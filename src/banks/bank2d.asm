SECTION "Bank 2D", ROMX[$4000], BANK[$2D]
    db $2D

Func_02D_4001::
    ld a, [$C529]
    cp a, $D5
    jr c, Jump_02D_400F
    ld hl, Func_02D_4001
    ld b, $99
    rst $10
    ret

Jump_02D_400F::
    ld de, Data_02D_4032
    call Func_000_25C9
    ret

Func_02D_4016:: ; heuristic: follows a terminator; C0
    ld a, [$C529]
    cp a, $D5
    jr c, Jump_02D_4024
    ld hl, $4010
    ld b, $99
    rst $10
    ret

Jump_02D_4024::
    ld de, Data_02D_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_02D_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $34, $40
    dw Data_02D_41DE
    dw Data_02D_4265
    dw Data_02D_42FB
    dw Data_02D_43F3
    dw Data_02D_451F
    dw Data_02D_45B0
    dw Data_02D_4621
    dw Data_02D_46CA
    dw Data_02D_4731
    dw Data_02D_47A9
    dw Data_02D_482E
    dw Data_02D_4879
    dw Data_02D_4958
    dw Data_02D_499F
    dw Data_02D_4B3D
    dw Data_02D_4C61
    dw Data_02D_4CF8
    dw Data_02D_4D91
    dw Data_02D_4DF7
    dw Data_02D_4EAA
    dw Data_02D_4F38
    dw Data_02D_4F5B
    dw Data_02D_4F80
    dw Data_02D_500A
    dw Data_02D_506D
    dw Data_02D_50B6
    dw Data_02D_512D
    dw Data_02D_51BF
    dw Data_02D_5248
    dw Data_02D_52B8
    dw Data_02D_5344
    dw Data_02D_53AA
    dw Data_02D_5419
    dw Data_02D_547B
    dw Data_02D_54E7
    dw Data_02D_5569
    dw Data_02D_55F3
    dw Data_02D_563A
    dw Data_02D_5660
    dw Data_02D_56A9
    dw Data_02D_571E
    dw Data_02D_578D
    dw Data_02D_5816
    dw Data_02D_5855
    dw Data_02D_58E6
    dw Data_02D_5902
    dw Data_02D_591E
    dw Data_02D_593A
    dw Data_02D_597C
    dw Data_02D_59E7
    dw Data_02D_5A56
    dw Data_02D_5AC6
    dw Data_02D_5B11
    dw Data_02D_5B4C
    dw Data_02D_5BBA
    dw Data_02D_5C03
    dw Data_02D_5C84
    dw Data_02D_5D72
    dw Data_02D_5D90
    dw Data_02D_5DFB
    dw Data_02D_5E65
    dw Data_02D_5FA1
    dw Data_02D_600C
    dw Data_02D_6099
    dw Data_02D_60E3
    dw Data_02D_6105
    dw Data_02D_614D
    dw Data_02D_61B3
    dw Data_02D_61F1
    dw Data_02D_6210
    dw Data_02D_6251
    dw Data_02D_63B3
    dw Data_02D_63D7
    dw Data_02D_644B
    dw Data_02D_64D3
    dw Data_02D_6616
    dw Data_02D_6616
    dw Data_02D_6616
    dw Data_02D_6616
    dw Data_02D_6616
    dw Data_02D_6616
    dw Data_02D_6672
    dw Data_02D_66B3
    dw Data_02D_6716
    dw Data_02D_6738
    dw Data_02D_677F
    dw Data_02D_6806
    dw Data_02D_6900
    dw Data_02D_6BED
    dw Data_02D_6C9D
    dw Data_02D_6E3C
    dw Data_02D_6E5A
    dw Data_02D_6EDC
    dw Data_02D_6F66
    dw Data_02D_6FD2
    dw Data_02D_704B
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_70EC
    dw Data_02D_7110
    dw Data_02D_714A
    dw Data_02D_7190
    dw Data_02D_71D0
    dw Data_02D_721B
    dw Data_02D_7259
    dw Data_02D_727C
    dw Data_02D_72B5
    dw Data_02D_72EE
    dw Data_02D_7335
    dw Data_02D_737A
    dw Data_02D_73BC
    dw Data_02D_73FD
    dw Data_02D_7439
    dw Data_02D_7475
    dw Data_02D_74BF
    dw Data_02D_750B
    dw Data_02D_752D
    dw Data_02D_7573
    dw Data_02D_75BB
    dw Data_02D_7606
    dw Data_02D_7623
    dw Data_02D_7645
    dw Data_02D_7680
    dw Data_02D_76A3
    dw Data_02D_76C4
    dw Data_02D_76EA
    dw Data_02D_770B
    dw Data_02D_7754
    dw Data_02D_779F
    dw Data_02D_77D9
    dw Data_02D_77FC
    dw Data_02D_783E
    dw Data_02D_788A
    dw Data_02D_78A3
    dw Data_02D_78E1
    dw Data_02D_791C
    dw Data_02D_7940
    dw Data_02D_7986
    dw Data_02D_79D0
    dw Data_02D_7A11
    dw Data_02D_7A55
    dw Data_02D_7A93
    dw Data_02D_7AB0
    dw Data_02D_7AF5
    dw Data_02D_7B30
    dw Data_02D_7B7A
    dw Data_02D_7BBE
    dw Data_02D_7BE3
    dw Data_02D_7C20
    dw Data_02D_7C40
    dw Data_02D_7C8C
    dw Data_02D_7CCF
    dw Data_02D_7CF5
    dw Data_02D_7D31
    dw Data_02D_7D6D
    dw Data_02D_7DB1
    dw Data_02D_7DD9
    dw Data_02D_7E20
    dw Data_02D_7E60
    dw Data_02D_7E94
    dw Data_02D_7EAB
    dw Data_02D_7EF2
    dw Data_02D_7F2C

Data_02D_41DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B41DE, $87

Data_02D_4265:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4265, $96

Data_02D_42FB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B42FB, $F8

Data_02D_43F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B43F3, $12C

Data_02D_451F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B451F, $91

Data_02D_45B0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B45B0, $71

Data_02D_4621:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4621, $A9

Data_02D_46CA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B46CA, $67

Data_02D_4731:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4731, $78

Data_02D_47A9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B47A9, $85

Data_02D_482E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B482E, $4B

Data_02D_4879:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4879, $DF

Data_02D_4958:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4958, $47

Data_02D_499F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B499F, $19E

Data_02D_4B3D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4B3D, $124

Data_02D_4C61:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4C61, $97

Data_02D_4CF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4CF8, $99

Data_02D_4D91:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4D91, $66

Data_02D_4DF7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4DF7, $B3

Data_02D_4EAA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4EAA, $8E

Data_02D_4F38:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $2F, $AB, $90, $2F, $28, $37, $3E, $90, $36, $28
    db $28, $F1, $24, $25, $32, $38, $37, $90, $25, $35, $28, $28, $27, $2C, $31, $2A
    db $99, $F7, $F0

Data_02D_4F5B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $A4, $90, $19, $28, $35, $2B, $24, $33, $36, $90, $32
    db $31, $F1, $24, $31, $32, $37, $2B, $28, $35, $90, $32, $26, $26, $24, $36, $2C
    db $32, $31, $B5, $F7, $F0

Data_02D_4F80:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B4F80, $8A

Data_02D_500A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B500A, $63

Data_02D_506D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B506D, $49

Data_02D_50B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B50B6, $77

Data_02D_512D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B512D, $92

Data_02D_51BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B51BF, $89

Data_02D_5248:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5248, $70

Data_02D_52B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B52B8, $8C

Data_02D_5344:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5344, $66

Data_02D_53AA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B53AA, $6F

Data_02D_5419:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5419, $62

Data_02D_547B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B547B, $6C

Data_02D_54E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B54E7, $82

Data_02D_5569:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5569, $8A

Data_02D_55F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B55F3, $47

Data_02D_563A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0E, $39, $28, $35, $3C, $32, $31, $28, $3E, $90, $36, $24, $3C
    db $2C, $31, $2A, $F1, $10, $35, $28, $24, $37, $15, $32, $2A, $43, $2F, $90, $36
    db $2C, $31, $2E, $99, $F7, $F0

Data_02D_5660:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5660, $49

Data_02D_56A9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B56A9, $75

Data_02D_571E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B571E, $6F

Data_02D_578D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B578D, $89

Data_02D_5816:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $20, $24, $9C, $2B, $28, $3C
    db $99, $F1, $0A, $35, $28, $90, $3C, $32, $38, $90, $35, $28, $24, $27, $3C, $98
    db $FA, $F7, $EF, $EE, $1B, $28, $24, $27, $3C, $90, $29, $32, $35, $90, $15, $2C
    db $30, $25, $32, $98, $EF, $EE, $20, $24, $35, $32, $32, $2B, $99, $FF, $F0

Data_02D_5855:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5855, $91

Data_02D_58E6:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $1D, $2C, $27, $24, $2F, $0B, $28, $2F, $2F, $B5, $F7, $F0

Data_02D_5902:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $11, $24, $35, $16, $2C, $35, $35, $32, $35, $B5, $F7, $F0

Data_02D_591E:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $1C, $2E, $3C, $1C, $2B, $2C, $28, $2F, $27, $B5, $F7, $F0

Data_02D_593A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B593A, $42

Data_02D_597C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B597C, $6B

Data_02D_59E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B59E7, $6F

Data_02D_5A56:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5A56, $70

Data_02D_5AC6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5AC6, $4B

Data_02D_5B11:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $1D, $2B, $28, $35, $28, $99
    db $F1, $0A, $2F, $2F, $90, $2B, $28, $24, $2F, $37, $2B, $3C, $90, $31, $32, $3A
    db $99, $FA, $F7, $EF, $EE, $15, $28, $37, $90, $30, $28, $90, $36, $28, $28, $AB
    db $EF, $EE, $3A, $24, $35, $32, $32, $2B, $99, $F7, $F0

Data_02D_5B4C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5B4C, $6E

Data_02D_5BBA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5BBA, $49

Data_02D_5C03:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5C03, $81

Data_02D_5C84:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5C84, $EE

Data_02D_5D72:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $20, $24, $9C, $2B, $28, $3C
    db $99, $F1, $10, $28, $37, $90, $2A, $32, $2C, $31, $2A, $99, $F7, $F0

Data_02D_5D90:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5D90, $6B

Data_02D_5DFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5DFB, $6A

Data_02D_5E65:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5E65, $13C

Data_02D_5FA1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B5FA1, $6B

Data_02D_600C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B600C, $8D

Data_02D_6099:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6099, $4A

Data_02D_60E3:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $AB, $90, $3A, $32, $3A, $99, $90, $22, $32, $38, $40
    db $28, $F1, $35, $28, $24, $2F, $2F, $3C, $90, $29, $24, $30, $32, $38, $36, $99
    db $F7, $F0

Data_02D_6105:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6105, $48

Data_02D_614D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B614D, $66

Data_02D_61B3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44, $90, $2F, $2C, $2E, $28, $90, $30, $3C, $F1, $2A, $35
    db $24, $31, $27, $26, $2B, $2C, $2F, $27, $35, $28, $31, $90, $37, $32, $FA, $F7
    db $EF, $EE, $2F, $28, $24, $35, $31, $90, $36, $32, $30, $28, $37, $2B, $2C, $31
    db $2A, $EF, $EE, $29, $35, $32, $30, $90, $3C, $32, $38, $99, $F7, $F0

Data_02D_61F1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $A4, $12, $90, $26, $24, $31, $41, $90, $28, $24, $37, $F1
    db $24, $31, $32, $37, $2B, $28, $35, $A4, $90, $23, $3D, $3D, $A4, $F7, $F0

Data_02D_6210:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6210, $41

Data_02D_6251:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6251, $162

Data_02D_63B3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2B, $28, $2B, $28, $AB, $90, $31, $32, $90, $31, $28
    db $28, $27, $F1, $37, $32, $90, $3A, $32, $35, $35, $3C, $90, $37, $2B, $28, $35
    db $28, $99, $F7, $F0

Data_02D_63D7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B63D7, $74

Data_02D_644B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B644B, $88

Data_02D_64D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B64D3, $143

Data_02D_6616:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6616, $5C

Data_02D_6672:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6672, $41

Data_02D_66B3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B66B3, $63

Data_02D_6716:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $24, $2E, $28, $90, $37, $2B, $28, $36, $28, $90, $37, $32
    db $F1, $15, $32, $35, $27, $90, $0D, $24, $35, $26, $2E, $90, $31, $32, $3A, $B5
    db $F7, $F0

Data_02D_6738:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6738, $47

Data_02D_677F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B677F, $87

Data_02D_6806:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6806, $FA

Data_02D_6900:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6900, $2ED

Data_02D_6BED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6BED, $B0

Data_02D_6C9D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6C9D, $19F

Data_02D_6E3C:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $39, $32, $2C, $26, $28, $90, $28, $26, $2B, $32, $28, $27, $F1, $29
    db $35, $32, $30, $90, $31, $32, $3A, $2B, $28, $35, $28, $A4, $F7, $F0

Data_02D_6E5A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6E5A, $82

Data_02D_6EDC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6EDC, $8A

Data_02D_6F66:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6F66, $6C

Data_02D_6FD2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B6FD2, $79

Data_02D_704B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B704B, $A1

Data_02D_70EC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $3A, $32, $32, $2B, $99, $90, $12, $3F, $90, $2B, $32, $37
    db $99, $F1, $15, $28, $37, $3E, $90, $2A, $32, $90, $24, $2F, $35, $28, $24, $27
    db $3C, $99, $F7, $F0

Data_02D_7110:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $2A, $32, $2C, $31, $2A, $90, $37, $32, $90, $3A
    db $32, $35, $2E, $F1, $2B, $24, $35, $27, $90, $24, $31, $27, $90, $28, $24, $35
    db $31, $FA, $F7, $EF, $EE, $30, $3C, $36, $28, $2F, $29, $90, $F9, $00, $3E, $EF
    db $EE, $33, $35, $24, $2C, $36, $28, $B5, $F7, $F0

Data_02D_714A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B714A, $46

Data_02D_7190:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $AB, $90, $12, $90, $3A, $2C, $2F, $2F, $F1, $29, $2C
    db $2A, $2B, $37, $90, $3A, $2C, $37, $2B, $90, $30, $3C, $90, $2F, $2C, $29, $28
    db $FA, $F7, $EF, $EE, $29, $32, $35, $90, $3C, $32, $38, $35, $90, $2B, $32, $31
    db $32, $35, $90, $24, $31, $27, $EF, $EE, $2A, $2F, $32, $35, $3C, $B5, $F7, $F0

Data_02D_71D0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B71D0, $4B

Data_02D_721B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44, $90, $2F, $2C, $2E, $28, $90, $37, $32, $90, $36, $28
    db $28, $F1, $2B, $32, $3A, $90, $3A, $28, $2F, $2F, $90, $3C, $32, $38, $90, $26
    db $24, $31, $FA, $F7, $EF, $EE, $26, $32, $30, $30, $24, $31, $27, $90, $38, $36
    db $90, $2C, $31, $EF, $EE, $25, $24, $37, $37, $2F, $28, $B5, $F7, $F0

Data_02D_7259:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $AB, $90, $2B, $32, $3A, $90, $24, $25, $32, $38, $37
    db $F1, $3C, $32, $38, $90, $25, $24, $37, $37, $2F, $28, $90, $31, $28, $3B, $37
    db $98, $F7, $F0

Data_02D_727C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $27, $32, $31, $41, $90, $31, $28, $28, $27, $90, $24
    db $31, $3C, $F1, $25, $24, $26, $2E, $38, $33, $B5, $FA, $F7, $EF, $EE, $12, $43
    db $2F, $90, $2D, $38, $36, $37, $90, $30, $38, $36, $26, $2F, $28, $EF, $EE, $37
    db $2B, $35, $32, $38, $2A, $2B, $99, $F7, $F0

Data_02D_72B5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $17, $32, $90, $31, $28, $28, $27, $90, $29, $32, $35, $F1, $27
    db $28, $29, $28, $31, $36, $28, $99, $FA, $F7, $EF, $EE, $18, $29, $29, $28, $31
    db $36, $28, $90, $2C, $36, $90, $3A, $2B, $24, $37, $3E, $EF, $EE, $2C, $30, $33
    db $32, $35, $37, $24, $31, $37, $B5, $F7, $F0

Data_02D_72EE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B72EE, $47

Data_02D_7335:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7335, $45

Data_02D_737A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B737A, $42

Data_02D_73BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B73BC, $41

Data_02D_73FD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $2A, $32, $2C, $31, $2A, $90, $37, $32, $90, $2A
    db $28, $37, $F1, $36, $37, $35, $32, $31, $2A, $90, $24, $31, $27, $90, $2C, $30
    db $33, $35, $28, $36, $36, $FA, $F7, $EF, $EE, $F9, $00, $B5, $90, $22, $28, $36
    db $AB, $90, $12, $EF, $EE, $3A, $2C, $2F, $2F, $99, $F7, $F0

Data_02D_7439:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $3E, $90, $18, $14, $A4, $90, $12, $90, $35, $28, $24
    db $2F, $2F, $3C, $F1, $27, $2C, $27, $31, $41, $90, $3A, $24, $31, $37, $90, $24
    db $31, $3C, $FA, $F7, $EF, $EE, $30, $28, $24, $37, $90, $24, $31, $3C, $3A, $24
    db $3C, $AB, $EF, $EE, $2B, $38, $30, $33, $2B, $99, $F7, $F0

Data_02D_7475:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7475, $4A

Data_02D_74BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B74BF, $4C

Data_02D_750B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $2C, $39, $28, $90, $30, $28, $90, $30, $28, $24, $37, $99
    db $F1, $18, $35, $90, $12, $90, $3A, $32, $31, $41, $90, $32, $25, $28, $3C, $99
    db $F7, $F0

Data_02D_752D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B752D, $46

Data_02D_7573:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7573, $48

Data_02D_75BB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B75BB, $4B

Data_02D_7606:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1E, $30, $A4, $90, $1E, $2B, $A4, $90, $0E, $35, $A4, $F1, $12
    db $37, $3E, $90, $31, $32, $37, $2B, $2C, $31, $2A, $A4, $F7, $F0

Data_02D_7623:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0F, $2C, $2A, $2B, $37, $2C, $31, $2A, $90, $2C, $36, $31, $41
    db $F1, $30, $3C, $90, $2C, $27, $28, $24, $90, $32, $29, $90, $29, $38, $31, $A4
    db $F7, $F0

Data_02D_7645:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $3A, $24, $2B, $99, $F1, $22, $32, $38, $90, $36, $37, $24
    db $35, $37, $2F, $28, $27, $90, $30, $28, $99, $FA, $F7, $EF, $EE, $19, $2F, $28
    db $24, $36, $28, $90, $27, $32, $31, $41, $90, $36, $31, $28, $24, $2E, $EF, $EE
    db $38, $33, $90, $32, $31, $90, $30, $28, $B5, $F7, $F0

Data_02D_7680:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $2F, $28, $24, $36, $28, $90, $27, $32, $31, $41, $90, $2E
    db $2C, $2F, $2F, $F1, $28, $39, $28, $31, $90, $28, $31, $28, $30, $2C, $28, $36
    db $B5, $F7, $F0

Data_02D_76A3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $24, $3C, $99, $90, $20, $32, $32, $2B, $32, $32, $99, $F1
    db $20, $28, $40, $28, $90, $2A, $32, $2C, $31, $2A, $90, $32, $38, $37, $99, $F7
    db $F0

Data_02D_76C4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $3A, $3A, $A4, $90, $16, $38, $36, $37, $90, $3A, $28, $90
    db $2A, $32, $98, $F1, $1D, $2B, $24, $37, $3E, $90, $2F, $2C, $2E, $28, $90, $3A
    db $32, $35, $2E, $99, $F7, $F0

Data_02D_76EA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $14, $99, $90, $0C, $32, $30, $28, $90, $32, $31, $99, $F1
    db $F9, $00, $90, $37, $32, $32, $AB, $90, $2B, $38, $36, $37, $2F, $28, $99, $F7
    db $F0

Data_02D_770B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B770B, $49

Data_02D_7754:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7754, $4B

Data_02D_779F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $32, $2A, $28, $37, $2B, $28, $35, $AB, $90, $3A, $28, $F1
    db $36, $2B, $24, $2F, $2F, $90, $29, $32, $35, $30, $90, $37, $2B, $28, $FA, $F7
    db $EF, $EE, $3A, $32, $35, $2F, $27, $3E, $90, $2A, $35, $28, $24, $37, $28, $36
    db $37, $EF, $EE, $37, $28, $24, $30, $99, $F7, $F0

Data_02D_77D9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $29, $90, $3C, $32, $38, $90, $27, $24, $3A, $27, $2F, $28
    db $AB, $F1, $12, $3F, $90, $2F, $28, $24, $39, $2C, $31, $2A, $90, $3C, $32, $38
    db $B5, $F7, $F0

Data_02D_77FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B77FC, $42

Data_02D_783E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B783E, $4C

Data_02D_788A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $30, $24, $2E, $28, $90, $30, $3C, $90, $32, $3A, $31
    db $F1, $35, $32, $24, $27, $36, $99, $F7, $F0

Data_02D_78A3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0C, $2B, $24, $35, $2A, $28, $AB, $90, $26, $2B, $24, $35, $2A
    db $28, $AB, $F1, $26, $2B, $24, $35, $2A, $28, $99, $FA, $F7, $EF, $EE, $1D, $2B
    db $28, $35, $28, $3E, $90, $31, $32, $90, $37, $38, $35, $31, $2C, $31, $2A, $EF
    db $EE, $25, $24, $26, $2E, $AB, $90, $28, $39, $28, $35, $99, $F7, $F0

Data_02D_78E1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $2F, $32, $32, $2E, $2C, $31, $2A, $F1, $29, $32
    db $35, $3A, $24, $35, $27, $90, $37, $32, $90, $2A, $32, $2C, $31, $2A, $FA, $F7
    db $EF, $EE, $32, $31, $90, $24, $90, $2D, $32, $38, $35, $31, $28, $3C, $90, $3A
    db $2C, $37, $2B, $EF, $EE, $3C, $32, $38, $B5, $F7, $F0

Data_02D_791C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $90, $2B, $24, $39, $28, $90, $37, $32, $90, $36, $37
    db $2C, $26, $2E, $F1, $37, $32, $90, $24, $90, $36, $26, $2B, $28, $27, $38, $2F
    db $28, $99, $F7, $F0

Data_02D_7940:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7940, $46

Data_02D_7986:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7986, $4A

Data_02D_79D0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B79D0, $41

Data_02D_7A11:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7A11, $44

Data_02D_7A55:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $A4, $90, $12, $90, $30, $38, $36, $37, $F1, $36, $24
    db $3C, $90, $37, $2B, $2C, $36, $A4, $FA, $F7, $EF, $EE, $22, $32, $38, $35, $90
    db $26, $2F, $32, $37, $2B, $28, $36, $90, $24, $35, $28, $EF, $EE, $32, $38, $37
    db $90, $32, $29, $90, $29, $24, $36, $2B, $2C, $32, $31, $B5, $F7, $F0

Data_02D_7A93:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $31, $32, $37, $90, $2A, $32, $32, $27, $F1, $3A
    db $2C, $37, $2B, $90, $26, $32, $30, $25, $32, $36, $A4, $F7, $F0

Data_02D_7AB0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7AB0, $45

Data_02D_7AF5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $43, $2F, $90, $37, $2B, $2C, $31, $2E, $90, $38, $33, $F1
    db $31, $28, $3A, $90, $33, $2F, $24, $31, $36, $99, $FA, $F7, $EF, $EE, $12, $43
    db $2F, $90, $37, $28, $24, $26, $2B, $90, $37, $2B, $28, $30, $90, $37, $32, $EF
    db $EE, $3C, $32, $38, $AB, $90, $F9, $00, $99, $F7, $F0

Data_02D_7B30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7B30, $4A

Data_02D_7B7A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7B7A, $44

Data_02D_7BBE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0D, $32, $31, $41, $90, $37, $24, $2F, $2E, $90, $37, $32, $90
    db $30, $28, $A4, $F1, $12, $90, $27, $32, $31, $41, $90, $2F, $2C, $2E, $28, $90
    db $2C, $37, $A4, $F7, $F0

Data_02D_7BE3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $AB, $90, $3C, $32, $38, $90, $36, $38, $35, $28, $F1
    db $3A, $32, $35, $2E, $90, $2B, $24, $35, $27, $99, $FA, $F7, $EF, $EE, $22, $32
    db $38, $40, $28, $90, $2D, $38, $36, $37, $90, $24, $EF, $EE, $2F, $2C, $37, $37
    db $2F, $28, $90, $2E, $2C, $27, $90, $37, $32, $32, $99, $F7, $F0

Data_02D_7C20:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $28, $37, $3E, $90, $36, $37, $24, $3C, $90, $24, $3A, $24
    db $3C, $F1, $29, $35, $32, $30, $90, $27, $24, $31, $2A, $28, $35, $B5, $F7, $F0

Data_02D_7C40:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7C40, $4C

Data_02D_7C8C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7C8C, $43

Data_02D_7CCF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $27, $32, $31, $41, $90, $3A, $24, $31, $37, $90, $37
    db $32, $F1, $26, $2B, $24, $37, $B5, $90, $15, $28, $24, $39, $28, $90, $30, $28
    db $90, $25, $28, $B5, $F7, $F0

Data_02D_7CF5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $99, $90, $15, $28, $37, $3E, $90, $2A, $28, $37, $F1
    db $30, $32, $39, $2C, $31, $2A, $90, $34, $38, $2C, $26, $2E, $99, $FA, $F7, $EF
    db $EE, $12, $90, $35, $28, $2F, $2C, $36, $2B, $90, $37, $2B, $2C, $36, $EF, $EE
    db $26, $2B, $24, $2F, $2F, $28, $31, $2A, $28, $99, $F7, $F0

Data_02D_7D31:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0F, $32, $35, $90, $37, $32, $30, $32, $35, $35, $32, $3A, $3E
    db $F1, $39, $2C, $26, $37, $32, $35, $2C, $28, $36, $AB, $FA, $F7, $EF, $EE, $12
    db $43, $2F, $90, $36, $33, $24, $35, $28, $90, $31, $32, $EF, $EE, $28, $29, $29
    db $32, $35, $37, $90, $37, $32, $27, $24, $3C, $99, $F7, $F0

Data_02D_7D6D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7D6D, $44

Data_02D_7DB1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $31, $90, $25, $24, $37, $37, $2F, $28, $AB, $90, $28, $39
    db $28, $35, $3C, $F1, $36, $28, $26, $32, $31, $27, $90, $2C, $36, $90, $24, $90
    db $27, $35, $24, $30, $24, $99, $F7, $F0

Data_02D_7DD9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7DD9, $47

Data_02D_7E20:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $98, $90, $1D, $2B, $2C, $36, $90, $2B, $38, $30, $24
    db $31, $F1, $33, $35, $28, $36, $38, $30, $28, $36, $90, $37, $32, $90, $32, $35
    db $27, $28, $35, $FA, $F7, $EF, $EE, $30, $28, $90, $24, $35, $32, $38, $31, $27
    db $98, $EF, $EE, $11, $32, $3A, $90, $24, $25, $36, $38, $35, $27, $B5, $F7, $F0

Data_02D_7E60:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $17, $32, $90, $30, $28, $35, $26, $3C, $90, $31, $28, $28, $27
    db $28, $27, $F1, $29, $32, $35, $90, $28, $31, $28, $30, $2C, $28, $36, $99, $FA
    db $F7, $EF, $EE, $1C, $30, $24, $36, $2B, $95, $28, $30, $90, $24, $2F, $2F, $99
    db $EF, $EE, $F7, $F0

Data_02D_7E94:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $17, $32, $90, $2A, $38, $37, $36, $AB, $F1, $31, $32, $90, $2A
    db $2F, $32, $35, $3C, $99, $F7, $F0

Data_02D_7EAB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7EAB, $47

Data_02D_7EF2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $29, $90, $12, $90, $26, $24, $31, $90, $2A, $28, $37, $F1
    db $2F, $38, $26, $2E, $90, $32, $31, $90, $30, $3C, $90, $36, $2C, $27, $28, $AB
    db $FA, $F7, $EF, $EE, $12, $90, $26, $24, $31, $90, $3A, $2C, $31, $90, $37, $2B
    db $28, $30, $EF, $EE, $24, $2F, $2F, $B5, $F7, $F0

Data_02D_7F2C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B7F2C, $46
    ds $8E, $00
