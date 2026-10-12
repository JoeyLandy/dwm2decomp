SECTION "Bank 08", ROMX[$4000], BANK[$08]
    db $08

; if wC528 < 9, BeginStringDisplay with DE = StringDatabase; otherwise far-calls Func_095_4650
; 12 call sites from 11 routines (e.g. ShowString_Bank08, ShowStringHL_Bank08, DebugMessageTest_Update_ToBeginStringDisplay_Bank08, PauseMenu_Items_Case02_Case02, ...)
; reads: wStringCategory
BeginStringDisplay_Bank08::
Func_008_4001:: ; address name
    ld a, [wStringCategory]
    cp a, $09
    jr c, Jump_008_400F
    farcall BeginStringDisplay_Bank08_Sub01
    ret

Jump_008_400F::
    ld de, StringDatabase
    call BeginStringDisplay
    ret

; if wC528 < 9, CopyStringToBuffer with DE = StringDatabase; otherwise far-calls Func_095_465F
; 3 call sites from 3 routines (e.g. CopyStringHLToDE, Talk00Event17_Case19, RunGameMode2State_Case01_Sub02)
; reads: wStringCategory
CopyStringToBuffer_Bank08::
Func_008_4016:: ; address name
    ld a, [wStringCategory]
    cp a, $09
    jr c, Jump_008_4024
    farcall CopyStringToBuffer_Bank08_Sub01
    ret

Jump_008_4024::
    ld de, StringDatabase
    call CopyStringToBuffer
    ret

; Func_008_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 71 call sites from 52 routines (e.g. DebugMessageTest_Init, DebugMonsterRecordViewer_Init, DebugSkillViewer_Init, DebugResultsDisplay_Init, ...)
ShowString_Bank08::
Func_008_402B:: ; address name
    call BeginStringDisplay_Bank08
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_08_4032::
StringDatabase:: ; heuristic: bank from RAM variable $D7FE; C0
Data_008_4032:: ; address name
    dw StringList_08_4044 ; id 0
    dw StringList_08_4242 ; id 1
    dw StringList_08_4258 ; id 2
Data_008_4038:: ; heuristic: argument of a bank-switching copy helper; C0
    dw StringList_08_4458 ; id 3
    dw StringList_08_4558 ; id 4
Data_008_403C:: ; heuristic: argument of a bank-switching copy helper; C0
    dw StringList_08_4716 ; id 5
    dw StringList_08_47F6 ; id 6
    dw StringList_08_48D6 ; id 7
    dw StringList_08_490C ; id 8

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4044::
StringTable_System:: ; heuristic: string list; C0
Data_008_4044:: ; address name
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

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4242::
StringTable_MonsterFamilies:: ; heuristic: string list; C0
Data_008_4242:: ; address name
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

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4258::
StringTable_MonsterNames:: ; heuristic: string list; C0
Data_008_4258:: ; address name
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

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4458::
StringTable_MonsterNames2:: ; heuristic: string list; C0
Data_008_4458:: ; address name
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

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4558::
StringTable_SkillNames:: ; heuristic: string list; C0
Data_008_4558:: ; address name
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

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4716::
StringTable_ItemNames:: ; heuristic: string list; C0
Data_008_4716:: ; address name
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

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_47F6::
StringTable_ItemDescriptions:: ; heuristic: string list; C0
Data_008_47F6:: ; address name
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

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_48D6::
StringTable_PersonalityNames:: ; heuristic: string list; C0
Data_008_48D6:: ; address name
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

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_490C::
StringTable_ItemMenuMessages:: ; heuristic: string list; C0
Data_008_490C:: ; address name
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

String_08_00_00:: ; heuristic: string; C0
Data_008_492A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "0123456789ABCDEF", $F0

String_08_00_01:: ; heuristic: string; C0
Data_008_493B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  DEBUG MODE        SELECT       1", $A3, "GOTO PROGRAM  2", $A3, "EDIT "
    db "         3", $A3, "AUTOMAP CHECK 4", $A3, "GRAFHICS      5", $A3, "SOUNDS     "
    db "   6", $A3, "BATTLE        7", $A3, "HAIGOU        8", $A3, "STAFF ROLL    9", $A3
    db "TOKUGI CHECK  A", $A3, "ENEMY TBL CHK B", $A3, "MESSAGE CHK  ?  RETURN  "
    db "?  ", $F0

String_08_00_02:: ; heuristic: string; C0
Data_008_4A1A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ? EDIT ?                      WORLD", $A3, "          MAP X", $A3, "  "
    db "            Y", $A3, "          POS X", $A3, "              Y", $A3, "        "
    db "  NOT DATA", $9F, $F0

String_08_00_03:: ; heuristic: string; C0
Data_008_4A94:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MONSTER BGSD CHARA     ", $F0

String_08_00_04:: ; heuristic: string; C0
Data_008_4AAC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ? AUTOMAP ?                   KEY  ", $A3, "          KEYID", $A3, "  "
    db "        LEVEL", $A3, "          POS X", $A3, "          POS Y", $A3, "        "
    db "  NOT DATA", $9F, $F0

String_08_00_05:: ; heuristic: string; C0
Data_008_4B26:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ? SOUND ?", $F1
    db $F1
    db "  BGM", $F1
    db "   SE", $F0

String_08_00_07:: ; heuristic: string; C0
Data_008_4B3F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "? GOTOPRG ?", $F1
    db $F1
    db $F1
    db " PRGNO1", $F1
    db " PRGNO2", $F1
    db " PRGNO3", $F0

String_08_00_08:: ; heuristic: string; C0
Data_008_4B65:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No more", $A4, $F0

String_08_00_09:: ; heuristic: string; C0
Data_008_4B6E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "? BATTLE ?", $F1
    db "No. foes", $F1
    db "Monster 1", $F1
    db "Monster 2", $F1
    db "Monster 3", $F1
    db "Debug", $F1
    db "Skill ID", $F1
    db "Species", $F1
    db "Level", $F0

String_08_00_0A:: ; heuristic: string; C0
Data_008_4BBD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MonsterFarm", $F0

String_08_00_0B:: ; heuristic: string; C0
Data_008_4BC9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatLog", $F0

String_08_00_0C:: ; heuristic: string; C0
Data_008_4BD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Main Street", $F0

String_08_00_0D:: ; heuristic: string; C0
Data_008_4BDE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door", $F0

String_08_00_0E:: ; heuristic: string; C0
Data_008_4BE9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reception", $F0

String_08_00_0F:: ; heuristic: string; C0
Data_008_4BF3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log's Navel", $F0

String_08_00_10:: ; heuristic: string; C0
Data_008_4BFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Home", $F0

String_08_00_11:: ; heuristic: string; C0
Data_008_4C03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stable", $F0

String_08_00_12:: ; heuristic: string; C0
Data_008_4C0A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Vault", $F0

String_08_00_13:: ; heuristic: string; C0
Data_008_4C10:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key Shop", $F0

String_08_00_14:: ; heuristic: string; C0
Data_008_4C19:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Evaluator", $F0

String_08_00_15:: ; heuristic: string; C0
Data_008_4C23:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Residences", $F0

String_08_00_17:: ; heuristic: string; C0
Data_008_4C2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starry ", $59, $F0

String_08_00_18:: ; heuristic: string; C0
Data_008_4C37:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Family Rm.", $F0

String_08_00_19:: ; heuristic: string; C0
Data_008_4C42:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Guy's Rm.", $F0

String_08_00_1A:: ; heuristic: string; C0
Data_008_4C4B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lady's Rm.", $F0

String_08_00_1B:: ; heuristic: string; C0
Data_008_4C55:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Library", $F0

String_08_00_1C:: ; heuristic: string; C0
Data_008_4C5D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Girl's Rm.", $F0

String_08_00_1D:: ; heuristic: string; C0
Data_008_4C67:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Christener", $F0

String_08_00_1E:: ; heuristic: string; C0
Data_008_4C72:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Background", $F0

String_08_00_1F:: ; heuristic: string; C0
Data_008_4C7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Old man's", $F0

String_08_00_20:: ; heuristic: string; C0
Data_008_4C86:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Medal man", $F0

String_08_00_21:: ; heuristic: string; C0
Data_008_4C90:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tavern", $F0

String_08_00_22:: ; heuristic: string; C0
Data_008_4C97:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Arena", $F0

String_08_00_23:: ; heuristic: string; C0
Data_008_4C9D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatLog ", $58, $F0

String_08_00_24:: ; heuristic: string; C0
Data_008_4CA8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Treetop", $F0

String_08_00_25:: ; heuristic: string; C0
Data_008_4CB0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log's nut", $F0

String_08_00_26:: ; heuristic: string; C0
Data_008_4CB9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log's view", $F0

String_08_00_27:: ; heuristic: string; C0
Data_008_4CC3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Deck", $F0

String_08_00_28:: ; heuristic: string; C0
Data_008_4CC8:: ; address name
    db $17, $18, $F0

String_08_00_2A:: ; heuristic: string; C0
Data_008_4CCB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Desert ", $5C, $F0

String_08_00_2B:: ; heuristic: string; C0
Data_008_4CD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kalka ", $57, $F0

String_08_00_2C:: ; heuristic: string; C0
Data_008_4CDC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kalka inn", $F0

String_08_00_2D:: ; heuristic: string; C0
Data_008_4CE6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Asiya inn", $F0

String_08_00_2E:: ; heuristic: string; C0
Data_008_4CF0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Asiya ", $57, $F0

String_08_00_2F:: ; heuristic: string; C0
Data_008_4CF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Asiya ", $58, $F0

String_08_00_30:: ; heuristic: string; C0
Data_008_4D00:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Desert King", $F0

String_08_00_31:: ; heuristic: string; C0
Data_008_4D0C:: ; address name
    db $17, $18, $F0

String_08_00_32:: ; heuristic: string; C0
Data_008_4D0F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hideout", $F0

String_08_00_33:: ; heuristic: string; C0
Data_008_4D17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_34:: ; heuristic: string; C0
Data_008_4D24:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CanalGate", $F0

String_08_00_35:: ; heuristic: string; C0
Data_008_4D2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Canal", $F0

String_08_00_36:: ; heuristic: string; C0
Data_008_4D34:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Not yet!", $F0

String_08_00_37:: ; heuristic: string; C0
Data_008_4D3D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dungeon", $F1

String_08_00_38:: ; heuristic: string; C0
Data_008_4D45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Treasury", $F1

String_08_00_39:: ; heuristic: string; C0
Data_008_4D4E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mirage Lake", $F1

String_08_00_3A:: ; heuristic: string; C0
Data_008_4D5A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Water ", $5C, $F0

String_08_00_3B:: ; heuristic: string; C0
Data_008_4D62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yold ", $57, $F0

String_08_00_3C:: ; heuristic: string; C0
Data_008_4D69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pt.Ritz ", $57, $F0

String_08_00_3D:: ; heuristic: string; C0
Data_008_4D73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pt.Ritz pub", $F0

String_08_00_3E:: ; heuristic: string; C0
Data_008_4D7F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pt.Ritz inn", $F0

String_08_00_3F:: ; heuristic: string; C0
Data_008_4D8B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cape ", $5A, $F0

String_08_00_40:: ; heuristic: string; C0
Data_008_4D92:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship ramp", $F0

String_08_00_41:: ; heuristic: string; C0
Data_008_4D9C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship 1F", $F0

String_08_00_42:: ; heuristic: string; C0
Data_008_4DA4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Volcano", $5A, "1F", $F0

String_08_00_43:: ; heuristic: string; C0
Data_008_4DAF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Volcano", $5A, "B1F", $F0

String_08_00_44:: ; heuristic: string; C0
Data_008_4DBB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Volcano", $5A, "B2F", $F0

String_08_00_45:: ; heuristic: string; C0
Data_008_4DC7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Loot vault", $F0

String_08_00_46:: ; heuristic: string; C0
Data_008_4DD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Polona ", $57, $F0

String_08_00_47:: ; heuristic: string; C0
Data_008_4DDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Polona inn", $F0

String_08_00_48:: ; heuristic: string; C0
Data_008_4DE6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lighthouse", $F0

String_08_00_49:: ; heuristic: string; C0
Data_008_4DF1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lighthouse", $F0

String_08_00_4A:: ; heuristic: string; C0
Data_008_4DFC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pinnacle", $F0

String_08_00_4B:: ; heuristic: string; C0
Data_008_4E05:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mermaid ", $5C, $F0

String_08_00_4C:: ; heuristic: string; C0
Data_008_4E0F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship 2F", $F0

String_08_00_4D:: ; heuristic: string; C0
Data_008_4E17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship deck", $F0

String_08_00_4E:: ; heuristic: string; C0
Data_008_4E21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Capt's qtr.", $F0

String_08_00_4F:: ; heuristic: string; C0
Data_008_4E2C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_50:: ; heuristic: string; C0
Data_008_4E39:: ; address name
    db $17, $18, $F0

String_08_00_52:: ; heuristic: string; C0
Data_008_4E3C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ice ", $5C, $F0

String_08_00_53:: ; heuristic: string; C0
Data_008_4E42:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spring", $F0

String_08_00_54:: ; heuristic: string; C0
Data_008_4E49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Norden ", $57, $F0

String_08_00_55:: ; heuristic: string; C0
Data_008_4E52:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Norden inn", $F0

String_08_00_56:: ; heuristic: string; C0
Data_008_4E5D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Norden ", $58, $F0

String_08_00_57:: ; heuristic: string; C0
Data_008_4E66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Norden jail", $F0

String_08_00_58:: ; heuristic: string; C0
Data_008_4E72:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "N tunnel", $F0

String_08_00_59:: ; heuristic: string; C0
Data_008_4E7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Nofor ", $57, $F0

String_08_00_5A:: ; heuristic: string; C0
Data_008_4E83:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Nofor pub", $F0

String_08_00_5B:: ; heuristic: string; C0
Data_008_4E8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Nofor inn", $F0

String_08_00_5C:: ; heuristic: string; C0
Data_008_4E97:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Border mine", $F0

String_08_00_5D:: ; heuristic: string; C0
Data_008_4EA3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine", $F0

String_08_00_5E:: ; heuristic: string; C0
Data_008_4EA8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine rm.", $F0

String_08_00_5F:: ; heuristic: string; C0
Data_008_4EB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine rm.", $F0

String_08_00_60:: ; heuristic: string; C0
Data_008_4EBA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine rm.", $F0

String_08_00_61:: ; heuristic: string; C0
Data_008_4EC3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gold mine", $F0

String_08_00_62:: ; heuristic: string; C0
Data_008_4ECD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Weston ", $57, $F0

String_08_00_63:: ; heuristic: string; C0
Data_008_4ED6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Weston inn", $F0

String_08_00_64:: ; heuristic: string; C0
Data_008_4EE1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Westania ", $58, $F0

String_08_00_65:: ; heuristic: string; C0
Data_008_4EEC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Westania ", $58, $F0

String_08_00_66:: ; heuristic: string; C0
Data_008_4EF7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yuna's rm.", $F0

String_08_00_67:: ; heuristic: string; C0
Data_008_4F01:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "S forest", $F0

String_08_00_68:: ; heuristic: string; C0
Data_008_4F0A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Estria  ", $58, $F0

String_08_00_69:: ; heuristic: string; C0
Data_008_4F14:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Estria inn", $F0

String_08_00_6A:: ; heuristic: string; C0
Data_008_4F1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Estria ", $58, $F0

String_08_00_6B:: ; heuristic: string; C0
Data_008_4F28:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Queen's rm.", $F0

String_08_00_6C:: ; heuristic: string; C0
Data_008_4F33:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "N mountain", $F0

String_08_00_6D:: ; heuristic: string; C0
Data_008_4F3E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lake ", $5D, " 1F", $F0

String_08_00_6E:: ; heuristic: string; C0
Data_008_4F48:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lake ", $5D, " 2F", $F0

String_08_00_6F:: ; heuristic: string; C0
Data_008_4F52:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lake ", $5D, " 3F", $F0

String_08_00_70:: ; heuristic: string; C0
Data_008_4F5C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lake ", $5D, " 4F", $F0

String_08_00_71:: ; heuristic: string; C0
Data_008_4F66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lake ", $5D, " 5F", $F0

String_08_00_72:: ; heuristic: string; C0
Data_008_4F70:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_73:: ; heuristic: string; C0
Data_008_4F7D:: ; address name
    db $17, $18, $F0

String_08_00_7A:: ; heuristic: string; C0
Data_008_4F80:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Float ", $5C, $F0

String_08_00_7B:: ; heuristic: string; C0
Data_008_4F88:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fhunt ", $57, $F0

String_08_00_7C:: ; heuristic: string; C0
Data_008_4F90:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fhunt inn", $F0

String_08_00_7D:: ; heuristic: string; C0
Data_008_4F9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sage ", $5D, " 1F", $F0

String_08_00_7E:: ; heuristic: string; C0
Data_008_4FA4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sage ", $5D, " 2F", $F0

String_08_00_7F:: ; heuristic: string; C0
Data_008_4FAE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sage ", $5D, " 3F", $F0

String_08_00_80:: ; heuristic: string; C0
Data_008_4FB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sage ", $5D, " 4F", $F0

String_08_00_81:: ; heuristic: string; C0
Data_008_4FC2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rope bridge", $F0

String_08_00_82:: ; heuristic: string; C0
Data_008_4FCE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pei ", $57, $F0

String_08_00_83:: ; heuristic: string; C0
Data_008_4FD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pei inn", $F0

String_08_00_84:: ; heuristic: string; C0
Data_008_4FDC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "W mountain", $F0

String_08_00_85:: ; heuristic: string; C0
Data_008_4FE7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "W tunnel", $F0

String_08_00_86:: ; heuristic: string; C0
Data_008_4FF0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano ", $57, $F0

String_08_00_87:: ; heuristic: string; C0
Data_008_4FF9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano inn", $F0

String_08_00_88:: ; heuristic: string; C0
Data_008_5004:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano pub", $F0

String_08_00_89:: ; heuristic: string; C0
Data_008_500F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano ", $58, $F0

String_08_00_8A:: ; heuristic: string; C0
Data_008_5018:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rope bridge", $F0

String_08_00_8B:: ; heuristic: string; C0
Data_008_5024:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small ", $5A, $F0

String_08_00_8C:: ; heuristic: string; C0
Data_008_502C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small ", $5A, " B1F", $F0

String_08_00_8D:: ; heuristic: string; C0
Data_008_5038:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small ", $5A, " B2F", $F0

String_08_00_8E:: ; heuristic: string; C0
Data_008_5044:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Boss Rm.", $F0

String_08_00_8F:: ; heuristic: string; C0
Data_008_504D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wind ", $5D, " 1F", $F0

String_08_00_90:: ; heuristic: string; C0
Data_008_5057:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wind ", $5D, " 2F", $F0

String_08_00_91:: ; heuristic: string; C0
Data_008_5061:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wind ", $5D, " 3F", $F0

String_08_00_92:: ; heuristic: string; C0
Data_008_506B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wind ", $5D, " 4F", $F0

String_08_00_93:: ; heuristic: string; C0
Data_008_5075:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sage ", $5D, $F0

String_08_00_94:: ; heuristic: string; C0
Data_008_507C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dead ", $58, $F0

String_08_00_95:: ; heuristic: string; C0
Data_008_5083:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cathedral", $F0

String_08_00_96:: ; heuristic: string; C0
Data_008_508D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Corridor", $F0

String_08_00_97:: ; heuristic: string; C0
Data_008_5096:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Morgue", $F0

String_08_00_98:: ; heuristic: string; C0
Data_008_509D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cemetery", $F0

String_08_00_99:: ; heuristic: string; C0
Data_008_50A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Music rm.", $F0

String_08_00_9A:: ; heuristic: string; C0
Data_008_50B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Corridor", $F0

String_08_00_9B:: ; heuristic: string; C0
Data_008_50B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dead rm.", $F0

String_08_00_9C:: ; heuristic: string; C0
Data_008_50C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "North ", $59, $F0

String_08_00_9D:: ; heuristic: string; C0
Data_008_50CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon ", $58, $F0

String_08_00_9E:: ; heuristic: string; C0
Data_008_50D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon ", $58, " 1F", $F0

String_08_00_9F:: ; heuristic: string; C0
Data_008_50DD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon ", $58, " B1F", $F0

String_08_00_A0:: ; heuristic: string; C0
Data_008_50E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon ", $58, " B2F", $F0

String_08_00_A1:: ; heuristic: string; C0
Data_008_50F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon ", $58, " B3F", $F0

String_08_00_A2:: ; heuristic: string; C0
Data_008_5101:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon ", $58, " B4F", $F0

String_08_00_A3:: ; heuristic: string; C0
Data_008_510D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon ", $58, " B5F", $F0

String_08_00_A4:: ; heuristic: string; C0
Data_008_5119:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon ", $58, " B6F", $F0

String_08_00_A5:: ; heuristic: string; C0
Data_008_5125:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon hall", $F0

String_08_00_A6:: ; heuristic: string; C0
Data_008_5130:: ; address name
    db $17, $18, $F0

String_08_00_A7:: ; heuristic: string; C0
Data_008_5133:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_A8:: ; heuristic: string; C0
Data_008_5140:: ; address name
    db $17, $18, $F0

String_08_00_AA:: ; heuristic: string; C0
Data_008_5143:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Limbo ", $5C, $F0

String_08_00_AB:: ; heuristic: string; C0
Data_008_514B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stairway", $F0

String_08_00_AC:: ; heuristic: string; C0
Data_008_5154:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Darck Manor", $F0

String_08_00_AD:: ; heuristic: string; C0
Data_008_5160:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gallery", $F0

String_08_00_AE:: ; heuristic: string; C0
Data_008_5168:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_AF:: ; heuristic: string; C0
Data_008_5175:: ; address name
    db $17, $18, $F0

String_08_00_B2:: ; heuristic: string; C0
Data_008_5178:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Elven ", $5C, $F0

String_08_00_B3:: ; heuristic: string; C0
Data_008_5180:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Elven ", $57, $F0

String_08_00_B4:: ; heuristic: string; C0
Data_008_5188:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "W forest", $F0

String_08_00_B5:: ; heuristic: string; C0
Data_008_5191:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lookout", $F0

String_08_00_B6:: ; heuristic: string; C0
Data_008_5199:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summit", $F0

String_08_00_B7:: ; heuristic: string; C0
Data_008_51A0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mt. base", $F0

String_08_00_B8:: ; heuristic: string; C0
Data_008_51A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PlatinumMt.", $F0

String_08_00_B9:: ; heuristic: string; C0
Data_008_51B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_BA:: ; heuristic: string; C0
Data_008_51C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lonely ", $5C, $F0

String_08_00_BB:: ; heuristic: string; C0
Data_008_51CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kiral Lab", $F0

String_08_00_BC:: ; heuristic: string; C0
Data_008_51D5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_BD:: ; heuristic: string; C0
Data_008_51E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lab B1F", $F0

String_08_00_BE:: ; heuristic: string; C0
Data_008_51EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lab B2F", $F0

String_08_00_BF:: ; heuristic: string; C0
Data_008_51F2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lab B3F", $F0

String_08_00_C0:: ; heuristic: string; C0
Data_008_51FA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Barrel rm.", $F0

String_08_00_C1:: ; heuristic: string; C0
Data_008_5205:: ; address name
    db $17, $18, $F0

String_08_00_C2:: ; heuristic: string; C0
Data_008_5208:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Traveler ", $5C, $F0

String_08_00_C3:: ; heuristic: string; C0
Data_008_5213:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Miagen ", $57, $F0

String_08_00_C4:: ; heuristic: string; C0
Data_008_521C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Travel hut", $F0

String_08_00_C5:: ; heuristic: string; C0
Data_008_5227:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "N forest", $F0

String_08_00_C6:: ; heuristic: string; C0
Data_008_5230:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inn", $F0

String_08_00_C7:: ; heuristic: string; C0
Data_008_5234:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $5D, " summit", $F0

String_08_00_C8:: ; heuristic: string; C0
Data_008_523D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Old ", $5D, " 1F", $F0

String_08_00_C9:: ; heuristic: string; C0
Data_008_5246:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Old ", $5D, " 2F", $F0

String_08_00_CA:: ; heuristic: string; C0
Data_008_524F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Old ", $5D, " 3F", $F0

String_08_00_CB:: ; heuristic: string; C0
Data_008_5258:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Old ", $5D, " 4F", $F0

String_08_00_CC:: ; heuristic: string; C0
Data_008_5261:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Old ", $5D, " 5F", $F0

String_08_00_CD:: ; heuristic: string; C0
Data_008_526A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Old ", $5D, " 6F", $F0

String_08_00_CE:: ; heuristic: string; C0
Data_008_5273:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Old ", $5D, " 7F", $F0

String_08_00_CF:: ; heuristic: string; C0
Data_008_527C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_D0:: ; heuristic: string; C0
Data_008_5289:: ; address name
    db $17, $18, $F0

String_08_00_D2:: ; heuristic: string; C0
Data_008_528C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Power ", $5C, $F0

String_08_00_D3:: ; heuristic: string; C0
Data_008_5294:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Power ", $5D, " 1F", $F0

String_08_00_D4:: ; heuristic: string; C0
Data_008_529F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Power ", $5D, " 2F", $F0

String_08_00_D5:: ; heuristic: string; C0
Data_008_52AA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Power ", $5D, " 3F", $F0

String_08_00_D6:: ; heuristic: string; C0
Data_008_52B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Power ", $5D, " 4F", $F0

String_08_00_D7:: ; heuristic: string; C0
Data_008_52C0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Power ", $5D, " 5F", $F0

String_08_00_D8:: ; heuristic: string; C0
Data_008_52CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Power ", $5D, " 6F", $F0

String_08_00_D9:: ; heuristic: string; C0
Data_008_52D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Power ", $5D, " 7F", $F0

String_08_00_DA:: ; heuristic: string; C0
Data_008_52E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_DB:: ; heuristic: string; C0
Data_008_52EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baffle ", $5C, $F0

String_08_00_DC:: ; heuristic: string; C0
Data_008_52F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baffle ", $5D, " 1F", $F0

String_08_00_DD:: ; heuristic: string; C0
Data_008_5303:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baffle ", $5D, " 2F", $F0

String_08_00_DE:: ; heuristic: string; C0
Data_008_530F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baffle ", $5D, " 3F", $F0

String_08_00_DF:: ; heuristic: string; C0
Data_008_531B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baffle ", $5D, " 4F", $F0

String_08_00_E0:: ; heuristic: string; C0
Data_008_5327:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baffle ", $5D, " 5F", $F0

String_08_00_E1:: ; heuristic: string; C0
Data_008_5333:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baffle ", $5D, " 6F", $F0

String_08_00_E2:: ; heuristic: string; C0
Data_008_533F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baffle ", $5D, " 7F", $F0

String_08_00_E3:: ; heuristic: string; C0
Data_008_534B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_E4:: ; heuristic: string; C0
Data_008_5358:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soul ", $5C, $F0

String_08_00_E5:: ; heuristic: string; C0
Data_008_535F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soul ", $5D, " 1F", $F0

String_08_00_E6:: ; heuristic: string; C0
Data_008_5369:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soul ", $5D, " 2F", $F0

String_08_00_E7:: ; heuristic: string; C0
Data_008_5373:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soul ", $5D, " 3F", $F0

String_08_00_E8:: ; heuristic: string; C0
Data_008_537D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soul ", $5D, " 4F", $F0

String_08_00_E9:: ; heuristic: string; C0
Data_008_5387:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soul ", $5D, " 5F", $F0

String_08_00_EA:: ; heuristic: string; C0
Data_008_5391:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soul ", $5D, " 6F", $F0

String_08_00_EB:: ; heuristic: string; C0
Data_008_539B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Soul ", $5D, " 7F", $F0

String_08_00_EC:: ; heuristic: string; C0
Data_008_53A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door ", $59, $F0

String_08_00_ED:: ; heuristic: string; C0
Data_008_53B2:: ; address name
    db $17, $18, $F0

String_08_01_00:: ; heuristic: string; C0
Data_008_53B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slime", $F0

String_08_01_01:: ; heuristic: string; C0
Data_008_53BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dragon", $F0

String_08_01_02:: ; heuristic: string; C0
Data_008_53C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beast", $F0

String_08_01_03:: ; heuristic: string; C0
Data_008_53C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bird", $F0

String_08_01_04:: ; heuristic: string; C0
Data_008_53CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Plant", $F0

String_08_01_05:: ; heuristic: string; C0
Data_008_53D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bug", $F0

String_08_01_06:: ; heuristic: string; C0
Data_008_53D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon", $F0

String_08_01_07:: ; heuristic: string; C0
Data_008_53DD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Zombie", $F0

String_08_01_08:: ; heuristic: string; C0
Data_008_53E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Material", $F0

String_08_01_09:: ; heuristic: string; C0
Data_008_53ED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Water", $F0

String_08_01_0A:: ; heuristic: string; C0
Data_008_53F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "????", $F0

String_08_02_00:: ; heuristic: string; C0
Data_008_53F8:: ; address name
    db $F0

String_08_02_01:: ; heuristic: string; C0
Data_008_53F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DrakSlime", $F0

String_08_02_02:: ; heuristic: string; C0
Data_008_5403:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpotSlime", $F0

String_08_02_03:: ; heuristic: string; C0
Data_008_540D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WingSlime", $F0

String_08_02_04:: ; heuristic: string; C0
Data_008_5417:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TreeSlime", $F0

String_08_02_05:: ; heuristic: string; C0
Data_008_5421:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snaily", $F0

String_08_02_06:: ; heuristic: string; C0
Data_008_5428:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SlimeNite", $F0

String_08_02_07:: ; heuristic: string; C0
Data_008_5432:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Babble", $F0

String_08_02_08:: ; heuristic: string; C0
Data_008_5439:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BoxSlime", $F0

String_08_02_09:: ; heuristic: string; C0
Data_008_5442:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PearlGel", $F0

String_08_02_0A:: ; heuristic: string; C0
Data_008_544B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slime", $F0

String_08_02_0B:: ; heuristic: string; C0
Data_008_5451:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Healer", $F0

String_08_02_0C:: ; heuristic: string; C0
Data_008_5458:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FangSlime", $F0

String_08_02_0D:: ; heuristic: string; C0
Data_008_5462:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RockSlime", $F0

String_08_02_0E:: ; heuristic: string; C0
Data_008_546C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SlimeBorg", $F0

String_08_02_0F:: ; heuristic: string; C0
Data_008_5476:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slabbit", $F0

String_08_02_10:: ; heuristic: string; C0
Data_008_547E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingSlime", $F0

String_08_02_11:: ; heuristic: string; C0
Data_008_5488:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Metaly", $F0

String_08_02_12:: ; heuristic: string; C0
Data_008_548F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Metabble", $F0

String_08_02_13:: ; heuristic: string; C0
Data_008_5498:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpotKing", $F0

String_08_02_14:: ; heuristic: string; C0
Data_008_54A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TropicGel", $F0

String_08_02_15:: ; heuristic: string; C0
Data_008_54AB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MimeSlime", $F0

String_08_02_16:: ; heuristic: string; C0
Data_008_54B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HaloSlime", $F0

String_08_02_17:: ; heuristic: string; C0
Data_008_54BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MetalKing", $F0

String_08_02_18:: ; heuristic: string; C0
Data_008_54C9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldSlime", $F0

String_08_02_19:: ; heuristic: string; C0
Data_008_54D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GranSlime", $F0

String_08_02_1A:: ; heuristic: string; C0
Data_008_54DD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WonderEgg", $F0

String_08_02_1B:: ; heuristic: string; C0
Data_008_54E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Butch", $F0

String_08_02_1C:: ; heuristic: string; C0
Data_008_54ED:: ; address name
    db $98, $F0

String_08_02_24:: ; heuristic: string; C0
Data_008_54EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DragonKid", $F0

String_08_02_25:: ; heuristic: string; C0
Data_008_54F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tortragon", $F0

String_08_02_26:: ; heuristic: string; C0
Data_008_5503:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pteranod", $F0

String_08_02_27:: ; heuristic: string; C0
Data_008_550C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gasgon", $F0

String_08_02_28:: ; heuristic: string; C0
Data_008_5513:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FairyDrak", $F0

String_08_02_29:: ; heuristic: string; C0
Data_008_551D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LizardMan", $F0

String_08_02_2A:: ; heuristic: string; C0
Data_008_5527:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Poisongon", $F0

String_08_02_2B:: ; heuristic: string; C0
Data_008_5531:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swordgon", $F0

String_08_02_2C:: ; heuristic: string; C0
Data_008_553A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drygon", $F0

String_08_02_2D:: ; heuristic: string; C0
Data_008_5541:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dragon", $F0

String_08_02_2E:: ; heuristic: string; C0
Data_008_5548:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MiniDrak", $F0

String_08_02_2F:: ; heuristic: string; C0
Data_008_5551:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadDragon", $F0

String_08_02_30:: ; heuristic: string; C0
Data_008_555B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rayburn", $F0

String_08_02_31:: ; heuristic: string; C0
Data_008_5563:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Chamelgon", $F0

String_08_02_32:: ; heuristic: string; C0
Data_008_556D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LizardFly", $F0

String_08_02_33:: ; heuristic: string; C0
Data_008_5577:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Andreal", $F0

String_08_02_34:: ; heuristic: string; C0
Data_008_557F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingCobra", $F0

String_08_02_35:: ; heuristic: string; C0
Data_008_5589:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Vampirus", $F0

String_08_02_36:: ; heuristic: string; C0
Data_008_5592:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SnakeBat", $F0

String_08_02_37:: ; heuristic: string; C0
Data_008_559B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spikerous", $F0

String_08_02_38:: ; heuristic: string; C0
Data_008_55A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatDrak", $F0

String_08_02_39:: ; heuristic: string; C0
Data_008_55AF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Crestpent", $F0

String_08_02_3A:: ; heuristic: string; C0
Data_008_55B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WingSnake", $F0

String_08_02_3B:: ; heuristic: string; C0
Data_008_55C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Coatol", $F0

String_08_02_3C:: ; heuristic: string; C0
Data_008_55CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orochi", $F0

String_08_02_3D:: ; heuristic: string; C0
Data_008_55D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BattleRex", $F0

String_08_02_3E:: ; heuristic: string; C0
Data_008_55DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SkyDragon", $F0

String_08_02_3F:: ; heuristic: string; C0
Data_008_55E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Serpentia", $F0

String_08_02_40:: ; heuristic: string; C0
Data_008_55EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Divinegon", $F0

String_08_02_41:: ; heuristic: string; C0
Data_008_55F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orligon", $F0

String_08_02_42:: ; heuristic: string; C0
Data_008_5601:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GigaDraco", $F0

String_08_02_43:: ; heuristic: string; C0
Data_008_560B:: ; address name
    db $98, $F0

String_08_02_47:: ; heuristic: string; C0
Data_008_560D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tonguella", $F0

String_08_02_48:: ; heuristic: string; C0
Data_008_5617:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Almiraj", $F0

String_08_02_49:: ; heuristic: string; C0
Data_008_561F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CatFly", $F0

String_08_02_4A:: ; heuristic: string; C0
Data_008_5626:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PillowRat", $F0

String_08_02_4B:: ; heuristic: string; C0
Data_008_5630:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Saccer", $F0

String_08_02_4C:: ; heuristic: string; C0
Data_008_5637:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GulpBeast", $F0

String_08_02_4D:: ; heuristic: string; C0
Data_008_5641:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skullroo", $F0

String_08_02_4E:: ; heuristic: string; C0
Data_008_564A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WindBeast", $F0

String_08_02_4F:: ; heuristic: string; C0
Data_008_5654:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beavern", $F0

String_08_02_50:: ; heuristic: string; C0
Data_008_565C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Antbear", $F0

String_08_02_51:: ; heuristic: string; C0
Data_008_5664:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SuperTen", $F0

String_08_02_52:: ; heuristic: string; C0
Data_008_566D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IronTurt", $F0

String_08_02_53:: ; heuristic: string; C0
Data_008_5676:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mommonja", $F0

String_08_02_54:: ; heuristic: string; C0
Data_008_567F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HammerMan", $F0

String_08_02_55:: ; heuristic: string; C0
Data_008_5689:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grizzly", $F0

String_08_02_56:: ; heuristic: string; C0
Data_008_5691:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yeti", $F0

String_08_02_57:: ; heuristic: string; C0
Data_008_5696:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArrowDog", $F0

String_08_02_58:: ; heuristic: string; C0
Data_008_569F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "NoctoKing", $F0

String_08_02_59:: ; heuristic: string; C0
Data_008_56A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeastNite", $F0

String_08_02_5A:: ; heuristic: string; C0
Data_008_56B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadGopher", $F0

String_08_02_5B:: ; heuristic: string; C0
Data_008_56BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FairyRat", $F0

String_08_02_5C:: ; heuristic: string; C0
Data_008_56C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Unicorn", $F0

String_08_02_5D:: ; heuristic: string; C0
Data_008_56CE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Goategon", $F0

String_08_02_5E:: ; heuristic: string; C0
Data_008_56D7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WildApe", $F0

String_08_02_5F:: ; heuristic: string; C0
Data_008_56DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Trumpeter", $F0

String_08_02_60:: ; heuristic: string; C0
Data_008_56E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingLeo", $F0

String_08_02_61:: ; heuristic: string; C0
Data_008_56F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkHorn", $F0

String_08_02_62:: ; heuristic: string; C0
Data_008_56FA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCat", $F0

String_08_02_63:: ; heuristic: string; C0
Data_008_5701:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BigEye", $F0

String_08_02_64:: ; heuristic: string; C0
Data_008_5708:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gorago", $F0

String_08_02_65:: ; heuristic: string; C0
Data_008_570F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CatMage", $F0

String_08_02_66:: ; heuristic: string; C0
Data_008_5717:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dumbira", $F0

String_08_02_67:: ; heuristic: string; C0
Data_008_571F:: ; address name
    db $98, $F0

String_08_02_6A:: ; heuristic: string; C0
Data_008_5721:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Picky", $F0

String_08_02_6B:: ; heuristic: string; C0
Data_008_5727:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wyvern", $F0

String_08_02_6C:: ; heuristic: string; C0
Data_008_572E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BullBird", $F0

String_08_02_6D:: ; heuristic: string; C0
Data_008_5737:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Florajay", $F0

String_08_02_6E:: ; heuristic: string; C0
Data_008_5740:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DuckKite", $F0

String_08_02_6F:: ; heuristic: string; C0
Data_008_5749:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadPecker", $F0

String_08_02_70:: ; heuristic: string; C0
Data_008_5753:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadRaven", $F0

String_08_02_71:: ; heuristic: string; C0
Data_008_575C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MistyWing", $F0

String_08_02_72:: ; heuristic: string; C0
Data_008_5766:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AquaHawk", $F0

String_08_02_73:: ; heuristic: string; C0
Data_008_576F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dracky", $F0

String_08_02_74:: ; heuristic: string; C0
Data_008_5776:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KiteHawk", $F0

String_08_02_75:: ; heuristic: string; C0
Data_008_577F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BigRoost", $F0

String_08_02_76:: ; heuristic: string; C0
Data_008_5788:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StubBird", $F0

String_08_02_77:: ; heuristic: string; C0
Data_008_5791:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LandOwl", $F0

String_08_02_78:: ; heuristic: string; C0
Data_008_5799:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadGoose", $F0

String_08_02_79:: ; heuristic: string; C0
Data_008_57A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCondor", $F0

String_08_02_7A:: ; heuristic: string; C0
Data_008_57AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Emyu", $F0

String_08_02_7B:: ; heuristic: string; C0
Data_008_57B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blizzardy", $F0

String_08_02_7C:: ; heuristic: string; C0
Data_008_57BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Phoenix", $F0

String_08_02_7D:: ; heuristic: string; C0
Data_008_57C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ZapBird", $F0

String_08_02_7E:: ; heuristic: string; C0
Data_008_57CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Garudian", $F0

String_08_02_7F:: ; heuristic: string; C0
Data_008_57D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhipBird", $F0

String_08_02_80:: ; heuristic: string; C0
Data_008_57DD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FunkyBird", $F0

String_08_02_81:: ; heuristic: string; C0
Data_008_57E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RainHawk", $F0

String_08_02_82:: ; heuristic: string; C0
Data_008_57F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Azurile", $F0

String_08_02_83:: ; heuristic: string; C0
Data_008_57F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shantak", $F0

String_08_02_84:: ; heuristic: string; C0
Data_008_5800:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CragDevil", $F0

String_08_02_85:: ; heuristic: string; C0
Data_008_580A:: ; address name
    db $98, $F0

String_08_02_8D:: ; heuristic: string; C0
Data_008_580C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadPlant", $F0

String_08_02_8E:: ; heuristic: string; C0
Data_008_5815:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FireWeed", $F0

String_08_02_8F:: ; heuristic: string; C0
Data_008_581E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FloraMan", $F0

String_08_02_90:: ; heuristic: string; C0
Data_008_5827:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WingTree", $F0

String_08_02_91:: ; heuristic: string; C0
Data_008_5830:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CactiBall", $F0

String_08_02_92:: ; heuristic: string; C0
Data_008_583A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gulpple", $F0

String_08_02_93:: ; heuristic: string; C0
Data_008_5842:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Toadstool", $F0

String_08_02_94:: ; heuristic: string; C0
Data_008_584C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AmberWeed", $F0

String_08_02_95:: ; heuristic: string; C0
Data_008_5856:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slurperon", $F0

String_08_02_96:: ; heuristic: string; C0
Data_008_5860:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stubsuck", $F0

String_08_02_97:: ; heuristic: string; C0
Data_008_5869:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Oniono", $F0

String_08_02_98:: ; heuristic: string; C0
Data_008_5870:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DanceVegi", $F0

String_08_02_99:: ; heuristic: string; C0
Data_008_587A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TreeBoy", $F0

String_08_02_9A:: ; heuristic: string; C0
Data_008_5882:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Devipine", $F0

String_08_02_9B:: ; heuristic: string; C0
Data_008_588B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FaceTree", $F0

String_08_02_9C:: ; heuristic: string; C0
Data_008_5894:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HerbMan", $F0

String_08_02_9D:: ; heuristic: string; C0
Data_008_589C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeanMan", $F0

String_08_02_9E:: ; heuristic: string; C0
Data_008_58A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilSeed", $F0

String_08_02_9F:: ; heuristic: string; C0
Data_008_58AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ManEater", $F0

String_08_02_A0:: ; heuristic: string; C0
Data_008_58B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snapper", $F0

String_08_02_A1:: ; heuristic: string; C0
Data_008_58BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GhosTree", $F0

String_08_02_A2:: ; heuristic: string; C0
Data_008_58C7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rosevine", $F0

String_08_02_A3:: ; heuristic: string; C0
Data_008_58D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Egdracil", $F0

String_08_02_A4:: ; heuristic: string; C0
Data_008_58D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Warubou", $F0

String_08_02_A5:: ; heuristic: string; C0
Data_008_58E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Watabou", $F0

String_08_02_A6:: ; heuristic: string; C0
Data_008_58E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eggplaton", $F0

String_08_02_A7:: ; heuristic: string; C0
Data_008_58F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FooHero", $F0

String_08_02_A8:: ; heuristic: string; C0
Data_008_58FB:: ; address name
    db $98, $F0

String_08_02_B0:: ; heuristic: string; C0
Data_008_58FD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GiantSlug", $F0

String_08_02_B1:: ; heuristic: string; C0
Data_008_5907:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Catapila", $F0

String_08_02_B2:: ; heuristic: string; C0
Data_008_5910:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gophecada", $F0

String_08_02_B3:: ; heuristic: string; C0
Data_008_591A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Butterfly", $F0

String_08_02_B4:: ; heuristic: string; C0
Data_008_5924:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WeedBug", $F0

String_08_02_B5:: ; heuristic: string; C0
Data_008_592C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GiantWorm", $F0

String_08_02_B6:: ; heuristic: string; C0
Data_008_5936:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lipsy", $F0

String_08_02_B7:: ; heuristic: string; C0
Data_008_593C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StagBug", $F0

String_08_02_B8:: ; heuristic: string; C0
Data_008_5944:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pyuro", $F0

String_08_02_B9:: ; heuristic: string; C0
Data_008_594A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArmyAnt", $F0

String_08_02_BA:: ; heuristic: string; C0
Data_008_5952:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoHopper", $F0

String_08_02_BB:: ; heuristic: string; C0
Data_008_595B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TailEater", $F0

String_08_02_BC:: ; heuristic: string; C0
Data_008_5965:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArmorPede", $F0

String_08_02_BD:: ; heuristic: string; C0
Data_008_596F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eyeder", $F0

String_08_02_BE:: ; heuristic: string; C0
Data_008_5976:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GiantMoth", $F0

String_08_02_BF:: ; heuristic: string; C0
Data_008_5980:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Droll", $F0

String_08_02_C0:: ; heuristic: string; C0
Data_008_5986:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArmyCrab", $F0

String_08_02_C1:: ; heuristic: string; C0
Data_008_598F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadHornet", $F0

String_08_02_C2:: ; heuristic: string; C0
Data_008_5999:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Belzebub", $F0

String_08_02_C3:: ; heuristic: string; C0
Data_008_59A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WarMantis", $F0

String_08_02_C4:: ; heuristic: string; C0
Data_008_59AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HornBeet", $F0

String_08_02_C5:: ; heuristic: string; C0
Data_008_59B5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sickler", $F0

String_08_02_C6:: ; heuristic: string; C0
Data_008_59BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Armorpion", $F0

String_08_02_C7:: ; heuristic: string; C0
Data_008_59C7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Digster", $F0

String_08_02_C8:: ; heuristic: string; C0
Data_008_59CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skularach", $F0

String_08_02_C9:: ; heuristic: string; C0
Data_008_59D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MultiEyes", $F0

String_08_02_CA:: ; heuristic: string; C0
Data_008_59E3:: ; address name
    db $98, $F0

String_08_02_D3:: ; heuristic: string; C0
Data_008_59E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pixy", $F0

String_08_02_D4:: ; heuristic: string; C0
Data_008_59EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MedusaEye", $F0

String_08_02_D5:: ; heuristic: string; C0
Data_008_59F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AgDevil", $F0

String_08_02_D6:: ; heuristic: string; C0
Data_008_59FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demonite", $F0

String_08_02_D7:: ; heuristic: string; C0
Data_008_5A05:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkEye", $F0

String_08_02_D8:: ; heuristic: string; C0
Data_008_5A0D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EyeBall", $F0

String_08_02_D9:: ; heuristic: string; C0
Data_008_5A15:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SkulRider", $F0

String_08_02_DA:: ; heuristic: string; C0
Data_008_5A1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilBeast", $F0

String_08_02_DB:: ; heuristic: string; C0
Data_008_5A29:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bubblemon", $F0

String_08_02_DC:: ; heuristic: string; C0
Data_008_5A33:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "1EyeClown", $F0

String_08_02_DD:: ; heuristic: string; C0
Data_008_5A3D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gremlin", $F0

String_08_02_DE:: ; heuristic: string; C0
Data_008_5A45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ArcDemon", $F0

String_08_02_DF:: ; heuristic: string; C0
Data_008_5A4E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lionex", $F0

String_08_02_E0:: ; heuristic: string; C0
Data_008_5A55:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoatHorn", $F0

String_08_02_E1:: ; heuristic: string; C0
Data_008_5A5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orc", $F0

String_08_02_E2:: ; heuristic: string; C0
Data_008_5A62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ogre", $F0

String_08_02_E3:: ; heuristic: string; C0
Data_008_5A67:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GateGuard", $F0

String_08_02_E4:: ; heuristic: string; C0
Data_008_5A71:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ChopClown", $F0

String_08_02_E5:: ; heuristic: string; C0
Data_008_5A7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BossTroll", $F0

String_08_02_E6:: ; heuristic: string; C0
Data_008_5A85:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grendal", $F0

String_08_02_E7:: ; heuristic: string; C0
Data_008_5A8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Akubar", $F0

String_08_02_E8:: ; heuristic: string; C0
Data_008_5A94:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadKnight", $F0

String_08_02_E9:: ; heuristic: string; C0
Data_008_5A9E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilWell", $F0

String_08_02_EA:: ; heuristic: string; C0
Data_008_5AA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gigantes", $F0

String_08_02_EB:: ; heuristic: string; C0
Data_008_5AB0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Centasaur", $F0

String_08_02_EC:: ; heuristic: string; C0
Data_008_5ABA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilArmor", $F0

String_08_02_ED:: ; heuristic: string; C0
Data_008_5AC4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Jamirus", $F0

String_08_02_EE:: ; heuristic: string; C0
Data_008_5ACC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Durran", $F0

String_08_02_EF:: ; heuristic: string; C0
Data_008_5AD3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Titanis", $F0

String_08_02_F0:: ; heuristic: string; C0
Data_008_5ADB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LampGenie", $F0

String_08_02_F1:: ; heuristic: string; C0
Data_008_5AE5:: ; address name
    db $98, $F0

String_08_02_F6:: ; heuristic: string; C0
Data_008_5AE7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spooky", $F0

String_08_02_F7:: ; heuristic: string; C0
Data_008_5AEE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skullgon", $F0

String_08_02_F8:: ; heuristic: string; C0
Data_008_5AF7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PutrePup", $F0

String_08_02_F9:: ; heuristic: string; C0
Data_008_5B00:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RotRaven", $F0

String_08_02_FA:: ; heuristic: string; C0
Data_008_5B09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mummy", $F0

String_08_02_FB:: ; heuristic: string; C0
Data_008_5B0F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkCrab", $F0

String_08_02_FC:: ; heuristic: string; C0
Data_008_5B18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeadNite", $F0

String_08_02_FD:: ; heuristic: string; C0
Data_008_5B21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shadow", $F0

String_08_02_FE:: ; heuristic: string; C0
Data_008_5B28:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skulpent", $F0

String_08_02_FF:: ; heuristic: string; C0
Data_008_5B31:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hork", $F0

String_08_03_00:: ; heuristic: string; C0
Data_008_5B36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mudron", $F0

String_08_03_01:: ; heuristic: string; C0
Data_008_5B3D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "NiteWhip", $F0

String_08_03_02:: ; heuristic: string; C0
Data_008_5B46:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WindMerge", $F0

String_08_03_03:: ; heuristic: string; C0
Data_008_5B50:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reaper", $F0

String_08_03_04:: ; heuristic: string; C0
Data_008_5B57:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inverzon", $F0

String_08_03_05:: ; heuristic: string; C0
Data_008_5B60:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FoxFire", $F0

String_08_03_06:: ; heuristic: string; C0
Data_008_5B68:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CaptDead", $F0

String_08_03_07:: ; heuristic: string; C0
Data_008_5B71:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeadNoble", $F0

String_08_03_08:: ; heuristic: string; C0
Data_008_5B7B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhiteKing", $F0

String_08_03_09:: ; heuristic: string; C0
Data_008_5B85:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BoneSlave", $F0

String_08_03_0A:: ; heuristic: string; C0
Data_008_5B8F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skeletor", $F0

String_08_03_0B:: ; heuristic: string; C0
Data_008_5B98:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Servant", $F0

String_08_03_0C:: ; heuristic: string; C0
Data_008_5BA0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lazamanus", $F0

String_08_03_0D:: ; heuristic: string; C0
Data_008_5BAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Copycat", $F0

String_08_03_0E:: ; heuristic: string; C0
Data_008_5BB2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadSpirit", $F0

String_08_03_0F:: ; heuristic: string; C0
Data_008_5BBC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PomPomBom", $F0

String_08_03_10:: ; heuristic: string; C0
Data_008_5BC6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Niterich", $F0

String_08_03_11:: ; heuristic: string; C0
Data_008_5BCF:: ; address name
    db $98, $F0

String_08_03_19:: ; heuristic: string; C0
Data_008_5BD1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "JewelBag", $F0

String_08_03_1A:: ; heuristic: string; C0
Data_008_5BDA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilWand", $F0

String_08_03_1B:: ; heuristic: string; C0
Data_008_5BE3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadCandle", $F0

String_08_03_1C:: ; heuristic: string; C0
Data_008_5BED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CoilBird", $F0

String_08_03_1D:: ; heuristic: string; C0
Data_008_5BF6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Facer", $F0

String_08_03_1E:: ; heuristic: string; C0
Data_008_5BFC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpikyBoy", $F0

String_08_03_1F:: ; heuristic: string; C0
Data_008_5C05:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MadMirror", $F0

String_08_03_20:: ; heuristic: string; C0
Data_008_5C0F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RogueNite", $F0

String_08_03_21:: ; heuristic: string; C0
Data_008_5C19:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Puppetor", $F0

String_08_03_22:: ; heuristic: string; C0
Data_008_5C22:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Goopi", $F0

String_08_03_23:: ; heuristic: string; C0
Data_008_5C28:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Voodoll", $F0

String_08_03_24:: ; heuristic: string; C0
Data_008_5C30:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MetalDrak", $F0

String_08_03_25:: ; heuristic: string; C0
Data_008_5C3A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Balzak", $F0

String_08_03_26:: ; heuristic: string; C0
Data_008_5C41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SabreMan", $F0

String_08_03_27:: ; heuristic: string; C0
Data_008_5C4A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CurseLamp", $F0

String_08_03_28:: ; heuristic: string; C0
Data_008_5C54:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Brushead", $F0

String_08_03_29:: ; heuristic: string; C0
Data_008_5C5D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster", $F0

String_08_03_2A:: ; heuristic: string; C0
Data_008_5C66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster2", $F0

String_08_03_2B:: ; heuristic: string; C0
Data_008_5C70:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilPot", $F0

String_08_03_2C:: ; heuristic: string; C0
Data_008_5C78:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gismo", $F0

String_08_03_2D:: ; heuristic: string; C0
Data_008_5C7E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LavaMan", $F0

String_08_03_2E:: ; heuristic: string; C0
Data_008_5C86:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IceMan", $F0

String_08_03_2F:: ; heuristic: string; C0
Data_008_5C8D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mimic", $F0

String_08_03_30:: ; heuristic: string; C0
Data_008_5C93:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Exaucers", $F0

String_08_03_31:: ; heuristic: string; C0
Data_008_5C9C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MudDoll", $F0

String_08_03_32:: ; heuristic: string; C0
Data_008_5CA4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Golem", $F0

String_08_03_33:: ; heuristic: string; C0
Data_008_5CAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StoneMan", $F0

String_08_03_34:: ; heuristic: string; C0
Data_008_5CB3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BombCrag", $F0

String_08_03_35:: ; heuristic: string; C0
Data_008_5CBC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldGolem", $F0

String_08_03_36:: ; heuristic: string; C0
Data_008_5CC6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DarkMate", $F0

String_08_03_37:: ; heuristic: string; C0
Data_008_5CCF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ProtoMech", $F0

String_08_03_38:: ; heuristic: string; C0
Data_008_5CD9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CloudKing", $F0

String_08_03_39:: ; heuristic: string; C0
Data_008_5CE3:: ; address name
    db $98, $F0

String_08_03_3C:: ; heuristic: string; C0
Data_008_5CE5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Petiteel", $F0

String_08_03_3D:: ; heuristic: string; C0
Data_008_5CEE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moray", $F0

String_08_03_3E:: ; heuristic: string; C0
Data_008_5CF4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WalrusMan", $F0

String_08_03_3F:: ; heuristic: string; C0
Data_008_5CFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RayGigas", $F0

String_08_03_40:: ; heuristic: string; C0
Data_008_5D07:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Anemon", $F0

String_08_03_41:: ; heuristic: string; C0
Data_008_5D0E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Aquarella", $F0

String_08_03_42:: ; heuristic: string; C0
Data_008_5D18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Merman", $F0

String_08_03_43:: ; heuristic: string; C0
Data_008_5D1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octokid", $F0

String_08_03_44:: ; heuristic: string; C0
Data_008_5D27:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PutreFish", $F0

String_08_03_45:: ; heuristic: string; C0
Data_008_5D31:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octoreach", $F0

String_08_03_46:: ; heuristic: string; C0
Data_008_5D3B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Angleron", $F0

String_08_03_47:: ; heuristic: string; C0
Data_008_5D44:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FishRider", $F0

String_08_03_48:: ; heuristic: string; C0
Data_008_5D4E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RushFish", $F0

String_08_03_49:: ; heuristic: string; C0
Data_008_5D57:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gamanian", $F0

String_08_03_4A:: ; heuristic: string; C0
Data_008_5D60:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Clawster", $F0

String_08_03_4B:: ; heuristic: string; C0
Data_008_5D69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CancerMan", $F0

String_08_03_4C:: ; heuristic: string; C0
Data_008_5D73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RogueWave", $F0

String_08_03_4D:: ; heuristic: string; C0
Data_008_5D7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Scallopa", $F0

String_08_03_4E:: ; heuristic: string; C0
Data_008_5D86:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SeaHorse", $F0

String_08_03_4F:: ; heuristic: string; C0
Data_008_5D8F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HoodSquid", $F0

String_08_03_50:: ; heuristic: string; C0
Data_008_5D99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MerTiger", $F0

String_08_03_51:: ; heuristic: string; C0
Data_008_5DA2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AxeShark", $F0

String_08_03_52:: ; heuristic: string; C0
Data_008_5DAB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octogon", $F0

String_08_03_53:: ; heuristic: string; C0
Data_008_5DB3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KingSquid", $F0

String_08_03_54:: ; heuristic: string; C0
Data_008_5DBD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Digong", $F0

String_08_03_55:: ; heuristic: string; C0
Data_008_5DC4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhaleMage", $F0

String_08_03_56:: ; heuristic: string; C0
Data_008_5DCE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Aquadon", $F0

String_08_03_57:: ; heuristic: string; C0
Data_008_5DD6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Octoraid", $F0

String_08_03_58:: ; heuristic: string; C0
Data_008_5DDF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grakos", $F0

String_08_03_59:: ; heuristic: string; C0
Data_008_5DE6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Poseidon", $F0

String_08_03_5A:: ; heuristic: string; C0
Data_008_5DEF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pumpoise", $F0

String_08_03_5B:: ; heuristic: string; C0
Data_008_5DF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starfish", $F0

String_08_03_5C:: ; heuristic: string; C0
Data_008_5E01:: ; address name
    db $98, $F0

String_08_03_5F:: ; heuristic: string; C0
Data_008_5E03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoLord", $F0

String_08_03_60:: ; heuristic: string; C0
Data_008_5E0D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoLord", $F0

String_08_03_61:: ; heuristic: string; C0
Data_008_5E17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LordDraco", $F0

String_08_03_62:: ; heuristic: string; C0
Data_008_5E21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hargon", $F0

String_08_03_63:: ; heuristic: string; C0
Data_008_5E28:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sidoh", $F0

String_08_03_64:: ; heuristic: string; C0
Data_008_5E2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Genosidoh", $F0

String_08_03_65:: ; heuristic: string; C0
Data_008_5E38:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Baramos", $F0

String_08_03_66:: ; heuristic: string; C0
Data_008_5E40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Zoma", $F0

String_08_03_67:: ; heuristic: string; C0
Data_008_5E45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AsuraZoma", $F0

String_08_03_68:: ; heuristic: string; C0
Data_008_5E4F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pizzaro", $F0

String_08_03_69:: ; heuristic: string; C0
Data_008_5E57:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PsychoPiz", $F0

String_08_03_6A:: ; heuristic: string; C0
Data_008_5E61:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Esterk", $F0

String_08_03_6B:: ; heuristic: string; C0
Data_008_5E68:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mirudraas", $F0

String_08_03_6C:: ; heuristic: string; C0
Data_008_5E72:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mirudraas", $F0

String_08_03_6D:: ; heuristic: string; C0
Data_008_5E7C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mudou", $F0

String_08_03_6E:: ; heuristic: string; C0
Data_008_5E82:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeathMore", $F0

String_08_03_6F:: ; heuristic: string; C0
Data_008_5E8C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeathMore", $F0

String_08_03_70:: ; heuristic: string; C0
Data_008_5E96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeathMore", $F0

String_08_03_71:: ; heuristic: string; C0
Data_008_5EA0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Darkdrium", $F0

String_08_03_72:: ; heuristic: string; C0
Data_008_5EAA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orgodemir", $F0

String_08_03_73:: ; heuristic: string; C0
Data_008_5EB4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Orgodemir", $F0

String_08_03_74:: ; heuristic: string; C0
Data_008_5EBE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Darck", $F0

String_08_03_75:: ; heuristic: string; C0
Data_008_5EC4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tatsu", $F0

String_08_03_76:: ; heuristic: string; C0
Data_008_5ECA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Diago", $F0

String_08_03_77:: ; heuristic: string; C0
Data_008_5ED0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Samsi", $F0

String_08_03_78:: ; heuristic: string; C0
Data_008_5ED6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bazoo", $F0

String_08_03_79:: ; heuristic: string; C0
Data_008_5EDC:: ; address name
    db $98, $F0

String_08_03_7C:: ; heuristic: string; C0
Data_008_5EDE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lamia", $F0

String_08_03_7D:: ; heuristic: string; C0
Data_008_5EE4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dimensaur", $F0

String_08_03_7E:: ; heuristic: string; C0
Data_008_5EEE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kagebou", $F0

String_08_03_7F:: ; heuristic: string; C0
Data_008_5EF6:: ; address name
    db $98, $F0

String_08_04_00:: ; heuristic: string; C0
Data_008_5EF8:: ; address name
    db $F0

String_08_04_01:: ; heuristic: string; C0
Data_008_5EF9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blaze", $F0

String_08_04_02:: ; heuristic: string; C0
Data_008_5EFF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blazemore", $F0

String_08_04_03:: ; heuristic: string; C0
Data_008_5F09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blazemost", $F0

String_08_04_04:: ; heuristic: string; C0
Data_008_5F13:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Firebal", $F0

String_08_04_05:: ; heuristic: string; C0
Data_008_5F1B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Firebane", $F0

String_08_04_06:: ; heuristic: string; C0
Data_008_5F24:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Firebolt", $F0

String_08_04_07:: ; heuristic: string; C0
Data_008_5F2D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bang", $F0

String_08_04_08:: ; heuristic: string; C0
Data_008_5F32:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Boom", $F0

String_08_04_09:: ; heuristic: string; C0
Data_008_5F37:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Explodet", $F0

String_08_04_0A:: ; heuristic: string; C0
Data_008_5F40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Infernos", $F0

String_08_04_0B:: ; heuristic: string; C0
Data_008_5F49:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Infermore", $F0

String_08_04_0C:: ; heuristic: string; C0
Data_008_5F53:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Infermost", $F0

String_08_04_0D:: ; heuristic: string; C0
Data_008_5F5D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bolt", $F0

String_08_04_0E:: ; heuristic: string; C0
Data_008_5F62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Zap", $F0

String_08_04_0F:: ; heuristic: string; C0
Data_008_5F66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thordain", $F0

String_08_04_10:: ; heuristic: string; C0
Data_008_5F6F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IceBolt", $F0

String_08_04_11:: ; heuristic: string; C0
Data_008_5F77:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SnowStorm", $F0

String_08_04_12:: ; heuristic: string; C0
Data_008_5F81:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blizzard", $F0

String_08_04_13:: ; heuristic: string; C0
Data_008_5F8A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beat", $F0

String_08_04_14:: ; heuristic: string; C0
Data_008_5F8F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Defeat", $F0

String_08_04_15:: ; heuristic: string; C0
Data_008_5F96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sacrifice", $F0

String_08_04_16:: ; heuristic: string; C0
Data_008_5FA0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Heal", $F0

String_08_04_17:: ; heuristic: string; C0
Data_008_5FA5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HealMore", $F0

String_08_04_18:: ; heuristic: string; C0
Data_008_5FAE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HealAll", $F0

String_08_04_19:: ; heuristic: string; C0
Data_008_5FB6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HealUs", $F0

String_08_04_1A:: ; heuristic: string; C0
Data_008_5FBD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HealUsAll", $F0

String_08_04_1B:: ; heuristic: string; C0
Data_008_5FC7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MPass", $F0

String_08_04_1C:: ; heuristic: string; C0
Data_008_5FCD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MPassmore", $F0

String_08_04_1D:: ; heuristic: string; C0
Data_008_5FD7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MPassmost", $F0

String_08_04_1E:: ; heuristic: string; C0
Data_008_5FE1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Vivify", $F0

String_08_04_1F:: ; heuristic: string; C0
Data_008_5FE8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revive", $F0

String_08_04_20:: ; heuristic: string; C0
Data_008_5FEF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Farewell", $F0

String_08_04_21:: ; heuristic: string; C0
Data_008_5FF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Antidote", $F0

String_08_04_22:: ; heuristic: string; C0
Data_008_6001:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeChaos", $F0

String_08_04_23:: ; heuristic: string; C0
Data_008_6009:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "NumbOff", $F0

String_08_04_24:: ; heuristic: string; C0
Data_008_6011:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CurseOff", $F0

String_08_04_25:: ; heuristic: string; C0
Data_008_601A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Upper", $F0

String_08_04_26:: ; heuristic: string; C0
Data_008_6020:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Increase", $F0

String_08_04_27:: ; heuristic: string; C0
Data_008_6029:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sap", $F0

String_08_04_28:: ; heuristic: string; C0
Data_008_602D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Defense", $F0

String_08_04_29:: ; heuristic: string; C0
Data_008_6035:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Speed", $F0

String_08_04_2A:: ; heuristic: string; C0
Data_008_603B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SpeedUp", $F0

String_08_04_2B:: ; heuristic: string; C0
Data_008_6043:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slow", $F0

String_08_04_2C:: ; heuristic: string; C0
Data_008_6048:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SlowAll", $F0

String_08_04_2D:: ; heuristic: string; C0
Data_008_6050:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TwinHits", $F0

String_08_04_2E:: ; heuristic: string; C0
Data_008_6059:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Surround", $F0

String_08_04_2F:: ; heuristic: string; C0
Data_008_6062:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sleep", $F0

String_08_04_30:: ; heuristic: string; C0
Data_008_6068:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SleepAll", $F0

String_08_04_31:: ; heuristic: string; C0
Data_008_6071:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TakeMagic", $F0

String_08_04_32:: ; heuristic: string; C0
Data_008_607B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RobMagic", $F0

String_08_04_33:: ; heuristic: string; C0
Data_008_6084:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StopSpell", $F0

String_08_04_34:: ; heuristic: string; C0
Data_008_608E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PanicAll", $F0

String_08_04_35:: ; heuristic: string; C0
Data_008_6097:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ironize", $F0

String_08_04_36:: ; heuristic: string; C0
Data_008_609F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MagicBack", $F0

String_08_04_37:: ; heuristic: string; C0
Data_008_60A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bounce", $F0

String_08_04_38:: ; heuristic: string; C0
Data_008_60B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Barrier", $F0

String_08_04_39:: ; heuristic: string; C0
Data_008_60B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MagicWall", $F0

String_08_04_3A:: ; heuristic: string; C0
Data_008_60C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Transform", $F0

String_08_04_3B:: ; heuristic: string; C0
Data_008_60CC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeDragon", $F0

String_08_04_3C:: ; heuristic: string; C0
Data_008_60D5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Chance", $F0

String_08_04_3D:: ; heuristic: string; C0
Data_008_60DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MegaMagic", $F0

String_08_04_3E:: ; heuristic: string; C0
Data_008_60E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BigBang", $F0

String_08_04_3F:: ; heuristic: string; C0
Data_008_60EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hellblast", $F0

String_08_04_40:: ; heuristic: string; C0
Data_008_60F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FireAir", $F0

String_08_04_41:: ; heuristic: string; C0
Data_008_6100:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BlazeAir", $F0

String_08_04_42:: ; heuristic: string; C0
Data_008_6109:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Scorching", $F0

String_08_04_43:: ; heuristic: string; C0
Data_008_6113:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhiteFire", $F0

String_08_04_44:: ; heuristic: string; C0
Data_008_611D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FrigidAir", $F0

String_08_04_45:: ; heuristic: string; C0
Data_008_6127:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IceAir", $F0

String_08_04_46:: ; heuristic: string; C0
Data_008_612E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IceStorm", $F0

String_08_04_47:: ; heuristic: string; C0
Data_008_6137:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WhiteAir", $F0

String_08_04_48:: ; heuristic: string; C0
Data_008_6140:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WindBeast", $F0

String_08_04_49:: ; heuristic: string; C0
Data_008_614A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Vacuum", $F0

String_08_04_4A:: ; heuristic: string; C0
Data_008_6151:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lightning", $F0

String_08_04_4B:: ; heuristic: string; C0
Data_008_615B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RockThrow", $F0

String_08_04_4C:: ; heuristic: string; C0
Data_008_6165:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Watershot", $F0

String_08_04_4D:: ; heuristic: string; C0
Data_008_616F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tidalwave", $F0

String_08_04_4E:: ; heuristic: string; C0
Data_008_6179:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CallHelp", $F0

String_08_04_4F:: ; heuristic: string; C0
Data_008_6182:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "YellHelp", $F0

String_08_04_50:: ; heuristic: string; C0
Data_008_618B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FireSlash", $F0

String_08_04_51:: ; heuristic: string; C0
Data_008_6195:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "VacuSlash", $F0

String_08_04_52:: ; heuristic: string; C0
Data_008_619F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BoltSlash", $F0

String_08_04_53:: ; heuristic: string; C0
Data_008_61A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IceSlash", $F0

String_08_04_54:: ; heuristic: string; C0
Data_008_61B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SlimeBlow", $F0

String_08_04_55:: ; heuristic: string; C0
Data_008_61BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DrakSlash", $F0

String_08_04_56:: ; heuristic: string; C0
Data_008_61C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeastCut", $F0

String_08_04_57:: ; heuristic: string; C0
Data_008_61CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BirdBlow", $F0

String_08_04_58:: ; heuristic: string; C0
Data_008_61D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BugBlow", $F0

String_08_04_59:: ; heuristic: string; C0
Data_008_61E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shears", $F0

String_08_04_5A:: ; heuristic: string; C0
Data_008_61E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DevilCut", $F0

String_08_04_5B:: ; heuristic: string; C0
Data_008_61F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ZombieCut", $F0

String_08_04_5C:: ; heuristic: string; C0
Data_008_61FA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "CleanCut", $F0

String_08_04_5D:: ; heuristic: string; C0
Data_008_6203:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AquaCut", $F0

String_08_04_5E:: ; heuristic: string; C0
Data_008_620B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MetalCut", $F0

String_08_04_5F:: ; heuristic: string; C0
Data_008_6214:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PoisonHit", $F0

String_08_04_60:: ; heuristic: string; C0
Data_008_621E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Paralyze", $F0

String_08_04_61:: ; heuristic: string; C0
Data_008_6227:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "NapAttack", $F0

String_08_04_62:: ; heuristic: string; C0
Data_008_6231:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SquallHit", $F0

String_08_04_63:: ; heuristic: string; C0
Data_008_623B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BiAttack", $F0

String_08_04_64:: ; heuristic: string; C0
Data_008_6244:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "QuadHits", $F0

String_08_04_65:: ; heuristic: string; C0
Data_008_624D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RainSlash", $F0

String_08_04_66:: ; heuristic: string; C0
Data_008_6257:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MultiCut", $F0

String_08_04_67:: ; heuristic: string; C0
Data_008_6260:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GigaSlash", $F0

String_08_04_68:: ; heuristic: string; C0
Data_008_626A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ChargeUp", $F0

String_08_04_69:: ; heuristic: string; C0
Data_008_6273:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PsycheUp", $F0

String_08_04_6A:: ; heuristic: string; C0
Data_008_627C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HighJump", $F0

String_08_04_6B:: ; heuristic: string; C0
Data_008_6285:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EvilSlash", $F0

String_08_04_6C:: ; heuristic: string; C0
Data_008_628F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Massacre", $F0

String_08_04_6D:: ; heuristic: string; C0
Data_008_6298:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TwinSlash", $F0

String_08_04_6E:: ; heuristic: string; C0
Data_008_62A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Berserker", $F0

String_08_04_6F:: ; heuristic: string; C0
Data_008_62AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ramming", $F0

String_08_04_70:: ; heuristic: string; C0
Data_008_62B4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kamikaze", $F0

String_08_04_71:: ; heuristic: string; C0
Data_008_62BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SleepAir", $F0

String_08_04_72:: ; heuristic: string; C0
Data_008_62C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PalsyAir", $F0

String_08_04_73:: ; heuristic: string; C0
Data_008_62CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PoisonGas", $F0

String_08_04_74:: ; heuristic: string; C0
Data_008_62D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PoisonAir", $F0

String_08_04_75:: ; heuristic: string; C0
Data_008_62E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Curse", $F0

String_08_04_76:: ; heuristic: string; C0
Data_008_62E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "OddDance", $F0

String_08_04_77:: ; heuristic: string; C0
Data_008_62F2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RobDance", $F0

String_08_04_78:: ; heuristic: string; C0
Data_008_62FB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PaniDance", $F0

String_08_04_79:: ; heuristic: string; C0
Data_008_6305:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "K.O.Dance", $F0

String_08_04_7A:: ; heuristic: string; C0
Data_008_630F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LureDance", $F0

String_08_04_7B:: ; heuristic: string; C0
Data_008_6319:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LifeDance", $F0

String_08_04_7C:: ; heuristic: string; C0
Data_008_6323:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hustle", $F0

String_08_04_7D:: ; heuristic: string; C0
Data_008_632A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SideStep", $F0

String_08_04_7E:: ; heuristic: string; C0
Data_008_6333:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SandStorm", $F0

String_08_04_7F:: ; heuristic: string; C0
Data_008_633D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Radiant", $F0

String_08_04_80:: ; heuristic: string; C0
Data_008_6345:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EerieLite", $F0

String_08_04_81:: ; heuristic: string; C0
Data_008_634F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Surge", $F0

String_08_04_82:: ; heuristic: string; C0
Data_008_6355:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "UltraDown", $F0

String_08_04_83:: ; heuristic: string; C0
Data_008_635F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeMagic", $F0

String_08_04_84:: ; heuristic: string; C0
Data_008_6367:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ThickFog", $F0

String_08_04_85:: ; heuristic: string; C0
Data_008_6370:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TatsuCall", $F0

String_08_04_86:: ; heuristic: string; C0
Data_008_637A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DiagoCall", $F0

String_08_04_87:: ; heuristic: string; C0
Data_008_6384:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SamsiCall", $F0

String_08_04_88:: ; heuristic: string; C0
Data_008_638E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BazooCall", $F0

String_08_04_89:: ; heuristic: string; C0
Data_008_6398:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SuckAir", $F0

String_08_04_8A:: ; heuristic: string; C0
Data_008_63A0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Focus", $F0

String_08_04_8B:: ; heuristic: string; C0
Data_008_63A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LushLicks", $F0

String_08_04_8C:: ; heuristic: string; C0
Data_008_63B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SickLick", $F0

String_08_04_8D:: ; heuristic: string; C0
Data_008_63B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LegSweep", $F0

String_08_04_8E:: ; heuristic: string; C0
Data_008_63C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BigTrip", $F0

String_08_04_8F:: ; heuristic: string; C0
Data_008_63CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ahhh", $F0

String_08_04_90:: ; heuristic: string; C0
Data_008_63CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WarCry", $F0

String_08_04_91:: ; heuristic: string; C0
Data_008_63D6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Geyser", $F0

String_08_04_92:: ; heuristic: string; C0
Data_008_63DD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DanceShut", $F0

String_08_04_93:: ; heuristic: string; C0
Data_008_63E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MouthShut", $F0

String_08_04_94:: ; heuristic: string; C0
Data_008_63F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StrongD", $F0

String_08_04_95:: ; heuristic: string; C0
Data_008_63F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dodge", $F0

String_08_04_96:: ; heuristic: string; C0
Data_008_63FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BladeD", $F0

String_08_04_97:: ; heuristic: string; C0
Data_008_6406:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cover", $F0

String_08_04_98:: ; heuristic: string; C0
Data_008_640C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Guardian", $F0

String_08_04_99:: ; heuristic: string; C0
Data_008_6415:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TailWind", $F0

String_08_04_9A:: ; heuristic: string; C0
Data_008_641E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StormWind", $F0

String_08_04_9B:: ; heuristic: string; C0
Data_008_6428:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AquaWall", $F0

String_08_04_9C:: ; heuristic: string; C0
Data_008_6431:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SealPray", $F0

String_08_04_9D:: ; heuristic: string; C0
Data_008_643A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SuckAll", $F0

String_08_04_9E:: ; heuristic: string; C0
Data_008_6442:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Imitate", $F0

String_08_04_9F:: ; heuristic: string; C0
Data_008_644A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Meditate", $F0

String_08_04_A0:: ; heuristic: string; C0
Data_008_6453:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LifeSong", $F0

String_08_04_A1:: ; heuristic: string; C0
Data_008_645C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LoveRain", $F0

String_08_04_A2:: ; heuristic: string; C0
Data_008_6465:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Whistle", $F0

String_08_04_A3:: ; heuristic: string; C0
Data_008_646D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pheromone", $F0

String_08_04_A4:: ; heuristic: string; C0
Data_008_6477:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StepGuard", $F0

String_08_04_A5:: ; heuristic: string; C0
Data_008_6481:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Outside", $F0

String_08_04_A6:: ; heuristic: string; C0
Data_008_6489:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Informer", $F0

String_08_04_A7:: ; heuristic: string; C0
Data_008_6492:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Errand", $F0

String_08_04_A8:: ; heuristic: string; C0
Data_008_6499:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "EagleEye", $F0

String_08_04_A9:: ; heuristic: string; C0
Data_008_64A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MapMagic", $F0

String_08_04_AA:: ; heuristic: string; C0
Data_008_64AB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ahhh", $F0

String_08_04_AB:: ; heuristic: string; C0
Data_008_64B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ZoneOut", $F0

String_08_04_AC:: ; heuristic: string; C0
Data_008_64B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Guard", $F0

String_08_04_AD:: ; heuristic: string; C0
Data_008_64BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PanicAll", $F0

String_08_04_AE:: ; heuristic: string; C0
Data_008_64C7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ironize", $F0

String_08_04_AF:: ; heuristic: string; C0
Data_008_64CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HighJump", $F0

String_08_04_CD:: ; heuristic: string; C0
Data_008_64D8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LoveRain", $F0

String_08_04_D0:: ; heuristic: string; C0
Data_008_64E1:: ; address name
    db $F0

String_08_05_00:: ; heuristic: string; C0
Data_008_64E2:: ; address name
    db $F0

String_08_05_01:: ; heuristic: string; C0
Data_008_64E3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Herb", $F0

String_08_05_02:: ; heuristic: string; C0
Data_008_64E8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LoveWater", $F0

String_08_05_03:: ; heuristic: string; C0
Data_008_64F2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WorldDew", $F0

String_08_05_04:: ; heuristic: string; C0
Data_008_64FB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Potion", $F0

String_08_05_05:: ; heuristic: string; C0
Data_008_6502:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ElfWater", $F0

String_08_05_06:: ; heuristic: string; C0
Data_008_650B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Antidote", $F0

String_08_05_07:: ; heuristic: string; C0
Data_008_6514:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MoonHerb", $F0

String_08_05_08:: ; heuristic: string; C0
Data_008_651D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Laurel", $F0

String_08_05_09:: ; heuristic: string; C0
Data_008_6524:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AwakeSand", $F0

String_08_05_0A:: ; heuristic: string; C0
Data_008_652E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SkyBell", $F0

String_08_05_0B:: ; heuristic: string; C0
Data_008_6536:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SageRock", $F0

String_08_05_0C:: ; heuristic: string; C0
Data_008_653F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WorldLeaf", $F0

String_08_05_0D:: ; heuristic: string; C0
Data_008_6549:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ATKseed", $F0

String_08_05_0E:: ; heuristic: string; C0
Data_008_6551:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DEFseed", $F0

String_08_05_0F:: ; heuristic: string; C0
Data_008_6559:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AGLseed", $F0

String_08_05_10:: ; heuristic: string; C0
Data_008_6561:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "INTseed", $F0

String_08_05_11:: ; heuristic: string; C0
Data_008_6569:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LifeAcorn", $F0

String_08_05_12:: ; heuristic: string; C0
Data_008_6573:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MysticNut", $F0

String_08_05_13:: ; heuristic: string; C0
Data_008_657D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Quest", $50, $F0

String_08_05_14:: ; heuristic: string; C0
Data_008_6584:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Horror", $50, $F0

String_08_05_15:: ; heuristic: string; C0
Data_008_658C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeNice", $50, $F0

String_08_05_16:: ; heuristic: string; C0
Data_008_6594:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cheater", $50, $F0

String_08_05_17:: ; heuristic: string; C0
Data_008_659D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smart", $50, $F0

String_08_05_18:: ; heuristic: string; C0
Data_008_65A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Comedy", $50, $F0

String_08_05_19:: ; heuristic: string; C0
Data_008_65AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeefJerky", $F0

String_08_05_1A:: ; heuristic: string; C0
Data_008_65B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PorkChop", $F0

String_08_05_1B:: ; heuristic: string; C0
Data_008_65BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rib", $F0

String_08_05_1C:: ; heuristic: string; C0
Data_008_65C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sirloin", $F0

String_08_05_1D:: ; heuristic: string; C0
Data_008_65CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BadMeat", $F0

String_08_05_1E:: ; heuristic: string; C0
Data_008_65D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MeteOrb", $F0

String_08_05_1F:: ; heuristic: string; C0
Data_008_65DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BeastTail", $F0

String_08_05_20:: ; heuristic: string; C0
Data_008_65E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Repellent", $F0

String_08_05_21:: ; heuristic: string; C0
Data_008_65EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ShinyHarp", $F0

String_08_05_22:: ; heuristic: string; C0
Data_008_65F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mist", $51, $F0

String_08_05_23:: ; heuristic: string; C0
Data_008_65FF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Friend", $51, $F0

String_08_05_24:: ; heuristic: string; C0
Data_008_6607:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wind", $51, $F0

String_08_05_25:: ; heuristic: string; C0
Data_008_660D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bolt", $51, $F0

String_08_05_26:: ; heuristic: string; C0
Data_008_6613:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snow", $51, $F0

String_08_05_27:: ; heuristic: string; C0
Data_008_6619:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fire", $51, $F0

String_08_05_28:: ; heuristic: string; C0
Data_008_661F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Warp", $51, $F0

String_08_05_29:: ; heuristic: string; C0
Data_008_6625:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WarpWing", $F0

String_08_05_2A:: ; heuristic: string; C0
Data_008_662E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ExitBell", $F0

String_08_05_2B:: ; heuristic: string; C0
Data_008_6637:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bookmark", $F0

String_08_05_2C:: ; heuristic: string; C0
Data_008_6640:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TinyMedal", $F0

String_08_05_2D:: ; heuristic: string; C0
Data_008_664A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldPass", $F0

String_08_05_2E:: ; heuristic: string; C0
Data_008_6653:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "LogTwig", $F0

String_08_05_2F:: ; heuristic: string; C0
Data_008_665B:: ; address name
    db $F0

String_08_05_30:: ; heuristic: string; C0
Data_008_665C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WaterCall", $F0

String_08_05_31:: ; heuristic: string; C0
Data_008_6666:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MoonRock", $F0

String_08_05_32:: ; heuristic: string; C0
Data_008_666F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Crest", $F0

String_08_05_33:: ; heuristic: string; C0
Data_008_6675:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "YunaSoul", $F0

String_08_05_34:: ; heuristic: string; C0
Data_008_667E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SleepHerb", $F0

String_08_05_35:: ; heuristic: string; C0
Data_008_6688:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Change", $51, $F0

String_08_05_36:: ; heuristic: string; C0
Data_008_6690:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TidalBell", $F0

String_08_05_37:: ; heuristic: string; C0
Data_008_669A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HarMirror", $F0

String_08_05_38:: ; heuristic: string; C0
Data_008_66A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sky", $5E, $F0

String_08_05_39:: ; heuristic: string; C0
Data_008_66A9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Heaven", $52, $F0

String_08_05_3A:: ; heuristic: string; C0
Data_008_66B1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Heaven", $54, $F0

String_08_05_3B:: ; heuristic: string; C0
Data_008_66B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Heaven", $53, $F0

String_08_05_3C:: ; heuristic: string; C0
Data_008_66C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WizStone", $F0

String_08_05_3D:: ; heuristic: string; C0
Data_008_66CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pretty", $55, $F0

String_08_05_3E:: ; heuristic: string; C0
Data_008_66D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Accessory", $F0

String_08_05_40:: ; heuristic: string; C0
Data_008_66DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "VITbelt", $F0

String_08_05_41:: ; heuristic: string; C0
Data_008_66E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoBelt", $F0

String_08_05_42:: ; heuristic: string; C0
Data_008_66EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MagicBelt", $F0

String_08_05_43:: ; heuristic: string; C0
Data_008_66F8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "OddBelt", $F0

String_08_05_44:: ; heuristic: string; C0
Data_008_6700:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "StoneFang", $F0

String_08_05_45:: ; heuristic: string; C0
Data_008_670A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SteelFang", $F0

String_08_05_46:: ; heuristic: string; C0
Data_008_6714:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MermScale", $F0

String_08_05_47:: ; heuristic: string; C0
Data_008_671E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DrakScale", $F0

String_08_05_48:: ; heuristic: string; C0
Data_008_6728:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "AGL", $55, $F0

String_08_05_49:: ; heuristic: string; C0
Data_008_672D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starry", $55, $F0

String_08_05_4A:: ; heuristic: string; C0
Data_008_6735:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smart", $56, $F0

String_08_05_4B:: ; heuristic: string; C0
Data_008_673C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wise", $56, $F0

String_08_05_4C:: ; heuristic: string; C0
Data_008_6742:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MagicCape", $F0

String_08_05_4D:: ; heuristic: string; C0
Data_008_674C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoCape", $F0

String_08_05_4E:: ; heuristic: string; C0
Data_008_6756:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "SilvrCape", $F0

String_08_05_4F:: ; heuristic: string; C0
Data_008_6760:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GoldCape", $F0

String_08_05_50:: ; heuristic: string; C0
Data_008_6769:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PltnmCape", $F0

String_08_05_51:: ; heuristic: string; C0
Data_008_6773:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "OrcaCape", $F0

String_08_05_52:: ; heuristic: string; C0
Data_008_677C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BraveCape", $F0

String_08_05_53:: ; heuristic: string; C0
Data_008_6786:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "D-Scale", $F0

String_08_05_54:: ; heuristic: string; C0
Data_008_678E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "None", $F0

String_08_05_5A:: ; heuristic: string; C0
Data_008_6793:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Life", $55, $F0

String_08_05_5B:: ; heuristic: string; C0
Data_008_6799:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Divine", $55, $F0

String_08_05_5C:: ; heuristic: string; C0
Data_008_67A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "War", $55, $F0

String_08_05_5D:: ; heuristic: string; C0
Data_008_67A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mage", $55, $F0

String_08_05_5E:: ; heuristic: string; C0
Data_008_67AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fight", $55, $F0

String_08_05_5F:: ; heuristic: string; C0
Data_008_67B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sailor", $55, $F0

String_08_05_60:: ; heuristic: string; C0
Data_008_67BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thief", $55, $F0

String_08_05_61:: ; heuristic: string; C0
Data_008_67C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cleric", $55, $F0

String_08_05_62:: ; heuristic: string; C0
Data_008_67CA:: ; address name
    db $F0

String_08_06_00:: ; heuristic: string; C0
Data_008_67CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of one", $F1
    db "monster by 30", $9D, "40.", $F0

String_08_06_02:: ; heuristic: string; C0
Data_008_67F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of one", $F1
    db "monster by 60", $9D, "70.", $F0

String_08_06_03:: ; heuristic: string; C0
Data_008_6815:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores HP", $F1
    db "of all monsters.", $F0

String_08_06_04:: ; heuristic: string; C0
Data_008_6838:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores MP of one", $F1
    db "monster by 20", $9D, "30.", $F0

String_08_06_05:: ; heuristic: string; C0
Data_008_685D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores MP", $F1
    db "of one monster.", $F0

String_08_06_06:: ; heuristic: string; C0
Data_008_687F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Removes all traces", $F1
    db "of poison.", $F0

String_08_06_07:: ; heuristic: string; C0
Data_008_689D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cures paralysis.", $F0

String_08_06_08:: ; heuristic: string; C0
Data_008_68AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lifts a curse off", $F1
    db "one monster.", $F0

String_08_06_09:: ; heuristic: string; C0
Data_008_68CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Awakens a sleeping", $F1
    db "monster.", $F0

String_08_06_0A:: ; heuristic: string; C0
Data_008_68E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snaps a monster", $F1
    db "out of confusion.", $F0

String_08_06_0B:: ; heuristic: string; C0
Data_008_690B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of all", $F1
    db "monsters by 60", $9D, "70.", $F0

String_08_06_0C:: ; heuristic: string; C0
Data_008_6931:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives a dead", $F1
    db "monster.", $F0

String_08_06_0D:: ; heuristic: string; C0
Data_008_6949:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 3.", $F0

String_08_06_0E:: ; heuristic: string; C0
Data_008_695A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 3.", $F0

String_08_06_0F:: ; heuristic: string; C0
Data_008_696B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 3.", $F0

String_08_06_10:: ; heuristic: string; C0
Data_008_697C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 3.", $F0

String_08_06_11:: ; heuristic: string; C0
Data_008_698D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 5.", $F0

String_08_06_12:: ; heuristic: string; C0
Data_008_69A2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 5.", $F0

String_08_06_13:: ; heuristic: string; C0
Data_008_69B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "braver.", $F0

String_08_06_14:: ; heuristic: string; C0
Data_008_69D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more cowardly.", $F0

String_08_06_15:: ; heuristic: string; C0
Data_008_69F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more kindly.", $F0

String_08_06_16:: ; heuristic: string; C0
Data_008_6A0E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more sly.", $F0

String_08_06_17:: ; heuristic: string; C0
Data_008_6A29:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more thoughtful.", $F0

String_08_06_18:: ; heuristic: string; C0
Data_008_6A4B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "simple-minded.", $F0

String_08_06_19:: ; heuristic: string; C0
Data_008_6A6B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "just a little.", $F0

String_08_06_1A:: ; heuristic: string; C0
Data_008_6A89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters a", $F1
    db "little bit.", $F0

String_08_06_1B:: ; heuristic: string; C0
Data_008_6AA6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters a", $F1
    db "lot.", $F0

String_08_06_1C:: ; heuristic: string; C0
Data_008_6ABC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "very much.", $F0

String_08_06_1D:: ; heuristic: string; C0
Data_008_6AD6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames a tiny bit,", $F1
    db "but also poisons.", $F0

String_08_06_1E:: ; heuristic: string; C0
Data_008_6AFA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "incredibly.", $F0

String_08_06_1F:: ; heuristic: string; C0
Data_008_6B15:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Checks if monster", $F1
    db "was caught before.", $F0

String_08_06_20:: ; heuristic: string; C0
Data_008_6B3A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents monsters", $F1
    db "from appearing.", $F0

String_08_06_21:: ; heuristic: string; C0
Data_008_6B5C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts monsters", $F1
    db "when strummed.", $F0

String_08_06_22:: ; heuristic: string; C0
Data_008_6B7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents casting", $F1
    db "of spells.", $F0

String_08_06_23:: ; heuristic: string; C0
Data_008_6B99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Doubles physical", $F1
    db "power of one.", $F0

String_08_06_24:: ; heuristic: string; C0
Data_008_6BB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with a windstorm.", $F0

String_08_06_25:: ; heuristic: string; C0
Data_008_6BDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with lightning.", $F0

String_08_06_26:: ; heuristic: string; C0
Data_008_6BFC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with a blizzard.", $F0

String_08_06_27:: ; heuristic: string; C0
Data_008_6C1E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits one target", $F1
    db "with a fireball.", $F0

String_08_06_28:: ; heuristic: string; C0
Data_008_6C3F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "the Door Shrine.", $F0

String_08_06_29:: ; heuristic: string; C0
Data_008_6C63:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "GreatLog.", $F0

String_08_06_2A:: ; heuristic: string; C0
Data_008_6C80:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "the exit.", $F0

String_08_06_2B:: ; heuristic: string; C0
Data_008_6C9D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enables saving in", $F1
    db "the Journal.", $F0

String_08_06_2C:: ; heuristic: string; C0
Data_008_6CBC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Collect and trade", $F1
    db "for rare gifts.", $F0

String_08_06_2D:: ; heuristic: string; C0
Data_008_6CDE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Get a 10-percent", $F1
    db "discount at shops.", $F0

String_08_06_2E:: ; heuristic: string; C0
Data_008_6D02:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moves the Door", $F1
    db "Shrine.", $F0

String_08_06_2F:: ; heuristic: string; C0
Data_008_6D19:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reveals Mirage", $F1
    db "Lake.", $F0

String_08_06_31:: ; heuristic: string; C0
Data_008_6D2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A magic stone that", $F1
    db "raises the tide.", $F0

String_08_06_32:: ; heuristic: string; C0
Data_008_6D52:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A medal from the", $F1
    db "elemental spirit.", $F0

String_08_06_33:: ; heuristic: string; C0
Data_008_6D75:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The lost soul of a", $F1
    db "princess.", $F0

String_08_06_34:: ; heuristic: string; C0
Data_008_6D92:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A blue flower that", $F1
    db "grows in snow.", $F0

String_08_06_35:: ; heuristic: string; C0
Data_008_6DB4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Transforms users", $F1
    db "into monsters.", $F0

String_08_06_36:: ; heuristic: string; C0
Data_008_6DD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a clam for", $F1
    db "crossing the sea.", $F0

String_08_06_37:: ; heuristic: string; C0
Data_008_6DF9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Destroys what it", $F1
    db "reflects.", $F0

String_08_06_38:: ; heuristic: string; C0
Data_008_6E14:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a cloud", $F1
    db "for flying.", $F0

String_08_06_39:: ; heuristic: string; C0
Data_008_6E30:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary helmet", $F1
    db "found in a cave.", $F0

String_08_06_3A:: ; heuristic: string; C0
Data_008_6E54:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary armor", $F1
    db "found in a tower.", $F0

String_08_06_3B:: ; heuristic: string; C0
Data_008_6E78:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary sword", $F1
    db "found in a castle.", $F0

String_08_06_3C:: ; heuristic: string; C0
Data_008_6E9D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A magical stone", $F1
    db "that glows blue.", $F0

String_08_06_3D:: ; heuristic: string; C0
Data_008_6EBE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A beautiful gold", $F1
    db "ring.", $F0

String_08_06_3E:: ; heuristic: string; C0
Data_008_6ED5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

String_08_06_40:: ; heuristic: string; C0
Data_008_6EE0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 30.", $F0

String_08_06_41:: ; heuristic: string; C0
Data_008_6EF6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 80.", $F0

String_08_06_42:: ; heuristic: string; C0
Data_008_6F0C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 30.", $F0

String_08_06_43:: ; heuristic: string; C0
Data_008_6F22:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 80.", $F0

String_08_06_44:: ; heuristic: string; C0
Data_008_6F38:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 10.", $F0

String_08_06_45:: ; heuristic: string; C0
Data_008_6F4A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 50.", $F0

String_08_06_46:: ; heuristic: string; C0
Data_008_6F5C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 10.", $F0

String_08_06_47:: ; heuristic: string; C0
Data_008_6F6E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 50.", $F0

String_08_06_48:: ; heuristic: string; C0
Data_008_6F80:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 10.", $F0

String_08_06_49:: ; heuristic: string; C0
Data_008_6F92:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 50.", $F0

String_08_06_4A:: ; heuristic: string; C0
Data_008_6FA4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 50.", $F0

String_08_06_4B:: ; heuristic: string; C0
Data_008_6FB6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 100.", $F0

String_08_06_4C:: ; heuristic: string; C0
Data_008_6FC9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to attack spells.", $F0

String_08_06_4D:: ; heuristic: string; C0
Data_008_6FED:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to fire and ice.", $F0

String_08_06_4E:: ; heuristic: string; C0
Data_008_7010:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists confusion,", $F1
    db "poison ", $B6, " sleep.", $F0

String_08_06_4F:: ; heuristic: string; C0
Data_008_7033:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists most", $F1
    db "status skills.", $F0

String_08_06_50:: ; heuristic: string; C0
Data_008_704F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists curse,", $F1
    db "paralysis ", $B6, " death.", $F0

String_08_06_51:: ; heuristic: string; C0
Data_008_7071:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to water skills.", $F0

String_08_06_52:: ; heuristic: string; C0
Data_008_7094:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents skills", $F1
    db "from being sealed.", $F0

String_08_06_53:: ; heuristic: string; C0
Data_008_70B7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 5.", $F0

String_08_06_54:: ; heuristic: string; C0
Data_008_70C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

String_08_06_5A:: ; heuristic: string; C0
Data_008_70D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP by 1", $F1
    db "on every step.", $F0

String_08_06_5B:: ; heuristic: string; C0
Data_008_70F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores MP by 1", $F1
    db "on every step.", $F0

String_08_06_5C:: ; heuristic: string; C0
Data_008_7113:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes max. HP", $F1
    db "gain.", $F0

String_08_06_5D:: ; heuristic: string; C0
Data_008_712A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes max.", $F1
    db "MP gain.", $F0

String_08_06_5E:: ; heuristic: string; C0
Data_008_7141:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes ATK gain", $F1
    db "while growing.", $F0

String_08_06_5F:: ; heuristic: string; C0
Data_008_7162:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes DEF gain", $F1
    db "while growing.", $F0

String_08_06_60:: ; heuristic: string; C0
Data_008_7183:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes AGL gain", $F1
    db "while growing.", $F0

String_08_06_61:: ; heuristic: string; C0
Data_008_71A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes INT gain", $F1
    db "while growing.", $F0

String_08_06_62:: ; heuristic: string; C0
Data_008_71C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

String_08_06_63:: ; heuristic: string; C0
Data_008_71D0:: ; address name
    db $F1, $F0

String_08_06_6F:: ; heuristic: string; C0
Data_008_71D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Checks if monster", $F1
    db "was caught before.", $F0

String_08_07_00:: ; heuristic: string; C0
Data_008_71F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hotblood", $F0

String_08_07_01:: ; heuristic: string; C0
Data_008_7200:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eager", $F0

String_08_07_02:: ; heuristic: string; C0
Data_008_7206:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smug", $F0

String_08_07_03:: ; heuristic: string; C0
Data_008_720B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Earnest", $F0

String_08_07_04:: ; heuristic: string; C0
Data_008_7213:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pushy", $F0

String_08_07_05:: ; heuristic: string; C0
Data_008_7219:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snobby", $F0

String_08_07_06:: ; heuristic: string; C0
Data_008_7220:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reckless", $F0

String_08_07_07:: ; heuristic: string; C0
Data_008_7229:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Daring", $F0

String_08_07_08:: ; heuristic: string; C0
Data_008_7230:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Daredevil", $F0

String_08_07_09:: ; heuristic: string; C0
Data_008_723A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cool", $9E, "Calm", $F0

String_08_07_0A:: ; heuristic: string; C0
Data_008_7244:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Serious", $F0

String_08_07_0B:: ; heuristic: string; C0
Data_008_724C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Selfish", $F0

String_08_07_0C:: ; heuristic: string; C0
Data_008_7254:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Simple", $F0

String_08_07_0D:: ; heuristic: string; C0
Data_008_725B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Innocent", $F0

String_08_07_0E:: ; heuristic: string; C0
Data_008_7264:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prideful", $F0

String_08_07_0F:: ; heuristic: string; C0
Data_008_726D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Nosy", $F0

String_08_07_10:: ; heuristic: string; C0
Data_008_7272:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Whimsy", $F0

String_08_07_11:: ; heuristic: string; C0
Data_008_7279:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spoiled", $F0

String_08_07_12:: ; heuristic: string; C0
Data_008_7281:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smart", $F0

String_08_07_13:: ; heuristic: string; C0
Data_008_7287:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sly", $F0

String_08_07_14:: ; heuristic: string; C0
Data_008_728B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cruel", $F0

String_08_07_15:: ; heuristic: string; C0
Data_008_7291:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shy", $F0

String_08_07_16:: ; heuristic: string; C0
Data_008_7295:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Affable", $F0

String_08_07_17:: ; heuristic: string; C0
Data_008_729D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Coward", $F0

String_08_07_18:: ; heuristic: string; C0
Data_008_72A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gullible", $F0

String_08_07_19:: ; heuristic: string; C0
Data_008_72AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Carefree", $F0

String_08_07_1A:: ; heuristic: string; C0
Data_008_72B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lazy", $F0

String_08_08_00:: ; heuristic: string; C0
Data_008_72BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No items", $F0

String_08_08_01:: ; heuristic: string; C0
Data_008_72C4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Toss this away?", $F0

String_08_08_02:: ; heuristic: string; C0
Data_008_72D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "W can't be", $F1
    db "tossed out.", $F7
    db $F0

String_08_08_03:: ; heuristic: string; C0
Data_008_72EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But nothing", $F1
    db "happened.", $F7
    db $F0

String_08_08_04:: ; heuristic: string; C0
Data_008_7303:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F6, " threw away", $F1
    db "the ", $F9, "W.", $F7
    db $F0

String_08_08_05:: ; heuristic: string; C0
Data_008_7319:: ; address name
    db $F9, $00, $F0

String_08_08_06:: ; heuristic: string; C0
Data_008_731C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F6, " tried using", $F1
    db $F9, "W.", $F7
    db $F2, "But nothing", $F1
    db "happened.", $F7
    db $F0

String_08_08_07:: ; heuristic: string; C0
Data_008_7346:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Toss out the", $F1
    db $F9, "W?", $F0

String_08_08_08:: ; heuristic: string; C0
Data_008_7357:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You can't toss", $F1
    db "that out!", $F7
    db $F0

String_08_08_09:: ; heuristic: string; C0
Data_008_7370:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "That can't be used", $F1
    db "here.", $F7
    db $F0

String_08_08_0A:: ; heuristic: string; C0
Data_008_7389:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Not in use.", $F0

String_08_08_0B:: ; heuristic: string; C0
Data_008_7395:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F6, " inserted the", $F1
    db "key.", $F7
    db $F0

String_08_08_0C:: ; heuristic: string; C0
Data_008_73AA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The key could not", $F1
    db "be used yet.", $F7
    db $F0

String_08_08_0D:: ; heuristic: string; C0
Data_008_73CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You can't save", $F1
    db "here.", $F7
    db $F0

String_08_08_0E:: ; heuristic: string; C0
Data_008_73DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No skills", $F0
    ds $C17, $00
