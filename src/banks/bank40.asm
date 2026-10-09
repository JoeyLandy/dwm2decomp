SECTION "Bank 40", ROMX[$4000], BANK[$40]
    db $40, $00, $00
    dw Data_040_4071
    db $20, $01
    dw Data_040_4071
    db $40, $00
    dw Data_040_4071
    db $60, $01
    dw Data_040_4071
    db $80, $02
    dw Data_040_4071
    db $A0, $03
    dw Data_040_4071
    db $40, $00
    dw Data_040_4077
    db $60, $01
    dw Data_040_42F3
    db $80, $02
    dw Data_040_4589
    db $40, $00
    dw Data_040_481D
    db $60, $01
    dw Data_040_49F5
    db $80, $02
    dw Data_040_4BCF
    db $40, $00
    dw Data_040_4E13
    db $60, $01
    dw Data_040_5039
    db $80, $02
    dw Data_040_5243
    db $40, $00
    dw Data_040_544F
    db $60, $01
    dw Data_040_56D1
    db $80, $02
    dw Data_040_59CB
    db $A0, $03
    dw Data_040_5C7D
    db $40, $00
    dw Data_040_5CE5
    db $60, $01
    dw Data_040_6113
    db $80, $02
    dw Data_040_64B1
    db $40, $00
    dw Data_040_67EF
    db $60, $01
    dw Data_040_6C5F
    db $80, $02
    dw Data_040_70BF
    db $40, $00
    dw Data_040_7543
    db $60, $01
    dw Data_040_7907
    db $80, $02
    dw Data_040_7B9B

Data_040_4071:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $FF, $FF

Data_040_4077:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $100077, $27C

Data_040_42F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1002F3, $296

Data_040_4589:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $100589, $294

Data_040_481D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10081D, $1D8

Data_040_49F5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1009F5, $1DA

Data_040_4BCF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $100BCF, $244

Data_040_4E13:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $100E13, $226

Data_040_5039:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $101039, $20A

Data_040_5243:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $101243, $20C

Data_040_544F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10144F, $282

Data_040_56D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1016D1, $2FA

Data_040_59CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1019CB, $2B2

Data_040_5C7D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $101C7D, $68

Data_040_5CE5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $101CE5, $42E

Data_040_6113:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $102113, $39E

Data_040_64B1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1024B1, $33E

Data_040_67EF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1027EF, $470

Data_040_6C5F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $102C5F, $460

Data_040_70BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1030BF, $484

Data_040_7543:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $103543, $3C4

Data_040_7907:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $103907, $294

Data_040_7B9B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $103B9B, $352
    ds $113, $00
