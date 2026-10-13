; ROM bank $94: special map screens
; The annotated listing of this bank is build/listing/bank94.asm.

SECTION "Bank 94", ROMX[$4000], BANK[$94]
    db $94

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map19Palettes::
BGPaletteBufferData_94_4001::
    dw $7d86, $7fff, $0214, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $012f, $4f3f, $001f, $0000 ; entry 5
    dw $29ce, $031d, $1415, $0000 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; compressed tileset of map $A3 (the first map record using it)
; LZSS-compressed: 1575 bytes that expand to 1872 (E-0016, E-0017)
MapA3Tileset::
    INCBIN "dwm2-cobi-us.gbc", $250041, $627

MapA3Palettes::
    dw $6080, $7fff, $6301, $0000 ; entry 0
    dw $48ec, $6bff, $4a6f, $0000 ; entry 1
    dw $384e, $53de, $5956, $0000 ; entry 2
    dw $00ef, $6bff, $015c, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $3320, $6bff, $4a6f, $0084 ; entry 5
    dw $023f, $2bff, $4a6f, $0084 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapA3Screens0::
    dfar MapA3Screens0_Y0X0 ; entry 0
    dfar MapA3Screens0_Y1X0 ; entry 1

MapA3Attrs0::
    dfar MapA3Attrs0_Y0X0 ; entry 0
    dfar MapA3Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 304 bytes that expand to 360 (E-0016, E-0017)
MapA3Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $2506B4, $130

; LZSS-compressed: 310 bytes that expand to 360 (E-0016, E-0017)
MapA3Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $2507E4, $136

; LZSS-compressed: 112 bytes that expand to 360 (E-0016, E-0017)
MapA3Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $25091A, $70

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
MapA3Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $25098A, $88

; compressed tileset of special map record 12 (SpecialMapRecords)
; LZSS-compressed: 1250 bytes that expand to 1728 (E-0016, E-0017)
SpecialMap0CTileset::
    INCBIN "dwm2-cobi-us.gbc", $250A12, $4E2

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0CPalettes::
    dw $212a, $7fff, $31cf, $0000 ; entry 0
    dw $0111, $3f7f, $0175, $0009 ; entry 1
    dw $01a0, $3f7f, $03e7, $00a0 ; entry 2
    dw $49ae, $7fff, $4acd, $0000 ; entry 3
    dw $7c01, $7fff, $7fe1, $0000 ; entry 4
    dw $2111, $3a5c, $21b8, $0044 ; entry 5
    dw $00f0, $7fff, $09f5, $0009 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of special map record 13 (SpecialMapRecords)
; LZSS-compressed: 1365 bytes that expand to 1584 (E-0016, E-0017)
SpecialMap0DTileset::
    INCBIN "dwm2-cobi-us.gbc", $250F34, $555

SpecialMap0DPalettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $00ed, $7fff, $11d4, $0000 ; entry 1
    dw $00ed, $22ba, $11d4, $0000 ; entry 2
    dw $01c4, $3f7f, $0348, $0000 ; entry 3
    dw $00ed, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0DScreens::
    dfar SpecialMap0DScreens_Y0X0 ; entry 0
    dfar SpecialMap0DScreens_Y0X1 ; entry 1
    dfar SpecialMap0DScreens_Y1X0 ; entry 2
    dfar SpecialMap0DScreens_Y1X1 ; entry 3

SpecialMap0DAttrs::
    dfar SpecialMap0DAttrs_Y0X0 ; entry 0
    dfar SpecialMap0DAttrs_Y0X1 ; entry 1
    dfar SpecialMap0DAttrs_Y1X0 ; entry 2
    dfar SpecialMap0DAttrs_Y1X1 ; entry 3

; LZSS-compressed: 260 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0DScreens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $2514E1, $104

; LZSS-compressed: 276 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0DScreens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $2515E5, $114

; LZSS-compressed: 294 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0DScreens_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $2516F9, $126

; LZSS-compressed: 308 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0DScreens_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $25181F, $134

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0DAttrs_Y0X0::
    db $68, $01, $00, $03, $00, $00, $0f, $42, $02, $00, $56, $05, $00, $4c, $0f, $31
    db $04, $04, $00, $92, $0f, $1f, $04, $04, $04, $04, $00, $c8, $0f, $07, $00, $f4
    db $08, $00, $f0, $0e, $00, $ee, $0f, $05, $00, $18, $1f, $05, $00, $ce, $08, $00
    db $53, $00, $00, $40, $1e, $02, $02

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0DAttrs_Y0X1::
    db $68, $01, $00, $03, $00, $00, $0f, $06, $04, $04, $04, $04, $00, $0a, $0f, $29
    db $00, $56, $02, $00, $4c, $0f, $0f, $02, $00, $82, $03, $00, $76, $0f, $2b, $00
    db $56, $06, $00, $be, $0f, $0b, $00, $52, $08, $00, $e8, $0f, $0d, $00, $54, $04
    db $00, $10, $1f, $11, $00, $00, $08, $00, $89, $02, $00, $1c, $0a

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0DAttrs_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $2519C7, $5B

; LZSS-compressed: 110 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0DAttrs_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $251A22, $6E

; compressed tileset of special map record 14 (SpecialMapRecords)
; LZSS-compressed: 1183 bytes that expand to 1552 (E-0016, E-0017)
SpecialMap0ETileset::
    INCBIN "dwm2-cobi-us.gbc", $251A90, $49F

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0EPalettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $05a4, $4b7b, $2a8e, $0084 ; entry 1
    dw $386c, $53de, $4593, $0000 ; entry 2
    dw $012f, $035f, $01da, $0000 ; entry 3
    dw $0160, $5ab1, $4a2d, $0000 ; entry 4
    dw $0152, $53de, $025c, $0008 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0EScreens::
    dfar SpecialMap0EScreens_Y0X0 ; entry 0
    dfar SpecialMap0EScreens_Y0X1 ; entry 1
    dfar SpecialMap0EScreens_Y1X0 ; entry 2
    dfar SpecialMap0EScreens_Y1X1 ; entry 3

SpecialMap0EAttrs::
    dfar SpecialMap0EAttrs_Y0X0 ; entry 0
    dfar SpecialMap0EAttrs_Y0X1 ; entry 1
    dfar SpecialMap0EAttrs_Y1X0 ; entry 2
    dfar SpecialMap0EAttrs_Y1X1 ; entry 3

; LZSS-compressed: 225 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0EScreens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $251F87, $E1

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0EScreens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $252068, $F6

; LZSS-compressed: 291 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0EScreens_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $25215E, $123

; LZSS-compressed: 293 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0EScreens_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $252281, $125

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0EAttrs_Y0X0::
    db $68, $01, $00, $04, $00, $00, $0f, $40, $01, $00, $54, $03, $00, $48, $0f, $0b
    db $00, $54, $04, $00, $58, $02, $00, $82, $06, $00, $7e, $0f, $09, $00, $80, $08
    db $00, $a6, $0f, $25, $00, $a0, $0e, $00, $f0, $0f, $13, $00, $74, $0e, $00, $5a
    db $04, $02, $00, $44, $15, $00, $3a, $1f, $07

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0EAttrs_Y0X1::
    db $68, $01, $00, $04, $00, $00, $0f, $1a, $01, $00, $2e, $03, $00, $22, $0f, $0b
    db $00, $2e, $04, $00, $32, $08, $00, $54, $0c, $00, $54, $08, $00, $30, $04, $00
    db $78, $0f, $4d, $00, $b0, $0f, $19, $00, $b2, $0c, $00, $4e, $0e, $00, $26, $1c
    db $00, $22, $0f, $0b

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0EAttrs_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $252413, $47

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0EAttrs_Y1X1::
    db $68, $01, $02, $04, $04, $01, $02, $02, $0b, $04, $04, $02, $00, $0f, $0b, $02
    db $fa, $f2, $02, $24, $0f, $05, $02, $02, $06, $02, $32, $04, $02, $02, $08, $02
    db $5a, $0f, $01, $02, $81, $0f, $4d, $02, $04, $0f, $1b, $02, $0a, $08, $02, $00
    db $04, $02, $12, $04, $02, $18, $1f, $11, $02, $4c, $16, $02, $46, $1a

; compressed tileset of special map record 15 (SpecialMapRecords)
; LZSS-compressed: 1244 bytes that expand to 1712 (E-0016, E-0017)
SpecialMap0FTileset::
    INCBIN "dwm2-cobi-us.gbc", $252498, $4DC

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0FPalettes::
    dw $192c, $7fff, $31cf, $0000 ; entry 0
    dw $0175, $5b7f, $1e7e, $0009 ; entry 1
    dw $01c4, $3f7f, $03e7, $00a0 ; entry 2
    dw $192c, $7fff, $03e7, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $7da0, $7fff, $7fe0, $0000 ; entry 5
    dw $0cec, $3f7f, $0175, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0FScreens::
    dfar SpecialMap0FScreens_Y0X0 ; entry 0
    dfar SpecialMap0FScreens_Y0X1 ; entry 1
    dfar SpecialMap0FScreens_Y1X0 ; entry 2
    dfar SpecialMap0FScreens_Y1X1 ; entry 3

SpecialMap0FAttrs::
    dfar SpecialMap0FAttrs_Y0X0 ; entry 0
    dfar SpecialMap0FAttrs_Y0X1 ; entry 1
    dfar SpecialMap0FAttrs_Y1X0 ; entry 2
    dfar SpecialMap0FAttrs_Y1X1 ; entry 3

; LZSS-compressed: 275 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0FScreens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $2529CC, $113

; LZSS-compressed: 248 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0FScreens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $252ADF, $F8

; LZSS-compressed: 257 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0FScreens_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $252BD7, $101

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0FScreens_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $252CD8, $E4

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0FAttrs_Y0X0::
    db $68, $01, $03, $02, $03, $00, $0f, $1a, $01, $03, $2e, $01, $03, $20, $0f, $15
    db $03, $56, $04, $03, $50, $0f, $03, $06, $03, $7a, $09, $03, $74, $0f, $0f, $00
    db $00, $03, $98, $0f, $13, $03, $80, $06, $03, $c8, $0f, $2b, $03, $00, $00, $03
    db $80, $08, $03, $16, $1f, $0d, $03, $5a, $0c, $03, $46, $1a

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0FAttrs_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $252DF8, $5B

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0FAttrs_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $252E53, $53

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0FAttrs_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $252EA6, $42

; compressed tileset of special map record 23 (SpecialMapRecords)
; LZSS-compressed: 743 bytes that expand to 1280 (E-0016, E-0017)
SpecialMap17Tileset::
    INCBIN "dwm2-cobi-us.gbc", $252EE8, $2E7

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap17Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $00ed, $7fff, $11d4, $0000 ; entry 1
    dw $00ed, $22ba, $11d4, $0000 ; entry 2
    dw $01c4, $3f7f, $0348, $0000 ; entry 3
    dw $00ed, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of special map record 24 (SpecialMapRecords)
; LZSS-compressed: 622 bytes that expand to 1200 (E-0016, E-0017)
SpecialMap18Tileset::
    INCBIN "dwm2-cobi-us.gbc", $25320F, $26E

SpecialMap18Palettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $05a4, $4b7b, $2a8e, $0084 ; entry 1
    dw $386c, $53de, $4593, $0000 ; entry 2
    dw $012f, $035f, $01da, $0000 ; entry 3
    dw $0160, $5ab1, $4a2d, $0000 ; entry 4
    dw $0152, $53de, $025c, $0008 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap18Screens::
    dfar SpecialMap18Screens_Y0X0 ; entry 0
    dfar SpecialMap18Screens_Y0X1 ; entry 1

SpecialMap18Attrs::
    dfar SpecialMap18Attrs_Y0X0 ; entry 0
    dfar SpecialMap18Attrs_Y0X1 ; entry 1

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
SpecialMap18Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $2534C9, $C6

; LZSS-compressed: 243 bytes that expand to 360 (E-0016, E-0017)
SpecialMap18Screens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $25358F, $F3

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
SpecialMap18Attrs_Y0X0::
    db $68, $01, $00, $04, $00, $00, $0f, $42, $01, $00, $56, $05, $00, $4c, $0f, $11
    db $06, $06, $00, $5a, $08, $00, $7e, $0e, $00, $56, $06, $00, $9a, $0f, $4d, $00
    db $be, $0f, $07, $00, $4e, $0e, $00, $5e, $0f, $13, $00, $5c, $04

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
SpecialMap18Attrs_Y0X1::
    db $68, $01, $00, $04, $00, $00, $0f, $14, $01, $00, $28, $03, $00, $24, $02, $00
    db $22, $0f, $11, $00, $2a, $08, $00, $52, $0f, $07, $00, $78, $06, $00, $76, $0f
    db $4d, $00, $9a, $0f, $03, $00, $74, $0f, $01, $00, $20, $0c, $00, $10, $1f, $0d
    db $00, $26, $0a, $00, $3e, $1f, $03

; compressed tileset of special map record 25 (SpecialMapRecords)
; LZSS-compressed: 832 bytes that expand to 1408 (E-0016, E-0017)
SpecialMap19Tileset::
    INCBIN "dwm2-cobi-us.gbc", $2536E6, $340

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap19Palettes::
    dw $192c, $7fff, $31cf, $0000 ; entry 0
    dw $0175, $5b7f, $1e7e, $0009 ; entry 1
    dw $01c4, $3f7f, $03e7, $00a0 ; entry 2
    dw $192a, $3f7f, $22f0, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $7da0, $7fff, $7fe0, $0000 ; entry 5
    dw $0cec, $3f7f, $0175, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap19Screens::
    dfar SpecialMap19Screens_Y0X0 ; entry 0
    dfar SpecialMap19Screens_Y0X1 ; entry 1

SpecialMap19Attrs::
    dfar SpecialMap19Attrs_Y0X0 ; entry 0
    dfar SpecialMap19Attrs_Y0X1 ; entry 1

; LZSS-compressed: 282 bytes that expand to 360 (E-0016, E-0017)
SpecialMap19Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $253A72, $11A

; LZSS-compressed: 265 bytes that expand to 360 (E-0016, E-0017)
SpecialMap19Screens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $253B8C, $109

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
SpecialMap19Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $253C95, $48

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
SpecialMap19Attrs_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $253CDD, $5A
    ds $2c9, $00
