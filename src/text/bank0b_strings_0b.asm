; ROM bank $0B: string tables
; The annotated listing of this bank is build/listing/bank0b.asm.

SECTION "Bank 0B", ROMX
    db $0b

; Loads DE = BeginStringDisplay_Bank0B_StringCategories (this bank string table: category 0 the
; library talk and short strings such as '???' and 'Welcome to the library.', 1 the monster
; descriptions, 2 the family names such as 'Slime') and calls BeginStringDisplay, which starts the
; text printer on string wStringIndex of category wStringCategory. Reached with farcall from the
; debug menu (bank $01) and called by ShowString_Bank0B. The 7 bytes after its ret are an unlabelled
; second copy of the same ld de / call / ret. (C1, E-0376)
; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank0B:: ; configured code entry (E-0395 (BeginStringDisplay_Bank0B: found only by the $4001 fall-through guess, which a new entry later in the bank can change; listed so it stays traced)); C0
    ld de, BeginStringDisplay_Bank0B_StringCategories
    call BeginStringDisplay
    ret

SECTION "Bank 0B CopyStringToBuffer_Bank0B", ROMX

; Loads DE = BeginStringDisplay_Bank0B_StringCategories, the string table of
; BeginStringDisplay_Bank0B, and calls CopyStringToBuffer: string wStringIndex of category
; wStringCategory is copied with its $F0 end to the address in wStringDestLo/Hi. It pairs with
; BeginStringDisplay_Bank0B like the other CopyStringToBuffer stubs of the string banks. No traced
; code, jump table or pointer reaches it (E-0395: it decodes as a routine but is unreached in the
; static listing). (C2, E-0395; probed E-0395)
; the same 7 bytes as CopyStringToBuffer_Bank09 (CopyStringToBuffer_Bank09) (E-0353)
CopyStringToBuffer_Bank0B:: ; configured code entry (E-0395); C0
    ld de, BeginStringDisplay_Bank0B_StringCategories
    call CopyStringToBuffer
    ret

SECTION "Bank 0B ShowString_Bank0B", ROMX

; Shows a bank $0B string at once: BeginStringDisplay_Bank0B (string wStringIndex of category
; wStringCategory) and then RunStringDisplayToEnd, which prints the whole string in one go instead
; of a glyph per frame. The library far-calls it six times (LibraryMenu_ShowMonsterEntry_DrawEntry,
; the pedigree and description steps, and LibraryMenu_DrawSeenNames), after setting
; wTextWindowTileLo/Hi and the window size. (C1, E-0376)
; BeginStringDisplay_Bank0B (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank0B::
    call BeginStringDisplay_Bank0B
    call RunStringDisplayToEnd
    ret

SECTION "Bank 0B BeginStringDisplay_Bank0B_StringCategories", ROMX

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank0B_StringCategories::
    dw StringList_Bank0B_StringCategories_0 ; id 0
    dw StringList_Bank0B_StringCategories_1 ; id 1
    dw StringList_Bank0B_StringCategories_2 ; id 2

; category list of BeginStringDisplay_Bank0B_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank0B_StringCategories_0::
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

StringList_Bank0B_StringCategories_1::
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

StringList_Bank0B_StringCategories_2::
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
    db "???@"

String_0B_00_01::
    db "<VOICE2>*: Welcome to the<LINE>"
    db "library.<PROMPT>"
    db "<CLEAR>Which family will<LINE>"
    db "you check?@"

String_0B_00_02::
    db "<VOICE2>*: Come back if you<LINE>"
    db "need to check up<PROMPT>"
    db "<NEXT>on your monster"
    db "<NEXT>Catalog.<WAIT>"
    db "@"

String_0B_00_03::
    db "<VOICE2>*: Which species<LINE>"
    db "will you check?@"

String_0B_00_04::
    db "<VOICE2>*: Which family<LINE>"
    db "will you check?@"

String_0B_00_05::
    db "<VOICE2>*: That family is a<LINE>"
    db "mystery still…<WAIT>"
    db "@"

String_0B_00_06::
    db "A slime that has<LINE>"
    db "dragon's blood.@"

String_0B_00_12::
    db "Recognized by its<LINE>"
    db "distinctive spots.@"

String_0B_00_13::
    db "Flies by flapping<LINE>"
    db "ear-like wings.@"

String_0B_00_14::
    db "Sunlight redoubles<LINE>"
    db "its usual power.@"

String_0B_00_15::
    db "Its rugged shell<LINE>"
    db "makes it slow.@"

String_0B_00_16::
    db "The slime shields<LINE>"
    db "the knight.@"

String_0B_00_17::
    db "Venom dissolved<LINE>"
    db "its own body.@"

String_0B_00_18::
    db "Although cubical,<LINE>"
    db "it is squishy.@"

String_0B_00_19::
    db "The body grew hard<LINE>"
    db "in the hard shell.@"

String_0B_00_1A::
    db "No.1 in softness<LINE>"
    db "and weakness.@"

String_0B_00_1B::
    db "Heals others with<LINE>"
    db "its tentacles.@"

String_0B_00_1C::
    db "The mane attests<LINE>"
    db "to its ferocity.@"

String_0B_00_1D::
    db "Likes to drop on<LINE>"
    db "foes heavily.@"

String_0B_00_1E::
    db "Enhanced for speed<LINE>"
    db "and durability.@"

String_0B_00_1F::
    db "Its huge legs are<LINE>"
    db "its main assets.@"

String_0B_00_20::
    db "Lives up to its<LINE>"
    db "name in power.@"

String_0B_00_21::
    db "Hard and fast, it<LINE>"
    db "flees quickly.@"

String_0B_00_22::
    db "Extremely hard and<LINE>"
    db "prone to fleeing.@"

String_0B_00_23::
    db "The largest of<LINE>"
    db "spotted slime.@"

String_0B_00_24::
    db "A cheerful slime<LINE>"
    db "that loves heat.@"

String_0B_00_25::
    db "Prefers to make<LINE>"
    db "its enemies laugh.@"

String_0B_00_26::
    db "The halo is used<LINE>"
    db "to bind enemies.@"

String_0B_00_27::
    db "Its body is<LINE>"
    db "extremely hard.@"

String_0B_00_28::
    db "Its golden body is<LINE>"
    db "unbreakable.@"

String_0B_00_29::
    db "The wise elder<LINE>"
    db "among slime.@"

String_0B_00_2A::
    db "What lurks inside<LINE>"
    db "is a mystery.@"

String_0B_00_2B::
    db "Despite its name,<LINE>"
    db "it never changes.@"

String_0B_00_35::
    db "Slow, but heavily<LINE>"
    db "protected.@"

String_0B_00_36::
    db "Its beaks never<LINE>"
    db "miss flying prey.@"

String_0B_00_37::
    db "Gases in its body<LINE>"
    db "keep it afloat.@"

String_0B_00_38::
    db "Also known as<LINE>"
    db "butterfly dragon.@"

String_0B_00_39::
    db "An accomplished<LINE>"
    db "user of swords.@"

String_0B_00_3A::
    db "Lives quietly in<LINE>"
    db "poisonous bogs.@"

String_0B_00_3B::
    db "Stabs with sword-<LINE>"
    db "like spikes.@"

String_0B_00_3C::
    db "Agile and equipped<LINE>"
    db "with sharp claws.@"

String_0B_00_3D::
    db "Breathes fire of<LINE>"
    db "great intensity.@"

String_0B_00_3E::
    db "Runs fast, but in<LINE>"
    db "a comical manner.@"

String_0B_00_3F::
    db "Its power is best<LINE>"
    db "among dragons.@"

String_0B_00_40::
    db "It flies with a<LINE>"
    db "rocking motion.@"

String_0B_00_41::
    db "Changes its colors<LINE>"
    db "to confuse foes.@"

String_0B_00_42::
    db "Works and attacks<LINE>"
    db "in droves.@"

String_0B_00_43::
    db "The wings are used<LINE>"
    db "for intimidation.@"

String_0B_00_44::
    db "Strikes foes with<LINE>"
    db "venomous fangs.@"

String_0B_00_45::
    db "Adept at making<LINE>"
    db "aerial attacks.@"

String_0B_00_46::
    db "Attacks with its<LINE>"
    db "long tongue.@"

String_0B_00_47::
    db "Breaks foes as if<LINE>"
    db "they were rocks.@"

String_0B_00_48::
    db "Great in both<LINE>"
    db "power and looks.@"

String_0B_00_49::
    db "Shakes its comb<LINE>"
    db "when facing a foe.@"

String_0B_00_4A::
    db "Spreads its wings<LINE>"
    db "for intimidation.@"

String_0B_00_4B::
    db "Strikes hard to KO<LINE>"
    db "foes instantly.@"

String_0B_00_4C::
    db "Thinks five times<LINE>"
    db "faster than foes.@"

String_0B_00_4D::
    db "Wildly swings its<LINE>"
    db "ax in battle.@"

String_0B_00_4E::
    db "Seeks prey with<LINE>"
    db "its whiskers.@"

String_0B_00_4F::
    db "The snakes it ate<LINE>"
    db "became its feet.@"

String_0B_00_50::
    db "Summons clouds and<LINE>"
    db "causes rain.@"

String_0B_00_51::
    db "Its body hardened<LINE>"
    db "from hibernation.@"

String_0B_00_52::
    db "Proud of its power<LINE>"
    db "and enormous size.@"

String_0B_00_53::
    db "Captures and eats<LINE>"
    db "foes in one gulp.@"

String_0B_00_58::
    db "The horn glows to<LINE>"
    db "confound enemies.@"

String_0B_00_59::
    db "Flies in close and<LINE>"
    db "claws savagely.@"

String_0B_00_5A::
    db "The fluffy fur<LINE>"
    db "offers protection.@"

String_0B_00_5B::
    db "Its armor is made<LINE>"
    db "of patched leaves.@"

String_0B_00_5C::
    db "It acts before it<LINE>"
    db "thinks.@"

String_0B_00_5D::
    db "It never lets go<LINE>"
    db "of the skull.@"

String_0B_00_5E::
    db "Shapes wind into<LINE>"
    db "powerful barriers.@"

String_0B_00_5F::
    db "Attacks prey in a<LINE>"
    db "biting swarm.@"

String_0B_00_60::
    db "Snags prey with<LINE>"
    db "its ropy tongue.@"

String_0B_00_61::
    db "Dances to cheer up<LINE>"
    db "the atmosphere.@"

String_0B_00_62::
    db "The horned shell<LINE>"
    db "is a good weapon.@"

String_0B_00_63::
    db "Its humorous face<LINE>"
    db "makes it popular.@"

String_0B_00_64::
    db "Has difficulty<LINE>"
    db "with the hammer.@"

String_0B_00_65::
    db "Its claws inflict<LINE>"
    db "wicked damage.@"

String_0B_00_66::
    db "It is difficult to<LINE>"
    db "spot in snow.@"

String_0B_00_67::
    db "It never misses<LINE>"
    db "with its arrows.@"

String_0B_00_68::
    db "Never loses in the<LINE>"
    db "darkness.@"

String_0B_00_69::
    db "Leaps out of trees<LINE>"
    db "to attack.@"

String_0B_00_6A::
    db "Burrows using its<LINE>"
    db "oversized shovel.@"

String_0B_00_6B::
    db "Flies using its<LINE>"
    db "ears as wings.@"

String_0B_00_6C::
    db "Its horn slays<LINE>"
    db "foes painlessly.@"

String_0B_00_6D::
    db "The horns curled<LINE>"
    db "from butting.@"

String_0B_00_6E::
    db "Moves fast in<LINE>"
    db "spite of its size.@"

String_0B_00_6F::
    db "Immobilizes foes<LINE>"
    db "with its trunk.@"

String_0B_00_70::
    db "Slaughters foes<LINE>"
    db "with its forelegs.@"

String_0B_00_71::
    db "Grips and hurls<LINE>"
    db "foes with horns.@"

String_0B_00_72::
    db "Friendly despite<LINE>"
    db "its savage looks.@"

String_0B_00_73::
    db "Sits quietly to<LINE>"
    db "avoid hunger.@"

String_0B_00_74::
    db "Uses mean looks to<LINE>"
    db "intimidate foes.@"

String_0B_00_75::
    db "A 100-year old cat<LINE>"
    db "capable of magic.@"

String_0B_00_76::
    db "Polishes its sword<LINE>"
    db "shiny every day.@"

String_0B_00_77::
    db "Attracts mates<LINE>"
    db "with its plumage.@"

String_0B_00_7B::
    db "A bird with a bug-<LINE>"
    db "like body.@"

String_0B_00_7C::
    db "Lack of exercise<LINE>"
    db "stunted its wings.@"

String_0B_00_7D::
    db "The facial flower<LINE>"
    db "is stuck on.@"

String_0B_00_7E::
    db "It spreads its<LINE>"
    db "limbs and glides.@"

String_0B_00_7F::
    db "Very cowardly.<LINE>"
    db "Likely to flee.@"

String_0B_00_80::
    db "Always carries its<LINE>"
    db "skull roost.@"

String_0B_00_81::
    db "Almost invisible<LINE>"
    db "except for a glow.@"

String_0B_00_82::
    db "It slices through<LINE>"
    db "water speedily.@"

String_0B_00_83::
    db "Hides in darkness<LINE>"
    db "and sneak attacks.@"

String_0B_00_84::
    db "Hunts using the<LINE>"
    db "eyes on its wings.@"

String_0B_00_85::
    db "Constant naps made<LINE>"
    db "this fowl huge.@"

String_0B_00_86::
    db "Delivers harsh<LINE>"
    db "head-butts.@"

String_0B_00_87::
    db "Hoots forlornly<LINE>"
    db "night after night.@"

String_0B_00_88::
    db "Pecks foes by<LINE>"
    db "twisting its neck.@"

String_0B_00_89::
    db "Hooks and tears<LINE>"
    db "with sharp claws.@"

String_0B_00_8A::
    db "Has eyes on its<LINE>"
    db "body and head.@"

String_0B_00_8B::
    db "Adept at freezing<LINE>"
    db "foes immobile.@"

String_0B_00_8C::
    db "Incinerates foes<LINE>"
    db "to nothing.@"

String_0B_00_8D::
    db "Wraps foes in<LINE>"
    db "white lightning.@"

String_0B_00_8E::
    db "Dives from the sky<LINE>"
    db "and kicks foes up.@"

String_0B_00_8F::
    db "Smashes foes flat<LINE>"
    db "with its body.@"

String_0B_00_90::
    db "Dances adroitly<LINE>"
    db "despite its girth.@"

String_0B_00_91::
    db "Has rainbow horns<LINE>"
    db "and tail.@"

String_0B_00_92::
    db "Flies and runs at<LINE>"
    db "the same speed.@"

String_0B_00_93::
    db "Thick-skinned and<LINE>"
    db "powerfully winged.@"

String_0B_00_94::
    db "Slides on its<LINE>"
    db "belly on ice.@"

String_0B_00_95::
    db "Thumps along on<LINE>"
    db "its thin vines.@"

String_0B_00_9E::
    db "Spits fire-hot<LINE>"
    db "seeds at foes.@"

String_0B_00_9F::
    db "Frail, but sharply<LINE>"
    db "intelligent.@"

String_0B_00_A0::
    db "It floats rather<LINE>"
    db "than flies.@"

String_0B_00_A1::
    db "Spins to fire its<LINE>"
    db "needles wildly.@"

String_0B_00_A2::
    db "Closes its eye and<LINE>"
    db "mouth to hide.@"

String_0B_00_A3::
    db "Scatters toxic<LINE>"
    db "spores by dancing.@"

String_0B_00_A4::
    db "Its face hardened<LINE>"
    db "into amber.@"

String_0B_00_A5::
    db "Swallows prey with<LINE>"
    db "its giant tongue.@"

String_0B_00_A6::
    db "Attacks the unwary<LINE>"
    db "who sit on it.@"

String_0B_00_A7::
    db "Its body fluids<LINE>"
    db "cause watery eyes.@"

String_0B_00_A8::
    db "Dances to make<LINE>"
    db "foes careless.@"

String_0B_00_A9::
    db "Usually calm, but<LINE>"
    db "easily enraged.@"

String_0B_00_AA::
    db "Closes its mouth<LINE>"
    db "to wait for prey.@"

String_0B_00_AB::
    db "It glares to lay a<LINE>"
    db "curse on foes.@"

String_0B_00_AC::
    db "It dies if it<LINE>"
    db "stops dancing.@"

String_0B_00_AD::
    db "Fires beans from<LINE>"
    db "its belly.@"

String_0B_00_AE::
    db "Hides underground<LINE>"
    db "until it gets hot.@"

String_0B_00_AF::
    db "Eats prey whole<LINE>"
    db "without chewing.@"

String_0B_00_B0::
    db "Eats rapidly with<LINE>"
    db "its three heads.@"

String_0B_00_B1::
    db "Embraces foes and<LINE>"
    db "drains nutrients.@"

String_0B_00_B2::
    db "Immobilizes foes<LINE>"
    db "with thorny vines.@"

String_0B_00_B3::
    db "Represents the<LINE>"
    db "anger of plants.@"

String_0B_00_B4::
    db "A mischievous<LINE>"
    db "plant elemantal.@"

String_0B_00_B5::
    db "An intelligent but<LINE>"
    db "odd ball of fluff.@"

String_0B_00_B6::
    db "Forces foes to<LINE>"
    db "dance with it.@"

String_0B_00_B7::
    db "A universal hero<LINE>"
    db "among its kind.@"

String_0B_00_B8::
    db "Attacks in a slow,<LINE>"
    db "deliberate manner.@"

String_0B_00_C1::
    db "Its stumpy feet<LINE>"
    db "limit its speed.@"

String_0B_00_C2::
    db "Drags prey under<LINE>"
    db "the ground.@"

String_0B_00_C3::
    db "Scatters dust to<LINE>"
    db "confuse foes.@"

String_0B_00_C4::
    db "A flower grew onto<LINE>"
    db "it while in soil.@"

String_0B_00_C5::
    db "Constricts foes<LINE>"
    db "with its body.@"

String_0B_00_C6::
    db "The lips conceal a<LINE>"
    db "long tongue.@"

String_0B_00_C7::
    db "Its hard shell<LINE>"
    db "make it tough.@"

String_0B_00_C8::
    db "Stabs and sucks<LINE>"
    db "with its mouth.@"

String_0B_00_C9::
    db "Small, but moves<LINE>"
    db "in large groups.@"

String_0B_00_CA::
    db "Always hops for<LINE>"
    db "unknown reasons.@"

String_0B_00_CB::
    db "Bites using mouths<LINE>"
    db "on both ends.@"

String_0B_00_CC::
    db "Swings side to<LINE>"
    db "side as it moves.@"

String_0B_00_CD::
    db "Climbs walls using<LINE>"
    db "its tentacles.@"

String_0B_00_CE::
    db "Stifles foes with<LINE>"
    db "its large wings.@"

String_0B_00_CF::
    db "Its eyes extend to<LINE>"
    db "spot far-off foes.@"

String_0B_00_D0::
    db "Its claws can't<LINE>"
    db "nick the shell.@"

String_0B_00_D1::
    db "The tail stinger<LINE>"
    db "is the finisher.@"

String_0B_00_D2::
    db "Its loud buzzing<LINE>"
    db "gives it away.@"

String_0B_00_D3::
    db "Stabs and hacks<LINE>"
    db "with its scythes.@"

String_0B_00_D4::
    db "The horn is used<LINE>"
    db "to hit and parry.@"

String_0B_00_D5::
    db "The sickles are as<LINE>"
    db "large as its body.@"

String_0B_00_D6::
    db "The stinger is a<LINE>"
    db "fierce weapon.@"

String_0B_00_D7::
    db "Dislikes water and<LINE>"
    db "lives in soil.@"

String_0B_00_D8::
    db "Capable of moving<LINE>"
    db "in any direction.@"

String_0B_00_D9::
    db "Its many eyes don't<LINE>"
    db "miss a thing.@"

String_0B_00_DA::
    db "Prefers mischief<LINE>"
    db "over eating.@"

String_0B_00_E4::
    db "The tentacles are<LINE>"
    db "actually snakes.@"

String_0B_00_E5::
    db "Hates getting its<LINE>"
    db "white fur dirty.@"

String_0B_00_E6::
    db "Intelligent, but<LINE>"
    db "far too frail.@"

String_0B_00_E7::
    db "The tentacles are<LINE>"
    db "tipped with eyes.@"

String_0B_00_E8::
    db "Its eye has a 360-<LINE>"
    db "degree coverage.@"

String_0B_00_E9::
    db "Never dismounts<LINE>"
    db "from the skull.@"

String_0B_00_EA::
    db "Intimidates with<LINE>"
    db "red, glaring eyes.@"

String_0B_00_EB::
    db "Its foam lets it<LINE>"
    db "dodge attacks.@"

String_0B_00_EC::
    db "Small, but deadly<LINE>"
    db "with spells.@"

String_0B_00_ED::
    db "Flies incredibly<LINE>"
    db "fast in mischief.@"

String_0B_00_EE::
    db "Stabs foes through<LINE>"
    db "with its trident.@"

String_0B_00_EF::
    db "Loves to fight,<LINE>"
    db "defeating all.@"

String_0B_00_F0::
    db "Stays red-faced<LINE>"
    db "from straining.@"

String_0B_00_F1::
    db "The spear is<LINE>"
    db "largely for show.@"

String_0B_00_F2::
    db "Swings spiked orbs<LINE>"
    db "to keep foes away.@"

String_0B_00_F3::
    db "Hides and strikes<LINE>"
    db "in darkness.@"

String_0B_00_F4::
    db "Uses its agility<LINE>"
    db "to confound foes.@"

String_0B_00_F5::
    db "Even its head is<LINE>"
    db "full of muscles.@"

String_0B_00_F6::
    db "The horn and fangs<LINE>"
    db "are its weapons.@"

String_0B_00_F7::
    db "Strong. Just<LINE>"
    db "incredibly so.@"

String_0B_00_F8::
    db "What the armor<LINE>"
    db "hides is unknown.@"

String_0B_00_F9::
    db "Waits in wells for<LINE>"
    db "prey to come.@"

String_0B_00_FA::
    db "Swings for the<LINE>"
    db "foe's weak spots.@"

String_0B_00_FB::
    db "Surprisingly agile<LINE>"
    db "for its heftiness.@"

String_0B_00_FC::
    db "The armor gives it<LINE>"
    db "great power.@"

String_0B_00_FD::
    db "Tracks foes<LINE>"
    db "with three eyes.@"

String_0B_00_FE::
    db "Seeks out battles<LINE>"
    db "for enjoyment.@"

String_0B_00_FF::
    db "When enraged, the<LINE>"
    db "horns straighten.@"

String_0B_01_00::
    db "A cruel demon that<LINE>"
    db "distorts wishes.@"

String_0B_01_01::
    db "Fades in and out<LINE>"
    db "to scare people.@"

String_0B_01_07::
    db "Created from the<LINE>"
    db "bones of dragons.@"

String_0B_01_08::
    db "It isn't bothered<LINE>"
    db "by new injuries.@"

String_0B_01_09::
    db "Drags stragglers<LINE>"
    db "off to death.@"

String_0B_01_0A::
    db "Bandages obscure<LINE>"
    db "its vision badly.@"

String_0B_01_0B::
    db "Its dark soul<LINE>"
    db "stained its body.@"

String_0B_01_0C::
    db "Unable to stop<LINE>"
    db "fighting in death.@"

String_0B_01_0D::
    db "It lost its body<LINE>"
    db "due to magic.@"

String_0B_01_0E::
    db "Rocks side to side<LINE>"
    db "as it approaches.@"

String_0B_01_0F::
    db "Dead, rotten, and<LINE>"
    db "not at peace.@"

String_0B_01_10::
    db "Shoots dirt from<LINE>"
    db "all over its body.@"

String_0B_01_11::
    db "Capable of going<LINE>"
    db "through walls.@"

String_0B_01_12::
    db "A shy soul, it<LINE>"
    db "swaddles its body.@"

String_0B_01_13::
    db "Sneaks up on foes<LINE>"
    db "from behind.@"

String_0B_01_14::
    db "The limbs were<LINE>"
    db "mixed up in death.@"

String_0B_01_15::
    db "The collar of fire<LINE>"
    db "is used to attack.@"

String_0B_01_16::
    db "Its arms were made<LINE>"
    db "into weapons.@"

String_0B_01_17::
    db "Retains its noble<LINE>"
    db "nature in death.@"

String_0B_01_18::
    db "Became a zombie<LINE>"
    db "while still alive.@"

String_0B_01_19::
    db "Will never be<LINE>"
    db "freed in death.@"

String_0B_01_1A::
    db "Slashes repeatedly<LINE>"
    db "with its six arms.@"

String_0B_01_1B::
    db "The four arms move<LINE>"
    db "independently.@"

String_0B_01_1C::
    db "Protects its head<LINE>"
    db "with both hands.@"

String_0B_01_1D::
    db "Shows dedication<LINE>"
    db "to its mimicry.@"

String_0B_01_1E::
    db "Wandering souls<LINE>"
    db "gathered as one.@"

String_0B_01_1F::
    db "Its thoughts are<LINE>"
    db "unfathomable.@"

String_0B_01_20::
    db "A proud and strong<LINE>"
    db "zombie swordsman.@"

String_0B_01_21::
    db "Dances if it spots<LINE>"
    db "anything shiny.@"

String_0B_01_2A::
    db "A wand that split<LINE>"
    db "from its mage.@"

String_0B_01_2B::
    db "Falls asleep if<LINE>"
    db "the flame dies.@"

String_0B_01_2C::
    db "A wind-up cuckoo<LINE>"
    db "that has a soul.@"

String_0B_01_2D::
    db "Made of wood that<LINE>"
    db "is 1000 years old.@"

String_0B_01_2E::
    db "One of its spikes<LINE>"
    db "sets off a bomb.@"

String_0B_01_2F::
    db "Traps foes within<LINE>"
    db "its reflection.@"

String_0B_01_30::
    db "Doomed to wander<LINE>"
    db "and roam forever.@"

String_0B_01_31::
    db "Controls itself<LINE>"
    db "with strings.@"

String_0B_01_32::
    db "Drags foes into<LINE>"
    db "mud with others.@"

String_0B_01_33::
    db "Emerged from 10000<LINE>"
    db "years of sleep.@"

String_0B_01_34::
    db "A fully mechanical<LINE>"
    db "dragon.@"

String_0B_01_35::
    db "Slow, so it relies<LINE>"
    db "on power smashes.@"

String_0B_01_36::
    db "Tears meat with<LINE>"
    db "its head and eats.@"

String_0B_01_37::
    db "Blows confusing<LINE>"
    db "smoke when buffed.@"

String_0B_01_38::
    db "Brushes foes until<LINE>"
    db "they turn all red.@"

String_0B_01_39::
    db "Battles until it<LINE>"
    db "is fully wrecked.@"

String_0B_01_3A::
    db "Battles savagely<LINE>"
    db "without mercy.@"

String_0B_01_3B::
    db "Bites whoever<LINE>"
    db "peers inside.@"

String_0B_01_3C::
    db "Descends from the<LINE>"
    db "sky to seek prey.@"

String_0B_01_3D::
    db "A giant that caked<LINE>"
    db "itself with magma.@"

String_0B_01_3E::
    db "A giant that caked<LINE>"
    db "itself with ice.@"

String_0B_01_3F::
    db "It bites unwary<LINE>"
    db "treasure hunters.@"

String_0B_01_40::
    db "Like-minded plates<LINE>"
    db "became a monster.@"

String_0B_01_41::
    db "Its body dries if<LINE>"
    db "it stops dancing.@"

String_0B_01_42::
    db "Its body cracks if<LINE>"
    db "it tries to talk.@"

String_0B_01_43::
    db "Its body breaks if<LINE>"
    db "it stops moving.@"

String_0B_01_44::
    db "Explodes without<LINE>"
    db "warning on waking.@"

String_0B_01_45::
    db "Proud of its big,<LINE>"
    db "golden body.@"

String_0B_01_46::
    db "Makes foes dizzy<LINE>"
    db "by rotating.@"

String_0B_01_47::
    db "Roboster's proto-<LINE>"
    db "type, but tough.@"

String_0B_01_48::
    db "A judge among<LINE>"
    db "monsters.@"

String_0B_01_49::
    db "Small, slippery<LINE>"
    db "and hard to hit.@"

String_0B_01_4D::
    db "Immobilizes foes<LINE>"
    db "then bites them.@"

String_0B_01_4E::
    db "Sits on foes and<LINE>"
    db "pummels them.@"

String_0B_01_4F::
    db "Suffocates foes<LINE>"
    db "with its body.@"

String_0B_01_50::
    db "Snares foes with<LINE>"
    db "its tentacles.@"

String_0B_01_51::
    db "Expands its body<LINE>"
    db "to startle foes.@"

String_0B_01_52::
    db "A fish that is as<LINE>"
    db "smart as people.@"

String_0B_01_53::
    db "A monster that got<LINE>"
    db "stuck in a trap.@"

String_0B_01_54::
    db "Swarms and eats<LINE>"
    db "foes instantly.@"

String_0B_01_55::
    db "The short legs<LINE>"
    db "make it sluggish.@"

String_0B_01_56::
    db "Attracts prey with<LINE>"
    db "a lighted antenna.@"

String_0B_01_57::
    db "A demon that rides<LINE>"
    db "a fish in battle.@"

String_0B_01_58::
    db "Swims straight to<LINE>"
    db "ram at high speed.@"

String_0B_01_59::
    db "Skips through<LINE>"
    db "water like a frog.@"

String_0B_01_5A::
    db "The pincers can<LINE>"
    db "cut its own shell.@"

String_0B_01_5B::
    db "The pincers are<LINE>"
    db "sharp, but heavy.@"

String_0B_01_5C::
    db "Drowns foes inside<LINE>"
    db "its turbid body.@"

String_0B_01_5D::
    db "Its shell is<LINE>"
    db "tough to open.@"

String_0B_01_5E::
    db "Remains upright<LINE>"
    db "even when asleep.@"

String_0B_01_5F::
    db "Hides its ugly<LINE>"
    db "body in a hood.@"

String_0B_01_60::
    db "Rampages in the<LINE>"
    db "sea with swords.@"

String_0B_01_61::
    db "Cleaves foes in<LINE>"
    db "two with its ax.@"

String_0B_01_62::
    db "Rarely seen as it<LINE>"
    db "hides in depths.@"

String_0B_01_63::
    db "Spits a huge cloud<LINE>"
    db "of obscuring ink.@"

String_0B_01_64::
    db "Drifts along with<LINE>"
    db "deep-sea currents.@"

String_0B_01_65::
    db "Its wand indicates<LINE>"
    db "magical power.@"

String_0B_01_66::
    db "Rare. It lurks<LINE>"
    db "only in deep seas.@"

String_0B_01_67::
    db "Uses tentacles to<LINE>"
    db "immobilize foes.@"

String_0B_01_68::
    db "The fin on its<LINE>"
    db "back is a weapon.@"

String_0B_01_69::
    db "Its thrashing can<LINE>"
    db "cause earthquakes.@"

String_0B_01_6A::
    db "Floats vacantly in<LINE>"
    db "the sea at peace.@"

String_0B_01_6B::
    db "Small, but capable<LINE>"
    db "of stretching.@"

String_0B_01_6C::
    db "DracoLord's first,<LINE>"
    db "unassuming form.@"

String_0B_01_70::
    db "DracoLord's true,<LINE>"
    db "powerful identity.@"

String_0B_01_71::
    db "DracoLord's form<LINE>"
    db "when enraged.@"

String_0B_01_72::
    db "An evil cleric who<LINE>"
    db "can use any spell.@"

String_0B_01_73::
    db "A being dedicated<LINE>"
    db "to world chaos.@"

String_0B_01_74::
    db "Sidoh reborn for <LINE>"
    db "total destruction.@"

String_0B_01_75::
    db "Lords over all<LINE>"
    db "demons with power.@"

String_0B_01_76::
    db "A Demon Lord that<LINE>"
    db "uses dark powers.@"

String_0B_01_77::
    db "The true, final<LINE>"
    db "form of Zoma.@"

String_0B_01_78::
    db "A being that seeks<LINE>"
    db "ultimate power.@"

String_0B_01_79::
    db "Pizzaro's pure and<LINE>"
    db "real guise.@"

String_0B_01_7A::
    db "Dedicated to chaos<LINE>"
    db "and domination.@"

String_0B_01_7B::
    db "Purely evil and<LINE>"
    db "divinely powerful.@"

String_0B_01_7C::
    db "The true, vile<LINE>"
    db "form of Mirudraas.@"

String_0B_01_7D::
    db "A Demon Lord that<LINE>"
    db "uses illusions.@"

String_0B_01_7E::
    db "The Demon Lord of<LINE>"
    db "all worlds.@"

String_0B_01_7F::
    db "The true, enraged<LINE>"
    db "form of DeathMore.@"

String_0B_01_80::
    db "DeathMore's final<LINE>"
    db "evolution.@"

String_0B_01_81::
    db "A being that<LINE>"
    db "dreams of death.@"

String_0B_01_82::
    db "Its elegance<LINE>"
    db "belies its greed.@"

String_0B_01_83::
    db "Its form strikes<LINE>"
    db "terror in all.@"

String_0B_01_84::
    db "The collector king<LINE>"
    db "of Limbo.@"

String_0B_02_00::
    db "Slime@"

String_0B_02_01::
    db "Dragon@"

String_0B_02_02::
    db "Beast@"

String_0B_02_03::
    db "Bird@"

String_0B_02_04::
    db "Plant@"

String_0B_02_05::
    db "Bug@"

String_0B_02_06::
    db "Demon@"

String_0B_02_07::
    db "Zombie@"

String_0B_02_08::
    db "Material@"

String_0B_02_09::
    db "Water@"

String_0B_02_0A::
    db "????@"
    ds $12cc, $00
