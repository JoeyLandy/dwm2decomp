SECTION "Bank 2D", ROMX[$4000], BANK[$2D]
    db $2d

; message bank $2D: when wStringIndex < $D5, BeginStringDisplay with this bank's table
; MessageStrings_Bank2D; otherwise far-calls BeginStringDisplay_Bank2D_Overflow (E-0080)
BeginStringDisplay_Bank2D::
    ld a, [wStringIndex]
    cp $d5
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank2D_Overflow
    ret

.call_begin_string_display:
    ld de, MessageStrings_Bank2D
    call BeginStringDisplay
    ret

; message bank $2D: when wStringIndex < $D5, CopyStringToBuffer with this bank's table
; MessageStrings_Bank2D; otherwise far-calls CopyStringToBuffer_Bank2D_Overflow (E-0080)
CopyStringToBuffer_Bank2D::
    ld a, [wStringIndex]
    cp $d5
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank2D_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, MessageStrings_Bank2D
    call CopyStringToBuffer
    ret
    db $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_2D_4032::
MessageStrings_Bank2D::
    dw StringList_2D_4034 ; id 0

; category list of StringCategories_2D_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_2D_4034::
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

Message_05_00::
    db $eb, "*: ", $f9, "0", $a4, " There", $f1
    db "have been frequent", $fa, $f7
    db $ef, $ee, "earthquakes on the", $ef, $ee, "island.", $fa, $f7
    db $ef, $ee, "Is it a sign of", $ef, $ee, "coming trouble?", $fa, $f7
    db $ef, $ee, "I don't want you", $ef, $ee, "wandering off", $a4, $f7
    db $f0

Message_05_01::
    db $ea, "*: People have been", $f1
    db "whispering that", $fa, $f7
    db $ef, $ee, "GreatLog will sink", $ef, $ee, "into the sea.", $fa, $f7
    db $ef, $ee, "It's in times like", $ef, $ee, "this that one has", $fa, $f7
    db $ef, $ee, "to be cool, calm", $ef, $ee, "and collected.", $f7
    db $f0

Message_05_02::
    db $ea, "Cobi: ", $f9, "0, tell", $f1
    db "me about what", $fa, $f7
    db $ef, $ee, "you've been seeing", $ef, $ee, "in other worlds.", $fa, $f7
    db $ef, $ee, $a4, "A monster king", $ef, $ee, "and a collector", $a4, $fa, $f7
    db $ef, $ee, "That's a weird", $ef, $ee, "combination.", $fa, $f7
    db $ef, $ee, "Over here, there've", $ef, $ee, "been earthquakes.", $fa, $f7
    db $ef, $ee, "People think it's", $ef, $ee, "a bad omen.", $fa, $f7
    db $ef, $ee, "Anyway, what do", $ef, $ee, "you need today?", $f7
    db $f0

Message_05_03::
    db $eb, "Tara: Big brother,", $f1
    db "tell me about what", $fa, $f7
    db $ef, $ee, "you've seen in the", $ef, $ee, "other worlds.", $fa, $f7
    db $ef, $ee, "A collector king?", $ef, $ee, "And a monster?", $fa, $f7
    db $ef, $ee, "Wow, that's a very", $ef, $ee, "odd combination.", $fa, $f7
    db $ef, $ee, "There have been", $ef, $ee, "earthquakes every", $fa, $f7
    db $ef, $ee, "day here. Everyone", $ef, $ee, "has been saying", $fa, $f7
    db $ef, $ee, "GreatLog will sink", $ef, $ee, "into the sea.", $fa, $f7
    db $ef, $ee, "Anyway, do you", $ef, $ee, "need any help?", $f7
    db $f0

Message_05_04::
    db $ea, "*: If the island", $f1
    db "sink, is no worry,", $fa, $f7
    db $ef, $ee, "my friend! This", $ef, $ee, "rope save you!", $fa, $f7
    db $ef, $ee, "It climb up and up", $ef, $ee, "into the clouds!", $fa, $f7
    db $ef, $ee, "Is free to try", $ef, $ee, "now. You try!", $f7
    db $f0

Message_05_05::
    db $ea, "*: People have been", $f1
    db "saying that they", $fa, $f7
    db $ef, $ee, "may be able to", $ef, $ee, "survive at the top", $fa, $f7
    db $ef, $ee, "of the tree if the", $ef, $ee, "island sinks.", $f7
    db $f0

Message_05_06::
    db $ea, "*: Hey! You're the", $f1
    db "kid who said the", $fa, $f7
    db $ef, $ee, "island was going", $ef, $ee, "to sink!", $fa, $f7
    db $ef, $ee, "There've been many", $ef, $ee, "earthquakes", $a4, $fa, $f7
    db $ef, $ee, "Were you telling", $ef, $ee, "the truth?", $fa, $f7
    db $ef, $ee, "No, it can't be", $a4, $ef, $ee, "But then again", $a4, $f7
    db $f0

Message_05_07::
    db $eb, "*: Prince Kameha", $f1
    db "came back!", $fa, $f7
    db $ef, $ee, "What with the", $ef, $ee, "earthquakes and", $fa, $f7
    db $ef, $ee, "all, bad luck does", $ef, $ee, "come in bunches", $a4, $f7
    db $f0

Message_05_08::
    db $eb, "*: Hi! Have you", $f1
    db "heard?", $fa, $f7
    db $ef, $ee, "GreatLog is going", $ef, $ee, "to sink!", $fa, $f7
    db $ef, $ee, "I'll have to buy", $ef, $ee, "supplies and get", $fa, $f7
    db $ef, $ee, "ready for the", $ef, $ee, "disaster!", $f7
    db $f0

Message_05_09::
    db $eb, "*: My neighbor is", $f1
    db "buying all sorts", $fa, $f7
    db $ef, $ee, "of things in a", $ef, $ee, "panic, but", $a4, $fa, $f7
    db $ef, $ee, "What good will", $ef, $ee, "clothes or monster", $fa, $f7
    db $ef, $ee, "accessories do her", $ef, $ee, "now?", $f7
    db $f0

Message_05_0A::
    db $ea, "*: When things are", $f1
    db "tough, you can't", $fa, $f7
    db $ef, $ee, "afford to panic.", $ef, $ee, "Try to stay calm.", $f7
    db $f0

Message_05_0B::
    db $ea, "*: You, ", $f9, "0,", $f1
    db "come with me!", $fa, $f7
    db $ef, $ee, "Prince Kameha", $44, $ef, $ee, "finally returned", $fa, $f7
    db $ef, $ee, "from who knows", $ef, $ee, "where.", $fa, $f7
    db $ef, $ee, "It turns out that", $ef, $ee, "you dragged him", $fa, $f7
    db $ef, $ee, "back from another", $ef, $ee, "world.", $fa, $f7
    db $ef, $ee, "His Majesty wishes", $ef, $ee, "to see you.", $fa, $f7
    db $ef, $ee, "Come with me to", $ef, $ee, "the Castle!", $f7
    db $f0

Message_05_0C::
    db $ea, "*: My beloved", $f1
    db "island is sinking", $a4, $fa, $f7
    db $ef, $ee, "But I can't do a", $ef, $ee, "thing but watch", $a4, $f7
    db $f0

Message_05_0D::
    db $ea, "King: Ah, thanks", $f1
    db "for coming!", $fa, $f7
    db $ef, $ee, "I've heard from", $ef, $ee, "Kameha, it was", $fa, $f7
    db $ef, $ee, "you who brought", $ef, $ee, "him back.", $fa, $f7
    db $ef, $ee, "It's no wonder why", $ef, $ee, "he couldn't be", $fa, $f7
    db $ef, $ee, "found anywhere on", $ef, $ee, "the island.", $fa, $f7
    db $ef, $ee, "I'm glad that he", $ef, $ee, "was found.", $fa, $f7
    db $ef, $ee, "Take the contents", $ef, $ee, "of the chests in", $fa, $f7
    db $ef, $ee, "my chamber as my", $ef, $ee, "thanks.", $fa, $f7
    db $ef, $ee, "I hope you will", $ef, $ee, "remain a friend to", $fa, $f7
    db $ef, $ee, "Kameha. He can be", $ef, $ee, "mischievous, and", $fa, $f7
    db $ef, $ee, "get into trouble,", $ef, $ee, "but I hope you", $fa, $f7
    db $ef, $ee, "will stand by him", $ef, $ee, "as a friend.", $f7
    db $f0

Message_05_0E::
    db $ea, "King: Kameha came", $f1
    db "back safely from", $fa, $f7
    db $ef, $ee, "another world.", $ef, $ee, "I owe it all to", $fa, $f7
    db $ef, $ee, "you, so I must", $ef, $ee, "thank you somehow.", $fa, $f7
    db $ef, $ee, "You may take the", $ef, $ee, "contents of the", $fa, $f7
    db $ef, $ee, "treasure chests in", $ef, $ee, "my chamber.", $fa, $f7
    db $ef, $ee, "I hope you will", $ef, $ee, "remain a friend to", $fa, $f7
    db $ef, $ee, "Kameha. He has few", $ef, $ee, "friends his age.", $fa, $f7
    db $ef, $ee, "I'm sure that he", $ef, $ee, "is lonely.", $f7
    db $f0

Message_05_0F::
    db $ea, "King: There have", $f1
    db "been many quakes.", $fa, $f7
    db $ef, $ee, "I hope nothing", $ef, $ee, "will come of them.", $fa, $f7
    db $ef, $ee, "Our people can't", $ef, $ee, "live in security", $fa, $f7
    db $ef, $ee, "with that weighing", $ef, $ee, "on their minds.", $f7
    db $f0

Message_05_10::
    db $ea, "*: The frequent", $f1
    db "quakes have raised", $fa, $f7
    db $ef, $ee, "grave concerns", $ef, $ee, "among the people.", $fa, $f7
    db $ef, $ee, "Our investigations", $ef, $ee, "have so far failed", $fa, $f7
    db $ef, $ee, "to identify what", $ef, $ee, "is causing them.", $f7
    db $f0

Message_05_11::
    db $ea, "*: Beyond here is", $f1
    db "his Majesty and", $fa, $f7
    db $ef, $ee, "Prince Kameha's", $ef, $ee, "chamber.", $fa, $f7
    db $ef, $ee, "I've received word", $ef, $ee, "to let you pass.", $f7
    db $f0

Message_05_12::
    db $ea, "Kameha: Yo, ", $f9, "0.", $f1
    db "Thanks for coming.", $fa, $f7
    db $ef, $ee, "Pop's got his eye", $ef, $ee, "on me, so I", $fa, $f7
    db $ef, $ee, "can't get out of", $ef, $ee, "here now, but I'll", $fa, $f7
    db $ef, $ee, "get out to other", $ef, $ee, "worlds again!", $fa, $f7
    db $ef, $ee, "That's a promise.", $ef, $ee, "You just wait!", $f7
    db $f0

Message_05_13::
    db $ea, "*: I'm a scientist.", $f1
    db "I've been studying", $fa, $f7
    db $ef, $ee, "the results of", $ef, $ee, "breeding monsters.", $fa, $f7
    db $ef, $ee, "Would you like to", $ef, $ee, "try breeding a", $fa, $f7
    db $ef, $ee, "monster with my", $ef, $ee, "Gulpple?", $ff, $f0

Message_05_14::
    db $ea, "*: Well, let's see", $f1
    db "about breeding!", $f7
    db $f0

Message_05_15::
    db $ea, "*: Oh", $a4, " Perhaps on", $f1
    db "another occasion.", $f7
    db $f0

Message_05_16::
    db $ea, "*: Hm", $a4, " So that", $f1
    db "combination of", $fa, $f7
    db $ef, $ee, "parents results in", $ef, $ee, "this species", $a4, $fa, $f7
    db $ef, $ee, "I", $44, " better get home", $ef, $ee, "quickly and make a", $fa, $f7
    db $ef, $ee, "record of this", $ef, $ee, "finding.", $f7
    db $f0

Message_05_17::
    db $ea, "*: GreatLog is", $f1
    db "sinking I heard,", $fa, $f7
    db $ef, $ee, "but I don't want", $ef, $ee, "to leave here.", $fa, $f7
    db $ef, $ee, "So I came up here", $ef, $ee, "for now.", $f7
    db $f0

Message_05_18::
    db $ea, "*: I've never once", $f1
    db "left the island.", $fa, $f7
    db $ef, $ee, "I can't imagine", $ef, $ee, "living elsewhere.", $f7
    db $f0

Message_05_19::
    db $eb, "*: This is a time", $f1
    db "we need Warubou's", $fa, $f7
    db $ef, $ee, "help the most.", $ef, $ee, "But I've heard it's", $fa, $f7
    db $ef, $ee, "stuck itself in a", $ef, $ee, "hole and is", $fa, $f7
    db $ef, $ee, "playing.", $f7
    db $f0

Message_05_1A::
    db $eb, "*: I didn't want to", $f1
    db "believe GreatLog", $fa, $f7
    db $ef, $ee, "is sinking, but", $ef, $ee, "seeing the changes", $fa, $f7
    db $ef, $ee, "that have been", $ef, $ee, "taking place", $a4, $fa, $f7
    db $ef, $ee, "I have no choice", $ef, $ee, "but to believe.", $f7
    db $f0

Message_05_1B::
    db $ea, "*: I won't believe", $f1
    db "that GreatLog is", $fa, $f7
    db $ef, $ee, "sinking. That just", $ef, $ee, "can't happen!", $fa, $f7
    db $ef, $ee, "It has to be one", $ef, $ee, "of Warubou's usual", $fa, $f7
    db $ef, $ee, "pranks.", $ef, $ee, "I'm convinced.", $f7
    db $f0

Message_05_1C::
    db $ea, "*: The King said", $f1
    db "that GreatLog will", $fa, $f7
    db $ef, $ee, "not sink, but if", $ef, $ee, "not, what's causing", $fa, $f7
    db $ef, $ee, "all the changes on", $ef, $ee, "the island?", $f7
    db $f0

Message_05_1D::
    db $ea, "*: Everyone, please", $f1
    db "remain calm.", $fa, $f7
    db $ef, $ee, "Even if GreatLog", $ef, $ee, "were to sink, we", $fa, $f7
    db $ef, $ee, "have enough ships", $ef, $ee, "to evacuate the", $fa, $f7
    db $ef, $ee, "entire population", $ef, $ee, "easily.", $f7
    db $f0

Message_05_1E::
    db $eb, "*: The GreatLog", $f1
    db "tree appeared to", $fa, $f7
    db $ef, $ee, "be healthy", $a4, " Could", $ef, $ee, "it be at the end", $fa, $f7
    db $ef, $ee, "of its natural", $ef, $ee, "lifespan?", $f7
    db $f0

Message_05_1F::
    db $ea, "*: Right now, we", $f1
    db "are investigating", $fa, $f7
    db $ef, $ee, "what is causing", $ef, $ee, "the earthquakes.", $fa, $f7
    db $ef, $ee, "Please don't panic,", $ef, $ee, "and stay home.", $f7
    db $f0

Message_05_20::
    db $ea, "*: I've studied", $f1
    db "GreatLog over a", $fa, $f7
    db $ef, $ee, "long time.", $ef, $ee, "I've never seen", $fa, $f7
    db $ef, $ee, "changes this", $ef, $ee, "profound, however.", $f7
    db $f0

Message_05_21::
    db $ea, "*: The Arena is", $f1
    db "closed under the", $fa, $f7
    db $ef, $ee, "King's decree.", $ef, $ee, "The whole island", $fa, $f7
    db $ef, $ee, "is too jumpy over", $ef, $ee, "the earthquakes.", $f7
    db $f0

Message_05_22::
    db $ea, "*: It's been decided", $f1
    db "to shut down the", $fa, $f7
    db $ef, $ee, "Arena for a", $ef, $ee, "while.", $fa, $f7
    db $ef, $ee, "The rumors about", $ef, $ee, "the island sinking", $fa, $f7
    db $ef, $ee, "kept people away", $ef, $ee, "anyway.", $f7
    db $f0

Message_05_23::
    db $ea, "*: Don't be fooled", $f1
    db "by those rumors", $fa, $f7
    db $ef, $ee, "about GreatLog", $ef, $ee, "sinking.", $fa, $f7
    db $ef, $ee, "We must be most", $ef, $ee, "vigilant against", $fa, $f7
    db $ef, $ee, "the horrifying", $ef, $ee, "prospect of panic.", $f7
    db $f0

Message_05_24::
    db $eb, "*: He can talk", $f1
    db "tough now, but", $a4, $fa, $f7
    db $ef, $ee, "What will we do if", $ef, $ee, "GreatLog sinks?", $f7
    db $f0

Message_05_25::
    db $eb, "*: Everyone's saying", $f1
    db "GreatLog'll sink!", $f7
    db $f0

Message_05_26::
    db $ea, "*: If GreatLog were", $f1
    db "to sink, we will", $fa, $f7
    db $ef, $ee, "keep its memory", $ef, $ee, "alive forever.", $f7
    db $f0

Message_05_27::
    db $ea, "*: I'm an adult so I", $f1
    db "can live anywhere.", $fa, $f7
    db $ef, $ee, "But I feel bad for", $ef, $ee, "my granddaughter", $fa, $f7
    db $ef, $ee, "who'll have to", $ef, $ee, "leave her friends.", $f7
    db $f0

Message_05_28::
    db $eb, "*: I don't want to", $f1
    db "leave GreatLog!", $fa, $f7
    db $ef, $ee, "I'm not leaving my", $ef, $ee, "friends behind!", $fa, $f7
    db $ef, $ee, "If I can't take", $ef, $ee, "Butch, I'm staying!", $f7
    db $f0

Message_05_29::
    db $ea, "*: Grandpa and the", $f1
    db "others are going", $fa, $f7
    db $ef, $ee, "to evacuate from", $ef, $ee, "GreatLog", $a4, $fa, $f7
    db $ef, $ee, "But there are too", $ef, $ee, "many people", $a4, $fa, $f7
    db $ef, $ee, "They have no room", $ef, $ee, "to take me", $a4, $f7
    db $f0

Message_05_2A::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Are you ready?", $fa, $f7
    db $ef, $ee, "Ready for Limbo?", $ef, $ee, "Warooh!", $ff, $f0

Message_05_2B::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Take the treasures", $fa, $f7
    db $ef, $ee, "that didn't work", $ef, $ee, "as the plug.", $fa, $f7
    db $ef, $ee, "Heheh, I repaired", $ef, $ee, "them and hung onto", $fa, $f7
    db $ef, $ee, "them, warooh!", $ef, $ee, "Take them now!", $f7
    db $f0

Message_05_2C::
    db $f9, "0 received the", $f1
    db "TidalBell.", $f7
    db $f0

Message_05_2D::
    db $f9, "0 received the", $f1
    db "HarMirror.", $f7
    db $f0

Message_05_2E::
    db $f9, "0 received the", $f1
    db "SkyShield.", $f7
    db $f0

Message_05_2F::
    db $ea, "Warubou: Limbo is", $f1
    db "the King's domain!", $fa, $f7
    db $ef, $ee, "You be careful,", $ef, $ee, "warooh!", $f7
    db $f0

Message_05_30::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Take the treasures", $fa, $f7
    db $ef, $ee, "that didn't work", $ef, $ee, "as the plug.", $fa, $f7
    db $ef, $ee, $a4, "Oh? You don't have", $ef, $ee, "enough room.", $f7
    db $f0

Message_05_31::
    db $ea, "Warubou: Wa-hey,", $f1
    db "well, hurry it up!", $fa, $f7
    db $ef, $ee, "When you're ready,", $ef, $ee, "I'll give you the", $fa, $f7
    db $ef, $ee, "three treasures", $ef, $ee, "then, warooh!", $f7
    db $f0

Message_05_32::
    db $ea, "Warubou: Wa-hey,", $f1
    db "you have to find", $fa, $f7
    db $ef, $ee, "a plug this time", $ef, $ee, "for sure, warooh!", $fa, $f7
    db $ef, $ee, "GreatLog has no", $ef, $ee, "life force left", $a4, $f7
    db $f0

Message_05_33::
    db $ea, "Warubou: Wa-hey,", $f1
    db "you did it, ", $f9, "0!", $fa, $f7
    db $ef, $ee, "I'll share some of", $ef, $ee, "GreatLog's energy.", $f7
    db $f0

Message_05_34::
    db $ea, "Warubou: There!", $f1
    db "All healthy now!", $fa, $f7
    db $ef, $ee, "Let me see,", $ef, $ee, "warooh!", $f7
    db $f0

Message_05_35::
    db $ea, "Warubou: So this", $f1
    db "is the MagicPlug", $a4, $fa, $f7
    db $ef, $ee, "Wa-hey, ", $f9, "0,", $ef, $ee, "I believed in you!", $fa, $f7
    db $ef, $ee, "Let's see if it", $ef, $ee, "will work, warooh!", $f7
    db $f0

Message_05_36::
    db $ea, "Warubou: There!", $f1
    db "It's a perfect fit!", $fa, $f7
    db $ef, $ee, "You finally did", $ef, $ee, "it, ", $f9, "0, warooh!", $f7
    db $f0

Message_05_37::
    db $ea, "Warubou:", $f1
    db "Wa-wa-hey! We were", $fa, $f7
    db $ef, $ee, "too late! The", $ef, $ee, "Navel's closed, but", $fa, $f7
    db $ef, $ee, "not enough life", $ef, $ee, "force was left to", $fa, $f7
    db $ef, $ee, "support the", $ef, $ee, "island!", $f7
    db $f0

Message_05_38::
    db $ea, "Warubou: Wa-hey", $a4, $f1
    db "That's it, then.", $fa, $f7
    db $ef, $ee, "There's nothing we", $ef, $ee, "can do now,", $fa, $f7
    db $ef, $ee, "warooh", $a4, " You did", $ef, $ee, "well, but maybe", $fa, $f7
    db $ef, $ee, "this is fate.", $ef, $ee, "Tell everyone to", $fa, $f7
    db $ef, $ee, "leave the island.", $ef, $ee, "I'll try to buy a", $fa, $f7
    db $ef, $ee, "little more time", $a4, $ef, $ee, "This is goodbye.", $fa, $f7
    db $ef, $ee, "Take care, ", $f9, "0.", $ef, $ee, $f7
    db $f0

Message_05_39::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Get going!", $f7
    db $f0

Message_05_3A::
    db $ea, "Warubou: Wa-hey?", $f1
    db "GreatLog's life", $fa, $f7
    db $ef, $ee, "force is coming", $ef, $ee, "back! And with", $fa, $f7
    db $ef, $ee, "such fervor! The", $ef, $ee, "Navel is sealed!", $f7
    db $f0

Message_05_3B::
    db $ea, "King: I thank you", $f1
    db "all for coming!", $fa, $f7
    db $ef, $ee, "Let me introduce", $ef, $ee, "you to the hero,", $fa, $f7
    db $ef, $ee, $f9, "0, the savior", $ef, $ee, "of GreatLog!", $f7
    db $f0

Message_05_3C::
    db $ea, "King: Even though", $f1
    db "the island's crisis", $fa, $f7
    db $ef, $ee, "was caused by", $ef, $ee, "Kameha, I'm unhappy", $fa, $f7
    db $ef, $ee, "that no one paid", $ef, $ee, "any heed to your", $fa, $f7
    db $ef, $ee, "dire warnings.", $ef, $ee, "Quite shameful.", $fa, $f7
    db $ef, $ee, "But your actions", $ef, $ee, "moved the hearts", $fa, $f7
    db $ef, $ee, "and souls of all", $ef, $ee, "of us.", $fa, $f7
    db $ef, $ee, $f9, "0, words could", $ef, $ee, "never express our", $fa, $f7
    db $ef, $ee, "feelings of thanks", $ef, $ee, "to you!", $fa, $f7
    db $ef, $ee, "Come, let us all", $ef, $ee, "celebrate!", $f7
    db $f0

Message_05_3D::
    db $ea, "King: GreatLog's", $f1
    db "crisis has passed.", $fa, $f7
    db $ef, $ee, "We have nothing to", $ef, $ee, "fear now!", $fa, $f7
    db $ef, $ee, "The Log's Navel", $ef, $ee, "has been plugged!", $f7
    db $f0

Message_05_3E::
    db $ea, "Kameha: I couldn't", $f1
    db "do anything, so", $fa, $f7
    db $ef, $ee, "you win, but just", $ef, $ee, "this time.", $fa, $f7
    db $ef, $ee, "But I'll take you", $ef, $ee, "on as a master", $fa, $f7
    db $ef, $ee, "next time. You be", $ef, $ee, "ready for me!", $f7
    db $f0

Message_05_3F::
    db $ea, "*: I don't think I", $f1
    db "was anywhere near", $fa, $f7
    db $ef, $ee, "as resourceful", $ef, $ee, "when I was a kid", $a4, $f7
    db $f0

Message_05_40::
    db $eb, "*: Oh, wow! You're", $f1
    db "really famous!", $f7
    db $f0

Message_05_41::
    db $ea, "*: I hate myself", $f1
    db "for not doing", $fa, $f7
    db $ef, $ee, "anything to help", $ef, $ee, "during the crisis.", $f7
    db $f0

Message_05_42::
    db $eb, "*: I'm sorry for", $f1
    db "doubting you.", $fa, $f7
    db $ef, $ee, "I'll believe you", $ef, $ee, "next time!", $fa, $f7
    db $ef, $ee, "But, I hope there", $ef, $ee, "isn't a next time!", $f7
    db $f0

Message_05_43::
    db $ea, "*: I", $44, " like my", $f1
    db "grandchildren to", $fa, $f7
    db $ef, $ee, "learn something", $ef, $ee, "from you!", $f7
    db $f0

Message_05_44::
    db $ea, "*: ", $a4, $a4, "I can't eat", $f1
    db "another", $a4, " Zzz", $a4, $f7
    db $f0

Message_05_45::
    db $ea, "*: You're today's", $f1
    db "guest of honor!", $fa, $f7
    db $ef, $ee, "You can't be", $ef, $ee, "wandering here!", $f7
    db $f0

Message_05_46::
    db $ea, "Cobi: ", $f9, "0,", $f1
    db "congratulations!", $fa, $f7
    db $ef, $ee, "I thought we were", $ef, $ee, "in deep trouble", $fa, $f7
    db $ef, $ee, "when the first", $ef, $ee, "Navel plug broke", $a4, $fa, $f7
    db $ef, $ee, "But you saved the", $ef, $ee, "island by teaming", $fa, $f7
    db $ef, $ee, "up with monsters!", $ef, $ee, "Good going!", $fa, $f7
    db $ef, $ee, "Wait", $a4, " Why are you", $ef, $ee, "so glum?", $fa, $f7
    db $ef, $ee, "Oh, I know, you've", $ef, $ee, "gotten to like", $fa, $f7
    db $ef, $ee, "traveling to other", $ef, $ee, "worlds and meeting", $fa, $f7
    db $ef, $ee, "people with your", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "You're going to", $ef, $ee, "miss it, right?", $f7
    db $f0

Message_05_47::
    db $ea, "*: Hehehe, no need", $f1
    db "to worry there!", $f7
    db $f0

Message_05_48::
    db $ea, "Warubou: Wa-hey!", $f1
    db "Instead of a quest", $fa, $f7
    db $ef, $ee, "for a replacement", $ef, $ee, "plug, you can go", $fa, $f7
    db $ef, $ee, "on a journey for", $ef, $ee, "yourself, warooh!", $f7
    db $f0

Message_05_49::
    db $ea, "Warubou: No one", $f1
    db "knows how many", $fa, $f7
    db $ef, $ee, "other worlds exist", $ef, $ee, "out there.", $fa, $f7
    db $ef, $ee, "You'll never ever", $ef, $ee, "run out of other", $fa, $f7
    db $ef, $ee, "worlds to explore,", $ef, $ee, "warooh!", $f7
    db $f0

Message_05_4A::
    db $eb, "Tara: ", $f9, "0,", $f1
    db "congratulations!", $fa, $f7
    db $ef, $ee, "I was sad that no", $ef, $ee, "one would believe", $fa, $f7
    db $ef, $ee, "us, but you saved", $ef, $ee, "GreatLog with your", $fa, $f7
    db $ef, $ee, "monster friends.", $ef, $ee, "That's great!", $fa, $f7
    db $ef, $ee, "Oh? You look sort", $ef, $ee, "of sad, somehow.", $fa, $f7
    db $ef, $ee, "Oh, wait, you've", $ef, $ee, "gotten to enjoy", $fa, $f7
    db $ef, $ee, "going to other", $ef, $ee, "worlds and meeting", $fa, $f7
    db $ef, $ee, "people with your", $ef, $ee, "monsters.", $fa, $f7
    db $ef, $ee, "You must be sad", $ef, $ee, "that it's over.", $f7
    db $f0

Message_05_4B::
    db $ea, "*: I", $44, " heard from", $f1
    db "Lord Darck, but it", $fa, $f7
    db $ef, $ee, "really was you", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Did you bring the", $ef, $ee, "treasures?", $ff, $f0

Message_05_51::
    db $ea, "*: Surprisingly", $f1
    db "obedient, are you?", $fa, $f7
    db $ef, $ee, "Hand over the", $ef, $ee, "treasures!", $f7
    db $f0

Message_05_52::
    db $f9, "0 handed over", $f1
    db "the TidalBell.", $fa, $f7
    db $ef, $ee, $f9, "0 handed over", $ef, $ee, "the HarMirror.", $fa, $f7
    db $ef, $ee, $f9, "0 handed over", $ef, $ee, "the SkyShield.", $f7
    db $f0

Message_05_53::
    db $ea, "*: Take these to", $f1
    db "Lord Darck now.", $f7
    db $f0

Message_05_54::
    db $ea, "*: My work is done", $a4, $f1
    db "I am now free to", $fa, $f7
    db $ef, $ee, "fight you without", $ef, $ee, "restraint!", $f7
    db $f0

Message_05_55::
    db $ea, "*: You seem to", $f1
    db "still not realize", $fa, $f7
    db $ef, $ee, "how puny and weak", $ef, $ee, "you are.", $fa, $f7
    db $ef, $ee, "Well, I will", $ef, $ee, "shatter your", $fa, $f7
    db $ef, $ee, "misplaced courage", $ef, $ee, "once and for all!", $f7
    db $f0

Message_05_56::
    db $ea, "*: N", $a4, " No", $a4, " How could", $f1
    db "my monsters lose", $a4, $fa, $f7
    db $ef, $ee, "I did just as Lord", $ef, $ee, "Darck bade me", $a4, $fa, $f7
    db $ef, $ee, "And obtained the", $ef, $ee, "treasures of the", $fa, $f7
    db $ef, $ee, "other worlds", $a4, $ef, $ee, "I did", $a4, $fa, $f7
    db $ef, $ee, "In return, he was", $ef, $ee, "supposed to give", $fa, $f7
    db $ef, $ee, "me the strongest", $ef, $ee, "monsters", $a4, " Why", $a4, $fa, $f7
    db $ef, $ee, "Why can't I beat", $ef, $ee, "your monsters?", $f7
    db $f0

Message_05_57::
    db $ea, "Darck: Fawahahah!", $f1
    db "You chased your", $fa, $f7
    db $ef, $ee, "treasures here,", $ef, $ee, "did you?", $fa, $f7
    db $ef, $ee, "Fantastic! You're", $ef, $ee, "a true collector!", $fa, $f7
    db $ef, $ee, "You see, I believe", $ef, $ee, "that there are two", $fa, $f7
    db $ef, $ee, "varieties of", $ef, $ee, "collectors.", $fa, $f7
    db $ef, $ee, "There are those", $ef, $ee, "who collect things", $fa, $f7
    db $ef, $ee, "of value only to", $ef, $ee, "themselves.", $fa, $f7
    db $ef, $ee, "And then there are", $ef, $ee, "collectors of what", $fa, $f7
    db $ef, $ee, "evokes desire and", $ef, $ee, "envy in others.", $fa, $f7
    db $ef, $ee, "Even though the", $ef, $ee, "act of collecting", $fa, $f7
    db $ef, $ee, "is the same, the", $ef, $ee, "motivation is", $fa, $f7
    db $ef, $ee, "entirely different", $ef, $ee, "for the two types.", $fa, $f7
    db $ef, $ee, "The vanity and the", $ef, $ee, "greed that lurk", $fa, $f7
    db $ef, $ee, "deep in hearts,", $ef, $ee, "when they are", $fa, $f7
    db $ef, $ee, "unleashed, they", $ef, $ee, "give me power.", $fa, $f7
    db $ef, $ee, "If you defeat me,", $ef, $ee, "the MagicPlug", $fa, $f7
    db $ef, $ee, "shall be yours.", $ef, $ee, "But, you won't.", $fa, $f7
    db $ef, $ee, "For this is where", $ef, $ee, "you die.", $fa, $f7
    db $ef, $ee, "Your despair, your", $ef, $ee, "anger, they will", $fa, $f7
    db $ef, $ee, "all make me even", $ef, $ee, "more powerful.", $fa, $f7
    db $ef, $ee, "Fwahahahahahah!", $ef, $ee, $f7
    db $f0

Message_05_58::
    db $ea, "Darck: Fwahahahah!", $f1
    db "Bravo! Splendid!", $fa, $f7
    db $ef, $ee, "You've come back", $ef, $ee, "again for me!", $fa, $f7
    db $ef, $ee, "You are a great", $ef, $ee, "collector!", $fa, $f7
    db $ef, $ee, "Defeat me and the", $ef, $ee, "treasure is yours!", $fa, $f7
    db $ef, $ee, "Come at me with", $ef, $ee, "everything!", $f7
    db $f0

Message_05_59::
    db $ea, "Darck: ", $a4, "Wha", $a4, " What?", $f1
    db "How could I", $a4, $fa, $f7
    db $ef, $ee, "I see", $a4, " It was I", $ef, $ee, "who was mistaken", $a4, $fa, $f7
    db $ef, $ee, "You collected not", $ef, $ee, "out of vanity or", $fa, $f7
    db $ef, $ee, "greed. No, it was", $ef, $ee, "something else", $a4, $fa, $f7
    db $ef, $ee, "It was a different", $ef, $ee, "motive altogether", $a4, $fa, $f7
    db $ef, $ee, "One that I could", $ef, $ee, "not understand", $a4, $fa, $f7
    db $ef, $ee, "And one that did", $ef, $ee, "not give me power", $a4, $fa, $f7
    db $ef, $ee, "You are the worst", $ef, $ee, "kind of collector", $a4, $fa, $f7
    db $ef, $ee, "But you've managed", $ef, $ee, "to collect the", $fa, $f7
    db $ef, $ee, "best partners for", $ef, $ee, "yourself", $a4, $fa, $f7
    db $ef, $ee, "Urrgh", $a4, " You win", $a4, $ef, $ee, "Open that chest", $a4, $f7
    db $f0

Message_05_5A::
    db "A voice echoed", $f1
    db "from nowhere", $a4, $f7
    db $f0

Message_05_5B::
    db $ea, "*: Wa-hey! can you", $f1
    db "hear me, ", $f9, "0?", $fa, $f7
    db $ef, $ee, "You found a plug", $ef, $ee, "for the Navel!", $fa, $f7
    db $ef, $ee, "I'll bring you", $ef, $ee, "back to GreatLog!", $fa, $f7
    db $ef, $ee, "Stand still,", $ef, $ee, "warooh!", $f7
    db $f0

Message_05_5C::
    db $ea, "*: How dare you", $f1
    db "come without the", $fa, $f7
    db $ef, $ee, "treasures", $a4, " You", $ef, $ee, "have some nerve!", $fa, $f7
    db $ef, $ee, "You're not getting", $ef, $ee, "past me without", $fa, $f7
    db $ef, $ee, "showing me the", $ef, $ee, "treasures.", $f7
    db $f0

Message_05_5D::
    db $ea, "*: You didn't bring", $f1
    db "the treasures?", $fa, $f7
    db $ef, $ee, "Well, hurry up and", $ef, $ee, "bring them!", $fa, $f7
    db $ef, $ee, "You have only a", $ef, $ee, "little time left!", $f7
    db $f0

Message_05_5E::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Magic Keys", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "The last keys lead", $ef, $ee, "to worlds that are", $fa, $f7
    db $ef, $ee, "inhabited by rare", $ef, $ee, "monsters.", $95, $f7
    db $f0

Message_05_5F::
    db $f9, "0 checked the", $f1
    db "bookshelf.", $fa, $f7
    db $ef, $ee, "'Magic Keys", $a4, $ef, $ee, $fa, $f7
    db $ef, $ee, $f3, "Keys that feature", $ef, $ee, "a family name,", $fa, $f7
    db $ef, $ee, "like FirstSlime", $ef, $ee, "Key, go to a world", $fa, $f7
    db $ef, $ee, "that is inhabited", $ef, $ee, "by that family.", $95, $f7
    db $f0

Message_05_60::
    db $ea, "*: Awooh! I'm hot!", $f1
    db "Let's go already!", $f7
    db $f0

Message_05_95::
    db $ea, "*: I'm going to work", $f1
    db "hard and earn", $fa, $f7
    db $ef, $ee, "myself ", $f9, "0's", $ef, $ee, "praise.", $f7
    db $f0

Message_05_96::
    db $ea, "*: I'm plenty good", $f1
    db "enough by myself.", $fa, $f7
    db $ef, $ee, "There is no need", $ef, $ee, "for others.", $f7
    db $f0

Message_05_97::
    db $ea, "*: ", $f9, "0, I will", $f1
    db "fight with my life", $fa, $f7
    db $ef, $ee, "for your honor and", $ef, $ee, "glory.", $f7
    db $f0

Message_05_98::
    db $ea, "*: I'll take the", $f1
    db "point in battle!", $fa, $f7
    db $ef, $ee, "Let me take charge", $ef, $ee, "of the situation!", $f7
    db $f0

Message_05_99::
    db $ea, "*: I", $44, " like to see", $f1
    db "how well you can", $fa, $f7
    db $ef, $ee, "command us in", $ef, $ee, "battle.", $f7
    db $f0

Message_05_9A::
    db $ea, "*: ", $f9, "0, how about", $f1
    db "you battle next?", $f7
    db $f0

Message_05_9B::
    db $ea, "*: I don't need any", $f1
    db "backup.", $fa, $f7
    db $ef, $ee, "I'll just muscle", $ef, $ee, "through!", $f7
    db $f0

Message_05_9C::
    db $ea, "*: No need for", $f1
    db "defense!", $fa, $f7
    db $ef, $ee, "Offense is what's", $ef, $ee, "important.", $f7
    db $f0

Message_05_9D::
    db $ea, "*: Watch what your", $f1
    db "opponent has", $a4, $fa, $f7
    db $ef, $ee, "Running away is a", $ef, $ee, "viable option", $a4, $f7
    db $f0

Message_05_9E::
    db $ea, "*: If I don't get", $f1
    db "an order, I won't", $fa, $f7
    db $ef, $ee, "even bother to do", $ef, $ee, "any eating!", $f7
    db $f0

Message_05_9F::
    db $ea, "*: Make sure you", $f1
    db "heal me first if", $fa, $f7
    db $ef, $ee, "I'm hurt.", $ef, $ee, "Don't forget that!", $f7
    db $f0

Message_05_A0::
    db $ea, "*: I", $44, " rather be", $f1
    db "tending flowers", $fa, $f7
    db $ef, $ee, "than going out", $ef, $ee, "into battle", $a4, $f7
    db $f0

Message_05_A1::
    db $ea, "*: I'm going to get", $f1
    db "strong and impress", $fa, $f7
    db $ef, $ee, $f9, "0. Yes, I", $ef, $ee, "will!", $f7
    db $f0

Message_05_A2::
    db $ea, "*: It's OK", $a4, " I really", $f1
    db "didn't want any", $fa, $f7
    db $ef, $ee, "meat anyway,", $ef, $ee, "humph!", $f7
    db $f0

Message_05_A3::
    db $ea, "*: Do you have your", $f1
    db "hankie and tissue?", $fa, $f7
    db $ef, $ee, "Oh, your buttons", $ef, $ee, "are crooked.", $f7
    db $f0

Message_05_A4::
    db $ea, "*: I'll do as I see", $f1
    db "fit, thank you.", $fa, $f7
    db $ef, $ee, "I don't need you to", $ef, $ee, "order me around.", $f7
    db $f0

Message_05_A5::
    db $ea, "*: Give me meat!", $f1
    db "Or I won't obey!", $f7
    db $f0

Message_05_A6::
    db $ea, "*: In general, I am", $f1
    db "of the opinion", $fa, $f7
    db $ef, $ee, "that fighting is", $ef, $ee, "meaningless.", $f7
    db $f0

Message_05_A7::
    db $ea, "*: If worse comes", $f1
    db "to worst, I'll use", $fa, $f7
    db $ef, $ee, "a mate as a shield", $ef, $ee, "to survive.", $f7
    db $f0

Message_05_A8::
    db $ea, "*: There isn't any", $f1
    db "point begging for", $fa, $f7
    db $ef, $ee, "mercy. I have no", $ef, $ee, "pity for losers.", $f7
    db $f0

Message_05_A9::
    db $ea, "*: Um", $a4, " Uh", $a4, " Er", $a4, $f1
    db "It's nothing", $a4, $f7
    db $f0

Message_05_AA::
    db $ea, "*: Fighting isn't", $f1
    db "my idea of fun", $a4, $f7
    db $f0

Message_05_AB::
    db $ea, "*: Awah!", $f1
    db "You startled me!", $fa, $f7
    db $ef, $ee, "Please don't sneak", $ef, $ee, "up on me.", $f7
    db $f0

Message_05_AC::
    db $ea, "*: Please don't kill", $f1
    db "even enemies.", $f7
    db $f0

Message_05_AD::
    db $ea, "*: Yay! Woohoo!", $f1
    db "We're going out!", $f7
    db $f0

Message_05_AE::
    db $ea, "*: Aww", $a4, " Must we go?", $f1
    db "That's like work!", $f7
    db $f0

Message_05_AF::
    db $ea, "*: OK! Come on!", $f1
    db $f9, "0 too, hustle!", $f7
    db $f0

Message_05_B0::
    db $ea, "*: Every day, we", $f1
    db "must strive to", $fa, $f7
    db $ef, $ee, "better ourselves!", $ef, $ee, "It is relentless!", $f7
    db $f0

Message_05_B1::
    db $ea, "*: As long as I'm", $f1
    db "around, you'll have", $fa, $f7
    db $ef, $ee, "nothing to fear", $ef, $ee, "from any monster!", $f7
    db $f0

Message_05_B2::
    db $ea, "*: Together, we", $f1
    db "shall form the", $fa, $f7
    db $ef, $ee, "world's greatest", $ef, $ee, "team!", $f7
    db $f0

Message_05_B3::
    db $ea, "*: If you dawdle,", $f1
    db "I'm leaving you.", $f7
    db $f0

Message_05_B4::
    db $ea, "*: Normally, you", $f1
    db "don't deserve me.", $fa, $f7
    db $ef, $ee, "Don't you dare", $ef, $ee, "forget that.", $f7
    db $f0

Message_05_B5::
    db $ea, "*: If in the right", $f1
    db "mind for it, I can", $fa, $f7
    db $ef, $ee, "flip the world", $ef, $ee, "over on its axis!", $f7
    db $f0

Message_05_B6::
    db $ea, "*: I make my own", $f1
    db "roads!", $f7
    db $f0

Message_05_B7::
    db $ea, "*: Charge, charge,", $f1
    db "charge!", $fa, $f7
    db $ef, $ee, "There's no turning", $ef, $ee, "back, ever!", $f7
    db $f0

Message_05_B8::
    db $ea, "*: I'm looking", $f1
    db "forward to going", $fa, $f7
    db $ef, $ee, "on a journey with", $ef, $ee, "you.", $f7
    db $f0

Message_05_B9::
    db $ea, "*: We have to stick", $f1
    db "to a schedule!", $f7
    db $f0

Message_05_BA::
    db $ea, "*: I need to do", $f1
    db "things at my pace.", $fa, $f7
    db $ef, $ee, "My rhythm gets so", $ef, $ee, "thrown off", $a4, $f7
    db $f0

Message_05_BB::
    db $ea, "*: Three meals and", $f1
    db "adequate sleep.", $fa, $f7
    db $ef, $ee, "That's all I need", $ef, $ee, "to be satisfied.", $f7
    db $f0

Message_05_BC::
    db $ea, "*: This adventure", $f1
    db "is exciting!", $fa, $f7
    db $ef, $ee, "Because I get to", $ef, $ee, "go with ", $f9, "0!", $f7
    db $f0

Message_05_BD::
    db $ea, "*: Don't pay any", $f1
    db "heed to me.", $fa, $f7
    db $ef, $ee, "I'll do whatever I", $ef, $ee, "must for myself.", $f7
    db $f0

Message_05_BE::
    db $ea, "*: ", $f9, "0", $a4, " I must", $f1
    db "say this", $a4, $fa, $f7
    db $ef, $ee, "Your clothes are", $ef, $ee, "out of fashion.", $f7
    db $f0

Message_05_BF::
    db $ea, "*: I'm not good", $f1
    db "with combos", $a4, $f7
    db $f0

Message_05_C0::
    db $ea, "*: If I don't want", $f1
    db "to do something,", $fa, $f7
    db $ef, $ee, "you'll never get", $ef, $ee, "me to do it", $a4, $f7
    db $f0

Message_05_C1::
    db $ea, "*: I'll think up", $f1
    db "new plans!", $fa, $f7
    db $ef, $ee, "I'll teach them to", $ef, $ee, "you, ", $f9, "0!", $f7
    db $f0

Message_05_C2::
    db $ea, "*: 'Dirty' is just", $f1
    db "another way of", $fa, $f7
    db $ef, $ee, "saying 'shockingly", $ef, $ee, "effective,' pal.", $f7
    db $f0

Message_05_C3::
    db $ea, "*: If you pull your", $f1
    db "punches, you'll be", $fa, $f7
    db $ef, $ee, "sure to regret it", $ef, $ee, "later.", $f7
    db $f0

Message_05_C4::
    db $ea, "*: Don't talk to me", $a4, $f1
    db "I don't like it", $a4, $f7
    db $f0

Message_05_C5::
    db $ea, "*: ", $f9, "0, you sure", $f1
    db "work hard!", $fa, $f7
    db $ef, $ee, "You're just a", $ef, $ee, "little kid too!", $f7
    db $f0

Message_05_C6::
    db $ea, "*: Let's stay away", $f1
    db "from danger.", $f7
    db $f0

Message_05_C7::
    db $ea, "*: Wouldn't it be", $f1
    db "nice if everyone,", $fa, $f7
    db $ef, $ee, "even our enemies,", $ef, $ee, "could be friends?", $f7
    db $f0

Message_05_C8::
    db $ea, "*: Oh, the weather", $f1
    db "is so gorgeous!", $fa, $f7
    db $ef, $ee, "We should go for a", $ef, $ee, "picnic!", $f7
    db $f0

Message_05_C9::
    db $ea, "*: I don't want to", $f1
    db "chat. Leave me be.", $f7
    db $f0

Message_05_CA::
    db $ea, "*: ", $f9, "0! Let's get", $f1
    db "moving quick!", $fa, $f7
    db $ef, $ee, "I relish this", $ef, $ee, "challenge!", $f7
    db $f0

Message_05_CB::
    db $ea, "*: For tomorrow's", $f1
    db "victories,", $fa, $f7
    db $ef, $ee, "I'll spare no", $ef, $ee, "effort today!", $f7
    db $f0

Message_05_CC::
    db $ea, "*: Check out this", $f1
    db "physique!", $fa, $f7
    db $ef, $ee, "Now this is what", $ef, $ee, "you call refined!", $f7
    db $f0

Message_05_CD::
    db $ea, "*: In battle, every", $f1
    db "second is a drama!", $f7
    db $f0

Message_05_CE::
    db $ea, "*: Gahahahahahah!", $f1
    db "Chaaaaaaaaaarge!", $fa, $f7
    db $ef, $ee, "Just hammer'em,", $ef, $ee, "I say. Hammer!", $f7
    db $f0

Message_05_CF::
    db $ea, "*: Oh? This human", $f1
    db "presumes to order", $fa, $f7
    db $ef, $ee, "me around?", $ef, $ee, "How absurd.", $f7
    db $f0

Message_05_D0::
    db $ea, "*: No mercy needed", $f1
    db "for enemies!", $fa, $f7
    db $ef, $ee, "Smash'em all!", $ef, $ee, $f7
    db $f0

Message_05_D1::
    db $ea, "*: No guts,", $f1
    db "no glory!", $f7
    db $f0

Message_05_D2::
    db $ea, "*: Even if there", $f1
    db "were a hundred", $fa, $f7
    db $ef, $ee, "enemies, I will", $ef, $ee, "keep marching on!", $f7
    db $f0

Message_05_D3::
    db $ea, "*: If I can get", $f1
    db "luck on my side,", $fa, $f7
    db $ef, $ee, "I can win them", $ef, $ee, "all.", $f7
    db $f0

Message_05_D4::
    db $ea, "*: Master, there", $f1
    db "should be rules", $fa, $f7
    db $ef, $ee, "within our party", $ef, $ee, "to keep order!", $f7
    db $f0
    ds $8e, $00
