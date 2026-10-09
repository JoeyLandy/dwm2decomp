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

Data_04B_4F27:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12CF27, $A9

Data_04B_4FD0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12CFD0, $17C

Data_04B_514C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D14C, $A6

Data_04B_51F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D1F2, $22B

Data_04B_541D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D41D, $B4

Data_04B_54D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D4D1, $2B5

Data_04B_5786:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D786, $79

Data_04B_57FF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12D7FF, $230

Data_04B_5A2F:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $02, $01, $00, $0F, $18, $04, $04, $01, $F6, $FE, $01, $2C, $0E
    db $04, $04, $01, $2C, $08, $04, $04, $01, $4E, $0F, $31, $01, $2C, $06, $01, $9C
    db $0F, $0D, $01, $2C, $04, $01, $C4, $0F, $4D, $01, $FC, $0F, $1D

Data_04B_5A5C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DA5C, $9F

Data_04B_5AFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DAFB, $5E

Data_04B_5B59:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DB59, $109

Data_04B_5C62:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DC62, $43

Data_04B_5CA5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12DCA5, $122

Data_04B_5DC7:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $15, $02, $01, $28, $0F, $44, $04, $01, $80, $01
    db $01, $72, $0F, $07, $01, $20, $0A, $01, $1A, $0F, $01, $01, $FF, $F2, $01, $80
    db $02, $01, $CD, $0F, $4D, $01, $E0, $0E, $01, $28, $0F, $15

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

Data_04B_614D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E14D, $CD

Data_04B_621A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E21A, $59

Data_04B_6273:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E273, $56

Data_04B_62C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E2C9, $B3

Data_04B_637C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E37C, $DA

Data_04B_6456:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E456, $BA

Data_04B_6510:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E510, $E9

Data_04B_65F9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E5F9, $D2

Data_04B_66CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E6CB, $84

Data_04B_674F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E74F, $65

Data_04B_67B4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E7B4, $C8

Data_04B_687C:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

Data_04B_688F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E88F, $B4

Data_04B_6943:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $19, $01, $02, $2C, $07, $02, $24, $0F, $07, $02
    db $2C, $00, $03, $02, $56, $03, $02, $32, $04, $02, $52, $0F, $03, $02, $56, $04
    db $02, $56, $04, $02, $78, $0F, $4D, $02, $88, $04, $02, $54, $0F, $13, $02, $50
    db $06, $02, $34, $0C, $02, $20, $1C, $02, $8C, $04, $02, $3A, $18, $02, $44, $1C

Data_04B_6983:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $3D, $01, $02, $50, $05, $02, $46, $0F, $0B, $03
    db $02, $78, $03, $02, $6C, $0F, $4D, $02, $90, $0C, $02, $50, $0F, $15, $02, $17
    db $1F, $3D

Data_04B_69A5:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $43, $01, $02, $56, $03, $02, $4A, $0F, $0F, $03
    db $03, $03, $03, $02, $70, $0F, $4D, $02, $D0, $0F, $4D, $02, $08, $1F, $11

Data_04B_69C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12E9C4, $48

Data_04B_6A0C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EA0C, $53

Data_04B_6A5F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EA5F, $43

Data_04B_6AA2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EAA2, $50

Data_04B_6AF2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EAF2, $4B

Data_04B_6B3D:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $00, $00, $01, $01, $02, $F6, $FE, $02, $02, $0F, $35, $01, $01
    db $02, $4C, $0F, $09, $02, $02, $04, $02, $7A, $0F, $0F, $02, $74, $0F, $01, $02
    db $A6, $0F, $07, $03, $03, $02, $C2, $0F, $0B, $03, $03, $03, $03, $02, $E4, $0F
    db $05, $02, $00, $06, $02, $06, $1F, $03, $02, $F8, $FE, $02, $2E, $1F, $13

Data_04B_6B7C:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $41, $01, $02, $54, $0B, $02, $50, $0F, $07, $03
    db $02, $7E, $09, $02, $78, $0F, $4D, $02, $88, $06, $02, $56, $0F, $13, $02, $1B
    db $1F, $39

Data_04B_6B9E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EB9E, $42

Data_04B_6BE0:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

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

Data_04B_6C82:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EC82, $76

Data_04B_6CF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12ECF8, $D1

Data_04B_6DC9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EDC9, $D0

Data_04B_6E99:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EE99, $AD

Data_04B_6F46:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EF46, $B3

Data_04B_6FF9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12EFF9, $50

Data_04B_7049:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F049, $93

Data_04B_70DC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F0DC, $AE

Data_04B_718A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

Data_04B_719D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F19D, $48

Data_04B_71E5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F1E5, $47

Data_04B_722C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F22C, $58

Data_04B_7284:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F284, $4A

Data_04B_72CE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F2CE, $45

Data_04B_7313:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $3D, $01, $02, $50, $07, $02, $48, $0F, $09, $03
    db $02, $78, $05, $02, $6E, $0F, $33, $02, $50, $0F, $15, $02, $EF, $0F, $4D, $02
    db $4F, $1F, $05

Data_04B_7336:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F336, $50

Data_04B_7386:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12F386, $41

Data_04B_73C7:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35
    ds $C26, $00
