SECTION "Bank 08", ROMX[$4000], BANK[$08]
    db $08

; if wC528 < 9, BeginStringDisplay with DE = StringDatabase; otherwise far-calls Func_095_4650
; 12 call sites from 11 routines (e.g. ShowString_Bank08, ShowStringHL_Bank08, DebugMessageTest_Update_Case00, PauseMenu_Items_Case02_Case02, ...)
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
; 3 call sites from 3 routines (e.g. CopyStringHLToDE, ScriptCommand8D_Run_Case19, RunGameMode2State_Case01_Sub02)
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
; 69 call sites from 50 routines (e.g. DebugMessageTest_Init, DebugMonsterRecordViewer_Init, DebugSkillViewer_Init, DebugResultsDisplay_Init, ...)
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
    dw Data_008_492A ; id 0
    dw Data_008_493B ; id 1
    dw Data_008_4A1A ; id 2
    dw Data_008_4A94 ; id 3
    dw Data_008_4AAC ; id 4
    dw Data_008_4B26 ; id 5
    dw Data_008_4B26 ; id 6
    dw Data_008_4B3F ; id 7
    dw Data_008_4B65 ; id 8
    dw Data_008_4B6E ; id 9
    dw Data_008_4BBD ; id 10
    dw Data_008_4BC9 ; id 11
    dw Data_008_4BD2 ; id 12
    dw Data_008_4BDE ; id 13
    dw Data_008_4BE9 ; id 14
    dw Data_008_4BF3 ; id 15
    dw Data_008_4BFE ; id 16
    dw Data_008_4C03 ; id 17
    dw Data_008_4C0A ; id 18
    dw Data_008_4C10 ; id 19
    dw Data_008_4C19 ; id 20
    dw Data_008_4C23 ; id 21
    dw Data_008_4C23 ; id 22
    dw Data_008_4C2E ; id 23
    dw Data_008_4C37 ; id 24
    dw Data_008_4C42 ; id 25
    dw Data_008_4C4B ; id 26
    dw Data_008_4C55 ; id 27
    dw Data_008_4C5D ; id 28
    dw Data_008_4C67 ; id 29
    dw Data_008_4C72 ; id 30
    dw Data_008_4C7D ; id 31
    dw Data_008_4C86 ; id 32
    dw Data_008_4C90 ; id 33
    dw Data_008_4C97 ; id 34
    dw Data_008_4C9D ; id 35
    dw Data_008_4CA8 ; id 36
    dw Data_008_4CB0 ; id 37
    dw Data_008_4CB9 ; id 38
    dw Data_008_4CC3 ; id 39
    dw Data_008_4CC8 ; id 40
    dw Data_008_4CC8 ; id 41
    dw Data_008_4CCB ; id 42
    dw Data_008_4CD4 ; id 43
    dw Data_008_4CDC ; id 44
    dw Data_008_4CE6 ; id 45
    dw Data_008_4CF0 ; id 46
    dw Data_008_4CF8 ; id 47
    dw Data_008_4D00 ; id 48
    dw Data_008_4D0C ; id 49
    dw Data_008_4D0F ; id 50
    dw Data_008_4D17 ; id 51
    dw Data_008_4D24 ; id 52
    dw Data_008_4D2E ; id 53
    dw Data_008_4D34 ; id 54
    dw Data_008_4D3D ; id 55
    dw Data_008_4D45 ; id 56
    dw Data_008_4D4E ; id 57
    dw Data_008_4D5A ; id 58
    dw Data_008_4D62 ; id 59
    dw Data_008_4D69 ; id 60
    dw Data_008_4D73 ; id 61
    dw Data_008_4D7F ; id 62
    dw Data_008_4D8B ; id 63
    dw Data_008_4D92 ; id 64
    dw Data_008_4D9C ; id 65
    dw Data_008_4DA4 ; id 66
    dw Data_008_4DAF ; id 67
    dw Data_008_4DBB ; id 68
    dw Data_008_4DC7 ; id 69
    dw Data_008_4DD2 ; id 70
    dw Data_008_4DDB ; id 71
    dw Data_008_4DE6 ; id 72
    dw Data_008_4DF1 ; id 73
    dw Data_008_4DFC ; id 74
    dw Data_008_4E05 ; id 75
    dw Data_008_4E0F ; id 76
    dw Data_008_4E17 ; id 77
    dw Data_008_4E21 ; id 78
    dw Data_008_4E2C ; id 79
    dw Data_008_4E39 ; id 80
    dw Data_008_4E39 ; id 81
    dw Data_008_4E3C ; id 82
    dw Data_008_4E42 ; id 83
    dw Data_008_4E49 ; id 84
    dw Data_008_4E52 ; id 85
    dw Data_008_4E5D ; id 86
    dw Data_008_4E66 ; id 87
    dw Data_008_4E72 ; id 88
    dw Data_008_4E7B ; id 89
    dw Data_008_4E83 ; id 90
    dw Data_008_4E8D ; id 91
    dw Data_008_4E97 ; id 92
    dw Data_008_4EA3 ; id 93
    dw Data_008_4EA8 ; id 94
    dw Data_008_4EB1 ; id 95
    dw Data_008_4EBA ; id 96
    dw Data_008_4EC3 ; id 97
    dw Data_008_4ECD ; id 98
    dw Data_008_4ED6 ; id 99
    dw Data_008_4EE1 ; id 100
    dw Data_008_4EEC ; id 101
    dw Data_008_4EF7 ; id 102
    dw Data_008_4F01 ; id 103
    dw Data_008_4F0A ; id 104
    dw Data_008_4F14 ; id 105
    dw Data_008_4F1F ; id 106
    dw Data_008_4F28 ; id 107
    dw Data_008_4F33 ; id 108
    dw Data_008_4F3E ; id 109
    dw Data_008_4F48 ; id 110
    dw Data_008_4F52 ; id 111
    dw Data_008_4F5C ; id 112
    dw Data_008_4F66 ; id 113
    dw Data_008_4F70 ; id 114
    dw Data_008_4F7D ; id 115
    dw Data_008_4F7D ; id 116
    dw Data_008_4F7D ; id 117
    dw Data_008_4F7D ; id 118
    dw Data_008_4F7D ; id 119
    dw Data_008_4F7D ; id 120
    dw Data_008_4F7D ; id 121
    dw Data_008_4F80 ; id 122
    dw Data_008_4F88 ; id 123
    dw Data_008_4F90 ; id 124
    dw Data_008_4F9A ; id 125
    dw Data_008_4FA4 ; id 126
    dw Data_008_4FAE ; id 127
    dw Data_008_4FB8 ; id 128
    dw Data_008_4FC2 ; id 129
    dw Data_008_4FCE ; id 130
    dw Data_008_4FD4 ; id 131
    dw Data_008_4FDC ; id 132
    dw Data_008_4FE7 ; id 133
    dw Data_008_4FF0 ; id 134
    dw Data_008_4FF9 ; id 135
    dw Data_008_5004 ; id 136
    dw Data_008_500F ; id 137
    dw Data_008_5018 ; id 138
    dw Data_008_5024 ; id 139
    dw Data_008_502C ; id 140
    dw Data_008_5038 ; id 141
    dw Data_008_5044 ; id 142
    dw Data_008_504D ; id 143
    dw Data_008_5057 ; id 144
    dw Data_008_5061 ; id 145
    dw Data_008_506B ; id 146
    dw Data_008_5075 ; id 147
    dw Data_008_507C ; id 148
    dw Data_008_5083 ; id 149
    dw Data_008_508D ; id 150
    dw Data_008_5096 ; id 151
    dw Data_008_509D ; id 152
    dw Data_008_50A6 ; id 153
    dw Data_008_50B0 ; id 154
    dw Data_008_50B9 ; id 155
    dw Data_008_50C2 ; id 156
    dw Data_008_50CA ; id 157
    dw Data_008_50D2 ; id 158
    dw Data_008_50DD ; id 159
    dw Data_008_50E9 ; id 160
    dw Data_008_50F5 ; id 161
    dw Data_008_5101 ; id 162
    dw Data_008_510D ; id 163
    dw Data_008_5119 ; id 164
    dw Data_008_5125 ; id 165
    dw Data_008_5130 ; id 166
    dw Data_008_5133 ; id 167
    dw Data_008_5140 ; id 168
    dw Data_008_5140 ; id 169
    dw Data_008_5143 ; id 170
    dw Data_008_514B ; id 171
    dw Data_008_5154 ; id 172
    dw Data_008_5160 ; id 173
    dw Data_008_5168 ; id 174
    dw Data_008_5175 ; id 175
    dw Data_008_5175 ; id 176
    dw Data_008_5175 ; id 177
    dw Data_008_5178 ; id 178
    dw Data_008_5180 ; id 179
    dw Data_008_5188 ; id 180
    dw Data_008_5191 ; id 181
    dw Data_008_5199 ; id 182
    dw Data_008_51A0 ; id 183
    dw Data_008_51A9 ; id 184
    dw Data_008_51B5 ; id 185
    dw Data_008_51C2 ; id 186
    dw Data_008_51CB ; id 187
    dw Data_008_51D5 ; id 188
    dw Data_008_51E2 ; id 189
    dw Data_008_51EA ; id 190
    dw Data_008_51F2 ; id 191
    dw Data_008_51FA ; id 192
    dw Data_008_5205 ; id 193
    dw Data_008_5208 ; id 194
    dw Data_008_5213 ; id 195
    dw Data_008_521C ; id 196
    dw Data_008_5227 ; id 197
    dw Data_008_5230 ; id 198
    dw Data_008_5234 ; id 199
    dw Data_008_523D ; id 200
    dw Data_008_5246 ; id 201
    dw Data_008_524F ; id 202
    dw Data_008_5258 ; id 203
    dw Data_008_5261 ; id 204
    dw Data_008_526A ; id 205
    dw Data_008_5273 ; id 206
    dw Data_008_527C ; id 207
    dw Data_008_5289 ; id 208
    dw Data_008_5289 ; id 209
    dw Data_008_528C ; id 210
    dw Data_008_5294 ; id 211
    dw Data_008_529F ; id 212
    dw Data_008_52AA ; id 213
    dw Data_008_52B5 ; id 214
    dw Data_008_52C0 ; id 215
    dw Data_008_52CB ; id 216
    dw Data_008_52D6 ; id 217
    dw Data_008_52E1 ; id 218
    dw Data_008_52EE ; id 219
    dw Data_008_52F7 ; id 220
    dw Data_008_5303 ; id 221
    dw Data_008_530F ; id 222
    dw Data_008_531B ; id 223
    dw Data_008_5327 ; id 224
    dw Data_008_5333 ; id 225
    dw Data_008_533F ; id 226
    dw Data_008_534B ; id 227
    dw Data_008_5358 ; id 228
    dw Data_008_535F ; id 229
    dw Data_008_5369 ; id 230
    dw Data_008_5373 ; id 231
    dw Data_008_537D ; id 232
    dw Data_008_5387 ; id 233
    dw Data_008_5391 ; id 234
    dw Data_008_539B ; id 235
    dw Data_008_53A5 ; id 236
    dw Data_008_53B2 ; id 237
    dw Data_008_53B2 ; id 238
    dw Data_008_53B2 ; id 239
    dw Data_008_53B2 ; id 240
    dw Data_008_53B2 ; id 241
    dw Data_008_53B2 ; id 242
    dw Data_008_53B2 ; id 243
    dw Data_008_53B2 ; id 244
    dw Data_008_53B2 ; id 245
    dw Data_008_53B2 ; id 246
    dw Data_008_53B2 ; id 247
    dw Data_008_53B2 ; id 248
    dw Data_008_53B2 ; id 249
    dw Data_008_53B2 ; id 250
    dw Data_008_53B2 ; id 251
    dw Data_008_53B2 ; id 252
    dw Data_008_53B2 ; id 253
    dw Data_008_53B2 ; id 254

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4242::
StringTable_MonsterFamilies:: ; heuristic: string list; C0
Data_008_4242:: ; address name
    dw Data_008_53B5 ; id 0
    dw Data_008_53BB ; id 1
    dw Data_008_53C2 ; id 2
    dw Data_008_53C8 ; id 3
    dw Data_008_53CD ; id 4
    dw Data_008_53D3 ; id 5
    dw Data_008_53D7 ; id 6
    dw Data_008_53DD ; id 7
    dw Data_008_53E4 ; id 8
    dw Data_008_53ED ; id 9
    dw Data_008_53F3 ; id 10

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4258::
StringTable_MonsterNames:: ; heuristic: string list; C0
Data_008_4258:: ; address name
    dw Data_008_53F8 ; id 0
    dw Data_008_53F9 ; id 1
    dw Data_008_5403 ; id 2
    dw Data_008_540D ; id 3
    dw Data_008_5417 ; id 4
    dw Data_008_5421 ; id 5
    dw Data_008_5428 ; id 6
    dw Data_008_5432 ; id 7
    dw Data_008_5439 ; id 8
    dw Data_008_5442 ; id 9
    dw Data_008_544B ; id 10
    dw Data_008_5451 ; id 11
    dw Data_008_5458 ; id 12
    dw Data_008_5462 ; id 13
    dw Data_008_546C ; id 14
    dw Data_008_5476 ; id 15
    dw Data_008_547E ; id 16
    dw Data_008_5488 ; id 17
    dw Data_008_548F ; id 18
    dw Data_008_5498 ; id 19
    dw Data_008_54A1 ; id 20
    dw Data_008_54AB ; id 21
    dw Data_008_54B5 ; id 22
    dw Data_008_54BF ; id 23
    dw Data_008_54C9 ; id 24
    dw Data_008_54D3 ; id 25
    dw Data_008_54DD ; id 26
    dw Data_008_54E7 ; id 27
    dw Data_008_54ED ; id 28
    dw Data_008_54ED ; id 29
    dw Data_008_54ED ; id 30
    dw Data_008_54ED ; id 31
    dw Data_008_54ED ; id 32
    dw Data_008_54ED ; id 33
    dw Data_008_54ED ; id 34
    dw Data_008_54ED ; id 35
    dw Data_008_54EF ; id 36
    dw Data_008_54F9 ; id 37
    dw Data_008_5503 ; id 38
    dw Data_008_550C ; id 39
    dw Data_008_5513 ; id 40
    dw Data_008_551D ; id 41
    dw Data_008_5527 ; id 42
    dw Data_008_5531 ; id 43
    dw Data_008_553A ; id 44
    dw Data_008_5541 ; id 45
    dw Data_008_5548 ; id 46
    dw Data_008_5551 ; id 47
    dw Data_008_555B ; id 48
    dw Data_008_5563 ; id 49
    dw Data_008_556D ; id 50
    dw Data_008_5577 ; id 51
    dw Data_008_557F ; id 52
    dw Data_008_5589 ; id 53
    dw Data_008_5592 ; id 54
    dw Data_008_559B ; id 55
    dw Data_008_55A5 ; id 56
    dw Data_008_55AF ; id 57
    dw Data_008_55B9 ; id 58
    dw Data_008_55C3 ; id 59
    dw Data_008_55CA ; id 60
    dw Data_008_55D1 ; id 61
    dw Data_008_55DB ; id 62
    dw Data_008_55E5 ; id 63
    dw Data_008_55EF ; id 64
    dw Data_008_55F9 ; id 65
    dw Data_008_5601 ; id 66
    dw Data_008_560B ; id 67
    dw Data_008_560B ; id 68
    dw Data_008_560B ; id 69
    dw Data_008_560B ; id 70
    dw Data_008_560D ; id 71
    dw Data_008_5617 ; id 72
    dw Data_008_561F ; id 73
    dw Data_008_5626 ; id 74
    dw Data_008_5630 ; id 75
    dw Data_008_5637 ; id 76
    dw Data_008_5641 ; id 77
    dw Data_008_564A ; id 78
    dw Data_008_5654 ; id 79
    dw Data_008_565C ; id 80
    dw Data_008_5664 ; id 81
    dw Data_008_566D ; id 82
    dw Data_008_5676 ; id 83
    dw Data_008_567F ; id 84
    dw Data_008_5689 ; id 85
    dw Data_008_5691 ; id 86
    dw Data_008_5696 ; id 87
    dw Data_008_569F ; id 88
    dw Data_008_56A9 ; id 89
    dw Data_008_56B3 ; id 90
    dw Data_008_56BD ; id 91
    dw Data_008_56C6 ; id 92
    dw Data_008_56CE ; id 93
    dw Data_008_56D7 ; id 94
    dw Data_008_56DF ; id 95
    dw Data_008_56E9 ; id 96
    dw Data_008_56F1 ; id 97
    dw Data_008_56FA ; id 98
    dw Data_008_5701 ; id 99
    dw Data_008_5708 ; id 100
    dw Data_008_570F ; id 101
    dw Data_008_5717 ; id 102
    dw Data_008_571F ; id 103
    dw Data_008_571F ; id 104
    dw Data_008_571F ; id 105
    dw Data_008_5721 ; id 106
    dw Data_008_5727 ; id 107
    dw Data_008_572E ; id 108
    dw Data_008_5737 ; id 109
    dw Data_008_5740 ; id 110
    dw Data_008_5749 ; id 111
    dw Data_008_5753 ; id 112
    dw Data_008_575C ; id 113
    dw Data_008_5766 ; id 114
    dw Data_008_576F ; id 115
    dw Data_008_5776 ; id 116
    dw Data_008_577F ; id 117
    dw Data_008_5788 ; id 118
    dw Data_008_5791 ; id 119
    dw Data_008_5799 ; id 120
    dw Data_008_57A2 ; id 121
    dw Data_008_57AC ; id 122
    dw Data_008_57B1 ; id 123
    dw Data_008_57BB ; id 124
    dw Data_008_57C3 ; id 125
    dw Data_008_57CB ; id 126
    dw Data_008_57D4 ; id 127
    dw Data_008_57DD ; id 128
    dw Data_008_57E7 ; id 129
    dw Data_008_57F0 ; id 130
    dw Data_008_57F8 ; id 131
    dw Data_008_5800 ; id 132
    dw Data_008_580A ; id 133
    dw Data_008_580A ; id 134
    dw Data_008_580A ; id 135
    dw Data_008_580A ; id 136
    dw Data_008_580A ; id 137
    dw Data_008_580A ; id 138
    dw Data_008_580A ; id 139
    dw Data_008_580A ; id 140
    dw Data_008_580C ; id 141
    dw Data_008_5815 ; id 142
    dw Data_008_581E ; id 143
    dw Data_008_5827 ; id 144
    dw Data_008_5830 ; id 145
    dw Data_008_583A ; id 146
    dw Data_008_5842 ; id 147
    dw Data_008_584C ; id 148
    dw Data_008_5856 ; id 149
    dw Data_008_5860 ; id 150
    dw Data_008_5869 ; id 151
    dw Data_008_5870 ; id 152
    dw Data_008_587A ; id 153
    dw Data_008_5882 ; id 154
    dw Data_008_588B ; id 155
    dw Data_008_5894 ; id 156
    dw Data_008_589C ; id 157
    dw Data_008_58A4 ; id 158
    dw Data_008_58AD ; id 159
    dw Data_008_58B6 ; id 160
    dw Data_008_58BE ; id 161
    dw Data_008_58C7 ; id 162
    dw Data_008_58D0 ; id 163
    dw Data_008_58D9 ; id 164
    dw Data_008_58E1 ; id 165
    dw Data_008_58E9 ; id 166
    dw Data_008_58F3 ; id 167
    dw Data_008_58FB ; id 168
    dw Data_008_58FB ; id 169
    dw Data_008_58FB ; id 170
    dw Data_008_58FB ; id 171
    dw Data_008_58FB ; id 172
    dw Data_008_58FB ; id 173
    dw Data_008_58FB ; id 174
    dw Data_008_58FB ; id 175
    dw Data_008_58FD ; id 176
    dw Data_008_5907 ; id 177
    dw Data_008_5910 ; id 178
    dw Data_008_591A ; id 179
    dw Data_008_5924 ; id 180
    dw Data_008_592C ; id 181
    dw Data_008_5936 ; id 182
    dw Data_008_593C ; id 183
    dw Data_008_5944 ; id 184
    dw Data_008_594A ; id 185
    dw Data_008_5952 ; id 186
    dw Data_008_595B ; id 187
    dw Data_008_5965 ; id 188
    dw Data_008_596F ; id 189
    dw Data_008_5976 ; id 190
    dw Data_008_5980 ; id 191
    dw Data_008_5986 ; id 192
    dw Data_008_598F ; id 193
    dw Data_008_5999 ; id 194
    dw Data_008_59A2 ; id 195
    dw Data_008_59AC ; id 196
    dw Data_008_59B5 ; id 197
    dw Data_008_59BD ; id 198
    dw Data_008_59C7 ; id 199
    dw Data_008_59CF ; id 200
    dw Data_008_59D9 ; id 201
    dw Data_008_59E3 ; id 202
    dw Data_008_59E3 ; id 203
    dw Data_008_59E3 ; id 204
    dw Data_008_59E3 ; id 205
    dw Data_008_59E3 ; id 206
    dw Data_008_59E3 ; id 207
    dw Data_008_59E3 ; id 208
    dw Data_008_59E3 ; id 209
    dw Data_008_59E3 ; id 210
    dw Data_008_59E5 ; id 211
    dw Data_008_59EA ; id 212
    dw Data_008_59F4 ; id 213
    dw Data_008_59FC ; id 214
    dw Data_008_5A05 ; id 215
    dw Data_008_5A0D ; id 216
    dw Data_008_5A15 ; id 217
    dw Data_008_5A1F ; id 218
    dw Data_008_5A29 ; id 219
    dw Data_008_5A33 ; id 220
    dw Data_008_5A3D ; id 221
    dw Data_008_5A45 ; id 222
    dw Data_008_5A4E ; id 223
    dw Data_008_5A55 ; id 224
    dw Data_008_5A5E ; id 225
    dw Data_008_5A62 ; id 226
    dw Data_008_5A67 ; id 227
    dw Data_008_5A71 ; id 228
    dw Data_008_5A7B ; id 229
    dw Data_008_5A85 ; id 230
    dw Data_008_5A8D ; id 231
    dw Data_008_5A94 ; id 232
    dw Data_008_5A9E ; id 233
    dw Data_008_5AA7 ; id 234
    dw Data_008_5AB0 ; id 235
    dw Data_008_5ABA ; id 236
    dw Data_008_5AC4 ; id 237
    dw Data_008_5ACC ; id 238
    dw Data_008_5AD3 ; id 239
    dw Data_008_5ADB ; id 240
    dw Data_008_5AE5 ; id 241
    dw Data_008_5AE5 ; id 242
    dw Data_008_5AE5 ; id 243
    dw Data_008_5AE5 ; id 244
    dw Data_008_5AE5 ; id 245
    dw Data_008_5AE7 ; id 246
    dw Data_008_5AEE ; id 247
    dw Data_008_5AF7 ; id 248
    dw Data_008_5B00 ; id 249
    dw Data_008_5B09 ; id 250
    dw Data_008_5B0F ; id 251
    dw Data_008_5B18 ; id 252
    dw Data_008_5B21 ; id 253
    dw Data_008_5B28 ; id 254
    dw Data_008_5B31 ; id 255

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4458::
StringTable_MonsterNames2:: ; heuristic: string list; C0
Data_008_4458:: ; address name
    dw Data_008_5B36 ; id 0
    dw Data_008_5B3D ; id 1
    dw Data_008_5B46 ; id 2
    dw Data_008_5B50 ; id 3
    dw Data_008_5B57 ; id 4
    dw Data_008_5B60 ; id 5
    dw Data_008_5B68 ; id 6
    dw Data_008_5B71 ; id 7
    dw Data_008_5B7B ; id 8
    dw Data_008_5B85 ; id 9
    dw Data_008_5B8F ; id 10
    dw Data_008_5B98 ; id 11
    dw Data_008_5BA0 ; id 12
    dw Data_008_5BAA ; id 13
    dw Data_008_5BB2 ; id 14
    dw Data_008_5BBC ; id 15
    dw Data_008_5BC6 ; id 16
    dw Data_008_5BCF ; id 17
    dw Data_008_5BCF ; id 18
    dw Data_008_5BCF ; id 19
    dw Data_008_5BCF ; id 20
    dw Data_008_5BCF ; id 21
    dw Data_008_5BCF ; id 22
    dw Data_008_5BCF ; id 23
    dw Data_008_5BCF ; id 24
    dw Data_008_5BD1 ; id 25
    dw Data_008_5BDA ; id 26
    dw Data_008_5BE3 ; id 27
    dw Data_008_5BED ; id 28
    dw Data_008_5BF6 ; id 29
    dw Data_008_5BFC ; id 30
    dw Data_008_5C05 ; id 31
    dw Data_008_5C0F ; id 32
    dw Data_008_5C19 ; id 33
    dw Data_008_5C22 ; id 34
    dw Data_008_5C28 ; id 35
    dw Data_008_5C30 ; id 36
    dw Data_008_5C3A ; id 37
    dw Data_008_5C41 ; id 38
    dw Data_008_5C4A ; id 39
    dw Data_008_5C54 ; id 40
    dw Data_008_5C5D ; id 41
    dw Data_008_5C66 ; id 42
    dw Data_008_5C70 ; id 43
    dw Data_008_5C78 ; id 44
    dw Data_008_5C7E ; id 45
    dw Data_008_5C86 ; id 46
    dw Data_008_5C8D ; id 47
    dw Data_008_5C93 ; id 48
    dw Data_008_5C9C ; id 49
    dw Data_008_5CA4 ; id 50
    dw Data_008_5CAA ; id 51
    dw Data_008_5CB3 ; id 52
    dw Data_008_5CBC ; id 53
    dw Data_008_5CC6 ; id 54
    dw Data_008_5CCF ; id 55
    dw Data_008_5CD9 ; id 56
    dw Data_008_5CE3 ; id 57
    dw Data_008_5CE3 ; id 58
    dw Data_008_5CE3 ; id 59
    dw Data_008_5CE5 ; id 60
    dw Data_008_5CEE ; id 61
    dw Data_008_5CF4 ; id 62
    dw Data_008_5CFE ; id 63
    dw Data_008_5D07 ; id 64
    dw Data_008_5D0E ; id 65
    dw Data_008_5D18 ; id 66
    dw Data_008_5D1F ; id 67
    dw Data_008_5D27 ; id 68
    dw Data_008_5D31 ; id 69
    dw Data_008_5D3B ; id 70
    dw Data_008_5D44 ; id 71
    dw Data_008_5D4E ; id 72
    dw Data_008_5D57 ; id 73
    dw Data_008_5D60 ; id 74
    dw Data_008_5D69 ; id 75
    dw Data_008_5D73 ; id 76
    dw Data_008_5D7D ; id 77
    dw Data_008_5D86 ; id 78
    dw Data_008_5D8F ; id 79
    dw Data_008_5D99 ; id 80
    dw Data_008_5DA2 ; id 81
    dw Data_008_5DAB ; id 82
    dw Data_008_5DB3 ; id 83
    dw Data_008_5DBD ; id 84
    dw Data_008_5DC4 ; id 85
    dw Data_008_5DCE ; id 86
    dw Data_008_5DD6 ; id 87
    dw Data_008_5DDF ; id 88
    dw Data_008_5DE6 ; id 89
    dw Data_008_5DEF ; id 90
    dw Data_008_5DF8 ; id 91
    dw Data_008_5E01 ; id 92
    dw Data_008_5E01 ; id 93
    dw Data_008_5E01 ; id 94
    dw Data_008_5E03 ; id 95
    dw Data_008_5E0D ; id 96
    dw Data_008_5E17 ; id 97
    dw Data_008_5E21 ; id 98
    dw Data_008_5E28 ; id 99
    dw Data_008_5E2E ; id 100
    dw Data_008_5E38 ; id 101
    dw Data_008_5E40 ; id 102
    dw Data_008_5E45 ; id 103
    dw Data_008_5E4F ; id 104
    dw Data_008_5E57 ; id 105
    dw Data_008_5E61 ; id 106
    dw Data_008_5E68 ; id 107
    dw Data_008_5E72 ; id 108
    dw Data_008_5E7C ; id 109
    dw Data_008_5E82 ; id 110
    dw Data_008_5E8C ; id 111
    dw Data_008_5E96 ; id 112
    dw Data_008_5EA0 ; id 113
    dw Data_008_5EAA ; id 114
    dw Data_008_5EB4 ; id 115
    dw Data_008_5EBE ; id 116
    dw Data_008_5EC4 ; id 117
    dw Data_008_5ECA ; id 118
    dw Data_008_5ED0 ; id 119
    dw Data_008_5ED6 ; id 120
    dw Data_008_5EDC ; id 121
    dw Data_008_5EDC ; id 122
    dw Data_008_5EDC ; id 123
    dw Data_008_5EDE ; id 124
    dw Data_008_5EE4 ; id 125
    dw Data_008_5EEE ; id 126
    dw Data_008_5EF6 ; id 127

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4558::
StringTable_SkillNames:: ; heuristic: string list; C0
Data_008_4558:: ; address name
    dw Data_008_5EF8 ; id 0
    dw Data_008_5EF9 ; id 1
    dw Data_008_5EFF ; id 2
    dw Data_008_5F09 ; id 3
    dw Data_008_5F13 ; id 4
    dw Data_008_5F1B ; id 5
    dw Data_008_5F24 ; id 6
    dw Data_008_5F2D ; id 7
    dw Data_008_5F32 ; id 8
    dw Data_008_5F37 ; id 9
    dw Data_008_5F40 ; id 10
    dw Data_008_5F49 ; id 11
    dw Data_008_5F53 ; id 12
    dw Data_008_5F5D ; id 13
    dw Data_008_5F62 ; id 14
    dw Data_008_5F66 ; id 15
    dw Data_008_5F6F ; id 16
    dw Data_008_5F77 ; id 17
    dw Data_008_5F81 ; id 18
    dw Data_008_5F8A ; id 19
    dw Data_008_5F8F ; id 20
    dw Data_008_5F96 ; id 21
    dw Data_008_5FA0 ; id 22
    dw Data_008_5FA5 ; id 23
    dw Data_008_5FAE ; id 24
    dw Data_008_5FB6 ; id 25
    dw Data_008_5FBD ; id 26
    dw Data_008_5FC7 ; id 27
    dw Data_008_5FCD ; id 28
    dw Data_008_5FD7 ; id 29
    dw Data_008_5FE1 ; id 30
    dw Data_008_5FE8 ; id 31
    dw Data_008_5FEF ; id 32
    dw Data_008_5FF8 ; id 33
    dw Data_008_6001 ; id 34
    dw Data_008_6009 ; id 35
    dw Data_008_6011 ; id 36
    dw Data_008_601A ; id 37
    dw Data_008_6020 ; id 38
    dw Data_008_6029 ; id 39
    dw Data_008_602D ; id 40
    dw Data_008_6035 ; id 41
    dw Data_008_603B ; id 42
    dw Data_008_6043 ; id 43
    dw Data_008_6048 ; id 44
    dw Data_008_6050 ; id 45
    dw Data_008_6059 ; id 46
    dw Data_008_6062 ; id 47
    dw Data_008_6068 ; id 48
    dw Data_008_6071 ; id 49
    dw Data_008_607B ; id 50
    dw Data_008_6084 ; id 51
    dw Data_008_608E ; id 52
    dw Data_008_6097 ; id 53
    dw Data_008_609F ; id 54
    dw Data_008_60A9 ; id 55
    dw Data_008_60B0 ; id 56
    dw Data_008_60B8 ; id 57
    dw Data_008_60C2 ; id 58
    dw Data_008_60CC ; id 59
    dw Data_008_60D5 ; id 60
    dw Data_008_60DC ; id 61
    dw Data_008_60E6 ; id 62
    dw Data_008_60EE ; id 63
    dw Data_008_60F8 ; id 64
    dw Data_008_6100 ; id 65
    dw Data_008_6109 ; id 66
    dw Data_008_6113 ; id 67
    dw Data_008_611D ; id 68
    dw Data_008_6127 ; id 69
    dw Data_008_612E ; id 70
    dw Data_008_6137 ; id 71
    dw Data_008_6140 ; id 72
    dw Data_008_614A ; id 73
    dw Data_008_6151 ; id 74
    dw Data_008_615B ; id 75
    dw Data_008_6165 ; id 76
    dw Data_008_616F ; id 77
    dw Data_008_6179 ; id 78
    dw Data_008_6182 ; id 79
    dw Data_008_618B ; id 80
    dw Data_008_6195 ; id 81
    dw Data_008_619F ; id 82
    dw Data_008_61A9 ; id 83
    dw Data_008_61B2 ; id 84
    dw Data_008_61BC ; id 85
    dw Data_008_61C6 ; id 86
    dw Data_008_61CF ; id 87
    dw Data_008_61D8 ; id 88
    dw Data_008_61E0 ; id 89
    dw Data_008_61E7 ; id 90
    dw Data_008_61F0 ; id 91
    dw Data_008_61FA ; id 92
    dw Data_008_6203 ; id 93
    dw Data_008_620B ; id 94
    dw Data_008_6214 ; id 95
    dw Data_008_621E ; id 96
    dw Data_008_6227 ; id 97
    dw Data_008_6231 ; id 98
    dw Data_008_623B ; id 99
    dw Data_008_6244 ; id 100
    dw Data_008_624D ; id 101
    dw Data_008_6257 ; id 102
    dw Data_008_6260 ; id 103
    dw Data_008_626A ; id 104
    dw Data_008_6273 ; id 105
    dw Data_008_627C ; id 106
    dw Data_008_6285 ; id 107
    dw Data_008_628F ; id 108
    dw Data_008_6298 ; id 109
    dw Data_008_62A2 ; id 110
    dw Data_008_62AC ; id 111
    dw Data_008_62B4 ; id 112
    dw Data_008_62BD ; id 113
    dw Data_008_62C6 ; id 114
    dw Data_008_62CF ; id 115
    dw Data_008_62D9 ; id 116
    dw Data_008_62E3 ; id 117
    dw Data_008_62E9 ; id 118
    dw Data_008_62F2 ; id 119
    dw Data_008_62FB ; id 120
    dw Data_008_6305 ; id 121
    dw Data_008_630F ; id 122
    dw Data_008_6319 ; id 123
    dw Data_008_6323 ; id 124
    dw Data_008_632A ; id 125
    dw Data_008_6333 ; id 126
    dw Data_008_633D ; id 127
    dw Data_008_6345 ; id 128
    dw Data_008_634F ; id 129
    dw Data_008_6355 ; id 130
    dw Data_008_635F ; id 131
    dw Data_008_6367 ; id 132
    dw Data_008_6370 ; id 133
    dw Data_008_637A ; id 134
    dw Data_008_6384 ; id 135
    dw Data_008_638E ; id 136
    dw Data_008_6398 ; id 137
    dw Data_008_63A0 ; id 138
    dw Data_008_63A6 ; id 139
    dw Data_008_63B0 ; id 140
    dw Data_008_63B9 ; id 141
    dw Data_008_63C2 ; id 142
    dw Data_008_63CA ; id 143
    dw Data_008_63CF ; id 144
    dw Data_008_63D6 ; id 145
    dw Data_008_63DD ; id 146
    dw Data_008_63E7 ; id 147
    dw Data_008_63F1 ; id 148
    dw Data_008_63F9 ; id 149
    dw Data_008_63FF ; id 150
    dw Data_008_6406 ; id 151
    dw Data_008_640C ; id 152
    dw Data_008_6415 ; id 153
    dw Data_008_641E ; id 154
    dw Data_008_6428 ; id 155
    dw Data_008_6431 ; id 156
    dw Data_008_643A ; id 157
    dw Data_008_6442 ; id 158
    dw Data_008_644A ; id 159
    dw Data_008_6453 ; id 160
    dw Data_008_645C ; id 161
    dw Data_008_6465 ; id 162
    dw Data_008_646D ; id 163
    dw Data_008_6477 ; id 164
    dw Data_008_6481 ; id 165
    dw Data_008_6489 ; id 166
    dw Data_008_6492 ; id 167
    dw Data_008_6499 ; id 168
    dw Data_008_64A2 ; id 169
    dw Data_008_64AB ; id 170
    dw Data_008_64B0 ; id 171
    dw Data_008_64B8 ; id 172
    dw Data_008_64BE ; id 173
    dw Data_008_64C7 ; id 174
    dw Data_008_64CF ; id 175
    dw Data_008_64CF ; id 176
    dw Data_008_64CF ; id 177
    dw Data_008_64CF ; id 178
    dw Data_008_64CF ; id 179
    dw Data_008_64CF ; id 180
    dw Data_008_64CF ; id 181
    dw Data_008_64CF ; id 182
    dw Data_008_64CF ; id 183
    dw Data_008_64CF ; id 184
    dw Data_008_64CF ; id 185
    dw Data_008_64CF ; id 186
    dw Data_008_64CF ; id 187
    dw Data_008_64CF ; id 188
    dw Data_008_64CF ; id 189
    dw Data_008_64CF ; id 190
    dw Data_008_64CF ; id 191
    dw Data_008_64CF ; id 192
    dw Data_008_64CF ; id 193
    dw Data_008_64CF ; id 194
    dw Data_008_64CF ; id 195
    dw Data_008_64CF ; id 196
    dw Data_008_64CF ; id 197
    dw Data_008_64CF ; id 198
    dw Data_008_64CF ; id 199
    dw Data_008_64CF ; id 200
    dw Data_008_64CF ; id 201
    dw Data_008_64CF ; id 202
    dw Data_008_64CF ; id 203
    dw Data_008_64CF ; id 204
    dw Data_008_64D8 ; id 205
    dw Data_008_64D8 ; id 206
    dw Data_008_64D8 ; id 207
    dw Data_008_64E1 ; id 208
    dw Data_008_64E1 ; id 209
    dw Data_008_64E1 ; id 210
    dw Data_008_64E1 ; id 211
    dw Data_008_64E1 ; id 212
    dw Data_008_64E1 ; id 213
    dw Data_008_64E1 ; id 214
    dw Data_008_64E1 ; id 215
    dw Data_008_64E1 ; id 216
    dw Data_008_64E1 ; id 217
    dw Data_008_64E1 ; id 218
    dw Data_008_64E1 ; id 219
    dw Data_008_64E1 ; id 220
    dw Data_008_64E1 ; id 221
    dw Data_008_64E1 ; id 222

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_4716::
StringTable_ItemNames:: ; heuristic: string list; C0
Data_008_4716:: ; address name
    dw Data_008_64E2 ; id 0
    dw Data_008_64E3 ; id 1
    dw Data_008_64E8 ; id 2
    dw Data_008_64F2 ; id 3
    dw Data_008_64FB ; id 4
    dw Data_008_6502 ; id 5
    dw Data_008_650B ; id 6
    dw Data_008_6514 ; id 7
    dw Data_008_651D ; id 8
    dw Data_008_6524 ; id 9
    dw Data_008_652E ; id 10
    dw Data_008_6536 ; id 11
    dw Data_008_653F ; id 12
    dw Data_008_6549 ; id 13
    dw Data_008_6551 ; id 14
    dw Data_008_6559 ; id 15
    dw Data_008_6561 ; id 16
    dw Data_008_6569 ; id 17
    dw Data_008_6573 ; id 18
    dw Data_008_657D ; id 19
    dw Data_008_6584 ; id 20
    dw Data_008_658C ; id 21
    dw Data_008_6594 ; id 22
    dw Data_008_659D ; id 23
    dw Data_008_65A4 ; id 24
    dw Data_008_65AC ; id 25
    dw Data_008_65B6 ; id 26
    dw Data_008_65BF ; id 27
    dw Data_008_65C3 ; id 28
    dw Data_008_65CB ; id 29
    dw Data_008_65D3 ; id 30
    dw Data_008_65DB ; id 31
    dw Data_008_65E5 ; id 32
    dw Data_008_65EF ; id 33
    dw Data_008_65F9 ; id 34
    dw Data_008_65FF ; id 35
    dw Data_008_6607 ; id 36
    dw Data_008_660D ; id 37
    dw Data_008_6613 ; id 38
    dw Data_008_6619 ; id 39
    dw Data_008_661F ; id 40
    dw Data_008_6625 ; id 41
    dw Data_008_662E ; id 42
    dw Data_008_6637 ; id 43
    dw Data_008_6640 ; id 44
    dw Data_008_664A ; id 45
    dw Data_008_6653 ; id 46
    dw Data_008_665B ; id 47
    dw Data_008_665C ; id 48
    dw Data_008_6666 ; id 49
    dw Data_008_666F ; id 50
    dw Data_008_6675 ; id 51
    dw Data_008_667E ; id 52
    dw Data_008_6688 ; id 53
    dw Data_008_6690 ; id 54
    dw Data_008_669A ; id 55
    dw Data_008_66A4 ; id 56
    dw Data_008_66A9 ; id 57
    dw Data_008_66B1 ; id 58
    dw Data_008_66B9 ; id 59
    dw Data_008_66C1 ; id 60
    dw Data_008_66CA ; id 61
    dw Data_008_66D2 ; id 62
    dw Data_008_66D2 ; id 63
    dw Data_008_66DC ; id 64
    dw Data_008_66E4 ; id 65
    dw Data_008_66EE ; id 66
    dw Data_008_66F8 ; id 67
    dw Data_008_6700 ; id 68
    dw Data_008_670A ; id 69
    dw Data_008_6714 ; id 70
    dw Data_008_671E ; id 71
    dw Data_008_6728 ; id 72
    dw Data_008_672D ; id 73
    dw Data_008_6735 ; id 74
    dw Data_008_673C ; id 75
    dw Data_008_6742 ; id 76
    dw Data_008_674C ; id 77
    dw Data_008_6756 ; id 78
    dw Data_008_6760 ; id 79
    dw Data_008_6769 ; id 80
    dw Data_008_6773 ; id 81
    dw Data_008_677C ; id 82
    dw Data_008_6786 ; id 83
    dw Data_008_678E ; id 84
    dw Data_008_678E ; id 85
    dw Data_008_678E ; id 86
    dw Data_008_678E ; id 87
    dw Data_008_678E ; id 88
    dw Data_008_678E ; id 89
    dw Data_008_6793 ; id 90
    dw Data_008_6799 ; id 91
    dw Data_008_67A1 ; id 92
    dw Data_008_67A6 ; id 93
    dw Data_008_67AC ; id 94
    dw Data_008_67B3 ; id 95
    dw Data_008_67BB ; id 96
    dw Data_008_67C2 ; id 97
    dw Data_008_67CA ; id 98
    dw Data_008_67CA ; id 99
    dw Data_008_67CA ; id 100
    dw Data_008_67CA ; id 101
    dw Data_008_67CA ; id 102
    dw Data_008_67CA ; id 103
    dw Data_008_67CA ; id 104
    dw Data_008_67CA ; id 105
    dw Data_008_67CA ; id 106
    dw Data_008_67CA ; id 107
    dw Data_008_67CA ; id 108
    dw Data_008_67CA ; id 109
    dw Data_008_67CA ; id 110
    dw Data_008_67CA ; id 111

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_47F6::
StringTable_ItemDescriptions:: ; heuristic: string list; C0
Data_008_47F6:: ; address name
    dw Data_008_67CB ; id 0
    dw Data_008_67CB ; id 1
    dw Data_008_67F0 ; id 2
    dw Data_008_6815 ; id 3
    dw Data_008_6838 ; id 4
    dw Data_008_685D ; id 5
    dw Data_008_687F ; id 6
    dw Data_008_689D ; id 7
    dw Data_008_68AE ; id 8
    dw Data_008_68CD ; id 9
    dw Data_008_68E9 ; id 10
    dw Data_008_690B ; id 11
    dw Data_008_6931 ; id 12
    dw Data_008_6949 ; id 13
    dw Data_008_695A ; id 14
    dw Data_008_696B ; id 15
    dw Data_008_697C ; id 16
    dw Data_008_698D ; id 17
    dw Data_008_69A2 ; id 18
    dw Data_008_69B7 ; id 19
    dw Data_008_69D0 ; id 20
    dw Data_008_69F0 ; id 21
    dw Data_008_6A0E ; id 22
    dw Data_008_6A29 ; id 23
    dw Data_008_6A4B ; id 24
    dw Data_008_6A6B ; id 25
    dw Data_008_6A89 ; id 26
    dw Data_008_6AA6 ; id 27
    dw Data_008_6ABC ; id 28
    dw Data_008_6AD6 ; id 29
    dw Data_008_6AFA ; id 30
    dw Data_008_6B15 ; id 31
    dw Data_008_6B3A ; id 32
    dw Data_008_6B5C ; id 33
    dw Data_008_6B7D ; id 34
    dw Data_008_6B99 ; id 35
    dw Data_008_6BB8 ; id 36
    dw Data_008_6BDB ; id 37
    dw Data_008_6BFC ; id 38
    dw Data_008_6C1E ; id 39
    dw Data_008_6C3F ; id 40
    dw Data_008_6C63 ; id 41
    dw Data_008_6C80 ; id 42
    dw Data_008_6C9D ; id 43
    dw Data_008_6CBC ; id 44
    dw Data_008_6CDE ; id 45
    dw Data_008_6D02 ; id 46
    dw Data_008_6D19 ; id 47
    dw Data_008_6D19 ; id 48
    dw Data_008_6D2E ; id 49
    dw Data_008_6D52 ; id 50
    dw Data_008_6D75 ; id 51
    dw Data_008_6D92 ; id 52
    dw Data_008_6DB4 ; id 53
    dw Data_008_6DD4 ; id 54
    dw Data_008_6DF9 ; id 55
    dw Data_008_6E14 ; id 56
    dw Data_008_6E30 ; id 57
    dw Data_008_6E54 ; id 58
    dw Data_008_6E78 ; id 59
    dw Data_008_6E9D ; id 60
    dw Data_008_6EBE ; id 61
    dw Data_008_6ED5 ; id 62
    dw Data_008_6ED5 ; id 63
    dw Data_008_6EE0 ; id 64
    dw Data_008_6EF6 ; id 65
    dw Data_008_6F0C ; id 66
    dw Data_008_6F22 ; id 67
    dw Data_008_6F38 ; id 68
    dw Data_008_6F4A ; id 69
    dw Data_008_6F5C ; id 70
    dw Data_008_6F6E ; id 71
    dw Data_008_6F80 ; id 72
    dw Data_008_6F92 ; id 73
    dw Data_008_6FA4 ; id 74
    dw Data_008_6FB6 ; id 75
    dw Data_008_6FC9 ; id 76
    dw Data_008_6FED ; id 77
    dw Data_008_7010 ; id 78
    dw Data_008_7033 ; id 79
    dw Data_008_704F ; id 80
    dw Data_008_7071 ; id 81
    dw Data_008_7094 ; id 82
    dw Data_008_70B7 ; id 83
    dw Data_008_70C8 ; id 84
    dw Data_008_70C8 ; id 85
    dw Data_008_70C8 ; id 86
    dw Data_008_70C8 ; id 87
    dw Data_008_70C8 ; id 88
    dw Data_008_70C8 ; id 89
    dw Data_008_70D3 ; id 90
    dw Data_008_70F3 ; id 91
    dw Data_008_7113 ; id 92
    dw Data_008_712A ; id 93
    dw Data_008_7141 ; id 94
    dw Data_008_7162 ; id 95
    dw Data_008_7183 ; id 96
    dw Data_008_71A4 ; id 97
    dw Data_008_71C5 ; id 98
    dw Data_008_71D0 ; id 99
    dw Data_008_71D0 ; id 100
    dw Data_008_71D0 ; id 101
    dw Data_008_71D0 ; id 102
    dw Data_008_71D0 ; id 103
    dw Data_008_71D0 ; id 104
    dw Data_008_71D0 ; id 105
    dw Data_008_71D0 ; id 106
    dw Data_008_71D0 ; id 107
    dw Data_008_71D0 ; id 108
    dw Data_008_71D0 ; id 109
    dw Data_008_71D0 ; id 110
    dw Data_008_71D2 ; id 111

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_48D6::
StringTable_PersonalityNames:: ; heuristic: string list; C0
Data_008_48D6:: ; address name
    dw Data_008_71F7 ; id 0
    dw Data_008_7200 ; id 1
    dw Data_008_7206 ; id 2
    dw Data_008_720B ; id 3
    dw Data_008_7213 ; id 4
    dw Data_008_7219 ; id 5
    dw Data_008_7220 ; id 6
    dw Data_008_7229 ; id 7
    dw Data_008_7230 ; id 8
    dw Data_008_723A ; id 9
    dw Data_008_7244 ; id 10
    dw Data_008_724C ; id 11
    dw Data_008_7254 ; id 12
    dw Data_008_725B ; id 13
    dw Data_008_7264 ; id 14
    dw Data_008_726D ; id 15
    dw Data_008_7272 ; id 16
    dw Data_008_7279 ; id 17
    dw Data_008_7281 ; id 18
    dw Data_008_7287 ; id 19
    dw Data_008_728B ; id 20
    dw Data_008_7291 ; id 21
    dw Data_008_7295 ; id 22
    dw Data_008_729D ; id 23
    dw Data_008_72A4 ; id 24
    dw Data_008_72AD ; id 25
    dw Data_008_72B6 ; id 26

; E-0217 (derived: category list of StringCategories_08_4032; one pointer per wStringIndex)
; record: string
StringList_08_490C::
StringTable_ItemMenuMessages:: ; heuristic: string list; C0
Data_008_490C:: ; address name
    dw Data_008_72BB ; id 0
    dw Data_008_72C4 ; id 1
    dw Data_008_72D4 ; id 2
    dw Data_008_72EC ; id 3
    dw Data_008_7303 ; id 4
    dw Data_008_7319 ; id 5
    dw Data_008_731C ; id 6
    dw Data_008_7346 ; id 7
    dw Data_008_7357 ; id 8
    dw Data_008_7370 ; id 9
    dw Data_008_7389 ; id 10
    dw Data_008_7395 ; id 11
    dw Data_008_73AA ; id 12
    dw Data_008_73CA ; id 13
    dw Data_008_73DF ; id 14

Data_008_492A:: ; heuristic: string; C0
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ABCDEF", $F0

Data_008_493B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  DEBUG MODE        SELECT       1", $A3, "GOTO PROGRAM  2", $A3, "EDIT "
    db "         3", $A3, "AUTOMAP CHECK 4", $A3, "GRAFHICS      5", $A3, "SOUNDS     "
    db "   6", $A3, "BATTLE        7", $A3, "HAIGOU        8", $A3, "STAFF ROLL    9", $A3
    db "TOKUGI CHECK  A", $A3, "ENEMY TBL CHK B", $A3, "MESSAGE CHK  ?  RETURN  "
    db "?  ", $F0

Data_008_4A1A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ? EDIT ?                      WORLD", $A3, "          MAP X", $A3, "  "
    db "            Y", $A3, "          POS X", $A3, "              Y", $A3, "        "
    db "  NOT DATA"
    db $9F, $F0

Data_008_4A94:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MONSTER BGSD CHARA     ", $F0

Data_008_4AAC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ? AUTOMAP ?                   KEY  ", $A3, "          KEYID", $A3, "  "
    db "        LEVEL", $A3, "          POS X", $A3, "          POS Y", $A3, "        "
    db "  NOT DATA"
    db $9F, $F0

Data_008_4B26:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ? SOUND ?", $F1
    db $F1
    db "  BGM", $F1
    db "   SE", $F0

Data_008_4B3F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "? GOTOPRG ?", $F1
    db $F1
    db $F1
    db " PRGNO1", $F1
    db " PRGNO2", $F1
    db " PRGNO3", $F0

Data_008_4B65:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No more", $A4, $F0

Data_008_4B6E:: ; heuristic: string; C0
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

Data_008_4BBD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MonsterFarm", $F0

Data_008_4BC9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatLog", $F0

Data_008_4BD2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Main Street", $F0

Data_008_4BDE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door", $F0

Data_008_4BE9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reception", $F0

Data_008_4BF3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log's Navel", $F0

Data_008_4BFE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Home", $F0

Data_008_4C03:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stable", $F0

Data_008_4C0A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Vault", $F0

Data_008_4C10:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key Shop", $F0

Data_008_4C19:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Evaluator", $F0

Data_008_4C23:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Residences", $F0

Data_008_4C2E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starry "
    db $59, $F0

Data_008_4C37:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Family Rm.", $F0

Data_008_4C42:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Guy's Rm.", $F0

Data_008_4C4B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lady's Rm.", $F0

Data_008_4C55:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Library", $F0

Data_008_4C5D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Girl's Rm.", $F0

Data_008_4C67:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Christener", $F0

Data_008_4C72:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Background", $F0

Data_008_4C7D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Old man's", $F0

Data_008_4C86:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Medal man", $F0

Data_008_4C90:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tavern", $F0

Data_008_4C97:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Arena", $F0

Data_008_4C9D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatLog "
    db $58, $F0

Data_008_4CA8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Treetop", $F0

Data_008_4CB0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log's nut", $F0

Data_008_4CB9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log's view", $F0

Data_008_4CC3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Deck", $F0

Data_008_4CC8:: ; heuristic: string; C0
    db $17, $18, $F0

Data_008_4CCB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Desert "
    db $5C, $F0

Data_008_4CD4:: ; heuristic: string; C0
    db $14, $24, $2F, $2E, $24, $90, $57, $F0

Data_008_4CDC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kalka inn", $F0

Data_008_4CE6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Asiya inn", $F0

Data_008_4CF0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Asiya "
    db $57, $F0

Data_008_4CF8:: ; heuristic: string; C0
    db $0A, $36, $2C, $3C, $24, $90, $58, $F0

Data_008_4D00:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Desert King", $F0

Data_008_4D0C:: ; heuristic: string; C0
    db $17, $18, $F0

Data_008_4D0F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hideout", $F0

Data_008_4D17:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door "
    db $59, $F0

Data_008_4D24:: ; heuristic: string; C0
    db $0C, $24, $31, $24, $2F, $10, $24, $37, $28, $F0

Data_008_4D2E:: ; heuristic: string; C0
    db $0C, $24, $31, $24, $2F, $F0

Data_008_4D34:: ; heuristic: string; C0
    db $17, $32, $37, $90, $3C, $28, $37, $99, $F0

Data_008_4D3D:: ; heuristic: string; C0
    db $0D, $38, $31, $2A, $28, $32, $31, $F1

Data_008_4D45:: ; heuristic: string; C0
    db $1D, $35, $28, $24, $36, $38, $35, $3C, $F1

Data_008_4D4E:: ; heuristic: string; C0
    db $16, $2C, $35, $24, $2A, $28, $90, $15, $24, $2E, $28, $F1

Data_008_4D5A:: ; heuristic: string; C0
    db $20, $24, $37, $28, $35, $90, $5C, $F0

Data_008_4D62:: ; heuristic: string; C0
    db $22, $32, $2F, $27, $90, $57, $F0

Data_008_4D69:: ; heuristic: string; C0
    db $19, $37, $B5, $1B, $2C, $37, $3D, $90, $57, $F0

Data_008_4D73:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pt.Ritz pub", $F0

Data_008_4D7F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pt.Ritz inn", $F0

Data_008_4D8B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cape "
    db $5A, $F0

Data_008_4D92:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship ramp", $F0

Data_008_4D9C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship 1F", $F0

Data_008_4DA4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Volcano"
    db $5A, $01, $0F, $F0

Data_008_4DAF:: ; heuristic: string; C0
    db $1F, $32, $2F, $26, $24, $31, $32, $5A, $0B, $01, $0F, $F0

Data_008_4DBB:: ; heuristic: string; C0
    db $1F, $32, $2F, $26, $24, $31, $32, $5A, $0B, $02, $0F, $F0

Data_008_4DC7:: ; heuristic: string; C0
    db $15, $32, $32, $37, $90, $39, $24, $38, $2F, $37, $F0

Data_008_4DD2:: ; heuristic: string; C0
    db $19, $32, $2F, $32, $31, $24, $90, $57, $F0

Data_008_4DDB:: ; heuristic: string; C0
    db $19, $32, $2F, $32, $31, $24, $90, $2C, $31, $31, $F0

Data_008_4DE6:: ; heuristic: string; C0
    db $15, $2C, $2A, $2B, $37, $2B, $32, $38, $36, $28, $F0

Data_008_4DF1:: ; heuristic: string; C0
    db $15, $2C, $2A, $2B, $37, $2B, $32, $38, $36, $28, $F0

Data_008_4DFC:: ; heuristic: string; C0
    db $19, $2C, $31, $31, $24, $26, $2F, $28, $F0

Data_008_4E05:: ; heuristic: string; C0
    db $16, $28, $35, $30, $24, $2C, $27, $90, $5C, $F0

Data_008_4E0F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship 2F", $F0

Data_008_4E17:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship deck", $F0

Data_008_4E21:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Capt's qtr.", $F0

Data_008_4E2C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door "
    db $59, $F0

Data_008_4E39:: ; heuristic: string; C0
    db $17, $18, $F0

Data_008_4E3C:: ; heuristic: string; C0
    db $12, $26, $28, $90, $5C, $F0

Data_008_4E42:: ; heuristic: string; C0
    db $1C, $33, $35, $2C, $31, $2A, $F0

Data_008_4E49:: ; heuristic: string; C0
    db $17, $32, $35, $27, $28, $31, $90, $57, $F0

Data_008_4E52:: ; heuristic: string; C0
    db $17, $32, $35, $27, $28, $31, $90, $2C, $31, $31, $F0

Data_008_4E5D:: ; heuristic: string; C0
    db $17, $32, $35, $27, $28, $31, $90, $58, $F0

Data_008_4E66:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Norden jail", $F0

Data_008_4E72:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "N tunnel", $F0

Data_008_4E7B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Nofor "
    db $57, $F0

Data_008_4E83:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Nofor pub", $F0

Data_008_4E8D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Nofor inn", $F0

Data_008_4E97:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Border mine", $F0

Data_008_4EA3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine", $F0

Data_008_4EA8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine rm.", $F0

Data_008_4EB1:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine rm.", $F0

Data_008_4EBA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine rm.", $F0

Data_008_4EC3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gold mine", $F0

Data_008_4ECD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Weston "
    db $57, $F0

Data_008_4ED6:: ; heuristic: string; C0
    db $20, $28, $36, $37, $32, $31, $90, $2C, $31, $31, $F0

Data_008_4EE1:: ; heuristic: string; C0
    db $20, $28, $36, $37, $24, $31, $2C, $24, $90, $58, $F0

Data_008_4EEC:: ; heuristic: string; C0
    db $20, $28, $36, $37, $24, $31, $2C, $24, $90, $58, $F0

Data_008_4EF7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yuna's rm.", $F0

Data_008_4F01:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "S forest", $F0

Data_008_4F0A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Estria  "
    db $58, $F0

Data_008_4F14:: ; heuristic: string; C0
    db $0E, $36, $37, $35, $2C, $24, $90, $2C, $31, $31, $F0

Data_008_4F1F:: ; heuristic: string; C0
    db $0E, $36, $37, $35, $2C, $24, $90, $58, $F0

Data_008_4F28:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Queen's rm.", $F0

Data_008_4F33:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "N mountain", $F0

Data_008_4F3E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lake "
    db $5D, $90, $01, $0F, $F0

Data_008_4F48:: ; heuristic: string; C0
    db $15, $24, $2E, $28, $90, $5D, $90, $02, $0F, $F0

Data_008_4F52:: ; heuristic: string; C0
    db $15, $24, $2E, $28, $90, $5D, $90, $03, $0F, $F0

Data_008_4F5C:: ; heuristic: string; C0
    db $15, $24, $2E, $28, $90, $5D, $90, $04, $0F, $F0

Data_008_4F66:: ; heuristic: string; C0
    db $15, $24, $2E, $28, $90, $5D, $90, $05, $0F, $F0

Data_008_4F70:: ; heuristic: string; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_4F7D:: ; heuristic: string; C0
    db $17, $18, $F0

Data_008_4F80:: ; heuristic: string; C0
    db $0F, $2F, $32, $24, $37, $90, $5C, $F0

Data_008_4F88:: ; heuristic: string; C0
    db $0F, $2B, $38, $31, $37, $90, $57, $F0

Data_008_4F90:: ; heuristic: string; C0
    db $0F, $2B, $38, $31, $37, $90, $2C, $31, $31, $F0

Data_008_4F9A:: ; heuristic: string; C0
    db $1C, $24, $2A, $28, $90, $5D, $90, $01, $0F, $F0

Data_008_4FA4:: ; heuristic: string; C0
    db $1C, $24, $2A, $28, $90, $5D, $90, $02, $0F, $F0

Data_008_4FAE:: ; heuristic: string; C0
    db $1C, $24, $2A, $28, $90, $5D, $90, $03, $0F, $F0

Data_008_4FB8:: ; heuristic: string; C0
    db $1C, $24, $2A, $28, $90, $5D, $90, $04, $0F, $F0

Data_008_4FC2:: ; heuristic: string; C0
    db $1B, $32, $33, $28, $90, $25, $35, $2C, $27, $2A, $28, $F0

Data_008_4FCE:: ; heuristic: string; C0
    db $19, $28, $2C, $90, $57, $F0

Data_008_4FD4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pei inn", $F0

Data_008_4FDC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "W mountain", $F0

Data_008_4FE7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "W tunnel", $F0

Data_008_4FF0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano "
    db $57, $F0

Data_008_4FF9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano inn", $F0

Data_008_5004:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano pub", $F0

Data_008_500F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano "
    db $58, $F0

Data_008_5018:: ; heuristic: string; C0
    db $1B, $32, $33, $28, $90, $25, $35, $2C, $27, $2A, $28, $F0

Data_008_5024:: ; heuristic: string; C0
    db $1C, $30, $24, $2F, $2F, $90, $5A, $F0

Data_008_502C:: ; heuristic: string; C0
    db $1C, $30, $24, $2F, $2F, $90, $5A, $90, $0B, $01, $0F, $F0

Data_008_5038:: ; heuristic: string; C0
    db $1C, $30, $24, $2F, $2F, $90, $5A, $90, $0B, $02, $0F, $F0

Data_008_5044:: ; heuristic: string; C0
    db $0B, $32, $36, $36, $90, $1B, $30, $B5, $F0

Data_008_504D:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $90, $5D, $90, $01, $0F, $F0

Data_008_5057:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $90, $5D, $90, $02, $0F, $F0

Data_008_5061:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $90, $5D, $90, $03, $0F, $F0

Data_008_506B:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $90, $5D, $90, $04, $0F, $F0

Data_008_5075:: ; heuristic: string; C0
    db $1C, $24, $2A, $28, $90, $5D, $F0

Data_008_507C:: ; heuristic: string; C0
    db $0D, $28, $24, $27, $90, $58, $F0

Data_008_5083:: ; heuristic: string; C0
    db $0C, $24, $37, $2B, $28, $27, $35, $24, $2F, $F0

Data_008_508D:: ; heuristic: string; C0
    db $0C, $32, $35, $35, $2C, $27, $32, $35, $F0

Data_008_5096:: ; heuristic: string; C0
    db $16, $32, $35, $2A, $38, $28, $F0

Data_008_509D:: ; heuristic: string; C0
    db $0C, $28, $30, $28, $37, $28, $35, $3C, $F0

Data_008_50A6:: ; heuristic: string; C0
    db $16, $38, $36, $2C, $26, $90, $35, $30, $B5, $F0

Data_008_50B0:: ; heuristic: string; C0
    db $0C, $32, $35, $35, $2C, $27, $32, $35, $F0

Data_008_50B9:: ; heuristic: string; C0
    db $0D, $28, $24, $27, $90, $35, $30, $B5, $F0

Data_008_50C2:: ; heuristic: string; C0
    db $17, $32, $35, $37, $2B, $90, $59, $F0

Data_008_50CA:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $90, $58, $F0

Data_008_50D2:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $01, $0F, $F0

Data_008_50DD:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $0B, $01, $0F, $F0

Data_008_50E9:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $0B, $02, $0F, $F0

Data_008_50F5:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $0B, $03, $0F, $F0

Data_008_5101:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $0B, $04, $0F, $F0

Data_008_510D:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $0B, $05, $0F, $F0

Data_008_5119:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $90, $58
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " B6F", $F0

Data_008_5125:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon hall", $F0

Data_008_5130:: ; heuristic: string; C0
    db $17, $18, $F0

Data_008_5133:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door "
    db $59, $F0

Data_008_5140:: ; heuristic: string; C0
    db $17, $18, $F0

Data_008_5143:: ; heuristic: string; C0
    db $15, $2C, $30, $25, $32, $90, $5C, $F0

Data_008_514B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stairway", $F0

Data_008_5154:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Darck Manor", $F0

Data_008_5160:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gallery", $F0

Data_008_5168:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door "
    db $59, $F0

Data_008_5175:: ; heuristic: string; C0
    db $17, $18, $F0

Data_008_5178:: ; heuristic: string; C0
    db $0E, $2F, $39, $28, $31, $90, $5C, $F0

Data_008_5180:: ; heuristic: string; C0
    db $0E, $2F, $39, $28, $31, $90, $57, $F0

Data_008_5188:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "W forest", $F0

Data_008_5191:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lookout", $F0

Data_008_5199:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summit", $F0

Data_008_51A0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mt. base", $F0

Data_008_51A9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PlatinumMt.", $F0

Data_008_51B5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door "
    db $59, $F0

Data_008_51C2:: ; heuristic: string; C0
    db $15, $32, $31, $28, $2F, $3C, $90, $5C, $F0

Data_008_51CB:: ; heuristic: string; C0
    db $14, $2C, $35, $24, $2F, $90, $15, $24, $25, $F0

Data_008_51D5:: ; heuristic: string; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_51E2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lab B1F", $F0

Data_008_51EA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lab B2F", $F0

Data_008_51F2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lab B3F", $F0

Data_008_51FA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Barrel rm.", $F0

Data_008_5205:: ; heuristic: string; C0
    db $17, $18, $F0

Data_008_5208:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Traveler "
    db $5C, $F0

Data_008_5213:: ; heuristic: string; C0
    db $16, $2C, $24, $2A, $28, $31, $90, $57, $F0

Data_008_521C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Travel hut", $F0

Data_008_5227:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "N forest", $F0

Data_008_5230:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inn", $F0

Data_008_5234:: ; heuristic: string; C0
    db $5D, $90, $36, $38, $30, $30, $2C, $37, $F0

Data_008_523D:: ; heuristic: string; C0
    db $18, $2F, $27, $90, $5D, $90, $01, $0F, $F0

Data_008_5246:: ; heuristic: string; C0
    db $18, $2F, $27, $90, $5D, $90, $02, $0F, $F0

Data_008_524F:: ; heuristic: string; C0
    db $18, $2F, $27, $90, $5D, $90, $03, $0F, $F0

Data_008_5258:: ; heuristic: string; C0
    db $18, $2F, $27, $90, $5D, $90, $04, $0F, $F0

Data_008_5261:: ; heuristic: string; C0
    db $18, $2F, $27, $90, $5D, $90, $05, $0F, $F0

Data_008_526A:: ; heuristic: string; C0
    db $18, $2F, $27, $90, $5D, $90, $06, $0F, $F0

Data_008_5273:: ; heuristic: string; C0
    db $18, $2F, $27, $90, $5D, $90, $07, $0F, $F0

Data_008_527C:: ; heuristic: string; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_5289:: ; heuristic: string; C0
    db $17, $18, $F0

Data_008_528C:: ; heuristic: string; C0
    db $19, $32, $3A, $28, $35, $90, $5C, $F0

Data_008_5294:: ; heuristic: string; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $01, $0F, $F0

Data_008_529F:: ; heuristic: string; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $02, $0F, $F0

Data_008_52AA:: ; heuristic: string; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $03, $0F, $F0

Data_008_52B5:: ; heuristic: string; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $04, $0F, $F0

Data_008_52C0:: ; heuristic: string; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $05, $0F, $F0

Data_008_52CB:: ; heuristic: string; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $06, $0F, $F0

Data_008_52D6:: ; heuristic: string; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $07, $0F, $F0

Data_008_52E1:: ; heuristic: string; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_52EE:: ; heuristic: string; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5C, $F0

Data_008_52F7:: ; heuristic: string; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $01, $0F, $F0

Data_008_5303:: ; heuristic: string; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $02, $0F, $F0

Data_008_530F:: ; heuristic: string; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $03, $0F, $F0

Data_008_531B:: ; heuristic: string; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $04, $0F, $F0

Data_008_5327:: ; heuristic: string; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $05, $0F, $F0

Data_008_5333:: ; heuristic: string; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $06, $0F, $F0

Data_008_533F:: ; heuristic: string; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $07, $0F, $F0

Data_008_534B:: ; heuristic: string; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_5358:: ; heuristic: string; C0
    db $1C, $32, $38, $2F, $90, $5C, $F0

Data_008_535F:: ; heuristic: string; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $01, $0F, $F0

Data_008_5369:: ; heuristic: string; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $02, $0F, $F0

Data_008_5373:: ; heuristic: string; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $03, $0F, $F0

Data_008_537D:: ; heuristic: string; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $04, $0F, $F0

Data_008_5387:: ; heuristic: string; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $05, $0F, $F0

Data_008_5391:: ; heuristic: string; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $06, $0F, $F0

Data_008_539B:: ; heuristic: string; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $07, $0F, $F0

Data_008_53A5:: ; heuristic: string; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_53B2:: ; heuristic: string; C0
    db $17, $18, $F0

Data_008_53B5:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_008_53BB:: ; heuristic: string; C0
    db $0D, $35, $24, $2A, $32, $31, $F0

Data_008_53C2:: ; heuristic: string; C0
    db $0B, $28, $24, $36, $37, $F0

Data_008_53C8:: ; heuristic: string; C0
    db $0B, $2C, $35, $27, $F0

Data_008_53CD:: ; heuristic: string; C0
    db $19, $2F, $24, $31, $37, $F0

Data_008_53D3:: ; heuristic: string; C0
    db $0B, $38, $2A, $F0

Data_008_53D7:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $F0

Data_008_53DD:: ; heuristic: string; C0
    db $23, $32, $30, $25, $2C, $28, $F0

Data_008_53E4:: ; heuristic: string; C0
    db $16, $24, $37, $28, $35, $2C, $24, $2F, $F0

Data_008_53ED:: ; heuristic: string; C0
    db $20, $24, $37, $28, $35, $F0

Data_008_53F3:: ; heuristic: string; C0
    db $98, $98, $98, $98, $F0

Data_008_53F8:: ; heuristic: string; C0
    db $F0

Data_008_53F9:: ; heuristic: string; C0
    db $0D, $35, $24, $2E, $1C, $2F, $2C, $30, $28, $F0

Data_008_5403:: ; heuristic: string; C0
    db $1C, $33, $32, $37, $1C, $2F, $2C, $30, $28, $F0

Data_008_540D:: ; heuristic: string; C0
    db $20, $2C, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_008_5417:: ; heuristic: string; C0
    db $1D, $35, $28, $28, $1C, $2F, $2C, $30, $28, $F0

Data_008_5421:: ; heuristic: string; C0
    db $1C, $31, $24, $2C, $2F, $3C, $F0

Data_008_5428:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $17, $2C, $37, $28, $F0

Data_008_5432:: ; heuristic: string; C0
    db $0B, $24, $25, $25, $2F, $28, $F0

Data_008_5439:: ; heuristic: string; C0
    db $0B, $32, $3B, $1C, $2F, $2C, $30, $28, $F0

Data_008_5442:: ; heuristic: string; C0
    db $19, $28, $24, $35, $2F, $10, $28, $2F, $F0

Data_008_544B:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_008_5451:: ; heuristic: string; C0
    db $11, $28, $24, $2F, $28, $35, $F0

Data_008_5458:: ; heuristic: string; C0
    db $0F, $24, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_008_5462:: ; heuristic: string; C0
    db $1B, $32, $26, $2E, $1C, $2F, $2C, $30, $28, $F0

Data_008_546C:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $0B, $32, $35, $2A, $F0

Data_008_5476:: ; heuristic: string; C0
    db $1C, $2F, $24, $25, $25, $2C, $37, $F0

Data_008_547E:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_008_5488:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $3C, $F0

Data_008_548F:: ; heuristic: string; C0
    db $16, $28, $37, $24, $25, $25, $2F, $28, $F0

Data_008_5498:: ; heuristic: string; C0
    db $1C, $33, $32, $37, $14, $2C, $31, $2A, $F0

Data_008_54A1:: ; heuristic: string; C0
    db $1D, $35, $32, $33, $2C, $26, $10, $28, $2F, $F0

Data_008_54AB:: ; heuristic: string; C0
    db $16, $2C, $30, $28, $1C, $2F, $2C, $30, $28, $F0

Data_008_54B5:: ; heuristic: string; C0
    db $11, $24, $2F, $32, $1C, $2F, $2C, $30, $28, $F0

Data_008_54BF:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $14, $2C, $31, $2A, $F0

Data_008_54C9:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $1C, $2F, $2C, $30, $28, $F0

Data_008_54D3:: ; heuristic: string; C0
    db $10, $35, $24, $31, $1C, $2F, $2C, $30, $28, $F0

Data_008_54DD:: ; heuristic: string; C0
    db $20, $32, $31, $27, $28, $35, $0E, $2A, $2A, $F0

Data_008_54E7:: ; heuristic: string; C0
    db $0B, $38, $37, $26, $2B, $F0

Data_008_54ED:: ; heuristic: string; C0
    db $98, $F0

Data_008_54EF:: ; heuristic: string; C0
    db $0D, $35, $24, $2A, $32, $31, $14, $2C, $27, $F0

Data_008_54F9:: ; heuristic: string; C0
    db $1D, $32, $35, $37, $35, $24, $2A, $32, $31, $F0

Data_008_5503:: ; heuristic: string; C0
    db $19, $37, $28, $35, $24, $31, $32, $27, $F0

Data_008_550C:: ; heuristic: string; C0
    db $10, $24, $36, $2A, $32, $31, $F0

Data_008_5513:: ; heuristic: string; C0
    db $0F, $24, $2C, $35, $3C, $0D, $35, $24, $2E, $F0

Data_008_551D:: ; heuristic: string; C0
    db $15, $2C, $3D, $24, $35, $27, $16, $24, $31, $F0

Data_008_5527:: ; heuristic: string; C0
    db $19, $32, $2C, $36, $32, $31, $2A, $32, $31, $F0

Data_008_5531:: ; heuristic: string; C0
    db $1C, $3A, $32, $35, $27, $2A, $32, $31, $F0

Data_008_553A:: ; heuristic: string; C0
    db $0D, $35, $3C, $2A, $32, $31, $F0

Data_008_5541:: ; heuristic: string; C0
    db $0D, $35, $24, $2A, $32, $31, $F0

Data_008_5548:: ; heuristic: string; C0
    db $16, $2C, $31, $2C, $0D, $35, $24, $2E, $F0

Data_008_5551:: ; heuristic: string; C0
    db $16, $24, $27, $0D, $35, $24, $2A, $32, $31, $F0

Data_008_555B:: ; heuristic: string; C0
    db $1B, $24, $3C, $25, $38, $35, $31, $F0

Data_008_5563:: ; heuristic: string; C0
    db $0C, $2B, $24, $30, $28, $2F, $2A, $32, $31, $F0

Data_008_556D:: ; heuristic: string; C0
    db $15, $2C, $3D, $24, $35, $27, $0F, $2F, $3C, $F0

Data_008_5577:: ; heuristic: string; C0
    db $0A, $31, $27, $35, $28, $24, $2F, $F0

Data_008_557F:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $0C, $32, $25, $35, $24, $F0

Data_008_5589:: ; heuristic: string; C0
    db $1F, $24, $30, $33, $2C, $35, $38, $36, $F0

Data_008_5592:: ; heuristic: string; C0
    db $1C, $31, $24, $2E, $28, $0B, $24, $37, $F0

Data_008_559B:: ; heuristic: string; C0
    db $1C, $33, $2C, $2E, $28, $35, $32, $38, $36, $F0

Data_008_55A5:: ; heuristic: string; C0
    db $10, $35, $28, $24, $37, $0D, $35, $24, $2E, $F0

Data_008_55AF:: ; heuristic: string; C0
    db $0C, $35, $28, $36, $37, $33, $28, $31, $37, $F0

Data_008_55B9:: ; heuristic: string; C0
    db $20, $2C, $31, $2A, $1C, $31, $24, $2E, $28, $F0

Data_008_55C3:: ; heuristic: string; C0
    db $0C, $32, $24, $37, $32, $2F, $F0

Data_008_55CA:: ; heuristic: string; C0
    db $18, $35, $32, $26, $2B, $2C, $F0

Data_008_55D1:: ; heuristic: string; C0
    db $0B, $24, $37, $37, $2F, $28, $1B, $28, $3B, $F0

Data_008_55DB:: ; heuristic: string; C0
    db $1C, $2E, $3C, $0D, $35, $24, $2A, $32, $31, $F0

Data_008_55E5:: ; heuristic: string; C0
    db $1C, $28, $35, $33, $28, $31, $37, $2C, $24, $F0

Data_008_55EF:: ; heuristic: string; C0
    db $0D, $2C, $39, $2C, $31, $28, $2A, $32, $31, $F0

Data_008_55F9:: ; heuristic: string; C0
    db $18, $35, $2F, $2C, $2A, $32, $31, $F0

Data_008_5601:: ; heuristic: string; C0
    db $10, $2C, $2A, $24, $0D, $35, $24, $26, $32, $F0

Data_008_560B:: ; heuristic: string; C0
    db $98, $F0

Data_008_560D:: ; heuristic: string; C0
    db $1D, $32, $31, $2A, $38, $28, $2F, $2F, $24, $F0

Data_008_5617:: ; heuristic: string; C0
    db $0A, $2F, $30, $2C, $35, $24, $2D, $F0

Data_008_561F:: ; heuristic: string; C0
    db $0C, $24, $37, $0F, $2F, $3C, $F0

Data_008_5626:: ; heuristic: string; C0
    db $19, $2C, $2F, $2F, $32, $3A, $1B, $24, $37, $F0

Data_008_5630:: ; heuristic: string; C0
    db $1C, $24, $26, $26, $28, $35, $F0

Data_008_5637:: ; heuristic: string; C0
    db $10, $38, $2F, $33, $0B, $28, $24, $36, $37, $F0

Data_008_5641:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $2F, $35, $32, $32, $F0

Data_008_564A:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $0B, $28, $24, $36, $37, $F0

Data_008_5654:: ; heuristic: string; C0
    db $0B, $28, $24, $39, $28, $35, $31, $F0

Data_008_565C:: ; heuristic: string; C0
    db $0A, $31, $37, $25, $28, $24, $35, $F0

Data_008_5664:: ; heuristic: string; C0
    db $1C, $38, $33, $28, $35, $1D, $28, $31, $F0

Data_008_566D:: ; heuristic: string; C0
    db $12, $35, $32, $31, $1D, $38, $35, $37, $F0

Data_008_5676:: ; heuristic: string; C0
    db $16, $32, $30, $30, $32, $31, $2D, $24, $F0

Data_008_567F:: ; heuristic: string; C0
    db $11, $24, $30, $30, $28, $35, $16, $24, $31, $F0

Data_008_5689:: ; heuristic: string; C0
    db $10, $35, $2C, $3D, $3D, $2F, $3C, $F0

Data_008_5691:: ; heuristic: string; C0
    db $22, $28, $37, $2C, $F0

Data_008_5696:: ; heuristic: string; C0
    db $0A, $35, $35, $32, $3A, $0D, $32, $2A, $F0

Data_008_569F:: ; heuristic: string; C0
    db $17, $32, $26, $37, $32, $14, $2C, $31, $2A, $F0

Data_008_56A9:: ; heuristic: string; C0
    db $0B, $28, $24, $36, $37, $17, $2C, $37, $28, $F0

Data_008_56B3:: ; heuristic: string; C0
    db $16, $24, $27, $10, $32, $33, $2B, $28, $35, $F0

Data_008_56BD:: ; heuristic: string; C0
    db $0F, $24, $2C, $35, $3C, $1B, $24, $37, $F0

Data_008_56C6:: ; heuristic: string; C0
    db $1E, $31, $2C, $26, $32, $35, $31, $F0

Data_008_56CE:: ; heuristic: string; C0
    db $10, $32, $24, $37, $28, $2A, $32, $31, $F0

Data_008_56D7:: ; heuristic: string; C0
    db $20, $2C, $2F, $27, $0A, $33, $28, $F0

Data_008_56DF:: ; heuristic: string; C0
    db $1D, $35, $38, $30, $33, $28, $37, $28, $35, $F0

Data_008_56E9:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $15, $28, $32, $F0

Data_008_56F1:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $11, $32, $35, $31, $F0

Data_008_56FA:: ; heuristic: string; C0
    db $16, $24, $27, $0C, $24, $37, $F0

Data_008_5701:: ; heuristic: string; C0
    db $0B, $2C, $2A, $0E, $3C, $28, $F0

Data_008_5708:: ; heuristic: string; C0
    db $10, $32, $35, $24, $2A, $32, $F0

Data_008_570F:: ; heuristic: string; C0
    db $0C, $24, $37, $16, $24, $2A, $28, $F0

Data_008_5717:: ; heuristic: string; C0
    db $0D, $38, $30, $25, $2C, $35, $24, $F0

Data_008_571F:: ; heuristic: string; C0
    db $98, $F0

Data_008_5721:: ; heuristic: string; C0
    db $19, $2C, $26, $2E, $3C, $F0

Data_008_5727:: ; heuristic: string; C0
    db $20, $3C, $39, $28, $35, $31, $F0

Data_008_572E:: ; heuristic: string; C0
    db $0B, $38, $2F, $2F, $0B, $2C, $35, $27, $F0

Data_008_5737:: ; heuristic: string; C0
    db $0F, $2F, $32, $35, $24, $2D, $24, $3C, $F0

Data_008_5740:: ; heuristic: string; C0
    db $0D, $38, $26, $2E, $14, $2C, $37, $28, $F0

Data_008_5749:: ; heuristic: string; C0
    db $16, $24, $27, $19, $28, $26, $2E, $28, $35, $F0

Data_008_5753:: ; heuristic: string; C0
    db $16, $24, $27, $1B, $24, $39, $28, $31, $F0

Data_008_575C:: ; heuristic: string; C0
    db $16, $2C, $36, $37, $3C, $20, $2C, $31, $2A, $F0

Data_008_5766:: ; heuristic: string; C0
    db $0A, $34, $38, $24, $11, $24, $3A, $2E, $F0

Data_008_576F:: ; heuristic: string; C0
    db $0D, $35, $24, $26, $2E, $3C, $F0

Data_008_5776:: ; heuristic: string; C0
    db $14, $2C, $37, $28, $11, $24, $3A, $2E, $F0

Data_008_577F:: ; heuristic: string; C0
    db $0B, $2C, $2A, $1B, $32, $32, $36, $37, $F0

Data_008_5788:: ; heuristic: string; C0
    db $1C, $37, $38, $25, $0B, $2C, $35, $27, $F0

Data_008_5791:: ; heuristic: string; C0
    db $15, $24, $31, $27, $18, $3A, $2F, $F0

Data_008_5799:: ; heuristic: string; C0
    db $16, $24, $27, $10, $32, $32, $36, $28, $F0

Data_008_57A2:: ; heuristic: string; C0
    db $16, $24, $27, $0C, $32, $31, $27, $32, $35, $F0

Data_008_57AC:: ; heuristic: string; C0
    db $0E, $30, $3C, $38, $F0

Data_008_57B1:: ; heuristic: string; C0
    db $0B, $2F, $2C, $3D, $3D, $24, $35, $27, $3C, $F0

Data_008_57BB:: ; heuristic: string; C0
    db $19, $2B, $32, $28, $31, $2C, $3B, $F0

Data_008_57C3:: ; heuristic: string; C0
    db $23, $24, $33, $0B, $2C, $35, $27, $F0

Data_008_57CB:: ; heuristic: string; C0
    db $10, $24, $35, $38, $27, $2C, $24, $31, $F0

Data_008_57D4:: ; heuristic: string; C0
    db $20, $2B, $2C, $33, $0B, $2C, $35, $27, $F0

Data_008_57DD:: ; heuristic: string; C0
    db $0F, $38, $31, $2E, $3C, $0B, $2C, $35, $27, $F0

Data_008_57E7:: ; heuristic: string; C0
    db $1B, $24, $2C, $31, $11, $24, $3A, $2E, $F0

Data_008_57F0:: ; heuristic: string; C0
    db $0A, $3D, $38, $35, $2C, $2F, $28, $F0

Data_008_57F8:: ; heuristic: string; C0
    db $1C, $2B, $24, $31, $37, $24, $2E, $F0

Data_008_5800:: ; heuristic: string; C0
    db $0C, $35, $24, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_008_580A:: ; heuristic: string; C0
    db $98, $F0

Data_008_580C:: ; heuristic: string; C0
    db $16, $24, $27, $19, $2F, $24, $31, $37, $F0

Data_008_5815:: ; heuristic: string; C0
    db $0F, $2C, $35, $28, $20, $28, $28, $27, $F0

Data_008_581E:: ; heuristic: string; C0
    db $0F, $2F, $32, $35, $24, $16, $24, $31, $F0

Data_008_5827:: ; heuristic: string; C0
    db $20, $2C, $31, $2A, $1D, $35, $28, $28, $F0

Data_008_5830:: ; heuristic: string; C0
    db $0C, $24, $26, $37, $2C, $0B, $24, $2F, $2F, $F0

Data_008_583A:: ; heuristic: string; C0
    db $10, $38, $2F, $33, $33, $2F, $28, $F0

Data_008_5842:: ; heuristic: string; C0
    db $1D, $32, $24, $27, $36, $37, $32, $32, $2F, $F0

Data_008_584C:: ; heuristic: string; C0
    db $0A, $30, $25, $28, $35, $20, $28, $28, $27, $F0

Data_008_5856:: ; heuristic: string; C0
    db $1C, $2F, $38, $35, $33, $28, $35, $32, $31, $F0

Data_008_5860:: ; heuristic: string; C0
    db $1C, $37, $38, $25, $36, $38, $26, $2E, $F0

Data_008_5869:: ; heuristic: string; C0
    db $18, $31, $2C, $32, $31, $32, $F0

Data_008_5870:: ; heuristic: string; C0
    db $0D, $24, $31, $26, $28, $1F, $28, $2A, $2C, $F0

Data_008_587A:: ; heuristic: string; C0
    db $1D, $35, $28, $28, $0B, $32, $3C, $F0

Data_008_5882:: ; heuristic: string; C0
    db $0D, $28, $39, $2C, $33, $2C, $31, $28, $F0

Data_008_588B:: ; heuristic: string; C0
    db $0F, $24, $26, $28, $1D, $35, $28, $28, $F0

Data_008_5894:: ; heuristic: string; C0
    db $11, $28, $35, $25, $16, $24, $31, $F0

Data_008_589C:: ; heuristic: string; C0
    db $0B, $28, $24, $31, $16, $24, $31, $F0

Data_008_58A4:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $1C, $28, $28, $27, $F0

Data_008_58AD:: ; heuristic: string; C0
    db $16, $24, $31, $0E, $24, $37, $28, $35, $F0

Data_008_58B6:: ; heuristic: string; C0
    db $1C, $31, $24, $33, $33, $28, $35, $F0

Data_008_58BE:: ; heuristic: string; C0
    db $10, $2B, $32, $36, $1D, $35, $28, $28, $F0

Data_008_58C7:: ; heuristic: string; C0
    db $1B, $32, $36, $28, $39, $2C, $31, $28, $F0

Data_008_58D0:: ; heuristic: string; C0
    db $0E, $2A, $27, $35, $24, $26, $2C, $2F, $F0

Data_008_58D9:: ; heuristic: string; C0
    db $20, $24, $35, $38, $25, $32, $38, $F0

Data_008_58E1:: ; heuristic: string; C0
    db $20, $24, $37, $24, $25, $32, $38, $F0

Data_008_58E9:: ; heuristic: string; C0
    db $0E, $2A, $2A, $33, $2F, $24, $37, $32, $31, $F0

Data_008_58F3:: ; heuristic: string; C0
    db $0F, $32, $32, $11, $28, $35, $32, $F0

Data_008_58FB:: ; heuristic: string; C0
    db $98, $F0

Data_008_58FD:: ; heuristic: string; C0
    db $10, $2C, $24, $31, $37, $1C, $2F, $38, $2A, $F0

Data_008_5907:: ; heuristic: string; C0
    db $0C, $24, $37, $24, $33, $2C, $2F, $24, $F0

Data_008_5910:: ; heuristic: string; C0
    db $10, $32, $33, $2B, $28, $26, $24, $27, $24, $F0

Data_008_591A:: ; heuristic: string; C0
    db $0B, $38, $37, $37, $28, $35, $29, $2F, $3C, $F0

Data_008_5924:: ; heuristic: string; C0
    db $20, $28, $28, $27, $0B, $38, $2A, $F0

Data_008_592C:: ; heuristic: string; C0
    db $10, $2C, $24, $31, $37, $20, $32, $35, $30, $F0

Data_008_5936:: ; heuristic: string; C0
    db $15, $2C, $33, $36, $3C, $F0

Data_008_593C:: ; heuristic: string; C0
    db $1C, $37, $24, $2A, $0B, $38, $2A, $F0

Data_008_5944:: ; heuristic: string; C0
    db $19, $3C, $38, $35, $32, $F0

Data_008_594A:: ; heuristic: string; C0
    db $0A, $35, $30, $3C, $0A, $31, $37, $F0

Data_008_5952:: ; heuristic: string; C0
    db $10, $32, $11, $32, $33, $33, $28, $35, $F0

Data_008_595B:: ; heuristic: string; C0
    db $1D, $24, $2C, $2F, $0E, $24, $37, $28, $35, $F0

Data_008_5965:: ; heuristic: string; C0
    db $0A, $35, $30, $32, $35, $19, $28, $27, $28, $F0

Data_008_596F:: ; heuristic: string; C0
    db $0E, $3C, $28, $27, $28, $35, $F0

Data_008_5976:: ; heuristic: string; C0
    db $10, $2C, $24, $31, $37, $16, $32, $37, $2B, $F0

Data_008_5980:: ; heuristic: string; C0
    db $0D, $35, $32, $2F, $2F, $F0

Data_008_5986:: ; heuristic: string; C0
    db $0A, $35, $30, $3C, $0C, $35, $24, $25, $F0

Data_008_598F:: ; heuristic: string; C0
    db $16, $24, $27, $11, $32, $35, $31, $28, $37, $F0

Data_008_5999:: ; heuristic: string; C0
    db $0B, $28, $2F, $3D, $28, $25, $38, $25, $F0

Data_008_59A2:: ; heuristic: string; C0
    db $20, $24, $35, $16, $24, $31, $37, $2C, $36, $F0

Data_008_59AC:: ; heuristic: string; C0
    db $11, $32, $35, $31, $0B, $28, $28, $37, $F0

Data_008_59B5:: ; heuristic: string; C0
    db $1C, $2C, $26, $2E, $2F, $28, $35, $F0

Data_008_59BD:: ; heuristic: string; C0
    db $0A, $35, $30, $32, $35, $33, $2C, $32, $31, $F0

Data_008_59C7:: ; heuristic: string; C0
    db $0D, $2C, $2A, $36, $37, $28, $35, $F0

Data_008_59CF:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $24, $35, $24, $26, $2B, $F0

Data_008_59D9:: ; heuristic: string; C0
    db $16, $38, $2F, $37, $2C, $0E, $3C, $28, $36, $F0

Data_008_59E3:: ; heuristic: string; C0
    db $98, $F0

Data_008_59E5:: ; heuristic: string; C0
    db $19, $2C, $3B, $3C, $F0

Data_008_59EA:: ; heuristic: string; C0
    db $16, $28, $27, $38, $36, $24, $0E, $3C, $28, $F0

Data_008_59F4:: ; heuristic: string; C0
    db $0A, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_008_59FC:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $2C, $37, $28, $F0

Data_008_5A05:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $0E, $3C, $28, $F0

Data_008_5A0D:: ; heuristic: string; C0
    db $0E, $3C, $28, $0B, $24, $2F, $2F, $F0

Data_008_5A15:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $1B, $2C, $27, $28, $35, $F0

Data_008_5A1F:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $0B, $28, $24, $36, $37, $F0

Data_008_5A29:: ; heuristic: string; C0
    db $0B, $38, $25, $25, $2F, $28, $30, $32, $31, $F0

Data_008_5A33:: ; heuristic: string; C0
    db $01, $0E, $3C, $28, $0C, $2F, $32, $3A, $31, $F0

Data_008_5A3D:: ; heuristic: string; C0
    db $10, $35, $28, $30, $2F, $2C, $31, $F0

Data_008_5A45:: ; heuristic: string; C0
    db $0A, $35, $26, $0D, $28, $30, $32, $31, $F0

Data_008_5A4E:: ; heuristic: string; C0
    db $15, $2C, $32, $31, $28, $3B, $F0

Data_008_5A55:: ; heuristic: string; C0
    db $10, $32, $24, $37, $11, $32, $35, $31, $F0

Data_008_5A5E:: ; heuristic: string; C0
    db $18, $35, $26, $F0

Data_008_5A62:: ; heuristic: string; C0
    db $18, $2A, $35, $28, $F0

Data_008_5A67:: ; heuristic: string; C0
    db $10, $24, $37, $28, $10, $38, $24, $35, $27, $F0

Data_008_5A71:: ; heuristic: string; C0
    db $0C, $2B, $32, $33, $0C, $2F, $32, $3A, $31, $F0

Data_008_5A7B:: ; heuristic: string; C0
    db $0B, $32, $36, $36, $1D, $35, $32, $2F, $2F, $F0

Data_008_5A85:: ; heuristic: string; C0
    db $10, $35, $28, $31, $27, $24, $2F, $F0

Data_008_5A8D:: ; heuristic: string; C0
    db $0A, $2E, $38, $25, $24, $35, $F0

Data_008_5A94:: ; heuristic: string; C0
    db $16, $24, $27, $14, $31, $2C, $2A, $2B, $37, $F0

Data_008_5A9E:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $20, $28, $2F, $2F, $F0

Data_008_5AA7:: ; heuristic: string; C0
    db $10, $2C, $2A, $24, $31, $37, $28, $36, $F0

Data_008_5AB0:: ; heuristic: string; C0
    db $0C, $28, $31, $37, $24, $36, $24, $38, $35, $F0

Data_008_5ABA:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $0A, $35, $30, $32, $35, $F0

Data_008_5AC4:: ; heuristic: string; C0
    db $13, $24, $30, $2C, $35, $38, $36, $F0

Data_008_5ACC:: ; heuristic: string; C0
    db $0D, $38, $35, $35, $24, $31, $F0

Data_008_5AD3:: ; heuristic: string; C0
    db $1D, $2C, $37, $24, $31, $2C, $36, $F0

Data_008_5ADB:: ; heuristic: string; C0
    db $15, $24, $30, $33, $10, $28, $31, $2C, $28, $F0

Data_008_5AE5:: ; heuristic: string; C0
    db $98, $F0

Data_008_5AE7:: ; heuristic: string; C0
    db $1C, $33, $32, $32, $2E, $3C, $F0

Data_008_5AEE:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $2F, $2A, $32, $31, $F0

Data_008_5AF7:: ; heuristic: string; C0
    db $19, $38, $37, $35, $28, $19, $38, $33, $F0

Data_008_5B00:: ; heuristic: string; C0
    db $1B, $32, $37, $1B, $24, $39, $28, $31, $F0

Data_008_5B09:: ; heuristic: string; C0
    db $16, $38, $30, $30, $3C, $F0

Data_008_5B0F:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $0C, $35, $24, $25, $F0

Data_008_5B18:: ; heuristic: string; C0
    db $0D, $28, $24, $27, $17, $2C, $37, $28, $F0

Data_008_5B21:: ; heuristic: string; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_008_5B28:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $33, $28, $31, $37, $F0

Data_008_5B31:: ; heuristic: string; C0
    db $11, $32, $35, $2E, $F0

Data_008_5B36:: ; heuristic: string; C0
    db $16, $38, $27, $35, $32, $31, $F0

Data_008_5B3D:: ; heuristic: string; C0
    db $17, $2C, $37, $28, $20, $2B, $2C, $33, $F0

Data_008_5B46:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $16, $28, $35, $2A, $28, $F0

Data_008_5B50:: ; heuristic: string; C0
    db $1B, $28, $24, $33, $28, $35, $F0

Data_008_5B57:: ; heuristic: string; C0
    db $12, $31, $39, $28, $35, $3D, $32, $31, $F0

Data_008_5B60:: ; heuristic: string; C0
    db $0F, $32, $3B, $0F, $2C, $35, $28, $F0

Data_008_5B68:: ; heuristic: string; C0
    db $0C, $24, $33, $37, $0D, $28, $24, $27, $F0

Data_008_5B71:: ; heuristic: string; C0
    db $0D, $28, $24, $27, $17, $32, $25, $2F, $28, $F0

Data_008_5B7B:: ; heuristic: string; C0
    db $20, $2B, $2C, $37, $28, $14, $2C, $31, $2A, $F0

Data_008_5B85:: ; heuristic: string; C0
    db $0B, $32, $31, $28, $1C, $2F, $24, $39, $28, $F0

Data_008_5B8F:: ; heuristic: string; C0
    db $1C, $2E, $28, $2F, $28, $37, $32, $35, $F0

Data_008_5B98:: ; heuristic: string; C0
    db $1C, $28, $35, $39, $24, $31, $37, $F0

Data_008_5BA0:: ; heuristic: string; C0
    db $15, $24, $3D, $24, $30, $24, $31, $38, $36, $F0

Data_008_5BAA:: ; heuristic: string; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_008_5BB2:: ; heuristic: string; C0
    db $16, $24, $27, $1C, $33, $2C, $35, $2C, $37, $F0

Data_008_5BBC:: ; heuristic: string; C0
    db $19, $32, $30, $19, $32, $30, $0B, $32, $30, $F0

Data_008_5BC6:: ; heuristic: string; C0
    db $17, $2C, $37, $28, $35, $2C, $26, $2B, $F0

Data_008_5BCF:: ; heuristic: string; C0
    db $98, $F0

Data_008_5BD1:: ; heuristic: string; C0
    db $13, $28, $3A, $28, $2F, $0B, $24, $2A, $F0

Data_008_5BDA:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $20, $24, $31, $27, $F0

Data_008_5BE3:: ; heuristic: string; C0
    db $16, $24, $27, $0C, $24, $31, $27, $2F, $28, $F0

Data_008_5BED:: ; heuristic: string; C0
    db $0C, $32, $2C, $2F, $0B, $2C, $35, $27, $F0

Data_008_5BF6:: ; heuristic: string; C0
    db $0F, $24, $26, $28, $35, $F0

Data_008_5BFC:: ; heuristic: string; C0
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $F0

Data_008_5C05:: ; heuristic: string; C0
    db $16, $24, $27, $16, $2C, $35, $35, $32, $35, $F0

Data_008_5C0F:: ; heuristic: string; C0
    db $1B, $32, $2A, $38, $28, $17, $2C, $37, $28, $F0

Data_008_5C19:: ; heuristic: string; C0
    db $19, $38, $33, $33, $28, $37, $32, $35, $F0

Data_008_5C22:: ; heuristic: string; C0
    db $10, $32, $32, $33, $2C, $F0

Data_008_5C28:: ; heuristic: string; C0
    db $1F, $32, $32, $27, $32, $2F, $2F, $F0

Data_008_5C30:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $0D, $35, $24, $2E, $F0

Data_008_5C3A:: ; heuristic: string; C0
    db $0B, $24, $2F, $3D, $24, $2E, $F0

Data_008_5C41:: ; heuristic: string; C0
    db $1C, $24, $25, $35, $28, $16, $24, $31, $F0

Data_008_5C4A:: ; heuristic: string; C0
    db $0C, $38, $35, $36, $28, $15, $24, $30, $33, $F0

Data_008_5C54:: ; heuristic: string; C0
    db $0B, $35, $38, $36, $2B, $28, $24, $27, $F0

Data_008_5C5D:: ; heuristic: string; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $F0

Data_008_5C66:: ; heuristic: string; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $02, $F0

Data_008_5C70:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $19, $32, $37, $F0

Data_008_5C78:: ; heuristic: string; C0
    db $10, $2C, $36, $30, $32, $F0

Data_008_5C7E:: ; heuristic: string; C0
    db $15, $24, $39, $24, $16, $24, $31, $F0

Data_008_5C86:: ; heuristic: string; C0
    db $12, $26, $28, $16, $24, $31, $F0

Data_008_5C8D:: ; heuristic: string; C0
    db $16, $2C, $30, $2C, $26, $F0

Data_008_5C93:: ; heuristic: string; C0
    db $0E, $3B, $24, $38, $26, $28, $35, $36, $F0

Data_008_5C9C:: ; heuristic: string; C0
    db $16, $38, $27, $0D, $32, $2F, $2F, $F0

Data_008_5CA4:: ; heuristic: string; C0
    db $10, $32, $2F, $28, $30, $F0

Data_008_5CAA:: ; heuristic: string; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_008_5CB3:: ; heuristic: string; C0
    db $0B, $32, $30, $25, $0C, $35, $24, $2A, $F0

Data_008_5CBC:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $10, $32, $2F, $28, $30, $F0

Data_008_5CC6:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $16, $24, $37, $28, $F0

Data_008_5CCF:: ; heuristic: string; C0
    db $19, $35, $32, $37, $32, $16, $28, $26, $2B, $F0

Data_008_5CD9:: ; heuristic: string; C0
    db $0C, $2F, $32, $38, $27, $14, $2C, $31, $2A, $F0

Data_008_5CE3:: ; heuristic: string; C0
    db $98, $F0

Data_008_5CE5:: ; heuristic: string; C0
    db $19, $28, $37, $2C, $37, $28, $28, $2F, $F0

Data_008_5CEE:: ; heuristic: string; C0
    db $16, $32, $35, $24, $3C, $F0

Data_008_5CF4:: ; heuristic: string; C0
    db $20, $24, $2F, $35, $38, $36, $16, $24, $31, $F0

Data_008_5CFE:: ; heuristic: string; C0
    db $1B, $24, $3C, $10, $2C, $2A, $24, $36, $F0

Data_008_5D07:: ; heuristic: string; C0
    db $0A, $31, $28, $30, $32, $31, $F0

Data_008_5D0E:: ; heuristic: string; C0
    db $0A, $34, $38, $24, $35, $28, $2F, $2F, $24, $F0

Data_008_5D18:: ; heuristic: string; C0
    db $16, $28, $35, $30, $24, $31, $F0

Data_008_5D1F:: ; heuristic: string; C0
    db $18, $26, $37, $32, $2E, $2C, $27, $F0

Data_008_5D27:: ; heuristic: string; C0
    db $19, $38, $37, $35, $28, $0F, $2C, $36, $2B, $F0

Data_008_5D31:: ; heuristic: string; C0
    db $18, $26, $37, $32, $35, $28, $24, $26, $2B, $F0

Data_008_5D3B:: ; heuristic: string; C0
    db $0A, $31, $2A, $2F, $28, $35, $32, $31, $F0

Data_008_5D44:: ; heuristic: string; C0
    db $0F, $2C, $36, $2B, $1B, $2C, $27, $28, $35, $F0

Data_008_5D4E:: ; heuristic: string; C0
    db $1B, $38, $36, $2B, $0F, $2C, $36, $2B, $F0

Data_008_5D57:: ; heuristic: string; C0
    db $10, $24, $30, $24, $31, $2C, $24, $31, $F0

Data_008_5D60:: ; heuristic: string; C0
    db $0C, $2F, $24, $3A, $36, $37, $28, $35, $F0

Data_008_5D69:: ; heuristic: string; C0
    db $0C, $24, $31, $26, $28, $35, $16, $24, $31, $F0

Data_008_5D73:: ; heuristic: string; C0
    db $1B, $32, $2A, $38, $28, $20, $24, $39, $28, $F0

Data_008_5D7D:: ; heuristic: string; C0
    db $1C, $26, $24, $2F, $2F, $32, $33, $24, $F0

Data_008_5D86:: ; heuristic: string; C0
    db $1C, $28, $24, $11, $32, $35, $36, $28, $F0

Data_008_5D8F:: ; heuristic: string; C0
    db $11, $32, $32, $27, $1C, $34, $38, $2C, $27, $F0

Data_008_5D99:: ; heuristic: string; C0
    db $16, $28, $35, $1D, $2C, $2A, $28, $35, $F0

Data_008_5DA2:: ; heuristic: string; C0
    db $0A, $3B, $28, $1C, $2B, $24, $35, $2E, $F0

Data_008_5DAB:: ; heuristic: string; C0
    db $18, $26, $37, $32, $2A, $32, $31, $F0

Data_008_5DB3:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $1C, $34, $38, $2C, $27, $F0

Data_008_5DBD:: ; heuristic: string; C0
    db $0D, $2C, $2A, $32, $31, $2A, $F0

Data_008_5DC4:: ; heuristic: string; C0
    db $20, $2B, $24, $2F, $28, $16, $24, $2A, $28, $F0

Data_008_5DCE:: ; heuristic: string; C0
    db $0A, $34, $38, $24, $27, $32, $31, $F0

Data_008_5DD6:: ; heuristic: string; C0
    db $18, $26, $37, $32, $35, $24, $2C, $27, $F0

Data_008_5DDF:: ; heuristic: string; C0
    db $10, $35, $24, $2E, $32, $36, $F0

Data_008_5DE6:: ; heuristic: string; C0
    db $19, $32, $36, $28, $2C, $27, $32, $31, $F0

Data_008_5DEF:: ; heuristic: string; C0
    db $19, $38, $30, $33, $32, $2C, $36, $28, $F0

Data_008_5DF8:: ; heuristic: string; C0
    db $1C, $37, $24, $35, $29, $2C, $36, $2B, $F0

Data_008_5E01:: ; heuristic: string; C0
    db $98, $F0

Data_008_5E03:: ; heuristic: string; C0
    db $0D, $35, $24, $26, $32, $15, $32, $35, $27, $F0

Data_008_5E0D:: ; heuristic: string; C0
    db $0D, $35, $24, $26, $32, $15, $32, $35, $27, $F0

Data_008_5E17:: ; heuristic: string; C0
    db $15, $32, $35, $27, $0D, $35, $24, $26, $32, $F0

Data_008_5E21:: ; heuristic: string; C0
    db $11, $24, $35, $2A, $32, $31, $F0

Data_008_5E28:: ; heuristic: string; C0
    db $1C, $2C, $27, $32, $2B, $F0

Data_008_5E2E:: ; heuristic: string; C0
    db $10, $28, $31, $32, $36, $2C, $27, $32, $2B, $F0

Data_008_5E38:: ; heuristic: string; C0
    db $0B, $24, $35, $24, $30, $32, $36, $F0

Data_008_5E40:: ; heuristic: string; C0
    db $23, $32, $30, $24, $F0

Data_008_5E45:: ; heuristic: string; C0
    db $0A, $36, $38, $35, $24, $23, $32, $30, $24, $F0

Data_008_5E4F:: ; heuristic: string; C0
    db $19, $2C, $3D, $3D, $24, $35, $32, $F0

Data_008_5E57:: ; heuristic: string; C0
    db $19, $36, $3C, $26, $2B, $32, $19, $2C, $3D, $F0

Data_008_5E61:: ; heuristic: string; C0
    db $0E, $36, $37, $28, $35, $2E, $F0

Data_008_5E68:: ; heuristic: string; C0
    db $16, $2C, $35, $38, $27, $35, $24, $24, $36, $F0

Data_008_5E72:: ; heuristic: string; C0
    db $16, $2C, $35, $38, $27, $35, $24, $24, $36, $F0

Data_008_5E7C:: ; heuristic: string; C0
    db $16, $38, $27, $32, $38, $F0

Data_008_5E82:: ; heuristic: string; C0
    db $0D, $28, $24, $37, $2B, $16, $32, $35, $28, $F0

Data_008_5E8C:: ; heuristic: string; C0
    db $0D, $28, $24, $37, $2B, $16, $32, $35, $28, $F0

Data_008_5E96:: ; heuristic: string; C0
    db $0D, $28, $24, $37, $2B, $16, $32, $35, $28, $F0

Data_008_5EA0:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $27, $35, $2C, $38, $30, $F0

Data_008_5EAA:: ; heuristic: string; C0
    db $18, $35, $2A, $32, $27, $28, $30, $2C, $35, $F0

Data_008_5EB4:: ; heuristic: string; C0
    db $18, $35, $2A, $32, $27, $28, $30, $2C, $35, $F0

Data_008_5EBE:: ; heuristic: string; C0
    db $0D, $24, $35, $26, $2E, $F0

Data_008_5EC4:: ; heuristic: string; C0
    db $1D, $24, $37, $36, $38, $F0

Data_008_5ECA:: ; heuristic: string; C0
    db $0D, $2C, $24, $2A, $32, $F0

Data_008_5ED0:: ; heuristic: string; C0
    db $1C, $24, $30, $36, $2C, $F0

Data_008_5ED6:: ; heuristic: string; C0
    db $0B, $24, $3D, $32, $32, $F0

Data_008_5EDC:: ; heuristic: string; C0
    db $98, $F0

Data_008_5EDE:: ; heuristic: string; C0
    db $15, $24, $30, $2C, $24, $F0

Data_008_5EE4:: ; heuristic: string; C0
    db $0D, $2C, $30, $28, $31, $36, $24, $38, $35, $F0

Data_008_5EEE:: ; heuristic: string; C0
    db $14, $24, $2A, $28, $25, $32, $38, $F0

Data_008_5EF6:: ; heuristic: string; C0
    db $98, $F0

Data_008_5EF8:: ; heuristic: string; C0
    db $F0

Data_008_5EF9:: ; heuristic: string; C0
    db $0B, $2F, $24, $3D, $28, $F0

Data_008_5EFF:: ; heuristic: string; C0
    db $0B, $2F, $24, $3D, $28, $30, $32, $35, $28, $F0

Data_008_5F09:: ; heuristic: string; C0
    db $0B, $2F, $24, $3D, $28, $30, $32, $36, $37, $F0

Data_008_5F13:: ; heuristic: string; C0
    db $0F, $2C, $35, $28, $25, $24, $2F, $F0

Data_008_5F1B:: ; heuristic: string; C0
    db $0F, $2C, $35, $28, $25, $24, $31, $28, $F0

Data_008_5F24:: ; heuristic: string; C0
    db $0F, $2C, $35, $28, $25, $32, $2F, $37, $F0

Data_008_5F2D:: ; heuristic: string; C0
    db $0B, $24, $31, $2A, $F0

Data_008_5F32:: ; heuristic: string; C0
    db $0B, $32, $32, $30, $F0

Data_008_5F37:: ; heuristic: string; C0
    db $0E, $3B, $33, $2F, $32, $27, $28, $37, $F0

Data_008_5F40:: ; heuristic: string; C0
    db $12, $31, $29, $28, $35, $31, $32, $36, $F0

Data_008_5F49:: ; heuristic: string; C0
    db $12, $31, $29, $28, $35, $30, $32, $35, $28, $F0

Data_008_5F53:: ; heuristic: string; C0
    db $12, $31, $29, $28, $35, $30, $32, $36, $37, $F0

Data_008_5F5D:: ; heuristic: string; C0
    db $0B, $32, $2F, $37, $F0

Data_008_5F62:: ; heuristic: string; C0
    db $23, $24, $33, $F0

Data_008_5F66:: ; heuristic: string; C0
    db $1D, $2B, $32, $35, $27, $24, $2C, $31, $F0

Data_008_5F6F:: ; heuristic: string; C0
    db $12, $26, $28, $0B, $32, $2F, $37, $F0

Data_008_5F77:: ; heuristic: string; C0
    db $1C, $31, $32, $3A, $1C, $37, $32, $35, $30, $F0

Data_008_5F81:: ; heuristic: string; C0
    db $0B, $2F, $2C, $3D, $3D, $24, $35, $27, $F0

Data_008_5F8A:: ; heuristic: string; C0
    db $0B, $28, $24, $37, $F0

Data_008_5F8F:: ; heuristic: string; C0
    db $0D, $28, $29, $28, $24, $37, $F0

Data_008_5F96:: ; heuristic: string; C0
    db $1C, $24, $26, $35, $2C, $29, $2C, $26, $28, $F0

Data_008_5FA0:: ; heuristic: string; C0
    db $11, $28, $24, $2F, $F0

Data_008_5FA5:: ; heuristic: string; C0
    db $11, $28, $24, $2F, $16, $32, $35, $28, $F0

Data_008_5FAE:: ; heuristic: string; C0
    db $11, $28, $24, $2F, $0A, $2F, $2F, $F0

Data_008_5FB6:: ; heuristic: string; C0
    db $11, $28, $24, $2F, $1E, $36, $F0

Data_008_5FBD:: ; heuristic: string; C0
    db $11, $28, $24, $2F, $1E, $36, $0A, $2F, $2F, $F0

Data_008_5FC7:: ; heuristic: string; C0
    db $16, $19, $24, $36, $36, $F0

Data_008_5FCD:: ; heuristic: string; C0
    db $16, $19, $24, $36, $36, $30, $32, $35, $28, $F0

Data_008_5FD7:: ; heuristic: string; C0
    db $16, $19, $24, $36, $36, $30, $32, $36, $37, $F0

Data_008_5FE1:: ; heuristic: string; C0
    db $1F, $2C, $39, $2C, $29, $3C, $F0

Data_008_5FE8:: ; heuristic: string; C0
    db $1B, $28, $39, $2C, $39, $28, $F0

Data_008_5FEF:: ; heuristic: string; C0
    db $0F, $24, $35, $28, $3A, $28, $2F, $2F, $F0

Data_008_5FF8:: ; heuristic: string; C0
    db $0A, $31, $37, $2C, $27, $32, $37, $28, $F0

Data_008_6001:: ; heuristic: string; C0
    db $0D, $28, $0C, $2B, $24, $32, $36, $F0

Data_008_6009:: ; heuristic: string; C0
    db $17, $38, $30, $25, $18, $29, $29, $F0

Data_008_6011:: ; heuristic: string; C0
    db $0C, $38, $35, $36, $28, $18, $29, $29, $F0

Data_008_601A:: ; heuristic: string; C0
    db $1E, $33, $33, $28, $35, $F0

Data_008_6020:: ; heuristic: string; C0
    db $12, $31, $26, $35, $28, $24, $36, $28, $F0

Data_008_6029:: ; heuristic: string; C0
    db $1C, $24, $33, $F0

Data_008_602D:: ; heuristic: string; C0
    db $0D, $28, $29, $28, $31, $36, $28, $F0

Data_008_6035:: ; heuristic: string; C0
    db $1C, $33, $28, $28, $27, $F0

Data_008_603B:: ; heuristic: string; C0
    db $1C, $33, $28, $28, $27, $1E, $33, $F0

Data_008_6043:: ; heuristic: string; C0
    db $1C, $2F, $32, $3A, $F0

Data_008_6048:: ; heuristic: string; C0
    db $1C, $2F, $32, $3A, $0A, $2F, $2F, $F0

Data_008_6050:: ; heuristic: string; C0
    db $1D, $3A, $2C, $31, $11, $2C, $37, $36, $F0

Data_008_6059:: ; heuristic: string; C0
    db $1C, $38, $35, $35, $32, $38, $31, $27, $F0

Data_008_6062:: ; heuristic: string; C0
    db $1C, $2F, $28, $28, $33, $F0

Data_008_6068:: ; heuristic: string; C0
    db $1C, $2F, $28, $28, $33, $0A, $2F, $2F, $F0

Data_008_6071:: ; heuristic: string; C0
    db $1D, $24, $2E, $28, $16, $24, $2A, $2C, $26, $F0

Data_008_607B:: ; heuristic: string; C0
    db $1B, $32, $25, $16, $24, $2A, $2C, $26, $F0

Data_008_6084:: ; heuristic: string; C0
    db $1C, $37, $32, $33, $1C, $33, $28, $2F, $2F, $F0

Data_008_608E:: ; heuristic: string; C0
    db $19, $24, $31, $2C, $26, $0A, $2F, $2F, $F0

Data_008_6097:: ; heuristic: string; C0
    db $12, $35, $32, $31, $2C, $3D, $28, $F0

Data_008_609F:: ; heuristic: string; C0
    db $16, $24, $2A, $2C, $26, $0B, $24, $26, $2E, $F0

Data_008_60A9:: ; heuristic: string; C0
    db $0B, $32, $38, $31, $26, $28, $F0

Data_008_60B0:: ; heuristic: string; C0
    db $0B, $24, $35, $35, $2C, $28, $35, $F0

Data_008_60B8:: ; heuristic: string; C0
    db $16, $24, $2A, $2C, $26, $20, $24, $2F, $2F, $F0

Data_008_60C2:: ; heuristic: string; C0
    db $1D, $35, $24, $31, $36, $29, $32, $35, $30, $F0

Data_008_60CC:: ; heuristic: string; C0
    db $0B, $28, $0D, $35, $24, $2A, $32, $31, $F0

Data_008_60D5:: ; heuristic: string; C0
    db $0C, $2B, $24, $31, $26, $28, $F0

Data_008_60DC:: ; heuristic: string; C0
    db $16, $28, $2A, $24, $16, $24, $2A, $2C, $26, $F0

Data_008_60E6:: ; heuristic: string; C0
    db $0B, $2C, $2A, $0B, $24, $31, $2A, $F0

Data_008_60EE:: ; heuristic: string; C0
    db $11, $28, $2F, $2F, $25, $2F, $24, $36, $37, $F0

Data_008_60F8:: ; heuristic: string; C0
    db $0F, $2C, $35, $28, $0A, $2C, $35, $F0

Data_008_6100:: ; heuristic: string; C0
    db $0B, $2F, $24, $3D, $28, $0A, $2C, $35, $F0

Data_008_6109:: ; heuristic: string; C0
    db $1C, $26, $32, $35, $26, $2B, $2C, $31, $2A, $F0

Data_008_6113:: ; heuristic: string; C0
    db $20, $2B, $2C, $37, $28, $0F, $2C, $35, $28, $F0

Data_008_611D:: ; heuristic: string; C0
    db $0F, $35, $2C, $2A, $2C, $27, $0A, $2C, $35, $F0

Data_008_6127:: ; heuristic: string; C0
    db $12, $26, $28, $0A, $2C, $35, $F0

Data_008_612E:: ; heuristic: string; C0
    db $12, $26, $28, $1C, $37, $32, $35, $30, $F0

Data_008_6137:: ; heuristic: string; C0
    db $20, $2B, $2C, $37, $28, $0A, $2C, $35, $F0

Data_008_6140:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $0B, $28, $24, $36, $37, $F0

Data_008_614A:: ; heuristic: string; C0
    db $1F, $24, $26, $38, $38, $30, $F0

Data_008_6151:: ; heuristic: string; C0
    db $15, $2C, $2A, $2B, $37, $31, $2C, $31, $2A, $F0

Data_008_615B:: ; heuristic: string; C0
    db $1B, $32, $26, $2E, $1D, $2B, $35, $32, $3A, $F0

Data_008_6165:: ; heuristic: string; C0
    db $20, $24, $37, $28, $35, $36, $2B, $32, $37, $F0

Data_008_616F:: ; heuristic: string; C0
    db $1D, $2C, $27, $24, $2F, $3A, $24, $39, $28, $F0

Data_008_6179:: ; heuristic: string; C0
    db $0C, $24, $2F, $2F, $11, $28, $2F, $33, $F0

Data_008_6182:: ; heuristic: string; C0
    db $22, $28, $2F, $2F, $11, $28, $2F, $33, $F0

Data_008_618B:: ; heuristic: string; C0
    db $0F, $2C, $35, $28, $1C, $2F, $24, $36, $2B, $F0

Data_008_6195:: ; heuristic: string; C0
    db $1F, $24, $26, $38, $1C, $2F, $24, $36, $2B, $F0

Data_008_619F:: ; heuristic: string; C0
    db $0B, $32, $2F, $37, $1C, $2F, $24, $36, $2B, $F0

Data_008_61A9:: ; heuristic: string; C0
    db $12, $26, $28, $1C, $2F, $24, $36, $2B, $F0

Data_008_61B2:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $0B, $2F, $32, $3A, $F0

Data_008_61BC:: ; heuristic: string; C0
    db $0D, $35, $24, $2E, $1C, $2F, $24, $36, $2B, $F0

Data_008_61C6:: ; heuristic: string; C0
    db $0B, $28, $24, $36, $37, $0C, $38, $37, $F0

Data_008_61CF:: ; heuristic: string; C0
    db $0B, $2C, $35, $27, $0B, $2F, $32, $3A, $F0

Data_008_61D8:: ; heuristic: string; C0
    db $0B, $38, $2A, $0B, $2F, $32, $3A, $F0

Data_008_61E0:: ; heuristic: string; C0
    db $1C, $2B, $28, $24, $35, $36, $F0

Data_008_61E7:: ; heuristic: string; C0
    db $0D, $28, $39, $2C, $2F, $0C, $38, $37, $F0

Data_008_61F0:: ; heuristic: string; C0
    db $23, $32, $30, $25, $2C, $28, $0C, $38, $37, $F0

Data_008_61FA:: ; heuristic: string; C0
    db $0C, $2F, $28, $24, $31, $0C, $38, $37, $F0

Data_008_6203:: ; heuristic: string; C0
    db $0A, $34, $38, $24, $0C, $38, $37, $F0

Data_008_620B:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $0C, $38, $37, $F0

Data_008_6214:: ; heuristic: string; C0
    db $19, $32, $2C, $36, $32, $31, $11, $2C, $37, $F0

Data_008_621E:: ; heuristic: string; C0
    db $19, $24, $35, $24, $2F, $3C, $3D, $28, $F0

Data_008_6227:: ; heuristic: string; C0
    db $17, $24, $33, $0A, $37, $37, $24, $26, $2E, $F0

Data_008_6231:: ; heuristic: string; C0
    db $1C, $34, $38, $24, $2F, $2F, $11, $2C, $37, $F0

Data_008_623B:: ; heuristic: string; C0
    db $0B, $2C, $0A, $37, $37, $24, $26, $2E, $F0

Data_008_6244:: ; heuristic: string; C0
    db $1A, $38, $24, $27, $11, $2C, $37, $36, $F0

Data_008_624D:: ; heuristic: string; C0
    db $1B, $24, $2C, $31, $1C, $2F, $24, $36, $2B, $F0

Data_008_6257:: ; heuristic: string; C0
    db $16, $38, $2F, $37, $2C, $0C, $38, $37, $F0

Data_008_6260:: ; heuristic: string; C0
    db $10, $2C, $2A, $24, $1C, $2F, $24, $36, $2B, $F0

Data_008_626A:: ; heuristic: string; C0
    db $0C, $2B, $24, $35, $2A, $28, $1E, $33, $F0

Data_008_6273:: ; heuristic: string; C0
    db $19, $36, $3C, $26, $2B, $28, $1E, $33, $F0

Data_008_627C:: ; heuristic: string; C0
    db $11, $2C, $2A, $2B, $13, $38, $30, $33, $F0

Data_008_6285:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $1C, $2F, $24, $36, $2B, $F0

Data_008_628F:: ; heuristic: string; C0
    db $16, $24, $36, $36, $24, $26, $35, $28, $F0

Data_008_6298:: ; heuristic: string; C0
    db $1D, $3A, $2C, $31, $1C, $2F, $24, $36, $2B, $F0

Data_008_62A2:: ; heuristic: string; C0
    db $0B, $28, $35, $36, $28, $35, $2E, $28, $35, $F0

Data_008_62AC:: ; heuristic: string; C0
    db $1B, $24, $30, $30, $2C, $31, $2A, $F0

Data_008_62B4:: ; heuristic: string; C0
    db $14, $24, $30, $2C, $2E, $24, $3D, $28, $F0

Data_008_62BD:: ; heuristic: string; C0
    db $1C, $2F, $28, $28, $33, $0A, $2C, $35, $F0

Data_008_62C6:: ; heuristic: string; C0
    db $19, $24, $2F, $36, $3C, $0A, $2C, $35, $F0

Data_008_62CF:: ; heuristic: string; C0
    db $19, $32, $2C, $36, $32, $31, $10, $24, $36, $F0

Data_008_62D9:: ; heuristic: string; C0
    db $19, $32, $2C, $36, $32, $31, $0A, $2C, $35, $F0

Data_008_62E3:: ; heuristic: string; C0
    db $0C, $38, $35, $36, $28, $F0

Data_008_62E9:: ; heuristic: string; C0
    db $18, $27, $27, $0D, $24, $31, $26, $28, $F0

Data_008_62F2:: ; heuristic: string; C0
    db $1B, $32, $25, $0D, $24, $31, $26, $28, $F0

Data_008_62FB:: ; heuristic: string; C0
    db $19, $24, $31, $2C, $0D, $24, $31, $26, $28, $F0

Data_008_6305:: ; heuristic: string; C0
    db $14, $B5, $18, $B5, $0D, $24, $31, $26, $28, $F0

Data_008_630F:: ; heuristic: string; C0
    db $15, $38, $35, $28, $0D, $24, $31, $26, $28, $F0

Data_008_6319:: ; heuristic: string; C0
    db $15, $2C, $29, $28, $0D, $24, $31, $26, $28, $F0

Data_008_6323:: ; heuristic: string; C0
    db $11, $38, $36, $37, $2F, $28, $F0

Data_008_632A:: ; heuristic: string; C0
    db $1C, $2C, $27, $28, $1C, $37, $28, $33, $F0

Data_008_6333:: ; heuristic: string; C0
    db $1C, $24, $31, $27, $1C, $37, $32, $35, $30, $F0

Data_008_633D:: ; heuristic: string; C0
    db $1B, $24, $27, $2C, $24, $31, $37, $F0

Data_008_6345:: ; heuristic: string; C0
    db $0E, $28, $35, $2C, $28, $15, $2C, $37, $28, $F0

Data_008_634F:: ; heuristic: string; C0
    db $1C, $38, $35, $2A, $28, $F0

Data_008_6355:: ; heuristic: string; C0
    db $1E, $2F, $37, $35, $24, $0D, $32, $3A, $31, $F0

Data_008_635F:: ; heuristic: string; C0
    db $0D, $28, $16, $24, $2A, $2C, $26, $F0

Data_008_6367:: ; heuristic: string; C0
    db $1D, $2B, $2C, $26, $2E, $0F, $32, $2A, $F0

Data_008_6370:: ; heuristic: string; C0
    db $1D, $24, $37, $36, $38, $0C, $24, $2F, $2F, $F0

Data_008_637A:: ; heuristic: string; C0
    db $0D, $2C, $24, $2A, $32, $0C, $24, $2F, $2F, $F0

Data_008_6384:: ; heuristic: string; C0
    db $1C, $24, $30, $36, $2C, $0C, $24, $2F, $2F, $F0

Data_008_638E:: ; heuristic: string; C0
    db $0B, $24, $3D, $32, $32, $0C, $24, $2F, $2F, $F0

Data_008_6398:: ; heuristic: string; C0
    db $1C, $38, $26, $2E, $0A, $2C, $35, $F0

Data_008_63A0:: ; heuristic: string; C0
    db $0F, $32, $26, $38, $36, $F0

Data_008_63A6:: ; heuristic: string; C0
    db $15, $38, $36, $2B, $15, $2C, $26, $2E, $36, $F0

Data_008_63B0:: ; heuristic: string; C0
    db $1C, $2C, $26, $2E, $15, $2C, $26, $2E, $F0

Data_008_63B9:: ; heuristic: string; C0
    db $15, $28, $2A, $1C, $3A, $28, $28, $33, $F0

Data_008_63C2:: ; heuristic: string; C0
    db $0B, $2C, $2A, $1D, $35, $2C, $33, $F0

Data_008_63CA:: ; heuristic: string; C0
    db $0A, $2B, $2B, $2B, $F0

Data_008_63CF:: ; heuristic: string; C0
    db $20, $24, $35, $0C, $35, $3C, $F0

Data_008_63D6:: ; heuristic: string; C0
    db $10, $28, $3C, $36, $28, $35, $F0

Data_008_63DD:: ; heuristic: string; C0
    db $0D, $24, $31, $26, $28, $1C, $2B, $38, $37, $F0

Data_008_63E7:: ; heuristic: string; C0
    db $16, $32, $38, $37, $2B, $1C, $2B, $38, $37, $F0

Data_008_63F1:: ; heuristic: string; C0
    db $1C, $37, $35, $32, $31, $2A, $0D, $F0

Data_008_63F9:: ; heuristic: string; C0
    db $0D, $32, $27, $2A, $28, $F0

Data_008_63FF:: ; heuristic: string; C0
    db $0B, $2F, $24, $27, $28, $0D, $F0

Data_008_6406:: ; heuristic: string; C0
    db $0C, $32, $39, $28, $35, $F0

Data_008_640C:: ; heuristic: string; C0
    db $10, $38, $24, $35, $27, $2C, $24, $31, $F0

Data_008_6415:: ; heuristic: string; C0
    db $1D, $24, $2C, $2F, $20, $2C, $31, $27, $F0

Data_008_641E:: ; heuristic: string; C0
    db $1C, $37, $32, $35, $30, $20, $2C, $31, $27, $F0

Data_008_6428:: ; heuristic: string; C0
    db $0A, $34, $38, $24, $20, $24, $2F, $2F, $F0

Data_008_6431:: ; heuristic: string; C0
    db $1C, $28, $24, $2F, $19, $35, $24, $3C, $F0

Data_008_643A:: ; heuristic: string; C0
    db $1C, $38, $26, $2E, $0A, $2F, $2F, $F0

Data_008_6442:: ; heuristic: string; C0
    db $12, $30, $2C, $37, $24, $37, $28, $F0

Data_008_644A:: ; heuristic: string; C0
    db $16, $28, $27, $2C, $37, $24, $37, $28, $F0

Data_008_6453:: ; heuristic: string; C0
    db $15, $2C, $29, $28, $1C, $32, $31, $2A, $F0

Data_008_645C:: ; heuristic: string; C0
    db $15, $32, $39, $28, $1B, $24, $2C, $31, $F0

Data_008_6465:: ; heuristic: string; C0
    db $20, $2B, $2C, $36, $37, $2F, $28, $F0

Data_008_646D:: ; heuristic: string; C0
    db $19, $2B, $28, $35, $32, $30, $32, $31, $28, $F0

Data_008_6477:: ; heuristic: string; C0
    db $1C, $37, $28, $33, $10, $38, $24, $35, $27, $F0

Data_008_6481:: ; heuristic: string; C0
    db $18, $38, $37, $36, $2C, $27, $28, $F0

Data_008_6489:: ; heuristic: string; C0
    db $12, $31, $29, $32, $35, $30, $28, $35, $F0

Data_008_6492:: ; heuristic: string; C0
    db $0E, $35, $35, $24, $31, $27, $F0

Data_008_6499:: ; heuristic: string; C0
    db $0E, $24, $2A, $2F, $28, $0E, $3C, $28, $F0

Data_008_64A2:: ; heuristic: string; C0
    db $16, $24, $33, $16, $24, $2A, $2C, $26, $F0

Data_008_64AB:: ; heuristic: string; C0
    db $0A, $2B, $2B, $2B, $F0

Data_008_64B0:: ; heuristic: string; C0
    db $23, $32, $31, $28, $18, $38, $37, $F0

Data_008_64B8:: ; heuristic: string; C0
    db $10, $38, $24, $35, $27, $F0

Data_008_64BE:: ; heuristic: string; C0
    db $19, $24, $31, $2C, $26, $0A, $2F, $2F, $F0

Data_008_64C7:: ; heuristic: string; C0
    db $12, $35, $32, $31, $2C, $3D, $28, $F0

Data_008_64CF:: ; heuristic: string; C0
    db $11, $2C, $2A, $2B, $13, $38, $30, $33, $F0

Data_008_64D8:: ; heuristic: string; C0
    db $15, $32, $39, $28, $1B, $24, $2C, $31, $F0

Data_008_64E1:: ; heuristic: string; C0
    db $F0

Data_008_64E2:: ; heuristic: string; C0
    db $F0

Data_008_64E3:: ; heuristic: string; C0
    db $11, $28, $35, $25, $F0

Data_008_64E8:: ; heuristic: string; C0
    db $15, $32, $39, $28, $20, $24, $37, $28, $35, $F0

Data_008_64F2:: ; heuristic: string; C0
    db $20, $32, $35, $2F, $27, $0D, $28, $3A, $F0

Data_008_64FB:: ; heuristic: string; C0
    db $19, $32, $37, $2C, $32, $31, $F0

Data_008_6502:: ; heuristic: string; C0
    db $0E, $2F, $29, $20, $24, $37, $28, $35, $F0

Data_008_650B:: ; heuristic: string; C0
    db $0A, $31, $37, $2C, $27, $32, $37, $28, $F0

Data_008_6514:: ; heuristic: string; C0
    db $16, $32, $32, $31, $11, $28, $35, $25, $F0

Data_008_651D:: ; heuristic: string; C0
    db $15, $24, $38, $35, $28, $2F, $F0

Data_008_6524:: ; heuristic: string; C0
    db $0A, $3A, $24, $2E, $28, $1C, $24, $31, $27, $F0

Data_008_652E:: ; heuristic: string; C0
    db $1C, $2E, $3C, $0B, $28, $2F, $2F, $F0

Data_008_6536:: ; heuristic: string; C0
    db $1C, $24, $2A, $28, $1B, $32, $26, $2E, $F0

Data_008_653F:: ; heuristic: string; C0
    db $20, $32, $35, $2F, $27, $15, $28, $24, $29, $F0

Data_008_6549:: ; heuristic: string; C0
    db $0A, $1D, $14, $36, $28, $28, $27, $F0

Data_008_6551:: ; heuristic: string; C0
    db $0D, $0E, $0F, $36, $28, $28, $27, $F0

Data_008_6559:: ; heuristic: string; C0
    db $0A, $10, $15, $36, $28, $28, $27, $F0

Data_008_6561:: ; heuristic: string; C0
    db $12, $17, $1D, $36, $28, $28, $27, $F0

Data_008_6569:: ; heuristic: string; C0
    db $15, $2C, $29, $28, $0A, $26, $32, $35, $31, $F0

Data_008_6573:: ; heuristic: string; C0
    db $16, $3C, $36, $37, $2C, $26, $17, $38, $37, $F0

Data_008_657D:: ; heuristic: string; C0
    db $1A, $38, $28, $36, $37, $50, $F0

Data_008_6584:: ; heuristic: string; C0
    db $11, $32, $35, $35, $32, $35, $50, $F0

Data_008_658C:: ; heuristic: string; C0
    db $0B, $28, $17, $2C, $26, $28, $50, $F0

Data_008_6594:: ; heuristic: string; C0
    db $0C, $2B, $28, $24, $37, $28, $35, $50, $F0

Data_008_659D:: ; heuristic: string; C0
    db $1C, $30, $24, $35, $37, $50, $F0

Data_008_65A4:: ; heuristic: string; C0
    db $0C, $32, $30, $28, $27, $3C, $50, $F0

Data_008_65AC:: ; heuristic: string; C0
    db $0B, $28, $28, $29, $13, $28, $35, $2E, $3C, $F0

Data_008_65B6:: ; heuristic: string; C0
    db $19, $32, $35, $2E, $0C, $2B, $32, $33, $F0

Data_008_65BF:: ; heuristic: string; C0
    db $1B, $2C, $25, $F0

Data_008_65C3:: ; heuristic: string; C0
    db $1C, $2C, $35, $2F, $32, $2C, $31, $F0

Data_008_65CB:: ; heuristic: string; C0
    db $0B, $24, $27, $16, $28, $24, $37, $F0

Data_008_65D3:: ; heuristic: string; C0
    db $16, $28, $37, $28, $18, $35, $25, $F0

Data_008_65DB:: ; heuristic: string; C0
    db $0B, $28, $24, $36, $37, $1D, $24, $2C, $2F, $F0

Data_008_65E5:: ; heuristic: string; C0
    db $1B, $28, $33, $28, $2F, $2F, $28, $31, $37, $F0

Data_008_65EF:: ; heuristic: string; C0
    db $1C, $2B, $2C, $31, $3C, $11, $24, $35, $33, $F0

Data_008_65F9:: ; heuristic: string; C0
    db $16, $2C, $36, $37, $51, $F0

Data_008_65FF:: ; heuristic: string; C0
    db $0F, $35, $2C, $28, $31, $27, $51, $F0

Data_008_6607:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $51, $F0

Data_008_660D:: ; heuristic: string; C0
    db $0B, $32, $2F, $37, $51, $F0

Data_008_6613:: ; heuristic: string; C0
    db $1C, $31, $32, $3A, $51, $F0

Data_008_6619:: ; heuristic: string; C0
    db $0F, $2C, $35, $28, $51, $F0

Data_008_661F:: ; heuristic: string; C0
    db $20, $24, $35, $33, $51, $F0

Data_008_6625:: ; heuristic: string; C0
    db $20, $24, $35, $33, $20, $2C, $31, $2A, $F0

Data_008_662E:: ; heuristic: string; C0
    db $0E, $3B, $2C, $37, $0B, $28, $2F, $2F, $F0

Data_008_6637:: ; heuristic: string; C0
    db $0B, $32, $32, $2E, $30, $24, $35, $2E, $F0

Data_008_6640:: ; heuristic: string; C0
    db $1D, $2C, $31, $3C, $16, $28, $27, $24, $2F, $F0

Data_008_664A:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $19, $24, $36, $36, $F0

Data_008_6653:: ; heuristic: string; C0
    db $15, $32, $2A, $1D, $3A, $2C, $2A, $F0

Data_008_665B:: ; heuristic: string; C0
    db $F0

Data_008_665C:: ; heuristic: string; C0
    db $20, $24, $37, $28, $35, $0C, $24, $2F, $2F, $F0

Data_008_6666:: ; heuristic: string; C0
    db $16, $32, $32, $31, $1B, $32, $26, $2E, $F0

Data_008_666F:: ; heuristic: string; C0
    db $0C, $35, $28, $36, $37, $F0

Data_008_6675:: ; heuristic: string; C0
    db $22, $38, $31, $24, $1C, $32, $38, $2F, $F0

Data_008_667E:: ; heuristic: string; C0
    db $1C, $2F, $28, $28, $33, $11, $28, $35, $25, $F0

Data_008_6688:: ; heuristic: string; C0
    db $0C, $2B, $24, $31, $2A, $28, $51, $F0

Data_008_6690:: ; heuristic: string; C0
    db $1D, $2C, $27, $24, $2F, $0B, $28, $2F, $2F, $F0

Data_008_669A:: ; heuristic: string; C0
    db $11, $24, $35, $16, $2C, $35, $35, $32, $35, $F0

Data_008_66A4:: ; heuristic: string; C0
    db $1C, $2E, $3C, $5E, $F0

Data_008_66A9:: ; heuristic: string; C0
    db $11, $28, $24, $39, $28, $31, $52, $F0

Data_008_66B1:: ; heuristic: string; C0
    db $11, $28, $24, $39, $28, $31, $54, $F0

Data_008_66B9:: ; heuristic: string; C0
    db $11, $28, $24, $39, $28, $31, $53, $F0

Data_008_66C1:: ; heuristic: string; C0
    db $20, $2C, $3D, $1C, $37, $32, $31, $28, $F0

Data_008_66CA:: ; heuristic: string; C0
    db $19, $35, $28, $37, $37, $3C, $55, $F0

Data_008_66D2:: ; heuristic: string; C0
    db $0A, $26, $26, $28, $36, $36, $32, $35, $3C, $F0

Data_008_66DC:: ; heuristic: string; C0
    db $1F, $12, $1D, $25, $28, $2F, $37, $F0

Data_008_66E4:: ; heuristic: string; C0
    db $0D, $35, $24, $26, $32, $0B, $28, $2F, $37, $F0

Data_008_66EE:: ; heuristic: string; C0
    db $16, $24, $2A, $2C, $26, $0B, $28, $2F, $37, $F0

Data_008_66F8:: ; heuristic: string; C0
    db $18, $27, $27, $0B, $28, $2F, $37, $F0

Data_008_6700:: ; heuristic: string; C0
    db $1C, $37, $32, $31, $28, $0F, $24, $31, $2A, $F0

Data_008_670A:: ; heuristic: string; C0
    db $1C, $37, $28, $28, $2F, $0F, $24, $31, $2A, $F0

Data_008_6714:: ; heuristic: string; C0
    db $16, $28, $35, $30, $1C, $26, $24, $2F, $28, $F0

Data_008_671E:: ; heuristic: string; C0
    db $0D, $35, $24, $2E, $1C, $26, $24, $2F, $28, $F0

Data_008_6728:: ; heuristic: string; C0
    db $0A, $10, $15, $55, $F0

Data_008_672D:: ; heuristic: string; C0
    db $1C, $37, $24, $35, $35, $3C, $55, $F0

Data_008_6735:: ; heuristic: string; C0
    db $1C, $30, $24, $35, $37, $56, $F0

Data_008_673C:: ; heuristic: string; C0
    db $20, $2C, $36, $28, $56, $F0

Data_008_6742:: ; heuristic: string; C0
    db $16, $24, $2A, $2C, $26, $0C, $24, $33, $28, $F0

Data_008_674C:: ; heuristic: string; C0
    db $0D, $35, $24, $26, $32, $0C, $24, $33, $28, $F0

Data_008_6756:: ; heuristic: string; C0
    db $1C, $2C, $2F, $39, $35, $0C, $24, $33, $28, $F0

Data_008_6760:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $0C, $24, $33, $28, $F0

Data_008_6769:: ; heuristic: string; C0
    db $19, $2F, $37, $31, $30, $0C, $24, $33, $28, $F0

Data_008_6773:: ; heuristic: string; C0
    db $18, $35, $26, $24, $0C, $24, $33, $28, $F0

Data_008_677C:: ; heuristic: string; C0
    db $0B, $35, $24, $39, $28, $0C, $24, $33, $28, $F0

Data_008_6786:: ; heuristic: string; C0
    db $0D, $9C, $1C, $26, $24, $2F, $28, $F0

Data_008_678E:: ; heuristic: string; C0
    db $17, $32, $31, $28, $F0

Data_008_6793:: ; heuristic: string; C0
    db $15, $2C, $29, $28, $55, $F0

Data_008_6799:: ; heuristic: string; C0
    db $0D, $2C, $39, $2C, $31, $28, $55, $F0

Data_008_67A1:: ; heuristic: string; C0
    db $20, $24, $35, $55, $F0

Data_008_67A6:: ; heuristic: string; C0
    db $16, $24, $2A, $28, $55, $F0

Data_008_67AC:: ; heuristic: string; C0
    db $0F, $2C, $2A, $2B, $37, $55, $F0

Data_008_67B3:: ; heuristic: string; C0
    db $1C, $24, $2C, $2F, $32, $35, $55, $F0

Data_008_67BB:: ; heuristic: string; C0
    db $1D, $2B, $2C, $28, $29, $55, $F0

Data_008_67C2:: ; heuristic: string; C0
    db $0C, $2F, $28, $35, $2C, $26, $55, $F0

Data_008_67CA:: ; heuristic: string; C0
    db $F0

Data_008_67CB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of one", $F1
    db "monster by "
    db $03, $00, $9D, $04, $00, $B5, $F0

Data_008_67F0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of one", $F1
    db "monster by "
    db $06, $00, $9D, $07, $00, $B5, $F0

Data_008_6815:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores HP", $F1
    db "of all monsters.", $F0

Data_008_6838:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores MP of one", $F1
    db "monster by "
    db $02, $00, $9D, $03, $00, $B5, $F0

Data_008_685D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores MP", $F1
    db "of one monster.", $F0

Data_008_687F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Removes all traces", $F1
    db "of poison.", $F0

Data_008_689D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cures paralysis.", $F0

Data_008_68AE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lifts a curse off", $F1
    db "one monster.", $F0

Data_008_68CD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Awakens a sleeping", $F1
    db "monster.", $F0

Data_008_68E9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snaps a monster", $F1
    db "out of confusion.", $F0

Data_008_690B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of all", $F1
    db "monsters by "
    db $06, $00, $9D, $07, $00, $B5, $F0

Data_008_6931:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives a dead", $F1
    db "monster.", $F0

Data_008_6949:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 3.", $F0

Data_008_695A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 3.", $F0

Data_008_696B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 3.", $F0

Data_008_697C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 3.", $F0

Data_008_698D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 5.", $F0

Data_008_69A2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 5.", $F0

Data_008_69B7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "braver.", $F0

Data_008_69D0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more cowardly.", $F0

Data_008_69F0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more kindly.", $F0

Data_008_6A0E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more sly.", $F0

Data_008_6A29:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more thoughtful.", $F0

Data_008_6A4B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "simple-minded.", $F0

Data_008_6A6B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "just a little.", $F0

Data_008_6A89:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters a", $F1
    db "little bit.", $F0

Data_008_6AA6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters a", $F1
    db "lot.", $F0

Data_008_6ABC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "very much.", $F0

Data_008_6AD6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames a tiny bit,", $F1
    db "but also poisons.", $F0

Data_008_6AFA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "incredibly.", $F0

Data_008_6B15:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Checks if monster", $F1
    db "was caught before.", $F0

Data_008_6B3A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents monsters", $F1
    db "from appearing.", $F0

Data_008_6B5C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts monsters", $F1
    db "when strummed.", $F0

Data_008_6B7D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents casting", $F1
    db "of spells.", $F0

Data_008_6B99:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Doubles physical", $F1
    db "power of one.", $F0

Data_008_6BB8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with a windstorm.", $F0

Data_008_6BDB:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with lightning.", $F0

Data_008_6BFC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with a blizzard.", $F0

Data_008_6C1E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits one target", $F1
    db "with a fireball.", $F0

Data_008_6C3F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "the Door Shrine.", $F0

Data_008_6C63:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "GreatLog.", $F0

Data_008_6C80:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "the exit.", $F0

Data_008_6C9D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enables saving in", $F1
    db "the Journal.", $F0

Data_008_6CBC:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Collect and trade", $F1
    db "for rare gifts.", $F0

Data_008_6CDE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Get a 10-percent", $F1
    db "discount at shops.", $F0

Data_008_6D02:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moves the Door", $F1
    db "Shrine.", $F0

Data_008_6D19:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reveals Mirage", $F1
    db "Lake.", $F0

Data_008_6D2E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A magic stone that", $F1
    db "raises the tide.", $F0

Data_008_6D52:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A medal from the", $F1
    db "elemental spirit.", $F0

Data_008_6D75:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The lost soul of a", $F1
    db "princess.", $F0

Data_008_6D92:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A blue flower that", $F1
    db "grows in snow.", $F0

Data_008_6DB4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Transforms users", $F1
    db "into monsters.", $F0

Data_008_6DD4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a clam for", $F1
    db "crossing the sea.", $F0

Data_008_6DF9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Destroys what it", $F1
    db "reflects.", $F0

Data_008_6E14:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a cloud", $F1
    db "for flying.", $F0

Data_008_6E30:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary helmet", $F1
    db "found in a cave.", $F0

Data_008_6E54:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary armor", $F1
    db "found in a tower.", $F0

Data_008_6E78:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary sword", $F1
    db "found in a castle.", $F0

Data_008_6E9D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A magical stone", $F1
    db "that glows blue.", $F0

Data_008_6EBE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A beautiful gold", $F1
    db "ring.", $F0

Data_008_6ED5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

Data_008_6EE0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 30.", $F0

Data_008_6EF6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 80.", $F0

Data_008_6F0C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 30.", $F0

Data_008_6F22:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 80.", $F0

Data_008_6F38:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 10.", $F0

Data_008_6F4A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 50.", $F0

Data_008_6F5C:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 10.", $F0

Data_008_6F6E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 50.", $F0

Data_008_6F80:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 10.", $F0

Data_008_6F92:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 50.", $F0

Data_008_6FA4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 50.", $F0

Data_008_6FB6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 100.", $F0

Data_008_6FC9:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to attack spells.", $F0

Data_008_6FED:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to fire and ice.", $F0

Data_008_7010:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists confusion,", $F1
    db "poison "
    db $B6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " sleep.", $F0

Data_008_7033:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists most", $F1
    db "status skills.", $F0

Data_008_704F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists curse,", $F1
    db "paralysis "
    db $B6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " death.", $F0

Data_008_7071:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to water skills.", $F0

Data_008_7094:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents skills", $F1
    db "from being sealed.", $F0

Data_008_70B7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 5.", $F0

Data_008_70C8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

Data_008_70D3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP by 1", $F1
    db "on every step.", $F0

Data_008_70F3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores MP by 1", $F1
    db "on every step.", $F0

Data_008_7113:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes max. HP", $F1
    db "gain.", $F0

Data_008_712A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes max.", $F1
    db "MP gain.", $F0

Data_008_7141:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes ATK gain", $F1
    db "while growing.", $F0

Data_008_7162:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes DEF gain", $F1
    db "while growing.", $F0

Data_008_7183:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes AGL gain", $F1
    db "while growing.", $F0

Data_008_71A4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes INT gain", $F1
    db "while growing.", $F0

Data_008_71C5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

Data_008_71D0:: ; heuristic: string; C0
    db $F1, $F0

Data_008_71D2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Checks if monster", $F1
    db "was caught before.", $F0

Data_008_71F7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hotblood", $F0

Data_008_7200:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eager", $F0

Data_008_7206:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smug", $F0

Data_008_720B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Earnest", $F0

Data_008_7213:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pushy", $F0

Data_008_7219:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snobby", $F0

Data_008_7220:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reckless", $F0

Data_008_7229:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Daring", $F0

Data_008_7230:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Daredevil", $F0

Data_008_723A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cool"
    db $9E, $0C, $24, $2F, $30, $F0

Data_008_7244:: ; heuristic: string; C0
    db $1C, $28, $35, $2C, $32, $38, $36, $F0

Data_008_724C:: ; heuristic: string; C0
    db $1C, $28, $2F, $29, $2C, $36, $2B, $F0

Data_008_7254:: ; heuristic: string; C0
    db $1C, $2C, $30, $33, $2F, $28, $F0

Data_008_725B:: ; heuristic: string; C0
    db $12, $31, $31, $32, $26, $28, $31, $37, $F0

Data_008_7264:: ; heuristic: string; C0
    db $19, $35, $2C, $27, $28, $29, $38, $2F, $F0

Data_008_726D:: ; heuristic: string; C0
    db $17, $32, $36, $3C, $F0

Data_008_7272:: ; heuristic: string; C0
    db $20, $2B, $2C, $30, $36, $3C, $F0

Data_008_7279:: ; heuristic: string; C0
    db $1C, $33, $32, $2C, $2F, $28, $27, $F0

Data_008_7281:: ; heuristic: string; C0
    db $1C, $30, $24, $35, $37, $F0

Data_008_7287:: ; heuristic: string; C0
    db $1C, $2F, $3C, $F0

Data_008_728B:: ; heuristic: string; C0
    db $0C, $35, $38, $28, $2F, $F0

Data_008_7291:: ; heuristic: string; C0
    db $1C, $2B, $3C, $F0

Data_008_7295:: ; heuristic: string; C0
    db $0A, $29, $29, $24, $25, $2F, $28, $F0

Data_008_729D:: ; heuristic: string; C0
    db $0C, $32, $3A, $24, $35, $27, $F0

Data_008_72A4:: ; heuristic: string; C0
    db $10, $38, $2F, $2F, $2C, $25, $2F, $28, $F0

Data_008_72AD:: ; heuristic: string; C0
    db $0C, $24, $35, $28, $29, $35, $28, $28, $F0

Data_008_72B6:: ; heuristic: string; C0
    db $15, $24, $3D, $3C, $F0

Data_008_72BB:: ; heuristic: string; C0
    db $17, $32, $90, $2C, $37, $28, $30, $36, $F0

Data_008_72C4:: ; heuristic: string; C0
    db $1D, $32, $36, $36, $90, $37, $2B, $2C, $36, $90, $24, $3A, $24, $3C, $98, $F0

Data_008_72D4:: ; heuristic: string; C0
    db $F9, $20, $90, $26, $24, $31, $41, $90, $25, $28, $F1, $37, $32, $36, $36, $28
    db $27, $90, $32, $38, $37, $B5, $F7, $F0

Data_008_72EC:: ; heuristic: string; C0
    db $0B, $38, $37, $90, $31, $32, $37, $2B, $2C, $31, $2A, $F1, $2B, $24, $33, $33
    db $28, $31, $28, $27, $B5, $F7, $F0

Data_008_7303:: ; heuristic: string; C0
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " threw away", $F1
    db "the ", $F9, "W.", $F7
    db $F0

Data_008_7319:: ; heuristic: string; C0
    db $F9, $00, $F0

Data_008_731C:: ; heuristic: string; C0
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " tried using", $F1
    db $F9, "W.", $F7
    db $F2, "But nothing", $F1
    db "happened.", $F7
    db $F0

Data_008_7346:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Toss out the", $F1
    db $F9, "W?", $F0

Data_008_7357:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You can't toss", $F1
    db "that out!", $F7
    db $F0

Data_008_7370:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "That can't be used", $F1
    db "here.", $F7
    db $F0

Data_008_7389:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Not in use.", $F0

Data_008_7395:: ; heuristic: string; C0
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " inserted the", $F1
    db "key.", $F7
    db $F0

Data_008_73AA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The key could not", $F1
    db "be used yet.", $F7
    db $F0

Data_008_73CA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You can't save", $F1
    db "here.", $F7
    db $F0

Data_008_73DF:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No skills", $F0
    ds $C17, $00
