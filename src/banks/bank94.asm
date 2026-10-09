SECTION "Bank 94", ROMX[$4000], BANK[$94]
    INCBIN "dwm2-cobi-us.gbc", $250000, $14B7
    ds $12, $00
    dw Data_094_54E1
    db $94
    dw Data_094_55E5
    db $94
    dw Data_094_56F9
    db $94
    dw Data_094_581F
    db $94
    dw Data_094_5953
    db $94
    dw Data_094_598A
    db $94
    dw Data_094_59C7
    db $94
    dw Data_094_5A22
    db $94

Data_094_54E1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2514E1, $104

Data_094_55E5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2515E5, $114

Data_094_56F9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2516F9, $126

Data_094_581F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25181F, $134

Data_094_5953:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $42, $02, $00, $56, $05, $00, $4C, $0F, $31
    db $04, $04, $00, $92, $0F, $1F, $04, $04, $04, $04, $00, $C8, $0F, $07, $00, $F4
    db $08, $00, $F0, $0E, $00, $EE, $0F, $05, $00, $18, $1F, $05, $00, $CE, $08, $00
    db $53, $00, $00, $40, $1E, $02, $02

Data_094_598A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $06, $04, $04, $04, $04, $00, $0A, $0F, $29
    db $00, $56, $02, $00, $4C, $0F, $0F, $02, $00, $82, $03, $00, $76, $0F, $2B, $00
    db $56, $06, $00, $BE, $0F, $0B, $00, $52, $08, $00, $E8, $0F, $0D, $00, $54, $04
    db $00, $10, $1F, $11, $00, $00, $08, $00, $89, $02, $00, $1C, $0A

Data_094_59C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2519C7, $5B

Data_094_5A22:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $251A22, $53C
    ds $11, $00
    dw Data_094_5F87
    db $94
    dw Data_094_6068
    db $94
    dw Data_094_615E
    db $94
    dw Data_094_6281
    db $94
    dw Data_094_63A6
    db $94
    dw Data_094_63DF
    db $94
    dw Data_094_6413
    db $94
    dw Data_094_645A
    db $94

Data_094_5F87:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $251F87, $E1

Data_094_6068:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $252068, $F6

Data_094_615E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25215E, $123

Data_094_6281:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $252281, $125

Data_094_63A6:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $40, $01, $00, $54, $03, $00, $48, $0F, $0B
    db $00, $54, $04, $00, $58, $02, $00, $82, $06, $00, $7E, $0F, $09, $00, $80, $08
    db $00, $A6, $0F, $25, $00, $A0, $0E, $00, $F0, $0F, $13, $00, $74, $0E, $00, $5A
    db $04, $02, $00, $44, $15, $00, $3A, $1F, $07

Data_094_63DF:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $1A, $01, $00, $2E, $03, $00, $22, $0F, $0B
    db $00, $2E, $04, $00, $32, $08, $00, $54, $0C, $00, $54, $08, $00, $30, $04, $00
    db $78, $0F, $4D, $00, $B0, $0F, $19, $00, $B2, $0C, $00, $4E, $0E, $00, $26, $1C
    db $00, $22, $0F, $0B

Data_094_6413:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $252413, $47

Data_094_645A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25245A, $55A
    dw Data_094_69CC
    db $94
    dw Data_094_6ADF
    db $94
    dw Data_094_6BD7
    db $94
    dw Data_094_6CD8
    db $94
    dw Data_094_6DBC
    db $94
    dw Data_094_6DF8
    db $94
    dw Data_094_6E53
    db $94
    dw Data_094_6EA6
    db $94

Data_094_69CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2529CC, $113

Data_094_6ADF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $252ADF, $F8

Data_094_6BD7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $252BD7, $101

Data_094_6CD8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $252CD8, $E4

Data_094_6DBC:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $02, $03, $00, $0F, $1A, $01, $03, $2E, $01, $03, $20, $0F, $15
    db $03, $56, $04, $03, $50, $0F, $03, $06, $03, $7A, $09, $03, $74, $0F, $0F, $00
    db $00, $03, $98, $0F, $13, $03, $80, $06, $03, $C8, $0F, $2B, $03, $00, $00, $03
    db $80, $08, $03, $16, $1F, $0D, $03, $5A, $0C, $03, $46, $1A

Data_094_6DF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $252DF8, $5B

Data_094_6E53:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $252E53, $53

Data_094_6EA6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $252EA6, $357
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $25320F, $B28
    ds $2C9, $00
