SECTION "Bank 88", ROMX[$4000], BANK[$88]
    db $88

; ld de, this bank's string table / BeginStringDisplay
; 2 call sites from 2 routines (e.g. ShowString_Bank88, DebugMessageTest_Update_Case11)
BeginStringDisplay_Bank88::
Func_088_4001:: ; address name
    ld de, Data_088_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

; Func_088_4001 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 2 call sites from 2 routines (e.g. DebugShowMonsterRecord, Func_001_6903)
ShowString_Bank88::
Func_088_400F:: ; address name
    call BeginStringDisplay_Bank88
    call RunStringDisplayToEnd
    ret

Data_088_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_088_401C
    dw Data_088_421C
    dw Data_088_441C

Data_088_401C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_088_461C
    dw Data_088_4621
    dw Data_088_4627
    dw Data_088_4631
    dw Data_088_463B
    dw Data_088_4645
    dw Data_088_464F
    dw Data_088_4659
    dw Data_088_4659
    dw Data_088_4663
    dw Data_088_4669
    dw Data_088_4671
    dw Data_088_4678
    dw Data_088_4682
    dw Data_088_468B
    dw Data_088_4690
    dw Data_088_4697
    dw Data_088_469F
    dw Data_088_46A9
    dw Data_088_46B3
    dw Data_088_46BA
    dw Data_088_46C4
    dw Data_088_46CA
    dw Data_088_46D1
    dw Data_088_46DB
    dw Data_088_46E4
    dw Data_088_46ED
    dw Data_088_46ED
    dw Data_088_46F7
    dw Data_088_4700
    dw Data_088_4709
    dw Data_088_4712
    dw Data_088_4719
    dw Data_088_4721
    dw Data_088_472B
    dw Data_088_4734
    dw Data_088_473E
    dw Data_088_4747
    dw Data_088_474F
    dw Data_088_4758
    dw Data_088_4761
    dw Data_088_476B
    dw Data_088_4775
    dw Data_088_477F
    dw Data_088_4784
    dw Data_088_4788
    dw Data_088_478E
    dw Data_088_4794
    dw Data_088_479A
    dw Data_088_47A0
    dw Data_088_47A8
    dw Data_088_47B1
    dw Data_088_47BB
    dw Data_088_47C3
    dw Data_088_47CC
    dw Data_088_47D4
    dw Data_088_47DC
    dw Data_088_47E4
    dw Data_088_47EC
    dw Data_088_47F5
    dw Data_088_47FC
    dw Data_088_4806
    dw Data_088_480F
    dw Data_088_4819
    dw Data_088_4822
    dw Data_088_482B
    dw Data_088_4834
    dw Data_088_483D
    dw Data_088_4847
    dw Data_088_4850
    dw Data_088_485A
    dw Data_088_4864
    dw Data_088_486D
    dw Data_088_4872
    dw Data_088_487B
    dw Data_088_4885
    dw Data_088_488E
    dw Data_088_4898
    dw Data_088_489F
    dw Data_088_48A8
    dw Data_088_48B2
    dw Data_088_48BB
    dw Data_088_48C5
    dw Data_088_48CF
    dw Data_088_48D7
    dw Data_088_48E0
    dw Data_088_48E8
    dw Data_088_48F0
    dw Data_088_48F9
    dw Data_088_4900
    dw Data_088_4909
    dw Data_088_4910
    dw Data_088_4917
    dw Data_088_4920
    dw Data_088_492A
    dw Data_088_4933
    dw Data_088_493C
    dw Data_088_4945
    dw Data_088_494F
    dw Data_088_4959
    dw Data_088_4961
    dw Data_088_496A
    dw Data_088_4972
    dw Data_088_497C
    dw Data_088_4986
    dw Data_088_498F
    dw Data_088_4999
    dw Data_088_49A3
    dw Data_088_49A9
    dw Data_088_49B3
    dw Data_088_49BC
    dw Data_088_49C5
    dw Data_088_49CE
    dw Data_088_49D8
    dw Data_088_49E2
    dw Data_088_49EC
    dw Data_088_49F6
    dw Data_088_4A00
    dw Data_088_4A09
    dw Data_088_4A09
    dw Data_088_4A09
    dw Data_088_4A09
    dw Data_088_4A09
    dw Data_088_4A09
    dw Data_088_4A09
    dw Data_088_4A09
    dw Data_088_4A0F
    dw Data_088_4A15
    dw Data_088_4A1B
    dw Data_088_4A21
    dw Data_088_4A27
    dw Data_088_4A30
    dw Data_088_4A37
    dw Data_088_4A40
    dw Data_088_4A49
    dw Data_088_4A52
    dw Data_088_4A59
    dw Data_088_4A62
    dw Data_088_4A6B
    dw Data_088_4A75
    dw Data_088_4A7B
    dw Data_088_4A85
    dw Data_088_4A8E
    dw Data_088_4A96
    dw Data_088_4AA0
    dw Data_088_4AAA
    dw Data_088_4AB3
    dw Data_088_4ABB
    dw Data_088_4AC3
    dw Data_088_4ACC
    dw Data_088_4AD3
    dw Data_088_4ADB
    dw Data_088_4AE5
    dw Data_088_4AED
    dw Data_088_4AF4
    dw Data_088_4AFE
    dw Data_088_4B08
    dw Data_088_4B12
    dw Data_088_4B1A
    dw Data_088_4B24
    dw Data_088_4B2E
    dw Data_088_4B36
    dw Data_088_4B3F
    dw Data_088_4B45
    dw Data_088_4B4D
    dw Data_088_4B56
    dw Data_088_4B5F
    dw Data_088_4B66
    dw Data_088_4B70
    dw Data_088_4B7A
    dw Data_088_4B82
    dw Data_088_4B8A
    dw Data_088_4B94
    dw Data_088_4B9D
    dw Data_088_4BA7
    dw Data_088_4BB0
    dw Data_088_4BB7
    dw Data_088_4BC0
    dw Data_088_4BC8
    dw Data_088_4BD1
    dw Data_088_4BDB
    dw Data_088_4BE2
    dw Data_088_4BE9
    dw Data_088_4BEF
    dw Data_088_4BF8
    dw Data_088_4C01
    dw Data_088_4C0A
    dw Data_088_4C12
    dw Data_088_4C1B
    dw Data_088_4C25
    dw Data_088_4C2F
    dw Data_088_4C36
    dw Data_088_4C3D
    dw Data_088_4C46
    dw Data_088_4C4E
    dw Data_088_4C58
    dw Data_088_4C5E
    dw Data_088_4C63
    dw Data_088_4C6B
    dw Data_088_4C70
    dw Data_088_4C7A
    dw Data_088_4C83
    dw Data_088_4C89
    dw Data_088_4C91
    dw Data_088_4C9B
    dw Data_088_4CA5
    dw Data_088_4CAC
    dw Data_088_4CB4
    dw Data_088_4CBC
    dw Data_088_4CC1
    dw Data_088_4CC9
    dw Data_088_4CD2
    dw Data_088_4CDC
    dw Data_088_4CE6
    dw Data_088_4CEF
    dw Data_088_4CF9
    dw Data_088_4D02
    dw Data_088_4D0C
    dw Data_088_4D15
    dw Data_088_4D1B
    dw Data_088_4D23
    dw Data_088_4D2A
    dw Data_088_4D33
    dw Data_088_4D3C
    dw Data_088_4D45
    dw Data_088_4D4E
    dw Data_088_4D58
    dw Data_088_4D60
    dw Data_088_4D6A
    dw Data_088_4D73
    dw Data_088_4D7B
    dw Data_088_4D83
    dw Data_088_4D8D
    dw Data_088_4D97
    dw Data_088_4DA1
    dw Data_088_4DAB
    dw Data_088_4DB3
    dw Data_088_4DBA
    dw Data_088_4DC3
    dw Data_088_4DCD
    dw Data_088_4DD7
    dw Data_088_4DE1
    dw Data_088_4DE9
    dw Data_088_4DF2
    dw Data_088_4DFB
    dw Data_088_4E03
    dw Data_088_4E0D
    dw Data_088_4E16
    dw Data_088_4E1D
    dw Data_088_4E26
    dw Data_088_4E2E
    dw Data_088_4E38
    dw Data_088_4E41
    dw Data_088_4E4A
    dw Data_088_4E51
    dw Data_088_4E58

Data_088_421C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_088_4E61
    dw Data_088_4E6A
    dw Data_088_4E73
    dw Data_088_4E7B
    dw Data_088_4E83
    dw Data_088_4E89
    dw Data_088_4E93
    dw Data_088_4E9A
    dw Data_088_4EA3
    dw Data_088_4EAD
    dw Data_088_4EB6
    dw Data_088_4EBF
    dw Data_088_4EC9
    dw Data_088_4ED2
    dw Data_088_4EDC
    dw Data_088_4EE6
    dw Data_088_4EED
    dw Data_088_4EF4
    dw Data_088_4EFD
    dw Data_088_4F06
    dw Data_088_4F0D
    dw Data_088_4F16
    dw Data_088_4F1D
    dw Data_088_4F27
    dw Data_088_4F31
    dw Data_088_4F3A
    dw Data_088_4F44
    dw Data_088_4F4D
    dw Data_088_4F56
    dw Data_088_4F60
    dw Data_088_4F69
    dw Data_088_4F72
    dw Data_088_4F7C
    dw Data_088_4F85
    dw Data_088_4F8C
    dw Data_088_4F96
    dw Data_088_4FA0
    dw Data_088_4FAA
    dw Data_088_4FAE
    dw Data_088_4FB8
    dw Data_088_4FBE
    dw Data_088_4FC8
    dw Data_088_4FD2
    dw Data_088_4FDB
    dw Data_088_4FE4
    dw Data_088_4FEC
    dw Data_088_4FF6
    dw Data_088_5000
    dw Data_088_500A
    dw Data_088_5014
    dw Data_088_501C
    dw Data_088_5026
    dw Data_088_5030
    dw Data_088_5035
    dw Data_088_503F
    dw Data_088_5048
    dw Data_088_5051
    dw Data_088_505B
    dw Data_088_5064
    dw Data_088_506C
    dw Data_088_5073
    dw Data_088_507D
    dw Data_088_5087
    dw Data_088_508E
    dw Data_088_5095
    dw Data_088_509F
    dw Data_088_50A8
    dw Data_088_50B0
    dw Data_088_50B9
    dw Data_088_50C1
    dw Data_088_50C8
    dw Data_088_50D0
    dw Data_088_50DA
    dw Data_088_50E4
    dw Data_088_50ED
    dw Data_088_50F7
    dw Data_088_50FE
    dw Data_088_5106
    dw Data_088_510F
    dw Data_088_5119
    dw Data_088_5120
    dw Data_088_5129
    dw Data_088_5133
    dw Data_088_513D
    dw Data_088_5146
    dw Data_088_514F
    dw Data_088_5159
    dw Data_088_5163
    dw Data_088_516C
    dw Data_088_5176
    dw Data_088_5180
    dw Data_088_5189
    dw Data_088_5192
    dw Data_088_519A
    dw Data_088_51A3
    dw Data_088_51A9
    dw Data_088_51B1
    dw Data_088_51B7
    dw Data_088_51C1
    dw Data_088_51CA
    dw Data_088_51D4
    dw Data_088_51DD
    dw Data_088_51E6
    dw Data_088_51EE
    dw Data_088_51F7
    dw Data_088_5201
    dw Data_088_520A
    dw Data_088_5213
    dw Data_088_521D
    dw Data_088_5227
    dw Data_088_5231
    dw Data_088_523B
    dw Data_088_5243
    dw Data_088_524C
    dw Data_088_5253
    dw Data_088_525D
    dw Data_088_5267
    dw Data_088_5271
    dw Data_088_527B
    dw Data_088_5283
    dw Data_088_528C
    dw Data_088_5294
    dw Data_088_529A
    dw Data_088_52A1
    dw Data_088_52AA
    dw Data_088_52B4
    dw Data_088_52BC
    dw Data_088_52C4
    dw Data_088_52CA
    dw Data_088_52D4
    dw Data_088_52DB
    dw Data_088_52DB
    dw Data_088_52E3
    dw Data_088_52ED
    dw Data_088_52F6
    dw Data_088_52FD
    dw Data_088_5306
    dw Data_088_530C
    dw Data_088_5316
    dw Data_088_531F
    dw Data_088_5328
    dw Data_088_5331
    dw Data_088_533B
    dw Data_088_5342
    dw Data_088_534C
    dw Data_088_5356
    dw Data_088_5360
    dw Data_088_5367
    dw Data_088_5370
    dw Data_088_537A
    dw Data_088_5384
    dw Data_088_538D
    dw Data_088_5394
    dw Data_088_539D
    dw Data_088_53A5
    dw Data_088_53AE
    dw Data_088_53B7
    dw Data_088_53C0
    dw Data_088_53CA
    dw Data_088_53D2
    dw Data_088_53DB
    dw Data_088_53E1
    dw Data_088_53EA
    dw Data_088_53F2
    dw Data_088_53FC
    dw Data_088_5404
    dw Data_088_540D
    dw Data_088_5416
    dw Data_088_541F
    dw Data_088_5428
    dw Data_088_5431
    dw Data_088_543A
    dw Data_088_543A
    dw Data_088_5444
    dw Data_088_544E
    dw Data_088_5458
    dw Data_088_5462
    dw Data_088_546C
    dw Data_088_5475
    dw Data_088_547F
    dw Data_088_5488
    dw Data_088_5492
    dw Data_088_5499
    dw Data_088_54A0
    dw Data_088_54A7
    dw Data_088_54AE
    dw Data_088_54B7
    dw Data_088_54BF
    dw Data_088_54C9
    dw Data_088_54D1
    dw Data_088_54DB
    dw Data_088_54E4
    dw Data_088_54EC
    dw Data_088_54F6
    dw Data_088_54FF
    dw Data_088_5509
    dw Data_088_5513
    dw Data_088_551D
    dw Data_088_5526
    dw Data_088_552A
    dw Data_088_5533
    dw Data_088_553C
    dw Data_088_5543
    dw Data_088_554B
    dw Data_088_5555
    dw Data_088_555C
    dw Data_088_5566
    dw Data_088_556E
    dw Data_088_5578
    dw Data_088_557F
    dw Data_088_5587
    dw Data_088_5590
    dw Data_088_5596
    dw Data_088_55A0
    dw Data_088_55A9
    dw Data_088_55B0
    dw Data_088_55B8
    dw Data_088_55C2
    dw Data_088_55CB
    dw Data_088_55D4
    dw Data_088_55DD
    dw Data_088_55E5
    dw Data_088_55ED
    dw Data_088_55F6
    dw Data_088_55FF
    dw Data_088_5607
    dw Data_088_5610
    dw Data_088_5618
    dw Data_088_5620
    dw Data_088_562A
    dw Data_088_5634
    dw Data_088_563E
    dw Data_088_5645
    dw Data_088_564F
    dw Data_088_564F
    dw Data_088_564F
    dw Data_088_564F
    dw Data_088_5658
    dw Data_088_5660
    dw Data_088_5669
    dw Data_088_566E
    dw Data_088_5678
    dw Data_088_567F
    dw Data_088_5685
    dw Data_088_568D
    dw Data_088_5697
    dw Data_088_56A0
    dw Data_088_56A9
    dw Data_088_56B3
    dw Data_088_56B8
    dw Data_088_56C0
    dw Data_088_56C9
    dw Data_088_56D2
    dw Data_088_56DC
    dw Data_088_56E6
    dw Data_088_56EC

Data_088_441C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_088_56F6
    dw Data_088_5700
    dw Data_088_5709
    dw Data_088_5712
    dw Data_088_571C
    dw Data_088_5726
    dw Data_088_5730
    dw Data_088_5738
    dw Data_088_5742
    dw Data_088_574C
    dw Data_088_5754
    dw Data_088_575B
    dw Data_088_5764
    dw Data_088_576E
    dw Data_088_5777
    dw Data_088_5781
    dw Data_088_578B
    dw Data_088_5795
    dw Data_088_579C
    dw Data_088_57A4
    dw Data_088_57AE
    dw Data_088_57B8
    dw Data_088_57BF
    dw Data_088_57C8
    dw Data_088_57CF
    dw Data_088_57D8
    dw Data_088_57DF
    dw Data_088_57E5
    dw Data_088_57EF
    dw Data_088_57F8
    dw Data_088_57FF
    dw Data_088_5807
    dw Data_088_580F
    dw Data_088_5819
    dw Data_088_5822
    dw Data_088_5829
    dw Data_088_5832
    dw Data_088_583C
    dw Data_088_5845
    dw Data_088_584D
    dw Data_088_5856
    dw Data_088_585E
    dw Data_088_5868
    dw Data_088_5871
    dw Data_088_587A
    dw Data_088_5884
    dw Data_088_588E
    dw Data_088_5895
    dw Data_088_589F
    dw Data_088_58A9
    dw Data_088_58B3
    dw Data_088_58BD
    dw Data_088_58C7
    dw Data_088_58CE
    dw Data_088_58D8
    dw Data_088_58DF
    dw Data_088_58E8
    dw Data_088_58F0
    dw Data_088_58F8
    dw Data_088_5901
    dw Data_088_590A
    dw Data_088_5914
    dw Data_088_591E
    dw Data_088_5927
    dw Data_088_592F
    dw Data_088_5937
    dw Data_088_5940
    dw Data_088_5949
    dw Data_088_5953
    dw Data_088_595C
    dw Data_088_5966
    dw Data_088_5970
    dw Data_088_597A
    dw Data_088_5981
    dw Data_088_5986
    dw Data_088_598F
    dw Data_088_5994
    dw Data_088_599D
    dw Data_088_59A7
    dw Data_088_59B1
    dw Data_088_59BB
    dw Data_088_59C5
    dw Data_088_59CF
    dw Data_088_59D7
    dw Data_088_59E0
    dw Data_088_59E9
    dw Data_088_59F3
    dw Data_088_59FA
    dw Data_088_5A02
    dw Data_088_5A0A
    dw Data_088_5A12
    dw Data_088_5A1B
    dw Data_088_5A24
    dw Data_088_5A2E
    dw Data_088_5A36
    dw Data_088_5A3E
    dw Data_088_5A45
    dw Data_088_5A4B
    dw Data_088_5A54
    dw Data_088_5A5E
    dw Data_088_5A67
    dw Data_088_5A70
    dw Data_088_5A79
    dw Data_088_5A83
    dw Data_088_5A8D
    dw Data_088_5A97
    dw Data_088_5AA0
    dw Data_088_5AA8
    dw Data_088_5AB0
    dw Data_088_5AB9
    dw Data_088_5AC2
    dw Data_088_5ACA
    dw Data_088_5AD3
    dw Data_088_5ADA
    dw Data_088_5AE3
    dw Data_088_5AED
    dw Data_088_5AF6
    dw Data_088_5AFF
    dw Data_088_5B08
    dw Data_088_5B12
    dw Data_088_5B19
    dw Data_088_5B21
    dw Data_088_5B2B
    dw Data_088_5B31
    dw Data_088_5B31
    dw Data_088_5B3B
    dw Data_088_5B45
    dw Data_088_5B4C
    dw Data_088_5B52
    dw Data_088_5B5C
    dw Data_088_5B64
    dw Data_088_5B69
    dw Data_088_5B73
    dw Data_088_5B7B
    dw Data_088_5B85
    dw Data_088_5B8C
    dw Data_088_5B8C
    dw Data_088_5B96
    dw Data_088_5B9C
    dw Data_088_5B9C
    dw Data_088_5B9C
    dw Data_088_5BA6
    dw Data_088_5BB0
    dw Data_088_5BB0
    dw Data_088_5BBA
    dw Data_088_5BC0
    dw Data_088_5BCA
    dw Data_088_5BD4
    dw Data_088_5BDE
    dw Data_088_5BE8
    dw Data_088_5BF0
    dw Data_088_5BFA
    dw Data_088_5C03
    dw Data_088_5C0A
    dw Data_088_5C13
    dw Data_088_5C1B
    dw Data_088_5C23
    dw Data_088_5C2B
    dw Data_088_5C33
    dw Data_088_5C3C
    dw Data_088_5C44
    dw Data_088_5C4E
    dw Data_088_5C56
    dw Data_088_5C60
    dw Data_088_5C69
    dw Data_088_5C73
    dw Data_088_5C7D
    dw Data_088_5C87
    dw Data_088_5C90
    dw Data_088_5C98
    dw Data_088_5CA1
    dw Data_088_5CA8
    dw Data_088_5CB1
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7
    dw Data_088_5CB7

Data_088_461C:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $31, $28, $F0

Data_088_4621:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_088_4627:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $32, $37, $1C, $2F, $2C, $30, $28, $F0

Data_088_4631:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $26, $37, $2C, $0B, $24, $2F, $2F, $F0

Data_088_463B:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2C, $2F, $0E, $24, $37, $28, $35, $F0

Data_088_4645:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $36, $37, $33, $28, $31, $37, $F0

Data_088_464F:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $0C, $32, $25, $35, $24, $F0

Data_088_4659:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $35, $36, $28, $15, $24, $30, $33, $F0

Data_088_4663:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_088_4669:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $37, $25, $28, $24, $35, $F0

Data_088_4671:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $2E, $3C, $F0

Data_088_4678:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2A, $2A, $33, $2F, $24, $37, $32, $31, $F0

Data_088_4682:: ; heuristic: target of a monotone pointer table; C0
    db $13, $28, $3A, $28, $2F, $0B, $24, $2A, $F0

Data_088_468B:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $2E, $F0

Data_088_4690:: ; heuristic: target of a monotone pointer table; C0
    db $20, $3C, $39, $28, $35, $31, $F0

Data_088_4697:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $3C, $0A, $31, $37, $F0

Data_088_469F:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $10, $32, $33, $2B, $28, $35, $F0

Data_088_46A9:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0E, $3C, $28, $0C, $2F, $32, $3A, $31, $F0

Data_088_46B3:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $2C, $2F, $3C, $F0

Data_088_46BA:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $2C, $36, $32, $31, $2A, $32, $31, $F0

Data_088_46C4:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $35, $24, $3C, $F0

Data_088_46CA:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3C, $28, $27, $28, $35, $F0

Data_088_46D1:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $37, $35, $28, $0F, $2C, $36, $2B, $F0

Data_088_46DB:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $30, $24, $31, $2C, $24, $31, $F0

Data_088_46E4:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $F0

Data_088_46ED:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $32, $27, $1C, $34, $38, $2C, $27, $F0

Data_088_46F7:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $33, $37, $0D, $28, $24, $27, $F0

Data_088_4700:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $37, $2C, $37, $28, $28, $2F, $F0

Data_088_4709:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $37, $1B, $24, $39, $28, $31, $F0

Data_088_4712:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $35, $30, $24, $31, $F0

Data_088_4719:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $2E, $2C, $27, $F0

Data_088_4721:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $2A, $38, $28, $20, $24, $39, $28, $F0

Data_088_472B:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $24, $35, $2F, $10, $28, $2F, $F0

Data_088_4734:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $35, $37, $35, $24, $2A, $32, $31, $F0

Data_088_473E:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $34, $38, $24, $11, $24, $3A, $2E, $F0

Data_088_4747:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $0E, $3C, $28, $F0

Data_088_474F:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $3C, $10, $2C, $2A, $24, $36, $F0

Data_088_4758:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $20, $24, $31, $27, $F0

Data_088_4761:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $17, $2C, $37, $28, $F0

Data_088_476B:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $3D, $24, $35, $27, $16, $24, $31, $F0

Data_088_4775:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $30, $30, $28, $35, $16, $24, $31, $F0

Data_088_477F:: ; heuristic: target of a monotone pointer table; C0
    db $22, $28, $37, $2C, $F0

Data_088_4784:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $26, $F0

Data_088_4788:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $36, $30, $32, $F0

Data_088_478E:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $32, $2F, $2F, $F0

Data_088_4794:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $32, $33, $2C, $F0

Data_088_479A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $30, $30, $3C, $F0

Data_088_47A0:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $28, $28, $0B, $32, $3C, $F0

Data_088_47A8:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $30, $25, $0C, $35, $24, $2A, $F0

Data_088_47B1:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $2A, $38, $28, $17, $2C, $37, $28, $F0

Data_088_47BB:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $2C, $3D, $3D, $2F, $3C, $F0

Data_088_47C3:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $2C, $37, $28, $F0

Data_088_47CC:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $2F, $33, $33, $2F, $28, $F0

Data_088_47D4:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $3B, $0F, $2C, $35, $28, $F0

Data_088_47DC:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $30, $2C, $35, $24, $2D, $F0

Data_088_47E4:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $31, $27, $18, $3A, $2F, $F0

Data_088_47EC:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $24, $37, $28, $2A, $32, $31, $F0

Data_088_47F5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $26, $26, $28, $35, $F0

Data_088_47FC:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_088_4806:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $2F, $2F, $0B, $2C, $35, $27, $F0

Data_088_480F:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $24, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_4819:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $35, $29, $2C, $36, $2B, $F0

Data_088_4822:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $24, $11, $32, $35, $36, $28, $F0

Data_088_482B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $31, $0E, $24, $37, $28, $35, $F0

Data_088_4834:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $38, $25, $0B, $2C, $35, $27, $F0

Data_088_483D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $24, $31, $37, $16, $32, $37, $2B, $F0

Data_088_4847:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $24, $37, $11, $32, $35, $31, $F0

Data_088_4850:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_088_485A:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $26, $2E, $1C, $2F, $2C, $30, $28, $F0

Data_088_4864:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $1B, $24, $39, $28, $31, $F0

Data_088_486D:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $30, $3C, $38, $F0

Data_088_4872:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $32, $35, $24, $16, $24, $31, $F0

Data_088_487B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $38, $35, $33, $28, $35, $32, $31, $F0

Data_088_4885:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $F0

Data_088_488E:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_4898:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $32, $31, $F0

Data_088_489F:: ; heuristic: target of a monotone pointer table; C0
    db $12, $35, $32, $31, $1D, $38, $35, $37, $F0

Data_088_48A8:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $16, $2C, $35, $35, $32, $35, $F0

Data_088_48B2:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $25, $35, $28, $16, $24, $31, $F0

Data_088_48BB:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $0B, $28, $24, $36, $37, $F0

Data_088_48C5:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $16, $24, $31, $37, $2C, $36, $F0

Data_088_48CF:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2B, $32, $28, $31, $2C, $3B, $F0

Data_088_48D7:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $20, $28, $28, $27, $F0

Data_088_48E0:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $2F, $27, $0A, $33, $28, $F0

Data_088_48E8:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $30, $25, $2C, $35, $24, $F0

Data_088_48F0:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $2F, $3D, $28, $25, $38, $25, $F0

Data_088_48F9:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $3C, $F0

Data_088_4900:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2B, $32, $36, $1D, $35, $28, $28, $F0

Data_088_4909:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $25, $25, $2F, $28, $F0

Data_088_4910:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $32, $31, $28, $3B, $F0

Data_088_4917:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $10, $32, $32, $36, $28, $F0

Data_088_4920:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $25, $25, $2F, $28, $30, $32, $31, $F0

Data_088_492A:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $2A, $24, $31, $37, $28, $36, $F0

Data_088_4933:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3B, $24, $38, $26, $28, $35, $36, $F0

Data_088_493C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $27, $17, $2C, $37, $28, $F0

Data_088_4945:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $37, $28, $10, $38, $24, $35, $27, $F0

Data_088_494F:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $1C, $33, $2C, $35, $2C, $37, $F0

Data_088_4959:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_088_4961:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $37, $28, $35, $2C, $26, $2B, $F0

Data_088_496A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $27, $35, $28, $24, $2F, $F0

Data_088_4972:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $14, $31, $2C, $2A, $2B, $37, $F0

Data_088_497C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_4986:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $2C, $2F, $0B, $2C, $35, $27, $F0

Data_088_498F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $32, $35, $19, $28, $27, $28, $F0

Data_088_4999:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $11, $32, $35, $31, $28, $37, $F0

Data_088_49A3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $27, $32, $38, $F0

Data_088_49A9:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $0A, $35, $30, $32, $35, $F0

Data_088_49B3:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $28, $2F, $28, $37, $32, $35, $F0

Data_088_49BC:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $30, $33, $2C, $35, $38, $36, $F0

Data_088_49C5:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $32, $35, $24, $2D, $24, $3C, $F0

Data_088_49CE:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $36, $36, $1D, $35, $32, $2F, $2F, $F0

Data_088_49D8:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $33, $0C, $2F, $32, $3A, $31, $F0

Data_088_49E2:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $36, $37, $3C, $20, $2C, $31, $2A, $F0

Data_088_49EC:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $28, $31, $37, $24, $36, $24, $38, $35, $F0

Data_088_49F6:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $2A, $24, $0D, $35, $24, $26, $32, $F0

Data_088_4A00:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $35, $38, $27, $2C, $24, $31, $F0

Data_088_4A09:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $30, $2C, $26, $F0

Data_088_4A0F:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $37, $36, $38, $F0

Data_088_4A15:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $24, $2A, $32, $F0

Data_088_4A1B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $30, $36, $2C, $F0

Data_088_4A21:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $3D, $32, $32, $F0

Data_088_4A27:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_4A30:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $25, $25, $2F, $28, $F0

Data_088_4A37:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $24, $35, $2F, $10, $28, $2F, $F0

Data_088_4A40:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $F0

Data_088_4A49:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $38, $36, $2B, $28, $24, $27, $F0

Data_088_4A52:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $2E, $3C, $F0

Data_088_4A59:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $1B, $24, $39, $28, $31, $F0

Data_088_4A62:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $37, $28, $11, $24, $3A, $2E, $F0

Data_088_4A6B:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $0B, $28, $24, $36, $37, $F0

Data_088_4A75:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $36, $30, $32, $F0

Data_088_4A7B:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $30, $19, $32, $30, $0B, $32, $30, $F0

Data_088_4A85:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $39, $2C, $33, $2C, $31, $28, $F0

Data_088_4A8E:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $2F, $33, $33, $2F, $28, $F0

Data_088_4A96:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2A, $2A, $33, $2F, $24, $37, $32, $31, $F0

Data_088_4AA0:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $30, $30, $28, $35, $16, $24, $31, $F0

Data_088_4AAA:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $38, $25, $36, $38, $26, $2E, $F0

Data_088_4AB3:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $28, $28, $0B, $32, $3C, $F0

Data_088_4ABB:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $32, $11, $28, $35, $32, $F0

Data_088_4AC3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $30, $30, $32, $31, $2D, $24, $F0

Data_088_4ACC:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $3C, $2A, $32, $31, $F0

Data_088_4AD3:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $35, $25, $16, $24, $31, $F0

Data_088_4ADB:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $1F, $28, $2A, $2C, $F0

Data_088_4AE5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $27, $0D, $32, $2F, $2F, $F0

Data_088_4AED:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_088_4AF4:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0C, $32, $31, $27, $32, $35, $F0

Data_088_4AFE:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $32, $38, $27, $14, $2C, $31, $2A, $F0

Data_088_4B08:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $35, $28, $24, $26, $2B, $F0

Data_088_4B12:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $2A, $32, $31, $F0

Data_088_4B1A:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $1C, $34, $38, $2C, $27, $F0

Data_088_4B24:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $36, $37, $3C, $20, $2C, $31, $2A, $F0

Data_088_4B2E:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_088_4B36:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $37, $28, $20, $2B, $2C, $33, $F0

Data_088_4B3F:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $32, $33, $2C, $F0

Data_088_4B45:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $35, $39, $24, $31, $37, $F0

Data_088_4B4D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $3C, $0C, $35, $24, $25, $F0

Data_088_4B56:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $0C, $35, $24, $25, $F0

Data_088_4B5F:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $32, $26, $2B, $2C, $F0

Data_088_4B66:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $35, $33, $28, $31, $37, $2C, $24, $F0

Data_088_4B70:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $2A, $24, $0D, $35, $24, $26, $32, $F0

Data_088_4B7A:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $15, $28, $32, $F0

Data_088_4B82:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3D, $38, $35, $2C, $2F, $28, $F0

Data_088_4B8A:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $39, $2C, $31, $28, $2A, $32, $31, $F0

Data_088_4B94:: ; heuristic: target of a monotone pointer table; C0
    db $19, $37, $28, $35, $24, $31, $32, $27, $F0

Data_088_4B9D:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $0B, $28, $24, $36, $37, $F0

Data_088_4BA7:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $2C, $35, $3C, $1B, $24, $37, $F0

Data_088_4BB0:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $2A, $0E, $3C, $28, $F0

Data_088_4BB7:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $2F, $2F, $0B, $2C, $35, $27, $F0

Data_088_4BC0:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $28, $28, $0B, $32, $3C, $F0

Data_088_4BC8:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $11, $32, $33, $33, $28, $35, $F0

Data_088_4BD1:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $0B, $28, $24, $36, $37, $F0

Data_088_4BDB:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $27, $35, $32, $31, $F0

Data_088_4BE2:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $24, $33, $28, $35, $F0

Data_088_4BE9:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $30, $30, $3C, $F0

Data_088_4BEF:: ; heuristic: target of a monotone pointer table; C0
    db $13, $28, $3A, $28, $2F, $0B, $24, $2A, $F0

Data_088_4BF8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $35, $29, $2C, $36, $2B, $F0

Data_088_4C01:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $38, $36, $2B, $28, $24, $27, $F0

Data_088_4C0A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $27, $0D, $32, $2F, $2F, $F0

Data_088_4C12:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $38, $36, $2B, $0F, $2C, $36, $2B, $F0

Data_088_4C1B:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_088_4C25:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $2C, $36, $32, $31, $2A, $32, $31, $F0

Data_088_4C2F:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $3C, $2A, $32, $31, $F0

Data_088_4C36:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $37, $0F, $2F, $3C, $F0

Data_088_4C3D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $30, $30, $32, $31, $2D, $24, $F0

Data_088_4C46:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $2C, $3D, $3D, $2F, $3C, $F0

Data_088_4C4E:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $24, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_4C58:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $26, $2E, $3C, $F0

Data_088_4C5E:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $3B, $3C, $F0

Data_088_4C63:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_4C6B:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $2E, $F0

Data_088_4C70:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $16, $28, $35, $2A, $28, $F0

Data_088_4C7A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $F0

Data_088_4C83:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $32, $33, $2C, $F0

Data_088_4C89:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $2E, $2C, $27, $F0

Data_088_4C91:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $31, $26, $28, $35, $16, $24, $31, $F0

Data_088_4C9B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $17, $2C, $37, $28, $F0

Data_088_4CA5:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $25, $25, $2F, $28, $F0

Data_088_4CAC:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $3C, $25, $38, $35, $31, $F0

Data_088_4CB4:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $37, $16, $24, $2A, $28, $F0

Data_088_4CBC:: ; heuristic: target of a monotone pointer table; C0
    db $22, $28, $37, $2C, $F0

Data_088_4CC1:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $39, $28, $35, $31, $F0

Data_088_4CC9:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $32, $35, $24, $2D, $24, $3C, $F0

Data_088_4CD2:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $24, $27, $36, $37, $32, $32, $2F, $F0

Data_088_4CDC:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $24, $31, $37, $16, $32, $37, $2B, $F0

Data_088_4CE6:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $3C, $0C, $35, $24, $25, $F0

Data_088_4CEF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $11, $32, $35, $31, $28, $37, $F0

Data_088_4CF9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $2C, $37, $28, $F0

Data_088_4D02:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0E, $3C, $28, $0C, $2F, $32, $3A, $31, $F0

Data_088_4D0C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $27, $17, $2C, $37, $28, $F0

Data_088_4D15:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $36, $30, $32, $F0

Data_088_4D1B:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $2A, $32, $31, $F0

Data_088_4D23:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $2C, $2F, $3C, $F0

Data_088_4D2A:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $3B, $1C, $2F, $2C, $30, $28, $F0

Data_088_4D33:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $30, $33, $2C, $35, $38, $36, $F0

Data_088_4D3C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $2F, $35, $32, $32, $F0

Data_088_4D45:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $2F, $2F, $0B, $2C, $35, $27, $F0

Data_088_4D4E:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $1F, $28, $2A, $2C, $F0

Data_088_4D58:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $2A, $0B, $38, $2A, $F0

Data_088_4D60:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $32, $35, $19, $28, $27, $28, $F0

Data_088_4D6A:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $37, $24, $33, $2C, $2F, $24, $F0

Data_088_4D73:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $0E, $3C, $28, $F0

Data_088_4D7B:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $30, $2F, $2C, $31, $F0

Data_088_4D83:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $27, $38, $36, $24, $0E, $3C, $28, $F0

Data_088_4D8D:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $0A, $35, $30, $32, $35, $F0

Data_088_4D97:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $16, $2C, $35, $35, $32, $35, $F0

Data_088_4DA1:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $2A, $38, $28, $17, $2C, $37, $28, $F0

Data_088_4DAB:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $30, $25, $2C, $35, $24, $F0

Data_088_4DB3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $3C, $F0

Data_088_4DBA:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $2E, $28, $0B, $24, $37, $F0

Data_088_4DC3:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $2F, $33, $0B, $28, $24, $36, $37, $F0

Data_088_4DCD:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $10, $32, $33, $2B, $28, $35, $F0

Data_088_4DD7:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $36, $37, $3C, $20, $2C, $31, $2A, $F0

Data_088_4DE1:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $31, $27, $18, $3A, $2F, $F0

Data_088_4DE9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $39, $2C, $33, $2C, $31, $28, $F0

Data_088_4DF2:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $2F, $3D, $28, $25, $38, $25, $F0

Data_088_4DFB:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $32, $11, $28, $35, $32, $F0

Data_088_4E03:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $25, $25, $2F, $28, $30, $32, $31, $F0

Data_088_4E0D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $24, $37, $11, $32, $35, $31, $F0

Data_088_4E16:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $32, $32, $2E, $3C, $F0

Data_088_4E1D:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $37, $35, $28, $19, $38, $33, $F0

Data_088_4E26:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_088_4E2E:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $0D, $35, $24, $2E, $F0

Data_088_4E38:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $3C, $10, $2C, $2A, $24, $36, $F0

Data_088_4E41:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $24, $35, $2F, $10, $28, $2F, $F0

Data_088_4E4A:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $36, $2A, $32, $31, $F0

Data_088_4E51:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $32, $31, $F0

Data_088_4E58:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $35, $32, $3A, $0D, $32, $2A, $F0

Data_088_4E61:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $37, $28, $11, $24, $3A, $2E, $F0

Data_088_4E6A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $38, $25, $0B, $2C, $35, $27, $F0

Data_088_4E73:: ; heuristic: target of a monotone pointer table; C0
    db $23, $24, $33, $0B, $2C, $35, $27, $F0

Data_088_4E7B:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $28, $27, $0B, $38, $2A, $F0

Data_088_4E83:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $33, $36, $3C, $F0

Data_088_4E89:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $2F, $37, $2C, $0E, $3C, $28, $36, $F0

Data_088_4E93:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_088_4E9A:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $33, $37, $0D, $28, $24, $27, $F0

Data_088_4EA3:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $35, $36, $28, $15, $24, $30, $33, $F0

Data_088_4EAD:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $2A, $2F, $28, $35, $32, $31, $F0

Data_088_4EB6:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $30, $24, $31, $2C, $24, $31, $F0

Data_088_4EBF:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $24, $2F, $28, $16, $24, $2A, $28, $F0

Data_088_4EC9:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $32, $37, $14, $2C, $31, $2A, $F0

Data_088_4ED2:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_4EDC:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $31, $2A, $38, $28, $2F, $2F, $24, $F0

Data_088_4EE6:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $26, $26, $28, $35, $F0

Data_088_4EED:: ; heuristic: target of a monotone pointer table; C0
    db $20, $3C, $39, $28, $35, $31, $F0

Data_088_4EF4:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $34, $38, $24, $11, $24, $3A, $2E, $F0

Data_088_4EFD:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $35, $38, $27, $2C, $24, $31, $F0

Data_088_4F06:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3C, $28, $27, $28, $35, $F0

Data_088_4F0D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $26, $0D, $28, $30, $32, $31, $F0

Data_088_4F16:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $32, $31, $28, $3B, $F0

Data_088_4F1D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $37, $28, $10, $38, $24, $35, $27, $F0

Data_088_4F27:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $28, $31, $37, $24, $36, $24, $38, $35, $F0

Data_088_4F31:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $F0

Data_088_4F3A:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2A, $2A, $33, $2F, $24, $37, $32, $31, $F0

Data_088_4F44:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $24, $3A, $36, $37, $28, $35, $F0

Data_088_4F4D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $35, $1D, $2C, $2A, $28, $35, $F0

Data_088_4F56:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $28, $28, $1C, $2F, $2C, $30, $28, $F0

Data_088_4F60:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $32, $35, $27, $2A, $32, $31, $F0

Data_088_4F69:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $33, $28, $35, $1D, $28, $31, $F0

Data_088_4F72:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $30, $30, $28, $35, $16, $24, $31, $F0

Data_088_4F7C:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $24, $37, $28, $2A, $32, $31, $F0

Data_088_4F85:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $2E, $3C, $F0

Data_088_4F8C:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $37, $35, $28, $0F, $2C, $36, $2B, $F0

Data_088_4F96:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $30, $25, $28, $35, $20, $28, $28, $27, $F0

Data_088_4FA0:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $16, $24, $31, $37, $2C, $36, $F0

Data_088_4FAA:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $26, $F0

Data_088_4FAE:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $33, $0C, $2F, $32, $3A, $31, $F0

Data_088_4FB8:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $30, $30, $3C, $F0

Data_088_4FBE:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $1C, $33, $2C, $35, $2C, $37, $F0

Data_088_4FC8:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $30, $19, $32, $30, $0B, $32, $30, $F0

Data_088_4FD2:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $30, $25, $0C, $35, $24, $2A, $F0

Data_088_4FDB:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $35, $24, $2C, $27, $F0

Data_088_4FE4:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $27, $35, $28, $24, $2F, $F0

Data_088_4FEC:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $24, $37, $0D, $35, $24, $2E, $F0

Data_088_4FF6:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $38, $30, $33, $28, $37, $28, $35, $F0

Data_088_5000:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $37, $32, $16, $28, $26, $2B, $F0

Data_088_500A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $32, $35, $33, $2C, $32, $31, $F0

Data_088_5014:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $2A, $36, $37, $28, $35, $F0

Data_088_501C:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $36, $36, $1D, $35, $32, $2F, $2F, $F0

Data_088_5026:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $14, $31, $2C, $2A, $2B, $37, $F0

Data_088_5030:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2A, $35, $28, $F0

Data_088_5035:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $27, $17, $32, $25, $2F, $28, $F0

Data_088_503F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $28, $2F, $28, $37, $32, $35, $F0

Data_088_5048:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_088_5051:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $36, $2B, $1B, $2C, $27, $28, $35, $F0

Data_088_505B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3B, $28, $1C, $2B, $24, $35, $2E, $F0

Data_088_5064:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $34, $38, $24, $27, $32, $31, $F0

Data_088_506C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $2A, $32, $31, $2A, $F0

Data_088_5073:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $14, $2C, $31, $2A, $F0

Data_088_507D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $35, $33, $28, $31, $37, $2C, $24, $F0

Data_088_5087:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $24, $37, $32, $2F, $F0

Data_088_508E:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $32, $26, $2B, $2C, $F0

Data_088_5095:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $37, $37, $2F, $28, $1B, $28, $3B, $F0

Data_088_509F:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $33, $0B, $2C, $35, $27, $F0

Data_088_50A8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $31, $37, $24, $2E, $F0

Data_088_50B0:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $36, $28, $39, $2C, $31, $28, $F0

Data_088_50B9:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $31, $27, $24, $2F, $F0

Data_088_50C1:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2E, $38, $25, $24, $35, $F0

Data_088_50C8:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $30, $2C, $35, $38, $36, $F0

Data_088_50D0:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $30, $33, $10, $28, $31, $2C, $28, $F0

Data_088_50DA:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $37, $28, $14, $2C, $31, $2A, $F0

Data_088_50E4:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $37, $28, $35, $2C, $26, $2B, $F0

Data_088_50ED:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $1C, $34, $38, $2C, $27, $F0

Data_088_50F7:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $24, $2E, $32, $36, $F0

Data_088_50FE:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $24, $25, $25, $2C, $37, $F0

Data_088_5106:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $2C, $2F, $0B, $2C, $35, $27, $F0

Data_088_510F:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $2C, $35, $3C, $0D, $35, $24, $2E, $F0

Data_088_5119:: ; heuristic: target of a monotone pointer table; C0
    db $18, $31, $2C, $32, $31, $32, $F0

Data_088_5120:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $1C, $28, $28, $27, $F0

Data_088_5129:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0C, $24, $31, $27, $2F, $28, $F0

Data_088_5133:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $32, $31, $14, $2C, $27, $F0

Data_088_513D:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $26, $2E, $14, $2C, $37, $28, $F0

Data_088_5146:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $2A, $1D, $35, $28, $28, $F0

Data_088_514F:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $24, $31, $37, $1C, $2F, $38, $2A, $F0

Data_088_5159:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $33, $2B, $28, $26, $24, $27, $24, $F0

Data_088_5163:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $37, $1B, $24, $39, $28, $31, $F0

Data_088_516C:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $30, $28, $2F, $2A, $32, $31, $F0

Data_088_5176:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $19, $28, $26, $2E, $28, $35, $F0

Data_088_5180:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $19, $2F, $24, $31, $37, $F0

Data_088_5189:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $26, $28, $1D, $35, $28, $28, $F0

Data_088_5192:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $31, $16, $24, $31, $F0

Data_088_519A:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $37, $24, $33, $2C, $2F, $24, $F0

Data_088_51A3:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $26, $28, $35, $F0

Data_088_51A9:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $32, $32, $27, $32, $2F, $2F, $F0

Data_088_51B1:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $28, $30, $F0

Data_088_51B7:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $2A, $38, $28, $20, $24, $39, $28, $F0

Data_088_51C1:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $3B, $1C, $2F, $2C, $30, $28, $F0

Data_088_51CA:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $0B, $32, $35, $2A, $F0

Data_088_51D4:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $11, $32, $35, $31, $F0

Data_088_51DD:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $31, $0E, $24, $37, $28, $35, $F0

Data_088_51E6:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $33, $33, $28, $35, $F0

Data_088_51EE:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2B, $32, $36, $1D, $35, $28, $28, $F0

Data_088_51F7:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $1B, $2C, $27, $28, $35, $F0

Data_088_5201:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $2A, $24, $31, $37, $28, $36, $F0

Data_088_520A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $33, $28, $31, $37, $F0

Data_088_5213:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $34, $38, $24, $35, $28, $2F, $2F, $24, $F0

Data_088_521D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $1C, $2F, $2C, $30, $28, $F0

Data_088_5227:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $24, $31, $1C, $2F, $2C, $30, $28, $F0

Data_088_5231:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $39, $2C, $31, $28, $2A, $32, $31, $F0

Data_088_523B:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $15, $28, $32, $F0

Data_088_5243:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $31, $11, $24, $3A, $2E, $F0

Data_088_524C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $35, $35, $24, $31, $F0

Data_088_5253:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $3D, $24, $30, $24, $31, $38, $36, $F0

Data_088_525D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $10, $32, $2F, $28, $30, $F0

Data_088_5267:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $2F, $2F, $32, $3A, $1B, $24, $37, $F0

Data_088_5271:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $32, $35, $19, $28, $27, $28, $F0

Data_088_527B:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $2F, $27, $0A, $33, $28, $F0

Data_088_5283:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $24, $3A, $36, $37, $28, $35, $F0

Data_088_528C:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $2F, $33, $33, $2F, $28, $F0

Data_088_5294:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $26, $2E, $F0

Data_088_529A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0C, $24, $37, $F0

Data_088_52A1:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $31, $0B, $28, $28, $37, $F0

Data_088_52AA:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_52B4:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $2A, $32, $31, $F0

Data_088_52BC:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $35, $39, $24, $31, $37, $F0

Data_088_52C4:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $26, $2E, $F0

Data_088_52CA:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $24, $31, $37, $20, $32, $35, $30, $F0

Data_088_52D4:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $32, $32, $2E, $3C, $F0

Data_088_52DB:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $39, $28, $35, $31, $F0

Data_088_52E3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0C, $24, $31, $27, $2F, $28, $F0

Data_088_52ED:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $F0

Data_088_52F6:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $28, $30, $32, $31, $F0

Data_088_52FD:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $35, $32, $3A, $0D, $32, $2A, $F0

Data_088_5306:: ; heuristic: target of a monotone pointer table; C0
    db $19, $3C, $38, $35, $32, $F0

Data_088_530C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $1F, $28, $2A, $2C, $F0

Data_088_5316:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $38, $36, $2B, $28, $24, $27, $F0

Data_088_531F:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $31, $2C, $0D, $35, $24, $2E, $F0

Data_088_5328:: ; heuristic: target of a monotone pointer table; C0
    db $19, $37, $28, $35, $24, $31, $32, $27, $F0

Data_088_5331:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $32, $31, $14, $2C, $27, $F0

Data_088_533B:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $37, $0F, $2F, $3C, $F0

Data_088_5342:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $31, $28, $1C, $2F, $24, $39, $28, $F0

Data_088_534C:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $1C, $34, $38, $2C, $27, $F0

Data_088_5356:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $17, $2C, $37, $28, $F0

Data_088_5360:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $3C, $2A, $32, $31, $F0

Data_088_5367:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $30, $33, $32, $2C, $36, $28, $F0

Data_088_5370:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $36, $2B, $1B, $2C, $27, $28, $35, $F0

Data_088_537A:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $2F, $35, $38, $36, $16, $24, $31, $F0

Data_088_5384:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $38, $25, $36, $38, $26, $2E, $F0

Data_088_538D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_088_5394:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $2A, $1D, $35, $28, $28, $F0

Data_088_539D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_53A5:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $33, $33, $28, $37, $32, $35, $F0

Data_088_53AE:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $26, $0D, $28, $30, $32, $31, $F0

Data_088_53B7:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $24, $37, $11, $32, $35, $31, $F0

Data_088_53C0:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $0D, $35, $24, $2E, $F0

Data_088_53CA:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_53D2:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $33, $33, $28, $37, $32, $35, $F0

Data_088_53DB:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $28, $30, $F0

Data_088_53E1:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $2F, $1C, $28, $28, $27, $F0

Data_088_53EA:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3C, $28, $0B, $24, $2F, $2F, $F0

Data_088_53F2:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $30, $28, $2F, $2A, $32, $31, $F0

Data_088_53FC:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $32, $11, $28, $35, $32, $F0

Data_088_5404:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $3B, $1C, $2F, $2C, $30, $28, $F0

Data_088_540D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $25, $25, $2F, $28, $F0

Data_088_5416:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $2C, $35, $3C, $1B, $24, $37, $F0

Data_088_541F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $32, $35, $27, $2A, $32, $31, $F0

Data_088_5428:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $30, $30, $32, $31, $2D, $24, $F0

Data_088_5431:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $37, $28, $11, $24, $3A, $2E, $F0

Data_088_543A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0C, $32, $31, $27, $32, $35, $F0

Data_088_5444:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $2A, $1C, $31, $24, $2E, $28, $F0

Data_088_544E:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $24, $37, $0D, $35, $24, $2E, $F0

Data_088_5458:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $1C, $34, $38, $2C, $27, $F0

Data_088_5462:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $0B, $28, $24, $36, $37, $F0

Data_088_546C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $10, $32, $32, $36, $28, $F0

Data_088_5475:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $24, $2F, $28, $16, $24, $2A, $28, $F0

Data_088_547F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $24, $11, $32, $35, $36, $28, $F0

Data_088_5488:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $35, $28, $24, $26, $2B, $F0

Data_088_5492:: ; heuristic: target of a monotone pointer table; C0
    db $12, $26, $28, $16, $24, $31, $F0

Data_088_5499:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_088_54A0:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $2A, $0E, $3C, $28, $F0

Data_088_54A7:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $2F, $3D, $24, $2E, $F0

Data_088_54AE:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $37, $1B, $24, $39, $28, $31, $F0

Data_088_54B7:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $30, $2C, $35, $38, $36, $F0

Data_088_54BF:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_54C9:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $30, $2F, $2C, $31, $F0

Data_088_54D1:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $36, $37, $33, $28, $31, $37, $F0

Data_088_54DB:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $32, $37, $14, $2C, $31, $2A, $F0

Data_088_54E4:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $2F, $33, $33, $2F, $28, $F0

Data_088_54EC:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $2C, $35, $3C, $0D, $35, $24, $2E, $F0

Data_088_54F6:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $26, $2E, $14, $2C, $37, $28, $F0

Data_088_54FF:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $38, $31, $2E, $3C, $0B, $2C, $35, $27, $F0

Data_088_5509:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $1F, $28, $2A, $2C, $F0

Data_088_5513:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $38, $35, $33, $28, $35, $32, $31, $F0

Data_088_551D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $19, $2F, $24, $31, $37, $F0

Data_088_5526:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $26, $F0

Data_088_552A:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $37, $35, $28, $19, $38, $33, $F0

Data_088_5533:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $39, $2C, $33, $2C, $31, $28, $F0

Data_088_553C:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $28, $30, $32, $31, $F0

Data_088_5543:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $35, $25, $16, $24, $31, $F0

Data_088_554B:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_088_5555:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $24, $37, $32, $2F, $F0

Data_088_555C:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $31, $2A, $1C, $2F, $2C, $30, $28, $F0

Data_088_5566:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $2C, $3D, $3D, $2F, $3C, $F0

Data_088_556E:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $17, $2C, $37, $28, $F0

Data_088_5578:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $2F, $28, $35, $F0

Data_088_557F:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $31, $2C, $26, $32, $35, $31, $F0

Data_088_5587:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $33, $28, $35, $1D, $28, $31, $F0

Data_088_5590:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_088_5596:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $26, $2E, $1C, $2F, $2C, $30, $28, $F0

Data_088_55A0:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $25, $25, $2F, $28, $F0

Data_088_55A9:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $35, $24, $2A, $32, $F0

Data_088_55B0:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $24, $25, $25, $2C, $37, $F0

Data_088_55B8:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $2F, $37, $2C, $0E, $3C, $28, $36, $F0

Data_088_55C2:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $2C, $35, $3C, $1B, $24, $37, $F0

Data_088_55CB:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $38, $25, $36, $38, $26, $2E, $F0

Data_088_55D4:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $19, $2F, $24, $31, $37, $F0

Data_088_55DD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $33, $33, $28, $35, $F0

Data_088_55E5:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $31, $27, $24, $2F, $F0

Data_088_55ED:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $11, $32, $33, $33, $28, $35, $F0

Data_088_55F6:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $35, $32, $3A, $0D, $32, $2A, $F0

Data_088_55FF:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $2A, $0B, $38, $2A, $F0

Data_088_5607:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $20, $28, $28, $27, $F0

Data_088_5610:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2A, $0D, $28, $39, $2C, $2F, $F0

Data_088_5618:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $2C, $3D, $3D, $2F, $3C, $F0

Data_088_5620:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $1B, $2C, $27, $28, $35, $F0

Data_088_562A:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $2F, $35, $38, $36, $16, $24, $31, $F0

Data_088_5634:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0C, $24, $31, $27, $2F, $28, $F0

Data_088_563E:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $24, $33, $28, $35, $F0

Data_088_5645:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $37, $32, $16, $28, $26, $2B, $F0

Data_088_564F:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $F0

Data_088_5658:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $37, $16, $24, $2A, $28, $F0

Data_088_5660:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $26, $28, $1D, $35, $28, $28, $F0

Data_088_5669:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2A, $35, $28, $F0

Data_088_566E:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $35, $36, $28, $15, $24, $30, $33, $F0

Data_088_5678:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $28, $30, $32, $31, $F0

Data_088_567F:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $33, $36, $3C, $F0

Data_088_5685:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $28, $27, $0B, $38, $2A, $F0

Data_088_568D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $2C, $2E, $28, $35, $32, $38, $36, $F0

Data_088_5697:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $2F, $2A, $32, $31, $F0

Data_088_56A0:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $33, $28, $31, $37, $F0

Data_088_56A9:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $37, $37, $28, $35, $29, $2F, $3C, $F0

Data_088_56B3:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $3B, $3C, $F0

Data_088_56B8:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_088_56C0:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_088_56C9:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $33, $0B, $2C, $35, $27, $F0

Data_088_56D2:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $30, $28, $1C, $2F, $2C, $30, $28, $F0

Data_088_56DC:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $31, $2A, $38, $28, $2F, $2F, $24, $F0

Data_088_56E6:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $28, $30, $F0

Data_088_56EC:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $25, $25, $2F, $28, $30, $32, $31, $F0

Data_088_56F6:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $2A, $38, $28, $17, $2C, $37, $28, $F0

Data_088_5700:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $33, $33, $28, $37, $32, $35, $F0

Data_088_5709:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3B, $24, $38, $26, $28, $35, $36, $F0

Data_088_5712:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $24, $2F, $28, $16, $24, $2A, $28, $F0

Data_088_571C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $27, $38, $36, $24, $0E, $3C, $28, $F0

Data_088_5726:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $14, $2C, $31, $2A, $F0

Data_088_5730:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $15, $28, $32, $F0

Data_088_5738:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $10, $32, $2F, $28, $30, $F0

Data_088_5742:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $24, $37, $0D, $35, $24, $2E, $F0

Data_088_574C:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $24, $25, $32, $38, $F0

Data_088_5754:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $35, $35, $24, $31, $F0

Data_088_575B:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $2C, $37, $28, $F0

Data_088_5764:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $36, $36, $1D, $35, $32, $2F, $2F, $F0

Data_088_576E:: ; heuristic: target of a monotone pointer table; C0
    db $13, $28, $3A, $28, $2F, $0B, $24, $2A, $F0

Data_088_5777:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $31, $28, $1C, $2F, $24, $39, $28, $F0

Data_088_5781:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $27, $17, $32, $25, $2F, $28, $F0

Data_088_578B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $2A, $38, $28, $17, $2C, $37, $28, $F0

Data_088_5795:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $2F, $3D, $24, $2E, $F0

Data_088_579C:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $32, $32, $27, $32, $2F, $2F, $F0

Data_088_57A4:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $37, $28, $10, $38, $24, $35, $27, $F0

Data_088_57AE:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $16, $2C, $35, $35, $32, $35, $F0

Data_088_57B8:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $24, $2E, $32, $36, $F0

Data_088_57BF:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $26, $24, $2F, $2F, $32, $33, $24, $F0

Data_088_57C8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $2C, $2F, $3C, $F0

Data_088_57CF:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $24, $3A, $36, $37, $28, $35, $F0

Data_088_57D8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $27, $32, $3A, $F0

Data_088_57DF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $30, $2C, $26, $F0

Data_088_57E5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $14, $2C, $31, $2A, $F0

Data_088_57EF:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $31, $11, $24, $3A, $2E, $F0

Data_088_57F8:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $24, $37, $32, $2F, $F0

Data_088_57FF:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2B, $32, $28, $31, $2C, $3B, $F0

Data_088_5807:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $31, $37, $24, $2E, $F0

Data_088_580F:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $2C, $3D, $3D, $24, $35, $27, $3C, $F0

Data_088_5819:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $2F, $2A, $32, $31, $F0

Data_088_5822:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2E, $38, $25, $24, $35, $F0

Data_088_5829:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $11, $32, $35, $31, $F0

Data_088_5832:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $35, $33, $28, $31, $37, $2C, $24, $F0

Data_088_583C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $33, $28, $35, $1D, $28, $31, $F0

Data_088_5845:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $31, $2C, $26, $32, $35, $31, $F0

Data_088_584D:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $37, $28, $11, $24, $3A, $2E, $F0

Data_088_5856:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $3B, $0F, $2C, $35, $28, $F0

Data_088_585E:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $0D, $35, $24, $2E, $F0

Data_088_5868:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3B, $28, $1C, $2B, $24, $35, $2E, $F0

Data_088_5871:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_088_587A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $27, $38, $36, $24, $0E, $3C, $28, $F0

Data_088_5884:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $11, $32, $35, $31, $28, $37, $F0

Data_088_588E:: ; heuristic: target of a monotone pointer table; C0
    db $18, $31, $2C, $32, $31, $32, $F0

Data_088_5895:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2C, $2F, $0E, $24, $37, $28, $35, $F0

Data_088_589F:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $17, $2C, $37, $28, $F0

Data_088_58A9:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $30, $28, $1C, $2F, $2C, $30, $28, $F0

Data_088_58B3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0D, $35, $24, $2A, $32, $31, $F0

Data_088_58BD:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $2A, $1C, $31, $24, $2E, $28, $F0

Data_088_58C7:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $32, $26, $2B, $2C, $F0

Data_088_58CE:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $38, $30, $33, $28, $37, $28, $35, $F0

Data_088_58D8:: ; heuristic: target of a monotone pointer table; C0
    db $20, $3C, $39, $28, $35, $31, $F0

Data_088_58DF:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $39, $2C, $33, $2C, $31, $28, $F0

Data_088_58E8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $33, $33, $28, $35, $F0

Data_088_58F0:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $2A, $0B, $38, $2A, $F0

Data_088_58F8:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $3C, $0C, $35, $24, $25, $F0

Data_088_5901:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $26, $0D, $28, $30, $32, $31, $F0

Data_088_590A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0E, $3C, $28, $0C, $2F, $32, $3A, $31, $F0

Data_088_5914:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $14, $31, $2C, $2A, $2B, $37, $F0

Data_088_591E:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $33, $37, $0D, $28, $24, $27, $F0

Data_088_5927:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $35, $39, $24, $31, $37, $F0

Data_088_592F:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $39, $24, $16, $24, $31, $F0

Data_088_5937:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $30, $25, $0C, $35, $24, $2A, $F0

Data_088_5940:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $38, $36, $2B, $0F, $2C, $36, $2B, $F0

Data_088_5949:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $24, $2F, $28, $16, $24, $2A, $28, $F0

Data_088_5953:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $32, $37, $14, $2C, $31, $2A, $F0

Data_088_595C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $0B, $32, $35, $2A, $F0

Data_088_5966:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $3D, $24, $35, $27, $16, $24, $31, $F0

Data_088_5970:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $24, $37, $0D, $35, $24, $2E, $F0

Data_088_597A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $0C, $24, $37, $F0

Data_088_5981:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $30, $3C, $38, $F0

Data_088_5986:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $31, $0B, $28, $28, $37, $F0

Data_088_598F:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2A, $35, $28, $F0

Data_088_5994:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $37, $35, $28, $19, $38, $33, $F0

Data_088_599D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $02, $F0

Data_088_59A7:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $10, $32, $2F, $28, $30, $F0

Data_088_59B1:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $37, $28, $14, $2C, $31, $2A, $F0

Data_088_59BB:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $1C, $2F, $2C, $30, $28, $F0

Data_088_59C5:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $39, $2C, $31, $28, $2A, $32, $31, $F0

Data_088_59CF:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $31, $2A, $15, $28, $32, $F0

Data_088_59D7:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $31, $11, $24, $3A, $2E, $F0

Data_088_59E0:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $36, $28, $39, $2C, $31, $28, $F0

Data_088_59E9:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $30, $32, $35, $33, $2C, $32, $31, $F0

Data_088_59F3:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $35, $35, $24, $31, $F0

Data_088_59FA:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $34, $38, $24, $27, $32, $31, $F0

Data_088_5A02:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $38, $25, $32, $38, $F0

Data_088_5A0A:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $37, $2C, $25, $32, $38, $F0

Data_088_5A12:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $28, $2F, $28, $37, $32, $35, $F0

Data_088_5A1B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_088_5A24:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $38, $31, $2E, $3C, $0B, $2C, $35, $27, $F0

Data_088_5A2E:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $33, $3C, $26, $24, $37, $F0

Data_088_5A36:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $27, $35, $28, $24, $2F, $F0

Data_088_5A3E:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $3C, $2A, $32, $31, $F0

Data_088_5A45:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $37, $26, $2B, $F0

Data_088_5A4B:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $30, $33, $32, $2C, $36, $28, $F0

Data_088_5A54:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $35, $27, $0D, $35, $24, $26, $32, $F0

Data_088_5A5E:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $35, $26, $0D, $28, $30, $32, $31, $F0

Data_088_5A67:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $33, $0B, $2C, $35, $27, $F0

Data_088_5A70:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $31, $28, $16, $24, $31, $F0

Data_088_5A79:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $27, $17, $32, $25, $2F, $28, $F0

Data_088_5A83:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $24, $2F, $14, $2C, $31, $2A, $F0

Data_088_5A8D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $35, $33, $28, $31, $37, $2C, $24, $F0

Data_088_5A97:: ; heuristic: target of a monotone pointer table; C0
    db $12, $35, $32, $31, $1D, $38, $35, $37, $F0

Data_088_5AA0:: ; heuristic: target of a monotone pointer table; C0
    db $23, $24, $33, $0B, $2C, $35, $27, $F0

Data_088_5AA8:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $32, $11, $28, $35, $32, $F0

Data_088_5AB0:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $24, $37, $11, $32, $35, $31, $F0

Data_088_5AB9:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $39, $28, $35, $3D, $32, $31, $F0

Data_088_5AC2:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $32, $32, $27, $32, $2F, $2F, $F0

Data_088_5ACA:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3B, $28, $1C, $2B, $24, $35, $2E, $F0

Data_088_5AD3:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $2A, $32, $31, $2A, $F0

Data_088_5ADA:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $32, $35, $27, $2A, $32, $31, $F0

Data_088_5AE3:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $2A, $24, $0D, $35, $24, $26, $32, $F0

Data_088_5AED:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $33, $28, $35, $1D, $28, $31, $F0

Data_088_5AF6:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $2A, $1B, $32, $32, $36, $37, $F0

Data_088_5AFF:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2B, $32, $36, $1D, $35, $28, $28, $F0

Data_088_5B08:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $16, $24, $31, $37, $2C, $36, $F0

Data_088_5B12:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $2F, $28, $35, $F0

Data_088_5B19:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $2A, $28, $25, $32, $38, $F0

Data_088_5B21:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $30, $28, $31, $36, $24, $38, $35, $F0

Data_088_5B2B:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $30, $2C, $24, $F0

Data_088_5B31:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $15, $32, $35, $27, $F0

Data_088_5B3B:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $35, $27, $0D, $35, $24, $26, $32, $F0

Data_088_5B45:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $35, $2A, $32, $31, $F0

Data_088_5B4C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $27, $32, $2B, $F0

Data_088_5B52:: ; heuristic: target of a monotone pointer table; C0
    db $10, $28, $31, $32, $36, $2C, $27, $32, $2B, $F0

Data_088_5B5C:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $35, $24, $30, $32, $36, $F0

Data_088_5B64:: ; heuristic: target of a monotone pointer table; C0
    db $23, $32, $30, $24, $F0

Data_088_5B69:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $36, $38, $35, $24, $23, $32, $30, $24, $F0

Data_088_5B73:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $3D, $3D, $24, $35, $32, $F0

Data_088_5B7B:: ; heuristic: target of a monotone pointer table; C0
    db $19, $36, $3C, $26, $2B, $32, $19, $2C, $3D, $F0

Data_088_5B85:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $36, $37, $28, $35, $2E, $F0

Data_088_5B8C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $35, $38, $27, $35, $24, $24, $36, $F0

Data_088_5B96:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $27, $32, $38, $F0

Data_088_5B9C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $37, $2B, $16, $32, $35, $28, $F0

Data_088_5BA6:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $27, $35, $2C, $38, $30, $F0

Data_088_5BB0:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $2A, $32, $27, $28, $30, $2C, $35, $F0

Data_088_5BBA:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $26, $2E, $F0

Data_088_5BC0:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $2F, $32, $1C, $2F, $2C, $30, $28, $F0

Data_088_5BCA:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $1C, $2F, $2C, $30, $28, $F0

Data_088_5BD4:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $24, $31, $1C, $2F, $2C, $30, $28, $F0

Data_088_5BDE:: ; heuristic: target of a monotone pointer table; C0
    db $20, $32, $31, $27, $28, $35, $0E, $2A, $2A, $F0

Data_088_5BE8:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $2F, $2C, $2A, $32, $31, $F0

Data_088_5BF0:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $2A, $24, $0D, $35, $24, $26, $32, $F0

Data_088_5BFA:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $11, $32, $35, $31, $F0

Data_088_5C03:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $35, $24, $2A, $32, $F0

Data_088_5C0A:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $31, $11, $24, $3A, $2E, $F0

Data_088_5C13:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3D, $38, $35, $2C, $2F, $28, $F0

Data_088_5C1B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $31, $37, $24, $2E, $F0

Data_088_5C23:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $24, $25, $32, $38, $F0

Data_088_5C2B:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $38, $25, $32, $38, $F0

Data_088_5C33:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2A, $27, $35, $24, $26, $2C, $2F, $F0

Data_088_5C3C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $2A, $36, $37, $28, $35, $F0

Data_088_5C44:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $38, $2F, $24, $35, $24, $26, $2B, $F0

Data_088_5C4E:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2C, $37, $24, $31, $2C, $36, $F0

Data_088_5C56:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $30, $33, $10, $28, $31, $2C, $28, $F0

Data_088_5C60:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $37, $28, $35, $2C, $26, $2B, $F0

Data_088_5C69:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $37, $28, $14, $2C, $31, $2A, $F0

Data_088_5C73:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $3D, $24, $30, $24, $31, $38, $36, $F0

Data_088_5C7D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $10, $32, $2F, $28, $30, $F0

Data_088_5C87:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $2E, $16, $24, $37, $28, $F0

Data_088_5C90:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $2A, $32, $31, $F0

Data_088_5C98:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $37, $32, $35, $24, $2C, $27, $F0

Data_088_5CA1:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $24, $2E, $32, $36, $F0

Data_088_5CA8:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $36, $28, $2C, $27, $32, $31, $F0

Data_088_5CB1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_088_5CB7:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $31, $27, $28, $29, $2C, $31, $28, $27, $F0, $30, $28, $F0, $1E, $31, $27
    db $28, $29, $2C, $31, $28, $27, $F0
    ds $2332, $00
