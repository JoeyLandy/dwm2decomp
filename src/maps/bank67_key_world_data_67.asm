; ROM bank $67: key-world data
; The annotated listing of this bank is build/listing/bank67.asm.

SECTION "Bank 67", ROMX[$4000], BANK[$67]
    db $67

; 1 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_WriteSVBK_2 skips the 8-byte header
; before each tile map (E-0146)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the
; AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup00::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_15 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

; a permutation of the sub-chunk numbers (E-0146)
; record: sub-chunk order
KeyWorldChunkGroup00Order::
    db $00 ; entry 0

KeyWorldChunkGroup01::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_21 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup01Order::
    db $00 ; entry 0

KeyWorldChunkGroup02::
    dfar KeyWorldScreenHeader_66_18 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_33 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup02Order::
    db $00 ; entry 0

KeyWorldChunkGroup03::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup03Order::
    db $00 ; entry 0

KeyWorldChunkGroup04::
    dfar KeyWorldScreenHeader_66_23 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup04Order::
    db $00 ; entry 0

KeyWorldChunkGroup05::
    dfar KeyWorldScreenHeader_66_23 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup05Order::
    db $00 ; entry 0

KeyWorldChunkGroup06::
    dfar KeyWorldScreenHeader_66_21 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_37 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_38 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_57 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup06Order::
    db $00 ; entry 0

KeyWorldChunkGroup07::
    dfar KeyWorldScreenHeader_66_26 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_31 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_37 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_48 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup07Order::
    db $00 ; entry 0

KeyWorldChunkGroup08::
    dfar KeyWorldScreenHeader_66_20 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_31 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_57 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup08Order::
    db $00 ; entry 0

KeyWorldChunkGroup09::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup09Order::
    db $00 ; entry 0

KeyWorldChunkGroup0A::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_35 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup0AOrder::
    db $00 ; entry 0

KeyWorldChunkGroup0B::
    dfar KeyWorldScreenHeader_66_22 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_42 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_41 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup0BOrder::
    db $00 ; entry 0

KeyWorldChunkGroup0C::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_44 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup0COrder::
    db $00 ; entry 0

KeyWorldChunkGroup0D::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_23 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_40 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup0DOrder::
    db $00 ; entry 0

KeyWorldChunkGroup0E::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_26 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_21 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_43 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_42 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_57 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup0EOrder::
    db $00 ; entry 0

KeyWorldChunkGroup0F::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_11 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_33 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_17 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup0FOrder::
    db $00 ; entry 0

; 2 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_WriteSVBK_2 skips the 8-byte header
; before each tile map (E-0146)
KeyWorldChunkGroup10::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_37 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_18 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_25 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_35 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup10Order::
    db $00, $01 ; entry 0

KeyWorldChunkGroup11::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_41 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_23 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_46 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup11Order::
    db $01, $00 ; entry 0

KeyWorldChunkGroup12::
    dfar KeyWorldScreenHeader_66_21 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_19 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_21 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_49 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_22 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_13 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_19 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_14 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup12Order::
    db $00, $01 ; entry 0

KeyWorldChunkGroup13::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_31 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_18 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup13Order::
    db $01, $00 ; entry 0

KeyWorldChunkGroup14::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_35 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_46 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_35 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup14Order::
    db $00, $01 ; entry 0

KeyWorldChunkGroup15::
    dfar KeyWorldScreenHeader_66_23 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_41 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_20 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_15 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_2 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup15Order::
    db $01, $00 ; entry 0

KeyWorldChunkGroup16::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_23 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_30 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_23 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_46 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_8 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_36 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_57 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup16Order::
    db $00, $01 ; entry 0

KeyWorldChunkGroup17::
    dfar KeyWorldScreenHeader_66_21 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_40 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_35 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_43 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_57 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_20 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_27 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_31 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_24 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_48 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup17Order::
    db $01, $00 ; entry 0

KeyWorldChunkGroup18::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_41 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_18 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup18Order::
    db $00, $01 ; entry 0

KeyWorldChunkGroup19::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_40 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_44 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_43 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_57 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_36 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_43 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_48 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_38 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup19Order::
    db $01, $00 ; entry 0

KeyWorldChunkGroup1A::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_23 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_46 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_42 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup1AOrder::
    db $00, $01 ; entry 0

KeyWorldChunkGroup1B::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_26 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_24 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_30 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_31 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_64_50 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_44 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup1BOrder::
    db $01, $00 ; entry 0

KeyWorldChunkGroup1C::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_49 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_11 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_39 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_9 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup1COrder::
    db $00, $01 ; entry 0

KeyWorldChunkGroup1D::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_26 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_43 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_48 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_43 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup1DOrder::
    db $01, $00 ; entry 0

KeyWorldChunkGroup1E::
    dfar KeyWorldScreenHeader_66_21 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_22 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_52 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_2 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_12 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_47 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup1EOrder::
    db $00, $01 ; entry 0

KeyWorldChunkGroup1F::
    dfar KeyWorldScreenHeader_66_24 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_26 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_13 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_48 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_18 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_9 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_57 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup1FOrder::
    db $01, $00 ; entry 0

KeyWorldChunkGroup20::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_32 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_34 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_31 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_37 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_29 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_22 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_2 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup20Order::
    db $00, $01 ; entry 0

KeyWorldChunkGroup21::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_43 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_24 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_32 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup21Order::
    db $01, $00 ; entry 0

KeyWorldChunkGroup22::
    dfar KeyWorldScreenHeader_66_18 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_29 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_55 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_43 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup22Order::
    db $00, $01 ; entry 0

KeyWorldChunkGroup23::
    dfar KeyWorldScreenHeader_66_25 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_37 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_16 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_20 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_15 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_2 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_51 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_36 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup23Order::
    db $01, $00 ; entry 0

KeyWorldChunkGroup24::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_38 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_36 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_31 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup24Order::
    db $00, $01 ; entry 0

KeyWorldChunkGroup25::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_43 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_34 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_39 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_33 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_35 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup25Order::
    db $01, $00 ; entry 0

KeyWorldChunkGroup26::
    dfar KeyWorldScreenHeader_66_22 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_31 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_40 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_31 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_19 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_26 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_57 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_48 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_48 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_57 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_17 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup26Order::
    db $00, $01 ; entry 0

KeyWorldChunkGroup27::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_24 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_39 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_25 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_46 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_57 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_55 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_23 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_39 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_8 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_48 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_8 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup27Order::
    db $01, $00 ; entry 0

KeyWorldChunkGroup28::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_31 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_14 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_22 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_44 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_43 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_43 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_43 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup28Order::
    db $00, $01 ; entry 0

KeyWorldChunkGroup29::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld29_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_50 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_57 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_43 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_44 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_23 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup29Order::
    db $01, $00 ; entry 0

KeyWorldChunkGroup2A::
    dfar KeyWorldScreenHeader_66_23 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_10 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_8 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_31 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_38 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup2AOrder::
    db $00, $01 ; entry 0

KeyWorldChunkGroup2B::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_26 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_41 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_35 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_36 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_21 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_37 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup2BOrder::
    db $01, $00 ; entry 0

KeyWorldChunkGroup2C::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_42 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_40 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_8 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_19 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_39 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_43 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_41 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_47 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup2COrder::
    db $00, $01 ; entry 0

KeyWorldChunkGroup2D::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_21 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_57 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_20 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup2DOrder::
    db $01, $00 ; entry 0

KeyWorldChunkGroup2E::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_26 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_31 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_11 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_44 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup2EOrder::
    db $00, $01 ; entry 0

KeyWorldChunkGroup2F::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_27 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_37 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_57 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_9 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_36 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_35 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_37 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup2FOrder::
    db $01, $00 ; entry 0

; 4 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_WriteSVBK_2 skips the 8-byte header
; before each tile map (E-0146)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the
; AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup30::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_19 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_15 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_19 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_22 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_30 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_35 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_15 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_35 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_8 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_48 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_16 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_29 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_31 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_10 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_35 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_64_22 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_14 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_33 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_35 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

; a permutation of the sub-chunk numbers (E-0146)
; record: sub-chunk order
KeyWorldChunkGroup30Order::
    db $00, $01, $02, $03 ; entry 0

KeyWorldChunkGroup31::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_36 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_38 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_31 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_16 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_23 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_12 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_25 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_37 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_19 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_40 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_29 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup31Order::
    db $03, $01, $02, $00 ; entry 0

KeyWorldChunkGroup32::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_24 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_38 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_23 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_19 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_22 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_19 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_24 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_11 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_22 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_8 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_35 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_44 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_32 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_63_33 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_29 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_32 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup32Order::
    db $01, $02, $00, $03 ; entry 0

KeyWorldChunkGroup33::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_36 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_32 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_49 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_35 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_29 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_26 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup33Order::
    db $03, $00, $02, $01 ; entry 0

KeyWorldChunkGroup34::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_25 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_31 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_21 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_20 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_11 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_22 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_9 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_16 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_19 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_23 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_24 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_8 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_2 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_2 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_11 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_4 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup34Order::
    db $00, $01, $03, $02 ; entry 0

KeyWorldChunkGroup35::
    dfar KeyWorldScreenHeader_66_23 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_37 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_22 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_18 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_44 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_3 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_35 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup35Order::
    db $02, $03, $01, $00 ; entry 0

KeyWorldChunkGroup36::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_37 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_21 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_33 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_42 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_47 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_39 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_14 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup36Order::
    db $02, $03, $00, $01 ; entry 0

KeyWorldChunkGroup37::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_25 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_24 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_36 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_47 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_18 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_2 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_7 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_38 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup37Order::
    db $01, $00, $02, $03 ; entry 0

KeyWorldChunkGroup38::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_21 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_34 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_51 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_29 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_5 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_35 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup38Order::
    db $00, $02, $01, $03 ; entry 0

KeyWorldChunkGroup39::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_23 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_27 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_25 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_35 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_38 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_20 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_19 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_9 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_29 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_51 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_41 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_35 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_46 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup39Order::
    db $03, $01, $02, $00 ; entry 0

KeyWorldChunkGroup3A::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_45 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_9 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_20 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_40 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_25 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_27 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_30 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 14: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_56 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_39 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup3AOrder::
    db $02, $00, $03, $01 ; entry 0

KeyWorldChunkGroup3B::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_24 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_47 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_23 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_25 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_15 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_16 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_9 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_47 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_36 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_50 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_20 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_14 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_35 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup3BOrder::
    db $02, $03, $00, $01 ; entry 0

KeyWorldChunkGroup3C::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_21 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_27 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_18 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_19 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_19 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_21 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_18 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_34 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_4 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_12 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_30 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_19 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_50 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_14 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_25 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_35 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_19 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_64_28 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_13 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_13 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_35 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup3COrder::
    db $00, $03, $01, $02 ; entry 0

KeyWorldChunkGroup3D::
    dfar KeyWorldScreenHeader_66_20 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_27 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_35 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_34 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_31 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_49 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_54 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_45 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_45 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_25 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_23 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup3DOrder::
    db $02, $01, $03, $00 ; entry 0

KeyWorldChunkGroup3E::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_31 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_23 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_27 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_44 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_41 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_39 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_64_51 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_16 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_41 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_45 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup3EOrder::
    db $03, $02, $00, $01 ; entry 0

KeyWorldChunkGroup3F::
    dfar KeyWorldScreenHeader_66_19 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_25 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_43 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_44 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_24 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_23 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_56 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_34 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_20 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_2 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_24 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_25 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_27 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_63_18 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_34 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_8 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_2 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_16 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_31 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_7 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup3FOrder::
    db $01, $00, $02, $03 ; entry 0

; 6 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_WriteSVBK_2 skips the 8-byte header
; before each tile map (E-0146)
KeyWorldChunkGroup40::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_18 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_18 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_17 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_3 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_11 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_24 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_20 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_3 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_17 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_11 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_18 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_47 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_20 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_55 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_35 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_20 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_27 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_21 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_32 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_24 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_26 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_64_13 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_3 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_5 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_39 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_11 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_45 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_17 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_15 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_18 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_25 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_2 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_33 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_24 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_27 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_31 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_8 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_5 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_5 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup40Order::
    db $00, $01, $02, $03, $04, $05 ; entry 0

KeyWorldChunkGroup41::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_38 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_41 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_38 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_7 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_51 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_35 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_44 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_16 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_19 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_2 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_17 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_26 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_47 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_11 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_6 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_22 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_15 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_47 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_25 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_56 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_27 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_38 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_6 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_46 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_36 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_21 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_34 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_38 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_39 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_37 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_35 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup41Order::
    db $04, $05, $03, $02, $01, $00 ; entry 0

KeyWorldChunkGroup42::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_19 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_23 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_25 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_16 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_50 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_4 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_17 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_38 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_37 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_53 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_22 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_21 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_15 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_22 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_33 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_2 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_44 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_3 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_49 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_30 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_18 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_49 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_63_23 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_31 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_40 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_2 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_7 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_33 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_32 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_37 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_12 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_50 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_39 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_33 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_15 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_65_27 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_44 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_36 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup42Order::
    db $04, $05, $03, $02, $00, $01 ; entry 0

KeyWorldChunkGroup43::
    dfar KeyWorldScreenHeader_66_28 ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_21 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_35 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_52 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_45 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_20 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_52 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_40 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_46 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_38 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_27 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_20 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_25 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_50 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_24 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_30 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_29 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_39 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_43 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_55 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_7 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_42 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_42 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_62_47 ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_7 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_22 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_49 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_34 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_50 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_14 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_48 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_22 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_26 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_64_15 ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_2 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_5 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_43 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_34 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_4 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_13 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_36 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_36 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_54 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66_28 ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_6 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_32 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_51 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_3 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_51 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_33 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_37 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_64_53 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_3 ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorldScreenHeader_66 ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_31 ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_42 ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_62_45 ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_41 ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_65_32 ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_63_39 ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_10 ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_2 ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_11 ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorldScreenHeader_66_28 ; screen 15: 8-byte header, then the compressed tile map
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

KeyWorldChunkGroup43Order::
    db $01, $00, $02, $03, $05, $04 ; entry 0
    ds $57, $00
