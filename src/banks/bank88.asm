SECTION "Bank 88", ROMX[$4000], BANK[$88]
    db $88

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank88::
    ld de, StringCategories_88_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank88 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank88::
    call BeginStringDisplay_Bank88
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_88_4016::
    dw StringList_88_401C ; id 0
    dw StringList_88_421C ; id 1
    dw StringList_88_441C ; id 2

; category list of StringCategories_88_4016; one pointer per wStringIndex (E-0217)
; record: string
StringList_88_401C::
    dw String_88_00_00 ; id 0
    dw String_88_00_01 ; id 1
    dw String_88_00_02 ; id 2
    dw String_88_00_03 ; id 3
    dw String_88_00_04 ; id 4
    dw String_88_00_05 ; id 5
    dw String_88_00_06 ; id 6
    dw String_88_00_07 ; id 7
    dw String_88_00_07 ; id 8
    dw String_88_00_09 ; id 9
    dw String_88_00_0A ; id 10
    dw String_88_00_0B ; id 11
    dw String_88_00_0C ; id 12
    dw String_88_00_0D ; id 13
    dw String_88_00_0E ; id 14
    dw String_88_00_0F ; id 15
    dw String_88_00_10 ; id 16
    dw String_88_00_11 ; id 17
    dw String_88_00_12 ; id 18
    dw String_88_00_13 ; id 19
    dw String_88_00_14 ; id 20
    dw String_88_00_15 ; id 21
    dw String_88_00_16 ; id 22
    dw String_88_00_17 ; id 23
    dw String_88_00_18 ; id 24
    dw String_88_00_19 ; id 25
    dw String_88_00_1A ; id 26
    dw String_88_00_1A ; id 27
    dw String_88_00_1C ; id 28
    dw String_88_00_1D ; id 29
    dw String_88_00_1E ; id 30
    dw String_88_00_1F ; id 31
    dw String_88_00_20 ; id 32
    dw String_88_00_21 ; id 33
    dw String_88_00_22 ; id 34
    dw String_88_00_23 ; id 35
    dw String_88_00_24 ; id 36
    dw String_88_00_25 ; id 37
    dw String_88_00_26 ; id 38
    dw String_88_00_27 ; id 39
    dw String_88_00_28 ; id 40
    dw String_88_00_29 ; id 41
    dw String_88_00_2A ; id 42
    dw String_88_00_2B ; id 43
    dw String_88_00_2C ; id 44
    dw String_88_00_2D ; id 45
    dw String_88_00_2E ; id 46
    dw String_88_00_2F ; id 47
    dw String_88_00_30 ; id 48
    dw String_88_00_31 ; id 49
    dw String_88_00_32 ; id 50
    dw String_88_00_33 ; id 51
    dw String_88_00_34 ; id 52
    dw String_88_00_35 ; id 53
    dw String_88_00_36 ; id 54
    dw String_88_00_37 ; id 55
    dw String_88_00_38 ; id 56
    dw String_88_00_39 ; id 57
    dw String_88_00_3A ; id 58
    dw String_88_00_3B ; id 59
    dw String_88_00_3C ; id 60
    dw String_88_00_3D ; id 61
    dw String_88_00_3E ; id 62
    dw String_88_00_3F ; id 63
    dw String_88_00_40 ; id 64
    dw String_88_00_41 ; id 65
    dw String_88_00_42 ; id 66
    dw String_88_00_43 ; id 67
    dw String_88_00_44 ; id 68
    dw String_88_00_45 ; id 69
    dw String_88_00_46 ; id 70
    dw String_88_00_47 ; id 71
    dw String_88_00_48 ; id 72
    dw String_88_00_49 ; id 73
    dw String_88_00_4A ; id 74
    dw String_88_00_4B ; id 75
    dw String_88_00_4C ; id 76
    dw String_88_00_4D ; id 77
    dw String_88_00_4E ; id 78
    dw String_88_00_4F ; id 79
    dw String_88_00_50 ; id 80
    dw String_88_00_51 ; id 81
    dw String_88_00_52 ; id 82
    dw String_88_00_53 ; id 83
    dw String_88_00_54 ; id 84
    dw String_88_00_55 ; id 85
    dw String_88_00_56 ; id 86
    dw String_88_00_57 ; id 87
    dw String_88_00_58 ; id 88
    dw String_88_00_59 ; id 89
    dw String_88_00_5A ; id 90
    dw String_88_00_5B ; id 91
    dw String_88_00_5C ; id 92
    dw String_88_00_5D ; id 93
    dw String_88_00_5E ; id 94
    dw String_88_00_5F ; id 95
    dw String_88_00_60 ; id 96
    dw String_88_00_61 ; id 97
    dw String_88_00_62 ; id 98
    dw String_88_00_63 ; id 99
    dw String_88_00_64 ; id 100
    dw String_88_00_65 ; id 101
    dw String_88_00_66 ; id 102
    dw String_88_00_67 ; id 103
    dw String_88_00_68 ; id 104
    dw String_88_00_69 ; id 105
    dw String_88_00_6A ; id 106
    dw String_88_00_6B ; id 107
    dw String_88_00_6C ; id 108
    dw String_88_00_6D ; id 109
    dw String_88_00_6E ; id 110
    dw String_88_00_6F ; id 111
    dw String_88_00_70 ; id 112
    dw String_88_00_71 ; id 113
    dw String_88_00_72 ; id 114
    dw String_88_00_73 ; id 115
    dw String_88_00_74 ; id 116
    dw String_88_00_75 ; id 117
    dw String_88_00_76 ; id 118
    dw String_88_00_76 ; id 119
    dw String_88_00_76 ; id 120
    dw String_88_00_76 ; id 121
    dw String_88_00_76 ; id 122
    dw String_88_00_76 ; id 123
    dw String_88_00_76 ; id 124
    dw String_88_00_76 ; id 125
    dw String_88_00_7E ; id 126
    dw String_88_00_7F ; id 127
    dw String_88_00_80 ; id 128
    dw String_88_00_81 ; id 129
    dw String_88_00_82 ; id 130
    dw String_88_00_83 ; id 131
    dw String_88_00_84 ; id 132
    dw String_88_00_85 ; id 133
    dw String_88_00_86 ; id 134
    dw String_88_00_87 ; id 135
    dw String_88_00_88 ; id 136
    dw String_88_00_89 ; id 137
    dw String_88_00_8A ; id 138
    dw String_88_00_8B ; id 139
    dw String_88_00_8C ; id 140
    dw String_88_00_8D ; id 141
    dw String_88_00_8E ; id 142
    dw String_88_00_8F ; id 143
    dw String_88_00_90 ; id 144
    dw String_88_00_91 ; id 145
    dw String_88_00_92 ; id 146
    dw String_88_00_93 ; id 147
    dw String_88_00_94 ; id 148
    dw String_88_00_95 ; id 149
    dw String_88_00_96 ; id 150
    dw String_88_00_97 ; id 151
    dw String_88_00_98 ; id 152
    dw String_88_00_99 ; id 153
    dw String_88_00_9A ; id 154
    dw String_88_00_9B ; id 155
    dw String_88_00_9C ; id 156
    dw String_88_00_9D ; id 157
    dw String_88_00_9E ; id 158
    dw String_88_00_9F ; id 159
    dw String_88_00_A0 ; id 160
    dw String_88_00_A1 ; id 161
    dw String_88_00_A2 ; id 162
    dw String_88_00_A3 ; id 163
    dw String_88_00_A4 ; id 164
    dw String_88_00_A5 ; id 165
    dw String_88_00_A6 ; id 166
    dw String_88_00_A7 ; id 167
    dw String_88_00_A8 ; id 168
    dw String_88_00_A9 ; id 169
    dw String_88_00_AA ; id 170
    dw String_88_00_AB ; id 171
    dw String_88_00_AC ; id 172
    dw String_88_00_AD ; id 173
    dw String_88_00_AE ; id 174
    dw String_88_00_AF ; id 175
    dw String_88_00_B0 ; id 176
    dw String_88_00_B1 ; id 177
    dw String_88_00_B2 ; id 178
    dw String_88_00_B3 ; id 179
    dw String_88_00_B4 ; id 180
    dw String_88_00_B5 ; id 181
    dw String_88_00_B6 ; id 182
    dw String_88_00_B7 ; id 183
    dw String_88_00_B8 ; id 184
    dw String_88_00_B9 ; id 185
    dw String_88_00_BA ; id 186
    dw String_88_00_BB ; id 187
    dw String_88_00_BC ; id 188
    dw String_88_00_BD ; id 189
    dw String_88_00_BE ; id 190
    dw String_88_00_BF ; id 191
    dw String_88_00_C0 ; id 192
    dw String_88_00_C1 ; id 193
    dw String_88_00_C2 ; id 194
    dw String_88_00_C3 ; id 195
    dw String_88_00_C4 ; id 196
    dw String_88_00_C5 ; id 197
    dw String_88_00_C6 ; id 198
    dw String_88_00_C7 ; id 199
    dw String_88_00_C8 ; id 200
    dw String_88_00_C9 ; id 201
    dw String_88_00_CA ; id 202
    dw String_88_00_CB ; id 203
    dw String_88_00_CC ; id 204
    dw String_88_00_CD ; id 205
    dw String_88_00_CE ; id 206
    dw String_88_00_CF ; id 207
    dw String_88_00_D0 ; id 208
    dw String_88_00_D1 ; id 209
    dw String_88_00_D2 ; id 210
    dw String_88_00_D3 ; id 211
    dw String_88_00_D4 ; id 212
    dw String_88_00_D5 ; id 213
    dw String_88_00_D6 ; id 214
    dw String_88_00_D7 ; id 215
    dw String_88_00_D8 ; id 216
    dw String_88_00_D9 ; id 217
    dw String_88_00_DA ; id 218
    dw String_88_00_DB ; id 219
    dw String_88_00_DC ; id 220
    dw String_88_00_DD ; id 221
    dw String_88_00_DE ; id 222
    dw String_88_00_DF ; id 223
    dw String_88_00_E0 ; id 224
    dw String_88_00_E1 ; id 225
    dw String_88_00_E2 ; id 226
    dw String_88_00_E3 ; id 227
    dw String_88_00_E4 ; id 228
    dw String_88_00_E5 ; id 229
    dw String_88_00_E6 ; id 230
    dw String_88_00_E7 ; id 231
    dw String_88_00_E8 ; id 232
    dw String_88_00_E9 ; id 233
    dw String_88_00_EA ; id 234
    dw String_88_00_EB ; id 235
    dw String_88_00_EC ; id 236
    dw String_88_00_ED ; id 237
    dw String_88_00_EE ; id 238
    dw String_88_00_EF ; id 239
    dw String_88_00_F0 ; id 240
    dw String_88_00_F1 ; id 241
    dw String_88_00_F2 ; id 242
    dw String_88_00_F3 ; id 243
    dw String_88_00_F4 ; id 244
    dw String_88_00_F5 ; id 245
    dw String_88_00_F6 ; id 246
    dw String_88_00_F7 ; id 247
    dw String_88_00_F8 ; id 248
    dw String_88_00_F9 ; id 249
    dw String_88_00_FA ; id 250
    dw String_88_00_FB ; id 251
    dw String_88_00_FC ; id 252
    dw String_88_00_FD ; id 253
    dw String_88_00_FE ; id 254
    dw String_88_00_FF ; id 255

StringList_88_421C::
    dw String_88_01_00 ; id 0
    dw String_88_01_01 ; id 1
    dw String_88_01_02 ; id 2
    dw String_88_01_03 ; id 3
    dw String_88_01_04 ; id 4
    dw String_88_01_05 ; id 5
    dw String_88_01_06 ; id 6
    dw String_88_01_07 ; id 7
    dw String_88_01_08 ; id 8
    dw String_88_01_09 ; id 9
    dw String_88_01_0A ; id 10
    dw String_88_01_0B ; id 11
    dw String_88_01_0C ; id 12
    dw String_88_01_0D ; id 13
    dw String_88_01_0E ; id 14
    dw String_88_01_0F ; id 15
    dw String_88_01_10 ; id 16
    dw String_88_01_11 ; id 17
    dw String_88_01_12 ; id 18
    dw String_88_01_13 ; id 19
    dw String_88_01_14 ; id 20
    dw String_88_01_15 ; id 21
    dw String_88_01_16 ; id 22
    dw String_88_01_17 ; id 23
    dw String_88_01_18 ; id 24
    dw String_88_01_19 ; id 25
    dw String_88_01_1A ; id 26
    dw String_88_01_1B ; id 27
    dw String_88_01_1C ; id 28
    dw String_88_01_1D ; id 29
    dw String_88_01_1E ; id 30
    dw String_88_01_1F ; id 31
    dw String_88_01_20 ; id 32
    dw String_88_01_21 ; id 33
    dw String_88_01_22 ; id 34
    dw String_88_01_23 ; id 35
    dw String_88_01_24 ; id 36
    dw String_88_01_25 ; id 37
    dw String_88_01_26 ; id 38
    dw String_88_01_27 ; id 39
    dw String_88_01_28 ; id 40
    dw String_88_01_29 ; id 41
    dw String_88_01_2A ; id 42
    dw String_88_01_2B ; id 43
    dw String_88_01_2C ; id 44
    dw String_88_01_2D ; id 45
    dw String_88_01_2E ; id 46
    dw String_88_01_2F ; id 47
    dw String_88_01_30 ; id 48
    dw String_88_01_31 ; id 49
    dw String_88_01_32 ; id 50
    dw String_88_01_33 ; id 51
    dw String_88_01_34 ; id 52
    dw String_88_01_35 ; id 53
    dw String_88_01_36 ; id 54
    dw String_88_01_37 ; id 55
    dw String_88_01_38 ; id 56
    dw String_88_01_39 ; id 57
    dw String_88_01_3A ; id 58
    dw String_88_01_3B ; id 59
    dw String_88_01_3C ; id 60
    dw String_88_01_3D ; id 61
    dw String_88_01_3E ; id 62
    dw String_88_01_3F ; id 63
    dw String_88_01_40 ; id 64
    dw String_88_01_41 ; id 65
    dw String_88_01_42 ; id 66
    dw String_88_01_43 ; id 67
    dw String_88_01_44 ; id 68
    dw String_88_01_45 ; id 69
    dw String_88_01_46 ; id 70
    dw String_88_01_47 ; id 71
    dw String_88_01_48 ; id 72
    dw String_88_01_49 ; id 73
    dw String_88_01_4A ; id 74
    dw String_88_01_4B ; id 75
    dw String_88_01_4C ; id 76
    dw String_88_01_4D ; id 77
    dw String_88_01_4E ; id 78
    dw String_88_01_4F ; id 79
    dw String_88_01_50 ; id 80
    dw String_88_01_51 ; id 81
    dw String_88_01_52 ; id 82
    dw String_88_01_53 ; id 83
    dw String_88_01_54 ; id 84
    dw String_88_01_55 ; id 85
    dw String_88_01_56 ; id 86
    dw String_88_01_57 ; id 87
    dw String_88_01_58 ; id 88
    dw String_88_01_59 ; id 89
    dw String_88_01_5A ; id 90
    dw String_88_01_5B ; id 91
    dw String_88_01_5C ; id 92
    dw String_88_01_5D ; id 93
    dw String_88_01_5E ; id 94
    dw String_88_01_5F ; id 95
    dw String_88_01_60 ; id 96
    dw String_88_01_61 ; id 97
    dw String_88_01_62 ; id 98
    dw String_88_01_63 ; id 99
    dw String_88_01_64 ; id 100
    dw String_88_01_65 ; id 101
    dw String_88_01_66 ; id 102
    dw String_88_01_67 ; id 103
    dw String_88_01_68 ; id 104
    dw String_88_01_69 ; id 105
    dw String_88_01_6A ; id 106
    dw String_88_01_6B ; id 107
    dw String_88_01_6C ; id 108
    dw String_88_01_6D ; id 109
    dw String_88_01_6E ; id 110
    dw String_88_01_6F ; id 111
    dw String_88_01_70 ; id 112
    dw String_88_01_71 ; id 113
    dw String_88_01_72 ; id 114
    dw String_88_01_73 ; id 115
    dw String_88_01_74 ; id 116
    dw String_88_01_75 ; id 117
    dw String_88_01_76 ; id 118
    dw String_88_01_77 ; id 119
    dw String_88_01_78 ; id 120
    dw String_88_01_79 ; id 121
    dw String_88_01_7A ; id 122
    dw String_88_01_7B ; id 123
    dw String_88_01_7C ; id 124
    dw String_88_01_7D ; id 125
    dw String_88_01_7E ; id 126
    dw String_88_01_7F ; id 127
    dw String_88_01_80 ; id 128
    dw String_88_01_81 ; id 129
    dw String_88_01_82 ; id 130
    dw String_88_01_82 ; id 131
    dw String_88_01_84 ; id 132
    dw String_88_01_85 ; id 133
    dw String_88_01_86 ; id 134
    dw String_88_01_87 ; id 135
    dw String_88_01_88 ; id 136
    dw String_88_01_89 ; id 137
    dw String_88_01_8A ; id 138
    dw String_88_01_8B ; id 139
    dw String_88_01_8C ; id 140
    dw String_88_01_8D ; id 141
    dw String_88_01_8E ; id 142
    dw String_88_01_8F ; id 143
    dw String_88_01_90 ; id 144
    dw String_88_01_91 ; id 145
    dw String_88_01_92 ; id 146
    dw String_88_01_93 ; id 147
    dw String_88_01_94 ; id 148
    dw String_88_01_95 ; id 149
    dw String_88_01_96 ; id 150
    dw String_88_01_97 ; id 151
    dw String_88_01_98 ; id 152
    dw String_88_01_99 ; id 153
    dw String_88_01_9A ; id 154
    dw String_88_01_9B ; id 155
    dw String_88_01_9C ; id 156
    dw String_88_01_9D ; id 157
    dw String_88_01_9E ; id 158
    dw String_88_01_9F ; id 159
    dw String_88_01_A0 ; id 160
    dw String_88_01_A1 ; id 161
    dw String_88_01_A2 ; id 162
    dw String_88_01_A3 ; id 163
    dw String_88_01_A4 ; id 164
    dw String_88_01_A5 ; id 165
    dw String_88_01_A6 ; id 166
    dw String_88_01_A7 ; id 167
    dw String_88_01_A8 ; id 168
    dw String_88_01_A9 ; id 169
    dw String_88_01_AA ; id 170
    dw String_88_01_AB ; id 171
    dw String_88_01_AB ; id 172
    dw String_88_01_AD ; id 173
    dw String_88_01_AE ; id 174
    dw String_88_01_AF ; id 175
    dw String_88_01_B0 ; id 176
    dw String_88_01_B1 ; id 177
    dw String_88_01_B2 ; id 178
    dw String_88_01_B3 ; id 179
    dw String_88_01_B4 ; id 180
    dw String_88_01_B5 ; id 181
    dw String_88_01_B6 ; id 182
    dw String_88_01_B7 ; id 183
    dw String_88_01_B8 ; id 184
    dw String_88_01_B9 ; id 185
    dw String_88_01_BA ; id 186
    dw String_88_01_BB ; id 187
    dw String_88_01_BC ; id 188
    dw String_88_01_BD ; id 189
    dw String_88_01_BE ; id 190
    dw String_88_01_BF ; id 191
    dw String_88_01_C0 ; id 192
    dw String_88_01_C1 ; id 193
    dw String_88_01_C2 ; id 194
    dw String_88_01_C3 ; id 195
    dw String_88_01_C4 ; id 196
    dw String_88_01_C5 ; id 197
    dw String_88_01_C6 ; id 198
    dw String_88_01_C7 ; id 199
    dw String_88_01_C8 ; id 200
    dw String_88_01_C9 ; id 201
    dw String_88_01_CA ; id 202
    dw String_88_01_CB ; id 203
    dw String_88_01_CC ; id 204
    dw String_88_01_CD ; id 205
    dw String_88_01_CE ; id 206
    dw String_88_01_CF ; id 207
    dw String_88_01_D0 ; id 208
    dw String_88_01_D1 ; id 209
    dw String_88_01_D2 ; id 210
    dw String_88_01_D3 ; id 211
    dw String_88_01_D4 ; id 212
    dw String_88_01_D5 ; id 213
    dw String_88_01_D6 ; id 214
    dw String_88_01_D7 ; id 215
    dw String_88_01_D8 ; id 216
    dw String_88_01_D9 ; id 217
    dw String_88_01_DA ; id 218
    dw String_88_01_DB ; id 219
    dw String_88_01_DC ; id 220
    dw String_88_01_DD ; id 221
    dw String_88_01_DE ; id 222
    dw String_88_01_DF ; id 223
    dw String_88_01_E0 ; id 224
    dw String_88_01_E1 ; id 225
    dw String_88_01_E2 ; id 226
    dw String_88_01_E3 ; id 227
    dw String_88_01_E4 ; id 228
    dw String_88_01_E5 ; id 229
    dw String_88_01_E6 ; id 230
    dw String_88_01_E7 ; id 231
    dw String_88_01_E8 ; id 232
    dw String_88_01_E9 ; id 233
    dw String_88_01_E9 ; id 234
    dw String_88_01_E9 ; id 235
    dw String_88_01_E9 ; id 236
    dw String_88_01_ED ; id 237
    dw String_88_01_EE ; id 238
    dw String_88_01_EF ; id 239
    dw String_88_01_F0 ; id 240
    dw String_88_01_F1 ; id 241
    dw String_88_01_F2 ; id 242
    dw String_88_01_F3 ; id 243
    dw String_88_01_F4 ; id 244
    dw String_88_01_F5 ; id 245
    dw String_88_01_F6 ; id 246
    dw String_88_01_F7 ; id 247
    dw String_88_01_F8 ; id 248
    dw String_88_01_F9 ; id 249
    dw String_88_01_FA ; id 250
    dw String_88_01_FB ; id 251
    dw String_88_01_FC ; id 252
    dw String_88_01_FD ; id 253
    dw String_88_01_FE ; id 254
    dw String_88_01_FF ; id 255

StringList_88_441C::
    dw String_88_02_00 ; id 0
    dw String_88_02_01 ; id 1
    dw String_88_02_02 ; id 2
    dw String_88_02_03 ; id 3
    dw String_88_02_04 ; id 4
    dw String_88_02_05 ; id 5
    dw String_88_02_06 ; id 6
    dw String_88_02_07 ; id 7
    dw String_88_02_08 ; id 8
    dw String_88_02_09 ; id 9
    dw String_88_02_0A ; id 10
    dw String_88_02_0B ; id 11
    dw String_88_02_0C ; id 12
    dw String_88_02_0D ; id 13
    dw String_88_02_0E ; id 14
    dw String_88_02_0F ; id 15
    dw String_88_02_10 ; id 16
    dw String_88_02_11 ; id 17
    dw String_88_02_12 ; id 18
    dw String_88_02_13 ; id 19
    dw String_88_02_14 ; id 20
    dw String_88_02_15 ; id 21
    dw String_88_02_16 ; id 22
    dw String_88_02_17 ; id 23
    dw String_88_02_18 ; id 24
    dw String_88_02_19 ; id 25
    dw String_88_02_1A ; id 26
    dw String_88_02_1B ; id 27
    dw String_88_02_1C ; id 28
    dw String_88_02_1D ; id 29
    dw String_88_02_1E ; id 30
    dw String_88_02_1F ; id 31
    dw String_88_02_20 ; id 32
    dw String_88_02_21 ; id 33
    dw String_88_02_22 ; id 34
    dw String_88_02_23 ; id 35
    dw String_88_02_24 ; id 36
    dw String_88_02_25 ; id 37
    dw String_88_02_26 ; id 38
    dw String_88_02_27 ; id 39
    dw String_88_02_28 ; id 40
    dw String_88_02_29 ; id 41
    dw String_88_02_2A ; id 42
    dw String_88_02_2B ; id 43
    dw String_88_02_2C ; id 44
    dw String_88_02_2D ; id 45
    dw String_88_02_2E ; id 46
    dw String_88_02_2F ; id 47
    dw String_88_02_30 ; id 48
    dw String_88_02_31 ; id 49
    dw String_88_02_32 ; id 50
    dw String_88_02_33 ; id 51
    dw String_88_02_34 ; id 52
    dw String_88_02_35 ; id 53
    dw String_88_02_36 ; id 54
    dw String_88_02_37 ; id 55
    dw String_88_02_38 ; id 56
    dw String_88_02_39 ; id 57
    dw String_88_02_3A ; id 58
    dw String_88_02_3B ; id 59
    dw String_88_02_3C ; id 60
    dw String_88_02_3D ; id 61
    dw String_88_02_3E ; id 62
    dw String_88_02_3F ; id 63
    dw String_88_02_40 ; id 64
    dw String_88_02_41 ; id 65
    dw String_88_02_42 ; id 66
    dw String_88_02_43 ; id 67
    dw String_88_02_44 ; id 68
    dw String_88_02_45 ; id 69
    dw String_88_02_46 ; id 70
    dw String_88_02_47 ; id 71
    dw String_88_02_48 ; id 72
    dw String_88_02_49 ; id 73
    dw String_88_02_4A ; id 74
    dw String_88_02_4B ; id 75
    dw String_88_02_4C ; id 76
    dw String_88_02_4D ; id 77
    dw String_88_02_4E ; id 78
    dw String_88_02_4F ; id 79
    dw String_88_02_50 ; id 80
    dw String_88_02_51 ; id 81
    dw String_88_02_52 ; id 82
    dw String_88_02_53 ; id 83
    dw String_88_02_54 ; id 84
    dw String_88_02_55 ; id 85
    dw String_88_02_56 ; id 86
    dw String_88_02_57 ; id 87
    dw String_88_02_58 ; id 88
    dw String_88_02_59 ; id 89
    dw String_88_02_5A ; id 90
    dw String_88_02_5B ; id 91
    dw String_88_02_5C ; id 92
    dw String_88_02_5D ; id 93
    dw String_88_02_5E ; id 94
    dw String_88_02_5F ; id 95
    dw String_88_02_60 ; id 96
    dw String_88_02_61 ; id 97
    dw String_88_02_62 ; id 98
    dw String_88_02_63 ; id 99
    dw String_88_02_64 ; id 100
    dw String_88_02_65 ; id 101
    dw String_88_02_66 ; id 102
    dw String_88_02_67 ; id 103
    dw String_88_02_68 ; id 104
    dw String_88_02_69 ; id 105
    dw String_88_02_6A ; id 106
    dw String_88_02_6B ; id 107
    dw String_88_02_6C ; id 108
    dw String_88_02_6D ; id 109
    dw String_88_02_6E ; id 110
    dw String_88_02_6F ; id 111
    dw String_88_02_70 ; id 112
    dw String_88_02_71 ; id 113
    dw String_88_02_72 ; id 114
    dw String_88_02_73 ; id 115
    dw String_88_02_74 ; id 116
    dw String_88_02_75 ; id 117
    dw String_88_02_76 ; id 118
    dw String_88_02_77 ; id 119
    dw String_88_02_78 ; id 120
    dw String_88_02_79 ; id 121
    dw String_88_02_7A ; id 122
    dw String_88_02_7B ; id 123
    dw String_88_02_7B ; id 124
    dw String_88_02_7D ; id 125
    dw String_88_02_7E ; id 126
    dw String_88_02_7F ; id 127
    dw String_88_02_80 ; id 128
    dw String_88_02_81 ; id 129
    dw String_88_02_82 ; id 130
    dw String_88_02_83 ; id 131
    dw String_88_02_84 ; id 132
    dw String_88_02_85 ; id 133
    dw String_88_02_86 ; id 134
    dw String_88_02_87 ; id 135
    dw String_88_02_87 ; id 136
    dw String_88_02_89 ; id 137
    dw String_88_02_8A ; id 138
    dw String_88_02_8A ; id 139
    dw String_88_02_8A ; id 140
    dw String_88_02_8D ; id 141
    dw String_88_02_8E ; id 142
    dw String_88_02_8E ; id 143
    dw String_88_02_90 ; id 144
    dw String_88_02_91 ; id 145
    dw String_88_02_92 ; id 146
    dw String_88_02_93 ; id 147
    dw String_88_02_94 ; id 148
    dw String_88_02_95 ; id 149
    dw String_88_02_96 ; id 150
    dw String_88_02_97 ; id 151
    dw String_88_02_98 ; id 152
    dw String_88_02_99 ; id 153
    dw String_88_02_9A ; id 154
    dw String_88_02_9B ; id 155
    dw String_88_02_9C ; id 156
    dw String_88_02_9D ; id 157
    dw String_88_02_9E ; id 158
    dw String_88_02_9F ; id 159
    dw String_88_02_A0 ; id 160
    dw String_88_02_A1 ; id 161
    dw String_88_02_A2 ; id 162
    dw String_88_02_A3 ; id 163
    dw String_88_02_A4 ; id 164
    dw String_88_02_A5 ; id 165
    dw String_88_02_A6 ; id 166
    dw String_88_02_A7 ; id 167
    dw String_88_02_A8 ; id 168
    dw String_88_02_A9 ; id 169
    dw String_88_02_AA ; id 170
    dw String_88_02_AB ; id 171
    dw String_88_02_AC ; id 172
    dw String_88_02_AD ; id 173
    dw String_88_02_AD ; id 174
    dw String_88_02_AD ; id 175
    dw String_88_02_AD ; id 176
    dw String_88_02_AD ; id 177
    dw String_88_02_AD ; id 178
    dw String_88_02_AD ; id 179
    dw String_88_02_AD ; id 180
    dw String_88_02_AD ; id 181
    dw String_88_02_AD ; id 182
    dw String_88_02_AD ; id 183
    dw String_88_02_AD ; id 184
    dw String_88_02_AD ; id 185
    dw String_88_02_AD ; id 186
    dw String_88_02_AD ; id 187
    dw String_88_02_AD ; id 188
    dw String_88_02_AD ; id 189
    dw String_88_02_AD ; id 190
    dw String_88_02_AD ; id 191
    dw String_88_02_AD ; id 192
    dw String_88_02_AD ; id 193
    dw String_88_02_AD ; id 194
    dw String_88_02_AD ; id 195
    dw String_88_02_AD ; id 196
    dw String_88_02_AD ; id 197
    dw String_88_02_AD ; id 198
    dw String_88_02_AD ; id 199
    dw String_88_02_AD ; id 200
    dw String_88_02_AD ; id 201
    dw String_88_02_AD ; id 202
    dw String_88_02_AD ; id 203
    dw String_88_02_AD ; id 204
    dw String_88_02_AD ; id 205
    dw String_88_02_AD ; id 206
    dw String_88_02_AD ; id 207
    dw String_88_02_AD ; id 208
    dw String_88_02_AD ; id 209
    dw String_88_02_AD ; id 210
    dw String_88_02_AD ; id 211
    dw String_88_02_AD ; id 212
    dw String_88_02_AD ; id 213
    dw String_88_02_AD ; id 214
    dw String_88_02_AD ; id 215
    dw String_88_02_AD ; id 216
    dw String_88_02_AD ; id 217
    dw String_88_02_AD ; id 218
    dw String_88_02_AD ; id 219
    dw String_88_02_AD ; id 220
    dw String_88_02_AD ; id 221
    dw String_88_02_AD ; id 222
    dw String_88_02_AD ; id 223
    dw String_88_02_AD ; id 224
    dw String_88_02_AD ; id 225
    dw String_88_02_AD ; id 226
    dw String_88_02_AD ; id 227
    dw String_88_02_AD ; id 228
    dw String_88_02_AD ; id 229
    dw String_88_02_AD ; id 230
    dw String_88_02_AD ; id 231
    dw String_88_02_AD ; id 232
    dw String_88_02_AD ; id 233
    dw String_88_02_AD ; id 234
    dw String_88_02_AD ; id 235
    dw String_88_02_AD ; id 236
    dw String_88_02_AD ; id 237
    dw String_88_02_AD ; id 238
    dw String_88_02_AD ; id 239
    dw String_88_02_AD ; id 240
    dw String_88_02_AD ; id 241
    dw String_88_02_AD ; id 242
    dw String_88_02_AD ; id 243
    dw String_88_02_AD ; id 244
    dw String_88_02_AD ; id 245
    dw String_88_02_AD ; id 246
    dw String_88_02_AD ; id 247
    dw String_88_02_AD ; id 248
    dw String_88_02_AD ; id 249
    dw String_88_02_AD ; id 250
    dw String_88_02_AD ; id 251
    dw String_88_02_AD ; id 252
    dw String_88_02_AD ; id 253
    dw String_88_02_AD ; id 254
    dw String_88_02_AD ; id 255

String_88_00_00::
    db "None", $f0

String_88_00_01::
    db "Slime", $f0

String_88_00_02::
    db "SpotSlime", $f0

String_88_00_03::
    db "CactiBall", $f0

String_88_00_04::
    db "TailEater", $f0

String_88_00_05::
    db "Crestpent", $f0

String_88_00_06::
    db "KingCobra", $f0

String_88_00_07::
    db "CurseLamp", $f0

String_88_00_09::
    db "Slime", $f0

String_88_00_0A::
    db "Antbear", $f0

String_88_00_0B::
    db "Dracky", $f0

String_88_00_0C::
    db "Eggplaton", $f0

String_88_00_0D::
    db "JewelBag", $f0

String_88_00_0E::
    db "Hork", $f0

String_88_00_0F::
    db "Wyvern", $f0

String_88_00_10::
    db "ArmyAnt", $f0

String_88_00_11::
    db "MadGopher", $f0

String_88_00_12::
    db "1EyeClown", $f0

String_88_00_13::
    db "Snaily", $f0

String_88_00_14::
    db "Poisongon", $f0

String_88_00_15::
    db "Moray", $f0

String_88_00_16::
    db "Eyeder", $f0

String_88_00_17::
    db "PutreFish", $f0

String_88_00_18::
    db "Gamanian", $f0

String_88_00_19::
    db "SpikyBoy", $f0

String_88_00_1A::
    db "HoodSquid", $f0

String_88_00_1C::
    db "CaptDead", $f0

String_88_00_1D::
    db "Petiteel", $f0

String_88_00_1E::
    db "RotRaven", $f0

String_88_00_1F::
    db "Merman", $f0

String_88_00_20::
    db "Octokid", $f0

String_88_00_21::
    db "RogueWave", $f0

String_88_00_22::
    db "PearlGel", $f0

String_88_00_23::
    db "Tortragon", $f0

String_88_00_24::
    db "AquaHawk", $f0

String_88_00_25::
    db "DarkEye", $f0

String_88_00_26::
    db "RayGigas", $f0

String_88_00_27::
    db "EvilWand", $f0

String_88_00_28::
    db "SlimeNite", $f0

String_88_00_29::
    db "LizardMan", $f0

String_88_00_2A::
    db "HammerMan", $f0

String_88_00_2B::
    db "Yeti", $f0

String_88_00_2C::
    db "Orc", $f0

String_88_00_2D::
    db "Gismo", $f0

String_88_00_2E::
    db "Droll", $f0

String_88_00_2F::
    db "Goopi", $f0

String_88_00_30::
    db "Mummy", $f0

String_88_00_31::
    db "TreeBoy", $f0

String_88_00_32::
    db "BombCrag", $f0

String_88_00_33::
    db "RogueNite", $f0

String_88_00_34::
    db "Grizzly", $f0

String_88_00_35::
    db "Demonite", $f0

String_88_00_36::
    db "Gulpple", $f0

String_88_00_37::
    db "FoxFire", $f0

String_88_00_38::
    db "Almiraj", $f0

String_88_00_39::
    db "LandOwl", $f0

String_88_00_3A::
    db "Goategon", $f0

String_88_00_3B::
    db "Saccer", $f0

String_88_00_3C::
    db "WingSlime", $f0

String_88_00_3D::
    db "BullBird", $f0

String_88_00_3E::
    db "CragDevil", $f0

String_88_00_3F::
    db "Starfish", $f0

String_88_00_40::
    db "SeaHorse", $f0

String_88_00_41::
    db "ManEater", $f0

String_88_00_42::
    db "StubBird", $f0

String_88_00_43::
    db "GiantMoth", $f0

String_88_00_44::
    db "GoatHorn", $f0

String_88_00_45::
    db "FangSlime", $f0

String_88_00_46::
    db "RockSlime", $f0

String_88_00_47::
    db "MadRaven", $f0

String_88_00_48::
    db "Emyu", $f0

String_88_00_49::
    db "FloraMan", $f0

String_88_00_4A::
    db "Slurperon", $f0

String_88_00_4B::
    db "Roboster", $f0

String_88_00_4C::
    db "MadDragon", $f0

String_88_00_4D::
    db "Dragon", $f0

String_88_00_4E::
    db "IronTurt", $f0

String_88_00_4F::
    db "MadMirror", $f0

String_88_00_50::
    db "SabreMan", $f0

String_88_00_51::
    db "EvilBeast", $f0

String_88_00_52::
    db "WarMantis", $f0

String_88_00_53::
    db "Phoenix", $f0

String_88_00_54::
    db "FireWeed", $f0

String_88_00_55::
    db "WildApe", $f0

String_88_00_56::
    db "Dumbira", $f0

String_88_00_57::
    db "Belzebub", $f0

String_88_00_58::
    db "Metaly", $f0

String_88_00_59::
    db "GhosTree", $f0

String_88_00_5A::
    db "Babble", $f0

String_88_00_5B::
    db "Lionex", $f0

String_88_00_5C::
    db "MadGoose", $f0

String_88_00_5D::
    db "Bubblemon", $f0

String_88_00_5E::
    db "Gigantes", $f0

String_88_00_5F::
    db "Exaucers", $f0

String_88_00_60::
    db "DeadNite", $f0

String_88_00_61::
    db "GateGuard", $f0

String_88_00_62::
    db "MadSpirit", $f0

String_88_00_63::
    db "Copycat", $f0

String_88_00_64::
    db "Niterich", $f0

String_88_00_65::
    db "Andreal", $f0

String_88_00_66::
    db "MadKnight", $f0

String_88_00_67::
    db "SkyDragon", $f0

String_88_00_68::
    db "CoilBird", $f0

String_88_00_69::
    db "ArmorPede", $f0

String_88_00_6A::
    db "MadHornet", $f0

String_88_00_6B::
    db "Mudou", $f0

String_88_00_6C::
    db "EvilArmor", $f0

String_88_00_6D::
    db "Skeletor", $f0

String_88_00_6E::
    db "Vampirus", $f0

String_88_00_6F::
    db "Florajay", $f0

String_88_00_70::
    db "BossTroll", $f0

String_88_00_71::
    db "ChopClown", $f0

String_88_00_72::
    db "MistyWing", $f0

String_88_00_73::
    db "Centasaur", $f0

String_88_00_74::
    db "GigaDraco", $f0

String_88_00_75::
    db "Garudian", $f0

String_88_00_76::
    db "Mimic", $f0

String_88_00_7E::
    db "Tatsu", $f0

String_88_00_7F::
    db "Diago", $f0

String_88_00_80::
    db "Samsi", $f0

String_88_00_81::
    db "Bazoo", $f0

String_88_00_82::
    db "BeDragon", $f0

String_88_00_83::
    db "Babble", $f0

String_88_00_84::
    db "PearlGel", $f0

String_88_00_85::
    db "SpikyBoy", $f0

String_88_00_86::
    db "Brushead", $f0

String_88_00_87::
    db "Dracky", $f0

String_88_00_88::
    db "MadRaven", $f0

String_88_00_89::
    db "KiteHawk", $f0

String_88_00_8A::
    db "WindBeast", $f0

String_88_00_8B::
    db "Gismo", $f0

String_88_00_8C::
    db "PomPomBom", $f0

String_88_00_8D::
    db "Devipine", $f0

String_88_00_8E::
    db "Gulpple", $f0

String_88_00_8F::
    db "Eggplaton", $f0

String_88_00_90::
    db "HammerMan", $f0

String_88_00_91::
    db "Stubsuck", $f0

String_88_00_92::
    db "TreeBoy", $f0

String_88_00_93::
    db "FooHero", $f0

String_88_00_94::
    db "Mommonja", $f0

String_88_00_95::
    db "Drygon", $f0

String_88_00_96::
    db "HerbMan", $f0

String_88_00_97::
    db "DanceVegi", $f0

String_88_00_98::
    db "MudDoll", $f0

String_88_00_99::
    db "Shadow", $f0

String_88_00_9A::
    db "MadCondor", $f0

String_88_00_9B::
    db "CloudKing", $f0

String_88_00_9C::
    db "Octoreach", $f0

String_88_00_9D::
    db "Octogon", $f0

String_88_00_9E::
    db "KingSquid", $f0

String_88_00_9F::
    db "MistyWing", $f0

String_88_00_A0::
    db "Copycat", $f0

String_88_00_A1::
    db "NiteWhip", $f0

String_88_00_A2::
    db "Goopi", $f0

String_88_00_A3::
    db "Servant", $f0

String_88_00_A4::
    db "ArmyCrab", $f0

String_88_00_A5::
    db "DarkCrab", $f0

String_88_00_A6::
    db "Orochi", $f0

String_88_00_A7::
    db "Serpentia", $f0

String_88_00_A8::
    db "GigaDraco", $f0

String_88_00_A9::
    db "KingLeo", $f0

String_88_00_AA::
    db "Azurile", $f0

String_88_00_AB::
    db "Divinegon", $f0

String_88_00_AC::
    db "Pteranod", $f0

String_88_00_AD::
    db "WindBeast", $f0

String_88_00_AE::
    db "FairyRat", $f0

String_88_00_AF::
    db "BigEye", $f0

String_88_00_B0::
    db "BullBird", $f0

String_88_00_B1::
    db "TreeBoy", $f0

String_88_00_B2::
    db "GoHopper", $f0

String_88_00_B3::
    db "EvilBeast", $f0

String_88_00_B4::
    db "Mudron", $f0

String_88_00_B5::
    db "Reaper", $f0

String_88_00_B6::
    db "Mummy", $f0

String_88_00_B7::
    db "JewelBag", $f0

String_88_00_B8::
    db "Starfish", $f0

String_88_00_B9::
    db "Brushead", $f0

String_88_00_BA::
    db "MudDoll", $f0

String_88_00_BB::
    db "RushFish", $f0

String_88_00_BC::
    db "WingSlime", $f0

String_88_00_BD::
    db "Poisongon", $f0

String_88_00_BE::
    db "Drygon", $f0

String_88_00_BF::
    db "CatFly", $f0

String_88_00_C0::
    db "Mommonja", $f0

String_88_00_C1::
    db "Grizzly", $f0

String_88_00_C2::
    db "CragDevil", $f0

String_88_00_C3::
    db "Picky", $f0

String_88_00_C4::
    db "Pixy", $f0

String_88_00_C5::
    db "AgDevil", $f0

String_88_00_C6::
    db "Hork", $f0

String_88_00_C7::
    db "WindMerge", $f0

String_88_00_C8::
    db "SpikyBoy", $f0

String_88_00_C9::
    db "Goopi", $f0

String_88_00_CA::
    db "Octokid", $f0

String_88_00_CB::
    db "CancerMan", $f0

String_88_00_CC::
    db "SlimeNite", $f0

String_88_00_CD::
    db "Babble", $f0

String_88_00_CE::
    db "Rayburn", $f0

String_88_00_CF::
    db "CatMage", $f0

String_88_00_D0::
    db "Yeti", $f0

String_88_00_D1::
    db "Beavern", $f0

String_88_00_D2::
    db "Florajay", $f0

String_88_00_D3::
    db "Toadstool", $f0

String_88_00_D4::
    db "GiantMoth", $f0

String_88_00_D5::
    db "ArmyCrab", $f0

String_88_00_D6::
    db "MadHornet", $f0

String_88_00_D7::
    db "Demonite", $f0

String_88_00_D8::
    db "1EyeClown", $f0

String_88_00_D9::
    db "DeadNite", $f0

String_88_00_DA::
    db "Gismo", $f0

String_88_00_DB::
    db "Octogon", $f0

String_88_00_DC::
    db "Snaily", $f0

String_88_00_DD::
    db "BoxSlime", $f0

String_88_00_DE::
    db "Vampirus", $f0

String_88_00_DF::
    db "Skullroo", $f0

String_88_00_E0::
    db "BullBird", $f0

String_88_00_E1::
    db "DanceVegi", $f0

String_88_00_E2::
    db "StagBug", $f0

String_88_00_E3::
    db "ArmorPede", $f0

String_88_00_E4::
    db "Catapila", $f0

String_88_00_E5::
    db "DarkEye", $f0

String_88_00_E6::
    db "Gremlin", $f0

String_88_00_E7::
    db "MedusaEye", $f0

String_88_00_E8::
    db "EvilArmor", $f0

String_88_00_E9::
    db "MadMirror", $f0

String_88_00_EA::
    db "RogueNite", $f0

String_88_00_EB::
    db "Dumbira", $f0

String_88_00_EC::
    db "Metaly", $f0

String_88_00_ED::
    db "SnakeBat", $f0

String_88_00_EE::
    db "GulpBeast", $f0

String_88_00_EF::
    db "MadGopher", $f0

String_88_00_F0::
    db "MistyWing", $f0

String_88_00_F1::
    db "LandOwl", $f0

String_88_00_F2::
    db "Devipine", $f0

String_88_00_F3::
    db "Belzebub", $f0

String_88_00_F4::
    db "FooHero", $f0

String_88_00_F5::
    db "Bubblemon", $f0

String_88_00_F6::
    db "GoatHorn", $f0

String_88_00_F7::
    db "Spooky", $f0

String_88_00_F8::
    db "PutrePup", $f0

String_88_00_F9::
    db "Copycat", $f0

String_88_00_FA::
    db "MetalDrak", $f0

String_88_00_FB::
    db "RayGigas", $f0

String_88_00_FC::
    db "PearlGel", $f0

String_88_00_FD::
    db "Gasgon", $f0

String_88_00_FE::
    db "Dragon", $f0

String_88_00_FF::
    db "ArrowDog", $f0

String_88_01_00::
    db "KiteHawk", $f0

String_88_01_01::
    db "StubBird", $f0

String_88_01_02::
    db "ZapBird", $f0

String_88_01_03::
    db "WeedBug", $f0

String_88_01_04::
    db "Lipsy", $f0

String_88_01_05::
    db "MultiEyes", $f0

String_88_01_06::
    db "Shadow", $f0

String_88_01_07::
    db "CaptDead", $f0

String_88_01_08::
    db "CurseLamp", $f0

String_88_01_09::
    db "Angleron", $f0

String_88_01_0A::
    db "Gamanian", $f0

String_88_01_0B::
    db "WhaleMage", $f0

String_88_01_0C::
    db "SpotKing", $f0

String_88_01_0D::
    db "SkyDragon", $f0

String_88_01_0E::
    db "Tonguella", $f0

String_88_01_0F::
    db "Saccer", $f0

String_88_01_10::
    db "Wyvern", $f0

String_88_01_11::
    db "AquaHawk", $f0

String_88_01_12::
    db "Garudian", $f0

String_88_01_13::
    db "Eyeder", $f0

String_88_01_14::
    db "ArcDemon", $f0

String_88_01_15::
    db "Lionex", $f0

String_88_01_16::
    db "GateGuard", $f0

String_88_01_17::
    db "Centasaur", $f0

String_88_01_18::
    db "Roboster", $f0

String_88_01_19::
    db "Eggplaton", $f0

String_88_01_1A::
    db "Clawster", $f0

String_88_01_1B::
    db "MerTiger", $f0

String_88_01_1C::
    db "TreeSlime", $f0

String_88_01_1D::
    db "Swordgon", $f0

String_88_01_1E::
    db "SuperTen", $f0

String_88_01_1F::
    db "HammerMan", $f0

String_88_01_20::
    db "Goategon", $f0

String_88_01_21::
    db "Dracky", $f0

String_88_01_22::
    db "PutreFish", $f0

String_88_01_23::
    db "AmberWeed", $f0

String_88_01_24::
    db "WarMantis", $f0

String_88_01_25::
    db "Orc", $f0

String_88_01_26::
    db "ChopClown", $f0

String_88_01_27::
    db "Mummy", $f0

String_88_01_28::
    db "MadSpirit", $f0

String_88_01_29::
    db "PomPomBom", $f0

String_88_01_2A::
    db "BombCrag", $f0

String_88_01_2B::
    db "Octoraid", $f0

String_88_01_2C::
    db "Andreal", $f0

String_88_01_2D::
    db "GreatDrak", $f0

String_88_01_2E::
    db "Trumpeter", $f0

String_88_01_2F::
    db "ProtoMech", $f0

String_88_01_30::
    db "Armorpion", $f0

String_88_01_31::
    db "Digster", $f0

String_88_01_32::
    db "BossTroll", $f0

String_88_01_33::
    db "MadKnight", $f0

String_88_01_34::
    db "Ogre", $f0

String_88_01_35::
    db "DeadNoble", $f0

String_88_01_36::
    db "Skeletor", $f0

String_88_01_37::
    db "StoneMan", $f0

String_88_01_38::
    db "FishRider", $f0

String_88_01_39::
    db "AxeShark", $f0

String_88_01_3A::
    db "Aquadon", $f0

String_88_01_3B::
    db "Digong", $f0

String_88_01_3C::
    db "MetalKing", $f0

String_88_01_3D::
    db "Serpentia", $f0

String_88_01_3E::
    db "Coatol", $f0

String_88_01_3F::
    db "Orochi", $f0

String_88_01_40::
    db "BattleRex", $f0

String_88_01_41::
    db "WhipBird", $f0

String_88_01_42::
    db "Shantak", $f0

String_88_01_43::
    db "Rosevine", $f0

String_88_01_44::
    db "Grendal", $f0

String_88_01_45::
    db "Akubar", $f0

String_88_01_46::
    db "Jamirus", $f0

String_88_01_47::
    db "LampGenie", $f0

String_88_01_48::
    db "WhiteKing", $f0

String_88_01_49::
    db "Niterich", $f0

String_88_01_4A::
    db "KingSquid", $f0

String_88_01_4B::
    db "Grakos", $f0

String_88_01_4C::
    db "Slabbit", $f0

String_88_01_4D::
    db "CoilBird", $f0

String_88_01_4E::
    db "FairyDrak", $f0

String_88_01_4F::
    db "Oniono", $f0

String_88_01_50::
    db "EvilSeed", $f0

String_88_01_51::
    db "MadCandle", $f0

String_88_01_52::
    db "DragonKid", $f0

String_88_01_53::
    db "DuckKite", $f0

String_88_01_54::
    db "WingTree", $f0

String_88_01_55::
    db "GiantSlug", $f0

String_88_01_56::
    db "Gophecada", $f0

String_88_01_57::
    db "RotRaven", $f0

String_88_01_58::
    db "Chamelgon", $f0

String_88_01_59::
    db "MadPecker", $f0

String_88_01_5A::
    db "MadPlant", $f0

String_88_01_5B::
    db "FaceTree", $f0

String_88_01_5C::
    db "BeanMan", $f0

String_88_01_5D::
    db "Catapila", $f0

String_88_01_5E::
    db "Facer", $f0

String_88_01_5F::
    db "Voodoll", $f0

String_88_01_60::
    db "Golem", $f0

String_88_01_61::
    db "RogueWave", $f0

String_88_01_62::
    db "BoxSlime", $f0

String_88_01_63::
    db "SlimeBorg", $f0

String_88_01_64::
    db "DarkHorn", $f0

String_88_01_65::
    db "ManEater", $f0

String_88_01_66::
    db "Snapper", $f0

String_88_01_67::
    db "GhosTree", $f0

String_88_01_68::
    db "SkulRider", $f0

String_88_01_69::
    db "Gigantes", $f0

String_88_01_6A::
    db "Skulpent", $f0

String_88_01_6B::
    db "Aquarella", $f0

String_88_01_6C::
    db "GoldSlime", $f0

String_88_01_6D::
    db "GranSlime", $f0

String_88_01_6E::
    db "Divinegon", $f0

String_88_01_6F::
    db "KingLeo", $f0

String_88_01_70::
    db "RainHawk", $f0

String_88_01_71::
    db "Durran", $f0

String_88_01_72::
    db "Lazamanus", $f0

String_88_01_73::
    db "GoldGolem", $f0

String_88_01_74::
    db "PillowRat", $f0

String_88_01_75::
    db "ArmorPede", $f0

String_88_01_76::
    db "WildApe", $f0

String_88_01_77::
    db "Clawster", $f0

String_88_01_78::
    db "Gulpple", $f0

String_88_01_79::
    db "Darck", $f0

String_88_01_7A::
    db "MadCat", $f0

String_88_01_7B::
    db "HornBeet", $f0

String_88_01_7C::
    db "SkyDragon", $f0

String_88_01_7D::
    db "Octogon", $f0

String_88_01_7E::
    db "Servant", $f0

String_88_01_7F::
    db "Darck", $f0

String_88_01_80::
    db "GiantWorm", $f0

String_88_01_81::
    db "Spooky", $f0

String_88_01_82::
    db "Beavern", $f0

String_88_01_84::
    db "MadCandle", $f0

String_88_01_85::
    db "SpikyBoy", $f0

String_88_01_86::
    db "Anemon", $f0

String_88_01_87::
    db "ArrowDog", $f0

String_88_01_88::
    db "Pyuro", $f0

String_88_01_89::
    db "DanceVegi", $f0

String_88_01_8A::
    db "Brushead", $f0

String_88_01_8B::
    db "MiniDrak", $f0

String_88_01_8C::
    db "Pteranod", $f0

String_88_01_8D::
    db "DragonKid", $f0

String_88_01_8E::
    db "CatFly", $f0

String_88_01_8F::
    db "BoneSlave", $f0

String_88_01_90::
    db "KingSquid", $f0

String_88_01_91::
    db "BeastNite", $f0

String_88_01_92::
    db "Drygon", $f0

String_88_01_93::
    db "Pumpoise", $f0

String_88_01_94::
    db "FishRider", $f0

String_88_01_95::
    db "WalrusMan", $f0

String_88_01_96::
    db "Stubsuck", $f0

String_88_01_97::
    db "Shadow", $f0

String_88_01_98::
    db "WingTree", $f0

String_88_01_99::
    db "AgDevil", $f0

String_88_01_9A::
    db "Puppetor", $f0

String_88_01_9B::
    db "ArcDemon", $f0

String_88_01_9C::
    db "GoatHorn", $f0

String_88_01_9D::
    db "MetalDrak", $f0

String_88_01_9E::
    db "AgDevil", $f0

String_88_01_9F::
    db "Puppetor", $f0

String_88_01_A0::
    db "Golem", $f0

String_88_01_A1::
    db "EvilSeed", $f0

String_88_01_A2::
    db "EyeBall", $f0

String_88_01_A3::
    db "Chamelgon", $f0

String_88_01_A4::
    db "FooHero", $f0

String_88_01_A5::
    db "BoxSlime", $f0

String_88_01_A6::
    db "Metabble", $f0

String_88_01_A7::
    db "FairyRat", $f0

String_88_01_A8::
    db "Swordgon", $f0

String_88_01_A9::
    db "Mommonja", $f0

String_88_01_AA::
    db "KiteHawk", $f0

String_88_01_AB::
    db "MadCondor", $f0

String_88_01_AD::
    db "WingSnake", $f0

String_88_01_AE::
    db "GreatDrak", $f0

String_88_01_AF::
    db "KingSquid", $f0

String_88_01_B0::
    db "WindBeast", $f0

String_88_01_B1::
    db "MadGoose", $f0

String_88_01_B2::
    db "WhaleMage", $f0

String_88_01_B3::
    db "SeaHorse", $f0

String_88_01_B4::
    db "Octoreach", $f0

String_88_01_B5::
    db "IceMan", $f0

String_88_01_B6::
    db "Shadow", $f0

String_88_01_B7::
    db "BigEye", $f0

String_88_01_B8::
    db "Balzak", $f0

String_88_01_B9::
    db "RotRaven", $f0

String_88_01_BA::
    db "Jamirus", $f0

String_88_01_BB::
    db "SkyDragon", $f0

String_88_01_BC::
    db "Gremlin", $f0

String_88_01_BD::
    db "Crestpent", $f0

String_88_01_BE::
    db "SpotKing", $f0

String_88_01_BF::
    db "Gulpple", $f0

String_88_01_C0::
    db "FairyDrak", $f0

String_88_01_C1::
    db "DuckKite", $f0

String_88_01_C2::
    db "FunkyBird", $f0

String_88_01_C3::
    db "DanceVegi", $f0

String_88_01_C4::
    db "Slurperon", $f0

String_88_01_C5::
    db "MadPlant", $f0

String_88_01_C6::
    db "Orc", $f0

String_88_01_C7::
    db "PutrePup", $f0

String_88_01_C8::
    db "Devipine", $f0

String_88_01_C9::
    db "Anemon", $f0

String_88_01_CA::
    db "HerbMan", $f0

String_88_01_CB::
    db "KingSlime", $f0

String_88_01_CC::
    db "Coatol", $f0

String_88_01_CD::
    db "FangSlime", $f0

String_88_01_CE::
    db "Grizzly", $f0

String_88_01_CF::
    db "BeastNite", $f0

String_88_01_D0::
    db "Healer", $f0

String_88_01_D1::
    db "Unicorn", $f0

String_88_01_D2::
    db "SuperTen", $f0

String_88_01_D3::
    db "Slime", $f0

String_88_01_D4::
    db "RockSlime", $f0

String_88_01_D5::
    db "Metabble", $f0

String_88_01_D6::
    db "Gorago", $f0

String_88_01_D7::
    db "Slabbit", $f0

String_88_01_D8::
    db "MultiEyes", $f0

String_88_01_D9::
    db "FairyRat", $f0

String_88_01_DA::
    db "Stubsuck", $f0

String_88_01_DB::
    db "MadPlant", $f0

String_88_01_DC::
    db "Snapper", $f0

String_88_01_DD::
    db "Grendal", $f0

String_88_01_DE::
    db "GoHopper", $f0

String_88_01_DF::
    db "ArrowDog", $f0

String_88_01_E0::
    db "StagBug", $f0

String_88_01_E1::
    db "FireWeed", $f0

String_88_01_E2::
    db "AgDevil", $f0

String_88_01_E3::
    db "Grizzly", $f0

String_88_01_E4::
    db "SkulRider", $f0

String_88_01_E5::
    db "WalrusMan", $f0

String_88_01_E6::
    db "MadCandle", $f0

String_88_01_E7::
    db "Reaper", $f0

String_88_01_E8::
    db "ProtoMech", $f0

String_88_01_E9::
    db "Roboster", $f0

String_88_01_ED::
    db "CatMage", $f0

String_88_01_EE::
    db "FaceTree", $f0

String_88_01_EF::
    db "Ogre", $f0

String_88_01_F0::
    db "CurseLamp", $f0

String_88_01_F1::
    db "Anemon", $f0

String_88_01_F2::
    db "Lipsy", $f0

String_88_01_F3::
    db "WeedBug", $f0

String_88_01_F4::
    db "Spikerous", $f0

String_88_01_F5::
    db "Skullgon", $f0

String_88_01_F6::
    db "Skulpent", $f0

String_88_01_F7::
    db "Butterfly", $f0

String_88_01_F8::
    db "Pixy", $f0

String_88_01_F9::
    db "Copycat", $f0

String_88_01_FA::
    db "StoneMan", $f0

String_88_01_FB::
    db "WhipBird", $f0

String_88_01_FC::
    db "MimeSlime", $f0

String_88_01_FD::
    db "Tonguella", $f0

String_88_01_FE::
    db "Golem", $f0

String_88_01_FF::
    db "Bubblemon", $f0

String_88_02_00::
    db "RogueNite", $f0

String_88_02_01::
    db "Puppetor", $f0

String_88_02_02::
    db "Exaucers", $f0

String_88_02_03::
    db "WhaleMage", $f0

String_88_02_04::
    db "MedusaEye", $f0

String_88_02_05::
    db "MetalKing", $f0

String_88_02_06::
    db "KingLeo", $f0

String_88_02_07::
    db "GoldGolem", $f0

String_88_02_08::
    db "GreatDrak", $f0

String_88_02_09::
    db "Watabou", $f0

String_88_02_0A::
    db "Durran", $f0

String_88_02_0B::
    db "Demonite", $f0

String_88_02_0C::
    db "BossTroll", $f0

String_88_02_0D::
    db "JewelBag", $f0

String_88_02_0E::
    db "BoneSlave", $f0

String_88_02_0F::
    db "DeadNoble", $f0

String_88_02_10::
    db "RogueNite", $f0

String_88_02_11::
    db "Balzak", $f0

String_88_02_12::
    db "Voodoll", $f0

String_88_02_13::
    db "GateGuard", $f0

String_88_02_14::
    db "MadMirror", $f0

String_88_02_15::
    db "Grakos", $f0

String_88_02_16::
    db "Scallopa", $f0

String_88_02_17::
    db "Snaily", $f0

String_88_02_18::
    db "Clawster", $f0

String_88_02_19::
    db "Shadow", $f0

String_88_02_1A::
    db "Mimic", $f0

String_88_02_1B::
    db "MetalKing", $f0

String_88_02_1C::
    db "RainHawk", $f0

String_88_02_1D::
    db "Coatol", $f0

String_88_02_1E::
    db "Phoenix", $f0

String_88_02_1F::
    db "Shantak", $f0

String_88_02_20::
    db "Blizzardy", $f0

String_88_02_21::
    db "Skullgon", $f0

String_88_02_22::
    db "Akubar", $f0

String_88_02_23::
    db "DarkHorn", $f0

String_88_02_24::
    db "Serpentia", $f0

String_88_02_25::
    db "SuperTen", $f0

String_88_02_26::
    db "Unicorn", $f0

String_88_02_27::
    db "KiteHawk", $f0

String_88_02_28::
    db "FoxFire", $f0

String_88_02_29::
    db "MetalDrak", $f0

String_88_02_2A::
    db "AxeShark", $f0

String_88_02_2B::
    db "StoneMan", $f0

String_88_02_2C::
    db "MedusaEye", $f0

String_88_02_2D::
    db "MadHornet", $f0

String_88_02_2E::
    db "Oniono", $f0

String_88_02_2F::
    db "TailEater", $f0

String_88_02_30::
    db "BeastNite", $f0

String_88_02_31::
    db "MimeSlime", $f0

String_88_02_32::
    db "MadDragon", $f0

String_88_02_33::
    db "WingSnake", $f0

String_88_02_34::
    db "Orochi", $f0

String_88_02_35::
    db "Trumpeter", $f0

String_88_02_36::
    db "Wyvern", $f0

String_88_02_37::
    db "Devipine", $f0

String_88_02_38::
    db "Snapper", $f0

String_88_02_39::
    db "StagBug", $f0

String_88_02_3A::
    db "ArmyCrab", $f0

String_88_02_3B::
    db "ArcDemon", $f0

String_88_02_3C::
    db "1EyeClown", $f0

String_88_02_3D::
    db "MadKnight", $f0

String_88_02_3E::
    db "CaptDead", $f0

String_88_02_3F::
    db "Servant", $f0

String_88_02_40::
    db "LavaMan", $f0

String_88_02_41::
    db "BombCrag", $f0

String_88_02_42::
    db "RushFish", $f0

String_88_02_43::
    db "WhaleMage", $f0

String_88_02_44::
    db "SpotKing", $f0

String_88_02_45::
    db "SlimeBorg", $f0

String_88_02_46::
    db "LizardMan", $f0

String_88_02_47::
    db "GreatDrak", $f0

String_88_02_48::
    db "MadCat", $f0

String_88_02_49::
    db "Emyu", $f0

String_88_02_4A::
    db "HornBeet", $f0

String_88_02_4B::
    db "Ogre", $f0

String_88_02_4C::
    db "PutrePup", $f0

String_88_02_4D::
    db "Roboster2", $f0

String_88_02_4E::
    db "GoldGolem", $f0

String_88_02_4F::
    db "WhiteKing", $f0

String_88_02_50::
    db "GoldSlime", $f0

String_88_02_51::
    db "Divinegon", $f0

String_88_02_52::
    db "KingLeo", $f0

String_88_02_53::
    db "RainHawk", $f0

String_88_02_54::
    db "Rosevine", $f0

String_88_02_55::
    db "Armorpion", $f0

String_88_02_56::
    db "Durran", $f0

String_88_02_57::
    db "Aquadon", $f0

String_88_02_58::
    db "Warubou", $f0

String_88_02_59::
    db "Petibou", $f0

String_88_02_5A::
    db "Skeletor", $f0

String_88_02_5B::
    db "StoneMan", $f0

String_88_02_5C::
    db "FunkyBird", $f0

String_88_02_5D::
    db "Copycat", $f0

String_88_02_5E::
    db "Andreal", $f0

String_88_02_5F::
    db "Drygon", $f0

String_88_02_60::
    db "Butch", $f0

String_88_02_61::
    db "Pumpoise", $f0

String_88_02_62::
    db "LordDraco", $f0

String_88_02_63::
    db "ArcDemon", $f0

String_88_02_64::
    db "WhipBird", $f0

String_88_02_65::
    db "StoneMan", $f0

String_88_02_66::
    db "DeadNoble", $f0

String_88_02_67::
    db "MetalKing", $f0

String_88_02_68::
    db "Serpentia", $f0

String_88_02_69::
    db "IronTurt", $f0

String_88_02_6A::
    db "ZapBird", $f0

String_88_02_6B::
    db "FooHero", $f0

String_88_02_6C::
    db "GoatHorn", $f0

String_88_02_6D::
    db "Inverzon", $f0

String_88_02_6E::
    db "Voodoll", $f0

String_88_02_6F::
    db "AxeShark", $f0

String_88_02_70::
    db "Digong", $f0

String_88_02_71::
    db "Swordgon", $f0

String_88_02_72::
    db "GigaDraco", $f0

String_88_02_73::
    db "SuperTen", $f0

String_88_02_74::
    db "BigRoost", $f0

String_88_02_75::
    db "GhosTree", $f0

String_88_02_76::
    db "WarMantis", $f0

String_88_02_77::
    db "Healer", $f0

String_88_02_78::
    db "Kagebou", $f0

String_88_02_79::
    db "Dimensaur", $f0

String_88_02_7A::
    db "Lamia", $f0

String_88_02_7B::
    db "DracoLord", $f0

String_88_02_7D::
    db "LordDraco", $f0

String_88_02_7E::
    db "Hargon", $f0

String_88_02_7F::
    db "Sidoh", $f0

String_88_02_80::
    db "Genosidoh", $f0

String_88_02_81::
    db "Baramos", $f0

String_88_02_82::
    db "Zoma", $f0

String_88_02_83::
    db "AsuraZoma", $f0

String_88_02_84::
    db "Pizzaro", $f0

String_88_02_85::
    db "PsychoPiz", $f0

String_88_02_86::
    db "Esterk", $f0

String_88_02_87::
    db "Mirudraas", $f0

String_88_02_89::
    db "Mudou", $f0

String_88_02_8A::
    db "DeathMore", $f0

String_88_02_8D::
    db "Darkdrium", $f0

String_88_02_8E::
    db "Orgodemir", $f0

String_88_02_90::
    db "Darck", $f0

String_88_02_91::
    db "HaloSlime", $f0

String_88_02_92::
    db "GoldSlime", $f0

String_88_02_93::
    db "GranSlime", $f0

String_88_02_94::
    db "WonderEgg", $f0

String_88_02_95::
    db "Orligon", $f0

String_88_02_96::
    db "GigaDraco", $f0

String_88_02_97::
    db "DarkHorn", $f0

String_88_02_98::
    db "Gorago", $f0

String_88_02_99::
    db "RainHawk", $f0

String_88_02_9A::
    db "Azurile", $f0

String_88_02_9B::
    db "Shantak", $f0

String_88_02_9C::
    db "Watabou", $f0

String_88_02_9D::
    db "Warubou", $f0

String_88_02_9E::
    db "Egdracil", $f0

String_88_02_9F::
    db "Digster", $f0

String_88_02_A0::
    db "Skularach", $f0

String_88_02_A1::
    db "Titanis", $f0

String_88_02_A2::
    db "LampGenie", $f0

String_88_02_A3::
    db "Niterich", $f0

String_88_02_A4::
    db "WhiteKing", $f0

String_88_02_A5::
    db "Lazamanus", $f0

String_88_02_A6::
    db "GoldGolem", $f0

String_88_02_A7::
    db "DarkMate", $f0

String_88_02_A8::
    db "Octogon", $f0

String_88_02_A9::
    db "Octoraid", $f0

String_88_02_AA::
    db "Grakos", $f0

String_88_02_AB::
    db "Poseidon", $f0

String_88_02_AC::
    db "Slime", $f0

String_88_02_AD::
    db "Undefined", $f0
    db $30, $28, $f0, $1e, $31, $27, $28, $29, $2c, $31, $28, $27, $f0
    ds $2332, $00
