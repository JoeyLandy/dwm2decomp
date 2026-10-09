SECTION "Bank 51", ROMX[$4000], BANK[$51]
    INCBIN "dwm2-cobi-us.gbc", $144000, $97A
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "WXCDCDMN2 22 2mnSTSTABYZ"
    INCBIN "dwm2-cobi-us.gbc", $144992, $943
    dw Data_051_5416
    db $51, $BA, $58, $51
    dw Data_051_58ED
    db $51, $16, $54, $51
    dw Data_051_5940
    db $51, $6B, $59, $51
    dw Data_051_5996
    db $51, $CF, $59, $51
    dw Data_051_59FE
    db $51, $2D, $5A, $51
    dw Data_051_5A6B
    db $51, $AC, $5A, $51
    dw Data_051_5AE7
    db $51, $37, $5B, $51
    dw Data_051_5B83
    db $51
    dw Data_051_5BB8
    db $51, $16, $54, $51
    dw Data_051_5BE0
    db $51, $16, $54, $51
    dw Data_051_5C18
    db $51, $4A, $5C, $51
    dw Data_051_5C83
    db $51, $CC, $5C, $51
    dw Data_051_5D1E
    db $51, $42, $5D, $51
    dw Data_051_5D8E
    db $51, $E4, $5D, $51
    dw Data_051_5E28
    db $51, $16, $54, $51
    dw Data_051_5E69
    db $51, $93, $5E, $51
    dw Data_051_5EBC
    db $51, $F1, $5E, $51
    dw Data_051_5416
    db $51
    dw Data_051_5416
    db $51
    dw Data_051_5416
    db $51
    dw Data_051_5F20
    db $51
    dw Data_051_5F6F
    db $51
    dw Data_051_5FA9
    db $51
    dw Data_051_5FE2
    db $51
    dw Data_051_6029
    db $51
    dw Data_051_6059
    db $51
    dw Data_051_6089
    db $51
    dw Data_051_60C4
    db $51
    dw Data_051_6101
    db $51
    dw Data_051_5416
    db $51
    dw Data_051_5416
    db $51
    dw Data_051_5416
    db $51
    dw Data_051_6147
    db $51
    dw Data_051_616E
    db $51
    dw Data_051_61AC
    db $51
    dw Data_051_61E7
    db $51
    dw Data_051_6227
    db $51
    dw Data_051_6254
    db $51
    dw Data_051_629A
    db $51
    dw Data_051_62BF
    db $51
    dw Data_051_62F7
    db $51, $16, $54, $51, $16, $54, $51, $3B, $63, $51, $63, $63, $51
    dw Data_051_5416
    db $51
    dw Data_051_6399
    db $51
    dw Data_051_63C4
    db $51
    dw Data_051_6409
    db $51
    dw Data_051_6434
    db $51
    dw Data_051_6476
    db $51
    dw Data_051_64B4
    db $51
    dw Data_051_6511
    db $51, $16, $54, $51, $16, $54, $51, $4C, $65, $51, $83, $65, $51
    dw Data_051_5416
    db $51
    dw Data_051_5416
    db $51
    dw Data_051_65B6
    db $51
    dw Data_051_65EA
    db $51
    dw Data_051_661D
    db $51
    dw Data_051_666E
    db $51
    dw Data_051_66AB
    db $51
    dw Data_051_66F0
    db $51
    dw Data_051_6730
    db $51
    dw Data_051_6768
    db $51
    dw Data_051_67A7
    db $51
    dw Data_051_67F2
    db $51
    dw Data_051_6849
    db $51
    dw Data_051_687A
    db $51
    dw Data_051_68B1
    db $51
    dw Data_051_68EC
    db $51
    dw Data_051_6941
    db $51
    dw Data_051_5416
    db $51
    dw Data_051_5416
    db $51
    dw Data_051_698F
    db $51
    dw Data_051_69C5
    db $51
    dw Data_051_6A0B
    db $51
    dw Data_051_6A50
    db $51
    dw Data_051_6A82
    db $51
    dw Data_051_6AC5
    db $51
    dw Data_051_6B0E
    db $51
    dw Data_051_6B43
    db $51
    dw Data_051_6B86
    db $51
    dw Data_051_6BB7
    db $51, $16, $54, $51, $16, $54, $51, $16, $54, $51, $E3, $6B, $51, $24, $6C, $51

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5416:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145416, $4D7

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_58ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1458ED, $53

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5940:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145940, $56

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5996:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145996, $68

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_59FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1459FE, $6D

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5A6B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145A6B, $7C

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5AE7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145AE7, $9C

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5B83:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $03, $01, $00, $01, $02, $01, $06, $03, $01, $FA, $FF, $0B, $01
    db $06, $04, $01, $20, $0F, $35, $01, $2A, $0C, $01, $78, $0F, $11, $01, $06, $00
    db $01, $A0, $0F, $07, $01, $A4, $0A, $01, $C8, $0F, $4D, $01, $D8, $08, $01, $2A
    db $08, $01, $40, $1F, $01

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5BB8:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $40, $0F, $2D, $02, $02, $02, $02, $01
    db $90, $0F, $15, $01, $A0, $0C, $01, $C8, $0F, $09, $01, $A2, $08, $01, $F0, $0F
    db $0B, $01, $A2, $06, $01, $18, $1F, $29

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5BE0:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $F0, $02, $01, $04, $07, $01, $FC, $FF, $15, $01, $0E
    db $04, $01, $2C, $0E, $01, $2C, $0A, $01, $4C, $0F, $15, $01, $26, $0F, $07, $01
    db $02, $08, $01, $FA, $FF, $01, $01, $FA, $FE, $01, $F8, $FF, $01, $01, $F6, $FC
    db $01, $F2, $FF, $01, $01, $A0, $FF, $49

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5C18:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145C18, $6B

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5C83:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145C83, $9B

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5D1E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145D1E, $70

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5D8E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145D8E, $9A

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5E28:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145E28, $41

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5E69:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145E69, $53

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5EBC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145EBC, $64

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5F20:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145F20, $4F

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5F6F:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $3C, $02, $02, $02, $02, $00, $48, $06, $00
    db $4A, $0F, $0B, $00, $5C, $0C, $00, $78, $0F, $0B, $00, $7A, $0A, $00, $A4, $0F
    db $03, $00, $C8, $04, $00, $C2, $0F, $15, $00, $86, $08, $00, $F6, $0F, $0B, $00
    db $52, $00, $00, $18, $1F, $11, $00, $EC, $0F, $05

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5FA9:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $03, $02, $00, $08, $03, $00, $00, $04, $00, $04
    db $0F, $2B, $00, $0A, $0E, $00, $54, $0F, $01, $00, $08, $04, $00, $4A, $0E, $00
    db $0C, $0E, $01, $01, $00, $06, $02, $00, $9C, $0F, $0B, $00, $00, $06, $00, $C4
    db $0F, $13, $00, $FD, $0F, $4D, $00, $10, $06

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5FE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $145FE2, $47

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6029:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $43, $02, $02, $01, $44, $0F, $11, $02, $01, $7C
    db $01, $01, $78, $04, $01, $76, $0F, $03, $01, $7C, $02, $02, $02, $04, $04, $04
    db $04, $01, $A0, $04, $01, $A0, $0F, $09, $01, $CF, $0F, $4D, $01, $08, $1F, $25

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6059:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $F6, $02, $01, $0A, $05, $01, $00, $0F, $2F, $01, $0A
    db $06, $01, $4C, $0F, $09, $01, $56, $0A, $01, $76, $0F, $03, $01, $9F, $0F, $4D
    db $01, $CA, $0F, $17, $03, $03, $01, $18, $1F, $11, $03, $03, $01, $3E, $1F, $03

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6089:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $02, $01, $00, $0F, $44, $01, $FA, $FF, $01, $01, $FA, $FE, $01
    db $F6, $FF, $01, $01, $7E, $0F, $29, $01, $56, $02, $01, $48, $0F, $01, $01, $00
    db $08, $03, $03, $01, $00, $0E, $01, $F4, $0C, $03, $01, $18, $13, $01, $F2, $02
    db $01, $1E, $12, $01, $18, $1F, $09, $01, $3E, $1F, $0D

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_60C4:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $02, $01, $00, $0F, $4D, $01, $4C, $0F, $38, $03, $03, $01, $AA
    db $00, $01, $AC, $00, $01, $A2, $0F, $0D, $01, $D4, $02, $01, $C8, $0F, $0B, $01
    db $D4, $04, $01, $EE, $0F, $03, $01, $B0, $04, $01, $D4, $04, $01, $FC, $F0, $01
    db $18, $1F, $05, $01, $FA, $06, $01, $FA, $F2, $01, $40, $1F, $01

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6101:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $146101, $46

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6147:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $F8, $02, $01, $0C, $03, $01, $00, $0F, $4D, $01, $24
    db $0C, $01, $1E, $04, $01, $78, $0F, $0F, $01, $1C, $02, $01, $A0, $0F, $13, $01
    db $D9, $0F, $4D, $01, $39, $1F, $1B

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_616E:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $02, $01, $00, $0B, $03, $03, $03, $03, $01, $00, $0F, $11, $01
    db $0E, $00, $01, $28, $0F, $3B, $01, $FE, $FE, $01, $88, $0F, $01, $01, $FC, $FF
    db $01, $01, $FA, $FF, $01, $01, $C4, $0F, $07, $01, $FE, $F0, $01, $FA, $FA, $01
    db $F0, $0F, $05, $01, $F6, $FC, $01, $18, $1F, $0F, $01, $4D, $1F, $07

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_61AC:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $04, $03, $04, $00, $0F, $4D, $04, $18, $0F, $04, $00, $00, $02, $02
    db $02, $02, $04, $6A, $0F, $11, $04, $FC, $F0, $02, $02, $01, $01, $03, $03, $04
    db $7C, $04, $04, $A0, $0F, $09, $04, $CE, $04, $04, $C4, $0F, $05, $04, $CE, $06
    db $04, $F0, $0F, $33, $04, $C8, $0C, $04, $3C, $1F, $05

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_61E7:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $03, $01, $00, $05, $02, $01, $0A, $05, $01, $00, $0F, $4D, $01
    db $10, $0A, $01, $1C, $06, $01, $78, $0F, $09, $01, $12, $02, $01, $9A, $0F, $0B
    db $01, $20, $08, $01, $C4, $0F, $05, $01, $EC, $0A, $01, $18, $0C, $01, $FA, $0C
    db $01, $FC, $F0, $01, $C2, $0C, $01, $1E, $1E, $01, $F8, $F4, $01, $38, $1F, $09

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6227:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $90, $0F, $1C
    db $03, $03, $00, $E2, $0C, $00, $00, $10, $00, $F2, $0F, $01, $00, $F0, $00, $00
    db $02, $14, $00, $14, $14, $00, $1A, $1F, $03, $00, $3A, $1F, $11

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6254:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $146254, $46

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_629A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $03, $01, $00, $0F, $3E, $01, $FC, $FF, $01, $01, $FC, $FE, $01
    db $FA, $FF, $01, $01, $78, $0F, $4D, $01, $88, $06, $01, $FE, $FA, $01, $F0, $0F
    db $2F, $01, $CE, $0F, $0F

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_62BF:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $03, $01, $00, $09, $01, $FA, $FF, $11, $02, $02, $02, $02, $01
    db $22, $0F, $0F, $01, $32, $06, $01, $4E, $0F, $09, $01, $32, $00, $01, $6E, $0F
    db $17, $01, $32, $04, $01, $A0, $0F, $07, $01, $A4, $08, $02, $02, $01, $C8, $0F
    db $2F, $01, $D0, $08, $01, $16, $1F, $2B

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_62F7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1462F7, $A2

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6399:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $F2, $02, $01, $06, $09, $01, $00, $0F, $2D, $01, $06
    db $0A, $01, $4E, $0F, $4D, $01, $0E, $0F, $21, $01, $04, $06, $01, $FA, $FF, $01
    db $01, $F8, $FE, $01, $F6, $FF, $01, $01, $A0, $FF, $1B

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_63C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1463C4, $45

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6409:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $44, $0F, $30, $02, $02, $00, $9A
    db $08, $00, $A4, $02, $00, $A4, $0E, $00, $B0, $00, $00, $A4, $04, $00, $CA, $04
    db $00, $CA, $0E, $00, $EF, $0F, $4D, $00, $08, $1F, $05

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6434:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $146434, $42

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6476:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $F2, $03, $01, $06, $09, $01, $00, $0F, $2D, $01, $06
    db $06, $02, $02, $01, $4C, $0F, $07, $01, $56, $06, $01, $82, $00, $01, $74, $0F
    db $05, $01, $7A, $0A, $01, $9A, $0F, $17, $01, $9A, $08, $01, $D0, $0E, $01, $D0
    db $06, $01, $98, $06, $01, $F6, $0E, $01, $F6, $0A, $01, $16, $1F, $2B

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_64B4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1464B4, $5D

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6511:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $146511, $A5

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_65B6:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $F2, $02, $01, $06, $09, $01, $00, $0F, $2F, $01, $02
    db $0A, $01, $50, $0F, $0B, $01, $00, $04, $01, $F4, $FF, $01, $01, $80, $0F, $13
    db $01, $54, $0F, $1B, $01, $44, $0F, $01, $01, $44, $0F, $0B, $01, $FA, $FF, $01
    db $01, $A0, $FF, $1D

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_65EA:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $04, $02, $04, $00, $0F, $4D, $04, $18, $0F, $04, $04, $F8, $FF, $01
    db $04, $78, $0F, $09, $01, $01, $01, $01, $04, $98, $0F, $11, $04, $FE, $F6, $03
    db $03, $04, $C8, $0F, $31, $04, $D2, $06, $04, $16, $1F, $09, $04, $18, $06, $04
    db $3C, $1F, $05

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_661D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14661D, $51

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_666E:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $03, $03, $03, $03, $02, $01, $04, $0B, $01, $00, $0F, $2B, $01
    db $FA, $F2, $01, $44, $0F, $0D, $01, $F8, $F4, $01, $6C, $0F, $13, $01, $72, $06
    db $01, $9C, $0F, $09, $01, $72, $0A, $01, $A0, $0C, $01, $D8, $0F, $07, $01, $DE
    db $0F, $05, $01, $F0, $FC, $01, $18, $1F, $01, $01, $3F, $1F, $15

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_66AB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1466AB, $45

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_66F0:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $03, $A0, $FF, $4D, $03, $20, $0F, $0D, $02, $02, $02, $02, $03
    db $7C, $08, $03, $7C, $0F, $03, $02, $02, $01, $01, $03, $80, $00, $03, $AA, $02
    db $03, $A0, $0F, $09, $03, $CE, $08, $03, $C8, $0F, $07, $03, $CC, $0A, $03, $F0
    db $0F, $09, $03, $CC, $08, $03, $18, $1F, $0B, $03, $CC, $06, $03, $40, $1F, $01

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6730:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $1B, $02, $01, $2E, $01, $01, $28, $04, $01, $28
    db $0F, $03, $01, $2E, $02, $01, $3A, $08, $01, $50, $0F, $01, $01, $52, $0A, $01
    db $72, $0F, $19, $01, $50, $0C, $01, $4C, $06, $01, $1E, $0F, $01, $01, $CC, $0F
    db $29, $01, $CA, $0C, $01, $18, $1F, $29

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6768:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $15, $02, $02, $01, $20, $0F, $15, $01, $28, $02
    db $01, $50, $00, $01, $28, $04, $01, $50, $0F, $03, $01, $22, $0C, $01, $76, $0F
    db $03, $01, $F2, $FF, $2D, $01, $CC, $0F, $03, $01, $5C, $0C, $01, $F2, $0F, $07
    db $01, $52, $04, $03, $03, $01, $16, $1F, $11, $01, $1C, $0A, $01, $94, $08

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_67A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1467A7, $4B

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_67F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1467F2, $57

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6849:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $40, $0F, $2D, $02, $02, $02, $02, $01
    db $90, $0F, $15, $01, $A2, $0C, $01, $C8, $0F, $07, $01, $C8, $0A, $01, $F0, $0F
    db $01, $03, $03, $01, $F0, $0E, $01, $18, $1F, $03, $01, $40, $10, $01, $32, $1F
    db $0F

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_687A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $1F, $02, $02, $01, $20, $0F, $0D, $02, $01, $54
    db $07, $01, $4C, $0F, $07, $01, $54, $08, $01, $5C, $04, $01, $7A, $0F, $29, $01
    db $78, $0C, $01, $C6, $0F, $13, $01, $4C, $0F, $09, $01, $52, $04, $01, $24, $0C
    db $01, $20, $1E, $01, $45, $1F, $0F

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_68B1:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $00, $00, $03, $03, $01, $50, $0F, $11, $03
    db $03, $01, $76, $0F, $11, $03, $03, $02, $02, $02, $02, $01, $A0, $0F, $0D, $01
    db $AE, $02, $01, $C6, $0F, $0F, $01, $D6, $02, $01, $EE, $0F, $0D, $01, $D4, $04
    db $01, $16, $1F, $0B, $01, $88, $00, $01, $38, $1F, $09

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_68EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1468EC, $55

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6941:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $146941, $4E

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_698F:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $F8, $02, $01, $0C, $03, $01, $00, $0F, $0B, $01, $0C
    db $04, $01, $26, $0F, $09, $01, $32, $06, $01, $4C, $0F, $09, $01, $56, $0A, $01
    db $76, $0F, $2F, $01, $54, $0F, $15, $01, $04, $0F, $1B, $01, $08, $06, $01, $18
    db $1F, $0F, $01, $4D, $1F, $07

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_69C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1469C5, $46

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6A0B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $146A0B, $45

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6A50:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $F6, $02, $01, $0A, $05, $01, $00, $0F, $09, $01, $0A
    db $06, $01, $26, $0F, $33, $01, $08, $0F, $15, $01, $06, $08, $01, $A0, $0F, $0D
    db $01, $08, $04, $01, $C8, $0F, $0F, $01, $08, $00, $01, $F8, $FF, $01, $01, $A0
    db $FF, $3F

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6A82:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $146A82, $43

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6AC5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $146AC5, $49

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6B0E:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $1F, $02, $02, $01, $20, $0F, $0D, $02, $01, $54
    db $05, $01, $4A, $0F, $07, $01, $54, $06, $01, $32, $06, $01, $78, $0F, $0B, $01
    db $4A, $0F, $11, $01, $24, $0C, $01, $CA, $0F, $03, $01, $22, $0E, $01, $32, $0F
    db $01, $01, $19, $1F, $3B

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6B43:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $146B43, $43

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6B86:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $02, $03, $00, $0F, $4D, $03, $40, $0F, $2C, $03, $FE, $F4, $01
    db $01, $03, $98, $06, $03, $A0, $0F, $03, $03, $FE, $FA, $03, $F8, $FF, $01, $03
    db $F6, $FE, $03, $F4, $FF, $01, $03, $F2, $FE, $03, $F0, $FF, $01, $03, $A0, $FF
    db $1D

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6BB7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $146BB7, $4CD
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $147096, $655
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $1476FD, $8EA
    ds $19, $00
