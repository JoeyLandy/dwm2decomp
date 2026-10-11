SECTION "Bank 52", ROMX[$4000], BANK[$52]
    db $52

; compressed tileset of map $73 (the first map record using it)
; LZSS-compressed asset: 1346 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map73Tileset:: ; heuristic: map tileset stream; C0
Data_052_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $148001, $542

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map73Palettes::
Data_052_4543:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $48EC, $6BFF, $4A6F, $0000 ; entry 1
    dw $0263, $3F7F, $03E7, $00A0 ; entry 2
    dw $0130, $36DE, $1E7E, $0000 ; entry 3
    dw $0189, $535E, $35F3, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $484C, $7FFF, $2BFF, $0000 ; entry 6
    dw $00A0, $00A0, $00A0, $00A0 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map73Screens0::
Data_052_4583:: ; address name
    dfar Data_052_459B ; entry 0
    dfar Data_052_4657 ; entry 1
    dfar Data_052_46FC ; entry 2
    dfar Data_052_47DF ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map73Attrs0::
Data_052_458F:: ; address name
    dfar Data_052_489E ; entry 0
    dfar Data_052_48E8 ; entry 1
    dfar Data_052_492E ; entry 2
    dfar Data_052_497C ; entry 3

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_459B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14859B, $BC

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4657:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $148657, $A5

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_46FC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1486FC, $E3

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_47DF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1487DF, $BF

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_489E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14889E, $4A

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_48E8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1488E8, $46

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_492E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14892E, $4E

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_497C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14897C, $4B

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map74Screens0::
Data_052_49C7:: ; address name
    dfar Data_052_49DF ; entry 0
    dfar Data_052_4A9A ; entry 1
    dfar Data_052_4B33 ; entry 2
    dfar Data_052_4BFC ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map74Attrs0::
Data_052_49D3:: ; address name
    dfar Data_052_4CB1 ; entry 0
    dfar Data_052_4CFA ; entry 1
    dfar Data_052_4D38 ; entry 2
    dfar Data_052_4D7B ; entry 3

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_49DF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1489DF, $BB

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4A9A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $148A9A, $99

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4B33:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $148B33, $C9

; LZSS-compressed asset: 181 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4BFC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $148BFC, $B5

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4CB1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $148CB1, $49

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4CFA:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $01, $02, $00, $0B, $02, $FC, $FF, $15, $02, $0E, $00, $02, $28
    db $0F, $13, $02, $50, $0F, $03, $04, $02, $78, $07, $02, $70, $0F, $15, $02, $82
    db $04, $02, $A0, $0F, $01, $02, $6C, $0C, $02, $C4, $0F, $11, $02, $D2, $0F, $09
    db $02, $7A, $0A, $02, $12, $1F, $07, $02, $76, $06, $02, $36, $1F, $0B

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4D38:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $148D38, $43

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4D7B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $148D7B, $43

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map75Screens0::
Data_052_4DBE:: ; address name
    dfar Data_052_4DD6 ; entry 0
    dfar Data_052_4EBA ; entry 1
    dfar Data_052_4F8A ; entry 2
    dfar Data_052_503E ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map75Attrs0::
Data_052_4DCA:: ; address name
    dfar Data_052_50F2 ; entry 0
    dfar Data_052_5150 ; entry 1
    dfar Data_052_5197 ; entry 2
    dfar Data_052_51CD ; entry 3

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4DD6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $148DD6, $E4

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4EBA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $148EBA, $D0

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_4F8A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $148F8A, $B4

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_503E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14903E, $B4

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_50F2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1490F2, $5E

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5150:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $149150, $47

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5197:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $09, $04, $04, $04, $04, $00, $00, $0A, $00, $0C
    db $0F, $25, $00, $0E, $00, $00, $58, $02, $00, $4E, $0F, $0B, $00, $76, $0F, $3D
    db $00, $70, $0F, $01, $00, $D0, $0F, $07, $00, $10, $00, $00, $10, $06, $00, $F8
    db $0F, $01, $00, $56, $0F, $35

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_51CD:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $04, $04, $00, $44, $0F, $11, $04, $00
    db $7C, $01, $00, $54, $0A, $00, $7C, $0E, $00, $7C, $02, $00, $7C, $04, $00, $9C
    db $0F, $05, $00, $7C, $06, $00, $BE, $0F, $0F, $00, $CE, $0A, $00, $EE, $0F, $07
    db $00, $A8, $0A, $00, $16, $1F, $03, $00, $00, $0F, $15

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map76Screens0::
Data_052_5208:: ; address name
    dfar Data_052_5220 ; entry 0
    dfar Data_052_5316 ; entry 1
    dfar Data_052_53D2 ; entry 2
    dfar Data_052_549B ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map76Attrs0::
Data_052_5214:: ; address name
    dfar Data_052_5561 ; entry 0
    dfar Data_052_55DE ; entry 1
    dfar Data_052_5629 ; entry 2
    dfar Data_052_565E ; entry 3

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5220:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $149220, $F6

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5316:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $149316, $BC

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_53D2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1493D2, $C9

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_549B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14949B, $C6

; LZSS-compressed asset: 125 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5561:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $149561, $7D

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_55DE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1495DE, $4B

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5629:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $01, $0E, $02, $00, $0F, $01, $02, $15, $0F, $1B
    db $04, $04, $04, $04, $02, $46, $0F, $11, $02, $54, $00, $02, $7E, $06, $02, $78
    db $0F, $07, $02, $80, $0F, $13, $02, $7C, $08, $02, $C4, $0F, $0D, $02, $A4, $0F
    db $19, $02, $18, $1F, $31

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_565E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14965E, $42

; compressed tileset of map $77 (the first map record using it)
; LZSS-compressed asset: 1299 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map77Tileset:: ; heuristic: map tileset stream; C0
Data_052_56A0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1496A0, $513

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map77Palettes::
Data_052_5BB3:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $48EC, $6BFF, $4A6F, $0000 ; entry 1
    dw $00ED, $22BA, $11D4, $0000 ; entry 2
    dw $01C4, $3F7F, $0348, $0000 ; entry 3
    dw $7DA0, $3F7F, $01DA, $0000 ; entry 4
    dw $00ED, $7FFF, $11D4, $0000 ; entry 5
    dw $012F, $3FBF, $01D5, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map77Screens0::
Data_052_5BF3:: ; address name
    dfar Data_052_5C05 ; entry 0
    dfar Data_052_5D3E ; entry 1
    dfar Data_052_5D90 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map77Attrs0::
Data_052_5BFC:: ; address name
    dfar Data_052_5EC4 ; entry 0
    dfar Data_052_5F2B ; entry 1
    dfar Data_052_5F43 ; entry 2

; LZSS-compressed asset: 313 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5C05:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $149C05, $139

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5D3E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $149D3E, $52

; LZSS-compressed asset: 308 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5D90:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $149D90, $134

; LZSS-compressed asset: 103 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5EC4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $149EC4, $67

; LZSS-compressed asset: 24 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5F2B:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $29, $04, $01, $3C, $0F, $3C, $01, $A0, $FF, $4D
    db $01, $EB, $0F, $4D, $01, $4B, $1F, $09

; LZSS-compressed asset: 111 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_5F43:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $149F43, $6F

; compressed tileset of map $78 (the first map record using it)
; LZSS-compressed asset: 1374 bytes expand to 1520 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map78Tileset:: ; heuristic: map tileset stream; C0
Data_052_5FB2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $149FB2, $55E

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map78Palettes::
Data_052_6510:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $00ED, $7FFF, $11D4, $0000 ; entry 1
    dw $00ED, $22BA, $11D4, $0000 ; entry 2
    dw $01C4, $3F7F, $0348, $0000 ; entry 3
    dw $00ED, $3F7F, $01DA, $0000 ; entry 4
    dw $00ED, $033F, $34D9, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map78Screens0::
Data_052_6550:: ; address name
    dfar Data_052_6568 ; entry 0
    dfar Data_052_668F ; entry 1
    dfar Data_052_67B3 ; entry 2
    dfar Data_052_68EA ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map78Attrs0::
Data_052_655C:: ; address name
    dfar Data_052_6A0A ; entry 0
    dfar Data_052_6A65 ; entry 1
    dfar Data_052_6AEE ; entry 2
    dfar Data_052_6B5A ; entry 3

; LZSS-compressed asset: 295 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_6568:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14A568, $127

; LZSS-compressed asset: 292 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_668F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14A68F, $124

; LZSS-compressed asset: 311 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_67B3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14A7B3, $137

; LZSS-compressed asset: 288 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_68EA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14A8EA, $120

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_6A0A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14AA0A, $5B

; LZSS-compressed asset: 137 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_6A65:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14AA65, $89

; LZSS-compressed asset: 108 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_6AEE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14AAEE, $6C

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_6B5A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $03, $04, $04, $04, $04, $00, $00, $04, $00, $00
    db $0F, $01, $02, $00, $28, $03, $00, $08, $00, $00, $30, $02, $00, $26, $0F, $4D
    db $00, $08, $02, $00, $30, $06, $00, $96, $0F, $33, $00, $2E, $02, $00, $F0, $0A
    db $00, $03, $1F, $4D, $00, $3C, $00

; compressed tileset of map $79 (the first map record using it)
; LZSS-compressed asset: 1106 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map79Tileset:: ; heuristic: map tileset stream; C0
Data_052_6B91:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14AB91, $452

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map79Palettes::
Data_052_6FE3:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $00ED, $3F7F, $11D4, $0000 ; entry 1
    dw $00ED, $22BA, $11D4, $0000 ; entry 2
    dw $00ED, $7FFF, $11D4, $0000 ; entry 3
    dw $00ED, $3F7F, $01DA, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map79Screens0::
Data_052_7023:: ; address name
    dfar Data_052_702F ; entry 0
    dfar Data_052_7148 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map79Attrs0::
Data_052_7029:: ; address name
    dfar Data_052_721D ; entry 0
    dfar Data_052_725B ; entry 1

; LZSS-compressed asset: 281 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_702F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14B02F, $119

; LZSS-compressed asset: 213 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_7148:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14B148, $D5

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_721D:: ; heuristic: map screen stream; C0
    db $68, $01, $04, $02, $04, $00, $02, $04, $F5, $FE, $02, $03, $04, $F5, $FE, $04
    db $1A, $08, $04, $FF, $FF, $00, $04, $FE, $FE, $01, $04, $12, $04, $04, $06, $07
    db $04, $5F, $05, $04, $06, $05, $04, $5E, $06, $04, $05, $06, $04, $85, $07, $04
    db $A2, $0F, $4D, $04, $17, $00, $03, $04, $04, $12, $04, $A6, $0F, $47

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_725B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $0A, $04, $04, $00, $0C, $0F, $01, $00, $32
    db $02, $00, $26, $0F, $35, $00, $7E, $0F, $49, $03, $03, $00, $DC, $02, $00, $DC
    db $08, $00, $F1, $0F, $4D, $00, $00, $0F, $03

; compressed tileset of map $7A (the first map record using it)
; LZSS-compressed asset: 1569 bytes expand to 1728 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map7ATileset:: ; heuristic: map tileset stream; C0
Data_052_7284:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14B284, $621

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map7APalettes::
Data_052_78A5:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $01A0, $3F7F, $03E7, $0000 ; entry 1
    dw $00ED, $3F7F, $01DA, $0000 ; entry 2
    dw $7D86, $3F7F, $01DA, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $00ED, $17E5, $01DA, $0000 ; entry 5
    dw $00ED, $7FFF, $01DA, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7AScreens0::
Data_052_78E5:: ; address name
    dfar Data_052_78F1 ; entry 0
    dfar Data_052_7A02 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7AAttrs0::
Data_052_78EB:: ; address name
    dfar Data_052_7B0B ; entry 0
    dfar Data_052_7B9C ; entry 1

; LZSS-compressed asset: 273 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_78F1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14B8F1, $111

; LZSS-compressed asset: 265 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_7A02:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14BA02, $109

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_7B0B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14BB0B, $91

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_052_7B9C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14BB9C, $4F

; compressed tileset of map $8B (the first map record using it)
; LZSS-compressed asset: 1042 bytes expand to 1344 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8BTileset:: ; heuristic: map tileset stream; C0
Data_052_7BEB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14BBEB, $415
