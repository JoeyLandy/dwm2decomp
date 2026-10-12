SECTION "Bank 67", ROMX[$4000], BANK[$67]
    db $67

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup00::
Data_067_4001:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50CE ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_48DA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_44A8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup00Order::
Data_067_4061:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup01::
Data_067_4062:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup01Order::
Data_067_40C2:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup02::
Data_067_40C3:: ; address name
    dfar KeyWorldScreenHeader_66_5477 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup02Order::
Data_067_4123:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup03::
Data_067_4124:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup03Order::
Data_067_4184:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup04::
Data_067_4185:: ; address name
    dfar KeyWorldScreenHeader_66_5705 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup04Order::
Data_067_41E5:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup05::
Data_067_41E6:: ; address name
    dfar KeyWorldScreenHeader_66_5705 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup05Order::
Data_067_4246:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup06::
Data_067_4247:: ; address name
    dfar KeyWorldScreenHeader_66_55DC ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4454 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7CD5 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld06_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld06_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup06Order::
Data_067_42A7:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup07::
Data_067_42A8:: ; address name
    dfar KeyWorldScreenHeader_66_596B ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7073 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7161 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld07_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld07_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup07Order::
Data_067_4308:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup08::
Data_067_4309:: ; address name
    dfar KeyWorldScreenHeader_66_5560 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7CD5 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld06_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup08Order::
Data_067_4369:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup09::
Data_067_436A:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup09Order::
Data_067_43CA:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0A::
Data_067_43CB:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0AOrder::
Data_067_442B:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0B::
Data_067_442C:: ; address name
    dfar KeyWorldScreenHeader_66_5658 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_72E0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6FCF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7545 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0B_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0B_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0B_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0BOrder::
Data_067_448C:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0C::
Data_067_448D:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7139 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0C_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0COrder::
Data_067_44ED:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0D::
Data_067_44EE:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_74A4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_72E0 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0D_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0B_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0DOrder::
Data_067_454E:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0E::
Data_067_454F:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_596B ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_76CB ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6FCF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7CD5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0E_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0B_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0EOrder::
Data_067_45AF:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 1 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup0F::
Data_067_45B0:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4642 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_51C2 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0F_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0F_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup0FOrder::
Data_067_4610:: ; address name
    db $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup10::
Data_067_4611:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4041 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_589C ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6CE1 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld10_1_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup10Order::
Data_067_46D1:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup11::
Data_067_46D3:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7545 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0B_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_7626 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup11Order::
Data_067_4793:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup12::
Data_067_4795:: ; address name
    dfar KeyWorldScreenHeader_66_55DC ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5485 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_431E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld12_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld12_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld12_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_77EB ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6148 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5310 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5F99 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5394 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld12_1_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld12_1_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld12_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld12_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup12Order::
Data_067_4855:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup13::
Data_067_4857:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5477 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup13Order::
Data_067_4917:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup14::
Data_067_4919:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6CE1 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_1_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_7626 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup14Order::
Data_067_49D9:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup15::
Data_067_49DB:: ; address name
    dfar KeyWorldScreenHeader_66_5705 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7545 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0B_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5560 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50CE ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40C4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_48DA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld15_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup15Order::
Data_067_4A9B:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup16::
Data_067_4A9D:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_60A2 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_559B ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40C4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld16_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld16_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld15_1_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_7626 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4960 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_44A8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7CD5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld16_1_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup16Order::
Data_067_4B5D:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup17::
Data_067_4B5F:: ; address name
    dfar KeyWorldScreenHeader_66_55DC ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6BB5 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_794A ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld17_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5560 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7161 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld07_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup17Order::
Data_067_4C1F:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup18::
Data_067_4C21:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6F23 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld18_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5477 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_72E0 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0B_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup18Order::
Data_067_4CE1:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup19::
Data_067_4CE3:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_74A4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7139 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7CD5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0D_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0C_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_76CB ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_748C ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_735C ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0E_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld19_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld19_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup19Order::
Data_067_4DA3:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1A::
Data_067_4DA5:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7952 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7626 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1A_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld1A_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_72E0 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0B_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1AOrder::
Data_067_4E65:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1B::
Data_067_4E67:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_596B ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_60A2 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld16_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_7848 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7793 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1B_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1BOrder::
Data_067_4F27:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1C::
Data_067_4F29:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_785D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1C_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_77EB ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4642 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4507 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0F_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1C_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1COrder::
Data_067_4FE9:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1D::
Data_067_4FEB:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_596B ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7161 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld07_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld07_0_Y2X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_76CB ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0E_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1DOrder::
Data_067_50AB:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1E::
Data_067_50AD:: ; address name
    dfar KeyWorldScreenHeader_66_55DC ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5519 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41F0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7A62 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_460E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46CC ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1E_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1E_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld1E_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld1E_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld1E_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_73B7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld1E_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1EOrder::
Data_067_516D:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup1F::
Data_067_516F:: ; address name
    dfar KeyWorldScreenHeader_66_57D9 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_596B ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_785D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4733 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1C_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld1F_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_774A ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44EB ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7CD5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld1F_1_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup1FOrder::
Data_067_522F:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup20::
Data_067_5231:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6659 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld20_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_65EA ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6B43 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5519 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40C4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_47BD ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld20_1_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1E_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld15_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld20_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup20Order::
Data_067_52F1:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup21::
Data_067_52F3:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_76CB ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0E_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_57D9 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6659 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld20_0_Y1X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup21Order::
Data_067_53B3:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup22::
Data_067_53B5:: ; address name
    dfar KeyWorldScreenHeader_66_5477 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_72E0 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6B43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0B_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld20_1_Y1X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_77A4 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7175 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_76CB ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld22_1_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0E_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup22Order::
Data_067_5475:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup23::
Data_067_5477:: ; address name
    dfar KeyWorldScreenHeader_66_589C ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_59BA ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4291 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_557A ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld23_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld23_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld12_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld23_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_751D ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup23Order::
Data_067_5537:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup24::
Data_067_5539:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6736 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup24Order::
Data_067_55F9:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup25::
Data_067_55FB:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_65EA ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup25Order::
Data_067_56BB:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup26::
Data_067_56BD:: ; address name
    dfar KeyWorldScreenHeader_66_5658 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6BB5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7175 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld22_1_Y1X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_54FD ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_596B ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_794A ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7161 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7161 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7CD5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_51C2 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld17_0_Y3X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld07_0_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld07_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld06_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld0F_0_Y3X1_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup26Order::
Data_067_577D:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup27::
Data_067_577F:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6991 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7952 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7CD5 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld27_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1A_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld06_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_77A4 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6991 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7175 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4454 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7161 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_49F7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld27_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld22_1_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld06_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld07_0_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld27_1_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup27Order::
Data_067_583F:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup28::
Data_067_5841:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4792 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld28_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5658 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7793 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7227 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_76CB ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld1B_1_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld28_1_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0E_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup28Order::
Data_067_5901:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup29::
Data_067_5903:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld29_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld29_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_74B6 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_794A ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7139 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5BD1 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld17_0_Y3X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0C_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld29_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup29Order::
Data_067_59C3:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2A::
Data_067_59C5:: ; address name
    dfar KeyWorldScreenHeader_66_5705 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45A7 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4454 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld2A_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld06_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_735C ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld19_1_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2AOrder::
Data_067_5A85:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2B::
Data_067_5A87:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_596B ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7545 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld0B_0_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6736 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2BOrder::
Data_067_5B47:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2C::
Data_067_5B49:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6FCF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_785D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7139 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_74A4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_49F7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0B_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1C_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld0C_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld0D_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld27_1_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_54FD ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6991 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_76CB ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6F23 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_73B7 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld27_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld0E_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld18_0_Y3X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld1E_1_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2COrder::
Data_067_5C09:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2D::
Data_067_5C0B:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_72E0 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7CD5 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0B_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y3X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5560 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2DOrder::
Data_067_5CCB:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2E::
Data_067_5CCD:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_596B ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4642 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7793 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0F_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld1B_1_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2EOrder::
Data_067_5D8D:: ; address name
    db $00, $01 ; entry 0

; E-0146 (derived: 2 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup2F::
Data_067_5D8F:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6808 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_794A ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4507 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7073 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld17_0_Y3X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld1C_1_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld07_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup2FOrder::
Data_067_5E4F:: ; address name
    db $01, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup30::
Data_067_5E51:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50CE ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5737 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6148 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6272 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld30_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld12_1_Y0X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld30_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6693 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_431E ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_544D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6CE1 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_48FA ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld12_0_Y3X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld30_1_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_1_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld30_1_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_774A ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5DED ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_662E ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_48DA ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_52A2 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld30_2_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld30_2_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld30_2_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_5AD4 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_431E ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_54F8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_472D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld12_0_Y3X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld30_3_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld30_3_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup30Order::
Data_067_5FD1:: ; address name
    db $00, $01, $02, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup31::
Data_067_5FD5:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_68B7 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5B93 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_431E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_53B1 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_47D4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld31_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld12_0_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld31_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld31_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_589C ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_54FD ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_74A4 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6B43 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld0D_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld20_1_Y1X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup31Order::
Data_067_6155:: ; address name
    db $03, $01, $02, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup32::
Data_067_6159:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5BD1 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5AD4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5D6D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_531D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld29_1_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld30_3_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld32_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld32_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5658 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_445B ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6CE1 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld32_1_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_1_Y0X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_7517 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6659 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld20_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_63_6DB3 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6B43 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6659 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld20_1_Y1X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld20_0_Y1X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup32Order::
Data_067_62D9:: ; address name
    db $01, $02, $00, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup33::
Data_067_62DD:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6659 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld20_0_Y1X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_743F ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7175 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld22_1_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_72E0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6B43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0B_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld20_1_Y1X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_5DD4 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup33Order::
Data_067_645D:: ; address name
    db $03, $00, $02, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup34::
Data_067_6461:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_589C ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5485 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4291 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6047 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5218 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6148 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5128 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld12_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld23_0_Y1X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld34_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld34_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld12_1_Y0X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld34_1_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_594F ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_65BE ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld34_2_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld34_2_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_445B ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_460E ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5218 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld32_1_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld1E_0_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld34_1_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup34Order::
Data_067_65E1:: ; address name
    db $00, $01, $03, $02 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup35::
Data_067_65E5:: ; address name
    dfar KeyWorldScreenHeader_66_5705 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5519 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4041 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1E_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld12_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5477 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7793 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld1B_1_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_41C9 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup35Order::
Data_067_6765:: ; address name
    db $02, $03, $01, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup36::
Data_067_6769:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5485 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_431E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_72E0 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld12_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld12_0_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld0B_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6546 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6FCF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0B_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_76AE ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_4F98 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup36Order::
Data_067_68E9:: ; address name
    db $02, $03, $00, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup37::
Data_067_68ED:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6736 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_76AE ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41F0 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld1E_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_43CA ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7175 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld22_1_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup37Order::
Data_067_6A6D:: ; address name
    db $01, $00, $02, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup38::
Data_067_6A71:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_65EA ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_7985 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6B43 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld20_1_Y1X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_42B3 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup38Order::
Data_067_6BF1:: ; address name
    db $00, $02, $01, $03 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup39::
Data_067_6BF5:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6693 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_53C7 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_594F ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5229 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_47D4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6B43 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld39_1_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld34_2_Y0X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld39_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld31_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld20_1_Y1X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_7985 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6D0D ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_72E0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0B_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup39Order::
Data_067_6D75:: ; address name
    db $03, $01, $02, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3A::
Data_067_6D79:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_720E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld3A_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5560 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7175 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_74A4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld22_1_Y1X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0D_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_60A2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld16_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_7878 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3AOrder::
Data_067_6EF9:: ; address name
    db $02, $00, $03, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3B::
Data_067_6EFD:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_785D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld1C_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50CE ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4041 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5DED ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5128 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld30_2_Y0X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld34_1_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_76AE ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7175 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld22_1_Y1X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_78C0 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6047 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5394 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld34_1_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld12_1_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3BOrder::
Data_067_707D:: ; address name
    db $02, $03, $00, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3C::
Data_067_7081:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5F99 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5A34 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56B8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld12_1_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld3C_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld3C_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_65EA ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41F0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5284 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_668A ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_594F ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld1E_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld3C_1_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld3C_1_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld34_2_Y0X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_78C0 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_54F8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6636 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5F99 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld30_3_Y1X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld3C_2_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld12_1_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_6145 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5437 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_47D4 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5310 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_472D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld3C_3_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld31_1_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld12_1_Y0X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld30_3_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3COrder::
Data_067_7201:: ; address name
    db $00, $03, $01, $02 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3D::
Data_067_7205:: ; address name
    dfar KeyWorldScreenHeader_66_5560 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_65EA ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_77EB ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_720E ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_720E ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld3A_0_Y1X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld3A_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5BD1 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld29_1_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3DOrder::
Data_067_7385:: ; address name
    db $02, $01, $03, $00 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3E::
Data_067_7389:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7139 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld0C_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7545 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_73F8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0B_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld3E_1_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_78B1 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6D0D ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_785D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1C_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3EOrder::
Data_067_7509:: ; address name
    db $03, $02, $00, $01 ; entry 0

; E-0146 (derived: 4 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup3F::
Data_067_750D:: ; address name
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7793 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5BD1 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1B_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld29_1_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_65EA ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_53C7 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40C4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld39_1_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld15_1_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_63_5EAF ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_694C ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_445B ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_460E ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_67DB ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54EA ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_48DA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_44A8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld3F_3_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld32_1_Y2X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld1E_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld3F_3_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld3F_3_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup3FOrder::
Data_067_768D:: ; address name
    db $01, $00, $02, $03 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup40::
Data_067_7691:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_58E6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5864 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_531D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_65BE ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld40_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld40_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld32_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld34_2_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5560 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5209 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40C4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5218 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5EAF ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51A5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld40_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld15_1_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld34_1_Y2X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld3F_3_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld40_1_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_76AE ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6047 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_53C7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6083 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_60DA ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6807 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_47BD ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_66AF ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld34_1_Y2X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld39_1_Y1X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld40_2_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld40_2_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld40_2_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld20_1_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld40_2_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_5310 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_472D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4291 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5218 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld30_3_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld23_0_Y1X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld34_1_Y2X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_75B0 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5209 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5587 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5EAF ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_601C ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_460E ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld40_1_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld40_4_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld3F_3_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld40_4_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1E_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_68C2 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5C31 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_431E ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6744 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6311 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_47D4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_48FA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld40_5_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld12_0_Y3X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld40_5_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld40_5_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld31_1_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld30_1_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup40Order::
Data_067_78D1:: ; address name
    db $00, $01, $02, $03, $04, $05 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup41::
Data_067_78D7:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_68B7 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_7517 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_594F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40C4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5E57 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6073 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_472D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4DE3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_431E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6148 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_544D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld34_2_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld15_1_Y1X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld41_2_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld41_2_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld30_3_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld41_2_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld12_0_Y3X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld12_1_Y0X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld30_1_Y2X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_70BD ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_472D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_735C ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld30_3_Y1X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld19_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_6F90 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup41Order::
Data_067_7B17:: ; address name
    db $04, $05, $03, $02, $01, $00 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup42::
Data_067_7B1D:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5E57 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld41_2_Y1X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_68B7 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5519 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5852 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_544D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5B98 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_68C2 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40C4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld1E_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld42_1_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld30_1_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld42_1_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld40_5_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld15_1_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_63_64F3 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6311 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_44A8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_460E ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld42_3_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld40_5_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld1E_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_78C0 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_5E8C ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup42Order::
Data_067_7D5D:: ; address name
    db $04, $05, $03, $02, $00, $01 ; entry 0

; E-0146 (derived: 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before each tile map)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup43::
Data_067_7D63:: ; address name
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_53C7 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld39_1_Y1X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_60A2 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7175 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7626 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld16_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld22_1_Y1X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld1A_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_76AE ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6148 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld12_1_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_544D ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_472D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld30_1_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld30_3_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6659 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld20_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_4546 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_73F8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld3E_1_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; E-0146 (derived: a permutation of the sub-chunk numbers)
; record: sub-chunk order
KeyWorldChunkGroup43Order::
Data_067_7FA3:: ; address name
    db $01, $00, $02, $03, $05, $04 ; entry 0
    ds $57, $00
