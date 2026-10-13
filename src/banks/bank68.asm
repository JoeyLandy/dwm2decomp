SECTION "Bank 68", ROMX[$4000], BANK[$68]
    db $68

; 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before
; each tile map (E-0146)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the
; AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup44::
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_431E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_47D4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld12_0_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld31_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5658 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5A34 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6636 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5218 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld3C_0_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld3C_2_Y0X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld34_1_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_63_60DA ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_544D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6148 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_68C2 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41F0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6744 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5284 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5485 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_613E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y2X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld30_1_Y2X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld12_1_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld40_5_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1E_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld40_5_Y1X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld3C_1_Y2X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld12_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld44_3_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5560 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5A34 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5F99 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6145 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_472D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld3C_0_Y3X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld12_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld3C_3_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld30_3_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_5737 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5394 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5437 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_47D4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld30_0_Y2X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld12_1_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld3C_3_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld31_1_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

; a permutation of the sub-chunk numbers (E-0146)
; record: sub-chunk order
KeyWorldChunkGroup44Order::
    db $04, $05, $03, $02, $00, $01 ; entry 0

KeyWorldChunkGroup45::
    dfar KeyWorldScreenHeader_66_5560 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_73B7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld1E_1_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_751D ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_720E ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld3A_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6693 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_76AE ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_75A3 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_74A4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0D_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup45Order::
    db $00, $02, $01, $03, $04, $05 ; entry 0

KeyWorldChunkGroup46::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_7848 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_73B7 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld1E_1_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_60A2 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld16_0_Y2X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_7848 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_423A ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6B43 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41F0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld20_1_Y1X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld1E_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup46Order::
    db $05, $04, $03, $02, $01, $00 ; entry 0

KeyWorldChunkGroup47::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_60A2 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5209 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5209 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55E2 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5F99 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6272 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld16_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld40_1_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld40_1_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld47_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld12_1_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld30_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6693 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5AD4 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_59BA ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6145 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_531D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_47D4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld30_3_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld23_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld3C_3_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld32_0_Y3X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld31_1_Y2X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_7517 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5FBC ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5EAF ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_544D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5E57 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5394 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld47_2_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld3F_3_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld30_1_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld41_2_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld12_1_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_41C9 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_7985 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5209 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5056 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_472D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5E57 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6272 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld40_1_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld47_4_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld30_3_Y1X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld41_2_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld30_0_Y3X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_70C1 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup47Order::
    db $01, $00, $02, $03, $05, $04 ; entry 0

; 3 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before
; each tile map (E-0146)
KeyWorldChunkGroup48::
    dfar KeyWorldScreenHeader_66_55DC ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5560 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7626 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld1A_0_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_65EA ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup48Order::
    db $00, $01, $02 ; entry 0

KeyWorldChunkGroup49::
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7626 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld1A_0_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6546 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_48DA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5705 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_720E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld3A_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup49Order::
    db $02, $01, $00 ; entry 0

KeyWorldChunkGroup4A::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_57D9 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_64CA ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5209 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5AD4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_445B ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_54F8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_48FA ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld40_1_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld30_3_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld32_1_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld30_3_Y1X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld30_1_Y3X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup4AOrder::
    db $01, $00, $02 ; entry 0

KeyWorldChunkGroup4B::
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5209 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_594F ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_531D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld40_1_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld34_2_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld32_0_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_7878 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6546 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup4BOrder::
    db $02, $00, $01 ; entry 0

; 6 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before
; each tile map (E-0146)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the
; AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4C::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_58E6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_64F3 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld40_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld42_3_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_65EA ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_662E ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5A34 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5AD4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld30_2_Y0X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld3C_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld30_3_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_64CA ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_594F ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41F0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5EAF ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6073 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5E57 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54EA ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld34_2_Y0X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1E_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld3F_3_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld41_2_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld41_2_Y1X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld3F_3_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_7B56 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5209 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56B8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5EAF ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6145 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_44A8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld40_1_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld3C_0_Y3X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld3F_3_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld3C_3_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_61C5 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_65BE ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6073 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4D49 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_472D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_47BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld4C_4_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld34_2_Y1X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld41_2_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld4C_4_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld30_3_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld20_1_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_5587 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5218 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7878 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_557A ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4FAD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld40_4_Y0X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld34_1_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld1D_1_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld23_0_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld4C_5_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 15: compressed attribute map

; a permutation of the sub-chunk numbers (E-0146)
; record: sub-chunk order
KeyWorldChunkGroup4COrder::
    db $00, $02, $05, $01, $03, $04 ; entry 0

KeyWorldChunkGroup4D::
    dfar KeyWorldScreenHeader_66_55DC ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5705 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_60A2 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_59BA ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40C4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_52A2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld16_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld23_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld15_1_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld12_0_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld30_2_Y1X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6546 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5705 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_66F6 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_406A ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup4DOrder::
    db $05, $02, $01, $04, $03, $00 ; entry 0

KeyWorldChunkGroup4E::
    dfar KeyWorldScreenHeader_66_5658 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5485 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55E2 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_64F3 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld12_0_Y3X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld47_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld42_3_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_64CA ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5284 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6784 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld3C_1_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld4E_2_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5477 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56B8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_531D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld3C_0_Y3X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld12_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld32_0_Y3X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_5B98 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_68C2 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4291 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_64F3 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6272 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_48DA ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld42_1_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld40_5_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld23_0_Y1X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld42_3_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld30_0_Y3X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup4EOrder::
    db $01, $02, $05, $00, $03, $04 ; entry 0

KeyWorldChunkGroup4F::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7139 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_76CB ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0C_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld0E_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6736 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_76CB ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0E_0_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_589C ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_406A ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_73F8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6F23 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld3E_1_Y3X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld18_0_Y3X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_4DE4 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7793 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1B_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup4FOrder::
    db $04, $03, $00, $05, $02, $01 ; entry 0

KeyWorldChunkGroup50::
    dfar KeyWorldScreenHeader_66_54FD ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_53C7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld39_1_Y1X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6CE1 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5BD1 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_1_Y0X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld29_1_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_64CA ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5E57 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_68C2 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5EAF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6272 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld41_2_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld40_5_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld3F_3_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld30_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5560 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5DED ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_694C ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_53B1 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld30_2_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld3F_3_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld12_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld31_1_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_59BA ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_53C7 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_59BA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_52A2 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4FAD ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5587 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_60D8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_52A2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld39_1_Y1X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld23_0_Y1X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld30_2_Y1X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld4C_5_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld40_4_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld50_4_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld30_2_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_5E91 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld50_5_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup50Order::
    db $01, $02, $05, $00, $03, $04 ; entry 0

KeyWorldChunkGroup51::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_68B7 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6FCF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0B_0_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_743F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_75B0 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6659 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_720E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld20_0_Y1X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld3A_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_774A ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_60A2 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld16_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_73F8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6F23 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld3E_1_Y3X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld18_0_Y3X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup51Order::
    db $00, $03, $04, $01, $02, $05 ; entry 0

KeyWorldChunkGroup52::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5C32 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld52_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_751D ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6FCF ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld0B_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5658 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5AD4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5437 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld30_3_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld3C_3_Y0X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_73F8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld3E_1_Y3X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_43CA ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup52Order::
    db $05, $02, $01, $04, $03, $00 ; entry 0

KeyWorldChunkGroup53::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5485 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5B93 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41F0 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6744 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6784 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld12_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld31_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld1E_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld40_5_Y1X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld4E_2_Y3X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_75A3 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_76ED ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4291 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y0X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld23_0_Y1X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6546 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_7848 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_60DA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5B98 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_54F8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld40_2_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld42_1_Y3X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld30_3_Y1X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_6807 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6B43 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_53C7 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5B93 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6636 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5284 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_54F8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y2X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld20_1_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld39_1_Y1X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld31_1_Y1X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld3C_2_Y0X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld3C_1_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld30_3_Y1X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_5B93 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_531D ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y1X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld32_0_Y3X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup53Order::
    db $04, $03, $00, $05, $02, $01 ; entry 0

; 9 sub-chunk(s) of a 4 x 4 grid of screens; Func_061_4472_Case00 skips the 8-byte header before
; each tile map (E-0146)
KeyWorldChunkGroup54::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_77A4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_70C1 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_53C7 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5B93 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_54F8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld1C_1_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld39_1_Y1X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld31_1_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld30_3_Y1X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_58E6 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6744 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_668A ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld40_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld40_5_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld3C_1_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_64CA ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_643F ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6BCD ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41F0 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5EAF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5218 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_460E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld08_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld1E_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld3F_3_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld34_1_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld1E_0_Y2X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_7626 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7945 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6F23 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld18_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_63_6047 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6145 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_453F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4734 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_66F6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4CD6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5BD1 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld3C_3_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld12_1_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld29_1_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_7945 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7545 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5337 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_431E ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0B_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld12_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 6: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_77EB ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y2X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_4F98 ; id 7: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5519 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5A34 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_60DA ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_60D8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6EFF ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld1E_0_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld3C_0_Y3X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld40_2_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld50_4_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_5E91 ; id 8: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld50_5_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup54Order::
    db $00, $02, $03, $01, $04, $07, $05, $06, $08 ; entry 0

KeyWorldChunkGroup55::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40C4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4D49 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5E57 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld15_1_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld4C_4_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld41_2_Y1X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_6546 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6808 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_594F ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5A34 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5B93 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6073 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5437 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_54F8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50F6 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld06_0_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld34_2_Y0X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld3C_0_Y3X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld31_1_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld41_2_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld3C_3_Y0X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld30_3_Y1X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld55_1_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_643F ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5EAF ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5218 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5587 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51A5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld3F_3_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld34_1_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld40_4_Y0X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld40_1_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_7848 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_57D0 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5437 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_697E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld55_3_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld3C_3_Y0X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld14_1_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_5218 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45E3 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld15_1_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_63_66AF ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5310 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_60DA ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5394 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6EDC ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5852 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_694C ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41F0 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6DE3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5B98 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6311 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6F70 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y3X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld12_1_Y0X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld40_2_Y2X2_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld12_1_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_1_Y0X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld42_1_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld3F_3_Y0X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld1E_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld00_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld42_1_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld40_5_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 6: screen 0: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 7: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_53C7 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55E2 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_47BD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_52A2 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld39_1_Y1X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld47_0_Y2X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld20_1_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld30_2_Y1X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_5B98 ; id 8: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_68C2 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_416D ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6744 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6272 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4843 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld42_1_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld40_5_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld3C_1_Y3X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld40_5_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld30_0_Y3X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld36_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup55Order::
    db $08, $07, $03, $06, $04, $02, $04, $01, $00 ; entry 0

KeyWorldChunkGroup56::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_528E ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40C4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7985 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5166 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_564B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51A5 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_454F ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_65BE ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5218 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld10_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld15_1_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y2X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld23_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld56_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld40_1_Y3X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld31_1_Y2X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld34_2_Y1X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld34_1_Y2X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_77A4 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6828 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_702C ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_64CA ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7626 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld10_1_Y2X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld1A_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_65EA ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7545 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0B_0_Y2X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_79CF ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6D0B ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_460E ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5705 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_74A4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4546 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_74B6 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld08_0_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld1E_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld04_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld0D_0_Y1X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld05_0_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld03_0_Y0X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_423A ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6E4E ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_72E0 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6546 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5BD1 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5FE5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5209 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4041 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld10_0_Y3X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld0B_0_Y1X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld00_0_Y0X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld29_1_Y2X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_1_Y0X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld40_1_Y2X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_75B0 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_73F8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld3E_1_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 6: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5F42 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_53C7 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_47BD ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_78B1 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y1X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld39_1_Y1X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld20_1_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld10_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld06_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_62_5337 ; id 7: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43BD ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5F99 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_668A ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6083 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4867 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46A7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_64F3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_472D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6A43 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6DB3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_460E ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_478E ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_505C ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7B56 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld00_0_Y1X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld12_1_Y1X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld3C_1_Y3X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld40_2_Y1X3_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld1E_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld12_1_Y2X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld42_3_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld30_3_Y1X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y2X2_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld1E_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld02_0_Y2X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_1_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld04_0_Y3X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_65_445B ; id 8: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5519 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41F0 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_694C ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5852 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5284 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_557A ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5437 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_468C ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_46C5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4D7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld32_1_Y2X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld1E_0_Y1X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld1E_0_Y1X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld3F_3_Y0X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld42_1_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld3C_1_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld23_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld3C_3_Y0X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld10_0_Y2X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X3_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup56Order::
    db $03, $02, $00, $07, $04, $01, $08, $06, $05 ; entry 0

KeyWorldChunkGroup57::
    dfar KeyWorldScreenHeader_66_5CC8 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_589C ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_68B7 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6C81 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7848 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6FC0 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld10_1_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld06_0_Y0X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld03_0_Y1X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld05_0_Y3X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld16_1_Y1X1_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6693 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5E8C ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6E8B ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld17_1_Y0X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X3_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_77CC ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_54FD ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6736 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_75B0 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4365 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5477 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld08_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld00_0_Y0X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y0X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld02_0_Y1X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y1X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld02_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_6F23 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5658 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_73F8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6C79 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D0D ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7626 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6D6B ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_65EA ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7641 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7517 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld18_0_Y3X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld0B_0_Y0X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld3E_1_Y3X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld13_0_Y2X1_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y1X3_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld02_0_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld08_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld04_0_Y0X2_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y0X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld10_0_Y1X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_64_6828 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4E6E ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_751D ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_774A ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6F90 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_423A ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41C9 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y2X3_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld07_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y2X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld1C_1_Y1X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld11_1_Y1X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_66_5CC8 ; id 6: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_78C0 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_68E4 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4F98 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5560 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_57D9 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5D1D ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7C14 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4917 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld04_0_Y1X0_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld10_0_Y3X2_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld03_0_Y2X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y1X0_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld17_1_Y2X1_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld24_1_Y2X0_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld07_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X2_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_63_6EFF ; id 7: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6AEC ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_706F ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7626 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5DD4 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7023 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_79CF ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42B3 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_70BD ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_55DC ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4859 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5115 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7A7D ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld11_1_Y2X2_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld17_0_Y3X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld1A_0_Y3X2_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld13_0_Y1X1_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld06_0_Y2X3_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld01_0_Y3X0_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld04_0_Y2X1_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld05_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld01_0_Y0X1_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld00_0_Y3X1_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X3_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld00_0_Y3X0_Attrs ; screen 15: compressed attribute map
    dfar KeyWorldScreenHeader_63_6DB3 ; id 8: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6E33 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_75A3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_76AE ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_406A ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40EE ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6D65 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5C71 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43CA ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6797 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4EF7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_45B4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4635 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4DE4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5CC8 ; screen 15: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Attrs ; screen 0: compressed attribute map
    dfar KeyWorld01_0_Y2X1_Attrs ; screen 1: compressed attribute map
    dfar KeyWorld05_0_Y2X1_Attrs ; screen 2: compressed attribute map
    dfar KeyWorld02_0_Y0X3_Attrs ; screen 3: compressed attribute map
    dfar KeyWorld00_0_Y1X0_Attrs ; screen 4: compressed attribute map
    dfar KeyWorld04_0_Y2X2_Attrs ; screen 5: compressed attribute map
    dfar KeyWorld04_0_Y1X2_Attrs ; screen 6: compressed attribute map
    dfar KeyWorld00_0_Y2X3_Attrs ; screen 7: compressed attribute map
    dfar KeyWorld05_0_Y2X2_Attrs ; screen 8: compressed attribute map
    dfar KeyWorld02_0_Y1X1_Attrs ; screen 9: compressed attribute map
    dfar KeyWorld0F_0_Y1X2_Attrs ; screen 10: compressed attribute map
    dfar KeyWorld08_0_Y3X3_Attrs ; screen 11: compressed attribute map
    dfar KeyWorld0A_0_Y1X2_Attrs ; screen 12: compressed attribute map
    dfar KeyWorld05_0_Y3X1_Attrs ; screen 13: compressed attribute map
    dfar KeyWorld01_0_Y3X2_Attrs ; screen 14: compressed attribute map
    dfar KeyWorld01_0_Y0X0_Attrs ; screen 15: compressed attribute map

KeyWorldChunkGroup57Order::
    db $05, $06, $08, $01, $04, $07, $00, $02, $03 ; entry 0

; compressed tileset of map $A2 (the first map record using it)
; LZSS-compressed: 1435 bytes that expand to 2048 (E-0016, E-0017)
MapA2Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1A2D79, $59B

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapA2Palettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $05a4, $53de, $0e29, $0084 ; entry 1
    dw $386c, $53de, $4593, $0000 ; entry 2
    dw $012f, $035f, $01da, $0000 ; entry 3
    dw $0160, $5ab1, $4a2d, $0000 ; entry 4
    dw $0152, $53de, $025c, $0008 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 12 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapA2Screens0::
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

MapA2Attrs0::
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

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1A339C, $F6

; LZSS-compressed: 248 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1A3492, $F8

MapA2Screens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $1A358A, $F8

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1A3682, $AA

; LZSS-compressed: 232 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $1A372C, $E8

; LZSS-compressed: 163 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $1A3814, $A3

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $1A38B7, $C0

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $1A3977, $E3

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $1A3A5A, $C2

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y3X0::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $1A3B30, $55

MapA2Screens0_Y3X2::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
MapA2Attrs0_Y0X0::
    db $68, $01, $00, $04, $04, $02, $00, $02, $0d, $04, $00, $00, $0f, $00, $04, $00
    db $14, $0f, $00, $00, $28, $0f, $2b, $01, $01, $02, $02, $01, $01, $00, $7a, $08
    db $00, $78, $0f, $05, $00, $a2, $0c, $00, $a0, $0f, $2b, $00, $a0, $08, $00, $28
    db $00, $00, $fe, $02, $00, $f4, $0f, $09, $00, $fe, $06, $00, $1a, $1f, $27

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
MapA2Attrs0_Y0X1::
    db $68, $01, $00, $02, $00, $00, $0f, $3e, $01, $00, $4e, $01, $00, $57, $01, $00
    db $4e, $07, $00, $55, $04, $00, $66, $02, $00, $64, $02, $00, $68, $08, $00, $55
    db $02, $00, $7a, $0f, $01, $00, $66, $0c, $00, $9e, $0f, $07, $00, $c4, $0f, $11
    db $04, $04, $00, $e0, $0e, $00, $f0, $0f, $03, $00, $16, $1f, $3b

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
MapA2Attrs0_Y0X2::
    db $68, $01, $00, $02, $00, $00, $0d, $04, $04, $00, $01, $0f, $00, $00, $13, $0d
    db $04, $00, $25, $0f, $2c, $01, $01, $02, $02, $01, $01, $00, $78, $08, $00, $76
    db $0f, $05, $00, $a0, $0c, $00, $9e, $0f, $2b, $00, $ee, $02, $00, $e4, $0e, $00
    db $f4, $0f, $03, $00, $9e, $06, $00, $14, $1f, $2d

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
MapA2Attrs0_Y1X0::
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $03, $00, $00, $00, $00, $0c
    db $04, $00, $04, $0e, $00, $04, $04, $00, $1e, $0f, $3f, $00, $04, $06, $00, $7a
    db $0f, $33, $00, $20, $0f, $33, $00, $02, $0f, $15, $00, $02, $0f, $13

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
MapA2Attrs0_Y1X1::
    db $68, $01, $00, $04, $00, $00, $0f, $18, $01, $00, $2c, $07, $00, $24, $0f, $07
    db $00, $2c, $08, $00, $34, $04, $00, $52, $0e, $00, $52, $0c, $00, $78, $0f, $2d
    db $00, $50, $0f, $15, $00, $28, $0f, $17, $00, $28, $08, $00, $20, $0f, $01, $00
    db $26, $1f, $1b

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
MapA2Attrs0_Y1X2::
    db $68, $01, $00, $04, $00, $00, $03, $01, $00, $08, $03, $00, $00, $04, $00, $04
    db $0f, $0d, $00, $0e, $08, $00, $30, $0f, $21, $00, $30, $06, $00, $6e, $0f, $33
    db $00, $28, $0f, $3d, $00, $00, $0f, $25, $00, $10, $0f, $05

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
MapA2Attrs0_Y2X0::
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $03, $00, $00, $00, $00, $0c
    db $04, $00, $04, $0f, $09, $00, $0a, $08, $00, $2c, $0f, $0b, $00, $06, $06, $00
    db $54, $0f, $29, $00, $52, $0c, $00, $a0, $0f, $07, $00, $52, $0a, $00, $c8, $0f
    db $09, $00, $f7, $0f, $4d, $00, $08, $1c

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
MapA2Attrs0_Y2X1::
    db $68, $01, $00, $04, $00, $00, $01, $01, $00, $06, $03, $00, $00, $02, $00, $00
    db $0f, $05, $00, $06, $04, $00, $0a, $08, $00, $2c, $0c, $00, $2c, $08, $00, $5b
    db $0f, $4d, $00, $90, $0f, $21, $00, $4e, $0e, $00, $4c, $0f, $01, $00, $26, $0f
    db $17, $00, $28, $0f, $15

MapA2Attrs0_Y2X2::
    db $68, $01, $00, $04, $00, $00, $03, $01, $00, $08, $03, $00, $00, $04, $00, $04
    db $0f, $03, $00, $08, $04, $00, $22, $0f, $07, $00, $2e, $06, $00, $46, $0f, $41
    db $00, $28, $0c, $00, $aa, $0f, $03, $00, $26, $0e, $00, $0e, $0a, $00, $f3, $0f
    db $4d, $00, $08, $1f, $01

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
MapA2Attrs0_Y3X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 26 bytes that expand to 360 (E-0016, E-0017)
MapA2Attrs0_Y3X1::
    db $68, $01, $02, $02, $ff, $f0, $01, $02, $04, $07, $02, $fc, $ff, $4d, $02, $5c
    db $0f, $4d, $02, $bc, $0f, $4d, $02, $08, $1f, $25

MapA2Attrs0_Y3X2::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapX62F0Palettes::
    dw $396b, $7fff, $5a94, $0000 ; entry 0
    dw $012f, $035f, $01da, $0000 ; entry 1
    dw $48ec, $6bff, $4a6f, $0000 ; entry 2
    dw $1154, $53de, $229a, $0084 ; entry 3
    dw $218c, $4f18, $3a52, $0000 ; entry 4
    dw $218c, $4f18, $3a52, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapX62F0Screens0::
    dfar MapX62F0Screens0_Y0X0 ; entry 0

MapX62F0Attrs0::
    dfar MapX62F0Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
MapX62F0Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1A3E04, $BA

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
MapX62F0Attrs0_Y0X0::
    db $68, $01, $04, $04, $ff, $f0, $02, $04, $04, $07, $04, $fc, $ff, $07, $04, $04
    db $04, $01, $01, $04, $0a, $06, $04, $2a, $0f, $05, $03, $04, $56, $03, $04, $4a
    db $0f, $0b, $04, $56, $04, $04, $5a, $02, $04, $76, $0f, $4d, $04, $ae, $0f, $1f
    db $04, $54, $0f, $13, $04, $50, $06, $04, $0c, $0c, $04, $48, $18
    ds $105, $00
