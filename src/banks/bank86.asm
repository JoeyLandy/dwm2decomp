SECTION "Bank 86", ROMX[$4000], BANK[$86]
    db $86

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank86::
    ld de, StringCategories_86_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9, $cd, $01, $40, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_86_4016::
    dw StringList_86_4018 ; id 0

; category list of StringCategories_86_4016; one pointer per wStringIndex (E-0217)
; record: string
StringList_86_4018::
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

Message_0C_00::
    db $ea, "*: This is the", $f1
    db "Power Tower.", $fa, $f7
    db $ef, $ee, "Are you the new", $ef, $ee, "challenger?", $fa, $f7
    db $ef, $ee, "If you win, you'll", $ef, $ee, "earn many useful", $fa, $f7
    db $ef, $ee, "accessories for", $ef, $ee, "your monsters.", $fa, $f7
    db $ef, $ee, "Could you get them", $ef, $ee, "all?", $f7
    db $f0

Message_0C_01::
    db $ea, "*: If you win,", $f1
    db "you'll earn many", $fa, $f7
    db $ef, $ee, "useful accessories", $ef, $ee, "for your monsters.", $fa, $f7
    db $ef, $ee, "Could you get them", $ef, $ee, "all?", $f7
    db $f0

Message_0C_02::
    db $ea, "*: Only a handful", $f1
    db "of masters have", $fa, $f7
    db $ef, $ee, "made it to the top", $ef, $ee, "of the Tower.", $fa, $f7
    db $ef, $ee, "I tried, but the", $ef, $ee, "best I could do", $fa, $f7
    db $ef, $ee, "was reach the", $ef, $ee, "fourth floor.", $f7
    db $f0

Message_0C_03::
    db $ea, "*: The Tower's many", $f1
    db "treasures are", $fa, $f7
    db $ef, $ee, "heavily guarded by", $ef, $ee, "monsters, slurp.", $fa, $f7
    db $ef, $ee, "They'll attack you", $ef, $ee, "all out, slurp.", $f7
    db $f0

Message_0C_04::
    db $ea, "*: This is the", $f1
    db "second floor-", $fa, $f7
    db $ef, $ee, "the Whirlwind", $ef, $ee, "Chamber.", $fa, $f7
    db $ef, $ee, "Can you withstand", $ef, $ee, "our wind power?", $f7
    db $f0

Message_0C_05::
    db $f0

Message_0C_06::
    db $f0

Message_0C_07::
    db $ea, "*: Not bad, not bad", $f1
    db "at all.", $fa, $f7
    db $ef, $ee, "Fine. Take the", $ef, $ee, "treasures.", $fa, $f7
    db $ef, $ee, "The Clearwater", $ef, $ee, "Chamber is next.", $fa, $f7
    db $ef, $ee, "Monsters that use", $ef, $ee, "water skills will", $fa, $f7
    db $ef, $ee, "be waiting for", $ef, $ee, "you.", $f7
    db $f0

Message_0C_08::
    db $ea, "*: This is the", $f1
    db "third floor-", $fa, $f7
    db $ef, $ee, "the Clearwater", $ef, $ee, "Chamber.", $fa, $f7
    db $ef, $ee, "If you belittle", $ef, $ee, "hydropower, you", $fa, $f7
    db $ef, $ee, "will suffer for", $ef, $ee, "your ignorance!", $f7
    db $f0

Message_0C_09::
    db $f0

Message_0C_0A::
    db $f0

Message_0C_0B::
    db $ea, "*: You're quite", $f1
    db "good.", $fa, $f7
    db $ef, $ee, "The treasures are", $ef, $ee, "yours to take.", $fa, $f7
    db $ef, $ee, "Upstairs is the", $ef, $ee, "Blizzard Chamber.", $fa, $f7
    db $ef, $ee, "It's very cold, so", $ef, $ee, "be careful.", $f7
    db $f0

Message_0C_0C::
    db $ea, "*: This is the", $f1
    db "fourth floor-", $fa, $f7
    db $ef, $ee, "the Blizzard", $ef, $ee, "Chamber.", $fa, $f7
    db $ef, $ee, "I hope you're", $ef, $ee, "bundled up warm.", $fa, $f7
    db $ef, $ee, "We'll freeze you", $ef, $ee, "solid!", $f7
    db $f0

Message_0C_0D::
    db $f0

Message_0C_0E::
    db $f0

Message_0C_0F::
    db $ea, "*: Wow, aren't you", $f1
    db "good.", $fa, $f7
    db $ef, $ee, "Go ahead and take", $ef, $ee, "the treasures.", $fa, $f7
    db $ef, $ee, "The Thunder", $ef, $ee, "Chamber's next.", $fa, $f7
    db $ef, $ee, "You can always", $ef, $ee, "hear the sound of", $fa, $f7
    db $ef, $ee, "crashing thunder.", $ef, $ee, "It's annoying!", $f7
    db $f0

Message_0C_10::
    db $ea, "*: This is the", $f1
    db "fifth floor-", $fa, $f7
    db $ef, $ee, "the Thunder", $ef, $ee, "Chamber.", $fa, $f7
    db $ef, $ee, "Prepare for", $ef, $ee, "obliteration!", $f7
    db $f0

Message_0C_11::
    db $f0

Message_0C_12::
    db $f0

Message_0C_13::
    db $ea, "*: Well done.", $f1
    db "So it shall be.", $fa, $f7
    db $ef, $ee, "You have bettered", $ef, $ee, "us in power.", $fa, $f7
    db $ef, $ee, "The Tower's peak", $ef, $ee, "is next.", $fa, $f7
    db $ef, $ee, "Monsters that use", $ef, $ee, "extreme heat stand", $fa, $f7
    db $ef, $ee, "alert for your", $ef, $ee, "arrival.", $f7
    db $f0

Message_0C_14::
    db $ea, "*: Well.", $f1
    db "How impressive.", $fa, $f7
    db $ef, $ee, "I must commend you", $ef, $ee, "for reaching me.", $fa, $f7
    db $ef, $ee, "Well.", $ef, $ee, "Shall we begin?", $f7
    db $f0

Message_0C_15::
    db $f0

Message_0C_16::
    db $ea, "*: Well.", $f1
    db "How impressive.", $fa, $f7
    db $ef, $ee, "Conquering the", $ef, $ee, "Power Tower.", $fa, $f7
    db $ef, $ee, "It was built by a", $a4, $ef, $ee, "a great being.", $fa, $f7
    db $ef, $ee, "He built other", $ef, $ee, "towers like this.", $fa, $f7
    db $ef, $ee, "Do you possess all", $ef, $ee, "that is needed to", $fa, $f7
    db $ef, $ee, "conquer them all?", $ef, $ee, "Well?", $fa, $f7
    db $ef, $ee, "Take the treasures", $ef, $ee, "behind me.", $f7
    db $f0

Message_0C_17::
    db $ea, "*: You've conquered", $f1
    db "the Power Tower.", $fa, $f7
    db $ef, $ee, "I hope you become", $ef, $ee, "a powerful master.", $f7
    db $f0

Message_0C_18::
    db $ea, "*: This is the", $f1
    db "Baffle Tower.", $fa, $f7
    db $ef, $ee, "Are you the new", $ef, $ee, "challenger?", $fa, $f7
    db $ef, $ee, "If you win, you'll", $ef, $ee, "earn many useful", $fa, $f7
    db $ef, $ee, "accessories for", $ef, $ee, "your monsters.", $fa, $f7
    db $ef, $ee, "Could you get them", $ef, $ee, "all?", $f7
    db $f0

Message_0C_19::
    db $ea, "*: If you win,", $f1
    db "you'll earn many", $fa, $f7
    db $ef, $ee, "useful accessories", $ef, $ee, "for your monsters.", $fa, $f7
    db $ef, $ee, "Could you get them", $ef, $ee, "all?", $f7
    db $f0

Message_0C_1A::
    db $eb, "*: In this Tower,", $f1
    db "your opponents", $fa, $f7
    db $ef, $ee, "come at you with", $ef, $ee, "support skills", $fa, $f7
    db $ef, $ee, "rather than all-", $ef, $ee, "out attacks.", $fa, $f7
    db $ef, $ee, "My party was put", $ef, $ee, "to sleep, made to", $fa, $f7
    db $ef, $ee, "dance", $a4, " All sorts", $ef, $ee, "of weird things.", $fa, $f7
    db $ef, $ee, "It was a rotten", $ef, $ee, "time, I swear!", $f7
    db $f0

Message_0C_1B::
    db $ea, "*: It's not that", $f1
    db "easy to win here", $fa, $f7
    db $ef, $ee, "by playing it fair", $ef, $ee, "and honorably.", $fa, $f7
    db $ef, $ee, "You have to use", $ef, $ee, "your noggin to mix", $fa, $f7
    db $ef, $ee, "and match skills", $ef, $ee, "for best effect.", $f7
    db $f0

Message_0C_1C::
    db $ea, "*: This is the", $f1
    db "second floor-", $fa, $f7
    db $ef, $ee, "the Shackle", $ef, $ee, "Chamber.", $fa, $f7
    db $ef, $ee, "We'll disable your", $ef, $ee, "skills!", $f7
    db $f0

Message_0C_1D::
    db $f0

Message_0C_1E::
    db $f0

Message_0C_1F::
    db $ea, "*: Well played.", $f1
    db "I can't complain.", $fa, $f7
    db $ef, $ee, "Fine. Take the", $ef, $ee, "treasures.", $fa, $f7
    db $ef, $ee, "The Confusion", $ef, $ee, "Chamber is next.", $fa, $f7
    db $ef, $ee, "Monsters that", $ef, $ee, "disable control", $fa, $f7
    db $ef, $ee, "will stand in your", $ef, $ee, "way.", $f7
    db $f0

Message_0C_20::
    db $ea, "*: This is the", $f1
    db "third floor-", $fa, $f7
    db $ef, $ee, "the Confusion", $ef, $ee, "Chamber.", $fa, $f7
    db $ef, $ee, "Let us gift you", $ef, $ee, "with a time of", $fa, $f7
    db $ef, $ee, "dreaming", $a4, $ef, $ee, $f7
    db $f0

Message_0C_21::
    db $f0

Message_0C_22::
    db $f0

Message_0C_23::
    db $ea, "*: Bravo. Take the", $f1
    db "treasures.", $fa, $f7
    db $ef, $ee, "Upstairs is the", $ef, $ee, "Fatigue Chamber.", $fa, $f7
    db $ef, $ee, "I understand it is", $ef, $ee, "very tiresome.", $f7
    db $f0

Message_0C_24::
    db $ea, "*: This is the", $f1
    db "fourth floor-", $fa, $f7
    db $ef, $ee, "the Fatigue", $ef, $ee, "Chamber.", $fa, $f7
    db $ef, $ee, "Let us put you to", $ef, $ee, "the test!", $f7
    db $f0

Message_0C_25::
    db $f0

Message_0C_26::
    db $f0

Message_0C_27::
    db $ea, "*: Remarkable,", $f1
    db "I must admit.", $fa, $f7
    db $ef, $ee, "You have earned", $ef, $ee, "the treasures.", $fa, $f7
    db $ef, $ee, "The Looting", $ef, $ee, "Chamber's next.", $fa, $f7
    db $ef, $ee, "Monsters that", $ef, $ee, "steal your power", $fa, $f7
    db $ef, $ee, "are what you will", $ef, $ee, "face.", $f7
    db $f0

Message_0C_28::
    db $ea, "*: This is the", $f1
    db "fifth floor-", $fa, $f7
    db $ef, $ee, "the Looting", $ef, $ee, "Chamber.", $fa, $f7
    db $ef, $ee, "Could you battle", $ef, $ee, "without strength?", $f7
    db $f0

Message_0C_29::
    db $f0

Message_0C_2A::
    db $f0

Message_0C_2B::
    db $ea, "*: You're quite", $f1
    db "tough.", $fa, $f7
    db $ef, $ee, "The treasures are", $ef, $ee, "yours to take.", $fa, $f7
    db $ef, $ee, "The Tower's peak", $ef, $ee, "is next.", $fa, $f7
    db $ef, $ee, "Monsters that use", $ef, $ee, "dangerous skills", $fa, $f7
    db $ef, $ee, "are waiting for", $ef, $ee, "the worthy.", $f7
    db $f0

Message_0C_2C::
    db $ea, "*: Ah, you have", $f1
    db "impressed me.", $fa, $f7
    db $ef, $ee, "It's rare to see", $ef, $ee, "anyone here.", $fa, $f7
    db $ef, $ee, "Let the final", $ef, $ee, "battle begin", $a4, $f7
    db $f0

Message_0C_2D::
    db $f0

Message_0C_2E::
    db $ea, "*: You are to be", $f1
    db "commended for", $fa, $f7
    db $ef, $ee, "conquering the", $ef, $ee, "Baffle Tower.", $fa, $f7
    db $ef, $ee, "It was built by a", $a4, $ef, $ee, "a great being.", $fa, $f7
    db $ef, $ee, "He built other", $ef, $ee, "towers like this.", $fa, $f7
    db $ef, $ee, "If you wish to be", $ef, $ee, "a true master, it", $fa, $f7
    db $ef, $ee, "is pointless to", $ef, $ee, "not conquer all", $fa, $f7
    db $ef, $ee, "the towers made by", $ef, $ee, "the great being.", $f7
    db $f0

Message_0C_2F::
    db $ea, "*: You've conquered", $f1
    db "the Baffle Tower.", $fa, $f7
    db $ef, $ee, "I hope you become", $ef, $ee, "a wise master.", $f7
    db $f0

Message_0C_30::
    db $ea, "*: If you've made", $f1
    db "it to this-the", $fa, $f7
    db $ef, $ee, "Soul Tower-it", $ef, $ee, "must mean that", $fa, $f7
    db $ef, $ee, "you've conquered", $ef, $ee, "the two other", $fa, $f7
    db $ef, $ee, "Towers of Power", $ef, $ee, "and Baffle.", $fa, $f7
    db $ef, $ee, "But even so, this", $ef, $ee, "Tower is terribly", $fa, $f7
    db $ef, $ee, "tough. I hope", $ef, $ee, "you're ready.", $f7
    db $f0

Message_0C_31::
    db $ea, "*: This Tower is", $f1
    db "terribly tough.", $fa, $f7
    db $ef, $ee, "I hope you're", $ef, $ee, "ready.", $f7
    db $f0

Message_0C_32::
    db $ea, "*: The monsters", $f1
    db "here are awful.", $fa, $f7
    db $ef, $ee, "I'm losing my", $ef, $ee, "confidence", $a4, $fa, $f7
    db $ef, $ee, "I heard a horrible", $ef, $ee, "racket from above.", $fa, $f7
    db $ef, $ee, "It might be that", $ef, $ee, "one skill", $a4, $f7
    db $f0

Message_0C_33::
    db $ea, "*: It's brutal up", $f1
    db "ahead.", $fa, $f7
    db $ef, $ee, "I wouldn't push my", $ef, $ee, "luck.", $fa, $f7
    db $ef, $ee, "Beating the second", $ef, $ee, "floor monsters was", $fa, $f7
    db $ef, $ee, "a serious ordeal,", $ef, $ee, "believe me.", $f7
    db $f0

Message_0C_34::
    db $ea, "*: This is the", $f1
    db "second floor.", $fa, $f7
    db $ef, $ee, "This is the Life", $ef, $ee, "Chamber.", $fa, $f7
    db $ef, $ee, "I'm not powerful,", $ef, $ee, "but I am durable!", $f7
    db $f0

Message_0C_35::
    db $f0

Message_0C_36::
    db $f0

Message_0C_37::
    db $ea, "*: You're quite", $f1
    db "good at this.", $fa, $f7
    db $ef, $ee, "Sure, take the", $ef, $ee, "treasures.", $fa, $f7
    db $ef, $ee, "Upstairs is the", $ef, $ee, "Pain Chamber.", $fa, $f7
    db $ef, $ee, "I don't like being", $ef, $ee, "hurt, so I really", $fa, $f7
    db $ef, $ee, "hate going up", $ef, $ee, "there, yikes!", $f7
    db $f0

Message_0C_38::
    db $ea, "*: This is the", $f1
    db "third floor.", $fa, $f7
    db $ef, $ee, "It's the Pain", $ef, $ee, "Chamber.", $fa, $f7
    db $ef, $ee, "I'll tell you right", $ef, $ee, "now, it really", $fa, $f7
    db $ef, $ee, "does hurt a lot in", $ef, $ee, "here! Here goes!", $f7
    db $f0

Message_0C_39::
    db $f0

Message_0C_3A::
    db $f0

Message_0C_3B::
    db $ea, "*: You've shown me", $f1
    db "your worth.", $fa, $f7
    db $ef, $ee, "Go on, take the", $ef, $ee, "treasures.", $fa, $f7
    db $ef, $ee, "The Healing", $ef, $ee, "Chamber is next.", $fa, $f7
    db $ef, $ee, "Monsters skilled", $ef, $ee, "at healing are", $fa, $f7
    db $ef, $ee, "eagerly waiting", $ef, $ee, "for you.", $f7
    db $f0

Message_0C_3C::
    db $ea, "*: This is the", $f1
    db "fourth floor.", $fa, $f7
    db $ef, $ee, "The Healing", $ef, $ee, "Chamber it is!", $fa, $f7
    db $ef, $ee, "The first thing", $ef, $ee, "you should know", $fa, $f7
    db $ef, $ee, "is that attacking", $ef, $ee, "us is a waste.", $fa, $f7
    db $ef, $ee, "Without further", $ef, $ee, "ado, let's begin.", $f7
    db $f0

Message_0C_3D::
    db $f0

Message_0C_3E::
    db $f0

Message_0C_3F::
    db $ea, "*: Fine, we will", $f1
    db "confer all the", $fa, $f7
    db $ef, $ee, "treasures to you", $ef, $ee, "for your victory.", $fa, $f7
    db $ef, $ee, "Up next is the", $ef, $ee, "Chaos Chamber.", $fa, $f7
    db $ef, $ee, "The greatest of", $ef, $ee, "the destroyers", $fa, $f7
    db $ef, $ee, "stand guard over", $ef, $ee, "the treasures.", $f7
    db $f0

Message_0C_40::
    db $ea, "*: This is the", $f1
    db "fifth floor.", $fa, $f7
    db $ef, $ee, "Welcome to the", $ef, $ee, "Chaos Chamber.", $fa, $f7
    db $ef, $ee, "Have you said your", $ef, $ee, "prayers?", $fa, $f7
    db $ef, $ee, "We will come out", $ef, $ee, "at maximum power!", $f7
    db $f0

Message_0C_41::
    db $f0

Message_0C_42::
    db $f0

Message_0C_43::
    db $ea, "*: All right.", $f1
    db "Good enough.", $fa, $f7
    db $ef, $ee, "The treasures are", $ef, $ee, "yours to take.", $fa, $f7
    db $ef, $ee, "The Tower's peak", $ef, $ee, "is next.", $fa, $f7
    db $ef, $ee, "The great being", $ef, $ee, "awaits you.", $f7
    db $f0

Message_0C_44::
    db $ea, "*: Oh? Well, well,", $f1
    db "you're the first", $fa, $f7
    db $ef, $ee, "master to visit me", $ef, $ee, "in a long time.", $fa, $f7
    db $ef, $ee, "But look at you!", $ef, $ee, "You're a child!", $fa, $f7
    db $ef, $ee, "I'm the Grand", $ef, $ee, "Master.", $fa, $f7
    db $ef, $ee, "I built this", $ef, $ee, "Tower.", $fa, $f7
    db $ef, $ee, "I've been waiting", $ef, $ee, "for strong masters", $fa, $f7
    db $ef, $ee, "to come ever since", $ef, $ee, "then.", $fa, $f7
    db $ef, $ee, "Please, show me", $ef, $ee, "what you can do!", $f7
    db $f0

Message_0C_45::
    db $ea, "*: Hello! You've", $f1
    db "come back!", $fa, $f7
    db $ef, $ee, "Are you feeling", $ef, $ee, "lucky?", $fa, $f7
    db $ef, $ee, "Then, let's start!", $ef, $ee, "Here we go!", $f7
    db $f0

Message_0C_46::
    db $ea, "*: You are good!", $f1
    db "I like you!", $fa, $f7
    db $ef, $ee, "You've conquered", $ef, $ee, "all three Towers-", $fa, $f7
    db $ef, $ee, "Power, Baffle and", $ef, $ee, "this, Soul Tower.", $fa, $f7
    db $ef, $ee, "You're certain to", $ef, $ee, "get even better.", $fa, $f7
    db $ef, $ee, "I want you to have", $ef, $ee, "some gifts!", $f7
    db $f0

Message_0C_47::
    db $ea, "*: You've conquered", $f1
    db "the Soul Tower.", $fa, $f7
    db $ef, $ee, "I hope you'll keep", $ef, $ee, "working towards", $fa, $f7
    db $ef, $ee, "becoming the best", $ef, $ee, "master ever.", $f7
    db $f0

Message_0C_48::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "The treasure chest", $ef, $ee, "was a Mimic!", $f7
    db $f0

Message_0C_49::
    db $f9, "0 checked the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "It was a Mimic!", $ef, $ee, "It began to talk.", $f7
    db $f0

Message_0C_4A::
    db $ea, "*: Lightning when", $f1
    db "wet is dangerous!", $f7
    db $f0

Message_0C_4B::
    db $ea, "*: When it's cold,", $f1
    db "fire's the answer!", $f7
    db $f0

Message_0C_4C::
    db $ea, "*: Electric jolts", $f1
    db "are good at times.", $f7
    db $f0

Message_0C_4D::
    db $ea, "*: Hot! Hot!", $f1
    db "Burning up!", $f7
    db $f0

Message_0C_4E::
    db $ea, "*: What to do if we", $f1
    db "are all in danger", $a4, $f7
    db $f0

Message_0C_4F::
    db $ea, "*: Sweets are good", $f1
    db "cheap energy!", $f7
    db $f0

Message_0C_50::
    db $ea, "*: Overconfidence", $f1
    db "is a trap.", $f7
    db $f0

Message_0C_51::
    db $ea, "*: I'm scared", $a4, $f1
    db "Terrified, even", $a4, $f7
    db $f0

Message_0C_52::
    db $ea, "*: If it hurts,", $f1
    db "heal it.", $f7
    db $f0

Message_0C_53::
    db $ea, "*: Good health", $f1
    db "above all.", $f7
    db $f0

Message_0C_54::
    db $ea, "*: Pow! Ka-pow!", $f1
    db "Big trouble!", $f7
    db $f0

Message_0C_55::
    db $ea, "*: Young master", $a4, $f1
    db "The final test", $a4, $f7
    db $f0

Message_0C_56::
    db $eb, "*: Really! Wow!", $f1
    db "You're the first", $fa, $f7
    db $ef, $ee, "human that I've", $ef, $ee, "ever met!", $fa, $f7
    db $ef, $ee, "Wow, a human is", $ef, $ee, "pretty cute!", $fa, $f7
    db $ef, $ee, "Don't you think so,", $ef, $ee, "big brother?", $f7
    db $f0

Message_0C_57::
    db $eb, "*: Oh, don't lie!", $f1
    db "You don't look", $fa, $f7
    db $ef, $ee, "like an elf or a", $ef, $ee, "monster at all!", $fa, $f7
    db $ef, $ee, "You really are a", $ef, $ee, "human, aren't you?", $ff, $f0

Message_0C_58::
    db $ea, "*: What is it, you", $f1
    db "little brat?", $fa, $f7
    db $ef, $ee, "Did you come to", $ef, $ee, "get creamed too?", $fa, $f7
    db $ef, $ee, "That town is full", $ef, $ee, "of the idle rich.", $fa, $f7
    db $ef, $ee, "Their treasures", $ef, $ee, "are there for the", $fa, $f7
    db $ef, $ee, "taking, so I took", $ef, $ee, "them.", $fa, $f7
    db $ef, $ee, "I was going to", $ef, $ee, "sell it off and", $fa, $f7
    db $ef, $ee, "make some serious", $ef, $ee, "money.", $fa, $f7
    db $ef, $ee, "But a brat like", $ef, $ee, "you comes along!", $fa, $f7
    db $ef, $ee, "I can still make", $ef, $ee, "this work", $a4, $fa, $f7
    db $ef, $ee, "If I don't let you", $ef, $ee, "go alive!", $f7
    db $f0

Message_0C_DF::
    db $ea, "*: What is it, you", $f1
    db "little brat?", $fa, $f7
    db $ef, $ee, "Back to get", $ef, $ee, "creamed again?", $fa, $f7
    db $ef, $ee, "I won't let you go", $ef, $ee, "alive this time!", $f7
    db $f0

Message_0C_E0::
    db $ea, "*: But", $a4, " No! I lost", $f1
    db "to this brat?", $f7
    db $f0

Message_0C_E1::
    db $eb, "Milayou: You are", $f1
    db "really special.", $fa, $f7
    db $ef, $ee, "I couldn't do a", $ef, $ee, "thing against him", $a4, $fa, $f7
    db $ef, $ee, "I'll have to train", $ef, $ee, "that much harder", $a4, $fa, $f7
    db $ef, $ee, "I'll be no match", $ef, $ee, "for my kid brother", $fa, $f7
    db $ef, $ee, "if  I don't apply", $ef, $ee, "myself better.", $fa, $f7
    db $ef, $ee, "I'll wait for you", $ef, $ee, "in town!", $f7
    db $f0

Message_0C_E2::
    db $ea, "*: Welcome to the", $f1
    db "town of Miagen.", $fa, $f7
    db $ef, $ee, "We're proud of our", $ef, $ee, "affluence here!", $f7
    db $f0

Message_0C_E3::
    db $eb, "*: So you defeated", $f1
    db "the evildoer?", $f7
    db $f0

Message_0C_E4::
    db $ea, "*: Wow, you have", $f1
    db "monsters! Wicked!", $fa, $f7
    db $ef, $ee, "They beat the bad", $ef, $ee, "guy, didn't they?", $f7
    db $f0

Message_0C_E5::
    db $eb, "*: Your monsters", $f1
    db "are good, it's", $fa, $f7
    db $ef, $ee, "plain to see.", $ef, $ee, "I like them!", $f7
    db $f0

Message_0C_E6::
    db $ea, "*: So there are", $f1
    db "evil masters", $a4, $fa, $f7
    db $ef, $ee, "Oh, but you're not", $ef, $ee, "one of those.", $f7
    db $f0

Message_0C_E7::
    db $eb, "*: Controlling", $f1
    db "monsters is no", $fa, $f7
    db $ef, $ee, "easy feat, is it?", $ef, $ee, "I'm so in awe!", $fa, $f7
    db $ef, $ee, "You've brought", $ef, $ee, "peace to us!", $f7
    db $f0

Message_0C_E8::
    db $ea, "*: I thank you in", $f1
    db "all sincerity!", $f7
    db $f0

Message_0C_E9::
    db $eb, "*: The atmosphere", $f1
    db "has cheered up,", $fa, $f7
    db $ef, $ee, "thanks to your", $ef, $ee, "crime busting.", $fa, $f7
    db $ef, $ee, "It gives me hope", $ef, $ee, "to live another", $fa, $f7
    db $ef, $ee, "one hundred years!", $ef, $ee, $f7
    db $f0

Message_0C_EA::
    db $ea, "*: I long to have a", $f1
    db "family of my own.", $fa, $f7
    db $ef, $ee, "I wish I was", $ef, $ee, "married", $a4, $f7
    db $f0

Message_0C_EB::
    db $eb, "*: Old people say", $f1
    db "that a cheerful", $fa, $f7
    db $ef, $ee, "town is a good", $ef, $ee, "town. I agree!", $f7
    db $f0

Message_0C_EC::
    db $ea, "*: Monsters can be", $f1
    db "good or evil on", $fa, $f7
    db $ef, $ee, "the whims of their", $ef, $ee, "masters, I guess.", $f7
    db $f0

Message_0C_ED::
    db $eb, "*: The thief was", $f1
    db "selling what he", $fa, $f7
    db $ef, $ee, "stole from us for", $ef, $ee, "a lot of gold.", $fa, $f7
    db $ef, $ee, "But why would he", $ef, $ee, "steal my clothes?", $fa, $f7
    db $ef, $ee, "Were they valuable", $ef, $ee, "because they were", $fa, $f7
    db $ef, $ee, "mine? I'm not sure", $ef, $ee, "I want to know", $a4, $f7
    db $f0

Message_0C_EE::
    db $ea, "*: It sure was a", $f1
    db "thrilling time", $fa, $f7
    db $ef, $ee, "when the thief was", $ef, $ee, "roving around.", $f7
    db $f0

Message_0C_EF::
    db $eb, "Milayou: I asked", $f1
    db "for your support", $fa, $f7
    db $ef, $ee, "to capture that", $ef, $ee, "thief", $a4, $fa, $f7
    db $ef, $ee, "But you ended up", $ef, $ee, "doing it all.", $fa, $f7
    db $ef, $ee, "I'm sorry, and", $ef, $ee, "thank you.", $fa, $f7
    db $ef, $ee, "Oh? You're from", $ef, $ee, "GreatLog?", $fa, $f7
    db $ef, $ee, "And you've won", $ef, $ee, "tournaments.", $fa, $f7
    db $ef, $ee, "Well, no wonder", $ef, $ee, "you're strong.", $fa, $f7
    db $ef, $ee, "How is Kameha,", $ef, $ee, "by the way?", $f7
    db $f0

Message_0C_F0::
    db $eb, "Milayou: How do I", $f1
    db "know about him?", $fa, $f7
    db $ef, $ee, "Well", $a4, $ef, $ee, "That's a secret!", $f7
    db $f0

Message_0C_F1::
    db $eb, "Milayou: You've", $f1
    db "inspired me to try", $fa, $f7
    db $ef, $ee, "harder in my", $ef, $ee, "training.", $fa, $f7
    db $ef, $ee, "I hope we can", $ef, $ee, "battle some day!", $f7
    db $f0

Message_0C_F2::
    db $ea, "*: That merchant,", $f1
    db "he was a thief.", $fa, $f7
    db $ef, $ee, "In one way he has", $ef, $ee, "my admiration.", $fa, $f7
    db $ef, $ee, "His bad deeds", $ef, $ee, "escaped my notice!", $f7
    db $f0

Message_0C_F3::
    db $ea, "*: People say you", $f1
    db "can't judge people", $fa, $f7
    db $ef, $ee, "by appearances", $a4, $ef, $ee, "But that thieving", $fa, $f7
    db $ef, $ee, "merchant", $a4, " He had", $ef, $ee, "the bad guy look!", $f7
    db $f0

Message_0C_F4::
    db $eb, "*: That greedy", $f1
    db "hound of a dealer", $fa, $f7
    db $ef, $ee, "was behind those", $ef, $ee, "monsters", $a4, $fa, $f7
    db $ef, $ee, "But to be caught", $ef, $ee, "out by selling", $fa, $f7
    db $ef, $ee, "what he stole", $a4, $ef, $ee, "He's not what I", $fa, $f7
    db $ef, $ee, "call a criminal", $ef, $ee, "mastermind.", $f7
    db $f0

Message_0C_F5::
    db $eb, "Milayou: I knew", $f1
    db "you", $44, " come back!", $fa, $f7
    db $ef, $ee, "I've trained hard", $ef, $ee, "since we last met.", $fa, $f7
    db $ef, $ee, "Would you like to", $ef, $ee, "spar with me?", $ff, $f0

Message_0C_F6::
    db $eb, "Milayou: Great!", $f1
    db "No holding back!", $f7
    db $f0

Message_0C_F7::
    db $eb, "Milayou: Oh", $a4, $f1
    db "I'm disappointed", $a4, $fa, $f7
    db $ef, $ee, "Come again if you", $ef, $ee, "want to spar.", $f7
    db $f0

Message_0C_F8::
    db $eb, "Milayou: Want to", $f1
    db "spar with me?", $ff, $f0

Message_0C_F9::
    db $eb, "Milayou: I lost", $a4, $f1
    db "But, good battle!", $fa, $f7
    db $ef, $ee, "Oh, I need to tell", $ef, $ee, "you this.", $fa, $f7
    db $ef, $ee, "If you meet a boy", $ef, $ee, "named Terry,", $fa, $f7
    db $ef, $ee, "please crush him", $ef, $ee, "in battle.", $fa, $f7
    db $ef, $ee, "He's not anyone", $ef, $ee, "special, so you", $fa, $f7
    db $ef, $ee, "can just destroy", $ef, $ee, "him. Promise!", $fa, $f7
    db $ef, $ee, "I really should", $ef, $ee, "get going myself.", $fa, $f7
    db $ef, $ee, "I hope we can meet", $ef, $ee, "again somewhere,", $fa, $f7
    db $ef, $ee, "sometime. OK!", $ef, $ee, "Bye-bye!", $f7
    db $f0

Message_0C_FA::
    db $f9, "0 peered into", $f1
    db "the oven.", $fa, $f7
    db $ef, $ee, "A tantalizing", $ef, $ee, "aroma wafted out", $a4, $f7
    db $f0

Message_0C_FB::
    db $f9, "0 tried to", $f1
    db "open the chest.", $fa, $f7
    db $ef, $ee, "But it was locked.", $ef, $ee, $f7
    db $f0

Message_0C_FC::
    db $f9, "0 peered into", $f1
    db "the vase.", $fa, $f7
    db $ef, $ee, "Cold water lapped", $ef, $ee, "and rippled.", $f7
    db $f0

Message_0C_FD::
    db $f9, "0 peered into", $f1
    db "the oven.", $fa, $f7
    db $ef, $ee, "Meat sizzled on a", $ef, $ee, "skewer.", $f7
    db $f0

Message_0C_FE::
    db $f9, "0 opened the", $f1
    db "treasure chest.", $fa, $f7
    db $ef, $ee, "It was crammed", $ef, $ee, "with treasures.", $fa, $f7
    db $ef, $ee, "It appears to be", $ef, $ee, "loot taken from", $fa, $f7
    db $ef, $ee, "the town.", $ef, $ee, $f7
    db $f0

Message_0C_FF::
    db $f0
    ds $14a1, $00
