; ROM bank $2F: battle text
; The annotated listing of this bank is build/listing/bank2f.asm.

SECTION "Bank 2F", ROMX[$4000], BANK[$2F]
    db $2f

; ld de, this bank's string table / BeginStringDisplay (E-0353)
BeginStringDisplay_Bank2F::
    ld de, BeginStringDisplay_Bank2F_StringCategories
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank2F (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0353)
ShowString_Bank2F::
    call BeginStringDisplay_Bank2F
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank2F_StringCategories::
    dw StringList_Bank2F_StringCategories_0 ; id 0
    dw StringList_Bank2F_StringCategories_1 ; id 1
    dw StringList_Bank2F_StringCategories_2 ; id 2
    dw StringList_Bank2F_StringCategories_3 ; id 3
    dw StringList_Bank2F_StringCategories_4 ; id 4
    dw StringList_Bank2F_StringCategories_5 ; id 5

; category list of BeginStringDisplay_Bank2F_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank2F_StringCategories_0::
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

StringList_Bank2F_StringCategories_1::
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

StringList_Bank2F_StringCategories_2::
    dw String_2F_02_00 ; id 0
    dw String_2F_02_01 ; id 1
    dw String_2F_02_02 ; id 2
    dw String_2F_02_03 ; id 3

StringList_Bank2F_StringCategories_3::
    dw String_2F_03_00 ; id 0

StringList_Bank2F_StringCategories_4::
    dw String_2F_03_00 ; id 0

StringList_Bank2F_StringCategories_5::
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
    db "<INSTANT><BUF0> appears!<LINE>"
    db "<PAUSE>@"

String_2F_00_01::
    db "<INSTANT>Monsters appear!<LINE>"
    db "<PAUSE>@"

String_2F_00_02::
    db "<INSTANT>Monsters appear!<LINE>"
    db "<PAUSE>@"

String_2F_00_03::
    db "<INSTANT>Monsters appear!<LINE>"
    db "<PAUSE>@"

String_2F_00_04::
    db "<INSTANT>Monsters appear!<LINE>"
    db "<PAUSE>@"

String_2F_00_05::
    db "<INSTANT>Monsters appear!<LINE>"
    db "<PAUSE>@"

String_2F_00_06::
    db "<INSTANT><PLAYER>'s party was<LINE>"
    db "wiped out!<MUSIC_WAIT>", $42, "@"

String_2F_00_07::
    db "<INSTANT>Monsters were<LINE>"
    db "defeated!<SFX_WAIT>", $7e, "<PROMPT>"
    db "@"

String_2F_00_08::
    db "<INSTANT><BUF0> left<LINE>"
    db "the scene.<PAUSE>@"

String_2F_00_09::
    db "<INSTANT>The monsters left<LINE>"
    db "the scene.<PAUSE>@"

String_2F_00_0A::
    db "<INSTANT>The monsters left<LINE>"
    db "the scene.<PAUSE>@"

String_2F_00_0B::
    db "<INSTANT><BUF0><LINE>"
    db "couldn't react!<PAUSE>@"

String_2F_00_0C::
    db "<INSTANT><BUF0><LINE>"
    db "appeared stunned!<PAUSE>@"

String_2F_00_0D::
    db "<INSTANT><BUF0><LINE>"
    db "suddenly attacked!<PAUSE>@"

String_2F_00_0E::
    db "<INSTANT><BUF0> struck<LINE>"
    db "without warning!<PAUSE>@"

String_2F_00_0F::
    db "<INSTANT><BUF0> is<LINE>"
    db "cursed!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0> can't<LINE>"
    db "move!<PAUSE>@"

String_2F_00_10::
    db "<INSTANT><BUF0> is<LINE>"
    db "cursed!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0> lost<LINE>"
    db "<BUF1>HP!<PAUSE>@"

String_2F_00_11::
    db "<INSTANT><BUF0> is<LINE>"
    db "cursed!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0> lost<LINE>"
    db "<BUF1>MP!<PAUSE>@"

String_2F_00_12::
    db "<INSTANT><BUF0> is<LINE>"
    db "cursed!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0> became<LINE>"
    db "confused!<PAUSE>@"

String_2F_00_13::
    db "<INSTANT><BUF0> is<LINE>"
    db "asleep.<PAUSE>@"

String_2F_00_14::
    db "<INSTANT><BUF0> is<LINE>"
    db "confused!<PAUSE>@"

String_2F_00_15::
    db "<INSTANT><BUF0> is a<LINE>"
    db "hunk of iron!<PAUSE>@"

String_2F_00_16::
    db "<INSTANT><BUF0> is<LINE>"
    db "frozen solid!<PAUSE>@"

String_2F_00_17::
    db "<INSTANT><BUF0> is<LINE>"
    db "paralyzed!<PAUSE>@"

String_2F_00_18::
    db "<INSTANT><BUF0> is<LINE>"
    db "dancing along!<PAUSE>@"

String_2F_00_19::
    db "<INSTANT><BUF0> is<LINE>"
    db "shivering!<PAUSE>@"

String_2F_00_1A::
    db "<INSTANT><BUF0> can't<LINE>"
    db "get back up!<PAUSE>@"

String_2F_00_1B::
    db "<INSTANT><BUF0> is<LINE>"
    db "cowering in fear!<PAUSE>@"

String_2F_00_1C::
    db "<INSTANT><BUF0> looks<LINE>"
    db "vacant and lost!<PAUSE>@"

String_2F_00_1D::
    db "<INSTANT>No items allowed<LINE>"
    db "in this battle!<WAIT>"
    db "@"

String_2F_00_1E::
    db "<INSTANT>This item can't be<LINE>"
    db "used in battle!<WAIT>"
    db "@"

String_2F_00_1F::
    db "<INSTANT>There are no<LINE>"
    db "usable items!<WAIT>"
    db "@"

String_2F_00_20::
    db "<INSTANT>No fleeing from<LINE>"
    db "this battle!<WAIT>"
    db "@"

String_2F_00_21::
    db "<INSTANT>Can't use that<LINE>"
    db "skill now!<WAIT>"
    db "@"

String_2F_00_22::
    db "<INSTANT>Selecting<LINE>"
    db "<BUF0>'s move…@"

String_2F_00_23::
    db "<INSTANT>No monsters to<LINE>"
    db "access PLAN.<WAIT>"
    db "@"

String_2F_00_24::
    db "<INSTANT>There is no target<LINE>"
    db "in sight!<WAIT>"
    db "@"

String_2F_00_25::
    db "<INSTANT>That skill can't<LINE>"
    db "be used in battle!<WAIT>"
    db "@"

String_2F_00_26::
    db "<INSTANT>Not enough MP!<LINE>"
    db "<WAIT>"
    db "@"

String_2F_00_27::
    db "<INSTANT>Retire now?<LINE>"
    db "@"

String_2F_00_28::
    db "<INSTANT><BUF0> ignored<LINE>"
    db "orders!<PAUSE>@"

String_2F_00_29::
    db "<INSTANT>It has no usable<LINE>"
    db "battle skills!<PAUSE>@"

String_2F_00_2A::
    db "<INSTANT><BUF0><LINE>"
    db "not recruited!<PAUSE>@"

String_2F_00_2B::
    db "<INSTANT><BUF0><LINE>"
    db "already recruited.<PAUSE>@"

String_2F_00_2C::
    db "<INSTANT>But the escape<LINE>"
    db "route was cut off!<PAUSE>@"

String_2F_00_2D::
    db "<INSTANT>But there's no one<LINE>"
    db "to command!<WAIT>"
    db "@"

String_2F_00_2E::
    db "<INSTANT><BUF0> struck<LINE>"
    db "at full power!<PAUSE>@"

String_2F_00_2F::
    db "<INSTANT><BUF0> tucked<LINE>"
    db "tighter in fear!<PAUSE>@"

String_2F_00_30::
    db "<INSTANT><BUF0><LINE>"
    db "concentrated!<PAUSE>@"

String_2F_00_31::
    db "<INSTANT><BUF0> struck<LINE>"
    db "back, enraged.<PAUSE>@"

String_2F_00_32::
    db "<INSTANT>Light fell softly<LINE>"
    db "on <BUF0>!<PAUSE>@"

String_2F_00_33::
    db "<INSTANT><BUF0> ducked<LINE>"
    db "behind <BUF1>!<PAUSE>@"

String_2F_00_34::
    db "<INSTANT><BUF0> pumped<LINE>"
    db "itself up!<PAUSE>@"

String_2F_00_35::
    db "<INSTANT><BUF0> rolled<LINE>"
    db "out of the way!<PAUSE>@"

String_2F_00_36::
    db "<INSTANT><BUF0> cast<LINE>"
    db "<BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_37::
    db "<INSTANT><BUF0> blew<LINE>"
    db "<BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_38::
    db "<INSTANT><BUF0> danced<LINE>"
    db "the <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_39::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to jump high!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_3A::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to call for help!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_3B::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to yell for help!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_3C::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to pump itself up!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_3D::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to cast a curse!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_3E::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to inhale all!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_3F::
    db "<INSTANT><BUF0> quiets<LINE>"
    db "<BUF2>!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_40::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to sing!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_41::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to make a barrier!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_42::
    db "<INSTANT><BUF0> prayed<LINE>"
    db "to the heavens!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_43::
    db "<INSTANT><BUF0> prayed<LINE>"
    db "for silence!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_44::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to shoot water!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_45::
    db "<INSTANT><BUF0> called<LINE>"
    db "for <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_46::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to use <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_47::
    db "<INSTANT><BUF0> tried<LINE>"
    db "waking <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_48::
    db "<INSTANT><BUF0> got<LINE>"
    db "ready to inhale!<PAUSE>"
    db "<CLEAR><INSTANT>But there weren't<LINE>"
    db "enough MP!<PAUSE>@"

String_2F_00_49::
    db "<INSTANT><BUF0> cast<LINE>"
    db "<BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But its spells<LINE>"
    db "are sealed!<PAUSE>@"

String_2F_00_4A::
    db "<INSTANT><BUF0> tried<LINE>"
    db "blowing <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But its mouth is<LINE>"
    db "sealed tight!<PAUSE>@"

String_2F_00_4B::
    db "<INSTANT><BUF0> danced<LINE>"
    db "the <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But it can't do<LINE>"
    db "the dance!<PAUSE>@"

String_2F_00_4C::
    db "<INSTANT><BUF0> cast<LINE>"
    db "<BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "shattered!<PAUSE>@"

String_2F_00_4D::
    db "<INSTANT><BUF0> cast<LINE>"
    db "<BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But it is sealed<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_4E::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to use <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But it is sealed<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_4F::
    db "<INSTANT><BUF0> blew<LINE>"
    db "<BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But it is sealed<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_50::
    db "<INSTANT><BUF0> tried<LINE>"
    db "waking <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_51::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to call for help!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_52::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to yell for help!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_53::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to build power!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_54::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to pump itself up!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_55::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to jump high!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_56::
    db "<INSTANT><BUF0> danced<LINE>"
    db "the <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_57::
    db "<INSTANT><BUF0> got<LINE>"
    db "ready to inhale!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_58::
    db "<INSTANT><BUF0> quiets<LINE>"
    db "<BUF2>!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_59::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to make a barrier!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_5A::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to inhale all!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_5B::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to sing!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_5C::
    db "<INSTANT><BUF0> prayed<LINE>"
    db "to the heavens!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_5D::
    db "<INSTANT><BUF0> tried<LINE>"
    db "to shoot water!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_5E::
    db "<INSTANT><BUF0> called<LINE>"
    db "for <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_5F::
    db "<INSTANT><BUF0> tried<LINE>"
    db "blowing <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But it is stopped<LINE>"
    db "by a prayer!<PAUSE>@"

String_2F_00_60::
    db "<INSTANT>You threw in<LINE>"
    db "the towel!<PAUSE>@"

String_2F_00_61::
    db "<INSTANT><BUF0> turns left!<LINE>"
    db "<PAUSE>@"

String_2F_00_62::
    db "<INSTANT>No turns left.<LINE>"
    db "This ends a draw.<PAUSE>@"

String_2F_00_63::
    db "<INSTANT>You broke a battle<LINE>"
    db "rule!<PROMPT>"
    db "<CLEAR>You lose.<PROMPT>"
    db "@"

String_2F_00_64::
    db "<INSTANT>Your opponent<LINE>"
    db "broke a rule!<PROMPT>"
    db "<CLEAR>You win.<PROMPT>"
    db "@"

String_2F_00_65::
    db "<INSTANT>That skill isn't<LINE>"
    db "for own use!<PAUSE>@"

String_2F_00_66::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>casting a spell!<LINE>"
    db "But it failed!<PAUSE>@"

String_2F_00_67::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>using a skill!<LINE>"
    db "But it failed!<PAUSE>@"

String_2F_00_68::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>to use magic!<LINE>"
    db "But it failed!<PAUSE>@"

String_2F_00_69::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>casting a spell!<LINE>"
    db "Not enough MP!<PAUSE>@"

String_2F_00_6A::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>using a skill!<LINE>"
    db "Not enough MP!<PAUSE>@"

String_2F_00_6B::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>to use magic!<LINE>"
    db "Not enough MP!<PAUSE>@"

String_2F_00_6C::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>Thordain into<LINE>"
    db "Alldain!<PAUSE>"
    db "<CLEAR><INSTANT>But spell was<LINE>"
    db "sealed!<PAUSE>@"

String_2F_00_6D::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>Thordain into<LINE>"
    db "Alldain!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "shattered!<PAUSE>@"

String_2F_00_6E::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>Blazemost and<LINE>"
    db "Blizzard into<PAUSE>"
    db "<CLEAR><INSTANT>Blitzer!<LINE>"
    db "But it was sealed!<PAUSE>@"

String_2F_00_6F::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>Blazemost and<LINE>"
    db "Blizzard into<PAUSE>"
    db "<CLEAR><INSTANT>Blitzer!<LINE>"
    db "But it shattered!<PAUSE>@"

String_2F_00_70::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>Sacrifice into<LINE>"
    db "Martyr!<PAUSE>"
    db "<CLEAR><INSTANT>But spell was<LINE>"
    db "sealed!<PAUSE>@"

String_2F_00_71::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>Sacrifice into<LINE>"
    db "Martyr!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "shattered!<PAUSE>@"

String_2F_00_72::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> let<PAUSE>"
    db "<CLEAR><INSTANT>loose their entire<LINE>"
    db "magical power!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "sealed!<PAUSE>@"

String_2F_00_73::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> let<PAUSE>"
    db "<CLEAR><INSTANT>loose their entire<LINE>"
    db "magical power!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "shattered!<PAUSE>@"

String_2F_00_74::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> sang<PAUSE>"
    db "<CLEAR><INSTANT>and danced to<LINE>"
    db "summon a spirit!<PAUSE>"
    db "<CLEAR><INSTANT>But the dance was<LINE>"
    db "stopped!<PAUSE>@"

String_2F_00_75::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> sang<PAUSE>"
    db "<CLEAR><INSTANT>and danced to<LINE>"
    db "summon death!<PAUSE>"
    db "<CLEAR><INSTANT>But the dance was<LINE>"
    db "stopped!<PAUSE>@"

String_2F_00_76::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>to turn into a<LINE>"
    db "huge dragon!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "sealed!<PAUSE>@"

String_2F_00_77::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>to turn into a<LINE>"
    db "huge dragon!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "shattered!<PAUSE>@"

String_2F_00_78::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> created<PAUSE>"
    db "<CLEAR><INSTANT>a vacuum for<LINE>"
    db "stealing MP!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "sealed!<PAUSE>@"

String_2F_00_79::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> created<PAUSE>"
    db "<CLEAR><INSTANT>a vacuum for<LINE>"
    db "stealing MP!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "shattered!<PAUSE>@"

String_2F_00_7A::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> danced<PAUSE>"
    db "<CLEAR><INSTANT>in an alluring<LINE>"
    db "fashion!<PAUSE>"
    db "<CLEAR><INSTANT>But the dance was<LINE>"
    db "stopped!<PAUSE>@"

String_2F_00_7B::
    db "<INSTANT><BUF0> can't<LINE>"
    db "eat while asleep!<PAUSE>@"

String_2F_00_7C::
    db "<INSTANT><BUF0> can't<LINE>"
    db "eat while<PAUSE>"
    db "<CLEAR><INSTANT>paralyzed!<PAUSE>@"

String_2F_00_7D::
    db "<INSTANT><BUF0> is a<LINE>"
    db "hunk of iron!<PAUSE>@"

String_2F_00_7E::
    db "<INSTANT><BUF0> brushed<LINE>"
    db "off <BUF2>!<PAUSE>@"

String_2F_00_7F::
    db "<INSTANT>But there is no<LINE>"
    db "one to betray!<WAIT>"
    db "@"

String_2F_00_80::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>using a linked<LINE>"
    db "skill!<PAUSE>"
    db "<CLEAR><INSTANT>But the skill was<LINE>"
    db "sealed!<PAUSE>@"

String_2F_00_81::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> danced <PAUSE>"
    db "<CLEAR><INSTANT>in an alluring<LINE>"
    db "fashion!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "sealed!<PAUSE>@"

String_2F_00_82::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>using a linked<LINE>"
    db "skill!<PAUSE>"
    db "<CLEAR><INSTANT>But the dance was<LINE>"
    db "stopped!<PAUSE>@"

String_2F_00_83::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> created<PAUSE>"
    db "<CLEAR><INSTANT>a vacuum for<LINE>"
    db "stealing MP!<PAUSE>"
    db "<CLEAR><INSTANT>But the dance was<LINE>"
    db "stopped!<PAUSE>@"

String_2F_00_84::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tried<PAUSE>"
    db "<CLEAR><INSTANT>using a linked<LINE>"
    db "skill!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "shattered!<PAUSE>@"

String_2F_00_85::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> danced <PAUSE>"
    db "<CLEAR><INSTANT>in an alluring<LINE>"
    db "fashion!<PAUSE>"
    db "<CLEAR><INSTANT>But the spell was<LINE>"
    db "shattered!<PAUSE>@"

String_2F_00_86::
    db "Monster was<LINE>"
    db "defeated!<SFX_WAIT>", $7e, "<PROMPT>"
    db "@"

String_2F_00_87::
    db "<INSTANT><BUF0>'s party<LINE>"
    db "was wiped out!<MUSIC_WAIT>", $42, "@"

String_2F_00_88::
    db "<INSTANT><BUF0> turn left!<LINE>"
    db "<PAUSE>@"

String_2F_01_00::
    db "<INSTANT><BUF0><LINE>"
    db "attacked!<PAUSE>@"

String_2F_01_01::
    db "<INSTANT><BUF0> cast<LINE>"
    db "<BUF1>!<PAUSE>@"

String_2F_01_02::
    db "<INSTANT><BUF0> loosed<LINE>"
    db "<BUF1>!<PAUSE>@"

String_2F_01_03::
    db "<INSTANT><BUF0> blew<LINE>"
    db "<BUF1>!<PAUSE>@"

String_2F_01_04::
    db "<INSTANT><BUF0> danced<LINE>"
    db "the <BUF1>!<PAUSE>@"

String_2F_01_05::
    db "<INSTANT><BUF1> shot<LINE>"
    db "from <BUF0>!<PAUSE>@"

String_2F_01_06::
    db "<INSTANT><BUF0> closed<LINE>"
    db "in on <BUF1>!<PAUSE>@"

String_2F_01_07::
    db "<INSTANT><BUF0> charged<LINE>"
    db "at <BUF1>!<PAUSE>@"

String_2F_01_08::
    db "<INSTANT><BUF0> charged<LINE>"
    db "receklessly!<PAUSE>@"

String_2F_01_09::
    db "<INSTANT><BUF0> dove at<LINE>"
    db "<BUF1>!<PAUSE>@"

String_2F_01_0A::
    db "<INSTANT><BUF0> flailed<LINE>"
    db "at <BUF1>!<PAUSE>@"

String_2F_01_0B::
    db "<INSTANT><BUF0> smashed<LINE>"
    db "<BUF1>!<PAUSE>@"

String_2F_01_0C::
    db "<INSTANT><BUF0> leapt<LINE>"
    db "high!<PAUSE>@"

String_2F_01_0D::
    db "<INSTANT><BUF0> fell<LINE>"
    db "out of the sky!<PAUSE>@"

String_2F_01_0E::
    db "<INSTANT><BUF0> inhaled<LINE>"
    db "deeply!<PAUSE>@"

String_2F_01_0F::
    db "<INSTANT><BUF1> prayed<LINE>"
    db "to the wind!<PAUSE>"
    db "<CLEAR><INSTANT>Blades of air<LINE>"
    db "slash out!<PAUSE>@"

String_2F_01_10::
    db "<INSTANT><BUF0> yelled<LINE>"
    db "for help!<PAUSE>@"

String_2F_01_11::
    db "<INSTANT><BUF0> called<LINE>"
    db "for help!<PAUSE>@"

String_2F_01_12::
    db "<INSTANT><BUF0><LINE>"
    db "concentrated!<PAUSE>@"

String_2F_01_13::
    db "<INSTANT><BUF0> struck<LINE>"
    db "like the wind!<PAUSE>@"

String_2F_01_14::
    db "<INSTANT><BUF0> struck<LINE>"
    db "mightily!<PAUSE>@"

String_2F_01_15::
    db "<INSTANT><BUF0> whipped<LINE>"
    db "up vicious winds!<PAUSE>@"

String_2F_01_16::
    db "<INSTANT><BUF0> brought<LINE>"
    db "lightning forth!<PAUSE>@"

String_2F_01_17::
    db "<INSTANT><BUF0> hurled<LINE>"
    db "huge boulders!<PAUSE>@"

String_2F_01_18::
    db "<INSTANT><BUF0> brought<LINE>"
    db "on an evil light!<PAUSE>"
    db "<CLEAR><INSTANT>Thunderbolts<LINE>"
    db "hammered down!<PAUSE>@"

String_2F_01_19::
    db "<INSTANT><BUF0> set off<LINE>"
    db "a BigBang!<PAUSE>"
    db "<CLEAR><INSTANT>Wild explosions<LINE>"
    db "echoed repeatedly!<PAUSE>@"

String_2F_01_1A::
    db "<INSTANT><BUF0> loosed<LINE>"
    db "all magic power!<PAUSE>"
    db "<CLEAR><INSTANT>It set off a<LINE>"
    db "wicked explosion!<PAUSE>@"

String_2F_01_1B::
    db "<INSTANT><BUF0> uttered<LINE>"
    db "a curse!<PAUSE>@"

String_2F_01_1C::
    db "<INSTANT><BUF0> kicked<LINE>"
    db "up a sandstorm!<PAUSE>@"

String_2F_01_1D::
    db "<INSTANT><BUF0> did an<LINE>"
    db "odd dance step!<PAUSE>@"

String_2F_01_1E::
    db "<INSTANT><BUF0> gave a<LINE>"
    db "powderpuff massage<PAUSE>"
    db "<CLEAR><INSTANT>to <BUF1>!<LINE>"
    db "<PAUSE>@"

String_2F_01_1F::
    db "<INSTANT><BUF0> licked<LINE>"
    db "<BUF1>'s face!<PAUSE>@"

String_2F_01_20::
    db "<INSTANT><BUF0> kicked<LINE>"
    db "<BUF1> low!<PAUSE>@"

String_2F_01_21::
    db "<INSTANT><BUF1> did a<LINE>"
    db "sweeping kick!<PAUSE>@"

String_2F_01_22::
    db "<INSTANT><BUF0> loosed<LINE>"
    db "a savage roar!<PAUSE>@"

String_2F_01_23::
    db "<INSTANT><BUF0> prayed<LINE>"
    db "to the earth!<PAUSE>@"

String_2F_01_24::
    db "<INSTANT><BUF0> whipped<LINE>"
    db "up <BUF1>!<PAUSE>@"

String_2F_01_25::
    db "<INSTANT><BUF0> quieted<LINE>"
    db "<BUF1>!<PAUSE>@"

String_2F_01_26::
    db "<INSTANT><BUF0> began<LINE>"
    db "to meditate!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0>'s<LINE>"
    db "wounds healed!<PAUSE>@"

String_2F_01_27::
    db "<INSTANT><BUF0> began<LINE>"
    db "singing!<PAUSE>@"

String_2F_01_28::
    db "<INSTANT><BUF0>'s song<LINE>"
    db "ended!<PAUSE>@"

String_2F_01_29::
    db "<INSTANT><BUF0> raised<LINE>"
    db "a water barrier!<PAUSE>@"

String_2F_01_2A::
    db "<INSTANT><BUF0> is<LINE>"
    db "guarding itself!<PAUSE>@"

String_2F_01_2B::
    db "<INSTANT><BUF0> shields<LINE>"
    db "<BUF1>!<PAUSE>@"

String_2F_01_2C::
    db "<INSTANT><BUF0> is<LINE>"
    db "braced for attack!<PAUSE>@"

String_2F_01_2D::
    db "<INSTANT><BUF0> is<LINE>"
    db "ready to parry!<PAUSE>@"

String_2F_01_2E::
    db "<INSTANT><BUF0> is in a<LINE>"
    db "defensive pose!<PAUSE>@"

String_2F_01_2F::
    db "<INSTANT><BUF0> looks<LINE>"
    db "for payback!<PAUSE>@"

String_2F_01_30::
    db "<INSTANT><BUF0> is set<LINE>"
    db "to inhale all!<PAUSE>@"

String_2F_01_31::
    db "<INSTANT><BUF0> prayed<LINE>"
    db "to the heavens!<PAUSE>@"

String_2F_01_32::
    db "<INSTANT><BUF0> prayed<LINE>"
    db "for silence!<PAUSE>"
    db "<CLEAR><INSTANT>An invisible force<LINE>"
    db "pressed down!<PAUSE>@"

String_2F_01_33::
    db "<INSTANT><BUF0> shot<LINE>"
    db "water!<PAUSE>@"

String_2F_01_34::
    db "<INSTANT><BUF0> created<LINE>"
    db "a huge tidal wave!<PAUSE>@"

String_2F_01_35::
    db "<INSTANT><BUF0> took<LINE>"
    db "<BUF1> damage!<PAUSE>@"

String_2F_01_36::
    db "<INSTANT><BUF0> took<LINE>"
    db "<BUF1> damage!<PAUSE>@"

String_2F_01_37::
    db "<INSTANT><BUF0>'s wound<LINE>"
    db "was healed!<PAUSE>@"

String_2F_01_38::
    db "<INSTANT><BUF0> was<LINE>"
    db "brutalized!<PAUSE>@"

String_2F_01_39::
    db "<INSTANT><BUF0>'s DEF<LINE>"
    db "fell by <BUF1>!<PAUSE>@"

String_2F_01_3A::
    db "<INSTANT><BUF0>'s DEF<LINE>"
    db "fell by <BUF1>!<PAUSE>@"

String_2F_01_3B::
    db "<INSTANT><BUF0> can't<LINE>"
    db "use spells now!<PAUSE>@"

String_2F_01_3C::
    db "<INSTANT><BUF0>'s spells<LINE>"
    db "were sealed!<PAUSE>@"

String_2F_01_3D::
    db "<INSTANT><BUF0> was<LINE>"
    db "stripped of <BUF1>MP!<PAUSE>@"

String_2F_01_3E::
    db "<INSTANT><BUF0> was<LINE>"
    db "stripped of <BUF1>MP!<PAUSE>@"

String_2F_01_3F::
    db "<INSTANT><BUF0> started<LINE>"
    db "glowing!<PAUSE>@"

String_2F_01_40::
    db "<INSTANT><BUF0> stole<LINE>"
    db "<BUF1>MP!<PAUSE>@"

String_2F_01_41::
    db "<INSTANT><BUF0> became<LINE>"
    db "befuddled!<PAUSE>@"

String_2F_01_42::
    db "<INSTANT><BUF0> became<LINE>"
    db "confused!<PAUSE>@"

String_2F_01_43::
    db "<INSTANT><BUF0>'s ATK<LINE>"
    db "doubled!<PAUSE>@"

String_2F_01_44::
    db "<INSTANT><BUF0> turned<LINE>"
    db "into a dragon!<PAUSE>@"

String_2F_01_45::
    db "<INSTANT><BUF0>'s DEF<LINE>"
    db "rose by <BUF1>!<PAUSE>@"

String_2F_01_46::
    db "<INSTANT><BUF0>'s party<LINE>"
    db "turned into iron!<PAUSE>@"

String_2F_01_47::
    db "<INSTANT><BUF0> turned<LINE>"
    db "into iron!<PAUSE>@"

String_2F_01_48::
    db "<INSTANT><BUF0>'s AGL<LINE>"
    db "was cut by <BUF1>!<PAUSE>@"

String_2F_01_49::
    db "<INSTANT><BUF0>'s AGL<LINE>"
    db "rose by <BUF1>!<PAUSE>@"

String_2F_01_4A::
    db "<INSTANT><BUF0> is lost<LINE>"
    db "in a daze!<PAUSE>@"

String_2F_01_4B::
    db "<INSTANT>A veil of light<LINE>"
    db "formed before<PAUSE>"
    db "<CLEAR><INSTANT><BUF0>!<LINE>"
    db "<PAUSE>@"

String_2F_01_4C::
    db "<INSTANT>A veil of light<LINE>"
    db "formed before<PAUSE>"
    db "<CLEAR><INSTANT><BUF0>!<LINE>"
    db "<PAUSE>@"

String_2F_01_4D::
    db "<INSTANT>A barrier of<LINE>"
    db "light appeared.<PAUSE>@"

String_2F_01_4E::
    db "<INSTANT><BUF0> was<LINE>"
    db "cured of poison.<PAUSE>@"

String_2F_01_4F::
    db "<INSTANT><BUF0> is no<LINE>"
    db "longer paralyzed.<PAUSE>@"

String_2F_01_50::
    db "<INSTANT><BUF0> came<LINE>"
    db "back to life!<PAUSE>@"

String_2F_01_51::
    db "<INSTANT><BUF0> was<LINE>"
    db "uncursed!<PAUSE>@"

String_2F_01_52::
    db "<INSTANT><BUF0> assumed<LINE>"
    db "<BUF1>'s form!<PAUSE>@"

String_2F_01_53::
    db "<INSTANT>Help arrived from<LINE>"
    db "seemingly nowhere!<PAUSE>@"

String_2F_01_54::
    db "<INSTANT><BUF0> was<LINE>"
    db "blinded by sand!<PAUSE>@"

String_2F_01_55::
    db "<INSTANT><BUF0>'s vision<LINE>"
    db "was harmed!<PAUSE>@"

String_2F_01_56::
    db "<INSTANT><BUF0> was<LINE>"
    db "weakened to magic!<PAUSE>@"

String_2F_01_57::
    db "<INSTANT><BUF0> lost<LINE>"
    db "<BUF1>MP!<PAUSE>@"

String_2F_01_58::
    db "<INSTANT><BUF0> joined<LINE>"
    db "the dancing!<PAUSE>@"

String_2F_01_59::
    db "<INSTANT><BUF0> looks<LINE>"
    db "content!<PAUSE>@"

String_2F_01_5A::
    db "<INSTANT><BUF0> got<LINE>"
    db "goose bumps!<PAUSE>@"

String_2F_01_5B::
    db "<INSTANT><BUF0> got<LINE>"
    db "goose bumps!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0>'s DEF<LINE>"
    db "dropped to '1'!<PAUSE>@"

String_2F_01_5C::
    db "<INSTANT><BUF0> was<LINE>"
    db "shocked!<PAUSE>@"

String_2F_01_5D::
    db "<INSTANT><BUF0> wiped<LINE>"
    db "out!<PAUSE>@"

String_2F_01_5E::
    db "<INSTANT><BUF0> lost<LINE>"
    db "all applied magic!<PAUSE>@"

String_2F_01_5F::
    db "<INSTANT><BUF0> turned<LINE>"
    db "back to normal!<PAUSE>@"

String_2F_01_60::
    db "<INSTANT><BUF0> was<LINE>"
    db "fully cured!<PAUSE>@"

String_2F_01_61::
    db "<INSTANT><BUF0> joined<LINE>"
    db "the battle!<PAUSE>@"

String_2F_01_62::
    db "<INSTANT><BUF0> can't<LINE>"
    db "dance anymore!<PAUSE>@"

String_2F_01_63::
    db "<INSTANT><BUF0> can't<LINE>"
    db "dance anymore!<PAUSE>@"

String_2F_01_64::
    db "<INSTANT><BUF0>'s mouth<LINE>"
    db "was sealed!<PAUSE>@"

String_2F_01_65::
    db "<INSTANT><BUF0>'s mouth<LINE>"
    db "was sealed!<PAUSE>@"

String_2F_01_66::
    db "<INSTANT><BUF0> is a<LINE>"
    db "hunk of iron!<PAUSE>@"

String_2F_01_67::
    db "<INSTANT><BUF0> did not<LINE>"
    db "come back to life!<PAUSE>@"

String_2F_01_68::
    db "<INSTANT>But it failed to<LINE>"
    db "reach <BUF0>!<PAUSE>@"

String_2F_01_69::
    db "<INSTANT>But the call went<LINE>"
    db "unheard!<PAUSE>@"

String_2F_01_6A::
    db "<INSTANT><BUF0> dodged<LINE>"
    db "the breath!<PAUSE>@"

String_2F_01_6B::
    db "<INSTANT><BUF0> quickly<LINE>"
    db "covered its ears!<PAUSE>@"

String_2F_01_6C::
    db "<INSTANT><BUF0> shook<LINE>"
    db "off the sand!<PAUSE>@"

String_2F_01_6D::
    db "<INSTANT><BUF0> closed<LINE>"
    db "its eyes in time!<PAUSE>@"

String_2F_01_6E::
    db "<INSTANT><BUF0> quickly<LINE>"
    db "dodged the attack!<PAUSE>@"

String_2F_01_6F::
    db "<INSTANT><BUF0> wasn't<LINE>"
    db "taken in!<PAUSE>@"

String_2F_01_70::
    db "<INSTANT><BUF0> slid<LINE>"
    db "out of the way!<PAUSE>@"

String_2F_01_71::
    db "<INSTANT><BUF0> was<LINE>"
    db "unharmed!<PAUSE>@"

String_2F_01_72::
    db "<INSTANT>But the prayer<LINE>"
    db "went unanswered!<PAUSE>@"

String_2F_01_73::
    db "<INSTANT><BUF0> was put<LINE>"
    db "to sleep!<PAUSE>@"

String_2F_01_74::
    db "<INSTANT><BUF0> fell<LINE>"
    db "asleep!<PAUSE>@"

String_2F_01_75::
    db "<INSTANT><BUF0> was<LINE>"
    db "poisoned!<PAUSE>@"

String_2F_01_76::
    db "<INSTANT><BUF0> became<LINE>"
    db "paralyzed!<PAUSE>@"

String_2F_01_77::
    db "<INSTANT><BUF0> was<LINE>"
    db "terribly poisoned!<PAUSE>@"

String_2F_01_78::
    db "<INSTANT><BUF0> froze<LINE>"
    db "solid!<PAUSE>@"

String_2F_01_79::
    db "<INSTANT><BUF0> became<LINE>"
    db "frozen solid!<PAUSE>@"

String_2F_01_7A::
    db "<INSTANT><BUF0> struck<LINE>"
    db "back!<PAUSE>@"

String_2F_01_7B::
    db "<INSTANT><BUF0> couldn't<LINE>"
    db "strike back!<PAUSE>@"

String_2F_01_7C::
    db "<INSTANT><BUF0>'s<LINE>"
    db "counterstrike!<PAUSE>@"

String_2F_01_7D::
    db "<INSTANT><BUF0> couldn't<LINE>"
    db "retaliate!<PAUSE>@"

String_2F_01_7E::
    db "<INSTANT><BUF0> blew<LINE>"
    db "back <BUF1>!<PAUSE>@"

String_2F_01_7F::
    db "<INSTANT><BUF0> went<LINE>"
    db "away!<PAUSE>@"

String_2F_01_80::
    db "<INSTANT>The wind around<LINE>"
    db "<BUF0> died!<PAUSE>@"

String_2F_01_81::
    db "<INSTANT>The help went<LINE>"
    db "away!<PAUSE>@"

String_2F_01_82::
    db "<INSTANT><BUF0><LINE>"
    db "woke up!<PAUSE>@"

String_2F_01_83::
    db "<INSTANT><BUF0> snapped<LINE>"
    db "out of confusion!<PAUSE>@"

String_2F_01_84::
    db "<INSTANT><BUF0>'s<LINE>"
    db "Ironize wore off!<PAUSE>@"

String_2F_01_85::
    db "<INSTANT><BUF0>'s wall<LINE>"
    db "of light faded!<PAUSE>@"

String_2F_01_86::
    db "<INSTANT>The giant went<LINE>"
    db "away laughing!<PAUSE>@"

String_2F_01_87::
    db "<INSTANT>The <BUF2><LINE>"
    db "shattered!<PAUSE>@"

String_2F_01_88::
    db "<INSTANT><BUF0> suffers<LINE>"
    db "from poison!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0> lost<LINE>"
    db "<BUF1>HP!<PAUSE>@"

String_2F_01_89::
    db "<INSTANT><BUF0> is<LINE>"
    db "wracked by poison!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0> lost<LINE>"
    db "<BUF1>HP!<PAUSE>@"

String_2F_01_8A::
    db "<INSTANT><BUF0> died!<LINE>"
    db "<PAUSE>@"

String_2F_01_8B::
    db "<INSTANT><BUF0> was<LINE>"
    db "defeated!<PAUSE>@"

String_2F_01_8C::
    db "<INSTANT><BUF0> died<LINE>"
    db "from dancing!<PAUSE>@"

String_2F_01_8D::
    db "<INSTANT><BUF0> dropped<LINE>"
    db "dead!<PAUSE>@"

String_2F_01_8E::
    db "<INSTANT><BUF0> was<LINE>"
    db "instantly slain!<PAUSE>@"

String_2F_01_8F::
    db "<INSTANT>The <BUF0><LINE>"
    db "shattered!<PAUSE>@"

String_2F_01_90::
    db "<INSTANT><BUF0> dropped<LINE>"
    db "dead!<PAUSE>@"

String_2F_01_91::
    db "<INSTANT><BUF0>'s prayer<LINE>"
    db "went unanswered!<PAUSE>@"

String_2F_01_92::
    db "<INSTANT>SealPray was<LINE>"
    db "broken!<PAUSE>@"

String_2F_01_93::
    db "<INSTANT><BUF0> became<LINE>"
    db "flush with power!<PAUSE>@"

String_2F_01_94::
    db "<INSTANT><BUF0> took<LINE>"
    db "the <BUF2> from<PAUSE>"
    db "<CLEAR><INSTANT><BUF1>.<LINE>"
    db "<PAUSE>@"

String_2F_01_95::
    db "<INSTANT><BUF0> ate the<LINE>"
    db "meat happily!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0> grew to<LINE>"
    db "like <BUF1>!<PAUSE>@"

String_2F_01_96::
    db "<INSTANT><BUF0> ate the<LINE>"
    db "meat fearfully!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0> glared<LINE>"
    db "at <BUF1>!<PAUSE>@"

String_2F_01_97::
    db "<INSTANT><BUF0> held the<LINE>"
    db "<BUF2> aloft!<PAUSE>@"

String_2F_01_98::
    db "<INSTANT>A warm light shone<LINE>"
    db "from the Orb!<PAUSE>@"

String_2F_01_99::
    db "<INSTANT><BUF0> gripped<LINE>"
    db "the BeastTail!<PAUSE>@"

String_2F_01_9A::
    db "<INSTANT>The BeastTail<LINE>"
    db "began pointing!<PAUSE>@"

String_2F_01_9B::
    db "<INSTANT><BUF0> held<LINE>"
    db "<BUF2> aloft!<PAUSE>@"

String_2F_01_9C::
    db "<INSTANT>Critical hit!<LINE>"
    db "<PAUSE>@"

String_2F_01_9D::
    db "<INSTANT>A brutal hit!<LINE>"
    db "<PAUSE>@"

String_2F_01_9E::
    db "<INSTANT><BUF0>'s<LINE>"
    db "spells, dances<PAUSE>"
    db "<CLEAR><INSTANT>and breaths are<LINE>"
    db "sealed!<PAUSE>@"

String_2F_01_9F::
    db "<INSTANT><BUF0> used<LINE>"
    db "the <BUF2>!<PAUSE>@"

String_2F_01_A0::
    db "<INSTANT><BUF0> tossed<LINE>"
    db "the <BUF2><PAUSE>"
    db "<CLEAR><INSTANT>at <BUF1>!<LINE>"
    db "<PAUSE>@"

String_2F_01_A1::
    db "<INSTANT><BUF0> held aloft<LINE>"
    db "the SageRock!<PAUSE>@"

String_2F_01_A2::
    db "<INSTANT><BUF0> scattered<LINE>"
    db "the WorldDew!<PAUSE>@"

String_2F_01_A3::
    db "<INSTANT><BUF0> held aloft<LINE>"
    db "the <BUF2>!<PAUSE>"
    db "<CLEAR><INSTANT>Bolts of lightning<LINE>"
    db "lashed out!<PAUSE>@"

String_2F_01_A4::
    db "<INSTANT><BUF0> held aloft<LINE>"
    db "the <BUF2>!<PAUSE>"
    db "<CLEAR><INSTANT>Tornadoes leapt<LINE>"
    db "from its tip!<PAUSE>@"

String_2F_01_A5::
    db "<INSTANT><BUF0> held aloft<LINE>"
    db "the <BUF2>!<PAUSE>"
    db "<CLEAR><INSTANT>A sinister fog<LINE>"
    db "descended!<PAUSE>@"

String_2F_01_A6::
    db "<INSTANT><BUF0> held aloft<LINE>"
    db "the <BUF2>!<PAUSE>"
    db "<CLEAR><INSTANT>A blizzard howls<LINE>"
    db "from its tip!<PAUSE>@"

String_2F_01_A7::
    db "<INSTANT><BUF0> held aloft<LINE>"
    db "the <BUF2>!<PAUSE>"
    db "<CLEAR><INSTANT>Flames leapt from<LINE>"
    db "its tip!<PAUSE>@"

String_2F_01_A8::
    db "<INSTANT><BUF0> set off<LINE>"
    db "a towering geyser!<PAUSE>@"

String_2F_01_A9::
    db "<INSTANT><BUF0> fell<LINE>"
    db "out of the sky!<PAUSE>@"

String_2F_01_AA::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> are<PAUSE>"
    db "<CLEAR><INSTANT>looking for a<LINE>"
    db "chance!<PAUSE>@"

String_2F_01_AB::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> danced<PAUSE>"
    db "<CLEAR><INSTANT>in an alluring<LINE>"
    db "fashion!<PAUSE>@"

String_2F_01_AC::
    db "<INSTANT>The barrier popped<LINE>"
    db "and disappeared!<PAUSE>@"

String_2F_01_AD::
    db "<INSTANT><BUF0> landed<LINE>"
    db "awkwardly!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0> took<LINE>"
    db "<BUF1> damage!<PAUSE>@"

String_2F_01_AE::
    db "<INSTANT><BUF0> landed<LINE>"
    db "awkwardly!<PAUSE>"
    db "<CLEAR><INSTANT><BUF0> took<LINE>"
    db "<BUF1> damage!<PAUSE>@"

String_2F_01_AF::
    db "<INSTANT><BUF0><LINE>"
    db "landed safely!<PAUSE>@"

String_2F_01_B0::
    db "<INSTANT><BUF1> was<LINE>"
    db "shattered!<PAUSE>@"

String_2F_01_B1::
    db "<INSTANT><BUF0> shook<LINE>"
    db "off <BUF1>!<PAUSE>@"

String_2F_01_B2::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> are<PAUSE>"
    db "<CLEAR><INSTANT>shielding a<LINE>"
    db "partner!<PAUSE>@"

String_2F_01_B3::
    db "<INSTANT><BUF0>'s MP was<LINE>"
    db "restored by <BUF1>!<PAUSE>@"

String_2F_01_B4::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> began<PAUSE>"
    db "<CLEAR><INSTANT>to concentrate!<LINE>"
    db "<PAUSE>@"

String_2F_01_B5::
    db "<INSTANT>But <BUF0> was<LINE>"
    db "unaffected!<PAUSE>@"

String_2F_01_B6::
    db "<INSTANT><BUF0> took a<LINE>"
    db "wild swing!<PAUSE>"
    db "<CLEAR><INSTANT>And managed to<LINE>"
    db "hurt only itself!<PAUSE>@"

String_2F_01_B7::
    db "<INSTANT><BUF0> is<LINE>"
    db "shaking in fear!<PAUSE>@"

String_2F_01_B8::
    db "<INSTANT><BUF0> charged<LINE>"
    db "at <BUF1>!<PAUSE>"
    db "<CLEAR><INSTANT>But tripped and<LINE>"
    db "wiped out!<PAUSE>@"

String_2F_01_B9::
    db "<INSTANT><BUF0> became<LINE>"
    db "paralyzed!<PAUSE>@"

String_2F_01_BA::
    db "<INSTANT><BUF0>'s<LINE>"
    db "attack!<PAUSE>"
    db "<CLEAR><INSTANT>It appears unable<LINE>"
    db "to move properly.<PAUSE>@"

String_2F_01_BB::
    db "<INSTANT><BUF0> began<LINE>"
    db "dancing!<PAUSE>@"

String_2F_01_BC::
    db "<INSTANT>A foul being was<LINE>"
    db "summoned!<PAUSE>@"

String_2F_01_BD::
    db "<INSTANT><BUF0> let off<LINE>"
    db "a black cloud!<PAUSE>@"

String_2F_01_BE::
    db "<INSTANT><BUF0><LINE>"
    db "filled with power!<PAUSE>@"

String_2F_01_BF::
    db "<INSTANT><BUF0> lost<LINE>"
    db "all its MP!<PAUSE>@"

String_2F_01_C0::
    db "<INSTANT>", $aa, "Chance, Chance,<LINE>"
    db "Chance…", $aa, "<PAUSE>"
    db "<CLEAR><INSTANT>The call echoed<LINE>"
    db "over and over!<PAUSE>@"

String_2F_01_C1::
    db "<INSTANT>A laughng giant<LINE>"
    db "appeared!<PAUSE>"
    db "<CLEAR><INSTANT>The giant<LINE>"
    db "attacked!<PAUSE>@"

String_2F_01_C2::
    db "<INSTANT>A cold wind swept<LINE>"
    db "<BUF0>'s party!<PAUSE>@"

String_2F_01_C3::
    db "<INSTANT><BUF0>'s MP<LINE>"
    db "was restored!<PAUSE>@"

String_2F_01_C4::
    db "<INSTANT>Meteors rained<LINE>"
    db "from the heavens!<PAUSE>@"

String_2F_01_C5::
    db "<INSTANT>The wall of light<LINE>"
    db "bounced the spell!<PAUSE>@"

String_2F_01_C6::
    db "<INSTANT>The wall of light<LINE>"
    db "bounced the spell!<PAUSE>@"

String_2F_01_C7::
    db "<INSTANT>The wind around<LINE>"
    db "<BUF0> bounced<PAUSE>"
    db "<CLEAR><INSTANT>the attack!<LINE>"
    db "<PAUSE>@"

String_2F_01_C8::
    db "<INSTANT><BUF0> shunted<LINE>"
    db "the attack!<PAUSE>@"

String_2F_01_C9::
    db "<INSTANT><BUF0> failed<LINE>"
    db "to avert attack!<PAUSE>@"

String_2F_01_CA::
    db "<INSTANT><BUF0> guarded<LINE>"
    db "<BUF1>!<PAUSE>@"

String_2F_01_CB::
    db "<INSTANT><BUF0> inhaled<LINE>"
    db "the attack!<PAUSE>@"

String_2F_01_CC::
    db "<INSTANT>But nothing<LINE>"
    db "happened!<PAUSE>@"

String_2F_01_CD::
    db "<INSTANT><BUF0>'s AGL<LINE>"
    db "fell by <BUF1>!<PAUSE>@"

String_2F_01_CE::
    db "<INSTANT><BUF0> didn't<LINE>"
    db "fall asleep!<PAUSE>@"

String_2F_01_CF::
    db "<INSTANT><BUF0> became<LINE>"
    db "more confused!<PAUSE>@"

String_2F_01_D0::
    db "<INSTANT>Miss! <BUF0><LINE>"
    db "was unharmed!<PAUSE>@"

String_2F_01_D1::
    db "<INSTANT>Miss! <BUF0><LINE>"
    db "avoided damage!<PAUSE>@"

String_2F_01_D2::
    db "<INSTANT><BUF0> leapt<LINE>"
    db "out of the way!<PAUSE>@"

String_2F_01_D3::
    db "<INSTANT><BUF0> dropped<LINE>"
    db "dead!<PAUSE>@"
    db "leapt "

String_2F_01_D4::
    db "<INSTANT><BUF0> is<LINE>"
    db "already asleep!<PAUSE>@"

String_2F_01_D5::
    db "<INSTANT><BUF0> is now<LINE>"
    db "weak to spells!<PAUSE>@"

String_2F_01_D6::
    db "<INSTANT>A gentle rain<LINE>"
    db "fell!<PAUSE>@"

String_2F_01_D7::
    db "<INSTANT><BUF0> has<LINE>"
    db "been immobilized!<PAUSE>@"

String_2F_01_D8::
    db "<INSTANT><BUF0> fled!<LINE>"
    db "<PAUSE>@"

String_2F_01_D9::
    db "<INSTANT><BUF0> was<LINE>"
    db "cursed!<PAUSE>@"

String_2F_01_DA::
    db "<INSTANT><BUF0> is<LINE>"
    db "building power!<PAUSE>@"

String_2F_01_DB::
    db "<INSTANT><BUF0> lost<LINE>"
    db "all applied magic!<PAUSE>@"

String_2F_01_DC::
    db "<INSTANT><BUF0> gave a<LINE>"
    db "powderpuff massage<PAUSE>"
    db "<CLEAR><INSTANT>to <BUF1>!<LINE>"
    db "<PAUSE>@"

String_2F_01_DD::
    db "<INSTANT><BUF0> was<LINE>"
    db "blown sky-high!<PAUSE>@"

String_2F_01_DE::
    db "<INSTANT><BUF0> can't<LINE>"
    db "dance anymore!<PAUSE>@"

String_2F_01_DF::
    db "<INSTANT><BUF0> lost<LINE>"
    db "its MP!<PAUSE>@"

String_2F_01_E0::
    db "<INSTANT><BUF0> looks<LINE>"
    db "vacant and lost!<PAUSE>@"

String_2F_01_E1::
    db "<INSTANT><BUF0> is<LINE>"
    db "guarding itself!<PAUSE>@"

String_2F_01_E2::
    db "<INSTANT><BUF0> got<LINE>"
    db "dizzy and fell!<PAUSE>@"

String_2F_01_E3::
    db "<INSTANT><BUF0> lost<LINE>"
    db "balance and fell!<PAUSE>@"

String_2F_01_E4::
    db "<INSTANT><BUF0> dropped<LINE>"
    db "down, asleep!<PAUSE>@"

String_2F_01_E5::
    db "<INSTANT><BUF0> fell<LINE>"
    db "and woke up!<PAUSE>@"

String_2F_01_E6::
    db "<INSTANT><BUF0> can't<LINE>"
    db "eat while<PAUSE>"
    db "<CLEAR><INSTANT>paralyzed!<PAUSE>@"

String_2F_01_E7::
    db "<INSTANT>The wind around<LINE>"
    db "<BUF0> died!<PAUSE>@"

String_2F_01_E8::
    db "<INSTANT><BUF0>'s wall<LINE>"
    db "of light faded!<PAUSE>@"

String_2F_01_E9::
    db "<INSTANT><BUF0>'s water<LINE>"
    db "barrier reacted!<PAUSE>@"

String_2F_01_EA::
    db "<INSTANT><BUF0>'s water<LINE>"
    db "barrier reacted!<PAUSE>@"

String_2F_01_EB::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>Thordain into<LINE>"
    db "Alldain!<PAUSE>@"

String_2F_01_EC::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>BlazeMost and<LINE>"
    db "Blizzard into<PAUSE>"
    db "<CLEAR><INSTANT>Blitzer!<LINE>"
    db "<PAUSE>@"

String_2F_01_ED::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> blasted<PAUSE>"
    db "<CLEAR><INSTANT>a Tidalwave with<LINE>"
    db "shockwaves to make<PAUSE>"
    db "<CLEAR><INSTANT>WaveBlast!<LINE>"
    db "<PAUSE>@"

String_2F_01_EE::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> tore<PAUSE>"
    db "<CLEAR><INSTANT>tornadoes with<LINE>"
    db "shockwaves to<PAUSE>"
    db "<CLEAR><INSTANT>loose RageAir!<LINE>"
    db "<PAUSE>@"

String_2F_01_EF::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> rocked<PAUSE>"
    db "<CLEAR><INSTANT>the ground with<LINE>"
    db "shockwaves to<PAUSE>"
    db "<CLEAR><INSTANT>loose RageQuake!<LINE>"
    db "<PAUSE>@"

String_2F_01_F0::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>two GigaSlashes<LINE>"
    db "into GigaBreak!<PAUSE>@"

String_2F_01_F1::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>two Sacrifices<LINE>"
    db "into Martyr!<PAUSE>@"

String_2F_01_F2::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> hurled<PAUSE>"
    db "<CLEAR><INSTANT><BUF2> high<LINE>"
    db "and dropped it!<PAUSE>@"

String_2F_01_F3::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> made<PAUSE>"
    db "<CLEAR><INSTANT>SquallHit faster<LINE>"
    db "using SpeedUp!<PAUSE>@"

String_2F_01_F4::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> let<PAUSE>"
    db "<CLEAR><INSTANT>loose their entire<LINE>"
    db "magical power!<PAUSE>"
    db "<CLEAR><INSTANT>It set off a<LINE>"
    db "wicked explosion!<PAUSE>@"

String_2F_01_F5::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> sang<PAUSE>"
    db "<CLEAR><INSTANT>and danced to<LINE>"
    db "summon a spirit!<PAUSE>@"

String_2F_01_F6::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> sang<PAUSE>"
    db "<CLEAR><INSTANT>and danced to<LINE>"
    db "summon death!<PAUSE>@"

String_2F_01_F7::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>into a huge<LINE>"
    db "dragon!<PAUSE>@"

String_2F_01_F8::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> turned<PAUSE>"
    db "<CLEAR><INSTANT>their skills into<LINE>"
    db "a wave of energy!<PAUSE>@"

String_2F_01_F9::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> loosed<PAUSE>"
    db "<CLEAR><INSTANT>a white, obscuring<LINE>"
    db "cloud!<PAUSE>@"

String_2F_01_FA::
    db "<INSTANT><BUF0> and<LINE>"
    db "<BUF1> created<PAUSE>"
    db "<CLEAR>a vacuum for<LINE>"
    db "stealing MP!<PAUSE>@"

String_2F_01_FB::
    db "<INSTANT>Critical hit!<LINE>"
    db "<PAUSE>@"

String_2F_01_FC::
    db "<INSTANT>A brutal hit!<LINE>"
    db "<PAUSE>@"

String_2F_01_FD::
    db "<INSTANT><INSTANT>The monsters ate<LINE>"
    db "the meat happily!<PAUSE>"
    db "<CLEAR><INSTANT>The monsters grew<LINE>"
    db "to like <BUF1>!<PAUSE>@"

String_2F_01_FE::
    db "<INSTANT>Monsters ate the<LINE>"
    db "meat fearfully!<PAUSE>"
    db "<CLEAR><INSTANT>Monsters glared<LINE>"
    db "at <BUF1>!<PAUSE>@"

String_2F_01_FF::
    db "<INSTANT>Monsters were<LINE>"
    db "filled with power!<PAUSE>@"

String_2F_02_00::
    db "Fixed@"

String_2F_02_01::
    db "Auto@"

String_2F_02_02::
    db "Fixed@"

String_2F_02_03::
    db "Auto@"

String_2F_03_00::
    db "Undefined@"

String_2F_05_00::
    db "<NEXT><PLAYER>'s party got"
    db "<NEXT><BUF0> EX points!<PROMPT>"
    db "@"

String_2F_05_01::
    db "<MUSIC_WAIT>", $00, "<INSTANT><BUF0> was<LINE>"
    db "promoted to Lv<BUF1>!<MUSIC_WAIT>", $50, "<PROMPT>"
    db "<CLEAR><INSTANT><BUF0><CURSOR>", $06, $00, "Max. HP +<BUF2><CURSOR>", $00, $01
    db "Lv<BUF1><CURSOR>", $06, $01, "Max. MP +<BUF>", $24, "<PROMPT>"
    db "<CLEAR><INSTANT><BUF0><CURSOR>", $06, $00, "ATK +<BUF>", $28, "<CURSOR>", $00, $01
    db "Lv<BUF1><CURSOR>", $06, $01, "DEF +<BUF>", $2c, "<PROMPT>"
    db "<CLEAR><INSTANT><BUF0><CURSOR>", $06, $00, "AGL +<BUF3><CURSOR>", $00, $01
    db "Lv<BUF1><CURSOR>", $06, $01, "INT +<BUF>", $34, "<PROMPT>"
    db "@"

String_2F_05_02::
    db "<INSTANT>At Lv<BUF1>, <BUF0> <LINE>"
    db "learned <BUF2>!<PROMPT>"
    db "@"

String_2F_05_04::
    db "<INSTANT><BUF0>'s <BUF3><LINE>"
    db "became <BUF2>!<PROMPT>"
    db "@"

String_2F_05_05::
    db "<INSTANT><BUF0> devised<LINE>"
    db "<BUF2> from the<PROMPT>"
    db "<CLEAR><INSTANT>skills it knows!<PROMPT>"
    db "@"

String_2F_05_06::
    db "<INSTANT>But <BUF0> can't<LINE>"
    db "learn more skills!<PROMPT>"
    db "<CLEAR><INSTANT>Which skill should<LINE>"
    db "be forgotten?<PROMPT>"
    db "@"

String_2F_05_07::
    db "<INSTANT>Which skill should<LINE>"
    db "be forgotten?<PROMPT>"
    db "@"

String_2F_05_08::
    db "<INSTANT>Forget <BUF2>?<LINE>"
    db "Are you sure?@"

String_2F_05_09::
    db "<INSTANT><BUF2> was<LINE>"
    db "forgottten.<PROMPT>"
    db "@"

String_2F_05_0A::
    db "<INSTANT>It has reached the<LINE>"
    db "limit for growth.<PROMPT>"
    db "@"

String_2F_05_0B::
    db "<INSTANT><BUF0> got up,<LINE>"
    db "looking hopeful.<PROMPT>"
    db "<CLEAR><INSTANT>Allow <BUF0> <LINE>"
    db "to join you?@"

String_2F_05_0C::
    db "<INSTANT><BUF0><LINE>"
    db "departed sadly…<PROMPT>"
    db "@"

String_2F_05_0D::
    db "<INSTANT>But there is no<LINE>"
    db "more room!<PROMPT>"
    db "<CLEAR><INSTANT>Release a monster<LINE>"
    db "to make room?@"

String_2F_05_0E::
    db "<INSTANT>Which will you<LINE>"
    db "choose?@"

String_2F_05_0F::
    db "<INSTANT>You have no eggs.<PROMPT>"
    db "@"

String_2F_05_10::
    db "<INSTANT>Release a monster<LINE>"
    db "for the new one?@"

String_2F_05_11::
    db "<INSTANT>Choose a monster<LINE>"
    db "to release.@"

String_2F_05_12::
    db "<INSTANT>Do you want to<LINE>"
    db "release <BUF1>?@"

String_2F_05_13::
    db "<INSTANT><BUF1> was set<LINE>"
    db "free in the wild.<PROMPT>"
    db "@"

String_2F_05_14::
    db "<INSTANT>Please name<LINE>"
    db "<BUF0>.<PROMPT>"
    db "@"

String_2F_05_15::
    db "<INSTANT>You can't travel<LINE>"
    db "all alone.<PROMPT>"
    db "@"

String_2F_05_16::
    db "<INSTANT>Choose an egg to<LINE>"
    db "abandon.@"

String_2F_05_17::
    db "<INSTANT>Abandon <BUF1>'s<LINE>"
    db "egg?@"

String_2F_05_18::
    db "<INSTANT><BUF1>'s egg<LINE>"
    db "was abandoned.<PROMPT>"
    db "@"

String_2F_05_19::
    db "<INSTANT>Will you take<LINE>"
    db "<BUF0> with you?@"

String_2F_05_1A::
    db "<INSTANT><BUF0> was sent<LINE>"
    db "back to the farm.<MUSIC_WAIT>", $d6, "<PROMPT>"
    db "@"

String_2F_05_1B::
    db "<INSTANT><BUF0> joined the<LINE>"
    db "party.<MUSIC_WAIT>", $d6, "<PROMPT>"
    db "@"

String_2F_05_1C::
    db "<INSTANT>Choose the monster<LINE>"
    db "to send home.@"

String_2F_05_1D::
    db "<INSTANT>Send <BUF0> back to<LINE>"
    db "the farm?@"

String_2F_05_1E::
    db "<INSTANT><BUF0> got up,<LINE>"
    db "looking hopeful.<PROMPT>"
    db "<CLEAR><INSTANT>But it sadly went<LINE>"
    db "away…<PROMPT>"
    db "@"

String_2F_05_1F::
    db "<INSTANT><BUF0> learned<LINE>"
    db "<BUF1>!<WAIT>"
    db "@"

String_2F_05_20::
    db "<INSTANT><BUF0> was sent to<LINE>"
    db "the farm.<MUSIC_WAIT>", $54, "<PROMPT>"
    db "@"

String_2F_05_21::
    db "<INSTANT><BUF0> joined the<LINE>"
    db "party.<MUSIC_WAIT>", $54, "<PROMPT>"
    db "@"
    ds $2d5, $00
