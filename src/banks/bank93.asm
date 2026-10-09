SECTION "Bank 93", ROMX[$4000], BANK[$93]
    INCBIN "dwm2-cobi-us.gbc", $24C000, $921
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $24C933, $E6D
    dw Data_093_57E8
    db $93
    dw Data_093_5927
    db $93
    dw Data_093_5A91
    db $93
    dw Data_093_5F35
    db $93
    dw Data_093_604A
    db $93
    dw Data_093_60A1
    db $93
    dw Data_093_6124
    db $93
    dw Data_093_628A
    db $93
    dw Data_093_57E8
    db $93
    dw Data_093_5927
    db $93
    dw Data_093_5E96
    db $93
    dw Data_093_5F35
    db $93
    dw Data_093_604A
    db $93
    dw Data_093_60A1
    db $93
    dw Data_093_6266
    db $93
    dw Data_093_628A
    db $93
    dw Data_093_585A
    db $93
    dw Data_093_5974
    db $93
    dw Data_093_5A91
    db $93
    dw Data_093_5FA8
    db $93
    dw Data_093_605E
    db $93
    dw Data_093_60B5
    db $93
    dw Data_093_6124
    db $93
    dw Data_093_629E
    db $93

Data_093_57E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24D7E8, $72

Data_093_585A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24D85A, $CD

Data_093_5927:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24D927, $4D

Data_093_5974:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24D974, $11D

Data_093_5A91:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24DA91, $405

Data_093_5E96:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24DE96, $9F

Data_093_5F35:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24DF35, $73

Data_093_5FA8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24DFA8, $A2

Data_093_604A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_093_605E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24E05E, $43

Data_093_60A1:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_093_60B5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24E0B5, $6F

Data_093_6124:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24E124, $142

Data_093_6266:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $01, $03, $00, $0F, $44, $02, $02, $02, $02, $03, $48, $0F, $0F
    db $03, $5A, $00, $03, $FE, $FC, $03, $7E, $0F, $01, $03, $A5, $0F, $4D, $03, $05
    db $1F, $4D, $01, $01

Data_093_628A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_093_629E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24E29E, $97A
    dw Data_093_6C30
    db $93
    dw Data_093_6D29
    db $93
    dw Data_093_6E39
    db $93
    dw Data_093_6F32
    db $93
    dw Data_093_700E
    db $93
    dw Data_093_7062
    db $93
    dw Data_093_70AF
    db $93
    dw Data_093_7101
    db $93

Data_093_6C30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24EC30, $F9

Data_093_6D29:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24ED29, $110

Data_093_6E39:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24EE39, $F9

Data_093_6F32:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24EF32, $DC

Data_093_700E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F00E, $54

Data_093_7062:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F062, $4D

Data_093_70AF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F0AF, $52

Data_093_7101:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $04, $01, $04, $00, $0F, $40, $03, $04, $54, $07, $04, $4C, $0F, $07
    db $04, $54, $06, $02, $02, $04, $5C, $04, $04, $7A, $0F, $0B, $04, $5A, $06, $04
    db $A2, $0F, $4D, $04, $4E, $0F, $17, $04, $FE, $FE, $04, $FC, $FF, $01, $00, $00
    dw Data_093_7149
    db $93
    dw Data_093_7248
    db $93
    dw Data_093_7321
    db $93
    dw Data_093_742C
    db $93
    dw Data_093_7520
    db $93
    dw Data_093_7566
    db $93
    dw Data_093_75A7
    db $93
    dw Data_093_75F5
    db $93

Data_093_7149:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F149, $FF

Data_093_7248:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F248, $D9

Data_093_7321:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F321, $10B

Data_093_742C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F42C, $F4

Data_093_7520:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F520, $46

Data_093_7566:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F566, $41

Data_093_75A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F5A7, $4E

Data_093_75F5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24F5F5, $DE
    ds $32, $00
    INCBIN "dwm2-cobi-us.gbc", $24F705, $1ED
    ds $22, $00
    INCBIN "dwm2-cobi-us.gbc", $24F914, $642
    ds $12, $00
    db $A0, $7D, $FF, $7F, $E0, $7F, $63, $00, $C4, $01, $FF, $7F, $52, $56, $84, $00
    db $B5, $01, $FF, $7F, $52, $56, $06, $00, $C4, $01, $FF, $7F, $94, $52, $00, $00
    db $A0, $7D, $FF, $7F, $E0, $7F, $E0, $40, $71, $01, $FF, $7F, $13, $2A, $00, $00
    db $15, $14, $FF, $7F, $F5, $25, $00, $00, $8C, $31, $FF, $7F, $94, $52
    ds $5A, $00
