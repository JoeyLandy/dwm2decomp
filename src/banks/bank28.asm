SECTION "Bank 28", ROMX[$4000], BANK[$28]
    db $28

Func_028_4001::
    ld a, [$C529]
    cp a, $DA
    jr c, Jump_028_400F
    ld hl, $4001
    ld b, $97
    rst $10
    ret

Jump_028_400F::
    ld de, $4032
    call Func_000_25C9
    ret

Func_028_4016:: ; heuristic: follows a terminator; C0
    ld a, [$C529]
    cp a, $DA
    jr c, Jump_028_4024
    ld hl, $4010
    ld b, $97
    rst $10
    ret

Jump_028_4024::
    ld de, $4032
    call Func_000_25FE
    ret

Func_028_402B::
    call Func_028_4001
    call Func_000_2611
    ret
    db $34, $40
    dw Data_028_41E8
    dw Data_028_42A3
    dw Data_028_42E4
    dw Data_028_4347
    dw Data_028_437B
    dw Data_028_439E
    dw Data_028_4406
    dw Data_028_4471
    dw Data_028_44A1
    dw Data_028_44DB
    dw Data_028_4516
    dw Data_028_4582
    dw Data_028_46A4
    dw Data_028_47B9
    dw Data_028_4845
    dw Data_028_4887
    dw Data_028_48C7
    dw Data_028_4906
    dw Data_028_4940
    dw Data_028_495E
    dw Data_028_4999
    dw Data_028_49DE
    dw Data_028_4A3E
    dw Data_028_4AFE
    dw Data_028_4BB0
    dw Data_028_4BF2
    dw Data_028_4C38
    dw Data_028_4C7E
    dw Data_028_4CB5
    dw Data_028_4D10
    dw Data_028_4D49
    dw Data_028_4E09
    dw Data_028_4E2B
    dw Data_028_4E8D
    dw Data_028_4EAF
    dw Data_028_4F15
    dw Data_028_4F99
    dw Data_028_4FD5
    dw Data_028_5014
    dw Data_028_5049
    dw Data_028_5083
    dw Data_028_50E5
    dw Data_028_5128
    dw Data_028_51A5
    dw Data_028_51C8
    dw Data_028_520D
    dw Data_028_5232
    dw Data_028_524F
    dw Data_028_52BE
    dw Data_028_5308
    dw Data_028_531C
    dw Data_028_5378
    dw Data_028_53E0
    dw Data_028_541E
    dw Data_028_54A2
    dw Data_028_5578
    dw Data_028_55B9
    dw Data_028_55F8
    dw Data_028_5631
    dw Data_028_56B9
    dw Data_028_5727
    dw Data_028_5791
    dw Data_028_57ED
    dw Data_028_584D
    dw Data_028_58CC
    dw Data_028_5955
    dw Data_028_59C0
    dw Data_028_59ED
    dw Data_028_5A2F
    dw Data_028_5A72
    dw Data_028_5AFF
    dw Data_028_5B3E
    dw Data_028_5B9C
    dw Data_028_5BDF
    dw Data_028_5C02
    dw Data_028_5C39
    dw Data_028_5C7E
    dw Data_028_5CA3
    dw Data_028_5CC7
    dw Data_028_5D30
    dw Data_028_5D7A
    dw Data_028_5DBB
    dw Data_028_5DFD
    dw Data_028_5E36
    dw Data_028_5E56
    dw Data_028_5E99
    dw Data_028_5EDB
    dw Data_028_5EDB
    dw Data_028_5EDB
    dw Data_028_5EFD
    dw Data_028_5F43
    dw Data_028_5F66
    dw Data_028_5F8B
    dw Data_028_5FD0
    dw Data_028_6141
    dw Data_028_6163
    dw Data_028_61EC
    dw Data_028_6233
    dw Data_028_626F
    dw Data_028_62DF
    dw Data_028_6322
    dw Data_028_63AC
    dw Data_028_6414
    dw Data_028_645A
    dw Data_028_6495
    dw Data_028_64DF
    dw Data_028_6523
    dw Data_028_6552
    dw Data_028_65FA
    dw Data_028_6620
    dw Data_028_66BB
    dw Data_028_66FC
    dw Data_028_6774
    dw Data_028_67B6
    dw Data_028_67FC
    dw Data_028_686A
    dw Data_028_691E
    dw Data_028_6968
    dw Data_028_69D4
    dw Data_028_6A56
    dw Data_028_6AF5
    dw Data_028_6B33
    dw Data_028_6B79
    dw Data_028_6C73
    dw Data_028_6D24
    dw Data_028_6D46
    dw Data_028_6D92
    dw Data_028_6E04
    dw Data_028_6EE5
    dw Data_028_716B
    dw Data_028_718B
    dw Data_028_71AF
    dw Data_028_71D4
    dw Data_028_721C
    dw Data_028_723F
    dw Data_028_735A
    dw Data_028_73A1
    dw Data_028_73E9
    dw Data_028_747B
    dw Data_028_74C0
    dw Data_028_7510
    dw Data_028_75C8
    dw Data_028_7608
    dw Data_028_7670
    dw Data_028_7696
    dw Data_028_76BC
    dw Data_028_776A
    dw Data_028_77AD
    dw Data_028_780C
    dw Data_028_78CB
    dw Data_028_7913
    dw Data_028_795B
    dw Data_028_799C
    dw Data_028_79FB
    dw Data_028_7A3C
    dw Data_028_7A7B
    dw Data_028_7A7B
    dw Data_028_7A7B
    dw Data_028_7A7B
    dw Data_028_7A7B
    dw Data_028_7A7B
    dw Data_028_7AB2
    dw Data_028_7AE9
    dw Data_028_7B56
    dw Data_028_7B88
    dw Data_028_7BB9
    dw Data_028_7C21
    dw Data_028_7C55
    dw Data_028_7C88
    dw Data_028_7CF2
    dw Data_028_7D32
    dw Data_028_7D69
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DDF
    dw Data_028_7DFE
    dw Data_028_7E3D
    dw Data_028_7E84
    dw Data_028_7EA3
    dw Data_028_7EE1
    dw Data_028_7F06
    dw Data_028_7F4C
    dw Data_028_7F6F
    dw Data_028_7F97

Data_028_41E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A01E8, $BB

Data_028_42A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A02A3, $41

Data_028_42E4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A02E4, $63

Data_028_4347:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $32, $25, $2C, $A3, $90, $20, $2B, $24, $37, $3E, $90, $3A, $35, $32
    db $31, $2A, $AB, $F1, $F9, $00, $98, $FA, $F7, $EF, $EE, $19, $24, $33, $24, $3E
    db $90, $26, $24, $2F, $2F, $2C, $31, $2A, $90, $29, $32, $35, $EF, $EE, $3C, $32
    db $38, $99, $F7, $F0

Data_028_437B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $1D, $24, $35, $24, $A3, $90, $11, $38, $35, $35, $3C, $99, $90, $19, $24
    db $33, $24, $F1, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $24, $31, $2A, $35, $3C
    db $99, $F7, $F0

Data_028_439E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A039E, $68

Data_028_4406:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0406, $6B

Data_028_4471:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $24, $2C, $2F, $2C, $31, $2A, $90, $2C, $36, $90, $36, $38
    db $35, $28, $EF, $EE, $28, $3B, $2B, $2C, $2F, $24, $35, $24, $37, $2C, $31, $2A
    db $B5, $90, $FA, $F7, $EF, $EE, $1B, $2C, $2A, $2B, $37, $98, $EF, $EE, $FF, $F0

Data_028_44A1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $32, $32, $27, $B5, $90, $1D, $2B, $24, $37, $3E, $F1, $2A
    db $32, $32, $27, $90, $37, $32, $90, $2B, $28, $24, $35, $99, $FA, $F7, $EF, $EE
    db $22, $32, $38, $90, $2B, $24, $39, $28, $90, $2A, $32, $37, $EF, $EE, $33, $32
    db $37, $28, $31, $37, $2C, $24, $2F, $99, $F7, $F0

Data_028_44DB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $37, $2B, $24, $37, $90, $36, $32, $98, $F1, $1D
    db $32, $32, $90, $25, $24, $27, $99, $FA, $F7, $EF, $EE, $22, $32, $38, $43, $2F
    db $90, $2A, $28, $37, $90, $38, $36, $28, $27, $90, $37, $32, $EF, $EE, $2C, $37
    db $90, $36, $32, $30, $28, $27, $24, $3C, $B5, $F7, $F0

Data_028_4516:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0516, $6C

Data_028_4582:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0582, $122

Data_028_46A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A06A4, $115

Data_028_47B9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A07B9, $8C

Data_028_4845:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0845, $42

Data_028_4887:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $25, $24, $35, $35, $28, $2F, $B5, $FA, $F7, $EF, $EE, $12, $37
    db $90, $3A, $24, $36, $90, $29, $2C, $2F, $2F, $28, $27, $90, $3A, $2C, $37, $2B
    db $EF, $EE, $26, $2F, $28, $24, $31, $90, $3A, $24, $37, $28, $35, $B5, $F7, $F0

Data_028_48C7:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $0F, $35, $28, $36
    db $2B, $2F, $3C, $90, $26, $24, $38, $2A, $2B, $37, $EF, $EE, $29, $2C, $36, $2B
    db $90, $3A, $28, $35, $28, $90, $2C, $31, $36, $2C, $27, $28, $B5, $F7, $F0

Data_028_4906:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $32, $25, $2C, $A3, $90, $F9, $00, $99, $F1, $1D, $2B, $28, $3C, $90
    db $36, $24, $2C, $27, $90, $10, $35, $28, $24, $37, $15, $32, $2A, $FA, $F7, $EF
    db $EE, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $2C, $31, $90, $36, $2C, $2A, $2B
    db $37, $EF, $EE, $36, $32, $32, $31, $B5, $F7, $F0

Data_028_4940:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $24, $31, $27, $90, $2B, $32, $99, $F1, $1D, $2B, $28, $35
    db $28, $3E, $90, $10, $35, $28, $24, $37, $15, $32, $2A, $99, $F7, $F0

Data_028_495E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $1D, $24, $35, $24, $A3, $90, $0B, $2C, $2A, $90, $25, $35, $32, $37, $2B
    db $28, $35, $99, $F1, $FA, $F7, $EF, $EE, $F3, $10, $35, $28, $24, $37, $15, $32
    db $2A, $90, $3A, $2C, $2F, $2F, $90, $25, $28, $EF, $EE, $2C, $31, $90, $36, $2C
    db $2A, $2B, $37, $90, $36, $32, $32, $31, $B5, $F7, $F0

Data_028_4999:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0999, $45

Data_028_49DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A09DE, $60

Data_028_4A3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0A3E, $C0

Data_028_4AFE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0AFE, $B2

Data_028_4BB0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0BB0, $42

Data_028_4BF2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0BF2, $46

Data_028_4C38:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0C38, $46

Data_028_4C7E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $2B, $24, $3C, $90, $2C, $36, $F1, $33
    db $35, $28, $37, $37, $3C, $90, $2A, $32, $32, $27, $B5, $FA, $F7, $EF, $EE, $16
    db $24, $3C, $25, $28, $90, $12, $90, $26, $24, $31, $90, $38, $36, $28, $EF, $EE
    db $37, $2B, $2C, $36, $A4, $F7, $F0

Data_028_4CB5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0CB5, $5B

Data_028_4D10:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $25, $24, $35, $35, $28, $2F, $B5, $FA, $F7, $EF, $EE, $12, $37
    db $90, $2C, $36, $90, $29, $38, $2F, $2F, $90, $32, $29, $EF, $EE, $27, $35, $2C
    db $28, $27, $90, $2B, $24, $3C, $B5, $F7, $F0

Data_028_4D49:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0D49, $C0

Data_028_4E09:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $32, $25, $2C, $A3, $90, $1C, $38, $35, $28, $AB, $90, $16, $24, $30
    db $24, $99, $F1, $20, $28, $43, $2F, $90, $25, $28, $90, $29, $2C, $31, $28, $B5
    db $F7, $F0

Data_028_4E2B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0E2B, $62

Data_028_4E8D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $1D, $24, $35, $24, $A3, $90, $20, $28, $43, $2F, $90, $25, $28, $90, $18
    db $14, $99, $F1, $12, $3F, $90, $2A, $32, $2C, $31, $2A, $90, $37, $32, $32, $B5
    db $F7, $F0

Data_028_4EAF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0EAF, $66

Data_028_4F15:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A0F15, $84

Data_028_4F99:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $27
    db $35, $28, $36, $36, $28, $35, $B5, $FA, $F7, $EF, $EE, $0C, $2B, $2C, $2F, $27
    db $35, $28, $31, $3E, $90, $26, $2F, $32, $37, $2B, $28, $36, $EF, $EE, $3A, $28
    db $35, $28, $90, $2C, $31, $36, $2C, $27, $28, $B5, $F7, $F0

Data_028_4FD5:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $27
    db $35, $28, $36, $36, $28, $35, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $36, $30
    db $28, $2F, $2F, $28, $27, $90, $32, $29, $90, $36, $38, $31, $9C, $EF, $EE, $27
    db $35, $2C, $28, $27, $90, $2F, $24, $38, $31, $27, $35, $3C, $B5, $F7, $F0

Data_028_5014:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $32
    db $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $36, $30, $28, $2F, $2F
    db $28, $27, $90, $32, $29, $EF, $EE, $29, $35, $28, $36, $2B, $90, $25, $35, $28
    db $24, $27, $B5, $F7, $F0

Data_028_5049:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $3A
    db $24, $36, $90, $29, $38, $2F, $2F, $90, $32, $29, $EF, $EE, $26, $2F, $28, $24
    db $35, $90, $3A, $24, $37, $28, $35, $B5, $F7, $F0

Data_028_5083:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1083, $62

Data_028_50E5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A10E5, $43

Data_028_5128:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1128, $7D

Data_028_51A5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $32, $25, $2C, $A3, $90, $11, $24, $2B, $24, $2B, $99, $90, $F9, $00
    db $F1, $3A, $32, $31, $41, $90, $2F, $24, $36, $37, $90, $24, $90, $27, $24, $3C
    db $99, $F7, $F0

Data_028_51C8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A11C8, $45

Data_028_520D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $1D, $24, $35, $24, $A3, $90, $0B, $2C, $2A, $90, $25, $35, $32, $37, $2B
    db $28, $35, $F1, $26, $24, $31, $41, $90, $27, $32, $90, $2C, $37, $90, $37, $2B
    db $28, $31, $B5, $F7, $F0

Data_028_5232:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $32, $90, $2B, $28, $2F, $33, $90, $3C, $32, $38, $35, $F1
    db $30, $32, $37, $2B, $28, $35, $90, $31, $32, $3A, $B5, $F7, $F0

Data_028_524F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A124F, $6F

Data_028_52BE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A12BE, $4A

Data_028_5308:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0C, $3F, $32, $31, $AB, $90, $20, $24, $35, $38, $25, $32, $38
    db $99, $F1, $F7, $F0

Data_028_531C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A131C, $5C

Data_028_5378:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1378, $68

Data_028_53E0:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $28, $90, $2B, $32, $35, $35, $2C, $27, $F1, $19, $35
    db $2C, $31, $26, $28, $90, $24, $31, $27, $90, $37, $2B, $24, $37, $FA, $F7, $EF
    db $EE, $28, $2F, $28, $30, $28, $31, $37, $24, $2F, $90, $36, $2C, $27, $28, $2E
    db $2C, $26, $2E, $EF, $EE, $32, $29, $90, $2B, $2C, $36, $99, $F7, $F0

Data_028_541E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A141E, $84

Data_028_54A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A14A2, $D6

Data_028_5578:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1578, $41

Data_028_55B9:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $0A, $90, $2F, $24
    db $35, $2A, $28, $AB, $90, $36, $24, $2F, $37, $28, $27, $EF, $EE, $29, $2C, $36
    db $2B, $90, $3A, $24, $36, $90, $2C, $31, $36, $2C, $27, $28, $B5, $F7, $F0

Data_028_55F8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $3C, $99, $90, $22, $32, $38, $90, $25, $35, $24, $37
    db $36, $99, $F1, $1C, $26, $35, $24, $30, $99, $FA, $F7, $EF, $EE, $11, $24, $31
    db $27, $36, $90, $32, $29, $29, $90, $30, $3C, $EF, $EE, $30, $28, $35, $26, $2B
    db $24, $31, $27, $2C, $36, $28, $99, $F7, $F0

Data_028_5631:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1631, $88

Data_028_56B9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A16B9, $6E

Data_028_5727:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1727, $6A

Data_028_5791:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1791, $5C

Data_028_57ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A17ED, $60

Data_028_584D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A184D, $7F

Data_028_58CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A18CC, $89

Data_028_5955:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1955, $6B

Data_028_59C0:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $24, $27, $90, $37, $2B, $28, $F1, $36, $2C, $2A, $31
    db $B5, $FA, $F7, $EF, $EE, $95, $0D, $24, $31, $2A, $28, $35, $99, $EF, $EE, $1C
    db $37, $24, $3C, $90, $26, $2F, $28, $24, $35, $99, $95, $F7, $F0

Data_028_59ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A19ED, $42

Data_028_5A2F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1A2F, $43

Data_028_5A72:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1A72, $8D

Data_028_5AFF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $31, $2E, $36, $90, $29, $32, $35, $F1, $26, $32
    db $30, $2C, $31, $2A, $90, $25, $3C, $B5, $FA, $F7, $EF, $EE, $12, $43, $2F, $90
    db $24, $2F, $3A, $24, $3C, $36, $90, $25, $28, $EF, $EE, $2B, $28, $35, $28, $90
    db $37, $32, $90, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $99, $F7, $F0

Data_028_5B3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1B3E, $5E

Data_028_5B9C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1B9C, $43

Data_028_5BDF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $20, $24, $2B, $24, $2B, $24, $2B
    db $99, $F1, $17, $32, $90, $2A, $32, $2C, $31, $2A, $90, $25, $3C, $90, $30, $28
    db $99, $F7, $F0

Data_028_5C02:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $20, $24, $35, $38, $25, $32, $38, $AB, $F1, $10
    db $35, $28, $24, $37, $15, $32, $2A, $3E, $90, $36, $33, $2C, $35, $2C, $37, $99
    db $FA, $F7, $EF, $EE, $20, $24, $35, $32, $32, $2B, $AB, $90, $3A, $24, $9C, $2B
    db $28, $3C, $99, $EF, $EE, $F7, $F0

Data_028_5C39:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1C39, $45

Data_028_5C7E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $24, $39, $28, $90, $3C, $32, $38, $90, $2B, $28, $24, $35
    db $27, $F1, $24, $25, $32, $38, $37, $90, $16, $24, $2A, $2C, $26, $90, $14, $28
    db $3C, $36, $98, $FF, $F0

Data_028_5CA3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $32, $3A, $AB, $90, $3C, $32, $38, $90, $2E, $2C, $27, $36
    db $F1, $36, $38, $35, $28, $90, $2F, $28, $24, $35, $31, $90, $34, $38, $2C, $26
    db $2E, $99, $F7, $F0

Data_028_5CC7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1CC7, $69

Data_028_5D30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1D30, $4A

Data_028_5D7A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1D7A, $41

Data_028_5DBB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1DBB, $42

Data_028_5DFD:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $90, $30, $3C, $AB, $90, $37, $2B, $28, $90, $3A, $28
    db $2F, $2F, $F1, $2C, $36, $31, $41, $90, $36, $24, $29, $28, $99, $FA, $F7, $EF
    db $EE, $0D, $32, $31, $41, $90, $25, $28, $90, $2F, $2C, $2E, $28, $EF, $EE, $20
    db $24, $35, $38, $25, $32, $38, $99, $F7, $F0

Data_028_5E36:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $20, $24, $9C, $2B, $28, $3C
    db $99, $F1, $12, $3F, $90, $36, $37, $24, $35, $39, $2C, $31, $2A, $99, $F7, $F0

Data_028_5E56:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1E56, $43

Data_028_5E99:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1E99, $42

Data_028_5EDB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $32, $25, $2C, $A3, $90, $1D, $2B, $24, $37, $3E, $90, $32, $38, $35
    db $36, $99, $F1, $10, $2C, $39, $28, $90, $2C, $37, $90, $25, $24, $26, $2E, $99
    db $F7, $F0

Data_028_5EFD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1EFD, $46

Data_028_5F43:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $12, $A4, $90, $12, $37, $A4, $F1
    db $12, $37, $3E, $90, $31, $32, $37, $90, $30, $3C, $90, $29, $24, $38, $2F, $37
    db $99, $F7, $F0

Data_028_5F66:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $20, $24, $9C, $2B, $28, $3C
    db $99, $F1, $12, $37, $3E, $90, $37, $2B, $28, $90, $32, $31, $2F, $3C, $90, $3A
    db $24, $3C, $99, $F7, $F0

Data_028_5F8B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1F8B, $45

Data_028_5FD0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A1FD0, $171

Data_028_6141:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $1D, $24, $35, $24, $A3, $90, $1D, $2B, $24, $37, $3E, $90, $32, $38, $35
    db $36, $99, $F1, $10, $2C, $39, $28, $90, $2C, $37, $90, $25, $24, $26, $2E, $99
    db $F7, $F0

Data_028_6163:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2163, $89

Data_028_61EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A21EC, $47

Data_028_6233:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $32, $25, $2C, $A3, $90, $20, $2B, $3C, $90, $3A, $32, $31, $41, $90
    db $3C, $32, $38, $F1, $25, $28, $2F, $2C, $28, $39, $28, $90, $38, $36, $98, $FA
    db $F7, $EF, $EE, $22, $32, $38, $90, $36, $37, $38, $25, $25, $32, $35, $31, $90
    db $32, $2F, $27, $EF, $EE, $2A, $32, $24, $37, $99, $F7, $F0

Data_028_626F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A226F, $70

Data_028_62DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A22DF, $43

Data_028_6322:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2322, $8A

Data_028_63AC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A23AC, $68

Data_028_6414:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2414, $46

Data_028_645A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $40, $28, $90, $2A, $32, $2C, $31, $2A, $90, $37, $32
    db $F1, $36, $2C, $31, $2E, $98, $FA, $F7, $EF, $EE, $12, $90, $26, $24, $31, $41
    db $90, $36, $3A, $2C, $30, $99, $EF, $EE, $20, $2B, $24, $37, $90, $36, $2B, $32
    db $38, $2F, $27, $90, $12, $90, $27, $32, $98, $F7, $F0

Data_028_6495:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2495, $4A

Data_028_64DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A24DF, $44

Data_028_6523:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0D, $2C, $27, $90, $3C, $32, $38, $90, $2A, $28, $37, $F1, $37
    db $2B, $28, $90, $33, $24, $26, $2E, $24, $2A, $28, $FA, $F7, $EF, $EE, $29, $35
    db $32, $30, $90, $2A, $35, $24, $31, $27, $30, $24, $98, $EF, $EE, $F7, $F0

Data_028_6552:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2552, $A8

Data_028_65FA:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $22, $32, $38, $90, $26, $24, $31, $90, $2A, $32, $90, $32, $38
    db $37, $AB, $F1, $25, $38, $37, $90, $31, $32, $37, $90, $37, $32, $32, $90, $2F
    db $24, $37, $28, $99, $F7, $F0

Data_028_6620:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2620, $9B

Data_028_66BB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A26BB, $41

Data_028_66FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A26FC, $78

Data_028_6774:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2774, $42

Data_028_67B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A27B6, $46

Data_028_67FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A27FC, $6E

Data_028_686A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A286A, $B4

Data_028_691E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A291E, $4A

Data_028_6968:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2968, $6C

Data_028_69D4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A29D4, $82

Data_028_6A56:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2A56, $9F

Data_028_6AF5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $3E, $90, $33, $32, $2C, $31, $37, $2F, $28, $36, $36
    db $F1, $2C, $29, $90, $3C, $32, $38, $40, $28, $90, $27, $28, $24, $27, $B5, $FA
    db $F7, $EF, $EE, $12, $3F, $90, $2A, $32, $2C, $31, $2A, $90, $37, $32, $90, $2F
    db $28, $24, $39, $28, $EF, $EE, $24, $2A, $24, $2C, $31, $B5, $F7, $F0

Data_028_6B33:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2B33, $46

Data_028_6B79:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2B79, $FA

Data_028_6C73:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2C73, $B1

Data_028_6D24:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $17, $32, $98, $F1, $1D, $2B
    db $28, $31, $90, $29, $2C, $31, $27, $90, $36, $32, $30, $28, $32, $31, $28, $99
    db $F7, $F0

Data_028_6D46:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2D46, $4C

Data_028_6D92:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2D92, $72

Data_028_6E04:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2E04, $E1

Data_028_6EE5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A2EE5, $286

Data_028_716B:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $18, $24, $36, $2C, $36, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_028_718B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $20, $24, $9C, $2B, $28, $3C
    db $99, $F1, $12, $90, $37, $35, $38, $36, $37, $90, $3C, $32, $38, $99, $90, $10
    db $32, $99, $F7, $F0

Data_028_71AF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $20, $24, $9C, $2B, $28, $3C
    db $99, $F1, $0F, $32, $35, $2A, $32, $37, $90, $36, $32, $30, $28, $37, $2B, $2C
    db $31, $2A, $99, $F7, $F0

Data_028_71D4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A31D4, $48

Data_028_721C:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $10, $35, $28, $24, $37, $15, $32, $2A, $90, $14, $28, $3C, $B5, $E5, $58, $F7
    db $E9, $FF, $F0

Data_028_723F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A323F, $11B

Data_028_735A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A335A, $47

Data_028_73A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A33A1, $48

Data_028_73E9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A33E9, $92

Data_028_747B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A347B, $45

Data_028_74C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A34C0, $50

Data_028_7510:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A3510, $B8

Data_028_75C8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $32, $25, $2C, $A3, $90, $1D, $2B, $24, $37, $3E, $90, $37, $35, $38
    db $28, $B5, $F1, $20, $2B, $24, $37, $90, $37, $32, $90, $27, $32, $A4, $FA, $F7
    db $EF, $EE, $11, $38, $2B, $98, $90, $F9, $00, $98, $EF, $EE, $0D, $32, $90, $3C
    db $32, $38, $90, $3A, $24, $31, $37, $90, $37, $32, $90, $2A, $32, $98, $FF, $F0

Data_028_7608:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A3608, $68

Data_028_7670:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $32, $25, $2C, $A3, $90, $0F, $2C, $31, $28, $B5, $90, $0B, $38, $37
    db $F1, $F9, $00, $AB, $90, $25, $3C, $FA, $F7, $EF, $EE, $3C, $32, $38, $35, $36
    db $28, $2F, $29, $A4, $F7, $F0

Data_028_7696:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $1C, $2F, $24, $36, $2B, $A3, $90, $0D, $32, $31, $41, $90, $3A, $32, $35
    db $35, $3C, $99, $F1, $12, $3F, $90, $35, $2C, $27, $2C, $31, $2A, $90, $24, $2F
    db $32, $31, $2A, $99, $F7, $F0

Data_028_76BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A36BC, $AE

Data_028_776A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A376A, $43

Data_028_77AD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A37AD, $5F

Data_028_780C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A380C, $BF

Data_028_78CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A38CB, $48

Data_028_7913:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A3913, $48

Data_028_795B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A395B, $41

Data_028_799C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A399C, $5F

Data_028_79FB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A39FB, $41

Data_028_7A3C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $1D, $24, $35, $24, $A3, $90, $1D, $2B, $28, $31, $90, $2C, $37, $3E, $F1
    db $3C, $32, $38, $35, $90, $2D, $32, $25, $AB, $90, $F9, $00, $99, $FA, $F7, $EF
    db $EE, $16, $24, $2E, $28, $90, $30, $28, $90, $33, $35, $32, $38, $27, $AB, $90
    db $25, $2C, $2A, $EF, $EE, $25, $35, $32, $37, $2B, $28, $35, $99, $F7, $F0

Data_028_7A7B:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $33, $28, $31, $28, $27, $90, $37, $2B, $28, $F1, $37, $35
    db $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7, $EF
    db $EE, $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28
    db $EF, $EE, $F9, $22, $B5, $F7, $F0

Data_028_7AB2:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $EF, $EE, $0B, $38, $37, $90, $2C, $37, $90, $3A, $24, $36, $90, $28, $30, $33
    db $37, $3C, $A4, $EF, $EE, $F7, $F0

Data_028_7AE9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A3AE9, $6D

Data_028_7B56:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $F9, $00, $90, $32
    db $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28, $EF, $EE, $F9, $22, $B5
    db $F7, $F0

Data_028_7B88:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $0B, $38, $37, $90
    db $2C, $37, $90, $3A, $24, $36, $90, $28, $30, $33, $37, $3C, $B5, $EF, $EE, $F7
    db $F0

Data_028_7BB9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A3BB9, $68

Data_028_7C21:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $25, $24, $35, $35, $28, $2F, $B5, $FA, $F7, $EF, $EE, $F9, $00
    db $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28, $EF, $EE, $F9
    db $22, $B5, $F7, $F0

Data_028_7C55:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $25, $24, $35, $35, $28, $2F, $B5, $FA, $F7, $EF, $EE, $0B, $38
    db $37, $90, $2C, $37, $90, $3A, $24, $36, $90, $28, $30, $33, $37, $3C, $B5, $EF
    db $EE, $F7, $F0

Data_028_7C88:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A3C88, $6A

Data_028_7CF2:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $33, $28, $31, $28, $27, $90, $37, $2B, $28, $F1, $37, $35
    db $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7, $EF
    db $EE, $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $24, $EF, $EE
    db $16, $24, $2A, $2C, $26, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_028_7D32:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $EF, $EE, $0B, $38, $37, $90, $2C, $37, $90, $3A, $24, $36, $90, $28, $30, $33
    db $37, $3C, $A4, $EF, $EE, $F7, $F0

Data_028_7D69:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A3D69, $76

Data_028_7DDF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $28, $37, $3E, $90, $36, $28, $28, $90, $2B, $32, $3A, $F1
    db $2A, $32, $32, $27, $90, $3C, $32, $38, $90, $24, $35, $28, $99, $F7, $F0

Data_028_7DFE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $37, $2B, $2C, $31, $2E, $90, $3C, $32, $38
    db $F1, $26, $32, $38, $2F, $27, $90, $3A, $2C, $31, $98, $FA, $F7, $EF, $EE, $0D
    db $35, $28, $24, $30, $90, $32, $31, $AB, $90, $3C, $32, $38, $EF, $EE, $2C, $31
    db $36, $32, $2F, $28, $31, $37, $90, $29, $32, $32, $2F, $36, $99, $F7, $F0

Data_028_7E3D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A3E3D, $47

Data_028_7E84:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $35, $28, $33, $24, $35, $28, $90, $37, $32, $90, $25, $28
    db $F1, $32, $39, $28, $35, $3A, $2B, $28, $2F, $30, $28, $27, $99, $F7, $F0

Data_028_7EA3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $32, $36, $28, $90, $30, $32, $31, $36, $37, $28, $35
    db $36, $F1, $24, $35, $28, $90, $30, $3C, $90, $29, $32, $28, $36, $98, $FA, $F7
    db $EF, $EE, $0F, $3A, $24, $2B, $24, $2B, $24, $2B, $24, $99, $EF, $EE, $11, $32
    db $3A, $90, $2F, $38, $27, $2C, $26, $35, $32, $38, $36, $99, $F7, $F0

Data_028_7EE1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $29, $90, $3C, $32, $38, $90, $3A, $2C, $31, $AB, $90, $3C
    db $32, $38, $F1, $26, $24, $31, $90, $25, $28, $90, $37, $2B, $28, $90, $25, $32
    db $36, $36, $99, $F7, $F0

Data_028_7F06:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A3F06, $46

Data_028_7F4C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $30, $98, $90, $16, $3C, $90, $35, $2C, $39, $24, $2F, $90
    db $2C, $36, $F1, $2B, $28, $35, $28, $98, $90, $0C, $32, $30, $28, $90, $32, $31
    db $99, $F7, $F0

Data_028_7F6F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0F, $2C, $31, $24, $2F, $2F, $3C, $AB, $90, $36, $32, $30, $28
    db $32, $31, $28, $F1, $37, $32, $90, $2C, $2A, $31, $2C, $37, $28, $90, $30, $3C
    db $90, $36, $32, $38, $2F, $99, $F7, $F0

Data_028_7F97:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $29, $28, $28, $2F, $90, $3C, $32, $38, $35, $F1, $36
    db $37, $35, $28, $31, $2A, $37, $2B, $A4, $FA, $F7, $EF, $EE, $1D, $2B, $2C, $36
    db $90, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $24, $EF, $EE, $2F, $32, $31, $2A
    db $90, $25, $24, $37, $37, $2F, $28, $B5, $F7, $F0
    ds $2F, $00
