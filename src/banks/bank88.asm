SECTION "Bank 88", ROMX[$4000], BANK[$88]
    db $88

; ld de, this bank's string table / BeginStringDisplay
; 2 call sites from 2 routines (e.g. ShowString_Bank88, DebugMessageTest_Update_Case11)
BeginStringDisplay_Bank88::
Func_088_4001:: ; address name
    ld de, StringCategories_88_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_088_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 2 call sites from 2 routines (e.g. DebugShowMonsterRecord, DebugBattleSetupShowFieldString)
ShowString_Bank88::
Func_088_400F:: ; address name
    call BeginStringDisplay_Bank88
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_88_4016::
Data_088_4016:: ; address name
    dw StringList_88_401C ; id 0
    dw StringList_88_421C ; id 1
    dw StringList_88_441C ; id 2

; E-0217 (derived: category list of StringCategories_88_4016; one pointer per wStringIndex)
; record: string
StringList_88_401C::
Data_088_401C:: ; address name
    dw Data_088_461C ; id 0
    dw Data_088_4621 ; id 1
    dw Data_088_4627 ; id 2
    dw Data_088_4631 ; id 3
    dw Data_088_463B ; id 4
    dw Data_088_4645 ; id 5
    dw Data_088_464F ; id 6
    dw Data_088_4659 ; id 7
    dw Data_088_4659 ; id 8
    dw Data_088_4663 ; id 9
    dw Data_088_4669 ; id 10
    dw Data_088_4671 ; id 11
    dw Data_088_4678 ; id 12
    dw Data_088_4682 ; id 13
    dw Data_088_468B ; id 14
    dw Data_088_4690 ; id 15
    dw Data_088_4697 ; id 16
    dw Data_088_469F ; id 17
    dw Data_088_46A9 ; id 18
    dw Data_088_46B3 ; id 19
    dw Data_088_46BA ; id 20
    dw Data_088_46C4 ; id 21
    dw Data_088_46CA ; id 22
    dw Data_088_46D1 ; id 23
    dw Data_088_46DB ; id 24
    dw Data_088_46E4 ; id 25
    dw Data_088_46ED ; id 26
    dw Data_088_46ED ; id 27
    dw Data_088_46F7 ; id 28
    dw Data_088_4700 ; id 29
    dw Data_088_4709 ; id 30
    dw Data_088_4712 ; id 31
    dw Data_088_4719 ; id 32
    dw Data_088_4721 ; id 33
    dw Data_088_472B ; id 34
    dw Data_088_4734 ; id 35
    dw Data_088_473E ; id 36
    dw Data_088_4747 ; id 37
    dw Data_088_474F ; id 38
    dw Data_088_4758 ; id 39
    dw Data_088_4761 ; id 40
    dw Data_088_476B ; id 41
    dw Data_088_4775 ; id 42
    dw Data_088_477F ; id 43
    dw Data_088_4784 ; id 44
    dw Data_088_4788 ; id 45
    dw Data_088_478E ; id 46
    dw Data_088_4794 ; id 47
    dw Data_088_479A ; id 48
    dw Data_088_47A0 ; id 49
    dw Data_088_47A8 ; id 50
    dw Data_088_47B1 ; id 51
    dw Data_088_47BB ; id 52
    dw Data_088_47C3 ; id 53
    dw Data_088_47CC ; id 54
    dw Data_088_47D4 ; id 55
    dw Data_088_47DC ; id 56
    dw Data_088_47E4 ; id 57
    dw Data_088_47EC ; id 58
    dw Data_088_47F5 ; id 59
    dw Data_088_47FC ; id 60
    dw Data_088_4806 ; id 61
    dw Data_088_480F ; id 62
    dw Data_088_4819 ; id 63
    dw Data_088_4822 ; id 64
    dw Data_088_482B ; id 65
    dw Data_088_4834 ; id 66
    dw Data_088_483D ; id 67
    dw Data_088_4847 ; id 68
    dw Data_088_4850 ; id 69
    dw Data_088_485A ; id 70
    dw Data_088_4864 ; id 71
    dw Data_088_486D ; id 72
    dw Data_088_4872 ; id 73
    dw Data_088_487B ; id 74
    dw Data_088_4885 ; id 75
    dw Data_088_488E ; id 76
    dw Data_088_4898 ; id 77
    dw Data_088_489F ; id 78
    dw Data_088_48A8 ; id 79
    dw Data_088_48B2 ; id 80
    dw Data_088_48BB ; id 81
    dw Data_088_48C5 ; id 82
    dw Data_088_48CF ; id 83
    dw Data_088_48D7 ; id 84
    dw Data_088_48E0 ; id 85
    dw Data_088_48E8 ; id 86
    dw Data_088_48F0 ; id 87
    dw Data_088_48F9 ; id 88
    dw Data_088_4900 ; id 89
    dw Data_088_4909 ; id 90
    dw Data_088_4910 ; id 91
    dw Data_088_4917 ; id 92
    dw Data_088_4920 ; id 93
    dw Data_088_492A ; id 94
    dw Data_088_4933 ; id 95
    dw Data_088_493C ; id 96
    dw Data_088_4945 ; id 97
    dw Data_088_494F ; id 98
    dw Data_088_4959 ; id 99
    dw Data_088_4961 ; id 100
    dw Data_088_496A ; id 101
    dw Data_088_4972 ; id 102
    dw Data_088_497C ; id 103
    dw Data_088_4986 ; id 104
    dw Data_088_498F ; id 105
    dw Data_088_4999 ; id 106
    dw Data_088_49A3 ; id 107
    dw Data_088_49A9 ; id 108
    dw Data_088_49B3 ; id 109
    dw Data_088_49BC ; id 110
    dw Data_088_49C5 ; id 111
    dw Data_088_49CE ; id 112
    dw Data_088_49D8 ; id 113
    dw Data_088_49E2 ; id 114
    dw Data_088_49EC ; id 115
    dw Data_088_49F6 ; id 116
    dw Data_088_4A00 ; id 117
    dw Data_088_4A09 ; id 118
    dw Data_088_4A09 ; id 119
    dw Data_088_4A09 ; id 120
    dw Data_088_4A09 ; id 121
    dw Data_088_4A09 ; id 122
    dw Data_088_4A09 ; id 123
    dw Data_088_4A09 ; id 124
    dw Data_088_4A09 ; id 125
    dw Data_088_4A0F ; id 126
    dw Data_088_4A15 ; id 127
    dw Data_088_4A1B ; id 128
    dw Data_088_4A21 ; id 129
    dw Data_088_4A27 ; id 130
    dw Data_088_4A30 ; id 131
    dw Data_088_4A37 ; id 132
    dw Data_088_4A40 ; id 133
    dw Data_088_4A49 ; id 134
    dw Data_088_4A52 ; id 135
    dw Data_088_4A59 ; id 136
    dw Data_088_4A62 ; id 137
    dw Data_088_4A6B ; id 138
    dw Data_088_4A75 ; id 139
    dw Data_088_4A7B ; id 140
    dw Data_088_4A85 ; id 141
    dw Data_088_4A8E ; id 142
    dw Data_088_4A96 ; id 143
    dw Data_088_4AA0 ; id 144
    dw Data_088_4AAA ; id 145
    dw Data_088_4AB3 ; id 146
    dw Data_088_4ABB ; id 147
    dw Data_088_4AC3 ; id 148
    dw Data_088_4ACC ; id 149
    dw Data_088_4AD3 ; id 150
    dw Data_088_4ADB ; id 151
    dw Data_088_4AE5 ; id 152
    dw Data_088_4AED ; id 153
    dw Data_088_4AF4 ; id 154
    dw Data_088_4AFE ; id 155
    dw Data_088_4B08 ; id 156
    dw Data_088_4B12 ; id 157
    dw Data_088_4B1A ; id 158
    dw Data_088_4B24 ; id 159
    dw Data_088_4B2E ; id 160
    dw Data_088_4B36 ; id 161
    dw Data_088_4B3F ; id 162
    dw Data_088_4B45 ; id 163
    dw Data_088_4B4D ; id 164
    dw Data_088_4B56 ; id 165
    dw Data_088_4B5F ; id 166
    dw Data_088_4B66 ; id 167
    dw Data_088_4B70 ; id 168
    dw Data_088_4B7A ; id 169
    dw Data_088_4B82 ; id 170
    dw Data_088_4B8A ; id 171
    dw Data_088_4B94 ; id 172
    dw Data_088_4B9D ; id 173
    dw Data_088_4BA7 ; id 174
    dw Data_088_4BB0 ; id 175
    dw Data_088_4BB7 ; id 176
    dw Data_088_4BC0 ; id 177
    dw Data_088_4BC8 ; id 178
    dw Data_088_4BD1 ; id 179
    dw Data_088_4BDB ; id 180
    dw Data_088_4BE2 ; id 181
    dw Data_088_4BE9 ; id 182
    dw Data_088_4BEF ; id 183
    dw Data_088_4BF8 ; id 184
    dw Data_088_4C01 ; id 185
    dw Data_088_4C0A ; id 186
    dw Data_088_4C12 ; id 187
    dw Data_088_4C1B ; id 188
    dw Data_088_4C25 ; id 189
    dw Data_088_4C2F ; id 190
    dw Data_088_4C36 ; id 191
    dw Data_088_4C3D ; id 192
    dw Data_088_4C46 ; id 193
    dw Data_088_4C4E ; id 194
    dw Data_088_4C58 ; id 195
    dw Data_088_4C5E ; id 196
    dw Data_088_4C63 ; id 197
    dw Data_088_4C6B ; id 198
    dw Data_088_4C70 ; id 199
    dw Data_088_4C7A ; id 200
    dw Data_088_4C83 ; id 201
    dw Data_088_4C89 ; id 202
    dw Data_088_4C91 ; id 203
    dw Data_088_4C9B ; id 204
    dw Data_088_4CA5 ; id 205
    dw Data_088_4CAC ; id 206
    dw Data_088_4CB4 ; id 207
    dw Data_088_4CBC ; id 208
    dw Data_088_4CC1 ; id 209
    dw Data_088_4CC9 ; id 210
    dw Data_088_4CD2 ; id 211
    dw Data_088_4CDC ; id 212
    dw Data_088_4CE6 ; id 213
    dw Data_088_4CEF ; id 214
    dw Data_088_4CF9 ; id 215
    dw Data_088_4D02 ; id 216
    dw Data_088_4D0C ; id 217
    dw Data_088_4D15 ; id 218
    dw Data_088_4D1B ; id 219
    dw Data_088_4D23 ; id 220
    dw Data_088_4D2A ; id 221
    dw Data_088_4D33 ; id 222
    dw Data_088_4D3C ; id 223
    dw Data_088_4D45 ; id 224
    dw Data_088_4D4E ; id 225
    dw Data_088_4D58 ; id 226
    dw Data_088_4D60 ; id 227
    dw Data_088_4D6A ; id 228
    dw Data_088_4D73 ; id 229
    dw Data_088_4D7B ; id 230
    dw Data_088_4D83 ; id 231
    dw Data_088_4D8D ; id 232
    dw Data_088_4D97 ; id 233
    dw Data_088_4DA1 ; id 234
    dw Data_088_4DAB ; id 235
    dw Data_088_4DB3 ; id 236
    dw Data_088_4DBA ; id 237
    dw Data_088_4DC3 ; id 238
    dw Data_088_4DCD ; id 239
    dw Data_088_4DD7 ; id 240
    dw Data_088_4DE1 ; id 241
    dw Data_088_4DE9 ; id 242
    dw Data_088_4DF2 ; id 243
    dw Data_088_4DFB ; id 244
    dw Data_088_4E03 ; id 245
    dw Data_088_4E0D ; id 246
    dw Data_088_4E16 ; id 247
    dw Data_088_4E1D ; id 248
    dw Data_088_4E26 ; id 249
    dw Data_088_4E2E ; id 250
    dw Data_088_4E38 ; id 251
    dw Data_088_4E41 ; id 252
    dw Data_088_4E4A ; id 253
    dw Data_088_4E51 ; id 254
    dw Data_088_4E58 ; id 255

; E-0217 (derived: category list of StringCategories_88_4016; one pointer per wStringIndex)
; record: string
StringList_88_421C::
Data_088_421C:: ; address name
    dw Data_088_4E61 ; id 0
    dw Data_088_4E6A ; id 1
    dw Data_088_4E73 ; id 2
    dw Data_088_4E7B ; id 3
    dw Data_088_4E83 ; id 4
    dw Data_088_4E89 ; id 5
    dw Data_088_4E93 ; id 6
    dw Data_088_4E9A ; id 7
    dw Data_088_4EA3 ; id 8
    dw Data_088_4EAD ; id 9
    dw Data_088_4EB6 ; id 10
    dw Data_088_4EBF ; id 11
    dw Data_088_4EC9 ; id 12
    dw Data_088_4ED2 ; id 13
    dw Data_088_4EDC ; id 14
    dw Data_088_4EE6 ; id 15
    dw Data_088_4EED ; id 16
    dw Data_088_4EF4 ; id 17
    dw Data_088_4EFD ; id 18
    dw Data_088_4F06 ; id 19
    dw Data_088_4F0D ; id 20
    dw Data_088_4F16 ; id 21
    dw Data_088_4F1D ; id 22
    dw Data_088_4F27 ; id 23
    dw Data_088_4F31 ; id 24
    dw Data_088_4F3A ; id 25
    dw Data_088_4F44 ; id 26
    dw Data_088_4F4D ; id 27
    dw Data_088_4F56 ; id 28
    dw Data_088_4F60 ; id 29
    dw Data_088_4F69 ; id 30
    dw Data_088_4F72 ; id 31
    dw Data_088_4F7C ; id 32
    dw Data_088_4F85 ; id 33
    dw Data_088_4F8C ; id 34
    dw Data_088_4F96 ; id 35
    dw Data_088_4FA0 ; id 36
    dw Data_088_4FAA ; id 37
    dw Data_088_4FAE ; id 38
    dw Data_088_4FB8 ; id 39
    dw Data_088_4FBE ; id 40
    dw Data_088_4FC8 ; id 41
    dw Data_088_4FD2 ; id 42
    dw Data_088_4FDB ; id 43
    dw Data_088_4FE4 ; id 44
    dw Data_088_4FEC ; id 45
    dw Data_088_4FF6 ; id 46
    dw Data_088_5000 ; id 47
    dw Data_088_500A ; id 48
    dw Data_088_5014 ; id 49
    dw Data_088_501C ; id 50
    dw Data_088_5026 ; id 51
    dw Data_088_5030 ; id 52
    dw Data_088_5035 ; id 53
    dw Data_088_503F ; id 54
    dw Data_088_5048 ; id 55
    dw Data_088_5051 ; id 56
    dw Data_088_505B ; id 57
    dw Data_088_5064 ; id 58
    dw Data_088_506C ; id 59
    dw Data_088_5073 ; id 60
    dw Data_088_507D ; id 61
    dw Data_088_5087 ; id 62
    dw Data_088_508E ; id 63
    dw Data_088_5095 ; id 64
    dw Data_088_509F ; id 65
    dw Data_088_50A8 ; id 66
    dw Data_088_50B0 ; id 67
    dw Data_088_50B9 ; id 68
    dw Data_088_50C1 ; id 69
    dw Data_088_50C8 ; id 70
    dw Data_088_50D0 ; id 71
    dw Data_088_50DA ; id 72
    dw Data_088_50E4 ; id 73
    dw Data_088_50ED ; id 74
    dw Data_088_50F7 ; id 75
    dw Data_088_50FE ; id 76
    dw Data_088_5106 ; id 77
    dw Data_088_510F ; id 78
    dw Data_088_5119 ; id 79
    dw Data_088_5120 ; id 80
    dw Data_088_5129 ; id 81
    dw Data_088_5133 ; id 82
    dw Data_088_513D ; id 83
    dw Data_088_5146 ; id 84
    dw Data_088_514F ; id 85
    dw Data_088_5159 ; id 86
    dw Data_088_5163 ; id 87
    dw Data_088_516C ; id 88
    dw Data_088_5176 ; id 89
    dw Data_088_5180 ; id 90
    dw Data_088_5189 ; id 91
    dw Data_088_5192 ; id 92
    dw Data_088_519A ; id 93
    dw Data_088_51A3 ; id 94
    dw Data_088_51A9 ; id 95
    dw Data_088_51B1 ; id 96
    dw Data_088_51B7 ; id 97
    dw Data_088_51C1 ; id 98
    dw Data_088_51CA ; id 99
    dw Data_088_51D4 ; id 100
    dw Data_088_51DD ; id 101
    dw Data_088_51E6 ; id 102
    dw Data_088_51EE ; id 103
    dw Data_088_51F7 ; id 104
    dw Data_088_5201 ; id 105
    dw Data_088_520A ; id 106
    dw Data_088_5213 ; id 107
    dw Data_088_521D ; id 108
    dw Data_088_5227 ; id 109
    dw Data_088_5231 ; id 110
    dw Data_088_523B ; id 111
    dw Data_088_5243 ; id 112
    dw Data_088_524C ; id 113
    dw Data_088_5253 ; id 114
    dw Data_088_525D ; id 115
    dw Data_088_5267 ; id 116
    dw Data_088_5271 ; id 117
    dw Data_088_527B ; id 118
    dw Data_088_5283 ; id 119
    dw Data_088_528C ; id 120
    dw Data_088_5294 ; id 121
    dw Data_088_529A ; id 122
    dw Data_088_52A1 ; id 123
    dw Data_088_52AA ; id 124
    dw Data_088_52B4 ; id 125
    dw Data_088_52BC ; id 126
    dw Data_088_52C4 ; id 127
    dw Data_088_52CA ; id 128
    dw Data_088_52D4 ; id 129
    dw Data_088_52DB ; id 130
    dw Data_088_52DB ; id 131
    dw Data_088_52E3 ; id 132
    dw Data_088_52ED ; id 133
    dw Data_088_52F6 ; id 134
    dw Data_088_52FD ; id 135
    dw Data_088_5306 ; id 136
    dw Data_088_530C ; id 137
    dw Data_088_5316 ; id 138
    dw Data_088_531F ; id 139
    dw Data_088_5328 ; id 140
    dw Data_088_5331 ; id 141
    dw Data_088_533B ; id 142
    dw Data_088_5342 ; id 143
    dw Data_088_534C ; id 144
    dw Data_088_5356 ; id 145
    dw Data_088_5360 ; id 146
    dw Data_088_5367 ; id 147
    dw Data_088_5370 ; id 148
    dw Data_088_537A ; id 149
    dw Data_088_5384 ; id 150
    dw Data_088_538D ; id 151
    dw Data_088_5394 ; id 152
    dw Data_088_539D ; id 153
    dw Data_088_53A5 ; id 154
    dw Data_088_53AE ; id 155
    dw Data_088_53B7 ; id 156
    dw Data_088_53C0 ; id 157
    dw Data_088_53CA ; id 158
    dw Data_088_53D2 ; id 159
    dw Data_088_53DB ; id 160
    dw Data_088_53E1 ; id 161
    dw Data_088_53EA ; id 162
    dw Data_088_53F2 ; id 163
    dw Data_088_53FC ; id 164
    dw Data_088_5404 ; id 165
    dw Data_088_540D ; id 166
    dw Data_088_5416 ; id 167
    dw Data_088_541F ; id 168
    dw Data_088_5428 ; id 169
    dw Data_088_5431 ; id 170
    dw Data_088_543A ; id 171
    dw Data_088_543A ; id 172
    dw Data_088_5444 ; id 173
    dw Data_088_544E ; id 174
    dw Data_088_5458 ; id 175
    dw Data_088_5462 ; id 176
    dw Data_088_546C ; id 177
    dw Data_088_5475 ; id 178
    dw Data_088_547F ; id 179
    dw Data_088_5488 ; id 180
    dw Data_088_5492 ; id 181
    dw Data_088_5499 ; id 182
    dw Data_088_54A0 ; id 183
    dw Data_088_54A7 ; id 184
    dw Data_088_54AE ; id 185
    dw Data_088_54B7 ; id 186
    dw Data_088_54BF ; id 187
    dw Data_088_54C9 ; id 188
    dw Data_088_54D1 ; id 189
    dw Data_088_54DB ; id 190
    dw Data_088_54E4 ; id 191
    dw Data_088_54EC ; id 192
    dw Data_088_54F6 ; id 193
    dw Data_088_54FF ; id 194
    dw Data_088_5509 ; id 195
    dw Data_088_5513 ; id 196
    dw Data_088_551D ; id 197
    dw Data_088_5526 ; id 198
    dw Data_088_552A ; id 199
    dw Data_088_5533 ; id 200
    dw Data_088_553C ; id 201
    dw Data_088_5543 ; id 202
    dw Data_088_554B ; id 203
    dw Data_088_5555 ; id 204
    dw Data_088_555C ; id 205
    dw Data_088_5566 ; id 206
    dw Data_088_556E ; id 207
    dw Data_088_5578 ; id 208
    dw Data_088_557F ; id 209
    dw Data_088_5587 ; id 210
    dw Data_088_5590 ; id 211
    dw Data_088_5596 ; id 212
    dw Data_088_55A0 ; id 213
    dw Data_088_55A9 ; id 214
    dw Data_088_55B0 ; id 215
    dw Data_088_55B8 ; id 216
    dw Data_088_55C2 ; id 217
    dw Data_088_55CB ; id 218
    dw Data_088_55D4 ; id 219
    dw Data_088_55DD ; id 220
    dw Data_088_55E5 ; id 221
    dw Data_088_55ED ; id 222
    dw Data_088_55F6 ; id 223
    dw Data_088_55FF ; id 224
    dw Data_088_5607 ; id 225
    dw Data_088_5610 ; id 226
    dw Data_088_5618 ; id 227
    dw Data_088_5620 ; id 228
    dw Data_088_562A ; id 229
    dw Data_088_5634 ; id 230
    dw Data_088_563E ; id 231
    dw Data_088_5645 ; id 232
    dw Data_088_564F ; id 233
    dw Data_088_564F ; id 234
    dw Data_088_564F ; id 235
    dw Data_088_564F ; id 236
    dw Data_088_5658 ; id 237
    dw Data_088_5660 ; id 238
    dw Data_088_5669 ; id 239
    dw Data_088_566E ; id 240
    dw Data_088_5678 ; id 241
    dw Data_088_567F ; id 242
    dw Data_088_5685 ; id 243
    dw Data_088_568D ; id 244
    dw Data_088_5697 ; id 245
    dw Data_088_56A0 ; id 246
    dw Data_088_56A9 ; id 247
    dw Data_088_56B3 ; id 248
    dw Data_088_56B8 ; id 249
    dw Data_088_56C0 ; id 250
    dw Data_088_56C9 ; id 251
    dw Data_088_56D2 ; id 252
    dw Data_088_56DC ; id 253
    dw Data_088_56E6 ; id 254
    dw Data_088_56EC ; id 255

; E-0217 (derived: category list of StringCategories_88_4016; one pointer per wStringIndex)
; record: string
StringList_88_441C::
Data_088_441C:: ; address name
    dw Data_088_56F6 ; id 0
    dw Data_088_5700 ; id 1
    dw Data_088_5709 ; id 2
    dw Data_088_5712 ; id 3
    dw Data_088_571C ; id 4
    dw Data_088_5726 ; id 5
    dw Data_088_5730 ; id 6
    dw Data_088_5738 ; id 7
    dw Data_088_5742 ; id 8
    dw Data_088_574C ; id 9
    dw Data_088_5754 ; id 10
    dw Data_088_575B ; id 11
    dw Data_088_5764 ; id 12
    dw Data_088_576E ; id 13
    dw Data_088_5777 ; id 14
    dw Data_088_5781 ; id 15
    dw Data_088_578B ; id 16
    dw Data_088_5795 ; id 17
    dw Data_088_579C ; id 18
    dw Data_088_57A4 ; id 19
    dw Data_088_57AE ; id 20
    dw Data_088_57B8 ; id 21
    dw Data_088_57BF ; id 22
    dw Data_088_57C8 ; id 23
    dw Data_088_57CF ; id 24
    dw Data_088_57D8 ; id 25
    dw Data_088_57DF ; id 26
    dw Data_088_57E5 ; id 27
    dw Data_088_57EF ; id 28
    dw Data_088_57F8 ; id 29
    dw Data_088_57FF ; id 30
    dw Data_088_5807 ; id 31
    dw Data_088_580F ; id 32
    dw Data_088_5819 ; id 33
    dw Data_088_5822 ; id 34
    dw Data_088_5829 ; id 35
    dw Data_088_5832 ; id 36
    dw Data_088_583C ; id 37
    dw Data_088_5845 ; id 38
    dw Data_088_584D ; id 39
    dw Data_088_5856 ; id 40
    dw Data_088_585E ; id 41
    dw Data_088_5868 ; id 42
    dw Data_088_5871 ; id 43
    dw Data_088_587A ; id 44
    dw Data_088_5884 ; id 45
    dw Data_088_588E ; id 46
    dw Data_088_5895 ; id 47
    dw Data_088_589F ; id 48
    dw Data_088_58A9 ; id 49
    dw Data_088_58B3 ; id 50
    dw Data_088_58BD ; id 51
    dw Data_088_58C7 ; id 52
    dw Data_088_58CE ; id 53
    dw Data_088_58D8 ; id 54
    dw Data_088_58DF ; id 55
    dw Data_088_58E8 ; id 56
    dw Data_088_58F0 ; id 57
    dw Data_088_58F8 ; id 58
    dw Data_088_5901 ; id 59
    dw Data_088_590A ; id 60
    dw Data_088_5914 ; id 61
    dw Data_088_591E ; id 62
    dw Data_088_5927 ; id 63
    dw Data_088_592F ; id 64
    dw Data_088_5937 ; id 65
    dw Data_088_5940 ; id 66
    dw Data_088_5949 ; id 67
    dw Data_088_5953 ; id 68
    dw Data_088_595C ; id 69
    dw Data_088_5966 ; id 70
    dw Data_088_5970 ; id 71
    dw Data_088_597A ; id 72
    dw Data_088_5981 ; id 73
    dw Data_088_5986 ; id 74
    dw Data_088_598F ; id 75
    dw Data_088_5994 ; id 76
    dw Data_088_599D ; id 77
    dw Data_088_59A7 ; id 78
    dw Data_088_59B1 ; id 79
    dw Data_088_59BB ; id 80
    dw Data_088_59C5 ; id 81
    dw Data_088_59CF ; id 82
    dw Data_088_59D7 ; id 83
    dw Data_088_59E0 ; id 84
    dw Data_088_59E9 ; id 85
    dw Data_088_59F3 ; id 86
    dw Data_088_59FA ; id 87
    dw Data_088_5A02 ; id 88
    dw Data_088_5A0A ; id 89
    dw Data_088_5A12 ; id 90
    dw Data_088_5A1B ; id 91
    dw Data_088_5A24 ; id 92
    dw Data_088_5A2E ; id 93
    dw Data_088_5A36 ; id 94
    dw Data_088_5A3E ; id 95
    dw Data_088_5A45 ; id 96
    dw Data_088_5A4B ; id 97
    dw Data_088_5A54 ; id 98
    dw Data_088_5A5E ; id 99
    dw Data_088_5A67 ; id 100
    dw Data_088_5A70 ; id 101
    dw Data_088_5A79 ; id 102
    dw Data_088_5A83 ; id 103
    dw Data_088_5A8D ; id 104
    dw Data_088_5A97 ; id 105
    dw Data_088_5AA0 ; id 106
    dw Data_088_5AA8 ; id 107
    dw Data_088_5AB0 ; id 108
    dw Data_088_5AB9 ; id 109
    dw Data_088_5AC2 ; id 110
    dw Data_088_5ACA ; id 111
    dw Data_088_5AD3 ; id 112
    dw Data_088_5ADA ; id 113
    dw Data_088_5AE3 ; id 114
    dw Data_088_5AED ; id 115
    dw Data_088_5AF6 ; id 116
    dw Data_088_5AFF ; id 117
    dw Data_088_5B08 ; id 118
    dw Data_088_5B12 ; id 119
    dw Data_088_5B19 ; id 120
    dw Data_088_5B21 ; id 121
    dw Data_088_5B2B ; id 122
    dw Data_088_5B31 ; id 123
    dw Data_088_5B31 ; id 124
    dw Data_088_5B3B ; id 125
    dw Data_088_5B45 ; id 126
    dw Data_088_5B4C ; id 127
    dw Data_088_5B52 ; id 128
    dw Data_088_5B5C ; id 129
    dw Data_088_5B64 ; id 130
    dw Data_088_5B69 ; id 131
    dw Data_088_5B73 ; id 132
    dw Data_088_5B7B ; id 133
    dw Data_088_5B85 ; id 134
    dw Data_088_5B8C ; id 135
    dw Data_088_5B8C ; id 136
    dw Data_088_5B96 ; id 137
    dw Data_088_5B9C ; id 138
    dw Data_088_5B9C ; id 139
    dw Data_088_5B9C ; id 140
    dw Data_088_5BA6 ; id 141
    dw Data_088_5BB0 ; id 142
    dw Data_088_5BB0 ; id 143
    dw Data_088_5BBA ; id 144
    dw Data_088_5BC0 ; id 145
    dw Data_088_5BCA ; id 146
    dw Data_088_5BD4 ; id 147
    dw Data_088_5BDE ; id 148
    dw Data_088_5BE8 ; id 149
    dw Data_088_5BF0 ; id 150
    dw Data_088_5BFA ; id 151
    dw Data_088_5C03 ; id 152
    dw Data_088_5C0A ; id 153
    dw Data_088_5C13 ; id 154
    dw Data_088_5C1B ; id 155
    dw Data_088_5C23 ; id 156
    dw Data_088_5C2B ; id 157
    dw Data_088_5C33 ; id 158
    dw Data_088_5C3C ; id 159
    dw Data_088_5C44 ; id 160
    dw Data_088_5C4E ; id 161
    dw Data_088_5C56 ; id 162
    dw Data_088_5C60 ; id 163
    dw Data_088_5C69 ; id 164
    dw Data_088_5C73 ; id 165
    dw Data_088_5C7D ; id 166
    dw Data_088_5C87 ; id 167
    dw Data_088_5C90 ; id 168
    dw Data_088_5C98 ; id 169
    dw Data_088_5CA1 ; id 170
    dw Data_088_5CA8 ; id 171
    dw Data_088_5CB1 ; id 172
    dw Data_088_5CB7 ; id 173
    dw Data_088_5CB7 ; id 174
    dw Data_088_5CB7 ; id 175
    dw Data_088_5CB7 ; id 176
    dw Data_088_5CB7 ; id 177
    dw Data_088_5CB7 ; id 178
    dw Data_088_5CB7 ; id 179
    dw Data_088_5CB7 ; id 180
    dw Data_088_5CB7 ; id 181
    dw Data_088_5CB7 ; id 182
    dw Data_088_5CB7 ; id 183
    dw Data_088_5CB7 ; id 184
    dw Data_088_5CB7 ; id 185
    dw Data_088_5CB7 ; id 186
    dw Data_088_5CB7 ; id 187
    dw Data_088_5CB7 ; id 188
    dw Data_088_5CB7 ; id 189
    dw Data_088_5CB7 ; id 190
    dw Data_088_5CB7 ; id 191
    dw Data_088_5CB7 ; id 192
    dw Data_088_5CB7 ; id 193
    dw Data_088_5CB7 ; id 194
    dw Data_088_5CB7 ; id 195
    dw Data_088_5CB7 ; id 196
    dw Data_088_5CB7 ; id 197
    dw Data_088_5CB7 ; id 198
    dw Data_088_5CB7 ; id 199
    dw Data_088_5CB7 ; id 200
    dw Data_088_5CB7 ; id 201
    dw Data_088_5CB7 ; id 202
    dw Data_088_5CB7 ; id 203
    dw Data_088_5CB7 ; id 204
    dw Data_088_5CB7 ; id 205
    dw Data_088_5CB7 ; id 206
    dw Data_088_5CB7 ; id 207
    dw Data_088_5CB7 ; id 208
    dw Data_088_5CB7 ; id 209
    dw Data_088_5CB7 ; id 210
    dw Data_088_5CB7 ; id 211
    dw Data_088_5CB7 ; id 212
    dw Data_088_5CB7 ; id 213
    dw Data_088_5CB7 ; id 214
    dw Data_088_5CB7 ; id 215
    dw Data_088_5CB7 ; id 216
    dw Data_088_5CB7 ; id 217
    dw Data_088_5CB7 ; id 218
    dw Data_088_5CB7 ; id 219
    dw Data_088_5CB7 ; id 220
    dw Data_088_5CB7 ; id 221
    dw Data_088_5CB7 ; id 222
    dw Data_088_5CB7 ; id 223
    dw Data_088_5CB7 ; id 224
    dw Data_088_5CB7 ; id 225
    dw Data_088_5CB7 ; id 226
    dw Data_088_5CB7 ; id 227
    dw Data_088_5CB7 ; id 228
    dw Data_088_5CB7 ; id 229
    dw Data_088_5CB7 ; id 230
    dw Data_088_5CB7 ; id 231
    dw Data_088_5CB7 ; id 232
    dw Data_088_5CB7 ; id 233
    dw Data_088_5CB7 ; id 234
    dw Data_088_5CB7 ; id 235
    dw Data_088_5CB7 ; id 236
    dw Data_088_5CB7 ; id 237
    dw Data_088_5CB7 ; id 238
    dw Data_088_5CB7 ; id 239
    dw Data_088_5CB7 ; id 240
    dw Data_088_5CB7 ; id 241
    dw Data_088_5CB7 ; id 242
    dw Data_088_5CB7 ; id 243
    dw Data_088_5CB7 ; id 244
    dw Data_088_5CB7 ; id 245
    dw Data_088_5CB7 ; id 246
    dw Data_088_5CB7 ; id 247
    dw Data_088_5CB7 ; id 248
    dw Data_088_5CB7 ; id 249
    dw Data_088_5CB7 ; id 250
    dw Data_088_5CB7 ; id 251
    dw Data_088_5CB7 ; id 252
    dw Data_088_5CB7 ; id 253
    dw Data_088_5CB7 ; id 254
    dw Data_088_5CB7 ; id 255

Data_088_461C:: ; heuristic: string; C0
    db $17, $32, $31, $28, $F0

Data_088_4621:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_088_4627:: ; heuristic: string; C0
    db $1C, $33, $32, $37, $1C, $2F, $2C, $30, $28, $F0

Data_088_4631:: ; heuristic: string; C0
    db $0C, $24, $26, $37, $2C, $0B, $24, $2F, $2F, $F0

Data_088_463B:: ; heuristic: string; C0
    db $1D, $24, $2C, $2F, $0E, $24, $37, $28, $35, $F0

Data_088_4645:: ; heuristic: string; C0
    db $0C, $35, $28, $36, $37, $33, $28, $31, $37, $F0

Data_088_464F:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $0C, $32, $25, $35, $24, $F0

Data_088_4659:: ; heuristic: string; C0
    db $0C, $38, $35, $36, $28, $15, $24, $30, $33, $F0

Data_088_4663:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_088_4669:: ; heuristic: string; C0
    db $0A, $31, $37, $25, $28, $24, $35, $F0

Data_088_4671:: ; heuristic: string; C0
    db $0D, $35, $24, $26, $2E, $3C, $F0

Data_088_4678:: ; heuristic: string; C0
    db $0E, $2A, $2A, $33, $2F, $24, $37, $32, $31, $F0

Data_088_4682:: ; heuristic: string; C0
    db $13, $28, $3A, $28, $2F, $0B, $24, $2A, $F0

Data_088_468B:: ; heuristic: string; C0
    db $11, $32, $35, $2E, $F0

Data_088_4690:: ; heuristic: string; C0
    db $20, $3C, $39, $28, $35, $31, $F0

Data_088_4697:: ; heuristic: string; C0
    db $0A, $35, $30, $3C, $0A, $31, $37, $F0

Data_088_469F:: ; heuristic: string; C0
    db $16, $24, $27, $10, $32, $33, $2B, $28, $35, $F0

Data_088_46A9:: ; heuristic: string; C0
    db $01, $0E, $3C, $28, $0C, $2F, $32, $3A, $31, $F0

Data_088_46B3:: ; heuristic: string; C0
    db $1C, $31, $24, $2C, $2F, $3C, $F0

Data_088_46BA:: ; heuristic: string; C0
    db $19, $32, $2C, $36, $32, $31, $2A, $32, $31, $F0

Data_088_46C4:: ; heuristic: string; C0
    db $16, $32, $35, $24, $3C, $F0

Data_088_46CA:: ; heuristic: string; C0
    db $0E, $3C, $28, $27, $28, $35, $F0

Data_088_46D1:: ; heuristic: string; C0
    db $19, $38, $37, $35, $28, $0F, $2C, $36, $2B, $F0

Data_088_46DB:: ; heuristic: string; C0
    db $10, $24, $30, $24, $31, $2C, $24, $31, $F0

Data_088_46E4:: ; heuristic: string; C0
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $F0

Data_088_46ED:: ; heuristic: string; C0
    db $11, $32, $32, $27, $1C, $34, $38, $2C, $27, $F0

Data_088_46F7:: ; heuristic: string; C0
    db $0C, $24, $33, $37, $0D, $28, $24, $27, $F0

Data_088_4700:: ; heuristic: string; C0
    db $19, $28, $37, $2C, $37, $28, $28, $2F, $F0

Data_088_4709:: ; heuristic: string; C0
    db $1B, $32, $37, $1B, $24, $39, $28, $31, $F0

Data_088_4712:: ; heuristic: string; C0
    db $16, $28, $35, $30, $24, $31, $F0

Data_088_4719:: ; heuristic: string; C0
    db $18, $26, $37, $32, $2E, $2C, $27, $F0

Data_088_4721:: ; heuristic: string; C0
    db $1B, $32, $2A, $38, $28, $20, $24, $39, $28, $F0

Data_088_472B:: ; heuristic: string; C0
    db $19, $28, $24, $35, $2F, $10, $28, $2F, $F0

Data_088_4734:: ; heuristic: string; C0
    db $1D, $32, $35, $37, $35, $24, $2A, $32, $31, $F0

Data_088_473E:: ; heuristic: string; C0
    db $0A, $34, $38, $24, $11, $24, $3A, $2E, $F0

Data_088_4747:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $0E, $3C, $28, $F0

Data_088_474F:: ; heuristic: string; C0
    db $1B, $24, $3C, $10, $2C, $2A, $24, $36, $F0

Data_088_4758:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $20, $24, $31, $27, $F0

Data_088_4761:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $17, $2C, $37, $28, $F0

Data_088_476B:: ; heuristic: string; C0
    db $15, $2C, $3D, $24, $35, $27, $16, $24, $31, $F0

Data_088_4775:: ; heuristic: string; C0
    db $11, $24, $30, $30, $28, $35, $16, $24, $31, $F0

Data_088_477F:: ; heuristic: string; C0
    db $22, $28, $37, $2C, $F0

Data_088_4784:: ; heuristic: string; C0
    db $18, $35, $26, $F0

Data_088_4788:: ; heuristic: string; C0
    db $10, $2C, $36, $30, $32, $F0

Data_088_478E:: ; heuristic: string; C0
    db $0D, $35, $32, $2F, $2F, $F0

Data_088_4794:: ; heuristic: string; C0
    db $10, $32, $32, $33, $2C, $F0

Data_088_479A:: ; heuristic: string; C0
    db $16, $38, $30, $30, $3C, $F0

Data_088_47A0:: ; heuristic: string; C0
    db $1D, $35, $28, $28, $0B, $32, $3C, $F0

Data_088_47A8:: ; heuristic: string; C0
    db $0B, $32, $30, $25, $0C, $35, $24, $2A, $F0

Data_088_47B1:: ; heuristic: string; C0
    db $1B, $32, $2A, $38, $28, $17, $2C, $37, $28, $F0

Data_088_47BB:: ; heuristic: string; C0
    db $10, $35, $2C, $3D, $3D, $2F, $3C, $F0

Data_088_47C3:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $2C, $37, $28, $F0

Data_088_47CC:: ; heuristic: string; C0
    db $10, $38, $2F, $33, $33, $2F, $28, $F0

Data_088_47D4:: ; heuristic: string; C0
    db $0F, $32, $3B, $0F, $2C, $35, $28, $F0

Data_088_47DC:: ; heuristic: string; C0
    db $0A, $2F, $30, $2C, $35, $24, $2D, $F0

Data_088_47E4:: ; heuristic: string; C0
    db $15, $24, $31, $27, $18, $3A, $2F, $F0

Data_088_47EC:: ; heuristic: string; C0
    db $10, $32, $24, $37, $28, $2A, $32, $31, $F0

Data_088_47F5:: ; heuristic: string; C0
    db $1C, $24, $26, $26, $28, $35, $F0

Data_088_47FC:: ; heuristic: string; C0
    db $20, $2C, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_088_4806:: ; heuristic: string; C0
    db $0B, $38, $2F, $2F, $0B, $2C, $35, $27, $F0

Data_088_480F:: ; heuristic: string; C0
    db $0C, $35, $24, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_4819:: ; heuristic: string; C0
    db $1C, $37, $24, $35, $29, $2C, $36, $2B, $F0

Data_088_4822:: ; heuristic: string; C0
    db $1C, $28, $24, $11, $32, $35, $36, $28, $F0

Data_088_482B:: ; heuristic: string; C0
    db $16, $24, $31, $0E, $24, $37, $28, $35, $F0

Data_088_4834:: ; heuristic: string; C0
    db $1C, $37, $38, $25, $0B, $2C, $35, $27, $F0

Data_088_483D:: ; heuristic: string; C0
    db $10, $2C, $24, $31, $37, $16, $32, $37, $2B, $F0

Data_088_4847:: ; heuristic: string; C0
    db $10, $32, $24, $37, $11, $32, $35, $31, $F0

Data_088_4850:: ; heuristic: string; C0
    db $0F, $24, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_088_485A:: ; heuristic: string; C0
    db $1B, $32, $26, $2E, $1C, $2F, $2C, $30, $28, $F0

Data_088_4864:: ; heuristic: string; C0
    db $16, $24, $27, $1B, $24, $39, $28, $31, $F0

Data_088_486D:: ; heuristic: string; C0
    db $0E, $30, $3C, $38, $F0

Data_088_4872:: ; heuristic: string; C0
    db $0F, $2F, $32, $35, $24, $16, $24, $31, $F0

Data_088_487B:: ; heuristic: string; C0
    db $1C, $2F, $38, $35, $33, $28, $35, $32, $31, $F0

Data_088_4885:: ; heuristic: string; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $F0

Data_088_488E:: ; heuristic: string; C0
    db $16, $24, $27, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_4898:: ; heuristic: string; C0
    db $0D, $35, $24, $2A, $32, $31, $F0

Data_088_489F:: ; heuristic: string; C0
    db $12, $35, $32, $31, $1D, $38, $35, $37, $F0

Data_088_48A8:: ; heuristic: string; C0
    db $16, $24, $27, $16, $2C, $35, $35, $32, $35, $F0

Data_088_48B2:: ; heuristic: string; C0
    db $1C, $24, $25, $35, $28, $16, $24, $31, $F0

Data_088_48BB:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $0B, $28, $24, $36, $37, $F0

Data_088_48C5:: ; heuristic: string; C0
    db $20, $24, $35, $16, $24, $31, $37, $2C, $36, $F0

Data_088_48CF:: ; heuristic: string; C0
    db $19, $2B, $32, $28, $31, $2C, $3B, $F0

Data_088_48D7:: ; heuristic: string; C0
    db $0F, $2C, $35, $28, $20, $28, $28, $27, $F0

Data_088_48E0:: ; heuristic: string; C0
    db $20, $2C, $2F, $27, $0A, $33, $28, $F0

Data_088_48E8:: ; heuristic: string; C0
    db $0D, $38, $30, $25, $2C, $35, $24, $F0

Data_088_48F0:: ; heuristic: string; C0
    db $0B, $28, $2F, $3D, $28, $25, $38, $25, $F0

Data_088_48F9:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $3C, $F0

Data_088_4900:: ; heuristic: string; C0
    db $10, $2B, $32, $36, $1D, $35, $28, $28, $F0

Data_088_4909:: ; heuristic: string; C0
    db $0B, $24, $25, $25, $2F, $28, $F0

Data_088_4910:: ; heuristic: string; C0
    db $15, $2C, $32, $31, $28, $3B, $F0

Data_088_4917:: ; heuristic: string; C0
    db $16, $24, $27, $10, $32, $32, $36, $28, $F0

Data_088_4920:: ; heuristic: string; C0
    db $0B, $38, $25, $25, $2F, $28, $30, $32, $31, $F0

Data_088_492A:: ; heuristic: string; C0
    db $10, $2C, $2A, $24, $31, $37, $28, $36, $F0

Data_088_4933:: ; heuristic: string; C0
    db $0E, $3B, $24, $38, $26, $28, $35, $36, $F0

Data_088_493C:: ; heuristic: string; C0
    db $0D, $28, $24, $27, $17, $2C, $37, $28, $F0

Data_088_4945:: ; heuristic: string; C0
    db $10, $24, $37, $28, $10, $38, $24, $35, $27, $F0

Data_088_494F:: ; heuristic: string; C0
    db $16, $24, $27, $1C, $33, $2C, $35, $2C, $37, $F0

Data_088_4959:: ; heuristic: string; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_088_4961:: ; heuristic: string; C0
    db $17, $2C, $37, $28, $35, $2C, $26, $2B, $F0

Data_088_496A:: ; heuristic: string; C0
    db $0A, $31, $27, $35, $28, $24, $2F, $F0

Data_088_4972:: ; heuristic: string; C0
    db $16, $24, $27, $14, $31, $2C, $2A, $2B, $37, $F0

Data_088_497C:: ; heuristic: string; C0
    db $1C, $2E, $3C, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_4986:: ; heuristic: string; C0
    db $0C, $32, $2C, $2F, $0B, $2C, $35, $27, $F0

Data_088_498F:: ; heuristic: string; C0
    db $0A, $35, $30, $32, $35, $19, $28, $27, $28, $F0

Data_088_4999:: ; heuristic: string; C0
    db $16, $24, $27, $11, $32, $35, $31, $28, $37, $F0

Data_088_49A3:: ; heuristic: string; C0
    db $16, $38, $27, $32, $38, $F0

Data_088_49A9:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $0A, $35, $30, $32, $35, $F0

Data_088_49B3:: ; heuristic: string; C0
    db $1C, $2E, $28, $2F, $28, $37, $32, $35, $F0

Data_088_49BC:: ; heuristic: string; C0
    db $1F, $24, $30, $33, $2C, $35, $38, $36, $F0

Data_088_49C5:: ; heuristic: string; C0
    db $0F, $2F, $32, $35, $24, $2D, $24, $3C, $F0

Data_088_49CE:: ; heuristic: string; C0
    db $0B, $32, $36, $36, $1D, $35, $32, $2F, $2F, $F0

Data_088_49D8:: ; heuristic: string; C0
    db $0C, $2B, $32, $33, $0C, $2F, $32, $3A, $31, $F0

Data_088_49E2:: ; heuristic: string; C0
    db $16, $2C, $36, $37, $3C, $20, $2C, $31, $2A, $F0

Data_088_49EC:: ; heuristic: string; C0
    db $0C, $28, $31, $37, $24, $36, $24, $38, $35, $F0

Data_088_49F6:: ; heuristic: string; C0
    db $10, $2C, $2A, $24, $0D, $35, $24, $26, $32, $F0

Data_088_4A00:: ; heuristic: string; C0
    db $10, $24, $35, $38, $27, $2C, $24, $31, $F0

Data_088_4A09:: ; heuristic: string; C0
    db $16, $2C, $30, $2C, $26, $F0

Data_088_4A0F:: ; heuristic: string; C0
    db $1D, $24, $37, $36, $38, $F0

Data_088_4A15:: ; heuristic: string; C0
    db $0D, $2C, $24, $2A, $32, $F0

Data_088_4A1B:: ; heuristic: string; C0
    db $1C, $24, $30, $36, $2C, $F0

Data_088_4A21:: ; heuristic: string; C0
    db $0B, $24, $3D, $32, $32, $F0

Data_088_4A27:: ; heuristic: string; C0
    db $0B, $28, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_4A30:: ; heuristic: string; C0
    db $0B, $24, $25, $25, $2F, $28, $F0

Data_088_4A37:: ; heuristic: string; C0
    db $19, $28, $24, $35, $2F, $10, $28, $2F, $F0

Data_088_4A40:: ; heuristic: string; C0
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $F0

Data_088_4A49:: ; heuristic: string; C0
    db $0B, $35, $38, $36, $2B, $28, $24, $27, $F0

Data_088_4A52:: ; heuristic: string; C0
    db $0D, $35, $24, $26, $2E, $3C, $F0

Data_088_4A59:: ; heuristic: string; C0
    db $16, $24, $27, $1B, $24, $39, $28, $31, $F0

Data_088_4A62:: ; heuristic: string; C0
    db $14, $2C, $37, $28, $11, $24, $3A, $2E, $F0

Data_088_4A6B:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $0B, $28, $24, $36, $37, $F0

Data_088_4A75:: ; heuristic: string; C0
    db $10, $2C, $36, $30, $32, $F0

Data_088_4A7B:: ; heuristic: string; C0
    db $19, $32, $30, $19, $32, $30, $0B, $32, $30, $F0

Data_088_4A85:: ; heuristic: string; C0
    db $0D, $28, $39, $2C, $33, $2C, $31, $28, $F0

Data_088_4A8E:: ; heuristic: string; C0
    db $10, $38, $2F, $33, $33, $2F, $28, $F0

Data_088_4A96:: ; heuristic: string; C0
    db $0E, $2A, $2A, $33, $2F, $24, $37, $32, $31, $F0

Data_088_4AA0:: ; heuristic: string; C0
    db $11, $24, $30, $30, $28, $35, $16, $24, $31, $F0

Data_088_4AAA:: ; heuristic: string; C0
    db $1C, $37, $38, $25, $36, $38, $26, $2E, $F0

Data_088_4AB3:: ; heuristic: string; C0
    db $1D, $35, $28, $28, $0B, $32, $3C, $F0

Data_088_4ABB:: ; heuristic: string; C0
    db $0F, $32, $32, $11, $28, $35, $32, $F0

Data_088_4AC3:: ; heuristic: string; C0
    db $16, $32, $30, $30, $32, $31, $2D, $24, $F0

Data_088_4ACC:: ; heuristic: string; C0
    db $0D, $35, $3C, $2A, $32, $31, $F0

Data_088_4AD3:: ; heuristic: string; C0
    db $11, $28, $35, $25, $16, $24, $31, $F0

Data_088_4ADB:: ; heuristic: string; C0
    db $0D, $24, $31, $26, $28, $1F, $28, $2A, $2C, $F0

Data_088_4AE5:: ; heuristic: string; C0
    db $16, $38, $27, $0D, $32, $2F, $2F, $F0

Data_088_4AED:: ; heuristic: string; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_088_4AF4:: ; heuristic: string; C0
    db $16, $24, $27, $0C, $32, $31, $27, $32, $35, $F0

Data_088_4AFE:: ; heuristic: string; C0
    db $0C, $2F, $32, $38, $27, $14, $2C, $31, $2A, $F0

Data_088_4B08:: ; heuristic: string; C0
    db $18, $26, $37, $32, $35, $28, $24, $26, $2B, $F0

Data_088_4B12:: ; heuristic: string; C0
    db $18, $26, $37, $32, $2A, $32, $31, $F0

Data_088_4B1A:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $1C, $34, $38, $2C, $27, $F0

Data_088_4B24:: ; heuristic: string; C0
    db $16, $2C, $36, $37, $3C, $20, $2C, $31, $2A, $F0

Data_088_4B2E:: ; heuristic: string; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_088_4B36:: ; heuristic: string; C0
    db $17, $2C, $37, $28, $20, $2B, $2C, $33, $F0

Data_088_4B3F:: ; heuristic: string; C0
    db $10, $32, $32, $33, $2C, $F0

Data_088_4B45:: ; heuristic: string; C0
    db $1C, $28, $35, $39, $24, $31, $37, $F0

Data_088_4B4D:: ; heuristic: string; C0
    db $0A, $35, $30, $3C, $0C, $35, $24, $25, $F0

Data_088_4B56:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $0C, $35, $24, $25, $F0

Data_088_4B5F:: ; heuristic: string; C0
    db $18, $35, $32, $26, $2B, $2C, $F0

Data_088_4B66:: ; heuristic: string; C0
    db $1C, $28, $35, $33, $28, $31, $37, $2C, $24, $F0

Data_088_4B70:: ; heuristic: string; C0
    db $10, $2C, $2A, $24, $0D, $35, $24, $26, $32, $F0

Data_088_4B7A:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $15, $28, $32, $F0

Data_088_4B82:: ; heuristic: string; C0
    db $0A, $3D, $38, $35, $2C, $2F, $28, $F0

Data_088_4B8A:: ; heuristic: string; C0
    db $0D, $2C, $39, $2C, $31, $28, $2A, $32, $31, $F0

Data_088_4B94:: ; heuristic: string; C0
    db $19, $37, $28, $35, $24, $31, $32, $27, $F0

Data_088_4B9D:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $0B, $28, $24, $36, $37, $F0

Data_088_4BA7:: ; heuristic: string; C0
    db $0F, $24, $2C, $35, $3C, $1B, $24, $37, $F0

Data_088_4BB0:: ; heuristic: string; C0
    db $0B, $2C, $2A, $0E, $3C, $28, $F0

Data_088_4BB7:: ; heuristic: string; C0
    db $0B, $38, $2F, $2F, $0B, $2C, $35, $27, $F0

Data_088_4BC0:: ; heuristic: string; C0
    db $1D, $35, $28, $28, $0B, $32, $3C, $F0

Data_088_4BC8:: ; heuristic: string; C0
    db $10, $32, $11, $32, $33, $33, $28, $35, $F0

Data_088_4BD1:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $0B, $28, $24, $36, $37, $F0

Data_088_4BDB:: ; heuristic: string; C0
    db $16, $38, $27, $35, $32, $31, $F0

Data_088_4BE2:: ; heuristic: string; C0
    db $1B, $28, $24, $33, $28, $35, $F0

Data_088_4BE9:: ; heuristic: string; C0
    db $16, $38, $30, $30, $3C, $F0

Data_088_4BEF:: ; heuristic: string; C0
    db $13, $28, $3A, $28, $2F, $0B, $24, $2A, $F0

Data_088_4BF8:: ; heuristic: string; C0
    db $1C, $37, $24, $35, $29, $2C, $36, $2B, $F0

Data_088_4C01:: ; heuristic: string; C0
    db $0B, $35, $38, $36, $2B, $28, $24, $27, $F0

Data_088_4C0A:: ; heuristic: string; C0
    db $16, $38, $27, $0D, $32, $2F, $2F, $F0

Data_088_4C12:: ; heuristic: string; C0
    db $1B, $38, $36, $2B, $0F, $2C, $36, $2B, $F0

Data_088_4C1B:: ; heuristic: string; C0
    db $20, $2C, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_088_4C25:: ; heuristic: string; C0
    db $19, $32, $2C, $36, $32, $31, $2A, $32, $31, $F0

Data_088_4C2F:: ; heuristic: string; C0
    db $0D, $35, $3C, $2A, $32, $31, $F0

Data_088_4C36:: ; heuristic: string; C0
    db $0C, $24, $37, $0F, $2F, $3C, $F0

Data_088_4C3D:: ; heuristic: string; C0
    db $16, $32, $30, $30, $32, $31, $2D, $24, $F0

Data_088_4C46:: ; heuristic: string; C0
    db $10, $35, $2C, $3D, $3D, $2F, $3C, $F0

Data_088_4C4E:: ; heuristic: string; C0
    db $0C, $35, $24, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_4C58:: ; heuristic: string; C0
    db $19, $2C, $26, $2E, $3C, $F0

Data_088_4C5E:: ; heuristic: string; C0
    db $19, $2C, $3B, $3C, $F0

Data_088_4C63:: ; heuristic: string; C0
    db $0A, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_4C6B:: ; heuristic: string; C0
    db $11, $32, $35, $2E, $F0

Data_088_4C70:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $16, $28, $35, $2A, $28, $F0

Data_088_4C7A:: ; heuristic: string; C0
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $F0

Data_088_4C83:: ; heuristic: string; C0
    db $10, $32, $32, $33, $2C, $F0

Data_088_4C89:: ; heuristic: string; C0
    db $18, $26, $37, $32, $2E, $2C, $27, $F0

Data_088_4C91:: ; heuristic: string; C0
    db $0C, $24, $31, $26, $28, $35, $16, $24, $31, $F0

Data_088_4C9B:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $17, $2C, $37, $28, $F0

Data_088_4CA5:: ; heuristic: string; C0
    db $0B, $24, $25, $25, $2F, $28, $F0

Data_088_4CAC:: ; heuristic: string; C0
    db $1B, $24, $3C, $25, $38, $35, $31, $F0

Data_088_4CB4:: ; heuristic: string; C0
    db $0C, $24, $37, $16, $24, $2A, $28, $F0

Data_088_4CBC:: ; heuristic: string; C0
    db $22, $28, $37, $2C, $F0

Data_088_4CC1:: ; heuristic: string; C0
    db $0B, $28, $24, $39, $28, $35, $31, $F0

Data_088_4CC9:: ; heuristic: string; C0
    db $0F, $2F, $32, $35, $24, $2D, $24, $3C, $F0

Data_088_4CD2:: ; heuristic: string; C0
    db $1D, $32, $24, $27, $36, $37, $32, $32, $2F, $F0

Data_088_4CDC:: ; heuristic: string; C0
    db $10, $2C, $24, $31, $37, $16, $32, $37, $2B, $F0

Data_088_4CE6:: ; heuristic: string; C0
    db $0A, $35, $30, $3C, $0C, $35, $24, $25, $F0

Data_088_4CEF:: ; heuristic: string; C0
    db $16, $24, $27, $11, $32, $35, $31, $28, $37, $F0

Data_088_4CF9:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $2C, $37, $28, $F0

Data_088_4D02:: ; heuristic: string; C0
    db $01, $0E, $3C, $28, $0C, $2F, $32, $3A, $31, $F0

Data_088_4D0C:: ; heuristic: string; C0
    db $0D, $28, $24, $27, $17, $2C, $37, $28, $F0

Data_088_4D15:: ; heuristic: string; C0
    db $10, $2C, $36, $30, $32, $F0

Data_088_4D1B:: ; heuristic: string; C0
    db $18, $26, $37, $32, $2A, $32, $31, $F0

Data_088_4D23:: ; heuristic: string; C0
    db $1C, $31, $24, $2C, $2F, $3C, $F0

Data_088_4D2A:: ; heuristic: string; C0
    db $0B, $32, $3B, $1C, $2F, $2C, $30, $28, $F0

Data_088_4D33:: ; heuristic: string; C0
    db $1F, $24, $30, $33, $2C, $35, $38, $36, $F0

Data_088_4D3C:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $2F, $35, $32, $32, $F0

Data_088_4D45:: ; heuristic: string; C0
    db $0B, $38, $2F, $2F, $0B, $2C, $35, $27, $F0

Data_088_4D4E:: ; heuristic: string; C0
    db $0D, $24, $31, $26, $28, $1F, $28, $2A, $2C, $F0

Data_088_4D58:: ; heuristic: string; C0
    db $1C, $37, $24, $2A, $0B, $38, $2A, $F0

Data_088_4D60:: ; heuristic: string; C0
    db $0A, $35, $30, $32, $35, $19, $28, $27, $28, $F0

Data_088_4D6A:: ; heuristic: string; C0
    db $0C, $24, $37, $24, $33, $2C, $2F, $24, $F0

Data_088_4D73:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $0E, $3C, $28, $F0

Data_088_4D7B:: ; heuristic: string; C0
    db $10, $35, $28, $30, $2F, $2C, $31, $F0

Data_088_4D83:: ; heuristic: string; C0
    db $16, $28, $27, $38, $36, $24, $0E, $3C, $28, $F0

Data_088_4D8D:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $0A, $35, $30, $32, $35, $F0

Data_088_4D97:: ; heuristic: string; C0
    db $16, $24, $27, $16, $2C, $35, $35, $32, $35, $F0

Data_088_4DA1:: ; heuristic: string; C0
    db $1B, $32, $2A, $38, $28, $17, $2C, $37, $28, $F0

Data_088_4DAB:: ; heuristic: string; C0
    db $0D, $38, $30, $25, $2C, $35, $24, $F0

Data_088_4DB3:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $3C, $F0

Data_088_4DBA:: ; heuristic: string; C0
    db $1C, $31, $24, $2E, $28, $0B, $24, $37, $F0

Data_088_4DC3:: ; heuristic: string; C0
    db $10, $38, $2F, $33, $0B, $28, $24, $36, $37, $F0

Data_088_4DCD:: ; heuristic: string; C0
    db $16, $24, $27, $10, $32, $33, $2B, $28, $35, $F0

Data_088_4DD7:: ; heuristic: string; C0
    db $16, $2C, $36, $37, $3C, $20, $2C, $31, $2A, $F0

Data_088_4DE1:: ; heuristic: string; C0
    db $15, $24, $31, $27, $18, $3A, $2F, $F0

Data_088_4DE9:: ; heuristic: string; C0
    db $0D, $28, $39, $2C, $33, $2C, $31, $28, $F0

Data_088_4DF2:: ; heuristic: string; C0
    db $0B, $28, $2F, $3D, $28, $25, $38, $25, $F0

Data_088_4DFB:: ; heuristic: string; C0
    db $0F, $32, $32, $11, $28, $35, $32, $F0

Data_088_4E03:: ; heuristic: string; C0
    db $0B, $38, $25, $25, $2F, $28, $30, $32, $31, $F0

Data_088_4E0D:: ; heuristic: string; C0
    db $10, $32, $24, $37, $11, $32, $35, $31, $F0

Data_088_4E16:: ; heuristic: string; C0
    db $1C, $33, $32, $32, $2E, $3C, $F0

Data_088_4E1D:: ; heuristic: string; C0
    db $19, $38, $37, $35, $28, $19, $38, $33, $F0

Data_088_4E26:: ; heuristic: string; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_088_4E2E:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $0D, $35, $24, $2E, $F0

Data_088_4E38:: ; heuristic: string; C0
    db $1B, $24, $3C, $10, $2C, $2A, $24, $36, $F0

Data_088_4E41:: ; heuristic: string; C0
    db $19, $28, $24, $35, $2F, $10, $28, $2F, $F0

Data_088_4E4A:: ; heuristic: string; C0
    db $10, $24, $36, $2A, $32, $31, $F0

Data_088_4E51:: ; heuristic: string; C0
    db $0D, $35, $24, $2A, $32, $31, $F0

Data_088_4E58:: ; heuristic: string; C0
    db $0A, $35, $35, $32, $3A, $0D, $32, $2A, $F0

Data_088_4E61:: ; heuristic: string; C0
    db $14, $2C, $37, $28, $11, $24, $3A, $2E, $F0

Data_088_4E6A:: ; heuristic: string; C0
    db $1C, $37, $38, $25, $0B, $2C, $35, $27, $F0

Data_088_4E73:: ; heuristic: string; C0
    db $23, $24, $33, $0B, $2C, $35, $27, $F0

Data_088_4E7B:: ; heuristic: string; C0
    db $20, $28, $28, $27, $0B, $38, $2A, $F0

Data_088_4E83:: ; heuristic: string; C0
    db $15, $2C, $33, $36, $3C, $F0

Data_088_4E89:: ; heuristic: string; C0
    db $16, $38, $2F, $37, $2C, $0E, $3C, $28, $36, $F0

Data_088_4E93:: ; heuristic: string; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_088_4E9A:: ; heuristic: string; C0
    db $0C, $24, $33, $37, $0D, $28, $24, $27, $F0

Data_088_4EA3:: ; heuristic: string; C0
    db $0C, $38, $35, $36, $28, $15, $24, $30, $33, $F0

Data_088_4EAD:: ; heuristic: string; C0
    db $0A, $31, $2A, $2F, $28, $35, $32, $31, $F0

Data_088_4EB6:: ; heuristic: string; C0
    db $10, $24, $30, $24, $31, $2C, $24, $31, $F0

Data_088_4EBF:: ; heuristic: string; C0
    db $20, $2B, $24, $2F, $28, $16, $24, $2A, $28, $F0

Data_088_4EC9:: ; heuristic: string; C0
    db $1C, $33, $32, $37, $14, $2C, $31, $2A, $F0

Data_088_4ED2:: ; heuristic: string; C0
    db $1C, $2E, $3C, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_4EDC:: ; heuristic: string; C0
    db $1D, $32, $31, $2A, $38, $28, $2F, $2F, $24, $F0

Data_088_4EE6:: ; heuristic: string; C0
    db $1C, $24, $26, $26, $28, $35, $F0

Data_088_4EED:: ; heuristic: string; C0
    db $20, $3C, $39, $28, $35, $31, $F0

Data_088_4EF4:: ; heuristic: string; C0
    db $0A, $34, $38, $24, $11, $24, $3A, $2E, $F0

Data_088_4EFD:: ; heuristic: string; C0
    db $10, $24, $35, $38, $27, $2C, $24, $31, $F0

Data_088_4F06:: ; heuristic: string; C0
    db $0E, $3C, $28, $27, $28, $35, $F0

Data_088_4F0D:: ; heuristic: string; C0
    db $0A, $35, $26, $0D, $28, $30, $32, $31, $F0

Data_088_4F16:: ; heuristic: string; C0
    db $15, $2C, $32, $31, $28, $3B, $F0

Data_088_4F1D:: ; heuristic: string; C0
    db $10, $24, $37, $28, $10, $38, $24, $35, $27, $F0

Data_088_4F27:: ; heuristic: string; C0
    db $0C, $28, $31, $37, $24, $36, $24, $38, $35, $F0

Data_088_4F31:: ; heuristic: string; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $F0

Data_088_4F3A:: ; heuristic: string; C0
    db $0E, $2A, $2A, $33, $2F, $24, $37, $32, $31, $F0

Data_088_4F44:: ; heuristic: string; C0
    db $0C, $2F, $24, $3A, $36, $37, $28, $35, $F0

Data_088_4F4D:: ; heuristic: string; C0
    db $16, $28, $35, $1D, $2C, $2A, $28, $35, $F0

Data_088_4F56:: ; heuristic: string; C0
    db $1D, $35, $28, $28, $1C, $2F, $2C, $30, $28, $F0

Data_088_4F60:: ; heuristic: string; C0
    db $1C, $3A, $32, $35, $27, $2A, $32, $31, $F0

Data_088_4F69:: ; heuristic: string; C0
    db $1C, $38, $33, $28, $35, $1D, $28, $31, $F0

Data_088_4F72:: ; heuristic: string; C0
    db $11, $24, $30, $30, $28, $35, $16, $24, $31, $F0

Data_088_4F7C:: ; heuristic: string; C0
    db $10, $32, $24, $37, $28, $2A, $32, $31, $F0

Data_088_4F85:: ; heuristic: string; C0
    db $0D, $35, $24, $26, $2E, $3C, $F0

Data_088_4F8C:: ; heuristic: string; C0
    db $19, $38, $37, $35, $28, $0F, $2C, $36, $2B, $F0

Data_088_4F96:: ; heuristic: string; C0
    db $0A, $30, $25, $28, $35, $20, $28, $28, $27, $F0

Data_088_4FA0:: ; heuristic: string; C0
    db $20, $24, $35, $16, $24, $31, $37, $2C, $36, $F0

Data_088_4FAA:: ; heuristic: string; C0
    db $18, $35, $26, $F0

Data_088_4FAE:: ; heuristic: string; C0
    db $0C, $2B, $32, $33, $0C, $2F, $32, $3A, $31, $F0

Data_088_4FB8:: ; heuristic: string; C0
    db $16, $38, $30, $30, $3C, $F0

Data_088_4FBE:: ; heuristic: string; C0
    db $16, $24, $27, $1C, $33, $2C, $35, $2C, $37, $F0

Data_088_4FC8:: ; heuristic: string; C0
    db $19, $32, $30, $19, $32, $30, $0B, $32, $30, $F0

Data_088_4FD2:: ; heuristic: string; C0
    db $0B, $32, $30, $25, $0C, $35, $24, $2A, $F0

Data_088_4FDB:: ; heuristic: string; C0
    db $18, $26, $37, $32, $35, $24, $2C, $27, $F0

Data_088_4FE4:: ; heuristic: string; C0
    db $0A, $31, $27, $35, $28, $24, $2F, $F0

Data_088_4FEC:: ; heuristic: string; C0
    db $10, $35, $28, $24, $37, $0D, $35, $24, $2E, $F0

Data_088_4FF6:: ; heuristic: string; C0
    db $1D, $35, $38, $30, $33, $28, $37, $28, $35, $F0

Data_088_5000:: ; heuristic: string; C0
    db $19, $35, $32, $37, $32, $16, $28, $26, $2B, $F0

Data_088_500A:: ; heuristic: string; C0
    db $0A, $35, $30, $32, $35, $33, $2C, $32, $31, $F0

Data_088_5014:: ; heuristic: string; C0
    db $0D, $2C, $2A, $36, $37, $28, $35, $F0

Data_088_501C:: ; heuristic: string; C0
    db $0B, $32, $36, $36, $1D, $35, $32, $2F, $2F, $F0

Data_088_5026:: ; heuristic: string; C0
    db $16, $24, $27, $14, $31, $2C, $2A, $2B, $37, $F0

Data_088_5030:: ; heuristic: string; C0
    db $18, $2A, $35, $28, $F0

Data_088_5035:: ; heuristic: string; C0
    db $0D, $28, $24, $27, $17, $32, $25, $2F, $28, $F0

Data_088_503F:: ; heuristic: string; C0
    db $1C, $2E, $28, $2F, $28, $37, $32, $35, $F0

Data_088_5048:: ; heuristic: string; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_088_5051:: ; heuristic: string; C0
    db $0F, $2C, $36, $2B, $1B, $2C, $27, $28, $35, $F0

Data_088_505B:: ; heuristic: string; C0
    db $0A, $3B, $28, $1C, $2B, $24, $35, $2E, $F0

Data_088_5064:: ; heuristic: string; C0
    db $0A, $34, $38, $24, $27, $32, $31, $F0

Data_088_506C:: ; heuristic: string; C0
    db $0D, $2C, $2A, $32, $31, $2A, $F0

Data_088_5073:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $14, $2C, $31, $2A, $F0

Data_088_507D:: ; heuristic: string; C0
    db $1C, $28, $35, $33, $28, $31, $37, $2C, $24, $F0

Data_088_5087:: ; heuristic: string; C0
    db $0C, $32, $24, $37, $32, $2F, $F0

Data_088_508E:: ; heuristic: string; C0
    db $18, $35, $32, $26, $2B, $2C, $F0

Data_088_5095:: ; heuristic: string; C0
    db $0B, $24, $37, $37, $2F, $28, $1B, $28, $3B, $F0

Data_088_509F:: ; heuristic: string; C0
    db $20, $2B, $2C, $33, $0B, $2C, $35, $27, $F0

Data_088_50A8:: ; heuristic: string; C0
    db $1C, $2B, $24, $31, $37, $24, $2E, $F0

Data_088_50B0:: ; heuristic: string; C0
    db $1B, $32, $36, $28, $39, $2C, $31, $28, $F0

Data_088_50B9:: ; heuristic: string; C0
    db $10, $35, $28, $31, $27, $24, $2F, $F0

Data_088_50C1:: ; heuristic: string; C0
    db $0A, $2E, $38, $25, $24, $35, $F0

Data_088_50C8:: ; heuristic: string; C0
    db $13, $24, $30, $2C, $35, $38, $36, $F0

Data_088_50D0:: ; heuristic: string; C0
    db $15, $24, $30, $33, $10, $28, $31, $2C, $28, $F0

Data_088_50DA:: ; heuristic: string; C0
    db $20, $2B, $2C, $37, $28, $14, $2C, $31, $2A, $F0

Data_088_50E4:: ; heuristic: string; C0
    db $17, $2C, $37, $28, $35, $2C, $26, $2B, $F0

Data_088_50ED:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $1C, $34, $38, $2C, $27, $F0

Data_088_50F7:: ; heuristic: string; C0
    db $10, $35, $24, $2E, $32, $36, $F0

Data_088_50FE:: ; heuristic: string; C0
    db $1C, $2F, $24, $25, $25, $2C, $37, $F0

Data_088_5106:: ; heuristic: string; C0
    db $0C, $32, $2C, $2F, $0B, $2C, $35, $27, $F0

Data_088_510F:: ; heuristic: string; C0
    db $0F, $24, $2C, $35, $3C, $0D, $35, $24, $2E, $F0

Data_088_5119:: ; heuristic: string; C0
    db $18, $31, $2C, $32, $31, $32, $F0

Data_088_5120:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $1C, $28, $28, $27, $F0

Data_088_5129:: ; heuristic: string; C0
    db $16, $24, $27, $0C, $24, $31, $27, $2F, $28, $F0

Data_088_5133:: ; heuristic: string; C0
    db $0D, $35, $24, $2A, $32, $31, $14, $2C, $27, $F0

Data_088_513D:: ; heuristic: string; C0
    db $0D, $38, $26, $2E, $14, $2C, $37, $28, $F0

Data_088_5146:: ; heuristic: string; C0
    db $20, $2C, $31, $2A, $1D, $35, $28, $28, $F0

Data_088_514F:: ; heuristic: string; C0
    db $10, $2C, $24, $31, $37, $1C, $2F, $38, $2A, $F0

Data_088_5159:: ; heuristic: string; C0
    db $10, $32, $33, $2B, $28, $26, $24, $27, $24, $F0

Data_088_5163:: ; heuristic: string; C0
    db $1B, $32, $37, $1B, $24, $39, $28, $31, $F0

Data_088_516C:: ; heuristic: string; C0
    db $0C, $2B, $24, $30, $28, $2F, $2A, $32, $31, $F0

Data_088_5176:: ; heuristic: string; C0
    db $16, $24, $27, $19, $28, $26, $2E, $28, $35, $F0

Data_088_5180:: ; heuristic: string; C0
    db $16, $24, $27, $19, $2F, $24, $31, $37, $F0

Data_088_5189:: ; heuristic: string; C0
    db $0F, $24, $26, $28, $1D, $35, $28, $28, $F0

Data_088_5192:: ; heuristic: string; C0
    db $0B, $28, $24, $31, $16, $24, $31, $F0

Data_088_519A:: ; heuristic: string; C0
    db $0C, $24, $37, $24, $33, $2C, $2F, $24, $F0

Data_088_51A3:: ; heuristic: string; C0
    db $0F, $24, $26, $28, $35, $F0

Data_088_51A9:: ; heuristic: string; C0
    db $1F, $32, $32, $27, $32, $2F, $2F, $F0

Data_088_51B1:: ; heuristic: string; C0
    db $10, $32, $2F, $28, $30, $F0

Data_088_51B7:: ; heuristic: string; C0
    db $1B, $32, $2A, $38, $28, $20, $24, $39, $28, $F0

Data_088_51C1:: ; heuristic: string; C0
    db $0B, $32, $3B, $1C, $2F, $2C, $30, $28, $F0

Data_088_51CA:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $0B, $32, $35, $2A, $F0

Data_088_51D4:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $11, $32, $35, $31, $F0

Data_088_51DD:: ; heuristic: string; C0
    db $16, $24, $31, $0E, $24, $37, $28, $35, $F0

Data_088_51E6:: ; heuristic: string; C0
    db $1C, $31, $24, $33, $33, $28, $35, $F0

Data_088_51EE:: ; heuristic: string; C0
    db $10, $2B, $32, $36, $1D, $35, $28, $28, $F0

Data_088_51F7:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $1B, $2C, $27, $28, $35, $F0

Data_088_5201:: ; heuristic: string; C0
    db $10, $2C, $2A, $24, $31, $37, $28, $36, $F0

Data_088_520A:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $33, $28, $31, $37, $F0

Data_088_5213:: ; heuristic: string; C0
    db $0A, $34, $38, $24, $35, $28, $2F, $2F, $24, $F0

Data_088_521D:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $1C, $2F, $2C, $30, $28, $F0

Data_088_5227:: ; heuristic: string; C0
    db $10, $35, $24, $31, $1C, $2F, $2C, $30, $28, $F0

Data_088_5231:: ; heuristic: string; C0
    db $0D, $2C, $39, $2C, $31, $28, $2A, $32, $31, $F0

Data_088_523B:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $15, $28, $32, $F0

Data_088_5243:: ; heuristic: string; C0
    db $1B, $24, $2C, $31, $11, $24, $3A, $2E, $F0

Data_088_524C:: ; heuristic: string; C0
    db $0D, $38, $35, $35, $24, $31, $F0

Data_088_5253:: ; heuristic: string; C0
    db $15, $24, $3D, $24, $30, $24, $31, $38, $36, $F0

Data_088_525D:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $10, $32, $2F, $28, $30, $F0

Data_088_5267:: ; heuristic: string; C0
    db $19, $2C, $2F, $2F, $32, $3A, $1B, $24, $37, $F0

Data_088_5271:: ; heuristic: string; C0
    db $0A, $35, $30, $32, $35, $19, $28, $27, $28, $F0

Data_088_527B:: ; heuristic: string; C0
    db $20, $2C, $2F, $27, $0A, $33, $28, $F0

Data_088_5283:: ; heuristic: string; C0
    db $0C, $2F, $24, $3A, $36, $37, $28, $35, $F0

Data_088_528C:: ; heuristic: string; C0
    db $10, $38, $2F, $33, $33, $2F, $28, $F0

Data_088_5294:: ; heuristic: string; C0
    db $0D, $24, $35, $26, $2E, $F0

Data_088_529A:: ; heuristic: string; C0
    db $16, $24, $27, $0C, $24, $37, $F0

Data_088_52A1:: ; heuristic: string; C0
    db $11, $32, $35, $31, $0B, $28, $28, $37, $F0

Data_088_52AA:: ; heuristic: string; C0
    db $1C, $2E, $3C, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_52B4:: ; heuristic: string; C0
    db $18, $26, $37, $32, $2A, $32, $31, $F0

Data_088_52BC:: ; heuristic: string; C0
    db $1C, $28, $35, $39, $24, $31, $37, $F0

Data_088_52C4:: ; heuristic: string; C0
    db $0D, $24, $35, $26, $2E, $F0

Data_088_52CA:: ; heuristic: string; C0
    db $10, $2C, $24, $31, $37, $20, $32, $35, $30, $F0

Data_088_52D4:: ; heuristic: string; C0
    db $1C, $33, $32, $32, $2E, $3C, $F0

Data_088_52DB:: ; heuristic: string; C0
    db $0B, $28, $24, $39, $28, $35, $31, $F0

Data_088_52E3:: ; heuristic: string; C0
    db $16, $24, $27, $0C, $24, $31, $27, $2F, $28, $F0

Data_088_52ED:: ; heuristic: string; C0
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $F0

Data_088_52F6:: ; heuristic: string; C0
    db $0A, $31, $28, $30, $32, $31, $F0

Data_088_52FD:: ; heuristic: string; C0
    db $0A, $35, $35, $32, $3A, $0D, $32, $2A, $F0

Data_088_5306:: ; heuristic: string; C0
    db $19, $3C, $38, $35, $32, $F0

Data_088_530C:: ; heuristic: string; C0
    db $0D, $24, $31, $26, $28, $1F, $28, $2A, $2C, $F0

Data_088_5316:: ; heuristic: string; C0
    db $0B, $35, $38, $36, $2B, $28, $24, $27, $F0

Data_088_531F:: ; heuristic: string; C0
    db $16, $2C, $31, $2C, $0D, $35, $24, $2E, $F0

Data_088_5328:: ; heuristic: string; C0
    db $19, $37, $28, $35, $24, $31, $32, $27, $F0

Data_088_5331:: ; heuristic: string; C0
    db $0D, $35, $24, $2A, $32, $31, $14, $2C, $27, $F0

Data_088_533B:: ; heuristic: string; C0
    db $0C, $24, $37, $0F, $2F, $3C, $F0

Data_088_5342:: ; heuristic: string; C0
    db $0B, $32, $31, $28, $1C, $2F, $24, $39, $28, $F0

Data_088_534C:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $1C, $34, $38, $2C, $27, $F0

Data_088_5356:: ; heuristic: string; C0
    db $0B, $28, $24, $36, $37, $17, $2C, $37, $28, $F0

Data_088_5360:: ; heuristic: string; C0
    db $0D, $35, $3C, $2A, $32, $31, $F0

Data_088_5367:: ; heuristic: string; C0
    db $19, $38, $30, $33, $32, $2C, $36, $28, $F0

Data_088_5370:: ; heuristic: string; C0
    db $0F, $2C, $36, $2B, $1B, $2C, $27, $28, $35, $F0

Data_088_537A:: ; heuristic: string; C0
    db $20, $24, $2F, $35, $38, $36, $16, $24, $31, $F0

Data_088_5384:: ; heuristic: string; C0
    db $1C, $37, $38, $25, $36, $38, $26, $2E, $F0

Data_088_538D:: ; heuristic: string; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_088_5394:: ; heuristic: string; C0
    db $20, $2C, $31, $2A, $1D, $35, $28, $28, $F0

Data_088_539D:: ; heuristic: string; C0
    db $0A, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_53A5:: ; heuristic: string; C0
    db $19, $38, $33, $33, $28, $37, $32, $35, $F0

Data_088_53AE:: ; heuristic: string; C0
    db $0A, $35, $26, $0D, $28, $30, $32, $31, $F0

Data_088_53B7:: ; heuristic: string; C0
    db $10, $32, $24, $37, $11, $32, $35, $31, $F0

Data_088_53C0:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $0D, $35, $24, $2E, $F0

Data_088_53CA:: ; heuristic: string; C0
    db $0A, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_53D2:: ; heuristic: string; C0
    db $19, $38, $33, $33, $28, $37, $32, $35, $F0

Data_088_53DB:: ; heuristic: string; C0
    db $10, $32, $2F, $28, $30, $F0

Data_088_53E1:: ; heuristic: string; C0
    db $0E, $39, $2C, $2F, $1C, $28, $28, $27, $F0

Data_088_53EA:: ; heuristic: string; C0
    db $0E, $3C, $28, $0B, $24, $2F, $2F, $F0

Data_088_53F2:: ; heuristic: string; C0
    db $0C, $2B, $24, $30, $28, $2F, $2A, $32, $31, $F0

Data_088_53FC:: ; heuristic: string; C0
    db $0F, $32, $32, $11, $28, $35, $32, $F0

Data_088_5404:: ; heuristic: string; C0
    db $0B, $32, $3B, $1C, $2F, $2C, $30, $28, $F0

Data_088_540D:: ; heuristic: string; C0
    db $16, $28, $37, $24, $25, $25, $2F, $28, $F0

Data_088_5416:: ; heuristic: string; C0
    db $0F, $24, $2C, $35, $3C, $1B, $24, $37, $F0

Data_088_541F:: ; heuristic: string; C0
    db $1C, $3A, $32, $35, $27, $2A, $32, $31, $F0

Data_088_5428:: ; heuristic: string; C0
    db $16, $32, $30, $30, $32, $31, $2D, $24, $F0

Data_088_5431:: ; heuristic: string; C0
    db $14, $2C, $37, $28, $11, $24, $3A, $2E, $F0

Data_088_543A:: ; heuristic: string; C0
    db $16, $24, $27, $0C, $32, $31, $27, $32, $35, $F0

Data_088_5444:: ; heuristic: string; C0
    db $20, $2C, $31, $2A, $1C, $31, $24, $2E, $28, $F0

Data_088_544E:: ; heuristic: string; C0
    db $10, $35, $28, $24, $37, $0D, $35, $24, $2E, $F0

Data_088_5458:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $1C, $34, $38, $2C, $27, $F0

Data_088_5462:: ; heuristic: string; C0
    db $20, $2C, $31, $27, $0B, $28, $24, $36, $37, $F0

Data_088_546C:: ; heuristic: string; C0
    db $16, $24, $27, $10, $32, $32, $36, $28, $F0

Data_088_5475:: ; heuristic: string; C0
    db $20, $2B, $24, $2F, $28, $16, $24, $2A, $28, $F0

Data_088_547F:: ; heuristic: string; C0
    db $1C, $28, $24, $11, $32, $35, $36, $28, $F0

Data_088_5488:: ; heuristic: string; C0
    db $18, $26, $37, $32, $35, $28, $24, $26, $2B, $F0

Data_088_5492:: ; heuristic: string; C0
    db $12, $26, $28, $16, $24, $31, $F0

Data_088_5499:: ; heuristic: string; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_088_54A0:: ; heuristic: string; C0
    db $0B, $2C, $2A, $0E, $3C, $28, $F0

Data_088_54A7:: ; heuristic: string; C0
    db $0B, $24, $2F, $3D, $24, $2E, $F0

Data_088_54AE:: ; heuristic: string; C0
    db $1B, $32, $37, $1B, $24, $39, $28, $31, $F0

Data_088_54B7:: ; heuristic: string; C0
    db $13, $24, $30, $2C, $35, $38, $36, $F0

Data_088_54BF:: ; heuristic: string; C0
    db $1C, $2E, $3C, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_54C9:: ; heuristic: string; C0
    db $10, $35, $28, $30, $2F, $2C, $31, $F0

Data_088_54D1:: ; heuristic: string; C0
    db $0C, $35, $28, $36, $37, $33, $28, $31, $37, $F0

Data_088_54DB:: ; heuristic: string; C0
    db $1C, $33, $32, $37, $14, $2C, $31, $2A, $F0

Data_088_54E4:: ; heuristic: string; C0
    db $10, $38, $2F, $33, $33, $2F, $28, $F0

Data_088_54EC:: ; heuristic: string; C0
    db $0F, $24, $2C, $35, $3C, $0D, $35, $24, $2E, $F0

Data_088_54F6:: ; heuristic: string; C0
    db $0D, $38, $26, $2E, $14, $2C, $37, $28, $F0

Data_088_54FF:: ; heuristic: string; C0
    db $0F, $38, $31, $2E, $3C, $0B, $2C, $35, $27, $F0

Data_088_5509:: ; heuristic: string; C0
    db $0D, $24, $31, $26, $28, $1F, $28, $2A, $2C, $F0

Data_088_5513:: ; heuristic: string; C0
    db $1C, $2F, $38, $35, $33, $28, $35, $32, $31, $F0

Data_088_551D:: ; heuristic: string; C0
    db $16, $24, $27, $19, $2F, $24, $31, $37, $F0

Data_088_5526:: ; heuristic: string; C0
    db $18, $35, $26, $F0

Data_088_552A:: ; heuristic: string; C0
    db $19, $38, $37, $35, $28, $19, $38, $33, $F0

Data_088_5533:: ; heuristic: string; C0
    db $0D, $28, $39, $2C, $33, $2C, $31, $28, $F0

Data_088_553C:: ; heuristic: string; C0
    db $0A, $31, $28, $30, $32, $31, $F0

Data_088_5543:: ; heuristic: string; C0
    db $11, $28, $35, $25, $16, $24, $31, $F0

Data_088_554B:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_088_5555:: ; heuristic: string; C0
    db $0C, $32, $24, $37, $32, $2F, $F0

Data_088_555C:: ; heuristic: string; C0
    db $0F, $24, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_088_5566:: ; heuristic: string; C0
    db $10, $35, $2C, $3D, $3D, $2F, $3C, $F0

Data_088_556E:: ; heuristic: string; C0
    db $0B, $28, $24, $36, $37, $17, $2C, $37, $28, $F0

Data_088_5578:: ; heuristic: string; C0
    db $11, $28, $24, $2F, $28, $35, $F0

Data_088_557F:: ; heuristic: string; C0
    db $1E, $31, $2C, $26, $32, $35, $31, $F0

Data_088_5587:: ; heuristic: string; C0
    db $1C, $38, $33, $28, $35, $1D, $28, $31, $F0

Data_088_5590:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_088_5596:: ; heuristic: string; C0
    db $1B, $32, $26, $2E, $1C, $2F, $2C, $30, $28, $F0

Data_088_55A0:: ; heuristic: string; C0
    db $16, $28, $37, $24, $25, $25, $2F, $28, $F0

Data_088_55A9:: ; heuristic: string; C0
    db $10, $32, $35, $24, $2A, $32, $F0

Data_088_55B0:: ; heuristic: string; C0
    db $1C, $2F, $24, $25, $25, $2C, $37, $F0

Data_088_55B8:: ; heuristic: string; C0
    db $16, $38, $2F, $37, $2C, $0E, $3C, $28, $36, $F0

Data_088_55C2:: ; heuristic: string; C0
    db $0F, $24, $2C, $35, $3C, $1B, $24, $37, $F0

Data_088_55CB:: ; heuristic: string; C0
    db $1C, $37, $38, $25, $36, $38, $26, $2E, $F0

Data_088_55D4:: ; heuristic: string; C0
    db $16, $24, $27, $19, $2F, $24, $31, $37, $F0

Data_088_55DD:: ; heuristic: string; C0
    db $1C, $31, $24, $33, $33, $28, $35, $F0

Data_088_55E5:: ; heuristic: string; C0
    db $10, $35, $28, $31, $27, $24, $2F, $F0

Data_088_55ED:: ; heuristic: string; C0
    db $10, $32, $11, $32, $33, $33, $28, $35, $F0

Data_088_55F6:: ; heuristic: string; C0
    db $0A, $35, $35, $32, $3A, $0D, $32, $2A, $F0

Data_088_55FF:: ; heuristic: string; C0
    db $1C, $37, $24, $2A, $0B, $38, $2A, $F0

Data_088_5607:: ; heuristic: string; C0
    db $0F, $2C, $35, $28, $20, $28, $28, $27, $F0

Data_088_5610:: ; heuristic: string; C0
    db $0A, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_5618:: ; heuristic: string; C0
    db $10, $35, $2C, $3D, $3D, $2F, $3C, $F0

Data_088_5620:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $1B, $2C, $27, $28, $35, $F0

Data_088_562A:: ; heuristic: string; C0
    db $20, $24, $2F, $35, $38, $36, $16, $24, $31, $F0

Data_088_5634:: ; heuristic: string; C0
    db $16, $24, $27, $0C, $24, $31, $27, $2F, $28, $F0

Data_088_563E:: ; heuristic: string; C0
    db $1B, $28, $24, $33, $28, $35, $F0

Data_088_5645:: ; heuristic: string; C0
    db $19, $35, $32, $37, $32, $16, $28, $26, $2B, $F0

Data_088_564F:: ; heuristic: string; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $F0

Data_088_5658:: ; heuristic: string; C0
    db $0C, $24, $37, $16, $24, $2A, $28, $F0

Data_088_5660:: ; heuristic: string; C0
    db $0F, $24, $26, $28, $1D, $35, $28, $28, $F0

Data_088_5669:: ; heuristic: string; C0
    db $18, $2A, $35, $28, $F0

Data_088_566E:: ; heuristic: string; C0
    db $0C, $38, $35, $36, $28, $15, $24, $30, $33, $F0

Data_088_5678:: ; heuristic: string; C0
    db $0A, $31, $28, $30, $32, $31, $F0

Data_088_567F:: ; heuristic: string; C0
    db $15, $2C, $33, $36, $3C, $F0

Data_088_5685:: ; heuristic: string; C0
    db $20, $28, $28, $27, $0B, $38, $2A, $F0

Data_088_568D:: ; heuristic: string; C0
    db $1C, $33, $2C, $2E, $28, $35, $32, $38, $36, $F0

Data_088_5697:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $2F, $2A, $32, $31, $F0

Data_088_56A0:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $33, $28, $31, $37, $F0

Data_088_56A9:: ; heuristic: string; C0
    db $0B, $38, $37, $37, $28, $35, $29, $2F, $3C, $F0

Data_088_56B3:: ; heuristic: string; C0
    db $19, $2C, $3B, $3C, $F0

Data_088_56B8:: ; heuristic: string; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_088_56C0:: ; heuristic: string; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_088_56C9:: ; heuristic: string; C0
    db $20, $2B, $2C, $33, $0B, $2C, $35, $27, $F0

Data_088_56D2:: ; heuristic: string; C0
    db $16, $2C, $30, $28, $1C, $2F, $2C, $30, $28, $F0

Data_088_56DC:: ; heuristic: string; C0
    db $1D, $32, $31, $2A, $38, $28, $2F, $2F, $24, $F0

Data_088_56E6:: ; heuristic: string; C0
    db $10, $32, $2F, $28, $30, $F0

Data_088_56EC:: ; heuristic: string; C0
    db $0B, $38, $25, $25, $2F, $28, $30, $32, $31, $F0

Data_088_56F6:: ; heuristic: string; C0
    db $1B, $32, $2A, $38, $28, $17, $2C, $37, $28, $F0

Data_088_5700:: ; heuristic: string; C0
    db $19, $38, $33, $33, $28, $37, $32, $35, $F0

Data_088_5709:: ; heuristic: string; C0
    db $0E, $3B, $24, $38, $26, $28, $35, $36, $F0

Data_088_5712:: ; heuristic: string; C0
    db $20, $2B, $24, $2F, $28, $16, $24, $2A, $28, $F0

Data_088_571C:: ; heuristic: string; C0
    db $16, $28, $27, $38, $36, $24, $0E, $3C, $28, $F0

Data_088_5726:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $14, $2C, $31, $2A, $F0

Data_088_5730:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $15, $28, $32, $F0

Data_088_5738:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $10, $32, $2F, $28, $30, $F0

Data_088_5742:: ; heuristic: string; C0
    db $10, $35, $28, $24, $37, $0D, $35, $24, $2E, $F0

Data_088_574C:: ; heuristic: string; C0
    db $20, $24, $37, $24, $25, $32, $38, $F0

Data_088_5754:: ; heuristic: string; C0
    db $0D, $38, $35, $35, $24, $31, $F0

Data_088_575B:: ; heuristic: string; C0
    db $0D, $28, $30, $32, $31, $2C, $37, $28, $F0

Data_088_5764:: ; heuristic: string; C0
    db $0B, $32, $36, $36, $1D, $35, $32, $2F, $2F, $F0

Data_088_576E:: ; heuristic: string; C0
    db $13, $28, $3A, $28, $2F, $0B, $24, $2A, $F0

Data_088_5777:: ; heuristic: string; C0
    db $0B, $32, $31, $28, $1C, $2F, $24, $39, $28, $F0

Data_088_5781:: ; heuristic: string; C0
    db $0D, $28, $24, $27, $17, $32, $25, $2F, $28, $F0

Data_088_578B:: ; heuristic: string; C0
    db $1B, $32, $2A, $38, $28, $17, $2C, $37, $28, $F0

Data_088_5795:: ; heuristic: string; C0
    db $0B, $24, $2F, $3D, $24, $2E, $F0

Data_088_579C:: ; heuristic: string; C0
    db $1F, $32, $32, $27, $32, $2F, $2F, $F0

Data_088_57A4:: ; heuristic: string; C0
    db $10, $24, $37, $28, $10, $38, $24, $35, $27, $F0

Data_088_57AE:: ; heuristic: string; C0
    db $16, $24, $27, $16, $2C, $35, $35, $32, $35, $F0

Data_088_57B8:: ; heuristic: string; C0
    db $10, $35, $24, $2E, $32, $36, $F0

Data_088_57BF:: ; heuristic: string; C0
    db $1C, $26, $24, $2F, $2F, $32, $33, $24, $F0

Data_088_57C8:: ; heuristic: string; C0
    db $1C, $31, $24, $2C, $2F, $3C, $F0

Data_088_57CF:: ; heuristic: string; C0
    db $0C, $2F, $24, $3A, $36, $37, $28, $35, $F0

Data_088_57D8:: ; heuristic: string; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_088_57DF:: ; heuristic: string; C0
    db $16, $2C, $30, $2C, $26, $F0

Data_088_57E5:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $14, $2C, $31, $2A, $F0

Data_088_57EF:: ; heuristic: string; C0
    db $1B, $24, $2C, $31, $11, $24, $3A, $2E, $F0

Data_088_57F8:: ; heuristic: string; C0
    db $0C, $32, $24, $37, $32, $2F, $F0

Data_088_57FF:: ; heuristic: string; C0
    db $19, $2B, $32, $28, $31, $2C, $3B, $F0

Data_088_5807:: ; heuristic: string; C0
    db $1C, $2B, $24, $31, $37, $24, $2E, $F0

Data_088_580F:: ; heuristic: string; C0
    db $0B, $2F, $2C, $3D, $3D, $24, $35, $27, $3C, $F0

Data_088_5819:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $2F, $2A, $32, $31, $F0

Data_088_5822:: ; heuristic: string; C0
    db $0A, $2E, $38, $25, $24, $35, $F0

Data_088_5829:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $11, $32, $35, $31, $F0

Data_088_5832:: ; heuristic: string; C0
    db $1C, $28, $35, $33, $28, $31, $37, $2C, $24, $F0

Data_088_583C:: ; heuristic: string; C0
    db $1C, $38, $33, $28, $35, $1D, $28, $31, $F0

Data_088_5845:: ; heuristic: string; C0
    db $1E, $31, $2C, $26, $32, $35, $31, $F0

Data_088_584D:: ; heuristic: string; C0
    db $14, $2C, $37, $28, $11, $24, $3A, $2E, $F0

Data_088_5856:: ; heuristic: string; C0
    db $0F, $32, $3B, $0F, $2C, $35, $28, $F0

Data_088_585E:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $0D, $35, $24, $2E, $F0

Data_088_5868:: ; heuristic: string; C0
    db $0A, $3B, $28, $1C, $2B, $24, $35, $2E, $F0

Data_088_5871:: ; heuristic: string; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_088_587A:: ; heuristic: string; C0
    db $16, $28, $27, $38, $36, $24, $0E, $3C, $28, $F0

Data_088_5884:: ; heuristic: string; C0
    db $16, $24, $27, $11, $32, $35, $31, $28, $37, $F0

Data_088_588E:: ; heuristic: string; C0
    db $18, $31, $2C, $32, $31, $32, $F0

Data_088_5895:: ; heuristic: string; C0
    db $1D, $24, $2C, $2F, $0E, $24, $37, $28, $35, $F0

Data_088_589F:: ; heuristic: string; C0
    db $0B, $28, $24, $36, $37, $17, $2C, $37, $28, $F0

Data_088_58A9:: ; heuristic: string; C0
    db $16, $2C, $30, $28, $1C, $2F, $2C, $30, $28, $F0

Data_088_58B3:: ; heuristic: string; C0
    db $16, $24, $27, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_58BD:: ; heuristic: string; C0
    db $20, $2C, $31, $2A, $1C, $31, $24, $2E, $28, $F0

Data_088_58C7:: ; heuristic: string; C0
    db $18, $35, $32, $26, $2B, $2C, $F0

Data_088_58CE:: ; heuristic: string; C0
    db $1D, $35, $38, $30, $33, $28, $37, $28, $35, $F0

Data_088_58D8:: ; heuristic: string; C0
    db $20, $3C, $39, $28, $35, $31, $F0

Data_088_58DF:: ; heuristic: string; C0
    db $0D, $28, $39, $2C, $33, $2C, $31, $28, $F0

Data_088_58E8:: ; heuristic: string; C0
    db $1C, $31, $24, $33, $33, $28, $35, $F0

Data_088_58F0:: ; heuristic: string; C0
    db $1C, $37, $24, $2A, $0B, $38, $2A, $F0

Data_088_58F8:: ; heuristic: string; C0
    db $0A, $35, $30, $3C, $0C, $35, $24, $25, $F0

Data_088_5901:: ; heuristic: string; C0
    db $0A, $35, $26, $0D, $28, $30, $32, $31, $F0

Data_088_590A:: ; heuristic: string; C0
    db $01, $0E, $3C, $28, $0C, $2F, $32, $3A, $31, $F0

Data_088_5914:: ; heuristic: string; C0
    db $16, $24, $27, $14, $31, $2C, $2A, $2B, $37, $F0

Data_088_591E:: ; heuristic: string; C0
    db $0C, $24, $33, $37, $0D, $28, $24, $27, $F0

Data_088_5927:: ; heuristic: string; C0
    db $1C, $28, $35, $39, $24, $31, $37, $F0

Data_088_592F:: ; heuristic: string; C0
    db $15, $24, $39, $24, $16, $24, $31, $F0

Data_088_5937:: ; heuristic: string; C0
    db $0B, $32, $30, $25, $0C, $35, $24, $2A, $F0

Data_088_5940:: ; heuristic: string; C0
    db $1B, $38, $36, $2B, $0F, $2C, $36, $2B, $F0

Data_088_5949:: ; heuristic: string; C0
    db $20, $2B, $24, $2F, $28, $16, $24, $2A, $28, $F0

Data_088_5953:: ; heuristic: string; C0
    db $1C, $33, $32, $37, $14, $2C, $31, $2A, $F0

Data_088_595C:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $0B, $32, $35, $2A, $F0

Data_088_5966:: ; heuristic: string; C0
    db $15, $2C, $3D, $24, $35, $27, $16, $24, $31, $F0

Data_088_5970:: ; heuristic: string; C0
    db $10, $35, $28, $24, $37, $0D, $35, $24, $2E, $F0

Data_088_597A:: ; heuristic: string; C0
    db $16, $24, $27, $0C, $24, $37, $F0

Data_088_5981:: ; heuristic: string; C0
    db $0E, $30, $3C, $38, $F0

Data_088_5986:: ; heuristic: string; C0
    db $11, $32, $35, $31, $0B, $28, $28, $37, $F0

Data_088_598F:: ; heuristic: string; C0
    db $18, $2A, $35, $28, $F0

Data_088_5994:: ; heuristic: string; C0
    db $19, $38, $37, $35, $28, $19, $38, $33, $F0

Data_088_599D:: ; heuristic: string; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $02, $F0

Data_088_59A7:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $10, $32, $2F, $28, $30, $F0

Data_088_59B1:: ; heuristic: string; C0
    db $20, $2B, $2C, $37, $28, $14, $2C, $31, $2A, $F0

Data_088_59BB:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $1C, $2F, $2C, $30, $28, $F0

Data_088_59C5:: ; heuristic: string; C0
    db $0D, $2C, $39, $2C, $31, $28, $2A, $32, $31, $F0

Data_088_59CF:: ; heuristic: string; C0
    db $14, $2C, $31, $2A, $15, $28, $32, $F0

Data_088_59D7:: ; heuristic: string; C0
    db $1B, $24, $2C, $31, $11, $24, $3A, $2E, $F0

Data_088_59E0:: ; heuristic: string; C0
    db $1B, $32, $36, $28, $39, $2C, $31, $28, $F0

Data_088_59E9:: ; heuristic: string; C0
    db $0A, $35, $30, $32, $35, $33, $2C, $32, $31, $F0

Data_088_59F3:: ; heuristic: string; C0
    db $0D, $38, $35, $35, $24, $31, $F0

Data_088_59FA:: ; heuristic: string; C0
    db $0A, $34, $38, $24, $27, $32, $31, $F0

Data_088_5A02:: ; heuristic: string; C0
    db $20, $24, $35, $38, $25, $32, $38, $F0

Data_088_5A0A:: ; heuristic: string; C0
    db $19, $28, $37, $2C, $25, $32, $38, $F0

Data_088_5A12:: ; heuristic: string; C0
    db $1C, $2E, $28, $2F, $28, $37, $32, $35, $F0

Data_088_5A1B:: ; heuristic: string; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_088_5A24:: ; heuristic: string; C0
    db $0F, $38, $31, $2E, $3C, $0B, $2C, $35, $27, $F0

Data_088_5A2E:: ; heuristic: string; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_088_5A36:: ; heuristic: string; C0
    db $0A, $31, $27, $35, $28, $24, $2F, $F0

Data_088_5A3E:: ; heuristic: string; C0
    db $0D, $35, $3C, $2A, $32, $31, $F0

Data_088_5A45:: ; heuristic: string; C0
    db $0B, $38, $37, $26, $2B, $F0

Data_088_5A4B:: ; heuristic: string; C0
    db $19, $38, $30, $33, $32, $2C, $36, $28, $F0

Data_088_5A54:: ; heuristic: string; C0
    db $15, $32, $35, $27, $0D, $35, $24, $26, $32, $F0

Data_088_5A5E:: ; heuristic: string; C0
    db $0A, $35, $26, $0D, $28, $30, $32, $31, $F0

Data_088_5A67:: ; heuristic: string; C0
    db $20, $2B, $2C, $33, $0B, $2C, $35, $27, $F0

Data_088_5A70:: ; heuristic: string; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_088_5A79:: ; heuristic: string; C0
    db $0D, $28, $24, $27, $17, $32, $25, $2F, $28, $F0

Data_088_5A83:: ; heuristic: string; C0
    db $16, $28, $37, $24, $2F, $14, $2C, $31, $2A, $F0

Data_088_5A8D:: ; heuristic: string; C0
    db $1C, $28, $35, $33, $28, $31, $37, $2C, $24, $F0

Data_088_5A97:: ; heuristic: string; C0
    db $12, $35, $32, $31, $1D, $38, $35, $37, $F0

Data_088_5AA0:: ; heuristic: string; C0
    db $23, $24, $33, $0B, $2C, $35, $27, $F0

Data_088_5AA8:: ; heuristic: string; C0
    db $0F, $32, $32, $11, $28, $35, $32, $F0

Data_088_5AB0:: ; heuristic: string; C0
    db $10, $32, $24, $37, $11, $32, $35, $31, $F0

Data_088_5AB9:: ; heuristic: string; C0
    db $12, $31, $39, $28, $35, $3D, $32, $31, $F0

Data_088_5AC2:: ; heuristic: string; C0
    db $1F, $32, $32, $27, $32, $2F, $2F, $F0

Data_088_5ACA:: ; heuristic: string; C0
    db $0A, $3B, $28, $1C, $2B, $24, $35, $2E, $F0

Data_088_5AD3:: ; heuristic: string; C0
    db $0D, $2C, $2A, $32, $31, $2A, $F0

Data_088_5ADA:: ; heuristic: string; C0
    db $1C, $3A, $32, $35, $27, $2A, $32, $31, $F0

Data_088_5AE3:: ; heuristic: string; C0
    db $10, $2C, $2A, $24, $0D, $35, $24, $26, $32, $F0

Data_088_5AED:: ; heuristic: string; C0
    db $1C, $38, $33, $28, $35, $1D, $28, $31, $F0

Data_088_5AF6:: ; heuristic: string; C0
    db $0B, $2C, $2A, $1B, $32, $32, $36, $37, $F0

Data_088_5AFF:: ; heuristic: string; C0
    db $10, $2B, $32, $36, $1D, $35, $28, $28, $F0

Data_088_5B08:: ; heuristic: string; C0
    db $20, $24, $35, $16, $24, $31, $37, $2C, $36, $F0

Data_088_5B12:: ; heuristic: string; C0
    db $11, $28, $24, $2F, $28, $35, $F0

Data_088_5B19:: ; heuristic: string; C0
    db $14, $24, $2A, $28, $25, $32, $38, $F0

Data_088_5B21:: ; heuristic: string; C0
    db $0D, $2C, $30, $28, $31, $36, $24, $38, $35, $F0

Data_088_5B2B:: ; heuristic: string; C0
    db $15, $24, $30, $2C, $24, $F0

Data_088_5B31:: ; heuristic: string; C0
    db $0D, $35, $24, $26, $32, $15, $32, $35, $27, $F0

Data_088_5B3B:: ; heuristic: string; C0
    db $15, $32, $35, $27, $0D, $35, $24, $26, $32, $F0

Data_088_5B45:: ; heuristic: string; C0
    db $11, $24, $35, $2A, $32, $31, $F0

Data_088_5B4C:: ; heuristic: string; C0
    db $1C, $2C, $27, $32, $2B, $F0

Data_088_5B52:: ; heuristic: string; C0
    db $10, $28, $31, $32, $36, $2C, $27, $32, $2B, $F0

Data_088_5B5C:: ; heuristic: string; C0
    db $0B, $24, $35, $24, $30, $32, $36, $F0

Data_088_5B64:: ; heuristic: string; C0
    db $23, $32, $30, $24, $F0

Data_088_5B69:: ; heuristic: string; C0
    db $0A, $36, $38, $35, $24, $23, $32, $30, $24, $F0

Data_088_5B73:: ; heuristic: string; C0
    db $19, $2C, $3D, $3D, $24, $35, $32, $F0

Data_088_5B7B:: ; heuristic: string; C0
    db $19, $36, $3C, $26, $2B, $32, $19, $2C, $3D, $F0

Data_088_5B85:: ; heuristic: string; C0
    db $0E, $36, $37, $28, $35, $2E, $F0

Data_088_5B8C:: ; heuristic: string; C0
    db $16, $2C, $35, $38, $27, $35, $24, $24, $36, $F0

Data_088_5B96:: ; heuristic: string; C0
    db $16, $38, $27, $32, $38, $F0

Data_088_5B9C:: ; heuristic: string; C0
    db $0D, $28, $24, $37, $2B, $16, $32, $35, $28, $F0

Data_088_5BA6:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $27, $35, $2C, $38, $30, $F0

Data_088_5BB0:: ; heuristic: string; C0
    db $18, $35, $2A, $32, $27, $28, $30, $2C, $35, $F0

Data_088_5BBA:: ; heuristic: string; C0
    db $0D, $24, $35, $26, $2E, $F0

Data_088_5BC0:: ; heuristic: string; C0
    db $11, $24, $2F, $32, $1C, $2F, $2C, $30, $28, $F0

Data_088_5BCA:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $1C, $2F, $2C, $30, $28, $F0

Data_088_5BD4:: ; heuristic: string; C0
    db $10, $35, $24, $31, $1C, $2F, $2C, $30, $28, $F0

Data_088_5BDE:: ; heuristic: string; C0
    db $20, $32, $31, $27, $28, $35, $0E, $2A, $2A, $F0

Data_088_5BE8:: ; heuristic: string; C0
    db $18, $35, $2F, $2C, $2A, $32, $31, $F0

Data_088_5BF0:: ; heuristic: string; C0
    db $10, $2C, $2A, $24, $0D, $35, $24, $26, $32, $F0

Data_088_5BFA:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $11, $32, $35, $31, $F0

Data_088_5C03:: ; heuristic: string; C0
    db $10, $32, $35, $24, $2A, $32, $F0

Data_088_5C0A:: ; heuristic: string; C0
    db $1B, $24, $2C, $31, $11, $24, $3A, $2E, $F0

Data_088_5C13:: ; heuristic: string; C0
    db $0A, $3D, $38, $35, $2C, $2F, $28, $F0

Data_088_5C1B:: ; heuristic: string; C0
    db $1C, $2B, $24, $31, $37, $24, $2E, $F0

Data_088_5C23:: ; heuristic: string; C0
    db $20, $24, $37, $24, $25, $32, $38, $F0

Data_088_5C2B:: ; heuristic: string; C0
    db $20, $24, $35, $38, $25, $32, $38, $F0

Data_088_5C33:: ; heuristic: string; C0
    db $0E, $2A, $27, $35, $24, $26, $2C, $2F, $F0

Data_088_5C3C:: ; heuristic: string; C0
    db $0D, $2C, $2A, $36, $37, $28, $35, $F0

Data_088_5C44:: ; heuristic: string; C0
    db $1C, $2E, $38, $2F, $24, $35, $24, $26, $2B, $F0

Data_088_5C4E:: ; heuristic: string; C0
    db $1D, $2C, $37, $24, $31, $2C, $36, $F0

Data_088_5C56:: ; heuristic: string; C0
    db $15, $24, $30, $33, $10, $28, $31, $2C, $28, $F0

Data_088_5C60:: ; heuristic: string; C0
    db $17, $2C, $37, $28, $35, $2C, $26, $2B, $F0

Data_088_5C69:: ; heuristic: string; C0
    db $20, $2B, $2C, $37, $28, $14, $2C, $31, $2A, $F0

Data_088_5C73:: ; heuristic: string; C0
    db $15, $24, $3D, $24, $30, $24, $31, $38, $36, $F0

Data_088_5C7D:: ; heuristic: string; C0
    db $10, $32, $2F, $27, $10, $32, $2F, $28, $30, $F0

Data_088_5C87:: ; heuristic: string; C0
    db $0D, $24, $35, $2E, $16, $24, $37, $28, $F0

Data_088_5C90:: ; heuristic: string; C0
    db $18, $26, $37, $32, $2A, $32, $31, $F0

Data_088_5C98:: ; heuristic: string; C0
    db $18, $26, $37, $32, $35, $24, $2C, $27, $F0

Data_088_5CA1:: ; heuristic: string; C0
    db $10, $35, $24, $2E, $32, $36, $F0

Data_088_5CA8:: ; heuristic: string; C0
    db $19, $32, $36, $28, $2C, $27, $32, $31, $F0

Data_088_5CB1:: ; heuristic: string; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_088_5CB7:: ; heuristic: string; C0
    db $1E, $31, $27, $28, $29, $2C, $31, $28, $27, $F0, $30, $28, $F0, $1E, $31, $27
    db $28, $29, $2C, $31, $28, $27, $F0
    ds $2332, $00
