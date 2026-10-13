SECTION "Bank 0B", ROMX[$4000], BANK[$0B]
    db $0B

; ld de, this bank's string table / BeginStringDisplay
; 2 call sites from 2 routines (e.g. ShowString_Bank0B, DebugMessageTest_Update_ToBeginStringDisplay_Bank0B)
BeginStringDisplay_Bank0B::
Func_00B_4001:: ; address name
    ld de, StringCategories_0B_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_00B_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 6 call sites from 5 routines (e.g. LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case05, LibraryMenu_ShowMonsterEntry_DrawThreeMetaSpritePartsFor5050_Case07, LibraryMenu_ShowMonsterEntry_Case06_ShowString_Bank08, ...)
ShowString_Bank0B::
Func_00B_400F:: ; address name
    call BeginStringDisplay_Bank0B
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_0B_4016::
Data_00B_4016:: ; address name
    dw StringList_0B_401C ; id 0
    dw StringList_0B_421C ; id 1
    dw StringList_0B_4326 ; id 2

; E-0217 (derived: category list of StringCategories_0B_4016; one pointer per wStringIndex)
; record: string
StringList_0B_401C::
Data_00B_401C:: ; address name
    dw String_0B_00_00 ; id 0
    dw String_0B_00_01 ; id 1
    dw String_0B_00_02 ; id 2
    dw String_0B_00_03 ; id 3
    dw String_0B_00_04 ; id 4
    dw String_0B_00_05 ; id 5
    dw String_0B_00_06 ; id 6
    dw String_0B_00_06 ; id 7
    dw String_0B_00_06 ; id 8
    dw String_0B_00_06 ; id 9
    dw String_0B_00_06 ; id 10
    dw String_0B_00_06 ; id 11
    dw String_0B_00_06 ; id 12
    dw String_0B_00_06 ; id 13
    dw String_0B_00_06 ; id 14
    dw String_0B_00_06 ; id 15
    dw String_0B_00_06 ; id 16
    dw String_0B_00_06 ; id 17
    dw String_0B_00_12 ; id 18
    dw String_0B_00_13 ; id 19
    dw String_0B_00_14 ; id 20
    dw String_0B_00_15 ; id 21
    dw String_0B_00_16 ; id 22
    dw String_0B_00_17 ; id 23
    dw String_0B_00_18 ; id 24
    dw String_0B_00_19 ; id 25
    dw String_0B_00_1A ; id 26
    dw String_0B_00_1B ; id 27
    dw String_0B_00_1C ; id 28
    dw String_0B_00_1D ; id 29
    dw String_0B_00_1E ; id 30
    dw String_0B_00_1F ; id 31
    dw String_0B_00_20 ; id 32
    dw String_0B_00_21 ; id 33
    dw String_0B_00_22 ; id 34
    dw String_0B_00_23 ; id 35
    dw String_0B_00_24 ; id 36
    dw String_0B_00_25 ; id 37
    dw String_0B_00_26 ; id 38
    dw String_0B_00_27 ; id 39
    dw String_0B_00_28 ; id 40
    dw String_0B_00_29 ; id 41
    dw String_0B_00_2A ; id 42
    dw String_0B_00_2B ; id 43
    dw String_0B_00_2B ; id 44
    dw String_0B_00_2B ; id 45
    dw String_0B_00_2B ; id 46
    dw String_0B_00_2B ; id 47
    dw String_0B_00_2B ; id 48
    dw String_0B_00_2B ; id 49
    dw String_0B_00_2B ; id 50
    dw String_0B_00_2B ; id 51
    dw String_0B_00_2B ; id 52
    dw String_0B_00_35 ; id 53
    dw String_0B_00_36 ; id 54
    dw String_0B_00_37 ; id 55
    dw String_0B_00_38 ; id 56
    dw String_0B_00_39 ; id 57
    dw String_0B_00_3A ; id 58
    dw String_0B_00_3B ; id 59
    dw String_0B_00_3C ; id 60
    dw String_0B_00_3D ; id 61
    dw String_0B_00_3E ; id 62
    dw String_0B_00_3F ; id 63
    dw String_0B_00_40 ; id 64
    dw String_0B_00_41 ; id 65
    dw String_0B_00_42 ; id 66
    dw String_0B_00_43 ; id 67
    dw String_0B_00_44 ; id 68
    dw String_0B_00_45 ; id 69
    dw String_0B_00_46 ; id 70
    dw String_0B_00_47 ; id 71
    dw String_0B_00_48 ; id 72
    dw String_0B_00_49 ; id 73
    dw String_0B_00_4A ; id 74
    dw String_0B_00_4B ; id 75
    dw String_0B_00_4C ; id 76
    dw String_0B_00_4D ; id 77
    dw String_0B_00_4E ; id 78
    dw String_0B_00_4F ; id 79
    dw String_0B_00_50 ; id 80
    dw String_0B_00_51 ; id 81
    dw String_0B_00_52 ; id 82
    dw String_0B_00_53 ; id 83
    dw String_0B_00_53 ; id 84
    dw String_0B_00_53 ; id 85
    dw String_0B_00_53 ; id 86
    dw String_0B_00_53 ; id 87
    dw String_0B_00_58 ; id 88
    dw String_0B_00_59 ; id 89
    dw String_0B_00_5A ; id 90
    dw String_0B_00_5B ; id 91
    dw String_0B_00_5C ; id 92
    dw String_0B_00_5D ; id 93
    dw String_0B_00_5E ; id 94
    dw String_0B_00_5F ; id 95
    dw String_0B_00_60 ; id 96
    dw String_0B_00_61 ; id 97
    dw String_0B_00_62 ; id 98
    dw String_0B_00_63 ; id 99
    dw String_0B_00_64 ; id 100
    dw String_0B_00_65 ; id 101
    dw String_0B_00_66 ; id 102
    dw String_0B_00_67 ; id 103
    dw String_0B_00_68 ; id 104
    dw String_0B_00_69 ; id 105
    dw String_0B_00_6A ; id 106
    dw String_0B_00_6B ; id 107
    dw String_0B_00_6C ; id 108
    dw String_0B_00_6D ; id 109
    dw String_0B_00_6E ; id 110
    dw String_0B_00_6F ; id 111
    dw String_0B_00_70 ; id 112
    dw String_0B_00_71 ; id 113
    dw String_0B_00_72 ; id 114
    dw String_0B_00_73 ; id 115
    dw String_0B_00_74 ; id 116
    dw String_0B_00_75 ; id 117
    dw String_0B_00_76 ; id 118
    dw String_0B_00_77 ; id 119
    dw String_0B_00_77 ; id 120
    dw String_0B_00_77 ; id 121
    dw String_0B_00_77 ; id 122
    dw String_0B_00_7B ; id 123
    dw String_0B_00_7C ; id 124
    dw String_0B_00_7D ; id 125
    dw String_0B_00_7E ; id 126
    dw String_0B_00_7F ; id 127
    dw String_0B_00_80 ; id 128
    dw String_0B_00_81 ; id 129
    dw String_0B_00_82 ; id 130
    dw String_0B_00_83 ; id 131
    dw String_0B_00_84 ; id 132
    dw String_0B_00_85 ; id 133
    dw String_0B_00_86 ; id 134
    dw String_0B_00_87 ; id 135
    dw String_0B_00_88 ; id 136
    dw String_0B_00_89 ; id 137
    dw String_0B_00_8A ; id 138
    dw String_0B_00_8B ; id 139
    dw String_0B_00_8C ; id 140
    dw String_0B_00_8D ; id 141
    dw String_0B_00_8E ; id 142
    dw String_0B_00_8F ; id 143
    dw String_0B_00_90 ; id 144
    dw String_0B_00_91 ; id 145
    dw String_0B_00_92 ; id 146
    dw String_0B_00_93 ; id 147
    dw String_0B_00_94 ; id 148
    dw String_0B_00_95 ; id 149
    dw String_0B_00_95 ; id 150
    dw String_0B_00_95 ; id 151
    dw String_0B_00_95 ; id 152
    dw String_0B_00_95 ; id 153
    dw String_0B_00_95 ; id 154
    dw String_0B_00_95 ; id 155
    dw String_0B_00_95 ; id 156
    dw String_0B_00_95 ; id 157
    dw String_0B_00_9E ; id 158
    dw String_0B_00_9F ; id 159
    dw String_0B_00_A0 ; id 160
    dw String_0B_00_A1 ; id 161
    dw String_0B_00_A2 ; id 162
    dw String_0B_00_A3 ; id 163
    dw String_0B_00_A4 ; id 164
    dw String_0B_00_A5 ; id 165
    dw String_0B_00_A6 ; id 166
    dw String_0B_00_A7 ; id 167
    dw String_0B_00_A8 ; id 168
    dw String_0B_00_A9 ; id 169
    dw String_0B_00_AA ; id 170
    dw String_0B_00_AB ; id 171
    dw String_0B_00_AC ; id 172
    dw String_0B_00_AD ; id 173
    dw String_0B_00_AE ; id 174
    dw String_0B_00_AF ; id 175
    dw String_0B_00_B0 ; id 176
    dw String_0B_00_B1 ; id 177
    dw String_0B_00_B2 ; id 178
    dw String_0B_00_B3 ; id 179
    dw String_0B_00_B4 ; id 180
    dw String_0B_00_B5 ; id 181
    dw String_0B_00_B6 ; id 182
    dw String_0B_00_B7 ; id 183
    dw String_0B_00_B8 ; id 184
    dw String_0B_00_B8 ; id 185
    dw String_0B_00_B8 ; id 186
    dw String_0B_00_B8 ; id 187
    dw String_0B_00_B8 ; id 188
    dw String_0B_00_B8 ; id 189
    dw String_0B_00_B8 ; id 190
    dw String_0B_00_B8 ; id 191
    dw String_0B_00_B8 ; id 192
    dw String_0B_00_C1 ; id 193
    dw String_0B_00_C2 ; id 194
    dw String_0B_00_C3 ; id 195
    dw String_0B_00_C4 ; id 196
    dw String_0B_00_C5 ; id 197
    dw String_0B_00_C6 ; id 198
    dw String_0B_00_C7 ; id 199
    dw String_0B_00_C8 ; id 200
    dw String_0B_00_C9 ; id 201
    dw String_0B_00_CA ; id 202
    dw String_0B_00_CB ; id 203
    dw String_0B_00_CC ; id 204
    dw String_0B_00_CD ; id 205
    dw String_0B_00_CE ; id 206
    dw String_0B_00_CF ; id 207
    dw String_0B_00_D0 ; id 208
    dw String_0B_00_D1 ; id 209
    dw String_0B_00_D2 ; id 210
    dw String_0B_00_D3 ; id 211
    dw String_0B_00_D4 ; id 212
    dw String_0B_00_D5 ; id 213
    dw String_0B_00_D6 ; id 214
    dw String_0B_00_D7 ; id 215
    dw String_0B_00_D8 ; id 216
    dw String_0B_00_D9 ; id 217
    dw String_0B_00_DA ; id 218
    dw String_0B_00_DA ; id 219
    dw String_0B_00_DA ; id 220
    dw String_0B_00_DA ; id 221
    dw String_0B_00_DA ; id 222
    dw String_0B_00_DA ; id 223
    dw String_0B_00_DA ; id 224
    dw String_0B_00_DA ; id 225
    dw String_0B_00_DA ; id 226
    dw String_0B_00_DA ; id 227
    dw String_0B_00_E4 ; id 228
    dw String_0B_00_E5 ; id 229
    dw String_0B_00_E6 ; id 230
    dw String_0B_00_E7 ; id 231
    dw String_0B_00_E8 ; id 232
    dw String_0B_00_E9 ; id 233
    dw String_0B_00_EA ; id 234
    dw String_0B_00_EB ; id 235
    dw String_0B_00_EC ; id 236
    dw String_0B_00_ED ; id 237
    dw String_0B_00_EE ; id 238
    dw String_0B_00_EF ; id 239
    dw String_0B_00_F0 ; id 240
    dw String_0B_00_F1 ; id 241
    dw String_0B_00_F2 ; id 242
    dw String_0B_00_F3 ; id 243
    dw String_0B_00_F4 ; id 244
    dw String_0B_00_F5 ; id 245
    dw String_0B_00_F6 ; id 246
    dw String_0B_00_F7 ; id 247
    dw String_0B_00_F8 ; id 248
    dw String_0B_00_F9 ; id 249
    dw String_0B_00_FA ; id 250
    dw String_0B_00_FB ; id 251
    dw String_0B_00_FC ; id 252
    dw String_0B_00_FD ; id 253
    dw String_0B_00_FE ; id 254
    dw String_0B_00_FF ; id 255

; E-0217 (derived: category list of StringCategories_0B_4016; one pointer per wStringIndex)
; record: string
StringList_0B_421C::
Data_00B_421C:: ; address name
    dw String_0B_01_00 ; id 0
    dw String_0B_01_01 ; id 1
    dw String_0B_01_01 ; id 2
    dw String_0B_01_01 ; id 3
    dw String_0B_01_01 ; id 4
    dw String_0B_01_01 ; id 5
    dw String_0B_01_01 ; id 6
    dw String_0B_01_07 ; id 7
    dw String_0B_01_08 ; id 8
    dw String_0B_01_09 ; id 9
    dw String_0B_01_0A ; id 10
    dw String_0B_01_0B ; id 11
    dw String_0B_01_0C ; id 12
    dw String_0B_01_0D ; id 13
    dw String_0B_01_0E ; id 14
    dw String_0B_01_0F ; id 15
    dw String_0B_01_10 ; id 16
    dw String_0B_01_11 ; id 17
    dw String_0B_01_12 ; id 18
    dw String_0B_01_13 ; id 19
    dw String_0B_01_14 ; id 20
    dw String_0B_01_15 ; id 21
    dw String_0B_01_16 ; id 22
    dw String_0B_01_17 ; id 23
    dw String_0B_01_18 ; id 24
    dw String_0B_01_19 ; id 25
    dw String_0B_01_1A ; id 26
    dw String_0B_01_1B ; id 27
    dw String_0B_01_1C ; id 28
    dw String_0B_01_1D ; id 29
    dw String_0B_01_1E ; id 30
    dw String_0B_01_1F ; id 31
    dw String_0B_01_20 ; id 32
    dw String_0B_01_21 ; id 33
    dw String_0B_01_21 ; id 34
    dw String_0B_01_21 ; id 35
    dw String_0B_01_21 ; id 36
    dw String_0B_01_21 ; id 37
    dw String_0B_01_21 ; id 38
    dw String_0B_01_21 ; id 39
    dw String_0B_01_21 ; id 40
    dw String_0B_01_21 ; id 41
    dw String_0B_01_2A ; id 42
    dw String_0B_01_2B ; id 43
    dw String_0B_01_2C ; id 44
    dw String_0B_01_2D ; id 45
    dw String_0B_01_2E ; id 46
    dw String_0B_01_2F ; id 47
    dw String_0B_01_30 ; id 48
    dw String_0B_01_31 ; id 49
    dw String_0B_01_32 ; id 50
    dw String_0B_01_33 ; id 51
    dw String_0B_01_34 ; id 52
    dw String_0B_01_35 ; id 53
    dw String_0B_01_36 ; id 54
    dw String_0B_01_37 ; id 55
    dw String_0B_01_38 ; id 56
    dw String_0B_01_39 ; id 57
    dw String_0B_01_3A ; id 58
    dw String_0B_01_3B ; id 59
    dw String_0B_01_3C ; id 60
    dw String_0B_01_3D ; id 61
    dw String_0B_01_3E ; id 62
    dw String_0B_01_3F ; id 63
    dw String_0B_01_40 ; id 64
    dw String_0B_01_41 ; id 65
    dw String_0B_01_42 ; id 66
    dw String_0B_01_43 ; id 67
    dw String_0B_01_44 ; id 68
    dw String_0B_01_45 ; id 69
    dw String_0B_01_46 ; id 70
    dw String_0B_01_47 ; id 71
    dw String_0B_01_48 ; id 72
    dw String_0B_01_49 ; id 73
    dw String_0B_01_49 ; id 74
    dw String_0B_01_49 ; id 75
    dw String_0B_01_49 ; id 76
    dw String_0B_01_4D ; id 77
    dw String_0B_01_4E ; id 78
    dw String_0B_01_4F ; id 79
    dw String_0B_01_50 ; id 80
    dw String_0B_01_51 ; id 81
    dw String_0B_01_52 ; id 82
    dw String_0B_01_53 ; id 83
    dw String_0B_01_54 ; id 84
    dw String_0B_01_55 ; id 85
    dw String_0B_01_56 ; id 86
    dw String_0B_01_57 ; id 87
    dw String_0B_01_58 ; id 88
    dw String_0B_01_59 ; id 89
    dw String_0B_01_5A ; id 90
    dw String_0B_01_5B ; id 91
    dw String_0B_01_5C ; id 92
    dw String_0B_01_5D ; id 93
    dw String_0B_01_5E ; id 94
    dw String_0B_01_5F ; id 95
    dw String_0B_01_60 ; id 96
    dw String_0B_01_61 ; id 97
    dw String_0B_01_62 ; id 98
    dw String_0B_01_63 ; id 99
    dw String_0B_01_64 ; id 100
    dw String_0B_01_65 ; id 101
    dw String_0B_01_66 ; id 102
    dw String_0B_01_67 ; id 103
    dw String_0B_01_68 ; id 104
    dw String_0B_01_69 ; id 105
    dw String_0B_01_6A ; id 106
    dw String_0B_01_6B ; id 107
    dw String_0B_01_6C ; id 108
    dw String_0B_01_6C ; id 109
    dw String_0B_01_6C ; id 110
    dw String_0B_01_6C ; id 111
    dw String_0B_01_70 ; id 112
    dw String_0B_01_71 ; id 113
    dw String_0B_01_72 ; id 114
    dw String_0B_01_73 ; id 115
    dw String_0B_01_74 ; id 116
    dw String_0B_01_75 ; id 117
    dw String_0B_01_76 ; id 118
    dw String_0B_01_77 ; id 119
    dw String_0B_01_78 ; id 120
    dw String_0B_01_79 ; id 121
    dw String_0B_01_7A ; id 122
    dw String_0B_01_7B ; id 123
    dw String_0B_01_7C ; id 124
    dw String_0B_01_7D ; id 125
    dw String_0B_01_7E ; id 126
    dw String_0B_01_7F ; id 127
    dw String_0B_01_80 ; id 128
    dw String_0B_01_81 ; id 129
    dw String_0B_01_82 ; id 130
    dw String_0B_01_83 ; id 131
    dw String_0B_01_84 ; id 132

; E-0217 (derived: category list of StringCategories_0B_4016; one pointer per wStringIndex)
; record: string
StringList_0B_4326::
Data_00B_4326:: ; address name
    dw String_0B_02_00 ; id 0
    dw String_0B_02_01 ; id 1
    dw String_0B_02_02 ; id 2
    dw String_0B_02_03 ; id 3
    dw String_0B_02_04 ; id 4
    dw String_0B_02_05 ; id 5
    dw String_0B_02_06 ; id 6
    dw String_0B_02_07 ; id 7
    dw String_0B_02_08 ; id 8
    dw String_0B_02_09 ; id 9
    dw String_0B_02_0A ; id 10

String_0B_00_00:: ; heuristic: string; C0
Data_00B_433C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "???", $F0

String_0B_00_01:: ; heuristic: string; C0
Data_00B_4340:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Welcome to the", $F1
    db "library.", $FA, $F7
    db $F2, "Which family will", $F1
    db "you check?", $F0

String_0B_00_02:: ; heuristic: string; C0
Data_00B_437A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Come back if you", $F1
    db "need to check up", $FA, $F7
    db $EF, $EE, "on your monster", $EF, $EE, "Catalog.", $F7
    db $F0

String_0B_00_03:: ; heuristic: string; C0
Data_00B_43BD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Which species", $F1
    db "will you check?", $F0

String_0B_00_04:: ; heuristic: string; C0
Data_00B_43DE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: Which family", $F1
    db "will you check?", $F0

String_0B_00_05:: ; heuristic: string; C0
Data_00B_43FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, "*: That family is a", $F1
    db "mystery still", $A4, $F7
    db $F0

String_0B_00_06:: ; heuristic: string; C0
Data_00B_4422:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A slime that has", $F1
    db "dragon's blood.", $F0

String_0B_00_12:: ; heuristic: string; C0
Data_00B_4442:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Recognized by its", $F1
    db "distinctive spots.", $F0

String_0B_00_13:: ; heuristic: string; C0
Data_00B_4467:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Flies by flapping", $F1
    db "ear-like wings.", $F0

String_0B_00_14:: ; heuristic: string; C0
Data_00B_4489:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sunlight redoubles", $F1
    db "its usual power.", $F0

String_0B_00_15:: ; heuristic: string; C0
Data_00B_44AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its rugged shell", $F1
    db "makes it slow.", $F0

String_0B_00_16:: ; heuristic: string; C0
Data_00B_44CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The slime shields", $F1
    db "the knight.", $F0

String_0B_00_17:: ; heuristic: string; C0
Data_00B_44EB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Venom dissolved", $F1
    db "its own body.", $F0

String_0B_00_18:: ; heuristic: string; C0
Data_00B_4509:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Although cubical,", $F1
    db "it is squishy.", $F0

String_0B_00_19:: ; heuristic: string; C0
Data_00B_452A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The body grew hard", $F1
    db "in the hard shell.", $F0

String_0B_00_1A:: ; heuristic: string; C0
Data_00B_4550:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No.1 in softness", $F1
    db "and weakness.", $F0

String_0B_00_1B:: ; heuristic: string; C0
Data_00B_456F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Heals others with", $F1
    db "its tentacles.", $F0

String_0B_00_1C:: ; heuristic: string; C0
Data_00B_4590:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The mane attests", $F1
    db "to its ferocity.", $F0

String_0B_00_1D:: ; heuristic: string; C0
Data_00B_45B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Likes to drop on", $F1
    db "foes heavily.", $F0

String_0B_00_1E:: ; heuristic: string; C0
Data_00B_45D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enhanced for speed", $F1
    db "and durability.", $F0

String_0B_00_1F:: ; heuristic: string; C0
Data_00B_45F4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its huge legs are", $F1
    db "its main assets.", $F0

String_0B_00_20:: ; heuristic: string; C0
Data_00B_4617:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lives up to its", $F1
    db "name in power.", $F0

String_0B_00_21:: ; heuristic: string; C0
Data_00B_4636:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hard and fast, it", $F1
    db "flees quickly.", $F0

String_0B_00_22:: ; heuristic: string; C0
Data_00B_4657:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Extremely hard and", $F1
    db "prone to fleeing.", $F0

String_0B_00_23:: ; heuristic: string; C0
Data_00B_467C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The largest of", $F1
    db "spotted slime.", $F0

String_0B_00_24:: ; heuristic: string; C0
Data_00B_469A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A cheerful slime", $F1
    db "that loves heat.", $F0

String_0B_00_25:: ; heuristic: string; C0
Data_00B_46BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prefers to make", $F1
    db "its enemies laugh.", $F0

String_0B_00_26:: ; heuristic: string; C0
Data_00B_46DF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The halo is used", $F1
    db "to bind enemies.", $F0

String_0B_00_27:: ; heuristic: string; C0
Data_00B_4701:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body is", $F1
    db "extremely hard.", $F0

String_0B_00_28:: ; heuristic: string; C0
Data_00B_471D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its golden body is", $F1
    db "unbreakable.", $F0

String_0B_00_29:: ; heuristic: string; C0
Data_00B_473D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The wise elder", $F1
    db "among slime.", $F0

String_0B_00_2A:: ; heuristic: string; C0
Data_00B_4759:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "What lurks inside", $F1
    db "is a mystery.", $F0

String_0B_00_2B:: ; heuristic: string; C0
Data_00B_4779:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Despite its name,", $F1
    db "it never changes.", $F0

String_0B_00_35:: ; heuristic: string; C0
Data_00B_479D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slow, but heavily", $F1
    db "protected.", $F0

String_0B_00_36:: ; heuristic: string; C0
Data_00B_47BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its beaks never", $F1
    db "miss flying prey.", $F0

String_0B_00_37:: ; heuristic: string; C0
Data_00B_47DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gases in its body", $F1
    db "keep it afloat.", $F0

String_0B_00_38:: ; heuristic: string; C0
Data_00B_47FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Also known as", $F1
    db "butterfly dragon.", $F0

String_0B_00_39:: ; heuristic: string; C0
Data_00B_481E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "An accomplished", $F1
    db "user of swords.", $F0

String_0B_00_3A:: ; heuristic: string; C0
Data_00B_483E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lives quietly in", $F1
    db "poisonous bogs.", $F0

String_0B_00_3B:: ; heuristic: string; C0
Data_00B_485F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stabs with sword-", $F1
    db "like spikes.", $F0

String_0B_00_3C:: ; heuristic: string; C0
Data_00B_487E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Agile and equipped", $F1
    db "with sharp claws.", $F0

String_0B_00_3D:: ; heuristic: string; C0
Data_00B_48A3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Breathes fire of", $F1
    db "great intensity.", $F0

String_0B_00_3E:: ; heuristic: string; C0
Data_00B_48C5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Runs fast, but in", $F1
    db "a comical manner.", $F0

String_0B_00_3F:: ; heuristic: string; C0
Data_00B_48E9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its power is best", $F1
    db "among dragons.", $F0

String_0B_00_40:: ; heuristic: string; C0
Data_00B_490A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It flies with a", $F1
    db "rocking motion.", $F0

String_0B_00_41:: ; heuristic: string; C0
Data_00B_492A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Changes its colors", $F1
    db "to confuse foes.", $F0

String_0B_00_42:: ; heuristic: string; C0
Data_00B_494E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Works and attacks", $F1
    db "in droves.", $F0

String_0B_00_43:: ; heuristic: string; C0
Data_00B_496B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The wings are used", $F1
    db "for intimidation.", $F0

String_0B_00_44:: ; heuristic: string; C0
Data_00B_4990:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Strikes foes with", $F1
    db "venomous fangs.", $F0

String_0B_00_45:: ; heuristic: string; C0
Data_00B_49B2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Adept at making", $F1
    db "aerial attacks.", $F0

String_0B_00_46:: ; heuristic: string; C0
Data_00B_49D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks with its", $F1
    db "long tongue.", $F0

String_0B_00_47:: ; heuristic: string; C0
Data_00B_49F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Breaks foes as if", $F1
    db "they were rocks.", $F0

String_0B_00_48:: ; heuristic: string; C0
Data_00B_4A13:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Great in both", $F1
    db "power and looks.", $F0

String_0B_00_49:: ; heuristic: string; C0
Data_00B_4A32:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shakes its comb", $F1
    db "when facing a foe.", $F0

String_0B_00_4A:: ; heuristic: string; C0
Data_00B_4A55:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spreads its wings", $F1
    db "for intimidation.", $F0

String_0B_00_4B:: ; heuristic: string; C0
Data_00B_4A79:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Strikes hard to KO", $F1
    db "foes instantly.", $F0

String_0B_00_4C:: ; heuristic: string; C0
Data_00B_4A9C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thinks five times", $F1
    db "faster than foes.", $F0

String_0B_00_4D:: ; heuristic: string; C0
Data_00B_4AC0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wildly swings its", $F1
    db "ax in battle.", $F0

String_0B_00_4E:: ; heuristic: string; C0
Data_00B_4AE0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Seeks prey with", $F1
    db "its whiskers.", $F0

String_0B_00_4F:: ; heuristic: string; C0
Data_00B_4AFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The snakes it ate", $F1
    db "became its feet.", $F0

String_0B_00_50:: ; heuristic: string; C0
Data_00B_4B21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons clouds and", $F1
    db "causes rain.", $F0

String_0B_00_51:: ; heuristic: string; C0
Data_00B_4B41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body hardened", $F1
    db "from hibernation.", $F0

String_0B_00_52:: ; heuristic: string; C0
Data_00B_4B65:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Proud of its power", $F1
    db "and enormous size.", $F0

String_0B_00_53:: ; heuristic: string; C0
Data_00B_4B8B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Captures and eats", $F1
    db "foes in one gulp.", $F0

String_0B_00_58:: ; heuristic: string; C0
Data_00B_4BAF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The horn glows to", $F1
    db "confound enemies.", $F0

String_0B_00_59:: ; heuristic: string; C0
Data_00B_4BD3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Flies in close and", $F1
    db "claws savagely.", $F0

String_0B_00_5A:: ; heuristic: string; C0
Data_00B_4BF6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The fluffy fur", $F1
    db "offers protection.", $F0

String_0B_00_5B:: ; heuristic: string; C0
Data_00B_4C18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its armor is made", $F1
    db "of patched leaves.", $F0

String_0B_00_5C:: ; heuristic: string; C0
Data_00B_4C3D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It acts before it", $F1
    db "thinks.", $F0

String_0B_00_5D:: ; heuristic: string; C0
Data_00B_4C57:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It never lets go", $F1
    db "of the skull.", $F0

String_0B_00_5E:: ; heuristic: string; C0
Data_00B_4C76:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shapes wind into", $F1
    db "powerful barriers.", $F0

String_0B_00_5F:: ; heuristic: string; C0
Data_00B_4C9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks prey in a", $F1
    db "biting swarm.", $F0

String_0B_00_60:: ; heuristic: string; C0
Data_00B_4CBA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snags prey with", $F1
    db "its ropy tongue.", $F0

String_0B_00_61:: ; heuristic: string; C0
Data_00B_4CDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dances to cheer up", $F1
    db "the atmosphere.", $F0

String_0B_00_62:: ; heuristic: string; C0
Data_00B_4CFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The horned shell", $F1
    db "is a good weapon.", $F0

String_0B_00_63:: ; heuristic: string; C0
Data_00B_4D21:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its humorous face", $F1
    db "makes it popular.", $F0

String_0B_00_64:: ; heuristic: string; C0
Data_00B_4D45:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Has difficulty", $F1
    db "with the hammer.", $F0

String_0B_00_65:: ; heuristic: string; C0
Data_00B_4D65:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its claws inflict", $F1
    db "wicked damage.", $F0

String_0B_00_66:: ; heuristic: string; C0
Data_00B_4D86:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It is difficult to", $F1
    db "spot in snow.", $F0

String_0B_00_67:: ; heuristic: string; C0
Data_00B_4DA7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It never misses", $F1
    db "with its arrows.", $F0

String_0B_00_68:: ; heuristic: string; C0
Data_00B_4DC8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Never loses in the", $F1
    db "darkness.", $F0

String_0B_00_69:: ; heuristic: string; C0
Data_00B_4DE5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Leaps out of trees", $F1
    db "to attack.", $F0

String_0B_00_6A:: ; heuristic: string; C0
Data_00B_4E03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Burrows using its", $F1
    db "oversized shovel.", $F0

String_0B_00_6B:: ; heuristic: string; C0
Data_00B_4E27:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Flies using its", $F1
    db "ears as wings.", $F0

String_0B_00_6C:: ; heuristic: string; C0
Data_00B_4E46:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its horn slays", $F1
    db "foes painlessly.", $F0

String_0B_00_6D:: ; heuristic: string; C0
Data_00B_4E66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The horns curled", $F1
    db "from butting.", $F0

String_0B_00_6E:: ; heuristic: string; C0
Data_00B_4E85:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moves fast in", $F1
    db "spite of its size.", $F0

String_0B_00_6F:: ; heuristic: string; C0
Data_00B_4EA6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Immobilizes foes", $F1
    db "with its trunk.", $F0

String_0B_00_70:: ; heuristic: string; C0
Data_00B_4EC7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slaughters foes", $F1
    db "with its forelegs.", $F0

String_0B_00_71:: ; heuristic: string; C0
Data_00B_4EEA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Grips and hurls", $F1
    db "foes with horns.", $F0

String_0B_00_72:: ; heuristic: string; C0
Data_00B_4F0B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Friendly despite", $F1
    db "its savage looks.", $F0

String_0B_00_73:: ; heuristic: string; C0
Data_00B_4F2E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sits quietly to", $F1
    db "avoid hunger.", $F0

String_0B_00_74:: ; heuristic: string; C0
Data_00B_4F4C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Uses mean looks to", $F1
    db "intimidate foes.", $F0

String_0B_00_75:: ; heuristic: string; C0
Data_00B_4F70:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A 100-year old cat", $F1
    db "capable of magic.", $F0

String_0B_00_76:: ; heuristic: string; C0
Data_00B_4F95:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Polishes its sword", $F1
    db "shiny every day.", $F0

String_0B_00_77:: ; heuristic: string; C0
Data_00B_4FB9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts mates", $F1
    db "with its plumage.", $F0

String_0B_00_7B:: ; heuristic: string; C0
Data_00B_4FDA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A bird with a bug-", $F1
    db "like body.", $F0

String_0B_00_7C:: ; heuristic: string; C0
Data_00B_4FF8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lack of exercise", $F1
    db "stunted its wings.", $F0

String_0B_00_7D:: ; heuristic: string; C0
Data_00B_501C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The facial flower", $F1
    db "is stuck on.", $F0

String_0B_00_7E:: ; heuristic: string; C0
Data_00B_503B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It spreads its", $F1
    db "limbs and glides.", $F0

String_0B_00_7F:: ; heuristic: string; C0
Data_00B_505C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Very cowardly.", $F1
    db "Likely to flee.", $F0

String_0B_00_80:: ; heuristic: string; C0
Data_00B_507B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Always carries its", $F1
    db "skull roost.", $F0

String_0B_00_81:: ; heuristic: string; C0
Data_00B_509B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Almost invisible", $F1
    db "except for a glow.", $F0

String_0B_00_82:: ; heuristic: string; C0
Data_00B_50BF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It slices through", $F1
    db "water speedily.", $F0

String_0B_00_83:: ; heuristic: string; C0
Data_00B_50E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hides in darkness", $F1
    db "and sneak attacks.", $F0

String_0B_00_84:: ; heuristic: string; C0
Data_00B_5106:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hunts using the", $F1
    db "eyes on its wings.", $F0

String_0B_00_85:: ; heuristic: string; C0
Data_00B_5129:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Constant naps made", $F1
    db "this fowl huge.", $F0

String_0B_00_86:: ; heuristic: string; C0
Data_00B_514C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Delivers harsh", $F1
    db "head-butts.", $F0

String_0B_00_87:: ; heuristic: string; C0
Data_00B_5167:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hoots forlornly", $F1
    db "night after night.", $F0

String_0B_00_88:: ; heuristic: string; C0
Data_00B_518A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pecks foes by", $F1
    db "twisting its neck.", $F0

String_0B_00_89:: ; heuristic: string; C0
Data_00B_51AB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hooks and tears", $F1
    db "with sharp claws.", $F0

String_0B_00_8A:: ; heuristic: string; C0
Data_00B_51CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Has eyes on its", $F1
    db "body and head.", $F0

String_0B_00_8B:: ; heuristic: string; C0
Data_00B_51EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Adept at freezing", $F1
    db "foes immobile.", $F0

String_0B_00_8C:: ; heuristic: string; C0
Data_00B_520D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Incinerates foes", $F1
    db "to nothing.", $F0

String_0B_00_8D:: ; heuristic: string; C0
Data_00B_522A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wraps foes in", $F1
    db "white lightning.", $F0

String_0B_00_8E:: ; heuristic: string; C0
Data_00B_5249:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dives from the sky", $F1
    db "and kicks foes up.", $F0

String_0B_00_8F:: ; heuristic: string; C0
Data_00B_526F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smashes foes flat", $F1
    db "with its body.", $F0

String_0B_00_90:: ; heuristic: string; C0
Data_00B_5290:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dances adroitly", $F1
    db "despite its girth.", $F0

String_0B_00_91:: ; heuristic: string; C0
Data_00B_52B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Has rainbow horns", $F1
    db "and tail.", $F0

String_0B_00_92:: ; heuristic: string; C0
Data_00B_52CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Flies and runs at", $F1
    db "the same speed.", $F0

String_0B_00_93:: ; heuristic: string; C0
Data_00B_52F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thick-skinned and", $F1
    db "powerfully winged.", $F0

String_0B_00_94:: ; heuristic: string; C0
Data_00B_5316:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slides on its", $F1
    db "belly on ice.", $F0

String_0B_00_95:: ; heuristic: string; C0
Data_00B_5332:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Thumps along on", $F1
    db "its thin vines.", $F0

String_0B_00_9E:: ; heuristic: string; C0
Data_00B_5352:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spits fire-hot", $F1
    db "seeds at foes.", $F0

String_0B_00_9F:: ; heuristic: string; C0
Data_00B_5370:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Frail, but sharply", $F1
    db "intelligent.", $F0

String_0B_00_A0:: ; heuristic: string; C0
Data_00B_5390:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It floats rather", $F1
    db "than flies.", $F0

String_0B_00_A1:: ; heuristic: string; C0
Data_00B_53AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spins to fire its", $F1
    db "needles wildly.", $F0

String_0B_00_A2:: ; heuristic: string; C0
Data_00B_53CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Closes its eye and", $F1
    db "mouth to hide.", $F0

String_0B_00_A3:: ; heuristic: string; C0
Data_00B_53F1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Scatters toxic", $F1
    db "spores by dancing.", $F0

String_0B_00_A4:: ; heuristic: string; C0
Data_00B_5413:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its face hardened", $F1
    db "into amber.", $F0

String_0B_00_A5:: ; heuristic: string; C0
Data_00B_5431:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swallows prey with", $F1
    db "its giant tongue.", $F0

String_0B_00_A6:: ; heuristic: string; C0
Data_00B_5456:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks the unwary", $F1
    db "who sit on it.", $F0

String_0B_00_A7:: ; heuristic: string; C0
Data_00B_5478:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body fluids", $F1
    db "cause watery eyes.", $F0

String_0B_00_A8:: ; heuristic: string; C0
Data_00B_549B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dances to make", $F1
    db "foes careless.", $F0

String_0B_00_A9:: ; heuristic: string; C0
Data_00B_54B9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Usually calm, but", $F1
    db "easily enraged.", $F0

String_0B_00_AA:: ; heuristic: string; C0
Data_00B_54DB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Closes its mouth", $F1
    db "to wait for prey.", $F0

String_0B_00_AB:: ; heuristic: string; C0
Data_00B_54FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It glares to lay a", $F1
    db "curse on foes.", $F0

String_0B_00_AC:: ; heuristic: string; C0
Data_00B_5520:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It dies if it", $F1
    db "stops dancing.", $F0

String_0B_00_AD:: ; heuristic: string; C0
Data_00B_553D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fires beans from", $F1
    db "its belly.", $F0

String_0B_00_AE:: ; heuristic: string; C0
Data_00B_5559:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hides underground", $F1
    db "until it gets hot.", $F0

String_0B_00_AF:: ; heuristic: string; C0
Data_00B_557E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eats prey whole", $F1
    db "without chewing.", $F0

String_0B_00_B0:: ; heuristic: string; C0
Data_00B_559F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eats rapidly with", $F1
    db "its three heads.", $F0

String_0B_00_B1:: ; heuristic: string; C0
Data_00B_55C2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Embraces foes and", $F1
    db "drains nutrients.", $F0

String_0B_00_B2:: ; heuristic: string; C0
Data_00B_55E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Immobilizes foes", $F1
    db "with thorny vines.", $F0

String_0B_00_B3:: ; heuristic: string; C0
Data_00B_560A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Represents the", $F1
    db "anger of plants.", $F0

String_0B_00_B4:: ; heuristic: string; C0
Data_00B_562A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A mischievous", $F1
    db "plant elemantal.", $F0

String_0B_00_B5:: ; heuristic: string; C0
Data_00B_5649:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "An intelligent but", $F1
    db "odd ball of fluff.", $F0

String_0B_00_B6:: ; heuristic: string; C0
Data_00B_566F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Forces foes to", $F1
    db "dance with it.", $F0

String_0B_00_B7:: ; heuristic: string; C0
Data_00B_568D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A universal hero", $F1
    db "among its kind.", $F0

String_0B_00_B8:: ; heuristic: string; C0
Data_00B_56AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attacks in a slow,", $F1
    db "deliberate manner.", $F0

String_0B_00_C1:: ; heuristic: string; C0
Data_00B_56D4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its stumpy feet", $F1
    db "limit its speed.", $F0

String_0B_00_C2:: ; heuristic: string; C0
Data_00B_56F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drags prey under", $F1
    db "the ground.", $F0

String_0B_00_C3:: ; heuristic: string; C0
Data_00B_5712:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Scatters dust to", $F1
    db "confuse foes.", $F0

String_0B_00_C4:: ; heuristic: string; C0
Data_00B_5731:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A flower grew onto", $F1
    db "it while in soil.", $F0

String_0B_00_C5:: ; heuristic: string; C0
Data_00B_5756:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Constricts foes", $F1
    db "with its body.", $F0

String_0B_00_C6:: ; heuristic: string; C0
Data_00B_5775:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The lips conceal a", $F1
    db "long tongue.", $F0

String_0B_00_C7:: ; heuristic: string; C0
Data_00B_5795:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its hard shell", $F1
    db "make it tough.", $F0

String_0B_00_C8:: ; heuristic: string; C0
Data_00B_57B3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stabs and sucks", $F1
    db "with its mouth.", $F0

String_0B_00_C9:: ; heuristic: string; C0
Data_00B_57D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small, but moves", $F1
    db "in large groups.", $F0

String_0B_00_CA:: ; heuristic: string; C0
Data_00B_57F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Always hops for", $F1
    db "unknown reasons.", $F0

String_0B_00_CB:: ; heuristic: string; C0
Data_00B_5816:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bites using mouths", $F1
    db "on both ends.", $F0

String_0B_00_CC:: ; heuristic: string; C0
Data_00B_5837:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swings side to", $F1
    db "side as it moves.", $F0

String_0B_00_CD:: ; heuristic: string; C0
Data_00B_5858:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Climbs walls using", $F1
    db "its tentacles.", $F0

String_0B_00_CE:: ; heuristic: string; C0
Data_00B_587A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stifles foes with", $F1
    db "its large wings.", $F0

String_0B_00_CF:: ; heuristic: string; C0
Data_00B_589D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its eyes extend to", $F1
    db "spot far-off foes.", $F0

String_0B_00_D0:: ; heuristic: string; C0
Data_00B_58C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its claws can't", $F1
    db "nick the shell.", $F0

String_0B_00_D1:: ; heuristic: string; C0
Data_00B_58E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The tail stinger", $F1
    db "is the finisher.", $F0

String_0B_00_D2:: ; heuristic: string; C0
Data_00B_5904:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its loud buzzing", $F1
    db "gives it away.", $F0

String_0B_00_D3:: ; heuristic: string; C0
Data_00B_5924:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stabs and hacks", $F1
    db "with its scythes.", $F0

String_0B_00_D4:: ; heuristic: string; C0
Data_00B_5946:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The horn is used", $F1
    db "to hit and parry.", $F0

String_0B_00_D5:: ; heuristic: string; C0
Data_00B_5969:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The sickles are as", $F1
    db "large as its body.", $F0

String_0B_00_D6:: ; heuristic: string; C0
Data_00B_598F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The stinger is a", $F1
    db "fierce weapon.", $F0

String_0B_00_D7:: ; heuristic: string; C0
Data_00B_59AF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dislikes water and", $F1
    db "lives in soil.", $F0

String_0B_00_D8:: ; heuristic: string; C0
Data_00B_59D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Capable of moving", $F1
    db "in any direction.", $F0

String_0B_00_D9:: ; heuristic: string; C0
Data_00B_59F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its many eyes don't", $F1
    db "miss a thing.", $F0

String_0B_00_DA:: ; heuristic: string; C0
Data_00B_5A16:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prefers mischief", $F1
    db "over eating.", $F0

String_0B_00_E4:: ; heuristic: string; C0
Data_00B_5A34:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The tentacles are", $F1
    db "actually snakes.", $F0

String_0B_00_E5:: ; heuristic: string; C0
Data_00B_5A57:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hates getting its", $F1
    db "white fur dirty.", $F0

String_0B_00_E6:: ; heuristic: string; C0
Data_00B_5A7A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Intelligent, but", $F1
    db "far too frail.", $F0

String_0B_00_E7:: ; heuristic: string; C0
Data_00B_5A9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The tentacles are", $F1
    db "tipped with eyes.", $F0

String_0B_00_E8:: ; heuristic: string; C0
Data_00B_5ABE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its eye has a 360-", $F1
    db "degree coverage.", $F0

String_0B_00_E9:: ; heuristic: string; C0
Data_00B_5AE2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Never dismounts", $F1
    db "from the skull.", $F0

String_0B_00_EA:: ; heuristic: string; C0
Data_00B_5B02:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Intimidates with", $F1
    db "red, glaring eyes.", $F0

String_0B_00_EB:: ; heuristic: string; C0
Data_00B_5B26:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its foam lets it", $F1
    db "dodge attacks.", $F0

String_0B_00_EC:: ; heuristic: string; C0
Data_00B_5B46:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small, but deadly", $F1
    db "with spells.", $F0

String_0B_00_ED:: ; heuristic: string; C0
Data_00B_5B65:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Flies incredibly", $F1
    db "fast in mischief.", $F0

String_0B_00_EE:: ; heuristic: string; C0
Data_00B_5B88:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stabs foes through", $F1
    db "with its trident.", $F0

String_0B_00_EF:: ; heuristic: string; C0
Data_00B_5BAD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Loves to fight,", $F1
    db "defeating all.", $F0

String_0B_00_F0:: ; heuristic: string; C0
Data_00B_5BCC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stays red-faced", $F1
    db "from straining.", $F0

String_0B_00_F1:: ; heuristic: string; C0
Data_00B_5BEC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The spear is", $F1
    db "largely for show.", $F0

String_0B_00_F2:: ; heuristic: string; C0
Data_00B_5C0B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swings spiked orbs", $F1
    db "to keep foes away.", $F0

String_0B_00_F3:: ; heuristic: string; C0
Data_00B_5C31:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hides and strikes", $F1
    db "in darkness.", $F0

String_0B_00_F4:: ; heuristic: string; C0
Data_00B_5C50:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Uses its agility", $F1
    db "to confound foes.", $F0

String_0B_00_F5:: ; heuristic: string; C0
Data_00B_5C73:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Even its head is", $F1
    db "full of muscles.", $F0

String_0B_00_F6:: ; heuristic: string; C0
Data_00B_5C95:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The horn and fangs", $F1
    db "are its weapons.", $F0

String_0B_00_F7:: ; heuristic: string; C0
Data_00B_5CB9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Strong. Just", $F1
    db "incredibly so.", $F0

String_0B_00_F8:: ; heuristic: string; C0
Data_00B_5CD5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "What the armor", $F1
    db "hides is unknown.", $F0

String_0B_00_F9:: ; heuristic: string; C0
Data_00B_5CF6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Waits in wells for", $F1
    db "prey to come.", $F0

String_0B_00_FA:: ; heuristic: string; C0
Data_00B_5D17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swings for the", $F1
    db "foe's weak spots.", $F0

String_0B_00_FB:: ; heuristic: string; C0
Data_00B_5D37:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Surprisingly agile", $F1
    db "for its heftiness.", $F0

String_0B_00_FC:: ; heuristic: string; C0
Data_00B_5D5D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The armor gives it", $F1
    db "great power.", $F0

String_0B_00_FD:: ; heuristic: string; C0
Data_00B_5D7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tracks foes", $F1
    db "with three eyes.", $F0

String_0B_00_FE:: ; heuristic: string; C0
Data_00B_5D9A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Seeks out battles", $F1
    db "for enjoyment.", $F0

String_0B_00_FF:: ; heuristic: string; C0
Data_00B_5DBB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "When enraged, the", $F1
    db "horns straighten.", $F0

String_0B_01_00:: ; heuristic: string; C0
Data_00B_5DDF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A cruel demon that", $F1
    db "distorts wishes.", $F0

String_0B_01_01:: ; heuristic: string; C0
Data_00B_5E03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fades in and out", $F1
    db "to scare people.", $F0

String_0B_01_07:: ; heuristic: string; C0
Data_00B_5E25:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Created from the", $F1
    db "bones of dragons.", $F0

String_0B_01_08:: ; heuristic: string; C0
Data_00B_5E48:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It isn't bothered", $F1
    db "by new injuries.", $F0

String_0B_01_09:: ; heuristic: string; C0
Data_00B_5E6A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drags stragglers", $F1
    db "off to death.", $F0

String_0B_01_0A:: ; heuristic: string; C0
Data_00B_5E89:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bandages obscure", $F1
    db "its vision badly.", $F0

String_0B_01_0B:: ; heuristic: string; C0
Data_00B_5EAC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its dark soul", $F1
    db "stained its body.", $F0

String_0B_01_0C:: ; heuristic: string; C0
Data_00B_5ECC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Unable to stop", $F1
    db "fighting in death.", $F0

String_0B_01_0D:: ; heuristic: string; C0
Data_00B_5EEE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It lost its body", $F1
    db "due to magic.", $F0

String_0B_01_0E:: ; heuristic: string; C0
Data_00B_5F0D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rocks side to side", $F1
    db "as it approaches.", $F0

String_0B_01_0F:: ; heuristic: string; C0
Data_00B_5F32:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dead, rotten, and", $F1
    db "not at peace.", $F0

String_0B_01_10:: ; heuristic: string; C0
Data_00B_5F52:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shoots dirt from", $F1
    db "all over its body.", $F0

String_0B_01_11:: ; heuristic: string; C0
Data_00B_5F76:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Capable of going", $F1
    db "through walls.", $F0

String_0B_01_12:: ; heuristic: string; C0
Data_00B_5F96:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A shy soul, it", $F1
    db "swaddles its body.", $F0

String_0B_01_13:: ; heuristic: string; C0
Data_00B_5FB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sneaks up on foes", $F1
    db "from behind.", $F0

String_0B_01_14:: ; heuristic: string; C0
Data_00B_5FD7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The limbs were", $F1
    db "mixed up in death.", $F0

String_0B_01_15:: ; heuristic: string; C0
Data_00B_5FF9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The collar of fire", $F1
    db "is used to attack.", $F0

String_0B_01_16:: ; heuristic: string; C0
Data_00B_601F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its arms were made", $F1
    db "into weapons.", $F0

String_0B_01_17:: ; heuristic: string; C0
Data_00B_6040:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Retains its noble", $F1
    db "nature in death.", $F0

String_0B_01_18:: ; heuristic: string; C0
Data_00B_6063:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Became a zombie", $F1
    db "while still alive.", $F0

String_0B_01_19:: ; heuristic: string; C0
Data_00B_6086:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Will never be", $F1
    db "freed in death.", $F0

String_0B_01_1A:: ; heuristic: string; C0
Data_00B_60A4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slashes repeatedly", $F1
    db "with its six arms.", $F0

String_0B_01_1B:: ; heuristic: string; C0
Data_00B_60CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The four arms move", $F1
    db "independently.", $F0

String_0B_01_1C:: ; heuristic: string; C0
Data_00B_60EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Protects its head", $F1
    db "with both hands.", $F0

String_0B_01_1D:: ; heuristic: string; C0
Data_00B_610F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Shows dedication", $F1
    db "to its mimicry.", $F0

String_0B_01_1E:: ; heuristic: string; C0
Data_00B_6130:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Wandering souls", $F1
    db "gathered as one.", $F0

String_0B_01_1F:: ; heuristic: string; C0
Data_00B_6151:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its thoughts are", $F1
    db "unfathomable.", $F0

String_0B_01_20:: ; heuristic: string; C0
Data_00B_6170:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A proud and strong", $F1
    db "zombie swordsman.", $F0

String_0B_01_21:: ; heuristic: string; C0
Data_00B_6195:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dances if it spots", $F1
    db "anything shiny.", $F0

String_0B_01_2A:: ; heuristic: string; C0
Data_00B_61B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A wand that split", $F1
    db "from its mage.", $F0

String_0B_01_2B:: ; heuristic: string; C0
Data_00B_61D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Falls asleep if", $F1
    db "the flame dies.", $F0

String_0B_01_2C:: ; heuristic: string; C0
Data_00B_61F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A wind-up cuckoo", $F1
    db "that has a soul.", $F0

String_0B_01_2D:: ; heuristic: string; C0
Data_00B_621B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Made of wood that", $F1
    db "is 1000 years old.", $F0

String_0B_01_2E:: ; heuristic: string; C0
Data_00B_6240:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "One of its spikes", $F1
    db "sets off a bomb.", $F0

String_0B_01_2F:: ; heuristic: string; C0
Data_00B_6263:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Traps foes within", $F1
    db "its reflection.", $F0

String_0B_01_30:: ; heuristic: string; C0
Data_00B_6285:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Doomed to wander", $F1
    db "and roam forever.", $F0

String_0B_01_31:: ; heuristic: string; C0
Data_00B_62A8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Controls itself", $F1
    db "with strings.", $F0

String_0B_01_32:: ; heuristic: string; C0
Data_00B_62C6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drags foes into", $F1
    db "mud with others.", $F0

String_0B_01_33:: ; heuristic: string; C0
Data_00B_62E7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Emerged from 10000", $F1
    db "years of sleep.", $F0

String_0B_01_34:: ; heuristic: string; C0
Data_00B_630A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A fully mechanical", $F1
    db "dragon.", $F0

String_0B_01_35:: ; heuristic: string; C0
Data_00B_6325:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slow, so it relies", $F1
    db "on power smashes.", $F0

String_0B_01_36:: ; heuristic: string; C0
Data_00B_634A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tears meat with", $F1
    db "its head and eats.", $F0

String_0B_01_37:: ; heuristic: string; C0
Data_00B_636D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Blows confusing", $F1
    db "smoke when buffed.", $F0

String_0B_01_38:: ; heuristic: string; C0
Data_00B_6390:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Brushes foes until", $F1
    db "they turn all red.", $F0

String_0B_01_39:: ; heuristic: string; C0
Data_00B_63B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Battles until it", $F1
    db "is fully wrecked.", $F0

String_0B_01_3A:: ; heuristic: string; C0
Data_00B_63D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Battles savagely", $F1
    db "without mercy.", $F0

String_0B_01_3B:: ; heuristic: string; C0
Data_00B_63F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bites whoever", $F1
    db "peers inside.", $F0

String_0B_01_3C:: ; heuristic: string; C0
Data_00B_6415:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Descends from the", $F1
    db "sky to seek prey.", $F0

String_0B_01_3D:: ; heuristic: string; C0
Data_00B_6439:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A giant that caked", $F1
    db "itself with magma.", $F0

String_0B_01_3E:: ; heuristic: string; C0
Data_00B_645F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A giant that caked", $F1
    db "itself with ice.", $F0

String_0B_01_3F:: ; heuristic: string; C0
Data_00B_6483:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It bites unwary", $F1
    db "treasure hunters.", $F0

String_0B_01_40:: ; heuristic: string; C0
Data_00B_64A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Like-minded plates", $F1
    db "became a monster.", $F0

String_0B_01_41:: ; heuristic: string; C0
Data_00B_64CA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body dries if", $F1
    db "it stops dancing.", $F0

String_0B_01_42:: ; heuristic: string; C0
Data_00B_64EE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body cracks if", $F1
    db "it tries to talk.", $F0

String_0B_01_43:: ; heuristic: string; C0
Data_00B_6513:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its body breaks if", $F1
    db "it stops moving.", $F0

String_0B_01_44:: ; heuristic: string; C0
Data_00B_6537:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Explodes without", $F1
    db "warning on waking.", $F0

String_0B_01_45:: ; heuristic: string; C0
Data_00B_655B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Proud of its big,", $F1
    db "golden body.", $F0

String_0B_01_46:: ; heuristic: string; C0
Data_00B_657A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes foes dizzy", $F1
    db "by rotating.", $F0

String_0B_01_47:: ; heuristic: string; C0
Data_00B_6598:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Roboster's proto-", $F1
    db "type, but tough.", $F0

String_0B_01_48:: ; heuristic: string; C0
Data_00B_65BA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A judge among", $F1
    db "monsters.", $F0

String_0B_01_49:: ; heuristic: string; C0
Data_00B_65D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small, slippery", $F1
    db "and hard to hit.", $F0

String_0B_01_4D:: ; heuristic: string; C0
Data_00B_65F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Immobilizes foes", $F1
    db "then bites them.", $F0

String_0B_01_4E:: ; heuristic: string; C0
Data_00B_6615:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sits on foes and", $F1
    db "pummels them.", $F0

String_0B_01_4F:: ; heuristic: string; C0
Data_00B_6634:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Suffocates foes", $F1
    db "with its body.", $F0

String_0B_01_50:: ; heuristic: string; C0
Data_00B_6653:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snares foes with", $F1
    db "its tentacles.", $F0

String_0B_01_51:: ; heuristic: string; C0
Data_00B_6673:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Expands its body", $F1
    db "to startle foes.", $F0

String_0B_01_52:: ; heuristic: string; C0
Data_00B_6695:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A fish that is as", $F1
    db "smart as people.", $F0

String_0B_01_53:: ; heuristic: string; C0
Data_00B_66B8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A monster that got", $F1
    db "stuck in a trap.", $F0

String_0B_01_54:: ; heuristic: string; C0
Data_00B_66DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swarms and eats", $F1
    db "foes instantly.", $F0

String_0B_01_55:: ; heuristic: string; C0
Data_00B_66FC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The short legs", $F1
    db "make it sluggish.", $F0

String_0B_01_56:: ; heuristic: string; C0
Data_00B_671D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts prey with", $F1
    db "a lighted antenna.", $F0

String_0B_01_57:: ; heuristic: string; C0
Data_00B_6743:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A demon that rides", $F1
    db "a fish in battle.", $F0

String_0B_01_58:: ; heuristic: string; C0
Data_00B_6768:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Swims straight to", $F1
    db "ram at high speed.", $F0

String_0B_01_59:: ; heuristic: string; C0
Data_00B_678D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Skips through", $F1
    db "water like a frog.", $F0

String_0B_01_5A:: ; heuristic: string; C0
Data_00B_67AE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The pincers can", $F1
    db "cut its own shell.", $F0

String_0B_01_5B:: ; heuristic: string; C0
Data_00B_67D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The pincers are", $F1
    db "sharp, but heavy.", $F0

String_0B_01_5C:: ; heuristic: string; C0
Data_00B_67F3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drowns foes inside", $F1
    db "its turbid body.", $F0

String_0B_01_5D:: ; heuristic: string; C0
Data_00B_6817:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its shell is", $F1
    db "tough to open.", $F0

String_0B_01_5E:: ; heuristic: string; C0
Data_00B_6833:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Remains upright", $F1
    db "even when asleep.", $F0

String_0B_01_5F:: ; heuristic: string; C0
Data_00B_6855:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hides its ugly", $F1
    db "body in a hood.", $F0

String_0B_01_60:: ; heuristic: string; C0
Data_00B_6874:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rampages in the", $F1
    db "sea with swords.", $F0

String_0B_01_61:: ; heuristic: string; C0
Data_00B_6895:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cleaves foes in", $F1
    db "two with its ax.", $F0

String_0B_01_62:: ; heuristic: string; C0
Data_00B_68B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rarely seen as it", $F1
    db "hides in depths.", $F0

String_0B_01_63:: ; heuristic: string; C0
Data_00B_68D9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Spits a huge cloud", $F1
    db "of obscuring ink.", $F0

String_0B_01_64:: ; heuristic: string; C0
Data_00B_68FE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Drifts along with", $F1
    db "deep-sea currents.", $F0

String_0B_01_65:: ; heuristic: string; C0
Data_00B_6923:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its wand indicates", $F1
    db "magical power.", $F0

String_0B_01_66:: ; heuristic: string; C0
Data_00B_6945:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Rare. It lurks", $F1
    db "only in deep seas.", $F0

String_0B_01_67:: ; heuristic: string; C0
Data_00B_6967:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Uses tentacles to", $F1
    db "immobilize foes.", $F0

String_0B_01_68:: ; heuristic: string; C0
Data_00B_698A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The fin on its", $F1
    db "back is a weapon.", $F0

String_0B_01_69:: ; heuristic: string; C0
Data_00B_69AB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its thrashing can", $F1
    db "cause earthquakes.", $F0

String_0B_01_6A:: ; heuristic: string; C0
Data_00B_69D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Floats vacantly in", $F1
    db "the sea at peace.", $F0

String_0B_01_6B:: ; heuristic: string; C0
Data_00B_69F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Small, but capable", $F1
    db "of stretching.", $F0

String_0B_01_6C:: ; heuristic: string; C0
Data_00B_6A17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoLord's first,", $F1
    db "unassuming form.", $F0

String_0B_01_70:: ; heuristic: string; C0
Data_00B_6A3A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoLord's true,", $F1
    db "powerful identity.", $F0

String_0B_01_71:: ; heuristic: string; C0
Data_00B_6A5E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DracoLord's form", $F1
    db "when enraged.", $F0

String_0B_01_72:: ; heuristic: string; C0
Data_00B_6A7C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "An evil cleric who", $F1
    db "can use any spell.", $F0

String_0B_01_73:: ; heuristic: string; C0
Data_00B_6AA2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A being dedicated", $F1
    db "to world chaos.", $F0

String_0B_01_74:: ; heuristic: string; C0
Data_00B_6AC4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Sidoh reborn for ", $F1
    db "total destruction.", $F0

String_0B_01_75:: ; heuristic: string; C0
Data_00B_6AE9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lords over all", $F1
    db "demons with power.", $F0

String_0B_01_76:: ; heuristic: string; C0
Data_00B_6B0B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A Demon Lord that", $F1
    db "uses dark powers.", $F0

String_0B_01_77:: ; heuristic: string; C0
Data_00B_6B2F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The true, final", $F1
    db "form of Zoma.", $F0

String_0B_01_78:: ; heuristic: string; C0
Data_00B_6B4D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A being that seeks", $F1
    db "ultimate power.", $F0

String_0B_01_79:: ; heuristic: string; C0
Data_00B_6B70:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pizzaro's pure and", $F1
    db "real guise.", $F0

String_0B_01_7A:: ; heuristic: string; C0
Data_00B_6B8E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dedicated to chaos", $F1
    db "and domination.", $F0

String_0B_01_7B:: ; heuristic: string; C0
Data_00B_6BB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Purely evil and", $F1
    db "divinely powerful.", $F0

String_0B_01_7C:: ; heuristic: string; C0
Data_00B_6BD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The true, vile", $F1
    db "form of Mirudraas.", $F0

String_0B_01_7D:: ; heuristic: string; C0
Data_00B_6BF6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A Demon Lord that", $F1
    db "uses illusions.", $F0

String_0B_01_7E:: ; heuristic: string; C0
Data_00B_6C18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The Demon Lord of", $F1
    db "all worlds.", $F0

String_0B_01_7F:: ; heuristic: string; C0
Data_00B_6C36:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The true, enraged", $F1
    db "form of DeathMore.", $F0

String_0B_01_80:: ; heuristic: string; C0
Data_00B_6C5B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DeathMore's final", $F1
    db "evolution.", $F0

String_0B_01_81:: ; heuristic: string; C0
Data_00B_6C77:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A being that", $F1
    db "dreams of death.", $F0

String_0B_01_82:: ; heuristic: string; C0
Data_00B_6C95:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its elegance", $F1
    db "belies its greed.", $F0

String_0B_01_83:: ; heuristic: string; C0
Data_00B_6CB4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Its form strikes", $F1
    db "terror in all.", $F0

String_0B_01_84:: ; heuristic: string; C0
Data_00B_6CD4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The collector king", $F1
    db "of Limbo.", $F0

String_0B_02_00:: ; heuristic: string; C0
Data_00B_6CF1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Slime", $F0

String_0B_02_01:: ; heuristic: string; C0
Data_00B_6CF7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Dragon", $F0

String_0B_02_02:: ; heuristic: string; C0
Data_00B_6CFE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Beast", $F0

String_0B_02_03:: ; heuristic: string; C0
Data_00B_6D04:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bird", $F0

String_0B_02_04:: ; heuristic: string; C0
Data_00B_6D09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Plant", $F0

String_0B_02_05:: ; heuristic: string; C0
Data_00B_6D0F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Bug", $F0

String_0B_02_06:: ; heuristic: string; C0
Data_00B_6D13:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon", $F0

String_0B_02_07:: ; heuristic: string; C0
Data_00B_6D19:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Zombie", $F0

String_0B_02_08:: ; heuristic: string; C0
Data_00B_6D20:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Material", $F0

String_0B_02_09:: ; heuristic: string; C0
Data_00B_6D29:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Water", $F0

String_0B_02_0A:: ; heuristic: string; C0
Data_00B_6D2F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "????", $F0
    ds $12CC, $00
