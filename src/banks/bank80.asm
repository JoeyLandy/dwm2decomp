SECTION "Bank 80", ROMX[$4000], BANK[$80]
    db $80

; message bank $80: when wStringIndex < $C8, BeginStringDisplay with this bank's table Data_080_4032; otherwise far-calls Func_096_4001 (E-0080)
; 3 call sites from 3 routines (e.g. GameMode0_Update_Table2_Case0A, Func_010_4AD0_Case09, ShowMessageHL_Case09)
; reads: wStringIndex
BeginStringDisplay_Bank80::
Func_080_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $C8
    jr c, Jump_080_400F
    farcall BeginStringDisplay_Bank80_Overflow
    ret

Jump_080_400F::
    ld de, MessageStrings_Bank80
    call BeginStringDisplay
    ret

; message bank $80: when wStringIndex < $C8, CopyStringToBuffer with this bank's table Data_080_4032; otherwise far-calls Func_096_4010 (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank80:: ; heuristic: follows a terminator; C0
Func_080_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $C8
    jr c, Jump_080_4024
    farcall CopyStringToBuffer_Bank80_Overflow
    ret

Jump_080_4024::
    ld de, MessageStrings_Bank80
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; string-pointer table of message bank $80: strings 0 to $C8 - 1; the rest are in MessageStrings_Bank80_Overflow (E-0080)
MessageStrings_Bank80:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_080_4032:: ; address name
    dw Data_080_4034

Data_080_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_080_41C4
    dw Data_080_41E8
    dw Data_080_4200
    dw Data_080_4324
    dw Data_080_43A3
    dw Data_080_43E1
    dw Data_080_44AF
    dw Data_080_44D3
    dw Data_080_4537
    dw Data_080_4554
    dw Data_080_4572
    dw Data_080_45FD
    dw Data_080_4675
    dw Data_080_46E1
    dw Data_080_4771
    dw Data_080_47E1
    dw Data_080_4868
    dw Data_080_48CE
    dw Data_080_4955
    dw Data_080_49C1
    dw Data_080_4A4A
    dw Data_080_4A8C
    dw Data_080_4B00
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4BD2
    dw Data_080_4C3B
    dw Data_080_4CF3
    dw Data_080_4D0F
    dw Data_080_4D2A
    dw Data_080_4D93
    dw Data_080_4DAE
    dw Data_080_4DD3
    dw Data_080_4E19
    dw Data_080_4E36
    dw Data_080_4E81
    dw Data_080_4EF0
    dw Data_080_4F36
    dw Data_080_4F53
    dw Data_080_4F78
    dw Data_080_4FAE
    dw Data_080_50A8
    dw Data_080_51BC
    dw Data_080_524D
    dw Data_080_52E9
    dw Data_080_536F
    dw Data_080_53B2
    dw Data_080_54AC
    dw Data_080_550D
    dw Data_080_5576
    dw Data_080_55DB
    dw Data_080_561F
    dw Data_080_578D
    dw Data_080_581A
    dw Data_080_589A
    dw Data_080_596D
    dw Data_080_59D5
    dw Data_080_5A16
    dw Data_080_5A99
    dw Data_080_5B25
    dw Data_080_5C24
    dw Data_080_5CCB
    dw Data_080_5DA4
    dw Data_080_5E6E
    dw Data_080_5E88
    dw Data_080_5EA7
    dw Data_080_5F14
    dw Data_080_5F77
    dw Data_080_5FFE
    dw Data_080_60AB
    dw Data_080_6167
    dw Data_080_627A
    dw Data_080_62AE
    dw Data_080_62DE
    dw Data_080_639F
    dw Data_080_6406
    dw Data_080_6441
    dw Data_080_6480
    dw Data_080_649D
    dw Data_080_64C0
    dw Data_080_6509
    dw Data_080_6573
    dw Data_080_65CB
    dw Data_080_65E3
    dw Data_080_662B
    dw Data_080_668A
    dw Data_080_66C6
    dw Data_080_66E0
    dw Data_080_673C
    dw Data_080_6781
    dw Data_080_6801
    dw Data_080_6843
    dw Data_080_68B6
    dw Data_080_68F8
    dw Data_080_6967
    dw Data_080_6A08
    dw Data_080_6AB3
    dw Data_080_6B18
    dw Data_080_6B7D
    dw Data_080_6BC7
    dw Data_080_6C49
    dw Data_080_6C8C
    dw Data_080_6D71
    dw Data_080_6DBB
    dw Data_080_6E46
    dw Data_080_6EA6
    dw Data_080_6EF9
    dw Data_080_6F70
    dw Data_080_6FBA
    dw Data_080_704B
    dw Data_080_7086
    dw Data_080_710F
    dw Data_080_7149
    dw Data_080_7208
    dw Data_080_7226
    dw Data_080_726E
    dw Data_080_73B0
    dw Data_080_73F5
    dw Data_080_74A1
    dw Data_080_757D
    dw Data_080_7602
    dw Data_080_7675
    dw Data_080_76E4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_7881
    dw Data_080_78BC
    dw Data_080_78D3
    dw Data_080_78D3
    dw Data_080_793E
    dw Data_080_795C
    dw Data_080_797F
    dw Data_080_79B9
    dw Data_080_7AB7
    dw Data_080_7B81
    dw Data_080_7BC5
    dw Data_080_7C91
    dw Data_080_7D5F
    dw Data_080_7DE6
    dw Data_080_7E07
    dw Data_080_7E40
    dw Data_080_7EC7
    dw Data_080_7F80

Data_080_41C4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen has", $F1
    db "become healthy.", $F7
    db $F0

Data_080_41E8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "shield.", $F7
    db $F0

Data_080_4200:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " So it was you", $F1
    db "holding up plans", $A4, $FA, $F7
    db $EF, $EE, "The King of Limbo", $EF, $EE, "promised me strong", $FA, $F7
    db $EF, $EE, "monsters in return", $EF, $EE, "for the Sky Shield", $FA, $F7
    db $EF, $EE, "being taken from", $EF, $EE, "the elemental.", $FA, $F7
    db $EF, $EE, "Any more of your", $EF, $EE, "meddling will not", $FA, $F7
    db $EF, $EE, "be tolerated.", $EF, $EE, "You should just", $FA, $F7
    db $EF, $EE, "back off now.", $EF, $EE, "Do you really", $FA, $F7
    db $EF, $EE, "think you can", $EF, $EE, "challenge me?"
    db $FF, $F0

Data_080_4324:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Tch, obstinate", $F1
    db "and foolish.", $FA, $F7
    db $EF, $EE, "You need to be", $EF, $EE, "taught a lesson.", $FA, $F7
    db $EF, $EE, "Come hither, my", $EF, $EE, "faithful fiends!", $FA, $F7
    db $EF, $EE, "Crush this fool!", $EF, $EE, $F7
    db $F0

Data_080_43A3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wha", $A4, " No!", $F1
    db "My monsters!", $FA, $F7
    db $EF, $EE, "It won't be this", $EF, $EE, "easy next time!", $F7
    db $F0

Data_080_43E1:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I bore witness", $F1
    db "to it all", $A4, $FA, $F7
    db $EF, $EE, "Your work has", $EF, $EE, "lifted the dark", $FA, $F7
    db $EF, $EE, "shadow that lay", $EF, $EE, "over this world.", $FA, $F7
    db $EF, $EE, "Peace should be", $EF, $EE, "quick to return.", $FA, $F7
    db $EF, $EE, "You no longer need", $EF, $EE, "the Crest.", $FA, $F7
    db $EF, $EE, "Throw it back into", $EF, $EE, "my spring.", $F7
    db $F0

Data_080_44AF:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Throw the Crest", $F1
    db "into my spring.", $F7
    db $F0

Data_080_44D3:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Kingdoms", $F1
    db "should return to", $FA, $F7
    db $EF, $EE, "their peaceful", $EF, $EE, "states.", $FA, $F7
    db $EF, $EE, "As my thanks, take", $EF, $EE, "the Sky Shield.", $F7
    db $F0

Data_080_4537:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "the Sky Shield.", $F7
    db $F0

Data_080_4554:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A voice echoed", $F1
    db "from nowhere", $A4, $F7
    db $F0

Data_080_4572:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Wa-hey! ", $F9, "0,", $F1
    db "can you hear me?", $FA, $F7
    db $EF, $EE, "I felt an odd", $EF, $EE, "power stirring.", $FA, $F7
    db $EF, $EE, "You found a plug", $EF, $EE, "for the Navel!", $FA, $F7
    db $EF, $EE, "I'll bring you", $EF, $EE, "back! Don't move!", $F7
    db $F0

Data_080_45FD:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The spirit's", $F1
    db "spring in the", $FA, $F7
    db $EF, $EE, "north isn't icy", $EF, $EE, "anymore.", $FA, $F7
    db $EF, $EE, "However cold it", $EF, $EE, "may be, spring", $FA, $F7
    db $EF, $EE, "always comes, I", $EF, $EE, "guess.", $F7
    db $F0

Data_080_4675:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The ice blocking", $F1
    db "the harbor finally", $FA, $F7
    db $EF, $EE, "broke up and", $EF, $EE, "melted away.", $FA, $F7
    db $EF, $EE, "We can get back to", $EF, $EE, "sailing again!", $F7
    db $F0

Data_080_46E1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The long winter", $F1
    db "seems to be over.", $FA, $F7
    db $EF, $EE, "It feels a little", $EF, $EE, "warmer now.", $FA, $F7
    db $EF, $EE, "It's the perfect", $EF, $EE, "occasion for a", $FA, $F7
    db $EF, $EE, "celebration drink", $EF, $EE, "at the tavern.", $F7
    db $F0

Data_080_4771:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " We were visiting", $F1
    db "from the east.", $FA, $F7
    db $EF, $EE, "We found things to", $EF, $EE, "be good here, so", $FA, $F7
    db $EF, $EE, "we", $42, "e decided to", $EF, $EE, "make this home.", $F7
    db $F0

Data_080_47E1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When the harbor's", $F1
    db "ice disappeared,", $FA, $F7
    db $EF, $EE, "the sailors went", $EF, $EE, "away with it", $A4, $FA, $F7
    db $EF, $EE, "The tavern's not", $EF, $EE, "earning money.", $FA, $F7
    db $EF, $EE, "I'm still feeling", $EF, $EE, "blue", $A4, $F7
    db $F0

Data_080_4868:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome! Oh?", $F1
    db "Hi, there!", $FA, $F7
    db $EF, $EE, "Well, you're a bit", $EF, $EE, "too young, but", $A4, $FA, $F7
    db $EF, $EE, "Since it's quiet,", $EF, $EE, "you're welcome.", $F7
    db $F0

Data_080_48CE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The eastern", $F1
    db "kingdom's castle", $FA, $F7
    db $EF, $EE, "is across the sea", $EF, $EE, "from here.", $FA, $F7
    db $EF, $EE, "Rumor has it that", $EF, $EE, "Queen Helen has", $FA, $F7
    db $EF, $EE, "recovered from her", $EF, $EE, "illness.", $F7
    db $F0

Data_080_4955:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The harbor has", $F1
    db "been busy with", $FA, $F7
    db $EF, $EE, "boats coming and", $EF, $EE, "going recently.", $FA, $F7
    db $EF, $EE, "I wonder how all", $EF, $EE, "the ice melted.", $F7
    db $F0

Data_080_49C1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The piled up ice", $F1
    db "floes disappeared", $FA, $F7
    db $EF, $EE, "from the harbor", $EF, $EE, "just like that.", $FA, $F7
    db $EF, $EE, "The elemental in", $EF, $EE, "the spring must", $FA, $F7
    db $EF, $EE, "have done it for", $EF, $EE, "us.", $F7
    db $F0

Data_080_4A4A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The warm weather", $F1
    db "melted the ice in", $FA, $F7
    db $EF, $EE, "the elemental's", $EF, $EE, "spring.", $F7
    db $F0

Data_080_4A8C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The scholar came", $F1
    db "back finally from", $FA, $F7
    db $EF, $EE, "his research trip.", $EF, $EE, "Who knows where he", $FA, $F7
    db $EF, $EE, "could have been", $EF, $EE, "all this time!", $F7
    db $F0

Data_080_4B00:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My maid is angry", $F1
    db "that I left the", $FA, $F7
    db $EF, $EE, "house vacant for", $EF, $EE, "so long.", $FA, $F7
    db $EF, $EE, "I wasn't wandering", $EF, $EE, "aimlessly, but", $A4, $F7
    db $F0

Data_080_4B69:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Father dug under", $F1
    db "the island, and he", $FA, $F7
    db $EF, $EE, "made a stable for", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "You can make them", $EF, $EE, "sleep now.", $F7
    db $F0

Data_080_4BD2:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I was going to", $F1
    db "ask Cobi, but I", $FA, $F7
    db $EF, $EE, "think you could do", $EF, $EE, "this, ", $F9, "0.", $FA, $F7
    db $EF, $EE, "Could you find", $EF, $EE, "something for me?"
    db $FF, $F0

Data_080_4C3B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The farm that", $F1
    db "your father always", $FA, $F7
    db $EF, $EE, "dreamed about is", $EF, $EE, "finally completed.", $FA, $F7
    db $EF, $EE, "I want to have a", $EF, $EE, "nice dinner to", $FA, $F7
    db $EF, $EE, "celebrate, so I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EF, $EE, "like some Sirloin.", $FA, $F7
    db $EF, $EE, "Please go buy some", $EF, $EE, "for me.", $F7
    db $F0

Data_080_4CF3:: ; heuristic: target of a monotone pointer table; C0
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Mama handed over", $F1
    db "1,200G.", $F7
    db $F0

Data_080_4D0F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " Then I'll", $F1
    db "ask Cobi.", $F7
    db $F0

Data_080_4D2A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I was going to", $F1
    db "ask Tara, but you", $FA, $F7
    db $EF, $EE, "could do this", $EF, $EE, "instead, ", $F9, "0.", $FA, $F7
    db $EF, $EE, "Could you find", $EF, $EE, "something for me?"
    db $FF, $F0

Data_080_4D93:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " Then I'll", $F1
    db "ask Tara.", $F7
    db $F0

Data_080_4DAE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Buy some Sirloin", $F1
    db "for our dinner.", $F7
    db $F0

Data_080_4DD3:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " They didn't have", $F1
    db "any around here.", $FA, $F7
    db $EF, $EE, "I'm surprised you", $EF, $EE, "found this.", $F7
    db $F0

Data_080_4E19:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Sirloin.", $F7
    db $F0

Data_080_4E36:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I don't have any", $F1
    db "errands right now.", $FA, $F7
    db $EF, $EE, "I'll ask if there's", $EF, $EE, "anything, ", $F9, "0.", $F7
    db $F0

Data_080_4E81:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " MadGopher helped", $F1
    db "me excavate.", $FA, $F7
    db $EF, $EE, "Look at the great", $EF, $EE, "stable we made!", $FA, $F7
    db $EF, $EE, "My dream farm is", $EF, $EE, "finally finished!", $F7
    db $F0

Data_080_4EF0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Whew. I'm done", $F1
    db "working finally.", $FA, $F7
    db $EF, $EE, "Can you take me", $EF, $EE, "out somewhere?"
    db $FF, $F0

Data_080_4F36:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You will?", $F1
    db "I'll cut loose!", $F7
    db $F0

Data_080_4F53:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, but you have", $F1
    db "no room for me", $A4, $F7
    db $F0

Data_080_4F78:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, don't be", $F1
    db "that way.", $FA, $F7
    db $EF, $EE, "I'm sure I can", $EF, $EE, "help you.", $F7
    db $F0

Data_080_4FAE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0, what", $F1
    db "was it like in the", $FA, $F7
    db $EF, $EE, "other worlds?", $EF, $EE, "I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " like to know.", $FA, $F7
    db $EF, $EE, $A4, "You met an", $EF, $EE, "elemental spirit?", $FA, $F7
    db $EF, $EE, "Wow. I wish I got", $EF, $EE, "to meet her.", $FA, $F7
    db $EF, $EE, "Papa made a stable", $EF, $EE, "under the island,", $FA, $F7
    db $EF, $EE, "so monsters can go", $EF, $EE, "to sleep.", $FA, $F7
    db $EF, $EE, "So, what can I do", $EF, $EE, "for you, sis?", $F7
    db $F0

Data_080_50A8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Tara", $A3, " Big brother,", $F1
    db "tell me about what", $FA, $F7
    db $EF, $EE, "you", $42, "e seen in the", $EF, $EE, "other worlds.", $FA, $F7
    db $EF, $EE, "An elemental in a", $EF, $EE, "spring?", $FA, $F7
    db $EF, $EE, "Was she really", $EF, $EE, "pretty?", $FA, $F7
    db $EF, $EE, $A4, "Big brother, lose", $EF, $EE, "that smirk!", $FA, $F7
    db $EF, $EE, "Papa made a stable", $EF, $EE, "under the island,", $FA, $F7
    db $EF, $EE, "so monsters can go", $EF, $EE, "to sleep.", $FA, $F7
    db $EF, $EE, "Anyway, do you", $EF, $EE, "need any help?", $F7
    db $F0

Data_080_51BC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There are powers", $F1
    db "that let you cross", $FA, $F7
    db $EF, $EE, "the sea or fly up", $EF, $EE, "in the sky.", $FA, $F7
    db $EF, $EE, "If you get such", $EF, $EE, "powers, face the", $FA, $F7
    db $EF, $EE, "sea or sky and", $EF, $EE, "push a button!", $F7
    db $F0

Data_080_524D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Have you been to", $F1
    db "the Starry Shrine?", $FA, $F7
    db $EF, $EE, "Breeding toughens", $EF, $EE, "up monsters.", $FA, $F7
    db $EF, $EE, "The offspring", $EF, $EE, "inherits the", $FA, $F7
    db $EF, $EE, "stats, attributes", $EF, $EE, "and skills of", $FA, $F7
    db $EF, $EE, "parents.", $EF, $EE, $F7
    db $F0

Data_080_52E9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Uheheheh, did", $F1
    db "you know this?", $FA, $F7
    db $EF, $EE, "Zombies like me", $EF, $EE, "aren't bothered by", $FA, $F7
    db $EF, $EE, "death spells or", $EF, $EE, "curses.", $FA, $F7
    db $EF, $EE, "We're specialists", $EF, $EE, "in that area.", $F7
    db $F0

Data_080_536F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm a bug, so", $F1
    db "I'm not badly", $FA, $F7
    db $EF, $EE, "affected by poison", $EF, $EE, "or paralysis.", $F7
    db $F0

Data_080_53B2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Prince Kameha", $F1
    db "has been missing", $FA, $F7
    db $EF, $EE, "from the castle a", $EF, $EE, "long time", $A4, $FA, $F7
    db $EF, $EE, "The King thought", $EF, $EE, "it was another of", $FA, $F7
    db $EF, $EE, "the Prince's silly", $EF, $EE, "pranks at first,", $FA, $F7
    db $EF, $EE, "but he's worried", $EF, $EE, "and appears unable", $FA, $F7
    db $EF, $EE, "to concentrate on", $EF, $EE, "work now.", $FA, $F7
    db $EF, $EE, "Have you seen", $EF, $EE, "Prince Kameha?"
    db $FF, $F0

Data_080_54AC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What's that?", $F1
    db "You saw Prince", $FA, $F7
    db $EF, $EE, "Kameha in another", $EF, $EE, "world?", $FA, $F7
    db $EF, $EE, "Come with me to", $EF, $EE, "see his Majesty!", $F7
    db $F0

Data_080_550D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " better be", $F1
    db "telling the truth.", $FA, $F7
    db $EF, $EE, "If you see the", $EF, $EE, "Prince, you let us", $FA, $F7
    db $EF, $EE, "know right away,", $EF, $EE, "get it?", $F7
    db $F0

Data_080_5576:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The man here has", $F1
    db "rare keys.", $FA, $F7
    db $EF, $EE, "Doesn't it intrigue", $EF, $EE, "you what sort of", $FA, $F7
    db $EF, $EE, "worlds his keys", $EF, $EE, "lead to?", $F7
    db $F0

Data_080_55DB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Sire, this child", $F1
    db "claims to know", $FA, $F7
    db $EF, $EE, "Prince Kameha's", $EF, $EE, "whereabouts.", $F7
    db $F0

Data_080_561F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " What's that?", $F1
    db "Is that so?", $FA, $F7
    db $EF, $EE, "Where has Kameha", $EF, $EE, "gotten to?", $FA, $F7
    db $EF, $EE, "What?", $EF, $EE, "Another world?", $FA, $F7
    db $EF, $EE, "So the rumors were", $EF, $EE, "true", $A4, $FA, $F7
    db $EF, $EE, "No wonder he could", $EF, $EE, "not be found.", $FA, $F7
    db $EF, $EE, "Well, so long as", $EF, $EE, "he is safe, it's", $FA, $F7
    db $EF, $EE, "fine. It is quiet", $EF, $EE, "when he's absent.", $FA, $F7
    db $EF, $EE, "If you see Kameha", $EF, $EE, "again, I'll ask", $FA, $F7
    db $EF, $EE, "that you let me", $EF, $EE, "know.", $FA, $F7
    db $EF, $EE, "Ah, I should also", $EF, $EE, "give you this.", $FA, $F7
    db $EF, $EE, "It's a Magic Key", $EF, $EE, "named Sky Key.", $F7
    db $F0

Data_080_578D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " If you see", $F1
    db "Kameha again, I'll", $FA, $F7
    db $EF, $EE, "ask that you let", $EF, $EE, "me know.", $FA, $F7
    db $EF, $EE, "I realize that he", $EF, $EE, "is a mischievous", $FA, $F7
    db $EF, $EE, "handful, but I", $EF, $EE, "need your help.", $F7
    db $F0

Data_080_581A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Prince Kameha", $F1
    db "wandered off like", $FA, $F7
    db $EF, $EE, "a kite without its", $EF, $EE, "string", $A4, $FA, $F7
    db $EF, $EE, "Who did he take", $EF, $EE, "after", $A4, $FA, $F7
    db $EF, $EE, $A4, "Uh, never mind,", $EF, $EE, "ignore that!", $F7
    db $F0

Data_080_589A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You're free to", $F1
    db "go anywhere in the", $FA, $F7
    db $EF, $EE, "Castle as you see", $EF, $EE, "fit.", $FA, $F7
    db $EF, $EE, "You can visit the", $EF, $EE, "Christener on the", $FA, $F7
    db $EF, $EE, "third level to", $EF, $EE, "rename monsters.", $FA, $F7
    db $EF, $EE, "Or drop into the", $EF, $EE, "tavern on four.", $FA, $F7
    db $EF, $EE, "But don't expect", $EF, $EE, "to be served!", $F7
    db $F0

Data_080_596D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The King and", $F1
    db "Prince's chamber", $FA, $F7
    db $EF, $EE, "is beyond here.", $EF, $EE, "If I let you go", $FA, $F7
    db $EF, $EE, "through, I'll catch", $EF, $EE, "royal heck.", $F7
    db $F0

Data_080_59D5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Please enter.", $F1
    db "The King awaits", $FA, $F7
    db $EF, $EE, "you in the", $EF, $EE, "reception hall.", $F7
    db $F0

Data_080_5A16:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is GreatLog", $F1
    db "Castle.", $FA, $F7
    db $EF, $EE, "The reception hall", $EF, $EE, "is beyond here.", $FA, $F7
    db $EF, $EE, "The stairs will", $EF, $EE, "take you to the", $FA, $F7
    db $EF, $EE, "top of GreatLog's", $EF, $EE, "tree.", $F7
    db $F0

Data_080_5A99:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The tavern just", $F1
    db "outside the Castle", $FA, $F7
    db $EF, $EE, "is frequented by", $EF, $EE, "masters.", $FA, $F7
    db $EF, $EE, "They'll offer to", $EF, $EE, "breed monsters,", $FA, $F7
    db $EF, $EE, "and they'll give", $EF, $EE, "you some tips.", $F7
    db $F0

Data_080_5B25:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hey, welcome!", $F1
    db "All masters are", $FA, $F7
    db $EF, $EE, "welcome here, even", $EF, $EE, "little kids.", $FA, $F7
    db $EF, $EE, "Skilled masters", $EF, $EE, "congregate here.", $FA, $F7
    db $EF, $EE, "You might get the", $EF, $EE, "chance to breed", $FA, $F7
    db $EF, $EE, "some monsters.", $EF, $EE, "Don't miss out.", $FA, $F7
    db $EF, $EE, "Raising monsters", $EF, $EE, "alone is tough, so", $FA, $F7
    db $EF, $EE, "don't waste any", $EF, $EE, "chance to breed.", $F7
    db $F0

Data_080_5C24:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " When you breed,", $F1
    db "notice a number", $FA, $F7
    db $EF, $EE, "after a plus sign", $EF, $EE, "in the name?", $FA, $F7
    db $EF, $EE, "The higher that", $EF, $EE, "number, the more", $FA, $F7
    db $EF, $EE, "the monster can", $EF, $EE, "grow.", $FA, $F7
    db $EF, $EE, "So you can level", $EF, $EE, "it up more!", $F7
    db $F0

Data_080_5CCB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you want to", $F1
    db "make a certain", $FA, $F7
    db $EF, $EE, "species stronger,", $EF, $EE, "just breed it with", $FA, $F7
    db $EF, $EE, "a monster of the", $EF, $EE, "same family.", $FA, $F7
    db $EF, $EE, "Even though the", $EF, $EE, "species remains", $FA, $F7
    db $EF, $EE, "unchanged, the", $EF, $EE, "monster will have", $FA, $F7
    db $EF, $EE, "inherited the", $EF, $EE, "partner's powers.", $F7
    db $F0

Data_080_5DA4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'm a traveling", $F1
    db "merchant.", $FA, $F7
    db $EF, $EE, "I'm also a master", $EF, $EE, "as a hobby.", $FA, $F7
    db $EF, $EE, "Listen, would you", $EF, $EE, "like to breed", $FA, $F7
    db $EF, $EE, "something with my", $EF, $EE, "SpikyBoy?", $FA, $F7
    db $EF, $EE, "If possible, I"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EF, $EE, "like to breed mine", $FA, $F7
    db $EF, $EE, "with another", $EF, $EE, "SpikyBoy. Well?"
    db $FF, $F0

Data_080_5E6E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Then let's breed", $F1
    db "them!", $F7
    db $F0

Data_080_5E88:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, too bad.", $F1
    db "Another time.", $F7
    db $F0

Data_080_5EA7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Breeding could", $F1
    db "result in monsters", $FA, $F7
    db $EF, $EE, "with skills you", $EF, $EE, "wouldn't expect.", $FA, $F7
    db $EF, $EE, "It's an added perk", $EF, $EE, "of breeding.", $F7
    db $F0

Data_080_5F14:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " From up here", $F1
    db "people look like", $FA, $F7
    db $EF, $EE, "ants scurrying", $EF, $EE, "about, but they're", $FA, $F7
    db $EF, $EE, "not as big as", $EF, $EE, "ArmyAnts.", $F7
    db $F0

Data_080_5F77:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " On the horizon,", $F1
    db "you can see an", $FA, $F7
    db $EF, $EE, "enormous tree like", $EF, $EE, "this one.", $FA, $F7
    db $EF, $EE, "It's the Kingdom", $EF, $EE, "of GreatTree.", $FA, $F7
    db $EF, $EE, "It's GreatLog's", $EF, $EE, "rival kingdom.", $F7
    db $F0

Data_080_5FFE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " GreatLog Castle", $F1
    db "was made by", $FA, $F7
    db $EF, $EE, "hollowing out", $EF, $EE, "giant coconuts.", $FA, $F7
    db $EF, $EE, "GreatLog should", $EF, $EE, "have four in all.", $FA, $F7
    db $EF, $EE, "That means there", $EF, $EE, "must be two more", $FA, $F7
    db $EF, $EE, "coconuts below", $EF, $EE, "this level.", $F7
    db $F0

Data_080_60AB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The island used", $F1
    db "to be lush with", $FA, $F7
    db $EF, $EE, "plants, but they", $EF, $EE, "are dying slowly", $A4, $FA, $F7
    db $EF, $EE, "Will GreatLog", $EF, $EE, "suffer that way?", $FA, $F7
    db $EF, $EE, "People don't appear", $EF, $EE, "to be concerned,", $FA, $F7
    db $EF, $EE, "but something is", $EF, $EE, "going to happen", $A4, $F7
    db $F0

Data_080_6167:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello, ", $F9, "0,", $F1
    db "welcome!", $FA, $F7
    db $EF, $EE, "This is the stable", $EF, $EE, "where you can keep", $FA, $F7
    db $EF, $EE, "monsters stored,", $EF, $EE, "but hibernating.", $FA, $F7
    db $EF, $EE, "A monster won't", $EF, $EE, "gain any EX points", $FA, $F7
    db $EF, $EE, "while hibernating,", $EF, $EE, "but it also won't", $FA, $F7
    db $EF, $EE, "return to its wild", $EF, $EE, "state.", $FA, $F7
    db $EF, $EE, "Do you want to", $EF, $EE, "have a monster", $FA, $F7
    db $EF, $EE, "hibernate in the", $EF, $EE, "stable?", $F7
    db $F0

Data_080_627A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello, ", $F9, "0,", $F1
    db "welcome!", $FA, $F7
    db $EF, $EE, "Want to use the", $EF, $EE, "stable?", $F7
    db $F0

Data_080_62AE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Zzzz", $A4, " Yawn", $A4, $F1
    db "Huh?", $FA, $F7
    db $EF, $EE, "Is it morning", $EF, $EE, "already?", $F7
    db $F0

Data_080_62DE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $28, $31, $90, $24, $90, $AC
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " appears", $F1
    db "by a monster's", $FA, $F7
    db $EF, $EE, "level number, it", $EF, $EE, "stops growing.", $FA, $F7
    db $EF, $EE, "It won't learn any", $EF, $EE, "more skills too.", $FA, $F7
    db $EF, $EE, "In other words, it", $EF, $EE, "indicates that the", $FA, $F7
    db $EF, $EE, "monster has grown", $EF, $EE, "as much as it can.", $F7
    db $F0

Data_080_639F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Our kind always", $F1
    db "stays near water.", $FA, $F7
    db $EF, $EE, "Go traveling on", $EF, $EE, "water if you want", $FA, $F7
    db $EF, $EE, "to see others like", $EF, $EE, "me.", $F7
    db $F0

Data_080_6406:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Zzz", $A4, " Zzz", $A4, $F1
    db "Zzz", $A4, " Whoops!", $FA, $F7
    db $EF, $EE, "Was I breathing", $EF, $EE, "fire there?", $F7
    db $F0

Data_080_6441:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you want to", $F1
    db "know how much your", $FA, $F7
    db $EF, $EE, "companions can", $EF, $EE, "grow?"
    db $FF, $F0

Data_080_6480:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "N's growth", $F1
    db "limit is Lv ", $F9
    db $4E, $B5, $F7, $F0

Data_080_649D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "N has reached", $F1
    db "its growth limit.", $F7
    db $F0

Data_080_64C0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Once a monster", $F1
    db "reaches its growth", $FA, $F7
    db $EF, $EE, "limit, it won't", $EF, $EE, "level up anymore.", $F7
    db $F0

Data_080_6509:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Everyone has a", $F1
    db "growth limit.", $FA, $F7
    db $EF, $EE, "Whether you accept", $EF, $EE, "this or not, you", $FA, $F7
    db $EF, $EE, "can't defy the", $EF, $EE, "march of time.", $F7
    db $F0

Data_080_6573:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Ssh", $A4, " Monsters are", $EF, $EE, "sleeping.", $FA, $F7
    db $EF, $EE, "Please be quiet in", $EF, $EE, "the stable.", $95, $F7
    db $F0

Data_080_65CB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "casket.", $F7
    db $F0

Data_080_65E3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Zzz", $A4, " Use the", $F1
    db "plan ", $95, "Charge", $95, " in", $FA, $F7
    db $EF, $EE, "battle to boost", $EF, $EE, "monster courage.", $95, $F7
    db $F0

Data_080_662B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Zzz", $A4, $F1
    db "Hnnnnnrgh", $A4, " Huh?", $FA, $F7
    db $EF, $EE, "Being ", $95, "Cautious", $95, $EF, $EE, "in battle makes", $FA, $F7
    db $EF, $EE, "monsters more", $EF, $EE, "compassionate.", $F7
    db $F0

Data_080_668A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Watch your step!", $EF, $EE, "Monster at sleep!", $95, $F7
    db $F0

Data_080_66C6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the hole.", $F7
    db $F0

Data_080_66E0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Zzz", $A4, " Zzz", $A4, $F1
    db "Some skills are", $FA, $F7
    db $EF, $EE, "developed from", $EF, $EE, "skills that have", $FA, $F7
    db $EF, $EE, "been learned", $EF, $EE, "already.", $F7
    db $F0

Data_080_673C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, you're the", $F1
    db "Kids Class Champ!", $FA, $F7
    db $EF, $EE, "Want to hear", $EF, $EE, "something good?"
    db $FF, $F0

Data_080_6781:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the C Class", $F1
    db "final, you'll be", $FA, $F7
    db $EF, $EE, "facing HammerMan", $EF, $EE, "and Stubsuck.", $FA, $F7
    db $EF, $EE, "HammerMan uses", $EF, $EE, "EvilSlash.", $FA, $F7
    db $EF, $EE, "It's one tough", $EF, $EE, "customer!", $F7
    db $F0

Data_080_6801:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, you're the", $F1
    db "C Class Champ!", $FA, $F7
    db $EF, $EE, "Want to hear", $EF, $EE, "something good?"
    db $FF, $F0

Data_080_6843:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the B Class", $F1
    db "final, you'll face", $FA, $F7
    db $EF, $EE, "three monsters-", $EF, $EE, "HerbMan, DanceVegi", $FA, $F7
    db $EF, $EE, "and MudDoll. Watch", $EF, $EE, "out for Hustle!", $F7
    db $F0

Data_080_68B6:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, you're the", $F1
    db "B Class Champ!", $FA, $F7
    db $EF, $EE, "Want to hear", $EF, $EE, "something good?"
    db $FF, $F0

Data_080_68F8:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the A Class", $F1
    db "final, you'll face", $FA, $F7
    db $EF, $EE, "MistyWing, Copycat", $EF, $EE, "and NiteWhip.", $FA, $F7
    db $EF, $EE, "Watch out for the", $EF, $EE, "skill Imitate!", $F7
    db $F0

Data_080_6967:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, you're the", $F1
    db "A Class Champ!", $FA, $F7
    db $EF, $EE, "The S Class is", $EF, $EE, "next.", $FA, $F7
    db $EF, $EE, "It's the final", $EF, $EE, "battle class.", $FA, $F7
    db $EF, $EE, "It's nothing like", $EF, $EE, "what you", $42, "e seen.", $FA, $F7
    db $EF, $EE, "Want to hear", $EF, $EE, "something good?"
    db $FF, $F0

Data_080_6A08:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the S Class", $F1
    db "final, you'll face", $FA, $F7
    db $EF, $EE, "Serpentia, Orochi", $EF, $EE, "and GigaDraco.", $FA, $F7
    db $EF, $EE, "They're horribly", $EF, $EE, "strong.", $FA, $F7
    db $EF, $EE, "You'll have to", $EF, $EE, "stop their attacks", $FA, $F7
    db $EF, $EE, "to get a chance at", $EF, $EE, "winning.", $F7
    db $F0

Data_080_6AB3:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My Emyu is very", $F1
    db "timid.", $FA, $F7
    db $EF, $EE, "I", $42, "e taken it down", $EF, $EE, "to the Coliseum,", $FA, $F7
    db $EF, $EE, "but all it does is", $EF, $EE, "take cover", $A4, $F7
    db $F0

Data_080_6B18:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wow, you", $42, "e got", $F1
    db "a brave monster!", $FA, $F7
    db $EF, $EE, "Look, Emyu!", $EF, $EE, "Do you see that?", $FA, $F7
    db $EF, $EE, "That's how I want", $EF, $EE, "you to be!", $F7
    db $F0

Data_080_6B7D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Has my Emyu", $F1
    db "learned to be more", $FA, $F7
    db $EF, $EE, "brave? I really", $EF, $EE, "wonder about that", $A4, $F7
    db $F0

Data_080_6BC7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Monsters look so", $F1
    db "frightening", $A4, $FA, $F7
    db $EF, $EE, "Yes, I know, I'm", $EF, $EE, "one too, but", $A4, $FA, $F7
    db $EF, $EE, "But when one", $EF, $EE, "glares at me", $A4, $FA, $F7
    db $EF, $EE, "Just the thought", $EF, $EE, "is scary!", $F7
    db $F0

Data_080_6C49:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I should be more", $F1
    db "assertive.", $FA, $F7
    db $EF, $EE, "It's not as if I'm", $EF, $EE, "going to die.", $F7
    db $F0

Data_080_6C8C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can call me", $F1
    db "the Medal Master.", $FA, $F7
    db $EF, $EE, "I am a collector", $EF, $EE, "of TinyMedals.", $FA, $F7
    db $EF, $EE, "I only recently", $EF, $EE, "moved to GreatLog.", $FA, $F7
    db $EF, $EE, "TinyMedals are all", $EF, $EE, "over the world.", $FA, $F7
    db $EF, $EE, "If you find any,", $EF, $EE, "can you bring them", $FA, $F7
    db $EF, $EE, "to me? I'll trade", $EF, $EE, "gifts for them.", $F7
    db $F0

Data_080_6D71:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can call me", $F1
    db "the Medal Master.", $FA, $F7
    db $EF, $EE, "I am a collector", $EF, $EE, "of TinyMedals.", $F7
    db $F0

Data_080_6DBB:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " My husband loves", $F1
    db "to collect things", $FA, $F7
    db $EF, $EE, "that are of no", $EF, $EE, "value to others.", $FA, $F7
    db $EF, $EE, "TinyMedals are", $EF, $EE, "what he's after", $FA, $F7
    db $EF, $EE, "right now.", $EF, $EE, "It's a passion!", $F7
    db $F0

Data_080_6E46:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I like making", $F1
    db "the Medal Master", $FA, $F7
    db $EF, $EE, "happy.", $EF, $EE, $FA, $F7
    db "If you have any", $EF, $EE, "TinyMedals can I", $FA, $F7
    db $EF, $EE, "have them?"
    db $FF, $F0

Data_080_6EA6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Yippee! Thanks a", $F1
    db "whole bunch!", $FA, $F7
    db $EF, $EE, "This will make the", $EF, $EE, "Medal Master ", $FA, $F7
    db $EF, $EE, "happy!", $EF, $EE, $F7
    db $F0

Data_080_6EF9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Yippee! Thanks a", $F1
    db "whole bunch!", $FA, $F7
    db $EF, $EE, "This will make the", $EF, $EE, "Medal Master", $FA, $F7
    db $EF, $EE, "happy! ", $EF, $EE, $FA, $F7
    db "Oh? You don't have", $EF, $EE, "any TinyMedals", $A4, $F7
    db $F0

Data_080_6F70:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Aww", $A4, " That's so", $F1
    db "disappointing.", $FA, $F7
    db $EF, $EE, "I wanted to please", $EF, $EE, "the Medal Master", $A4, $F7
    db $F0

Data_080_6FBA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The Medal Master", $F1
    db "was famous as a", $FA, $F7
    db $EF, $EE, "monster master", $EF, $EE, "when he was young.", $FA, $F7
    db $EF, $EE, "The dresser is", $EF, $EE, "full of treasures", $FA, $F7
    db $EF, $EE, "that he collected", $EF, $EE, "back then.", $F7
    db $F0

Data_080_704B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "It overflowed with", $EF, $EE, "treasures.", $F7
    db $F0

Data_080_7086:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "It overflowed with", $EF, $EE, "TinyMedals.", $FA, $F7
    db $EF, $EE, "The Medal Master", $EF, $EE, "glanced sharply,", $FA, $F7
    db $EF, $EE, "prompting ", $F9, "0 to", $EF, $EE, "close the dresser.", $F7
    db $F0

Data_080_710F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "oven.", $FA, $F7
    db $EF, $EE, "There was an old,", $EF, $EE, "polished pot.", $F7
    db $F0

Data_080_7149:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey, I", $F1
    db "feel an odd power", $FA, $F7
    db $EF, $EE, "stirring again in", $EF, $EE, "another world.", $FA, $F7
    db $EF, $EE, "It must be the", $EF, $EE, "LightOrb, which is", $FA, $F7
    db $EF, $EE, "sealed away safely", $EF, $EE, "somewhere, warooh.", $FA, $F7
    db $EF, $EE, "Take this Sky Key", $EF, $EE, "and find it!", $F7
    db $F0

Data_080_7208:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Sky Key."
    db $E5, $58, $F7, $E9, $FF, $F0

Data_080_7226:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db $F9, "0 and Kameha!", $FA, $F7
    db $EF, $EE, "I share GreatLog's", $EF, $EE, "power with you!", $F7
    db $F0

Data_080_726E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " There!", $F1
    db "All healed now!", $FA, $F7
    db $EF, $EE, "There is something", $EF, $EE, "strange, warooh.", $FA, $F7
    db $EF, $EE, "I feel an odd sort", $EF, $EE, "of power coming", $FA, $F7
    db $EF, $EE, "from Limbo, but I", $EF, $EE, "can't tell if it's", $FA, $F7
    db $EF, $EE, "from anything that", $EF, $EE, "could be a plug.", $FA, $F7
    db $EF, $EE, "But no choice is", $EF, $EE, "what we have.", $FA, $F7
    db $EF, $EE, "You have to do the", $EF, $EE, "King's bidding.", $FA, $F7
    db $EF, $EE, "GreatLog's life", $EF, $EE, "force is almost", $FA, $F7
    db $EF, $EE, "all used up", $A4, $EF, $EE, "Huh?", $F7
    db $F0

Data_080_73B0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I", $A4, " I have", $F1
    db "to go back to the", $FA, $F7
    db $EF, $EE, "Castle for a", $EF, $EE, "while! Later!", $F7
    db $F0

Data_080_73F5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "there is little", $FA, $F7
    db $EF, $EE, "time left to us", $EF, $EE, "now.", $FA, $F7
    db $EF, $EE, $F9, "0, this is our", $EF, $EE, "last chance.", $FA, $F7
    db $EF, $EE, "If we don't find a", $EF, $EE, "proper plug this", $FA, $F7
    db $EF, $EE, "time, GreatLog is", $EF, $EE, "finished, warooh!", $F7
    db $F0

Data_080_74A1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "we don't have the", $FA, $F7
    db $EF, $EE, "time to be in", $EF, $EE, "shock, warooh.", $FA, $F7
    db $EF, $EE, "I have here the", $EF, $EE, "treasures that", $FA, $F7
    db $EF, $EE, "didn't work as the", $EF, $EE, "Navel's plug.", $FA, $F7
    db $EF, $EE, "Come get them when", $EF, $EE, "you are ready to", $FA, $F7
    db $EF, $EE, "leave to the world", $EF, $EE, "of Limbo, warooh.", $F7
    db $F0

Data_080_757D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the C Class", $F1
    db "final, you'll be", $FA, $F7
    db $EF, $EE, "facing HammerMan", $EF, $EE, "and Stubsuck.", $FA, $F7
    db $EF, $EE, "HammerMan uses", $EF, $EE, "Heal, so you", $FA, $F7
    db $EF, $EE, "should knock it", $EF, $EE, "out first.", $F7
    db $F0

Data_080_7602:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the B Class", $F1
    db "final, you'll face", $FA, $F7
    db $EF, $EE, "three monsters-", $EF, $EE, "HerbMan, DanceVegi", $FA, $F7
    db $EF, $EE, "and MudDoll. Watch", $EF, $EE, "out for Hustle!", $F7
    db $F0

Data_080_7675:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the A Class", $F1
    db "final, you'll face", $FA, $F7
    db $EF, $EE, "MistyWing, Copycat", $EF, $EE, "and NiteWhip.", $FA, $F7
    db $EF, $EE, "Watch out for the", $EF, $EE, "skill Imitate!", $F7
    db $F0

Data_080_76E4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " In the S Class", $F1
    db "final, you'll be", $FA, $F7
    db $EF, $EE, "facing DrakSlime,", $EF, $EE, "MetalKing and", $FA, $F7
    db $EF, $EE, "MimeSlime.", $EF, $EE, "That's the team.", $FA, $F7
    db $EF, $EE, "Don't be fooled by", $EF, $EE, "the way they look.", $FA, $F7
    db $EF, $EE, "You won't even", $EF, $EE, "scratch them if", $FA, $F7
    db $EF, $EE, "you don't attack", $EF, $EE, "them hard.", $F7
    db $F0

Data_080_77B4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, $A4, $A4, $A4, "?", $F1
    db "You startled me", $A4, $FA, $F7
    db $EF, $EE, "I don't remember", $EF, $EE, "who I am, what I'm", $FA, $F7
    db $EF, $EE, "doing here, or", $EF, $EE, "anything else", $A4, $FA, $F7
    db $EF, $EE, "I just know that I", $EF, $EE, "need help", $A4, $FA, $F7
    db $EF, $EE, "Oh? Do you know", $EF, $EE, "who I am?", $FA, $F7
    db $EF, $EE, "Could I get you to", $EF, $EE, "take me back home?"
    db $FF, $F0

Data_080_7881:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You will?", $F1
    db "Thank you!", $FA, $F7
    db $EF, $EE, "Let me hide among", $EF, $EE, "your items.", $F7
    db $F0

Data_080_78BC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained", $F1
    db "YunaSoul.", $F7
    db $F0

Data_080_78D3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " If you", $42, "e come", $F1
    db "to entertain Lady", $FA, $F7
    db $EF, $EE, "Yuna, you"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " better", $EF, $EE, "hurry in.", $FA, $F7
    db $EF, $EE, "Someone else could", $EF, $EE, "win the reward!", $F7
    db $F0

Data_080_793E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Am I dreaming?", $F1
    db "Two Kings?", $F7
    db $F0

Data_080_795C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " What? Why are", $F1
    db "there two Kings?", $F7
    db $F0

Data_080_797F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "It felt just a", $EF, $EE, "little warm.", $F7
    db $F0

Data_080_79B9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "History of the", $EF, $EE, "Lake Kingdoms", $A4, $FA, $F7
    db $EF, $EE, "The three Kingdoms", $EF, $EE, "surrounding the", $FA, $F7
    db $EF, $EE, "lake were once a", $EF, $EE, "single kingdom.", $FA, $F7
    db $EF, $EE, "The three Kingdoms", $EF, $EE, "were formed when", $FA, $F7
    db $EF, $EE, "three princes were", $EF, $EE, "allowed to divide", $FA, $F7
    db $EF, $EE, "the kingdom among", $EF, $EE, "themselves.", $95, $F7
    db $F0

Data_080_7AB7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "History of the", $EF, $EE, "Lake Kingdoms", $A4, $FA, $F7
    db $EF, $EE, "The elemental", $EF, $EE, "spirit in the", $FA, $F7
    db $EF, $EE, "spring is a kind-", $EF, $EE, "hearted being who", $FA, $F7
    db $EF, $EE, "has watched over", $EF, $EE, "human settlers", $FA, $F7
    db $EF, $EE, "since their", $EF, $EE, "earliest days.", $95, $F7
    db $F0

Data_080_7B81:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "a noxious fluid.", $F7
    db $F0

Data_080_7BC5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "History of the", $EF, $EE, "Lake Kingdoms", $A4, $FA, $F7
    db $EF, $EE, "In the middle of", $EF, $EE, "the lake is a", $FA, $F7
    db $EF, $EE, "tower made by a", $EF, $EE, "wizard.", $FA, $F7
    db $EF, $EE, "It is said to have", $EF, $EE, "been built in the", $FA, $F7
    db $EF, $EE, "distant past to", $EF, $EE, "guard treasures.", $95, $F7
    db $F0

Data_080_7C91:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "History of the", $EF, $EE, "Lake Kingdoms", $A4, $FA, $F7
    db $EF, $EE, "Ringed by the", $EF, $EE, "three Kingdoms,", $FA, $F7
    db $EF, $EE, "the lake serves as", $EF, $EE, "their reservoir.", $FA, $F7
    db $EF, $EE, "It also acts as a", $EF, $EE, "road that is never", $FA, $F7
    db $EF, $EE, "blocked by snow or", $EF, $EE, "ice.", $95, $F7
    db $F0

Data_080_7D5F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " The spirit", $F1
    db "made it possible", $FA, $F7
    db $EF, $EE, "for us to survive", $EF, $EE, "the harsh cold.", $FA, $F7
    db $EF, $EE, "Could I ask you to", $EF, $EE, "thank her on", $FA, $F7
    db $EF, $EE, "behalf of all of", $EF, $EE, "us?", $F7
    db $F0

Data_080_7DE6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This tunnel", $F1
    db "leads to a port.", $F7
    db $F0

Data_080_7E07:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The ice melted", $F1
    db "away!", $FA, $F7
    db $EF, $EE, "The port can be", $EF, $EE, "used again.", $F7
    db $F0

Data_080_7E40:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Yuna", $A3, " I heard that", $F1
    db "you saved Queen", $FA, $F7
    db $EF, $EE, "Helen, isn't that", $EF, $EE, "right?", $FA, $F7
    db $EF, $EE, "That means I can", $EF, $EE, "sneak out of the", $FA, $F7
    db $EF, $EE, "Castle without", $EF, $EE, "worry again!", $F7
    db $F0

Data_080_7EC7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen came", $F1
    db "by the other day,", $FA, $F7
    db $EF, $EE, "so I found my", $EF, $EE, "courage and said,", $FA, $F7
    db $EF, $EE
    db $AA, $11, $28, $2F, $2F, $32, $AB, $AA
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " to her.", $EF, $EE, "Do you know what?", $FA, $F7
    db $EF, $EE, "She gave me a", $EF, $EE, "really nice smile", $FA, $F7
    db $EF, $EE, "and said, "
    db $AA, $11, $28, $2F, $2F, $32, $AB, $AA, $EF, $EE, $35, $2C, $2A, $2B, $37, $90
    db $25, $24, $26, $2E, $99, $F7, $F0

Data_080_7F80:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Queen Helen's", $F1
    db "dreams come true", $FA, $F7
    db $EF, $EE, "more often than", $EF, $EE, "not.", $F7
    db $F0
    ds $45, $00
