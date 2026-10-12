SECTION "Bank 67", ROMX[$4000], BANK[$67]
    db $67

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup00::
Data_067_4001:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_50CE
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_64_48DA
    dfar KeyWorldScreenHeader_63_44A8
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld00_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld00_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup00Order::
Data_067_4061:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup01::
Data_067_4062:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup01Order::
Data_067_40C2:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup02::
Data_067_40C3:: ; address name
    dfar KeyWorldScreenHeader_66_5477 ; id 0
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup02Order::
Data_067_4123:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup03::
Data_067_4124:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup03Order::
Data_067_4184:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup04::
Data_067_4185:: ; address name
    dfar KeyWorldScreenHeader_66_5705 ; id 0
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup04Order::
Data_067_41E5:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup05::
Data_067_41E6:: ; address name
    dfar KeyWorldScreenHeader_66_5705 ; id 0
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup05Order::
Data_067_4246:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup06::
Data_067_4247:: ; address name
    dfar KeyWorldScreenHeader_66_55DC ; id 0
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_62_4454
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_64_7CD5
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld06_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld06_0_Y3X0_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup06Order::
Data_067_42A7:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup07::
Data_067_42A8:: ; address name
    dfar KeyWorldScreenHeader_66_596B ; id 0
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_63_7073
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_65_7161
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorld07_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld07_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld07_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup07Order::
Data_067_4308:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup08::
Data_067_4309:: ; address name
    dfar KeyWorldScreenHeader_66_5560 ; id 0
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7CD5
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld06_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup08Order::
Data_067_4369:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup09::
Data_067_436A:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup09Order::
Data_067_43CA:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0A::
Data_067_43CB:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0AOrder::
Data_067_442B:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0B::
Data_067_442C:: ; address name
    dfar KeyWorldScreenHeader_66_5658 ; id 0
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_64_72E0
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_64_6FCF
    dfar KeyWorldScreenHeader_63_7545
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld0B_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld0B_0_Y2X1_Attrs
    dfar KeyWorld0B_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0BOrder::
Data_067_448C:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0C::
Data_067_448D:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_64_7139
    dfar KeyWorldScreenHeader_65_74B6
Data_067_44A5:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld0C_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0COrder::
Data_067_44ED:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0D::
Data_067_44EE:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_63_74A4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_64_72E0
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld0D_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld0B_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0DOrder::
Data_067_454E:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0E::
Data_067_454F:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_596B
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_63_76CB
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_64_6FCF
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7CD5
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld0E_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld0B_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld06_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0EOrder::
Data_067_45AF:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0F::
Data_067_45B0:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_4642
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_51C2
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld0F_0_Y1X1_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld0F_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0FOrder::
Data_067_4610:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup10::
Data_067_4611:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_65_4041
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_65_6DE3
Data_067_4635:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld10_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld10_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorldScreenHeader_66_589C ; id 1
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_62_6CE1
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld10_1_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup10Order::
Data_067_46D1:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup11::
Data_067_46D3:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_63_7545
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_62_7626 ; id 1
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup11Order::
Data_067_4793:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup12::
Data_067_4795:: ; address name
    dfar KeyWorldScreenHeader_66_55DC ; id 0
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorld12_0_Y2X1_Header
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_62_5485
    dfar KeyWorldScreenHeader_65_431E
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld12_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld12_0_Y3X1_Attrs
    dfar KeyWorld12_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_62_77EB ; id 1
    dfar KeyWorldScreenHeader_63_6148
    dfar KeyWorldScreenHeader_64_5310
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_63_5F99
    dfar KeyWorldScreenHeader_64_5394
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld12_1_Y0X1_Attrs
    dfar KeyWorld12_1_Y0X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld12_1_Y1X1_Attrs
    dfar KeyWorld12_1_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup12Order::
Data_067_4855:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup13::
Data_067_4857:: ; address name
    dw KeyWorldScreenHeader_66_5CC8 ; id 0
Data_067_4859:: ; heuristic: label inside a table; C0
    db $66
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_66_5477 ; id 1
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup13Order::
Data_067_4917:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup14::
Data_067_4919:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_62_6CE1
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld10_1_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_62_7626 ; id 1
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup14Order::
Data_067_49D9:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup15::
Data_067_49DB:: ; address name
    dfar KeyWorldScreenHeader_66_5705 ; id 0
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_63_7545
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_5560 ; id 1
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_50CE
    dfar KeyWorldScreenHeader_65_40C4
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_64_48DA
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld00_0_Y1X1_Attrs
    dfar KeyWorld15_1_Y1X2_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld00_0_Y2X1_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup15Order::
Data_067_4A9B:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup16::
Data_067_4A9D:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_60A2
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_559B
    dfar KeyWorldScreenHeader_65_40C4
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld16_0_Y2X1_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld16_0_Y3X1_Attrs
    dfar KeyWorld15_1_Y1X2_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorldScreenHeader_62_7626 ; id 1
    dfar KeyWorldScreenHeader_64_4960
    dfar KeyWorldScreenHeader_63_44A8
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7CD5
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld16_1_Y0X1_Attrs
    dfar KeyWorld00_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld06_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup16Order::
Data_067_4B5D:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup17::
Data_067_4B5F:: ; address name
    dfar KeyWorldScreenHeader_66_55DC ; id 0
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_6BB5
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_794A
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld17_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld17_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5560 ; id 1
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_65_7161
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld07_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup17Order::
Data_067_4C1F:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup18::
Data_067_4C21:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_64_6F23
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld18_0_Y3X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5477 ; id 1
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_64_72E0
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld0B_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup18Order::
Data_067_4CE1:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup19::
Data_067_4CE3:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_63_74A4
    dfar KeyWorldScreenHeader_64_7139
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7CD5
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld0D_0_Y1X2_Attrs
    dfar KeyWorld0C_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld06_0_Y3X0_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_63_76CB
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_64_748C
    dfar KeyWorldScreenHeader_63_735C
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld0E_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld19_1_Y2X1_Attrs
    dfar KeyWorld19_1_Y2X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup19Order::
Data_067_4DA3:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1A::
Data_067_4DA5:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_63_7952
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_63_7626
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld1A_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld1A_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_64_72E0
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld0B_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1AOrder::
Data_067_4E65:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1B::
Data_067_4E67:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_596B
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_60A2
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld16_0_Y2X1_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_64_7848 ; id 1
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_63_7793
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld1B_1_Y1X1_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1BOrder::
Data_067_4F27:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1C::
Data_067_4F29:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_63_785D
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld1C_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_62_77EB ; id 1
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
Data_067_4F98:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_62_4642
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_4507
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld0F_0_Y1X1_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld1C_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1COrder::
Data_067_4FE9:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1D::
Data_067_4FEB:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_596B
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_65_7161
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld07_0_Y2X1_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_63_76CB
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld0E_0_Y1X1_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1DOrder::
Data_067_50AB:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1E::
Data_067_50AD:: ; address name
    dfar KeyWorldScreenHeader_66_55DC ; id 0
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_5519
    dfar KeyWorldScreenHeader_65_41F0
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_62_7A62
    dfar KeyWorldScreenHeader_64_460E
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_46CC
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld1E_0_Y1X1_Attrs
    dfar KeyWorld1E_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld1E_0_Y2X0_Attrs
    dfar KeyWorld1E_0_Y2X1_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld1E_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_64_73B7
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld1E_1_Y2X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1EOrder::
Data_067_516D:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1F::
Data_067_516F:: ; address name
    dfar KeyWorldScreenHeader_66_57D9 ; id 0
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_596B
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_63_785D
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_4733
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld07_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld1C_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld1F_0_Y3X1_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorldScreenHeader_62_774A ; id 1
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_65_44EB
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7CD5
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld1F_1_Y0X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld10_0_Y2X1_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld06_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1FOrder::
Data_067_522F:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup20::
Data_067_5231:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_64_6659
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld20_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_65_65EA ; id 1
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_63_6B43
    dfar KeyWorldScreenHeader_62_5519
    dfar KeyWorldScreenHeader_65_40C4
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_64_47BD
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld20_1_Y1X0_Attrs
    dfar KeyWorld1E_0_Y1X1_Attrs
    dfar KeyWorld15_1_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld20_1_Y2X1_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup20Order::
Data_067_52F1:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup21::
Data_067_52F3:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_63_76CB
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld0E_0_Y1X1_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_57D9 ; id 1
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_64_6659
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld20_0_Y1X3_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup21Order::
Data_067_53B3:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup22::
Data_067_53B5:: ; address name
    dfar KeyWorldScreenHeader_66_5477 ; id 0
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_64_72E0
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_63_6B43
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld0B_0_Y1X2_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld20_1_Y1X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorldScreenHeader_65_77A4 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_62_7175
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_63_76CB
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld22_1_Y1X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld0E_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup22Order::
Data_067_5475:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup23::
Data_067_5477:: ; address name
    dfar KeyWorldScreenHeader_66_589C ; id 0
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_64_59BA
    dfar KeyWorldScreenHeader_65_4291
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorld12_0_Y2X1_Header
    dfar KeyWorldScreenHeader_63_557A
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld23_0_Y1X2_Attrs
    dfar KeyWorld23_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld12_0_Y2X1_Attrs
    dfar KeyWorld23_0_Y2X2_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_65_751D ; id 1
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup23Order::
Data_067_5537:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup24::
Data_067_5539:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_65_6736 ; id 1
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup24Order::
Data_067_55F9:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup25::
Data_067_55FB:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_65_65EA ; id 1
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup25Order::
Data_067_56BB:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup26::
Data_067_56BD:: ; address name
    dfar KeyWorldScreenHeader_66_5658 ; id 0
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_64_6BB5
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_62_7175
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld17_0_Y1X2_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld22_1_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorldScreenHeader_66_54FD ; id 1
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_66_596B
    dfar KeyWorldScreenHeader_65_794A
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_65_7161
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_65_7161
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_64_7CD5
    dfar KeyWorldScreenHeader_66_51C2
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld07_0_Y0X0_Attrs
    dfar KeyWorld17_0_Y3X2_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld07_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld07_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld06_0_Y3X0_Attrs
    dfar KeyWorld0F_0_Y3X1_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup26Order::
Data_067_577D:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup27::
Data_067_577F:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_6991
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_63_7952
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_64_7CD5
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld27_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld1A_0_Y1X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld06_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorldScreenHeader_65_77A4 ; id 1
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_6991
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_62_7175
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_62_4454
    dfar KeyWorldScreenHeader_65_7161
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_49F7
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld27_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld22_1_Y1X0_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld06_0_Y1X2_Attrs
    dfar KeyWorld07_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld27_1_Y3X1_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup27Order::
Data_067_583F:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup28::
Data_067_5841:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_4792
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld28_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_5658 ; id 1
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_7793
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7227
    dfar KeyWorldScreenHeader_63_76CB
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld1B_1_Y1X1_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld28_1_Y2X0_Attrs
    dfar KeyWorld0E_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup28Order::
Data_067_5901:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup29::
Data_067_5903:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorld29_0_Y1X2_Header
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld29_0_Y1X2_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_74B6 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_794A
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_64_7139
    dfar KeyWorldScreenHeader_65_5BD1
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld17_0_Y3X2_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld0C_0_Y1X2_Attrs
    dfar KeyWorld29_1_Y2X2_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup29Order::
Data_067_59C3:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2A::
Data_067_59C5:: ; address name
    dfar KeyWorldScreenHeader_66_5705 ; id 0
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_45A7
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_4454
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld2A_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld06_0_Y1X2_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_735C
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld19_1_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2AOrder::
Data_067_5A85:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2B::
Data_067_5A87:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_596B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_63_7545
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_66_5CC8
    dw KeyWorld01_0_Y0X0_Attrs
Data_067_5AB9:: ; heuristic: label inside a table; C0
    db $66
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld07_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld0B_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_6736 ; id 1
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2BOrder::
Data_067_5B47:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2C::
Data_067_5B49:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_64_6FCF
    dfar KeyWorldScreenHeader_63_785D
    dfar KeyWorldScreenHeader_64_7139
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_63_74A4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_49F7
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld0B_0_Y2X1_Attrs
    dfar KeyWorld1C_0_Y1X2_Attrs
    dfar KeyWorld0C_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld0D_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld27_1_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_66_54FD ; id 1
    dfar KeyWorldScreenHeader_65_6991
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_76CB
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_64_6F23
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_73B7
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4DE4
Data_067_5BD9:: ; heuristic: label inside a table; C0
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld27_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0E_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld18_0_Y3X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld1E_1_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2COrder::
Data_067_5C09:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2D::
Data_067_5C0B:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_64_72E0
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_7CD5
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld0B_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5560 ; id 1
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2DOrder::
Data_067_5CCB:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2E::
Data_067_5CCD:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_596B
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_4642
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_63_7793
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld0F_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld1B_1_Y1X1_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2EOrder::
Data_067_5D8D:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2F::
Data_067_5D8F:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_6808 ; id 1
    dfar KeyWorldScreenHeader_65_794A
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_4507
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_63_7073
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld17_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld1C_1_Y2X2_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld07_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2FOrder::
Data_067_5E4F:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup30::
Data_067_5E51:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_50CE
    dfar KeyWorldScreenHeader_65_5737
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_63_6148
    dfar KeyWorldScreenHeader_64_6272
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld00_0_Y1X1_Attrs
    dfar KeyWorld30_0_Y2X3_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld12_1_Y0X1_Attrs
    dfar KeyWorld30_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_65_6693 ; id 1
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_431E
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_544D
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_6CE1
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_63_48FA
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld12_0_Y3X2_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld30_1_Y2X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld10_1_Y0X2_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld30_1_Y3X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_62_774A ; id 2
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_63_5DED
    dfar KeyWorldScreenHeader_62_662E
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_64_48DA
    dfar KeyWorldScreenHeader_63_52A2
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld30_2_Y0X2_Attrs
    dfar KeyWorld30_2_Y0X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y2X1_Attrs
    dfar KeyWorld30_2_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_64_5AD4 ; id 3
    dfar KeyWorldScreenHeader_65_431E
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_63_54F8
    dfar KeyWorldScreenHeader_63_472D
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld30_3_Y0X0_Attrs
    dfar KeyWorld12_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld30_3_Y1X0_Attrs
    dfar KeyWorld30_3_Y1X1_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup30Order::
Data_067_5FD1:: ; address name
    db $00, $01, $02, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup31::
Data_067_5FD5:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorldScreenHeader_65_68B7 ; id 1
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_64_5B93
    dfar KeyWorldScreenHeader_65_431E
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_63_53B1
    dfar KeyWorldScreenHeader_63_47D4
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld31_1_Y1X1_Attrs
    dfar KeyWorld12_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld31_1_Y2X1_Attrs
    dfar KeyWorld31_1_Y2X2_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_66_589C ; id 2
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_66_54FD ; id 3
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_63_74A4
    dfar KeyWorldScreenHeader_63_6B43
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld0D_0_Y1X2_Attrs
    dfar KeyWorld20_1_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup31Order::
Data_067_6155:: ; address name
    db $03, $01, $02, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup32::
Data_067_6159:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_5BD1
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_64_5AD4
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_62_5D6D
    dfar KeyWorldScreenHeader_63_531D
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld29_1_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld30_3_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld32_0_Y3X2_Attrs
    dfar KeyWorld32_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_66_5658 ; id 1
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_445B
    dfar KeyWorldScreenHeader_62_6CE1
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld32_1_Y2X0_Attrs
    dfar KeyWorld10_1_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_62_7517 ; id 2
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_64_6659
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_66_5CC8
Data_067_6240:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_64_7945
Data_067_6243:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_66_46C5
    dw KeyWorldScreenHeader_66_478E
Data_067_6248:: ; heuristic: label inside a table; C0
    db $66
Data_067_6249:: ; heuristic: label inside a table; C0
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld20_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
Data_067_6270:: ; heuristic: label inside a table; C0
    dfar KeyWorld02_0_Y3X0_Attrs
Data_067_6273:: ; heuristic: label inside a table; C0
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorldScreenHeader_63_6DB3 ; id 3
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_63_6B43
    dfar KeyWorldScreenHeader_64_6659
    dfar KeyWorldScreenHeader_66_4CD6
    dw KeyWorldScreenHeader_65_7641
Data_067_6293:: ; heuristic: label inside a table; C0
    db $65
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld20_1_Y1X0_Attrs
    dfar KeyWorld20_0_Y1X3_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup32Order::
Data_067_62D9:: ; address name
    db $01, $02, $00, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup33::
Data_067_62DD:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_64_6659
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld20_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_65_743F ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7175
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dw KeyWorld04_0_Y1X3_Attrs
Data_067_637B:: ; heuristic: label inside a table; C0
    db $65
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld22_1_Y1X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_64_72E0
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6B43
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld0B_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld20_1_Y1X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorldScreenHeader_65_5DD4 ; id 3
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup33Order::
Data_067_645D:: ; address name
    db $03, $00, $02, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup34::
Data_067_6461:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dw KeyWorldScreenHeader_66_5CC8
Data_067_6469:: ; heuristic: label inside a table; C0
    db $66
    dfar KeyWorldScreenHeader_66_5CC8
Data_067_646D:: ; heuristic: label inside a table; C0
    dw KeyWorldScreenHeader_66_5CC8
Data_067_646F:: ; heuristic: label inside a table; C0
    db $66
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dw KeyWorldScreenHeader_66_5CC8
Data_067_6478:: ; heuristic: label inside a table; C0
    db $66
Data_067_6479:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_66_5CC8
    dw KeyWorldScreenHeader_66_5CC8
Data_067_647E:: ; heuristic: label inside a table; C0
    db $66
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorldScreenHeader_66_589C ; id 1
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_5485
    dfar KeyWorldScreenHeader_65_4291
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_63_6047
    dfar KeyWorldScreenHeader_64_5218
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_63_6148
    dfar KeyWorldScreenHeader_64_5128
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld12_0_Y3X1_Attrs
    dfar KeyWorld23_0_Y1X3_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld34_1_Y2X1_Attrs
    dfar KeyWorld34_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld12_1_Y0X1_Attrs
    dfar KeyWorld34_1_Y3X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_64_594F
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_63_65BE
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld34_2_Y0X3_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld34_2_Y1X3_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dw KeyWorld10_0_Y2X1_Attrs
Data_067_6574:: ; heuristic: label inside a table; C0
    db $64
Data_067_6575:: ; heuristic: label inside a table; C0
    dfar KeyWorld05_0_Y3X0_Attrs
    dw KeyWorld06_0_Y3X1_Attrs
Data_067_657A:: ; heuristic: label inside a table; C0
    db $66
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_65_445B ; id 3
    dfar KeyWorldScreenHeader_64_460E
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_64_5218
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld32_1_Y2X0_Attrs
    dfar KeyWorld1E_0_Y2X1_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld34_1_Y2X2_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup34Order::
Data_067_65E1:: ; address name
    db $00, $01, $03, $02 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup35::
Data_067_65E5:: ; address name
    dfar KeyWorldScreenHeader_66_5705 ; id 0
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_5519
    dfar KeyWorldScreenHeader_65_4041
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorld12_0_Y2X1_Header
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld1E_0_Y1X1_Attrs
    dfar KeyWorld10_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld12_0_Y2X1_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dw KeyWorld04_0_Y2X2_Attrs
Data_067_6644:: ; heuristic: label inside a table; C0
    db $62
Data_067_6645:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_66_5477 ; id 1
    dw KeyWorldScreenHeader_65_64CA
Data_067_664A:: ; heuristic: label inside a table; C0
    db $65
Data_067_664B:: ; heuristic: label inside a table; C0
    dw KeyWorldScreenHeader_65_65EA
Data_067_664D:: ; heuristic: label inside a table; C0
    db $65
Data_067_664E:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_65_76ED
    dw KeyWorldScreenHeader_62_7985
Data_067_6653:: ; heuristic: label inside a table; C0
    db $62
Data_067_6654:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_63_6DB3
    dw KeyWorldScreenHeader_65_70BD
Data_067_665C:: ; heuristic: label inside a table; C0
    db $65
    dfar KeyWorldScreenHeader_63_7793
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld1B_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_62_41C9 ; id 3
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup35Order::
Data_067_6765:: ; address name
    db $02, $03, $01, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup36::
Data_067_6769:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_5485
    dfar KeyWorldScreenHeader_65_431E
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_64_72E0
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld12_0_Y3X1_Attrs
    dfar KeyWorld12_0_Y3X2_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld0B_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_65_6546 ; id 1
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_64_6FCF
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld0B_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_62_76AE ; id 2
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_4F98 ; id 3
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup36Order::
Data_067_68E9:: ; address name
    db $02, $03, $00, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup37::
Data_067_68ED:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorldScreenHeader_65_6736 ; id 1
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_62_76AE ; id 2
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_65_41F0
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld1E_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_62_43CA ; id 3
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_62_7175
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld22_1_Y1X0_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup37Order::
Data_067_6A6D:: ; address name
    db $01, $00, $02, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup38::
Data_067_6A71:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_65_65EA ; id 1
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_62_7985 ; id 2
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_63_6B43
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld20_1_Y1X0_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_62_42B3 ; id 3
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_70BD
    dw KeyWorld01_0_Y2X1_Header
Data_067_6B9F:: ; heuristic: label inside a table; C0
    db $62
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup38Order::
Data_067_6BF1:: ; address name
    db $00, $02, $01, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup39::
Data_067_6BF5:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_65_6693 ; id 1
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_62_53C7
    dfar KeyWorldScreenHeader_64_594F
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_5229
    dfar KeyWorldScreenHeader_63_47D4
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_63_6B43
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld39_1_Y1X0_Attrs
    dfar KeyWorld34_2_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld39_1_Y2X1_Attrs
    dfar KeyWorld31_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld20_1_Y1X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_62_7985 ; id 2
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_6D0D ; id 3
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_64_72E0
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld0B_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup39Order::
Data_067_6D75:: ; address name
    db $03, $01, $02, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3A::
Data_067_6D79:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_64_720E
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld3A_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5560 ; id 1
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_62_7175
    dfar KeyWorldScreenHeader_63_74A4
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld22_1_Y1X0_Attrs
    dfar KeyWorld0D_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_60A2
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld16_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_65_7878 ; id 3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3AOrder::
Data_067_6EF9:: ; address name
    db $02, $00, $03, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3B::
Data_067_6EFD:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_63_785D
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld1C_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_50CE
    dfar KeyWorldScreenHeader_65_4041
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_63_5DED
    dfar KeyWorldScreenHeader_64_5128
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X1_Attrs
    dfar KeyWorld10_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld30_2_Y0X2_Attrs
    dfar KeyWorld34_1_Y3X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_62_76AE ; id 2
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_7175
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld22_1_Y1X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_62_78C0 ; id 3
    dfar KeyWorldScreenHeader_63_6047
    dfar KeyWorldScreenHeader_64_5394
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld34_1_Y2X1_Attrs
    dfar KeyWorld12_1_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3BOrder::
Data_067_707D:: ; address name
    db $02, $03, $00, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3C::
Data_067_7081:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_63_5F99
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_64_5A34
    dfar KeyWorldScreenHeader_65_56B8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld12_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld3C_0_Y3X2_Attrs
    dfar KeyWorld3C_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_65_65EA ; id 1
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_41F0
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_5284
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_62_668A
    dfar KeyWorldScreenHeader_64_594F
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld1E_0_Y1X2_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld3C_1_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld3C_1_Y3X0_Attrs
    dfar KeyWorld34_2_Y0X3_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_62_78C0 ; id 2
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_54F8
    dfar KeyWorldScreenHeader_63_6636
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_63_5F99
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld30_3_Y1X0_Attrs
    dfar KeyWorld3C_2_Y0X3_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld12_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_64_6145 ; id 3
    dfar KeyWorldScreenHeader_63_5437
    dfar KeyWorldScreenHeader_63_47D4
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_64_5310
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_63_472D
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld3C_3_Y0X0_Attrs
    dfar KeyWorld3C_3_Y0X1_Attrs
    dfar KeyWorld31_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld12_1_Y0X2_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld30_3_Y1X1_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3COrder::
Data_067_7201:: ; address name
    db $00, $03, $01, $02 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3D::
Data_067_7205:: ; address name
    dfar KeyWorldScreenHeader_66_5560 ; id 0
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_65EA ; id 1
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_62_77EB ; id 2
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_64_720E
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_64_720E
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld3A_0_Y1X3_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld3A_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 3
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_65_5BD1
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld29_1_Y2X2_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3DOrder::
Data_067_7385:: ; address name
    db $02, $01, $03, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3E::
Data_067_7389:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_64_7139
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld0C_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_63_7545
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_73F8
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y2X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld3E_1_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_64_78B1 ; id 2
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_6D0D ; id 3
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_63_785D
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld1C_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3EOrder::
Data_067_7509:: ; address name
    db $03, $02, $00, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3F::
Data_067_750D:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_63_7793
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_5BD1
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld1B_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld29_1_Y2X2_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_65_65EA ; id 1
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_53C7
    dfar KeyWorldScreenHeader_65_40C4
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld39_1_Y1X0_Attrs
    dfar KeyWorld15_1_Y1X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorldScreenHeader_63_5EAF ; id 3
    dfar KeyWorldScreenHeader_62_694C
    dfar KeyWorldScreenHeader_65_445B
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_64_460E
    dfar KeyWorldScreenHeader_63_67DB
    dfar KeyWorldScreenHeader_64_54EA
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_64_48DA
    dfar KeyWorldScreenHeader_63_44A8
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorld3F_3_Y0X0_Attrs
    dfar KeyWorld3F_3_Y0X1_Attrs
    dfar KeyWorld32_1_Y2X0_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld1E_0_Y2X1_Attrs
    dfar KeyWorld3F_3_Y1X1_Attrs
    dfar KeyWorld3F_3_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3FOrder::
Data_067_768D:: ; address name
    db $01, $00, $02, $03 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup40::
Data_067_7691:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_64_58E6
    dfar KeyWorldScreenHeader_64_5864
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_63_531D
    dfar KeyWorldScreenHeader_63_65BE
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld40_0_Y2X2_Attrs
    dfar KeyWorld40_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld32_0_Y3X3_Attrs
    dfar KeyWorld34_2_Y1X3_Attrs
    dfar KeyWorldScreenHeader_66_5560 ; id 1
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_62_5209
    dfar KeyWorldScreenHeader_65_40C4
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_64_5218
    dfar KeyWorldScreenHeader_63_5EAF
    dfar KeyWorldScreenHeader_64_51A5
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld40_1_Y2X1_Attrs
    dfar KeyWorld15_1_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld34_1_Y2X2_Attrs
    dfar KeyWorld3F_3_Y0X0_Attrs
    dfar KeyWorld40_1_Y3X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_62_76AE ; id 2
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_63_6047
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_62_53C7
    dfar KeyWorldScreenHeader_62_6083
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_63_60DA
    dfar KeyWorldScreenHeader_62_6807
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_64_47BD
    dfar KeyWorldScreenHeader_63_66AF
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld34_1_Y2X1_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld39_1_Y1X0_Attrs
    dfar KeyWorld40_2_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld40_2_Y2X2_Attrs
    dfar KeyWorld40_2_Y2X3_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld20_1_Y2X1_Attrs
    dfar KeyWorld40_2_Y3X3_Attrs
    dfar KeyWorldScreenHeader_64_5310 ; id 3
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_63_472D
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_65_4291
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_5218
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorld12_1_Y0X2_Attrs
    dfar KeyWorld10_0_Y2X1_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld30_3_Y1X1_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld23_0_Y1X3_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld34_1_Y2X2_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorldScreenHeader_62_75B0 ; id 4
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_5209
    dfar KeyWorldScreenHeader_65_5587
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_63_5EAF
    dfar KeyWorldScreenHeader_64_601C
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_64_460E
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld40_1_Y2X1_Attrs
    dfar KeyWorld40_4_Y0X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld3F_3_Y0X0_Attrs
    dfar KeyWorld40_4_Y1X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld1E_0_Y2X1_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_62_68C2 ; id 5
    dfar KeyWorldScreenHeader_64_5C31
    dfar KeyWorldScreenHeader_65_431E
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_63_6744
    dfar KeyWorldScreenHeader_64_6311
    dfar KeyWorldScreenHeader_63_47D4
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_48FA
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld40_5_Y0X0_Attrs
    dfar KeyWorld40_5_Y0X1_Attrs
    dfar KeyWorld12_0_Y3X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld40_5_Y1X0_Attrs
    dfar KeyWorld40_5_Y1X1_Attrs
    dfar KeyWorld31_1_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld30_1_Y3X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup40Order::
Data_067_78D1:: ; address name
    db $00, $01, $02, $03, $04, $05 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup41::
Data_067_78D7:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_65_68B7 ; id 1
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_62_7517 ; id 2
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_64_594F
    dfar KeyWorldScreenHeader_65_40C4
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_63_5E57
    dfar KeyWorldScreenHeader_64_6073
    dfar KeyWorldScreenHeader_63_472D
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_65_4DE3
    dfar KeyWorldScreenHeader_65_431E
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_63_6148
    dfar KeyWorldScreenHeader_64_544D
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld34_2_Y0X3_Attrs
    dfar KeyWorld15_1_Y1X2_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld41_2_Y1X1_Attrs
    dfar KeyWorld41_2_Y1X2_Attrs
    dfar KeyWorld30_3_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld41_2_Y2X2_Attrs
    dfar KeyWorld12_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld12_1_Y0X1_Attrs
    dfar KeyWorld30_1_Y2X0_Attrs
    dfar KeyWorldScreenHeader_65_70BD ; id 3
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
Data_067_7A51:: ; heuristic: label inside a table; C0
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 4
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_472D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_63_735C
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld30_3_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld19_1_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_62_6F90 ; id 5
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
Data_067_7AE1:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup41Order::
Data_067_7B17:: ; address name
    db $04, $05, $03, $02, $01, $00 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup42::
Data_067_7B1D:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_63_5E57
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld41_2_Y1X1_Attrs
    dfar KeyWorldScreenHeader_65_68B7 ; id 1
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_5519
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_65_5852
    dfar KeyWorldScreenHeader_64_544D
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_65_5B98
    dfar KeyWorldScreenHeader_62_68C2
    dfar KeyWorldScreenHeader_65_40C4
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld1E_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
Data_067_7BC5:: ; heuristic: label inside a table; C0
    dfar KeyWorld42_1_Y2X0_Attrs
    dfar KeyWorld30_1_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld42_1_Y3X0_Attrs
    dfar KeyWorld40_5_Y0X0_Attrs
    dfar KeyWorld15_1_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_63_64F3 ; id 3
    dfar KeyWorldScreenHeader_64_6311
    dfar KeyWorldScreenHeader_63_44A8
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_64_460E
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld42_3_Y0X0_Attrs
    dfar KeyWorld40_5_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X2_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld1E_0_Y2X1_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_62_78C0 ; id 4
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_5E8C ; id 5
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup42Order::
Data_067_7D5D:: ; address name
    db $04, $05, $03, $02, $00, $01 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup43::
Data_067_7D63:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_53C7
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld39_1_Y1X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_60A2
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_62_7175
    dfar KeyWorldScreenHeader_63_7626
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld16_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld22_1_Y1X0_Attrs
    dfar KeyWorld1A_0_Y3X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorldScreenHeader_62_76AE ; id 2
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_63_6148
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld12_1_Y0X1_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_64_544D ; id 3
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_472D
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld30_1_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld30_3_Y1X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 4
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_64_6659
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld20_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_66_4546 ; id 5
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_63_73F8
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dw KeyWorld02_0_Y1X0_Attrs
Data_067_7F84:: ; heuristic: label inside a table; C0
    db $62
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld3E_1_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup43Order::
Data_067_7FA3:: ; address name
    db $01, $00, $02, $03, $05, $04 ; entry 0
    ds $57, $00
