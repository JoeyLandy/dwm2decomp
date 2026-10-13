SECTION "Bank 08", ROMX[$4000], BANK[$08]
    db $08

; if wStringCategory < 9, BeginStringDisplay with DE = StringDatabase; otherwise far-calls
; BeginStringDisplay_Bank08_BeginStringDisplay
BeginStringDisplay_Bank08::
    ld a, [wStringCategory]
    cp $09
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank08_BeginStringDisplay
    ret

.call_begin_string_display:
    ld de, StringDatabase
    call BeginStringDisplay
    ret

; if wStringCategory < 9, CopyStringToBuffer with DE = StringDatabase; otherwise far-calls
; CopyStringToBuffer_Bank08_CopyStringToBuffer
CopyStringToBuffer_Bank08::
    ld a, [wStringCategory]
    cp $09
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank08_CopyStringToBuffer
    ret

.call_copy_string_to_buffer:
    ld de, StringDatabase
    call CopyStringToBuffer
    ret

; BeginStringDisplay_Bank08 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank08::
    call BeginStringDisplay_Bank08
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_08_4032::
StringDatabase::
    dw StringList_08_4044 ; id 0
    dw StringList_08_4242 ; id 1
    dw StringList_08_4258 ; id 2
CopyNameStringFromBank08Database_Data_4038::
    dw StringList_08_4458 ; id 3
    dw StringList_08_4558 ; id 4
ArenaMenu_Case27_Sub02_ReadFarPointerAtDEInBankB_Data::
    dw StringList_08_4716 ; id 5
    dw StringList_08_47F6 ; id 6
    dw StringList_08_48D6 ; id 7
    dw StringList_08_490C ; id 8

; category list of StringCategories_08_4032; one pointer per wStringIndex (E-0217)
; record: string
StringList_08_4044::
StringTable_System::
    dw String_08_00_00 ; id 0
    dw String_08_00_01 ; id 1
    dw String_08_00_02 ; id 2
    dw String_08_00_03 ; id 3
    dw String_08_00_04 ; id 4
    dw String_08_00_05 ; id 5
    dw String_08_00_05 ; id 6
    dw String_08_00_07 ; id 7
    dw String_08_00_08 ; id 8
    dw String_08_00_09 ; id 9
    dw String_08_00_0A ; id 10
    dw String_08_00_0B ; id 11
    dw String_08_00_0C ; id 12
    dw String_08_00_0D ; id 13
    dw String_08_00_0E ; id 14
    dw String_08_00_0F ; id 15
    dw String_08_00_10 ; id 16
    dw String_08_00_11 ; id 17
    dw String_08_00_12 ; id 18
    dw String_08_00_13 ; id 19
    dw String_08_00_14 ; id 20
    dw String_08_00_15 ; id 21
    dw String_08_00_15 ; id 22
    dw String_08_00_17 ; id 23
    dw String_08_00_18 ; id 24
    dw String_08_00_19 ; id 25
    dw String_08_00_1A ; id 26
    dw String_08_00_1B ; id 27
    dw String_08_00_1C ; id 28
    dw String_08_00_1D ; id 29
    dw String_08_00_1E ; id 30
    dw String_08_00_1F ; id 31
    dw String_08_00_20 ; id 32
    dw String_08_00_21 ; id 33
    dw String_08_00_22 ; id 34
    dw String_08_00_23 ; id 35
    dw String_08_00_24 ; id 36
    dw String_08_00_25 ; id 37
    dw String_08_00_26 ; id 38
    dw String_08_00_27 ; id 39
    dw String_08_00_28 ; id 40
    dw String_08_00_28 ; id 41
    dw String_08_00_2A ; id 42
    dw String_08_00_2B ; id 43
    dw String_08_00_2C ; id 44
    dw String_08_00_2D ; id 45
    dw String_08_00_2E ; id 46
    dw String_08_00_2F ; id 47
    dw String_08_00_30 ; id 48
    dw String_08_00_31 ; id 49
    dw String_08_00_32 ; id 50
    dw String_08_00_33 ; id 51
    dw String_08_00_34 ; id 52
    dw String_08_00_35 ; id 53
    dw String_08_00_36 ; id 54
    dw String_08_00_37 ; id 55
    dw String_08_00_38 ; id 56
    dw String_08_00_39 ; id 57
    dw String_08_00_3A ; id 58
    dw String_08_00_3B ; id 59
    dw String_08_00_3C ; id 60
    dw String_08_00_3D ; id 61
    dw String_08_00_3E ; id 62
    dw String_08_00_3F ; id 63
    dw String_08_00_40 ; id 64
    dw String_08_00_41 ; id 65
    dw String_08_00_42 ; id 66
    dw String_08_00_43 ; id 67
    dw String_08_00_44 ; id 68
    dw String_08_00_45 ; id 69
    dw String_08_00_46 ; id 70
    dw String_08_00_47 ; id 71
    dw String_08_00_48 ; id 72
    dw String_08_00_49 ; id 73
    dw String_08_00_4A ; id 74
    dw String_08_00_4B ; id 75
    dw String_08_00_4C ; id 76
    dw String_08_00_4D ; id 77
    dw String_08_00_4E ; id 78
    dw String_08_00_4F ; id 79
    dw String_08_00_50 ; id 80
    dw String_08_00_50 ; id 81
    dw String_08_00_52 ; id 82
    dw String_08_00_53 ; id 83
    dw String_08_00_54 ; id 84
    dw String_08_00_55 ; id 85
    dw String_08_00_56 ; id 86
    dw String_08_00_57 ; id 87
    dw String_08_00_58 ; id 88
    dw String_08_00_59 ; id 89
    dw String_08_00_5A ; id 90
    dw String_08_00_5B ; id 91
    dw String_08_00_5C ; id 92
    dw String_08_00_5D ; id 93
    dw String_08_00_5E ; id 94
    dw String_08_00_5F ; id 95
    dw String_08_00_60 ; id 96
    dw String_08_00_61 ; id 97
    dw String_08_00_62 ; id 98
    dw String_08_00_63 ; id 99
    dw String_08_00_64 ; id 100
    dw String_08_00_65 ; id 101
    dw String_08_00_66 ; id 102
    dw String_08_00_67 ; id 103
    dw String_08_00_68 ; id 104
    dw String_08_00_69 ; id 105
    dw String_08_00_6A ; id 106
    dw String_08_00_6B ; id 107
    dw String_08_00_6C ; id 108
    dw String_08_00_6D ; id 109
    dw String_08_00_6E ; id 110
    dw String_08_00_6F ; id 111
    dw String_08_00_70 ; id 112
    dw String_08_00_71 ; id 113
    dw String_08_00_72 ; id 114
    dw String_08_00_73 ; id 115
    dw String_08_00_73 ; id 116
    dw String_08_00_73 ; id 117
    dw String_08_00_73 ; id 118
    dw String_08_00_73 ; id 119
    dw String_08_00_73 ; id 120
    dw String_08_00_73 ; id 121
    dw String_08_00_7A ; id 122
    dw String_08_00_7B ; id 123
    dw String_08_00_7C ; id 124
    dw String_08_00_7D ; id 125
    dw String_08_00_7E ; id 126
    dw String_08_00_7F ; id 127
    dw String_08_00_80 ; id 128
    dw String_08_00_81 ; id 129
    dw String_08_00_82 ; id 130
    dw String_08_00_83 ; id 131
    dw String_08_00_84 ; id 132
    dw String_08_00_85 ; id 133
    dw String_08_00_86 ; id 134
    dw String_08_00_87 ; id 135
    dw String_08_00_88 ; id 136
    dw String_08_00_89 ; id 137
    dw String_08_00_8A ; id 138
    dw String_08_00_8B ; id 139
    dw String_08_00_8C ; id 140
    dw String_08_00_8D ; id 141
    dw String_08_00_8E ; id 142
    dw String_08_00_8F ; id 143
    dw String_08_00_90 ; id 144
    dw String_08_00_91 ; id 145
    dw String_08_00_92 ; id 146
    dw String_08_00_93 ; id 147
    dw String_08_00_94 ; id 148
    dw String_08_00_95 ; id 149
    dw String_08_00_96 ; id 150
    dw String_08_00_97 ; id 151
    dw String_08_00_98 ; id 152
    dw String_08_00_99 ; id 153
    dw String_08_00_9A ; id 154
    dw String_08_00_9B ; id 155
    dw String_08_00_9C ; id 156
    dw String_08_00_9D ; id 157
    dw String_08_00_9E ; id 158
    dw String_08_00_9F ; id 159
    dw String_08_00_A0 ; id 160
    dw String_08_00_A1 ; id 161
    dw String_08_00_A2 ; id 162
    dw String_08_00_A3 ; id 163
    dw String_08_00_A4 ; id 164
    dw String_08_00_A5 ; id 165
    dw String_08_00_A6 ; id 166
    dw String_08_00_A7 ; id 167
    dw String_08_00_A8 ; id 168
    dw String_08_00_A8 ; id 169
    dw String_08_00_AA ; id 170
    dw String_08_00_AB ; id 171
    dw String_08_00_AC ; id 172
    dw String_08_00_AD ; id 173
    dw String_08_00_AE ; id 174
    dw String_08_00_AF ; id 175
    dw String_08_00_AF ; id 176
    dw String_08_00_AF ; id 177
    dw String_08_00_B2 ; id 178
    dw String_08_00_B3 ; id 179
    dw String_08_00_B4 ; id 180
    dw String_08_00_B5 ; id 181
    dw String_08_00_B6 ; id 182
    dw String_08_00_B7 ; id 183
    dw String_08_00_B8 ; id 184
    dw String_08_00_B9 ; id 185
    dw String_08_00_BA ; id 186
    dw String_08_00_BB ; id 187
    dw String_08_00_BC ; id 188
    dw String_08_00_BD ; id 189
    dw String_08_00_BE ; id 190
    dw String_08_00_BF ; id 191
    dw String_08_00_C0 ; id 192
    dw String_08_00_C1 ; id 193
    dw String_08_00_C2 ; id 194
    dw String_08_00_C3 ; id 195
    dw String_08_00_C4 ; id 196
    dw String_08_00_C5 ; id 197
    dw String_08_00_C6 ; id 198
    dw String_08_00_C7 ; id 199
    dw String_08_00_C8 ; id 200
    dw String_08_00_C9 ; id 201
    dw String_08_00_CA ; id 202
    dw String_08_00_CB ; id 203
    dw String_08_00_CC ; id 204
    dw String_08_00_CD ; id 205
    dw String_08_00_CE ; id 206
    dw String_08_00_CF ; id 207
    dw String_08_00_D0 ; id 208
    dw String_08_00_D0 ; id 209
    dw String_08_00_D2 ; id 210
    dw String_08_00_D3 ; id 211
    dw String_08_00_D4 ; id 212
    dw String_08_00_D5 ; id 213
    dw String_08_00_D6 ; id 214
    dw String_08_00_D7 ; id 215
    dw String_08_00_D8 ; id 216
    dw String_08_00_D9 ; id 217
    dw String_08_00_DA ; id 218
    dw String_08_00_DB ; id 219
    dw String_08_00_DC ; id 220
    dw String_08_00_DD ; id 221
    dw String_08_00_DE ; id 222
    dw String_08_00_DF ; id 223
    dw String_08_00_E0 ; id 224
    dw String_08_00_E1 ; id 225
    dw String_08_00_E2 ; id 226
    dw String_08_00_E3 ; id 227
    dw String_08_00_E4 ; id 228
    dw String_08_00_E5 ; id 229
    dw String_08_00_E6 ; id 230
    dw String_08_00_E7 ; id 231
    dw String_08_00_E8 ; id 232
    dw String_08_00_E9 ; id 233
    dw String_08_00_EA ; id 234
    dw String_08_00_EB ; id 235
    dw String_08_00_EC ; id 236
    dw String_08_00_ED ; id 237
    dw String_08_00_ED ; id 238
    dw String_08_00_ED ; id 239
    dw String_08_00_ED ; id 240
    dw String_08_00_ED ; id 241
    dw String_08_00_ED ; id 242
    dw String_08_00_ED ; id 243
    dw String_08_00_ED ; id 244
    dw String_08_00_ED ; id 245
    dw String_08_00_ED ; id 246
    dw String_08_00_ED ; id 247
    dw String_08_00_ED ; id 248
    dw String_08_00_ED ; id 249
    dw String_08_00_ED ; id 250
    dw String_08_00_ED ; id 251
    dw String_08_00_ED ; id 252
    dw String_08_00_ED ; id 253
    dw String_08_00_ED ; id 254

StringList_08_4242::
StringTable_MonsterFamilies::
    dw String_08_01_00 ; id 0
    dw String_08_01_01 ; id 1
    dw String_08_01_02 ; id 2
    dw String_08_01_03 ; id 3
    dw String_08_01_04 ; id 4
    dw String_08_01_05 ; id 5
    dw String_08_01_06 ; id 6
    dw String_08_01_07 ; id 7
    dw String_08_01_08 ; id 8
    dw String_08_01_09 ; id 9
    dw String_08_01_0A ; id 10

StringList_08_4258::
StringTable_MonsterNames::
    dw String_08_02_00 ; id 0
    dw String_08_02_01 ; id 1
    dw String_08_02_02 ; id 2
    dw String_08_02_03 ; id 3
    dw String_08_02_04 ; id 4
    dw String_08_02_05 ; id 5
    dw String_08_02_06 ; id 6
    dw String_08_02_07 ; id 7
    dw String_08_02_08 ; id 8
    dw String_08_02_09 ; id 9
    dw String_08_02_0A ; id 10
    dw String_08_02_0B ; id 11
    dw String_08_02_0C ; id 12
    dw String_08_02_0D ; id 13
    dw String_08_02_0E ; id 14
    dw String_08_02_0F ; id 15
    dw String_08_02_10 ; id 16
    dw String_08_02_11 ; id 17
    dw String_08_02_12 ; id 18
    dw String_08_02_13 ; id 19
    dw String_08_02_14 ; id 20
    dw String_08_02_15 ; id 21
    dw String_08_02_16 ; id 22
    dw String_08_02_17 ; id 23
    dw String_08_02_18 ; id 24
    dw String_08_02_19 ; id 25
    dw String_08_02_1A ; id 26
    dw String_08_02_1B ; id 27
    dw String_08_02_1C ; id 28
    dw String_08_02_1C ; id 29
    dw String_08_02_1C ; id 30
    dw String_08_02_1C ; id 31
    dw String_08_02_1C ; id 32
    dw String_08_02_1C ; id 33
    dw String_08_02_1C ; id 34
    dw String_08_02_1C ; id 35
    dw String_08_02_24 ; id 36
    dw String_08_02_25 ; id 37
    dw String_08_02_26 ; id 38
    dw String_08_02_27 ; id 39
    dw String_08_02_28 ; id 40
    dw String_08_02_29 ; id 41
    dw String_08_02_2A ; id 42
    dw String_08_02_2B ; id 43
    dw String_08_02_2C ; id 44
    dw String_08_02_2D ; id 45
    dw String_08_02_2E ; id 46
    dw String_08_02_2F ; id 47
    dw String_08_02_30 ; id 48
    dw String_08_02_31 ; id 49
    dw String_08_02_32 ; id 50
    dw String_08_02_33 ; id 51
    dw String_08_02_34 ; id 52
    dw String_08_02_35 ; id 53
    dw String_08_02_36 ; id 54
    dw String_08_02_37 ; id 55
    dw String_08_02_38 ; id 56
    dw String_08_02_39 ; id 57
    dw String_08_02_3A ; id 58
    dw String_08_02_3B ; id 59
    dw String_08_02_3C ; id 60
    dw String_08_02_3D ; id 61
    dw String_08_02_3E ; id 62
    dw String_08_02_3F ; id 63
    dw String_08_02_40 ; id 64
    dw String_08_02_41 ; id 65
    dw String_08_02_42 ; id 66
    dw String_08_02_43 ; id 67
    dw String_08_02_43 ; id 68
    dw String_08_02_43 ; id 69
    dw String_08_02_43 ; id 70
    dw String_08_02_47 ; id 71
    dw String_08_02_48 ; id 72
    dw String_08_02_49 ; id 73
    dw String_08_02_4A ; id 74
    dw String_08_02_4B ; id 75
    dw String_08_02_4C ; id 76
    dw String_08_02_4D ; id 77
    dw String_08_02_4E ; id 78
    dw String_08_02_4F ; id 79
    dw String_08_02_50 ; id 80
    dw String_08_02_51 ; id 81
    dw String_08_02_52 ; id 82
    dw String_08_02_53 ; id 83
    dw String_08_02_54 ; id 84
    dw String_08_02_55 ; id 85
    dw String_08_02_56 ; id 86
    dw String_08_02_57 ; id 87
    dw String_08_02_58 ; id 88
    dw String_08_02_59 ; id 89
    dw String_08_02_5A ; id 90
    dw String_08_02_5B ; id 91
    dw String_08_02_5C ; id 92
    dw String_08_02_5D ; id 93
    dw String_08_02_5E ; id 94
    dw String_08_02_5F ; id 95
    dw String_08_02_60 ; id 96
    dw String_08_02_61 ; id 97
    dw String_08_02_62 ; id 98
    dw String_08_02_63 ; id 99
    dw String_08_02_64 ; id 100
    dw String_08_02_65 ; id 101
    dw String_08_02_66 ; id 102
    dw String_08_02_67 ; id 103
    dw String_08_02_67 ; id 104
    dw String_08_02_67 ; id 105
    dw String_08_02_6A ; id 106
    dw String_08_02_6B ; id 107
    dw String_08_02_6C ; id 108
    dw String_08_02_6D ; id 109
    dw String_08_02_6E ; id 110
    dw String_08_02_6F ; id 111
    dw String_08_02_70 ; id 112
    dw String_08_02_71 ; id 113
    dw String_08_02_72 ; id 114
    dw String_08_02_73 ; id 115
    dw String_08_02_74 ; id 116
    dw String_08_02_75 ; id 117
    dw String_08_02_76 ; id 118
    dw String_08_02_77 ; id 119
    dw String_08_02_78 ; id 120
    dw String_08_02_79 ; id 121
    dw String_08_02_7A ; id 122
    dw String_08_02_7B ; id 123
    dw String_08_02_7C ; id 124
    dw String_08_02_7D ; id 125
    dw String_08_02_7E ; id 126
    dw String_08_02_7F ; id 127
    dw String_08_02_80 ; id 128
    dw String_08_02_81 ; id 129
    dw String_08_02_82 ; id 130
    dw String_08_02_83 ; id 131
    dw String_08_02_84 ; id 132
    dw String_08_02_85 ; id 133
    dw String_08_02_85 ; id 134
    dw String_08_02_85 ; id 135
    dw String_08_02_85 ; id 136
    dw String_08_02_85 ; id 137
    dw String_08_02_85 ; id 138
    dw String_08_02_85 ; id 139
    dw String_08_02_85 ; id 140
    dw String_08_02_8D ; id 141
    dw String_08_02_8E ; id 142
    dw String_08_02_8F ; id 143
    dw String_08_02_90 ; id 144
    dw String_08_02_91 ; id 145
    dw String_08_02_92 ; id 146
    dw String_08_02_93 ; id 147
    dw String_08_02_94 ; id 148
    dw String_08_02_95 ; id 149
    dw String_08_02_96 ; id 150
    dw String_08_02_97 ; id 151
    dw String_08_02_98 ; id 152
    dw String_08_02_99 ; id 153
    dw String_08_02_9A ; id 154
    dw String_08_02_9B ; id 155
    dw String_08_02_9C ; id 156
    dw String_08_02_9D ; id 157
    dw String_08_02_9E ; id 158
    dw String_08_02_9F ; id 159
    dw String_08_02_A0 ; id 160
    dw String_08_02_A1 ; id 161
    dw String_08_02_A2 ; id 162
    dw String_08_02_A3 ; id 163
    dw String_08_02_A4 ; id 164
    dw String_08_02_A5 ; id 165
    dw String_08_02_A6 ; id 166
    dw String_08_02_A7 ; id 167
    dw String_08_02_A8 ; id 168
    dw String_08_02_A8 ; id 169
    dw String_08_02_A8 ; id 170
    dw String_08_02_A8 ; id 171
    dw String_08_02_A8 ; id 172
    dw String_08_02_A8 ; id 173
    dw String_08_02_A8 ; id 174
    dw String_08_02_A8 ; id 175
    dw String_08_02_B0 ; id 176
    dw String_08_02_B1 ; id 177
    dw String_08_02_B2 ; id 178
    dw String_08_02_B3 ; id 179
    dw String_08_02_B4 ; id 180
    dw String_08_02_B5 ; id 181
    dw String_08_02_B6 ; id 182
    dw String_08_02_B7 ; id 183
    dw String_08_02_B8 ; id 184
    dw String_08_02_B9 ; id 185
    dw String_08_02_BA ; id 186
    dw String_08_02_BB ; id 187
    dw String_08_02_BC ; id 188
    dw String_08_02_BD ; id 189
    dw String_08_02_BE ; id 190
    dw String_08_02_BF ; id 191
    dw String_08_02_C0 ; id 192
    dw String_08_02_C1 ; id 193
    dw String_08_02_C2 ; id 194
    dw String_08_02_C3 ; id 195
    dw String_08_02_C4 ; id 196
    dw String_08_02_C5 ; id 197
    dw String_08_02_C6 ; id 198
    dw String_08_02_C7 ; id 199
    dw String_08_02_C8 ; id 200
    dw String_08_02_C9 ; id 201
    dw String_08_02_CA ; id 202
    dw String_08_02_CA ; id 203
    dw String_08_02_CA ; id 204
    dw String_08_02_CA ; id 205
    dw String_08_02_CA ; id 206
    dw String_08_02_CA ; id 207
    dw String_08_02_CA ; id 208
    dw String_08_02_CA ; id 209
    dw String_08_02_CA ; id 210
    dw String_08_02_D3 ; id 211
    dw String_08_02_D4 ; id 212
    dw String_08_02_D5 ; id 213
    dw String_08_02_D6 ; id 214
    dw String_08_02_D7 ; id 215
    dw String_08_02_D8 ; id 216
    dw String_08_02_D9 ; id 217
    dw String_08_02_DA ; id 218
    dw String_08_02_DB ; id 219
    dw String_08_02_DC ; id 220
    dw String_08_02_DD ; id 221
    dw String_08_02_DE ; id 222
    dw String_08_02_DF ; id 223
    dw String_08_02_E0 ; id 224
    dw String_08_02_E1 ; id 225
    dw String_08_02_E2 ; id 226
    dw String_08_02_E3 ; id 227
    dw String_08_02_E4 ; id 228
    dw String_08_02_E5 ; id 229
    dw String_08_02_E6 ; id 230
    dw String_08_02_E7 ; id 231
    dw String_08_02_E8 ; id 232
    dw String_08_02_E9 ; id 233
    dw String_08_02_EA ; id 234
    dw String_08_02_EB ; id 235
    dw String_08_02_EC ; id 236
    dw String_08_02_ED ; id 237
    dw String_08_02_EE ; id 238
    dw String_08_02_EF ; id 239
    dw String_08_02_F0 ; id 240
    dw String_08_02_F1 ; id 241
    dw String_08_02_F1 ; id 242
    dw String_08_02_F1 ; id 243
    dw String_08_02_F1 ; id 244
    dw String_08_02_F1 ; id 245
    dw String_08_02_F6 ; id 246
    dw String_08_02_F7 ; id 247
    dw String_08_02_F8 ; id 248
    dw String_08_02_F9 ; id 249
    dw String_08_02_FA ; id 250
    dw String_08_02_FB ; id 251
    dw String_08_02_FC ; id 252
    dw String_08_02_FD ; id 253
    dw String_08_02_FE ; id 254
    dw String_08_02_FF ; id 255

StringList_08_4458::
StringTable_MonsterNames2::
    dw String_08_03_00 ; id 0
    dw String_08_03_01 ; id 1
    dw String_08_03_02 ; id 2
    dw String_08_03_03 ; id 3
    dw String_08_03_04 ; id 4
    dw String_08_03_05 ; id 5
    dw String_08_03_06 ; id 6
    dw String_08_03_07 ; id 7
    dw String_08_03_08 ; id 8
    dw String_08_03_09 ; id 9
    dw String_08_03_0A ; id 10
    dw String_08_03_0B ; id 11
    dw String_08_03_0C ; id 12
    dw String_08_03_0D ; id 13
    dw String_08_03_0E ; id 14
    dw String_08_03_0F ; id 15
    dw String_08_03_10 ; id 16
    dw String_08_03_11 ; id 17
    dw String_08_03_11 ; id 18
    dw String_08_03_11 ; id 19
    dw String_08_03_11 ; id 20
    dw String_08_03_11 ; id 21
    dw String_08_03_11 ; id 22
    dw String_08_03_11 ; id 23
    dw String_08_03_11 ; id 24
    dw String_08_03_19 ; id 25
    dw String_08_03_1A ; id 26
    dw String_08_03_1B ; id 27
    dw String_08_03_1C ; id 28
    dw String_08_03_1D ; id 29
    dw String_08_03_1E ; id 30
    dw String_08_03_1F ; id 31
    dw String_08_03_20 ; id 32
    dw String_08_03_21 ; id 33
    dw String_08_03_22 ; id 34
    dw String_08_03_23 ; id 35
    dw String_08_03_24 ; id 36
    dw String_08_03_25 ; id 37
    dw String_08_03_26 ; id 38
    dw String_08_03_27 ; id 39
    dw String_08_03_28 ; id 40
    dw String_08_03_29 ; id 41
    dw String_08_03_2A ; id 42
    dw String_08_03_2B ; id 43
    dw String_08_03_2C ; id 44
    dw String_08_03_2D ; id 45
    dw String_08_03_2E ; id 46
    dw String_08_03_2F ; id 47
    dw String_08_03_30 ; id 48
    dw String_08_03_31 ; id 49
    dw String_08_03_32 ; id 50
    dw String_08_03_33 ; id 51
    dw String_08_03_34 ; id 52
    dw String_08_03_35 ; id 53
    dw String_08_03_36 ; id 54
    dw String_08_03_37 ; id 55
    dw String_08_03_38 ; id 56
    dw String_08_03_39 ; id 57
    dw String_08_03_39 ; id 58
    dw String_08_03_39 ; id 59
    dw String_08_03_3C ; id 60
    dw String_08_03_3D ; id 61
    dw String_08_03_3E ; id 62
    dw String_08_03_3F ; id 63
    dw String_08_03_40 ; id 64
    dw String_08_03_41 ; id 65
    dw String_08_03_42 ; id 66
    dw String_08_03_43 ; id 67
    dw String_08_03_44 ; id 68
    dw String_08_03_45 ; id 69
    dw String_08_03_46 ; id 70
    dw String_08_03_47 ; id 71
    dw String_08_03_48 ; id 72
    dw String_08_03_49 ; id 73
    dw String_08_03_4A ; id 74
    dw String_08_03_4B ; id 75
    dw String_08_03_4C ; id 76
    dw String_08_03_4D ; id 77
    dw String_08_03_4E ; id 78
    dw String_08_03_4F ; id 79
    dw String_08_03_50 ; id 80
    dw String_08_03_51 ; id 81
    dw String_08_03_52 ; id 82
    dw String_08_03_53 ; id 83
    dw String_08_03_54 ; id 84
    dw String_08_03_55 ; id 85
    dw String_08_03_56 ; id 86
    dw String_08_03_57 ; id 87
    dw String_08_03_58 ; id 88
    dw String_08_03_59 ; id 89
    dw String_08_03_5A ; id 90
    dw String_08_03_5B ; id 91
    dw String_08_03_5C ; id 92
    dw String_08_03_5C ; id 93
    dw String_08_03_5C ; id 94
    dw String_08_03_5F ; id 95
    dw String_08_03_60 ; id 96
    dw String_08_03_61 ; id 97
    dw String_08_03_62 ; id 98
    dw String_08_03_63 ; id 99
    dw String_08_03_64 ; id 100
    dw String_08_03_65 ; id 101
    dw String_08_03_66 ; id 102
    dw String_08_03_67 ; id 103
    dw String_08_03_68 ; id 104
    dw String_08_03_69 ; id 105
    dw String_08_03_6A ; id 106
    dw String_08_03_6B ; id 107
    dw String_08_03_6C ; id 108
    dw String_08_03_6D ; id 109
    dw String_08_03_6E ; id 110
    dw String_08_03_6F ; id 111
    dw String_08_03_70 ; id 112
    dw String_08_03_71 ; id 113
    dw String_08_03_72 ; id 114
    dw String_08_03_73 ; id 115
    dw String_08_03_74 ; id 116
    dw String_08_03_75 ; id 117
    dw String_08_03_76 ; id 118
    dw String_08_03_77 ; id 119
    dw String_08_03_78 ; id 120
    dw String_08_03_79 ; id 121
    dw String_08_03_79 ; id 122
    dw String_08_03_79 ; id 123
    dw String_08_03_7C ; id 124
    dw String_08_03_7D ; id 125
    dw String_08_03_7E ; id 126
    dw String_08_03_7F ; id 127

StringList_08_4558::
StringTable_SkillNames::
    dw String_08_04_00 ; id 0
    dw String_08_04_01 ; id 1
    dw String_08_04_02 ; id 2
    dw String_08_04_03 ; id 3
    dw String_08_04_04 ; id 4
    dw String_08_04_05 ; id 5
    dw String_08_04_06 ; id 6
    dw String_08_04_07 ; id 7
    dw String_08_04_08 ; id 8
    dw String_08_04_09 ; id 9
    dw String_08_04_0A ; id 10
    dw String_08_04_0B ; id 11
    dw String_08_04_0C ; id 12
    dw String_08_04_0D ; id 13
    dw String_08_04_0E ; id 14
    dw String_08_04_0F ; id 15
    dw String_08_04_10 ; id 16
    dw String_08_04_11 ; id 17
    dw String_08_04_12 ; id 18
    dw String_08_04_13 ; id 19
    dw String_08_04_14 ; id 20
    dw String_08_04_15 ; id 21
    dw String_08_04_16 ; id 22
    dw String_08_04_17 ; id 23
    dw String_08_04_18 ; id 24
    dw String_08_04_19 ; id 25
    dw String_08_04_1A ; id 26
    dw String_08_04_1B ; id 27
    dw String_08_04_1C ; id 28
    dw String_08_04_1D ; id 29
    dw String_08_04_1E ; id 30
    dw String_08_04_1F ; id 31
    dw String_08_04_20 ; id 32
    dw String_08_04_21 ; id 33
    dw String_08_04_22 ; id 34
    dw String_08_04_23 ; id 35
    dw String_08_04_24 ; id 36
    dw String_08_04_25 ; id 37
    dw String_08_04_26 ; id 38
    dw String_08_04_27 ; id 39
    dw String_08_04_28 ; id 40
    dw String_08_04_29 ; id 41
    dw String_08_04_2A ; id 42
    dw String_08_04_2B ; id 43
    dw String_08_04_2C ; id 44
    dw String_08_04_2D ; id 45
    dw String_08_04_2E ; id 46
    dw String_08_04_2F ; id 47
    dw String_08_04_30 ; id 48
    dw String_08_04_31 ; id 49
    dw String_08_04_32 ; id 50
    dw String_08_04_33 ; id 51
    dw String_08_04_34 ; id 52
    dw String_08_04_35 ; id 53
    dw String_08_04_36 ; id 54
    dw String_08_04_37 ; id 55
    dw String_08_04_38 ; id 56
    dw String_08_04_39 ; id 57
    dw String_08_04_3A ; id 58
    dw String_08_04_3B ; id 59
    dw String_08_04_3C ; id 60
    dw String_08_04_3D ; id 61
    dw String_08_04_3E ; id 62
    dw String_08_04_3F ; id 63
    dw String_08_04_40 ; id 64
    dw String_08_04_41 ; id 65
    dw String_08_04_42 ; id 66
    dw String_08_04_43 ; id 67
    dw String_08_04_44 ; id 68
    dw String_08_04_45 ; id 69
    dw String_08_04_46 ; id 70
    dw String_08_04_47 ; id 71
    dw String_08_04_48 ; id 72
    dw String_08_04_49 ; id 73
    dw String_08_04_4A ; id 74
    dw String_08_04_4B ; id 75
    dw String_08_04_4C ; id 76
    dw String_08_04_4D ; id 77
    dw String_08_04_4E ; id 78
    dw String_08_04_4F ; id 79
    dw String_08_04_50 ; id 80
    dw String_08_04_51 ; id 81
    dw String_08_04_52 ; id 82
    dw String_08_04_53 ; id 83
    dw String_08_04_54 ; id 84
    dw String_08_04_55 ; id 85
    dw String_08_04_56 ; id 86
    dw String_08_04_57 ; id 87
    dw String_08_04_58 ; id 88
    dw String_08_04_59 ; id 89
    dw String_08_04_5A ; id 90
    dw String_08_04_5B ; id 91
    dw String_08_04_5C ; id 92
    dw String_08_04_5D ; id 93
    dw String_08_04_5E ; id 94
    dw String_08_04_5F ; id 95
    dw String_08_04_60 ; id 96
    dw String_08_04_61 ; id 97
    dw String_08_04_62 ; id 98
    dw String_08_04_63 ; id 99
    dw String_08_04_64 ; id 100
    dw String_08_04_65 ; id 101
    dw String_08_04_66 ; id 102
    dw String_08_04_67 ; id 103
    dw String_08_04_68 ; id 104
    dw String_08_04_69 ; id 105
    dw String_08_04_6A ; id 106
    dw String_08_04_6B ; id 107
    dw String_08_04_6C ; id 108
    dw String_08_04_6D ; id 109
    dw String_08_04_6E ; id 110
    dw String_08_04_6F ; id 111
    dw String_08_04_70 ; id 112
    dw String_08_04_71 ; id 113
    dw String_08_04_72 ; id 114
    dw String_08_04_73 ; id 115
    dw String_08_04_74 ; id 116
    dw String_08_04_75 ; id 117
    dw String_08_04_76 ; id 118
    dw String_08_04_77 ; id 119
    dw String_08_04_78 ; id 120
    dw String_08_04_79 ; id 121
    dw String_08_04_7A ; id 122
    dw String_08_04_7B ; id 123
    dw String_08_04_7C ; id 124
    dw String_08_04_7D ; id 125
    dw String_08_04_7E ; id 126
    dw String_08_04_7F ; id 127
    dw String_08_04_80 ; id 128
    dw String_08_04_81 ; id 129
    dw String_08_04_82 ; id 130
    dw String_08_04_83 ; id 131
    dw String_08_04_84 ; id 132
    dw String_08_04_85 ; id 133
    dw String_08_04_86 ; id 134
    dw String_08_04_87 ; id 135
    dw String_08_04_88 ; id 136
    dw String_08_04_89 ; id 137
    dw String_08_04_8A ; id 138
    dw String_08_04_8B ; id 139
    dw String_08_04_8C ; id 140
    dw String_08_04_8D ; id 141
    dw String_08_04_8E ; id 142
    dw String_08_04_8F ; id 143
    dw String_08_04_90 ; id 144
    dw String_08_04_91 ; id 145
    dw String_08_04_92 ; id 146
    dw String_08_04_93 ; id 147
    dw String_08_04_94 ; id 148
    dw String_08_04_95 ; id 149
    dw String_08_04_96 ; id 150
    dw String_08_04_97 ; id 151
    dw String_08_04_98 ; id 152
    dw String_08_04_99 ; id 153
    dw String_08_04_9A ; id 154
    dw String_08_04_9B ; id 155
    dw String_08_04_9C ; id 156
    dw String_08_04_9D ; id 157
    dw String_08_04_9E ; id 158
    dw String_08_04_9F ; id 159
    dw String_08_04_A0 ; id 160
    dw String_08_04_A1 ; id 161
    dw String_08_04_A2 ; id 162
    dw String_08_04_A3 ; id 163
    dw String_08_04_A4 ; id 164
    dw String_08_04_A5 ; id 165
    dw String_08_04_A6 ; id 166
    dw String_08_04_A7 ; id 167
    dw String_08_04_A8 ; id 168
    dw String_08_04_A9 ; id 169
    dw String_08_04_AA ; id 170
    dw String_08_04_AB ; id 171
    dw String_08_04_AC ; id 172
    dw String_08_04_AD ; id 173
    dw String_08_04_AE ; id 174
    dw String_08_04_AF ; id 175
    dw String_08_04_AF ; id 176
    dw String_08_04_AF ; id 177
    dw String_08_04_AF ; id 178
    dw String_08_04_AF ; id 179
    dw String_08_04_AF ; id 180
    dw String_08_04_AF ; id 181
    dw String_08_04_AF ; id 182
    dw String_08_04_AF ; id 183
    dw String_08_04_AF ; id 184
    dw String_08_04_AF ; id 185
    dw String_08_04_AF ; id 186
    dw String_08_04_AF ; id 187
    dw String_08_04_AF ; id 188
    dw String_08_04_AF ; id 189
    dw String_08_04_AF ; id 190
    dw String_08_04_AF ; id 191
    dw String_08_04_AF ; id 192
    dw String_08_04_AF ; id 193
    dw String_08_04_AF ; id 194
    dw String_08_04_AF ; id 195
    dw String_08_04_AF ; id 196
    dw String_08_04_AF ; id 197
    dw String_08_04_AF ; id 198
    dw String_08_04_AF ; id 199
    dw String_08_04_AF ; id 200
    dw String_08_04_AF ; id 201
    dw String_08_04_AF ; id 202
    dw String_08_04_AF ; id 203
    dw String_08_04_AF ; id 204
    dw String_08_04_CD ; id 205
    dw String_08_04_CD ; id 206
    dw String_08_04_CD ; id 207
    dw String_08_04_D0 ; id 208
    dw String_08_04_D0 ; id 209
    dw String_08_04_D0 ; id 210
    dw String_08_04_D0 ; id 211
    dw String_08_04_D0 ; id 212
    dw String_08_04_D0 ; id 213
    dw String_08_04_D0 ; id 214
    dw String_08_04_D0 ; id 215
    dw String_08_04_D0 ; id 216
    dw String_08_04_D0 ; id 217
    dw String_08_04_D0 ; id 218
    dw String_08_04_D0 ; id 219
    dw String_08_04_D0 ; id 220
    dw String_08_04_D0 ; id 221
    dw String_08_04_D0 ; id 222

StringList_08_4716::
StringTable_ItemNames::
    dw String_08_05_00 ; id 0
    dw String_08_05_01 ; id 1
    dw String_08_05_02 ; id 2
    dw String_08_05_03 ; id 3
    dw String_08_05_04 ; id 4
    dw String_08_05_05 ; id 5
    dw String_08_05_06 ; id 6
    dw String_08_05_07 ; id 7
    dw String_08_05_08 ; id 8
    dw String_08_05_09 ; id 9
    dw String_08_05_0A ; id 10
    dw String_08_05_0B ; id 11
    dw String_08_05_0C ; id 12
    dw String_08_05_0D ; id 13
    dw String_08_05_0E ; id 14
    dw String_08_05_0F ; id 15
    dw String_08_05_10 ; id 16
    dw String_08_05_11 ; id 17
    dw String_08_05_12 ; id 18
    dw String_08_05_13 ; id 19
    dw String_08_05_14 ; id 20
    dw String_08_05_15 ; id 21
    dw String_08_05_16 ; id 22
    dw String_08_05_17 ; id 23
    dw String_08_05_18 ; id 24
    dw String_08_05_19 ; id 25
    dw String_08_05_1A ; id 26
    dw String_08_05_1B ; id 27
    dw String_08_05_1C ; id 28
    dw String_08_05_1D ; id 29
    dw String_08_05_1E ; id 30
    dw String_08_05_1F ; id 31
    dw String_08_05_20 ; id 32
    dw String_08_05_21 ; id 33
    dw String_08_05_22 ; id 34
    dw String_08_05_23 ; id 35
    dw String_08_05_24 ; id 36
    dw String_08_05_25 ; id 37
    dw String_08_05_26 ; id 38
    dw String_08_05_27 ; id 39
    dw String_08_05_28 ; id 40
    dw String_08_05_29 ; id 41
    dw String_08_05_2A ; id 42
    dw String_08_05_2B ; id 43
    dw String_08_05_2C ; id 44
    dw String_08_05_2D ; id 45
    dw String_08_05_2E ; id 46
    dw String_08_05_2F ; id 47
    dw String_08_05_30 ; id 48
    dw String_08_05_31 ; id 49
    dw String_08_05_32 ; id 50
    dw String_08_05_33 ; id 51
    dw String_08_05_34 ; id 52
    dw String_08_05_35 ; id 53
    dw String_08_05_36 ; id 54
    dw String_08_05_37 ; id 55
    dw String_08_05_38 ; id 56
    dw String_08_05_39 ; id 57
    dw String_08_05_3A ; id 58
    dw String_08_05_3B ; id 59
    dw String_08_05_3C ; id 60
    dw String_08_05_3D ; id 61
    dw String_08_05_3E ; id 62
    dw String_08_05_3E ; id 63
    dw String_08_05_40 ; id 64
    dw String_08_05_41 ; id 65
    dw String_08_05_42 ; id 66
    dw String_08_05_43 ; id 67
    dw String_08_05_44 ; id 68
    dw String_08_05_45 ; id 69
    dw String_08_05_46 ; id 70
    dw String_08_05_47 ; id 71
    dw String_08_05_48 ; id 72
    dw String_08_05_49 ; id 73
    dw String_08_05_4A ; id 74
    dw String_08_05_4B ; id 75
    dw String_08_05_4C ; id 76
    dw String_08_05_4D ; id 77
    dw String_08_05_4E ; id 78
    dw String_08_05_4F ; id 79
    dw String_08_05_50 ; id 80
    dw String_08_05_51 ; id 81
    dw String_08_05_52 ; id 82
    dw String_08_05_53 ; id 83
    dw String_08_05_54 ; id 84
    dw String_08_05_54 ; id 85
    dw String_08_05_54 ; id 86
    dw String_08_05_54 ; id 87
    dw String_08_05_54 ; id 88
    dw String_08_05_54 ; id 89
    dw String_08_05_5A ; id 90
    dw String_08_05_5B ; id 91
    dw String_08_05_5C ; id 92
    dw String_08_05_5D ; id 93
    dw String_08_05_5E ; id 94
    dw String_08_05_5F ; id 95
    dw String_08_05_60 ; id 96
    dw String_08_05_61 ; id 97
    dw String_08_05_62 ; id 98
    dw String_08_05_62 ; id 99
    dw String_08_05_62 ; id 100
    dw String_08_05_62 ; id 101
    dw String_08_05_62 ; id 102
    dw String_08_05_62 ; id 103
    dw String_08_05_62 ; id 104
    dw String_08_05_62 ; id 105
    dw String_08_05_62 ; id 106
    dw String_08_05_62 ; id 107
    dw String_08_05_62 ; id 108
    dw String_08_05_62 ; id 109
    dw String_08_05_62 ; id 110
    dw String_08_05_62 ; id 111

StringList_08_47F6::
StringTable_ItemDescriptions::
    dw String_08_06_00 ; id 0
    dw String_08_06_00 ; id 1
    dw String_08_06_02 ; id 2
    dw String_08_06_03 ; id 3
    dw String_08_06_04 ; id 4
    dw String_08_06_05 ; id 5
    dw String_08_06_06 ; id 6
    dw String_08_06_07 ; id 7
    dw String_08_06_08 ; id 8
    dw String_08_06_09 ; id 9
    dw String_08_06_0A ; id 10
    dw String_08_06_0B ; id 11
    dw String_08_06_0C ; id 12
    dw String_08_06_0D ; id 13
    dw String_08_06_0E ; id 14
    dw String_08_06_0F ; id 15
    dw String_08_06_10 ; id 16
    dw String_08_06_11 ; id 17
    dw String_08_06_12 ; id 18
    dw String_08_06_13 ; id 19
    dw String_08_06_14 ; id 20
    dw String_08_06_15 ; id 21
    dw String_08_06_16 ; id 22
    dw String_08_06_17 ; id 23
    dw String_08_06_18 ; id 24
    dw String_08_06_19 ; id 25
    dw String_08_06_1A ; id 26
    dw String_08_06_1B ; id 27
    dw String_08_06_1C ; id 28
    dw String_08_06_1D ; id 29
    dw String_08_06_1E ; id 30
    dw String_08_06_1F ; id 31
    dw String_08_06_20 ; id 32
    dw String_08_06_21 ; id 33
    dw String_08_06_22 ; id 34
    dw String_08_06_23 ; id 35
    dw String_08_06_24 ; id 36
    dw String_08_06_25 ; id 37
    dw String_08_06_26 ; id 38
    dw String_08_06_27 ; id 39
    dw String_08_06_28 ; id 40
    dw String_08_06_29 ; id 41
    dw String_08_06_2A ; id 42
    dw String_08_06_2B ; id 43
    dw String_08_06_2C ; id 44
    dw String_08_06_2D ; id 45
    dw String_08_06_2E ; id 46
    dw String_08_06_2F ; id 47
    dw String_08_06_2F ; id 48
    dw String_08_06_31 ; id 49
    dw String_08_06_32 ; id 50
    dw String_08_06_33 ; id 51
    dw String_08_06_34 ; id 52
    dw String_08_06_35 ; id 53
    dw String_08_06_36 ; id 54
    dw String_08_06_37 ; id 55
    dw String_08_06_38 ; id 56
    dw String_08_06_39 ; id 57
    dw String_08_06_3A ; id 58
    dw String_08_06_3B ; id 59
    dw String_08_06_3C ; id 60
    dw String_08_06_3D ; id 61
    dw String_08_06_3E ; id 62
    dw String_08_06_3E ; id 63
    dw String_08_06_40 ; id 64
    dw String_08_06_41 ; id 65
    dw String_08_06_42 ; id 66
    dw String_08_06_43 ; id 67
    dw String_08_06_44 ; id 68
    dw String_08_06_45 ; id 69
    dw String_08_06_46 ; id 70
    dw String_08_06_47 ; id 71
    dw String_08_06_48 ; id 72
    dw String_08_06_49 ; id 73
    dw String_08_06_4A ; id 74
    dw String_08_06_4B ; id 75
    dw String_08_06_4C ; id 76
    dw String_08_06_4D ; id 77
    dw String_08_06_4E ; id 78
    dw String_08_06_4F ; id 79
    dw String_08_06_50 ; id 80
    dw String_08_06_51 ; id 81
    dw String_08_06_52 ; id 82
    dw String_08_06_53 ; id 83
    dw String_08_06_54 ; id 84
    dw String_08_06_54 ; id 85
    dw String_08_06_54 ; id 86
    dw String_08_06_54 ; id 87
    dw String_08_06_54 ; id 88
    dw String_08_06_54 ; id 89
    dw String_08_06_5A ; id 90
    dw String_08_06_5B ; id 91
    dw String_08_06_5C ; id 92
    dw String_08_06_5D ; id 93
    dw String_08_06_5E ; id 94
    dw String_08_06_5F ; id 95
    dw String_08_06_60 ; id 96
    dw String_08_06_61 ; id 97
    dw String_08_06_62 ; id 98
    dw String_08_06_63 ; id 99
    dw String_08_06_63 ; id 100
    dw String_08_06_63 ; id 101
    dw String_08_06_63 ; id 102
    dw String_08_06_63 ; id 103
    dw String_08_06_63 ; id 104
    dw String_08_06_63 ; id 105
    dw String_08_06_63 ; id 106
    dw String_08_06_63 ; id 107
    dw String_08_06_63 ; id 108
    dw String_08_06_63 ; id 109
    dw String_08_06_63 ; id 110
    dw String_08_06_6F ; id 111

StringList_08_48D6::
StringTable_PersonalityNames::
    dw String_08_07_00 ; id 0
    dw String_08_07_01 ; id 1
    dw String_08_07_02 ; id 2
    dw String_08_07_03 ; id 3
    dw String_08_07_04 ; id 4
    dw String_08_07_05 ; id 5
    dw String_08_07_06 ; id 6
    dw String_08_07_07 ; id 7
    dw String_08_07_08 ; id 8
    dw String_08_07_09 ; id 9
    dw String_08_07_0A ; id 10
    dw String_08_07_0B ; id 11
    dw String_08_07_0C ; id 12
    dw String_08_07_0D ; id 13
    dw String_08_07_0E ; id 14
    dw String_08_07_0F ; id 15
    dw String_08_07_10 ; id 16
    dw String_08_07_11 ; id 17
    dw String_08_07_12 ; id 18
    dw String_08_07_13 ; id 19
    dw String_08_07_14 ; id 20
    dw String_08_07_15 ; id 21
    dw String_08_07_16 ; id 22
    dw String_08_07_17 ; id 23
    dw String_08_07_18 ; id 24
    dw String_08_07_19 ; id 25
    dw String_08_07_1A ; id 26

StringList_08_490C::
StringTable_ItemMenuMessages::
    dw String_08_08_00 ; id 0
    dw String_08_08_01 ; id 1
    dw String_08_08_02 ; id 2
    dw String_08_08_03 ; id 3
    dw String_08_08_04 ; id 4
    dw String_08_08_05 ; id 5
    dw String_08_08_06 ; id 6
    dw String_08_08_07 ; id 7
    dw String_08_08_08 ; id 8
    dw String_08_08_09 ; id 9
    dw String_08_08_0A ; id 10
    dw String_08_08_0B ; id 11
    dw String_08_08_0C ; id 12
    dw String_08_08_0D ; id 13
    dw String_08_08_0E ; id 14

String_08_00_00::
    db "0123456789ABCDEF", $f0

String_08_00_01::
    db "  DEBUG MODE        SELECT       1:GOTO PROGRAM  2:EDIT     "
    db "     3:AUTOMAP CHECK 4:GRAFHICS      5:SOUNDS        6:BATTL"
    db "E        7:HAIGOU        8:STAFF ROLL    9:TOKUGI CHECK  A:E"
    db "NEMY TBL CHK B:MESSAGE CHK  ?  RETURN  ?  ", $f0

String_08_00_02::
    db "  ? EDIT ?                      WORLD:          MAP X:      "
    db "        Y:          POS X:              Y:          NOT DATA"
    db $9f, $f0

String_08_00_03::
    db "MONSTER BGSD CHARA     ", $f0

String_08_00_04::
    db "  ? AUTOMAP ?                   KEY  :          KEYID:      "
    db "    LEVEL:          POS X:          POS Y:          NOT DATA"
    db $9f, $f0

String_08_00_05::
    db "  ? SOUND ?", $f1
    db $f1
    db "  BGM", $f1
    db "   SE", $f0

String_08_00_07::
    db "? GOTOPRG ?", $f1
    db $f1
    db $f1
    db " PRGNO1", $f1
    db " PRGNO2", $f1
    db " PRGNO3", $f0

String_08_00_08::
    db "No more", $a4, $f0

String_08_00_09::
    db "? BATTLE ?", $f1
    db "No. foes", $f1
    db "Monster 1", $f1
    db "Monster 2", $f1
    db "Monster 3", $f1
    db "Debug", $f1
    db "Skill ID", $f1
    db "Species", $f1
    db "Level", $f0

String_08_00_0A::
    db "MonsterFarm", $f0

String_08_00_0B::
    db "GreatLog", $f0

String_08_00_0C::
    db "Main Street", $f0

String_08_00_0D::
    db "Magic Door", $f0

String_08_00_0E::
    db "Reception", $f0

String_08_00_0F::
    db "Log's Navel", $f0

String_08_00_10::
    db "Home", $f0

String_08_00_11::
    db "Stable", $f0

String_08_00_12::
    db "Vault", $f0

String_08_00_13::
    db "Key Shop", $f0

String_08_00_14::
    db "Evaluator", $f0

String_08_00_15::
    db "Residences", $f0

String_08_00_17::
    db "Starry ", $59, $f0

String_08_00_18::
    db "Family Rm.", $f0

String_08_00_19::
    db "Guy's Rm.", $f0

String_08_00_1A::
    db "Lady's Rm.", $f0

String_08_00_1B::
    db "Library", $f0

String_08_00_1C::
    db "Girl's Rm.", $f0

String_08_00_1D::
    db "Christener", $f0

String_08_00_1E::
    db "Background", $f0

String_08_00_1F::
    db "Old man's", $f0

String_08_00_20::
    db "Medal man", $f0

String_08_00_21::
    db "Tavern", $f0

String_08_00_22::
    db "Arena", $f0

String_08_00_23::
    db "GreatLog ", $58, $f0

String_08_00_24::
    db "Treetop", $f0

String_08_00_25::
    db "Log's nut", $f0

String_08_00_26::
    db "Log's view", $f0

String_08_00_27::
    db "Deck", $f0

String_08_00_28::
    db $17, $18, $f0

String_08_00_2A::
    db "Desert ", $5c, $f0

String_08_00_2B::
    db "Kalka ", $57, $f0

String_08_00_2C::
    db "Kalka inn", $f0

String_08_00_2D::
    db "Asiya inn", $f0

String_08_00_2E::
    db "Asiya ", $57, $f0

String_08_00_2F::
    db "Asiya ", $58, $f0

String_08_00_30::
    db "Desert King", $f0

String_08_00_31::
    db $17, $18, $f0

String_08_00_32::
    db "Hideout", $f0

String_08_00_33::
    db "Magic Door ", $59, $f0

String_08_00_34::
    db "CanalGate", $f0

String_08_00_35::
    db "Canal", $f0

String_08_00_36::
    db "Not yet!", $f0

String_08_00_37::
    db "Dungeon", $f1

String_08_00_38::
    db "Treasury", $f1

String_08_00_39::
    db "Mirage Lake", $f1

String_08_00_3A::
    db "Water ", $5c, $f0

String_08_00_3B::
    db "Yold ", $57, $f0

String_08_00_3C::
    db "Pt.Ritz ", $57, $f0

String_08_00_3D::
    db "Pt.Ritz pub", $f0

String_08_00_3E::
    db "Pt.Ritz inn", $f0

String_08_00_3F::
    db "Cape ", $5a, $f0

String_08_00_40::
    db "Ship ramp", $f0

String_08_00_41::
    db "Ship 1F", $f0

String_08_00_42::
    db "Volcano", $5a, "1F", $f0

String_08_00_43::
    db "Volcano", $5a, "B1F", $f0

String_08_00_44::
    db "Volcano", $5a, "B2F", $f0

String_08_00_45::
    db "Loot vault", $f0

String_08_00_46::
    db "Polona ", $57, $f0

String_08_00_47::
    db "Polona inn", $f0

String_08_00_48::
    db "Lighthouse", $f0

String_08_00_49::
    db "Lighthouse", $f0

String_08_00_4A::
    db "Pinnacle", $f0

String_08_00_4B::
    db "Mermaid ", $5c, $f0

String_08_00_4C::
    db "Ship 2F", $f0

String_08_00_4D::
    db "Ship deck", $f0

String_08_00_4E::
    db "Capt's qtr.", $f0

String_08_00_4F::
    db "Magic Door ", $59, $f0

String_08_00_50::
    db $17, $18, $f0

String_08_00_52::
    db "Ice ", $5c, $f0

String_08_00_53::
    db "Spring", $f0

String_08_00_54::
    db "Norden ", $57, $f0

String_08_00_55::
    db "Norden inn", $f0

String_08_00_56::
    db "Norden ", $58, $f0

String_08_00_57::
    db "Norden jail", $f0

String_08_00_58::
    db "N tunnel", $f0

String_08_00_59::
    db "Nofor ", $57, $f0

String_08_00_5A::
    db "Nofor pub", $f0

String_08_00_5B::
    db "Nofor inn", $f0

String_08_00_5C::
    db "Border mine", $f0

String_08_00_5D::
    db "Mine", $f0

String_08_00_5E::
    db "Mine rm.", $f0

String_08_00_5F::
    db "Mine rm.", $f0

String_08_00_60::
    db "Mine rm.", $f0

String_08_00_61::
    db "Gold mine", $f0

String_08_00_62::
    db "Weston ", $57, $f0

String_08_00_63::
    db "Weston inn", $f0

String_08_00_64::
    db "Westania ", $58, $f0

String_08_00_65::
    db "Westania ", $58, $f0

String_08_00_66::
    db "Yuna's rm.", $f0

String_08_00_67::
    db "S forest", $f0

String_08_00_68::
    db "Estria  ", $58, $f0

String_08_00_69::
    db "Estria inn", $f0

String_08_00_6A::
    db "Estria ", $58, $f0

String_08_00_6B::
    db "Queen's rm.", $f0

String_08_00_6C::
    db "N mountain", $f0

String_08_00_6D::
    db "Lake ", $5d, " 1F", $f0

String_08_00_6E::
    db "Lake ", $5d, " 2F", $f0

String_08_00_6F::
    db "Lake ", $5d, " 3F", $f0

String_08_00_70::
    db "Lake ", $5d, " 4F", $f0

String_08_00_71::
    db "Lake ", $5d, " 5F", $f0

String_08_00_72::
    db "Magic Door ", $59, $f0

String_08_00_73::
    db $17, $18, $f0

String_08_00_7A::
    db "Float ", $5c, $f0

String_08_00_7B::
    db "Fhunt ", $57, $f0

String_08_00_7C::
    db "Fhunt inn", $f0

String_08_00_7D::
    db "Sage ", $5d, " 1F", $f0

String_08_00_7E::
    db "Sage ", $5d, " 2F", $f0

String_08_00_7F::
    db "Sage ", $5d, " 3F", $f0

String_08_00_80::
    db "Sage ", $5d, " 4F", $f0

String_08_00_81::
    db "Rope bridge", $f0

String_08_00_82::
    db "Pei ", $57, $f0

String_08_00_83::
    db "Pei inn", $f0

String_08_00_84::
    db "W mountain", $f0

String_08_00_85::
    db "W tunnel", $f0

String_08_00_86::
    db "Hitano ", $57, $f0

String_08_00_87::
    db "Hitano inn", $f0

String_08_00_88::
    db "Hitano pub", $f0

String_08_00_89::
    db "Hitano ", $58, $f0

String_08_00_8A::
    db "Rope bridge", $f0

String_08_00_8B::
    db "Small ", $5a, $f0

String_08_00_8C::
    db "Small ", $5a, " B1F", $f0

String_08_00_8D::
    db "Small ", $5a, " B2F", $f0

String_08_00_8E::
    db "Boss Rm.", $f0

String_08_00_8F::
    db "Wind ", $5d, " 1F", $f0

String_08_00_90::
    db "Wind ", $5d, " 2F", $f0

String_08_00_91::
    db "Wind ", $5d, " 3F", $f0

String_08_00_92::
    db "Wind ", $5d, " 4F", $f0

String_08_00_93::
    db "Sage ", $5d, $f0

String_08_00_94::
    db "Dead ", $58, $f0

String_08_00_95::
    db "Cathedral", $f0

String_08_00_96::
    db "Corridor", $f0

String_08_00_97::
    db "Morgue", $f0

String_08_00_98::
    db "Cemetery", $f0

String_08_00_99::
    db "Music rm.", $f0

String_08_00_9A::
    db "Corridor", $f0

String_08_00_9B::
    db "Dead rm.", $f0

String_08_00_9C::
    db "North ", $59, $f0

String_08_00_9D::
    db "Demon ", $58, $f0

String_08_00_9E::
    db "Demon ", $58, " 1F", $f0

String_08_00_9F::
    db "Demon ", $58, " B1F", $f0

String_08_00_A0::
    db "Demon ", $58, " B2F", $f0

String_08_00_A1::
    db "Demon ", $58, " B3F", $f0

String_08_00_A2::
    db "Demon ", $58, " B4F", $f0

String_08_00_A3::
    db "Demon ", $58, " B5F", $f0

String_08_00_A4::
    db "Demon ", $58, " B6F", $f0

String_08_00_A5::
    db "Demon hall", $f0

String_08_00_A6::
    db $17, $18, $f0

String_08_00_A7::
    db "Magic Door ", $59, $f0

String_08_00_A8::
    db $17, $18, $f0

String_08_00_AA::
    db "Limbo ", $5c, $f0

String_08_00_AB::
    db "Stairway", $f0

String_08_00_AC::
    db "Darck Manor", $f0

String_08_00_AD::
    db "Gallery", $f0

String_08_00_AE::
    db "Magic Door ", $59, $f0

String_08_00_AF::
    db $17, $18, $f0

String_08_00_B2::
    db "Elven ", $5c, $f0

String_08_00_B3::
    db "Elven ", $57, $f0

String_08_00_B4::
    db "W forest", $f0

String_08_00_B5::
    db "Lookout", $f0

String_08_00_B6::
    db "Summit", $f0

String_08_00_B7::
    db "Mt. base", $f0

String_08_00_B8::
    db "PlatinumMt.", $f0

String_08_00_B9::
    db "Magic Door ", $59, $f0

String_08_00_BA::
    db "Lonely ", $5c, $f0

String_08_00_BB::
    db "Kiral Lab", $f0

String_08_00_BC::
    db "Magic Door ", $59, $f0

String_08_00_BD::
    db "Lab B1F", $f0

String_08_00_BE::
    db "Lab B2F", $f0

String_08_00_BF::
    db "Lab B3F", $f0

String_08_00_C0::
    db "Barrel rm.", $f0

String_08_00_C1::
    db $17, $18, $f0

String_08_00_C2::
    db "Traveler ", $5c, $f0

String_08_00_C3::
    db "Miagen ", $57, $f0

String_08_00_C4::
    db "Travel hut", $f0

String_08_00_C5::
    db "N forest", $f0

String_08_00_C6::
    db "Inn", $f0

String_08_00_C7::
    db $5d, " summit", $f0

String_08_00_C8::
    db "Old ", $5d, " 1F", $f0

String_08_00_C9::
    db "Old ", $5d, " 2F", $f0

String_08_00_CA::
    db "Old ", $5d, " 3F", $f0

String_08_00_CB::
    db "Old ", $5d, " 4F", $f0

String_08_00_CC::
    db "Old ", $5d, " 5F", $f0

String_08_00_CD::
    db "Old ", $5d, " 6F", $f0

String_08_00_CE::
    db "Old ", $5d, " 7F", $f0

String_08_00_CF::
    db "Magic Door ", $59, $f0

String_08_00_D0::
    db $17, $18, $f0

String_08_00_D2::
    db "Power ", $5c, $f0

String_08_00_D3::
    db "Power ", $5d, " 1F", $f0

String_08_00_D4::
    db "Power ", $5d, " 2F", $f0

String_08_00_D5::
    db "Power ", $5d, " 3F", $f0

String_08_00_D6::
    db "Power ", $5d, " 4F", $f0

String_08_00_D7::
    db "Power ", $5d, " 5F", $f0

String_08_00_D8::
    db "Power ", $5d, " 6F", $f0

String_08_00_D9::
    db "Power ", $5d, " 7F", $f0

String_08_00_DA::
    db "Magic Door ", $59, $f0

String_08_00_DB::
    db "Baffle ", $5c, $f0

String_08_00_DC::
    db "Baffle ", $5d, " 1F", $f0

String_08_00_DD::
    db "Baffle ", $5d, " 2F", $f0

String_08_00_DE::
    db "Baffle ", $5d, " 3F", $f0

String_08_00_DF::
    db "Baffle ", $5d, " 4F", $f0

String_08_00_E0::
    db "Baffle ", $5d, " 5F", $f0

String_08_00_E1::
    db "Baffle ", $5d, " 6F", $f0

String_08_00_E2::
    db "Baffle ", $5d, " 7F", $f0

String_08_00_E3::
    db "Magic Door ", $59, $f0

String_08_00_E4::
    db "Soul ", $5c, $f0

String_08_00_E5::
    db "Soul ", $5d, " 1F", $f0

String_08_00_E6::
    db "Soul ", $5d, " 2F", $f0

String_08_00_E7::
    db "Soul ", $5d, " 3F", $f0

String_08_00_E8::
    db "Soul ", $5d, " 4F", $f0

String_08_00_E9::
    db "Soul ", $5d, " 5F", $f0

String_08_00_EA::
    db "Soul ", $5d, " 6F", $f0

String_08_00_EB::
    db "Soul ", $5d, " 7F", $f0

String_08_00_EC::
    db "Magic Door ", $59, $f0

String_08_00_ED::
    db $17, $18, $f0

String_08_01_00::
    db "Slime", $f0

String_08_01_01::
    db "Dragon", $f0

String_08_01_02::
    db "Beast", $f0

String_08_01_03::
    db "Bird", $f0

String_08_01_04::
    db "Plant", $f0

String_08_01_05::
    db "Bug", $f0

String_08_01_06::
    db "Demon", $f0

String_08_01_07::
    db "Zombie", $f0

String_08_01_08::
    db "Material", $f0

String_08_01_09::
    db "Water", $f0

String_08_01_0A::
    db "????", $f0

String_08_02_00::
    db $f0

String_08_02_01::
    db "DrakSlime", $f0

String_08_02_02::
    db "SpotSlime", $f0

String_08_02_03::
    db "WingSlime", $f0

String_08_02_04::
    db "TreeSlime", $f0

String_08_02_05::
    db "Snaily", $f0

String_08_02_06::
    db "SlimeNite", $f0

String_08_02_07::
    db "Babble", $f0

String_08_02_08::
    db "BoxSlime", $f0

String_08_02_09::
    db "PearlGel", $f0

String_08_02_0A::
    db "Slime", $f0

String_08_02_0B::
    db "Healer", $f0

String_08_02_0C::
    db "FangSlime", $f0

String_08_02_0D::
    db "RockSlime", $f0

String_08_02_0E::
    db "SlimeBorg", $f0

String_08_02_0F::
    db "Slabbit", $f0

String_08_02_10::
    db "KingSlime", $f0

String_08_02_11::
    db "Metaly", $f0

String_08_02_12::
    db "Metabble", $f0

String_08_02_13::
    db "SpotKing", $f0

String_08_02_14::
    db "TropicGel", $f0

String_08_02_15::
    db "MimeSlime", $f0

String_08_02_16::
    db "HaloSlime", $f0

String_08_02_17::
    db "MetalKing", $f0

String_08_02_18::
    db "GoldSlime", $f0

String_08_02_19::
    db "GranSlime", $f0

String_08_02_1A::
    db "WonderEgg", $f0

String_08_02_1B::
    db "Butch", $f0

String_08_02_1C::
    db $98, $f0

String_08_02_24::
    db "DragonKid", $f0

String_08_02_25::
    db "Tortragon", $f0

String_08_02_26::
    db "Pteranod", $f0

String_08_02_27::
    db "Gasgon", $f0

String_08_02_28::
    db "FairyDrak", $f0

String_08_02_29::
    db "LizardMan", $f0

String_08_02_2A::
    db "Poisongon", $f0

String_08_02_2B::
    db "Swordgon", $f0

String_08_02_2C::
    db "Drygon", $f0

String_08_02_2D::
    db "Dragon", $f0

String_08_02_2E::
    db "MiniDrak", $f0

String_08_02_2F::
    db "MadDragon", $f0

String_08_02_30::
    db "Rayburn", $f0

String_08_02_31::
    db "Chamelgon", $f0

String_08_02_32::
    db "LizardFly", $f0

String_08_02_33::
    db "Andreal", $f0

String_08_02_34::
    db "KingCobra", $f0

String_08_02_35::
    db "Vampirus", $f0

String_08_02_36::
    db "SnakeBat", $f0

String_08_02_37::
    db "Spikerous", $f0

String_08_02_38::
    db "GreatDrak", $f0

String_08_02_39::
    db "Crestpent", $f0

String_08_02_3A::
    db "WingSnake", $f0

String_08_02_3B::
    db "Coatol", $f0

String_08_02_3C::
    db "Orochi", $f0

String_08_02_3D::
    db "BattleRex", $f0

String_08_02_3E::
    db "SkyDragon", $f0

String_08_02_3F::
    db "Serpentia", $f0

String_08_02_40::
    db "Divinegon", $f0

String_08_02_41::
    db "Orligon", $f0

String_08_02_42::
    db "GigaDraco", $f0

String_08_02_43::
    db $98, $f0

String_08_02_47::
    db "Tonguella", $f0

String_08_02_48::
    db "Almiraj", $f0

String_08_02_49::
    db "CatFly", $f0

String_08_02_4A::
    db "PillowRat", $f0

String_08_02_4B::
    db "Saccer", $f0

String_08_02_4C::
    db "GulpBeast", $f0

String_08_02_4D::
    db "Skullroo", $f0

String_08_02_4E::
    db "WindBeast", $f0

String_08_02_4F::
    db "Beavern", $f0

String_08_02_50::
    db "Antbear", $f0

String_08_02_51::
    db "SuperTen", $f0

String_08_02_52::
    db "IronTurt", $f0

String_08_02_53::
    db "Mommonja", $f0

String_08_02_54::
    db "HammerMan", $f0

String_08_02_55::
    db "Grizzly", $f0

String_08_02_56::
    db "Yeti", $f0

String_08_02_57::
    db "ArrowDog", $f0

String_08_02_58::
    db "NoctoKing", $f0

String_08_02_59::
    db "BeastNite", $f0

String_08_02_5A::
    db "MadGopher", $f0

String_08_02_5B::
    db "FairyRat", $f0

String_08_02_5C::
    db "Unicorn", $f0

String_08_02_5D::
    db "Goategon", $f0

String_08_02_5E::
    db "WildApe", $f0

String_08_02_5F::
    db "Trumpeter", $f0

String_08_02_60::
    db "KingLeo", $f0

String_08_02_61::
    db "DarkHorn", $f0

String_08_02_62::
    db "MadCat", $f0

String_08_02_63::
    db "BigEye", $f0

String_08_02_64::
    db "Gorago", $f0

String_08_02_65::
    db "CatMage", $f0

String_08_02_66::
    db "Dumbira", $f0

String_08_02_67::
    db $98, $f0

String_08_02_6A::
    db "Picky", $f0

String_08_02_6B::
    db "Wyvern", $f0

String_08_02_6C::
    db "BullBird", $f0

String_08_02_6D::
    db "Florajay", $f0

String_08_02_6E::
    db "DuckKite", $f0

String_08_02_6F::
    db "MadPecker", $f0

String_08_02_70::
    db "MadRaven", $f0

String_08_02_71::
    db "MistyWing", $f0

String_08_02_72::
    db "AquaHawk", $f0

String_08_02_73::
    db "Dracky", $f0

String_08_02_74::
    db "KiteHawk", $f0

String_08_02_75::
    db "BigRoost", $f0

String_08_02_76::
    db "StubBird", $f0

String_08_02_77::
    db "LandOwl", $f0

String_08_02_78::
    db "MadGoose", $f0

String_08_02_79::
    db "MadCondor", $f0

String_08_02_7A::
    db "Emyu", $f0

String_08_02_7B::
    db "Blizzardy", $f0

String_08_02_7C::
    db "Phoenix", $f0

String_08_02_7D::
    db "ZapBird", $f0

String_08_02_7E::
    db "Garudian", $f0

String_08_02_7F::
    db "WhipBird", $f0

String_08_02_80::
    db "FunkyBird", $f0

String_08_02_81::
    db "RainHawk", $f0

String_08_02_82::
    db "Azurile", $f0

String_08_02_83::
    db "Shantak", $f0

String_08_02_84::
    db "CragDevil", $f0

String_08_02_85::
    db $98, $f0

String_08_02_8D::
    db "MadPlant", $f0

String_08_02_8E::
    db "FireWeed", $f0

String_08_02_8F::
    db "FloraMan", $f0

String_08_02_90::
    db "WingTree", $f0

String_08_02_91::
    db "CactiBall", $f0

String_08_02_92::
    db "Gulpple", $f0

String_08_02_93::
    db "Toadstool", $f0

String_08_02_94::
    db "AmberWeed", $f0

String_08_02_95::
    db "Slurperon", $f0

String_08_02_96::
    db "Stubsuck", $f0

String_08_02_97::
    db "Oniono", $f0

String_08_02_98::
    db "DanceVegi", $f0

String_08_02_99::
    db "TreeBoy", $f0

String_08_02_9A::
    db "Devipine", $f0

String_08_02_9B::
    db "FaceTree", $f0

String_08_02_9C::
    db "HerbMan", $f0

String_08_02_9D::
    db "BeanMan", $f0

String_08_02_9E::
    db "EvilSeed", $f0

String_08_02_9F::
    db "ManEater", $f0

String_08_02_A0::
    db "Snapper", $f0

String_08_02_A1::
    db "GhosTree", $f0

String_08_02_A2::
    db "Rosevine", $f0

String_08_02_A3::
    db "Egdracil", $f0

String_08_02_A4::
    db "Warubou", $f0

String_08_02_A5::
    db "Watabou", $f0

String_08_02_A6::
    db "Eggplaton", $f0

String_08_02_A7::
    db "FooHero", $f0

String_08_02_A8::
    db $98, $f0

String_08_02_B0::
    db "GiantSlug", $f0

String_08_02_B1::
    db "Catapila", $f0

String_08_02_B2::
    db "Gophecada", $f0

String_08_02_B3::
    db "Butterfly", $f0

String_08_02_B4::
    db "WeedBug", $f0

String_08_02_B5::
    db "GiantWorm", $f0

String_08_02_B6::
    db "Lipsy", $f0

String_08_02_B7::
    db "StagBug", $f0

String_08_02_B8::
    db "Pyuro", $f0

String_08_02_B9::
    db "ArmyAnt", $f0

String_08_02_BA::
    db "GoHopper", $f0

String_08_02_BB::
    db "TailEater", $f0

String_08_02_BC::
    db "ArmorPede", $f0

String_08_02_BD::
    db "Eyeder", $f0

String_08_02_BE::
    db "GiantMoth", $f0

String_08_02_BF::
    db "Droll", $f0

String_08_02_C0::
    db "ArmyCrab", $f0

String_08_02_C1::
    db "MadHornet", $f0

String_08_02_C2::
    db "Belzebub", $f0

String_08_02_C3::
    db "WarMantis", $f0

String_08_02_C4::
    db "HornBeet", $f0

String_08_02_C5::
    db "Sickler", $f0

String_08_02_C6::
    db "Armorpion", $f0

String_08_02_C7::
    db "Digster", $f0

String_08_02_C8::
    db "Skularach", $f0

String_08_02_C9::
    db "MultiEyes", $f0

String_08_02_CA::
    db $98, $f0

String_08_02_D3::
    db "Pixy", $f0

String_08_02_D4::
    db "MedusaEye", $f0

String_08_02_D5::
    db "AgDevil", $f0

String_08_02_D6::
    db "Demonite", $f0

String_08_02_D7::
    db "DarkEye", $f0

String_08_02_D8::
    db "EyeBall", $f0

String_08_02_D9::
    db "SkulRider", $f0

String_08_02_DA::
    db "EvilBeast", $f0

String_08_02_DB::
    db "Bubblemon", $f0

String_08_02_DC::
    db "1EyeClown", $f0

String_08_02_DD::
    db "Gremlin", $f0

String_08_02_DE::
    db "ArcDemon", $f0

String_08_02_DF::
    db "Lionex", $f0

String_08_02_E0::
    db "GoatHorn", $f0

String_08_02_E1::
    db "Orc", $f0

String_08_02_E2::
    db "Ogre", $f0

String_08_02_E3::
    db "GateGuard", $f0

String_08_02_E4::
    db "ChopClown", $f0

String_08_02_E5::
    db "BossTroll", $f0

String_08_02_E6::
    db "Grendal", $f0

String_08_02_E7::
    db "Akubar", $f0

String_08_02_E8::
    db "MadKnight", $f0

String_08_02_E9::
    db "EvilWell", $f0

String_08_02_EA::
    db "Gigantes", $f0

String_08_02_EB::
    db "Centasaur", $f0

String_08_02_EC::
    db "EvilArmor", $f0

String_08_02_ED::
    db "Jamirus", $f0

String_08_02_EE::
    db "Durran", $f0

String_08_02_EF::
    db "Titanis", $f0

String_08_02_F0::
    db "LampGenie", $f0

String_08_02_F1::
    db $98, $f0

String_08_02_F6::
    db "Spooky", $f0

String_08_02_F7::
    db "Skullgon", $f0

String_08_02_F8::
    db "PutrePup", $f0

String_08_02_F9::
    db "RotRaven", $f0

String_08_02_FA::
    db "Mummy", $f0

String_08_02_FB::
    db "DarkCrab", $f0

String_08_02_FC::
    db "DeadNite", $f0

String_08_02_FD::
    db "Shadow", $f0

String_08_02_FE::
    db "Skulpent", $f0

String_08_02_FF::
    db "Hork", $f0

String_08_03_00::
    db "Mudron", $f0

String_08_03_01::
    db "NiteWhip", $f0

String_08_03_02::
    db "WindMerge", $f0

String_08_03_03::
    db "Reaper", $f0

String_08_03_04::
    db "Inverzon", $f0

String_08_03_05::
    db "FoxFire", $f0

String_08_03_06::
    db "CaptDead", $f0

String_08_03_07::
    db "DeadNoble", $f0

String_08_03_08::
    db "WhiteKing", $f0

String_08_03_09::
    db "BoneSlave", $f0

String_08_03_0A::
    db "Skeletor", $f0

String_08_03_0B::
    db "Servant", $f0

String_08_03_0C::
    db "Lazamanus", $f0

String_08_03_0D::
    db "Copycat", $f0

String_08_03_0E::
    db "MadSpirit", $f0

String_08_03_0F::
    db "PomPomBom", $f0

String_08_03_10::
    db "Niterich", $f0

String_08_03_11::
    db $98, $f0

String_08_03_19::
    db "JewelBag", $f0

String_08_03_1A::
    db "EvilWand", $f0

String_08_03_1B::
    db "MadCandle", $f0

String_08_03_1C::
    db "CoilBird", $f0

String_08_03_1D::
    db "Facer", $f0

String_08_03_1E::
    db "SpikyBoy", $f0

String_08_03_1F::
    db "MadMirror", $f0

String_08_03_20::
    db "RogueNite", $f0

String_08_03_21::
    db "Puppetor", $f0

String_08_03_22::
    db "Goopi", $f0

String_08_03_23::
    db "Voodoll", $f0

String_08_03_24::
    db "MetalDrak", $f0

String_08_03_25::
    db "Balzak", $f0

String_08_03_26::
    db "SabreMan", $f0

String_08_03_27::
    db "CurseLamp", $f0

String_08_03_28::
    db "Brushead", $f0

String_08_03_29::
    db "Roboster", $f0

String_08_03_2A::
    db "Roboster2", $f0

String_08_03_2B::
    db "EvilPot", $f0

String_08_03_2C::
    db "Gismo", $f0

String_08_03_2D::
    db "LavaMan", $f0

String_08_03_2E::
    db "IceMan", $f0

String_08_03_2F::
    db "Mimic", $f0

String_08_03_30::
    db "Exaucers", $f0

String_08_03_31::
    db "MudDoll", $f0

String_08_03_32::
    db "Golem", $f0

String_08_03_33::
    db "StoneMan", $f0

String_08_03_34::
    db "BombCrag", $f0

String_08_03_35::
    db "GoldGolem", $f0

String_08_03_36::
    db "DarkMate", $f0

String_08_03_37::
    db "ProtoMech", $f0

String_08_03_38::
    db "CloudKing", $f0

String_08_03_39::
    db $98, $f0

String_08_03_3C::
    db "Petiteel", $f0

String_08_03_3D::
    db "Moray", $f0

String_08_03_3E::
    db "WalrusMan", $f0

String_08_03_3F::
    db "RayGigas", $f0

String_08_03_40::
    db "Anemon", $f0

String_08_03_41::
    db "Aquarella", $f0

String_08_03_42::
    db "Merman", $f0

String_08_03_43::
    db "Octokid", $f0

String_08_03_44::
    db "PutreFish", $f0

String_08_03_45::
    db "Octoreach", $f0

String_08_03_46::
    db "Angleron", $f0

String_08_03_47::
    db "FishRider", $f0

String_08_03_48::
    db "RushFish", $f0

String_08_03_49::
    db "Gamanian", $f0

String_08_03_4A::
    db "Clawster", $f0

String_08_03_4B::
    db "CancerMan", $f0

String_08_03_4C::
    db "RogueWave", $f0

String_08_03_4D::
    db "Scallopa", $f0

String_08_03_4E::
    db "SeaHorse", $f0

String_08_03_4F::
    db "HoodSquid", $f0

String_08_03_50::
    db "MerTiger", $f0

String_08_03_51::
    db "AxeShark", $f0

String_08_03_52::
    db "Octogon", $f0

String_08_03_53::
    db "KingSquid", $f0

String_08_03_54::
    db "Digong", $f0

String_08_03_55::
    db "WhaleMage", $f0

String_08_03_56::
    db "Aquadon", $f0

String_08_03_57::
    db "Octoraid", $f0

String_08_03_58::
    db "Grakos", $f0

String_08_03_59::
    db "Poseidon", $f0

String_08_03_5A::
    db "Pumpoise", $f0

String_08_03_5B::
    db "Starfish", $f0

String_08_03_5C::
    db $98, $f0

String_08_03_5F::
    db "DracoLord", $f0

String_08_03_60::
    db "DracoLord", $f0

String_08_03_61::
    db "LordDraco", $f0

String_08_03_62::
    db "Hargon", $f0

String_08_03_63::
    db "Sidoh", $f0

String_08_03_64::
    db "Genosidoh", $f0

String_08_03_65::
    db "Baramos", $f0

String_08_03_66::
    db "Zoma", $f0

String_08_03_67::
    db "AsuraZoma", $f0

String_08_03_68::
    db "Pizzaro", $f0

String_08_03_69::
    db "PsychoPiz", $f0

String_08_03_6A::
    db "Esterk", $f0

String_08_03_6B::
    db "Mirudraas", $f0

String_08_03_6C::
    db "Mirudraas", $f0

String_08_03_6D::
    db "Mudou", $f0

String_08_03_6E::
    db "DeathMore", $f0

String_08_03_6F::
    db "DeathMore", $f0

String_08_03_70::
    db "DeathMore", $f0

String_08_03_71::
    db "Darkdrium", $f0

String_08_03_72::
    db "Orgodemir", $f0

String_08_03_73::
    db "Orgodemir", $f0

String_08_03_74::
    db "Darck", $f0

String_08_03_75::
    db "Tatsu", $f0

String_08_03_76::
    db "Diago", $f0

String_08_03_77::
    db "Samsi", $f0

String_08_03_78::
    db "Bazoo", $f0

String_08_03_79::
    db $98, $f0

String_08_03_7C::
    db "Lamia", $f0

String_08_03_7D::
    db "Dimensaur", $f0

String_08_03_7E::
    db "Kagebou", $f0

String_08_03_7F::
    db $98, $f0

String_08_04_00::
    db $f0

String_08_04_01::
    db "Blaze", $f0

String_08_04_02::
    db "Blazemore", $f0

String_08_04_03::
    db "Blazemost", $f0

String_08_04_04::
    db "Firebal", $f0

String_08_04_05::
    db "Firebane", $f0

String_08_04_06::
    db "Firebolt", $f0

String_08_04_07::
    db "Bang", $f0

String_08_04_08::
    db "Boom", $f0

String_08_04_09::
    db "Explodet", $f0

String_08_04_0A::
    db "Infernos", $f0

String_08_04_0B::
    db "Infermore", $f0

String_08_04_0C::
    db "Infermost", $f0

String_08_04_0D::
    db "Bolt", $f0

String_08_04_0E::
    db "Zap", $f0

String_08_04_0F::
    db "Thordain", $f0

String_08_04_10::
    db "IceBolt", $f0

String_08_04_11::
    db "SnowStorm", $f0

String_08_04_12::
    db "Blizzard", $f0

String_08_04_13::
    db "Beat", $f0

String_08_04_14::
    db "Defeat", $f0

String_08_04_15::
    db "Sacrifice", $f0

String_08_04_16::
    db "Heal", $f0

String_08_04_17::
    db "HealMore", $f0

String_08_04_18::
    db "HealAll", $f0

String_08_04_19::
    db "HealUs", $f0

String_08_04_1A::
    db "HealUsAll", $f0

String_08_04_1B::
    db "MPass", $f0

String_08_04_1C::
    db "MPassmore", $f0

String_08_04_1D::
    db "MPassmost", $f0

String_08_04_1E::
    db "Vivify", $f0

String_08_04_1F::
    db "Revive", $f0

String_08_04_20::
    db "Farewell", $f0

String_08_04_21::
    db "Antidote", $f0

String_08_04_22::
    db "DeChaos", $f0

String_08_04_23::
    db "NumbOff", $f0

String_08_04_24::
    db "CurseOff", $f0

String_08_04_25::
    db "Upper", $f0

String_08_04_26::
    db "Increase", $f0

String_08_04_27::
    db "Sap", $f0

String_08_04_28::
    db "Defense", $f0

String_08_04_29::
    db "Speed", $f0

String_08_04_2A::
    db "SpeedUp", $f0

String_08_04_2B::
    db "Slow", $f0

String_08_04_2C::
    db "SlowAll", $f0

String_08_04_2D::
    db "TwinHits", $f0

String_08_04_2E::
    db "Surround", $f0

String_08_04_2F::
    db "Sleep", $f0

String_08_04_30::
    db "SleepAll", $f0

String_08_04_31::
    db "TakeMagic", $f0

String_08_04_32::
    db "RobMagic", $f0

String_08_04_33::
    db "StopSpell", $f0

String_08_04_34::
    db "PanicAll", $f0

String_08_04_35::
    db "Ironize", $f0

String_08_04_36::
    db "MagicBack", $f0

String_08_04_37::
    db "Bounce", $f0

String_08_04_38::
    db "Barrier", $f0

String_08_04_39::
    db "MagicWall", $f0

String_08_04_3A::
    db "Transform", $f0

String_08_04_3B::
    db "BeDragon", $f0

String_08_04_3C::
    db "Chance", $f0

String_08_04_3D::
    db "MegaMagic", $f0

String_08_04_3E::
    db "BigBang", $f0

String_08_04_3F::
    db "Hellblast", $f0

String_08_04_40::
    db "FireAir", $f0

String_08_04_41::
    db "BlazeAir", $f0

String_08_04_42::
    db "Scorching", $f0

String_08_04_43::
    db "WhiteFire", $f0

String_08_04_44::
    db "FrigidAir", $f0

String_08_04_45::
    db "IceAir", $f0

String_08_04_46::
    db "IceStorm", $f0

String_08_04_47::
    db "WhiteAir", $f0

String_08_04_48::
    db "WindBeast", $f0

String_08_04_49::
    db "Vacuum", $f0

String_08_04_4A::
    db "Lightning", $f0

String_08_04_4B::
    db "RockThrow", $f0

String_08_04_4C::
    db "Watershot", $f0

String_08_04_4D::
    db "Tidalwave", $f0

String_08_04_4E::
    db "CallHelp", $f0

String_08_04_4F::
    db "YellHelp", $f0

String_08_04_50::
    db "FireSlash", $f0

String_08_04_51::
    db "VacuSlash", $f0

String_08_04_52::
    db "BoltSlash", $f0

String_08_04_53::
    db "IceSlash", $f0

String_08_04_54::
    db "SlimeBlow", $f0

String_08_04_55::
    db "DrakSlash", $f0

String_08_04_56::
    db "BeastCut", $f0

String_08_04_57::
    db "BirdBlow", $f0

String_08_04_58::
    db "BugBlow", $f0

String_08_04_59::
    db "Shears", $f0

String_08_04_5A::
    db "DevilCut", $f0

String_08_04_5B::
    db "ZombieCut", $f0

String_08_04_5C::
    db "CleanCut", $f0

String_08_04_5D::
    db "AquaCut", $f0

String_08_04_5E::
    db "MetalCut", $f0

String_08_04_5F::
    db "PoisonHit", $f0

String_08_04_60::
    db "Paralyze", $f0

String_08_04_61::
    db "NapAttack", $f0

String_08_04_62::
    db "SquallHit", $f0

String_08_04_63::
    db "BiAttack", $f0

String_08_04_64::
    db "QuadHits", $f0

String_08_04_65::
    db "RainSlash", $f0

String_08_04_66::
    db "MultiCut", $f0

String_08_04_67::
    db "GigaSlash", $f0

String_08_04_68::
    db "ChargeUp", $f0

String_08_04_69::
    db "PsycheUp", $f0

String_08_04_6A::
    db "HighJump", $f0

String_08_04_6B::
    db "EvilSlash", $f0

String_08_04_6C::
    db "Massacre", $f0

String_08_04_6D::
    db "TwinSlash", $f0

String_08_04_6E::
    db "Berserker", $f0

String_08_04_6F::
    db "Ramming", $f0

String_08_04_70::
    db "Kamikaze", $f0

String_08_04_71::
    db "SleepAir", $f0

String_08_04_72::
    db "PalsyAir", $f0

String_08_04_73::
    db "PoisonGas", $f0

String_08_04_74::
    db "PoisonAir", $f0

String_08_04_75::
    db "Curse", $f0

String_08_04_76::
    db "OddDance", $f0

String_08_04_77::
    db "RobDance", $f0

String_08_04_78::
    db "PaniDance", $f0

String_08_04_79::
    db "K.O.Dance", $f0

String_08_04_7A::
    db "LureDance", $f0

String_08_04_7B::
    db "LifeDance", $f0

String_08_04_7C::
    db "Hustle", $f0

String_08_04_7D::
    db "SideStep", $f0

String_08_04_7E::
    db "SandStorm", $f0

String_08_04_7F::
    db "Radiant", $f0

String_08_04_80::
    db "EerieLite", $f0

String_08_04_81::
    db "Surge", $f0

String_08_04_82::
    db "UltraDown", $f0

String_08_04_83::
    db "DeMagic", $f0

String_08_04_84::
    db "ThickFog", $f0

String_08_04_85::
    db "TatsuCall", $f0

String_08_04_86::
    db "DiagoCall", $f0

String_08_04_87::
    db "SamsiCall", $f0

String_08_04_88::
    db "BazooCall", $f0

String_08_04_89::
    db "SuckAir", $f0

String_08_04_8A::
    db "Focus", $f0

String_08_04_8B::
    db "LushLicks", $f0

String_08_04_8C::
    db "SickLick", $f0

String_08_04_8D::
    db "LegSweep", $f0

String_08_04_8E::
    db "BigTrip", $f0

String_08_04_8F::
    db "Ahhh", $f0

String_08_04_90::
    db "WarCry", $f0

String_08_04_91::
    db "Geyser", $f0

String_08_04_92::
    db "DanceShut", $f0

String_08_04_93::
    db "MouthShut", $f0

String_08_04_94::
    db "StrongD", $f0

String_08_04_95::
    db "Dodge", $f0

String_08_04_96::
    db "BladeD", $f0

String_08_04_97::
    db "Cover", $f0

String_08_04_98::
    db "Guardian", $f0

String_08_04_99::
    db "TailWind", $f0

String_08_04_9A::
    db "StormWind", $f0

String_08_04_9B::
    db "AquaWall", $f0

String_08_04_9C::
    db "SealPray", $f0

String_08_04_9D::
    db "SuckAll", $f0

String_08_04_9E::
    db "Imitate", $f0

String_08_04_9F::
    db "Meditate", $f0

String_08_04_A0::
    db "LifeSong", $f0

String_08_04_A1::
    db "LoveRain", $f0

String_08_04_A2::
    db "Whistle", $f0

String_08_04_A3::
    db "Pheromone", $f0

String_08_04_A4::
    db "StepGuard", $f0

String_08_04_A5::
    db "Outside", $f0

String_08_04_A6::
    db "Informer", $f0

String_08_04_A7::
    db "Errand", $f0

String_08_04_A8::
    db "EagleEye", $f0

String_08_04_A9::
    db "MapMagic", $f0

String_08_04_AA::
    db "Ahhh", $f0

String_08_04_AB::
    db "ZoneOut", $f0

String_08_04_AC::
    db "Guard", $f0

String_08_04_AD::
    db "PanicAll", $f0

String_08_04_AE::
    db "Ironize", $f0

String_08_04_AF::
    db "HighJump", $f0

String_08_04_CD::
    db "LoveRain", $f0

String_08_04_D0::
    db $f0

String_08_05_00::
    db $f0

String_08_05_01::
    db "Herb", $f0

String_08_05_02::
    db "LoveWater", $f0

String_08_05_03::
    db "WorldDew", $f0

String_08_05_04::
    db "Potion", $f0

String_08_05_05::
    db "ElfWater", $f0

String_08_05_06::
    db "Antidote", $f0

String_08_05_07::
    db "MoonHerb", $f0

String_08_05_08::
    db "Laurel", $f0

String_08_05_09::
    db "AwakeSand", $f0

String_08_05_0A::
    db "SkyBell", $f0

String_08_05_0B::
    db "SageRock", $f0

String_08_05_0C::
    db "WorldLeaf", $f0

String_08_05_0D::
    db "ATKseed", $f0

String_08_05_0E::
    db "DEFseed", $f0

String_08_05_0F::
    db "AGLseed", $f0

String_08_05_10::
    db "INTseed", $f0

String_08_05_11::
    db "LifeAcorn", $f0

String_08_05_12::
    db "MysticNut", $f0

String_08_05_13::
    db "Quest", $50, $f0

String_08_05_14::
    db "Horror", $50, $f0

String_08_05_15::
    db "BeNice", $50, $f0

String_08_05_16::
    db "Cheater", $50, $f0

String_08_05_17::
    db "Smart", $50, $f0

String_08_05_18::
    db "Comedy", $50, $f0

String_08_05_19::
    db "BeefJerky", $f0

String_08_05_1A::
    db "PorkChop", $f0

String_08_05_1B::
    db "Rib", $f0

String_08_05_1C::
    db "Sirloin", $f0

String_08_05_1D::
    db "BadMeat", $f0

String_08_05_1E::
    db "MeteOrb", $f0

String_08_05_1F::
    db "BeastTail", $f0

String_08_05_20::
    db "Repellent", $f0

String_08_05_21::
    db "ShinyHarp", $f0

String_08_05_22::
    db "Mist", $51, $f0

String_08_05_23::
    db "Friend", $51, $f0

String_08_05_24::
    db "Wind", $51, $f0

String_08_05_25::
    db "Bolt", $51, $f0

String_08_05_26::
    db "Snow", $51, $f0

String_08_05_27::
    db "Fire", $51, $f0

String_08_05_28::
    db "Warp", $51, $f0

String_08_05_29::
    db "WarpWing", $f0

String_08_05_2A::
    db "ExitBell", $f0

String_08_05_2B::
    db "Bookmark", $f0

String_08_05_2C::
    db "TinyMedal", $f0

String_08_05_2D::
    db "GoldPass", $f0

String_08_05_2E::
    db "LogTwig", $f0

String_08_05_2F::
    db $f0

String_08_05_30::
    db "WaterCall", $f0

String_08_05_31::
    db "MoonRock", $f0

String_08_05_32::
    db "Crest", $f0

String_08_05_33::
    db "YunaSoul", $f0

String_08_05_34::
    db "SleepHerb", $f0

String_08_05_35::
    db "Change", $51, $f0

String_08_05_36::
    db "TidalBell", $f0

String_08_05_37::
    db "HarMirror", $f0

String_08_05_38::
    db "Sky", $5e, $f0

String_08_05_39::
    db "Heaven", $52, $f0

String_08_05_3A::
    db "Heaven", $54, $f0

String_08_05_3B::
    db "Heaven", $53, $f0

String_08_05_3C::
    db "WizStone", $f0

String_08_05_3D::
    db "Pretty", $55, $f0

String_08_05_3E::
    db "Accessory", $f0

String_08_05_40::
    db "VITbelt", $f0

String_08_05_41::
    db "DracoBelt", $f0

String_08_05_42::
    db "MagicBelt", $f0

String_08_05_43::
    db "OddBelt", $f0

String_08_05_44::
    db "StoneFang", $f0

String_08_05_45::
    db "SteelFang", $f0

String_08_05_46::
    db "MermScale", $f0

String_08_05_47::
    db "DrakScale", $f0

String_08_05_48::
    db "AGL", $55, $f0

String_08_05_49::
    db "Starry", $55, $f0

String_08_05_4A::
    db "Smart", $56, $f0

String_08_05_4B::
    db "Wise", $56, $f0

String_08_05_4C::
    db "MagicCape", $f0

String_08_05_4D::
    db "DracoCape", $f0

String_08_05_4E::
    db "SilvrCape", $f0

String_08_05_4F::
    db "GoldCape", $f0

String_08_05_50::
    db "PltnmCape", $f0

String_08_05_51::
    db "OrcaCape", $f0

String_08_05_52::
    db "BraveCape", $f0

String_08_05_53::
    db "D-Scale", $f0

String_08_05_54::
    db "None", $f0

String_08_05_5A::
    db "Life", $55, $f0

String_08_05_5B::
    db "Divine", $55, $f0

String_08_05_5C::
    db "War", $55, $f0

String_08_05_5D::
    db "Mage", $55, $f0

String_08_05_5E::
    db "Fight", $55, $f0

String_08_05_5F::
    db "Sailor", $55, $f0

String_08_05_60::
    db "Thief", $55, $f0

String_08_05_61::
    db "Cleric", $55, $f0

String_08_05_62::
    db $f0

String_08_06_00::
    db "Restores HP of one", $f1
    db "monster by 30", $9d, "40.", $f0

String_08_06_02::
    db "Restores HP of one", $f1
    db "monster by 60", $9d, "70.", $f0

String_08_06_03::
    db "Fully restores HP", $f1
    db "of all monsters.", $f0

String_08_06_04::
    db "Restores MP of one", $f1
    db "monster by 20", $9d, "30.", $f0

String_08_06_05::
    db "Fully restores MP", $f1
    db "of one monster.", $f0

String_08_06_06::
    db "Removes all traces", $f1
    db "of poison.", $f0

String_08_06_07::
    db "Cures paralysis.", $f0

String_08_06_08::
    db "Lifts a curse off", $f1
    db "one monster.", $f0

String_08_06_09::
    db "Awakens a sleeping", $f1
    db "monster.", $f0

String_08_06_0A::
    db "Snaps a monster", $f1
    db "out of confusion.", $f0

String_08_06_0B::
    db "Restores HP of all", $f1
    db "monsters by 60", $9d, "70.", $f0

String_08_06_0C::
    db "Revives a dead", $f1
    db "monster.", $f0

String_08_06_0D::
    db "Raises ATK by 3.", $f0

String_08_06_0E::
    db "Raises DEF by 3.", $f0

String_08_06_0F::
    db "Raises AGL by 3.", $f0

String_08_06_10::
    db "Raises INT by 3.", $f0

String_08_06_11::
    db "Raises max. HP", $f1
    db "by 5.", $f0

String_08_06_12::
    db "Raises max. MP", $f1
    db "by 5.", $f0

String_08_06_13::
    db "Makes the reader", $f1
    db "braver.", $f0

String_08_06_14::
    db "Makes the reader", $f1
    db "more cowardly.", $f0

String_08_06_15::
    db "Makes the reader", $f1
    db "more kindly.", $f0

String_08_06_16::
    db "Makes the reader", $f1
    db "more sly.", $f0

String_08_06_17::
    db "Makes the reader", $f1
    db "more thoughtful.", $f0

String_08_06_18::
    db "Makes the reader", $f1
    db "simple-minded.", $f0

String_08_06_19::
    db "Tames monsters", $f1
    db "just a little.", $f0

String_08_06_1A::
    db "Tames monsters a", $f1
    db "little bit.", $f0

String_08_06_1B::
    db "Tames monsters a", $f1
    db "lot.", $f0

String_08_06_1C::
    db "Tames monsters", $f1
    db "very much.", $f0

String_08_06_1D::
    db "Tames a tiny bit,", $f1
    db "but also poisons.", $f0

String_08_06_1E::
    db "Tames monsters", $f1
    db "incredibly.", $f0

String_08_06_1F::
    db "Checks if monster", $f1
    db "was caught before.", $f0

String_08_06_20::
    db "Prevents monsters", $f1
    db "from appearing.", $f0

String_08_06_21::
    db "Attracts monsters", $f1
    db "when strummed.", $f0

String_08_06_22::
    db "Prevents casting", $f1
    db "of spells.", $f0

String_08_06_23::
    db "Doubles physical", $f1
    db "power of one.", $f0

String_08_06_24::
    db "Hits all enemies", $f1
    db "with a windstorm.", $f0

String_08_06_25::
    db "Hits all enemies", $f1
    db "with lightning.", $f0

String_08_06_26::
    db "Hits all enemies", $f1
    db "with a blizzard.", $f0

String_08_06_27::
    db "Hits one target", $f1
    db "with a fireball.", $f0

String_08_06_28::
    db "Instantly warps to", $f1
    db "the Door Shrine.", $f0

String_08_06_29::
    db "Instantly warps to", $f1
    db "GreatLog.", $f0

String_08_06_2A::
    db "Instantly warps to", $f1
    db "the exit.", $f0

String_08_06_2B::
    db "Enables saving in", $f1
    db "the Journal.", $f0

String_08_06_2C::
    db "Collect and trade", $f1
    db "for rare gifts.", $f0

String_08_06_2D::
    db "Get a 10-percent", $f1
    db "discount at shops.", $f0

String_08_06_2E::
    db "Moves the Door", $f1
    db "Shrine.", $f0

String_08_06_2F::
    db "Reveals Mirage", $f1
    db "Lake.", $f0

String_08_06_31::
    db "A magic stone that", $f1
    db "raises the tide.", $f0

String_08_06_32::
    db "A medal from the", $f1
    db "elemental spirit.", $f0

String_08_06_33::
    db "The lost soul of a", $f1
    db "princess.", $f0

String_08_06_34::
    db "A blue flower that", $f1
    db "grows in snow.", $f0

String_08_06_35::
    db "Transforms users", $f1
    db "into monsters.", $f0

String_08_06_36::
    db "Summons a clam for", $f1
    db "crossing the sea.", $f0

String_08_06_37::
    db "Destroys what it", $f1
    db "reflects.", $f0

String_08_06_38::
    db "Summons a cloud", $f1
    db "for flying.", $f0

String_08_06_39::
    db "A legendary helmet", $f1
    db "found in a cave.", $f0

String_08_06_3A::
    db "A legendary armor", $f1
    db "found in a tower.", $f0

String_08_06_3B::
    db "A legendary sword", $f1
    db "found in a castle.", $f0

String_08_06_3C::
    db "A magical stone", $f1
    db "that glows blue.", $f0

String_08_06_3D::
    db "A beautiful gold", $f1
    db "ring.", $f0

String_08_06_3E::
    db "Undefined.", $f0

String_08_06_40::
    db "Raises max. HP", $f1
    db "by 30.", $f0

String_08_06_41::
    db "Raises max. HP", $f1
    db "by 80.", $f0

String_08_06_42::
    db "Raises max. MP", $f1
    db "by 30.", $f0

String_08_06_43::
    db "Raises max. MP", $f1
    db "by 80.", $f0

String_08_06_44::
    db "Raises ATK by 10.", $f0

String_08_06_45::
    db "Raises ATK by 50.", $f0

String_08_06_46::
    db "Raises DEF by 10.", $f0

String_08_06_47::
    db "Raises DEF by 50.", $f0

String_08_06_48::
    db "Raises AGL by 10.", $f0

String_08_06_49::
    db "Raises AGL by 50.", $f0

String_08_06_4A::
    db "Raises INT by 50.", $f0

String_08_06_4B::
    db "Raises INT by 100.", $f0

String_08_06_4C::
    db "Raises resistance", $f1
    db "to attack spells.", $f0

String_08_06_4D::
    db "Raises resistance", $f1
    db "to fire and ice.", $f0

String_08_06_4E::
    db "Resists confusion,", $f1
    db "poison ", $b6, " sleep.", $f0

String_08_06_4F::
    db "Resists most", $f1
    db "status skills.", $f0

String_08_06_50::
    db "Resists curse,", $f1
    db "paralysis ", $b6, " death.", $f0

String_08_06_51::
    db "Raises resistance", $f1
    db "to water skills.", $f0

String_08_06_52::
    db "Prevents skills", $f1
    db "from being sealed.", $f0

String_08_06_53::
    db "Raises DEF by 5.", $f0

String_08_06_54::
    db "Undefined.", $f0

String_08_06_5A::
    db "Restores HP by 1", $f1
    db "on every step.", $f0

String_08_06_5B::
    db "Restores MP by 1", $f1
    db "on every step.", $f0

String_08_06_5C::
    db "Promotes max. HP", $f1
    db "gain.", $f0

String_08_06_5D::
    db "Promotes max.", $f1
    db "MP gain.", $f0

String_08_06_5E::
    db "Promotes ATK gain", $f1
    db "while growing.", $f0

String_08_06_5F::
    db "Promotes DEF gain", $f1
    db "while growing.", $f0

String_08_06_60::
    db "Promotes AGL gain", $f1
    db "while growing.", $f0

String_08_06_61::
    db "Promotes INT gain", $f1
    db "while growing.", $f0

String_08_06_62::
    db "Undefined.", $f0

String_08_06_63::
    db $f1, $f0

String_08_06_6F::
    db "Checks if monster", $f1
    db "was caught before.", $f0

String_08_07_00::
    db "Hotblood", $f0

String_08_07_01::
    db "Eager", $f0

String_08_07_02::
    db "Smug", $f0

String_08_07_03::
    db "Earnest", $f0

String_08_07_04::
    db "Pushy", $f0

String_08_07_05::
    db "Snobby", $f0

String_08_07_06::
    db "Reckless", $f0

String_08_07_07::
    db "Daring", $f0

String_08_07_08::
    db "Daredevil", $f0

String_08_07_09::
    db "Cool", $9e, "Calm", $f0

String_08_07_0A::
    db "Serious", $f0

String_08_07_0B::
    db "Selfish", $f0

String_08_07_0C::
    db "Simple", $f0

String_08_07_0D::
    db "Innocent", $f0

String_08_07_0E::
    db "Prideful", $f0

String_08_07_0F::
    db "Nosy", $f0

String_08_07_10::
    db "Whimsy", $f0

String_08_07_11::
    db "Spoiled", $f0

String_08_07_12::
    db "Smart", $f0

String_08_07_13::
    db "Sly", $f0

String_08_07_14::
    db "Cruel", $f0

String_08_07_15::
    db "Shy", $f0

String_08_07_16::
    db "Affable", $f0

String_08_07_17::
    db "Coward", $f0

String_08_07_18::
    db "Gullible", $f0

String_08_07_19::
    db "Carefree", $f0

String_08_07_1A::
    db "Lazy", $f0

String_08_08_00::
    db "No items", $f0

String_08_08_01::
    db "Toss this away?", $f0

String_08_08_02::
    db $f9, "W can't be", $f1
    db "tossed out.", $f7
    db $f0

String_08_08_03::
    db "But nothing", $f1
    db "happened.", $f7
    db $f0

String_08_08_04::
    db $f6, " threw away", $f1
    db "the ", $f9, "W.", $f7
    db $f0

String_08_08_05::
    db $f9, $00, $f0

String_08_08_06::
    db $f6, " tried using", $f1
    db $f9, "W.", $f7
    db $f2, "But nothing", $f1
    db "happened.", $f7
    db $f0

String_08_08_07::
    db "Toss out the", $f1
    db $f9, "W?", $f0

String_08_08_08::
    db "You can't toss", $f1
    db "that out!", $f7
    db $f0

String_08_08_09::
    db "That can't be used", $f1
    db "here.", $f7
    db $f0

String_08_08_0A::
    db "Not in use.", $f0

String_08_08_0B::
    db $f6, " inserted the", $f1
    db "key.", $f7
    db $f0

String_08_08_0C::
    db "The key could not", $f1
    db "be used yet.", $f7
    db $f0

String_08_08_0D::
    db "You can't save", $f1
    db "here.", $f7
    db $f0

String_08_08_0E::
    db "No skills", $f0
    ds $c17, $00
