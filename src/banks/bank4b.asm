SECTION "Bank 4B", ROMX[$4000], BANK[$4B]
    INCBIN "dwm2-cobi-us.gbc", $12C000, $E61
    dw Data_04B_4F18
    db $52, $3A, $A5, $0C
    dw Data_04B_4F27
    db $4B, $27, $4F, $4B
    dw Data_04B_4F27
    db $4B, $27, $4F, $4B
    dw Data_04B_4FD0
    db $4B, $99, $50, $4B
    dw Data_04B_514C
    db $4B, $27, $4F, $4B
    dw Data_04B_51F2
    db $4B, $B6, $52, $4B
    dw Data_04B_541D
    db $4B, $27, $4F, $4B
    dw Data_04B_54D1
    db $4B, $C7, $55, $4B
    dw Data_04B_5786
    db $4B, $74, $58, $4B
    dw Data_04B_5A2F
    db $4B, $2F, $5A, $4B
    dw Data_04B_5A2F
    db $4B, $2F, $5A, $4B
    dw Data_04B_5A5C
    db $4B, $B9, $5A, $4B
    dw Data_04B_5AFB
    db $4B, $2F, $5A, $4B
    dw Data_04B_5B59
    db $4B, $AF, $5B, $4B
    dw Data_04B_5C62
    db $4B, $2F, $5A, $4B
    dw Data_04B_5CA5
    db $4B, $01, $5D, $4B
    dw Data_04B_5DC7
    db $4B, $1C, $5E, $4B
    dw Data_04B_4F27
    db $4B, $27, $4F, $4B
    dw Data_04B_4F27
    db $4B, $27, $4F, $4B
    dw Data_04B_4FD0
    db $4B, $99, $50, $4B
    dw Data_04B_514C
    db $4B, $27, $4F, $4B
    dw Data_04B_51F2
    db $4B, $7A, $53, $4B
    dw Data_04B_541D
    db $4B, $27, $4F, $4B
    dw Data_04B_54D1
    db $4B, $B9, $56, $4B
    dw Data_04B_57FF
    db $4B, $52, $59, $4B
    dw Data_04B_5A2F
    db $4B, $2F, $5A, $4B
    dw Data_04B_5A2F
    db $4B, $2F, $5A, $4B
    dw Data_04B_5A5C
    db $4B, $B9, $5A, $4B
    dw Data_04B_5AFB
    db $4B, $2F, $5A, $4B
    dw Data_04B_5B59
    db $4B, $15, $5C, $4B
    dw Data_04B_5C62
    db $4B

Data_04B_4F18:: ; heuristic: target of a monotone pointer table; C0
    db $2F, $5A, $4B
    dw Data_04B_5CA5
    db $4B, $78, $5D, $4B
    dw Data_04B_5DF3
    db $4B, $70, $5E, $4B

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_4F27:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12CF27, $A9

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_4FD0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12CFD0, $17C

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_514C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D14C, $A6

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_51F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D1F2, $22B

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_541D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D41D, $B4

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_54D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D4D1, $2B5

; LZSS-compressed asset: 121 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_5786:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D786, $79

; LZSS-compressed asset: 117 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_57FF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D7FF, $230

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_5A2F:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $02, $01, $00, $0F, $18, $04, $04, $01, $F6, $FE, $01, $2C, $0E
    db $04, $04, $01, $2C, $08, $04, $04, $01, $4E, $0F, $31, $01, $2C, $06, $01, $9C
    db $0F, $0D, $01, $2C, $04, $01, $C4, $0F, $4D, $01, $FC, $0F, $1D

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_5A5C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DA5C, $9F

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_5AFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DAFB, $5E

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_5B59:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DB59, $109

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_5C62:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DC62, $43

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_5CA5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DCA5, $122

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_5DC7:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $15, $02, $01, $28, $0F, $44, $04, $01, $80, $01
    db $01, $72, $0F, $07, $01, $20, $0A, $01, $1A, $0F, $01, $01, $FF, $F2, $01, $80
    db $02, $01, $CD, $0F, $4D, $01, $E0, $0E, $01, $28, $0F, $15

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_5DF3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DDF3, $2CA
    dw Data_04B_614D
    db $4B
    dw Data_04B_621A
    db $4B
    dw Data_04B_6273
    db $4B
    dw Data_04B_62C9
    db $4B
    dw Data_04B_637C
    db $4B
    dw Data_04B_6456
    db $4B
    dw Data_04B_65F9
    db $4B
    dw Data_04B_66CB
    db $4B
    dw Data_04B_674F
    db $4B
    dw Data_04B_67B4
    db $4B
    dw Data_04B_687C
    db $4B
    dw Data_04B_688F
    db $4B
    dw Data_04B_6943
    db $4B
    dw Data_04B_6983
    db $4B
    dw Data_04B_69A5
    db $4B
    dw Data_04B_69C4
    db $4B
    dw Data_04B_6A0C
    db $4B
    dw Data_04B_6A5F
    db $4B
    dw Data_04B_6AF2
    db $4B
    dw Data_04B_6B3D
    db $4B
    dw Data_04B_6B7C
    db $4B
    dw Data_04B_6B9E
    db $4B
    dw Data_04B_6BE0
    db $4B
    dw Data_04B_6BF3
    db $4B
    dw Data_04B_614D
    db $4B
    dw Data_04B_621A
    db $4B
    dw Data_04B_6273
    db $4B
    dw Data_04B_62C9
    db $4B
    dw Data_04B_637C
    db $4B
    dw Data_04B_6510
    db $4B
    dw Data_04B_65F9
    db $4B
    dw Data_04B_66CB
    db $4B
    dw Data_04B_674F
    db $4B
    dw Data_04B_67B4
    db $4B
    dw Data_04B_687C
    db $4B
    dw Data_04B_688F
    db $4B
    dw Data_04B_6943
    db $4B
    dw Data_04B_6983
    db $4B
    dw Data_04B_69A5
    db $4B
    dw Data_04B_69C4
    db $4B
    dw Data_04B_6A0C
    db $4B
    dw Data_04B_6AA2
    db $4B
    dw Data_04B_6AF2
    db $4B
    dw Data_04B_6B3D
    db $4B
    dw Data_04B_6B7C
    db $4B
    dw Data_04B_6B9E
    db $4B
    dw Data_04B_6BE0
    db $4B
    dw Data_04B_6BF3
    db $4B

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_614D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E14D, $CD

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_621A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E21A, $59

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6273:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E273, $56

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_62C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E2C9, $B3

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_637C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E37C, $DA

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6456:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E456, $BA

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6510:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E510, $E9

; LZSS-compressed asset: 210 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_65F9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E5F9, $D2

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_66CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E6CB, $84

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_674F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E74F, $65

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_67B4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E7B4, $C8

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_687C:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_688F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E88F, $B4

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6943:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $19, $01, $02, $2C, $07, $02, $24, $0F, $07, $02
    db $2C, $00, $03, $02, $56, $03, $02, $32, $04, $02, $52, $0F, $03, $02, $56, $04
    db $02, $56, $04, $02, $78, $0F, $4D, $02, $88, $04, $02, $54, $0F, $13, $02, $50
    db $06, $02, $34, $0C, $02, $20, $1C, $02, $8C, $04, $02, $3A, $18, $02, $44, $1C

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6983:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $3D, $01, $02, $50, $05, $02, $46, $0F, $0B, $03
    db $02, $78, $03, $02, $6C, $0F, $4D, $02, $90, $0C, $02, $50, $0F, $15, $02, $17
    db $1F, $3D

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_69A5:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $43, $01, $02, $56, $03, $02, $4A, $0F, $0F, $03
    db $03, $03, $03, $02, $70, $0F, $4D, $02, $D0, $0F, $4D, $02, $08, $1F, $11

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_69C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E9C4, $48

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6A0C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EA0C, $53

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6A5F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EA5F, $43

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6AA2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EAA2, $50

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6AF2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EAF2, $4B

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6B3D:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $00, $00, $01, $01, $02, $F6, $FE, $02, $02, $0F, $35, $01, $01
    db $02, $4C, $0F, $09, $02, $02, $04, $02, $7A, $0F, $0F, $02, $74, $0F, $01, $02
    db $A6, $0F, $07, $03, $03, $02, $C2, $0F, $0B, $03, $03, $03, $03, $02, $E4, $0F
    db $05, $02, $00, $06, $02, $06, $1F, $03, $02, $F8, $FE, $02, $2E, $1F, $13

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6B7C:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $41, $01, $02, $54, $0B, $02, $50, $0F, $07, $03
    db $02, $7E, $09, $02, $78, $0F, $4D, $02, $88, $06, $02, $56, $0F, $13, $02, $1B
    db $1F, $39

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6B9E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EB9E, $42

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6BE0:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6BF3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EBF3, $59
    dw Data_04B_6C82
    db $4B
    dw Data_04B_6CF8
    db $4B
    dw Data_04B_6DC9
    db $4B
    dw Data_04B_6E99
    db $4B
    dw Data_04B_6F46
    db $4B
    dw Data_04B_6FF9
    db $4B
    dw Data_04B_7049
    db $4B
    dw Data_04B_70DC
    db $4B
    dw Data_04B_718A
    db $4B
    dw Data_04B_719D
    db $4B
    dw Data_04B_71E5
    db $4B
    dw Data_04B_722C
    db $4B
    dw Data_04B_7284
    db $4B
    dw Data_04B_72CE
    db $4B
    dw Data_04B_7313
    db $4B
    dw Data_04B_7336
    db $4B
    dw Data_04B_7386
    db $4B
    dw Data_04B_73C7
    db $4B

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6C82:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EC82, $76

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6CF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12ECF8, $D1

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6DC9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EDC9, $D0

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6E99:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EE99, $AD

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6F46:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EF46, $B3

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_6FF9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EFF9, $50

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_7049:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F049, $93

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_70DC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F0DC, $AE

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_718A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_719D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F19D, $48

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_71E5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F1E5, $47

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_722C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F22C, $58

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_7284:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F284, $4A

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_72CE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F2CE, $45

; LZSS-compressed asset: 35 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_7313:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $3D, $01, $02, $50, $07, $02, $48, $0F, $09, $03
    db $02, $78, $05, $02, $6E, $0F, $33, $02, $50, $0F, $15, $02, $EF, $0F, $4D, $02
    db $4F, $1F, $05

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_7336:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F336, $50

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_7386:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F386, $41

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04B_73C7:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35
    ds $C26, $00
