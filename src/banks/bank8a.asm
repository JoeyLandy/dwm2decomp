SECTION "Bank 8A", ROMX[$4000], BANK[$8A]
    db $8A

; ld de, this bank's string table / BeginStringDisplay
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank8A, ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank89, KeyWorldBossBattle_Case05_Sub01_Sub01_BeginStringDisplay_Bank8A)
BeginStringDisplay_Bank8A::
Func_08A_4001:: ; address name
    ld de, StringCategories_8A_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_8A_4016::
Data_08A_4016:: ; address name
    dw StringList_8A_4018 ; id 0

; E-0217 (derived: category list of StringCategories_8A_4016; one pointer per wStringIndex)
; record: string
StringList_8A_4018::
Data_08A_4018:: ; address name
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

String_8A_00_00:: ; heuristic: string; C0
Data_08A_4216:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I'll tell you", $F1
    db "about this great", $FA, $F7
    db $EF, $EE, "adventure story I", $EF, $EE, "read long ago.", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 1,", $EF, $EE, "The Name is Hasta", $A4, $FA, $F7
    db $EF, $EE, "There once was a", $EF, $EE, "boy named Hasta.", $FA, $F7
    db $EF, $EE, "Who dreamed of", $EF, $EE, "becoming a master.", $FA, $F7
    db $EF, $EE, "One day he awoke,", $EF, $EE, "and had a nice", $A4, $FA, $F7
    db $EF, $EE, $A4, "Wait, how", $44, " the", $EF, $EE, "rest of it go?", $F7
    db $F0

String_8A_00_01:: ; heuristic: string; C0
Data_08A_432E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Hey, do you know", $F1
    db "this tale? Listen!", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 2,", $EF, $EE, "What Lies Beside", $A4, $FA, $F7
    db $EF, $EE, "When Hasta awoke,", $EF, $EE, "he realized that", $FA, $F7
    db $EF, $EE, "he wasn't alone in", $EF, $EE, "his bed.", $FA, $F7
    db $EF, $EE, "Lying beside him", $EF, $EE, "was a rotted body!", $FA, $F7
    db $EF, $EE, "What do you think?", $EF, $EE, "Pretty scary, eh?", $F7
    db $F0

String_8A_00_02:: ; heuristic: string; C0
Data_08A_4428:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Want to hear", $F1
    db "about a story I", $FA, $F7
    db $EF, $EE, "read when I was", $EF, $EE, "little?", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 3,", $EF, $EE, "Dead Man Waking", $A4, $FA, $F7
    db $EF, $EE, "Hasta found", $EF, $EE, "his courage and", $FA, $F7
    db $EF, $EE, "prodded the fetid", $EF, $EE, "corpse", $A4, $FA, $F7
    db $EF, $EE, "The putrid horror", $EF, $EE, "suddenly sat up!", $FA, $F7
    db $EF, $EE, "It was actually a", $EF, $EE, "Hork!", $FA, $F7
    db $EF, $EE, "Oooh, I thought it", $EF, $EE, "was so scary!", $F7
    db $F0

String_8A_00_03:: ; heuristic: string; C0
Data_08A_4545:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Let me recount", $F1
    db "this ancient lore", $A4, $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 4,", $EF, $EE, "Undead Calm", $A4, $FA, $F7
    db $EF, $EE, "Hork stretched and", $EF, $EE, "yawned out loud,", $FA, $F7
    db $EF, $EE, "'Fwaaah", $A4, " I need my", $EF, $EE, "beauty sleep.", $95, $FA, $F7
    db $EF, $EE, "And Hork went back", $EF, $EE, "to sleep.", $FA, $F7
    db $EF, $EE, "I guess that must", $EF, $EE, "be what sleeping", $FA, $F7
    db $EF, $EE, "like the dead is", $EF, $EE, "all about.", $F7
    db $F0

String_8A_00_04:: ; heuristic: string; C0
Data_08A_4657:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Long ago, there", $F1
    db "were books titled", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure.", $FA, $F7
    db $EF, $EE, "But the author", $EF, $EE, "gave up after just", $FA, $F7
    db $EF, $EE, "four slim books, I", $EF, $EE, "hear.", $FA, $F7
    db $EF, $EE, "I wonder if anyone", $EF, $EE, "remembers them?", $F7
    db $F0

String_8A_00_05:: ; heuristic: string; C0
Data_08A_4704:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Hey, did you", $F1
    db "know?", $FA, $F7
    db $EF, $EE, "In any world that", $EF, $EE, "you visit using an", $FA, $F7
    db $EF, $EE, "appraised Magic", $EF, $EE, "Key, you'll come", $FA, $F7
    db $EF, $EE, "across bosses of", $EF, $EE, "certain areas.", $FA, $F7
    db $EF, $EE, "Until those bosses", $EF, $EE, "are defeated, no", $FA, $F7
    db $EF, $EE, "monster will join", $EF, $EE, "your party.", $FA, $F7
    db $EF, $EE, "They may want to,", $EF, $EE, "but they can't", $FA, $F7
    db $EF, $EE, "with the bosses", $EF, $EE, "watching them.", $FA, $F7
    db $EF, $EE, "So, if you want to", $EF, $EE, "befriend monsters,", $FA, $F7
    db $EF, $EE, "you need to defeat", $EF, $EE, "the area bosses.", $F7
    db $F0

String_8A_00_09:: ; heuristic: string; C0
Data_08A_486F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: If you visit any", $F1
    db "world using an", $FA, $F7
    db $EF, $EE, "appraised Magic", $EF, $EE, "Key, there will", $FA, $F7
    db $EF, $EE, "always be bosses", $EF, $EE, "of certain areas.", $FA, $F7
    db $EF, $EE, "If you don't beat", $EF, $EE, "those bosses, no", $FA, $F7
    db $EF, $EE, "monster will join", $EF, $EE, "your party.", $FA, $F7
    db $EF, $EE, "They're too scared", $EF, $EE, "of their bosses to", $FA, $F7
    db $EF, $EE, "even consider", $EF, $EE, "rebelling.", $FA, $F7
    db $EF, $EE, "So, if you want", $EF, $EE, "monsters to join", $FA, $F7
    db $EF, $EE, "you, defeat the", $EF, $EE, "area bosses.", $F7
    db $F0

String_8A_00_0A:: ; heuristic: string; C0
Data_08A_49B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: In every world", $F1
    db "visited using an", $FA, $F7
    db $EF, $EE, "appraised Magic", $EF, $EE, "Key, you will see", $FA, $F7
    db $EF, $EE, "monster bosses", $EF, $EE, "exerting rule.", $FA, $F7
    db $EF, $EE, "Unless they are", $EF, $EE, "defeated, no", $FA, $F7
    db $EF, $EE, "monster will dare", $EF, $EE, "to join you.", $FA, $F7
    db $EF, $EE, "Fear of their", $EF, $EE, "bosses keeps them", $FA, $F7
    db $EF, $EE, "from acting on", $EF, $EE, "their own.", $FA, $F7
    db $EF, $EE, "That's why you", $EF, $EE, "must defeat bosses", $FA, $F7
    db $EF, $EE, "first to befriend", $EF, $EE, "wild monsters.", $F7
    db $F0

String_8A_00_0B:: ; heuristic: string; C0
Data_08A_4AEE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: There should be", $F1
    db "a castle in which", $FA, $F7
    db $EF, $EE, "the monster boss", $EF, $EE, "resides.", $FA, $F7
    db $EF, $EE, "Wild monsters are", $EF, $EE, "dominated by the", $FA, $F7
    db $EF, $EE, "boss, and won't", $EF, $EE, "become tame", $A4, $F7
    db $F0

String_8A_00_11:: ; heuristic: string; C0
Data_08A_4B79:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Monsters you", $F1
    db "beat in battle", $FA, $F7
    db $EF, $EE, "could join your", $EF, $EE, "party.", $FA, $F7
    db $EF, $EE, "A strong monster", $EF, $EE, "makes a powerful", $FA, $F7
    db $EF, $EE, "companion-if you", $EF, $EE, "can get one.", $F7
    db $F0

String_8A_00_14:: ; heuristic: string; C0
Data_08A_4BFC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Monsters you", $F1
    db "beat in battle", $FA, $F7
    db $EF, $EE, "could join your", $EF, $EE, "party.", $FA, $F7
    db $EF, $EE, "But their boss", $EF, $EE, "must be beaten", $FA, $F7
    db $EF, $EE, "before that can", $EF, $EE, "happen.", $F7
    db $F0

String_8A_00_15:: ; heuristic: string; C0
Data_08A_4C75:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Traveling with", $F1
    db "monsters?", $FA, $F7
    db $EF, $EE, "That takes a good", $EF, $EE, "deal of courage.", $F7
    db $F0

String_8A_00_16:: ; heuristic: string; C0
Data_08A_4CB9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You're so young", $F1
    db "and small, but", $FA, $F7
    db $EF, $EE, "here you are, on a", $EF, $EE, "perilous journey", $A4, $FA, $F7
    db $EF, $EE, "Our soldiers can", $EF, $EE, "stand to learn a", $FA, $F7
    db $EF, $EE, "thing or two from", $EF, $EE, "you!", $F7
    db $F0

String_8A_00_17:: ; heuristic: string; C0
Data_08A_4D45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The Castle is", $F1
    db "safe.", $FA, $F7
    db $EF, $EE, "Relax, and enjoy", $EF, $EE, "your stay.", $F7
    db $F0

String_8A_00_18:: ; heuristic: string; C0
Data_08A_4D7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Do you know of", $F1
    db "the MeteOrb?", $FA, $F7
    db $EF, $EE, "It's a rare item", $EF, $EE, "that does away", $FA, $F7
    db $EF, $EE, "with a monster's", $EF, $EE, "mistrust.", $F7
    db $F0

String_8A_00_19:: ; heuristic: string; C0
Data_08A_4DDE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: The last monster", $F1
    db "you beat in battle", $FA, $F7
    db $EF, $EE, "has a chance of", $EF, $EE, "joining you.", $FA, $F7
    db $EF, $EE, "If you're after a", $EF, $EE, "specific species,", $FA, $F7
    db $EF, $EE, "you might consider", $EF, $EE, "healing it.", $F7
    db $F0

String_8A_00_1A:: ; heuristic: string; C0
Data_08A_4E71:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: There's a monster", $F1
    db "that's skilled at", $FA, $F7
    db $EF, $EE, "attracting the", $EF, $EE, "opposite sex.", $F7
    db $F0

String_8A_00_1B:: ; heuristic: string; C0
Data_08A_4EB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: If you want to", $F1
    db "befriend monsters,", $FA, $F7
    db $EF, $EE, "give them meat,", $EF, $EE, "and don't be cheap.", $FA, $F7
    db $EF, $EE, "The more expensive", $EF, $EE, "it is, the better", $FA, $F7
    db $EF, $EE, "the quality of the", $EF, $EE, "meat, you see.", $F7
    db $F0

String_8A_00_1C:: ; heuristic: string; C0
Data_08A_4F54:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I met a traveler", $F1
    db "who had monsters", $FA, $F7
    db $EF, $EE, "with him, just", $EF, $EE, "like you.", $FA, $F7
    db $EF, $EE, "Those monsters", $EF, $EE, "looked fearsome!", $F7
    db $F0

String_8A_00_1D:: ; heuristic: string; C0
Data_08A_4FBB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I met a traveler", $F1
    db "who had monsters", $FA, $F7
    db $EF, $EE, "with him, just", $EF, $EE, "like you.", $FA, $F7
    db $EF, $EE, "They used skills", $EF, $EE, "I", $44, " never seen.", $F7
    db $F0

String_8A_00_1E:: ; heuristic: string; C0
Data_08A_5022:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: If you ignore", $F1
    db "them, monsters", $FA, $F7
    db $EF, $EE, "will ignore you", $EF, $EE, "too.", $F7
    db $F0

String_8A_00_1F:: ; heuristic: string; C0
Data_08A_505C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: While we do get", $F1
    db "travelers here,", $FA, $F7
    db $EF, $EE, "I've only seen one", $EF, $EE, "other kid.", $FA, $F7
    db $EF, $EE, "It was a boy", $A4, $EF, $EE, "Terry, I think.", $F7
    db $F0

String_8A_00_20:: ; heuristic: string; C0
Data_08A_50C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $F7
    db $F0

String_8A_00_21:: ; heuristic: string; C0
Data_08A_50F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $F7
    db $F0

String_8A_00_22:: ; heuristic: string; C0
Data_08A_5125:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "open the chest.", $FA, $F7
    db $EF, $EE, "But it was locked.", $EF, $EE, $F7
    db $F0

String_8A_00_23:: ; heuristic: string; C0
Data_08A_515A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Hello! How may I", $F1
    db "help you today?", $F7
    db $F0

String_8A_00_24:: ; heuristic: string; C0
Data_08A_517F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Welcome to the", $F1
    db "traveler's inn!", $F7
    db $F0

String_8A_00_25:: ; heuristic: string; C0
Data_08A_51A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Let me see what", $F1
    db "you are made of!", $F7
    db $F0

String_8A_00_26:: ; heuristic: string; C0
Data_08A_51C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: You'll have to", $F1
    db "beat me to pass!", $F7
    db $F0

String_8A_00_27:: ; heuristic: string; C0
Data_08A_51E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I am a servant", $F1
    db "of the Gods.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you today?", $F7
    db $F0

String_8A_00_28:: ; heuristic: string; C0
Data_08A_5228:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Welcome to the", $F1
    db "traveler's inn!", $FA, $F7
    db $EF, $EE, "The view here is", $EF, $EE, "magnificent!", $F7
    db $F0

String_8A_00_29:: ; heuristic: string; C0
Data_08A_526C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The evil force", $F1
    db "enshrouding the", $FA, $F7
    db $EF, $EE, "entire world faded", $EF, $EE, "away!", $F7
    db $F0

String_8A_00_2A:: ; heuristic: string; C0
Data_08A_52A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The evil force", $F1
    db "covering the", $FA, $F7
    db $EF, $EE, "continent faded", $EF, $EE, "away!", $F7
    db $F0

String_8A_00_2B:: ; heuristic: string; C0
Data_08A_52E0:: ; address name
    db $F0
    ds $2D1F, $00
