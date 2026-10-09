SECTION "Bank 2B", ROMX[$4000], BANK[$2B]
    db $2B

Func_02B_4001::
    ld a, [wC529]
    cp a, $8A
    jr c, Jump_02B_400F
    ld hl, Func_098_4001
    ld b, $98
    rst $10
    ret

Jump_02B_400F::
    ld de, Data_02B_4032
    call Func_000_25C9
    ret

Func_02B_4016:: ; heuristic: follows a terminator; C0
    ld a, [wC529]
    cp a, $8A
    jr c, Jump_02B_4024
    ld hl, Func_098_4010
    ld b, $98
    rst $10
    ret

Jump_02B_4024::
    ld de, Data_02B_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_02B_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_02B_4034

Data_02B_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02B_4148
    dw Data_02B_417B
    dw Data_02B_41DE
    dw Data_02B_42D5
    dw Data_02B_433E
    dw Data_02B_4406
    dw Data_02B_44AA
    dw Data_02B_4514
    dw Data_02B_45F2
    dw Data_02B_462A
    dw Data_02B_4798
    dw Data_02B_4905
    dw Data_02B_49DE
    dw Data_02B_4A44
    dw Data_02B_4A7C
    dw Data_02B_4B5D
    dw Data_02B_4BC8
    dw Data_02B_4BF0
    dw Data_02B_4C33
    dw Data_02B_4C73
    dw Data_02B_4CAD
    dw Data_02B_4CF1
    dw Data_02B_4D80
    dw Data_02B_4DB6
    dw Data_02B_4FA3
    dw Data_02B_509C
    dw Data_02B_50D7
    dw Data_02B_5189
    dw Data_02B_5210
    dw Data_02B_526D
    dw Data_02B_528F
    dw Data_02B_52F1
    dw Data_02B_535E
    dw Data_02B_53CA
    dw Data_02B_543F
    dw Data_02B_557B
    dw Data_02B_55E1
    dw Data_02B_564E
    dw Data_02B_566D
    dw Data_02B_56D8
    dw Data_02B_571E
    dw Data_02B_57EC
    dw Data_02B_587B
    dw Data_02B_58C0
    dw Data_02B_592B
    dw Data_02B_598D
    dw Data_02B_59FA
    dw Data_02B_5A68
    dw Data_02B_5ADA
    dw Data_02B_5B49
    dw Data_02B_5B6D
    dw Data_02B_5B93
    dw Data_02B_5BB7
    dw Data_02B_5C87
    dw Data_02B_5D1C
    dw Data_02B_5D68
    dw Data_02B_5E17
    dw Data_02B_5E80
    dw Data_02B_5F07
    dw Data_02B_5F71
    dw Data_02B_6065
    dw Data_02B_613B
    dw Data_02B_61A8
    dw Data_02B_623A
    dw Data_02B_62A8
    dw Data_02B_62F1
    dw Data_02B_6359
    dw Data_02B_639B
    dw Data_02B_63DF
    dw Data_02B_6440
    dw Data_02B_6463
    dw Data_02B_6507
    dw Data_02B_652C
    dw Data_02B_654C
    dw Data_02B_656F
    dw Data_02B_6596
    dw Data_02B_6612
    dw Data_02B_6637
    dw Data_02B_6678
    dw Data_02B_66E1
    dw Data_02B_674C
    dw Data_02B_67DF
    dw Data_02B_688D
    dw Data_02B_68E2
    dw Data_02B_6931
    dw Data_02B_697C
    dw Data_02B_69E0
    dw Data_02B_6A1F
    dw Data_02B_6ACA
    dw Data_02B_6B61
    dw Data_02B_6C21
    dw Data_02B_6C8A
    dw Data_02B_6CEB
    dw Data_02B_6E26
    dw Data_02B_6EA9
    dw Data_02B_6F04
    dw Data_02B_6F5F
    dw Data_02B_6F9D
    dw Data_02B_6FDE
    dw Data_02B_6FFC
    dw Data_02B_703B
    dw Data_02B_7078
    dw Data_02B_7098
    dw Data_02B_70D9
    dw Data_02B_70FB
    dw Data_02B_711E
    dw Data_02B_7162
    dw Data_02B_71AF
    dw Data_02B_71CB
    dw Data_02B_71EC
    dw Data_02B_7231
    dw Data_02B_726A
    dw Data_02B_72B1
    dw Data_02B_731C
    dw Data_02B_7339
    dw Data_02B_737D
    dw Data_02B_73BE
    dw Data_02B_747D
    dw Data_02B_74E9
    dw Data_02B_756D
    dw Data_02B_75B6
    dw Data_02B_761D
    dw Data_02B_76A9
    dw Data_02B_7719
    dw Data_02B_777E
    dw Data_02B_77DE
    dw Data_02B_7849
    dw Data_02B_788C
    dw Data_02B_7936
    dw Data_02B_79C1
    dw Data_02B_7A2A
    dw Data_02B_7AB6
    dw Data_02B_7B3F
    dw Data_02B_7BBF
    dw Data_02B_7C1F
    dw Data_02B_7C81
    dw Data_02B_7D19
    dw Data_02B_7D86

Data_02B_4148:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $2C, $36, $90, $17, $32, $35, $27, $28
    db $31, $AB, $F1, $37, $2B, $28, $90, $2E, $2C, $31, $2A, $27, $32, $30, $90, $32
    db $29, $90, $37, $2B, $28, $FA, $F7, $EF, $EE, $31, $32, $35, $37, $2B, $B5, $EF
    db $EE, $F7, $F0

Data_02B_417B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC17B, $63

Data_02B_41DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC1DE, $F7

Data_02B_42D5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC2D5, $69

Data_02B_433E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC33E, $C8

Data_02B_4406:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC406, $A4

Data_02B_44AA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC4AA, $6A

Data_02B_4514:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC514, $DE

Data_02B_45F2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $24, $39, $28, $90, $3C, $32, $38, $90, $2B, $28, $24, $35
    db $27, $F1, $24, $25, $32, $38, $37, $90, $37, $2B, $28, $90, $36, $33, $2C, $35
    db $2C, $37, $FA, $F7, $EF, $EE, $2C, $31, $90, $37, $2B, $28, $90, $36, $33, $35
    db $2C, $31, $2A, $98, $EF, $EE, $FF, $F0

Data_02B_462A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC62A, $16E

Data_02B_4798:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC798, $16D

Data_02B_4905:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC905, $D9

Data_02B_49DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AC9DE, $66

Data_02B_4A44:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $90, $37, $32, $90, $32, $38
    db $35, $F1, $26, $2B, $38, $35, $26, $2B, $B5, $FA, $F7, $EF, $EE, $11, $32, $3A
    db $90, $30, $24, $3C, $90, $12, $90, $25, $28, $90, $32, $29, $EF, $EE, $36, $28
    db $35, $39, $2C, $26, $28, $98, $F7, $F0

Data_02B_4A7C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ACA7C, $E1

Data_02B_4B5D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ACB5D, $6B

Data_02B_4BC8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $99, $90, $11, $32, $3A, $90
    db $30, $24, $3C, $F1, $12, $90, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $90
    db $37, $32, $27, $24, $3C, $98, $F7, $F0

Data_02B_4BF0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ACBF0, $43

Data_02B_4C33:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $25, $24, $35, $35, $28, $2F, $B5, $FA, $F7, $EF, $EE, $12, $37
    db $90, $3A, $24, $36, $90, $29, $2C, $2F, $2F, $28, $27, $90, $3A, $2C, $37, $2B
    db $EF, $EE, $25, $2F, $24, $26, $2E, $90, $35, $32, $26, $2E, $36, $B5, $F7, $F0

Data_02B_4C73:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $32, $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $29
    db $28, $2F, $37, $90, $2D, $38, $36, $37, $90, $24, $EF, $EE, $2F, $2C, $37, $37
    db $2F, $28, $90, $3A, $24, $35, $30, $B5, $F7, $F0

Data_02B_4CAD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ACCAD, $44

Data_02B_4CF1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ACCF1, $8F

Data_02B_4D80:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $36
    db $2B, $2C, $28, $2F, $27, $B5, $FA, $F7, $EF, $EE, $0A, $90, $25, $28, $24, $38
    db $37, $2C, $29, $38, $2F, $90, $39, $32, $2C, $26, $28, $EF, $EE, $28, $26, $2B
    db $32, $28, $27, $B5, $F7, $F0

Data_02B_4DB6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ACDB6, $1ED

Data_02B_4FA3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ACFA3, $F9

Data_02B_509C:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $EF, $EE, $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B
    db $28, $EF, $EE, $0C, $35, $28, $36, $37, $B5, $F7, $F0

Data_02B_50D7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD0D7, $B2

Data_02B_5189:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD189, $87

Data_02B_5210:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD210, $5D

Data_02B_526D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $2F, $28, $24, $36, $28, $90, $28, $31, $37, $28, $35, $AB
    db $F1, $3C, $32, $38, $35, $90, $28, $31, $39, $32, $3C, $36, $2B, $2C, $33, $99
    db $F7, $F0

Data_02B_528F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD28F, $62

Data_02B_52F1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD2F1, $6D

Data_02B_535E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD35E, $6C

Data_02B_53CA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD3CA, $75

Data_02B_543F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD43F, $13C

Data_02B_557B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD57B, $66

Data_02B_55E1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD5E1, $6D

Data_02B_564E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $2C, $36, $90, $37, $2B, $28, $90, $33
    db $32, $35, $37, $F1, $32, $29, $90, $17, $32, $29, $32, $35, $B5, $F7, $F0

Data_02B_566D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD66D, $6B

Data_02B_56D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD6D8, $46

Data_02B_571E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD71E, $CE

Data_02B_57EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD7EC, $8F

Data_02B_587B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD87B, $45

Data_02B_58C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD8C0, $6B

Data_02B_592B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD92B, $62

Data_02B_598D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD98D, $6D

Data_02B_59FA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AD9FA, $6E

Data_02B_5A68:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ADA68, $72

Data_02B_5ADA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ADADA, $6F

Data_02B_5B49:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $99, $90, $20, $2B, $24, $37
    db $F1, $26, $24, $31, $90, $12, $90, $27, $32, $90, $29, $32, $35, $90, $3C, $32
    db $38, $98, $F7, $F0

Data_02B_5B6D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $35, $28, $28, $37, $2C, $31, $2A, $36, $99, $90, $11, $32
    db $3A, $F1, $36, $2B, $24, $2F, $2F, $90, $12, $90, $36, $28, $35, $39, $28, $90
    db $3C, $32, $38, $98, $F7, $F0

Data_02B_5B93:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2F, $2F, $32, $99, $90, $11, $24, $39, $28, $90, $24
    db $F1, $2F, $32, $32, $2E, $90, $24, $37, $90, $30, $3C, $90, $3A, $24, $35, $28
    db $36, $99, $F7, $F0

Data_02B_5BB7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ADBB7, $D0

Data_02B_5C87:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ADC87, $95

Data_02B_5D1C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ADD1C, $4C

Data_02B_5D68:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ADD68, $AF

Data_02B_5E17:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ADE17, $69

Data_02B_5E80:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ADE80, $87

Data_02B_5F07:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ADF07, $6A

Data_02B_5F71:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ADF71, $F4

Data_02B_6065:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE065, $D6

Data_02B_613B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE13B, $6D

Data_02B_61A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE1A8, $92

Data_02B_623A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE23A, $6E

Data_02B_62A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE2A8, $49

Data_02B_62F1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE2F1, $68

Data_02B_6359:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE359, $42

Data_02B_639B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE39B, $44

Data_02B_63DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE3DF, $61

Data_02B_6440:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $14, $2C, $27, $AB, $90, $3C, $32, $38, $90, $2B, $24, $39, $28
    db $F1, $2A, $38, $37, $36, $90, $37, $32, $90, $25, $28, $90, $2B, $28, $35, $28
    db $B5, $F7, $F0

Data_02B_6463:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE463, $A4

Data_02B_6507:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $24, $2A, $24, $2C, $31, $98, $90, $12, $43
    db $2F, $F1, $2B, $24, $39, $28, $90, $37, $32, $90, $2A, $28, $37, $90, $38, $2A
    db $2F, $3C, $B5, $F7, $F0

Data_02B_652C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0D, $24, $35, $31, $99, $90, $1D, $24, $2E, $28, $90, $37, $2B
    db $2C, $36, $99, $F1, $1C, $0A, $0C, $1B, $12, $0F, $12, $0C, $0E, $99, $F7, $F0

Data_02B_654C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $98, $90, $20, $2B, $24, $37, $90, $3A, $24
    db $36, $F1, $37, $2B, $24, $37, $90, $28, $3B, $33, $2F, $32, $36, $2C, $32, $31
    db $98, $F7, $F0

Data_02B_656F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $37, $90, $27, $38, $36, $37, $90, $37, $2B, $28
    db $35, $28, $A4, $F1, $12, $36, $90, $37, $2B, $24, $37, $90, $37, $2B, $28, $90
    db $2A, $32, $2F, $27, $98, $F7, $F0

Data_02B_6596:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE596, $7C

Data_02B_6612:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $44, $90, $25, $28, $37, $37, $28, $35, $90, $2A, $28
    db $37, $F1, $3A, $32, $35, $27, $90, $37, $32, $90, $37, $2B, $28, $90, $14, $2C
    db $31, $2A, $99, $F7, $F0

Data_02B_6637:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE637, $41

Data_02B_6678:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE678, $69

Data_02B_66E1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE6E1, $6B

Data_02B_674C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE74C, $93

Data_02B_67DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE7DF, $AE

Data_02B_688D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE88D, $55

Data_02B_68E2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE8E2, $4F

Data_02B_6931:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE931, $4B

Data_02B_697C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AE97C, $64

Data_02B_69E0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $35, $28, $3E, $90, $2D, $38, $36, $37, $90, $31
    db $32, $F1, $37, $28, $2F, $2F, $2C, $31, $2A, $90, $3A, $2B, $24, $37, $90, $2A
    db $35, $28, $28, $27, $FA, $F7, $EF, $EE, $3A, $2C, $2F, $2F, $90, $30, $24, $2E
    db $28, $90, $33, $28, $32, $33, $2F, $28, $EF, $EE, $27, $32, $A4, $F7, $F0

Data_02B_6A1F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AEA1F, $AB

Data_02B_6ACA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AEACA, $97

Data_02B_6B61:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AEB61, $C0

Data_02B_6C21:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AEC21, $69

Data_02B_6C8A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AEC8A, $61

Data_02B_6CEB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AECEB, $13B

Data_02B_6E26:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AEE26, $83

Data_02B_6EA9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AEEA9, $5B

Data_02B_6F04:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AEF04, $5B

Data_02B_6F5F:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $37, $24, $33, $33, $28, $27, $90, $32, $31, $F1, $37, $2B, $28
    db $90, $3A, $24, $2F, $2F, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28, $90, $3A, $24
    db $2F, $2F, $90, $36, $32, $38, $31, $27, $28, $27, $EF, $EE, $2B, $28, $24, $39
    db $3C, $90, $24, $31, $27, $90, $36, $32, $2F, $2C, $27, $B5, $F7, $F0

Data_02B_6F9D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AEF9D, $41

Data_02B_6FDE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $A4, $F9, $00, $A4, $F1, $1D, $2B
    db $24, $37, $90, $3A, $24, $36, $31, $41, $90, $2C, $37, $A4, $F7, $F0

Data_02B_6FFC:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $37, $24, $33, $33, $28, $27, $90, $32, $31, $F1, $37, $2B, $28
    db $90, $3A, $24, $2F, $2F, $B5, $FA, $F7, $EF, $EE, $1C, $32, $38, $31, $27, $90
    db $28, $26, $2B, $32, $28, $27, $90, $24, $36, $90, $2C, $29, $EF, $EE, $2C, $37
    db $90, $3A, $28, $35, $28, $90, $2B, $32, $2F, $2F, $32, $3A, $B5, $F7, $F0

Data_02B_703B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $1D, $2B, $24, $37, $3E, $90, $2C
    db $37, $99, $F1, $1D, $2B, $24, $37, $3E, $90, $37, $2B, $28, $90, $28, $3B, $2C
    db $37, $99, $FA, $F7, $EF, $EE, $F9, $00, $AB, $90, $12, $43, $2F, $90, $2A, $32
    db $90, $32, $31, $EF, $EE, $24, $2B, $28, $24, $27, $99, $F7, $F0

Data_02B_7078:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $37, $2B, $28, $90, $35, $28, $24, $2F, $F1, $14
    db $2C, $31, $2A, $AB, $90, $3C, $32, $38, $90, $29, $24, $2E, $28, $99, $F7, $F0

Data_02B_7098:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF098, $41

Data_02B_70D9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $35, $28, $24, $2F, $99, $90, $0D, $32, $31, $41
    db $F1, $3C, $32, $38, $90, $25, $28, $2F, $2C, $28, $39, $28, $90, $30, $28, $98
    db $F7, $F0

Data_02B_70FB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $32, $32, $2E, $90, $2C, $31, $90, $30, $3C, $90, $28, $3C
    db $28, $36, $99, $F1, $12, $3F, $90, $31, $32, $37, $90, $2F, $3C, $2C, $31, $2A
    db $99, $F7, $F0

Data_02B_711E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF11E, $44

Data_02B_7162:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF162, $4D

Data_02B_71AF:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $30, $2C, $35, $35, $32, $35, $90, $36, $2B, $32, $3A, $36
    db $F1, $37, $2B, $28, $90, $14, $2C, $31, $2A, $B5, $F7, $F0

Data_02B_71CB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $24, $30, $90, $35, $28, $24, $2F, $99, $F1, $0D, $32
    db $31, $41, $90, $25, $28, $2F, $2C, $28, $39, $28, $90, $2B, $2C, $30, $99, $F7
    db $F0

Data_02B_71EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF1EC, $45

Data_02B_7231:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $32, $32, $2E, $90, $24, $37, $90, $2B, $2C, $30, $99, $F1
    db $11, $28, $3E, $90, $2A, $35, $2C, $30, $3C, $99, $FA, $F7, $EF, $EE, $11, $28
    db $3E, $90, $31, $32, $90, $26, $32, $30, $33, $24, $35, $2C, $36, $32, $31, $EF
    db $EE, $37, $32, $90, $30, $28, $99, $F7, $F0

Data_02B_726A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF26A, $47

Data_02B_72B1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF2B1, $6B

Data_02B_731C:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $30, $2C, $35, $35, $32, $35, $90, $36, $2B, $32, $3A, $36
    db $90, $24, $F1, $30, $32, $31, $36, $37, $28, $35, $B5, $F7, $F0

Data_02B_7339:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF339, $44

Data_02B_737D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF37D, $41

Data_02B_73BE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF3BE, $BF

Data_02B_747D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF47D, $6C

Data_02B_74E9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF4E9, $84

Data_02B_756D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF56D, $49

Data_02B_75B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF5B6, $67

Data_02B_761D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF61D, $8C

Data_02B_76A9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF6A9, $70

Data_02B_7719:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF719, $65

Data_02B_777E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF77E, $60

Data_02B_77DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF7DE, $6B

Data_02B_7849:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF849, $43

Data_02B_788C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF88C, $AA

Data_02B_7936:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF936, $8B

Data_02B_79C1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AF9C1, $69

Data_02B_7A2A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AFA2A, $8C

Data_02B_7AB6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AFAB6, $89

Data_02B_7B3F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AFB3F, $80

Data_02B_7BBF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AFBBF, $60

Data_02B_7C1F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AFC1F, $62

Data_02B_7C81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AFC81, $98

Data_02B_7D19:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AFD19, $6D

Data_02B_7D86:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AFD86, $F7
    ds $183, $00
