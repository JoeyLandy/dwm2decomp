SECTION "Bank 2F", ROMX[$4000], BANK[$2F]
    db $2F

; ld de, this bank's string table / BeginStringDisplay
; 31 call sites from 31 routines (e.g. ShowString_Bank2F, DebugMessageTest_Update_Case0F, ShowStringCategory5_Bank16, BattlePhase0_Step2_Case03, ...)
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
    dw Data_02F_4384 ; id 0
    dw Data_02F_4393 ; id 1
    dw Data_02F_43A7 ; id 2
    dw Data_02F_43BB ; id 3
    dw Data_02F_43CF ; id 4
    dw Data_02F_43E3 ; id 5
    dw Data_02F_43F7 ; id 6
    dw Data_02F_4412 ; id 7
    dw Data_02F_442F ; id 8
    dw Data_02F_4444 ; id 9
    dw Data_02F_4463 ; id 10
    dw Data_02F_4482 ; id 11
    dw Data_02F_4496 ; id 12
    dw Data_02F_44AD ; id 13
    dw Data_02F_44C5 ; id 14
    dw Data_02F_44E2 ; id 15
    dw Data_02F_4502 ; id 16
    dw Data_02F_4522 ; id 17
    dw Data_02F_4542 ; id 18
    dw Data_02F_4568 ; id 19
    dw Data_02F_4578 ; id 20
    dw Data_02F_458A ; id 21
    dw Data_02F_45A2 ; id 22
    dw Data_02F_45B8 ; id 23
    dw Data_02F_45CB ; id 24
    dw Data_02F_45E2 ; id 25
    dw Data_02F_45F5 ; id 26
    dw Data_02F_460C ; id 27
    dw Data_02F_4626 ; id 28
    dw Data_02F_4642 ; id 29
    dw Data_02F_4665 ; id 30
    dw Data_02F_4689 ; id 31
    dw Data_02F_46A6 ; id 32
    dw Data_02F_46C5 ; id 33
    dw Data_02F_46E0 ; id 34
    dw Data_02F_46F5 ; id 35
    dw Data_02F_4713 ; id 36
    dw Data_02F_4732 ; id 37
    dw Data_02F_4757 ; id 38
    dw Data_02F_4769 ; id 39
    dw Data_02F_4777 ; id 40
    dw Data_02F_478C ; id 41
    dw Data_02F_47AE ; id 42
    dw Data_02F_47C2 ; id 43
    dw Data_02F_47DA ; id 44
    dw Data_02F_47FE ; id 45
    dw Data_02F_481E ; id 46
    dw Data_02F_4839 ; id 47
    dw Data_02F_4856 ; id 48
    dw Data_02F_4869 ; id 49
    dw Data_02F_4884 ; id 50
    dw Data_02F_489F ; id 51
    dw Data_02F_48B6 ; id 52
    dw Data_02F_48CD ; id 53
    dw Data_02F_48E9 ; id 54
    dw Data_02F_4915 ; id 55
    dw Data_02F_4941 ; id 56
    dw Data_02F_4973 ; id 57
    dw Data_02F_49AA ; id 58
    dw Data_02F_49E5 ; id 59
    dw Data_02F_4A20 ; id 60
    dw Data_02F_4A5C ; id 61
    dw Data_02F_4A96 ; id 62
    dw Data_02F_4ACE ; id 63
    dw Data_02F_4AFC ; id 64
    dw Data_02F_4B2E ; id 65
    dw Data_02F_4B6A ; id 66
    dw Data_02F_4BA4 ; id 67
    dw Data_02F_4BDB ; id 68
    dw Data_02F_4C14 ; id 69
    dw Data_02F_4C46 ; id 70
    dw Data_02F_4C7A ; id 71
    dw Data_02F_4CAE ; id 72
    dw Data_02F_4CE6 ; id 73
    dw Data_02F_4D11 ; id 74
    dw Data_02F_4D49 ; id 75
    dw Data_02F_4D79 ; id 76
    dw Data_02F_4DA6 ; id 77
    dw Data_02F_4DD4 ; id 78
    dw Data_02F_4E0A ; id 79
    dw Data_02F_4E38 ; id 80
    dw Data_02F_4E6F ; id 81
    dw Data_02F_4EAD ; id 82
    dw Data_02F_4EEB ; id 83
    dw Data_02F_4F27 ; id 84
    dw Data_02F_4F66 ; id 85
    dw Data_02F_4FA0 ; id 86
    dw Data_02F_4FD5 ; id 87
    dw Data_02F_5010 ; id 88
    dw Data_02F_5041 ; id 89
    dw Data_02F_5080 ; id 90
    dw Data_02F_50BB ; id 91
    dw Data_02F_50F0 ; id 92
    dw Data_02F_512D ; id 93
    dw Data_02F_5169 ; id 94
    dw Data_02F_519E ; id 95
    dw Data_02F_51D6 ; id 96
    dw Data_02F_51F0 ; id 97
    dw Data_02F_5202 ; id 98
    dw Data_02F_5225 ; id 99
    dw Data_02F_524D ; id 100
    dw Data_02F_5277 ; id 101
    dw Data_02F_5296 ; id 102
    dw Data_02F_52CA ; id 103
    dw Data_02F_52FC ; id 104
    dw Data_02F_532D ; id 105
    dw Data_02F_5361 ; id 106
    dw Data_02F_5393 ; id 107
    dw Data_02F_53C4 ; id 108
    dw Data_02F_5408 ; id 109
    dw Data_02F_5453 ; id 110
    dw Data_02F_54A2 ; id 111
    dw Data_02F_54F0 ; id 112
    dw Data_02F_5534 ; id 113
    dw Data_02F_557F ; id 114
    dw Data_02F_55CF ; id 115
    dw Data_02F_5622 ; id 116
    dw Data_02F_5671 ; id 117
    dw Data_02F_56BD ; id 118
    dw Data_02F_5709 ; id 119
    dw Data_02F_5758 ; id 120
    dw Data_02F_57A4 ; id 121
    dw Data_02F_57F3 ; id 122
    dw Data_02F_583D ; id 123
    dw Data_02F_5859 ; id 124
    dw Data_02F_587A ; id 125
    dw Data_02F_5892 ; id 126
    dw Data_02F_58A7 ; id 127
    dw Data_02F_58C8 ; id 128
    dw Data_02F_590E ; id 129
    dw Data_02F_5958 ; id 130
    dw Data_02F_599F ; id 131
    dw Data_02F_59EC ; id 132
    dw Data_02F_5A35 ; id 133
    dw Data_02F_5A82 ; id 134
    dw Data_02F_5A9C ; id 135
    dw Data_02F_5AB8 ; id 136

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_4134::
Data_02F_4134:: ; address name
    dw Data_02F_5AC9 ; id 0
    dw Data_02F_5AD8 ; id 1
    dw Data_02F_5AE6 ; id 2
    dw Data_02F_5AF6 ; id 3
    dw Data_02F_5B04 ; id 4
    dw Data_02F_5B18 ; id 5
    dw Data_02F_5B2B ; id 6
    dw Data_02F_5B41 ; id 7
    dw Data_02F_5B55 ; id 8
    dw Data_02F_5B6F ; id 9
    dw Data_02F_5B80 ; id 10
    dw Data_02F_5B94 ; id 11
    dw Data_02F_5BA5 ; id 12
    dw Data_02F_5BB6 ; id 13
    dw Data_02F_5BD0 ; id 14
    dw Data_02F_5BE5 ; id 15
    dw Data_02F_5C19 ; id 16
    dw Data_02F_5C2F ; id 17
    dw Data_02F_5C45 ; id 18
    dw Data_02F_5C58 ; id 19
    dw Data_02F_5C73 ; id 20
    dw Data_02F_5C89 ; id 21
    dw Data_02F_5CA8 ; id 22
    dw Data_02F_5CC6 ; id 23
    dw Data_02F_5CE1 ; id 24
    dw Data_02F_5D1E ; id 25
    dw Data_02F_5D5B ; id 26
    dw Data_02F_5D99 ; id 27
    dw Data_02F_5DAF ; id 28
    dw Data_02F_5DCB ; id 29
    dw Data_02F_5DE7 ; id 30
    dw Data_02F_5E10 ; id 31
    dw Data_02F_5E26 ; id 32
    dw Data_02F_5E3A ; id 33
    dw Data_02F_5E54 ; id 34
    dw Data_02F_5E6F ; id 35
    dw Data_02F_5E89 ; id 36
    dw Data_02F_5E9D ; id 37
    dw Data_02F_5EAE ; id 38
    dw Data_02F_5EDB ; id 39
    dw Data_02F_5EEF ; id 40
    dw Data_02F_5F01 ; id 41
    dw Data_02F_5F1E ; id 42
    dw Data_02F_5F37 ; id 43
    dw Data_02F_5F48 ; id 44
    dw Data_02F_5F63 ; id 45
    dw Data_02F_5F7B ; id 46
    dw Data_02F_5F98 ; id 47
    dw Data_02F_5FB0 ; id 48
    dw Data_02F_5FCB ; id 49
    dw Data_02F_5FE7 ; id 50
    dw Data_02F_6023 ; id 51
    dw Data_02F_6034 ; id 52
    dw Data_02F_6054 ; id 53
    dw Data_02F_6069 ; id 54
    dw Data_02F_607E ; id 55
    dw Data_02F_6096 ; id 56
    dw Data_02F_60AB ; id 57
    dw Data_02F_60C1 ; id 58
    dw Data_02F_60D7 ; id 59
    dw Data_02F_60F1 ; id 60
    dw Data_02F_610B ; id 61
    dw Data_02F_6126 ; id 62
    dw Data_02F_6141 ; id 63
    dw Data_02F_6157 ; id 64
    dw Data_02F_6168 ; id 65
    dw Data_02F_617F ; id 66
    dw Data_02F_6195 ; id 67
    dw Data_02F_61A8 ; id 68
    dw Data_02F_61C3 ; id 69
    dw Data_02F_61D9 ; id 70
    dw Data_02F_61F7 ; id 71
    dw Data_02F_620E ; id 72
    dw Data_02F_6227 ; id 73
    dw Data_02F_623D ; id 74
    dw Data_02F_6255 ; id 75
    dw Data_02F_627C ; id 76
    dw Data_02F_62A3 ; id 77
    dw Data_02F_62C2 ; id 78
    dw Data_02F_62DC ; id 79
    dw Data_02F_62F9 ; id 80
    dw Data_02F_6311 ; id 81
    dw Data_02F_6324 ; id 82
    dw Data_02F_633B ; id 83
    dw Data_02F_6362 ; id 84
    dw Data_02F_637C ; id 85
    dw Data_02F_6395 ; id 86
    dw Data_02F_63B1 ; id 87
    dw Data_02F_63C1 ; id 88
    dw Data_02F_63DA ; id 89
    dw Data_02F_63EE ; id 90
    dw Data_02F_6404 ; id 91
    dw Data_02F_6434 ; id 92
    dw Data_02F_6446 ; id 93
    dw Data_02F_6456 ; id 94
    dw Data_02F_6473 ; id 95
    dw Data_02F_648F ; id 96
    dw Data_02F_64A5 ; id 97
    dw Data_02F_64BD ; id 98
    dw Data_02F_64D6 ; id 99
    dw Data_02F_64EF ; id 100
    dw Data_02F_6507 ; id 101
    dw Data_02F_651F ; id 102
    dw Data_02F_6537 ; id 103
    dw Data_02F_6557 ; id 104
    dw Data_02F_6574 ; id 105
    dw Data_02F_6591 ; id 106
    dw Data_02F_65A9 ; id 107
    dw Data_02F_65C8 ; id 108
    dw Data_02F_65E1 ; id 109
    dw Data_02F_65FF ; id 110
    dw Data_02F_661F ; id 111
    dw Data_02F_6634 ; id 112
    dw Data_02F_664E ; id 113
    dw Data_02F_6661 ; id 114
    dw Data_02F_6683 ; id 115
    dw Data_02F_669A ; id 116
    dw Data_02F_66AC ; id 117
    dw Data_02F_66BF ; id 118
    dw Data_02F_66D6 ; id 119
    dw Data_02F_66F2 ; id 120
    dw Data_02F_6704 ; id 121
    dw Data_02F_671E ; id 122
    dw Data_02F_6730 ; id 123
    dw Data_02F_674A ; id 124
    dw Data_02F_675F ; id 125
    dw Data_02F_6777 ; id 126
    dw Data_02F_678A ; id 127
    dw Data_02F_679A ; id 128
    dw Data_02F_67B5 ; id 129
    dw Data_02F_67CB ; id 130
    dw Data_02F_67D9 ; id 131
    dw Data_02F_67F8 ; id 132
    dw Data_02F_6810 ; id 133
    dw Data_02F_682B ; id 134
    dw Data_02F_684B ; id 135
    dw Data_02F_685F ; id 136
    dw Data_02F_6889 ; id 137
    dw Data_02F_68B4 ; id 138
    dw Data_02F_68C0 ; id 139
    dw Data_02F_68D3 ; id 140
    dw Data_02F_68EB ; id 141
    dw Data_02F_68FE ; id 142
    dw Data_02F_6918 ; id 143
    dw Data_02F_692C ; id 144
    dw Data_02F_693F ; id 145
    dw Data_02F_695D ; id 146
    dw Data_02F_6974 ; id 147
    dw Data_02F_6992 ; id 148
    dw Data_02F_69AF ; id 149
    dw Data_02F_69E0 ; id 150
    dw Data_02F_6A10 ; id 151
    dw Data_02F_6A28 ; id 152
    dw Data_02F_6A4B ; id 153
    dw Data_02F_6A67 ; id 154
    dw Data_02F_6A87 ; id 155
    dw Data_02F_6A9B ; id 156
    dw Data_02F_6AAC ; id 157
    dw Data_02F_6ABD ; id 158
    dw Data_02F_6AEC ; id 159
    dw Data_02F_6AFE ; id 160
    dw Data_02F_6B1B ; id 161
    dw Data_02F_6B39 ; id 162
    dw Data_02F_6B56 ; id 163
    dw Data_02F_6B8F ; id 164
    dw Data_02F_6BC7 ; id 165
    dw Data_02F_6BFB ; id 166
    dw Data_02F_6C34 ; id 167
    dw Data_02F_6C69 ; id 168
    dw Data_02F_6C89 ; id 169
    dw Data_02F_6CA3 ; id 170
    dw Data_02F_6CCB ; id 171
    dw Data_02F_6CF8 ; id 172
    dw Data_02F_6D1E ; id 173
    dw Data_02F_6D4A ; id 174
    dw Data_02F_6D76 ; id 175
    dw Data_02F_6D8A ; id 176
    dw Data_02F_6D9E ; id 177
    dw Data_02F_6DB1 ; id 178
    dw Data_02F_6DD8 ; id 179
    dw Data_02F_6DF5 ; id 180
    dw Data_02F_6E1A ; id 181
    dw Data_02F_6E33 ; id 182
    dw Data_02F_6E6E ; id 183
    dw Data_02F_6E87 ; id 184
    dw Data_02F_6EB8 ; id 185
    dw Data_02F_6ECF ; id 186
    dw Data_02F_6F03 ; id 187
    dw Data_02F_6F17 ; id 188
    dw Data_02F_6F34 ; id 189
    dw Data_02F_6F50 ; id 190
    dw Data_02F_6F68 ; id 191
    dw Data_02F_6F7E ; id 192
    dw Data_02F_6FBB ; id 193
    dw Data_02F_6FED ; id 194
    dw Data_02F_700C ; id 195
    dw Data_02F_7023 ; id 196
    dw Data_02F_7046 ; id 197
    dw Data_02F_706D ; id 198
    dw Data_02F_7094 ; id 199
    dw Data_02F_70C0 ; id 200
    dw Data_02F_70D9 ; id 201
    dw Data_02F_70F6 ; id 202
    dw Data_02F_7107 ; id 203
    dw Data_02F_7120 ; id 204
    dw Data_02F_7138 ; id 205
    dw Data_02F_714E ; id 206
    dw Data_02F_7166 ; id 207
    dw Data_02F_7181 ; id 208
    dw Data_02F_719A ; id 209
    dw Data_02F_71B5 ; id 210
    dw Data_02F_71D0 ; id 211
    dw Data_02F_71E9 ; id 212
    dw Data_02F_7201 ; id 213
    dw Data_02F_721D ; id 214
    dw Data_02F_7233 ; id 215
    dw Data_02F_724E ; id 216
    dw Data_02F_725A ; id 217
    dw Data_02F_726B ; id 218
    dw Data_02F_7283 ; id 219
    dw Data_02F_72A0 ; id 220
    dw Data_02F_72C9 ; id 221
    dw Data_02F_72E2 ; id 222
    dw Data_02F_72FB ; id 223
    dw Data_02F_730D ; id 224
    dw Data_02F_7329 ; id 225
    dw Data_02F_7342 ; id 226
    dw Data_02F_735B ; id 227
    dw Data_02F_7377 ; id 228
    dw Data_02F_7392 ; id 229
    dw Data_02F_73A9 ; id 230
    dw Data_02F_73CA ; id 231
    dw Data_02F_73E5 ; id 232
    dw Data_02F_7400 ; id 233
    dw Data_02F_741D ; id 234
    dw Data_02F_743A ; id 235
    dw Data_02F_7466 ; id 236
    dw Data_02F_74A3 ; id 237
    dw Data_02F_74EB ; id 238
    dw Data_02F_752D ; id 239
    dw Data_02F_7574 ; id 240
    dw Data_02F_75A9 ; id 241
    dw Data_02F_75DA ; id 242
    dw Data_02F_7607 ; id 243
    dw Data_02F_763A ; id 244
    dw Data_02F_768F ; id 245
    dw Data_02F_76C1 ; id 246
    dw Data_02F_76F0 ; id 247
    dw Data_02F_7719 ; id 248
    dw Data_02F_7752 ; id 249
    dw Data_02F_7781 ; id 250
    dw Data_02F_77B0 ; id 251
    dw Data_02F_77C1 ; id 252
    dw Data_02F_77D2 ; id 253
    dw Data_02F_7818 ; id 254
    dw Data_02F_7854 ; id 255

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_4334::
Data_02F_4334:: ; address name
    dw Data_02F_7877 ; id 0
    dw Data_02F_787D ; id 1
    dw Data_02F_7882 ; id 2
    dw Data_02F_7888 ; id 3

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_433C::
Data_02F_433C:: ; address name
    dw Data_02F_788D ; id 0

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_433E::
Data_02F_433E:: ; address name
    dw Data_02F_788D ; id 0

; E-0217 (derived: category list of StringCategories_2F_4016; one pointer per wStringIndex)
; record: string
StringList_2F_4340::
Data_02F_4340:: ; address name
    dw Data_02F_7897 ; id 0
    dw Data_02F_78B7 ; id 1
    dw Data_02F_7942 ; id 2
    dw Data_02F_7942 ; id 3
    dw Data_02F_795E ; id 4
    dw Data_02F_7973 ; id 5
    dw Data_02F_79A1 ; id 6
    dw Data_02F_79E7 ; id 7
    dw Data_02F_7A0B ; id 8
    dw Data_02F_7A25 ; id 9
    dw Data_02F_7A3B ; id 10
    dw Data_02F_7A63 ; id 11
    dw Data_02F_7A9A ; id 12
    dw Data_02F_7AB0 ; id 13
    dw Data_02F_7AEF ; id 14
    dw Data_02F_7B07 ; id 15
    dw Data_02F_7B1C ; id 16
    dw Data_02F_7B40 ; id 17
    dw Data_02F_7B5E ; id 18
    dw Data_02F_7B7A ; id 19
    dw Data_02F_7B9A ; id 20
    dw Data_02F_7BAD ; id 21
    dw Data_02F_7BCB ; id 22
    dw Data_02F_7BE6 ; id 23
    dw Data_02F_7BF8 ; id 24
    dw Data_02F_7C12 ; id 25
    dw Data_02F_7C2E ; id 26
    dw Data_02F_7C51 ; id 27
    dw Data_02F_7C6B ; id 28
    dw Data_02F_7C8D ; id 29
    dw Data_02F_7CA8 ; id 30
    dw Data_02F_7CE2 ; id 31
    dw Data_02F_7CF3 ; id 32
    dw Data_02F_7D11 ; id 33

Data_02F_4384:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 appears!", $F1
    db $EC, $F0

Data_02F_4393:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters appear!", $F1
    db $EC, $F0

Data_02F_43A7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters appear!", $F1
    db $EC, $F0

Data_02F_43BB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters appear!", $F1
    db $EC, $F0

Data_02F_43CF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters appear!", $F1
    db $EC, $F0

Data_02F_43E3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters appear!", $F1
    db $EC, $F0

Data_02F_43F7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F6, "'s party was", $F1
    db "wiped out!", $E5, $42, $F0

Data_02F_4412:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters were", $F1
    db "defeated!", $E4, $7E, $FA, $F7
    db $F0

Data_02F_442F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 left", $F1
    db "the scene.", $EC, $F0

Data_02F_4444:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The monsters left", $F1
    db "the scene.", $EC, $F0

Data_02F_4463:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The monsters left", $F1
    db "the scene.", $EC, $F0

Data_02F_4482:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "couldn't react!", $EC, $F0

Data_02F_4496:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "appeared stunned!", $EC, $F0

Data_02F_44AD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "suddenly attacked!", $EC, $F0

Data_02F_44C5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "without warning!", $EC, $F0

Data_02F_44E2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 can't", $F1
    db "move!", $EC, $F0

Data_02F_4502:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GHP!", $EC, $F0

Data_02F_4522:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GMP!", $EC, $F0

Data_02F_4542:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cursed!", $EC, $F2, $ED, $F9, "0 became", $F1
    db "confused!", $EC, $F0

Data_02F_4568:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "asleep.", $EC, $F0

Data_02F_4578:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "confused!", $EC, $F0

Data_02F_458A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is a", $F1
    db "hunk of iron!", $EC, $F0

Data_02F_45A2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "frozen solid!", $EC, $F0

Data_02F_45B8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "paralyzed!", $EC, $F0

Data_02F_45CB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "dancing along!", $EC, $F0

Data_02F_45E2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "shivering!", $EC, $F0

Data_02F_45F5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "get back up!", $EC, $F0

Data_02F_460C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "cowering in fear!", $EC, $F0

Data_02F_4626:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "vacant and lost!", $EC, $F0

Data_02F_4642:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No items allowed", $F1
    db "in this battle!", $F7
    db $F0

Data_02F_4665:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "This item can't be", $F1
    db "used in battle!", $F7
    db $F0

Data_02F_4689:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "There are no", $F1
    db "usable items!", $F7
    db $F0

Data_02F_46A6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No fleeing from", $F1
    db "this battle!", $F7
    db $F0

Data_02F_46C5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Can't use that", $F1
    db "skill now!", $F7
    db $F0

Data_02F_46E0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Selecting", $F1
    db $F9, "0's move", $A4, $F0

Data_02F_46F5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No monsters to", $F1
    db "access PLAN.", $F7
    db $F0

Data_02F_4713:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "There is no target", $F1
    db "in sight!", $F7
    db $F0

Data_02F_4732:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "That skill can't", $F1
    db "be used in battle!", $F7
    db $F0

Data_02F_4757:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Not enough MP!", $F1
    db $F7
    db $F0

Data_02F_4769:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Retire now?", $F1
    db $F0

Data_02F_4777:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ignored", $F1
    db "orders!", $EC, $F0

Data_02F_478C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "It has no usable", $F1
    db "battle skills!", $EC, $F0

Data_02F_47AE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "not recruited!", $EC, $F0

Data_02F_47C2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "already recruited.", $EC, $F0

Data_02F_47DA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But the escape", $F1
    db "route was cut off!", $EC, $F0

Data_02F_47FE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But there's no one", $F1
    db "to command!", $F7
    db $F0

Data_02F_481E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "at full power!", $EC, $F0

Data_02F_4839:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tucked", $F1
    db "tighter in fear!", $EC, $F0

Data_02F_4856:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "concentrated!", $EC, $F0

Data_02F_4869:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "back, enraged.", $EC, $F0

Data_02F_4884:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Light fell softly", $F1
    db "on ", $F9, "0!", $EC, $F0

Data_02F_489F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ducked", $F1
    db "behind ", $F9, "G!", $EC, $F0

Data_02F_48B6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 pumped", $F1
    db "itself up!", $EC, $F0

Data_02F_48CD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 rolled", $F1
    db "out of the way!", $EC, $F0

Data_02F_48E9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4915:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4941:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4973:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to jump high!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_49AA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to call for help!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_49E5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to yell for help!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4A20:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to pump itself up!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4A5C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to cast a curse!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4A96:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to inhale all!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4ACE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quiets", $F1
    db $F9, "W!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4AFC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to sing!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4B2E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to make a barrier!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4B6A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the heavens!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4BA4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "for silence!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4BDB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to shoot water!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4C14:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 called", $F1
    db "for ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4C46:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to use ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4C7A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "waking ", $F9, "G!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4CAE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "ready to inhale!", $EC, $F2, $ED, "But there weren't", $F1
    db "enough MP!", $EC, $F0

Data_02F_4CE6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But its spells", $F1
    db "are sealed!", $EC, $F0

Data_02F_4D11:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "blowing ", $F9, "G!", $EC, $F2, $ED, "But its mouth is", $F1
    db "sealed tight!", $EC, $F0

Data_02F_4D49:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F2, $ED, "But it can't do", $F1
    db "the dance!", $EC, $F0

Data_02F_4D79:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_4DA6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F2, $ED, "But it is sealed", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4DD4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to use ", $F9, "G!", $EC, $F2, $ED, "But it is sealed", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4E0A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db $F9, "G!", $EC, $F2, $ED, "But it is sealed", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4E38:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "waking ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4E6F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to call for help!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4EAD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to yell for help!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4EEB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to build power!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4F27:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to pump itself up!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4F66:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to jump high!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4FA0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_4FD5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "ready to inhale!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_5010:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quiets", $F1
    db $F9, "W!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_5041:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to make a barrier!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_5080:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to inhale all!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_50BB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to sing!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_50F0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the heavens!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_512D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "to shoot water!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_5169:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 called", $F1
    db "for ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_519E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tried", $F1
    db "blowing ", $F9, "G!", $EC, $F2, $ED, "But it is stopped", $F1
    db "by a prayer!", $EC, $F0

Data_02F_51D6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You threw in", $F1
    db "the towel!", $EC, $F0

Data_02F_51F0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turns left!", $F1
    db $EC, $F0

Data_02F_5202:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "No turns left.", $F1
    db "This ends a draw.", $EC, $F0

Data_02F_5225:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You broke a battle", $F1
    db "rule!", $FA, $F7
    db $F2, "You lose.", $FA, $F7
    db $F0

Data_02F_524D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Your opponent", $F1
    db "broke a rule!", $FA, $F7
    db $F2, "You win.", $FA, $F7
    db $F0

Data_02F_5277:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "That skill isn't", $F1
    db "for own use!", $EC, $F0

Data_02F_5296:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "casting a spell!", $F1
    db "But it failed!", $EC, $F0

Data_02F_52CA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a skill!", $F1
    db "But it failed!", $EC, $F0

Data_02F_52FC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to use magic!", $F1
    db "But it failed!", $EC, $F0

Data_02F_532D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "casting a spell!", $F1
    db "Not enough MP!", $EC, $F0

Data_02F_5361:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a skill!", $F1
    db "Not enough MP!", $EC, $F0

Data_02F_5393:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to use magic!", $F1
    db "Not enough MP!", $EC, $F0

Data_02F_53C4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Thordain into", $F1
    db "Alldain!", $EC, $F2, $ED, "But spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_5408:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Thordain into", $F1
    db "Alldain!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_5453:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Blazemost and", $F1
    db "Blizzard into", $EC, $F2, $ED, "Blitzer!", $F1
    db "But it was sealed!", $EC, $F0

Data_02F_54A2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Blazemost and", $F1
    db "Blizzard into", $EC, $F2, $ED, "Blitzer!", $F1
    db "But it shattered!", $EC, $F0

Data_02F_54F0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Sacrifice into", $F1
    db "Martyr!", $EC, $F2, $ED, "But spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_5534:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Sacrifice into", $F1
    db "Martyr!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_557F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G let", $EC, $F2, $ED, "loose their entire", $F1
    db "magical power!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_55CF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G let", $EC, $F2, $ED, "loose their entire", $F1
    db "magical power!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_5622:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon a spirit!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

Data_02F_5671:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon death!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

Data_02F_56BD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to turn into a", $F1
    db "huge dragon!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_5709:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "to turn into a", $F1
    db "huge dragon!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_5758:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, $ED, "a vacuum for", $F1
    db "stealing MP!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_57A4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, $ED, "a vacuum for", $F1
    db "stealing MP!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_57F3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

Data_02F_583D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "eat while asleep!", $EC, $F0

Data_02F_5859:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "eat while", $EC, $F2, $ED, "paralyzed!", $EC, $F0

Data_02F_587A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is a", $F1
    db "hunk of iron!", $EC, $F0

Data_02F_5892:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 brushed", $F1
    db "off ", $F9, "W!", $EC, $F0

Data_02F_58A7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But there is no", $F1
    db "one to betray!", $F7
    db $F0

Data_02F_58C8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a linked", $F1
    db "skill!", $EC, $F2, $ED, "But the skill was", $F1
    db "sealed!", $EC, $F0

Data_02F_590E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced ", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F2, $ED, "But the spell was", $F1
    db "sealed!", $EC, $F0

Data_02F_5958:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a linked", $F1
    db "skill!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

Data_02F_599F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, $ED, "a vacuum for", $F1
    db "stealing MP!", $EC, $F2, $ED, "But the dance was", $F1
    db "stopped!", $EC, $F0

Data_02F_59EC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tried", $EC, $F2, $ED, "using a linked", $F1
    db "skill!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_5A35:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced ", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F2, $ED, "But the spell was", $F1
    db "shattered!", $EC, $F0

Data_02F_5A82:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Monster was", $F1
    db "defeated!", $E4, $7E, $FA, $F7
    db $F0

Data_02F_5A9C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's party", $F1
    db "was wiped out!", $E5, $42, $F0

Data_02F_5AB8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turn left!", $F1
    db $EC, $F0

Data_02F_5AC9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "attacked!", $EC, $F0

Data_02F_5AD8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 cast", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5AE6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 loosed", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5AF6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5B04:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 danced", $F1
    db "the ", $F9, "G!", $EC, $F0

Data_02F_5B18:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G shot", $F1
    db "from ", $F9, "0!", $EC, $F0

Data_02F_5B2B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 closed", $F1
    db "in on ", $F9, "G!", $EC, $F0

Data_02F_5B41:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 charged", $F1
    db "at ", $F9, "G!", $EC, $F0

Data_02F_5B55:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 charged", $F1
    db "receklessly!", $EC, $F0

Data_02F_5B6F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dove at", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5B80:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 flailed", $F1
    db "at ", $F9, "G!", $EC, $F0

Data_02F_5B94:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 smashed", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5BA5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 leapt", $F1
    db "high!", $EC, $F0

Data_02F_5BB6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "out of the sky!", $EC, $F0

Data_02F_5BD0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 inhaled", $F1
    db "deeply!", $EC, $F0

Data_02F_5BE5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G prayed", $F1
    db "to the wind!", $EC, $F2, $ED, "Blades of air", $F1
    db "slash out!", $EC, $F0

Data_02F_5C19:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 yelled", $F1
    db "for help!", $EC, $F0

Data_02F_5C2F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 called", $F1
    db "for help!", $EC, $F0

Data_02F_5C45:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "concentrated!", $EC, $F0

Data_02F_5C58:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "like the wind!", $EC, $F0

Data_02F_5C73:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "mightily!", $EC, $F0

Data_02F_5C89:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 whipped", $F1
    db "up vicious winds!", $EC, $F0

Data_02F_5CA8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 brought", $F1
    db "lightning forth!", $EC, $F0

Data_02F_5CC6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 hurled", $F1
    db "huge boulders!", $EC, $F0

Data_02F_5CE1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 brought", $F1
    db "on an evil light!", $EC, $F2, $ED, "Thunderbolts", $F1
    db "hammered down!", $EC, $F0

Data_02F_5D1E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 set off", $F1
    db "a BigBang!", $EC, $F2, $ED, "Wild explosions", $F1
    db "echoed repeatedly!", $EC, $F0

Data_02F_5D5B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 loosed", $F1
    db "all magic power!", $EC, $F2, $ED, "It set off a", $F1
    db "wicked explosion!", $EC, $F0

Data_02F_5D99:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 uttered", $F1
    db "a curse!", $EC, $F0

Data_02F_5DAF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 kicked", $F1
    db "up a sandstorm!", $EC, $F0

Data_02F_5DCB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 did an", $F1
    db "odd dance step!", $EC, $F0

Data_02F_5DE7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 gave a", $F1
    db "powderpuff massage", $EC, $F2, $ED, "to ", $F9, "G!", $F1
    db $EC, $F0

Data_02F_5E10:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 licked", $F1
    db $F9, "G's face!", $EC, $F0

Data_02F_5E26:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 kicked", $F1
    db $F9, "G low!", $EC, $F0

Data_02F_5E3A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G did a", $F1
    db "sweeping kick!", $EC, $F0

Data_02F_5E54:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 loosed", $F1
    db "a savage roar!", $EC, $F0

Data_02F_5E6F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the earth!", $EC, $F0

Data_02F_5E89:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 whipped", $F1
    db "up ", $F9, "G!", $EC, $F0

Data_02F_5E9D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quieted", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5EAE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 began", $F1
    db "to meditate!", $EC, $F2, $ED, $F9, "0's", $F1
    db "wounds healed!", $EC, $F0

Data_02F_5EDB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 began", $F1
    db "singing!", $EC, $F0

Data_02F_5EEF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's song", $F1
    db "ended!", $EC, $F0

Data_02F_5F01:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 raised", $F1
    db "a water barrier!", $EC, $F0

Data_02F_5F1E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "guarding itself!", $EC, $F0

Data_02F_5F37:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shields", $F1
    db $F9, "G!", $EC, $F0

Data_02F_5F48:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "braced for attack!", $EC, $F0

Data_02F_5F63:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "ready to parry!", $EC, $F0

Data_02F_5F7B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is in a", $F1
    db "defensive pose!", $EC, $F0

Data_02F_5F98:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "for payback!", $EC, $F0

Data_02F_5FB0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is set", $F1
    db "to inhale all!", $EC, $F0

Data_02F_5FCB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "to the heavens!", $EC, $F0

Data_02F_5FE7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 prayed", $F1
    db "for silence!", $EC, $F2, $ED, "An invisible force", $F1
    db "pressed down!", $EC, $F0

Data_02F_6023:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shot", $F1
    db "water!", $EC, $F0

Data_02F_6034:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 created", $F1
    db "a huge tidal wave!", $EC, $F0

Data_02F_6054:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

Data_02F_6069:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

Data_02F_607E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's wound", $F1
    db "was healed!", $EC, $F0

Data_02F_6096:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "brutalized!", $EC, $F0

Data_02F_60AB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's DEF", $F1
    db "fell by ", $F9, "G!", $EC, $F0

Data_02F_60C1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's DEF", $F1
    db "fell by ", $F9, "G!", $EC, $F0

Data_02F_60D7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "use spells now!", $EC, $F0

Data_02F_60F1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's spells", $F1
    db "were sealed!", $EC, $F0

Data_02F_610B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "stripped of ", $F9, "GMP!", $EC, $F0

Data_02F_6126:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "stripped of ", $F9, "GMP!", $EC, $F0

Data_02F_6141:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 started", $F1
    db "glowing!", $EC, $F0

Data_02F_6157:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 stole", $F1
    db $F9, "GMP!", $EC, $F0

Data_02F_6168:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "befuddled!", $EC, $F0

Data_02F_617F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "confused!", $EC, $F0

Data_02F_6195:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's ATK", $F1
    db "doubled!", $EC, $F0

Data_02F_61A8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turned", $F1
    db "into a dragon!", $EC, $F0

Data_02F_61C3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's DEF", $F1
    db "rose by ", $F9, "G!", $EC, $F0

Data_02F_61D9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's party", $F1
    db "turned into iron!", $EC, $F0

Data_02F_61F7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turned", $F1
    db "into iron!", $EC, $F0

Data_02F_620E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's AGL", $F1
    db "was cut by ", $F9, "G!", $EC, $F0

Data_02F_6227:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's AGL", $F1
    db "rose by ", $F9, "G!", $EC, $F0

Data_02F_623D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is lost", $F1
    db "in a daze!", $EC, $F0

Data_02F_6255:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A veil of light", $F1
    db "formed before", $EC, $F2, $ED, $F9, "0!", $F1
    db $EC, $F0

Data_02F_627C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A veil of light", $F1
    db "formed before", $EC, $F2, $ED, $F9, "0!", $F1
    db $EC, $F0

Data_02F_62A3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A barrier of", $F1
    db "light appeared.", $EC, $F0

Data_02F_62C2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "cured of poison.", $EC, $F0

Data_02F_62DC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is no", $F1
    db "longer paralyzed.", $EC, $F0

Data_02F_62F9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 came", $F1
    db "back to life!", $EC, $F0

Data_02F_6311:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "uncursed!", $EC, $F0

Data_02F_6324:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 assumed", $F1
    db $F9, "G's form!", $EC, $F0

Data_02F_633B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Help arrived from", $F1
    db "seemingly nowhere!", $EC, $F0

Data_02F_6362:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "blinded by sand!", $EC, $F0

Data_02F_637C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's vision", $F1
    db "was harmed!", $EC, $F0

Data_02F_6395:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "weakened to magic!", $EC, $F0

Data_02F_63B1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db $F9, "GMP!", $EC, $F0

Data_02F_63C1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined", $F1
    db "the dancing!", $EC, $F0

Data_02F_63DA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "content!", $EC, $F0

Data_02F_63EE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "goose bumps!", $EC, $F0

Data_02F_6404:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "goose bumps!", $EC, $F2, $ED, $F9, "0's DEF", $F1
    db "dropped to ", $95, "1", $95, "!", $EC, $F0

Data_02F_6434:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "shocked!", $EC, $F0

Data_02F_6446:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 wiped", $F1
    db "out!", $EC, $F0

Data_02F_6456:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "all applied magic!", $EC, $F0

Data_02F_6473:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 turned", $F1
    db "back to normal!", $EC, $F0

Data_02F_648F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "fully cured!", $EC, $F0

Data_02F_64A5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined", $F1
    db "the battle!", $EC, $F0

Data_02F_64BD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "dance anymore!", $EC, $F0

Data_02F_64D6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "dance anymore!", $EC, $F0

Data_02F_64EF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's mouth", $F1
    db "was sealed!", $EC, $F0

Data_02F_6507:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's mouth", $F1
    db "was sealed!", $EC, $F0

Data_02F_651F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is a", $F1
    db "hunk of iron!", $EC, $F0

Data_02F_6537:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 did not", $F1
    db "come back to life!", $EC, $F0

Data_02F_6557:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But it failed to", $F1
    db "reach ", $F9, "0!", $EC, $F0

Data_02F_6574:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But the call went", $F1
    db "unheard!", $EC, $F0

Data_02F_6591:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dodged", $F1
    db "the breath!", $EC, $F0

Data_02F_65A9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quickly", $F1
    db "covered its ears!", $EC, $F0

Data_02F_65C8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shook", $F1
    db "off the sand!", $EC, $F0

Data_02F_65E1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 closed", $F1
    db "its eyes in time!", $EC, $F0

Data_02F_65FF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 quickly", $F1
    db "dodged the attack!", $EC, $F0

Data_02F_661F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 wasn't", $F1
    db "taken in!", $EC, $F0

Data_02F_6634:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 slid", $F1
    db "out of the way!", $EC, $F0

Data_02F_664E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "unharmed!", $EC, $F0

Data_02F_6661:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But the prayer", $F1
    db "went unanswered!", $EC, $F0

Data_02F_6683:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was put", $F1
    db "to sleep!", $EC, $F0

Data_02F_669A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "asleep!", $EC, $F0

Data_02F_66AC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "poisoned!", $EC, $F0

Data_02F_66BF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "paralyzed!", $EC, $F0

Data_02F_66D6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "terribly poisoned!", $EC, $F0

Data_02F_66F2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 froze", $F1
    db "solid!", $EC, $F0

Data_02F_6704:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "frozen solid!", $EC, $F0

Data_02F_671E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 struck", $F1
    db "back!", $EC, $F0

Data_02F_6730:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 couldn't", $F1
    db "strike back!", $EC, $F0

Data_02F_674A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "counterstrike!", $EC, $F0

Data_02F_675F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 couldn't", $F1
    db "retaliate!", $EC, $F0

Data_02F_6777:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 blew", $F1
    db "back ", $F9, "G!", $EC, $F0

Data_02F_678A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 went", $F1
    db "away!", $EC, $F0

Data_02F_679A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wind around", $F1
    db $F9, "0 died!", $EC, $F0

Data_02F_67B5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The help went", $F1
    db "away!", $EC, $F0

Data_02F_67CB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "woke up!", $EC, $F0

Data_02F_67D9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 snapped", $F1
    db "out of confusion!", $EC, $F0

Data_02F_67F8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "Ironize wore off!", $EC, $F0

Data_02F_6810:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's wall", $F1
    db "of light faded!", $EC, $F0

Data_02F_682B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The giant went", $F1
    db "away laughing!", $EC, $F0

Data_02F_684B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The ", $F9, "W", $F1
    db "shattered!", $EC, $F0

Data_02F_685F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 suffers", $F1
    db "from poison!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GHP!", $EC, $F0

Data_02F_6889:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "wracked by poison!", $EC, $F2, $ED, $F9, "0 lost", $F1
    db $F9, "GHP!", $EC, $F0

Data_02F_68B4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 died!", $F1
    db $EC, $F0

Data_02F_68C0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "defeated!", $EC, $F0

Data_02F_68D3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 died", $F1
    db "from dancing!", $EC, $F0

Data_02F_68EB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "dead!", $EC, $F0

Data_02F_68FE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "instantly slain!", $EC, $F0

Data_02F_6918:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The ", $F9, "0", $F1
    db "shattered!", $EC, $F0

Data_02F_692C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "dead!", $EC, $F0

Data_02F_693F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's prayer", $F1
    db "went unanswered!", $EC, $F0

Data_02F_695D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "SealPray was", $F1
    db "broken!", $EC, $F0

Data_02F_6974:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "flush with power!", $EC, $F0

Data_02F_6992:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took", $F1
    db "the ", $F9, "W from", $EC, $F2, $ED, $F9, "G.", $F1
    db $EC, $F0

Data_02F_69AF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ate the", $F1
    db "meat happily!", $EC, $F2, $ED, $F9, "0 grew to", $F1
    db "like ", $F9, "G!", $EC, $F0

Data_02F_69E0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 ate the", $F1
    db "meat fearfully!", $EC, $F2, $ED, $F9, "0 glared", $F1
    db "at ", $F9, "G!", $EC, $F0

Data_02F_6A10:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held the", $F1
    db $F9, "W aloft!", $EC, $F0

Data_02F_6A28:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A warm light shone", $F1
    db "from the Orb!", $EC, $F0

Data_02F_6A4B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 gripped", $F1
    db "the BeastTail!", $EC, $F0

Data_02F_6A67:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The BeastTail", $F1
    db "began pointing!", $EC, $F0

Data_02F_6A87:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held", $F1
    db $F9, "W aloft!", $EC, $F0

Data_02F_6A9B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Critical hit!", $F1
    db $EC, $F0

Data_02F_6AAC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A brutal hit!", $F1
    db $EC, $F0

Data_02F_6ABD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "spells, dances", $EC, $F2, $ED, "and breaths are", $F1
    db "sealed!", $EC, $F0

Data_02F_6AEC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 used", $F1
    db "the ", $F9, "W!", $EC, $F0

Data_02F_6AFE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 tossed", $F1
    db "the ", $F9, "W", $EC, $F2, $ED, "at ", $F9, "G!", $F1
    db $EC, $F0

Data_02F_6B1B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the SageRock!", $EC, $F0

Data_02F_6B39:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 scattered", $F1
    db "the WorldDew!", $EC, $F0

Data_02F_6B56:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "Bolts of lightning", $F1
    db "lashed out!", $EC, $F0

Data_02F_6B8F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "Tornadoes leapt", $F1
    db "from its tip!", $EC, $F0

Data_02F_6BC7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "A sinister fog", $F1
    db "descended!", $EC, $F0

Data_02F_6BFB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "A blizzard howls", $F1
    db "from its tip!", $EC, $F0

Data_02F_6C34:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 held aloft", $F1
    db "the ", $F9, "W!", $EC, $F2, $ED, "Flames leapt from", $F1
    db "its tip!", $EC, $F0

Data_02F_6C69:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 set off", $F1
    db "a towering geyser!", $EC, $F0

Data_02F_6C89:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "out of the sky!", $EC, $F0

Data_02F_6CA3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G are", $EC, $F2, $ED, "looking for a", $F1
    db "chance!", $EC, $F0

Data_02F_6CCB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G danced", $EC, $F2, $ED, "in an alluring", $F1
    db "fashion!", $EC, $F0

Data_02F_6CF8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The barrier popped", $F1
    db "and disappeared!", $EC, $F0

Data_02F_6D1E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 landed", $F1
    db "awkwardly!", $EC, $F2, $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

Data_02F_6D4A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 landed", $F1
    db "awkwardly!", $EC, $F2, $ED, $F9, "0 took", $F1
    db $F9, "G damage!", $EC, $F0

Data_02F_6D76:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "landed safely!", $EC, $F0

Data_02F_6D8A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G was", $F1
    db "shattered!", $EC, $F0

Data_02F_6D9E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shook", $F1
    db "off ", $F9, "G!", $EC, $F0

Data_02F_6DB1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G are", $EC, $F2, $ED, "shielding a", $F1
    db "partner!", $EC, $F0

Data_02F_6DD8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's MP was", $F1
    db "restored by ", $F9, "G!", $EC, $F0

Data_02F_6DF5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G began", $EC, $F2, $ED, "to concentrate!", $F1
    db $EC, $F0

Data_02F_6E1A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But ", $F9, "0 was", $F1
    db "unaffected!", $EC, $F0

Data_02F_6E33:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 took a", $F1
    db "wild swing!", $EC, $F2, $ED, "And managed to", $F1
    db "hurt only itself!", $EC, $F0

Data_02F_6E6E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "shaking in fear!", $EC, $F0

Data_02F_6E87:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 charged", $F1
    db "at ", $F9, "G!", $EC, $F2, $ED, "But tripped and", $F1
    db "wiped out!", $EC, $F0

Data_02F_6EB8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "paralyzed!", $EC, $F0

Data_02F_6ECF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's", $F1
    db "attack!", $EC, $F2, $ED, "It appears unable", $F1
    db "to move properly.", $EC, $F0

Data_02F_6F03:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 began", $F1
    db "dancing!", $EC, $F0

Data_02F_6F17:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A foul being was", $F1
    db "summoned!", $EC, $F0

Data_02F_6F34:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 let off", $F1
    db "a black cloud!", $EC, $F0

Data_02F_6F50:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "filled with power!", $EC, $F0

Data_02F_6F68:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "all its MP!", $EC, $F0

Data_02F_6F7E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $AA, "Chance, Chance,", $F1
    db "Chance", $A4, $AA, $EC, $F2, $ED, "The call echoed", $F1
    db "over and over!", $EC, $F0

Data_02F_6FBB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A laughng giant", $F1
    db "appeared!", $EC, $F2, $ED, "The giant", $F1
    db "attacked!", $EC, $F0

Data_02F_6FED:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A cold wind swept", $F1
    db $F9, "0's party!", $EC, $F0

Data_02F_700C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's MP", $F1
    db "was restored!", $EC, $F0

Data_02F_7023:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Meteors rained", $F1
    db "from the heavens!", $EC, $F0

Data_02F_7046:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wall of light", $F1
    db "bounced the spell!", $EC, $F0

Data_02F_706D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wall of light", $F1
    db "bounced the spell!", $EC, $F0

Data_02F_7094:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wind around", $F1
    db $F9, "0 bounced", $EC, $F2, $ED, "the attack!", $F1
    db $EC, $F0

Data_02F_70C0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 shunted", $F1
    db "the attack!", $EC, $F0

Data_02F_70D9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 failed", $F1
    db "to avert attack!", $EC, $F0

Data_02F_70F6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 guarded", $F1
    db $F9, "G!", $EC, $F0

Data_02F_7107:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 inhaled", $F1
    db "the attack!", $EC, $F0

Data_02F_7120:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But nothing", $F1
    db "happened!", $EC, $F0

Data_02F_7138:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's AGL", $F1
    db "fell by ", $F9, "G!", $EC, $F0

Data_02F_714E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 didn't", $F1
    db "fall asleep!", $EC, $F0

Data_02F_7166:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 became", $F1
    db "more confused!", $EC, $F0

Data_02F_7181:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Miss! ", $F9, "0", $F1
    db "was unharmed!", $EC, $F0

Data_02F_719A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Miss! ", $F9, "0", $F1
    db "avoided damage!", $EC, $F0

Data_02F_71B5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 leapt", $F1
    db "out of the way!", $EC, $F0

Data_02F_71D0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "dead!", $EC, $F0, "leapt "

Data_02F_71E9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "already asleep!", $EC, $F0

Data_02F_7201:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is now", $F1
    db "weak to spells!", $EC, $F0

Data_02F_721D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A gentle rain", $F1
    db "fell!", $EC, $F0

Data_02F_7233:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 has", $F1
    db "been immobilized!", $EC, $F0

Data_02F_724E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fled!", $F1
    db $EC, $F0

Data_02F_725A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "cursed!", $EC, $F0

Data_02F_726B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "building power!", $EC, $F0

Data_02F_7283:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "all applied magic!", $EC, $F0

Data_02F_72A0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 gave a", $F1
    db "powderpuff massage", $EC, $F2, $ED, "to ", $F9, "G!", $F1
    db $EC, $F0

Data_02F_72C9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was", $F1
    db "blown sky-high!", $EC, $F0

Data_02F_72E2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "dance anymore!", $EC, $F0

Data_02F_72FB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "its MP!", $EC, $F0

Data_02F_730D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 looks", $F1
    db "vacant and lost!", $EC, $F0

Data_02F_7329:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 is", $F1
    db "guarding itself!", $EC, $F0

Data_02F_7342:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got", $F1
    db "dizzy and fell!", $EC, $F0

Data_02F_735B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 lost", $F1
    db "balance and fell!", $EC, $F0

Data_02F_7377:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 dropped", $F1
    db "down, asleep!", $EC, $F0

Data_02F_7392:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 fell", $F1
    db "and woke up!", $EC, $F0

Data_02F_73A9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 can't", $F1
    db "eat while", $EC, $F2, $ED, "paralyzed!", $EC, $F0

Data_02F_73CA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "The wind around", $F1
    db $F9, "0 died!", $EC, $F0

Data_02F_73E5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's wall", $F1
    db "of light faded!", $EC, $F0

Data_02F_7400:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's water", $F1
    db "barrier reacted!", $EC, $F0

Data_02F_741D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's water", $F1
    db "barrier reacted!", $EC, $F0

Data_02F_743A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "Thordain into", $F1
    db "Alldain!", $EC, $F0

Data_02F_7466:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "BlazeMost and", $F1
    db "Blizzard into", $EC, $F2, $ED, "Blitzer!", $F1
    db $EC, $F0

Data_02F_74A3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G blasted", $EC, $F2, $ED, "a Tidalwave with", $F1
    db "shockwaves to make", $EC, $F2, $ED, "WaveBlast!", $F1
    db $EC, $F0

Data_02F_74EB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G tore", $EC, $F2, $ED, "tornadoes with", $F1
    db "shockwaves to", $EC, $F2, $ED, "loose RageAir!", $F1
    db $EC, $F0

Data_02F_752D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G rocked", $EC, $F2, $ED, "the ground with", $F1
    db "shockwaves to", $EC, $F2, $ED, "loose RageQuake!", $F1
    db $EC, $F0

Data_02F_7574:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "two GigaSlashes", $F1
    db "into GigaBreak!", $EC, $F0

Data_02F_75A9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "two Sacrifices", $F1
    db "into Martyr!", $EC, $F0

Data_02F_75DA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G hurled", $EC, $F2, $ED, $F9, "W high", $F1
    db "and dropped it!", $EC, $F0

Data_02F_7607:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G made", $EC, $F2, $ED, "SquallHit faster", $F1
    db "using SpeedUp!", $EC, $F0

Data_02F_763A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G let", $EC, $F2, $ED, "loose their entire", $F1
    db "magical power!", $EC, $F2, $ED, "It set off a", $F1
    db "wicked explosion!", $EC, $F0

Data_02F_768F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon a spirit!", $EC, $F0

Data_02F_76C1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G sang", $EC, $F2, $ED, "and danced to", $F1
    db "summon death!", $EC, $F0

Data_02F_76F0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "into a huge", $F1
    db "dragon!", $EC, $F0

Data_02F_7719:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G turned", $EC, $F2, $ED, "their skills into", $F1
    db "a wave of energy!", $EC, $F0

Data_02F_7752:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G loosed", $EC, $F2, $ED, "a white, obscuring", $F1
    db "cloud!", $EC, $F0

Data_02F_7781:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 and", $F1
    db $F9, "G created", $EC, $F2, "a vacuum for", $F1
    db "stealing MP!", $EC, $F0

Data_02F_77B0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Critical hit!", $F1
    db $EC, $F0

Data_02F_77C1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "A brutal hit!", $F1
    db $EC, $F0

Data_02F_77D2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $ED, "The monsters ate", $F1
    db "the meat happily!", $EC, $F2, $ED, "The monsters grew", $F1
    db "to like ", $F9, "G!", $EC, $F0

Data_02F_7818:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters ate the", $F1
    db "meat fearfully!", $EC, $F2, $ED, "Monsters glared", $F1
    db "at ", $F9, "G!", $EC, $F0

Data_02F_7854:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Monsters were", $F1
    db "filled with power!", $EC, $F0

Data_02F_7877:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fixed", $F0

Data_02F_787D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Auto", $F0

Data_02F_7882:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fixed", $F0

Data_02F_7888:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Auto", $F0

Data_02F_788D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined", $F0

Data_02F_7897:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EF, $EE, $F6, "'s party got", $EF, $EE, $F9, "0 EX points!", $FA, $F7
    db $F0

Data_02F_78B7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $E5, "0", $ED, $F9, "0 was", $F1
    db "promoted to Lv", $F9, "G!", $E5, $50, $FA, $F7
    db $F2, $ED, $F9, "0", $E8, "60Max. HP ", $A2, $F9, "W", $E8, "01Lv", $F9, "G", $E8, "61Max. MP ", $A2, $F9
    db "a", $FA, $F7
    db $F2, $ED, $F9, "0", $E8, "60ATK ", $A2, $F9, "e", $E8, "01Lv", $F9, "G", $E8, "61DEF ", $A2, $F9, "i", $FA, $F7
    db $F2, $ED, $F9, "0", $E8, "60AGL ", $A2, $F9, "m", $E8, "01Lv", $F9, "G", $E8, "61INT ", $A2, $F9, "q", $FA, $F7
    db $F0

Data_02F_7942:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "At Lv", $F9, "G, ", $F9, "0 ", $F1
    db "learned ", $F9, "W!", $FA, $F7
    db $F0

Data_02F_795E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0's ", $F9, "m", $F1
    db "became ", $F9, "W!", $FA, $F7
    db $F0

Data_02F_7973:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 devised", $F1
    db $F9, "W from the", $FA, $F7
    db $F2, $ED, "skills it knows!", $FA, $F7
    db $F0

Data_02F_79A1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But ", $F9, "0 can't", $F1
    db "learn more skills!", $FA, $F7
    db $F2, $ED, "Which skill should", $F1
    db "be forgotten?", $FA, $F7
    db $F0

Data_02F_79E7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Which skill should", $F1
    db "be forgotten?", $FA, $F7
    db $F0

Data_02F_7A0B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Forget ", $F9, "W?", $F1
    db "Are you sure?", $F0

Data_02F_7A25:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "W was", $F1
    db "forgottten.", $FA, $F7
    db $F0

Data_02F_7A3B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "It has reached the", $F1
    db "limit for growth.", $FA, $F7
    db $F0

Data_02F_7A63:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got up,", $F1
    db "looking hopeful.", $FA, $F7
    db $F2, $ED, "Allow ", $F9, "0 ", $F1
    db "to join you?", $F0

Data_02F_7A9A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0", $F1
    db "departed sadly", $A4, $FA, $F7
    db $F0

Data_02F_7AB0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "But there is no", $F1
    db "more room!", $FA, $F7
    db $F2, $ED, "Release a monster", $F1
    db "to make room?", $F0

Data_02F_7AEF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Which will you", $F1
    db "choose?", $F0

Data_02F_7B07:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You have no eggs.", $FA, $F7
    db $F0

Data_02F_7B1C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Release a monster", $F1
    db "for the new one?", $F0

Data_02F_7B40:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Choose a monster", $F1
    db "to release.", $F0

Data_02F_7B5E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Do you want to", $F1
    db "release ", $F9, "G?", $F0

Data_02F_7B7A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G was set", $F1
    db "free in the wild.", $FA, $F7
    db $F0

Data_02F_7B9A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Please name", $F1
    db $F9, "0.", $FA, $F7
    db $F0

Data_02F_7BAD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "You can't travel", $F1
    db "all alone.", $FA, $F7
    db $F0

Data_02F_7BCB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Choose an egg to", $F1
    db "abandon.", $F0

Data_02F_7BE6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Abandon ", $F9, "G's", $F1
    db "egg?", $F0

Data_02F_7BF8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "G's egg", $F1
    db "was abandoned.", $FA, $F7
    db $F0

Data_02F_7C12:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Will you take", $F1
    db $F9, "0 with you?", $F0

Data_02F_7C2E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was sent", $F1
    db "back to the farm.", $E5, $D6, $FA, $F7
    db $F0

Data_02F_7C51:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined the", $F1
    db "party.", $E5, $D6, $FA, $F7
    db $F0

Data_02F_7C6B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Choose the monster", $F1
    db "to send home.", $F0

Data_02F_7C8D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, "Send ", $F9, "0 back to", $F1
    db "the farm?", $F0

Data_02F_7CA8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 got up,", $F1
    db "looking hopeful.", $FA, $F7
    db $F2, $ED, "But it sadly went", $F1
    db "away", $A4, $FA, $F7
    db $F0

Data_02F_7CE2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 learned", $F1
    db $F9, "G!", $F7
    db $F0

Data_02F_7CF3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 was sent to", $F1
    db "the farm.", $E5, $54, $FA, $F7
    db $F0

Data_02F_7D11:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $ED, $F9, "0 joined the", $F1
    db "party.", $E5, $54, $FA, $F7
    db $F0
    ds $2D5, $00
