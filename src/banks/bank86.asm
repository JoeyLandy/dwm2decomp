SECTION "Bank 86", ROMX[$4000], BANK[$86]
    db $86

; ld de, this bank's string table / BeginStringDisplay
; 3 call sites from 3 routines (e.g. DebugMessageTest_Update_Case0C, ScriptCommand09_Case01_Sub01_Case0C, ShowMessageHL_Case0C)
BeginStringDisplay_Bank86::
Func_086_4001:: ; address name
    ld de, StringCategories_86_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_86_4016::
Data_086_4016:: ; address name
    dw StringList_86_4018 ; id 0

; E-0217 (derived: category list of StringCategories_86_4016; one pointer per wStringIndex)
; record: string
StringList_86_4018::
Data_086_4018:: ; address name
    dw Message_0C_00 ; id 0
    dw Message_0C_01 ; id 1
    dw Message_0C_02 ; id 2
    dw Message_0C_03 ; id 3
    dw Message_0C_04 ; id 4
    dw Message_0C_05 ; id 5
    dw Message_0C_06 ; id 6
    dw Message_0C_07 ; id 7
    dw Message_0C_08 ; id 8
    dw Message_0C_09 ; id 9
    dw Message_0C_0A ; id 10
    dw Message_0C_0B ; id 11
    dw Message_0C_0C ; id 12
    dw Message_0C_0D ; id 13
    dw Message_0C_0E ; id 14
    dw Message_0C_0F ; id 15
    dw Message_0C_10 ; id 16
    dw Message_0C_11 ; id 17
    dw Message_0C_12 ; id 18
    dw Message_0C_13 ; id 19
    dw Message_0C_14 ; id 20
    dw Message_0C_15 ; id 21
    dw Message_0C_16 ; id 22
    dw Message_0C_17 ; id 23
    dw Message_0C_18 ; id 24
    dw Message_0C_19 ; id 25
    dw Message_0C_1A ; id 26
    dw Message_0C_1B ; id 27
    dw Message_0C_1C ; id 28
    dw Message_0C_1D ; id 29
    dw Message_0C_1E ; id 30
    dw Message_0C_1F ; id 31
    dw Message_0C_20 ; id 32
    dw Message_0C_21 ; id 33
    dw Message_0C_22 ; id 34
    dw Message_0C_23 ; id 35
    dw Message_0C_24 ; id 36
    dw Message_0C_25 ; id 37
    dw Message_0C_26 ; id 38
    dw Message_0C_27 ; id 39
    dw Message_0C_28 ; id 40
    dw Message_0C_29 ; id 41
    dw Message_0C_2A ; id 42
    dw Message_0C_2B ; id 43
    dw Message_0C_2C ; id 44
    dw Message_0C_2D ; id 45
    dw Message_0C_2E ; id 46
    dw Message_0C_2F ; id 47
    dw Message_0C_30 ; id 48
    dw Message_0C_31 ; id 49
    dw Message_0C_32 ; id 50
    dw Message_0C_33 ; id 51
    dw Message_0C_34 ; id 52
    dw Message_0C_35 ; id 53
    dw Message_0C_36 ; id 54
    dw Message_0C_37 ; id 55
    dw Message_0C_38 ; id 56
    dw Message_0C_39 ; id 57
    dw Message_0C_3A ; id 58
    dw Message_0C_3B ; id 59
    dw Message_0C_3C ; id 60
    dw Message_0C_3D ; id 61
    dw Message_0C_3E ; id 62
    dw Message_0C_3F ; id 63
    dw Message_0C_40 ; id 64
    dw Message_0C_41 ; id 65
    dw Message_0C_42 ; id 66
    dw Message_0C_43 ; id 67
    dw Message_0C_44 ; id 68
    dw Message_0C_45 ; id 69
    dw Message_0C_46 ; id 70
    dw Message_0C_47 ; id 71
    dw Message_0C_48 ; id 72
    dw Message_0C_49 ; id 73
    dw Message_0C_4A ; id 74
    dw Message_0C_4B ; id 75
    dw Message_0C_4C ; id 76
    dw Message_0C_4D ; id 77
    dw Message_0C_4E ; id 78
    dw Message_0C_4F ; id 79
    dw Message_0C_50 ; id 80
    dw Message_0C_51 ; id 81
    dw Message_0C_52 ; id 82
    dw Message_0C_53 ; id 83
    dw Message_0C_54 ; id 84
    dw Message_0C_55 ; id 85
    dw Message_0C_56 ; id 86
    dw Message_0C_57 ; id 87
    dw Message_0C_58 ; id 88
    dw Message_0C_58 ; id 89
    dw Message_0C_58 ; id 90
    dw Message_0C_58 ; id 91
    dw Message_0C_58 ; id 92
    dw Message_0C_58 ; id 93
    dw Message_0C_58 ; id 94
    dw Message_0C_58 ; id 95
    dw Message_0C_58 ; id 96
    dw Message_0C_58 ; id 97
    dw Message_0C_58 ; id 98
    dw Message_0C_58 ; id 99
    dw Message_0C_58 ; id 100
    dw Message_0C_58 ; id 101
    dw Message_0C_58 ; id 102
    dw Message_0C_58 ; id 103
    dw Message_0C_58 ; id 104
    dw Message_0C_58 ; id 105
    dw Message_0C_58 ; id 106
    dw Message_0C_58 ; id 107
    dw Message_0C_58 ; id 108
    dw Message_0C_58 ; id 109
    dw Message_0C_58 ; id 110
    dw Message_0C_58 ; id 111
    dw Message_0C_58 ; id 112
    dw Message_0C_58 ; id 113
    dw Message_0C_58 ; id 114
    dw Message_0C_58 ; id 115
    dw Message_0C_58 ; id 116
    dw Message_0C_58 ; id 117
    dw Message_0C_58 ; id 118
    dw Message_0C_58 ; id 119
    dw Message_0C_58 ; id 120
    dw Message_0C_58 ; id 121
    dw Message_0C_58 ; id 122
    dw Message_0C_58 ; id 123
    dw Message_0C_58 ; id 124
    dw Message_0C_58 ; id 125
    dw Message_0C_58 ; id 126
    dw Message_0C_58 ; id 127
    dw Message_0C_58 ; id 128
    dw Message_0C_58 ; id 129
    dw Message_0C_58 ; id 130
    dw Message_0C_58 ; id 131
    dw Message_0C_58 ; id 132
    dw Message_0C_58 ; id 133
    dw Message_0C_58 ; id 134
    dw Message_0C_58 ; id 135
    dw Message_0C_58 ; id 136
    dw Message_0C_58 ; id 137
    dw Message_0C_58 ; id 138
    dw Message_0C_58 ; id 139
    dw Message_0C_58 ; id 140
    dw Message_0C_58 ; id 141
    dw Message_0C_58 ; id 142
    dw Message_0C_58 ; id 143
    dw Message_0C_58 ; id 144
    dw Message_0C_58 ; id 145
    dw Message_0C_58 ; id 146
    dw Message_0C_58 ; id 147
    dw Message_0C_58 ; id 148
    dw Message_0C_58 ; id 149
    dw Message_0C_58 ; id 150
    dw Message_0C_58 ; id 151
    dw Message_0C_58 ; id 152
    dw Message_0C_58 ; id 153
    dw Message_0C_58 ; id 154
    dw Message_0C_58 ; id 155
    dw Message_0C_58 ; id 156
    dw Message_0C_58 ; id 157
    dw Message_0C_58 ; id 158
    dw Message_0C_58 ; id 159
    dw Message_0C_58 ; id 160
    dw Message_0C_58 ; id 161
    dw Message_0C_58 ; id 162
    dw Message_0C_58 ; id 163
    dw Message_0C_58 ; id 164
    dw Message_0C_58 ; id 165
    dw Message_0C_58 ; id 166
    dw Message_0C_58 ; id 167
    dw Message_0C_58 ; id 168
    dw Message_0C_58 ; id 169
    dw Message_0C_58 ; id 170
    dw Message_0C_58 ; id 171
    dw Message_0C_58 ; id 172
    dw Message_0C_58 ; id 173
    dw Message_0C_58 ; id 174
    dw Message_0C_58 ; id 175
    dw Message_0C_58 ; id 176
    dw Message_0C_58 ; id 177
    dw Message_0C_58 ; id 178
    dw Message_0C_58 ; id 179
    dw Message_0C_58 ; id 180
    dw Message_0C_58 ; id 181
    dw Message_0C_58 ; id 182
    dw Message_0C_58 ; id 183
    dw Message_0C_58 ; id 184
    dw Message_0C_58 ; id 185
    dw Message_0C_58 ; id 186
    dw Message_0C_58 ; id 187
    dw Message_0C_58 ; id 188
    dw Message_0C_58 ; id 189
    dw Message_0C_58 ; id 190
    dw Message_0C_58 ; id 191
    dw Message_0C_58 ; id 192
    dw Message_0C_58 ; id 193
    dw Message_0C_58 ; id 194
    dw Message_0C_58 ; id 195
    dw Message_0C_58 ; id 196
    dw Message_0C_58 ; id 197
    dw Message_0C_58 ; id 198
    dw Message_0C_58 ; id 199
    dw Message_0C_58 ; id 200
    dw Message_0C_58 ; id 201
    dw Message_0C_58 ; id 202
    dw Message_0C_58 ; id 203
    dw Message_0C_58 ; id 204
    dw Message_0C_58 ; id 205
    dw Message_0C_58 ; id 206
    dw Message_0C_58 ; id 207
    dw Message_0C_58 ; id 208
    dw Message_0C_58 ; id 209
    dw Message_0C_58 ; id 210
    dw Message_0C_58 ; id 211
    dw Message_0C_58 ; id 212
    dw Message_0C_58 ; id 213
    dw Message_0C_58 ; id 214
    dw Message_0C_58 ; id 215
    dw Message_0C_58 ; id 216
    dw Message_0C_58 ; id 217
    dw Message_0C_58 ; id 218
    dw Message_0C_58 ; id 219
    dw Message_0C_58 ; id 220
    dw Message_0C_58 ; id 221
    dw Message_0C_58 ; id 222
    dw Message_0C_DF ; id 223
    dw Message_0C_E0 ; id 224
    dw Message_0C_E1 ; id 225
    dw Message_0C_E2 ; id 226
    dw Message_0C_E3 ; id 227
    dw Message_0C_E4 ; id 228
    dw Message_0C_E5 ; id 229
    dw Message_0C_E6 ; id 230
    dw Message_0C_E7 ; id 231
    dw Message_0C_E8 ; id 232
    dw Message_0C_E9 ; id 233
    dw Message_0C_EA ; id 234
    dw Message_0C_EB ; id 235
    dw Message_0C_EC ; id 236
    dw Message_0C_ED ; id 237
    dw Message_0C_EE ; id 238
    dw Message_0C_EF ; id 239
    dw Message_0C_F0 ; id 240
    dw Message_0C_F1 ; id 241
    dw Message_0C_F2 ; id 242
    dw Message_0C_F3 ; id 243
    dw Message_0C_F4 ; id 244
    dw Message_0C_F5 ; id 245
    dw Message_0C_F6 ; id 246
    dw Message_0C_F7 ; id 247
    dw Message_0C_F8 ; id 248
    dw Message_0C_F9 ; id 249
    dw Message_0C_FA ; id 250
    dw Message_0C_FB ; id 251
    dw Message_0C_FC ; id 252
    dw Message_0C_FD ; id 253
    dw Message_0C_FE ; id 254
    dw Message_0C_FF ; id 255

Message_0C_00:: ; heuristic: string; C0
Data_086_4218:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "Power Tower.", $FA, $F7
    db $EF, $EE, "Are you the new", $EF, $EE, "challenger?", $FA, $F7
    db $EF, $EE, "If you win, you'll", $EF, $EE, "earn many useful", $FA, $F7
    db $EF, $EE, "accessories for", $EF, $EE, "your monsters.", $FA, $F7
    db $EF, $EE, "Could you get them", $EF, $EE, "all?", $F7
    db $F0

Message_0C_01:: ; heuristic: string; C0
Data_086_42BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you win,", $F1
    db "you'll earn many", $FA, $F7
    db $EF, $EE, "useful accessories", $EF, $EE, "for your monsters.", $FA, $F7
    db $EF, $EE, "Could you get them", $EF, $EE, "all?", $F7
    db $F0

Message_0C_02:: ; heuristic: string; C0
Data_086_4321:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Only a handful", $F1
    db "of masters have", $FA, $F7
    db $EF, $EE, "made it to the top", $EF, $EE, "of the Tower.", $FA, $F7
    db $EF, $EE, "I tried, but the", $EF, $EE, "best I could do", $FA, $F7
    db $EF, $EE, "was reach the", $EF, $EE, "fourth floor.", $F7
    db $F0

Message_0C_03:: ; heuristic: string; C0
Data_086_43AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The Tower's many", $F1
    db "treasures are", $FA, $F7
    db $EF, $EE, "heavily guarded by", $EF, $EE, "monsters, slurp.", $FA, $F7
    db $EF, $EE, "They'll attack you", $EF, $EE, "all out, slurp.", $F7
    db $F0

Message_0C_04:: ; heuristic: string; C0
Data_086_441E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "second floor-", $FA, $F7
    db $EF, $EE, "the Whirlwind", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "Can you withstand", $EF, $EE, "our wind power?", $F7
    db $F0

Message_0C_05:: ; heuristic: string; C0
Data_086_447D:: ; address name
    db $F0

Message_0C_06:: ; heuristic: string; C0
Data_086_447E:: ; address name
    db $F0

Message_0C_07:: ; heuristic: string; C0
Data_086_447F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Not bad, not bad", $F1
    db "at all.", $FA, $F7
    db $EF, $EE, "Fine. Take the", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "The Clearwater", $EF, $EE, "Chamber is next.", $FA, $F7
    db $EF, $EE, "Monsters that use", $EF, $EE, "water skills will", $FA, $F7
    db $EF, $EE, "be waiting for", $EF, $EE, "you.", $F7
    db $F0

Message_0C_08:: ; heuristic: string; C0
Data_086_451E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "third floor-", $FA, $F7
    db $EF, $EE, "the Clearwater", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "If you belittle", $EF, $EE, "hydropower, you", $FA, $F7
    db $EF, $EE, "will suffer for", $EF, $EE, "your ignorance!", $F7
    db $F0

Message_0C_09:: ; heuristic: string; C0
Data_086_459F:: ; address name
    db $F0

Message_0C_0A:: ; heuristic: string; C0
Data_086_45A0:: ; address name
    db $F0

Message_0C_0B:: ; heuristic: string; C0
Data_086_45A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're quite", $F1
    db "good.", $FA, $F7
    db $EF, $EE, "The treasures are", $EF, $EE, "yours to take.", $FA, $F7
    db $EF, $EE, "Upstairs is the", $EF, $EE, "Blizzard Chamber.", $FA, $F7
    db $EF, $EE, "It's very cold, so", $EF, $EE, "be careful.", $F7
    db $F0

Message_0C_0C:: ; heuristic: string; C0
Data_086_4624:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "fourth floor-", $FA, $F7
    db $EF, $EE, "the Blizzard", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "I hope you're", $EF, $EE, "bundled up warm.", $FA, $F7
    db $EF, $EE, "We'll freeze you", $EF, $EE, "solid!", $F7
    db $F0

Message_0C_0D:: ; heuristic: string; C0
Data_086_4699:: ; address name
    db $F0

Message_0C_0E:: ; heuristic: string; C0
Data_086_469A:: ; address name
    db $F0

Message_0C_0F:: ; heuristic: string; C0
Data_086_469B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wow, aren't you", $F1
    db "good.", $FA, $F7
    db $EF, $EE, "Go ahead and take", $EF, $EE, "the treasures.", $FA, $F7
    db $EF, $EE, "The Thunder", $EF, $EE, "Chamber's next.", $FA, $F7
    db $EF, $EE, "You can always", $EF, $EE, "hear the sound of", $FA, $F7
    db $EF, $EE, "crashing thunder.", $EF, $EE, "It's annoying!", $F7
    db $F0

Message_0C_10:: ; heuristic: string; C0
Data_086_4741:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "fifth floor-", $FA, $F7
    db $EF, $EE, "the Thunder", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "Prepare for", $EF, $EE, "obliteration!", $F7
    db $F0

Message_0C_11:: ; heuristic: string; C0
Data_086_4795:: ; address name
    db $F0

Message_0C_12:: ; heuristic: string; C0
Data_086_4796:: ; address name
    db $F0

Message_0C_13:: ; heuristic: string; C0
Data_086_4797:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well done.", $F1
    db "So it shall be.", $FA, $F7
    db $EF, $EE, "You have bettered", $EF, $EE, "us in power.", $FA, $F7
    db $EF, $EE, "The Tower's peak", $EF, $EE, "is next.", $FA, $F7
    db $EF, $EE, "Monsters that use", $EF, $EE, "extreme heat stand", $FA, $F7
    db $EF, $EE, "alert for your", $EF, $EE, "arrival.", $F7
    db $F0

Message_0C_14:: ; heuristic: string; C0
Data_086_483B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well.", $F1
    db "How impressive.", $FA, $F7
    db $EF, $EE, "I must commend you", $EF, $EE, "for reaching me.", $FA, $F7
    db $EF, $EE, "Well.", $EF, $EE, "Shall we begin?", $F7
    db $F0

Message_0C_15:: ; heuristic: string; C0
Data_086_4897:: ; address name
    db $F0

Message_0C_16:: ; heuristic: string; C0
Data_086_4898:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well.", $F1
    db "How impressive.", $FA, $F7
    db $EF, $EE, "Conquering the", $EF, $EE, "Power Tower.", $FA, $F7
    db $EF, $EE, "It was built by a", $A4, $EF, $EE, "a great being.", $FA, $F7
    db $EF, $EE, "He built other", $EF, $EE, "towers like this.", $FA, $F7
    db $EF, $EE, "Do you possess all", $EF, $EE, "that is needed to", $FA, $F7
    db $EF, $EE, "conquer them all?", $EF, $EE, "Well?", $FA, $F7
    db $EF, $EE, "Take the treasures", $EF, $EE, "behind me.", $F7
    db $F0

Message_0C_17:: ; heuristic: string; C0
Data_086_4984:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e conquered", $F1
    db "the Power Tower.", $FA, $F7
    db $EF, $EE, "I hope you become", $EF, $EE, "a powerful master.", $F7
    db $F0

Message_0C_18:: ; heuristic: string; C0
Data_086_49D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "Baffle Tower.", $FA, $F7
    db $EF, $EE, "Are you the new", $EF, $EE, "challenger?", $FA, $F7
    db $EF, $EE, "If you win, you'll", $EF, $EE, "earn many useful", $FA, $F7
    db $EF, $EE, "accessories for", $EF, $EE, "your monsters.", $FA, $F7
    db $EF, $EE, "Could you get them", $EF, $EE, "all?", $F7
    db $F0

Message_0C_19:: ; heuristic: string; C0
Data_086_4A76:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you win,", $F1
    db "you'll earn many", $FA, $F7
    db $EF, $EE, "useful accessories", $EF, $EE, "for your monsters.", $FA, $F7
    db $EF, $EE, "Could you get them", $EF, $EE, "all?", $F7
    db $F0

Message_0C_1A:: ; heuristic: string; C0
Data_086_4ADC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " In this Tower,", $F1
    db "your opponents", $FA, $F7
    db $EF, $EE, "come at you with", $EF, $EE, "support skills", $FA, $F7
    db $EF, $EE, "rather than all-", $EF, $EE, "out attacks.", $FA, $F7
    db $EF, $EE, "My party was put", $EF, $EE, "to sleep, made to", $FA, $F7
    db $EF, $EE, "dance", $A4, " All sorts", $EF, $EE, "of weird things.", $FA, $F7
    db $EF, $EE, "It was a rotten", $EF, $EE, "time, I swear!", $F7
    db $F0

Message_0C_1B:: ; heuristic: string; C0
Data_086_4BB4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's not that", $F1
    db "easy to win here", $FA, $F7
    db $EF, $EE, "by playing it fair", $EF, $EE, "and honorably.", $FA, $F7
    db $EF, $EE, "You have to use", $EF, $EE, "your noggin to mix", $FA, $F7
    db $EF, $EE, "and match skills", $EF, $EE, "for best effect.", $F7
    db $F0

Message_0C_1C:: ; heuristic: string; C0
Data_086_4C49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "second floor-", $FA, $F7
    db $EF, $EE, "the Shackle", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "We'll disable your", $EF, $EE, "skills!", $F7
    db $F0

Message_0C_1D:: ; heuristic: string; C0
Data_086_4C9E:: ; address name
    db $F0

Message_0C_1E:: ; heuristic: string; C0
Data_086_4C9F:: ; address name
    db $F0

Message_0C_1F:: ; heuristic: string; C0
Data_086_4CA0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Well played.", $F1
    db "I can't complain.", $FA, $F7
    db $EF, $EE, "Fine. Take the", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "The Confusion", $EF, $EE, "Chamber is next.", $FA, $F7
    db $EF, $EE, "Monsters that", $EF, $EE, "disable control", $FA, $F7
    db $EF, $EE, "will stand in your", $EF, $EE, "way.", $F7
    db $F0

Message_0C_20:: ; heuristic: string; C0
Data_086_4D41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "third floor-", $FA, $F7
    db $EF, $EE, "the Confusion", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "Let us gift you", $EF, $EE, "with a time of", $FA, $F7
    db $EF, $EE, "dreaming", $A4, $EF, $EE, $F7
    db $F0

Message_0C_21:: ; heuristic: string; C0
Data_086_4DAB:: ; address name
    db $F0

Message_0C_22:: ; heuristic: string; C0
Data_086_4DAC:: ; address name
    db $F0

Message_0C_23:: ; heuristic: string; C0
Data_086_4DAD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Bravo. Take the", $F1
    db "treasures.", $FA, $F7
    db $EF, $EE, "Upstairs is the", $EF, $EE, "Fatigue Chamber.", $FA, $F7
    db $EF, $EE, "I understand it is", $EF, $EE, "very tiresome.", $F7
    db $F0

Message_0C_24:: ; heuristic: string; C0
Data_086_4E17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "fourth floor-", $FA, $F7
    db $EF, $EE, "the Fatigue", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "Let us put you to", $EF, $EE, "the test!", $F7
    db $F0

Message_0C_25:: ; heuristic: string; C0
Data_086_4E6E:: ; address name
    db $F0

Message_0C_26:: ; heuristic: string; C0
Data_086_4E6F:: ; address name
    db $F0

Message_0C_27:: ; heuristic: string; C0
Data_086_4E70:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Remarkable,", $F1
    db "I must admit.", $FA, $F7
    db $EF, $EE, "You have earned", $EF, $EE, "the treasures.", $FA, $F7
    db $EF, $EE, "The Looting", $EF, $EE, "Chamber's next.", $FA, $F7
    db $EF, $EE, "Monsters that", $EF, $EE, "steal your power", $FA, $F7
    db $EF, $EE, "are what you will", $EF, $EE, "face.", $F7
    db $F0

Message_0C_28:: ; heuristic: string; C0
Data_086_4F0F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "fifth floor-", $FA, $F7
    db $EF, $EE, "the Looting", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "Could you battle", $EF, $EE, "without strength?", $F7
    db $F0

Message_0C_29:: ; heuristic: string; C0
Data_086_4F6C:: ; address name
    db $F0

Message_0C_2A:: ; heuristic: string; C0
Data_086_4F6D:: ; address name
    db $F0

Message_0C_2B:: ; heuristic: string; C0
Data_086_4F6E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're quite", $F1
    db "tough.", $FA, $F7
    db $EF, $EE, "The treasures are", $EF, $EE, "yours to take.", $FA, $F7
    db $EF, $EE, "The Tower's peak", $EF, $EE, "is next.", $FA, $F7
    db $EF, $EE, "Monsters that use", $EF, $EE, "dangerous skills", $FA, $F7
    db $EF, $EE, "are waiting for", $EF, $EE, "the worthy.", $F7
    db $F0

Message_0C_2C:: ; heuristic: string; C0
Data_086_500E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Ah, you have", $F1
    db "impressed me.", $FA, $F7
    db $EF, $EE, "It's rare to see", $EF, $EE, "anyone here.", $FA, $F7
    db $EF, $EE, "Let the final", $EF, $EE, "battle begin", $A4, $F7
    db $F0

Message_0C_2D:: ; heuristic: string; C0
Data_086_506E:: ; address name
    db $F0

Message_0C_2E:: ; heuristic: string; C0
Data_086_506F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You are to be", $F1
    db "commended for", $FA, $F7
    db $EF, $EE, "conquering the", $EF, $EE, "Baffle Tower.", $FA, $F7
    db $EF, $EE, "It was built by a", $A4, $EF, $EE, "a great being.", $FA, $F7
    db $EF, $EE, "He built other", $EF, $EE, "towers like this.", $FA, $F7
    db $EF, $EE, "If you wish to be", $EF, $EE, "a true master, it", $FA, $F7
    db $EF, $EE, "is pointless to", $EF, $EE, "not conquer all", $FA, $F7
    db $EF, $EE, "the towers made by", $EF, $EE, "the great being.", $F7
    db $F0

Message_0C_2F:: ; heuristic: string; C0
Data_086_516F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e conquered", $F1
    db "the Baffle Tower.", $FA, $F7
    db $EF, $EE, "I hope you become", $EF, $EE, "a wise master.", $F7
    db $F0

Message_0C_30:: ; heuristic: string; C0
Data_086_51BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If you", $42, "e made", $F1
    db "it to this-the", $FA, $F7
    db $EF, $EE, "Soul Tower-it", $EF, $EE, "must mean that", $FA, $F7
    db $EF, $EE, "you", $42, "e conquered", $EF, $EE, "the two other", $FA, $F7
    db $EF, $EE, "Towers of Power", $EF, $EE, "and Baffle.", $FA, $F7
    db $EF, $EE, "But even so, this", $EF, $EE, "Tower is terribly", $FA, $F7
    db $EF, $EE, "tough. I hope", $EF, $EE, "you're ready.", $F7
    db $F0

Message_0C_31:: ; heuristic: string; C0
Data_086_5285:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This Tower is", $F1
    db "terribly tough.", $FA, $F7
    db $EF, $EE, "I hope you're", $EF, $EE, "ready.", $F7
    db $F0

Message_0C_32:: ; heuristic: string; C0
Data_086_52BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " The monsters", $F1
    db "here are awful.", $FA, $F7
    db $EF, $EE, "I'm losing my", $EF, $EE, "confidence", $A4, $FA, $F7
    db $EF, $EE, "I heard a horrible", $EF, $EE, "racket from above.", $FA, $F7
    db $EF, $EE, "It might be that", $EF, $EE, "one skill", $A4, $F7
    db $F0

Message_0C_33:: ; heuristic: string; C0
Data_086_5347:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It's brutal up", $F1
    db "ahead.", $FA, $F7
    db $EF, $EE, "I wouldn't push my", $EF, $EE, "luck.", $FA, $F7
    db $EF, $EE, "Beating the second", $EF, $EE, "floor monsters was", $FA, $F7
    db $EF, $EE, "a serious ordeal,", $EF, $EE, "believe me.", $F7
    db $F0

Message_0C_34:: ; heuristic: string; C0
Data_086_53C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "second floor.", $FA, $F7
    db $EF, $EE, "This is the Life", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "I'm not powerful,", $EF, $EE, "but I am durable!", $F7
    db $F0

Message_0C_35:: ; heuristic: string; C0
Data_086_542B:: ; address name
    db $F0

Message_0C_36:: ; heuristic: string; C0
Data_086_542C:: ; address name
    db $F0

Message_0C_37:: ; heuristic: string; C0
Data_086_542D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You're quite", $F1
    db "good at this.", $FA, $F7
    db $EF, $EE, "Sure, take the", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "Upstairs is the", $EF, $EE, "Pain Chamber.", $FA, $F7
    db $EF, $EE, "I don't like being", $EF, $EE, "hurt, so I really", $FA, $F7
    db $EF, $EE, "hate going up", $EF, $EE, "there, yikes!", $F7
    db $F0

Message_0C_38:: ; heuristic: string; C0
Data_086_54D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "third floor.", $FA, $F7
    db $EF, $EE, "It's the Pain", $EF, $EE, "Chamber.", $FA, $F7
    db $EF, $EE, "I'll tell you right", $EF, $EE, "now, it really", $FA, $F7
    db $EF, $EE, "does hurt a lot in", $EF, $EE, "here! Here goes!", $F7
    db $F0

Message_0C_39:: ; heuristic: string; C0
Data_086_5558:: ; address name
    db $F0

Message_0C_3A:: ; heuristic: string; C0
Data_086_5559:: ; address name
    db $F0

Message_0C_3B:: ; heuristic: string; C0
Data_086_555A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e shown me", $F1
    db "your worth.", $FA, $F7
    db $EF, $EE, "Go on, take the", $EF, $EE, "treasures.", $FA, $F7
    db $EF, $EE, "The Healing", $EF, $EE, "Chamber is next.", $FA, $F7
    db $EF, $EE, "Monsters skilled", $EF, $EE, "at healing are", $FA, $F7
    db $EF, $EE, "eagerly waiting", $EF, $EE, "for you.", $F7
    db $F0

Message_0C_3C:: ; heuristic: string; C0
Data_086_55FA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "fourth floor.", $FA, $F7
    db $EF, $EE, "The Healing", $EF, $EE, "Chamber it is!", $FA, $F7
    db $EF, $EE, "The first thing", $EF, $EE, "you should know", $FA, $F7
    db $EF, $EE, "is that attacking", $EF, $EE, "us is a waste.", $FA, $F7
    db $EF, $EE, "Without further", $EF, $EE, "ado, let's begin.", $F7
    db $F0

Message_0C_3D:: ; heuristic: string; C0
Data_086_56A5:: ; address name
    db $F0

Message_0C_3E:: ; heuristic: string; C0
Data_086_56A6:: ; address name
    db $F0

Message_0C_3F:: ; heuristic: string; C0
Data_086_56A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fine, we will", $F1
    db "confer all the", $FA, $F7
    db $EF, $EE, "treasures to you", $EF, $EE, "for your victory.", $FA, $F7
    db $EF, $EE, "Up next is the", $EF, $EE, "Chaos Chamber.", $FA, $F7
    db $EF, $EE, "The greatest of", $EF, $EE, "the destroyers", $FA, $F7
    db $EF, $EE, "stand guard over", $EF, $EE, "the treasures.", $F7
    db $F0

Message_0C_40:: ; heuristic: string; C0
Data_086_5758:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the", $F1
    db "fifth floor.", $FA, $F7
    db $EF, $EE, "Welcome to the", $EF, $EE, "Chaos Chamber.", $FA, $F7
    db $EF, $EE, "Have you said your", $EF, $EE, "prayers?", $FA, $F7
    db $EF, $EE, "We will come out", $EF, $EE, "at maximum power!", $F7
    db $F0

Message_0C_41:: ; heuristic: string; C0
Data_086_57DE:: ; address name
    db $F0

Message_0C_42:: ; heuristic: string; C0
Data_086_57DF:: ; address name
    db $F0

Message_0C_43:: ; heuristic: string; C0
Data_086_57E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " All right.", $F1
    db "Good enough.", $FA, $F7
    db $EF, $EE, "The treasures are", $EF, $EE, "yours to take.", $FA, $F7
    db $EF, $EE, "The Tower's peak", $EF, $EE, "is next.", $FA, $F7
    db $EF, $EE, "The great being", $EF, $EE, "awaits you.", $F7
    db $F0

Message_0C_44:: ; heuristic: string; C0
Data_086_585E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Oh? Well, well,", $F1
    db "you're the first", $FA, $F7
    db $EF, $EE, "master to visit me", $EF, $EE, "in a long time.", $FA, $F7
    db $EF, $EE, "But look at you!", $EF, $EE, "You're a child!", $FA, $F7
    db $EF, $EE, "I'm the Grand", $EF, $EE, "Master.", $FA, $F7
    db $EF, $EE, "I built this", $EF, $EE, "Tower.", $FA, $F7
    db $EF, $EE, "I", $42, "e been waiting", $EF, $EE, "for strong masters", $FA, $F7
    db $EF, $EE, "to come ever since", $EF, $EE, "then.", $FA, $F7
    db $EF, $EE, "Please, show me", $EF, $EE, "what you can do!", $F7
    db $F0

Message_0C_45:: ; heuristic: string; C0
Data_086_5968:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hello! You", $42, "e", $F1
    db "come back!", $FA, $F7
    db $EF, $EE, "Are you feeling", $EF, $EE, "lucky?", $FA, $F7
    db $EF, $EE, "Then, let's start!", $EF, $EE, "Here we go!", $F7
    db $F0

Message_0C_46:: ; heuristic: string; C0
Data_086_59C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You are good!", $F1
    db "I like you!", $FA, $F7
    db $EF, $EE, "You", $42, "e conquered", $EF, $EE, "all three Towers-", $FA, $F7
    db $EF, $EE, "Power, Baffle and", $EF, $EE, "this, Soul Tower.", $FA, $F7
    db $EF, $EE, "You're certain to", $EF, $EE, "get even better.", $FA, $F7
    db $EF, $EE, "I want you to have", $EF, $EE, "some gifts!", $F7
    db $F0

Message_0C_47:: ; heuristic: string; C0
Data_086_5A76:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e conquered", $F1
    db "the Soul Tower.", $FA, $F7
    db $EF, $EE, "I hope you'll keep", $EF, $EE, "working towards", $FA, $F7
    db $EF, $EE, "becoming the best", $EF, $EE, "master ever.", $F7
    db $F0

Message_0C_48:: ; heuristic: string; C0
Data_086_5AE3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "The treasure chest", $EF, $EE, "was a Mimic!", $F7
    db $F0

Message_0C_49:: ; heuristic: string; C0
Data_086_5B27:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 checked the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "It was a Mimic!", $EF, $EE, "It began to talk.", $F7
    db $F0

Message_0C_4A:: ; heuristic: string; C0
Data_086_5B6D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Lightning when", $F1
    db "wet is dangerous!", $F7
    db $F0

Message_0C_4B:: ; heuristic: string; C0
Data_086_5B92:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " When it's cold,", $F1
    db "fire's the answer!", $F7
    db $F0

Message_0C_4C:: ; heuristic: string; C0
Data_086_5BB7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Electric jolts", $F1
    db "are good at times.", $F7
    db $F0

Message_0C_4D:: ; heuristic: string; C0
Data_086_5BDD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hot! Hot!", $F1
    db "Burning up!", $F7
    db $F0

Message_0C_4E:: ; heuristic: string; C0
Data_086_5BF7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What to do if we", $F1
    db "are all in danger", $A4, $F7
    db $F0

Message_0C_4F:: ; heuristic: string; C0
Data_086_5C1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Sweets are good", $F1
    db "cheap energy!", $F7
    db $F0

Message_0C_50:: ; heuristic: string; C0
Data_086_5C41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Overconfidence", $F1
    db "is a trap.", $F7
    db $F0

Message_0C_51:: ; heuristic: string; C0
Data_086_5C5F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'm scared", $A4, $F1
    db "Terrified, even", $A4, $F7
    db $F0

Message_0C_52:: ; heuristic: string; C0
Data_086_5C7F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " If it hurts,", $F1
    db "heal it.", $F7
    db $F0

Message_0C_53:: ; heuristic: string; C0
Data_086_5C99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Good health", $F1
    db "above all.", $F7
    db $F0

Message_0C_54:: ; heuristic: string; C0
Data_086_5CB4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Pow! Ka-pow!", $F1
    db "Big trouble!", $F7
    db $F0

Message_0C_55:: ; heuristic: string; C0
Data_086_5CD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Young master", $A4, $F1
    db "The final test", $A4, $F7
    db $F0

Message_0C_56:: ; heuristic: string; C0
Data_086_5CF4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Really! Wow!", $F1
    db "You're the first", $FA, $F7
    db $EF, $EE, "human that I", $42, "e", $EF, $EE, "ever met!", $FA, $F7
    db $EF, $EE, "Wow, a human is", $EF, $EE, "pretty cute!", $FA, $F7
    db $EF, $EE, "Don't you think so,", $EF, $EE, "big brother?", $F7
    db $F0

Message_0C_57:: ; heuristic: string; C0
Data_086_5D77:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, don't lie!", $F1
    db "You don't look", $FA, $F7
    db $EF, $EE, "like an elf or a", $EF, $EE, "monster at all!", $FA, $F7
    db $EF, $EE, "You really are a", $EF, $EE, "human, aren't you?", $FF, $F0

Message_0C_58:: ; heuristic: string; C0
Data_086_5DE3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What is it, you", $F1
    db "little brat?", $FA, $F7
    db $EF, $EE, "Did you come to", $EF, $EE, "get creamed too?", $FA, $F7
    db $EF, $EE, "That town is full", $EF, $EE, "of the idle rich.", $FA, $F7
    db $EF, $EE, "Their treasures", $EF, $EE, "are there for the", $FA, $F7
    db $EF, $EE, "taking, so I took", $EF, $EE, "them.", $FA, $F7
    db $EF, $EE, "I was going to", $EF, $EE, "sell it off and", $FA, $F7
    db $EF, $EE, "make some serious", $EF, $EE, "money.", $FA, $F7
    db $EF, $EE, "But a brat like", $EF, $EE, "you comes along!", $FA, $F7
    db $EF, $EE, "I can still make", $EF, $EE, "this work", $A4, $FA, $F7
    db $EF, $EE, "If I don't let you", $EF, $EE, "go alive!", $F7
    db $F0

Message_0C_DF:: ; heuristic: string; C0
Data_086_5F38:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " What is it, you", $F1
    db "little brat?", $FA, $F7
    db $EF, $EE, "Back to get", $EF, $EE, "creamed again?", $FA, $F7
    db $EF, $EE, "I won't let you go", $EF, $EE, "alive this time!", $F7
    db $F0

Message_0C_E0:: ; heuristic: string; C0
Data_086_5F9F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " But", $A4, " No! I lost", $F1
    db "to this brat?", $F7
    db $F0

Message_0C_E1:: ; heuristic: string; C0
Data_086_5FC1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " You are", $F1
    db "really special.", $FA, $F7
    db $EF, $EE, "I couldn't do a", $EF, $EE, "thing against him", $A4, $FA, $F7
    db $EF, $EE, "I'll have to train", $EF, $EE, "that much harder", $A4, $FA, $F7
    db $EF, $EE, "I'll be no match", $EF, $EE, "for my kid brother", $FA, $F7
    db $EF, $EE, "if  I don't apply", $EF, $EE, "myself better.", $FA, $F7
    db $EF, $EE, "I'll wait for you", $EF, $EE, "in town!", $F7
    db $F0

Message_0C_E2:: ; heuristic: string; C0
Data_086_609B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome to the", $F1
    db "town of Miagen.", $FA, $F7
    db $EF, $EE, "We're proud of our", $EF, $EE, "affluence here!", $F7
    db $F0

Message_0C_E3:: ; heuristic: string; C0
Data_086_60E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " So you defeated", $F1
    db "the evildoer?", $F7
    db $F0

Message_0C_E4:: ; heuristic: string; C0
Data_086_6106:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Wow, you have", $F1
    db "monsters! Wicked!", $FA, $F7
    db $EF, $EE, "They beat the bad", $EF, $EE, "guy, didn't they?", $F7
    db $F0

Message_0C_E5:: ; heuristic: string; C0
Data_086_6151:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Your monsters", $F1
    db "are good, it's", $FA, $F7
    db $EF, $EE, "plain to see.", $EF, $EE, "I like them!", $F7
    db $F0

Message_0C_E6:: ; heuristic: string; C0
Data_086_6190:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " So there are", $F1
    db "evil masters", $A4, $FA, $F7
    db $EF, $EE, "Oh, but you're not", $EF, $EE, "one of those.", $F7
    db $F0

Message_0C_E7:: ; heuristic: string; C0
Data_086_61D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Controlling", $F1
    db "monsters is no", $FA, $F7
    db $EF, $EE, "easy feat, is it?", $EF, $EE, "I'm so in awe!", $FA, $F7
    db $EF, $EE, "You", $42, "e brought", $EF, $EE, "peace to us!", $F7
    db $F0

Message_0C_E8:: ; heuristic: string; C0
Data_086_6235:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I thank you in", $F1
    db "all sincerity!", $F7
    db $F0

Message_0C_E9:: ; heuristic: string; C0
Data_086_6257:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The atmosphere", $F1
    db "has cheered up,", $FA, $F7
    db $EF, $EE, "thanks to your", $EF, $EE, "crime busting.", $FA, $F7
    db $EF, $EE, "It gives me hope", $EF, $EE, "to live another", $FA, $F7
    db $EF, $EE, "one hundred years!", $EF, $EE, $F7
    db $F0

Message_0C_EA:: ; heuristic: string; C0
Data_086_62D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I long to have a", $F1
    db "family of my own.", $FA, $F7
    db $EF, $EE, "I wish I was", $EF, $EE, "married", $A4, $F7
    db $F0

Message_0C_EB:: ; heuristic: string; C0
Data_086_631A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Old people say", $F1
    db "that a cheerful", $FA, $F7
    db $EF, $EE, "town is a good", $EF, $EE, "town. I agree!", $F7
    db $F0

Message_0C_EC:: ; heuristic: string; C0
Data_086_635F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Monsters can be", $F1
    db "good or evil on", $FA, $F7
    db $EF, $EE, "the whims of their", $EF, $EE, "masters, I guess.", $F7
    db $F0

Message_0C_ED:: ; heuristic: string; C0
Data_086_63AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The thief was", $F1
    db "selling what he", $FA, $F7
    db $EF, $EE, "stole from us for", $EF, $EE, "a lot of gold.", $FA, $F7
    db $EF, $EE, "But why would he", $EF, $EE, "steal my clothes?", $FA, $F7
    db $EF, $EE, "Were they valuable", $EF, $EE, "because they were", $FA, $F7
    db $EF, $EE, "mine? I'm not sure", $EF, $EE, "I want to know", $A4, $F7
    db $F0

Message_0C_EE:: ; heuristic: string; C0
Data_086_6469:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " It sure was a", $F1
    db "thrilling time", $FA, $F7
    db $EF, $EE, "when the thief was", $EF, $EE, "roving around.", $F7
    db $F0

Message_0C_EF:: ; heuristic: string; C0
Data_086_64B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " I asked", $F1
    db "for your support", $FA, $F7
    db $EF, $EE, "to capture that", $EF, $EE, "thief", $A4, $FA, $F7
    db $EF, $EE, "But you ended up", $EF, $EE, "doing it all.", $FA, $F7
    db $EF, $EE, "I'm sorry, and", $EF, $EE, "thank you.", $FA, $F7
    db $EF, $EE, "Oh? You're from", $EF, $EE, "GreatLog?", $FA, $F7
    db $EF, $EE, "And you", $42, "e won", $EF, $EE, "tournaments.", $FA, $F7
    db $EF, $EE, "Well, no wonder", $EF, $EE, "you're strong.", $FA, $F7
    db $EF, $EE, "How is Kameha,", $EF, $EE, "by the way?", $F7
    db $F0

Message_0C_F0:: ; heuristic: string; C0
Data_086_65AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " How do I", $F1
    db "know about him?", $FA, $F7
    db $EF, $EE, "Well", $A4, $EF, $EE, "That's a secret!", $F7
    db $F0

Message_0C_F1:: ; heuristic: string; C0
Data_086_65EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " You", $42, "e", $F1
    db "inspired me to try", $FA, $F7
    db $EF, $EE, "harder in my", $EF, $EE, "training.", $FA, $F7
    db $EF, $EE, "I hope we can", $EF, $EE, "battle some day!", $F7
    db $F0

Message_0C_F2:: ; heuristic: string; C0
Data_086_664C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That merchant,", $F1
    db "he was a thief.", $FA, $F7
    db $EF, $EE, "In one way he has", $EF, $EE, "my admiration.", $FA, $F7
    db $EF, $EE, "His bad deeds", $EF, $EE, "escaped my notice!", $F7
    db $F0

Message_0C_F3:: ; heuristic: string; C0
Data_086_66B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " People say you", $F1
    db "can't judge people", $FA, $F7
    db $EF, $EE, "by appearances", $A4, $EF, $EE, "But that thieving", $FA, $F7
    db $EF, $EE, "merchant", $A4, " He had", $EF, $EE, "the bad guy look!", $F7
    db $F0

Message_0C_F4:: ; heuristic: string; C0
Data_086_672B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That greedy", $F1
    db "hound of a dealer", $FA, $F7
    db $EF, $EE, "was behind those", $EF, $EE, "monsters", $A4, $FA, $F7
    db $EF, $EE, "But to be caught", $EF, $EE, "out by selling", $FA, $F7
    db $EF, $EE, "what he stole", $A4, $EF, $EE, "He's not what I", $FA, $F7
    db $EF, $EE, "call a criminal", $EF, $EE, "mastermind.", $F7
    db $F0

Message_0C_F5:: ; heuristic: string; C0
Data_086_67D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " I knew", $F1
    db "you", $44, " come back!", $FA, $F7
    db $EF, $EE, "I", $42, "e trained hard", $EF, $EE, "since we last met.", $FA, $F7
    db $EF, $EE, "Would you like to", $EF, $EE, "spar with me?", $FF, $F0

Message_0C_F6:: ; heuristic: string; C0
Data_086_6840:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " Great!", $F1
    db "No holding back!", $F7
    db $F0

Message_0C_F7:: ; heuristic: string; C0
Data_086_6863:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " Oh", $A4, $F1
    db "I'm disappointed", $A4, $FA, $F7
    db $EF, $EE, "Come again if you", $EF, $EE, "want to spar.", $F7
    db $F0

Message_0C_F8:: ; heuristic: string; C0
Data_086_68A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " Want to", $F1
    db "spar with me?", $FF, $F0

Message_0C_F9:: ; heuristic: string; C0
Data_086_68C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "Milayou", $A3, " I lost", $A4, $F1
    db "But, good battle!", $FA, $F7
    db $EF, $EE, "Oh, I need to tell", $EF, $EE, "you this.", $FA, $F7
    db $EF, $EE, "If you meet a boy", $EF, $EE, "named Terry,", $FA, $F7
    db $EF, $EE, "please crush him", $EF, $EE, "in battle.", $FA, $F7
    db $EF, $EE, "He's not anyone", $EF, $EE, "special, so you", $FA, $F7
    db $EF, $EE, "can just destroy", $EF, $EE, "him. Promise!", $FA, $F7
    db $EF, $EE, "I really should", $EF, $EE, "get going myself.", $FA, $F7
    db $EF, $EE, "I hope we can meet", $EF, $EE, "again somewhere,", $FA, $F7
    db $EF, $EE, "sometime. OK!", $EF, $EE, "Bye-bye!", $F7
    db $F0

Message_0C_FA:: ; heuristic: string; C0
Data_086_6A00:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "A tantalizing", $EF, $EE, "aroma wafted out", $A4, $F7
    db $F0

Message_0C_FB:: ; heuristic: string; C0
Data_086_6A3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 tried to", $F1
    db "open the chest.", $FA, $F7
    db $EF, $EE, "But it was locked.", $EF, $EE, $F7
    db $F0

Message_0C_FC:: ; heuristic: string; C0
Data_086_6A73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the vase.", $FA, $F7
    db $EF, $EE, "Cold water lapped", $EF, $EE, "and rippled.", $F7
    db $F0

Message_0C_FD:: ; heuristic: string; C0
Data_086_6AB0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 peered into", $F1
    db "the oven.", $FA, $F7
    db $EF, $EE, "Meat sizzled on a", $EF, $EE, "skewer.", $F7
    db $F0

Message_0C_FE:: ; heuristic: string; C0
Data_086_6AE8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 opened the", $F1
    db "treasure chest.", $FA, $F7
    db $EF, $EE, "It was crammed", $EF, $EE, "with treasures.", $FA, $F7
    db $EF, $EE, "It appears to be", $EF, $EE, "loot taken from", $FA, $F7
    db $EF, $EE, "the town.", $EF, $EE, $F7
    db $F0

Message_0C_FF:: ; heuristic: string; C0
Data_086_6B5E:: ; address name
    db $F0
    ds $14A1, $00
