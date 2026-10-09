SECTION "Bank 96", ROMX[$4000], BANK[$96]
    db $96

; 1 call site from 1 routine (e.g. Func_080_4001)
; reads: wC529
; writes: wC529
Func_096_4001::
    ld de, Data_096_404B
    ld a, [wC529]
    sub a, $C8
    ld [wC529], a
    call Func_000_25C9
    ret

; 1 call site from 1 routine (e.g. Func_080_4016)
; reads: wC529
; writes: wC529
Func_096_4010:: ; heuristic: follows a terminator; C0
    ld de, Data_096_404B
    ld a, [wC529]
    sub a, $C8
    ld [wC529], a
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; 2 call sites from 2 routines (e.g. Func_082_4001, Func_082_4016)
; reads: wC529
; writes: wC529
Func_096_4026::
    ld de, Data_096_574A
    ld a, [wC529]
    sub a, $90
    ld [wC529], a
    call Func_000_25C9
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC529
; writes: wC529
Func_096_4035:: ; heuristic: follows a terminator; C0
    ld de, Data_096_574A
    ld a, [wC529]
    sub a, $90
    ld [wC529], a
    call Func_000_25FE
    ret
    db $CD, $26, $40, $CD, $11, $26, $C9

Data_096_404B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_096_404D

Data_096_404D:: ; heuristic: target of a monotone pointer table; C0
    dw Data_096_40BD
    dw Data_096_4119
    dw Data_096_4184
    dw Data_096_4236
    dw Data_096_42BE
    dw Data_096_432C
    dw Data_096_4374
    dw Data_096_43AA
    dw Data_096_43F6
    dw Data_096_4413
    dw Data_096_442E
    dw Data_096_44B1
    dw Data_096_44D3
    dw Data_096_44F2
    dw Data_096_4735
    dw Data_096_4735
    dw Data_096_47D8
    dw Data_096_4818
    dw Data_096_4878
    dw Data_096_4899
    dw Data_096_48DA
    dw Data_096_494E
    dw Data_096_494E
    dw Data_096_49BC
    dw Data_096_4A3C
    dw Data_096_4A9E
    dw Data_096_4B0D
    dw Data_096_4B91
    dw Data_096_4C0F
    dw Data_096_4CC6
    dw Data_096_4D0E
    dw Data_096_4E8F
    dw Data_096_4EE5
    dw Data_096_4F27
    dw Data_096_4F80
    dw Data_096_4FEC
    dw Data_096_4FF7
    dw Data_096_5016
    dw Data_096_5036
    dw Data_096_510C
    dw Data_096_515B
    dw Data_096_51C2
    dw Data_096_51C2
    dw Data_096_5201
    dw Data_096_525C
    dw Data_096_52C9
    dw Data_096_539D
    dw Data_096_539D
    dw Data_096_547E
    dw Data_096_54C2
    dw Data_096_5507
    dw Data_096_554B
    dw Data_096_55C7
    dw Data_096_560B
    dw Data_096_5671
    dw Data_096_56B8

Data_096_40BD:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You will?", $F1
    db "Thank you!", $FA, $F7
    db $EF, $EE, "Let me hide among", $EF, $EE, "your items.", $FA, $F7
    db $EF, $EE, "Oh? You have no", $EF, $EE, "room for me", $A4, $F7
    db $F0

Data_096_4119:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " How terribly", $F1
    db "disappointing.", $FA, $F7
    db $EF, $EE, "I'll have to find", $EF, $EE, "someone else who", $FA, $F7
    db $EF, $EE, "would be willing", $EF, $EE, "to help me", $A4, $F7
    db $F0

Data_096_4184:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't remember", $F1
    db "who I am, what I'm", $FA, $F7
    db $EF, $EE, "doing here, or", $EF, $EE, "anything else", $A4, $FA, $F7
    db $EF, $EE, "I just know that I", $EF, $EE, "need help", $A4, $FA, $F7
    db $EF, $EE, "Oh? Do you know", $EF, $EE, "who I am?", $FA, $F7
    db $EF, $EE, "Could I get you to", $EF, $EE, "take me back home?"
    db $FF, $F0

Data_096_4236:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The crowds that", $F1
    db "flocked to the", $FA, $F7
    db $EF, $EE, "castle have all", $EF, $EE, "left.", $FA, $F7
    db $EF, $EE, "Not a one of them", $EF, $EE, "raised even the", $FA, $F7
    db $EF, $EE, "ghost of a smile", $EF, $EE, "from Lady Yuna", $A4, $F7
    db $F0

Data_096_42BE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Yuna has", $F1
    db "locked herself", $FA, $F7
    db $EF, $EE, "away in her room", $A4, $EF, $EE, "Everyone failed to", $FA, $F7
    db $EF, $EE, "cheer her up even", $EF, $EE, "the least bit", $A4, $F7
    db $F0

Data_096_432C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna locked", $F1
    db "herself in and", $FA, $F7
    db $EF, $EE, "won't respond to", $EF, $EE, "repeated calls.", $F7
    db $F0

Data_096_4374:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "marionette.", $FA, $F7
    db $EF, $EE, "It sagged", $EF, $EE, "lifelessly.", $F7
    db $F0

Data_096_43AA:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $A4, $A4, $A4, $A4, $F1, $FA, $F7, $EF, $EE, $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "W-where am I?", $F1
    db "I", $A4, " I", $A4, " I am", $A4, $FA, $F7
    db $EF, $EE, "I'm on the verge", $EF, $EE, "of remembering!", $F7
    db $F0

Data_096_43F6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yuna's soul filled", $F1
    db "her body.", $F7
    db $F0

Data_096_4413:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, $A4, " STOP", $A4, $F1
    db "DON", $95, "T MEDDLE", $A4, $F7
    db $F0

Data_096_442E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " NEVER DID I", $F1
    db "EXPECT YUNA", $95, "S SOUL", $FA, $F7
    db $EF, $EE, "TO BE FOUND", $A4, $EF, $EE, "BUT, NO MATTER.", $FA, $F7
    db $EF, $EE, "YOU MUST DEFEAT ME", $EF, $EE, "TO SAVE HER.", $FA, $F7
    db $EF, $EE, "DO YOU WISH TO", $EF, $EE, "BATTLE?"
    db $FF, $F0

Data_096_44B1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " FOOLHARDY.", $F1
    db "BRAVE BUT FOOLISH.", $F7
    db $F0

Data_096_44D3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " H-HOW", $A4, " BUT I", $A4, $F1
    db "THIS ISN", $95, "T", $A4, $A4, $F7
    db $F0

Data_096_44F2:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e finally", $F1
    db "remembered.", $FA, $F7
    db $EF, $EE, "I'm Yuna, the", $EF, $EE, "King's daughter.", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " overheard a", $EF, $EE, "man and monsters", $FA, $F7
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

Data_096_4735:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Yuna", $A3, " Their next", $F1
    db "target is Queen", $FA, $F7
    db $EF, $EE, "Helen of the", $EF, $EE, "eastern kingdom.", $FA, $F7
    db $EF, $EE, "There can be no", $EF, $EE, "one else.", $FA, $F7
    db $EF, $EE, "Please, go to her", $EF, $EE, "and help her like", $FA, $F7
    db $EF, $EE, "you have helped", $EF, $EE, "me.", $F7
    db $F0

Data_096_47D8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna has", $F1
    db "regained her usual", $FA, $F7
    db $EF, $EE, "exuberance and", $EF, $EE, "energy.", $F7
    db $F0

Data_096_4818:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna snuck", $F1
    db "out again.", $FA, $F7
    db $EF, $EE, "I'm not sure if we", $EF, $EE, "should be happy or", $FA, $F7
    db $EF, $EE, "concerned about", $EF, $EE, "it.", $F7
    db $F0

Data_096_4878:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? How did you", $F1
    db "get in here?", $F7
    db $F0

Data_096_4899:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How could we", $F1
    db "ever thank you", $FA, $F7
    db $EF, $EE, "enough for saving", $EF, $EE, "Lady Yuna?", $F7
    db $F0

Data_096_48DA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Yuna is back", $F1
    db "to being herself.", $FA, $F7
    db $EF, $EE, "Perhaps she is a", $EF, $EE, "bit too energetic,", $FA, $F7
    db $EF, $EE, "but it's a cause", $EF, $EE, "for celebration!", $F7
    db $F0

Data_096_494E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna is", $F1
    db "back to her cheery", $FA, $F7
    db $EF, $EE, "smiling self!", $EF, $EE, "Even the weather", $FA, $F7
    db $EF, $EE, "seems to be in a", $EF, $EE, "celebrating mood.", $F7
    db $F0

Data_096_49BC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Lady Yuna has", $EF, $EE, "regained her", $FA, $F7
    db $EF, $EE, "cheerful vivacity.", $EF, $EE, "The contest for", $FA, $F7
    db $EF, $EE, "cheering her up is", $EF, $EE, "now finished.", $95, $F7
    db $F0

Data_096_4A3C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna seems", $F1
    db "to be her cheerful", $FA, $F7
    db $EF, $EE, "old self again.", $EF, $EE, "But whatever", $FA, $F7
    db $EF, $EE, "became of the", $EF, $EE, "reward?", $F7
    db $F0

Data_096_4A9E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Lady Yuna tries", $F1
    db "to bolt from the", $FA, $F7
    db $EF, $EE, "Castle every day.", $EF, $EE, "That, of course,", $FA, $F7
    db $EF, $EE, "causes the King", $EF, $EE, "great anxiety.", $F7
    db $F0

Data_096_4B0D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " All the people", $F1
    db "swarming to the", $FA, $F7
    db $EF, $EE, "Castle have gone", $EF, $EE, "away", $A4, $FA, $F7
    db $EF, $EE, "I wish I could", $42, "e", $EF, $EE, "seen them", $A4, $FA, $F7
    db $EF, $EE, "They should have", $EF, $EE, "done shows here.", $F7
    db $F0

Data_096_4B91:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen had", $F1
    db "been suffering", $FA, $F7
    db $EF, $EE, "from nightmares,", $EF, $EE, "and now she has", $FA, $F7
    db $EF, $EE, "fallen terribly", $EF, $EE, "ill", $A4, $FA, $F7
    db $EF, $EE, "Her life is in", $EF, $EE, "jeopardy", $A4, $F7
    db $F0

Data_096_4C0F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't come", $F1
    db "in here.", $FA, $F7
    db $EF, $EE, "Queen Helen's room", $EF, $EE, "is past here.", $FA, $F7
    db $EF, $EE, "She's taken sick", $EF, $EE, "from nightmares.", $FA, $F7
    db $EF, $EE, "If she could sleep", $EF, $EE, "deeply, far beyond", $FA, $F7
    db $EF, $EE, "seeing any dreams,", $EF, $EE, "she may be cured", $A4, $F7
    db $F0

Data_096_4CC6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The reception", $F1
    db "hall is past here.", $FA, $F7
    db $EF, $EE, "However, our Queen", $EF, $EE, "isn't there.", $F7
    db $F0

Data_096_4D0E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e traveled far", $F1
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

Data_096_4E8F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "blue flower.", $FA, $F7
    db $EF, $EE, "It was the", $EF, $EE, "SleepHerb!", $FA, $F7
    db $EF, $EE, $F9, "0 obtained the", $EF, $EE, "SleepHerb.", $F7
    db $F0

Data_096_4EE5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "blue flower.", $FA, $F7
    db $EF, $EE, "The SleepHerb", $EF, $EE, "poked out of snow.", $F7
    db $F0

Data_096_4F27:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "blue flower.", $FA, $F7
    db $EF, $EE, "It was the", $EF, $EE, "SleepHerb!", $FA, $F7
    db $EF, $EE, "But there was no", $EF, $EE, "room for it.", $F7
    db $F0

Data_096_4F80:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Pardon me?", $F1
    db "You have medicine?", $FA, $F7
    db $EF, $EE, "This flower will", $EF, $EE, "save our Queen?", $FA, $F7
    db $EF, $EE, "Please come with", $EF, $EE, "me to her room!", $F7
    db $F0

Data_096_4FEC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, $A4, $A4, $A4, $A4, $A4, $F7
    db $F0

Data_096_4FF7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The Queen took the", $F1
    db "SleepHerb", $A4, $F7
    db $F0

Data_096_5016:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I wish you", $F1
    db "wouldn't do that", $A4, $F7
    db $F0

Data_096_5036:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our plan called", $F1
    db "for chaos in the", $FA, $F7
    db $EF, $EE, "three kingdoms", $EF, $EE, "around the lake", $A4, $FA, $F7
    db $EF, $EE, "So I had wormed my", $EF, $EE, "way into the", $FA, $F7
    db $EF, $EE, "Queen's dreams to", $EF, $EE, "create nightmares.", $FA, $F7
    db $EF, $EE, "That drug will", $EF, $EE, "ruin my plan.", $FA, $F7
    db $EF, $EE, "You dare to defy", $EF, $EE, "me, child?"
    db $FF, $F0

Data_096_510C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Heh, such a show", $F1
    db "of false bravado!", $FA, $F7
    db $EF, $EE, "You will pay for", $EF, $EE, "it with your life!", $F7
    db $F0

Data_096_515B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? Lose to a", $F1
    db "child's monsters?", $FA, $F7
    db $EF, $EE, "So it was you who", $EF, $EE, "took the others!", $FA, $F7
    db $EF, $EE, "I must inform my", $EF, $EE, "King!", $F7
    db $F0

Data_096_51C2:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, my goodness!", $F1
    db "Thank you!", $FA, $F7
    db $EF, $EE, "You saved our", $EF, $EE, "Queen Helen!", $F7
    db $F0

Data_096_5201:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That was a", $F1
    db "lovely sleep.", $FA, $F7
    db $EF, $EE, "I haven't slept so", $EF, $EE, "soundly in weeks.", $FA, $F7
    db $EF, $EE, "Oh? Who are you?", $EF, $EE, $F7
    db $F0

Data_096_525C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Your Highness!", $F1
    db "You're awake!", $FA, $F7
    db $EF, $EE, "This child rid you", $EF, $EE, "of the fiend that", $FA, $F7
    db $EF, $EE, "made nightmares of", $EF, $EE, "your dreams.", $F7
    db $F0

Data_096_52C9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Helen", $A3, " I put you", $F1
    db "through trouble", $A4, $FA, $F7
    db $EF, $EE, "Since I started", $EF, $EE, "having nightmares,", $FA, $F7
    db $EF, $EE, "I haven't awoken", $EF, $EE, "this refreshed.", $FA, $F7
    db $EF, $EE, "I am truly", $EF, $EE, "grateful.", $FA, $F7
    db $EF, $EE, "Oh! That Crest", $A4, $EF, $EE, "It's the spirit's", $A4, $FA, $F7
    db $EF, $EE, "So it was all the", $EF, $EE, "spirit's bidding", $A4, $F7
    db $F0

Data_096_539D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Helen", $A3, " Thank you", $F1
    db "so much.", $FA, $F7
    db $EF, $EE, "Please thank the", $EF, $EE, "spirit for me too.", $FA, $F7
    db $EF, $EE, $A4, $A4, $A4, $A4, $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Oh? I saw a dark", $F1
    db "shadow over you", $A4, $FA, $F7
    db $EF, $EE, "But you're blessed", $EF, $EE, "by the spirit", $A4, $FA, $F7
    db $EF, $EE, "I must have just", $EF, $EE, "imagined it.", $FA, $F7
    db $EF, $EE, "Please don't think", $EF, $EE, "anything of it.", $F7
    db $F0

Data_096_547E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Quick, give the", $F1
    db "medicine to "

Data_096_549D:: ; heuristic: bank from RAM variable $D7FE; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "our", $FA, $F7
    db $EF, $EE, "Queen Helen.", $EF, $EE, "Please, hurry!", $F7
    db $F0

Data_096_54C2:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen is", $F1
    db "safe for now!", $FA, $F7
    db $EF, $EE, "Please get rid of", $EF, $EE, "the monsters!", $F7
    db $F0

Data_096_5507:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You have", $F1
    db "restored peace.", $FA, $F7
    db $EF, $EE, "For this, we can", $EF, $EE, "thank the spirit.", $F7
    db $F0

Data_096_554B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen isn't", $F1
    db "bedridden by", $FA, $F7
    db $EF, $EE, "nightmares", $EF, $EE, "anymore.", $FA, $F7
    db $EF, $EE, "From now on, it's", $EF

Data_096_5598:: ; heuristic: bank from RAM variable $D7FE; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EE, "our turn to do our", $FA, $F7
    db $EF, $EE, "best for Queen", $EF, $EE, "Helen.", $F7
    db $F0

Data_096_55C7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen has", $F1
    db "had a good dream,", $FA, $F7
    db $EF, $EE, "I", $42, "e heard.", $EF, $EE, "What a change!", $F7
    db $F0

Data_096_560B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The skies are", $F1
    db "clear, but my", $FA, $F7
    db $EF, $EE, "heart remains", $EF, $EE, "heavy and clouded", $A4, $FA, $F7
    db $EF, $EE, "When will my wife", $EF, $EE, "come home?", $F7
    db $F0

Data_096_5671:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It has been", $F1
    db "getting warmer.", $FA, $F7
    db $EF, $EE, "The lake's ice is", $EF, $EE, "starting to melt.", $F7
    db $F0

Data_096_56B8:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I heard from my", $F1
    db "sister who works", $FA, $F7
    db $EF, $EE, "at the castle that", $EF, $EE, "Queen Helen had", $FA, $F7
    db $EF, $EE, "been possessed by", $EF, $EE, "a monster.", $FA, $F7
    db $EF, $EE, "That's why she was", $EF, $EE, "in a bad mood!", $F7
    db $F0

Data_096_574A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_096_574C

Data_096_574C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_096_582C
    dw Data_096_586E
    dw Data_096_588A
    dw Data_096_5941
    dw Data_096_595F
    dw Data_096_5A3D
    dw Data_096_5A99
    dw Data_096_5B1C
    dw Data_096_5B8C
    dw Data_096_5C1F
    dw Data_096_5CCA
    dw Data_096_5CEB
    dw Data_096_5DBD
    dw Data_096_5E68
    dw Data_096_5E8B
    dw Data_096_5F5D
    dw Data_096_602E
    dw Data_096_604E
    dw Data_096_6146
    dw Data_096_61ED
    dw Data_096_62CB
    dw Data_096_6386
    dw Data_096_63EB
    dw Data_096_6456
    dw Data_096_64C4
    dw Data_096_654E
    dw Data_096_654E
    dw Data_096_654E
    dw Data_096_654E
    dw Data_096_65B5
    dw Data_096_66AD
    dw Data_096_6723
    dw Data_096_67A6
    dw Data_096_686E
    dw Data_096_691E
    dw Data_096_6985
    dw Data_096_6A11
    dw Data_096_6AA1
    dw Data_096_6AC2
    dw Data_096_6B16
    dw Data_096_6B35
    dw Data_096_6B89
    dw Data_096_6C18
    dw Data_096_6C60
    dw Data_096_6CFD
    dw Data_096_6D41
    dw Data_096_6DA7
    dw Data_096_6DF7
    dw Data_096_6E82
    dw Data_096_6EA2
    dw Data_096_6EC0
    dw Data_096_6EE0
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6

Data_096_582C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " So you're", $F1
    db "confident, huh?", $FA, $F7
    db $EF, $EE, "Let's go down to", $EF, $EE, "the Arena!", $F7
    db $F0

Data_096_586E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " What?", $F1
    db "Scared, ", $F9, "0?", $F7
    db $F0

Data_096_588A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Well, uh,", $F1
    db "luck and status", $FA, $F7
    db $EF, $EE, "and conditions and", $EF, $EE, "other factors just", $FA, $F7
    db $EF, $EE, "weren't right today", $EF, $EE, "for me to win.", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $F7
    db $F0

Data_096_5941:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Elf Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_096_595F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Well, uh,", $F1
    db "luck and status", $FA, $F7
    db $EF, $EE, "and conditions and", $EF, $EE, "other factors just", $FA, $F7
    db $EF, $EE, "weren't right today", $EF, $EE, "for me to win.", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $FA, $F7
    db $EF, $EE, $A4, "Your key ring's", $EF, $EE, "full. Later, then.", $F7
    db $F0

Data_096_5A3D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " What?", $F1
    db "Oh, it's ", $F9, "0.", $FA, $F7
    db $EF, $EE, "Did you want", $EF, $EE, "something?", $FA, $F7
    db $EF, $EE, "Just joking, you", $EF, $EE, "came for this.", $F7
    db $F0

Data_096_5A99:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " What?", $F1
    db "Oh, it's ", $F9, "0.", $FA, $F7
    db $EF, $EE, "Did you want", $EF, $EE, "something?", $FA, $F7
    db $EF, $EE, "Just joking, you", $EF, $EE, "came for this.", $FA, $F7
    db $EF, $EE, $A4, "Your key ring's", $EF, $EE, "full. Later, then.", $F7
    db $F0

Data_096_5B1C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Wahahahah!", $F1
    db "You're weak!", $FA, $F7
    db $EF, $EE, "You're a lot weaker", $EF, $EE, "than I expected!", $FA, $F7
    db $EF, $EE, "I'll take you on", $EF, $EE, "whenever you want!", $F7
    db $F0

Data_096_5B8C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Watch me,", $F1
    db "I'm going to train", $FA, $F7
    db $EF, $EE, "in other worlds", $EF, $EE, "and flatten you!", $FA, $F7
    db $EF, $EE, "You're my rival,", $EF, $EE, "so don't you dare", $FA, $F7
    db $EF, $EE, "lose to anyone", $EF, $EE, "else before me!", $F7
    db $F0

Data_096_5C1F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " ", $A4, "Whew.", $F1
    db "That was special.", $FA, $F7
    db $EF, $EE, "I may have lost", $EF, $EE, "the battle, but I", $FA, $F7
    db $EF, $EE, "had you beat in", $EF, $EE, "technique.", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $F7
    db $F0

Data_096_5CCA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Lonely Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_096_5CEB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " ", $A4, "Whew.", $F1
    db "That was special.", $FA, $F7
    db $EF, $EE, "I may have lost", $EF, $EE, "the battle, but I", $FA, $F7
    db $EF, $EE, "had you beat in", $EF, $EE, "technique.", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $FA, $F7
    db $EF, $EE, $A4, "Your key ring's", $EF, $EE, "full. Later, then.", $F7
    db $F0

Data_096_5DBD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " That was a", $F1
    db "good warmup!", $FA, $F7
    db $EF, $EE, "Are you ready for", $EF, $EE, "the real thing?", $FA, $F7
    db $EF, $EE, "The last one", $EF, $EE, "standing wins!", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $F7
    db $F0

Data_096_5E68:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Traveler Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_096_5E8B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " That was a", $F1
    db "good warmup!", $FA, $F7
    db $EF, $EE, "Are you ready for", $EF, $EE, "the real thing?", $FA, $F7
    db $EF, $EE, "The last one", $EF, $EE, "standing wins!", $FA, $F7
    db $EF, $EE, "Oh, OK, I lost.", $EF, $EE, "It's my turn next.", $FA, $F7
    db $EF, $EE, "Here, you can have", $EF, $EE, "this.", $FA, $F7
    db $EF, $EE, $A4, "Your key ring's", $EF, $EE, "full. Later, then.", $F7
    db $F0

Data_096_5F5D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Whew", $A4, $F1
    db "Close, real close.", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " say our skills", $EF, $EE, "are almost equal.", $FA, $F7
    db $EF, $EE, "You don't have the", $EF, $EE, "confidence to beat", $FA, $F7
    db $EF, $EE, "me again, do you?", $EF, $EE, "I can tell.", $FA, $F7
    db $EF, $EE, "Oh, OK, a loss is", $EF, $EE, "a loss.", $FA, $F7
    db $EF, $EE, "Here's my best", $EF, $EE, "Magic Key.", $F7
    db $F0

Data_096_602E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Brawn Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_096_604E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Whew", $A4, $F1
    db "Close, real close.", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " say our skills", $EF, $EE, "are almost equal.", $FA, $F7
    db $EF, $EE, "You don't have the", $EF, $EE, "confidence to beat", $FA, $F7
    db $EF, $EE, "me again, do you?", $EF, $EE, "I can tell.", $FA, $F7
    db $EF, $EE, "Oh, OK, a loss is", $EF, $EE, "a loss.", $FA, $F7
    db $EF, $EE, "Here's my best", $EF, $EE, "Magic Key.", $FA, $F7
    db $EF, $EE, $A4, "Your key ring's", $EF, $EE, "full. Later, then.", $F7
    db $F0

Data_096_6146:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Tch, right", $F1
    db "to the end I could", $FA, $F7
    db $EF, $EE, "never beat you,", $EF, $EE, $F9, "0.", $FA, $F7
    db $EF, $EE, "I don't have any", $EF, $EE, "more rare keys,", $FA, $F7
    db $EF, $EE, "but we should keep", $EF, $EE, "battling.", $FA, $F7
    db $EF, $EE, "After all, we're", $EF, $EE, "still rivals!", $F7
    db $F0

Data_096_61ED:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "I was thinking", $A4, $FA, $F7
    db $EF, $EE, "GreatLog isn't in", $EF, $EE, "danger anymore.", $FA, $F7
    db $EF, $EE, "It doesn't matter", $EF, $EE, "if I'm not here.", $FA, $F7
    db $EF, $EE, "I want to go on a", $EF, $EE, "journey, warooh!", $FA, $F7
    db $EF, $EE, "Will you take me", $EF, $EE, "with you, warooh?", $FA, $F7
    db $EF, $EE, "Oh? But there's no", $EF, $EE, "room for me", $A4, $F7
    db $F0

Data_096_62CB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "I was thinking", $A4, $FA, $F7
    db $EF, $EE, "GreatLog isn't in", $EF, $EE, "danger anymore.", $FA, $F7
    db $EF, $EE, "It doesn't matter", $EF, $EE, "if I'm not here.", $FA, $F7
    db $EF, $EE, "I want to go on a", $EF, $EE, "journey, warooh!", $FA, $F7
    db $EF, $EE, "Will you take me", $EF, $EE, "with you, warooh?"
    db $FF, $F0

Data_096_6386:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Good, good, good!", $FA, $F7
    db $EF, $EE, "I knew I could", $EF, $EE, "count on you!", $FA, $F7
    db $EF, $EE, "Wa-hey, Petibou", $EF, $EE, "come here!", $F7
    db $F0

Data_096_63EB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " What?", $F1
    db "This little kid?", $FA, $F7
    db $EF, $EE, "This is really a", $EF, $EE, "monster master?", $FA, $F7
    db $EF, $EE, "But Papa said so,", $EF, $EE, "so I'll do it.", $F7
    db $F0

Data_096_6456:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "my kid has a big", $FA, $F7
    db $EF, $EE, "mouth, but Petibou", $EF, $EE, "will be useful.", $FA, $F7
    db $EF, $EE, "I will be at the", $EF, $EE, "farm, warooh.", $F7
    db $F0

Data_096_64C4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Petibou", $A3, " It's sort", $F1
    db "of boring guarding", $FA, $F7
    db $EF, $EE, "the Log's Navel", $EF, $EE, "like this", $A4, $FA, $F7
    db $EF, $EE, "Maybe I'll pull", $EF, $EE, "out the plug", $A4, $FA, $F7
    db $EF, $EE, "I'm joking! Tch,", $EF, $EE, "you look scary!", $F7
    db $F0

Data_096_654E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You need to", $F1
    db "strike the right", $FA, $F7
    db $EF, $EE, "balance of skills", $EF, $EE, "and abilities.", $FA, $F7
    db $EF, $EE, "That's important", $EF, $EE, "for winning!", $F7
    db $F0

Data_096_65B5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Humph", $A4, $F1
    db "I'm Terry.", $FA, $F7
    db $EF, $EE, "I'm a master from", $EF, $EE, "GreatTree.", $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " heard about", $EF, $EE, "GreatLog's heroic", $FA, $F7
    db $EF, $EE, "master, so I came", $EF, $EE, "to look.", $FA, $F7
    db $EF, $EE, "Are you that", $EF, $EE, "master?", $FA, $F7
    db $EF, $EE, "I can't tell by", $EF, $EE, "the way you look,", $FA, $F7
    db $EF, $EE, "but a battle will", $EF, $EE, "prove it.", $FA, $F7
    db $EF, $EE, "Do you feel like", $EF, $EE, "battling me?"
    db $FF, $F0

Data_096_66AD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " Humph", $A4, $F1
    db "Confident, huh?", $FA, $F7
    db $EF, $EE, "I'll tell you", $EF, $EE, "right now, I'm", $FA, $F7
    db $EF, $EE, "pretty confident", $EF, $EE, "too.", $FA, $F7
    db $EF, $EE, "I'll see you in", $EF, $EE, "the ring.", $F7
    db $F0

Data_096_6723:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " Oh, it was", $F1
    db "someone else?", $FA, $F7
    db $EF, $EE, "So much for my", $EF, $EE, "instinct.", $FA, $F7
    db $EF, $EE, "I was looking", $EF, $EE, "forward to seeing", $FA, $F7
    db $EF, $EE, "GreatLog's savior", $EF, $EE, "in battle.", $F7
    db $F0

Data_096_67A6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " heard", $F1
    db "about GreatLog's", $FA, $F7
    db $EF, $EE, "heroic master, so", $EF, $EE, "I came to look.", $FA, $F7
    db $EF, $EE, "Are you that", $EF, $EE, "master?", $FA, $F7
    db $EF, $EE, "I can't tell by", $EF, $EE, "the way you look,", $FA, $F7
    db $EF, $EE, "but a battle will", $EF, $EE, "prove it.", $FA, $F7
    db $EF, $EE, "Do you feel like", $EF, $EE, "battling me?"
    db $FF, $F0

Data_096_686E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " Well, this", $F1
    db "proves that I have", $FA, $F7
    db $EF, $EE, "lots to learn", $EF, $EE, "still.", $FA, $F7
    db $EF, $EE, "I hope you'll stay", $EF, $EE, "a good rival.", $FA, $F7
    db $EF, $EE, "If it's all right", $EF, $EE, "with you, we ought", $FA, $F7
    db $EF, $EE, "to breed our", $EF, $EE, "monsters sometime.", $F7
    db $F0

Data_096_691E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " Humph", $A4, $F1
    db "Don't take it hard.", $FA, $F7
    db $EF, $EE, "You really weren't", $EF, $EE, "weak.", $FA, $F7
    db $EF, $EE, "I was just a bit", $EF, $EE, "better, that's all.", $F7
    db $F0

Data_096_6985:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Terry", $A3, " I hope", $F1
    db "you'll stay a good", $FA, $F7
    db $EF, $EE, "rival of mine", $EF, $EE, "after this.", $FA, $F7
    db $EF, $EE, "If it's all right", $EF, $EE, "with you, we ought", $FA, $F7
    db $EF, $EE, "to breed our", $EF, $EE, "monsters sometime.", $F7
    db $F0

Data_096_6A11:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There are still", $F1
    db "many things that I", $FA, $F7
    db $EF, $EE, "know nothing about", $EF, $EE, "in the world.", $FA, $F7
    db $EF, $EE, "That's why life is", $EF, $EE, "so exciting.", $FA, $F7
    db $EF, $EE, "I'm not calling it", $EF, $EE, "quits yet!", $F7
    db $F0

Data_096_6AA1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "Baffle Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_096_6AC2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 found a", $F1
    db "Magic Key.", $FA, $F7
    db $EF, $EE, "But the key ring", $EF, $EE, "is full.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Magic Key back.", $F7
    db $F0

Data_096_6B16:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "Soul Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_096_6B35:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 found a", $F1
    db "Magic Key.", $FA, $F7
    db $EF, $EE, "But the key ring", $EF, $EE, "is full.", $FA, $F7
    db $EF, $EE, $F9, "0 put the", $EF, $EE, "Magic Key back.", $F7
    db $F0

Data_096_6B89:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " GreatLog appears", $F1
    db "to have returned", $FA, $F7
    db $EF, $EE, "to normal, the way", $EF, $EE, "it once was.", $FA, $F7
    db $EF, $EE, "On second thought,", $EF, $EE, "perhaps not.", $FA, $F7
    db $EF, $EE, "It looks better", $EF, $EE, "than before!", $F7
    db $F0

Data_096_6C18:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm feeling", $F1
    db "invigorated too.", $FA, $F7
    db $EF, $EE, "I want to live as", $EF, $EE, "long as GreatLog!", $F7
    db $F0

Data_096_6C60:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Ah, GreatLog's", $F1
    db "savior!", $FA, $F7
    db $EF, $EE, "Are you taking a", $EF, $EE, "break from your", $FA, $F7
    db $EF, $EE, "otherworldly", $EF, $EE, "journeys?", $FA, $F7
    db $EF, $EE, "The view from here", $EF, $EE, "is said to be the", $FA, $F7
    db $EF, $EE, "best in all", $EF, $EE, "GreatLog!", $F7
    db $F0

Data_096_6CFD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The island has", $F1
    db "become more lush", $FA, $F7
    db $EF, $EE, "and green. Thank", $EF, $EE, "you, hero!", $F7
    db $F0

Data_096_6D41:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There's something", $F1
    db "wrong with Emyu", $A4, $FA, $F7
    db $EF, $EE, "It's become a bit", $EF, $EE, "too energetic.", $FA, $F7
    db $EF, $EE, "What can I do", $EF, $EE, "about it?", $F7
    db $F0

Data_096_6DA7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, hey, hey!", $F1
    db "We have to hustle!", $FA, $F7
    db $EF, $EE, "We have to move to", $EF, $EE, "find a new groove!", $F7
    db $F0

Data_096_6DF7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How good of you", $F1
    db "to overcome those", $FA, $F7
    db $EF, $EE, "demanding trials,", $EF, $EE, "my little friend!", $FA, $F7
    db $EF, $EE, "You", $42, "e certainly", $EF, $EE, "impressed me!", $FA, $F7
    db $EF, $EE, "Take this!", $EF, $EE, "It's a gift!", $F7
    db $F0

Data_096_6E82:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained the", $F1
    db "Magic Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_096_6EA2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But there was", $F1
    db "nothing there.", $F7
    db $F0

Data_096_6EC0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Magic Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_096_6EE0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "desk.", $F7
    db $F0

Data_096_6EF6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25AEF6, $11B

; 1 call site from 1 routine (e.g. Func_00E_4001)
; reads: wC529
; writes: wC529
Func_096_7011::
    ld de, Data_096_7036
    ld a, [wC529]
    sub a, $88
    ld [wC529], a
    call Func_000_25C9
    ret

; 1 call site from 1 routine (e.g. Func_00E_4016)
; reads: wC529
; writes: wC529
Func_096_7020:: ; heuristic: follows a terminator; C0
    ld de, Data_096_7036
    ld a, [wC529]
    sub a, $88
    ld [wC529], a
    call Func_000_25FE
    ret
    db $CD, $11, $70, $CD, $11, $26, $C9

Data_096_7036:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_096_7038

Data_096_7038:: ; heuristic: target of a monotone pointer table; C0
    dw Data_096_7068
    dw Data_096_70D1
    dw Data_096_70F2
    dw Data_096_712E
    dw Data_096_716A
    dw Data_096_7191
    dw Data_096_7191
    dw Data_096_7191
    dw Data_096_7191
    dw Data_096_7191
    dw Data_096_7191
    dw Data_096_71CC
    dw Data_096_71EF
    dw Data_096_723D
    dw Data_096_7255
    dw Data_096_729D
    dw Data_096_72BA
    dw Data_096_7328
    dw Data_096_734B
    dw Data_096_738C
    dw Data_096_73C4
    dw Data_096_73E7
    dw Data_096_73E7
    dw Data_096_73E7

Data_096_7068:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, hey.", $F1
    db "Well, looky here.", $FA, $F7
    db $EF, $EE, "Something great's", $EF, $EE, "going to result.", $FA, $F7
    db $EF, $EE, "We have to let", $EF, $EE, "this pair breed.", $F0

Data_096_70D1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " OK? Let's not", $F1
    db "waste any time.", $F7
    db $F0

Data_096_70F2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " All right, we'll", $F1
    db "have to do this", $FA, $F7
    db $EF, $EE, "again another", $EF, $EE, "time.", $F7
    db $F0

Data_096_712E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0", $F1
    db "will be in your", $FA, $F7
    db $EF, $EE, "egg.", $FA, $F7
    db $EF, $EE, "Want to do this", $EF, $EE, "breeding?", $F0

Data_096_716A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Its accessory is", $F1
    db "in the Vault now.", $F7
    db $F0

Data_096_7191:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm, that's too", $F1
    db "bad, then.", $FA, $F7
    db $EF, $EE, "It's a wasted", $EF, $EE, "opportunity", $A4, $F7
    db $F0

Data_096_71CC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What will be my", $F1
    db "StoneMan's mate?", $F0

Data_096_71EF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Listen, child.", $F1
    db "How would you like", $FA, $F7
    db $EF, $EE, "to breed something", $EF, $EE, "with my StoneMan?", $F0

Data_096_723D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $37, $2B, $24, $37, $90, $3C, $32, $38, $35, $F1
    db $26, $2B, $32, $2C, $26, $28, $98, $F0

Data_096_7255:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " rather you", $F1
    db "didn't use such a ", $FA, $F7
    db $EF, $EE, "low-level monster", $EF, $EE, "for breeding.", $F7
    db $F0

Data_096_729D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You mustn't be", $F1
    db "all alone.", $F7
    db $F0

Data_096_72BA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm? Well, well.", $F1
    db "Something a little", $FA, $F7
    db $EF, $EE, "extraordinary will", $EF, $EE, "be the result.", $FA, $F7
    db $EF, $EE, "Well, do you wish", $EF, $EE, "to proceed?", $F0

Data_096_7328:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I like that", $F1
    db "reply! Let's start.", $F7
    db $F0

Data_096_734B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Thank you, my", $F1
    db "little friend!", $FA, $F7
    db $EF, $EE, "We'll have to do", $EF, $EE, "this again.", $F7
    db $F0

Data_096_738C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0", $F1
    db "will be your baby.", $FA, $F7
    db $EF, $EE, "Is that acceptable", $EF, $EE, "to you?", $F0

Data_096_73C4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Its accessory is", $F1
    db "in the Vault.", $F7
    db $F0

Data_096_73E7:: ; heuristic: target of a monotone pointer table; C0
    db $F0
    ds $C18, $00
