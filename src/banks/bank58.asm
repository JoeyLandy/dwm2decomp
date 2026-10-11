SECTION "Bank 58", ROMX[$4000], BANK[$58]
    db $58

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map32Palettes::
Data_058_4001:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $218C, $4F18, $3A52, $0000 ; entry 1
    dw $02C0, $3F7F, $03E2, $0000 ; entry 2
    dw $010E, $3F7F, $0216, $0000 ; entry 3
    dw $0192, $3F7F, $03E2, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $7C01, $7FFF, $56B5, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map33Palettes::
Data_058_4041:: ; heuristic: map BG palettes; C0
    dw $4044, $7FFF, $0216, $0000 ; entry 0
    dw $01C2, $7FFF, $0216, $0000 ; entry 1
    dw $010E, $3F7F, $0216, $0002 ; entry 2
    dw $1092, $39DC, $108C, $0084 ; entry 3
    dw $4908, $7FFF, $6250, $0CA5 ; entry 4
    dw $4F18, $3A52, $218C, $0CA5 ; entry 5
    dw $4F18, $3A52, $3BFF, $0CA5 ; entry 6
    dw $4F18, $3A52, $218C, $0CA5 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map34Palettes::
Data_058_4081:: ; heuristic: map BG palettes; C0
    dw $1528, $7FFF, $6B2B, $0000 ; entry 0
    dw $010E, $7BDE, $22BA, $0000 ; entry 1
    dw $010E, $22BA, $11D4, $0000 ; entry 2
    dw $010E, $3F7F, $0216, $0000 ; entry 3
    dw $698B, $4F18, $1648, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map35Palettes::
Data_058_40C1:: ; heuristic: map BG palettes; C0
    dw $6080, $7FFF, $6301, $0000 ; entry 0
    dw $0152, $3F7F, $025E, $0002 ; entry 1
    dw $001B, $2BFF, $023F, $0000 ; entry 2
    dw $00CF, $3F7F, $0176, $0002 ; entry 3
    dw $4F18, $3A52, $218C, $0CA5 ; entry 4
    dw $4F18, $3A52, $218C, $0CA5 ; entry 5
    dw $4F18, $3A52, $218C, $0CA5 ; entry 6
    dw $4F18, $3A52, $218C, $0CA5 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map36Palettes::
Data_058_4101:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $7DA0, $4F18, $260C, $0000 ; entry 1
    dw $7DA0, $4F18, $7FE0, $0000 ; entry 2
    dw $0941, $4F18, $1627, $0000 ; entry 3
    dw $7DA0, $7FFF, $5AD6, $0000 ; entry 4
    dw $012F, $4F3A, $01D5, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map37Palettes::
Data_058_4141:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $6301, $0000 ; entry 0
    dw $012F, $4F18, $01D8, $0000 ; entry 1
    dw $012F, $3FBF, $01D5, $0000 ; entry 2
    dw $0941, $3AF3, $1627, $0000 ; entry 3
    dw $0949, $4EF5, $2DCD, $0000 ; entry 4
    dw $012F, $3AF3, $01D5, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of map $40 (the first map record using it)
; LZSS-compressed asset: 1062 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map40Tileset:: ; heuristic: map tileset stream; C0
Data_058_4181:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $160181, $426

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map40Palettes::
Data_058_45A7:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $28C8, $3FBF, $4192, $0000 ; entry 1
    dw $3108, $72DC, $4992, $0CA5 ; entry 2
    dw $0106, $4F18, $020C, $0000 ; entry 3
    dw $2084, $2A56, $394A, $0000 ; entry 4
    dw $0106, $677A, $0210, $0000 ; entry 5
    dw $7DA0, $7FFF, $5AD6, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0CA5 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map40Screens0::
Data_058_45E7:: ; heuristic: map screen array; C0
    dfar Data_058_45FF ; entry 0
    dfar Data_058_49AA ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map40Attrs0::
Data_058_45ED:: ; heuristic: map screen array; C0
    dfar Data_058_4BB3 ; entry 0
    dfar Data_058_4D92 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map40Screens2::
Data_058_45F3:: ; heuristic: map screen array; C0
    dfar Data_058_48EE ; entry 0
    dfar Data_058_4ABC ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map40Attrs2::
Data_058_45F9:: ; heuristic: map screen array; C0
    dfar Data_058_4D3C ; entry 0
    dfar Data_058_4E17 ; entry 1

; LZSS-compressed asset: 263 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_45FF:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1605FF, $107

; LZSS-compressed asset: 245 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4706:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $160706, $F5

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_47FB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1607FB, $F3

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_48EE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1608EE, $BC

; LZSS-compressed asset: 274 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_49AA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1609AA, $112

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4ABC:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $160ABC, $F7

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4BB3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $160BB3, $8F

; LZSS-compressed asset: 137 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4C42:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $160C42, $89

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4CCB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $160CCB, $71

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4D3C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $160D3C, $56

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4D92:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $160D92, $85

; LZSS-compressed asset: 106 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4E17:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $160E17, $6A

; compressed tileset of map $41 (the first map record using it)
; LZSS-compressed asset: 1379 bytes expand to 1648 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map41Tileset:: ; heuristic: map tileset stream; C0
Data_058_4E81:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $160E81, $563

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map41Palettes::
Data_058_53E4:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $5AD6, $7FFF, $7FE0, $0063 ; entry 1
    dw $4CF4, $3FBF, $6238, $0000 ; entry 2
    dw $7DA0, $3FBF, $6238, $0000 ; entry 3
    dw $4CF4, $7FE0, $6238, $0000 ; entry 4
    dw $0116, $03FF, $01FC, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map41Screens0::
Data_058_5424:: ; heuristic: map screen array; C0
    dfar Data_058_5430 ; entry 0
    dfar Data_058_5562 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map41Attrs0::
Data_058_542A:: ; heuristic: map screen array; C0
    dfar Data_058_568A ; entry 0
    dfar Data_058_570E ; entry 1

; LZSS-compressed asset: 306 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_5430:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $161430, $132

; LZSS-compressed asset: 296 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_5562:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $161562, $128

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_568A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16168A, $84

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_570E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16170E, $77

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map42Screens0::
Data_058_5785:: ; heuristic: map screen array; C0
    dfar Data_058_5797 ; entry 0
    dfar Data_058_58B3 ; entry 1
    dfar Data_058_59C5 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map42Attrs0::
Data_058_578E:: ; heuristic: map screen array; C0
    dfar Data_058_5AC9 ; entry 0
    dfar Data_058_5AF6 ; entry 1
    dfar Data_058_5B36 ; entry 2

; LZSS-compressed asset: 284 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_5797:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $161797, $11C

; LZSS-compressed asset: 274 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_58B3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1618B3, $112

; LZSS-compressed asset: 260 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_59C5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1619C5, $104

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_5AC9:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $05, $05, $00, $00, $06, $00, $0B, $0F, $08, $06
    db $00, $30, $01, $03, $03, $05, $00, $0A, $07, $00, $30, $0F, $01, $00, $4E, $0F
    db $3F, $00, $4C, $0F, $01, $00, $4C, $0F, $4B, $00, $4E, $0F, $39

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_5AF6:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $03, $03, $03, $03, $05, $02, $00, $00, $02, $03, $02, $02, $04
    db $02, $02, $10, $0F, $02, $01, $01, $02, $28, $02, $02, $10, $08, $02, $FE, $F0
    db $02, $FE, $F2, $02, $34, $0F, $0B, $05, $05, $02, $64, $02, $02, $1E, $0F, $29
    db $06, $06, $02, $5C, $0E, $02, $AA, $08, $02, $C9, $0F, $4D, $02, $08, $1F, $2B

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_5B36:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $03, $03, $03, $05, $00, $00, $00, $00, $03, $02, $00, $04
    db $02, $00, $10, $0F, $10, $05, $00, $0F, $0F, $00, $00, $38, $0F, $29, $00, $10
    db $0F, $13, $02, $02, $02, $02, $00, $9E, $0F, $07, $00, $60, $0F, $3B, $00, $08
    db $1F, $3B

; compressed tileset of map $44 (the first map record using it)
; LZSS-compressed asset: 1164 bytes expand to 1568 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map44Tileset:: ; heuristic: map tileset stream; C0
Data_058_5B68:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $161B68, $48C

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map44Palettes::
Data_058_5FF4:: ; heuristic: map BG palettes; C0
    dw $294A, $7FFF, $4F18, $0000 ; entry 0
    dw $012F, $4F18, $01D8, $0000 ; entry 1
    dw $012F, $3FBF, $01D5, $0000 ; entry 2
    dw $0941, $3AF3, $1627, $0000 ; entry 3
    dw $1410, $02D7, $4D15, $0000 ; entry 4
    dw $012F, $3AF3, $01D8, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map44Screens0::
Data_058_6034:: ; heuristic: map screen array; C0
    dfar Data_058_603A ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map44Attrs0::
Data_058_6037:: ; heuristic: map screen array; C0
    dfar Data_058_614D ; entry 0

; LZSS-compressed asset: 275 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_603A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16203A, $113

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_614D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16214D, $77

; compressed tileset of map $A0 (the first map record using it)
; LZSS-compressed asset: 974 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA0Tileset:: ; heuristic: map tileset stream; C0
Data_058_61C4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1621C4, $3CE

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapA0Palettes::
Data_058_6592:: ; heuristic: map BG palettes; C0
    dw $0173, $7FFF, $0235, $0063 ; entry 0
    dw $0110, $51CE, $0235, $0063 ; entry 1
    dw $0142, $03FF, $034E, $0000 ; entry 2
    dw $0110, $03FF, $034E, $0000 ; entry 3
    dw $384E, $03FF, $5956, $0000 ; entry 4
    dw $300C, $35B8, $4812, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA0Screens0::
Data_058_65D2:: ; heuristic: map screen array; C0
    dfar Data_058_6662 ; entry 0
    dfar Data_058_66AF ; entry 1
    dfar Data_058_6754 ; entry 2
    dfar Data_058_6770 ; entry 3
    dfar Data_058_678C ; entry 4
    dfar Data_058_680C ; entry 5
    dfar Data_058_69D1 ; entry 6
    dfar Data_058_6A7F ; entry 7
    dfar Data_058_6A9B ; entry 8
    dfar Data_058_6B05 ; entry 9
    dfar Data_058_6BE5 ; entry 10
    dfar Data_058_6C69 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA0Attrs0::
Data_058_65F6:: ; heuristic: map screen array; C0
    dfar Data_058_6C85 ; entry 0
    dfar Data_058_6CAA ; entry 1
    dfar Data_058_6CEA ; entry 2
    dfar Data_058_6CFE ; entry 3
    dfar Data_058_6D12 ; entry 4
    dfar Data_058_6D42 ; entry 5
    dfar Data_058_6DE9 ; entry 6
    dfar Data_058_6E22 ; entry 7
    dfar Data_058_6E36 ; entry 8
    dfar Data_058_6E5F ; entry 9
    dfar Data_058_6EB3 ; entry 10
    dfar Data_058_6EE0 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA0Screens1::
Data_058_661A:: ; heuristic: map screen array; C0
    dfar Data_058_6662 ; entry 0
    dfar Data_058_66AF ; entry 1
    dfar Data_058_6754 ; entry 2
    dfar Data_058_6770 ; entry 3
    dfar Data_058_678C ; entry 4
    dfar Data_058_68F2 ; entry 5
    dfar Data_058_69D1 ; entry 6
    dfar Data_058_6A7F ; entry 7
    dfar Data_058_6A9B ; entry 8
    dfar Data_058_6B05 ; entry 9
    dfar Data_058_6BE5 ; entry 10
    dfar Data_058_6C69 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA0Attrs1::
Data_058_663E:: ; heuristic: map screen array; C0
    dfar Data_058_6C85 ; entry 0
    dfar Data_058_6CAA ; entry 1
    dfar Data_058_6CEA ; entry 2
    dfar Data_058_6CFE ; entry 3
    dfar Data_058_6D12 ; entry 4
    dfar Data_058_6D97 ; entry 5
    dfar Data_058_6DE9 ; entry 6
    dfar Data_058_6E22 ; entry 7
    dfar Data_058_6E36 ; entry 8
    dfar Data_058_6E5F ; entry 9
    dfar Data_058_6EB3 ; entry 10
    dfar Data_058_6EE0 ; entry 11

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6662:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $162662, $4D

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_66AF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1626AF, $A5

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6754:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6770:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_678C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16278C, $80

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_680C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16280C, $E6

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_68F2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1628F2, $DF

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_69D1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1629D1, $AE

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6A7F:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 106 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6A9B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $162A9B, $6A

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6B05:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $162B05, $E0

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6BE5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $162BE5, $84

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6C69:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6C85:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $7A, $0F, $06
    db $02, $02, $00, $C8, $0F, $0F, $02, $00, $FE, $01, $00, $F0, $0F, $0D, $00, $FE
    db $02, $00, $16, $1F, $2B

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6CAA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $1E, $03, $03, $00, $20, $0F, $11, $02, $02
    db $02, $02, $00, $32, $0C, $00, $58, $0E, $00, $58, $00, $00, $58, $0C, $00, $7E
    db $0C, $00, $7E, $04, $00, $5A, $00, $00, $9A, $0F, $07, $00, $A2, $0F, $13, $00
    db $A0, $0A, $00, $76, $0C, $00, $F8, $0F, $01, $00, $AC, $06, $00, $16, $1F, $2B

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6CEA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6CFE:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6D12:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $07, $02, $00, $0C, $03, $00, $00, $0F, $0B, $00
    db $0C, $04, $00, $26, $0F, $0B, $00, $32, $06, $00, $4E, $0F, $0B, $00, $30, $0F
    db $15, $00, $08, $0F, $17, $00, $BE, $0F, $3F, $00, $0A, $04, $00, $18, $1F, $29

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6D42:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $162D42, $55

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6D97:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $162D97, $52

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6DE9:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $40, $02, $00, $54, $01, $00, $46, $0F, $0B
    db $00, $54, $02, $03, $03, $00, $56, $08, $00, $78, $0F, $05, $03, $00, $A4, $01
    db $00, $56, $06, $00, $A0, $0F, $2D, $00, $7C, $0F, $15, $00, $18, $16, $00, $12
    db $1F, $13, $00, $10, $1F, $01, $00, $00, $04

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6E22:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6E36:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $09, $02, $00, $0E, $01, $00, $00, $0F, $0D, $00
    db $0E, $02, $00, $26, $0F, $37, $00, $0C, $0F, $15, $00, $0A, $04, $00, $A0, $0F
    db $11, $00, $D7, $0F, $4D, $00, $08, $1F, $1D

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6E5F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $162E5F, $54

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6EB3:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $07, $01, $00, $0C, $03, $00, $00, $0F, $29, $00
    db $12, $06, $00, $48, $06, $00, $50, $0F, $03, $00, $10, $02, $00, $6E, $0C, $00
    db $7C, $0F, $03, $00, $A5, $0F, $4D, $00, $05, $1F, $4D, $01, $01

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6EE0:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; compressed tileset of map $A1 (the first map record using it)
; LZSS-compressed asset: 1332 bytes expand to 1664 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA1Tileset:: ; heuristic: map tileset stream; C0
Data_058_6EF4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $162EF4, $534

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapA1Palettes::
Data_058_7428:: ; heuristic: map BG palettes; C0
    dw $0160, $7FFF, $4A2D, $0000 ; entry 0
    dw $1154, $53DE, $229A, $0000 ; entry 1
    dw $0142, $03FF, $034E, $0000 ; entry 2
    dw $008C, $035F, $00DC, $0000 ; entry 3
    dw $350E, $773C, $4616, $0C69 ; entry 4
    dw $0160, $5AB1, $4A2D, $0000 ; entry 5
    dw $05A4, $53DE, $0E29, $0084 ; entry 6
    dw $7FFF, $7FFF, $7FFF, $7FFF ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA1Screens0::
Data_058_7468:: ; heuristic: map screen array; C0
    dfar Data_058_748C ; entry 0
    dfar Data_058_7616 ; entry 1
    dfar Data_058_772C ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA1Attrs0::
Data_058_7471:: ; heuristic: map screen array; C0
    dfar Data_058_781F ; entry 0
    dfar Data_058_7897 ; entry 1
    dfar Data_058_78F9 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA1Screens1::
Data_058_747A:: ; heuristic: map screen array; C0
    dfar Data_058_7585 ; entry 0
    dfar Data_058_7616 ; entry 1
    dfar Data_058_772C ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA1Attrs1::
Data_058_7483:: ; heuristic: map screen array; C0
    dfar Data_058_785E ; entry 0
    dfar Data_058_7897 ; entry 1
    dfar Data_058_78F9 ; entry 2

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_748C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16348C, $F9

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_7585:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $163585, $91

; LZSS-compressed asset: 278 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_7616:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $163616, $116

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_772C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16372C, $F3

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_781F:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $F0, $06, $02, $04, $07, $02, $FC, $FF, $4D, $02, $0C
    db $08, $02, $15, $03, $02, $F4, $FF, $01, $02, $F9, $F7, $03, $03, $02, $90, $0F
    db $13, $01, $01, $02, $7C, $06, $02, $A2, $01, $02, $C7, $0F, $10, $02, $CA, $01
    db $02, $EF, $0F, $04, $02, $7A, $08, $02, $12, $1F, $15, $02, $86, $0F, $07

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_785E:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $FF, $45, $06, $06, $02, $46, $0F, $12, $06, $06, $02
    db $58, $0E, $02, $7F, $0B, $03, $03, $02, $90, $0F, $13, $01, $01, $02, $7C, $06
    db $02, $A2, $01, $02, $C7, $0F, $10, $02, $CA, $01, $02, $EF, $0F, $04, $02, $7A
    db $08, $02, $12, $1F, $15, $02, $72, $0F, $07

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_7897:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $163897, $62

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_78F9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1638F9, $53
    ds $6B4, $00
