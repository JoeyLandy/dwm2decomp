SECTION "Bank 68", ROMX[$4000], BANK[$68]
    db $68

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup44::
Data_068_4001:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_6693
    dfar Data_065_6736
    dfar Data_065_76ED
    dfar Data_062_75B0
    dfar Data_062_5337
    dfar Data_065_431E
    dfar Data_062_6F90
    dfar Data_062_7626
    dfar Data_064_4734
    dfar Data_063_47D4
    dfar Data_062_528E
    dfar Data_064_7848
    dfar Data_063_6DB3
    dfar Data_062_42B3
    dfar Data_064_46A7
    dfar Data_066_5A5F
    dfar Data_065_6B2C
    dfar Data_065_6B50
    dfar Data_065_7B11
    dfar Data_062_7B66
    dfar Data_062_573B
    dfar Data_065_46BF
    dfar Data_062_73E8
    dfar Data_062_7B96
    dfar Data_064_4B1E
    dfar Data_063_4B70
    dfar Data_062_56FE
    dfar Data_064_7DFB
    dfar Data_063_722B
    dfar Data_062_4967
    dfar Data_064_4AD9
    dfar Data_066_5658 ; id 1
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_5E8C
    dfar Data_062_6E33
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_064_5A34
    dfar Data_065_416D
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_063_6636
    dfar Data_064_5218
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_5AE7
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_6301
    dfar Data_062_737B
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_064_5E47
    dfar Data_065_4643
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_063_69E0
    dfar Data_064_56B0
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 2
    dfar Data_064_7A7D
    dfar Data_066_478E
    dfar Data_063_6E4E
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_774A
    dfar Data_066_5CC8
    dfar Data_066_5705
    dfar Data_065_6736
    dfar Data_065_5F42
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_066_4BC0
    dfar Data_063_7250
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7BFD
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_065_6B50
    dfar Data_065_634B
    dfar Data_063_60DA ; id 3
    dfar Data_064_544D
    dfar Data_062_6EDC
    dfar Data_065_751D
    dfar Data_063_6148
    dfar Data_062_68C2
    dfar Data_065_41F0
    dfar Data_065_6D65
    dfar Data_064_4843
    dfar Data_063_6744
    dfar Data_064_5284
    dfar Data_065_6D0D
    dfar Data_062_5485
    dfar Data_062_613E
    dfar Data_063_468C
    dfar Data_065_6C81
    dfar Data_063_63CF
    dfar Data_064_5794
    dfar Data_062_73A7
    dfar Data_065_7A80
    dfar Data_063_63FE
    dfar Data_062_6BF7
    dfar Data_065_4662
    dfar Data_065_7290
    dfar Data_064_4B88
    dfar Data_063_6A61
    dfar Data_064_56E0
    dfar Data_065_7279
    dfar Data_062_57A2
    dfar Data_062_64F0
    dfar Data_063_4AF5
    dfar Data_065_7251
    dfar Data_066_5560 ; id 4
    dfar Data_065_5DD4
    dfar Data_062_5337
    dfar Data_064_5A34
    dfar Data_062_7626
    dfar Data_062_41C9
    dfar Data_063_5F99
    dfar Data_064_6145
    dfar Data_064_78B1
    dfar Data_063_6D0B
    dfar Data_064_4734
    dfar Data_063_472D
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_066_46C5
    dfar Data_066_478E
    dfar Data_066_5A87
    dfar Data_065_62D2
    dfar Data_062_573B
    dfar Data_064_5E47
    dfar Data_062_7B96
    dfar Data_062_492F
    dfar Data_063_633B
    dfar Data_064_6509
    dfar Data_064_7E22
    dfar Data_063_71F3
    dfar Data_064_4B1E
    dfar Data_063_4B25
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_066_4B6F
    dfar Data_066_4BC0
    dfar Data_065_5737 ; id 5
    dfar Data_064_5394
    dfar Data_064_6797
    dfar Data_066_4D7D
    dfar Data_063_5437
    dfar Data_063_47D4
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_064_697E
    dfar Data_066_478E
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_5A75
    dfar Data_064_5742
    dfar Data_064_6D09
    dfar Data_066_52C5
    dfar Data_063_57D1
    dfar Data_063_4B70
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_064_6D86
    dfar Data_066_4BC0
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_5366
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup44Order::
Data_068_4241:: ; heuristic: start of a structured table; C0
    db $04, $05, $03, $02, $00, $01 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup45::
Data_068_4247:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5560 ; id 0
    dfar Data_065_6546
    dfar Data_065_64CA
    dfar Data_065_6808
    dfar Data_062_7626
    dfar Data_062_40EE
    dfar Data_062_43CA
    dfar Data_062_4365
    dfar Data_062_75B0
    dfar Data_062_41C9
    dfar Data_064_6AEC
    dfar Data_066_4859
    dfar Data_064_78B1
    dfar Data_066_4917
    dfar Data_064_73B7
    dfar Data_065_77A4
    dfar Data_066_5A87
    dfar Data_065_6AC6
    dfar Data_065_6A8F
    dfar Data_065_6B9F
    dfar Data_062_7B96
    dfar Data_062_48DA
    dfar Data_062_49C6
    dfar Data_062_49AA
    dfar Data_062_7B66
    dfar Data_062_492F
    dfar Data_064_6DFE
    dfar Data_066_4C04
    dfar Data_064_7E22
    dfar Data_066_4C37
    dfar Data_064_7730
    dfar Data_065_7B60
    dfar Data_065_751D ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_6F90
    dfar Data_065_743F
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_46C5
    dfar Data_066_4CD6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_73E8
    dfar Data_065_7A30
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_4B6F
    dfar Data_066_52A0
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 2
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_064_720E
    dfar Data_066_5CC8
    dfar Data_066_589C
    dfar Data_065_68B7
    dfar Data_065_5F42
    dfar Data_066_589C
    dfar Data_065_5C71
    dfar Data_062_4365
    dfar Data_064_697E
    dfar Data_062_76AE
    dfar Data_064_6797
    dfar Data_066_478E
    dfar Data_066_4F98
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_064_76A3
    dfar Data_066_615D
    dfar Data_066_5B97
    dfar Data_065_6BD1
    dfar Data_065_634B
    dfar Data_066_5B97
    dfar Data_065_6244
    dfar Data_062_49AA
    dfar Data_064_6D86
    dfar Data_062_7BC5
    dfar Data_064_6D09
    dfar Data_066_4BC0
    dfar Data_066_5366
    dfar Data_065_6693 ; id 3
    dfar Data_065_5D1D
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_062_423A
    dfar Data_062_41C9
    dfar Data_065_6C81
    dfar Data_066_5CC8
    dfar Data_066_45B4
    dfar Data_063_6D0B
    dfar Data_062_6E33
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_062_76AE
    dfar Data_062_40EE
    dfar Data_065_6D65
    dfar Data_065_6B2C
    dfar Data_065_6293
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_062_494B
    dfar Data_062_492F
    dfar Data_065_7251
    dfar Data_066_615D
    dfar Data_066_4B1A
    dfar Data_063_71F3
    dfar Data_062_737B
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_062_7BC5
    dfar Data_062_48DA
    dfar Data_065_7290
    dfar Data_062_76AE ; id 4
    dfar Data_062_6D6B
    dfar Data_065_751D
    dfar Data_066_5658
    dfar Data_062_7626
    dfar Data_062_406A
    dfar Data_065_6DE3
    dfar Data_064_79CF
    dfar Data_064_7848
    dfar Data_063_6BCD
    dfar Data_062_6EDC
    dfar Data_065_6736
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_066_45B4
    dfar Data_066_478E
    dfar Data_062_7BC5
    dfar Data_062_732E
    dfar Data_065_7A80
    dfar Data_066_5AE7
    dfar Data_062_7B96
    dfar Data_062_48C0
    dfar Data_065_72B2
    dfar Data_064_7E84
    dfar Data_064_7DFB
    dfar Data_063_7181
    dfar Data_062_73A7
    dfar Data_065_6B50
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_066_4B1A
    dfar Data_066_4BC0
    dfar Data_065_75A3 ; id 5
    dfar Data_064_7945
    dfar Data_063_6C79
    dfar Data_065_6D0D
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_065_6D65
    dfar Data_065_6693
    dfar Data_065_6546
    dfar Data_063_74A4
    dfar Data_066_4D7D
    dfar Data_066_46C5
    dfar Data_066_45B4
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_065_7AAA
    dfar Data_064_7E51
    dfar Data_063_71D4
    dfar Data_065_7279
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_065_7290
    dfar Data_065_6B2C
    dfar Data_065_6AC6
    dfar Data_063_7ADE
    dfar Data_066_52C5
    dfar Data_066_4B6F
    dfar Data_066_4B1A
    dfar Data_066_52E9
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup45Order::
Data_068_4487:: ; heuristic: start of a structured table; C0
    db $00, $02, $01, $03, $04, $05 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup46::
Data_068_448D:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5658
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_5E8C
    dfar Data_062_6E33
    dfar Data_065_75A3
    dfar Data_062_774A
    dfar Data_064_68E4
    dfar Data_066_45B4
    dfar Data_066_4E6E
    dfar Data_062_77EB
    dfar Data_065_6F70
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6301
    dfar Data_062_737B
    dfar Data_065_7AAA
    dfar Data_062_7BFD
    dfar Data_064_6D64
    dfar Data_066_4B1A
    dfar Data_066_5311
    dfar Data_062_7C25
    dfar Data_065_7334
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5705
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_062_702C
    dfar Data_065_76ED
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_062_7409
    dfar Data_065_7B11
    dfar Data_064_7848 ; id 2
    dfar Data_064_73B7
    dfar Data_065_743F
    dfar Data_066_5CC8
    dfar Data_066_5560
    dfar Data_065_5FE5
    dfar Data_062_6D6B
    dfar Data_065_77A4
    dfar Data_062_76AE
    dfar Data_062_41C9
    dfar Data_064_6797
    dfar Data_066_4F98
    dfar Data_062_774A
    dfar Data_062_42B3
    dfar Data_065_6DE3
    dfar Data_066_5658
    dfar Data_064_7DFB
    dfar Data_064_7730
    dfar Data_065_7A30
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_6391
    dfar Data_062_732E
    dfar Data_065_7B60
    dfar Data_062_7BC5
    dfar Data_062_492F
    dfar Data_064_6D09
    dfar Data_066_5366
    dfar Data_062_7BFD
    dfar Data_062_4967
    dfar Data_065_72B2
    dfar Data_066_5AE7
    dfar Data_066_5CC8 ; id 3
    dfar Data_064_7B56
    dfar Data_063_6DB3
    dfar Data_065_6D65
    dfar Data_066_589C
    dfar Data_065_6808
    dfar Data_065_5E8C
    dfar Data_065_6DE3
    dfar Data_062_7985
    dfar Data_064_6A43
    dfar Data_066_46C5
    dfar Data_066_4E6E
    dfar Data_065_60A2
    dfar Data_062_70C1
    dfar Data_065_65EA
    dfar Data_065_75A3
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_063_722B
    dfar Data_065_7290
    dfar Data_066_5B97
    dfar Data_065_6B9F
    dfar Data_065_6301
    dfar Data_065_72B2
    dfar Data_062_7CBA
    dfar Data_064_6DC8
    dfar Data_066_4B6F
    dfar Data_066_5311
    dfar Data_065_63C6
    dfar Data_062_744A
    dfar Data_065_6AEA
    dfar Data_065_7AAA
    dfar Data_064_7848 ; id 4
    dfar Data_063_6C79
    dfar Data_062_6EDC
    dfar Data_065_5DD4
    dfar Data_066_54FD
    dfar Data_065_5D1D
    dfar Data_062_41C9
    dfar Data_062_528E
    dfar Data_064_7848
    dfar Data_066_45B4
    dfar Data_063_6D0B
    dfar Data_064_46A7
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_066_4635
    dfar Data_064_7DFB
    dfar Data_063_71D4
    dfar Data_062_73A7
    dfar Data_065_62D2
    dfar Data_066_5A5F
    dfar Data_065_6293
    dfar Data_062_492F
    dfar Data_062_56FE
    dfar Data_064_7DFB
    dfar Data_066_4B1A
    dfar Data_063_71F3
    dfar Data_064_4AD9
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_066_4B3B
    dfar Data_062_423A ; id 5
    dfar Data_064_6797
    dfar Data_063_6B43
    dfar Data_065_6D0D
    dfar Data_065_41F0
    dfar Data_065_6D0D
    dfar Data_064_7848
    dfar Data_066_4D7D
    dfar Data_063_468C
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_494B
    dfar Data_064_6D09
    dfar Data_063_7151
    dfar Data_065_7279
    dfar Data_065_4662
    dfar Data_065_7279
    dfar Data_064_7DFB
    dfar Data_066_52C5
    dfar Data_063_4AF5
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_4B1A
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup46Order::
Data_068_46CD:: ; heuristic: start of a structured table; C0
    db $05, $04, $03, $02, $01, $00 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup47::
Data_068_46D3:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_065_643F
    dfar Data_066_5CC8
    dfar Data_066_589C
    dfar Data_065_60A2
    dfar Data_062_5209
    dfar Data_066_5560
    dfar Data_065_5D1D
    dfar Data_062_5209
    dfar Data_065_55E2
    dfar Data_062_75B0
    dfar Data_062_40EE
    dfar Data_063_5F99
    dfar Data_064_6272
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_6A71
    dfar Data_066_615D
    dfar Data_066_5B97
    dfar Data_065_63C6
    dfar Data_062_56DF
    dfar Data_066_5A87
    dfar Data_065_6293
    dfar Data_062_56DF
    dfar Data_065_59E9
    dfar Data_062_7B66
    dfar Data_062_48DA
    dfar Data_063_633B
    dfar Data_064_657E
    dfar Data_065_6693 ; id 1
    dfar Data_065_65EA
    dfar Data_065_6808
    dfar Data_065_74B6
    dfar Data_064_5AD4
    dfar Data_064_59BA
    dfar Data_065_416D
    dfar Data_065_6D65
    dfar Data_064_6145
    dfar Data_063_531D
    dfar Data_063_453F
    dfar Data_065_6DE3
    dfar Data_063_47D4
    dfar Data_064_6828
    dfar Data_066_4635
    dfar Data_066_4EF7
    dfar Data_065_6B2C
    dfar Data_065_6AEA
    dfar Data_065_6B9F
    dfar Data_065_7A51
    dfar Data_064_5E8E
    dfar Data_064_5E12
    dfar Data_065_4643
    dfar Data_065_7290
    dfar Data_064_6509
    dfar Data_063_5769
    dfar Data_063_4A65
    dfar Data_065_72B2
    dfar Data_063_4B70
    dfar Data_064_6D28
    dfar Data_066_4B3B
    dfar Data_066_5342
    dfar Data_062_7517 ; id 2
    dfar Data_062_5337
    dfar Data_062_5FBC
    dfar Data_063_4867
    dfar Data_062_75B0
    dfar Data_064_46A7
    dfar Data_065_75A3
    dfar Data_065_43BD
    dfar Data_064_78B1
    dfar Data_063_6C79
    dfar Data_063_5EAF
    dfar Data_064_544D
    dfar Data_066_54FD
    dfar Data_065_5C71
    dfar Data_063_5E57
    dfar Data_064_5394
    dfar Data_062_7B3B
    dfar Data_062_573B
    dfar Data_062_6450
    dfar Data_063_4BB7
    dfar Data_062_7B66
    dfar Data_064_4AD9
    dfar Data_065_7AAA
    dfar Data_065_470B
    dfar Data_064_7E22
    dfar Data_063_71D4
    dfar Data_063_62DE
    dfar Data_064_5794
    dfar Data_066_5A5F
    dfar Data_065_6244
    dfar Data_063_62C3
    dfar Data_064_5742
    dfar Data_062_41C9 ; id 3
    dfar Data_065_6DE3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_40EE
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_6828
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_6D0D
    dfar Data_066_54FD
    dfar Data_065_6693
    dfar Data_065_751D
    dfar Data_062_492F
    dfar Data_065_72B2
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_48DA
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_6D28
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_7279
    dfar Data_066_5A5F
    dfar Data_065_6B2C
    dfar Data_065_7A80
    dfar Data_062_7985 ; id 4
    dfar Data_062_5209
    dfar Data_065_5056
    dfar Data_063_472D
    dfar Data_062_78C0
    dfar Data_063_5E57
    dfar Data_064_6272
    dfar Data_064_68E4
    dfar Data_062_76AE
    dfar Data_064_46A7
    dfar Data_063_4867
    dfar Data_065_7023
    dfar Data_064_7848
    dfar Data_066_478E
    dfar Data_066_4859
    dfar Data_066_505C
    dfar Data_062_7CBA
    dfar Data_062_56DF
    dfar Data_065_5414
    dfar Data_063_4B25
    dfar Data_062_7C82
    dfar Data_063_62C3
    dfar Data_064_657E
    dfar Data_064_6D64
    dfar Data_062_7BC5
    dfar Data_064_4AD9
    dfar Data_063_4BB7
    dfar Data_065_737C
    dfar Data_064_7DFB
    dfar Data_066_4BC0
    dfar Data_066_4C04
    dfar Data_066_53AD
    dfar Data_062_70C1 ; id 5
    dfar Data_065_5FE5
    dfar Data_062_42B3
    dfar Data_065_6D65
    dfar Data_066_4859
    dfar Data_066_4917
    dfar Data_066_478E
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_744A
    dfar Data_065_6391
    dfar Data_062_4967
    dfar Data_065_7290
    dfar Data_066_4C04
    dfar Data_066_4C37
    dfar Data_066_4BC0
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup47Order::
Data_068_4913:: ; heuristic: start of a structured table; C0
    db $01, $00, $02, $03, $05, $04 ; entry 0

; E-0146 (derived: 3 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup48::
Data_068_4919:: ; heuristic: key-world chunk group; C0
    dfar Data_066_55DC ; id 0
    dfar Data_065_6693
    dfar Data_065_64CA
    dfar Data_065_76ED
    dfar Data_062_7626
    dfar Data_062_423A
    dfar Data_062_423A
    dfar Data_062_702C
    dfar Data_064_7848
    dfar Data_063_6DB3
    dfar Data_062_41C9
    dfar Data_064_697E
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_46C5
    dfar Data_066_4F98
    dfar Data_066_5AB9
    dfar Data_065_6B2C
    dfar Data_065_6A8F
    dfar Data_065_7B11
    dfar Data_062_7B96
    dfar Data_062_494B
    dfar Data_062_494B
    dfar Data_062_7409
    dfar Data_064_7DFB
    dfar Data_063_722B
    dfar Data_062_492F
    dfar Data_064_6D86
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_4B6F
    dfar Data_066_5366
    dfar Data_066_5560 ; id 1
    dfar Data_065_7641
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_5E8C
    dfar Data_062_702C
    dfar Data_065_6546
    dfar Data_063_7626
    dfar Data_066_4635
    dfar Data_063_6EFF
    dfar Data_064_6797
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5A87
    dfar Data_065_7AE1
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6301
    dfar Data_062_7409
    dfar Data_065_6AC6
    dfar Data_063_7B4F
    dfar Data_066_4B3B
    dfar Data_063_729A
    dfar Data_064_6D09
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_065_65EA ; id 2
    dfar Data_065_6808
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_063_6DB3
    dfar Data_064_6AEC
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_065_6F70
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7B56
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_6AEA
    dfar Data_065_6B9F
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_063_722B
    dfar Data_064_6DFE
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_065_7334
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup48Order::
Data_068_4A39:: ; heuristic: start of a structured table; C0
    db $00, $01, $02 ; entry 0

; E-0146 (derived: 3 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup49::
Data_068_4A3C:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_6693
    dfar Data_065_77A4
    dfar Data_066_5705
    dfar Data_064_77CC
    dfar Data_063_6E4E
    dfar Data_062_6EDC
    dfar Data_063_7626
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_063_6C79
    dfar Data_062_6EDC
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_066_4546
    dfar Data_066_5A5F
    dfar Data_065_6B2C
    dfar Data_065_7B60
    dfar Data_066_5B0F
    dfar Data_064_7DD4
    dfar Data_063_7250
    dfar Data_062_73A7
    dfar Data_063_7B4F
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_063_71D4
    dfar Data_062_73A7
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_066_4AF5
    dfar Data_065_6546 ; id 1
    dfar Data_065_64CA
    dfar Data_065_6693
    dfar Data_065_7878
    dfar Data_063_6E4E
    dfar Data_062_5337
    dfar Data_065_416D
    dfar Data_062_6EDC
    dfar Data_065_5FE5
    dfar Data_064_48DA
    dfar Data_063_4867
    dfar Data_064_697E
    dfar Data_066_45B4
    dfar Data_066_4635
    dfar Data_066_46C5
    dfar Data_066_4DE4
    dfar Data_065_6AC6
    dfar Data_065_6A8F
    dfar Data_065_6B2C
    dfar Data_065_7B9E
    dfar Data_063_7250
    dfar Data_062_573B
    dfar Data_065_4643
    dfar Data_062_73A7
    dfar Data_065_6391
    dfar Data_064_4BC1
    dfar Data_063_4BB7
    dfar Data_064_6D86
    dfar Data_066_4B1A
    dfar Data_066_4B3B
    dfar Data_066_4B6F
    dfar Data_066_52E9
    dfar Data_066_5705 ; id 2
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_5FE5
    dfar Data_065_6DE3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_4635
    dfar Data_064_720E
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5B0F
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_6391
    dfar Data_065_72B2
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_4B3B
    dfar Data_064_76A3
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_066_52E9
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup49Order::
Data_068_4B5C:: ; heuristic: start of a structured table; C0
    db $02, $01, $00 ; entry 0

; E-0146 (derived: 3 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4A::
Data_068_4B5F:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5658
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_066_5705
    dfar Data_065_5E8C
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_063_6DB3
    dfar Data_062_6E33
    dfar Data_065_68B7
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_45B4
    dfar Data_066_4917
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_065_6301
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_063_722B
    dfar Data_062_737B
    dfar Data_065_6BD1
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_4B1A
    dfar Data_066_4C37
    dfar Data_066_57D9 ; id 1
    dfar Data_065_77A4
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_062_78C0
    dfar Data_062_70C1
    dfar Data_065_75A3
    dfar Data_062_7626
    dfar Data_065_5FE5
    dfar Data_064_6A43
    dfar Data_064_706F
    dfar Data_065_5D1D
    dfar Data_066_4859
    dfar Data_066_505C
    dfar Data_064_7945
    dfar Data_066_45B4
    dfar Data_066_5B5A
    dfar Data_065_7B60
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_062_7C82
    dfar Data_062_744A
    dfar Data_065_7AAA
    dfar Data_062_7B96
    dfar Data_065_6391
    dfar Data_064_6DC8
    dfar Data_064_761D
    dfar Data_065_6293
    dfar Data_066_4C04
    dfar Data_066_53AD
    dfar Data_064_7E51
    dfar Data_066_4B1A
    dfar Data_065_64CA ; id 2
    dfar Data_065_6693
    dfar Data_065_68B7
    dfar Data_065_7878
    dfar Data_062_5209
    dfar Data_064_5AD4
    dfar Data_065_445B
    dfar Data_065_70BD
    dfar Data_064_46A7
    dfar Data_063_54F8
    dfar Data_063_48FA
    dfar Data_065_7023
    dfar Data_066_46C5
    dfar Data_066_4546
    dfar Data_066_4917
    dfar Data_066_5115
    dfar Data_065_6A8F
    dfar Data_065_6B2C
    dfar Data_065_6BD1
    dfar Data_065_7B9E
    dfar Data_062_56DF
    dfar Data_064_5E8E
    dfar Data_065_473E
    dfar Data_065_73A8
    dfar Data_064_4AD9
    dfar Data_063_5822
    dfar Data_063_4BF0
    dfar Data_065_737C
    dfar Data_066_4B6F
    dfar Data_066_4AF5
    dfar Data_066_4C37
    dfar Data_066_53DF

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4AOrder::
Data_068_4C7F:: ; heuristic: start of a structured table; C0
    db $01, $00, $02 ; entry 0

; E-0146 (derived: 3 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4B::
Data_068_4C82:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_64CA
    dfar Data_065_643F
    dfar Data_065_6808
    dfar Data_062_7626
    dfar Data_062_5209
    dfar Data_064_594F
    dfar Data_065_416D
    dfar Data_062_76AE
    dfar Data_064_46A7
    dfar Data_063_531D
    dfar Data_063_468C
    dfar Data_064_79CF
    dfar Data_066_46C5
    dfar Data_066_478E
    dfar Data_066_4546
    dfar Data_066_5A5F
    dfar Data_065_6A8F
    dfar Data_065_6A71
    dfar Data_065_6B9F
    dfar Data_062_7B96
    dfar Data_062_56DF
    dfar Data_064_5DEE
    dfar Data_065_4643
    dfar Data_062_7BC5
    dfar Data_064_4AD9
    dfar Data_063_5769
    dfar Data_063_4AF5
    dfar Data_064_7E84
    dfar Data_066_4B6F
    dfar Data_066_4BC0
    dfar Data_066_4AF5
    dfar Data_065_7878 ; id 1
    dfar Data_066_5560
    dfar Data_065_74B6
    dfar Data_066_589C
    dfar Data_062_6E33
    dfar Data_065_5D1D
    dfar Data_062_6E33
    dfar Data_065_5D1D
    dfar Data_064_6828
    dfar Data_066_4635
    dfar Data_066_4635
    dfar Data_063_6D0B
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_065_7B9E
    dfar Data_066_5A87
    dfar Data_065_7A51
    dfar Data_066_5B97
    dfar Data_062_737B
    dfar Data_065_6293
    dfar Data_062_737B
    dfar Data_065_6293
    dfar Data_064_6D28
    dfar Data_066_4B3B
    dfar Data_066_4B3B
    dfar Data_063_71F3
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_065_6546 ; id 2
    dfar Data_065_7878
    dfar Data_066_57D9
    dfar Data_065_7641
    dfar Data_064_6828
    dfar Data_066_505C
    dfar Data_062_77EB
    dfar Data_065_6DE3
    dfar Data_062_6F90
    dfar Data_065_6736
    dfar Data_065_5E8C
    dfar Data_065_6D65
    dfar Data_066_4859
    dfar Data_066_46C5
    dfar Data_066_4635
    dfar Data_066_4D7D
    dfar Data_065_6AC6
    dfar Data_065_7B9E
    dfar Data_066_5B5A
    dfar Data_065_7AE1
    dfar Data_064_6D28
    dfar Data_066_53AD
    dfar Data_062_7C25
    dfar Data_065_72B2
    dfar Data_062_73E8
    dfar Data_065_6B50
    dfar Data_065_6301
    dfar Data_065_7290
    dfar Data_066_4C04
    dfar Data_066_4B6F
    dfar Data_066_4B3B
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4BOrder::
Data_068_4DA2:: ; heuristic: start of a structured table; C0
    db $02, $00, $01 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4C::
Data_068_4DA5:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_6693
    dfar Data_065_5C71
    dfar Data_066_55DC
    dfar Data_065_5DD4
    dfar Data_062_5337
    dfar Data_064_58E6
    dfar Data_062_7626
    dfar Data_062_40EE
    dfar Data_064_4734
    dfar Data_063_64F3
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6B2C
    dfar Data_065_6244
    dfar Data_066_5AB9
    dfar Data_065_62D2
    dfar Data_062_573B
    dfar Data_064_5DC8
    dfar Data_062_7B96
    dfar Data_062_48DA
    dfar Data_064_4B1E
    dfar Data_063_694D
    dfar Data_065_65EA ; id 1
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_066_57D9
    dfar Data_062_41C9
    dfar Data_065_6F70
    dfar Data_066_5705
    dfar Data_065_5FE5
    dfar Data_065_416D
    dfar Data_062_702C
    dfar Data_065_5F42
    dfar Data_062_4365
    dfar Data_062_662E
    dfar Data_064_5A34
    dfar Data_064_5AD4
    dfar Data_065_43BD
    dfar Data_065_6AEA
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_066_5B5A
    dfar Data_062_492F
    dfar Data_065_7334
    dfar Data_066_5B0F
    dfar Data_065_6391
    dfar Data_065_4643
    dfar Data_062_7409
    dfar Data_065_634B
    dfar Data_062_49AA
    dfar Data_062_6AE8
    dfar Data_064_5E47
    dfar Data_064_5E8E
    dfar Data_065_470B
    dfar Data_065_64CA ; id 2
    dfar Data_065_6546
    dfar Data_065_6546
    dfar Data_065_76ED
    dfar Data_062_5166
    dfar Data_064_594F
    dfar Data_065_41F0
    dfar Data_065_6E8B
    dfar Data_063_5EAF
    dfar Data_064_6073
    dfar Data_063_4867
    dfar Data_065_70BD
    dfar Data_063_5E57
    dfar Data_064_54EA
    dfar Data_064_68E4
    dfar Data_066_505C
    dfar Data_065_6A8F
    dfar Data_065_6AC6
    dfar Data_065_6AC6
    dfar Data_065_7B11
    dfar Data_062_569C
    dfar Data_064_5DEE
    dfar Data_065_4662
    dfar Data_065_72E6
    dfar Data_063_62DE
    dfar Data_064_64A7
    dfar Data_063_4BB7
    dfar Data_065_73A8
    dfar Data_063_62C3
    dfar Data_064_57CD
    dfar Data_064_6D64
    dfar Data_066_53AD
    dfar Data_064_7B56 ; id 3
    dfar Data_063_6BCD
    dfar Data_062_5209
    dfar Data_065_56B8
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_063_5EAF
    dfar Data_064_6145
    dfar Data_066_5CC8
    dfar Data_062_76AE
    dfar Data_064_46A7
    dfar Data_063_44A8
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_4635
    dfar Data_066_4917
    dfar Data_064_7F00
    dfar Data_063_7181
    dfar Data_062_56DF
    dfar Data_065_5A4D
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_063_62DE
    dfar Data_064_6509
    dfar Data_066_615D
    dfar Data_062_7BC5
    dfar Data_064_4AD9
    dfar Data_063_4A36
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_4B3B
    dfar Data_066_4C37
    dfar Data_064_61C5 ; id 4
    dfar Data_063_65BE
    dfar Data_064_6073
    dfar Data_065_4D49
    dfar Data_063_468C
    dfar Data_064_4843
    dfar Data_063_472D
    dfar Data_064_47BD
    dfar Data_064_68E4
    dfar Data_066_4917
    dfar Data_066_4635
    dfar Data_063_6D0B
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_064_6532
    dfar Data_063_69A8
    dfar Data_064_64A7
    dfar Data_065_52C8
    dfar Data_063_4AF5
    dfar Data_064_4B88
    dfar Data_063_4B25
    dfar Data_064_4B43
    dfar Data_064_6D64
    dfar Data_066_4C37
    dfar Data_066_4B3B
    dfar Data_063_71F3
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_065_5587 ; id 5
    dfar Data_064_5218
    dfar Data_062_6EDC
    dfar Data_065_7878
    dfar Data_063_557A
    dfar Data_065_4FAD
    dfar Data_065_416D
    dfar Data_065_70BD
    dfar Data_062_423A
    dfar Data_064_454F
    dfar Data_063_453F
    dfar Data_065_7023
    dfar Data_066_45B4
    dfar Data_066_4859
    dfar Data_066_46C5
    dfar Data_066_5115
    dfar Data_065_59BF
    dfar Data_064_56B0
    dfar Data_062_73A7
    dfar Data_065_7B9E
    dfar Data_063_5855
    dfar Data_065_53BE
    dfar Data_065_4643
    dfar Data_065_73A8
    dfar Data_062_494B
    dfar Data_064_4A58
    dfar Data_063_4A65
    dfar Data_065_737C
    dfar Data_066_4B1A
    dfar Data_066_4C04
    dfar Data_066_4B6F
    dfar Data_066_53DF

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4COrder::
Data_068_4FE5:: ; heuristic: start of a structured table; C0
    db $00, $02, $05, $01, $03, $04 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4D::
Data_068_4FEB:: ; heuristic: key-world chunk group; C0
    dfar Data_066_55DC ; id 0
    dfar Data_065_7641
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_062_6F90
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_063_6DB3
    dfar Data_062_6EDC
    dfar Data_065_6546
    dfar Data_066_5CC8
    dfar Data_062_774A
    dfar Data_062_5166
    dfar Data_065_416D
    dfar Data_066_5AB9
    dfar Data_065_7AE1
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_062_73E8
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_063_722B
    dfar Data_062_73A7
    dfar Data_065_6AC6
    dfar Data_066_615D
    dfar Data_062_7BFD
    dfar Data_062_569C
    dfar Data_065_4643
    dfar Data_066_5705 ; id 1
    dfar Data_065_77A4
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_062_78C0
    dfar Data_062_6E33
    dfar Data_065_6693
    dfar Data_065_5C71
    dfar Data_065_60A2
    dfar Data_062_5166
    dfar Data_064_59BA
    dfar Data_065_40C4
    dfar Data_062_40EE
    dfar Data_064_44CC
    dfar Data_063_52A2
    dfar Data_063_453F
    dfar Data_066_5B0F
    dfar Data_065_7B60
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_062_7C82
    dfar Data_062_737B
    dfar Data_065_6B2C
    dfar Data_065_6244
    dfar Data_065_63C6
    dfar Data_062_569C
    dfar Data_064_5E12
    dfar Data_065_45EE
    dfar Data_062_48DA
    dfar Data_064_4A2C
    dfar Data_063_5744
    dfar Data_063_4A65
    dfar Data_065_6546 ; id 2
    dfar Data_065_6693
    dfar Data_065_65EA
    dfar Data_065_74B6
    dfar Data_062_41C9
    dfar Data_064_68E4
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_064_697E
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_6F90
    dfar Data_065_65EA
    dfar Data_065_6736
    dfar Data_065_751D
    dfar Data_065_6AC6
    dfar Data_065_6B2C
    dfar Data_065_6AEA
    dfar Data_065_7A51
    dfar Data_062_492F
    dfar Data_064_6D64
    dfar Data_066_4B1A
    dfar Data_066_52C5
    dfar Data_064_6D86
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_73E8
    dfar Data_065_6AEA
    dfar Data_065_6B50
    dfar Data_065_7A80
    dfar Data_066_5705 ; id 3
    dfar Data_065_5C71
    dfar Data_064_454F
    dfar Data_063_468C
    dfar Data_062_7985
    dfar Data_062_40EE
    dfar Data_062_40EE
    dfar Data_064_6797
    dfar Data_064_78B1
    dfar Data_066_4859
    dfar Data_063_6C79
    dfar Data_062_6D6B
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_066_46C5
    dfar Data_066_5B0F
    dfar Data_065_6244
    dfar Data_064_4A58
    dfar Data_063_4AF5
    dfar Data_062_7CBA
    dfar Data_062_48DA
    dfar Data_062_48DA
    dfar Data_064_6D09
    dfar Data_064_7E22
    dfar Data_066_4C04
    dfar Data_063_71D4
    dfar Data_062_732E
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_066_4B6F
    dfar Data_064_66F6 ; id 4
    dfar Data_066_4917
    dfar Data_063_6FC0
    dfar Data_062_4365
    dfar Data_066_4D7D
    dfar Data_066_589C
    dfar Data_065_5DD4
    dfar Data_064_697E
    dfar Data_065_74B6
    dfar Data_064_7C14
    dfar Data_066_45B4
    dfar Data_066_4EF7
    dfar Data_066_4CD6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_6CC4
    dfar Data_066_4C37
    dfar Data_063_72C9
    dfar Data_062_49AA
    dfar Data_066_52C5
    dfar Data_066_5B97
    dfar Data_065_62D2
    dfar Data_064_6D86
    dfar Data_065_7A51
    dfar Data_064_7F35
    dfar Data_066_4B1A
    dfar Data_066_5342
    dfar Data_066_52A0
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_406A ; id 5
    dfar Data_062_40EE
    dfar Data_062_40EE
    dfar Data_065_6DE3
    dfar Data_063_6BCD
    dfar Data_064_6797
    dfar Data_066_45B4
    dfar Data_066_4E6E
    dfar Data_062_75B0
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_066_4CD6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_48C0
    dfar Data_062_48DA
    dfar Data_062_48DA
    dfar Data_065_72B2
    dfar Data_063_7181
    dfar Data_064_6D09
    dfar Data_066_4B1A
    dfar Data_066_5311
    dfar Data_062_7B66
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_066_52A0
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4DOrder::
Data_068_522B:: ; heuristic: start of a structured table; C0
    db $05, $02, $01, $04, $03, $00 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4E::
Data_068_5231:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5658 ; id 0
    dfar Data_065_6693
    dfar Data_065_7641
    dfar Data_066_5CC8
    dfar Data_062_774A
    dfar Data_062_423A
    dfar Data_062_6F90
    dfar Data_065_65EA
    dfar Data_064_79CF
    dfar Data_063_6DB3
    dfar Data_062_41C9
    dfar Data_064_6828
    dfar Data_066_5CC8
    dfar Data_062_7517
    dfar Data_064_6828
    dfar Data_066_4E6E
    dfar Data_066_5AE7
    dfar Data_065_6B2C
    dfar Data_065_7AE1
    dfar Data_066_615D
    dfar Data_062_7BFD
    dfar Data_062_494B
    dfar Data_062_73E8
    dfar Data_065_6AEA
    dfar Data_064_7E84
    dfar Data_063_722B
    dfar Data_062_492F
    dfar Data_064_6D28
    dfar Data_066_615D
    dfar Data_062_7B3B
    dfar Data_064_6D28
    dfar Data_066_5311
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_5560
    dfar Data_065_6736
    dfar Data_065_6808
    dfar Data_065_6546
    dfar Data_065_5D1D
    dfar Data_062_406A
    dfar Data_062_5485
    dfar Data_063_6C79
    dfar Data_062_40EE
    dfar Data_062_5166
    dfar Data_065_55E2
    dfar Data_064_78B1
    dfar Data_063_6C79
    dfar Data_064_454F
    dfar Data_063_64F3
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_6B50
    dfar Data_065_6B9F
    dfar Data_065_6AC6
    dfar Data_065_6293
    dfar Data_062_48C0
    dfar Data_062_57A2
    dfar Data_063_71D4
    dfar Data_062_48DA
    dfar Data_062_569C
    dfar Data_065_59E9
    dfar Data_064_7E22
    dfar Data_063_71D4
    dfar Data_064_4A58
    dfar Data_063_694D
    dfar Data_065_64CA ; id 2
    dfar Data_065_5F42
    dfar Data_065_70BD
    dfar Data_066_5CC8
    dfar Data_065_416D
    dfar Data_063_6EFF
    dfar Data_062_70C1
    dfar Data_065_75A3
    dfar Data_064_5284
    dfar Data_062_7985
    dfar Data_062_41C9
    dfar Data_065_6D65
    dfar Data_062_6784
    dfar Data_064_7C14
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_065_6A8F
    dfar Data_065_634B
    dfar Data_065_73A8
    dfar Data_066_615D
    dfar Data_065_4643
    dfar Data_063_729A
    dfar Data_062_744A
    dfar Data_065_7AAA
    dfar Data_064_56E0
    dfar Data_062_7CBA
    dfar Data_062_492F
    dfar Data_065_7290
    dfar Data_062_6B76
    dfar Data_064_7F35
    dfar Data_066_4B1A
    dfar Data_066_52C5
    dfar Data_066_5477 ; id 3
    dfar Data_065_5F42
    dfar Data_065_6F70
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_063_6E4E
    dfar Data_062_702C
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_062_42B3
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_066_478E
    dfar Data_066_4DE4
    dfar Data_066_5A3B
    dfar Data_065_634B
    dfar Data_065_7334
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_063_7250
    dfar Data_062_7409
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_062_4967
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_066_4BC0
    dfar Data_066_52E9
    dfar Data_066_5CC8 ; id 4
    dfar Data_062_76AE
    dfar Data_062_528E
    dfar Data_065_56B8
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_064_44CC
    dfar Data_063_531D
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_063_6D0B
    dfar Data_062_41C9
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_066_4635
    dfar Data_066_615D
    dfar Data_062_7BC5
    dfar Data_062_56FE
    dfar Data_065_5A4D
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_064_4A2C
    dfar Data_063_5769
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_063_71F3
    dfar Data_062_492F
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_066_4B3B
    dfar Data_065_5B98 ; id 5
    dfar Data_062_68C2
    dfar Data_065_4291
    dfar Data_065_6D65
    dfar Data_063_64F3
    dfar Data_064_6272
    dfar Data_063_468C
    dfar Data_065_6D65
    dfar Data_064_48DA
    dfar Data_063_4867
    dfar Data_064_6828
    dfar Data_066_4DE4
    dfar Data_066_4917
    dfar Data_066_4859
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_065_5BBD
    dfar Data_062_6BF7
    dfar Data_065_469B
    dfar Data_065_7290
    dfar Data_063_694D
    dfar Data_064_657E
    dfar Data_063_4AF5
    dfar Data_065_7290
    dfar Data_064_4BC1
    dfar Data_063_4BB7
    dfar Data_064_6D28
    dfar Data_066_52E9
    dfar Data_066_4C37
    dfar Data_066_4C04
    dfar Data_066_53AD
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4EOrder::
Data_068_5471:: ; heuristic: start of a structured table; C0
    db $01, $02, $05, $00, $03, $04 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4F::
Data_068_5477:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5705
    dfar Data_066_5705
    dfar Data_065_65EA
    dfar Data_065_75A3
    dfar Data_062_77EB
    dfar Data_062_774A
    dfar Data_064_6797
    dfar Data_064_7139
    dfar Data_063_76CB
    dfar Data_064_7A7D
    dfar Data_066_4D7D
    dfar Data_062_77EB
    dfar Data_062_702C
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_066_5B0F
    dfar Data_065_6AEA
    dfar Data_065_7AAA
    dfar Data_062_7C25
    dfar Data_062_7BFD
    dfar Data_064_6D09
    dfar Data_064_7661
    dfar Data_063_7B7B
    dfar Data_064_7EB0
    dfar Data_066_52C5
    dfar Data_062_7C25
    dfar Data_062_7409
    dfar Data_065_6736 ; id 1
    dfar Data_065_6736
    dfar Data_065_77A4
    dfar Data_066_57D9
    dfar Data_064_697E
    dfar Data_063_6E4E
    dfar Data_065_6F70
    dfar Data_066_5705
    dfar Data_066_4F98
    dfar Data_062_77EB
    dfar Data_065_7023
    dfar Data_062_77EB
    dfar Data_065_6693
    dfar Data_063_76CB
    dfar Data_066_505C
    dfar Data_062_78C0
    dfar Data_065_6B50
    dfar Data_065_6B50
    dfar Data_065_7B60
    dfar Data_066_5B5A
    dfar Data_064_6D86
    dfar Data_063_7250
    dfar Data_065_7334
    dfar Data_066_5B0F
    dfar Data_066_5366
    dfar Data_062_7C25
    dfar Data_065_737C
    dfar Data_062_7C25
    dfar Data_065_6B2C
    dfar Data_063_7B7B
    dfar Data_066_53AD
    dfar Data_062_7C82
    dfar Data_066_5CC8 ; id 2
    dfar Data_066_5560
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_065_6546
    dfar Data_065_5D1D
    dfar Data_062_6EDC
    dfar Data_065_7641
    dfar Data_062_40EE
    dfar Data_062_41C9
    dfar Data_062_41C9
    dfar Data_065_6E8B
    dfar Data_064_6797
    dfar Data_063_6C79
    dfar Data_062_423A
    dfar Data_065_6D65
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_065_6AC6
    dfar Data_065_6293
    dfar Data_062_73A7
    dfar Data_065_7AE1
    dfar Data_062_48DA
    dfar Data_062_492F
    dfar Data_062_492F
    dfar Data_065_72E6
    dfar Data_064_6D09
    dfar Data_063_71D4
    dfar Data_062_494B
    dfar Data_065_7290
    dfar Data_066_589C ; id 3
    dfar Data_065_68B7
    dfar Data_065_5DD4
    dfar Data_062_406A
    dfar Data_062_7985
    dfar Data_064_6AEC
    dfar Data_063_6EFF
    dfar Data_062_40EE
    dfar Data_064_7C14
    dfar Data_066_5115
    dfar Data_062_7985
    dfar Data_064_6797
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_4DE4
    dfar Data_066_5B97
    dfar Data_065_6BD1
    dfar Data_065_62D2
    dfar Data_062_48C0
    dfar Data_062_7CBA
    dfar Data_064_6DFE
    dfar Data_063_729A
    dfar Data_062_48DA
    dfar Data_064_7F35
    dfar Data_066_53DF
    dfar Data_062_7CBA
    dfar Data_064_6D09
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_52E9
    dfar Data_062_406A ; id 4
    dfar Data_062_6E33
    dfar Data_065_6546
    dfar Data_063_73F8
    dfar Data_062_40EE
    dfar Data_062_41C9
    dfar Data_064_6828
    dfar Data_064_6F23
    dfar Data_063_6BCD
    dfar Data_062_423A
    dfar Data_065_6E8B
    dfar Data_062_75B0
    dfar Data_064_7848
    dfar Data_066_4635
    dfar Data_066_4E6E
    dfar Data_064_7848
    dfar Data_062_48C0
    dfar Data_062_737B
    dfar Data_065_6AC6
    dfar Data_063_7A89
    dfar Data_062_48DA
    dfar Data_062_492F
    dfar Data_064_6D28
    dfar Data_064_75A9
    dfar Data_063_7181
    dfar Data_062_494B
    dfar Data_065_72E6
    dfar Data_062_7B66
    dfar Data_064_7DFB
    dfar Data_066_4B3B
    dfar Data_066_5311
    dfar Data_064_7DFB
    dfar Data_066_4DE4 ; id 5
    dfar Data_064_78B1
    dfar Data_063_6DB3
    dfar Data_065_6F70
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_065_7023
    dfar Data_062_6E33
    dfar Data_065_6546
    dfar Data_063_7793
    dfar Data_066_5115
    dfar Data_066_45B4
    dfar Data_066_4635
    dfar Data_066_5115
    dfar Data_066_5CC8
    dfar Data_066_52E9
    dfar Data_064_7E22
    dfar Data_063_722B
    dfar Data_065_7334
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_065_737C
    dfar Data_062_737B
    dfar Data_065_6AC6
    dfar Data_063_7BD2
    dfar Data_066_53DF
    dfar Data_066_4B1A
    dfar Data_066_4B3B
    dfar Data_066_53DF
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4FOrder::
Data_068_56B7:: ; heuristic: start of a structured table; C0
    db $04, $03, $00, $05, $02, $01 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup50::
Data_068_56BD:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_65EA
    dfar Data_065_6736
    dfar Data_065_75A3
    dfar Data_062_7626
    dfar Data_062_41C9
    dfar Data_062_423A
    dfar Data_062_6E33
    dfar Data_062_76AE
    dfar Data_062_40EE
    dfar Data_062_42B3
    dfar Data_062_41C9
    dfar Data_064_7945
    dfar Data_063_6D0B
    dfar Data_062_53C7
    dfar Data_065_416D
    dfar Data_066_5A5F
    dfar Data_065_6AEA
    dfar Data_065_6B50
    dfar Data_065_7AAA
    dfar Data_062_7B96
    dfar Data_062_492F
    dfar Data_062_494B
    dfar Data_062_737B
    dfar Data_062_7BC5
    dfar Data_062_48DA
    dfar Data_062_4967
    dfar Data_062_492F
    dfar Data_064_7E51
    dfar Data_063_71F3
    dfar Data_062_5761
    dfar Data_065_4643
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_743F
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_774A
    dfar Data_065_6C81
    dfar Data_066_5477
    dfar Data_065_74B6
    dfar Data_062_77EB
    dfar Data_062_6CE1
    dfar Data_065_5BD1
    dfar Data_062_6D6B
    dfar Data_065_5FE5
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_7A30
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7BFD
    dfar Data_065_7251
    dfar Data_066_5A3B
    dfar Data_065_7A51
    dfar Data_062_7C25
    dfar Data_062_7306
    dfar Data_065_6216
    dfar Data_062_732E
    dfar Data_065_6391
    dfar Data_065_64CA ; id 2
    dfar Data_065_68B7
    dfar Data_065_77A4
    dfar Data_066_5CC8
    dfar Data_062_5166
    dfar Data_065_43BD
    dfar Data_062_70C1
    dfar Data_065_751D
    dfar Data_063_5E57
    dfar Data_062_68C2
    dfar Data_065_43BD
    dfar Data_065_6D65
    dfar Data_063_5EAF
    dfar Data_064_6272
    dfar Data_063_4867
    dfar Data_065_6E8B
    dfar Data_065_6A8F
    dfar Data_065_6BD1
    dfar Data_065_7B60
    dfar Data_066_615D
    dfar Data_062_569C
    dfar Data_065_470B
    dfar Data_062_744A
    dfar Data_065_7A80
    dfar Data_063_62C3
    dfar Data_062_6BF7
    dfar Data_065_470B
    dfar Data_065_7290
    dfar Data_063_62DE
    dfar Data_064_657E
    dfar Data_063_4BB7
    dfar Data_065_72E6
    dfar Data_066_5560 ; id 3
    dfar Data_065_5F42
    dfar Data_063_5DED
    dfar Data_062_694C
    dfar Data_064_7848
    dfar Data_063_6DB3
    dfar Data_064_44CC
    dfar Data_063_53B1
    dfar Data_066_5CC8
    dfar Data_064_7B56
    dfar Data_063_6DB3
    dfar Data_064_6828
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_505C
    dfar Data_066_5A87
    dfar Data_065_634B
    dfar Data_063_6298
    dfar Data_062_6C2D
    dfar Data_064_7DFB
    dfar Data_063_722B
    dfar Data_064_4A2C
    dfar Data_063_57AC
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_063_722B
    dfar Data_064_6D28
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_53AD
    dfar Data_064_59BA ; id 4
    dfar Data_065_43BD
    dfar Data_062_53C7
    dfar Data_064_59BA
    dfar Data_063_52A2
    dfar Data_065_4FAD
    dfar Data_065_5587
    dfar Data_064_60D8
    dfar Data_063_6DB3
    dfar Data_064_454F
    dfar Data_063_52A2
    dfar Data_063_468C
    dfar Data_064_77CC
    dfar Data_066_46C5
    dfar Data_066_4917
    dfar Data_066_4635
    dfar Data_064_5E12
    dfar Data_065_470B
    dfar Data_062_5761
    dfar Data_064_5E12
    dfar Data_063_5744
    dfar Data_065_53BE
    dfar Data_065_59BF
    dfar Data_064_64DA
    dfar Data_063_722B
    dfar Data_064_4A58
    dfar Data_063_5744
    dfar Data_063_4AF5
    dfar Data_064_7DD4
    dfar Data_066_4B6F
    dfar Data_066_4C37
    dfar Data_066_4B3B
    dfar Data_062_5E91 ; id 5
    dfar Data_063_453F
    dfar Data_064_697E
    dfar Data_066_4CD6
    dfar Data_063_45E3
    dfar Data_062_406A
    dfar Data_065_6E8B
    dfar Data_066_5CC8
    dfar Data_064_6797
    dfar Data_066_4546
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_63DA
    dfar Data_063_4A65
    dfar Data_064_6D86
    dfar Data_066_52A0
    dfar Data_063_4AB5
    dfar Data_062_48C0
    dfar Data_065_72E6
    dfar Data_066_615D
    dfar Data_064_6D09
    dfar Data_066_4AF5
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup50Order::
Data_068_58FD:: ; heuristic: start of a structured table; C0
    db $01, $02, $05, $00, $03, $04 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup51::
Data_068_5903:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_55DC
    dfar Data_065_65EA
    dfar Data_065_6546
    dfar Data_066_5477
    dfar Data_065_5DD4
    dfar Data_062_41C9
    dfar Data_064_6797
    dfar Data_062_77EB
    dfar Data_064_6828
    dfar Data_066_4635
    dfar Data_066_4DE4
    dfar Data_062_774A
    dfar Data_062_6EDC
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_5AB9
    dfar Data_065_6AEA
    dfar Data_065_6AC6
    dfar Data_066_5A3B
    dfar Data_065_62D2
    dfar Data_062_492F
    dfar Data_064_6D09
    dfar Data_062_7C25
    dfar Data_064_6D28
    dfar Data_066_4B3B
    dfar Data_066_52E9
    dfar Data_062_7BFD
    dfar Data_062_73A7
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_065_68B7 ; id 1
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_4635
    dfar Data_064_6FCF
    dfar Data_065_77A4
    dfar Data_066_57D9
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_062_6E33
    dfar Data_065_5D1D
    dfar Data_066_55DC
    dfar Data_065_5D1D
    dfar Data_062_41C9
    dfar Data_064_6828
    dfar Data_065_6BD1
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_4B3B
    dfar Data_064_75F2
    dfar Data_065_7B60
    dfar Data_066_5B5A
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_062_737B
    dfar Data_065_6293
    dfar Data_066_5AB9
    dfar Data_065_6293
    dfar Data_062_492F
    dfar Data_064_6D28
    dfar Data_066_5CC8 ; id 2
    dfar Data_066_5477
    dfar Data_065_743F
    dfar Data_066_5CC8
    dfar Data_065_6808
    dfar Data_065_5C71
    dfar Data_062_6E33
    dfar Data_065_751D
    dfar Data_062_41C9
    dfar Data_062_406A
    dfar Data_062_40EE
    dfar Data_065_6D65
    dfar Data_066_45B4
    dfar Data_063_6BCD
    dfar Data_064_6797
    dfar Data_066_4DE4
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_7A30
    dfar Data_066_615D
    dfar Data_065_6B9F
    dfar Data_065_6244
    dfar Data_062_737B
    dfar Data_065_7A80
    dfar Data_062_492F
    dfar Data_062_48C0
    dfar Data_062_48DA
    dfar Data_065_7290
    dfar Data_066_4B1A
    dfar Data_063_7181
    dfar Data_064_6D09
    dfar Data_066_52E9
    dfar Data_062_75B0 ; id 3
    dfar Data_064_6659
    dfar Data_064_706F
    dfar Data_065_7641
    dfar Data_062_7626
    dfar Data_065_6E8B
    dfar Data_064_78B1
    dfar Data_066_4E6E
    dfar Data_064_7848
    dfar Data_064_720E
    dfar Data_065_64CA
    dfar Data_065_6736
    dfar Data_066_5CC8
    dfar Data_064_7B56
    dfar Data_066_4546
    dfar Data_066_4859
    dfar Data_062_7B66
    dfar Data_064_6C95
    dfar Data_064_761D
    dfar Data_065_7AE1
    dfar Data_062_7B96
    dfar Data_065_72E6
    dfar Data_064_7E22
    dfar Data_066_5311
    dfar Data_064_7DFB
    dfar Data_064_76A3
    dfar Data_065_6A8F
    dfar Data_065_6B50
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_066_4AF5
    dfar Data_066_4C04
    dfar Data_062_774A ; id 4
    dfar Data_064_6797
    dfar Data_066_4917
    dfar Data_066_4DE4
    dfar Data_062_77EB
    dfar Data_065_6F70
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_065_60A2
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_066_4635
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_7BFD
    dfar Data_064_6D09
    dfar Data_066_4C37
    dfar Data_066_52E9
    dfar Data_062_7C25
    dfar Data_065_7334
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_63C6
    dfar Data_065_7279
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_066_4B3B
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 5
    dfar Data_062_75B0
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_065_65EA
    dfar Data_063_73F8
    dfar Data_064_6F23
    dfar Data_065_751D
    dfar Data_066_478E
    dfar Data_066_4D7D
    dfar Data_064_7848
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_062_7B66
    dfar Data_065_7279
    dfar Data_066_615D
    dfar Data_065_6AEA
    dfar Data_063_7A89
    dfar Data_064_75A9
    dfar Data_065_7A80
    dfar Data_066_4BC0
    dfar Data_066_52C5
    dfar Data_064_7DFB
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup51Order::
Data_068_5B43:: ; heuristic: start of a structured table; C0
    db $00, $03, $04, $01, $02, $05 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup52::
Data_068_5B49:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5658
    dfar Data_065_6693
    dfar Data_065_6546
    dfar Data_066_589C
    dfar Data_065_5E8C
    dfar Data_062_423A
    dfar Data_064_6797
    dfar Data_064_7C14
    dfar Data_063_6DB3
    dfar Data_064_68E4
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_4EF7
    dfar Data_066_5C32
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6B2C
    dfar Data_065_6AC6
    dfar Data_066_5B97
    dfar Data_065_6301
    dfar Data_062_494B
    dfar Data_064_6D09
    dfar Data_064_7F35
    dfar Data_063_722B
    dfar Data_064_6D64
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_5342
    dfar Data_066_6138
    dfar Data_065_751D ; id 1
    dfar Data_066_5560
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_064_6FCF
    dfar Data_065_5D1D
    dfar Data_062_6D6B
    dfar Data_062_75B0
    dfar Data_062_7626
    dfar Data_064_6797
    dfar Data_063_6BCD
    dfar Data_062_406A
    dfar Data_064_78B1
    dfar Data_066_4D7D
    dfar Data_064_7848
    dfar Data_063_6BCD
    dfar Data_065_7A80
    dfar Data_066_5A87
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_064_75F2
    dfar Data_065_6293
    dfar Data_062_732E
    dfar Data_062_7B66
    dfar Data_062_7B96
    dfar Data_064_6D09
    dfar Data_063_7181
    dfar Data_062_48C0
    dfar Data_064_7E22
    dfar Data_066_52C5
    dfar Data_064_7DFB
    dfar Data_063_7181
    dfar Data_066_5658 ; id 2
    dfar Data_065_7641
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_5E8C
    dfar Data_062_702C
    dfar Data_065_6546
    dfar Data_065_74B6
    dfar Data_062_5337
    dfar Data_064_5AD4
    dfar Data_065_416D
    dfar Data_065_6D0D
    dfar Data_064_4734
    dfar Data_063_5437
    dfar Data_063_45E3
    dfar Data_065_6D65
    dfar Data_066_5AE7
    dfar Data_065_7AE1
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_6301
    dfar Data_062_7409
    dfar Data_065_6AC6
    dfar Data_065_7A51
    dfar Data_062_573B
    dfar Data_064_5E8E
    dfar Data_065_4643
    dfar Data_065_7279
    dfar Data_064_4B1E
    dfar Data_063_57D1
    dfar Data_063_4AB5
    dfar Data_065_7290
    dfar Data_066_5CC8 ; id 3
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_76AE
    dfar Data_062_6EDC
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_066_4635
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7BC5
    dfar Data_062_73A7
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_066_4B3B
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 4
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_5FE5
    dfar Data_065_6693
    dfar Data_065_751D
    dfar Data_062_75B0
    dfar Data_064_6A43
    dfar Data_063_6DB3
    dfar Data_062_6E33
    dfar Data_063_73F8
    dfar Data_066_505C
    dfar Data_064_79CF
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6391
    dfar Data_065_6B2C
    dfar Data_065_7A80
    dfar Data_062_7B66
    dfar Data_064_6DC8
    dfar Data_063_722B
    dfar Data_062_737B
    dfar Data_063_7A89
    dfar Data_066_53AD
    dfar Data_064_7E84
    dfar Data_066_4B1A
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_062_43CA ; id 5
    dfar Data_064_6828
    dfar Data_066_45B4
    dfar Data_066_4EF7
    dfar Data_063_6FC0
    dfar Data_062_6EDC
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_062_7985
    dfar Data_062_41C9
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_4635
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_062_49C6
    dfar Data_064_6D28
    dfar Data_066_4B1A
    dfar Data_066_5342
    dfar Data_063_72C9
    dfar Data_062_73A7
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_062_7CBA
    dfar Data_062_492F
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_4B3B
    dfar Data_066_52C5
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup52Order::
Data_068_5D89:: ; heuristic: start of a structured table; C0
    db $05, $02, $01, $04, $03, $00 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup53::
Data_068_5D8F:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5705
    dfar Data_065_65EA
    dfar Data_066_5477
    dfar Data_065_6808
    dfar Data_065_5FE5
    dfar Data_062_423A
    dfar Data_062_78C0
    dfar Data_062_5485
    dfar Data_064_5B93
    dfar Data_065_41F0
    dfar Data_062_76AE
    dfar Data_064_4843
    dfar Data_063_6744
    dfar Data_062_6784
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_065_6AEA
    dfar Data_066_5A3B
    dfar Data_065_6B9F
    dfar Data_065_6391
    dfar Data_062_494B
    dfar Data_062_7C82
    dfar Data_062_57A2
    dfar Data_064_5ED5
    dfar Data_065_4662
    dfar Data_062_7BC5
    dfar Data_064_4B88
    dfar Data_063_6A61
    dfar Data_062_6B76
    dfar Data_065_75A3 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_6E8B
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_062_6EDC
    dfar Data_065_6546
    dfar Data_065_76ED
    dfar Data_064_7A7D
    dfar Data_065_4291
    dfar Data_062_41C9
    dfar Data_062_702C
    dfar Data_065_6736
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_72E6
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_062_73A7
    dfar Data_065_6AC6
    dfar Data_065_7B11
    dfar Data_064_7EB0
    dfar Data_065_469B
    dfar Data_062_492F
    dfar Data_062_7409
    dfar Data_065_6B50
    dfar Data_065_6546 ; id 2
    dfar Data_065_643F
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_062_40EE
    dfar Data_062_406A
    dfar Data_065_6DE3
    dfar Data_066_5CC8
    dfar Data_063_6C79
    dfar Data_064_66F6
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_065_5D1D
    dfar Data_062_6D6B
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_065_6AC6
    dfar Data_065_6A71
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_062_48DA
    dfar Data_062_48C0
    dfar Data_065_72B2
    dfar Data_066_615D
    dfar Data_063_71D4
    dfar Data_064_6CC4
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_065_6293
    dfar Data_062_732E
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_064_7848 ; id 3
    dfar Data_063_6D0B
    dfar Data_063_60DA
    dfar Data_065_5B98
    dfar Data_066_54FD
    dfar Data_065_5DD4
    dfar Data_064_4843
    dfar Data_063_54F8
    dfar Data_064_78B1
    dfar Data_066_4635
    dfar Data_063_6EFF
    dfar Data_062_4365
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_066_4859
    dfar Data_064_7DFB
    dfar Data_063_71F3
    dfar Data_063_63CF
    dfar Data_065_5BBD
    dfar Data_066_5A5F
    dfar Data_065_62D2
    dfar Data_064_4B88
    dfar Data_063_5822
    dfar Data_064_7E22
    dfar Data_066_4B3B
    dfar Data_063_729A
    dfar Data_062_49AA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_066_4C04
    dfar Data_062_6807 ; id 4
    dfar Data_063_6B43
    dfar Data_062_53C7
    dfar Data_064_5B93
    dfar Data_063_6636
    dfar Data_064_5284
    dfar Data_064_454F
    dfar Data_063_54F8
    dfar Data_064_46A7
    dfar Data_063_45E3
    dfar Data_064_66F6
    dfar Data_063_6DB3
    dfar Data_066_44A5
    dfar Data_066_4546
    dfar Data_066_4D7D
    dfar Data_064_78B1
    dfar Data_062_6BA6
    dfar Data_063_7151
    dfar Data_062_5761
    dfar Data_064_5ED5
    dfar Data_063_69E0
    dfar Data_064_56E0
    dfar Data_064_4A58
    dfar Data_063_5822
    dfar Data_064_4AD9
    dfar Data_063_4AB5
    dfar Data_064_6CC4
    dfar Data_063_722B
    dfar Data_066_4AD3
    dfar Data_066_4AF5
    dfar Data_066_52C5
    dfar Data_064_7E22
    dfar Data_064_5B93 ; id 5
    dfar Data_065_416D
    dfar Data_062_6F90
    dfar Data_065_74B6
    dfar Data_063_531D
    dfar Data_063_45E3
    dfar Data_062_406A
    dfar Data_065_6D0D
    dfar Data_062_40EE
    dfar Data_064_6797
    dfar Data_066_4546
    dfar Data_066_4D7D
    dfar Data_066_4859
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_5ED5
    dfar Data_065_4643
    dfar Data_062_73E8
    dfar Data_065_7A51
    dfar Data_063_5769
    dfar Data_063_4AB5
    dfar Data_062_48C0
    dfar Data_065_7279
    dfar Data_062_48DA
    dfar Data_064_6D09
    dfar Data_066_4AF5
    dfar Data_066_52C5
    dfar Data_066_4C04
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup53Order::
Data_068_5FCF:: ; heuristic: start of a structured table; C0
    db $04, $03, $00, $05, $02, $01 ; entry 0

; E-0146 (derived: 9 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup54::
Data_068_5FD5:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_589C
    dfar Data_065_77A4
    dfar Data_066_5CC8
    dfar Data_066_5705
    dfar Data_065_5FE5
    dfar Data_062_70C1
    dfar Data_066_5658
    dfar Data_065_5E8C
    dfar Data_062_53C7
    dfar Data_064_5B93
    dfar Data_062_77EB
    dfar Data_062_423A
    dfar Data_064_4734
    dfar Data_063_54F8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5B97
    dfar Data_065_7B60
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_065_6391
    dfar Data_062_744A
    dfar Data_066_5AE7
    dfar Data_065_6301
    dfar Data_062_5761
    dfar Data_064_5ED5
    dfar Data_062_7C25
    dfar Data_062_494B
    dfar Data_064_4B1E
    dfar Data_063_5822
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_55DC
    dfar Data_065_65EA
    dfar Data_065_6808
    dfar Data_065_7641
    dfar Data_064_78B1
    dfar Data_064_58E6
    dfar Data_065_43BD
    dfar Data_062_6EDC
    dfar Data_065_751D
    dfar Data_063_6744
    dfar Data_062_668A
    dfar Data_065_416D
    dfar Data_065_6D0D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5AB9
    dfar Data_065_6AEA
    dfar Data_065_6B9F
    dfar Data_065_7AE1
    dfar Data_064_7E22
    dfar Data_064_5DC8
    dfar Data_065_470B
    dfar Data_062_73A7
    dfar Data_065_7A80
    dfar Data_063_6A61
    dfar Data_062_6B10
    dfar Data_065_4643
    dfar Data_065_7279
    dfar Data_065_64CA ; id 2
    dfar Data_065_643F
    dfar Data_065_68B7
    dfar Data_065_7641
    dfar Data_063_6BCD
    dfar Data_062_5166
    dfar Data_065_41F0
    dfar Data_065_70BD
    dfar Data_062_75B0
    dfar Data_063_5EAF
    dfar Data_064_5218
    dfar Data_065_6D65
    dfar Data_062_7626
    dfar Data_064_460E
    dfar Data_063_45E3
    dfar Data_065_6E8B
    dfar Data_065_6A8F
    dfar Data_065_6A71
    dfar Data_065_6BD1
    dfar Data_065_7AE1
    dfar Data_063_7181
    dfar Data_062_569C
    dfar Data_065_4662
    dfar Data_065_73A8
    dfar Data_062_7B66
    dfar Data_063_62DE
    dfar Data_064_56B0
    dfar Data_065_7290
    dfar Data_062_7B96
    dfar Data_064_4AA9
    dfar Data_063_4AB5
    dfar Data_065_72E6
    dfar Data_062_7626 ; id 3
    dfar Data_064_66F6
    dfar Data_066_45B4
    dfar Data_063_6C79
    dfar Data_064_7945
    dfar Data_064_6F23
    dfar Data_065_751D
    dfar Data_062_7626
    dfar Data_066_5CC8
    dfar Data_062_75B0
    dfar Data_062_6E33
    dfar Data_065_5D1D
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_062_40EE
    dfar Data_062_40EE
    dfar Data_062_7B96
    dfar Data_064_6CC4
    dfar Data_066_4B1A
    dfar Data_063_71D4
    dfar Data_064_7E51
    dfar Data_064_75A9
    dfar Data_065_7A80
    dfar Data_062_7B96
    dfar Data_066_615D
    dfar Data_062_7B66
    dfar Data_062_737B
    dfar Data_065_6293
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_062_48DA
    dfar Data_062_48DA
    dfar Data_063_6047 ; id 4
    dfar Data_064_6145
    dfar Data_063_453F
    dfar Data_065_6C81
    dfar Data_064_4734
    dfar Data_063_468C
    dfar Data_064_66F6
    dfar Data_066_4CD6
    dfar Data_064_697E
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_066_5477
    dfar Data_065_6E8B
    dfar Data_066_5658
    dfar Data_065_64CA
    dfar Data_065_5BD1
    dfar Data_063_6383
    dfar Data_064_6509
    dfar Data_063_4A65
    dfar Data_065_7251
    dfar Data_064_4B1E
    dfar Data_063_4AF5
    dfar Data_064_6CC4
    dfar Data_066_52A0
    dfar Data_064_6D86
    dfar Data_066_4B1A
    dfar Data_066_52C5
    dfar Data_066_5A3B
    dfar Data_065_72E6
    dfar Data_066_5AE7
    dfar Data_065_6A8F
    dfar Data_065_6216
    dfar Data_064_7945 ; id 5
    dfar Data_063_6EFF
    dfar Data_064_6828
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_064_706F
    dfar Data_065_751D
    dfar Data_065_65EA
    dfar Data_065_6693
    dfar Data_063_7545
    dfar Data_066_4EF7
    dfar Data_062_5337
    dfar Data_065_431E
    dfar Data_065_6DE3
    dfar Data_066_5CC8
    dfar Data_064_7E51
    dfar Data_063_729A
    dfar Data_064_6D28
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_064_761D
    dfar Data_065_7A80
    dfar Data_065_6AEA
    dfar Data_065_6B2C
    dfar Data_063_7B05
    dfar Data_066_5342
    dfar Data_062_573B
    dfar Data_065_46BF
    dfar Data_065_72B2
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 6
    dfar Data_064_7B56
    dfar Data_063_6D0B
    dfar Data_064_68E4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_062_6EDC
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_064_6828
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_4E6E
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_063_71F3
    dfar Data_064_6D64
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_062_73A7
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7C25
Data_068_6266:: ; heuristic: label inside a table; C0
    dfar Data_064_6D28
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_5311
    dfar Data_066_4F98 ; id 7
    dfar Data_062_7985
    dfar Data_062_5519
    dfar Data_064_5A34
    dfar Data_065_65EA
    dfar Data_065_5FE5
    dfar Data_063_60DA
    dfar Data_064_60D8
    dfar Data_066_46C5
    dfar Data_063_6EFF
    dfar Data_064_4843
    dfar Data_063_468C
    dfar Data_066_5CC8
    dfar Data_064_7B56
    dfar Data_066_4859
    dfar Data_066_4635
    dfar Data_066_5366
    dfar Data_062_7CBA
    dfar Data_062_57D8
    dfar Data_064_5E47
    dfar Data_065_6AEA
    dfar Data_065_6391
    dfar Data_063_63CF
    dfar Data_064_64DA
    dfar Data_066_4B6F
    dfar Data_063_729A
    dfar Data_064_4B88
    dfar Data_063_4AF5
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_066_4C04
    dfar Data_066_4B3B
    dfar Data_062_5E91 ; id 8
    dfar Data_063_45E3
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_063_45E3
    dfar Data_064_6797
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_064_6797
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_63DA
    dfar Data_063_4AB5
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_063_4AB5
    dfar Data_064_6D09
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_064_6D09
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup54Order::
Data_068_6335:: ; heuristic: start of a structured table; C0
    db $00, $02, $03, $01, $04, $07, $05, $06, $08 ; entry 0

; E-0146 (derived: 9 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup55::
Data_068_633E:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_54FD
    dfar Data_065_65EA
    dfar Data_065_64CA
    dfar Data_066_5658
    dfar Data_065_5C71
    dfar Data_062_528E
    dfar Data_065_40C4
    dfar Data_062_78C0
    dfar Data_062_406A
    dfar Data_064_46A7
    dfar Data_065_4D49
    dfar Data_062_774A
    dfar Data_062_40EE
    dfar Data_062_41C9
    dfar Data_063_5E57
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6AEA
    dfar Data_065_6A8F
    dfar Data_066_5AE7
    dfar Data_065_6244
    dfar Data_062_56FE
    dfar Data_065_45EE
    dfar Data_062_7C82
    dfar Data_062_48C0
    dfar Data_064_4AD9
    dfar Data_065_52C8
    dfar Data_062_7BFD
    dfar Data_062_48DA
    dfar Data_062_492F
    dfar Data_063_62C3
    dfar Data_065_6546 ; id 1
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_589C
    dfar Data_062_40EE
    dfar Data_062_6EDC
    dfar Data_065_6808
    dfar Data_065_5FE5
    dfar Data_064_594F
    dfar Data_064_5A34
    dfar Data_064_5B93
    dfar Data_065_43BD
    dfar Data_064_6073
    dfar Data_063_5437
    dfar Data_063_54F8
    dfar Data_065_50F6
    dfar Data_065_6AC6
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_5B97
    dfar Data_062_48DA
    dfar Data_062_73A7
    dfar Data_065_6B9F
    dfar Data_065_6391
    dfar Data_064_5DEE
    dfar Data_064_5E47
    dfar Data_064_5ED5
    dfar Data_065_470B
    dfar Data_064_64A7
    dfar Data_063_57D1
    dfar Data_063_5822
    dfar Data_065_5457
    dfar Data_065_643F ; id 2
    dfar Data_065_6546
    dfar Data_065_68B7
    dfar Data_065_75A3
    dfar Data_062_528E
    dfar Data_065_416D
    dfar Data_064_68E4
    dfar Data_066_4E6E
    dfar Data_063_5EAF
    dfar Data_064_5218
    dfar Data_065_6E8B
    dfar Data_066_5CC8
    dfar Data_065_5587
    dfar Data_064_51A5
    dfar Data_062_6F90
    dfar Data_065_75A3
    dfar Data_065_6A71
    dfar Data_065_6AC6
    dfar Data_065_6BD1
    dfar Data_065_7AAA
    dfar Data_062_56FE
    dfar Data_065_4643
    dfar Data_064_6D64
    dfar Data_066_5311
    dfar Data_063_62DE
    dfar Data_064_56B0
    dfar Data_065_72E6
    dfar Data_066_615D
    dfar Data_065_59BF
    dfar Data_064_567F
    dw Data_062_73E8
Data_068_645A:: ; heuristic: label inside a table; C0
    db $62
    dfar Data_065_7AAA
Data_068_645E:: ; heuristic: label inside a table; C0
    dfar Data_064_7848 ; id 3
    dfar Data_063_6D0B
    dfar Data_062_528E
    dfar Data_065_57D0
    dfar Data_066_5CC8
    dfar Data_065_5DD4
    dfar Data_064_46A7
    dfar Data_063_5437
    dfar Data_062_75B0
Data_068_6479:: ; heuristic: label inside a table; C0
    dfar Data_062_41C9
    dfar Data_062_406A
    dfar Data_064_697E
    dfar Data_064_79CF
    dfar Data_066_4635
    dfar Data_066_4635
    dfar Data_066_4F98
    dfar Data_064_7DFB
    dfar Data_063_71F3
    dfar Data_062_56FE
    dfar Data_065_5AC0
    dfar Data_066_615D
    dfar Data_065_62D2
    dfar Data_064_4AD9
    dfar Data_063_57D1
    dfar Data_062_7B66
    dfar Data_062_492F
    dfar Data_062_48C0
    dfar Data_064_6D86
    dfar Data_064_7E84
    dfar Data_066_4B3B
    dfar Data_066_4B3B
    dfar Data_066_5366
    dfar Data_064_5218 ; id 4
    dfar Data_062_41C9
    dfar Data_062_42B3
    dfar Data_062_6E33
    dfar Data_063_45E3
    dfar Data_064_6828
    dfar Data_063_6D0B
    dfar Data_062_40EE
    dfar Data_066_45B4
    dfar Data_066_4E6E
    dfar Data_062_76AE
    dfar Data_064_68E4
    dfar Data_066_5CC8
    dfar Data_066_55DC
    dfar Data_065_5DD4
    dfar Data_065_6E8B
    dfar Data_064_56B0
    dfar Data_062_492F
    dfar Data_062_4967
    dfar Data_062_737B
    dfar Data_063_4AB5
    dfar Data_064_6D28
    dfar Data_063_71F3
    dfar Data_062_48DA
    dfar Data_066_4B1A
    dfar Data_066_5311
    dfar Data_062_7BC5
    dfar Data_064_6D64
    dfar Data_066_615D
    dfar Data_066_5AB9
    dfar Data_065_62D2
    dfar Data_065_72E6
    dfar Data_063_66AF ; id 5
    dfar Data_064_5310
    dfar Data_064_6828
    dfar Data_066_4E6E
    dfar Data_063_60DA
    dfar Data_064_5394
    dfar Data_062_6EDC
    dfar Data_065_75A3
    dfar Data_065_5852
    dfar Data_062_694C
    dfar Data_065_41F0
    dfar Data_065_6DE3
    dfar Data_065_5B98
    dw Data_064_6311
Data_068_6547:: ; heuristic: label inside a table; C0
    db $64
    dfar Data_063_468C
    dfar Data_065_6F70
    dfar Data_063_6A11
    dfar Data_064_5719
    dfar Data_064_6D28
    dfar Data_066_5311
    dfar Data_063_63CF
    dw Data_064_5742
Data_068_655F:: ; heuristic: label inside a table; C0
    db $64
    dfar Data_062_73A7
Data_068_6563:: ; heuristic: label inside a table; C0
    dw Data_065_7AAA
Data_068_6565:: ; heuristic: label inside a table; C0
    db $65
    dfar Data_065_5AF8
    dfar Data_062_6C2D
    dfar Data_065_4662
    dfar Data_065_72B2
Data_068_6572:: ; heuristic: label inside a table; C0
    dfar Data_065_5BBD
    dfar Data_064_65BC
    dfar Data_063_4AF5
Data_068_657B:: ; heuristic: label inside a table; C0
    dfar Data_065_7334
    dfar Data_066_5CC8 ; id 6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 7
    dfar Data_062_7517
    dfar Data_062_53C7
    dfar Data_065_55E2
    dfar Data_066_5CC8
    dfar Data_062_774A
    dfar Data_064_47BD
    dfar Data_063_52A2
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_066_478E
    dfar Data_063_6C79
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_066_615D
    dfar Data_062_7B3B
    dfar Data_062_5761
    dfar Data_065_59E9
    dfar Data_066_615D
    dfar Data_062_7BFD
    dfar Data_064_4B43
    dfar Data_063_5744
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_066_4BC0
    dfar Data_063_71D4
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_065_5B98 ; id 8
    dfar Data_062_68C2
    dw Data_065_416D
Data_068_6646:: ; heuristic: label inside a table; C0
    db $65
    dw Data_065_70BD
Data_068_6649:: ; heuristic: label inside a table; C0
    db $65
    dw Data_063_6744
Data_068_664C:: ; heuristic: label inside a table; C0
    db $63
Data_068_664D:: ; heuristic: label inside a table; C0
    dfar Data_064_6272
    dw Data_063_468C
Data_068_6652:: ; heuristic: label inside a table; C0
    db $63
    dfar Data_065_7023
    dfar Data_064_4843
    dfar Data_063_4867
Data_068_665C:: ; heuristic: label inside a table; C0
    dfar Data_064_6828
    dw Data_066_4DE4
Data_068_6661:: ; heuristic: label inside a table; C0
    db $66
    dfar Data_066_4859
    dfar Data_066_4917
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_065_5BBD
    dfar Data_062_6BF7
    dfar Data_065_4643
    dfar Data_065_73A8
    dfar Data_063_6A61
    dfar Data_064_657E
    dfar Data_063_4AF5
    dfar Data_065_737C
    dfar Data_064_4B88
    dfar Data_063_4BB7
    dfar Data_064_6D28
    dfar Data_066_52E9
    dfar Data_066_4C04
    dfar Data_066_4C37
    dfar Data_066_5342
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup55Order::
Data_068_669E:: ; heuristic: start of a structured table; C0
    db $08, $07, $03, $06, $04, $02, $04, $01, $00 ; entry 0

; E-0146 (derived: 9 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup56::
Data_068_66A7:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5560
    dfar Data_065_6693
    dfar Data_065_64CA
    dfar Data_066_589C
    dfar Data_065_5C71
    dfar Data_062_528E
    dfar Data_065_40C4
    dfar Data_062_7985
    dfar Data_062_5166
    dfar Data_065_564B
    dfar Data_064_51A5
    dfar Data_062_78C0
    dfar Data_064_454F
    dfar Data_063_65BE
    dfar Data_064_5218
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_6B2C
    dfar Data_065_6A8F
    dfar Data_066_5B97
    dfar Data_065_6244
    dfar Data_062_56FE
    dfar Data_065_45EE
    dfar Data_062_7CBA
    dfar Data_062_569C
    dfar Data_065_5A18
    dfar Data_064_567F
    dfar Data_062_7C82
    dfar Data_064_4A58
    dfar Data_063_69A8
    dfar Data_064_56B0
    dfar Data_065_77A4 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_6546
    dfar Data_062_702C
    dfar Data_065_65EA
    dfar Data_065_5E8C
    dfar Data_064_6828
    dfar Data_064_6A43
    dfar Data_066_45B4
    dfar Data_063_6DB3
    dfar Data_062_6F90
    dfar Data_062_702C
    dfar Data_065_64CA
    dfar Data_063_7626
    dfar Data_066_46C5
    dfar Data_065_7B60
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6AC6
    dfar Data_062_7409
    dfar Data_065_6AEA
    dfar Data_065_6301
    dfar Data_064_6D28
    dfar Data_064_6DC8
    dfar Data_066_4B1A
    dfar Data_063_722B
    dfar Data_062_73E8
    dfar Data_062_7409
    dfar Data_065_6A8F
    dfar Data_063_7B4F
    dfar Data_066_4B6F
    dfar Data_065_65EA ; id 2
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_4635
    dfar Data_064_706F
    dfar Data_065_6546
    dfar Data_065_74B6
    dfar Data_065_75A3
    dfar Data_062_76AE
    dfar Data_062_40EE
    dfar Data_065_6D0D
    dfar Data_064_706F
    dfar Data_063_7545
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_065_6AEA
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_4B3B
    dfar Data_064_761D
    dfar Data_065_6AC6
    dfar Data_065_7A51
    dfar Data_065_7AAA
    dfar Data_062_7BC5
    dfar Data_062_48DA
    dfar Data_065_7279
    dfar Data_064_761D
    dfar Data_063_7B05
    dfar Data_066_4B1A
    dfar Data_066_52C5
    dfar Data_064_79CF ; id 3
    dfar Data_063_6D0B
    dfar Data_064_460E
    dfar Data_063_468C
    dfar Data_066_5705
    dfar Data_063_74A4
    dfar Data_066_4546
    dfar Data_066_4635
    dfar Data_064_7A7D
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5560
    dfar Data_065_74B6
    dfar Data_066_55DC
    dfar Data_064_7E84
    dfar Data_063_71F3
    dfar Data_064_4AA9
    dfar Data_063_4AF5
    dfar Data_066_5B0F
    dfar Data_063_7ADE
    dfar Data_066_4AF5
    dfar Data_066_4B3B
    dfar Data_064_7EB0
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_7A51
    dfar Data_066_5AB9
    dfar Data_062_423A ; id 4
    dfar Data_062_4365
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_063_6E4E
    dfar Data_064_6A43
    dfar Data_066_4DE4
    dfar Data_066_5477
    dfar Data_064_78B1
    dfar Data_064_72E0
    dfar Data_065_6546
    dfar Data_065_5BD1
    dfar Data_065_6736
    dfar Data_065_5FE5
    dfar Data_062_5209
    dfar Data_065_4041
    dfar Data_062_494B
    dfar Data_062_49AA
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_063_7250
    dfar Data_064_6DC8
    dfar Data_066_52E9
    dfar Data_066_5A3B
    dfar Data_064_7E22
    dfar Data_064_76F7
    dfar Data_065_6AC6
    dfar Data_065_6216
    dfar Data_065_6B50
    dfar Data_065_6391
    dfar Data_062_56DF
    dfar Data_065_45C0
    dfar Data_062_75B0 ; id 5
    dfar Data_065_70BD
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_063_73F8
    dfar Data_066_5115
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_066_55DC
    dfar Data_065_751D
    dfar Data_062_6D6B
    dfar Data_065_68B7
    dfar Data_065_5DD4
    dfar Data_065_6D65
    dfar Data_062_7B66
    dfar Data_065_73A8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_063_7A89
    dfar Data_066_53DF
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_7279
    dfar Data_066_615D
    dfar Data_066_5AB9
    dfar Data_065_7A80
    dfar Data_062_732E
    dfar Data_065_6BD1
    dfar Data_065_62D2
    dfar Data_065_7290
    dfar Data_066_5CC8 ; id 6
    dfar Data_062_774A
    dfar Data_062_6D6B
    dfar Data_065_5F42
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_063_6C79
    dfar Data_062_53C7
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_75B0
    dfar Data_064_47BD
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_066_44A5
    dfar Data_066_615D
    dfar Data_062_7BFD
    dfar Data_062_732E
    dfar Data_065_634B
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_063_71D4
    dfar Data_062_5761
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7B66
    dfar Data_064_4B43
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_066_4AD3
    dfar Data_062_5337 ; id 7
    dfar Data_065_43BD
    dfar Data_063_5F99
    dfar Data_062_668A
    dfar Data_062_6083
    dfar Data_063_4867
    dfar Data_064_46A7
    dfar Data_063_64F3
    dfar Data_063_472D
    dfar Data_064_6A43
    dfar Data_063_6DB3
    dfar Data_064_460E
    dfar Data_066_478E
    dfar Data_066_505C
    dfar Data_064_7B56
    dfar Data_066_4635
    dfar Data_062_573B
    dfar Data_065_470B
    dfar Data_063_633B
    dfar Data_062_6B10
    dfar Data_062_6496
    dfar Data_063_4BB7
    dfar Data_064_4AD9
    dfar Data_063_694D
    dfar Data_063_4B25
    dfar Data_064_6DC8
    dfar Data_063_722B
    dfar Data_064_4AA9
    dfar Data_066_4BC0
    dfar Data_066_53AD
    dfar Data_064_7F00
    dfar Data_066_4B3B
    dfar Data_065_445B ; id 8
    dfar Data_062_5519
    dfar Data_065_41F0
    dfar Data_065_6D0D
    dfar Data_062_694C
    dfar Data_065_5852
    dfar Data_064_5284
    dfar Data_065_70BD
    dfar Data_063_557A
    dfar Data_063_5437
    dfar Data_063_468C
    dfar Data_065_6E8B
    dfar Data_066_4917
    dfar Data_066_46C5
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_065_473E
    dfar Data_062_57D8
    dfar Data_065_4662
    dfar Data_065_7279
    dfar Data_062_6C2D
    dfar Data_065_5AF8
    dfar Data_064_56E0
    dfar Data_065_73A8
    dfar Data_063_5855
    dfar Data_063_57D1
    dfar Data_063_4AF5
    dfar Data_065_72E6
    dfar Data_066_4C37
    dfar Data_066_4B6F
    dfar Data_066_4B1A
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup56Order::
Data_068_6A07:: ; heuristic: start of a structured table; C0
    db $03, $02, $00, $07, $04, $01, $08, $06, $05 ; entry 0

; E-0146 (derived: 9 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup57::
Data_068_6A10:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_589C
    dfar Data_065_68B7
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_062_43CA
    dfar Data_065_6C81
    dfar Data_066_57D9
    dfar Data_065_5D1D
    dfar Data_062_4365
    dfar Data_062_6E33
    dfar Data_064_7848
    dfar Data_066_45B4
    dfar Data_063_6FC0
    dfar Data_062_40EE
    dfar Data_066_615D
    dfar Data_066_5B97
    dfar Data_065_6BD1
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_062_49C6
    dfar Data_065_7251
    dfar Data_066_5B5A
    dfar Data_065_6293
    dfar Data_062_49AA
    dfar Data_062_737B
    dfar Data_064_7DFB
    dfar Data_066_4B1A
    dfar Data_063_72C9
    dfar Data_062_48DA
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_55DC
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5AB9
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_066_5CC8 ; id 2
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_6693
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_065_5E8C
    dfar Data_062_41C9
    dfar Data_065_6E8B
    dfar Data_066_5CC8
    dfar Data_062_423A
    dfar Data_064_68E4
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6B2C
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_065_6301
    dfar Data_062_492F
    dfar Data_065_72E6
    dfar Data_066_615D
    dfar Data_062_494B
    dfar Data_064_6D64
    dfar Data_066_5366
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 3
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_066_4635
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_6736
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_75B0
    dfar Data_062_4365
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_065_5C71
    dfar Data_062_40EE
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_066_4B3B
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6B50
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7B66
    dfar Data_062_49AA
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_6244
    dfar Data_062_48DA
    dfar Data_064_6F23 ; id 4
    dfar Data_065_75A3
    dfar Data_066_5658
    dfar Data_065_5D1D
    dfar Data_063_73F8
    dfar Data_066_4E6E
    dfar Data_064_79CF
    dfar Data_063_6C79
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_062_6D6B
    dfar Data_065_65EA
    dfar Data_065_7641
    dfar Data_062_7517
    dfar Data_064_75A9
    dfar Data_065_7AAA
    dfar Data_066_5AE7
    dfar Data_065_6293
    dfar Data_063_7A89
    dfar Data_066_5311
    dfar Data_064_7E84
    dfar Data_063_71D4
    dfar Data_065_7279
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_062_732E
    dfar Data_065_6AEA
    dfar Data_065_7AE1
    dfar Data_062_7B3B
    dfar Data_064_6828 ; id 5
    dfar Data_066_4E6E
    dfar Data_066_5560
    dfar Data_065_751D
    dfar Data_062_774A
    dfar Data_066_55DC
    dfar Data_065_5D1D
    dfar Data_065_6D65
    dfar Data_062_6F90
    dfar Data_065_5DD4
    dfar Data_064_6797
    dfar Data_066_4DE4
    dfar Data_062_423A
    dfar Data_062_41C9
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_064_6D28
    dfar Data_066_5311
    dfar Data_066_5A87
    dfar Data_065_7A80
    dfar Data_062_7BFD
    dfar Data_066_5AB9
    dfar Data_065_6293
    dfar Data_065_7290
    dfar Data_062_73E8
    dfar Data_065_62D2
    dfar Data_064_6D09
    dfar Data_066_52E9
    dfar Data_062_494B
    dfar Data_062_492F
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 6
    dfar Data_062_78C0
    dfar Data_064_68E4
    dfar Data_066_45B4
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_4F98
    dfar Data_066_5560
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_57D9
    dfar Data_065_5D1D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_4917
    dfar Data_066_615D
    dfar Data_062_7C82
    dfar Data_064_6D64
    dfar Data_066_4B1A
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_5366
    dfar Data_066_5A87
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5B5A
    dfar Data_065_6293
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_4C37
    dfar Data_063_6EFF ; id 7
    dfar Data_064_6AEC
    dfar Data_064_706F
    dfar Data_063_7626
    dfar Data_065_5DD4
    dfar Data_065_7023
    dfar Data_064_79CF
    dfar Data_066_4DE4
    dfar Data_062_42B3
    dfar Data_065_70BD
    dfar Data_066_5CC8
    dfar Data_066_55DC
    dfar Data_066_4859
    dfar Data_066_5115
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_063_729A
    dfar Data_064_6DFE
    dfar Data_064_761D
    dfar Data_063_7B4F
    dfar Data_065_62D2
    dfar Data_065_737C
    dfar Data_064_7E84
    dfar Data_066_52E9
    dfar Data_062_4967
    dfar Data_065_73A8
    dfar Data_066_615D
    dfar Data_066_5AB9
    dfar Data_066_4C04
    dfar Data_066_53DF
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_063_6DB3 ; id 8
    dfar Data_062_4001
    dfar Data_062_6E33
    dfar Data_065_75A3
    dfar Data_062_76AE
    dfar Data_062_406A
    dfar Data_062_40EE
    dfar Data_065_6D65
    dfar Data_065_5C71
    dfar Data_062_43CA
    dfar Data_064_6797
    dfar Data_066_4EF7
    dfar Data_066_45B4
    dfar Data_066_4635
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_063_722B
    dfar Data_062_48AC
    dfar Data_062_737B
    dfar Data_065_7AAA
    dfar Data_062_7BC5
    dfar Data_062_48C0
    dfar Data_062_48DA
    dfar Data_065_7290
    dfar Data_065_6244
    dfar Data_062_49C6
    dfar Data_064_6D09
    dfar Data_066_5342
    dfar Data_066_4B1A
    dfar Data_066_4B3B
    dfar Data_066_52E9
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup57Order::
Data_068_6D70:: ; heuristic: start of a structured table; C0
    db $05, $06, $08, $01, $04, $07, $00, $02, $03 ; entry 0

; compressed tileset of map $A2 (the first map record using it)
; LZSS-compressed asset: 1435 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Tileset:: ; heuristic: map tileset stream; C0
Data_068_6D79:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A2D79, $59B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapA2Palettes::
Data_068_7314:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $05A4, $53DE, $0E29, $0084 ; entry 1
    dw $386C, $53DE, $4593, $0000 ; entry 2
    dw $012F, $035F, $01DA, $0000 ; entry 3
    dw $0160, $5AB1, $4A2D, $0000 ; entry 4
    dw $0152, $53DE, $025C, $0008 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA2Screens0::
Data_068_7354:: ; heuristic: map screen array; C0
    dfar Data_068_739C ; entry 0
    dfar Data_068_7492 ; entry 1
    dfar Data_068_758A ; entry 2
    dfar Data_068_7682 ; entry 3
    dfar Data_068_772C ; entry 4
    dfar Data_068_7814 ; entry 5
    dfar Data_068_78B7 ; entry 6
    dfar Data_068_7977 ; entry 7
    dfar Data_068_7A5A ; entry 8
    dfar Data_068_7B1C ; entry 9
    dfar Data_068_7B30 ; entry 10
    dfar Data_068_7B85 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA2Attrs0::
Data_068_7378:: ; heuristic: map screen array; C0
    dfar Data_068_7B99 ; entry 0
    dfar Data_068_7BD8 ; entry 1
    dfar Data_068_7C15 ; entry 2
    dfar Data_068_7C4F ; entry 3
    dfar Data_068_7C7D ; entry 4
    dfar Data_068_7CB0 ; entry 5
    dfar Data_068_7CDC ; entry 6
    dfar Data_068_7D14 ; entry 7
    dfar Data_068_7D49 ; entry 8
    dfar Data_068_7D7E ; entry 9
    dfar Data_068_7D91 ; entry 10
    dfar Data_068_7DAB ; entry 11

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_739C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A339C, $F6

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7492:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3492, $F8

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_758A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A358A, $F8

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7682:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3682, $AA

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_772C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A372C, $E8

; LZSS-compressed asset: 163 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7814:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3814, $A3

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_78B7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A38B7, $C0

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7977:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3977, $E3

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7A5A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3A5A, $C2

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7B1C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7B30:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3B30, $55

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7B85:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7B99:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $04, $02, $00, $02, $0D, $04, $00, $00, $0F, $00, $04, $00
    db $14, $0F, $00, $00, $28, $0F, $2B, $01, $01, $02, $02, $01, $01, $00, $7A, $08
    db $00, $78, $0F, $05, $00, $A2, $0C, $00, $A0, $0F, $2B, $00, $A0, $08, $00, $28
    db $00, $00, $FE, $02, $00, $F4, $0F, $09, $00, $FE, $06, $00, $1A, $1F, $27

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7BD8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $01, $00, $4E, $01, $00, $57, $01, $00
    db $4E, $07, $00, $55, $04, $00, $66, $02, $00, $64, $02, $00, $68, $08, $00, $55
    db $02, $00, $7A, $0F, $01, $00, $66, $0C, $00, $9E, $0F, $07, $00, $C4, $0F, $11
    db $04, $04, $00, $E0, $0E, $00, $F0, $0F, $03, $00, $16, $1F, $3B

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7C15:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0D, $04, $04, $00, $01, $0F, $00, $00, $13, $0D
    db $04, $00, $25, $0F, $2C, $01, $01, $02, $02, $01, $01, $00, $78, $08, $00, $76
    db $0F, $05, $00, $A0, $0C, $00, $9E, $0F, $2B, $00, $EE, $02, $00, $E4, $0E, $00
    db $F4, $0F, $03, $00, $9E, $06, $00, $14, $1F, $2D

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7C4F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $03, $00, $00, $00, $00, $0C
    db $04, $00, $04, $0E, $00, $04, $04, $00, $1E, $0F, $3F, $00, $04, $06, $00, $7A
    db $0F, $33, $00, $20, $0F, $33, $00, $02, $0F, $15, $00, $02, $0F, $13

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7C7D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $0F, $18, $01, $00, $2C, $07, $00, $24, $0F, $07
    db $00, $2C, $08, $00, $34, $04, $00, $52, $0E, $00, $52, $0C, $00, $78, $0F, $2D
    db $00, $50, $0F, $15, $00, $28, $0F, $17, $00, $28, $08, $00, $20, $0F, $01, $00
    db $26, $1F, $1B

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7CB0:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $03, $01, $00, $08, $03, $00, $00, $04, $00, $04
    db $0F, $0D, $00, $0E, $08, $00, $30, $0F, $21, $00, $30, $06, $00, $6E, $0F, $33
    db $00, $28, $0F, $3D, $00, $00, $0F, $25, $00, $10, $0F, $05

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7CDC:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $03, $00, $00, $00, $00, $0C
    db $04, $00, $04, $0F, $09, $00, $0A, $08, $00, $2C, $0F, $0B, $00, $06, $06, $00
    db $54, $0F, $29, $00, $52, $0C, $00, $A0, $0F, $07, $00, $52, $0A, $00, $C8, $0F
    db $09, $00, $F7, $0F, $4D, $00, $08, $1C

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7D14:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $01, $01, $00, $06, $03, $00, $00, $02, $00, $00
    db $0F, $05, $00, $06, $04, $00, $0A, $08, $00, $2C, $0C, $00, $2C, $08, $00, $5B
    db $0F, $4D, $00, $90, $0F, $21, $00, $4E, $0E, $00, $4C, $0F, $01, $00, $26, $0F
    db $17, $00, $28, $0F, $15

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7D49:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $03, $01, $00, $08, $03, $00, $00, $04, $00, $04
    db $0F, $03, $00, $08, $04, $00, $22, $0F, $07, $00, $2E, $06, $00, $46, $0F, $41
    db $00, $28, $0C, $00, $AA, $0F, $03, $00, $26, $0E, $00, $0E, $0A, $00, $F3, $0F
    db $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7D7E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 26 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7D91:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $F0, $01, $02, $04, $07, $02, $FC, $FF, $4D, $02, $5C
    db $0F, $4D, $02, $BC, $0F, $4D, $02, $08, $1F, $25

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7DAB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3DAB, $150
    ds $105, $00
