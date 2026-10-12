SECTION "Bank 68", ROMX[$4000], BANK[$68]
    db $68

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup44::
Data_068_4001:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_65_431E
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_63_47D4
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld12_0_Y3X2_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld10_0_Y2X1_Attrs
    dfar KeyWorld31_1_Y2X2_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorldScreenHeader_66_5658 ; id 1
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_5A34
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_6636
    dfar KeyWorldScreenHeader_64_5218
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld3C_0_Y3X2_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld3C_2_Y0X3_Attrs
    dfar KeyWorld34_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorldScreenHeader_63_60DA ; id 3
    dfar KeyWorldScreenHeader_64_544D
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_63_6148
    dfar KeyWorldScreenHeader_62_68C2
    dfar KeyWorldScreenHeader_65_41F0
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_6744
    dfar KeyWorldScreenHeader_64_5284
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_62_5485
    dfar KeyWorldScreenHeader_62_613E
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorld40_2_Y2X2_Attrs
    dfar KeyWorld30_1_Y2X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld12_1_Y0X1_Attrs
    dfar KeyWorld40_5_Y0X0_Attrs
    dfar KeyWorld1E_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld40_5_Y1X0_Attrs
    dfar KeyWorld3C_1_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld12_0_Y3X1_Attrs
    dfar KeyWorld44_3_Y3X1_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_66_5560 ; id 4
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_64_5A34
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_63_5F99
    dfar KeyWorldScreenHeader_64_6145
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_63_472D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld3C_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld12_1_Y1X1_Attrs
    dfar KeyWorld3C_3_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld10_0_Y2X1_Attrs
    dfar KeyWorld30_3_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorldScreenHeader_65_5737 ; id 5
    dfar KeyWorldScreenHeader_64_5394
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_63_5437
    dfar KeyWorldScreenHeader_63_47D4
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld30_0_Y2X3_Attrs
    dfar KeyWorld12_1_Y1X2_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld3C_3_Y0X1_Attrs
    dfar KeyWorld31_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup44Order::
Data_068_4241:: ; address name
    db $04, $05, $03, $02, $00, $01 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup45::
Data_068_4247:: ; address name
    dfar KeyWorldScreenHeader_66_5560 ; id 0
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_64_73B7
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld1E_1_Y2X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorldScreenHeader_65_751D ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_64_720E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld3A_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorldScreenHeader_65_6693 ; id 3
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_62_76AE ; id 4
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorldScreenHeader_65_75A3 ; id 5
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_63_74A4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld0D_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup45Order::
Data_068_4487:: ; address name
    db $00, $02, $01, $03, $04, $05 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup46::
Data_068_448D:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorldScreenHeader_64_7848 ; id 2
    dfar KeyWorldScreenHeader_64_73B7
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld1E_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 3
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_65_60A2
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld16_0_Y2X1_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorldScreenHeader_64_7848 ; id 4
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_62_423A ; id 5
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_63_6B43
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_65_41F0
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld20_1_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld1E_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup46Order::
Data_068_46CD:: ; address name
    db $05, $04, $03, $02, $01, $00 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup47::
Data_068_46D3:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_60A2
    dfar KeyWorldScreenHeader_62_5209
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_5209
    dfar KeyWorldScreenHeader_65_55E2
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_63_5F99
    dfar KeyWorldScreenHeader_64_6272
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld16_0_Y2X1_Attrs
    dfar KeyWorld40_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld40_1_Y2X1_Attrs
    dfar KeyWorld47_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld12_1_Y1X1_Attrs
    dfar KeyWorld30_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_65_6693 ; id 1
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_5AD4
    dfar KeyWorldScreenHeader_64_59BA
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_64_6145
    dfar KeyWorldScreenHeader_63_531D
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_63_47D4
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld30_3_Y0X0_Attrs
    dfar KeyWorld23_0_Y1X2_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld3C_3_Y0X0_Attrs
    dfar KeyWorld32_0_Y3X3_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld31_1_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_62_7517 ; id 2
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_62_5FBC
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_63_5EAF
    dfar KeyWorldScreenHeader_64_544D
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_63_5E57
    dfar KeyWorldScreenHeader_64_5394
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld47_2_Y0X2_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld3F_3_Y0X0_Attrs
    dfar KeyWorld30_1_Y2X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld41_2_Y1X1_Attrs
    dfar KeyWorld12_1_Y1X2_Attrs
    dfar KeyWorldScreenHeader_62_41C9 ; id 3
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorldScreenHeader_62_7985 ; id 4
    dfar KeyWorldScreenHeader_62_5209
    dfar KeyWorldScreenHeader_65_5056
    dfar KeyWorldScreenHeader_63_472D
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_63_5E57
    dfar KeyWorldScreenHeader_64_6272
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld40_1_Y2X1_Attrs
    dfar KeyWorld47_4_Y0X2_Attrs
    dfar KeyWorld30_3_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld41_2_Y1X1_Attrs
    dfar KeyWorld30_0_Y3X3_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorldScreenHeader_62_70C1 ; id 5
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
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
KeyWorldChunkGroup47Order::
Data_068_4913:: ; address name
    db $01, $00, $02, $03, $05, $04 ; entry 0

; E-0146 (derived: 3 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup48::
Data_068_4919:: ; address name
    dfar KeyWorldScreenHeader_66_55DC ; id 0
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorldScreenHeader_66_5560 ; id 1
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_63_7626
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld1A_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_65EA ; id 2
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup48Order::
Data_068_4A39:: ; address name
    db $00, $01, $02 ; entry 0

; E-0146 (derived: 3 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup49::
Data_068_4A3C:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_63_7626
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld1A_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_65_6546 ; id 1
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_64_48DA
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld00_0_Y2X1_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_5705 ; id 2
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_64_720E
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld3A_0_Y1X3_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup49Order::
Data_068_4B5C:: ; address name
    db $02, $01, $00 ; entry 0

; E-0146 (derived: 3 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4A::
Data_068_4B5F:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_57D9 ; id 1
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_65_64CA ; id 2
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_62_5209
    dfar KeyWorldScreenHeader_64_5AD4
    dfar KeyWorldScreenHeader_65_445B
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_63_54F8
    dfar KeyWorldScreenHeader_63_48FA
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld40_1_Y2X1_Attrs
    dfar KeyWorld30_3_Y0X0_Attrs
    dfar KeyWorld32_1_Y2X0_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld30_3_Y1X0_Attrs
    dfar KeyWorld30_1_Y3X0_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4AOrder::
Data_068_4C7F:: ; address name
    db $01, $00, $02 ; entry 0

; E-0146 (derived: 3 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4B::
Data_068_4C82:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_5209
    dfar KeyWorldScreenHeader_64_594F
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_63_531D
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld40_1_Y2X1_Attrs
    dfar KeyWorld34_2_Y0X3_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld32_0_Y3X3_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_65_7878 ; id 1
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorldScreenHeader_65_6546 ; id 2
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4BOrder::
Data_068_4DA2:: ; address name
    db $02, $00, $01 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4C::
Data_068_4DA5:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_64_58E6
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_63_64F3
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld40_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld10_0_Y2X1_Attrs
    dfar KeyWorld42_3_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_65EA ; id 1
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_662E
    dfar KeyWorldScreenHeader_64_5A34
    dfar KeyWorldScreenHeader_64_5AD4
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld30_2_Y0X3_Attrs
    dfar KeyWorld3C_0_Y3X2_Attrs
    dfar KeyWorld30_3_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_65_64CA ; id 2
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_64_594F
    dfar KeyWorldScreenHeader_65_41F0
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_63_5EAF
    dfar KeyWorldScreenHeader_64_6073
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_63_5E57
    dfar KeyWorldScreenHeader_64_54EA
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld34_2_Y0X3_Attrs
    dfar KeyWorld1E_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld3F_3_Y0X0_Attrs
    dfar KeyWorld41_2_Y1X2_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld41_2_Y1X1_Attrs
    dfar KeyWorld3F_3_Y1X2_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorldScreenHeader_64_7B56 ; id 3
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_5209
    dfar KeyWorldScreenHeader_65_56B8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_63_5EAF
    dfar KeyWorldScreenHeader_64_6145
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_63_44A8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld40_1_Y2X1_Attrs
    dfar KeyWorld3C_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld3F_3_Y0X0_Attrs
    dfar KeyWorld3C_3_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld00_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_64_61C5 ; id 4
    dfar KeyWorldScreenHeader_63_65BE
    dfar KeyWorldScreenHeader_64_6073
    dfar KeyWorldScreenHeader_65_4D49
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_472D
    dfar KeyWorldScreenHeader_64_47BD
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorld4C_4_Y0X0_Attrs
    dfar KeyWorld34_2_Y1X3_Attrs
    dfar KeyWorld41_2_Y1X2_Attrs
    dfar KeyWorld4C_4_Y0X3_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld30_3_Y1X1_Attrs
    dfar KeyWorld20_1_Y2X1_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorldScreenHeader_65_5587 ; id 5
    dfar KeyWorldScreenHeader_64_5218
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_7878
    dfar KeyWorldScreenHeader_63_557A
    dfar KeyWorldScreenHeader_65_4FAD
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorld40_4_Y0X3_Attrs
    dfar KeyWorld34_1_Y2X2_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld1D_1_Y2X3_Attrs
    dfar KeyWorld23_0_Y2X2_Attrs
    dfar KeyWorld4C_5_Y1X1_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4COrder::
Data_068_4FE5:: ; address name
    db $00, $02, $05, $01, $03, $04 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4D::
Data_068_4FEB:: ; address name
    dfar KeyWorldScreenHeader_66_55DC ; id 0
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_5705 ; id 1
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_65_60A2
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_64_59BA
    dfar KeyWorldScreenHeader_65_40C4
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorld12_0_Y2X1_Header
    dfar KeyWorldScreenHeader_63_52A2
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld16_0_Y2X1_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld23_0_Y1X2_Attrs
    dfar KeyWorld15_1_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld12_0_Y2X1_Attrs
    dfar KeyWorld30_2_Y1X3_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorldScreenHeader_65_6546 ; id 2
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorldScreenHeader_66_5705 ; id 3
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_64_66F6 ; id 4
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_62_406A ; id 5
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4DOrder::
Data_068_522B:: ; address name
    db $05, $02, $01, $04, $03, $00 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4E::
Data_068_5231:: ; address name
    dfar KeyWorldScreenHeader_66_5658 ; id 0
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_5485
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_65_55E2
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_63_64F3
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld12_0_Y3X1_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld47_0_Y2X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld42_3_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_64CA ; id 2
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_64_5284
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_62_6784
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld3C_1_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld4E_2_Y3X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_66_5477 ; id 3
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 4
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_65_56B8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorld12_0_Y2X1_Header
    dfar KeyWorldScreenHeader_63_531D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld3C_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld12_0_Y2X1_Attrs
    dfar KeyWorld32_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_65_5B98 ; id 5
    dfar KeyWorldScreenHeader_62_68C2
    dfar KeyWorldScreenHeader_65_4291
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_63_64F3
    dfar KeyWorldScreenHeader_64_6272
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_64_48DA
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld42_1_Y3X0_Attrs
    dfar KeyWorld40_5_Y0X0_Attrs
    dfar KeyWorld23_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld42_3_Y0X0_Attrs
    dfar KeyWorld30_0_Y3X3_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y2X1_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4EOrder::
Data_068_5471:: ; address name
    db $01, $02, $05, $00, $03, $04 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4F::
Data_068_5477:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_64_7139
    dfar KeyWorldScreenHeader_63_76CB
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld0C_0_Y1X2_Attrs
    dfar KeyWorld0E_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorldScreenHeader_65_6736 ; id 1
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_63_76CB
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld0E_0_Y1X1_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_66_589C ; id 3
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_62_406A ; id 4
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_63_73F8
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_64_6F23
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld3E_1_Y3X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld18_0_Y3X1_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorldScreenHeader_66_4DE4 ; id 5
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_63_7793
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld1B_1_Y1X1_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup4FOrder::
Data_068_56B7:: ; address name
    db $04, $03, $00, $05, $02, $01 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup50::
Data_068_56BD:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_62_53C7
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld39_1_Y1X0_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_6CE1
    dfar KeyWorldScreenHeader_65_5BD1
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld10_1_Y0X2_Attrs
    dfar KeyWorld29_1_Y2X2_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorldScreenHeader_65_64CA ; id 2
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_63_5E57
    dfar KeyWorldScreenHeader_62_68C2
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_63_5EAF
    dfar KeyWorldScreenHeader_64_6272
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld41_2_Y1X1_Attrs
    dfar KeyWorld40_5_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld3F_3_Y0X0_Attrs
    dfar KeyWorld30_0_Y3X3_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_66_5560 ; id 3
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_63_5DED
    dfar KeyWorldScreenHeader_62_694C
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorld12_0_Y2X1_Header
    dfar KeyWorldScreenHeader_63_53B1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld30_2_Y0X2_Attrs
    dfar KeyWorld3F_3_Y0X1_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld12_0_Y2X1_Attrs
    dfar KeyWorld31_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorldScreenHeader_64_59BA ; id 4
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_62_53C7
    dfar KeyWorldScreenHeader_64_59BA
    dfar KeyWorldScreenHeader_63_52A2
    dfar KeyWorldScreenHeader_65_4FAD
    dfar KeyWorldScreenHeader_65_5587
    dfar KeyWorldScreenHeader_64_60D8
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_63_52A2
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorld23_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld39_1_Y1X0_Attrs
    dfar KeyWorld23_0_Y1X2_Attrs
    dfar KeyWorld30_2_Y1X3_Attrs
    dfar KeyWorld4C_5_Y1X1_Attrs
    dfar KeyWorld40_4_Y0X3_Attrs
    dfar KeyWorld50_4_Y1X3_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld30_2_Y1X3_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_62_5E91 ; id 5
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld50_5_Y0X0_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup50Order::
Data_068_58FD:: ; address name
    db $01, $02, $05, $00, $03, $04 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup51::
Data_068_5903:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_65_68B7 ; id 1
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_64_6FCF
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld0B_0_Y2X1_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_743F
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_62_75B0 ; id 3
    dfar KeyWorldScreenHeader_64_6659
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_64_720E
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld20_0_Y1X3_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld3A_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_62_774A ; id 4
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_60A2
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld16_0_Y2X1_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 5
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_63_73F8
    dfar KeyWorldScreenHeader_64_6F23
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld3E_1_Y3X0_Attrs
    dfar KeyWorld18_0_Y3X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup51Order::
Data_068_5B43:: ; address name
    db $00, $03, $04, $01, $02, $05 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup52::
Data_068_5B49:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5C32
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld52_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_65_751D ; id 1
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_6FCF
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y2X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorldScreenHeader_66_5658 ; id 2
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_64_5AD4
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_63_5437
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld30_3_Y0X0_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld10_0_Y2X1_Attrs
    dfar KeyWorld3C_3_Y0X1_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_63_73F8
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld3E_1_Y3X0_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_62_43CA ; id 5
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup52Order::
Data_068_5D89:: ; address name
    db $05, $02, $01, $04, $03, $00 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup53::
Data_068_5D8F:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_62_5485
    dfar KeyWorldScreenHeader_64_5B93
    dfar KeyWorldScreenHeader_65_41F0
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_6744
    dfar KeyWorldScreenHeader_62_6784
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld12_0_Y3X1_Attrs
    dfar KeyWorld31_1_Y1X1_Attrs
    dfar KeyWorld1E_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld40_5_Y1X0_Attrs
    dfar KeyWorld4E_2_Y3X0_Attrs
    dfar KeyWorldScreenHeader_65_75A3 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_76ED
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_65_4291
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld23_0_Y1X3_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorldScreenHeader_65_6546 ; id 2
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_64_7848 ; id 3
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_63_60DA
    dfar KeyWorldScreenHeader_65_5B98
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_54F8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld40_2_Y2X2_Attrs
    dfar KeyWorld42_1_Y3X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld30_3_Y1X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_62_6807 ; id 4
    dfar KeyWorldScreenHeader_63_6B43
    dfar KeyWorldScreenHeader_62_53C7
    dfar KeyWorldScreenHeader_64_5B93
    dfar KeyWorldScreenHeader_63_6636
    dfar KeyWorldScreenHeader_64_5284
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_63_54F8
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorld40_2_Y2X3_Attrs
    dfar KeyWorld20_1_Y1X0_Attrs
    dfar KeyWorld39_1_Y1X0_Attrs
    dfar KeyWorld31_1_Y1X1_Attrs
    dfar KeyWorld3C_2_Y0X3_Attrs
    dfar KeyWorld3C_1_Y2X0_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld30_3_Y1X0_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorldScreenHeader_64_5B93 ; id 5
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_63_531D
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld31_1_Y1X1_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld32_0_Y3X3_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup53Order::
Data_068_5FCF:: ; address name
    db $04, $03, $00, $05, $02, $01 ; entry 0

; E-0146 (derived: 9 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup54::
Data_068_5FD5:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_77A4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_62_70C1
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_53C7
    dfar KeyWorldScreenHeader_64_5B93
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_63_54F8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld1C_1_Y0X1_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld39_1_Y1X0_Attrs
    dfar KeyWorld31_1_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld10_0_Y2X1_Attrs
    dfar KeyWorld30_3_Y1X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_64_58E6
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_63_6744
    dfar KeyWorldScreenHeader_62_668A
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld40_0_Y2X2_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld40_5_Y1X0_Attrs
    dfar KeyWorld3C_1_Y3X0_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_65_64CA ; id 2
    dfar KeyWorldScreenHeader_65_643F
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_63_6BCD
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_65_41F0
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_63_5EAF
    dfar KeyWorldScreenHeader_64_5218
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_64_460E
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld08_0_Y1X1_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld1E_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld3F_3_Y0X0_Attrs
    dfar KeyWorld34_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld1E_0_Y2X1_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_62_7626 ; id 3
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_64_7945
    dfar KeyWorldScreenHeader_64_6F23
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld18_0_Y3X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_63_6047 ; id 4
    dfar KeyWorldScreenHeader_64_6145
    dfar KeyWorldScreenHeader_63_453F
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_64_4734
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_64_66F6
    dfar KeyWorldScreenHeader_66_4CD6
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_65_5BD1
    dfar KeyWorld34_1_Y2X1_Attrs
    dfar KeyWorld3C_3_Y0X0_Attrs
    dfar KeyWorld12_1_Y2X2_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld10_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y2X3_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld29_1_Y2X2_Attrs
    dfar KeyWorldScreenHeader_64_7945 ; id 5
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_63_7545
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_62_5337
    dfar KeyWorldScreenHeader_65_431E
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld02_0_Y3X0_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld0B_0_Y2X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld12_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 6
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_77EB
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y2X0_Attrs
Data_068_6266:: ; heuristic: label inside a table; C0
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_66_4F98 ; id 7
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_5519
    dfar KeyWorldScreenHeader_64_5A34
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_63_60DA
    dfar KeyWorldScreenHeader_64_60D8
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_63_6EFF
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld1E_0_Y1X1_Attrs
    dfar KeyWorld3C_0_Y3X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld40_2_Y2X2_Attrs
    dfar KeyWorld50_4_Y1X3_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_62_5E91 ; id 8
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld50_5_Y0X0_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup54Order::
Data_068_6335:: ; address name
    db $00, $02, $03, $01, $04, $07, $05, $06, $08 ; entry 0

; E-0146 (derived: 9 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup55::
Data_068_633E:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_65_40C4
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_65_4D49
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_63_5E57
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld15_1_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld4C_4_Y0X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld41_2_Y1X1_Attrs
    dfar KeyWorldScreenHeader_65_6546 ; id 1
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_6808
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_64_594F
    dfar KeyWorldScreenHeader_64_5A34
    dfar KeyWorldScreenHeader_64_5B93
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_64_6073
    dfar KeyWorldScreenHeader_63_5437
    dfar KeyWorldScreenHeader_63_54F8
    dfar KeyWorldScreenHeader_65_50F6
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld17_1_Y0X2_Attrs
    dfar KeyWorld06_0_Y0X1_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld34_2_Y0X3_Attrs
    dfar KeyWorld3C_0_Y3X2_Attrs
    dfar KeyWorld31_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld41_2_Y1X2_Attrs
    dfar KeyWorld3C_3_Y0X1_Attrs
    dfar KeyWorld30_3_Y1X0_Attrs
    dfar KeyWorld55_1_Y3X3_Attrs
    dfar KeyWorldScreenHeader_65_643F ; id 2
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_65_416D
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_63_5EAF
    dfar KeyWorldScreenHeader_64_5218
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5587
    dfar KeyWorldScreenHeader_64_51A5
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorld07_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld3F_3_Y0X0_Attrs
    dfar KeyWorld34_1_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld40_4_Y0X3_Attrs
    dfar KeyWorld40_1_Y3X2_Attrs
    dw KeyWorld1C_1_Y1X2_Attrs
Data_068_645A:: ; heuristic: label inside a table; C0
    db $62
    dfar KeyWorld02_0_Y0X3_Attrs
Data_068_645E:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_64_7848 ; id 3
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_65_57D0
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_63_5437
    dfar KeyWorldScreenHeader_62_75B0
Data_068_6479:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_64_697E
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld55_3_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld3C_3_Y0X1_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld14_1_Y1X2_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorldScreenHeader_64_5218 ; id 4
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_63_45E3
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorld34_1_Y2X2_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld15_1_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorldScreenHeader_63_66AF ; id 5
    dfar KeyWorldScreenHeader_64_5310
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_63_60DA
    dfar KeyWorldScreenHeader_64_5394
    dfar KeyWorldScreenHeader_62_6EDC
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_65_5852
    dfar KeyWorldScreenHeader_62_694C
    dfar KeyWorldScreenHeader_65_41F0
    dfar KeyWorldScreenHeader_65_6DE3
    dfar KeyWorldScreenHeader_65_5B98
    dw KeyWorldScreenHeader_64_6311
Data_068_6547:: ; heuristic: label inside a table; C0
    db $64
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_65_6F70
    dfar KeyWorld40_2_Y3X3_Attrs
    dfar KeyWorld12_1_Y0X2_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld40_2_Y2X2_Attrs
    dw KeyWorld12_1_Y1X2_Attrs
Data_068_655F:: ; heuristic: label inside a table; C0
    db $64
    dfar KeyWorld17_1_Y0X2_Attrs
Data_068_6563:: ; heuristic: label inside a table; C0
    dw KeyWorld02_0_Y0X3_Attrs
Data_068_6565:: ; heuristic: label inside a table; C0
    db $65
    dfar KeyWorld42_1_Y2X0_Attrs
    dfar KeyWorld3F_3_Y0X1_Attrs
    dfar KeyWorld1E_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y1X3_Attrs
Data_068_6572:: ; heuristic: label inside a table; C0
    dfar KeyWorld42_1_Y3X0_Attrs
    dfar KeyWorld40_5_Y1X1_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
Data_068_657B:: ; heuristic: label inside a table; C0
    dfar KeyWorld08_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 6
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
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
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 7
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorldScreenHeader_62_53C7
    dfar KeyWorldScreenHeader_65_55E2
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_64_47BD
    dfar KeyWorldScreenHeader_63_52A2
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorld39_1_Y1X0_Attrs
    dfar KeyWorld47_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld20_1_Y2X1_Attrs
    dfar KeyWorld30_2_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorldScreenHeader_65_5B98 ; id 8
    dfar KeyWorldScreenHeader_62_68C2
    dw KeyWorldScreenHeader_65_416D
Data_068_6646:: ; heuristic: label inside a table; C0
    db $65
    dw KeyWorldScreenHeader_65_70BD
Data_068_6649:: ; heuristic: label inside a table; C0
    db $65
    dw KeyWorldScreenHeader_63_6744
Data_068_664C:: ; heuristic: label inside a table; C0
    db $63
Data_068_664D:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_64_6272
    dw KeyWorldScreenHeader_63_468C
Data_068_6652:: ; heuristic: label inside a table; C0
    db $63
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_64_4843
    dfar KeyWorldScreenHeader_63_4867
Data_068_665C:: ; heuristic: label inside a table; C0
    dfar KeyWorldScreenHeader_64_6828
    dw KeyWorldScreenHeader_66_4DE4
Data_068_6661:: ; heuristic: label inside a table; C0
    db $66
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld42_1_Y3X0_Attrs
    dfar KeyWorld40_5_Y0X0_Attrs
    dfar KeyWorld3C_1_Y3X2_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld40_5_Y1X0_Attrs
    dfar KeyWorld30_0_Y3X3_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld36_0_Y2X1_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup55Order::
Data_068_669E:: ; address name
    db $08, $07, $03, $06, $04, $02, $04, $01, $00 ; entry 0

; E-0146 (derived: 9 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup56::
Data_068_66A7:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_62_528E
    dfar KeyWorldScreenHeader_65_40C4
    dfar KeyWorldScreenHeader_62_7985
    dfar KeyWorldScreenHeader_62_5166
    dfar KeyWorldScreenHeader_65_564B
    dfar KeyWorldScreenHeader_64_51A5
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_64_454F
    dfar KeyWorldScreenHeader_63_65BE
    dfar KeyWorldScreenHeader_64_5218
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld10_0_Y1X1_Attrs
    dfar KeyWorld15_1_Y1X2_Attrs
    dfar KeyWorld04_0_Y2X0_Attrs
    dfar KeyWorld23_0_Y1X1_Attrs
    dfar KeyWorld56_0_Y2X2_Attrs
    dfar KeyWorld40_1_Y3X2_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld31_1_Y2X0_Attrs
    dfar KeyWorld34_2_Y1X3_Attrs
    dfar KeyWorld34_1_Y2X2_Attrs
    dfar KeyWorldScreenHeader_65_77A4 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_64_6828
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_62_702C
    dfar KeyWorldScreenHeader_65_64CA
    dfar KeyWorldScreenHeader_63_7626
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorld11_1_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld10_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X2_Attrs
    dfar KeyWorld1A_0_Y3X2_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_65_65EA ; id 2
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_63_7545
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld0B_0_Y2X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs
    dfar KeyWorldScreenHeader_64_79CF ; id 3
    dfar KeyWorldScreenHeader_63_6D0B
    dfar KeyWorldScreenHeader_64_460E
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_66_5705
    dfar KeyWorldScreenHeader_63_74A4
    dfar KeyWorldScreenHeader_66_4546
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_74B6
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld08_0_Y2X2_Attrs
    dfar KeyWorld1E_0_Y2X1_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y0X0_Attrs
    dfar KeyWorld0D_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld03_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorldScreenHeader_62_423A ; id 4
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_6E4E
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorldScreenHeader_64_72E0
    dfar KeyWorldScreenHeader_65_6546
    dfar KeyWorldScreenHeader_65_5BD1
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_65_5FE5
    dfar KeyWorldScreenHeader_62_5209
    dfar KeyWorldScreenHeader_65_4041
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld0B_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y0X1_Attrs
    dfar KeyWorld29_1_Y2X2_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld10_1_Y0X1_Attrs
    dfar KeyWorld40_1_Y2X1_Attrs
    dfar KeyWorld10_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_62_75B0 ; id 5
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_63_73F8
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld3E_1_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 6
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_5F42
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_62_53C7
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_64_47BD
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_78B1
    dfar KeyWorld06_0_Y3X1_Header
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld39_1_Y1X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld20_1_Y2X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_0_Y3X0_Attrs
    dfar KeyWorld06_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_62_5337 ; id 7
    dfar KeyWorldScreenHeader_65_43BD
    dfar KeyWorldScreenHeader_63_5F99
    dfar KeyWorldScreenHeader_62_668A
    dfar KeyWorldScreenHeader_62_6083
    dfar KeyWorldScreenHeader_63_4867
    dfar KeyWorldScreenHeader_64_46A7
    dfar KeyWorldScreenHeader_63_64F3
    dfar KeyWorldScreenHeader_63_472D
    dfar KeyWorldScreenHeader_64_6A43
    dfar KeyWorldScreenHeader_63_6DB3
    dfar KeyWorldScreenHeader_64_460E
    dfar KeyWorldScreenHeader_66_478E
    dfar KeyWorldScreenHeader_66_505C
    dfar KeyWorldScreenHeader_64_7B56
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorld12_0_Y1X1_Attrs
    dfar KeyWorld00_0_Y1X2_Attrs
    dfar KeyWorld12_1_Y1X1_Attrs
    dfar KeyWorld3C_1_Y3X0_Attrs
    dfar KeyWorld40_2_Y1X3_Attrs
    dfar KeyWorld1E_0_Y2X2_Attrs
    dfar KeyWorld12_1_Y2X1_Attrs
    dfar KeyWorld42_3_Y0X0_Attrs
    dfar KeyWorld30_3_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X2_Attrs
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld1E_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y2X2_Attrs
    dfar KeyWorld10_1_Y3X3_Attrs
    dfar KeyWorld04_0_Y3X0_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorldScreenHeader_65_445B ; id 8
    dfar KeyWorldScreenHeader_62_5519
    dfar KeyWorldScreenHeader_65_41F0
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_62_694C
    dfar KeyWorldScreenHeader_65_5852
    dfar KeyWorldScreenHeader_64_5284
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_63_557A
    dfar KeyWorldScreenHeader_63_5437
    dfar KeyWorldScreenHeader_63_468C
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorldScreenHeader_66_46C5
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4D7D
    dfar KeyWorld32_1_Y2X0_Attrs
    dfar KeyWorld1E_0_Y1X1_Attrs
    dfar KeyWorld1E_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld3F_3_Y0X1_Attrs
    dfar KeyWorld42_1_Y2X0_Attrs
    dfar KeyWorld3C_1_Y2X0_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld23_0_Y2X2_Attrs
    dfar KeyWorld3C_3_Y0X1_Attrs
    dfar KeyWorld10_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorld04_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y3X3_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup56Order::
Data_068_6A07:: ; address name
    db $03, $02, $00, $07, $04, $01, $08, $06, $05 ; entry 0

; E-0146 (derived: 9 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup57::
Data_068_6A10:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0
    dfar KeyWorldScreenHeader_66_589C
    dfar KeyWorldScreenHeader_65_68B7
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_65_6C81
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_64_7848
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_63_6FC0
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld10_1_Y0X0_Attrs
    dfar KeyWorld06_0_Y0X2_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld03_0_Y1X2_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld05_0_Y3X0_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld16_1_Y1X1_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_6693
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_65_5E8C
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6E8B
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y0X1_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y0X1_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld02_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 3
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_77CC
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_54FD
    dfar KeyWorldScreenHeader_65_6736
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_75B0
    dfar KeyWorldScreenHeader_62_4365
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5477
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld08_0_Y2X1_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y0X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y1X0_Attrs
    dfar KeyWorld02_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y0X0_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorldScreenHeader_64_6F23 ; id 4
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_66_5658
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_63_73F8
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_63_6C79
    dfar KeyWorldScreenHeader_65_6D0D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_62_7626
    dfar KeyWorldScreenHeader_62_6D6B
    dfar KeyWorldScreenHeader_65_65EA
    dfar KeyWorldScreenHeader_65_7641
    dfar KeyWorldScreenHeader_62_7517
    dfar KeyWorld18_0_Y3X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld0B_0_Y0X0_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld3E_1_Y3X0_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld13_0_Y2X1_Attrs
    dfar KeyWorld04_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld02_0_Y2X0_Attrs
    dfar KeyWorld08_0_Y1X2_Attrs
    dfar KeyWorld04_0_Y0X2_Attrs
    dfar KeyWorld00_0_Y0X3_Attrs
    dfar KeyWorld10_0_Y1X0_Attrs
    dfar KeyWorldScreenHeader_64_6828 ; id 5
    dfar KeyWorldScreenHeader_66_4E6E
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_65_751D
    dfar KeyWorldScreenHeader_62_774A
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_62_6F90
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_62_423A
    dfar KeyWorldScreenHeader_62_41C9
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld0A_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld07_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y2X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld1C_1_Y1X2_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y1X2_Attrs
    dfar KeyWorld11_1_Y1X1_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorldScreenHeader_66_5CC8 ; id 6
    dfar KeyWorldScreenHeader_62_78C0
    dfar KeyWorldScreenHeader_64_68E4
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4F98
    dfar KeyWorldScreenHeader_66_5560
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_57D9
    dfar KeyWorldScreenHeader_65_5D1D
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7C14
    dfar KeyWorldScreenHeader_66_4917
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld04_0_Y1X0_Attrs
    dfar KeyWorld10_0_Y3X2_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld03_0_Y2X2_Attrs
    dfar KeyWorld01_0_Y1X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld17_1_Y2X1_Attrs
    dfar KeyWorld24_1_Y2X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld07_0_Y3X2_Attrs
    dfar KeyWorld00_0_Y3X2_Attrs
    dfar KeyWorldScreenHeader_63_6EFF ; id 7
    dfar KeyWorldScreenHeader_64_6AEC
    dfar KeyWorldScreenHeader_64_706F
    dfar KeyWorldScreenHeader_63_7626
    dfar KeyWorldScreenHeader_65_5DD4
    dfar KeyWorldScreenHeader_65_7023
    dfar KeyWorldScreenHeader_64_79CF
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_62_42B3
    dfar KeyWorldScreenHeader_65_70BD
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_66_55DC
    dfar KeyWorldScreenHeader_66_4859
    dfar KeyWorldScreenHeader_66_5115
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorldScreenHeader_64_7A7D
    dfar KeyWorld14_1_Y1X1_Attrs
    dfar KeyWorld11_1_Y2X2_Attrs
    dfar KeyWorld17_0_Y3X1_Attrs
    dfar KeyWorld1A_0_Y3X2_Attrs
    dfar KeyWorld13_0_Y1X1_Attrs
    dfar KeyWorld06_0_Y2X3_Attrs
    dfar KeyWorld01_0_Y3X0_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld04_0_Y2X1_Attrs
    dfar KeyWorld05_0_Y1X1_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld01_0_Y0X1_Attrs
    dfar KeyWorld00_0_Y3X1_Attrs
    dfar KeyWorld05_0_Y3X3_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs
    dfar KeyWorld00_0_Y3X0_Attrs
    dfar KeyWorldScreenHeader_63_6DB3 ; id 8
    dfar KeyWorld01_0_Y2X1_Header
    dfar KeyWorldScreenHeader_62_6E33
    dfar KeyWorldScreenHeader_65_75A3
    dfar KeyWorldScreenHeader_62_76AE
    dfar KeyWorldScreenHeader_62_406A
    dfar KeyWorldScreenHeader_62_40EE
    dfar KeyWorldScreenHeader_65_6D65
    dfar KeyWorldScreenHeader_65_5C71
    dfar KeyWorldScreenHeader_62_43CA
    dfar KeyWorldScreenHeader_64_6797
    dfar KeyWorldScreenHeader_66_4EF7
    dfar KeyWorldScreenHeader_66_45B4
    dfar KeyWorldScreenHeader_66_4635
    dfar KeyWorldScreenHeader_66_4DE4
    dfar KeyWorldScreenHeader_66_5CC8
    dfar KeyWorld27_0_Y1X3_Attrs
    dfar KeyWorld01_0_Y2X1_Attrs
    dfar KeyWorld05_0_Y2X1_Attrs
    dfar KeyWorld02_0_Y0X3_Attrs
    dfar KeyWorld00_0_Y1X0_Attrs
    dfar KeyWorld04_0_Y2X2_Attrs
    dfar KeyWorld04_0_Y1X2_Attrs
    dfar KeyWorld00_0_Y2X3_Attrs
    dfar KeyWorld05_0_Y2X2_Attrs
    dfar KeyWorld02_0_Y1X1_Attrs
    dfar KeyWorld0F_0_Y1X2_Attrs
    dfar KeyWorld08_0_Y3X3_Attrs
    dfar KeyWorld0A_0_Y1X2_Attrs
    dfar KeyWorld05_0_Y3X1_Attrs
    dfar KeyWorld01_0_Y3X2_Attrs
    dfar KeyWorld01_0_Y0X0_Attrs

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup57Order::
Data_068_6D70:: ; address name
    db $05, $06, $08, $01, $04, $07, $00, $02, $03 ; entry 0

; compressed tileset of map $A2 (the first map record using it)
; LZSS-compressed asset: 1435 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Tileset:: ; heuristic: map tileset stream; C0
Data_068_6D79:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A2D79, $59B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapA2Palettes::
Data_068_7314:: ; address name
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
Data_068_7354:: ; address name
    dfar MapA2Screens0_Y0X0 ; entry 0
    dfar MapA2Screens0_Y0X1 ; entry 1
    dfar MapA2Screens0_Y0X2 ; entry 2
    dfar MapA2Screens0_Y1X0 ; entry 3
    dfar MapA2Screens0_Y1X1 ; entry 4
    dfar MapA2Screens0_Y1X2 ; entry 5
    dfar MapA2Screens0_Y2X0 ; entry 6
    dfar MapA2Screens0_Y2X1 ; entry 7
    dfar MapA2Screens0_Y2X2 ; entry 8
    dfar MapA2Screens0_Y3X0 ; entry 9
    dfar MapA2Screens0_Y3X1 ; entry 10
    dfar MapA2Screens0_Y3X2 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA2Attrs0::
Data_068_7378:: ; address name
    dfar MapA2Attrs0_Y0X0 ; entry 0
    dfar MapA2Attrs0_Y0X1 ; entry 1
    dfar MapA2Attrs0_Y0X2 ; entry 2
    dfar MapA2Attrs0_Y1X0 ; entry 3
    dfar MapA2Attrs0_Y1X1 ; entry 4
    dfar MapA2Attrs0_Y1X2 ; entry 5
    dfar MapA2Attrs0_Y2X0 ; entry 6
    dfar MapA2Attrs0_Y2X1 ; entry 7
    dfar MapA2Attrs0_Y2X2 ; entry 8
    dfar MapA2Attrs0_Y3X0 ; entry 9
    dfar MapA2Attrs0_Y3X1 ; entry 10
    dfar MapA2Attrs0_Y3X2 ; entry 11

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_068_739C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A339C, $F6

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_068_7492:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A3492, $F8

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y0X2:: ; heuristic: map screen stream; C0
Data_068_758A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A358A, $F8

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_068_7682:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A3682, $AA

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_068_772C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A372C, $E8

; LZSS-compressed asset: 163 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y1X2:: ; heuristic: map screen stream; C0
Data_068_7814:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A3814, $A3

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y2X0:: ; heuristic: map screen stream; C0
Data_068_78B7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A38B7, $C0

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y2X1:: ; heuristic: map screen stream; C0
Data_068_7977:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A3977, $E3

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y2X2:: ; heuristic: map screen stream; C0
Data_068_7A5A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A3A5A, $C2

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y3X0:: ; heuristic: map screen stream; C0
Data_068_7B1C:: ; address name
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y3X1:: ; heuristic: map screen stream; C0
Data_068_7B30:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A3B30, $55

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Screens0_Y3X2:: ; heuristic: map screen stream; C0
Data_068_7B85:: ; address name
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_068_7B99:: ; address name
    db $68, $01, $00, $04, $04, $02, $00, $02, $0D, $04, $00, $00, $0F, $00, $04, $00
    db $14, $0F, $00, $00, $28, $0F, $2B, $01, $01, $02, $02, $01, $01, $00, $7A, $08
    db $00, $78, $0F, $05, $00, $A2, $0C, $00, $A0, $0F, $2B, $00, $A0, $08, $00, $28
    db $00, $00, $FE, $02, $00, $F4, $0F, $09, $00, $FE, $06, $00, $1A, $1F, $27

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_068_7BD8:: ; address name
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $01, $00, $4E, $01, $00, $57, $01, $00
    db $4E, $07, $00, $55, $04, $00, $66, $02, $00, $64, $02, $00, $68, $08, $00, $55
    db $02, $00, $7A, $0F, $01, $00, $66, $0C, $00, $9E, $0F, $07, $00, $C4, $0F, $11
    db $04, $04, $00, $E0, $0E, $00, $F0, $0F, $03, $00, $16, $1F, $3B

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_068_7C15:: ; address name
    db $68, $01, $00, $02, $00, $00, $0D, $04, $04, $00, $01, $0F, $00, $00, $13, $0D
    db $04, $00, $25, $0F, $2C, $01, $01, $02, $02, $01, $01, $00, $78, $08, $00, $76
    db $0F, $05, $00, $A0, $0C, $00, $9E, $0F, $2B, $00, $EE, $02, $00, $E4, $0E, $00
    db $F4, $0F, $03, $00, $9E, $06, $00, $14, $1F, $2D

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_068_7C4F:: ; address name
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $03, $00, $00, $00, $00, $0C
    db $04, $00, $04, $0E, $00, $04, $04, $00, $1E, $0F, $3F, $00, $04, $06, $00, $7A
    db $0F, $33, $00, $20, $0F, $33, $00, $02, $0F, $15, $00, $02, $0F, $13

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_068_7C7D:: ; address name
    db $68, $01, $00, $04, $00, $00, $0F, $18, $01, $00, $2C, $07, $00, $24, $0F, $07
    db $00, $2C, $08, $00, $34, $04, $00, $52, $0E, $00, $52, $0C, $00, $78, $0F, $2D
    db $00, $50, $0F, $15, $00, $28, $0F, $17, $00, $28, $08, $00, $20, $0F, $01, $00
    db $26, $1F, $1B

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_068_7CB0:: ; address name
    db $68, $01, $00, $04, $00, $00, $03, $01, $00, $08, $03, $00, $00, $04, $00, $04
    db $0F, $0D, $00, $0E, $08, $00, $30, $0F, $21, $00, $30, $06, $00, $6E, $0F, $33
    db $00, $28, $0F, $3D, $00, $00, $0F, $25, $00, $10, $0F, $05

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_068_7CDC:: ; address name
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $03, $00, $00, $00, $00, $0C
    db $04, $00, $04, $0F, $09, $00, $0A, $08, $00, $2C, $0F, $0B, $00, $06, $06, $00
    db $54, $0F, $29, $00, $52, $0C, $00, $A0, $0F, $07, $00, $52, $0A, $00, $C8, $0F
    db $09, $00, $F7, $0F, $4D, $00, $08, $1C

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_068_7D14:: ; address name
    db $68, $01, $00, $04, $00, $00, $01, $01, $00, $06, $03, $00, $00, $02, $00, $00
    db $0F, $05, $00, $06, $04, $00, $0A, $08, $00, $2C, $0C, $00, $2C, $08, $00, $5B
    db $0F, $4D, $00, $90, $0F, $21, $00, $4E, $0E, $00, $4C, $0F, $01, $00, $26, $0F
    db $17, $00, $28, $0F, $15

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_068_7D49:: ; address name
    db $68, $01, $00, $04, $00, $00, $03, $01, $00, $08, $03, $00, $00, $04, $00, $04
    db $0F, $03, $00, $08, $04, $00, $22, $0F, $07, $00, $2E, $06, $00, $46, $0F, $41
    db $00, $28, $0C, $00, $AA, $0F, $03, $00, $26, $0E, $00, $0E, $0A, $00, $F3, $0F
    db $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y3X0:: ; heuristic: map screen stream; C0
Data_068_7D7E:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 26 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y3X1:: ; heuristic: map screen stream; C0
Data_068_7D91:: ; address name
    db $68, $01, $02, $02, $FF, $F0, $01, $02, $04, $07, $02, $FC, $FF, $4D, $02, $5C
    db $0F, $4D, $02, $BC, $0F, $4D, $02, $08, $1F, $25

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Attrs0_Y3X2:: ; heuristic: map screen stream; C0
Data_068_7DAB:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapX62F0Palettes::
Data_068_7DBE:: ; address name
    dw $396B, $7FFF, $5A94, $0000 ; entry 0
    dw $012F, $035F, $01DA, $0000 ; entry 1
    dw $48EC, $6BFF, $4A6F, $0000 ; entry 2
    dw $1154, $53DE, $229A, $0084 ; entry 3
    dw $218C, $4F18, $3A52, $0000 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapX62F0Screens0::
Data_068_7DFE:: ; address name
    dfar MapX62F0Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapX62F0Attrs0::
Data_068_7E01:: ; address name
    dfar MapX62F0Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapX62F0Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_068_7E04:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A3E04, $BA

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapX62F0Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_068_7EBE:: ; address name
    db $68, $01, $04, $04, $FF, $F0, $02, $04, $04, $07, $04, $FC, $FF, $07, $04, $04
    db $04, $01, $01, $04, $0A, $06, $04, $2A, $0F, $05, $03, $04, $56, $03, $04, $4A
    db $0F, $0B, $04, $56, $04, $04, $5A, $02, $04, $76, $0F, $4D, $04, $AE, $0F, $1F
    db $04, $54, $0F, $13, $04, $50, $06, $04, $0C, $0C, $04, $48, $18
    ds $105, $00
