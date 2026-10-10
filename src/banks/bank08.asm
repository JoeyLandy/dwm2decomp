SECTION "Bank 08", ROMX[$4000], BANK[$08]
    db $08

; if wC528 < 9, BeginStringDisplay with DE = StringDatabase; otherwise far-calls Func_095_4650
; 12 call sites from 6 routines (e.g. ShowString_Bank08, Func_000_2E72, Func_001_4AD4, Func_003_5253, ...)
; reads: wStringCategory
BeginStringDisplay_Bank08::
Func_008_4001:: ; address name
    ld a, [wStringCategory]
    cp a, $09
    jr c, Jump_008_400F
    farcall Func_095_4650
    ret

Jump_008_400F::
    ld de, StringDatabase
    call BeginStringDisplay
    ret

; if wC528 < 9, CopyStringToBuffer with DE = StringDatabase; otherwise far-calls Func_095_465F
; 3 call sites from 3 routines (e.g. Func_000_2E81, Func_012_4B19, Func_0A1_52D4)
; reads: wStringCategory
CopyStringToBuffer_Bank08::
Func_008_4016:: ; address name
    ld a, [wStringCategory]
    cp a, $09
    jr c, Jump_008_4024
    farcall Func_095_465F
    ret

Jump_008_4024::
    ld de, StringDatabase
    call CopyStringToBuffer
    ret

; Func_008_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 67 call sites from 40 routines (e.g. Func_001_4045, Func_001_4F80, Func_001_5EAF, Func_001_6903, ...)
ShowString_Bank08::
Func_008_402B:: ; address name
    call BeginStringDisplay_Bank08
    call RunStringDisplayToEnd
    ret

; nine pointers, one per string category; each points at a table of string pointers; strings end in $F0 (E-0026)
StringDatabase:: ; heuristic: bank from RAM variable $D7FE; C0
Data_008_4032:: ; address name
    dw StringTable_System
    dw StringTable_MonsterFamilies
    dw StringTable_MonsterNames

Data_008_4038:: ; heuristic: argument of a bank-switching copy helper; C0
    dw StringTable_MonsterNames2
    dw StringTable_SkillNames

Data_008_403C:: ; heuristic: argument of a bank-switching copy helper; C0
    dw StringTable_ItemNames
    dw StringTable_ItemDescriptions
    dw StringTable_PersonalityNames
    dw StringTable_ItemMenuMessages

; 255 strings: debug-menu and system text, for example 'DEBUG MODE' and '? EDIT ?' (named from its contents; E-0026)
StringTable_System:: ; heuristic: target of a monotone pointer table; C0
Data_008_4044:: ; address name
    dw Data_008_492A
    dw Data_008_493B
    dw Data_008_4A1A
    dw Data_008_4A94
    dw Data_008_4AAC
    dw Data_008_4B26
    dw Data_008_4B26
    dw Data_008_4B3F
    dw Data_008_4B65
    dw Data_008_4B6E
    dw Data_008_4BBD
    dw Data_008_4BC9
    dw Data_008_4BD2
    dw Data_008_4BDE
    dw Data_008_4BE9
    dw Data_008_4BF3
    dw Data_008_4BFE
    dw Data_008_4C03
    dw Data_008_4C0A
    dw Data_008_4C10
    dw Data_008_4C19
    dw Data_008_4C23
    dw Data_008_4C23
    dw Data_008_4C2E
    dw Data_008_4C37
    dw Data_008_4C42
    dw Data_008_4C4B
    dw Data_008_4C55
    dw Data_008_4C5D
    dw Data_008_4C67
    dw Data_008_4C72
    dw Data_008_4C7D
    dw Data_008_4C86
    dw Data_008_4C90
    dw Data_008_4C97
    dw Data_008_4C9D
    dw Data_008_4CA8
    dw Data_008_4CB0
    dw Data_008_4CB9
    dw Data_008_4CC3
    dw Data_008_4CC8
    dw Data_008_4CC8
    dw Data_008_4CCB
    dw Data_008_4CD4
    dw Data_008_4CDC
    dw Data_008_4CE6
    dw Data_008_4CF0
    dw Data_008_4CF8
    dw Data_008_4D00
    dw Data_008_4D0C
    dw Data_008_4D0F
    dw Data_008_4D17
    dw Data_008_4D24
    dw Data_008_4D2E
    dw Data_008_4D34
    dw Data_008_4D3D
    dw Data_008_4D45
    dw Data_008_4D4E
    dw Data_008_4D5A
    dw Data_008_4D62
    dw Data_008_4D69
    dw Data_008_4D73
    dw Data_008_4D7F
    dw Data_008_4D8B
    dw Data_008_4D92
    dw Data_008_4D9C
    dw Data_008_4DA4
    dw Data_008_4DAF
    dw Data_008_4DBB
    dw Data_008_4DC7
    dw Data_008_4DD2
    dw Data_008_4DDB
    dw Data_008_4DE6
    dw Data_008_4DF1
    dw Data_008_4DFC
    dw Data_008_4E05
    dw Data_008_4E0F
    dw Data_008_4E17
    dw Data_008_4E21
    dw Data_008_4E2C
    dw Data_008_4E39
    dw Data_008_4E39
    dw Data_008_4E3C
    dw Data_008_4E42
    dw Data_008_4E49
    dw Data_008_4E52
    dw Data_008_4E5D
    dw Data_008_4E66
    dw Data_008_4E72
    dw Data_008_4E7B
    dw Data_008_4E83
    dw Data_008_4E8D
    dw Data_008_4E97
    dw Data_008_4EA3
    dw Data_008_4EA8
    dw Data_008_4EB1
    dw Data_008_4EBA
    dw Data_008_4EC3
    dw Data_008_4ECD
    dw Data_008_4ED6
    dw Data_008_4EE1
    dw Data_008_4EEC
    dw Data_008_4EF7
    dw Data_008_4F01
    dw Data_008_4F0A
    dw Data_008_4F14
    dw Data_008_4F1F
    dw Data_008_4F28
    dw Data_008_4F33
    dw Data_008_4F3E
    dw Data_008_4F48
    dw Data_008_4F52
    dw Data_008_4F5C
    dw Data_008_4F66
    dw Data_008_4F70
    dw Data_008_4F7D
    dw Data_008_4F7D
    dw Data_008_4F7D
    dw Data_008_4F7D
    dw Data_008_4F7D
    dw Data_008_4F7D
    dw Data_008_4F7D
    dw Data_008_4F80
    dw Data_008_4F88
    dw Data_008_4F90
    dw Data_008_4F9A
    dw Data_008_4FA4
    dw Data_008_4FAE
    dw Data_008_4FB8
    dw Data_008_4FC2
    dw Data_008_4FCE
    dw Data_008_4FD4
    dw Data_008_4FDC
    dw Data_008_4FE7
    dw Data_008_4FF0
    dw Data_008_4FF9
    dw Data_008_5004
    dw Data_008_500F
    dw Data_008_5018
    dw Data_008_5024
    dw Data_008_502C
    dw Data_008_5038
    dw Data_008_5044
    dw Data_008_504D
    dw Data_008_5057
    dw Data_008_5061
    dw Data_008_506B
    dw Data_008_5075
    dw Data_008_507C
    dw Data_008_5083
    dw Data_008_508D
    dw Data_008_5096
    dw Data_008_509D
    dw Data_008_50A6
    dw Data_008_50B0
    dw Data_008_50B9
    dw Data_008_50C2
    dw Data_008_50CA
    dw Data_008_50D2
    dw Data_008_50DD
    dw Data_008_50E9
    dw Data_008_50F5
    dw Data_008_5101
    dw Data_008_510D
    dw Data_008_5119
    dw Data_008_5125
    dw Data_008_5130
    dw Data_008_5133
    dw Data_008_5140
    dw Data_008_5140
    dw Data_008_5143
    dw Data_008_514B
    dw Data_008_5154
    dw Data_008_5160
    dw Data_008_5168
    dw Data_008_5175
    dw Data_008_5175
    dw Data_008_5175
    dw Data_008_5178
    dw Data_008_5180
    dw Data_008_5188
    dw Data_008_5191
    dw Data_008_5199
    dw Data_008_51A0
    dw Data_008_51A9
    dw Data_008_51B5
    dw Data_008_51C2
    dw Data_008_51CB
    dw Data_008_51D5
    dw Data_008_51E2
    dw Data_008_51EA
    dw Data_008_51F2
    dw Data_008_51FA
    dw Data_008_5205
    dw Data_008_5208
    dw Data_008_5213
    dw Data_008_521C
    dw Data_008_5227
    dw Data_008_5230
    dw Data_008_5234
    dw Data_008_523D
    dw Data_008_5246
    dw Data_008_524F
    dw Data_008_5258
    dw Data_008_5261
    dw Data_008_526A
    dw Data_008_5273
    dw Data_008_527C
    dw Data_008_5289
    dw Data_008_5289
    dw Data_008_528C
    dw Data_008_5294
    dw Data_008_529F
    dw Data_008_52AA
    dw Data_008_52B5
    dw Data_008_52C0
    dw Data_008_52CB
    dw Data_008_52D6
    dw Data_008_52E1
    dw Data_008_52EE
    dw Data_008_52F7
    dw Data_008_5303
    dw Data_008_530F
    dw Data_008_531B
    dw Data_008_5327
    dw Data_008_5333
    dw Data_008_533F
    dw Data_008_534B
    dw Data_008_5358
    dw Data_008_535F
    dw Data_008_5369
    dw Data_008_5373
    dw Data_008_537D
    dw Data_008_5387
    dw Data_008_5391
    dw Data_008_539B
    dw Data_008_53A5
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2
    dw Data_008_53B2

; 11 strings: Slime, Dragon, Beast, Bird, Plant, ... (named from its contents; E-0026)
StringTable_MonsterFamilies:: ; heuristic: target of a monotone pointer table; C0
Data_008_4242:: ; address name
    dw Data_008_53B5
    dw Data_008_53BB
    dw Data_008_53C2
    dw Data_008_53C8
    dw Data_008_53CD
    dw Data_008_53D3
    dw Data_008_53D7
    dw Data_008_53DD
    dw Data_008_53E4
    dw Data_008_53ED
    dw Data_008_53F3

; 256 strings indexed by the number the monster-name routines take in HL (entry 0 is empty): 'DrakSlime', 'SpotSlime', ... (named from its contents; E-0026)
StringTable_MonsterNames:: ; heuristic: target of a monotone pointer table; C0
Data_008_4258:: ; address name
    dw Data_008_53F8
    dw Data_008_53F9
    dw Data_008_5403
    dw Data_008_540D
    dw Data_008_5417
    dw Data_008_5421
    dw Data_008_5428
    dw Data_008_5432
    dw Data_008_5439
    dw Data_008_5442
    dw Data_008_544B
    dw Data_008_5451
    dw Data_008_5458
    dw Data_008_5462
    dw Data_008_546C
    dw Data_008_5476
    dw Data_008_547E
    dw Data_008_5488
    dw Data_008_548F
    dw Data_008_5498
    dw Data_008_54A1
    dw Data_008_54AB
    dw Data_008_54B5
    dw Data_008_54BF
    dw Data_008_54C9
    dw Data_008_54D3
    dw Data_008_54DD
    dw Data_008_54E7
    dw Data_008_54ED
    dw Data_008_54ED
    dw Data_008_54ED
    dw Data_008_54ED
    dw Data_008_54ED
    dw Data_008_54ED
    dw Data_008_54ED
    dw Data_008_54ED
    dw Data_008_54EF
    dw Data_008_54F9
    dw Data_008_5503
    dw Data_008_550C
    dw Data_008_5513
    dw Data_008_551D
    dw Data_008_5527
    dw Data_008_5531
    dw Data_008_553A
    dw Data_008_5541
    dw Data_008_5548
    dw Data_008_5551
    dw Data_008_555B
    dw Data_008_5563
    dw Data_008_556D
    dw Data_008_5577
    dw Data_008_557F
    dw Data_008_5589
    dw Data_008_5592
    dw Data_008_559B
    dw Data_008_55A5
    dw Data_008_55AF
    dw Data_008_55B9
    dw Data_008_55C3
    dw Data_008_55CA
    dw Data_008_55D1
    dw Data_008_55DB
    dw Data_008_55E5
    dw Data_008_55EF
    dw Data_008_55F9
    dw Data_008_5601
    dw Data_008_560B
    dw Data_008_560B
    dw Data_008_560B
    dw Data_008_560B
    dw Data_008_560D
    dw Data_008_5617
    dw Data_008_561F
    dw Data_008_5626
    dw Data_008_5630
    dw Data_008_5637
    dw Data_008_5641
    dw Data_008_564A
    dw Data_008_5654
    dw Data_008_565C
    dw Data_008_5664
    dw Data_008_566D
    dw Data_008_5676
    dw Data_008_567F
    dw Data_008_5689
    dw Data_008_5691
    dw Data_008_5696
    dw Data_008_569F
    dw Data_008_56A9
    dw Data_008_56B3
    dw Data_008_56BD
    dw Data_008_56C6
    dw Data_008_56CE
    dw Data_008_56D7
    dw Data_008_56DF
    dw Data_008_56E9
    dw Data_008_56F1
    dw Data_008_56FA
    dw Data_008_5701
    dw Data_008_5708
    dw Data_008_570F
    dw Data_008_5717
    dw Data_008_571F
    dw Data_008_571F
    dw Data_008_571F
    dw Data_008_5721
    dw Data_008_5727
    dw Data_008_572E
    dw Data_008_5737
    dw Data_008_5740
    dw Data_008_5749
    dw Data_008_5753
    dw Data_008_575C
    dw Data_008_5766
    dw Data_008_576F
    dw Data_008_5776
    dw Data_008_577F
    dw Data_008_5788
    dw Data_008_5791
    dw Data_008_5799
    dw Data_008_57A2
    dw Data_008_57AC
    dw Data_008_57B1
    dw Data_008_57BB
    dw Data_008_57C3
    dw Data_008_57CB
    dw Data_008_57D4
    dw Data_008_57DD
    dw Data_008_57E7
    dw Data_008_57F0
    dw Data_008_57F8
    dw Data_008_5800
    dw Data_008_580A
    dw Data_008_580A
    dw Data_008_580A
    dw Data_008_580A
    dw Data_008_580A
    dw Data_008_580A
    dw Data_008_580A
    dw Data_008_580A
    dw Data_008_580C
    dw Data_008_5815
    dw Data_008_581E
    dw Data_008_5827
    dw Data_008_5830
    dw Data_008_583A
    dw Data_008_5842
    dw Data_008_584C
    dw Data_008_5856
    dw Data_008_5860
    dw Data_008_5869
    dw Data_008_5870
    dw Data_008_587A
    dw Data_008_5882
    dw Data_008_588B
    dw Data_008_5894
    dw Data_008_589C
    dw Data_008_58A4
    dw Data_008_58AD
    dw Data_008_58B6
    dw Data_008_58BE
    dw Data_008_58C7
    dw Data_008_58D0
    dw Data_008_58D9
    dw Data_008_58E1
    dw Data_008_58E9
    dw Data_008_58F3
    dw Data_008_58FB
    dw Data_008_58FB
    dw Data_008_58FB
    dw Data_008_58FB
    dw Data_008_58FB
    dw Data_008_58FB
    dw Data_008_58FB
    dw Data_008_58FB
    dw Data_008_58FD
    dw Data_008_5907
    dw Data_008_5910
    dw Data_008_591A
    dw Data_008_5924
    dw Data_008_592C
    dw Data_008_5936
    dw Data_008_593C
    dw Data_008_5944
    dw Data_008_594A
    dw Data_008_5952
    dw Data_008_595B
    dw Data_008_5965
    dw Data_008_596F
    dw Data_008_5976
    dw Data_008_5980
    dw Data_008_5986
    dw Data_008_598F
    dw Data_008_5999
    dw Data_008_59A2
    dw Data_008_59AC
    dw Data_008_59B5
    dw Data_008_59BD
    dw Data_008_59C7
    dw Data_008_59CF
    dw Data_008_59D9
    dw Data_008_59E3
    dw Data_008_59E3
    dw Data_008_59E3
    dw Data_008_59E3
    dw Data_008_59E3
    dw Data_008_59E3
    dw Data_008_59E3
    dw Data_008_59E3
    dw Data_008_59E3
    dw Data_008_59E5
    dw Data_008_59EA
    dw Data_008_59F4
    dw Data_008_59FC
    dw Data_008_5A05
    dw Data_008_5A0D
    dw Data_008_5A15
    dw Data_008_5A1F
    dw Data_008_5A29
    dw Data_008_5A33
    dw Data_008_5A3D
    dw Data_008_5A45
    dw Data_008_5A4E
    dw Data_008_5A55
    dw Data_008_5A5E
    dw Data_008_5A62
    dw Data_008_5A67
    dw Data_008_5A71
    dw Data_008_5A7B
    dw Data_008_5A85
    dw Data_008_5A8D
    dw Data_008_5A94
    dw Data_008_5A9E
    dw Data_008_5AA7
    dw Data_008_5AB0
    dw Data_008_5ABA
    dw Data_008_5AC4
    dw Data_008_5ACC
    dw Data_008_5AD3
    dw Data_008_5ADB
    dw Data_008_5AE5
    dw Data_008_5AE5
    dw Data_008_5AE5
    dw Data_008_5AE5
    dw Data_008_5AE5
    dw Data_008_5AE7
    dw Data_008_5AEE
    dw Data_008_5AF7
    dw Data_008_5B00
    dw Data_008_5B09
    dw Data_008_5B0F
    dw Data_008_5B18
    dw Data_008_5B21
    dw Data_008_5B28
    dw Data_008_5B31

; 128 more monster names: 'Mudron', 'NiteWhip', ... (named from its contents; E-0026)
StringTable_MonsterNames2:: ; heuristic: target of a monotone pointer table; C0
Data_008_4458:: ; address name
    dw Data_008_5B36
    dw Data_008_5B3D
    dw Data_008_5B46
    dw Data_008_5B50
    dw Data_008_5B57
    dw Data_008_5B60
    dw Data_008_5B68
    dw Data_008_5B71
    dw Data_008_5B7B
    dw Data_008_5B85
    dw Data_008_5B8F
    dw Data_008_5B98
    dw Data_008_5BA0
    dw Data_008_5BAA
    dw Data_008_5BB2
    dw Data_008_5BBC
    dw Data_008_5BC6
    dw Data_008_5BCF
    dw Data_008_5BCF
    dw Data_008_5BCF
    dw Data_008_5BCF
    dw Data_008_5BCF
    dw Data_008_5BCF
    dw Data_008_5BCF
    dw Data_008_5BCF
    dw Data_008_5BD1
    dw Data_008_5BDA
    dw Data_008_5BE3
    dw Data_008_5BED
    dw Data_008_5BF6
    dw Data_008_5BFC
    dw Data_008_5C05
    dw Data_008_5C0F
    dw Data_008_5C19
    dw Data_008_5C22
    dw Data_008_5C28
    dw Data_008_5C30
    dw Data_008_5C3A
    dw Data_008_5C41
    dw Data_008_5C4A
    dw Data_008_5C54
    dw Data_008_5C5D
    dw Data_008_5C66
    dw Data_008_5C70
    dw Data_008_5C78
    dw Data_008_5C7E
    dw Data_008_5C86
    dw Data_008_5C8D
    dw Data_008_5C93
    dw Data_008_5C9C
    dw Data_008_5CA4
    dw Data_008_5CAA
    dw Data_008_5CB3
    dw Data_008_5CBC
    dw Data_008_5CC6
    dw Data_008_5CCF
    dw Data_008_5CD9
    dw Data_008_5CE3
    dw Data_008_5CE3
    dw Data_008_5CE3
    dw Data_008_5CE5
    dw Data_008_5CEE
    dw Data_008_5CF4
    dw Data_008_5CFE
    dw Data_008_5D07
    dw Data_008_5D0E
    dw Data_008_5D18
    dw Data_008_5D1F
    dw Data_008_5D27
    dw Data_008_5D31
    dw Data_008_5D3B
    dw Data_008_5D44
    dw Data_008_5D4E
    dw Data_008_5D57
    dw Data_008_5D60
    dw Data_008_5D69
    dw Data_008_5D73
    dw Data_008_5D7D
    dw Data_008_5D86
    dw Data_008_5D8F
    dw Data_008_5D99
    dw Data_008_5DA2
    dw Data_008_5DAB
    dw Data_008_5DB3
    dw Data_008_5DBD
    dw Data_008_5DC4
    dw Data_008_5DCE
    dw Data_008_5DD6
    dw Data_008_5DDF
    dw Data_008_5DE6
    dw Data_008_5DEF
    dw Data_008_5DF8
    dw Data_008_5E01
    dw Data_008_5E01
    dw Data_008_5E01
    dw Data_008_5E03
    dw Data_008_5E0D
    dw Data_008_5E17
    dw Data_008_5E21
    dw Data_008_5E28
    dw Data_008_5E2E
    dw Data_008_5E38
    dw Data_008_5E40
    dw Data_008_5E45
    dw Data_008_5E4F
    dw Data_008_5E57
    dw Data_008_5E61
    dw Data_008_5E68
    dw Data_008_5E72
    dw Data_008_5E7C
    dw Data_008_5E82
    dw Data_008_5E8C
    dw Data_008_5E96
    dw Data_008_5EA0
    dw Data_008_5EAA
    dw Data_008_5EB4
    dw Data_008_5EBE
    dw Data_008_5EC4
    dw Data_008_5ECA
    dw Data_008_5ED0
    dw Data_008_5ED6
    dw Data_008_5EDC
    dw Data_008_5EDC
    dw Data_008_5EDC
    dw Data_008_5EDE
    dw Data_008_5EE4
    dw Data_008_5EEE
    dw Data_008_5EF6

; 223 strings: 'Blaze', 'Blazemore', 'Blazemost', 'Firebal', ... (named from its contents; E-0026)
StringTable_SkillNames:: ; heuristic: target of a monotone pointer table; C0
Data_008_4558:: ; address name
    dw Data_008_5EF8
    dw Data_008_5EF9
    dw Data_008_5EFF
    dw Data_008_5F09
    dw Data_008_5F13
    dw Data_008_5F1B
    dw Data_008_5F24
    dw Data_008_5F2D
    dw Data_008_5F32
    dw Data_008_5F37
    dw Data_008_5F40
    dw Data_008_5F49
    dw Data_008_5F53
    dw Data_008_5F5D
    dw Data_008_5F62
    dw Data_008_5F66
    dw Data_008_5F6F
    dw Data_008_5F77
    dw Data_008_5F81
    dw Data_008_5F8A
    dw Data_008_5F8F
    dw Data_008_5F96
    dw Data_008_5FA0
    dw Data_008_5FA5
    dw Data_008_5FAE
    dw Data_008_5FB6
    dw Data_008_5FBD
    dw Data_008_5FC7
    dw Data_008_5FCD
    dw Data_008_5FD7
    dw Data_008_5FE1
    dw Data_008_5FE8
    dw Data_008_5FEF
    dw Data_008_5FF8
    dw Data_008_6001
    dw Data_008_6009
    dw Data_008_6011
    dw Data_008_601A
    dw Data_008_6020
    dw Data_008_6029
    dw Data_008_602D
    dw Data_008_6035
    dw Data_008_603B
    dw Data_008_6043
    dw Data_008_6048
    dw Data_008_6050
    dw Data_008_6059
    dw Data_008_6062
    dw Data_008_6068
    dw Data_008_6071
    dw Data_008_607B
    dw Data_008_6084
    dw Data_008_608E
    dw Data_008_6097
    dw Data_008_609F
    dw Data_008_60A9
    dw Data_008_60B0
    dw Data_008_60B8
    dw Data_008_60C2
    dw Data_008_60CC
    dw Data_008_60D5
    dw Data_008_60DC
    dw Data_008_60E6
    dw Data_008_60EE
    dw Data_008_60F8
    dw Data_008_6100
    dw Data_008_6109
    dw Data_008_6113
    dw Data_008_611D
    dw Data_008_6127
    dw Data_008_612E
    dw Data_008_6137
    dw Data_008_6140
    dw Data_008_614A
    dw Data_008_6151
    dw Data_008_615B
    dw Data_008_6165
    dw Data_008_616F
    dw Data_008_6179
    dw Data_008_6182
    dw Data_008_618B
    dw Data_008_6195
    dw Data_008_619F
    dw Data_008_61A9
    dw Data_008_61B2
    dw Data_008_61BC
    dw Data_008_61C6
    dw Data_008_61CF
    dw Data_008_61D8
    dw Data_008_61E0
    dw Data_008_61E7
    dw Data_008_61F0
    dw Data_008_61FA
    dw Data_008_6203
    dw Data_008_620B
    dw Data_008_6214
    dw Data_008_621E
    dw Data_008_6227
    dw Data_008_6231
    dw Data_008_623B
    dw Data_008_6244
    dw Data_008_624D
    dw Data_008_6257
    dw Data_008_6260
    dw Data_008_626A
    dw Data_008_6273
    dw Data_008_627C
    dw Data_008_6285
    dw Data_008_628F
    dw Data_008_6298
    dw Data_008_62A2
    dw Data_008_62AC
    dw Data_008_62B4
    dw Data_008_62BD
    dw Data_008_62C6
    dw Data_008_62CF
    dw Data_008_62D9
    dw Data_008_62E3
    dw Data_008_62E9
    dw Data_008_62F2
    dw Data_008_62FB
    dw Data_008_6305
    dw Data_008_630F
    dw Data_008_6319
    dw Data_008_6323
    dw Data_008_632A
    dw Data_008_6333
    dw Data_008_633D
    dw Data_008_6345
    dw Data_008_634F
    dw Data_008_6355
    dw Data_008_635F
    dw Data_008_6367
    dw Data_008_6370
    dw Data_008_637A
    dw Data_008_6384
    dw Data_008_638E
    dw Data_008_6398
    dw Data_008_63A0
    dw Data_008_63A6
    dw Data_008_63B0
    dw Data_008_63B9
    dw Data_008_63C2
    dw Data_008_63CA
    dw Data_008_63CF
    dw Data_008_63D6
    dw Data_008_63DD
    dw Data_008_63E7
    dw Data_008_63F1
    dw Data_008_63F9
    dw Data_008_63FF
    dw Data_008_6406
    dw Data_008_640C
    dw Data_008_6415
    dw Data_008_641E
    dw Data_008_6428
    dw Data_008_6431
    dw Data_008_643A
    dw Data_008_6442
    dw Data_008_644A
    dw Data_008_6453
    dw Data_008_645C
    dw Data_008_6465
    dw Data_008_646D
    dw Data_008_6477
    dw Data_008_6481
    dw Data_008_6489
    dw Data_008_6492
    dw Data_008_6499
    dw Data_008_64A2
    dw Data_008_64AB
    dw Data_008_64B0
    dw Data_008_64B8
    dw Data_008_64BE
    dw Data_008_64C7
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64CF
    dw Data_008_64D8
    dw Data_008_64D8
    dw Data_008_64D8
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1
    dw Data_008_64E1

; 112 strings: 'Herb', 'LoveWater', 'WorldDew', 'Potion', ... (named from its contents; E-0026)
StringTable_ItemNames:: ; heuristic: target of a monotone pointer table; C0
Data_008_4716:: ; address name
    dw Data_008_64E2
    dw Data_008_64E3
    dw Data_008_64E8
    dw Data_008_64F2
    dw Data_008_64FB
    dw Data_008_6502
    dw Data_008_650B
    dw Data_008_6514
    dw Data_008_651D
    dw Data_008_6524
    dw Data_008_652E
    dw Data_008_6536
    dw Data_008_653F
    dw Data_008_6549
    dw Data_008_6551
    dw Data_008_6559
    dw Data_008_6561
    dw Data_008_6569
    dw Data_008_6573
    dw Data_008_657D
    dw Data_008_6584
    dw Data_008_658C
    dw Data_008_6594
    dw Data_008_659D
    dw Data_008_65A4
    dw Data_008_65AC
    dw Data_008_65B6
    dw Data_008_65BF
    dw Data_008_65C3
    dw Data_008_65CB
    dw Data_008_65D3
    dw Data_008_65DB
    dw Data_008_65E5
    dw Data_008_65EF
    dw Data_008_65F9
    dw Data_008_65FF
    dw Data_008_6607
    dw Data_008_660D
    dw Data_008_6613
    dw Data_008_6619
    dw Data_008_661F
    dw Data_008_6625
    dw Data_008_662E
    dw Data_008_6637
    dw Data_008_6640
    dw Data_008_664A
    dw Data_008_6653
    dw Data_008_665B
    dw Data_008_665C
    dw Data_008_6666
    dw Data_008_666F
    dw Data_008_6675
    dw Data_008_667E
    dw Data_008_6688
    dw Data_008_6690
    dw Data_008_669A
    dw Data_008_66A4
    dw Data_008_66A9
    dw Data_008_66B1
    dw Data_008_66B9
    dw Data_008_66C1
    dw Data_008_66CA
    dw Data_008_66D2
    dw Data_008_66D2
    dw Data_008_66DC
    dw Data_008_66E4
    dw Data_008_66EE
    dw Data_008_66F8
    dw Data_008_6700
    dw Data_008_670A
    dw Data_008_6714
    dw Data_008_671E
    dw Data_008_6728
    dw Data_008_672D
    dw Data_008_6735
    dw Data_008_673C
    dw Data_008_6742
    dw Data_008_674C
    dw Data_008_6756
    dw Data_008_6760
    dw Data_008_6769
    dw Data_008_6773
    dw Data_008_677C
    dw Data_008_6786
    dw Data_008_678E
    dw Data_008_678E
    dw Data_008_678E
    dw Data_008_678E
    dw Data_008_678E
    dw Data_008_678E
    dw Data_008_6793
    dw Data_008_6799
    dw Data_008_67A1
    dw Data_008_67A6
    dw Data_008_67AC
    dw Data_008_67B3
    dw Data_008_67BB
    dw Data_008_67C2
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA
    dw Data_008_67CA

; 112 strings: 'Restores HP of one monster', ... (named from its contents; E-0026)
StringTable_ItemDescriptions:: ; heuristic: target of a monotone pointer table; C0
Data_008_47F6:: ; address name
    dw Data_008_67CB
    dw Data_008_67CB
    dw Data_008_67F0
    dw Data_008_6815
    dw Data_008_6838
    dw Data_008_685D
    dw Data_008_687F
    dw Data_008_689D
    dw Data_008_68AE
    dw Data_008_68CD
    dw Data_008_68E9
    dw Data_008_690B
    dw Data_008_6931
    dw Data_008_6949
    dw Data_008_695A
    dw Data_008_696B
    dw Data_008_697C
    dw Data_008_698D
    dw Data_008_69A2
    dw Data_008_69B7
    dw Data_008_69D0
    dw Data_008_69F0
    dw Data_008_6A0E
    dw Data_008_6A29
    dw Data_008_6A4B
    dw Data_008_6A6B
    dw Data_008_6A89
    dw Data_008_6AA6
    dw Data_008_6ABC
    dw Data_008_6AD6
    dw Data_008_6AFA
    dw Data_008_6B15
    dw Data_008_6B3A
    dw Data_008_6B5C
    dw Data_008_6B7D
    dw Data_008_6B99
    dw Data_008_6BB8
    dw Data_008_6BDB
    dw Data_008_6BFC
    dw Data_008_6C1E
    dw Data_008_6C3F
    dw Data_008_6C63
    dw Data_008_6C80
    dw Data_008_6C9D
    dw Data_008_6CBC
    dw Data_008_6CDE
    dw Data_008_6D02
    dw Data_008_6D19
    dw Data_008_6D19
    dw Data_008_6D2E
    dw Data_008_6D52
    dw Data_008_6D75
    dw Data_008_6D92
    dw Data_008_6DB4
    dw Data_008_6DD4
    dw Data_008_6DF9
    dw Data_008_6E14
    dw Data_008_6E30
    dw Data_008_6E54
    dw Data_008_6E78
    dw Data_008_6E9D
    dw Data_008_6EBE
    dw Data_008_6ED5
    dw Data_008_6ED5
    dw Data_008_6EE0
    dw Data_008_6EF6
    dw Data_008_6F0C
    dw Data_008_6F22
    dw Data_008_6F38
    dw Data_008_6F4A
    dw Data_008_6F5C
    dw Data_008_6F6E
    dw Data_008_6F80
    dw Data_008_6F92
    dw Data_008_6FA4
    dw Data_008_6FB6
    dw Data_008_6FC9
    dw Data_008_6FED
    dw Data_008_7010
    dw Data_008_7033
    dw Data_008_704F
    dw Data_008_7071
    dw Data_008_7094
    dw Data_008_70B7
    dw Data_008_70C8
    dw Data_008_70C8
    dw Data_008_70C8
    dw Data_008_70C8
    dw Data_008_70C8
    dw Data_008_70C8
    dw Data_008_70D3
    dw Data_008_70F3
    dw Data_008_7113
    dw Data_008_712A
    dw Data_008_7141
    dw Data_008_7162
    dw Data_008_7183
    dw Data_008_71A4
    dw Data_008_71C5
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D0
    dw Data_008_71D2

; 27 strings: 'Hotblood', 'Eager', 'Smug', 'Earnest', 'Pushy', ... (named from its contents; E-0026)
StringTable_PersonalityNames:: ; heuristic: target of a monotone pointer table; C0
Data_008_48D6:: ; address name
    dw Data_008_71F7
    dw Data_008_7200
    dw Data_008_7206
    dw Data_008_720B
    dw Data_008_7213
    dw Data_008_7219
    dw Data_008_7220
    dw Data_008_7229
    dw Data_008_7230
    dw Data_008_723A
    dw Data_008_7244
    dw Data_008_724C
    dw Data_008_7254
    dw Data_008_725B
    dw Data_008_7264
    dw Data_008_726D
    dw Data_008_7272
    dw Data_008_7279
    dw Data_008_7281
    dw Data_008_7287
    dw Data_008_728B
    dw Data_008_7291
    dw Data_008_7295
    dw Data_008_729D
    dw Data_008_72A4
    dw Data_008_72AD
    dw Data_008_72B6

; 15 strings: 'No items', 'Toss this away?', ... (named from its contents; E-0026)
StringTable_ItemMenuMessages:: ; heuristic: target of a monotone pointer table; C0
Data_008_490C:: ; address name
    dw Data_008_72BB
    dw Data_008_72C4
    dw Data_008_72D4
    dw Data_008_72EC
    dw Data_008_7303
    dw Data_008_7319
    dw Data_008_731C
    dw Data_008_7346
    dw Data_008_7357
    dw Data_008_7370
    dw Data_008_7389
    dw Data_008_7395
    dw Data_008_73AA
    dw Data_008_73CA
    dw Data_008_73DF

Data_008_492A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ABCDEF", $F0

Data_008_493B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  DEBUG MODE        SELECT       1", $A3, "GOTO PROGRAM  2", $A3, "EDIT "
    db "         3", $A3, "AUTOMAP CHECK 4", $A3, "GRAFHICS      5", $A3, "SOUNDS     "
    db "   6", $A3, "BATTLE        7", $A3, "HAIGOU        8", $A3, "STAFF ROLL    9", $A3
    db "TOKUGI CHECK  A", $A3, "ENEMY TBL CHK B", $A3, "MESSAGE CHK  ?  RETURN  "
    db "?  ", $F0

Data_008_4A1A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ? EDIT ?                      WORLD", $A3, "          MAP X", $A3, "  "
    db "            Y", $A3, "          POS X", $A3, "              Y", $A3, "        "
    db "  NOT DATA"
    db $9F, $F0

Data_008_4A94:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MONSTER BGSD CHARA     ", $F0

Data_008_4AAC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ? AUTOMAP ?                   KEY  ", $A3, "          KEYID", $A3, "  "
    db "        LEVEL", $A3, "          POS X", $A3, "          POS Y", $A3, "        "
    db "  NOT DATA"
    db $9F, $F0

Data_008_4B26:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ? SOUND ?", $F1
    db $F1
    db "  BGM", $F1
    db "   SE", $F0

Data_008_4B3F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "? GOTOPRG ?", $F1
    db $F1
    db $F1
    db " PRGNO1", $F1
    db " PRGNO2", $F1
    db " PRGNO3", $F0

Data_008_4B65:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No more", $A4, $F0

Data_008_4B6E:: ; heuristic: target of a monotone pointer table; C0
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

Data_008_4BBD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MonsterFarm", $F0

Data_008_4BC9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatLog", $F0

Data_008_4BD2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Main Street", $F0

Data_008_4BDE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door", $F0

Data_008_4BE9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reception", $F0

Data_008_4BF3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log's Navel", $F0

Data_008_4BFE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Home", $F0

Data_008_4C03:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stable", $F0

Data_008_4C0A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Vault", $F0

Data_008_4C10:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Key Shop", $F0

Data_008_4C19:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Evaluator", $F0

Data_008_4C23:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Residences", $F0

Data_008_4C2E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starry "
    db $59, $F0

Data_008_4C37:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Family Rm.", $F0

Data_008_4C42:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Guy's Rm.", $F0

Data_008_4C4B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lady's Rm.", $F0

Data_008_4C55:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Library", $F0

Data_008_4C5D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Girl's Rm.", $F0

Data_008_4C67:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Christener", $F0

Data_008_4C72:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Background", $F0

Data_008_4C7D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Old man's", $F0

Data_008_4C86:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Medal man", $F0

Data_008_4C90:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tavern", $F0

Data_008_4C97:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Arena", $F0

Data_008_4C9D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "GreatLog "
    db $58, $F0

Data_008_4CA8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Treetop", $F0

Data_008_4CB0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log's nut", $F0

Data_008_4CB9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Log's view", $F0

Data_008_4CC3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Deck", $F0

Data_008_4CC8:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $F0

Data_008_4CCB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Desert "
    db $5C, $F0

Data_008_4CD4:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $2F, $2E, $24, $90, $57, $F0

Data_008_4CDC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Kalka inn", $F0

Data_008_4CE6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Asiya inn", $F0

Data_008_4CF0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Asiya "
    db $57, $F0

Data_008_4CF8:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $36, $2C, $3C, $24, $90, $58, $F0

Data_008_4D00:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Desert King", $F0

Data_008_4D0C:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $F0

Data_008_4D0F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hideout", $F0

Data_008_4D17:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door "
    db $59, $F0

Data_008_4D24:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $31, $24, $2F, $10, $24, $37, $28, $F0

Data_008_4D2E:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $31, $24, $2F, $F0

Data_008_4D34:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $37, $90, $3C, $28, $37, $99, $F0

Data_008_4D3D:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $31, $2A, $28, $32, $31, $F1

Data_008_4D45:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $28, $24, $36, $38, $35, $3C, $F1

Data_008_4D4E:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $35, $24, $2A, $28, $90, $15, $24, $2E, $28, $F1

Data_008_4D5A:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $28, $35, $90, $5C, $F0

Data_008_4D62:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $2F, $27, $90, $57, $F0

Data_008_4D69:: ; heuristic: target of a monotone pointer table; C0
    db $19, $37, $B5, $1B, $2C, $37, $3D, $90, $57, $F0

Data_008_4D73:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pt.Ritz pub", $F0

Data_008_4D7F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pt.Ritz inn", $F0

Data_008_4D8B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cape "
    db $5A, $F0

Data_008_4D92:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship ramp", $F0

Data_008_4D9C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship 1F", $F0

Data_008_4DA4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Volcano"
    db $5A, $01, $0F, $F0

Data_008_4DAF:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $32, $2F, $26, $24, $31, $32, $5A, $0B, $01, $0F, $F0

Data_008_4DBB:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $32, $2F, $26, $24, $31, $32, $5A, $0B, $02, $0F, $F0

Data_008_4DC7:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $32, $37, $90, $39, $24, $38, $2F, $37, $F0

Data_008_4DD2:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $2F, $32, $31, $24, $90, $57, $F0

Data_008_4DDB:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $2F, $32, $31, $24, $90, $2C, $31, $31, $F0

Data_008_4DE6:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $2A, $2B, $37, $2B, $32, $38, $36, $28, $F0

Data_008_4DF1:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $2A, $2B, $37, $2B, $32, $38, $36, $28, $F0

Data_008_4DFC:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $31, $31, $24, $26, $2F, $28, $F0

Data_008_4E05:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $35, $30, $24, $2C, $27, $90, $5C, $F0

Data_008_4E0F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship 2F", $F0

Data_008_4E17:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Ship deck", $F0

Data_008_4E21:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Capt's qtr.", $F0

Data_008_4E2C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door "
    db $59, $F0

Data_008_4E39:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $F0

Data_008_4E3C:: ; heuristic: target of a monotone pointer table; C0
    db $12, $26, $28, $90, $5C, $F0

Data_008_4E42:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $35, $2C, $31, $2A, $F0

Data_008_4E49:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $35, $27, $28, $31, $90, $57, $F0

Data_008_4E52:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $35, $27, $28, $31, $90, $2C, $31, $31, $F0

Data_008_4E5D:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $35, $27, $28, $31, $90, $58, $F0

Data_008_4E66:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Norden jail", $F0

Data_008_4E72:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "N tunnel", $F0

Data_008_4E7B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Nofor "
    db $57, $F0

Data_008_4E83:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Nofor pub", $F0

Data_008_4E8D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Nofor inn", $F0

Data_008_4E97:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Border mine", $F0

Data_008_4EA3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine", $F0

Data_008_4EA8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine rm.", $F0

Data_008_4EB1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine rm.", $F0

Data_008_4EBA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mine rm.", $F0

Data_008_4EC3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gold mine", $F0

Data_008_4ECD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Weston "
    db $57, $F0

Data_008_4ED6:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $36, $37, $32, $31, $90, $2C, $31, $31, $F0

Data_008_4EE1:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $36, $37, $24, $31, $2C, $24, $90, $58, $F0

Data_008_4EEC:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $36, $37, $24, $31, $2C, $24, $90, $58, $F0

Data_008_4EF7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Yuna's rm.", $F0

Data_008_4F01:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "S forest", $F0

Data_008_4F0A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Estria  "
    db $58, $F0

Data_008_4F14:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $36, $37, $35, $2C, $24, $90, $2C, $31, $31, $F0

Data_008_4F1F:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $36, $37, $35, $2C, $24, $90, $58, $F0

Data_008_4F28:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Queen's rm.", $F0

Data_008_4F33:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "N mountain", $F0

Data_008_4F3E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lake "
    db $5D, $90, $01, $0F, $F0

Data_008_4F48:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $2E, $28, $90, $5D, $90, $02, $0F, $F0

Data_008_4F52:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $2E, $28, $90, $5D, $90, $03, $0F, $F0

Data_008_4F5C:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $2E, $28, $90, $5D, $90, $04, $0F, $F0

Data_008_4F66:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $2E, $28, $90, $5D, $90, $05, $0F, $F0

Data_008_4F70:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_4F7D:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $F0

Data_008_4F80:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $32, $24, $37, $90, $5C, $F0

Data_008_4F88:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2B, $38, $31, $37, $90, $57, $F0

Data_008_4F90:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2B, $38, $31, $37, $90, $2C, $31, $31, $F0

Data_008_4F9A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2A, $28, $90, $5D, $90, $01, $0F, $F0

Data_008_4FA4:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2A, $28, $90, $5D, $90, $02, $0F, $F0

Data_008_4FAE:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2A, $28, $90, $5D, $90, $03, $0F, $F0

Data_008_4FB8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2A, $28, $90, $5D, $90, $04, $0F, $F0

Data_008_4FC2:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $33, $28, $90, $25, $35, $2C, $27, $2A, $28, $F0

Data_008_4FCE:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $2C, $90, $57, $F0

Data_008_4FD4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pei inn", $F0

Data_008_4FDC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "W mountain", $F0

Data_008_4FE7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "W tunnel", $F0

Data_008_4FF0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano "
    db $57, $F0

Data_008_4FF9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano inn", $F0

Data_008_5004:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano pub", $F0

Data_008_500F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hitano "
    db $58, $F0

Data_008_5018:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $33, $28, $90, $25, $35, $2C, $27, $2A, $28, $F0

Data_008_5024:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $2F, $2F, $90, $5A, $F0

Data_008_502C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $2F, $2F, $90, $5A, $90, $0B, $01, $0F, $F0

Data_008_5038:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $2F, $2F, $90, $5A, $90, $0B, $02, $0F, $F0

Data_008_5044:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $36, $36, $90, $1B, $30, $B5, $F0

Data_008_504D:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $90, $5D, $90, $01, $0F, $F0

Data_008_5057:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $90, $5D, $90, $02, $0F, $F0

Data_008_5061:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $90, $5D, $90, $03, $0F, $F0

Data_008_506B:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $90, $5D, $90, $04, $0F, $F0

Data_008_5075:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2A, $28, $90, $5D, $F0

Data_008_507C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $27, $90, $58, $F0

Data_008_5083:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $37, $2B, $28, $27, $35, $24, $2F, $F0

Data_008_508D:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $35, $35, $2C, $27, $32, $35, $F0

Data_008_5096:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $35, $2A, $38, $28, $F0

Data_008_509D:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $28, $30, $28, $37, $28, $35, $3C, $F0

Data_008_50A6:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $36, $2C, $26, $90, $35, $30, $B5, $F0

Data_008_50B0:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $35, $35, $2C, $27, $32, $35, $F0

Data_008_50B9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $27, $90, $35, $30, $B5, $F0

Data_008_50C2:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $35, $37, $2B, $90, $59, $F0

Data_008_50CA:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $90, $58, $F0

Data_008_50D2:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $01, $0F, $F0

Data_008_50DD:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $0B, $01, $0F, $F0

Data_008_50E9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $0B, $02, $0F, $F0

Data_008_50F5:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $0B, $03, $0F, $F0

Data_008_5101:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $0B, $04, $0F, $F0

Data_008_510D:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $90, $58, $90, $0B, $05, $0F, $F0

Data_008_5119:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $90, $58
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " B6F", $F0

Data_008_5125:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Demon hall", $F0

Data_008_5130:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $F0

Data_008_5133:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door "
    db $59, $F0

Data_008_5140:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $F0

Data_008_5143:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $30, $25, $32, $90, $5C, $F0

Data_008_514B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Stairway", $F0

Data_008_5154:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Darck Manor", $F0

Data_008_5160:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gallery", $F0

Data_008_5168:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door "
    db $59, $F0

Data_008_5175:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $F0

Data_008_5178:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2F, $39, $28, $31, $90, $5C, $F0

Data_008_5180:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2F, $39, $28, $31, $90, $57, $F0

Data_008_5188:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "W forest", $F0

Data_008_5191:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lookout", $F0

Data_008_5199:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summit", $F0

Data_008_51A0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Mt. base", $F0

Data_008_51A9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "PlatinumMt.", $F0

Data_008_51B5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Magic Door "
    db $59, $F0

Data_008_51C2:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $31, $28, $2F, $3C, $90, $5C, $F0

Data_008_51CB:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $35, $24, $2F, $90, $15, $24, $25, $F0

Data_008_51D5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_51E2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lab B1F", $F0

Data_008_51EA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lab B2F", $F0

Data_008_51F2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lab B3F", $F0

Data_008_51FA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Barrel rm.", $F0

Data_008_5205:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $F0

Data_008_5208:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Traveler "
    db $5C, $F0

Data_008_5213:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $24, $2A, $28, $31, $90, $57, $F0

Data_008_521C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Travel hut", $F0

Data_008_5227:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "N forest", $F0

Data_008_5230:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Inn", $F0

Data_008_5234:: ; heuristic: target of a monotone pointer table; C0
    db $5D, $90, $36, $38, $30, $30, $2C, $37, $F0

Data_008_523D:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $27, $90, $5D, $90, $01, $0F, $F0

Data_008_5246:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $27, $90, $5D, $90, $02, $0F, $F0

Data_008_524F:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $27, $90, $5D, $90, $03, $0F, $F0

Data_008_5258:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $27, $90, $5D, $90, $04, $0F, $F0

Data_008_5261:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $27, $90, $5D, $90, $05, $0F, $F0

Data_008_526A:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $27, $90, $5D, $90, $06, $0F, $F0

Data_008_5273:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $27, $90, $5D, $90, $07, $0F, $F0

Data_008_527C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_5289:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $F0

Data_008_528C:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $3A, $28, $35, $90, $5C, $F0

Data_008_5294:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $01, $0F, $F0

Data_008_529F:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $02, $0F, $F0

Data_008_52AA:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $03, $0F, $F0

Data_008_52B5:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $04, $0F, $F0

Data_008_52C0:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $05, $0F, $F0

Data_008_52CB:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $06, $0F, $F0

Data_008_52D6:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $3A, $28, $35, $90, $5D, $90, $07, $0F, $F0

Data_008_52E1:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_52EE:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5C, $F0

Data_008_52F7:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $01, $0F, $F0

Data_008_5303:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $02, $0F, $F0

Data_008_530F:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $03, $0F, $F0

Data_008_531B:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $04, $0F, $F0

Data_008_5327:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $05, $0F, $F0

Data_008_5333:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $06, $0F, $F0

Data_008_533F:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $29, $29, $2F, $28, $90, $5D, $90, $07, $0F, $F0

Data_008_534B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_5358:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $38, $2F, $90, $5C, $F0

Data_008_535F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $01, $0F, $F0

Data_008_5369:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $02, $0F, $F0

Data_008_5373:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $03, $0F, $F0

Data_008_537D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $04, $0F, $F0

Data_008_5387:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $05, $0F, $F0

Data_008_5391:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $06, $0F, $F0

Data_008_539B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $38, $2F, $90, $5D, $90, $07, $0F, $F0

Data_008_53A5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $90, $0D, $32, $32, $35, $90, $59, $F0

Data_008_53B2:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $F0

Data_008_53B5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_008_53BB:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $32, $31, $F0

Data_008_53C2:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $F0

Data_008_53C8:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $35, $27, $F0

Data_008_53CD:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $24, $31, $37, $F0

Data_008_53D3:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $2A, $F0

Data_008_53D7:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $F0

Data_008_53DD:: ; heuristic: target of a monotone pointer table; C0
    db $23, $32, $30, $25, $2C, $28, $F0

Data_008_53E4:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $37, $28, $35, $2C, $24, $2F, $F0

Data_008_53ED:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $28, $35, $F0

Data_008_53F3:: ; heuristic: target of a monotone pointer table; C0
    db $98, $98, $98, $98, $F0

Data_008_53F8:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_008_53F9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2E, $1C, $2F, $2C, $30, $28, $F0

Data_008_5403:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $32, $37, $1C, $2F, $2C, $30, $28, $F0

Data_008_540D:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_008_5417:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $28, $28, $1C, $2F, $2C, $30, $28, $F0

Data_008_5421:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $2C, $2F, $3C, $F0

Data_008_5428:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $17, $2C, $37, $28, $F0

Data_008_5432:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $25, $25, $2F, $28, $F0

Data_008_5439:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $3B, $1C, $2F, $2C, $30, $28, $F0

Data_008_5442:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $24, $35, $2F, $10, $28, $2F, $F0

Data_008_544B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_008_5451:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $2F, $28, $35, $F0

Data_008_5458:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_008_5462:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $26, $2E, $1C, $2F, $2C, $30, $28, $F0

Data_008_546C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $0B, $32, $35, $2A, $F0

Data_008_5476:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $24, $25, $25, $2C, $37, $F0

Data_008_547E:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_008_5488:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $3C, $F0

Data_008_548F:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $25, $25, $2F, $28, $F0

Data_008_5498:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $32, $37, $14, $2C, $31, $2A, $F0

Data_008_54A1:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $32, $33, $2C, $26, $10, $28, $2F, $F0

Data_008_54AB:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $30, $28, $1C, $2F, $2C, $30, $28, $F0

Data_008_54B5:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $2F, $32, $1C, $2F, $2C, $30, $28, $F0

Data_008_54BF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $14, $2C, $31, $2A, $F0

Data_008_54C9:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $1C, $2F, $2C, $30, $28, $F0

Data_008_54D3:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $24, $31, $1C, $2F, $2C, $30, $28, $F0

Data_008_54DD:: ; heuristic: target of a monotone pointer table; C0
    db $20, $32, $31, $27, $28, $35, $0E, $2A, $2A, $F0

Data_008_54E7:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $37, $26, $2B, $F0

Data_008_54ED:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_54EF:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $32, $31, $14, $2C, $27, $F0

Data_008_54F9:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $35, $37, $35, $24, $2A, $32, $31, $F0

Data_008_5503:: ; heuristic: target of a monotone pointer table; C0
    db $19, $37, $28, $35, $24, $31, $32, $27, $F0

Data_008_550C:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $36, $2A, $32, $31, $F0

Data_008_5513:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $2C, $35, $3C, $0D, $35, $24, $2E, $F0

Data_008_551D:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $3D, $24, $35, $27, $16, $24, $31, $F0

Data_008_5527:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $2C, $36, $32, $31, $2A, $32, $31, $F0

Data_008_5531:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $32, $35, $27, $2A, $32, $31, $F0

Data_008_553A:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $3C, $2A, $32, $31, $F0

Data_008_5541:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $32, $31, $F0

Data_008_5548:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $31, $2C, $0D, $35, $24, $2E, $F0

Data_008_5551:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0D, $35, $24, $2A, $32, $31, $F0

Data_008_555B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $3C, $25, $38, $35, $31, $F0

Data_008_5563:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $30, $28, $2F, $2A, $32, $31, $F0

Data_008_556D:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $3D, $24, $35, $27, $0F, $2F, $3C, $F0

Data_008_5577:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $27, $35, $28, $24, $2F, $F0

Data_008_557F:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $0C, $32, $25, $35, $24, $F0

Data_008_5589:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $30, $33, $2C, $35, $38, $36, $F0

Data_008_5592:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $2E, $28, $0B, $24, $37, $F0

Data_008_559B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $2C, $2E, $28, $35, $32, $38, $36, $F0

Data_008_55A5:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $24, $37, $0D, $35, $24, $2E, $F0

Data_008_55AF:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $36, $37, $33, $28, $31, $37, $F0

Data_008_55B9:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $2A, $1C, $31, $24, $2E, $28, $F0

Data_008_55C3:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $24, $37, $32, $2F, $F0

Data_008_55CA:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $32, $26, $2B, $2C, $F0

Data_008_55D1:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $37, $37, $2F, $28, $1B, $28, $3B, $F0

Data_008_55DB:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $0D, $35, $24, $2A, $32, $31, $F0

Data_008_55E5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $35, $33, $28, $31, $37, $2C, $24, $F0

Data_008_55EF:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $39, $2C, $31, $28, $2A, $32, $31, $F0

Data_008_55F9:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $2F, $2C, $2A, $32, $31, $F0

Data_008_5601:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $2A, $24, $0D, $35, $24, $26, $32, $F0

Data_008_560B:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_560D:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $31, $2A, $38, $28, $2F, $2F, $24, $F0

Data_008_5617:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $30, $2C, $35, $24, $2D, $F0

Data_008_561F:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $37, $0F, $2F, $3C, $F0

Data_008_5626:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $2F, $2F, $32, $3A, $1B, $24, $37, $F0

Data_008_5630:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $26, $26, $28, $35, $F0

Data_008_5637:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $2F, $33, $0B, $28, $24, $36, $37, $F0

Data_008_5641:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $2F, $35, $32, $32, $F0

Data_008_564A:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $0B, $28, $24, $36, $37, $F0

Data_008_5654:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $39, $28, $35, $31, $F0

Data_008_565C:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $37, $25, $28, $24, $35, $F0

Data_008_5664:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $33, $28, $35, $1D, $28, $31, $F0

Data_008_566D:: ; heuristic: target of a monotone pointer table; C0
    db $12, $35, $32, $31, $1D, $38, $35, $37, $F0

Data_008_5676:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $30, $30, $32, $31, $2D, $24, $F0

Data_008_567F:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $30, $30, $28, $35, $16, $24, $31, $F0

Data_008_5689:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $2C, $3D, $3D, $2F, $3C, $F0

Data_008_5691:: ; heuristic: target of a monotone pointer table; C0
    db $22, $28, $37, $2C, $F0

Data_008_5696:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $35, $32, $3A, $0D, $32, $2A, $F0

Data_008_569F:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $26, $37, $32, $14, $2C, $31, $2A, $F0

Data_008_56A9:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $17, $2C, $37, $28, $F0

Data_008_56B3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $10, $32, $33, $2B, $28, $35, $F0

Data_008_56BD:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $2C, $35, $3C, $1B, $24, $37, $F0

Data_008_56C6:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $31, $2C, $26, $32, $35, $31, $F0

Data_008_56CE:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $24, $37, $28, $2A, $32, $31, $F0

Data_008_56D7:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $2F, $27, $0A, $33, $28, $F0

Data_008_56DF:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $38, $30, $33, $28, $37, $28, $35, $F0

Data_008_56E9:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $15, $28, $32, $F0

Data_008_56F1:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $11, $32, $35, $31, $F0

Data_008_56FA:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0C, $24, $37, $F0

Data_008_5701:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $2A, $0E, $3C, $28, $F0

Data_008_5708:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $35, $24, $2A, $32, $F0

Data_008_570F:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $37, $16, $24, $2A, $28, $F0

Data_008_5717:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $30, $25, $2C, $35, $24, $F0

Data_008_571F:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_5721:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $26, $2E, $3C, $F0

Data_008_5727:: ; heuristic: target of a monotone pointer table; C0
    db $20, $3C, $39, $28, $35, $31, $F0

Data_008_572E:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $2F, $2F, $0B, $2C, $35, $27, $F0

Data_008_5737:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $32, $35, $24, $2D, $24, $3C, $F0

Data_008_5740:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $26, $2E, $14, $2C, $37, $28, $F0

Data_008_5749:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $19, $28, $26, $2E, $28, $35, $F0

Data_008_5753:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $1B, $24, $39, $28, $31, $F0

Data_008_575C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $36, $37, $3C, $20, $2C, $31, $2A, $F0

Data_008_5766:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $34, $38, $24, $11, $24, $3A, $2E, $F0

Data_008_576F:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $2E, $3C, $F0

Data_008_5776:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $37, $28, $11, $24, $3A, $2E, $F0

Data_008_577F:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $2A, $1B, $32, $32, $36, $37, $F0

Data_008_5788:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $38, $25, $0B, $2C, $35, $27, $F0

Data_008_5791:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $31, $27, $18, $3A, $2F, $F0

Data_008_5799:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $10, $32, $32, $36, $28, $F0

Data_008_57A2:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0C, $32, $31, $27, $32, $35, $F0

Data_008_57AC:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $30, $3C, $38, $F0

Data_008_57B1:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $2C, $3D, $3D, $24, $35, $27, $3C, $F0

Data_008_57BB:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2B, $32, $28, $31, $2C, $3B, $F0

Data_008_57C3:: ; heuristic: target of a monotone pointer table; C0
    db $23, $24, $33, $0B, $2C, $35, $27, $F0

Data_008_57CB:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $35, $38, $27, $2C, $24, $31, $F0

Data_008_57D4:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $33, $0B, $2C, $35, $27, $F0

Data_008_57DD:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $38, $31, $2E, $3C, $0B, $2C, $35, $27, $F0

Data_008_57E7:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $31, $11, $24, $3A, $2E, $F0

Data_008_57F0:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3D, $38, $35, $2C, $2F, $28, $F0

Data_008_57F8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $31, $37, $24, $2E, $F0

Data_008_5800:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $24, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_008_580A:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_580C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $19, $2F, $24, $31, $37, $F0

Data_008_5815:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $20, $28, $28, $27, $F0

Data_008_581E:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $32, $35, $24, $16, $24, $31, $F0

Data_008_5827:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $2A, $1D, $35, $28, $28, $F0

Data_008_5830:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $26, $37, $2C, $0B, $24, $2F, $2F, $F0

Data_008_583A:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $2F, $33, $33, $2F, $28, $F0

Data_008_5842:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $24, $27, $36, $37, $32, $32, $2F, $F0

Data_008_584C:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $30, $25, $28, $35, $20, $28, $28, $27, $F0

Data_008_5856:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $38, $35, $33, $28, $35, $32, $31, $F0

Data_008_5860:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $38, $25, $36, $38, $26, $2E, $F0

Data_008_5869:: ; heuristic: target of a monotone pointer table; C0
    db $18, $31, $2C, $32, $31, $32, $F0

Data_008_5870:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $1F, $28, $2A, $2C, $F0

Data_008_587A:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $28, $28, $0B, $32, $3C, $F0

Data_008_5882:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $39, $2C, $33, $2C, $31, $28, $F0

Data_008_588B:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $26, $28, $1D, $35, $28, $28, $F0

Data_008_5894:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $35, $25, $16, $24, $31, $F0

Data_008_589C:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $31, $16, $24, $31, $F0

Data_008_58A4:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $1C, $28, $28, $27, $F0

Data_008_58AD:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $31, $0E, $24, $37, $28, $35, $F0

Data_008_58B6:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $33, $33, $28, $35, $F0

Data_008_58BE:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2B, $32, $36, $1D, $35, $28, $28, $F0

Data_008_58C7:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $36, $28, $39, $2C, $31, $28, $F0

Data_008_58D0:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2A, $27, $35, $24, $26, $2C, $2F, $F0

Data_008_58D9:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $38, $25, $32, $38, $F0

Data_008_58E1:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $24, $25, $32, $38, $F0

Data_008_58E9:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2A, $2A, $33, $2F, $24, $37, $32, $31, $F0

Data_008_58F3:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $32, $11, $28, $35, $32, $F0

Data_008_58FB:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_58FD:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $24, $31, $37, $1C, $2F, $38, $2A, $F0

Data_008_5907:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $37, $24, $33, $2C, $2F, $24, $F0

Data_008_5910:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $33, $2B, $28, $26, $24, $27, $24, $F0

Data_008_591A:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $37, $37, $28, $35, $29, $2F, $3C, $F0

Data_008_5924:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $28, $27, $0B, $38, $2A, $F0

Data_008_592C:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $24, $31, $37, $20, $32, $35, $30, $F0

Data_008_5936:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $33, $36, $3C, $F0

Data_008_593C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $2A, $0B, $38, $2A, $F0

Data_008_5944:: ; heuristic: target of a monotone pointer table; C0
    db $19, $3C, $38, $35, $32, $F0

Data_008_594A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $3C, $0A, $31, $37, $F0

Data_008_5952:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $11, $32, $33, $33, $28, $35, $F0

Data_008_595B:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2C, $2F, $0E, $24, $37, $28, $35, $F0

Data_008_5965:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $32, $35, $19, $28, $27, $28, $F0

Data_008_596F:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3C, $28, $27, $28, $35, $F0

Data_008_5976:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $24, $31, $37, $16, $32, $37, $2B, $F0

Data_008_5980:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $32, $2F, $2F, $F0

Data_008_5986:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $3C, $0C, $35, $24, $25, $F0

Data_008_598F:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $11, $32, $35, $31, $28, $37, $F0

Data_008_5999:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $2F, $3D, $28, $25, $38, $25, $F0

Data_008_59A2:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $16, $24, $31, $37, $2C, $36, $F0

Data_008_59AC:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $31, $0B, $28, $28, $37, $F0

Data_008_59B5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $26, $2E, $2F, $28, $35, $F0

Data_008_59BD:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $32, $35, $33, $2C, $32, $31, $F0

Data_008_59C7:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $2A, $36, $37, $28, $35, $F0

Data_008_59CF:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $24, $35, $24, $26, $2B, $F0

Data_008_59D9:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $2F, $37, $2C, $0E, $3C, $28, $36, $F0

Data_008_59E3:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_59E5:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $3B, $3C, $F0

Data_008_59EA:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $27, $38, $36, $24, $0E, $3C, $28, $F0

Data_008_59F4:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_008_59FC:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $2C, $37, $28, $F0

Data_008_5A05:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $0E, $3C, $28, $F0

Data_008_5A0D:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3C, $28, $0B, $24, $2F, $2F, $F0

Data_008_5A15:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $1B, $2C, $27, $28, $35, $F0

Data_008_5A1F:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $0B, $28, $24, $36, $37, $F0

Data_008_5A29:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $25, $25, $2F, $28, $30, $32, $31, $F0

Data_008_5A33:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0E, $3C, $28, $0C, $2F, $32, $3A, $31, $F0

Data_008_5A3D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $30, $2F, $2C, $31, $F0

Data_008_5A45:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $26, $0D, $28, $30, $32, $31, $F0

Data_008_5A4E:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $32, $31, $28, $3B, $F0

Data_008_5A55:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $24, $37, $11, $32, $35, $31, $F0

Data_008_5A5E:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $26, $F0

Data_008_5A62:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2A, $35, $28, $F0

Data_008_5A67:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $37, $28, $10, $38, $24, $35, $27, $F0

Data_008_5A71:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $33, $0C, $2F, $32, $3A, $31, $F0

Data_008_5A7B:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $36, $36, $1D, $35, $32, $2F, $2F, $F0

Data_008_5A85:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $31, $27, $24, $2F, $F0

Data_008_5A8D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2E, $38, $25, $24, $35, $F0

Data_008_5A94:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $14, $31, $2C, $2A, $2B, $37, $F0

Data_008_5A9E:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $20, $28, $2F, $2F, $F0

Data_008_5AA7:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $2A, $24, $31, $37, $28, $36, $F0

Data_008_5AB0:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $28, $31, $37, $24, $36, $24, $38, $35, $F0

Data_008_5ABA:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $0A, $35, $30, $32, $35, $F0

Data_008_5AC4:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $30, $2C, $35, $38, $36, $F0

Data_008_5ACC:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $35, $35, $24, $31, $F0

Data_008_5AD3:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2C, $37, $24, $31, $2C, $36, $F0

Data_008_5ADB:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $30, $33, $10, $28, $31, $2C, $28, $F0

Data_008_5AE5:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_5AE7:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $32, $32, $2E, $3C, $F0

Data_008_5AEE:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $2F, $2A, $32, $31, $F0

Data_008_5AF7:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $37, $35, $28, $19, $38, $33, $F0

Data_008_5B00:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $37, $1B, $24, $39, $28, $31, $F0

Data_008_5B09:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $30, $30, $3C, $F0

Data_008_5B0F:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $0C, $35, $24, $25, $F0

Data_008_5B18:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $27, $17, $2C, $37, $28, $F0

Data_008_5B21:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_008_5B28:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $33, $28, $31, $37, $F0

Data_008_5B31:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $2E, $F0

Data_008_5B36:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $27, $35, $32, $31, $F0

Data_008_5B3D:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $37, $28, $20, $2B, $2C, $33, $F0

Data_008_5B46:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $16, $28, $35, $2A, $28, $F0

Data_008_5B50:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $24, $33, $28, $35, $F0

Data_008_5B57:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $39, $28, $35, $3D, $32, $31, $F0

Data_008_5B60:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $3B, $0F, $2C, $35, $28, $F0

Data_008_5B68:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $33, $37, $0D, $28, $24, $27, $F0

Data_008_5B71:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $27, $17, $32, $25, $2F, $28, $F0

Data_008_5B7B:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $37, $28, $14, $2C, $31, $2A, $F0

Data_008_5B85:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $31, $28, $1C, $2F, $24, $39, $28, $F0

Data_008_5B8F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $28, $2F, $28, $37, $32, $35, $F0

Data_008_5B98:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $35, $39, $24, $31, $37, $F0

Data_008_5BA0:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $3D, $24, $30, $24, $31, $38, $36, $F0

Data_008_5BAA:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_008_5BB2:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $1C, $33, $2C, $35, $2C, $37, $F0

Data_008_5BBC:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $30, $19, $32, $30, $0B, $32, $30, $F0

Data_008_5BC6:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $37, $28, $35, $2C, $26, $2B, $F0

Data_008_5BCF:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_5BD1:: ; heuristic: target of a monotone pointer table; C0
    db $13, $28, $3A, $28, $2F, $0B, $24, $2A, $F0

Data_008_5BDA:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $20, $24, $31, $27, $F0

Data_008_5BE3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0C, $24, $31, $27, $2F, $28, $F0

Data_008_5BED:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $2C, $2F, $0B, $2C, $35, $27, $F0

Data_008_5BF6:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $26, $28, $35, $F0

Data_008_5BFC:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $F0

Data_008_5C05:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $16, $2C, $35, $35, $32, $35, $F0

Data_008_5C0F:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $2A, $38, $28, $17, $2C, $37, $28, $F0

Data_008_5C19:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $33, $33, $28, $37, $32, $35, $F0

Data_008_5C22:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $32, $33, $2C, $F0

Data_008_5C28:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $32, $32, $27, $32, $2F, $2F, $F0

Data_008_5C30:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $0D, $35, $24, $2E, $F0

Data_008_5C3A:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $2F, $3D, $24, $2E, $F0

Data_008_5C41:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $25, $35, $28, $16, $24, $31, $F0

Data_008_5C4A:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $35, $36, $28, $15, $24, $30, $33, $F0

Data_008_5C54:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $38, $36, $2B, $28, $24, $27, $F0

Data_008_5C5D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $F0

Data_008_5C66:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $02, $F0

Data_008_5C70:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $19, $32, $37, $F0

Data_008_5C78:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $36, $30, $32, $F0

Data_008_5C7E:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $39, $24, $16, $24, $31, $F0

Data_008_5C86:: ; heuristic: target of a monotone pointer table; C0
    db $12, $26, $28, $16, $24, $31, $F0

Data_008_5C8D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $30, $2C, $26, $F0

Data_008_5C93:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3B, $24, $38, $26, $28, $35, $36, $F0

Data_008_5C9C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $27, $0D, $32, $2F, $2F, $F0

Data_008_5CA4:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $28, $30, $F0

Data_008_5CAA:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_008_5CB3:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $30, $25, $0C, $35, $24, $2A, $F0

Data_008_5CBC:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $10, $32, $2F, $28, $30, $F0

Data_008_5CC6:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $16, $24, $37, $28, $F0

Data_008_5CCF:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $37, $32, $16, $28, $26, $2B, $F0

Data_008_5CD9:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $32, $38, $27, $14, $2C, $31, $2A, $F0

Data_008_5CE3:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_5CE5:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $37, $2C, $37, $28, $28, $2F, $F0

Data_008_5CEE:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $35, $24, $3C, $F0

Data_008_5CF4:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $2F, $35, $38, $36, $16, $24, $31, $F0

Data_008_5CFE:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $3C, $10, $2C, $2A, $24, $36, $F0

Data_008_5D07:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $28, $30, $32, $31, $F0

Data_008_5D0E:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $34, $38, $24, $35, $28, $2F, $2F, $24, $F0

Data_008_5D18:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $35, $30, $24, $31, $F0

Data_008_5D1F:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $2E, $2C, $27, $F0

Data_008_5D27:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $37, $35, $28, $0F, $2C, $36, $2B, $F0

Data_008_5D31:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $35, $28, $24, $26, $2B, $F0

Data_008_5D3B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $2A, $2F, $28, $35, $32, $31, $F0

Data_008_5D44:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $36, $2B, $1B, $2C, $27, $28, $35, $F0

Data_008_5D4E:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $38, $36, $2B, $0F, $2C, $36, $2B, $F0

Data_008_5D57:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $30, $24, $31, $2C, $24, $31, $F0

Data_008_5D60:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $24, $3A, $36, $37, $28, $35, $F0

Data_008_5D69:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $31, $26, $28, $35, $16, $24, $31, $F0

Data_008_5D73:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $2A, $38, $28, $20, $24, $39, $28, $F0

Data_008_5D7D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $26, $24, $2F, $2F, $32, $33, $24, $F0

Data_008_5D86:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $24, $11, $32, $35, $36, $28, $F0

Data_008_5D8F:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $32, $27, $1C, $34, $38, $2C, $27, $F0

Data_008_5D99:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $35, $1D, $2C, $2A, $28, $35, $F0

Data_008_5DA2:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3B, $28, $1C, $2B, $24, $35, $2E, $F0

Data_008_5DAB:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $2A, $32, $31, $F0

Data_008_5DB3:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $1C, $34, $38, $2C, $27, $F0

Data_008_5DBD:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $2A, $32, $31, $2A, $F0

Data_008_5DC4:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $24, $2F, $28, $16, $24, $2A, $28, $F0

Data_008_5DCE:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $34, $38, $24, $27, $32, $31, $F0

Data_008_5DD6:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $35, $24, $2C, $27, $F0

Data_008_5DDF:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $24, $2E, $32, $36, $F0

Data_008_5DE6:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $36, $28, $2C, $27, $32, $31, $F0

Data_008_5DEF:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $30, $33, $32, $2C, $36, $28, $F0

Data_008_5DF8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $35, $29, $2C, $36, $2B, $F0

Data_008_5E01:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_5E03:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $15, $32, $35, $27, $F0

Data_008_5E0D:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $15, $32, $35, $27, $F0

Data_008_5E17:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $35, $27, $0D, $35, $24, $26, $32, $F0

Data_008_5E21:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $35, $2A, $32, $31, $F0

Data_008_5E28:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $27, $32, $2B, $F0

Data_008_5E2E:: ; heuristic: target of a monotone pointer table; C0
    db $10, $28, $31, $32, $36, $2C, $27, $32, $2B, $F0

Data_008_5E38:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $35, $24, $30, $32, $36, $F0

Data_008_5E40:: ; heuristic: target of a monotone pointer table; C0
    db $23, $32, $30, $24, $F0

Data_008_5E45:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $36, $38, $35, $24, $23, $32, $30, $24, $F0

Data_008_5E4F:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $3D, $3D, $24, $35, $32, $F0

Data_008_5E57:: ; heuristic: target of a monotone pointer table; C0
    db $19, $36, $3C, $26, $2B, $32, $19, $2C, $3D, $F0

Data_008_5E61:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $36, $37, $28, $35, $2E, $F0

Data_008_5E68:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $35, $38, $27, $35, $24, $24, $36, $F0

Data_008_5E72:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $35, $38, $27, $35, $24, $24, $36, $F0

Data_008_5E7C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $27, $32, $38, $F0

Data_008_5E82:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $37, $2B, $16, $32, $35, $28, $F0

Data_008_5E8C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $37, $2B, $16, $32, $35, $28, $F0

Data_008_5E96:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $37, $2B, $16, $32, $35, $28, $F0

Data_008_5EA0:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $27, $35, $2C, $38, $30, $F0

Data_008_5EAA:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $2A, $32, $27, $28, $30, $2C, $35, $F0

Data_008_5EB4:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $2A, $32, $27, $28, $30, $2C, $35, $F0

Data_008_5EBE:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $26, $2E, $F0

Data_008_5EC4:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $37, $36, $38, $F0

Data_008_5ECA:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $24, $2A, $32, $F0

Data_008_5ED0:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $30, $36, $2C, $F0

Data_008_5ED6:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $3D, $32, $32, $F0

Data_008_5EDC:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_5EDE:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $30, $2C, $24, $F0

Data_008_5EE4:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $30, $28, $31, $36, $24, $38, $35, $F0

Data_008_5EEE:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $2A, $28, $25, $32, $38, $F0

Data_008_5EF6:: ; heuristic: target of a monotone pointer table; C0
    db $98, $F0

Data_008_5EF8:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_008_5EF9:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $24, $3D, $28, $F0

Data_008_5EFF:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $24, $3D, $28, $30, $32, $35, $28, $F0

Data_008_5F09:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $24, $3D, $28, $30, $32, $36, $37, $F0

Data_008_5F13:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $25, $24, $2F, $F0

Data_008_5F1B:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $25, $24, $31, $28, $F0

Data_008_5F24:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $25, $32, $2F, $37, $F0

Data_008_5F2D:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $31, $2A, $F0

Data_008_5F32:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $32, $30, $F0

Data_008_5F37:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3B, $33, $2F, $32, $27, $28, $37, $F0

Data_008_5F40:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $28, $35, $31, $32, $36, $F0

Data_008_5F49:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $28, $35, $30, $32, $35, $28, $F0

Data_008_5F53:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $28, $35, $30, $32, $36, $37, $F0

Data_008_5F5D:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $2F, $37, $F0

Data_008_5F62:: ; heuristic: target of a monotone pointer table; C0
    db $23, $24, $33, $F0

Data_008_5F66:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $32, $35, $27, $24, $2C, $31, $F0

Data_008_5F6F:: ; heuristic: target of a monotone pointer table; C0
    db $12, $26, $28, $0B, $32, $2F, $37, $F0

Data_008_5F77:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $32, $3A, $1C, $37, $32, $35, $30, $F0

Data_008_5F81:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $2C, $3D, $3D, $24, $35, $27, $F0

Data_008_5F8A:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $37, $F0

Data_008_5F8F:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $29, $28, $24, $37, $F0

Data_008_5F96:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $26, $35, $2C, $29, $2C, $26, $28, $F0

Data_008_5FA0:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $2F, $F0

Data_008_5FA5:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $2F, $16, $32, $35, $28, $F0

Data_008_5FAE:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $2F, $0A, $2F, $2F, $F0

Data_008_5FB6:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $2F, $1E, $36, $F0

Data_008_5FBD:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $2F, $1E, $36, $0A, $2F, $2F, $F0

Data_008_5FC7:: ; heuristic: target of a monotone pointer table; C0
    db $16, $19, $24, $36, $36, $F0

Data_008_5FCD:: ; heuristic: target of a monotone pointer table; C0
    db $16, $19, $24, $36, $36, $30, $32, $35, $28, $F0

Data_008_5FD7:: ; heuristic: target of a monotone pointer table; C0
    db $16, $19, $24, $36, $36, $30, $32, $36, $37, $F0

Data_008_5FE1:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $2C, $39, $2C, $29, $3C, $F0

Data_008_5FE8:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $39, $2C, $39, $28, $F0

Data_008_5FEF:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $35, $28, $3A, $28, $2F, $2F, $F0

Data_008_5FF8:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $37, $2C, $27, $32, $37, $28, $F0

Data_008_6001:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $0C, $2B, $24, $32, $36, $F0

Data_008_6009:: ; heuristic: target of a monotone pointer table; C0
    db $17, $38, $30, $25, $18, $29, $29, $F0

Data_008_6011:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $35, $36, $28, $18, $29, $29, $F0

Data_008_601A:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $33, $33, $28, $35, $F0

Data_008_6020:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $26, $35, $28, $24, $36, $28, $F0

Data_008_6029:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $33, $F0

Data_008_602D:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $29, $28, $31, $36, $28, $F0

Data_008_6035:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $28, $28, $27, $F0

Data_008_603B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $28, $28, $27, $1E, $33, $F0

Data_008_6043:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $32, $3A, $F0

Data_008_6048:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $32, $3A, $0A, $2F, $2F, $F0

Data_008_6050:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3A, $2C, $31, $11, $2C, $37, $36, $F0

Data_008_6059:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $35, $35, $32, $38, $31, $27, $F0

Data_008_6062:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $28, $28, $33, $F0

Data_008_6068:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $28, $28, $33, $0A, $2F, $2F, $F0

Data_008_6071:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2E, $28, $16, $24, $2A, $2C, $26, $F0

Data_008_607B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $16, $24, $2A, $2C, $26, $F0

Data_008_6084:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $33, $1C, $33, $28, $2F, $2F, $F0

Data_008_608E:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $31, $2C, $26, $0A, $2F, $2F, $F0

Data_008_6097:: ; heuristic: target of a monotone pointer table; C0
    db $12, $35, $32, $31, $2C, $3D, $28, $F0

Data_008_609F:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $0B, $24, $26, $2E, $F0

Data_008_60A9:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $38, $31, $26, $28, $F0

Data_008_60B0:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $35, $35, $2C, $28, $35, $F0

Data_008_60B8:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $20, $24, $2F, $2F, $F0

Data_008_60C2:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $24, $31, $36, $29, $32, $35, $30, $F0

Data_008_60CC:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $0D, $35, $24, $2A, $32, $31, $F0

Data_008_60D5:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $31, $26, $28, $F0

Data_008_60DC:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $2A, $24, $16, $24, $2A, $2C, $26, $F0

Data_008_60E6:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $2A, $0B, $24, $31, $2A, $F0

Data_008_60EE:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $2F, $2F, $25, $2F, $24, $36, $37, $F0

Data_008_60F8:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $0A, $2C, $35, $F0

Data_008_6100:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $24, $3D, $28, $0A, $2C, $35, $F0

Data_008_6109:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $26, $32, $35, $26, $2B, $2C, $31, $2A, $F0

Data_008_6113:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $37, $28, $0F, $2C, $35, $28, $F0

Data_008_611D:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $35, $2C, $2A, $2C, $27, $0A, $2C, $35, $F0

Data_008_6127:: ; heuristic: target of a monotone pointer table; C0
    db $12, $26, $28, $0A, $2C, $35, $F0

Data_008_612E:: ; heuristic: target of a monotone pointer table; C0
    db $12, $26, $28, $1C, $37, $32, $35, $30, $F0

Data_008_6137:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $37, $28, $0A, $2C, $35, $F0

Data_008_6140:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $0B, $28, $24, $36, $37, $F0

Data_008_614A:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $26, $38, $38, $30, $F0

Data_008_6151:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $2A, $2B, $37, $31, $2C, $31, $2A, $F0

Data_008_615B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $26, $2E, $1D, $2B, $35, $32, $3A, $F0

Data_008_6165:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $28, $35, $36, $2B, $32, $37, $F0

Data_008_616F:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2C, $27, $24, $2F, $3A, $24, $39, $28, $F0

Data_008_6179:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $2F, $2F, $11, $28, $2F, $33, $F0

Data_008_6182:: ; heuristic: target of a monotone pointer table; C0
    db $22, $28, $2F, $2F, $11, $28, $2F, $33, $F0

Data_008_618B:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $1C, $2F, $24, $36, $2B, $F0

Data_008_6195:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $26, $38, $1C, $2F, $24, $36, $2B, $F0

Data_008_619F:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $2F, $37, $1C, $2F, $24, $36, $2B, $F0

Data_008_61A9:: ; heuristic: target of a monotone pointer table; C0
    db $12, $26, $28, $1C, $2F, $24, $36, $2B, $F0

Data_008_61B2:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $0B, $2F, $32, $3A, $F0

Data_008_61BC:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2E, $1C, $2F, $24, $36, $2B, $F0

Data_008_61C6:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $0C, $38, $37, $F0

Data_008_61CF:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $35, $27, $0B, $2F, $32, $3A, $F0

Data_008_61D8:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $2A, $0B, $2F, $32, $3A, $F0

Data_008_61E0:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $28, $24, $35, $36, $F0

Data_008_61E7:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $39, $2C, $2F, $0C, $38, $37, $F0

Data_008_61F0:: ; heuristic: target of a monotone pointer table; C0
    db $23, $32, $30, $25, $2C, $28, $0C, $38, $37, $F0

Data_008_61FA:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $28, $24, $31, $0C, $38, $37, $F0

Data_008_6203:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $34, $38, $24, $0C, $38, $37, $F0

Data_008_620B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $0C, $38, $37, $F0

Data_008_6214:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $2C, $36, $32, $31, $11, $2C, $37, $F0

Data_008_621E:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $35, $24, $2F, $3C, $3D, $28, $F0

Data_008_6227:: ; heuristic: target of a monotone pointer table; C0
    db $17, $24, $33, $0A, $37, $37, $24, $26, $2E, $F0

Data_008_6231:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $34, $38, $24, $2F, $2F, $11, $2C, $37, $F0

Data_008_623B:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $0A, $37, $37, $24, $26, $2E, $F0

Data_008_6244:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $38, $24, $27, $11, $2C, $37, $36, $F0

Data_008_624D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $31, $1C, $2F, $24, $36, $2B, $F0

Data_008_6257:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $2F, $37, $2C, $0C, $38, $37, $F0

Data_008_6260:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $2A, $24, $1C, $2F, $24, $36, $2B, $F0

Data_008_626A:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $35, $2A, $28, $1E, $33, $F0

Data_008_6273:: ; heuristic: target of a monotone pointer table; C0
    db $19, $36, $3C, $26, $2B, $28, $1E, $33, $F0

Data_008_627C:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $2A, $2B, $13, $38, $30, $33, $F0

Data_008_6285:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $1C, $2F, $24, $36, $2B, $F0

Data_008_628F:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $36, $36, $24, $26, $35, $28, $F0

Data_008_6298:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3A, $2C, $31, $1C, $2F, $24, $36, $2B, $F0

Data_008_62A2:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $35, $36, $28, $35, $2E, $28, $35, $F0

Data_008_62AC:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $30, $30, $2C, $31, $2A, $F0

Data_008_62B4:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $30, $2C, $2E, $24, $3D, $28, $F0

Data_008_62BD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $28, $28, $33, $0A, $2C, $35, $F0

Data_008_62C6:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $2F, $36, $3C, $0A, $2C, $35, $F0

Data_008_62CF:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $2C, $36, $32, $31, $10, $24, $36, $F0

Data_008_62D9:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $2C, $36, $32, $31, $0A, $2C, $35, $F0

Data_008_62E3:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $35, $36, $28, $F0

Data_008_62E9:: ; heuristic: target of a monotone pointer table; C0
    db $18, $27, $27, $0D, $24, $31, $26, $28, $F0

Data_008_62F2:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $0D, $24, $31, $26, $28, $F0

Data_008_62FB:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $31, $2C, $0D, $24, $31, $26, $28, $F0

Data_008_6305:: ; heuristic: target of a monotone pointer table; C0
    db $14, $B5, $18, $B5, $0D, $24, $31, $26, $28, $F0

Data_008_630F:: ; heuristic: target of a monotone pointer table; C0
    db $15, $38, $35, $28, $0D, $24, $31, $26, $28, $F0

Data_008_6319:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $28, $0D, $24, $31, $26, $28, $F0

Data_008_6323:: ; heuristic: target of a monotone pointer table; C0
    db $11, $38, $36, $37, $2F, $28, $F0

Data_008_632A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $27, $28, $1C, $37, $28, $33, $F0

Data_008_6333:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $31, $27, $1C, $37, $32, $35, $30, $F0

Data_008_633D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $27, $2C, $24, $31, $37, $F0

Data_008_6345:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $28, $35, $2C, $28, $15, $2C, $37, $28, $F0

Data_008_634F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $35, $2A, $28, $F0

Data_008_6355:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $2F, $37, $35, $24, $0D, $32, $3A, $31, $F0

Data_008_635F:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $16, $24, $2A, $2C, $26, $F0

Data_008_6367:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $2C, $26, $2E, $0F, $32, $2A, $F0

Data_008_6370:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $37, $36, $38, $0C, $24, $2F, $2F, $F0

Data_008_637A:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $24, $2A, $32, $0C, $24, $2F, $2F, $F0

Data_008_6384:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $30, $36, $2C, $0C, $24, $2F, $2F, $F0

Data_008_638E:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $3D, $32, $32, $0C, $24, $2F, $2F, $F0

Data_008_6398:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $26, $2E, $0A, $2C, $35, $F0

Data_008_63A0:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $26, $38, $36, $F0

Data_008_63A6:: ; heuristic: target of a monotone pointer table; C0
    db $15, $38, $36, $2B, $15, $2C, $26, $2E, $36, $F0

Data_008_63B0:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $26, $2E, $15, $2C, $26, $2E, $F0

Data_008_63B9:: ; heuristic: target of a monotone pointer table; C0
    db $15, $28, $2A, $1C, $3A, $28, $28, $33, $F0

Data_008_63C2:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $2A, $1D, $35, $2C, $33, $F0

Data_008_63CA:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2B, $2B, $2B, $F0

Data_008_63CF:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $0C, $35, $3C, $F0

Data_008_63D6:: ; heuristic: target of a monotone pointer table; C0
    db $10, $28, $3C, $36, $28, $35, $F0

Data_008_63DD:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $1C, $2B, $38, $37, $F0

Data_008_63E7:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $38, $37, $2B, $1C, $2B, $38, $37, $F0

Data_008_63F1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $35, $32, $31, $2A, $0D, $F0

Data_008_63F9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $32, $27, $2A, $28, $F0

Data_008_63FF:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $24, $27, $28, $0D, $F0

Data_008_6406:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $39, $28, $35, $F0

Data_008_640C:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $24, $35, $27, $2C, $24, $31, $F0

Data_008_6415:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2C, $2F, $20, $2C, $31, $27, $F0

Data_008_641E:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $35, $30, $20, $2C, $31, $27, $F0

Data_008_6428:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $34, $38, $24, $20, $24, $2F, $2F, $F0

Data_008_6431:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $24, $2F, $19, $35, $24, $3C, $F0

Data_008_643A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $26, $2E, $0A, $2F, $2F, $F0

Data_008_6442:: ; heuristic: target of a monotone pointer table; C0
    db $12, $30, $2C, $37, $24, $37, $28, $F0

Data_008_644A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $27, $2C, $37, $24, $37, $28, $F0

Data_008_6453:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $28, $1C, $32, $31, $2A, $F0

Data_008_645C:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $39, $28, $1B, $24, $2C, $31, $F0

Data_008_6465:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $36, $37, $2F, $28, $F0

Data_008_646D:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2B, $28, $35, $32, $30, $32, $31, $28, $F0

Data_008_6477:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $28, $33, $10, $38, $24, $35, $27, $F0

Data_008_6481:: ; heuristic: target of a monotone pointer table; C0
    db $18, $38, $37, $36, $2C, $27, $28, $F0

Data_008_6489:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $32, $35, $30, $28, $35, $F0

Data_008_6492:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $35, $35, $24, $31, $27, $F0

Data_008_6499:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $24, $2A, $2F, $28, $0E, $3C, $28, $F0

Data_008_64A2:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $33, $16, $24, $2A, $2C, $26, $F0

Data_008_64AB:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2B, $2B, $2B, $F0

Data_008_64B0:: ; heuristic: target of a monotone pointer table; C0
    db $23, $32, $31, $28, $18, $38, $37, $F0

Data_008_64B8:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $24, $35, $27, $F0

Data_008_64BE:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $31, $2C, $26, $0A, $2F, $2F, $F0

Data_008_64C7:: ; heuristic: target of a monotone pointer table; C0
    db $12, $35, $32, $31, $2C, $3D, $28, $F0

Data_008_64CF:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $2A, $2B, $13, $38, $30, $33, $F0

Data_008_64D8:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $39, $28, $1B, $24, $2C, $31, $F0

Data_008_64E1:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_008_64E2:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_008_64E3:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $35, $25, $F0

Data_008_64E8:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $39, $28, $20, $24, $37, $28, $35, $F0

Data_008_64F2:: ; heuristic: target of a monotone pointer table; C0
    db $20, $32, $35, $2F, $27, $0D, $28, $3A, $F0

Data_008_64FB:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $37, $2C, $32, $31, $F0

Data_008_6502:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2F, $29, $20, $24, $37, $28, $35, $F0

Data_008_650B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $37, $2C, $27, $32, $37, $28, $F0

Data_008_6514:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $32, $31, $11, $28, $35, $25, $F0

Data_008_651D:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $38, $35, $28, $2F, $F0

Data_008_6524:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3A, $24, $2E, $28, $1C, $24, $31, $27, $F0

Data_008_652E:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $0B, $28, $2F, $2F, $F0

Data_008_6536:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2A, $28, $1B, $32, $26, $2E, $F0

Data_008_653F:: ; heuristic: target of a monotone pointer table; C0
    db $20, $32, $35, $2F, $27, $15, $28, $24, $29, $F0

Data_008_6549:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $1D, $14, $36, $28, $28, $27, $F0

Data_008_6551:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $0E, $0F, $36, $28, $28, $27, $F0

Data_008_6559:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $10, $15, $36, $28, $28, $27, $F0

Data_008_6561:: ; heuristic: target of a monotone pointer table; C0
    db $12, $17, $1D, $36, $28, $28, $27, $F0

Data_008_6569:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $28, $0A, $26, $32, $35, $31, $F0

Data_008_6573:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $36, $37, $2C, $26, $17, $38, $37, $F0

Data_008_657D:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $38, $28, $36, $37, $50, $F0

Data_008_6584:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $35, $32, $35, $50, $F0

Data_008_658C:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $17, $2C, $26, $28, $50, $F0

Data_008_6594:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $28, $24, $37, $28, $35, $50, $F0

Data_008_659D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $35, $37, $50, $F0

Data_008_65A4:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $30, $28, $27, $3C, $50, $F0

Data_008_65AC:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $28, $29, $13, $28, $35, $2E, $3C, $F0

Data_008_65B6:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $35, $2E, $0C, $2B, $32, $33, $F0

Data_008_65BF:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $25, $F0

Data_008_65C3:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $35, $2F, $32, $2C, $31, $F0

Data_008_65CB:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $27, $16, $28, $24, $37, $F0

Data_008_65D3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $28, $18, $35, $25, $F0

Data_008_65DB:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $1D, $24, $2C, $2F, $F0

Data_008_65E5:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $33, $28, $2F, $2F, $28, $31, $37, $F0

Data_008_65EF:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $2C, $31, $3C, $11, $24, $35, $33, $F0

Data_008_65F9:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $36, $37, $51, $F0

Data_008_65FF:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $35, $2C, $28, $31, $27, $51, $F0

Data_008_6607:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $51, $F0

Data_008_660D:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $2F, $37, $51, $F0

Data_008_6613:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $32, $3A, $51, $F0

Data_008_6619:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $51, $F0

Data_008_661F:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $33, $51, $F0

Data_008_6625:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $33, $20, $2C, $31, $2A, $F0

Data_008_662E:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3B, $2C, $37, $0B, $28, $2F, $2F, $F0

Data_008_6637:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $32, $2E, $30, $24, $35, $2E, $F0

Data_008_6640:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2C, $31, $3C, $16, $28, $27, $24, $2F, $F0

Data_008_664A:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $19, $24, $36, $36, $F0

Data_008_6653:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $2A, $1D, $3A, $2C, $2A, $F0

Data_008_665B:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_008_665C:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $28, $35, $0C, $24, $2F, $2F, $F0

Data_008_6666:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $32, $31, $1B, $32, $26, $2E, $F0

Data_008_666F:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $36, $37, $F0

Data_008_6675:: ; heuristic: target of a monotone pointer table; C0
    db $22, $38, $31, $24, $1C, $32, $38, $2F, $F0

Data_008_667E:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $28, $28, $33, $11, $28, $35, $25, $F0

Data_008_6688:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $31, $2A, $28, $51, $F0

Data_008_6690:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2C, $27, $24, $2F, $0B, $28, $2F, $2F, $F0

Data_008_669A:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $35, $16, $2C, $35, $35, $32, $35, $F0

Data_008_66A4:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $5E, $F0

Data_008_66A9:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $39, $28, $31, $52, $F0

Data_008_66B1:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $39, $28, $31, $54, $F0

Data_008_66B9:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $39, $28, $31, $53, $F0

Data_008_66C1:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $3D, $1C, $37, $32, $31, $28, $F0

Data_008_66CA:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $37, $37, $3C, $55, $F0

Data_008_66D2:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $26, $26, $28, $36, $36, $32, $35, $3C, $F0

Data_008_66DC:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $12, $1D, $25, $28, $2F, $37, $F0

Data_008_66E4:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $0B, $28, $2F, $37, $F0

Data_008_66EE:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $0B, $28, $2F, $37, $F0

Data_008_66F8:: ; heuristic: target of a monotone pointer table; C0
    db $18, $27, $27, $0B, $28, $2F, $37, $F0

Data_008_6700:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $31, $28, $0F, $24, $31, $2A, $F0

Data_008_670A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $28, $28, $2F, $0F, $24, $31, $2A, $F0

Data_008_6714:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $35, $30, $1C, $26, $24, $2F, $28, $F0

Data_008_671E:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2E, $1C, $26, $24, $2F, $28, $F0

Data_008_6728:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $10, $15, $55, $F0

Data_008_672D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $35, $35, $3C, $55, $F0

Data_008_6735:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $35, $37, $56, $F0

Data_008_673C:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $36, $28, $56, $F0

Data_008_6742:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $0C, $24, $33, $28, $F0

Data_008_674C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $0C, $24, $33, $28, $F0

Data_008_6756:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $2F, $39, $35, $0C, $24, $33, $28, $F0

Data_008_6760:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $0C, $24, $33, $28, $F0

Data_008_6769:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $37, $31, $30, $0C, $24, $33, $28, $F0

Data_008_6773:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $26, $24, $0C, $24, $33, $28, $F0

Data_008_677C:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $24, $39, $28, $0C, $24, $33, $28, $F0

Data_008_6786:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $9C, $1C, $26, $24, $2F, $28, $F0

Data_008_678E:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $31, $28, $F0

Data_008_6793:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $28, $55, $F0

Data_008_6799:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $39, $2C, $31, $28, $55, $F0

Data_008_67A1:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $55, $F0

Data_008_67A6:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $28, $55, $F0

Data_008_67AC:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $2A, $2B, $37, $55, $F0

Data_008_67B3:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2C, $2F, $32, $35, $55, $F0

Data_008_67BB:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $2C, $28, $29, $55, $F0

Data_008_67C2:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $28, $35, $2C, $26, $55, $F0

Data_008_67CA:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_008_67CB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of one", $F1
    db "monster by "
    db $03, $00, $9D, $04, $00, $B5, $F0

Data_008_67F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of one", $F1
    db "monster by "
    db $06, $00, $9D, $07, $00, $B5, $F0

Data_008_6815:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores HP", $F1
    db "of all monsters.", $F0

Data_008_6838:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores MP of one", $F1
    db "monster by "
    db $02, $00, $9D, $03, $00, $B5, $F0

Data_008_685D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores MP", $F1
    db "of one monster.", $F0

Data_008_687F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Removes all traces", $F1
    db "of poison.", $F0

Data_008_689D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cures paralysis.", $F0

Data_008_68AE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lifts a curse off", $F1
    db "one monster.", $F0

Data_008_68CD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Awakens a sleeping", $F1
    db "monster.", $F0

Data_008_68E9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snaps a monster", $F1
    db "out of confusion.", $F0

Data_008_690B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of all", $F1
    db "monsters by "
    db $06, $00, $9D, $07, $00, $B5, $F0

Data_008_6931:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives a dead", $F1
    db "monster.", $F0

Data_008_6949:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 3.", $F0

Data_008_695A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 3.", $F0

Data_008_696B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 3.", $F0

Data_008_697C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 3.", $F0

Data_008_698D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 5.", $F0

Data_008_69A2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 5.", $F0

Data_008_69B7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "braver.", $F0

Data_008_69D0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more cowardly.", $F0

Data_008_69F0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more kindly.", $F0

Data_008_6A0E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more sly.", $F0

Data_008_6A29:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more thoughtful.", $F0

Data_008_6A4B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "simple-minded.", $F0

Data_008_6A6B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "just a little.", $F0

Data_008_6A89:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters a", $F1
    db "little bit.", $F0

Data_008_6AA6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters a", $F1
    db "lot.", $F0

Data_008_6ABC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "very much.", $F0

Data_008_6AD6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames a tiny bit,", $F1
    db "but also poisons.", $F0

Data_008_6AFA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "incredibly.", $F0

Data_008_6B15:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Checks if monster", $F1
    db "was caught before.", $F0

Data_008_6B3A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents monsters", $F1
    db "from appearing.", $F0

Data_008_6B5C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts monsters", $F1
    db "when strummed.", $F0

Data_008_6B7D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents casting", $F1
    db "of spells.", $F0

Data_008_6B99:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Doubles physical", $F1
    db "power of one.", $F0

Data_008_6BB8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with a windstorm.", $F0

Data_008_6BDB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with lightning.", $F0

Data_008_6BFC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with a blizzard.", $F0

Data_008_6C1E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits one target", $F1
    db "with a fireball.", $F0

Data_008_6C3F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "the Door Shrine.", $F0

Data_008_6C63:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "GreatLog.", $F0

Data_008_6C80:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "the exit.", $F0

Data_008_6C9D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enables saving in", $F1
    db "the Journal.", $F0

Data_008_6CBC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Collect and trade", $F1
    db "for rare gifts.", $F0

Data_008_6CDE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Get a 10-percent", $F1
    db "discount at shops.", $F0

Data_008_6D02:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moves the Door", $F1
    db "Shrine.", $F0

Data_008_6D19:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reveals Mirage", $F1
    db "Lake.", $F0

Data_008_6D2E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A magic stone that", $F1
    db "raises the tide.", $F0

Data_008_6D52:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A medal from the", $F1
    db "elemental spirit.", $F0

Data_008_6D75:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The lost soul of a", $F1
    db "princess.", $F0

Data_008_6D92:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A blue flower that", $F1
    db "grows in snow.", $F0

Data_008_6DB4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Transforms users", $F1
    db "into monsters.", $F0

Data_008_6DD4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a clam for", $F1
    db "crossing the sea.", $F0

Data_008_6DF9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Destroys what it", $F1
    db "reflects.", $F0

Data_008_6E14:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a cloud", $F1
    db "for flying.", $F0

Data_008_6E30:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary helmet", $F1
    db "found in a cave.", $F0

Data_008_6E54:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary armor", $F1
    db "found in a tower.", $F0

Data_008_6E78:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary sword", $F1
    db "found in a castle.", $F0

Data_008_6E9D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A magical stone", $F1
    db "that glows blue.", $F0

Data_008_6EBE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A beautiful gold", $F1
    db "ring.", $F0

Data_008_6ED5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

Data_008_6EE0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 30.", $F0

Data_008_6EF6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 80.", $F0

Data_008_6F0C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 30.", $F0

Data_008_6F22:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 80.", $F0

Data_008_6F38:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 10.", $F0

Data_008_6F4A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 50.", $F0

Data_008_6F5C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 10.", $F0

Data_008_6F6E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 50.", $F0

Data_008_6F80:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 10.", $F0

Data_008_6F92:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 50.", $F0

Data_008_6FA4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 50.", $F0

Data_008_6FB6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 100.", $F0

Data_008_6FC9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to attack spells.", $F0

Data_008_6FED:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to fire and ice.", $F0

Data_008_7010:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists confusion,", $F1
    db "poison "
    db $B6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " sleep.", $F0

Data_008_7033:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists most", $F1
    db "status skills.", $F0

Data_008_704F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists curse,", $F1
    db "paralysis "
    db $B6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " death.", $F0

Data_008_7071:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to water skills.", $F0

Data_008_7094:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents skills", $F1
    db "from being sealed.", $F0

Data_008_70B7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 5.", $F0

Data_008_70C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

Data_008_70D3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP by 1", $F1
    db "on every step.", $F0

Data_008_70F3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores MP by 1", $F1
    db "on every step.", $F0

Data_008_7113:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes max. HP", $F1
    db "gain.", $F0

Data_008_712A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes max.", $F1
    db "MP gain.", $F0

Data_008_7141:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes ATK gain", $F1
    db "while growing.", $F0

Data_008_7162:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes DEF gain", $F1
    db "while growing.", $F0

Data_008_7183:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes AGL gain", $F1
    db "while growing.", $F0

Data_008_71A4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes INT gain", $F1
    db "while growing.", $F0

Data_008_71C5:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

Data_008_71D0:: ; heuristic: target of a monotone pointer table; C0
    db $F1, $F0

Data_008_71D2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Checks if monster", $F1
    db "was caught before.", $F0

Data_008_71F7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hotblood", $F0

Data_008_7200:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Eager", $F0

Data_008_7206:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Smug", $F0

Data_008_720B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Earnest", $F0

Data_008_7213:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pushy", $F0

Data_008_7219:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snobby", $F0

Data_008_7220:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reckless", $F0

Data_008_7229:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Daring", $F0

Data_008_7230:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Daredevil", $F0

Data_008_723A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cool"
    db $9E, $0C, $24, $2F, $30, $F0

Data_008_7244:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $35, $2C, $32, $38, $36, $F0

Data_008_724C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $2F, $29, $2C, $36, $2B, $F0

Data_008_7254:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $30, $33, $2F, $28, $F0

Data_008_725B:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $31, $32, $26, $28, $31, $37, $F0

Data_008_7264:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $2C, $27, $28, $29, $38, $2F, $F0

Data_008_726D:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $36, $3C, $F0

Data_008_7272:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $30, $36, $3C, $F0

Data_008_7279:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $32, $2C, $2F, $28, $27, $F0

Data_008_7281:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $35, $37, $F0

Data_008_7287:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $3C, $F0

Data_008_728B:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $38, $28, $2F, $F0

Data_008_7291:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $3C, $F0

Data_008_7295:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $29, $29, $24, $25, $2F, $28, $F0

Data_008_729D:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $3A, $24, $35, $27, $F0

Data_008_72A4:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $2F, $2F, $2C, $25, $2F, $28, $F0

Data_008_72AD:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $35, $28, $29, $35, $28, $28, $F0

Data_008_72B6:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $3D, $3C, $F0

Data_008_72BB:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $90, $2C, $37, $28, $30, $36, $F0

Data_008_72C4:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $36, $36, $90, $37, $2B, $2C, $36, $90, $24, $3A, $24, $3C, $98, $F0

Data_008_72D4:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $20, $90, $26, $24, $31, $41, $90, $25, $28, $F1, $37, $32, $36, $36, $28
    db $27, $90, $32, $38, $37, $B5, $F7, $F0

Data_008_72EC:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $37, $90, $31, $32, $37, $2B, $2C, $31, $2A, $F1, $2B, $24, $33, $33
    db $28, $31, $28, $27, $B5, $F7, $F0

Data_008_7303:: ; heuristic: target of a monotone pointer table; C0
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " threw away", $F1
    db "the ", $F9, "W.", $F7
    db $F0

Data_008_7319:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $F0

Data_008_731C:: ; heuristic: target of a monotone pointer table; C0
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " tried using", $F1
    db $F9, "W.", $F7
    db $F2, "But nothing", $F1
    db "happened.", $F7
    db $F0

Data_008_7346:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Toss out the", $F1
    db $F9, "W?", $F0

Data_008_7357:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You can't toss", $F1
    db "that out!", $F7
    db $F0

Data_008_7370:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "That can't be used", $F1
    db "here.", $F7
    db $F0

Data_008_7389:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Not in use.", $F0

Data_008_7395:: ; heuristic: target of a monotone pointer table; C0
    db $F6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " inserted the", $F1
    db "key.", $F7
    db $F0

Data_008_73AA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The key could not", $F1
    db "be used yet.", $F7
    db $F0

Data_008_73CA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You can't save", $F1
    db "here.", $F7
    db $F0

Data_008_73DF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "No skills", $F0
    ds $C17, $00
