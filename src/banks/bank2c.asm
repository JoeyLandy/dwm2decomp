SECTION "Bank 2C", ROMX[$4000], BANK[$2C]
    db $2C

Func_02C_4001::
    ld a, [wC529]
    cp a, $91
    jr c, Jump_02C_400F
    ld hl, Func_098_4026
    ld b, $98
    rst $10
    ret

Jump_02C_400F::
    ld de, Data_02C_4032
    call Func_000_25C9
    ret

Func_02C_4016:: ; heuristic: follows a terminator; C0
    ld a, [wC529]
    cp a, $91
    jr c, Jump_02C_4024
    ld hl, Func_098_4035
    ld b, $98
    rst $10
    ret

Jump_02C_4024::
    ld de, Data_02C_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_02C_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_02C_4034

Data_02C_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02C_4156
    dw Data_02C_41C4
    dw Data_02C_4241
    dw Data_02C_42AE
    dw Data_02C_43DB
    dw Data_02C_444D
    dw Data_02C_4500
    dw Data_02C_4568
    dw Data_02C_45F8
    dw Data_02C_464F
    dw Data_02C_46E5
    dw Data_02C_4772
    dw Data_02C_47E7
    dw Data_02C_48D4
    dw Data_02C_4983
    dw Data_02C_49C1
    dw Data_02C_49FE
    dw Data_02C_4A84
    dw Data_02C_4AF9
    dw Data_02C_4B07
    dw Data_02C_4B68
    dw Data_02C_4C0E
    dw Data_02C_4D7F
    dw Data_02C_4E2B
    dw Data_02C_4E6E
    dw Data_02C_4F43
    dw Data_02C_4F82
    dw Data_02C_4FE0
    dw Data_02C_505F
    dw Data_02C_50B9
    dw Data_02C_50F6
    dw Data_02C_513A
    dw Data_02C_515A
    dw Data_02C_51BB
    dw Data_02C_524A
    dw Data_02C_52D7
    dw Data_02C_5342
    dw Data_02C_53B6
    dw Data_02C_541F
    dw Data_02C_543B
    dw Data_02C_5462
    dw Data_02C_5486
    dw Data_02C_54CA
    dw Data_02C_553F
    dw Data_02C_55F0
    dw Data_02C_56A1
    dw Data_02C_56C3
    dw Data_02C_56EB
    dw Data_02C_572E
    dw Data_02C_576C
    dw Data_02C_57A7
    dw Data_02C_57C9
    dw Data_02C_57D8
    dw Data_02C_581F
    dw Data_02C_5880
    dw Data_02C_58D8
    dw Data_02C_5920
    dw Data_02C_59A7
    dw Data_02C_59EE
    dw Data_02C_5AE6
    dw Data_02C_5B09
    dw Data_02C_5B74
    dw Data_02C_5BDF
    dw Data_02C_5C67
    dw Data_02C_5CF2
    dw Data_02C_5D62
    dw Data_02C_5DA4
    dw Data_02C_5DE4
    dw Data_02C_5E4D
    dw Data_02C_5EDD
    dw Data_02C_5FDC
    dw Data_02C_6069
    dw Data_02C_60AE
    dw Data_02C_611B
    dw Data_02C_6169
    dw Data_02C_61DE
    dw Data_02C_6200
    dw Data_02C_6221
    dw Data_02C_62BD
    dw Data_02C_637D
    dw Data_02C_63B5
    dw Data_02C_641E
    dw Data_02C_6436
    dw Data_02C_649D
    dw Data_02C_649D
    dw Data_02C_649D
    dw Data_02C_64E1
    dw Data_02C_654E
    dw Data_02C_65B8
    dw Data_02C_6694
    dw Data_02C_6723
    dw Data_02C_6764
    dw Data_02C_67A5
    dw Data_02C_67E6
    dw Data_02C_6872
    dw Data_02C_6898
    dw Data_02C_68DB
    dw Data_02C_6922
    dw Data_02C_6961
    dw Data_02C_699E
    dw Data_02C_69F8
    dw Data_02C_6A3C
    dw Data_02C_6A56
    dw Data_02C_6B04
    dw Data_02C_6B90
    dw Data_02C_6BCD
    dw Data_02C_6C1F
    dw Data_02C_6C5F
    dw Data_02C_6CA4
    dw Data_02C_6CEA
    dw Data_02C_6D49
    dw Data_02C_6DB2
    dw Data_02C_6E6A
    dw Data_02C_6E8B
    dw Data_02C_6F7A
    dw Data_02C_7014
    dw Data_02C_7057
    dw Data_02C_70DA
    dw Data_02C_711C
    dw Data_02C_715F
    dw Data_02C_71CB
    dw Data_02C_720A
    dw Data_02C_72F8
    dw Data_02C_733D
    dw Data_02C_7360
    dw Data_02C_7382
    dw Data_02C_73A4
    dw Data_02C_7457
    dw Data_02C_74C8
    dw Data_02C_75B4
    dw Data_02C_7765
    dw Data_02C_782C
    dw Data_02C_7863
    dw Data_02C_7888
    dw Data_02C_7946
    dw Data_02C_796A
    dw Data_02C_7BCB
    dw Data_02C_7BCB
    dw Data_02C_7BCB
    dw Data_02C_7C4A
    dw Data_02C_7CEA
    dw Data_02C_7D57
    dw Data_02C_7D77
    dw Data_02C_7DBF
    dw Data_02C_7EA5

Data_02C_4156:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0156, $6E

Data_02C_41C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B01C4, $7D

Data_02C_4241:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0241, $6D

Data_02C_42AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B02AE, $12D

Data_02C_43DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B03DB, $72

Data_02C_444D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B044D, $B3

Data_02C_4500:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0500, $68

Data_02C_4568:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0568, $90

Data_02C_45F8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B05F8, $57

Data_02C_464F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B064F, $96

Data_02C_46E5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B06E5, $8D

Data_02C_4772:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0772, $75

Data_02C_47E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B07E7, $ED

Data_02C_48D4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B08D4, $AF

Data_02C_4983:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $2A
    db $35, $24, $39, $28, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28, $90, $37, $32, $30
    db $25, $36, $37, $32, $31, $28, $90, $3A, $24, $36, $EF, $EE, $26, $32, $39, $28
    db $35, $28, $27, $90, $2C, $31, $90, $30, $32, $36, $36, $B5, $F7, $F0

Data_02C_49C1:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $32
    db $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $0A, $90, $33, $28, $26, $38, $2F, $2C
    db $24, $35, $90, $30, $28, $24, $37, $EF, $EE, $25, $35, $32, $37, $2B, $90, $3A
    db $24, $36, $90, $25, $32, $2C, $2F, $2C, $31, $2A, $B5, $F7, $F0

Data_02C_49FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B09FE, $86

Data_02C_4A84:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0A84, $75

Data_02C_4AF9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $14, $3A, $28, $28, $28, $28, $2B, $99, $F1, $F7, $F0

Data_02C_4B07:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0B07, $61

Data_02C_4B68:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0B68, $A6

Data_02C_4C0E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0C0E, $171

Data_02C_4D7F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0D7F, $AC

Data_02C_4E2B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0E2B, $43

Data_02C_4E6E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0E6E, $D5

Data_02C_4F43:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $2F, $98, $90, $20, $2C, $2F, $2F, $90, $3C, $32
    db $38, $F1, $2A, $32, $90, $2F, $32, $32, $2E, $90, $29, $32, $35, $90, $37, $2B
    db $28, $FA, $F7, $EF, $EE, $36, $37, $32, $2F, $28, $31, $90, $15, $2C, $2A, $2B
    db $37, $18, $35, $25, $EF, $EE, $29, $32, $35, $90, $30, $28, $98, $FF, $F0

Data_02C_4F82:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0F82, $5E

Data_02C_4FE0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B0FE0, $7F

Data_02C_505F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B105F, $5A

Data_02C_50B9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $30, $98, $90, $22, $32, $38, $40, $28, $90, $29, $35, $32
    db $30, $F1, $37, $2B, $28, $90, $39, $2C, $2F, $2F, $24, $2A, $28, $99, $FA, $F7
    db $EF, $EE, $11, $38, $35, $35, $3C, $90, $38, $33, $90, $24, $31, $27, $90, $2A
    db $32, $EF, $EE, $37, $2B, $35, $32, $38, $2A, $2B, $99, $F7, $F0

Data_02C_50F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B10F6, $44

Data_02C_513A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $17, $3C, $24, $98, $90, $1D, $35, $24, $39, $28, $2F, $28, $35
    db $36, $98, $F1, $1D, $2B, $24, $37, $3E, $90, $35, $24, $35, $28, $99, $F7, $F0

Data_02C_515A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B115A, $61

Data_02C_51BB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B11BB, $8F

Data_02C_524A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B124A, $8D

Data_02C_52D7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B12D7, $6B

Data_02C_5342:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1342, $74

Data_02C_53B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B13B6, $69

Data_02C_541F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $A4, $90, $0A, $35, $28, $90, $3C, $32, $38, $90
    db $24, $F1, $30, $32, $31, $36, $37, $28, $35, $98, $FF, $F0

Data_02C_543B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1E, $2B, $9C, $2B, $38, $2B, $A4, $90, $22, $32, $38, $90, $27
    db $32, $31, $41, $F1, $2F, $32, $32, $2E, $90, $39, $28, $35, $3C, $90, $36, $37
    db $35, $32, $31, $2A, $B5, $F7, $F0

Data_02C_5462:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1E, $2B, $9C, $2B, $38, $2B, $A4, $90, $22, $32, $38, $90, $2F
    db $32, $32, $2E, $F1, $38, $2B, $A4, $90, $27, $28, $2F, $2C, $26, $2C, $32, $38
    db $36, $B5, $F7, $F0

Data_02C_5486:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1486, $44

Data_02C_54CA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B14CA, $75

Data_02C_553F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B153F, $B1

Data_02C_55F0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B15F0, $B1

Data_02C_56A1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $32, $32, $27, $90, $27, $24, $3C, $B5, $90, $11, $32, $3A
    db $F1, $30, $24, $3C, $90, $12, $90, $2B, $28, $2F, $33, $90, $3C, $32, $38, $98
    db $F7, $F0

Data_02C_56C3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $32, $3A, $90, $30, $24, $3C, $90, $3A, $28, $90, $36, $28
    db $35, $39, $28, $F1, $3C, $32, $38, $35, $90, $30, $32, $35, $37, $24, $2F, $90
    db $36, $32, $38, $2F, $36, $98, $F7, $F0

Data_02C_56EB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B16EB, $43

Data_02C_572E:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $A4, $12, $37, $90
    db $24, $33, $33, $28, $24, $35, $28, $27, $90, $37, $32, $90, $25, $28, $EF, $EE
    db $30, $28, $35, $26, $2B, $24, $31, $27, $2C, $36, $28, $A4, $F7, $F0

Data_02C_576C:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $37, $35, $2C, $28, $27, $90, $37, $32, $F1, $32, $33, $28, $31
    db $90, $37, $2B, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7, $EF, $EE, $0B
    db $38, $37, $90, $37, $2B, $28, $90, $26, $2B, $28, $36, $37, $90, $3A, $24, $36
    db $EF, $EE, $2F, $32, $26, $2E, $28, $27, $B5, $F7, $F0

Data_02C_57A7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $90, $37, $32, $90, $37, $2B
    db $28, $F1, $37, $35, $24, $39, $28, $2F, $28, $35, $3E, $90, $2C, $31, $31, $B5
    db $F7, $F0

Data_02C_57C9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $14, $3A, $28, $28, $28, $28, $28, $2B, $99, $F1, $F7, $F0

Data_02C_57D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B17D8, $47

Data_02C_581F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B181F, $61

Data_02C_5880:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1880, $58

Data_02C_58D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B18D8, $48

Data_02C_5920:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1920, $87

Data_02C_59A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B19A7, $47

Data_02C_59EE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B19EE, $F8

Data_02C_5AE6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $A4, $90, $22, $32, $38, $90, $3A, $32, $31, $41, $F1
    db $2B, $38, $30, $32, $35, $90, $24, $31, $90, $32, $2F, $27, $90, $30, $24, $31
    db $A4, $F7, $F0

Data_02C_5B09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1B09, $6B

Data_02C_5B74:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1B74, $6B

Data_02C_5BDF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1BDF, $88

Data_02C_5C67:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1C67, $8B

Data_02C_5CF2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1CF2, $70

Data_02C_5D62:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1D62, $42

Data_02C_5DA4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $14, $2C, $31, $2A, $90, $2B, $24, $36, $F1
    db $33, $32, $36, $37, $28, $27, $90, $24, $90, $31, $32, $37, $2C, $26, $28, $B5
    db $FA, $F7, $EF, $EE, $1B, $28, $24, $27, $90, $37, $2B, $28, $90, $36, $2C, $2A
    db $31, $90, $32, $39, $28, $35, $EF, $EE, $37, $2B, $28, $35, $28, $B5, $F7, $F0

Data_02C_5DE4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1DE4, $69

Data_02C_5E4D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1E4D, $90

Data_02C_5EDD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1EDD, $FF

Data_02C_5FDC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B1FDC, $8D

Data_02C_6069:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2069, $45

Data_02C_60AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B20AE, $6D

Data_02C_611B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B211B, $4E

Data_02C_6169:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2169, $75

Data_02C_61DE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $99, $90, $11, $32, $3A, $90
    db $30, $24, $3C, $F1, $12, $90, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $98
    db $F7, $F0

Data_02C_6200:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $32, $3A, $90, $30, $24, $3C, $90, $32, $38, $35, $F1, $26
    db $2B, $38, $35, $26, $2B, $90, $2B, $28, $2F, $33, $90, $3C, $32, $38, $98, $F7
    db $F0

Data_02C_6221:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2221, $9C

Data_02C_62BD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B22BD, $C0

Data_02C_637D:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $32
    db $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $0B, $2C, $3D, $24, $35, $35, $28, $90
    db $25, $38, $2A, $36, $90, $3A, $28, $35, $28, $EF, $EE, $32, $31, $90, $36, $2E
    db $28, $3A, $28, $35, $36, $B5, $F7, $F0

Data_02C_63B5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B23B5, $69

Data_02C_641E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $90, $37, $32, $90, $32, $38
    db $35, $F1, $2C, $31, $31, $B5, $F7, $F0

Data_02C_6436:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2436, $67

Data_02C_649D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B249D, $44

Data_02C_64E1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B24E1, $6D

Data_02C_654E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B254E, $6A

Data_02C_65B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B25B8, $DC

Data_02C_6694:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2694, $8F

Data_02C_6723:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2723, $41

Data_02C_6764:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2764, $41

Data_02C_67A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B27A5, $41

Data_02C_67E6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B27E6, $8C

Data_02C_6872:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $38, $33, $90, $29, $32, $35, $90, $3C, $32, $38
    db $35, $F1, $26, $2B, $24, $2F, $2F, $28, $31, $2A, $28, $90, $24, $31, $3C, $37
    db $2C, $30, $28, $99, $F7, $F0

Data_02C_6898:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2898, $43

Data_02C_68DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B28DB, $47

Data_02C_6922:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $37, $28, $33, $90, $32, $31, $26, $28, $90, $32, $31, $F1
    db $28, $24, $26, $2B, $90, $32, $29, $90, $37, $2B, $28, $90, $37, $3A, $32, $FA
    db $F7, $EF, $EE, $29, $2F, $32, $32, $35, $90, $37, $2C, $2F, $28, $36, $90, $32
    db $31, $90, $37, $2B, $28, $EF, $EE, $35, $2C, $2A, $2B, $37, $B5, $F7, $F0

Data_02C_6961:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $31
    db $32, $37, $2C, $26, $28, $B5, $FA, $F7, $EF, $EE, $95, $15, $24, $3C, $90, $37
    db $2B, $28, $90, $36, $32, $38, $2F, $36, $90, $37, $32, $EF, $EE, $28, $37, $28
    db $35, $31, $24, $2F, $90, $35, $28, $36, $37, $B5, $95, $F7, $F0

Data_02C_699E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B299E, $5A

Data_02C_69F8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B29F8, $44

Data_02C_6A3C:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $27, $32, $32, $35, $90, $32, $33, $28, $31, $28, $27, $F1, $36, $32
    db $30, $28, $3A, $2B, $28, $35, $28, $A4, $F7, $F0

Data_02C_6A56:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2A56, $AE

Data_02C_6B04:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2B04, $8C

Data_02C_6B90:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $42, $28, $90, $25, $28, $24, $37, $28, $31, $90
    db $30, $28, $F1, $29, $24, $2C, $35, $2F, $3C, $A4, $FA, $F7, $EF, $EE, $1D, $24
    db $2E, $28, $90, $37, $2B, $28, $90, $37, $35, $28, $24, $36, $38, $35, $28, $A4
    db $EF, $EE, $0F, $24, $35, $28, $3A, $28, $2F, $2F, $A4, $F7, $F0

Data_02C_6BCD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2BCD, $52

Data_02C_6C1F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $14, $2C, $31, $2A, $3E, $90, $26, $24, $36
    db $37, $2F, $28, $F1, $2C, $36, $90, $35, $28, $24, $26, $2B, $28, $27, $90, $25
    db $3C, $90, $37, $2B, $28, $FA, $F7, $EF, $EE, $37, $35, $24, $39, $28, $2F, $28
    db $35, $3E, $90, $2A, $24, $37, $28, $EF, $EE, $2B, $28, $35, $28, $B5, $F7, $F0

Data_02C_6C5F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2C5F, $45

Data_02C_6CA4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2CA4, $46

Data_02C_6CEA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2CEA, $5F

Data_02C_6D49:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2D49, $69

Data_02C_6DB2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2DB2, $B8

Data_02C_6E6A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $30, $98, $90, $11, $32, $3A, $90, $27, $2C, $27, $90, $3C
    db $32, $38, $F1, $2A, $28, $37, $90, $2C, $31, $90, $2B, $28, $35, $28, $98, $F7
    db $F0

Data_02C_6E8B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2E8B, $EF

Data_02C_6F7A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B2F7A, $9A

Data_02C_7014:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B3014, $43

Data_02C_7057:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B3057, $83

Data_02C_70DA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B30DA, $42

Data_02C_711C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B311C, $43

Data_02C_715F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B315F, $6C

Data_02C_71CB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $24, $24, $2B, $99, $90, $22, $32, $38, $90, $29, $32, $38
    db $31, $27, $F1, $30, $28, $90, $3A, $2B, $2C, $2F, $28, $90, $12, $90, $3A, $24
    db $36, $FA, $F7, $EF, $EE, $36, $2F, $38, $29, $29, $2C, $31, $2A, $90, $32, $29
    db $29, $90, $29, $35, $32, $30, $EF, $EE, $3A, $32, $35, $2E, $A4, $F7, $F0

Data_02C_720A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B320A, $EE

Data_02C_72F8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B32F8, $45

Data_02C_733D:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1, $37
    db $2B, $28, $90, $11, $28, $24, $39, $28, $31, $90, $11, $28, $2F, $30, $28, $37
    db $B5, $F7, $F0

Data_02C_7360:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1, $37
    db $2B, $28, $90, $11, $28, $24, $39, $28, $31, $90, $0A, $35, $30, $32, $35, $B5
    db $F7, $F0

Data_02C_7382:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1, $37
    db $2B, $28, $90, $11, $28, $24, $39, $28, $31, $90, $1C, $3A, $32, $35, $27, $B5
    db $F7, $F0

Data_02C_73A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B33A4, $B3

Data_02C_7457:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B3457, $71

Data_02C_74C8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B34C8, $EC

Data_02C_75B4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B35B4, $1B1

Data_02C_7765:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B3765, $C7

Data_02C_782C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $20, $2B, $24, $9C, $3A, $2B, $24
    db $F1, $3A, $2B, $24, $24, $24, $24, $37, $98, $FA, $F7, $EF, $EE, $20, $2B, $24
    db $37, $90, $2D, $38, $36, $37, $90, $2B, $24, $33, $33, $28, $31, $28, $27, $EF
    db $EE, $31, $32, $3A, $98, $F7, $F0

Data_02C_7863:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $20, $2B, $32, $90, $24, $35, $28
    db $F1, $3C, $32, $38, $90, $37, $32, $90, $27, $2C, $36, $37, $38, $35, $25, $90
    db $30, $28, $98, $F7, $F0

Data_02C_7888:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B3888, $BE

Data_02C_7946:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $20, $2B, $24, $37, $98, $90, $20
    db $2B, $3C, $F1, $27, $32, $90, $3C, $32, $38, $90, $27, $32, $90, $37, $2B, $24
    db $37, $98, $F7, $F0

Data_02C_796A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B396A, $261

Data_02C_7BCB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B3BCB, $7F

Data_02C_7C4A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B3C4A, $A0

Data_02C_7CEA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B3CEA, $6D

Data_02C_7D57:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $15, $2C, $30, $25, $32, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_02C_7D77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B3D77, $48

Data_02C_7DBF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0B3DBF, $E6

Data_02C_7EA5:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $39, $32, $2C, $26, $28, $90, $28, $26, $2B, $32, $28, $27, $F1, $29
    db $35, $32, $30, $90, $31, $32, $3A, $2B, $28, $35, $28, $A4, $F7, $F0
    ds $13D, $00
