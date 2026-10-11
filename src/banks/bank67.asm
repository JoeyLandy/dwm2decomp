SECTION "Bank 67", ROMX[$4000], BANK[$67]
    db $67

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup00::
Data_067_4001:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_6546
    dfar Data_065_6736
    dfar Data_065_7641
    dfar Data_062_76AE
    dfar Data_062_50CE
    dfar Data_065_43BD
    dfar Data_065_6DE3
    dfar Data_062_774A
    dfar Data_064_48DA
    dfar Data_063_44A8
    dfar Data_065_6D65
    dfar Data_064_7A7D
    dfar Data_066_4859
    dfar Data_066_4917
    dfar Data_066_4D7D
    dfar Data_066_5A5F
    dfar Data_065_6AC6
    dfar Data_065_6B50
    dfar Data_065_7AE1
    dfar Data_062_7BC5
    dfar Data_062_566F
    dfar Data_065_470B
    dfar Data_065_72B2
    dfar Data_062_7BFD
    dfar Data_064_4BC1
    dfar Data_063_4A36
    dfar Data_065_7290
    dfar Data_064_7EB0
    dfar Data_066_4C04
    dfar Data_066_4C37
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup00Order::
Data_067_4061:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup01::
Data_067_4062:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_55DC
    dfar Data_065_64CA
    dfar Data_065_743F
    dfar Data_066_5560
    dfar Data_065_5F42
    dfar Data_062_423A
    dfar Data_065_6D65
    dfar Data_062_77EB
    dfar Data_062_4001
    dfar Data_064_6A43
    dfar Data_066_4E6E
    dfar Data_064_79CF
    dfar Data_066_4917
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_5AB9
    dfar Data_065_6A8F
    dfar Data_065_7A30
    dfar Data_066_5A87
    dfar Data_065_634B
    dfar Data_062_494B
    dfar Data_065_7290
    dfar Data_062_7C25
    dfar Data_062_48AC
    dfar Data_064_6DC8
    dfar Data_066_5311
    dfar Data_064_7E84
    dfar Data_066_4C37
    dfar Data_066_52E9
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup01Order::
Data_067_40C2:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup02::
Data_067_40C3:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5477 ; id 0
    dfar Data_065_64CA
    dfar Data_065_6546
    dfar Data_065_75A3
    dfar Data_062_75B0
    dfar Data_062_43CA
    dfar Data_062_4365
    dfar Data_065_6E8B
    dfar Data_062_7626
    dfar Data_064_66F6
    dfar Data_066_478E
    dfar Data_066_4CD6
    dfar Data_064_7945
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5A3B
    dfar Data_065_6A8F
    dfar Data_065_6AC6
    dfar Data_065_7AAA
    dfar Data_062_7B66
    dfar Data_062_49C6
    dfar Data_062_49AA
    dfar Data_065_72E6
    dfar Data_062_7B96
    dfar Data_064_6CC4
    dfar Data_066_4BC0
    dfar Data_066_52A0
    dfar Data_064_7E51
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup02Order::
Data_067_4123:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup03::
Data_067_4124:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5560
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_76AE
    dfar Data_065_6C81
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7BC5
    dfar Data_065_7251
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_5366
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup03Order::
Data_067_4184:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup04::
Data_067_4185:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5705 ; id 0
    dfar Data_065_6693
    dfar Data_065_65EA
    dfar Data_065_76ED
    dfar Data_062_78C0
    dfar Data_062_423A
    dfar Data_062_40EE
    dfar Data_065_6D0D
    dfar Data_062_7985
    dfar Data_062_42B3
    dfar Data_062_406A
    dfar Data_065_6D65
    dfar Data_064_7B56
    dfar Data_066_478E
    dfar Data_066_46C5
    dfar Data_066_4E6E
    dfar Data_066_5B0F
    dfar Data_065_6B2C
    dfar Data_065_6AEA
    dfar Data_065_7B11
    dfar Data_062_7C82
    dfar Data_062_494B
    dfar Data_062_48DA
    dfar Data_065_7279
    dfar Data_062_7CBA
    dfar Data_062_4967
    dfar Data_062_48C0
    dfar Data_065_7290
    dfar Data_064_7F00
    dfar Data_066_4BC0
    dfar Data_066_4B6F
    dfar Data_066_5311

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup04Order::
Data_067_41E5:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup05::
Data_067_41E6:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5705 ; id 0
    dfar Data_065_743F
    dfar Data_066_5477
    dfar Data_065_76ED
    dfar Data_062_76AE
    dfar Data_065_70BD
    dfar Data_062_774A
    dfar Data_065_6D0D
    dfar Data_062_7985
    dfar Data_062_6E33
    dfar Data_065_5C71
    dfar Data_065_6DE3
    dfar Data_064_7848
    dfar Data_066_4635
    dfar Data_066_4546
    dfar Data_066_5115
    dfar Data_066_5B0F
    dfar Data_065_7A30
    dfar Data_066_5A3B
    dfar Data_065_7B11
    dfar Data_062_7BC5
    dfar Data_065_73A8
    dfar Data_062_7BFD
    dfar Data_065_7279
    dfar Data_062_7CBA
    dfar Data_062_737B
    dfar Data_065_6244
    dfar Data_065_72B2
    dfar Data_064_7DFB
    dfar Data_066_4B3B
    dfar Data_066_4AF5
    dfar Data_066_53DF

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup05Order::
Data_067_4246:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup06::
Data_067_4247:: ; heuristic: key-world chunk group; C0
    dfar Data_066_55DC ; id 0
    dfar Data_065_6808
    dfar Data_065_68B7
    dfar Data_065_74B6
    dfar Data_062_7626
    dfar Data_062_42B3
    dfar Data_062_4454
    dfar Data_065_6E8B
    dfar Data_062_75B0
    dfar Data_062_406A
    dfar Data_062_40EE
    dfar Data_065_7023
    dfar Data_064_7CD5
    dfar Data_066_44A5
    dfar Data_066_4635
    dfar Data_066_4F98
    dfar Data_066_5AB9
    dfar Data_065_6B9F
    dfar Data_065_6BD1
    dfar Data_065_7A51
    dfar Data_062_7B96
    dfar Data_062_4967
    dfar Data_062_49F1
    dfar Data_065_72E6
    dfar Data_062_7B66
    dfar Data_062_48C0
    dfar Data_062_48DA
    dfar Data_065_737C
    dfar Data_064_7F84
    dfar Data_066_4AD3
    dfar Data_066_4B3B
    dfar Data_066_5366

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup06Order::
Data_067_42A7:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup07::
Data_067_42A8:: ; heuristic: key-world chunk group; C0
    dfar Data_066_596B ; id 0
    dfar Data_065_643F
    dfar Data_065_64CA
    dfar Data_065_751D
    dfar Data_062_7626
    dfar Data_064_66F6
    dfar Data_063_7073
    dfar Data_065_6E8B
    dfar Data_062_76AE
    dfar Data_065_7161
    dfar Data_062_76AE
    dfar Data_065_7023
    dfar Data_064_7848
    dfar Data_066_4CD6
    dfar Data_064_7C14
    dfar Data_066_4F98
    dfar Data_066_5BD9
    dfar Data_065_6A71
    dfar Data_065_6A8F
    dfar Data_065_7A80
    dfar Data_062_7B96
    dfar Data_064_6CC4
    dfar Data_063_7306
    dfar Data_065_72E6
    dfar Data_062_7BC5
    dfar Data_065_73EA
    dfar Data_062_7BC5
    dfar Data_065_737C
    dfar Data_064_7DFB
    dfar Data_066_52A0
    dfar Data_064_7F35
    dfar Data_066_5366

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup07Order::
Data_067_4308:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup08::
Data_067_4309:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5560 ; id 0
    dfar Data_065_643F
    dfar Data_065_7641
    dfar Data_066_5CC8
    dfar Data_064_7CD5
    dfar Data_063_6BCD
    dfar Data_062_6D6B
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_063_6D0B
    dfar Data_065_6F70
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_4EF7
    dfar Data_066_5A87
    dfar Data_065_6A71
    dfar Data_065_7AE1
    dfar Data_066_615D
    dfar Data_064_7F84
    dfar Data_063_7181
    dfar Data_062_732E
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_063_71F3
    dfar Data_065_7334
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_5342

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup08Order::
Data_067_4369:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup09::
Data_067_436A:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_065_5C71
    dfar Data_065_6E8B
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_46C5
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_6244
    dfar Data_065_72E6
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_4B6F
    dfar Data_066_52C5
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup09Order::
Data_067_43CA:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup0A::
Data_067_43CB:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_6736
    dfar Data_065_64CA
    dfar Data_065_74B6
    dfar Data_062_77EB
    dfar Data_064_6828
    dfar Data_066_45B4
    dfar Data_066_4E6E
    dfar Data_064_7848
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5A5F
    dfar Data_065_6B50
    dfar Data_065_6A8F
    dfar Data_065_7A51
    dfar Data_062_7C25
    dfar Data_064_6D28
    dfar Data_066_4B1A
    dfar Data_066_5311
    dfar Data_064_7DFB
    dfar Data_066_5366
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0AOrder::
Data_067_442B:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup0B::
Data_067_442C:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5658 ; id 0
    dfar Data_065_64CA
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_062_76AE
    dfar Data_064_66F6
    dfar Data_064_72E0
    dfar Data_065_74B6
    dfar Data_064_7945
    dfar Data_064_6FCF
    dfar Data_063_7545
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_066_5AE7
    dfar Data_065_6A8F
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_062_7BC5
    dfar Data_064_6CC4
    dfar Data_064_76F7
    dfar Data_065_7A51
    dfar Data_064_7E51
    dfar Data_064_75F2
    dfar Data_063_7B05
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_5366
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0BOrder::
Data_067_448C:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup0C::
Data_067_448D:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_54FD
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_064_7139
    dfar Data_065_74B6
Data_067_44A5:: ; heuristic: label inside a table; C0
    dfar Data_066_5477
    dfar Data_065_6736
    dfar Data_065_5C71
    dfar Data_065_6C81
    dfar Data_064_7848
    dfar Data_066_4546
    dfar Data_066_4635
    dfar Data_066_4EF7
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_064_7661
    dfar Data_065_7A51
    dfar Data_066_5A3B
    dfar Data_065_6B50
    dfar Data_065_6244
    dfar Data_065_7251
    dfar Data_064_7DFB
    dfar Data_066_4AF5
    dfar Data_066_4B3B
    dfar Data_066_5342

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0COrder::
Data_067_44ED:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup0D::
Data_067_44EE:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5705
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_063_74A4
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_064_72E0
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_4CD6
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_063_7ADE
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_064_76F7
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_52A0

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0DOrder::
Data_067_454E:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup0E::
Data_067_454F:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_596B
    dfar Data_065_65EA
    dfar Data_065_74B6
    dfar Data_066_55DC
    dfar Data_063_76CB
    dfar Data_066_46C5
    dfar Data_066_4F98
    dfar Data_064_7848
    dfar Data_064_6FCF
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7CD5
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_5BD9
    dfar Data_065_6AEA
    dfar Data_065_7A51
    dfar Data_066_5AB9
    dfar Data_063_7B7B
    dfar Data_066_4B6F
    dfar Data_066_5366
    dfar Data_064_7DFB
    dfar Data_064_75F2
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F84
    dfar Data_066_52C5
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0EOrder::
Data_067_45AF:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup0F::
Data_067_45B0:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_6736
    dfar Data_065_65EA
    dfar Data_065_74B6
    dfar Data_062_774A
    dfar Data_062_4642
    dfar Data_064_6797
    dfar Data_066_4CD6
    dfar Data_062_76AE
    dfar Data_064_66F6
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_51C2
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5A5F
    dfar Data_065_6B50
    dfar Data_065_6AEA
    dfar Data_065_7A51
    dfar Data_062_7BFD
    dfar Data_062_4A9A
    dfar Data_064_6D09
    dfar Data_066_52A0
    dfar Data_062_7BC5
    dfar Data_064_6CC4
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_5416
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0FOrder::
Data_067_4610:: ; heuristic: start of a structured table; C0
    db $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup10::
Data_067_4611:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_6546
    dfar Data_065_6808
    dfar Data_065_743F
    dfar Data_062_7517
    dfar Data_062_528E
    dfar Data_065_4041
    dfar Data_065_6E8B
    dfar Data_062_75B0
    dfar Data_064_4734
    dfar Data_063_468C
    dfar Data_065_6DE3
Data_067_4635:: ; heuristic: label inside a table; C0
    dfar Data_064_78B1
    dfar Data_063_6E4E
    dfar Data_064_68E4
    dfar Data_066_4F98
    dfar Data_066_5A5F
    dfar Data_065_6AC6
    dfar Data_065_6B9F
    dfar Data_065_7A30
    dfar Data_062_7B3B
    dfar Data_062_56FE
    dfar Data_065_45C0
    dfar Data_065_72E6
    dfar Data_062_7B66
    dfar Data_064_4B1E
    dfar Data_063_4AF5
    dfar Data_065_72B2
    dfar Data_064_7E22
    dfar Data_063_7250
    dfar Data_064_6D64
    dfar Data_066_5366
    dfar Data_066_589C ; id 1
    dfar Data_065_5FE5
    dfar Data_062_6CE1
    dfar Data_065_743F
    dfar Data_062_75B0
    dfar Data_064_6797
    dfar Data_063_6D0B
    dfar Data_065_6F70
    dfar Data_062_774A
    dfar Data_062_702C
    dfar Data_065_5FE5
    dfar Data_065_70BD
    dfar Data_064_77CC
    dfar Data_066_45B4
    dfar Data_066_46C5
    dfar Data_066_505C
    dfar Data_066_5B97
    dfar Data_065_6391
    dfar Data_062_7306
    dfar Data_065_7A30
    dfar Data_062_7B66
    dfar Data_064_6D09
    dfar Data_063_71F3
    dfar Data_065_7334
    dfar Data_062_7BFD
    dfar Data_062_7409
    dfar Data_065_6391
    dfar Data_065_73A8
    dfar Data_064_7DD4
    dfar Data_066_4B1A
    dfar Data_066_4B6F
    dfar Data_066_53AD

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup10Order::
Data_067_46D1:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup11::
Data_067_46D3:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_063_7545
    dfar Data_066_4DE4
    dfar Data_066_5705
    dfar Data_065_5FE5
    dfar Data_065_70BD
    dfar Data_066_5CC8
    dfar Data_062_76AE
    dfar Data_062_406A
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_063_7B05
    dfar Data_066_52E9
    dfar Data_066_5B0F
    dfar Data_065_6391
    dfar Data_065_73A8
    dfar Data_066_615D
    dfar Data_062_7BC5
    dfar Data_062_48C0
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_062_7626 ; id 1
    dfar Data_062_423A
    dfar Data_062_702C
    dfar Data_065_77A4
    dfar Data_062_7517
    dfar Data_062_41C9
    dfar Data_062_406A
    dfar Data_065_6D0D
    dfar Data_064_79CF
    dfar Data_063_6E4E
    dfar Data_064_6AEC
    dfar Data_066_4CD6
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_062_7B96
    dfar Data_062_494B
    dfar Data_062_7409
    dfar Data_065_7B60
    dfar Data_062_7B3B
    dfar Data_062_492F
    dfar Data_062_48C0
    dfar Data_065_7279
    dfar Data_064_7E84
    dfar Data_063_7250
    dfar Data_064_6DFE
    dfar Data_066_52A0
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_066_52C5
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup11Order::
Data_067_4793:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup12::
Data_067_4795:: ; heuristic: key-world chunk group; C0
    dfar Data_066_55DC ; id 0
    dfar Data_065_6736
    dfar Data_065_6546
    dfar Data_065_74B6
    dfar Data_062_7626
    dfar Data_062_5337
    dfar Data_065_43BD
    dfar Data_065_70BD
    dfar Data_062_75B0
    dfar Data_064_44CC
    dfar Data_063_468C
    dfar Data_065_6E8B
    dfar Data_062_78C0
    dfar Data_062_5485
    dfar Data_065_431E
    dfar Data_065_6D65
    dfar Data_066_5AB9
    dfar Data_065_6B50
    dfar Data_065_6AC6
    dfar Data_065_7A51
    dfar Data_062_7B96
    dfar Data_062_573B
    dfar Data_065_470B
    dfar Data_065_73A8
    dfar Data_062_7B66
    dfar Data_064_4A2C
    dfar Data_063_4AF5
    dfar Data_065_72E6
    dfar Data_062_7C82
    dfar Data_062_57A2
    dfar Data_065_46BF
    dfar Data_065_7290
    dfar Data_062_77EB ; id 1
    dfar Data_063_6148
    dfar Data_064_5310
    dfar Data_065_6D0D
    dfar Data_062_7517
    dfar Data_063_5F99
    dfar Data_064_5394
    dfar Data_065_6DE3
    dfar Data_062_774A
    dfar Data_064_46A7
    dfar Data_063_453F
    dfar Data_065_7023
    dfar Data_064_7C14
    dfar Data_066_44A5
    dfar Data_066_45B4
    dfar Data_066_5115
    dfar Data_062_7C25
    dfar Data_063_63FE
    dfar Data_064_5719
    dfar Data_065_7279
    dfar Data_062_7B3B
    dfar Data_063_633B
    dfar Data_064_5742
    dfar Data_065_72B2
    dfar Data_062_7BFD
    dfar Data_064_4AD9
    dfar Data_063_4A65
    dfar Data_065_737C
    dfar Data_064_7F35
    dfar Data_066_4AD3
    dfar Data_066_4B1A
    dfar Data_066_53DF

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup12Order::
Data_067_4855:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup13::
Data_067_4857:: ; heuristic: key-world chunk group; C0
    dw Data_066_5CC8 ; id 0
Data_067_4859:: ; heuristic: label inside a table; C0
    db $66
    dfar Data_066_5658
    dfar Data_065_6736
    dfar Data_065_77A4
    dfar Data_066_5477
    dfar Data_065_5DD4
    dfar Data_062_43CA
    dfar Data_065_6C81
    dfar Data_064_7848
    dfar Data_063_6C79
    dfar Data_062_41C9
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_062_7517
    dfar Data_064_6797
    dfar Data_066_4EF7
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6B50
    dfar Data_065_7B60
    dfar Data_066_5A3B
    dfar Data_065_62D2
    dfar Data_062_49C6
    dfar Data_065_7251
    dfar Data_064_7DFB
    dfar Data_063_71D4
    dfar Data_062_492F
    dfar Data_065_7279
    dfar Data_066_615D
    dfar Data_062_7B3B
    dfar Data_064_6D09
    dfar Data_066_5342
    dfar Data_066_5477 ; id 1
    dfar Data_065_5DD4
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_062_75B0
    dfar Data_062_423A
    dfar Data_062_6D6B
    dfar Data_065_76ED
    dfar Data_062_7985
    dfar Data_062_42B3
    dfar Data_064_6AEC
    dfar Data_066_4CD6
    dfar Data_064_7B56
    dfar Data_066_44A5
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_066_5A3B
    dfar Data_065_62D2
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_062_7B66
    dfar Data_062_494B
    dfar Data_062_732E
    dfar Data_065_7B11
    dfar Data_062_7CBA
    dfar Data_062_4967
    dfar Data_064_6DFE
    dfar Data_066_52A0
    dfar Data_064_7F00
    dfar Data_066_4AD3
    dfar Data_066_53AD
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup13Order::
Data_067_4917:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup14::
Data_067_4919:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5477
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_065_5F42
    dfar Data_062_6CE1
    dfar Data_065_75A3
    dfar Data_062_7985
    dfar Data_062_4365
    dfar Data_062_42B3
    dfar Data_065_6E8B
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_634B
    dfar Data_062_7306
    dfar Data_065_7AAA
    dfar Data_062_7CBA
    dfar Data_062_49AA
    dfar Data_062_4967
    dfar Data_065_72E6
    dfar Data_062_7626 ; id 1
    dfar Data_062_41C9
    dfar Data_062_423A
    dfar Data_065_6F70
    dfar Data_064_7848
    dfar Data_063_6EFF
    dfar Data_064_697E
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_062_7985
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_062_7B96
    dfar Data_062_492F
    dfar Data_062_494B
    dfar Data_065_7334
    dfar Data_064_7DFB
    dfar Data_063_729A
    dfar Data_064_6D86
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_062_7CBA
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_066_52C5
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup14Order::
Data_067_49D9:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup15::
Data_067_49DB:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5705 ; id 0
    dfar Data_065_6736
    dfar Data_065_6693
    dfar Data_065_74B6
    dfar Data_064_7A7D
    dfar Data_063_6E4E
    dfar Data_062_41C9
    dfar Data_065_6C81
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_063_6D0B
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_063_7545
    dfar Data_066_4DE4
    dfar Data_066_5B0F
    dfar Data_065_6B50
    dfar Data_065_6B2C
    dfar Data_065_7A51
    dfar Data_064_7EB0
    dfar Data_063_7250
    dfar Data_062_492F
    dfar Data_065_7251
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_063_71F3
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_063_7B05
    dfar Data_066_52E9
    dfar Data_066_5560 ; id 1
    dfar Data_065_5C71
    dfar Data_062_6D6B
    dfar Data_065_743F
    dfar Data_062_76AE
    dfar Data_062_50CE
    dfar Data_065_40C4
    dfar Data_065_6C81
    dfar Data_062_774A
    dfar Data_064_48DA
    dfar Data_063_45E3
    dfar Data_065_6DE3
    dfar Data_064_7A7D
    dfar Data_066_4859
    dfar Data_066_45B4
    dfar Data_066_4E6E
    dfar Data_066_5A87
    dfar Data_065_6244
    dfar Data_062_732E
    dfar Data_065_7A30
    dfar Data_062_7BC5
    dfar Data_062_566F
    dfar Data_065_45EE
    dfar Data_065_7251
    dfar Data_062_7BFD
    dfar Data_064_4BC1
    dfar Data_063_4AB5
    dfar Data_065_72B2
    dfar Data_064_7EB0
    dfar Data_066_4C04
    dfar Data_066_4B1A
    dfar Data_066_5311

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup15Order::
Data_067_4A9B:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup16::
Data_067_4A9D:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5705
    dfar Data_065_7641
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_78C0
    dfar Data_065_6DE3
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_60A2
    dfar Data_062_6E33
    dfar Data_065_77A4
    dfar Data_062_75B0
    dfar Data_062_559B
    dfar Data_065_40C4
    dfar Data_065_70BD
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_065_7AE1
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7C82
    dfar Data_065_72B2
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_63C6
    dfar Data_062_737B
    dfar Data_065_7B60
    dfar Data_062_7B66
    dfar Data_062_5801
    dfar Data_065_45EE
    dfar Data_065_73A8
    dfar Data_062_7626 ; id 1
    dfar Data_064_4960
    dfar Data_063_44A8
    dfar Data_065_6D65
    dfar Data_064_7848
    dfar Data_063_6FC0
    dfar Data_064_697E
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_062_78C0
    dfar Data_065_6E8B
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7CD5
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_062_7B96
    dfar Data_064_4C07
    dfar Data_063_4A36
    dfar Data_065_7290
    dfar Data_064_7DFB
    dfar Data_063_72C9
    dfar Data_064_6D86
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_062_7C82
    dfar Data_065_72E6
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F84
    dfar Data_066_5311
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup16Order::
Data_067_4B5D:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup17::
Data_067_4B5F:: ; heuristic: key-world chunk group; C0
    dfar Data_066_55DC ; id 0
    dfar Data_065_65EA
    dfar Data_065_6546
    dfar Data_065_743F
    dfar Data_062_76AE
    dfar Data_062_41C9
    dfar Data_064_6BB5
    dfar Data_066_4D7D
    dfar Data_062_75B0
    dfar Data_064_6828
    dfar Data_066_4CD6
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_064_706F
    dfar Data_065_794A
    dfar Data_066_5CC8
    dfar Data_066_5AB9
    dfar Data_065_6AEA
    dfar Data_065_6AC6
    dfar Data_065_7A30
    dfar Data_062_7BC5
    dfar Data_062_492F
    dfar Data_064_6E3C
    dfar Data_066_52C5
    dfar Data_062_7B66
    dfar Data_064_6D28
    dfar Data_066_52A0
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_064_761D
    dfar Data_065_7BE4
    dfar Data_066_615D
    dfar Data_066_5560 ; id 1
    dfar Data_065_5E8C
    dfar Data_062_6EDC
    dfar Data_065_7641
    dfar Data_064_77CC
    dfar Data_066_478E
    dfar Data_063_6C79
    dfar Data_065_6F70
    dfar Data_066_5CC8
    dfar Data_066_57D9
    dfar Data_065_5C71
    dfar Data_065_7161
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_44A5
    dfar Data_066_4D7D
    dfar Data_066_5A87
    dfar Data_065_6301
    dfar Data_062_73A7
    dfar Data_065_7AE1
    dfar Data_064_7DD4
    dfar Data_066_4BC0
    dfar Data_063_71D4
    dfar Data_065_7334
    dfar Data_066_615D
    dfar Data_066_5B5A
    dfar Data_065_6244
    dfar Data_065_73EA
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_4AD3
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup17Order::
Data_067_4C1F:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup18::
Data_067_4C21:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_7641
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_064_6F23
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_7AE1
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_064_75A9
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_5477 ; id 1
    dfar Data_065_5C71
    dfar Data_065_6E8B
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_064_66F6
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_064_72E0
    dfar Data_065_6546
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_4635
    dfar Data_066_4D7D
    dfar Data_066_5A3B
    dfar Data_065_6244
    dfar Data_065_72E6
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_064_6CC4
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_064_76F7
    dfar Data_065_6AC6
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_4B3B
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup18Order::
Data_067_4CE1:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup19::
Data_067_4CE3:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5477
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_063_74A4
    dfar Data_064_7139
    dfar Data_065_74B6
    dfar Data_064_78B1
    dfar Data_064_706F
    dfar Data_065_5FE5
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_064_7CD5
    dfar Data_063_6FC0
    dfar Data_065_6D65
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_063_7ADE
    dfar Data_064_7661
    dfar Data_065_7A51
    dfar Data_064_7E22
    dfar Data_064_761D
    dfar Data_065_6391
    dfar Data_065_7279
    dfar Data_066_615D
    dfar Data_064_7F84
    dfar Data_063_72C9
    dfar Data_065_7290
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_54FD
    dfar Data_065_5C71
    dfar Data_065_6F70
    dfar Data_066_5560
    dfar Data_063_76CB
    dfar Data_063_6BCD
    dfar Data_065_6DE3
    dfar Data_064_7848
    dfar Data_064_748C
    dfar Data_063_735C
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6244
    dfar Data_065_7334
    dfar Data_066_5A87
    dfar Data_063_7B7B
    dfar Data_063_7181
    dfar Data_065_72B2
    dfar Data_064_7DFB
    dfar Data_064_7778
    dfar Data_063_7A4C
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_52C5
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup19Order::
Data_067_4DA3:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup1A::
Data_067_4DA5:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5705
    dfar Data_065_65EA
    dfar Data_065_74B6
    dfar Data_066_54FD
    dfar Data_063_7952
    dfar Data_063_6BCD
    dfar Data_065_6E8B
    dfar Data_064_7848
    dfar Data_066_4D7D
    dfar Data_062_774A
    dfar Data_065_70BD
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_063_7626
    dfar Data_066_4D7D
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_065_6AEA
    dfar Data_065_7A51
    dfar Data_066_5A5F
    dfar Data_063_7C60
    dfar Data_063_7181
    dfar Data_065_72E6
    dfar Data_064_7DFB
    dfar Data_066_52C5
    dfar Data_062_7BFD
    dfar Data_065_73A8
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_063_7B4F
    dfar Data_066_52C5
    dfar Data_066_5CC8 ; id 1
    dfar Data_064_77CC
    dfar Data_064_72E0
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_064_76F7
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_5311
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
KeyWorldChunkGroup1AOrder::
Data_067_4E65:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup1B::
Data_067_4E67:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_596B
    dfar Data_065_751D
    dfar Data_066_57D9
    dfar Data_065_6736
    dfar Data_065_60A2
    dfar Data_065_7023
    dfar Data_062_76AE
    dfar Data_064_6AEC
    dfar Data_063_6C79
    dfar Data_065_6F70
    dfar Data_062_7517
    dfar Data_062_6D6B
    dfar Data_065_5FE5
    dfar Data_065_6DE3
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5BD9
    dfar Data_065_7A80
    dfar Data_066_5B5A
    dfar Data_065_6B50
    dfar Data_065_63C6
    dfar Data_065_737C
    dfar Data_062_7BC5
    dfar Data_064_6DFE
    dfar Data_063_71D4
    dfar Data_065_7334
    dfar Data_062_7B3B
    dfar Data_062_732E
    dfar Data_065_6391
    dfar Data_065_72B2
    dfar Data_064_7848 ; id 1
    dfar Data_063_6BCD
    dfar Data_064_6A43
    dfar Data_066_4EF7
    dfar Data_066_54FD
    dfar Data_063_7793
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_5115
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7DFB
    dfar Data_063_7181
    dfar Data_064_6DC8
    dfar Data_066_5342
    dfar Data_066_5A5F
    dfar Data_063_7BD2
    dfar Data_066_53AD
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_53DF
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1BOrder::
Data_067_4F27:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup1C::
Data_067_4F29:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_063_785D
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_063_7C12
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_77EB ; id 1
    dfar Data_062_70C1
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_062_7626
Data_067_4F98:: ; heuristic: label inside a table; C0
    dfar Data_062_4642
    dfar Data_062_6F90
    dfar Data_065_74B6
    dfar Data_064_77CC
    dfar Data_063_6BCD
    dfar Data_062_4507
    dfar Data_065_6DE3
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_4635
    dfar Data_066_505C
    dfar Data_062_7C25
    dfar Data_062_744A
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_062_4A9A
    dfar Data_062_73E8
    dfar Data_065_7A51
    dfar Data_064_7DD4
    dfar Data_063_7181
    dfar Data_062_4A36
    dfar Data_065_72B2
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_4B3B
    dfar Data_066_53AD

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1COrder::
Data_067_4FE9:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup1D::
Data_067_4FEB:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_596B
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_064_706F
    dfar Data_065_6736
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_062_7985
    dfar Data_062_43CA
    dfar Data_065_7161
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5BD9
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_064_761D
    dfar Data_065_6B50
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_062_7CBA
    dfar Data_062_49C6
    dfar Data_065_73EA
    dfar Data_066_5CC8 ; id 1
    dfar Data_062_76AE
    dfar Data_064_6A43
    dfar Data_066_4D7D
    dfar Data_066_54FD
    dfar Data_063_76CB
    dfar Data_066_5115
    dfar Data_066_5CC8
    dfar Data_064_7B56
    dfar Data_066_4D7D
    dfar Data_066_54FD
    dfar Data_065_7878
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_066_4D7D
    dfar Data_066_615D
    dfar Data_062_7BC5
    dfar Data_064_6DC8
    dfar Data_066_52C5
    dfar Data_066_5A5F
    dfar Data_063_7B7B
    dfar Data_066_53DF
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_066_52C5
    dfar Data_066_5A5F
    dfar Data_065_7B9E
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1DOrder::
Data_067_50AB:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup1E::
Data_067_50AD:: ; heuristic: key-world chunk group; C0
    dfar Data_066_55DC ; id 0
    dfar Data_065_65EA
    dfar Data_065_6693
    dfar Data_065_74B6
    dfar Data_062_7626
    dfar Data_062_5519
    dfar Data_065_41F0
    dfar Data_065_6DE3
    dfar Data_062_7A62
    dfar Data_064_460E
    dfar Data_063_4867
    dfar Data_065_70BD
    dfar Data_064_7848
    dfar Data_063_6BCD
    dfar Data_062_46CC
    dfar Data_065_6E8B
    dfar Data_066_5AB9
    dfar Data_065_6AEA
    dfar Data_065_6B2C
    dfar Data_065_7A51
    dfar Data_062_7B96
    dfar Data_062_57D8
    dfar Data_065_4662
    dfar Data_065_72B2
    dfar Data_062_7CFF
    dfar Data_064_4AA9
    dfar Data_063_4BB7
    dfar Data_065_73A8
    dfar Data_064_7DFB
    dfar Data_063_7181
    dfar Data_062_4ACF
    dfar Data_065_72E6
    dfar Data_066_5CC8 ; id 1
    dfar Data_064_7848
    dfar Data_066_478E
    dfar Data_066_4D7D
    dfar Data_066_54FD
    dfar Data_065_77A4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_064_73B7
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_4BC0
    dfar Data_066_52C5
    dfar Data_066_5A5F
    dfar Data_065_7B60
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_064_7730
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_066_52C5
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1EOrder::
Data_067_516D:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup1F::
Data_067_516F:: ; heuristic: key-world chunk group; C0
    dfar Data_066_57D9 ; id 0
    dfar Data_065_751D
    dfar Data_066_596B
    dfar Data_065_74B6
    dfar Data_064_78B1
    dfar Data_066_4DE4
    dfar Data_062_76AE
    dfar Data_065_7023
    dfar Data_066_54FD
    dfar Data_065_65EA
    dfar Data_063_785D
    dfar Data_066_4EF7
    dfar Data_062_7626
    dfar Data_062_4733
    dfar Data_062_6D6B
    dfar Data_065_74B6
    dfar Data_066_5B5A
    dfar Data_065_7A80
    dfar Data_066_5BD9
    dfar Data_065_7A51
    dfar Data_064_7E22
    dfar Data_066_52E9
    dfar Data_062_7BC5
    dfar Data_065_737C
    dfar Data_066_5A5F
    dfar Data_065_6AEA
    dfar Data_063_7C12
    dfar Data_066_5342
    dfar Data_062_7B96
    dfar Data_062_4AE3
    dfar Data_062_732E
    dfar Data_065_7A51
    dfar Data_062_774A ; id 1
    dfar Data_062_528E
    dfar Data_065_44EB
    dfar Data_065_6DE3
    dfar Data_062_76AE
    dfar Data_064_4734
    dfar Data_063_45E3
    dfar Data_065_6F70
    dfar Data_064_7848
    dfar Data_063_6D0B
    dfar Data_064_6A43
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_064_7CD5
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_062_7BFD
    dfar Data_062_56FE
    dfar Data_065_477D
    dfar Data_065_72B2
    dfar Data_062_7BC5
    dfar Data_064_4B1E
    dfar Data_063_4AB5
    dfar Data_065_7334
    dfar Data_064_7DFB
    dfar Data_063_71F3
    dfar Data_064_6DC8
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_064_7F84
    dfar Data_066_52C5
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1FOrder::
Data_067_522F:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup20::
Data_067_5231:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_64CA
    dfar Data_065_6693
    dfar Data_065_6546
    dfar Data_062_7517
    dfar Data_062_41C9
    dfar Data_062_406A
    dfar Data_064_6659
    dfar Data_062_77EB
    dfar Data_062_423A
    dfar Data_062_40EE
    dfar Data_065_6C81
    dfar Data_064_78B1
    dfar Data_066_46C5
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_066_5A5F
    dfar Data_065_6A8F
    dfar Data_065_6B2C
    dfar Data_065_6AC6
    dfar Data_062_7B3B
    dfar Data_062_492F
    dfar Data_062_48C0
    dfar Data_064_6C95
    dfar Data_062_7C25
    dfar Data_062_494B
    dfar Data_062_48DA
    dfar Data_065_7251
    dfar Data_064_7E22
    dfar Data_066_4B6F
    dfar Data_066_4B1A
    dfar Data_066_52C5
    dfar Data_065_65EA ; id 1
    dfar Data_065_643F
    dfar Data_065_6808
    dfar Data_065_74B6
    dfar Data_063_6B43
    dfar Data_062_5519
    dfar Data_065_40C4
    dfar Data_065_6DE3
    dfar Data_062_7517
    dfar Data_064_47BD
    dfar Data_063_453F
    dfar Data_065_6E8B
    dfar Data_064_7945
    dfar Data_066_4635
    dfar Data_066_44A5
    dfar Data_066_4DE4
    dfar Data_065_6AEA
    dfar Data_065_6A71
    dfar Data_065_6B9F
    dfar Data_065_7A51
    dfar Data_063_7151
    dfar Data_062_57D8
    dfar Data_065_45EE
    dfar Data_065_72B2
    dfar Data_062_7B3B
    dfar Data_064_4B43
    dfar Data_063_4A65
    dfar Data_065_72E6
    dfar Data_064_7E51
    dfar Data_066_4B3B
    dfar Data_066_4AD3
    dfar Data_066_52E9

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup20Order::
Data_067_52F1:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup21::
Data_067_52F3:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5560
    dfar Data_065_65EA
    dfar Data_065_7878
    dfar Data_066_5658
    dfar Data_063_76CB
    dfar Data_063_6E4E
    dfar Data_062_70C1
    dfar Data_064_7848
    dfar Data_066_4EF7
    dfar Data_062_76AE
    dfar Data_062_40EE
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_4546
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_6AEA
    dfar Data_065_7B9E
    dfar Data_066_5AE7
    dfar Data_063_7B7B
    dfar Data_063_7250
    dfar Data_062_744A
    dfar Data_064_7DFB
    dfar Data_066_5342
    dfar Data_062_7BC5
    dfar Data_062_48DA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_4AF5
    dfar Data_066_57D9 ; id 1
    dfar Data_065_6736
    dfar Data_065_6693
    dfar Data_065_75A3
    dfar Data_065_5C71
    dfar Data_064_6659
    dfar Data_063_6BCD
    dfar Data_065_6D65
    dfar Data_064_6797
    dfar Data_066_4E6E
    dfar Data_062_774A
    dfar Data_065_6F70
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_505C
    dfar Data_066_5B5A
    dfar Data_065_6B50
    dfar Data_065_6B2C
    dfar Data_065_7AAA
    dfar Data_065_6244
    dfar Data_064_6C95
    dfar Data_063_7181
    dfar Data_065_7290
    dfar Data_064_6D09
    dfar Data_066_5311
    dfar Data_062_7BFD
    dfar Data_065_7334
    dfar Data_066_53AD
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_53AD

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup21Order::
Data_067_53B3:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup22::
Data_067_53B5:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5477 ; id 0
    dfar Data_065_76ED
    dfar Data_066_5658
    dfar Data_065_64CA
    dfar Data_064_7C14
    dfar Data_064_72E0
    dfar Data_065_5DD4
    dfar Data_062_40EE
    dfar Data_066_5CC8
    dfar Data_062_774A
    dfar Data_064_697E
    dfar Data_063_6B43
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_066_4DE4
    dfar Data_064_7848
    dfar Data_066_5A3B
    dfar Data_065_7B11
    dfar Data_066_5AE7
    dfar Data_065_6A8F
    dfar Data_064_7F35
    dfar Data_064_76F7
    dfar Data_065_62D2
    dfar Data_062_48DA
    dfar Data_066_615D
    dfar Data_062_7BFD
    dfar Data_064_6D86
    dfar Data_063_7151
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_066_52E9
    dfar Data_064_7DFB
    dfar Data_065_77A4 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_743F
    dfar Data_062_7175
    dfar Data_065_6693
    dfar Data_063_76CB
    dfar Data_066_4E6E
    dfar Data_062_406A
    dfar Data_062_41C9
    dfar Data_062_70C1
    dfar Data_065_751D
    dfar Data_066_44A5
    dfar Data_066_45B4
    dfar Data_066_4917
    dfar Data_066_4D7D
    dfar Data_065_7B60
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_7A30
    dfar Data_062_7480
    dfar Data_065_6B2C
    dfar Data_063_7B7B
    dfar Data_066_5311
    dfar Data_062_48C0
    dfar Data_062_492F
    dfar Data_062_744A
    dfar Data_065_7A80
    dfar Data_066_4AD3
    dfar Data_066_4B1A
    dfar Data_066_4C37
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup22Order::
Data_067_5475:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup23::
Data_067_5477:: ; heuristic: key-world chunk group; C0
    dfar Data_066_589C ; id 0
    dfar Data_065_6546
    dfar Data_065_6808
    dfar Data_065_6736
    dfar Data_062_78C0
    dfar Data_062_5166
    dfar Data_064_59BA
    dfar Data_065_4291
    dfar Data_062_774A
    dfar Data_064_44CC
    dfar Data_063_557A
    dfar Data_063_453F
    dfar Data_064_7A7D
    dfar Data_066_4635
    dfar Data_066_45B4
    dfar Data_066_4546
    dfar Data_066_5B97
    dfar Data_065_6AC6
    dfar Data_065_6B9F
    dfar Data_065_6B50
    dfar Data_062_7C82
    dfar Data_062_569C
    dfar Data_064_5E12
    dfar Data_065_469B
    dfar Data_062_7BFD
    dfar Data_064_4A2C
    dfar Data_063_5855
    dfar Data_063_4A65
    dfar Data_064_7EB0
    dfar Data_066_4B3B
    dfar Data_066_4B1A
    dfar Data_066_4AF5
    dfar Data_065_751D ; id 1
    dfar Data_066_5477
    dfar Data_065_6546
    dfar Data_065_75A3
    dfar Data_062_6EDC
    dfar Data_065_5C71
    dfar Data_062_4001
    dfar Data_065_6E8B
    dfar Data_064_68E4
    dfar Data_063_6FC0
    dfar Data_062_43CA
    dfar Data_065_6F70
    dfar Data_066_4F98
    dfar Data_064_7B56
    dfar Data_066_4546
    dfar Data_066_505C
    dfar Data_065_7A80
    dfar Data_066_5A3B
    dfar Data_065_6AC6
    dfar Data_065_7AAA
    dfar Data_062_73A7
    dfar Data_065_6244
    dfar Data_062_48AC
    dfar Data_065_72E6
    dfar Data_064_6D64
    dfar Data_063_72C9
    dfar Data_062_49C6
    dfar Data_065_7334
    dfar Data_066_5366
    dfar Data_064_7F00
    dfar Data_066_4AF5
    dfar Data_066_53AD

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup23Order::
Data_067_5537:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup24::
Data_067_5539:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_68B7
    dfar Data_066_54FD
    dfar Data_065_6546
    dfar Data_065_5F42
    dfar Data_064_6A43
    dfar Data_064_7A7D
    dfar Data_066_45B4
    dfar Data_063_6D0B
    dfar Data_062_702C
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_066_4859
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6BD1
    dfar Data_066_5A5F
    dfar Data_065_6AC6
    dfar Data_065_634B
    dfar Data_064_6DC8
    dfar Data_064_7EB0
    dfar Data_066_4B1A
    dfar Data_063_71F3
    dfar Data_062_7409
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_066_4C04
    dfar Data_065_6736 ; id 1
    dfar Data_065_6546
    dfar Data_065_64CA
    dfar Data_065_75A3
    dfar Data_063_6C79
    dfar Data_062_4365
    dfar Data_062_43CA
    dfar Data_065_6E8B
    dfar Data_065_5D1D
    dfar Data_064_697E
    dfar Data_063_6E4E
    dfar Data_065_6D65
    dfar Data_066_4635
    dfar Data_066_4EF7
    dfar Data_064_78B1
    dfar Data_066_4D7D
    dfar Data_065_6B50
    dfar Data_065_6AC6
    dfar Data_065_6A8F
    dfar Data_065_7AAA
    dfar Data_063_71D4
    dfar Data_062_49AA
    dfar Data_062_49C6
    dfar Data_065_72E6
    dfar Data_065_6293
    dfar Data_064_6D86
    dfar Data_063_7250
    dfar Data_065_7290
    dfar Data_066_4B3B
    dfar Data_066_5342
    dfar Data_064_7E22
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup24Order::
Data_067_55F9:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup25::
Data_067_55FB:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5560
    dfar Data_066_54FD
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_062_7517
    dfar Data_064_78B1
    dfar Data_064_706F
    dfar Data_065_64CA
    dfar Data_065_5FE5
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_478E
    dfar Data_066_4917
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_066_5A5F
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_062_7B3B
    dfar Data_064_7E22
    dfar Data_064_761D
    dfar Data_065_6A8F
    dfar Data_065_6391
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_4BC0
    dfar Data_066_4C37
    dfar Data_065_65EA ; id 1
    dfar Data_065_6693
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_062_4001
    dfar Data_062_42B3
    dfar Data_062_6F90
    dfar Data_065_75A3
    dfar Data_064_66F6
    dfar Data_063_6EFF
    dfar Data_062_42B3
    dfar Data_065_7023
    dfar Data_066_4CD6
    dfar Data_064_7C14
    dfar Data_066_4917
    dfar Data_066_4D7D
    dfar Data_065_6AEA
    dfar Data_065_6B2C
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_062_48AC
    dfar Data_062_4967
    dfar Data_062_73E8
    dfar Data_065_7AAA
    dfar Data_064_6CC4
    dfar Data_063_729A
    dfar Data_062_4967
    dfar Data_065_737C
    dfar Data_066_52A0
    dfar Data_064_7F35
    dfar Data_066_4C37
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup25Order::
Data_067_56BB:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup26::
Data_067_56BD:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5658 ; id 0
    dfar Data_065_643F
    dfar Data_065_64CA
    dfar Data_065_7641
    dfar Data_062_77EB
    dfar Data_064_6BB5
    dfar Data_063_6C79
    dfar Data_062_7175
    dfar Data_062_78C0
    dfar Data_062_6E33
    dfar Data_065_5DD4
    dfar Data_064_6A43
    dfar Data_064_7C14
    dfar Data_066_4635
    dfar Data_066_46C5
    dfar Data_066_4F98
    dfar Data_066_5AE7
    dfar Data_065_6A71
    dfar Data_065_6A8F
    dfar Data_065_7AE1
    dfar Data_062_7C25
    dfar Data_064_6E3C
    dfar Data_063_71D4
    dfar Data_062_7480
    dfar Data_062_7C82
    dfar Data_062_737B
    dfar Data_065_62D2
    dfar Data_064_6DC8
    dfar Data_064_7F35
    dfar Data_066_4B3B
    dfar Data_066_4B6F
    dfar Data_066_5366
    dfar Data_066_54FD ; id 1
    dfar Data_065_7878
    dfar Data_066_596B
    dfar Data_065_794A
    dfar Data_065_5D1D
    dfar Data_062_70C1
    dfar Data_065_5D1D
    dfar Data_065_7161
    dfar Data_063_6D0B
    dfar Data_064_697E
    dfar Data_063_6D0B
    dfar Data_065_7161
    dfar Data_064_79CF
    dfar Data_066_4EF7
    dfar Data_064_7CD5
    dfar Data_066_51C2
    dfar Data_066_5A5F
    dfar Data_065_7B9E
    dfar Data_066_5BD9
    dfar Data_065_7BE4
    dfar Data_065_6293
    dfar Data_062_744A
    dfar Data_065_6293
    dfar Data_065_73EA
    dfar Data_063_71F3
    dfar Data_064_6D86
    dfar Data_063_71F3
    dfar Data_065_73EA
    dfar Data_064_7E84
    dfar Data_066_5342
    dfar Data_064_7F84
    dfar Data_066_5416

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup26Order::
Data_067_577D:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup27::
Data_067_577F:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_57D9
    dfar Data_065_6991
    dfar Data_065_65EA
    dfar Data_066_589C
    dfar Data_063_7952
    dfar Data_066_45B4
    dfar Data_063_6DB3
    dfar Data_064_7CD5
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_615D
    dfar Data_066_5B5A
    dfar Data_065_6C25
    dfar Data_065_6AEA
    dfar Data_066_5B97
    dfar Data_063_7C60
    dfar Data_066_4B1A
    dfar Data_063_722B
    dfar Data_064_7F84
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_065_77A4 ; id 1
    dfar Data_066_5705
    dfar Data_065_6991
    dfar Data_065_74B6
    dfar Data_062_7175
    dfar Data_065_5DD4
    dfar Data_062_4454
    dfar Data_065_7161
    dfar Data_062_4365
    dfar Data_062_423A
    dfar Data_064_6A43
    dfar Data_066_4E6E
    dfar Data_066_4546
    dfar Data_066_49F7
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_065_7B60
    dfar Data_066_5B0F
    dfar Data_065_6C25
    dfar Data_065_7A51
    dfar Data_062_7480
    dfar Data_065_62D2
    dfar Data_062_49F1
    dfar Data_065_73EA
    dfar Data_062_49AA
    dfar Data_062_494B
    dfar Data_064_6DC8
    dfar Data_066_5311
    dfar Data_066_4AF5
    dfar Data_066_4C79
    dfar Data_066_5366
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup27Order::
Data_067_583F:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup28::
Data_067_5841:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_6546
    dfar Data_065_643F
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_063_6BCD
    dfar Data_062_4792
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_46C5
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6AC6
    dfar Data_065_6A71
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_063_7181
    dfar Data_062_4AF7
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_4B6F
    dfar Data_066_5658 ; id 1
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_063_7793
    dfar Data_064_706F
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_062_7227
    dfar Data_063_76CB
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_45B4
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5AE7
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_063_7BD2
    dfar Data_064_761D
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_062_74C1
    dfar Data_063_7B7B
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_066_4B1A
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup28Order::
Data_067_5901:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup29::
Data_067_5903:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_6736
    dfar Data_066_5CC8
    dfar Data_066_5560
    dfar Data_065_615E
    dfar Data_064_6AEC
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6B50
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_63F4
    dfar Data_064_6DFE
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_4B1A
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_74B6 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_794A
    dfar Data_064_706F
    dfar Data_065_77A4
    dfar Data_062_77EB
    dfar Data_065_6DE3
    dfar Data_064_7945
    dfar Data_064_7139
    dfar Data_065_5BD1
    dfar Data_065_6C81
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_478E
    dfar Data_066_4D7D
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_7BE4
    dfar Data_064_761D
    dfar Data_065_7B60
    dfar Data_062_7C25
    dfar Data_065_72B2
    dfar Data_064_7E51
    dfar Data_064_7661
    dfar Data_065_6216
    dfar Data_065_7251
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_4BC0
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup29Order::
Data_067_59C3:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup2A::
Data_067_59C5:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5705 ; id 0
    dfar Data_065_65EA
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_062_7517
    dfar Data_062_45A7
    dfar Data_062_6D6B
    dfar Data_065_7878
    dfar Data_064_7848
    dfar Data_063_6BCD
    dfar Data_062_4454
    dfar Data_062_70C1
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_066_4635
    dfar Data_066_46C5
    dfar Data_066_5B0F
    dfar Data_065_6AEA
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_062_7B3B
    dfar Data_062_4A63
    dfar Data_062_732E
    dfar Data_065_7B9E
    dfar Data_064_7DFB
    dfar Data_063_7181
    dfar Data_062_49F1
    dfar Data_062_744A
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_066_4B3B
    dfar Data_066_4B6F
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_643F
    dfar Data_065_7641
    dfar Data_066_5CC8
    dfar Data_063_735C
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6A71
    dfar Data_065_7AE1
    dfar Data_066_615D
    dfar Data_063_7A4C
    dfar Data_066_4B1A
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2AOrder::
Data_067_5A85:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup2B::
Data_067_5A87:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_54FD
    dfar Data_065_75A3
    dfar Data_066_596B
    dfar Data_066_5CC8
    dfar Data_062_7517
    dfar Data_062_6EDC
    dfar Data_063_7545
    dfar Data_066_54FD
    dfar Data_065_5C71
    dfar Data_064_6828
    dfar Data_066_4D7D
    dfar Data_064_79CF
    dfar Data_066_46C5
    dfar Data_066_5115
    dfar Data_066_5CC8
    dw Data_066_615D
Data_067_5AB9:: ; heuristic: label inside a table; C0
    db $66
    dfar Data_066_5A5F
    dfar Data_065_7AAA
    dfar Data_066_5BD9
    dfar Data_066_615D
    dfar Data_062_7B3B
    dfar Data_062_73A7
    dfar Data_063_7B05
    dfar Data_066_5A5F
    dfar Data_065_6244
    dfar Data_064_6D28
    dfar Data_066_52C5
    dfar Data_064_7E84
    dfar Data_066_4B6F
    dfar Data_066_53DF
    dfar Data_066_615D
    dfar Data_065_6736 ; id 1
    dfar Data_065_65EA
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_4546
    dfar Data_066_4859
    dfar Data_066_4CD6
    dfar Data_066_5CC8
    dfar Data_066_55DC
    dfar Data_065_65EA
    dfar Data_065_6808
    dfar Data_065_74B6
    dfar Data_064_7848
    dfar Data_066_4917
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_065_6B50
    dfar Data_065_6AEA
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_4AF5
    dfar Data_066_4C04
    dfar Data_066_52A0
    dfar Data_066_615D
    dfar Data_066_5AB9
    dfar Data_065_6AEA
    dfar Data_065_6B9F
    dfar Data_065_7A51
    dfar Data_064_7DFB
    dfar Data_066_4C37
    dfar Data_066_4B1A
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2BOrder::
Data_067_5B47:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup2C::
Data_067_5B49:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_743F
    dfar Data_066_5658
    dfar Data_065_75A3
    dfar Data_064_78B1
    dfar Data_064_6FCF
    dfar Data_063_785D
    dfar Data_064_7139
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_062_6D6B
    dfar Data_063_74A4
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_49F7
    dfar Data_066_4D7D
    dfar Data_066_5A5F
    dfar Data_065_7A30
    dfar Data_066_5AE7
    dfar Data_065_7AAA
    dfar Data_064_7E22
    dfar Data_064_75F2
    dfar Data_063_7C12
    dfar Data_064_7661
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_062_732E
    dfar Data_063_7ADE
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_4C79
    dfar Data_066_52C5
    dfar Data_066_54FD ; id 1
    dfar Data_065_6991
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_063_76CB
    dfar Data_066_46C5
    dfar Data_064_6F23
    dfar Data_065_74B6
    dfar Data_064_73B7
    dfar Data_065_6546
    dfar Data_065_5DD4
    dfar Data_065_6C81
    dfar Data_064_7848
    dfar Data_066_44A5
    dfar Data_066_4635
    dfar Data_066_4DE4
Data_067_5BD9:: ; heuristic: label inside a table; C0
    dfar Data_066_5A5F
    dfar Data_065_6C25
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_063_7B7B
    dfar Data_066_4B6F
    dfar Data_064_75A9
    dfar Data_065_7A51
    dfar Data_064_7730
    dfar Data_065_6AC6
    dfar Data_065_62D2
    dfar Data_065_7251
    dfar Data_064_7DFB
    dfar Data_066_4AD3
    dfar Data_066_4B3B
    dfar Data_066_52E9

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2COrder::
Data_067_5C09:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup2D::
Data_067_5C0B:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_065_74B6
    dfar Data_066_55DC
    dfar Data_065_74B6
    dfar Data_064_7848
    dfar Data_064_706F
    dfar Data_064_78B1
    dfar Data_064_72E0
    dfar Data_065_74B6
    dfar Data_064_7CD5
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_7A51
    dfar Data_066_5AB9
    dfar Data_065_7A51
    dfar Data_064_7DFB
    dfar Data_064_761D
    dfar Data_064_7E22
    dfar Data_064_76F7
    dfar Data_065_7A51
    dfar Data_064_7F84
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_5560 ; id 1
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_5F42
    dfar Data_062_6D6B
    dfar Data_065_7641
    dfar Data_066_5CC8
    dfar Data_066_4635
    dfar Data_063_6BCD
    dfar Data_062_6EDC
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_44A5
    dfar Data_066_4D7D
    dfar Data_066_5A87
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_634B
    dfar Data_062_732E
    dfar Data_065_7AE1
    dfar Data_066_615D
    dfar Data_066_4B3B
    dfar Data_063_7181
    dfar Data_062_73A7
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_4AD3
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2DOrder::
Data_067_5CCB:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup2E::
Data_067_5CCD:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_596B
    dfar Data_065_643F
    dfar Data_065_751D
    dfar Data_066_5560
    dfar Data_065_5F42
    dfar Data_064_6797
    dfar Data_064_706F
    dfar Data_062_7517
    dfar Data_062_4642
    dfar Data_062_6D6B
    dfar Data_063_7793
    dfar Data_064_78B1
    dfar Data_066_478E
    dfar Data_066_45B4
    dfar Data_066_4EF7
    dfar Data_066_615D
    dfar Data_066_5BD9
    dfar Data_065_6A71
    dfar Data_065_7A80
    dfar Data_066_5A87
    dfar Data_065_634B
    dfar Data_064_6D09
    dfar Data_064_761D
    dfar Data_062_7B3B
    dfar Data_062_4A9A
    dfar Data_062_732E
    dfar Data_063_7BD2
    dfar Data_064_7E22
    dfar Data_066_4BC0
    dfar Data_066_4B1A
    dfar Data_066_5342
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_4E6E
    dfar Data_066_54FD
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5311
    dfar Data_066_5A5F
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_52C5
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2EOrder::
Data_067_5D8D:: ; heuristic: start of a structured table; C0
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup2F::
Data_067_5D8F:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_5E8C
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_066_44A5
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6301
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_066_4AD3
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_6808 ; id 1
    dfar Data_065_794A
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_4507
    dfar Data_062_6D6B
    dfar Data_065_6546
    dfar Data_065_7878
    dfar Data_063_6FC0
    dfar Data_064_6828
    dfar Data_063_7073
    dfar Data_065_6D0D
    dfar Data_064_7B56
    dfar Data_066_4D7D
    dfar Data_064_7848
    dfar Data_066_4D7D
    dfar Data_065_6B9F
    dfar Data_065_7BE4
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_4A36
    dfar Data_062_732E
    dfar Data_065_6AC6
    dfar Data_065_7B9E
    dfar Data_063_72C9
    dfar Data_064_6D28
    dfar Data_063_7306
    dfar Data_065_7279
    dfar Data_064_7F00
    dfar Data_066_52C5
    dfar Data_064_7DFB
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2FOrder::
Data_067_5E4F:: ; heuristic: start of a structured table; C0
    db $01, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup30::
Data_067_5E51:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5560
    dfar Data_065_65EA
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_065_5C71
    dfar Data_062_5337
    dfar Data_066_54FD
    dfar Data_065_5D1D
    dfar Data_062_50CE
    dfar Data_065_5737
    dfar Data_062_7517
    dfar Data_062_41C9
    dfar Data_063_6148
    dfar Data_064_6272
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_6AEA
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_065_6244
    dfar Data_062_573B
    dfar Data_066_5A5F
    dfar Data_065_6293
    dfar Data_062_566F
    dfar Data_065_5A75
    dfar Data_062_7B3B
    dfar Data_062_492F
    dfar Data_063_63FE
    dfar Data_064_657E
    dfar Data_065_6693 ; id 1
    dfar Data_065_77A4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_431E
    dfar Data_062_702C
    dfar Data_065_743F
    dfar Data_066_5CC8
    dfar Data_064_544D
    dfar Data_062_423A
    dfar Data_062_6CE1
    dfar Data_065_7878
    dfar Data_063_48FA
    dfar Data_062_41C9
    dfar Data_062_4001
    dfar Data_065_6C81
    dfar Data_065_6B2C
    dfar Data_065_7B60
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_46BF
    dfar Data_062_7409
    dfar Data_065_7A30
    dfar Data_066_615D
    dfar Data_064_5794
    dfar Data_062_494B
    dfar Data_062_7306
    dfar Data_065_7B9E
    dfar Data_063_4BF0
    dfar Data_062_492F
    dfar Data_062_48AC
    dfar Data_065_7251
    dfar Data_062_774A ; id 2
    dfar Data_062_406A
    dfar Data_063_5DED
    dfar Data_062_662E
    dfar Data_064_7848
    dfar Data_063_6C79
    dfar Data_064_48DA
    dfar Data_063_52A2
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_063_6EFF
    dfar Data_062_41C9
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_066_46C5
    dfar Data_062_7BFD
    dfar Data_062_48C0
    dfar Data_063_6298
    dfar Data_062_6AE8
    dfar Data_064_7DFB
    dfar Data_063_71D4
    dfar Data_064_4BC1
    dfar Data_063_5744
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_063_729A
    dfar Data_062_492F
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_066_4B6F
    dfar Data_064_5AD4 ; id 3
    dfar Data_065_431E
    dfar Data_062_4365
    dfar Data_065_70BD
    dfar Data_063_54F8
    dfar Data_063_472D
    dfar Data_064_66F6
    dfar Data_066_4CD6
    dfar Data_062_43CA
    dfar Data_064_6828
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_4546
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_5E8E
    dfar Data_065_46BF
    dfar Data_062_49AA
    dfar Data_065_73A8
    dfar Data_063_5822
    dfar Data_063_4B25
    dfar Data_064_6CC4
    dfar Data_066_52A0
    dfar Data_062_49C6
    dfar Data_064_6D28
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_4AF5
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup30Order::
Data_067_5FD1:: ; heuristic: start of a structured table; C0
    db $00, $01, $02, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup31::
Data_067_5FD5:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5658
    dfar Data_065_65EA
    dfar Data_065_6546
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_063_6FC0
    dfar Data_062_406A
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7B56
    dfar Data_063_6E4E
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6AEA
    dfar Data_065_6AC6
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_063_72C9
    dfar Data_062_48C0
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_063_7250
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_065_68B7 ; id 1
    dfar Data_065_6693
    dfar Data_065_643F
    dfar Data_065_75A3
    dfar Data_062_5166
    dfar Data_064_5B93
    dfar Data_065_431E
    dfar Data_065_6D65
    dfar Data_064_454F
    dfar Data_063_53B1
    dfar Data_063_47D4
    dfar Data_065_6C81
    dfar Data_066_45B4
    dfar Data_063_6D0B
    dfar Data_064_6A43
    dfar Data_066_5115
    dfar Data_065_6BD1
    dfar Data_065_6B2C
    dfar Data_065_6A71
    dfar Data_065_7AAA
    dfar Data_062_569C
    dfar Data_064_5ED5
    dfar Data_065_46BF
    dfar Data_065_7290
    dfar Data_064_4A58
    dfar Data_063_57AC
    dfar Data_063_4B70
    dfar Data_065_7251
    dfar Data_066_4B1A
    dfar Data_063_71F3
    dfar Data_064_6DC8
    dfar Data_066_53DF
    dfar Data_066_589C ; id 2
    dfar Data_065_6808
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_062_75B0
    dfar Data_062_40EE
    dfar Data_062_6EDC
    dfar Data_065_6693
    dfar Data_062_7517
    dfar Data_062_43CA
    dfar Data_062_4365
    dfar Data_064_697E
    dfar Data_064_7848
    dfar Data_066_45B4
    dfar Data_066_4635
    dfar Data_066_4EF7
    dfar Data_066_5B97
    dfar Data_065_6B9F
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_062_7B66
    dfar Data_062_48DA
    dfar Data_062_73A7
    dfar Data_065_6B2C
    dfar Data_062_7B3B
    dfar Data_062_49C6
    dfar Data_062_49AA
    dfar Data_064_6D86
    dfar Data_064_7DFB
    dfar Data_066_4B1A
    dfar Data_066_4B3B
    dfar Data_066_5342
    dfar Data_066_54FD ; id 3
    dfar Data_065_5C71
    dfar Data_062_6E33
    dfar Data_065_7641
    dfar Data_063_74A4
    dfar Data_063_6B43
    dfar Data_062_41C9
    dfar Data_065_70BD
    dfar Data_066_4E6E
    dfar Data_062_7517
    dfar Data_064_68E4
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_066_5A5F
    dfar Data_065_6244
    dfar Data_062_737B
    dfar Data_065_7AE1
    dfar Data_063_7ADE
    dfar Data_063_7151
    dfar Data_062_492F
    dfar Data_065_73A8
    dfar Data_066_5311
    dfar Data_062_7B3B
    dfar Data_064_6D64
    dfar Data_066_53AD
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_066_5366
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup31Order::
Data_067_6155:: ; heuristic: start of a structured table; C0
    db $03, $01, $02, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup32::
Data_067_6159:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_57D9
    dfar Data_065_68B7
    dfar Data_065_751D
    dfar Data_066_5560
    dfar Data_065_5BD1
    dfar Data_062_4365
    dfar Data_062_6D6B
    dfar Data_062_75B0
    dfar Data_062_42B3
    dfar Data_062_5337
    dfar Data_064_5AD4
    dfar Data_062_76AE
    dfar Data_062_5337
    dfar Data_062_5D6D
    dfar Data_063_531D
    dfar Data_066_615D
    dfar Data_066_5B5A
    dfar Data_065_6BD1
    dfar Data_065_7A80
    dfar Data_066_5A87
    dfar Data_065_6216
    dfar Data_062_49AA
    dfar Data_062_732E
    dfar Data_062_7B66
    dfar Data_062_4967
    dfar Data_062_573B
    dfar Data_064_5E8E
    dfar Data_062_7BC5
    dfar Data_062_573B
    dfar Data_062_6352
    dfar Data_063_5769
    dfar Data_066_5658 ; id 1
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_5D1D
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_445B
    dfar Data_062_6CE1
    dfar Data_065_65EA
    dfar Data_065_7641
    dfar Data_063_4867
    dfar Data_062_42B3
    dfar Data_064_6797
    dfar Data_066_4D7D
    dfar Data_066_5AE7
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_6293
    dfar Data_065_7279
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_473E
    dfar Data_062_7306
    dfar Data_065_6AEA
    dfar Data_065_7AE1
    dfar Data_063_4BB7
    dfar Data_062_4967
    dfar Data_064_6D09
    dfar Data_066_52C5
    dfar Data_062_7517 ; id 2
    dfar Data_064_454F
    dfar Data_063_468C
    dfar Data_064_6659
    dfar Data_064_78B1
    dfar Data_063_6DB3
    dfar Data_062_423A
    dfar Data_065_70BD
    dfar Data_066_5CC8
    dfar Data_062_78C0
    dfar Data_062_42B3
    dfar Data_062_70C1
    dfar Data_066_5CC8
Data_067_6240:: ; heuristic: label inside a table; C0
    dfar Data_064_7945
Data_067_6243:: ; heuristic: label inside a table; C0
    dfar Data_066_46C5
    dw Data_066_478E
Data_067_6248:: ; heuristic: label inside a table; C0
    db $66
Data_067_6249:: ; heuristic: label inside a table; C0
    dfar Data_062_7B3B
    dfar Data_064_4A58
    dfar Data_063_4AF5
    dfar Data_064_6C95
    dfar Data_064_7E22
    dfar Data_063_722B
    dfar Data_062_494B
    dfar Data_065_73A8
    dfar Data_066_615D
    dfar Data_062_7C82
    dfar Data_062_4967
    dfar Data_062_744A
    dfar Data_066_615D
Data_067_6270:: ; heuristic: label inside a table; C0
    dfar Data_064_7E51
Data_067_6273:: ; heuristic: label inside a table; C0
    dfar Data_066_4B6F
    dfar Data_066_4BC0
    dfar Data_063_6DB3 ; id 3
    dfar Data_062_41C9
    dfar Data_062_6E33
    dfar Data_065_74B6
    dfar Data_064_7A7D
    dfar Data_063_6B43
    dfar Data_064_6659
    dfar Data_066_4CD6
    dw Data_065_7641
Data_067_6293:: ; heuristic: label inside a table; C0
    db $65
    dfar Data_062_78C0
    dfar Data_065_70BD
    dfar Data_066_5CC8
    dfar Data_066_4E6E
    dfar Data_064_78B1
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_063_722B
    dfar Data_062_492F
    dfar Data_062_737B
    dfar Data_065_7A51
    dfar Data_064_7EB0
    dfar Data_063_7151
    dfar Data_064_6C95
    dfar Data_066_52A0
    dfar Data_065_7AE1
    dfar Data_062_7C82
    dfar Data_065_73A8
    dfar Data_066_615D
    dfar Data_066_5311
    dfar Data_064_7E22
    dfar Data_066_52C5
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup32Order::
Data_067_62D9:: ; heuristic: start of a structured table; C0
    db $01, $02, $00, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup33::
Data_067_62DD:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_6693
    dfar Data_065_65EA
    dfar Data_065_64CA
    dfar Data_062_7626
    dfar Data_062_4365
    dfar Data_062_40EE
    dfar Data_062_4365
    dfar Data_062_77EB
    dfar Data_062_423A
    dfar Data_062_406A
    dfar Data_062_42B3
    dfar Data_064_79CF
    dfar Data_063_6FC0
    dfar Data_064_6659
    dfar Data_066_4917
    dfar Data_066_5A5F
    dfar Data_065_6B2C
    dfar Data_065_6AEA
    dfar Data_065_6A8F
    dfar Data_062_7B96
    dfar Data_062_49AA
    dfar Data_062_48DA
    dfar Data_062_49AA
    dfar Data_062_7C25
    dfar Data_062_494B
    dfar Data_062_48C0
    dfar Data_062_4967
    dfar Data_064_7E84
    dfar Data_063_72C9
    dfar Data_064_6C95
    dfar Data_066_4C37
    dfar Data_065_743F ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_7175
    dfar Data_065_6736
    dfar Data_065_65EA
    dfar Data_065_74B6
    dfar Data_063_6EFF
    dfar Data_062_423A
    dfar Data_062_40EE
    dfar Data_065_6C81
    dfar Data_065_7A30
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dw Data_065_7279
Data_067_637B:: ; heuristic: label inside a table; C0
    db $65
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7480
    dfar Data_065_6B50
    dfar Data_065_6AEA
    dfar Data_065_7A51
    dfar Data_063_729A
    dfar Data_062_494B
    dfar Data_062_48DA
    dfar Data_065_7251
    dfar Data_066_5CC8 ; id 2
    dfar Data_062_7626
    dfar Data_065_6DE3
    dfar Data_066_5658
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_064_72E0
    dfar Data_065_5F42
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_063_6B43
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_065_72B2
    dfar Data_066_5AE7
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_064_76F7
    dfar Data_065_634B
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_063_7151
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_065_5DD4 ; id 3
    dfar Data_062_40EE
    dfar Data_062_4365
    dfar Data_065_6D65
    dfar Data_062_42B3
    dfar Data_064_68E4
    dfar Data_063_6E4E
    dfar Data_065_70BD
    dfar Data_062_4365
    dfar Data_062_6D6B
    dfar Data_065_5DD4
    dfar Data_065_6C81
    dfar Data_066_4917
    dfar Data_066_44A5
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_065_62D2
    dfar Data_062_48DA
    dfar Data_062_49AA
    dfar Data_065_7290
    dfar Data_062_4967
    dfar Data_064_6D64
    dfar Data_063_7250
    dfar Data_065_73A8
    dfar Data_062_49AA
    dfar Data_062_732E
    dfar Data_065_62D2
    dfar Data_065_7251
    dfar Data_066_4C37
    dfar Data_066_4AD3
    dfar Data_066_4B1A
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup33Order::
Data_067_645D:: ; heuristic: start of a structured table; C0
    db $03, $00, $02, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup34::
Data_067_6461:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dw Data_066_5CC8
Data_067_6469:: ; heuristic: label inside a table; C0
    db $66
    dfar Data_066_5CC8
Data_067_646D:: ; heuristic: label inside a table; C0
    dw Data_066_5CC8
Data_067_646F:: ; heuristic: label inside a table; C0
    db $66
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dw Data_066_5CC8
Data_067_6478:: ; heuristic: label inside a table; C0
    db $66
Data_067_6479:: ; heuristic: label inside a table; C0
    dfar Data_066_5CC8
    dw Data_066_5CC8
Data_067_647E:: ; heuristic: label inside a table; C0
    db $66
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_65EA
    dfar Data_065_6546
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
    dfar Data_066_5AE7
    dfar Data_065_6AEA
    dfar Data_065_6AC6
    dfar Data_066_589C ; id 1
    dfar Data_065_64CA
    dfar Data_065_643F
    dfar Data_065_77A4
    dfar Data_062_774A
    dfar Data_062_5485
    dfar Data_065_4291
    dfar Data_065_6F70
    dfar Data_062_7626
    dfar Data_063_6047
    dfar Data_064_5218
    dfar Data_065_6DE3
    dfar Data_065_5DD4
    dfar Data_063_6148
    dfar Data_064_5128
    dfar Data_065_6D0D
    dfar Data_066_5B97
    dfar Data_065_6A8F
    dfar Data_065_6A71
    dfar Data_065_7B60
    dfar Data_062_7BFD
    dfar Data_062_57A2
    dfar Data_065_469B
    dfar Data_065_7334
    dfar Data_062_7B96
    dfar Data_063_6383
    dfar Data_064_56B0
    dfar Data_065_72B2
    dfar Data_065_62D2
    dfar Data_063_63FE
    dfar Data_064_5653
    dfar Data_065_7279
    dfar Data_066_5CC8 ; id 2
    dfar Data_062_7985
    dfar Data_062_5166
    dfar Data_064_594F
    dfar Data_066_5705
    dfar Data_065_5FE5
    dfar Data_064_46A7
    dfar Data_063_65BE
    dfar Data_062_7517
    dfar Data_062_423A
    dfar Data_062_42B3
    dfar Data_064_4734
    dfar Data_064_7848
    dfar Data_066_44A5
    dfar Data_066_4859
    dfar Data_066_45B4
    dfar Data_066_615D
    dfar Data_062_7CBA
    dfar Data_062_569C
    dfar Data_064_5DEE
    dfar Data_066_5B0F
    dfar Data_065_6391
    dfar Data_064_4AD9
    dfar Data_063_69A8
    dfar Data_062_7B3B
    dfar Data_062_494B
    dfar Data_062_4967
    dw Data_064_4B1E
Data_067_6574:: ; heuristic: label inside a table; C0
    db $64
Data_067_6575:: ; heuristic: label inside a table; C0
    dfar Data_064_7DFB
    dw Data_066_4AD3
Data_067_657A:: ; heuristic: label inside a table; C0
    db $66
    dfar Data_066_4C04
    dfar Data_066_4B1A
    dfar Data_065_445B ; id 3
    dfar Data_064_460E
    dfar Data_063_453F
    dfar Data_065_7023
    dfar Data_064_5218
    dfar Data_062_4001
    dfar Data_064_68E4
    dfar Data_066_4F98
    dfar Data_063_468C
    dfar Data_062_406A
    dfar Data_065_6DE3
    dfar Data_066_5CC8
    dfar Data_066_46C5
    dfar Data_066_478E
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_065_473E
    dfar Data_064_4AA9
    dfar Data_063_4A65
    dfar Data_065_737C
    dfar Data_064_56B0
    dfar Data_062_48AC
    dfar Data_064_6D64
    dfar Data_066_5366
    dfar Data_063_4AF5
    dfar Data_062_48C0
    dfar Data_065_72B2
    dfar Data_066_615D
    dfar Data_066_4B6F
    dfar Data_066_4BC0
    dfar Data_066_53AD
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup34Order::
Data_067_65E1:: ; heuristic: start of a structured table; C0
    db $00, $01, $03, $02 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup35::
Data_067_65E5:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5705 ; id 0
    dfar Data_065_6808
    dfar Data_065_6736
    dfar Data_065_7641
    dfar Data_062_774A
    dfar Data_062_5519
    dfar Data_065_4041
    dfar Data_065_6DE3
    dfar Data_062_76AE
    dfar Data_064_44CC
    dfar Data_063_453F
    dfar Data_062_6E33
    dfar Data_064_78B1
    dfar Data_063_6BCD
    dfar Data_062_43CA
    dfar Data_062_406A
    dfar Data_066_5B0F
    dfar Data_065_6B9F
    dfar Data_065_6B50
    dfar Data_065_7AE1
    dfar Data_062_7BFD
    dfar Data_062_57D8
    dfar Data_065_45C0
    dfar Data_065_72B2
    dfar Data_062_7BC5
    dfar Data_064_4A2C
    dfar Data_063_4A65
    dfar Data_062_737B
    dfar Data_064_7E22
    dfar Data_063_7181
    dfar Data_062_49C6
    dw Data_062_48C0
Data_067_6644:: ; heuristic: label inside a table; C0
    db $62
Data_067_6645:: ; heuristic: label inside a table; C0
    dfar Data_066_5477 ; id 1
    dw Data_065_64CA
Data_067_664A:: ; heuristic: label inside a table; C0
    db $65
Data_067_664B:: ; heuristic: label inside a table; C0
    dw Data_065_65EA
Data_067_664D:: ; heuristic: label inside a table; C0
    db $65
Data_067_664E:: ; heuristic: label inside a table; C0
    dfar Data_065_76ED
    dw Data_062_7985
Data_067_6653:: ; heuristic: label inside a table; C0
    db $62
Data_067_6654:: ; heuristic: label inside a table; C0
    dfar Data_064_6797
    dfar Data_063_6DB3
    dw Data_065_70BD
Data_067_665C:: ; heuristic: label inside a table; C0
    db $65
    dfar Data_063_7793
    dfar Data_066_4E6E
    dfar Data_062_7626
    dfar Data_065_7023
    dfar Data_062_702C
    dfar Data_065_6693
    dfar Data_062_75B0
    dfar Data_066_5115
    dfar Data_066_5A3B
    dfar Data_065_6A8F
    dfar Data_065_6AEA
    dfar Data_065_7B11
    dfar Data_062_7CBA
    dfar Data_064_6D09
    dfar Data_063_722B
    dfar Data_065_73A8
    dfar Data_063_7BD2
    dfar Data_066_5311
    dfar Data_062_7B96
    dfar Data_065_737C
    dfar Data_062_7409
    dfar Data_065_6B2C
    dfar Data_062_7B66
    dfar Data_066_53DF
    dfar Data_066_5CC8 ; id 2
    dfar Data_064_79CF
    dfar Data_063_6E4E
    dfar Data_062_4365
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_76AE
    dfar Data_062_4001
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_063_6BCD
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_063_7250
    dfar Data_062_49AA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7BC5
    dfar Data_062_48AC
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_063_7181
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_062_41C9 ; id 3
    dfar Data_062_423A
    dfar Data_062_702C
    dfar Data_065_77A4
    dfar Data_062_42B3
    dfar Data_064_6AEC
    dfar Data_063_6EFF
    dfar Data_065_6DE3
    dfar Data_062_40EE
    dfar Data_065_6D0D
    dfar Data_064_7A7D
    dfar Data_066_4EF7
    dfar Data_066_4546
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_492F
    dfar Data_062_494B
    dfar Data_062_7409
    dfar Data_065_7B60
    dfar Data_062_4967
    dfar Data_064_6DFE
    dfar Data_063_729A
    dfar Data_065_72B2
    dfar Data_062_48DA
    dfar Data_065_7279
    dfar Data_064_7EB0
    dfar Data_066_5342
    dfar Data_066_4AF5
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup35Order::
Data_067_6765:: ; heuristic: start of a structured table; C0
    db $02, $03, $01, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup36::
Data_067_6769:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_64CA
    dfar Data_065_6808
    dfar Data_065_65EA
    dfar Data_062_75B0
    dfar Data_062_5485
    dfar Data_065_431E
    dfar Data_064_68E4
    dfar Data_062_7626
    dfar Data_064_4843
    dfar Data_063_4867
    dfar Data_065_7023
    dfar Data_062_76AE
    dfar Data_064_6A43
    dfar Data_066_4859
    dfar Data_064_72E0
    dfar Data_066_5A5F
    dfar Data_065_6A8F
    dfar Data_065_6B9F
    dfar Data_065_6AEA
    dfar Data_062_7B66
    dfar Data_062_57A2
    dfar Data_065_46BF
    dfar Data_064_6D64
    dfar Data_062_7B96
    dfar Data_064_4B88
    dfar Data_063_4BB7
    dfar Data_065_737C
    dfar Data_062_7BC5
    dfar Data_064_6DC8
    dfar Data_066_4C04
    dfar Data_064_76F7
    dfar Data_065_6546 ; id 1
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_45B4
    dfar Data_064_6FCF
    dfar Data_065_6546
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_062_7626
    dfar Data_062_40EE
    dfar Data_065_6D65
    dfar Data_065_75A3
    dfar Data_062_76AE
    dfar Data_062_41C9
    dfar Data_065_6DE3
    dfar Data_065_6AC6
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_4B1A
    dfar Data_064_75F2
    dfar Data_065_6AC6
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_062_7B96
    dfar Data_062_48DA
    dfar Data_065_7290
    dfar Data_065_7AAA
    dfar Data_062_7BC5
    dfar Data_062_492F
    dfar Data_065_72B2
    dfar Data_062_76AE ; id 2
    dfar Data_062_6EDC
    dfar Data_065_75A3
    dfar Data_064_7945
    dfar Data_064_79CF
    dfar Data_063_6D0B
    dfar Data_062_6F90
    dfar Data_065_65EA
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_063_6DB3
    dfar Data_062_423A
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_066_46C5
    dfar Data_062_7BC5
    dfar Data_062_73A7
    dfar Data_065_7AAA
    dfar Data_064_7E51
    dfar Data_064_7E84
    dfar Data_063_71F3
    dfar Data_062_73E8
    dfar Data_065_6AEA
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_063_722B
    dfar Data_062_494B
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_066_4B6F
    dfar Data_066_4F98 ; id 3
    dfar Data_062_77EB
    dfar Data_062_42B3
    dfar Data_065_6F70
    dfar Data_065_6736
    dfar Data_065_5F42
    dfar Data_064_697E
    dfar Data_066_4F98
    dfar Data_064_6A43
    dfar Data_066_4859
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5366
    dfar Data_062_7C25
    dfar Data_062_4967
    dfar Data_065_7334
    dfar Data_065_6B50
    dfar Data_065_634B
    dfar Data_064_6D86
    dfar Data_066_5366
    dfar Data_064_6DC8
    dfar Data_066_4C04
    dfar Data_066_53AD
    dfar Data_066_615D
    dfar Data_066_53AD
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup36Order::
Data_067_68E9:: ; heuristic: start of a structured table; C0
    db $02, $03, $00, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup37::
Data_067_68ED:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_64CA
    dfar Data_065_7878
    dfar Data_066_589C
    dfar Data_062_7985
    dfar Data_064_6AEC
    dfar Data_066_5115
    dfar Data_064_7C14
    dfar Data_062_78C0
    dfar Data_065_6C81
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_062_70C1
    dfar Data_065_77A4
    dfar Data_066_57D9
    dfar Data_066_5A5F
    dfar Data_065_6A8F
    dfar Data_065_7B9E
    dfar Data_066_5B97
    dfar Data_062_7CBA
    dfar Data_064_6DFE
    dfar Data_066_53DF
    dfar Data_064_7F35
    dfar Data_062_7C82
    dfar Data_065_7251
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_062_744A
    dfar Data_065_7B60
    dfar Data_066_5B5A
    dfar Data_065_6736 ; id 1
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_063_6E4E
    dfar Data_062_702C
    dfar Data_065_6693
    dfar Data_065_7641
    dfar Data_062_77EB
    dfar Data_062_42B3
    dfar Data_064_68E4
    dfar Data_066_4EF7
    dfar Data_065_5F42
    dfar Data_064_697E
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_065_6B50
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_063_7250
    dfar Data_062_7409
    dfar Data_065_6B2C
    dfar Data_065_7AE1
    dfar Data_062_7C25
    dfar Data_062_4967
    dfar Data_064_6D64
    dfar Data_066_5342
    dfar Data_065_634B
    dfar Data_064_6D86
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_062_76AE ; id 2
    dfar Data_062_41C9
    dfar Data_062_6EDC
    dfar Data_065_5DD4
    dfar Data_062_774A
    dfar Data_062_42B3
    dfar Data_062_528E
    dfar Data_065_41F0
    dfar Data_064_79CF
    dfar Data_063_6D0B
    dfar Data_064_454F
    dfar Data_063_453F
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_066_45B4
    dfar Data_066_4546
    dfar Data_062_7BC5
    dfar Data_062_492F
    dfar Data_062_73A7
    dfar Data_065_62D2
    dfar Data_062_7BFD
    dfar Data_062_4967
    dfar Data_062_56FE
    dfar Data_065_4662
    dfar Data_064_7E84
    dfar Data_063_71F3
    dfar Data_064_4A58
    dfar Data_063_4A65
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_066_4B1A
    dfar Data_066_4AF5
    dfar Data_062_43CA ; id 3
    dfar Data_065_70BD
    dfar Data_066_54FD
    dfar Data_065_74B6
    dfar Data_064_6AEC
    dfar Data_066_5115
    dfar Data_062_75B0
    dfar Data_065_6D0D
    dfar Data_062_7175
    dfar Data_065_68B7
    dfar Data_065_5D1D
    dfar Data_065_6D65
    dfar Data_066_4917
    dfar Data_066_46C5
    dfar Data_066_45B4
    dfar Data_066_4DE4
    dfar Data_062_49C6
    dfar Data_065_73A8
    dfar Data_066_5A5F
    dfar Data_065_7A51
    dfar Data_064_6DFE
    dfar Data_066_53DF
    dfar Data_062_7B66
    dfar Data_065_7279
    dfar Data_062_7480
    dfar Data_065_6BD1
    dfar Data_065_6293
    dfar Data_065_7290
    dfar Data_066_4C37
    dfar Data_066_4B6F
    dfar Data_066_4B1A
    dfar Data_066_52E9

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup37Order::
Data_067_6A6D:: ; heuristic: start of a structured table; C0
    db $01, $00, $02, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup38::
Data_067_6A71:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_64CA
    dfar Data_066_5CC8
    dfar Data_066_5560
    dfar Data_065_5C71
    dfar Data_062_423A
    dfar Data_066_55DC
    dfar Data_065_5D1D
    dfar Data_062_406A
    dfar Data_062_43CA
    dfar Data_062_76AE
    dfar Data_062_40EE
    dfar Data_062_42B3
    dfar Data_062_4365
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6A8F
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_6244
    dfar Data_062_494B
    dfar Data_066_5AB9
    dfar Data_065_6293
    dfar Data_062_48C0
    dfar Data_062_49C6
    dfar Data_062_7BC5
    dfar Data_062_48DA
    dfar Data_062_4967
    dfar Data_062_49AA
    dfar Data_065_65EA ; id 1
    dfar Data_065_743F
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_41C9
    dfar Data_062_6D6B
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_062_406A
    dfar Data_062_423A
    dfar Data_062_6E33
    dfar Data_065_751D
    dfar Data_062_40EE
    dfar Data_062_4365
    dfar Data_062_42B3
    dfar Data_065_6E8B
    dfar Data_065_6AEA
    dfar Data_065_7A30
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_492F
    dfar Data_062_732E
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_062_48C0
    dfar Data_062_494B
    dfar Data_062_737B
    dfar Data_065_7A80
    dfar Data_062_48DA
    dfar Data_062_49AA
    dfar Data_062_4967
    dfar Data_065_72E6
    dfar Data_062_7985 ; id 2
    dfar Data_062_43CA
    dfar Data_062_41C9
    dfar Data_062_406A
    dfar Data_064_7A7D
    dfar Data_063_6DB3
    dfar Data_062_4365
    dfar Data_062_43CA
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_063_6B43
    dfar Data_062_4365
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_066_4546
    dfar Data_062_7CBA
    dfar Data_062_49C6
    dfar Data_062_492F
    dfar Data_062_48C0
    dfar Data_064_7EB0
    dfar Data_063_722B
    dfar Data_062_49AA
    dfar Data_062_49C6
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_063_7151
    dfar Data_062_49AA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_066_4AF5
    dfar Data_062_42B3 ; id 3
    dfar Data_062_423A
    dfar Data_062_40EE
    dfar Data_065_70BD
    dw Data_062_4001
Data_067_6B9F:: ; heuristic: label inside a table; C0
    db $62
    dfar Data_062_4001
    dfar Data_064_6828
    dfar Data_066_4E6E
    dfar Data_062_406A
    dfar Data_064_6797
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_4546
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_4967
    dfar Data_062_494B
    dfar Data_062_48DA
    dfar Data_065_73A8
    dfar Data_062_48AC
    dfar Data_062_48AC
    dfar Data_064_6D28
    dfar Data_066_5311
    dfar Data_062_48C0
    dfar Data_064_6D09
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_4AF5
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup38Order::
Data_067_6BF1:: ; heuristic: start of a structured table; C0
    db $00, $02, $01, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup39::
Data_067_6BF5:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_066_5CC8
    dfar Data_066_5705
    dfar Data_065_65EA
    dfar Data_065_5E8C
    dfar Data_066_589C
    dfar Data_065_5D1D
    dfar Data_062_43CA
    dfar Data_062_40EE
    dfar Data_062_75B0
    dfar Data_062_4365
    dfar Data_064_6A43
    dfar Data_063_6E4E
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_065_6AEA
    dfar Data_065_6301
    dfar Data_066_5B97
    dfar Data_065_6293
    dfar Data_062_49C6
    dfar Data_062_48DA
    dfar Data_062_7B66
    dfar Data_062_49AA
    dfar Data_064_6DC8
    dfar Data_063_7250
    dfar Data_065_6693 ; id 1
    dfar Data_065_65EA
    dfar Data_065_68B7
    dfar Data_065_7641
    dfar Data_062_53C7
    dfar Data_064_594F
    dfar Data_065_43BD
    dfar Data_065_6DE3
    dfar Data_064_4843
    dfar Data_063_5229
    dfar Data_063_47D4
    dfar Data_065_6D65
    dfar Data_064_6AEC
    dfar Data_063_6B43
    dfar Data_062_423A
    dfar Data_065_6D0D
    dfar Data_065_6B2C
    dfar Data_065_6AEA
    dfar Data_065_6BD1
    dfar Data_065_7AE1
    dfar Data_062_5761
    dfar Data_064_5DEE
    dfar Data_065_470B
    dfar Data_065_72B2
    dfar Data_064_4B88
    dfar Data_063_570C
    dfar Data_063_4B70
    dfar Data_065_7290
    dfar Data_064_6DFE
    dfar Data_063_7151
    dfar Data_062_494B
    dfar Data_065_7279
    dfar Data_062_7985 ; id 2
    dfar Data_062_423A
    dfar Data_065_6F70
    dfar Data_062_774A
    dfar Data_062_7517
    dfar Data_062_406A
    dfar Data_065_6D65
    dfar Data_064_7945
    dfar Data_062_75B0
    dfar Data_064_6797
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_7CBA
    dfar Data_062_494B
    dfar Data_065_7334
    dfar Data_062_7BFD
    dfar Data_062_7B3B
    dfar Data_062_48C0
    dfar Data_065_7290
    dfar Data_064_7E51
    dfar Data_062_7B66
    dfar Data_064_6D09
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_6D0D ; id 3
    dfar Data_062_7626
    dfar Data_064_6828
    dfar Data_066_4EF7
    dfar Data_066_4CD6
    dfar Data_064_7C14
    dfar Data_064_72E0
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_75B0
    dfar Data_065_6DE3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_4DE4
    dfar Data_065_7279
    dfar Data_062_7B96
    dfar Data_064_6D28
    dfar Data_066_5342
    dfar Data_066_52A0
    dfar Data_064_7F35
    dfar Data_064_76F7
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7B66
    dfar Data_065_72B2
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_52E9

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup39Order::
Data_067_6D75:: ; heuristic: start of a structured table; C0
    db $03, $01, $02, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup3A::
Data_067_6D79:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_6736
    dfar Data_065_6693
    dfar Data_065_75A3
    dfar Data_062_7626
    dfar Data_062_4365
    dfar Data_064_6A43
    dfar Data_064_720E
    dfar Data_062_76AE
    dfar Data_064_6AEC
    dfar Data_066_5115
    dfar Data_064_78B1
    dfar Data_064_79CF
    dfar Data_066_4CD6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5A5F
    dfar Data_065_6B50
    dfar Data_065_6B2C
    dfar Data_065_7AAA
    dfar Data_062_7B96
    dfar Data_062_49AA
    dfar Data_064_6DC8
    dfar Data_064_76A3
    dfar Data_062_7BC5
    dfar Data_064_6DFE
    dfar Data_066_53DF
    dfar Data_064_7E22
    dfar Data_064_7E84
    dfar Data_066_52A0
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5560 ; id 1
    dfar Data_065_743F
    dfar Data_066_54FD
    dfar Data_065_74B6
    dfar Data_065_5F42
    dfar Data_062_7175
    dfar Data_063_74A4
    dfar Data_066_5115
    dfar Data_066_4859
    dfar Data_063_6E4E
    dfar Data_062_6EDC
    dfar Data_065_77A4
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_063_6DB3
    dfar Data_065_6F70
    dfar Data_066_5A87
    dfar Data_065_7A30
    dfar Data_066_5A5F
    dfar Data_065_7A51
    dfar Data_065_634B
    dfar Data_062_7480
    dfar Data_063_7ADE
    dfar Data_066_53DF
    dfar Data_066_4C04
    dfar Data_063_7250
    dfar Data_062_73A7
    dfar Data_065_7B60
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_063_722B
    dfar Data_065_7334
    dfar Data_066_5CC8 ; id 2
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_066_5560
    dfar Data_065_76ED
    dfar Data_066_589C
    dfar Data_065_5E8C
    dfar Data_062_75B0
    dfar Data_062_6EDC
    dfar Data_065_60A2
    dfar Data_062_423A
    dfar Data_064_7945
    dfar Data_066_46C5
    dfar Data_066_4546
    dfar Data_066_44A5
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_066_5A87
    dfar Data_065_7B11
    dfar Data_066_5B97
    dfar Data_065_6301
    dfar Data_062_7B66
    dfar Data_062_73A7
    dfar Data_065_63C6
    dfar Data_062_494B
    dfar Data_064_7E51
    dfar Data_066_4B6F
    dfar Data_066_4AF5
    dfar Data_066_4AD3
    dfar Data_065_7878 ; id 3
    dfar Data_066_5CC8
    dfar Data_062_7985
    dfar Data_065_70BD
    dfar Data_062_6F90
    dfar Data_065_6736
    dfar Data_065_5FE5
    dfar Data_065_7023
    dfar Data_064_68E4
    dfar Data_063_6DB3
    dfar Data_064_6A43
    dfar Data_066_4F98
    dfar Data_066_4EF7
    dfar Data_064_79CF
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_065_7B9E
    dfar Data_066_615D
    dfar Data_062_7CBA
    dfar Data_065_73A8
    dfar Data_062_73E8
    dfar Data_065_6B50
    dfar Data_065_6391
    dfar Data_065_737C
    dfar Data_064_6D64
    dfar Data_063_722B
    dfar Data_064_6DC8
    dfar Data_066_5366
    dfar Data_066_5342
    dfar Data_064_7E84
    dfar Data_066_53AD
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3AOrder::
Data_067_6EF9:: ; heuristic: start of a structured table; C0
    db $02, $00, $03, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup3B::
Data_067_6EFD:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_57D9
    dfar Data_065_7878
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_7985
    dfar Data_065_70BD
    dfar Data_066_5705
    dfar Data_066_589C
    dfar Data_063_785D
    dfar Data_066_5115
    dfar Data_062_7985
    dfar Data_062_78C0
    dfar Data_065_7023
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_615D
    dfar Data_066_5B5A
    dfar Data_065_7B9E
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7CBA
    dfar Data_065_73A8
    dfar Data_066_5B0F
    dfar Data_066_5B97
    dfar Data_063_7C12
    dfar Data_066_53DF
    dfar Data_062_7CBA
    dfar Data_062_7C82
    dfar Data_065_737C
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_5658
    dfar Data_065_6736
    dfar Data_065_76ED
    dfar Data_065_6693
    dfar Data_065_5F42
    dfar Data_062_4001
    dfar Data_065_6F70
    dfar Data_062_423A
    dfar Data_062_50CE
    dfar Data_065_4041
    dfar Data_065_6C81
    dfar Data_063_6DB3
    dfar Data_063_5DED
    dfar Data_064_5128
    dfar Data_065_6E8B
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6B50
    dfar Data_065_7B11
    dfar Data_065_6B2C
    dfar Data_065_634B
    dfar Data_062_48AC
    dfar Data_065_7334
    dfar Data_062_494B
    dfar Data_062_566F
    dfar Data_065_45C0
    dfar Data_065_7251
    dfar Data_063_722B
    dfar Data_063_6298
    dfar Data_064_5653
    dfar Data_065_72E6
    dfar Data_062_76AE ; id 2
    dfar Data_062_6EDC
    dfar Data_065_65EA
    dfar Data_065_75A3
    dfar Data_062_7985
    dfar Data_062_4001
    dfar Data_062_41C9
    dfar Data_062_7175
    dfar Data_064_7C14
    dfar Data_063_6FC0
    dfar Data_062_43CA
    dfar Data_064_6AEC
    dfar Data_066_5CC8
    dfar Data_064_7C14
    dfar Data_066_4917
    dfar Data_066_5115
    dfar Data_062_7BC5
    dfar Data_062_73A7
    dfar Data_065_6AEA
    dfar Data_065_7AAA
    dfar Data_062_7CBA
    dfar Data_062_48AC
    dfar Data_062_492F
    dfar Data_062_7480
    dfar Data_064_7F35
    dfar Data_063_72C9
    dfar Data_062_49C6
    dfar Data_064_6DFE
    dfar Data_066_615D
    dfar Data_064_7F35
    dfar Data_066_4C37
    dfar Data_066_53DF
    dfar Data_062_78C0 ; id 3
    dfar Data_063_6047
    dfar Data_064_5394
    dfar Data_065_6F70
    dfar Data_065_5FE5
    dfar Data_064_4843
    dfar Data_063_4867
    dfar Data_065_7023
    dfar Data_066_4859
    dfar Data_063_6EFF
    dfar Data_064_6A43
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_062_7C82
    dfar Data_063_6383
    dfar Data_064_5742
    dfar Data_065_7334
    dfar Data_065_6391
    dfar Data_064_4B88
    dfar Data_063_4BB7
    dfar Data_065_737C
    dfar Data_066_4C04
    dfar Data_063_729A
    dfar Data_064_6DC8
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_066_5366
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3BOrder::
Data_067_707D:: ; heuristic: start of a structured table; C0
    db $02, $03, $00, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup3C::
Data_067_7081:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_6693
    dfar Data_066_5CC8
    dfar Data_066_55DC
    dfar Data_065_5E8C
    dfar Data_062_528E
    dfar Data_066_5477
    dfar Data_065_5DD4
    dfar Data_062_423A
    dfar Data_063_5F99
    dfar Data_062_774A
    dfar Data_062_5337
    dfar Data_064_5A34
    dfar Data_065_56B8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_6B2C
    dfar Data_066_615D
    dfar Data_066_5AB9
    dfar Data_065_6301
    dfar Data_062_56FE
    dfar Data_066_5A3B
    dfar Data_065_62D2
    dfar Data_062_494B
    dfar Data_063_633B
    dfar Data_062_7BFD
    dfar Data_062_573B
    dfar Data_064_5E47
    dfar Data_065_5A4D
    dfar Data_065_65EA ; id 1
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_41F0
    dfar Data_062_6EDC
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_064_5284
    dfar Data_062_40EE
    dfar Data_062_6E33
    dfar Data_065_74B6
    dfar Data_062_668A
    dfar Data_064_594F
    dfar Data_065_416D
    dfar Data_065_6D65
    dfar Data_065_6AEA
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_4662
    dfar Data_062_73A7
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_064_56E0
    dfar Data_062_48DA
    dfar Data_062_737B
    dfar Data_065_7A51
    dfar Data_062_6B10
    dfar Data_064_5DEE
    dfar Data_065_4643
    dfar Data_065_7290
    dfar Data_062_78C0 ; id 2
    dfar Data_064_4843
    dfar Data_063_54F8
    dfar Data_063_6636
    dfar Data_064_7B56
    dfar Data_063_6EFF
    dfar Data_062_4365
    dfar Data_063_5F99
    dfar Data_066_5CC8
    dfar Data_064_7B56
    dfar Data_063_6DB3
    dfar Data_064_4734
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_46C5
    dfar Data_062_7C82
    dfar Data_064_4B88
    dfar Data_063_5822
    dfar Data_063_69E0
    dfar Data_064_7F00
    dfar Data_063_729A
    dfar Data_062_49AA
    dfar Data_063_633B
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_063_722B
    dfar Data_064_4B1E
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_4B6F
    dfar Data_064_6145 ; id 3
    dfar Data_063_5437
    dfar Data_063_47D4
    dfar Data_065_6DE3
    dfar Data_064_5310
    dfar Data_062_42B3
    dfar Data_064_6828
    dfar Data_066_4E6E
    dfar Data_063_472D
    dfar Data_064_697E
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_066_478E
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_6509
    dfar Data_063_57D1
    dfar Data_063_4B70
    dfar Data_065_72B2
    dfar Data_064_5719
    dfar Data_062_4967
    dfar Data_064_6D28
    dfar Data_066_5311
    dfar Data_063_4B25
    dfar Data_064_6D86
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_066_4BC0
    dfar Data_066_5366
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3COrder::
Data_067_7201:: ; heuristic: start of a structured table; C0
    db $00, $03, $01, $02 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup3D::
Data_067_7205:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5560 ; id 0
    dfar Data_065_751D
    dfar Data_066_5658
    dfar Data_065_6693
    dfar Data_062_7626
    dfar Data_062_6E33
    dfar Data_065_5E8C
    dfar Data_062_41C9
    dfar Data_062_774A
    dfar Data_062_423A
    dfar Data_064_68E4
    dfar Data_066_4635
    dfar Data_062_76AE
    dfar Data_064_6828
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_066_5A87
    dfar Data_065_7A80
    dfar Data_066_5AE7
    dfar Data_065_6B2C
    dfar Data_062_7B96
    dfar Data_062_737B
    dfar Data_065_6301
    dfar Data_062_492F
    dfar Data_062_7BFD
    dfar Data_062_494B
    dfar Data_064_6D64
    dfar Data_066_4B3B
    dfar Data_062_7BC5
    dfar Data_064_6D28
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_065_65EA ; id 1
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_40EE
    dfar Data_062_6E33
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_063_6C79
    dfar Data_062_406A
    dfar Data_062_6D6B
    dfar Data_065_74B6
    dfar Data_064_7848
    dfar Data_063_6E4E
    dfar Data_062_42B3
    dfar Data_065_6D0D
    dfar Data_065_6AEA
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_48DA
    dfar Data_062_737B
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_063_71D4
    dfar Data_062_48C0
    dfar Data_062_732E
    dfar Data_065_7A51
    dfar Data_064_7DFB
    dfar Data_063_7250
    dfar Data_062_4967
    dfar Data_065_7279
    dfar Data_062_77EB ; id 2
    dfar Data_065_6F70
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7A7D
    dfar Data_064_720E
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_064_720E
    dfar Data_065_6736
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7B56
    dfar Data_066_478E
    dfar Data_062_7C25
    dfar Data_065_7334
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7EB0
    dfar Data_064_76A3
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_064_76A3
    dfar Data_065_6B50
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_066_4BC0
    dfar Data_066_5CC8 ; id 3
    dfar Data_062_75B0
    dfar Data_062_40EE
    dfar Data_065_6DE3
    dfar Data_066_589C
    dfar Data_065_5FE5
    dfar Data_064_697E
    dfar Data_066_4EF7
    dfar Data_065_5BD1
    dfar Data_064_6AEC
    dfar Data_066_5115
    dfar Data_066_5CC8
    dfar Data_066_4859
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_062_7B66
    dfar Data_062_48DA
    dfar Data_065_72B2
    dfar Data_066_5B97
    dfar Data_065_6391
    dfar Data_064_6D86
    dfar Data_066_5342
    dfar Data_065_6216
    dfar Data_064_6DFE
    dfar Data_066_53DF
    dfar Data_066_615D
    dfar Data_066_4C04
    dfar Data_066_53AD
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3DOrder::
Data_067_7385:: ; heuristic: start of a structured table; C0
    db $02, $01, $03, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup3E::
Data_067_7389:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_54FD
    dfar Data_065_643F
    dfar Data_065_751D
    dfar Data_066_5705
    dfar Data_065_5E8C
    dfar Data_062_41C9
    dfar Data_065_6D0D
    dfar Data_062_7517
    dfar Data_062_43CA
    dfar Data_062_4365
    dfar Data_065_6F70
    dfar Data_062_75B0
    dfar Data_064_6797
    dfar Data_066_4635
    dfar Data_064_7139
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6A71
    dfar Data_065_7A80
    dfar Data_066_5B0F
    dfar Data_065_6301
    dfar Data_062_492F
    dfar Data_065_7279
    dfar Data_062_7B3B
    dfar Data_062_49C6
    dfar Data_062_49AA
    dfar Data_065_7334
    dfar Data_062_7B66
    dfar Data_064_6D09
    dfar Data_066_4B3B
    dfar Data_064_7661
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_066_5477
    dfar Data_063_7545
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_063_73F8
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_066_5A3B
    dfar Data_063_7B05
    dfar Data_066_5366
    dfar Data_066_615D
    dfar Data_063_7A89
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_78B1 ; id 2
    dfar Data_066_5115
    dfar Data_066_5CC8
    dfar Data_062_78C0
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_6736
    dfar Data_065_5FE5
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_066_46C5
    dfar Data_066_4917
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7E22
    dfar Data_066_53DF
    dfar Data_066_615D
    dfar Data_062_7C82
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6B50
    dfar Data_065_6391
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_066_4B6F
    dfar Data_066_4C37
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_6D0D ; id 3
    dfar Data_066_5658
    dfar Data_065_75A3
    dfar Data_066_5CC8
    dfar Data_062_6E33
    dfar Data_063_785D
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_063_6D0B
    dfar Data_062_70C1
    dfar Data_065_6546
    dfar Data_065_75A3
    dfar Data_064_79CF
    dfar Data_066_478E
    dfar Data_066_4546
    dfar Data_066_4D7D
    dfar Data_065_7279
    dfar Data_066_5AE7
    dfar Data_065_7AAA
    dfar Data_066_615D
    dfar Data_062_737B
    dfar Data_063_7C12
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_063_71F3
    dfar Data_062_744A
    dfar Data_065_6AC6
    dfar Data_065_7AAA
    dfar Data_064_7E84
    dfar Data_066_4BC0
    dfar Data_066_4AF5
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3EOrder::
Data_067_7509:: ; heuristic: start of a structured table; C0
    db $03, $02, $00, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup3F::
Data_067_750D:: ; heuristic: key-world chunk group; C0
    dfar Data_066_54FD ; id 0
    dfar Data_065_751D
    dfar Data_066_589C
    dfar Data_065_6736
    dfar Data_064_7848
    dfar Data_064_706F
    dfar Data_063_7793
    dfar Data_066_46C5
    dfar Data_066_57D9
    dfar Data_065_5BD1
    dfar Data_062_702C
    dfar Data_065_6693
    dfar Data_064_7C14
    dfar Data_066_46C5
    dfar Data_066_44A5
    dfar Data_063_6E4E
    dfar Data_066_5A5F
    dfar Data_065_7A80
    dfar Data_066_5B97
    dfar Data_065_6B50
    dfar Data_064_7DFB
    dfar Data_064_761D
    dfar Data_063_7BD2
    dfar Data_066_4B6F
    dfar Data_066_5B5A
    dfar Data_065_6216
    dfar Data_062_7409
    dfar Data_065_6B2C
    dfar Data_064_7F35
    dfar Data_066_4B6F
    dfar Data_066_4AD3
    dfar Data_063_7250
    dfar Data_065_65EA ; id 1
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_063_6DB3
    dfar Data_062_6E33
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_065_5FE5
    dfar Data_062_43CA
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_062_53C7
    dfar Data_065_40C4
    dfar Data_062_6E33
    dfar Data_065_75A3
    dfar Data_065_6AEA
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_063_722B
    dfar Data_062_737B
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_065_6391
    dfar Data_062_49C6
    dfar Data_065_7279
    dfar Data_066_615D
    dfar Data_062_5761
    dfar Data_065_45EE
    dfar Data_062_737B
    dfar Data_065_7AAA
    dfar Data_066_5CC8 ; id 2
    dfar Data_066_5CC8
    dfar Data_066_5560
    dfar Data_065_5C71
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_76AE
    dfar Data_062_4001
    dfar Data_066_5CC8
    dfar Data_066_589C
    dfar Data_065_5E8C
    dfar Data_064_6AEC
    dfar Data_066_5CC8
    dfar Data_064_7B56
    dfar Data_066_478E
    dfar Data_066_505C
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_6244
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7BC5
    dfar Data_062_48AC
    dfar Data_066_615D
    dfar Data_066_5B97
    dfar Data_065_6301
    dfar Data_064_6DFE
    dfar Data_066_615D
    dfar Data_064_7F00
    dfar Data_066_4BC0
    dfar Data_066_53AD
    dfar Data_063_5EAF ; id 3
    dfar Data_062_694C
    dfar Data_065_445B
    dfar Data_065_6F70
    dfar Data_064_460E
    dfar Data_063_67DB
    dfar Data_064_54EA
    dfar Data_065_6E8B
    dfar Data_063_6C79
    dfar Data_064_48DA
    dfar Data_063_44A8
    dfar Data_065_6DE3
    dfar Data_064_78B1
    dfar Data_066_4917
    dfar Data_066_4546
    dfar Data_066_4DE4
    dfar Data_063_62DE
    dfar Data_062_6C2D
    dfar Data_065_473E
    dfar Data_065_7334
    dfar Data_064_4AA9
    dfar Data_063_6AA0
    dfar Data_064_57CD
    dfar Data_065_72E6
    dfar Data_063_71D4
    dfar Data_064_4BC1
    dfar Data_063_4A36
    dfar Data_065_72B2
    dfar Data_064_7E22
    dfar Data_066_4C37
    dfar Data_066_4AF5
    dfar Data_066_52E9

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3FOrder::
Data_067_768D:: ; heuristic: start of a structured table; C0
    db $01, $00, $02, $03 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup40::
Data_067_7691:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_64CA
    dfar Data_065_6736
    dfar Data_065_6546
    dfar Data_062_7626
    dfar Data_062_528E
    dfar Data_064_58E6
    dfar Data_064_5864
    dfar Data_062_7985
    dfar Data_064_46A7
    dfar Data_063_531D
    dfar Data_063_65BE
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_6A8F
    dfar Data_065_6B50
    dfar Data_065_6AC6
    dfar Data_062_7B96
    dfar Data_062_56FE
    dfar Data_064_5DC8
    dfar Data_064_5DA3
    dfar Data_062_7CBA
    dfar Data_064_4AD9
    dfar Data_063_5769
    dfar Data_063_69A8
    dfar Data_066_5560 ; id 1
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_5D1D
    dfar Data_062_6EDC
    dfar Data_065_65EA
    dfar Data_065_75A3
    dfar Data_065_416D
    dfar Data_062_5209
    dfar Data_065_40C4
    dfar Data_065_6D0D
    dfar Data_064_5218
    dfar Data_063_5EAF
    dfar Data_064_51A5
    dfar Data_065_6F70
    dfar Data_066_5A87
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_065_6293
    dfar Data_062_73A7
    dfar Data_065_6AEA
    dfar Data_065_7AAA
    dfar Data_065_4643
    dfar Data_062_56DF
    dfar Data_065_45EE
    dfar Data_065_7279
    dfar Data_064_56B0
    dfar Data_063_62DE
    dfar Data_064_567F
    dfar Data_065_7334
    dfar Data_062_76AE ; id 2
    dfar Data_062_4365
    dfar Data_062_42B3
    dfar Data_063_6047
    dfar Data_064_7B56
    dfar Data_063_6EFF
    dfar Data_062_53C7
    dfar Data_062_6083
    dfar Data_066_5CC8
    dfar Data_062_78C0
    dfar Data_063_60DA
    dfar Data_062_6807
    dfar Data_066_57D9
    dfar Data_065_5FE5
    dfar Data_064_47BD
    dfar Data_063_66AF
    dfar Data_062_7BC5
    dfar Data_062_49AA
    dfar Data_062_4967
    dfar Data_063_6383
    dfar Data_064_7F00
    dfar Data_063_729A
    dfar Data_062_5761
    dfar Data_062_6496
    dfar Data_066_615D
    dfar Data_062_7C82
    dfar Data_063_63CF
    dfar Data_062_6BA6
    dfar Data_066_5B5A
    dfar Data_065_6391
    dfar Data_064_4B43
    dfar Data_063_6A11
    dfar Data_064_5310 ; id 3
    dfar Data_064_4734
    dfar Data_063_45E3
    dfar Data_065_6D65
    dfar Data_063_472D
    dfar Data_064_68E4
    dfar Data_066_45B4
    dfar Data_066_4DE4
    dfar Data_065_4291
    dfar Data_062_6F90
    dfar Data_065_751D
    dfar Data_066_5CC8
    dfar Data_064_5218
    dfar Data_062_423A
    dfar Data_062_6E33
    dfar Data_065_751D
    dfar Data_064_5719
    dfar Data_064_4B1E
    dfar Data_063_4AB5
    dfar Data_065_7290
    dfar Data_063_4B25
    dfar Data_064_6D64
    dfar Data_066_4B1A
    dfar Data_066_52E9
    dfar Data_065_469B
    dfar Data_062_73E8
    dfar Data_065_7A80
    dfar Data_066_615D
    dfar Data_064_56B0
    dfar Data_062_494B
    dfar Data_062_737B
    dfar Data_065_7A80
    dfar Data_062_75B0 ; id 4
    dfar Data_062_423A
    dfar Data_062_5209
    dfar Data_065_5587
    dfar Data_062_7626
    dfar Data_062_41C9
    dfar Data_063_5EAF
    dfar Data_064_601C
    dfar Data_064_7848
    dfar Data_063_6DB3
    dfar Data_064_460E
    dfar Data_063_453F
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_45B4
    dfar Data_066_4546
    dfar Data_062_7B66
    dfar Data_062_494B
    dfar Data_062_56DF
    dfar Data_065_59BF
    dfar Data_062_7B96
    dfar Data_062_492F
    dfar Data_063_62DE
    dfar Data_064_647E
    dfar Data_064_7DFB
    dfar Data_063_722B
    dfar Data_064_4AA9
    dfar Data_063_4A65
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_4B1A
    dfar Data_066_4AF5
    dfar Data_062_68C2 ; id 5
    dfar Data_064_5C31
    dfar Data_065_431E
    dfar Data_065_6F70
    dfar Data_063_6744
    dfar Data_064_6311
    dfar Data_063_47D4
    dfar Data_065_6E8B
    dfar Data_064_4843
    dfar Data_063_48FA
    dfar Data_062_42B3
    dfar Data_065_6DE3
    dfar Data_066_4859
    dfar Data_066_44A5
    dfar Data_066_478E
    dfar Data_066_4D7D
    dfar Data_062_6BF7
    dfar Data_064_5F0C
    dfar Data_065_46BF
    dfar Data_065_7334
    dfar Data_063_6A61
    dfar Data_064_65BC
    dfar Data_063_4B70
    dfar Data_065_72E6
    dfar Data_064_4B88
    dfar Data_063_4BF0
    dfar Data_062_4967
    dfar Data_065_72B2
    dfar Data_066_4C04
    dfar Data_066_4AD3
    dfar Data_066_4BC0
    dfar Data_066_52C5

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup40Order::
Data_067_78D1:: ; heuristic: start of a structured table; C0
    db $00, $01, $02, $03, $04, $05 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup41::
Data_067_78D7:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_65EA
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_063_6DB3
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5560
    dfar Data_065_5F42
    dfar Data_066_5658
    dfar Data_065_65EA
    dfar Data_065_5D1D
    dfar Data_062_4365
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6AEA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_063_722B
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A87
    dfar Data_065_634B
    dfar Data_066_5AE7
    dfar Data_065_6AEA
    dfar Data_065_6293
    dfar Data_062_49AA
    dfar Data_065_68B7 ; id 1
    dfar Data_065_7878
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_406A
    dfar Data_062_70C1
    dfar Data_065_68B7
    dfar Data_065_75A3
    dfar Data_062_40EE
    dfar Data_064_697E
    dfar Data_066_4917
    dfar Data_065_751D
    dfar Data_064_6828
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_6BD1
    dfar Data_065_7B9E
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_48C0
    dfar Data_062_744A
    dfar Data_065_6BD1
    dfar Data_065_7AAA
    dfar Data_062_48DA
    dfar Data_064_6D86
    dfar Data_066_4C37
    dfar Data_065_7A80
    dfar Data_064_6D28
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_062_7517 ; id 2
    dfar Data_062_5166
    dfar Data_064_594F
    dfar Data_065_40C4
    dfar Data_062_7626
    dfar Data_063_5E57
    dfar Data_064_6073
    dfar Data_063_472D
    dfar Data_062_76AE
    dfar Data_064_454F
    dfar Data_065_4DE3
    dfar Data_065_431E
    dfar Data_064_7945
    dfar Data_063_6BCD
    dfar Data_063_6148
    dfar Data_064_544D
    dfar Data_062_7B3B
    dfar Data_062_569C
    dfar Data_064_5DEE
    dfar Data_065_45EE
    dfar Data_062_7B96
    dfar Data_063_62C3
    dfar Data_064_64A7
    dfar Data_063_4B25
    dfar Data_062_7BC5
    dfar Data_064_4A58
    dfar Data_065_531E
    dfar Data_065_46BF
    dfar Data_064_7E51
    dfar Data_063_7181
    dfar Data_063_63FE
    dfar Data_064_5794
    dfar Data_065_70BD ; id 3
    dfar Data_066_589C
    dfar Data_065_7878
    dfar Data_066_5CC8
    dfar Data_062_6EDC
    dfar Data_065_5E8C
    dfar Data_065_6F70
    dfar Data_066_5CC8
    dfar Data_064_6A43
    dfar Data_066_4859
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_065_7023
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_73A8
    dfar Data_066_5B97
    dfar Data_065_7B9E
    dfar Data_066_615D
    dfar Data_062_73A7
    dfar Data_065_6301
    dfar Data_065_7334
    dfar Data_066_615D
    dfar Data_064_6DC8
    dfar Data_066_4C04
    dfar Data_066_5366
    dfar Data_066_615D
    dfar Data_065_737C
    dfar Data_066_615D
Data_067_7A51:: ; heuristic: label inside a table; C0
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 4
    dfar Data_062_77EB
    dfar Data_064_4843
    dfar Data_063_472D
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_063_6FC0
    dfar Data_062_41C9
    dfar Data_066_55DC
    dfar Data_065_65EA
    dfar Data_063_735C
    dfar Data_066_45B4
    dfar Data_064_7848
    dfar Data_066_45B4
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_064_4B88
    dfar Data_063_4B25
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_063_72C9
    dfar Data_062_492F
    dfar Data_066_5AB9
    dfar Data_065_6AEA
    dfar Data_063_7A4C
    dfar Data_066_4B1A
    dfar Data_064_7DFB
    dfar Data_066_4B1A
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_062_6F90 ; id 5
    dfar Data_065_6808
    dfar Data_065_6736
    dfar Data_065_75A3
    dfar Data_064_6797
    dfar Data_063_6EFF
    dfar Data_064_68E4
    dfar Data_066_4DE4
    dfar Data_066_4E6E
    dfar Data_062_7985
    dfar Data_065_6E8B
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
Data_067_7AE1:: ; heuristic: label inside a table; C0
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_062_73E8
    dfar Data_065_6B9F
    dfar Data_065_6B50
    dfar Data_065_7AAA
    dfar Data_064_6D09
    dfar Data_063_729A
    dfar Data_064_6D64
    dfar Data_066_52E9
    dfar Data_066_5311
    dfar Data_062_7CBA
    dfar Data_065_72E6
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_5311
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup41Order::
Data_067_7B17:: ; heuristic: start of a structured table; C0
    db $04, $05, $03, $02, $01, $00 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup42::
Data_067_7B1D:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_5CC8
    dfar Data_066_54FD
    dfar Data_065_64CA
    dfar Data_066_5CC8
    dfar Data_066_5705
    dfar Data_065_5D1D
    dfar Data_062_406A
    dfar Data_066_5CC8
    dfar Data_062_77EB
    dfar Data_062_41C9
    dfar Data_062_5166
    dfar Data_066_5CC8
    dfar Data_062_78C0
    dfar Data_062_423A
    dfar Data_063_5E57
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5A5F
    dfar Data_065_6A8F
    dfar Data_066_615D
    dfar Data_066_5B0F
    dfar Data_065_6293
    dfar Data_062_48C0
    dfar Data_066_615D
    dfar Data_062_7C25
    dfar Data_062_492F
    dfar Data_062_569C
    dfar Data_066_615D
    dfar Data_062_7C82
    dfar Data_062_494B
    dfar Data_063_62C3
    dfar Data_065_68B7 ; id 1
    dfar Data_065_6808
    dfar Data_065_7641
    dfar Data_066_5CC8
    dfar Data_062_5519
    dfar Data_065_43BD
    dfar Data_062_6EDC
    dfar Data_065_76ED
    dfar Data_065_5852
    dfar Data_064_544D
    dfar Data_062_40EE
    dfar Data_065_6F70
    dfar Data_065_5B98
    dfar Data_062_68C2
    dfar Data_065_40C4
    dfar Data_065_6D65
    dfar Data_065_6BD1
    dfar Data_065_6B9F
    dfar Data_065_7AE1
    dfar Data_066_615D
    dfar Data_062_57D8
    dfar Data_065_470B
    dfar Data_062_73A7
    dfar Data_065_7B11
Data_067_7BC5:: ; heuristic: label inside a table; C0
    dfar Data_065_5AF8
    dfar Data_064_5794
    dfar Data_062_48DA
    dfar Data_065_7334
    dfar Data_065_5BBD
    dfar Data_062_6BF7
    dfar Data_065_45EE
    dfar Data_065_7290
    dfar Data_066_5CC8 ; id 2
    dfar Data_062_7517
    dfar Data_062_406A
    dfar Data_064_46A7
    dfar Data_066_5CC8
    dfar Data_064_77CC
    dfar Data_063_6BCD
    dfar Data_062_40EE
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_7848
    dfar Data_066_4546
    dfar Data_066_5477
    dfar Data_065_743F
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_615D
    dfar Data_062_7B3B
    dfar Data_062_48C0
    dfar Data_064_4AD9
    dfar Data_066_615D
    dfar Data_064_7DD4
    dfar Data_063_7181
    dfar Data_062_48DA
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7DFB
    dfar Data_066_4AF5
    dfar Data_066_5A3B
    dfar Data_065_7A30
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_063_64F3 ; id 3
    dfar Data_064_6311
    dfar Data_063_44A8
    dfar Data_065_6C81
    dfar Data_064_460E
    dfar Data_063_4867
    dfar Data_064_66F6
    dfar Data_066_4EF7
    dfar Data_063_6D0B
    dfar Data_062_4365
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_062_774A
    dfar Data_064_697E
    dfar Data_066_4E6E
    dfar Data_066_5CC8
    dfar Data_063_694D
    dfar Data_064_65BC
    dfar Data_063_4A36
    dfar Data_065_7251
    dfar Data_064_4AA9
    dfar Data_063_4BB7
    dfar Data_064_6CC4
    dfar Data_066_5342
    dfar Data_063_71F3
    dfar Data_062_49AA
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_062_7BFD
    dfar Data_064_6D86
    dfar Data_066_5311
    dfar Data_066_615D
    dfar Data_062_78C0 ; id 4
    dfar Data_062_6F90
    dfar Data_065_6736
    dfar Data_065_6546
    dfar Data_062_7985
    dfar Data_062_406A
    dfar Data_062_4365
    dfar Data_062_40EE
    dfar Data_062_75B0
    dfar Data_062_41C9
    dfar Data_064_6AEC
    dfar Data_066_45B4
    dfar Data_064_7945
    dfar Data_066_45B4
    dfar Data_066_505C
    dfar Data_066_5CC8
    dfar Data_062_7C82
    dfar Data_062_73E8
    dfar Data_065_6B50
    dfar Data_065_6AC6
    dfar Data_062_7CBA
    dfar Data_062_48C0
    dfar Data_062_49AA
    dfar Data_062_48DA
    dfar Data_062_7B66
    dfar Data_062_492F
    dfar Data_064_6DFE
    dfar Data_066_4B1A
    dfar Data_064_7E51
    dfar Data_066_4B1A
    dfar Data_066_53AD
    dfar Data_066_615D
    dfar Data_065_5E8C ; id 5
    dfar Data_065_6E8B
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_68E4
    dfar Data_066_4F98
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_065_6301
    dfar Data_065_72E6
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_6D64
    dfar Data_066_5366
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup42Order::
Data_067_7D5D:: ; heuristic: start of a structured table; C0
    db $04, $05, $03, $02, $00, $01 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header), then 16 to their attribute maps
KeyWorldChunkGroup43::
Data_067_7D63:: ; heuristic: key-world chunk group; C0
    dfar Data_066_5CC8 ; id 0
    dfar Data_066_55DC
    dfar Data_065_6693
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_064_7945
    dfar Data_063_6DB3
    dfar Data_065_6F70
    dfar Data_066_5560
    dfar Data_065_75A3
    dfar Data_062_774A
    dfar Data_062_702C
    dfar Data_062_7626
    dfar Data_062_6EDC
    dfar Data_065_5E8C
    dfar Data_062_53C7
    dfar Data_066_615D
    dfar Data_066_5AB9
    dfar Data_065_6B2C
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_064_7E51
    dfar Data_063_722B
    dfar Data_065_7334
    dfar Data_066_5A87
    dfar Data_065_7AAA
    dfar Data_062_7BFD
    dfar Data_062_7409
    dfar Data_062_7B96
    dfar Data_062_73A7
    dfar Data_065_6301
    dfar Data_062_5761
    dfar Data_066_5CC8 ; id 1
    dfar Data_066_589C
    dfar Data_065_74B6
    dfar Data_066_5CC8
    dfar Data_066_57D9
    dfar Data_065_60A2
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_065_5FE5
    dfar Data_064_6AEC
    dfar Data_064_706F
    dfar Data_065_77A4
    dfar Data_065_43BD
    dfar Data_062_7175
    dfar Data_063_7626
    dfar Data_066_4F98
    dfar Data_066_615D
    dfar Data_066_5B97
    dfar Data_065_7A51
    dfar Data_066_615D
    dfar Data_066_5B5A
    dfar Data_065_63C6
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_065_6391
    dfar Data_064_6DFE
    dfar Data_064_761D
    dfar Data_065_7B60
    dfar Data_065_470B
    dfar Data_062_7480
    dfar Data_063_7B4F
    dfar Data_066_5366
    dfar Data_062_76AE ; id 2
    dfar Data_062_43CA
    dfar Data_062_4365
    dfar Data_063_6148
    dfar Data_062_77EB
    dfar Data_064_6797
    dfar Data_063_6E4E
    dfar Data_064_454F
    dfar Data_064_7848
    dfar Data_066_4F98
    dfar Data_062_774A
    dfar Data_062_4001
    dfar Data_066_5CC8
    dfar Data_066_5658
    dfar Data_065_5DD4
    dfar Data_062_40EE
    dfar Data_062_7BC5
    dfar Data_062_49C6
    dfar Data_062_49AA
    dfar Data_063_63FE
    dfar Data_062_7C25
    dfar Data_064_6D09
    dfar Data_063_7250
    dfar Data_064_4A58
    dfar Data_064_7DFB
    dfar Data_066_5366
    dfar Data_062_7BFD
    dfar Data_062_48AC
    dfar Data_066_615D
    dfar Data_066_5AE7
    dfar Data_065_62D2
    dfar Data_062_48DA
    dfar Data_064_544D ; id 3
    dfar Data_062_40EE
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_063_472D
    dfar Data_062_41C9
    dfar Data_065_6DE3
    dfar Data_066_5CC8
    dfar Data_064_6797
    dfar Data_066_46C5
    dfar Data_066_4EF7
    dfar Data_066_5CC8
    dfar Data_062_6D6B
    dfar Data_065_6736
    dfar Data_065_76ED
    dfar Data_066_5CC8
    dfar Data_064_5794
    dfar Data_062_48DA
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_063_4B25
    dfar Data_062_492F
    dfar Data_065_72B2
    dfar Data_066_615D
    dfar Data_064_6D09
    dfar Data_066_4B6F
    dfar Data_066_5342
    dfar Data_066_615D
    dfar Data_062_732E
    dfar Data_065_6B50
    dfar Data_065_7B11
    dfar Data_066_615D
    dfar Data_066_5CC8 ; id 4
    dfar Data_062_75B0
    dfar Data_062_4365
    dfar Data_064_6659
    dfar Data_066_5CC8
    dfar Data_062_7985
    dfar Data_062_41C9
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_064_78B1
    dfar Data_063_6DB3
    dfar Data_062_6E33
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_064_79CF
    dfar Data_066_4635
    dfar Data_066_615D
    dfar Data_062_7B66
    dfar Data_062_49AA
    dfar Data_064_6C95
    dfar Data_066_615D
    dfar Data_062_7CBA
    dfar Data_062_492F
    dfar Data_065_7279
    dfar Data_066_615D
    dfar Data_064_7E22
    dfar Data_063_722B
    dfar Data_062_737B
    dfar Data_066_615D
    dfar Data_066_615D
    dfar Data_064_7E84
    dfar Data_066_4B3B
    dfar Data_066_4546 ; id 5
    dfar Data_063_6C79
    dfar Data_065_6D65
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_062_75B0
    dfar Data_065_6D0D
    dfar Data_066_5CC8
    dfar Data_065_64CA
    dfar Data_063_73F8
    dfar Data_066_4D7D
    dfar Data_066_5CC8
    dfar Data_066_45B4
    dfar Data_066_4DE4
    dfar Data_066_5CC8
    dfar Data_066_5CC8
    dfar Data_066_4AF5
    dfar Data_063_71D4
    dfar Data_065_7290
    dfar Data_066_615D
    dfar Data_066_615D
    dw Data_062_7B66
Data_067_7F84:: ; heuristic: label inside a table; C0
    db $62
    dfar Data_065_7279
    dfar Data_066_615D
    dfar Data_065_6A8F
    dfar Data_063_7A89
    dfar Data_066_52C5
    dfar Data_066_615D
    dfar Data_066_4B1A
    dfar Data_066_52E9
    dfar Data_066_615D
    dfar Data_066_615D

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup43Order::
Data_067_7FA3:: ; heuristic: start of a structured table; C0
    db $01, $00, $02, $03, $05, $04 ; entry 0
    ds $57, $00
