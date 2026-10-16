; ROM bank $67: key-world data
; The annotated listing of this bank is build/listing/bank67.asm.

SECTION "Bank 67", ROMX
    db $67

; 1 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_Type0 skips the 8-byte header before each
; tile map (E-0146)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the
; AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup00::
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X1_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld07_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld0B_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0C_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0D_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0E_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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

; 2 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_Type0 skips the 8-byte header before each
; tile map (E-0146)
KeyWorldChunkGroup10::
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld10_1_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y2X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X1_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y2X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y2X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld16_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld16_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y2X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X1_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld18_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0D_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0C_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0E_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld19_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld19_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1A_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld1A_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld16_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld05_0_Y3X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1B_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y2X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y2X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0E_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X1_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld17_1_Y2X1_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld1F_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y2X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld1F_1_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld20_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0E_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld17_1_Y2X1_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld20_0_Y1X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y1X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld11_1_Y0X3_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld22_1_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0E_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld10_1_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld07_0_Y0X3_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld0B_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld22_1_Y1X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1A_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld11_1_Y0X3_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld22_1_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld27_1_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld28_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld0B_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld1B_1_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld28_1_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0E_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld29_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld03_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0C_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld29_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld2A_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld19_1_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld0C_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld0D_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld27_1_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld0E_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld18_0_Y3X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_1_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld1B_1_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld06_0_Y0X1_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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

; 4 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_Type0 skips the 8-byte header before each
; tile map (E-0146)
; record: 16 far pointers to screen tile maps (each behind an 8-byte header whose bytes 6-7 pick the
; AutomapBlocks entry), then 16 to their attribute maps
KeyWorldChunkGroup30::
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld30_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y0X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld30_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X1_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld30_1_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld30_1_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y2X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld30_2_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld30_2_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld30_2_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld30_3_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld06_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld10_1_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld0D_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y1X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld29_1_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld32_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld32_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld0B_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld32_1_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld10_0_Y1X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld20_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld27_0_Y1X3_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y1X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld20_0_Y1X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld20_0_Y1X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X3_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld22_1_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y1X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld13_0_Y1X1_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
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
    dfar KeyWorld0B_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld10_1_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y0X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld32_1_Y2X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld1B_1_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld11_1_Y1X1_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X1_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y1X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld03_0_Y2X2_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y1X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y1X1_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld22_1_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y2X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y1X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y2X1_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X1_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y0X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y1X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y2X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y1X3_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld3A_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld22_1_Y1X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0D_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld16_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
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
    dfar KeyWorld1D_1_Y2X3_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld30_2_Y0X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y1X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld22_1_Y1X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y1X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y0X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y1X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_2_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld3C_3_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_3_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y0X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y2X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld3A_0_Y1X3_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld3A_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld29_1_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld0C_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld3E_1_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld10_0_Y3X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y1X3_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld1B_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld29_1_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y3X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y1X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld3F_3_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld32_1_Y2X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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

; 6 sub-chunk(s) of a 4 x 4 grid of screens; LoadMapScreen_Type0 skips the 8-byte header before each
; tile map (E-0146)
KeyWorldChunkGroup40::
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld40_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld40_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld32_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y1X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y1X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld3C_1_Y3X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y2X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y1X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y1X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld20_1_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld40_2_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld12_1_Y0X2_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld34_1_Y2X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld02_0_Y1X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld40_1_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld40_4_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld3F_3_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld40_4_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld40_5_Y0X0_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y1X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld30_1_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y3X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld06_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld07_0_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X1_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld10_0_Y1X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld34_2_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y1X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld12_0_Y3X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y0X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld30_1_Y2X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld05_0_Y1X1_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld1D_1_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y2X3_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld36_0_Y2X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld16_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld19_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld1C_1_Y1X2_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld24_1_Y2X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld23_0_Y1X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld41_2_Y1X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld06_0_Y0X2_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld06_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld42_1_Y2X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld30_1_Y2X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld42_1_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld15_1_Y1X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y2X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X3_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld42_3_Y0X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld40_5_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y1X2_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld1E_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld14_1_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld04_0_Y1X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld1C_1_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y3X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld17_1_Y0X1_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X3_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X2_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 0: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X1_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y3X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y2X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y1X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y0X3_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y2X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y0X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld39_1_Y1X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 1: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y0X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld17_1_Y2X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld16_0_Y2X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld10_1_Y0X1_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld17_0_Y3X1_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y0X3_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld22_1_Y1X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld1A_0_Y3X2_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld00_0_Y1X0_Header ; id 2: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld12_1_Y0X1_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld31_1_Y2X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld03_0_Y2X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X0_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld0B_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y1X1_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld30_1_Y2X0_Header ; id 3: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X2_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld30_3_Y1X1_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y1X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld0F_0_Y1X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y3X2_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld08_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y0X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y0X3_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld01_0_Y0X0_Header ; id 4: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X2_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld20_0_Y1X3_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y2X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld11_1_Y1X1_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld10_0_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld27_0_Y1X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y2X1_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld05_0_Y3X1_Header ; screen 15: 8-byte header, then the compressed tile map
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
    dfar KeyWorld05_0_Y3X2_Header ; id 5: screen 0: 8-byte header, then the compressed tile map
    dfar KeyWorld13_0_Y2X1_Header ; screen 1: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y2X3_Header ; screen 2: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 3: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 4: 8-byte header, then the compressed tile map
    dfar KeyWorld02_0_Y1X0_Header ; screen 5: 8-byte header, then the compressed tile map
    dfar KeyWorld04_0_Y1X3_Header ; screen 6: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 7: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X2_Header ; screen 8: 8-byte header, then the compressed tile map
    dfar KeyWorld3E_1_Y3X0_Header ; screen 9: 8-byte header, then the compressed tile map
    dfar KeyWorld00_0_Y3X3_Header ; screen 10: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 11: 8-byte header, then the compressed tile map
    dfar KeyWorld0A_0_Y1X2_Header ; screen 12: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y3X2_Header ; screen 13: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 14: 8-byte header, then the compressed tile map
    dfar KeyWorld01_0_Y0X0_Header ; screen 15: 8-byte header, then the compressed tile map
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
