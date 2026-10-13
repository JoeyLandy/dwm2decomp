SECTION "Bank 09", ROMX[$4000], BANK[$09]
    db $09

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank09::
    ld de, StringCategories_09_4016
    call BeginStringDisplay
    ret

; ld de, this bank's string table / CopyStringToBuffer
CopyStringToBuffer_Bank09::
    ld de, StringCategories_09_4016
    call CopyStringToBuffer
    ret

; BeginStringDisplay_Bank09 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank09::
    call BeginStringDisplay_Bank09
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_09_4016::
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

; category list of StringCategories_09_4016; one pointer per wStringIndex (E-0217)
; record: string
StringList_09_402A::
    dw String_09_00_00 ; id 0
    dw String_09_00_01 ; id 1
    dw String_09_00_02 ; id 2

StringList_09_4030::
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

StringList_09_4064::
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

StringList_09_4078::
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

StringList_09_410A::
    dw String_09_04_00 ; id 0

StringList_09_410C::
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

StringList_09_41B4::
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

StringList_09_41CE::
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

StringList_09_41EC::
    dw String_09_08_00 ; id 0

StringList_09_41EE::
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

String_09_00_00::
    db "WHATUsoePersoHPMPATKDEFAGLINTWLDnality", $f0

String_09_00_01::
    db "TOWHOHPMP", $f0

String_09_00_02::
    db "RJadlnoprtuxy-fWATUCHPMDcgimhw    Dcgimh       ", $ac, $f0

String_09_01_00::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $f2, "But it was empty.", $f7
    db $f0

String_09_01_01::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $f2, $f9, "0 obtained", $f1
    db $f9, $4e, "G.", $f7
    db $f0

String_09_01_02::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $f2, $f9, "0 obtained the", $f1
    db $f9, "Y.", $f7
    db $f0

String_09_01_03::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $f2, "Found ", $f9, "Y.", $f1
    db $fa, $f7
    db $f2, "But there is no", $f1
    db "room for it.", $f7
    db $f0

String_09_01_04::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $f2, "The chest was a", $f1
    db "Mimic!", $f7
    db $f0

String_09_01_05::
    db $f9, "0 obtained", $f1
    db $f9, $4e, "G.", $f7
    db $f0

String_09_01_06::
    db $f9, "0 obtained the", $f1
    db $f9, "Y.", $f7
    db $f0

String_09_01_07::
    db "Found ", $f9, "Y.", $f1
    db $fa, $f7
    db $f2, "But there is no", $f1
    db "room for it.", $f7
    db $f0

String_09_01_08::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $f2, $f9, "0 obtained a", $f1
    db "Magic Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_09_01_09::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $f2, "A Magic Key was", $f1
    db "found.", $fa, $f7
    db $f2, "But there is no", $f1
    db "room for it.", $f7
    db $f0

String_09_01_0A::
    db $f9, "N dropped", $f1
    db "dead.", $f7
    db $f0

String_09_01_0B::
    db $f2, $f9, "N dropped", $f1
    db "dead.", $f7
    db $f0

String_09_01_0C::
    db $ea, "Warubou: Wa-hey,", $f1
    db $f9, "0?", $fa, $f7
    db $ef, $ee, "Wiped out were", $ef, $ee, "you, warooh?", $fa, $f7
    db $ef, $ee, "GreatLog can't be", $ef, $ee, "saved if you're a", $fa, $f7
    db $ef, $ee, "waffling little", $ef, $ee, "wimp, warooh.", $fa, $f7
    db $ef, $ee, "I'm big-hearted,", $ef, $ee, "so I'll share some", $fa, $f7
    db $ef, $ee, "of GreatLog's power", $ef, $ee, "with you.", $f7
    db $f0

String_09_01_0D::
    db $ea, "Warubou: Wa-hey,", $f1
    db $f9, "0! You're safe!", $fa, $f7
    db $ef, $ee, "I'll share some of", $ef, $ee, "GreatLog's power.", $f7
    db $f0

String_09_01_0E::
    db "The two monsters", $f1
    db "went away quietly", $a4, $f7
    db $f0

String_09_01_0F::
    db "Repellent's effect", $f1
    db "wore off.", $f7
    db $f0

String_09_01_10::
    db "StepGuard's effect", $f1
    db "wore off.", $f7
    db $f0

String_09_01_11::
    db $ea, "Warubou: Wa-hey.", $f1
    db "There. All healed!", $fa, $f7
    db $ef, $ee, "You be careful,", $ef, $ee, "warooh!", $f7
    db $f0

String_09_01_12::
    db "ChangeStaff's", $f1
    db "effect wore off.", $f7
    db $f0

String_09_01_13::
    db $ea, "Warubou: Wa-hey,", $f1
    db $f9, "0, wiped out?", $fa, $f7
    db $ef, $ee, "That isn't good at", $ef, $ee, "all for a master!", $fa, $f7
    db $ef, $ee, "I'm big-hearted so", $ef, $ee, "I'll share some of", $fa, $f7
    db $ef, $ee, "GreatLog's power", $ef, $ee, "with you, warooh!", $f7
    db $f0

String_09_01_14::
    db $ea, "Petibou: Hey,", $f1
    db $f9, "0?", $fa, $f7
    db $ef, $ee, "Getting wiped out", $ef, $ee, "is wimpy!", $fa, $f7
    db $ef, $ee, "You're not much of", $ef, $ee, "a hero, are you?", $fa, $f7
    db $ef, $ee, "Peti's big-hearted,", $ef, $ee, "so I'll share some", $fa, $f7
    db $ef, $ee, "of GreatLog's power", $ef, $ee, "with you.", $f7
    db $f0

String_09_01_15::
    db $ea, "Petibou: Back,", $f1
    db $f9, "0?", $fa, $f7
    db $ef, $ee, "I'll share some of", $ef, $ee, "GreatLog's power.", $f7
    db $f0

String_09_01_16::
    db $ea, "Petibou: There.", $f1
    db "All healed now.", $fa, $f7
    db $ef, $ee, "You be careful out", $ef, $ee, "there!", $f7
    db $f0

String_09_01_17::
    db $f9, "X hatched.", $fa, $f7
    db $f1
    db "Please name it.", $ef, $ee, $f7
    db $f0

String_09_01_18::
    db $f9, "X", $a2, $f9, $4e, $f1
    db "hatched.", $fa, $f7
    db $ef, $ee, "Please name it.", $ef, $ee, $f7
    db $f0

String_09_01_19::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $f2, $f9, "0 obtained a", $f1
    db "DreamEgg.", $fa, $f7
    db $ef, $ee, "DreamEgg was sent", $ef, $ee, "to the farm.", $f7
    db $f0

String_09_02_00::
    db "FIGHTEMPLAN", $f0

String_09_02_01::
    db "ChargeMixedDefense      Command", $f0

String_09_02_02::
    db "FightSklGuard", $f0

String_09_02_03::
    db "TOWHAlyEnem", $f0

String_09_02_04::
    db "InfoOKMonsterEgg", $f0

String_09_02_06::
    db "Skill On", $9e, "Off Orb ID Odds", $f0

String_09_02_07::
    db "No Skil", $f0

String_09_02_08::
    db "Special Command", $f0

String_09_02_09::
    db "Betray", $f1
    db "Twin", $f1
    db "Guard", $f0

String_09_03_00::
    db $b8, $f0

String_09_03_01::
    db "Ylw", $f0

String_09_03_02::
    db "Plain", $f0

String_09_03_03::
    db "Green", $f0

String_09_03_04::
    db "Blue", $f0

String_09_03_05::
    db "First", $f0

String_09_03_06::
    db "Red", $f0

String_09_03_07::
    db "White", $f0

String_09_03_08::
    db "Quiet", $f0

String_09_03_09::
    db "Black", $f0

String_09_03_0A::
    db "Gaudy", $f0

String_09_03_0B::
    db "Silvr", $f0

String_09_03_0C::
    db "Dream", $f0

String_09_03_0D::
    db "Misty", $f0

String_09_03_0E::
    db "Secrt", $f0

String_09_03_0F::
    db "Shiny", $f0

String_09_03_10::
    db "Last", $f0

String_09_03_11::
    db "Slime", $f0

String_09_03_12::
    db "Draco", $f0

String_09_03_13::
    db "Beast", $f0

String_09_03_14::
    db "Bird", $f0

String_09_03_15::
    db "Tree", $f0

String_09_03_16::
    db "Bug", $f0

String_09_03_17::
    db "Devil", $f0

String_09_03_18::
    db "Death", $f0

String_09_03_19::
    db "Thing", $f0

String_09_03_1A::
    db "Water", $f0

String_09_03_1B::
    db "Lord", $f0

String_09_03_1C::
    db "Cave", $f0

String_09_03_1D::
    db "Isle", $f0

String_09_03_1E::
    db "Torch", $f0

String_09_03_1F::
    db "Gardn", $f0

String_09_03_20::
    db "Pit", $f0

String_09_03_21::
    db "Bsmt", $f0

String_09_03_22::
    db "Jail", $f0

String_09_03_23::
    db "Magma", $f0

String_09_03_24::
    db "Sea", $f0

String_09_03_25::
    db "Field", $f0

String_09_03_26::
    db "Tower", $f0

String_09_03_27::
    db "Mine", $f0

String_09_03_28::
    db "Hill", $f0

String_09_03_29::
    db "Cstle", $f0

String_09_03_2A::
    db "Mound", $f0

String_09_03_2B::
    db "Desrt", $f0

String_09_03_2C::
    db "Lake", $f0

String_09_03_2D::
    db "Jungl", $f0

String_09_03_2E::
    db "Haven", $f0

String_09_03_2F::
    db "Grass", $f0

String_09_03_30::
    db "Forst", $f0

String_09_03_31::
    db "Grave", $f0

String_09_03_32::
    db "Crag", $f0

String_09_03_33::
    db "Shore", $f0

String_09_03_34::
    db "Log", $f0

String_09_03_35::
    db "Sky", $f0

String_09_03_36::
    db "Mtn", $f0

String_09_03_37::
    db "View", $f0

String_09_03_38::
    db "Cliff", $f0

String_09_03_39::
    db "Islet", $f0

String_09_03_3A::
    db "Land", $f0

String_09_03_3B::
    db "Grove", $f0

String_09_03_3C::
    db "Swamp", $f0

String_09_03_3D::
    db "Manor", $f0

String_09_03_3E::
    db "Depth", $f0

String_09_03_3F::
    db "Hole", $f0

String_09_03_40::
    db "Tomb", $f0

String_09_03_41::
    db "Soil", $f0

String_09_03_42::
    db "Pond", $f0

String_09_03_43::
    db "Hell", $f0

String_09_03_44::
    db "Moon", $f0

String_09_03_45::
    db "Ocean", $f0

String_09_03_46::
    db "Gulch", $f0

String_09_03_47::
    db "River", $f0

String_09_03_48::
    db "Star", $f0

String_09_04_00::
    db $f0

String_09_05_00::
    db $ea, "*: Allow me to heal", $f1
    db "your injuries.", $f7
    db $f0

String_09_05_01::
    db $ea, "*: I will pray for", $f1
    db "you. Farewell.", $f7
    db $f0

String_09_05_02::
    db $ea, "*: ", $f9, "Y! Only", $f1
    db $f9, $4e, "G! Well?", $ff, $f0

String_09_05_03::
    db $ea, "*: Thanks! Hope I", $f1
    db "see you again!", $f7
    db $f0

String_09_05_04::
    db $ea, "*: Hah? Not buying?", $f1
    db "Bah, another time.", $f7
    db $f0

String_09_05_05::
    db $ea, "*: I'll heal you", $f1
    db "for 1000G. Well?", $ff, $f0

String_09_05_06::
    db $ea, "*: Hehehe, money is", $f1
    db "my motivation.", $fa, $f7
    db $ef, $ee, "Hope you'll give", $ef, $ee, "me some again!", $f7
    db $f0

String_09_05_07::
    db $ea, "*: Heh, I hope your", $f1
    db "luck holds, kid!", $fa, $f7
    db $ef, $ee, "Don't blame me if", $ef, $ee, "you don't make it.", $f7
    db $f0

String_09_05_08::
    db $ea, "*: ", $f9, "Y! Just", $f1
    db $f9, $4e, "G! Well?", $ff, $f0

String_09_05_09::
    db $ea, "*: Heheheh, thanks!", $f1
    db "See you again!", $f7
    db $f0

String_09_05_0A::
    db $ea, "*: Tch, tightwad", $a4, $f1
    db "You'll regret this.", $f7
    db $f0

String_09_05_0B::
    db $ea, "*: I'm a wandering", $f1
    db "master.", $fa, $f7
    db $ef, $ee, "I've been on the", $ef, $ee, "road for training.", $fa, $f7
    db $ef, $ee, "You look tough.", $ef, $ee, "Want to battle?", $ff, $f0

String_09_05_0C::
    db $ea, "*: Urgh. Tougher", $f1
    db "than me", $a4, $fa, $f7
    db $ef, $ee, "I", $44, " better redouble", $ef, $ee, "my training.", $f7
    db $f0

String_09_05_0D::
    db $f9, "0 obtained a", $f1
    db "WarpWing.", $f7
    db $f0

String_09_05_0E::
    db $ea, "*: Hahahah! I", $f1
    db "overestimated you!", $f7
    db $f0

String_09_05_0F::
    db $f9, "0 lost", $f1
    db $f9, $4e, "G.", $f7
    db $f0

String_09_05_10::
    db $eb, "*: I'm a traveling", $f1
    db "master.", $fa, $f7
    db $ef, $ee, "I'm training", $ef, $ee, "my monsters.", $fa, $f7
    db $ef, $ee, "You look strong.", $ef, $ee, "Will you battle?", $ff, $f0

String_09_05_11::
    db $eb, "*: Uh-oh, I lost!", $f1
    db "I can do better!", $f7
    db $f0

String_09_05_12::
    db $eb, "*: I'm sorry, but", $f1
    db "you didn't put up", $fa, $f7
    db $ef, $ee, "much resistance.", $ef, $ee, "I'm a little bored.", $f7
    db $f0

String_09_05_13::
    db $eb, "*: Hi! Want to try", $f1
    db "your luck?", $fa, $f7
    db $ef, $ee, $f9, "Y is the", $ef, $ee, "prize!", $fa, $f7
    db $ef, $ee, "Want to try?", $ef, $ee, "It's just 100G!", $ff, $f0

String_09_05_14::
    db $eb, "*: I'll pick a card", $f1
    db "between 1 and 13.", $fa, $f7
    db $ef, $ee, "Is the card I", $ef, $ee, "picked above 7?", $ff, $f0

String_09_05_15::
    db $eb, "*: I'll have nice", $f1
    db "prizes next time.", $f7
    db $f0

String_09_05_16::
    db $eb, "*: I picked", $a4, " ", $f9, $4e, "!", $f1
    db "Wow! You win!", $fa, $f7
    db $ef, $ee, "Next, ", $f9, "Y is", $ef, $ee, "the prize.", $fa, $f7
    db $ef, $ee, "Want to bet what", $ef, $ee, "you've won so far", $fa, $f7
    db $ef, $ee, "and ", $f9, $51, "G for a", $ef, $ee, "chance to win?", $ff, $f0

String_09_05_17::
    db $eb, "*: I picked", $a4, " ", $f9, $4e, "!", $f1
    db "Whoops, you lose.", $fa, $f7
    db $ef, $ee, "I'll take ", $f9, $51, "G", $ef, $ee, "and any prize.", $f7
    db $f0

String_09_05_18::
    db $eb, "*: I picked", $a4, " ", $f9, $4e, "!", $f1
    db "Oh, same number?", $fa, $f7
    db $ef, $ee, "Sorry, I win in", $ef, $ee, "this case.", $fa, $f7
    db $ef, $ee, "I'll take ", $f9, $51, "G", $ef, $ee, "and any prize.", $f7
    db $f0

String_09_05_19::
    db $eb, "*: Do you think the", $f1
    db "next card I pick", $fa, $f7
    db $ef, $ee, "will be above ", $f9, $4e, "?", $ef, $ee, $ff, $f0

String_09_05_1A::
    db $eb, "*: Awww, you won't", $f1
    db "play?", $fa, $f7
    db $ef, $ee, "Please come again", $ef, $ee, "and try your luck!", $f7
    db $f0

String_09_05_1B::
    db $f9, "0 obtained", $f1
    db "the ", $f9, "Y.", $f7
    db $f0

String_09_05_1C::
    db $eb, "*: I picked", $a4, " ", $f9, $4e, "!", $f1
    db "Wow! You win!", $fa, $f7
    db $ef, $ee, "That was the last", $ef, $ee, "prize!", $fa, $f7
    db $ef, $ee, "Please try again", $ef, $ee, "the next time!", $f7
    db $f0

String_09_05_1D::
    db $ea, "*: If you can beat", $f1
    db "me, I'll give you", $fa, $f7
    db $ef, $ee, "something good.", $ef, $ee, "Want to battle?", $ff, $f0

String_09_05_1E::
    db $ea, "*: Very good. Here's", $f1
    db "your reward.", $f7
    db $f0

String_09_05_1F::
    db $ea, "*: Well, that was", $f1
    db "unseemly.", $fa, $f7
    db $ef, $ee, "You shouldn't shirk", $ef, $ee, "from training.", $f7
    db $f0

String_09_05_20::
    db $f9, "0 lost", $f1
    db $f9, $4e, "G.", $f7
    db $f0

String_09_05_21::
    db $ea, "Do you want a map?", $f1
    db "Just 200G.", $ff, $f0

String_09_05_22::
    db $ea, "*: No?", $f1
    db "That's too bad.", $f7
    db $f0

String_09_05_23::
    db $ea, $f9, "0 handed over", $f1
    db "200G.", $f7
    db $f0

String_09_05_24::
    db $ea, "*: I'll give you", $f1
    db "special medicine", $fa, $f7
    db $ef, $ee, "if you manage to", $ef, $ee, "defeat me.", $fa, $f7
    db $ef, $ee, "Would you like to", $ef, $ee, "challenge me?", $ff, $f0

String_09_05_25::
    db $ea, "*: You've won.", $f1
    db "As promised, let", $fa, $f7
    db $ef, $ee, "me give you some", $ef, $ee, "of my medicine.", $f7
    db $f0

String_09_05_26::
    db $f9, "N's ", $f9, "Y", $f1
    db "rose by ", $f9, $4e, ".", $f7
    db $f0

String_09_05_27::
    db $f0

String_09_05_28::
    db $11, $19, $f0

String_09_05_29::
    db $16, $19, $f0

String_09_05_2A::
    db "ATK", $f0

String_09_05_2B::
    db "DEF", $f0

String_09_05_2C::
    db "AGL", $f0

String_09_05_2D::
    db "INT", $f0

String_09_05_2E::
    db $ea, "*: Welcome aboard", $f1
    db "the casino ship!", $fa, $f7
    db $ef, $ee, "Have a spin on the", $ef, $ee, "slots for 100G!", $fa, $f7
    db $ef, $ee, "There are prizes", $ef, $ee, "too. Try it out?", $ff, $f0

String_09_05_2F::
    db $ea, "*: Stop the reels", $f1
    db "with the A Button.", $fa, $f7
    db $ef, $ee, "Depending on what", $ef, $ee, "marks you line up,", $fa, $f7
    db $ef, $ee, "the prizes will", $ef, $ee, "vary. Ready?", $f7
    db $f0

String_09_05_30::
    db $ea, "*: Lucky! You win a", $f1
    db "TinyMedal!", $f7
    db $f0

String_09_05_31::
    db $ea, "*: There it is!", $f1
    db "You win 1000G!", $f7
    db $f0

String_09_05_32::
    db $ea, "*: Whoa! You've won", $f1
    db "a MeteOrb!", $f7
    db $f0

String_09_05_33::
    db $ea, "*: Whoa", $a4, " Are you", $f1
    db "kidding me?", $fa, $f7
    db $ef, $ee, "You've won some", $ef, $ee, "secret medicine.", $f7
    db $f0

String_09_05_34::
    db $ea, "*: Are you serious?", $f1
    db "I don't believe it.", $fa, $f7
    db $ef, $ee, "You've won some", $ef, $ee, "secret medicine.", $f7
    db $f0

String_09_05_35::
    db $ea, "*: Too bad", $a4, $f1
    db "Try again, OK?", $f7
    db $f0

String_09_05_36::
    db $ea, "*: That's too bad.", $f1
    db "See you again.", $f7
    db $f0

String_09_05_37::
    db $ea, "*: I will heal your", $f1
    db "injuries for you", $a4, $fa, $f7
    db $ef, $ee, "If you can defeat", $ef, $ee, "me, that is. Well?", $ff, $f0

String_09_05_38::
    db $ea, "*: Fine, fine,", $f1
    db "I surrender.", $fa, $f7
    db $ef, $ee, "I'll heal your", $ef, $ee, "party as promised.", $f7
    db $f0

String_09_05_39::
    db $ea, "*: Your lack of", $f1
    db "training is clear.", $fa, $f7
    db $ef, $ee, "Best of luck to", $ef, $ee, "you", $a4, $f7
    db $f0

String_09_05_3A::
    db $ea, "*: Let me lighten", $f1
    db "your purse.", $f7
    db $f0

String_09_05_3B::
    db $ea, "*: I see an injured", $f1
    db "monster", $a4, $fa, $f7
    db $ef, $ee, "Heh, I think I can", $ef, $ee, "win this one.", $f7
    db $f0

String_09_05_3C::
    db $ea, "*: Oh, at least one", $f1
    db "monster tired?", $fa, $f7
    db $ef, $ee, "This works out", $ef, $ee, "perfectly for me.", $f7
    db $f0

String_09_05_3D::
    db $ea, "*: Heh, those are", $f1
    db "some weaklings!", $fa, $f7
    db $ef, $ee, "That makes things", $ef, $ee, "easy for me.", $f7
    db $f0

String_09_05_3E::
    db "The fugitive", $f1
    db "master was", $fa, $f7
    db $ef, $ee, "captured and sent", $ef, $ee, "back to GreatLog.", $f7
    db $f0

String_09_05_3F::
    db $ea, "*: I'll unburden", $f1
    db "you of your gold.", $f7
    db $f0

String_09_05_40::
    db $ea, "*: I'm not dirty-", $f1
    db "not at all.", $fa, $f7
    db $ef, $ee, "You shouldn't be", $ef, $ee, "so careless.", $f7
    db $f0

String_09_05_41::
    db $ea, "*: You'll need more", $f1
    db "experience to", $fa, $f7
    db $ef, $ee, "catch me, much", $ef, $ee, "more, hahahah!", $f7
    db $f0

String_09_05_42::
    db $ea, "*: Heheheh, your", $f1
    db "looks don't lie!", $fa, $f7
    db $ef, $ee, "That'll teach you", $ef, $ee, "to stay away!", $f7
    db $f0

String_09_05_43::
    db $f9, "0 received a", $f1
    db "Magic Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_09_05_44::
    db $ea, "*: Lucky, kid!", $f1
    db "You've won 500G!", $f7
    db $f0

String_09_05_45::
    db $ea, "*: Lucky, kid!", $f1
    db "You've won 200G!", $f7
    db $f0

String_09_05_46::
    db $ea, "*: Lucky, kid!", $f1
    db "You've won 100G!", $f7
    db $f0

String_09_05_47::
    db $ea, "*: Lucky, kid!", $f1
    db "You've won 50G!", $f7
    db $f0

String_09_05_48::
    db $ea, "*: You've no courage", $f1
    db "to battle?", $fa, $f7
    db $ef, $ee, "Shame, it really", $ef, $ee, "is.", $f7
    db $f0

String_09_05_49::
    db $ea, "*: I take being a", $f1
    db "master seriously.", $fa, $f7
    db $ef, $ee, "I won't hold back", $ef, $ee, "from anything!", $f7
    db $f0

String_09_05_4A::
    db $ea, "*: No? You're rather", $f1
    db "cowardly.", $f7
    db $f0

String_09_05_4B::
    db $ea, "*: Ah, the sparkle", $f1
    db "in your eyes", $a4, $fa, $f7
    db $ef, $ee, "I", $44, " best not", $ef, $ee, "disappoint you!", $f7
    db $f0

String_09_05_4C::
    db $ea, "*: What?", $f1
    db "Little chicken!", $fa, $f7
    db $ef, $ee, "Go home to your", $ef, $ee, "mommy, baby!", $f7
    db $f0

String_09_05_4D::
    db $ea, "*: Good answer!", $f1
    db "Let's battle!", $f7
    db $f0

String_09_05_4E::
    db $eb, "*: Oh, you poor", $f1
    db "monsters.", $fa, $f7
    db $ef, $ee, "You have such a", $ef, $ee, "poor master", $a4, $f7
    db $f0

String_09_05_4F::
    db $eb, "*: Oh, you're ready,", $f1
    db "are you?", $fa, $f7
    db $ef, $ee, "But I don't plan", $ef, $ee, "on losing!", $f7
    db $f0

String_09_05_50::
    db $ea, "*: I thought you", $f1
    db "were dedicated", $a4, $fa, $f7
    db $ef, $ee, "But my eyes must", $ef, $ee, "have been misled.", $f7
    db $f0

String_09_05_51::
    db $ea, "*: My eyes didn't", $f1
    db "mislead me. Ready?", $f7
    db $f0

String_09_05_52::
    db $ea, "*: Now you can see", $f1
    db "the entire world!", $f7
    db $f0

String_09_05_53::
    db $ea, "*: I hope you'll", $f1
    db "put up more of a", $fa, $f7
    db $ef, $ee, "fight next time", $ef, $ee, "than this", $a4, $f7
    db $f0

String_09_06_00::
    db $f0

String_09_06_01::
    db "GreatLog", $5b, $f0

String_09_06_02::
    db "Oasis", $5b, $f0

String_09_06_03::
    db "Pirate", $5b, $f0

String_09_06_04::
    db "Ice", $5b, $f0

String_09_06_05::
    db "Sky", $5b, $f0

String_09_06_06::
    db "Limbo", $5b, $f0

String_09_06_07::
    db "Elf", $5b, $f0

String_09_06_08::
    db "Lonely", $5b, $f0

String_09_06_09::
    db "Traveler", $5b, $f0

String_09_06_0A::
    db "Brawn", $5b, $f0

String_09_06_0B::
    db "Baffle", $5b, $f0

String_09_06_0C::
    db "Soul", $5b, $f0

String_09_07_00::
    db $f1, $f1, $f0

String_09_07_01::
    db "Key to", $f1
    db "return", $f1
    db "home.", $f0

String_09_07_02::
    db "Key to", $f1
    db "Desert", $f1
    db "World.", $f0

String_09_07_03::
    db "Key to", $f1
    db "Sea", $f1
    db "World.", $f0

String_09_07_04::
    db "Key to", $f1
    db "Ice", $f1
    db "World.", $f0

String_09_07_05::
    db "Key to", $f1
    db "Sky", $f1
    db "World.", $f0

String_09_07_06::
    db "Key to", $f1
    db "Limbo.", $f1
    db $f0

String_09_07_07::
    db "Key to", $f1
    db "Elf", $f1
    db "World.", $f0

String_09_07_08::
    db "Key to", $f1
    db "Lonely", $f1
    db "World.", $f0

String_09_07_09::
    db "Key to", $f1
    db "Travel", $f1
    db "World.", $f0

String_09_07_0A::
    db "Key to", $f1
    db "Power", $f1
    db "World.", $f0

String_09_07_0B::
    db "Key to", $f1
    db "Baffle", $f1
    db "World.", $f0

String_09_07_0C::
    db "Key to", $f1
    db "Soul", $f1
    db "World.", $f0

String_09_07_0D::
    db "Magic", $f1
    db "Key to", $f1
    db "where?", $f0

String_09_07_0E::
    db "Key to", $f1
    db $f9, "0.", $f1
    db $f0

String_09_08_00::
    db "New gameContinueVS battleBreedTrade ", $b8, "Journal datalost", $a4, $f0

String_09_09_00::
    db $ea, "*: Welcome to the", $f1
    db "Arena!", $fa, $f7
    db $ef, $ee, "We have a special", $ef, $ee, "team with us!", $f7
    db $f0

String_09_09_01::
    db $ea, "*: Welcome to the", $f1
    db "Arena!", $fa, $f7
    db $ef, $ee, "For today's C", $ef, $ee, "Class Challenge,", $fa, $f7
    db $ef, $ee, "we have a little", $ef, $ee, "challenger!", $f7
    db $f0

String_09_09_02::
    db $ea, "*: Welcome to the", $f1
    db "Arena!", $fa, $f7
    db $ef, $ee, "For today's B", $ef, $ee, "Class Tournament,", $fa, $f7
    db $ef, $ee, "we have a brave,", $ef, $ee, "new challenger!", $f7
    db $f0

String_09_09_03::
    db $ea, "*: Welcome to the", $f1
    db "Arena!", $fa, $f7
    db $ef, $ee, "For today's A", $ef, $ee, "Class Tournament,", $fa, $f7
    db $ef, $ee, "we have a hot, new", $ef, $ee, "challenger!", $f7
    db $f0

String_09_09_04::
    db $ea, "*: Ladies and", $f1
    db "gentlemen!", $fa, $f7
    db $ef, $ee, "For today's S", $ef, $ee, "Class Tournament,", $fa, $f7
    db $ef, $ee, "we have a brand", $ef, $ee, "new hero!", $f7
    db $f0

String_09_09_05::
    db $ea, "*: E Class battles", $f1
    db "are ready to go!", $f7
    db $f0

String_09_09_06::
    db $ea, "*: D Class battles", $f1
    db "are ready to go!", $f7
    db $f0

String_09_09_07::
    db $ea, "*: C Class battles", $f1
    db "are ready to go!", $f7
    db $f0

String_09_09_08::
    db $ea, "*: B Class battles", $f1
    db "are ready to go!", $f7
    db $f0

String_09_09_09::
    db $ea, "*: A Class battles", $f1
    db "are ready to go!", $f7
    db $f0

String_09_09_0A::
    db $ea, "*: S Class battles", $f1
    db "are ready to go!", $f7
    db $f0

String_09_09_0B::
    db $ea, "*: Ladies and", $f1
    db "gentlemen!", $fa, $f7
    db $ef, $ee, "Get ready for a", $ef, $ee, "Special Match!", $fa, $f7
    db $ef, $ee, "Master ", $f9, "0", $ef, $ee, "will take on", $a4, $f7
    db $f0

String_09_09_0C::
    db $ea, "*: Master ", $f9, "0 and", $f1
    db "the farm friends!", $f7
    db $f0

String_09_09_0D::
    db $ea, "*: Master ", $f9, "0 and", $f1
    db "the fun friends!", $f7
    db $f0

String_09_09_0E::
    db $ea, "*: Master ", $f9, "0 and", $f1
    db "trusty friends!", $f7
    db $f0

String_09_09_0F::
    db $ea, "*: Master ", $f9, "0 and", $f1
    db "powerful friends!", $f7
    db $f0

String_09_09_10::
    db $ea, "*: Master ", $f9, "0 and", $f1
    db "brave friends!", $f7
    db $f0

String_09_09_11::
    db $ea, "*: This next battle", $f1
    db "will feature the", $fa, $f7
    db $ef, $ee, "up-and-coming", $ef, $ee, "monster master", $a4, $fa, $f7
    db $ef, $ee, "Master ", $f9, "0 and", $ef, $ee, "the farm friends!", $f7
    db $f0

String_09_09_12::
    db $ea, "*: ????????? and", $f1
    db "????? friends!", $f7
    db $f0

String_09_09_13::
    db $ea, "*: Battle one!", $f1
    db "Ready? Go!", $f7
    db $f0

String_09_09_14::
    db $ea, "*: Battle two!", $f1
    db "Ready? Go!", $f7
    db $f0

String_09_09_15::
    db $ea, "*: This decides the", $f1
    db "champion!", $fa, $f7
    db $ef, $ee, "Final battle!", $ef, $ee, "Ready? Go!", $f7
    db $f0

String_09_09_16::
    db $ea, "*: This is it! The", $f1
    db "deciding battle!", $fa, $f7
    db $ef, $ee, "Are you ready?", $ef, $ee, "Let's go!", $f7
    db $f0

String_09_09_17::
    db $ea, "*: The challenger", $f1
    db "wins battle one!", $f7
    db $f0

String_09_09_18::
    db $ea, "*: That's amazing!", $f1
    db "Is this true?", $fa, $f7
    db $ef, $ee, "The challenger", $ef, $ee, "wins battle two!", $f7
    db $f0

String_09_09_19::
    db $ea, "*: Master ", $f9, "0 has", $f1
    db "won battle one!", $f7
    db $f0

String_09_09_1A::
    db $ea, "*: Master ", $f9, "0 has", $f1
    db "won battle two!", $f7
    db $f0

String_09_09_1B::
    db $ea, "*: Incredible!", $f1
    db "The winners are", $fa, $f7
    db $ef, $ee, "Master ", $f9, "0 and", $ef, $ee, "the fun friends!", $e5, $48, $fa, $f7
    db $e9, $ff, $ef, $ee, "What an impressive", $ef, $ee, "debut!", $f7
    db $f0

String_09_09_1C::
    db $ea, "*: The C Class", $f1
    db "champion party is", $fa, $f7
    db $ef, $ee, "Master ", $f9, "0 and", $ef, $ee, "the fun friends!", $e5, $4a, $fa, $f7
    db $e9, $ff, $ef, $ee, "Let's hear it for", $ef, $ee, "the champion!", $f7
    db $f0

String_09_09_1D::
    db $ea, "*: The B Class", $f1
    db "champion party is", $fa, $f7
    db $ef, $ee, "Master ", $f9, "0 and", $ef, $ee, "trusty friends!", $e5, $4a, $fa, $f7
    db $e9, $ff, $ef, $ee, "Let's hear it for", $ef, $ee, "the champion!", $f7
    db $f0

String_09_09_1E::
    db $ea, "*: The A Class", $f1
    db "champion party is", $fa, $f7
    db $ef, $ee, "Master ", $f9, "0 and", $ef, $ee, "powerful friends!", $e5, $4a, $fa, $f7
    db $e9, $ff, $ef, $ee, "Let's have a huge", $ef, $ee, "hand for them!", $f7
    db $f0

String_09_09_1F::
    db $ea, "*: The S Class", $f1
    db "champion party is", $fa, $f7
    db $ef, $ee, "Master ", $f9, "0 and", $ef, $ee, "brave friends!", $e5, $4d, $fa, $f7
    db $e9, $ff, $ef, $ee, "Let's hear it for", $ef, $ee, "the new hero!", $f7
    db $f0

String_09_09_20::
    db $ea, "*: This match's", $f1
    db "winners are", $fa, $f7
    db $ef, $ee, "Master ", $f9, "0 and", $ef, $ee, "the farm friends!", $fa, $f7
    db $ef, $ee, "Let's hear it for", $ef, $ee, "the winning party!", $f7
    db $f0

String_09_09_21::
    db $ea, "*: The Special", $f1
    db "Match winners are", $fa, $f7
    db $ef, $ee, "Master ", $f9, "0 and", $ef, $ee, "the farm friends!", $fa, $f7
    db $ef, $ee, "Let's hear it for", $ef, $ee, "the winning party!", $f7
    db $f0
    ds $1a86, $00
