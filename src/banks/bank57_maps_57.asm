; ROM bank $57: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank57.asm.

SECTION "Bank 57", ROMX[$4000], BANK[$57]
    db $57

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map32Screens0::
    dfar Map32Screens0_Y0X0 ; entry 0
    dfar Map32Screens0_Y0X1 ; entry 1
    dfar Map32Screens0_Y1X0 ; entry 2
    dfar Map32Screens0_Y1X1 ; entry 3

Map32Attrs0::
    dfar Map32Attrs0_Y0X0 ; entry 0
    dfar Map32Attrs0_Y0X1 ; entry 1
    dfar Map32Attrs0_Y1X0 ; entry 2
    dfar Map32Attrs0_Y1X1 ; entry 3

Map32Screens2::
    dfar Map32Screens0_Y0X0 ; entry 0
    dfar Map32Screens0_Y0X1 ; entry 1
    dfar Map32Screens2_Y1X0 ; entry 2
    dfar Map32Screens2_Y1X1 ; entry 3

Map32Attrs2::
    dfar Map32Attrs0_Y0X0 ; entry 0
    dfar Map32Attrs0_Y0X1 ; entry 1
    dfar Map32Attrs2_Y1X0 ; entry 2
    dfar Map32Attrs2_Y1X1 ; entry 3

; LZSS-compressed: 270 bytes that expand to 360 (E-0016, E-0017)
Map32Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15C031, $10E

; LZSS-compressed: 303 bytes that expand to 360 (E-0016, E-0017)
Map32Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $15C13F, $12F

; LZSS-compressed: 268 bytes that expand to 360 (E-0016, E-0017)
Map32Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15C26E, $10C

; LZSS-compressed: 256 bytes that expand to 360 (E-0016, E-0017)
Map32Screens2_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15C37A, $100

; LZSS-compressed: 263 bytes that expand to 360 (E-0016, E-0017)
Map32Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $15C47A, $107

; LZSS-compressed: 239 bytes that expand to 360 (E-0016, E-0017)
Map32Screens2_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $15C581, $EF

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map32Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15C670, $4C

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map32Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $15C6BC, $50

; LZSS-compressed: 112 bytes that expand to 360 (E-0016, E-0017)
Map32Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15C70C, $70

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map32Attrs2_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15C77C, $63

Map32Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $15C7DF, $70

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
Map32Attrs2_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $15C84F, $53

; compressed tileset of map $33 (the first map record using it)
; LZSS-compressed: 729 bytes that expand to 1120 (E-0016, E-0017)
Map33Tileset::
    INCBIN "dwm2-cobi-us.gbc", $15C8A2, $2D9

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map33Screens0::
    dfar Map33Screens0_Y0X0 ; entry 0
    dfar Map33Screens0_Y1X0 ; entry 1

Map33Attrs0::
    dfar Map33Attrs0_Y0X0 ; entry 0
    dfar Map33Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
Map33Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15CB87, $A6

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
Map33Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15CC2D, $76

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map33Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15CCA3, $48

; LZSS-compressed: 25 bytes that expand to 360 (E-0016, E-0017)
Map33Attrs0_Y1X0::
    db $68, $01, $01, $00, $00, $02, $01, $02, $0b, $01, $fe, $ff, $4d, $01, $5e, $0f
    db $4d, $01, $be, $0f, $4d, $01, $0a, $1f, $23

; compressed tileset of map $34 (the first map record using it)
; LZSS-compressed: 690 bytes that expand to 1216 (E-0016, E-0017)
Map34Tileset::
    INCBIN "dwm2-cobi-us.gbc", $15CD04, $2B2

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map34Screens0::
    dfar Map34Screens0_Y0X0 ; entry 0

Map34Attrs0::
    dfar Map34Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
Map34Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15CFBC, $BD

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map34Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15D079, $4E

; compressed tileset of map $35 (the first map record using it)
; LZSS-compressed: 739 bytes that expand to 992 (E-0016, E-0017)
Map35Tileset::
    INCBIN "dwm2-cobi-us.gbc", $15D0C7, $2E3

; 16 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map35Screens0::
    dfar Map35Screens0_Y0X0 ; entry 0
    dfar Map35Screens0_Y0X1 ; entry 1
    dfar Map35Screens0_Y0X2 ; entry 2
    dfar Map35Screens0_Y0X3 ; entry 3
    dfar Map35Screens0_Y1X0 ; entry 4
    dfar Map35Screens0_Y1X1 ; entry 5
    dfar Map35Screens0_Y1X2 ; entry 6
    dfar Map35Screens0_Y1X3 ; entry 7
    dfar Map35Screens0_Y2X0 ; entry 8
    dfar Map35Screens0_Y2X1 ; entry 9
    dfar Map35Screens0_Y2X2 ; entry 10
    dfar Map35Screens0_Y2X3 ; entry 11
    dfar Map35Screens0_Y3X0 ; entry 12
    dfar Map35Screens0_Y3X1 ; entry 13
    dfar Map35Screens0_Y3X2 ; entry 14
    dfar Map35Screens0_Y3X3 ; entry 15

Map35Attrs0::
    dfar Map35Attrs0_Y0X0 ; entry 0
    dfar Map35Attrs0_Y0X1 ; entry 1
    dfar Map35Attrs0_Y0X2 ; entry 2
    dfar Map35Attrs0_Y0X3 ; entry 3
    dfar Map35Attrs0_Y1X0 ; entry 4
    dfar Map35Attrs0_Y1X1 ; entry 5
    dfar Map35Attrs0_Y1X2 ; entry 6
    dfar Map35Attrs0_Y1X3 ; entry 7
    dfar Map35Attrs0_Y2X0 ; entry 8
    dfar Map35Attrs0_Y2X1 ; entry 9
    dfar Map35Attrs0_Y2X2 ; entry 10
    dfar Map35Attrs0_Y2X3 ; entry 11
    dfar Map35Attrs0_Y3X0 ; entry 12
    dfar Map35Attrs0_Y3X1 ; entry 13
    dfar Map35Attrs0_Y3X2 ; entry 14
    dfar Map35Attrs0_Y3X3 ; entry 15

; LZSS-compressed: 237 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15D40A, $ED

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $15D4F7, $CB

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $15D5C2, $CE

; LZSS-compressed: 233 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y0X3::
    INCBIN "dwm2-cobi-us.gbc", $15D690, $E9

; LZSS-compressed: 188 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15D779, $BC

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $15D835, $92

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $15D8C7, $C5

; LZSS-compressed: 199 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y1X3::
    INCBIN "dwm2-cobi-us.gbc", $15D98C, $C7

Map35Screens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $15DA53, $BC

; LZSS-compressed: 219 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $15DB0F, $DB

; LZSS-compressed: 241 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $15DBEA, $F1

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y2X3::
    INCBIN "dwm2-cobi-us.gbc", $15DCDB, $D7

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y3X0::
    INCBIN "dwm2-cobi-us.gbc", $15DDB2, $A6

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $15DE58, $D6

; LZSS-compressed: 219 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y3X2::
    INCBIN "dwm2-cobi-us.gbc", $15DF2E, $DB

; LZSS-compressed: 247 bytes that expand to 360 (E-0016, E-0017)
Map35Screens0_Y3X3::
    INCBIN "dwm2-cobi-us.gbc", $15E009, $F7

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15E100, $54

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $15E154, $4B

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $15E19F, $4E

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y0X3::
    INCBIN "dwm2-cobi-us.gbc", $15E1ED, $5E

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15E24B, $45

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y1X1::
    db $68, $01, $02, $02, $ff, $f2, $01, $02, $06, $01, $02, $f8, $ff, $09, $02, $06
    db $02, $02, $1a, $0f, $0f, $03, $02, $50, $03, $02, $44, $0f, $0d, $02, $28, $08
    db $02, $83, $0f, $4d, $02, $28, $0c, $02, $e0, $0f, $4b, $02, $72, $0f, $01, $00
    db $00

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y1X2::
    db $68, $01, $02, $02, $ff, $f0, $01, $02, $04, $01, $02, $00, $0f, $19, $03, $02
    db $36, $01, $02, $28, $0f, $0b, $02, $08, $02, $02, $fc, $fa, $02, $5a, $06, $02
    db $54, $04, $02, $6c, $0f, $19, $02, $06, $0a, $02, $a6, $0f, $0b, $02, $d7, $0f
    db $4d, $02, $a8, $0f, $1d

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y1X3::
    INCBIN "dwm2-cobi-us.gbc", $15E2F6, $4A

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $15E340, $42

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $15E382, $48

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $15E3CA, $51

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y2X3::
    INCBIN "dwm2-cobi-us.gbc", $15E41B, $44

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y3X0::
    db $68, $01, $02, $02, $ff, $f0, $01, $02, $04, $0b, $02, $00, $0f, $11, $03, $03
    db $03, $03, $02, $28, $0f, $0f, $03, $03, $02, $10, $0e, $02, $5e, $0f, $01, $02
    db $0e, $0f, $17, $02, $88, $0f, $31, $02, $02, $06, $02, $f8, $ff, $01, $02, $a0
    db $ff, $43

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $15E491, $54

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y3X2::
    INCBIN "dwm2-cobi-us.gbc", $15E4E5, $4D

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map35Attrs0_Y3X3::
    INCBIN "dwm2-cobi-us.gbc", $15E532, $4B

; compressed tileset of map $37 (the first map record using it)
; LZSS-compressed: 1166 bytes that expand to 1776 (E-0016, E-0017)
Map37Tileset::
    INCBIN "dwm2-cobi-us.gbc", $15E57D, $48E

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map37Screens0::
    dfar Map37Screens0_Y0X0 ; entry 0
    dfar Map37Screens0_Y0X1 ; entry 1
    dfar Map37Screens0_Y0X2 ; entry 2

Map37Attrs0::
    dfar Map37Attrs0_Y0X0 ; entry 0
    dfar Map37Attrs0_Y0X1 ; entry 1
    dfar Map37Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 266 bytes that expand to 360 (E-0016, E-0017)
Map37Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15EA1D, $10A

; LZSS-compressed: 309 bytes that expand to 360 (E-0016, E-0017)
Map37Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $15EB27, $135

; LZSS-compressed: 277 bytes that expand to 360 (E-0016, E-0017)
Map37Screens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $15EC5C, $115

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
Map37Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15ED71, $57

; LZSS-compressed: 115 bytes that expand to 360 (E-0016, E-0017)
Map37Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $15EDC8, $73

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
Map37Attrs0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $15EE3B, $5B

; compressed tileset of map $38 (the first map record using it)
; LZSS-compressed: 656 bytes that expand to 1536 (E-0016, E-0017)
Map38Tileset::
    INCBIN "dwm2-cobi-us.gbc", $15EE96, $290

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map38Palettes::
    dw $6080, $7fff, $6301, $0000 ; entry 0
    dw $01c8, $3f7f, $46ad, $0002 ; entry 1
    dw $001b, $2bff, $023f, $0000 ; entry 2
    dw $0108, $3f7f, $0216, $0002 ; entry 3
    dw $00d0, $7fff, $191f, $0063 ; entry 4
    dw $4f18, $3a52, $218c, $0ca5 ; entry 5
    dw $4f18, $3a52, $218c, $0ca5 ; entry 6
    dw $4f18, $3a52, $218c, $0ca5 ; entry 7

; 16 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map38Screens0::
    dfar Map38Screens0_Y0X0 ; entry 0
    dfar Map38Screens0_Y0X1 ; entry 1
    dfar Map38Screens0_Y0X2 ; entry 2
    dfar Map38Screens0_Y0X3 ; entry 3
    dfar Map38Screens0_Y1X0 ; entry 4
    dfar Map38Screens0_Y1X1 ; entry 5
    dfar Map38Screens0_Y1X2 ; entry 6
    dfar Map38Screens0_Y1X3 ; entry 7
    dfar Map38Screens0_Y2X0 ; entry 8
    dfar Map38Screens0_Y2X1 ; entry 9
    dfar Map38Screens0_Y2X2 ; entry 10
    dfar Map38Screens0_Y2X3 ; entry 11
    dfar Map38Screens0_Y3X0 ; entry 12
    dfar Map38Screens0_Y3X1 ; entry 13
    dfar Map38Screens0_Y3X2 ; entry 14
    dfar Map38Screens0_Y3X3 ; entry 15

Map38Attrs0::
    dfar Map38Attrs0_Y0X0 ; entry 0
    dfar Map38Attrs0_Y0X1 ; entry 1
    dfar Map38Attrs0_Y0X2 ; entry 2
    dfar Map38Attrs0_Y0X3 ; entry 3
    dfar Map38Attrs0_Y1X0 ; entry 4
    dfar Map38Attrs0_Y1X1 ; entry 5
    dfar Map38Attrs0_Y1X2 ; entry 6
    dfar Map38Attrs0_Y1X3 ; entry 7
    dfar Map38Attrs0_Y2X0 ; entry 8
    dfar Map38Attrs0_Y2X1 ; entry 9
    dfar Map38Attrs0_Y2X2 ; entry 10
    dfar Map38Attrs0_Y2X3 ; entry 11
    dfar Map38Attrs0_Y3X0 ; entry 12
    dfar Map38Attrs0_Y3X1 ; entry 13
    dfar Map38Attrs0_Y3X2 ; entry 14
    dfar Map38Attrs0_Y3X3 ; entry 15

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y0X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $15F1D9, $81

Map38Screens0_Y0X2::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

Map38Screens0_Y0X3::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15F280, $BF

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $15F33F, $9F

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $15F3DE, $99

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y1X3::
    INCBIN "dwm2-cobi-us.gbc", $15F477, $B6

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y2X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $15F540, $93

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $15F5D3, $95

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y2X3::
    INCBIN "dwm2-cobi-us.gbc", $15F668, $B0

Map38Screens0_Y3X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

Map38Screens0_Y3X1::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y3X2::
    INCBIN "dwm2-cobi-us.gbc", $15F73E, $94

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map38Screens0_Y3X3::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

Map38Attrs0_Y0X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map38Attrs0_Y0X1::
    db $68, $01, $02, $02, $ff, $f2, $10, $02, $b7, $ff, $3c, $01, $02, $56, $03, $02
    db $4a, $0f, $0b, $02, $56, $00, $03, $03, $03, $03, $02, $5a, $08, $02, $7c, $0f
    db $03, $02, $80, $00, $02, $80, $0a, $02, $a4, $0f, $0b, $02, $82, $00, $02, $c6
    db $0f, $4d, $02, $ea, $0f, $05, $02, $5c, $02, $02, $44, $1c

Map38Attrs0_Y0X2::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

Map38Attrs0_Y0X3::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
Map38Attrs0_Y1X0::
    db $68, $01, $02, $02, $ff, $f0, $01, $02, $04, $09, $02, $fe, $ff, $05, $02, $04
    db $00, $03, $02, $2e, $05, $02, $0e, $02, $02, $2a, $0f, $03, $02, $2e, $06, $02
    db $2e, $02, $02, $50, $0f, $4d, $02, $88, $0f, $1d, $02, $2c, $0f, $13, $02, $02
    db $0f, $15, $02, $41, $1f, $13

Map38Attrs0_Y1X1::
    db $68, $01, $02, $00, $00, $01, $01, $01, $01, $03, $02, $06, $07, $01, $01, $02
    db $00, $0f, $01, $02, $02, $0c, $02, $22, $04, $02, $2c, $0c, $02, $4f, $0f, $4d
    db $02, $90, $0f, $2d, $02, $28, $0f, $15, $02, $00, $0e, $02, $16, $1f, $05, $02
    db $00, $00, $02, $32, $1f, $0f

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map38Attrs0_Y1X2::
    db $68, $01, $02, $01, $02, $00, $07, $02, $f8, $ff, $09, $03, $02, $28, $05, $02
    db $06, $06, $02, $28, $0f, $0b, $02, $2e, $06, $02, $50, $0f, $0f, $02, $2e, $02
    db $02, $78, $0f, $4d, $02, $9c, $0e, $02, $5e, $0f, $13, $02, $48, $0f, $01, $02
    db $24, $1f, $03, $02, $22, $0c, $02, $4a, $16

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map38Attrs0_Y1X3::
    db $68, $01, $02, $02, $ff, $ff, $19, $01, $02, $2c, $07, $02, $24, $0f, $07, $02
    db $2c, $00, $03, $02, $56, $03, $02, $34, $04, $02, $52, $0f, $03, $02, $56, $04
    db $02, $5a, $02, $02, $76, $0f, $2f, $02, $54, $0f, $13, $02, $50, $06, $02, $34
    db $0c, $02, $f8, $0c, $02, $78, $04, $02, $12, $18, $02, $1c, $1f, $25

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map38Attrs0_Y2X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map38Attrs0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $15F950, $41

Map38Attrs0_Y2X2::
    db $68, $01, $02, $03, $02, $00, $07, $01, $02, $0c, $03, $02, $00, $0f, $0d, $02
    db $33, $0f, $4d, $02, $68, $0f, $21, $02, $24, $0f, $01, $02, $24, $0f, $01, $00
    db $00, $02, $de, $0f, $17, $02, $12, $06, $02, $0c, $02, $02, $18, $1f, $03, $02
    db $f0, $08, $02, $3e, $12, $02, $40, $1f, $01

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map38Attrs0_Y2X3::
    db $68, $01, $02, $01, $02, $00, $03, $03, $03, $03, $03, $02, $00, $02, $02, $fe
    db $ff, $03, $02, $08, $00, $02, $28, $08, $02, $24, $0f, $4d, $02, $70, $0f, $2b
    db $02, $22, $0f, $01, $02, $22, $0c, $02, $0c, $04, $02, $ee, $0f, $03, $02, $00
    db $04, $02, $fc, $04, $02, $14, $1f, $05, $02, $3f, $1f, $15

Map38Attrs0_Y3X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

Map38Attrs0_Y3X1::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map38Attrs0_Y3X2::
    db $68, $01, $02, $02, $ff, $f0, $01, $01, $03, $02, $06, $03, $01, $01, $02, $fc
    db $ff, $07, $01, $01, $02, $04, $08, $02, $0e, $02, $02, $2a, $0e, $02, $2a, $08
    db $02, $32, $04, $02, $50, $0f, $03, $02, $54, $08, $02, $32, $04, $02, $7a, $0f
    db $4d, $02, $da, $0f, $4d, $02, $fe, $0f, $07

Map38Attrs0_Y3X3::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35
    ds $588, $00
