; ROM bank $70: key-world map screens
; The annotated listing of this bank is build/listing/bank70.asm.

SECTION "Bank 70", ROMX[$4000], BANK[$70]
    db $70

; compressed BG tiles (2048 bytes, 128 tiles): entry 8 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 716 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles8::
    INCBIN "dwm2-cobi-us.gbc", $1C0001, $191

; LZSS-compressed: 1418 bytes that expand to 1478 (E-0016, E-0017)
Gfx_70_4192::
    INCBIN "dwm2-cobi-us.gbc", $1C0192, $13B

; entry 8 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes8::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $150b, $5f17, $15ae, $0044 ; entry 1
    dw $3dea, $5f17, $4eae, $0000 ; entry 2
    dw $150b, $5f17, $15ae, $0000 ; entry 3
    dw $5d8c, $5f17, $5ab1, $0000 ; entry 4
    dw $218c, $5f17, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y3X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C030D, $77

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y3X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C0384, $A6

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C042A, $D6

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C0500, $D5

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C05D5, $A0

; LZSS-compressed: 167 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y3X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C0675, $A7

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C071C, $DA

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y3X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C07F6, $EB

; LZSS-compressed: 138 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_48E1::
    INCBIN "dwm2-cobi-us.gbc", $1C08E1, $8A

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_496B::
    INCBIN "dwm2-cobi-us.gbc", $1C096B, $CC

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_4A37::
    INCBIN "dwm2-cobi-us.gbc", $1C0A37, $E0

; LZSS-compressed: 245 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_4B17::
    INCBIN "dwm2-cobi-us.gbc", $1C0B17, $F5

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_4C0C::
    INCBIN "dwm2-cobi-us.gbc", $1C0C0C, $92

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1B_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C0C9E, $C8

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom14_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C0D66, $F6

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom68_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C0E5C, $D0

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y3X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $24, $0c, $00, $80, $04, $00, $78, $0f, $0d, $00, $18, $0c, $00
    db $a8, $0f, $29, $00, $f7, $0f, $4d, $00, $20, $0c

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y3X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $2b, $00, $08, $00, $00, $52, $08, $00, $4e, $0f, $09, $03, $00, $7e, $03
    db $00, $5c, $04, $00, $7a, $0f, $07, $00, $a2, $06, $00, $9e, $0f, $0b, $00, $80
    db $0f, $13, $00, $56, $0f, $15, $00, $56, $0f, $11, $00, $3e, $1f, $13

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y2X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C0F94, $47

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C0FDB, $4A

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $03, $00, $08, $00, $00, $2a, $08, $00, $26, $0f, $05, $03, $03, $01, $01
    db $00, $52, $08, $00, $4e, $0f, $05, $00, $28, $0f, $17, $00, $50, $0a, $00, $9e
    db $0f, $09, $00, $28, $0a, $00, $c8, $0f, $09, $00, $f7, $0f, $4d, $00, $0c, $0c

KeyWorldRoom02_Y3X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $10, $0a, $03, $00, $82, $03, $00, $1e, $06, $00, $80, $0f, $01
    db $00, $1a, $02, $00, $88, $00, $00, $9e, $0f, $3b, $00, $22, $0e, $00, $fe, $0a
    db $00, $1c, $00, $00, $1e, $0c, $00, $20, $1f, $01, $00, $3a, $1f, $0d

KeyWorldRoom03_Y2X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C10A3, $4A

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y3X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C10ED, $55

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_5142::
    INCBIN "dwm2-cobi-us.gbc", $1C1142, $44

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_5186::
    INCBIN "dwm2-cobi-us.gbc", $1C1186, $6B

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_51F1::
    INCBIN "dwm2-cobi-us.gbc", $1C11F1, $62

; LZSS-compressed: 105 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_5253::
    INCBIN "dwm2-cobi-us.gbc", $1C1253, $69

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_52BC::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $31, $00, $06, $00, $00, $48, $0f, $15, $05, $05, $05, $05, $00, $08, $0a
    db $00, $82, $0f, $05, $00, $08, $00, $00, $9e, $0f, $0d, $05, $05, $03, $03, $00
    db $c2, $0f, $11, $00, $f9, $0f, $4d, $00, $0c, $0a

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1B_Y2X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C12F6, $4E

KeyWorldRoom14_Y1X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C1344, $4E

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom68_Y3X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C1392, $47

; compressed BG tiles (2048 bytes, 128 tiles): entry 9 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 653 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles9::
    INCBIN "dwm2-cobi-us.gbc", $1C13D9, $28D

; entry 9 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes9::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $150b, $6bff, $4d8c, $0044 ; entry 1
    dw $4d8c, $6bff, $5e73, $0000 ; entry 2
    dw $7da0, $7fff, $7fe0, $0063 ; entry 3
    dw $5d8c, $6bff, $5ab1, $0000 ; entry 4
    dw $218c, $6bff, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C16A6, $8B

; LZSS-compressed: 183 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C1731, $B7

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C17E8, $D9

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C18C1, $A9

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C196A, $C2

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C1A2C, $EC

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C1B18, $EE

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y3X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C1C06, $DE

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_5CE4::
    INCBIN "dwm2-cobi-us.gbc", $1C1CE4, $A2

; LZSS-compressed: 199 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_5D86::
    INCBIN "dwm2-cobi-us.gbc", $1C1D86, $C7

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_5E4D::
    INCBIN "dwm2-cobi-us.gbc", $1C1E4D, $E0

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_5F2D::
    INCBIN "dwm2-cobi-us.gbc", $1C1F2D, $D8

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_6005::
    INCBIN "dwm2-cobi-us.gbc", $1C2005, $95

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_609A::
    INCBIN "dwm2-cobi-us.gbc", $1C209A, $D6

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom29_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C2170, $DA

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_624A::
    INCBIN "dwm2-cobi-us.gbc", $1C224A, $D7

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $09, $00, $20, $0f, $17, $00, $1e, $0f, $01, $00, $0a, $06, $00, $08, $00
    db $00, $78, $04, $00, $70, $0f, $0b, $03, $03, $00, $90, $0f, $39, $00, $ef, $0f
    db $4d, $00, $20, $0f, $05

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y2X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C2356, $42

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y3X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $31, $00, $06, $02, $00, $0a, $0c, $00, $5a, $06, $00, $5a, $02, $00, $78
    db $06, $00, $74, $0f, $09, $00, $76, $06, $00, $02, $08, $00, $a6, $0c, $00, $00
    db $06, $00, $ca, $0f, $09, $00, $ef, $0f, $4d, $00, $08, $1f, $05

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y2X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C23D5, $4C

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y2X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C2421, $49

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y3X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C246A, $4B

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C24B5, $59

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y3X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C250E, $48

; LZSS-compressed: 3295 bytes that expand to 3359 (E-0016, E-0017)
Gfx_70_6556::
    db $1f, $0d

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_6558::
    INCBIN "dwm2-cobi-us.gbc", $1C2558, $51

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_65A9::
    INCBIN "dwm2-cobi-us.gbc", $1C25A9, $68

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_6611::
    INCBIN "dwm2-cobi-us.gbc", $1C2611, $5D

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_666E::
    INCBIN "dwm2-cobi-us.gbc", $1C266E, $66

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_66D4::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $31, $05, $05, $00, $46, $0f, $0b, $00, $08, $00, $03, $03, $05, $05, $05
    db $05, $03, $03, $00, $70, $0f, $0f, $00, $7c, $02, $00, $98, $0f, $0d, $00, $c8
    db $02, $00, $be, $0f, $0b, $00, $ef, $0f, $4d, $00, $08, $1f, $05

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_6711::
    INCBIN "dwm2-cobi-us.gbc", $1C2711, $47

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom29_Y2X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C2758, $48

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_67A0::
    INCBIN "dwm2-cobi-us.gbc", $1C27A0, $50

; compressed BG tiles (2048 bytes, 128 tiles): entry 10 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 660 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles10::
    INCBIN "dwm2-cobi-us.gbc", $1C27F0, $294

; entry 10 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes10::
    dw $01a2, $7fff, $0348, $0063 ; entry 0
    dw $01a2, $3f7f, $0348, $0084 ; entry 1
    dw $01a2, $3f7f, $0348, $0084 ; entry 2
    dw $01a2, $7fff, $0348, $0084 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $218c, $3f7f, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y1X0_Tiles::
    db $68, $01, $00, $20, $21, $00, $00, $00, $08, $09, $40, $41, $40, $41, $06, $07
    db $00, $00, $02, $30, $31, $00, $14, $00, $18, $19, $50, $51, $50, $51, $16, $17
    db $00, $14, $02, $00, $00, $0f, $4d, $00, $60, $0f, $35, $42, $43, $00, $5a, $0e
    db $52, $53, $00, $be, $0f, $27, $00, $58, $0f, $35

; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C2AFE, $BA

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C2BB8, $CE

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C2C86, $D7

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C2D5D, $A1

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C2DFE, $E5

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y1X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C2EE3, $B9

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C2F9C, $DA

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_7076::
    db $68, $01, $00, $20, $21, $00, $00, $00, $08, $09, $40, $41, $40, $41, $06, $07
    db $00, $00, $02, $30, $31, $00, $14, $00, $18, $19, $50, $51, $50, $51, $16, $17
    db $00, $14, $02, $00, $00, $0f, $45, $28, $29, $28, $29, $00, $0c, $0c, $38, $39
    db $38, $39, $00, $70, $0f, $4d, $00, $08, $0f, $4d, $00, $08, $1c

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_70B3::
    INCBIN "dwm2-cobi-us.gbc", $1C30B3, $C1

KeyWorldScreen_70_7174::
    INCBIN "dwm2-cobi-us.gbc", $1C3174, $C1

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_7235::
    INCBIN "dwm2-cobi-us.gbc", $1C3235, $C9

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0D_Y1X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C32FE, $BD

; LZSS-compressed: 257 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom3E_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C33BB, $101

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_70_74BC::
    INCBIN "dwm2-cobi-us.gbc", $1C34BC, $B9

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom37_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1C3575, $DD

; LZSS-compressed: 33 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y1X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $60, $0f, $49, $00, $6a, $00, $00, $c0, $0f, $39, $00, $6c, $0f
    db $35

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y1X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $2d, $00, $08, $00, $00, $54, $06, $00, $4e, $0f, $05, $00, $56, $0e, $00
    db $78, $0f, $0d, $00, $4a, $0f, $01, $00, $ac, $0f, $1f, $00, $52, $06, $00, $e8
    db $0f, $0d, $00, $78, $0f, $17, $00, $06, $0f, $0f

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y1X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C36AD, $47

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C36F4, $51

KeyWorldRoom02_Y1X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $2f, $00, $08, $00, $00, $08, $0c, $00, $56, $0e, $00, $56, $04, $00, $08
    db $08, $00, $7c, $0e, $00, $7c, $08, $00, $08, $04, $00, $a2, $0f, $29, $00, $7a
    db $0f, $15, $00, $52, $0f, $17, $00, $04, $0f, $11

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C377F, $4E

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y1X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $09, $00, $06, $00, $00, $20, $0f, $39, $00, $08, $00, $03, $00, $84, $01
    db $00, $76, $0f, $0b, $00, $7c, $06, $00, $9e, $0f, $39, $00, $9a, $0f, $01, $00
    db $86, $0a, $03, $03, $00, $fc, $0e, $00, $20, $1f, $01, $00, $08, $0f, $0d

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y1X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C380C, $43

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_784F::
    db $68, $01, $03, $02, $03, $00, $03, $01, $01, $01, $01, $03, $00, $04, $03, $00
    db $0f, $4d, $03, $20, $08, $00, $02, $03, $ff, $f5, $03, $77, $06, $03, $fd, $f7
    db $03, $78, $0f, $45, $03, $1c, $0f, $4d, $03, $08, $1c

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_787A::
    INCBIN "dwm2-cobi-us.gbc", $1C387A, $63

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_78DD::
    INCBIN "dwm2-cobi-us.gbc", $1C38DD, $4A

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_7927::
    INCBIN "dwm2-cobi-us.gbc", $1C3927, $47

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0D_Y1X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C396E, $4C

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom3E_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C39BA, $53

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_70_7A0D::
    INCBIN "dwm2-cobi-us.gbc", $1C3A0D, $45

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom37_Y2X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1C3A52, $4B

; compressed BG tiles (2048 bytes, 128 tiles): entry 11 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 1053 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles11::
    INCBIN "dwm2-cobi-us.gbc", $1C3A9D, $41D

; entry 11 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes11::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $218c, $3f7f, $029a, $0000 ; entry 1
    dw $3523, $42d8, $318c, $0044 ; entry 2
    dw $218c, $3f7f, $318c, $0084 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $218c, $3f7f, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7
    ds $106, $00
