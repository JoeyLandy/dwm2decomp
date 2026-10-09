SECTION "Bank 98", ROMX[$4000], BANK[$98]
    db $98

Func_098_4001::
    ld de, Data_098_4070
    ld a, [$C529]
    sub a, $8A
    ld [$C529], a
    call Func_000_25C9
    ret

Func_098_4010:: ; heuristic: follows a terminator; C0
    ld de, Data_098_4070
    ld a, [$C529]
    sub a, $8A
    ld [$C529], a
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Func_098_4026::
    ld de, Data_098_572E
    ld a, [$C529]
    sub a, $91
    ld [$C529], a
    call Func_000_25C9
    ret

Func_098_4035:: ; heuristic: follows a terminator; C0
    ld de, Data_098_572E
    ld a, [$C529]
    sub a, $91
    ld [$C529], a
    call Func_000_25FE
    ret
    db $CD, $26, $40, $CD, $11, $26, $C9

Func_098_404B::
    ld de, Data_098_7032
    ld a, [$C529]
    sub a, $DE
    ld [$C529], a
    call Func_000_25C9
    ret

Func_098_405A:: ; heuristic: follows a terminator; C0
    ld de, Data_098_7032
    ld a, [$C529]
    sub a, $DE
    ld [$C529], a
    call Func_000_25FE
    ret
    db $CD, $4B, $40, $CD, $11, $26, $C9

Data_098_4070:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $72, $40
    dw Data_098_4154
    dw Data_098_4255
    dw Data_098_4275
    dw Data_098_4302
    dw Data_098_4359
    dw Data_098_43E8
    dw Data_098_4454
    dw Data_098_449D
    dw Data_098_4526
    dw Data_098_4598
    dw Data_098_464F
    dw Data_098_4705
    dw Data_098_47C0
    dw Data_098_487A
    dw Data_098_489A
    dw Data_098_48E7
    dw Data_098_4948
    dw Data_098_4990
    dw Data_098_49F7
    dw Data_098_4A3A
    dw Data_098_4A7A
    dw Data_098_4B0A
    dw Data_098_4B9B
    dw Data_098_4BBF
    dw Data_098_4BE4
    dw Data_098_4C09
    dw Data_098_4C13
    dw Data_098_4D3E
    dw Data_098_4DCF
    dw Data_098_4E0A
    dw Data_098_4EA4
    dw Data_098_4F06
    dw Data_098_4F6C
    dw Data_098_4FD4
    dw Data_098_5035
    dw Data_098_50C6
    dw Data_098_5198
    dw Data_098_5208
    dw Data_098_52BF
    dw Data_098_52E1
    dw Data_098_5303
    dw Data_098_5322
    dw Data_098_5344
    dw Data_098_53D7
    dw Data_098_548F
    dw Data_098_55E9
    dw Data_098_560F
    dw Data_098_56A2
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_5723
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D
    dw Data_098_572D

Data_098_4154:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260154, $101

Data_098_4255:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2F, $2F, $32, $99, $90, $11, $32, $3A, $90, $30, $24
    db $3C, $90, $12, $F1, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $98, $F7, $F0

Data_098_4275:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260275, $8D

Data_098_4302:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260302, $57

Data_098_4359:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260359, $8F

Data_098_43E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2603E8, $6C

Data_098_4454:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260454, $49

Data_098_449D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26049D, $89

Data_098_4526:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260526, $72

Data_098_4598:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260598, $B7

Data_098_464F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26064F, $B6

Data_098_4705:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260705, $BB

Data_098_47C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2607C0, $BA

Data_098_487A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $0C, $24, $36, $37, $2F, $28, $90, $2C, $36
    db $90, $2C, $31, $F1, $24, $31, $90, $38, $33, $35, $32, $24, $35, $B5, $F7, $F0

Data_098_489A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26089A, $4D

Data_098_48E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2608E7, $61

Data_098_4948:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260948, $48

Data_098_4990:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260990, $67

Data_098_49F7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2609F7, $43

Data_098_4A3A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $40, $28, $90, $2B, $28, $35, $28, $90, $37, $32
    db $F1, $26, $2B, $28, $28, $35, $90, $15, $24, $27, $3C, $90, $22, $38, $31, $24
    db $B5, $FA, $F7, $EF, $EE, $19, $2F, $28, $24, $36, $28, $90, $2A, $32, $90, $35
    db $2C, $2A, $2B, $37, $EF, $EE, $37, $2B, $35, $32, $38, $2A, $2B, $B5, $F7, $F0

Data_098_4A7A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260A7A, $90

Data_098_4B0A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260B0A, $91

Data_098_4B9B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0E, $31, $32, $38, $2A, $2B, $A4, $90, $0E, $31, $32, $38, $2A
    db $2B, $F1, $32, $29, $90, $37, $2B, $24, $37, $90, $27, $24, $31, $26, $2C, $31
    db $2A, $99, $F7, $F0

Data_098_4BBF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $24, $30, $90, $37, $2B, $28, $90, $14, $2C, $31, $2A
    db $B5, $F1, $20, $2B, $24, $37, $90, $2C, $36, $90, $3C, $32, $38, $35, $90, $24
    db $26, $37, $98, $F7, $F0

Data_098_4BE4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $2C, $31, $2A, $A3, $90, $16, $24, $2A, $31, $2C, $29, $2C, $26, $28
    db $31, $37, $99, $F1, $0D, $32, $31, $41, $90, $3C, $32, $38, $90, $24, $2A, $35
    db $28, $28, $98, $F7, $F0

Data_098_4C09:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $A4, $A4, $A4, $A4, $F1, $F7, $F0

Data_098_4C13:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260C13, $12B

Data_098_4D3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260D3E, $91

Data_098_4DCF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $2C, $36, $90, $37, $2B, $28, $F1, $0C
    db $24, $36, $37, $2F, $28, $90, $32, $29, $90, $0E, $36, $37, $35, $2C, $24, $AB
    db $FA, $F7, $EF, $EE, $37, $2B, $28, $90, $28, $24, $36, $37, $28, $35, $31, $EF
    db $EE, $2E, $2C, $31, $2A, $27, $32, $30, $B5, $F7, $F0

Data_098_4E0A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260E0A, $9A

Data_098_4EA4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260EA4, $62

Data_098_4F06:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260F06, $66

Data_098_4F6C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260F6C, $68

Data_098_4FD4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $260FD4, $61

Data_098_5035:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261035, $91

Data_098_50C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2610C6, $D2

Data_098_5198:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261198, $70

Data_098_5208:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261208, $B7

Data_098_52BF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $2C, $36, $90, $31, $32, $90, $33, $2F
    db $24, $26, $28, $F1, $29, $32, $35, $90, $24, $90, $26, $2B, $2C, $2F, $27, $99
    db $F7, $F0

Data_098_52E1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $98, $90, $0A, $31, $90, $28, $31, $39, $32, $3C, $F1
    db $29, $35, $32, $30, $90, $37, $2B, $28, $90, $36, $33, $2C, $35, $2C, $37, $99
    db $F7, $F0

Data_098_5303:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $25, $28, $2A, $90, $3C, $32, $38, $35, $F1, $33, $24
    db $35, $27, $32, $31, $AB, $90, $33, $2F, $28, $24, $36, $28, $99, $F7, $F0

Data_098_5322:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2F, $2F, $32, $99, $90, $20, $2B, $24, $37, $90, $30
    db $24, $3C, $F1, $12, $90, $27, $32, $90, $29, $32, $35, $90, $3C, $32, $38, $98
    db $F7, $F0

Data_098_5344:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261344, $93

Data_098_53D7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2613D7, $B8

Data_098_548F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26148F, $15A

Data_098_55E9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $AB, $90, $3C, $32, $38, $40, $28, $90, $35, $38, $36
    db $2B, $28, $27, $F1, $29, $32, $35, $90, $37, $2C, $30, $28, $A4, $90, $1C, $32
    db $35, $35, $3C, $A4, $F7, $F0

Data_098_560F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26160F, $93

Data_098_56A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2616A2, $81

Data_098_5723:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $A4, $A4, $A4, $A4, $98, $F7, $F0

Data_098_572D:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_098_572E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $57
    dw Data_098_580E
    dw Data_098_588B
    dw Data_098_58FC
    dw Data_098_59BC
    dw Data_098_5A3E
    dw Data_098_5A88
    dw Data_098_5B1C
    dw Data_098_5B59
    dw Data_098_5BC0
    dw Data_098_5BDD
    dw Data_098_5C21
    dw Data_098_5CAC
    dw Data_098_5CF9
    dw Data_098_5D36
    dw Data_098_5D78
    dw Data_098_5D98
    dw Data_098_5DBF
    dw Data_098_5E02
    dw Data_098_5E43
    dw Data_098_5E8F
    dw Data_098_5F01
    dw Data_098_5F72
    dw Data_098_6075
    dw Data_098_6093
    dw Data_098_60CF
    dw Data_098_6103
    dw Data_098_6151
    dw Data_098_6151
    dw Data_098_6151
    dw Data_098_6151
    dw Data_098_6151
    dw Data_098_6151
    dw Data_098_623D
    dw Data_098_6259
    dw Data_098_62A5
    dw Data_098_6391
    dw Data_098_6412
    dw Data_098_64B9
    dw Data_098_64F5
    dw Data_098_6567
    dw Data_098_6588
    dw Data_098_65CC
    dw Data_098_6630
    dw Data_098_66D1
    dw Data_098_6731
    dw Data_098_67B8
    dw Data_098_67EF
    dw Data_098_6812
    dw Data_098_684A
    dw Data_098_68D8
    dw Data_098_6920
    dw Data_098_6983
    dw Data_098_69C5
    dw Data_098_6A42
    dw Data_098_6ABF
    dw Data_098_6B5B
    dw Data_098_6BEC
    dw Data_098_6C4F
    dw Data_098_6CCA
    dw Data_098_6D48
    dw Data_098_6DA2
    dw Data_098_6DDA
    dw Data_098_6E49
    dw Data_098_6E85
    dw Data_098_6EDC
    dw Data_098_6F69
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031
    dw Data_098_7031

Data_098_580E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26180E, $7D

Data_098_588B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26188B, $71

Data_098_58FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2618FC, $C0

Data_098_59BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2619BC, $82

Data_098_5A3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261A3E, $4A

Data_098_5A88:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261A88, $94

Data_098_5B1C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $0C, $24, $36, $37, $2F, $28, $90, $2C, $36
    db $F1, $31, $32, $3A, $90, $30, $24, $31, $24, $2A, $28, $27, $90, $25, $3C, $90
    db $24, $2F, $2F, $FA, $F7, $EF, $EE, $32, $29, $90, $38, $36, $90, $2C, $31, $90
    db $37, $2B, $28, $90, $37, $32, $3A, $31, $B5, $EF, $EE, $F7, $F0

Data_098_5B59:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261B59, $67

Data_098_5BC0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $28, $35, $28, $90, $2B, $24, $36, $90, $32, $38, $35
    db $F1, $14, $2C, $31, $2A, $90, $2A, $32, $31, $28, $98, $F7, $F0

Data_098_5BDD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261BDD, $44

Data_098_5C21:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261C21, $8B

Data_098_5CAC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261CAC, $4D

Data_098_5CF9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $16, $24, $3C, $32, $35, $90, $2C, $36, $F1
    db $25, $28, $3C, $32, $31, $27, $90, $2B, $28, $35, $28, $B5, $FA, $F7, $EF, $EE
    db $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $37, $26, $2B, $90, $3C, $32, $38
    db $35, $EF, $EE, $30, $24, $31, $31, $28, $35, $36, $B5, $F7, $F0

Data_098_5D36:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261D36, $42

Data_098_5D78:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $2F, $28, $24, $36, $28, $27, $90, $37, $2B, $28, $F1
    db $2A, $35, $24, $39, $28, $3E, $90, $25, $38, $37, $37, $32, $31, $B5, $F7, $F0

Data_098_5D98:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $26, $24, $36, $37, $2F, $28, $3E, $90, $2F
    db $32, $35, $27, $F1, $36, $38, $30, $30, $32, $31, $36, $90, $30, $32, $31, $36
    db $37, $28, $35, $36, $A4, $F7, $F0

Data_098_5DBF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261DBF, $43

Data_098_5E02:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261E02, $41

Data_098_5E43:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261E43, $4C

Data_098_5E8F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261E8F, $72

Data_098_5F01:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261F01, $71

Data_098_5F72:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $261F72, $103

Data_098_6075:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $A4, $1D, $2B, $2C, $36, $90, $3A, $24, $3C, $A4, $F1, $A4
    db $11, $28, $35, $28, $A4, $90, $A4, $11, $28, $35, $28, $A4, $F7, $F0

Data_098_6093:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $A4, $20, $2B, $28, $35, $28, $90, $2C, $36, $90, $30, $3C, $F1
    db $26, $24, $36, $2E, $28, $37, $A4, $90, $20, $2B, $28, $35, $28, $A4, $FA, $F7
    db $EF, $EE, $1B, $2C, $31, $2A, $90, $37, $2B, $28, $90, $25, $28, $2F, $2F, $A4
    db $EF, $EE, $A4, $19, $2F, $28, $24, $36, $28, $A4, $F7, $F0

Data_098_60CF:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $31
    db $32, $37, $2C, $26, $28, $B5, $FA, $F7, $EF, $EE, $95, $10, $38, $2C, $27, $28
    db $90, $37, $2B, $28, $90, $2F, $32, $36, $37, $EF, $EE, $36, $32, $38, $2F, $36
    db $A4, $95, $F7, $F0

Data_098_6103:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262103, $4E

Data_098_6151:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262151, $EC

Data_098_623D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $10, $32, $32, $27, $99, $90, $15, $28, $37, $3E, $90, $2A, $28
    db $37, $F1, $36, $37, $24, $35, $37, $28, $27, $99, $F7, $F0

Data_098_6259:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262259, $4C

Data_098_62A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2622A5, $EC

Data_098_6391:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262391, $81

Data_098_6412:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262412, $A7

Data_098_64B9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $29, $90, $3C, $32, $38, $90, $28, $24, $37, $90, $24, $31
    db $3C, $F1, $0B, $24, $27, $16, $28, $24, $37, $90, $2F, $2C, $2E, $28, $90, $30
    db $28, $AB, $FA, $F7, $EF, $EE, $3C, $32, $38, $43, $2F, $90, $2A, $28, $37, $EF
    db $EE, $33, $32, $2C, $36, $32, $31, $28, $27, $B5, $F7, $F0

Data_098_64F5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2624F5, $72

Data_098_6567:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $32, $32, $27, $99, $90, $15, $28, $37, $3E, $90, $2A, $28
    db $37, $F1, $37, $2B, $2C, $36, $90, $36, $37, $24, $35, $37, $28, $27, $99, $F7
    db $F0

Data_098_6588:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262588, $44

Data_098_65CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2625CC, $64

Data_098_6630:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262630, $A1

Data_098_66D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2626D1, $60

Data_098_6731:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262731, $87

Data_098_67B8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $2F, $2C, $2E, $28, $90, $3C, $32, $38, $35, $F1, $36
    db $37, $3C, $2F, $28, $99, $FA, $F7, $EF, $EE, $15, $28, $37, $3E, $90, $2A, $28
    db $37, $90, $36, $37, $24, $35, $37, $28, $27, $EF, $EE, $3A, $2C, $37, $2B, $90
    db $37, $2B, $2C, $36, $B5, $F7, $F0

Data_098_67EF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $98, $90, $0A, $35, $28, $90, $3C, $32, $38
    db $F1, $36, $38, $35, $28, $90, $24, $25, $32, $38, $37, $90, $37, $2B, $24, $37
    db $98, $F7, $F0

Data_098_6812:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2F, $2F, $90, $35, $2C, $2A, $2B, $37, $3C, $99, $F1, $FA
    db $F7, $EF, $EE, $F3, $20, $28, $43, $2F, $90, $27, $32, $90, $37, $2B, $2C, $36
    db $90, $24, $2A, $24, $2C, $31, $EF, $EE, $31, $28, $3B, $37, $90, $37, $2C, $30
    db $28, $90, $37, $32, $32, $99, $F7, $F0

Data_098_684A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26284A, $8E

Data_098_68D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2628D8, $48

Data_098_6920:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262920, $63

Data_098_6983:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262983, $42

Data_098_69C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2629C5, $7D

Data_098_6A42:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262A42, $7D

Data_098_6ABF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262ABF, $9C

Data_098_6B5B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262B5B, $91

Data_098_6BEC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262BEC, $63

Data_098_6C4F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262C4F, $7B

Data_098_6CCA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262CCA, $7E

Data_098_6D48:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262D48, $5A

Data_098_6DA2:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $36
    db $2B, $28, $2F, $29, $B5, $FA, $F7, $EF, $EE, $F9, $00, $90, $32, $25, $37, $24
    db $2C, $31, $28, $27, $90, $24, $EF, $EE, $16, $24, $2A, $2C, $26, $90, $14, $28
    db $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_098_6DDA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262DDA, $6F

Data_098_6E49:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $3A
    db $24, $36, $90, $29, $38, $2F, $2F, $90, $32, $29, $EF, $EE, $28, $36, $32, $37
    db $28, $35, $2C, $26, $90, $2D, $38, $31, $2E, $B5, $F7, $F0

Data_098_6E85:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262E85, $57

Data_098_6EDC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262EDC, $8D

Data_098_6F69:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $262F69, $C8

Data_098_7031:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_098_7032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $34, $70
    dw Data_098_7078
    dw Data_098_7130
    dw Data_098_714B
    dw Data_098_71AC
    dw Data_098_71EA
    dw Data_098_7227
    dw Data_098_7288
    dw Data_098_72C5
    dw Data_098_7323
    dw Data_098_7369
    dw Data_098_73EC
    dw Data_098_7496
    dw Data_098_7542
    dw Data_098_75E6
    dw Data_098_7684
    dw Data_098_7755
    dw Data_098_781C
    dw Data_098_78FD
    dw Data_098_7A0B
    dw Data_098_7A4D
    dw Data_098_7AE9
    dw Data_098_7B1F
    dw Data_098_7BA4
    dw Data_098_7BC8
    dw Data_098_7C2F
    dw Data_098_7C75
    dw Data_098_7CB4
    dw Data_098_7CD2
    dw Data_098_7CD2
    dw Data_098_7CD2
    dw Data_098_7CD2
    dw Data_098_7CD2
    dw Data_098_7CD2
    dw Data_098_7CD2

Data_098_7078:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263078, $B8

Data_098_7130:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $28, $24, $38, $37, $2C, $29, $38, $2F, $90, $39, $32, $2C, $26
    db $28, $F1, $28, $26, $2B, $32, $28, $27, $A4, $F7, $F0

Data_098_714B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26314B, $61

Data_098_71AC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $28, $28, $2C, $31, $2A, $90, $37, $2B, $28, $F1, $2F, $2C
    db $39, $28, $2F, $2C, $31, $28, $36, $36, $90, $32, $29, $FA, $F7, $EF, $EE, $15
    db $24, $27, $3C, $90, $22, $38, $31, $24, $90, $2F, $2C, $29, $37, $36, $EF, $EE
    db $32, $38, $35, $90, $36, $33, $2C, $35, $2C, $37, $36, $B5, $F7, $F0

Data_098_71EA:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $32, $30, $25, $36, $37, $32, $31, $28, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28
    db $35, $28, $90, $24, $33, $33, $28, $24, $35, $28, $27, $90, $37, $32, $EF, $EE
    db $25, $28, $90, $31, $32, $37, $2B, $2C, $31, $2A, $B5, $F7, $F0

Data_098_7227:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263227, $61

Data_098_7288:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $38, $2B, $98, $90, $11, $24, $36, $90, $37, $2B, $28, $90
    db $36, $28, $24, $F1, $35, $2C, $36, $28, $31, $98, $FA, $F7, $EF, $EE, $18, $2B
    db $AB, $90, $3A, $28, $2F, $2F, $B5, $90, $12, $3F, $90, $24, $EF, $EE, $2A, $32
    db $32, $27, $90, $36, $3A, $2C, $30, $30, $28, $35, $B5, $F7, $F0

Data_098_72C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2632C5, $5E

Data_098_7323:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263323, $46

Data_098_7369:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263369, $83

Data_098_73EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2633EC, $AA

Data_098_7496:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263496, $AC

Data_098_7542:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263542, $A4

Data_098_75E6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2635E6, $9E

Data_098_7684:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263684, $D1

Data_098_7755:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263755, $C7

Data_098_781C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26381C, $E1

Data_098_78FD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2638FD, $10E

Data_098_7A0B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263A0B, $42

Data_098_7A4D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263A4D, $9C

Data_098_7AE9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $3A, $28, $24, $37, $2B, $28, $35, $90, $2B
    db $24, $36, $F1, $25, $28, $28, $31, $90, $30, $2C, $2F, $27, $B5, $FA, $F7, $EF
    db $EE, $12, $37, $3E, $90, $24, $90, $2A, $32, $32, $27, $90, $37, $2B, $2C, $31
    db $2A, $B5, $EF, $EE, $F7, $F0

Data_098_7B1F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263B1F, $85

Data_098_7BA4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $1A, $38, $28, $28, $31, $3E, $90, $2F, $32
    db $36, $37, $F1, $2B, $28, $35, $90, $36, $26, $24, $35, $3C, $90, $2F, $32, $32
    db $2E, $99, $F7, $F0

Data_098_7BC8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263BC8, $67

Data_098_7C2F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $263C2F, $46

Data_098_7C75:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $20, $24, $9C, $2B, $28, $3C
    db $98, $F1, $0F, $28, $28, $2F, $90, $37, $2B, $24, $37, $AB, $90, $3A, $24, $35
    db $32, $32, $2B, $98, $FA, $F7, $EF, $EE, $0D, $2C, $27, $90, $36, $32, $30, $28
    db $37, $2B, $2C, $31, $2A, $EF, $EE, $36, $2B, $24, $2E, $28, $98, $F7, $F0

Data_098_7CB4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $23, $23, $23, $23, $23, $A4, $90, $1C, $36, $36, $36, $A4, $F1
    db $23, $23, $23, $23, $23, $A4, $90, $1C, $36, $36, $36, $A4, $F7, $F0

Data_098_7CD2:: ; heuristic: target of a monotone pointer table; C0
    ds $32E, $00
