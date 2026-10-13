; ROM bank $6C: special map screens
; The annotated listing of this bank is build/listing/bank6c.asm.

SECTION "Bank 6C", ROMX[$4000], BANK[$6C]
    db $6c

; compressed tileset of special map record 16 (SpecialMapRecords)
; LZSS-compressed: 648 bytes that expand to 1280 (E-0016, E-0017)
SpecialMap10Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1B0001, $288

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap10Palettes::
    dw $100e, $7fff, $718c, $0000 ; entry 0
    dw $012f, $3f7f, $01da, $0000 ; entry 1
    dw $01c0, $7fff, $03e2, $0000 ; entry 2
    dw $01c0, $3f7f, $03e2, $0000 ; entry 3
    dw $218c, $3f7f, $03e2, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap10Screens::
    dfar SpecialMap10Screens_Y0X0 ; entry 0
    dfar SpecialMap10Screens_Y0X1 ; entry 1

SpecialMap10Attrs::
    dfar SpecialMap10Attrs_Y0X0 ; entry 0
    dfar SpecialMap10Attrs_Y0X1 ; entry 1

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
SpecialMap10Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B02D5, $E5

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
SpecialMap10Screens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B03BA, $EC

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
SpecialMap10Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B04A6, $51

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
SpecialMap10Attrs_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B04F7, $45

; compressed tileset of special map record 17 (SpecialMapRecords)
; LZSS-compressed: 689 bytes that expand to 1216 (E-0016, E-0017)
SpecialMap11Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1B053C, $2B1

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap11Palettes::
    dw $00af, $7fff, $4208, $0000 ; entry 0
    dw $00af, $67ff, $01da, $0000 ; entry 1
    dw $0191, $3f7f, $029a, $0000 ; entry 2
    dw $01c0, $3f7f, $01d3, $0000 ; entry 3
    dw $092e, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap11Screens::
    dfar SpecialMap11Screens_Y0X0 ; entry 0
    dfar SpecialMap11Screens_Y0X1 ; entry 1

SpecialMap11Attrs::
    dfar SpecialMap11Attrs_Y0X0 ; entry 0
    dfar SpecialMap11Attrs_Y0X1 ; entry 1

; LZSS-compressed: 259 bytes that expand to 360 (E-0016, E-0017)
SpecialMap11Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B0839, $103

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
SpecialMap11Screens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B093C, $EE

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
SpecialMap11Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B0A2A, $68

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
SpecialMap11Attrs_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B0A92, $64

; compressed tileset of special map record 18 (SpecialMapRecords)
; LZSS-compressed: 886 bytes that expand to 1248 (E-0016, E-0017)
SpecialMap12Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1B0AF6, $376

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap12Palettes::
    dw $2d6b, $7fff, $4a52, $0000 ; entry 0
    dw $50aa, $1f1f, $013f, $0000 ; entry 1
    dw $3d6b, $3f7f, $5e8e, $0000 ; entry 2
    dw $01c0, $3f7f, $03e2, $0000 ; entry 3
    dw $012f, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap12Screens::
    dfar SpecialMap12Screens_Y0X0 ; entry 0
    dfar SpecialMap12Screens_Y0X1 ; entry 1

SpecialMap12Attrs::
    dfar SpecialMap12Attrs_Y0X0 ; entry 0
    dfar SpecialMap12Attrs_Y0X1 ; entry 1

; LZSS-compressed: 270 bytes that expand to 360 (E-0016, E-0017)
SpecialMap12Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B0EB8, $10E

; LZSS-compressed: 243 bytes that expand to 360 (E-0016, E-0017)
SpecialMap12Screens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B0FC6, $F3

; LZSS-compressed: 123 bytes that expand to 360 (E-0016, E-0017)
SpecialMap12Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B10B9, $7B

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
SpecialMap12Attrs_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B1134, $60

; compressed tileset of special map record 19 (SpecialMapRecords)
; LZSS-compressed: 749 bytes that expand to 1216 (E-0016, E-0017)
SpecialMap13Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1B1194, $2ED

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap13Palettes::
    dw $218c, $7fff, $7eb1, $0000 ; entry 0
    dw $012f, $7fff, $01da, $0000 ; entry 1
    dw $012f, $3f3f, $0239, $0000 ; entry 2
    dw $1586, $7fff, $02c0, $0000 ; entry 3
    dw $1094, $429e, $21b8, $0044 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap13Screens::
    dfar SpecialMap13Screens_Y0X0 ; entry 0
    dfar SpecialMap13Screens_Y0X1 ; entry 1

SpecialMap13Attrs::
    dfar SpecialMap13Attrs_Y0X0 ; entry 0
    dfar SpecialMap13Attrs_Y0X1 ; entry 1

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
SpecialMap13Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B14CD, $E6

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
SpecialMap13Screens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B15B3, $EE

; LZSS-compressed: 124 bytes that expand to 360 (E-0016, E-0017)
SpecialMap13Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B16A1, $7C

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
SpecialMap13Attrs_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B171D, $78

; compressed tileset of special map record 20 (SpecialMapRecords)
; LZSS-compressed: 750 bytes that expand to 1216 (E-0016, E-0017)
SpecialMap14Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1B1795, $2EE

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap14Palettes::
    dw $49ae, $7fff, $4acd, $0000 ; entry 0
    dw $012f, $67ff, $01da, $0000 ; entry 1
    dw $012f, $3f7f, $029a, $0000 ; entry 2
    dw $1586, $3f7f, $029a, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap14Screens::
    dfar SpecialMap14Screens_Y0X0 ; entry 0
    dfar SpecialMap14Screens_Y0X1 ; entry 1

SpecialMap14Attrs::
    dfar SpecialMap14Attrs_Y0X0 ; entry 0
    dfar SpecialMap14Attrs_Y0X1 ; entry 1

; LZSS-compressed: 280 bytes that expand to 360 (E-0016, E-0017)
SpecialMap14Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B1ACF, $118

; LZSS-compressed: 264 bytes that expand to 360 (E-0016, E-0017)
SpecialMap14Screens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B1BE7, $108

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
SpecialMap14Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B1CEF, $43

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
SpecialMap14Attrs_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B1D32, $41

; compressed tileset of special map record 21 (SpecialMapRecords)
; LZSS-compressed: 828 bytes that expand to 1232 (E-0016, E-0017)
SpecialMap15Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1B1D73, $33C

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap15Palettes::
    dw $100e, $7fff, $718c, $0000 ; entry 0
    dw $18eb, $67ff, $01da, $0000 ; entry 1
    dw $28e8, $4f18, $0dd5, $0000 ; entry 2
    dw $3c6b, $3a52, $2510, $0000 ; entry 3
    dw $012f, $03e2, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap15Screens::
    dfar SpecialMap15Screens_Y0X0 ; entry 0
    dfar SpecialMap15Screens_Y0X1 ; entry 1

SpecialMap15Attrs::
    dfar SpecialMap15Attrs_Y0X0 ; entry 0
    dfar SpecialMap15Attrs_Y0X1 ; entry 1

; LZSS-compressed: 292 bytes that expand to 360 (E-0016, E-0017)
SpecialMap15Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B20FB, $124

; LZSS-compressed: 291 bytes that expand to 360 (E-0016, E-0017)
SpecialMap15Screens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B221F, $123

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
SpecialMap15Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B2342, $4F

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
SpecialMap15Attrs_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B2391, $53

; compressed tileset of special map record 22 (SpecialMapRecords)
; LZSS-compressed: 885 bytes that expand to 1504 (E-0016, E-0017)
SpecialMap16Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1B23E4, $375

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap16Palettes::
    dw $212a, $7fff, $31cf, $0000 ; entry 0
    dw $0111, $3f7f, $0175, $0009 ; entry 1
    dw $01a0, $3f7f, $03e7, $00a0 ; entry 2
    dw $49ae, $7fff, $4acd, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $2111, $3a5c, $21b8, $0044 ; entry 5
    dw $00f0, $7fff, $09f5, $0009 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap16Screens::
    dfar SpecialMap16Screens_Y0X0 ; entry 0
    dfar SpecialMap16Screens_Y0X1 ; entry 1

SpecialMap16Attrs::
    dfar SpecialMap16Attrs_Y0X0 ; entry 0
    dfar SpecialMap16Attrs_Y0X1 ; entry 1

; LZSS-compressed: 261 bytes that expand to 360 (E-0016, E-0017)
SpecialMap16Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B27A5, $105

; LZSS-compressed: 232 bytes that expand to 360 (E-0016, E-0017)
SpecialMap16Screens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B28AA, $E8

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
SpecialMap16Attrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B2992, $50

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
SpecialMap16Attrs_Y0X1::
    db $68, $01, $04, $02, $04, $00, $0f, $06, $06, $06, $06, $06, $04, $0a, $0f, $1f
    db $06, $06, $00, $00, $04, $1a, $00, $04, $44, $0f, $0f, $04, $78, $04, $04, $6e
    db $0f, $15, $01, $04, $aa, $03, $04, $9e, $0f, $37, $03, $03, $03, $03, $04, $ec
    db $0f, $05, $04, $16, $06, $04, $aa, $06, $04, $18, $1f, $05, $04, $3e, $1f, $11

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap17Screens::
    dfar SpecialMap17Screens_Y0X0 ; entry 0
    dfar SpecialMap17Screens_Y0X1 ; entry 1

SpecialMap17Attrs::
    dfar SpecialMap17Attrs_Y0X0 ; entry 0
    dfar SpecialMap17Attrs_Y0X1 ; entry 1

; LZSS-compressed: 249 bytes that expand to 360 (E-0016, E-0017)
SpecialMap17Screens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B2A2E, $F9

; LZSS-compressed: 301 bytes that expand to 360 (E-0016, E-0017)
SpecialMap17Screens_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B2B27, $12D

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
SpecialMap17Attrs_Y0X0::
    db $68, $01, $00, $03, $00, $00, $0f, $42, $02, $00, $56, $05, $00, $4c, $0f, $0d
    db $04, $04, $02, $02, $05, $05, $00, $7e, $00, $00, $76, $0f, $07, $00, $80, $00
    db $00, $56, $04, $04, $04, $00, $88, $02, $00, $a4, $0f, $2b, $00, $f4, $0a, $00
    db $f0, $0f, $05, $00, $f2, $0c, $00, $18, $1f, $07, $00, $00, $0f, $0f

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
SpecialMap17Attrs_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1B2C92, $4A

; compressed tileset of special map record 26 (SpecialMapRecords)
; LZSS-compressed: 1306 bytes that expand to 2048 (E-0016, E-0017)
SpecialMap1ATileset::
    INCBIN "dwm2-cobi-us.gbc", $1B2CDC, $51A

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap1APalettes::
    dw $00d9, $7fff, $025f, $0063 ; entry 0
    dw $30e9, $5f17, $49cd, $0044 ; entry 1
    dw $39c9, $5f17, $4a8d, $0000 ; entry 2
    dw $10cc, $52da, $1d94, $0000 ; entry 3
    dw $194a, $6bdf, $15ef, $0084 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $194a, $5f17, $2e0e, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1AScreens::
    dfar SpecialMap1AScreens_Y0X0 ; entry 0

SpecialMap1AAttrs::
    dfar SpecialMap1AAttrs_Y0X0 ; entry 0

SpecialMap1BScreens::
    dfar SpecialMap1BScreens_Y0X0 ; entry 0

SpecialMap1BAttrs::
    dfar SpecialMap1BAttrs_Y0X0 ; entry 0

SpecialMap1CScreens::
    dfar SpecialMap1CScreens_Y0X0 ; entry 0

SpecialMap1CAttrs::
    dfar SpecialMap1CAttrs_Y0X0 ; entry 0

SpecialMap1DScreens::
    dfar SpecialMap1DScreens_Y0X0 ; entry 0

SpecialMap1DAttrs::
    dfar SpecialMap1DAttrs_Y0X0 ; entry 0

SpecialMap1EScreens::
    dfar SpecialMap1EScreens_Y0X0 ; entry 0

SpecialMap1EAttrs::
    dfar SpecialMap1EAttrs_Y0X0 ; entry 0

; LZSS-compressed: 272 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1AScreens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B3254, $110

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1AAttrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B3364, $68

; LZSS-compressed: 278 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1BScreens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B33CC, $116

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1BAttrs_Y0X0::
    db $68, $01, $00, $03, $00, $00, $0f, $06, $06, $06, $00, $16, $06, $00, $16, $02
    db $00, $2a, $0a, $00, $26, $0f, $1f, $00, $62, $0e, $00, $22, $08, $00, $76, $0f
    db $07, $00, $0e, $0f, $09, $00, $16, $08, $00, $7c, $0f, $15, $00, $ea, $0f, $13
    db $00, $28, $0a, $00, $22, $0f, $01, $00, $00, $0f, $07, $00, $00, $0e

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1CScreens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B3520, $E0

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1CAttrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B3600, $57

; LZSS-compressed: 247 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1DScreens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B3657, $F7

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1DAttrs_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B374E, $46

; LZSS-compressed: 286 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1EScreens_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1B3794, $11E

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
SpecialMap1EAttrs_Y0X0::
    db $68, $01, $00, $04, $00, $00, $0f, $42, $06, $00, $56, $03, $00, $4a, $0f, $0d
    db $00, $54, $02, $00, $46, $0f, $01, $00, $4c, $09, $00, $7d, $06, $00, $5b, $05
    db $00, $a4, $08, $00, $4e, $05, $00, $b9, $0f, $18, $00, $ed, $0a, $00, $95, $0f
    db $00, $00, $b5, $0f, $05, $06, $00, $7e, $04, $00, $96, $0b, $00, $59, $0f, $0c

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8F_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B38F2, $B0

KeyWorldRoom8F_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B39A2, $46

; LZSS-compressed: 157 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8C_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B39E8, $9D

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8C_Y3X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $40, $01, $00, $54, $07, $00, $4c, $0f, $05
    db $00, $5a, $0f, $0b, $00, $50, $0e, $01, $01, $03, $03, $00, $98, $0f, $11, $03
    db $03, $00, $a4, $02, $00, $c4, $0f, $05, $00, $52, $02, $00, $4c, $08, $00, $fa
    db $08, $00, $fa, $0c, $00, $68, $0f, $03, $00, $20, $1f, $21

KeyWorldRoom8E_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B3AC1, $B0

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8E_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B3B71, $42

; LZSS-compressed: 172 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8D_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B3BB3, $AC

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8D_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B3C5F, $43

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom91_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B3CA2, $99

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom91_Y3X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $40, $01, $00, $54, $07, $00, $4c, $0f, $07
    db $00, $5c, $0e, $00, $78, $0f, $09, $01, $01, $03, $03, $00, $98, $0f, $11, $03
    db $03, $00, $8a, $04, $00, $c6, $0f, $0b, $00, $74, $0a, $00, $f2, $0f, $05, $00
    db $54, $0c, $00, $1a, $1f, $27

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom96_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B3D71, $94

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom96_Y3X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $40, $01, $00, $54, $07, $00, $4c, $0f, $05
    db $00, $5a, $0e, $00, $76, $0f, $0b, $01, $01, $03, $03, $00, $98, $0f, $11, $03
    db $03, $00, $88, $04, $00, $c6, $0f, $03, $00, $e8, $06, $00, $ee, $08, $00, $f2
    db $0f, $05, $00, $68, $0f, $03, $00, $20, $1f, $21

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom99_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B3E3F, $A5

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom99_Y3X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $2d, $00, $08, $00, $00, $54, $04, $00, $4c, $0f, $07, $00, $5c, $0c, $00
    db $76, $0f, $0b, $01, $01, $03, $03, $00, $98, $0f, $11, $03, $03, $00, $a4, $02
    db $00, $c4, $0f, $0d, $00, $80, $0f, $13, $00, $54, $0c, $00, $1a, $1f, $27
    ds $dd, $00
