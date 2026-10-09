SECTION "Bank 83", ROMX[$4000], BANK[$83]
    db $83

Func_083_4001::
    ld a, [$C529]
    cp a, $C7
    jr c, Jump_083_400F
    ld hl, Data_083_4070
    ld b, $97
    rst $10
    ret

Jump_083_400F::
    ld de, Data_083_4032
    call Func_000_25C9
    ret

Func_083_4016:: ; heuristic: follows a terminator; C0
    ld a, [$C529]
    cp a, $C7
    jr c, Jump_083_4024
    ld hl, $407F
    ld b, $97
    rst $10
    ret

Jump_083_4024::
    ld de, Data_083_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_083_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $34, $40
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2

Data_083_4070:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_41C2
    dw Data_083_4229
    dw Data_083_4229
    dw Data_083_426E
    dw Data_083_42C0
    dw Data_083_4307
    dw Data_083_438C
    dw Data_083_43C5
    dw Data_083_43C5
    dw Data_083_4424
    dw Data_083_446C
    dw Data_083_44B2
    dw Data_083_4512
    dw Data_083_455F
    dw Data_083_45BB
    dw Data_083_462C
    dw Data_083_4697
    dw Data_083_46D9
    dw Data_083_471A
    dw Data_083_473A
    dw Data_083_478E
    dw Data_083_47DA
    dw Data_083_4828
    dw Data_083_4876
    dw Data_083_48B7
    dw Data_083_4929
    dw Data_083_496A
    dw Data_083_49D7
    dw Data_083_4A2A
    dw Data_083_4A4B
    dw Data_083_4A78
    dw Data_083_4AF5
    dw Data_083_4B3C
    dw Data_083_4B61
    dw Data_083_4BA6
    dw Data_083_4C15
    dw Data_083_4C88
    dw Data_083_4CD4
    dw Data_083_4D3C
    dw Data_083_4D3C
    dw Data_083_4D74
    dw Data_083_4E18
    dw Data_083_4E79
    dw Data_083_4EE4
    dw Data_083_4F6A
    dw Data_083_4FA7
    dw Data_083_500F
    dw Data_083_5052
    dw Data_083_50B6
    dw Data_083_511B
    dw Data_083_5159
    dw Data_083_5193
    dw Data_083_5241
    dw Data_083_5285
    dw Data_083_52C6
    dw Data_083_5326
    dw Data_083_5386
    dw Data_083_53E7
    dw Data_083_5454
    dw Data_083_54BE
    dw Data_083_5538
    dw Data_083_55A1
    dw Data_083_5633
    dw Data_083_56A5
    dw Data_083_5707
    dw Data_083_5777
    dw Data_083_57E4
    dw Data_083_584E
    dw Data_083_588B
    dw Data_083_58CC
    dw Data_083_590A
    dw Data_083_593D
    dw Data_083_59B2
    dw Data_083_5A1F
    dw Data_083_5A6A
    dw Data_083_5AD7
    dw Data_083_5B37
    dw Data_083_5BA1
    dw Data_083_5C10
    dw Data_083_5C81
    dw Data_083_5CE9
    dw Data_083_5D52
    dw Data_083_5D96
    dw Data_083_5DFD
    dw Data_083_5E5C
    dw Data_083_5EE9
    dw Data_083_5F6B
    dw Data_083_5FFE
    dw Data_083_6088
    dw Data_083_6108
    dw Data_083_61A1
    dw Data_083_620C
    dw Data_083_6252
    dw Data_083_62D1
    dw Data_083_633A
    dw Data_083_637C
    dw Data_083_63DA
    dw Data_083_6445
    dw Data_083_64B0
    dw Data_083_6514
    dw Data_083_6580
    dw Data_083_65E1
    dw Data_083_6625
    dw Data_083_669A
    dw Data_083_66B7
    dw Data_083_66F8
    dw Data_083_6763
    dw Data_083_67A6
    dw Data_083_67EE
    dw Data_083_682E
    dw Data_083_686E
    dw Data_083_68F1
    dw Data_083_6916
    dw Data_083_6955
    dw Data_083_699D
    dw Data_083_69E2
    dw Data_083_6A26
    dw Data_083_6A85
    dw Data_083_6ABD
    dw Data_083_6B6E
    dw Data_083_6BC7
    dw Data_083_6C0F
    dw Data_083_6C7E
    dw Data_083_6CE4
    dw Data_083_6D4F
    dw Data_083_6DB2
    dw Data_083_6DFB
    dw Data_083_6E61
    dw Data_083_6EC9
    dw Data_083_6F30
    dw Data_083_6F7E
    dw Data_083_6FEF
    dw Data_083_7014
    dw Data_083_707F
    dw Data_083_70C1
    dw Data_083_70F9
    dw Data_083_7199
    dw Data_083_7200
    dw Data_083_7262
    dw Data_083_72D2
    dw Data_083_733C
    dw Data_083_73AE
    dw Data_083_7448
    dw Data_083_74DF
    dw Data_083_754D
    dw Data_083_75D0
    dw Data_083_7649
    dw Data_083_76B6
    dw Data_083_7763
    dw Data_083_77CB
    dw Data_083_7837
    dw Data_083_78C5
    dw Data_083_792E
    dw Data_083_7999
    dw Data_083_7A25
    dw Data_083_7A8D
    dw Data_083_7AF4
    dw Data_083_7B5A
    dw Data_083_7BC1
    dw Data_083_7C42
    dw Data_083_7C65
    dw Data_083_7CCC
    dw Data_083_7D36
    dw Data_083_7D99
    dw Data_083_7E29
    dw Data_083_7E95
    dw Data_083_7F14

Data_083_41C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C1C2, $67

Data_083_4229:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C229, $45

Data_083_426E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C26E, $52

Data_083_42C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C2C0, $47

Data_083_4307:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C307, $85

Data_083_438C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $14, $9C, $2E, $28, $28, $33, $90, $30, $32, $31, $36, $37, $28
    db $35, $36, $F1, $24, $3A, $24, $3C, $90, $29, $35, $32, $30, $90, $30, $28, $99
    db $FA, $F7, $EF, $EE, $1D, $2B, $28, $3C, $90, $29, $35, $2C, $2A, $2B, $37, $28
    db $31, $90, $30, $28, $99, $EF, $EE, $F7, $F0

Data_083_43C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C3C5, $5F

Data_083_4424:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C424, $48

Data_083_446C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C46C, $46

Data_083_44B2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C4B2, $60

Data_083_4512:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C512, $4D

Data_083_455F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C55F, $5C

Data_083_45BB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C5BB, $71

Data_083_462C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C62C, $6B

Data_083_4697:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C697, $42

Data_083_46D9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C6D9, $41

Data_083_471A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0E, $34, $38, $2C, $33, $90, $0D, $9C, $1C, $26, $24, $2F, $28
    db $90, $37, $32, $F1, $35, $24, $2C, $36, $28, $90, $0D, $0E, $0F, $B5, $F7, $F0

Data_083_473A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C73A, $54

Data_083_478E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C78E, $4C

Data_083_47DA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C7DA, $4E

Data_083_4828:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C828, $4E

Data_083_4876:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C876, $41

Data_083_48B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C8B7, $72

Data_083_4929:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C929, $41

Data_083_496A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C96A, $6D

Data_083_49D7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20C9D7, $53

Data_083_4A2A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $36, $2B, $99, $90, $0B, $28, $90, $34, $38, $2C, $28, $37
    db $90, $2C, $31, $F1, $37, $2B, $28, $90, $0C, $24, $36, $37, $2F, $28, $99, $F7
    db $F0

Data_083_4A4B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $23, $3D, $3D, $3D, $A4, $F1, $FA, $F7, $EF, $EE, $F3, $11, $38
    db $2B, $98, $90, $17, $9C, $31, $32, $AB, $90, $12, $EF, $EE, $3A, $24, $36, $31
    db $41, $90, $36, $2F, $28, $28, $33, $2C, $31, $2A, $99, $F7, $F0

Data_083_4A78:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CA78, $7D

Data_083_4AF5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CAF5, $47

Data_083_4B3C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $42, $28, $90, $2A, $32, $37, $90, $2A, $38, $37
    db $36, $F1, $29, $32, $35, $90, $24, $90, $2F, $2C, $37, $37, $2F, $28, $90, $2E
    db $2C, $27, $99, $F7, $F0

Data_083_4B61:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CB61, $45

Data_083_4BA6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CBA6, $6F

Data_083_4C15:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CC15, $73

Data_083_4C88:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CC88, $4C

Data_083_4CD4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CCD4, $68

Data_083_4D3C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $90, $2E, $2C, $27, $90, $3A, $2C, $37, $2B, $F1, $30, $32
    db $31, $36, $37, $28, $35, $36, $90, $2C, $31, $90, $37, $32, $3A, $98, $FA, $F7
    db $EF, $EE, $22, $32, $38, $40, $28, $90, $24, $90, $25, $35, $24, $39, $28, $EF
    db $EE, $36, $32, $38, $2F, $99, $F7, $F0

Data_083_4D74:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CD74, $A4

Data_083_4E18:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CE18, $61

Data_083_4E79:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CE79, $6B

Data_083_4EE4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CEE4, $86

Data_083_4F6A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $35, $90, $28, $3C, $28, $36, $90, $24, $35, $28
    db $F1, $38, $31, $26, $2F, $32, $38, $27, $28, $27, $A4, $FA, $F7, $EF, $EE, $22
    db $32, $38, $90, $36, $28, $28, $30, $90, $37, $32, $90, $25, $28, $90, $24, $EF
    db $EE, $2A, $32, $32, $27, $90, $36, $32, $35, $37, $B5, $F7, $F0

Data_083_4FA7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20CFA7, $68

Data_083_500F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D00F, $43

Data_083_5052:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D052, $64

Data_083_50B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D0B6, $65

Data_083_511B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $24, $2F, $37, $99, $F1, $20, $2B, $32, $90, $2A, $32, $28
    db $36, $90, $37, $2B, $28, $35, $28, $98, $FA, $F7, $EF, $EE, $12, $90, $2F, $32
    db $32, $2E, $90, $2A, $32, $32, $27, $90, $24, $36, $90, $24, $EF, $EE, $2A, $38
    db $24, $35, $27, $AB, $90, $27, $32, $31, $41, $90, $12, $98, $F7, $F0

Data_083_5159:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $37, $28, $35, $35, $2C, $29, $2C, $28, $27, $90
    db $32, $29, $F1, $30, $32, $31, $36, $37, $28, $35, $36, $99, $FA, $F7, $EF, $EE
    db $14, $28, $28, $33, $90, $37, $2B, $28, $30, $90, $24, $3A, $24, $3C, $EF, $EE
    db $29, $35, $32, $30, $90, $30, $28, $99, $F7, $F0

Data_083_5193:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D193, $AE

Data_083_5241:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D241, $44

Data_083_5285:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D285, $41

Data_083_52C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D2C6, $60

Data_083_5326:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D326, $60

Data_083_5386:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D386, $61

Data_083_53E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D3E7, $6D

Data_083_5454:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D454, $6A

Data_083_54BE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D4BE, $7A

Data_083_5538:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D538, $69

Data_083_55A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D5A1, $92

Data_083_5633:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D633, $72

Data_083_56A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D6A5, $62

Data_083_5707:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D707, $70

Data_083_5777:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D777, $6D

Data_083_57E4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D7E4, $6A

Data_083_584E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $30, $28, $35, $26, $2B, $24, $31, $27, $2C
    db $36, $28, $F1, $32, $29, $90, $36, $2B, $32, $33, $36, $90, $39, $24, $35, $2C
    db $28, $36, $FA, $F7, $EF, $EE, $29, $35, $32, $30, $90, $33, $2F, $24, $26, $28
    db $90, $37, $32, $EF, $EE, $33, $2F, $24, $26, $28, $B5, $F7, $F0

Data_083_588B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D88B, $41

Data_083_58CC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $3E, $90, $27, $24, $31, $2A, $28, $35, $32, $38, $36
    db $F1, $32, $38, $37, $90, $37, $2B, $28, $35, $28, $B5, $FA, $F7, $EF, $EE, $10
    db $28, $37, $90, $36, $32, $30, $28, $90, $35, $28, $36, $37, $EF, $EE, $25, $28
    db $29, $32, $35, $28, $90, $3C, $32, $38, $90, $2A, $32, $B5, $F7, $F0

Data_083_590A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1E, $2B, $A4, $F1, $1E, $30, $A4, $FA, $F7, $EF, $EE, $0A, $35
    db $28, $31, $41, $90, $3C, $32, $38, $90, $24, $29, $35, $24, $2C, $27, $EF, $EE
    db $32, $29, $90, $3C, $32, $38, $35, $90, $30, $32, $31, $36, $37, $28, $35, $36
    db $98, $F7, $F0

Data_083_593D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D93D, $75

Data_083_59B2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20D9B2, $6D

Data_083_5A1F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DA1F, $4B

Data_083_5A6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DA6A, $6D

Data_083_5AD7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DAD7, $60

Data_083_5B37:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DB37, $6A

Data_083_5BA1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DBA1, $6F

Data_083_5C10:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DC10, $71

Data_083_5C81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DC81, $68

Data_083_5CE9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DCE9, $69

Data_083_5D52:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DD52, $44

Data_083_5D96:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DD96, $67

Data_083_5DFD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DDFD, $5F

Data_083_5E5C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DE5C, $8D

Data_083_5EE9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DEE9, $82

Data_083_5F6B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DF6B, $93

Data_083_5FFE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20DFFE, $8A

Data_083_6088:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E088, $80

Data_083_6108:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E108, $99

Data_083_61A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E1A1, $6B

Data_083_620C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E20C, $46

Data_083_6252:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E252, $7F

Data_083_62D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E2D1, $69

Data_083_633A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E33A, $42

Data_083_637C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E37C, $5E

Data_083_63DA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E3DA, $6B

Data_083_6445:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E445, $6B

Data_083_64B0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E4B0, $64

Data_083_6514:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E514, $6C

Data_083_6580:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E580, $61

Data_083_65E1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E5E1, $44

Data_083_6625:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E625, $75

Data_083_669A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $2B, $24, $37, $90, $37, $32, $90, $30, $24, $2E, $28, $90
    db $29, $32, $35, $F1, $36, $38, $33, $33, $28, $35, $A4, $F7, $F0

Data_083_66B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E6B7, $41

Data_083_66F8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E6F8, $6B

Data_083_6763:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E763, $43

Data_083_67A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E7A6, $48

Data_083_67EE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $24, $37, $90, $30, $24, $31, $90, $37, $2B, $28, $35
    db $28, $F1, $2E, $28, $28, $33, $36, $90, $36, $37, $24, $35, $2C, $31, $2A, $B5
    db $FA, $F7, $EF, $EE, $0D, $32, $28, $36, $90, $2B, $28, $90, $37, $2B, $2C, $31
    db $2E, $90, $12, $3F, $EF, $EE, $36, $37, $35, $24, $31, $2A, $28, $98, $F7, $F0

Data_083_682E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $AB, $90, $24, $35, $28, $31, $41, $90, $3C, $32, $38
    db $F1, $26, $38, $37, $28, $99, $FA, $F7, $EF, $EE, $0A, $31, $27, $90, $3C, $32
    db $38, $35, $90, $30, $32, $31, $36, $37, $28, $35, $36, $EF, $EE, $24, $35, $28
    db $90, $24, $27, $32, $35, $24, $25, $2F, $28, $90, $37, $32, $32, $99, $F7, $F0

Data_083_686E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E86E, $83

Data_083_68F1:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $90, $3A, $2C, $36, $2B, $90, $12, $90, $2B, $24, $27, $90
    db $24, $F1, $36, $2C, $25, $2F, $2C, $31, $2A, $90, $2F, $2C, $2E, $28, $90, $3C
    db $32, $38, $B5, $F7, $F0

Data_083_6916:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $16, $3C, $90, $25, $32, $3C, $90, $2C, $36, $90, $24, $F1, $27
    db $2C, $35, $37, $90, $30, $24, $2A, $31, $28, $37, $99, $FA, $F7, $EF, $EE, $12
    db $90, $26, $24, $31, $41, $90, $2E, $28, $28, $33, $90, $38, $33, $EF, $EE, $3A
    db $2C, $37, $2B, $90, $37, $2B, $28, $90, $3A, $24, $36, $2B, $99, $F7, $F0

Data_083_6955:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E955, $48

Data_083_699D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E99D, $45

Data_083_69E2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20E9E2, $44

Data_083_6A26:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EA26, $5F

Data_083_6A85:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $22, $32, $38, $40, $28, $90, $32, $31, $90, $24, $F1, $2D, $32
    db $38, $35, $31, $28, $3C, $90, $3A, $2C, $37, $2B, $FA, $F7, $EF, $EE, $30, $32
    db $31, $36, $37, $28, $35, $36, $98, $EF, $EE, $12, $3F, $90, $2C, $30, $33, $35
    db $28, $36, $36, $28, $27, $B5, $F7, $F0

Data_083_6ABD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EABD, $B1

Data_083_6B6E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EB6E, $59

Data_083_6BC7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EBC7, $48

Data_083_6C0F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EC0F, $6F

Data_083_6C7E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EC7E, $66

Data_083_6CE4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20ECE4, $6B

Data_083_6D4F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20ED4F, $63

Data_083_6DB2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EDB2, $49

Data_083_6DFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EDFB, $66

Data_083_6E61:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EE61, $68

Data_083_6EC9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EEC9, $67

Data_083_6F30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EF30, $4E

Data_083_6F7E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20EF7E, $71

Data_083_6FEF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $90, $37, $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B
    db $28, $36, $37, $F1, $2B, $32, $2F, $27, $36, $90, $32, $31, $28, $90, $2C, $37
    db $28, $30, $B5, $F7, $F0

Data_083_7014:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F014, $6B

Data_083_707F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F07F, $42

Data_083_70C1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $37, $2B, $28, $35, $90, $3A, $32, $35, $2F, $27, $36, $AB
    db $F1, $3C, $32, $38, $90, $36, $24, $3C, $98, $FA, $F7, $EF, $EE, $12, $44, $90
    db $2F, $2C, $2E, $28, $90, $37, $32, $90, $2A, $32, $EF, $EE, $36, $32, $30, $28
    db $3A, $2B, $28, $35, $28, $A4, $F7, $F0

Data_083_70F9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F0F9, $A0

Data_083_7199:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F199, $67

Data_083_7200:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F200, $62

Data_083_7262:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F262, $70

Data_083_72D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F2D2, $6A

Data_083_733C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F33C, $72

Data_083_73AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F3AE, $9A

Data_083_7448:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F448, $97

Data_083_74DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F4DF, $6E

Data_083_754D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F54D, $83

Data_083_75D0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F5D0, $79

Data_083_7649:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F649, $6D

Data_083_76B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F6B6, $AD

Data_083_7763:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F763, $68

Data_083_77CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F7CB, $6C

Data_083_7837:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F837, $8E

Data_083_78C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F8C5, $69

Data_083_792E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F92E, $6B

Data_083_7999:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20F999, $8C

Data_083_7A25:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FA25, $68

Data_083_7A8D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FA8D, $67

Data_083_7AF4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FAF4, $66

Data_083_7B5A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FB5A, $67

Data_083_7BC1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FBC1, $81

Data_083_7C42:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $13, $38, $36, $37, $90, $33, $38, $36, $2B, $2C, $31, $2A, $90
    db $30, $28, $F1, $3A, $32, $31, $41, $90, $25, $38, $27, $2A, $28, $90, $30, $28
    db $99, $F7, $F0

Data_083_7C65:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FC65, $67

Data_083_7CCC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FCCC, $6A

Data_083_7D36:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FD36, $63

Data_083_7D99:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FD99, $90

Data_083_7E29:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FE29, $6C

Data_083_7E95:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FE95, $7F

Data_083_7F14:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20FF14, $45
    ds $A7, $00
