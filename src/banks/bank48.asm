SECTION "Bank 48", ROMX[$4000], BANK[$48]
    INCBIN "dwm2-cobi-us.gbc", $120000, $1178
    dw Data_048_519C
    db $48
    dw Data_048_523C
    db $48
    dw Data_048_52D3
    db $48
    dw Data_048_5362
    db $48
    dw Data_048_53D3
    db $48
    dw Data_048_541D
    db $48
    dw Data_048_547C
    db $48
    dw Data_048_54BF
    db $48
    dw Data_048_5509
    db $48
    dw Data_048_5544
    db $48
    dw Data_048_557C
    db $48
    dw Data_048_55A4
    db $48

Data_048_519C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12119C, $A0

Data_048_523C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12123C, $97

Data_048_52D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1212D3, $8F

Data_048_5362:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $121362, $71

Data_048_53D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1213D3, $4A

Data_048_541D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12141D, $5F

Data_048_547C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12147C, $43

Data_048_54BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1214BF, $4A

Data_048_5509:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $01, $01, $01, $00, $00, $02, $00, $00, $00, $02
    db $02, $00, $00, $0F, $37, $00, $06, $00, $00, $4E, $0F, $03, $04, $00, $78, $01
    db $01, $01, $00, $78, $00, $00, $70, $0F, $0F, $00, $A0, $04, $00, $9A, $0F, $3D
    db $00, $82, $00, $00, $EE, $0F, $39, $00, $9A, $0F, $07

Data_048_5544:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $02, $03, $03, $01, $01, $04, $00, $06, $09, $00, $00, $0F
    db $4D, $00, $10, $04, $06, $06, $00, $6A, $0F, $15, $00, $7C, $0A, $00, $A0, $0F
    db $05, $00, $7A, $00, $00, $18, $02, $00, $18, $02, $00, $C8, $0F, $07, $00, $F2
    db $0A, $00, $F0, $0F, $4D, $00, $CA, $00

Data_048_557C:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $90, $0F, $1C
    db $03, $03, $01, $01, $04, $04, $00, $F2, $00, $00, $F4, $02, $01, $01, $03, $03
    db $00, $F0, $0F, $03, $00, $16, $1F, $3B

Data_048_55A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1215A4, $28B9
    ds $1A, $00
    INCBIN "dwm2-cobi-us.gbc", $123E77, $16D
    ds $1C, $00
