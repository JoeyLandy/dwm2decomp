SECTION "Bank 8A", ROMX[$4000], BANK[$8A]
    db $8a

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank8A::
    ld de, StringCategories_8A_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9, $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_8A_4016::
    dw StringList_8A_4018 ; id 0

; category list of StringCategories_8A_4016; one pointer per wStringIndex (E-0217)
; record: string
StringList_8A_4018::
    dw String_8A_00_00 ; id 0
    dw String_8A_00_01 ; id 1
    dw String_8A_00_02 ; id 2
    dw String_8A_00_03 ; id 3
    dw String_8A_00_04 ; id 4
    dw String_8A_00_05 ; id 5
    dw String_8A_00_05 ; id 6
    dw String_8A_00_05 ; id 7
    dw String_8A_00_05 ; id 8
    dw String_8A_00_09 ; id 9
    dw String_8A_00_0A ; id 10
    dw String_8A_00_0B ; id 11
    dw String_8A_00_0B ; id 12
    dw String_8A_00_0B ; id 13
    dw String_8A_00_0B ; id 14
    dw String_8A_00_0B ; id 15
    dw String_8A_00_0B ; id 16
    dw String_8A_00_11 ; id 17
    dw String_8A_00_11 ; id 18
    dw String_8A_00_11 ; id 19
    dw String_8A_00_14 ; id 20
    dw String_8A_00_15 ; id 21
    dw String_8A_00_16 ; id 22
    dw String_8A_00_17 ; id 23
    dw String_8A_00_18 ; id 24
    dw String_8A_00_19 ; id 25
    dw String_8A_00_1A ; id 26
    dw String_8A_00_1B ; id 27
    dw String_8A_00_1C ; id 28
    dw String_8A_00_1D ; id 29
    dw String_8A_00_1E ; id 30
    dw String_8A_00_1F ; id 31
    dw String_8A_00_20 ; id 32
    dw String_8A_00_21 ; id 33
    dw String_8A_00_22 ; id 34
    dw String_8A_00_23 ; id 35
    dw String_8A_00_24 ; id 36
    dw String_8A_00_25 ; id 37
    dw String_8A_00_26 ; id 38
    dw String_8A_00_27 ; id 39
    dw String_8A_00_28 ; id 40
    dw String_8A_00_29 ; id 41
    dw String_8A_00_2A ; id 42
    dw String_8A_00_2B ; id 43
    dw String_8A_00_2B ; id 44
    dw String_8A_00_2B ; id 45
    dw String_8A_00_2B ; id 46
    dw String_8A_00_2B ; id 47
    dw String_8A_00_2B ; id 48
    dw String_8A_00_2B ; id 49
    dw String_8A_00_2B ; id 50
    dw String_8A_00_2B ; id 51
    dw String_8A_00_2B ; id 52
    dw String_8A_00_2B ; id 53
    dw String_8A_00_2B ; id 54
    dw String_8A_00_2B ; id 55
    dw String_8A_00_2B ; id 56
    dw String_8A_00_2B ; id 57
    dw String_8A_00_2B ; id 58
    dw String_8A_00_2B ; id 59
    dw String_8A_00_2B ; id 60
    dw String_8A_00_2B ; id 61
    dw String_8A_00_2B ; id 62
    dw String_8A_00_2B ; id 63
    dw String_8A_00_2B ; id 64
    dw String_8A_00_2B ; id 65
    dw String_8A_00_2B ; id 66
    dw String_8A_00_2B ; id 67
    dw String_8A_00_2B ; id 68
    dw String_8A_00_2B ; id 69
    dw String_8A_00_2B ; id 70
    dw String_8A_00_2B ; id 71
    dw String_8A_00_2B ; id 72
    dw String_8A_00_2B ; id 73
    dw String_8A_00_2B ; id 74
    dw String_8A_00_2B ; id 75
    dw String_8A_00_2B ; id 76
    dw String_8A_00_2B ; id 77
    dw String_8A_00_2B ; id 78
    dw String_8A_00_2B ; id 79
    dw String_8A_00_2B ; id 80
    dw String_8A_00_2B ; id 81
    dw String_8A_00_2B ; id 82
    dw String_8A_00_2B ; id 83
    dw String_8A_00_2B ; id 84
    dw String_8A_00_2B ; id 85
    dw String_8A_00_2B ; id 86
    dw String_8A_00_2B ; id 87
    dw String_8A_00_2B ; id 88
    dw String_8A_00_2B ; id 89
    dw String_8A_00_2B ; id 90
    dw String_8A_00_2B ; id 91
    dw String_8A_00_2B ; id 92
    dw String_8A_00_2B ; id 93
    dw String_8A_00_2B ; id 94
    dw String_8A_00_2B ; id 95
    dw String_8A_00_2B ; id 96
    dw String_8A_00_2B ; id 97
    dw String_8A_00_2B ; id 98
    dw String_8A_00_2B ; id 99
    dw String_8A_00_2B ; id 100
    dw String_8A_00_2B ; id 101
    dw String_8A_00_2B ; id 102
    dw String_8A_00_2B ; id 103
    dw String_8A_00_2B ; id 104
    dw String_8A_00_2B ; id 105
    dw String_8A_00_2B ; id 106
    dw String_8A_00_2B ; id 107
    dw String_8A_00_2B ; id 108
    dw String_8A_00_2B ; id 109
    dw String_8A_00_2B ; id 110
    dw String_8A_00_2B ; id 111
    dw String_8A_00_2B ; id 112
    dw String_8A_00_2B ; id 113
    dw String_8A_00_2B ; id 114
    dw String_8A_00_2B ; id 115
    dw String_8A_00_2B ; id 116
    dw String_8A_00_2B ; id 117
    dw String_8A_00_2B ; id 118
    dw String_8A_00_2B ; id 119
    dw String_8A_00_2B ; id 120
    dw String_8A_00_2B ; id 121
    dw String_8A_00_2B ; id 122
    dw String_8A_00_2B ; id 123
    dw String_8A_00_2B ; id 124
    dw String_8A_00_2B ; id 125
    dw String_8A_00_2B ; id 126
    dw String_8A_00_2B ; id 127
    dw String_8A_00_2B ; id 128
    dw String_8A_00_2B ; id 129
    dw String_8A_00_2B ; id 130
    dw String_8A_00_2B ; id 131
    dw String_8A_00_2B ; id 132
    dw String_8A_00_2B ; id 133
    dw String_8A_00_2B ; id 134
    dw String_8A_00_2B ; id 135
    dw String_8A_00_2B ; id 136
    dw String_8A_00_2B ; id 137
    dw String_8A_00_2B ; id 138
    dw String_8A_00_2B ; id 139
    dw String_8A_00_2B ; id 140
    dw String_8A_00_2B ; id 141
    dw String_8A_00_2B ; id 142
    dw String_8A_00_2B ; id 143
    dw String_8A_00_2B ; id 144
    dw String_8A_00_2B ; id 145
    dw String_8A_00_2B ; id 146
    dw String_8A_00_2B ; id 147
    dw String_8A_00_2B ; id 148
    dw String_8A_00_2B ; id 149
    dw String_8A_00_2B ; id 150
    dw String_8A_00_2B ; id 151
    dw String_8A_00_2B ; id 152
    dw String_8A_00_2B ; id 153
    dw String_8A_00_2B ; id 154
    dw String_8A_00_2B ; id 155
    dw String_8A_00_2B ; id 156
    dw String_8A_00_2B ; id 157
    dw String_8A_00_2B ; id 158
    dw String_8A_00_2B ; id 159
    dw String_8A_00_2B ; id 160
    dw String_8A_00_2B ; id 161
    dw String_8A_00_2B ; id 162
    dw String_8A_00_2B ; id 163
    dw String_8A_00_2B ; id 164
    dw String_8A_00_2B ; id 165
    dw String_8A_00_2B ; id 166
    dw String_8A_00_2B ; id 167
    dw String_8A_00_2B ; id 168
    dw String_8A_00_2B ; id 169
    dw String_8A_00_2B ; id 170
    dw String_8A_00_2B ; id 171
    dw String_8A_00_2B ; id 172
    dw String_8A_00_2B ; id 173
    dw String_8A_00_2B ; id 174
    dw String_8A_00_2B ; id 175
    dw String_8A_00_2B ; id 176
    dw String_8A_00_2B ; id 177
    dw String_8A_00_2B ; id 178
    dw String_8A_00_2B ; id 179
    dw String_8A_00_2B ; id 180
    dw String_8A_00_2B ; id 181
    dw String_8A_00_2B ; id 182
    dw String_8A_00_2B ; id 183
    dw String_8A_00_2B ; id 184
    dw String_8A_00_2B ; id 185
    dw String_8A_00_2B ; id 186
    dw String_8A_00_2B ; id 187
    dw String_8A_00_2B ; id 188
    dw String_8A_00_2B ; id 189
    dw String_8A_00_2B ; id 190
    dw String_8A_00_2B ; id 191
    dw String_8A_00_2B ; id 192
    dw String_8A_00_2B ; id 193
    dw String_8A_00_2B ; id 194
    dw String_8A_00_2B ; id 195
    dw String_8A_00_2B ; id 196
    dw String_8A_00_2B ; id 197
    dw String_8A_00_2B ; id 198
    dw String_8A_00_2B ; id 199
    dw String_8A_00_2B ; id 200
    dw String_8A_00_2B ; id 201
    dw String_8A_00_2B ; id 202
    dw String_8A_00_2B ; id 203
    dw String_8A_00_2B ; id 204
    dw String_8A_00_2B ; id 205
    dw String_8A_00_2B ; id 206
    dw String_8A_00_2B ; id 207
    dw String_8A_00_2B ; id 208
    dw String_8A_00_2B ; id 209
    dw String_8A_00_2B ; id 210
    dw String_8A_00_2B ; id 211
    dw String_8A_00_2B ; id 212
    dw String_8A_00_2B ; id 213
    dw String_8A_00_2B ; id 214
    dw String_8A_00_2B ; id 215
    dw String_8A_00_2B ; id 216
    dw String_8A_00_2B ; id 217
    dw String_8A_00_2B ; id 218
    dw String_8A_00_2B ; id 219
    dw String_8A_00_2B ; id 220
    dw String_8A_00_2B ; id 221
    dw String_8A_00_2B ; id 222
    dw String_8A_00_2B ; id 223
    dw String_8A_00_2B ; id 224
    dw String_8A_00_2B ; id 225
    dw String_8A_00_2B ; id 226
    dw String_8A_00_2B ; id 227
    dw String_8A_00_2B ; id 228
    dw String_8A_00_2B ; id 229
    dw String_8A_00_2B ; id 230
    dw String_8A_00_2B ; id 231
    dw String_8A_00_2B ; id 232
    dw String_8A_00_2B ; id 233
    dw String_8A_00_2B ; id 234
    dw String_8A_00_2B ; id 235
    dw String_8A_00_2B ; id 236
    dw String_8A_00_2B ; id 237
    dw String_8A_00_2B ; id 238
    dw String_8A_00_2B ; id 239
    dw String_8A_00_2B ; id 240
    dw String_8A_00_2B ; id 241
    dw String_8A_00_2B ; id 242
    dw String_8A_00_2B ; id 243
    dw String_8A_00_2B ; id 244
    dw String_8A_00_2B ; id 245
    dw String_8A_00_2B ; id 246
    dw String_8A_00_2B ; id 247
    dw String_8A_00_2B ; id 248
    dw String_8A_00_2B ; id 249
    dw String_8A_00_2B ; id 250
    dw String_8A_00_2B ; id 251
    dw String_8A_00_2B ; id 252
    dw String_8A_00_2B ; id 253
    dw String_8A_00_2B ; id 254

String_8A_00_00::
    db $ea, "*: I'll tell you", $f1
    db "about this great", $fa, $f7
    db $ef, $ee, "adventure story I", $ef, $ee, "read long ago.", $fa, $f7
    db $ef, $ee, "Master Hasta's", $ef, $ee, "Adventure", $a4, $fa, $f7
    db $ef, $ee, "Book 1,", $ef, $ee, "The Name is Hasta", $a4, $fa, $f7
    db $ef, $ee, "There once was a", $ef, $ee, "boy named Hasta.", $fa, $f7
    db $ef, $ee, "Who dreamed of", $ef, $ee, "becoming a master.", $fa, $f7
    db $ef, $ee, "One day he awoke,", $ef, $ee, "and had a nice", $a4, $fa, $f7
    db $ef, $ee, $a4, "Wait, how", $44, " the", $ef, $ee, "rest of it go?", $f7
    db $f0

String_8A_00_01::
    db $ea, "*: Hey, do you know", $f1
    db "this tale? Listen!", $fa, $f7
    db $ef, $ee, "Master Hasta's", $ef, $ee, "Adventure", $a4, $fa, $f7
    db $ef, $ee, "Book 2,", $ef, $ee, "What Lies Beside", $a4, $fa, $f7
    db $ef, $ee, "When Hasta awoke,", $ef, $ee, "he realized that", $fa, $f7
    db $ef, $ee, "he wasn't alone in", $ef, $ee, "his bed.", $fa, $f7
    db $ef, $ee, "Lying beside him", $ef, $ee, "was a rotted body!", $fa, $f7
    db $ef, $ee, "What do you think?", $ef, $ee, "Pretty scary, eh?", $f7
    db $f0

String_8A_00_02::
    db $eb, "*: Want to hear", $f1
    db "about a story I", $fa, $f7
    db $ef, $ee, "read when I was", $ef, $ee, "little?", $fa, $f7
    db $ef, $ee, "Master Hasta's", $ef, $ee, "Adventure", $a4, $fa, $f7
    db $ef, $ee, "Book 3,", $ef, $ee, "Dead Man Waking", $a4, $fa, $f7
    db $ef, $ee, "Hasta found", $ef, $ee, "his courage and", $fa, $f7
    db $ef, $ee, "prodded the fetid", $ef, $ee, "corpse", $a4, $fa, $f7
    db $ef, $ee, "The putrid horror", $ef, $ee, "suddenly sat up!", $fa, $f7
    db $ef, $ee, "It was actually a", $ef, $ee, "Hork!", $fa, $f7
    db $ef, $ee, "Oooh, I thought it", $ef, $ee, "was so scary!", $f7
    db $f0

String_8A_00_03::
    db $ea, "*: Let me recount", $f1
    db "this ancient lore", $a4, $fa, $f7
    db $ef, $ee, "Master Hasta's", $ef, $ee, "Adventure", $a4, $fa, $f7
    db $ef, $ee, "Book 4,", $ef, $ee, "Undead Calm", $a4, $fa, $f7
    db $ef, $ee, "Hork stretched and", $ef, $ee, "yawned out loud,", $fa, $f7
    db $ef, $ee, "'Fwaaah", $a4, " I need my", $ef, $ee, "beauty sleep.", $95, $fa, $f7
    db $ef, $ee, "And Hork went back", $ef, $ee, "to sleep.", $fa, $f7
    db $ef, $ee, "I guess that must", $ef, $ee, "be what sleeping", $fa, $f7
    db $ef, $ee, "like the dead is", $ef, $ee, "all about.", $f7
    db $f0

String_8A_00_04::
    db $ea, "*: Long ago, there", $f1
    db "were books titled", $fa, $f7
    db $ef, $ee, "Master Hasta's", $ef, $ee, "Adventure.", $fa, $f7
    db $ef, $ee, "But the author", $ef, $ee, "gave up after just", $fa, $f7
    db $ef, $ee, "four slim books, I", $ef, $ee, "hear.", $fa, $f7
    db $ef, $ee, "I wonder if anyone", $ef, $ee, "remembers them?", $f7
    db $f0

String_8A_00_05::
    db $ea, "*: Hey, did you", $f1
    db "know?", $fa, $f7
    db $ef, $ee, "In any world that", $ef, $ee, "you visit using an", $fa, $f7
    db $ef, $ee, "appraised Magic", $ef, $ee, "Key, you'll come", $fa, $f7
    db $ef, $ee, "across bosses of", $ef, $ee, "certain areas.", $fa, $f7
    db $ef, $ee, "Until those bosses", $ef, $ee, "are defeated, no", $fa, $f7
    db $ef, $ee, "monster will join", $ef, $ee, "your party.", $fa, $f7
    db $ef, $ee, "They may want to,", $ef, $ee, "but they can't", $fa, $f7
    db $ef, $ee, "with the bosses", $ef, $ee, "watching them.", $fa, $f7
    db $ef, $ee, "So, if you want to", $ef, $ee, "befriend monsters,", $fa, $f7
    db $ef, $ee, "you need to defeat", $ef, $ee, "the area bosses.", $f7
    db $f0

String_8A_00_09::
    db $eb, "*: If you visit any", $f1
    db "world using an", $fa, $f7
    db $ef, $ee, "appraised Magic", $ef, $ee, "Key, there will", $fa, $f7
    db $ef, $ee, "always be bosses", $ef, $ee, "of certain areas.", $fa, $f7
    db $ef, $ee, "If you don't beat", $ef, $ee, "those bosses, no", $fa, $f7
    db $ef, $ee, "monster will join", $ef, $ee, "your party.", $fa, $f7
    db $ef, $ee, "They're too scared", $ef, $ee, "of their bosses to", $fa, $f7
    db $ef, $ee, "even consider", $ef, $ee, "rebelling.", $fa, $f7
    db $ef, $ee, "So, if you want", $ef, $ee, "monsters to join", $fa, $f7
    db $ef, $ee, "you, defeat the", $ef, $ee, "area bosses.", $f7
    db $f0

String_8A_00_0A::
    db $ea, "*: In every world", $f1
    db "visited using an", $fa, $f7
    db $ef, $ee, "appraised Magic", $ef, $ee, "Key, you will see", $fa, $f7
    db $ef, $ee, "monster bosses", $ef, $ee, "exerting rule.", $fa, $f7
    db $ef, $ee, "Unless they are", $ef, $ee, "defeated, no", $fa, $f7
    db $ef, $ee, "monster will dare", $ef, $ee, "to join you.", $fa, $f7
    db $ef, $ee, "Fear of their", $ef, $ee, "bosses keeps them", $fa, $f7
    db $ef, $ee, "from acting on", $ef, $ee, "their own.", $fa, $f7
    db $ef, $ee, "That's why you", $ef, $ee, "must defeat bosses", $fa, $f7
    db $ef, $ee, "first to befriend", $ef, $ee, "wild monsters.", $f7
    db $f0

String_8A_00_0B::
    db $ea, "*: There should be", $f1
    db "a castle in which", $fa, $f7
    db $ef, $ee, "the monster boss", $ef, $ee, "resides.", $fa, $f7
    db $ef, $ee, "Wild monsters are", $ef, $ee, "dominated by the", $fa, $f7
    db $ef, $ee, "boss, and won't", $ef, $ee, "become tame", $a4, $f7
    db $f0

String_8A_00_11::
    db $ea, "*: Monsters you", $f1
    db "beat in battle", $fa, $f7
    db $ef, $ee, "could join your", $ef, $ee, "party.", $fa, $f7
    db $ef, $ee, "A strong monster", $ef, $ee, "makes a powerful", $fa, $f7
    db $ef, $ee, "companion-if you", $ef, $ee, "can get one.", $f7
    db $f0

String_8A_00_14::
    db $ea, "*: Monsters you", $f1
    db "beat in battle", $fa, $f7
    db $ef, $ee, "could join your", $ef, $ee, "party.", $fa, $f7
    db $ef, $ee, "But their boss", $ef, $ee, "must be beaten", $fa, $f7
    db $ef, $ee, "before that can", $ef, $ee, "happen.", $f7
    db $f0

String_8A_00_15::
    db $ea, "*: Traveling with", $f1
    db "monsters?", $fa, $f7
    db $ef, $ee, "That takes a good", $ef, $ee, "deal of courage.", $f7
    db $f0

String_8A_00_16::
    db $ea, "*: You're so young", $f1
    db "and small, but", $fa, $f7
    db $ef, $ee, "here you are, on a", $ef, $ee, "perilous journey", $a4, $fa, $f7
    db $ef, $ee, "Our soldiers can", $ef, $ee, "stand to learn a", $fa, $f7
    db $ef, $ee, "thing or two from", $ef, $ee, "you!", $f7
    db $f0

String_8A_00_17::
    db $ea, "*: The Castle is", $f1
    db "safe.", $fa, $f7
    db $ef, $ee, "Relax, and enjoy", $ef, $ee, "your stay.", $f7
    db $f0

String_8A_00_18::
    db $ea, "*: Do you know of", $f1
    db "the MeteOrb?", $fa, $f7
    db $ef, $ee, "It's a rare item", $ef, $ee, "that does away", $fa, $f7
    db $ef, $ee, "with a monster's", $ef, $ee, "mistrust.", $f7
    db $f0

String_8A_00_19::
    db $ea, "*: The last monster", $f1
    db "you beat in battle", $fa, $f7
    db $ef, $ee, "has a chance of", $ef, $ee, "joining you.", $fa, $f7
    db $ef, $ee, "If you're after a", $ef, $ee, "specific species,", $fa, $f7
    db $ef, $ee, "you might consider", $ef, $ee, "healing it.", $f7
    db $f0

String_8A_00_1A::
    db $ea, "*: There's a monster", $f1
    db "that's skilled at", $fa, $f7
    db $ef, $ee, "attracting the", $ef, $ee, "opposite sex.", $f7
    db $f0

String_8A_00_1B::
    db $ea, "*: If you want to", $f1
    db "befriend monsters,", $fa, $f7
    db $ef, $ee, "give them meat,", $ef, $ee, "and don't be cheap.", $fa, $f7
    db $ef, $ee, "The more expensive", $ef, $ee, "it is, the better", $fa, $f7
    db $ef, $ee, "the quality of the", $ef, $ee, "meat, you see.", $f7
    db $f0

String_8A_00_1C::
    db $ea, "*: I met a traveler", $f1
    db "who had monsters", $fa, $f7
    db $ef, $ee, "with him, just", $ef, $ee, "like you.", $fa, $f7
    db $ef, $ee, "Those monsters", $ef, $ee, "looked fearsome!", $f7
    db $f0

String_8A_00_1D::
    db $ea, "*: I met a traveler", $f1
    db "who had monsters", $fa, $f7
    db $ef, $ee, "with him, just", $ef, $ee, "like you.", $fa, $f7
    db $ef, $ee, "They used skills", $ef, $ee, "I", $44, " never seen.", $f7
    db $f0

String_8A_00_1E::
    db $ea, "*: If you ignore", $f1
    db "them, monsters", $fa, $f7
    db $ef, $ee, "will ignore you", $ef, $ee, "too.", $f7
    db $f0

String_8A_00_1F::
    db $ea, "*: While we do get", $f1
    db "travelers here,", $fa, $f7
    db $ef, $ee, "I've only seen one", $ef, $ee, "other kid.", $fa, $f7
    db $ef, $ee, "It was a boy", $a4, $ef, $ee, "Terry, I think.", $f7
    db $f0

String_8A_00_20::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "But it was empty.", $ef, $ee, $f7
    db $f0

String_8A_00_21::
    db $f9, "0 peered into", $f1
    db "the oven.", $fa, $f7
    db $ef, $ee, "But it was empty.", $ef, $ee, $f7
    db $f0

String_8A_00_22::
    db $f9, "0 tried to", $f1
    db "open the chest.", $fa, $f7
    db $ef, $ee, "But it was locked.", $ef, $ee, $f7
    db $f0

String_8A_00_23::
    db $ea, "*: Hello! How may I", $f1
    db "help you today?", $f7
    db $f0

String_8A_00_24::
    db $ea, "*: Welcome to the", $f1
    db "traveler's inn!", $f7
    db $f0

String_8A_00_25::
    db $ea, "*: Let me see what", $f1
    db "you are made of!", $f7
    db $f0

String_8A_00_26::
    db $ea, "*: You'll have to", $f1
    db "beat me to pass!", $f7
    db $f0

String_8A_00_27::
    db $ea, "*: I am a servant", $f1
    db "of the Gods.", $fa, $f7
    db $ef, $ee, "How may I serve", $ef, $ee, "you today?", $f7
    db $f0

String_8A_00_28::
    db $ea, "*: Welcome to the", $f1
    db "traveler's inn!", $fa, $f7
    db $ef, $ee, "The view here is", $ef, $ee, "magnificent!", $f7
    db $f0

String_8A_00_29::
    db "The evil force", $f1
    db "enshrouding the", $fa, $f7
    db $ef, $ee, "entire world faded", $ef, $ee, "away!", $f7
    db $f0

String_8A_00_2A::
    db "The evil force", $f1
    db "covering the", $fa, $f7
    db $ef, $ee, "continent faded", $ef, $ee, "away!", $f7
    db $f0

String_8A_00_2B::
    db $f0
    ds $2d1f, $00
