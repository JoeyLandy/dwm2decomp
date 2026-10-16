; ROM bank $68: key-world map screens
; The annotated listing of this bank is build/listing/bank68.asm.

SECTION "Bank 68", ROMX
    db $68

; 6 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_Type0 skips the 8-byte header before each
; tile map (E-0146)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the
; AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup44::
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld0B_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_0_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_2_Y0X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld40_2_Y2X2_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld30_1_Y2X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y1X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y2X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld44_3_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_0_Y3X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld30_0_Y2X3_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_1_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld07_0_Y0X3_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld3A_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X1_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y1X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y0X3_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0D_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld05_0_Y3X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_1_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld16_0_Y2X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld05_0_Y3X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X2_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y1X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld16_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld47_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld30_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X1_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld32_0_Y3X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld10_0_Y1X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld47_2_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld30_1_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld11_1_Y1X1_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y2X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld47_4_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld30_0_Y3X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld1C_1_Y0X1_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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

; 3 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_Type0 skips the 8-byte header before each
; tile map (E-0146)
KeyWorldChunkGroup48::
    dfar KeyWorld01_0_Y0X1_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld1A_0_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X2_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld1A_0_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X1_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld3A_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld17_1_Y2X1_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X2_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld32_1_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld30_1_Y3X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld32_0_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld1D_1_Y2X3_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X1_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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

; 6 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_Type0 skips the 8-byte header before each
; tile map (E-0146)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the
; AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup4C::
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld40_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld42_3_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld30_2_Y0X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X2_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y0X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y3X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_0_Y3X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld4C_4_Y0X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y1X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld4C_4_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld40_4_Y0X3_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld4C_5_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X1_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld16_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld30_2_Y1X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X1_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y2X1_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y2X2_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld0B_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld47_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld42_3_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X2_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld4E_2_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_0_Y3X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld32_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld42_1_Y3X0_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld42_3_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld30_0_Y3X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0C_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld0E_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0E_0_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld10_1_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y2X2_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld3E_1_Y3X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld18_0_Y3X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y3X2_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1B_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y1X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld29_1_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X2_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld30_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld30_2_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld23_0_Y1X2_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y1X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld30_2_Y1X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld4C_5_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld40_4_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld50_4_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld30_2_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld50_5_Y0X0_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld06_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y1X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld20_0_Y1X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld3A_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y2X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld16_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld3E_1_Y3X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld18_0_Y3X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld52_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld07_0_Y0X3_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld0B_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld3E_1_Y3X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y1X1_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y1X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld4E_2_Y3X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y0X3_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X1_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld05_0_Y3X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld42_1_Y3X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld40_2_Y2X3_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y1X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y1X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_2_Y0X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld31_1_Y1X1_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld32_0_Y3X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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

; 9 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_Type0 skips the 8-byte header before each
; tile map (E-0146)
KeyWorldChunkGroup54::
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y1X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld40_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X2_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y2X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld18_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld34_1_Y2X1_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld29_1_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y3X0_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 6: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld03_0_Y2X2_Header ; id 7: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_0_Y3X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld50_4_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld50_5_Y0X0_Header ; id 8: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld4C_4_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X1_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y0X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_0_Y3X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld55_1_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld07_0_Y0X1_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld40_4_Y0X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld05_0_Y3X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld55_3_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld34_1_Y2X2_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld40_2_Y3X3_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld42_1_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld42_1_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 6: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 7: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y1X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld47_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld30_2_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld42_1_Y3X0_Header ; id 8: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld30_0_Y3X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld56_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y3X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y1X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld11_1_Y0X3_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld1A_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X2_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y3X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0D_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X2_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld29_1_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y1X0_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld3E_1_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 6: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y1X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
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
    dfar KeyWorld12_0_Y1X1_Header ; id 7: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y1X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld42_3_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld32_1_Y2X0_Header ; id 8: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld42_1_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld18_0_Y3X1_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld3E_1_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld0A_0_Y1X1_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 6: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld14_1_Y1X1_Header ; id 7: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld1A_0_Y3X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld27_0_Y1X3_Header ; id 8: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    INCBIN "maps/mapa2/tileset.lz"

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
    INCBIN "maps/mapa2/screens0_y0_x0.lz"

; LZSS-compressed: 248 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y0X1::
    INCBIN "maps/mapa2/screens0_y0_x1.lz"

MapA2Screens0_Y0X2::
    INCBIN "maps/mapa2/screens0_y0_x2.lz"

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y1X0::
    INCBIN "maps/mapa2/screens0_y1_x0.lz"

; LZSS-compressed: 232 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y1X1::
    INCBIN "maps/mapa2/screens0_y1_x1.lz"

; LZSS-compressed: 163 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y1X2::
    INCBIN "maps/mapa2/screens0_y1_x2.lz"

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y2X0::
    INCBIN "maps/mapa2/screens0_y2_x0.lz"

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y2X1::
    INCBIN "maps/mapa2/screens0_y2_x1.lz"

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y2X2::
    INCBIN "maps/mapa2/screens0_y2_x2.lz"

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y3X0::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
MapA2Screens0_Y3X1::
    INCBIN "maps/mapa2/screens0_y3_x1.lz"

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
    dfar UnusedStoneHallScreenMap ; entry 0

MapX62F0Attrs0::
    dfar MapX62F0Attrs0_Y0X0 ; entry 0

; Tile map: 360 bytes = one 20 x 18 screen of tile numbers, the only screen (1 x 1) of
; MapRecordX62F0, a map record that no MapTable entry points to (bank11_maps.asm). Drawn with
; SandDoorRoomTileset (bank $90) in vTiles2: a hall framed by square stone blocks with a small
; barred gate or chest at the top middle, a herringbone paved floor in the middle and speckled sand
; strips on both sides with small tree-like marks. Since the record is not in MapTable and no other
; load of $7E04 exists, nothing in the game shows it. (C1, E-0383)
; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
UnusedStoneHallScreenMap::
    INCBIN "gfx/misc/unused_stone_hall_screen_map.lz"

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
MapX62F0Attrs0_Y0X0::
    db $68, $01, $04, $04, $ff, $f0, $02, $04, $04, $07, $04, $fc, $ff, $07, $04, $04
    db $04, $01, $01, $04, $0a, $06, $04, $2a, $0f, $05, $03, $04, $56, $03, $04, $4a
    db $0f, $0b, $04, $56, $04, $04, $5a, $02, $04, $76, $0f, $4d, $04, $ae, $0f, $1f
    db $04, $54, $0f, $13, $04, $50, $06, $04, $0c, $0c, $04, $48, $18
    ds $105, $00
