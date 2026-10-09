SECTION "Bank 80", ROMX[$4000], BANK[$80]
    db $80

Func_080_4001::
    ld a, [$C529]
    cp a, $C8
    jr c, Jump_080_400F
    ld hl, Func_096_4001
    ld b, $96
    rst $10
    ret

Jump_080_400F::
    ld de, Data_080_4032
    call Func_000_25C9
    ret

Func_080_4016:: ; heuristic: follows a terminator; C0
    ld a, [$C529]
    cp a, $C8
    jr c, Jump_080_4024
    ld hl, Func_096_4010
    ld b, $96
    rst $10
    ret

Jump_080_4024::
    ld de, Data_080_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_080_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $34, $40
    dw Data_080_41C4
    dw Data_080_41E8
    dw Data_080_4200
    dw Data_080_4324
    dw Data_080_43A3
    dw Data_080_43E1
    dw Data_080_44AF
    dw Data_080_44D3
    dw Data_080_4537
    dw Data_080_4554
    dw Data_080_4572
    dw Data_080_45FD
    dw Data_080_4675
    dw Data_080_46E1
    dw Data_080_4771
    dw Data_080_47E1
    dw Data_080_4868
    dw Data_080_48CE
    dw Data_080_4955
    dw Data_080_49C1
    dw Data_080_4A4A
    dw Data_080_4A8C
    dw Data_080_4B00
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4B69
    dw Data_080_4BD2
    dw Data_080_4C3B
    dw Data_080_4CF3
    dw Data_080_4D0F
    dw Data_080_4D2A
    dw Data_080_4D93
    dw Data_080_4DAE
    dw Data_080_4DD3
    dw Data_080_4E19
    dw Data_080_4E36
    dw Data_080_4E81
    dw Data_080_4EF0
    dw Data_080_4F36
    dw Data_080_4F53
    dw Data_080_4F78
    dw Data_080_4FAE
    dw Data_080_50A8
    dw Data_080_51BC
    dw Data_080_524D
    dw Data_080_52E9
    dw Data_080_536F
    dw Data_080_53B2
    dw Data_080_54AC
    dw Data_080_550D
    dw Data_080_5576
    dw Data_080_55DB
    dw Data_080_561F
    dw Data_080_578D
    dw Data_080_581A
    dw Data_080_589A
    dw Data_080_596D
    dw Data_080_59D5
    dw Data_080_5A16
    dw Data_080_5A99
    dw Data_080_5B25
    dw Data_080_5C24
    dw Data_080_5CCB
    dw Data_080_5DA4
    dw Data_080_5E6E
    dw Data_080_5E88
    dw Data_080_5EA7
    dw Data_080_5F14
    dw Data_080_5F77
    dw Data_080_5FFE
    dw Data_080_60AB
    dw Data_080_6167
    dw Data_080_627A
    dw Data_080_62AE
    dw Data_080_62DE
    dw Data_080_639F
    dw Data_080_6406
    dw Data_080_6441
    dw Data_080_6480
    dw Data_080_649D
    dw Data_080_64C0
    dw Data_080_6509
    dw Data_080_6573
    dw Data_080_65CB
    dw Data_080_65E3
    dw Data_080_662B
    dw Data_080_668A
    dw Data_080_66C6
    dw Data_080_66E0
    dw Data_080_673C
    dw Data_080_6781
    dw Data_080_6801
    dw Data_080_6843
    dw Data_080_68B6
    dw Data_080_68F8
    dw Data_080_6967
    dw Data_080_6A08
    dw Data_080_6AB3
    dw Data_080_6B18
    dw Data_080_6B7D
    dw Data_080_6BC7
    dw Data_080_6C49
    dw Data_080_6C8C
    dw Data_080_6D71
    dw Data_080_6DBB
    dw Data_080_6E46
    dw Data_080_6EA6
    dw Data_080_6EF9
    dw Data_080_6F70
    dw Data_080_6FBA
    dw Data_080_704B
    dw Data_080_7086
    dw Data_080_710F
    dw Data_080_7149
    dw Data_080_7208
    dw Data_080_7226
    dw Data_080_726E
    dw Data_080_73B0
    dw Data_080_73F5
    dw Data_080_74A1
    dw Data_080_757D
    dw Data_080_7602
    dw Data_080_7675
    dw Data_080_76E4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_77B4
    dw Data_080_7881
    dw Data_080_78BC
    dw Data_080_78D3
    dw Data_080_78D3
    dw Data_080_793E
    dw Data_080_795C
    dw Data_080_797F
    dw Data_080_79B9
    dw Data_080_7AB7
    dw Data_080_7B81
    dw Data_080_7BC5
    dw Data_080_7C91
    dw Data_080_7D5F
    dw Data_080_7DE6
    dw Data_080_7E07
    dw Data_080_7E40
    dw Data_080_7EC7
    dw Data_080_7F80

Data_080_41C4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1A, $38, $28, $28, $31, $90, $11, $28, $2F, $28, $31, $90, $2B
    db $24, $36, $F1, $25, $28, $26, $32, $30, $28, $90, $2B, $28, $24, $2F, $37, $2B
    db $3C, $B5, $F7, $F0

Data_080_41E8:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $36
    db $2B, $2C, $28, $2F, $27, $B5, $F7, $F0

Data_080_4200:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200200, $124

Data_080_4324:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200324, $7F

Data_080_43A3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $A4, $90, $17, $32, $99, $F1, $16, $3C, $90, $30
    db $32, $31, $36, $37, $28, $35, $36, $99, $FA, $F7, $EF, $EE, $12, $37, $90, $3A
    db $32, $31, $41, $90, $25, $28, $90, $37, $2B, $2C, $36, $EF, $EE, $28, $24, $36
    db $3C, $90, $31, $28, $3B, $37, $90, $37, $2C, $30, $28, $99, $F7, $F0

Data_080_43E1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2003E1, $CE

Data_080_44AF:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $35, $32, $3A, $90, $37, $2B, $28, $90, $0C, $35, $28
    db $36, $37, $F1, $2C, $31, $37, $32, $90, $30, $3C, $90, $36, $33, $35, $2C, $31
    db $2A, $B5, $F7, $F0

Data_080_44D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2004D3, $64

Data_080_4537:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $37, $2B, $28, $90
    db $1C, $2E, $3C, $90, $1C, $2B, $2C, $28, $2F, $27, $B5, $F7, $F0

Data_080_4554:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $39, $32, $2C, $26, $28, $90, $28, $26, $2B, $32, $28, $27, $F1, $29
    db $35, $32, $30, $90, $31, $32, $3A, $2B, $28, $35, $28, $A4, $F7, $F0

Data_080_4572:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200572, $8B

Data_080_45FD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2005FD, $78

Data_080_4675:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200675, $6C

Data_080_46E1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2006E1, $90

Data_080_4771:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200771, $70

Data_080_47E1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2007E1, $87

Data_080_4868:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200868, $66

Data_080_48CE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2008CE, $87

Data_080_4955:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200955, $6C

Data_080_49C1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2009C1, $89

Data_080_4A4A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200A4A, $42

Data_080_4A8C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200A8C, $74

Data_080_4B00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200B00, $69

Data_080_4B69:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200B69, $69

Data_080_4BD2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200BD2, $69

Data_080_4C3B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200C3B, $B8

Data_080_4CF3:: ; heuristic: target of a monotone pointer table; C0
    db $45, $90, $16, $24, $30, $24, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39
    db $28, $35, $F1, $01, $AB, $02, $00, $00, $10, $B5, $F7, $F0

Data_080_4D0F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $A4, $90, $1D, $2B, $28, $31, $90, $12, $43, $2F, $F1
    db $24, $36, $2E, $90, $0C, $32, $25, $2C, $B5, $F7, $F0

Data_080_4D2A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200D2A, $69

Data_080_4D93:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $A4, $90, $1D, $2B, $28, $31, $90, $12, $43, $2F, $F1
    db $24, $36, $2E, $90, $1D, $24, $35, $24, $B5, $F7, $F0

Data_080_4DAE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0B, $38, $3C, $90, $36, $32, $30, $28, $90, $1C, $2C, $35, $2F
    db $32, $2C, $31, $F1, $29, $32, $35, $90, $32, $38, $35, $90, $27, $2C, $31, $31
    db $28, $35, $B5, $F7, $F0

Data_080_4DD3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200DD3, $46

Data_080_4E19:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1, $37
    db $2B, $28, $90, $1C, $2C, $35, $2F, $32, $2C, $31, $B5, $F7, $F0

Data_080_4E36:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200E36, $4B

Data_080_4E81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200E81, $6F

Data_080_4EF0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200EF0, $46

Data_080_4F36:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $3A, $2C, $2F, $2F, $98, $F1, $12, $43, $2F
    db $90, $26, $38, $37, $90, $2F, $32, $32, $36, $28, $99, $F7, $F0

Data_080_4F53:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $AB, $90, $25, $38, $37, $90, $3C, $32, $38, $90, $2B
    db $24, $39, $28, $F1, $31, $32, $90, $35, $32, $32, $30, $90, $29, $32, $35, $90
    db $30, $28, $A4, $F7, $F0

Data_080_4F78:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $AB, $90, $27, $32, $31, $41, $90, $25, $28, $F1, $37
    db $2B, $24, $37, $90, $3A, $24, $3C, $B5, $FA, $F7, $EF, $EE, $12, $3F, $90, $36
    db $38, $35, $28, $90, $12, $90, $26, $24, $31, $EF, $EE, $2B, $28, $2F, $33, $90
    db $3C, $32, $38, $B5, $F7, $F0

Data_080_4FAE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $200FAE, $FA

Data_080_50A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2010A8, $114

Data_080_51BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2011BC, $91

Data_080_524D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20124D, $9C

Data_080_52E9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2012E9, $86

Data_080_536F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20136F, $43

Data_080_53B2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2013B2, $FA

Data_080_54AC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2014AC, $61

Data_080_550D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20150D, $69

Data_080_5576:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201576, $65

Data_080_55DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2015DB, $44

Data_080_561F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20161F, $16E

Data_080_578D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20178D, $8D

Data_080_581A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20181A, $80

Data_080_589A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20189A, $D3

Data_080_596D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20196D, $68

Data_080_59D5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2019D5, $41

Data_080_5A16:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201A16, $83

Data_080_5A99:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201A99, $8C

Data_080_5B25:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201B25, $FF

Data_080_5C24:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201C24, $A7

Data_080_5CCB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201CCB, $D9

Data_080_5DA4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201DA4, $CA

Data_080_5E6E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $31, $90, $2F, $28, $37, $3E, $90, $25, $35, $28
    db $28, $27, $F1, $37, $2B, $28, $30, $99, $F7, $F0

Data_080_5E88:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $AB, $90, $37, $32, $32, $90, $25, $24, $27, $B5, $F1
    db $0A, $31, $32, $37, $2B, $28, $35, $90, $37, $2C, $30, $28, $B5, $F7, $F0

Data_080_5EA7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201EA7, $6D

Data_080_5F14:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201F14, $63

Data_080_5F77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201F77, $87

Data_080_5FFE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $201FFE, $AD

Data_080_60AB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2020AB, $BC

Data_080_6167:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202167, $113

Data_080_627A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2F, $2F, $32, $AB, $90, $F9, $00, $AB, $F1, $3A, $28
    db $2F, $26, $32, $30, $28, $99, $FA, $F7, $EF, $EE, $20, $24, $31, $37, $90, $37
    db $32, $90, $38, $36, $28, $90, $37, $2B, $28, $EF, $EE, $36, $37, $24, $25, $2F
    db $28, $98, $F7, $F0

Data_080_62AE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $23, $3D, $3D, $3D, $A4, $90, $22, $24, $3A, $31, $A4, $F1, $11
    db $38, $2B, $98, $FA, $F7, $EF, $EE, $12, $36, $90, $2C, $37, $90, $30, $32, $35
    db $31, $2C, $31, $2A, $EF, $EE, $24, $2F, $35, $28, $24, $27, $3C, $98, $F7, $F0

Data_080_62DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2022DE, $C1

Data_080_639F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20239F, $67

Data_080_6406:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $23, $3D, $3D, $A4, $90, $23, $3D, $3D, $A4, $F1, $23, $3D, $3D
    db $A4, $90, $20, $2B, $32, $32, $33, $36, $99, $FA, $F7, $EF, $EE, $20, $24, $36
    db $90, $12, $90, $25, $35, $28, $24, $37, $2B, $2C, $31, $2A, $EF, $EE, $29, $2C
    db $35, $28, $90, $37, $2B, $28, $35, $28, $98, $F7, $F0

Data_080_6441:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0D, $32, $90, $3C, $32, $38, $90, $3A, $24, $31, $37, $90, $37
    db $32, $F1, $2E, $31, $32, $3A, $90, $2B, $32, $3A, $90, $30, $38, $26, $2B, $90
    db $3C, $32, $38, $35, $FA, $F7, $EF, $EE, $26, $32, $30, $33, $24, $31, $2C, $32
    db $31, $36, $90, $26, $24, $31, $EF, $EE, $2A, $35, $32, $3A, $98, $FF, $F0

Data_080_6480:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $F9, $17, $3E, $90, $2A, $35, $32, $3A, $37, $2B, $F1, $2F, $2C, $30, $2C
    db $37, $90, $2C, $36, $90, $15, $39, $90, $F9, $4E, $B5, $F7, $F0

Data_080_649D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $F9, $17, $90, $2B, $24, $36, $90, $35, $28, $24, $26, $2B, $28, $27, $F1
    db $2C, $37, $36, $90, $2A, $35, $32, $3A, $37, $2B, $90, $2F, $2C, $30, $2C, $37
    db $B5, $F7, $F0

Data_080_64C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2024C0, $49

Data_080_6509:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202509, $6A

Data_080_6573:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202573, $58

Data_080_65CB:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $26
    db $24, $36, $2E, $28, $37, $B5, $F7, $F0

Data_080_65E3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2025E3, $48

Data_080_662B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20262B, $5F

Data_080_668A:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $24, $27, $90, $37, $2B, $28, $F1, $36, $2C, $2A, $31
    db $B5, $FA, $F7, $EF, $EE, $95, $20, $24, $37, $26, $2B, $90, $3C, $32, $38, $35
    db $90, $36, $37, $28, $33, $99, $EF, $EE, $16, $32, $31, $36, $37, $28, $35, $90
    db $24, $37, $90, $36, $2F, $28, $28, $33, $99, $95, $F7, $F0

Data_080_66C6:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $2B, $32, $2F, $28, $B5, $F7, $F0

Data_080_66E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2026E0, $5C

Data_080_673C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20273C, $45

Data_080_6781:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202781, $80

Data_080_6801:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202801, $42

Data_080_6843:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202843, $73

Data_080_68B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2028B6, $42

Data_080_68F8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2028F8, $6F

Data_080_6967:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202967, $A1

Data_080_6A08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202A08, $AB

Data_080_6AB3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202AB3, $65

Data_080_6B18:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202B18, $65

Data_080_6B7D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202B7D, $4A

Data_080_6BC7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202BC7, $82

Data_080_6C49:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202C49, $43

Data_080_6C8C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202C8C, $E5

Data_080_6D71:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202D71, $4A

Data_080_6DBB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202DBB, $8B

Data_080_6E46:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202E46, $60

Data_080_6EA6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202EA6, $53

Data_080_6EF9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202EF9, $77

Data_080_6F70:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202F70, $4A

Data_080_6FBA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $202FBA, $91

Data_080_704B:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $27
    db $35, $28, $36, $36, $28, $35, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $32, $39
    db $28, $35, $29, $2F, $32, $3A, $28, $27, $90, $3A, $2C, $37, $2B, $EF, $EE, $37
    db $35, $28, $24, $36, $38, $35, $28, $36, $B5, $F7, $F0

Data_080_7086:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203086, $89

Data_080_710F:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $32
    db $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28, $35, $28, $90, $3A, $24
    db $36, $90, $24, $31, $90, $32, $2F, $27, $AB, $EF, $EE, $33, $32, $2F, $2C, $36
    db $2B, $28, $27, $90, $33, $32, $37, $B5, $F7, $F0

Data_080_7149:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203149, $BF

Data_080_7208:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $1C, $2E, $3C, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_080_7226:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203226, $48

Data_080_726E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20326E, $142

Data_080_73B0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2033B0, $45

Data_080_73F5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2033F5, $AC

Data_080_74A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2034A1, $DC

Data_080_757D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20357D, $85

Data_080_7602:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203602, $73

Data_080_7675:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203675, $6F

Data_080_76E4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2036E4, $D0

Data_080_77B4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2037B4, $CD

Data_080_7881:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $22, $32, $38, $90, $3A, $2C, $2F, $2F, $98, $F1, $1D, $2B, $24
    db $31, $2E, $90, $3C, $32, $38, $99, $FA, $F7, $EF, $EE, $15, $28, $37, $90, $30
    db $28, $90, $2B, $2C, $27, $28, $90, $24, $30, $32, $31, $2A, $EF, $EE, $3C, $32
    db $38, $35, $90, $2C, $37, $28, $30, $36, $B5, $F7, $F0

Data_080_78BC:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $F1, $22, $38, $31, $24
    db $1C, $32, $38, $2F, $B5, $F7, $F0

Data_080_78D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2038D3, $6B

Data_080_793E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $30, $90, $12, $90, $27, $35, $28, $24, $30, $2C, $31, $2A
    db $98, $F1, $1D, $3A, $32, $90, $14, $2C, $31, $2A, $36, $98, $F7, $F0

Data_080_795C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $98, $90, $20, $2B, $3C, $90, $24, $35, $28
    db $F1, $37, $2B, $28, $35, $28, $90, $37, $3A, $32, $90, $14, $2C, $31, $2A, $36
    db $98, $F7, $F0

Data_080_797F:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $32, $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $29
    db $28, $2F, $37, $90, $2D, $38, $36, $37, $90, $24, $EF, $EE, $2F, $2C, $37, $37
    db $2F, $28, $90, $3A, $24, $35, $30, $B5, $F7, $F0

Data_080_79B9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2039B9, $FE

Data_080_7AB7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203AB7, $CA

Data_080_7B81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203B81, $44

Data_080_7BC5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203BC5, $CC

Data_080_7C91:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203C91, $CE

Data_080_7D5F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203D5F, $87

Data_080_7DE6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $37, $38, $31, $31, $28, $2F, $F1, $2F
    db $28, $24, $27, $36, $90, $37, $32, $90, $24, $90, $33, $32, $35, $37, $B5, $F7
    db $F0

Data_080_7E07:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $2C, $26, $28, $90, $30, $28, $2F, $37, $28
    db $27, $F1, $24, $3A, $24, $3C, $99, $FA, $F7, $EF, $EE, $1D, $2B, $28, $90, $33
    db $32, $35, $37, $90, $26, $24, $31, $90, $25, $28, $EF, $EE, $38, $36, $28, $27
    db $90, $24, $2A, $24, $2C, $31, $B5, $F7, $F0

Data_080_7E40:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203E40, $87

Data_080_7EC7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $203EC7, $B9

Data_080_7F80:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1A, $38, $28, $28, $31, $90, $11, $28, $2F, $28, $31, $3E, $F1
    db $27, $35, $28, $24, $30, $36, $90, $26, $32, $30, $28, $90, $37, $35, $38, $28
    db $FA, $F7, $EF, $EE, $30, $32, $35, $28, $90, $32, $29, $37, $28, $31, $90, $37
    db $2B, $24, $31, $EF, $EE, $31, $32, $37, $B5, $F7, $F0
    ds $45, $00
