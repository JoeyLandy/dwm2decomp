SECTION "Bank 88", ROMX[$4000], BANK[$88]
    db $88

; ld de, this bank's string table / BeginStringDisplay
; 2 call sites from 2 routines (e.g. ShowString_Bank88, DebugMessageTest_Update_Case11)
BeginStringDisplay_Bank88::
Func_088_4001:: ; address name
    ld de, StringCategories_88_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_088_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 2 call sites from 2 routines (e.g. DebugShowMonsterRecord, DebugBattleSetupShowFieldString)
ShowString_Bank88::
Func_088_400F:: ; address name
    call BeginStringDisplay_Bank88
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_88_4016::
Data_088_4016:: ; address name
    dw StringList_88_401C ; id 0
    dw StringList_88_421C ; id 1
    dw StringList_88_441C ; id 2

; E-0217 (derived: category list of StringCategories_88_4016; one pointer per wStringIndex)
; record: string
StringList_88_401C::
Data_088_401C:: ; address name
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

; E-0217 (derived: category list of StringCategories_88_4016; one pointer per wStringIndex)
; record: string
StringList_88_421C::
Data_088_421C:: ; address name
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

; E-0217 (derived: category list of StringCategories_88_4016; one pointer per wStringIndex)
; record: string
StringList_88_441C::
Data_088_441C:: ; address name
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

String_88_00_00:: ; heuristic: string; C0
Data_088_461C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "None", $F0

String_88_00_01:: ; heuristic: string; C0
Data_088_4621:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slime", $F0

String_88_00_02:: ; heuristic: string; C0
Data_088_4627:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpotSlime", $F0

String_88_00_03:: ; heuristic: string; C0
Data_088_4631:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CactiBall", $F0

String_88_00_04:: ; heuristic: string; C0
Data_088_463B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TailEater", $F0

String_88_00_05:: ; heuristic: string; C0
Data_088_4645:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Crestpent", $F0

String_88_00_06:: ; heuristic: string; C0
Data_088_464F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingCobra", $F0

String_88_00_07:: ; heuristic: string; C0
Data_088_4659:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CurseLamp", $F0

String_88_00_09:: ; heuristic: string; C0
Data_088_4663:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slime", $F0

String_88_00_0A:: ; heuristic: string; C0
Data_088_4669:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Antbear", $F0

String_88_00_0B:: ; heuristic: string; C0
Data_088_4671:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dracky", $F0

String_88_00_0C:: ; heuristic: string; C0
Data_088_4678:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eggplaton", $F0

String_88_00_0D:: ; heuristic: string; C0
Data_088_4682:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "JewelBag", $F0

String_88_00_0E:: ; heuristic: string; C0
Data_088_468B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hork", $F0

String_88_00_0F:: ; heuristic: string; C0
Data_088_4690:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wyvern", $F0

String_88_00_10:: ; heuristic: string; C0
Data_088_4697:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArmyAnt", $F0

String_88_00_11:: ; heuristic: string; C0
Data_088_469F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadGopher", $F0

String_88_00_12:: ; heuristic: string; C0
Data_088_46A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "1EyeClown", $F0

String_88_00_13:: ; heuristic: string; C0
Data_088_46B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snaily", $F0

String_88_00_14:: ; heuristic: string; C0
Data_088_46BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Poisongon", $F0

String_88_00_15:: ; heuristic: string; C0
Data_088_46C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moray", $F0

String_88_00_16:: ; heuristic: string; C0
Data_088_46CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eyeder", $F0

String_88_00_17:: ; heuristic: string; C0
Data_088_46D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PutreFish", $F0

String_88_00_18:: ; heuristic: string; C0
Data_088_46DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gamanian", $F0

String_88_00_19:: ; heuristic: string; C0
Data_088_46E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpikyBoy", $F0

String_88_00_1A:: ; heuristic: string; C0
Data_088_46ED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HoodSquid", $F0

String_88_00_1C:: ; heuristic: string; C0
Data_088_46F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CaptDead", $F0

String_88_00_1D:: ; heuristic: string; C0
Data_088_4700:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Petiteel", $F0

String_88_00_1E:: ; heuristic: string; C0
Data_088_4709:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RotRaven", $F0

String_88_00_1F:: ; heuristic: string; C0
Data_088_4712:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Merman", $F0

String_88_00_20:: ; heuristic: string; C0
Data_088_4719:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octokid", $F0

String_88_00_21:: ; heuristic: string; C0
Data_088_4721:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RogueWave", $F0

String_88_00_22:: ; heuristic: string; C0
Data_088_472B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PearlGel", $F0

String_88_00_23:: ; heuristic: string; C0
Data_088_4734:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tortragon", $F0

String_88_00_24:: ; heuristic: string; C0
Data_088_473E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AquaHawk", $F0

String_88_00_25:: ; heuristic: string; C0
Data_088_4747:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkEye", $F0

String_88_00_26:: ; heuristic: string; C0
Data_088_474F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RayGigas", $F0

String_88_00_27:: ; heuristic: string; C0
Data_088_4758:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilWand", $F0

String_88_00_28:: ; heuristic: string; C0
Data_088_4761:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SlimeNite", $F0

String_88_00_29:: ; heuristic: string; C0
Data_088_476B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LizardMan", $F0

String_88_00_2A:: ; heuristic: string; C0
Data_088_4775:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HammerMan", $F0

String_88_00_2B:: ; heuristic: string; C0
Data_088_477F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yeti", $F0

String_88_00_2C:: ; heuristic: string; C0
Data_088_4784:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orc", $F0

String_88_00_2D:: ; heuristic: string; C0
Data_088_4788:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gismo", $F0

String_88_00_2E:: ; heuristic: string; C0
Data_088_478E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Droll", $F0

String_88_00_2F:: ; heuristic: string; C0
Data_088_4794:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Goopi", $F0

String_88_00_30:: ; heuristic: string; C0
Data_088_479A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mummy", $F0

String_88_00_31:: ; heuristic: string; C0
Data_088_47A0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TreeBoy", $F0

String_88_00_32:: ; heuristic: string; C0
Data_088_47A8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BombCrag", $F0

String_88_00_33:: ; heuristic: string; C0
Data_088_47B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RogueNite", $F0

String_88_00_34:: ; heuristic: string; C0
Data_088_47BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grizzly", $F0

String_88_00_35:: ; heuristic: string; C0
Data_088_47C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demonite", $F0

String_88_00_36:: ; heuristic: string; C0
Data_088_47CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gulpple", $F0

String_88_00_37:: ; heuristic: string; C0
Data_088_47D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FoxFire", $F0

String_88_00_38:: ; heuristic: string; C0
Data_088_47DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Almiraj", $F0

String_88_00_39:: ; heuristic: string; C0
Data_088_47E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LandOwl", $F0

String_88_00_3A:: ; heuristic: string; C0
Data_088_47EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Goategon", $F0

String_88_00_3B:: ; heuristic: string; C0
Data_088_47F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Saccer", $F0

String_88_00_3C:: ; heuristic: string; C0
Data_088_47FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WingSlime", $F0

String_88_00_3D:: ; heuristic: string; C0
Data_088_4806:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BullBird", $F0

String_88_00_3E:: ; heuristic: string; C0
Data_088_480F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CragDevil", $F0

String_88_00_3F:: ; heuristic: string; C0
Data_088_4819:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starfish", $F0

String_88_00_40:: ; heuristic: string; C0
Data_088_4822:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SeaHorse", $F0

String_88_00_41:: ; heuristic: string; C0
Data_088_482B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ManEater", $F0

String_88_00_42:: ; heuristic: string; C0
Data_088_4834:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StubBird", $F0

String_88_00_43:: ; heuristic: string; C0
Data_088_483D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GiantMoth", $F0

String_88_00_44:: ; heuristic: string; C0
Data_088_4847:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoatHorn", $F0

String_88_00_45:: ; heuristic: string; C0
Data_088_4850:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FangSlime", $F0

String_88_00_46:: ; heuristic: string; C0
Data_088_485A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RockSlime", $F0

String_88_00_47:: ; heuristic: string; C0
Data_088_4864:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadRaven", $F0

String_88_00_48:: ; heuristic: string; C0
Data_088_486D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Emyu", $F0

String_88_00_49:: ; heuristic: string; C0
Data_088_4872:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FloraMan", $F0

String_88_00_4A:: ; heuristic: string; C0
Data_088_487B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slurperon", $F0

String_88_00_4B:: ; heuristic: string; C0
Data_088_4885:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster", $F0

String_88_00_4C:: ; heuristic: string; C0
Data_088_488E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadDragon", $F0

String_88_00_4D:: ; heuristic: string; C0
Data_088_4898:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dragon", $F0

String_88_00_4E:: ; heuristic: string; C0
Data_088_489F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IronTurt", $F0

String_88_00_4F:: ; heuristic: string; C0
Data_088_48A8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadMirror", $F0

String_88_00_50:: ; heuristic: string; C0
Data_088_48B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SabreMan", $F0

String_88_00_51:: ; heuristic: string; C0
Data_088_48BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilBeast", $F0

String_88_00_52:: ; heuristic: string; C0
Data_088_48C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WarMantis", $F0

String_88_00_53:: ; heuristic: string; C0
Data_088_48CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Phoenix", $F0

String_88_00_54:: ; heuristic: string; C0
Data_088_48D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FireWeed", $F0

String_88_00_55:: ; heuristic: string; C0
Data_088_48E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WildApe", $F0

String_88_00_56:: ; heuristic: string; C0
Data_088_48E8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dumbira", $F0

String_88_00_57:: ; heuristic: string; C0
Data_088_48F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Belzebub", $F0

String_88_00_58:: ; heuristic: string; C0
Data_088_48F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Metaly", $F0

String_88_00_59:: ; heuristic: string; C0
Data_088_4900:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GhosTree", $F0

String_88_00_5A:: ; heuristic: string; C0
Data_088_4909:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Babble", $F0

String_88_00_5B:: ; heuristic: string; C0
Data_088_4910:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lionex", $F0

String_88_00_5C:: ; heuristic: string; C0
Data_088_4917:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadGoose", $F0

String_88_00_5D:: ; heuristic: string; C0
Data_088_4920:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bubblemon", $F0

String_88_00_5E:: ; heuristic: string; C0
Data_088_492A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gigantes", $F0

String_88_00_5F:: ; heuristic: string; C0
Data_088_4933:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Exaucers", $F0

String_88_00_60:: ; heuristic: string; C0
Data_088_493C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeadNite", $F0

String_88_00_61:: ; heuristic: string; C0
Data_088_4945:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GateGuard", $F0

String_88_00_62:: ; heuristic: string; C0
Data_088_494F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadSpirit", $F0

String_88_00_63:: ; heuristic: string; C0
Data_088_4959:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Copycat", $F0

String_88_00_64:: ; heuristic: string; C0
Data_088_4961:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Niterich", $F0

String_88_00_65:: ; heuristic: string; C0
Data_088_496A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Andreal", $F0

String_88_00_66:: ; heuristic: string; C0
Data_088_4972:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadKnight", $F0

String_88_00_67:: ; heuristic: string; C0
Data_088_497C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SkyDragon", $F0

String_88_00_68:: ; heuristic: string; C0
Data_088_4986:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CoilBird", $F0

String_88_00_69:: ; heuristic: string; C0
Data_088_498F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArmorPede", $F0

String_88_00_6A:: ; heuristic: string; C0
Data_088_4999:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadHornet", $F0

String_88_00_6B:: ; heuristic: string; C0
Data_088_49A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mudou", $F0

String_88_00_6C:: ; heuristic: string; C0
Data_088_49A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilArmor", $F0

String_88_00_6D:: ; heuristic: string; C0
Data_088_49B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skeletor", $F0

String_88_00_6E:: ; heuristic: string; C0
Data_088_49BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Vampirus", $F0

String_88_00_6F:: ; heuristic: string; C0
Data_088_49C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Florajay", $F0

String_88_00_70:: ; heuristic: string; C0
Data_088_49CE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BossTroll", $F0

String_88_00_71:: ; heuristic: string; C0
Data_088_49D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ChopClown", $F0

String_88_00_72:: ; heuristic: string; C0
Data_088_49E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MistyWing", $F0

String_88_00_73:: ; heuristic: string; C0
Data_088_49EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Centasaur", $F0

String_88_00_74:: ; heuristic: string; C0
Data_088_49F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GigaDraco", $F0

String_88_00_75:: ; heuristic: string; C0
Data_088_4A00:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Garudian", $F0

String_88_00_76:: ; heuristic: string; C0
Data_088_4A09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mimic", $F0

String_88_00_7E:: ; heuristic: string; C0
Data_088_4A0F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tatsu", $F0

String_88_00_7F:: ; heuristic: string; C0
Data_088_4A15:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Diago", $F0

String_88_00_80:: ; heuristic: string; C0
Data_088_4A1B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Samsi", $F0

String_88_00_81:: ; heuristic: string; C0
Data_088_4A21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bazoo", $F0

String_88_00_82:: ; heuristic: string; C0
Data_088_4A27:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeDragon", $F0

String_88_00_83:: ; heuristic: string; C0
Data_088_4A30:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Babble", $F0

String_88_00_84:: ; heuristic: string; C0
Data_088_4A37:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PearlGel", $F0

String_88_00_85:: ; heuristic: string; C0
Data_088_4A40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpikyBoy", $F0

String_88_00_86:: ; heuristic: string; C0
Data_088_4A49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Brushead", $F0

String_88_00_87:: ; heuristic: string; C0
Data_088_4A52:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dracky", $F0

String_88_00_88:: ; heuristic: string; C0
Data_088_4A59:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadRaven", $F0

String_88_00_89:: ; heuristic: string; C0
Data_088_4A62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KiteHawk", $F0

String_88_00_8A:: ; heuristic: string; C0
Data_088_4A6B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WindBeast", $F0

String_88_00_8B:: ; heuristic: string; C0
Data_088_4A75:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gismo", $F0

String_88_00_8C:: ; heuristic: string; C0
Data_088_4A7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PomPomBom", $F0

String_88_00_8D:: ; heuristic: string; C0
Data_088_4A85:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Devipine", $F0

String_88_00_8E:: ; heuristic: string; C0
Data_088_4A8E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gulpple", $F0

String_88_00_8F:: ; heuristic: string; C0
Data_088_4A96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eggplaton", $F0

String_88_00_90:: ; heuristic: string; C0
Data_088_4AA0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HammerMan", $F0

String_88_00_91:: ; heuristic: string; C0
Data_088_4AAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stubsuck", $F0

String_88_00_92:: ; heuristic: string; C0
Data_088_4AB3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TreeBoy", $F0

String_88_00_93:: ; heuristic: string; C0
Data_088_4ABB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FooHero", $F0

String_88_00_94:: ; heuristic: string; C0
Data_088_4AC3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mommonja", $F0

String_88_00_95:: ; heuristic: string; C0
Data_088_4ACC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drygon", $F0

String_88_00_96:: ; heuristic: string; C0
Data_088_4AD3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HerbMan", $F0

String_88_00_97:: ; heuristic: string; C0
Data_088_4ADB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DanceVegi", $F0

String_88_00_98:: ; heuristic: string; C0
Data_088_4AE5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MudDoll", $F0

String_88_00_99:: ; heuristic: string; C0
Data_088_4AED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shadow", $F0

String_88_00_9A:: ; heuristic: string; C0
Data_088_4AF4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCondor", $F0

String_88_00_9B:: ; heuristic: string; C0
Data_088_4AFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CloudKing", $F0

String_88_00_9C:: ; heuristic: string; C0
Data_088_4B08:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octoreach", $F0

String_88_00_9D:: ; heuristic: string; C0
Data_088_4B12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octogon", $F0

String_88_00_9E:: ; heuristic: string; C0
Data_088_4B1A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingSquid", $F0

String_88_00_9F:: ; heuristic: string; C0
Data_088_4B24:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MistyWing", $F0

String_88_00_A0:: ; heuristic: string; C0
Data_088_4B2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Copycat", $F0

String_88_00_A1:: ; heuristic: string; C0
Data_088_4B36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "NiteWhip", $F0

String_88_00_A2:: ; heuristic: string; C0
Data_088_4B3F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Goopi", $F0

String_88_00_A3:: ; heuristic: string; C0
Data_088_4B45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Servant", $F0

String_88_00_A4:: ; heuristic: string; C0
Data_088_4B4D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArmyCrab", $F0

String_88_00_A5:: ; heuristic: string; C0
Data_088_4B56:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkCrab", $F0

String_88_00_A6:: ; heuristic: string; C0
Data_088_4B5F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orochi", $F0

String_88_00_A7:: ; heuristic: string; C0
Data_088_4B66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Serpentia", $F0

String_88_00_A8:: ; heuristic: string; C0
Data_088_4B70:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GigaDraco", $F0

String_88_00_A9:: ; heuristic: string; C0
Data_088_4B7A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingLeo", $F0

String_88_00_AA:: ; heuristic: string; C0
Data_088_4B82:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Azurile", $F0

String_88_00_AB:: ; heuristic: string; C0
Data_088_4B8A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Divinegon", $F0

String_88_00_AC:: ; heuristic: string; C0
Data_088_4B94:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pteranod", $F0

String_88_00_AD:: ; heuristic: string; C0
Data_088_4B9D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WindBeast", $F0

String_88_00_AE:: ; heuristic: string; C0
Data_088_4BA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FairyRat", $F0

String_88_00_AF:: ; heuristic: string; C0
Data_088_4BB0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BigEye", $F0

String_88_00_B0:: ; heuristic: string; C0
Data_088_4BB7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BullBird", $F0

String_88_00_B1:: ; heuristic: string; C0
Data_088_4BC0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TreeBoy", $F0

String_88_00_B2:: ; heuristic: string; C0
Data_088_4BC8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoHopper", $F0

String_88_00_B3:: ; heuristic: string; C0
Data_088_4BD1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilBeast", $F0

String_88_00_B4:: ; heuristic: string; C0
Data_088_4BDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mudron", $F0

String_88_00_B5:: ; heuristic: string; C0
Data_088_4BE2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reaper", $F0

String_88_00_B6:: ; heuristic: string; C0
Data_088_4BE9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mummy", $F0

String_88_00_B7:: ; heuristic: string; C0
Data_088_4BEF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "JewelBag", $F0

String_88_00_B8:: ; heuristic: string; C0
Data_088_4BF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starfish", $F0

String_88_00_B9:: ; heuristic: string; C0
Data_088_4C01:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Brushead", $F0

String_88_00_BA:: ; heuristic: string; C0
Data_088_4C0A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MudDoll", $F0

String_88_00_BB:: ; heuristic: string; C0
Data_088_4C12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RushFish", $F0

String_88_00_BC:: ; heuristic: string; C0
Data_088_4C1B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WingSlime", $F0

String_88_00_BD:: ; heuristic: string; C0
Data_088_4C25:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Poisongon", $F0

String_88_00_BE:: ; heuristic: string; C0
Data_088_4C2F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drygon", $F0

String_88_00_BF:: ; heuristic: string; C0
Data_088_4C36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CatFly", $F0

String_88_00_C0:: ; heuristic: string; C0
Data_088_4C3D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mommonja", $F0

String_88_00_C1:: ; heuristic: string; C0
Data_088_4C46:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grizzly", $F0

String_88_00_C2:: ; heuristic: string; C0
Data_088_4C4E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CragDevil", $F0

String_88_00_C3:: ; heuristic: string; C0
Data_088_4C58:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Picky", $F0

String_88_00_C4:: ; heuristic: string; C0
Data_088_4C5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pixy", $F0

String_88_00_C5:: ; heuristic: string; C0
Data_088_4C63:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AgDevil", $F0

String_88_00_C6:: ; heuristic: string; C0
Data_088_4C6B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hork", $F0

String_88_00_C7:: ; heuristic: string; C0
Data_088_4C70:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WindMerge", $F0

String_88_00_C8:: ; heuristic: string; C0
Data_088_4C7A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpikyBoy", $F0

String_88_00_C9:: ; heuristic: string; C0
Data_088_4C83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Goopi", $F0

String_88_00_CA:: ; heuristic: string; C0
Data_088_4C89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octokid", $F0

String_88_00_CB:: ; heuristic: string; C0
Data_088_4C91:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CancerMan", $F0

String_88_00_CC:: ; heuristic: string; C0
Data_088_4C9B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SlimeNite", $F0

String_88_00_CD:: ; heuristic: string; C0
Data_088_4CA5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Babble", $F0

String_88_00_CE:: ; heuristic: string; C0
Data_088_4CAC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rayburn", $F0

String_88_00_CF:: ; heuristic: string; C0
Data_088_4CB4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CatMage", $F0

String_88_00_D0:: ; heuristic: string; C0
Data_088_4CBC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yeti", $F0

String_88_00_D1:: ; heuristic: string; C0
Data_088_4CC1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beavern", $F0

String_88_00_D2:: ; heuristic: string; C0
Data_088_4CC9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Florajay", $F0

String_88_00_D3:: ; heuristic: string; C0
Data_088_4CD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Toadstool", $F0

String_88_00_D4:: ; heuristic: string; C0
Data_088_4CDC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GiantMoth", $F0

String_88_00_D5:: ; heuristic: string; C0
Data_088_4CE6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArmyCrab", $F0

String_88_00_D6:: ; heuristic: string; C0
Data_088_4CEF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadHornet", $F0

String_88_00_D7:: ; heuristic: string; C0
Data_088_4CF9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demonite", $F0

String_88_00_D8:: ; heuristic: string; C0
Data_088_4D02:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "1EyeClown", $F0

String_88_00_D9:: ; heuristic: string; C0
Data_088_4D0C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeadNite", $F0

String_88_00_DA:: ; heuristic: string; C0
Data_088_4D15:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gismo", $F0

String_88_00_DB:: ; heuristic: string; C0
Data_088_4D1B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octogon", $F0

String_88_00_DC:: ; heuristic: string; C0
Data_088_4D23:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snaily", $F0

String_88_00_DD:: ; heuristic: string; C0
Data_088_4D2A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BoxSlime", $F0

String_88_00_DE:: ; heuristic: string; C0
Data_088_4D33:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Vampirus", $F0

String_88_00_DF:: ; heuristic: string; C0
Data_088_4D3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skullroo", $F0

String_88_00_E0:: ; heuristic: string; C0
Data_088_4D45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BullBird", $F0

String_88_00_E1:: ; heuristic: string; C0
Data_088_4D4E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DanceVegi", $F0

String_88_00_E2:: ; heuristic: string; C0
Data_088_4D58:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StagBug", $F0

String_88_00_E3:: ; heuristic: string; C0
Data_088_4D60:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArmorPede", $F0

String_88_00_E4:: ; heuristic: string; C0
Data_088_4D6A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Catapila", $F0

String_88_00_E5:: ; heuristic: string; C0
Data_088_4D73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkEye", $F0

String_88_00_E6:: ; heuristic: string; C0
Data_088_4D7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gremlin", $F0

String_88_00_E7:: ; heuristic: string; C0
Data_088_4D83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MedusaEye", $F0

String_88_00_E8:: ; heuristic: string; C0
Data_088_4D8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilArmor", $F0

String_88_00_E9:: ; heuristic: string; C0
Data_088_4D97:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadMirror", $F0

String_88_00_EA:: ; heuristic: string; C0
Data_088_4DA1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RogueNite", $F0

String_88_00_EB:: ; heuristic: string; C0
Data_088_4DAB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dumbira", $F0

String_88_00_EC:: ; heuristic: string; C0
Data_088_4DB3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Metaly", $F0

String_88_00_ED:: ; heuristic: string; C0
Data_088_4DBA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SnakeBat", $F0

String_88_00_EE:: ; heuristic: string; C0
Data_088_4DC3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GulpBeast", $F0

String_88_00_EF:: ; heuristic: string; C0
Data_088_4DCD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadGopher", $F0

String_88_00_F0:: ; heuristic: string; C0
Data_088_4DD7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MistyWing", $F0

String_88_00_F1:: ; heuristic: string; C0
Data_088_4DE1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LandOwl", $F0

String_88_00_F2:: ; heuristic: string; C0
Data_088_4DE9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Devipine", $F0

String_88_00_F3:: ; heuristic: string; C0
Data_088_4DF2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Belzebub", $F0

String_88_00_F4:: ; heuristic: string; C0
Data_088_4DFB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FooHero", $F0

String_88_00_F5:: ; heuristic: string; C0
Data_088_4E03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bubblemon", $F0

String_88_00_F6:: ; heuristic: string; C0
Data_088_4E0D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoatHorn", $F0

String_88_00_F7:: ; heuristic: string; C0
Data_088_4E16:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spooky", $F0

String_88_00_F8:: ; heuristic: string; C0
Data_088_4E1D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PutrePup", $F0

String_88_00_F9:: ; heuristic: string; C0
Data_088_4E26:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Copycat", $F0

String_88_00_FA:: ; heuristic: string; C0
Data_088_4E2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MetalDrak", $F0

String_88_00_FB:: ; heuristic: string; C0
Data_088_4E38:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RayGigas", $F0

String_88_00_FC:: ; heuristic: string; C0
Data_088_4E41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PearlGel", $F0

String_88_00_FD:: ; heuristic: string; C0
Data_088_4E4A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gasgon", $F0

String_88_00_FE:: ; heuristic: string; C0
Data_088_4E51:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dragon", $F0

String_88_00_FF:: ; heuristic: string; C0
Data_088_4E58:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArrowDog", $F0

String_88_01_00:: ; heuristic: string; C0
Data_088_4E61:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KiteHawk", $F0

String_88_01_01:: ; heuristic: string; C0
Data_088_4E6A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StubBird", $F0

String_88_01_02:: ; heuristic: string; C0
Data_088_4E73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ZapBird", $F0

String_88_01_03:: ; heuristic: string; C0
Data_088_4E7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WeedBug", $F0

String_88_01_04:: ; heuristic: string; C0
Data_088_4E83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lipsy", $F0

String_88_01_05:: ; heuristic: string; C0
Data_088_4E89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MultiEyes", $F0

String_88_01_06:: ; heuristic: string; C0
Data_088_4E93:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shadow", $F0

String_88_01_07:: ; heuristic: string; C0
Data_088_4E9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CaptDead", $F0

String_88_01_08:: ; heuristic: string; C0
Data_088_4EA3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CurseLamp", $F0

String_88_01_09:: ; heuristic: string; C0
Data_088_4EAD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Angleron", $F0

String_88_01_0A:: ; heuristic: string; C0
Data_088_4EB6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gamanian", $F0

String_88_01_0B:: ; heuristic: string; C0
Data_088_4EBF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhaleMage", $F0

String_88_01_0C:: ; heuristic: string; C0
Data_088_4EC9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpotKing", $F0

String_88_01_0D:: ; heuristic: string; C0
Data_088_4ED2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SkyDragon", $F0

String_88_01_0E:: ; heuristic: string; C0
Data_088_4EDC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tonguella", $F0

String_88_01_0F:: ; heuristic: string; C0
Data_088_4EE6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Saccer", $F0

String_88_01_10:: ; heuristic: string; C0
Data_088_4EED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wyvern", $F0

String_88_01_11:: ; heuristic: string; C0
Data_088_4EF4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AquaHawk", $F0

String_88_01_12:: ; heuristic: string; C0
Data_088_4EFD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Garudian", $F0

String_88_01_13:: ; heuristic: string; C0
Data_088_4F06:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eyeder", $F0

String_88_01_14:: ; heuristic: string; C0
Data_088_4F0D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArcDemon", $F0

String_88_01_15:: ; heuristic: string; C0
Data_088_4F16:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lionex", $F0

String_88_01_16:: ; heuristic: string; C0
Data_088_4F1D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GateGuard", $F0

String_88_01_17:: ; heuristic: string; C0
Data_088_4F27:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Centasaur", $F0

String_88_01_18:: ; heuristic: string; C0
Data_088_4F31:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster", $F0

String_88_01_19:: ; heuristic: string; C0
Data_088_4F3A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eggplaton", $F0

String_88_01_1A:: ; heuristic: string; C0
Data_088_4F44:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Clawster", $F0

String_88_01_1B:: ; heuristic: string; C0
Data_088_4F4D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MerTiger", $F0

String_88_01_1C:: ; heuristic: string; C0
Data_088_4F56:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TreeSlime", $F0

String_88_01_1D:: ; heuristic: string; C0
Data_088_4F60:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swordgon", $F0

String_88_01_1E:: ; heuristic: string; C0
Data_088_4F69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SuperTen", $F0

String_88_01_1F:: ; heuristic: string; C0
Data_088_4F72:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HammerMan", $F0

String_88_01_20:: ; heuristic: string; C0
Data_088_4F7C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Goategon", $F0

String_88_01_21:: ; heuristic: string; C0
Data_088_4F85:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dracky", $F0

String_88_01_22:: ; heuristic: string; C0
Data_088_4F8C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PutreFish", $F0

String_88_01_23:: ; heuristic: string; C0
Data_088_4F96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AmberWeed", $F0

String_88_01_24:: ; heuristic: string; C0
Data_088_4FA0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WarMantis", $F0

String_88_01_25:: ; heuristic: string; C0
Data_088_4FAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orc", $F0

String_88_01_26:: ; heuristic: string; C0
Data_088_4FAE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ChopClown", $F0

String_88_01_27:: ; heuristic: string; C0
Data_088_4FB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mummy", $F0

String_88_01_28:: ; heuristic: string; C0
Data_088_4FBE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadSpirit", $F0

String_88_01_29:: ; heuristic: string; C0
Data_088_4FC8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PomPomBom", $F0

String_88_01_2A:: ; heuristic: string; C0
Data_088_4FD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BombCrag", $F0

String_88_01_2B:: ; heuristic: string; C0
Data_088_4FDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octoraid", $F0

String_88_01_2C:: ; heuristic: string; C0
Data_088_4FE4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Andreal", $F0

String_88_01_2D:: ; heuristic: string; C0
Data_088_4FEC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatDrak", $F0

String_88_01_2E:: ; heuristic: string; C0
Data_088_4FF6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Trumpeter", $F0

String_88_01_2F:: ; heuristic: string; C0
Data_088_5000:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ProtoMech", $F0

String_88_01_30:: ; heuristic: string; C0
Data_088_500A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Armorpion", $F0

String_88_01_31:: ; heuristic: string; C0
Data_088_5014:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Digster", $F0

String_88_01_32:: ; heuristic: string; C0
Data_088_501C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BossTroll", $F0

String_88_01_33:: ; heuristic: string; C0
Data_088_5026:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadKnight", $F0

String_88_01_34:: ; heuristic: string; C0
Data_088_5030:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ogre", $F0

String_88_01_35:: ; heuristic: string; C0
Data_088_5035:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeadNoble", $F0

String_88_01_36:: ; heuristic: string; C0
Data_088_503F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skeletor", $F0

String_88_01_37:: ; heuristic: string; C0
Data_088_5048:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StoneMan", $F0

String_88_01_38:: ; heuristic: string; C0
Data_088_5051:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FishRider", $F0

String_88_01_39:: ; heuristic: string; C0
Data_088_505B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AxeShark", $F0

String_88_01_3A:: ; heuristic: string; C0
Data_088_5064:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Aquadon", $F0

String_88_01_3B:: ; heuristic: string; C0
Data_088_506C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Digong", $F0

String_88_01_3C:: ; heuristic: string; C0
Data_088_5073:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MetalKing", $F0

String_88_01_3D:: ; heuristic: string; C0
Data_088_507D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Serpentia", $F0

String_88_01_3E:: ; heuristic: string; C0
Data_088_5087:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Coatol", $F0

String_88_01_3F:: ; heuristic: string; C0
Data_088_508E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orochi", $F0

String_88_01_40:: ; heuristic: string; C0
Data_088_5095:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BattleRex", $F0

String_88_01_41:: ; heuristic: string; C0
Data_088_509F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhipBird", $F0

String_88_01_42:: ; heuristic: string; C0
Data_088_50A8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shantak", $F0

String_88_01_43:: ; heuristic: string; C0
Data_088_50B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rosevine", $F0

String_88_01_44:: ; heuristic: string; C0
Data_088_50B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grendal", $F0

String_88_01_45:: ; heuristic: string; C0
Data_088_50C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Akubar", $F0

String_88_01_46:: ; heuristic: string; C0
Data_088_50C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Jamirus", $F0

String_88_01_47:: ; heuristic: string; C0
Data_088_50D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LampGenie", $F0

String_88_01_48:: ; heuristic: string; C0
Data_088_50DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhiteKing", $F0

String_88_01_49:: ; heuristic: string; C0
Data_088_50E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Niterich", $F0

String_88_01_4A:: ; heuristic: string; C0
Data_088_50ED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingSquid", $F0

String_88_01_4B:: ; heuristic: string; C0
Data_088_50F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grakos", $F0

String_88_01_4C:: ; heuristic: string; C0
Data_088_50FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slabbit", $F0

String_88_01_4D:: ; heuristic: string; C0
Data_088_5106:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CoilBird", $F0

String_88_01_4E:: ; heuristic: string; C0
Data_088_510F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FairyDrak", $F0

String_88_01_4F:: ; heuristic: string; C0
Data_088_5119:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Oniono", $F0

String_88_01_50:: ; heuristic: string; C0
Data_088_5120:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilSeed", $F0

String_88_01_51:: ; heuristic: string; C0
Data_088_5129:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCandle", $F0

String_88_01_52:: ; heuristic: string; C0
Data_088_5133:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DragonKid", $F0

String_88_01_53:: ; heuristic: string; C0
Data_088_513D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DuckKite", $F0

String_88_01_54:: ; heuristic: string; C0
Data_088_5146:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WingTree", $F0

String_88_01_55:: ; heuristic: string; C0
Data_088_514F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GiantSlug", $F0

String_88_01_56:: ; heuristic: string; C0
Data_088_5159:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gophecada", $F0

String_88_01_57:: ; heuristic: string; C0
Data_088_5163:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RotRaven", $F0

String_88_01_58:: ; heuristic: string; C0
Data_088_516C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Chamelgon", $F0

String_88_01_59:: ; heuristic: string; C0
Data_088_5176:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadPecker", $F0

String_88_01_5A:: ; heuristic: string; C0
Data_088_5180:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadPlant", $F0

String_88_01_5B:: ; heuristic: string; C0
Data_088_5189:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FaceTree", $F0

String_88_01_5C:: ; heuristic: string; C0
Data_088_5192:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeanMan", $F0

String_88_01_5D:: ; heuristic: string; C0
Data_088_519A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Catapila", $F0

String_88_01_5E:: ; heuristic: string; C0
Data_088_51A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Facer", $F0

String_88_01_5F:: ; heuristic: string; C0
Data_088_51A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Voodoll", $F0

String_88_01_60:: ; heuristic: string; C0
Data_088_51B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Golem", $F0

String_88_01_61:: ; heuristic: string; C0
Data_088_51B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RogueWave", $F0

String_88_01_62:: ; heuristic: string; C0
Data_088_51C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BoxSlime", $F0

String_88_01_63:: ; heuristic: string; C0
Data_088_51CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SlimeBorg", $F0

String_88_01_64:: ; heuristic: string; C0
Data_088_51D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkHorn", $F0

String_88_01_65:: ; heuristic: string; C0
Data_088_51DD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ManEater", $F0

String_88_01_66:: ; heuristic: string; C0
Data_088_51E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snapper", $F0

String_88_01_67:: ; heuristic: string; C0
Data_088_51EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GhosTree", $F0

String_88_01_68:: ; heuristic: string; C0
Data_088_51F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SkulRider", $F0

String_88_01_69:: ; heuristic: string; C0
Data_088_5201:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gigantes", $F0

String_88_01_6A:: ; heuristic: string; C0
Data_088_520A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skulpent", $F0

String_88_01_6B:: ; heuristic: string; C0
Data_088_5213:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Aquarella", $F0

String_88_01_6C:: ; heuristic: string; C0
Data_088_521D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldSlime", $F0

String_88_01_6D:: ; heuristic: string; C0
Data_088_5227:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GranSlime", $F0

String_88_01_6E:: ; heuristic: string; C0
Data_088_5231:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Divinegon", $F0

String_88_01_6F:: ; heuristic: string; C0
Data_088_523B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingLeo", $F0

String_88_01_70:: ; heuristic: string; C0
Data_088_5243:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RainHawk", $F0

String_88_01_71:: ; heuristic: string; C0
Data_088_524C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Durran", $F0

String_88_01_72:: ; heuristic: string; C0
Data_088_5253:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lazamanus", $F0

String_88_01_73:: ; heuristic: string; C0
Data_088_525D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldGolem", $F0

String_88_01_74:: ; heuristic: string; C0
Data_088_5267:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PillowRat", $F0

String_88_01_75:: ; heuristic: string; C0
Data_088_5271:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArmorPede", $F0

String_88_01_76:: ; heuristic: string; C0
Data_088_527B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WildApe", $F0

String_88_01_77:: ; heuristic: string; C0
Data_088_5283:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Clawster", $F0

String_88_01_78:: ; heuristic: string; C0
Data_088_528C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gulpple", $F0

String_88_01_79:: ; heuristic: string; C0
Data_088_5294:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Darck", $F0

String_88_01_7A:: ; heuristic: string; C0
Data_088_529A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCat", $F0

String_88_01_7B:: ; heuristic: string; C0
Data_088_52A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HornBeet", $F0

String_88_01_7C:: ; heuristic: string; C0
Data_088_52AA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SkyDragon", $F0

String_88_01_7D:: ; heuristic: string; C0
Data_088_52B4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octogon", $F0

String_88_01_7E:: ; heuristic: string; C0
Data_088_52BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Servant", $F0

String_88_01_7F:: ; heuristic: string; C0
Data_088_52C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Darck", $F0

String_88_01_80:: ; heuristic: string; C0
Data_088_52CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GiantWorm", $F0

String_88_01_81:: ; heuristic: string; C0
Data_088_52D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spooky", $F0

String_88_01_82:: ; heuristic: string; C0
Data_088_52DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beavern", $F0

String_88_01_84:: ; heuristic: string; C0
Data_088_52E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCandle", $F0

String_88_01_85:: ; heuristic: string; C0
Data_088_52ED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpikyBoy", $F0

String_88_01_86:: ; heuristic: string; C0
Data_088_52F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Anemon", $F0

String_88_01_87:: ; heuristic: string; C0
Data_088_52FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArrowDog", $F0

String_88_01_88:: ; heuristic: string; C0
Data_088_5306:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pyuro", $F0

String_88_01_89:: ; heuristic: string; C0
Data_088_530C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DanceVegi", $F0

String_88_01_8A:: ; heuristic: string; C0
Data_088_5316:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Brushead", $F0

String_88_01_8B:: ; heuristic: string; C0
Data_088_531F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MiniDrak", $F0

String_88_01_8C:: ; heuristic: string; C0
Data_088_5328:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pteranod", $F0

String_88_01_8D:: ; heuristic: string; C0
Data_088_5331:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DragonKid", $F0

String_88_01_8E:: ; heuristic: string; C0
Data_088_533B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CatFly", $F0

String_88_01_8F:: ; heuristic: string; C0
Data_088_5342:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BoneSlave", $F0

String_88_01_90:: ; heuristic: string; C0
Data_088_534C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingSquid", $F0

String_88_01_91:: ; heuristic: string; C0
Data_088_5356:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeastNite", $F0

String_88_01_92:: ; heuristic: string; C0
Data_088_5360:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drygon", $F0

String_88_01_93:: ; heuristic: string; C0
Data_088_5367:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pumpoise", $F0

String_88_01_94:: ; heuristic: string; C0
Data_088_5370:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FishRider", $F0

String_88_01_95:: ; heuristic: string; C0
Data_088_537A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WalrusMan", $F0

String_88_01_96:: ; heuristic: string; C0
Data_088_5384:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stubsuck", $F0

String_88_01_97:: ; heuristic: string; C0
Data_088_538D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shadow", $F0

String_88_01_98:: ; heuristic: string; C0
Data_088_5394:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WingTree", $F0

String_88_01_99:: ; heuristic: string; C0
Data_088_539D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AgDevil", $F0

String_88_01_9A:: ; heuristic: string; C0
Data_088_53A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Puppetor", $F0

String_88_01_9B:: ; heuristic: string; C0
Data_088_53AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArcDemon", $F0

String_88_01_9C:: ; heuristic: string; C0
Data_088_53B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoatHorn", $F0

String_88_01_9D:: ; heuristic: string; C0
Data_088_53C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MetalDrak", $F0

String_88_01_9E:: ; heuristic: string; C0
Data_088_53CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AgDevil", $F0

String_88_01_9F:: ; heuristic: string; C0
Data_088_53D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Puppetor", $F0

String_88_01_A0:: ; heuristic: string; C0
Data_088_53DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Golem", $F0

String_88_01_A1:: ; heuristic: string; C0
Data_088_53E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilSeed", $F0

String_88_01_A2:: ; heuristic: string; C0
Data_088_53EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EyeBall", $F0

String_88_01_A3:: ; heuristic: string; C0
Data_088_53F2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Chamelgon", $F0

String_88_01_A4:: ; heuristic: string; C0
Data_088_53FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FooHero", $F0

String_88_01_A5:: ; heuristic: string; C0
Data_088_5404:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BoxSlime", $F0

String_88_01_A6:: ; heuristic: string; C0
Data_088_540D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Metabble", $F0

String_88_01_A7:: ; heuristic: string; C0
Data_088_5416:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FairyRat", $F0

String_88_01_A8:: ; heuristic: string; C0
Data_088_541F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swordgon", $F0

String_88_01_A9:: ; heuristic: string; C0
Data_088_5428:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mommonja", $F0

String_88_01_AA:: ; heuristic: string; C0
Data_088_5431:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KiteHawk", $F0

String_88_01_AB:: ; heuristic: string; C0
Data_088_543A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCondor", $F0

String_88_01_AD:: ; heuristic: string; C0
Data_088_5444:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WingSnake", $F0

String_88_01_AE:: ; heuristic: string; C0
Data_088_544E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatDrak", $F0

String_88_01_AF:: ; heuristic: string; C0
Data_088_5458:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingSquid", $F0

String_88_01_B0:: ; heuristic: string; C0
Data_088_5462:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WindBeast", $F0

String_88_01_B1:: ; heuristic: string; C0
Data_088_546C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadGoose", $F0

String_88_01_B2:: ; heuristic: string; C0
Data_088_5475:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhaleMage", $F0

String_88_01_B3:: ; heuristic: string; C0
Data_088_547F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SeaHorse", $F0

String_88_01_B4:: ; heuristic: string; C0
Data_088_5488:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octoreach", $F0

String_88_01_B5:: ; heuristic: string; C0
Data_088_5492:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IceMan", $F0

String_88_01_B6:: ; heuristic: string; C0
Data_088_5499:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shadow", $F0

String_88_01_B7:: ; heuristic: string; C0
Data_088_54A0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BigEye", $F0

String_88_01_B8:: ; heuristic: string; C0
Data_088_54A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Balzak", $F0

String_88_01_B9:: ; heuristic: string; C0
Data_088_54AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RotRaven", $F0

String_88_01_BA:: ; heuristic: string; C0
Data_088_54B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Jamirus", $F0

String_88_01_BB:: ; heuristic: string; C0
Data_088_54BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SkyDragon", $F0

String_88_01_BC:: ; heuristic: string; C0
Data_088_54C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gremlin", $F0

String_88_01_BD:: ; heuristic: string; C0
Data_088_54D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Crestpent", $F0

String_88_01_BE:: ; heuristic: string; C0
Data_088_54DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpotKing", $F0

String_88_01_BF:: ; heuristic: string; C0
Data_088_54E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gulpple", $F0

String_88_01_C0:: ; heuristic: string; C0
Data_088_54EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FairyDrak", $F0

String_88_01_C1:: ; heuristic: string; C0
Data_088_54F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DuckKite", $F0

String_88_01_C2:: ; heuristic: string; C0
Data_088_54FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FunkyBird", $F0

String_88_01_C3:: ; heuristic: string; C0
Data_088_5509:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DanceVegi", $F0

String_88_01_C4:: ; heuristic: string; C0
Data_088_5513:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slurperon", $F0

String_88_01_C5:: ; heuristic: string; C0
Data_088_551D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadPlant", $F0

String_88_01_C6:: ; heuristic: string; C0
Data_088_5526:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orc", $F0

String_88_01_C7:: ; heuristic: string; C0
Data_088_552A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PutrePup", $F0

String_88_01_C8:: ; heuristic: string; C0
Data_088_5533:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Devipine", $F0

String_88_01_C9:: ; heuristic: string; C0
Data_088_553C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Anemon", $F0

String_88_01_CA:: ; heuristic: string; C0
Data_088_5543:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HerbMan", $F0

String_88_01_CB:: ; heuristic: string; C0
Data_088_554B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingSlime", $F0

String_88_01_CC:: ; heuristic: string; C0
Data_088_5555:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Coatol", $F0

String_88_01_CD:: ; heuristic: string; C0
Data_088_555C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FangSlime", $F0

String_88_01_CE:: ; heuristic: string; C0
Data_088_5566:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grizzly", $F0

String_88_01_CF:: ; heuristic: string; C0
Data_088_556E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeastNite", $F0

String_88_01_D0:: ; heuristic: string; C0
Data_088_5578:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Healer", $F0

String_88_01_D1:: ; heuristic: string; C0
Data_088_557F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Unicorn", $F0

String_88_01_D2:: ; heuristic: string; C0
Data_088_5587:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SuperTen", $F0

String_88_01_D3:: ; heuristic: string; C0
Data_088_5590:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slime", $F0

String_88_01_D4:: ; heuristic: string; C0
Data_088_5596:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RockSlime", $F0

String_88_01_D5:: ; heuristic: string; C0
Data_088_55A0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Metabble", $F0

String_88_01_D6:: ; heuristic: string; C0
Data_088_55A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gorago", $F0

String_88_01_D7:: ; heuristic: string; C0
Data_088_55B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slabbit", $F0

String_88_01_D8:: ; heuristic: string; C0
Data_088_55B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MultiEyes", $F0

String_88_01_D9:: ; heuristic: string; C0
Data_088_55C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FairyRat", $F0

String_88_01_DA:: ; heuristic: string; C0
Data_088_55CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stubsuck", $F0

String_88_01_DB:: ; heuristic: string; C0
Data_088_55D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadPlant", $F0

String_88_01_DC:: ; heuristic: string; C0
Data_088_55DD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snapper", $F0

String_88_01_DD:: ; heuristic: string; C0
Data_088_55E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grendal", $F0

String_88_01_DE:: ; heuristic: string; C0
Data_088_55ED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoHopper", $F0

String_88_01_DF:: ; heuristic: string; C0
Data_088_55F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArrowDog", $F0

String_88_01_E0:: ; heuristic: string; C0
Data_088_55FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StagBug", $F0

String_88_01_E1:: ; heuristic: string; C0
Data_088_5607:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FireWeed", $F0

String_88_01_E2:: ; heuristic: string; C0
Data_088_5610:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AgDevil", $F0

String_88_01_E3:: ; heuristic: string; C0
Data_088_5618:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grizzly", $F0

String_88_01_E4:: ; heuristic: string; C0
Data_088_5620:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SkulRider", $F0

String_88_01_E5:: ; heuristic: string; C0
Data_088_562A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WalrusMan", $F0

String_88_01_E6:: ; heuristic: string; C0
Data_088_5634:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCandle", $F0

String_88_01_E7:: ; heuristic: string; C0
Data_088_563E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reaper", $F0

String_88_01_E8:: ; heuristic: string; C0
Data_088_5645:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ProtoMech", $F0

String_88_01_E9:: ; heuristic: string; C0
Data_088_564F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster", $F0

String_88_01_ED:: ; heuristic: string; C0
Data_088_5658:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CatMage", $F0

String_88_01_EE:: ; heuristic: string; C0
Data_088_5660:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FaceTree", $F0

String_88_01_EF:: ; heuristic: string; C0
Data_088_5669:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ogre", $F0

String_88_01_F0:: ; heuristic: string; C0
Data_088_566E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CurseLamp", $F0

String_88_01_F1:: ; heuristic: string; C0
Data_088_5678:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Anemon", $F0

String_88_01_F2:: ; heuristic: string; C0
Data_088_567F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lipsy", $F0

String_88_01_F3:: ; heuristic: string; C0
Data_088_5685:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WeedBug", $F0

String_88_01_F4:: ; heuristic: string; C0
Data_088_568D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spikerous", $F0

String_88_01_F5:: ; heuristic: string; C0
Data_088_5697:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skullgon", $F0

String_88_01_F6:: ; heuristic: string; C0
Data_088_56A0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skulpent", $F0

String_88_01_F7:: ; heuristic: string; C0
Data_088_56A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Butterfly", $F0

String_88_01_F8:: ; heuristic: string; C0
Data_088_56B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pixy", $F0

String_88_01_F9:: ; heuristic: string; C0
Data_088_56B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Copycat", $F0

String_88_01_FA:: ; heuristic: string; C0
Data_088_56C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StoneMan", $F0

String_88_01_FB:: ; heuristic: string; C0
Data_088_56C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhipBird", $F0

String_88_01_FC:: ; heuristic: string; C0
Data_088_56D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MimeSlime", $F0

String_88_01_FD:: ; heuristic: string; C0
Data_088_56DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tonguella", $F0

String_88_01_FE:: ; heuristic: string; C0
Data_088_56E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Golem", $F0

String_88_01_FF:: ; heuristic: string; C0
Data_088_56EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bubblemon", $F0

String_88_02_00:: ; heuristic: string; C0
Data_088_56F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RogueNite", $F0

String_88_02_01:: ; heuristic: string; C0
Data_088_5700:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Puppetor", $F0

String_88_02_02:: ; heuristic: string; C0
Data_088_5709:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Exaucers", $F0

String_88_02_03:: ; heuristic: string; C0
Data_088_5712:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhaleMage", $F0

String_88_02_04:: ; heuristic: string; C0
Data_088_571C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MedusaEye", $F0

String_88_02_05:: ; heuristic: string; C0
Data_088_5726:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MetalKing", $F0

String_88_02_06:: ; heuristic: string; C0
Data_088_5730:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingLeo", $F0

String_88_02_07:: ; heuristic: string; C0
Data_088_5738:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldGolem", $F0

String_88_02_08:: ; heuristic: string; C0
Data_088_5742:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatDrak", $F0

String_88_02_09:: ; heuristic: string; C0
Data_088_574C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Watabou", $F0

String_88_02_0A:: ; heuristic: string; C0
Data_088_5754:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Durran", $F0

String_88_02_0B:: ; heuristic: string; C0
Data_088_575B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demonite", $F0

String_88_02_0C:: ; heuristic: string; C0
Data_088_5764:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BossTroll", $F0

String_88_02_0D:: ; heuristic: string; C0
Data_088_576E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "JewelBag", $F0

String_88_02_0E:: ; heuristic: string; C0
Data_088_5777:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BoneSlave", $F0

String_88_02_0F:: ; heuristic: string; C0
Data_088_5781:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeadNoble", $F0

String_88_02_10:: ; heuristic: string; C0
Data_088_578B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RogueNite", $F0

String_88_02_11:: ; heuristic: string; C0
Data_088_5795:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Balzak", $F0

String_88_02_12:: ; heuristic: string; C0
Data_088_579C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Voodoll", $F0

String_88_02_13:: ; heuristic: string; C0
Data_088_57A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GateGuard", $F0

String_88_02_14:: ; heuristic: string; C0
Data_088_57AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadMirror", $F0

String_88_02_15:: ; heuristic: string; C0
Data_088_57B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grakos", $F0

String_88_02_16:: ; heuristic: string; C0
Data_088_57BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Scallopa", $F0

String_88_02_17:: ; heuristic: string; C0
Data_088_57C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snaily", $F0

String_88_02_18:: ; heuristic: string; C0
Data_088_57CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Clawster", $F0

String_88_02_19:: ; heuristic: string; C0
Data_088_57D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shadow", $F0

String_88_02_1A:: ; heuristic: string; C0
Data_088_57DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mimic", $F0

String_88_02_1B:: ; heuristic: string; C0
Data_088_57E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MetalKing", $F0

String_88_02_1C:: ; heuristic: string; C0
Data_088_57EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RainHawk", $F0

String_88_02_1D:: ; heuristic: string; C0
Data_088_57F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Coatol", $F0

String_88_02_1E:: ; heuristic: string; C0
Data_088_57FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Phoenix", $F0

String_88_02_1F:: ; heuristic: string; C0
Data_088_5807:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shantak", $F0

String_88_02_20:: ; heuristic: string; C0
Data_088_580F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blizzardy", $F0

String_88_02_21:: ; heuristic: string; C0
Data_088_5819:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skullgon", $F0

String_88_02_22:: ; heuristic: string; C0
Data_088_5822:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Akubar", $F0

String_88_02_23:: ; heuristic: string; C0
Data_088_5829:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkHorn", $F0

String_88_02_24:: ; heuristic: string; C0
Data_088_5832:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Serpentia", $F0

String_88_02_25:: ; heuristic: string; C0
Data_088_583C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SuperTen", $F0

String_88_02_26:: ; heuristic: string; C0
Data_088_5845:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Unicorn", $F0

String_88_02_27:: ; heuristic: string; C0
Data_088_584D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KiteHawk", $F0

String_88_02_28:: ; heuristic: string; C0
Data_088_5856:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FoxFire", $F0

String_88_02_29:: ; heuristic: string; C0
Data_088_585E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MetalDrak", $F0

String_88_02_2A:: ; heuristic: string; C0
Data_088_5868:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AxeShark", $F0

String_88_02_2B:: ; heuristic: string; C0
Data_088_5871:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StoneMan", $F0

String_88_02_2C:: ; heuristic: string; C0
Data_088_587A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MedusaEye", $F0

String_88_02_2D:: ; heuristic: string; C0
Data_088_5884:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadHornet", $F0

String_88_02_2E:: ; heuristic: string; C0
Data_088_588E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Oniono", $F0

String_88_02_2F:: ; heuristic: string; C0
Data_088_5895:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TailEater", $F0

String_88_02_30:: ; heuristic: string; C0
Data_088_589F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeastNite", $F0

String_88_02_31:: ; heuristic: string; C0
Data_088_58A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MimeSlime", $F0

String_88_02_32:: ; heuristic: string; C0
Data_088_58B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadDragon", $F0

String_88_02_33:: ; heuristic: string; C0
Data_088_58BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WingSnake", $F0

String_88_02_34:: ; heuristic: string; C0
Data_088_58C7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orochi", $F0

String_88_02_35:: ; heuristic: string; C0
Data_088_58CE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Trumpeter", $F0

String_88_02_36:: ; heuristic: string; C0
Data_088_58D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wyvern", $F0

String_88_02_37:: ; heuristic: string; C0
Data_088_58DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Devipine", $F0

String_88_02_38:: ; heuristic: string; C0
Data_088_58E8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snapper", $F0

String_88_02_39:: ; heuristic: string; C0
Data_088_58F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StagBug", $F0

String_88_02_3A:: ; heuristic: string; C0
Data_088_58F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArmyCrab", $F0

String_88_02_3B:: ; heuristic: string; C0
Data_088_5901:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArcDemon", $F0

String_88_02_3C:: ; heuristic: string; C0
Data_088_590A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "1EyeClown", $F0

String_88_02_3D:: ; heuristic: string; C0
Data_088_5914:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadKnight", $F0

String_88_02_3E:: ; heuristic: string; C0
Data_088_591E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CaptDead", $F0

String_88_02_3F:: ; heuristic: string; C0
Data_088_5927:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Servant", $F0

String_88_02_40:: ; heuristic: string; C0
Data_088_592F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LavaMan", $F0

String_88_02_41:: ; heuristic: string; C0
Data_088_5937:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BombCrag", $F0

String_88_02_42:: ; heuristic: string; C0
Data_088_5940:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RushFish", $F0

String_88_02_43:: ; heuristic: string; C0
Data_088_5949:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhaleMage", $F0

String_88_02_44:: ; heuristic: string; C0
Data_088_5953:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpotKing", $F0

String_88_02_45:: ; heuristic: string; C0
Data_088_595C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SlimeBorg", $F0

String_88_02_46:: ; heuristic: string; C0
Data_088_5966:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LizardMan", $F0

String_88_02_47:: ; heuristic: string; C0
Data_088_5970:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatDrak", $F0

String_88_02_48:: ; heuristic: string; C0
Data_088_597A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCat", $F0

String_88_02_49:: ; heuristic: string; C0
Data_088_5981:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Emyu", $F0

String_88_02_4A:: ; heuristic: string; C0
Data_088_5986:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HornBeet", $F0

String_88_02_4B:: ; heuristic: string; C0
Data_088_598F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ogre", $F0

String_88_02_4C:: ; heuristic: string; C0
Data_088_5994:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PutrePup", $F0

String_88_02_4D:: ; heuristic: string; C0
Data_088_599D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster2", $F0

String_88_02_4E:: ; heuristic: string; C0
Data_088_59A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldGolem", $F0

String_88_02_4F:: ; heuristic: string; C0
Data_088_59B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhiteKing", $F0

String_88_02_50:: ; heuristic: string; C0
Data_088_59BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldSlime", $F0

String_88_02_51:: ; heuristic: string; C0
Data_088_59C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Divinegon", $F0

String_88_02_52:: ; heuristic: string; C0
Data_088_59CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingLeo", $F0

String_88_02_53:: ; heuristic: string; C0
Data_088_59D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RainHawk", $F0

String_88_02_54:: ; heuristic: string; C0
Data_088_59E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rosevine", $F0

String_88_02_55:: ; heuristic: string; C0
Data_088_59E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Armorpion", $F0

String_88_02_56:: ; heuristic: string; C0
Data_088_59F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Durran", $F0

String_88_02_57:: ; heuristic: string; C0
Data_088_59FA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Aquadon", $F0

String_88_02_58:: ; heuristic: string; C0
Data_088_5A02:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Warubou", $F0

String_88_02_59:: ; heuristic: string; C0
Data_088_5A0A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Petibou", $F0

String_88_02_5A:: ; heuristic: string; C0
Data_088_5A12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skeletor", $F0

String_88_02_5B:: ; heuristic: string; C0
Data_088_5A1B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StoneMan", $F0

String_88_02_5C:: ; heuristic: string; C0
Data_088_5A24:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FunkyBird", $F0

String_88_02_5D:: ; heuristic: string; C0
Data_088_5A2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Copycat", $F0

String_88_02_5E:: ; heuristic: string; C0
Data_088_5A36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Andreal", $F0

String_88_02_5F:: ; heuristic: string; C0
Data_088_5A3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drygon", $F0

String_88_02_60:: ; heuristic: string; C0
Data_088_5A45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Butch", $F0

String_88_02_61:: ; heuristic: string; C0
Data_088_5A4B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pumpoise", $F0

String_88_02_62:: ; heuristic: string; C0
Data_088_5A54:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LordDraco", $F0

String_88_02_63:: ; heuristic: string; C0
Data_088_5A5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArcDemon", $F0

String_88_02_64:: ; heuristic: string; C0
Data_088_5A67:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhipBird", $F0

String_88_02_65:: ; heuristic: string; C0
Data_088_5A70:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StoneMan", $F0

String_88_02_66:: ; heuristic: string; C0
Data_088_5A79:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeadNoble", $F0

String_88_02_67:: ; heuristic: string; C0
Data_088_5A83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MetalKing", $F0

String_88_02_68:: ; heuristic: string; C0
Data_088_5A8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Serpentia", $F0

String_88_02_69:: ; heuristic: string; C0
Data_088_5A97:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IronTurt", $F0

String_88_02_6A:: ; heuristic: string; C0
Data_088_5AA0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ZapBird", $F0

String_88_02_6B:: ; heuristic: string; C0
Data_088_5AA8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FooHero", $F0

String_88_02_6C:: ; heuristic: string; C0
Data_088_5AB0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoatHorn", $F0

String_88_02_6D:: ; heuristic: string; C0
Data_088_5AB9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inverzon", $F0

String_88_02_6E:: ; heuristic: string; C0
Data_088_5AC2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Voodoll", $F0

String_88_02_6F:: ; heuristic: string; C0
Data_088_5ACA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AxeShark", $F0

String_88_02_70:: ; heuristic: string; C0
Data_088_5AD3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Digong", $F0

String_88_02_71:: ; heuristic: string; C0
Data_088_5ADA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swordgon", $F0

String_88_02_72:: ; heuristic: string; C0
Data_088_5AE3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GigaDraco", $F0

String_88_02_73:: ; heuristic: string; C0
Data_088_5AED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SuperTen", $F0

String_88_02_74:: ; heuristic: string; C0
Data_088_5AF6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BigRoost", $F0

String_88_02_75:: ; heuristic: string; C0
Data_088_5AFF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GhosTree", $F0

String_88_02_76:: ; heuristic: string; C0
Data_088_5B08:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WarMantis", $F0

String_88_02_77:: ; heuristic: string; C0
Data_088_5B12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Healer", $F0

String_88_02_78:: ; heuristic: string; C0
Data_088_5B19:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kagebou", $F0

String_88_02_79:: ; heuristic: string; C0
Data_088_5B21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dimensaur", $F0

String_88_02_7A:: ; heuristic: string; C0
Data_088_5B2B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lamia", $F0

String_88_02_7B:: ; heuristic: string; C0
Data_088_5B31:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoLord", $F0

String_88_02_7D:: ; heuristic: string; C0
Data_088_5B3B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LordDraco", $F0

String_88_02_7E:: ; heuristic: string; C0
Data_088_5B45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hargon", $F0

String_88_02_7F:: ; heuristic: string; C0
Data_088_5B4C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sidoh", $F0

String_88_02_80:: ; heuristic: string; C0
Data_088_5B52:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Genosidoh", $F0

String_88_02_81:: ; heuristic: string; C0
Data_088_5B5C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baramos", $F0

String_88_02_82:: ; heuristic: string; C0
Data_088_5B64:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Zoma", $F0

String_88_02_83:: ; heuristic: string; C0
Data_088_5B69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AsuraZoma", $F0

String_88_02_84:: ; heuristic: string; C0
Data_088_5B73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pizzaro", $F0

String_88_02_85:: ; heuristic: string; C0
Data_088_5B7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PsychoPiz", $F0

String_88_02_86:: ; heuristic: string; C0
Data_088_5B85:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Esterk", $F0

String_88_02_87:: ; heuristic: string; C0
Data_088_5B8C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mirudraas", $F0

String_88_02_89:: ; heuristic: string; C0
Data_088_5B96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mudou", $F0

String_88_02_8A:: ; heuristic: string; C0
Data_088_5B9C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeathMore", $F0

String_88_02_8D:: ; heuristic: string; C0
Data_088_5BA6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Darkdrium", $F0

String_88_02_8E:: ; heuristic: string; C0
Data_088_5BB0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orgodemir", $F0

String_88_02_90:: ; heuristic: string; C0
Data_088_5BBA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Darck", $F0

String_88_02_91:: ; heuristic: string; C0
Data_088_5BC0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HaloSlime", $F0

String_88_02_92:: ; heuristic: string; C0
Data_088_5BCA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldSlime", $F0

String_88_02_93:: ; heuristic: string; C0
Data_088_5BD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GranSlime", $F0

String_88_02_94:: ; heuristic: string; C0
Data_088_5BDE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WonderEgg", $F0

String_88_02_95:: ; heuristic: string; C0
Data_088_5BE8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orligon", $F0

String_88_02_96:: ; heuristic: string; C0
Data_088_5BF0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GigaDraco", $F0

String_88_02_97:: ; heuristic: string; C0
Data_088_5BFA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkHorn", $F0

String_88_02_98:: ; heuristic: string; C0
Data_088_5C03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gorago", $F0

String_88_02_99:: ; heuristic: string; C0
Data_088_5C0A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RainHawk", $F0

String_88_02_9A:: ; heuristic: string; C0
Data_088_5C13:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Azurile", $F0

String_88_02_9B:: ; heuristic: string; C0
Data_088_5C1B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shantak", $F0

String_88_02_9C:: ; heuristic: string; C0
Data_088_5C23:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Watabou", $F0

String_88_02_9D:: ; heuristic: string; C0
Data_088_5C2B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Warubou", $F0

String_88_02_9E:: ; heuristic: string; C0
Data_088_5C33:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Egdracil", $F0

String_88_02_9F:: ; heuristic: string; C0
Data_088_5C3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Digster", $F0

String_88_02_A0:: ; heuristic: string; C0
Data_088_5C44:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skularach", $F0

String_88_02_A1:: ; heuristic: string; C0
Data_088_5C4E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Titanis", $F0

String_88_02_A2:: ; heuristic: string; C0
Data_088_5C56:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LampGenie", $F0

String_88_02_A3:: ; heuristic: string; C0
Data_088_5C60:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Niterich", $F0

String_88_02_A4:: ; heuristic: string; C0
Data_088_5C69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhiteKing", $F0

String_88_02_A5:: ; heuristic: string; C0
Data_088_5C73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lazamanus", $F0

String_88_02_A6:: ; heuristic: string; C0
Data_088_5C7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldGolem", $F0

String_88_02_A7:: ; heuristic: string; C0
Data_088_5C87:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkMate", $F0

String_88_02_A8:: ; heuristic: string; C0
Data_088_5C90:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octogon", $F0

String_88_02_A9:: ; heuristic: string; C0
Data_088_5C98:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octoraid", $F0

String_88_02_AA:: ; heuristic: string; C0
Data_088_5CA1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grakos", $F0

String_88_02_AB:: ; heuristic: string; C0
Data_088_5CA8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Poseidon", $F0

String_88_02_AC:: ; heuristic: string; C0
Data_088_5CB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slime", $F0

String_88_02_AD:: ; heuristic: string; C0
Data_088_5CB7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined", $F0
    db $30, $28, $F0, $1E, $31, $27, $28, $29, $2C, $31, $28, $27, $F0
    ds $2332, $00
