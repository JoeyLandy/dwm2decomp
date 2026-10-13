; ROM bank $09: string tables
; The annotated listing of this bank is build/listing/bank09.asm.

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
    db "WHATUsoePersoHPMPATKDEFAGLINTWLDnality@"

String_09_00_01::
    db "TOWHOHPMP@"

String_09_00_02::
    db "RJadlnoprtuxy-fWATUCHPMDcgimhw    Dcgimh       ★@"

String_09_01_00::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<CLEAR>But it was empty.<WAIT>"
    db "@"

String_09_01_01::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<CLEAR><BUF0> obtained<LINE>"
    db "<BUF>", $4e, "G.<WAIT>"
    db "@"

String_09_01_02::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<CLEAR><BUF0> obtained the<LINE>"
    db "<BUF>", $22, ".<WAIT>"
    db "@"

String_09_01_03::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<CLEAR>Found <BUF>", $22, ".<LINE>"
    db "<PROMPT>"
    db "<CLEAR>But there is no<LINE>"
    db "room for it.<WAIT>"
    db "@"

String_09_01_04::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<CLEAR>The chest was a<LINE>"
    db "Mimic!<WAIT>"
    db "@"

String_09_01_05::
    db "<BUF0> obtained<LINE>"
    db "<BUF>", $4e, "G.<WAIT>"
    db "@"

String_09_01_06::
    db "<BUF0> obtained the<LINE>"
    db "<BUF>", $22, ".<WAIT>"
    db "@"

String_09_01_07::
    db "Found <BUF>", $22, ".<LINE>"
    db "<PROMPT>"
    db "<CLEAR>But there is no<LINE>"
    db "room for it.<WAIT>"
    db "@"

String_09_01_08::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<CLEAR><BUF0> obtained a<LINE>"
    db "Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_09_01_09::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<CLEAR>A Magic Key was<LINE>"
    db "found.<PROMPT>"
    db "<CLEAR>But there is no<LINE>"
    db "room for it.<WAIT>"
    db "@"

String_09_01_0A::
    db "<BUF>", $17, " dropped<LINE>"
    db "dead.<WAIT>"
    db "@"

String_09_01_0B::
    db "<CLEAR><BUF>", $17, " dropped<LINE>"
    db "dead.<WAIT>"
    db "@"

String_09_01_0C::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "<BUF0>?<PROMPT>"
    db "<NEXT>Wiped out were"
    db "<NEXT>you, warooh?<PROMPT>"
    db "<NEXT>GreatLog can't be"
    db "<NEXT>saved if you're a<PROMPT>"
    db "<NEXT>waffling little"
    db "<NEXT>wimp, warooh.<PROMPT>"
    db "<NEXT>I'm big-hearted,"
    db "<NEXT>so I'll share some<PROMPT>"
    db "<NEXT>of GreatLog's power"
    db "<NEXT>with you.<WAIT>"
    db "@"

String_09_01_0D::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "<BUF0>! You're safe!<PROMPT>"
    db "<NEXT>I'll share some of"
    db "<NEXT>GreatLog's power.<WAIT>"
    db "@"

String_09_01_0E::
    db "The two monsters<LINE>"
    db "went away quietly…<WAIT>"
    db "@"

String_09_01_0F::
    db "Repellent's effect<LINE>"
    db "wore off.<WAIT>"
    db "@"

String_09_01_10::
    db "StepGuard's effect<LINE>"
    db "wore off.<WAIT>"
    db "@"

String_09_01_11::
    db "<VOICE1>Warubou: Wa-hey.<LINE>"
    db "There. All healed!<PROMPT>"
    db "<NEXT>You be careful,"
    db "<NEXT>warooh!<WAIT>"
    db "@"

String_09_01_12::
    db "ChangeStaff's<LINE>"
    db "effect wore off.<WAIT>"
    db "@"

String_09_01_13::
    db "<VOICE1>Warubou: Wa-hey,<LINE>"
    db "<BUF0>, wiped out?<PROMPT>"
    db "<NEXT>That isn't good at"
    db "<NEXT>all for a master!<PROMPT>"
    db "<NEXT>I'm big-hearted so"
    db "<NEXT>I'll share some of<PROMPT>"
    db "<NEXT>GreatLog's power"
    db "<NEXT>with you, warooh!<WAIT>"
    db "@"

String_09_01_14::
    db "<VOICE1>Petibou: Hey,<LINE>"
    db "<BUF0>?<PROMPT>"
    db "<NEXT>Getting wiped out"
    db "<NEXT>is wimpy!<PROMPT>"
    db "<NEXT>You're not much of"
    db "<NEXT>a hero, are you?<PROMPT>"
    db "<NEXT>Peti's big-hearted,"
    db "<NEXT>so I'll share some<PROMPT>"
    db "<NEXT>of GreatLog's power"
    db "<NEXT>with you.<WAIT>"
    db "@"

String_09_01_15::
    db "<VOICE1>Petibou: Back,<LINE>"
    db "<BUF0>?<PROMPT>"
    db "<NEXT>I'll share some of"
    db "<NEXT>GreatLog's power.<WAIT>"
    db "@"

String_09_01_16::
    db "<VOICE1>Petibou: There.<LINE>"
    db "All healed now.<PROMPT>"
    db "<NEXT>You be careful out"
    db "<NEXT>there!<WAIT>"
    db "@"

String_09_01_17::
    db "<BUF>", $21, " hatched.<PROMPT>"
    db "<LINE>"
    db "Please name it."
    db "<NEXT><WAIT>"
    db "@"

String_09_01_18::
    db "<BUF>", $21, "+<BUF>", $4e, "<LINE>"
    db "hatched.<PROMPT>"
    db "<NEXT>Please name it."
    db "<NEXT><WAIT>"
    db "@"

String_09_01_19::
    db "<BUF0> checked the<LINE>"
    db "treasure chest.<PROMPT>"
    db "<CLEAR><BUF0> obtained a<LINE>"
    db "DreamEgg.<PROMPT>"
    db "<NEXT>DreamEgg was sent"
    db "<NEXT>to the farm.<WAIT>"
    db "@"

String_09_02_00::
    db "FIGHTEMPLAN@"

String_09_02_01::
    db "ChargeMixedDefense      Command@"

String_09_02_02::
    db "FightSklGuard@"

String_09_02_03::
    db "TOWHAlyEnem@"

String_09_02_04::
    db "InfoOKMonsterEgg@"

String_09_02_06::
    db "Skill On/Off Orb ID Odds@"

String_09_02_07::
    db "No Skil@"

String_09_02_08::
    db "Special Command@"

String_09_02_09::
    db "Betray<LINE>"
    db "Twin<LINE>"
    db "Guard@"

String_09_03_00::
    db $b8, $f0

String_09_03_01::
    db "Ylw@"

String_09_03_02::
    db "Plain@"

String_09_03_03::
    db "Green@"

String_09_03_04::
    db "Blue@"

String_09_03_05::
    db "First@"

String_09_03_06::
    db "Red@"

String_09_03_07::
    db "White@"

String_09_03_08::
    db "Quiet@"

String_09_03_09::
    db "Black@"

String_09_03_0A::
    db "Gaudy@"

String_09_03_0B::
    db "Silvr@"

String_09_03_0C::
    db "Dream@"

String_09_03_0D::
    db "Misty@"

String_09_03_0E::
    db "Secrt@"

String_09_03_0F::
    db "Shiny@"

String_09_03_10::
    db "Last@"

String_09_03_11::
    db "Slime@"

String_09_03_12::
    db "Draco@"

String_09_03_13::
    db "Beast@"

String_09_03_14::
    db "Bird@"

String_09_03_15::
    db "Tree@"

String_09_03_16::
    db "Bug@"

String_09_03_17::
    db "Devil@"

String_09_03_18::
    db "Death@"

String_09_03_19::
    db "Thing@"

String_09_03_1A::
    db "Water@"

String_09_03_1B::
    db "Lord@"

String_09_03_1C::
    db "Cave@"

String_09_03_1D::
    db "Isle@"

String_09_03_1E::
    db "Torch@"

String_09_03_1F::
    db "Gardn@"

String_09_03_20::
    db "Pit@"

String_09_03_21::
    db "Bsmt@"

String_09_03_22::
    db "Jail@"

String_09_03_23::
    db "Magma@"

String_09_03_24::
    db "Sea@"

String_09_03_25::
    db "Field@"

String_09_03_26::
    db "Tower@"

String_09_03_27::
    db "Mine@"

String_09_03_28::
    db "Hill@"

String_09_03_29::
    db "Cstle@"

String_09_03_2A::
    db "Mound@"

String_09_03_2B::
    db "Desrt@"

String_09_03_2C::
    db "Lake@"

String_09_03_2D::
    db "Jungl@"

String_09_03_2E::
    db "Haven@"

String_09_03_2F::
    db "Grass@"

String_09_03_30::
    db "Forst@"

String_09_03_31::
    db "Grave@"

String_09_03_32::
    db "Crag@"

String_09_03_33::
    db "Shore@"

String_09_03_34::
    db "Log@"

String_09_03_35::
    db "Sky@"

String_09_03_36::
    db "Mtn@"

String_09_03_37::
    db "View@"

String_09_03_38::
    db "Cliff@"

String_09_03_39::
    db "Islet@"

String_09_03_3A::
    db "Land@"

String_09_03_3B::
    db "Grove@"

String_09_03_3C::
    db "Swamp@"

String_09_03_3D::
    db "Manor@"

String_09_03_3E::
    db "Depth@"

String_09_03_3F::
    db "Hole@"

String_09_03_40::
    db "Tomb@"

String_09_03_41::
    db "Soil@"

String_09_03_42::
    db "Pond@"

String_09_03_43::
    db "Hell@"

String_09_03_44::
    db "Moon@"

String_09_03_45::
    db "Ocean@"

String_09_03_46::
    db "Gulch@"

String_09_03_47::
    db "River@"

String_09_03_48::
    db "Star@"

String_09_04_00::
    db $f0

String_09_05_00::
    db "<VOICE1>*: Allow me to heal<LINE>"
    db "your injuries.<WAIT>"
    db "@"

String_09_05_01::
    db "<VOICE1>*: I will pray for<LINE>"
    db "you. Farewell.<WAIT>"
    db "@"

String_09_05_02::
    db "<VOICE1>*: <BUF>", $22, "! Only<LINE>"
    db "<BUF>", $4e, "G! Well?<CHOICE>"
    db "@"

String_09_05_03::
    db "<VOICE1>*: Thanks! Hope I<LINE>"
    db "see you again!<WAIT>"
    db "@"

String_09_05_04::
    db "<VOICE1>*: Hah? Not buying?<LINE>"
    db "Bah, another time.<WAIT>"
    db "@"

String_09_05_05::
    db "<VOICE1>*: I'll heal you<LINE>"
    db "for 1000G. Well?<CHOICE>"
    db "@"

String_09_05_06::
    db "<VOICE1>*: Hehehe, money is<LINE>"
    db "my motivation.<PROMPT>"
    db "<NEXT>Hope you'll give"
    db "<NEXT>me some again!<WAIT>"
    db "@"

String_09_05_07::
    db "<VOICE1>*: Heh, I hope your<LINE>"
    db "luck holds, kid!<PROMPT>"
    db "<NEXT>Don't blame me if"
    db "<NEXT>you don't make it.<WAIT>"
    db "@"

String_09_05_08::
    db "<VOICE1>*: <BUF>", $22, "! Just<LINE>"
    db "<BUF>", $4e, "G! Well?<CHOICE>"
    db "@"

String_09_05_09::
    db "<VOICE1>*: Heheheh, thanks!<LINE>"
    db "See you again!<WAIT>"
    db "@"

String_09_05_0A::
    db "<VOICE1>*: Tch, tightwad…<LINE>"
    db "You'll regret this.<WAIT>"
    db "@"

String_09_05_0B::
    db "<VOICE1>*: I'm a wandering<LINE>"
    db "master.<PROMPT>"
    db "<NEXT>I've been on the"
    db "<NEXT>road for training.<PROMPT>"
    db "<NEXT>You look tough."
    db "<NEXT>Want to battle?<CHOICE>"
    db "@"

String_09_05_0C::
    db "<VOICE1>*: Urgh. Tougher<LINE>"
    db "than me…<PROMPT>"
    db "<NEXT>I", $44, " better redouble"
    db "<NEXT>my training.<WAIT>"
    db "@"

String_09_05_0D::
    db "<BUF0> obtained a<LINE>"
    db "WarpWing.<WAIT>"
    db "@"

String_09_05_0E::
    db "<VOICE1>*: Hahahah! I<LINE>"
    db "overestimated you!<WAIT>"
    db "@"

String_09_05_0F::
    db "<BUF0> lost<LINE>"
    db "<BUF>", $4e, "G.<WAIT>"
    db "@"

String_09_05_10::
    db "<VOICE2>*: I'm a traveling<LINE>"
    db "master.<PROMPT>"
    db "<NEXT>I'm training"
    db "<NEXT>my monsters.<PROMPT>"
    db "<NEXT>You look strong."
    db "<NEXT>Will you battle?<CHOICE>"
    db "@"

String_09_05_11::
    db "<VOICE2>*: Uh-oh, I lost!<LINE>"
    db "I can do better!<WAIT>"
    db "@"

String_09_05_12::
    db "<VOICE2>*: I'm sorry, but<LINE>"
    db "you didn't put up<PROMPT>"
    db "<NEXT>much resistance."
    db "<NEXT>I'm a little bored.<WAIT>"
    db "@"

String_09_05_13::
    db "<VOICE2>*: Hi! Want to try<LINE>"
    db "your luck?<PROMPT>"
    db "<NEXT><BUF>", $22, " is the"
    db "<NEXT>prize!<PROMPT>"
    db "<NEXT>Want to try?"
    db "<NEXT>It's just 100G!<CHOICE>"
    db "@"

String_09_05_14::
    db "<VOICE2>*: I'll pick a card<LINE>"
    db "between 1 and 13.<PROMPT>"
    db "<NEXT>Is the card I"
    db "<NEXT>picked above 7?<CHOICE>"
    db "@"

String_09_05_15::
    db "<VOICE2>*: I'll have nice<LINE>"
    db "prizes next time.<WAIT>"
    db "@"

String_09_05_16::
    db "<VOICE2>*: I picked… <BUF>", $4e, "!<LINE>"
    db "Wow! You win!<PROMPT>"
    db "<NEXT>Next, <BUF>", $22, " is"
    db "<NEXT>the prize.<PROMPT>"
    db "<NEXT>Want to bet what"
    db "<NEXT>you've won so far<PROMPT>"
    db "<NEXT>and <BUF>", $51, "G for a"
    db "<NEXT>chance to win?<CHOICE>"
    db "@"

String_09_05_17::
    db "<VOICE2>*: I picked… <BUF>", $4e, "!<LINE>"
    db "Whoops, you lose.<PROMPT>"
    db "<NEXT>I'll take <BUF>", $51, "G"
    db "<NEXT>and any prize.<WAIT>"
    db "@"

String_09_05_18::
    db "<VOICE2>*: I picked… <BUF>", $4e, "!<LINE>"
    db "Oh, same number?<PROMPT>"
    db "<NEXT>Sorry, I win in"
    db "<NEXT>this case.<PROMPT>"
    db "<NEXT>I'll take <BUF>", $51, "G"
    db "<NEXT>and any prize.<WAIT>"
    db "@"

String_09_05_19::
    db "<VOICE2>*: Do you think the<LINE>"
    db "next card I pick<PROMPT>"
    db "<NEXT>will be above <BUF>", $4e, "?"
    db "<NEXT><CHOICE>"
    db "@"

String_09_05_1A::
    db "<VOICE2>*: Awww, you won't<LINE>"
    db "play?<PROMPT>"
    db "<NEXT>Please come again"
    db "<NEXT>and try your luck!<WAIT>"
    db "@"

String_09_05_1B::
    db "<BUF0> obtained<LINE>"
    db "the <BUF>", $22, ".<WAIT>"
    db "@"

String_09_05_1C::
    db "<VOICE2>*: I picked… <BUF>", $4e, "!<LINE>"
    db "Wow! You win!<PROMPT>"
    db "<NEXT>That was the last"
    db "<NEXT>prize!<PROMPT>"
    db "<NEXT>Please try again"
    db "<NEXT>the next time!<WAIT>"
    db "@"

String_09_05_1D::
    db "<VOICE1>*: If you can beat<LINE>"
    db "me, I'll give you<PROMPT>"
    db "<NEXT>something good."
    db "<NEXT>Want to battle?<CHOICE>"
    db "@"

String_09_05_1E::
    db "<VOICE1>*: Very good. Here's<LINE>"
    db "your reward.<WAIT>"
    db "@"

String_09_05_1F::
    db "<VOICE1>*: Well, that was<LINE>"
    db "unseemly.<PROMPT>"
    db "<NEXT>You shouldn't shirk"
    db "<NEXT>from training.<WAIT>"
    db "@"

String_09_05_20::
    db "<BUF0> lost<LINE>"
    db "<BUF>", $4e, "G.<WAIT>"
    db "@"

String_09_05_21::
    db "<VOICE1>Do you want a map?<LINE>"
    db "Just 200G.<CHOICE>"
    db "@"

String_09_05_22::
    db "<VOICE1>*: No?<LINE>"
    db "That's too bad.<WAIT>"
    db "@"

String_09_05_23::
    db "<VOICE1><BUF0> handed over<LINE>"
    db "200G.<WAIT>"
    db "@"

String_09_05_24::
    db "<VOICE1>*: I'll give you<LINE>"
    db "special medicine<PROMPT>"
    db "<NEXT>if you manage to"
    db "<NEXT>defeat me.<PROMPT>"
    db "<NEXT>Would you like to"
    db "<NEXT>challenge me?<CHOICE>"
    db "@"

String_09_05_25::
    db "<VOICE1>*: You've won.<LINE>"
    db "As promised, let<PROMPT>"
    db "<NEXT>me give you some"
    db "<NEXT>of my medicine.<WAIT>"
    db "@"

String_09_05_26::
    db "<BUF>", $17, "'s <BUF>", $22, "<LINE>"
    db "rose by <BUF>", $4e, ".<WAIT>"
    db "@"

String_09_05_27::
    db $f0

String_09_05_28::
    db $11, $19, $f0

String_09_05_29::
    db $16, $19, $f0

String_09_05_2A::
    db "ATK@"

String_09_05_2B::
    db "DEF@"

String_09_05_2C::
    db "AGL@"

String_09_05_2D::
    db "INT@"

String_09_05_2E::
    db "<VOICE1>*: Welcome aboard<LINE>"
    db "the casino ship!<PROMPT>"
    db "<NEXT>Have a spin on the"
    db "<NEXT>slots for 100G!<PROMPT>"
    db "<NEXT>There are prizes"
    db "<NEXT>too. Try it out?<CHOICE>"
    db "@"

String_09_05_2F::
    db "<VOICE1>*: Stop the reels<LINE>"
    db "with the A Button.<PROMPT>"
    db "<NEXT>Depending on what"
    db "<NEXT>marks you line up,<PROMPT>"
    db "<NEXT>the prizes will"
    db "<NEXT>vary. Ready?<WAIT>"
    db "@"

String_09_05_30::
    db "<VOICE1>*: Lucky! You win a<LINE>"
    db "TinyMedal!<WAIT>"
    db "@"

String_09_05_31::
    db "<VOICE1>*: There it is!<LINE>"
    db "You win 1000G!<WAIT>"
    db "@"

String_09_05_32::
    db "<VOICE1>*: Whoa! You've won<LINE>"
    db "a MeteOrb!<WAIT>"
    db "@"

String_09_05_33::
    db "<VOICE1>*: Whoa… Are you<LINE>"
    db "kidding me?<PROMPT>"
    db "<NEXT>You've won some"
    db "<NEXT>secret medicine.<WAIT>"
    db "@"

String_09_05_34::
    db "<VOICE1>*: Are you serious?<LINE>"
    db "I don't believe it.<PROMPT>"
    db "<NEXT>You've won some"
    db "<NEXT>secret medicine.<WAIT>"
    db "@"

String_09_05_35::
    db "<VOICE1>*: Too bad…<LINE>"
    db "Try again, OK?<WAIT>"
    db "@"

String_09_05_36::
    db "<VOICE1>*: That's too bad.<LINE>"
    db "See you again.<WAIT>"
    db "@"

String_09_05_37::
    db "<VOICE1>*: I will heal your<LINE>"
    db "injuries for you…<PROMPT>"
    db "<NEXT>If you can defeat"
    db "<NEXT>me, that is. Well?<CHOICE>"
    db "@"

String_09_05_38::
    db "<VOICE1>*: Fine, fine,<LINE>"
    db "I surrender.<PROMPT>"
    db "<NEXT>I'll heal your"
    db "<NEXT>party as promised.<WAIT>"
    db "@"

String_09_05_39::
    db "<VOICE1>*: Your lack of<LINE>"
    db "training is clear.<PROMPT>"
    db "<NEXT>Best of luck to"
    db "<NEXT>you…<WAIT>"
    db "@"

String_09_05_3A::
    db "<VOICE1>*: Let me lighten<LINE>"
    db "your purse.<WAIT>"
    db "@"

String_09_05_3B::
    db "<VOICE1>*: I see an injured<LINE>"
    db "monster…<PROMPT>"
    db "<NEXT>Heh, I think I can"
    db "<NEXT>win this one.<WAIT>"
    db "@"

String_09_05_3C::
    db "<VOICE1>*: Oh, at least one<LINE>"
    db "monster tired?<PROMPT>"
    db "<NEXT>This works out"
    db "<NEXT>perfectly for me.<WAIT>"
    db "@"

String_09_05_3D::
    db "<VOICE1>*: Heh, those are<LINE>"
    db "some weaklings!<PROMPT>"
    db "<NEXT>That makes things"
    db "<NEXT>easy for me.<WAIT>"
    db "@"

String_09_05_3E::
    db "The fugitive<LINE>"
    db "master was<PROMPT>"
    db "<NEXT>captured and sent"
    db "<NEXT>back to GreatLog.<WAIT>"
    db "@"

String_09_05_3F::
    db "<VOICE1>*: I'll unburden<LINE>"
    db "you of your gold.<WAIT>"
    db "@"

String_09_05_40::
    db "<VOICE1>*: I'm not dirty-<LINE>"
    db "not at all.<PROMPT>"
    db "<NEXT>You shouldn't be"
    db "<NEXT>so careless.<WAIT>"
    db "@"

String_09_05_41::
    db "<VOICE1>*: You'll need more<LINE>"
    db "experience to<PROMPT>"
    db "<NEXT>catch me, much"
    db "<NEXT>more, hahahah!<WAIT>"
    db "@"

String_09_05_42::
    db "<VOICE1>*: Heheheh, your<LINE>"
    db "looks don't lie!<PROMPT>"
    db "<NEXT>That'll teach you"
    db "<NEXT>to stay away!<WAIT>"
    db "@"

String_09_05_43::
    db "<BUF0> received a<LINE>"
    db "Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

String_09_05_44::
    db "<VOICE1>*: Lucky, kid!<LINE>"
    db "You've won 500G!<WAIT>"
    db "@"

String_09_05_45::
    db "<VOICE1>*: Lucky, kid!<LINE>"
    db "You've won 200G!<WAIT>"
    db "@"

String_09_05_46::
    db "<VOICE1>*: Lucky, kid!<LINE>"
    db "You've won 100G!<WAIT>"
    db "@"

String_09_05_47::
    db "<VOICE1>*: Lucky, kid!<LINE>"
    db "You've won 50G!<WAIT>"
    db "@"

String_09_05_48::
    db "<VOICE1>*: You've no courage<LINE>"
    db "to battle?<PROMPT>"
    db "<NEXT>Shame, it really"
    db "<NEXT>is.<WAIT>"
    db "@"

String_09_05_49::
    db "<VOICE1>*: I take being a<LINE>"
    db "master seriously.<PROMPT>"
    db "<NEXT>I won't hold back"
    db "<NEXT>from anything!<WAIT>"
    db "@"

String_09_05_4A::
    db "<VOICE1>*: No? You're rather<LINE>"
    db "cowardly.<WAIT>"
    db "@"

String_09_05_4B::
    db "<VOICE1>*: Ah, the sparkle<LINE>"
    db "in your eyes…<PROMPT>"
    db "<NEXT>I", $44, " best not"
    db "<NEXT>disappoint you!<WAIT>"
    db "@"

String_09_05_4C::
    db "<VOICE1>*: What?<LINE>"
    db "Little chicken!<PROMPT>"
    db "<NEXT>Go home to your"
    db "<NEXT>mommy, baby!<WAIT>"
    db "@"

String_09_05_4D::
    db "<VOICE1>*: Good answer!<LINE>"
    db "Let's battle!<WAIT>"
    db "@"

String_09_05_4E::
    db "<VOICE2>*: Oh, you poor<LINE>"
    db "monsters.<PROMPT>"
    db "<NEXT>You have such a"
    db "<NEXT>poor master…<WAIT>"
    db "@"

String_09_05_4F::
    db "<VOICE2>*: Oh, you're ready,<LINE>"
    db "are you?<PROMPT>"
    db "<NEXT>But I don't plan"
    db "<NEXT>on losing!<WAIT>"
    db "@"

String_09_05_50::
    db "<VOICE1>*: I thought you<LINE>"
    db "were dedicated…<PROMPT>"
    db "<NEXT>But my eyes must"
    db "<NEXT>have been misled.<WAIT>"
    db "@"

String_09_05_51::
    db "<VOICE1>*: My eyes didn't<LINE>"
    db "mislead me. Ready?<WAIT>"
    db "@"

String_09_05_52::
    db "<VOICE1>*: Now you can see<LINE>"
    db "the entire world!<WAIT>"
    db "@"

String_09_05_53::
    db "<VOICE1>*: I hope you'll<LINE>"
    db "put up more of a<PROMPT>"
    db "<NEXT>fight next time"
    db "<NEXT>than this…<WAIT>"
    db "@"

String_09_06_00::
    db $f0

String_09_06_01::
    db "GreatLog", $5b, "@"

String_09_06_02::
    db "Oasis", $5b, "@"

String_09_06_03::
    db "Pirate", $5b, "@"

String_09_06_04::
    db "Ice", $5b, "@"

String_09_06_05::
    db "Sky", $5b, "@"

String_09_06_06::
    db "Limbo", $5b, "@"

String_09_06_07::
    db "Elf", $5b, "@"

String_09_06_08::
    db "Lonely", $5b, "@"

String_09_06_09::
    db "Traveler", $5b, "@"

String_09_06_0A::
    db "Brawn", $5b, "@"

String_09_06_0B::
    db "Baffle", $5b, "@"

String_09_06_0C::
    db "Soul", $5b, "@"

String_09_07_00::
    db $f1, $f1, $f0

String_09_07_01::
    db "Key to<LINE>"
    db "return<LINE>"
    db "home.@"

String_09_07_02::
    db "Key to<LINE>"
    db "Desert<LINE>"
    db "World.@"

String_09_07_03::
    db "Key to<LINE>"
    db "Sea<LINE>"
    db "World.@"

String_09_07_04::
    db "Key to<LINE>"
    db "Ice<LINE>"
    db "World.@"

String_09_07_05::
    db "Key to<LINE>"
    db "Sky<LINE>"
    db "World.@"

String_09_07_06::
    db "Key to<LINE>"
    db "Limbo.<LINE>"
    db "@"

String_09_07_07::
    db "Key to<LINE>"
    db "Elf<LINE>"
    db "World.@"

String_09_07_08::
    db "Key to<LINE>"
    db "Lonely<LINE>"
    db "World.@"

String_09_07_09::
    db "Key to<LINE>"
    db "Travel<LINE>"
    db "World.@"

String_09_07_0A::
    db "Key to<LINE>"
    db "Power<LINE>"
    db "World.@"

String_09_07_0B::
    db "Key to<LINE>"
    db "Baffle<LINE>"
    db "World.@"

String_09_07_0C::
    db "Key to<LINE>"
    db "Soul<LINE>"
    db "World.@"

String_09_07_0D::
    db "Magic<LINE>"
    db "Key to<LINE>"
    db "where?@"

String_09_07_0E::
    db "Key to<LINE>"
    db "<BUF0>.<LINE>"
    db "@"

String_09_08_00::
    db "New gameContinueVS battleBreedTrade ©Journal datalost…@"

String_09_09_00::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "Arena!<PROMPT>"
    db "<NEXT>We have a special"
    db "<NEXT>team with us!<WAIT>"
    db "@"

String_09_09_01::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "Arena!<PROMPT>"
    db "<NEXT>For today's C"
    db "<NEXT>Class Challenge,<PROMPT>"
    db "<NEXT>we have a little"
    db "<NEXT>challenger!<WAIT>"
    db "@"

String_09_09_02::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "Arena!<PROMPT>"
    db "<NEXT>For today's B"
    db "<NEXT>Class Tournament,<PROMPT>"
    db "<NEXT>we have a brave,"
    db "<NEXT>new challenger!<WAIT>"
    db "@"

String_09_09_03::
    db "<VOICE1>*: Welcome to the<LINE>"
    db "Arena!<PROMPT>"
    db "<NEXT>For today's A"
    db "<NEXT>Class Tournament,<PROMPT>"
    db "<NEXT>we have a hot, new"
    db "<NEXT>challenger!<WAIT>"
    db "@"

String_09_09_04::
    db "<VOICE1>*: Ladies and<LINE>"
    db "gentlemen!<PROMPT>"
    db "<NEXT>For today's S"
    db "<NEXT>Class Tournament,<PROMPT>"
    db "<NEXT>we have a brand"
    db "<NEXT>new hero!<WAIT>"
    db "@"

String_09_09_05::
    db "<VOICE1>*: E Class battles<LINE>"
    db "are ready to go!<WAIT>"
    db "@"

String_09_09_06::
    db "<VOICE1>*: D Class battles<LINE>"
    db "are ready to go!<WAIT>"
    db "@"

String_09_09_07::
    db "<VOICE1>*: C Class battles<LINE>"
    db "are ready to go!<WAIT>"
    db "@"

String_09_09_08::
    db "<VOICE1>*: B Class battles<LINE>"
    db "are ready to go!<WAIT>"
    db "@"

String_09_09_09::
    db "<VOICE1>*: A Class battles<LINE>"
    db "are ready to go!<WAIT>"
    db "@"

String_09_09_0A::
    db "<VOICE1>*: S Class battles<LINE>"
    db "are ready to go!<WAIT>"
    db "@"

String_09_09_0B::
    db "<VOICE1>*: Ladies and<LINE>"
    db "gentlemen!<PROMPT>"
    db "<NEXT>Get ready for a"
    db "<NEXT>Special Match!<PROMPT>"
    db "<NEXT>Master <BUF0>"
    db "<NEXT>will take on…<WAIT>"
    db "@"

String_09_09_0C::
    db "<VOICE1>*: Master <BUF0> and<LINE>"
    db "the farm friends!<WAIT>"
    db "@"

String_09_09_0D::
    db "<VOICE1>*: Master <BUF0> and<LINE>"
    db "the fun friends!<WAIT>"
    db "@"

String_09_09_0E::
    db "<VOICE1>*: Master <BUF0> and<LINE>"
    db "trusty friends!<WAIT>"
    db "@"

String_09_09_0F::
    db "<VOICE1>*: Master <BUF0> and<LINE>"
    db "powerful friends!<WAIT>"
    db "@"

String_09_09_10::
    db "<VOICE1>*: Master <BUF0> and<LINE>"
    db "brave friends!<WAIT>"
    db "@"

String_09_09_11::
    db "<VOICE1>*: This next battle<LINE>"
    db "will feature the<PROMPT>"
    db "<NEXT>up-and-coming"
    db "<NEXT>monster master…<PROMPT>"
    db "<NEXT>Master <BUF0> and"
    db "<NEXT>the farm friends!<WAIT>"
    db "@"

String_09_09_12::
    db "<VOICE1>*: ????????? and<LINE>"
    db "????? friends!<WAIT>"
    db "@"

String_09_09_13::
    db "<VOICE1>*: Battle one!<LINE>"
    db "Ready? Go!<WAIT>"
    db "@"

String_09_09_14::
    db "<VOICE1>*: Battle two!<LINE>"
    db "Ready? Go!<WAIT>"
    db "@"

String_09_09_15::
    db "<VOICE1>*: This decides the<LINE>"
    db "champion!<PROMPT>"
    db "<NEXT>Final battle!"
    db "<NEXT>Ready? Go!<WAIT>"
    db "@"

String_09_09_16::
    db "<VOICE1>*: This is it! The<LINE>"
    db "deciding battle!<PROMPT>"
    db "<NEXT>Are you ready?"
    db "<NEXT>Let's go!<WAIT>"
    db "@"

String_09_09_17::
    db "<VOICE1>*: The challenger<LINE>"
    db "wins battle one!<WAIT>"
    db "@"

String_09_09_18::
    db "<VOICE1>*: That's amazing!<LINE>"
    db "Is this true?<PROMPT>"
    db "<NEXT>The challenger"
    db "<NEXT>wins battle two!<WAIT>"
    db "@"

String_09_09_19::
    db "<VOICE1>*: Master <BUF0> has<LINE>"
    db "won battle one!<WAIT>"
    db "@"

String_09_09_1A::
    db "<VOICE1>*: Master <BUF0> has<LINE>"
    db "won battle two!<WAIT>"
    db "@"

String_09_09_1B::
    db "<VOICE1>*: Incredible!<LINE>"
    db "The winners are<PROMPT>"
    db "<NEXT>Master <BUF0> and"
    db "<NEXT>the fun friends!<MUSIC_WAIT>", $48, "<PROMPT>"
    db "<MAP_MUSIC>"
    db "<NEXT>What an impressive"
    db "<NEXT>debut!<WAIT>"
    db "@"

String_09_09_1C::
    db "<VOICE1>*: The C Class<LINE>"
    db "champion party is<PROMPT>"
    db "<NEXT>Master <BUF0> and"
    db "<NEXT>the fun friends!<MUSIC_WAIT>", $4a, "<PROMPT>"
    db "<MAP_MUSIC>"
    db "<NEXT>Let's hear it for"
    db "<NEXT>the champion!<WAIT>"
    db "@"

String_09_09_1D::
    db "<VOICE1>*: The B Class<LINE>"
    db "champion party is<PROMPT>"
    db "<NEXT>Master <BUF0> and"
    db "<NEXT>trusty friends!<MUSIC_WAIT>", $4a, "<PROMPT>"
    db "<MAP_MUSIC>"
    db "<NEXT>Let's hear it for"
    db "<NEXT>the champion!<WAIT>"
    db "@"

String_09_09_1E::
    db "<VOICE1>*: The A Class<LINE>"
    db "champion party is<PROMPT>"
    db "<NEXT>Master <BUF0> and"
    db "<NEXT>powerful friends!<MUSIC_WAIT>", $4a, "<PROMPT>"
    db "<MAP_MUSIC>"
    db "<NEXT>Let's have a huge"
    db "<NEXT>hand for them!<WAIT>"
    db "@"

String_09_09_1F::
    db "<VOICE1>*: The S Class<LINE>"
    db "champion party is<PROMPT>"
    db "<NEXT>Master <BUF0> and"
    db "<NEXT>brave friends!<MUSIC_WAIT>", $4d, "<PROMPT>"
    db "<MAP_MUSIC>"
    db "<NEXT>Let's hear it for"
    db "<NEXT>the new hero!<WAIT>"
    db "@"

String_09_09_20::
    db "<VOICE1>*: This match's<LINE>"
    db "winners are<PROMPT>"
    db "<NEXT>Master <BUF0> and"
    db "<NEXT>the farm friends!<PROMPT>"
    db "<NEXT>Let's hear it for"
    db "<NEXT>the winning party!<WAIT>"
    db "@"

String_09_09_21::
    db "<VOICE1>*: The Special<LINE>"
    db "Match winners are<PROMPT>"
    db "<NEXT>Master <BUF0> and"
    db "<NEXT>the farm friends!<PROMPT>"
    db "<NEXT>Let's hear it for"
    db "<NEXT>the winning party!<WAIT>"
    db "@"
    ds $1a86, $00
