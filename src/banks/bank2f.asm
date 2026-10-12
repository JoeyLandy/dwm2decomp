SECTION "Bank 2F", ROMX[$4000], BANK[$2F]
    db $2F

; ld de, this bank's string table / BeginStringDisplay
; 31 call sites from 31 routines (e.g. ShowString_Bank2F, DebugMessageTest_Update_ToBeginStringDisplay_Bank2F, ShowStringCategory5_Bank16, BattlePhase0_Step2_Case03, ...)
BeginStringDisplay_Bank2F::
Func_02F_4001:: ; address name
    ld de, StringCategories_2F_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_02F_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 2 call sites from 2 routines (e.g. DebugBattleSetupShowFieldString, ShowStringCategory5Immediate_Bank16)
ShowString_Bank2F::
Func_02F_400F:: ; address name
    call BeginStringDisplay_Bank2F
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_2F_4016::
Data_02F_4016:: ; address name
    dw StringList_2F_4022 ; id 0
    dw StringList_2F_4134 ; id 1
    dw StringList_2F_4334 ; id 2
    dw StringList_2F_433C ; id 3
    dw StringList_2F_433E ; id 4
    dw StringList_2F_4340 ; id 5

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_4022::
Data_02F_4022:: ; address name
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

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_4134::
Data_02F_4134:: ; address name
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

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_4334::
Data_02F_4334:: ; address name
    dw String_2F_02_00 ; id 0
    dw String_2F_02_01 ; id 1
    dw String_2F_02_02 ; id 2
    dw String_2F_02_03 ; id 3

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_433C::
Data_02F_433C:: ; address name
    dw String_2F_03_00 ; id 0

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_433E::
Data_02F_433E:: ; address name
    dw String_2F_03_00 ; id 0

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_4340::
Data_02F_4340:: ; address name
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

String_2F_00_00:: ; heuristic: string; C0
Data_02F_4384:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 appears!", $F1
    db $EC, $F0

String_2F_00_01:: ; heuristic: string; C0
Data_02F_4393:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters appear!", $F1
    db $EC, $F0

String_2F_00_02:: ; heuristic: string; C0
Data_02F_43A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters appear!", $F1
    db $EC, $F0

String_2F_00_03:: ; heuristic: string; C0
Data_02F_43BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters appear!", $F1
    db $EC, $F0

String_2F_00_04:: ; heuristic: string; C0
Data_02F_43CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters appear!", $F1
    db $EC, $F0

String_2F_00_05:: ; heuristic: string; C0
Data_02F_43E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters appear!", $F1
    db $EC, $F0

String_2F_00_06:: ; heuristic: string; C0
Data_02F_43F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F6, "'s party was", $F1
    db "wiped out!", $E5, $42, $F0

String_2F_00_07:: ; heuristic: string; C0
Data_02F_4412:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters were", $F1
    db "defeated!", $E4, $7E, $FA, $F7
    db $F0

String_2F_00_08:: ; heuristic: string; C0
Data_02F_442F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 left", $F1
    db "the scene.", $EC, $F0

String_2F_00_09:: ; heuristic: string; C0
Data_02F_4444:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The monsters left", $F1
    db "the scene.", $EC, $F0

String_2F_00_0A:: ; heuristic: string; C0
Data_02F_4463:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The monsters left", $F1
    db "the scene.", $EC, $F0

String_2F_00_0B:: ; heuristic: string; C0
Data_02F_4482:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "couldn't react!", $EC, $F0

String_2F_00_0C:: ; heuristic: string; C0
Data_02F_4496:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "appeared stunned!", $EC, $F0

String_2F_00_0D:: ; heuristic: string; C0
Data_02F_44AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "suddenly attacked!", $EC, $F0

String_2F_00_0E:: ; heuristic: string; C0
Data_02F_44C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "without warning!", $EC, $F0

String_2F_00_0F:: ; heuristic: string; C0
Data_02F_44E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 can't", $F1
    db "move!", $EC, $F0

String_2F_00_10:: ; heuristic: string; C0
Data_02F_4502:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GHP!", $EC, $F0

String_2F_00_11:: ; heuristic: string; C0
Data_02F_4522:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GMP!", $EC, $F0

String_2F_00_12:: ; heuristic: string; C0
Data_02F_4542:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 became", $F1
    db "confused!", $EC, $F0

String_2F_00_13:: ; heuristic: string; C0
Data_02F_4568:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "asleep.", $EC, $F0

String_2F_00_14:: ; heuristic: string; C0
Data_02F_4578:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "confused!", $EC, $F0

String_2F_00_15:: ; heuristic: string; C0
Data_02F_458A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is a", $F1
    db "hunk of iron!", $EC, $F0

String_2F_00_16:: ; heuristic: string; C0
Data_02F_45A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "frozen solid!", $EC, $F0

String_2F_00_17:: ; heuristic: string; C0
Data_02F_45B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "paralyzed!", $EC, $F0

String_2F_00_18:: ; heuristic: string; C0
Data_02F_45CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "dancing along!", $EC, $F0

String_2F_00_19:: ; heuristic: string; C0
Data_02F_45E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "shivering!", $EC, $F0

String_2F_00_1A:: ; heuristic: string; C0
Data_02F_45F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "get back up!", $EC, $F0

String_2F_00_1B:: ; heuristic: string; C0
Data_02F_460C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cowering in fear!", $EC, $F0

String_2F_00_1C:: ; heuristic: string; C0
Data_02F_4626:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "vacant and lost!", $EC, $F0

String_2F_00_1D:: ; heuristic: string; C0
Data_02F_4642:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No items allowed", $F1
    db "in this battle!", $F7
    db $F0

String_2F_00_1E:: ; heuristic: string; C0
Data_02F_4665:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "This item can't be", $F1
    db "used in battle!", $F7
    db $F0

String_2F_00_1F:: ; heuristic: string; C0
Data_02F_4689:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "There are no", $F1
    db "usable items!", $F7
    db $F0

String_2F_00_20:: ; heuristic: string; C0
Data_02F_46A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No fleeing from", $F1
    db "this battle!", $F7
    db $F0

String_2F_00_21:: ; heuristic: string; C0
Data_02F_46C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Can't use that", $F1
    db "skill now!", $F7
    db $F0

String_2F_00_22:: ; heuristic: string; C0
Data_02F_46E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Selecting", $F1
    db $F9, "0's move", $A4, $F0

String_2F_00_23:: ; heuristic: string; C0
Data_02F_46F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No monsters to", $F1
    db "access PLAN.", $F7
    db $F0

String_2F_00_24:: ; heuristic: string; C0
Data_02F_4713:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "There is no target", $F1
    db "in sight!", $F7
    db $F0

String_2F_00_25:: ; heuristic: string; C0
Data_02F_4732:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "That skill can't", $F1
    db "be used in battle!", $F7
    db $F0

String_2F_00_26:: ; heuristic: string; C0
Data_02F_4757:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Not enough MP!", $F1
    db $F7
    db $F0

String_2F_00_27:: ; heuristic: string; C0
Data_02F_4769:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Retire now?", $F1
    db $F0

String_2F_00_28:: ; heuristic: string; C0
Data_02F_4777:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ignored", $F1
    db "orders!", $EC, $F0

String_2F_00_29:: ; heuristic: string; C0
Data_02F_478C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "It has no usable", $F1
    db "battle skills!", $EC, $F0

String_2F_00_2A:: ; heuristic: string; C0
Data_02F_47AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "not recruited!", $EC, $F0

String_2F_00_2B:: ; heuristic: string; C0
Data_02F_47C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "already recruited.", $EC, $F0

String_2F_00_2C:: ; heuristic: string; C0
Data_02F_47DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But the escape", $F1
    db "route was cut off!", $EC, $F0

String_2F_00_2D:: ; heuristic: string; C0
Data_02F_47FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But there's no one", $F1
    db "to command!", $F7
    db $F0

String_2F_00_2E:: ; heuristic: string; C0
Data_02F_481E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "at full power!", $EC, $F0

String_2F_00_2F:: ; heuristic: string; C0
Data_02F_4839:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tucked", $F1
    db "tighter in fear!", $EC, $F0

String_2F_00_30:: ; heuristic: string; C0
Data_02F_4856:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "concentrated!", $EC, $F0

String_2F_00_31:: ; heuristic: string; C0
Data_02F_4869:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "back, enraged.", $EC, $F0

String_2F_00_32:: ; heuristic: string; C0
Data_02F_4884:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Light fell softly", $F1
    db "on ", $F9, "0!", $EC, $F0

String_2F_00_33:: ; heuristic: string; C0
Data_02F_489F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ducked", $F1
    db "behind ", $F9, "G!", $EC, $F0

String_2F_00_34:: ; heuristic: string; C0
Data_02F_48B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 pumped", $F1
    db "itself up!", $EC, $F0

String_2F_00_35:: ; heuristic: string; C0
Data_02F_48CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 rolled", $F1
    db "out of the way!", $EC, $F0

String_2F_00_36:: ; heuristic: string; C0
Data_02F_48E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_37:: ; heuristic: string; C0
Data_02F_4915:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_38:: ; heuristic: string; C0
Data_02F_4941:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_39:: ; heuristic: string; C0
Data_02F_4973:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to jump high!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_3A:: ; heuristic: string; C0
Data_02F_49AA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to call for help!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_3B:: ; heuristic: string; C0
Data_02F_49E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to yell for help!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_3C:: ; heuristic: string; C0
Data_02F_4A20:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to pump itself up!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_3D:: ; heuristic: string; C0
Data_02F_4A5C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to cast a curse!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_3E:: ; heuristic: string; C0
Data_02F_4A96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to inhale all!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_3F:: ; heuristic: string; C0
Data_02F_4ACE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quiets", $F1
    db $F9, "W!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_40:: ; heuristic: string; C0
Data_02F_4AFC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to sing!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_41:: ; heuristic: string; C0
Data_02F_4B2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to make a barrier!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_42:: ; heuristic: string; C0
Data_02F_4B6A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the heavens!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_43:: ; heuristic: string; C0
Data_02F_4BA4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "for silence!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_44:: ; heuristic: string; C0
Data_02F_4BDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to shoot water!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_45:: ; heuristic: string; C0
Data_02F_4C14:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 called", $F1
    db "for ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_46:: ; heuristic: string; C0
Data_02F_4C46:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to use ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_47:: ; heuristic: string; C0
Data_02F_4C7A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "waking ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_48:: ; heuristic: string; C0
Data_02F_4CAE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "ready to inhale!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

String_2F_00_49:: ; heuristic: string; C0
Data_02F_4CE6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But its spells", $F1
    db "are sealed!", $EC, $F0

String_2F_00_4A:: ; heuristic: string; C0
Data_02F_4D11:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "blowing ", $F9, "G!", $EC, $F2, $ED, "But its mouth is", $F1
    db "sealed tight!", $EC, $F0

String_2F_00_4B:: ; heuristic: string; C0
Data_02F_4D49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F2, $ED, "But it can't do", $F1
    db "the dance!", $EC, $F0

String_2F_00_4C:: ; heuristic: string; C0
Data_02F_4D79:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

String_2F_00_4D:: ; heuristic: string; C0
Data_02F_4DA6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But it is sealed", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_4E:: ; heuristic: string; C0
Data_02F_4DD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to use ", $F9, "G!", $EC, $F2, $ED, "But it is sealed", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_4F:: ; heuristic: string; C0
Data_02F_4E0A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db $F9, "G!", $EC, $F2, $ED, "But it is sealed", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_50:: ; heuristic: string; C0
Data_02F_4E38:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "waking ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_51:: ; heuristic: string; C0
Data_02F_4E6F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to call for help!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_52:: ; heuristic: string; C0
Data_02F_4EAD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to yell for help!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_53:: ; heuristic: string; C0
Data_02F_4EEB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to build power!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_54:: ; heuristic: string; C0
Data_02F_4F27:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to pump itself up!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_55:: ; heuristic: string; C0
Data_02F_4F66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to jump high!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_56:: ; heuristic: string; C0
Data_02F_4FA0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_57:: ; heuristic: string; C0
Data_02F_4FD5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "ready to inhale!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_58:: ; heuristic: string; C0
Data_02F_5010:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quiets", $F1
    db $F9, "W!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_59:: ; heuristic: string; C0
Data_02F_5041:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to make a barrier!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_5A:: ; heuristic: string; C0
Data_02F_5080:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to inhale all!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_5B:: ; heuristic: string; C0
Data_02F_50BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to sing!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_5C:: ; heuristic: string; C0
Data_02F_50F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the heavens!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_5D:: ; heuristic: string; C0
Data_02F_512D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to shoot water!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_5E:: ; heuristic: string; C0
Data_02F_5169:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 called", $F1
    db "for ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_5F:: ; heuristic: string; C0
Data_02F_519E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "blowing ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

String_2F_00_60:: ; heuristic: string; C0
Data_02F_51D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You threw in", $F1
    db "the towel!", $EC, $F0

String_2F_00_61:: ; heuristic: string; C0
Data_02F_51F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turns left!", $F1
    db $EC, $F0

String_2F_00_62:: ; heuristic: string; C0
Data_02F_5202:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No turns left.", $F1
    db "This ends a draw.", $EC, $F0

String_2F_00_63:: ; heuristic: string; C0
Data_02F_5225:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You broke a battle", $F1
    db "rule!", $FA, $F7
    db $F2, "You lose.", $FA, $F7
    db $F0

String_2F_00_64:: ; heuristic: string; C0
Data_02F_524D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Your opponent", $F1
    db "broke a rule!", $FA, $F7
    db $F2, "You win.", $FA, $F7
    db $F0

String_2F_00_65:: ; heuristic: string; C0
Data_02F_5277:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "That skill isn't", $F1
    db "for own use!", $EC, $F0

String_2F_00_66:: ; heuristic: string; C0
Data_02F_5296:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "casting a spell!", $F1
    db "But it failed!", $EC, $F0

String_2F_00_67:: ; heuristic: string; C0
Data_02F_52CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a skill!", $F1
    db "But it failed!", $EC, $F0

String_2F_00_68:: ; heuristic: string; C0
Data_02F_52FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to use magic!", $F1
    db "But it failed!", $EC, $F0

String_2F_00_69:: ; heuristic: string; C0
Data_02F_532D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "casting a spell!", $F1
    db "Not enough MP!", $EC, $F0

String_2F_00_6A:: ; heuristic: string; C0
Data_02F_5361:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a skill!", $F1
    db "Not enough MP!", $EC, $F0

String_2F_00_6B:: ; heuristic: string; C0
Data_02F_5393:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to use magic!", $F1
    db "Not enough MP!", $EC, $F0

String_2F_00_6C:: ; heuristic: string; C0
Data_02F_53C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Thordain into", $F1
    db "Alldain!", $EC, $F2, $ED, "But spell was", $F1
    db "sealed!", $EC, $F0

String_2F_00_6D:: ; heuristic: string; C0
Data_02F_5408:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Thordain into", $F1
    db "Alldain!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

String_2F_00_6E:: ; heuristic: string; C0
Data_02F_5453:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Blazemost and", $F1
    db "Blizzard into", $EC, $F2, $ED, "Blitzer!", $F1
    db "But it was sealed!", $EC, $F0

String_2F_00_6F:: ; heuristic: string; C0
Data_02F_54A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Blazemost and", $F1
    db "Blizzard into", $EC, $F2, $ED, "Blitzer!", $F1
    db "But it shattered!", $EC, $F0

String_2F_00_70:: ; heuristic: string; C0
Data_02F_54F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Sacrifice into", $F1
    db "Martyr!", $EC, $F2, $ED, "But spell was", $F1
    db "sealed!", $EC, $F0

String_2F_00_71:: ; heuristic: string; C0
Data_02F_5534:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Sacrifice into", $F1
    db "Martyr!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

String_2F_00_72:: ; heuristic: string; C0
Data_02F_557F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G let", $EC, $F2, $ED, "loose their entire", $F1
    db "magical power!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

String_2F_00_73:: ; heuristic: string; C0
Data_02F_55CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G let", $EC, $F2, $ED, "loose their entire", $F1
    db "magical power!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

String_2F_00_74:: ; heuristic: string; C0
Data_02F_5622:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon a spirit!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

String_2F_00_75:: ; heuristic: string; C0
Data_02F_5671:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon death!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

String_2F_00_76:: ; heuristic: string; C0
Data_02F_56BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to turn into a", $F1
    db "huge dragon!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

String_2F_00_77:: ; heuristic: string; C0
Data_02F_5709:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to turn into a", $F1
    db "huge dragon!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

String_2F_00_78:: ; heuristic: string; C0
Data_02F_5758:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, $ED, "a vacuum for", $F1
    db "stealing MP!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

String_2F_00_79:: ; heuristic: string; C0
Data_02F_57A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, $ED, "a vacuum for", $F1
    db "stealing MP!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

String_2F_00_7A:: ; heuristic: string; C0
Data_02F_57F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

String_2F_00_7B:: ; heuristic: string; C0
Data_02F_583D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "eat while asleep!", $EC, $F0

String_2F_00_7C:: ; heuristic: string; C0
Data_02F_5859:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "eat while", $EC, $F2, $ED, "paralyzed!", $EC, $F0

String_2F_00_7D:: ; heuristic: string; C0
Data_02F_587A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is a", $F1
    db "hunk of iron!", $EC, $F0

String_2F_00_7E:: ; heuristic: string; C0
Data_02F_5892:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 brushed", $F1
    db "off ", $F9, "W!", $EC, $F0

String_2F_00_7F:: ; heuristic: string; C0
Data_02F_58A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But there is no", $F1
    db "one to betray!", $F7
    db $F0

String_2F_00_80:: ; heuristic: string; C0
Data_02F_58C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a linked", $F1
    db "skill!", $EC, $F2, $ED, "But the skill was", $F1
    db "sealed!", $EC, $F0

String_2F_00_81:: ; heuristic: string; C0
Data_02F_590E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced ", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

String_2F_00_82:: ; heuristic: string; C0
Data_02F_5958:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a linked", $F1
    db "skill!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

String_2F_00_83:: ; heuristic: string; C0
Data_02F_599F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, $ED, "a vacuum for", $F1
    db "stealing MP!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

String_2F_00_84:: ; heuristic: string; C0
Data_02F_59EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a linked", $F1
    db "skill!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

String_2F_00_85:: ; heuristic: string; C0
Data_02F_5A35:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced ", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

String_2F_00_86:: ; heuristic: string; C0
Data_02F_5A82:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Monster was", $F1
    db "defeated!", $E4, $7E, $FA, $F7
    db $F0

String_2F_00_87:: ; heuristic: string; C0
Data_02F_5A9C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's party", $F1
    db "was wiped out!", $E5, $42, $F0

String_2F_00_88:: ; heuristic: string; C0
Data_02F_5AB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turn left!", $F1
    db $EC, $F0

String_2F_01_00:: ; heuristic: string; C0
Data_02F_5AC9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "attacked!", $EC, $F0

String_2F_01_01:: ; heuristic: string; C0
Data_02F_5AD8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F0

String_2F_01_02:: ; heuristic: string; C0
Data_02F_5AE6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 loosed", $F1
    db $F9, "G!", $EC, $F0

String_2F_01_03:: ; heuristic: string; C0
Data_02F_5AF6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db $F9, "G!", $EC, $F0

String_2F_01_04:: ; heuristic: string; C0
Data_02F_5B04:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F0

String_2F_01_05:: ; heuristic: string; C0
Data_02F_5B18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G shot", $F1
    db "from ", $F9, "0!", $EC, $F0

String_2F_01_06:: ; heuristic: string; C0
Data_02F_5B2B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 closed", $F1
    db "in on ", $F9, "G!", $EC, $F0

String_2F_01_07:: ; heuristic: string; C0
Data_02F_5B41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 charged", $F1
    db "at ", $F9, "G!", $EC, $F0

String_2F_01_08:: ; heuristic: string; C0
Data_02F_5B55:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 charged", $F1
    db "receklessly!", $EC, $F0

String_2F_01_09:: ; heuristic: string; C0
Data_02F_5B6F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dove at", $F1
    db $F9, "G!", $EC, $F0

String_2F_01_0A:: ; heuristic: string; C0
Data_02F_5B80:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 flailed", $F1
    db "at ", $F9, "G!", $EC, $F0

String_2F_01_0B:: ; heuristic: string; C0
Data_02F_5B94:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 smashed", $F1
    db $F9, "G!", $EC, $F0

String_2F_01_0C:: ; heuristic: string; C0
Data_02F_5BA5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 leapt", $F1
    db "high!", $EC, $F0

String_2F_01_0D:: ; heuristic: string; C0
Data_02F_5BB6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "out of the sky!", $EC, $F0

String_2F_01_0E:: ; heuristic: string; C0
Data_02F_5BD0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 inhaled", $F1
    db "deeply!", $EC, $F0

String_2F_01_0F:: ; heuristic: string; C0
Data_02F_5BE5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G prayed", $F1
    db "to the wind!", $EC, $F2, $ED, "Blades of air", $F1
    db "slash out!", $EC, $F0

String_2F_01_10:: ; heuristic: string; C0
Data_02F_5C19:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 yelled", $F1
    db "for help!", $EC, $F0

String_2F_01_11:: ; heuristic: string; C0
Data_02F_5C2F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 called", $F1
    db "for help!", $EC, $F0

String_2F_01_12:: ; heuristic: string; C0
Data_02F_5C45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "concentrated!", $EC, $F0

String_2F_01_13:: ; heuristic: string; C0
Data_02F_5C58:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "like the wind!", $EC, $F0

String_2F_01_14:: ; heuristic: string; C0
Data_02F_5C73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "mightily!", $EC, $F0

String_2F_01_15:: ; heuristic: string; C0
Data_02F_5C89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 whipped", $F1
    db "up vicious winds!", $EC, $F0

String_2F_01_16:: ; heuristic: string; C0
Data_02F_5CA8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 brought", $F1
    db "lightning forth!", $EC, $F0

String_2F_01_17:: ; heuristic: string; C0
Data_02F_5CC6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 hurled", $F1
    db "huge boulders!", $EC, $F0

String_2F_01_18:: ; heuristic: string; C0
Data_02F_5CE1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 brought", $F1
    db "on an evil light!", $EC, $F2, $ED, "Thunderbolts", $F1
    db "hammered down!", $EC, $F0

String_2F_01_19:: ; heuristic: string; C0
Data_02F_5D1E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 set off", $F1
    db "a BigBang!", $EC, $F2, $ED, "Wild explosions", $F1
    db "echoed repeatedly!", $EC, $F0

String_2F_01_1A:: ; heuristic: string; C0
Data_02F_5D5B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 loosed", $F1
    db "all magic power!", $EC, $F2, $ED, "It set off a", $F1
    db "wicked explosion!", $EC, $F0

String_2F_01_1B:: ; heuristic: string; C0
Data_02F_5D99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 uttered", $F1
    db "a curse!", $EC, $F0

String_2F_01_1C:: ; heuristic: string; C0
Data_02F_5DAF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 kicked", $F1
    db "up a sandstorm!", $EC, $F0

String_2F_01_1D:: ; heuristic: string; C0
Data_02F_5DCB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 did an", $F1
    db "odd dance step!", $EC, $F0

String_2F_01_1E:: ; heuristic: string; C0
Data_02F_5DE7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 gave a", $F1
    db "powderpuff massage", $EC, $F2, $ED, "to ", $F9, "G!", $F1
    db $EC, $F0

String_2F_01_1F:: ; heuristic: string; C0
Data_02F_5E10:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 licked", $F1
    db $F9, "G's face!", $EC, $F0

String_2F_01_20:: ; heuristic: string; C0
Data_02F_5E26:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 kicked", $F1
    db $F9, "G low!", $EC, $F0

String_2F_01_21:: ; heuristic: string; C0
Data_02F_5E3A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G did a", $F1
    db "sweeping kick!", $EC, $F0

String_2F_01_22:: ; heuristic: string; C0
Data_02F_5E54:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 loosed", $F1
    db "a savage roar!", $EC, $F0

String_2F_01_23:: ; heuristic: string; C0
Data_02F_5E6F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the earth!", $EC, $F0

String_2F_01_24:: ; heuristic: string; C0
Data_02F_5E89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 whipped", $F1
    db "up ", $F9, "G!", $EC, $F0

String_2F_01_25:: ; heuristic: string; C0
Data_02F_5E9D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quieted", $F1
    db $F9, "G!", $EC, $F0

String_2F_01_26:: ; heuristic: string; C0
Data_02F_5EAE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 began", $F1
    db "to meditate!", $EC, $F2, $ED, $F9, "0's", $F1
    db "wounds healed!", $EC, $F0

String_2F_01_27:: ; heuristic: string; C0
Data_02F_5EDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 began", $F1
    db "singing!", $EC, $F0

String_2F_01_28:: ; heuristic: string; C0
Data_02F_5EEF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's song", $F1
    db "ended!", $EC, $F0

String_2F_01_29:: ; heuristic: string; C0
Data_02F_5F01:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 raised", $F1
    db "a water barrier!", $EC, $F0

String_2F_01_2A:: ; heuristic: string; C0
Data_02F_5F1E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "guarding itself!", $EC, $F0

String_2F_01_2B:: ; heuristic: string; C0
Data_02F_5F37:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shields", $F1
    db $F9, "G!", $EC, $F0

String_2F_01_2C:: ; heuristic: string; C0
Data_02F_5F48:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "braced for attack!", $EC, $F0

String_2F_01_2D:: ; heuristic: string; C0
Data_02F_5F63:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "ready to parry!", $EC, $F0

String_2F_01_2E:: ; heuristic: string; C0
Data_02F_5F7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is in a", $F1
    db "defensive pose!", $EC, $F0

String_2F_01_2F:: ; heuristic: string; C0
Data_02F_5F98:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "for payback!", $EC, $F0

String_2F_01_30:: ; heuristic: string; C0
Data_02F_5FB0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is set", $F1
    db "to inhale all!", $EC, $F0

String_2F_01_31:: ; heuristic: string; C0
Data_02F_5FCB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the heavens!", $EC, $F0

String_2F_01_32:: ; heuristic: string; C0
Data_02F_5FE7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "for silence!", $EC, $F2, $ED, "An invisible force", $F1
    db "pressed down!", $EC, $F0

String_2F_01_33:: ; heuristic: string; C0
Data_02F_6023:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shot", $F1
    db "water!", $EC, $F0

String_2F_01_34:: ; heuristic: string; C0
Data_02F_6034:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 created", $F1
    db "a huge tidal wave!", $EC, $F0

String_2F_01_35:: ; heuristic: string; C0
Data_02F_6054:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

String_2F_01_36:: ; heuristic: string; C0
Data_02F_6069:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

String_2F_01_37:: ; heuristic: string; C0
Data_02F_607E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's wound", $F1
    db "was healed!", $EC, $F0

String_2F_01_38:: ; heuristic: string; C0
Data_02F_6096:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "brutalized!", $EC, $F0

String_2F_01_39:: ; heuristic: string; C0
Data_02F_60AB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's DEF", $F1
    db "fell by ", $F9, "G!", $EC, $F0

String_2F_01_3A:: ; heuristic: string; C0
Data_02F_60C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's DEF", $F1
    db "fell by ", $F9, "G!", $EC, $F0

String_2F_01_3B:: ; heuristic: string; C0
Data_02F_60D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "use spells now!", $EC, $F0

String_2F_01_3C:: ; heuristic: string; C0
Data_02F_60F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's spells", $F1
    db "were sealed!", $EC, $F0

String_2F_01_3D:: ; heuristic: string; C0
Data_02F_610B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "stripped of ", $F9, "GMP!", $EC, $F0

String_2F_01_3E:: ; heuristic: string; C0
Data_02F_6126:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "stripped of ", $F9, "GMP!", $EC, $F0

String_2F_01_3F:: ; heuristic: string; C0
Data_02F_6141:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 started", $F1
    db "glowing!", $EC, $F0

String_2F_01_40:: ; heuristic: string; C0
Data_02F_6157:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 stole", $F1
    db $F9, "GMP!", $EC, $F0

String_2F_01_41:: ; heuristic: string; C0
Data_02F_6168:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "befuddled!", $EC, $F0

String_2F_01_42:: ; heuristic: string; C0
Data_02F_617F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "confused!", $EC, $F0

String_2F_01_43:: ; heuristic: string; C0
Data_02F_6195:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's ATK", $F1
    db "doubled!", $EC, $F0

String_2F_01_44:: ; heuristic: string; C0
Data_02F_61A8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turned", $F1
    db "into a dragon!", $EC, $F0

String_2F_01_45:: ; heuristic: string; C0
Data_02F_61C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's DEF", $F1
    db "rose by ", $F9, "G!", $EC, $F0

String_2F_01_46:: ; heuristic: string; C0
Data_02F_61D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's party", $F1
    db "turned into iron!", $EC, $F0

String_2F_01_47:: ; heuristic: string; C0
Data_02F_61F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turned", $F1
    db "into iron!", $EC, $F0

String_2F_01_48:: ; heuristic: string; C0
Data_02F_620E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's AGL", $F1
    db "was cut by ", $F9, "G!", $EC, $F0

String_2F_01_49:: ; heuristic: string; C0
Data_02F_6227:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's AGL", $F1
    db "rose by ", $F9, "G!", $EC, $F0

String_2F_01_4A:: ; heuristic: string; C0
Data_02F_623D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is lost", $F1
    db "in a daze!", $EC, $F0

String_2F_01_4B:: ; heuristic: string; C0
Data_02F_6255:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A veil of light", $F1
    db "formed before", $EC, $F2, $ED, $F9, "0!", $F1
    db $EC, $F0

String_2F_01_4C:: ; heuristic: string; C0
Data_02F_627C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A veil of light", $F1
    db "formed before", $EC, $F2, $ED, $F9, "0!", $F1
    db $EC, $F0

String_2F_01_4D:: ; heuristic: string; C0
Data_02F_62A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A barrier of", $F1
    db "light appeared.", $EC, $F0

String_2F_01_4E:: ; heuristic: string; C0
Data_02F_62C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "cured of poison.", $EC, $F0

String_2F_01_4F:: ; heuristic: string; C0
Data_02F_62DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is no", $F1
    db "longer paralyzed.", $EC, $F0

String_2F_01_50:: ; heuristic: string; C0
Data_02F_62F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 came", $F1
    db "back to life!", $EC, $F0

String_2F_01_51:: ; heuristic: string; C0
Data_02F_6311:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "uncursed!", $EC, $F0

String_2F_01_52:: ; heuristic: string; C0
Data_02F_6324:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 assumed", $F1
    db $F9, "G's form!", $EC, $F0

String_2F_01_53:: ; heuristic: string; C0
Data_02F_633B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Help arrived from", $F1
    db "seemingly nowhere!", $EC, $F0

String_2F_01_54:: ; heuristic: string; C0
Data_02F_6362:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "blinded by sand!", $EC, $F0

String_2F_01_55:: ; heuristic: string; C0
Data_02F_637C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's vision", $F1
    db "was harmed!", $EC, $F0

String_2F_01_56:: ; heuristic: string; C0
Data_02F_6395:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "weakened to magic!", $EC, $F0

String_2F_01_57:: ; heuristic: string; C0
Data_02F_63B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db $F9, "GMP!", $EC, $F0

String_2F_01_58:: ; heuristic: string; C0
Data_02F_63C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined", $F1
    db "the dancing!", $EC, $F0

String_2F_01_59:: ; heuristic: string; C0
Data_02F_63DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "content!", $EC, $F0

String_2F_01_5A:: ; heuristic: string; C0
Data_02F_63EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "goose bumps!", $EC, $F0

String_2F_01_5B:: ; heuristic: string; C0
Data_02F_6404:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "goose bumps!", $EC, $F2, $ED, $F9, "0's DEF", $F1
    db "dropped to ", $95, "1", $95, "!", $EC, $F0

String_2F_01_5C:: ; heuristic: string; C0
Data_02F_6434:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "shocked!", $EC, $F0

String_2F_01_5D:: ; heuristic: string; C0
Data_02F_6446:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 wiped", $F1
    db "out!", $EC, $F0

String_2F_01_5E:: ; heuristic: string; C0
Data_02F_6456:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "all applied magic!", $EC, $F0

String_2F_01_5F:: ; heuristic: string; C0
Data_02F_6473:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turned", $F1
    db "back to normal!", $EC, $F0

String_2F_01_60:: ; heuristic: string; C0
Data_02F_648F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "fully cured!", $EC, $F0

String_2F_01_61:: ; heuristic: string; C0
Data_02F_64A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined", $F1
    db "the battle!", $EC, $F0

String_2F_01_62:: ; heuristic: string; C0
Data_02F_64BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "dance anymore!", $EC, $F0

String_2F_01_63:: ; heuristic: string; C0
Data_02F_64D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "dance anymore!", $EC, $F0

String_2F_01_64:: ; heuristic: string; C0
Data_02F_64EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's mouth", $F1
    db "was sealed!", $EC, $F0

String_2F_01_65:: ; heuristic: string; C0
Data_02F_6507:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's mouth", $F1
    db "was sealed!", $EC, $F0

String_2F_01_66:: ; heuristic: string; C0
Data_02F_651F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is a", $F1
    db "hunk of iron!", $EC, $F0

String_2F_01_67:: ; heuristic: string; C0
Data_02F_6537:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 did not", $F1
    db "come back to life!", $EC, $F0

String_2F_01_68:: ; heuristic: string; C0
Data_02F_6557:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But it failed to", $F1
    db "reach ", $F9, "0!", $EC, $F0

String_2F_01_69:: ; heuristic: string; C0
Data_02F_6574:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But the call went", $F1
    db "unheard!", $EC, $F0

String_2F_01_6A:: ; heuristic: string; C0
Data_02F_6591:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dodged", $F1
    db "the breath!", $EC, $F0

String_2F_01_6B:: ; heuristic: string; C0
Data_02F_65A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quickly", $F1
    db "covered its ears!", $EC, $F0

String_2F_01_6C:: ; heuristic: string; C0
Data_02F_65C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shook", $F1
    db "off the sand!", $EC, $F0

String_2F_01_6D:: ; heuristic: string; C0
Data_02F_65E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 closed", $F1
    db "its eyes in time!", $EC, $F0

String_2F_01_6E:: ; heuristic: string; C0
Data_02F_65FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quickly", $F1
    db "dodged the attack!", $EC, $F0

String_2F_01_6F:: ; heuristic: string; C0
Data_02F_661F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 wasn't", $F1
    db "taken in!", $EC, $F0

String_2F_01_70:: ; heuristic: string; C0
Data_02F_6634:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 slid", $F1
    db "out of the way!", $EC, $F0

String_2F_01_71:: ; heuristic: string; C0
Data_02F_664E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "unharmed!", $EC, $F0

String_2F_01_72:: ; heuristic: string; C0
Data_02F_6661:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But the prayer", $F1
    db "went unanswered!", $EC, $F0

String_2F_01_73:: ; heuristic: string; C0
Data_02F_6683:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was put", $F1
    db "to sleep!", $EC, $F0

String_2F_01_74:: ; heuristic: string; C0
Data_02F_669A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "asleep!", $EC, $F0

String_2F_01_75:: ; heuristic: string; C0
Data_02F_66AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "poisoned!", $EC, $F0

String_2F_01_76:: ; heuristic: string; C0
Data_02F_66BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "paralyzed!", $EC, $F0

String_2F_01_77:: ; heuristic: string; C0
Data_02F_66D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "terribly poisoned!", $EC, $F0

String_2F_01_78:: ; heuristic: string; C0
Data_02F_66F2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 froze", $F1
    db "solid!", $EC, $F0

String_2F_01_79:: ; heuristic: string; C0
Data_02F_6704:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "frozen solid!", $EC, $F0

String_2F_01_7A:: ; heuristic: string; C0
Data_02F_671E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "back!", $EC, $F0

String_2F_01_7B:: ; heuristic: string; C0
Data_02F_6730:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 couldn't", $F1
    db "strike back!", $EC, $F0

String_2F_01_7C:: ; heuristic: string; C0
Data_02F_674A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "counterstrike!", $EC, $F0

String_2F_01_7D:: ; heuristic: string; C0
Data_02F_675F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 couldn't", $F1
    db "retaliate!", $EC, $F0

String_2F_01_7E:: ; heuristic: string; C0
Data_02F_6777:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db "back ", $F9, "G!", $EC, $F0

String_2F_01_7F:: ; heuristic: string; C0
Data_02F_678A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 went", $F1
    db "away!", $EC, $F0

String_2F_01_80:: ; heuristic: string; C0
Data_02F_679A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wind around", $F1
    db $F9, "0 died!", $EC, $F0

String_2F_01_81:: ; heuristic: string; C0
Data_02F_67B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The help went", $F1
    db "away!", $EC, $F0

String_2F_01_82:: ; heuristic: string; C0
Data_02F_67CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "woke up!", $EC, $F0

String_2F_01_83:: ; heuristic: string; C0
Data_02F_67D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 snapped", $F1
    db "out of confusion!", $EC, $F0

String_2F_01_84:: ; heuristic: string; C0
Data_02F_67F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "Ironize wore off!", $EC, $F0

String_2F_01_85:: ; heuristic: string; C0
Data_02F_6810:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's wall", $F1
    db "of light faded!", $EC, $F0

String_2F_01_86:: ; heuristic: string; C0
Data_02F_682B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The giant went", $F1
    db "away laughing!", $EC, $F0

String_2F_01_87:: ; heuristic: string; C0
Data_02F_684B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The ", $F9, "W", $F1
    db "shattered!", $EC, $F0

String_2F_01_88:: ; heuristic: string; C0
Data_02F_685F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 suffers", $F1
    db "from poison!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GHP!", $EC, $F0

String_2F_01_89:: ; heuristic: string; C0
Data_02F_6889:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "wracked by poison!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GHP!", $EC, $F0

String_2F_01_8A:: ; heuristic: string; C0
Data_02F_68B4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 died!", $F1
    db $EC, $F0

String_2F_01_8B:: ; heuristic: string; C0
Data_02F_68C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "defeated!", $EC, $F0

String_2F_01_8C:: ; heuristic: string; C0
Data_02F_68D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 died", $F1
    db "from dancing!", $EC, $F0

String_2F_01_8D:: ; heuristic: string; C0
Data_02F_68EB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "dead!", $EC, $F0

String_2F_01_8E:: ; heuristic: string; C0
Data_02F_68FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "instantly slain!", $EC, $F0

String_2F_01_8F:: ; heuristic: string; C0
Data_02F_6918:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The ", $F9, "0", $F1
    db "shattered!", $EC, $F0

String_2F_01_90:: ; heuristic: string; C0
Data_02F_692C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "dead!", $EC, $F0

String_2F_01_91:: ; heuristic: string; C0
Data_02F_693F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's prayer", $F1
    db "went unanswered!", $EC, $F0

String_2F_01_92:: ; heuristic: string; C0
Data_02F_695D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "SealPray was", $F1
    db "broken!", $EC, $F0

String_2F_01_93:: ; heuristic: string; C0
Data_02F_6974:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "flush with power!", $EC, $F0

String_2F_01_94:: ; heuristic: string; C0
Data_02F_6992:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took", $F1
    db "the ", $F9, "W from", $EC, $F2, $ED, $F9, "G.", $F1
    db $EC, $F0

String_2F_01_95:: ; heuristic: string; C0
Data_02F_69AF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ate the", $F1
    db "meat happily!", $EC, $F2, $ED, $F9, "0 grew to", $F1
    db "like ", $F9, "G!", $EC, $F0

String_2F_01_96:: ; heuristic: string; C0
Data_02F_69E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ate the", $F1
    db "meat fearfully!", $EC, $F2, $ED, $F9, "0 glared", $F1
    db "at ", $F9, "G!", $EC, $F0

String_2F_01_97:: ; heuristic: string; C0
Data_02F_6A10:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held the", $F1
    db $F9, "W aloft!", $EC, $F0

String_2F_01_98:: ; heuristic: string; C0
Data_02F_6A28:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A warm light shone", $F1
    db "from the Orb!", $EC, $F0

String_2F_01_99:: ; heuristic: string; C0
Data_02F_6A4B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 gripped", $F1
    db "the BeastTail!", $EC, $F0

String_2F_01_9A:: ; heuristic: string; C0
Data_02F_6A67:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The BeastTail", $F1
    db "began pointing!", $EC, $F0

String_2F_01_9B:: ; heuristic: string; C0
Data_02F_6A87:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held", $F1
    db $F9, "W aloft!", $EC, $F0

String_2F_01_9C:: ; heuristic: string; C0
Data_02F_6A9B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Critical hit!", $F1
    db $EC, $F0

String_2F_01_9D:: ; heuristic: string; C0
Data_02F_6AAC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A brutal hit!", $F1
    db $EC, $F0

String_2F_01_9E:: ; heuristic: string; C0
Data_02F_6ABD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "spells, dances", $EC, $F2, $ED, "and breaths are", $F1
    db "sealed!", $EC, $F0

String_2F_01_9F:: ; heuristic: string; C0
Data_02F_6AEC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 used", $F1
    db "the ", $F9, "W!", $EC, $F0

String_2F_01_A0:: ; heuristic: string; C0
Data_02F_6AFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tossed", $F1
    db "the ", $F9, "W", $EC, $F2, $ED, "at ", $F9, "G!", $F1
    db $EC, $F0

String_2F_01_A1:: ; heuristic: string; C0
Data_02F_6B1B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the SageRock!", $EC, $F0

String_2F_01_A2:: ; heuristic: string; C0
Data_02F_6B39:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 scattered", $F1
    db "the WorldDew!", $EC, $F0

String_2F_01_A3:: ; heuristic: string; C0
Data_02F_6B56:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "Bolts of lightning", $F1
    db "lashed out!", $EC, $F0

String_2F_01_A4:: ; heuristic: string; C0
Data_02F_6B8F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "Tornadoes leapt", $F1
    db "from its tip!", $EC, $F0

String_2F_01_A5:: ; heuristic: string; C0
Data_02F_6BC7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "A sinister fog", $F1
    db "descended!", $EC, $F0

String_2F_01_A6:: ; heuristic: string; C0
Data_02F_6BFB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "A blizzard howls", $F1
    db "from its tip!", $EC, $F0

String_2F_01_A7:: ; heuristic: string; C0
Data_02F_6C34:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "Flames leapt from", $F1
    db "its tip!", $EC, $F0

String_2F_01_A8:: ; heuristic: string; C0
Data_02F_6C69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 set off", $F1
    db "a towering geyser!", $EC, $F0

String_2F_01_A9:: ; heuristic: string; C0
Data_02F_6C89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "out of the sky!", $EC, $F0

String_2F_01_AA:: ; heuristic: string; C0
Data_02F_6CA3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G are", $EC, $F2, $ED, "looking for a", $F1
    db "chance!", $EC, $F0

String_2F_01_AB:: ; heuristic: string; C0
Data_02F_6CCB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F0

String_2F_01_AC:: ; heuristic: string; C0
Data_02F_6CF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The barrier popped", $F1
    db "and disappeared!", $EC, $F0

String_2F_01_AD:: ; heuristic: string; C0
Data_02F_6D1E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 landed", $F1
    db "awkwardly!", $EC, $F2, $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

String_2F_01_AE:: ; heuristic: string; C0
Data_02F_6D4A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 landed", $F1
    db "awkwardly!", $EC, $F2, $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

String_2F_01_AF:: ; heuristic: string; C0
Data_02F_6D76:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "landed safely!", $EC, $F0

String_2F_01_B0:: ; heuristic: string; C0
Data_02F_6D8A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G was", $F1
    db "shattered!", $EC, $F0

String_2F_01_B1:: ; heuristic: string; C0
Data_02F_6D9E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shook", $F1
    db "off ", $F9, "G!", $EC, $F0

String_2F_01_B2:: ; heuristic: string; C0
Data_02F_6DB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G are", $EC, $F2, $ED, "shielding a", $F1
    db "partner!", $EC, $F0

String_2F_01_B3:: ; heuristic: string; C0
Data_02F_6DD8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's MP was", $F1
    db "restored by ", $F9, "G!", $EC, $F0

String_2F_01_B4:: ; heuristic: string; C0
Data_02F_6DF5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G began", $EC, $F2, $ED, "to concentrate!", $F1
    db $EC, $F0

String_2F_01_B5:: ; heuristic: string; C0
Data_02F_6E1A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But ", $F9, "0 was", $F1
    db "unaffected!", $EC, $F0

String_2F_01_B6:: ; heuristic: string; C0
Data_02F_6E33:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took a", $F1
    db "wild swing!", $EC, $F2, $ED, "And managed to", $F1
    db "hurt only itself!", $EC, $F0

String_2F_01_B7:: ; heuristic: string; C0
Data_02F_6E6E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "shaking in fear!", $EC, $F0

String_2F_01_B8:: ; heuristic: string; C0
Data_02F_6E87:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 charged", $F1
    db "at ", $F9, "G!", $EC, $F2, $ED, "But tripped and", $F1
    db "wiped out!", $EC, $F0

String_2F_01_B9:: ; heuristic: string; C0
Data_02F_6EB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "paralyzed!", $EC, $F0

String_2F_01_BA:: ; heuristic: string; C0
Data_02F_6ECF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "attack!", $EC, $F2, $ED, "It appears unable", $F1
    db "to move properly.", $EC, $F0

String_2F_01_BB:: ; heuristic: string; C0
Data_02F_6F03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 began", $F1
    db "dancing!", $EC, $F0

String_2F_01_BC:: ; heuristic: string; C0
Data_02F_6F17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A foul being was", $F1
    db "summoned!", $EC, $F0

String_2F_01_BD:: ; heuristic: string; C0
Data_02F_6F34:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 let off", $F1
    db "a black cloud!", $EC, $F0

String_2F_01_BE:: ; heuristic: string; C0
Data_02F_6F50:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "filled with power!", $EC, $F0

String_2F_01_BF:: ; heuristic: string; C0
Data_02F_6F68:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "all its MP!", $EC, $F0

String_2F_01_C0:: ; heuristic: string; C0
Data_02F_6F7E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $AA, "Chance, Chance,", $F1
    db "Chance", $A4, $AA, $EC, $F2, $ED, "The call echoed", $F1
    db "over and over!", $EC, $F0

String_2F_01_C1:: ; heuristic: string; C0
Data_02F_6FBB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A laughng giant", $F1
    db "appeared!", $EC, $F2, $ED, "The giant", $F1
    db "attacked!", $EC, $F0

String_2F_01_C2:: ; heuristic: string; C0
Data_02F_6FED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A cold wind swept", $F1
    db $F9, "0's party!", $EC, $F0

String_2F_01_C3:: ; heuristic: string; C0
Data_02F_700C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's MP", $F1
    db "was restored!", $EC, $F0

String_2F_01_C4:: ; heuristic: string; C0
Data_02F_7023:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Meteors rained", $F1
    db "from the heavens!", $EC, $F0

String_2F_01_C5:: ; heuristic: string; C0
Data_02F_7046:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wall of light", $F1
    db "bounced the spell!", $EC, $F0

String_2F_01_C6:: ; heuristic: string; C0
Data_02F_706D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wall of light", $F1
    db "bounced the spell!", $EC, $F0

String_2F_01_C7:: ; heuristic: string; C0
Data_02F_7094:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wind around", $F1
    db $F9, "0 bounced", $EC, $F2, $ED, "the attack!", $F1
    db $EC, $F0

String_2F_01_C8:: ; heuristic: string; C0
Data_02F_70C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shunted", $F1
    db "the attack!", $EC, $F0

String_2F_01_C9:: ; heuristic: string; C0
Data_02F_70D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 failed", $F1
    db "to avert attack!", $EC, $F0

String_2F_01_CA:: ; heuristic: string; C0
Data_02F_70F6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 guarded", $F1
    db $F9, "G!", $EC, $F0

String_2F_01_CB:: ; heuristic: string; C0
Data_02F_7107:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 inhaled", $F1
    db "the attack!", $EC, $F0

String_2F_01_CC:: ; heuristic: string; C0
Data_02F_7120:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But nothing", $F1
    db "happened!", $EC, $F0

String_2F_01_CD:: ; heuristic: string; C0
Data_02F_7138:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's AGL", $F1
    db "fell by ", $F9, "G!", $EC, $F0

String_2F_01_CE:: ; heuristic: string; C0
Data_02F_714E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 didn't", $F1
    db "fall asleep!", $EC, $F0

String_2F_01_CF:: ; heuristic: string; C0
Data_02F_7166:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "more confused!", $EC, $F0

String_2F_01_D0:: ; heuristic: string; C0
Data_02F_7181:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Miss! ", $F9, "0", $F1
    db "was unharmed!", $EC, $F0

String_2F_01_D1:: ; heuristic: string; C0
Data_02F_719A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Miss! ", $F9, "0", $F1
    db "avoided damage!", $EC, $F0

String_2F_01_D2:: ; heuristic: string; C0
Data_02F_71B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 leapt", $F1
    db "out of the way!", $EC, $F0

String_2F_01_D3:: ; heuristic: string; C0
Data_02F_71D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "dead!", $EC, $F0, "leapt "

String_2F_01_D4:: ; heuristic: string; C0
Data_02F_71E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "already asleep!", $EC, $F0

String_2F_01_D5:: ; heuristic: string; C0
Data_02F_7201:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is now", $F1
    db "weak to spells!", $EC, $F0

String_2F_01_D6:: ; heuristic: string; C0
Data_02F_721D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A gentle rain", $F1
    db "fell!", $EC, $F0

String_2F_01_D7:: ; heuristic: string; C0
Data_02F_7233:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 has", $F1
    db "been immobilized!", $EC, $F0

String_2F_01_D8:: ; heuristic: string; C0
Data_02F_724E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fled!", $F1
    db $EC, $F0

String_2F_01_D9:: ; heuristic: string; C0
Data_02F_725A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "cursed!", $EC, $F0

String_2F_01_DA:: ; heuristic: string; C0
Data_02F_726B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "building power!", $EC, $F0

String_2F_01_DB:: ; heuristic: string; C0
Data_02F_7283:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "all applied magic!", $EC, $F0

String_2F_01_DC:: ; heuristic: string; C0
Data_02F_72A0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 gave a", $F1
    db "powderpuff massage", $EC, $F2, $ED, "to ", $F9, "G!", $F1
    db $EC, $F0

String_2F_01_DD:: ; heuristic: string; C0
Data_02F_72C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "blown sky-high!", $EC, $F0

String_2F_01_DE:: ; heuristic: string; C0
Data_02F_72E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "dance anymore!", $EC, $F0

String_2F_01_DF:: ; heuristic: string; C0
Data_02F_72FB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "its MP!", $EC, $F0

String_2F_01_E0:: ; heuristic: string; C0
Data_02F_730D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "vacant and lost!", $EC, $F0

String_2F_01_E1:: ; heuristic: string; C0
Data_02F_7329:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "guarding itself!", $EC, $F0

String_2F_01_E2:: ; heuristic: string; C0
Data_02F_7342:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "dizzy and fell!", $EC, $F0

String_2F_01_E3:: ; heuristic: string; C0
Data_02F_735B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "balance and fell!", $EC, $F0

String_2F_01_E4:: ; heuristic: string; C0
Data_02F_7377:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "down, asleep!", $EC, $F0

String_2F_01_E5:: ; heuristic: string; C0
Data_02F_7392:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "and woke up!", $EC, $F0

String_2F_01_E6:: ; heuristic: string; C0
Data_02F_73A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "eat while", $EC, $F2, $ED, "paralyzed!", $EC, $F0

String_2F_01_E7:: ; heuristic: string; C0
Data_02F_73CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wind around", $F1
    db $F9, "0 died!", $EC, $F0

String_2F_01_E8:: ; heuristic: string; C0
Data_02F_73E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's wall", $F1
    db "of light faded!", $EC, $F0

String_2F_01_E9:: ; heuristic: string; C0
Data_02F_7400:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's water", $F1
    db "barrier reacted!", $EC, $F0

String_2F_01_EA:: ; heuristic: string; C0
Data_02F_741D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's water", $F1
    db "barrier reacted!", $EC, $F0

String_2F_01_EB:: ; heuristic: string; C0
Data_02F_743A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Thordain into", $F1
    db "Alldain!", $EC, $F0

String_2F_01_EC:: ; heuristic: string; C0
Data_02F_7466:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "BlazeMost and", $F1
    db "Blizzard into", $EC, $F2, $ED, "Blitzer!", $F1
    db $EC, $F0

String_2F_01_ED:: ; heuristic: string; C0
Data_02F_74A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G blasted", $EC, $F2, $ED, "a Tidalwave with", $F1
    db "shockwaves to make", $EC, $F2, $ED, "WaveBlast!", $F1
    db $EC, $F0

String_2F_01_EE:: ; heuristic: string; C0
Data_02F_74EB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tore", $EC, $F2, $ED, "tornadoes with", $F1
    db "shockwaves to", $EC, $F2, $ED, "loose RageAir!", $F1
    db $EC, $F0

String_2F_01_EF:: ; heuristic: string; C0
Data_02F_752D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G rocked", $EC, $F2, $ED, "the ground with", $F1
    db "shockwaves to", $EC, $F2, $ED, "loose RageQuake!", $F1
    db $EC, $F0

String_2F_01_F0:: ; heuristic: string; C0
Data_02F_7574:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "two GigaSlashes", $F1
    db "into GigaBreak!", $EC, $F0

String_2F_01_F1:: ; heuristic: string; C0
Data_02F_75A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "two Sacrifices", $F1
    db "into Martyr!", $EC, $F0

String_2F_01_F2:: ; heuristic: string; C0
Data_02F_75DA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G hurled", $EC, $F2, $ED, $F9, "W high", $F1
    db "and dropped it!", $EC, $F0

String_2F_01_F3:: ; heuristic: string; C0
Data_02F_7607:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G made", $EC, $F2, $ED, "SquallHit faster", $F1
    db "using SpeedUp!", $EC, $F0

String_2F_01_F4:: ; heuristic: string; C0
Data_02F_763A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G let", $EC, $F2, $ED, "loose their entire", $F1
    db "magical power!", $EC, $F2, $ED, "It set off a", $F1
    db "wicked explosion!", $EC, $F0

String_2F_01_F5:: ; heuristic: string; C0
Data_02F_768F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon a spirit!", $EC, $F0

String_2F_01_F6:: ; heuristic: string; C0
Data_02F_76C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon death!", $EC, $F0

String_2F_01_F7:: ; heuristic: string; C0
Data_02F_76F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "into a huge", $F1
    db "dragon!", $EC, $F0

String_2F_01_F8:: ; heuristic: string; C0
Data_02F_7719:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "their skills into", $F1
    db "a wave of energy!", $EC, $F0

String_2F_01_F9:: ; heuristic: string; C0
Data_02F_7752:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G loosed", $EC, $F2, $ED, "a white, obscuring", $F1
    db "cloud!", $EC, $F0

String_2F_01_FA:: ; heuristic: string; C0
Data_02F_7781:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, "a vacuum for", $F1
    db "stealing MP!", $EC, $F0

String_2F_01_FB:: ; heuristic: string; C0
Data_02F_77B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Critical hit!", $F1
    db $EC, $F0

String_2F_01_FC:: ; heuristic: string; C0
Data_02F_77C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A brutal hit!", $F1
    db $EC, $F0

String_2F_01_FD:: ; heuristic: string; C0
Data_02F_77D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $ED, "The monsters ate", $F1
    db "the meat happily!", $EC, $F2, $ED, "The monsters grew", $F1
    db "to like ", $F9, "G!", $EC, $F0

String_2F_01_FE:: ; heuristic: string; C0
Data_02F_7818:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters ate the", $F1
    db "meat fearfully!", $EC, $F2, $ED, "Monsters glared", $F1
    db "at ", $F9, "G!", $EC, $F0

String_2F_01_FF:: ; heuristic: string; C0
Data_02F_7854:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters were", $F1
    db "filled with power!", $EC, $F0

String_2F_02_00:: ; heuristic: string; C0
Data_02F_7877:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fixed", $F0

String_2F_02_01:: ; heuristic: string; C0
Data_02F_787D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Auto", $F0

String_2F_02_02:: ; heuristic: string; C0
Data_02F_7882:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fixed", $F0

String_2F_02_03:: ; heuristic: string; C0
Data_02F_7888:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Auto", $F0

String_2F_03_00:: ; heuristic: string; C0
Data_02F_788D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined", $F0

String_2F_05_00:: ; heuristic: string; C0
Data_02F_7897:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EF, $EE, $F6, "'s party got", $EF, $EE, $F9, "0 EX points!", $FA, $F7
    db $F0

String_2F_05_01:: ; heuristic: string; C0
Data_02F_78B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $E5, "0", $ED, $F9, "0 was", $F1
    db "promoted to Lv", $F9, "G!", $E5, $50, $FA, $F7
    db $F2, $ED, $F9, "0", $E8, "60Max. HP ", $A2, $F9, "W", $E8, "01Lv", $F9, "G", $E8, "61Max. MP ", $A2, $F9
    db "a", $FA, $F7
    db $F2, $ED, $F9, "0", $E8, "60ATK ", $A2, $F9, "e", $E8, "01Lv", $F9, "G", $E8, "61DEF ", $A2, $F9, "i", $FA, $F7
    db $F2, $ED, $F9, "0", $E8, "60AGL ", $A2, $F9, "m", $E8, "01Lv", $F9, "G", $E8, "61INT ", $A2, $F9, "q", $FA, $F7
    db $F0

String_2F_05_02:: ; heuristic: string; C0
Data_02F_7942:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "At Lv", $F9, "G, ", $F9, "0 ", $F1
    db "learned ", $F9, "W!", $FA, $F7
    db $F0

String_2F_05_04:: ; heuristic: string; C0
Data_02F_795E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's ", $F9, "m", $F1
    db "became ", $F9, "W!", $FA, $F7
    db $F0

String_2F_05_05:: ; heuristic: string; C0
Data_02F_7973:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 devised", $F1
    db $F9, "W from the", $FA, $F7
    db $F2, $ED, "skills it knows!", $FA, $F7
    db $F0

String_2F_05_06:: ; heuristic: string; C0
Data_02F_79A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But ", $F9, "0 can't", $F1
    db "learn more skills!", $FA, $F7
    db $F2, $ED, "Which skill should", $F1
    db "be forgotten?", $FA, $F7
    db $F0

String_2F_05_07:: ; heuristic: string; C0
Data_02F_79E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Which skill should", $F1
    db "be forgotten?", $FA, $F7
    db $F0

String_2F_05_08:: ; heuristic: string; C0
Data_02F_7A0B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Forget ", $F9, "W?", $F1
    db "Are you sure?", $F0

String_2F_05_09:: ; heuristic: string; C0
Data_02F_7A25:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "W was", $F1
    db "forgottten.", $FA, $F7
    db $F0

String_2F_05_0A:: ; heuristic: string; C0
Data_02F_7A3B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "It has reached the", $F1
    db "limit for growth.", $FA, $F7
    db $F0

String_2F_05_0B:: ; heuristic: string; C0
Data_02F_7A63:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got up,", $F1
    db "looking hopeful.", $FA, $F7
    db $F2, $ED, "Allow ", $F9, "0 ", $F1
    db "to join you?", $F0

String_2F_05_0C:: ; heuristic: string; C0
Data_02F_7A9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "departed sadly", $A4, $FA, $F7
    db $F0

String_2F_05_0D:: ; heuristic: string; C0
Data_02F_7AB0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But there is no", $F1
    db "more room!", $FA, $F7
    db $F2, $ED, "Release a monster", $F1
    db "to make room?", $F0

String_2F_05_0E:: ; heuristic: string; C0
Data_02F_7AEF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Which will you", $F1
    db "choose?", $F0

String_2F_05_0F:: ; heuristic: string; C0
Data_02F_7B07:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You have no eggs.", $FA, $F7
    db $F0

String_2F_05_10:: ; heuristic: string; C0
Data_02F_7B1C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Release a monster", $F1
    db "for the new one?", $F0

String_2F_05_11:: ; heuristic: string; C0
Data_02F_7B40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Choose a monster", $F1
    db "to release.", $F0

String_2F_05_12:: ; heuristic: string; C0
Data_02F_7B5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Do you want to", $F1
    db "release ", $F9, "G?", $F0

String_2F_05_13:: ; heuristic: string; C0
Data_02F_7B7A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G was set", $F1
    db "free in the wild.", $FA, $F7
    db $F0

String_2F_05_14:: ; heuristic: string; C0
Data_02F_7B9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Please name", $F1
    db $F9, "0.", $FA, $F7
    db $F0

String_2F_05_15:: ; heuristic: string; C0
Data_02F_7BAD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You can't travel", $F1
    db "all alone.", $FA, $F7
    db $F0

String_2F_05_16:: ; heuristic: string; C0
Data_02F_7BCB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Choose an egg to", $F1
    db "abandon.", $F0

String_2F_05_17:: ; heuristic: string; C0
Data_02F_7BE6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Abandon ", $F9, "G's", $F1
    db "egg?", $F0

String_2F_05_18:: ; heuristic: string; C0
Data_02F_7BF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G's egg", $F1
    db "was abandoned.", $FA, $F7
    db $F0

String_2F_05_19:: ; heuristic: string; C0
Data_02F_7C12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Will you take", $F1
    db $F9, "0 with you?", $F0

String_2F_05_1A:: ; heuristic: string; C0
Data_02F_7C2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was sent", $F1
    db "back to the farm.", $E5, $D6, $FA, $F7
    db $F0

String_2F_05_1B:: ; heuristic: string; C0
Data_02F_7C51:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined the", $F1
    db "party.", $E5, $D6, $FA, $F7
    db $F0

String_2F_05_1C:: ; heuristic: string; C0
Data_02F_7C6B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Choose the monster", $F1
    db "to send home.", $F0

String_2F_05_1D:: ; heuristic: string; C0
Data_02F_7C8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Send ", $F9, "0 back to", $F1
    db "the farm?", $F0

String_2F_05_1E:: ; heuristic: string; C0
Data_02F_7CA8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got up,", $F1
    db "looking hopeful.", $FA, $F7
    db $F2, $ED, "But it sadly went", $F1
    db "away", $A4, $FA, $F7
    db $F0

String_2F_05_1F:: ; heuristic: string; C0
Data_02F_7CE2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 learned", $F1
    db $F9, "G!", $F7
    db $F0

String_2F_05_20:: ; heuristic: string; C0
Data_02F_7CF3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was sent to", $F1
    db "the farm.", $E5, $54, $FA, $F7
    db $F0

String_2F_05_21:: ; heuristic: string; C0
Data_02F_7D11:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined the", $F1
    db "party.", $E5, $54, $FA, $F7
    db $F0
    ds $2D5, $00
