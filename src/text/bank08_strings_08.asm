; ROM bank $08: string tables: system text, monster, skill and item names
; The annotated listing of this bank is build/listing/bank08.asm.

SECTION "Bank 08", ROMX
    db $08

; Starts showing string wStringIndex of category wStringCategory: categories below 9 call
; BeginStringDisplay with DE = StringDatabase (this bank); 9 and above far-call
; BeginStringDisplay_Bank08_Overflow, which uses category - 9 of the bank $95 table. The text
; printer then draws the string over the next frames while wTextFlags is non-zero. (C1, E-0375)
; if wStringCategory < 9, BeginStringDisplay with DE = StringDatabase; otherwise far-calls
; BeginStringDisplay_Bank08_Overflow
BeginStringDisplay_Bank08::
    ld a, [wStringCategory]
    cp $09
    jr c, .call_begin_string_display
    farcall BeginStringDisplay_Bank08_Overflow
    ret

.call_begin_string_display:
    ld de, StringDatabase
    call BeginStringDisplay
    ret

SECTION "Bank 08 CopyStringToBuffer_Bank08", ROMX

; Copies string wStringIndex of category wStringCategory, with its $F0 end, to the address in
; wStringDestLo/wStringDestHi (CopyStringToBuffer, which also sets wStringBank): categories below 9
; from StringDatabase in this bank, 9 and above from bank $95 through
; CopyStringToBuffer_Bank08_Overflow, which leaves wStringCategory reduced by 9. (C2, E-0375)
; if wStringCategory < 9, CopyStringToBuffer with DE = StringDatabase; otherwise far-calls
; CopyStringToBuffer_Bank08_Overflow
CopyStringToBuffer_Bank08::
    ld a, [wStringCategory]
    cp $09
    jr c, .call_copy_string_to_buffer
    farcall CopyStringToBuffer_Bank08_Overflow
    ret

.call_copy_string_to_buffer:
    ld de, StringDatabase
    call CopyStringToBuffer
    ret

SECTION "Bank 08 ShowString_Bank08", ROMX

; BeginStringDisplay_Bank08, then RunStringDisplayToEnd: draws a whole string of the bank $08 table
; (bank $95 for categories 9 and above) at once. Used by the debug menu, the pause menu, the library
; and the arena among others. (C1, E-0375)
; BeginStringDisplay_Bank08 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank08::
    call BeginStringDisplay_Bank08
    call RunStringDisplayToEnd
    ret

SECTION "Bank 08 StringDatabase", ROMX

; Nine words, each the pointer to the string list of one category 0-8: StringTable_System,
; StringTable_MonsterFamilies, StringTable_MonsterNames, StringTable_MonsterNames2,
; StringTable_SkillNames, StringTable_ItemNames, StringTable_ItemDescriptions,
; StringTable_PersonalityNames and StringTable_ItemMenuMessages. LookupString indexes it by
; wStringCategory, then the chosen list by wStringIndex, through BeginStringDisplay_Bank08 and
; CopyStringToBuffer_Bank08 (category 9 and above go to the bank $95 table); other banks read single
; words of it (for example the word at StringDatabase + 4). (C1, E-0381)
; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringDatabase::
    dw StringTable_System ; id 0
    dw StringTable_MonsterFamilies ; id 1
    dw StringTable_MonsterNames ; id 2
StringDatabase_MonsterNames2::
    dw StringTable_MonsterNames2 ; id 3
    dw StringTable_SkillNames ; id 4
StringDatabase_ItemNames::
    dw StringTable_ItemNames ; id 5
    dw StringTable_ItemDescriptions ; id 6
    dw StringTable_PersonalityNames ; id 7
    dw StringTable_ItemMenuMessages ; id 8

; 255 strings: debug-menu and system text, for example 'DEBUG MODE' and '? EDIT ?' (named from its
; contents; E-0026)
; category list of StringDatabase; one pointer per wStringIndex (E-0217)
; record: string
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

; 11 strings: Slime, Dragon, Beast, Bird, Plant, ... (named from its contents; E-0026)
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

; 256 strings indexed by the number the monster-name routines take in HL (entry 0 is empty):
; 'DrakSlime', 'SpotSlime', ... (named from its contents; E-0026)
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

; 128 more monster names: 'Mudron', 'NiteWhip', ... (named from its contents; E-0026)
; category list of StringDatabase; one pointer per wStringIndex (E-0217)
; record: string
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

; 223 strings: 'Blaze', 'Blazemore', 'Blazemost', 'Firebal', ... (named from its contents; E-0026)
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

; 112 strings: 'Herb', 'LoveWater', 'WorldDew', 'Potion', ... (named from its contents; E-0026)
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

; 112 strings: 'Restores HP of one monster', ... (named from its contents; E-0026)
; category list of StringDatabase; one pointer per wStringIndex (E-0217)
; record: string
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

; 27 strings: 'Hotblood', 'Eager', 'Smug', 'Earnest', 'Pushy', ... (named from its contents; E-0026)
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

; 15 strings: 'No items', 'Toss this away?', ... (named from its contents; E-0026)
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
    db "0123456789ABCDEF@"

String_08_00_01::
    db "  DEBUG MODE        SELECT       1:GOTO PROGRAM  2:EDIT     "
    db "     3:AUTOMAP CHECK 4:GRAFHICS      5:SOUNDS        6:BATTL"
    db "E        7:HAIGOU        8:STAFF ROLL    9:TOKUGI CHECK  A:E"
    db "NEMY TBL CHK B:MESSAGE CHK  ?  RETURN  ?  @"

String_08_00_02::
    db "  ? EDIT ?                      WORLD:          MAP X:      "
    db "        Y:          POS X:              Y:          NOT DATA"
    db $9f, "@"

String_08_00_03::
    db "MONSTER BGSD CHARA     @"

String_08_00_04::
    db "  ? AUTOMAP ?                   KEY  :          KEYID:      "
    db "    LEVEL:          POS X:          POS Y:          NOT DATA"
    db $9f, "@"

String_08_00_05::
    db "  ? SOUND ?<LINE>"
    db "<LINE>"
    db "  BGM<LINE>"
    db "   SE@"

String_08_00_07::
    db "? GOTOPRG ?<LINE>"
    db "<LINE>"
    db "<LINE>"
    db " PRGNO1<LINE>"
    db " PRGNO2<LINE>"
    db " PRGNO3@"

String_08_00_08::
    db "No more…@"

String_08_00_09::
    db "? BATTLE ?<LINE>"
    db "No. foes<LINE>"
    db "Monster 1<LINE>"
    db "Monster 2<LINE>"
    db "Monster 3<LINE>"
    db "Debug<LINE>"
    db "Skill ID<LINE>"
    db "Species<LINE>"
    db "Level@"

String_08_00_0A::
    db "MonsterFarm@"

String_08_00_0B::
    db "GreatLog@"

String_08_00_0C::
    db "Main Street@"

String_08_00_0D::
    db "Magic Door@"

String_08_00_0E::
    db "Reception@"

String_08_00_0F::
    db "Log's Navel@"

String_08_00_10::
    db "Home@"

String_08_00_11::
    db "Stable@"

String_08_00_12::
    db "Vault@"

String_08_00_13::
    db "Key Shop@"

String_08_00_14::
    db "Evaluator@"

String_08_00_15::
    db "Residences@"

String_08_00_17::
    db "Starry ", $59, "@"

String_08_00_18::
    db "Family Rm.@"

String_08_00_19::
    db "Guy's Rm.@"

String_08_00_1A::
    db "Lady's Rm.@"

String_08_00_1B::
    db "Library@"

String_08_00_1C::
    db "Girl's Rm.@"

String_08_00_1D::
    db "Christener@"

String_08_00_1E::
    db "Background@"

String_08_00_1F::
    db "Old man's@"

String_08_00_20::
    db "Medal man@"

String_08_00_21::
    db "Tavern@"

String_08_00_22::
    db "Arena@"

String_08_00_23::
    db "GreatLog ", $58, "@"

String_08_00_24::
    db "Treetop@"

String_08_00_25::
    db "Log's nut@"

String_08_00_26::
    db "Log's view@"

String_08_00_27::
    db "Deck@"

String_08_00_28::
    db $17, $18, $f0

String_08_00_2A::
    db "Desert ", $5c, "@"

String_08_00_2B::
    db "Kalka ", $57, "@"

String_08_00_2C::
    db "Kalka inn@"

String_08_00_2D::
    db "Asiya inn@"

String_08_00_2E::
    db "Asiya ", $57, "@"

String_08_00_2F::
    db "Asiya ", $58, "@"

String_08_00_30::
    db "Desert King@"

String_08_00_31::
    db $17, $18, $f0

String_08_00_32::
    db "Hideout@"

String_08_00_33::
    db "Magic Door ", $59, "@"

String_08_00_34::
    db "CanalGate@"

String_08_00_35::
    db "Canal@"

String_08_00_36::
    db "Not yet!@"

String_08_00_37::
    db "Dungeon<LINE>"

String_08_00_38::
    db "Treasury<LINE>"

String_08_00_39::
    db "Mirage Lake<LINE>"

String_08_00_3A::
    db "Water ", $5c, "@"

String_08_00_3B::
    db "Yold ", $57, "@"

String_08_00_3C::
    db "Pt.Ritz ", $57, "@"

String_08_00_3D::
    db "Pt.Ritz pub@"

String_08_00_3E::
    db "Pt.Ritz inn@"

String_08_00_3F::
    db "Cape ", $5a, "@"

String_08_00_40::
    db "Ship ramp@"

String_08_00_41::
    db "Ship 1F@"

String_08_00_42::
    db "Volcano", $5a, "1F@"

String_08_00_43::
    db "Volcano", $5a, "B1F@"

String_08_00_44::
    db "Volcano", $5a, "B2F@"

String_08_00_45::
    db "Loot vault@"

String_08_00_46::
    db "Polona ", $57, "@"

String_08_00_47::
    db "Polona inn@"

String_08_00_48::
    db "Lighthouse@"

String_08_00_49::
    db "Lighthouse@"

String_08_00_4A::
    db "Pinnacle@"

String_08_00_4B::
    db "Mermaid ", $5c, "@"

String_08_00_4C::
    db "Ship 2F@"

String_08_00_4D::
    db "Ship deck@"

String_08_00_4E::
    db "Capt's qtr.@"

String_08_00_4F::
    db "Magic Door ", $59, "@"

String_08_00_50::
    db $17, $18, $f0

String_08_00_52::
    db "Ice ", $5c, "@"

String_08_00_53::
    db "Spring@"

String_08_00_54::
    db "Norden ", $57, "@"

String_08_00_55::
    db "Norden inn@"

String_08_00_56::
    db "Norden ", $58, "@"

String_08_00_57::
    db "Norden jail@"

String_08_00_58::
    db "N tunnel@"

String_08_00_59::
    db "Nofor ", $57, "@"

String_08_00_5A::
    db "Nofor pub@"

String_08_00_5B::
    db "Nofor inn@"

String_08_00_5C::
    db "Border mine@"

String_08_00_5D::
    db "Mine@"

String_08_00_5E::
    db "Mine rm.@"

String_08_00_5F::
    db "Mine rm.@"

String_08_00_60::
    db "Mine rm.@"

String_08_00_61::
    db "Gold mine@"

String_08_00_62::
    db "Weston ", $57, "@"

String_08_00_63::
    db "Weston inn@"

String_08_00_64::
    db "Westania ", $58, "@"

String_08_00_65::
    db "Westania ", $58, "@"

String_08_00_66::
    db "Yuna's rm.@"

String_08_00_67::
    db "S forest@"

String_08_00_68::
    db "Estria  ", $58, "@"

String_08_00_69::
    db "Estria inn@"

String_08_00_6A::
    db "Estria ", $58, "@"

String_08_00_6B::
    db "Queen's rm.@"

String_08_00_6C::
    db "N mountain@"

String_08_00_6D::
    db "Lake ", $5d, " 1F@"

String_08_00_6E::
    db "Lake ", $5d, " 2F@"

String_08_00_6F::
    db "Lake ", $5d, " 3F@"

String_08_00_70::
    db "Lake ", $5d, " 4F@"

String_08_00_71::
    db "Lake ", $5d, " 5F@"

String_08_00_72::
    db "Magic Door ", $59, "@"

String_08_00_73::
    db $17, $18, $f0

String_08_00_7A::
    db "Float ", $5c, "@"

String_08_00_7B::
    db "Fhunt ", $57, "@"

String_08_00_7C::
    db "Fhunt inn@"

String_08_00_7D::
    db "Sage ", $5d, " 1F@"

String_08_00_7E::
    db "Sage ", $5d, " 2F@"

String_08_00_7F::
    db "Sage ", $5d, " 3F@"

String_08_00_80::
    db "Sage ", $5d, " 4F@"

String_08_00_81::
    db "Rope bridge@"

String_08_00_82::
    db "Pei ", $57, "@"

String_08_00_83::
    db "Pei inn@"

String_08_00_84::
    db "W mountain@"

String_08_00_85::
    db "W tunnel@"

String_08_00_86::
    db "Hitano ", $57, "@"

String_08_00_87::
    db "Hitano inn@"

String_08_00_88::
    db "Hitano pub@"

String_08_00_89::
    db "Hitano ", $58, "@"

String_08_00_8A::
    db "Rope bridge@"

String_08_00_8B::
    db "Small ", $5a, "@"

String_08_00_8C::
    db "Small ", $5a, " B1F@"

String_08_00_8D::
    db "Small ", $5a, " B2F@"

String_08_00_8E::
    db "Boss Rm.@"

String_08_00_8F::
    db "Wind ", $5d, " 1F@"

String_08_00_90::
    db "Wind ", $5d, " 2F@"

String_08_00_91::
    db "Wind ", $5d, " 3F@"

String_08_00_92::
    db "Wind ", $5d, " 4F@"

String_08_00_93::
    db "Sage ", $5d, "@"

String_08_00_94::
    db "Dead ", $58, "@"

String_08_00_95::
    db "Cathedral@"

String_08_00_96::
    db "Corridor@"

String_08_00_97::
    db "Morgue@"

String_08_00_98::
    db "Cemetery@"

String_08_00_99::
    db "Music rm.@"

String_08_00_9A::
    db "Corridor@"

String_08_00_9B::
    db "Dead rm.@"

String_08_00_9C::
    db "North ", $59, "@"

String_08_00_9D::
    db "Demon ", $58, "@"

String_08_00_9E::
    db "Demon ", $58, " 1F@"

String_08_00_9F::
    db "Demon ", $58, " B1F@"

String_08_00_A0::
    db "Demon ", $58, " B2F@"

String_08_00_A1::
    db "Demon ", $58, " B3F@"

String_08_00_A2::
    db "Demon ", $58, " B4F@"

String_08_00_A3::
    db "Demon ", $58, " B5F@"

String_08_00_A4::
    db "Demon ", $58, " B6F@"

String_08_00_A5::
    db "Demon hall@"

String_08_00_A6::
    db $17, $18, $f0

String_08_00_A7::
    db "Magic Door ", $59, "@"

String_08_00_A8::
    db $17, $18, $f0

String_08_00_AA::
    db "Limbo ", $5c, "@"

String_08_00_AB::
    db "Stairway@"

String_08_00_AC::
    db "Darck Manor@"

String_08_00_AD::
    db "Gallery@"

String_08_00_AE::
    db "Magic Door ", $59, "@"

String_08_00_AF::
    db $17, $18, $f0

String_08_00_B2::
    db "Elven ", $5c, "@"

String_08_00_B3::
    db "Elven ", $57, "@"

String_08_00_B4::
    db "W forest@"

String_08_00_B5::
    db "Lookout@"

String_08_00_B6::
    db "Summit@"

String_08_00_B7::
    db "Mt. base@"

String_08_00_B8::
    db "PlatinumMt.@"

String_08_00_B9::
    db "Magic Door ", $59, "@"

String_08_00_BA::
    db "Lonely ", $5c, "@"

String_08_00_BB::
    db "Kiral Lab@"

String_08_00_BC::
    db "Magic Door ", $59, "@"

String_08_00_BD::
    db "Lab B1F@"

String_08_00_BE::
    db "Lab B2F@"

String_08_00_BF::
    db "Lab B3F@"

String_08_00_C0::
    db "Barrel rm.@"

String_08_00_C1::
    db $17, $18, $f0

String_08_00_C2::
    db "Traveler ", $5c, "@"

String_08_00_C3::
    db "Miagen ", $57, "@"

String_08_00_C4::
    db "Travel hut@"

String_08_00_C5::
    db "N forest@"

String_08_00_C6::
    db "Inn@"

String_08_00_C7::
    db $5d, " summit@"

String_08_00_C8::
    db "Old ", $5d, " 1F@"

String_08_00_C9::
    db "Old ", $5d, " 2F@"

String_08_00_CA::
    db "Old ", $5d, " 3F@"

String_08_00_CB::
    db "Old ", $5d, " 4F@"

String_08_00_CC::
    db "Old ", $5d, " 5F@"

String_08_00_CD::
    db "Old ", $5d, " 6F@"

String_08_00_CE::
    db "Old ", $5d, " 7F@"

String_08_00_CF::
    db "Magic Door ", $59, "@"

String_08_00_D0::
    db $17, $18, $f0

String_08_00_D2::
    db "Power ", $5c, "@"

String_08_00_D3::
    db "Power ", $5d, " 1F@"

String_08_00_D4::
    db "Power ", $5d, " 2F@"

String_08_00_D5::
    db "Power ", $5d, " 3F@"

String_08_00_D6::
    db "Power ", $5d, " 4F@"

String_08_00_D7::
    db "Power ", $5d, " 5F@"

String_08_00_D8::
    db "Power ", $5d, " 6F@"

String_08_00_D9::
    db "Power ", $5d, " 7F@"

String_08_00_DA::
    db "Magic Door ", $59, "@"

String_08_00_DB::
    db "Baffle ", $5c, "@"

String_08_00_DC::
    db "Baffle ", $5d, " 1F@"

String_08_00_DD::
    db "Baffle ", $5d, " 2F@"

String_08_00_DE::
    db "Baffle ", $5d, " 3F@"

String_08_00_DF::
    db "Baffle ", $5d, " 4F@"

String_08_00_E0::
    db "Baffle ", $5d, " 5F@"

String_08_00_E1::
    db "Baffle ", $5d, " 6F@"

String_08_00_E2::
    db "Baffle ", $5d, " 7F@"

String_08_00_E3::
    db "Magic Door ", $59, "@"

String_08_00_E4::
    db "Soul ", $5c, "@"

String_08_00_E5::
    db "Soul ", $5d, " 1F@"

String_08_00_E6::
    db "Soul ", $5d, " 2F@"

String_08_00_E7::
    db "Soul ", $5d, " 3F@"

String_08_00_E8::
    db "Soul ", $5d, " 4F@"

String_08_00_E9::
    db "Soul ", $5d, " 5F@"

String_08_00_EA::
    db "Soul ", $5d, " 6F@"

String_08_00_EB::
    db "Soul ", $5d, " 7F@"

String_08_00_EC::
    db "Magic Door ", $59, "@"

String_08_00_ED::
    db $17, $18, $f0

String_08_01_00::
    db "Slime@"

String_08_01_01::
    db "Dragon@"

String_08_01_02::
    db "Beast@"

String_08_01_03::
    db "Bird@"

String_08_01_04::
    db "Plant@"

String_08_01_05::
    db "Bug@"

String_08_01_06::
    db "Demon@"

String_08_01_07::
    db "Zombie@"

String_08_01_08::
    db "Material@"

String_08_01_09::
    db "Water@"

String_08_01_0A::
    db "????@"

String_08_02_00::
    db $f0

String_08_02_01::
    db "DrakSlime@"

String_08_02_02::
    db "SpotSlime@"

String_08_02_03::
    db "WingSlime@"

String_08_02_04::
    db "TreeSlime@"

String_08_02_05::
    db "Snaily@"

String_08_02_06::
    db "SlimeNite@"

String_08_02_07::
    db "Babble@"

String_08_02_08::
    db "BoxSlime@"

String_08_02_09::
    db "PearlGel@"

String_08_02_0A::
    db "Slime@"

String_08_02_0B::
    db "Healer@"

String_08_02_0C::
    db "FangSlime@"

String_08_02_0D::
    db "RockSlime@"

String_08_02_0E::
    db "SlimeBorg@"

String_08_02_0F::
    db "Slabbit@"

String_08_02_10::
    db "KingSlime@"

String_08_02_11::
    db "Metaly@"

String_08_02_12::
    db "Metabble@"

String_08_02_13::
    db "SpotKing@"

String_08_02_14::
    db "TropicGel@"

String_08_02_15::
    db "MimeSlime@"

String_08_02_16::
    db "HaloSlime@"

String_08_02_17::
    db "MetalKing@"

String_08_02_18::
    db "GoldSlime@"

String_08_02_19::
    db "GranSlime@"

String_08_02_1A::
    db "WonderEgg@"

String_08_02_1B::
    db "Butch@"

String_08_02_1C::
    db $98, $f0

String_08_02_24::
    db "DragonKid@"

String_08_02_25::
    db "Tortragon@"

String_08_02_26::
    db "Pteranod@"

String_08_02_27::
    db "Gasgon@"

String_08_02_28::
    db "FairyDrak@"

String_08_02_29::
    db "LizardMan@"

String_08_02_2A::
    db "Poisongon@"

String_08_02_2B::
    db "Swordgon@"

String_08_02_2C::
    db "Drygon@"

String_08_02_2D::
    db "Dragon@"

String_08_02_2E::
    db "MiniDrak@"

String_08_02_2F::
    db "MadDragon@"

String_08_02_30::
    db "Rayburn@"

String_08_02_31::
    db "Chamelgon@"

String_08_02_32::
    db "LizardFly@"

String_08_02_33::
    db "Andreal@"

String_08_02_34::
    db "KingCobra@"

String_08_02_35::
    db "Vampirus@"

String_08_02_36::
    db "SnakeBat@"

String_08_02_37::
    db "Spikerous@"

String_08_02_38::
    db "GreatDrak@"

String_08_02_39::
    db "Crestpent@"

String_08_02_3A::
    db "WingSnake@"

String_08_02_3B::
    db "Coatol@"

String_08_02_3C::
    db "Orochi@"

String_08_02_3D::
    db "BattleRex@"

String_08_02_3E::
    db "SkyDragon@"

String_08_02_3F::
    db "Serpentia@"

String_08_02_40::
    db "Divinegon@"

String_08_02_41::
    db "Orligon@"

String_08_02_42::
    db "GigaDraco@"

String_08_02_43::
    db $98, $f0

String_08_02_47::
    db "Tonguella@"

String_08_02_48::
    db "Almiraj@"

String_08_02_49::
    db "CatFly@"

String_08_02_4A::
    db "PillowRat@"

String_08_02_4B::
    db "Saccer@"

String_08_02_4C::
    db "GulpBeast@"

String_08_02_4D::
    db "Skullroo@"

String_08_02_4E::
    db "WindBeast@"

String_08_02_4F::
    db "Beavern@"

String_08_02_50::
    db "Antbear@"

String_08_02_51::
    db "SuperTen@"

String_08_02_52::
    db "IronTurt@"

String_08_02_53::
    db "Mommonja@"

String_08_02_54::
    db "HammerMan@"

String_08_02_55::
    db "Grizzly@"

String_08_02_56::
    db "Yeti@"

String_08_02_57::
    db "ArrowDog@"

String_08_02_58::
    db "NoctoKing@"

String_08_02_59::
    db "BeastNite@"

String_08_02_5A::
    db "MadGopher@"

String_08_02_5B::
    db "FairyRat@"

String_08_02_5C::
    db "Unicorn@"

String_08_02_5D::
    db "Goategon@"

String_08_02_5E::
    db "WildApe@"

String_08_02_5F::
    db "Trumpeter@"

String_08_02_60::
    db "KingLeo@"

String_08_02_61::
    db "DarkHorn@"

String_08_02_62::
    db "MadCat@"

String_08_02_63::
    db "BigEye@"

String_08_02_64::
    db "Gorago@"

String_08_02_65::
    db "CatMage@"

String_08_02_66::
    db "Dumbira@"

String_08_02_67::
    db $98, $f0

String_08_02_6A::
    db "Picky@"

String_08_02_6B::
    db "Wyvern@"

String_08_02_6C::
    db "BullBird@"

String_08_02_6D::
    db "Florajay@"

String_08_02_6E::
    db "DuckKite@"

String_08_02_6F::
    db "MadPecker@"

String_08_02_70::
    db "MadRaven@"

String_08_02_71::
    db "MistyWing@"

String_08_02_72::
    db "AquaHawk@"

String_08_02_73::
    db "Dracky@"

String_08_02_74::
    db "KiteHawk@"

String_08_02_75::
    db "BigRoost@"

String_08_02_76::
    db "StubBird@"

String_08_02_77::
    db "LandOwl@"

String_08_02_78::
    db "MadGoose@"

String_08_02_79::
    db "MadCondor@"

String_08_02_7A::
    db "Emyu@"

String_08_02_7B::
    db "Blizzardy@"

String_08_02_7C::
    db "Phoenix@"

String_08_02_7D::
    db "ZapBird@"

String_08_02_7E::
    db "Garudian@"

String_08_02_7F::
    db "WhipBird@"

String_08_02_80::
    db "FunkyBird@"

String_08_02_81::
    db "RainHawk@"

String_08_02_82::
    db "Azurile@"

String_08_02_83::
    db "Shantak@"

String_08_02_84::
    db "CragDevil@"

String_08_02_85::
    db $98, $f0

String_08_02_8D::
    db "MadPlant@"

String_08_02_8E::
    db "FireWeed@"

String_08_02_8F::
    db "FloraMan@"

String_08_02_90::
    db "WingTree@"

String_08_02_91::
    db "CactiBall@"

String_08_02_92::
    db "Gulpple@"

String_08_02_93::
    db "Toadstool@"

String_08_02_94::
    db "AmberWeed@"

String_08_02_95::
    db "Slurperon@"

String_08_02_96::
    db "Stubsuck@"

String_08_02_97::
    db "Oniono@"

String_08_02_98::
    db "DanceVegi@"

String_08_02_99::
    db "TreeBoy@"

String_08_02_9A::
    db "Devipine@"

String_08_02_9B::
    db "FaceTree@"

String_08_02_9C::
    db "HerbMan@"

String_08_02_9D::
    db "BeanMan@"

String_08_02_9E::
    db "EvilSeed@"

String_08_02_9F::
    db "ManEater@"

String_08_02_A0::
    db "Snapper@"

String_08_02_A1::
    db "GhosTree@"

String_08_02_A2::
    db "Rosevine@"

String_08_02_A3::
    db "Egdracil@"

String_08_02_A4::
    db "Warubou@"

String_08_02_A5::
    db "Watabou@"

String_08_02_A6::
    db "Eggplaton@"

String_08_02_A7::
    db "FooHero@"

String_08_02_A8::
    db $98, $f0

String_08_02_B0::
    db "GiantSlug@"

String_08_02_B1::
    db "Catapila@"

String_08_02_B2::
    db "Gophecada@"

String_08_02_B3::
    db "Butterfly@"

String_08_02_B4::
    db "WeedBug@"

String_08_02_B5::
    db "GiantWorm@"

String_08_02_B6::
    db "Lipsy@"

String_08_02_B7::
    db "StagBug@"

String_08_02_B8::
    db "Pyuro@"

String_08_02_B9::
    db "ArmyAnt@"

String_08_02_BA::
    db "GoHopper@"

String_08_02_BB::
    db "TailEater@"

String_08_02_BC::
    db "ArmorPede@"

String_08_02_BD::
    db "Eyeder@"

String_08_02_BE::
    db "GiantMoth@"

String_08_02_BF::
    db "Droll@"

String_08_02_C0::
    db "ArmyCrab@"

String_08_02_C1::
    db "MadHornet@"

String_08_02_C2::
    db "Belzebub@"

String_08_02_C3::
    db "WarMantis@"

String_08_02_C4::
    db "HornBeet@"

String_08_02_C5::
    db "Sickler@"

String_08_02_C6::
    db "Armorpion@"

String_08_02_C7::
    db "Digster@"

String_08_02_C8::
    db "Skularach@"

String_08_02_C9::
    db "MultiEyes@"

String_08_02_CA::
    db $98, $f0

String_08_02_D3::
    db "Pixy@"

String_08_02_D4::
    db "MedusaEye@"

String_08_02_D5::
    db "AgDevil@"

String_08_02_D6::
    db "Demonite@"

String_08_02_D7::
    db "DarkEye@"

String_08_02_D8::
    db "EyeBall@"

String_08_02_D9::
    db "SkulRider@"

String_08_02_DA::
    db "EvilBeast@"

String_08_02_DB::
    db "Bubblemon@"

String_08_02_DC::
    db "1EyeClown@"

String_08_02_DD::
    db "Gremlin@"

String_08_02_DE::
    db "ArcDemon@"

String_08_02_DF::
    db "Lionex@"

String_08_02_E0::
    db "GoatHorn@"

String_08_02_E1::
    db "Orc@"

String_08_02_E2::
    db "Ogre@"

String_08_02_E3::
    db "GateGuard@"

String_08_02_E4::
    db "ChopClown@"

String_08_02_E5::
    db "BossTroll@"

String_08_02_E6::
    db "Grendal@"

String_08_02_E7::
    db "Akubar@"

String_08_02_E8::
    db "MadKnight@"

String_08_02_E9::
    db "EvilWell@"

String_08_02_EA::
    db "Gigantes@"

String_08_02_EB::
    db "Centasaur@"

String_08_02_EC::
    db "EvilArmor@"

String_08_02_ED::
    db "Jamirus@"

String_08_02_EE::
    db "Durran@"

String_08_02_EF::
    db "Titanis@"

String_08_02_F0::
    db "LampGenie@"

String_08_02_F1::
    db $98, $f0

String_08_02_F6::
    db "Spooky@"

String_08_02_F7::
    db "Skullgon@"

String_08_02_F8::
    db "PutrePup@"

String_08_02_F9::
    db "RotRaven@"

String_08_02_FA::
    db "Mummy@"

String_08_02_FB::
    db "DarkCrab@"

String_08_02_FC::
    db "DeadNite@"

String_08_02_FD::
    db "Shadow@"

String_08_02_FE::
    db "Skulpent@"

String_08_02_FF::
    db "Hork@"

String_08_03_00::
    db "Mudron@"

String_08_03_01::
    db "NiteWhip@"

String_08_03_02::
    db "WindMerge@"

String_08_03_03::
    db "Reaper@"

String_08_03_04::
    db "Inverzon@"

String_08_03_05::
    db "FoxFire@"

String_08_03_06::
    db "CaptDead@"

String_08_03_07::
    db "DeadNoble@"

String_08_03_08::
    db "WhiteKing@"

String_08_03_09::
    db "BoneSlave@"

String_08_03_0A::
    db "Skeletor@"

String_08_03_0B::
    db "Servant@"

String_08_03_0C::
    db "Lazamanus@"

String_08_03_0D::
    db "Copycat@"

String_08_03_0E::
    db "MadSpirit@"

String_08_03_0F::
    db "PomPomBom@"

String_08_03_10::
    db "Niterich@"

String_08_03_11::
    db $98, $f0

String_08_03_19::
    db "JewelBag@"

String_08_03_1A::
    db "EvilWand@"

String_08_03_1B::
    db "MadCandle@"

String_08_03_1C::
    db "CoilBird@"

String_08_03_1D::
    db "Facer@"

String_08_03_1E::
    db "SpikyBoy@"

String_08_03_1F::
    db "MadMirror@"

String_08_03_20::
    db "RogueNite@"

String_08_03_21::
    db "Puppetor@"

String_08_03_22::
    db "Goopi@"

String_08_03_23::
    db "Voodoll@"

String_08_03_24::
    db "MetalDrak@"

String_08_03_25::
    db "Balzak@"

String_08_03_26::
    db "SabreMan@"

String_08_03_27::
    db "CurseLamp@"

String_08_03_28::
    db "Brushead@"

String_08_03_29::
    db "Roboster@"

String_08_03_2A::
    db "Roboster2@"

String_08_03_2B::
    db "EvilPot@"

String_08_03_2C::
    db "Gismo@"

String_08_03_2D::
    db "LavaMan@"

String_08_03_2E::
    db "IceMan@"

String_08_03_2F::
    db "Mimic@"

String_08_03_30::
    db "Exaucers@"

String_08_03_31::
    db "MudDoll@"

String_08_03_32::
    db "Golem@"

String_08_03_33::
    db "StoneMan@"

String_08_03_34::
    db "BombCrag@"

String_08_03_35::
    db "GoldGolem@"

String_08_03_36::
    db "DarkMate@"

String_08_03_37::
    db "ProtoMech@"

String_08_03_38::
    db "CloudKing@"

String_08_03_39::
    db $98, $f0

String_08_03_3C::
    db "Petiteel@"

String_08_03_3D::
    db "Moray@"

String_08_03_3E::
    db "WalrusMan@"

String_08_03_3F::
    db "RayGigas@"

String_08_03_40::
    db "Anemon@"

String_08_03_41::
    db "Aquarella@"

String_08_03_42::
    db "Merman@"

String_08_03_43::
    db "Octokid@"

String_08_03_44::
    db "PutreFish@"

String_08_03_45::
    db "Octoreach@"

String_08_03_46::
    db "Angleron@"

String_08_03_47::
    db "FishRider@"

String_08_03_48::
    db "RushFish@"

String_08_03_49::
    db "Gamanian@"

String_08_03_4A::
    db "Clawster@"

String_08_03_4B::
    db "CancerMan@"

String_08_03_4C::
    db "RogueWave@"

String_08_03_4D::
    db "Scallopa@"

String_08_03_4E::
    db "SeaHorse@"

String_08_03_4F::
    db "HoodSquid@"

String_08_03_50::
    db "MerTiger@"

String_08_03_51::
    db "AxeShark@"

String_08_03_52::
    db "Octogon@"

String_08_03_53::
    db "KingSquid@"

String_08_03_54::
    db "Digong@"

String_08_03_55::
    db "WhaleMage@"

String_08_03_56::
    db "Aquadon@"

String_08_03_57::
    db "Octoraid@"

String_08_03_58::
    db "Grakos@"

String_08_03_59::
    db "Poseidon@"

String_08_03_5A::
    db "Pumpoise@"

String_08_03_5B::
    db "Starfish@"

String_08_03_5C::
    db $98, $f0

String_08_03_5F::
    db "DracoLord@"

String_08_03_60::
    db "DracoLord@"

String_08_03_61::
    db "LordDraco@"

String_08_03_62::
    db "Hargon@"

String_08_03_63::
    db "Sidoh@"

String_08_03_64::
    db "Genosidoh@"

String_08_03_65::
    db "Baramos@"

String_08_03_66::
    db "Zoma@"

String_08_03_67::
    db "AsuraZoma@"

String_08_03_68::
    db "Pizzaro@"

String_08_03_69::
    db "PsychoPiz@"

String_08_03_6A::
    db "Esterk@"

String_08_03_6B::
    db "Mirudraas@"

String_08_03_6C::
    db "Mirudraas@"

String_08_03_6D::
    db "Mudou@"

String_08_03_6E::
    db "DeathMore@"

String_08_03_6F::
    db "DeathMore@"

String_08_03_70::
    db "DeathMore@"

String_08_03_71::
    db "Darkdrium@"

String_08_03_72::
    db "Orgodemir@"

String_08_03_73::
    db "Orgodemir@"

String_08_03_74::
    db "Darck@"

String_08_03_75::
    db "Tatsu@"

String_08_03_76::
    db "Diago@"

String_08_03_77::
    db "Samsi@"

String_08_03_78::
    db "Bazoo@"

String_08_03_79::
    db $98, $f0

String_08_03_7C::
    db "Lamia@"

String_08_03_7D::
    db "Dimensaur@"

String_08_03_7E::
    db "Kagebou@"

String_08_03_7F::
    db $98, $f0

String_08_04_00::
    db $f0

String_08_04_01::
    db "Blaze@"

String_08_04_02::
    db "Blazemore@"

String_08_04_03::
    db "Blazemost@"

String_08_04_04::
    db "Firebal@"

String_08_04_05::
    db "Firebane@"

String_08_04_06::
    db "Firebolt@"

String_08_04_07::
    db "Bang@"

String_08_04_08::
    db "Boom@"

String_08_04_09::
    db "Explodet@"

String_08_04_0A::
    db "Infernos@"

String_08_04_0B::
    db "Infermore@"

String_08_04_0C::
    db "Infermost@"

String_08_04_0D::
    db "Bolt@"

String_08_04_0E::
    db "Zap@"

String_08_04_0F::
    db "Thordain@"

String_08_04_10::
    db "IceBolt@"

String_08_04_11::
    db "SnowStorm@"

String_08_04_12::
    db "Blizzard@"

String_08_04_13::
    db "Beat@"

String_08_04_14::
    db "Defeat@"

String_08_04_15::
    db "Sacrifice@"

String_08_04_16::
    db "Heal@"

String_08_04_17::
    db "HealMore@"

String_08_04_18::
    db "HealAll@"

String_08_04_19::
    db "HealUs@"

String_08_04_1A::
    db "HealUsAll@"

String_08_04_1B::
    db "MPass@"

String_08_04_1C::
    db "MPassmore@"

String_08_04_1D::
    db "MPassmost@"

String_08_04_1E::
    db "Vivify@"

String_08_04_1F::
    db "Revive@"

String_08_04_20::
    db "Farewell@"

String_08_04_21::
    db "Antidote@"

String_08_04_22::
    db "DeChaos@"

String_08_04_23::
    db "NumbOff@"

String_08_04_24::
    db "CurseOff@"

String_08_04_25::
    db "Upper@"

String_08_04_26::
    db "Increase@"

String_08_04_27::
    db "Sap@"

String_08_04_28::
    db "Defense@"

String_08_04_29::
    db "Speed@"

String_08_04_2A::
    db "SpeedUp@"

String_08_04_2B::
    db "Slow@"

String_08_04_2C::
    db "SlowAll@"

String_08_04_2D::
    db "TwinHits@"

String_08_04_2E::
    db "Surround@"

String_08_04_2F::
    db "Sleep@"

String_08_04_30::
    db "SleepAll@"

String_08_04_31::
    db "TakeMagic@"

String_08_04_32::
    db "RobMagic@"

String_08_04_33::
    db "StopSpell@"

String_08_04_34::
    db "PanicAll@"

String_08_04_35::
    db "Ironize@"

String_08_04_36::
    db "MagicBack@"

String_08_04_37::
    db "Bounce@"

String_08_04_38::
    db "Barrier@"

String_08_04_39::
    db "MagicWall@"

String_08_04_3A::
    db "Transform@"

String_08_04_3B::
    db "BeDragon@"

String_08_04_3C::
    db "Chance@"

String_08_04_3D::
    db "MegaMagic@"

String_08_04_3E::
    db "BigBang@"

String_08_04_3F::
    db "Hellblast@"

String_08_04_40::
    db "FireAir@"

String_08_04_41::
    db "BlazeAir@"

String_08_04_42::
    db "Scorching@"

String_08_04_43::
    db "WhiteFire@"

String_08_04_44::
    db "FrigidAir@"

String_08_04_45::
    db "IceAir@"

String_08_04_46::
    db "IceStorm@"

String_08_04_47::
    db "WhiteAir@"

String_08_04_48::
    db "WindBeast@"

String_08_04_49::
    db "Vacuum@"

String_08_04_4A::
    db "Lightning@"

String_08_04_4B::
    db "RockThrow@"

String_08_04_4C::
    db "Watershot@"

String_08_04_4D::
    db "Tidalwave@"

String_08_04_4E::
    db "CallHelp@"

String_08_04_4F::
    db "YellHelp@"

String_08_04_50::
    db "FireSlash@"

String_08_04_51::
    db "VacuSlash@"

String_08_04_52::
    db "BoltSlash@"

String_08_04_53::
    db "IceSlash@"

String_08_04_54::
    db "SlimeBlow@"

String_08_04_55::
    db "DrakSlash@"

String_08_04_56::
    db "BeastCut@"

String_08_04_57::
    db "BirdBlow@"

String_08_04_58::
    db "BugBlow@"

String_08_04_59::
    db "Shears@"

String_08_04_5A::
    db "DevilCut@"

String_08_04_5B::
    db "ZombieCut@"

String_08_04_5C::
    db "CleanCut@"

String_08_04_5D::
    db "AquaCut@"

String_08_04_5E::
    db "MetalCut@"

String_08_04_5F::
    db "PoisonHit@"

String_08_04_60::
    db "Paralyze@"

String_08_04_61::
    db "NapAttack@"

String_08_04_62::
    db "SquallHit@"

String_08_04_63::
    db "BiAttack@"

String_08_04_64::
    db "QuadHits@"

String_08_04_65::
    db "RainSlash@"

String_08_04_66::
    db "MultiCut@"

String_08_04_67::
    db "GigaSlash@"

String_08_04_68::
    db "ChargeUp@"

String_08_04_69::
    db "PsycheUp@"

String_08_04_6A::
    db "HighJump@"

String_08_04_6B::
    db "EvilSlash@"

String_08_04_6C::
    db "Massacre@"

String_08_04_6D::
    db "TwinSlash@"

String_08_04_6E::
    db "Berserker@"

String_08_04_6F::
    db "Ramming@"

String_08_04_70::
    db "Kamikaze@"

String_08_04_71::
    db "SleepAir@"

String_08_04_72::
    db "PalsyAir@"

String_08_04_73::
    db "PoisonGas@"

String_08_04_74::
    db "PoisonAir@"

String_08_04_75::
    db "Curse@"

String_08_04_76::
    db "OddDance@"

String_08_04_77::
    db "RobDance@"

String_08_04_78::
    db "PaniDance@"

String_08_04_79::
    db "K.O.Dance@"

String_08_04_7A::
    db "LureDance@"

String_08_04_7B::
    db "LifeDance@"

String_08_04_7C::
    db "Hustle@"

String_08_04_7D::
    db "SideStep@"

String_08_04_7E::
    db "SandStorm@"

String_08_04_7F::
    db "Radiant@"

String_08_04_80::
    db "EerieLite@"

String_08_04_81::
    db "Surge@"

String_08_04_82::
    db "UltraDown@"

String_08_04_83::
    db "DeMagic@"

String_08_04_84::
    db "ThickFog@"

String_08_04_85::
    db "TatsuCall@"

String_08_04_86::
    db "DiagoCall@"

String_08_04_87::
    db "SamsiCall@"

String_08_04_88::
    db "BazooCall@"

String_08_04_89::
    db "SuckAir@"

String_08_04_8A::
    db "Focus@"

String_08_04_8B::
    db "LushLicks@"

String_08_04_8C::
    db "SickLick@"

String_08_04_8D::
    db "LegSweep@"

String_08_04_8E::
    db "BigTrip@"

String_08_04_8F::
    db "Ahhh@"

String_08_04_90::
    db "WarCry@"

String_08_04_91::
    db "Geyser@"

String_08_04_92::
    db "DanceShut@"

String_08_04_93::
    db "MouthShut@"

String_08_04_94::
    db "StrongD@"

String_08_04_95::
    db "Dodge@"

String_08_04_96::
    db "BladeD@"

String_08_04_97::
    db "Cover@"

String_08_04_98::
    db "Guardian@"

String_08_04_99::
    db "TailWind@"

String_08_04_9A::
    db "StormWind@"

String_08_04_9B::
    db "AquaWall@"

String_08_04_9C::
    db "SealPray@"

String_08_04_9D::
    db "SuckAll@"

String_08_04_9E::
    db "Imitate@"

String_08_04_9F::
    db "Meditate@"

String_08_04_A0::
    db "LifeSong@"

String_08_04_A1::
    db "LoveRain@"

String_08_04_A2::
    db "Whistle@"

String_08_04_A3::
    db "Pheromone@"

String_08_04_A4::
    db "StepGuard@"

String_08_04_A5::
    db "Outside@"

String_08_04_A6::
    db "Informer@"

String_08_04_A7::
    db "Errand@"

String_08_04_A8::
    db "EagleEye@"

String_08_04_A9::
    db "MapMagic@"

String_08_04_AA::
    db "Ahhh@"

String_08_04_AB::
    db "ZoneOut@"

String_08_04_AC::
    db "Guard@"

String_08_04_AD::
    db "PanicAll@"

String_08_04_AE::
    db "Ironize@"

String_08_04_AF::
    db "HighJump@"

String_08_04_CD::
    db "LoveRain@"

String_08_04_D0::
    db $f0

String_08_05_00::
    db $f0

String_08_05_01::
    db "Herb@"

String_08_05_02::
    db "LoveWater@"

String_08_05_03::
    db "WorldDew@"

String_08_05_04::
    db "Potion@"

String_08_05_05::
    db "ElfWater@"

String_08_05_06::
    db "Antidote@"

String_08_05_07::
    db "MoonHerb@"

String_08_05_08::
    db "Laurel@"

String_08_05_09::
    db "AwakeSand@"

String_08_05_0A::
    db "SkyBell@"

String_08_05_0B::
    db "SageRock@"

String_08_05_0C::
    db "WorldLeaf@"

String_08_05_0D::
    db "ATKseed@"

String_08_05_0E::
    db "DEFseed@"

String_08_05_0F::
    db "AGLseed@"

String_08_05_10::
    db "INTseed@"

String_08_05_11::
    db "LifeAcorn@"

String_08_05_12::
    db "MysticNut@"

String_08_05_13::
    db "Quest", $50, "@"

String_08_05_14::
    db "Horror", $50, "@"

String_08_05_15::
    db "BeNice", $50, "@"

String_08_05_16::
    db "Cheater", $50, "@"

String_08_05_17::
    db "Smart", $50, "@"

String_08_05_18::
    db "Comedy", $50, "@"

String_08_05_19::
    db "BeefJerky@"

String_08_05_1A::
    db "PorkChop@"

String_08_05_1B::
    db "Rib@"

String_08_05_1C::
    db "Sirloin@"

String_08_05_1D::
    db "BadMeat@"

String_08_05_1E::
    db "MeteOrb@"

String_08_05_1F::
    db "BeastTail@"

String_08_05_20::
    db "Repellent@"

String_08_05_21::
    db "ShinyHarp@"

String_08_05_22::
    db "Mist", $51, "@"

String_08_05_23::
    db "Friend", $51, "@"

String_08_05_24::
    db "Wind", $51, "@"

String_08_05_25::
    db "Bolt", $51, "@"

String_08_05_26::
    db "Snow", $51, "@"

String_08_05_27::
    db "Fire", $51, "@"

String_08_05_28::
    db "Warp", $51, "@"

String_08_05_29::
    db "WarpWing@"

String_08_05_2A::
    db "ExitBell@"

String_08_05_2B::
    db "Bookmark@"

String_08_05_2C::
    db "TinyMedal@"

String_08_05_2D::
    db "GoldPass@"

String_08_05_2E::
    db "LogTwig@"

String_08_05_2F::
    db $f0

String_08_05_30::
    db "WaterCall@"

String_08_05_31::
    db "MoonRock@"

String_08_05_32::
    db "Crest@"

String_08_05_33::
    db "YunaSoul@"

String_08_05_34::
    db "SleepHerb@"

String_08_05_35::
    db "Change", $51, "@"

String_08_05_36::
    db "TidalBell@"

String_08_05_37::
    db "HarMirror@"

String_08_05_38::
    db "Sky", $5e, "@"

String_08_05_39::
    db "Heaven", $52, "@"

String_08_05_3A::
    db "Heaven", $54, "@"

String_08_05_3B::
    db "Heaven", $53, "@"

String_08_05_3C::
    db "WizStone@"

String_08_05_3D::
    db "Pretty", $55, "@"

String_08_05_3E::
    db "Accessory@"

String_08_05_40::
    db "VITbelt@"

String_08_05_41::
    db "DracoBelt@"

String_08_05_42::
    db "MagicBelt@"

String_08_05_43::
    db "OddBelt@"

String_08_05_44::
    db "StoneFang@"

String_08_05_45::
    db "SteelFang@"

String_08_05_46::
    db "MermScale@"

String_08_05_47::
    db "DrakScale@"

String_08_05_48::
    db "AGL", $55, "@"

String_08_05_49::
    db "Starry", $55, "@"

String_08_05_4A::
    db "Smart", $56, "@"

String_08_05_4B::
    db "Wise", $56, "@"

String_08_05_4C::
    db "MagicCape@"

String_08_05_4D::
    db "DracoCape@"

String_08_05_4E::
    db "SilvrCape@"

String_08_05_4F::
    db "GoldCape@"

String_08_05_50::
    db "PltnmCape@"

String_08_05_51::
    db "OrcaCape@"

String_08_05_52::
    db "BraveCape@"

String_08_05_53::
    db "D-Scale@"

String_08_05_54::
    db "None@"

String_08_05_5A::
    db "Life", $55, "@"

String_08_05_5B::
    db "Divine", $55, "@"

String_08_05_5C::
    db "War", $55, "@"

String_08_05_5D::
    db "Mage", $55, "@"

String_08_05_5E::
    db "Fight", $55, "@"

String_08_05_5F::
    db "Sailor", $55, "@"

String_08_05_60::
    db "Thief", $55, "@"

String_08_05_61::
    db "Cleric", $55, "@"

String_08_05_62::
    db $f0

String_08_06_00::
    db "Restores HP of one<LINE>"
    db "monster by 30~40.@"

String_08_06_02::
    db "Restores HP of one<LINE>"
    db "monster by 60~70.@"

String_08_06_03::
    db "Fully restores HP<LINE>"
    db "of all monsters.@"

String_08_06_04::
    db "Restores MP of one<LINE>"
    db "monster by 20~30.@"

String_08_06_05::
    db "Fully restores MP<LINE>"
    db "of one monster.@"

String_08_06_06::
    db "Removes all traces<LINE>"
    db "of poison.@"

String_08_06_07::
    db "Cures paralysis.@"

String_08_06_08::
    db "Lifts a curse off<LINE>"
    db "one monster.@"

String_08_06_09::
    db "Awakens a sleeping<LINE>"
    db "monster.@"

String_08_06_0A::
    db "Snaps a monster<LINE>"
    db "out of confusion.@"

String_08_06_0B::
    db "Restores HP of all<LINE>"
    db "monsters by 60~70.@"

String_08_06_0C::
    db "Revives a dead<LINE>"
    db "monster.@"

String_08_06_0D::
    db "Raises ATK by 3.@"

String_08_06_0E::
    db "Raises DEF by 3.@"

String_08_06_0F::
    db "Raises AGL by 3.@"

String_08_06_10::
    db "Raises INT by 3.@"

String_08_06_11::
    db "Raises max. HP<LINE>"
    db "by 5.@"

String_08_06_12::
    db "Raises max. MP<LINE>"
    db "by 5.@"

String_08_06_13::
    db "Makes the reader<LINE>"
    db "braver.@"

String_08_06_14::
    db "Makes the reader<LINE>"
    db "more cowardly.@"

String_08_06_15::
    db "Makes the reader<LINE>"
    db "more kindly.@"

String_08_06_16::
    db "Makes the reader<LINE>"
    db "more sly.@"

String_08_06_17::
    db "Makes the reader<LINE>"
    db "more thoughtful.@"

String_08_06_18::
    db "Makes the reader<LINE>"
    db "simple-minded.@"

String_08_06_19::
    db "Tames monsters<LINE>"
    db "just a little.@"

String_08_06_1A::
    db "Tames monsters a<LINE>"
    db "little bit.@"

String_08_06_1B::
    db "Tames monsters a<LINE>"
    db "lot.@"

String_08_06_1C::
    db "Tames monsters<LINE>"
    db "very much.@"

String_08_06_1D::
    db "Tames a tiny bit,<LINE>"
    db "but also poisons.@"

String_08_06_1E::
    db "Tames monsters<LINE>"
    db "incredibly.@"

String_08_06_1F::
    db "Checks if monster<LINE>"
    db "was caught before.@"

String_08_06_20::
    db "Prevents monsters<LINE>"
    db "from appearing.@"

String_08_06_21::
    db "Attracts monsters<LINE>"
    db "when strummed.@"

String_08_06_22::
    db "Prevents casting<LINE>"
    db "of spells.@"

String_08_06_23::
    db "Doubles physical<LINE>"
    db "power of one.@"

String_08_06_24::
    db "Hits all enemies<LINE>"
    db "with a windstorm.@"

String_08_06_25::
    db "Hits all enemies<LINE>"
    db "with lightning.@"

String_08_06_26::
    db "Hits all enemies<LINE>"
    db "with a blizzard.@"

String_08_06_27::
    db "Hits one target<LINE>"
    db "with a fireball.@"

String_08_06_28::
    db "Instantly warps to<LINE>"
    db "the Door Shrine.@"

String_08_06_29::
    db "Instantly warps to<LINE>"
    db "GreatLog.@"

String_08_06_2A::
    db "Instantly warps to<LINE>"
    db "the exit.@"

String_08_06_2B::
    db "Enables saving in<LINE>"
    db "the Journal.@"

String_08_06_2C::
    db "Collect and trade<LINE>"
    db "for rare gifts.@"

String_08_06_2D::
    db "Get a 10-percent<LINE>"
    db "discount at shops.@"

String_08_06_2E::
    db "Moves the Door<LINE>"
    db "Shrine.@"

String_08_06_2F::
    db "Reveals Mirage<LINE>"
    db "Lake.@"

String_08_06_31::
    db "A magic stone that<LINE>"
    db "raises the tide.@"

String_08_06_32::
    db "A medal from the<LINE>"
    db "elemental spirit.@"

String_08_06_33::
    db "The lost soul of a<LINE>"
    db "princess.@"

String_08_06_34::
    db "A blue flower that<LINE>"
    db "grows in snow.@"

String_08_06_35::
    db "Transforms users<LINE>"
    db "into monsters.@"

String_08_06_36::
    db "Summons a clam for<LINE>"
    db "crossing the sea.@"

String_08_06_37::
    db "Destroys what it<LINE>"
    db "reflects.@"

String_08_06_38::
    db "Summons a cloud<LINE>"
    db "for flying.@"

String_08_06_39::
    db "A legendary helmet<LINE>"
    db "found in a cave.@"

String_08_06_3A::
    db "A legendary armor<LINE>"
    db "found in a tower.@"

String_08_06_3B::
    db "A legendary sword<LINE>"
    db "found in a castle.@"

String_08_06_3C::
    db "A magical stone<LINE>"
    db "that glows blue.@"

String_08_06_3D::
    db "A beautiful gold<LINE>"
    db "ring.@"

String_08_06_3E::
    db "Undefined.@"

String_08_06_40::
    db "Raises max. HP<LINE>"
    db "by 30.@"

String_08_06_41::
    db "Raises max. HP<LINE>"
    db "by 80.@"

String_08_06_42::
    db "Raises max. MP<LINE>"
    db "by 30.@"

String_08_06_43::
    db "Raises max. MP<LINE>"
    db "by 80.@"

String_08_06_44::
    db "Raises ATK by 10.@"

String_08_06_45::
    db "Raises ATK by 50.@"

String_08_06_46::
    db "Raises DEF by 10.@"

String_08_06_47::
    db "Raises DEF by 50.@"

String_08_06_48::
    db "Raises AGL by 10.@"

String_08_06_49::
    db "Raises AGL by 50.@"

String_08_06_4A::
    db "Raises INT by 50.@"

String_08_06_4B::
    db "Raises INT by 100.@"

String_08_06_4C::
    db "Raises resistance<LINE>"
    db "to attack spells.@"

String_08_06_4D::
    db "Raises resistance<LINE>"
    db "to fire and ice.@"

String_08_06_4E::
    db "Resists confusion,<LINE>"
    db "poison ", $b6, " sleep.@"

String_08_06_4F::
    db "Resists most<LINE>"
    db "status skills.@"

String_08_06_50::
    db "Resists curse,<LINE>"
    db "paralysis ", $b6, " death.@"

String_08_06_51::
    db "Raises resistance<LINE>"
    db "to water skills.@"

String_08_06_52::
    db "Prevents skills<LINE>"
    db "from being sealed.@"

String_08_06_53::
    db "Raises DEF by 5.@"

String_08_06_54::
    db "Undefined.@"

String_08_06_5A::
    db "Restores HP by 1<LINE>"
    db "on every step.@"

String_08_06_5B::
    db "Restores MP by 1<LINE>"
    db "on every step.@"

String_08_06_5C::
    db "Promotes max. HP<LINE>"
    db "gain.@"

String_08_06_5D::
    db "Promotes max.<LINE>"
    db "MP gain.@"

String_08_06_5E::
    db "Promotes ATK gain<LINE>"
    db "while growing.@"

String_08_06_5F::
    db "Promotes DEF gain<LINE>"
    db "while growing.@"

String_08_06_60::
    db "Promotes AGL gain<LINE>"
    db "while growing.@"

String_08_06_61::
    db "Promotes INT gain<LINE>"
    db "while growing.@"

String_08_06_62::
    db "Undefined.@"

String_08_06_63::
    db $f1, $f0

String_08_06_6F::
    db "Checks if monster<LINE>"
    db "was caught before.@"

String_08_07_00::
    db "Hotblood@"

String_08_07_01::
    db "Eager@"

String_08_07_02::
    db "Smug@"

String_08_07_03::
    db "Earnest@"

String_08_07_04::
    db "Pushy@"

String_08_07_05::
    db "Snobby@"

String_08_07_06::
    db "Reckless@"

String_08_07_07::
    db "Daring@"

String_08_07_08::
    db "Daredevil@"

String_08_07_09::
    db "Cool/Calm@"

String_08_07_0A::
    db "Serious@"

String_08_07_0B::
    db "Selfish@"

String_08_07_0C::
    db "Simple@"

String_08_07_0D::
    db "Innocent@"

String_08_07_0E::
    db "Prideful@"

String_08_07_0F::
    db "Nosy@"

String_08_07_10::
    db "Whimsy@"

String_08_07_11::
    db "Spoiled@"

String_08_07_12::
    db "Smart@"

String_08_07_13::
    db "Sly@"

String_08_07_14::
    db "Cruel@"

String_08_07_15::
    db "Shy@"

String_08_07_16::
    db "Affable@"

String_08_07_17::
    db "Coward@"

String_08_07_18::
    db "Gullible@"

String_08_07_19::
    db "Carefree@"

String_08_07_1A::
    db "Lazy@"

String_08_08_00::
    db "No items@"

String_08_08_01::
    db "Toss this away?@"

String_08_08_02::
    db "<BUF2> can't be<LINE>"
    db "tossed out.<WAIT>"
    db "@"

String_08_08_03::
    db "But nothing<LINE>"
    db "happened.<WAIT>"
    db "@"

String_08_08_04::
    db "<PLAYER> threw away<LINE>"
    db "the <BUF2>.<WAIT>"
    db "@"

String_08_08_05::
    db $f9, $00, $f0

String_08_08_06::
    db "<PLAYER> tried using<LINE>"
    db "<BUF2>.<WAIT>"
    db "<CLEAR>But nothing<LINE>"
    db "happened.<WAIT>"
    db "@"

String_08_08_07::
    db "Toss out the<LINE>"
    db "<BUF2>?@"

String_08_08_08::
    db "You can't toss<LINE>"
    db "that out!<WAIT>"
    db "@"

String_08_08_09::
    db "That can't be used<LINE>"
    db "here.<WAIT>"
    db "@"

String_08_08_0A::
    db "Not in use.@"

String_08_08_0B::
    db "<PLAYER> inserted the<LINE>"
    db "key.<WAIT>"
    db "@"

String_08_08_0C::
    db "The key could not<LINE>"
    db "be used yet.<WAIT>"
    db "@"

String_08_08_0D::
    db "You can't save<LINE>"
    db "here.<WAIT>"
    db "@"

String_08_08_0E::
    db "No skills@"
    ds $c17, $00
