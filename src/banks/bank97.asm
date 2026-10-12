SECTION "Bank 97", ROMX[$4000], BANK[$97]
    db $97

; only called from BeginStringDisplay_Bank28 (E-0047)
; 1 call site from 1 routine (e.g. BeginStringDisplay_Bank28)
; reads: wStringIndex
; writes: wStringIndex
BeginStringDisplay_Bank28_Sub01::
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

; string-pointer table for message bank $28, strings from $DA up (index minus $DA) (E-0080)
; address loaded by BeginStringDisplay_Bank28_Sub01, CopyStringToBuffer_Bank28_Overflow
MessageStrings_Bank28_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_097_4095:: ; address name
    dw Data_097_4097

Data_097_4097:: ; heuristic: target of a monotone pointer table; C0
    dw Message_00_DA
    dw Message_00_DB
    dw Message_00_DC
    dw Message_00_DD
    dw Message_00_DE
    dw Message_00_DF
    dw Message_00_E0
    dw Message_00_E1
    dw Message_00_E2
    dw Message_00_E3
    dw Message_00_E4
    dw Message_00_E5
    dw Message_00_E6
    dw Message_00_E7
    dw Message_00_E8
    dw Message_00_E9
    dw Message_00_EA
    dw Message_00_EB
    dw Message_00_EC
    dw Message_00_ED
    dw Message_00_EE
    dw Message_00_EF
    dw Message_00_F0
    dw Message_00_F0
    dw Message_00_F0
    dw Message_00_F0
    dw Message_00_F4
    dw Message_00_F5
    dw Message_00_F6
    dw Message_00_F6
    dw Message_00_F6
    dw Message_00_F6
    dw Message_00_F6
    dw Message_00_FB
    dw Message_00_FC
    dw Message_00_FD
    dw Message_00_FE
    dw Message_00_FF

Message_00_DA:: ; heuristic: string; C0
Data_097_40E3:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have raised", $F1
    db "your charges well.", $FA, $F7
    db $EF, $EE, "Test them against", $EF, $EE, "me!", $F7
    db $F0

Message_00_DB:: ; heuristic: string; C0
Data_097_4124:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? How did", $F1
    db "you get here?", $FA, $F7
    db $EF, $EE, "Arrgh, don't meddle", $EF, $EE, "in my affairs!", $F7
    db $F0

Message_00_DC:: ; heuristic: string; C0
Data_097_416A:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " All those who", $F1
    db "stood before me", $FA, $F7
    db $EF, $EE, "I shattered with", $EF, $EE, "these hands!", $F7
    db $F0

Message_00_DD:: ; heuristic: string; C0
Data_097_41AE:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Let me show you", $F1
    db "why your monsters", $FA, $F7
    db $EF, $EE, "can't stop shaking!", $EF, $EE, $F7
    db $F0

Message_00_DE:: ; heuristic: string; C0
Data_097_41EC:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We can connect", $F1
    db "only in battle.", $FA, $F7
    db $EF, $EE, "Get ready!", $EF, $EE, $F7
    db $F0

Message_00_DF:: ; heuristic: string; C0
Data_097_421F:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Power is the", $F1
    db "basis of all!", $FA, $F7
    db $EF, $EE, "Your words are", $EF, $EE, "meaningless!", $F7
    db $F0

Message_00_E0:: ; heuristic: string; C0
Data_097_425E:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you wish to", $F1
    db "pass, you'll have", $FA, $F7
    db $EF, $EE, "to beat me. There's", $EF, $EE, "no other way!", $F7
    db $F0

Message_00_E1:: ; heuristic: string; C0
Data_097_42A7:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're going to", $F1
    db "beat the boss?", $FA, $F7
    db $EF, $EE, "You have me to", $EF, $EE, "deal with first!", $F7
    db $F0

Message_00_E2:: ; heuristic: string; C0
Data_097_42ED:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Courage alone", $F1
    db "won't let you win!", $F7
    db $F0

Message_00_E3:: ; heuristic: string; C0
Data_097_4311:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " So long as I", $F1
    db "stand, no one, but", $FA, $F7
    db $EF, $EE, "no one gets by", $EF, $EE, "here!", $F7
    db $F0

Message_00_E4:: ; heuristic: string; C0
Data_097_434E:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? There still", $F1
    db "was someone with", $FA, $F7
    db $EF, $EE, "a little spine?", $EF, $EE, "Fwahahaha!", $F7
    db $F0

Message_00_E5:: ; heuristic: string; C0
Data_097_4392:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? I'm busy!", $F1
    db "Make it quick!", $F7
    db $F0

Message_00_E6:: ; heuristic: string; C0
Data_097_43B4:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Curse your luck", $F1
    db "for coming here!", $F7
    db $F0

Message_00_E7:: ; heuristic: string; C0
Data_097_43D9:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You think I", $F1
    db "look weak! Don't", $FA, $F7
    db $EF, $EE, "you deny it!", $EF, $EE, "I can tell!", $F7
    db $F0

Message_00_E8:: ; heuristic: string; C0
Data_097_4416:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Just how much", $F1
    db "are you willing to", $FA, $F7
    db $EF, $EE, "sacrifice before", $EF, $EE, "you give up?", $F7
    db $F0

Message_00_E9:: ; heuristic: string; C0
Data_097_445D:: ; address name
    db $EA, $45, $90, $11, $3C, $24, $2B, $3C, $24, $2B, $3C, $24, $99, $F1, $FA, $F7
    db $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Another weakling", $EF, $EE, "come to amuse me!", $F7
    db $F0

Message_00_EA:: ; heuristic: string; C0
Data_097_4495:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Too late for", $F1
    db "regrets now.", $FA, $F7
    db $EF, $EE, "I'll show you my", $EF, $EE, "true strength!", $F7
    db $F0

Message_00_EB:: ; heuristic: string; C0
Data_097_44D6:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Try to keep me", $F1
    db "amused at least.", $F7
    db $F0

Message_00_EC:: ; heuristic: string; C0
Data_097_44FA:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hah! You're too", $F1
    db "weak to take me!", $F7
    db $F0

Message_00_ED:: ; heuristic: string; C0
Data_097_451E:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The boss is", $F1
    db "beyond here.", $FA, $F7
    db $EF, $EE, "I can't let the", $EF, $EE, "likes of you pass.", $F7
    db $F0

Message_00_EE:: ; heuristic: string; C0
Data_097_4561:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e still got", $F1
    db "enough power to", $FA, $F7
    db $EF, $EE, "brush off a green", $EF, $EE, "master like you!", $F7
    db $F0

Message_00_EF:: ; heuristic: string; C0
Data_097_45AA:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Fufufu", $A4, " There is", $F1
    db "only winning or", $FA, $F7
    db $EF, $EE, "losing in battle,", $EF, $EE, "and nothing else.", $F7
    db $F0

Message_00_F0:: ; heuristic: string; C0
Data_097_45F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Get a tenth off", $F1
    db "the shop prices.", $F0

Message_00_F4:: ; heuristic: string; C0
Data_097_4618:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Use to create a", $F1
    db "door shrine.", $F0

Message_00_F5:: ; heuristic: string; C0
Data_097_4635:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It is an item with", $F1
    db "a magical power.", $F0

Message_00_F6:: ; heuristic: string; C0
Data_097_4659:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello! What can", $F1
    db "I do for you?", $F7
    db $F0

Message_00_FB:: ; heuristic: string; C0
Data_097_467B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "THE END", $A4, $F0

Message_00_FC:: ; heuristic: string; C0
Data_097_4684:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have to eat", $F1
    db "your vegetables!", $FA, $F7
    db $EF, $EE, $F9, "0 was force-", $EF, $EE, "fed an INT Seed!", $F7
    db $F0

Message_00_FD:: ; heuristic: string; C0
Data_097_46CC:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, that's mine!", $F1
    db $FA, $F7
    db $EF, $EE, $F9, "0 obtained a", $EF, $EE, "TinyMedal.", $F7
    db $F0

Message_00_FE:: ; heuristic: string; C0
Data_097_46FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " Here, just", $F1
    db "take this.", $FA, $F7
    db $EF, $EE, $F9, "0 received", $EF, $EE, "10,000G!", $F7
    db $F0

Message_00_FF:: ; heuristic: string; C0
Data_097_4737:: ; address name
    db $9F, $9F, $9F, $90, $0C, $32, $30, $33, $32, $36, $2C, $31, $2A, $90, $9F, $9F
    db $9F, $F7, $F0

; string-pointer table for message bank $29, strings from $8E up (index minus $8E) (E-0080)
; address loaded by BeginStringDisplay_Bank29_Overflow, CopyStringToBuffer_Bank29_Overflow
MessageStrings_Bank29_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_097_474A:: ; address name
    dw Data_097_474C

Data_097_474C:: ; heuristic: target of a monotone pointer table; C0
    dw Message_01_8E
    dw Message_01_8F
    dw Message_01_90
    dw Message_01_91
    dw Message_01_92
    dw Message_01_93
    dw Message_01_94
    dw Message_01_95
    dw Message_01_96
    dw Message_01_97
    dw Message_01_98
    dw Message_01_99
    dw Message_01_9A
    dw Message_01_9B
    dw Message_01_9C
    dw Message_01_9D
    dw Message_01_9E
    dw Message_01_9F
    dw Message_01_A0
    dw Message_01_A1
    dw Message_01_A2
    dw Message_01_A3
    dw Message_01_A4
    dw Message_01_A5
    dw Message_01_A6
    dw Message_01_A7
    dw Message_01_A8
    dw Message_01_A9
    dw Message_01_AA
    dw Message_01_AB
    dw Message_01_AC
    dw Message_01_AD
    dw Message_01_AE
    dw Message_01_AF
    dw Message_01_B0
    dw Message_01_B1
    dw Message_01_B2
    dw Message_01_B3
    dw Message_01_B4
    dw Message_01_B5
    dw Message_01_B6
    dw Message_01_B7
    dw Message_01_B8
    dw Message_01_B9
    dw Message_01_BA
    dw Message_01_BB
    dw Message_01_BC
    dw Message_01_BD
    dw Message_01_BE
    dw Message_01_BF
    dw Message_01_C0
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_C1
    dw Message_01_D1
    dw Message_01_D2
    dw Message_01_D3
    dw Message_01_D4
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5
    dw Message_01_D5

Message_01_8E:: ; heuristic: string; C0
Data_097_4830:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't chase what", $F1
    db "runs from you.", $FA, $F7
    db $EF, $EE, "Lay some bait, and", $EF, $EE, "let it come.", $FA, $F7
    db $EF, $EE, "That's the trick.", $EF, $EE, "Don't understand?", $FA, $F7
    db $EF, $EE, "The oasis is east", $EF, $EE, "of here, beyond", $FA, $F7
    db $EF, $EE, "a range of craggy", $EF, $EE, "mountains.", $FA, $F7
    db $EF, $EE, "Head for it, and", $EF, $EE, "you'll see.", $F7
    db $F0

Message_01_8F:: ; heuristic: string; C0
Data_097_4904:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We didn't help", $F1
    db "the thieves!", $FA, $F7
    db $EF, $EE, "One of their men", $EF, $EE, "had joined the", $FA, $F7
    db $EF, $EE, "circus and used", $EF, $EE, "us as a cover.", $FA, $F7
    db $EF, $EE, "We had no idea.", $EF, $EE, "Please, we should", $FA, $F7
    db $EF, $EE, "be released!", $EF, $EE, $F7
    db $F0

Message_01_90:: ; heuristic: string; C0
Data_097_49A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " The lake was", $F1
    db "in sight, but once", $FA, $F7
    db $EF, $EE, "we get this close,", $EF, $EE, "it isn't there!", $FA, $F7
    db $EF, $EE, "We'll never be", $EF, $EE, "able to find the", $FA, $F7
    db $EF, $EE, "hideout of the", $EF, $EE, "thieves this way!", $F7
    db $F0

Message_01_91:: ; heuristic: string; C0
Data_097_4A38:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We can see the", $F1
    db "hideout plainly,", $FA, $F7
    db $EF, $EE, "but where did the", $EF, $EE, "lake disappear to?", $F7
    db $F0

Message_01_92:: ; heuristic: string; C0
Data_097_4A85:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The prisoner in", $F1
    db "the dungeon said", $FA, $F7
    db $EF, $EE, "that he saw the", $EF, $EE, "mirage lake.", $FA, $F7
    db $EF, $EE, "I wonder if he was", $EF, $EE, "being truthful", $A4, $F7
    db $F0

Message_01_93:: ; heuristic: string; C0
Data_097_4AF2:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How can we reach", $F1
    db "the hideout?", $F7
    db $F0

Message_01_94:: ; heuristic: string; C0
Data_097_4B14:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Thieves drove us", $F1
    db "from our homes!", $F7
    db $F0

Message_01_95:: ; heuristic: string; C0
Data_097_4B39:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The leader of", $F1
    db "the thieves is a", $FA, $F7
    db $EF, $EE, "terrible man!", $EF, $EE, "He uses monsters!", $F7
    db $F0

Message_01_96:: ; heuristic: string; C0
Data_097_4B80:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Heh, you have", $F1
    db "monsters in tow?", $FA, $F7
    db $EF, $EE, "You're not from", $EF, $EE, "this world.", $FA, $F7
    db $EF, $EE, "I", $42, "e come from the", $EF, $EE, "same world as you.", $FA, $F7
    db $EF, $EE, "I", $42, "e been wandering", $EF, $EE, "through the other", $FA, $F7
    db $EF, $EE, "worlds seeking the", $EF, $EE, "ultimate monster.", $FA, $F7
    db $EF, $EE, "I was promised a", $EF, $EE, "strong monster by", $FA, $F7
    db $EF, $EE, "the Demon Lord of", $EF, $EE, "Limbo in exchange", $FA, $F7
    db $EF, $EE, "for this world's", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "Come forth, my", $EF, $EE, "pretty!", $FA, $F7
    db $EF, $EE, "Show them their", $EF, $EE, "place!", $F7
    db $F0

Message_01_97:: ; heuristic: string; C0
Data_097_4CE1:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You again!", $F1
    db "You're determined!", $FA, $F7
    db $EF, $EE, "But it won't make", $EF, $EE, "a difference!", $F7
    db $F0

Message_01_98:: ; heuristic: string; C0
Data_097_4D25:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You defeated my", $F1
    db "monster?", $FA, $F7
    db $EF, $EE, "Urggh", $A4, $EF, $EE, "Time to regroup!", $F7
    db $F0

Message_01_99:: ; heuristic: string; C0
Data_097_4D5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " You thieves!", $F1
    db "There's no escape!", $FA, $F7
    db $EF, $EE, "Repent for your", $EF, $EE, "misdeeds, and sur", $A4, $FA, $F7
    db $EF, $EE, "What? How did you", $EF, $EE, "get", $A4, " Ah, whatever!", $FA, $F7
    db $EF, $EE, "The thieves are in", $EF, $EE, "there?", $FA, $F7
    db $EF, $EE, "You're safe now!", $EF, $EE, "We're here!", $F7
    db $F0

Message_01_9A:: ; heuristic: string; C0
Data_097_4E12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Surrender", $F1
    db "and live!", $F7
    db $F0

Message_01_9B:: ; heuristic: string; C0
Data_097_4E2E:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Aiyeeh!", $F1
    db "Help me, boss!", $F7
    db $F0

Message_01_9C:: ; heuristic: string; C0
Data_097_4E49:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Urgah! Mercy!", $F1
    db "I surrender!", $F7
    db $F0

Message_01_9D:: ; heuristic: string; C0
Data_097_4E68:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Wahah! We", $42, "e", $F1
    db "bagged the lot!", $FA, $F7
    db $EF, $EE, "Peace will be", $EF, $EE, "restored among", $FA, $F7
    db $EF, $EE, "people and", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "You", $42, "e been a great", $EF, $EE, "help to us.", $FA, $F7
    db $EF, $EE, "I must reward your", $EF, $EE, "efforts.", $F7
    db $F0

Message_01_9E:: ; heuristic: string; C0
Data_097_4F09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " This is the", $F1
    db "TidalBell.", $FA, $F7
    db $EF, $EE, "It's imbued with a", $EF, $EE, "mystic power.", $FA, $F7
    db $EF, $EE, "What do you intend", $EF, $EE, "to do with it?", $FA, $F7
    db $EF, $EE, "Hm? A plug for a", $EF, $EE, "navel?", $FA, $F7
    db $EF, $EE, "Take this as my", $EF, $EE, "thanks!", $F7
    db $F0

Message_01_9F:: ; heuristic: string; C0
Data_097_4FAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "TidalBell.", $F7
    db $F0

Message_01_A0:: ; heuristic: string; C0
Data_097_4FC6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " I", $42, "e been a", $F1
    db "burden to you, but", $FA, $F7
    db $EF, $EE, "I'll be fine now.", $EF, $EE, "I know what to do.", $FA, $F7
    db $EF, $EE, "I will rule with", $EF, $EE, "confidence.", $FA, $F7
    db $EF, $EE, "You will always be", $EF, $EE, "welcome with us!", $F7
    db $F0

Message_01_A1:: ; heuristic: string; C0
Data_097_505D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A voice echoed", $F1
    db "from nowhere", $A4, $F7
    db $F0

Message_01_A2:: ; heuristic: string; C0
Data_097_507B:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Wa-hey!", $F1
    db "Can you hear me?", $FA, $F7
    db $EF, $EE, "I felt an odd", $EF, $EE, "power stirring.", $FA, $F7
    db $EF, $EE, "You found a plug", $EF, $EE, "for the Navel!", $FA, $F7
    db $EF, $EE, "I'll bring you", $EF, $EE, "back! Don't move!", $F7
    db $F0

Message_01_A3:: ; heuristic: string; C0
Data_097_5102:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King caught", $F1
    db "the thieves!", $F7
    db $F0

Message_01_A4:: ; heuristic: string; C0
Data_097_5123:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The last king", $F1
    db "was a great man.", $FA, $F7
    db $EF, $EE, "Our King takes", $EF, $EE, "after him!", $F7
    db $F0

Message_01_A5:: ; heuristic: string; C0
Data_097_5164:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We recovered", $F1
    db "everything that", $FA, $F7
    db $EF, $EE, "was taken from us.", $EF, $EE, $F7
    db $F0

Message_01_A6:: ; heuristic: string; C0
Data_097_519D:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The circus has", $F1
    db "moved onto the", $FA, $F7
    db $EF, $EE, "town, and they got", $EF, $EE, "there safely.", $F7
    db $F0

Message_01_A7:: ; heuristic: string; C0
Data_097_51E4:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " His Majesty's", $F1
    db "popularity has", $FA, $F7
    db $EF, $EE, "been growing like", $EF, $EE, "wildfire.", $FA, $F7
    db $EF, $EE, "So much for idle", $EF, $EE, "rumors.", $F7
    db $F0

Message_01_A8:: ; heuristic: string; C0
Data_097_5241:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Making a hideout", $F1
    db "in Mirage Lake", $A4, $FA, $F7
    db $EF, $EE, "No wonder they", $EF, $EE, "avoided detection!", $F7
    db $F0

Message_01_A9:: ; heuristic: string; C0
Data_097_528C:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " They let us out", $F1
    db "when they realized", $FA, $F7
    db $EF, $EE, "that we were also", $EF, $EE, "victims like them.", $FA, $F7
    db $EF, $EE, "Indeed, it was a", $EF, $EE, "double whammy!", $F7
    db $F0

Message_01_AA:: ; heuristic: string; C0
Data_097_5300:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Come back and", $F1
    db "join the troupe!", $FA, $F7
    db $EF, $EE, "You'll become a", $EF, $EE, "legendary tamer!", $F7
    db $F0

Message_01_AB:: ; heuristic: string; C0
Data_097_5347:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The troupe'll", $F1
    db "reform!", $FA, $F7
    db $EF, $EE, "We'll recruit new", $EF, $EE, "members, watch!", $F7
    db $F0

Message_01_AC:: ; heuristic: string; C0
Data_097_5385:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We're more", $F1
    db "vigilant now!", $FA, $F7
    db $EF, $EE, "No thieves will", $EF, $EE, "succeed again!", $F7
    db $F0

Message_01_AD:: ; heuristic: string; C0
Data_097_53C4:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I will do my", $F1
    db "best to help make", $FA, $F7
    db $EF, $EE, "the Kingdom a", $EF, $EE, "better place.", $F7
    db $F0

Message_01_AE:: ; heuristic: string; C0
Data_097_5407:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome, our", $F1
    db "honored guests!", $FA, $F7
    db $EF, $EE, "The King is eager", $EF, $EE, "to see you!", $F7
    db $F0

Message_01_AF:: ; heuristic: string; C0
Data_097_544A:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Mirage Lake is a", $F1
    db "mystical place", $FA, $F7
    db $EF, $EE, "that can be seen,", $EF, $EE, "but never reached.", $FA, $F7
    db $EF, $EE, "It's famous as a", $EF, $EE, "haven for Beavern.", $F7
    db $F0

Message_01_B0:: ; heuristic: string; C0
Data_097_54BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Ah, good of", $F1
    db "you to visit!", $FA, $F7
    db $EF, $EE, "Our people are", $EF, $EE, "living in peace", $FA, $F7
    db $EF, $EE, "again, much thanks", $EF, $EE, "to you!", $F7
    db $F0

Message_01_B1:: ; heuristic: string; C0
Data_097_5522:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The dungeon is", $F1
    db "full of thieves!", $F7
    db $F0

Message_01_B2:: ; heuristic: string; C0
Data_097_5546:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Cooh, our home", $F1
    db "come back to us!", $F7
    db $F0

Message_01_B3:: ; heuristic: string; C0
Data_097_556A:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Cooh! Thieves", $F1
    db "are gone!", $FA, $F7
    db $EF, $EE, "No more worries!", $EF, $EE, "Cooqueeh!", $F7
    db $F0

Message_01_B4:: ; heuristic: string; C0
Data_097_55A5:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Cooh! This bed", $F1
    db "perfect for sleep!", $F7
    db $F0

Message_01_B5:: ; heuristic: string; C0
Data_097_55CB:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Kyooh! Swimming", $F1
    db "in a desert", $A4, $FA, $F7
    db $EF, $EE, "This is luxury!", $EF, $EE, "No doubt!", $F7
    db $F0

Message_01_B6:: ; heuristic: string; C0
Data_097_560A:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Kyukyooh! You", $F1
    db "are good human.", $FA, $F7
    db $EF, $EE, "I respect you now!", $EF, $EE, $F7
    db $F0

Message_01_B7:: ; heuristic: string; C0
Data_097_5644:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Cooh, I heard", $F1
    db "from others held", $FA, $F7
    db $EF, $EE, "captive by the", $EF, $EE, "thieves.", $FA, $F7
    db $EF, $EE, "You beat their", $EF, $EE, "boss!", $FA, $F7
    db $EF, $EE, "I see how you beat", $EF, $EE, "me now!", $FA, $F7
    db $EF, $EE, "Let me join your", $EF, $EE, "party!"
    db $FF, $F0

Message_01_B8:: ; heuristic: string; C0
Data_097_56D7:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We are partners,", $F1
    db "and good ones too!", $F7
    db $F0

Message_01_B9:: ; heuristic: string; C0
Data_097_56FF:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "But you have no", $F1
    db "room for me", $A4, $F7
    db $F0

Message_01_BA:: ; heuristic: string; C0
Data_097_5721:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Tch, I think", $F1
    db "I can help you", $A4, $F7
    db $F0

Message_01_BB:: ; heuristic: string; C0
Data_097_5742:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to our", $F1
    db "inn!", $F7
    db $F0

Message_01_BC:: ; heuristic: string; C0
Data_097_575A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "Thieves have", $EF, $EE, "emptied it", $A4, $F7
    db $F0

Message_01_BD:: ; heuristic: string; C0
Data_097_5797:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was full of", $EF, $EE, "wood chips.", $F7
    db $F0

Message_01_BE:: ; heuristic: string; C0
Data_097_57D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "There was a long,", $EF, $EE, "thin cloth.", $F7
    db $F0

Message_01_BF:: ; heuristic: string; C0
Data_097_580B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "The prisoners", $95, $EF, $EE, "things were there.", $F7
    db $F0

Message_01_C0:: ; heuristic: string; C0
Data_097_584B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "But it was empty", $A4, $EF, $EE, $F7
    db $F0

Message_01_C1:: ; heuristic: string; C0
Data_097_5882:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is a great", $F1
    db "spot to raise a", $FA, $F7
    db $EF, $EE, "monster's egg.", $EF, $EE, "Eggs are supposed", $FA, $F7
    db $EF, $EE, "to be hatched at", $EF, $EE, "the Starry Shrine,", $FA, $F7
    db $EF, $EE, "but they won't", $EF, $EE, "notice if we hatch", $FA, $F7
    db $EF, $EE, "one here.", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Have you ever", $F1
    db "found a Dream Egg?"
    db $FF, $F0

Message_01_D1:: ; heuristic: string; C0
Data_097_594B:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Put the Dream", $F1
    db "Egg on the hay.", $FA, $F7
    db $EF, $EE, "To raise it, give", $EF, $EE, "it items.", $FA, $F7
    db $EF, $EE, "An Herb will raise", $EF, $EE, "HP, for example.", $FA, $F7
    db $EF, $EE, "To make the egg", $EF, $EE, "hatch, it needs", $FA, $F7
    db $EF, $EE, "you to talk to", $EF, $EE, "many people.", $FA, $F7
    db $EF, $EE, "If you're lucky,", $EF, $EE, "you may get a", $FA, $F7
    db $EF, $EE, "powerful monster", $EF, $EE, "to hatch.", $F7
    db $F0

Message_01_D2:: ; heuristic: string; C0
Data_097_5A3A:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This talk is too", $F1
    db "early for you.", $F7
    db $F0

Message_01_D3:: ; heuristic: string; C0
Data_097_5A5E:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you ever", $F1
    db "found a Dream Egg?"
    db $FF, $F0

Message_01_D4:: ; heuristic: string; C0
Data_097_5A83:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're the child", $F1
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

Message_01_D5:: ; heuristic: string; C0
Data_097_5BBE:: ; address name
    db $F0

; string-pointer table for message bank $2A, strings from $95 up (index minus $95) (E-0080)
; address loaded by BeginStringDisplay_Bank2A_Overflow, CopyStringToBuffer_Bank2A_Overflow
MessageStrings_Bank2A_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_097_5BBF:: ; address name
    dw Data_097_5BC1

Data_097_5BC1:: ; heuristic: target of a monotone pointer table; C0
    dw Message_02_95
    dw Message_02_96
    dw Message_02_97
    dw Message_02_98
    dw Message_02_99
    dw Message_02_9A
    dw Message_02_9B
    dw Message_02_9C
    dw Message_02_9D
    dw Message_02_9E
    dw Message_02_9F
    dw Message_02_A0
    dw Message_02_A1
    dw Message_02_A2
    dw Message_02_A3
    dw Message_02_A4
    dw Message_02_A5
    dw Message_02_A6
    dw Message_02_A7
    dw Message_02_A8
    dw Message_02_A9
    dw Message_02_AA
    dw Message_02_AB
    dw Message_02_AC
    dw Message_02_AD
    dw Message_02_AE
    dw Message_02_AF
    dw Message_02_B0
    dw Message_02_B1
    dw Message_02_B2
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_B3
    dw Message_02_DD
    dw Message_02_DE
    dw Message_02_DE
    dw Message_02_DE
    dw Message_02_DE
    dw Message_02_DE
    dw Message_02_DE
    dw Message_02_DE
    dw Message_02_DE
    dw Message_02_DE
    dw Message_02_E7
    dw Message_02_E7
    dw Message_02_E7
    dw Message_02_EA
    dw Message_02_EA
    dw Message_02_EA
    dw Message_02_ED
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE
    dw Message_02_EE

Message_02_95:: ; heuristic: string; C0
Data_097_5C97:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In an Arena", $F1
    db "battle, you can't", $FA, $F7
    db $EF, $EE, "command your", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "You have to leave", $EF, $EE, "it up to them.", $FA, $F7
    db $EF, $EE, "What kinds of", $EF, $EE, "personalities they", $FA, $F7
    db $EF, $EE, "have will decide", $EF, $EE, "how they act.", $F7
    db $F0

Message_02_96:: ; heuristic: string; C0
Data_097_5D40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "the crowd's trash.", $F7
    db $F0

Message_02_97:: ; heuristic: string; C0
Data_097_5D83:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to my", $F1
    db "Key Shop!", $FA, $F7
    db $EF, $EE, "I appraise and", $EF, $EE, "identify keys!", $FA, $F7
    db $EF, $EE, "An unidentified", $EF, $EE, "key can't be used!", $FA, $F7
    db $EF, $EE, "Should I appraise", $EF, $EE, "your keys?", $F0

Message_02_98:: ; heuristic: string; C0
Data_097_5E07:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to my", $F1
    db "Key Shop!", $FA, $F7
    db $EF, $EE, "Should I appraise", $EF, $EE, "your keys?", $F0

Message_02_99:: ; heuristic: string; C0
Data_097_5E43:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm apprenticing", $F1
    db "under the boss.", $FA, $F7
    db $EF, $EE, "He told me that", $EF, $EE, "the name of a key", $FA, $F7
    db $EF, $EE, "hints at its", $EF, $EE, "destination.", $F7
    db $F0

Message_02_9A:: ; heuristic: string; C0
Data_097_5EAB:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Day after day,", $F1
    db "I examine keys.", $FA, $F7
    db $EF, $EE, "But I'm nothing", $EF, $EE, "compared to the", $FA, $F7
    db $EF, $EE, "boss yet.", $EF, $EE, $F7
    db $F0

Message_02_9B:: ; heuristic: string; C0
Data_097_5F00:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I found a key in", $F1
    db "another world, so", $FA, $F7
    db $EF, $EE, "I'm having it", $EF, $EE, "appraised.", $FA, $F7
    db $EF, $EE, "I hope it leads to", $EF, $EE, "a world with some", $FA, $F7
    db $EF, $EE, "monsters I", $42, "e not", $EF, $EE, "yet seen.", $F7
    db $F0

Message_02_9C:: ; heuristic: string; C0
Data_097_5F8B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "It greedily sucked", $EF, $EE, "air into its fire.", $F7
    db $F0

Message_02_9D:: ; heuristic: string; C0
Data_097_5FCF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was full of", $EF, $EE, "jet-black coal.", $F7
    db $F0

Message_02_9E:: ; heuristic: string; C0
Data_097_600C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "This time, you'll", $FA, $F7
    db $EF, $EE, "have to find the", $EF, $EE, "key first, warooh.", $FA, $F7
    db $EF, $EE, "The key, it should", $EF, $EE, "be in GreatLog.", $FA, $F7
    db $EF, $EE, "I think it is the", $EF, $EE, "PirateKey.", $FA, $F7
    db $EF, $EE, "Don't you forget", $EF, $EE, "it, warooh.", $F7
    db $F0

Message_02_9F:: ; heuristic: string; C0
Data_097_60C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "hurry.", $FA, $F7
    db $EF, $EE, "You need to gather", $EF, $EE, "more energy.", $F7
    db $F0

Message_02_A0:: ; heuristic: string; C0
Data_097_60FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "you", $42, "e gathered", $FA, $F7
    db $EF, $EE, "enough energy for", $EF, $EE, "just one person.", $FA, $F7
    db $EF, $EE, "I need more energy", $EF, $EE, "still, hurry!", $F7
    db $F0

Message_02_A1:: ; heuristic: string; C0
Data_097_616C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey, I", $F1
    db "have enough energy", $FA, $F7
    db $EF, $EE, "for two people.", $EF, $EE, "But I need more.", $FA, $F7
    db $EF, $EE, "Just a bit more,", $EF, $EE, "and I'll be ready.", $F7
    db $F0

Message_02_A2:: ; heuristic: string; C0
Data_097_61E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey.", $F1
    db "I need you to go", $FA, $F7
    db $EF, $EE, "to another world", $EF, $EE, "to find a plug.", $FA, $F7
    db $EF, $EE, "But I", $42, "e no power", $EF, $EE, "to make a key", $A4, $FA, $F7
    db $EF, $EE, "That power is from", $EF, $EE, "GreatLog's tree.", $FA, $F7
    db $EF, $EE, "It is energy made", $EF, $EE, "by the bond tying", $FA, $F7
    db $EF, $EE, "people and their", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "Help people bond", $EF, $EE, "with monsters, and", $FA, $F7
    db $EF, $EE, "GreatLog's power", $EF, $EE, "will be boosted.", $F7
    db $F0

Message_02_A3:: ; heuristic: string; C0
Data_097_6308:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "There is enough", $EF, $EE, "power for me to", $FA, $F7
    db $EF, $EE, "make a Magic Key,", $EF, $EE, "yes, warooh!", $FA, $F7
    db $EF, $EE, "Good job, ", $F9, "0!", $EF, $EE, "Just wait now!", $FA, $F7
    db $EF, $EE, "I'll make the key", $EF, $EE, "right away.", $F7
    db $F0

Message_02_A4:: ; heuristic: string; C0
Data_097_63B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0 you're slow!", $FA, $F7
    db $EF, $EE, "Kameha already", $EF, $EE, "came by today with", $FA, $F7
    db $EF, $EE, "the PirateKey,", $EF, $EE, "warooh.", $FA, $F7
    db $EF, $EE, "He got it from the", $EF, $EE, "King by whining.", $FA, $F7
    db $EF, $EE, "You"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " better follow", $EF, $EE, "him to the other", $FA, $F7
    db $EF, $EE, "world right away.", $EF, $EE, "Don't be late!", $FA, $F7
    db $EF, $EE, "Also, Kameha isn't", $EF, $EE, "a bad guy, warooh.", $FA, $F7
    db $EF, $EE, "If you see him", $EF, $EE, "over there, help", $FA, $F7
    db $EF, $EE, "him if he needs", $EF, $EE, "it.", $FA, $F7
    db $EF, $EE, "And, don't forget.", $EF, $EE, "You can cross", $FA, $F7
    db $EF, $EE, "water by using the", $EF, $EE, "TidalBell.", $FA, $F7
    db $EF, $EE, "Bring me back some", $EF, $EE, "good news, warooh!", $F7
    db $F0

Message_02_A5:: ; heuristic: string; C0
Data_097_655C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "PirateKey."
    db $E5, $58, $F7, $E9, $FF, $F0

Message_02_A6:: ; heuristic: string; C0
Data_097_657C:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Putting up a", $F1
    db "bridge is easy!", $F7
    db $F0

Message_02_A7:: ; heuristic: string; C0
Data_097_659D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "You did it, ", $F9, "0!", $FA, $F7
    db $EF, $EE, "GreatLog's power", $EF, $EE, "will heal you!", $F7
    db $F0

Message_02_A8:: ; heuristic: string; C0
Data_097_65E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " There,", $F1
    db "your party's fine!", $FA, $F7
    db $EF, $EE, "So, the new plug", $EF, $EE, "for Log's Navel?", $F7
    db $F0

Message_02_A9:: ; heuristic: string; C0
Data_097_662C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "So, this is it?", $FA, $F7
    db $EF, $EE, "This is the", $EF, $EE, "HarMirror, warooh?", $FA, $F7
    db $EF, $EE, "I can feel an odd", $EF, $EE, "power from it!", $F7
    db $F0

Message_02_AA:: ; heuristic: string; C0
Data_097_6697:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "That's it!", $FA, $F7
    db $EF, $EE, "GreatLog is saved!", $EF, $EE, "Good, now", $A4, " Warooh?", $F7
    db $F0

Message_02_AB:: ; heuristic: string; C0
Data_097_66DE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "No good, no good!", $FA, $F7
    db $EF, $EE, "I have to plug the", $EF, $EE, "Navel again!", $F7
    db $F0

Message_02_AC:: ; heuristic: string; C0
Data_097_6727:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey", $A4, $F1
    db "That was no good.", $FA, $F7
    db $EF, $EE, "But HarMirror does", $EF, $EE, "have magic in it.", $FA, $F7
    db $EF, $EE, "Give me your hand,", $EF, $EE, $F9, "0. Wa-hey!", $F7
    db $F0

Message_02_AD:: ; heuristic: string; C0
Data_097_6798:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Stop that!", $FA, $F7
    db $EF, $EE, "Why do you look so", $EF, $EE, "unhappy at me?", $FA, $F7
    db $EF, $EE, "A hero doesn't walk", $EF, $EE, "from someone in", $FA, $F7
    db $EF, $EE, "trouble, you ought", $EF, $EE, "to know that!", $FA, $F7
    db $EF, $EE, "Come on, give me a", $EF, $EE, "big smile, warooh!"
    db $FF, $F0

Message_02_AE:: ; heuristic: string; C0
Data_097_6852:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Listen.", $F1
    db "I feel a strange", $FA, $F7
    db $EF, $EE, "power in another", $EF, $EE, "world, warooh.", $FA, $F7
    db $EF, $EE, "It has to be a", $EF, $EE, "plug, I can tell!", $FA, $F7
    db $EF, $EE, "Wa-hey, gather", $EF, $EE, "more of the energy", $FA, $F7
    db $EF, $EE, "from GreatLog's", $EF, $EE, "tree, I need it.", $F7
    db $F0

Message_02_AF:: ; heuristic: string; C0
Data_097_6909:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db $F9, "0?", $FA, $F7
    db $EF, $EE, "Angry still with", $EF, $EE, "me, warooh?", $FA, $F7
    db $EF, $EE, "Wasted energy,", $EF, $EE, "that is!", $FA, $F7
    db $EF, $EE, "Come on, cheer up", $EF, $EE, "and smile, wa-hey!"
    db $FF, $F0

Message_02_B0:: ; heuristic: string; C0
Data_097_6986:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was full of", $EF, $EE, "junk.", $F7
    db $F0

Message_02_B1:: ; heuristic: string; C0
Data_097_69BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "It was still warm", $EF, $EE, "from cooking.", $F7
    db $F0

Message_02_B2:: ; heuristic: string; C0
Data_097_69F9:: ; address name
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Come back if you", $F1
    db "need to check up", $FA, $F7
    db $EF, $EE, "on your monster", $EF, $EE, "Catalog.", $F7
    db $F0

Message_02_B3:: ; heuristic: string; C0
Data_097_6A3C:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " GreatLog's", $F1
    db "Starry Shrine", $FA, $F7
    db $EF, $EE, "wasn't in use for", $EF, $EE, "a long time.", $FA, $F7
    db $EF, $EE, "But research into", $EF, $EE, "breeding shed new", $FA, $F7
    db $EF, $EE, "light on its great", $EF, $EE, "potential.", $FA, $F7
    db $EF, $EE, "Now, the Shrine is", $EF, $EE, "considered to be", $FA, $F7
    db $EF, $EE, "an indispensable", $EF, $EE, "place for masters.", $F7
    db $F0

Message_02_DD:: ; heuristic: string; C0
Data_097_6B14:: ; address name
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Parents pass on", $F1
    db "abilities to their", $FA, $F7
    db $EF, $EE, "children, who in", $EF, $EE, "turn pass on their", $FA, $F7
    db $EF, $EE, "abilities to their", $EF, $EE, "own offspring.", $FA, $F7
    db $EF, $EE, "Saying goodbye is", $EF, $EE, "never easy, but", $FA, $F7
    db $EF, $EE, "that is the cycle", $EF, $EE, "of life.", $F7
    db $F0

Message_02_DE:: ; heuristic: string; C0
Data_097_6BCE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "IceKey."
    db $E5, $58, $F7, $E9, $FF, $F0

Message_02_E7:: ; heuristic: string; C0
Data_097_6BEB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey?", $F1
    db "So, this is it?", $FA, $F7
    db $EF, $EE, "This is the", $EF, $EE, "SkyShield, warooh?", $FA, $F7
    db $EF, $EE, "It gives off more", $EF, $EE, "magical power than", $FA, $F7
    db $EF, $EE, "the other things", $EF, $EE, "you", $42, "e brought me.", $FA, $F7
    db $EF, $EE, "We'll see if it", $EF, $EE, "works, warooh!", $F7
    db $F0

Message_02_EA:: ; heuristic: string; C0
Data_097_6CA3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey", $A4, $F1
    db "That was no good.", $FA, $F7
    db $EF, $EE, "But this too has", $EF, $EE, "magic in it.", $FA, $F7
    db $EF, $EE, "Give me your hand,", $EF, $EE, $F9, "0. Wa-hey!", $F7
    db $F0

Message_02_ED:: ; heuristic: string; C0
Data_097_6D0D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Stop that!", $FA, $F7
    db $EF, $EE, "Why do you look so", $EF, $EE, "disgusted with me?", $FA, $F7
    db $EF, $EE, "People can do", $EF, $EE, "anything if they", $FA, $F7
    db $EF, $EE, "buckle down and", $EF, $EE, "work, warooh!", $FA, $F7
    db $EF, $EE, "Come on, give me a", $EF, $EE, "big smile, ", $F9, "0!"
    db $FF, $F0

Message_02_EE:: ; heuristic: string; C0
Data_097_6DC0:: ; address name
    db $F0

; string-pointer table for message bank $83, strings from $C7 up (index minus $C7) (E-0080)
; address loaded by BeginStringDisplay_Bank83_Overflow, CopyStringToBuffer_Bank83_Overflow
MessageStrings_Bank83_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_097_6DC1:: ; address name
    dw Data_097_6DC3

Data_097_6DC3:: ; heuristic: target of a monotone pointer table; C0
    dw Data_097_6E35
    dw Data_097_6ECB
    dw Data_097_6F35
    dw Data_097_6F7B
    dw Data_097_6FC7
    dw Data_097_7012
    dw Data_097_7052
    dw Data_097_70BB
    dw Data_097_70FB
    dw Data_097_7162
    dw Data_097_717E
    dw Data_097_71C6
    dw Data_097_7232
    dw Data_097_7297
    dw Data_097_7305
    dw Data_097_7353
    dw Data_097_739A
    dw Data_097_7404
    dw Data_097_7471
    dw Data_097_74CD
    dw Data_097_753A
    dw Data_097_75C9
    dw Data_097_762C
    dw Data_097_7674
    dw Data_097_770C
    dw Data_097_7753
    dw Data_097_7791
    dw Data_097_77EA
    dw Data_097_782D
    dw Data_097_78A8
    dw Data_097_791A
    dw Data_097_7959
    dw Data_097_799E
    dw Data_097_79E2
    dw Data_097_7A27
    dw Data_097_7A65
    dw Data_097_7AAE
    dw Data_097_7AF8
    dw Data_097_7B3F
    dw Data_097_7B8D
    dw Data_097_7BBD
    dw Data_097_7C2C
    dw Data_097_7C6E
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC

Data_097_6E35:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The skills that", $F1
    db "are learned by", $FA, $F7
    db $EF, $EE, "monsters depends", $EF, $EE, "on their families.", $FA, $F7
    db $EF, $EE, "Through breeding,", $EF, $EE, "monsters will", $FA, $F7
    db $EF, $EE, "learn a greater", $EF, $EE, "variety of skills.", $F7
    db $F0

Data_097_6ECB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How quickly the", $F1
    db "different stats", $FA, $F7
    db $EF, $EE, "rise varies by the", $EF, $EE, "monster family.", $FA, $F7
    db $EF, $EE, "I bet you didn't", $EF, $EE, "know that.", $F7
    db $F0

Data_097_6F35:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wish I could", $F1
    db "play outside", $A4, $FA, $F7
    db $EF, $EE, "But Mom won't let", $EF, $EE, "me go anywhere", $A4, $F7
    db $F0

Data_097_6F7B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Aren't you lonely", $F1
    db "traveling alone?", $FA, $F7
    db $EF, $EE, "Oh, but then you're", $EF, $EE, "with monsters.", $F7
    db $F0

Data_097_6FC7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wish I had", $F1
    db "monster friends.", $FA, $F7
    db $EF, $EE, "They could help me", $EF, $EE, "with my homework.", $F7
    db $F0

Data_097_7012:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Why are you", $F1
    db "consorting with", $FA, $F7
    db $EF, $EE, "monsters?", $EF, $EE, "I don't trust you!", $F7
    db $F0

Data_097_7052:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When I grow up,", $F1
    db "I'm going to take", $FA, $F7
    db $EF, $EE, "over my dad's job", $EF, $EE, "as a dealer.", $FA, $F7
    db $EF, $EE, "He travels from", $EF, $EE, "town to town!", $F7
    db $F0

Data_097_70BB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " D-don't t-try to", $F1
    db "scare me.", $FA, $F7
    db $EF, $EE, "I", $A4, " I'm not scared", $EF, $EE, "of monsters!", $F7
    db $F0

Data_097_70FB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If we could fly", $F1
    db "like birds", $A4, $FA, $F7
    db $EF, $EE, "We"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " be able to go", $EF, $EE, "anywhere.", $FA, $F7
    db $EF, $EE, "Now that's freedom.", $EF, $EE, "Don't you think?", $F7
    db $F0

Data_097_7162:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Would you be my", $F1
    db "friend?", $F7
    db $F0

Data_097_717E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't goof off!", $F1
    db "Do your homework!", $FA, $F7
    db $EF, $EE, "My mom says that", $EF, $EE, "all the time.", $F7
    db $F0

Data_097_71C6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Mom's going to", $F1
    db "have a baby soon.", $FA, $F7
    db $EF, $EE, "I wonder if it", $EF, $EE, "will be a boy or", $FA, $F7
    db $EF, $EE, "girl. It doesn't", $EF, $EE, "matter, though!", $F7
    db $F0

Data_097_7232:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A bard, that's", $F1
    db "what I'm gonna be.", $FA, $F7
    db $EF, $EE, "Gonna travel and", $EF, $EE, "sing about it.", $FA, $F7
    db $EF, $EE, "I practice!", $EF, $EE, "La"
    db $9D, $90, $2F, $24, $2F, $24, $2F, $24, $9D, $B5, $F7, $F0

Data_097_7297:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " love to ride", $F1
    db "through forests on", $FA, $F7
    db $EF, $EE, "a Unicorn.", $EF, $EE, "That's my dream.", $FA, $F7
    db $EF, $EE, "If it comes true,", $EF, $EE, "I'll let you ride!", $F7
    db $F0

Data_097_7305:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I hate carrots!", $F1
    db "It tastes blecch!", $FA, $F7
    db $EF, $EE, "I bet a DanceVegi", $EF, $EE, "tastes awful too!", $F7
    db $F0

Data_097_7353:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lipsy always", $F1
    db "wants to kiss.", $FA, $F7
    db $EF, $EE, "Mommy's like that", $EF, $EE, "after some cider.", $F7
    db $F0

Data_097_739A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm going to be", $F1
    db "like my dad and", $FA, $F7
    db $EF, $EE, "become a soldier.", $EF, $EE, "I'll get to wear", $FA, $F7
    db $EF, $EE, "the awesome armor", $EF, $EE, "they have.", $F7
    db $F0

Data_097_7404:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you think it's", $F1
    db "impressive to have", $FA, $F7
    db $EF, $EE, "monsters around?", $EF, $EE, "I'm not jealous.", $FA, $F7
    db $EF, $EE, "No, really, I'm", $EF, $EE, "not envious!", $F7
    db $F0

Data_097_7471:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm your master", $F1
    db "from now on!", $FA, $F7
    db $EF, $EE, "Your first order", $EF, $EE, "is", $A4, $FA, $F7
    db $EF, $EE, "Wait! Listen!", $EF, $EE, "Will you listen?", $F7
    db $F0

Data_097_74CD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You act big for", $F1
    db "an outsider!", $FA, $F7
    db $EF, $EE, "Don't think you", $EF, $EE, "scare me with your", $FA, $F7
    db $EF, $EE, "monsters. I", $A4, " I'm", $EF, $EE, "not scared a bit!", $F7
    db $F0

Data_097_753A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monsters get", $F1
    db "discouraged if you", $FA, $F7
    db $EF, $EE, "order them around", $EF, $EE, "all the time.", $FA, $F7
    db $EF, $EE, "You should assign", $EF, $EE, "them a plan, and", $FA, $F7
    db $EF, $EE, "let them do what", $EF, $EE, "they want.", $F7
    db $F0

Data_097_75C9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A bred monster", $F1
    db "learns the skills", $FA, $F7
    db $EF, $EE, "that its parents", $EF, $EE, "knew.", $FA, $F7
    db $EF, $EE, "So, it will learn", $EF, $EE, "many skills.", $F7
    db $F0

Data_097_762C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Skills come in", $F1
    db "the three groups", $FA, $F7
    db $EF, $EE, "of attack, support", $EF, $EE, "and defense.", $F7
    db $F0

Data_097_7674:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You'll find it", $F1
    db "easier to raise", $FA, $F7
    db $EF, $EE, "monsters if you", $EF, $EE, "assign them roles.", $FA, $F7
    db $EF, $EE, "On the other hand,", $EF, $EE, "you could raise", $FA, $F7
    db $EF, $EE, "one like a hero-", $EF, $EE, "useful all around.", $F7
    db $F0

Data_097_770C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e never met", $F1
    db "anyone like you.", $FA, $F7
    db $EF, $EE, "Your quiet way is", $EF, $EE, "just so cool!", $F7
    db $F0

Data_097_7753:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You came from", $F1
    db "GreatLog?", $FA, $F7
    db $EF, $EE, "I", $42, "e never heard", $EF, $EE, "of it, sorry.", $F7
    db $F0

Data_097_7791:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, you're a", $F1
    db "traveler?", $FA, $F7
    db $EF, $EE, "From GreatLog, you", $EF, $EE, "say.", $FA, $F7
    db $EF, $EE, "I", $42, "e been to", $EF, $EE, "GreatTree, myself.", $F7
    db $F0

Data_097_77EA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e heard tales", $F1
    db "that GreatLog is a", $FA, $F7
    db $EF, $EE, "hollowed out palm", $EF, $EE, "tree.", $F7
    db $F0

Data_097_782D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're from", $F1
    db "GreatLog?", $F7
    db $F0, "Isn't that where", $F1
    db "the prince is a", $FA, $F7
    db $EF, $EE, "little terror?", $EF, $EE, "Kameha, right?", $FA, $F7
    db $EF, $EE, "Royalty can be so", $EF, $EE, "selfish.", $F7
    db $F0

Data_097_78A8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I understand", $F1
    db "monster masters", $FA, $F7
    db $EF, $EE, "flock to the", $EF, $EE, "kingdom of", $FA, $F7
    db $EF, $EE, "GreatLog.", $EF, $EE, $FA, $F7
    db $EF, $EE, "Oh? You're from", $EF, $EE, "GreatLog, you say?", $F7
    db $F0

Data_097_791A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wander the", $F1
    db "other worlds", $A4, $FA, $F7
    db $EF, $EE, "I'm sure we will", $EF, $EE, "meet again.", $F7
    db $F0

Data_097_7959:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wander the", $F1
    db "other worlds", $A4, $FA, $F7
    db $EF, $EE, "I chronicle what", $EF, $EE, "I", $42, "e experienced.", $F7
    db $F0

Data_097_799E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wander the", $F1
    db "other worlds", $A4, $FA, $F7
    db $EF, $EE, "I'll see more, as", $EF, $EE, "I", $42, "e done today.", $F7
    db $F0

Data_097_79E2:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wander the", $F1
    db "other worlds", $A4, $FA, $F7
    db $EF, $EE, "I'll soon leave", $EF, $EE, "for another world.", $F7
    db $F0

Data_097_7A27:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wander the", $F1
    db "other worlds", $A4, $FA, $F7
    db $EF, $EE, "We may have", $EF, $EE, "crossed paths", $A4, $F7
    db $F0

Data_097_7A65:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I study monsters", $F1
    db "in other worlds.", $FA, $F7
    db $EF, $EE, "I'm intrigued by", $EF, $EE, "your monsters.", $F7
    db $F0

Data_097_7AAE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I study monsters", $F1
    db "in other worlds.", $FA, $F7
    db $EF, $EE, "I think I'm done", $EF, $EE, "with this area.", $F7
    db $F0

Data_097_7AF8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I study monsters", $F1
    db "in other worlds.", $FA, $F7
    db $EF, $EE, "What monsters", $EF, $EE, "await me next?", $F7
    db $F0

Data_097_7B3F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I study monsters", $F1
    db "in other worlds.", $FA, $F7
    db $EF, $EE, "Haven't I seen you", $EF, $EE, "elsewhere before?", $F7
    db $F0

Data_097_7B8D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $38, $30, $33, $2B, $A4, $F1, $FA, $F7, $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "That's my Terry", $EF, $EE, "impression. So?", $F7
    db $F0

Data_097_7BBD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I met this girl", $F1
    db "named Milayou.", $FA, $F7
    db $EF, $EE, "Hoo boy, she was", $EF, $EE, "some kind of cute.", $FA, $F7
    db $EF, $EE, "She'll become", $EF, $EE, "stunning for sure!", $F7
    db $F0

Data_097_7C2C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $3A, $2C, $36, $2B, $90, $1D, $28, $35, $35, $3C, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F1
    db "visit again.", $FA, $F7
    db $EF, $EE, "The girls come out", $EF, $EE, "to see him.", $F7
    db $F0

Data_097_7C6E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm going to", $F1
    db "marry Milayou.", $FA, $F7
    db $EF, $EE, "You bet I will!", $EF, $EE, "I said so!", $F7
    db $F0

Data_097_7CAC:: ; heuristic: target of a monotone pointer table; C0
    ds $354, $00
