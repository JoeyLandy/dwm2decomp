SECTION "Bank 8A", ROMX[$4000], BANK[$8A]
    db $8A

; ld de, this bank's string table / BeginStringDisplay
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_Case14, ScriptCommand09_Case01_Sub01_Case0D, Talk09Event00_Case05_Sub01_Sub01_Case01)
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
    dw Data_08A_4216 ; id 0
    dw Data_08A_432E ; id 1
    dw Data_08A_4428 ; id 2
    dw Data_08A_4545 ; id 3
    dw Data_08A_4657 ; id 4
    dw Data_08A_4704 ; id 5
    dw Data_08A_4704 ; id 6
    dw Data_08A_4704 ; id 7
    dw Data_08A_4704 ; id 8
    dw Data_08A_486F ; id 9
    dw Data_08A_49B2 ; id 10
    dw Data_08A_4AEE ; id 11
    dw Data_08A_4AEE ; id 12
    dw Data_08A_4AEE ; id 13
    dw Data_08A_4AEE ; id 14
    dw Data_08A_4AEE ; id 15
    dw Data_08A_4AEE ; id 16
    dw Data_08A_4B79 ; id 17
    dw Data_08A_4B79 ; id 18
    dw Data_08A_4B79 ; id 19
    dw Data_08A_4BFC ; id 20
    dw Data_08A_4C75 ; id 21
    dw Data_08A_4CB9 ; id 22
    dw Data_08A_4D45 ; id 23
    dw Data_08A_4D7D ; id 24
    dw Data_08A_4DDE ; id 25
    dw Data_08A_4E71 ; id 26
    dw Data_08A_4EB8 ; id 27
    dw Data_08A_4F54 ; id 28
    dw Data_08A_4FBB ; id 29
    dw Data_08A_5022 ; id 30
    dw Data_08A_505C ; id 31
    dw Data_08A_50C3 ; id 32
    dw Data_08A_50F4 ; id 33
    dw Data_08A_5125 ; id 34
    dw Data_08A_515A ; id 35
    dw Data_08A_517F ; id 36
    dw Data_08A_51A1 ; id 37
    dw Data_08A_51C6 ; id 38
    dw Data_08A_51E9 ; id 39
    dw Data_08A_5228 ; id 40
    dw Data_08A_526C ; id 41
    dw Data_08A_52A9 ; id 42
    dw Data_08A_52E0 ; id 43
    dw Data_08A_52E0 ; id 44
    dw Data_08A_52E0 ; id 45
    dw Data_08A_52E0 ; id 46
    dw Data_08A_52E0 ; id 47
    dw Data_08A_52E0 ; id 48
    dw Data_08A_52E0 ; id 49
    dw Data_08A_52E0 ; id 50
    dw Data_08A_52E0 ; id 51
    dw Data_08A_52E0 ; id 52
    dw Data_08A_52E0 ; id 53
    dw Data_08A_52E0 ; id 54
    dw Data_08A_52E0 ; id 55
    dw Data_08A_52E0 ; id 56
    dw Data_08A_52E0 ; id 57
    dw Data_08A_52E0 ; id 58
    dw Data_08A_52E0 ; id 59
    dw Data_08A_52E0 ; id 60
    dw Data_08A_52E0 ; id 61
    dw Data_08A_52E0 ; id 62
    dw Data_08A_52E0 ; id 63
    dw Data_08A_52E0 ; id 64
    dw Data_08A_52E0 ; id 65
    dw Data_08A_52E0 ; id 66
    dw Data_08A_52E0 ; id 67
    dw Data_08A_52E0 ; id 68
    dw Data_08A_52E0 ; id 69
    dw Data_08A_52E0 ; id 70
    dw Data_08A_52E0 ; id 71
    dw Data_08A_52E0 ; id 72
    dw Data_08A_52E0 ; id 73
    dw Data_08A_52E0 ; id 74
    dw Data_08A_52E0 ; id 75
    dw Data_08A_52E0 ; id 76
    dw Data_08A_52E0 ; id 77
    dw Data_08A_52E0 ; id 78
    dw Data_08A_52E0 ; id 79
    dw Data_08A_52E0 ; id 80
    dw Data_08A_52E0 ; id 81
    dw Data_08A_52E0 ; id 82
    dw Data_08A_52E0 ; id 83
    dw Data_08A_52E0 ; id 84
    dw Data_08A_52E0 ; id 85
    dw Data_08A_52E0 ; id 86
    dw Data_08A_52E0 ; id 87
    dw Data_08A_52E0 ; id 88
    dw Data_08A_52E0 ; id 89
    dw Data_08A_52E0 ; id 90
    dw Data_08A_52E0 ; id 91
    dw Data_08A_52E0 ; id 92
    dw Data_08A_52E0 ; id 93
    dw Data_08A_52E0 ; id 94
    dw Data_08A_52E0 ; id 95
    dw Data_08A_52E0 ; id 96
    dw Data_08A_52E0 ; id 97
    dw Data_08A_52E0 ; id 98
    dw Data_08A_52E0 ; id 99
    dw Data_08A_52E0 ; id 100
    dw Data_08A_52E0 ; id 101
    dw Data_08A_52E0 ; id 102
    dw Data_08A_52E0 ; id 103
    dw Data_08A_52E0 ; id 104
    dw Data_08A_52E0 ; id 105
    dw Data_08A_52E0 ; id 106
    dw Data_08A_52E0 ; id 107
    dw Data_08A_52E0 ; id 108
    dw Data_08A_52E0 ; id 109
    dw Data_08A_52E0 ; id 110
    dw Data_08A_52E0 ; id 111
    dw Data_08A_52E0 ; id 112
    dw Data_08A_52E0 ; id 113
    dw Data_08A_52E0 ; id 114
    dw Data_08A_52E0 ; id 115
    dw Data_08A_52E0 ; id 116
    dw Data_08A_52E0 ; id 117
    dw Data_08A_52E0 ; id 118
    dw Data_08A_52E0 ; id 119
    dw Data_08A_52E0 ; id 120
    dw Data_08A_52E0 ; id 121
    dw Data_08A_52E0 ; id 122
    dw Data_08A_52E0 ; id 123
    dw Data_08A_52E0 ; id 124
    dw Data_08A_52E0 ; id 125
    dw Data_08A_52E0 ; id 126
    dw Data_08A_52E0 ; id 127
    dw Data_08A_52E0 ; id 128
    dw Data_08A_52E0 ; id 129
    dw Data_08A_52E0 ; id 130
    dw Data_08A_52E0 ; id 131
    dw Data_08A_52E0 ; id 132
    dw Data_08A_52E0 ; id 133
    dw Data_08A_52E0 ; id 134
    dw Data_08A_52E0 ; id 135
    dw Data_08A_52E0 ; id 136
    dw Data_08A_52E0 ; id 137
    dw Data_08A_52E0 ; id 138
    dw Data_08A_52E0 ; id 139
    dw Data_08A_52E0 ; id 140
    dw Data_08A_52E0 ; id 141
    dw Data_08A_52E0 ; id 142
    dw Data_08A_52E0 ; id 143
    dw Data_08A_52E0 ; id 144
    dw Data_08A_52E0 ; id 145
    dw Data_08A_52E0 ; id 146
    dw Data_08A_52E0 ; id 147
    dw Data_08A_52E0 ; id 148
    dw Data_08A_52E0 ; id 149
    dw Data_08A_52E0 ; id 150
    dw Data_08A_52E0 ; id 151
    dw Data_08A_52E0 ; id 152
    dw Data_08A_52E0 ; id 153
    dw Data_08A_52E0 ; id 154
    dw Data_08A_52E0 ; id 155
    dw Data_08A_52E0 ; id 156
    dw Data_08A_52E0 ; id 157
    dw Data_08A_52E0 ; id 158
    dw Data_08A_52E0 ; id 159
    dw Data_08A_52E0 ; id 160
    dw Data_08A_52E0 ; id 161
    dw Data_08A_52E0 ; id 162
    dw Data_08A_52E0 ; id 163
    dw Data_08A_52E0 ; id 164
    dw Data_08A_52E0 ; id 165
    dw Data_08A_52E0 ; id 166
    dw Data_08A_52E0 ; id 167
    dw Data_08A_52E0 ; id 168
    dw Data_08A_52E0 ; id 169
    dw Data_08A_52E0 ; id 170
    dw Data_08A_52E0 ; id 171
    dw Data_08A_52E0 ; id 172
    dw Data_08A_52E0 ; id 173
    dw Data_08A_52E0 ; id 174
    dw Data_08A_52E0 ; id 175
    dw Data_08A_52E0 ; id 176
    dw Data_08A_52E0 ; id 177
    dw Data_08A_52E0 ; id 178
    dw Data_08A_52E0 ; id 179
    dw Data_08A_52E0 ; id 180
    dw Data_08A_52E0 ; id 181
    dw Data_08A_52E0 ; id 182
    dw Data_08A_52E0 ; id 183
    dw Data_08A_52E0 ; id 184
    dw Data_08A_52E0 ; id 185
    dw Data_08A_52E0 ; id 186
    dw Data_08A_52E0 ; id 187
    dw Data_08A_52E0 ; id 188
    dw Data_08A_52E0 ; id 189
    dw Data_08A_52E0 ; id 190
    dw Data_08A_52E0 ; id 191
    dw Data_08A_52E0 ; id 192
    dw Data_08A_52E0 ; id 193
    dw Data_08A_52E0 ; id 194
    dw Data_08A_52E0 ; id 195
    dw Data_08A_52E0 ; id 196
    dw Data_08A_52E0 ; id 197
    dw Data_08A_52E0 ; id 198
    dw Data_08A_52E0 ; id 199
    dw Data_08A_52E0 ; id 200
    dw Data_08A_52E0 ; id 201
    dw Data_08A_52E0 ; id 202
    dw Data_08A_52E0 ; id 203
    dw Data_08A_52E0 ; id 204
    dw Data_08A_52E0 ; id 205
    dw Data_08A_52E0 ; id 206
    dw Data_08A_52E0 ; id 207
    dw Data_08A_52E0 ; id 208
    dw Data_08A_52E0 ; id 209
    dw Data_08A_52E0 ; id 210
    dw Data_08A_52E0 ; id 211
    dw Data_08A_52E0 ; id 212
    dw Data_08A_52E0 ; id 213
    dw Data_08A_52E0 ; id 214
    dw Data_08A_52E0 ; id 215
    dw Data_08A_52E0 ; id 216
    dw Data_08A_52E0 ; id 217
    dw Data_08A_52E0 ; id 218
    dw Data_08A_52E0 ; id 219
    dw Data_08A_52E0 ; id 220
    dw Data_08A_52E0 ; id 221
    dw Data_08A_52E0 ; id 222
    dw Data_08A_52E0 ; id 223
    dw Data_08A_52E0 ; id 224
    dw Data_08A_52E0 ; id 225
    dw Data_08A_52E0 ; id 226
    dw Data_08A_52E0 ; id 227
    dw Data_08A_52E0 ; id 228
    dw Data_08A_52E0 ; id 229
    dw Data_08A_52E0 ; id 230
    dw Data_08A_52E0 ; id 231
    dw Data_08A_52E0 ; id 232
    dw Data_08A_52E0 ; id 233
    dw Data_08A_52E0 ; id 234
    dw Data_08A_52E0 ; id 235
    dw Data_08A_52E0 ; id 236
    dw Data_08A_52E0 ; id 237
    dw Data_08A_52E0 ; id 238
    dw Data_08A_52E0 ; id 239
    dw Data_08A_52E0 ; id 240
    dw Data_08A_52E0 ; id 241
    dw Data_08A_52E0 ; id 242
    dw Data_08A_52E0 ; id 243
    dw Data_08A_52E0 ; id 244
    dw Data_08A_52E0 ; id 245
    dw Data_08A_52E0 ; id 246
    dw Data_08A_52E0 ; id 247
    dw Data_08A_52E0 ; id 248
    dw Data_08A_52E0 ; id 249
    dw Data_08A_52E0 ; id 250
    dw Data_08A_52E0 ; id 251
    dw Data_08A_52E0 ; id 252
    dw Data_08A_52E0 ; id 253
    dw Data_08A_52E0 ; id 254

Data_08A_4216:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll tell you", $F1
    db "about this great", $FA, $F7
    db $EF, $EE, "adventure story I", $EF, $EE, "read long ago.", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 1,", $EF, $EE, "The Name is Hasta", $A4, $FA, $F7
    db $EF, $EE, "There once was a", $EF, $EE, "boy named Hasta.", $FA, $F7
    db $EF, $EE, "Who dreamed of", $EF, $EE, "becoming a master.", $FA, $F7
    db $EF, $EE, "One day he awoke,", $EF, $EE, "and had a nice", $A4, $FA, $F7
    db $EF, $EE, $A4, "Wait, how", $44, " the", $EF, $EE, "rest of it go?", $F7
    db $F0

Data_08A_432E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, do you know", $F1
    db "this tale? Listen!", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 2,", $EF, $EE, "What Lies Beside", $A4, $FA, $F7
    db $EF, $EE, "When Hasta awoke,", $EF, $EE, "he realized that", $FA, $F7
    db $EF, $EE, "he wasn't alone in", $EF, $EE, "his bed.", $FA, $F7
    db $EF, $EE, "Lying beside him", $EF, $EE, "was a rotted body!", $FA, $F7
    db $EF, $EE, "What do you think?", $EF, $EE, "Pretty scary, eh?", $F7
    db $F0

Data_08A_4428:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Want to hear", $F1
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

Data_08A_4545:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let me recount", $F1
    db "this ancient lore", $A4, $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure", $A4, $FA, $F7
    db $EF, $EE, "Book 4,", $EF, $EE, "Undead Calm", $A4, $FA, $F7
    db $EF, $EE, "Hork stretched and", $EF, $EE, "yawned out loud,", $FA, $F7
    db $EF, $EE, $95, "Fwaaah", $A4, " I need my", $EF, $EE, "beauty sleep.", $95, $FA, $F7
    db $EF, $EE, "And Hork went back", $EF, $EE, "to sleep.", $FA, $F7
    db $EF, $EE, "I guess that must", $EF, $EE, "be what sleeping", $FA, $F7
    db $EF, $EE, "like the dead is", $EF, $EE, "all about.", $F7
    db $F0

Data_08A_4657:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Long ago, there", $F1
    db "were books titled", $FA, $F7
    db $EF, $EE, "Master Hasta's", $EF, $EE, "Adventure.", $FA, $F7
    db $EF, $EE, "But the author", $EF, $EE, "gave up after just", $FA, $F7
    db $EF, $EE, "four slim books, I", $EF, $EE, "hear.", $FA, $F7
    db $EF, $EE, "I wonder if anyone", $EF, $EE, "remembers them?", $F7
    db $F0

Data_08A_4704:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hey, did you", $F1
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

Data_08A_486F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " If you visit any", $F1
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

Data_08A_49B2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " In every world", $F1
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

Data_08A_4AEE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There should be", $F1
    db "a castle in which", $FA, $F7
    db $EF, $EE, "the monster boss", $EF, $EE, "resides.", $FA, $F7
    db $EF, $EE, "Wild monsters are", $EF, $EE, "dominated by the", $FA, $F7
    db $EF, $EE, "boss, and won't", $EF, $EE, "become tame", $A4, $F7
    db $F0

Data_08A_4B79:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monsters you", $F1
    db "beat in battle", $FA, $F7
    db $EF, $EE, "could join your", $EF, $EE, "party.", $FA, $F7
    db $EF, $EE, "A strong monster", $EF, $EE, "makes a powerful", $FA, $F7
    db $EF, $EE, "companion-if you", $EF, $EE, "can get one.", $F7
    db $F0

Data_08A_4BFC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monsters you", $F1
    db "beat in battle", $FA, $F7
    db $EF, $EE, "could join your", $EF, $EE, "party.", $FA, $F7
    db $EF, $EE, "But their boss", $EF, $EE, "must be beaten", $FA, $F7
    db $EF, $EE, "before that can", $EF, $EE, "happen.", $F7
    db $F0

Data_08A_4C75:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Traveling with", $F1
    db "monsters?", $FA, $F7
    db $EF, $EE, "That takes a good", $EF, $EE, "deal of courage.", $F7
    db $F0

Data_08A_4CB9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're so young", $F1
    db "and small, but", $FA, $F7
    db $EF, $EE, "here you are, on a", $EF, $EE, "perilous journey", $A4, $FA, $F7
    db $EF, $EE, "Our soldiers can", $EF, $EE, "stand to learn a", $FA, $F7
    db $EF, $EE, "thing or two from", $EF, $EE, "you!", $F7
    db $F0

Data_08A_4D45:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Castle is", $F1
    db "safe.", $FA, $F7
    db $EF, $EE, "Relax, and enjoy", $EF, $EE, "your stay.", $F7
    db $F0

Data_08A_4D7D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Do you know of", $F1
    db "the MeteOrb?", $FA, $F7
    db $EF, $EE, "It's a rare item", $EF, $EE, "that does away", $FA, $F7
    db $EF, $EE, "with a monster's", $EF, $EE, "mistrust.", $F7
    db $F0

Data_08A_4DDE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The last monster", $F1
    db "you beat in battle", $FA, $F7
    db $EF, $EE, "has a chance of", $EF, $EE, "joining you.", $FA, $F7
    db $EF, $EE, "If you're after a", $EF, $EE, "specific species,", $FA, $F7
    db $EF, $EE, "you might consider", $EF, $EE, "healing it.", $F7
    db $F0

Data_08A_4E71:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There's a monster", $F1
    db "that's skilled at", $FA, $F7
    db $EF, $EE, "attracting the", $EF, $EE, "opposite sex.", $F7
    db $F0

Data_08A_4EB8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you want to", $F1
    db "befriend monsters,", $FA, $F7
    db $EF, $EE, "give them meat,", $EF, $EE, "and don't be cheap.", $FA, $F7
    db $EF, $EE, "The more expensive", $EF, $EE, "it is, the better", $FA, $F7
    db $EF, $EE, "the quality of the", $EF, $EE, "meat, you see.", $F7
    db $F0

Data_08A_4F54:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I met a traveler", $F1
    db "who had monsters", $FA, $F7
    db $EF, $EE, "with him, just", $EF, $EE, "like you.", $FA, $F7
    db $EF, $EE, "Those monsters", $EF, $EE, "looked fearsome!", $F7
    db $F0

Data_08A_4FBB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I met a traveler", $F1
    db "who had monsters", $FA, $F7
    db $EF, $EE, "with him, just", $EF, $EE, "like you.", $FA, $F7
    db $EF, $EE, "They used skills", $EF, $EE, "I", $44, " never seen.", $F7
    db $F0

Data_08A_5022:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you ignore", $F1
    db "them, monsters", $FA, $F7
    db $EF, $EE, "will ignore you", $EF, $EE, "too.", $F7
    db $F0

Data_08A_505C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " While we do get", $F1
    db "travelers here,", $FA, $F7
    db $EF, $EE, "I", $42, "e only seen one", $EF, $EE, "other kid.", $FA, $F7
    db $EF, $EE, "It was a boy", $A4, $EF, $EE, "Terry, I think.", $F7
    db $F0

Data_08A_50C3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $F7
    db $F0

Data_08A_50F4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "But it was empty.", $EF, $EE, $F7
    db $F0

Data_08A_5125:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "open the chest.", $FA, $F7
    db $EF, $EE, "But it was locked.", $EF, $EE, $F7
    db $F0

Data_08A_515A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello! How may I", $F1
    db "help you today?", $F7
    db $F0

Data_08A_517F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "traveler's inn!", $F7
    db $F0

Data_08A_51A1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Let me see what", $F1
    db "you are made of!", $F7
    db $F0

Data_08A_51C6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You'll have to", $F1
    db "beat me to pass!", $F7
    db $F0

Data_08A_51E9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I am a servant", $F1
    db "of the Gods.", $FA, $F7
    db $EF, $EE, "How may I serve", $EF, $EE, "you today?", $F7
    db $F0

Data_08A_5228:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "traveler's inn!", $FA, $F7
    db $EF, $EE, "The view here is", $EF, $EE, "magnificent!", $F7
    db $F0

Data_08A_526C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The evil force", $F1
    db "enshrouding the", $FA, $F7
    db $EF, $EE, "entire world faded", $EF, $EE, "away!", $F7
    db $F0

Data_08A_52A9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The evil force", $F1
    db "covering the", $FA, $F7
    db $EF, $EE, "continent faded", $EF, $EE, "away!", $F7
    db $F0

Data_08A_52E0:: ; heuristic: string; C0
    db $F0
    ds $2D1F, $00
