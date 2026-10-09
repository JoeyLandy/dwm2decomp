SECTION "Bank 5B", ROMX[$4000], BANK[$5B]
    INCBIN "dwm2-cobi-us.gbc", $16C000, $273
    dw Data_05B_428B
    db $5B
    dw Data_05B_4325
    db $5B
    dw Data_05B_43C9
    db $5B
    dw Data_05B_4475
    db $5B
    dw Data_05B_451A
    db $5B
    dw Data_05B_455C
    db $5B
    dw Data_05B_45A7
    db $5B
    dw Data_05B_45F4
    db $5B

; LZSS-compressed asset: 154 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_428B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16C28B, $9A

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4325:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16C325, $A4

; LZSS-compressed asset: 172 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_43C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16C3C9, $AC

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4475:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16C475, $A5

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_451A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16C51A, $42

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_455C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16C55C, $4B

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_45A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16C5A7, $4D

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_45F4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16C5F4, $5B2
    dw Data_05B_4BBE
    db $5B
    dw Data_05B_4CAE
    db $5B
    dw Data_05B_4D95
    db $5B
    dw Data_05B_4E7A
    db $5B
    dw Data_05B_4F77
    db $5B
    dw Data_05B_4FDA
    db $5B
    dw Data_05B_5051
    db $5B
    dw Data_05B_50CB
    db $5B

; LZSS-compressed asset: 240 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4BBE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16CBBE, $F0

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4CAE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16CCAE, $E7

; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4D95:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16CD95, $E5

; LZSS-compressed asset: 253 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4E7A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16CE7A, $FD

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4F77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16CF77, $63

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4FDA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16CFDA, $77

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_5051:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16D051, $7A

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_50CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16D0CB, $4F7
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $16D5D4, $B43
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $16E129, $3EF
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $16E52A, $1B9
    dw Data_05B_6713
    db $5B
    dw Data_05B_6755
    db $5B
    dw Data_05B_6819
    db $5B
    dw Data_05B_6844
    db $5B
    dw Data_05B_689D
    db $5B
    dw Data_05B_68B5
    db $5B
    dw Data_05B_6903
    db $5B
    dw Data_05B_691F
    db $5B
    dw Data_05B_6713
    db $5B
    dw Data_05B_67B7
    db $5B
    dw Data_05B_6819
    db $5B
    dw Data_05B_6844
    db $5B
    dw Data_05B_689D
    db $5B
    dw Data_05B_68DC
    db $5B
    dw Data_05B_6903
    db $5B
    dw Data_05B_691F
    db $5B

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6713:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16E713, $42

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6755:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16E755, $62

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_67B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16E7B7, $62

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6819:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $08, $09, $40, $41, $00, $02, $0C, $18, $19, $50, $51, $00, $16
    db $0C, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $45, $20, $21, $02
    db $03, $00, $42, $1C, $30, $31, $12, $13, $00, $56, $1C

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6844:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16E844, $59

; LZSS-compressed asset: 24 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_689D:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $05, $00, $52, $0D, $00, $50, $0F, $4D
    db $00, $B0, $0F, $4D, $00, $FC, $0F, $31

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_68B5:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $05, $00, $50, $01, $00, $4C, $04, $03
    db $03, $00, $54, $00, $00, $50, $0F, $0F, $00, $52, $02, $00, $78, $0F, $4D, $00
    db $D8, $0F, $4D, $00, $FC, $0F, $09

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_68DC:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $05, $00, $50, $01, $00, $4C, $04, $03
    db $03, $00, $54, $00, $00, $50, $0F, $0F, $00, $52, $02, $00, $78, $0F, $4D, $00
    db $D8, $0F, $4D, $00, $FC, $0F, $09

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6903:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $02, $05, $00, $02, $0D, $00, $00, $0F, $4D, $00, $60, $0F
    db $4D, $00, $C0, $0F, $4D, $00, $D0, $0A, $00, $40, $1F, $13

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_691F:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $05, $00, $00, $01, $02, $02, $02, $02, $00, $00, $02, $00, $04
    db $00, $00, $00, $0F, $4D, $00, $10, $06, $00, $78, $08, $00, $76, $0F, $35, $01
    db $01, $00, $C0, $0F, $13, $00, $6E, $0F, $33, $00, $3E, $1F, $15
    dw Data_05B_6964
    db $5B
    dw Data_05B_69A8
    db $5B
    dw Data_05B_6A42
    db $5B
    dw Data_05B_6AC3
    db $5B
    dw Data_05B_6B07
    db $5B
    dw Data_05B_6B26
    db $5B
    dw Data_05B_6B57
    db $5B
    dw Data_05B_6B90
    db $5B

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6964:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16E964, $44

; LZSS-compressed asset: 154 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_69A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16E9A8, $9A

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6A42:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16EA42, $81

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6AC3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16EAC3, $44

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6B07:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $05, $00, $52, $0D, $00, $50, $0F, $4D
    db $00, $B0, $0F, $4D, $00, $E8, $0F, $17, $00, $4A, $0F, $01, $00, $00, $02

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6B26:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $05, $00, $50, $01, $00, $4C, $04, $01
    db $01, $00, $54, $00, $00, $50, $0F, $0F, $00, $52, $02, $00, $78, $0F, $33, $00
    db $4C, $04, $00, $C6, $0F, $31, $00, $18, $18, $00, $16, $1F, $03, $00, $00, $0F
    db $15

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6B57:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $02, $02, $05, $01, $02, $07, $02, $01, $0E, $03, $01, $02, $0F
    db $35, $01, $08, $04, $01, $52, $0F, $2B, $00, $00, $01, $92, $0F, $15, $01, $A4
    db $0A, $01, $C8, $0F, $09, $01, $A4, $08, $01, $F0, $0F, $03, $03, $03, $01, $F8
    db $F4, $01, $10, $1F, $0B, $01, $40, $1F, $13

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6B90:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $05, $00, $50, $0D, $00, $4E, $0F, $4D
    db $00, $AE, $0F, $4D, $00, $D2, $0F, $0B, $00, $00, $0F, $15
    dw Data_05B_6BC4
    db $5B
    dw Data_05B_6C71
    db $5B
    dw Data_05B_6D17
    db $5B
    dw Data_05B_6DA6
    db $5B
    dw Data_05B_6E41
    db $5B
    dw Data_05B_6E7F
    db $5B
    dw Data_05B_6E9E
    db $5B
    dw Data_05B_6ECA
    db $5B

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6BC4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16EBC4, $AD

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6C71:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16EC71, $A6

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6D17:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16ED17, $8F

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6DA6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16EDA6, $9B

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6E41:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $40, $05, $00, $54, $05, $01, $01, $05, $05
    db $00, $4E, $0F, $11, $00, $54, $00, $00, $76, $0F, $0F, $00, $48, $0F, $01, $00
    db $48, $0E, $00, $46, $0F, $01, $00, $46, $0E, $00, $EC, $0C, $00, $F4, $0F, $0B
    db $00, $84, $06, $00, $1C, $1F, $0B, $00, $EA, $0F, $03, $00, $00, $00

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6E7F:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $42, $05, $00, $56, $05, $00, $4C, $0F, $4D
    db $00, $70, $0E, $00, $46, $0F, $01, $00, $60, $0F, $47, $00, $C8, $0F, $15

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6E9E:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $02, $02, $02, $05, $05, $05, $05, $00, $00, $00, $00, $08
    db $08, $00, $04, $0F, $2D, $00, $54, $04, $00, $4C, $0F, $31, $00, $10, $0F, $35
    db $00, $44, $0F, $05, $00, $F0, $0F, $35, $00, $40, $1F, $09

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6ECA:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $01, $05, $05, $05, $05, $00, $00, $02, $00, $0A
    db $06, $00, $06, $0F, $2D, $00, $56, $02, $00, $4C, $0F, $33, $00, $00, $0F, $37
    db $00, $56, $06, $00, $5A, $06, $00, $F0, $0F, $29, $00, $3C, $1F, $15
    dw Data_05B_6F10
    db $5B
    dw Data_05B_6FB3
    db $5B
    dw Data_05B_705C
    db $5B
    dw Data_05B_710B
    db $5B
    dw Data_05B_7198
    db $5B
    dw Data_05B_71D1
    db $5B
    dw Data_05B_7212
    db $5B
    dw Data_05B_7251
    db $5B

; LZSS-compressed asset: 163 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6F10:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16EF10, $A3

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6FB3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16EFB3, $A9

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_705C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16F05C, $AF

; LZSS-compressed asset: 141 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_710B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16F10B, $8D

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7198:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $46, $05, $00, $5A, $03, $00, $4E, $0F, $0B
    db $00, $5A, $04, $00, $74, $0F, $0B, $00, $80, $06, $00, $5E, $06, $00, $A6, $0E
    db $00, $A6, $0A, $00, $C6, $0F, $15, $00, $A0, $0F, $19, $00, $A4, $0F, $03, $00
    db $54, $08, $00, $4C, $0F, $01, $00, $00, $00

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_71D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16F1D1, $41

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7212:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $02, $01, $00, $05, $05, $01, $0A, $01, $01, $00, $06, $01, $06
    db $0F, $27, $01, $0A, $02, $01, $54, $04, $01, $4E, $0F, $0B, $01, $FA, $F2, $01
    db $0A, $06, $01, $7C, $0F, $29, $01, $52, $0A, $01, $4C, $0F, $01, $01, $00, $0C
    db $01, $EA, $0F, $0F, $01, $52, $06, $01, $16, $1F, $0D, $01, $3E, $1F, $0B

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7251:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $05, $00, $52, $09, $00, $4C, $0F, $05
    db $00, $52, $04, $03, $03, $00, $6E, $0F, $13, $00, $6C, $0F, $01, $00, $58, $0F
    db $07, $00, $4A, $0F, $01, $00, $4A, $0E, $00, $48, $0F, $01, $00, $48, $0E, $00
    db $46, $0F, $01, $00, $00, $0F, $1F
    dw Data_05B_72A0
    db $5B
    dw Data_05B_735A
    db $5B
    dw Data_05B_73CB
    db $5B
    dw Data_05B_7470
    db $5B
    dw Data_05B_7515
    db $5B
    dw Data_05B_7552
    db $5B
    dw Data_05B_7574
    db $5B
    dw Data_05B_75B0
    db $5B

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_72A0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16F2A0, $BA

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_735A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16F35A, $71

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_73CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16F3CB, $A5

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7470:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16F470, $A5

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7515:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $02, $03, $00, $0F, $48, $05, $05, $01, $01, $05, $05, $03, $4E
    db $0F, $11, $00, $00, $03, $74, $0F, $0D, $05, $05, $03, $84, $02, $03, $9C, $0F
    db $0F, $03, $AC, $0C, $03, $CE, $0F, $05, $03, $F8, $02, $03, $EC, $0F, $09, $03
    db $84, $00, $03, $86, $0C, $03, $1C, $1F, $03, $03, $FA, $0F, $0F

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7552:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $42, $05, $00, $56, $03, $00, $4A, $0F, $15
    db $00, $5C, $08, $00, $7E, $0F, $4D, $00, $B6, $0F, $21, $00, $4A, $0F, $29, $00
    db $00, $02

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7574:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $02, $02, $02, $02, $05, $01, $04, $03, $01, $00, $00, $01, $0C
    db $04, $01, $04, $0F, $2D, $00, $00, $01, $08, $0A, $01, $54, $0F, $01, $01, $52
    db $0F, $23, $01, $0A, $06, $01, $A8, $0F, $01, $01, $52, $0F, $1D, $01, $08, $0F
    db $11, $01, $02, $04, $01, $18, $1F, $0F, $01, $40, $1F, $07

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_75B0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16F5B0, $2C9
    ds $787, $00
