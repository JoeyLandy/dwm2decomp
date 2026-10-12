SECTION "Bank 96", ROMX[$4000], BANK[$96]
    db $96

; overflow for message bank $80: wStringIndex -= $C8, then BeginStringDisplay with the table Data_096_404B in this bank (E-0080)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank80)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank80_Overflow::
Func_096_4001:: ; address name
    ld de, MessageStrings_Bank80_Overflow
    ld a, [wStringIndex]
    sub a, $C8
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $80: wStringIndex -= $C8, then CopyStringToBuffer with the table Data_096_404B in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank80)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank80_Overflow:: ; heuristic: follows a terminator; C0
Func_096_4010:: ; address name
    ld de, MessageStrings_Bank80_Overflow
    ld a, [wStringIndex]
    sub a, $C8
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; overflow for message bank $82: wStringIndex -= $90, then BeginStringDisplay with the table Data_096_574A in this bank (E-0080)
; 2 call sites from 2 routines (e.g. BeginStringDisplay_Bank82, CopyStringToBuffer_Bank82)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank82_Overflow::
Func_096_4026:: ; address name
    ld de, MessageStrings_Bank82_Overflow
    ld a, [wStringIndex]
    sub a, $90
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $82: wStringIndex -= $90, then CopyStringToBuffer with the table Data_096_574A in this bank (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank82_Overflow:: ; heuristic: follows a terminator; C0
Func_096_4035:: ; address name
    ld de, MessageStrings_Bank82_Overflow
    ld a, [wStringIndex]
    sub a, $90
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $26, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_96_404B::
MessageStrings_Bank80_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_096_404B:: ; address name
    dw StringList_96_404D ; id 0

; E-0217 (derived: category list of StringCategories_96_404B; one pointer per wStringIndex)
; record: string
StringList_96_404D::
Data_096_404D:: ; address name
    dw String_96_404B_00_00 ; id 0
    dw String_96_404B_00_01 ; id 1
    dw String_96_404B_00_02 ; id 2
    dw String_96_404B_00_03 ; id 3
    dw String_96_404B_00_04 ; id 4
    dw String_96_404B_00_05 ; id 5
    dw String_96_404B_00_06 ; id 6
    dw String_96_404B_00_07 ; id 7
    dw String_96_404B_00_08 ; id 8
    dw String_96_404B_00_09 ; id 9
    dw String_96_404B_00_0A ; id 10
    dw String_96_404B_00_0B ; id 11
    dw String_96_404B_00_0C ; id 12
    dw String_96_404B_00_0D ; id 13
    dw String_96_404B_00_0E ; id 14
    dw String_96_404B_00_0E ; id 15
    dw String_96_404B_00_10 ; id 16
    dw String_96_404B_00_11 ; id 17
    dw String_96_404B_00_12 ; id 18
    dw String_96_404B_00_13 ; id 19
    dw String_96_404B_00_14 ; id 20
    dw String_96_404B_00_15 ; id 21
    dw String_96_404B_00_15 ; id 22
    dw String_96_404B_00_17 ; id 23
    dw String_96_404B_00_18 ; id 24
    dw String_96_404B_00_19 ; id 25
    dw String_96_404B_00_1A ; id 26
    dw String_96_404B_00_1B ; id 27
    dw String_96_404B_00_1C ; id 28
    dw String_96_404B_00_1D ; id 29
    dw String_96_404B_00_1E ; id 30
    dw String_96_404B_00_1F ; id 31
    dw String_96_404B_00_20 ; id 32
    dw String_96_404B_00_21 ; id 33
    dw String_96_404B_00_22 ; id 34
    dw String_96_404B_00_23 ; id 35
    dw String_96_404B_00_24 ; id 36
    dw String_96_404B_00_25 ; id 37
    dw String_96_404B_00_26 ; id 38
    dw String_96_404B_00_27 ; id 39
    dw String_96_404B_00_28 ; id 40
    dw String_96_404B_00_29 ; id 41
    dw String_96_404B_00_29 ; id 42
    dw String_96_404B_00_2B ; id 43
    dw String_96_404B_00_2C ; id 44
    dw String_96_404B_00_2D ; id 45
    dw String_96_404B_00_2E ; id 46
    dw String_96_404B_00_2E ; id 47
    dw String_96_404B_00_30 ; id 48
    dw String_96_404B_00_31 ; id 49
    dw String_96_404B_00_32 ; id 50
    dw String_96_404B_00_33 ; id 51
    dw String_96_404B_00_34 ; id 52
    dw String_96_404B_00_35 ; id 53
    dw String_96_404B_00_36 ; id 54
    dw String_96_404B_00_37 ; id 55

String_96_404B_00_00:: ; heuristic: string; C0
Data_096_40BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You will?", $F1
    db "Thank you!", $FA, $F7
    db $EF, $EE, "Let me hide among", $EF, $EE, "your items.", $FA, $F7
    db $EF, $EE, "Oh? You have no", $EF, $EE, "room for me", $A4, $F7
    db $F0

String_96_404B_00_01:: ; heuristic: string; C0
Data_096_4119:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh", $A4, " How terribly", $F1
    db "disappointing.", $FA, $F7
    db $EF, $EE, "I'll have to find", $EF, $EE, "someone else who", $FA, $F7
    db $EF, $EE, "would be willing", $EF, $EE, "to help me", $A4, $F7
    db $F0

String_96_404B_00_02:: ; heuristic: string; C0
Data_096_4184:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I don't remember", $F1
    db "who I am, what I'm", $FA, $F7
    db $EF, $EE, "doing here, or", $EF, $EE, "anything else", $A4, $FA, $F7
    db $EF, $EE, "I just know that I", $EF, $EE, "need help", $A4, $FA, $F7
    db $EF, $EE, "Oh? Do you know", $EF, $EE, "who I am?", $FA, $F7
    db $EF, $EE, "Could I get you to", $EF, $EE, "take me back home?", $FF, $F0

String_96_404B_00_03:: ; heuristic: string; C0
Data_096_4236:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The crowds that", $F1
    db "flocked to the", $FA, $F7
    db $EF, $EE, "castle have all", $EF, $EE, "left.", $FA, $F7
    db $EF, $EE, "Not a one of them", $EF, $EE, "raised even the", $FA, $F7
    db $EF, $EE, "ghost of a smile", $EF, $EE, "from Lady Yuna", $A4, $F7
    db $F0

String_96_404B_00_04:: ; heuristic: string; C0
Data_096_42BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Yuna has", $F1
    db "locked herself", $FA, $F7
    db $EF, $EE, "away in her room", $A4, $EF, $EE, "Everyone failed to", $FA, $F7
    db $EF, $EE, "cheer her up even", $EF, $EE, "the least bit", $A4, $F7
    db $F0

String_96_404B_00_05:: ; heuristic: string; C0
Data_096_432C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lady Yuna locked", $F1
    db "herself in and", $FA, $F7
    db $EF, $EE, "won't respond to", $EF, $EE, "repeated calls.", $F7
    db $F0

String_96_404B_00_06:: ; heuristic: string; C0
Data_096_4374:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "marionette.", $FA, $F7
    db $EF, $EE, "It sagged", $EF, $EE, "lifelessly.", $F7
    db $F0

String_96_404B_00_07:: ; heuristic: string; C0
Data_096_43AA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, $A4, $A4, $A4, $F1
    db $FA, $F7
    db $EF, $EE, $F3, "W-where am I?", $F1
    db "I", $A4, " I", $A4, " I am", $A4, $FA, $F7
    db $EF, $EE, "I'm on the verge", $EF, $EE, "of remembering!", $F7
    db $F0

String_96_404B_00_08:: ; heuristic: string; C0
Data_096_43F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yuna's soul filled", $F1
    db "her body.", $F7
    db $F0

String_96_404B_00_09:: ; heuristic: string; C0
Data_096_4413:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, $A4, " STOP", $A4, $F1
    db "DON", $95, "T MEDDLE", $A4, $F7
    db $F0

String_96_404B_00_0A:: ; heuristic: string; C0
Data_096_442E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " NEVER DID I", $F1
    db "EXPECT YUNA", $95, "S SOUL", $FA, $F7
    db $EF, $EE, "TO BE FOUND", $A4, $EF, $EE, "BUT, NO MATTER.", $FA, $F7
    db $EF, $EE, "YOU MUST DEFEAT ME", $EF, $EE, "TO SAVE HER.", $FA, $F7
    db $EF, $EE, "DO YOU WISH TO", $EF, $EE, "BATTLE?", $FF, $F0

String_96_404B_00_0B:: ; heuristic: string; C0
Data_096_44B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " FOOLHARDY.", $F1
    db "BRAVE BUT FOOLISH.", $F7
    db $F0

String_96_404B_00_0C:: ; heuristic: string; C0
Data_096_44D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " H-HOW", $A4, " BUT I", $A4, $F1
    db "THIS ISN", $95, "T", $A4, $A4, $F7
    db $F0

String_96_404B_00_0D:: ; heuristic: string; C0
Data_096_44F2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I", $42, "e finally", $F1
    db "remembered.", $FA, $F7
    db $EF, $EE, "I'm Yuna, the", $EF, $EE, "King's daughter.", $FA, $F7
    db $EF, $EE, "I", $44, " overheard a", $EF, $EE, "man and monsters", $FA, $F7
    db $EF, $EE, "concocting a", $EF, $EE, "criminal plan in", $FA, $F7
    db $EF, $EE, "the forest, but", $EF, $EE, "they found me.", $FA, $F7
    db $EF, $EE, "A monster drained", $EF, $EE, "my soul, and my", $FA, $F7
    db $EF, $EE, "body was put under", $EF, $EE, "its control.", $FA, $F7
    db $EF, $EE, "Their plan was", $EF, $EE, "diabolical!", $FA, $F7
    db $EF, $EE, "They wanted to", $EF, $EE, "steal the Sky", $FA, $F7
    db $EF, $EE, "Shield from the", $EF, $EE, "elemental spirit,", $FA, $F7
    db $EF, $EE, "so they tried to", $EF, $EE, "create strife", $FA, $F7
    db $EF, $EE, "among people to", $EF, $EE, "weaken the spirit.", $FA, $F7
    db $EF, $EE, "Their next target", $EF, $EE, "is Queen Helen of", $FA, $F7
    db $EF, $EE, "the kingdom in the", $EF, $EE, "east.", $FA, $F7
    db $EF, $EE, "There can be no", $EF, $EE, "one else.", $FA, $F7
    db $EF, $EE, "Please, go to her", $EF, $EE, "and help her like", $FA, $F7
    db $EF, $EE, "you have helped", $EF, $EE, "me.", $F7
    db $F0

String_96_404B_00_0E:: ; heuristic: string; C0
Data_096_4735:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Yuna", $A3, " Their next", $F1
    db "target is Queen", $FA, $F7
    db $EF, $EE, "Helen of the", $EF, $EE, "eastern kingdom.", $FA, $F7
    db $EF, $EE, "There can be no", $EF, $EE, "one else.", $FA, $F7
    db $EF, $EE, "Please, go to her", $EF, $EE, "and help her like", $FA, $F7
    db $EF, $EE, "you have helped", $EF, $EE, "me.", $F7
    db $F0

String_96_404B_00_10:: ; heuristic: string; C0
Data_096_47D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lady Yuna has", $F1
    db "regained her usual", $FA, $F7
    db $EF, $EE, "exuberance and", $EF, $EE, "energy.", $F7
    db $F0

String_96_404B_00_11:: ; heuristic: string; C0
Data_096_4818:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lady Yuna snuck", $F1
    db "out again.", $FA, $F7
    db $EF, $EE, "I'm not sure if we", $EF, $EE, "should be happy or", $FA, $F7
    db $EF, $EE, "concerned about", $EF, $EE, "it.", $F7
    db $F0

String_96_404B_00_12:: ; heuristic: string; C0
Data_096_4878:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh? How did you", $F1
    db "get in here?", $F7
    db $F0

String_96_404B_00_13:: ; heuristic: string; C0
Data_096_4899:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How could we", $F1
    db "ever thank you", $FA, $F7
    db $EF, $EE, "enough for saving", $EF, $EE, "Lady Yuna?", $F7
    db $F0

String_96_404B_00_14:: ; heuristic: string; C0
Data_096_48DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Yuna is back", $F1
    db "to being herself.", $FA, $F7
    db $EF, $EE, "Perhaps she is a", $EF, $EE, "bit too energetic,", $FA, $F7
    db $EF, $EE, "but it's a cause", $EF, $EE, "for celebration!", $F7
    db $F0

String_96_404B_00_15:: ; heuristic: string; C0
Data_096_494E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lady Yuna is", $F1
    db "back to her cheery", $FA, $F7
    db $EF, $EE, "smiling self!", $EF, $EE, "Even the weather", $FA, $F7
    db $EF, $EE, "seems to be in a", $EF, $EE, "celebrating mood.", $F7
    db $F0

String_96_404B_00_17:: ; heuristic: string; C0
Data_096_49BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Lady Yuna has", $EF, $EE, "regained her", $FA, $F7
    db $EF, $EE, "cheerful vivacity.", $EF, $EE, "The contest for", $FA, $F7
    db $EF, $EE, "cheering her up is", $EF, $EE, "now finished.", $95, $F7
    db $F0

String_96_404B_00_18:: ; heuristic: string; C0
Data_096_4A3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lady Yuna seems", $F1
    db "to be her cheerful", $FA, $F7
    db $EF, $EE, "old self again.", $EF, $EE, "But whatever", $FA, $F7
    db $EF, $EE, "became of the", $EF, $EE, "reward?", $F7
    db $F0

String_96_404B_00_19:: ; heuristic: string; C0
Data_096_4A9E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Lady Yuna tries", $F1
    db "to bolt from the", $FA, $F7
    db $EF, $EE, "Castle every day.", $EF, $EE, "That, of course,", $FA, $F7
    db $EF, $EE, "causes the King", $EF, $EE, "great anxiety.", $F7
    db $F0

String_96_404B_00_1A:: ; heuristic: string; C0
Data_096_4B0D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " All the people", $F1
    db "swarming to the", $FA, $F7
    db $EF, $EE, "Castle have gone", $EF, $EE, "away", $A4, $FA, $F7
    db $EF, $EE, "I wish I could", $42, "e", $EF, $EE, "seen them", $A4, $FA, $F7
    db $EF, $EE, "They should have", $EF, $EE, "done shows here.", $F7
    db $F0

String_96_404B_00_1B:: ; heuristic: string; C0
Data_096_4B91:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Queen Helen had", $F1
    db "been suffering", $FA, $F7
    db $EF, $EE, "from nightmares,", $EF, $EE, "and now she has", $FA, $F7
    db $EF, $EE, "fallen terribly", $EF, $EE, "ill", $A4, $FA, $F7
    db $EF, $EE, "Her life is in", $EF, $EE, "jeopardy", $A4, $F7
    db $F0

String_96_404B_00_1C:: ; heuristic: string; C0
Data_096_4C0F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You can't come", $F1
    db "in here.", $FA, $F7
    db $EF, $EE, "Queen Helen's room", $EF, $EE, "is past here.", $FA, $F7
    db $EF, $EE, "She's taken sick", $EF, $EE, "from nightmares.", $FA, $F7
    db $EF, $EE, "If she could sleep", $EF, $EE, "deeply, far beyond", $FA, $F7
    db $EF, $EE, "seeing any dreams,", $EF, $EE, "she may be cured", $A4, $F7
    db $F0

String_96_404B_00_1D:: ; heuristic: string; C0
Data_096_4CC6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The reception", $F1
    db "hall is past here.", $FA, $F7
    db $EF, $EE, "However, our Queen", $EF, $EE, "isn't there.", $F7
    db $F0

String_96_404B_00_1E:: ; heuristic: string; C0
Data_096_4D0E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e traveled far", $F1
    db "to study plants.", $FA, $F7
    db $EF, $EE, "SleepHerb is the", $EF, $EE, "one plant that", $FA, $F7
    db $EF, $EE, "assures a deep and", $EF, $EE, "dreamless sleep.", $FA, $F7
    db $EF, $EE, "It grows only atop", $EF, $EE, "a mountain on the", $FA, $F7
    db $EF, $EE, "east and north", $EF, $EE, "kingdom's border.", $FA, $F7
    db $EF, $EE, "It is a rare blue", $EF, $EE, "flower that grows", $FA, $F7
    db $EF, $EE, "only in extreme", $EF, $EE, "cold.", $FA, $F7
    db $EF, $EE, "Oh, the mountain", $EF, $EE, "can be reached", $FA, $F7
    db $EF, $EE, "only from the east", $EF, $EE, "side.", $FA, $F7
    db $EF, $EE, "It is far to the", $EF, $EE, "north of the", $FA, $F7
    db $EF, $EE, "eastern kingdom's", $EF, $EE, "castle.", $F7
    db $F0

String_96_404B_00_1F:: ; heuristic: string; C0
Data_096_4E8F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "blue flower.", $FA, $F7
    db $EF, $EE, "It was the", $EF, $EE, "SleepHerb!", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, "SleepHerb.", $F7
    db $F0

String_96_404B_00_20:: ; heuristic: string; C0
Data_096_4EE5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "blue flower.", $FA, $F7
    db $EF, $EE, "The SleepHerb", $EF, $EE, "poked out of snow.", $F7
    db $F0

String_96_404B_00_21:: ; heuristic: string; C0
Data_096_4F27:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "blue flower.", $FA, $F7
    db $EF, $EE, "It was the", $EF, $EE, "SleepHerb!", $FA, $F7
    db $EF, $EE, "But there was no", $EF, $EE, "room for it.", $F7
    db $F0

String_96_404B_00_22:: ; heuristic: string; C0
Data_096_4F80:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Pardon me?", $F1
    db "You have medicine?", $FA, $F7
    db $EF, $EE, "This flower will", $EF, $EE, "save our Queen?", $FA, $F7
    db $EF, $EE, "Please come with", $EF, $EE, "me to her room!", $F7
    db $F0

String_96_404B_00_23:: ; heuristic: string; C0
Data_096_4FEC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, $A4, $A4, $A4, $A4, $A4, $F7
    db $F0

String_96_404B_00_24:: ; heuristic: string; C0
Data_096_4FF7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The Queen took the", $F1
    db "SleepHerb", $A4, $F7
    db $F0

String_96_404B_00_25:: ; heuristic: string; C0
Data_096_5016:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I wish you", $F1
    db "wouldn't do that", $A4, $F7
    db $F0

String_96_404B_00_26:: ; heuristic: string; C0
Data_096_5036:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Our plan called", $F1
    db "for chaos in the", $FA, $F7
    db $EF, $EE, "three kingdoms", $EF, $EE, "around the lake", $A4, $FA, $F7
    db $EF, $EE, "So I had wormed my", $EF, $EE, "way into the", $FA, $F7
    db $EF, $EE, "Queen's dreams to", $EF, $EE, "create nightmares.", $FA, $F7
    db $EF, $EE, "That drug will", $EF, $EE, "ruin my plan.", $FA, $F7
    db $EF, $EE, "You dare to defy", $EF, $EE, "me, child?", $FF, $F0

String_96_404B_00_27:: ; heuristic: string; C0
Data_096_510C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heh, such a show", $F1
    db "of false bravado!", $FA, $F7
    db $EF, $EE, "You will pay for", $EF, $EE, "it with your life!", $F7
    db $F0

String_96_404B_00_28:: ; heuristic: string; C0
Data_096_515B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? Lose to a", $F1
    db "child's monsters?", $FA, $F7
    db $EF, $EE, "So it was you who", $EF, $EE, "took the others!", $FA, $F7
    db $EF, $EE, "I must inform my", $EF, $EE, "King!", $F7
    db $F0

String_96_404B_00_29:: ; heuristic: string; C0
Data_096_51C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, my goodness!", $F1
    db "Thank you!", $FA, $F7
    db $EF, $EE, "You saved our", $EF, $EE, "Queen Helen!", $F7
    db $F0

String_96_404B_00_2B:: ; heuristic: string; C0
Data_096_5201:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That was a", $F1
    db "lovely sleep.", $FA, $F7
    db $EF, $EE, "I haven't slept so", $EF, $EE, "soundly in weeks.", $FA, $F7
    db $EF, $EE, "Oh? Who are you?", $EF, $EE, $F7
    db $F0

String_96_404B_00_2C:: ; heuristic: string; C0
Data_096_525C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Your Highness!", $F1
    db "You're awake!", $FA, $F7
    db $EF, $EE, "This child rid you", $EF, $EE, "of the fiend that", $FA, $F7
    db $EF, $EE, "made nightmares of", $EF, $EE, "your dreams.", $F7
    db $F0

String_96_404B_00_2D:: ; heuristic: string; C0
Data_096_52C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Helen", $A3, " I put you", $F1
    db "through trouble", $A4, $FA, $F7
    db $EF, $EE, "Since I started", $EF, $EE, "having nightmares,", $FA, $F7
    db $EF, $EE, "I haven't awoken", $EF, $EE, "this refreshed.", $FA, $F7
    db $EF, $EE, "I am truly", $EF, $EE, "grateful.", $FA, $F7
    db $EF, $EE, "Oh! That Crest", $A4, $EF, $EE, "It's the spirit's", $A4, $FA, $F7
    db $EF, $EE, "So it was all the", $EF, $EE, "spirit's bidding", $A4, $F7
    db $F0

String_96_404B_00_2E:: ; heuristic: string; C0
Data_096_539D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Helen", $A3, " Thank you", $F1
    db "so much.", $FA, $F7
    db $EF, $EE, "Please thank the", $EF, $EE, "spirit for me too.", $FA, $F7
    db $EF, $EE, $A4, $A4, $A4, $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Oh? I saw a dark", $F1
    db "shadow over you", $A4, $FA, $F7
    db $EF, $EE, "But you're blessed", $EF, $EE, "by the spirit", $A4, $FA, $F7
    db $EF, $EE, "I must have just", $EF, $EE, "imagined it.", $FA, $F7
    db $EF, $EE, "Please don't think", $EF, $EE, "anything of it.", $F7
    db $F0

String_96_404B_00_30:: ; heuristic: string; C0
Data_096_547E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Quick, give the", $F1
    db "medicine to our", $FA, $F7
    db $EF, $EE, "Queen Helen.", $EF, $EE, "Please, hurry!", $F7
    db $F0

String_96_404B_00_31:: ; heuristic: string; C0
Data_096_54C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Queen Helen is", $F1
    db "safe for now!", $FA, $F7
    db $EF, $EE, "Please get rid of", $EF, $EE, "the monsters!", $F7
    db $F0

String_96_404B_00_32:: ; heuristic: string; C0
Data_096_5507:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You have", $F1
    db "restored peace.", $FA, $F7
    db $EF, $EE, "For this, we can", $EF, $EE, "thank the spirit.", $F7
    db $F0

String_96_404B_00_33:: ; heuristic: string; C0
Data_096_554B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Queen Helen isn't", $F1
    db "bedridden by", $FA, $F7
    db $EF, $EE, "nightmares", $EF, $EE, "anymore.", $FA, $F7
    db $EF, $EE, "From now on, it's", $EF, $EE, "our turn to do our", $FA, $F7
    db $EF, $EE, "best for Queen", $EF, $EE, "Helen.", $F7
    db $F0

String_96_404B_00_34:: ; heuristic: string; C0
Data_096_55C7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Queen Helen has", $F1
    db "had a good dream,", $FA, $F7
    db $EF, $EE, "I", $42, "e heard.", $EF, $EE, "What a change!", $F7
    db $F0

String_96_404B_00_35:: ; heuristic: string; C0
Data_096_560B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The skies are", $F1
    db "clear, but my", $FA, $F7
    db $EF, $EE, "heart remains", $EF, $EE, "heavy and clouded", $A4, $FA, $F7
    db $EF, $EE, "When will my wife", $EF, $EE, "come home?", $F7
    db $F0

String_96_404B_00_36:: ; heuristic: string; C0
Data_096_5671:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It has been", $F1
    db "getting warmer.", $FA, $F7
    db $EF, $EE, "The lake's ice is", $EF, $EE, "starting to melt.", $F7
    db $F0

String_96_404B_00_37:: ; heuristic: string; C0
Data_096_56B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I heard from my", $F1
    db "sister who works", $FA, $F7
    db $EF, $EE, "at the castle that", $EF, $EE, "Queen Helen had", $FA, $F7
    db $EF, $EE, "been possessed by", $EF, $EE, "a monster.", $FA, $F7
    db $EF, $EE, "That's why she was", $EF, $EE, "in a bad mood!", $F7
    db $F0

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_96_574A::
MessageStrings_Bank82_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_096_574A:: ; address name
    dw StringList_96_574C ; id 0

; E-0217 (derived: category list of StringCategories_96_574A; one pointer per wStringIndex)
; record: string
StringList_96_574C::
Data_096_574C:: ; address name
    dw String_96_574A_00_00 ; id 0
    dw String_96_574A_00_01 ; id 1
    dw String_96_574A_00_02 ; id 2
    dw String_96_574A_00_03 ; id 3
    dw String_96_574A_00_04 ; id 4
    dw String_96_574A_00_05 ; id 5
    dw String_96_574A_00_06 ; id 6
    dw String_96_574A_00_07 ; id 7
    dw String_96_574A_00_08 ; id 8
    dw String_96_574A_00_09 ; id 9
    dw String_96_574A_00_0A ; id 10
    dw String_96_574A_00_0B ; id 11
    dw String_96_574A_00_0C ; id 12
    dw String_96_574A_00_0D ; id 13
    dw String_96_574A_00_0E ; id 14
    dw String_96_574A_00_0F ; id 15
    dw String_96_574A_00_10 ; id 16
    dw String_96_574A_00_11 ; id 17
    dw String_96_574A_00_12 ; id 18
    dw String_96_574A_00_13 ; id 19
    dw String_96_574A_00_14 ; id 20
    dw String_96_574A_00_15 ; id 21
    dw String_96_574A_00_16 ; id 22
    dw String_96_574A_00_17 ; id 23
    dw String_96_574A_00_18 ; id 24
    dw String_96_574A_00_19 ; id 25
    dw String_96_574A_00_19 ; id 26
    dw String_96_574A_00_19 ; id 27
    dw String_96_574A_00_19 ; id 28
    dw String_96_574A_00_1D ; id 29
    dw String_96_574A_00_1E ; id 30
    dw String_96_574A_00_1F ; id 31
    dw String_96_574A_00_20 ; id 32
    dw String_96_574A_00_21 ; id 33
    dw String_96_574A_00_22 ; id 34
    dw String_96_574A_00_23 ; id 35
    dw String_96_574A_00_24 ; id 36
    dw String_96_574A_00_25 ; id 37
    dw String_96_574A_00_26 ; id 38
    dw String_96_574A_00_27 ; id 39
    dw String_96_574A_00_28 ; id 40
    dw String_96_574A_00_29 ; id 41
    dw String_96_574A_00_2A ; id 42
    dw String_96_574A_00_2B ; id 43
    dw String_96_574A_00_2C ; id 44
    dw String_96_574A_00_2D ; id 45
    dw String_96_574A_00_2E ; id 46
    dw String_96_574A_00_2F ; id 47
    dw String_96_574A_00_30 ; id 48
    dw String_96_574A_00_31 ; id 49
    dw String_96_574A_00_32 ; id 50
    dw String_96_574A_00_33 ; id 51
    dw String_96_574A_00_34 ; id 52
    dw String_96_574A_00_34 ; id 53
    dw String_96_574A_00_34 ; id 54
    dw String_96_574A_00_34 ; id 55
    dw String_96_574A_00_34 ; id 56
    dw String_96_574A_00_34 ; id 57
    dw String_96_574A_00_34 ; id 58
    dw String_96_574A_00_34 ; id 59
    dw String_96_574A_00_34 ; id 60
    dw String_96_574A_00_34 ; id 61
    dw String_96_574A_00_34 ; id 62
    dw String_96_574A_00_34 ; id 63
    dw String_96_574A_00_34 ; id 64
    dw String_96_574A_00_34 ; id 65
    dw String_96_574A_00_34 ; id 66
    dw String_96_574A_00_34 ; id 67
    dw String_96_574A_00_34 ; id 68
    dw String_96_574A_00_34 ; id 69
    dw String_96_574A_00_34 ; id 70
    dw String_96_574A_00_34 ; id 71
    dw String_96_574A_00_34 ; id 72
    dw String_96_574A_00_34 ; id 73
    dw String_96_574A_00_34 ; id 74
    dw String_96_574A_00_34 ; id 75
    dw String_96_574A_00_34 ; id 76
    dw String_96_574A_00_34 ; id 77
    dw String_96_574A_00_34 ; id 78
    dw String_96_574A_00_34 ; id 79
    dw String_96_574A_00_34 ; id 80
    dw String_96_574A_00_34 ; id 81
    dw String_96_574A_00_34 ; id 82
    dw String_96_574A_00_34 ; id 83
    dw String_96_574A_00_34 ; id 84
    dw String_96_574A_00_34 ; id 85
    dw String_96_574A_00_34 ; id 86
    dw String_96_574A_00_34 ; id 87
    dw String_96_574A_00_34 ; id 88
    dw String_96_574A_00_34 ; id 89
    dw String_96_574A_00_34 ; id 90
    dw String_96_574A_00_34 ; id 91
    dw String_96_574A_00_34 ; id 92
    dw String_96_574A_00_34 ; id 93
    dw String_96_574A_00_34 ; id 94
    dw String_96_574A_00_34 ; id 95
    dw String_96_574A_00_34 ; id 96
    dw String_96_574A_00_34 ; id 97
    dw String_96_574A_00_34 ; id 98
    dw String_96_574A_00_34 ; id 99
    dw String_96_574A_00_34 ; id 100
    dw String_96_574A_00_34 ; id 101
    dw String_96_574A_00_34 ; id 102
    dw String_96_574A_00_34 ; id 103
    dw String_96_574A_00_34 ; id 104
    dw String_96_574A_00_34 ; id 105
    dw String_96_574A_00_34 ; id 106
    dw String_96_574A_00_34 ; id 107
    dw String_96_574A_00_34 ; id 108
    dw String_96_574A_00_34 ; id 109
    dw String_96_574A_00_34 ; id 110
    dw String_96_574A_00_34 ; id 111

String_96_574A_00_00:: ; heuristic: string; C0
Data_096_582C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " So you're", $F1
    db "confident, huh?", $FA, $F7
    db $EF, $EE, "Let's go down to", $EF, $EE, "the Arena!", $F7
    db $F0

String_96_574A_00_01:: ; heuristic: string; C0
Data_096_586E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " What?", $F1
    db "Scared, ", $F9, "0?", $F7
    db $F0

String_96_574A_00_02:: ; heuristic: string; C0
Data_096_588A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Well, uh,", $F1
    db "luck and status", $FA, $F7
    db $EF, $EE, "and conditions and", $EF, $EE, "other factors just", $FA, $F7
    db $EF, $EE, "weren't right today", $EF, $EE, "for me to win.", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $F7
    db $F0

String_96_574A_00_03:: ; heuristic: string; C0
Data_096_5941:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Elf Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_96_574A_00_04:: ; heuristic: string; C0
Data_096_595F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Well, uh,", $F1
    db "luck and status", $FA, $F7
    db $EF, $EE, "and conditions and", $EF, $EE, "other factors just", $FA, $F7
    db $EF, $EE, "weren't right today", $EF, $EE, "for me to win.", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $FA, $F7
    db $EF, $EE, $A4, "Your key ring's", $EF, $EE, "full. Later, then.", $F7
    db $F0

String_96_574A_00_05:: ; heuristic: string; C0
Data_096_5A3D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " What?", $F1
    db "Oh, it's ", $F9, "0.", $FA, $F7
    db $EF, $EE, "Did you want", $EF, $EE, "something?", $FA, $F7
    db $EF, $EE, "Just joking, you", $EF, $EE, "came for this.", $F7
    db $F0

String_96_574A_00_06:: ; heuristic: string; C0
Data_096_5A99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " What?", $F1
    db "Oh, it's ", $F9, "0.", $FA, $F7
    db $EF, $EE, "Did you want", $EF, $EE, "something?", $FA, $F7
    db $EF, $EE, "Just joking, you", $EF, $EE, "came for this.", $FA, $F7
    db $EF, $EE, $A4, "Your key ring's", $EF, $EE, "full. Later, then.", $F7
    db $F0

String_96_574A_00_07:: ; heuristic: string; C0
Data_096_5B1C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Wahahahah!", $F1
    db "You're weak!", $FA, $F7
    db $EF, $EE, "You're a lot weaker", $EF, $EE, "than I expected!", $FA, $F7
    db $EF, $EE, "I'll take you on", $EF, $EE, "whenever you want!", $F7
    db $F0

String_96_574A_00_08:: ; heuristic: string; C0
Data_096_5B8C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Watch me,", $F1
    db "I'm going to train", $FA, $F7
    db $EF, $EE, "in other worlds", $EF, $EE, "and flatten you!", $FA, $F7
    db $EF, $EE, "You're my rival,", $EF, $EE, "so don't you dare", $FA, $F7
    db $EF, $EE, "lose to anyone", $EF, $EE, "else before me!", $F7
    db $F0

String_96_574A_00_09:: ; heuristic: string; C0
Data_096_5C1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " ", $A4, "Whew.", $F1
    db "That was special.", $FA, $F7
    db $EF, $EE, "I may have lost", $EF, $EE, "the battle, but I", $FA, $F7
    db $EF, $EE, "had you beat in", $EF, $EE, "technique.", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $F7
    db $F0

String_96_574A_00_0A:: ; heuristic: string; C0
Data_096_5CCA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Lonely Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_96_574A_00_0B:: ; heuristic: string; C0
Data_096_5CEB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " ", $A4, "Whew.", $F1
    db "That was special.", $FA, $F7
    db $EF, $EE, "I may have lost", $EF, $EE, "the battle, but I", $FA, $F7
    db $EF, $EE, "had you beat in", $EF, $EE, "technique.", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $FA, $F7
    db $EF, $EE, $A4, "Your key ring's", $EF, $EE, "full. Later, then.", $F7
    db $F0

String_96_574A_00_0C:: ; heuristic: string; C0
Data_096_5DBD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " That was a", $F1
    db "good warmup!", $FA, $F7
    db $EF, $EE, "Are you ready for", $EF, $EE, "the real thing?", $FA, $F7
    db $EF, $EE, "The last one", $EF, $EE, "standing wins!", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $F7
    db $F0

String_96_574A_00_0D:: ; heuristic: string; C0
Data_096_5E68:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Traveler Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_96_574A_00_0E:: ; heuristic: string; C0
Data_096_5E8B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " That was a", $F1
    db "good warmup!", $FA, $F7
    db $EF, $EE, "Are you ready for", $EF, $EE, "the real thing?", $FA, $F7
    db $EF, $EE, "The last one", $EF, $EE, "standing wins!", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $FA, $F7
    db $EF, $EE, $A4, "Your key ring's", $EF, $EE, "full. Later, then.", $F7
    db $F0

String_96_574A_00_0F:: ; heuristic: string; C0
Data_096_5F5D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Whew", $A4, $F1
    db "Close, real close.", $FA, $F7
    db $EF, $EE, "I", $44, " say our skills", $EF, $EE, "are almost equal.", $FA, $F7
    db $EF, $EE, "You don't have the", $EF, $EE, "confidence to beat", $FA, $F7
    db $EF, $EE, "me again, do you?", $EF, $EE, "I can tell.", $FA, $F7
    db $EF, $EE, "Oh, OK, a loss is", $EF, $EE, "a loss.", $FA, $F7
    db $EF, $EE, "Here's my best", $EF, $EE, "Magic Key.", $F7
    db $F0

String_96_574A_00_10:: ; heuristic: string; C0
Data_096_602E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Brawn Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_96_574A_00_11:: ; heuristic: string; C0
Data_096_604E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Whew", $A4, $F1
    db "Close, real close.", $FA, $F7
    db $EF, $EE, "I", $44, " say our skills", $EF, $EE, "are almost equal.", $FA, $F7
    db $EF, $EE, "You don't have the", $EF, $EE, "confidence to beat", $FA, $F7
    db $EF, $EE, "me again, do you?", $EF, $EE, "I can tell.", $FA, $F7
    db $EF, $EE, "Oh, OK, a loss is", $EF, $EE, "a loss.", $FA, $F7
    db $EF, $EE, "Here's my best", $EF, $EE, "Magic Key.", $FA, $F7
    db $EF, $EE, $A4, "Your key ring's", $EF, $EE, "full. Later, then.", $F7
    db $F0

String_96_574A_00_12:: ; heuristic: string; C0
Data_096_6146:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Tch, right", $F1
    db "to the end I could", $FA, $F7
    db $EF, $EE, "never beat you,", $EF, $EE, $F9, "0.", $FA, $F7
    db $EF, $EE, "I don't have any", $EF, $EE, "more rare keys,", $FA, $F7
    db $EF, $EE, "but we should keep", $EF, $EE, "battling.", $FA, $F7
    db $EF, $EE, "After all, we're", $EF, $EE, "still rivals!", $F7
    db $F0

String_96_574A_00_13:: ; heuristic: string; C0
Data_096_61ED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "I was thinking", $A4, $FA, $F7
    db $EF, $EE, "GreatLog isn't in", $EF, $EE, "danger anymore.", $FA, $F7
    db $EF, $EE, "It doesn't matter", $EF, $EE, "if I'm not here.", $FA, $F7
    db $EF, $EE, "I want to go on a", $EF, $EE, "journey, warooh!", $FA, $F7
    db $EF, $EE, "Will you take me", $EF, $EE, "with you, warooh?", $FA, $F7
    db $EF, $EE, "Oh? But there's no", $EF, $EE, "room for me", $A4, $F7
    db $F0

String_96_574A_00_14:: ; heuristic: string; C0
Data_096_62CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "I was thinking", $A4, $FA, $F7
    db $EF, $EE, "GreatLog isn't in", $EF, $EE, "danger anymore.", $FA, $F7
    db $EF, $EE, "It doesn't matter", $EF, $EE, "if I'm not here.", $FA, $F7
    db $EF, $EE, "I want to go on a", $EF, $EE, "journey, warooh!", $FA, $F7
    db $EF, $EE, "Will you take me", $EF, $EE, "with you, warooh?", $FF, $F0

String_96_574A_00_15:: ; heuristic: string; C0
Data_096_6386:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Good, good, good!", $FA, $F7
    db $EF, $EE, "I knew I could", $EF, $EE, "count on you!", $FA, $F7
    db $EF, $EE, "Wa-hey, Petibou", $EF, $EE, "come here!", $F7
    db $F0

String_96_574A_00_16:: ; heuristic: string; C0
Data_096_63EB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " What?", $F1
    db "This little kid?", $FA, $F7
    db $EF, $EE, "This is really a", $EF, $EE, "monster master?", $FA, $F7
    db $EF, $EE, "But Papa said so,", $EF, $EE, "so I'll do it.", $F7
    db $F0

String_96_574A_00_17:: ; heuristic: string; C0
Data_096_6456:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "my kid has a big", $FA, $F7
    db $EF, $EE, "mouth, but Petibou", $EF, $EE, "will be useful.", $FA, $F7
    db $EF, $EE, "I will be at the", $EF, $EE, "farm, warooh.", $F7
    db $F0

String_96_574A_00_18:: ; heuristic: string; C0
Data_096_64C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " It's sort", $F1
    db "of boring guarding", $FA, $F7
    db $EF, $EE, "the Log's Navel", $EF, $EE, "like this", $A4, $FA, $F7
    db $EF, $EE, "Maybe I'll pull", $EF, $EE, "out the plug", $A4, $FA, $F7
    db $EF, $EE, "I'm joking! Tch,", $EF, $EE, "you look scary!", $F7
    db $F0

String_96_574A_00_19:: ; heuristic: string; C0
Data_096_654E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You need to", $F1
    db "strike the right", $FA, $F7
    db $EF, $EE, "balance of skills", $EF, $EE, "and abilities.", $FA, $F7
    db $EF, $EE, "That's important", $EF, $EE, "for winning!", $F7
    db $F0

String_96_574A_00_1D:: ; heuristic: string; C0
Data_096_65B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Humph", $A4, $F1
    db "I'm Terry.", $FA, $F7
    db $EF, $EE, "I'm a master from", $EF, $EE, "GreatTree.", $FA, $F7
    db $EF, $EE, "I", $44, " heard about", $EF, $EE, "GreatLog's heroic", $FA, $F7
    db $EF, $EE, "master, so I came", $EF, $EE, "to look.", $FA, $F7
    db $EF, $EE, "Are you that", $EF, $EE, "master?", $FA, $F7
    db $EF, $EE, "I can't tell by", $EF, $EE, "the way you look,", $FA, $F7
    db $EF, $EE, "but a battle will", $EF, $EE, "prove it.", $FA, $F7
    db $EF, $EE, "Do you feel like", $EF, $EE, "battling me?", $FF, $F0

String_96_574A_00_1E:: ; heuristic: string; C0
Data_096_66AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " Humph", $A4, $F1
    db "Confident, huh?", $FA, $F7
    db $EF, $EE, "I'll tell you", $EF, $EE, "right now, I'm", $FA, $F7
    db $EF, $EE, "pretty confident", $EF, $EE, "too.", $FA, $F7
    db $EF, $EE, "I'll see you in", $EF, $EE, "the ring.", $F7
    db $F0

String_96_574A_00_1F:: ; heuristic: string; C0
Data_096_6723:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " Oh, it was", $F1
    db "someone else?", $FA, $F7
    db $EF, $EE, "So much for my", $EF, $EE, "instinct.", $FA, $F7
    db $EF, $EE, "I was looking", $EF, $EE, "forward to seeing", $FA, $F7
    db $EF, $EE, "GreatLog's savior", $EF, $EE, "in battle.", $F7
    db $F0

String_96_574A_00_20:: ; heuristic: string; C0
Data_096_67A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " I", $44, " heard", $F1
    db "about GreatLog's", $FA, $F7
    db $EF, $EE, "heroic master, so", $EF, $EE, "I came to look.", $FA, $F7
    db $EF, $EE, "Are you that", $EF, $EE, "master?", $FA, $F7
    db $EF, $EE, "I can't tell by", $EF, $EE, "the way you look,", $FA, $F7
    db $EF, $EE, "but a battle will", $EF, $EE, "prove it.", $FA, $F7
    db $EF, $EE, "Do you feel like", $EF, $EE, "battling me?", $FF, $F0

String_96_574A_00_21:: ; heuristic: string; C0
Data_096_686E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " Well, this", $F1
    db "proves that I have", $FA, $F7
    db $EF, $EE, "lots to learn", $EF, $EE, "still.", $FA, $F7
    db $EF, $EE, "I hope you'll stay", $EF, $EE, "a good rival.", $FA, $F7
    db $EF, $EE, "If it's all right", $EF, $EE, "with you, we ought", $FA, $F7
    db $EF, $EE, "to breed our", $EF, $EE, "monsters sometime.", $F7
    db $F0

String_96_574A_00_22:: ; heuristic: string; C0
Data_096_691E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " Humph", $A4, $F1
    db "Don't take it hard.", $FA, $F7
    db $EF, $EE, "You really weren't", $EF, $EE, "weak.", $FA, $F7
    db $EF, $EE, "I was just a bit", $EF, $EE, "better, that's all.", $F7
    db $F0

String_96_574A_00_23:: ; heuristic: string; C0
Data_096_6985:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " I hope", $F1
    db "you'll stay a good", $FA, $F7
    db $EF, $EE, "rival of mine", $EF, $EE, "after this.", $FA, $F7
    db $EF, $EE, "If it's all right", $EF, $EE, "with you, we ought", $FA, $F7
    db $EF, $EE, "to breed our", $EF, $EE, "monsters sometime.", $F7
    db $F0

String_96_574A_00_24:: ; heuristic: string; C0
Data_096_6A11:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There are still", $F1
    db "many things that I", $FA, $F7
    db $EF, $EE, "know nothing about", $EF, $EE, "in the world.", $FA, $F7
    db $EF, $EE, "That's why life is", $EF, $EE, "so exciting.", $FA, $F7
    db $EF, $EE, "I'm not calling it", $EF, $EE, "quits yet!", $F7
    db $F0

String_96_574A_00_25:: ; heuristic: string; C0
Data_096_6AA1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "Baffle Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_96_574A_00_26:: ; heuristic: string; C0
Data_096_6AC2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 found a", $F1
    db "Magic Key.", $FA, $F7
    db $EF, $EE, "But the key ring", $EF, $EE, "is full.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Magic Key back.", $F7
    db $F0

String_96_574A_00_27:: ; heuristic: string; C0
Data_096_6B16:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "Soul Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_96_574A_00_28:: ; heuristic: string; C0
Data_096_6B35:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 found a", $F1
    db "Magic Key.", $FA, $F7
    db $EF, $EE, "But the key ring", $EF, $EE, "is full.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Magic Key back.", $F7
    db $F0

String_96_574A_00_29:: ; heuristic: string; C0
Data_096_6B89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " GreatLog appears", $F1
    db "to have returned", $FA, $F7
    db $EF, $EE, "to normal, the way", $EF, $EE, "it once was.", $FA, $F7
    db $EF, $EE, "On second thought,", $EF, $EE, "perhaps not.", $FA, $F7
    db $EF, $EE, "It looks better", $EF, $EE, "than before!", $F7
    db $F0

String_96_574A_00_2A:: ; heuristic: string; C0
Data_096_6C18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'm feeling", $F1
    db "invigorated too.", $FA, $F7
    db $EF, $EE, "I want to live as", $EF, $EE, "long as GreatLog!", $F7
    db $F0

String_96_574A_00_2B:: ; heuristic: string; C0
Data_096_6C60:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, GreatLog's", $F1
    db "savior!", $FA, $F7
    db $EF, $EE, "Are you taking a", $EF, $EE, "break from your", $FA, $F7
    db $EF, $EE, "otherworldly", $EF, $EE, "journeys?", $FA, $F7
    db $EF, $EE, "The view from here", $EF, $EE, "is said to be the", $FA, $F7
    db $EF, $EE, "best in all", $EF, $EE, "GreatLog!", $F7
    db $F0

String_96_574A_00_2C:: ; heuristic: string; C0
Data_096_6CFD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The island has", $F1
    db "become more lush", $FA, $F7
    db $EF, $EE, "and green. Thank", $EF, $EE, "you, hero!", $F7
    db $F0

String_96_574A_00_2D:: ; heuristic: string; C0
Data_096_6D41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " There's something", $F1
    db "wrong with Emyu", $A4, $FA, $F7
    db $EF, $EE, "It's become a bit", $EF, $EE, "too energetic.", $FA, $F7
    db $EF, $EE, "What can I do", $EF, $EE, "about it?", $F7
    db $F0

String_96_574A_00_2E:: ; heuristic: string; C0
Data_096_6DA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, hey, hey!", $F1
    db "We have to hustle!", $FA, $F7
    db $EF, $EE, "We have to move to", $EF, $EE, "find a new groove!", $F7
    db $F0

String_96_574A_00_2F:: ; heuristic: string; C0
Data_096_6DF7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How good of you", $F1
    db "to overcome those", $FA, $F7
    db $EF, $EE, "demanding trials,", $EF, $EE, "my little friend!", $FA, $F7
    db $EF, $EE, "You", $42, "e certainly", $EF, $EE, "impressed me!", $FA, $F7
    db $EF, $EE, "Take this!", $EF, $EE, "It's a gift!", $F7
    db $F0

String_96_574A_00_30:: ; heuristic: string; C0
Data_096_6E82:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "Magic Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_96_574A_00_31:: ; heuristic: string; C0
Data_096_6EA2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But there was", $F1
    db "nothing there.", $F7
    db $F0

String_96_574A_00_32:: ; heuristic: string; C0
Data_096_6EC0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Magic Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_96_574A_00_33:: ; heuristic: string; C0
Data_096_6EE0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "desk.", $F7
    db $F0

String_96_574A_00_34:: ; heuristic: string; C0
Data_096_6EF6:: ; address name
    db $F0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_96_6EF7:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
Script_96_6EF8:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F06, Script_96_6F03, Script_96_6EFD
Script_96_6EFD:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CLOSE
    script_message $800A ; 'Please come see me when you'
    script_command SCRIPT_BREED_CLOSE
    script_end
Script_96_6F03:: ; heuristic: event script entry or jump target; C0
    script_jump Script_96_6FBA
Script_96_6F06:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F13, Script_96_6F0A
Script_96_6F0A:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; 'Um You don't have any eggs'
    script_message $C004 ; 'How else may I serve you?'
    script_jump Script_96_6EF8
Script_96_6F13:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Which egg should I appraise?'
Script_96_6F16:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F21, Script_96_6F1A
Script_96_6F1A:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; 'How else may I serve you?'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6EF8
Script_96_6F21:: ; heuristic: event script entry or jump target; C0
    script_message $C003 ; 'It will cost 20G. It that'
Script_96_6F24:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F30, Script_96_6F34, Script_96_6F29
Script_96_6F29:: ; heuristic: event script entry or jump target; C0
    script_message $C002 ; 'Which egg should I appraise?'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6F16
Script_96_6F30:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6F24
Script_96_6F34:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F3E, Script_96_6F38
Script_96_6F38:: ; heuristic: event script entry or jump target; C0
    script_message $C005 ; 'Um You don't have enough gold'
    script_jump Script_96_6FEF
Script_96_6F3E:: ; heuristic: event script entry or jump target; C0
    script_message $C00B ; 'OK, I'll evaluate this egg now'
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F47, Script_96_6F4D, Script_96_6F53, Script_96_6F59
Script_96_6F47:: ; heuristic: event script entry or jump target; C0
    script_message $C00C ; 'It's fine. There's nothing wrong.'
    script_jump Script_96_6F5C
Script_96_6F4D:: ; heuristic: event script entry or jump target; C0
    script_message $C00D ; 'It's good, and growing healthy.'
    script_jump Script_96_6F5C
Script_96_6F53:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; 'Wow, this egg is really vigorous.'
    script_jump Script_96_6F5C
Script_96_6F59:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; 'Oh, my! This egg is incredible!'
Script_96_6F5C:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F62, Script_96_6F68, Script_96_6F6E, Script_96_6F74
Script_96_6F62:: ; heuristic: event script entry or jump target; C0
    script_message $C010 ; 'Don't expect too many skills.'
    script_jump Script_96_6F77
Script_96_6F68:: ; heuristic: event script entry or jump target; C0
    script_message $C011 ; 'It has a fair number of'
    script_jump Script_96_6F77
Script_96_6F6E:: ; heuristic: event script entry or jump target; C0
    script_message $C012 ; 'It inherited its parents skills.'
    script_jump Script_96_6F77
Script_96_6F74:: ; heuristic: event script entry or jump target; C0
    script_message $C013 ; 'It knows a great variety of'
Script_96_6F77:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F7D, Script_96_6F83, Script_96_6F89, Script_96_6F8F
Script_96_6F7D:: ; heuristic: event script entry or jump target; C0
    script_message $C014 ; 'Its growth may be a bit'
    script_jump Script_96_6F92
Script_96_6F83:: ; heuristic: event script entry or jump target; C0
    script_message $C015 ; 'It will grow in an average'
    script_jump Script_96_6F92
Script_96_6F89:: ; heuristic: event script entry or jump target; C0
    script_message $C016 ; 'It will be hard to raise'
    script_jump Script_96_6F92
Script_96_6F8F:: ; heuristic: event script entry or jump target; C0
    script_message $C017 ; 'Its growth can't be faulted.'
Script_96_6F92:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6F97, Script_96_6F9D, Script_96_6FA3
Script_96_6F97:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'It appears to be a hard'
    script_jump Script_96_6FA6
Script_96_6F9D:: ; heuristic: event script entry or jump target; C0
    script_message $C019 ; 'This one seems to be quite'
    script_jump Script_96_6FA6
Script_96_6FA3:: ; heuristic: event script entry or jump target; C0
    script_message $C01A ; 'I can tell this one is'
Script_96_6FA6:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6FAA, Script_96_6FB0
Script_96_6FAA:: ; heuristic: event script entry or jump target; C0
    script_message $C01B ; 'No doubt at all-it's male.'
    script_jump Script_96_6FB3
Script_96_6FB0:: ; heuristic: event script entry or jump target; C0
    script_message $C01C ; 'No doubt at all-it's female.'
Script_96_6FB3:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_message $C01D ; 'That's the best I could do'
    script_jump Script_96_6FEF
Script_96_6FBA:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6FC1, Script_96_6FBE
Script_96_6FBE:: ; heuristic: event script entry or jump target; C0
    script_jump Script_96_6F0A
Script_96_6FC1:: ; heuristic: event script entry or jump target; C0
    script_message $C007 ; 'Which egg should I bless?'
Script_96_6FC4:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6FCF, Script_96_6FC8
Script_96_6FC8:: ; heuristic: event script entry or jump target; C0
    script_message $C004 ; 'How else may I serve you?'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6EF8
Script_96_6FCF:: ; heuristic: event script entry or jump target; C0
    script_message $C008 ; 'It will cost 0G. Is that'
Script_96_6FD2:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6FDE, Script_96_6FE2, Script_96_6FD7
Script_96_6FD7:: ; heuristic: event script entry or jump target; C0
    script_message $C007 ; 'Which egg should I bless?'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6FC4
Script_96_6FDE:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6FD2
Script_96_6FE2:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_choice_jump Script_96_6FEC, Script_96_6FE6
Script_96_6FE6:: ; heuristic: event script entry or jump target; C0
    script_message $C005 ; 'Um You don't have enough gold'
    script_jump Script_96_6FEF
Script_96_6FEC:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; 'Egg, egg, toss and scramble 0'
Script_96_6FEF:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_EGG_SERVICE
    script_command SCRIPT_EGG_SERVICE
    script_message $C004 ; 'How else may I serve you?'
    script_command SCRIPT_EGG_SERVICE
    script_jump Script_96_6EF8
Script_96_6FF8:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_RENAME
    script_command SCRIPT_RENAME
    script_choice_jump Script_96_7003, Script_96_6FFD
Script_96_6FFD:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_RENAME_CLOSE
    script_message $8022 ; 'Come here for renaming monsters.'
    script_command SCRIPT_RENAME_CLOSE
    script_end
Script_96_7003:: ; heuristic: event script entry or jump target; C0
    script_message $C023 ; 'Pick the monster to rename.'
Script_96_7006:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_RENAME
    script_choice_jump Script_96_700D, Script_96_700A
Script_96_700A:: ; heuristic: event script entry or jump target; C0
    script_jump Script_96_6FFD
Script_96_700D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_RENAME
    script_jump Script_96_7006

; only called from DebugMessageTest_Update_Case1C_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugMessageTest_Update_Case1C_Sub01_BeginStringDisplay_Sub01)
; reads: wStringIndex
; writes: wStringIndex
DebugMessageTest_Update_Case1C_Sub01_BeginStringDisplay::
Func_096_7011:: ; address name
    ld de, MessageStrings_Bank0E_Overflow
    ld a, [wStringIndex]
    sub a, $88
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $0E: wStringIndex -= $88, then CopyStringToBuffer with the table Data_096_7036 in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank0E)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank0E_Overflow:: ; heuristic: follows a terminator; C0
Func_096_7020:: ; address name
    ld de, MessageStrings_Bank0E_Overflow
    ld a, [wStringIndex]
    sub a, $88
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $11, $70, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_96_7036::
MessageStrings_Bank0E_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_096_7036:: ; address name
    dw StringList_96_7038 ; id 0

; E-0217 (derived: category list of StringCategories_96_7036; one pointer per wStringIndex)
; record: string
StringList_96_7038::
Data_096_7038:: ; address name
    dw String_96_7036_00_00 ; id 0
    dw String_96_7036_00_01 ; id 1
    dw String_96_7036_00_02 ; id 2
    dw String_96_7036_00_03 ; id 3
    dw String_96_7036_00_04 ; id 4
    dw String_96_7036_00_05 ; id 5
    dw String_96_7036_00_05 ; id 6
    dw String_96_7036_00_05 ; id 7
    dw String_96_7036_00_05 ; id 8
    dw String_96_7036_00_05 ; id 9
    dw String_96_7036_00_05 ; id 10
    dw String_96_7036_00_0B ; id 11
    dw String_96_7036_00_0C ; id 12
    dw String_96_7036_00_0D ; id 13
    dw String_96_7036_00_0E ; id 14
    dw String_96_7036_00_0F ; id 15
    dw String_96_7036_00_10 ; id 16
    dw String_96_7036_00_11 ; id 17
    dw String_96_7036_00_12 ; id 18
    dw String_96_7036_00_13 ; id 19
    dw String_96_7036_00_14 ; id 20
    dw String_96_7036_00_15 ; id 21
    dw String_96_7036_00_15 ; id 22
    dw String_96_7036_00_15 ; id 23

String_96_7036_00_00:: ; heuristic: string; C0
Data_096_7068:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, hey.", $F1
    db "Well, looky here.", $FA, $F7
    db $EF, $EE, "Something great's", $EF, $EE, "going to result.", $FA, $F7
    db $EF, $EE, "We have to let", $EF, $EE, "this pair breed.", $F0

String_96_7036_00_01:: ; heuristic: string; C0
Data_096_70D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " OK? Let's not", $F1
    db "waste any time.", $F7
    db $F0

String_96_7036_00_02:: ; heuristic: string; C0
Data_096_70F2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " All right, we'll", $F1
    db "have to do this", $FA, $F7
    db $EF, $EE, "again another", $EF, $EE, "time.", $F7
    db $F0

String_96_7036_00_03:: ; heuristic: string; C0
Data_096_712E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0", $F1
    db "will be in your", $FA, $F7
    db $EF, $EE, "egg.", $FA, $F7
    db $EF, $EE, "Want to do this", $EF, $EE, "breeding?", $F0

String_96_7036_00_04:: ; heuristic: string; C0
Data_096_716A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Its accessory is", $F1
    db "in the Vault now.", $F7
    db $F0

String_96_7036_00_05:: ; heuristic: string; C0
Data_096_7191:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm, that's too", $F1
    db "bad, then.", $FA, $F7
    db $EF, $EE, "It's a wasted", $EF, $EE, "opportunity", $A4, $F7
    db $F0

String_96_7036_00_0B:: ; heuristic: string; C0
Data_096_71CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What will be my", $F1
    db "StoneMan's mate?", $F0

String_96_7036_00_0C:: ; heuristic: string; C0
Data_096_71EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Listen, child.", $F1
    db "How would you like", $FA, $F7
    db $EF, $EE, "to breed something", $EF, $EE, "with my StoneMan?", $F0

String_96_7036_00_0D:: ; heuristic: string; C0
Data_096_723D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is that your", $F1
    db "choice?", $F0

String_96_7036_00_0E:: ; heuristic: string; C0
Data_096_7255:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $44, " rather you", $F1
    db "didn't use such a ", $FA, $F7
    db $EF, $EE, "low-level monster", $EF, $EE, "for breeding.", $F7
    db $F0

String_96_7036_00_0F:: ; heuristic: string; C0
Data_096_729D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You mustn't be", $F1
    db "all alone.", $F7
    db $F0

String_96_7036_00_10:: ; heuristic: string; C0
Data_096_72BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm? Well, well.", $F1
    db "Something a little", $FA, $F7
    db $EF, $EE, "extraordinary will", $EF, $EE, "be the result.", $FA, $F7
    db $EF, $EE, "Well, do you wish", $EF, $EE, "to proceed?", $F0

String_96_7036_00_11:: ; heuristic: string; C0
Data_096_7328:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I like that", $F1
    db "reply! Let's start.", $F7
    db $F0

String_96_7036_00_12:: ; heuristic: string; C0
Data_096_734B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Thank you, my", $F1
    db "little friend!", $FA, $F7
    db $EF, $EE, "We'll have to do", $EF, $EE, "this again.", $F7
    db $F0

String_96_7036_00_13:: ; heuristic: string; C0
Data_096_738C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0", $F1
    db "will be your baby.", $FA, $F7
    db $EF, $EE, "Is that acceptable", $EF, $EE, "to you?", $F0

String_96_7036_00_14:: ; heuristic: string; C0
Data_096_73C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Its accessory is", $F1
    db "in the Vault.", $F7
    db $F0

String_96_7036_00_15:: ; heuristic: string; C0
Data_096_73E7:: ; address name
    db $F0
    ds $C18, $00
