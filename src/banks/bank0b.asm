SECTION "Bank 0B", ROMX[$4000], BANK[$0B]
    db $0b

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank0B::
    ld de, StringCategories_0B_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank0B (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank0B::
    call BeginStringDisplay_Bank0B
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_0B_4016::
    dw StringList_0B_401C ; id 0
    dw StringList_0B_421C ; id 1
    dw StringList_0B_4326 ; id 2

; category list of StringCategories_0B_4016; one pointer per wStringIndex (E-0217)
; record: string
StringList_0B_401C::
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

StringList_0B_421C::
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

StringList_0B_4326::
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

String_0B_00_00::
    db "???", $f0

String_0B_00_01::
    db $eb, "*: Welcome to the", $f1
    db "library.", $fa, $f7
    db $f2, "Which family will", $f1
    db "you check?", $f0

String_0B_00_02::
    db $eb, "*: Come back if you", $f1
    db "need to check up", $fa, $f7
    db $ef, $ee, "on your monster", $ef, $ee, "Catalog.", $f7
    db $f0

String_0B_00_03::
    db $eb, "*: Which species", $f1
    db "will you check?", $f0

String_0B_00_04::
    db $eb, "*: Which family", $f1
    db "will you check?", $f0

String_0B_00_05::
    db $eb, "*: That family is a", $f1
    db "mystery still", $a4, $f7
    db $f0

String_0B_00_06::
    db "A slime that has", $f1
    db "dragon's blood.", $f0

String_0B_00_12::
    db "Recognized by its", $f1
    db "distinctive spots.", $f0

String_0B_00_13::
    db "Flies by flapping", $f1
    db "ear-like wings.", $f0

String_0B_00_14::
    db "Sunlight redoubles", $f1
    db "its usual power.", $f0

String_0B_00_15::
    db "Its rugged shell", $f1
    db "makes it slow.", $f0

String_0B_00_16::
    db "The slime shields", $f1
    db "the knight.", $f0

String_0B_00_17::
    db "Venom dissolved", $f1
    db "its own body.", $f0

String_0B_00_18::
    db "Although cubical,", $f1
    db "it is squishy.", $f0

String_0B_00_19::
    db "The body grew hard", $f1
    db "in the hard shell.", $f0

String_0B_00_1A::
    db "No.1 in softness", $f1
    db "and weakness.", $f0

String_0B_00_1B::
    db "Heals others with", $f1
    db "its tentacles.", $f0

String_0B_00_1C::
    db "The mane attests", $f1
    db "to its ferocity.", $f0

String_0B_00_1D::
    db "Likes to drop on", $f1
    db "foes heavily.", $f0

String_0B_00_1E::
    db "Enhanced for speed", $f1
    db "and durability.", $f0

String_0B_00_1F::
    db "Its huge legs are", $f1
    db "its main assets.", $f0

String_0B_00_20::
    db "Lives up to its", $f1
    db "name in power.", $f0

String_0B_00_21::
    db "Hard and fast, it", $f1
    db "flees quickly.", $f0

String_0B_00_22::
    db "Extremely hard and", $f1
    db "prone to fleeing.", $f0

String_0B_00_23::
    db "The largest of", $f1
    db "spotted slime.", $f0

String_0B_00_24::
    db "A cheerful slime", $f1
    db "that loves heat.", $f0

String_0B_00_25::
    db "Prefers to make", $f1
    db "its enemies laugh.", $f0

String_0B_00_26::
    db "The halo is used", $f1
    db "to bind enemies.", $f0

String_0B_00_27::
    db "Its body is", $f1
    db "extremely hard.", $f0

String_0B_00_28::
    db "Its golden body is", $f1
    db "unbreakable.", $f0

String_0B_00_29::
    db "The wise elder", $f1
    db "among slime.", $f0

String_0B_00_2A::
    db "What lurks inside", $f1
    db "is a mystery.", $f0

String_0B_00_2B::
    db "Despite its name,", $f1
    db "it never changes.", $f0

String_0B_00_35::
    db "Slow, but heavily", $f1
    db "protected.", $f0

String_0B_00_36::
    db "Its beaks never", $f1
    db "miss flying prey.", $f0

String_0B_00_37::
    db "Gases in its body", $f1
    db "keep it afloat.", $f0

String_0B_00_38::
    db "Also known as", $f1
    db "butterfly dragon.", $f0

String_0B_00_39::
    db "An accomplished", $f1
    db "user of swords.", $f0

String_0B_00_3A::
    db "Lives quietly in", $f1
    db "poisonous bogs.", $f0

String_0B_00_3B::
    db "Stabs with sword-", $f1
    db "like spikes.", $f0

String_0B_00_3C::
    db "Agile and equipped", $f1
    db "with sharp claws.", $f0

String_0B_00_3D::
    db "Breathes fire of", $f1
    db "great intensity.", $f0

String_0B_00_3E::
    db "Runs fast, but in", $f1
    db "a comical manner.", $f0

String_0B_00_3F::
    db "Its power is best", $f1
    db "among dragons.", $f0

String_0B_00_40::
    db "It flies with a", $f1
    db "rocking motion.", $f0

String_0B_00_41::
    db "Changes its colors", $f1
    db "to confuse foes.", $f0

String_0B_00_42::
    db "Works and attacks", $f1
    db "in droves.", $f0

String_0B_00_43::
    db "The wings are used", $f1
    db "for intimidation.", $f0

String_0B_00_44::
    db "Strikes foes with", $f1
    db "venomous fangs.", $f0

String_0B_00_45::
    db "Adept at making", $f1
    db "aerial attacks.", $f0

String_0B_00_46::
    db "Attacks with its", $f1
    db "long tongue.", $f0

String_0B_00_47::
    db "Breaks foes as if", $f1
    db "they were rocks.", $f0

String_0B_00_48::
    db "Great in both", $f1
    db "power and looks.", $f0

String_0B_00_49::
    db "Shakes its comb", $f1
    db "when facing a foe.", $f0

String_0B_00_4A::
    db "Spreads its wings", $f1
    db "for intimidation.", $f0

String_0B_00_4B::
    db "Strikes hard to KO", $f1
    db "foes instantly.", $f0

String_0B_00_4C::
    db "Thinks five times", $f1
    db "faster than foes.", $f0

String_0B_00_4D::
    db "Wildly swings its", $f1
    db "ax in battle.", $f0

String_0B_00_4E::
    db "Seeks prey with", $f1
    db "its whiskers.", $f0

String_0B_00_4F::
    db "The snakes it ate", $f1
    db "became its feet.", $f0

String_0B_00_50::
    db "Summons clouds and", $f1
    db "causes rain.", $f0

String_0B_00_51::
    db "Its body hardened", $f1
    db "from hibernation.", $f0

String_0B_00_52::
    db "Proud of its power", $f1
    db "and enormous size.", $f0

String_0B_00_53::
    db "Captures and eats", $f1
    db "foes in one gulp.", $f0

String_0B_00_58::
    db "The horn glows to", $f1
    db "confound enemies.", $f0

String_0B_00_59::
    db "Flies in close and", $f1
    db "claws savagely.", $f0

String_0B_00_5A::
    db "The fluffy fur", $f1
    db "offers protection.", $f0

String_0B_00_5B::
    db "Its armor is made", $f1
    db "of patched leaves.", $f0

String_0B_00_5C::
    db "It acts before it", $f1
    db "thinks.", $f0

String_0B_00_5D::
    db "It never lets go", $f1
    db "of the skull.", $f0

String_0B_00_5E::
    db "Shapes wind into", $f1
    db "powerful barriers.", $f0

String_0B_00_5F::
    db "Attacks prey in a", $f1
    db "biting swarm.", $f0

String_0B_00_60::
    db "Snags prey with", $f1
    db "its ropy tongue.", $f0

String_0B_00_61::
    db "Dances to cheer up", $f1
    db "the atmosphere.", $f0

String_0B_00_62::
    db "The horned shell", $f1
    db "is a good weapon.", $f0

String_0B_00_63::
    db "Its humorous face", $f1
    db "makes it popular.", $f0

String_0B_00_64::
    db "Has difficulty", $f1
    db "with the hammer.", $f0

String_0B_00_65::
    db "Its claws inflict", $f1
    db "wicked damage.", $f0

String_0B_00_66::
    db "It is difficult to", $f1
    db "spot in snow.", $f0

String_0B_00_67::
    db "It never misses", $f1
    db "with its arrows.", $f0

String_0B_00_68::
    db "Never loses in the", $f1
    db "darkness.", $f0

String_0B_00_69::
    db "Leaps out of trees", $f1
    db "to attack.", $f0

String_0B_00_6A::
    db "Burrows using its", $f1
    db "oversized shovel.", $f0

String_0B_00_6B::
    db "Flies using its", $f1
    db "ears as wings.", $f0

String_0B_00_6C::
    db "Its horn slays", $f1
    db "foes painlessly.", $f0

String_0B_00_6D::
    db "The horns curled", $f1
    db "from butting.", $f0

String_0B_00_6E::
    db "Moves fast in", $f1
    db "spite of its size.", $f0

String_0B_00_6F::
    db "Immobilizes foes", $f1
    db "with its trunk.", $f0

String_0B_00_70::
    db "Slaughters foes", $f1
    db "with its forelegs.", $f0

String_0B_00_71::
    db "Grips and hurls", $f1
    db "foes with horns.", $f0

String_0B_00_72::
    db "Friendly despite", $f1
    db "its savage looks.", $f0

String_0B_00_73::
    db "Sits quietly to", $f1
    db "avoid hunger.", $f0

String_0B_00_74::
    db "Uses mean looks to", $f1
    db "intimidate foes.", $f0

String_0B_00_75::
    db "A 100-year old cat", $f1
    db "capable of magic.", $f0

String_0B_00_76::
    db "Polishes its sword", $f1
    db "shiny every day.", $f0

String_0B_00_77::
    db "Attracts mates", $f1
    db "with its plumage.", $f0

String_0B_00_7B::
    db "A bird with a bug-", $f1
    db "like body.", $f0

String_0B_00_7C::
    db "Lack of exercise", $f1
    db "stunted its wings.", $f0

String_0B_00_7D::
    db "The facial flower", $f1
    db "is stuck on.", $f0

String_0B_00_7E::
    db "It spreads its", $f1
    db "limbs and glides.", $f0

String_0B_00_7F::
    db "Very cowardly.", $f1
    db "Likely to flee.", $f0

String_0B_00_80::
    db "Always carries its", $f1
    db "skull roost.", $f0

String_0B_00_81::
    db "Almost invisible", $f1
    db "except for a glow.", $f0

String_0B_00_82::
    db "It slices through", $f1
    db "water speedily.", $f0

String_0B_00_83::
    db "Hides in darkness", $f1
    db "and sneak attacks.", $f0

String_0B_00_84::
    db "Hunts using the", $f1
    db "eyes on its wings.", $f0

String_0B_00_85::
    db "Constant naps made", $f1
    db "this fowl huge.", $f0

String_0B_00_86::
    db "Delivers harsh", $f1
    db "head-butts.", $f0

String_0B_00_87::
    db "Hoots forlornly", $f1
    db "night after night.", $f0

String_0B_00_88::
    db "Pecks foes by", $f1
    db "twisting its neck.", $f0

String_0B_00_89::
    db "Hooks and tears", $f1
    db "with sharp claws.", $f0

String_0B_00_8A::
    db "Has eyes on its", $f1
    db "body and head.", $f0

String_0B_00_8B::
    db "Adept at freezing", $f1
    db "foes immobile.", $f0

String_0B_00_8C::
    db "Incinerates foes", $f1
    db "to nothing.", $f0

String_0B_00_8D::
    db "Wraps foes in", $f1
    db "white lightning.", $f0

String_0B_00_8E::
    db "Dives from the sky", $f1
    db "and kicks foes up.", $f0

String_0B_00_8F::
    db "Smashes foes flat", $f1
    db "with its body.", $f0

String_0B_00_90::
    db "Dances adroitly", $f1
    db "despite its girth.", $f0

String_0B_00_91::
    db "Has rainbow horns", $f1
    db "and tail.", $f0

String_0B_00_92::
    db "Flies and runs at", $f1
    db "the same speed.", $f0

String_0B_00_93::
    db "Thick-skinned and", $f1
    db "powerfully winged.", $f0

String_0B_00_94::
    db "Slides on its", $f1
    db "belly on ice.", $f0

String_0B_00_95::
    db "Thumps along on", $f1
    db "its thin vines.", $f0

String_0B_00_9E::
    db "Spits fire-hot", $f1
    db "seeds at foes.", $f0

String_0B_00_9F::
    db "Frail, but sharply", $f1
    db "intelligent.", $f0

String_0B_00_A0::
    db "It floats rather", $f1
    db "than flies.", $f0

String_0B_00_A1::
    db "Spins to fire its", $f1
    db "needles wildly.", $f0

String_0B_00_A2::
    db "Closes its eye and", $f1
    db "mouth to hide.", $f0

String_0B_00_A3::
    db "Scatters toxic", $f1
    db "spores by dancing.", $f0

String_0B_00_A4::
    db "Its face hardened", $f1
    db "into amber.", $f0

String_0B_00_A5::
    db "Swallows prey with", $f1
    db "its giant tongue.", $f0

String_0B_00_A6::
    db "Attacks the unwary", $f1
    db "who sit on it.", $f0

String_0B_00_A7::
    db "Its body fluids", $f1
    db "cause watery eyes.", $f0

String_0B_00_A8::
    db "Dances to make", $f1
    db "foes careless.", $f0

String_0B_00_A9::
    db "Usually calm, but", $f1
    db "easily enraged.", $f0

String_0B_00_AA::
    db "Closes its mouth", $f1
    db "to wait for prey.", $f0

String_0B_00_AB::
    db "It glares to lay a", $f1
    db "curse on foes.", $f0

String_0B_00_AC::
    db "It dies if it", $f1
    db "stops dancing.", $f0

String_0B_00_AD::
    db "Fires beans from", $f1
    db "its belly.", $f0

String_0B_00_AE::
    db "Hides underground", $f1
    db "until it gets hot.", $f0

String_0B_00_AF::
    db "Eats prey whole", $f1
    db "without chewing.", $f0

String_0B_00_B0::
    db "Eats rapidly with", $f1
    db "its three heads.", $f0

String_0B_00_B1::
    db "Embraces foes and", $f1
    db "drains nutrients.", $f0

String_0B_00_B2::
    db "Immobilizes foes", $f1
    db "with thorny vines.", $f0

String_0B_00_B3::
    db "Represents the", $f1
    db "anger of plants.", $f0

String_0B_00_B4::
    db "A mischievous", $f1
    db "plant elemantal.", $f0

String_0B_00_B5::
    db "An intelligent but", $f1
    db "odd ball of fluff.", $f0

String_0B_00_B6::
    db "Forces foes to", $f1
    db "dance with it.", $f0

String_0B_00_B7::
    db "A universal hero", $f1
    db "among its kind.", $f0

String_0B_00_B8::
    db "Attacks in a slow,", $f1
    db "deliberate manner.", $f0

String_0B_00_C1::
    db "Its stumpy feet", $f1
    db "limit its speed.", $f0

String_0B_00_C2::
    db "Drags prey under", $f1
    db "the ground.", $f0

String_0B_00_C3::
    db "Scatters dust to", $f1
    db "confuse foes.", $f0

String_0B_00_C4::
    db "A flower grew onto", $f1
    db "it while in soil.", $f0

String_0B_00_C5::
    db "Constricts foes", $f1
    db "with its body.", $f0

String_0B_00_C6::
    db "The lips conceal a", $f1
    db "long tongue.", $f0

String_0B_00_C7::
    db "Its hard shell", $f1
    db "make it tough.", $f0

String_0B_00_C8::
    db "Stabs and sucks", $f1
    db "with its mouth.", $f0

String_0B_00_C9::
    db "Small, but moves", $f1
    db "in large groups.", $f0

String_0B_00_CA::
    db "Always hops for", $f1
    db "unknown reasons.", $f0

String_0B_00_CB::
    db "Bites using mouths", $f1
    db "on both ends.", $f0

String_0B_00_CC::
    db "Swings side to", $f1
    db "side as it moves.", $f0

String_0B_00_CD::
    db "Climbs walls using", $f1
    db "its tentacles.", $f0

String_0B_00_CE::
    db "Stifles foes with", $f1
    db "its large wings.", $f0

String_0B_00_CF::
    db "Its eyes extend to", $f1
    db "spot far-off foes.", $f0

String_0B_00_D0::
    db "Its claws can't", $f1
    db "nick the shell.", $f0

String_0B_00_D1::
    db "The tail stinger", $f1
    db "is the finisher.", $f0

String_0B_00_D2::
    db "Its loud buzzing", $f1
    db "gives it away.", $f0

String_0B_00_D3::
    db "Stabs and hacks", $f1
    db "with its scythes.", $f0

String_0B_00_D4::
    db "The horn is used", $f1
    db "to hit and parry.", $f0

String_0B_00_D5::
    db "The sickles are as", $f1
    db "large as its body.", $f0

String_0B_00_D6::
    db "The stinger is a", $f1
    db "fierce weapon.", $f0

String_0B_00_D7::
    db "Dislikes water and", $f1
    db "lives in soil.", $f0

String_0B_00_D8::
    db "Capable of moving", $f1
    db "in any direction.", $f0

String_0B_00_D9::
    db "Its many eyes don't", $f1
    db "miss a thing.", $f0

String_0B_00_DA::
    db "Prefers mischief", $f1
    db "over eating.", $f0

String_0B_00_E4::
    db "The tentacles are", $f1
    db "actually snakes.", $f0

String_0B_00_E5::
    db "Hates getting its", $f1
    db "white fur dirty.", $f0

String_0B_00_E6::
    db "Intelligent, but", $f1
    db "far too frail.", $f0

String_0B_00_E7::
    db "The tentacles are", $f1
    db "tipped with eyes.", $f0

String_0B_00_E8::
    db "Its eye has a 360-", $f1
    db "degree coverage.", $f0

String_0B_00_E9::
    db "Never dismounts", $f1
    db "from the skull.", $f0

String_0B_00_EA::
    db "Intimidates with", $f1
    db "red, glaring eyes.", $f0

String_0B_00_EB::
    db "Its foam lets it", $f1
    db "dodge attacks.", $f0

String_0B_00_EC::
    db "Small, but deadly", $f1
    db "with spells.", $f0

String_0B_00_ED::
    db "Flies incredibly", $f1
    db "fast in mischief.", $f0

String_0B_00_EE::
    db "Stabs foes through", $f1
    db "with its trident.", $f0

String_0B_00_EF::
    db "Loves to fight,", $f1
    db "defeating all.", $f0

String_0B_00_F0::
    db "Stays red-faced", $f1
    db "from straining.", $f0

String_0B_00_F1::
    db "The spear is", $f1
    db "largely for show.", $f0

String_0B_00_F2::
    db "Swings spiked orbs", $f1
    db "to keep foes away.", $f0

String_0B_00_F3::
    db "Hides and strikes", $f1
    db "in darkness.", $f0

String_0B_00_F4::
    db "Uses its agility", $f1
    db "to confound foes.", $f0

String_0B_00_F5::
    db "Even its head is", $f1
    db "full of muscles.", $f0

String_0B_00_F6::
    db "The horn and fangs", $f1
    db "are its weapons.", $f0

String_0B_00_F7::
    db "Strong. Just", $f1
    db "incredibly so.", $f0

String_0B_00_F8::
    db "What the armor", $f1
    db "hides is unknown.", $f0

String_0B_00_F9::
    db "Waits in wells for", $f1
    db "prey to come.", $f0

String_0B_00_FA::
    db "Swings for the", $f1
    db "foe's weak spots.", $f0

String_0B_00_FB::
    db "Surprisingly agile", $f1
    db "for its heftiness.", $f0

String_0B_00_FC::
    db "The armor gives it", $f1
    db "great power.", $f0

String_0B_00_FD::
    db "Tracks foes", $f1
    db "with three eyes.", $f0

String_0B_00_FE::
    db "Seeks out battles", $f1
    db "for enjoyment.", $f0

String_0B_00_FF::
    db "When enraged, the", $f1
    db "horns straighten.", $f0

String_0B_01_00::
    db "A cruel demon that", $f1
    db "distorts wishes.", $f0

String_0B_01_01::
    db "Fades in and out", $f1
    db "to scare people.", $f0

String_0B_01_07::
    db "Created from the", $f1
    db "bones of dragons.", $f0

String_0B_01_08::
    db "It isn't bothered", $f1
    db "by new injuries.", $f0

String_0B_01_09::
    db "Drags stragglers", $f1
    db "off to death.", $f0

String_0B_01_0A::
    db "Bandages obscure", $f1
    db "its vision badly.", $f0

String_0B_01_0B::
    db "Its dark soul", $f1
    db "stained its body.", $f0

String_0B_01_0C::
    db "Unable to stop", $f1
    db "fighting in death.", $f0

String_0B_01_0D::
    db "It lost its body", $f1
    db "due to magic.", $f0

String_0B_01_0E::
    db "Rocks side to side", $f1
    db "as it approaches.", $f0

String_0B_01_0F::
    db "Dead, rotten, and", $f1
    db "not at peace.", $f0

String_0B_01_10::
    db "Shoots dirt from", $f1
    db "all over its body.", $f0

String_0B_01_11::
    db "Capable of going", $f1
    db "through walls.", $f0

String_0B_01_12::
    db "A shy soul, it", $f1
    db "swaddles its body.", $f0

String_0B_01_13::
    db "Sneaks up on foes", $f1
    db "from behind.", $f0

String_0B_01_14::
    db "The limbs were", $f1
    db "mixed up in death.", $f0

String_0B_01_15::
    db "The collar of fire", $f1
    db "is used to attack.", $f0

String_0B_01_16::
    db "Its arms were made", $f1
    db "into weapons.", $f0

String_0B_01_17::
    db "Retains its noble", $f1
    db "nature in death.", $f0

String_0B_01_18::
    db "Became a zombie", $f1
    db "while still alive.", $f0

String_0B_01_19::
    db "Will never be", $f1
    db "freed in death.", $f0

String_0B_01_1A::
    db "Slashes repeatedly", $f1
    db "with its six arms.", $f0

String_0B_01_1B::
    db "The four arms move", $f1
    db "independently.", $f0

String_0B_01_1C::
    db "Protects its head", $f1
    db "with both hands.", $f0

String_0B_01_1D::
    db "Shows dedication", $f1
    db "to its mimicry.", $f0

String_0B_01_1E::
    db "Wandering souls", $f1
    db "gathered as one.", $f0

String_0B_01_1F::
    db "Its thoughts are", $f1
    db "unfathomable.", $f0

String_0B_01_20::
    db "A proud and strong", $f1
    db "zombie swordsman.", $f0

String_0B_01_21::
    db "Dances if it spots", $f1
    db "anything shiny.", $f0

String_0B_01_2A::
    db "A wand that split", $f1
    db "from its mage.", $f0

String_0B_01_2B::
    db "Falls asleep if", $f1
    db "the flame dies.", $f0

String_0B_01_2C::
    db "A wind-up cuckoo", $f1
    db "that has a soul.", $f0

String_0B_01_2D::
    db "Made of wood that", $f1
    db "is 1000 years old.", $f0

String_0B_01_2E::
    db "One of its spikes", $f1
    db "sets off a bomb.", $f0

String_0B_01_2F::
    db "Traps foes within", $f1
    db "its reflection.", $f0

String_0B_01_30::
    db "Doomed to wander", $f1
    db "and roam forever.", $f0

String_0B_01_31::
    db "Controls itself", $f1
    db "with strings.", $f0

String_0B_01_32::
    db "Drags foes into", $f1
    db "mud with others.", $f0

String_0B_01_33::
    db "Emerged from 10000", $f1
    db "years of sleep.", $f0

String_0B_01_34::
    db "A fully mechanical", $f1
    db "dragon.", $f0

String_0B_01_35::
    db "Slow, so it relies", $f1
    db "on power smashes.", $f0

String_0B_01_36::
    db "Tears meat with", $f1
    db "its head and eats.", $f0

String_0B_01_37::
    db "Blows confusing", $f1
    db "smoke when buffed.", $f0

String_0B_01_38::
    db "Brushes foes until", $f1
    db "they turn all red.", $f0

String_0B_01_39::
    db "Battles until it", $f1
    db "is fully wrecked.", $f0

String_0B_01_3A::
    db "Battles savagely", $f1
    db "without mercy.", $f0

String_0B_01_3B::
    db "Bites whoever", $f1
    db "peers inside.", $f0

String_0B_01_3C::
    db "Descends from the", $f1
    db "sky to seek prey.", $f0

String_0B_01_3D::
    db "A giant that caked", $f1
    db "itself with magma.", $f0

String_0B_01_3E::
    db "A giant that caked", $f1
    db "itself with ice.", $f0

String_0B_01_3F::
    db "It bites unwary", $f1
    db "treasure hunters.", $f0

String_0B_01_40::
    db "Like-minded plates", $f1
    db "became a monster.", $f0

String_0B_01_41::
    db "Its body dries if", $f1
    db "it stops dancing.", $f0

String_0B_01_42::
    db "Its body cracks if", $f1
    db "it tries to talk.", $f0

String_0B_01_43::
    db "Its body breaks if", $f1
    db "it stops moving.", $f0

String_0B_01_44::
    db "Explodes without", $f1
    db "warning on waking.", $f0

String_0B_01_45::
    db "Proud of its big,", $f1
    db "golden body.", $f0

String_0B_01_46::
    db "Makes foes dizzy", $f1
    db "by rotating.", $f0

String_0B_01_47::
    db "Roboster's proto-", $f1
    db "type, but tough.", $f0

String_0B_01_48::
    db "A judge among", $f1
    db "monsters.", $f0

String_0B_01_49::
    db "Small, slippery", $f1
    db "and hard to hit.", $f0

String_0B_01_4D::
    db "Immobilizes foes", $f1
    db "then bites them.", $f0

String_0B_01_4E::
    db "Sits on foes and", $f1
    db "pummels them.", $f0

String_0B_01_4F::
    db "Suffocates foes", $f1
    db "with its body.", $f0

String_0B_01_50::
    db "Snares foes with", $f1
    db "its tentacles.", $f0

String_0B_01_51::
    db "Expands its body", $f1
    db "to startle foes.", $f0

String_0B_01_52::
    db "A fish that is as", $f1
    db "smart as people.", $f0

String_0B_01_53::
    db "A monster that got", $f1
    db "stuck in a trap.", $f0

String_0B_01_54::
    db "Swarms and eats", $f1
    db "foes instantly.", $f0

String_0B_01_55::
    db "The short legs", $f1
    db "make it sluggish.", $f0

String_0B_01_56::
    db "Attracts prey with", $f1
    db "a lighted antenna.", $f0

String_0B_01_57::
    db "A demon that rides", $f1
    db "a fish in battle.", $f0

String_0B_01_58::
    db "Swims straight to", $f1
    db "ram at high speed.", $f0

String_0B_01_59::
    db "Skips through", $f1
    db "water like a frog.", $f0

String_0B_01_5A::
    db "The pincers can", $f1
    db "cut its own shell.", $f0

String_0B_01_5B::
    db "The pincers are", $f1
    db "sharp, but heavy.", $f0

String_0B_01_5C::
    db "Drowns foes inside", $f1
    db "its turbid body.", $f0

String_0B_01_5D::
    db "Its shell is", $f1
    db "tough to open.", $f0

String_0B_01_5E::
    db "Remains upright", $f1
    db "even when asleep.", $f0

String_0B_01_5F::
    db "Hides its ugly", $f1
    db "body in a hood.", $f0

String_0B_01_60::
    db "Rampages in the", $f1
    db "sea with swords.", $f0

String_0B_01_61::
    db "Cleaves foes in", $f1
    db "two with its ax.", $f0

String_0B_01_62::
    db "Rarely seen as it", $f1
    db "hides in depths.", $f0

String_0B_01_63::
    db "Spits a huge cloud", $f1
    db "of obscuring ink.", $f0

String_0B_01_64::
    db "Drifts along with", $f1
    db "deep-sea currents.", $f0

String_0B_01_65::
    db "Its wand indicates", $f1
    db "magical power.", $f0

String_0B_01_66::
    db "Rare. It lurks", $f1
    db "only in deep seas.", $f0

String_0B_01_67::
    db "Uses tentacles to", $f1
    db "immobilize foes.", $f0

String_0B_01_68::
    db "The fin on its", $f1
    db "back is a weapon.", $f0

String_0B_01_69::
    db "Its thrashing can", $f1
    db "cause earthquakes.", $f0

String_0B_01_6A::
    db "Floats vacantly in", $f1
    db "the sea at peace.", $f0

String_0B_01_6B::
    db "Small, but capable", $f1
    db "of stretching.", $f0

String_0B_01_6C::
    db "DracoLord's first,", $f1
    db "unassuming form.", $f0

String_0B_01_70::
    db "DracoLord's true,", $f1
    db "powerful identity.", $f0

String_0B_01_71::
    db "DracoLord's form", $f1
    db "when enraged.", $f0

String_0B_01_72::
    db "An evil cleric who", $f1
    db "can use any spell.", $f0

String_0B_01_73::
    db "A being dedicated", $f1
    db "to world chaos.", $f0

String_0B_01_74::
    db "Sidoh reborn for ", $f1
    db "total destruction.", $f0

String_0B_01_75::
    db "Lords over all", $f1
    db "demons with power.", $f0

String_0B_01_76::
    db "A Demon Lord that", $f1
    db "uses dark powers.", $f0

String_0B_01_77::
    db "The true, final", $f1
    db "form of Zoma.", $f0

String_0B_01_78::
    db "A being that seeks", $f1
    db "ultimate power.", $f0

String_0B_01_79::
    db "Pizzaro's pure and", $f1
    db "real guise.", $f0

String_0B_01_7A::
    db "Dedicated to chaos", $f1
    db "and domination.", $f0

String_0B_01_7B::
    db "Purely evil and", $f1
    db "divinely powerful.", $f0

String_0B_01_7C::
    db "The true, vile", $f1
    db "form of Mirudraas.", $f0

String_0B_01_7D::
    db "A Demon Lord that", $f1
    db "uses illusions.", $f0

String_0B_01_7E::
    db "The Demon Lord of", $f1
    db "all worlds.", $f0

String_0B_01_7F::
    db "The true, enraged", $f1
    db "form of DeathMore.", $f0

String_0B_01_80::
    db "DeathMore's final", $f1
    db "evolution.", $f0

String_0B_01_81::
    db "A being that", $f1
    db "dreams of death.", $f0

String_0B_01_82::
    db "Its elegance", $f1
    db "belies its greed.", $f0

String_0B_01_83::
    db "Its form strikes", $f1
    db "terror in all.", $f0

String_0B_01_84::
    db "The collector king", $f1
    db "of Limbo.", $f0

String_0B_02_00::
    db "Slime", $f0

String_0B_02_01::
    db "Dragon", $f0

String_0B_02_02::
    db "Beast", $f0

String_0B_02_03::
    db "Bird", $f0

String_0B_02_04::
    db "Plant", $f0

String_0B_02_05::
    db "Bug", $f0

String_0B_02_06::
    db "Demon", $f0

String_0B_02_07::
    db "Zombie", $f0

String_0B_02_08::
    db "Material", $f0

String_0B_02_09::
    db "Water", $f0

String_0B_02_0A::
    db "????", $f0
    ds $12cc, $00
