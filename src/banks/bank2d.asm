SECTION "Bank 2D", ROMX[$4000], BANK[$2D]
    db $2D

; message bank $2D: when wStringIndex < $D5, BeginStringDisplay with this bank's table Data_02D_4032; otherwise far-calls Func_099_4001 (E-0080)
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank2D, ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2D, ShowMessageHL_ToBeginStringDisplay_Bank2D)
; reads: wStringIndex
BeginStringDisplay_Bank2D::
Func_02D_4001:: ; address name
    ld a, [wStringIndex]
    cp a, $D5
    jr c, Jump_02D_400F
    farcall BeginStringDisplay_Bank2D_Overflow
    ret

Jump_02D_400F::
    ld de, MessageStrings_Bank2D
    call BeginStringDisplay
    ret

; message bank $2D: when wStringIndex < $D5, CopyStringToBuffer with this bank's table Data_02D_4032; otherwise far-calls Func_099_4010 (E-0080)
; no direct call (reached through a table, a jump or a vector)
; reads: wStringIndex
CopyStringToBuffer_Bank2D:: ; heuristic: follows a terminator; C0
Func_02D_4016:: ; address name
    ld a, [wStringIndex]
    cp a, $D5
    jr c, Jump_02D_4024
    farcall CopyStringToBuffer_Bank2D_Overflow
    ret

Jump_02D_4024::
    ld de, MessageStrings_Bank2D
    call CopyStringToBuffer
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_2D_4032::
MessageStrings_Bank2D:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_02D_4032:: ; address name
    dw StringList_2D_4034 ; id 0

; E-0217 (derived: category list of StringCategories_2D_4032; one pointer per wStringIndex)
; record: string
StringList_2D_4034::
Data_02D_4034:: ; address name
    dw Message_05_00 ; id 0
    dw Message_05_01 ; id 1
    dw Message_05_02 ; id 2
    dw Message_05_03 ; id 3
    dw Message_05_04 ; id 4
    dw Message_05_05 ; id 5
    dw Message_05_06 ; id 6
    dw Message_05_07 ; id 7
    dw Message_05_08 ; id 8
    dw Message_05_09 ; id 9
    dw Message_05_0A ; id 10
    dw Message_05_0B ; id 11
    dw Message_05_0C ; id 12
    dw Message_05_0D ; id 13
    dw Message_05_0E ; id 14
    dw Message_05_0F ; id 15
    dw Message_05_10 ; id 16
    dw Message_05_11 ; id 17
    dw Message_05_12 ; id 18
    dw Message_05_13 ; id 19
    dw Message_05_14 ; id 20
    dw Message_05_15 ; id 21
    dw Message_05_16 ; id 22
    dw Message_05_17 ; id 23
    dw Message_05_18 ; id 24
    dw Message_05_19 ; id 25
    dw Message_05_1A ; id 26
    dw Message_05_1B ; id 27
    dw Message_05_1C ; id 28
    dw Message_05_1D ; id 29
    dw Message_05_1E ; id 30
    dw Message_05_1F ; id 31
    dw Message_05_20 ; id 32
    dw Message_05_21 ; id 33
    dw Message_05_22 ; id 34
    dw Message_05_23 ; id 35
    dw Message_05_24 ; id 36
    dw Message_05_25 ; id 37
    dw Message_05_26 ; id 38
    dw Message_05_27 ; id 39
    dw Message_05_28 ; id 40
    dw Message_05_29 ; id 41
    dw Message_05_2A ; id 42
    dw Message_05_2B ; id 43
    dw Message_05_2C ; id 44
    dw Message_05_2D ; id 45
    dw Message_05_2E ; id 46
    dw Message_05_2F ; id 47
    dw Message_05_30 ; id 48
    dw Message_05_31 ; id 49
    dw Message_05_32 ; id 50
    dw Message_05_33 ; id 51
    dw Message_05_34 ; id 52
    dw Message_05_35 ; id 53
    dw Message_05_36 ; id 54
    dw Message_05_37 ; id 55
    dw Message_05_38 ; id 56
    dw Message_05_39 ; id 57
    dw Message_05_3A ; id 58
    dw Message_05_3B ; id 59
    dw Message_05_3C ; id 60
    dw Message_05_3D ; id 61
    dw Message_05_3E ; id 62
    dw Message_05_3F ; id 63
    dw Message_05_40 ; id 64
    dw Message_05_41 ; id 65
    dw Message_05_42 ; id 66
    dw Message_05_43 ; id 67
    dw Message_05_44 ; id 68
    dw Message_05_45 ; id 69
    dw Message_05_46 ; id 70
    dw Message_05_47 ; id 71
    dw Message_05_48 ; id 72
    dw Message_05_49 ; id 73
    dw Message_05_4A ; id 74
    dw Message_05_4B ; id 75
    dw Message_05_4B ; id 76
    dw Message_05_4B ; id 77
    dw Message_05_4B ; id 78
    dw Message_05_4B ; id 79
    dw Message_05_4B ; id 80
    dw Message_05_51 ; id 81
    dw Message_05_52 ; id 82
    dw Message_05_53 ; id 83
    dw Message_05_54 ; id 84
    dw Message_05_55 ; id 85
    dw Message_05_56 ; id 86
    dw Message_05_57 ; id 87
    dw Message_05_58 ; id 88
    dw Message_05_59 ; id 89
    dw Message_05_5A ; id 90
    dw Message_05_5B ; id 91
    dw Message_05_5C ; id 92
    dw Message_05_5D ; id 93
    dw Message_05_5E ; id 94
    dw Message_05_5F ; id 95
    dw Message_05_60 ; id 96
    dw Message_05_60 ; id 97
    dw Message_05_60 ; id 98
    dw Message_05_60 ; id 99
    dw Message_05_60 ; id 100
    dw Message_05_60 ; id 101
    dw Message_05_60 ; id 102
    dw Message_05_60 ; id 103
    dw Message_05_60 ; id 104
    dw Message_05_60 ; id 105
    dw Message_05_60 ; id 106
    dw Message_05_60 ; id 107
    dw Message_05_60 ; id 108
    dw Message_05_60 ; id 109
    dw Message_05_60 ; id 110
    dw Message_05_60 ; id 111
    dw Message_05_60 ; id 112
    dw Message_05_60 ; id 113
    dw Message_05_60 ; id 114
    dw Message_05_60 ; id 115
    dw Message_05_60 ; id 116
    dw Message_05_60 ; id 117
    dw Message_05_60 ; id 118
    dw Message_05_60 ; id 119
    dw Message_05_60 ; id 120
    dw Message_05_60 ; id 121
    dw Message_05_60 ; id 122
    dw Message_05_60 ; id 123
    dw Message_05_60 ; id 124
    dw Message_05_60 ; id 125
    dw Message_05_60 ; id 126
    dw Message_05_60 ; id 127
    dw Message_05_60 ; id 128
    dw Message_05_60 ; id 129
    dw Message_05_60 ; id 130
    dw Message_05_60 ; id 131
    dw Message_05_60 ; id 132
    dw Message_05_60 ; id 133
    dw Message_05_60 ; id 134
    dw Message_05_60 ; id 135
    dw Message_05_60 ; id 136
    dw Message_05_60 ; id 137
    dw Message_05_60 ; id 138
    dw Message_05_60 ; id 139
    dw Message_05_60 ; id 140
    dw Message_05_60 ; id 141
    dw Message_05_60 ; id 142
    dw Message_05_60 ; id 143
    dw Message_05_60 ; id 144
    dw Message_05_60 ; id 145
    dw Message_05_60 ; id 146
    dw Message_05_60 ; id 147
    dw Message_05_60 ; id 148
    dw Message_05_95 ; id 149
    dw Message_05_96 ; id 150
    dw Message_05_97 ; id 151
    dw Message_05_98 ; id 152
    dw Message_05_99 ; id 153
    dw Message_05_9A ; id 154
    dw Message_05_9B ; id 155
    dw Message_05_9C ; id 156
    dw Message_05_9D ; id 157
    dw Message_05_9E ; id 158
    dw Message_05_9F ; id 159
    dw Message_05_A0 ; id 160
    dw Message_05_A1 ; id 161
    dw Message_05_A2 ; id 162
    dw Message_05_A3 ; id 163
    dw Message_05_A4 ; id 164
    dw Message_05_A5 ; id 165
    dw Message_05_A6 ; id 166
    dw Message_05_A7 ; id 167
    dw Message_05_A8 ; id 168
    dw Message_05_A9 ; id 169
    dw Message_05_AA ; id 170
    dw Message_05_AB ; id 171
    dw Message_05_AC ; id 172
    dw Message_05_AD ; id 173
    dw Message_05_AE ; id 174
    dw Message_05_AF ; id 175
    dw Message_05_B0 ; id 176
    dw Message_05_B1 ; id 177
    dw Message_05_B2 ; id 178
    dw Message_05_B3 ; id 179
    dw Message_05_B4 ; id 180
    dw Message_05_B5 ; id 181
    dw Message_05_B6 ; id 182
    dw Message_05_B7 ; id 183
    dw Message_05_B8 ; id 184
    dw Message_05_B9 ; id 185
    dw Message_05_BA ; id 186
    dw Message_05_BB ; id 187
    dw Message_05_BC ; id 188
    dw Message_05_BD ; id 189
    dw Message_05_BE ; id 190
    dw Message_05_BF ; id 191
    dw Message_05_C0 ; id 192
    dw Message_05_C1 ; id 193
    dw Message_05_C2 ; id 194
    dw Message_05_C3 ; id 195
    dw Message_05_C4 ; id 196
    dw Message_05_C5 ; id 197
    dw Message_05_C6 ; id 198
    dw Message_05_C7 ; id 199
    dw Message_05_C8 ; id 200
    dw Message_05_C9 ; id 201
    dw Message_05_CA ; id 202
    dw Message_05_CB ; id 203
    dw Message_05_CC ; id 204
    dw Message_05_CD ; id 205
    dw Message_05_CE ; id 206
    dw Message_05_CF ; id 207
    dw Message_05_D0 ; id 208
    dw Message_05_D1 ; id 209
    dw Message_05_D2 ; id 210
    dw Message_05_D3 ; id 211
    dw Message_05_D4 ; id 212

Message_05_00:: ; heuristic: string; C0
Data_02D_41DE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $F9, "0", $A4, " There", $F1
    db "have been frequent", $FA, $F7
    db $EF, $EE, "earthquakes on the", $EF, $EE, "island.", $FA, $F7
    db $EF, $EE, "Is it a sign of", $EF, $EE, "coming trouble?", $FA, $F7
    db $EF, $EE, "I don't want you", $EF, $EE, "wandering off", $A4, $F7
    db $F0

Message_05_01:: ; heuristic: string; C0
Data_02D_4265:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " People have been", $F1
    db "whispering that", $FA, $F7
    db $EF, $EE, "GreatLog will sink", $EF, $EE, "into the sea.", $FA, $F7
    db $EF, $EE, "It's in times like", $EF, $EE, "this that one has", $FA, $F7
    db $EF, $EE, "to be cool, calm", $EF, $EE, "and collected.", $F7
    db $F0

Message_05_02:: ; heuristic: string; C0
Data_02D_42FB:: ; address name
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

Message_05_03:: ; heuristic: string; C0
Data_02D_43F3:: ; address name
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

Message_05_04:: ; heuristic: string; C0
Data_02D_451F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If the island", $F1
    db "sink, is no worry,", $FA, $F7
    db $EF, $EE, "my friend! This", $EF, $EE, "rope save you!", $FA, $F7
    db $EF, $EE, "It climb up and up", $EF, $EE, "into the clouds!", $FA, $F7
    db $EF, $EE, "Is free to try", $EF, $EE, "now. You try!", $F7
    db $F0

Message_05_05:: ; heuristic: string; C0
Data_02D_45B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " People have been", $F1
    db "saying that they", $FA, $F7
    db $EF, $EE, "may be able to", $EF, $EE, "survive at the top", $FA, $F7
    db $EF, $EE, "of the tree if the", $EF, $EE, "island sinks.", $F7
    db $F0

Message_05_06:: ; heuristic: string; C0
Data_02D_4621:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey! You're the", $F1
    db "kid who said the", $FA, $F7
    db $EF, $EE, "island was going", $EF, $EE, "to sink!", $FA, $F7
    db $EF, $EE, "There", $42, "e been many", $EF, $EE, "earthquakes", $A4, $FA, $F7
    db $EF, $EE, "Were you telling", $EF, $EE, "the truth?", $FA, $F7
    db $EF, $EE, "No, it can't be", $A4, $EF, $EE, "But then again", $A4, $F7
    db $F0

Message_05_07:: ; heuristic: string; C0
Data_02D_46CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Prince Kameha", $F1
    db "came back!", $FA, $F7
    db $EF, $EE, "What with the", $EF, $EE, "earthquakes and", $FA, $F7
    db $EF, $EE, "all, bad luck does", $EF, $EE, "come in bunches", $A4, $F7
    db $F0

Message_05_08:: ; heuristic: string; C0
Data_02D_4731:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Hi! Have you", $F1
    db "heard?", $FA, $F7
    db $EF, $EE, "GreatLog is going", $EF, $EE, "to sink!", $FA, $F7
    db $EF, $EE, "I'll have to buy", $EF, $EE, "supplies and get", $FA, $F7
    db $EF, $EE, "ready for the", $EF, $EE, "disaster!", $F7
    db $F0

Message_05_09:: ; heuristic: string; C0
Data_02D_47A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " My neighbor is", $F1
    db "buying all sorts", $FA, $F7
    db $EF, $EE, "of things in a", $EF, $EE, "panic, but", $A4, $FA, $F7
    db $EF, $EE, "What good will", $EF, $EE, "clothes or monster", $FA, $F7
    db $EF, $EE, "accessories do her", $EF, $EE, "now?", $F7
    db $F0

Message_05_0A:: ; heuristic: string; C0
Data_02D_482E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When things are", $F1
    db "tough, you can't", $FA, $F7
    db $EF, $EE, "afford to panic.", $EF, $EE, "Try to stay calm.", $F7
    db $F0

Message_05_0B:: ; heuristic: string; C0
Data_02D_4879:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You, ", $F9, "0,", $F1
    db "come with me!", $FA, $F7
    db $EF, $EE, "Prince Kameha", $44, $EF, $EE, "finally returned", $FA, $F7
    db $EF, $EE, "from who knows", $EF, $EE, "where.", $FA, $F7
    db $EF, $EE, "It turns out that", $EF, $EE, "you dragged him", $FA, $F7
    db $EF, $EE, "back from another", $EF, $EE, "world.", $FA, $F7
    db $EF, $EE, "His Majesty wishes", $EF, $EE, "to see you.", $FA, $F7
    db $EF, $EE, "Come with me to", $EF, $EE, "the Castle!", $F7
    db $F0

Message_05_0C:: ; heuristic: string; C0
Data_02D_4958:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My beloved", $F1
    db "island is sinking", $A4, $FA, $F7
    db $EF, $EE, "But I can't do a", $EF, $EE, "thing but watch", $A4, $F7
    db $F0

Message_05_0D:: ; heuristic: string; C0
Data_02D_499F:: ; address name
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

Message_05_0E:: ; heuristic: string; C0
Data_02D_4B3D:: ; address name
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

Message_05_0F:: ; heuristic: string; C0
Data_02D_4C61:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " There have", $F1
    db "been many quakes.", $FA, $F7
    db $EF, $EE, "I hope nothing", $EF, $EE, "will come of them.", $FA, $F7
    db $EF, $EE, "Our people can't", $EF, $EE, "live in security", $FA, $F7
    db $EF, $EE, "with that weighing", $EF, $EE, "on their minds.", $F7
    db $F0

Message_05_10:: ; heuristic: string; C0
Data_02D_4CF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The frequent", $F1
    db "quakes have raised", $FA, $F7
    db $EF, $EE, "grave concerns", $EF, $EE, "among the people.", $FA, $F7
    db $EF, $EE, "Our investigations", $EF, $EE, "have so far failed", $FA, $F7
    db $EF, $EE, "to identify what", $EF, $EE, "is causing them.", $F7
    db $F0

Message_05_11:: ; heuristic: string; C0
Data_02D_4D91:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Beyond here is", $F1
    db "his Majesty and", $FA, $F7
    db $EF, $EE, "Prince Kameha's", $EF, $EE, "chamber.", $FA, $F7
    db $EF, $EE, "I", $42, "e received word", $EF, $EE, "to let you pass.", $F7
    db $F0

Message_05_12:: ; heuristic: string; C0
Data_02D_4DF7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " Yo, ", $F9, "0.", $F1
    db "Thanks for coming.", $FA, $F7
    db $EF, $EE, "Pop's got his eye", $EF, $EE, "on me, so I", $FA, $F7
    db $EF, $EE, "can't get out of", $EF, $EE, "here now, but I'll", $FA, $F7
    db $EF, $EE, "get out to other", $EF, $EE, "worlds again!", $FA, $F7
    db $EF, $EE, "That's a promise.", $EF, $EE, "You just wait!", $F7
    db $F0

Message_05_13:: ; heuristic: string; C0
Data_02D_4EAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm a scientist.", $F1
    db "I", $42, "e been studying", $FA, $F7
    db $EF, $EE, "the results of", $EF, $EE, "breeding monsters.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "try breeding a", $FA, $F7
    db $EF, $EE, "monster with my", $EF, $EE, "Gulpple?", $FF, $F0

Message_05_14:: ; heuristic: string; C0
Data_02D_4F38:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well, let's see", $F1
    db "about breeding!", $F7
    db $F0

Message_05_15:: ; heuristic: string; C0
Data_02D_4F5B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh", $A4, " Perhaps on", $F1
    db "another occasion.", $F7
    db $F0

Message_05_16:: ; heuristic: string; C0
Data_02D_4F80:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hm", $A4, " So that", $F1
    db "combination of", $FA, $F7
    db $EF, $EE, "parents results in", $EF, $EE, "this species", $A4, $FA, $F7
    db $EF, $EE, "I", $44, " better get home", $EF, $EE, "quickly and make a", $FA, $F7
    db $EF, $EE, "record of this", $EF, $EE, "finding.", $F7
    db $F0

Message_05_17:: ; heuristic: string; C0
Data_02D_500A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " GreatLog is", $F1
    db "sinking I heard,", $FA, $F7
    db $EF, $EE, "but I don't want", $EF, $EE, "to leave here.", $FA, $F7
    db $EF, $EE, "So I came up here", $EF, $EE, "for now.", $F7
    db $F0

Message_05_18:: ; heuristic: string; C0
Data_02D_506D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e never once", $F1
    db "left the island.", $FA, $F7
    db $EF, $EE, "I can't imagine", $EF, $EE, "living elsewhere.", $F7
    db $F0

Message_05_19:: ; heuristic: string; C0
Data_02D_50B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " This is a time", $F1
    db "we need Warubou's", $FA, $F7
    db $EF, $EE, "help the most.", $EF, $EE, "But I", $42, "e heard it's", $FA, $F7
    db $EF, $EE, "stuck itself in a", $EF, $EE, "hole and is", $FA, $F7
    db $EF, $EE, "playing.", $F7
    db $F0

Message_05_1A:: ; heuristic: string; C0
Data_02D_512D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I didn't want to", $F1
    db "believe GreatLog", $FA, $F7
    db $EF, $EE, "is sinking, but", $EF, $EE, "seeing the changes", $FA, $F7
    db $EF, $EE, "that have been", $EF, $EE, "taking place", $A4, $FA, $F7
    db $EF, $EE, "I have no choice", $EF, $EE, "but to believe.", $F7
    db $F0

Message_05_1B:: ; heuristic: string; C0
Data_02D_51BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I won't believe", $F1
    db "that GreatLog is", $FA, $F7
    db $EF, $EE, "sinking. That just", $EF, $EE, "can't happen!", $FA, $F7
    db $EF, $EE, "It has to be one", $EF, $EE, "of Warubou's usual", $FA, $F7
    db $EF, $EE, "pranks.", $EF, $EE, "I'm convinced.", $F7
    db $F0

Message_05_1C:: ; heuristic: string; C0
Data_02D_5248:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The King said", $F1
    db "that GreatLog will", $FA, $F7
    db $EF, $EE, "not sink, but if", $EF, $EE, "not, what's causing", $FA, $F7
    db $EF, $EE, "all the changes on", $EF, $EE, "the island?", $F7
    db $F0

Message_05_1D:: ; heuristic: string; C0
Data_02D_52B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Everyone, please", $F1
    db "remain calm.", $FA, $F7
    db $EF, $EE, "Even if GreatLog", $EF, $EE, "were to sink, we", $FA, $F7
    db $EF, $EE, "have enough ships", $EF, $EE, "to evacuate the", $FA, $F7
    db $EF, $EE, "entire population", $EF, $EE, "easily.", $F7
    db $F0

Message_05_1E:: ; heuristic: string; C0
Data_02D_5344:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The GreatLog", $F1
    db "tree appeared to", $FA, $F7
    db $EF, $EE, "be healthy", $A4, " Could", $EF, $EE, "it be at the end", $FA, $F7
    db $EF, $EE, "of its natural", $EF, $EE, "lifespan?", $F7
    db $F0

Message_05_1F:: ; heuristic: string; C0
Data_02D_53AA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Right now, we", $F1
    db "are investigating", $FA, $F7
    db $EF, $EE, "what is causing", $EF, $EE, "the earthquakes.", $FA, $F7
    db $EF, $EE, "Please don't panic,", $EF, $EE, "and stay home.", $F7
    db $F0

Message_05_20:: ; heuristic: string; C0
Data_02D_5419:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $42, "e studied", $F1
    db "GreatLog over a", $FA, $F7
    db $EF, $EE, "long time.", $EF, $EE, "I", $42, "e never seen", $FA, $F7
    db $EF, $EE, "changes this", $EF, $EE, "profound, however.", $F7
    db $F0

Message_05_21:: ; heuristic: string; C0
Data_02D_547B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Arena is", $F1
    db "closed under the", $FA, $F7
    db $EF, $EE, "King's decree.", $EF, $EE, "The whole island", $FA, $F7
    db $EF, $EE, "is too jumpy over", $EF, $EE, "the earthquakes.", $F7
    db $F0

Message_05_22:: ; heuristic: string; C0
Data_02D_54E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's been decided", $F1
    db "to shut down the", $FA, $F7
    db $EF, $EE, "Arena for a", $EF, $EE, "while.", $FA, $F7
    db $EF, $EE, "The rumors about", $EF, $EE, "the island sinking", $FA, $F7
    db $EF, $EE, "kept people away", $EF, $EE, "anyway.", $F7
    db $F0

Message_05_23:: ; heuristic: string; C0
Data_02D_5569:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Don't be fooled", $F1
    db "by those rumors", $FA, $F7
    db $EF, $EE, "about GreatLog", $EF, $EE, "sinking.", $FA, $F7
    db $EF, $EE, "We must be most", $EF, $EE, "vigilant against", $FA, $F7
    db $EF, $EE, "the horrifying", $EF, $EE, "prospect of panic.", $F7
    db $F0

Message_05_24:: ; heuristic: string; C0
Data_02D_55F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " He can talk", $F1
    db "tough now, but", $A4, $FA, $F7
    db $EF, $EE, "What will we do if", $EF, $EE, "GreatLog sinks?", $F7
    db $F0

Message_05_25:: ; heuristic: string; C0
Data_02D_563A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Everyone's saying", $F1
    db "GreatLog'll sink!", $F7
    db $F0

Message_05_26:: ; heuristic: string; C0
Data_02D_5660:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If GreatLog were", $F1
    db "to sink, we will", $FA, $F7
    db $EF, $EE, "keep its memory", $EF, $EE, "alive forever.", $F7
    db $F0

Message_05_27:: ; heuristic: string; C0
Data_02D_56A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm an adult so I", $F1
    db "can live anywhere.", $FA, $F7
    db $EF, $EE, "But I feel bad for", $EF, $EE, "my granddaughter", $FA, $F7
    db $EF, $EE, "who'll have to", $EF, $EE, "leave her friends.", $F7
    db $F0

Message_05_28:: ; heuristic: string; C0
Data_02D_571E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I don't want to", $F1
    db "leave GreatLog!", $FA, $F7
    db $EF, $EE, "I'm not leaving my", $EF, $EE, "friends behind!", $FA, $F7
    db $EF, $EE, "If I can't take", $EF, $EE, "Butch, I'm staying!", $F7
    db $F0

Message_05_29:: ; heuristic: string; C0
Data_02D_578D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Grandpa and the", $F1
    db "others are going", $FA, $F7
    db $EF, $EE, "to evacuate from", $EF, $EE, "GreatLog", $A4, $FA, $F7
    db $EF, $EE, "But there are too", $EF, $EE, "many people", $A4, $FA, $F7
    db $EF, $EE, "They have no room", $EF, $EE, "to take me", $A4, $F7
    db $F0

Message_05_2A:: ; heuristic: string; C0
Data_02D_5816:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Are you ready?", $FA, $F7
    db $EF, $EE, "Ready for Limbo?", $EF, $EE, "Warooh!", $FF, $F0

Message_05_2B:: ; heuristic: string; C0
Data_02D_5855:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Take the treasures", $FA, $F7
    db $EF, $EE, "that didn't work", $EF, $EE, "as the plug.", $FA, $F7
    db $EF, $EE, "Heheh, I repaired", $EF, $EE, "them and hung onto", $FA, $F7
    db $EF, $EE, "them, warooh!", $EF, $EE, "Take them now!", $F7
    db $F0

Message_05_2C:: ; heuristic: string; C0
Data_02D_58E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "TidalBell.", $F7
    db $F0

Message_05_2D:: ; heuristic: string; C0
Data_02D_5902:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "HarMirror.", $F7
    db $F0

Message_05_2E:: ; heuristic: string; C0
Data_02D_591E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received the", $F1
    db "SkyShield.", $F7
    db $F0

Message_05_2F:: ; heuristic: string; C0
Data_02D_593A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Limbo is", $F1
    db "the King's domain!", $FA, $F7
    db $EF, $EE, "You be careful,", $EF, $EE, "warooh!", $F7
    db $F0

Message_05_30:: ; heuristic: string; C0
Data_02D_597C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Take the treasures", $FA, $F7
    db $EF, $EE, "that didn't work", $EF, $EE, "as the plug.", $FA, $F7
    db $EF, $EE, $A4, "Oh? You don't have", $EF, $EE, "enough room.", $F7
    db $F0

Message_05_31:: ; heuristic: string; C0
Data_02D_59E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "well, hurry it up!", $FA, $F7
    db $EF, $EE, "When you're ready,", $EF, $EE, "I'll give you the", $FA, $F7
    db $EF, $EE, "three treasures", $EF, $EE, "then, warooh!", $F7
    db $F0

Message_05_32:: ; heuristic: string; C0
Data_02D_5A56:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "you have to find", $FA, $F7
    db $EF, $EE, "a plug this time", $EF, $EE, "for sure, warooh!", $FA, $F7
    db $EF, $EE, "GreatLog has no", $EF, $EE, "life force left", $A4, $F7
    db $F0

Message_05_33:: ; heuristic: string; C0
Data_02D_5AC6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey,", $F1
    db "you did it, ", $F9, "0!", $FA, $F7
    db $EF, $EE, "I'll share some of", $EF, $EE, "GreatLog's energy.", $F7
    db $F0

Message_05_34:: ; heuristic: string; C0
Data_02D_5B11:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " There!", $F1
    db "All healthy now!", $FA, $F7
    db $EF, $EE, "Let me see,", $EF, $EE, "warooh!", $F7
    db $F0

Message_05_35:: ; heuristic: string; C0
Data_02D_5B4C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " So this", $F1
    db "is the MagicPlug", $A4, $FA, $F7
    db $EF, $EE, "Wa-hey, ", $F9, "0,", $EF, $EE, "I believed in you!", $FA, $F7
    db $EF, $EE, "Let's see if it", $EF, $EE, "will work, warooh!", $F7
    db $F0

Message_05_36:: ; heuristic: string; C0
Data_02D_5BBA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " There!", $F1
    db "It's a perfect fit!", $FA, $F7
    db $EF, $EE, "You finally did", $EF, $EE, "it, ", $F9, "0, warooh!", $F7
    db $F0

Message_05_37:: ; heuristic: string; C0
Data_02D_5C03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, $F1
    db "Wa-wa-hey! We were", $FA, $F7
    db $EF, $EE, "too late! The", $EF, $EE, "Navel's closed, but", $FA, $F7
    db $EF, $EE, "not enough life", $EF, $EE, "force was left to", $FA, $F7
    db $EF, $EE, "support the", $EF, $EE, "island!", $F7
    db $F0

Message_05_38:: ; heuristic: string; C0
Data_02D_5C84:: ; address name
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

Message_05_39:: ; heuristic: string; C0
Data_02D_5D72:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Get going!", $F7
    db $F0

Message_05_3A:: ; heuristic: string; C0
Data_02D_5D90:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey?", $F1
    db "GreatLog's life", $FA, $F7
    db $EF, $EE, "force is coming", $EF, $EE, "back! And with", $FA, $F7
    db $EF, $EE, "such fervor! The", $EF, $EE, "Navel is sealed!", $F7
    db $F0

Message_05_3B:: ; heuristic: string; C0
Data_02D_5DFB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " I thank you", $F1
    db "all for coming!", $FA, $F7
    db $EF, $EE, "Let me introduce", $EF, $EE, "you to the hero,", $FA, $F7
    db $EF, $EE, $F9, "0, the savior", $EF, $EE, "of GreatLog!", $F7
    db $F0

Message_05_3C:: ; heuristic: string; C0
Data_02D_5E65:: ; address name
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

Message_05_3D:: ; heuristic: string; C0
Data_02D_5FA1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "King", $A3, " GreatLog's", $F1
    db "crisis has passed.", $FA, $F7
    db $EF, $EE, "We have nothing to", $EF, $EE, "fear now!", $FA, $F7
    db $EF, $EE, "The Log's Navel", $EF, $EE, "has been plugged!", $F7
    db $F0

Message_05_3E:: ; heuristic: string; C0
Data_02D_600C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Kameha", $A3, " I couldn't", $F1
    db "do anything, so", $FA, $F7
    db $EF, $EE, "you win, but just", $EF, $EE, "this time.", $FA, $F7
    db $EF, $EE, "But I'll take you", $EF, $EE, "on as a master", $FA, $F7
    db $EF, $EE, "next time. You be", $EF, $EE, "ready for me!", $F7
    db $F0

Message_05_3F:: ; heuristic: string; C0
Data_02D_6099:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I don't think I", $F1
    db "was anywhere near", $FA, $F7
    db $EF, $EE, "as resourceful", $EF, $EE, "when I was a kid", $A4, $F7
    db $F0

Message_05_40:: ; heuristic: string; C0
Data_02D_60E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, wow! You're", $F1
    db "really famous!", $F7
    db $F0

Message_05_41:: ; heuristic: string; C0
Data_02D_6105:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I hate myself", $F1
    db "for not doing", $FA, $F7
    db $EF, $EE, "anything to help", $EF, $EE, "during the crisis.", $F7
    db $F0

Message_05_42:: ; heuristic: string; C0
Data_02D_614D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I'm sorry for", $F1
    db "doubting you.", $FA, $F7
    db $EF, $EE, "I'll believe you", $EF, $EE, "next time!", $FA, $F7
    db $EF, $EE, "But, I hope there", $EF, $EE, "isn't a next time!", $F7
    db $F0

Message_05_43:: ; heuristic: string; C0
Data_02D_61B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $44, " like my", $F1
    db "grandchildren to", $FA, $F7
    db $EF, $EE, "learn something", $EF, $EE, "from you!", $F7
    db $F0

Message_05_44:: ; heuristic: string; C0
Data_02D_61F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $A4, $A4, "I can't eat", $F1
    db "another", $A4, " Zzz", $A4, $F7
    db $F0

Message_05_45:: ; heuristic: string; C0
Data_02D_6210:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're today's", $F1
    db "guest of honor!", $FA, $F7
    db $EF, $EE, "You can't be", $EF, $EE, "wandering here!", $F7
    db $F0

Message_05_46:: ; heuristic: string; C0
Data_02D_6251:: ; address name
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

Message_05_47:: ; heuristic: string; C0
Data_02D_63B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hehehe, no need", $F1
    db "to worry there!", $F7
    db $F0

Message_05_48:: ; heuristic: string; C0
Data_02D_63D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " Wa-hey!", $F1
    db "Instead of a quest", $FA, $F7
    db $EF, $EE, "for a replacement", $EF, $EE, "plug, you can go", $FA, $F7
    db $EF, $EE, "on a journey for", $EF, $EE, "yourself, warooh!", $F7
    db $F0

Message_05_49:: ; heuristic: string; C0
Data_02D_644B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Warubou", $A3, " No one", $F1
    db "knows how many", $FA, $F7
    db $EF, $EE, "other worlds exist", $EF, $EE, "out there.", $FA, $F7
    db $EF, $EE, "You'll never ever", $EF, $EE, "run out of other", $FA, $F7
    db $EF, $EE, "worlds to explore,", $EF, $EE, "warooh!", $F7
    db $F0

Message_05_4A:: ; heuristic: string; C0
Data_02D_64D3:: ; address name
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

Message_05_4B:: ; heuristic: string; C0
Data_02D_6616:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $44, " heard from", $F1
    db "Lord Darck, but it", $FA, $F7
    db $EF, $EE, "really was you", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Did you bring the", $EF, $EE, "treasures?", $FF, $F0

Message_05_51:: ; heuristic: string; C0
Data_02D_6672:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Surprisingly", $F1
    db "obedient, are you?", $FA, $F7
    db $EF, $EE, "Hand over the", $EF, $EE, "treasures!", $F7
    db $F0

Message_05_52:: ; heuristic: string; C0
Data_02D_66B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 handed over", $F1
    db "the TidalBell.", $FA, $F7
    db $EF, $EE, $F9, "0 handed over", $EF, $EE, "the HarMirror.", $FA, $F7
    db $EF, $EE, $F9, "0 handed over", $EF, $EE, "the SkyShield.", $F7
    db $F0

Message_05_53:: ; heuristic: string; C0
Data_02D_6716:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Take these to", $F1
    db "Lord Darck now.", $F7
    db $F0

Message_05_54:: ; heuristic: string; C0
Data_02D_6738:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " My work is done", $A4, $F1
    db "I am now free to", $FA, $F7
    db $EF, $EE, "fight you without", $EF, $EE, "restraint!", $F7
    db $F0

Message_05_55:: ; heuristic: string; C0
Data_02D_677F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You seem to", $F1
    db "still not realize", $FA, $F7
    db $EF, $EE, "how puny and weak", $EF, $EE, "you are.", $FA, $F7
    db $EF, $EE, "Well, I will", $EF, $EE, "shatter your", $FA, $F7
    db $EF, $EE, "misplaced courage", $EF, $EE, "once and for all!", $F7
    db $F0

Message_05_56:: ; heuristic: string; C0
Data_02D_6806:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " N", $A4, " No", $A4, " How could", $F1
    db "my monsters lose", $A4, $FA, $F7
    db $EF, $EE, "I did just as Lord", $EF, $EE, "Darck bade me", $A4, $FA, $F7
    db $EF, $EE, "And obtained the", $EF, $EE, "treasures of the", $FA, $F7
    db $EF, $EE, "other worlds", $A4, $EF, $EE, "I did", $A4, $FA, $F7
    db $EF, $EE, "In return, he was", $EF, $EE, "supposed to give", $FA, $F7
    db $EF, $EE, "me the strongest", $EF, $EE, "monsters", $A4, " Why", $A4, $FA, $F7
    db $EF, $EE, "Why can't I beat", $EF, $EE, "your monsters?", $F7
    db $F0

Message_05_57:: ; heuristic: string; C0
Data_02D_6900:: ; address name
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

Message_05_58:: ; heuristic: string; C0
Data_02D_6BED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "Darck", $A3, " Fwahahahah!", $F1
    db "Bravo! Splendid!", $FA, $F7
    db $EF, $EE, "You", $42, "e come back", $EF, $EE, "again for me!", $FA, $F7
    db $EF, $EE, "You are a great", $EF, $EE, "collector!", $FA, $F7
    db $EF, $EE, "Defeat me and the", $EF, $EE, "treasure is yours!", $FA, $F7
    db $EF, $EE, "Come at me with", $EF, $EE, "everything!", $F7
    db $F0

Message_05_59:: ; heuristic: string; C0
Data_02D_6C9D:: ; address name
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

Message_05_5A:: ; heuristic: string; C0
Data_02D_6E3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A voice echoed", $F1
    db "from nowhere", $A4, $F7
    db $F0

Message_05_5B:: ; heuristic: string; C0
Data_02D_6E5A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wa-hey! can you", $F1
    db "hear me, ", $F9, "0?", $FA, $F7
    db $EF, $EE, "You found a plug", $EF, $EE, "for the Navel!", $FA, $F7
    db $EF, $EE, "I'll bring you", $EF, $EE, "back to GreatLog!", $FA, $F7
    db $EF, $EE, "Stand still,", $EF, $EE, "warooh!", $F7
    db $F0

Message_05_5C:: ; heuristic: string; C0
Data_02D_6EDC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " How dare you", $F1
    db "come without the", $FA, $F7
    db $EF, $EE, "treasures", $A4, " You", $EF, $EE, "have some nerve!", $FA, $F7
    db $EF, $EE, "You're not getting", $EF, $EE, "past me without", $FA, $F7
    db $EF, $EE, "showing me the", $EF, $EE, "treasures.", $F7
    db $F0

Message_05_5D:: ; heuristic: string; C0
Data_02D_6F66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You didn't bring", $F1
    db "the treasures?", $FA, $F7
    db $EF, $EE, "Well, hurry up and", $EF, $EE, "bring them!", $FA, $F7
    db $EF, $EE, "You have only a", $EF, $EE, "little time left!", $F7
    db $F0

Message_05_5E:: ; heuristic: string; C0
Data_02D_6FD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Magic Keys", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "The last keys lead", $EF, $EE, "to worlds that are", $FA, $F7
    db $EF, $EE, "inhabited by rare", $EF, $EE, "monsters.", $95, $F7
    db $F0

Message_05_5F:: ; heuristic: string; C0
Data_02D_704B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "bookshelf.", $FA, $F7
    db $EF, $EE, $95, "Magic Keys", $A4, $EF, $EE, $FA, $F7
    db $EF, $EE, $F3, "Keys that feature", $EF, $EE, "a family name,", $FA, $F7
    db $EF, $EE, "like FirstSlime", $EF, $EE, "Key, go to a world", $FA, $F7
    db $EF, $EE, "that is inhabited", $EF, $EE, "by that family.", $95, $F7
    db $F0

Message_05_60:: ; heuristic: string; C0
Data_02D_70EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Awooh! I'm hot!", $F1
    db "Let's go already!", $F7
    db $F0

Message_05_95:: ; heuristic: string; C0
Data_02D_7110:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm going to work", $F1
    db "hard and earn", $FA, $F7
    db $EF, $EE, "myself ", $F9, "0's", $EF, $EE, "praise.", $F7
    db $F0

Message_05_96:: ; heuristic: string; C0
Data_02D_714A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm plenty good", $F1
    db "enough by myself.", $FA, $F7
    db $EF, $EE, "There is no need", $EF, $EE, "for others.", $F7
    db $F0

Message_05_97:: ; heuristic: string; C0
Data_02D_7190:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0, I will", $F1
    db "fight with my life", $FA, $F7
    db $EF, $EE, "for your honor and", $EF, $EE, "glory.", $F7
    db $F0

Message_05_98:: ; heuristic: string; C0
Data_02D_71D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll take the", $F1
    db "point in battle!", $FA, $F7
    db $EF, $EE, "Let me take charge", $EF, $EE, "of the situation!", $F7
    db $F0

Message_05_99:: ; heuristic: string; C0
Data_02D_721B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $44, " like to see", $F1
    db "how well you can", $FA, $F7
    db $EF, $EE, "command us in", $EF, $EE, "battle.", $F7
    db $F0

Message_05_9A:: ; heuristic: string; C0
Data_02D_7259:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0, how about", $F1
    db "you battle next?", $F7
    db $F0

Message_05_9B:: ; heuristic: string; C0
Data_02D_727C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I don't need any", $F1
    db "backup.", $FA, $F7
    db $EF, $EE, "I'll just muscle", $EF, $EE, "through!", $F7
    db $F0

Message_05_9C:: ; heuristic: string; C0
Data_02D_72B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " No need for", $F1
    db "defense!", $FA, $F7
    db $EF, $EE, "Offense is what's", $EF, $EE, "important.", $F7
    db $F0

Message_05_9D:: ; heuristic: string; C0
Data_02D_72EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Watch what your", $F1
    db "opponent has", $A4, $FA, $F7
    db $EF, $EE, "Running away is a", $EF, $EE, "viable option", $A4, $F7
    db $F0

Message_05_9E:: ; heuristic: string; C0
Data_02D_7335:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If I don't get", $F1
    db "an order, I won't", $FA, $F7
    db $EF, $EE, "even bother to do", $EF, $EE, "any eating!", $F7
    db $F0

Message_05_9F:: ; heuristic: string; C0
Data_02D_737A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Make sure you", $F1
    db "heal me first if", $FA, $F7
    db $EF, $EE, "I'm hurt.", $EF, $EE, "Don't forget that!", $F7
    db $F0

Message_05_A0:: ; heuristic: string; C0
Data_02D_73BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I", $44, " rather be", $F1
    db "tending flowers", $FA, $F7
    db $EF, $EE, "than going out", $EF, $EE, "into battle", $A4, $F7
    db $F0

Message_05_A1:: ; heuristic: string; C0
Data_02D_73FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm going to get", $F1
    db "strong and impress", $FA, $F7
    db $EF, $EE, $F9, "0. Yes, I", $EF, $EE, "will!", $F7
    db $F0

Message_05_A2:: ; heuristic: string; C0
Data_02D_7439:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's OK", $A4, " I really", $F1
    db "didn't want any", $FA, $F7
    db $EF, $EE, "meat anyway,", $EF, $EE, "humph!", $F7
    db $F0

Message_05_A3:: ; heuristic: string; C0
Data_02D_7475:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Do you have your", $F1
    db "hankie and tissue?", $FA, $F7
    db $EF, $EE, "Oh, your buttons", $EF, $EE, "are crooked.", $F7
    db $F0

Message_05_A4:: ; heuristic: string; C0
Data_02D_74BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll do as I see", $F1
    db "fit, thank you.", $FA, $F7
    db $EF, $EE, "I don't need you to", $EF, $EE, "order me around.", $F7
    db $F0

Message_05_A5:: ; heuristic: string; C0
Data_02D_750B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Give me meat!", $F1
    db "Or I won't obey!", $F7
    db $F0

Message_05_A6:: ; heuristic: string; C0
Data_02D_752D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " In general, I am", $F1
    db "of the opinion", $FA, $F7
    db $EF, $EE, "that fighting is", $EF, $EE, "meaningless.", $F7
    db $F0

Message_05_A7:: ; heuristic: string; C0
Data_02D_7573:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If worse comes", $F1
    db "to worst, I'll use", $FA, $F7
    db $EF, $EE, "a mate as a shield", $EF, $EE, "to survive.", $F7
    db $F0

Message_05_A8:: ; heuristic: string; C0
Data_02D_75BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There isn't any", $F1
    db "point begging for", $FA, $F7
    db $EF, $EE, "mercy. I have no", $EF, $EE, "pity for losers.", $F7
    db $F0

Message_05_A9:: ; heuristic: string; C0
Data_02D_7606:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Um", $A4, " Uh", $A4, " Er", $A4, $F1
    db "It's nothing", $A4, $F7
    db $F0

Message_05_AA:: ; heuristic: string; C0
Data_02D_7623:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fighting isn't", $F1
    db "my idea of fun", $A4, $F7
    db $F0

Message_05_AB:: ; heuristic: string; C0
Data_02D_7645:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Awah!", $F1
    db "You startled me!", $FA, $F7
    db $EF, $EE, "Please don't sneak", $EF, $EE, "up on me.", $F7
    db $F0

Message_05_AC:: ; heuristic: string; C0
Data_02D_7680:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Please don't kill", $F1
    db "even enemies.", $F7
    db $F0

Message_05_AD:: ; heuristic: string; C0
Data_02D_76A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Yay! Woohoo!", $F1
    db "We're going out!", $F7
    db $F0

Message_05_AE:: ; heuristic: string; C0
Data_02D_76C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Aww", $A4, " Must we go?", $F1
    db "That's like work!", $F7
    db $F0

Message_05_AF:: ; heuristic: string; C0
Data_02D_76EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " OK! Come on!", $F1
    db $F9, "0 too, hustle!", $F7
    db $F0

Message_05_B0:: ; heuristic: string; C0
Data_02D_770B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Every day, we", $F1
    db "must strive to", $FA, $F7
    db $EF, $EE, "better ourselves!", $EF, $EE, "It is relentless!", $F7
    db $F0

Message_05_B1:: ; heuristic: string; C0
Data_02D_7754:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " As long as I'm", $F1
    db "around, you'll have", $FA, $F7
    db $EF, $EE, "nothing to fear", $EF, $EE, "from any monster!", $F7
    db $F0

Message_05_B2:: ; heuristic: string; C0
Data_02D_779F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Together, we", $F1
    db "shall form the", $FA, $F7
    db $EF, $EE, "world's greatest", $EF, $EE, "team!", $F7
    db $F0

Message_05_B3:: ; heuristic: string; C0
Data_02D_77D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you dawdle,", $F1
    db "I'm leaving you.", $F7
    db $F0

Message_05_B4:: ; heuristic: string; C0
Data_02D_77FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Normally, you", $F1
    db "don't deserve me.", $FA, $F7
    db $EF, $EE, "Don't you dare", $EF, $EE, "forget that.", $F7
    db $F0

Message_05_B5:: ; heuristic: string; C0
Data_02D_783E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If in the right", $F1
    db "mind for it, I can", $FA, $F7
    db $EF, $EE, "flip the world", $EF, $EE, "over on its axis!", $F7
    db $F0

Message_05_B6:: ; heuristic: string; C0
Data_02D_788A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I make my own", $F1
    db "roads!", $F7
    db $F0

Message_05_B7:: ; heuristic: string; C0
Data_02D_78A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Charge, charge,", $F1
    db "charge!", $FA, $F7
    db $EF, $EE, "There's no turning", $EF, $EE, "back, ever!", $F7
    db $F0

Message_05_B8:: ; heuristic: string; C0
Data_02D_78E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm looking", $F1
    db "forward to going", $FA, $F7
    db $EF, $EE, "on a journey with", $EF, $EE, "you.", $F7
    db $F0

Message_05_B9:: ; heuristic: string; C0
Data_02D_791C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " We have to stick", $F1
    db "to a schedule!", $F7
    db $F0

Message_05_BA:: ; heuristic: string; C0
Data_02D_7940:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I need to do", $F1
    db "things at my pace.", $FA, $F7
    db $EF, $EE, "My rhythm gets so", $EF, $EE, "thrown off", $A4, $F7
    db $F0

Message_05_BB:: ; heuristic: string; C0
Data_02D_7986:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Three meals and", $F1
    db "adequate sleep.", $FA, $F7
    db $EF, $EE, "That's all I need", $EF, $EE, "to be satisfied.", $F7
    db $F0

Message_05_BC:: ; heuristic: string; C0
Data_02D_79D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This adventure", $F1
    db "is exciting!", $FA, $F7
    db $EF, $EE, "Because I get to", $EF, $EE, "go with ", $F9, "0!", $F7
    db $F0

Message_05_BD:: ; heuristic: string; C0
Data_02D_7A11:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Don't pay any", $F1
    db "heed to me.", $FA, $F7
    db $EF, $EE, "I'll do whatever I", $EF, $EE, "must for myself.", $F7
    db $F0

Message_05_BE:: ; heuristic: string; C0
Data_02D_7A55:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0", $A4, " I must", $F1
    db "say this", $A4, $FA, $F7
    db $EF, $EE, "Your clothes are", $EF, $EE, "out of fashion.", $F7
    db $F0

Message_05_BF:: ; heuristic: string; C0
Data_02D_7A93:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm not good", $F1
    db "with combos", $A4, $F7
    db $F0

Message_05_C0:: ; heuristic: string; C0
Data_02D_7AB0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If I don't want", $F1
    db "to do something,", $FA, $F7
    db $EF, $EE, "you'll never get", $EF, $EE, "me to do it", $A4, $F7
    db $F0

Message_05_C1:: ; heuristic: string; C0
Data_02D_7AF5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll think up", $F1
    db "new plans!", $FA, $F7
    db $EF, $EE, "I'll teach them to", $EF, $EE, "you, ", $F9, "0!", $F7
    db $F0

Message_05_C2:: ; heuristic: string; C0
Data_02D_7B30:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $95, "Dirty", $95, " is just", $F1
    db "another way of", $FA, $F7
    db $EF, $EE, "saying 'shockingly", $EF, $EE, "effective,", $95, " pal.", $F7
    db $F0

Message_05_C3:: ; heuristic: string; C0
Data_02D_7B7A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you pull your", $F1
    db "punches, you'll be", $FA, $F7
    db $EF, $EE, "sure to regret it", $EF, $EE, "later.", $F7
    db $F0

Message_05_C4:: ; heuristic: string; C0
Data_02D_7BBE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Don't talk to me", $A4, $F1
    db "I don't like it", $A4, $F7
    db $F0

Message_05_C5:: ; heuristic: string; C0
Data_02D_7BE3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0, you sure", $F1
    db "work hard!", $FA, $F7
    db $EF, $EE, "You're just a", $EF, $EE, "little kid too!", $F7
    db $F0

Message_05_C6:: ; heuristic: string; C0
Data_02D_7C20:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let's stay away", $F1
    db "from danger.", $F7
    db $F0

Message_05_C7:: ; heuristic: string; C0
Data_02D_7C40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wouldn't it be", $F1
    db "nice if everyone,", $FA, $F7
    db $EF, $EE, "even our enemies,", $EF, $EE, "could be friends?", $F7
    db $F0

Message_05_C8:: ; heuristic: string; C0
Data_02D_7C8C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh, the weather", $F1
    db "is so gorgeous!", $FA, $F7
    db $EF, $EE, "We should go for a", $EF, $EE, "picnic!", $F7
    db $F0

Message_05_C9:: ; heuristic: string; C0
Data_02D_7CCF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I don't want to", $F1
    db "chat. Leave me be.", $F7
    db $F0

Message_05_CA:: ; heuristic: string; C0
Data_02D_7CF5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0! Let's get", $F1
    db "moving quick!", $FA, $F7
    db $EF, $EE, "I relish this", $EF, $EE, "challenge!", $F7
    db $F0

Message_05_CB:: ; heuristic: string; C0
Data_02D_7D31:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " For tomorrow's", $F1
    db "victories,", $FA, $F7
    db $EF, $EE, "I'll spare no", $EF, $EE, "effort today!", $F7
    db $F0

Message_05_CC:: ; heuristic: string; C0
Data_02D_7D6D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Check out this", $F1
    db "physique!", $FA, $F7
    db $EF, $EE, "Now this is what", $EF, $EE, "you call refined!", $F7
    db $F0

Message_05_CD:: ; heuristic: string; C0
Data_02D_7DB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " In battle, every", $F1
    db "second is a drama!", $F7
    db $F0

Message_05_CE:: ; heuristic: string; C0
Data_02D_7DD9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Gahahahahahah!", $F1
    db "Chaaaaaaaaaarge!", $FA, $F7
    db $EF, $EE, "Just hammer", $95, "em,", $EF, $EE, "I say. Hammer!", $F7
    db $F0

Message_05_CF:: ; heuristic: string; C0
Data_02D_7E20:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh? This human", $F1
    db "presumes to order", $FA, $F7
    db $EF, $EE, "me around?", $EF, $EE, "How absurd.", $F7
    db $F0

Message_05_D0:: ; heuristic: string; C0
Data_02D_7E60:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " No mercy needed", $F1
    db "for enemies!", $FA, $F7
    db $EF, $EE, "Smash", $95, "em all!", $EF, $EE, $F7
    db $F0

Message_05_D1:: ; heuristic: string; C0
Data_02D_7E94:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " No guts,", $F1
    db "no glory!", $F7
    db $F0

Message_05_D2:: ; heuristic: string; C0
Data_02D_7EAB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Even if there", $F1
    db "were a hundred", $FA, $F7
    db $EF, $EE, "enemies, I will", $EF, $EE, "keep marching on!", $F7
    db $F0

Message_05_D3:: ; heuristic: string; C0
Data_02D_7EF2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If I can get", $F1
    db "luck on my side,", $FA, $F7
    db $EF, $EE, "I can win them", $EF, $EE, "all.", $F7
    db $F0

Message_05_D4:: ; heuristic: string; C0
Data_02D_7F2C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Master, there", $F1
    db "should be rules", $FA, $F7
    db $EF, $EE, "within our party", $EF, $EE, "to keep order!", $F7
    db $F0
    ds $8E, $00
