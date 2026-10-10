SECTION "Bank 38", ROMX[$4000], BANK[$38]
    db $38

; E-0041 (C1: Func_000_1FE3 indexes it with the monster id and decompresses the stream to VRAM; the debug monster viewer shows the picture; every one of the 383 entries parses as a 576-byte stream; entry 0 is a placeholder). Each entry is a 3-byte far pointer: address, then bank.
; record: compressed picture stream (36 tiles, drawn 6 x 6); ROM bank of that data
MonsterPictureTable::
Data_038_4001:: ; heuristic: start of a structured table; C0
    dw Data_074_4001 ; id 0
    db $74
    dw Data_074_4001 ; id 1
    db $74
    dw Data_074_40F1 ; id 2
    db $74
    dw Data_074_4182 ; id 3
    db $74
    dw Data_074_42A4 ; id 4
    db $74
    dw Data_074_4347 ; id 5
    db $74
    dw Data_074_43FE ; id 6
    db $74
    dw Data_074_44F9 ; id 7
    db $74
    dw Data_074_45B0 ; id 8
    db $74
    dw Data_074_4666 ; id 9
    db $74
    dw Data_074_476F ; id 10
    db $74
    dw Data_074_47D4 ; id 11
    db $74
    dw Data_074_4870 ; id 12
    db $74
    dw Data_074_4957 ; id 13
    db $74
    dw Data_074_49EB ; id 14
    db $74
    dw Data_074_4A97 ; id 15
    db $74
    dw Data_074_4B5B ; id 16
    db $74
    dw Data_074_4CA3 ; id 17
    db $74
    dw Data_074_4D08 ; id 18
    db $74
    dw Data_074_4DBF ; id 19
    db $74
    dw Data_074_4F25 ; id 20
    db $74
    dw Data_074_4FFE ; id 21
    db $74
    dw Data_074_5108 ; id 22
    db $74
    dw Data_074_51B3 ; id 23
    db $74
    dw Data_074_52FC ; id 24
    db $74
    dw Data_074_54E7 ; id 25
    db $74
    dw Data_074_56E4 ; id 26
    db $74
    dw Data_074_40F1 ; id 27
    db $74
    dw Data_074_4001 ; id 28
    db $74
    dw Data_074_4001 ; id 29
    db $74
    dw Data_074_4001 ; id 30
    db $74
    dw Data_074_4001 ; id 31
    db $74
    dw Data_074_4001 ; id 32
    db $74
    dw Data_074_4001 ; id 33
    db $74
    dw Data_074_4001 ; id 34
    db $74
    dw Data_074_4001 ; id 35
    db $74
    dw Data_074_5772 ; id 36
    db $74
    dw Data_074_58A0 ; id 37
    db $74
    dw Data_074_5A1C ; id 38
    db $74
    dw Data_074_5B72 ; id 39
    db $74
    dw Data_074_5D27 ; id 40
    db $74
    dw Data_074_5E54 ; id 41
    db $74
    dw Data_074_6032 ; id 42
    db $74
    dw Data_074_61B2 ; id 43
    db $74
    dw Data_074_6390 ; id 44
    db $74
    dw Data_074_655D ; id 45
    db $74
    dw Data_074_66DB ; id 46
    db $74
    dw Data_074_67C7 ; id 47
    db $74
    dw Data_074_69B6 ; id 48
    db $74
    dw Data_074_6B66 ; id 49
    db $74
    dw Data_074_6C85 ; id 50
    db $74
    dw Data_074_6E05 ; id 51
    db $74
    dw Data_074_6FD1 ; id 52
    db $74
    dw Data_074_70C1 ; id 53
    db $74
    dw Data_074_727D ; id 54
    db $74
    dw Data_074_73E1 ; id 55
    db $74
    dw Data_074_7521 ; id 56
    db $74
    dw Data_074_7732 ; id 57
    db $74
    dw Data_074_78AA ; id 58
    db $74
    dw Data_074_7A89 ; id 59
    db $74
    dw Data_074_7C55 ; id 60
    db $74
    dw Data_074_7E16 ; id 61
    db $74
    dw Data_075_4001 ; id 62
    db $75
    dw Data_075_41D7 ; id 63
    db $75
    dw Data_075_43A3 ; id 64
    db $75
    dw Data_075_4579 ; id 65
    db $75
    dw Data_075_4737 ; id 66
    db $75
    dw Data_074_4001 ; id 67
    db $74
    dw Data_074_4001 ; id 68
    db $74
    dw Data_074_4001 ; id 69
    db $74
    dw Data_074_4001 ; id 70
    db $74
    dw Data_075_4918 ; id 71
    db $75
    dw Data_075_4A3F ; id 72
    db $75
    dw Data_075_4B21 ; id 73
    db $75
    dw Data_075_4CB0 ; id 74
    db $75
    dw Data_075_4D74 ; id 75
    db $75
    dw Data_075_4E92 ; id 76
    db $75
    dw Data_075_504D ; id 77
    db $75
    dw Data_075_5162 ; id 78
    db $75
    dw Data_075_52FB ; id 79
    db $75
Data_038_40F1:: ; heuristic: label inside a table; C0
    dw Data_075_54CD ; id 80
    db $75
    dw Data_075_560C ; id 81
    db $75
    dw Data_075_571E ; id 82
    db $75
    dw Data_075_58C0 ; id 83
    db $75
    dw Data_075_59D5 ; id 84
    db $75
    dw Data_075_5B13 ; id 85
    db $75
    dw Data_075_5C9C ; id 86
    db $75
    dw Data_075_5E6E ; id 87
    db $75
    dw Data_075_5FEC ; id 88
    db $75
    dw Data_075_61EA ; id 89
    db $75
    dw Data_075_6318 ; id 90
    db $75
    dw Data_075_6400 ; id 91
    db $75
    dw Data_075_64F9 ; id 92
    db $75
    dw Data_075_669C ; id 93
    db $75
    dw Data_075_67A1 ; id 94
    db $75
    dw Data_075_6925 ; id 95
    db $75
    dw Data_075_6B0D ; id 96
    db $75
    dw Data_075_6D3F ; id 97
    db $75
    dw Data_075_6F1D ; id 98
    db $75
    dw Data_075_7086 ; id 99
    db $75
    dw Data_075_7241 ; id 100
    db $75
    dw Data_075_743A ; id 101
    db $75
    dw Data_075_7590 ; id 102
    db $75
    dw Data_074_4001 ; id 103
    db $74
    dw Data_074_4001 ; id 104
    db $74
    dw Data_074_4001 ; id 105
    db $74
    dw Data_077_4001 ; id 106
    db $77
    dw Data_075_777F ; id 107
    db $75
    dw Data_075_78B5 ; id 108
    db $75
    dw Data_075_7A0B ; id 109
    db $75
    dw Data_075_7B6A ; id 110
    db $75
    dw Data_076_4001 ; id 111
    db $76
    dw Data_076_411A ; id 112
    db $76
    dw Data_076_421F ; id 113
    db $76
    dw Data_076_42FC ; id 114
    db $76
    dw Data_076_446C ; id 115
    db $76
    dw Data_076_4526 ; id 116
    db $76
    dw Data_076_469A ; id 117
    db $76
    dw Data_076_484A ; id 118
    db $76
    dw Data_076_4968 ; id 119
    db $76
    dw Data_076_4AF5 ; id 120
    db $76
    dw Data_076_4C71 ; id 121
    db $76
    dw Data_076_4E27 ; id 122
    db $76
    dw Data_076_4F5E ; id 123
    db $76
    dw Data_076_5121 ; id 124
    db $76
    dw Data_076_52E7 ; id 125
    db $76
    dw Data_076_54A7 ; id 126
    db $76
    dw Data_076_5692 ; id 127
    db $76
    dw Data_076_585F ; id 128
    db $76
    dw Data_076_59DD ; id 129
    db $76
    dw Data_076_5BDA ; id 130
    db $76
    dw Data_076_5DB2 ; id 131
    db $76
    dw Data_076_5FBE ; id 132
    db $76
    dw Data_074_4001 ; id 133
    db $74
    dw Data_074_4001 ; id 134
    db $74
    dw Data_074_4001 ; id 135
    db $74
    dw Data_074_4001 ; id 136
    db $74
    dw Data_074_4001 ; id 137
    db $74
    dw Data_074_4001 ; id 138
    db $74
    dw Data_074_4001 ; id 139
    db $74
    dw Data_074_4001 ; id 140
    db $74
    dw Data_07A_4001 ; id 141
    db $7A
    dw Data_076_60DE ; id 142
    db $76
    dw Data_076_6249 ; id 143
    db $76
    dw Data_076_642D ; id 144
    db $76
    dw Data_076_6595 ; id 145
    db $76
    dw Data_076_66ED ; id 146
    db $76
    dw Data_076_67FC ; id 147
    db $76
    dw Data_076_690A ; id 148
    db $76
    dw Data_076_6A98 ; id 149
    db $76
    dw Data_076_6BA7 ; id 150
    db $76
    dw Data_076_6CF7 ; id 151
    db $76
    dw Data_076_6E34 ; id 152
    db $76
    dw Data_076_6F5C ; id 153
    db $76
    dw Data_076_70DA ; id 154
    db $76
    dw Data_076_71CC ; id 155
    db $76
    dw Data_076_7384 ; id 156
    db $76
    dw Data_076_7530 ; id 157
    db $76
    dw Data_076_7670 ; id 158
    db $76
    dw Data_076_7762 ; id 159
    db $76
    dw Data_076_78E3 ; id 160
    db $76
    dw Data_076_7A54 ; id 161
    db $76
    dw Data_076_7B79 ; id 162
    db $76
    dw Data_077_4175 ; id 163
    db $77
    dw Data_077_4372 ; id 164
    db $77
    dw Data_077_44B5 ; id 165
    db $77
    dw Data_077_45BD ; id 166
    db $77
    dw Data_077_46A5 ; id 167
    db $77
    dw Data_074_4001 ; id 168
    db $74
    dw Data_074_4001 ; id 169
    db $74
    dw Data_074_4001 ; id 170
    db $74
    dw Data_074_4001 ; id 171
    db $74
    dw Data_074_4001 ; id 172
    db $74
    dw Data_074_4001 ; id 173
    db $74
    dw Data_074_4001 ; id 174
    db $74
    dw Data_074_4001 ; id 175
    db $74
    dw Data_077_4784 ; id 176
    db $77
    dw Data_077_487E ; id 177
    db $77
    dw Data_077_4968 ; id 178
    db $77
    dw Data_077_4A16 ; id 179
    db $77
    dw Data_077_4B22 ; id 180
    db $77
    dw Data_077_4C42 ; id 181
    db $77
    dw Data_077_4D42 ; id 182
    db $77
    dw Data_077_4E1C ; id 183
    db $77
    dw Data_077_4F19 ; id 184
    db $77
    dw Data_077_50D6 ; id 185
    db $77
    dw Data_077_519D ; id 186
    db $77
    dw Data_077_523B ; id 187
    db $77
    dw Data_077_5366 ; id 188
    db $77
    dw Data_077_544D ; id 189
    db $77
    dw Data_077_5519 ; id 190
    db $77
    dw Data_077_566B ; id 191
    db $77
    dw Data_077_5784 ; id 192
    db $77
    dw Data_077_58AB ; id 193
    db $77
    dw Data_077_5A05 ; id 194
    db $77
    dw Data_077_5B8C ; id 195
    db $77
    dw Data_077_5D15 ; id 196
    db $77
    dw Data_077_5E64 ; id 197
    db $77
    dw Data_077_5F7C ; id 198
    db $77
    dw Data_077_6104 ; id 199
    db $77
    dw Data_077_62B1 ; id 200
    db $77
    dw Data_077_644D ; id 201
    db $77
    dw Data_074_4001 ; id 202
    db $74
    dw Data_074_4001 ; id 203
    db $74
    dw Data_074_4001 ; id 204
    db $74
    dw Data_074_4001 ; id 205
    db $74
    dw Data_074_4001 ; id 206
    db $74
    dw Data_074_4001 ; id 207
    db $74
    dw Data_074_4001 ; id 208
    db $74
    dw Data_074_4001 ; id 209
    db $74
    dw Data_074_4001 ; id 210
    db $74
    dw Data_078_4001 ; id 211
    db $78
    dw Data_078_40F5 ; id 212
    db $78
    dw Data_078_41FB ; id 213
    db $78
    dw Data_078_4371 ; id 214
    db $78
    dw Data_078_4482 ; id 215
    db $78
    dw Data_078_4580 ; id 216
    db $78
    dw Data_078_4657 ; id 217
    db $78
    dw Data_078_47A8 ; id 218
    db $78
    dw Data_078_4976 ; id 219
    db $78
    dw Data_078_4B28 ; id 220
    db $78
    dw Data_078_4C59 ; id 221
    db $78
    dw Data_078_4D2F ; id 222
    db $78
    dw Data_078_4EFD ; id 223
    db $78
    dw Data_078_5101 ; id 224
    db $78
Data_038_42A4:: ; heuristic: label inside a table; C0
    dw Data_078_52A6 ; id 225
    db $78
    dw Data_078_540D ; id 226
    db $78
    dw Data_078_55D3 ; id 227
    db $78
    dw Data_078_57B2 ; id 228
    db $78
    dw Data_078_5982 ; id 229
    db $78
    dw Data_078_5B49 ; id 230
    db $78
    dw Data_078_5D2A ; id 231
    db $78
    dw Data_078_5F27 ; id 232
    db $78
    dw Data_078_6104 ; id 233
    db $78
    dw Data_078_62E5 ; id 234
    db $78
    dw Data_078_64EF ; id 235
    db $78
    dw Data_078_668F ; id 236
    db $78
    dw Data_078_6857 ; id 237
    db $78
    dw Data_078_6A3B ; id 238
    db $78
    dw Data_078_6BEB ; id 239
    db $78
    dw Data_078_6E05 ; id 240
    db $78
    dw Data_074_4001 ; id 241
    db $74
    dw Data_074_4001 ; id 242
    db $74
    dw Data_074_4001 ; id 243
    db $74
    dw Data_074_4001 ; id 244
    db $74
    dw Data_074_4001 ; id 245
    db $74
    dw Data_078_6FBB ; id 246
    db $78
    dw Data_078_7098 ; id 247
    db $78
    dw Data_078_729E ; id 248
    db $78
    dw Data_078_735D ; id 249
    db $78
    dw Data_078_7459 ; id 250
    db $78
    dw Data_078_75A5 ; id 251
    db $78
    dw Data_078_76F1 ; id 252
    db $78
    dw Data_078_7847 ; id 253
    db $78
    dw Data_078_794B ; id 254
    db $78
    dw Data_078_7A35 ; id 255
    db $78
    dw Data_078_7B6B ; id 256
    db $78
    dw Data_078_7D09 ; id 257
    db $78
    dw Data_078_7DE2 ; id 258
    db $78
    dw Data_079_4001 ; id 259
    db $79
    dw Data_079_410A ; id 260
    db $79
    dw Data_079_4275 ; id 261
    db $79
    dw Data_079_4403 ; id 262
    db $79
    dw Data_079_45D2 ; id 263
    db $79
    dw Data_079_47C7 ; id 264
    db $79
    dw Data_079_4925 ; id 265
    db $79
    dw Data_079_4A85 ; id 266
    db $79
    dw Data_079_4C5C ; id 267
    db $79
    dw Data_079_4E46 ; id 268
    db $79
    dw Data_079_5023 ; id 269
    db $79
    dw Data_079_50B0 ; id 270
    db $79
    dw Data_079_5193 ; id 271
    db $79
    dw Data_079_52B9 ; id 272
    db $79
    dw Data_074_4001 ; id 273
    db $74
    dw Data_074_4001 ; id 274
    db $74
    dw Data_074_4001 ; id 275
    db $74
    dw Data_074_4001 ; id 276
    db $74
    dw Data_074_4001 ; id 277
    db $74
    dw Data_074_4001 ; id 278
    db $74
    dw Data_074_4001 ; id 279
    db $74
    dw Data_074_4001 ; id 280
    db $74
    dw Data_079_545F ; id 281
    db $79
    dw Data_079_55C0 ; id 282
    db $79
    dw Data_079_567A ; id 283
    db $79
    dw Data_079_5746 ; id 284
    db $79
    dw Data_079_58BD ; id 285
    db $79
    dw Data_079_59CF ; id 286
    db $79
    dw Data_079_5AB8 ; id 287
    db $79
    dw Data_079_5C0B ; id 288
    db $79
    dw Data_079_5D8B ; id 289
    db $79
    dw Data_079_5ED8 ; id 290
    db $79
    dw Data_079_5FA8 ; id 291
    db $79
    dw Data_079_60DA ; id 292
    db $79
    dw Data_079_62CE ; id 293
    db $79
    dw Data_079_64AE ; id 294
    db $79
    dw Data_079_6569 ; id 295
    db $79
    dw Data_079_665E ; id 296
    db $79
    dw Data_079_67E4 ; id 297
    db $79
    dw Data_079_699A ; id 298
    db $79
    dw Data_079_6B5C ; id 299
    db $79
    dw Data_079_6C59 ; id 300
    db $79
    dw Data_079_6D45 ; id 301
    db $79
    dw Data_079_6E8F ; id 302
    db $79
    dw Data_079_6FD8 ; id 303
    db $79
    dw Data_079_70CC ; id 304
    db $79
    dw Data_079_7236 ; id 305
    db $79
    dw Data_079_7349 ; id 306
    db $79
    dw Data_079_7517 ; id 307
    db $79
    dw Data_079_768B ; id 308
    db $79
    dw Data_079_77A0 ; id 309
    db $79
    dw Data_079_79C3 ; id 310
    db $79
    dw Data_079_7BB4 ; id 311
    db $79
    dw Data_079_7D4B ; id 312
    db $79
    dw Data_074_4001 ; id 313
    db $74
    dw Data_074_4001 ; id 314
    db $74
    dw Data_074_4001 ; id 315
    db $74
    dw Data_077_6615 ; id 316
    db $77
    dw Data_077_66F3 ; id 317
    db $77
    dw Data_077_682F ; id 318
    db $77
    dw Data_077_69FA ; id 319
    db $77
    dw Data_077_6B2F ; id 320
    db $77
    dw Data_077_6C73 ; id 321
    db $77
    dw Data_077_6D9F ; id 322
    db $77
    dw Data_077_6EB2 ; id 323
    db $77
    dw Data_077_6FD7 ; id 324
    db $77
    dw Data_077_70AE ; id 325
    db $77
    dw Data_077_71C7 ; id 326
    db $77
    dw Data_077_72E9 ; id 327
    db $77
    dw Data_077_7458 ; id 328
    db $77
    dw Data_077_756E ; id 329
    db $77
    dw Data_077_7688 ; id 330
    db $77
    dw Data_077_7843 ; id 331
    db $77
    dw Data_077_79B6 ; id 332
    db $77
    dw Data_077_7B2A ; id 333
    db $77
    dw Data_077_7C1C ; id 334
    db $77
    dw Data_077_7D3C ; id 335
    db $77
    dw Data_07A_413F ; id 336
    db $7A
    dw Data_07A_4326 ; id 337
    db $7A
    dw Data_07A_451E ; id 338
    db $7A
    dw Data_07A_4708 ; id 339
    db $7A
    dw Data_07A_48D0 ; id 340
    db $7A
    dw Data_07A_4A60 ; id 341
    db $7A
    dw Data_07A_4C36 ; id 342
    db $7A
    dw Data_07A_4E3B ; id 343
    db $7A
    dw Data_07A_5052 ; id 344
    db $7A
    dw Data_07A_523F ; id 345
    db $7A
    dw Data_07A_5459 ; id 346
    db $7A
    dw Data_07A_556F ; id 347
    db $7A
    dw Data_074_4001 ; id 348
    db $74
    dw Data_074_4001 ; id 349
    db $74
    dw Data_074_4001 ; id 350
    db $74
    dw Data_07A_565F ; id 351
    db $7A
    dw Data_07A_580F ; id 352
    db $7A
    dw Data_07A_59F5 ; id 353
    db $7A
    dw Data_07A_5C03 ; id 354
    db $7A
    dw Data_07A_5DB2 ; id 355
    db $7A
    dw Data_07A_5FCA ; id 356
    db $7A
    dw Data_07A_61E5 ; id 357
    db $7A
    dw Data_07A_638E ; id 358
    db $7A
    dw Data_07A_657F ; id 359
    db $7A
    dw Data_07A_6755 ; id 360
    db $7A
    dw Data_07A_6983 ; id 361
    db $7A
    dw Data_07A_6B8A ; id 362
    db $7A
    dw Data_07A_6D77 ; id 363
    db $7A
    dw Data_07A_6EF9 ; id 364
    db $7A
    dw Data_07A_712A ; id 365
    db $7A
    dw Data_07A_731C ; id 366
    db $7A
    dw Data_07A_7487 ; id 367
    db $7A
    dw Data_07A_76B7 ; id 368
    db $7A
    dw Data_07A_7860 ; id 369
    db $7A
    dw Data_07A_7A0F ; id 370
    db $7A
    dw Data_07A_7B44 ; id 371
    db $7A
    dw Data_07A_7D78 ; id 372
    db $7A
    dw Data_074_4001 ; id 373
    db $74
    dw Data_074_4001 ; id 374
    db $74
    dw Data_074_4001 ; id 375
    db $74
    dw Data_074_4001 ; id 376
    db $74
    dw Data_074_4001 ; id 377
    db $74
    dw Data_074_4001 ; id 378
    db $74
    dw Data_074_4001 ; id 379
    db $74
    dw Data_076_7D8A ; id 380
    db $76
    dw Data_07B_4001 ; id 381
    db $7B
    dw Data_075_7D5F ; id 382
    db $75

; E-0041 (C1: Func_000_2090 indexes it with the monster id; the 36 bytes it points at are added to hFFC6 and written to VRAM bank 1 as the picture's tile attributes). Far pointers: address, bank.
; record: raw 6 x 6 attribute map for the picture (a zero entry selects a default); ROM bank of that data
MonsterAttributeMapTable::
Data_038_447E:: ; heuristic: start of a structured table; C0
    dw JumpTable ; id 0
    db $00
    dw JumpTable ; id 1
    db $00
    dw JumpTable ; id 2
    db $00
    dw Data_07B_59F9 ; id 3
    db $7B
    dw Data_07B_5A1D ; id 4
    db $7B
    dw Data_07B_5A41 ; id 5
    db $7B
    dw Data_07B_5A65 ; id 6
    db $7B
    dw JumpTable ; id 7
    db $00
    dw JumpTable ; id 8
    db $00
    dw Data_07B_5A89 ; id 9
    db $7B
    dw JumpTable ; id 10
    db $00
    dw JumpTable ; id 11
    db $00
    dw Data_07B_5AAD ; id 12
    db $7B
    dw JumpTable ; id 13
    db $00
    dw Data_07B_5AD1 ; id 14
    db $7B
    dw JumpTable ; id 15
    db $00
    dw Data_07B_5AF5 ; id 16
    db $7B
    dw JumpTable ; id 17
    db $00
    dw JumpTable ; id 18
    db $00
    dw Data_07B_5B19 ; id 19
    db $7B
    dw Data_07B_5B3D ; id 20
    db $7B
    dw Data_07B_5B61 ; id 21
    db $7B
    dw Data_07B_5B85 ; id 22
    db $7B
    dw Data_07B_5BA9 ; id 23
    db $7B
    dw Data_07B_5BCD ; id 24
    db $7B
    dw Data_07B_5BF1 ; id 25
    db $7B
    dw Data_07B_5C15 ; id 26
    db $7B
    dw JumpTable ; id 27
    db $00
    dw JumpTable ; id 28
    db $00
    dw JumpTable ; id 29
    db $00
    dw JumpTable ; id 30
    db $00
    dw JumpTable ; id 31
    db $00
    dw JumpTable ; id 32
    db $00
    dw JumpTable ; id 33
    db $00
    dw JumpTable ; id 34
    db $00
    dw JumpTable ; id 35
    db $00
    dw Data_07B_5C39 ; id 36
    db $7B
    dw Data_07B_5C5D ; id 37
    db $7B
    dw Data_07B_5C81 ; id 38
    db $7B
    dw JumpTable ; id 39
    db $00
    dw Data_07B_5CA5 ; id 40
    db $7B
Data_038_44F9:: ; heuristic: label inside a table; C0
    dw Data_07B_5CC9 ; id 41
    db $7B
    dw Data_07B_5CED ; id 42
    db $7B
    dw Data_07B_5D11 ; id 43
    db $7B
    dw JumpTable ; id 44
    db $00
    dw Data_07B_5D35 ; id 45
    db $7B
    dw Data_07B_5D59 ; id 46
    db $7B
    dw Data_07B_5D7D ; id 47
    db $7B
    dw Data_07B_5DA1 ; id 48
    db $7B
    dw JumpTable ; id 49
    db $00
    dw JumpTable ; id 50
    db $00
    dw Data_07B_5DC5 ; id 51
    db $7B
    dw JumpTable ; id 52
    db $00
    dw Data_07B_5DE9 ; id 53
    db $7B
    dw Data_07B_5E0D ; id 54
    db $7B
    dw Data_07B_5E31 ; id 55
    db $7B
    dw JumpTable ; id 56
    db $00
    dw Data_07B_5E55 ; id 57
    db $7B
    dw Data_07B_5E79 ; id 58
    db $7B
    dw Data_07B_5E9D ; id 59
    db $7B
    dw Data_07B_5EC1 ; id 60
    db $7B
    dw Data_07B_5EE5 ; id 61
    db $7B
    dw JumpTable ; id 62
    db $00
    dw Data_07B_5F09 ; id 63
    db $7B
    dw Data_07B_5F2D ; id 64
    db $7B
    dw Data_07B_5F51 ; id 65
    db $7B
    dw Data_07B_5F75 ; id 66
    db $7B
    dw JumpTable ; id 67
    db $00
    dw JumpTable ; id 68
    db $00
    dw JumpTable ; id 69
    db $00
    dw JumpTable ; id 70
    db $00
    dw Data_07B_5F99 ; id 71
    db $7B
    dw JumpTable ; id 72
    db $00
    dw JumpTable ; id 73
    db $00
    dw Data_07B_5FE1 ; id 74
    db $7B
    dw Data_07B_6005 ; id 75
    db $7B
    dw Data_07B_6029 ; id 76
    db $7B
    dw Data_07B_604D ; id 77
    db $7B
    dw JumpTable ; id 78
    db $00
    dw Data_07B_6071 ; id 79
    db $7B
    dw Data_07B_6095 ; id 80
    db $7B
    dw Data_07B_60B9 ; id 81
    db $7B
    dw Data_07B_60DD ; id 82
    db $7B
    dw JumpTable ; id 83
    db $00
    dw Data_07B_6101 ; id 84
    db $7B
    dw JumpTable ; id 85
    db $00
    dw Data_07B_6125 ; id 86
    db $7B
    dw Data_07B_6149 ; id 87
    db $7B
    dw Data_07B_616D ; id 88
    db $7B
    dw Data_07B_6191 ; id 89
    db $7B
    dw JumpTable ; id 90
    db $00
    dw Data_07B_61B5 ; id 91
    db $7B
    dw Data_07B_61D9 ; id 92
    db $7B
    dw Data_07B_61FD ; id 93
    db $7B
    dw JumpTable ; id 94
    db $00
    dw JumpTable ; id 95
    db $00
    dw JumpTable ; id 96
    db $00
    dw Data_07B_6221 ; id 97
    db $7B
    dw Data_07B_6245 ; id 98
    db $7B
    dw Data_07B_6269 ; id 99
    db $7B
    dw Data_07B_628D ; id 100
    db $7B
    dw Data_07B_62B1 ; id 101
    db $7B
Data_038_45B0:: ; heuristic: label inside a table; C0
    dw Data_07B_62D5 ; id 102
    db $7B
    dw JumpTable ; id 103
    db $00
    dw JumpTable ; id 104
    db $00
    dw JumpTable ; id 105
    db $00
    dw Data_07B_62F9 ; id 106
    db $7B
    dw Data_07B_631D ; id 107
    db $7B
    dw Data_07B_6341 ; id 108
    db $7B
    dw Data_07B_6365 ; id 109
    db $7B
    dw Data_07B_6389 ; id 110
    db $7B
    dw Data_07B_63AD ; id 111
    db $7B
    dw Data_07B_63D1 ; id 112
    db $7B
    dw JumpTable ; id 113
    db $00
    dw Data_07B_63F5 ; id 114
    db $7B
    dw JumpTable ; id 115
    db $00
    dw Data_07B_6419 ; id 116
    db $7B
    dw Data_07B_643D ; id 117
    db $7B
    dw Data_07B_6461 ; id 118
    db $7B
    dw JumpTable ; id 119
    db $00
    dw Data_07B_6485 ; id 120
    db $7B
    dw Data_07B_64A9 ; id 121
    db $7B
    dw Data_07B_64CD ; id 122
    db $7B
    dw Data_07B_64F1 ; id 123
    db $7B
    dw JumpTable ; id 124
    db $00
    dw Data_07B_6515 ; id 125
    db $7B
    dw Data_07B_6539 ; id 126
    db $7B
    dw Data_07B_655D ; id 127
    db $7B
    dw Data_07B_6581 ; id 128
    db $7B
    dw Data_07B_65A5 ; id 129
    db $7B
    dw Data_07B_65C9 ; id 130
    db $7B
    dw Data_07B_65ED ; id 131
    db $7B
    dw Data_07B_6611 ; id 132
    db $7B
    dw JumpTable ; id 133
    db $00
    dw JumpTable ; id 134
    db $00
    dw JumpTable ; id 135
    db $00
    dw JumpTable ; id 136
    db $00
    dw JumpTable ; id 137
    db $00
    dw JumpTable ; id 138
    db $00
    dw JumpTable ; id 139
    db $00
    dw JumpTable ; id 140
    db $00
    dw Data_07B_6635 ; id 141
    db $7B
    dw Data_07B_6659 ; id 142
    db $7B
    dw Data_07B_667D ; id 143
    db $7B
    dw Data_07B_66A1 ; id 144
    db $7B
    dw Data_07B_66C5 ; id 145
    db $7B
    dw Data_07B_66E9 ; id 146
    db $7B
    dw Data_07B_670D ; id 147
    db $7B
    dw Data_07B_6731 ; id 148
    db $7B
    dw Data_07B_6755 ; id 149
    db $7B
    dw Data_07B_6779 ; id 150
    db $7B
    dw Data_07B_679D ; id 151
    db $7B
    dw Data_07B_67C1 ; id 152
    db $7B
    dw Data_07B_67E5 ; id 153
    db $7B
    dw Data_07B_6809 ; id 154
    db $7B
    dw Data_07B_682D ; id 155
    db $7B
    dw Data_07B_6851 ; id 156
    db $7B
    dw Data_07B_6875 ; id 157
    db $7B
    dw Data_07B_6899 ; id 158
    db $7B
    dw Data_07B_68BD ; id 159
    db $7B
    dw Data_07B_68E1 ; id 160
    db $7B
    dw Data_07B_6905 ; id 161
    db $7B
    dw Data_07B_6929 ; id 162
Data_038_4666:: ; heuristic: label inside a table; C0
    db $7B
    dw Data_07B_694D ; id 163
    db $7B
    dw Data_07B_6971 ; id 164
    db $7B
    dw JumpTable ; id 165
    db $00
    dw JumpTable ; id 166
    db $00
    dw Data_07B_6995 ; id 167
    db $7B
    dw JumpTable ; id 168
    db $00
    dw JumpTable ; id 169
    db $00
    dw JumpTable ; id 170
    db $00
    dw JumpTable ; id 171
    db $00
    dw JumpTable ; id 172
    db $00
    dw JumpTable ; id 173
    db $00
    dw JumpTable ; id 174
    db $00
    dw JumpTable ; id 175
    db $00
    dw Data_07B_69B9 ; id 176
    db $7B
    dw Data_07B_69DD ; id 177
    db $7B
    dw JumpTable ; id 178
    db $00
    dw Data_07B_6A01 ; id 179
    db $7B
    dw Data_07B_6A25 ; id 180
    db $7B
    dw JumpTable ; id 181
    db $00
    dw Data_07B_6A49 ; id 182
    db $7B
    dw Data_07B_6A6D ; id 183
    db $7B
    dw Data_07B_6A91 ; id 184
    db $7B
    dw JumpTable ; id 185
    db $00
    dw Data_07B_6AB5 ; id 186
    db $7B
    dw Data_07B_6AD9 ; id 187
    db $7B
    dw Data_07B_6AFD ; id 188
    db $7B
    dw Data_07B_6B21 ; id 189
    db $7B
    dw Data_07B_6B45 ; id 190
    db $7B
    dw Data_07B_6B69 ; id 191
    db $7B
    dw JumpTable ; id 192
    db $00
    dw JumpTable ; id 193
    db $00
    dw Data_07B_6B8D ; id 194
    db $7B
    dw Data_07B_6BB1 ; id 195
    db $7B
    dw Data_07B_6BD5 ; id 196
    db $7B
    dw Data_07B_6BF9 ; id 197
    db $7B
    dw JumpTable ; id 198
    db $00
    dw Data_07B_6C1D ; id 199
    db $7B
    dw Data_07B_6C41 ; id 200
    db $7B
    dw Data_07B_6C65 ; id 201
    db $7B
    dw JumpTable ; id 202
    db $00
    dw JumpTable ; id 203
    db $00
    dw JumpTable ; id 204
    db $00
    dw JumpTable ; id 205
    db $00
    dw JumpTable ; id 206
    db $00
    dw JumpTable ; id 207
    db $00
    dw JumpTable ; id 208
    db $00
    dw JumpTable ; id 209
    db $00
    dw JumpTable ; id 210
    db $00
    dw Data_07B_6C89 ; id 211
    db $7B
    dw JumpTable ; id 212
    db $00
    dw JumpTable ; id 213
    db $00
    dw Data_07B_6CAD ; id 214
    db $7B
    dw JumpTable ; id 215
    db $00
    dw JumpTable ; id 216
    db $00
    dw Data_07B_6CD1 ; id 217
    db $7B
    dw JumpTable ; id 218
    db $00
    dw Data_07B_6CF5 ; id 219
    db $7B
    dw Data_07B_6D19 ; id 220
    db $7B
    dw JumpTable ; id 221
    db $00
    dw Data_07B_6D3D ; id 222
    db $7B
    dw Data_07B_6D61 ; id 223
    db $7B
    dw Data_07B_6D85 ; id 224
    db $7B
    dw Data_07B_6DA9 ; id 225
    db $7B
    dw Data_07B_6DCD ; id 226
    db $7B
    dw Data_07B_6DF1 ; id 227
    db $7B
    dw Data_07B_6E15 ; id 228
    db $7B
    dw Data_07B_6E39 ; id 229
    db $7B
    dw Data_07B_6E5D ; id 230
    db $7B
    dw Data_07B_6E81 ; id 231
    db $7B
    dw Data_07B_6EA5 ; id 232
    db $7B
    dw Data_07B_6EC9 ; id 233
    db $7B
    dw Data_07B_6EED ; id 234
    db $7B
    dw Data_07B_6F11 ; id 235
    db $7B
    dw Data_07B_6F35 ; id 236
    db $7B
    dw Data_07B_6F59 ; id 237
    db $7B
    dw Data_07B_6F7D ; id 238
    db $7B
    dw Data_07B_6FA1 ; id 239
    db $7B
    dw Data_07B_6FC5 ; id 240
    db $7B
    dw JumpTable ; id 241
    db $00
    dw JumpTable ; id 242
    db $00
    dw JumpTable ; id 243
    db $00
    dw JumpTable ; id 244
    db $00
    dw JumpTable ; id 245
    db $00
    dw Data_07B_6FE9 ; id 246
    db $7B
    dw Data_07B_700D ; id 247
    db $7B
    dw JumpTable ; id 248
    db $00
    dw Data_07B_7031 ; id 249
    db $7B
    dw Data_07B_7055 ; id 250
    db $7B
Data_038_476F:: ; heuristic: label inside a table; C0
    dw Data_07B_7079 ; id 251
    db $7B
    dw Data_07B_709D ; id 252
    db $7B
    dw JumpTable ; id 253
    db $00
    dw JumpTable ; id 254
    db $00
    dw Data_07B_70C1 ; id 255
    db $7B
    dw JumpTable ; id 256
    db $00
    dw JumpTable ; id 257
    db $00
    dw JumpTable ; id 258
    db $00
    dw JumpTable ; id 259
    db $00
    dw Data_07B_70E5 ; id 260
    db $7B
    dw JumpTable ; id 261
    db $00
    dw Data_07B_7109 ; id 262
    db $7B
    dw Data_07B_712D ; id 263
    db $7B
    dw Data_07B_7151 ; id 264
    db $7B
    dw Data_07B_7175 ; id 265
    db $7B
    dw Data_07B_7199 ; id 266
    db $7B
    dw Data_07B_71BD ; id 267
    db $7B
    dw Data_07B_71E1 ; id 268
    db $7B
    dw JumpTable ; id 269
    db $00
    dw JumpTable ; id 270
    db $00
    dw Data_07B_7205 ; id 271
    db $7B
    dw JumpTable ; id 272
    db $00
    dw JumpTable ; id 273
    db $00
    dw JumpTable ; id 274
    db $00
    dw JumpTable ; id 275
    db $00
    dw JumpTable ; id 276
    db $00
    dw JumpTable ; id 277
    db $00
    dw JumpTable ; id 278
    db $00
    dw JumpTable ; id 279
    db $00
    dw JumpTable ; id 280
    db $00
    dw Data_07B_7229 ; id 281
    db $7B
    dw JumpTable ; id 282
    db $00
    dw Data_07B_724D ; id 283
    db $7B
    dw Data_07B_7271 ; id 284
Data_038_47D4:: ; heuristic: label inside a table; C0
    db $7B
    dw Data_07B_7295 ; id 285
    db $7B
    dw JumpTable ; id 286
    db $00
    dw JumpTable ; id 287
    db $00
    dw Data_07B_72B9 ; id 288
    db $7B
    dw Data_07B_72DD ; id 289
    db $7B
    dw JumpTable ; id 290
    db $00
    dw JumpTable ; id 291
    db $00
    dw Data_07B_7301 ; id 292
    db $7B
    dw Data_07B_7325 ; id 293
    db $7B
    dw JumpTable ; id 294
    db $00
    dw Data_07B_7349 ; id 295
    db $7B
    dw Data_07B_736D ; id 296
    db $7B
    dw Data_07B_7391 ; id 297
    db $7B
    dw Data_07B_73B5 ; id 298
    db $7B
    dw JumpTable ; id 299
    db $00
    dw JumpTable ; id 300
    db $00
    dw JumpTable ; id 301
    db $00
    dw JumpTable ; id 302
    db $00
    dw Data_07B_73D9 ; id 303
    db $7B
    dw Data_07B_73FD ; id 304
    db $7B
    dw JumpTable ; id 305
    db $00
    dw JumpTable ; id 306
    db $00
    dw JumpTable ; id 307
    db $00
    dw JumpTable ; id 308
    db $00
    dw Data_07B_7421 ; id 309
    db $7B
    dw Data_07B_7445 ; id 310
    db $7B
    dw Data_07B_7469 ; id 311
    db $7B
    dw Data_07B_748D ; id 312
    db $7B
    dw JumpTable ; id 313
    db $00
    dw JumpTable ; id 314
    db $00
    dw JumpTable ; id 315
    db $00
    dw Data_07B_74B1 ; id 316
    db $7B
    dw Data_07B_74D5 ; id 317
    db $7B
    dw JumpTable ; id 318
    db $00
    dw JumpTable ; id 319
    db $00
    dw Data_07B_74F9 ; id 320
    db $7B
    dw Data_07B_751D ; id 321
    db $7B
    dw JumpTable ; id 322
    db $00
    dw Data_07B_7541 ; id 323
    db $7B
    dw Data_07B_7565 ; id 324
    db $7B
    dw JumpTable ; id 325
    db $00
    dw Data_07B_7589 ; id 326
    db $7B
    dw Data_07B_75AD ; id 327
    db $7B
    dw Data_07B_75D1 ; id 328
    db $7B
    dw Data_07B_75F5 ; id 329
    db $7B
    dw Data_07B_7619 ; id 330
    db $7B
    dw JumpTable ; id 331
    db $00
    dw Data_07B_763D ; id 332
    db $7B
    dw Data_07B_7661 ; id 333
    db $7B
    dw JumpTable ; id 334
    db $00
    dw Data_07B_7685 ; id 335
    db $7B
    dw Data_07B_76A9 ; id 336
Data_038_4870:: ; heuristic: label inside a table; C0
    db $7B
    dw Data_07B_76CD ; id 337
    db $7B
    dw JumpTable ; id 338
    db $00
    dw Data_07B_76F1 ; id 339
    db $7B
    dw Data_07B_7715 ; id 340
    db $7B
    dw Data_07B_7739 ; id 341
    db $7B
    dw Data_07B_775D ; id 342
    db $7B
    dw Data_07B_7781 ; id 343
    db $7B
    dw Data_07B_77A5 ; id 344
    db $7B
    dw Data_07B_77C9 ; id 345
    db $7B
    dw Data_07B_77ED ; id 346
    db $7B
    dw JumpTable ; id 347
    db $00
    dw JumpTable ; id 348
    db $00
    dw JumpTable ; id 349
    db $00
    dw JumpTable ; id 350
    db $00
    dw Data_07B_7811 ; id 351
    db $7B
    dw Data_07B_7835 ; id 352
    db $7B
    dw Data_07B_7859 ; id 353
    db $7B
    dw Data_07B_787D ; id 354
    db $7B
    dw JumpTable ; id 355
    db $00
    dw Data_07B_78A1 ; id 356
    db $7B
    dw Data_07B_78C5 ; id 357
    db $7B
    dw Data_07B_78E9 ; id 358
    db $7B
    dw Data_07B_790D ; id 359
    db $7B
    dw JumpTable ; id 360
    db $00
    dw Data_07B_7931 ; id 361
    db $7B
    dw Data_07B_7955 ; id 362
    db $7B
    dw Data_07B_7979 ; id 363
    db $7B
    dw JumpTable ; id 364
    db $00
    dw Data_07B_799D ; id 365
    db $7B
    dw Data_07B_79C1 ; id 366
    db $7B
    dw JumpTable ; id 367
    db $00
    dw Data_07B_79E5 ; id 368
    db $7B
    dw Data_07B_7A09 ; id 369
    db $7B
    dw Data_07B_7A2D ; id 370
    db $7B
    dw Data_07B_7A51 ; id 371
    db $7B
    dw Data_07B_7A75 ; id 372
    db $7B
    dw JumpTable ; id 373
    db $00
    dw JumpTable ; id 374
    db $00
    dw JumpTable ; id 375
    db $00
    dw JumpTable ; id 376
    db $00
    dw JumpTable ; id 377
    db $00
    dw JumpTable ; id 378
    db $00
    dw JumpTable ; id 379
    db $00
    dw Data_07B_7A99 ; id 380
    db $7B
    dw Data_07B_7ABD ; id 381
    db $7B
    dw Data_07B_7AE1 ; id 382
    db $7B
    ds $5C, $00

Data_038_4957:: ; heuristic: target of a monotone pointer table; C0
    ds $94, $00

Data_038_49EB:: ; heuristic: target of a monotone pointer table; C0
    ds $AC, $00

Data_038_4A97:: ; heuristic: target of a monotone pointer table; C0
    ds $C4, $00

Data_038_4B5B:: ; heuristic: target of a monotone pointer table; C0
    ds $148, $00

Data_038_4CA3:: ; heuristic: target of a monotone pointer table; C0
    ds $65, $00

Data_038_4D08:: ; heuristic: target of a monotone pointer table; C0
    ds $B7, $00

Data_038_4DBF:: ; heuristic: target of a monotone pointer table; C0
    ds $166, $00

Data_038_4F25:: ; heuristic: target of a monotone pointer table; C0
    ds $D9, $00

Data_038_4FFE:: ; heuristic: target of a monotone pointer table; C0
    ds $10A, $00

Data_038_5108:: ; heuristic: target of a monotone pointer table; C0
    ds $AB, $00

Data_038_51B3:: ; heuristic: target of a monotone pointer table; C0
    ds $149, $00

Data_038_52FC:: ; heuristic: target of a monotone pointer table; C0
    ds $1EB, $00

Data_038_54E7:: ; heuristic: target of a monotone pointer table; C0
    ds $1FD, $00

Data_038_56E4:: ; heuristic: target of a monotone pointer table; C0
    ds $435, $00

Data_038_5B19:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5B3D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5B61:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5B85:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5BA9:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5BCD:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5BF1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5C15:: ; heuristic: target of a monotone pointer table; C0
    ds $1B0, $00

Data_038_5DC5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5DE9:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_5E31:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5E55:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_5E9D:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_5EE5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_5F09:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_5F51:: ; heuristic: target of a monotone pointer table; C0
    ds $3A8, $00

Data_038_62F9:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6341:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6389:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_63D1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_63F5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6419:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6461:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6485:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_64CD:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6515:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6539:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_655D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6581:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_65A5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_65C9:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_65ED:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6611:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6635:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6659:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_667D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_66A1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_66C5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_66E9:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_670D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6731:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6755:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6779:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_679D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_67C1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_67E5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6809:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_682D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6851:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6875:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6899:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_68BD:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_68E1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6905:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6929:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_694D:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6971:: ; heuristic: target of a monotone pointer table; C0
    ds $3A8, $00

Data_038_6D19:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_6D3D:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6D85:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6DCD:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6E15:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6E5D:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6EA5:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6EED:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6F35:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6F7D:: ; heuristic: target of a monotone pointer table; C0
    ds $48, $00

Data_038_6FC5:: ; heuristic: target of a monotone pointer table; C0
    ds $47B, $00

Data_038_7440:: ; heuristic: target of a monotone pointer table; C0
    ds $17, $00

Data_038_7457:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7458:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_745A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_745B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_745D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_745E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7460:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7461:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7463:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7465:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7466:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7467:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7469:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_746B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_746C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_746E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_746F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7470:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7472:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7473:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7475:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7477:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7478:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_747A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_747C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_747E:: ; heuristic: target of a monotone pointer table; C0
    ds $C2, $00

Data_038_7540:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7541:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7543:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7545:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7547:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7549:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_754A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_754B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_754C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_754D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_754E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7550:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7551:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7552:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7554:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7556:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7557:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7558:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7559:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_755B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_755C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_755E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_755F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7561:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7563:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7564:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7566:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7567:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7569:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_756B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_756D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_756F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7570:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7572:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7574:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7575:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7577:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_757A:: ; heuristic: target of a monotone pointer table; C0
    ds $C6, $00

Data_038_7640:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7642:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7644:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7646:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7649:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_764C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_764F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7652:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_038_7656:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7659:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_038_765D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7660:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_038_7664:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7666:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7669:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_766B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_766E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7670:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7673:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7676:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7678:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_767B:: ; heuristic: target of a monotone pointer table; C0
    ds $76, $00

Data_038_76F1:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_7715:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_7739:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_038_7743:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7745:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7747:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7748:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7749:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_774F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7750:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7751:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7752:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7753:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7754:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7755:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7756:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7757:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7758:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_775A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_775B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_775D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_775E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_775F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7761:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7762:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7764:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7766:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7768:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7769:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_776B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_776C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_776D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_776E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_776F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7770:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7771:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7772:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7774:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7775:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7776:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7778:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7779:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_777B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_777C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_777D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00

Data_038_7781:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_77A5:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_77C9:: ; heuristic: target of a monotone pointer table; C0
    ds $24, $00

Data_038_77ED:: ; heuristic: target of a monotone pointer table; C0
    ds $53, $00

Data_038_7840:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7841:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7843:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7844:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7845:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7846:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7847:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7849:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_784B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_784C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_784D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_784E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7851:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7852:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7854:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7855:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7857:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7859:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_785B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_785D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_785F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7861:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7862:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7864:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7866:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7868:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_786A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_786B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_786E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_786F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7870:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7872:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7873:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7874:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7875:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7876:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7878:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7879:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_787A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_787B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_787D:: ; heuristic: target of a monotone pointer table; C0
    ds $C3, $00

Data_038_7940:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7941:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7942:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7944:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7945:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7947:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7949:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_794A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_794C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_794E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7950:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7951:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7952:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7954:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7955:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7956:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7957:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7958:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7959:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_795A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_795C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_795D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_795E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_795F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7960:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7962:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7964:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7965:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7966:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7967:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7969:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_796B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_796C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_796D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_796E:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_796F:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7970:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7972:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7973:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7975:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7976:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7977:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7979:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_797B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_797D:: ; heuristic: target of a monotone pointer table; C0
    ds $C4, $00

Data_038_7A41:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A43:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A45:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A47:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A48:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A4A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A4C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A4E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A50:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A52:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A54:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A55:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A56:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A58:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A59:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7A5C:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A5D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A5F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A61:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A63:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A65:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A67:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A69:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A6B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A6D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A6E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_038_7A71:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A73:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A74:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A76:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A78:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A7A:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_038_7A7B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00

Data_038_7A7D:: ; heuristic: target of a monotone pointer table; C0
    ds $583, $00
