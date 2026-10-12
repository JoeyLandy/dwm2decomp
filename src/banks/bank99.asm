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

; string-pointer table for message bank $2D, strings from $D5 up (index minus $D5) (E-0080)
; address loaded by BeginStringDisplay_Bank2D_Overflow, CopyStringToBuffer_Bank2D_Overflow
MessageStrings_Bank2D_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_099_4070:: ; address name
    dw Data_099_4072

Data_099_4072:: ; heuristic: target of a monotone pointer table; C0
    dw Message_05_D5
    dw Message_05_D6
    dw Message_05_D7
    dw Message_05_D8
    dw Message_05_D9
    dw Message_05_DA
    dw Message_05_DB
    dw Message_05_DC
    dw Message_05_DD
    dw Message_05_DE
    dw Message_05_DF
    dw Message_05_E0
    dw Message_05_E1
    dw Message_05_E2
    dw Message_05_E3
    dw Message_05_E4
    dw Message_05_E5
    dw Message_05_E6
    dw Message_05_E7
    dw Message_05_E8
    dw Message_05_E9
    dw Message_05_EA
    dw Message_05_EB
    dw Message_05_EC
    dw Message_05_ED
    dw Message_05_EE
    dw Message_05_EF
    dw Message_05_F0
    dw Message_05_F1
    dw Message_05_F2
    dw Message_05_F3
    dw Message_05_F4
    dw Message_05_F5
    dw Message_05_F6
    dw Message_05_F7
    dw Message_05_F8
    dw Message_05_F9
    dw Message_05_FA
    dw Message_05_FB
    dw Message_05_FC
    dw Message_05_FD
    dw Message_05_FE
    dw Message_05_FF

Message_05_D5:: ; heuristic: string; C0
Data_099_40C8:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Make sure you", $F1
    db "tell the others ", $FA, $F7
    db $EF, $EE, "that I'm No. 1,", $EF, $EE, "do you understand?", $F7
    db $F0

Message_05_D6:: ; heuristic: string; C0
Data_099_4111:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm as plain as", $F1
    db "a baked potato.", $FA, $F7
    db $EF, $EE, "Even what I say is", $EF, $EE, "bland.", $F7
    db $F0

Message_05_D7:: ; heuristic: string; C0
Data_099_4152:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Isn't the weather", $F1
    db "fabulous?", $FA, $F7
    db $EF, $EE, "We need to be out", $EF, $EE, "traveling!", $F7
    db $F0

Message_05_D8:: ; heuristic: string; C0
Data_099_4192:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't be so", $F1
    db "obstinate?", $FA, $F7
    db $EF, $EE, "But I'm not!", $EF, $EE, "Huh? I'm acting it?", $F7
    db $F0

Message_05_D9:: ; heuristic: string; C0
Data_099_41CF:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Master, please", $F1
    db "consider saving", $FA, $F7
    db $EF, $EE, "your money, and", $EF, $EE, "not wasting it.", $F7
    db $F0

Message_05_DA:: ; heuristic: string; C0
Data_099_4216:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I plan to leave", $F1
    db "as I see fit.", $FA, $F7
    db $EF, $EE, "Leave me alone,", $EF, $EE, "please.", $F7
    db $F0

Message_05_DB:: ; heuristic: string; C0
Data_099_4254:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Meat, meat, give", $F1
    db "me meat!", $FA, $F7
    db $EF, $EE, "Or I won't work", $EF, $EE, "for you. Meat!", $F7
    db $F0

Message_05_DC:: ; heuristic: string; C0
Data_099_4294:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Know your enemy,", $F1
    db "know yourself,", $FA, $F7
    db $EF, $EE, "and you will win", $EF, $EE, "without danger.", $F7
    db $F0

Message_05_DD:: ; heuristic: string; C0
Data_099_42DD:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Use a mate as a", $F1
    db "shield, escape", $A4, $FA, $F7
    db $EF, $EE, "Whoops, uh", $A4, " nah,", $EF, $EE, "nothing", $A4, $F7
    db $F0

Message_05_DE:: ; heuristic: string; C0
Data_099_431F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Enemies deserve", $F1
    db "no mercy!", $FA, $F7
    db $EF, $EE, "Crush them with", $EF, $EE, "all our might!", $F7
    db $F0

Message_05_DF:: ; heuristic: string; C0
Data_099_4360:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $A4, " Um", $A4, " Shy", $A4, $F1
    db "Sorry", $A4, " I'm sorry", $A4, $F7
    db $F0

Message_05_E0:: ; heuristic: string; C0
Data_099_4381:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " For my partners,", $F1
    db "and most of all", $FA, $F7
    db $EF, $EE, "for you, master,", $EF, $EE, "I'll do my best!", $F7
    db $F0

Message_05_E1:: ; heuristic: string; C0
Data_099_43CB:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, no", $A4, $F1
    db "Must I go?", $FA, $F7
    db $EF, $EE, "Caves and dark", $EF, $EE, "places are scary", $A4, $F7
    db $F0

Message_05_E2:: ; heuristic: string; C0
Data_099_4407:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll clean, wash,", $F1
    db "whatever you wish!", $FA, $F7
    db $EF, $EE, "Just give me the", $EF, $EE, "word!", $F7
    db $F0

Message_05_E3:: ; heuristic: string; C0
Data_099_444A:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well, is seems", $F1
    db "to me, the world", $FA, $F7
    db $EF, $EE, "at large is pretty", $EF, $EE, "peaceful, ayup!", $F7
    db $F0

Message_05_E4:: ; heuristic: string; C0
Data_099_4495:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Is there any way", $F1
    db "of fighting while", $FA, $F7
    db $EF, $EE, "you're asleep?", $EF, $EE, "How ideal!", $F7
    db $F0

Message_05_E5:: ; heuristic: string; C0
Data_099_44D9:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The dark fire", $F1
    db "that spirals in my", $FA, $F7
    db $EF, $EE, "heart shall never", $EF, $EE, "be extinguished!", $F7
    db $F0

Message_05_E6:: ; heuristic: string; C0
Data_099_4525:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Seeing your joy", $F1
    db "adds to my own.", $F7
    db $F0

Message_05_E7:: ; heuristic: string; C0
Data_099_4549:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I will take care", $F1
    db "of you totally!", $F7
    db $F0

Message_05_E8:: ; heuristic: string; C0
Data_099_456E:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " World domination", $F1
    db "is the ultimate", $FA, $F7
    db $EF, $EE, "goal in my life!", $EF, $EE, $F7
    db $F0

Message_05_E9:: ; heuristic: string; C0
Data_099_45A9:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " However dire the", $F1
    db "situation, I will", $FA, $F7
    db $EF, $EE, "always shield you", $EF, $EE, "from danger.", $F7
    db $F0

Message_05_EA:: ; heuristic: string; C0
Data_099_45F3:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Human! You be", $F1
    db "grateful that I", $FA, $F7
    db $EF, $EE, "have even chosen", $EF, $EE, "to accompany you!", $F7
    db $F0

Message_05_EB:: ; heuristic: string; C0
Data_099_463C:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Even once, I", $F1
    db "would have liked", $FA, $F7
    db $EF, $EE, "to have been a", $EF, $EE, "hero", $A4, $F7
    db $F0

Message_05_EC:: ; heuristic: string; C0
Data_099_4677:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Fufufu", $A4, " Perhaps", $F1
    db "we will be enemies", $FA, $F7
    db $EF, $EE, "if we meet again", $EF, $EE, "in the future.", $F7
    db $F0

Message_05_ED:: ; heuristic: string; C0
Data_099_46C2:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " For you, master,", $F1
    db "I will leap into", $FA, $F7
    db $EF, $EE, "a pool of fire, if", $EF, $EE, "you so command me.", $F7
    db $F0

Message_05_EE:: ; heuristic: string; C0
Data_099_4712:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Excitement,", $F1
    db "tension", $A4, $FA, $F7
    db $EF, $EE, "They are emotions", $EF, $EE, "without meaning.", $F7
    db $F0

Message_05_EF:: ; heuristic: string; C0
Data_099_4752:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " People and", $F1
    db "monsters should be", $FA, $F7
    db $EF, $EE, "punished alike for", $EF, $EE, "sins they commit.", $F7
    db $F0

Message_05_F0:: ; heuristic: string; C0
Data_099_479D:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Give me the", $F1
    db "chance to shine.", $FA, $F7
    db $EF, $EE, "I will protect you", $EF, $EE, "if you do.", $F7
    db $F0

Message_05_F1:: ; heuristic: string; C0
Data_099_47E0:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I am the Lord of", $F1
    db "the monsters!", $FA, $F7
    db $EF, $EE, "What? Too plain?", $EF, $EE, "You think so?", $F7
    db $F0

Message_05_F2:: ; heuristic: string; C0
Data_099_4826:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Are there no", $F1
    db "unbreakable toys ", $FA, $F7
    db $EF, $EE, "that will keep", $EF, $EE, "coming back?", $F7
    db $F0

Message_05_F3:: ; heuristic: string; C0
Data_099_4869:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't bother me", $A4, $F1
    db "Leave me be", $A4, $F7
    db $F0

Message_05_F4:: ; heuristic: string; C0
Data_099_488A:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Let me conquer a", $F1
    db "world for you, eh?", $F7
    db $F0

Message_05_F5:: ; heuristic: string; C0
Data_099_48B2:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " To be conquered", $F1
    db "by me is to know", $FA, $F7
    db $EF, $EE, "happiness!", $EF, $EE, "Hahahahahah!", $F7
    db $F0

Message_05_F6:: ; heuristic: string; C0
Data_099_48F3:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The world is", $F1
    db "mine!", $FA, $F7
    db $EF, $EE, "That is the way it", $EF, $EE, "has to be!", $F7
    db $F0

Message_05_F7:: ; heuristic: string; C0
Data_099_492C:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Everything is", $F1
    db "according to plan.", $FA, $F7
    db $EF, $EE, "Nothing unexpected", $EF, $EE, "can happen.", $F7
    db $F0

Message_05_F8:: ; heuristic: string; C0
Data_099_4974:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can be the", $F1
    db "decoy. I'll strike", $FA, $F7
    db $EF, $EE, "while you're under", $EF, $EE, "attack. How's that?", $F7
    db $F0

Message_05_F9:: ; heuristic: string; C0
Data_099_49C2:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The feelings of", $F1
    db "hatred and sorrow", $FA, $F7
    db $EF, $EE, "become my power.", $EF, $EE, $F7
    db $F0

Message_05_FA:: ; heuristic: string; C0
Data_099_49FE:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Traveling is", $F1
    db "fine, but quietly", $FA, $F7
    db $EF, $EE, "reading is also", $EF, $EE, "pleasant", $A4, $F7
    db $F0

Message_05_FB:: ; heuristic: string; C0
Data_099_4A3F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " All my power, I", $F1
    db "will use for you", $A4, $F7
    db $F0

Message_05_FC:: ; heuristic: string; C0
Data_099_4A65:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The p-power of", $F1
    db "heroes is scary", $A4, $F7
    db $F0

Message_05_FD:: ; heuristic: string; C0
Data_099_4A89:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you would", $F1
    db "allow it, I wish", $FA, $F7
    db $EF, $EE, "to conquer this", $EF, $EE, "world.", $F7
    db $F0

Message_05_FE:: ; heuristic: string; C0
Data_099_4AC6:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Life isn't bad!", $F1
    db "Take it easy,", $FA, $F7
    db $EF, $EE, "slow down, relax", $EF, $EE, "and enjoy!", $F7
    db $F0

Message_05_FF:: ; heuristic: string; C0
Data_099_4B07:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I can't be", $F1
    db "bothered to chat", $A4, $FA, $F7
    db $EF, $EE, "Be gone", $A4, $EF, $EE, $F7
    db $F0

; string-pointer table for message bank $2E, strings from $A6 up (index minus $A6) (E-0080)
; address loaded by BeginStringDisplay_Bank2E_Overflow, CopyStringToBuffer_Bank2E_Overflow
MessageStrings_Bank2E_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_099_4B35:: ; address name
    dw Data_099_4B37

Data_099_4B37:: ; heuristic: target of a monotone pointer table; C0
    dw Message_06_A6
    dw Message_06_A7
    dw Message_06_A8
    dw Message_06_A9
    dw Message_06_AA
    dw Message_06_AB
    dw Message_06_AC
    dw Message_06_AD
    dw Message_06_AE
    dw Message_06_AF
    dw Message_06_B0
    dw Message_06_B1
    dw Message_06_B2
    dw Message_06_B3
    dw Message_06_B4
    dw Message_06_B5
    dw Message_06_B6
    dw Message_06_B7
    dw Message_06_B8
    dw Message_06_B9
    dw Message_06_BA
    dw Message_06_BB
    dw Message_06_BC
    dw Message_06_BD
    dw Message_06_BE
    dw Message_06_BE
    dw Message_06_C0
    dw Message_06_C1
    dw Message_06_C2
    dw Message_06_C3
    dw Message_06_C4
    dw Message_06_C5
    dw Message_06_C6
    dw Message_06_C7
    dw Message_06_C8
    dw Message_06_C9
    dw Message_06_CA
    dw Message_06_CB
    dw Message_06_CC
    dw Message_06_CD
    dw Message_06_CE
    dw Message_06_CF
    dw Message_06_D0
    dw Message_06_D1
    dw Message_06_D2
    dw Message_06_D3
    dw Message_06_D4
    dw Message_06_D5
    dw Message_06_D6
    dw Message_06_D7
    dw Message_06_D8
    dw Message_06_D9
    dw Message_06_DA
    dw Message_06_DB
    dw Message_06_DC
    dw Message_06_DD
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE
    dw Message_06_DE

Message_06_A6:: ; heuristic: string; C0
Data_099_4BEB:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our daughter's", $F1
    db "only memento was", $FA, $F7
    db $EF, $EE, "taken from us by", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "I'm losing the will", $EF, $EE, "to keep living", $A4, $F7
    db $F0

Message_06_A7:: ; heuristic: string; C0
Data_099_4C54:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It doesn't look", $F1
    db "like the monsters", $FA, $F7
    db $EF, $EE, "are coming from", $EF, $EE, "anywhere close.", $FA, $F7
    db $EF, $EE, "You ought to pay a", $EF, $EE, "visit to the hut", $FA, $F7
    db $EF, $EE, "by the spring in", $EF, $EE, "the west.", $FA, $F7
    db $EF, $EE, "It's for use by", $EF, $EE, "travelers.", $FA, $F7
    db $EF, $EE, "You might talk to", $EF, $EE, "them for clues.", $F7
    db $F0

Message_06_A8:: ; heuristic: string; C0
Data_099_4D28:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The old couple", $F1
    db "across the way", $FA, $F7
    db $EF, $EE, "were robbed of a", $EF, $EE, "precious item.", $FA, $F7
    db $EF, $EE, "That's why they", $EF, $EE, "were so sad.", $F7
    db $F0

Message_06_A9:: ; heuristic: string; C0
Data_099_4D8E:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "traveler's hut.", $FA, $F7
    db $EF, $EE, "Stay and rest your", $EF, $EE, "feet a while.", $F7
    db $F0

Message_06_AA:: ; heuristic: string; C0
Data_099_4DD2:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That dealer,", $F1
    db "how expensive!", $FA, $F7
    db $EF, $EE, "Nobody can afford", $EF, $EE, "what he sells!", $FA, $F7
    db $EF, $EE, "But he does have", $EF, $EE, "super merchandise", $A4, $F7
    db $F0

Message_06_AB:: ; heuristic: string; C0
Data_099_4E3F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lately, the town", $F1
    db "of Miagen has been", $FA, $F7
    db $EF, $EE, "hit by plundering", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "Did you know that?", $EF, $EE
    db $FF, $F0

Message_06_AC:: ; heuristic: string; C0
Data_099_4E9F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's rumored that", $F1
    db "monsters raid the", $FA, $F7
    db $EF, $EE, "town by scaling", $EF, $EE, "the mountain range", $FA, $F7
    db $EF, $EE, "to the north.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "I think there was", $EF, $EE, "a forest nearby.", $FA, $F7
    db $EF, $EE, "Perhaps they came", $EF, $EE, "from that forest.", $FA, $F7
    db $EF, $EE, "The forest is east", $EF, $EE, "from here.", $F7
    db $F0

Message_06_AD:: ; heuristic: string; C0
Data_099_4F72:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You didn't know?", $F1
    db "Well, listen up.", $FA, $F7
    db $EF, $EE, "Go to the town of", $EF, $EE, "Miagen.", $FA, $F7
    db $EF, $EE, "The townspeople", $EF, $EE, "are in an uproar.", $F7
    db $F0

Message_06_AE:: ; heuristic: string; C0
Data_099_4FDB:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That dealer's", $F1
    db "wares", $A4, $FA, $F7
    db $EF, $EE, "Could he sell any", $EF, $EE, "at those prices?", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like to make", $EF, $EE, "money like that", $A4, $F7
    db $F0

Message_06_AF:: ; heuristic: string; C0
Data_099_503F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How does this", $F1
    db "ornament look?", $FA, $F7
    db $EF, $EE, "Take it home for", $EF, $EE, "just 12,000G.", $FA, $F7
    db $EF, $EE, "You say that's too", $EF, $EE, "much?", $FA, $F7
    db $EF, $EE, "Heh, scram if you", $EF, $EE, "have no money.", $F7
    db $F0

Message_06_B0:: ; heuristic: string; C0
Data_099_50C4:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How does this", $F1
    db "jewelry look?", $FA, $F7
    db $EF, $EE, "It's yours for a", $EF, $EE, "mere 18,000G.", $FA, $F7
    db $EF, $EE, "You say that's too", $EF, $EE, "much?", $FA, $F7
    db $EF, $EE, "Heh, scram if you", $EF, $EE, "have no money.", $F7
    db $F0

Message_06_B1:: ; heuristic: string; C0
Data_099_5147:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How does this", $F1
    db "grand vase look?", $FA, $F7
    db $EF, $EE, "A bargain at", $EF, $EE, "23,000G!", $FA, $F7
    db $EF, $EE, "You say that's too", $EF, $EE, "much?", $FA, $F7
    db $EF, $EE, "Heh, scram if you", $EF, $EE, "have no money.", $F7
    db $F0

Message_06_B2:: ; heuristic: string; C0
Data_099_51C5:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e no use for", $F1
    db "the poor.", $FA, $F7
    db $EF, $EE, "Come back if you", $EF, $EE, "make some money.", $F7
    db $F0

Message_06_B3:: ; heuristic: string; C0
Data_099_5208:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How does this", $F1
    db "ornament look?", $FA, $F7
    db $EF, $EE, "Take it home for", $EF, $EE, "just 12,000G.", $FA, $F7
    db $EF, $EE, "What? Monsters?", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Get lost if you're", $EF, $EE, "not buying!", $F7
    db $F0

Message_06_B4:: ; heuristic: string; C0
Data_099_5284:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How does this", $F1
    db "jewelry look?", $FA, $F7
    db $EF, $EE, "It's yours for a", $EF, $EE, "mere 18,000G.", $FA, $F7
    db $EF, $EE, "What? Monsters?", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "I don't have time", $EF, $EE, "to play games!", $F7
    db $F0

Message_06_B5:: ; heuristic: string; C0
Data_099_5300:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How does this", $F1
    db "grand vase look?", $FA, $F7
    db $EF, $EE, "A bargain at", $EF, $EE, "23,000G!", $FA, $F7
    db $EF, $EE, "What? Monsters?", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "If you're not a", $EF, $EE, "customer, beat it!", $F7
    db $F0

Message_06_B6:: ; heuristic: string; C0
Data_099_5379:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This pendant is", $F1
    db "yours for 38,000G", $A4, $FA, $F7
    db $EF, $EE, "What? Monsters?", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "I don't know a", $EF, $EE, "thing about that!", $FA, $F7
    db $EF, $EE, "You're bad for", $EF, $EE, "business, vamoose!", $F7
    db $F0

Message_06_B7:: ; heuristic: string; C0
Data_099_53FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The tower's entry", $F1
    db "is sealed tight.", $F7
    db $F0

Message_06_B8:: ; heuristic: string; C0
Data_099_5422:: ; address name
    db $EA, $45, $90, $20, $2B, $32, $90, $24, $35, $28, $90, $3C, $32, $38, $98, $F1
    db $FA, $F7, $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You shouldn't be", $EF, $EE, "meddling here!", $F7
    db $F0

Message_06_B9:: ; heuristic: string; C0
Data_099_5458:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're going to", $F1
    db "regret seeing us.", $FA, $F7
    db $EF, $EE, "We can't let you", $EF, $EE, "go blab. Gwaaaaah!", $F7
    db $F0

Message_06_BA:: ; heuristic: string; C0
Data_099_54A4:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What, not you", $F1
    db "again!", $F7
    db $F0

Message_06_BB:: ; heuristic: string; C0
Data_099_54BD:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We'll smash you", $F1
    db "as often as it", $FA, $F7
    db $EF, $EE, "takes to make you", $EF, $EE, "stop meddling!", $F7
    db $F0

Message_06_BC:: ; heuristic: string; C0
Data_099_5504:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Please! Mercy!", $F1
    db "Spare us!", $FA, $F7
    db $EF, $EE, "Take back every-", $EF, $EE, "thing we took!", $F7
    db $F0

Message_06_BD:: ; heuristic: string; C0
Data_099_5545:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, "Pretty Ring.", $F7
    db $F0

Message_06_BE:: ; heuristic: string; C0
Data_099_5585:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 found the", $F1
    db "Pretty Ring.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Pretty Ring back.", $F7
    db $F0

Message_06_C0:: ; heuristic: string; C0
Data_099_55E2:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I dug deep in my", $F1
    db "purse to buy from", $FA, $F7
    db $EF, $EE, "that dealer, but", $EF, $EE, "it feel very odd.", $FA, $F7
    db $EF, $EE, "What I buy look", $EF, $EE, "very familiar.", $FA, $F7
    db $EF, $EE, "I don't know why.", $EF, $EE, "I will remember.", $F7
    db $F0

Message_06_C1:: ; heuristic: string; C0
Data_099_5679:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? Monsters", $F1
    db "attacked you in", $FA, $F7
    db $EF, $EE, "the northern", $EF, $EE, "forest?", $FA, $F7
    db $EF, $EE, "I'm surprised to", $EF, $EE, "see you alive.", $FA, $F7
    db $EF, $EE, "Um", $A4, " Are you maybe", $EF, $EE, "really tough?", $F7
    db $F0

Message_06_C2:: ; heuristic: string; C0
Data_099_56FC:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That dealer is a", $F1
    db "greedy hound!", $FA, $F7
    db $EF, $EE, "He won't tell me", $EF, $EE, "where he gets his", $FA, $F7
    db $EF, $EE, "merchandise, the", $EF, $EE, "cheapskate!", $F7
    db $F0

Message_06_C3:: ; heuristic: string; C0
Data_099_5766:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " For 47,000G this", $F1
    db "earring", $A4, " What?", $FA, $F7
    db $EF, $EE, "You went to the", $EF, $EE, "northern forest?", $FA, $F7
    db $EF, $EE, "Monsters didn't", $EF, $EE, "attack you?", $F7
    db $F0

Message_06_C4:: ; heuristic: string; C0
Data_099_57CE:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You defeated the", $F1
    db "monsters?", $FA, $F7
    db $EF, $EE, "You're not joking,", $EF, $EE, "are you?", $F7
    db $F0

Message_06_C5:: ; heuristic: string; C0
Data_099_580C:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You defeated the", $F1
    db "monsters", $A4, $FA, $F7
    db $EF, $EE, $A4, "You're not joking,", $EF, $EE, "are you?", $F7
    db $F0

Message_06_C6:: ; heuristic: string; C0
Data_099_584B:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Are you Milayou's", $F1
    db "friend?", $FA, $F7
    db $EF, $EE, "The little monster", $EF, $EE, "master?", $FA, $F7
    db $EF, $EE, "You're after the", $EF, $EE, "bad monsters aren't", $FA, $F7
    db $EF, $EE, "you? That is just", $EF, $EE, "so neat!", $F7
    db $F0

Message_06_C7:: ; heuristic: string; C0
Data_099_58CD:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If a monster", $F1
    db "could be good or", $FA, $F7
    db $EF, $EE, "bad, does that", $EF, $EE, "mean there are", $FA, $F7
    db $EF, $EE, "both good masters", $EF, $EE, "and bad ones?", $F7
    db $F0

Message_06_C8:: ; heuristic: string; C0
Data_099_5935:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't you think", $F1
    db "it's odd that the", $FA, $F7
    db $EF, $EE, "monsters are after", $EF, $EE, "treasures?", $FA, $F7
    db $EF, $EE, "I can understand", $EF, $EE, "if they went for", $FA, $F7
    db $EF, $EE, "food, but", $A4, $EF, $EE, $F7
    db $F0

Message_06_C9:: ; heuristic: string; C0
Data_099_59B1:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Arrrgh! This is", $F1
    db "so infuriating!", $FA, $F7
    db $EF, $EE, "The monsters took", $EF, $EE, "my lingerie again!", $FA, $F7
    db $EF, $EE, "What exactly would", $EF, $EE, "they want with my", $FA, $F7
    db $EF, $EE, "underwear anyway?", $EF, $EE, "It makes no sense!", $F7
    db $F0

Message_06_CA:: ; heuristic: string; C0
Data_099_5A50:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 showed the", $F1
    db "Pretty Ring.", $F7
    db $F0

Message_06_CB:: ; heuristic: string; C0
Data_099_5A6C:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah", $A4, " That ring", $A4, $F1
    db "Is", $A4, " Is it", $A4, $FA, $F7
    db $EF, $EE, "That's my daughter's", $EF, $EE, "ring!", $F7
    db $F0

Message_06_CC:: ; heuristic: string; C0
Data_099_5AA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Pretty Ring.", $F7
    db $F0

Message_06_CD:: ; heuristic: string; C0
Data_099_5AC8:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Thank you for", $F1
    db "getting the ring", $FA, $F7
    db $EF, $EE, "back for me.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But things haven't", $EF, $EE, "been good for us.", $FA, $F7
    db $EF, $EE, "First, there was a", $EF, $EE, "traveling dealer", $FA, $F7
    db $EF, $EE, "who was terribly", $EF, $EE, "pushy and rude.", $FA, $F7
    db $EF, $EE, "He also stared at", $EF, $EE, "our belongings.", $FA, $F7
    db $EF, $EE, "We had to throw", $EF, $EE, "him out.", $F7
    db $F0

Message_06_CE:: ; heuristic: string; C0
Data_099_5BB6:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Things haven't", $F1
    db "been good for us.", $FA, $F7
    db $EF, $EE, "There was a", $EF, $EE, "traveling dealer", $FA, $F7
    db $EF, $EE, "who was terribly", $EF, $EE, "pushy and rude.", $FA, $F7
    db $EF, $EE, "He also stared at", $EF, $EE, "our belongings.", $FA, $F7
    db $EF, $EE, "We had to throw", $EF, $EE, "him out.", $F7
    db $F0

Message_06_CF:: ; heuristic: string; C0
Data_099_5C63:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Thank you for", $F1
    db "recovering our", $FA, $F7
    db $EF, $EE, "daughter's ring.", $EF, $EE, "As a show of our", $FA, $F7
    db $EF, $EE, "thanks, would you", $EF, $EE, "accept this?", $F7
    db $F0

Message_06_D0:: ; heuristic: string; C0
Data_099_5CCC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $F1
    db "SageRock.", $F7
    db $F0

Message_06_D1:: ; heuristic: string; C0
Data_099_5CE5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received a", $F1
    db "SageRock.", $FA, $F7
    db $EF, $EE, "But there is no", $EF, $EE, "room for it.", $FA, $F7
    db $EF, $EE, $F9, "0 gave back", $EF, $EE, "the SageRock.", $F7
    db $F0

Message_06_D2:: ; heuristic: string; C0
Data_099_5D3E:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We are grateful", $F1
    db "that you recovered", $FA, $F7
    db $EF, $EE, "our daughter's", $EF, $EE, "ring. As a show of", $FA, $F7
    db $EF, $EE, "our thanks, would", $EF, $EE, "you accept this?", $F7
    db $F0

Message_06_D3:: ; heuristic: string; C0
Data_099_5DB1:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We are grateful", $F1
    db "that you recovered", $FA, $F7
    db $EF, $EE, "our daughter's", $EF, $EE, "ring.", $F7
    db $F0

Message_06_D4:: ; heuristic: string; C0
Data_099_5DF0:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The old couple", $F1
    db "look happy after", $FA, $F7
    db $EF, $EE, "they got their", $EF, $EE, "treasure back.", $F7
    db $F0

Message_06_D5:: ; heuristic: string; C0
Data_099_5E36:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm so glad the", $F1
    db "people across the", $FA, $F7
    db $EF, $EE, "way got back their", $EF, $EE, "stolen treasure.", $F7
    db $F0

Message_06_D6:: ; heuristic: string; C0
Data_099_5E83:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What do those", $F1
    db "monsters do with", $FA, $F7
    db $EF, $EE, "the things that", $EF, $EE, "they steal?", $FA, $F7
    db $EF, $EE, "If it were me, I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EF, $EE, "act as a fence and", $FA, $F7
    db $EF, $EE, "sell them on the", $EF, $EE, "sly for big money", $A4, $FA, $F7
    db $EF, $EE, "I'm only joking!", $EF, $EE, "Just a joke!", $F7
    db $F0

Message_06_D7:: ; heuristic: string; C0
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

Message_06_D8:: ; heuristic: string; C0
Data_099_600D:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I dug deep in my", $F1
    db "purse to buy from", $FA, $F7
    db $EF, $EE, "that dealer, but", $EF, $EE, "that ornament, it", $FA, $F7
    db $EF, $EE, "was the one stolen", $EF, $EE, "from my neighbor.", $FA, $F7
    db $EF, $EE, "What sort of", $EF, $EE, "nonsense is this?", $F7
    db $F0

Message_06_D9:: ; heuristic: string; C0
Data_099_60A7:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The thieving", $F1
    db "monsters had a", $FA, $F7
    db $EF, $EE, "boss, didn't they?", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "He must be a sly", $EF, $EE, "scoundrel to let", $FA, $F7
    db $EF, $EE, "his underlings do", $EF, $EE, "his dirty deeds.", $F7
    db $F0

Message_06_DA:: ; heuristic: string; C0
Data_099_612C:: ; address name
    db $EA, $45, $90, $20, $2B, $24, $37, $98, $90, $20, $2B, $28, $35, $28, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $F1
    db "get my wares?", $FA, $F7
    db $EF, $EE, "Uh", $A4, " Erm", $A4, " Whoops!", $EF, $EE, "Look at the time!", $FA, $F7
    db $EF, $EE, "Out of the way,", $EF, $EE, "I'm late!", $F7
    db $F0

Message_06_DB:: ; heuristic: string; C0
Data_099_6191:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That greedhound", $F1
    db "dealer scuttled", $FA, $F7
    db $EF, $EE, "off in an awful", $EF, $EE, "hurry.", $F7
    db $F0

Message_06_DC:: ; heuristic: string; C0
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

Message_06_DD:: ; heuristic: string; C0
Data_099_631E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " Please", $F1
    db "defeat the dark", $FA, $F7
    db $EF, $EE, "master and bring", $EF, $EE, "him to justice!", $F7
    db $F0

Message_06_DE:: ; heuristic: string; C0
Data_099_6365:: ; address name
    db $F0

; string-pointer table for message bank $7C, strings from $87 up (index minus $87) (E-0080)
; address loaded by BeginStringDisplay_Bank7C_Overflow, CopyStringToBuffer_Bank7C_Overflow
MessageStrings_Bank7C_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_099_6366:: ; address name
    dw Data_099_6368

Data_099_6368:: ; heuristic: target of a monotone pointer table; C0
    dw Message_08_87
    dw Message_08_88
    dw Message_08_89
    dw Message_08_8A
    dw Message_08_8B
    dw Message_08_8C
    dw Message_08_8D
    dw Message_08_8E
    dw Message_08_8F
    dw Message_08_90
    dw Message_08_91
    dw Message_08_92
    dw Message_08_93
    dw Message_08_94
    dw Message_08_95
    dw Message_08_95
    dw Message_08_95
    dw Message_08_95
    dw Message_08_95
    dw Message_08_95
    dw Message_08_95
    dw Message_08_95
    dw Message_08_95
    dw Message_08_95
    dw Message_08_95
    dw Message_08_95
    dw Message_08_A1
    dw Message_08_A2
    dw Message_08_A3
    dw Message_08_A4
    dw Message_08_A5
    dw Message_08_A6
    dw Message_08_A7
    dw Message_08_A8
    dw Message_08_A9
    dw Message_08_AA
    dw Message_08_AB
    dw Message_08_AB
    dw Message_08_AD
    dw Message_08_AE
    dw Message_08_AF
    dw Message_08_B0
    dw Message_08_B1
    dw Message_08_B2
    dw Message_08_B3
    dw Message_08_B4
    dw Message_08_B5
    dw Message_08_B6
    dw Message_08_B7
    dw Message_08_B8
    dw Message_08_B9
    dw Message_08_BA
    dw Message_08_BB
    dw Message_08_BC
    dw Message_08_BD
    dw Message_08_BE
    dw Message_08_BF
    dw Message_08_C0
    dw Message_08_C1
    dw Message_08_C2
    dw Message_08_C3
    dw Message_08_C4
    dw Message_08_C5
    dw Message_08_C6
    dw Message_08_C6
    dw Message_08_C8
    dw Message_08_C9
    dw Message_08_CA
    dw Message_08_CB
    dw Message_08_CC
    dw Message_08_CD
    dw Message_08_CE
    dw Message_08_CF
    dw Message_08_D0
    dw Message_08_D1
    dw Message_08_D2
    dw Message_08_D3
    dw Message_08_D4
    dw Message_08_D5
    dw Message_08_D6
    dw Message_08_D7
    dw Message_08_D8
    dw Message_08_D9
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_DA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA
    dw Message_08_EA

Message_08_87:: ; heuristic: string; C0
Data_099_645A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained", $EF, $EE, "the MoonRock.", $F7
    db $F0

Message_08_88:: ; heuristic: string; C0
Data_099_6498:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "There was the", $EF, $EE, "MoonRock inside.", $FA, $F7
    db $EF, $EE, "But there was no", $EF, $EE, "room for it.", $F7
    db $F0

Message_08_89:: ; heuristic: string; C0
Data_099_64FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "It smelled of", $EF, $EE, "grilled fish.", $F7
    db $F0

Message_08_8A:: ; heuristic: string; C0
Data_099_6537:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "merchandise.", $F7
    db $F0

Message_08_8B:: ; heuristic: string; C0
Data_099_6575:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Welcome to the", $EF, $EE, "Port of Polona!", $FA, $F7
    db $EF, $EE, "Frolic with", $EF, $EE, "mermaids", $A4, $95, $F7
    db $F0

Message_08_8C:: ; heuristic: string; C0
Data_099_65C7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "There were tourist", $EF, $EE, "pamphlets inside.", $FA, $F7
    db $EF, $EE, $95, "Infinitely clear", $EF, $EE, "blue waters and", $FA, $F7
    db $EF, $EE, "playful mermaids", $EF, $EE, "await you!", $95, $F7
    db $F0

Message_08_8D:: ; heuristic: string; C0
Data_099_6651:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "Two shiny pots", $EF, $EE, "were inside.", $F7
    db $F0

Message_08_8E:: ; heuristic: string; C0
Data_099_668B:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "mermaid kingdom.", $FA, $F7
    db $EF, $EE, "Did you want to go", $EF, $EE, "home?"
    db $FF, $F0

Message_08_8F:: ; heuristic: string; C0
Data_099_66C9:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Close your eyes", $F1
    db "for a little bit", $A4, $F7
    db $F0

Message_08_90:: ; heuristic: string; C0
Data_099_66EF:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh. Tell me if", $F1
    db "you want to go.", $F7
    db $F0

Message_08_91:: ; heuristic: string; C0
Data_099_6712:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Aiyeeeeeh", $A4, $F1
    db $F7
    db $F0

Message_08_92:: ; heuristic: string; C0
Data_099_6728:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Your monsters", $F1
    db "appear dispirited", $A4, $FA, $F7
    db $EF, $EE, "It's unfortunate,", $EF, $EE, "but next time.", $F7
    db $F0

Message_08_93:: ; heuristic: string; C0
Data_099_6772:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thick, suction-", $F1
    db "cupped tentacles", $FA, $F7
    db $EF, $EE, "snaked out of the", $EF, $EE, "whirlpool!", $F7
    db $F0

Message_08_94:: ; heuristic: string; C0
Data_099_67B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The raging sea", $F1
    db "calmed, and the", $FA, $F7
    db $EF, $EE, "whirlpool smoothed", $EF, $EE, "to nothing.", $F7
    db $F0

Message_08_95:: ; heuristic: string; C0
Data_099_67F8:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Father put up a", $F1
    db "bridge across to", $FA, $F7
    db $EF, $EE, "that tiny island.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "We have more room", $EF, $EE, "for monsters now.", $F7
    db $F0

Message_08_A1:: ; heuristic: string; C0
Data_099_685D:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? You'll run", $F1
    db "another errand?"
    db $FF, $F0

Message_08_A2:: ; heuristic: string; C0
Data_099_687F:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My, what has", $F1
    db "gotten into you?", $FA, $F7
    db $EF, $EE, "Will miracles", $EF, $EE, "never cease?", $FA, $F7
    db $EF, $EE, "Could you go buy a", $EF, $EE, "Potion for me?", $FA, $F7
    db $EF, $EE, "Father's run down", $EF, $EE, "from overwork.", $F7
    db $F0

Message_08_A3:: ; heuristic: string; C0
Data_099_690A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mama handed over", $F1
    db "400G.", $F7
    db $F0

Message_08_A4:: ; heuristic: string; C0
Data_099_6922:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " No miracles", $F1
    db "today! Oh, well.", $FA, $F7
    db $EF, $EE, "Of course, off you", $EF, $EE, "go and play!", $F7
    db $F0

Message_08_A5:: ; heuristic: string; C0
Data_099_6967:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I need you to", $F1
    db "get me a Potion.", $F7
    db $F0

Message_08_A6:: ; heuristic: string; C0
Data_099_698A:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " You", $42, "e found", $F1
    db "what I wanted.", $FA, $F7
    db $EF, $EE, "I knew I could", $EF, $EE, "count on you!", $F7
    db $F0

Message_08_A7:: ; heuristic: string; C0
Data_099_69CE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Potion.", $F7
    db $F0

Message_08_A8:: ; heuristic: string; C0
Data_099_69EA:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well, could you", $F1
    db "go buy a Rib?", $FA, $F7
    db $EF, $EE, "It'll be a change", $EF, $EE, "from fish.", $F7
    db $F0

Message_08_A9:: ; heuristic: string; C0
Data_099_6A2C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mama handed over", $F1
    db "600G.", $F7
    db $F0

Message_08_AA:: ; heuristic: string; C0
Data_099_6A44:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I want you to", $F1
    db "buy me a Rib.", $F7
    db $F0

Message_08_AB:: ; heuristic: string; C0
Data_099_6A64:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Rib.", $F7
    db $F0

Message_08_AD:: ; heuristic: string; C0
Data_099_6A7D:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Thanks, ", $F9, "0!", $F1
    db "You're great help!", $F7
    db $F0

Message_08_AE:: ; heuristic: string; C0
Data_099_6A9F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My father was a", $F1
    db "Slime and Mama was", $FA, $F7
    db $EF, $EE, "a MiniDrak, and", $EF, $EE, "I'm neither.", $FA, $F7
    db $EF, $EE, "When the parents", $EF, $EE, "are different, the", $FA, $F7
    db $EF, $EE, "offspring are", $EF, $EE, "different too.", $F7
    db $F0

Message_08_AF:: ; heuristic: string; C0
Data_099_6B2F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Beavern helped", $F1
    db "put up the bridge.", $FA, $F7
    db $EF, $EE, "It's a solid piece", $EF, $EE, "of work, this!", $FA, $F7
    db $EF, $EE, "An underground", $EF, $EE, "stable is next,", $FA, $F7
    db $EF, $EE, "or at least if I", $EF, $EE, "can get help.", $FA, $F7
    db $EF, $EE, "Have you seen any", $EF, $EE, "MadGophers?"
    db $FF, $F0

Message_08_B0:: ; heuristic: string; C0
Data_099_6BE2:: ; address name
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like to get", $F1
    db "help for digging.", $FA, $F7
    db $EF, $EE, "Could you befriend", $EF, $EE, "a MadGopher?", $F7
    db $F0

Message_08_B1:: ; heuristic: string; C0
Data_099_6C2B:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If one joins", $F1
    db "you, could you", $FA, $F7
    db $EF, $EE, "bring it home to", $EF, $EE, "meet me?", $F7
    db $F0

Message_08_B2:: ; heuristic: string; C0
Data_099_6C69:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A MadGopher", $F1
    db "joined you?", $FA, $F7
    db $EF, $EE, "Could you pass it", $EF, $EE, "over to me?", $FA, $F7
    db $EF, $EE, $A4, "But that will", $EF, $EE, "leave you alone", $A4, $F7
    db $F0

Message_08_B3:: ; heuristic: string; C0
Data_099_6CCB:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A MadGopher", $F1
    db "joined you?", $FA, $F7
    db $EF, $EE, "Could you pass it", $EF, $EE, "over to me?"
    db $FF, $F0

Message_08_B4:: ; heuristic: string; C0
Data_099_6D09:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Great, ", $F9, "0!", $F1
    db "Thanks a lot!", $FA, $F7
    db $EF, $EE, "This will make the", $EF, $EE, "farm more useful!", $F7
    db $F0

Message_08_B5:: ; heuristic: string; C0
Data_099_6D4F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0, I need", $F1
    db "your help.", $FA, $F7
    db $EF, $EE, "Please get me a", $EF, $EE, "MadGopher.", $F7
    db $F0

Message_08_B6:: ; heuristic: string; C0
Data_099_6D88:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " MadGopher's been", $F1
    db "a great help.", $FA, $F7
    db $EF, $EE, "The excavation", $EF, $EE, "should go quickly.", $F7
    db $F0

Message_08_B7:: ; heuristic: string; C0
Data_099_6DD0:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e finished", $F1
    db "working.", $FA, $F7
    db $EF, $EE, "Can I go with you", $EF, $EE, "again?"
    db $FF, $F0

Message_08_B8:: ; heuristic: string; C0
Data_099_6E07:: ; address name
    db $EA, $45, $90, $12, $3F, $90, $26, $32, $38, $31, $37, $2C, $31, $2A, $90, $32
    db $31, $F1, $3C, $32, $38, $99, $F7, $F0

Message_08_B9:: ; heuristic: string; C0
Data_099_6E1F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "But you have no", $F1
    db "room for me", $A4, $F7
    db $F0

Message_08_BA:: ; heuristic: string; C0
Data_099_6E41:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Tch, I thought I", $F1
    db "could help you", $A4, $F7
    db $F0

Message_08_BB:: ; heuristic: string; C0
Data_099_6E66:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have to tamp", $F1
    db "the ground firmly", $FA, $F7
    db $EF, $EE, "around where you", $EF, $EE, "do your digging.", $F7
    db $F0

Message_08_BC:: ; heuristic: string; C0
Data_099_6EB3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0, what", $F1
    db "was it like in the", $FA, $F7
    db $EF, $EE, "other worlds?", $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like to know.", $FA, $F7
    db $EF, $EE, $A4, "Oh", $A4, " Kameha's out", $EF, $EE, "there too.", $FA, $F7
    db $EF, $EE, "No wonder he hasn't", $EF, $EE, "been around.", $FA, $F7
    db $EF, $EE, "There's a bridge", $EF, $EE, "over to the next", $FA, $F7
    db $EF, $EE, "island, so the", $EF, $EE, "farm grew a bit", $FA, $F7
    db $EF, $EE, "bigger.", $EF, $EE, "So, what can I do", $FA, $F7
    db $EF, $EE, "for you, sis?", $EF, $EE, $F7
    db $F0

Message_08_BD:: ; heuristic: string; C0
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

Message_08_BE:: ; heuristic: string; C0
Data_099_70B6:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Including the", $F1
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

Message_08_BF:: ; heuristic: string; C0
Data_099_7213:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Master only", $F1
    db "makes me charge.", $FA, $F7
    db $EF, $EE, "It made me more", $EF, $EE, "courageous!", $F7
    db $F0

Message_08_C0:: ; heuristic: string; C0
Data_099_7254:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We get more and", $F1
    db "more stubborn as", $FA, $F7
    db $EF, $EE, "we grow to higher", $EF, $EE, "levels.", $FA, $F7
    db $EF, $EE, "Our personalities", $EF, $EE, "don't change much,", $FA, $F7
    db $EF, $EE, "once we get old.", $EF, $EE, "Fwohohoho!", $F7
    db $F0

Message_08_C1:: ; heuristic: string; C0
Data_099_72DF:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey! You're the", $F1
    db "kid who said the", $FA, $F7
    db $EF, $EE, "island was going", $EF, $EE, "to sink!", $FA, $F7
    db $EF, $EE, "I believed you and", $EF, $EE, "sailed off, but", $FA, $F7
    db $EF, $EE, "the island's still", $EF, $EE, "here!", $FA, $F7
    db $EF, $EE, "You rotten little", $EF, $EE, "lie master!", $F7
    db $F0

Message_08_C2:: ; heuristic: string; C0
Data_099_7386:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I have nothing", $F1
    db "for a liar!", $F7
    db $F0

Message_08_C3:: ; heuristic: string; C0
Data_099_73A5:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " To take off an", $F1
    db "accessory, just", $FA, $F7
    db $EF, $EE, "put a different", $EF, $EE, "accessory on.", $FA, $F7
    db $EF, $EE, "Try equipping a", $EF, $EE, "D-Scale, that will", $FA, $F7
    db $EF, $EE, "remove whatever is", $EF, $EE, "equipped.", $FA, $F7
    db $EF, $EE, "It's common", $EF, $EE, "knowledge!", $F7
    db $F0

Message_08_C4:: ; heuristic: string; C0
Data_099_744C:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The woman next", $F1
    db "to me, she repeats", $FA, $F7
    db $EF, $EE, "whatever she hears", $EF, $EE, "from other people", $FA, $F7
    db $EF, $EE, "and acts smart.", $EF, $EE, "What a Copycat", $A4, $F7
    db $F0

Message_08_C5:: ; heuristic: string; C0
Data_099_74BF:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I want to open", $F1
    db "up a shop here,", $FA, $F7
    db $EF, $EE, "but I need help", $EF, $EE, "unloading my ship.", $FA, $F7
    db $EF, $EE, "I heard an ArmyAnt", $EF, $EE, "can carry things", $FA, $F7
    db $EF, $EE, "much bigger than", $EF, $EE, "itself.", $FA, $F7
    db $EF, $EE, "Yep, an ArmyAnt", $EF, $EE, "would be helpful", $A4, $F7
    db $F0

Message_08_C6:: ; heuristic: string; C0
Data_099_7574:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wait! Could I", $F1
    db "get you to leave", $FA, $F7
    db $EF, $EE, "your Army Ant with", $EF, $EE, "me?", $FA, $F7
    db $EF, $EE, "Oh", $A4, " But that would", $EF, $EE, "leave you alone", $A4, $F7
    db $F0

Message_08_C8:: ; heuristic: string; C0
Data_099_75DA:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wait! Could I", $F1
    db "get you to leave", $FA, $F7
    db $EF, $EE, "your Army Ant with", $EF, $EE, "me?"
    db $FF, $F0

Message_08_C9:: ; heuristic: string; C0
Data_099_7618:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Fantastic! I can", $F1
    db "open my shop now!", $F7
    db $F0

Message_08_CA:: ; heuristic: string; C0
Data_099_763F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " That's very", $F1
    db "disappointing.", $FA, $F7
    db $EF, $EE, "I could have my", $EF, $EE, "shop quickly too", $A4, $F7
    db $F0

Message_08_CB:: ; heuristic: string; C0
Data_099_7687:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ArmyAnt helped", $F1
    db "me get my shop up.", $FA, $F7
    db $EF, $EE, "Would you care to", $EF, $EE, "see my wares?", $F7
    db $F0

Message_08_CC:: ; heuristic: string; C0
Data_099_76D1:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome! How may", $F1
    db "I serve you?", $F7
    db $F0

Message_08_CD:: ; heuristic: string; C0
Data_099_76F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "door.", $FA, $F7
    db $EF, $EE, "The door won't open", $EF, $EE, "with any key.", $F7
    db $F0

Message_08_CE:: ; heuristic: string; C0
Data_099_772E:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Many trees have", $F1
    db "submerged", $A4, $FA, $F7
    db $EF, $EE, "The island seems", $EF, $EE, "to be undergoing", $FA, $F7
    db $EF, $EE, "an unwelcome", $EF, $EE, "change", $A4, $F7
    db $F0

Message_08_CF:: ; heuristic: string; C0
Data_099_778C:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Um", $A4, " I'm the Egg", $F1
    db "Evaluator.", $FA, $F7
    db $EF, $EE, "You don't know who", $EF, $EE, "I am", $A4, " Right?", $FA, $F7
    db $EF, $EE, "Um", $A4, " All monsters", $EF, $EE, "hatch from eggs.", $FA, $F7
    db $EF, $EE, "I check your eggs", $EF, $EE, "to determine the", $FA, $F7
    db $EF, $EE, "gender of the", $EF, $EE, "monster inside.", $FA, $F7
    db $EF, $EE, "I can also sing a", $EF, $EE, "song to change the", $FA, $F7
    db $EF, $EE, "gender of the", $EF, $EE, "monster in an egg.", $FA, $F7
    db $EF, $EE, "May I help you in", $EF, $EE, "any way today?", $F7
    db $F0

Message_08_D0:: ; heuristic: string; C0
Data_099_78AF:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm the Egg", $F1
    db "Evaluator.", $FA, $F7
    db $EF, $EE, "May I help you in", $EF, $EE, "any way today?", $F7
    db $F0

Message_08_D1:: ; heuristic: string; C0
Data_099_78EE:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Evaluator", $F1
    db "said I had an", $FA, $F7
    db $EF, $EE, "amazing egg.", $EF, $EE, "But I stumbled on", $FA, $F7
    db $EF, $EE, "the stairs and", $EF, $EE, "almost broke it.", $F7
    db $F0

Message_08_D2:: ; heuristic: string; C0
Data_099_7955:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Go down these", $F1
    db "stairs to the", $FA, $F7
    db $EF, $EE, "Starry Shrine.", $EF, $EE, $F7
    db $F0

Message_08_D3:: ; heuristic: string; C0
Data_099_7989:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to the", $F1
    db "Starry Shrine.", $FA, $F7
    db $EF, $EE, "I'm Professor", $EF, $EE, "Monster.", $FA, $F7
    db $EF, $EE, "I have the run of", $EF, $EE, "the place while I", $FA, $F7
    db $EF, $EE, "study monsters and", $EF, $EE, "their breeding.", $FA, $F7
    db $EF, $EE, "I can help you", $EF, $EE, "breed monsters", $FA, $F7
    db $EF, $EE, "and hatch the eggs", $EF, $EE, "that result.", $FA, $F7
    db $EF, $EE, "So, what do you", $EF, $EE, "need of me today?", $F7
    db $F0

Message_08_D4:: ; heuristic: string; C0
Data_099_7A80:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to the", $F1
    db "Starry Shrine.", $FA, $F7
    db $EF, $EE, "What do you need", $EF, $EE, "of me today?", $F7
    db $F0

Message_08_D5:: ; heuristic: string; C0
Data_099_7AC4:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm the Prof's", $F1
    db "assistant.", $FA, $F7
    db $EF, $EE, "Do you want to", $EF, $EE, "hear about the", $FA, $F7
    db $EF, $EE, "Starry Shrine?", $EF, $EE
    db $FF, $F0

Message_08_D6:: ; heuristic: string; C0
Data_099_7B16:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can breed", $F1
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

Message_08_D7:: ; heuristic: string; C0
Data_099_7C8A:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Talk to the Prof", $F1
    db "if you need help.", $F7
    db $F0

Message_08_D8:: ; heuristic: string; C0
Data_099_7CB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Breeding Guide", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In breeding, the", $EF, $EE, "monster chosen as", $FA, $F7
    db $EF, $EE, "the base sets the", $EF, $EE, "baby's family.", $FA, $F7
    db $EF, $EE, "If a Slime family", $EF, $EE, "monster is chosen", $FA, $F7
    db $EF, $EE, "as the base, the", $EF, $EE, "baby will also be", $FA, $F7
    db $EF, $EE, "of the Slime", $EF, $EE, "family.", $FA, $F7
    db $EF, $EE, "And if a Dragon", $EF, $EE, "family monster is", $FA, $F7
    db $EF, $EE, "the base monster,", $EF, $EE, "the baby will also", $FA, $F7
    db $EF, $EE, "be of the Dragon", $EF, $EE, "family.", $95, $F7
    db $F0

Message_08_D9:: ; heuristic: string; C0
Data_099_7E03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Breeding Guide", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "In breeding, the", $EF, $EE, "families and the", $FA, $F7
    db $EF, $EE, "species of the", $EF, $EE, "parents determine", $FA, $F7
    db $EF, $EE, "the species of the", $EF, $EE, "baby.", $FA, $F7
    db $EF, $EE, "Changing the mix", $EF, $EE, "of families and", $FA, $F7
    db $EF, $EE, "species results in", $EF, $EE, "different babies.", $95, $F7
    db $F0

Message_08_DA:: ; heuristic: string; C0
Data_099_7EEC:: ; address name
    db $EA

Message_08_EA:: ; heuristic: string; C0
Data_099_7EED:: ; address name
    db $F0
    ds $112, $00
