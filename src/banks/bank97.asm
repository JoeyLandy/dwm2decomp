SECTION "Bank 97", ROMX[$4000], BANK[$97]
    db $97

; only called from BeginStringDisplay_Bank28 (E-0047)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank28)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank28_BeginStringDisplay::
Func_097_4001:: ; address name
    ld de, MessageStrings_Bank28_Overflow
    ld a, [wStringIndex]
    sub a, $DA
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $28: wStringIndex -= $DA, then CopyStringToBuffer with the table Data_097_4095 in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank28)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank28_Overflow:: ; heuristic: follows a terminator; C0
Func_097_4010:: ; address name
    ld de, MessageStrings_Bank28_Overflow
    ld a, [wStringIndex]
    sub a, $DA
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; overflow for message bank $29: wStringIndex -= $8E, then BeginStringDisplay with the table Data_097_474A in this bank (E-0080)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank29)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank29_Overflow::
Func_097_4026:: ; address name
    ld de, MessageStrings_Bank29_Overflow
    ld a, [wStringIndex]
    sub a, $8E
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $29: wStringIndex -= $8E, then CopyStringToBuffer with the table Data_097_474A in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank29)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank29_Overflow:: ; heuristic: follows a terminator; C0
Func_097_4035:: ; address name
    ld de, MessageStrings_Bank29_Overflow
    ld a, [wStringIndex]
    sub a, $8E
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $26, $40, $CD, $11, $26, $C9

; overflow for message bank $2A: wStringIndex -= $95, then BeginStringDisplay with the table Data_097_5BBF in this bank (E-0080)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank2A)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank2A_Overflow::
Func_097_404B:: ; address name
    ld de, MessageStrings_Bank2A_Overflow
    ld a, [wStringIndex]
    sub a, $95
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $2A: wStringIndex -= $95, then CopyStringToBuffer with the table Data_097_5BBF in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank2A)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank2A_Overflow:: ; heuristic: follows a terminator; C0
Func_097_405A:: ; address name
    ld de, MessageStrings_Bank2A_Overflow
    ld a, [wStringIndex]
    sub a, $95
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $4B, $40, $CD, $11, $26, $C9

; overflow for message bank $83: wStringIndex -= $C7, then BeginStringDisplay with the table Data_097_6DC1 in this bank (E-0080)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank83)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank83_Overflow::
Func_097_4070:: ; address name
    ld de, MessageStrings_Bank83_Overflow
    ld a, [wStringIndex]
    sub a, $C7
    ld [wStringIndex], a
    call BeginStringDisplay
    ret

; overflow for message bank $83: wStringIndex -= $C7, then CopyStringToBuffer with the table Data_097_6DC1 in this bank (E-0080)
; 1 call site from 1 routine (e.g. CopyStringToBuffer_Bank83)
; reads: wStringIndex
; writes: wStringIndex
CopyStringToBuffer_Bank83_Overflow:: ; heuristic: follows a terminator; C0
Func_097_407F:: ; address name
    ld de, MessageStrings_Bank83_Overflow
    ld a, [wStringIndex]
    sub a, $C7
    ld [wStringIndex], a
    call CopyStringToBuffer
    ret
    db $CD, $70, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_97_4095::
MessageStrings_Bank28_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_097_4095:: ; address name
    dw StringList_97_4097 ; id 0

; E-0217 (derived: category list of StringCategories_97_4095; one pointer per wStringIndex)
; record: string
StringList_97_4097::
Data_097_4097:: ; address name
    dw String_97_4095_00_00 ; id 0
    dw String_97_4095_00_01 ; id 1
    dw String_97_4095_00_02 ; id 2
    dw String_97_4095_00_03 ; id 3
    dw String_97_4095_00_04 ; id 4
    dw String_97_4095_00_05 ; id 5
    dw String_97_4095_00_06 ; id 6
    dw String_97_4095_00_07 ; id 7
    dw String_97_4095_00_08 ; id 8
    dw String_97_4095_00_09 ; id 9
    dw String_97_4095_00_0A ; id 10
    dw String_97_4095_00_0B ; id 11
    dw String_97_4095_00_0C ; id 12
    dw String_97_4095_00_0D ; id 13
    dw String_97_4095_00_0E ; id 14
    dw String_97_4095_00_0F ; id 15
    dw String_97_4095_00_10 ; id 16
    dw String_97_4095_00_11 ; id 17
    dw String_97_4095_00_12 ; id 18
    dw String_97_4095_00_13 ; id 19
    dw String_97_4095_00_14 ; id 20
    dw String_97_4095_00_15 ; id 21
    dw String_97_4095_00_16 ; id 22
    dw String_97_4095_00_16 ; id 23
    dw String_97_4095_00_16 ; id 24
    dw String_97_4095_00_16 ; id 25
    dw String_97_4095_00_1A ; id 26
    dw String_97_4095_00_1B ; id 27
    dw String_97_4095_00_1C ; id 28
    dw String_97_4095_00_1C ; id 29
    dw String_97_4095_00_1C ; id 30
    dw String_97_4095_00_1C ; id 31
    dw String_97_4095_00_1C ; id 32
    dw String_97_4095_00_21 ; id 33
    dw String_97_4095_00_22 ; id 34
    dw String_97_4095_00_23 ; id 35
    dw String_97_4095_00_24 ; id 36
    dw String_97_4095_00_25 ; id 37

String_97_4095_00_00:: ; heuristic: string; C0
Data_097_40E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You have raised", $F1
    db "your charges well.", $FA, $F7
    db $EF, $EE, "Test them against", $EF, $EE, "me!", $F7
    db $F0

String_97_4095_00_01:: ; heuristic: string; C0
Data_097_4124:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? How did", $F1
    db "you get here?", $FA, $F7
    db $EF, $EE, "Arrgh, don't meddle", $EF, $EE, "in my affairs!", $F7
    db $F0

String_97_4095_00_02:: ; heuristic: string; C0
Data_097_416A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " All those who", $F1
    db "stood before me", $FA, $F7
    db $EF, $EE, "I shattered with", $EF, $EE, "these hands!", $F7
    db $F0

String_97_4095_00_03:: ; heuristic: string; C0
Data_097_41AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let me show you", $F1
    db "why your monsters", $FA, $F7
    db $EF, $EE, "can't stop shaking!", $EF, $EE, $F7
    db $F0

String_97_4095_00_04:: ; heuristic: string; C0
Data_097_41EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We can connect", $F1
    db "only in battle.", $FA, $F7
    db $EF, $EE, "Get ready!", $EF, $EE, $F7
    db $F0

String_97_4095_00_05:: ; heuristic: string; C0
Data_097_421F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Power is the", $F1
    db "basis of all!", $FA, $F7
    db $EF, $EE, "Your words are", $EF, $EE, "meaningless!", $F7
    db $F0

String_97_4095_00_06:: ; heuristic: string; C0
Data_097_425E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you wish to", $F1
    db "pass, you'll have", $FA, $F7
    db $EF, $EE, "to beat me. There's", $EF, $EE, "no other way!", $F7
    db $F0

String_97_4095_00_07:: ; heuristic: string; C0
Data_097_42A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're going to", $F1
    db "beat the boss?", $FA, $F7
    db $EF, $EE, "You have me to", $EF, $EE, "deal with first!", $F7
    db $F0

String_97_4095_00_08:: ; heuristic: string; C0
Data_097_42ED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Courage alone", $F1
    db "won't let you win!", $F7
    db $F0

String_97_4095_00_09:: ; heuristic: string; C0
Data_097_4311:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " So long as I", $F1
    db "stand, no one, but", $FA, $F7
    db $EF, $EE, "no one gets by", $EF, $EE, "here!", $F7
    db $F0

String_97_4095_00_0A:: ; heuristic: string; C0
Data_097_434E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh? There still", $F1
    db "was someone with", $FA, $F7
    db $EF, $EE, "a little spine?", $EF, $EE, "Fwahahaha!", $F7
    db $F0

String_97_4095_00_0B:: ; heuristic: string; C0
Data_097_4392:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? I'm busy!", $F1
    db "Make it quick!", $F7
    db $F0

String_97_4095_00_0C:: ; heuristic: string; C0
Data_097_43B4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Curse your luck", $F1
    db "for coming here!", $F7
    db $F0

String_97_4095_00_0D:: ; heuristic: string; C0
Data_097_43D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You think I", $F1
    db "look weak! Don't", $FA, $F7
    db $EF, $EE, "you deny it!", $EF, $EE, "I can tell!", $F7
    db $F0

String_97_4095_00_0E:: ; heuristic: string; C0
Data_097_4416:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Just how much", $F1
    db "are you willing to", $FA, $F7
    db $EF, $EE, "sacrifice before", $EF, $EE, "you give up?", $F7
    db $F0

String_97_4095_00_0F:: ; heuristic: string; C0
Data_097_445D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hyahyahya!", $F1
    db $FA, $F7
    db $EF, $EE, $F3, "Another weakling", $EF, $EE, "come to amuse me!", $F7
    db $F0

String_97_4095_00_10:: ; heuristic: string; C0
Data_097_4495:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Too late for", $F1
    db "regrets now.", $FA, $F7
    db $EF, $EE, "I'll show you my", $EF, $EE, "true strength!", $F7
    db $F0

String_97_4095_00_11:: ; heuristic: string; C0
Data_097_44D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Try to keep me", $F1
    db "amused at least.", $F7
    db $F0

String_97_4095_00_12:: ; heuristic: string; C0
Data_097_44FA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hah! You're too", $F1
    db "weak to take me!", $F7
    db $F0

String_97_4095_00_13:: ; heuristic: string; C0
Data_097_451E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The boss is", $F1
    db "beyond here.", $FA, $F7
    db $EF, $EE, "I can't let the", $EF, $EE, "likes of you pass.", $F7
    db $F0

String_97_4095_00_14:: ; heuristic: string; C0
Data_097_4561:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I've still got", $F1
    db "enough power to", $FA, $F7
    db $EF, $EE, "brush off a green", $EF, $EE, "master like you!", $F7
    db $F0

String_97_4095_00_15:: ; heuristic: string; C0
Data_097_45AA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fufufu", $A4, " There is", $F1
    db "only winning or", $FA, $F7
    db $EF, $EE, "losing in battle,", $EF, $EE, "and nothing else.", $F7
    db $F0

String_97_4095_00_16:: ; heuristic: string; C0
Data_097_45F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Get a tenth off", $F1
    db "the shop prices.", $F0

String_97_4095_00_1A:: ; heuristic: string; C0
Data_097_4618:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Use to create a", $F1
    db "door shrine.", $F0

String_97_4095_00_1B:: ; heuristic: string; C0
Data_097_4635:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It is an item with", $F1
    db "a magical power.", $F0

String_97_4095_00_1C:: ; heuristic: string; C0
Data_097_4659:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello! What can", $F1
    db "I do for you?", $F7
    db $F0

String_97_4095_00_21:: ; heuristic: string; C0
Data_097_467B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "THE END", $A4, $F0

String_97_4095_00_22:: ; heuristic: string; C0
Data_097_4684:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You have to eat", $F1
    db "your vegetables!", $FA, $F7
    db $EF, $EE, $F9, "0 was force-", $EF, $EE, "fed an INT Seed!", $F7
    db $F0

String_97_4095_00_23:: ; heuristic: string; C0
Data_097_46CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, that's mine!", $F1
    db $FA, $F7
    db $EF, $EE, $F9, "0 obtained a", $EF, $EE, "TinyMedal.", $F7
    db $F0

String_97_4095_00_24:: ; heuristic: string; C0
Data_097_46FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " Here, just", $F1
    db "take this.", $FA, $F7
    db $EF, $EE, $F9, "0 received", $EF, $EE, "10,000G!", $F7
    db $F0

String_97_4095_00_25:: ; heuristic: string; C0
Data_097_4737:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $9F, $9F, $9F, " Composing ", $9F, $9F, $9F, $F7
    db $F0

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_97_474A::
MessageStrings_Bank29_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_097_474A:: ; address name
    dw StringList_97_474C ; id 0

; E-0217 (derived: category list of StringCategories_97_474A; one pointer per wStringIndex)
; record: string
StringList_97_474C::
Data_097_474C:: ; address name
    dw String_97_474A_00_00 ; id 0
    dw String_97_474A_00_01 ; id 1
    dw String_97_474A_00_02 ; id 2
    dw String_97_474A_00_03 ; id 3
    dw String_97_474A_00_04 ; id 4
    dw String_97_474A_00_05 ; id 5
    dw String_97_474A_00_06 ; id 6
    dw String_97_474A_00_07 ; id 7
    dw String_97_474A_00_08 ; id 8
    dw String_97_474A_00_09 ; id 9
    dw String_97_474A_00_0A ; id 10
    dw String_97_474A_00_0B ; id 11
    dw String_97_474A_00_0C ; id 12
    dw String_97_474A_00_0D ; id 13
    dw String_97_474A_00_0E ; id 14
    dw String_97_474A_00_0F ; id 15
    dw String_97_474A_00_10 ; id 16
    dw String_97_474A_00_11 ; id 17
    dw String_97_474A_00_12 ; id 18
    dw String_97_474A_00_13 ; id 19
    dw String_97_474A_00_14 ; id 20
    dw String_97_474A_00_15 ; id 21
    dw String_97_474A_00_16 ; id 22
    dw String_97_474A_00_17 ; id 23
    dw String_97_474A_00_18 ; id 24
    dw String_97_474A_00_19 ; id 25
    dw String_97_474A_00_1A ; id 26
    dw String_97_474A_00_1B ; id 27
    dw String_97_474A_00_1C ; id 28
    dw String_97_474A_00_1D ; id 29
    dw String_97_474A_00_1E ; id 30
    dw String_97_474A_00_1F ; id 31
    dw String_97_474A_00_20 ; id 32
    dw String_97_474A_00_21 ; id 33
    dw String_97_474A_00_22 ; id 34
    dw String_97_474A_00_23 ; id 35
    dw String_97_474A_00_24 ; id 36
    dw String_97_474A_00_25 ; id 37
    dw String_97_474A_00_26 ; id 38
    dw String_97_474A_00_27 ; id 39
    dw String_97_474A_00_28 ; id 40
    dw String_97_474A_00_29 ; id 41
    dw String_97_474A_00_2A ; id 42
    dw String_97_474A_00_2B ; id 43
    dw String_97_474A_00_2C ; id 44
    dw String_97_474A_00_2D ; id 45
    dw String_97_474A_00_2E ; id 46
    dw String_97_474A_00_2F ; id 47
    dw String_97_474A_00_30 ; id 48
    dw String_97_474A_00_31 ; id 49
    dw String_97_474A_00_32 ; id 50
    dw String_97_474A_00_33 ; id 51
    dw String_97_474A_00_33 ; id 52
    dw String_97_474A_00_33 ; id 53
    dw String_97_474A_00_33 ; id 54
    dw String_97_474A_00_33 ; id 55
    dw String_97_474A_00_33 ; id 56
    dw String_97_474A_00_33 ; id 57
    dw String_97_474A_00_33 ; id 58
    dw String_97_474A_00_33 ; id 59
    dw String_97_474A_00_33 ; id 60
    dw String_97_474A_00_33 ; id 61
    dw String_97_474A_00_33 ; id 62
    dw String_97_474A_00_33 ; id 63
    dw String_97_474A_00_33 ; id 64
    dw String_97_474A_00_33 ; id 65
    dw String_97_474A_00_33 ; id 66
    dw String_97_474A_00_43 ; id 67
    dw String_97_474A_00_44 ; id 68
    dw String_97_474A_00_45 ; id 69
    dw String_97_474A_00_46 ; id 70
    dw String_97_474A_00_47 ; id 71
    dw String_97_474A_00_47 ; id 72
    dw String_97_474A_00_47 ; id 73
    dw String_97_474A_00_47 ; id 74
    dw String_97_474A_00_47 ; id 75
    dw String_97_474A_00_47 ; id 76
    dw String_97_474A_00_47 ; id 77
    dw String_97_474A_00_47 ; id 78
    dw String_97_474A_00_47 ; id 79
    dw String_97_474A_00_47 ; id 80
    dw String_97_474A_00_47 ; id 81
    dw String_97_474A_00_47 ; id 82
    dw String_97_474A_00_47 ; id 83
    dw String_97_474A_00_47 ; id 84
    dw String_97_474A_00_47 ; id 85
    dw String_97_474A_00_47 ; id 86
    dw String_97_474A_00_47 ; id 87
    dw String_97_474A_00_47 ; id 88
    dw String_97_474A_00_47 ; id 89
    dw String_97_474A_00_47 ; id 90
    dw String_97_474A_00_47 ; id 91
    dw String_97_474A_00_47 ; id 92
    dw String_97_474A_00_47 ; id 93
    dw String_97_474A_00_47 ; id 94
    dw String_97_474A_00_47 ; id 95
    dw String_97_474A_00_47 ; id 96
    dw String_97_474A_00_47 ; id 97
    dw String_97_474A_00_47 ; id 98
    dw String_97_474A_00_47 ; id 99
    dw String_97_474A_00_47 ; id 100
    dw String_97_474A_00_47 ; id 101
    dw String_97_474A_00_47 ; id 102
    dw String_97_474A_00_47 ; id 103
    dw String_97_474A_00_47 ; id 104
    dw String_97_474A_00_47 ; id 105
    dw String_97_474A_00_47 ; id 106
    dw String_97_474A_00_47 ; id 107
    dw String_97_474A_00_47 ; id 108
    dw String_97_474A_00_47 ; id 109
    dw String_97_474A_00_47 ; id 110
    dw String_97_474A_00_47 ; id 111
    dw String_97_474A_00_47 ; id 112
    dw String_97_474A_00_47 ; id 113

String_97_474A_00_00:: ; heuristic: string; C0
Data_097_4830:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Don't chase what", $F1
    db "runs from you.", $FA, $F7
    db $EF, $EE, "Lay some bait, and", $EF, $EE, "let it come.", $FA, $F7
    db $EF, $EE, "That's the trick.", $EF, $EE, "Don't understand?", $FA, $F7
    db $EF, $EE, "The oasis is east", $EF, $EE, "of here, beyond", $FA, $F7
    db $EF, $EE, "a range of craggy", $EF, $EE, "mountains.", $FA, $F7
    db $EF, $EE, "Head for it, and", $EF, $EE, "you'll see.", $F7
    db $F0

String_97_474A_00_01:: ; heuristic: string; C0
Data_097_4904:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We didn't help", $F1
    db "the thieves!", $FA, $F7
    db $EF, $EE, "One of their men", $EF, $EE, "had joined the", $FA, $F7
    db $EF, $EE, "circus and used", $EF, $EE, "us as a cover.", $FA, $F7
    db $EF, $EE, "We had no idea.", $EF, $EE, "Please, we should", $FA, $F7
    db $EF, $EE, "be released!", $EF, $EE, $F7
    db $F0

String_97_474A_00_02:: ; heuristic: string; C0
Data_097_49A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " The lake was", $F1
    db "in sight, but once", $FA, $F7
    db $EF, $EE, "we get this close,", $EF, $EE, "it isn't there!", $FA, $F7
    db $EF, $EE, "We'll never be", $EF, $EE, "able to find the", $FA, $F7
    db $EF, $EE, "hideout of the", $EF, $EE, "thieves this way!", $F7
    db $F0

String_97_474A_00_03:: ; heuristic: string; C0
Data_097_4A38:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We can see the", $F1
    db "hideout plainly,", $FA, $F7
    db $EF, $EE, "but where did the", $EF, $EE, "lake disappear to?", $F7
    db $F0

String_97_474A_00_04:: ; heuristic: string; C0
Data_097_4A85:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The prisoner in", $F1
    db "the dungeon said", $FA, $F7
    db $EF, $EE, "that he saw the", $EF, $EE, "mirage lake.", $FA, $F7
    db $EF, $EE, "I wonder if he was", $EF, $EE, "being truthful", $A4, $F7
    db $F0

String_97_474A_00_05:: ; heuristic: string; C0
Data_097_4AF2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How can we reach", $F1
    db "the hideout?", $F7
    db $F0

String_97_474A_00_06:: ; heuristic: string; C0
Data_097_4B14:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Thieves drove us", $F1
    db "from our homes!", $F7
    db $F0

String_97_474A_00_07:: ; heuristic: string; C0
Data_097_4B39:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The leader of", $F1
    db "the thieves is a", $FA, $F7
    db $EF, $EE, "terrible man!", $EF, $EE, "He uses monsters!", $F7
    db $F0

String_97_474A_00_08:: ; heuristic: string; C0
Data_097_4B80:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Heh, you have", $F1
    db "monsters in tow?", $FA, $F7
    db $EF, $EE, "You're not from", $EF, $EE, "this world.", $FA, $F7
    db $EF, $EE, "I've come from the", $EF, $EE, "same world as you.", $FA, $F7
    db $EF, $EE, "I've been wandering", $EF, $EE, "through the other", $FA, $F7
    db $EF, $EE, "worlds seeking the", $EF, $EE, "ultimate monster.", $FA, $F7
    db $EF, $EE, "I was promised a", $EF, $EE, "strong monster by", $FA, $F7
    db $EF, $EE, "the Demon Lord of", $EF, $EE, "Limbo in exchange", $FA, $F7
    db $EF, $EE, "for this world's", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "Come forth, my", $EF, $EE, "pretty!", $FA, $F7
    db $EF, $EE, "Show them their", $EF, $EE, "place!", $F7
    db $F0

String_97_474A_00_09:: ; heuristic: string; C0
Data_097_4CE1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You again!", $F1
    db "You're determined!", $FA, $F7
    db $EF, $EE, "But it won't make", $EF, $EE, "a difference!", $F7
    db $F0

String_97_474A_00_0A:: ; heuristic: string; C0
Data_097_4D25:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You defeated my", $F1
    db "monster?", $FA, $F7
    db $EF, $EE, "Urggh", $A4, $EF, $EE, "Time to regroup!", $F7
    db $F0

String_97_474A_00_0B:: ; heuristic: string; C0
Data_097_4D5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " You thieves!", $F1
    db "There's no escape!", $FA, $F7
    db $EF, $EE, "Repent for your", $EF, $EE, "misdeeds, and sur", $A4, $FA, $F7
    db $EF, $EE, "What? How did you", $EF, $EE, "get", $A4, " Ah, whatever!", $FA, $F7
    db $EF, $EE, "The thieves are in", $EF, $EE, "there?", $FA, $F7
    db $EF, $EE, "You're safe now!", $EF, $EE, "We're here!", $F7
    db $F0

String_97_474A_00_0C:: ; heuristic: string; C0
Data_097_4E12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Surrender", $F1
    db "and live!", $F7
    db $F0

String_97_474A_00_0D:: ; heuristic: string; C0
Data_097_4E2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Aiyeeh!", $F1
    db "Help me, boss!", $F7
    db $F0

String_97_474A_00_0E:: ; heuristic: string; C0
Data_097_4E49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Urgah! Mercy!", $F1
    db "I surrender!", $F7
    db $F0

String_97_474A_00_0F:: ; heuristic: string; C0
Data_097_4E68:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Wahah! We've", $F1
    db "bagged the lot!", $FA, $F7
    db $EF, $EE, "Peace will be", $EF, $EE, "restored among", $FA, $F7
    db $EF, $EE, "people and", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "You've been a great", $EF, $EE, "help to us.", $FA, $F7
    db $EF, $EE, "I must reward your", $EF, $EE, "efforts.", $F7
    db $F0

String_97_474A_00_10:: ; heuristic: string; C0
Data_097_4F09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " This is the", $F1
    db "TidalBell.", $FA, $F7
    db $EF, $EE, "It's imbued with a", $EF, $EE, "mystic power.", $FA, $F7
    db $EF, $EE, "What do you intend", $EF, $EE, "to do with it?", $FA, $F7
    db $EF, $EE, "Hm? A plug for a", $EF, $EE, "navel?", $FA, $F7
    db $EF, $EE, "Take this as my", $EF, $EE, "thanks!", $F7
    db $F0

String_97_474A_00_11:: ; heuristic: string; C0
Data_097_4FAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "TidalBell.", $F7
    db $F0

String_97_474A_00_12:: ; heuristic: string; C0
Data_097_4FC6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " I've been a", $F1
    db "burden to you, but", $FA, $F7
    db $EF, $EE, "I'll be fine now.", $EF, $EE, "I know what to do.", $FA, $F7
    db $EF, $EE, "I will rule with", $EF, $EE, "confidence.", $FA, $F7
    db $EF, $EE, "You will always be", $EF, $EE, "welcome with us!", $F7
    db $F0

String_97_474A_00_13:: ; heuristic: string; C0
Data_097_505D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A voice echoed", $F1
    db "from nowhere", $A4, $F7
    db $F0

String_97_474A_00_14:: ; heuristic: string; C0
Data_097_507B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "Wa-hey!", $F1
    db "Can you hear me?", $FA, $F7
    db $EF, $EE, "I felt an odd", $EF, $EE, "power stirring.", $FA, $F7
    db $EF, $EE, "You found a plug", $EF, $EE, "for the Navel!", $FA, $F7
    db $EF, $EE, "I'll bring you", $EF, $EE, "back! Don't move!", $F7
    db $F0

String_97_474A_00_15:: ; heuristic: string; C0
Data_097_5102:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King caught", $F1
    db "the thieves!", $F7
    db $F0

String_97_474A_00_16:: ; heuristic: string; C0
Data_097_5123:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The last king", $F1
    db "was a great man.", $FA, $F7
    db $EF, $EE, "Our King takes", $EF, $EE, "after him!", $F7
    db $F0

String_97_474A_00_17:: ; heuristic: string; C0
Data_097_5164:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We recovered", $F1
    db "everything that", $FA, $F7
    db $EF, $EE, "was taken from us.", $EF, $EE, $F7
    db $F0

String_97_474A_00_18:: ; heuristic: string; C0
Data_097_519D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The circus has", $F1
    db "moved onto the", $FA, $F7
    db $EF, $EE, "town, and they got", $EF, $EE, "there safely.", $F7
    db $F0

String_97_474A_00_19:: ; heuristic: string; C0
Data_097_51E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " His Majesty's", $F1
    db "popularity has", $FA, $F7
    db $EF, $EE, "been growing like", $EF, $EE, "wildfire.", $FA, $F7
    db $EF, $EE, "So much for idle", $EF, $EE, "rumors.", $F7
    db $F0

String_97_474A_00_1A:: ; heuristic: string; C0
Data_097_5241:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Making a hideout", $F1
    db "in Mirage Lake", $A4, $FA, $F7
    db $EF, $EE, "No wonder they", $EF, $EE, "avoided detection!", $F7
    db $F0

String_97_474A_00_1B:: ; heuristic: string; C0
Data_097_528C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " They let us out", $F1
    db "when they realized", $FA, $F7
    db $EF, $EE, "that we were also", $EF, $EE, "victims like them.", $FA, $F7
    db $EF, $EE, "Indeed, it was a", $EF, $EE, "double whammy!", $F7
    db $F0

String_97_474A_00_1C:: ; heuristic: string; C0
Data_097_5300:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Come back and", $F1
    db "join the troupe!", $FA, $F7
    db $EF, $EE, "You'll become a", $EF, $EE, "legendary tamer!", $F7
    db $F0

String_97_474A_00_1D:: ; heuristic: string; C0
Data_097_5347:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The troupe'll", $F1
    db "reform!", $FA, $F7
    db $EF, $EE, "We'll recruit new", $EF, $EE, "members, watch!", $F7
    db $F0

String_97_474A_00_1E:: ; heuristic: string; C0
Data_097_5385:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We're more", $F1
    db "vigilant now!", $FA, $F7
    db $EF, $EE, "No thieves will", $EF, $EE, "succeed again!", $F7
    db $F0

String_97_474A_00_1F:: ; heuristic: string; C0
Data_097_53C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I will do my", $F1
    db "best to help make", $FA, $F7
    db $EF, $EE, "the Kingdom a", $EF, $EE, "better place.", $F7
    db $F0

String_97_474A_00_20:: ; heuristic: string; C0
Data_097_5407:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome, our", $F1
    db "honored guests!", $FA, $F7
    db $EF, $EE, "The King is eager", $EF, $EE, "to see you!", $F7
    db $F0

String_97_474A_00_21:: ; heuristic: string; C0
Data_097_544A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Mirage Lake is a", $F1
    db "mystical place", $FA, $F7
    db $EF, $EE, "that can be seen,", $EF, $EE, "but never reached.", $FA, $F7
    db $EF, $EE, "It's famous as a", $EF, $EE, "haven for Beavern.", $F7
    db $F0

String_97_474A_00_22:: ; heuristic: string; C0
Data_097_54BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Ah, good of", $F1
    db "you to visit!", $FA, $F7
    db $EF, $EE, "Our people are", $EF, $EE, "living in peace", $FA, $F7
    db $EF, $EE, "again, much thanks", $EF, $EE, "to you!", $F7
    db $F0

String_97_474A_00_23:: ; heuristic: string; C0
Data_097_5522:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The dungeon is", $F1
    db "full of thieves!", $F7
    db $F0

String_97_474A_00_24:: ; heuristic: string; C0
Data_097_5546:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Cooh, our home", $F1
    db "come back to us!", $F7
    db $F0

String_97_474A_00_25:: ; heuristic: string; C0
Data_097_556A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Cooh! Thieves", $F1
    db "are gone!", $FA, $F7
    db $EF, $EE, "No more worries!", $EF, $EE, "Cooqueeh!", $F7
    db $F0

String_97_474A_00_26:: ; heuristic: string; C0
Data_097_55A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Cooh! This bed", $F1
    db "perfect for sleep!", $F7
    db $F0

String_97_474A_00_27:: ; heuristic: string; C0
Data_097_55CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Kyooh! Swimming", $F1
    db "in a desert", $A4, $FA, $F7
    db $EF, $EE, "This is luxury!", $EF, $EE, "No doubt!", $F7
    db $F0

String_97_474A_00_28:: ; heuristic: string; C0
Data_097_560A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Kyukyooh! You", $F1
    db "are good human.", $FA, $F7
    db $EF, $EE, "I respect you now!", $EF, $EE, $F7
    db $F0

String_97_474A_00_29:: ; heuristic: string; C0
Data_097_5644:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Cooh, I heard", $F1
    db "from others held", $FA, $F7
    db $EF, $EE, "captive by the", $EF, $EE, "thieves.", $FA, $F7
    db $EF, $EE, "You beat their", $EF, $EE, "boss!", $FA, $F7
    db $EF, $EE, "I see how you beat", $EF, $EE, "me now!", $FA, $F7
    db $EF, $EE, "Let me join your", $EF, $EE, "party!", $FF, $F0

String_97_474A_00_2A:: ; heuristic: string; C0
Data_097_56D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We are partners,", $F1
    db "and good ones too!", $F7
    db $F0

String_97_474A_00_2B:: ; heuristic: string; C0
Data_097_56FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "But you have no", $F1
    db "room for me", $A4, $F7
    db $F0

String_97_474A_00_2C:: ; heuristic: string; C0
Data_097_5721:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Tch, I think", $F1
    db "I can help you", $A4, $F7
    db $F0

String_97_474A_00_2D:: ; heuristic: string; C0
Data_097_5742:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to our", $F1
    db "inn!", $F7
    db $F0

String_97_474A_00_2E:: ; heuristic: string; C0
Data_097_575A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "Thieves have", $EF, $EE, "emptied it", $A4, $F7
    db $F0

String_97_474A_00_2F:: ; heuristic: string; C0
Data_097_5797:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was full of", $EF, $EE, "wood chips.", $F7
    db $F0

String_97_474A_00_30:: ; heuristic: string; C0
Data_097_57D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "There was a long,", $EF, $EE, "thin cloth.", $F7
    db $F0

String_97_474A_00_31:: ; heuristic: string; C0
Data_097_580B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "The prisoners", $95, $EF, $EE, "things were there.", $F7
    db $F0

String_97_474A_00_32:: ; heuristic: string; C0
Data_097_584B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "But it was empty", $A4, $EF, $EE, $F7
    db $F0

String_97_474A_00_33:: ; heuristic: string; C0
Data_097_5882:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is a great", $F1
    db "spot to raise a", $FA, $F7
    db $EF, $EE, "monster's egg.", $EF, $EE, "Eggs are supposed", $FA, $F7
    db $EF, $EE, "to be hatched at", $EF, $EE, "the Starry Shrine,", $FA, $F7
    db $EF, $EE, "but they won't", $EF, $EE, "notice if we hatch", $FA, $F7
    db $EF, $EE, "one here.", $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Have you ever", $F1
    db "found a Dream Egg?", $FF, $F0

String_97_474A_00_43:: ; heuristic: string; C0
Data_097_594B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Put the Dream", $F1
    db "Egg on the hay.", $FA, $F7
    db $EF, $EE, "To raise it, give", $EF, $EE, "it items.", $FA, $F7
    db $EF, $EE, "An Herb will raise", $EF, $EE, "HP, for example.", $FA, $F7
    db $EF, $EE, "To make the egg", $EF, $EE, "hatch, it needs", $FA, $F7
    db $EF, $EE, "you to talk to", $EF, $EE, "many people.", $FA, $F7
    db $EF, $EE, "If you're lucky,", $EF, $EE, "you may get a", $FA, $F7
    db $EF, $EE, "powerful monster", $EF, $EE, "to hatch.", $F7
    db $F0

String_97_474A_00_44:: ; heuristic: string; C0
Data_097_5A3A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This talk is too", $F1
    db "early for you.", $F7
    db $F0

String_97_474A_00_45:: ; heuristic: string; C0
Data_097_5A5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Have you ever", $F1
    db "found a Dream Egg?", $FF, $F0

String_97_474A_00_46:: ; heuristic: string; C0
Data_097_5A83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're the child", $F1
    db "of the farmer?", $FA, $F7
    db $EF, $EE, "Under his Majesty's", $EF, $EE, "decree, there will", $FA, $F7
    db $EF, $EE, "be a tournament", $EF, $EE, "for child masters.", $FA, $F7
    db $EF, $EE, "He wishes you to", $EF, $EE, "take part.", $FA, $F7
    db $EF, $EE, "Needless to say, a", $EF, $EE, "prize awaits the", $FA, $F7
    db $EF, $EE, "champion - the", $EF, $EE, "PirateKey.", $FA, $F7
    db $EF, $EE, "The winner also", $EF, $EE, "wins the right to", $FA, $F7
    db $EF, $EE, "use the Starry", $EF, $EE, "Shrine and Egg", $FA, $F7
    db $EF, $EE, "Evaluator's", $EF, $EE, "services.", $F7
    db $F0

String_97_474A_00_47:: ; heuristic: string; C0
Data_097_5BBE:: ; address name
    db $F0

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_97_5BBF::
MessageStrings_Bank2A_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_097_5BBF:: ; address name
    dw StringList_97_5BC1 ; id 0

; E-0217 (derived: category list of StringCategories_97_5BBF; one pointer per wStringIndex)
; record: string
StringList_97_5BC1::
Data_097_5BC1:: ; address name
    dw String_97_5BBF_00_00 ; id 0
    dw String_97_5BBF_00_01 ; id 1
    dw String_97_5BBF_00_02 ; id 2
    dw String_97_5BBF_00_03 ; id 3
    dw String_97_5BBF_00_04 ; id 4
    dw String_97_5BBF_00_05 ; id 5
    dw String_97_5BBF_00_06 ; id 6
    dw String_97_5BBF_00_07 ; id 7
    dw String_97_5BBF_00_08 ; id 8
    dw String_97_5BBF_00_09 ; id 9
    dw String_97_5BBF_00_0A ; id 10
    dw String_97_5BBF_00_0B ; id 11
    dw String_97_5BBF_00_0C ; id 12
    dw String_97_5BBF_00_0D ; id 13
    dw String_97_5BBF_00_0E ; id 14
    dw String_97_5BBF_00_0F ; id 15
    dw String_97_5BBF_00_10 ; id 16
    dw String_97_5BBF_00_11 ; id 17
    dw String_97_5BBF_00_12 ; id 18
    dw String_97_5BBF_00_13 ; id 19
    dw String_97_5BBF_00_14 ; id 20
    dw String_97_5BBF_00_15 ; id 21
    dw String_97_5BBF_00_16 ; id 22
    dw String_97_5BBF_00_17 ; id 23
    dw String_97_5BBF_00_18 ; id 24
    dw String_97_5BBF_00_19 ; id 25
    dw String_97_5BBF_00_1A ; id 26
    dw String_97_5BBF_00_1B ; id 27
    dw String_97_5BBF_00_1C ; id 28
    dw String_97_5BBF_00_1D ; id 29
    dw String_97_5BBF_00_1E ; id 30
    dw String_97_5BBF_00_1E ; id 31
    dw String_97_5BBF_00_1E ; id 32
    dw String_97_5BBF_00_1E ; id 33
    dw String_97_5BBF_00_1E ; id 34
    dw String_97_5BBF_00_1E ; id 35
    dw String_97_5BBF_00_1E ; id 36
    dw String_97_5BBF_00_1E ; id 37
    dw String_97_5BBF_00_1E ; id 38
    dw String_97_5BBF_00_1E ; id 39
    dw String_97_5BBF_00_1E ; id 40
    dw String_97_5BBF_00_1E ; id 41
    dw String_97_5BBF_00_1E ; id 42
    dw String_97_5BBF_00_1E ; id 43
    dw String_97_5BBF_00_1E ; id 44
    dw String_97_5BBF_00_1E ; id 45
    dw String_97_5BBF_00_1E ; id 46
    dw String_97_5BBF_00_1E ; id 47
    dw String_97_5BBF_00_1E ; id 48
    dw String_97_5BBF_00_1E ; id 49
    dw String_97_5BBF_00_1E ; id 50
    dw String_97_5BBF_00_1E ; id 51
    dw String_97_5BBF_00_1E ; id 52
    dw String_97_5BBF_00_1E ; id 53
    dw String_97_5BBF_00_1E ; id 54
    dw String_97_5BBF_00_1E ; id 55
    dw String_97_5BBF_00_1E ; id 56
    dw String_97_5BBF_00_1E ; id 57
    dw String_97_5BBF_00_1E ; id 58
    dw String_97_5BBF_00_1E ; id 59
    dw String_97_5BBF_00_1E ; id 60
    dw String_97_5BBF_00_1E ; id 61
    dw String_97_5BBF_00_1E ; id 62
    dw String_97_5BBF_00_1E ; id 63
    dw String_97_5BBF_00_1E ; id 64
    dw String_97_5BBF_00_1E ; id 65
    dw String_97_5BBF_00_1E ; id 66
    dw String_97_5BBF_00_1E ; id 67
    dw String_97_5BBF_00_1E ; id 68
    dw String_97_5BBF_00_1E ; id 69
    dw String_97_5BBF_00_1E ; id 70
    dw String_97_5BBF_00_1E ; id 71
    dw String_97_5BBF_00_48 ; id 72
    dw String_97_5BBF_00_49 ; id 73
    dw String_97_5BBF_00_49 ; id 74
    dw String_97_5BBF_00_49 ; id 75
    dw String_97_5BBF_00_49 ; id 76
    dw String_97_5BBF_00_49 ; id 77
    dw String_97_5BBF_00_49 ; id 78
    dw String_97_5BBF_00_49 ; id 79
    dw String_97_5BBF_00_49 ; id 80
    dw String_97_5BBF_00_49 ; id 81
    dw String_97_5BBF_00_52 ; id 82
    dw String_97_5BBF_00_52 ; id 83
    dw String_97_5BBF_00_52 ; id 84
    dw String_97_5BBF_00_55 ; id 85
    dw String_97_5BBF_00_55 ; id 86
    dw String_97_5BBF_00_55 ; id 87
    dw String_97_5BBF_00_58 ; id 88
    dw String_97_5BBF_00_59 ; id 89
    dw String_97_5BBF_00_59 ; id 90
    dw String_97_5BBF_00_59 ; id 91
    dw String_97_5BBF_00_59 ; id 92
    dw String_97_5BBF_00_59 ; id 93
    dw String_97_5BBF_00_59 ; id 94
    dw String_97_5BBF_00_59 ; id 95
    dw String_97_5BBF_00_59 ; id 96
    dw String_97_5BBF_00_59 ; id 97
    dw String_97_5BBF_00_59 ; id 98
    dw String_97_5BBF_00_59 ; id 99
    dw String_97_5BBF_00_59 ; id 100
    dw String_97_5BBF_00_59 ; id 101
    dw String_97_5BBF_00_59 ; id 102
    dw String_97_5BBF_00_59 ; id 103
    dw String_97_5BBF_00_59 ; id 104
    dw String_97_5BBF_00_59 ; id 105
    dw String_97_5BBF_00_59 ; id 106

String_97_5BBF_00_00:: ; heuristic: string; C0
Data_097_5C97:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In an Arena", $F1
    db "battle, you can't", $FA, $F7
    db $EF, $EE, "command your", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "You have to leave", $EF, $EE, "it up to them.", $FA, $F7
    db $EF, $EE, "What kinds of", $EF, $EE, "personalities they", $FA, $F7
    db $EF, $EE, "have will decide", $EF, $EE, "how they act.", $F7
    db $F0

String_97_5BBF_00_01:: ; heuristic: string; C0
Data_097_5D40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "the crowd's trash.", $F7
    db $F0

String_97_5BBF_00_02:: ; heuristic: string; C0
Data_097_5D83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to my", $F1
    db "Key Shop!", $FA, $F7
    db $EF, $EE, "I appraise and", $EF, $EE, "identify keys!", $FA, $F7
    db $EF, $EE, "An unidentified", $EF, $EE, "key can't be used!", $FA, $F7
    db $EF, $EE, "Should I appraise", $EF, $EE, "your keys?", $F0

String_97_5BBF_00_03:: ; heuristic: string; C0
Data_097_5E07:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to my", $F1
    db "Key Shop!", $FA, $F7
    db $EF, $EE, "Should I appraise", $EF, $EE, "your keys?", $F0

String_97_5BBF_00_04:: ; heuristic: string; C0
Data_097_5E43:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm apprenticing", $F1
    db "under the boss.", $FA, $F7
    db $EF, $EE, "He told me that", $EF, $EE, "the name of a key", $FA, $F7
    db $EF, $EE, "hints at its", $EF, $EE, "destination.", $F7
    db $F0

String_97_5BBF_00_05:: ; heuristic: string; C0
Data_097_5EAB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Day after day,", $F1
    db "I examine keys.", $FA, $F7
    db $EF, $EE, "But I'm nothing", $EF, $EE, "compared to the", $FA, $F7
    db $EF, $EE, "boss yet.", $EF, $EE, $F7
    db $F0

String_97_5BBF_00_06:: ; heuristic: string; C0
Data_097_5F00:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I found a key in", $F1
    db "another world, so", $FA, $F7
    db $EF, $EE, "I'm having it", $EF, $EE, "appraised.", $FA, $F7
    db $EF, $EE, "I hope it leads to", $EF, $EE, "a world with some", $FA, $F7
    db $EF, $EE, "monsters I've not", $EF, $EE, "yet seen.", $F7
    db $F0

String_97_5BBF_00_07:: ; heuristic: string; C0
Data_097_5F8B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "It greedily sucked", $EF, $EE, "air into its fire.", $F7
    db $F0

String_97_5BBF_00_08:: ; heuristic: string; C0
Data_097_5FCF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was full of", $EF, $EE, "jet-black coal.", $F7
    db $F0

String_97_5BBF_00_09:: ; heuristic: string; C0
Data_097_600C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "This time, you'll", $FA, $F7
    db $EF, $EE, "have to find the", $EF, $EE, "key first, warooh.", $FA, $F7
    db $EF, $EE, "The key, it should", $EF, $EE, "be in GreatLog.", $FA, $F7
    db $EF, $EE, "I think it is the", $EF, $EE, "PirateKey.", $FA, $F7
    db $EF, $EE, "Don't you forget", $EF, $EE, "it, warooh.", $F7
    db $F0

String_97_5BBF_00_0A:: ; heuristic: string; C0
Data_097_60C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "hurry.", $FA, $F7
    db $EF, $EE, "You need to gather", $EF, $EE, "more energy.", $F7
    db $F0

String_97_5BBF_00_0B:: ; heuristic: string; C0
Data_097_60FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "you've gathered", $FA, $F7
    db $EF, $EE, "enough energy for", $EF, $EE, "just one person.", $FA, $F7
    db $EF, $EE, "I need more energy", $EF, $EE, "still, hurry!", $F7
    db $F0

String_97_5BBF_00_0C:: ; heuristic: string; C0
Data_097_616C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey, I", $F1
    db "have enough energy", $FA, $F7
    db $EF, $EE, "for two people.", $EF, $EE, "But I need more.", $FA, $F7
    db $EF, $EE, "Just a bit more,", $EF, $EE, "and I'll be ready.", $F7
    db $F0

String_97_5BBF_00_0D:: ; heuristic: string; C0
Data_097_61E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey.", $F1
    db "I need you to go", $FA, $F7
    db $EF, $EE, "to another world", $EF, $EE, "to find a plug.", $FA, $F7
    db $EF, $EE, "But I've no power", $EF, $EE, "to make a key", $A4, $FA, $F7
    db $EF, $EE, "That power is from", $EF, $EE, "GreatLog's tree.", $FA, $F7
    db $EF, $EE, "It is energy made", $EF, $EE, "by the bond tying", $FA, $F7
    db $EF, $EE, "people and their", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "Help people bond", $EF, $EE, "with monsters, and", $FA, $F7
    db $EF, $EE, "GreatLog's power", $EF, $EE, "will be boosted.", $F7
    db $F0

String_97_5BBF_00_0E:: ; heuristic: string; C0
Data_097_6308:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "There is enough", $EF, $EE, "power for me to", $FA, $F7
    db $EF, $EE, "make a Magic Key,", $EF, $EE, "yes, warooh!", $FA, $F7
    db $EF, $EE, "Good job, ", $F9, "0!", $EF, $EE, "Just wait now!", $FA, $F7
    db $EF, $EE, "I'll make the key", $EF, $EE, "right away.", $F7
    db $F0

String_97_5BBF_00_0F:: ; heuristic: string; C0
Data_097_63B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0 you're slow!", $FA, $F7
    db $EF, $EE, "Kameha already", $EF, $EE, "came by today with", $FA, $F7
    db $EF, $EE, "the PirateKey,", $EF, $EE, "warooh.", $FA, $F7
    db $EF, $EE, "He got it from the", $EF, $EE, "King by whining.", $FA, $F7
    db $EF, $EE, "You", $44, " better follow", $EF, $EE, "him to the other", $FA, $F7
    db $EF, $EE, "world right away.", $EF, $EE, "Don't be late!", $FA, $F7
    db $EF, $EE, "Also, Kameha isn't", $EF, $EE, "a bad guy, warooh.", $FA, $F7
    db $EF, $EE, "If you see him", $EF, $EE, "over there, help", $FA, $F7
    db $EF, $EE, "him if he needs", $EF, $EE, "it.", $FA, $F7
    db $EF, $EE, "And, don't forget.", $EF, $EE, "You can cross", $FA, $F7
    db $EF, $EE, "water by using the", $EF, $EE, "TidalBell.", $FA, $F7
    db $EF, $EE, "Bring me back some", $EF, $EE, "good news, warooh!", $F7
    db $F0

String_97_5BBF_00_10:: ; heuristic: string; C0
Data_097_655C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "PirateKey.", $E5, $58, $F7
    db $E9, $FF, $F0

String_97_5BBF_00_11:: ; heuristic: string; C0
Data_097_657C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Putting up a", $F1
    db "bridge is easy!", $F7
    db $F0

String_97_5BBF_00_12:: ; heuristic: string; C0
Data_097_659D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "You did it, ", $F9, "0!", $FA, $F7
    db $EF, $EE, "GreatLog's power", $EF, $EE, "will heal you!", $F7
    db $F0

String_97_5BBF_00_13:: ; heuristic: string; C0
Data_097_65E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " There,", $F1
    db "your party's fine!", $FA, $F7
    db $EF, $EE, "So, the new plug", $EF, $EE, "for Log's Navel?", $F7
    db $F0

String_97_5BBF_00_14:: ; heuristic: string; C0
Data_097_662C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "So, this is it?", $FA, $F7
    db $EF, $EE, "This is the", $EF, $EE, "HarMirror, warooh?", $FA, $F7
    db $EF, $EE, "I can feel an odd", $EF, $EE, "power from it!", $F7
    db $F0

String_97_5BBF_00_15:: ; heuristic: string; C0
Data_097_6697:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "That's it!", $FA, $F7
    db $EF, $EE, "GreatLog is saved!", $EF, $EE, "Good, now", $A4, " Warooh?", $F7
    db $F0

String_97_5BBF_00_16:: ; heuristic: string; C0
Data_097_66DE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "No good, no good!", $FA, $F7
    db $EF, $EE, "I have to plug the", $EF, $EE, "Navel again!", $F7
    db $F0

String_97_5BBF_00_17:: ; heuristic: string; C0
Data_097_6727:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey", $A4, $F1
    db "That was no good.", $FA, $F7
    db $EF, $EE, "But HarMirror does", $EF, $EE, "have magic in it.", $FA, $F7
    db $EF, $EE, "Give me your hand,", $EF, $EE, $F9, "0. Wa-hey!", $F7
    db $F0

String_97_5BBF_00_18:: ; heuristic: string; C0
Data_097_6798:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Stop that!", $FA, $F7
    db $EF, $EE, "Why do you look so", $EF, $EE, "unhappy at me?", $FA, $F7
    db $EF, $EE, "A hero doesn't walk", $EF, $EE, "from someone in", $FA, $F7
    db $EF, $EE, "trouble, you ought", $EF, $EE, "to know that!", $FA, $F7
    db $EF, $EE, "Come on, give me a", $EF, $EE, "big smile, warooh!", $FF, $F0

String_97_5BBF_00_19:: ; heuristic: string; C0
Data_097_6852:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Listen.", $F1
    db "I feel a strange", $FA, $F7
    db $EF, $EE, "power in another", $EF, $EE, "world, warooh.", $FA, $F7
    db $EF, $EE, "It has to be a", $EF, $EE, "plug, I can tell!", $FA, $F7
    db $EF, $EE, "Wa-hey, gather", $EF, $EE, "more of the energy", $FA, $F7
    db $EF, $EE, "from GreatLog's", $EF, $EE, "tree, I need it.", $F7
    db $F0

String_97_5BBF_00_1A:: ; heuristic: string; C0
Data_097_6909:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "Angry still with", $EF, $EE, "me, warooh?", $FA, $F7
    db $EF, $EE, "Wasted energy,", $EF, $EE, "that is!", $FA, $F7
    db $EF, $EE, "Come on, cheer up", $EF, $EE, "and smile, wa-hey!", $FF, $F0

String_97_5BBF_00_1B:: ; heuristic: string; C0
Data_097_6986:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was full of", $EF, $EE, "junk.", $F7
    db $F0

String_97_5BBF_00_1C:: ; heuristic: string; C0
Data_097_69BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "It was still warm", $EF, $EE, "from cooking.", $F7
    db $F0

String_97_5BBF_00_1D:: ; heuristic: string; C0
Data_097_69F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Come back if you", $F1
    db "need to check up", $FA, $F7
    db $EF, $EE, "on your monster", $EF, $EE, "Catalog.", $F7
    db $F0

String_97_5BBF_00_1E:: ; heuristic: string; C0
Data_097_6A3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " GreatLog's", $F1
    db "Starry Shrine", $FA, $F7
    db $EF, $EE, "wasn't in use for", $EF, $EE, "a long time.", $FA, $F7
    db $EF, $EE, "But research into", $EF, $EE, "breeding shed new", $FA, $F7
    db $EF, $EE, "light on its great", $EF, $EE, "potential.", $FA, $F7
    db $EF, $EE, "Now, the Shrine is", $EF, $EE, "considered to be", $FA, $F7
    db $EF, $EE, "an indispensable", $EF, $EE, "place for masters.", $F7
    db $F0

String_97_5BBF_00_48:: ; heuristic: string; C0
Data_097_6B14:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Parents pass on", $F1
    db "abilities to their", $FA, $F7
    db $EF, $EE, "children, who in", $EF, $EE, "turn pass on their", $FA, $F7
    db $EF, $EE, "abilities to their", $EF, $EE, "own offspring.", $FA, $F7
    db $EF, $EE, "Saying goodbye is", $EF, $EE, "never easy, but", $FA, $F7
    db $EF, $EE, "that is the cycle", $EF, $EE, "of life.", $F7
    db $F0

String_97_5BBF_00_49:: ; heuristic: string; C0
Data_097_6BCE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "IceKey.", $E5, $58, $F7
    db $E9, $FF, $F0

String_97_5BBF_00_52:: ; heuristic: string; C0
Data_097_6BEB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey?", $F1
    db "So, this is it?", $FA, $F7
    db $EF, $EE, "This is the", $EF, $EE, "SkyShield, warooh?", $FA, $F7
    db $EF, $EE, "It gives off more", $EF, $EE, "magical power than", $FA, $F7
    db $EF, $EE, "the other things", $EF, $EE, "you've brought me.", $FA, $F7
    db $EF, $EE, "We'll see if it", $EF, $EE, "works, warooh!", $F7
    db $F0

String_97_5BBF_00_55:: ; heuristic: string; C0
Data_097_6CA3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey", $A4, $F1
    db "That was no good.", $FA, $F7
    db $EF, $EE, "But this too has", $EF, $EE, "magic in it.", $FA, $F7
    db $EF, $EE, "Give me your hand,", $EF, $EE, $F9, "0. Wa-hey!", $F7
    db $F0

String_97_5BBF_00_58:: ; heuristic: string; C0
Data_097_6D0D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Stop that!", $FA, $F7
    db $EF, $EE, "Why do you look so", $EF, $EE, "disgusted with me?", $FA, $F7
    db $EF, $EE, "People can do", $EF, $EE, "anything if they", $FA, $F7
    db $EF, $EE, "buckle down and", $EF, $EE, "work, warooh!", $FA, $F7
    db $EF, $EE, "Come on, give me a", $EF, $EE, "big smile, ", $F9, "0!", $FF, $F0

String_97_5BBF_00_59:: ; heuristic: string; C0
Data_097_6DC0:: ; address name
    db $F0

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_97_6DC1::
MessageStrings_Bank83_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_097_6DC1:: ; address name
    dw StringList_97_6DC3 ; id 0

; E-0217 (derived: category list of StringCategories_97_6DC1; one pointer per wStringIndex)
; record: string
StringList_97_6DC3::
Data_097_6DC3:: ; address name
    dw String_97_6DC1_00_00 ; id 0
    dw String_97_6DC1_00_01 ; id 1
    dw String_97_6DC1_00_02 ; id 2
    dw String_97_6DC1_00_03 ; id 3
    dw String_97_6DC1_00_04 ; id 4
    dw String_97_6DC1_00_05 ; id 5
    dw String_97_6DC1_00_06 ; id 6
    dw String_97_6DC1_00_07 ; id 7
    dw String_97_6DC1_00_08 ; id 8
    dw String_97_6DC1_00_09 ; id 9
    dw String_97_6DC1_00_0A ; id 10
    dw String_97_6DC1_00_0B ; id 11
    dw String_97_6DC1_00_0C ; id 12
    dw String_97_6DC1_00_0D ; id 13
    dw String_97_6DC1_00_0E ; id 14
    dw String_97_6DC1_00_0F ; id 15
    dw String_97_6DC1_00_10 ; id 16
    dw String_97_6DC1_00_11 ; id 17
    dw String_97_6DC1_00_12 ; id 18
    dw String_97_6DC1_00_13 ; id 19
    dw String_97_6DC1_00_14 ; id 20
    dw String_97_6DC1_00_15 ; id 21
    dw String_97_6DC1_00_16 ; id 22
    dw String_97_6DC1_00_17 ; id 23
    dw String_97_6DC1_00_18 ; id 24
    dw String_97_6DC1_00_19 ; id 25
    dw String_97_6DC1_00_1A ; id 26
    dw String_97_6DC1_00_1B ; id 27
    dw String_97_6DC1_00_1C ; id 28
    dw String_97_6DC1_00_1D ; id 29
    dw String_97_6DC1_00_1E ; id 30
    dw String_97_6DC1_00_1F ; id 31
    dw String_97_6DC1_00_20 ; id 32
    dw String_97_6DC1_00_21 ; id 33
    dw String_97_6DC1_00_22 ; id 34
    dw String_97_6DC1_00_23 ; id 35
    dw String_97_6DC1_00_24 ; id 36
    dw String_97_6DC1_00_25 ; id 37
    dw String_97_6DC1_00_26 ; id 38
    dw String_97_6DC1_00_27 ; id 39
    dw String_97_6DC1_00_28 ; id 40
    dw String_97_6DC1_00_29 ; id 41
    dw String_97_6DC1_00_2A ; id 42
    dw String_97_6DC1_00_2B ; id 43
    dw String_97_6DC1_00_2B ; id 44
    dw String_97_6DC1_00_2B ; id 45
    dw String_97_6DC1_00_2B ; id 46
    dw String_97_6DC1_00_2B ; id 47
    dw String_97_6DC1_00_2B ; id 48
    dw String_97_6DC1_00_2B ; id 49
    dw String_97_6DC1_00_2B ; id 50
    dw String_97_6DC1_00_2B ; id 51
    dw String_97_6DC1_00_2B ; id 52
    dw String_97_6DC1_00_2B ; id 53
    dw String_97_6DC1_00_2B ; id 54
    dw String_97_6DC1_00_2B ; id 55
    dw String_97_6DC1_00_2B ; id 56

String_97_6DC1_00_00:: ; heuristic: string; C0
Data_097_6E35:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The skills that", $F1
    db "are learned by", $FA, $F7
    db $EF, $EE, "monsters depends", $EF, $EE, "on their families.", $FA, $F7
    db $EF, $EE, "Through breeding,", $EF, $EE, "monsters will", $FA, $F7
    db $EF, $EE, "learn a greater", $EF, $EE, "variety of skills.", $F7
    db $F0

String_97_6DC1_00_01:: ; heuristic: string; C0
Data_097_6ECB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How quickly the", $F1
    db "different stats", $FA, $F7
    db $EF, $EE, "rise varies by the", $EF, $EE, "monster family.", $FA, $F7
    db $EF, $EE, "I bet you didn't", $EF, $EE, "know that.", $F7
    db $F0

String_97_6DC1_00_02:: ; heuristic: string; C0
Data_097_6F35:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I wish I could", $F1
    db "play outside", $A4, $FA, $F7
    db $EF, $EE, "But Mom won't let", $EF, $EE, "me go anywhere", $A4, $F7
    db $F0

String_97_6DC1_00_03:: ; heuristic: string; C0
Data_097_6F7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Aren't you lonely", $F1
    db "traveling alone?", $FA, $F7
    db $EF, $EE, "Oh, but then you're", $EF, $EE, "with monsters.", $F7
    db $F0

String_97_6DC1_00_04:: ; heuristic: string; C0
Data_097_6FC7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I wish I had", $F1
    db "monster friends.", $FA, $F7
    db $EF, $EE, "They could help me", $EF, $EE, "with my homework.", $F7
    db $F0

String_97_6DC1_00_05:: ; heuristic: string; C0
Data_097_7012:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Why are you", $F1
    db "consorting with", $FA, $F7
    db $EF, $EE, "monsters?", $EF, $EE, "I don't trust you!", $F7
    db $F0

String_97_6DC1_00_06:: ; heuristic: string; C0
Data_097_7052:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When I grow up,", $F1
    db "I'm going to take", $FA, $F7
    db $EF, $EE, "over my dad's job", $EF, $EE, "as a dealer.", $FA, $F7
    db $EF, $EE, "He travels from", $EF, $EE, "town to town!", $F7
    db $F0

String_97_6DC1_00_07:: ; heuristic: string; C0
Data_097_70BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " D-don't t-try to", $F1
    db "scare me.", $FA, $F7
    db $EF, $EE, "I", $A4, " I'm not scared", $EF, $EE, "of monsters!", $F7
    db $F0

String_97_6DC1_00_08:: ; heuristic: string; C0
Data_097_70FB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If we could fly", $F1
    db "like birds", $A4, $FA, $F7
    db $EF, $EE, "We", $44, " be able to go", $EF, $EE, "anywhere.", $FA, $F7
    db $EF, $EE, "Now that's freedom.", $EF, $EE, "Don't you think?", $F7
    db $F0

String_97_6DC1_00_09:: ; heuristic: string; C0
Data_097_7162:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Would you be my", $F1
    db "friend?", $F7
    db $F0

String_97_6DC1_00_0A:: ; heuristic: string; C0
Data_097_717E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Don't goof off!", $F1
    db "Do your homework!", $FA, $F7
    db $EF, $EE, "My mom says that", $EF, $EE, "all the time.", $F7
    db $F0

String_97_6DC1_00_0B:: ; heuristic: string; C0
Data_097_71C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Mom's going to", $F1
    db "have a baby soon.", $FA, $F7
    db $EF, $EE, "I wonder if it", $EF, $EE, "will be a boy or", $FA, $F7
    db $EF, $EE, "girl. It doesn't", $EF, $EE, "matter, though!", $F7
    db $F0

String_97_6DC1_00_0C:: ; heuristic: string; C0
Data_097_7232:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A bard, that's", $F1
    db "what I'm gonna be.", $FA, $F7
    db $EF, $EE, "Gonna travel and", $EF, $EE, "sing about it.", $FA, $F7
    db $EF, $EE, "I practice!", $EF, $EE, "La", $9D, " lalala", $9D, ".", $F7
    db $F0

String_97_6DC1_00_0D:: ; heuristic: string; C0
Data_097_7297:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $44, " love to ride", $F1
    db "through forests on", $FA, $F7
    db $EF, $EE, "a Unicorn.", $EF, $EE, "That's my dream.", $FA, $F7
    db $EF, $EE, "If it comes true,", $EF, $EE, "I'll let you ride!", $F7
    db $F0

String_97_6DC1_00_0E:: ; heuristic: string; C0
Data_097_7305:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I hate carrots!", $F1
    db "It tastes blecch!", $FA, $F7
    db $EF, $EE, "I bet a DanceVegi", $EF, $EE, "tastes awful too!", $F7
    db $F0

String_97_6DC1_00_0F:: ; heuristic: string; C0
Data_097_7353:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lipsy always", $F1
    db "wants to kiss.", $FA, $F7
    db $EF, $EE, "Mommy's like that", $EF, $EE, "after some cider.", $F7
    db $F0

String_97_6DC1_00_10:: ; heuristic: string; C0
Data_097_739A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm going to be", $F1
    db "like my dad and", $FA, $F7
    db $EF, $EE, "become a soldier.", $EF, $EE, "I'll get to wear", $FA, $F7
    db $EF, $EE, "the awesome armor", $EF, $EE, "they have.", $F7
    db $F0

String_97_6DC1_00_11:: ; heuristic: string; C0
Data_097_7404:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Do you think it's", $F1
    db "impressive to have", $FA, $F7
    db $EF, $EE, "monsters around?", $EF, $EE, "I'm not jealous.", $FA, $F7
    db $EF, $EE, "No, really, I'm", $EF, $EE, "not envious!", $F7
    db $F0

String_97_6DC1_00_12:: ; heuristic: string; C0
Data_097_7471:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm your master", $F1
    db "from now on!", $FA, $F7
    db $EF, $EE, "Your first order", $EF, $EE, "is", $A4, $FA, $F7
    db $EF, $EE, "Wait! Listen!", $EF, $EE, "Will you listen?", $F7
    db $F0

String_97_6DC1_00_13:: ; heuristic: string; C0
Data_097_74CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You act big for", $F1
    db "an outsider!", $FA, $F7
    db $EF, $EE, "Don't think you", $EF, $EE, "scare me with your", $FA, $F7
    db $EF, $EE, "monsters. I", $A4, " I'm", $EF, $EE, "not scared a bit!", $F7
    db $F0

String_97_6DC1_00_14:: ; heuristic: string; C0
Data_097_753A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monsters get", $F1
    db "discouraged if you", $FA, $F7
    db $EF, $EE, "order them around", $EF, $EE, "all the time.", $FA, $F7
    db $EF, $EE, "You should assign", $EF, $EE, "them a plan, and", $FA, $F7
    db $EF, $EE, "let them do what", $EF, $EE, "they want.", $F7
    db $F0

String_97_6DC1_00_15:: ; heuristic: string; C0
Data_097_75C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A bred monster", $F1
    db "learns the skills", $FA, $F7
    db $EF, $EE, "that its parents", $EF, $EE, "knew.", $FA, $F7
    db $EF, $EE, "So, it will learn", $EF, $EE, "many skills.", $F7
    db $F0

String_97_6DC1_00_16:: ; heuristic: string; C0
Data_097_762C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Skills come in", $F1
    db "the three groups", $FA, $F7
    db $EF, $EE, "of attack, support", $EF, $EE, "and defense.", $F7
    db $F0

String_97_6DC1_00_17:: ; heuristic: string; C0
Data_097_7674:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You'll find it", $F1
    db "easier to raise", $FA, $F7
    db $EF, $EE, "monsters if you", $EF, $EE, "assign them roles.", $FA, $F7
    db $EF, $EE, "On the other hand,", $EF, $EE, "you could raise", $FA, $F7
    db $EF, $EE, "one like a hero-", $EF, $EE, "useful all around.", $F7
    db $F0

String_97_6DC1_00_18:: ; heuristic: string; C0
Data_097_770C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I've never met", $F1
    db "anyone like you.", $FA, $F7
    db $EF, $EE, "Your quiet way is", $EF, $EE, "just so cool!", $F7
    db $F0

String_97_6DC1_00_19:: ; heuristic: string; C0
Data_097_7753:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You came from", $F1
    db "GreatLog?", $FA, $F7
    db $EF, $EE, "I've never heard", $EF, $EE, "of it, sorry.", $F7
    db $F0

String_97_6DC1_00_1A:: ; heuristic: string; C0
Data_097_7791:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, you're a", $F1
    db "traveler?", $FA, $F7
    db $EF, $EE, "From GreatLog, you", $EF, $EE, "say.", $FA, $F7
    db $EF, $EE, "I've been to", $EF, $EE, "GreatTree, myself.", $F7
    db $F0

String_97_6DC1_00_1B:: ; heuristic: string; C0
Data_097_77EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I've heard tales", $F1
    db "that GreatLog is a", $FA, $F7
    db $EF, $EE, "hollowed out palm", $EF, $EE, "tree.", $F7
    db $F0

String_97_6DC1_00_1C:: ; heuristic: string; C0
Data_097_782D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're from", $F1
    db "GreatLog?", $F7
    db $F0, "Isn't that where", $F1
    db "the prince is a", $FA, $F7
    db $EF, $EE, "little terror?", $EF, $EE, "Kameha, right?", $FA, $F7
    db $EF, $EE, "Royalty can be so", $EF, $EE, "selfish.", $F7
    db $F0

String_97_6DC1_00_1D:: ; heuristic: string; C0
Data_097_78A8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I understand", $F1
    db "monster masters", $FA, $F7
    db $EF, $EE, "flock to the", $EF, $EE, "kingdom of", $FA, $F7
    db $EF, $EE, "GreatLog.", $EF, $EE, $FA, $F7
    db $EF, $EE, "Oh? You're from", $EF, $EE, "GreatLog, you say?", $F7
    db $F0

String_97_6DC1_00_1E:: ; heuristic: string; C0
Data_097_791A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I wander the", $F1
    db "other worlds", $A4, $FA, $F7
    db $EF, $EE, "I'm sure we will", $EF, $EE, "meet again.", $F7
    db $F0

String_97_6DC1_00_1F:: ; heuristic: string; C0
Data_097_7959:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I wander the", $F1
    db "other worlds", $A4, $FA, $F7
    db $EF, $EE, "I chronicle what", $EF, $EE, "I've experienced.", $F7
    db $F0

String_97_6DC1_00_20:: ; heuristic: string; C0
Data_097_799E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I wander the", $F1
    db "other worlds", $A4, $FA, $F7
    db $EF, $EE, "I'll see more, as", $EF, $EE, "I've done today.", $F7
    db $F0

String_97_6DC1_00_21:: ; heuristic: string; C0
Data_097_79E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I wander the", $F1
    db "other worlds", $A4, $FA, $F7
    db $EF, $EE, "I'll soon leave", $EF, $EE, "for another world.", $F7
    db $F0

String_97_6DC1_00_22:: ; heuristic: string; C0
Data_097_7A27:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I wander the", $F1
    db "other worlds", $A4, $FA, $F7
    db $EF, $EE, "We may have", $EF, $EE, "crossed paths", $A4, $F7
    db $F0

String_97_6DC1_00_23:: ; heuristic: string; C0
Data_097_7A65:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I study monsters", $F1
    db "in other worlds.", $FA, $F7
    db $EF, $EE, "I'm intrigued by", $EF, $EE, "your monsters.", $F7
    db $F0

String_97_6DC1_00_24:: ; heuristic: string; C0
Data_097_7AAE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I study monsters", $F1
    db "in other worlds.", $FA, $F7
    db $EF, $EE, "I think I'm done", $EF, $EE, "with this area.", $F7
    db $F0

String_97_6DC1_00_25:: ; heuristic: string; C0
Data_097_7AF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I study monsters", $F1
    db "in other worlds.", $FA, $F7
    db $EF, $EE, "What monsters", $EF, $EE, "await me next?", $F7
    db $F0

String_97_6DC1_00_26:: ; heuristic: string; C0
Data_097_7B3F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I study monsters", $F1
    db "in other worlds.", $FA, $F7
    db $EF, $EE, "Haven't I seen you", $EF, $EE, "elsewhere before?", $F7
    db $F0

String_97_6DC1_00_27:: ; heuristic: string; C0
Data_097_7B8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Humph", $A4, $F1
    db $FA, $F7
    db $EF, $EE, $F3, "That's my Terry", $EF, $EE, "impression. So?", $F7
    db $F0

String_97_6DC1_00_28:: ; heuristic: string; C0
Data_097_7BBD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I met this girl", $F1
    db "named Milayou.", $FA, $F7
    db $EF, $EE, "Hoo boy, she was", $EF, $EE, "some kind of cute.", $FA, $F7
    db $EF, $EE, "She'll become", $EF, $EE, "stunning for sure!", $F7
    db $F0

String_97_6DC1_00_29:: ; heuristic: string; C0
Data_097_7C2C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I wish Terry", $44, $F1
    db "visit again.", $FA, $F7
    db $EF, $EE, "The girls come out", $EF, $EE, "to see him.", $F7
    db $F0

String_97_6DC1_00_2A:: ; heuristic: string; C0
Data_097_7C6E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm going to", $F1
    db "marry Milayou.", $FA, $F7
    db $EF, $EE, "You bet I will!", $EF, $EE, "I said so!", $F7
    db $F0

String_97_6DC1_00_2B:: ; heuristic: string; C0
Data_097_7CAC:: ; address name
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
    db "000000000000000000000000000000000000000000000000000000000000"
    db "000000000000"
