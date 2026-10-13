SECTION "Bank 2F", ROMX[$4000], BANK[$2F]
    db $2f

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank2F::
    ld de, StringCategories_2F_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank2F (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank2F::
    call BeginStringDisplay_Bank2F
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_2F_4016::
    dw StringList_2F_4022 ; id 0
    dw StringList_2F_4134 ; id 1
    dw StringList_2F_4334 ; id 2
    dw StringList_2F_433C ; id 3
    dw StringList_2F_433E ; id 4
    dw StringList_2F_4340 ; id 5

; category list of StringCategories_2F_4016; one pointer per wStringIndex (E-0217)
; record: string
StringList_2F_4022::
    dw String_2F_00_00 ; id 0
    dw String_2F_00_01 ; id 1
    dw String_2F_00_02 ; id 2
    dw String_2F_00_03 ; id 3
    dw String_2F_00_04 ; id 4
    dw String_2F_00_05 ; id 5
    dw String_2F_00_06 ; id 6
    dw String_2F_00_07 ; id 7
    dw String_2F_00_08 ; id 8
    dw String_2F_00_09 ; id 9
    dw String_2F_00_0A ; id 10
    dw String_2F_00_0B ; id 11
    dw String_2F_00_0C ; id 12
    dw String_2F_00_0D ; id 13
    dw String_2F_00_0E ; id 14
    dw String_2F_00_0F ; id 15
    dw String_2F_00_10 ; id 16
    dw String_2F_00_11 ; id 17
    dw String_2F_00_12 ; id 18
    dw String_2F_00_13 ; id 19
    dw String_2F_00_14 ; id 20
    dw String_2F_00_15 ; id 21
    dw String_2F_00_16 ; id 22
    dw String_2F_00_17 ; id 23
    dw String_2F_00_18 ; id 24
    dw String_2F_00_19 ; id 25
    dw String_2F_00_1A ; id 26
    dw String_2F_00_1B ; id 27
    dw String_2F_00_1C ; id 28
    dw String_2F_00_1D ; id 29
    dw String_2F_00_1E ; id 30
    dw String_2F_00_1F ; id 31
    dw String_2F_00_20 ; id 32
    dw String_2F_00_21 ; id 33
    dw String_2F_00_22 ; id 34
    dw String_2F_00_23 ; id 35
    dw String_2F_00_24 ; id 36
    dw String_2F_00_25 ; id 37
    dw String_2F_00_26 ; id 38
    dw String_2F_00_27 ; id 39
    dw String_2F_00_28 ; id 40
    dw String_2F_00_29 ; id 41
    dw String_2F_00_2A ; id 42
    dw String_2F_00_2B ; id 43
    dw String_2F_00_2C ; id 44
    dw String_2F_00_2D ; id 45
    dw String_2F_00_2E ; id 46
    dw String_2F_00_2F ; id 47
    dw String_2F_00_30 ; id 48
    dw String_2F_00_31 ; id 49
    dw String_2F_00_32 ; id 50
    dw String_2F_00_33 ; id 51
    dw String_2F_00_34 ; id 52
    dw String_2F_00_35 ; id 53
    dw String_2F_00_36 ; id 54
    dw String_2F_00_37 ; id 55
    dw String_2F_00_38 ; id 56
    dw String_2F_00_39 ; id 57
    dw String_2F_00_3A ; id 58
    dw String_2F_00_3B ; id 59
    dw String_2F_00_3C ; id 60
    dw String_2F_00_3D ; id 61
    dw String_2F_00_3E ; id 62
    dw String_2F_00_3F ; id 63
    dw String_2F_00_40 ; id 64
    dw String_2F_00_41 ; id 65
    dw String_2F_00_42 ; id 66
    dw String_2F_00_43 ; id 67
    dw String_2F_00_44 ; id 68
    dw String_2F_00_45 ; id 69
    dw String_2F_00_46 ; id 70
    dw String_2F_00_47 ; id 71
    dw String_2F_00_48 ; id 72
    dw String_2F_00_49 ; id 73
    dw String_2F_00_4A ; id 74
    dw String_2F_00_4B ; id 75
    dw String_2F_00_4C ; id 76
    dw String_2F_00_4D ; id 77
    dw String_2F_00_4E ; id 78
    dw String_2F_00_4F ; id 79
    dw String_2F_00_50 ; id 80
    dw String_2F_00_51 ; id 81
    dw String_2F_00_52 ; id 82
    dw String_2F_00_53 ; id 83
    dw String_2F_00_54 ; id 84
    dw String_2F_00_55 ; id 85
    dw String_2F_00_56 ; id 86
    dw String_2F_00_57 ; id 87
    dw String_2F_00_58 ; id 88
    dw String_2F_00_59 ; id 89
    dw String_2F_00_5A ; id 90
    dw String_2F_00_5B ; id 91
    dw String_2F_00_5C ; id 92
    dw String_2F_00_5D ; id 93
    dw String_2F_00_5E ; id 94
    dw String_2F_00_5F ; id 95
    dw String_2F_00_60 ; id 96
    dw String_2F_00_61 ; id 97
    dw String_2F_00_62 ; id 98
    dw String_2F_00_63 ; id 99
    dw String_2F_00_64 ; id 100
    dw String_2F_00_65 ; id 101
    dw String_2F_00_66 ; id 102
    dw String_2F_00_67 ; id 103
    dw String_2F_00_68 ; id 104
    dw String_2F_00_69 ; id 105
    dw String_2F_00_6A ; id 106
    dw String_2F_00_6B ; id 107
    dw String_2F_00_6C ; id 108
    dw String_2F_00_6D ; id 109
    dw String_2F_00_6E ; id 110
    dw String_2F_00_6F ; id 111
    dw String_2F_00_70 ; id 112
    dw String_2F_00_71 ; id 113
    dw String_2F_00_72 ; id 114
    dw String_2F_00_73 ; id 115
    dw String_2F_00_74 ; id 116
    dw String_2F_00_75 ; id 117
    dw String_2F_00_76 ; id 118
    dw String_2F_00_77 ; id 119
    dw String_2F_00_78 ; id 120
    dw String_2F_00_79 ; id 121
    dw String_2F_00_7A ; id 122
    dw String_2F_00_7B ; id 123
    dw String_2F_00_7C ; id 124
    dw String_2F_00_7D ; id 125
    dw String_2F_00_7E ; id 126
    dw String_2F_00_7F ; id 127
    dw String_2F_00_80 ; id 128
    dw String_2F_00_81 ; id 129
    dw String_2F_00_82 ; id 130
    dw String_2F_00_83 ; id 131
    dw String_2F_00_84 ; id 132
    dw String_2F_00_85 ; id 133
    dw String_2F_00_86 ; id 134
    dw String_2F_00_87 ; id 135
    dw String_2F_00_88 ; id 136

StringList_2F_4134::
    dw String_2F_01_00 ; id 0
    dw String_2F_01_01 ; id 1
    dw String_2F_01_02 ; id 2
    dw String_2F_01_03 ; id 3
    dw String_2F_01_04 ; id 4
    dw String_2F_01_05 ; id 5
    dw String_2F_01_06 ; id 6
    dw String_2F_01_07 ; id 7
    dw String_2F_01_08 ; id 8
    dw String_2F_01_09 ; id 9
    dw String_2F_01_0A ; id 10
    dw String_2F_01_0B ; id 11
    dw String_2F_01_0C ; id 12
    dw String_2F_01_0D ; id 13
    dw String_2F_01_0E ; id 14
    dw String_2F_01_0F ; id 15
    dw String_2F_01_10 ; id 16
    dw String_2F_01_11 ; id 17
    dw String_2F_01_12 ; id 18
    dw String_2F_01_13 ; id 19
    dw String_2F_01_14 ; id 20
    dw String_2F_01_15 ; id 21
    dw String_2F_01_16 ; id 22
    dw String_2F_01_17 ; id 23
    dw String_2F_01_18 ; id 24
    dw String_2F_01_19 ; id 25
    dw String_2F_01_1A ; id 26
    dw String_2F_01_1B ; id 27
    dw String_2F_01_1C ; id 28
    dw String_2F_01_1D ; id 29
    dw String_2F_01_1E ; id 30
    dw String_2F_01_1F ; id 31
    dw String_2F_01_20 ; id 32
    dw String_2F_01_21 ; id 33
    dw String_2F_01_22 ; id 34
    dw String_2F_01_23 ; id 35
    dw String_2F_01_24 ; id 36
    dw String_2F_01_25 ; id 37
    dw String_2F_01_26 ; id 38
    dw String_2F_01_27 ; id 39
    dw String_2F_01_28 ; id 40
    dw String_2F_01_29 ; id 41
    dw String_2F_01_2A ; id 42
    dw String_2F_01_2B ; id 43
    dw String_2F_01_2C ; id 44
    dw String_2F_01_2D ; id 45
    dw String_2F_01_2E ; id 46
    dw String_2F_01_2F ; id 47
    dw String_2F_01_30 ; id 48
    dw String_2F_01_31 ; id 49
    dw String_2F_01_32 ; id 50
    dw String_2F_01_33 ; id 51
    dw String_2F_01_34 ; id 52
    dw String_2F_01_35 ; id 53
    dw String_2F_01_36 ; id 54
    dw String_2F_01_37 ; id 55
    dw String_2F_01_38 ; id 56
    dw String_2F_01_39 ; id 57
    dw String_2F_01_3A ; id 58
    dw String_2F_01_3B ; id 59
    dw String_2F_01_3C ; id 60
    dw String_2F_01_3D ; id 61
    dw String_2F_01_3E ; id 62
    dw String_2F_01_3F ; id 63
    dw String_2F_01_40 ; id 64
    dw String_2F_01_41 ; id 65
    dw String_2F_01_42 ; id 66
    dw String_2F_01_43 ; id 67
    dw String_2F_01_44 ; id 68
    dw String_2F_01_45 ; id 69
    dw String_2F_01_46 ; id 70
    dw String_2F_01_47 ; id 71
    dw String_2F_01_48 ; id 72
    dw String_2F_01_49 ; id 73
    dw String_2F_01_4A ; id 74
    dw String_2F_01_4B ; id 75
    dw String_2F_01_4C ; id 76
    dw String_2F_01_4D ; id 77
    dw String_2F_01_4E ; id 78
    dw String_2F_01_4F ; id 79
    dw String_2F_01_50 ; id 80
    dw String_2F_01_51 ; id 81
    dw String_2F_01_52 ; id 82
    dw String_2F_01_53 ; id 83
    dw String_2F_01_54 ; id 84
    dw String_2F_01_55 ; id 85
    dw String_2F_01_56 ; id 86
    dw String_2F_01_57 ; id 87
    dw String_2F_01_58 ; id 88
    dw String_2F_01_59 ; id 89
    dw String_2F_01_5A ; id 90
    dw String_2F_01_5B ; id 91
    dw String_2F_01_5C ; id 92
    dw String_2F_01_5D ; id 93
    dw String_2F_01_5E ; id 94
    dw String_2F_01_5F ; id 95
    dw String_2F_01_60 ; id 96
    dw String_2F_01_61 ; id 97
    dw String_2F_01_62 ; id 98
    dw String_2F_01_63 ; id 99
    dw String_2F_01_64 ; id 100
    dw String_2F_01_65 ; id 101
    dw String_2F_01_66 ; id 102
    dw String_2F_01_67 ; id 103
    dw String_2F_01_68 ; id 104
    dw String_2F_01_69 ; id 105
    dw String_2F_01_6A ; id 106
    dw String_2F_01_6B ; id 107
    dw String_2F_01_6C ; id 108
    dw String_2F_01_6D ; id 109
    dw String_2F_01_6E ; id 110
    dw String_2F_01_6F ; id 111
    dw String_2F_01_70 ; id 112
    dw String_2F_01_71 ; id 113
    dw String_2F_01_72 ; id 114
    dw String_2F_01_73 ; id 115
    dw String_2F_01_74 ; id 116
    dw String_2F_01_75 ; id 117
    dw String_2F_01_76 ; id 118
    dw String_2F_01_77 ; id 119
    dw String_2F_01_78 ; id 120
    dw String_2F_01_79 ; id 121
    dw String_2F_01_7A ; id 122
    dw String_2F_01_7B ; id 123
    dw String_2F_01_7C ; id 124
    dw String_2F_01_7D ; id 125
    dw String_2F_01_7E ; id 126
    dw String_2F_01_7F ; id 127
    dw String_2F_01_80 ; id 128
    dw String_2F_01_81 ; id 129
    dw String_2F_01_82 ; id 130
    dw String_2F_01_83 ; id 131
    dw String_2F_01_84 ; id 132
    dw String_2F_01_85 ; id 133
    dw String_2F_01_86 ; id 134
    dw String_2F_01_87 ; id 135
    dw String_2F_01_88 ; id 136
    dw String_2F_01_89 ; id 137
    dw String_2F_01_8A ; id 138
    dw String_2F_01_8B ; id 139
    dw String_2F_01_8C ; id 140
    dw String_2F_01_8D ; id 141
    dw String_2F_01_8E ; id 142
    dw String_2F_01_8F ; id 143
    dw String_2F_01_90 ; id 144
    dw String_2F_01_91 ; id 145
    dw String_2F_01_92 ; id 146
    dw String_2F_01_93 ; id 147
    dw String_2F_01_94 ; id 148
    dw String_2F_01_95 ; id 149
    dw String_2F_01_96 ; id 150
    dw String_2F_01_97 ; id 151
    dw String_2F_01_98 ; id 152
    dw String_2F_01_99 ; id 153
    dw String_2F_01_9A ; id 154
    dw String_2F_01_9B ; id 155
    dw String_2F_01_9C ; id 156
    dw String_2F_01_9D ; id 157
    dw String_2F_01_9E ; id 158
    dw String_2F_01_9F ; id 159
    dw String_2F_01_A0 ; id 160
    dw String_2F_01_A1 ; id 161
    dw String_2F_01_A2 ; id 162
    dw String_2F_01_A3 ; id 163
    dw String_2F_01_A4 ; id 164
    dw String_2F_01_A5 ; id 165
    dw String_2F_01_A6 ; id 166
    dw String_2F_01_A7 ; id 167
    dw String_2F_01_A8 ; id 168
    dw String_2F_01_A9 ; id 169
    dw String_2F_01_AA ; id 170
    dw String_2F_01_AB ; id 171
    dw String_2F_01_AC ; id 172
    dw String_2F_01_AD ; id 173
    dw String_2F_01_AE ; id 174
    dw String_2F_01_AF ; id 175
    dw String_2F_01_B0 ; id 176
    dw String_2F_01_B1 ; id 177
    dw String_2F_01_B2 ; id 178
    dw String_2F_01_B3 ; id 179
    dw String_2F_01_B4 ; id 180
    dw String_2F_01_B5 ; id 181
    dw String_2F_01_B6 ; id 182
    dw String_2F_01_B7 ; id 183
    dw String_2F_01_B8 ; id 184
    dw String_2F_01_B9 ; id 185
    dw String_2F_01_BA ; id 186
    dw String_2F_01_BB ; id 187
    dw String_2F_01_BC ; id 188
    dw String_2F_01_BD ; id 189
    dw String_2F_01_BE ; id 190
    dw String_2F_01_BF ; id 191
    dw String_2F_01_C0 ; id 192
    dw String_2F_01_C1 ; id 193
    dw String_2F_01_C2 ; id 194
    dw String_2F_01_C3 ; id 195
    dw String_2F_01_C4 ; id 196
    dw String_2F_01_C5 ; id 197
    dw String_2F_01_C6 ; id 198
    dw String_2F_01_C7 ; id 199
    dw String_2F_01_C8 ; id 200
    dw String_2F_01_C9 ; id 201
    dw String_2F_01_CA ; id 202
    dw String_2F_01_CB ; id 203
    dw String_2F_01_CC ; id 204
    dw String_2F_01_CD ; id 205
    dw String_2F_01_CE ; id 206
    dw String_2F_01_CF ; id 207
    dw String_2F_01_D0 ; id 208
    dw String_2F_01_D1 ; id 209
    dw String_2F_01_D2 ; id 210
    dw String_2F_01_D3 ; id 211
    dw String_2F_01_D4 ; id 212
    dw String_2F_01_D5 ; id 213
    dw String_2F_01_D6 ; id 214
    dw String_2F_01_D7 ; id 215
    dw String_2F_01_D8 ; id 216
    dw String_2F_01_D9 ; id 217
    dw String_2F_01_DA ; id 218
    dw String_2F_01_DB ; id 219
    dw String_2F_01_DC ; id 220
    dw String_2F_01_DD ; id 221
    dw String_2F_01_DE ; id 222
    dw String_2F_01_DF ; id 223
    dw String_2F_01_E0 ; id 224
    dw String_2F_01_E1 ; id 225
    dw String_2F_01_E2 ; id 226
    dw String_2F_01_E3 ; id 227
    dw String_2F_01_E4 ; id 228
    dw String_2F_01_E5 ; id 229
    dw String_2F_01_E6 ; id 230
    dw String_2F_01_E7 ; id 231
    dw String_2F_01_E8 ; id 232
    dw String_2F_01_E9 ; id 233
    dw String_2F_01_EA ; id 234
    dw String_2F_01_EB ; id 235
    dw String_2F_01_EC ; id 236
    dw String_2F_01_ED ; id 237
    dw String_2F_01_EE ; id 238
    dw String_2F_01_EF ; id 239
    dw String_2F_01_F0 ; id 240
    dw String_2F_01_F1 ; id 241
    dw String_2F_01_F2 ; id 242
    dw String_2F_01_F3 ; id 243
    dw String_2F_01_F4 ; id 244
    dw String_2F_01_F5 ; id 245
    dw String_2F_01_F6 ; id 246
    dw String_2F_01_F7 ; id 247
    dw String_2F_01_F8 ; id 248
    dw String_2F_01_F9 ; id 249
    dw String_2F_01_FA ; id 250
    dw String_2F_01_FB ; id 251
    dw String_2F_01_FC ; id 252
    dw String_2F_01_FD ; id 253
    dw String_2F_01_FE ; id 254
    dw String_2F_01_FF ; id 255

StringList_2F_4334::
    dw String_2F_02_00 ; id 0
    dw String_2F_02_01 ; id 1
    dw String_2F_02_02 ; id 2
    dw String_2F_02_03 ; id 3

StringList_2F_433C::
    dw String_2F_03_00 ; id 0

StringList_2F_433E::
    dw String_2F_03_00 ; id 0

StringList_2F_4340::
    dw String_2F_05_00 ; id 0
    dw String_2F_05_01 ; id 1
    dw String_2F_05_02 ; id 2
    dw String_2F_05_02 ; id 3
    dw String_2F_05_04 ; id 4
    dw String_2F_05_05 ; id 5
    dw String_2F_05_06 ; id 6
    dw String_2F_05_07 ; id 7
    dw String_2F_05_08 ; id 8
    dw String_2F_05_09 ; id 9
    dw String_2F_05_0A ; id 10
    dw String_2F_05_0B ; id 11
    dw String_2F_05_0C ; id 12
    dw String_2F_05_0D ; id 13
    dw String_2F_05_0E ; id 14
    dw String_2F_05_0F ; id 15
    dw String_2F_05_10 ; id 16
    dw String_2F_05_11 ; id 17
    dw String_2F_05_12 ; id 18
    dw String_2F_05_13 ; id 19
    dw String_2F_05_14 ; id 20
    dw String_2F_05_15 ; id 21
    dw String_2F_05_16 ; id 22
    dw String_2F_05_17 ; id 23
    dw String_2F_05_18 ; id 24
    dw String_2F_05_19 ; id 25
    dw String_2F_05_1A ; id 26
    dw String_2F_05_1B ; id 27
    dw String_2F_05_1C ; id 28
    dw String_2F_05_1D ; id 29
    dw String_2F_05_1E ; id 30
    dw String_2F_05_1F ; id 31
    dw String_2F_05_20 ; id 32
    dw String_2F_05_21 ; id 33

String_2F_00_00::
    db $ed, $f9, "0 appears!", $f1
    db $ec, $f0

String_2F_00_01::
    db $ed, "Monsters appear!", $f1
    db $ec, $f0

String_2F_00_02::
    db $ed, "Monsters appear!", $f1
    db $ec, $f0

String_2F_00_03::
    db $ed, "Monsters appear!", $f1
    db $ec, $f0

String_2F_00_04::
    db $ed, "Monsters appear!", $f1
    db $ec, $f0

String_2F_00_05::
    db $ed, "Monsters appear!", $f1
    db $ec, $f0

String_2F_00_06::
    db $ed, $f6, "'s party was", $f1
    db "wiped out!", $e5, "'v", $f0

String_2F_00_07::
    db $ed, "Monsters were", $f1
    db "defeated!", $e4, $7e, $fa, $f7
    db $f0

String_2F_00_08::
    db $ed, $f9, "0 left", $f1
    db "the scene.", $ec, $f0

String_2F_00_09::
    db $ed, "The monsters left", $f1
    db "the scene.", $ec, $f0

String_2F_00_0A::
    db $ed, "The monsters left", $f1
    db "the scene.", $ec, $f0

String_2F_00_0B::
    db $ed, $f9, "0", $f1
    db "couldn't react!", $ec, $f0

String_2F_00_0C::
    db $ed, $f9, "0", $f1
    db "appeared stunned!", $ec, $f0

String_2F_00_0D::
    db $ed, $f9, "0", $f1
    db "suddenly attacked!", $ec, $f0

String_2F_00_0E::
    db $ed, $f9, "0 struck", $f1
    db "without warning!", $ec, $f0

String_2F_00_0F::
    db $ed, $f9, "0 is", $f1
    db "cursed!", $ec, $f2, $ed, $f9, "0 can't", $f1
    db "move!", $ec, $f0

String_2F_00_10::
    db $ed, $f9, "0 is", $f1
    db "cursed!", $ec, $f2, $ed, $f9, "0 lost", $f1
    db $f9, "GHP!", $ec, $f0

String_2F_00_11::
    db $ed, $f9, "0 is", $f1
    db "cursed!", $ec, $f2, $ed, $f9, "0 lost", $f1
    db $f9, "GMP!", $ec, $f0

String_2F_00_12::
    db $ed, $f9, "0 is", $f1
    db "cursed!", $ec, $f2, $ed, $f9, "0 became", $f1
    db "confused!", $ec, $f0

String_2F_00_13::
    db $ed, $f9, "0 is", $f1
    db "asleep.", $ec, $f0

String_2F_00_14::
    db $ed, $f9, "0 is", $f1
    db "confused!", $ec, $f0

String_2F_00_15::
    db $ed, $f9, "0 is a", $f1
    db "hunk of iron!", $ec, $f0

String_2F_00_16::
    db $ed, $f9, "0 is", $f1
    db "frozen solid!", $ec, $f0

String_2F_00_17::
    db $ed, $f9, "0 is", $f1
    db "paralyzed!", $ec, $f0

String_2F_00_18::
    db $ed, $f9, "0 is", $f1
    db "dancing along!", $ec, $f0

String_2F_00_19::
    db $ed, $f9, "0 is", $f1
    db "shivering!", $ec, $f0

String_2F_00_1A::
    db $ed, $f9, "0 can't", $f1
    db "get back up!", $ec, $f0

String_2F_00_1B::
    db $ed, $f9, "0 is", $f1
    db "cowering in fear!", $ec, $f0

String_2F_00_1C::
    db $ed, $f9, "0 looks", $f1
    db "vacant and lost!", $ec, $f0

String_2F_00_1D::
    db $ed, "No items allowed", $f1
    db "in this battle!", $f7
    db $f0

String_2F_00_1E::
    db $ed, "This item can't be", $f1
    db "used in battle!", $f7
    db $f0

String_2F_00_1F::
    db $ed, "There are no", $f1
    db "usable items!", $f7
    db $f0

String_2F_00_20::
    db $ed, "No fleeing from", $f1
    db "this battle!", $f7
    db $f0

String_2F_00_21::
    db $ed, "Can't use that", $f1
    db "skill now!", $f7
    db $f0

String_2F_00_22::
    db $ed, "Selecting", $f1
    db $f9, "0's move", $a4, $f0

String_2F_00_23::
    db $ed, "No monsters to", $f1
    db "access PLAN.", $f7
    db $f0

String_2F_00_24::
    db $ed, "There is no target", $f1
    db "in sight!", $f7
    db $f0

String_2F_00_25::
    db $ed, "That skill can't", $f1
    db "be used in battle!", $f7
    db $f0

String_2F_00_26::
    db $ed, "Not enough MP!", $f1
    db $f7
    db $f0

String_2F_00_27::
    db $ed, "Retire now?", $f1
    db $f0

String_2F_00_28::
    db $ed, $f9, "0 ignored", $f1
    db "orders!", $ec, $f0

String_2F_00_29::
    db $ed, "It has no usable", $f1
    db "battle skills!", $ec, $f0

String_2F_00_2A::
    db $ed, $f9, "0", $f1
    db "not recruited!", $ec, $f0

String_2F_00_2B::
    db $ed, $f9, "0", $f1
    db "already recruited.", $ec, $f0

String_2F_00_2C::
    db $ed, "But the escape", $f1
    db "route was cut off!", $ec, $f0

String_2F_00_2D::
    db $ed, "But there's no one", $f1
    db "to command!", $f7
    db $f0

String_2F_00_2E::
    db $ed, $f9, "0 struck", $f1
    db "at full power!", $ec, $f0

String_2F_00_2F::
    db $ed, $f9, "0 tucked", $f1
    db "tighter in fear!", $ec, $f0

String_2F_00_30::
    db $ed, $f9, "0", $f1
    db "concentrated!", $ec, $f0

String_2F_00_31::
    db $ed, $f9, "0 struck", $f1
    db "back, enraged.", $ec, $f0

String_2F_00_32::
    db $ed, "Light fell softly", $f1
    db "on ", $f9, "0!", $ec, $f0

String_2F_00_33::
    db $ed, $f9, "0 ducked", $f1
    db "behind ", $f9, "G!", $ec, $f0

String_2F_00_34::
    db $ed, $f9, "0 pumped", $f1
    db "itself up!", $ec, $f0

String_2F_00_35::
    db $ed, $f9, "0 rolled", $f1
    db "out of the way!", $ec, $f0

String_2F_00_36::
    db $ed, $f9, "0 cast", $f1
    db $f9, "G!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_37::
    db $ed, $f9, "0 blew", $f1
    db $f9, "G!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_38::
    db $ed, $f9, "0 danced", $f1
    db "the ", $f9, "G!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_39::
    db $ed, $f9, "0 tried", $f1
    db "to jump high!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_3A::
    db $ed, $f9, "0 tried", $f1
    db "to call for help!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_3B::
    db $ed, $f9, "0 tried", $f1
    db "to yell for help!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_3C::
    db $ed, $f9, "0 tried", $f1
    db "to pump itself up!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_3D::
    db $ed, $f9, "0 tried", $f1
    db "to cast a curse!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_3E::
    db $ed, $f9, "0 tried", $f1
    db "to inhale all!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_3F::
    db $ed, $f9, "0 quiets", $f1
    db $f9, "W!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_40::
    db $ed, $f9, "0 tried", $f1
    db "to sing!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_41::
    db $ed, $f9, "0 tried", $f1
    db "to make a barrier!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_42::
    db $ed, $f9, "0 prayed", $f1
    db "to the heavens!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_43::
    db $ed, $f9, "0 prayed", $f1
    db "for silence!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_44::
    db $ed, $f9, "0 tried", $f1
    db "to shoot water!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_45::
    db $ed, $f9, "0 called", $f1
    db "for ", $f9, "G!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_46::
    db $ed, $f9, "0 tried", $f1
    db "to use ", $f9, "G!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_47::
    db $ed, $f9, "0 tried", $f1
    db "waking ", $f9, "G!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_48::
    db $ed, $f9, "0 got", $f1
    db "ready to inhale!", $ec, $f2, $ed, "But there weren't", $f1
    db "enough MP!", $ec, $f0

String_2F_00_49::
    db $ed, $f9, "0 cast", $f1
    db $f9, "G!", $ec, $f2, $ed, "But its spells", $f1
    db "are sealed!", $ec, $f0

String_2F_00_4A::
    db $ed, $f9, "0 tried", $f1
    db "blowing ", $f9, "G!", $ec, $f2, $ed, "But its mouth is", $f1
    db "sealed tight!", $ec, $f0

String_2F_00_4B::
    db $ed, $f9, "0 danced", $f1
    db "the ", $f9, "G!", $ec, $f2, $ed, "But it can't do", $f1
    db "the dance!", $ec, $f0

String_2F_00_4C::
    db $ed, $f9, "0 cast", $f1
    db $f9, "G!", $ec, $f2, $ed, "But the spell was", $f1
    db "shattered!", $ec, $f0

String_2F_00_4D::
    db $ed, $f9, "0 cast", $f1
    db $f9, "G!", $ec, $f2, $ed, "But it is sealed", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_4E::
    db $ed, $f9, "0 tried", $f1
    db "to use ", $f9, "G!", $ec, $f2, $ed, "But it is sealed", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_4F::
    db $ed, $f9, "0 blew", $f1
    db $f9, "G!", $ec, $f2, $ed, "But it is sealed", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_50::
    db $ed, $f9, "0 tried", $f1
    db "waking ", $f9, "G!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_51::
    db $ed, $f9, "0 tried", $f1
    db "to call for help!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_52::
    db $ed, $f9, "0 tried", $f1
    db "to yell for help!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_53::
    db $ed, $f9, "0 tried", $f1
    db "to build power!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_54::
    db $ed, $f9, "0 tried", $f1
    db "to pump itself up!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_55::
    db $ed, $f9, "0 tried", $f1
    db "to jump high!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_56::
    db $ed, $f9, "0 danced", $f1
    db "the ", $f9, "G!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_57::
    db $ed, $f9, "0 got", $f1
    db "ready to inhale!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_58::
    db $ed, $f9, "0 quiets", $f1
    db $f9, "W!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_59::
    db $ed, $f9, "0 tried", $f1
    db "to make a barrier!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_5A::
    db $ed, $f9, "0 tried", $f1
    db "to inhale all!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_5B::
    db $ed, $f9, "0 tried", $f1
    db "to sing!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_5C::
    db $ed, $f9, "0 prayed", $f1
    db "to the heavens!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_5D::
    db $ed, $f9, "0 tried", $f1
    db "to shoot water!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_5E::
    db $ed, $f9, "0 called", $f1
    db "for ", $f9, "G!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_5F::
    db $ed, $f9, "0 tried", $f1
    db "blowing ", $f9, "G!", $ec, $f2, $ed, "But it is stopped", $f1
    db "by a prayer!", $ec, $f0

String_2F_00_60::
    db $ed, "You threw in", $f1
    db "the towel!", $ec, $f0

String_2F_00_61::
    db $ed, $f9, "0 turns left!", $f1
    db $ec, $f0

String_2F_00_62::
    db $ed, "No turns left.", $f1
    db "This ends a draw.", $ec, $f0

String_2F_00_63::
    db $ed, "You broke a battle", $f1
    db "rule!", $fa, $f7
    db $f2, "You lose.", $fa, $f7
    db $f0

String_2F_00_64::
    db $ed, "Your opponent", $f1
    db "broke a rule!", $fa, $f7
    db $f2, "You win.", $fa, $f7
    db $f0

String_2F_00_65::
    db $ed, "That skill isn't", $f1
    db "for own use!", $ec, $f0

String_2F_00_66::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "casting a spell!", $f1
    db "But it failed!", $ec, $f0

String_2F_00_67::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "using a skill!", $f1
    db "But it failed!", $ec, $f0

String_2F_00_68::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "to use magic!", $f1
    db "But it failed!", $ec, $f0

String_2F_00_69::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "casting a spell!", $f1
    db "Not enough MP!", $ec, $f0

String_2F_00_6A::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "using a skill!", $f1
    db "Not enough MP!", $ec, $f0

String_2F_00_6B::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "to use magic!", $f1
    db "Not enough MP!", $ec, $f0

String_2F_00_6C::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "Thordain into", $f1
    db "Alldain!", $ec, $f2, $ed, "But spell was", $f1
    db "sealed!", $ec, $f0

String_2F_00_6D::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "Thordain into", $f1
    db "Alldain!", $ec, $f2, $ed, "But the spell was", $f1
    db "shattered!", $ec, $f0

String_2F_00_6E::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "Blazemost and", $f1
    db "Blizzard into", $ec, $f2, $ed, "Blitzer!", $f1
    db "But it was sealed!", $ec, $f0

String_2F_00_6F::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "Blazemost and", $f1
    db "Blizzard into", $ec, $f2, $ed, "Blitzer!", $f1
    db "But it shattered!", $ec, $f0

String_2F_00_70::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "Sacrifice into", $f1
    db "Martyr!", $ec, $f2, $ed, "But spell was", $f1
    db "sealed!", $ec, $f0

String_2F_00_71::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "Sacrifice into", $f1
    db "Martyr!", $ec, $f2, $ed, "But the spell was", $f1
    db "shattered!", $ec, $f0

String_2F_00_72::
    db $ed, $f9, "0 and", $f1
    db $f9, "G let", $ec, $f2, $ed, "loose their entire", $f1
    db "magical power!", $ec, $f2, $ed, "But the spell was", $f1
    db "sealed!", $ec, $f0

String_2F_00_73::
    db $ed, $f9, "0 and", $f1
    db $f9, "G let", $ec, $f2, $ed, "loose their entire", $f1
    db "magical power!", $ec, $f2, $ed, "But the spell was", $f1
    db "shattered!", $ec, $f0

String_2F_00_74::
    db $ed, $f9, "0 and", $f1
    db $f9, "G sang", $ec, $f2, $ed, "and danced to", $f1
    db "summon a spirit!", $ec, $f2, $ed, "But the dance was", $f1
    db "stopped!", $ec, $f0

String_2F_00_75::
    db $ed, $f9, "0 and", $f1
    db $f9, "G sang", $ec, $f2, $ed, "and danced to", $f1
    db "summon death!", $ec, $f2, $ed, "But the dance was", $f1
    db "stopped!", $ec, $f0

String_2F_00_76::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "to turn into a", $f1
    db "huge dragon!", $ec, $f2, $ed, "But the spell was", $f1
    db "sealed!", $ec, $f0

String_2F_00_77::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "to turn into a", $f1
    db "huge dragon!", $ec, $f2, $ed, "But the spell was", $f1
    db "shattered!", $ec, $f0

String_2F_00_78::
    db $ed, $f9, "0 and", $f1
    db $f9, "G created", $ec, $f2, $ed, "a vacuum for", $f1
    db "stealing MP!", $ec, $f2, $ed, "But the spell was", $f1
    db "sealed!", $ec, $f0

String_2F_00_79::
    db $ed, $f9, "0 and", $f1
    db $f9, "G created", $ec, $f2, $ed, "a vacuum for", $f1
    db "stealing MP!", $ec, $f2, $ed, "But the spell was", $f1
    db "shattered!", $ec, $f0

String_2F_00_7A::
    db $ed, $f9, "0 and", $f1
    db $f9, "G danced", $ec, $f2, $ed, "in an alluring", $f1
    db "fashion!", $ec, $f2, $ed, "But the dance was", $f1
    db "stopped!", $ec, $f0

String_2F_00_7B::
    db $ed, $f9, "0 can't", $f1
    db "eat while asleep!", $ec, $f0

String_2F_00_7C::
    db $ed, $f9, "0 can't", $f1
    db "eat while", $ec, $f2, $ed, "paralyzed!", $ec, $f0

String_2F_00_7D::
    db $ed, $f9, "0 is a", $f1
    db "hunk of iron!", $ec, $f0

String_2F_00_7E::
    db $ed, $f9, "0 brushed", $f1
    db "off ", $f9, "W!", $ec, $f0

String_2F_00_7F::
    db $ed, "But there is no", $f1
    db "one to betray!", $f7
    db $f0

String_2F_00_80::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "using a linked", $f1
    db "skill!", $ec, $f2, $ed, "But the skill was", $f1
    db "sealed!", $ec, $f0

String_2F_00_81::
    db $ed, $f9, "0 and", $f1
    db $f9, "G danced ", $ec, $f2, $ed, "in an alluring", $f1
    db "fashion!", $ec, $f2, $ed, "But the spell was", $f1
    db "sealed!", $ec, $f0

String_2F_00_82::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "using a linked", $f1
    db "skill!", $ec, $f2, $ed, "But the dance was", $f1
    db "stopped!", $ec, $f0

String_2F_00_83::
    db $ed, $f9, "0 and", $f1
    db $f9, "G created", $ec, $f2, $ed, "a vacuum for", $f1
    db "stealing MP!", $ec, $f2, $ed, "But the dance was", $f1
    db "stopped!", $ec, $f0

String_2F_00_84::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tried", $ec, $f2, $ed, "using a linked", $f1
    db "skill!", $ec, $f2, $ed, "But the spell was", $f1
    db "shattered!", $ec, $f0

String_2F_00_85::
    db $ed, $f9, "0 and", $f1
    db $f9, "G danced ", $ec, $f2, $ed, "in an alluring", $f1
    db "fashion!", $ec, $f2, $ed, "But the spell was", $f1
    db "shattered!", $ec, $f0

String_2F_00_86::
    db "Monster was", $f1
    db "defeated!", $e4, $7e, $fa, $f7
    db $f0

String_2F_00_87::
    db $ed, $f9, "0's party", $f1
    db "was wiped out!", $e5, "'v", $f0

String_2F_00_88::
    db $ed, $f9, "0 turn left!", $f1
    db $ec, $f0

String_2F_01_00::
    db $ed, $f9, "0", $f1
    db "attacked!", $ec, $f0

String_2F_01_01::
    db $ed, $f9, "0 cast", $f1
    db $f9, "G!", $ec, $f0

String_2F_01_02::
    db $ed, $f9, "0 loosed", $f1
    db $f9, "G!", $ec, $f0

String_2F_01_03::
    db $ed, $f9, "0 blew", $f1
    db $f9, "G!", $ec, $f0

String_2F_01_04::
    db $ed, $f9, "0 danced", $f1
    db "the ", $f9, "G!", $ec, $f0

String_2F_01_05::
    db $ed, $f9, "G shot", $f1
    db "from ", $f9, "0!", $ec, $f0

String_2F_01_06::
    db $ed, $f9, "0 closed", $f1
    db "in on ", $f9, "G!", $ec, $f0

String_2F_01_07::
    db $ed, $f9, "0 charged", $f1
    db "at ", $f9, "G!", $ec, $f0

String_2F_01_08::
    db $ed, $f9, "0 charged", $f1
    db "receklessly!", $ec, $f0

String_2F_01_09::
    db $ed, $f9, "0 dove at", $f1
    db $f9, "G!", $ec, $f0

String_2F_01_0A::
    db $ed, $f9, "0 flailed", $f1
    db "at ", $f9, "G!", $ec, $f0

String_2F_01_0B::
    db $ed, $f9, "0 smashed", $f1
    db $f9, "G!", $ec, $f0

String_2F_01_0C::
    db $ed, $f9, "0 leapt", $f1
    db "high!", $ec, $f0

String_2F_01_0D::
    db $ed, $f9, "0 fell", $f1
    db "out of the sky!", $ec, $f0

String_2F_01_0E::
    db $ed, $f9, "0 inhaled", $f1
    db "deeply!", $ec, $f0

String_2F_01_0F::
    db $ed, $f9, "G prayed", $f1
    db "to the wind!", $ec, $f2, $ed, "Blades of air", $f1
    db "slash out!", $ec, $f0

String_2F_01_10::
    db $ed, $f9, "0 yelled", $f1
    db "for help!", $ec, $f0

String_2F_01_11::
    db $ed, $f9, "0 called", $f1
    db "for help!", $ec, $f0

String_2F_01_12::
    db $ed, $f9, "0", $f1
    db "concentrated!", $ec, $f0

String_2F_01_13::
    db $ed, $f9, "0 struck", $f1
    db "like the wind!", $ec, $f0

String_2F_01_14::
    db $ed, $f9, "0 struck", $f1
    db "mightily!", $ec, $f0

String_2F_01_15::
    db $ed, $f9, "0 whipped", $f1
    db "up vicious winds!", $ec, $f0

String_2F_01_16::
    db $ed, $f9, "0 brought", $f1
    db "lightning forth!", $ec, $f0

String_2F_01_17::
    db $ed, $f9, "0 hurled", $f1
    db "huge boulders!", $ec, $f0

String_2F_01_18::
    db $ed, $f9, "0 brought", $f1
    db "on an evil light!", $ec, $f2, $ed, "Thunderbolts", $f1
    db "hammered down!", $ec, $f0

String_2F_01_19::
    db $ed, $f9, "0 set off", $f1
    db "a BigBang!", $ec, $f2, $ed, "Wild explosions", $f1
    db "echoed repeatedly!", $ec, $f0

String_2F_01_1A::
    db $ed, $f9, "0 loosed", $f1
    db "all magic power!", $ec, $f2, $ed, "It set off a", $f1
    db "wicked explosion!", $ec, $f0

String_2F_01_1B::
    db $ed, $f9, "0 uttered", $f1
    db "a curse!", $ec, $f0

String_2F_01_1C::
    db $ed, $f9, "0 kicked", $f1
    db "up a sandstorm!", $ec, $f0

String_2F_01_1D::
    db $ed, $f9, "0 did an", $f1
    db "odd dance step!", $ec, $f0

String_2F_01_1E::
    db $ed, $f9, "0 gave a", $f1
    db "powderpuff massage", $ec, $f2, $ed, "to ", $f9, "G!", $f1
    db $ec, $f0

String_2F_01_1F::
    db $ed, $f9, "0 licked", $f1
    db $f9, "G's face!", $ec, $f0

String_2F_01_20::
    db $ed, $f9, "0 kicked", $f1
    db $f9, "G low!", $ec, $f0

String_2F_01_21::
    db $ed, $f9, "G did a", $f1
    db "sweeping kick!", $ec, $f0

String_2F_01_22::
    db $ed, $f9, "0 loosed", $f1
    db "a savage roar!", $ec, $f0

String_2F_01_23::
    db $ed, $f9, "0 prayed", $f1
    db "to the earth!", $ec, $f0

String_2F_01_24::
    db $ed, $f9, "0 whipped", $f1
    db "up ", $f9, "G!", $ec, $f0

String_2F_01_25::
    db $ed, $f9, "0 quieted", $f1
    db $f9, "G!", $ec, $f0

String_2F_01_26::
    db $ed, $f9, "0 began", $f1
    db "to meditate!", $ec, $f2, $ed, $f9, "0's", $f1
    db "wounds healed!", $ec, $f0

String_2F_01_27::
    db $ed, $f9, "0 began", $f1
    db "singing!", $ec, $f0

String_2F_01_28::
    db $ed, $f9, "0's song", $f1
    db "ended!", $ec, $f0

String_2F_01_29::
    db $ed, $f9, "0 raised", $f1
    db "a water barrier!", $ec, $f0

String_2F_01_2A::
    db $ed, $f9, "0 is", $f1
    db "guarding itself!", $ec, $f0

String_2F_01_2B::
    db $ed, $f9, "0 shields", $f1
    db $f9, "G!", $ec, $f0

String_2F_01_2C::
    db $ed, $f9, "0 is", $f1
    db "braced for attack!", $ec, $f0

String_2F_01_2D::
    db $ed, $f9, "0 is", $f1
    db "ready to parry!", $ec, $f0

String_2F_01_2E::
    db $ed, $f9, "0 is in a", $f1
    db "defensive pose!", $ec, $f0

String_2F_01_2F::
    db $ed, $f9, "0 looks", $f1
    db "for payback!", $ec, $f0

String_2F_01_30::
    db $ed, $f9, "0 is set", $f1
    db "to inhale all!", $ec, $f0

String_2F_01_31::
    db $ed, $f9, "0 prayed", $f1
    db "to the heavens!", $ec, $f0

String_2F_01_32::
    db $ed, $f9, "0 prayed", $f1
    db "for silence!", $ec, $f2, $ed, "An invisible force", $f1
    db "pressed down!", $ec, $f0

String_2F_01_33::
    db $ed, $f9, "0 shot", $f1
    db "water!", $ec, $f0

String_2F_01_34::
    db $ed, $f9, "0 created", $f1
    db "a huge tidal wave!", $ec, $f0

String_2F_01_35::
    db $ed, $f9, "0 took", $f1
    db $f9, "G damage!", $ec, $f0

String_2F_01_36::
    db $ed, $f9, "0 took", $f1
    db $f9, "G damage!", $ec, $f0

String_2F_01_37::
    db $ed, $f9, "0's wound", $f1
    db "was healed!", $ec, $f0

String_2F_01_38::
    db $ed, $f9, "0 was", $f1
    db "brutalized!", $ec, $f0

String_2F_01_39::
    db $ed, $f9, "0's DEF", $f1
    db "fell by ", $f9, "G!", $ec, $f0

String_2F_01_3A::
    db $ed, $f9, "0's DEF", $f1
    db "fell by ", $f9, "G!", $ec, $f0

String_2F_01_3B::
    db $ed, $f9, "0 can't", $f1
    db "use spells now!", $ec, $f0

String_2F_01_3C::
    db $ed, $f9, "0's spells", $f1
    db "were sealed!", $ec, $f0

String_2F_01_3D::
    db $ed, $f9, "0 was", $f1
    db "stripped of ", $f9, "GMP!", $ec, $f0

String_2F_01_3E::
    db $ed, $f9, "0 was", $f1
    db "stripped of ", $f9, "GMP!", $ec, $f0

String_2F_01_3F::
    db $ed, $f9, "0 started", $f1
    db "glowing!", $ec, $f0

String_2F_01_40::
    db $ed, $f9, "0 stole", $f1
    db $f9, "GMP!", $ec, $f0

String_2F_01_41::
    db $ed, $f9, "0 became", $f1
    db "befuddled!", $ec, $f0

String_2F_01_42::
    db $ed, $f9, "0 became", $f1
    db "confused!", $ec, $f0

String_2F_01_43::
    db $ed, $f9, "0's ATK", $f1
    db "doubled!", $ec, $f0

String_2F_01_44::
    db $ed, $f9, "0 turned", $f1
    db "into a dragon!", $ec, $f0

String_2F_01_45::
    db $ed, $f9, "0's DEF", $f1
    db "rose by ", $f9, "G!", $ec, $f0

String_2F_01_46::
    db $ed, $f9, "0's party", $f1
    db "turned into iron!", $ec, $f0

String_2F_01_47::
    db $ed, $f9, "0 turned", $f1
    db "into iron!", $ec, $f0

String_2F_01_48::
    db $ed, $f9, "0's AGL", $f1
    db "was cut by ", $f9, "G!", $ec, $f0

String_2F_01_49::
    db $ed, $f9, "0's AGL", $f1
    db "rose by ", $f9, "G!", $ec, $f0

String_2F_01_4A::
    db $ed, $f9, "0 is lost", $f1
    db "in a daze!", $ec, $f0

String_2F_01_4B::
    db $ed, "A veil of light", $f1
    db "formed before", $ec, $f2, $ed, $f9, "0!", $f1
    db $ec, $f0

String_2F_01_4C::
    db $ed, "A veil of light", $f1
    db "formed before", $ec, $f2, $ed, $f9, "0!", $f1
    db $ec, $f0

String_2F_01_4D::
    db $ed, "A barrier of", $f1
    db "light appeared.", $ec, $f0

String_2F_01_4E::
    db $ed, $f9, "0 was", $f1
    db "cured of poison.", $ec, $f0

String_2F_01_4F::
    db $ed, $f9, "0 is no", $f1
    db "longer paralyzed.", $ec, $f0

String_2F_01_50::
    db $ed, $f9, "0 came", $f1
    db "back to life!", $ec, $f0

String_2F_01_51::
    db $ed, $f9, "0 was", $f1
    db "uncursed!", $ec, $f0

String_2F_01_52::
    db $ed, $f9, "0 assumed", $f1
    db $f9, "G's form!", $ec, $f0

String_2F_01_53::
    db $ed, "Help arrived from", $f1
    db "seemingly nowhere!", $ec, $f0

String_2F_01_54::
    db $ed, $f9, "0 was", $f1
    db "blinded by sand!", $ec, $f0

String_2F_01_55::
    db $ed, $f9, "0's vision", $f1
    db "was harmed!", $ec, $f0

String_2F_01_56::
    db $ed, $f9, "0 was", $f1
    db "weakened to magic!", $ec, $f0

String_2F_01_57::
    db $ed, $f9, "0 lost", $f1
    db $f9, "GMP!", $ec, $f0

String_2F_01_58::
    db $ed, $f9, "0 joined", $f1
    db "the dancing!", $ec, $f0

String_2F_01_59::
    db $ed, $f9, "0 looks", $f1
    db "content!", $ec, $f0

String_2F_01_5A::
    db $ed, $f9, "0 got", $f1
    db "goose bumps!", $ec, $f0

String_2F_01_5B::
    db $ed, $f9, "0 got", $f1
    db "goose bumps!", $ec, $f2, $ed, $f9, "0's DEF", $f1
    db "dropped to '1'!", $ec, $f0

String_2F_01_5C::
    db $ed, $f9, "0 was", $f1
    db "shocked!", $ec, $f0

String_2F_01_5D::
    db $ed, $f9, "0 wiped", $f1
    db "out!", $ec, $f0

String_2F_01_5E::
    db $ed, $f9, "0 lost", $f1
    db "all applied magic!", $ec, $f0

String_2F_01_5F::
    db $ed, $f9, "0 turned", $f1
    db "back to normal!", $ec, $f0

String_2F_01_60::
    db $ed, $f9, "0 was", $f1
    db "fully cured!", $ec, $f0

String_2F_01_61::
    db $ed, $f9, "0 joined", $f1
    db "the battle!", $ec, $f0

String_2F_01_62::
    db $ed, $f9, "0 can't", $f1
    db "dance anymore!", $ec, $f0

String_2F_01_63::
    db $ed, $f9, "0 can't", $f1
    db "dance anymore!", $ec, $f0

String_2F_01_64::
    db $ed, $f9, "0's mouth", $f1
    db "was sealed!", $ec, $f0

String_2F_01_65::
    db $ed, $f9, "0's mouth", $f1
    db "was sealed!", $ec, $f0

String_2F_01_66::
    db $ed, $f9, "0 is a", $f1
    db "hunk of iron!", $ec, $f0

String_2F_01_67::
    db $ed, $f9, "0 did not", $f1
    db "come back to life!", $ec, $f0

String_2F_01_68::
    db $ed, "But it failed to", $f1
    db "reach ", $f9, "0!", $ec, $f0

String_2F_01_69::
    db $ed, "But the call went", $f1
    db "unheard!", $ec, $f0

String_2F_01_6A::
    db $ed, $f9, "0 dodged", $f1
    db "the breath!", $ec, $f0

String_2F_01_6B::
    db $ed, $f9, "0 quickly", $f1
    db "covered its ears!", $ec, $f0

String_2F_01_6C::
    db $ed, $f9, "0 shook", $f1
    db "off the sand!", $ec, $f0

String_2F_01_6D::
    db $ed, $f9, "0 closed", $f1
    db "its eyes in time!", $ec, $f0

String_2F_01_6E::
    db $ed, $f9, "0 quickly", $f1
    db "dodged the attack!", $ec, $f0

String_2F_01_6F::
    db $ed, $f9, "0 wasn't", $f1
    db "taken in!", $ec, $f0

String_2F_01_70::
    db $ed, $f9, "0 slid", $f1
    db "out of the way!", $ec, $f0

String_2F_01_71::
    db $ed, $f9, "0 was", $f1
    db "unharmed!", $ec, $f0

String_2F_01_72::
    db $ed, "But the prayer", $f1
    db "went unanswered!", $ec, $f0

String_2F_01_73::
    db $ed, $f9, "0 was put", $f1
    db "to sleep!", $ec, $f0

String_2F_01_74::
    db $ed, $f9, "0 fell", $f1
    db "asleep!", $ec, $f0

String_2F_01_75::
    db $ed, $f9, "0 was", $f1
    db "poisoned!", $ec, $f0

String_2F_01_76::
    db $ed, $f9, "0 became", $f1
    db "paralyzed!", $ec, $f0

String_2F_01_77::
    db $ed, $f9, "0 was", $f1
    db "terribly poisoned!", $ec, $f0

String_2F_01_78::
    db $ed, $f9, "0 froze", $f1
    db "solid!", $ec, $f0

String_2F_01_79::
    db $ed, $f9, "0 became", $f1
    db "frozen solid!", $ec, $f0

String_2F_01_7A::
    db $ed, $f9, "0 struck", $f1
    db "back!", $ec, $f0

String_2F_01_7B::
    db $ed, $f9, "0 couldn't", $f1
    db "strike back!", $ec, $f0

String_2F_01_7C::
    db $ed, $f9, "0's", $f1
    db "counterstrike!", $ec, $f0

String_2F_01_7D::
    db $ed, $f9, "0 couldn't", $f1
    db "retaliate!", $ec, $f0

String_2F_01_7E::
    db $ed, $f9, "0 blew", $f1
    db "back ", $f9, "G!", $ec, $f0

String_2F_01_7F::
    db $ed, $f9, "0 went", $f1
    db "away!", $ec, $f0

String_2F_01_80::
    db $ed, "The wind around", $f1
    db $f9, "0 died!", $ec, $f0

String_2F_01_81::
    db $ed, "The help went", $f1
    db "away!", $ec, $f0

String_2F_01_82::
    db $ed, $f9, "0", $f1
    db "woke up!", $ec, $f0

String_2F_01_83::
    db $ed, $f9, "0 snapped", $f1
    db "out of confusion!", $ec, $f0

String_2F_01_84::
    db $ed, $f9, "0's", $f1
    db "Ironize wore off!", $ec, $f0

String_2F_01_85::
    db $ed, $f9, "0's wall", $f1
    db "of light faded!", $ec, $f0

String_2F_01_86::
    db $ed, "The giant went", $f1
    db "away laughing!", $ec, $f0

String_2F_01_87::
    db $ed, "The ", $f9, "W", $f1
    db "shattered!", $ec, $f0

String_2F_01_88::
    db $ed, $f9, "0 suffers", $f1
    db "from poison!", $ec, $f2, $ed, $f9, "0 lost", $f1
    db $f9, "GHP!", $ec, $f0

String_2F_01_89::
    db $ed, $f9, "0 is", $f1
    db "wracked by poison!", $ec, $f2, $ed, $f9, "0 lost", $f1
    db $f9, "GHP!", $ec, $f0

String_2F_01_8A::
    db $ed, $f9, "0 died!", $f1
    db $ec, $f0

String_2F_01_8B::
    db $ed, $f9, "0 was", $f1
    db "defeated!", $ec, $f0

String_2F_01_8C::
    db $ed, $f9, "0 died", $f1
    db "from dancing!", $ec, $f0

String_2F_01_8D::
    db $ed, $f9, "0 dropped", $f1
    db "dead!", $ec, $f0

String_2F_01_8E::
    db $ed, $f9, "0 was", $f1
    db "instantly slain!", $ec, $f0

String_2F_01_8F::
    db $ed, "The ", $f9, "0", $f1
    db "shattered!", $ec, $f0

String_2F_01_90::
    db $ed, $f9, "0 dropped", $f1
    db "dead!", $ec, $f0

String_2F_01_91::
    db $ed, $f9, "0's prayer", $f1
    db "went unanswered!", $ec, $f0

String_2F_01_92::
    db $ed, "SealPray was", $f1
    db "broken!", $ec, $f0

String_2F_01_93::
    db $ed, $f9, "0 became", $f1
    db "flush with power!", $ec, $f0

String_2F_01_94::
    db $ed, $f9, "0 took", $f1
    db "the ", $f9, "W from", $ec, $f2, $ed, $f9, "G.", $f1
    db $ec, $f0

String_2F_01_95::
    db $ed, $f9, "0 ate the", $f1
    db "meat happily!", $ec, $f2, $ed, $f9, "0 grew to", $f1
    db "like ", $f9, "G!", $ec, $f0

String_2F_01_96::
    db $ed, $f9, "0 ate the", $f1
    db "meat fearfully!", $ec, $f2, $ed, $f9, "0 glared", $f1
    db "at ", $f9, "G!", $ec, $f0

String_2F_01_97::
    db $ed, $f9, "0 held the", $f1
    db $f9, "W aloft!", $ec, $f0

String_2F_01_98::
    db $ed, "A warm light shone", $f1
    db "from the Orb!", $ec, $f0

String_2F_01_99::
    db $ed, $f9, "0 gripped", $f1
    db "the BeastTail!", $ec, $f0

String_2F_01_9A::
    db $ed, "The BeastTail", $f1
    db "began pointing!", $ec, $f0

String_2F_01_9B::
    db $ed, $f9, "0 held", $f1
    db $f9, "W aloft!", $ec, $f0

String_2F_01_9C::
    db $ed, "Critical hit!", $f1
    db $ec, $f0

String_2F_01_9D::
    db $ed, "A brutal hit!", $f1
    db $ec, $f0

String_2F_01_9E::
    db $ed, $f9, "0's", $f1
    db "spells, dances", $ec, $f2, $ed, "and breaths are", $f1
    db "sealed!", $ec, $f0

String_2F_01_9F::
    db $ed, $f9, "0 used", $f1
    db "the ", $f9, "W!", $ec, $f0

String_2F_01_A0::
    db $ed, $f9, "0 tossed", $f1
    db "the ", $f9, "W", $ec, $f2, $ed, "at ", $f9, "G!", $f1
    db $ec, $f0

String_2F_01_A1::
    db $ed, $f9, "0 held aloft", $f1
    db "the SageRock!", $ec, $f0

String_2F_01_A2::
    db $ed, $f9, "0 scattered", $f1
    db "the WorldDew!", $ec, $f0

String_2F_01_A3::
    db $ed, $f9, "0 held aloft", $f1
    db "the ", $f9, "W!", $ec, $f2, $ed, "Bolts of lightning", $f1
    db "lashed out!", $ec, $f0

String_2F_01_A4::
    db $ed, $f9, "0 held aloft", $f1
    db "the ", $f9, "W!", $ec, $f2, $ed, "Tornadoes leapt", $f1
    db "from its tip!", $ec, $f0

String_2F_01_A5::
    db $ed, $f9, "0 held aloft", $f1
    db "the ", $f9, "W!", $ec, $f2, $ed, "A sinister fog", $f1
    db "descended!", $ec, $f0

String_2F_01_A6::
    db $ed, $f9, "0 held aloft", $f1
    db "the ", $f9, "W!", $ec, $f2, $ed, "A blizzard howls", $f1
    db "from its tip!", $ec, $f0

String_2F_01_A7::
    db $ed, $f9, "0 held aloft", $f1
    db "the ", $f9, "W!", $ec, $f2, $ed, "Flames leapt from", $f1
    db "its tip!", $ec, $f0

String_2F_01_A8::
    db $ed, $f9, "0 set off", $f1
    db "a towering geyser!", $ec, $f0

String_2F_01_A9::
    db $ed, $f9, "0 fell", $f1
    db "out of the sky!", $ec, $f0

String_2F_01_AA::
    db $ed, $f9, "0 and", $f1
    db $f9, "G are", $ec, $f2, $ed, "looking for a", $f1
    db "chance!", $ec, $f0

String_2F_01_AB::
    db $ed, $f9, "0 and", $f1
    db $f9, "G danced", $ec, $f2, $ed, "in an alluring", $f1
    db "fashion!", $ec, $f0

String_2F_01_AC::
    db $ed, "The barrier popped", $f1
    db "and disappeared!", $ec, $f0

String_2F_01_AD::
    db $ed, $f9, "0 landed", $f1
    db "awkwardly!", $ec, $f2, $ed, $f9, "0 took", $f1
    db $f9, "G damage!", $ec, $f0

String_2F_01_AE::
    db $ed, $f9, "0 landed", $f1
    db "awkwardly!", $ec, $f2, $ed, $f9, "0 took", $f1
    db $f9, "G damage!", $ec, $f0

String_2F_01_AF::
    db $ed, $f9, "0", $f1
    db "landed safely!", $ec, $f0

String_2F_01_B0::
    db $ed, $f9, "G was", $f1
    db "shattered!", $ec, $f0

String_2F_01_B1::
    db $ed, $f9, "0 shook", $f1
    db "off ", $f9, "G!", $ec, $f0

String_2F_01_B2::
    db $ed, $f9, "0 and", $f1
    db $f9, "G are", $ec, $f2, $ed, "shielding a", $f1
    db "partner!", $ec, $f0

String_2F_01_B3::
    db $ed, $f9, "0's MP was", $f1
    db "restored by ", $f9, "G!", $ec, $f0

String_2F_01_B4::
    db $ed, $f9, "0 and", $f1
    db $f9, "G began", $ec, $f2, $ed, "to concentrate!", $f1
    db $ec, $f0

String_2F_01_B5::
    db $ed, "But ", $f9, "0 was", $f1
    db "unaffected!", $ec, $f0

String_2F_01_B6::
    db $ed, $f9, "0 took a", $f1
    db "wild swing!", $ec, $f2, $ed, "And managed to", $f1
    db "hurt only itself!", $ec, $f0

String_2F_01_B7::
    db $ed, $f9, "0 is", $f1
    db "shaking in fear!", $ec, $f0

String_2F_01_B8::
    db $ed, $f9, "0 charged", $f1
    db "at ", $f9, "G!", $ec, $f2, $ed, "But tripped and", $f1
    db "wiped out!", $ec, $f0

String_2F_01_B9::
    db $ed, $f9, "0 became", $f1
    db "paralyzed!", $ec, $f0

String_2F_01_BA::
    db $ed, $f9, "0's", $f1
    db "attack!", $ec, $f2, $ed, "It appears unable", $f1
    db "to move properly.", $ec, $f0

String_2F_01_BB::
    db $ed, $f9, "0 began", $f1
    db "dancing!", $ec, $f0

String_2F_01_BC::
    db $ed, "A foul being was", $f1
    db "summoned!", $ec, $f0

String_2F_01_BD::
    db $ed, $f9, "0 let off", $f1
    db "a black cloud!", $ec, $f0

String_2F_01_BE::
    db $ed, $f9, "0", $f1
    db "filled with power!", $ec, $f0

String_2F_01_BF::
    db $ed, $f9, "0 lost", $f1
    db "all its MP!", $ec, $f0

String_2F_01_C0::
    db $ed, $aa, "Chance, Chance,", $f1
    db "Chance", $a4, $aa, $ec, $f2, $ed, "The call echoed", $f1
    db "over and over!", $ec, $f0

String_2F_01_C1::
    db $ed, "A laughng giant", $f1
    db "appeared!", $ec, $f2, $ed, "The giant", $f1
    db "attacked!", $ec, $f0

String_2F_01_C2::
    db $ed, "A cold wind swept", $f1
    db $f9, "0's party!", $ec, $f0

String_2F_01_C3::
    db $ed, $f9, "0's MP", $f1
    db "was restored!", $ec, $f0

String_2F_01_C4::
    db $ed, "Meteors rained", $f1
    db "from the heavens!", $ec, $f0

String_2F_01_C5::
    db $ed, "The wall of light", $f1
    db "bounced the spell!", $ec, $f0

String_2F_01_C6::
    db $ed, "The wall of light", $f1
    db "bounced the spell!", $ec, $f0

String_2F_01_C7::
    db $ed, "The wind around", $f1
    db $f9, "0 bounced", $ec, $f2, $ed, "the attack!", $f1
    db $ec, $f0

String_2F_01_C8::
    db $ed, $f9, "0 shunted", $f1
    db "the attack!", $ec, $f0

String_2F_01_C9::
    db $ed, $f9, "0 failed", $f1
    db "to avert attack!", $ec, $f0

String_2F_01_CA::
    db $ed, $f9, "0 guarded", $f1
    db $f9, "G!", $ec, $f0

String_2F_01_CB::
    db $ed, $f9, "0 inhaled", $f1
    db "the attack!", $ec, $f0

String_2F_01_CC::
    db $ed, "But nothing", $f1
    db "happened!", $ec, $f0

String_2F_01_CD::
    db $ed, $f9, "0's AGL", $f1
    db "fell by ", $f9, "G!", $ec, $f0

String_2F_01_CE::
    db $ed, $f9, "0 didn't", $f1
    db "fall asleep!", $ec, $f0

String_2F_01_CF::
    db $ed, $f9, "0 became", $f1
    db "more confused!", $ec, $f0

String_2F_01_D0::
    db $ed, "Miss! ", $f9, "0", $f1
    db "was unharmed!", $ec, $f0

String_2F_01_D1::
    db $ed, "Miss! ", $f9, "0", $f1
    db "avoided damage!", $ec, $f0

String_2F_01_D2::
    db $ed, $f9, "0 leapt", $f1
    db "out of the way!", $ec, $f0

String_2F_01_D3::
    db $ed, $f9, "0 dropped", $f1
    db "dead!", $ec, $f0, "leapt "

String_2F_01_D4::
    db $ed, $f9, "0 is", $f1
    db "already asleep!", $ec, $f0

String_2F_01_D5::
    db $ed, $f9, "0 is now", $f1
    db "weak to spells!", $ec, $f0

String_2F_01_D6::
    db $ed, "A gentle rain", $f1
    db "fell!", $ec, $f0

String_2F_01_D7::
    db $ed, $f9, "0 has", $f1
    db "been immobilized!", $ec, $f0

String_2F_01_D8::
    db $ed, $f9, "0 fled!", $f1
    db $ec, $f0

String_2F_01_D9::
    db $ed, $f9, "0 was", $f1
    db "cursed!", $ec, $f0

String_2F_01_DA::
    db $ed, $f9, "0 is", $f1
    db "building power!", $ec, $f0

String_2F_01_DB::
    db $ed, $f9, "0 lost", $f1
    db "all applied magic!", $ec, $f0

String_2F_01_DC::
    db $ed, $f9, "0 gave a", $f1
    db "powderpuff massage", $ec, $f2, $ed, "to ", $f9, "G!", $f1
    db $ec, $f0

String_2F_01_DD::
    db $ed, $f9, "0 was", $f1
    db "blown sky-high!", $ec, $f0

String_2F_01_DE::
    db $ed, $f9, "0 can't", $f1
    db "dance anymore!", $ec, $f0

String_2F_01_DF::
    db $ed, $f9, "0 lost", $f1
    db "its MP!", $ec, $f0

String_2F_01_E0::
    db $ed, $f9, "0 looks", $f1
    db "vacant and lost!", $ec, $f0

String_2F_01_E1::
    db $ed, $f9, "0 is", $f1
    db "guarding itself!", $ec, $f0

String_2F_01_E2::
    db $ed, $f9, "0 got", $f1
    db "dizzy and fell!", $ec, $f0

String_2F_01_E3::
    db $ed, $f9, "0 lost", $f1
    db "balance and fell!", $ec, $f0

String_2F_01_E4::
    db $ed, $f9, "0 dropped", $f1
    db "down, asleep!", $ec, $f0

String_2F_01_E5::
    db $ed, $f9, "0 fell", $f1
    db "and woke up!", $ec, $f0

String_2F_01_E6::
    db $ed, $f9, "0 can't", $f1
    db "eat while", $ec, $f2, $ed, "paralyzed!", $ec, $f0

String_2F_01_E7::
    db $ed, "The wind around", $f1
    db $f9, "0 died!", $ec, $f0

String_2F_01_E8::
    db $ed, $f9, "0's wall", $f1
    db "of light faded!", $ec, $f0

String_2F_01_E9::
    db $ed, $f9, "0's water", $f1
    db "barrier reacted!", $ec, $f0

String_2F_01_EA::
    db $ed, $f9, "0's water", $f1
    db "barrier reacted!", $ec, $f0

String_2F_01_EB::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "Thordain into", $f1
    db "Alldain!", $ec, $f0

String_2F_01_EC::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "BlazeMost and", $f1
    db "Blizzard into", $ec, $f2, $ed, "Blitzer!", $f1
    db $ec, $f0

String_2F_01_ED::
    db $ed, $f9, "0 and", $f1
    db $f9, "G blasted", $ec, $f2, $ed, "a Tidalwave with", $f1
    db "shockwaves to make", $ec, $f2, $ed, "WaveBlast!", $f1
    db $ec, $f0

String_2F_01_EE::
    db $ed, $f9, "0 and", $f1
    db $f9, "G tore", $ec, $f2, $ed, "tornadoes with", $f1
    db "shockwaves to", $ec, $f2, $ed, "loose RageAir!", $f1
    db $ec, $f0

String_2F_01_EF::
    db $ed, $f9, "0 and", $f1
    db $f9, "G rocked", $ec, $f2, $ed, "the ground with", $f1
    db "shockwaves to", $ec, $f2, $ed, "loose RageQuake!", $f1
    db $ec, $f0

String_2F_01_F0::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "two GigaSlashes", $f1
    db "into GigaBreak!", $ec, $f0

String_2F_01_F1::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "two Sacrifices", $f1
    db "into Martyr!", $ec, $f0

String_2F_01_F2::
    db $ed, $f9, "0 and", $f1
    db $f9, "G hurled", $ec, $f2, $ed, $f9, "W high", $f1
    db "and dropped it!", $ec, $f0

String_2F_01_F3::
    db $ed, $f9, "0 and", $f1
    db $f9, "G made", $ec, $f2, $ed, "SquallHit faster", $f1
    db "using SpeedUp!", $ec, $f0

String_2F_01_F4::
    db $ed, $f9, "0 and", $f1
    db $f9, "G let", $ec, $f2, $ed, "loose their entire", $f1
    db "magical power!", $ec, $f2, $ed, "It set off a", $f1
    db "wicked explosion!", $ec, $f0

String_2F_01_F5::
    db $ed, $f9, "0 and", $f1
    db $f9, "G sang", $ec, $f2, $ed, "and danced to", $f1
    db "summon a spirit!", $ec, $f0

String_2F_01_F6::
    db $ed, $f9, "0 and", $f1
    db $f9, "G sang", $ec, $f2, $ed, "and danced to", $f1
    db "summon death!", $ec, $f0

String_2F_01_F7::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "into a huge", $f1
    db "dragon!", $ec, $f0

String_2F_01_F8::
    db $ed, $f9, "0 and", $f1
    db $f9, "G turned", $ec, $f2, $ed, "their skills into", $f1
    db "a wave of energy!", $ec, $f0

String_2F_01_F9::
    db $ed, $f9, "0 and", $f1
    db $f9, "G loosed", $ec, $f2, $ed, "a white, obscuring", $f1
    db "cloud!", $ec, $f0

String_2F_01_FA::
    db $ed, $f9, "0 and", $f1
    db $f9, "G created", $ec, $f2, "a vacuum for", $f1
    db "stealing MP!", $ec, $f0

String_2F_01_FB::
    db $ed, "Critical hit!", $f1
    db $ec, $f0

String_2F_01_FC::
    db $ed, "A brutal hit!", $f1
    db $ec, $f0

String_2F_01_FD::
    db $ed, $ed, "The monsters ate", $f1
    db "the meat happily!", $ec, $f2, $ed, "The monsters grew", $f1
    db "to like ", $f9, "G!", $ec, $f0

String_2F_01_FE::
    db $ed, "Monsters ate the", $f1
    db "meat fearfully!", $ec, $f2, $ed, "Monsters glared", $f1
    db "at ", $f9, "G!", $ec, $f0

String_2F_01_FF::
    db $ed, "Monsters were", $f1
    db "filled with power!", $ec, $f0

String_2F_02_00::
    db "Fixed", $f0

String_2F_02_01::
    db "Auto", $f0

String_2F_02_02::
    db "Fixed", $f0

String_2F_02_03::
    db "Auto", $f0

String_2F_03_00::
    db "Undefined", $f0

String_2F_05_00::
    db $ef, $ee, $f6, "'s party got", $ef, $ee, $f9, "0 EX points!", $fa, $f7
    db $f0

String_2F_05_01::
    db $e5, "0", $ed, $f9, "0 was", $f1
    db "promoted to Lv", $f9, "G!", $e5, $50, $fa, $f7
    db $f2, $ed, $f9, "0", $e8, "60Max. HP ", $a2, $f9, "W", $e8, "01Lv", $f9, "G", $e8, "61Max. MP ", $a2, $f9
    db "a", $fa, $f7
    db $f2, $ed, $f9, "0", $e8, "60ATK ", $a2, $f9, "e", $e8, "01Lv", $f9, "G", $e8, "61DEF ", $a2, $f9, "i", $fa, $f7
    db $f2, $ed, $f9, "0", $e8, "60AGL ", $a2, $f9, "m", $e8, "01Lv", $f9, "G", $e8, "61INT ", $a2, $f9, "q", $fa, $f7
    db $f0

String_2F_05_02::
    db $ed, "At Lv", $f9, "G, ", $f9, "0 ", $f1
    db "learned ", $f9, "W!", $fa, $f7
    db $f0

String_2F_05_04::
    db $ed, $f9, "0's ", $f9, "m", $f1
    db "became ", $f9, "W!", $fa, $f7
    db $f0

String_2F_05_05::
    db $ed, $f9, "0 devised", $f1
    db $f9, "W from the", $fa, $f7
    db $f2, $ed, "skills it knows!", $fa, $f7
    db $f0

String_2F_05_06::
    db $ed, "But ", $f9, "0 can't", $f1
    db "learn more skills!", $fa, $f7
    db $f2, $ed, "Which skill should", $f1
    db "be forgotten?", $fa, $f7
    db $f0

String_2F_05_07::
    db $ed, "Which skill should", $f1
    db "be forgotten?", $fa, $f7
    db $f0

String_2F_05_08::
    db $ed, "Forget ", $f9, "W?", $f1
    db "Are you sure?", $f0

String_2F_05_09::
    db $ed, $f9, "W was", $f1
    db "forgottten.", $fa, $f7
    db $f0

String_2F_05_0A::
    db $ed, "It has reached the", $f1
    db "limit for growth.", $fa, $f7
    db $f0

String_2F_05_0B::
    db $ed, $f9, "0 got up,", $f1
    db "looking hopeful.", $fa, $f7
    db $f2, $ed, "Allow ", $f9, "0 ", $f1
    db "to join you?", $f0

String_2F_05_0C::
    db $ed, $f9, "0", $f1
    db "departed sadly", $a4, $fa, $f7
    db $f0

String_2F_05_0D::
    db $ed, "But there is no", $f1
    db "more room!", $fa, $f7
    db $f2, $ed, "Release a monster", $f1
    db "to make room?", $f0

String_2F_05_0E::
    db $ed, "Which will you", $f1
    db "choose?", $f0

String_2F_05_0F::
    db $ed, "You have no eggs.", $fa, $f7
    db $f0

String_2F_05_10::
    db $ed, "Release a monster", $f1
    db "for the new one?", $f0

String_2F_05_11::
    db $ed, "Choose a monster", $f1
    db "to release.", $f0

String_2F_05_12::
    db $ed, "Do you want to", $f1
    db "release ", $f9, "G?", $f0

String_2F_05_13::
    db $ed, $f9, "G was set", $f1
    db "free in the wild.", $fa, $f7
    db $f0

String_2F_05_14::
    db $ed, "Please name", $f1
    db $f9, "0.", $fa, $f7
    db $f0

String_2F_05_15::
    db $ed, "You can't travel", $f1
    db "all alone.", $fa, $f7
    db $f0

String_2F_05_16::
    db $ed, "Choose an egg to", $f1
    db "abandon.", $f0

String_2F_05_17::
    db $ed, "Abandon ", $f9, "G's", $f1
    db "egg?", $f0

String_2F_05_18::
    db $ed, $f9, "G's egg", $f1
    db "was abandoned.", $fa, $f7
    db $f0

String_2F_05_19::
    db $ed, "Will you take", $f1
    db $f9, "0 with you?", $f0

String_2F_05_1A::
    db $ed, $f9, "0 was sent", $f1
    db "back to the farm.", $e5, $d6, $fa, $f7
    db $f0

String_2F_05_1B::
    db $ed, $f9, "0 joined the", $f1
    db "party.", $e5, $d6, $fa, $f7
    db $f0

String_2F_05_1C::
    db $ed, "Choose the monster", $f1
    db "to send home.", $f0

String_2F_05_1D::
    db $ed, "Send ", $f9, "0 back to", $f1
    db "the farm?", $f0

String_2F_05_1E::
    db $ed, $f9, "0 got up,", $f1
    db "looking hopeful.", $fa, $f7
    db $f2, $ed, "But it sadly went", $f1
    db "away", $a4, $fa, $f7
    db $f0

String_2F_05_1F::
    db $ed, $f9, "0 learned", $f1
    db $f9, "G!", $f7
    db $f0

String_2F_05_20::
    db $ed, $f9, "0 was sent to", $f1
    db "the farm.", $e5, $54, $fa, $f7
    db $f0

String_2F_05_21::
    db $ed, $f9, "0 joined the", $f1
    db "party.", $e5, $54, $fa, $f7
    db $f0
    ds $2d5, $00
