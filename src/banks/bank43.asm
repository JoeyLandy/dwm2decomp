SECTION "Bank 43", ROMX[$4000], BANK[$43]
    db $43, $00, $03
    dw Data_043_40DD
    db $00, $03
    dw Data_043_40F9
    db $00, $03
    dw Data_043_411D
    db $00, $03
    dw Data_043_413F
    db $00, $00
    dw Data_043_416B
    db $20, $03
    dw Data_043_41A9
    db $00, $00
    dw Data_043_41BF
    db $20, $03
    dw Data_043_4235
    db $00, $03
    dw Data_043_4253
    db $00, $03
    dw Data_043_426B
    db $00, $00
    dw Data_043_429D
    db $20, $03
    dw Data_043_42CB
    db $00, $03
    dw Data_043_42E1
    db $20, $00
    dw Data_043_4301
    db $00, $00
    dw Data_043_4307
    db $20, $03
    dw Data_043_4359
    db $00, $00
    dw Data_043_4379
    db $20, $03
    dw Data_043_438F
    db $00, $00
    dw Data_043_43CF
    db $20, $03
    dw Data_043_4431
    db $00, $03
    dw Data_043_4449
    db $00, $00
    dw Data_043_447B
    db $20, $03
    dw Data_043_4509
    db $00, $00
    dw Data_043_4521
    db $20, $03
    dw Data_043_4559
    db $00, $00
    dw Data_043_457B
    db $20, $03
    dw Data_043_4591
    db $00, $00
    dw Data_043_45AD
    db $20, $03
    dw Data_043_45E1
    db $00, $00
    dw Data_043_4611
    db $20, $03
    dw Data_043_4641
    db $00, $00
    dw Data_043_465F
    db $20, $03
    dw Data_043_469F
    db $00, $00
    dw Data_043_46C1
    db $20, $03
    dw Data_043_471F
    db $00, $03
    dw Data_043_4731
    db $40, $00
    dw Data_043_4769
    db $60, $01
    dw Data_043_4F29
    db $80, $02
    dw Data_043_5849
    db $40, $00
    dw Data_043_59B7
    db $60, $01
    dw Data_043_5C95
    db $80, $02
    dw Data_043_5EB3
    db $00, $00
    dw Data_043_61F5
    db $20, $01
    dw Data_043_622F
    db $00, $00
    dw Data_043_6271
    db $20, $01
    dw Data_043_6299
    db $40, $00
    dw Data_043_62C1
    db $60, $01
    dw Data_043_6305
    db $80, $02
    dw Data_043_6341
    db $00, $03
    dw Data_043_6373
    db $00, $00
    dw Data_043_63AB
    db $20, $03
    dw Data_043_63EB
    db $00, $03
    dw Data_043_6409
    db $40, $00
    dw Data_043_641D
    db $60, $01
    dw Data_043_650D

Data_043_40DD:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $23, $02, $31, $04, $12, $05, $13, $05, $C7, $20, $30, $05
    db $C0, $FE, $10, $10, $A0, $05, $C7, $20, $20, $18, $FF, $FF

Data_043_40F9:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $40, $02, $60, $03, $20, $08, $11, $02, $40, $03, $A0, $06
    db $C7, $10, $40, $05, $A0, $0F, $1F, $03, $C3, $30, $70, $20, $C7, $30, $70, $30
    db $FF, $FF, $FF, $FF

Data_043_411D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $C7, $20, $50, $01, $40, $08, $21, $08, $A0, $08, $21, $10
    db $A0, $0F, $53, $05, $46, $06, $50, $03, $30, $03, $42, $08, $C7, $20, $42, $20
    db $FF, $FF

Data_043_413F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $60, $04, $30, $02, $50, $02, $20, $02, $40, $02, $1F, $01
    db $50, $02, $60, $04, $30, $02, $50, $02, $20, $02, $40, $02, $60, $02, $40, $05
    db $22, $07, $C1, $20, $40, $08, $A0, $05, $40, $10, $FF, $FF

Data_043_416B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $0F, $25, $12, $06, $1F, $01, $12, $06, $1F, $01, $12, $06, $1F, $01
    db $AE, $10, $12, $06, $1F, $01, $AE, $00, $15, $06, $1F, $01, $15, $06, $1F, $01
    db $15, $06, $1F, $01, $AE, $10, $15, $06, $1F, $01, $A0, $08, $15, $06, $1F, $01
    db $15, $06, $1F, $01, $15, $06, $1F, $01, $12, $09, $1F, $01, $FF, $FF

Data_043_41A9:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $1F, $55, $40, $03, $41, $06, $70, $05, $60, $22, $C1, $50
    db $A0, $07, $60, $10, $FF, $FF

Data_043_41BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10C1BF, $76

Data_043_4235:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $C3, $7F, $11, $20, $C1, $40, $11, $20, $1F, $02, $C0, $FE
    db $A0, $08, $51, $10, $51, $10, $A0, $05, $C1, $50, $51, $30, $FF, $FF

Data_043_4253:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $C3, $0A, $21, $03, $13, $02, $A0, $0F, $20, $09, $12, $10
    db $C7, $20, $A0, $08, $12, $20, $FF, $FF

Data_043_426B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $50, $02, $42, $02, $A0, $0A, $50, $01, $A0, $0C, $40, $02
    db $42, $02, $A0, $07, $40, $01, $A0, $0A, $40, $02, $42, $02, $A0, $05, $40, $01
    db $40, $02, $42, $02, $40, $01, $A0, $03, $40, $01, $40, $02, $42, $02, $40, $01
    db $FF, $FF

Data_043_429D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $09, $16, $A0, $06, $1F, $26, $41, $04, $1F, $01, $A0, $0F, $41, $04
    db $1F, $01, $A1, $16, $30, $02, $A0, $0D, $30, $05, $1F, $01, $A0, $08, $30, $03
    db $A0, $05, $30, $02, $A0, $02, $30, $03, $A0, $01, $30, $02, $FF, $FF

Data_043_42CB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0D, $00, $1F, $03, $CC, $2E, $12, $35, $A0, $06, $C1, $1F, $11, $06
    db $A0, $03, $11, $06, $FF, $FF

Data_043_42E1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0E, $00, $53, $06, $43, $02, $41, $10, $A0, $0C, $40, $10, $C1, $70
    db $42, $03, $A0, $0B, $51, $14, $A0, $06, $51, $10, $A0, $04, $51, $30, $FF, $FF

Data_043_4301:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $FF, $FF

Data_043_4307:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10C307, $52

Data_043_4359:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $C3, $10, $1D, $01, $42, $19, $12, $09, $C1, $70, $3D, $02
    db $2C, $01, $31, $20, $A0, $0A, $C1, $50, $31, $10, $A0, $04, $32, $14, $FF, $FF

Data_043_4379:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $C1, $50, $58, $02, $1F, $02, $58, $03, $1F, $01, $5B, $10
    db $A0, $08, $5B, $10, $FF, $FF

Data_043_438F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $C1, $50, $12, $20, $A0, $05, $12, $13, $A0, $0F, $CC, $10
    db $12, $13, $C1, $5F, $12, $0C, $13, $0B, $13, $0A, $13, $08, $13, $07, $13, $06
    db $13, $05, $13, $04, $13, $03, $13, $02, $A0, $08, $12, $03, $12, $02, $12, $02
    db $A0, $03, $11, $02, $11, $02, $A0, $02, $10, $02, $10, $02, $FF, $FF, $FF, $FF

Data_043_43CF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10C3CF, $62

Data_043_4431:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0A, $00, $23, $02, $21, $10, $A0, $0C, $21, $18, $C1, $60, $A0, $0B
    db $21, $10, $A0, $07, $21, $28, $FF, $FF

Data_043_4449:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $1C, $01, $1F, $01, $C1, $02, $1D, $02, $44, $16, $4D, $03
    db $45, $05, $2E, $01, $11, $02, $1F, $01, $C3, $20, $3C, $03, $4F, $02, $46, $0B
    db $C7, $75, $50, $0B, $43, $0D, $60, $20, $A0, $05, $60, $14, $A0, $02, $60, $10
    db $FF, $FF

Data_043_447B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10C47B, $8E

Data_043_4509:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $1F, $4B, $A0, $08, $20, $10, $A0, $0F, $1D, $04, $C1, $7F
    db $46, $20, $A0, $08, $46, $25, $FF, $FF

Data_043_4521:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $1F, $1F, $44, $40, $02, $42, $02, $43, $02, $41, $02, $A0, $0D
    db $40, $02, $41, $02, $42, $02, $43, $02, $A0, $0B, $40, $02, $41, $02, $40, $02
    db $41, $02, $A0, $08, $42, $02, $43, $02, $42, $02, $43, $02, $A0, $05, $42, $02
    db $43, $02, $40, $02, $41, $02, $FF, $FF

Data_043_4559:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $CC, $20, $50, $1E, $C3, $40, $50, $20, $A0, $0C, $C1, $70
    db $50, $08, $C3, $40, $A0, $0F, $3D, $02, $60, $25, $C1, $50, $A0, $0B, $60, $40
    db $FF, $FF

Data_043_457B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $C1, $40, $70, $06, $1F, $26, $59, $01, $C1, $70, $5B, $15
    db $A0, $08, $5B, $18, $FF, $FF

Data_043_4591:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $20, $05, $C1, $30, $42, $10, $A0, $06, $42, $10, $A0, $0E
    db $C1, $7F, $13, $25, $43, $12, $A0, $06, $43, $20, $FF, $FF

Data_043_45AD:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $1C, $1F, $16, $40, $05, $48, $05, $39, $05, $42, $05, $40, $05
    db $39, $05, $A0, $0C, $40, $05, $48, $05, $39, $05, $42, $05, $A0, $06, $40, $05
    db $48, $05, $39, $05, $42, $05, $A0, $03, $40, $05, $48, $05, $A0, $01, $39, $05
    db $42, $05, $FF, $FF

Data_043_45E1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $58, $02, $50, $07, $20, $07, $A0, $07, $20, $0A, $1F, $06
    db $A0, $0F, $60, $0C, $63, $0C, $54, $0A, $65, $04, $A0, $08, $63, $0C, $54, $0A
    db $65, $04, $A0, $03, $63, $0C, $A0, $02, $54, $0A, $A0, $01, $65, $04, $FF, $FF

Data_043_4611:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $1E, $1F, $46, $40, $05, $48, $05, $39, $05, $42, $05, $40, $05
    db $39, $05, $A0, $0C, $40, $05, $48, $05, $39, $05, $42, $05, $A0, $06, $40, $05
    db $48, $05, $A0, $03, $39, $05, $42, $05, $A0, $01, $40, $05, $48, $05, $FF, $FF

Data_043_4641:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $59, $02, $50, $07, $30, $0B, $20, $07, $A0, $07, $20, $04
    db $A0, $0E, $60, $20, $80, $30, $A0, $0A, $C1, $50, $80, $18, $FF, $FF

Data_043_465F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $27, $20, $05, $26, $05, $25, $05, $2B, $05, $30, $05, $36, $05
    db $35, $05, $3B, $05, $40, $05, $46, $05, $45, $05, $4B, $05, $50, $05, $56, $05
    db $A0, $04, $40, $05, $46, $05, $45, $05, $4B, $05, $A0, $02, $50, $05, $56, $05
    db $45, $05, $4B, $05, $A0, $01, $50, $05, $56, $05, $45, $05, $4B, $05, $FF, $FF

Data_043_469F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $5B, $08, $50, $04, $5A, $07, $40, $04, $59, $06, $30, $03
    db $58, $05, $3B, $04, $3C, $03, $5C, $03, $54, $15, $C1, $50, $A0, $08, $54, $20
    db $FF, $FF

Data_043_46C1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10C6C1, $5E

Data_043_471F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $C1, $7F, $46, $20, $46, $20, $46, $20, $A0, $08, $46, $25
    db $FF, $FF

Data_043_4731:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $2C, $03, $1F, $01, $1C, $02, $1F, $01, $67, $03, $1F, $01
    db $48, $01, $1F, $01, $2C, $03, $1F, $01, $1C, $02, $1F, $01, $A0, $08, $67, $03
    db $1F, $01, $48, $01, $1F, $01, $A0, $03, $2C, $03, $1F, $01, $A0, $0F, $50, $0C
    db $C7, $20, $A0, $07, $50, $20, $FF, $FF

Data_043_4769:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10C769, $7C0

Data_043_4F29:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10CF29, $920

Data_043_5849:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10D849, $16E

Data_043_59B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10D9B7, $2DE

Data_043_5C95:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10DC95, $21E

Data_043_5EB3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10DEB3, $342

Data_043_61F5:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $0F, $00, $63, $04, $66, $04, $68, $04, $70, $04, $60, $04, $66, $04
    db $60, $04, $63, $04, $61, $04, $66, $04, $60, $04, $68, $04, $63, $04, $A0, $08
    db $61, $04, $68, $04, $66, $04, $A0, $05, $64, $04, $68, $04, $A0, $02, $60, $04
    db $68, $04, $63, $04, $68, $02, $1F, $18, $FF, $FF

Data_043_622F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10E22F, $42

Data_043_6271:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $0F, $36, $13, $06, $1F, $01, $18, $06, $1F, $01, $1A, $06, $1F, $01
    db $22, $06, $1F, $01, $27, $06, $1F, $01, $34, $06, $A0, $08, $34, $06, $A0, $03
    db $34, $06, $A0, $02, $34, $05, $FF, $FF

Data_043_6299:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $09, $00, $13, $06, $1F, $01, $18, $06, $1F, $01, $1A, $06, $1F, $01
    db $22, $06, $1F, $01, $27, $06, $1F, $01, $34, $06, $A0, $06, $34, $06, $A0, $03
    db $34, $06, $A0, $02, $34, $05, $FF, $FF

Data_043_62C1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10E2C1, $44

Data_043_6305:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0D, $00, $C2, $40, $1F, $0A, $35, $0A, $A0, $0B, $35, $0A, $34, $0A
    db $A0, $0A, $34, $0A, $32, $0A, $32, $0A, $30, $0A, $C1, $14, $A0, $0F, $32, $09
    db $A0, $0B, $32, $09, $A0, $08, $32, $09, $A0, $05, $32, $09, $A0, $03, $32, $09
    db $A0, $02, $32, $0A, $A0, $01, $32, $0A, $1F, $10, $FF, $FF

Data_043_6341:: ; heuristic: target of a monotone pointer table; C0
    db $00, $30, $02, $02, $A2, $70, $A1, $09, $15, $0A, $A1, $02, $A2, $1F, $30, $0A
    db $30, $0A, $35, $0A, $35, $0A, $35, $0A, $35, $0A, $35, $0A, $A2, $0A, $A0, $02
    db $36, $09, $A0, $04, $36, $09, $A0, $06, $36, $09, $A0, $06, $36, $05, $1F, $35
    db $FF, $FF

Data_043_6373:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $60, $0E, $A0, $06, $60, $0B, $A0, $0F, $11, $02, $45, $03
    db $15, $01, $50, $03, $45, $03, $16, $01, $45, $02, $55, $02, $14, $01, $45, $02
    db $45, $06, $45, $03, $46, $04, $45, $06, $A0, $06, $45, $05, $A0, $04, $45, $05
    db $45, $03, $A0, $03, $45, $03, $FF, $FF

Data_043_63AB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $0F, $3D, $AE, $10, $C2, $09, $A0, $05, $54, $05, $54, $05, $A0, $08
    db $55, $05, $55, $05, $56, $05, $A0, $0C, $56, $05, $A0, $0F, $53, $05, $43, $05
    db $A0, $0A, $53, $05, $54, $05, $54, $05, $55, $05, $45, $05, $A0, $04, $55, $05
    db $56, $05, $A0, $02, $46, $05, $56, $05, $A0, $01, $56, $05, $56, $05, $FF, $FF

Data_043_63EB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $1E, $02, $23, $02, $31, $04, $12, $05, $13, $05, $C7, $20
    db $30, $10, $C0, $FE, $10, $10, $A0, $05, $C7, $30, $20, $20, $FF, $FF

Data_043_6409:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $0F, $00, $CC, $02, $40, $10, $C1, $50, $50, $23, $32, $02, $A0, $06
    db $40, $15, $FF, $FF

Data_043_641D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10E41D, $F0

Data_043_650D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10E50D, $102
    ds $19F1, $00
