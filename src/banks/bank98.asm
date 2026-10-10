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

; string-pointer table for message bank $2B, strings from $8A up (index minus $8A) (E-0080)
MessageStrings_Bank2B_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_098_4070:: ; address name
    dw Data_098_4072

Data_098_4072:: ; heuristic: target of a monotone pointer table; C0
    dw Data_098_4154
    dw Data_098_4255
    dw Data_098_4275
    dw Data_098_4302
    dw Data_098_4359
    dw Data_098_43E8
    dw Data_098_4454
    dw Data_098_449D
    dw Data_098_4526
    dw Data_098_4598
    dw Data_098_464F
    dw Data_098_4705
    dw Data_098_47C0
    dw Data_098_487A
    dw Data_098_489A
    dw Data_098_48E7
    dw Data_098_4948
    dw Data_098_4990
    dw Data_098_49F7
    dw Data_098_4A3A
    dw Data_098_4A7A
    dw Data_098_4B0A
    dw Data_098_4B9B
    dw Data_098_4BBF
    dw Data_098_4BE4
    dw Data_098_4C09
    dw Data_098_4C13
    dw Data_098_4D3E
    dw Data_098_4DCF
    dw Data_098_4E0A
    dw Data_098_4EA4
    dw Data_098_4F06
    dw Data_098_4F6C
    dw Data_098_4FD4
    dw Data_098_5035
    dw Data_098_50C6
    dw Data_098_5198
    dw Data_098_5208
    dw Data_098_52BF
    dw Data_098_52E1
    dw Data_098_5303
    dw Data_098_5322
    dw Data_098_5344
    dw Data_098_53D7
    dw Data_098_548F
    dw Data_098_55E9
    dw Data_098_560F
    dw Data_098_56A2
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D

Data_098_4154:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A woodsman came", $F1
    db "by a while back.", $FA, $F7
    db $EF, $EE, "He said something", $EF, $EE, "very disturbing.", $FA, $F7
    db $EF, $EE, "He was in the big", $EF, $EE, "forest, which is", $FA, $F7
    db $EF, $EE, "across the bridge", $EF, $EE, "south of town.", $FA, $F7
    db $EF, $EE, "He claims to have", $EF, $EE, "been chased by the", $FA, $F7
    db $EF, $EE, "ghost of a young", $EF, $EE, "woman.", $FA, $F7
    db $EF, $EE, "The forest looks", $EF, $EE, "ordinary, but", $A4, $F7
    db $F0

Data_098_4255:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello! How may I", $F1
    db "serve you?", $F7
    db $F0

Data_098_4275:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The lake is", $F1
    db "frozen, so I can't", $FA, $F7
    db $EF, $EE, "very well take my", $EF, $EE, "boat out.", $FA, $F7
    db $EF, $EE, "The north winds", $EF, $EE, "seem to be unduly", $FA, $F7
    db $EF, $EE, "harsh this year", $EF, $EE, "for some reason.", $F7
    db $F0

Data_098_4302:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is Westania", $F1
    db "Castle.", $FA, $F7
    db $EF, $EE, "Westania is the", $EF, $EE, "kingdom to the", $FA, $F7
    db $EF, $EE, "west of the lake.", $EF, $EE, $F7
    db $F0

Data_098_4359:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Nobody fails to", $F1
    db "be impressed when", $FA, $F7
    db $EF, $EE, "I breathe fire,", $EF, $EE, "and I mean nobody!", $FA, $F7
    db $EF, $EE, "I'm sure Lady Yuna", $EF, $EE, "will be delighted", $FA, $F7
    db $EF, $EE, "when she sees my", $EF, $EE, "act.", $F7
    db $F0

Data_098_43E8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e brought with", $F1
    db "me a necklace that", $FA, $F7
    db $EF, $EE, "is studded with", $EF, $EE, "jewels.", $FA, $F7
    db $EF, $EE, "Any woman would be", $EF, $EE, "delighted by it!", $F7
    db $F0

Data_098_4454:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When I balance", $F1
    db "on my ball, people", $FA, $F7
    db $EF, $EE, "simply go wild.", $EF, $EE, "Just watch me!", $F7
    db $F0

Data_098_449D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I hurl knives", $F1
    db "with incredible", $FA, $F7
    db $EF, $EE, "accuracy.", $EF, $EE, "I never miss!", $FA, $F7
    db $EF, $EE, "Even Lady Yuna", $EF, $EE, "will be surprised.", $FA, $F7
    db $EF, $EE, "That'll snap her", $EF, $EE, "out of her funk.", $F7
    db $F0

Data_098_4526:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Please, line up!", $F1
    db "And quit pushing!", $FA, $F7
    db $EF, $EE, "Everyone will get", $EF, $EE, "their turn.", $FA, $F7
    db $EF, $EE, $A4, "Sigh", $A4, " Everyone is", $EF, $EE, "after the reward", $A4, $F7
    db $F0

Data_098_4598:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " Lady Yuna", $A4, $F1
    db "To think that I", $FA, $F7
    db $EF, $EE, "won't get to see", $EF, $EE, "your smile again", $A4, $FA, $F7
    db $EF, $EE, "Oh, it's the end", $EF, $EE, "of the world! Huh?", $FA, $F7
    db $EF, $EE, "Gaaah! What are", $EF, $EE, "you doing here?", $FA, $F7
    db $EF, $EE, "You shouldn't be", $EF, $EE, "eavesdropping!", $F7
    db $F0

Data_098_464F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Come all who have", $EF, $EE, "the confidence to", $FA, $F7
    db $EF, $EE, "delight Lady Yuna", $EF, $EE, "out of depression.", $FA, $F7
    db $EF, $EE, "Anyone restoring", $EF, $EE, "joyous laughter to", $FA, $F7
    db $EF, $EE, "her will receive a", $EF, $EE, "generous reward.", $95, $F7
    db $F0

Data_098_4705:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Well, if", $F1
    db "it isn't ", $F9, "0!", $FA, $F7
    db $EF, $EE, "You managed to get", $EF, $EE, "out of the Castle,", $FA, $F7
    db $EF, $EE, "did you? You can", $EF, $EE, "thank me for it.", $FA, $F7
    db $EF, $EE, "I let you have the", $EF, $EE, "glory last time,", $FA, $F7
    db $EF, $EE, "but this time, it", $EF, $EE, "will be mine!", $F7
    db $F0

Data_098_47C0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's a mean old", $F1
    db "world out there.", $FA, $F7
    db $EF, $EE, "I", $42, "e heard there", $EF, $EE, "are even monsters", $FA, $F7
    db $EF, $EE, "in our midsts.", $EF, $EE, "It's frightening.", $FA, $F7
    db $EF, $EE, "You should record", $EF, $EE, "in your Journal", $FA, $F7
    db $EF, $EE, "whenever you do", $EF, $EE, "anything of note.", $F7
    db $F0

Data_098_487A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Castle is in", $F1
    db "an uproar.", $F7
    db $F0

Data_098_489A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna used", $F1
    db "to be very lively.", $FA, $F7
    db $EF, $EE, "It makes no sense,", $EF, $EE, "her depression.", $F7
    db $F0

Data_098_48E7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the east", $F1
    db "lives an old man", $FA, $F7
    db $EF, $EE, "who had tutored", $EF, $EE, "Lady Yuna.", $FA, $F7
    db $EF, $EE, "He knows about her", $EF, $EE, "the best.", $F7
    db $F0

Data_098_4948:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What happened to", $F1
    db "Lady Yuna?", $FA, $F7
    db $EF, $EE, "It's as if she is", $EF, $EE, "a soulless puppet", $A4, $F7
    db $F0

Data_098_4990:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Before, Lady", $F1
    db "Yuna would be up", $FA, $F7
    db $EF, $EE, "and out playing at", $EF, $EE, "sunrise.", $FA, $F7
    db $EF, $EE, "But now, she never", $EF, $EE, "ventures out", $A4, $F7
    db $F0

Data_098_49F7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This leads to", $F1
    db "Lady Yuna's room.", $FA, $F7
    db $EF, $EE, "You may not go", $EF, $EE, "beyond here.", $F7
    db $F0

Data_098_4A3A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're here to", $F1
    db "cheer Lady Yuna.", $FA, $F7
    db $EF, $EE, "Please go right", $EF, $EE, "through.", $F7
    db $F0

Data_098_4A7A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're here to", $F1
    db "cheer Lady Yuna.", $FA, $F7
    db $EF, $EE, "Oh? Your monsters", $EF, $EE, "are not healthy.", $FA, $F7
    db $EF, $EE, "That won't do. No,", $EF, $EE, "not at all.", $FA, $F7
    db $EF, $EE, "You'll have to", $EF, $EE, "leave, I'm afraid.", $F7
    db $F0

Data_098_4B0A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're here to", $F1
    db "cheer Lady Yuna.", $FA, $F7
    db $EF, $EE, "Oh? You haven't", $EF, $EE, "three monsters?", $FA, $F7
    db $EF, $EE, "Your show can't be", $EF, $EE, "very impressive.", $FA, $F7
    db $EF, $EE, "You'll have to", $EF, $EE, "leave, I'm afraid.", $F7
    db $F0

Data_098_4B9B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Enough", $A4, " Enough", $F1
    db "of that dancing!", $F7
    db $F0

Data_098_4BBF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I am the King.", $F1
    db "What is your act?", $F7
    db $F0

Data_098_4BE4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Magnificent!", $F1
    db "Don't you agree?", $F7
    db $F0

Data_098_4C09:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, $A4, $A4, $A4, $F1
    db $F7
    db $F0

Data_098_4C13:: ; heuristic: target of a monotone pointer table; C0
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

Data_098_4D3E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Many have tried", $F1
    db "to cheer Lady Yuna", $FA, $F7
    db $EF, $EE, "up to the way she", $EF, $EE, "was before.", $FA, $F7
    db $EF, $EE, "However, none have", $EF, $EE, "succeeded.", $FA, $F7
    db $EF, $EE, "Will we ever see", $EF, $EE, "her smile again?", $F7
    db $F0

Data_098_4DCF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the", $F1
    db "Castle of Estria,", $FA, $F7
    db $EF, $EE, "the eastern", $EF, $EE, "kingdom.", $F7
    db $F0

Data_098_4E0A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen came", $F1
    db "by a while ago, so", $FA, $F7
    db $EF, $EE, "I greeted her. But", $EF, $EE, "she said nothing", $FA, $F7
    db $EF, $EE, "and walked by", $EF, $EE, "without notice.", $FA, $F7
    db $EF, $EE, "She used to greet", $EF, $EE, "us warmly before", $A4, $F7
    db $F0

Data_098_4EA4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The spirit's", $F1
    db "spring has frozen.", $FA, $F7
    db $EF, $EE, "The lake is full", $EF, $EE, "of ice too.", $FA, $F7
    db $EF, $EE, "These are terrible", $EF, $EE, "omens", $A4, $F7
    db $F0

Data_098_4F06:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen's", $F1
    db "dreams come true.", $FA, $F7
    db $EF, $EE, "If she hadn't", $EF, $EE, "dreamed of this,", $FA, $F7
    db $EF, $EE, "we would", $42, "e fared", $EF, $EE, "much worse.", $F7
    db $F0

Data_098_4F6C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our Queen is a", $F1
    db "kind person who", $FA, $F7
    db $EF, $EE, "has a friendly", $EF, $EE, "word for everyone,", $FA, $F7
    db $EF, $EE, "but lately she", $EF, $EE, "looks grim", $A4, $F7
    db $F0

Data_098_4FD4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A teacher from", $F1
    db "the west lives", $FA, $F7
    db $EF, $EE, "over there.", $EF, $EE, "He once was a", $FA, $F7
    db $EF, $EE, "tutor to the west's", $EF, $EE, "princess.", $F7
    db $F0

Data_098_5035:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There is a", $F1
    db "spring in the far", $FA, $F7
    db $EF, $EE, "north that is home", $EF, $EE, "to a spirit.", $FA, $F7
    db $EF, $EE, "The spirit lends", $EF, $EE, "us the power to", $FA, $F7
    db $EF, $EE, "survive in these", $EF, $EE, "harsh conditions.", $F7
    db $F0

Data_098_50C6:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I heard this on", $F1
    db "the sly from my", $FA, $F7
    db $EF, $EE, "sister who works", $EF, $EE, "in the Castle.", $FA, $F7
    db $EF, $EE, "Queen Helen is", $EF, $EE, "very upset over", $FA, $F7
    db $EF, $EE, "ominous dreams.", $EF, $EE, "They must be bad", $FA, $F7
    db $EF, $EE, "to keep her from", $EF, $EE, "sleeping.", $FA, $F7
    db $EF, $EE, "That's why she", $EF, $EE, "seems so cranky", $A4, $F7
    db $F0

Data_098_5198:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Queen looks", $F1
    db "haggard recently.", $FA, $F7
    db $EF, $EE, "Lack of sleep must", $EF, $EE, "be very taxing.", $FA, $F7
    db $EF, $EE, "She has been", $EF, $EE, "rather irritable.", $F7
    db $F0

Data_098_5208:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Around these", $F1
    db "parts, there are", $FA, $F7
    db $EF, $EE, "times of perpetual", $EF, $EE, "days", $A4, " And nights", $A4, $FA, $F7
    db $EF, $EE, "It can be hard to", $EF, $EE, "sleep properly.", $FA, $F7
    db $EF, $EE, "I use a potion", $EF, $EE, "made by a scholar", $FA, $F7
    db $EF, $EE, "when I can't sleep.", $EF, $EE, "It works!", $F7
    db $F0

Data_098_52BF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is no place", $F1
    db "for a child!", $F7
    db $F0

Data_098_52E1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? An envoy", $F1
    db "from the spirit!", $F7
    db $F0

Data_098_5303:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I beg your", $F1
    db "pardon, please!", $F7
    db $F0

Data_098_5322:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello! What may", $F1
    db "I do for you?", $F7
    db $F0

Data_098_5344:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A botanist does", $F1
    db "live here", $A4, $FA, $F7
    db $EF, $EE, "But he's been gone", $EF, $EE, "for quite some", $FA, $F7
    db $EF, $EE, "time on a research", $EF, $EE, "trip of some sort.", $FA, $F7
    db $EF, $EE, "Who knows where he", $EF, $EE, "could be now.", $F7
    db $F0

Data_098_53D7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I retired as a", $F1
    db "teacher and came", $FA, $F7
    db $EF, $EE, "back home.", $EF, $EE, "But yes, I tutored", $FA, $F7
    db $EF, $EE, "Lady Yuna in the", $EF, $EE, "western kingdom.", $FA, $F7
    db $EF, $EE, "It brings back", $EF, $EE, "some memories", $A4, $FA, $F7
    db $EF, $EE, "Will you hear this", $EF, $EE, "old man reminisce?"
    db $FF, $F0

Data_098_548F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna was a", $F1
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

Data_098_55E9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, you're rushed", $F1
    db "for time", $A4, " Sorry", $A4, $F7
    db $F0

Data_098_560F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I want to return", $F1
    db "to the north, but", $FA, $F7
    db $EF, $EE, "there are no ships", $EF, $EE, "sailing.", $FA, $F7
    db $EF, $EE, "The mountains in", $EF, $EE, "the north are too", $FA, $F7
    db $EF, $EE, "treacherous to", $EF, $EE, "attempt crossing.", $F7
    db $F0

Data_098_56A2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen has", $F1
    db "been suffering", $FA, $F7
    db $EF, $EE, "from nightmares", $EF, $EE, "terribly.", $FA, $F7
    db $EF, $EE, "They don't let her", $EF, $EE, "sleep.", $FA, $F7
    db $EF, $EE, "We're concerned", $EF, $EE, "for her health", $A4, $F7
    db $F0

Data_098_5723:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $A4, $A4, $A4, $A4, $98, $F7, $F0

Data_098_572D:: ; heuristic: target of a monotone pointer table; C0
    db $F0

; string-pointer table for message bank $2C, strings from $91 up (index minus $91) (E-0080)
MessageStrings_Bank2C_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_098_572E:: ; address name
    dw Data_098_5730

Data_098_5730:: ; heuristic: target of a monotone pointer table; C0
    dw Data_098_580E
    dw Data_098_588B
    dw Data_098_58FC
    dw Data_098_59BC
    dw Data_098_5A3E
    dw Data_098_5A88
    dw Data_098_5B1C
    dw Data_098_5B59
    dw Data_098_5BC0
    dw Data_098_5BDD
    dw Data_098_5C21
    dw Data_098_5CAC
    dw Data_098_5CF9
    dw Data_098_5D36
    dw Data_098_5D78
    dw Data_098_5D98
    dw Data_098_5DBF
    dw Data_098_5E02
    dw Data_098_5E43
    dw Data_098_5E8F
    dw Data_098_5F01
    dw Data_098_5F72
    dw Data_098_6075
    dw Data_098_6093
    dw Data_098_60CF
    dw Data_098_6103
    dw Data_098_6151
    dw Data_098_6151
    dw Data_098_6151
    dw Data_098_6151
    dw Data_098_6151
    dw Data_098_6151
    dw Data_098_623D
    dw Data_098_6259
    dw Data_098_62A5
    dw Data_098_6391
    dw Data_098_6412
    dw Data_098_64B9
    dw Data_098_64F5
    dw Data_098_6567
    dw Data_098_6588
    dw Data_098_65CC
    dw Data_098_6630
    dw Data_098_66D1
    dw Data_098_6731
    dw Data_098_67B8
    dw Data_098_67EF
    dw Data_098_6812
    dw Data_098_684A
    dw Data_098_68D8
    dw Data_098_6920
    dw Data_098_6983
    dw Data_098_69C5
    dw Data_098_6A42
    dw Data_098_6ABF
    dw Data_098_6B5B
    dw Data_098_6BEC
    dw Data_098_6C4F
    dw Data_098_6CCA
    dw Data_098_6D48
    dw Data_098_6DA2
    dw Data_098_6DDA
    dw Data_098_6E49
    dw Data_098_6E85
    dw Data_098_6EDC
    dw Data_098_6F69
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031

Data_098_580E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wa-hey! Can you", $F1
    db "hear me, ", $F9, "0?", $FA, $F7
    db $EF, $EE, "Things have turned", $EF, $EE, "serious, warooh!", $FA, $F7
    db $EF, $EE, "I'll bring you back", $EF, $EE, "to GreatLog.", $FA, $F7
    db $EF, $EE, "Don't move!", $EF, $EE, $F7
    db $F0

Data_098_588B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Some time ago,", $F1
    db "lightning struck", $FA, $F7
    db $EF, $EE, "the tower, causing", $EF, $EE, "it to buckle.", $FA, $F7
    db $EF, $EE, "A huge bird flew", $EF, $EE, "out of the rubble.", $F7
    db $F0

Data_098_58FC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who disturbs my", $F1
    db "sleep?", $FA, $F7
    db $EF, $EE, "The visitor from", $EF, $EE, "another world.", $FA, $F7
    db $EF, $EE, "I no longer feel", $EF, $EE, "the LightOrb's", $FA, $F7
    db $EF, $EE, "presence in this", $EF, $EE, "world.", $FA, $F7
    db $EF, $EE, "The Orb will no", $EF, $EE, "longer be a cause", $FA, $F7
    db $EF, $EE, "of strife in our", $EF, $EE, "world", $A4, $F7
    db $F0

Data_098_59BC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I heard on my", $F1
    db "travels that the", $FA, $F7
    db $EF, $EE, "monster King has", $EF, $EE, "disappeared.", $FA, $F7
    db $EF, $EE, "Where could he", $EF, $EE, "have gone?", $FA, $F7
    db $EF, $EE, "Well, it's not a", $EF, $EE, "bad thing.", $F7
    db $F0

Data_098_5A3E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The monster King", $F1
    db "disappeared.", $FA, $F7
    db $EF, $EE, "He"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " made monsters", $EF, $EE, "obey using magic.", $F7
    db $F0

Data_098_5A88:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When the monster", $F1
    db "King disappeared,", $FA, $F7
    db $EF, $EE, "we all gained our", $EF, $EE, "freedom.", $FA, $F7
    db $EF, $EE, "But everyone's been", $EF, $EE, "having so much fun", $FA, $F7
    db $EF, $EE, "treasure hunting,", $EF, $EE, "no one's quit!", $F7
    db $F0

Data_098_5B1C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Castle is", $F1
    db "now managed by all", $FA, $F7
    db $EF, $EE, "of us in the town.", $EF, $EE, $F7
    db $F0

Data_098_5B59:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Rumor has it", $F1
    db "that almost no one", $FA, $F7
    db $EF, $EE, "has seen the", $EF, $EE, "monster King.", $FA, $F7
    db $EF, $EE, "Maybe he looked", $EF, $EE, "weak and frail.", $F7
    db $F0

Data_098_5BC0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Where has our", $F1
    db "King gone?", $F7
    db $F0

Data_098_5BDD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There's no point", $F1
    db "staying in the", $FA, $F7
    db $EF, $EE, "army. I should go", $EF, $EE, "back home.", $F7
    db $F0

Data_098_5C21:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If I had the", $F1
    db "LightOrb, even I", $FA, $F7
    db $EF, $EE, "could become the", $EF, $EE, "King of monsters.", $FA, $F7
    db $EF, $EE, "Could you please", $EF, $EE, "tell me where I", $FA, $F7
    db $EF, $EE, "could find the", $EF, $EE, "LightOrb?", $F7
    db $F0

Data_098_5CAC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Town of Hitano", $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3, $20, $2B, $28, $35, $28, $90, $37, $35, $28, $24, $36, $38, $35, $28, $EF
    db $EE, $2B, $38, $31, $37, $28, $35, $36, $90, $2A, $24, $37, $2B, $28, $35, $B5
    db $95, $F7, $F0

Data_098_5CF9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Mayor is", $F1
    db "beyond here.", $FA, $F7
    db $EF, $EE, "Please watch your", $EF, $EE, "manners.", $F7
    db $F0

Data_098_5D36:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e become the", $F1
    db "Mayor, but what", $FA, $F7
    db $EF, $EE, "exactly should I", $EF, $EE, "be doing?", $F7
    db $F0

Data_098_5D78:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 released the", $F1
    db "grave's button.", $F7
    db $F0

Data_098_5D98:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The castle's lord", $F1
    db "summons monsters", $A4, $F7
    db $F0

Data_098_5DBF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A button hides", $F1
    db "behind a grave", $A4, $FA, $F7
    db $EF, $EE, "A button that", $EF, $EE, "opens a door", $A4, $F7
    db $F0

Data_098_5E02:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked", $F1
    db "behind the grave.", $FA, $F7
    db $EF, $EE, "There was nothing", $EF, $EE, "of interest.", $F7
    db $F0

Data_098_5E43:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King's gone.", $F1
    db "What should I do?", $FA, $F7
    db $EF, $EE, "I guess there's no", $EF, $EE, "Sirloin for me.", $F7
    db $F0

Data_098_5E8F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " South beyond the", $F1
    db "mountains is the", $FA, $F7
    db $EF, $EE, "King's castle.", $EF, $EE, "I understand that", $FA, $F7
    db $EF, $EE, "it's bustling with", $EF, $EE, "treasure hunters.", $F7
    db $F0

Data_098_5F01:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Several ancient", $F1
    db "ruins remain in", $FA, $F7
    db $EF, $EE, "the southern part", $EF, $EE, "of the continent.", $FA, $F7
    db $EF, $EE, "Treasures may be", $EF, $EE, "hidden in them.", $F7
    db $F0

Data_098_5F72:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I was taking a", $F1
    db "walk outside with", $FA, $F7
    db $EF, $EE, "my friend Roboster", $EF, $EE, "when he was almost", $FA, $F7
    db $EF, $EE, "taken away by a", $EF, $EE, "giant MadCondor.", $FA, $F7
    db $EF, $EE, "I think it was his", $EF, $EE, "shiny metal body", $FA, $F7
    db $EF, $EE, "that attracted the", $EF, $EE, "bird.", $FA, $F7
    db $EF, $EE, "That may mean", $EF, $EE, "lamps and armor", $FA, $F7
    db $EF, $EE, "will also draw the", $EF, $EE, "bird's attention.", $F7
    db $F0

Data_098_6075:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, $A4, "This way", $A4, $F1
    db $A4, "Here", $A4, " ", $A4, "Here", $A4, $F7
    db $F0

Data_098_6093:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Where is my", $F1
    db "casket", $A4, " Where", $A4, $FA, $F7
    db $EF, $EE, "Ring the bell", $A4, $EF, $EE, $A4, "Please", $A4, $F7
    db $F0

Data_098_60CF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "notice.", $FA, $F7
    db $EF, $EE, $95, "Guide the lost", $EF, $EE, "souls", $A4, $95, $F7
    db $F0

Data_098_6103:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Determine where", $EF, $EE, "you will land", $FA, $F7
    db $EF, $EE, "before flying", $EF, $EE, "off.", $95, $F7
    db $F0

Data_098_6151:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I lost again.", $F1
    db "I need to train my", $FA, $F7
    db $EF, $EE, "monsters a lot", $EF, $EE, "more to win.", $FA, $F7
    db $EF, $EE, "I'll have to go", $EF, $EE, "back to a world", $FA, $F7
    db $EF, $EE, "I", $42, "e already", $EF, $EE, "finished, and", $FA, $F7
    db $EF, $EE, "raise their levels", $EF, $EE, "some more.", $FA, $F7
    db $EF, $EE, "There might be", $EF, $EE, "something new for", $FA, $F7
    db $EF, $EE, "me to discover.", $EF, $EE, "Who knows?", $F7
    db $F0

Data_098_623D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Good! Let's get", $F1
    db "started!", $F7
    db $F0

Data_098_6259:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll be here for", $F1
    db "a while longer.", $FA, $F7
    db $EF, $EE, "If you change your", $EF, $EE, "mind, come back.", $F7
    db $F0

Data_098_62A5:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I lost again.", $F1
    db "I need to train my", $FA, $F7
    db $EF, $EE, "monsters a lot", $EF, $EE, "more to win.", $FA, $F7
    db $EF, $EE, "I'll have to go", $EF, $EE, "back to a world", $FA, $F7
    db $EF, $EE, "I", $42, "e already", $EF, $EE, "finished, and", $FA, $F7
    db $EF, $EE, "raise their levels", $EF, $EE, "some more.", $FA, $F7
    db $EF, $EE, "There might be", $EF, $EE, "something new for", $FA, $F7
    db $EF, $EE, "me to discover.", $EF, $EE, "Who knows?", $F7
    db $F0

Data_098_6391:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When you breed,", $F1
    db "the offspring", $FA, $F7
    db $EF, $EE, "inherit the", $EF, $EE, "parents", $95, " skills", $FA, $F7
    db $EF, $EE, "and abilities.", $EF, $EE, "So, you're better", $FA, $F7
    db $EF, $EE, "off breeding", $EF, $EE, "monsters.", $F7
    db $F0

Data_098_6412:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you know all", $F1
    db "the kinds of meat?", $FA, $F7
    db $EF, $EE, "There's BeefJerky,", $EF, $EE, "PorkChop, Rib and", $FA, $F7
    db $EF, $EE, "then there's", $EF, $EE, "Sirloin.", $FA, $F7
    db $EF, $EE, "Sirloin is the", $EF, $EE, "ultimate!", $FA, $F7
    db $EF, $EE, "So tender and", $EF, $EE, "heavenly tasty!", $F7
    db $F0

Data_098_64B9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you eat any", $F1
    db "BadMeat like me,", $FA, $F7
    db $EF, $EE, "you'll get", $EF, $EE, "poisoned.", $F7
    db $F0

Data_098_64F5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm? Little one,", $F1
    db "are you a master?", $FA, $F7
    db $EF, $EE, "How would you like", $EF, $EE, "to breed one of", $FA, $F7
    db $EF, $EE, "your monsters with", $EF, $EE, "my Armorpede?"
    db $FF, $F0

Data_098_6567:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Good! Let's get", $F1
    db "this started!", $F7
    db $F0

Data_098_6588:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, too bad.", $F1
    db "Another time.", $FA, $F7
    db $EF, $EE, "Tell me if you", $EF, $EE, "change your mind.", $F7
    db $F0

Data_098_65CC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you get an", $F1
    db "EvilArmor, I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $FA, $F7
    db $EF, $EE, "breed it with a", $EF, $EE, "material family", $FA, $F7
    db $EF, $EE, "partner. It's a", $EF, $EE, "tough combo.", $F7
    db $F0

Data_098_6630:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " NoctoKing is my", $F1
    db "name!", $FA, $F7
    db $EF, $EE, "Darkness is my", $EF, $EE, "domain!", $FA, $F7
    db $EF, $EE, "Perchance, do you", $EF, $EE, "know a skill named", $FA, $F7
    db $EF, $EE, "Ahhh? Its effects", $EF, $EE, "differ markedly", $FA, $F7
    db $EF, $EE, "depending on the", $EF, $EE, "gender.", $F7
    db $F0

Data_098_66D1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I learned how to", $F1
    db "Massacre!", $FA, $F7
    db $EF, $EE, "But I ended up", $EF, $EE, "clocking my mates", $FA, $F7
    db $EF, $EE, "pretty good too.", $EF, $EE, "Ehehe.", $F7
    db $F0

Data_098_6731:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Yo! Up close,", $F1
    db "you look tougher", $FA, $F7
    db $EF, $EE, "than you first", $EF, $EE, "appeared.", $FA, $F7
    db $EF, $EE, "Want to breed a", $EF, $EE, "monster with my", $FA, $F7
    db $EF, $EE, "WildApe? Does", $EF, $EE, "that sound good?"
    db $FF, $F0

Data_098_67B8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I like your", $F1
    db "style!", $FA, $F7
    db $EF, $EE, "Let's get started", $EF, $EE, "with this.", $F7
    db $F0

Data_098_67EF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? Are you", $F1
    db "sure about that?", $F7
    db $F0

Data_098_6812:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2F, $2F, $90, $35, $2C, $2A, $2B, $37, $3C, $99, $F1, $FA
    db $F7, $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "We'll do this again", $EF, $EE, "next time too!", $F7
    db $F0

Data_098_684A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Arr, matey!", $F1
    db "I'm CaptDead!", $FA, $F7
    db $EF, $EE, "A dashing zombie", $EF, $EE, "of the open seas!", $FA, $F7
    db $EF, $EE, "If I CallHelp, my", $EF, $EE, "trusty crew will", $FA, $F7
    db $EF, $EE, "come running,", $EF, $EE, "cutlasses ready!", $F7
    db $F0

Data_098_68D8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I strike with my", $F1
    db "eight tentacles.", $FA, $F7
    db $EF, $EE, "That means I hit", $EF, $EE, "eight times!", $F7
    db $F0

Data_098_6920:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome. I'm the", $F1
    db "Christener.", $FA, $F7
    db $EF, $EE, "I can rename your", $EF, $EE, "monsters here.", $FA, $F7
    db $EF, $EE, "Do you wish to", $EF, $EE, "rename one?", $F0

Data_098_6983:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome. I'm the", $F1
    db "Christener.", $FA, $F7
    db $EF, $EE, "Do you wish to", $EF, $EE, "rename someone?", $F0

Data_098_69C5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Handbook on", $EF, $EE, "Naming", $A4, $FA, $F7
    db $EF, $EE, "Using a part of", $EF, $EE, "the species name", $FA, $F7
    db $EF, $EE, "enables easier", $EF, $EE, "identification.", $95, $F7
    db $F0

Data_098_6A42:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Handbook on", $EF, $EE, "Naming", $A4, $FA, $F7
    db $EF, $EE, "Borrowing from the", $EF, $EE, "parents", $95, " names", $FA, $F7
    db $EF, $EE, "adds to the weight", $EF, $EE, "of a name.", $95, $F7
    db $F0

Data_098_6ABF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Handbook on", $EF, $EE, "Naming", $A4, $FA, $F7
    db $EF, $EE, "A string of the", $EF, $EE, "same character", $FA, $F7
    db $EF, $EE, "makes a terrible", $EF, $EE, "name. Where is", $FA, $F7
    db $EF, $EE, "your love for your", $EF, $EE, "monster?", $95, $F7
    db $F0

Data_098_6B5B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I was once a", $F1
    db "great master who", $FA, $F7
    db $EF, $EE, "traveled from", $EF, $EE, "world to world.", $FA, $F7
    db $EF, $EE, "I used that key to", $EF, $EE, "reach a world.", $FA, $F7
    db $EF, $EE, "You have your own", $EF, $EE, "Magic Keys, yes?"
    db $FF, $F0

Data_098_6BEC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you shown", $F1
    db "them to the Key", $FA, $F7
    db $EF, $EE, "Shop's boss?", $EF, $EE, "He'll make it so", $FA, $F7
    db $EF, $EE, "you can go to", $EF, $EE, "other worlds.", $F7
    db $F0

Data_098_6C4F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e not found", $F1
    db "any yet?", $FA, $F7
    db $EF, $EE, "That's a", $EF, $EE, "rotten shame", $A4, $FA, $F7
    db $EF, $EE, "Fine, look on the", $EF, $EE, "shelf there.", $FA, $F7
    db $EF, $EE, "You can take one", $EF, $EE, "of my keys.", $F7
    db $F0

Data_098_6CCA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That key, I used", $F1
    db "on my travels to", $FA, $F7
    db $EF, $EE, "other worlds in my", $EF, $EE, "youth.", $FA, $F7
    db $EF, $EE, "It brings back", $EF, $EE, "memories.", $FA, $F7
    db $EF, $EE, "No, you may not", $EF, $EE, "have it.", $F7
    db $F0

Data_098_6D48:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "shelf.", $FA, $F7
    db $EF, $EE, "Souvenirs from", $EF, $EE, "other worlds", $FA, $F7
    db $EF, $EE, "covered the shelf", $EF, $EE, "haphazardly.", $F7
    db $F0

Data_098_6DA2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "shelf.", $FA, $F7
    db $EF, $EE, $F9, "0 obtained a", $EF, $EE, "Magic Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_098_6DDA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "shelf.", $FA, $F7
    db $EF, $EE, $F9, "0 found a", $EF, $EE, "Magic Key.", $FA, $F7
    db $EF, $EE, "But the key ring", $EF, $EE, "was full.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Magic Key back.", $F7
    db $F0

Data_098_6E49:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "It was full of", $EF, $EE, "esoteric junk.", $F7
    db $F0

Data_098_6E85:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Monster Arena,", $EF, $EE, "where masters meet", $FA, $F7
    db $EF, $EE, "for battle!", $EF, $EE, "Downstairs!", $95, $F7
    db $F0

Data_098_6EDC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There are times", $F1
    db "when you have to", $FA, $F7
    db $EF, $EE, "take weak monsters", $EF, $EE, "out and about.", $FA, $F7
    db $EF, $EE, "If you want to", $EF, $EE, "avoid battles,", $FA, $F7
    db $EF, $EE, "sprinkle on some", $EF, $EE, "Repellent.", $F7
    db $F0

Data_098_6F69:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Up ahead is the", $F1
    db "Starry Shrine and", $FA, $F7
    db $EF, $EE, "the Egg Evaluator's", $EF, $EE, "room.", $FA, $F7
    db $EF, $EE, "Both facilities", $EF, $EE, "are absolutely", $FA, $F7
    db $EF, $EE, "indispensable to", $EF, $EE, "masters.", $FA, $F7
    db $EF, $EE, "But they're only", $EF, $EE, "open to certified", $FA, $F7
    db $EF, $EE, "masters, and no", $EF, $EE, "one else.", $F7
    db $F0

Data_098_7031:: ; heuristic: target of a monotone pointer table; C0
    db $F0

; string-pointer table for message bank $89, strings from $DE up (index minus $DE) (E-0080)
MessageStrings_Bank89_Overflow:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_098_7032:: ; address name
    dw Data_098_7034

Data_098_7034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_098_7078
    dw Data_098_7130
    dw Data_098_714B
    dw Data_098_71AC
    dw Data_098_71EA
    dw Data_098_7227
    dw Data_098_7288
    dw Data_098_72C5
    dw Data_098_7323
    dw Data_098_7369
    dw Data_098_73EC
    dw Data_098_7496
    dw Data_098_7542
    dw Data_098_75E6
    dw Data_098_7684
    dw Data_098_7755
    dw Data_098_781C
    dw Data_098_78FD
    dw Data_098_7A0B
    dw Data_098_7A4D
    dw Data_098_7AE9
    dw Data_098_7B1F
    dw Data_098_7BA4
    dw Data_098_7BC8
    dw Data_098_7C2F
    dw Data_098_7C75
    dw Data_098_7CB4
    dw Data_098_7CD2
    dw Data_098_7CD2
    dw Data_098_7CD2
    dw Data_098_7CD2
    dw Data_098_7CD2
    dw Data_098_7CD2
    dw Data_098_7CD2

Data_098_7078:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? You don't", $F1
    db "know about the", $FA, $F7
    db $EF, $EE, "Starry Shrine or", $EF, $EE, "the Egg Evaluator?", $FA, $F7
    db $EF, $EE, "Urrrgh", $A4, " Look them", $EF, $EE, "up at the Library.", $FA, $F7
    db $EF, $EE, "I'm not much good", $EF, $EE, "at explaining, but", $FA, $F7
    db $EF, $EE, "I", $42, "e gotten you", $EF, $EE, "the word!", $F7
    db $F0

Data_098_7130:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A beautiful voice", $F1
    db "echoed", $A4, $F7
    db $F0

Data_098_714B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Helen", $A3, " I thank you", $F1
    db "from the heart.", $FA, $F7
    db $EF, $EE, "Please give my", $EF, $EE, "regards to the", $FA, $F7
    db $EF, $EE, "spirit in the", $EF, $EE, "spring.", $F7
    db $F0

Data_098_71AC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Seeing the", $F1
    db "liveliness of", $FA, $F7
    db $EF, $EE, "Lady Yuna lifts", $EF, $EE, "our spirits.", $F7
    db $F0

Data_098_71EA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "tombstone.", $FA, $F7
    db $EF, $EE, "There appeared to", $EF, $EE, "be nothing.", $F7
    db $F0

Data_098_7227:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The sea is huge", $F1
    db "and mysterious.", $FA, $F7
    db $EF, $EE, "There must be", $EF, $EE, "totally different", $FA, $F7
    db $EF, $EE, "monsters in the", $EF, $EE, "sea.", $F7
    db $F0

Data_098_7288:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Huh? Has the sea", $F1
    db "risen?", $FA, $F7
    db $EF, $EE, "Oh, well. I'm a", $EF, $EE, "good swimmer.", $F7
    db $F0

Data_098_72C5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The water flowed", $F1
    db "right over the", $FA, $F7
    db $EF, $EE, "ground almost", $EF, $EE, "instantly.", $FA, $F7
    db $EF, $EE, "Is GreatLog really", $EF, $EE, "safe?", $F7
    db $F0

Data_098_7323:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Look! A MadCondor!", $F1
    db "It has something!", $FA, $F7
    db $EF, $EE, "It clutched a", $EF, $EE, "glowing ball!", $F7
    db $F0

Data_098_7369:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, ", $F9, "0!", $F1
    db "You", $42, "e befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You", $42, "e got at", $EF, $EE, "least 20 species!", $FA, $F7
    db $EF, $EE, "Keep at it, and", $EF, $EE, "get some more!", $F7
    db $F0

Data_098_73EC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, ", $F9, "0!", $F1
    db "You", $42, "e befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You", $42, "e got at", $EF, $EE, "least 30 species!", $FA, $F7
    db $EF, $EE, "You can check up", $EF, $EE, "on your monsters", $95, $FA, $F7
    db $EF, $EE, "cataloged data at", $EF, $EE, "the Library.", $F7
    db $F0

Data_098_7496:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, ", $F9, "0!", $F1
    db "You", $42, "e befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You", $42, "e got at", $EF, $EE, "least 40 species!", $FA, $F7
    db $EF, $EE, "If the farm is", $EF, $EE, "full, you should", $FA, $F7
    db $EF, $EE, "try breeding some", $EF, $EE, "of your monsters.", $F7
    db $F0

Data_098_7542:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, ", $F9, "0!", $F1
    db "You", $42, "e befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You", $42, "e got at", $EF, $EE, "least 50 species!", $FA, $F7
    db $EF, $EE, "By the way, I", $EF, $EE, "think Prince", $FA, $F7
    db $EF, $EE, "Kameha had some", $EF, $EE, "rare Magic Keys.", $F7
    db $F0

Data_098_75E6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, ", $F9, "0!", $F1
    db "You", $42, "e befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You", $42, "e got at", $EF, $EE, "least 100 species!", $FA, $F7
    db $EF, $EE, "You", $42, "e grown up a", $EF, $EE, "lot through this.", $FA, $F7
    db $EF, $EE, "I'm proud of you!", $EF, $EE, $F7
    db $F0

Data_098_7684:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, ", $F9, "0!", $F1
    db "You", $42, "e befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You", $42, "e got at", $EF, $EE, "least 150 species!", $FA, $F7
    db $EF, $EE, "Have you met a boy", $EF, $EE, "named Terry?", $FA, $F7
    db $EF, $EE, "You should be good", $EF, $EE, "enough as a master", $FA, $F7
    db $EF, $EE, "to be worthy of", $EF, $EE, "his approval.", $F7
    db $F0

Data_098_7755:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, ", $F9, "0!", $F1
    db "You", $42, "e befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You", $42, "e got at", $EF, $EE, "least 200 species!", $FA, $F7
    db $EF, $EE, "I doubt no one has", $EF, $EE, "cataloged as many", $FA, $F7
    db $EF, $EE, "monsters as you.", $EF, $EE, $A4, "What's that?", $FA, $F7
    db $EF, $EE, "Am I embarrassing", $EF, $EE, "you?", $F7
    db $F0

Data_098_781C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, ", $F9, "0!", $F1
    db "You", $42, "e befriended", $FA, $F7
    db $EF, $EE, "a good number of", $EF, $EE, "monsters!", $FA, $F7
    db $EF, $EE, "You", $42, "e got at", $EF, $EE, "least 250 species!", $FA, $F7
    db $EF, $EE, "I had no idea that", $EF, $EE, "there were so many", $FA, $F7
    db $EF, $EE, "distinct species", $EF, $EE, "of monsters. Even", $FA, $F7
    db $EF, $EE, "Professor Monster", $EF, $EE, "can't know them", $FA, $F7
    db $EF, $EE, "all.", $EF, $EE, $F7
    db $F0

Data_098_78FD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Congratulations,", $F1
    db $F9, "0!", $FA, $F7
    db $EF, $EE, "You", $42, "e cataloged", $EF, $EE, "every species.", $FA, $F7
    db $EF, $EE, "There appear to", $EF, $EE, "be no monsters", $FA, $F7
    db $EF, $EE, "left to be caught", $EF, $EE, "and cataloged.", $FA, $F7
    db $EF, $EE, "You hung in for", $EF, $EE, "all this time.", $FA, $F7
    db $EF, $EE, "I'm sincerely", $EF, $EE, "proud of you.", $FA, $F7
    db $EF, $EE, $F9, "0, I'm counting", $EF, $EE, "on you to look", $FA, $F7
    db $EF, $EE, "after the farm and", $EF, $EE, "the monsters.", $F7
    db $F0

Data_098_7A0B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome to the", $F1
    db "Library!", $FA, $F7
    db $EF, $EE, "Your monster", $EF, $EE, "Catalog is done!"
    db $E5, $4D, $F7, $E9, $FF, $F0

Data_098_7A4D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We need fanfare", $F1
    db "right about now", $A4, $FA, $F7
    db $EF, $EE, "Congratulations,", $EF, $EE, "our little hero!", $FA, $F7
    db $EF, $EE, "Here is your newly", $EF, $EE, "filled Catalog!", $FA, $F7
    db $EF, $EE, "Which family would", $EF, $EE, "you like to check?", $F7
    db $F0

Data_098_7AE9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The weather has", $F1
    db "been mild.", $FA, $F7
    db $EF, $EE, "It's a good thing.", $EF, $EE, $F7
    db $F0

Data_098_7B1F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna has", $F1
    db "come out of her", $FA, $F7
    db $EF, $EE, "depression. I", $42, "e", $EF, $EE, "heard.", $FA, $F7
    db $EF, $EE, "When it comes to", $EF, $EE, "rumors, good ones", $FA, $F7
    db $EF, $EE, "are the best, I", $EF, $EE, "have to say.", $F7
    db $F0

Data_098_7BA4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Queen's lost", $F1
    db "her scary look!", $F7
    db $F0

Data_098_7BC8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The kingdoms of", $F1
    db "the north and west", $FA, $F7
    db $EF, $EE, "have reconciled", $EF, $EE, "from their ugly", $FA, $F7
    db $EF, $EE, "squabble over the", $EF, $EE, "mine.", $F7
    db $F0

Data_098_7C2F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The scholar who", $F1
    db "was in the tavern?", $FA, $F7
    db $EF, $EE, "I think he went", $EF, $EE, "back home.", $F7
    db $F0

Data_098_7C75:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey?", $F1
    db "Feel that, warooh?", $FA, $F7
    db $EF, $EE, "Did something", $EF, $EE, "shake?", $F7
    db $F0

Data_098_7CB4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ZZZZZ", $A4, " Ssss", $A4, $F1
    db "ZZZZZ", $A4, " Ssss", $A4, $F7
    db $F0

Data_098_7CD2:: ; heuristic: target of a monotone pointer table; C0
    ds $32E, $00
