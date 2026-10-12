SECTION "Bank 99", ROMX[$4000], BANK[$99]
    db $99

; overflow for message bank $2D: wStringIndex -= $D5, then BeginStringDisplay with the table Data_099_4070 in this bank (E-0080)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank2D)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank2D_Overflow::
Func_099_4001:: ; address name
    ld de, MessageStrings_Bank2D_Overflow
    ld a, [wStringIndex]
    sub a, $D5
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2D: wStringIndex -= $D5, then CopyStringToBuffer with the table Data_099_4070 in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank2D)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank2D_Overflow:: ; heuristic: follows a terminator; C0
Func_099_4010:: ; address name
    ld de, MessageStrings_Bank2D_Overflow
    ld a, [wStringIndex]
    sub a, $D5
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; overflow for message bank $2E: wStringIndex -= $A6, then BeginStringDisplay with the table Data_099_4B35 in this bank (E-0080)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank2E)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank2E_Overflow::
Func_099_4026:: ; address name
    ld de, MessageStrings_Bank2E_Overflow
    ld a, [wStringIndex]
    sub a, $A6
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2E: wStringIndex -= $A6, then CopyStringToBuffer with the table Data_099_4B35 in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank2E)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank2E_Overflow:: ; heuristic: follows a terminator; C0
Func_099_4035:: ; address name
    ld de, MessageStrings_Bank2E_Overflow
    ld a, [wStringIndex]
    sub a, $A6
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $26, $40, $CD, $11, $26, $C9

; overflow for message bank $7C: wStringIndex -= $87, then BeginStringDisplay with the table Data_099_6366 in this bank (E-0080)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank7C)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank7C_Overflow::
Func_099_404B:: ; address name
    ld de, MessageStrings_Bank7C_Overflow
    ld a, [wStringIndex]
    sub a, $87
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $7C: wStringIndex -= $87, then CopyStringToBuffer with the table Data_099_6366 in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank7C)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank7C_Overflow:: ; heuristic: follows a terminator; C0
Func_099_405A:: ; address name
    ld de, MessageStrings_Bank7C_Overflow
    ld a, [wStringIndex]
    sub a, $87
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $4B, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_99_4070::
MessageStrings_Bank2D_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_099_4070:: ; address name
    dw StringList_99_4072 ; id 0

; E-0217 (derived: category list of StringCategories_99_4070; one pointer per wStringIndex)
; record: string
StringList_99_4072::
Data_099_4072:: ; address name
    dw String_99_4070_00_00 ; id 0
    dw String_99_4070_00_01 ; id 1
    dw String_99_4070_00_02 ; id 2
    dw String_99_4070_00_03 ; id 3
    dw String_99_4070_00_04 ; id 4
    dw String_99_4070_00_05 ; id 5
    dw String_99_4070_00_06 ; id 6
    dw String_99_4070_00_07 ; id 7
    dw String_99_4070_00_08 ; id 8
    dw String_99_4070_00_09 ; id 9
    dw String_99_4070_00_0A ; id 10
    dw String_99_4070_00_0B ; id 11
    dw String_99_4070_00_0C ; id 12
    dw String_99_4070_00_0D ; id 13
    dw String_99_4070_00_0E ; id 14
    dw String_99_4070_00_0F ; id 15
    dw String_99_4070_00_10 ; id 16
    dw String_99_4070_00_11 ; id 17
    dw String_99_4070_00_12 ; id 18
    dw String_99_4070_00_13 ; id 19
    dw String_99_4070_00_14 ; id 20
    dw String_99_4070_00_15 ; id 21
    dw String_99_4070_00_16 ; id 22
    dw String_99_4070_00_17 ; id 23
    dw String_99_4070_00_18 ; id 24
    dw String_99_4070_00_19 ; id 25
    dw String_99_4070_00_1A ; id 26
    dw String_99_4070_00_1B ; id 27
    dw String_99_4070_00_1C ; id 28
    dw String_99_4070_00_1D ; id 29
    dw String_99_4070_00_1E ; id 30
    dw String_99_4070_00_1F ; id 31
    dw String_99_4070_00_20 ; id 32
    dw String_99_4070_00_21 ; id 33
    dw String_99_4070_00_22 ; id 34
    dw String_99_4070_00_23 ; id 35
    dw String_99_4070_00_24 ; id 36
    dw String_99_4070_00_25 ; id 37
    dw String_99_4070_00_26 ; id 38
    dw String_99_4070_00_27 ; id 39
    dw String_99_4070_00_28 ; id 40
    dw String_99_4070_00_29 ; id 41
    dw String_99_4070_00_2A ; id 42

String_99_4070_00_00:: ; heuristic: string; C0
Data_099_40C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Make sure you", $F1
    db "tell the others ", $FA, $F7
    db $EF, $EE, "that I'm No. 1,", $EF, $EE, "do you understand?", $F7
    db $F0

String_99_4070_00_01:: ; heuristic: string; C0
Data_099_4111:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm as plain as", $F1
    db "a baked potato.", $FA, $F7
    db $EF, $EE, "Even what I say is", $EF, $EE, "bland.", $F7
    db $F0

String_99_4070_00_02:: ; heuristic: string; C0
Data_099_4152:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Isn't the weather", $F1
    db "fabulous?", $FA, $F7
    db $EF, $EE, "We need to be out", $EF, $EE, "traveling!", $F7
    db $F0

String_99_4070_00_03:: ; heuristic: string; C0
Data_099_4192:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Don't be so", $F1
    db "obstinate?", $FA, $F7
    db $EF, $EE, "But I'm not!", $EF, $EE, "Huh? I'm acting it?", $F7
    db $F0

String_99_4070_00_04:: ; heuristic: string; C0
Data_099_41CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master, please", $F1
    db "consider saving", $FA, $F7
    db $EF, $EE, "your money, and", $EF, $EE, "not wasting it.", $F7
    db $F0

String_99_4070_00_05:: ; heuristic: string; C0
Data_099_4216:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I plan to leave", $F1
    db "as I see fit.", $FA, $F7
    db $EF, $EE, "Leave me alone,", $EF, $EE, "please.", $F7
    db $F0

String_99_4070_00_06:: ; heuristic: string; C0
Data_099_4254:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Meat, meat, give", $F1
    db "me meat!", $FA, $F7
    db $EF, $EE, "Or I won't work", $EF, $EE, "for you. Meat!", $F7
    db $F0

String_99_4070_00_07:: ; heuristic: string; C0
Data_099_4294:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Know your enemy,", $F1
    db "know yourself,", $FA, $F7
    db $EF, $EE, "and you will win", $EF, $EE, "without danger.", $F7
    db $F0

String_99_4070_00_08:: ; heuristic: string; C0
Data_099_42DD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Use a mate as a", $F1
    db "shield, escape", $A4, $FA, $F7
    db $EF, $EE, "Whoops, uh", $A4, " nah,", $EF, $EE, "nothing", $A4, $F7
    db $F0

String_99_4070_00_09:: ; heuristic: string; C0
Data_099_431F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Enemies deserve", $F1
    db "no mercy!", $FA, $F7
    db $EF, $EE, "Crush them with", $EF, $EE, "all our might!", $F7
    db $F0

String_99_4070_00_0A:: ; heuristic: string; C0
Data_099_4360:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $A4, " Um", $A4, " Shy", $A4, $F1
    db "Sorry", $A4, " I'm sorry", $A4, $F7
    db $F0

String_99_4070_00_0B:: ; heuristic: string; C0
Data_099_4381:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " For my partners,", $F1
    db "and most of all", $FA, $F7
    db $EF, $EE, "for you, master,", $EF, $EE, "I'll do my best!", $F7
    db $F0

String_99_4070_00_0C:: ; heuristic: string; C0
Data_099_43CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, no", $A4, $F1
    db "Must I go?", $FA, $F7
    db $EF, $EE, "Caves and dark", $EF, $EE, "places are scary", $A4, $F7
    db $F0

String_99_4070_00_0D:: ; heuristic: string; C0
Data_099_4407:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll clean, wash,", $F1
    db "whatever you wish!", $FA, $F7
    db $EF, $EE, "Just give me the", $EF, $EE, "word!", $F7
    db $F0

String_99_4070_00_0E:: ; heuristic: string; C0
Data_099_444A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well, is seems", $F1
    db "to me, the world", $FA, $F7
    db $EF, $EE, "at large is pretty", $EF, $EE, "peaceful, ayup!", $F7
    db $F0

String_99_4070_00_0F:: ; heuristic: string; C0
Data_099_4495:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is there any way", $F1
    db "of fighting while", $FA, $F7
    db $EF, $EE, "you're asleep?", $EF, $EE, "How ideal!", $F7
    db $F0

String_99_4070_00_10:: ; heuristic: string; C0
Data_099_44D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The dark fire", $F1
    db "that spirals in my", $FA, $F7
    db $EF, $EE, "heart shall never", $EF, $EE, "be extinguished!", $F7
    db $F0

String_99_4070_00_11:: ; heuristic: string; C0
Data_099_4525:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Seeing your joy", $F1
    db "adds to my own.", $F7
    db $F0

String_99_4070_00_12:: ; heuristic: string; C0
Data_099_4549:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I will take care", $F1
    db "of you totally!", $F7
    db $F0

String_99_4070_00_13:: ; heuristic: string; C0
Data_099_456E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " World domination", $F1
    db "is the ultimate", $FA, $F7
    db $EF, $EE, "goal in my life!", $EF, $EE, $F7
    db $F0

String_99_4070_00_14:: ; heuristic: string; C0
Data_099_45A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " However dire the", $F1
    db "situation, I will", $FA, $F7
    db $EF, $EE, "always shield you", $EF, $EE, "from danger.", $F7
    db $F0

String_99_4070_00_15:: ; heuristic: string; C0
Data_099_45F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Human! You be", $F1
    db "grateful that I", $FA, $F7
    db $EF, $EE, "have even chosen", $EF, $EE, "to accompany you!", $F7
    db $F0

String_99_4070_00_16:: ; heuristic: string; C0
Data_099_463C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Even once, I", $F1
    db "would have liked", $FA, $F7
    db $EF, $EE, "to have been a", $EF, $EE, "hero", $A4, $F7
    db $F0

String_99_4070_00_17:: ; heuristic: string; C0
Data_099_4677:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fufufu", $A4, " Perhaps", $F1
    db "we will be enemies", $FA, $F7
    db $EF, $EE, "if we meet again", $EF, $EE, "in the future.", $F7
    db $F0

String_99_4070_00_18:: ; heuristic: string; C0
Data_099_46C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " For you, master,", $F1
    db "I will leap into", $FA, $F7
    db $EF, $EE, "a pool of fire, if", $EF, $EE, "you so command me.", $F7
    db $F0

String_99_4070_00_19:: ; heuristic: string; C0
Data_099_4712:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Excitement,", $F1
    db "tension", $A4, $FA, $F7
    db $EF, $EE, "They are emotions", $EF, $EE, "without meaning.", $F7
    db $F0

String_99_4070_00_1A:: ; heuristic: string; C0
Data_099_4752:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " People and", $F1
    db "monsters should be", $FA, $F7
    db $EF, $EE, "punished alike for", $EF, $EE, "sins they commit.", $F7
    db $F0

String_99_4070_00_1B:: ; heuristic: string; C0
Data_099_479D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Give me the", $F1
    db "chance to shine.", $FA, $F7
    db $EF, $EE, "I will protect you", $EF, $EE, "if you do.", $F7
    db $F0

String_99_4070_00_1C:: ; heuristic: string; C0
Data_099_47E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I am the Lord of", $F1
    db "the monsters!", $FA, $F7
    db $EF, $EE, "What? Too plain?", $EF, $EE, "You think so?", $F7
    db $F0

String_99_4070_00_1D:: ; heuristic: string; C0
Data_099_4826:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Are there no", $F1
    db "unbreakable toys ", $FA, $F7
    db $EF, $EE, "that will keep", $EF, $EE, "coming back?", $F7
    db $F0

String_99_4070_00_1E:: ; heuristic: string; C0
Data_099_4869:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Don't bother me", $A4, $F1
    db "Leave me be", $A4, $F7
    db $F0

String_99_4070_00_1F:: ; heuristic: string; C0
Data_099_488A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let me conquer a", $F1
    db "world for you, eh?", $F7
    db $F0

String_99_4070_00_20:: ; heuristic: string; C0
Data_099_48B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " To be conquered", $F1
    db "by me is to know", $FA, $F7
    db $EF, $EE, "happiness!", $EF, $EE, "Hahahahahah!", $F7
    db $F0

String_99_4070_00_21:: ; heuristic: string; C0
Data_099_48F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The world is", $F1
    db "mine!", $FA, $F7
    db $EF, $EE, "That is the way it", $EF, $EE, "has to be!", $F7
    db $F0

String_99_4070_00_22:: ; heuristic: string; C0
Data_099_492C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Everything is", $F1
    db "according to plan.", $FA, $F7
    db $EF, $EE, "Nothing unexpected", $EF, $EE, "can happen.", $F7
    db $F0

String_99_4070_00_23:: ; heuristic: string; C0
Data_099_4974:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You can be the", $F1
    db "decoy. I'll strike", $FA, $F7
    db $EF, $EE, "while you're under", $EF, $EE, "attack. How's that?", $F7
    db $F0

String_99_4070_00_24:: ; heuristic: string; C0
Data_099_49C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The feelings of", $F1
    db "hatred and sorrow", $FA, $F7
    db $EF, $EE, "become my power.", $EF, $EE, $F7
    db $F0

String_99_4070_00_25:: ; heuristic: string; C0
Data_099_49FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Traveling is", $F1
    db "fine, but quietly", $FA, $F7
    db $EF, $EE, "reading is also", $EF, $EE, "pleasant", $A4, $F7
    db $F0

String_99_4070_00_26:: ; heuristic: string; C0
Data_099_4A3F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " All my power, I", $F1
    db "will use for you", $A4, $F7
    db $F0

String_99_4070_00_27:: ; heuristic: string; C0
Data_099_4A65:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The p-power of", $F1
    db "heroes is scary", $A4, $F7
    db $F0

String_99_4070_00_28:: ; heuristic: string; C0
Data_099_4A89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you would", $F1
    db "allow it, I wish", $FA, $F7
    db $EF, $EE, "to conquer this", $EF, $EE, "world.", $F7
    db $F0

String_99_4070_00_29:: ; heuristic: string; C0
Data_099_4AC6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Life isn't bad!", $F1
    db "Take it easy,", $FA, $F7
    db $EF, $EE, "slow down, relax", $EF, $EE, "and enjoy!", $F7
    db $F0

String_99_4070_00_2A:: ; heuristic: string; C0
Data_099_4B07:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I can't be", $F1
    db "bothered to chat", $A4, $FA, $F7
    db $EF, $EE, "Be gone", $A4, $EF, $EE, $F7
    db $F0

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_99_4B35::
MessageStrings_Bank2E_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_099_4B35:: ; address name
    dw StringList_99_4B37 ; id 0

; E-0217 (derived: category list of StringCategories_99_4B35; one pointer per wStringIndex)
; record: string
StringList_99_4B37::
Data_099_4B37:: ; address name
    dw String_99_4B35_00_00 ; id 0
    dw String_99_4B35_00_01 ; id 1
    dw String_99_4B35_00_02 ; id 2
    dw String_99_4B35_00_03 ; id 3
    dw String_99_4B35_00_04 ; id 4
    dw String_99_4B35_00_05 ; id 5
    dw String_99_4B35_00_06 ; id 6
    dw String_99_4B35_00_07 ; id 7
    dw String_99_4B35_00_08 ; id 8
    dw String_99_4B35_00_09 ; id 9
    dw String_99_4B35_00_0A ; id 10
    dw String_99_4B35_00_0B ; id 11
    dw String_99_4B35_00_0C ; id 12
    dw String_99_4B35_00_0D ; id 13
    dw String_99_4B35_00_0E ; id 14
    dw String_99_4B35_00_0F ; id 15
    dw String_99_4B35_00_10 ; id 16
    dw String_99_4B35_00_11 ; id 17
    dw String_99_4B35_00_12 ; id 18
    dw String_99_4B35_00_13 ; id 19
    dw String_99_4B35_00_14 ; id 20
    dw String_99_4B35_00_15 ; id 21
    dw String_99_4B35_00_16 ; id 22
    dw String_99_4B35_00_17 ; id 23
    dw String_99_4B35_00_18 ; id 24
    dw String_99_4B35_00_18 ; id 25
    dw String_99_4B35_00_1A ; id 26
    dw String_99_4B35_00_1B ; id 27
    dw String_99_4B35_00_1C ; id 28
    dw String_99_4B35_00_1D ; id 29
    dw String_99_4B35_00_1E ; id 30
    dw String_99_4B35_00_1F ; id 31
    dw String_99_4B35_00_20 ; id 32
    dw String_99_4B35_00_21 ; id 33
    dw String_99_4B35_00_22 ; id 34
    dw String_99_4B35_00_23 ; id 35
    dw String_99_4B35_00_24 ; id 36
    dw String_99_4B35_00_25 ; id 37
    dw String_99_4B35_00_26 ; id 38
    dw String_99_4B35_00_27 ; id 39
    dw String_99_4B35_00_28 ; id 40
    dw String_99_4B35_00_29 ; id 41
    dw String_99_4B35_00_2A ; id 42
    dw String_99_4B35_00_2B ; id 43
    dw String_99_4B35_00_2C ; id 44
    dw String_99_4B35_00_2D ; id 45
    dw String_99_4B35_00_2E ; id 46
    dw String_99_4B35_00_2F ; id 47
    dw String_99_4B35_00_30 ; id 48
    dw String_99_4B35_00_31 ; id 49
    dw String_99_4B35_00_32 ; id 50
    dw String_99_4B35_00_33 ; id 51
    dw String_99_4B35_00_34 ; id 52
    dw String_99_4B35_00_35 ; id 53
    dw String_99_4B35_00_36 ; id 54
    dw String_99_4B35_00_37 ; id 55
    dw String_99_4B35_00_38 ; id 56
    dw String_99_4B35_00_38 ; id 57
    dw String_99_4B35_00_38 ; id 58
    dw String_99_4B35_00_38 ; id 59
    dw String_99_4B35_00_38 ; id 60
    dw String_99_4B35_00_38 ; id 61
    dw String_99_4B35_00_38 ; id 62
    dw String_99_4B35_00_38 ; id 63
    dw String_99_4B35_00_38 ; id 64
    dw String_99_4B35_00_38 ; id 65
    dw String_99_4B35_00_38 ; id 66
    dw String_99_4B35_00_38 ; id 67
    dw String_99_4B35_00_38 ; id 68
    dw String_99_4B35_00_38 ; id 69
    dw String_99_4B35_00_38 ; id 70
    dw String_99_4B35_00_38 ; id 71
    dw String_99_4B35_00_38 ; id 72
    dw String_99_4B35_00_38 ; id 73
    dw String_99_4B35_00_38 ; id 74
    dw String_99_4B35_00_38 ; id 75
    dw String_99_4B35_00_38 ; id 76
    dw String_99_4B35_00_38 ; id 77
    dw String_99_4B35_00_38 ; id 78
    dw String_99_4B35_00_38 ; id 79
    dw String_99_4B35_00_38 ; id 80
    dw String_99_4B35_00_38 ; id 81
    dw String_99_4B35_00_38 ; id 82
    dw String_99_4B35_00_38 ; id 83
    dw String_99_4B35_00_38 ; id 84
    dw String_99_4B35_00_38 ; id 85
    dw String_99_4B35_00_38 ; id 86
    dw String_99_4B35_00_38 ; id 87
    dw String_99_4B35_00_38 ; id 88
    dw String_99_4B35_00_38 ; id 89

String_99_4B35_00_00:: ; heuristic: string; C0
Data_099_4BEB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Our daughter's", $F1
    db "only memento was", $FA, $F7
    db $EF, $EE, "taken from us by", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "I'm losing the will", $EF, $EE, "to keep living", $A4, $F7
    db $F0

String_99_4B35_00_01:: ; heuristic: string; C0
Data_099_4C54:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It doesn't look", $F1
    db "like the monsters", $FA, $F7
    db $EF, $EE, "are coming from", $EF, $EE, "anywhere close.", $FA, $F7
    db $EF, $EE, "You ought to pay a", $EF, $EE, "visit to the hut", $FA, $F7
    db $EF, $EE, "by the spring in", $EF, $EE, "the west.", $FA, $F7
    db $EF, $EE, "It's for use by", $EF, $EE, "travelers.", $FA, $F7
    db $EF, $EE, "You might talk to", $EF, $EE, "them for clues.", $F7
    db $F0

String_99_4B35_00_02:: ; heuristic: string; C0
Data_099_4D28:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The old couple", $F1
    db "across the way", $FA, $F7
    db $EF, $EE, "were robbed of a", $EF, $EE, "precious item.", $FA, $F7
    db $EF, $EE, "That's why they", $EF, $EE, "were so sad.", $F7
    db $F0

String_99_4B35_00_03:: ; heuristic: string; C0
Data_099_4D8E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "traveler's hut.", $FA, $F7
    db $EF, $EE, "Stay and rest your", $EF, $EE, "feet a while.", $F7
    db $F0

String_99_4B35_00_04:: ; heuristic: string; C0
Data_099_4DD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That dealer,", $F1
    db "how expensive!", $FA, $F7
    db $EF, $EE, "Nobody can afford", $EF, $EE, "what he sells!", $FA, $F7
    db $EF, $EE, "But he does have", $EF, $EE, "super merchandise", $A4, $F7
    db $F0

String_99_4B35_00_05:: ; heuristic: string; C0
Data_099_4E3F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lately, the town", $F1
    db "of Miagen has been", $FA, $F7
    db $EF, $EE, "hit by plundering", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "Did you know that?", $EF, $EE, $FF, $F0

String_99_4B35_00_06:: ; heuristic: string; C0
Data_099_4E9F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's rumored that", $F1
    db "monsters raid the", $FA, $F7
    db $EF, $EE, "town by scaling", $EF, $EE, "the mountain range", $FA, $F7
    db $EF, $EE, "to the north.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "I think there was", $EF, $EE, "a forest nearby.", $FA, $F7
    db $EF, $EE, "Perhaps they came", $EF, $EE, "from that forest.", $FA, $F7
    db $EF, $EE, "The forest is east", $EF, $EE, "from here.", $F7
    db $F0

String_99_4B35_00_07:: ; heuristic: string; C0
Data_099_4F72:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You didn't know?", $F1
    db "Well, listen up.", $FA, $F7
    db $EF, $EE, "Go to the town of", $EF, $EE, "Miagen.", $FA, $F7
    db $EF, $EE, "The townspeople", $EF, $EE, "are in an uproar.", $F7
    db $F0

String_99_4B35_00_08:: ; heuristic: string; C0
Data_099_4FDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That dealer's", $F1
    db "wares", $A4, $FA, $F7
    db $EF, $EE, "Could he sell any", $EF, $EE, "at those prices?", $FA, $F7
    db $EF, $EE, "I", $44, " like to make", $EF, $EE, "money like that", $A4, $F7
    db $F0

String_99_4B35_00_09:: ; heuristic: string; C0
Data_099_503F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How does this", $F1
    db "ornament look?", $FA, $F7
    db $EF, $EE, "Take it home for", $EF, $EE, "just 12,000G.", $FA, $F7
    db $EF, $EE, "You say that's too", $EF, $EE, "much?", $FA, $F7
    db $EF, $EE, "Heh, scram if you", $EF, $EE, "have no money.", $F7
    db $F0

String_99_4B35_00_0A:: ; heuristic: string; C0
Data_099_50C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How does this", $F1
    db "jewelry look?", $FA, $F7
    db $EF, $EE, "It's yours for a", $EF, $EE, "mere 18,000G.", $FA, $F7
    db $EF, $EE, "You say that's too", $EF, $EE, "much?", $FA, $F7
    db $EF, $EE, "Heh, scram if you", $EF, $EE, "have no money.", $F7
    db $F0

String_99_4B35_00_0B:: ; heuristic: string; C0
Data_099_5147:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How does this", $F1
    db "grand vase look?", $FA, $F7
    db $EF, $EE, "A bargain at", $EF, $EE, "23,000G!", $FA, $F7
    db $EF, $EE, "You say that's too", $EF, $EE, "much?", $FA, $F7
    db $EF, $EE, "Heh, scram if you", $EF, $EE, "have no money.", $F7
    db $F0

String_99_4B35_00_0C:: ; heuristic: string; C0
Data_099_51C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e no use for", $F1
    db "the poor.", $FA, $F7
    db $EF, $EE, "Come back if you", $EF, $EE, "make some money.", $F7
    db $F0

String_99_4B35_00_0D:: ; heuristic: string; C0
Data_099_5208:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How does this", $F1
    db "ornament look?", $FA, $F7
    db $EF, $EE, "Take it home for", $EF, $EE, "just 12,000G.", $FA, $F7
    db $EF, $EE, "What? Monsters?", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Get lost if you're", $EF, $EE, "not buying!", $F7
    db $F0

String_99_4B35_00_0E:: ; heuristic: string; C0
Data_099_5284:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How does this", $F1
    db "jewelry look?", $FA, $F7
    db $EF, $EE, "It's yours for a", $EF, $EE, "mere 18,000G.", $FA, $F7
    db $EF, $EE, "What? Monsters?", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "I don't have time", $EF, $EE, "to play games!", $F7
    db $F0

String_99_4B35_00_0F:: ; heuristic: string; C0
Data_099_5300:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How does this", $F1
    db "grand vase look?", $FA, $F7
    db $EF, $EE, "A bargain at", $EF, $EE, "23,000G!", $FA, $F7
    db $EF, $EE, "What? Monsters?", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "If you're not a", $EF, $EE, "customer, beat it!", $F7
    db $F0

String_99_4B35_00_10:: ; heuristic: string; C0
Data_099_5379:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This pendant is", $F1
    db "yours for 38,000G", $A4, $FA, $F7
    db $EF, $EE, "What? Monsters?", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "I don't know a", $EF, $EE, "thing about that!", $FA, $F7
    db $EF, $EE, "You're bad for", $EF, $EE, "business, vamoose!", $F7
    db $F0

String_99_4B35_00_11:: ; heuristic: string; C0
Data_099_53FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The tower's entry", $F1
    db "is sealed tight.", $F7
    db $F0

String_99_4B35_00_12:: ; heuristic: string; C0
Data_099_5422:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who are you?", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "You shouldn't be", $EF, $EE, "meddling here!", $F7
    db $F0

String_99_4B35_00_13:: ; heuristic: string; C0
Data_099_5458:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're going to", $F1
    db "regret seeing us.", $FA, $F7
    db $EF, $EE, "We can't let you", $EF, $EE, "go blab. Gwaaaaah!", $F7
    db $F0

String_99_4B35_00_14:: ; heuristic: string; C0
Data_099_54A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What, not you", $F1
    db "again!", $F7
    db $F0

String_99_4B35_00_15:: ; heuristic: string; C0
Data_099_54BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We'll smash you", $F1
    db "as often as it", $FA, $F7
    db $EF, $EE, "takes to make you", $EF, $EE, "stop meddling!", $F7
    db $F0

String_99_4B35_00_16:: ; heuristic: string; C0
Data_099_5504:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Please! Mercy!", $F1
    db "Spare us!", $FA, $F7
    db $EF, $EE, "Take back every-", $EF, $EE, "thing we took!", $F7
    db $F0

String_99_4B35_00_17:: ; heuristic: string; C0
Data_099_5545:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, "Pretty Ring.", $F7
    db $F0

String_99_4B35_00_18:: ; heuristic: string; C0
Data_099_5585:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 found the", $F1
    db "Pretty Ring.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Pretty Ring back.", $F7
    db $F0

String_99_4B35_00_1A:: ; heuristic: string; C0
Data_099_55E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I dug deep in my", $F1
    db "purse to buy from", $FA, $F7
    db $EF, $EE, "that dealer, but", $EF, $EE, "it feel very odd.", $FA, $F7
    db $EF, $EE, "What I buy look", $EF, $EE, "very familiar.", $FA, $F7
    db $EF, $EE, "I don't know why.", $EF, $EE, "I will remember.", $F7
    db $F0

String_99_4B35_00_1B:: ; heuristic: string; C0
Data_099_5679:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? Monsters", $F1
    db "attacked you in", $FA, $F7
    db $EF, $EE, "the northern", $EF, $EE, "forest?", $FA, $F7
    db $EF, $EE, "I'm surprised to", $EF, $EE, "see you alive.", $FA, $F7
    db $EF, $EE, "Um", $A4, " Are you maybe", $EF, $EE, "really tough?", $F7
    db $F0

String_99_4B35_00_1C:: ; heuristic: string; C0
Data_099_56FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That dealer is a", $F1
    db "greedy hound!", $FA, $F7
    db $EF, $EE, "He won't tell me", $EF, $EE, "where he gets his", $FA, $F7
    db $EF, $EE, "merchandise, the", $EF, $EE, "cheapskate!", $F7
    db $F0

String_99_4B35_00_1D:: ; heuristic: string; C0
Data_099_5766:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " For 47,000G this", $F1
    db "earring", $A4, " What?", $FA, $F7
    db $EF, $EE, "You went to the", $EF, $EE, "northern forest?", $FA, $F7
    db $EF, $EE, "Monsters didn't", $EF, $EE, "attack you?", $F7
    db $F0

String_99_4B35_00_1E:: ; heuristic: string; C0
Data_099_57CE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You defeated the", $F1
    db "monsters?", $FA, $F7
    db $EF, $EE, "You're not joking,", $EF, $EE, "are you?", $F7
    db $F0

String_99_4B35_00_1F:: ; heuristic: string; C0
Data_099_580C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You defeated the", $F1
    db "monsters", $A4, $FA, $F7
    db $EF, $EE, $A4, "You're not joking,", $EF, $EE, "are you?", $F7
    db $F0

String_99_4B35_00_20:: ; heuristic: string; C0
Data_099_584B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Are you Milayou's", $F1
    db "friend?", $FA, $F7
    db $EF, $EE, "The little monster", $EF, $EE, "master?", $FA, $F7
    db $EF, $EE, "You're after the", $EF, $EE, "bad monsters aren't", $FA, $F7
    db $EF, $EE, "you? That is just", $EF, $EE, "so neat!", $F7
    db $F0

String_99_4B35_00_21:: ; heuristic: string; C0
Data_099_58CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If a monster", $F1
    db "could be good or", $FA, $F7
    db $EF, $EE, "bad, does that", $EF, $EE, "mean there are", $FA, $F7
    db $EF, $EE, "both good masters", $EF, $EE, "and bad ones?", $F7
    db $F0

String_99_4B35_00_22:: ; heuristic: string; C0
Data_099_5935:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Don't you think", $F1
    db "it's odd that the", $FA, $F7
    db $EF, $EE, "monsters are after", $EF, $EE, "treasures?", $FA, $F7
    db $EF, $EE, "I can understand", $EF, $EE, "if they went for", $FA, $F7
    db $EF, $EE, "food, but", $A4, $EF, $EE, $F7
    db $F0

String_99_4B35_00_23:: ; heuristic: string; C0
Data_099_59B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Arrrgh! This is", $F1
    db "so infuriating!", $FA, $F7
    db $EF, $EE, "The monsters took", $EF, $EE, "my lingerie again!", $FA, $F7
    db $EF, $EE, "What exactly would", $EF, $EE, "they want with my", $FA, $F7
    db $EF, $EE, "underwear anyway?", $EF, $EE, "It makes no sense!", $F7
    db $F0

String_99_4B35_00_24:: ; heuristic: string; C0
Data_099_5A50:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 showed the", $F1
    db "Pretty Ring.", $F7
    db $F0

String_99_4B35_00_25:: ; heuristic: string; C0
Data_099_5A6C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah", $A4, " That ring", $A4, $F1
    db "Is", $A4, " Is it", $A4, $FA, $F7
    db $EF, $EE, "That's my daughter's", $EF, $EE, "ring!", $F7
    db $F0

String_99_4B35_00_26:: ; heuristic: string; C0
Data_099_5AA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Pretty Ring.", $F7
    db $F0

String_99_4B35_00_27:: ; heuristic: string; C0
Data_099_5AC8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Thank you for", $F1
    db "getting the ring", $FA, $F7
    db $EF, $EE, "back for me.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "But things haven't", $EF, $EE, "been good for us.", $FA, $F7
    db $EF, $EE, "First, there was a", $EF, $EE, "traveling dealer", $FA, $F7
    db $EF, $EE, "who was terribly", $EF, $EE, "pushy and rude.", $FA, $F7
    db $EF, $EE, "He also stared at", $EF, $EE, "our belongings.", $FA, $F7
    db $EF, $EE, "We had to throw", $EF, $EE, "him out.", $F7
    db $F0

String_99_4B35_00_28:: ; heuristic: string; C0
Data_099_5BB6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Things haven't", $F1
    db "been good for us.", $FA, $F7
    db $EF, $EE, "There was a", $EF, $EE, "traveling dealer", $FA, $F7
    db $EF, $EE, "who was terribly", $EF, $EE, "pushy and rude.", $FA, $F7
    db $EF, $EE, "He also stared at", $EF, $EE, "our belongings.", $FA, $F7
    db $EF, $EE, "We had to throw", $EF, $EE, "him out.", $F7
    db $F0

String_99_4B35_00_29:: ; heuristic: string; C0
Data_099_5C63:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Thank you for", $F1
    db "recovering our", $FA, $F7
    db $EF, $EE, "daughter's ring.", $EF, $EE, "As a show of our", $FA, $F7
    db $EF, $EE, "thanks, would you", $EF, $EE, "accept this?", $F7
    db $F0

String_99_4B35_00_2A:: ; heuristic: string; C0
Data_099_5CCC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $F1
    db "SageRock.", $F7
    db $F0

String_99_4B35_00_2B:: ; heuristic: string; C0
Data_099_5CE5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $F1
    db "SageRock.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 gave back", $EF, $EE, "the SageRock.", $F7
    db $F0

String_99_4B35_00_2C:: ; heuristic: string; C0
Data_099_5D3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " We are grateful", $F1
    db "that you recovered", $FA, $F7
    db $EF, $EE, "our daughter's", $EF, $EE, "ring. As a show of", $FA, $F7
    db $EF, $EE, "our thanks, would", $EF, $EE, "you accept this?", $F7
    db $F0

String_99_4B35_00_2D:: ; heuristic: string; C0
Data_099_5DB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " We are grateful", $F1
    db "that you recovered", $FA, $F7
    db $EF, $EE, "our daughter's", $EF, $EE, "ring.", $F7
    db $F0

String_99_4B35_00_2E:: ; heuristic: string; C0
Data_099_5DF0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The old couple", $F1
    db "look happy after", $FA, $F7
    db $EF, $EE, "they got their", $EF, $EE, "treasure back.", $F7
    db $F0

String_99_4B35_00_2F:: ; heuristic: string; C0
Data_099_5E36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'm so glad the", $F1
    db "people across the", $FA, $F7
    db $EF, $EE, "way got back their", $EF, $EE, "stolen treasure.", $F7
    db $F0

String_99_4B35_00_30:: ; heuristic: string; C0
Data_099_5E83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What do those", $F1
    db "monsters do with", $FA, $F7
    db $EF, $EE, "the things that", $EF, $EE, "they steal?", $FA, $F7
    db $EF, $EE, "If it were me, I", $44, $EF, $EE, "act as a fence and", $FA, $F7
    db $EF, $EE, "sell them on the", $EF, $EE, "sly for big money", $A4, $FA, $F7
    db $EF, $EE, "I'm only joking!", $EF, $EE, "Just a joke!", $F7
    db $F0

String_99_4B35_00_31:: ; heuristic: string; C0
Data_099_5F38:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " I", $42, "e been", $F1
    db "checking around,", $FA, $F7
    db $EF, $EE, "and I think the", $EF, $EE, "evidence is clear.", $FA, $F7
    db $EF, $EE, "Somebody is behind", $EF, $EE, "the monsters.", $FA, $F7
    db $EF, $EE, "It's the work of a", $EF, $EE, "dark master.", $FA, $F7
    db $EF, $EE, "I don't know who", $EF, $EE, "it is, though.", $FA, $F7
    db $EF, $EE, "Do you have any", $EF, $EE, "idea who?", $F7
    db $F0

String_99_4B35_00_32:: ; heuristic: string; C0
Data_099_600D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I dug deep in my", $F1
    db "purse to buy from", $FA, $F7
    db $EF, $EE, "that dealer, but", $EF, $EE, "that ornament, it", $FA, $F7
    db $EF, $EE, "was the one stolen", $EF, $EE, "from my neighbor.", $FA, $F7
    db $EF, $EE, "What sort of", $EF, $EE, "nonsense is this?", $F7
    db $F0

String_99_4B35_00_33:: ; heuristic: string; C0
Data_099_60A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The thieving", $F1
    db "monsters had a", $FA, $F7
    db $EF, $EE, "boss, didn't they?", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "He must be a sly", $EF, $EE, "scoundrel to let", $FA, $F7
    db $EF, $EE, "his underlings do", $EF, $EE, "his dirty deeds.", $F7
    db $F0

String_99_4B35_00_34:: ; heuristic: string; C0
Data_099_612C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? Where", $44, " I", $F1
    db "get my wares?", $FA, $F7
    db $EF, $EE, "Uh", $A4, " Erm", $A4, " Whoops!", $EF, $EE, "Look at the time!", $FA, $F7
    db $EF, $EE, "Out of the way,", $EF, $EE, "I'm late!", $F7
    db $F0

String_99_4B35_00_35:: ; heuristic: string; C0
Data_099_6191:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That greedhound", $F1
    db "dealer scuttled", $FA, $F7
    db $EF, $EE, "off in an awful", $EF, $EE, "hurry.", $F7
    db $F0

String_99_4B35_00_36:: ; heuristic: string; C0
Data_099_61D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " I thought", $F1
    db "this forest looked", $FA, $F7
    db $EF, $EE, "suspicious, so I", $EF, $EE, "was investigating", $A4, $FA, $F7
    db $EF, $EE, "I was jumped from", $EF, $EE, "behind and my", $FA, $F7
    db $EF, $EE, "party was crushed", $EF, $EE, "just like that.", $FA, $F7
    db $EF, $EE, "A man, he looked", $EF, $EE, "like a dealer, was", $FA, $F7
    db $EF, $EE, "commanding the", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "He must have been", $EF, $EE, "the mastermind.", $FA, $F7
    db $EF, $EE, "The dark master", $EF, $EE, "went into the", $FA, $F7
    db $EF, $EE, "tower. Please go", $EF, $EE, "after him for me!", $F7
    db $F0

String_99_4B35_00_37:: ; heuristic: string; C0
Data_099_631E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " Please", $F1
    db "defeat the dark", $FA, $F7
    db $EF, $EE, "master and bring", $EF, $EE, "him to justice!", $F7
    db $F0

String_99_4B35_00_38:: ; heuristic: string; C0
Data_099_6365:: ; address name
    db $F0

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_99_6366::
MessageStrings_Bank7C_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_099_6366:: ; address name
    dw StringList_99_6368 ; id 0

; E-0217 (derived: category list of StringCategories_99_6366; one pointer per wStringIndex)
; record: string
StringList_99_6368::
Data_099_6368:: ; address name
    dw String_99_6366_00_00 ; id 0
    dw String_99_6366_00_01 ; id 1
    dw String_99_6366_00_02 ; id 2
    dw String_99_6366_00_03 ; id 3
    dw String_99_6366_00_04 ; id 4
    dw String_99_6366_00_05 ; id 5
    dw String_99_6366_00_06 ; id 6
    dw String_99_6366_00_07 ; id 7
    dw String_99_6366_00_08 ; id 8
    dw String_99_6366_00_09 ; id 9
    dw String_99_6366_00_0A ; id 10
    dw String_99_6366_00_0B ; id 11
    dw String_99_6366_00_0C ; id 12
    dw String_99_6366_00_0D ; id 13
    dw String_99_6366_00_0E ; id 14
    dw String_99_6366_00_0E ; id 15
    dw String_99_6366_00_0E ; id 16
    dw String_99_6366_00_0E ; id 17
    dw String_99_6366_00_0E ; id 18
    dw String_99_6366_00_0E ; id 19
    dw String_99_6366_00_0E ; id 20
    dw String_99_6366_00_0E ; id 21
    dw String_99_6366_00_0E ; id 22
    dw String_99_6366_00_0E ; id 23
    dw String_99_6366_00_0E ; id 24
    dw String_99_6366_00_0E ; id 25
    dw String_99_6366_00_1A ; id 26
    dw String_99_6366_00_1B ; id 27
    dw String_99_6366_00_1C ; id 28
    dw String_99_6366_00_1D ; id 29
    dw String_99_6366_00_1E ; id 30
    dw String_99_6366_00_1F ; id 31
    dw String_99_6366_00_20 ; id 32
    dw String_99_6366_00_21 ; id 33
    dw String_99_6366_00_22 ; id 34
    dw String_99_6366_00_23 ; id 35
    dw String_99_6366_00_24 ; id 36
    dw String_99_6366_00_24 ; id 37
    dw String_99_6366_00_26 ; id 38
    dw String_99_6366_00_27 ; id 39
    dw String_99_6366_00_28 ; id 40
    dw String_99_6366_00_29 ; id 41
    dw String_99_6366_00_2A ; id 42
    dw String_99_6366_00_2B ; id 43
    dw String_99_6366_00_2C ; id 44
    dw String_99_6366_00_2D ; id 45
    dw String_99_6366_00_2E ; id 46
    dw String_99_6366_00_2F ; id 47
    dw String_99_6366_00_30 ; id 48
    dw String_99_6366_00_31 ; id 49
    dw String_99_6366_00_32 ; id 50
    dw String_99_6366_00_33 ; id 51
    dw String_99_6366_00_34 ; id 52
    dw String_99_6366_00_35 ; id 53
    dw String_99_6366_00_36 ; id 54
    dw String_99_6366_00_37 ; id 55
    dw String_99_6366_00_38 ; id 56
    dw String_99_6366_00_39 ; id 57
    dw String_99_6366_00_3A ; id 58
    dw String_99_6366_00_3B ; id 59
    dw String_99_6366_00_3C ; id 60
    dw String_99_6366_00_3D ; id 61
    dw String_99_6366_00_3E ; id 62
    dw String_99_6366_00_3F ; id 63
    dw String_99_6366_00_3F ; id 64
    dw String_99_6366_00_41 ; id 65
    dw String_99_6366_00_42 ; id 66
    dw String_99_6366_00_43 ; id 67
    dw String_99_6366_00_44 ; id 68
    dw String_99_6366_00_45 ; id 69
    dw String_99_6366_00_46 ; id 70
    dw String_99_6366_00_47 ; id 71
    dw String_99_6366_00_48 ; id 72
    dw String_99_6366_00_49 ; id 73
    dw String_99_6366_00_4A ; id 74
    dw String_99_6366_00_4B ; id 75
    dw String_99_6366_00_4C ; id 76
    dw String_99_6366_00_4D ; id 77
    dw String_99_6366_00_4E ; id 78
    dw String_99_6366_00_4F ; id 79
    dw String_99_6366_00_50 ; id 80
    dw String_99_6366_00_51 ; id 81
    dw String_99_6366_00_52 ; id 82
    dw String_99_6366_00_53 ; id 83
    dw String_99_6366_00_53 ; id 84
    dw String_99_6366_00_53 ; id 85
    dw String_99_6366_00_53 ; id 86
    dw String_99_6366_00_53 ; id 87
    dw String_99_6366_00_53 ; id 88
    dw String_99_6366_00_53 ; id 89
    dw String_99_6366_00_53 ; id 90
    dw String_99_6366_00_53 ; id 91
    dw String_99_6366_00_53 ; id 92
    dw String_99_6366_00_53 ; id 93
    dw String_99_6366_00_53 ; id 94
    dw String_99_6366_00_53 ; id 95
    dw String_99_6366_00_53 ; id 96
    dw String_99_6366_00_53 ; id 97
    dw String_99_6366_00_53 ; id 98
    dw String_99_6366_00_63 ; id 99
    dw String_99_6366_00_63 ; id 100
    dw String_99_6366_00_63 ; id 101
    dw String_99_6366_00_63 ; id 102
    dw String_99_6366_00_63 ; id 103
    dw String_99_6366_00_63 ; id 104
    dw String_99_6366_00_63 ; id 105
    dw String_99_6366_00_63 ; id 106
    dw String_99_6366_00_63 ; id 107
    dw String_99_6366_00_63 ; id 108
    dw String_99_6366_00_63 ; id 109
    dw String_99_6366_00_63 ; id 110
    dw String_99_6366_00_63 ; id 111
    dw String_99_6366_00_63 ; id 112
    dw String_99_6366_00_63 ; id 113
    dw String_99_6366_00_63 ; id 114
    dw String_99_6366_00_63 ; id 115
    dw String_99_6366_00_63 ; id 116
    dw String_99_6366_00_63 ; id 117
    dw String_99_6366_00_63 ; id 118
    dw String_99_6366_00_63 ; id 119
    dw String_99_6366_00_63 ; id 120

String_99_6366_00_00:: ; heuristic: string; C0
Data_099_645A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained", $EF, $EE, "the MoonRock.", $F7
    db $F0

String_99_6366_00_01:: ; heuristic: string; C0
Data_099_6498:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "There was the", $EF, $EE, "MoonRock inside.", $FA, $F7
    db $EF, $EE, "But there was no", $EF, $EE, "room for it.", $F7
    db $F0

String_99_6366_00_02:: ; heuristic: string; C0
Data_099_64FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "It smelled of", $EF, $EE, "grilled fish.", $F7
    db $F0

String_99_6366_00_03:: ; heuristic: string; C0
Data_099_6537:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "merchandise.", $F7
    db $F0

String_99_6366_00_04:: ; heuristic: string; C0
Data_099_6575:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Welcome to the", $EF, $EE, "Port of Polona!", $FA, $F7
    db $EF, $EE, "Frolic with", $EF, $EE, "mermaids", $A4, $95, $F7
    db $F0

String_99_6366_00_05:: ; heuristic: string; C0
Data_099_65C7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "There were tourist", $EF, $EE, "pamphlets inside.", $FA, $F7
    db $EF, $EE, $95, "Infinitely clear", $EF, $EE, "blue waters and", $FA, $F7
    db $EF, $EE, "playful mermaids", $EF, $EE, "await you!", $95, $F7
    db $F0

String_99_6366_00_06:: ; heuristic: string; C0
Data_099_6651:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "Two shiny pots", $EF, $EE, "were inside.", $F7
    db $F0

String_99_6366_00_07:: ; heuristic: string; C0
Data_099_668B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " This is the", $F1
    db "mermaid kingdom.", $FA, $F7
    db $EF, $EE, "Did you want to go", $EF, $EE, "home?", $FF, $F0

String_99_6366_00_08:: ; heuristic: string; C0
Data_099_66C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Close your eyes", $F1
    db "for a little bit", $A4, $F7
    db $F0

String_99_6366_00_09:: ; heuristic: string; C0
Data_099_66EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh. Tell me if", $F1
    db "you want to go.", $F7
    db $F0

String_99_6366_00_0A:: ; heuristic: string; C0
Data_099_6712:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Aiyeeeeeh", $A4, $F1
    db $F7
    db $F0

String_99_6366_00_0B:: ; heuristic: string; C0
Data_099_6728:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "Your monsters", $F1
    db "appear dispirited", $A4, $FA, $F7
    db $EF, $EE, "It's unfortunate,", $EF, $EE, "but next time.", $F7
    db $F0

String_99_6366_00_0C:: ; heuristic: string; C0
Data_099_6772:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thick, suction-", $F1
    db "cupped tentacles", $FA, $F7
    db $EF, $EE, "snaked out of the", $EF, $EE, "whirlpool!", $F7
    db $F0

String_99_6366_00_0D:: ; heuristic: string; C0
Data_099_67B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The raging sea", $F1
    db "calmed, and the", $FA, $F7
    db $EF, $EE, "whirlpool smoothed", $EF, $EE, "to nothing.", $F7
    db $F0

String_99_6366_00_0E:: ; heuristic: string; C0
Data_099_67F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Father put up a", $F1
    db "bridge across to", $FA, $F7
    db $EF, $EE, "that tiny island.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "We have more room", $EF, $EE, "for monsters now.", $F7
    db $F0

String_99_6366_00_1A:: ; heuristic: string; C0
Data_099_685D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh? You'll run", $F1
    db "another errand?", $FF, $F0

String_99_6366_00_1B:: ; heuristic: string; C0
Data_099_687F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " My, what has", $F1
    db "gotten into you?", $FA, $F7
    db $EF, $EE, "Will miracles", $EF, $EE, "never cease?", $FA, $F7
    db $EF, $EE, "Could you go buy a", $EF, $EE, "Potion for me?", $FA, $F7
    db $EF, $EE, "Father's run down", $EF, $EE, "from overwork.", $F7
    db $F0

String_99_6366_00_1C:: ; heuristic: string; C0
Data_099_690A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mama handed over", $F1
    db "400G.", $F7
    db $F0

String_99_6366_00_1D:: ; heuristic: string; C0
Data_099_6922:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " No miracles", $F1
    db "today! Oh, well.", $FA, $F7
    db $EF, $EE, "Of course, off you", $EF, $EE, "go and play!", $F7
    db $F0

String_99_6366_00_1E:: ; heuristic: string; C0
Data_099_6967:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I need you to", $F1
    db "get me a Potion.", $F7
    db $F0

String_99_6366_00_1F:: ; heuristic: string; C0
Data_099_698A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh", $A4, " You", $42, "e found", $F1
    db "what I wanted.", $FA, $F7
    db $EF, $EE, "I knew I could", $EF, $EE, "count on you!", $F7
    db $F0

String_99_6366_00_20:: ; heuristic: string; C0
Data_099_69CE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Potion.", $F7
    db $F0

String_99_6366_00_21:: ; heuristic: string; C0
Data_099_69EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Well, could you", $F1
    db "go buy a Rib?", $FA, $F7
    db $EF, $EE, "It'll be a change", $EF, $EE, "from fish.", $F7
    db $F0

String_99_6366_00_22:: ; heuristic: string; C0
Data_099_6A2C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mama handed over", $F1
    db "600G.", $F7
    db $F0

String_99_6366_00_23:: ; heuristic: string; C0
Data_099_6A44:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I want you to", $F1
    db "buy me a Rib.", $F7
    db $F0

String_99_6366_00_24:: ; heuristic: string; C0
Data_099_6A64:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Rib.", $F7
    db $F0

String_99_6366_00_26:: ; heuristic: string; C0
Data_099_6A7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Thanks, ", $F9, "0!", $F1
    db "You're great help!", $F7
    db $F0

String_99_6366_00_27:: ; heuristic: string; C0
Data_099_6A9F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My father was a", $F1
    db "Slime and Mama was", $FA, $F7
    db $EF, $EE, "a MiniDrak, and", $EF, $EE, "I'm neither.", $FA, $F7
    db $EF, $EE, "When the parents", $EF, $EE, "are different, the", $FA, $F7
    db $EF, $EE, "offspring are", $EF, $EE, "different too.", $F7
    db $F0

String_99_6366_00_28:: ; heuristic: string; C0
Data_099_6B2F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Beavern helped", $F1
    db "put up the bridge.", $FA, $F7
    db $EF, $EE, "It's a solid piece", $EF, $EE, "of work, this!", $FA, $F7
    db $EF, $EE, "An underground", $EF, $EE, "stable is next,", $FA, $F7
    db $EF, $EE, "or at least if I", $EF, $EE, "can get help.", $FA, $F7
    db $EF, $EE, "Have you seen any", $EF, $EE, "MadGophers?", $FF, $F0

String_99_6366_00_29:: ; heuristic: string; C0
Data_099_6BE2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $44, " like to get", $F1
    db "help for digging.", $FA, $F7
    db $EF, $EE, "Could you befriend", $EF, $EE, "a MadGopher?", $F7
    db $F0

String_99_6366_00_2A:: ; heuristic: string; C0
Data_099_6C2B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If one joins", $F1
    db "you, could you", $FA, $F7
    db $EF, $EE, "bring it home to", $EF, $EE, "meet me?", $F7
    db $F0

String_99_6366_00_2B:: ; heuristic: string; C0
Data_099_6C69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A MadGopher", $F1
    db "joined you?", $FA, $F7
    db $EF, $EE, "Could you pass it", $EF, $EE, "over to me?", $FA, $F7
    db $EF, $EE, $A4, "But that will", $EF, $EE, "leave you alone", $A4, $F7
    db $F0

String_99_6366_00_2C:: ; heuristic: string; C0
Data_099_6CCB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A MadGopher", $F1
    db "joined you?", $FA, $F7
    db $EF, $EE, "Could you pass it", $EF, $EE, "over to me?", $FF, $F0

String_99_6366_00_2D:: ; heuristic: string; C0
Data_099_6D09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Great, ", $F9, "0!", $F1
    db "Thanks a lot!", $FA, $F7
    db $EF, $EE, "This will make the", $EF, $EE, "farm more useful!", $F7
    db $F0

String_99_6366_00_2E:: ; heuristic: string; C0
Data_099_6D4F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0, I need", $F1
    db "your help.", $FA, $F7
    db $EF, $EE, "Please get me a", $EF, $EE, "MadGopher.", $F7
    db $F0

String_99_6366_00_2F:: ; heuristic: string; C0
Data_099_6D88:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " MadGopher's been", $F1
    db "a great help.", $FA, $F7
    db $EF, $EE, "The excavation", $EF, $EE, "should go quickly.", $F7
    db $F0

String_99_6366_00_30:: ; heuristic: string; C0
Data_099_6DD0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e finished", $F1
    db "working.", $FA, $F7
    db $EF, $EE, "Can I go with you", $EF, $EE, "again?", $FF, $F0

String_99_6366_00_31:: ; heuristic: string; C0
Data_099_6E07:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm counting on", $F1
    db "you!", $F7
    db $F0

String_99_6366_00_32:: ; heuristic: string; C0
Data_099_6E1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "But you have no", $F1
    db "room for me", $A4, $F7
    db $F0

String_99_6366_00_33:: ; heuristic: string; C0
Data_099_6E41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Tch, I thought I", $F1
    db "could help you", $A4, $F7
    db $F0

String_99_6366_00_34:: ; heuristic: string; C0
Data_099_6E66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You have to tamp", $F1
    db "the ground firmly", $FA, $F7
    db $EF, $EE, "around where you", $EF, $EE, "do your digging.", $F7
    db $F0

String_99_6366_00_35:: ; heuristic: string; C0
Data_099_6EB3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0, what", $F1
    db "was it like in the", $FA, $F7
    db $EF, $EE, "other worlds?", $EF, $EE, "I", $44, " like to know.", $FA, $F7
    db $EF, $EE, $A4, "Oh", $A4, " Kameha's out", $EF, $EE, "there too.", $FA, $F7
    db $EF, $EE, "No wonder he hasn't", $EF, $EE, "been around.", $FA, $F7
    db $EF, $EE, "There's a bridge", $EF, $EE, "over to the next", $FA, $F7
    db $EF, $EE, "island, so the", $EF, $EE, "farm grew a bit", $FA, $F7
    db $EF, $EE, "bigger.", $EF, $EE, "So, what can I do", $FA, $F7
    db $EF, $EE, "for you, sis?", $EF, $EE, $F7
    db $F0

String_99_6366_00_36:: ; heuristic: string; C0
Data_099_6FB7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Big brother,", $F1
    db "tell me about your", $FA, $F7
    db $EF, $EE, "adventures in", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, $A4, "Oh", $A4, " The Prince is", $EF, $EE, "searching too.", $FA, $F7
    db $EF, $EE, "Papa put a bridge", $EF, $EE, "over to that tiny", $FA, $F7
    db $EF, $EE, "island, so the", $EF, $EE, "farm is bigger.", $FA, $F7
    db $EF, $EE, "You can leave more", $EF, $EE, "monsters now.", $FA, $F7
    db $EF, $EE, "Do you need me for", $EF, $EE, "anything?", $F7
    db $F0

String_99_6366_00_37:: ; heuristic: string; C0
Data_099_70B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Including the", $F1
    db "monsters with you,", $FA, $F7
    db $EF, $EE, "the farm can hold", $EF, $EE, "up to 30 now.", $FA, $F7
    db $EF, $EE, "Expansion added to", $EF, $EE, "capacity.", $FA, $F7
    db $EF, $EE, "Monsters in the", $EF, $EE, "farm earn some", $FA, $F7
    db $EF, $EE, "EX points as you", $EF, $EE, "battle.", $FA, $F7
    db $EF, $EE, "But if you leave", $EF, $EE, "them in the farm,", $FA, $F7
    db $EF, $EE, "they will grow", $EF, $EE, "without learning", $FA, $F7
    db $EF, $EE, "skills, and they", $EF, $EE, "turn disobedient.", $FA, $F7
    db $EF, $EE, "So, you should", $EF, $EE, "take different", $FA, $F7
    db $EF, $EE, "monsters out for", $EF, $EE, "training.", $F7
    db $F0

String_99_6366_00_38:: ; heuristic: string; C0
Data_099_7213:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master only", $F1
    db "makes me charge.", $FA, $F7
    db $EF, $EE, "It made me more", $EF, $EE, "courageous!", $F7
    db $F0

String_99_6366_00_39:: ; heuristic: string; C0
Data_099_7254:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We get more and", $F1
    db "more stubborn as", $FA, $F7
    db $EF, $EE, "we grow to higher", $EF, $EE, "levels.", $FA, $F7
    db $EF, $EE, "Our personalities", $EF, $EE, "don't change much,", $FA, $F7
    db $EF, $EE, "once we get old.", $EF, $EE, "Fwohohoho!", $F7
    db $F0

String_99_6366_00_3A:: ; heuristic: string; C0
Data_099_72DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey! You're the", $F1
    db "kid who said the", $FA, $F7
    db $EF, $EE, "island was going", $EF, $EE, "to sink!", $FA, $F7
    db $EF, $EE, "I believed you and", $EF, $EE, "sailed off, but", $FA, $F7
    db $EF, $EE, "the island's still", $EF, $EE, "here!", $FA, $F7
    db $EF, $EE, "You rotten little", $EF, $EE, "lie master!", $F7
    db $F0

String_99_6366_00_3B:: ; heuristic: string; C0
Data_099_7386:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I have nothing", $F1
    db "for a liar!", $F7
    db $F0

String_99_6366_00_3C:: ; heuristic: string; C0
Data_099_73A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " To take off an", $F1
    db "accessory, just", $FA, $F7
    db $EF, $EE, "put a different", $EF, $EE, "accessory on.", $FA, $F7
    db $EF, $EE, "Try equipping a", $EF, $EE, "D-Scale, that will", $FA, $F7
    db $EF, $EE, "remove whatever is", $EF, $EE, "equipped.", $FA, $F7
    db $EF, $EE, "It's common", $EF, $EE, "knowledge!", $F7
    db $F0

String_99_6366_00_3D:: ; heuristic: string; C0
Data_099_744C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The woman next", $F1
    db "to me, she repeats", $FA, $F7
    db $EF, $EE, "whatever she hears", $EF, $EE, "from other people", $FA, $F7
    db $EF, $EE, "and acts smart.", $EF, $EE, "What a Copycat", $A4, $F7
    db $F0

String_99_6366_00_3E:: ; heuristic: string; C0
Data_099_74BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I want to open", $F1
    db "up a shop here,", $FA, $F7
    db $EF, $EE, "but I need help", $EF, $EE, "unloading my ship.", $FA, $F7
    db $EF, $EE, "I heard an ArmyAnt", $EF, $EE, "can carry things", $FA, $F7
    db $EF, $EE, "much bigger than", $EF, $EE, "itself.", $FA, $F7
    db $EF, $EE, "Yep, an ArmyAnt", $EF, $EE, "would be helpful", $A4, $F7
    db $F0

String_99_6366_00_3F:: ; heuristic: string; C0
Data_099_7574:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wait! Could I", $F1
    db "get you to leave", $FA, $F7
    db $EF, $EE, "your Army Ant with", $EF, $EE, "me?", $FA, $F7
    db $EF, $EE, "Oh", $A4, " But that would", $EF, $EE, "leave you alone", $A4, $F7
    db $F0

String_99_6366_00_41:: ; heuristic: string; C0
Data_099_75DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wait! Could I", $F1
    db "get you to leave", $FA, $F7
    db $EF, $EE, "your Army Ant with", $EF, $EE, "me?", $FF, $F0

String_99_6366_00_42:: ; heuristic: string; C0
Data_099_7618:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fantastic! I can", $F1
    db "open my shop now!", $F7
    db $F0

String_99_6366_00_43:: ; heuristic: string; C0
Data_099_763F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh", $A4, " That's very", $F1
    db "disappointing.", $FA, $F7
    db $EF, $EE, "I could have my", $EF, $EE, "shop quickly too", $A4, $F7
    db $F0

String_99_6366_00_44:: ; heuristic: string; C0
Data_099_7687:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ArmyAnt helped", $F1
    db "me get my shop up.", $FA, $F7
    db $EF, $EE, "Would you care to", $EF, $EE, "see my wares?", $F7
    db $F0

String_99_6366_00_45:: ; heuristic: string; C0
Data_099_76D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome! How may", $F1
    db "I serve you?", $F7
    db $F0

String_99_6366_00_46:: ; heuristic: string; C0
Data_099_76F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "door.", $FA, $F7
    db $EF, $EE, "The door won't open", $EF, $EE, "with any key.", $F7
    db $F0

String_99_6366_00_47:: ; heuristic: string; C0
Data_099_772E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Many trees have", $F1
    db "submerged", $A4, $FA, $F7
    db $EF, $EE, "The island seems", $EF, $EE, "to be undergoing", $FA, $F7
    db $EF, $EE, "an unwelcome", $EF, $EE, "change", $A4, $F7
    db $F0

String_99_6366_00_48:: ; heuristic: string; C0
Data_099_778C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Um", $A4, " I'm the Egg", $F1
    db "Evaluator.", $FA, $F7
    db $EF, $EE, "You don't know who", $EF, $EE, "I am", $A4, " Right?", $FA, $F7
    db $EF, $EE, "Um", $A4, " All monsters", $EF, $EE, "hatch from eggs.", $FA, $F7
    db $EF, $EE, "I check your eggs", $EF, $EE, "to determine the", $FA, $F7
    db $EF, $EE, "gender of the", $EF, $EE, "monster inside.", $FA, $F7
    db $EF, $EE, "I can also sing a", $EF, $EE, "song to change the", $FA, $F7
    db $EF, $EE, "gender of the", $EF, $EE, "monster in an egg.", $FA, $F7
    db $EF, $EE, "May I help you in", $EF, $EE, "any way today?", $F7
    db $F0

String_99_6366_00_49:: ; heuristic: string; C0
Data_099_78AF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'm the Egg", $F1
    db "Evaluator.", $FA, $F7
    db $EF, $EE, "May I help you in", $EF, $EE, "any way today?", $F7
    db $F0

String_99_6366_00_4A:: ; heuristic: string; C0
Data_099_78EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Evaluator", $F1
    db "said I had an", $FA, $F7
    db $EF, $EE, "amazing egg.", $EF, $EE, "But I stumbled on", $FA, $F7
    db $EF, $EE, "the stairs and", $EF, $EE, "almost broke it.", $F7
    db $F0

String_99_6366_00_4B:: ; heuristic: string; C0
Data_099_7955:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Go down these", $F1
    db "stairs to the", $FA, $F7
    db $EF, $EE, "Starry Shrine.", $EF, $EE, $F7
    db $F0

String_99_6366_00_4C:: ; heuristic: string; C0
Data_099_7989:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "Starry Shrine.", $FA, $F7
    db $EF, $EE, "I'm Professor", $EF, $EE, "Monster.", $FA, $F7
    db $EF, $EE, "I have the run of", $EF, $EE, "the place while I", $FA, $F7
    db $EF, $EE, "study monsters and", $EF, $EE, "their breeding.", $FA, $F7
    db $EF, $EE, "I can help you", $EF, $EE, "breed monsters", $FA, $F7
    db $EF, $EE, "and hatch the eggs", $EF, $EE, "that result.", $FA, $F7
    db $EF, $EE, "So, what do you", $EF, $EE, "need of me today?", $F7
    db $F0

String_99_6366_00_4D:: ; heuristic: string; C0
Data_099_7A80:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "Starry Shrine.", $FA, $F7
    db $EF, $EE, "What do you need", $EF, $EE, "of me today?", $F7
    db $F0

String_99_6366_00_4E:: ; heuristic: string; C0
Data_099_7AC4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm the Prof's", $F1
    db "assistant.", $FA, $F7
    db $EF, $EE, "Do you want to", $EF, $EE, "hear about the", $FA, $F7
    db $EF, $EE, "Starry Shrine?", $EF, $EE, $FF, $F0

String_99_6366_00_4F:: ; heuristic: string; C0
Data_099_7B16:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You can breed", $F1
    db "monsters and hatch", $FA, $F7
    db $EF, $EE, "their eggs here at", $EF, $EE, "the Starry Shrine.", $FA, $F7
    db $EF, $EE, "Breeding happens", $EF, $EE, "when two monsters", $FA, $F7
    db $EF, $EE, "get married to", $EF, $EE, "each other.", $FA, $F7
    db $EF, $EE, "Their egg contains", $EF, $EE, "a monster that", $FA, $F7
    db $EF, $EE, "has the abilities", $EF, $EE, "of the parents.", $FA, $F7
    db $EF, $EE, "We can hatch that", $EF, $EE, "egg for you too.", $FA, $F7
    db $EF, $EE, "The parents will", $EF, $EE, "go away somewhere,", $FA, $F7
    db $EF, $EE, "but you won't lose", $EF, $EE, "accessories.", $FA, $F7
    db $EF, $EE, "Those get sent to", $EF, $EE, "the Vault.", $F7
    db $F0

String_99_6366_00_50:: ; heuristic: string; C0
Data_099_7C8A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Talk to the Prof", $F1
    db "if you need help.", $F7
    db $F0

String_99_6366_00_51:: ; heuristic: string; C0
Data_099_7CB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Breeding Guide", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "In breeding, the", $EF, $EE, "monster chosen as", $FA, $F7
    db $EF, $EE, "the base sets the", $EF, $EE, "baby's family.", $FA, $F7
    db $EF, $EE, "If a Slime family", $EF, $EE, "monster is chosen", $FA, $F7
    db $EF, $EE, "as the base, the", $EF, $EE, "baby will also be", $FA, $F7
    db $EF, $EE, "of the Slime", $EF, $EE, "family.", $FA, $F7
    db $EF, $EE, "And if a Dragon", $EF, $EE, "family monster is", $FA, $F7
    db $EF, $EE, "the base monster,", $EF, $EE, "the baby will also", $FA, $F7
    db $EF, $EE, "be of the Dragon", $EF, $EE, "family.", $95, $F7
    db $F0

String_99_6366_00_52:: ; heuristic: string; C0
Data_099_7E03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Breeding Guide", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "In breeding, the", $EF, $EE, "families and the", $FA, $F7
    db $EF, $EE, "species of the", $EF, $EE, "parents determine", $FA, $F7
    db $EF, $EE, "the species of the", $EF, $EE, "baby.", $FA, $F7
    db $EF, $EE, "Changing the mix", $EF, $EE, "of families and", $FA, $F7
    db $EF, $EE, "species results in", $EF, $EE, "different babies.", $95, $F7
    db $F0

String_99_6366_00_53:: ; heuristic: string; C0
Data_099_7EEC:: ; address name
    db $EA

String_99_6366_00_63:: ; heuristic: string; C0
Data_099_7EED:: ; address name
    db $F0
    ds $112, $00
