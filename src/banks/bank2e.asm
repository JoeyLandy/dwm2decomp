SECTION "Bank 2E", ROMX[$4000], BANK[$2E]
    db $2E

Func_02E_4001::
    ld a, [$C529]
    cp a, $A6
    jr c, Jump_02E_400F
    ld hl, Func_099_4026
    ld b, $99
    rst $10
    ret

Jump_02E_400F::
    ld de, Data_02E_4032
    call Func_000_25C9
    ret

Func_02E_4016:: ; heuristic: follows a terminator; C0
    ld a, [$C529]
    cp a, $A6
    jr c, Jump_02E_4024
    ld hl, Func_099_4035
    ld b, $99
    rst $10
    ret

Jump_02E_4024::
    ld de, Data_02E_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_02E_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $34, $40
    dw Data_02E_4180
    dw Data_02E_4188
    dw Data_02E_41F0
    dw Data_02E_422D
    dw Data_02E_4248
    dw Data_02E_4340
    dw Data_02E_4398
    dw Data_02E_43F7
    dw Data_02E_443F
    dw Data_02E_4465
    dw Data_02E_44AE
    dw Data_02E_44D3
    dw Data_02E_45CD
    dw Data_02E_45F0
    dw Data_02E_4629
    dw Data_02E_4650
    dw Data_02E_4739
    dw Data_02E_47E3
    dw Data_02E_4828
    dw Data_02E_4885
    dw Data_02E_490A
    dw Data_02E_494E
    dw Data_02E_4A28
    dw Data_02E_4AD7
    dw Data_02E_4BA0
    dw Data_02E_4C0C
    dw Data_02E_4C0C
    dw Data_02E_4CDF
    dw Data_02E_4D20
    dw Data_02E_4D5D
    dw Data_02E_4DF3
    dw Data_02E_4E05
    dw Data_02E_4E20
    dw Data_02E_4E43
    dw Data_02E_4E5F
    dw Data_02E_4EE7
    dw Data_02E_4F2B
    dw Data_02E_4F6A
    dw Data_02E_4FE3
    dw Data_02E_505B
    dw Data_02E_509E
    dw Data_02E_510F
    dw Data_02E_512E
    dw Data_02E_5203
    dw Data_02E_5278
    dw Data_02E_5372
    dw Data_02E_5410
    dw Data_02E_5435
    dw Data_02E_54C5
    dw Data_02E_5574
    dw Data_02E_5686
    dw Data_02E_5713
    dw Data_02E_57A2
    dw Data_02E_580D
    dw Data_02E_5845
    dw Data_02E_5866
    dw Data_02E_587D
    dw Data_02E_58B0
    dw Data_02E_5918
    dw Data_02E_593F
    dw Data_02E_5960
    dw Data_02E_5999
    dw Data_02E_59B9
    dw Data_02E_59DF
    dw Data_02E_5A02
    dw Data_02E_5AC5
    dw Data_02E_5B0C
    dw Data_02E_5B23
    dw Data_02E_5B6D
    dw Data_02E_5BB2
    dw Data_02E_5BB2
    dw Data_02E_5BF4
    dw Data_02E_5C36
    dw Data_02E_5C7B
    dw Data_02E_5D1B
    dw Data_02E_5D61
    dw Data_02E_5DA8
    dw Data_02E_5E11
    dw Data_02E_5E76
    dw Data_02E_5EB7
    dw Data_02E_5EF7
    dw Data_02E_5F8D
    dw Data_02E_6001
    dw Data_02E_604B
    dw Data_02E_60F1
    dw Data_02E_610B
    dw Data_02E_6189
    dw Data_02E_61CA
    dw Data_02E_6206
    dw Data_02E_6244
    dw Data_02E_63C4
    dw Data_02E_63DC
    dw Data_02E_64BC
    dw Data_02E_65B8
    dw Data_02E_65FD
    dw Data_02E_663A
    dw Data_02E_66EF
    dw Data_02E_6796
    dw Data_02E_6834
    dw Data_02E_6876
    dw Data_02E_68B2
    dw Data_02E_68F6
    dw Data_02E_6957
    dw Data_02E_6A4C
    dw Data_02E_6AB5
    dw Data_02E_6AEF
    dw Data_02E_6B36
    dw Data_02E_6B7D
    dw Data_02E_6BFC
    dw Data_02E_6C1F
    dw Data_02E_6C44
    dw Data_02E_6C6A
    dw Data_02E_6C8F
    dw Data_02E_6CAA
    dw Data_02E_6CF1
    dw Data_02E_6D0C
    dw Data_02E_6D18
    dw Data_02E_6D62
    dw Data_02E_6D6E
    dw Data_02E_6E68
    dw Data_02E_6ED2
    dw Data_02E_6F14
    dw Data_02E_6F37
    dw Data_02E_6F95
    dw Data_02E_7011
    dw Data_02E_704B
    dw Data_02E_70D3
    dw Data_02E_70F3
    dw Data_02E_715B
    dw Data_02E_71A4
    dw Data_02E_7204
    dw Data_02E_7220
    dw Data_02E_7220
    dw Data_02E_7220
    dw Data_02E_7220
    dw Data_02E_72B2
    dw Data_02E_72D5
    dw Data_02E_7368
    dw Data_02E_7469
    dw Data_02E_74EF
    dw Data_02E_754B
    dw Data_02E_7589
    dw Data_02E_75A4
    dw Data_02E_75C7
    dw Data_02E_7631
    dw Data_02E_7697
    dw Data_02E_76FC
    dw Data_02E_7736
    dw Data_02E_7799
    dw Data_02E_784A
    dw Data_02E_7854
    dw Data_02E_7874
    dw Data_02E_787E
    dw Data_02E_78A1
    dw Data_02E_7914
    dw Data_02E_7952
    dw Data_02E_79C3
    dw Data_02E_7A1E
    dw Data_02E_7A40
    dw Data_02E_7A62
    dw Data_02E_7B0D
    dw Data_02E_7C31
    dw Data_02E_7D50
    dw Data_02E_7D8C
    dw Data_02E_7DD2
    dw Data_02E_7EA1

Data_02E_4180:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $99, $F7, $F0

Data_02E_4188:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8188, $68

Data_02E_41F0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0E, $39, $28, $31, $90, $3A, $32, $35, $36, $28, $AB, $90, $3C
    db $32, $38, $F1, $2B, $24, $39, $28, $90, $30, $32, $31, $36, $37, $28, $35, $36
    db $B5, $FA, $F7, $EF, $EE, $10, $28, $37, $90, $32, $38, $37, $90, $32, $29, $90
    db $32, $38, $35, $EF, $EE, $3A, $32, $35, $2F, $27, $99, $F7, $F0

Data_02E_422D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0A, $35, $28, $90, $3C, $32, $38, $90, $30, $24, $3C, $25, $28
    db $90, $24, $F1, $2B, $38, $30, $24, $31, $98, $FF, $F0

Data_02E_4248:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8248, $F8

Data_02E_4340:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8340, $58

Data_02E_4398:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8398, $5F

Data_02E_43F7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B83F7, $48

Data_02E_443F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2F, $2F, $32, $AB, $90, $30, $38, $31, $26, $2B, $2E
    db $2C, $31, $B5, $F1, $0E, $31, $2D, $32, $3C, $90, $3C, $32, $38, $35, $90, $36
    db $37, $24, $3C, $99, $F7, $F0

Data_02E_4465:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8465, $49

Data_02E_44AE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $40, $28, $90, $31, $32, $37, $90, $2F, $2C, $2E
    db $28, $F1, $38, $36, $B5, $90, $22, $32, $38, $90, $36, $26, $24, $35, $28, $90
    db $30, $28, $A4, $F7, $F0

Data_02E_44D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B84D3, $FA

Data_02E_45CD:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $2C, $36, $90, $2B, $32, $35, $36, $28, $90, $3A, $24
    db $36, $F1, $2B, $28, $35, $28, $90, $25, $28, $29, $32, $35, $28, $90, $38, $36
    db $B5, $F7, $F0

Data_02E_45F0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $2C, $36, $90, $0E, $2F, $39, $28, $31
    db $F1, $39, $2C, $2F, $2F, $24, $2A, $28, $B5, $FA, $F7, $EF, $EE, $22, $32, $38
    db $40, $28, $90, $24, $90, $2B, $38, $30, $24, $31, $AB, $EF, $EE, $24, $35, $28
    db $31, $41, $90, $3C, $32, $38, $98, $F7, $F0

Data_02E_4629:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $99, $90, $11, $32, $3A, $90
    db $30, $24, $3C, $F1, $12, $90, $2B, $28, $2F, $33, $90, $3C, $32, $38, $90, $37
    db $32, $27, $24, $3C, $98, $F7, $F0

Data_02E_4650:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8650, $E9

Data_02E_4739:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8739, $AA

Data_02E_47E3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B87E3, $45

Data_02E_4828:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8828, $5D

Data_02E_4885:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8885, $85

Data_02E_490A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B890A, $44

Data_02E_494E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B894E, $DA

Data_02E_4A28:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8A28, $AF

Data_02E_4AD7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8AD7, $C9

Data_02E_4BA0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8BA0, $6C

Data_02E_4C0C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8C0C, $D3

Data_02E_4CDF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8CDF, $41

Data_02E_4D20:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $11, $38, $30, $24, $31, $36, $90, $26, $24, $31, $41, $90, $25
    db $28, $F1, $37, $35, $38, $36, $37, $28, $27, $AB, $90, $25, $38, $37, $A4, $FA
    db $F7, $EF, $EE, $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $37, $26, $2B, $90
    db $32, $39, $28, $35, $EF, $EE, $0C, $3C, $24, $2F, $B5, $F7, $F0

Data_02E_4D5D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8D5D, $96

Data_02E_4DF3:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $32, $38, $31, $37, $28, $27, $90, $32, $29, $29, $A4, $F1
    db $F7, $F0

Data_02E_4E05:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $0C, $3C, $24, $2F, $A3, $90, $0E, $28, $28, $2E, $AB, $90, $F9, $00, $99
    db $F1, $11, $28, $2F, $33, $90, $30, $28, $99, $F7, $F0

Data_02E_4E20:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $24, $36, $37, $28, $35, $90, $0A, $2A, $0D, $28, $39, $2C
    db $2F, $AB, $F1, $24, $90, $2B, $38, $30, $24, $31, $AB, $90, $35, $38, $29, $29
    db $99, $F7, $F0

Data_02E_4E43:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $90, $36, $2B, $24, $2F, $2F, $90, $3A, $28
    db $F1, $27, $32, $AB, $90, $35, $38, $29, $29, $98, $F7, $F0

Data_02E_4E5F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8E5F, $88

Data_02E_4EE7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8EE7, $44

Data_02E_4F2B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $37, $3E, $90, $3A, $2B, $24, $37, $90, $3A, $28
    db $43, $2F, $F1, $27, $32, $AB, $90, $2E, $2C, $27, $B5, $FA, $F7, $EF, $EE, $22
    db $32, $38, $40, $28, $90, $32, $38, $35, $90, $27, $2C, $31, $31, $28, $35, $EF
    db $EE, $37, $32, $27, $24, $3C, $AB, $90, $35, $38, $29, $29, $99, $F7, $F0

Data_02E_4F6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8F6A, $79

Data_02E_4FE3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B8FE3, $78

Data_02E_505B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B905B, $43

Data_02E_509E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B909E, $71

Data_02E_510F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1B, $32, $2F, $37, $AB, $90, $3A, $24, $2C, $37, $99, $F1, $A4
    db $10, $32, $31, $28, $90, $24, $2F, $35, $28, $24, $27, $3C, $A4, $F7, $F0

Data_02E_512E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B912E, $D5

Data_02E_5203:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9203, $75

Data_02E_5278:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9278, $FA

Data_02E_5372:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9372, $9E

Data_02E_5410:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0D, $2C, $27, $31, $41, $90, $12, $90, $24, $36, $2E, $90, $3C
    db $32, $38, $F1, $37, $32, $90, $33, $35, $32, $37, $28, $26, $37, $90, $0C, $3C
    db $24, $2F, $98, $F7, $F0

Data_02E_5435:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9435, $90

Data_02E_54C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B94C5, $AF

Data_02E_5574:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9574, $112

Data_02E_5686:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9686, $8D

Data_02E_5713:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9713, $8F

Data_02E_57A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B97A2, $6B

Data_02E_580D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $14, $2C, $2E, $2C, $2E, $2C, $AB, $90, $3A, $2B, $24, $37, $F1
    db $2D, $38, $36, $37, $90, $3C, $32, $38, $98, $FA, $F7, $EF, $EE, $1D, $2B, $24
    db $37, $3E, $90, $38, $37, $37, $28, $35, $2F, $3C, $EF, $EE, $2F, $24, $38, $2A
    db $2B, $24, $25, $2F, $28, $99, $F7, $F0

Data_02E_5845:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $1B, $32, $2F, $37, $A3, $90, $1C, $2B, $38, $37, $90, $38, $33, $99, $F1
    db $10, $2C, $39, $28, $90, $25, $24, $26, $2E, $90, $0C, $3C, $24, $2F, $99, $F7
    db $F0

Data_02E_5866:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $38, $30, $33, $2B, $A4, $F1, $11, $32, $3A, $90, $25, $32
    db $35, $2C, $31, $2A, $A4, $F7, $F0

Data_02E_587D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $1B, $32, $2F, $37, $A3, $90, $1E, $35, $35, $35, $2A, $2B, $A4, $F1, $F9
    db $00, $A4, $90, $19, $2F, $28, $24, $36, $28, $A4, $FA, $F7, $EF, $EE, $19, $2F
    db $28, $24, $36, $28, $90, $36, $24, $39, $28, $90, $0C, $3C, $24, $2F, $99, $EF
    db $EE, $F7, $F0

Data_02E_58B0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B98B0, $68

Data_02E_5918:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $AB, $90, $3C, $32, $38, $90, $24, $2A, $24
    db $2C, $31, $98, $F1, $1B, $38, $27, $28, $AB, $90, $35, $38, $27, $28, $AB, $90
    db $35, $38, $27, $28, $99, $F7, $F0

Data_02E_593F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $9C, $3A, $2B, $24, $37, $98, $90, $12, $A4, $F1, $15
    db $32, $36, $37, $90, $37, $32, $90, $24, $90, $26, $2B, $2C, $2F, $27, $98, $F7
    db $F0

Data_02E_5960:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $1B, $32, $2F, $37, $A3, $90, $20, $32, $3A, $A4, $90, $F9, $00, $AB, $F1
    db $3C, $32, $38, $40, $28, $90, $37, $32, $38, $2A, $2B, $B5, $FA, $F7, $EF, $EE
    db $18, $2B, $99, $90, $0C, $3C, $24, $2F, $99, $EF, $EE, $20, $2B, $28, $35, $28
    db $3E, $90, $0C, $3C, $24, $2F, $98, $F7, $F0

Data_02E_5999:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $1B, $32, $2F, $37, $A3, $90, $0C, $3C, $24, $2F, $99, $90, $0A, $35, $28
    db $F1, $3C, $32, $38, $90, $18, $14, $98, $90, $0C, $3C, $24, $2F, $99, $F7, $F0

Data_02E_59B9:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $0C, $3C, $24, $2F, $A3, $90, $0B, $2C, $2A, $90, $25, $35, $32, $37, $2B
    db $28, $35, $99, $F1, $12, $90, $3A, $24, $36, $90, $36, $32, $90, $36, $26, $24
    db $35, $28, $27, $99, $F7, $F0

Data_02E_59DF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $1B, $32, $2F, $37, $A3, $90, $22, $32, $38, $40, $28, $90, $36, $24, $29
    db $28, $F1, $31, $32, $3A, $B5, $90, $F9, $00, $90, $27, $2C, $27, $90, $2C, $37
    db $B5, $F7, $F0

Data_02E_5A02:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9A02, $C3

Data_02E_5AC5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9AC5, $47

Data_02E_5B0C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $0C, $3C, $24, $2F, $A3, $90, $F9, $00, $AB, $90, $37, $2B, $24, $31, $2E
    db $F1, $3C, $32, $38, $A4, $F7, $F0

Data_02E_5B23:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9B23, $4A

Data_02E_5B6D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9B6D, $45

Data_02E_5BB2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9BB2, $42

Data_02E_5BF4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9BF4, $42

Data_02E_5C36:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9C36, $45

Data_02E_5C7B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9C7B, $A0

Data_02E_5D1B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9D1B, $46

Data_02E_5D61:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9D61, $47

Data_02E_5DA8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9DA8, $69

Data_02E_5E11:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9E11, $65

Data_02E_5E76:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9E76, $41

Data_02E_5EB7:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $22, $32, $38, $A4, $90, $22, $32, $38, $40, $28, $90, $24, $F1
    db $36, $24, $39, $24, $2A, $28, $90, $25, $38, $37, $90, $12, $90, $30, $38, $36
    db $37, $FA, $F7, $EF, $EE, $37, $2B, $24, $31, $2E, $90, $3C, $32, $38, $90, $24
    db $36, $90, $24, $EF, $EE, $26, $32, $38, $35, $37, $28, $36, $3C, $B5, $F7, $F0

Data_02E_5EF7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9EF7, $96

Data_02E_5F8D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B9F8D, $74

Data_02E_6001:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA001, $4A

Data_02E_604B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA04B, $A6

Data_02E_60F1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $1D, $32, $32, $90, $36, $37, $35, $32, $31, $2A, $A4, $F1
    db $0A, $35, $35, $32, $32, $32, $2B, $99, $F7, $F0

Data_02E_610B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA10B, $7E

Data_02E_6189:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA189, $41

Data_02E_61CA:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $32
    db $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $0A, $90, $36, $2B, $24, $35, $33, $90
    db $24, $35, $32, $30, $24, $90, $32, $29, $EF, $EE, $30, $28, $27, $2C, $26, $2C
    db $31, $28, $90, $3A, $24, $29, $37, $28, $27, $A4, $F7, $F0

Data_02E_6206:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $32
    db $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $1C, $37, $28, $3A, $90, $36, $2C, $30
    db $30, $28, $35, $28, $27, $90, $24, $31, $27, $EF, $EE, $25, $38, $25, $25, $2F
    db $28, $27, $90, $2C, $31, $90, $24, $90, $33, $32, $37, $B5, $F7, $F0

Data_02E_6244:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA244, $180

Data_02E_63C4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $2C, $2C, $A4, $90, $10, $2A, $3D, $3D, $A4, $F1, $19, $2C
    db $2C, $2C, $2C, $2C, $2C, $A4, $F7, $F0

Data_02E_63DC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA3DC, $E0

Data_02E_64BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA4BC, $FC

Data_02E_65B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA5B8, $45

Data_02E_65FD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $2C, $35, $24, $2F, $A3, $90, $12, $90, $31, $28, $28, $27, $90, $2B
    db $28, $2F, $33, $F1, $3A, $2C, $37, $2B, $90, $30, $3C, $90, $36, $37, $38, $27
    db $2C, $28, $36, $B5, $FA, $F7, $EF, $EE, $20, $2C, $2F, $2F, $90, $3C, $32, $38
    db $90, $2B, $28, $2F, $33, $90, $30, $28, $98, $EF, $EE, $FF, $F0

Data_02E_663A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA63A, $B5

Data_02E_66EF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA6EF, $A7

Data_02E_6796:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA796, $9E

Data_02E_6834:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA834, $42

Data_02E_6876:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $25, $24, $35, $35, $28, $2F, $B5, $FA, $F7, $EF, $EE, $12, $37
    db $90, $29, $24, $2C, $31, $37, $2F, $3C, $90, $36, $30, $28, $2F, $2F, $28, $27
    db $EF, $EE, $32, $29, $90, $30, $32, $2F, $27, $A4, $F7, $F0

Data_02E_68B2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA8B2, $44

Data_02E_68F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA8F6, $61

Data_02E_6957:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BA957, $F5

Data_02E_6A4C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BAA4C, $69

Data_02E_6AB5:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $25, $24, $35, $35, $28, $2F, $B5, $FA, $F7, $EF, $EE, $1D, $2B
    db $28, $35, $28, $90, $3A, $24, $36, $90, $31, $32, $37, $2B, $2C, $31, $2A, $EF
    db $EE, $2C, $31, $36, $2C, $27, $28, $B5, $F7, $F0

Data_02E_6AEF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BAAEF, $47

Data_02E_6B36:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BAB36, $47

Data_02E_6B7D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BAB7D, $7F

Data_02E_6BFC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $1B, $18, $0F, $0E, $1C, $1C, $18, $1B, $A4, $90, $1C, $0A
    db $22, $F1, $10, $1E, $0A, $1B, $0D, $90, $1D, $1B, $0E, $0A, $1C, $1E, $1B, $0E
    db $A4, $F7, $F0

Data_02E_6C1F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $1B, $18, $A4, $90, $1C, $18, $1B, $A4, $90, $0A, $22, $A4
    db $F1, $10, $10, $10, $10, $1E, $0A, $1B, $0D, $A4, $90, $1D, $1B, $0E, $23, $23
    db $23, $1D, $A4, $F7, $F0

Data_02E_6C44:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $27, $24, $30, $24, $2A, $28, $90, $24, $33, $33, $28, $24
    db $35, $36, $F1, $37, $32, $90, $2B, $24, $39, $28, $90, $3A, $32, $35, $36, $28
    db $31, $28, $27, $B5, $F7, $F0

Data_02E_6C6A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $1B, $18, $A4, $90, $1C, $18, $1B, $A4, $90, $0A, $22, $A4
    db $F1, $10, $10, $10, $10, $1E, $0A, $1B, $0D, $A4, $90, $1D, $1B, $0E, $23, $23
    db $23, $1D, $A4, $F7, $F0

Data_02E_6C8F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $12, $19, $12, $19, $12, $A4, $F1, $10, $10, $10, $10, $10
    db $10, $0A, $10, $0A, $10, $0A, $10, $0A, $A4, $F7, $F0

Data_02E_6CAA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BACAA, $47

Data_02E_6CF1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $12, $19, $12, $19, $12, $A4, $F1, $10, $10, $10, $10, $10
    db $10, $0A, $10, $0A, $10, $0A, $10, $0A, $A4, $F7, $F0

Data_02E_6D0C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $12, $A4, $90, $19, $12, $A4, $F7, $F0

Data_02E_6D18:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BAD18, $4A

Data_02E_6D62:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $12, $A4, $90, $19, $12, $A4, $F7, $F0

Data_02E_6D6E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BAD6E, $FA

Data_02E_6E68:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BAE68, $6A

Data_02E_6ED2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BAED2, $42

Data_02E_6F14:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $1B, $18, $0F, $0E, $A4, $90, $1C, $18, $1B, $A4, $F1, $18
    db $1B, $0D, $0E, $1B, $A4, $90, $16, $1E, $1C, $1D, $A4, $90, $18, $0B, $0E, $22
    db $A4, $F7, $F0

Data_02E_6F37:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BAF37, $5E

Data_02E_6F95:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BAF95, $7C

Data_02E_7011:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $25, $24, $35, $35, $28, $2F, $B5, $FA, $F7, $EF, $EE, $1D, $2B
    db $28, $35, $28, $90, $3A, $24, $36, $90, $31, $32, $37, $2B, $2C, $31, $2A, $EF
    db $EE, $2C, $31, $36, $2C, $27, $28, $B5, $F7, $F0

Data_02E_704B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB04B, $88

Data_02E_70D3:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1, $37
    db $2B, $28, $90, $25, $2F, $38, $28, $90, $36, $37, $32, $31, $28, $B5, $F7, $F0

Data_02E_70F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB0F3, $68

Data_02E_715B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB15B, $49

Data_02E_71A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB1A4, $60

Data_02E_7204:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $1C, $30, $24, $35, $37, $0B, $32, $32, $2E, $B5, $F7, $F0

Data_02E_7220:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB220, $92

Data_02E_72B2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $2C, $35, $24, $2F, $A3, $90, $1F, $2C, $36, $2C, $37, $90, $30, $28
    db $F1, $3A, $2B, $28, $31, $90, $3C, $32, $38, $40, $28, $90, $29, $35, $28, $28
    db $B5, $F7, $F0

Data_02E_72D5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB2D5, $93

Data_02E_7368:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB368, $101

Data_02E_7469:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB469, $86

Data_02E_74EF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB4EF, $5C

Data_02E_754B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $0E, $15, $0C, $18, $16, $0E, $B5, $F1, $12, $90, $0A, $16
    db $90, $1B, $18, $0B, $9C, $17, $B5, $FA, $F7, $EF, $EE, $12, $90, $1C, $0E, $1B
    db $1F, $0E, $90, $0A, $1C, $90, $1D, $11, $0E, $EF, $EE, $19, $1B, $18, $0F, $0E
    db $1C, $1C, $18, $1B, $95, $1C, $90, $0A, $12, $0D, $0E, $B5, $F7, $F0

Data_02E_7589:: ; heuristic: target of a monotone pointer table; C0
    db $A4, $1B, $32, $25, $32, $36, $37, $28, $35, $90, $36, $37, $32, $33, $33, $28
    db $27, $F1, $30, $32, $39, $2C, $31, $2A, $A4, $F7, $F0

Data_02E_75A4:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $90, $36, $37, $32, $33, $33, $28, $27
    db $F1, $30, $32, $39, $2C, $31, $2A, $90, $28, $31, $37, $2C, $35, $28, $2F, $3C
    db $A4, $F7, $F0

Data_02E_75C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB5C7, $6A

Data_02E_7631:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB631, $66

Data_02E_7697:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB697, $65

Data_02E_76FC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0A, $35, $28, $90, $3C, $32, $38, $35, $F1, $30, $32, $31, $36
    db $37, $28, $35, $36, $90, $2A, $32, $32, $27, $98, $FA, $F7, $EF, $EE, $12, $90
    db $27, $32, $31, $41, $90, $2F, $2C, $2E, $28, $90, $25, $24, $27, $EF, $EE, $30
    db $32, $31, $36, $37, $28, $35, $36, $99, $F7, $F0

Data_02E_7736:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB736, $63

Data_02E_7799:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB799, $B1

Data_02E_784A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $2C, $2A, $2B, $A4, $F7, $F0

Data_02E_7854:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $32, $2F, $27, $90, $30, $24, $31, $3E, $90, $36, $2C, $2A
    db $2B, $F1, $36, $32, $38, $31, $27, $28, $27, $90, $36, $24, $27, $A4, $F7, $F0

Data_02E_7874:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1C, $2C, $2A, $2B, $A4, $F7, $F0

Data_02E_787E:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $32, $2F, $27, $90, $3A, $32, $30, $24, $31, $3E, $F1, $36
    db $2C, $2A, $2B, $90, $3A, $24, $36, $90, $27, $28, $36, $32, $2F, $24, $37, $28
    db $A4, $F7, $F0

Data_02E_78A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB8A1, $73

Data_02E_7914:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $28, $90, $32, $2F, $27, $90, $33, $28, $32, $33, $2F
    db $28, $F1, $24, $26, $35, $32, $36, $36, $90, $37, $2B, $28, $90, $3A, $24, $3C
    db $FA, $F7, $EF, $EE, $2F, $32, $32, $2E, $90, $39, $28, $35, $3C, $90, $36, $24
    db $27, $EF, $EE, $35, $28, $26, $28, $31, $37, $2F, $3C, $B5, $F7, $F0

Data_02E_7952:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB952, $71

Data_02E_79C3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BB9C3, $5B

Data_02E_7A1E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2F, $2F, $32, $99, $90, $20, $2B, $24, $37, $90, $30
    db $24, $3C, $F1, $12, $90, $27, $32, $90, $29, $32, $35, $90, $3C, $32, $38, $98
    db $F7, $F0

Data_02E_7A40:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $90, $37, $32, $90, $32, $38
    db $35, $F1, $37, $35, $24, $39, $28, $2F, $28, $35, $3E, $90, $2C, $31, $31, $B5
    db $F7, $F0

Data_02E_7A62:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BBA62, $AB

Data_02E_7B0D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BBB0D, $124

Data_02E_7C31:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BBC31, $11F

Data_02E_7D50:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $90, $26, $24, $31, $41, $90, $26, $32, $38, $31, $37, $90
    db $32, $31, $F1, $3C, $32, $38, $35, $90, $36, $38, $33, $33, $32, $35, $37, $98
    db $FA, $F7, $EF, $EE, $1D, $2B, $24, $37, $3E, $90, $35, $28, $24, $2F, $2F, $3C
    db $90, $37, $32, $32, $EF, $EE, $25, $24, $27, $A4, $F7, $F0

Data_02E_7D8C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BBD8C, $46

Data_02E_7DD2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BBDD2, $CF

Data_02E_7EA1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BBEA1, $90
    ds $CF, $00
