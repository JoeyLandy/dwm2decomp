SECTION "Bank 86", ROMX[$4000], BANK[$86]
    db $86

Func_086_4001::
    ld de, Data_086_4016
    call Func_000_25C9
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

Data_086_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $18, $40
    dw Data_086_4218
    dw Data_086_42BB
    dw Data_086_4321
    dw Data_086_43AE
    dw Data_086_441E
    dw Data_086_447D
    dw Data_086_447E
    dw Data_086_447F
    dw Data_086_451E
    dw Data_086_459F
    dw Data_086_45A0
    dw Data_086_45A1
    dw Data_086_4624
    dw Data_086_4699
    dw Data_086_469A
    dw Data_086_469B
    dw Data_086_4741
    dw Data_086_4795
    dw Data_086_4796
    dw Data_086_4797
    dw Data_086_483B
    dw Data_086_4897
    dw Data_086_4898
    dw Data_086_4984
    dw Data_086_49D2
    dw Data_086_4A76
    dw Data_086_4ADC
    dw Data_086_4BB4
    dw Data_086_4C49
    dw Data_086_4C9E
    dw Data_086_4C9F
    dw Data_086_4CA0
    dw Data_086_4D41
    dw Data_086_4DAB
    dw Data_086_4DAC
    dw Data_086_4DAD
    dw Data_086_4E17
    dw Data_086_4E6E
    dw Data_086_4E6F
    dw Data_086_4E70
    dw Data_086_4F0F
    dw Data_086_4F6C
    dw Data_086_4F6D
    dw Data_086_4F6E
    dw Data_086_500E
    dw Data_086_506E
    dw Data_086_506F
    dw Data_086_516F
    dw Data_086_51BA
    dw Data_086_5285
    dw Data_086_52BF
    dw Data_086_5347
    dw Data_086_53C8
    dw Data_086_542B
    dw Data_086_542C
    dw Data_086_542D
    dw Data_086_54D3
    dw Data_086_5558
    dw Data_086_5559
    dw Data_086_555A
    dw Data_086_55FA
    dw Data_086_56A5
    dw Data_086_56A6
    dw Data_086_56A7
    dw Data_086_5758
    dw Data_086_57DE
    dw Data_086_57DF
    dw Data_086_57E0
    dw Data_086_585E
    dw Data_086_5968
    dw Data_086_59C1
    dw Data_086_5A76
    dw Data_086_5AE3
    dw Data_086_5B27
    dw Data_086_5B6D
    dw Data_086_5B92
    dw Data_086_5BB7
    dw Data_086_5BDD
    dw Data_086_5BF7
    dw Data_086_5C1F
    dw Data_086_5C41
    dw Data_086_5C5F
    dw Data_086_5C7F
    dw Data_086_5C99
    dw Data_086_5CB4
    dw Data_086_5CD2
    dw Data_086_5CF4
    dw Data_086_5D77
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5DE3
    dw Data_086_5F38
    dw Data_086_5F9F
    dw Data_086_5FC1
    dw Data_086_609B
    dw Data_086_60E4
    dw Data_086_6106
    dw Data_086_6151
    dw Data_086_6190
    dw Data_086_61D3
    dw Data_086_6235
    dw Data_086_6257
    dw Data_086_62D9
    dw Data_086_631A
    dw Data_086_635F
    dw Data_086_63AC
    dw Data_086_6469
    dw Data_086_64B0
    dw Data_086_65AC
    dw Data_086_65EA
    dw Data_086_664C
    dw Data_086_66B9
    dw Data_086_672B
    dw Data_086_67D2
    dw Data_086_6840
    dw Data_086_6863
    dw Data_086_68A7
    dw Data_086_68C8
    dw Data_086_6A00
    dw Data_086_6A3E
    dw Data_086_6A73
    dw Data_086_6AB0
    dw Data_086_6AE8
    dw Data_086_6B5E

Data_086_4218:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218218, $A3

Data_086_42BB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2182BB, $66

Data_086_4321:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218321, $8D

Data_086_43AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2183AE, $70

Data_086_441E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21841E, $5F

Data_086_447D:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_447E:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_447F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21847F, $9F

Data_086_451E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21851E, $81

Data_086_459F:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_45A0:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_45A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2185A1, $83

Data_086_4624:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218624, $75

Data_086_4699:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_469A:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_469B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21869B, $A6

Data_086_4741:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218741, $54

Data_086_4795:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4796:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4797:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218797, $A4

Data_086_483B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21883B, $5C

Data_086_4897:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4898:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218898, $EC

Data_086_4984:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218984, $4E

Data_086_49D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2189D2, $A4

Data_086_4A76:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218A76, $66

Data_086_4ADC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218ADC, $D8

Data_086_4BB4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218BB4, $95

Data_086_4C49:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218C49, $55

Data_086_4C9E:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4C9F:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4CA0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218CA0, $A1

Data_086_4D41:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218D41, $6A

Data_086_4DAB:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4DAC:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4DAD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218DAD, $6A

Data_086_4E17:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218E17, $57

Data_086_4E6E:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4E6F:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4E70:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218E70, $9F

Data_086_4F0F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218F0F, $5D

Data_086_4F6C:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4F6D:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_4F6E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $218F6E, $A0

Data_086_500E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21900E, $60

Data_086_506E:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_506F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21906F, $100

Data_086_516F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21916F, $4B

Data_086_51BA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2191BA, $CB

Data_086_5285:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $1D, $32, $3A, $28, $35, $90, $2C, $36
    db $F1, $37, $28, $35, $35, $2C, $25, $2F, $3C, $90, $37, $32, $38, $2A, $2B, $B5
    db $FA, $F7, $EF, $EE, $12, $90, $2B, $32, $33, $28, $90, $3C, $32, $38, $40, $28
    db $EF, $EE, $35, $28, $24, $27, $3C, $B5, $F7, $F0

Data_086_52BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2192BF, $88

Data_086_5347:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219347, $81

Data_086_53C8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2193C8, $63

Data_086_542B:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_542C:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_542D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21942D, $A6

Data_086_54D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2194D3, $85

Data_086_5558:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_5559:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_555A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21955A, $A0

Data_086_55FA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2195FA, $AB

Data_086_56A5:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_56A6:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_56A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2196A7, $B1

Data_086_5758:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219758, $86

Data_086_57DE:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_57DF:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_086_57E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2197E0, $7E

Data_086_585E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21985E, $10A

Data_086_5968:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219968, $59

Data_086_59C1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2199C1, $B5

Data_086_5A76:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219A76, $6D

Data_086_5AE3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219AE3, $44

Data_086_5B27:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219B27, $46

Data_086_5B6D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $2C, $2A, $2B, $37, $31, $2C, $31, $2A, $90, $3A, $2B, $28
    db $31, $F1, $3A, $28, $37, $90, $2C, $36, $90, $27, $24, $31, $2A, $28, $35, $32
    db $38, $36, $99, $F7, $F0

Data_086_5B92:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $28, $31, $90, $2C, $37, $3E, $90, $26, $32, $2F, $27
    db $AB, $F1, $29, $2C, $35, $28, $3E, $90, $37, $2B, $28, $90, $24, $31, $36, $3A
    db $28, $35, $99, $F7, $F0

Data_086_5BB7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0E, $2F, $28, $26, $37, $35, $2C, $26, $90, $2D, $32, $2F, $37
    db $36, $F1, $24, $35, $28, $90, $2A, $32, $32, $27, $90, $24, $37, $90, $37, $2C
    db $30, $28, $36, $B5, $F7, $F0

Data_086_5BDD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $32, $37, $99, $90, $11, $32, $37, $99, $F1, $0B, $38, $35
    db $31, $2C, $31, $2A, $90, $38, $33, $99, $F7, $F0

Data_086_5BF7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $90, $37, $32, $90, $27, $32, $90, $2C, $29
    db $90, $3A, $28, $F1, $24, $35, $28, $90, $24, $2F, $2F, $90, $2C, $31, $90, $27
    db $24, $31, $2A, $28, $35, $A4, $F7, $F0

Data_086_5C1F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $3A, $28, $28, $37, $36, $90, $24, $35, $28, $90, $2A, $32
    db $32, $27, $F1, $26, $2B, $28, $24, $33, $90, $28, $31, $28, $35, $2A, $3C, $99
    db $F7, $F0

Data_086_5C41:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $39, $28, $35, $26, $32, $31, $29, $2C, $27, $28, $31, $26
    db $28, $F1, $2C, $36, $90, $24, $90, $37, $35, $24, $33, $B5, $F7, $F0

Data_086_5C5F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $36, $26, $24, $35, $28, $27, $A4, $F1, $1D, $28
    db $35, $35, $2C, $29, $2C, $28, $27, $AB, $90, $28, $39, $28, $31, $A4, $F7, $F0

Data_086_5C7F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $29, $90, $2C, $37, $90, $2B, $38, $35, $37, $36, $AB, $F1
    db $2B, $28, $24, $2F, $90, $2C, $37, $B5, $F7, $F0

Data_086_5C99:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $32, $32, $27, $90, $2B, $28, $24, $2F, $37, $2B, $F1, $24
    db $25, $32, $39, $28, $90, $24, $2F, $2F, $B5, $F7, $F0

Data_086_5CB4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $32, $3A, $99, $90, $14, $24, $9C, $33, $32, $3A, $99, $F1
    db $0B, $2C, $2A, $90, $37, $35, $32, $38, $25, $2F, $28, $99, $F7, $F0

Data_086_5CD2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $31, $2A, $90, $30, $24, $36, $37, $28, $35, $A4
    db $F1, $1D, $2B, $28, $90, $29, $2C, $31, $24, $2F, $90, $37, $28, $36, $37, $A4
    db $F7, $F0

Data_086_5CF4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219CF4, $83

Data_086_5D77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219D77, $6C

Data_086_5DE3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219DE3, $155

Data_086_5F38:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219F38, $67

Data_086_5F9F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0B, $38, $37, $A4, $90, $17, $32, $99, $90, $12, $90, $2F, $32
    db $36, $37, $F1, $37, $32, $90, $37, $2B, $2C, $36, $90, $25, $35, $24, $37, $98
    db $F7, $F0

Data_086_5FC1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $219FC1, $DA

Data_086_609B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A09B, $49

Data_086_60E4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1C, $32, $90, $3C, $32, $38, $90, $27, $28, $29, $28, $24, $37
    db $28, $27, $F1, $37, $2B, $28, $90, $28, $39, $2C, $2F, $27, $32, $28, $35, $98
    db $F7, $F0

Data_086_6106:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A106, $4B

Data_086_6151:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $22, $32, $38, $35, $90, $30, $32, $31, $36, $37, $28, $35, $36
    db $F1, $24, $35, $28, $90, $2A, $32, $32, $27, $AB, $90, $2C, $37, $3E, $FA, $F7
    db $EF, $EE, $33, $2F, $24, $2C, $31, $90, $37, $32, $90, $36, $28, $28, $B5, $EF
    db $EE, $12, $90, $2F, $2C, $2E, $28, $90, $37, $2B, $28, $30, $99, $F7, $F0

Data_086_6190:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A190, $43

Data_086_61D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A1D3, $62

Data_086_6235:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $37, $2B, $24, $31, $2E, $90, $3C, $32, $38, $90, $2C
    db $31, $F1, $24, $2F, $2F, $90, $36, $2C, $31, $26, $28, $35, $2C, $37, $3C, $99
    db $F7, $F0

Data_086_6257:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A257, $82

Data_086_62D9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A2D9, $41

Data_086_631A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A31A, $45

Data_086_635F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A35F, $4D

Data_086_63AC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A3AC, $BD

Data_086_6469:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A469, $47

Data_086_64B0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A4B0, $FC

Data_086_65AC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $16, $2C, $2F, $24, $3C, $32, $38, $A3, $90, $11, $32, $3A, $90, $27, $32
    db $90, $12, $F1, $2E, $31, $32, $3A, $90, $24, $25, $32, $38, $37, $90, $2B, $2C
    db $30, $98, $FA, $F7, $EF, $EE, $20, $28, $2F, $2F, $A4, $EF, $EE, $1D, $2B, $24
    db $37, $3E, $90, $24, $90, $36, $28, $26, $35, $28, $37, $99, $F7, $F0

Data_086_65EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A5EA, $62

Data_086_664C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A64C, $6D

Data_086_66B9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A6B9, $72

Data_086_672B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A72B, $A7

Data_086_67D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A7D2, $6E

Data_086_6840:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $16, $2C, $2F, $24, $3C, $32, $38, $A3, $90, $10, $35, $28, $24, $37, $99
    db $F1, $17, $32, $90, $2B, $32, $2F, $27, $2C, $31, $2A, $90, $25, $24, $26, $2E
    db $99, $F7, $F0

Data_086_6863:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A863, $44

Data_086_68A7:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $16, $2C, $2F, $24, $3C, $32, $38, $A3, $90, $20, $24, $31, $37, $90, $37
    db $32, $F1, $36, $33, $24, $35, $90, $3A, $2C, $37, $2B, $90, $30, $28, $98, $FF
    db $F0

Data_086_68C8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21A8C8, $138

Data_086_6A00:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $32, $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $0A, $90, $37, $24
    db $31, $37, $24, $2F, $2C, $3D, $2C, $31, $2A, $EF, $EE, $24, $35, $32, $30, $24
    db $90, $3A, $24, $29, $37, $28, $27, $90, $32, $38, $37, $A4, $F7, $F0

Data_086_6A3E:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $37, $35, $2C, $28, $27, $90, $37, $32, $F1, $32, $33, $28, $31
    db $90, $37, $2B, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7, $EF, $EE, $0B
    db $38, $37, $90, $2C, $37, $90, $3A, $24, $36, $90, $2F, $32, $26, $2E, $28, $27
    db $B5, $EF, $EE, $F7, $F0

Data_086_6A73:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $0C, $32, $2F, $27
    db $90, $3A, $24, $37, $28, $35, $90, $2F, $24, $33, $33, $28, $27, $EF, $EE, $24
    db $31, $27, $90, $35, $2C, $33, $33, $2F, $28, $27, $B5, $F7, $F0

Data_086_6AB0:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $32, $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $16, $28, $24, $37
    db $90, $36, $2C, $3D, $3D, $2F, $28, $27, $90, $32, $31, $90, $24, $EF, $EE, $36
    db $2E, $28, $3A, $28, $35, $B5, $F7, $F0

Data_086_6AE8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21AAE8, $76

Data_086_6B5E:: ; heuristic: target of a monotone pointer table; C0
    db $F0
    ds $14A1, $00
