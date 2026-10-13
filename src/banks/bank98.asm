SECTION "Bank 98", ROMX[$4000], BANK[$98]
    db $98

; overflow for message bank $2B: wStringIndex -= $8A, then BeginStringDisplay with the table Data_098_4070 in this bank (E-0080)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank2B)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank2B_Overflow::
Func_098_4001:: ; address name
    ld de, MessageStrings_Bank2B_Overflow
    ld a, [wStringIndex]
    sub a, $8A
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2B: wStringIndex -= $8A, then CopyStringToBuffer with the table Data_098_4070 in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank2B)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank2B_Overflow:: ; heuristic: follows a terminator; C0
Func_098_4010:: ; address name
    ld de, MessageStrings_Bank2B_Overflow
    ld a, [wStringIndex]
    sub a, $8A
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; overflow for message bank $2C: wStringIndex -= $91, then BeginStringDisplay with the table Data_098_572E in this bank (E-0080)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank2C)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank2C_Overflow::
Func_098_4026:: ; address name
    ld de, MessageStrings_Bank2C_Overflow
    ld a, [wStringIndex]
    sub a, $91
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2C: wStringIndex -= $91, then CopyStringToBuffer with the table Data_098_572E in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank2C)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank2C_Overflow:: ; heuristic: follows a terminator; C0
Func_098_4035:: ; address name
    ld de, MessageStrings_Bank2C_Overflow
    ld a, [wStringIndex]
    sub a, $91
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $26, $40, $CD, $11, $26, $C9

; overflow for message bank $89: wStringIndex -= $DE, then BeginStringDisplay with the table Data_098_7032 in this bank (E-0080)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank89)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank89_Overflow::
Func_098_404B:: ; address name
    ld de, MessageStrings_Bank89_Overflow
    ld a, [wStringIndex]
    sub a, $DE
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $89: wStringIndex -= $DE, then CopyStringToBuffer with the table Data_098_7032 in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank89)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank89_Overflow:: ; heuristic: follows a terminator; C0
Func_098_405A:: ; address name
    ld de, MessageStrings_Bank89_Overflow
    ld a, [wStringIndex]
    sub a, $DE
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $4B, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_98_4070::
MessageStrings_Bank2B_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_098_4070:: ; address name
    dw StringList_98_4072 ; id 0

; E-0217 (derived: category list of StringCategories_98_4070; one pointer per wStringIndex)
; record: string
StringList_98_4072::
Data_098_4072:: ; address name
    dw String_98_4070_00_00 ; id 0
    dw String_98_4070_00_01 ; id 1
    dw String_98_4070_00_02 ; id 2
    dw String_98_4070_00_03 ; id 3
    dw String_98_4070_00_04 ; id 4
    dw String_98_4070_00_05 ; id 5
    dw String_98_4070_00_06 ; id 6
    dw String_98_4070_00_07 ; id 7
    dw String_98_4070_00_08 ; id 8
    dw String_98_4070_00_09 ; id 9
    dw String_98_4070_00_0A ; id 10
    dw String_98_4070_00_0B ; id 11
    dw String_98_4070_00_0C ; id 12
    dw String_98_4070_00_0D ; id 13
    dw String_98_4070_00_0E ; id 14
    dw String_98_4070_00_0F ; id 15
    dw String_98_4070_00_10 ; id 16
    dw String_98_4070_00_11 ; id 17
    dw String_98_4070_00_12 ; id 18
    dw String_98_4070_00_13 ; id 19
    dw String_98_4070_00_14 ; id 20
    dw String_98_4070_00_15 ; id 21
    dw String_98_4070_00_16 ; id 22
    dw String_98_4070_00_17 ; id 23
    dw String_98_4070_00_18 ; id 24
    dw String_98_4070_00_19 ; id 25
    dw String_98_4070_00_1A ; id 26
    dw String_98_4070_00_1B ; id 27
    dw String_98_4070_00_1C ; id 28
    dw String_98_4070_00_1D ; id 29
    dw String_98_4070_00_1E ; id 30
    dw String_98_4070_00_1F ; id 31
    dw String_98_4070_00_20 ; id 32
    dw String_98_4070_00_21 ; id 33
    dw String_98_4070_00_22 ; id 34
    dw String_98_4070_00_23 ; id 35
    dw String_98_4070_00_24 ; id 36
    dw String_98_4070_00_25 ; id 37
    dw String_98_4070_00_26 ; id 38
    dw String_98_4070_00_27 ; id 39
    dw String_98_4070_00_28 ; id 40
    dw String_98_4070_00_29 ; id 41
    dw String_98_4070_00_2A ; id 42
    dw String_98_4070_00_2B ; id 43
    dw String_98_4070_00_2C ; id 44
    dw String_98_4070_00_2D ; id 45
    dw String_98_4070_00_2E ; id 46
    dw String_98_4070_00_2F ; id 47
    dw String_98_4070_00_30 ; id 48
    dw String_98_4070_00_30 ; id 49
    dw String_98_4070_00_30 ; id 50
    dw String_98_4070_00_30 ; id 51
    dw String_98_4070_00_30 ; id 52
    dw String_98_4070_00_30 ; id 53
    dw String_98_4070_00_30 ; id 54
    dw String_98_4070_00_30 ; id 55
    dw String_98_4070_00_30 ; id 56
    dw String_98_4070_00_39 ; id 57
    dw String_98_4070_00_39 ; id 58
    dw String_98_4070_00_39 ; id 59
    dw String_98_4070_00_39 ; id 60
    dw String_98_4070_00_39 ; id 61
    dw String_98_4070_00_39 ; id 62
    dw String_98_4070_00_39 ; id 63
    dw String_98_4070_00_39 ; id 64
    dw String_98_4070_00_39 ; id 65
    dw String_98_4070_00_39 ; id 66
    dw String_98_4070_00_39 ; id 67
    dw String_98_4070_00_39 ; id 68
    dw String_98_4070_00_39 ; id 69
    dw String_98_4070_00_39 ; id 70
    dw String_98_4070_00_39 ; id 71
    dw String_98_4070_00_39 ; id 72
    dw String_98_4070_00_39 ; id 73
    dw String_98_4070_00_39 ; id 74
    dw String_98_4070_00_39 ; id 75
    dw String_98_4070_00_39 ; id 76
    dw String_98_4070_00_39 ; id 77
    dw String_98_4070_00_39 ; id 78
    dw String_98_4070_00_39 ; id 79
    dw String_98_4070_00_39 ; id 80
    dw String_98_4070_00_39 ; id 81
    dw String_98_4070_00_39 ; id 82
    dw String_98_4070_00_39 ; id 83
    dw String_98_4070_00_39 ; id 84
    dw String_98_4070_00_39 ; id 85
    dw String_98_4070_00_39 ; id 86
    dw String_98_4070_00_39 ; id 87
    dw String_98_4070_00_39 ; id 88
    dw String_98_4070_00_39 ; id 89
    dw String_98_4070_00_39 ; id 90
    dw String_98_4070_00_39 ; id 91
    dw String_98_4070_00_39 ; id 92
    dw String_98_4070_00_39 ; id 93
    dw String_98_4070_00_39 ; id 94
    dw String_98_4070_00_39 ; id 95
    dw String_98_4070_00_39 ; id 96
    dw String_98_4070_00_39 ; id 97
    dw String_98_4070_00_39 ; id 98
    dw String_98_4070_00_39 ; id 99
    dw String_98_4070_00_39 ; id 100
    dw String_98_4070_00_39 ; id 101
    dw String_98_4070_00_39 ; id 102
    dw String_98_4070_00_39 ; id 103
    dw String_98_4070_00_39 ; id 104
    dw String_98_4070_00_39 ; id 105
    dw String_98_4070_00_39 ; id 106
    dw String_98_4070_00_39 ; id 107
    dw String_98_4070_00_39 ; id 108
    dw String_98_4070_00_39 ; id 109
    dw String_98_4070_00_39 ; id 110
    dw String_98_4070_00_39 ; id 111
    dw String_98_4070_00_39 ; id 112

String_98_4070_00_00:: ; heuristic: string; C0
Data_098_4154:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A woodsman came", $F1
    db "by a while back.", $FA, $F7
    db $EF, $EE, "He said something", $EF, $EE, "very disturbing.", $FA, $F7
    db $EF, $EE, "He was in the big", $EF, $EE, "forest, which is", $FA, $F7
    db $EF, $EE, "across the bridge", $EF, $EE, "south of town.", $FA, $F7
    db $EF, $EE, "He claims to have", $EF, $EE, "been chased by the", $FA, $F7
    db $EF, $EE, "ghost of a young", $EF, $EE, "woman.", $FA, $F7
    db $EF, $EE, "The forest looks", $EF, $EE, "ordinary, but", $A4, $F7
    db $F0

String_98_4070_00_01:: ; heuristic: string; C0
Data_098_4255:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello! How may I", $F1
    db "serve you?", $F7
    db $F0

String_98_4070_00_02:: ; heuristic: string; C0
Data_098_4275:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The lake is", $F1
    db "frozen, so I can't", $FA, $F7
    db $EF, $EE, "very well take my", $EF, $EE, "boat out.", $FA, $F7
    db $EF, $EE, "The north winds", $EF, $EE, "seem to be unduly", $FA, $F7
    db $EF, $EE, "harsh this year", $EF, $EE, "for some reason.", $F7
    db $F0

String_98_4070_00_03:: ; heuristic: string; C0
Data_098_4302:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is Westania", $F1
    db "Castle.", $FA, $F7
    db $EF, $EE, "Westania is the", $EF, $EE, "kingdom to the", $FA, $F7
    db $EF, $EE, "west of the lake.", $EF, $EE, $F7
    db $F0

String_98_4070_00_04:: ; heuristic: string; C0
Data_098_4359:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Nobody fails to", $F1
    db "be impressed when", $FA, $F7
    db $EF, $EE, "I breathe fire,", $EF, $EE, "and I mean nobody!", $FA, $F7
    db $EF, $EE, "I'm sure Lady Yuna", $EF, $EE, "will be delighted", $FA, $F7
    db $EF, $EE, "when she sees my", $EF, $EE, "act.", $F7
    db $F0

String_98_4070_00_05:: ; heuristic: string; C0
Data_098_43E8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I've brought with", $F1
    db "me a necklace that", $FA, $F7
    db $EF, $EE, "is studded with", $EF, $EE, "jewels.", $FA, $F7
    db $EF, $EE, "Any woman would be", $EF, $EE, "delighted by it!", $F7
    db $F0

String_98_4070_00_06:: ; heuristic: string; C0
Data_098_4454:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When I balance", $F1
    db "on my ball, people", $FA, $F7
    db $EF, $EE, "simply go wild.", $EF, $EE, "Just watch me!", $F7
    db $F0

String_98_4070_00_07:: ; heuristic: string; C0
Data_098_449D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I hurl knives", $F1
    db "with incredible", $FA, $F7
    db $EF, $EE, "accuracy.", $EF, $EE, "I never miss!", $FA, $F7
    db $EF, $EE, "Even Lady Yuna", $EF, $EE, "will be surprised.", $FA, $F7
    db $EF, $EE, "That'll snap her", $EF, $EE, "out of her funk.", $F7
    db $F0

String_98_4070_00_08:: ; heuristic: string; C0
Data_098_4526:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Please, line up!", $F1
    db "And quit pushing!", $FA, $F7
    db $EF, $EE, "Everyone will get", $EF, $EE, "their turn.", $FA, $F7
    db $EF, $EE, $A4, "Sigh", $A4, " Everyone is", $EF, $EE, "after the reward", $A4, $F7
    db $F0

String_98_4070_00_09:: ; heuristic: string; C0
Data_098_4598:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh", $A4, " Lady Yuna", $A4, $F1
    db "To think that I", $FA, $F7
    db $EF, $EE, "won't get to see", $EF, $EE, "your smile again", $A4, $FA, $F7
    db $EF, $EE, "Oh, it's the end", $EF, $EE, "of the world! Huh?", $FA, $F7
    db $EF, $EE, "Gaaah! What are", $EF, $EE, "you doing here?", $FA, $F7
    db $EF, $EE, "You shouldn't be", $EF, $EE, "eavesdropping!", $F7
    db $F0

String_98_4070_00_0A:: ; heuristic: string; C0
Data_098_464F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, "'Come all who have", $EF, $EE, "the confidence to", $FA, $F7
    db $EF, $EE, "delight Lady Yuna", $EF, $EE, "out of depression.", $FA, $F7
    db $EF, $EE, "Anyone restoring", $EF, $EE, "joyous laughter to", $FA, $F7
    db $EF, $EE, "her will receive a", $EF, $EE, "generous reward.", $95, $F7
    db $F0

String_98_4070_00_0B:: ; heuristic: string; C0
Data_098_4705:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Well, if", $F1
    db "it isn't ", $F9, "0!", $FA, $F7
    db $EF, $EE, "You managed to get", $EF, $EE, "out of the Castle,", $FA, $F7
    db $EF, $EE, "did you? You can", $EF, $EE, "thank me for it.", $FA, $F7
    db $EF, $EE, "I let you have the", $EF, $EE, "glory last time,", $FA, $F7
    db $EF, $EE, "but this time, it", $EF, $EE, "will be mine!", $F7
    db $F0

String_98_4070_00_0C:: ; heuristic: string; C0
Data_098_47C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's a mean old", $F1
    db "world out there.", $FA, $F7
    db $EF, $EE, "I've heard there", $EF, $EE, "are even monsters", $FA, $F7
    db $EF, $EE, "in our midsts.", $EF, $EE, "It's frightening.", $FA, $F7
    db $EF, $EE, "You should record", $EF, $EE, "in your Journal", $FA, $F7
    db $EF, $EE, "whenever you do", $EF, $EE, "anything of note.", $F7
    db $F0

String_98_4070_00_0D:: ; heuristic: string; C0
Data_098_487A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Castle is in", $F1
    db "an uproar.", $F7
    db $F0

String_98_4070_00_0E:: ; heuristic: string; C0
Data_098_489A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lady Yuna used", $F1
    db "to be very lively.", $FA, $F7
    db $EF, $EE, "It makes no sense,", $EF, $EE, "her depression.", $F7
    db $F0

String_98_4070_00_0F:: ; heuristic: string; C0
Data_098_48E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " In the east", $F1
    db "lives an old man", $FA, $F7
    db $EF, $EE, "who had tutored", $EF, $EE, "Lady Yuna.", $FA, $F7
    db $EF, $EE, "He knows about her", $EF, $EE, "the best.", $F7
    db $F0

String_98_4070_00_10:: ; heuristic: string; C0
Data_098_4948:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What happened to", $F1
    db "Lady Yuna?", $FA, $F7
    db $EF, $EE, "It's as if she is", $EF, $EE, "a soulless puppet", $A4, $F7
    db $F0

String_98_4070_00_11:: ; heuristic: string; C0
Data_098_4990:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Before, Lady", $F1
    db "Yuna would be up", $FA, $F7
    db $EF, $EE, "and out playing at", $EF, $EE, "sunrise.", $FA, $F7
    db $EF, $EE, "But now, she never", $EF, $EE, "ventures out", $A4, $F7
    db $F0

String_98_4070_00_12:: ; heuristic: string; C0
Data_098_49F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This leads to", $F1
    db "Lady Yuna's room.", $FA, $F7
    db $EF, $EE, "You may not go", $EF, $EE, "beyond here.", $F7
    db $F0

String_98_4070_00_13:: ; heuristic: string; C0
Data_098_4A3A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're here to", $F1
    db "cheer Lady Yuna.", $FA, $F7
    db $EF, $EE, "Please go right", $EF, $EE, "through.", $F7
    db $F0

String_98_4070_00_14:: ; heuristic: string; C0
Data_098_4A7A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're here to", $F1
    db "cheer Lady Yuna.", $FA, $F7
    db $EF, $EE, "Oh? Your monsters", $EF, $EE, "are not healthy.", $FA, $F7
    db $EF, $EE, "That won't do. No,", $EF, $EE, "not at all.", $FA, $F7
    db $EF, $EE, "You'll have to", $EF, $EE, "leave, I'm afraid.", $F7
    db $F0

String_98_4070_00_15:: ; heuristic: string; C0
Data_098_4B0A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're here to", $F1
    db "cheer Lady Yuna.", $FA, $F7
    db $EF, $EE, "Oh? You haven't", $EF, $EE, "three monsters?", $FA, $F7
    db $EF, $EE, "Your show can't be", $EF, $EE, "very impressive.", $FA, $F7
    db $EF, $EE, "You'll have to", $EF, $EE, "leave, I'm afraid.", $F7
    db $F0

String_98_4070_00_16:: ; heuristic: string; C0
Data_098_4B9B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Enough", $A4, " Enough", $F1
    db "of that dancing!", $F7
    db $F0

String_98_4070_00_17:: ; heuristic: string; C0
Data_098_4BBF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I am the King.", $F1
    db "What is your act?", $F7
    db $F0

String_98_4070_00_18:: ; heuristic: string; C0
Data_098_4BE4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Magnificent!", $F1
    db "Don't you agree?", $F7
    db $F0

String_98_4070_00_19:: ; heuristic: string; C0
Data_098_4C09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, $A4, $A4, $A4, $F1
    db $F7
    db $F0

String_98_4070_00_1A:: ; heuristic: string; C0
Data_098_4C13:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " ", $A4, "Sigh", $A4, $F1
    db "Not even this", $A4, $FA, $F7
    db $EF, $EE, "You were superb,", $EF, $EE, "but Yuna didn't", $FA, $F7
    db $EF, $EE, "appear to be much", $EF, $EE, "impressed", $A4, $FA, $F7
    db $EF, $EE, "She used to be", $EF, $EE, "full of laughter", $A4, $FA, $F7
    db $EF, $EE, "It happened so", $EF, $EE, "quickly.", $FA, $F7
    db $EF, $EE, "She came back to", $EF, $EE, "the castle like", $FA, $F7
    db $EF, $EE, "that one day and", $EF, $EE, "hasn't been the", $FA, $F7
    db $EF, $EE, "same ever since", $EF, $EE, "then.", $FA, $F7
    db $EF, $EE, "No one has any", $EF, $EE, "idea what to do", $A4, $F7
    db $F0

String_98_4070_00_1B:: ; heuristic: string; C0
Data_098_4D3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Many have tried", $F1
    db "to cheer Lady Yuna", $FA, $F7
    db $EF, $EE, "up to the way she", $EF, $EE, "was before.", $FA, $F7
    db $EF, $EE, "However, none have", $EF, $EE, "succeeded.", $FA, $F7
    db $EF, $EE, "Will we ever see", $EF, $EE, "her smile again?", $F7
    db $F0

String_98_4070_00_1C:: ; heuristic: string; C0
Data_098_4DCF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "Castle of Estria,", $FA, $F7
    db $EF, $EE, "the eastern", $EF, $EE, "kingdom.", $F7
    db $F0

String_98_4070_00_1D:: ; heuristic: string; C0
Data_098_4E0A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Queen Helen came", $F1
    db "by a while ago, so", $FA, $F7
    db $EF, $EE, "I greeted her. But", $EF, $EE, "she said nothing", $FA, $F7
    db $EF, $EE, "and walked by", $EF, $EE, "without notice.", $FA, $F7
    db $EF, $EE, "She used to greet", $EF, $EE, "us warmly before", $A4, $F7
    db $F0

String_98_4070_00_1E:: ; heuristic: string; C0
Data_098_4EA4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The spirit's", $F1
    db "spring has frozen.", $FA, $F7
    db $EF, $EE, "The lake is full", $EF, $EE, "of ice too.", $FA, $F7
    db $EF, $EE, "These are terrible", $EF, $EE, "omens", $A4, $F7
    db $F0

String_98_4070_00_1F:: ; heuristic: string; C0
Data_098_4F06:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Queen Helen's", $F1
    db "dreams come true.", $FA, $F7
    db $EF, $EE, "If she hadn't", $EF, $EE, "dreamed of this,", $FA, $F7
    db $EF, $EE, "we would've fared", $EF, $EE, "much worse.", $F7
    db $F0

String_98_4070_00_20:: ; heuristic: string; C0
Data_098_4F6C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Our Queen is a", $F1
    db "kind person who", $FA, $F7
    db $EF, $EE, "has a friendly", $EF, $EE, "word for everyone,", $FA, $F7
    db $EF, $EE, "but lately she", $EF, $EE, "looks grim", $A4, $F7
    db $F0

String_98_4070_00_21:: ; heuristic: string; C0
Data_098_4FD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " A teacher from", $F1
    db "the west lives", $FA, $F7
    db $EF, $EE, "over there.", $EF, $EE, "He once was a", $FA, $F7
    db $EF, $EE, "tutor to the west's", $EF, $EE, "princess.", $F7
    db $F0

String_98_4070_00_22:: ; heuristic: string; C0
Data_098_5035:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There is a", $F1
    db "spring in the far", $FA, $F7
    db $EF, $EE, "north that is home", $EF, $EE, "to a spirit.", $FA, $F7
    db $EF, $EE, "The spirit lends", $EF, $EE, "us the power to", $FA, $F7
    db $EF, $EE, "survive in these", $EF, $EE, "harsh conditions.", $F7
    db $F0

String_98_4070_00_23:: ; heuristic: string; C0
Data_098_50C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I heard this on", $F1
    db "the sly from my", $FA, $F7
    db $EF, $EE, "sister who works", $EF, $EE, "in the Castle.", $FA, $F7
    db $EF, $EE, "Queen Helen is", $EF, $EE, "very upset over", $FA, $F7
    db $EF, $EE, "ominous dreams.", $EF, $EE, "They must be bad", $FA, $F7
    db $EF, $EE, "to keep her from", $EF, $EE, "sleeping.", $FA, $F7
    db $EF, $EE, "That's why she", $EF, $EE, "seems so cranky", $A4, $F7
    db $F0

String_98_4070_00_24:: ; heuristic: string; C0
Data_098_5198:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Queen looks", $F1
    db "haggard recently.", $FA, $F7
    db $EF, $EE, "Lack of sleep must", $EF, $EE, "be very taxing.", $FA, $F7
    db $EF, $EE, "She has been", $EF, $EE, "rather irritable.", $F7
    db $F0

String_98_4070_00_25:: ; heuristic: string; C0
Data_098_5208:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Around these", $F1
    db "parts, there are", $FA, $F7
    db $EF, $EE, "times of perpetual", $EF, $EE, "days", $A4, " And nights", $A4, $FA, $F7
    db $EF, $EE, "It can be hard to", $EF, $EE, "sleep properly.", $FA, $F7
    db $EF, $EE, "I use a potion", $EF, $EE, "made by a scholar", $FA, $F7
    db $EF, $EE, "when I can't sleep.", $EF, $EE, "It works!", $F7
    db $F0

String_98_4070_00_26:: ; heuristic: string; C0
Data_098_52BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is no place", $F1
    db "for a child!", $F7
    db $F0

String_98_4070_00_27:: ; heuristic: string; C0
Data_098_52E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh? An envoy", $F1
    db "from the spirit!", $F7
    db $F0

String_98_4070_00_28:: ; heuristic: string; C0
Data_098_5303:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I beg your", $F1
    db "pardon, please!", $F7
    db $F0

String_98_4070_00_29:: ; heuristic: string; C0
Data_098_5322:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello! What may", $F1
    db "I do for you?", $F7
    db $F0

String_98_4070_00_2A:: ; heuristic: string; C0
Data_098_5344:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " A botanist does", $F1
    db "live here", $A4, $FA, $F7
    db $EF, $EE, "But he's been gone", $EF, $EE, "for quite some", $FA, $F7
    db $EF, $EE, "time on a research", $EF, $EE, "trip of some sort.", $FA, $F7
    db $EF, $EE, "Who knows where he", $EF, $EE, "could be now.", $F7
    db $F0

String_98_4070_00_2B:: ; heuristic: string; C0
Data_098_53D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I retired as a", $F1
    db "teacher and came", $FA, $F7
    db $EF, $EE, "back home.", $EF, $EE, "But yes, I tutored", $FA, $F7
    db $EF, $EE, "Lady Yuna in the", $EF, $EE, "western kingdom.", $FA, $F7
    db $EF, $EE, "It brings back", $EF, $EE, "some memories", $A4, $FA, $F7
    db $EF, $EE, "Will you hear this", $EF, $EE, "old man reminisce?", $FF, $F0

String_98_4070_00_2C:: ; heuristic: string; C0
Data_098_548F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lady Yuna was a", $F1
    db "rambunctious soul.", $FA, $F7
    db $EF, $EE, "She was much more", $EF, $EE, "likely to be out", $FA, $F7
    db $EF, $EE, "playing in forests", $EF, $EE, "with animals than", $FA, $F7
    db $EF, $EE, "staying cooped up", $EF, $EE, "in the castle.", $FA, $F7
    db $EF, $EE, "She used to climb", $EF, $EE, "out of her room on", $FA, $F7
    db $EF, $EE, "vines outside her", $EF, $EE, "window.", $FA, $F7
    db $EF, $EE, "She often went to", $EF, $EE, "the forest south", $FA, $F7
    db $EF, $EE, "of the castle. She", $EF, $EE, "liked it there.", $FA, $F7
    db $EF, $EE, "Ah, good memories", $EF, $EE, "indeed! Fwohohoho!", $F7
    db $F0

String_98_4070_00_2D:: ; heuristic: string; C0
Data_098_55E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, you're rushed", $F1
    db "for time", $A4, " Sorry", $A4, $F7
    db $F0

String_98_4070_00_2E:: ; heuristic: string; C0
Data_098_560F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I want to return", $F1
    db "to the north, but", $FA, $F7
    db $EF, $EE, "there are no ships", $EF, $EE, "sailing.", $FA, $F7
    db $EF, $EE, "The mountains in", $EF, $EE, "the north are too", $FA, $F7
    db $EF, $EE, "treacherous to", $EF, $EE, "attempt crossing.", $F7
    db $F0

String_98_4070_00_2F:: ; heuristic: string; C0
Data_098_56A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Queen Helen has", $F1
    db "been suffering", $FA, $F7
    db $EF, $EE, "from nightmares", $EF, $EE, "terribly.", $FA, $F7
    db $EF, $EE, "They don't let her", $EF, $EE, "sleep.", $FA, $F7
    db $EF, $EE, "We're concerned", $EF, $EE, "for her health", $A4, $F7
    db $F0

String_98_4070_00_30:: ; heuristic: string; C0
Data_098_5723:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, $A4, $A4, $A4, "?", $F7
    db $F0

String_98_4070_00_39:: ; heuristic: string; C0
Data_098_572D:: ; address name
    db $F0

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_98_572E::
MessageStrings_Bank2C_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_098_572E:: ; address name
    dw StringList_98_5730 ; id 0

; E-0217 (derived: category list of StringCategories_98_572E; one pointer per wStringIndex)
; record: string
StringList_98_5730::
Data_098_5730:: ; address name
    dw String_98_572E_00_00 ; id 0
    dw String_98_572E_00_01 ; id 1
    dw String_98_572E_00_02 ; id 2
    dw String_98_572E_00_03 ; id 3
    dw String_98_572E_00_04 ; id 4
    dw String_98_572E_00_05 ; id 5
    dw String_98_572E_00_06 ; id 6
    dw String_98_572E_00_07 ; id 7
    dw String_98_572E_00_08 ; id 8
    dw String_98_572E_00_09 ; id 9
    dw String_98_572E_00_0A ; id 10
    dw String_98_572E_00_0B ; id 11
    dw String_98_572E_00_0C ; id 12
    dw String_98_572E_00_0D ; id 13
    dw String_98_572E_00_0E ; id 14
    dw String_98_572E_00_0F ; id 15
    dw String_98_572E_00_10 ; id 16
    dw String_98_572E_00_11 ; id 17
    dw String_98_572E_00_12 ; id 18
    dw String_98_572E_00_13 ; id 19
    dw String_98_572E_00_14 ; id 20
    dw String_98_572E_00_15 ; id 21
    dw String_98_572E_00_16 ; id 22
    dw String_98_572E_00_17 ; id 23
    dw String_98_572E_00_18 ; id 24
    dw String_98_572E_00_19 ; id 25
    dw String_98_572E_00_1A ; id 26
    dw String_98_572E_00_1A ; id 27
    dw String_98_572E_00_1A ; id 28
    dw String_98_572E_00_1A ; id 29
    dw String_98_572E_00_1A ; id 30
    dw String_98_572E_00_1A ; id 31
    dw String_98_572E_00_20 ; id 32
    dw String_98_572E_00_21 ; id 33
    dw String_98_572E_00_22 ; id 34
    dw String_98_572E_00_23 ; id 35
    dw String_98_572E_00_24 ; id 36
    dw String_98_572E_00_25 ; id 37
    dw String_98_572E_00_26 ; id 38
    dw String_98_572E_00_27 ; id 39
    dw String_98_572E_00_28 ; id 40
    dw String_98_572E_00_29 ; id 41
    dw String_98_572E_00_2A ; id 42
    dw String_98_572E_00_2B ; id 43
    dw String_98_572E_00_2C ; id 44
    dw String_98_572E_00_2D ; id 45
    dw String_98_572E_00_2E ; id 46
    dw String_98_572E_00_2F ; id 47
    dw String_98_572E_00_30 ; id 48
    dw String_98_572E_00_31 ; id 49
    dw String_98_572E_00_32 ; id 50
    dw String_98_572E_00_33 ; id 51
    dw String_98_572E_00_34 ; id 52
    dw String_98_572E_00_35 ; id 53
    dw String_98_572E_00_36 ; id 54
    dw String_98_572E_00_37 ; id 55
    dw String_98_572E_00_38 ; id 56
    dw String_98_572E_00_39 ; id 57
    dw String_98_572E_00_3A ; id 58
    dw String_98_572E_00_3B ; id 59
    dw String_98_572E_00_3C ; id 60
    dw String_98_572E_00_3D ; id 61
    dw String_98_572E_00_3E ; id 62
    dw String_98_572E_00_3F ; id 63
    dw String_98_572E_00_40 ; id 64
    dw String_98_572E_00_41 ; id 65
    dw String_98_572E_00_42 ; id 66
    dw String_98_572E_00_42 ; id 67
    dw String_98_572E_00_42 ; id 68
    dw String_98_572E_00_42 ; id 69
    dw String_98_572E_00_42 ; id 70
    dw String_98_572E_00_42 ; id 71
    dw String_98_572E_00_42 ; id 72
    dw String_98_572E_00_42 ; id 73
    dw String_98_572E_00_42 ; id 74
    dw String_98_572E_00_42 ; id 75
    dw String_98_572E_00_42 ; id 76
    dw String_98_572E_00_42 ; id 77
    dw String_98_572E_00_42 ; id 78
    dw String_98_572E_00_42 ; id 79
    dw String_98_572E_00_42 ; id 80
    dw String_98_572E_00_42 ; id 81
    dw String_98_572E_00_42 ; id 82
    dw String_98_572E_00_42 ; id 83
    dw String_98_572E_00_42 ; id 84
    dw String_98_572E_00_42 ; id 85
    dw String_98_572E_00_42 ; id 86
    dw String_98_572E_00_42 ; id 87
    dw String_98_572E_00_42 ; id 88
    dw String_98_572E_00_42 ; id 89
    dw String_98_572E_00_42 ; id 90
    dw String_98_572E_00_42 ; id 91
    dw String_98_572E_00_42 ; id 92
    dw String_98_572E_00_42 ; id 93
    dw String_98_572E_00_42 ; id 94
    dw String_98_572E_00_42 ; id 95
    dw String_98_572E_00_42 ; id 96
    dw String_98_572E_00_42 ; id 97
    dw String_98_572E_00_42 ; id 98
    dw String_98_572E_00_42 ; id 99
    dw String_98_572E_00_42 ; id 100
    dw String_98_572E_00_42 ; id 101
    dw String_98_572E_00_42 ; id 102
    dw String_98_572E_00_42 ; id 103
    dw String_98_572E_00_42 ; id 104
    dw String_98_572E_00_42 ; id 105
    dw String_98_572E_00_42 ; id 106
    dw String_98_572E_00_42 ; id 107
    dw String_98_572E_00_42 ; id 108
    dw String_98_572E_00_42 ; id 109
    dw String_98_572E_00_42 ; id 110

String_98_572E_00_00:: ; heuristic: string; C0
Data_098_580E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wa-hey! Can you", $F1
    db "hear me, ", $F9, "0?", $FA, $F7
    db $EF, $EE, "Things have turned", $EF, $EE, "serious, warooh!", $FA, $F7
    db $EF, $EE, "I'll bring you back", $EF, $EE, "to GreatLog.", $FA, $F7
    db $EF, $EE, "Don't move!", $EF, $EE, $F7
    db $F0

String_98_572E_00_01:: ; heuristic: string; C0
Data_098_588B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Some time ago,", $F1
    db "lightning struck", $FA, $F7
    db $EF, $EE, "the tower, causing", $EF, $EE, "it to buckle.", $FA, $F7
    db $EF, $EE, "A huge bird flew", $EF, $EE, "out of the rubble.", $F7
    db $F0

String_98_572E_00_02:: ; heuristic: string; C0
Data_098_58FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Who disturbs my", $F1
    db "sleep?", $FA, $F7
    db $EF, $EE, "The visitor from", $EF, $EE, "another world.", $FA, $F7
    db $EF, $EE, "I no longer feel", $EF, $EE, "the LightOrb's", $FA, $F7
    db $EF, $EE, "presence in this", $EF, $EE, "world.", $FA, $F7
    db $EF, $EE, "The Orb will no", $EF, $EE, "longer be a cause", $FA, $F7
    db $EF, $EE, "of strife in our", $EF, $EE, "world", $A4, $F7
    db $F0

String_98_572E_00_03:: ; heuristic: string; C0
Data_098_59BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I heard on my", $F1
    db "travels that the", $FA, $F7
    db $EF, $EE, "monster King has", $EF, $EE, "disappeared.", $FA, $F7
    db $EF, $EE, "Where could he", $EF, $EE, "have gone?", $FA, $F7
    db $EF, $EE, "Well, it's not a", $EF, $EE, "bad thing.", $F7
    db $F0

String_98_572E_00_04:: ; heuristic: string; C0
Data_098_5A3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The monster King", $F1
    db "disappeared.", $FA, $F7
    db $EF, $EE, "He", $44, " made monsters", $EF, $EE, "obey using magic.", $F7
    db $F0

String_98_572E_00_05:: ; heuristic: string; C0
Data_098_5A88:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When the monster", $F1
    db "King disappeared,", $FA, $F7
    db $EF, $EE, "we all gained our", $EF, $EE, "freedom.", $FA, $F7
    db $EF, $EE, "But everyone's been", $EF, $EE, "having so much fun", $FA, $F7
    db $EF, $EE, "treasure hunting,", $EF, $EE, "no one's quit!", $F7
    db $F0

String_98_572E_00_06:: ; heuristic: string; C0
Data_098_5B1C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Castle is", $F1
    db "now managed by all", $FA, $F7
    db $EF, $EE, "of us in the town.", $EF, $EE, $F7
    db $F0

String_98_572E_00_07:: ; heuristic: string; C0
Data_098_5B59:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Rumor has it", $F1
    db "that almost no one", $FA, $F7
    db $EF, $EE, "has seen the", $EF, $EE, "monster King.", $FA, $F7
    db $EF, $EE, "Maybe he looked", $EF, $EE, "weak and frail.", $F7
    db $F0

String_98_572E_00_08:: ; heuristic: string; C0
Data_098_5BC0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Where has our", $F1
    db "King gone?", $F7
    db $F0

String_98_572E_00_09:: ; heuristic: string; C0
Data_098_5BDD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There's no point", $F1
    db "staying in the", $FA, $F7
    db $EF, $EE, "army. I should go", $EF, $EE, "back home.", $F7
    db $F0

String_98_572E_00_0A:: ; heuristic: string; C0
Data_098_5C21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If I had the", $F1
    db "LightOrb, even I", $FA, $F7
    db $EF, $EE, "could become the", $EF, $EE, "King of monsters.", $FA, $F7
    db $EF, $EE, "Could you please", $EF, $EE, "tell me where I", $FA, $F7
    db $EF, $EE, "could find the", $EF, $EE, "LightOrb?", $F7
    db $F0

String_98_572E_00_0B:: ; heuristic: string; C0
Data_098_5CAC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, "'Town of Hitano", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Where treasure", $EF, $EE, "hunters gather.", $95, $F7
    db $F0

String_98_572E_00_0C:: ; heuristic: string; C0
Data_098_5CF9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Mayor is", $F1
    db "beyond here.", $FA, $F7
    db $EF, $EE, "Please watch your", $EF, $EE, "manners.", $F7
    db $F0

String_98_572E_00_0D:: ; heuristic: string; C0
Data_098_5D36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I've become the", $F1
    db "Mayor, but what", $FA, $F7
    db $EF, $EE, "exactly should I", $EF, $EE, "be doing?", $F7
    db $F0

String_98_572E_00_0E:: ; heuristic: string; C0
Data_098_5D78:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 released the", $F1
    db "grave's button.", $F7
    db $F0

String_98_572E_00_0F:: ; heuristic: string; C0
Data_098_5D98:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The castle's lord", $F1
    db "summons monsters", $A4, $F7
    db $F0

String_98_572E_00_10:: ; heuristic: string; C0
Data_098_5DBF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A button hides", $F1
    db "behind a grave", $A4, $FA, $F7
    db $EF, $EE, "A button that", $EF, $EE, "opens a door", $A4, $F7
    db $F0

String_98_572E_00_11:: ; heuristic: string; C0
Data_098_5E02:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked", $F1
    db "behind the grave.", $FA, $F7
    db $EF, $EE, "There was nothing", $EF, $EE, "of interest.", $F7
    db $F0

String_98_572E_00_12:: ; heuristic: string; C0
Data_098_5E43:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King's gone.", $F1
    db "What should I do?", $FA, $F7
    db $EF, $EE, "I guess there's no", $EF, $EE, "Sirloin for me.", $F7
    db $F0

String_98_572E_00_13:: ; heuristic: string; C0
Data_098_5E8F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " South beyond the", $F1
    db "mountains is the", $FA, $F7
    db $EF, $EE, "King's castle.", $EF, $EE, "I understand that", $FA, $F7
    db $EF, $EE, "it's bustling with", $EF, $EE, "treasure hunters.", $F7
    db $F0

String_98_572E_00_14:: ; heuristic: string; C0
Data_098_5F01:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Several ancient", $F1
    db "ruins remain in", $FA, $F7
    db $EF, $EE, "the southern part", $EF, $EE, "of the continent.", $FA, $F7
    db $EF, $EE, "Treasures may be", $EF, $EE, "hidden in them.", $F7
    db $F0

String_98_572E_00_15:: ; heuristic: string; C0
Data_098_5F72:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I was taking a", $F1
    db "walk outside with", $FA, $F7
    db $EF, $EE, "my friend Roboster", $EF, $EE, "when he was almost", $FA, $F7
    db $EF, $EE, "taken away by a", $EF, $EE, "giant MadCondor.", $FA, $F7
    db $EF, $EE, "I think it was his", $EF, $EE, "shiny metal body", $FA, $F7
    db $EF, $EE, "that attracted the", $EF, $EE, "bird.", $FA, $F7
    db $EF, $EE, "That may mean", $EF, $EE, "lamps and armor", $FA, $F7
    db $EF, $EE, "will also draw the", $EF, $EE, "bird's attention.", $F7
    db $F0

String_98_572E_00_16:: ; heuristic: string; C0
Data_098_6075:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, $A4, "This way", $A4, $F1
    db $A4, "Here", $A4, " ", $A4, "Here", $A4, $F7
    db $F0

String_98_572E_00_17:: ; heuristic: string; C0
Data_098_6093:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, "Where is my", $F1
    db "casket", $A4, " Where", $A4, $FA, $F7
    db $EF, $EE, "Ring the bell", $A4, $EF, $EE, $A4, "Please", $A4, $F7
    db $F0

String_98_572E_00_18:: ; heuristic: string; C0
Data_098_60CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "notice.", $FA, $F7
    db $EF, $EE, "'Guide the lost", $EF, $EE, "souls", $A4, $95, $F7
    db $F0

String_98_572E_00_19:: ; heuristic: string; C0
Data_098_6103:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, "'Determine where", $EF, $EE, "you will land", $FA, $F7
    db $EF, $EE, "before flying", $EF, $EE, "off.", $95, $F7
    db $F0

String_98_572E_00_1A:: ; heuristic: string; C0
Data_098_6151:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I lost again.", $F1
    db "I need to train my", $FA, $F7
    db $EF, $EE, "monsters a lot", $EF, $EE, "more to win.", $FA, $F7
    db $EF, $EE, "I'll have to go", $EF, $EE, "back to a world", $FA, $F7
    db $EF, $EE, "I've already", $EF, $EE, "finished, and", $FA, $F7
    db $EF, $EE, "raise their levels", $EF, $EE, "some more.", $FA, $F7
    db $EF, $EE, "There might be", $EF, $EE, "something new for", $FA, $F7
    db $EF, $EE, "me to discover.", $EF, $EE, "Who knows?", $F7
    db $F0

String_98_572E_00_20:: ; heuristic: string; C0
Data_098_623D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Good! Let's get", $F1
    db "started!", $F7
    db $F0

String_98_572E_00_21:: ; heuristic: string; C0
Data_098_6259:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'll be here for", $F1
    db "a while longer.", $FA, $F7
    db $EF, $EE, "If you change your", $EF, $EE, "mind, come back.", $F7
    db $F0

String_98_572E_00_22:: ; heuristic: string; C0
Data_098_62A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I lost again.", $F1
    db "I need to train my", $FA, $F7
    db $EF, $EE, "monsters a lot", $EF, $EE, "more to win.", $FA, $F7
    db $EF, $EE, "I'll have to go", $EF, $EE, "back to a world", $FA, $F7
    db $EF, $EE, "I've already", $EF, $EE, "finished, and", $FA, $F7
    db $EF, $EE, "raise their levels", $EF, $EE, "some more.", $FA, $F7
    db $EF, $EE, "There might be", $EF, $EE, "something new for", $FA, $F7
    db $EF, $EE, "me to discover.", $EF, $EE, "Who knows?", $F7
    db $F0

String_98_572E_00_23:: ; heuristic: string; C0
Data_098_6391:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " When you breed,", $F1
    db "the offspring", $FA, $F7
    db $EF, $EE, "inherit the", $EF, $EE, "parents' skills", $FA, $F7
    db $EF, $EE, "and abilities.", $EF, $EE, "So, you're better", $FA, $F7
    db $EF, $EE, "off breeding", $EF, $EE, "monsters.", $F7
    db $F0

String_98_572E_00_24:: ; heuristic: string; C0
Data_098_6412:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Do you know all", $F1
    db "the kinds of meat?", $FA, $F7
    db $EF, $EE, "There's BeefJerky,", $EF, $EE, "PorkChop, Rib and", $FA, $F7
    db $EF, $EE, "then there's", $EF, $EE, "Sirloin.", $FA, $F7
    db $EF, $EE, "Sirloin is the", $EF, $EE, "ultimate!", $FA, $F7
    db $EF, $EE, "So tender and", $EF, $EE, "heavenly tasty!", $F7
    db $F0

String_98_572E_00_25:: ; heuristic: string; C0
Data_098_64B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you eat any", $F1
    db "BadMeat like me,", $FA, $F7
    db $EF, $EE, "you'll get", $EF, $EE, "poisoned.", $F7
    db $F0

String_98_572E_00_26:: ; heuristic: string; C0
Data_098_64F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm? Little one,", $F1
    db "are you a master?", $FA, $F7
    db $EF, $EE, "How would you like", $EF, $EE, "to breed one of", $FA, $F7
    db $EF, $EE, "your monsters with", $EF, $EE, "my Armorpede?", $FF, $F0

String_98_572E_00_27:: ; heuristic: string; C0
Data_098_6567:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Good! Let's get", $F1
    db "this started!", $F7
    db $F0

String_98_572E_00_28:: ; heuristic: string; C0
Data_098_6588:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, too bad.", $F1
    db "Another time.", $FA, $F7
    db $EF, $EE, "Tell me if you", $EF, $EE, "change your mind.", $F7
    db $F0

String_98_572E_00_29:: ; heuristic: string; C0
Data_098_65CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you get an", $F1
    db "EvilArmor, I", $44, $FA, $F7
    db $EF, $EE, "breed it with a", $EF, $EE, "material family", $FA, $F7
    db $EF, $EE, "partner. It's a", $EF, $EE, "tough combo.", $F7
    db $F0

String_98_572E_00_2A:: ; heuristic: string; C0
Data_098_6630:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " NoctoKing is my", $F1
    db "name!", $FA, $F7
    db $EF, $EE, "Darkness is my", $EF, $EE, "domain!", $FA, $F7
    db $EF, $EE, "Perchance, do you", $EF, $EE, "know a skill named", $FA, $F7
    db $EF, $EE, "Ahhh? Its effects", $EF, $EE, "differ markedly", $FA, $F7
    db $EF, $EE, "depending on the", $EF, $EE, "gender.", $F7
    db $F0

String_98_572E_00_2B:: ; heuristic: string; C0
Data_098_66D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I learned how to", $F1
    db "Massacre!", $FA, $F7
    db $EF, $EE, "But I ended up", $EF, $EE, "clocking my mates", $FA, $F7
    db $EF, $EE, "pretty good too.", $EF, $EE, "Ehehe.", $F7
    db $F0

String_98_572E_00_2C:: ; heuristic: string; C0
Data_098_6731:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Yo! Up close,", $F1
    db "you look tougher", $FA, $F7
    db $EF, $EE, "than you first", $EF, $EE, "appeared.", $FA, $F7
    db $EF, $EE, "Want to breed a", $EF, $EE, "monster with my", $FA, $F7
    db $EF, $EE, "WildApe? Does", $EF, $EE, "that sound good?", $FF, $F0

String_98_572E_00_2D:: ; heuristic: string; C0
Data_098_67B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I like your", $F1
    db "style!", $FA, $F7
    db $EF, $EE, "Let's get started", $EF, $EE, "with this.", $F7
    db $F0

String_98_572E_00_2E:: ; heuristic: string; C0
Data_098_67EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? Are you", $F1
    db "sure about that?", $F7
    db $F0

String_98_572E_00_2F:: ; heuristic: string; C0
Data_098_6812:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " All righty!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "We'll do this again", $EF, $EE, "next time too!", $F7
    db $F0

String_98_572E_00_30:: ; heuristic: string; C0
Data_098_684A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Arr, matey!", $F1
    db "I'm CaptDead!", $FA, $F7
    db $EF, $EE, "A dashing zombie", $EF, $EE, "of the open seas!", $FA, $F7
    db $EF, $EE, "If I CallHelp, my", $EF, $EE, "trusty crew will", $FA, $F7
    db $EF, $EE, "come running,", $EF, $EE, "cutlasses ready!", $F7
    db $F0

String_98_572E_00_31:: ; heuristic: string; C0
Data_098_68D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I strike with my", $F1
    db "eight tentacles.", $FA, $F7
    db $EF, $EE, "That means I hit", $EF, $EE, "eight times!", $F7
    db $F0

String_98_572E_00_32:: ; heuristic: string; C0
Data_098_6920:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome. I'm the", $F1
    db "Christener.", $FA, $F7
    db $EF, $EE, "I can rename your", $EF, $EE, "monsters here.", $FA, $F7
    db $EF, $EE, "Do you wish to", $EF, $EE, "rename one?", $F0

String_98_572E_00_33:: ; heuristic: string; C0
Data_098_6983:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome. I'm the", $F1
    db "Christener.", $FA, $F7
    db $EF, $EE, "Do you wish to", $EF, $EE, "rename someone?", $F0

String_98_572E_00_34:: ; heuristic: string; C0
Data_098_69C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, "'Handbook on", $EF, $EE, "Naming", $A4, $FA, $F7
    db $EF, $EE, "Using a part of", $EF, $EE, "the species name", $FA, $F7
    db $EF, $EE, "enables easier", $EF, $EE, "identification.", $95, $F7
    db $F0

String_98_572E_00_35:: ; heuristic: string; C0
Data_098_6A42:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, "'Handbook on", $EF, $EE, "Naming", $A4, $FA, $F7
    db $EF, $EE, "Borrowing from the", $EF, $EE, "parents' names", $FA, $F7
    db $EF, $EE, "adds to the weight", $EF, $EE, "of a name.", $95, $F7
    db $F0

String_98_572E_00_36:: ; heuristic: string; C0
Data_098_6ABF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, "'Handbook on", $EF, $EE, "Naming", $A4, $FA, $F7
    db $EF, $EE, "A string of the", $EF, $EE, "same character", $FA, $F7
    db $EF, $EE, "makes a terrible", $EF, $EE, "name. Where is", $FA, $F7
    db $EF, $EE, "your love for your", $EF, $EE, "monster?", $95, $F7
    db $F0

String_98_572E_00_37:: ; heuristic: string; C0
Data_098_6B5B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I was once a", $F1
    db "great master who", $FA, $F7
    db $EF, $EE, "traveled from", $EF, $EE, "world to world.", $FA, $F7
    db $EF, $EE, "I used that key to", $EF, $EE, "reach a world.", $FA, $F7
    db $EF, $EE, "You have your own", $EF, $EE, "Magic Keys, yes?", $FF, $F0

String_98_572E_00_38:: ; heuristic: string; C0
Data_098_6BEC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Have you shown", $F1
    db "them to the Key", $FA, $F7
    db $EF, $EE, "Shop's boss?", $EF, $EE, "He'll make it so", $FA, $F7
    db $EF, $EE, "you can go to", $EF, $EE, "other worlds.", $F7
    db $F0

String_98_572E_00_39:: ; heuristic: string; C0
Data_098_6C4F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You've not found", $F1
    db "any yet?", $FA, $F7
    db $EF, $EE, "That's a", $EF, $EE, "rotten shame", $A4, $FA, $F7
    db $EF, $EE, "Fine, look on the", $EF, $EE, "shelf there.", $FA, $F7
    db $EF, $EE, "You can take one", $EF, $EE, "of my keys.", $F7
    db $F0

String_98_572E_00_3A:: ; heuristic: string; C0
Data_098_6CCA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That key, I used", $F1
    db "on my travels to", $FA, $F7
    db $EF, $EE, "other worlds in my", $EF, $EE, "youth.", $FA, $F7
    db $EF, $EE, "It brings back", $EF, $EE, "memories.", $FA, $F7
    db $EF, $EE, "No, you may not", $EF, $EE, "have it.", $F7
    db $F0

String_98_572E_00_3B:: ; heuristic: string; C0
Data_098_6D48:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "shelf.", $FA, $F7
    db $EF, $EE, "Souvenirs from", $EF, $EE, "other worlds", $FA, $F7
    db $EF, $EE, "covered the shelf", $EF, $EE, "haphazardly.", $F7
    db $F0

String_98_572E_00_3C:: ; heuristic: string; C0
Data_098_6DA2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "shelf.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained a", $EF, $EE, "Magic Key.", $E5, $58, $F7
    db $E9, $FF, $F0

String_98_572E_00_3D:: ; heuristic: string; C0
Data_098_6DDA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "shelf.", $FA, $F7
    db $EF, $EE, $F9, "0 found a", $EF, $EE, "Magic Key.", $FA, $F7
    db $EF, $EE, "But the key ring", $EF, $EE, "was full.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Magic Key back.", $F7
    db $F0

String_98_572E_00_3E:: ; heuristic: string; C0
Data_098_6E49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was full of", $EF, $EE, "esoteric junk.", $F7
    db $F0

String_98_572E_00_3F:: ; heuristic: string; C0
Data_098_6E85:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, "'Monster Arena,", $EF, $EE, "where masters meet", $FA, $F7
    db $EF, $EE, "for battle!", $EF, $EE, "Downstairs!", $95, $F7
    db $F0

String_98_572E_00_40:: ; heuristic: string; C0
Data_098_6EDC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There are times", $F1
    db "when you have to", $FA, $F7
    db $EF, $EE, "take weak monsters", $EF, $EE, "out and about.", $FA, $F7
    db $EF, $EE, "If you want to", $EF, $EE, "avoid battles,", $FA, $F7
    db $EF, $EE, "sprinkle on some", $EF, $EE, "Repellent.", $F7
    db $F0

String_98_572E_00_41:: ; heuristic: string; C0
Data_098_6F69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Up ahead is the", $F1
    db "Starry Shrine and", $FA, $F7
    db $EF, $EE, "the Egg Evaluator's", $EF, $EE, "room.", $FA, $F7
    db $EF, $EE, "Both facilities", $EF, $EE, "are absolutely", $FA, $F7
    db $EF, $EE, "indispensable to", $EF, $EE, "masters.", $FA, $F7
    db $EF, $EE, "But they're only", $EF, $EE, "open to certified", $FA, $F7
    db $EF, $EE, "masters, and no", $EF, $EE, "one else.", $F7
    db $F0

String_98_572E_00_42:: ; heuristic: string; C0
Data_098_7031:: ; address name
    db $F0

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_98_7032::
MessageStrings_Bank89_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_098_7032:: ; address name
    dw StringList_98_7034 ; id 0

; E-0217 (derived: category list of StringCategories_98_7032; one pointer per wStringIndex)
; record: string
StringList_98_7034::
Data_098_7034:: ; address name
    dw String_98_7032_00_00 ; id 0
    dw String_98_7032_00_01 ; id 1
    dw String_98_7032_00_02 ; id 2
    dw String_98_7032_00_03 ; id 3
    dw String_98_7032_00_04 ; id 4
    dw String_98_7032_00_05 ; id 5
    dw String_98_7032_00_06 ; id 6
    dw String_98_7032_00_07 ; id 7
    dw String_98_7032_00_08 ; id 8
    dw String_98_7032_00_09 ; id 9
    dw String_98_7032_00_0A ; id 10
    dw String_98_7032_00_0B ; id 11
    dw String_98_7032_00_0C ; id 12
    dw String_98_7032_00_0D ; id 13
    dw String_98_7032_00_0E ; id 14
    dw String_98_7032_00_0F ; id 15
    dw String_98_7032_00_10 ; id 16
    dw String_98_7032_00_11 ; id 17
    dw String_98_7032_00_12 ; id 18
    dw String_98_7032_00_13 ; id 19
    dw String_98_7032_00_14 ; id 20
    dw String_98_7032_00_15 ; id 21
    dw String_98_7032_00_16 ; id 22
    dw String_98_7032_00_17 ; id 23
    dw String_98_7032_00_18 ; id 24
    dw String_98_7032_00_19 ; id 25
    dw String_98_7032_00_1A ; id 26
    dw String_98_7032_00_1B ; id 27
    dw String_98_7032_00_1B ; id 28
    dw String_98_7032_00_1B ; id 29
    dw String_98_7032_00_1B ; id 30
    dw String_98_7032_00_1B ; id 31
    dw String_98_7032_00_1B ; id 32
    dw String_98_7032_00_1B ; id 33

String_98_7032_00_00:: ; heuristic: string; C0
Data_098_7078:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? You don't", $F1
    db "know about the", $FA, $F7
    db $EF, $EE, "Starry Shrine or", $EF, $EE, "the Egg Evaluator?", $FA, $F7
    db $EF, $EE, "Urrrgh", $A4, " Look them", $EF, $EE, "up at the Library.", $FA, $F7
    db $EF, $EE, "I'm not much good", $EF, $EE, "at explaining, but", $FA, $F7
    db $EF, $EE, "I've gotten you", $EF, $EE, "the word!", $F7
    db $F0

String_98_7032_00_01:: ; heuristic: string; C0
Data_098_7130:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A beautiful voice", $F1
    db "echoed", $A4, $F7
    db $F0

String_98_7032_00_02:: ; heuristic: string; C0
Data_098_714B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Helen", $A3, " I thank you", $F1
    db "from the heart.", $FA, $F7
    db $EF, $EE, "Please give my", $EF, $EE, "regards to the", $FA, $F7
    db $EF, $EE, "spirit in the", $EF, $EE, "spring.", $F7
    db $F0

String_98_7032_00_03:: ; heuristic: string; C0
Data_098_71AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Seeing the", $F1
    db "liveliness of", $FA, $F7
    db $EF, $EE, "Lady Yuna lifts", $EF, $EE, "our spirits.", $F7
    db $F0

String_98_7032_00_04:: ; heuristic: string; C0
Data_098_71EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "tombstone.", $FA, $F7
    db $EF, $EE, "There appeared to", $EF, $EE, "be nothing.", $F7
    db $F0

String_98_7032_00_05:: ; heuristic: string; C0
Data_098_7227:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The sea is huge", $F1
    db "and mysterious.", $FA, $F7
    db $EF, $EE, "There must be", $EF, $EE, "totally different", $FA, $F7
    db $EF, $EE, "monsters in the", $EF, $EE, "sea.", $F7
    db $F0

String_98_7032_00_06:: ; heuristic: string; C0
Data_098_7288:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Huh? Has the sea", $F1
    db "risen?", $FA, $F7
    db $EF, $EE, "Oh, well. I'm a", $EF, $EE, "good swimmer.", $F7
    db $F0

String_98_7032_00_07:: ; heuristic: string; C0
Data_098_72C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The water flowed", $F1
    db "right over the", $FA, $F7
    db $EF, $EE, "ground almost", $EF, $EE, "instantly.", $FA, $F7
    db $EF, $EE, "Is GreatLog really", $EF, $EE, "safe?", $F7
    db $F0

String_98_7032_00_08:: ; heuristic: string; C0
Data_098_7323:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Look! A MadCondor!", $F1
    db "It has something!", $FA, $F7
    db $EF, $EE, "It clutched a", $EF, $EE, "glowing ball!", $F7
    db $F0

String_98_7032_00_09:: ; heuristic: string; C0
Data_098_7369:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, ", $F9, "0!", $F1
    db "You've befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You've got at", $EF, $EE, "least 20 species!", $FA, $F7
    db $EF, $EE, "Keep at it, and", $EF, $EE, "get some more!", $F7
    db $F0

String_98_7032_00_0A:: ; heuristic: string; C0
Data_098_73EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, ", $F9, "0!", $F1
    db "You've befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You've got at", $EF, $EE, "least 30 species!", $FA, $F7
    db $EF, $EE, "You can check up", $EF, $EE, "on your monsters", $95, $FA, $F7
    db $EF, $EE, "cataloged data at", $EF, $EE, "the Library.", $F7
    db $F0

String_98_7032_00_0B:: ; heuristic: string; C0
Data_098_7496:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, ", $F9, "0!", $F1
    db "You've befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You've got at", $EF, $EE, "least 40 species!", $FA, $F7
    db $EF, $EE, "If the farm is", $EF, $EE, "full, you should", $FA, $F7
    db $EF, $EE, "try breeding some", $EF, $EE, "of your monsters.", $F7
    db $F0

String_98_7032_00_0C:: ; heuristic: string; C0
Data_098_7542:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, ", $F9, "0!", $F1
    db "You've befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You've got at", $EF, $EE, "least 50 species!", $FA, $F7
    db $EF, $EE, "By the way, I", $EF, $EE, "think Prince", $FA, $F7
    db $EF, $EE, "Kameha had some", $EF, $EE, "rare Magic Keys.", $F7
    db $F0

String_98_7032_00_0D:: ; heuristic: string; C0
Data_098_75E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, ", $F9, "0!", $F1
    db "You've befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You've got at", $EF, $EE, "least 100 species!", $FA, $F7
    db $EF, $EE, "You've grown up a", $EF, $EE, "lot through this.", $FA, $F7
    db $EF, $EE, "I'm proud of you!", $EF, $EE, $F7
    db $F0

String_98_7032_00_0E:: ; heuristic: string; C0
Data_098_7684:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, ", $F9, "0!", $F1
    db "You've befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You've got at", $EF, $EE, "least 150 species!", $FA, $F7
    db $EF, $EE, "Have you met a boy", $EF, $EE, "named Terry?", $FA, $F7
    db $EF, $EE, "You should be good", $EF, $EE, "enough as a master", $FA, $F7
    db $EF, $EE, "to be worthy of", $EF, $EE, "his approval.", $F7
    db $F0

String_98_7032_00_0F:: ; heuristic: string; C0
Data_098_7755:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, ", $F9, "0!", $F1
    db "You've befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You've got at", $EF, $EE, "least 200 species!", $FA, $F7
    db $EF, $EE, "I doubt no one has", $EF, $EE, "cataloged as many", $FA, $F7
    db $EF, $EE, "monsters as you.", $EF, $EE, $A4, "What's that?", $FA, $F7
    db $EF, $EE, "Am I embarrassing", $EF, $EE, "you?", $F7
    db $F0

String_98_7032_00_10:: ; heuristic: string; C0
Data_098_781C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, ", $F9, "0!", $F1
    db "You've befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You've got at", $EF, $EE, "least 250 species!", $FA, $F7
    db $EF, $EE, "I had no idea that", $EF, $EE, "there were so many", $FA, $F7
    db $EF, $EE, "distinct species", $EF, $EE, "of monsters. Even", $FA, $F7
    db $EF, $EE, "Professor Monster", $EF, $EE, "can't know them", $FA, $F7
    db $EF, $EE, "all.", $EF, $EE, $F7
    db $F0

String_98_7032_00_11:: ; heuristic: string; C0
Data_098_78FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Congratulations,", $F1
    db $F9, "0!", $FA, $F7
    db $EF, $EE, "You've cataloged", $EF, $EE, "every species.", $FA, $F7
    db $EF, $EE, "There appear to", $EF, $EE, "be no monsters", $FA, $F7
    db $EF, $EE, "left to be caught", $EF, $EE, "and cataloged.", $FA, $F7
    db $EF, $EE, "You hung in for", $EF, $EE, "all this time.", $FA, $F7
    db $EF, $EE, "I'm sincerely", $EF, $EE, "proud of you.", $FA, $F7
    db $EF, $EE, $F9, "0, I'm counting", $EF, $EE, "on you to look", $FA, $F7
    db $EF, $EE, "after the farm and", $EF, $EE, "the monsters.", $F7
    db $F0

String_98_7032_00_12:: ; heuristic: string; C0
Data_098_7A0B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome to the", $F1
    db "Library!", $FA, $F7
    db $EF, $EE, "Your monster", $EF, $EE, "Catalog is done!", $E5, $4D, $F7
    db $E9, $FF, $F0

String_98_7032_00_13:: ; heuristic: string; C0
Data_098_7A4D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " We need fanfare", $F1
    db "right about now", $A4, $FA, $F7
    db $EF, $EE, "Congratulations,", $EF, $EE, "our little hero!", $FA, $F7
    db $EF, $EE, "Here is your newly", $EF, $EE, "filled Catalog!", $FA, $F7
    db $EF, $EE, "Which family would", $EF, $EE, "you like to check?", $F7
    db $F0

String_98_7032_00_14:: ; heuristic: string; C0
Data_098_7AE9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The weather has", $F1
    db "been mild.", $FA, $F7
    db $EF, $EE, "It's a good thing.", $EF, $EE, $F7
    db $F0

String_98_7032_00_15:: ; heuristic: string; C0
Data_098_7B1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lady Yuna has", $F1
    db "come out of her", $FA, $F7
    db $EF, $EE, "depression. I've", $EF, $EE, "heard.", $FA, $F7
    db $EF, $EE, "When it comes to", $EF, $EE, "rumors, good ones", $FA, $F7
    db $EF, $EE, "are the best, I", $EF, $EE, "have to say.", $F7
    db $F0

String_98_7032_00_16:: ; heuristic: string; C0
Data_098_7BA4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Queen's lost", $F1
    db "her scary look!", $F7
    db $F0

String_98_7032_00_17:: ; heuristic: string; C0
Data_098_7BC8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The kingdoms of", $F1
    db "the north and west", $FA, $F7
    db $EF, $EE, "have reconciled", $EF, $EE, "from their ugly", $FA, $F7
    db $EF, $EE, "squabble over the", $EF, $EE, "mine.", $F7
    db $F0

String_98_7032_00_18:: ; heuristic: string; C0
Data_098_7C2F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The scholar who", $F1
    db "was in the tavern?", $FA, $F7
    db $EF, $EE, "I think he went", $EF, $EE, "back home.", $F7
    db $F0

String_98_7032_00_19:: ; heuristic: string; C0
Data_098_7C75:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey?", $F1
    db "Feel that, warooh?", $FA, $F7
    db $EF, $EE, "Did something", $EF, $EE, "shake?", $F7
    db $F0

String_98_7032_00_1A:: ; heuristic: string; C0
Data_098_7CB4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ZZZZZ", $A4, " Ssss", $A4, $F1
    db "ZZZZZ", $A4, " Ssss", $A4, $F7
    db $F0

String_98_7032_00_1B:: ; heuristic: string; C0
Data_098_7CD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000000000000000000000000000000000000000000000000000"
    db "0000000000000000000000000000000000"
