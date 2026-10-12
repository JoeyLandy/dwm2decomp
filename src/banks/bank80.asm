SECTION "Bank 80", ROMX[$4000], BANK[$80]
    db $80

; message bank $80: when wStringIndex < $C8, BeginStringDisplay with this bank's table Data_080_4032; otherwise far-calls Func_096_4001 (E-0080)
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_Case0A, Func_010_4AD0_Case09, ShowMessageHL_Case09)
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

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_80_4032::
MessageStrings_Bank80:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_080_4032:: ; address name
    dw StringList_80_4034 ; id 0

; E-0217 (derived: category list of StringCategories_80_4032; one pointer per wStringIndex)
; record: string
StringList_80_4034::
Data_080_4034:: ; address name
    dw Data_080_41C4 ; id 0
    dw Data_080_41E8 ; id 1
    dw Data_080_4200 ; id 2
    dw Data_080_4324 ; id 3
    dw Data_080_43A3 ; id 4
    dw Data_080_43E1 ; id 5
    dw Data_080_44AF ; id 6
    dw Data_080_44D3 ; id 7
    dw Data_080_4537 ; id 8
    dw Data_080_4554 ; id 9
    dw Data_080_4572 ; id 10
    dw Data_080_45FD ; id 11
    dw Data_080_4675 ; id 12
    dw Data_080_46E1 ; id 13
    dw Data_080_4771 ; id 14
    dw Data_080_47E1 ; id 15
    dw Data_080_4868 ; id 16
    dw Data_080_48CE ; id 17
    dw Data_080_4955 ; id 18
    dw Data_080_49C1 ; id 19
    dw Data_080_4A4A ; id 20
    dw Data_080_4A8C ; id 21
    dw Data_080_4B00 ; id 22
    dw Data_080_4B69 ; id 23
    dw Data_080_4B69 ; id 24
    dw Data_080_4B69 ; id 25
    dw Data_080_4B69 ; id 26
    dw Data_080_4B69 ; id 27
    dw Data_080_4B69 ; id 28
    dw Data_080_4B69 ; id 29
    dw Data_080_4B69 ; id 30
    dw Data_080_4B69 ; id 31
    dw Data_080_4B69 ; id 32
    dw Data_080_4BD2 ; id 33
    dw Data_080_4C3B ; id 34
    dw Data_080_4CF3 ; id 35
    dw Data_080_4D0F ; id 36
    dw Data_080_4D2A ; id 37
    dw Data_080_4D93 ; id 38
    dw Data_080_4DAE ; id 39
    dw Data_080_4DD3 ; id 40
    dw Data_080_4E19 ; id 41
    dw Data_080_4E36 ; id 42
    dw Data_080_4E81 ; id 43
    dw Data_080_4EF0 ; id 44
    dw Data_080_4F36 ; id 45
    dw Data_080_4F53 ; id 46
    dw Data_080_4F78 ; id 47
    dw Data_080_4FAE ; id 48
    dw Data_080_50A8 ; id 49
    dw Data_080_51BC ; id 50
    dw Data_080_524D ; id 51
    dw Data_080_52E9 ; id 52
    dw Data_080_536F ; id 53
    dw Data_080_53B2 ; id 54
    dw Data_080_54AC ; id 55
    dw Data_080_550D ; id 56
    dw Data_080_5576 ; id 57
    dw Data_080_55DB ; id 58
    dw Data_080_561F ; id 59
    dw Data_080_578D ; id 60
    dw Data_080_581A ; id 61
    dw Data_080_589A ; id 62
    dw Data_080_596D ; id 63
    dw Data_080_59D5 ; id 64
    dw Data_080_5A16 ; id 65
    dw Data_080_5A99 ; id 66
    dw Data_080_5B25 ; id 67
    dw Data_080_5C24 ; id 68
    dw Data_080_5CCB ; id 69
    dw Data_080_5DA4 ; id 70
    dw Data_080_5E6E ; id 71
    dw Data_080_5E88 ; id 72
    dw Data_080_5EA7 ; id 73
    dw Data_080_5F14 ; id 74
    dw Data_080_5F77 ; id 75
    dw Data_080_5FFE ; id 76
    dw Data_080_60AB ; id 77
    dw Data_080_6167 ; id 78
    dw Data_080_627A ; id 79
    dw Data_080_62AE ; id 80
    dw Data_080_62DE ; id 81
    dw Data_080_639F ; id 82
    dw Data_080_6406 ; id 83
    dw Data_080_6441 ; id 84
    dw Data_080_6480 ; id 85
    dw Data_080_649D ; id 86
    dw Data_080_64C0 ; id 87
    dw Data_080_6509 ; id 88
    dw Data_080_6573 ; id 89
    dw Data_080_65CB ; id 90
    dw Data_080_65E3 ; id 91
    dw Data_080_662B ; id 92
    dw Data_080_668A ; id 93
    dw Data_080_66C6 ; id 94
    dw Data_080_66E0 ; id 95
    dw Data_080_673C ; id 96
    dw Data_080_6781 ; id 97
    dw Data_080_6801 ; id 98
    dw Data_080_6843 ; id 99
    dw Data_080_68B6 ; id 100
    dw Data_080_68F8 ; id 101
    dw Data_080_6967 ; id 102
    dw Data_080_6A08 ; id 103
    dw Data_080_6AB3 ; id 104
    dw Data_080_6B18 ; id 105
    dw Data_080_6B7D ; id 106
    dw Data_080_6BC7 ; id 107
    dw Data_080_6C49 ; id 108
    dw Data_080_6C8C ; id 109
    dw Data_080_6D71 ; id 110
    dw Data_080_6DBB ; id 111
    dw Data_080_6E46 ; id 112
    dw Data_080_6EA6 ; id 113
    dw Data_080_6EF9 ; id 114
    dw Data_080_6F70 ; id 115
    dw Data_080_6FBA ; id 116
    dw Data_080_704B ; id 117
    dw Data_080_7086 ; id 118
    dw Data_080_710F ; id 119
    dw Data_080_7149 ; id 120
    dw Data_080_7208 ; id 121
    dw Data_080_7226 ; id 122
    dw Data_080_726E ; id 123
    dw Data_080_73B0 ; id 124
    dw Data_080_73F5 ; id 125
    dw Data_080_74A1 ; id 126
    dw Data_080_757D ; id 127
    dw Data_080_7602 ; id 128
    dw Data_080_7675 ; id 129
    dw Data_080_76E4 ; id 130
    dw Data_080_77B4 ; id 131
    dw Data_080_77B4 ; id 132
    dw Data_080_77B4 ; id 133
    dw Data_080_77B4 ; id 134
    dw Data_080_77B4 ; id 135
    dw Data_080_77B4 ; id 136
    dw Data_080_77B4 ; id 137
    dw Data_080_77B4 ; id 138
    dw Data_080_77B4 ; id 139
    dw Data_080_77B4 ; id 140
    dw Data_080_77B4 ; id 141
    dw Data_080_77B4 ; id 142
    dw Data_080_77B4 ; id 143
    dw Data_080_77B4 ; id 144
    dw Data_080_77B4 ; id 145
    dw Data_080_77B4 ; id 146
    dw Data_080_77B4 ; id 147
    dw Data_080_77B4 ; id 148
    dw Data_080_77B4 ; id 149
    dw Data_080_77B4 ; id 150
    dw Data_080_77B4 ; id 151
    dw Data_080_77B4 ; id 152
    dw Data_080_77B4 ; id 153
    dw Data_080_77B4 ; id 154
    dw Data_080_77B4 ; id 155
    dw Data_080_77B4 ; id 156
    dw Data_080_77B4 ; id 157
    dw Data_080_77B4 ; id 158
    dw Data_080_77B4 ; id 159
    dw Data_080_77B4 ; id 160
    dw Data_080_77B4 ; id 161
    dw Data_080_77B4 ; id 162
    dw Data_080_77B4 ; id 163
    dw Data_080_77B4 ; id 164
    dw Data_080_77B4 ; id 165
    dw Data_080_77B4 ; id 166
    dw Data_080_77B4 ; id 167
    dw Data_080_77B4 ; id 168
    dw Data_080_77B4 ; id 169
    dw Data_080_77B4 ; id 170
    dw Data_080_77B4 ; id 171
    dw Data_080_77B4 ; id 172
    dw Data_080_77B4 ; id 173
    dw Data_080_77B4 ; id 174
    dw Data_080_77B4 ; id 175
    dw Data_080_77B4 ; id 176
    dw Data_080_77B4 ; id 177
    dw Data_080_77B4 ; id 178
    dw Data_080_77B4 ; id 179
    dw Data_080_77B4 ; id 180
    dw Data_080_77B4 ; id 181
    dw Data_080_7881 ; id 182
    dw Data_080_78BC ; id 183
    dw Data_080_78D3 ; id 184
    dw Data_080_78D3 ; id 185
    dw Data_080_793E ; id 186
    dw Data_080_795C ; id 187
    dw Data_080_797F ; id 188
    dw Data_080_79B9 ; id 189
    dw Data_080_7AB7 ; id 190
    dw Data_080_7B81 ; id 191
    dw Data_080_7BC5 ; id 192
    dw Data_080_7C91 ; id 193
    dw Data_080_7D5F ; id 194
    dw Data_080_7DE6 ; id 195
    dw Data_080_7E07 ; id 196
    dw Data_080_7E40 ; id 197
    dw Data_080_7EC7 ; id 198
    dw Data_080_7F80 ; id 199

Data_080_41C4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Queen Helen has", $F1
    db "become healthy.", $F7
    db $F0

Data_080_41E8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "shield.", $F7
    db $F0

Data_080_4200:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " So it was you", $F1
    db "holding up plans", $A4, $FA, $F7
    db $EF, $EE, "The King of Limbo", $EF, $EE, "promised me strong", $FA, $F7
    db $EF, $EE, "monsters in return", $EF, $EE, "for the Sky Shield", $FA, $F7
    db $EF, $EE, "being taken from", $EF, $EE, "the elemental.", $FA, $F7
    db $EF, $EE, "Any more of your", $EF, $EE, "meddling will not", $FA, $F7
    db $EF, $EE, "be tolerated.", $EF, $EE, "You should just", $FA, $F7
    db $EF, $EE, "back off now.", $EF, $EE, "Do you really", $FA, $F7
    db $EF, $EE, "think you can", $EF, $EE, "challenge me?", $FF, $F0

Data_080_4324:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Tch, obstinate", $F1
    db "and foolish.", $FA, $F7
    db $EF, $EE, "You need to be", $EF, $EE, "taught a lesson.", $FA, $F7
    db $EF, $EE, "Come hither, my", $EF, $EE, "faithful fiends!", $FA, $F7
    db $EF, $EE, "Crush this fool!", $EF, $EE, $F7
    db $F0

Data_080_43A3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wha", $A4, " No!", $F1
    db "My monsters!", $FA, $F7
    db $EF, $EE, "It won't be this", $EF, $EE, "easy next time!", $F7
    db $F0

Data_080_43E1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I bore witness", $F1
    db "to it all", $A4, $FA, $F7
    db $EF, $EE, "Your work has", $EF, $EE, "lifted the dark", $FA, $F7
    db $EF, $EE, "shadow that lay", $EF, $EE, "over this world.", $FA, $F7
    db $EF, $EE, "Peace should be", $EF, $EE, "quick to return.", $FA, $F7
    db $EF, $EE, "You no longer need", $EF, $EE, "the Crest.", $FA, $F7
    db $EF, $EE, "Throw it back into", $EF, $EE, "my spring.", $F7
    db $F0

Data_080_44AF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Throw the Crest", $F1
    db "into my spring.", $F7
    db $F0

Data_080_44D3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The Kingdoms", $F1
    db "should return to", $FA, $F7
    db $EF, $EE, "their peaceful", $EF, $EE, "states.", $FA, $F7
    db $EF, $EE, "As my thanks, take", $EF, $EE, "the Sky Shield.", $F7
    db $F0

Data_080_4537:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "the Sky Shield.", $F7
    db $F0

Data_080_4554:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A voice echoed", $F1
    db "from nowhere", $A4, $F7
    db $F0

Data_080_4572:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, "Wa-hey! ", $F9, "0,", $F1
    db "can you hear me?", $FA, $F7
    db $EF, $EE, "I felt an odd", $EF, $EE, "power stirring.", $FA, $F7
    db $EF, $EE, "You found a plug", $EF, $EE, "for the Navel!", $FA, $F7
    db $EF, $EE, "I'll bring you", $EF, $EE, "back! Don't move!", $F7
    db $F0

Data_080_45FD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The spirit's", $F1
    db "spring in the", $FA, $F7
    db $EF, $EE, "north isn't icy", $EF, $EE, "anymore.", $FA, $F7
    db $EF, $EE, "However cold it", $EF, $EE, "may be, spring", $FA, $F7
    db $EF, $EE, "always comes, I", $EF, $EE, "guess.", $F7
    db $F0

Data_080_4675:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The ice blocking", $F1
    db "the harbor finally", $FA, $F7
    db $EF, $EE, "broke up and", $EF, $EE, "melted away.", $FA, $F7
    db $EF, $EE, "We can get back to", $EF, $EE, "sailing again!", $F7
    db $F0

Data_080_46E1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The long winter", $F1
    db "seems to be over.", $FA, $F7
    db $EF, $EE, "It feels a little", $EF, $EE, "warmer now.", $FA, $F7
    db $EF, $EE, "It's the perfect", $EF, $EE, "occasion for a", $FA, $F7
    db $EF, $EE, "celebration drink", $EF, $EE, "at the tavern.", $F7
    db $F0

Data_080_4771:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We were visiting", $F1
    db "from the east.", $FA, $F7
    db $EF, $EE, "We found things to", $EF, $EE, "be good here, so", $FA, $F7
    db $EF, $EE, "we", $42, "e decided to", $EF, $EE, "make this home.", $F7
    db $F0

Data_080_47E1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When the harbor's", $F1
    db "ice disappeared,", $FA, $F7
    db $EF, $EE, "the sailors went", $EF, $EE, "away with it", $A4, $FA, $F7
    db $EF, $EE, "The tavern's not", $EF, $EE, "earning money.", $FA, $F7
    db $EF, $EE, "I'm still feeling", $EF, $EE, "blue", $A4, $F7
    db $F0

Data_080_4868:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Welcome! Oh?", $F1
    db "Hi, there!", $FA, $F7
    db $EF, $EE, "Well, you're a bit", $EF, $EE, "too young, but", $A4, $FA, $F7
    db $EF, $EE, "Since it's quiet,", $EF, $EE, "you're welcome.", $F7
    db $F0

Data_080_48CE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The eastern", $F1
    db "kingdom's castle", $FA, $F7
    db $EF, $EE, "is across the sea", $EF, $EE, "from here.", $FA, $F7
    db $EF, $EE, "Rumor has it that", $EF, $EE, "Queen Helen has", $FA, $F7
    db $EF, $EE, "recovered from her", $EF, $EE, "illness.", $F7
    db $F0

Data_080_4955:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The harbor has", $F1
    db "been busy with", $FA, $F7
    db $EF, $EE, "boats coming and", $EF, $EE, "going recently.", $FA, $F7
    db $EF, $EE, "I wonder how all", $EF, $EE, "the ice melted.", $F7
    db $F0

Data_080_49C1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The piled up ice", $F1
    db "floes disappeared", $FA, $F7
    db $EF, $EE, "from the harbor", $EF, $EE, "just like that.", $FA, $F7
    db $EF, $EE, "The elemental in", $EF, $EE, "the spring must", $FA, $F7
    db $EF, $EE, "have done it for", $EF, $EE, "us.", $F7
    db $F0

Data_080_4A4A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The warm weather", $F1
    db "melted the ice in", $FA, $F7
    db $EF, $EE, "the elemental's", $EF, $EE, "spring.", $F7
    db $F0

Data_080_4A8C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The scholar came", $F1
    db "back finally from", $FA, $F7
    db $EF, $EE, "his research trip.", $EF, $EE, "Who knows where he", $FA, $F7
    db $EF, $EE, "could have been", $EF, $EE, "all this time!", $F7
    db $F0

Data_080_4B00:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My maid is angry", $F1
    db "that I left the", $FA, $F7
    db $EF, $EE, "house vacant for", $EF, $EE, "so long.", $FA, $F7
    db $EF, $EE, "I wasn't wandering", $EF, $EE, "aimlessly, but", $A4, $F7
    db $F0

Data_080_4B69:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Father dug under", $F1
    db "the island, and he", $FA, $F7
    db $EF, $EE, "made a stable for", $EF, $EE, "monsters.", $FA, $F7
    db $EF, $EE, "You can make them", $EF, $EE, "sleep now.", $F7
    db $F0

Data_080_4BD2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I was going to", $F1
    db "ask Cobi, but I", $FA, $F7
    db $EF, $EE, "think you could do", $EF, $EE, "this, ", $F9, "0.", $FA, $F7
    db $EF, $EE, "Could you find", $EF, $EE, "something for me?", $FF, $F0

Data_080_4C3B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The farm that", $F1
    db "your father always", $FA, $F7
    db $EF, $EE, "dreamed about is", $EF, $EE, "finally completed.", $FA, $F7
    db $EF, $EE, "I want to have a", $EF, $EE, "nice dinner to", $FA, $F7
    db $EF, $EE, "celebrate, so I", $44, $EF, $EE, "like some Sirloin.", $FA, $F7
    db $EF, $EE, "Please go buy some", $EF, $EE, "for me.", $F7
    db $F0

Data_080_4CF3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $45, " Mama handed over", $F1
    db "1,200G.", $F7
    db $F0

Data_080_4D0F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh", $A4, " Then I'll", $F1
    db "ask Cobi.", $F7
    db $F0

Data_080_4D2A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I was going to", $F1
    db "ask Tara, but you", $FA, $F7
    db $EF, $EE, "could do this", $EF, $EE, "instead, ", $F9, "0.", $FA, $F7
    db $EF, $EE, "Could you find", $EF, $EE, "something for me?", $FF, $F0

Data_080_4D93:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh", $A4, " Then I'll", $F1
    db "ask Tara.", $F7
    db $F0

Data_080_4DAE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Buy some Sirloin", $F1
    db "for our dinner.", $F7
    db $F0

Data_080_4DD3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " They didn't have", $F1
    db "any around here.", $FA, $F7
    db $EF, $EE, "I'm surprised you", $EF, $EE, "found this.", $F7
    db $F0

Data_080_4E19:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the Sirloin.", $F7
    db $F0

Data_080_4E36:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I don't have any", $F1
    db "errands right now.", $FA, $F7
    db $EF, $EE, "I'll ask if there's", $EF, $EE, "anything, ", $F9, "0.", $F7
    db $F0

Data_080_4E81:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " MadGopher helped", $F1
    db "me excavate.", $FA, $F7
    db $EF, $EE, "Look at the great", $EF, $EE, "stable we made!", $FA, $F7
    db $EF, $EE, "My dream farm is", $EF, $EE, "finally finished!", $F7
    db $F0

Data_080_4EF0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Whew. I'm done", $F1
    db "working finally.", $FA, $F7
    db $EF, $EE, "Can you take me", $EF, $EE, "out somewhere?", $FF, $F0

Data_080_4F36:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You will?", $F1
    db "I'll cut loose!", $F7
    db $F0

Data_080_4F53:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, but you have", $F1
    db "no room for me", $A4, $F7
    db $F0

Data_080_4F78:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, don't be", $F1
    db "that way.", $FA, $F7
    db $EF, $EE, "I'm sure I can", $EF, $EE, "help you.", $F7
    db $F0

Data_080_4FAE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Cobi", $A3, " ", $F9, "0, what", $F1
    db "was it like in the", $FA, $F7
    db $EF, $EE, "other worlds?", $EF, $EE, "I", $44, " like to know.", $FA, $F7
    db $EF, $EE, $A4, "You met an", $EF, $EE, "elemental spirit?", $FA, $F7
    db $EF, $EE, "Wow. I wish I got", $EF, $EE, "to meet her.", $FA, $F7
    db $EF, $EE, "Papa made a stable", $EF, $EE, "under the island,", $FA, $F7
    db $EF, $EE, "so monsters can go", $EF, $EE, "to sleep.", $FA, $F7
    db $EF, $EE, "So, what can I do", $EF, $EE, "for you, sis?", $F7
    db $F0

Data_080_50A8:: ; heuristic: string; C0
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

Data_080_51BC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There are powers", $F1
    db "that let you cross", $FA, $F7
    db $EF, $EE, "the sea or fly up", $EF, $EE, "in the sky.", $FA, $F7
    db $EF, $EE, "If you get such", $EF, $EE, "powers, face the", $FA, $F7
    db $EF, $EE, "sea or sky and", $EF, $EE, "push a button!", $F7
    db $F0

Data_080_524D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Have you been to", $F1
    db "the Starry Shrine?", $FA, $F7
    db $EF, $EE, "Breeding toughens", $EF, $EE, "up monsters.", $FA, $F7
    db $EF, $EE, "The offspring", $EF, $EE, "inherits the", $FA, $F7
    db $EF, $EE, "stats, attributes", $EF, $EE, "and skills of", $FA, $F7
    db $EF, $EE, "parents.", $EF, $EE, $F7
    db $F0

Data_080_52E9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Uheheheh, did", $F1
    db "you know this?", $FA, $F7
    db $EF, $EE, "Zombies like me", $EF, $EE, "aren't bothered by", $FA, $F7
    db $EF, $EE, "death spells or", $EF, $EE, "curses.", $FA, $F7
    db $EF, $EE, "We're specialists", $EF, $EE, "in that area.", $F7
    db $F0

Data_080_536F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm a bug, so", $F1
    db "I'm not badly", $FA, $F7
    db $EF, $EE, "affected by poison", $EF, $EE, "or paralysis.", $F7
    db $F0

Data_080_53B2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Prince Kameha", $F1
    db "has been missing", $FA, $F7
    db $EF, $EE, "from the castle a", $EF, $EE, "long time", $A4, $FA, $F7
    db $EF, $EE, "The King thought", $EF, $EE, "it was another of", $FA, $F7
    db $EF, $EE, "the Prince's silly", $EF, $EE, "pranks at first,", $FA, $F7
    db $EF, $EE, "but he's worried", $EF, $EE, "and appears unable", $FA, $F7
    db $EF, $EE, "to concentrate on", $EF, $EE, "work now.", $FA, $F7
    db $EF, $EE, "Have you seen", $EF, $EE, "Prince Kameha?", $FF, $F0

Data_080_54AC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What's that?", $F1
    db "You saw Prince", $FA, $F7
    db $EF, $EE, "Kameha in another", $EF, $EE, "world?", $FA, $F7
    db $EF, $EE, "Come with me to", $EF, $EE, "see his Majesty!", $F7
    db $F0

Data_080_550D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $44, " better be", $F1
    db "telling the truth.", $FA, $F7
    db $EF, $EE, "If you see the", $EF, $EE, "Prince, you let us", $FA, $F7
    db $EF, $EE, "know right away,", $EF, $EE, "get it?", $F7
    db $F0

Data_080_5576:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The man here has", $F1
    db "rare keys.", $FA, $F7
    db $EF, $EE, "Doesn't it intrigue", $EF, $EE, "you what sort of", $FA, $F7
    db $EF, $EE, "worlds his keys", $EF, $EE, "lead to?", $F7
    db $F0

Data_080_55DB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Sire, this child", $F1
    db "claims to know", $FA, $F7
    db $EF, $EE, "Prince Kameha's", $EF, $EE, "whereabouts.", $F7
    db $F0

Data_080_561F:: ; heuristic: string; C0
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

Data_080_578D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " If you see", $F1
    db "Kameha again, I'll", $FA, $F7
    db $EF, $EE, "ask that you let", $EF, $EE, "me know.", $FA, $F7
    db $EF, $EE, "I realize that he", $EF, $EE, "is a mischievous", $FA, $F7
    db $EF, $EE, "handful, but I", $EF, $EE, "need your help.", $F7
    db $F0

Data_080_581A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Prince Kameha", $F1
    db "wandered off like", $FA, $F7
    db $EF, $EE, "a kite without its", $EF, $EE, "string", $A4, $FA, $F7
    db $EF, $EE, "Who did he take", $EF, $EE, "after", $A4, $FA, $F7
    db $EF, $EE, $A4, "Uh, never mind,", $EF, $EE, "ignore that!", $F7
    db $F0

Data_080_589A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're free to", $F1
    db "go anywhere in the", $FA, $F7
    db $EF, $EE, "Castle as you see", $EF, $EE, "fit.", $FA, $F7
    db $EF, $EE, "You can visit the", $EF, $EE, "Christener on the", $FA, $F7
    db $EF, $EE, "third level to", $EF, $EE, "rename monsters.", $FA, $F7
    db $EF, $EE, "Or drop into the", $EF, $EE, "tavern on four.", $FA, $F7
    db $EF, $EE, "But don't expect", $EF, $EE, "to be served!", $F7
    db $F0

Data_080_596D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King and", $F1
    db "Prince's chamber", $FA, $F7
    db $EF, $EE, "is beyond here.", $EF, $EE, "If I let you go", $FA, $F7
    db $EF, $EE, "through, I'll catch", $EF, $EE, "royal heck.", $F7
    db $F0

Data_080_59D5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Please enter.", $F1
    db "The King awaits", $FA, $F7
    db $EF, $EE, "you in the", $EF, $EE, "reception hall.", $F7
    db $F0

Data_080_5A16:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is GreatLog", $F1
    db "Castle.", $FA, $F7
    db $EF, $EE, "The reception hall", $EF, $EE, "is beyond here.", $FA, $F7
    db $EF, $EE, "The stairs will", $EF, $EE, "take you to the", $FA, $F7
    db $EF, $EE, "top of GreatLog's", $EF, $EE, "tree.", $F7
    db $F0

Data_080_5A99:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The tavern just", $F1
    db "outside the Castle", $FA, $F7
    db $EF, $EE, "is frequented by", $EF, $EE, "masters.", $FA, $F7
    db $EF, $EE, "They'll offer to", $EF, $EE, "breed monsters,", $FA, $F7
    db $EF, $EE, "and they'll give", $EF, $EE, "you some tips.", $F7
    db $F0

Data_080_5B25:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, welcome!", $F1
    db "All masters are", $FA, $F7
    db $EF, $EE, "welcome here, even", $EF, $EE, "little kids.", $FA, $F7
    db $EF, $EE, "Skilled masters", $EF, $EE, "congregate here.", $FA, $F7
    db $EF, $EE, "You might get the", $EF, $EE, "chance to breed", $FA, $F7
    db $EF, $EE, "some monsters.", $EF, $EE, "Don't miss out.", $FA, $F7
    db $EF, $EE, "Raising monsters", $EF, $EE, "alone is tough, so", $FA, $F7
    db $EF, $EE, "don't waste any", $EF, $EE, "chance to breed.", $F7
    db $F0

Data_080_5C24:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When you breed,", $F1
    db "notice a number", $FA, $F7
    db $EF, $EE, "after a plus sign", $EF, $EE, "in the name?", $FA, $F7
    db $EF, $EE, "The higher that", $EF, $EE, "number, the more", $FA, $F7
    db $EF, $EE, "the monster can", $EF, $EE, "grow.", $FA, $F7
    db $EF, $EE, "So you can level", $EF, $EE, "it up more!", $F7
    db $F0

Data_080_5CCB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you want to", $F1
    db "make a certain", $FA, $F7
    db $EF, $EE, "species stronger,", $EF, $EE, "just breed it with", $FA, $F7
    db $EF, $EE, "a monster of the", $EF, $EE, "same family.", $FA, $F7
    db $EF, $EE, "Even though the", $EF, $EE, "species remains", $FA, $F7
    db $EF, $EE, "unchanged, the", $EF, $EE, "monster will have", $FA, $F7
    db $EF, $EE, "inherited the", $EF, $EE, "partner's powers.", $F7
    db $F0

Data_080_5DA4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm a traveling", $F1
    db "merchant.", $FA, $F7
    db $EF, $EE, "I'm also a master", $EF, $EE, "as a hobby.", $FA, $F7
    db $EF, $EE, "Listen, would you", $EF, $EE, "like to breed", $FA, $F7
    db $EF, $EE, "something with my", $EF, $EE, "SpikyBoy?", $FA, $F7
    db $EF, $EE, "If possible, I", $44, $EF, $EE, "like to breed mine", $FA, $F7
    db $EF, $EE, "with another", $EF, $EE, "SpikyBoy. Well?", $FF, $F0

Data_080_5E6E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Then let's breed", $F1
    db "them!", $F7
    db $F0

Data_080_5E88:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, too bad.", $F1
    db "Another time.", $F7
    db $F0

Data_080_5EA7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Breeding could", $F1
    db "result in monsters", $FA, $F7
    db $EF, $EE, "with skills you", $EF, $EE, "wouldn't expect.", $FA, $F7
    db $EF, $EE, "It's an added perk", $EF, $EE, "of breeding.", $F7
    db $F0

Data_080_5F14:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " From up here", $F1
    db "people look like", $FA, $F7
    db $EF, $EE, "ants scurrying", $EF, $EE, "about, but they're", $FA, $F7
    db $EF, $EE, "not as big as", $EF, $EE, "ArmyAnts.", $F7
    db $F0

Data_080_5F77:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " On the horizon,", $F1
    db "you can see an", $FA, $F7
    db $EF, $EE, "enormous tree like", $EF, $EE, "this one.", $FA, $F7
    db $EF, $EE, "It's the Kingdom", $EF, $EE, "of GreatTree.", $FA, $F7
    db $EF, $EE, "It's GreatLog's", $EF, $EE, "rival kingdom.", $F7
    db $F0

Data_080_5FFE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " GreatLog Castle", $F1
    db "was made by", $FA, $F7
    db $EF, $EE, "hollowing out", $EF, $EE, "giant coconuts.", $FA, $F7
    db $EF, $EE, "GreatLog should", $EF, $EE, "have four in all.", $FA, $F7
    db $EF, $EE, "That means there", $EF, $EE, "must be two more", $FA, $F7
    db $EF, $EE, "coconuts below", $EF, $EE, "this level.", $F7
    db $F0

Data_080_60AB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The island used", $F1
    db "to be lush with", $FA, $F7
    db $EF, $EE, "plants, but they", $EF, $EE, "are dying slowly", $A4, $FA, $F7
    db $EF, $EE, "Will GreatLog", $EF, $EE, "suffer that way?", $FA, $F7
    db $EF, $EE, "People don't appear", $EF, $EE, "to be concerned,", $FA, $F7
    db $EF, $EE, "but something is", $EF, $EE, "going to happen", $A4, $F7
    db $F0

Data_080_6167:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello, ", $F9, "0,", $F1
    db "welcome!", $FA, $F7
    db $EF, $EE, "This is the stable", $EF, $EE, "where you can keep", $FA, $F7
    db $EF, $EE, "monsters stored,", $EF, $EE, "but hibernating.", $FA, $F7
    db $EF, $EE, "A monster won't", $EF, $EE, "gain any EX points", $FA, $F7
    db $EF, $EE, "while hibernating,", $EF, $EE, "but it also won't", $FA, $F7
    db $EF, $EE, "return to its wild", $EF, $EE, "state.", $FA, $F7
    db $EF, $EE, "Do you want to", $EF, $EE, "have a monster", $FA, $F7
    db $EF, $EE, "hibernate in the", $EF, $EE, "stable?", $F7
    db $F0

Data_080_627A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello, ", $F9, "0,", $F1
    db "welcome!", $FA, $F7
    db $EF, $EE, "Want to use the", $EF, $EE, "stable?", $F7
    db $F0

Data_080_62AE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Zzzz", $A4, " Yawn", $A4, $F1
    db "Huh?", $FA, $F7
    db $EF, $EE, "Is it morning", $EF, $EE, "already?", $F7
    db $F0

Data_080_62DE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When a ", $AC, " appears", $F1
    db "by a monster's", $FA, $F7
    db $EF, $EE, "level number, it", $EF, $EE, "stops growing.", $FA, $F7
    db $EF, $EE, "It won't learn any", $EF, $EE, "more skills too.", $FA, $F7
    db $EF, $EE, "In other words, it", $EF, $EE, "indicates that the", $FA, $F7
    db $EF, $EE, "monster has grown", $EF, $EE, "as much as it can.", $F7
    db $F0

Data_080_639F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Our kind always", $F1
    db "stays near water.", $FA, $F7
    db $EF, $EE, "Go traveling on", $EF, $EE, "water if you want", $FA, $F7
    db $EF, $EE, "to see others like", $EF, $EE, "me.", $F7
    db $F0

Data_080_6406:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Zzz", $A4, " Zzz", $A4, $F1
    db "Zzz", $A4, " Whoops!", $FA, $F7
    db $EF, $EE, "Was I breathing", $EF, $EE, "fire there?", $F7
    db $F0

Data_080_6441:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Do you want to", $F1
    db "know how much your", $FA, $F7
    db $EF, $EE, "companions can", $EF, $EE, "grow?", $FF, $F0

Data_080_6480:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "N's growth", $F1
    db "limit is Lv ", $F9, $4E, ".", $F7
    db $F0

Data_080_649D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "N has reached", $F1
    db "its growth limit.", $F7
    db $F0

Data_080_64C0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Once a monster", $F1
    db "reaches its growth", $FA, $F7
    db $EF, $EE, "limit, it won't", $EF, $EE, "level up anymore.", $F7
    db $F0

Data_080_6509:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Everyone has a", $F1
    db "growth limit.", $FA, $F7
    db $EF, $EE, "Whether you accept", $EF, $EE, "this or not, you", $FA, $F7
    db $EF, $EE, "can't defy the", $EF, $EE, "march of time.", $F7
    db $F0

Data_080_6573:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Ssh", $A4, " Monsters are", $EF, $EE, "sleeping.", $FA, $F7
    db $EF, $EE, "Please be quiet in", $EF, $EE, "the stable.", $95, $F7
    db $F0

Data_080_65CB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "casket.", $F7
    db $F0

Data_080_65E3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Zzz", $A4, " Use the", $F1
    db "plan ", $95, "Charge", $95, " in", $FA, $F7
    db $EF, $EE, "battle to boost", $EF, $EE, "monster courage.", $95, $F7
    db $F0

Data_080_662B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Zzz", $A4, $F1
    db "Hnnnnnrgh", $A4, " Huh?", $FA, $F7
    db $EF, $EE, "Being ", $95, "Cautious", $95, $EF, $EE, "in battle makes", $FA, $F7
    db $EF, $EE, "monsters more", $EF, $EE, "compassionate.", $F7
    db $F0

Data_080_668A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 read the", $F1
    db "sign.", $FA, $F7
    db $EF, $EE, $95, "Watch your step!", $EF, $EE, "Monster at sleep!", $95, $F7
    db $F0

Data_080_66C6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the hole.", $F7
    db $F0

Data_080_66E0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Zzz", $A4, " Zzz", $A4, $F1
    db "Some skills are", $FA, $F7
    db $EF, $EE, "developed from", $EF, $EE, "skills that have", $FA, $F7
    db $EF, $EE, "been learned", $EF, $EE, "already.", $F7
    db $F0

Data_080_673C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, you're the", $F1
    db "Kids Class Champ!", $FA, $F7
    db $EF, $EE, "Want to hear", $EF, $EE, "something good?", $FF, $F0

Data_080_6781:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the C Class", $F1
    db "final, you'll be", $FA, $F7
    db $EF, $EE, "facing HammerMan", $EF, $EE, "and Stubsuck.", $FA, $F7
    db $EF, $EE, "HammerMan uses", $EF, $EE, "EvilSlash.", $FA, $F7
    db $EF, $EE, "It's one tough", $EF, $EE, "customer!", $F7
    db $F0

Data_080_6801:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, you're the", $F1
    db "C Class Champ!", $FA, $F7
    db $EF, $EE, "Want to hear", $EF, $EE, "something good?", $FF, $F0

Data_080_6843:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the B Class", $F1
    db "final, you'll face", $FA, $F7
    db $EF, $EE, "three monsters-", $EF, $EE, "HerbMan, DanceVegi", $FA, $F7
    db $EF, $EE, "and MudDoll. Watch", $EF, $EE, "out for Hustle!", $F7
    db $F0

Data_080_68B6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, you're the", $F1
    db "B Class Champ!", $FA, $F7
    db $EF, $EE, "Want to hear", $EF, $EE, "something good?", $FF, $F0

Data_080_68F8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the A Class", $F1
    db "final, you'll face", $FA, $F7
    db $EF, $EE, "MistyWing, Copycat", $EF, $EE, "and NiteWhip.", $FA, $F7
    db $EF, $EE, "Watch out for the", $EF, $EE, "skill Imitate!", $F7
    db $F0

Data_080_6967:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, you're the", $F1
    db "A Class Champ!", $FA, $F7
    db $EF, $EE, "The S Class is", $EF, $EE, "next.", $FA, $F7
    db $EF, $EE, "It's the final", $EF, $EE, "battle class.", $FA, $F7
    db $EF, $EE, "It's nothing like", $EF, $EE, "what you", $42, "e seen.", $FA, $F7
    db $EF, $EE, "Want to hear", $EF, $EE, "something good?", $FF, $F0

Data_080_6A08:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the S Class", $F1
    db "final, you'll face", $FA, $F7
    db $EF, $EE, "Serpentia, Orochi", $EF, $EE, "and GigaDraco.", $FA, $F7
    db $EF, $EE, "They're horribly", $EF, $EE, "strong.", $FA, $F7
    db $EF, $EE, "You'll have to", $EF, $EE, "stop their attacks", $FA, $F7
    db $EF, $EE, "to get a chance at", $EF, $EE, "winning.", $F7
    db $F0

Data_080_6AB3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " My Emyu is very", $F1
    db "timid.", $FA, $F7
    db $EF, $EE, "I", $42, "e taken it down", $EF, $EE, "to the Coliseum,", $FA, $F7
    db $EF, $EE, "but all it does is", $EF, $EE, "take cover", $A4, $F7
    db $F0

Data_080_6B18:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Wow, you", $42, "e got", $F1
    db "a brave monster!", $FA, $F7
    db $EF, $EE, "Look, Emyu!", $EF, $EE, "Do you see that?", $FA, $F7
    db $EF, $EE, "That's how I want", $EF, $EE, "you to be!", $F7
    db $F0

Data_080_6B7D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Has my Emyu", $F1
    db "learned to be more", $FA, $F7
    db $EF, $EE, "brave? I really", $EF, $EE, "wonder about that", $A4, $F7
    db $F0

Data_080_6BC7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monsters look so", $F1
    db "frightening", $A4, $FA, $F7
    db $EF, $EE, "Yes, I know, I'm", $EF, $EE, "one too, but", $A4, $FA, $F7
    db $EF, $EE, "But when one", $EF, $EE, "glares at me", $A4, $FA, $F7
    db $EF, $EE, "Just the thought", $EF, $EE, "is scary!", $F7
    db $F0

Data_080_6C49:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I should be more", $F1
    db "assertive.", $FA, $F7
    db $EF, $EE, "It's not as if I'm", $EF, $EE, "going to die.", $F7
    db $F0

Data_080_6C8C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You can call me", $F1
    db "the Medal Master.", $FA, $F7
    db $EF, $EE, "I am a collector", $EF, $EE, "of TinyMedals.", $FA, $F7
    db $EF, $EE, "I only recently", $EF, $EE, "moved to GreatLog.", $FA, $F7
    db $EF, $EE, "TinyMedals are all", $EF, $EE, "over the world.", $FA, $F7
    db $EF, $EE, "If you find any,", $EF, $EE, "can you bring them", $FA, $F7
    db $EF, $EE, "to me? I'll trade", $EF, $EE, "gifts for them.", $F7
    db $F0

Data_080_6D71:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You can call me", $F1
    db "the Medal Master.", $FA, $F7
    db $EF, $EE, "I am a collector", $EF, $EE, "of TinyMedals.", $F7
    db $F0

Data_080_6DBB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " My husband loves", $F1
    db "to collect things", $FA, $F7
    db $EF, $EE, "that are of no", $EF, $EE, "value to others.", $FA, $F7
    db $EF, $EE, "TinyMedals are", $EF, $EE, "what he's after", $FA, $F7
    db $EF, $EE, "right now.", $EF, $EE, "It's a passion!", $F7
    db $F0

Data_080_6E46:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I like making", $F1
    db "the Medal Master", $FA, $F7
    db $EF, $EE, "happy.", $EF, $EE, $FA, $F7
    db "If you have any", $EF, $EE, "TinyMedals can I", $FA, $F7
    db $EF, $EE, "have them?", $FF, $F0

Data_080_6EA6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Yippee! Thanks a", $F1
    db "whole bunch!", $FA, $F7
    db $EF, $EE, "This will make the", $EF, $EE, "Medal Master ", $FA, $F7
    db $EF, $EE, "happy!", $EF, $EE, $F7
    db $F0

Data_080_6EF9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Yippee! Thanks a", $F1
    db "whole bunch!", $FA, $F7
    db $EF, $EE, "This will make the", $EF, $EE, "Medal Master", $FA, $F7
    db $EF, $EE, "happy! ", $EF, $EE, $FA, $F7
    db "Oh? You don't have", $EF, $EE, "any TinyMedals", $A4, $F7
    db $F0

Data_080_6F70:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Aww", $A4, " That's so", $F1
    db "disappointing.", $FA, $F7
    db $EF, $EE, "I wanted to please", $EF, $EE, "the Medal Master", $A4, $F7
    db $F0

Data_080_6FBA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Medal Master", $F1
    db "was famous as a", $FA, $F7
    db $EF, $EE, "monster master", $EF, $EE, "when he was young.", $FA, $F7
    db $EF, $EE, "The dresser is", $EF, $EE, "full of treasures", $FA, $F7
    db $EF, $EE, "that he collected", $EF, $EE, "back then.", $F7
    db $F0

Data_080_704B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "It overflowed with", $EF, $EE, "treasures.", $F7
    db $F0

Data_080_7086:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "dresser.", $FA, $F7
    db $EF, $EE, "It overflowed with", $EF, $EE, "TinyMedals.", $FA, $F7
    db $EF, $EE, "The Medal Master", $EF, $EE, "glanced sharply,", $FA, $F7
    db $EF, $EE, "prompting ", $F9, "0 to", $EF, $EE, "close the dresser.", $F7
    db $F0

Data_080_710F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "oven.", $FA, $F7
    db $EF, $EE, "There was an old,", $EF, $EE, "polished pot.", $F7
    db $F0

Data_080_7149:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey, I", $F1
    db "feel an odd power", $FA, $F7
    db $EF, $EE, "stirring again in", $EF, $EE, "another world.", $FA, $F7
    db $EF, $EE, "It must be the", $EF, $EE, "LightOrb, which is", $FA, $F7
    db $EF, $EE, "sealed away safely", $EF, $EE, "somewhere, warooh.", $FA, $F7
    db $EF, $EE, "Take this Sky Key", $EF, $EE, "and find it!", $F7
    db $F0

Data_080_7208:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "Sky Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Data_080_7226:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db $F9, "0 and Kameha!", $FA, $F7
    db $EF, $EE, "I share GreatLog's", $EF, $EE, "power with you!", $F7
    db $F0

Data_080_726E:: ; heuristic: string; C0
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

Data_080_73B0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I", $A4, " I have", $F1
    db "to go back to the", $FA, $F7
    db $EF, $EE, "Castle for a", $EF, $EE, "while! Later!", $F7
    db $F0

Data_080_73F5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "there is little", $FA, $F7
    db $EF, $EE, "time left to us", $EF, $EE, "now.", $FA, $F7
    db $EF, $EE, $F9, "0, this is our", $EF, $EE, "last chance.", $FA, $F7
    db $EF, $EE, "If we don't find a", $EF, $EE, "proper plug this", $FA, $F7
    db $EF, $EE, "time, GreatLog is", $EF, $EE, "finished, warooh!", $F7
    db $F0

Data_080_74A1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "we don't have the", $FA, $F7
    db $EF, $EE, "time to be in", $EF, $EE, "shock, warooh.", $FA, $F7
    db $EF, $EE, "I have here the", $EF, $EE, "treasures that", $FA, $F7
    db $EF, $EE, "didn't work as the", $EF, $EE, "Navel's plug.", $FA, $F7
    db $EF, $EE, "Come get them when", $EF, $EE, "you are ready to", $FA, $F7
    db $EF, $EE, "leave to the world", $EF, $EE, "of Limbo, warooh.", $F7
    db $F0

Data_080_757D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the C Class", $F1
    db "final, you'll be", $FA, $F7
    db $EF, $EE, "facing HammerMan", $EF, $EE, "and Stubsuck.", $FA, $F7
    db $EF, $EE, "HammerMan uses", $EF, $EE, "Heal, so you", $FA, $F7
    db $EF, $EE, "should knock it", $EF, $EE, "out first.", $F7
    db $F0

Data_080_7602:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the B Class", $F1
    db "final, you'll face", $FA, $F7
    db $EF, $EE, "three monsters-", $EF, $EE, "HerbMan, DanceVegi", $FA, $F7
    db $EF, $EE, "and MudDoll. Watch", $EF, $EE, "out for Hustle!", $F7
    db $F0

Data_080_7675:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the A Class", $F1
    db "final, you'll face", $FA, $F7
    db $EF, $EE, "MistyWing, Copycat", $EF, $EE, "and NiteWhip.", $FA, $F7
    db $EF, $EE, "Watch out for the", $EF, $EE, "skill Imitate!", $F7
    db $F0

Data_080_76E4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In the S Class", $F1
    db "final, you'll be", $FA, $F7
    db $EF, $EE, "facing DrakSlime,", $EF, $EE, "MetalKing and", $FA, $F7
    db $EF, $EE, "MimeSlime.", $EF, $EE, "That's the team.", $FA, $F7
    db $EF, $EE, "Don't be fooled by", $EF, $EE, "the way they look.", $FA, $F7
    db $EF, $EE, "You won't even", $EF, $EE, "scratch them if", $FA, $F7
    db $EF, $EE, "you don't attack", $EF, $EE, "them hard.", $F7
    db $F0

Data_080_77B4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, $A4, $A4, $A4, "?", $F1
    db "You startled me", $A4, $FA, $F7
    db $EF, $EE, "I don't remember", $EF, $EE, "who I am, what I'm", $FA, $F7
    db $EF, $EE, "doing here, or", $EF, $EE, "anything else", $A4, $FA, $F7
    db $EF, $EE, "I just know that I", $EF, $EE, "need help", $A4, $FA, $F7
    db $EF, $EE, "Oh? Do you know", $EF, $EE, "who I am?", $FA, $F7
    db $EF, $EE, "Could I get you to", $EF, $EE, "take me back home?", $FF, $F0

Data_080_7881:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You will?", $F1
    db "Thank you!", $FA, $F7
    db $EF, $EE, "Let me hide among", $EF, $EE, "your items.", $F7
    db $F0

Data_080_78BC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 obtained", $F1
    db "YunaSoul.", $F7
    db $F0

Data_080_78D3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you", $42, "e come", $F1
    db "to entertain Lady", $FA, $F7
    db $EF, $EE, "Yuna, you", $44, " better", $EF, $EE, "hurry in.", $FA, $F7
    db $EF, $EE, "Someone else could", $EF, $EE, "win the reward!", $F7
    db $F0

Data_080_793E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Am I dreaming?", $F1
    db "Two Kings?", $F7
    db $F0

Data_080_795C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What? Why are", $F1
    db "there two Kings?", $F7
    db $F0

Data_080_797F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "It felt just a", $EF, $EE, "little warm.", $F7
    db $F0

Data_080_79B9:: ; heuristic: string; C0
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

Data_080_7AB7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "History of the", $EF, $EE, "Lake Kingdoms", $A4, $FA, $F7
    db $EF, $EE, "The elemental", $EF, $EE, "spirit in the", $FA, $F7
    db $EF, $EE, "spring is a kind-", $EF, $EE, "hearted being who", $FA, $F7
    db $EF, $EE, "has watched over", $EF, $EE, "human settlers", $FA, $F7
    db $EF, $EE, "since their", $EF, $EE, "earliest days.", $95, $F7
    db $F0

Data_080_7B81:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the barrel.", $FA, $F7
    db $EF, $EE, "It was filled with", $EF, $EE, "a noxious fluid.", $F7
    db $F0

Data_080_7BC5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "History of the", $EF, $EE, "Lake Kingdoms", $A4, $FA, $F7
    db $EF, $EE, "In the middle of", $EF, $EE, "the lake is a", $FA, $F7
    db $EF, $EE, "tower made by a", $EF, $EE, "wizard.", $FA, $F7
    db $EF, $EE, "It is said to have", $EF, $EE, "been built in the", $FA, $F7
    db $EF, $EE, "distant past to", $EF, $EE, "guard treasures.", $95, $F7
    db $F0

Data_080_7C91:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "History of the", $EF, $EE, "Lake Kingdoms", $A4, $FA, $F7
    db $EF, $EE, "Ringed by the", $EF, $EE, "three Kingdoms,", $FA, $F7
    db $EF, $EE, "the lake serves as", $EF, $EE, "their reservoir.", $FA, $F7
    db $EF, $EE, "It also acts as a", $EF, $EE, "road that is never", $FA, $F7
    db $EF, $EE, "blocked by snow or", $EF, $EE, "ice.", $95, $F7
    db $F0

Data_080_7D5F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " The spirit", $F1
    db "made it possible", $FA, $F7
    db $EF, $EE, "for us to survive", $EF, $EE, "the harsh cold.", $FA, $F7
    db $EF, $EE, "Could I ask you to", $EF, $EE, "thank her on", $FA, $F7
    db $EF, $EE, "behalf of all of", $EF, $EE, "us?", $F7
    db $F0

Data_080_7DE6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This tunnel", $F1
    db "leads to a port.", $F7
    db $F0

Data_080_7E07:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The ice melted", $F1
    db "away!", $FA, $F7
    db $EF, $EE, "The port can be", $EF, $EE, "used again.", $F7
    db $F0

Data_080_7E40:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Yuna", $A3, " I heard that", $F1
    db "you saved Queen", $FA, $F7
    db $EF, $EE, "Helen, isn't that", $EF, $EE, "right?", $FA, $F7
    db $EF, $EE, "That means I can", $EF, $EE, "sneak out of the", $FA, $F7
    db $EF, $EE, "Castle without", $EF, $EE, "worry again!", $F7
    db $F0

Data_080_7EC7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Queen Helen came", $F1
    db "by the other day,", $FA, $F7
    db $EF, $EE, "so I found my", $EF, $EE, "courage and said,", $FA, $F7
    db $EF, $EE, $AA, "Hello,", $AA, " to her.", $EF, $EE, "Do you know what?", $FA, $F7
    db $EF, $EE, "She gave me a", $EF, $EE, "really nice smile", $FA, $F7
    db $EF, $EE, "and said, ", $AA, "Hello,", $AA, $EF, $EE, "right back!", $F7
    db $F0

Data_080_7F80:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Queen Helen's", $F1
    db "dreams come true", $FA, $F7
    db $EF, $EE, "more often than", $EF, $EE, "not.", $F7
    db $F0
    ds $45, $00
