SECTION "Bank 2D", ROMX[$4000], BANK[$2D]
    db $2D

; 3 call sites from 3 routines (e.g. GameMode0_Update, Func_010_4AD0, Func_05F_69FB)
; reads: wStringIndex
Func_02D_4001::
    ld a, [wStringIndex]
    cp a, $D5
    jr c, Jump_02D_400F
    farcall Func_099_4001
    ret

Jump_02D_400F::
    ld de, Data_02D_4032
    call BeginStringDisplay
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
Func_02D_4016:: ; heuristic: follows a terminator; C0
    ld a, [wStringIndex]
    cp a, $D5
    jr c, Jump_02D_4024
    farcall Func_099_4010
    ret

Jump_02D_4024::
    ld de, Data_02D_4032
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_02D_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_02D_4034

Data_02D_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02D_41DE
    dw Data_02D_4265
    dw Data_02D_42FB
    dw Data_02D_43F3
    dw Data_02D_451F
    dw Data_02D_45B0
    dw Data_02D_4621
    dw Data_02D_46CA
    dw Data_02D_4731
    dw Data_02D_47A9
    dw Data_02D_482E
    dw Data_02D_4879
    dw Data_02D_4958
    dw Data_02D_499F
    dw Data_02D_4B3D
    dw Data_02D_4C61
    dw Data_02D_4CF8
    dw Data_02D_4D91
    dw Data_02D_4DF7
    dw Data_02D_4EAA
    dw Data_02D_4F38
    dw Data_02D_4F5B
    dw Data_02D_4F80
    dw Data_02D_500A
    dw Data_02D_506D
    dw Data_02D_50B6
    dw Data_02D_512D
    dw Data_02D_51BF
    dw Data_02D_5248
    dw Data_02D_52B8
    dw Data_02D_5344
    dw Data_02D_53AA
    dw Data_02D_5419
    dw Data_02D_547B
    dw Data_02D_54E7
    dw Data_02D_5569
    dw Data_02D_55F3
    dw Data_02D_563A
    dw Data_02D_5660
    dw Data_02D_56A9
    dw Data_02D_571E
    dw Data_02D_578D
    dw Data_02D_5816
    dw Data_02D_5855
    dw Data_02D_58E6
    dw Data_02D_5902
    dw Data_02D_591E
    dw Data_02D_593A
    dw Data_02D_597C
    dw Data_02D_59E7
    dw Data_02D_5A56
    dw Data_02D_5AC6
    dw Data_02D_5B11
    dw Data_02D_5B4C
    dw Data_02D_5BBA
    dw Data_02D_5C03
    dw Data_02D_5C84
    dw Data_02D_5D72
    dw Data_02D_5D90
    dw Data_02D_5DFB
    dw Data_02D_5E65
    dw Data_02D_5FA1
    dw Data_02D_600C
    dw Data_02D_6099
    dw Data_02D_60E3
    dw Data_02D_6105
    dw Data_02D_614D
    dw Data_02D_61B3
    dw Data_02D_61F1
    dw Data_02D_6210
    dw Data_02D_6251
    dw Data_02D_63B3
    dw Data_02D_63D7
    dw Data_02D_644B
    dw Data_02D_64D3
    dw Data_02D_6616
    dw Data_02D_6616
    dw Data_02D_6616
    dw Data_02D_6616
    dw Data_02D_6616
    dw Data_02D_6616
    dw Data_02D_6672
    dw Data_02D_66B3
    dw Data_02D_6716
    dw Data_02D_6738
    dw Data_02D_677F
    dw Data_02D_6806
    dw Data_02D_6900
    dw Data_02D_6BED
    dw Data_02D_6C9D
    dw Data_02D_6E3C
    dw Data_02D_6E5A
    dw Data_02D_6EDC
    dw Data_02D_6F66
    dw Data_02D_6FD2
    dw Data_02D_704B
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_7110
    dw Data_02D_714A
    dw Data_02D_7190
    dw Data_02D_71D0
    dw Data_02D_721B
    dw Data_02D_7259
    dw Data_02D_727C
    dw Data_02D_72B5
    dw Data_02D_72EE
    dw Data_02D_7335
    dw Data_02D_737A
    dw Data_02D_73BC
    dw Data_02D_73FD
    dw Data_02D_7439
    dw Data_02D_7475
    dw Data_02D_74BF
    dw Data_02D_750B
    dw Data_02D_752D
    dw Data_02D_7573
    dw Data_02D_75BB
    dw Data_02D_7606
    dw Data_02D_7623
    dw Data_02D_7645
    dw Data_02D_7680
    dw Data_02D_76A3
    dw Data_02D_76C4
    dw Data_02D_76EA
    dw Data_02D_770B
    dw Data_02D_7754
    dw Data_02D_779F
    dw Data_02D_77D9
    dw Data_02D_77FC
    dw Data_02D_783E
    dw Data_02D_788A
    dw Data_02D_78A3
    dw Data_02D_78E1
    dw Data_02D_791C
    dw Data_02D_7940
    dw Data_02D_7986
    dw Data_02D_79D0
    dw Data_02D_7A11
    dw Data_02D_7A55
    dw Data_02D_7A93
    dw Data_02D_7AB0
    dw Data_02D_7AF5
    dw Data_02D_7B30
    dw Data_02D_7B7A
    dw Data_02D_7BBE
    dw Data_02D_7BE3
    dw Data_02D_7C20
    dw Data_02D_7C40
    dw Data_02D_7C8C
    dw Data_02D_7CCF
    dw Data_02D_7CF5
    dw Data_02D_7D31
    dw Data_02D_7D6D
    dw Data_02D_7DB1
    dw Data_02D_7DD9
    dw Data_02D_7E20
    dw Data_02D_7E60
    dw Data_02D_7E94
    dw Data_02D_7EAB
    dw Data_02D_7EF2
    dw Data_02D_7F2C

Data_02D_41DE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0", $A4, " There", $F1
    db "have been frequent", $FA, $F7
    db $EF, $EE, "earthquakes on the", $EF, $EE, "island.", $FA, $F7
    db $EF, $EE, "Is it a sign of", $EF, $EE, "coming trouble?", $FA, $F7
    db $EF, $EE, "I don't want you", $EF, $EE, "wandering off", $A4, $F7
    db $F0

Data_02D_4265:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " People have been", $F1
    db "whispering that", $FA, $F7
    db $EF, $EE, "GreatLog will sink", $EF, $EE, "into the sea.", $FA, $F7
    db $EF, $EE, "It's in times like", $EF, $EE, "this that one has", $FA, $F7
    db $EF, $EE, "to be cool, calm", $EF, $EE, "and collected.", $F7
    db $F0

Data_02D_42FB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0, tell", $F1
    db "me about what", $FA, $F7
    db $EF, $EE, "you", $42, "e been seeing", $EF, $EE, "in other worlds.", $FA, $F7
    db $EF, $EE, $A4, "A monster king", $EF, $EE, "and a collector", $A4, $FA, $F7
    db $EF, $EE, "That's a weird", $EF, $EE, "combination.", $FA, $F7
    db $EF, $EE, "Over here, there", $42, "e", $EF, $EE, "been earthquakes.", $FA, $F7
    db $EF, $EE, "People think it's", $EF, $EE, "a bad omen.", $FA, $F7
    db $EF, $EE, "Anyway, what do", $EF, $EE, "you need today?", $F7
    db $F0

Data_02D_43F3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Big brother,", $F1
    db "tell me about what", $FA, $F7
    db $EF, $EE, "you", $42, "e seen in the", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "A collector king?", $EF, $EE, "And a monster?", $FA, $F7
    db $EF, $EE, "Wow, that's a very", $EF, $EE, "odd combination.", $FA, $F7
    db $EF, $EE, "There have been", $EF, $EE, "earthquakes every", $FA, $F7
    db $EF, $EE, "day here. Everyone", $EF, $EE, "has been saying", $FA, $F7
    db $EF, $EE, "GreatLog will sink", $EF, $EE, "into the sea.", $FA, $F7
    db $EF, $EE, "Anyway, do you", $EF, $EE, "need any help?", $F7
    db $F0

Data_02D_451F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If the island", $F1
    db "sink, is no worry,", $FA, $F7
    db $EF, $EE, "my friend! This", $EF, $EE, "rope save you!", $FA, $F7
    db $EF, $EE, "It climb up and up", $EF, $EE, "into the clouds!", $FA, $F7
    db $EF, $EE, "Is free to try", $EF, $EE, "now. You try!", $F7
    db $F0

Data_02D_45B0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " People have been", $F1
    db "saying that they", $FA, $F7
    db $EF, $EE, "may be able to", $EF, $EE, "survive at the top", $FA, $F7
    db $EF, $EE, "of the tree if the", $EF, $EE, "island sinks.", $F7
    db $F0

Data_02D_4621:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey! You're the", $F1
    db "kid who said the", $FA, $F7
    db $EF, $EE, "island was going", $EF, $EE, "to sink!", $FA, $F7
    db $EF, $EE, "There", $42, "e been many", $EF, $EE, "earthquakes", $A4, $FA, $F7
    db $EF, $EE, "Were you telling", $EF, $EE, "the truth?", $FA, $F7
    db $EF, $EE, "No, it can't be", $A4, $EF, $EE, "But then again", $A4, $F7
    db $F0

Data_02D_46CA:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Prince Kameha", $F1
    db "came back!", $FA, $F7
    db $EF, $EE, "What with the", $EF, $EE, "earthquakes and", $FA, $F7
    db $EF, $EE, "all, bad luck does", $EF, $EE, "come in bunches", $A4, $F7
    db $F0

Data_02D_4731:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hi! Have you", $F1
    db "heard?", $FA, $F7
    db $EF, $EE, "GreatLog is going", $EF, $EE, "to sink!", $FA, $F7
    db $EF, $EE, "I'll have to buy", $EF, $EE, "supplies and get", $FA, $F7
    db $EF, $EE, "ready for the", $EF, $EE, "disaster!", $F7
    db $F0

Data_02D_47A9:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My neighbor is", $F1
    db "buying all sorts", $FA, $F7
    db $EF, $EE, "of things in a", $EF, $EE, "panic, but", $A4, $FA, $F7
    db $EF, $EE, "What good will", $EF, $EE, "clothes or monster", $FA, $F7
    db $EF, $EE, "accessories do her", $EF, $EE, "now?", $F7
    db $F0

Data_02D_482E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When things are", $F1
    db "tough, you can't", $FA, $F7
    db $EF, $EE, "afford to panic.", $EF, $EE, "Try to stay calm.", $F7
    db $F0

Data_02D_4879:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You, ", $F9, "0,", $F1
    db "come with me!", $FA, $F7
    db $EF, $EE, "Prince Kameha"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EF, $EE, "finally returned", $FA, $F7
    db $EF, $EE, "from who knows", $EF, $EE, "where.", $FA, $F7
    db $EF, $EE, "It turns out that", $EF, $EE, "you dragged him", $FA, $F7
    db $EF, $EE, "back from another", $EF, $EE, "world.", $FA, $F7
    db $EF, $EE, "His Majesty wishes", $EF, $EE, "to see you.", $FA, $F7
    db $EF, $EE, "Come with me to", $EF, $EE, "the Castle!", $F7
    db $F0

Data_02D_4958:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My beloved", $F1
    db "island is sinking", $A4, $FA, $F7
    db $EF, $EE, "But I can't do a", $EF, $EE, "thing but watch", $A4, $F7
    db $F0

Data_02D_499F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Ah, thanks", $F1
    db "for coming!", $FA, $F7
    db $EF, $EE, "I", $42, "e heard from", $EF, $EE, "Kameha, it was", $FA, $F7
    db $EF, $EE, "you who brought", $EF, $EE, "him back.", $FA, $F7
    db $EF, $EE, "It's no wonder why", $EF, $EE, "he couldn't be", $FA, $F7
    db $EF, $EE, "found anywhere on", $EF, $EE, "the island.", $FA, $F7
    db $EF, $EE, "I'm glad that he", $EF, $EE, "was found.", $FA, $F7
    db $EF, $EE, "Take the contents", $EF, $EE, "of the chests in", $FA, $F7
    db $EF, $EE, "my chamber as my", $EF, $EE, "thanks.", $FA, $F7
    db $EF, $EE, "I hope you will", $EF, $EE, "remain a friend to", $FA, $F7
    db $EF, $EE, "Kameha. He can be", $EF, $EE, "mischievous, and", $FA, $F7
    db $EF, $EE, "get into trouble,", $EF, $EE, "but I hope you", $FA, $F7
    db $EF, $EE, "will stand by him", $EF, $EE, "as a friend.", $F7
    db $F0

Data_02D_4B3D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Kameha came", $F1
    db "back safely from", $FA, $F7
    db $EF, $EE, "another world.", $EF, $EE, "I owe it all to", $FA, $F7
    db $EF, $EE, "you, so I must", $EF, $EE, "thank you somehow.", $FA, $F7
    db $EF, $EE, "You may take the", $EF, $EE, "contents of the", $FA, $F7
    db $EF, $EE, "treasure chests in", $EF, $EE, "my chamber.", $FA, $F7
    db $EF, $EE, "I hope you will", $EF, $EE, "remain a friend to", $FA, $F7
    db $EF, $EE, "Kameha. He has few", $EF, $EE, "friends his age.", $FA, $F7
    db $EF, $EE, "I'm sure that he", $EF, $EE, "is lonely.", $F7
    db $F0

Data_02D_4C61:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " There have", $F1
    db "been many quakes.", $FA, $F7
    db $EF, $EE, "I hope nothing", $EF, $EE, "will come of them.", $FA, $F7
    db $EF, $EE, "Our people can't", $EF, $EE, "live in security", $FA, $F7
    db $EF, $EE, "with that weighing", $EF, $EE, "on their minds.", $F7
    db $F0

Data_02D_4CF8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The frequent", $F1
    db "quakes have raised", $FA, $F7
    db $EF, $EE, "grave concerns", $EF, $EE, "among the people.", $FA, $F7
    db $EF, $EE, "Our investigations", $EF, $EE, "have so far failed", $FA, $F7
    db $EF, $EE, "to identify what", $EF, $EE, "is causing them.", $F7
    db $F0

Data_02D_4D91:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Beyond here is", $F1
    db "his Majesty and", $FA, $F7
    db $EF, $EE, "Prince Kameha's", $EF, $EE, "chamber.", $FA, $F7
    db $EF, $EE, "I", $42, "e received word", $EF, $EE, "to let you pass.", $F7
    db $F0

Data_02D_4DF7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Yo, ", $F9, "0.", $F1
    db "Thanks for coming.", $FA, $F7
    db $EF, $EE, "Pop's got his eye", $EF, $EE, "on me, so I", $FA, $F7
    db $EF, $EE, "can't get out of", $EF, $EE, "here now, but I'll", $FA, $F7
    db $EF, $EE, "get out to other", $EF, $EE, "worlds again!", $FA, $F7
    db $EF, $EE, "That's a promise.", $EF, $EE, "You just wait!", $F7
    db $F0

Data_02D_4EAA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm a scientist.", $F1
    db "I", $42, "e been studying", $FA, $F7
    db $EF, $EE, "the results of", $EF, $EE, "breeding monsters.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "try breeding a", $FA, $F7
    db $EF, $EE, "monster with my", $EF, $EE, "Gulpple?"
    db $FF, $F0

Data_02D_4F38:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Well, let's see", $F1
    db "about breeding!", $F7
    db $F0

Data_02D_4F5B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " Perhaps on", $F1
    db "another occasion.", $F7
    db $F0

Data_02D_4F80:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hm", $A4, " So that", $F1
    db "combination of", $FA, $F7
    db $EF, $EE, "parents results in", $EF, $EE, "this species", $A4, $FA, $F7
    db $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " better get home", $EF, $EE, "quickly and make a", $FA, $F7
    db $EF, $EE, "record of this", $EF, $EE, "finding.", $F7
    db $F0

Data_02D_500A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " GreatLog is", $F1
    db "sinking I heard,", $FA, $F7
    db $EF, $EE, "but I don't want", $EF, $EE, "to leave here.", $FA, $F7
    db $EF, $EE, "So I came up here", $EF, $EE, "for now.", $F7
    db $F0

Data_02D_506D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e never once", $F1
    db "left the island.", $FA, $F7
    db $EF, $EE, "I can't imagine", $EF, $EE, "living elsewhere.", $F7
    db $F0

Data_02D_50B6:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is a time", $F1
    db "we need Warubou's", $FA, $F7
    db $EF, $EE, "help the most.", $EF, $EE, "But I", $42, "e heard it's", $FA, $F7
    db $EF, $EE, "stuck itself in a", $EF, $EE, "hole and is", $FA, $F7
    db $EF, $EE, "playing.", $F7
    db $F0

Data_02D_512D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I didn't want to", $F1
    db "believe GreatLog", $FA, $F7
    db $EF, $EE, "is sinking, but", $EF, $EE, "seeing the changes", $FA, $F7
    db $EF, $EE, "that have been", $EF, $EE, "taking place", $A4, $FA, $F7
    db $EF, $EE, "I have no choice", $EF, $EE, "but to believe.", $F7
    db $F0

Data_02D_51BF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I won't believe", $F1
    db "that GreatLog is", $FA, $F7
    db $EF, $EE, "sinking. That just", $EF, $EE, "can't happen!", $FA, $F7
    db $EF, $EE, "It has to be one", $EF, $EE, "of Warubou's usual", $FA, $F7
    db $EF, $EE, "pranks.", $EF, $EE, "I'm convinced.", $F7
    db $F0

Data_02D_5248:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King said", $F1
    db "that GreatLog will", $FA, $F7
    db $EF, $EE, "not sink, but if", $EF, $EE, "not, what's causing", $FA, $F7
    db $EF, $EE, "all the changes on", $EF, $EE, "the island?", $F7
    db $F0

Data_02D_52B8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Everyone, please", $F1
    db "remain calm.", $FA, $F7
    db $EF, $EE, "Even if GreatLog", $EF, $EE, "were to sink, we", $FA, $F7
    db $EF, $EE, "have enough ships", $EF, $EE, "to evacuate the", $FA, $F7
    db $EF, $EE, "entire population", $EF, $EE, "easily.", $F7
    db $F0

Data_02D_5344:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The GreatLog", $F1
    db "tree appeared to", $FA, $F7
    db $EF, $EE, "be healthy", $A4, " Could", $EF, $EE, "it be at the end", $FA, $F7
    db $EF, $EE, "of its natural", $EF, $EE, "lifespan?", $F7
    db $F0

Data_02D_53AA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Right now, we", $F1
    db "are investigating", $FA, $F7
    db $EF, $EE, "what is causing", $EF, $EE, "the earthquakes.", $FA, $F7
    db $EF, $EE, "Please don't panic,", $EF, $EE, "and stay home.", $F7
    db $F0

Data_02D_5419:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I", $42, "e studied", $F1
    db "GreatLog over a", $FA, $F7
    db $EF, $EE, "long time.", $EF, $EE, "I", $42, "e never seen", $FA, $F7
    db $EF, $EE, "changes this", $EF, $EE, "profound, however.", $F7
    db $F0

Data_02D_547B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Arena is", $F1
    db "closed under the", $FA, $F7
    db $EF, $EE, "King's decree.", $EF, $EE, "The whole island", $FA, $F7
    db $EF, $EE, "is too jumpy over", $EF, $EE, "the earthquakes.", $F7
    db $F0

Data_02D_54E7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's been decided", $F1
    db "to shut down the", $FA, $F7
    db $EF, $EE, "Arena for a", $EF, $EE, "while.", $FA, $F7
    db $EF, $EE, "The rumors about", $EF, $EE, "the island sinking", $FA, $F7
    db $EF, $EE, "kept people away", $EF, $EE, "anyway.", $F7
    db $F0

Data_02D_5569:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't be fooled", $F1
    db "by those rumors", $FA, $F7
    db $EF, $EE, "about GreatLog", $EF, $EE, "sinking.", $FA, $F7
    db $EF, $EE, "We must be most", $EF, $EE, "vigilant against", $FA, $F7
    db $EF, $EE, "the horrifying", $EF, $EE, "prospect of panic.", $F7
    db $F0

Data_02D_55F3:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " He can talk", $F1
    db "tough now, but", $A4, $FA, $F7
    db $EF, $EE, "What will we do if", $EF, $EE, "GreatLog sinks?", $F7
    db $F0

Data_02D_563A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Everyone's saying", $F1
    db "GreatLog'll sink!", $F7
    db $F0

Data_02D_5660:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If GreatLog were", $F1
    db "to sink, we will", $FA, $F7
    db $EF, $EE, "keep its memory", $EF, $EE, "alive forever.", $F7
    db $F0

Data_02D_56A9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm an adult so I", $F1
    db "can live anywhere.", $FA, $F7
    db $EF, $EE, "But I feel bad for", $EF, $EE, "my granddaughter", $FA, $F7
    db $EF, $EE, "who'll have to", $EF, $EE, "leave her friends.", $F7
    db $F0

Data_02D_571E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't want to", $F1
    db "leave GreatLog!", $FA, $F7
    db $EF, $EE, "I'm not leaving my", $EF, $EE, "friends behind!", $FA, $F7
    db $EF, $EE, "If I can't take", $EF, $EE, "Butch, I'm staying!", $F7
    db $F0

Data_02D_578D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Grandpa and the", $F1
    db "others are going", $FA, $F7
    db $EF, $EE, "to evacuate from", $EF, $EE, "GreatLog", $A4, $FA, $F7
    db $EF, $EE, "But there are too", $EF, $EE, "many people", $A4, $FA, $F7
    db $EF, $EE, "They have no room", $EF, $EE, "to take me", $A4, $F7
    db $F0

Data_02D_5816:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Are you ready?", $FA, $F7
    db $EF, $EE, "Ready for Limbo?", $EF, $EE, "Warooh!"
    db $FF, $F0

Data_02D_5855:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Take the treasures", $FA, $F7
    db $EF, $EE, "that didn't work", $EF, $EE, "as the plug.", $FA, $F7
    db $EF, $EE, "Heheh, I repaired", $EF, $EE, "them and hung onto", $FA, $F7
    db $EF, $EE, "them, warooh!", $EF, $EE, "Take them now!", $F7
    db $F0

Data_02D_58E6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "TidalBell.", $F7
    db $F0

Data_02D_5902:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "HarMirror.", $F7
    db $F0

Data_02D_591E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "SkyShield.", $F7
    db $F0

Data_02D_593A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Limbo is", $F1
    db "the King's domain!", $FA, $F7
    db $EF, $EE, "You be careful,", $EF, $EE, "warooh!", $F7
    db $F0

Data_02D_597C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Take the treasures", $FA, $F7
    db $EF, $EE, "that didn't work", $EF, $EE, "as the plug.", $FA, $F7
    db $EF, $EE, $A4, "Oh? You don't have", $EF, $EE, "enough room.", $F7
    db $F0

Data_02D_59E7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "well, hurry it up!", $FA, $F7
    db $EF, $EE, "When you're ready,", $EF, $EE, "I'll give you the", $FA, $F7
    db $EF, $EE, "three treasures", $EF, $EE, "then, warooh!", $F7
    db $F0

Data_02D_5A56:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "you have to find", $FA, $F7
    db $EF, $EE, "a plug this time", $EF, $EE, "for sure, warooh!", $FA, $F7
    db $EF, $EE, "GreatLog has no", $EF, $EE, "life force left", $A4, $F7
    db $F0

Data_02D_5AC6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "you did it, ", $F9, "0!", $FA, $F7
    db $EF, $EE, "I'll share some of", $EF, $EE, "GreatLog's energy.", $F7
    db $F0

Data_02D_5B11:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " There!", $F1
    db "All healthy now!", $FA, $F7
    db $EF, $EE, "Let me see,", $EF, $EE, "warooh!", $F7
    db $F0

Data_02D_5B4C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " So this", $F1
    db "is the MagicPlug", $A4, $FA, $F7
    db $EF, $EE, "Wa-hey, ", $F9, "0,", $EF, $EE, "I believed in you!", $FA, $F7
    db $EF, $EE, "Let's see if it", $EF, $EE, "will work, warooh!", $F7
    db $F0

Data_02D_5BBA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " There!", $F1
    db "It's a perfect fit!", $FA, $F7
    db $EF, $EE, "You finally did", $EF, $EE, "it, ", $F9, "0, warooh!", $F7
    db $F0

Data_02D_5C03:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, $F1
    db "Wa-wa-hey! We were", $FA, $F7
    db $EF, $EE, "too late! The", $EF, $EE, "Navel's closed, but", $FA, $F7
    db $EF, $EE, "not enough life", $EF, $EE, "force was left to", $FA, $F7
    db $EF, $EE, "support the", $EF, $EE, "island!", $F7
    db $F0

Data_02D_5C84:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey", $A4, $F1
    db "That's it, then.", $FA, $F7
    db $EF, $EE, "There's nothing we", $EF, $EE, "can do now,", $FA, $F7
    db $EF, $EE, "warooh", $A4, " You did", $EF, $EE, "well, but maybe", $FA, $F7
    db $EF, $EE, "this is fate.", $EF, $EE, "Tell everyone to", $FA, $F7
    db $EF, $EE, "leave the island.", $EF, $EE, "I'll try to buy a", $FA, $F7
    db $EF, $EE, "little more time", $A4, $EF, $EE, "This is goodbye.", $FA, $F7
    db $EF, $EE, "Take care, ", $F9, "0.", $EF, $EE, $F7
    db $F0

Data_02D_5D72:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Get going!", $F7
    db $F0

Data_02D_5D90:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey?", $F1
    db "GreatLog's life", $FA, $F7
    db $EF, $EE, "force is coming", $EF, $EE, "back! And with", $FA, $F7
    db $EF, $EE, "such fervor! The", $EF, $EE, "Navel is sealed!", $F7
    db $F0

Data_02D_5DFB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " I thank you", $F1
    db "all for coming!", $FA, $F7
    db $EF, $EE, "Let me introduce", $EF, $EE, "you to the hero,", $FA, $F7
    db $EF, $EE, $F9, "0, the savior", $EF, $EE, "of GreatLog!", $F7
    db $F0

Data_02D_5E65:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " Even though", $F1
    db "the island's crisis", $FA, $F7
    db $EF, $EE, "was caused by", $EF, $EE, "Kameha, I'm unhappy", $FA, $F7
    db $EF, $EE, "that no one paid", $EF, $EE, "any heed to your", $FA, $F7
    db $EF, $EE, "dire warnings.", $EF, $EE, "Quite shameful.", $FA, $F7
    db $EF, $EE, "But your actions", $EF, $EE, "moved the hearts", $FA, $F7
    db $EF, $EE, "and souls of all", $EF, $EE, "of us.", $FA, $F7
    db $EF, $EE, $F9, "0, words could", $EF, $EE, "never express our", $FA, $F7
    db $EF, $EE, "feelings of thanks", $EF, $EE, "to you!", $FA, $F7
    db $EF, $EE, "Come, let us all", $EF, $EE, "celebrate!", $F7
    db $F0

Data_02D_5FA1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " GreatLog's", $F1
    db "crisis has passed.", $FA, $F7
    db $EF, $EE, "We have nothing to", $EF, $EE, "fear now!", $FA, $F7
    db $EF, $EE, "The Log's Navel", $EF, $EE, "has been plugged!", $F7
    db $F0

Data_02D_600C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I couldn't", $F1
    db "do anything, so", $FA, $F7
    db $EF, $EE, "you win, but just", $EF, $EE, "this time.", $FA, $F7
    db $EF, $EE, "But I'll take you", $EF, $EE, "on as a master", $FA, $F7
    db $EF, $EE, "next time. You be", $EF, $EE, "ready for me!", $F7
    db $F0

Data_02D_6099:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't think I", $F1
    db "was anywhere near", $FA, $F7
    db $EF, $EE, "as resourceful", $EF, $EE, "when I was a kid", $A4, $F7
    db $F0

Data_02D_60E3:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, wow! You're", $F1
    db "really famous!", $F7
    db $F0

Data_02D_6105:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I hate myself", $F1
    db "for not doing", $FA, $F7
    db $EF, $EE, "anything to help", $EF, $EE, "during the crisis.", $F7
    db $F0

Data_02D_614D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm sorry for", $F1
    db "doubting you.", $FA, $F7
    db $EF, $EE, "I'll believe you", $EF, $EE, "next time!", $FA, $F7
    db $EF, $EE, "But, I hope there", $EF, $EE, "isn't a next time!", $F7
    db $F0

Data_02D_61B3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like my", $F1
    db "grandchildren to", $FA, $F7
    db $EF, $EE, "learn something", $EF, $EE, "from you!", $F7
    db $F0

Data_02D_61F1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, $A4, "I can't eat", $F1
    db "another", $A4, " Zzz", $A4, $F7
    db $F0

Data_02D_6210:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're today's", $F1
    db "guest of honor!", $FA, $F7
    db $EF, $EE, "You can't be", $EF, $EE, "wandering here!", $F7
    db $F0

Data_02D_6251:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0,", $F1
    db "congratulations!", $FA, $F7
    db $EF, $EE, "I thought we were", $EF, $EE, "in deep trouble", $FA, $F7
    db $EF, $EE, "when the first", $EF, $EE, "Navel plug broke", $A4, $FA, $F7
    db $EF, $EE, "But you saved the", $EF, $EE, "island by teaming", $FA, $F7
    db $EF, $EE, "up with monsters!", $EF, $EE, "Good going!", $FA, $F7
    db $EF, $EE, "Wait", $A4, " Why are you", $EF, $EE, "so glum?", $FA, $F7
    db $EF, $EE, "Oh, I know, you", $42, "e", $EF, $EE, "gotten to like", $FA, $F7
    db $EF, $EE, "traveling to other", $EF, $EE, "worlds and meeting", $FA, $F7
    db $EF, $EE, "people with your", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "You're going to", $EF, $EE, "miss it, right?", $F7
    db $F0

Data_02D_63B3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hehehe, no need", $F1
    db "to worry there!", $F7
    db $F0

Data_02D_63D7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Instead of a quest", $FA, $F7
    db $EF, $EE, "for a replacement", $EF, $EE, "plug, you can go", $FA, $F7
    db $EF, $EE, "on a journey for", $EF, $EE, "yourself, warooh!", $F7
    db $F0

Data_02D_644B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " No one", $F1
    db "knows how many", $FA, $F7
    db $EF, $EE, "other worlds exist", $EF, $EE, "out there.", $FA, $F7
    db $EF, $EE, "You'll never ever", $EF, $EE, "run out of other", $FA, $F7
    db $EF, $EE, "worlds to explore,", $EF, $EE, "warooh!", $F7
    db $F0

Data_02D_64D3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " ", $F9, "0,", $F1
    db "congratulations!", $FA, $F7
    db $EF, $EE, "I was sad that no", $EF, $EE, "one would believe", $FA, $F7
    db $EF, $EE, "us, but you saved", $EF, $EE, "GreatLog with your", $FA, $F7
    db $EF, $EE, "monster friends.", $EF, $EE, "That's great!", $FA, $F7
    db $EF, $EE, "Oh? You look sort", $EF, $EE, "of sad, somehow.", $FA, $F7
    db $EF, $EE, "Oh, wait, you", $42, "e", $EF, $EE, "gotten to enjoy", $FA, $F7
    db $EF, $EE, "going to other", $EF, $EE, "worlds and meeting", $FA, $F7
    db $EF, $EE, "people with your", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "You must be sad", $EF, $EE, "that it's over.", $F7
    db $F0

Data_02D_6616:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " heard from", $F1
    db "Lord Darck, but it", $FA, $F7
    db $EF, $EE, "really was you", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Did you bring the", $EF, $EE, "treasures?"
    db $FF, $F0

Data_02D_6672:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Surprisingly", $F1
    db "obedient, are you?", $FA, $F7
    db $EF, $EE, "Hand over the", $EF, $EE, "treasures!", $F7
    db $F0

Data_02D_66B3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the TidalBell.", $FA, $F7
    db $EF, $EE, $F9, "0 handed over", $EF, $EE, "the HarMirror.", $FA, $F7
    db $EF, $EE, $F9, "0 handed over", $EF, $EE, "the SkyShield.", $F7
    db $F0

Data_02D_6716:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Take these to", $F1
    db "Lord Darck now.", $F7
    db $F0

Data_02D_6738:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My work is done", $A4, $F1
    db "I am now free to", $FA, $F7
    db $EF, $EE, "fight you without", $EF, $EE, "restraint!", $F7
    db $F0

Data_02D_677F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You seem to", $F1
    db "still not realize", $FA, $F7
    db $EF, $EE, "how puny and weak", $EF, $EE, "you are.", $FA, $F7
    db $EF, $EE, "Well, I will", $EF, $EE, "shatter your", $FA, $F7
    db $EF, $EE, "misplaced courage", $EF, $EE, "once and for all!", $F7
    db $F0

Data_02D_6806:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " N", $A4, " No", $A4, " How could", $F1
    db "my monsters lose", $A4, $FA, $F7
    db $EF, $EE, "I did just as Lord", $EF, $EE, "Darck bade me", $A4, $FA, $F7
    db $EF, $EE, "And obtained the", $EF, $EE, "treasures of the", $FA, $F7
    db $EF, $EE, "other worlds", $A4, $EF, $EE, "I did", $A4, $FA, $F7
    db $EF, $EE, "In return, he was", $EF, $EE, "supposed to give", $FA, $F7
    db $EF, $EE, "me the strongest", $EF, $EE, "monsters", $A4, " Why", $A4, $FA, $F7
    db $EF, $EE, "Why can't I beat", $EF, $EE, "your monsters?", $F7
    db $F0

Data_02D_6900:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Darck", $A3, " Fawahahah!", $F1
    db "You chased your", $FA, $F7
    db $EF, $EE, "treasures here,", $EF, $EE, "did you?", $FA, $F7
    db $EF, $EE, "Fantastic! You're", $EF, $EE, "a true collector!", $FA, $F7
    db $EF, $EE, "You see, I believe", $EF, $EE, "that there are two", $FA, $F7
    db $EF, $EE, "varieties of", $EF, $EE, "collectors.", $FA, $F7
    db $EF, $EE, "There are those", $EF, $EE, "who collect things", $FA, $F7
    db $EF, $EE, "of value only to", $EF, $EE, "themselves.", $FA, $F7
    db $EF, $EE, "And then there are", $EF, $EE, "collectors of what", $FA, $F7
    db $EF, $EE, "evokes desire and", $EF, $EE, "envy in others.", $FA, $F7
    db $EF, $EE, "Even though the", $EF, $EE, "act of collecting", $FA, $F7
    db $EF, $EE, "is the same, the", $EF, $EE, "motivation is", $FA, $F7
    db $EF, $EE, "entirely different", $EF, $EE, "for the two types.", $FA, $F7
    db $EF, $EE, "The vanity and the", $EF, $EE, "greed that lurk", $FA, $F7
    db $EF, $EE, "deep in hearts,", $EF, $EE, "when they are", $FA, $F7
    db $EF, $EE, "unleashed, they", $EF, $EE, "give me power.", $FA, $F7
    db $EF, $EE, "If you defeat me,", $EF, $EE, "the MagicPlug", $FA, $F7
    db $EF, $EE, "shall be yours.", $EF, $EE, "But, you won't.", $FA, $F7
    db $EF, $EE, "For this is where", $EF, $EE, "you die.", $FA, $F7
    db $EF, $EE, "Your despair, your", $EF, $EE, "anger, they will", $FA, $F7
    db $EF, $EE, "all make me even", $EF, $EE, "more powerful.", $FA, $F7
    db $EF, $EE, "Fwahahahahahah!", $EF, $EE, $F7
    db $F0

Data_02D_6BED:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Darck", $A3, " Fwahahahah!", $F1
    db "Bravo! Splendid!", $FA, $F7
    db $EF, $EE, "You", $42, "e come back", $EF, $EE, "again for me!", $FA, $F7
    db $EF, $EE, "You are a great", $EF, $EE, "collector!", $FA, $F7
    db $EF, $EE, "Defeat me and the", $EF, $EE, "treasure is yours!", $FA, $F7
    db $EF, $EE, "Come at me with", $EF, $EE, "everything!", $F7
    db $F0

Data_02D_6C9D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Darck", $A3, " ", $A4, "Wha", $A4, " What?", $F1
    db "How could I", $A4, $FA, $F7
    db $EF, $EE, "I see", $A4, " It was I", $EF, $EE, "who was mistaken", $A4, $FA, $F7
    db $EF, $EE, "You collected not", $EF, $EE, "out of vanity or", $FA, $F7
    db $EF, $EE, "greed. No, it was", $EF, $EE, "something else", $A4, $FA, $F7
    db $EF, $EE, "It was a different", $EF, $EE, "motive altogether", $A4, $FA, $F7
    db $EF, $EE, "One that I could", $EF, $EE, "not understand", $A4, $FA, $F7
    db $EF, $EE, "And one that did", $EF, $EE, "not give me power", $A4, $FA, $F7
    db $EF, $EE, "You are the worst", $EF, $EE, "kind of collector", $A4, $FA, $F7
    db $EF, $EE, "But you", $42, "e managed", $EF, $EE, "to collect the", $FA, $F7
    db $EF, $EE, "best partners for", $EF, $EE, "yourself", $A4, $FA, $F7
    db $EF, $EE, "Urrgh", $A4, " You win", $A4, $EF, $EE, "Open that chest", $A4, $F7
    db $F0

Data_02D_6E3C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A voice echoed", $F1
    db "from nowhere", $A4, $F7
    db $F0

Data_02D_6E5A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wa-hey! can you", $F1
    db "hear me, ", $F9, "0?", $FA, $F7
    db $EF, $EE, "You found a plug", $EF, $EE, "for the Navel!", $FA, $F7
    db $EF, $EE, "I'll bring you", $EF, $EE, "back to GreatLog!", $FA, $F7
    db $EF, $EE, "Stand still,", $EF, $EE, "warooh!", $F7
    db $F0

Data_02D_6EDC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How dare you", $F1
    db "come without the", $FA, $F7
    db $EF, $EE, "treasures", $A4, " You", $EF, $EE, "have some nerve!", $FA, $F7
    db $EF, $EE, "You're not getting", $EF, $EE, "past me without", $FA, $F7
    db $EF, $EE, "showing me the", $EF, $EE, "treasures.", $F7
    db $F0

Data_02D_6F66:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You didn't bring", $F1
    db "the treasures?", $FA, $F7
    db $EF, $EE, "Well, hurry up and", $EF, $EE, "bring them!", $FA, $F7
    db $EF, $EE, "You have only a", $EF, $EE, "little time left!", $F7
    db $F0

Data_02D_6FD2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Magic Keys", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The last keys lead", $EF, $EE, "to worlds that are", $FA, $F7
    db $EF, $EE, "inhabited by rare", $EF, $EE, "monsters.", $95, $F7
    db $F0

Data_02D_704B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Magic Keys", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE
    db $F3
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Keys that feature", $EF, $EE, "a family name,", $FA, $F7
    db $EF, $EE, "like FirstSlime", $EF, $EE, "Key, go to a world", $FA, $F7
    db $EF, $EE, "that is inhabited", $EF, $EE, "by that family.", $95, $F7
    db $F0

Data_02D_70EC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Awooh! I'm hot!", $F1
    db "Let's go already!", $F7
    db $F0

Data_02D_7110:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm going to work", $F1
    db "hard and earn", $FA, $F7
    db $EF, $EE, "myself ", $F9, "0's", $EF, $EE, "praise.", $F7
    db $F0

Data_02D_714A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm plenty good", $F1
    db "enough by myself.", $FA, $F7
    db $EF, $EE, "There is no need", $EF, $EE, "for others.", $F7
    db $F0

Data_02D_7190:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0, I will", $F1
    db "fight with my life", $FA, $F7
    db $EF, $EE, "for your honor and", $EF, $EE, "glory.", $F7
    db $F0

Data_02D_71D0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll take the", $F1
    db "point in battle!", $FA, $F7
    db $EF, $EE, "Let me take charge", $EF, $EE, "of the situation!", $F7
    db $F0

Data_02D_721B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like to see", $F1
    db "how well you can", $FA, $F7
    db $EF, $EE, "command us in", $EF, $EE, "battle.", $F7
    db $F0

Data_02D_7259:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0, how about", $F1
    db "you battle next?", $F7
    db $F0

Data_02D_727C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't need any", $F1
    db "backup.", $FA, $F7
    db $EF, $EE, "I'll just muscle", $EF, $EE, "through!", $F7
    db $F0

Data_02D_72B5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " No need for", $F1
    db "defense!", $FA, $F7
    db $EF, $EE, "Offense is what's", $EF, $EE, "important.", $F7
    db $F0

Data_02D_72EE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Watch what your", $F1
    db "opponent has", $A4, $FA, $F7
    db $EF, $EE, "Running away is a", $EF, $EE, "viable option", $A4, $F7
    db $F0

Data_02D_7335:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If I don't get", $F1
    db "an order, I won't", $FA, $F7
    db $EF, $EE, "even bother to do", $EF, $EE, "any eating!", $F7
    db $F0

Data_02D_737A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Make sure you", $F1
    db "heal me first if", $FA, $F7
    db $EF, $EE, "I'm hurt.", $EF, $EE, "Don't forget that!", $F7
    db $F0

Data_02D_73BC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " rather be", $F1
    db "tending flowers", $FA, $F7
    db $EF, $EE, "than going out", $EF, $EE, "into battle", $A4, $F7
    db $F0

Data_02D_73FD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm going to get", $F1
    db "strong and impress", $FA, $F7
    db $EF, $EE, $F9, "0. Yes, I", $EF, $EE, "will!", $F7
    db $F0

Data_02D_7439:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's OK", $A4, " I really", $F1
    db "didn't want any", $FA, $F7
    db $EF, $EE, "meat anyway,", $EF, $EE, "humph!", $F7
    db $F0

Data_02D_7475:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you have your", $F1
    db "hankie and tissue?", $FA, $F7
    db $EF, $EE, "Oh, your buttons", $EF, $EE, "are crooked.", $F7
    db $F0

Data_02D_74BF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll do as I see", $F1
    db "fit, thank you.", $FA, $F7
    db $EF, $EE, "I don't need you to", $EF, $EE, "order me around.", $F7
    db $F0

Data_02D_750B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Give me meat!", $F1
    db "Or I won't obey!", $F7
    db $F0

Data_02D_752D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In general, I am", $F1
    db "of the opinion", $FA, $F7
    db $EF, $EE, "that fighting is", $EF, $EE, "meaningless.", $F7
    db $F0

Data_02D_7573:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If worse comes", $F1
    db "to worst, I'll use", $FA, $F7
    db $EF, $EE, "a mate as a shield", $EF, $EE, "to survive.", $F7
    db $F0

Data_02D_75BB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There isn't any", $F1
    db "point begging for", $FA, $F7
    db $EF, $EE, "mercy. I have no", $EF, $EE, "pity for losers.", $F7
    db $F0

Data_02D_7606:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Um", $A4, " Uh", $A4, " Er", $A4, $F1
    db "It's nothing", $A4, $F7
    db $F0

Data_02D_7623:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Fighting isn't", $F1
    db "my idea of fun", $A4, $F7
    db $F0

Data_02D_7645:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Awah!", $F1
    db "You startled me!", $FA, $F7
    db $EF, $EE, "Please don't sneak", $EF, $EE, "up on me.", $F7
    db $F0

Data_02D_7680:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Please don't kill", $F1
    db "even enemies.", $F7
    db $F0

Data_02D_76A3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Yay! Woohoo!", $F1
    db "We're going out!", $F7
    db $F0

Data_02D_76C4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Aww", $A4, " Must we go?", $F1
    db "That's like work!", $F7
    db $F0

Data_02D_76EA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " OK! Come on!", $F1
    db $F9, "0 too, hustle!", $F7
    db $F0

Data_02D_770B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Every day, we", $F1
    db "must strive to", $FA, $F7
    db $EF, $EE, "better ourselves!", $EF, $EE, "It is relentless!", $F7
    db $F0

Data_02D_7754:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " As long as I'm", $F1
    db "around, you'll have", $FA, $F7
    db $EF, $EE, "nothing to fear", $EF, $EE, "from any monster!", $F7
    db $F0

Data_02D_779F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Together, we", $F1
    db "shall form the", $FA, $F7
    db $EF, $EE, "world's greatest", $EF, $EE, "team!", $F7
    db $F0

Data_02D_77D9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you dawdle,", $F1
    db "I'm leaving you.", $F7
    db $F0

Data_02D_77FC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Normally, you", $F1
    db "don't deserve me.", $FA, $F7
    db $EF, $EE, "Don't you dare", $EF, $EE, "forget that.", $F7
    db $F0

Data_02D_783E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If in the right", $F1
    db "mind for it, I can", $FA, $F7
    db $EF, $EE, "flip the world", $EF, $EE, "over on its axis!", $F7
    db $F0

Data_02D_788A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I make my own", $F1
    db "roads!", $F7
    db $F0

Data_02D_78A3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Charge, charge,", $F1
    db "charge!", $FA, $F7
    db $EF, $EE, "There's no turning", $EF, $EE, "back, ever!", $F7
    db $F0

Data_02D_78E1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm looking", $F1
    db "forward to going", $FA, $F7
    db $EF, $EE, "on a journey with", $EF, $EE, "you.", $F7
    db $F0

Data_02D_791C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We have to stick", $F1
    db "to a schedule!", $F7
    db $F0

Data_02D_7940:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I need to do", $F1
    db "things at my pace.", $FA, $F7
    db $EF, $EE, "My rhythm gets so", $EF, $EE, "thrown off", $A4, $F7
    db $F0

Data_02D_7986:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Three meals and", $F1
    db "adequate sleep.", $FA, $F7
    db $EF, $EE, "That's all I need", $EF, $EE, "to be satisfied.", $F7
    db $F0

Data_02D_79D0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This adventure", $F1
    db "is exciting!", $FA, $F7
    db $EF, $EE, "Because I get to", $EF, $EE, "go with ", $F9, "0!", $F7
    db $F0

Data_02D_7A11:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't pay any", $F1
    db "heed to me.", $FA, $F7
    db $EF, $EE, "I'll do whatever I", $EF, $EE, "must for myself.", $F7
    db $F0

Data_02D_7A55:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0", $A4, " I must", $F1
    db "say this", $A4, $FA, $F7
    db $EF, $EE, "Your clothes are", $EF, $EE, "out of fashion.", $F7
    db $F0

Data_02D_7A93:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm not good", $F1
    db "with combos", $A4, $F7
    db $F0

Data_02D_7AB0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If I don't want", $F1
    db "to do something,", $FA, $F7
    db $EF, $EE, "you'll never get", $EF, $EE, "me to do it", $A4, $F7
    db $F0

Data_02D_7AF5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll think up", $F1
    db "new plans!", $FA, $F7
    db $EF, $EE, "I'll teach them to", $EF, $EE, "you, ", $F9, "0!", $F7
    db $F0

Data_02D_7B30:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $95, "Dirty", $95, " is just", $F1
    db "another way of", $FA, $F7
    db $EF, $EE, "saying 'shockingly", $EF, $EE, "effective,", $95, " pal.", $F7
    db $F0

Data_02D_7B7A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you pull your", $F1
    db "punches, you'll be", $FA, $F7
    db $EF, $EE, "sure to regret it", $EF, $EE, "later.", $F7
    db $F0

Data_02D_7BBE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't talk to me", $A4, $F1
    db "I don't like it", $A4, $F7
    db $F0

Data_02D_7BE3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0, you sure", $F1
    db "work hard!", $FA, $F7
    db $EF, $EE, "You're just a", $EF, $EE, "little kid too!", $F7
    db $F0

Data_02D_7C20:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Let's stay away", $F1
    db "from danger.", $F7
    db $F0

Data_02D_7C40:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wouldn't it be", $F1
    db "nice if everyone,", $FA, $F7
    db $EF, $EE, "even our enemies,", $EF, $EE, "could be friends?", $F7
    db $F0

Data_02D_7C8C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, the weather", $F1
    db "is so gorgeous!", $FA, $F7
    db $EF, $EE, "We should go for a", $EF, $EE, "picnic!", $F7
    db $F0

Data_02D_7CCF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't want to", $F1
    db "chat. Leave me be.", $F7
    db $F0

Data_02D_7CF5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0! Let's get", $F1
    db "moving quick!", $FA, $F7
    db $EF, $EE, "I relish this", $EF, $EE, "challenge!", $F7
    db $F0

Data_02D_7D31:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " For tomorrow's", $F1
    db "victories,", $FA, $F7
    db $EF, $EE, "I'll spare no", $EF, $EE, "effort today!", $F7
    db $F0

Data_02D_7D6D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Check out this", $F1
    db "physique!", $FA, $F7
    db $EF, $EE, "Now this is what", $EF, $EE, "you call refined!", $F7
    db $F0

Data_02D_7DB1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In battle, every", $F1
    db "second is a drama!", $F7
    db $F0

Data_02D_7DD9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7DD9, $47

Data_02D_7E20:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh? This human", $F1
    db "presumes to order", $FA, $F7
    db $EF, $EE, "me around?", $EF, $EE, "How absurd.", $F7
    db $F0

Data_02D_7E60:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " No mercy needed", $F1
    db "for enemies!", $FA, $F7
    db $EF, $EE, "Smash", $95, "em all!", $EF, $EE, $F7
    db $F0

Data_02D_7E94:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $17, $32, $90, $2A, $38, $37, $36, $AB, $F1, $31, $32, $90, $2A
    db $2F, $32, $35, $3C, $99, $F7, $F0

Data_02D_7EAB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Even if there", $F1
    db "were a hundred", $FA, $F7
    db $EF, $EE, "enemies, I will", $EF, $EE, "keep marching on!", $F7
    db $F0

Data_02D_7EF2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If I can get", $F1
    db "luck on my side,", $FA, $F7
    db $EF, $EE, "I can win them", $EF, $EE, "all.", $F7
    db $F0

Data_02D_7F2C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Master, there", $F1
    db "should be rules", $FA, $F7
    db $EF, $EE, "within our party", $EF, $EE, "to keep order!", $F7
    db $F0
    ds $8E, $00
