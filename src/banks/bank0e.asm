SECTION "Bank 0E", ROMX[$4000], BANK[$0E]
    db $0E

Func_00E_4001::
    ld a, [$C529]
    cp a, $88
    jr c, Jump_00E_400F
    ld hl, Func_096_7011
    ld b, $96
    rst $10
    ret

Jump_00E_400F::
    ld de, Data_00E_4032
    call Func_000_25C9
    ret

Func_00E_4016:: ; heuristic: follows a terminator; C0
    ld a, [$C529]
    cp a, $88
    jr c, Jump_00E_4024
    ld hl, Func_096_7020
    ld b, $96
    rst $10
    ret

Jump_00E_4024::
    ld de, Data_00E_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_00E_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00E_4034

Data_00E_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4144
    dw Data_00E_4167
    dw Data_00E_4188
    dw Data_00E_4188
    dw Data_00E_4188
    dw Data_00E_4188
    dw Data_00E_4188
    dw Data_00E_4188
    dw Data_00E_41A6
    dw Data_00E_41CA
    dw Data_00E_4206
    dw Data_00E_4217
    dw Data_00E_4237
    dw Data_00E_425E
    dw Data_00E_429E
    dw Data_00E_42B9
    dw Data_00E_4304
    dw Data_00E_4342
    dw Data_00E_4369
    dw Data_00E_4369
    dw Data_00E_4369
    dw Data_00E_4369
    dw Data_00E_4369
    dw Data_00E_4369
    dw Data_00E_43AD
    dw Data_00E_43D4
    dw Data_00E_441B
    dw Data_00E_443C
    dw Data_00E_447C
    dw Data_00E_449D
    dw Data_00E_450D
    dw Data_00E_452F
    dw Data_00E_45A8
    dw Data_00E_45DF
    dw Data_00E_4602
    dw Data_00E_4602
    dw Data_00E_4602
    dw Data_00E_4602
    dw Data_00E_4602
    dw Data_00E_4602
    dw Data_00E_4640
    dw Data_00E_4663
    dw Data_00E_46AF
    dw Data_00E_46D0
    dw Data_00E_4719
    dw Data_00E_473E
    dw Data_00E_47A7
    dw Data_00E_47C3
    dw Data_00E_480B
    dw Data_00E_4841
    dw Data_00E_4864
    dw Data_00E_4864
    dw Data_00E_4864
    dw Data_00E_4864
    dw Data_00E_4864
    dw Data_00E_4864
    dw Data_00E_4882
    dw Data_00E_48BF
    dw Data_00E_48E4
    dw Data_00E_4903
    dw Data_00E_4946
    dw Data_00E_4968
    dw Data_00E_49D1
    dw Data_00E_49F4
    dw Data_00E_4A34
    dw Data_00E_4A6F
    dw Data_00E_4A92
    dw Data_00E_4A92
    dw Data_00E_4A92
    dw Data_00E_4A92
    dw Data_00E_4A92
    dw Data_00E_4A92
    dw Data_00E_4ADB
    dw Data_00E_4B00
    dw Data_00E_4B4F
    dw Data_00E_4B6F
    dw Data_00E_4B96
    dw Data_00E_4BB8
    dw Data_00E_4C28
    dw Data_00E_4C4C
    dw Data_00E_4CB8
    dw Data_00E_4CEF
    dw Data_00E_4D16
    dw Data_00E_4D16
    dw Data_00E_4D16
    dw Data_00E_4D16
    dw Data_00E_4D16
    dw Data_00E_4D16
    dw Data_00E_4D61
    dw Data_00E_4D85
    dw Data_00E_4DCE
    dw Data_00E_4DEF
    dw Data_00E_4E33
    dw Data_00E_4E58
    dw Data_00E_4EC8
    dw Data_00E_4EE5
    dw Data_00E_4F76
    dw Data_00E_4FBD
    dw Data_00E_4FE4
    dw Data_00E_4FE4
    dw Data_00E_4FE4
    dw Data_00E_4FE4
    dw Data_00E_4FE4
    dw Data_00E_4FE4
    dw Data_00E_5026
    dw Data_00E_5049
    dw Data_00E_508B
    dw Data_00E_50AB
    dw Data_00E_50CE
    dw Data_00E_50ED
    dw Data_00E_5159
    dw Data_00E_517A
    dw Data_00E_520A
    dw Data_00E_5243
    dw Data_00E_526A
    dw Data_00E_526A
    dw Data_00E_526A
    dw Data_00E_526A
    dw Data_00E_526A
    dw Data_00E_526A
    dw Data_00E_52A6
    dw Data_00E_52CB
    dw Data_00E_530F
    dw Data_00E_532E
    dw Data_00E_5350

Data_00E_4144:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $36, $90, $24, $26, $26, $28, $36, $36, $32, $35, $3C
    db $90, $2C, $36, $F1, $2C, $31, $90, $37, $2B, $28, $90, $1F, $24, $38, $2F, $37
    db $B5, $F7, $F0

Data_00E_4167:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $2C, $37, $90, $18, $14, $90, $37, $32, $90, $36
    db $24, $39, $28, $F1, $37, $2B, $28, $90, $35, $28, $36, $38, $2F, $37, $36, $98
    db $F0

Data_00E_4188:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $32, $32, $90, $25, $24, $27, $A4, $90, $15, $28, $37, $3E
    db $F1, $30, $28, $28, $37, $90, $24, $2A, $24, $2C, $31, $B5, $F7, $F0

Data_00E_41A6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $32, $90, $3A, $2C, $2F, $2F, $90, $25, $35, $28, $28
    db $27, $F1, $3A, $2C, $37, $2B, $90, $30, $3C, $90, $1C, $33, $2C, $2E, $3C, $0B
    db $32, $3C, $98, $F0

Data_00E_41CA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $32, $38, $2F, $27, $90, $3C, $32, $38, $90, $2F, $2C, $2E
    db $28, $F1, $37, $32, $90, $25, $35, $28, $28, $27, $90, $24, $90, $30, $32, $31
    db $36, $37, $28, $35, $FA, $F7, $EF, $EE, $3A, $2C, $37, $2B, $90, $30, $3C, $90
    db $1C, $33, $2C, $2E, $3C, $0B, $32, $3C, $98, $EF, $EE, $F0

Data_00E_4206:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $30, $32, $31, $36, $37, $28, $35, $98
    db $F0

Data_00E_4217:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $90, $2F, $32, $3A, $9C, $2F, $28, $39, $28, $2F, $90, $32
    db $31, $28, $F1, $26, $24, $31, $41, $90, $25, $35, $28, $28, $27, $B5, $F7, $F0

Data_00E_4237:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $35, $90, $33, $24, $35, $37, $3C, $90, $3A, $32
    db $31, $41, $F1, $2B, $24, $39, $28, $90, $24, $31, $3C, $90, $30, $32, $31, $36
    db $37, $28, $35, $36, $B5, $F7, $F0

Data_00E_425E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $32, $30, $28, $37, $2B, $2C, $31, $2A, $90, $2B, $38, $2A
    db $28, $F1, $3A, $2C, $2F, $2F, $90, $35, $28, $36, $38, $2F, $37, $A4, $FA, $F7
    db $EF, $EE, $1C, $2B, $24, $2F, $2F, $90, $3A, $28, $90, $25, $28, $2A, $2C, $31
    db $90, $37, $2B, $28, $EF, $EE, $25, $35, $28, $28, $27, $2C, $31, $2A, $98, $F0

Data_00E_429E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $28, $37, $3E, $90, $2A, $28, $37, $90, $37, $2B, $2C, $36
    db $F1, $36, $37, $24, $35, $37, $28, $27, $99, $F7, $F0

Data_00E_42B9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0382B9, $4B

Data_00E_4304:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $F1, $3A, $2C, $2F, $2F, $90, $35, $28, $36, $38, $2F
    db $37, $AB, $FA, $F7, $EF, $EE, $12, $90, $37, $2B, $2C, $31, $2E, $B5, $EF, $EE
    db $FA, $F7, $EF, $EE, $F3, $1C, $2B, $24, $2F, $2F, $90, $3A, $28, $90, $25, $28
    db $2A, $2C, $31, $F1, $25, $35, $28, $28, $27, $2C, $31, $2A, $98, $F0

Data_00E_4342:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $36, $90, $24, $26, $26, $28, $36, $36, $32, $35, $3C
    db $90, $2C, $36, $F1, $31, $32, $3A, $90, $2C, $31, $90, $37, $2B, $28, $90, $1F
    db $24, $38, $2F, $37, $B5, $F7, $F0

Data_00E_4369:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038369, $44

Data_00E_43AD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $2C, $26, $2B, $90, $32, $31, $28, $3E, $90, $2A, $32
    db $2C, $31, $2A, $F1, $3A, $2C, $37, $2B, $90, $30, $3C, $90, $0A, $35, $30, $32
    db $35, $19, $28, $27, $28, $98, $F0

Data_00E_43D4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0383D4, $47

Data_00E_441B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $37, $2B, $2C, $36, $90, $37, $2B, $28, $90, $32
    db $31, $28, $F1, $29, $32, $35, $90, $25, $35, $28, $28, $27, $2C, $31, $2A, $98
    db $F0

Data_00E_443C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0D, $32, $31, $41, $90, $36, $37, $2C, $26, $2E, $90, $30, $28
    db $F1, $3A, $2C, $37, $2B, $90, $24, $90, $2F, $32, $3A, $9C, $2F, $28, $39, $28
    db $2F, $FA, $F7, $EF, $EE, $30, $32, $31, $36, $37, $28, $35, $99, $EF, $EE, $1D
    db $2B, $24, $37, $3E, $90, $31, $32, $37, $90, $29, $24, $2C, $35, $99, $F7, $F0

Data_00E_447C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $32, $3E, $90, $2A, $32, $2C, $31, $2A, $90, $37, $32
    db $F1, $36, $37, $24, $3C, $90, $3A, $2C, $37, $2B, $90, $3C, $32, $38, $98, $F7
    db $F0

Data_00E_449D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03849D, $70

Data_00E_450D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $35, $28, $24, $37, $AB, $90, $2F, $28, $37, $3E, $90, $2A
    db $28, $37, $F1, $37, $2B, $2C, $36, $90, $36, $37, $24, $35, $37, $28, $27, $B5
    db $F7, $F0

Data_00E_452F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03852F, $79

Data_00E_45A8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $90, $2C, $36, $F1, $3A, $2B, $24, $37, $90, $3C, $32
    db $38, $43, $2F, $90, $2A, $28, $37, $B5, $FA, $F7, $EF, $EE, $0C, $24, $31, $90
    db $3A, $28, $90, $2A, $28, $37, $90, $2A, $32, $2C, $31, $2A, $EF, $EE, $24, $2F
    db $35, $28, $24, $27, $3C, $98, $F0

Data_00E_45DF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $36, $90, $24, $26, $26, $28, $36, $36, $32, $35, $3C
    db $90, $2C, $36, $F1, $2C, $31, $90, $37, $2B, $28, $90, $1F, $24, $38, $2F, $37
    db $B5, $F7, $F0

Data_00E_4602:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $30, $A4, $90, $1D, $2B, $24, $37, $90, $2C, $36, $F1, $27
    db $2C, $36, $24, $33, $33, $32, $2C, $31, $37, $2C, $31, $2A, $B5, $FA, $F7, $EF
    db $EE, $12, $90, $2B, $32, $33, $28, $90, $3A, $28, $90, $3A, $2C, $2F, $2F, $EF
    db $EE, $30, $28, $28, $37, $90, $24, $2A, $24, $2C, $31, $B5, $F7, $F0

Data_00E_4640:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $2C, $26, $2B, $90, $3A, $2C, $2F, $2F, $90, $25, $28
    db $90, $30, $3C, $F1, $10, $38, $2F, $33, $33, $2F, $28, $3E, $90, $30, $24, $37
    db $28, $98, $F0

Data_00E_4663:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038663, $4C

Data_00E_46AF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $37, $2B, $2C, $36, $90, $3C, $32, $38, $35, $F1
    db $25, $35, $28, $28, $27, $2C, $31, $2A, $90, $26, $2B, $32, $2C, $26, $28, $98
    db $F0

Data_00E_46D0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0386D0, $49

Data_00E_4719:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $43, $2F, $90, $2B, $24, $39, $28, $90, $31, $32
    db $F1, $30, $32, $31, $36, $37, $28, $35, $36, $90, $3A, $2C, $37, $2B, $90, $3C
    db $32, $38, $B5, $F7, $F0

Data_00E_473E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03873E, $69

Data_00E_47A7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1B, $28, $24, $27, $3C, $98, $90, $1D, $2B, $28, $31, $F1, $2F
    db $28, $37, $3E, $90, $25, $28, $2A, $2C, $31, $B5, $F7, $F0

Data_00E_47C3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0387C3, $48

Data_00E_480B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $F1, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $37, $2B
    db $28, $FA, $F7, $EF, $EE, $35, $28, $36, $38, $2F, $37, $B5, $FA, $F7, $EF, $EE
    db $12, $36, $90, $2C, $37, $90, $18, $14, $90, $37, $32, $EF, $EE, $33, $35, $32
    db $26, $28, $28, $27, $98, $F0

Data_00E_4841:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $36, $90, $24, $26, $26, $28, $36, $36, $32, $35, $3C
    db $90, $2C, $36, $F1, $2C, $31, $90, $37, $2B, $28, $90, $1F, $24, $38, $2F, $37
    db $B5, $F7, $F0

Data_00E_4864:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $98, $90, $0A, $35, $28, $90, $3C, $32, $38
    db $F1, $2E, $2C, $27, $27, $2C, $31, $2A, $90, $30, $28, $98, $F7, $F0

Data_00E_4882:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $3C, $AB, $90, $30, $24, $37, $28, $3C, $AB, $90, $3A
    db $24, $31, $37, $F1, $37, $32, $90, $25, $35, $28, $28, $27, $90, $36, $32, $30
    db $28, $37, $2B, $2C, $31, $2A, $FA, $F7, $EF, $EE, $3A, $2C, $37, $2B, $90, $30
    db $3C, $90, $20, $2C, $2F, $27, $0A, $33, $28, $98, $EF, $EE, $F0

Data_00E_48BF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $43, $2F, $90, $3C, $32, $38, $90, $33, $38
    db $37, $F1, $38, $33, $90, $29, $32, $35, $90, $30, $3C, $90, $20, $2C, $2F, $27
    db $0A, $33, $28, $98, $F0

Data_00E_48E4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $37, $2B, $2C, $36, $90, $32, $31, $28, $F1, $2A
    db $32, $2C, $31, $2A, $90, $37, $32, $90, $25, $35, $28, $28, $27, $98, $F0

Data_00E_4903:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038903, $43

Data_00E_4946:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $43, $2F, $90, $25, $28, $90, $24, $2F, $2F, $F1
    db $24, $2F, $32, $31, $28, $90, $2C, $29, $90, $3C, $32, $38, $90, $27, $32, $B5
    db $F7, $F0

Data_00E_4968:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038968, $69

Data_00E_49D1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0F, $2C, $31, $28, $99, $90, $15, $28, $37, $3E, $90, $31, $32
    db $37, $F1, $3A, $24, $36, $37, $28, $90, $24, $31, $3C, $90, $37, $2C, $30, $28
    db $99, $F7, $F0

Data_00E_49F4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $31, $2E, $36, $AB, $90, $30, $24, $37, $28, $3C
    db $99, $F1, $16, $38, $26, $2B, $90, $32, $25, $2F, $2C, $2A, $28, $27, $99, $FA
    db $F7, $EF, $EE, $11, $32, $33, $28, $90, $3A, $28, $90, $26, $24, $31, $90, $27
    db $32, $EF, $EE, $37, $2B, $2C, $36, $90, $24, $2A, $24, $2C, $31, $99, $F7, $F0

Data_00E_4A34:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $90, $2C, $36, $F1, $3A, $2B, $24, $37, $90, $3C, $32
    db $38, $43, $2F, $90, $2A, $28, $37, $B5, $FA, $F7, $EF, $EE, $20, $28, $2F, $2F
    db $AB, $90, $27, $32, $90, $3C, $32, $38, $90, $3A, $24, $31, $37, $EF, $EE, $37
    db $32, $90, $27, $32, $90, $37, $2B, $2C, $36, $98, $F0

Data_00E_4A6F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $36, $90, $24, $26, $26, $28, $36, $36, $32, $35, $3C
    db $90, $2C, $36, $F1, $2C, $31, $90, $37, $2B, $28, $90, $1F, $24, $38, $2F, $37
    db $B5, $F7, $F0

Data_00E_4A92:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038A92, $49

Data_00E_4ADB:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $2B, $2C, $26, $2B, $90, $3A, $2C, $2F, $2F, $90, $25, $28
    db $90, $30, $3C, $F1, $0F, $38, $31, $2E, $3C, $0B, $2C, $35, $27, $3E, $90, $30
    db $24, $37, $28, $98, $F0

Data_00E_4B00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038B00, $4F

Data_00E_4B4F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $36, $90, $37, $2B, $2C, $36, $90, $30, $32, $31, $36, $37
    db $28, $35, $F1, $18, $14, $90, $3A, $2C, $37, $2B, $90, $3C, $32, $38, $98, $F0

Data_00E_4B6F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $2C, $36, $90, $30, $32, $31, $36, $37, $28, $35, $90
    db $2C, $36, $F1, $3A, $24, $3C, $90, $37, $32, $32, $90, $2F, $32, $3A, $9C, $2F
    db $28, $39, $28, $2F, $B5, $F7, $F0

Data_00E_4B96:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $22, $32, $38, $90, $26, $24, $31, $41, $90, $25, $28, $90, $25
    db $3C, $F1, $3C, $32, $38, $35, $90, $2F, $32, $31, $28, $36, $32, $30, $28, $99
    db $F7, $F0

Data_00E_4BB8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038BB8, $70

Data_00E_4C28:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $32, $31, $27, $28, $35, $29, $38, $2F, $99, $90, $15, $28
    db $37, $3E, $F1, $25, $28, $2A, $2C, $31, $90, $25, $35, $28, $28, $27, $2C, $31
    db $2A, $99, $F7, $F0

Data_00E_4C4C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038C4C, $6C

Data_00E_4CB8:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $F9, $00, $F1, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $3C, $32
    db $38, $35, $90, $25, $24, $25, $3C, $B5, $FA, $F7, $EF, $EE, $1C, $2B, $32, $38
    db $2F, $27, $90, $3A, $28, $90, $2F, $28, $37, $90, $37, $2B, $28, $30, $EF, $EE
    db $25, $35, $28, $28, $27, $98, $F0

Data_00E_4CEF:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $36, $90, $24, $26, $26, $28, $36, $36, $32, $35, $3C
    db $90, $2C, $36, $F1, $2C, $31, $90, $37, $2B, $28, $90, $1F, $24, $38, $2F, $37
    db $90, $31, $32, $3A, $B5, $F7, $F0

Data_00E_4D16:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038D16, $4B

Data_00E_4D61:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $90, $3A, $2C, $2F, $2F, $90, $25, $35, $28
    db $28, $27, $F1, $3A, $2C, $37, $2B, $90, $30, $3C, $90, $0C, $32, $33, $3C, $26
    db $24, $37, $98, $F0

Data_00E_4D85:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038D85, $49

Data_00E_4DCE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $37, $2B, $24, $37, $90, $3C, $32, $38, $35, $F1
    db $25, $35, $28, $28, $27, $2C, $31, $2A, $90, $26, $2B, $32, $2C, $26, $28, $98
    db $F0

Data_00E_4DEF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038DEF, $44

Data_00E_4E33:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $43, $2F, $90, $2B, $24, $39, $28, $90, $31, $32
    db $F1, $30, $32, $31, $36, $37, $28, $35, $36, $90, $3A, $2C, $37, $2B, $90, $3C
    db $32, $38, $B5, $F7, $F0

Data_00E_4E58:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038E58, $70

Data_00E_4EC8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1B, $28, $24, $27, $3C, $98, $90, $10, $32, $32, $27, $AB, $F1
    db $2F, $28, $37, $3E, $90, $25, $28, $2A, $2C, $31, $B5, $F7, $F0

Data_00E_4EE5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038EE5, $91

Data_00E_4F76:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038F76, $47

Data_00E_4FBD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $36, $90, $24, $26, $26, $28, $36, $36, $32, $35, $3C
    db $90, $2C, $36, $F1, $2C, $31, $90, $37, $2B, $28, $90, $1F, $24, $38, $2F, $37
    db $90, $31, $32, $3A, $B5, $F7, $F0

Data_00E_4FE4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $038FE4, $42

Data_00E_5026:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $2B, $24, $37, $3E, $90, $2A, $32, $2C, $31, $2A, $90, $37
    db $32, $F1, $25, $28, $90, $3A, $2C, $37, $2B, $90, $0A, $31, $27, $35, $28, $24
    db $2F, $98, $F0

Data_00E_5049:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $039049, $42

Data_00E_508B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $36, $90, $37, $2B, $2C, $36, $90, $30, $32, $31, $36, $37
    db $28, $35, $F1, $18, $14, $90, $3A, $2C, $37, $2B, $90, $3C, $32, $38, $98, $F0

Data_00E_50AB:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $24, $37, $90, $32, $31, $28, $3E, $90, $37, $32, $32
    db $F1, $2F, $32, $3A, $9C, $2F, $28, $39, $28, $2F, $AB, $90, $27, $28, $24, $35
    db $B5, $F7, $F0

Data_00E_50CE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $22, $32, $38, $90, $26, $24, $31, $41, $90, $2A, $32, $90, $32
    db $29, $29, $F1, $24, $2F, $2F, $90, $24, $2F, $32, $31, $28, $B5, $F7, $F0

Data_00E_50ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0390ED, $6C

Data_00E_5159:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $10, $32, $32, $27, $AB, $90, $2F, $28, $37, $3E, $90, $2A, $28
    db $37, $F1, $37, $2B, $2C, $36, $90, $36, $37, $24, $35, $37, $28, $27, $B5, $F7
    db $F0

Data_00E_517A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03917A, $90

Data_00E_520A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $F9, $00, $F1, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $3C, $32
    db $38, $35, $90, $25, $24, $25, $3C, $B5, $FA, $F7, $EF, $EE, $12, $36, $90, $2C
    db $37, $90, $18, $14, $90, $37, $32, $90, $2F, $28, $37, $EF, $EE, $37, $2B, $28
    db $30, $90, $25, $35, $28, $28, $27, $98, $F0

Data_00E_5243:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $36, $90, $24, $26, $26, $28, $36, $36, $32, $35, $3C
    db $90, $2C, $36, $F1, $31, $32, $3A, $90, $2C, $31, $90, $37, $2B, $28, $90, $1F
    db $24, $38, $2F, $37, $B5, $F7, $F0

Data_00E_526A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $24, $24, $37, $98, $F1, $22, $32, $38, $40, $28
    db $90, $36, $28, $35, $2C, $32, $38, $36, $98, $FA, $F7, $EF, $EE, $20, $28, $2F
    db $2F, $AB, $90, $30, $24, $3C, $25, $28, $90, $3A, $28, $43, $2F, $EF, $EE, $30
    db $28, $28, $37, $90, $24, $2A, $24, $2C, $31, $B5, $F7, $F0

Data_00E_52A6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $43, $2F, $90, $3C, $32, $38, $90, $33, $24
    db $2C, $35, $F1, $3A, $2C, $37, $2B, $90, $30, $3C, $90, $1C, $2E, $28, $2F, $28
    db $37, $32, $35, $98, $F0

Data_00E_52CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0392CB, $44

Data_00E_530F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $37, $2B, $24, $37, $90, $3A, $2B, $24, $37, $F1
    db $3C, $32, $38, $40, $28, $90, $33, $2C, $26, $2E, $2C, $31, $2A, $98, $F0

Data_00E_532E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $17, $32, $AB, $90, $31, $32, $B5, $90, $17, $32, $37, $2B, $2C
    db $31, $2A, $F1, $2F, $32, $3A, $90, $2C, $31, $90, $2F, $28, $39, $28, $2F, $B5
    db $F7, $F0

Data_00E_5350:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $43, $2F, $90, $25, $28, $90, $3A, $2C, $37, $2B
    db $32, $38, $37, $F1, $24, $90, $30, $32, $31, $36, $37, $28, $35, $B5, $F7, $F0

Func_00E_5370::
    ld de, Data_00E_5385
    call Func_000_25C9
    ret
    db $11, $85, $53, $CD, $FE, $25, $C9

Func_00E_537E::
    call Func_00E_5370
    call Func_000_2611
    ret

Data_00E_5385:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00E_5387

Data_00E_5387:: ; heuristic: target of a monotone pointer table; C0
    dw Data_00E_53B5
    dw Data_00E_53B5
    dw Data_00E_53D0
    dw Data_00E_53E8
    dw Data_00E_5405
    dw Data_00E_5422
    dw Data_00E_5468
    dw Data_00E_5488
    dw Data_00E_5495
    dw Data_00E_54B5
    dw Data_00E_54D6
    dw Data_00E_54F4
    dw Data_00E_550B
    dw Data_00E_552B
    dw Data_00E_5567
    dw Data_00E_556E
    dw Data_00E_557B
    dw Data_00E_559A
    dw Data_00E_55D7
    dw Data_00E_560D
    dw Data_00E_5623
    dw Data_00E_563E
    dw Data_00E_5662

Data_00E_53B5:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $24, $27, $3C, $90, $37, $32, $90, $36, $37, $24, $35, $37, $F1, $25
    db $35, $28, $28, $27, $2C, $31, $2A, $B5, $FA, $F7, $F0

Data_00E_53D0:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $90, $35, $28, $29, $38, $36, $28, $27, $F1, $25, $35, $28, $28
    db $27, $2C, $31, $2A, $B5, $FA, $F7, $F0

Data_00E_53E8:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $35, $90, $33, $24, $2F, $90, $35, $28, $29, $38, $36, $28, $27
    db $F1, $25, $35, $28, $28, $27, $2C, $31, $2A, $B5, $FA, $F7, $F0

Data_00E_5405:: ; heuristic: target of a monotone pointer table; C0
    db $12, $36, $90, $37, $2B, $2C, $36, $90, $32, $31, $28, $90, $18, $14, $90, $29
    db $32, $35, $F1, $25, $35, $28, $28, $27, $2C, $31, $2A, $98, $F0

Data_00E_5422:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $039422, $46

Data_00E_5468:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $32, $36, $28, $90, $29, $35, $32, $30, $90, $37, $2B, $28, $F1
    db $29, $24, $35, $30, $3E, $90, $35, $32, $36, $37, $28, $35, $B5, $FA, $F7, $F0

Data_00E_5488:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $B5, $F0

Data_00E_5495:: ; heuristic: target of a monotone pointer table; C0
    db $12, $27, $28, $31, $37, $2C, $26, $24, $2F, $90, $2A, $28, $31, $27, $28, $35
    db $36, $F1, $26, $24, $31, $41, $90, $25, $35, $28, $28, $27, $B5, $FA, $F7, $F0

Data_00E_54B5:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $32, $36, $28, $90, $37, $2B, $28, $90, $30, $32, $31, $36, $37
    db $28, $35, $F1, $29, $32, $35, $90, $25, $35, $28, $28, $27, $2C, $31, $2A, $B5
    db $F0

Data_00E_54D6:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $26, $32, $38, $33, $2F, $28, $90, $2C, $36, $F1, $2C, $31
    db $26, $32, $30, $33, $24, $37, $2C, $25, $2F, $28, $B5, $FA, $F7, $F0

Data_00E_54F4:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $26, $28, $28, $27, $90, $3A, $2C, $37, $2B, $F1, $25, $35, $28
    db $28, $27, $2C, $31, $2A, $98, $F0

Data_00E_550B:: ; heuristic: target of a monotone pointer table; C0
    db $12, $36, $90, $2C, $37, $90, $18, $14, $90, $37, $32, $90, $35, $28, $26, $32
    db $35, $27, $F1, $37, $2B, $28, $90, $35, $28, $36, $38, $2F, $37, $36, $98, $F0

Data_00E_552B:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $30, $32, $31, $36, $37, $28, $35, $36, $90, $2F, $2C, $2E
    db $28, $F1, $28, $24, $26, $2B, $90, $32, $37, $2B, $28, $35, $B5, $FA, $F7, $EF
    db $EE, $0B, $35, $28, $28, $27, $2C, $31, $2A, $90, $3A, $2C, $2F, $2F, $90, $25
    db $28, $EF, $EE, $36, $37, $24, $35, $37, $28, $27, $B5, $F0

Data_00E_5567:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $32, $18, $14, $F0

Data_00E_556E:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $28, $27, $12, $31, $29, $32, $0E, $3B, $2C, $37, $F0

Data_00E_557B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $1D, $14, $0D, $0E, $0F, $10, $15, $12, $17, $20

Data_00E_5586:: ; heuristic: bank from RAM variable $D7FE; C0
    db $16, $28, $3B, $37, $39, $2F, $0B, $24, $36, $90, $90, $90, $90, $90, $90, $90
    db $90, $A2, $90, $F0

Data_00E_559A:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $28, $28, $27, $2C, $31, $2A, $90, $3A, $28, $31, $37, $F1, $3A, $35
    db $32, $31, $2A, $90, $36, $32, $30, $28, $2B, $32, $3A, $B5, $FA, $F7, $EF, $EE
    db $0B, $35, $28, $28, $27, $2C, $31, $2A, $90, $3A, $2C, $2F, $2F, $90, $25, $28
    db $EF, $EE, $26, $24, $31, $26, $28, $2F, $28, $27, $B5, $F7, $F0

Data_00E_55D7:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $10, $24, $30, $28, $90, $15, $2C, $31, $2E, $F1, $29, $24
    db $2C, $2F, $28, $27, $B5, $FA, $F7, $EF, $EE, $0B, $35, $28, $28, $27, $2C, $31
    db $2A, $90, $3A, $2C, $2F, $2F, $90, $25, $28, $EF, $EE, $26, $24, $31, $26, $28
    db $2F, $28, $27, $B5, $F7, $F0

Data_00E_560D:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $90, $35, $28, $29, $38, $36, $28, $27, $F1, $25, $35, $28, $28
    db $27, $2C, $31, $2A, $B5, $F0

Data_00E_5623:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $35, $90, $33, $24, $2F, $90, $35, $28, $29, $38, $36, $28, $27
    db $F1, $25, $35, $28, $28, $27, $2C, $31, $2A, $B5, $F0

Data_00E_563E:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $35, $90, $25, $35, $28, $28, $27, $2C, $31, $2A, $90, $3A, $2C, $37
    db $2B, $F1, $1D, $28, $35, $35, $3C, $3E, $90, $30, $32, $31, $36, $37, $28, $35
    db $36, $B5, $F7, $F0

Data_00E_5662:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $26, $26, $28, $36, $36, $32, $35, $2C, $28, $36, $90, $3A
    db $2C, $2F, $2F, $F1, $25, $28, $90, $2C, $31, $90, $37, $2B, $28, $90, $1F, $24
    db $38, $2F, $37, $B5, $F7, $F0

Func_00E_5688::
    ld hl, $CAD0
    ld b, $A5

Jump_00E_568D::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00E_568D
    ld hl, $C991
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, Data_00E_6208
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, $CA36
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld c, $00

Jump_00E_56AE::
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_570D
    cp a, $FE
    jr z, Jump_00E_56E2
    cp a, $FD
    jr z, Jump_00E_5705
    cp a, $FC
    jr z, Jump_00E_56DA
    cp a, $FB
    jr z, Jump_00E_56D1
    dec hl
    push hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_00E_5708
    ld a, [hl]
    cp a, d
    jr nz, Jump_00E_5708
    jp Jump_00E_5710

Jump_00E_56D1::
    ld a, [$D7F1]
    cp a, $02
    jr nz, Jump_00E_570D
    jr Jump_00E_5705

Jump_00E_56DA::
    dec hl
    push hl
    ld b, [hl]
    ld hl, $C9F3
    jr Jump_00E_56E8

Jump_00E_56E2::
    dec hl
    push hl
    ld b, [hl]
    ld hl, $CA98

Jump_00E_56E8::
    ld a, [hl]
    cp a, b
    jp nc, Jump_00E_56EF
    jr Jump_00E_5708

Jump_00E_56EF::
    ld a, [$C991]
    ld l, a
    ld a, [$C992]
    ld h, a
    ld a, [$CA36]
    cp a, l
    jr nz, Jump_00E_5708
    ld a, [$CA37]
    cp a, h
    jr nz, Jump_00E_5708
    jr Jump_00E_5710

Jump_00E_5705::
    dec hl
    push hl
    inc c

Jump_00E_5708::
    pop hl
    inc hl
    inc hl
    jr Jump_00E_56AE

Jump_00E_570D::
    jp Jump_00E_5737

Jump_00E_5710::
    pop hl
    push bc
    ld hl, $C991
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, Data_00E_6E14
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop bc
    ld a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00E_572C
    inc h

Jump_00E_572C::
    ld a, [hl+]
    ld [$D7F6], a
    ld a, [hl]
    ld [$D7F7], a
    jp Jump_00E_5862

Jump_00E_5737::
    ld hl, $C991
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, Data_00E_734E
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, $CA38
    ld a, [hl]
    and a, $0F
    ld e, a
    pop hl
    ld c, $00

Jump_00E_5754::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_5777
    cp a, $FE
    jr z, Jump_00E_575F
    jr Jump_00E_576A

Jump_00E_575F::
    ld a, [$D7F1]
    cp a, $02
    jr nz, Jump_00E_5777
    inc hl
    inc c
    jr Jump_00E_5754

Jump_00E_576A::
    push hl
    ld a, [hl]
    cp a, e
    jr nz, Jump_00E_5772
    jp Jump_00E_577A

Jump_00E_5772::
    pop hl
    inc hl
    inc c
    jr Jump_00E_5754

Jump_00E_5777::
    jp Jump_00E_57A1

Jump_00E_577A::
    pop hl
    push bc
    ld hl, $C991
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld hl, Data_00E_774F
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop bc
    ld a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00E_5796
    inc h

Jump_00E_5796::
    ld a, [hl+]
    ld [$D7F6], a
    ld a, [hl]
    ld [$D7F7], a
    jp Jump_00E_5862

Jump_00E_57A1::
    ld hl, $C993
    ld a, [hl]
    and a, $0F
    add a, a
    ld hl, Data_00E_7B83
    add a, l
    ld l, a
    jr nc, Jump_00E_57B0
    inc h

Jump_00E_57B0::
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, $CA36
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld c, $00

Jump_00E_57BE::
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_57DD
    cp a, $FD
    jr z, Jump_00E_57D5
    dec hl
    push hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_00E_57D8
    ld a, [hl]
    cp a, d
    jr nz, Jump_00E_57D8
    jp Jump_00E_57E0

Jump_00E_57D5::
    dec hl
    push hl
    inc c

Jump_00E_57D8::
    pop hl
    inc hl
    inc hl
    jr Jump_00E_57BE

Jump_00E_57DD::
    jp Jump_00E_5808

Jump_00E_57E0::
    pop hl
    push bc
    ld hl, $C993
    ld a, [hl]
    and a, $0F
    add a, a
    ld hl, Data_00E_7DBF
    add a, l
    ld l, a
    jr nc, Jump_00E_57F1
    inc h

Jump_00E_57F1::
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop bc
    ld a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00E_57FD
    inc h

Jump_00E_57FD::
    ld a, [hl+]
    ld [$D7F6], a
    ld a, [hl]
    ld [$D7F7], a
    jp Jump_00E_5862

Jump_00E_5808::
    ld hl, $C993
    ld a, [hl]
    and a, $0F
    add a, a
    ld hl, Data_00E_7E83
    add a, l
    ld l, a
    jr nc, Jump_00E_5817
    inc h

Jump_00E_5817::
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld hl, $CA38
    ld a, [hl]
    and a, $0F
    pop hl
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00E_5829
    inc h

Jump_00E_5829::
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_5854
    cp a, $FE
    jr z, Jump_00E_583F
    dec hl
    ld a, [hl+]
    ld [$D7F6], a
    ld a, [hl]
    ld [$D7F7], a
    jp Jump_00E_5862

Jump_00E_583F::
    ld a, $FF
    ld [$D7F6], a
    ld a, $FF
    ld [$D7F7], a
    ld a, $06
    ld [$CFA8], a
    ld a, $FF
    ld [$D7F5], a
    ret

Jump_00E_5854::
    ld hl, $C991
    ld a, [hl+]
    ld [$D7F6], a
    ld a, [hl]
    ld [$D7F7], a
    jp Jump_00E_5862

Jump_00E_5862::
    ld hl, $CADB
    ld a, [$D7F6]
    ld [hl+], a
    ld a, [$D7F7]
    ld [hl], a
    ld hl, $C994
    ld a, [hl]
    and a, $01
    swap a
    ld b, a
    push bc
    call Func_00E_615A
    ld a, [$D7F5]
    pop bc
    or a, b
    ld b, a
    ld hl, $CADD
    ld [hl], b
    xor a, a
    ld hl, $CB25
    ld [hl], a
    ld hl, $CB74
    ld [hl], a
    ld hl, $CB28
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [$C616]
    ld hl, $CAE9
    ld [hl], a
    ld a, $01
    ld hl, $CB26
    ld [hl], a
    ld hl, $CAD0
    ld [hl], a
    ld hl, $CB3E
    ld [hl], a
    call Func_00E_5E94
    call Func_00E_5E85
    call Func_00E_5E2D
    ld hl, $C986
    ld de, $CA2B
    ld c, $00
    ld b, $08

Jump_00E_58BB::
    push hl
    ld a, c
    ld hl, Data_00E_6200
    add a, l
    ld l, a
    jr nc, Jump_00E_58C5
    inc h

Jump_00E_58C5::
    ld a, [hl]
    pop hl
    push hl
    add a, l
    ld l, a
    jr nc, Jump_00E_58CD
    inc h

Jump_00E_58CD::
    push de
    ld a, c
    ld de, Data_00E_6200
    add a, e
    ld e, a
    jr nc, Jump_00E_58D7
    inc d

Jump_00E_58D7::
    ld a, [de]
    pop de
    push de
    add a, e
    ld e, a
    jr nc, Jump_00E_58DF
    inc d

Jump_00E_58DF::
    push bc
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld e, c
    ld d, b
    pop bc
    push bc
    call Func_00E_59E1
    add hl, de
    srl h
    rr l
    srl h
    rr l
    pop bc
    push bc
    ld de, $CB2B
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_00E_5904
    inc d

Jump_00E_5904::
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    pop bc
    pop de
    pop hl
    inc c
    dec b
    jr nz, Jump_00E_58BB
    ld a, $6F
    add a, l
    ld l, a
    jr nc, Jump_00E_5917
    inc h

Jump_00E_5917::
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_00E_591E
    inc d

Jump_00E_591E::
    ld c, $00
    ld b, $04

Jump_00E_5922::
    push hl
    push de
    push bc
    ld b, [hl]
    ld a, [de]
    add a, b
    srl a
    ld e, a
    pop bc
    push bc
    ld hl, $CB3F
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_00E_5936
    inc h

Jump_00E_5936::
    ld [hl], e
    pop bc
    pop de
    pop hl
    inc hl
    inc de
    inc c
    dec b
    jr nz, Jump_00E_5922
    ld hl, $C9F3
    ld de, $CA98
    ld a, [$D7F1]
    and a, a
    jr z, Jump_00E_594F
    ld a, [hl]
    jr Jump_00E_5955

Jump_00E_594F::
    ld b, [hl]
    ld a, [de]
    cp a, b
    jr nc, Jump_00E_5955
    ld a, [hl]

Jump_00E_5955::
    ld b, a
    push bc
    ld hl, $C9DC
    ld de, $CA81
    ld b, [hl]
    ld a, [de]
    add a, b
    cp a, $64
    jr nc, Jump_00E_5974
    cp a, $4C
    jr nc, Jump_00E_5978
    cp a, $3C
    jr nc, Jump_00E_597C
    cp a, $28
    jr nc, Jump_00E_5980
    ld b, $01
    jr Jump_00E_5982

Jump_00E_5974::
    ld b, $05
    jr Jump_00E_5982

Jump_00E_5978::
    ld b, $04
    jr Jump_00E_5982

Jump_00E_597C::
    ld b, $03
    jr Jump_00E_5982

Jump_00E_5980::
    ld b, $02

Jump_00E_5982::
    ld a, b
    pop bc
    add a, b
    cp a, $64
    jr c, Jump_00E_598B
    ld a, $63

Jump_00E_598B::
    ld hl, $CB3D
    ld [hl], a
    ld hl, $CADB
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [$D00E]
    ld b, a
    push bc
    ld hl, $CB3D
    ld a, [hl]
    ld c, $03
    call Func_000_1682
    pop bc
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_00E_59B5
    inc h

Jump_00E_59B5::
    ld a, h
    and a, a
    jr z, Jump_00E_59BD
    ld a, $63
    jr Jump_00E_59C4

Jump_00E_59BD::
    ld a, l
    cp a, $64
    jr c, Jump_00E_59C4
    ld a, $63

Jump_00E_59C4::
    ld hl, $CB27
    ld [hl], a
    call Func_00E_61C1
    call Func_00E_5EE8
    call Func_00E_5CB2
    call Func_00E_5AA4
    ld a, [$CFA8]
    inc a
    ld [$CFA8], a
    ld a, $FF
    ld [$D7F5], a
    ret

Func_00E_59E1::
    ld a, [$CA2A]
    and a, a
    jr z, Jump_00E_5A25
    ld b, a
    push hl
    ld a, c
    add a, a
    ld hl, Data_00E_5A6B
    add a, l
    ld l, a
    jr nc, Jump_00E_59F3
    inc h

Jump_00E_59F3::
    push de
    ld e, [hl]
    inc hl
    ld d, [hl]

Jump_00E_59F7::
    ld a, [de]
    cp a, $FF
    jr z, Jump_00E_5A02
    cp a, b
    jr z, Jump_00E_5A05
    inc de
    jr Jump_00E_59F7

Jump_00E_5A02::
    pop de
    jr Jump_00E_5A24

Jump_00E_5A05::
    pop de
    ld a, d
    cp a, $03
    jr c, Jump_00E_5A12
    ld a, e
    cp a, $E7
    jr c, Jump_00E_5A12
    jr Jump_00E_5A24

Jump_00E_5A12::
    ld a, b
    ld hl, Data_00E_5A8E
    add a, l
    ld l, a
    jr nc, Jump_00E_5A1B
    inc h

Jump_00E_5A1B::
    ld a, [hl]
    ld b, a
    ld a, e
    sub a, b
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a

Jump_00E_5A24::
    pop hl

Jump_00E_5A25::
    ld a, [$CACF]
    and a, a
    ret z
    ld b, a
    push de
    ld a, c
    add a, a
    ld de, Data_00E_5A6B
    add a, e
    ld e, a
    jr nc, Jump_00E_5A36
    inc d

Jump_00E_5A36::
    push hl
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a

Jump_00E_5A3C::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_5A47
    cp a, b
    jr z, Jump_00E_5A4A
    inc hl
    jr Jump_00E_5A3C

Jump_00E_5A47::
    pop hl
    jr Jump_00E_5A69

Jump_00E_5A4A::
    pop hl
    ld a, h
    cp a, $03
    jr c, Jump_00E_5A57
    ld a, l
    cp a, $E7
    jr c, Jump_00E_5A57
    jr Jump_00E_5A69

Jump_00E_5A57::
    ld a, b
    ld de, Data_00E_5A8E
    add a, e
    ld e, a
    jr nc, Jump_00E_5A60
    inc d

Jump_00E_5A60::
    ld a, [de]
    ld b, a
    ld a, l
    sub a, b
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_00E_5A69::
    pop de
    ret

Data_00E_5A6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00E_5A7B
    dw Data_00E_5A7B
    dw Data_00E_5A7E
    dw Data_00E_5A7E
    dw Data_00E_5A81
    dw Data_00E_5A84
    dw Data_00E_5A88
    dw Data_00E_5A8B

Data_00E_5A7B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $FF

Data_00E_5A7E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $04, $FF

Data_00E_5A81:: ; heuristic: target of a monotone pointer table; C0
    db $05, $06, $FF

Data_00E_5A84:: ; heuristic: target of a monotone pointer table; C0
    db $07, $08, $14, $FF

Data_00E_5A88:: ; heuristic: target of a monotone pointer table; C0
    db $09, $0A, $FF

Data_00E_5A8B:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $0C, $FF

Data_00E_5A8E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $1E, $50, $1E, $50, $0A, $32, $0A, $32, $0A, $32, $32, $64, $00, $00, $00
    db $00, $00, $00, $00, $05, $00

Func_00E_5AA4::
    ld hl, $CB04
    ld c, $08

Jump_00E_5AA9::
    ld a, $FF
    ld [hl+], a
    dec c
    jr nz, Jump_00E_5AA9
    ld hl, $CADB
    call Func_00E_5C11
    ld hl, $CB0C
    call Func_00E_5C09
    push hl
    ld hl, $C991
    call Func_00E_5C11
    pop hl
    call Func_00E_5C09
    push hl
    ld hl, $CA36
    call Func_00E_5C11
    pop hl
    call Func_00E_5C09
    ld de, $C9BA
    call Func_00E_5C00
    ld de, $CA5F
    call Func_00E_5C00
    call Func_00E_5AEA
    call Func_00E_5BCC
    call Func_00E_5BB3
    call Func_00E_5BCC
    ret

Func_00E_5AEA::
    ld hl, $CB0C
    ld c, $19

Jump_00E_5AEF::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00E_5AFE
    ld de, Data_00E_5B03
    add a, e
    ld e, a
    jr nc, Jump_00E_5AFC
    inc d

Jump_00E_5AFC::
    ld a, [de]
    ld [hl], a

Jump_00E_5AFE::
    inc hl
    dec c
    jr nz, Jump_00E_5AEF
    ret

Data_00E_5B03:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $039B03, $B0

Func_00E_5BB3::
    ld hl, $CB0C
    ld de, $CB0C
    ld c, $19

Jump_00E_5BBB::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_00E_5BC5
    inc hl
    dec c
    jr nz, Jump_00E_5BBB
    ret

Jump_00E_5BC5::
    ld [de], a
    inc de
    inc hl
    dec c
    jr nz, Jump_00E_5BBB
    ret

Func_00E_5BCC::
    ld hl, $CB0C
    ld c, $00

Jump_00E_5BD1::
    ld a, [hl]
    and a, a
    jr z, Jump_00E_5BDB
    cp a, $FF
    jr z, Jump_00E_5BDB
    jr Jump_00E_5BE0

Jump_00E_5BDB::
    ld a, $FF
    ld [hl], a
    jr Jump_00E_5BF8

Jump_00E_5BE0::
    ld b, a
    push hl
    ld a, c
    cp a, $19
    jr z, Jump_00E_5BF7
    ld e, a
    inc hl

Jump_00E_5BE9::
    ld a, [hl]
    cp a, b
    jr nz, Jump_00E_5BF0
    ld a, $FF
    ld [hl], a

Jump_00E_5BF0::
    inc hl
    inc e
    ld a, e
    cp a, $19
    jr c, Jump_00E_5BE9

Jump_00E_5BF7::
    pop hl

Jump_00E_5BF8::
    inc hl
    inc c
    ld a, c
    cp a, $19
    jr c, Jump_00E_5BD1
    ret

Func_00E_5C00::
    ld c, $08

Jump_00E_5C02::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_00E_5C02
    ret

Func_00E_5C09::
    push af
    ld a, b
    ld [hl+], a
    ld a, c
    ld [hl+], a
    pop af
    ld [hl+], a
    ret

Func_00E_5C11::
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [$D010]
    ld b, a
    ld a, [$D011]
    ld c, a
    ld a, [$D012]
    ret

Func_00E_5C2B:: ; heuristic: follows a terminator; C0
    ld a, [$D7F1]
    ld [$D006], a
    ld a, [$D7F2]
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [$D010]
    ld [$D7F5], a
    ld a, [$D011]
    ld [$D7F6], a
    ld a, [$D012]
    ld [$D7F7], a
    ret

Func_00E_5C50:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $A000
    ld c, $1E

Jump_00E_5C5E::
    push hl
    push bc
    ld a, [hl]
    and a, a
    jr z, Jump_00E_5CA1
    push hl
    ld a, $0B
    add a, l
    ld l, a
    jr nc, Jump_00E_5C6C
    inc h

Jump_00E_5C6C::
    ld a, [hl+]
    ld [$D7F2], a
    ld [$D006], a
    ld a, [hl]
    ld [$D7F3], a
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    pop hl
    ld a, $73
    add a, l
    ld l, a
    jr nc, Jump_00E_5C88
    inc h

Jump_00E_5C88::
    ld b, $1B
    ld c, $00

Jump_00E_5C8C::
    push hl
    push bc
    ld a, c
    ld [$D7F4], a
    call Func_00E_5E1D
    ld a, [$D7F5]
    pop bc
    pop hl
    and a, $03
    ld [hl+], a
    inc c
    dec b
    jr nz, Jump_00E_5C8C

Jump_00E_5CA1::
    pop bc
    pop hl
    ld a, $A5
    add a, l
    ld l, a
    jr nc, Jump_00E_5CAA
    inc h

Jump_00E_5CAA::
    dec c
    jr nz, Jump_00E_5C5E
    xor a, a
    ld [$0100], a
    ret

Func_00E_5CB2::
    ld hl, $CADB
    ld a, [hl+]
    ld [$D7F2], a
    ld [$D006], a
    ld a, [hl]
    ld [$D7F3], a
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld b, $1B
    ld c, $00

Jump_00E_5CCD::
    push bc
    ld a, c
    ld [$D7F4], a
    call Func_00E_5E1D
    ld a, [$D7F5]
    cp a, $03
    jr nc, Jump_00E_5D01
    pop bc
    push bc
    ld a, [$D7F5]
    cp a, $02
    jr z, Jump_00E_5CF4
    ld b, $03
    call Func_00E_5DAF
    ld a, b
    cp a, $FF
    jr z, Jump_00E_5D01
    call Func_00E_5D16
    jr Jump_00E_5D01

Jump_00E_5CF4::
    ld b, $05
    call Func_00E_5DAF
    ld a, b
    cp a, $FF
    jr z, Jump_00E_5D01
    call Func_00E_5D77

Jump_00E_5D01::
    pop bc
    ld de, $CB43
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_00E_5D0B
    inc d

Jump_00E_5D0B::
    ld a, [$D7F5]
    and a, $03
    ld [de], a
    inc c
    dec b
    jr nz, Jump_00E_5CCD
    ret

Func_00E_5D16::
    push bc
    ld hl, $CB3D
    ld a, [hl]
    and a, a
    jr nz, Jump_00E_5D20
    pop bc
    ret

Jump_00E_5D20::
    ld a, b
    cp a, $03
    jr z, Jump_00E_5D3B
    cp a, $04
    jr z, Jump_00E_5D3F
    cp a, $05
    jr z, Jump_00E_5D43
    ld a, [$D7F5]
    inc a
    ld [$D7F5], a
    ld a, $05

Jump_00E_5D36::
    call Func_00E_5D4E

Jump_00E_5D39::
    pop bc
    ret

Jump_00E_5D3B::
    ld a, $01
    jr Jump_00E_5D36

Jump_00E_5D3F::
    ld a, $03
    jr Jump_00E_5D36

Jump_00E_5D43::
    ld a, $0A
    call Func_00E_5D4E
    cp a, $FF
    jr z, Jump_00E_5D39
    jr Jump_00E_5D3F

Func_00E_5D4E::
    ld c, a
    ld hl, $CB3D
    ld a, [hl]
    call Func_000_1682
    ld a, h
    and a, a
    jr nz, Jump_00E_5D6E
    ld a, l
    cp a, $64
    jr nc, Jump_00E_5D6E
    push af
    push bc
    ld b, $0F
    call Func_00E_611B
    pop bc
    pop af
    cp a, l
    jr nc, Jump_00E_5D6E
    ld a, $FF
    ret

Jump_00E_5D6E::
    ld a, [$D7F5]
    inc a
    ld [$D7F5], a
    xor a, a
    ret

Func_00E_5D77::
    push bc
    ld hl, $CB3D
    ld a, [hl]
    and a, a
    jr nz, Jump_00E_5D81

Jump_00E_5D7F::
    pop bc
    ret

Jump_00E_5D81::
    ld a, b
    cp a, $05
    jr z, Jump_00E_5D8D
    ld a, $02
    call Func_00E_5D4E
    pop bc
    ret

Jump_00E_5D8D::
    ld hl, $CB3D
    cp a, $01
    jr z, Jump_00E_5D7F
    ld a, [hl]
    push af
    push bc
    ld b, $1F
    call Func_00E_611B
    pop bc
    pop af
    cp a, l
    jr nc, Jump_00E_5DA5
    ld a, $FF
    pop bc
    ret

Jump_00E_5DA5::
    ld a, [$D7F5]
    inc a
    ld [$D7F5], a
    xor a, a
    pop bc
    ret

Func_00E_5DAF::
    ld hl, $C9F9
    call Func_00E_5DCD
    cp a, $FF
    jr z, Jump_00E_5DCA
    ld e, a
    ld hl, $CA9E
    call Func_00E_5DCD
    cp a, $FF
    jr z, Jump_00E_5DCA
    add a, e
    cp a, b
    jr c, Jump_00E_5DCA
    ld b, a
    ret

Jump_00E_5DCA::
    ld b, $FF
    ret

Func_00E_5DCD::
    push hl
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_00E_5DD4
    inc h

Jump_00E_5DD4::
    ld a, [hl]
    cp a, $02
    jr z, Jump_00E_5DDB

Jump_00E_5DD9::
    pop hl
    ret

Jump_00E_5DDB::
    pop hl
    push hl
    push af
    ld a, $31
    add a, l
    ld l, a
    jr nc, Jump_00E_5DE5
    inc h

Jump_00E_5DE5::
    ld a, [hl]
    and a, a
    jr z, Jump_00E_5DFF
    cp a, $1C
    jr nc, Jump_00E_5DFF
    dec a
    ld hl, Data_00E_5E02
    add a, l
    ld l, a
    jr nc, Jump_00E_5DF6
    inc h

Jump_00E_5DF6::
    ld a, [hl]
    cp a, c
    jr nz, Jump_00E_5DFF
    pop af
    pop hl
    ld a, $FF
    ret

Jump_00E_5DFF::
    pop af
    jr Jump_00E_5DD9

Data_00E_5E02:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $03, $04, $05, $06, $0E, $0F, $07, $10, $11, $12, $13, $14, $08
    db $09, $0A, $0B, $15, $16, $17, $18, $19, $1A, $0C, $0D

Func_00E_5E1D::
    ld hl, $D01A
    ld a, [$D7F4]
    add a, l
    ld l, a
    jr nc, Jump_00E_5E28
    inc h

Jump_00E_5E28::
    ld a, [hl]
    ld [$D7F5], a
    ret

Func_00E_5E2D::
    ld hl, $CADD
    ld a, [hl]
    and a, $10
    and a, a
    jr nz, Jump_00E_5E3B
    ld de, Data_00E_5E61
    jr Jump_00E_5E3E

Jump_00E_5E3B::
    ld de, Data_00E_5E6D

Jump_00E_5E3E::
    ld c, $00
    ld b, $06

Jump_00E_5E42::
    push de
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    ld a, c
    add a, a
    ld hl, Data_00E_5E79
    add a, l
    ld l, a
    jr nc, Jump_00E_5E53
    inc h

Jump_00E_5E53::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, [hl]
    ld [de], a
    pop de
    inc de
    inc de
    inc c
    dec b
    jr nz, Jump_00E_5E42
    ret

Data_00E_5E61:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $91, $C9, $92, $C9, $36, $CA, $37, $CA, $F3, $C9, $98, $CA

Data_00E_5E6D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $36, $CA, $37, $CA, $91, $C9, $92, $C9, $98, $CA, $F3, $C9

Data_00E_5E79:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EA, $CA, $EB, $CA, $EC, $CA, $ED, $CA, $68, $CB, $73, $CB

Func_00E_5E85::
    ld hl, $C60C
    ld de, $CADF
    ld c, $0A

Jump_00E_5E8D::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_00E_5E8D
    ret

Func_00E_5E94::
    ld hl, $CADD
    ld a, [hl]
    and a, $10
    and a, a
    jr nz, Jump_00E_5EA2
    ld de, Data_00E_5ED0
    jr Jump_00E_5EA5

Jump_00E_5EA2::
    ld de, Data_00E_5ED8

Jump_00E_5EA5::
    ld c, $00
    ld b, $04

Jump_00E_5EA9::
    push de
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    ld hl, Data_00E_5EE0
    ld a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00E_5EBA
    inc h

Jump_00E_5EBA::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    push bc
    ld b, $0A

Jump_00E_5EC1::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00E_5EC1
    pop bc
    pop de
    inc de
    inc de
    inc c
    dec b
    jr nz, Jump_00E_5EA9
    ret

Data_00E_5ED0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $87, $C9, $2C, $CA, $95, $C9, $3A, $CA

Data_00E_5ED8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2C, $CA, $87, $C9, $3A, $CA, $95, $C9

Data_00E_5EE0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5E, $CB, $69, $CB, $EE, $CA, $F9, $CA

Func_00E_5EE8::
    call Func_00E_5F91
    ld c, $00
    ld a, [$D7F5]
    and a, a
    jr nz, Jump_00E_5EF7
    ld a, c
    add a, $05
    ld c, a

Jump_00E_5EF7::
    ld hl, $C9DD
    ld a, [hl-]
    ld b, a
    ld a, [hl]
    cp a, b
    jr nz, Jump_00E_5F0D
    ld hl, $CA82
    ld a, [hl-]
    ld b, a
    ld a, [hl]
    cp a, b
    jr nz, Jump_00E_5F0D
    ld a, c
    add a, $05
    ld c, a

Jump_00E_5F0D::
    ld hl, $C9F3
    ld a, [hl]
    cp a, $05
    jr c, Jump_00E_5F27
    ld b, a
    ld hl, $CA98
    ld a, [hl]
    cp a, $05
    jr c, Jump_00E_5F27
    add a, b
    bit 0, a
    jr nz, Jump_00E_5F27
    ld a, c
    add a, $02
    ld c, a

Jump_00E_5F27::
    ld a, [$D7F1]
    and a, a
    jr z, Jump_00E_5F31
    ld a, c
    add a, $03
    ld c, a

Jump_00E_5F31::
    ld a, c
    and a, a
    ret z
    ld b, $08
    ld de, Data_00E_5F89

Jump_00E_5F39::
    push de
    push bc
    ld hl, $CAD0
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_00E_5F44
    inc h

Jump_00E_5F44::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    push bc
    ld a, c
    ld c, e
    ld b, d
    call Func_000_16AA
    ld a, $64
    call Func_000_16D1
    and a, a
    jr z, Jump_00E_5F58
    inc hl

Jump_00E_5F58::
    pop bc
    pop de
    push de
    push bc
    ld bc, $CAD0
    ld a, [de]
    add a, c
    ld c, a
    jr nc, Jump_00E_5F65
    inc b

Jump_00E_5F65::
    push bc
    ld a, [bc]
    ld e, a
    inc bc
    ld a, [bc]
    ld d, a
    add hl, de
    ld a, h
    cp a, $03
    jr c, Jump_00E_5F7C
    jr nz, Jump_00E_5F78
    ld a, l
    cp a, $E8
    jr c, Jump_00E_5F7C

Jump_00E_5F78::
    ld h, $03
    ld l, $E7

Jump_00E_5F7C::
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    pop bc
    pop de
    inc de
    dec b
    jr nz, Jump_00E_5F39
    ret

Data_00E_5F89:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5B, $5D, $5F, $61, $63, $65, $67, $69

Func_00E_5F91::
    ld hl, $C986
    call Func_00E_5FF9
    push af
    ld hl, $CA2B
    call Func_00E_5FF9
    ld b, a
    ld l, a
    ld h, $00
    srl h
    rr l
    srl h
    rr l
    pop af
    push af
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, Data_00E_603F
    add hl, de
    ld a, b
    and a, $03
    ld de, Data_00E_6117
    add a, e
    ld e, a
    jr nc, Jump_00E_5FCB
    inc d

Jump_00E_5FCB::
    ld a, [de]
    ld c, a
    ld a, [hl]
    and a, c
    ld c, a
    ld a, b
    and a, $03
    and a, a
    jr z, Jump_00E_5FE1
    cp a, $01
    jr z, Jump_00E_5FEA
    cp a, $02
    jr z, Jump_00E_5FEF
    ld a, c
    jr Jump_00E_5FF4

Jump_00E_5FE1::
    ld a, c
    swap a
    srl a
    srl a
    jr Jump_00E_5FF4

Jump_00E_5FEA::
    ld a, c
    swap a
    jr Jump_00E_5FF4

Jump_00E_5FEF::
    ld a, c
    srl a
    srl a

Jump_00E_5FF4::
    ld [$D7F5], a
    pop af
    ret

Func_00E_5FF9::
    push hl
    ld a, $6F
    add a, l
    ld l, a
    jr nc, Jump_00E_6001
    inc h

Jump_00E_6001::
    ld a, [hl]
    ldh [$FFC6], a
    call Func_00E_6032
    ld a, $09
    call Func_000_1682
    ld b, l
    pop hl
    push hl
    ld a, $72
    add a, l
    ld l, a
    jr nc, Jump_00E_6016
    inc h

Jump_00E_6016::
    ld a, [hl]
    ldh [$FFC6], a
    call Func_00E_6032
    ld a, c
    add a, a
    add a, c
    add a, b
    ld b, a
    pop hl
    ld a, $70
    add a, l
    ld l, a
    jr nc, Jump_00E_6029
    inc h

Jump_00E_6029::
    ld a, [hl]
    ldh [$FFC6], a
    call Func_00E_6032
    ld a, c
    add a, b
    ret

Func_00E_6032::
    ldh a, [$FFC6]
    ld c, $00
    cp a, $C0
    ret nc
    inc c
    cp a, $40
    ret nc
    inc c
    ret

Data_00E_603F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03A03F, $D8

Data_00E_6117:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $30, $0C, $03

Func_00E_611B::
    push bc
    call Func_000_095B
    pop bc
    ld a, [$C5E7]
    ld l, a
    rl a
    and a, b
    ld h, a
    ld a, $29
    call Func_000_16D1
    ret

Func_00E_612E::
    ld a, c
    push af
    ld a, [$D7F5]
    ld c, a
    pop af
    call Func_000_1F89

Func_00E_6138::
    ldh a, [$FFC6]
    ld [$D7F6], a
    ldh a, [$FFC7]
    ld [$D7F7], a
    call Func_00E_615A
    ld a, [$D7F5]
    and a, $0F
    ld [$D09D], a
    ld a, [$D7F4]
    ld [$D09E], a
    ld hl, Func_016_7A48
    ld b, $16
    rst $10
    ret

Func_00E_615A::
    ld a, [$D7F6]
    ld l, a
    ld a, [$D7F7]
    ld h, a
    cp a, $01
    jr nz, Jump_00E_6175
    ld a, l
    cp a, $11
    jr c, Jump_00E_61AF
    cp a, $39
    jr c, Jump_00E_61B3
    cp a, $5C
    jr c, Jump_00E_61B7
    jr Jump_00E_61BB

Jump_00E_6175::
    ld a, l
    cp a, $1B
    jr c, Jump_00E_6194
    cp a, $43
    jr c, Jump_00E_6197
    cp a, $67
    jr c, Jump_00E_619B
    cp a, $85
    jr c, Jump_00E_619F
    cp a, $A8
    jr c, Jump_00E_61A3
    cp a, $CA
    jr c, Jump_00E_61A7
    cp a, $F1
    jr c, Jump_00E_61AB
    jr Jump_00E_61AF

Jump_00E_6194::
    xor a, a
    jr Jump_00E_61BD

Jump_00E_6197::
    ld a, $01
    jr Jump_00E_61BD

Jump_00E_619B::
    ld a, $02
    jr Jump_00E_61BD

Jump_00E_619F::
    ld a, $03
    jr Jump_00E_61BD

Jump_00E_61A3::
    ld a, $04
    jr Jump_00E_61BD

Jump_00E_61A7::
    ld a, $05
    jr Jump_00E_61BD

Jump_00E_61AB::
    ld a, $06
    jr Jump_00E_61BD

Jump_00E_61AF::
    ld a, $07
    jr Jump_00E_61BD

Jump_00E_61B3::
    ld a, $08
    jr Jump_00E_61BD

Jump_00E_61B7::
    ld a, $09
    jr Jump_00E_61BD

Jump_00E_61BB::
    ld a, $0A

Jump_00E_61BD::
    ld [$D7F5], a
    ret

Func_00E_61C1::
    ld a, [$CADB]
    ld [$D006], a
    ld a, [$CADC]
    ld [$D007], a
    ld hl, Func_035_4013
    ld b, $35
    rst $10
    ld a, [$D009]
    and a, a
    jr z, Jump_00E_61F4
    and a, $03
    ld hl, Data_00E_61FC
    add a, l
    ld l, a
    jr nc, Jump_00E_61E3
    inc h

Jump_00E_61E3::
    ld a, [hl]
    push af
    push bc
    ld b, $0F
    call Func_00E_611B
    pop bc
    pop af
    cp a, l
    jr c, Jump_00E_61F4
    ld b, $01
    jr Jump_00E_61F6

Jump_00E_61F4::
    ld b, $00

Jump_00E_61F6::
    ld a, b
    ld hl, $CADE
    ld [hl], a
    ret

Data_00E_61FC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $0A, $32, $5A

Data_00E_6200:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5D, $5D, $61, $61, $63, $65, $67, $69

Data_00E_6208:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03A208, $82
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_66E6
    dw Data_00E_6716
    dw Data_00E_671C
    dw Data_00E_6508
    db $08, $65, $2C, $67
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6508
    db $5E, $67, $6E, $67
    dw Data_00E_6508
    db $8A, $67, $90, $67
    dw Data_00E_67B2
    db $D4, $67, $E0, $67
    dw Data_00E_67E4
    db $EA, $67, $08, $65
    dw Data_00E_67EE
    db $06, $68, $22, $68
    dw Data_00E_684C
    db $08, $65, $72, $68
    dw Data_00E_6876
    db $08, $65, $08, $65
    dw Data_00E_6888
    db $8E, $68
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6508
    db $08, $65, $AA, $68
    dw Data_00E_6508
    db $08, $65, $AE, $68
    dw Data_00E_6508
    db $08, $65, $B4, $68
    dw Data_00E_6508
    db $BA, $68, $08, $65
    dw Data_00E_6508
    db $BE, $68, $CE, $68
    dw Data_00E_68DE
    db $08, $65, $F6, $68
    dw Data_00E_6910
    db $18, $69, $2C, $69
    dw Data_00E_6932
    db $3C, $69, $40, $69, $08, $65, $44, $69, $48, $69, $08, $65, $08, $65, $08, $65
    db $08, $65, $08, $65, $08, $65, $08, $65, $08, $65, $08, $65, $08, $65
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6508
    db $54, $69, $08, $65
    dw Data_00E_6508
    db $58, $69, $08, $65
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6960
    db $66, $69, $08, $65
    dw Data_00E_696A
    db $72, $69, $08, $65
    dw Data_00E_6976
    db $08, $65, $08, $65
    dw Data_00E_697C
    INCBIN "dwm2-cobi-us.gbc", $03A358, $44
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_69C8
    dw Data_00E_6A08
    dw Data_00E_6A0C
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6A12
    dw Data_00E_6A1C
    dw Data_00E_6A26
    dw Data_00E_6A2C
    dw Data_00E_6A34
    INCBIN "dwm2-cobi-us.gbc", $03A3C8, $44
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6508
    dw Data_00E_6B9A
    dw Data_00E_6BBC
    dw Data_00E_6BC8
    dw Data_00E_6BD0
    dw Data_00E_6BE6
    dw Data_00E_6C18
    dw Data_00E_6508
    db $1E, $6C, $24, $6C
    dw Data_00E_6508
    db $32, $6C, $08, $65
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6508
    db $08, $65, $46, $6C
    dw Data_00E_6C50
    db $08, $65, $08, $65
    dw Data_00E_6C5E
    db $62, $6C, $08, $65
    dw Data_00E_6C70
    db $76, $6C, $8A, $6C
    dw Data_00E_6C94
    db $08, $65, $A8, $6C
    dw Data_00E_6CBA
    db $08, $65, $C0, $6C
    dw Data_00E_6CD6
    db $DE, $6C, $E4, $6C
    dw Data_00E_6CF6
    db $FA, $6C, $FE, $6C, $08, $65, $02, $6D, $06, $6D, $1E, $6D
    dw Data_00E_6508
    db $3A, $6D, $08, $65
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6508
    db $3E, $6D, $44, $6D
    dw Data_00E_6508
    db $08, $65, $4A, $6D
    dw Data_00E_6D50
    db $08, $65, $60, $6D
    dw Data_00E_6D6C
    db $70, $6D, $74, $6D
    dw Data_00E_6D80
    db $08, $65, $08, $65
    dw Data_00E_6D84
    db $8C, $6D, $08, $65
    dw Data_00E_6D92
    dw Data_00E_6508
    db $A2, $6D, $08, $65
    dw Data_00E_6508
    db $08, $65, $AA, $6D
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6508
    db $08, $65, $08, $65
    dw Data_00E_6DAE
    db $B6, $6D, $08, $65
    dw Data_00E_6DBE
    db $C2, $6D, $08, $65
    dw Data_00E_6DC6
    db $CC, $6D, $08, $65
    dw Data_00E_6DD8
    db $E2, $6D, $E6, $6D
    dw Data_00E_6DEA
    db $F4, $6D, $08, $65
    dw Data_00E_6DF8
    db $FE, $6D, $06, $6E, $08, $65, $0E, $6E, $08, $65, $08, $65, $08, $65, $08, $65
    db $08, $65, $08, $65, $08, $65, $08, $65, $08, $65, $08, $65, $08, $65, $08, $65
    db $08, $65

Data_00E_6508:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03A508, $1DE

Data_00E_66E6:: ; heuristic: target of a monotone pointer table; C0
    db $C7, $00, $F7, $00, $07, $01, $08, $01, $0A, $01, $FD, $FD, $04, $00, $0C, $00
    db $2F, $00, $80, $00, $8D, $00, $9B, $00, $B6, $00, $D6, $00, $DD, $00, $0D, $01
    db $19, $01, $2F, $01, $FD, $FD, $77, $00, $79, $00, $7D, $00, $7F, $00, $FF, $FF

Data_00E_6716:: ; heuristic: target of a monotone pointer table; C0
    db $FB, $FB, $0B, $00, $FF, $FF

Data_00E_671C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03A71C, $96

Data_00E_67B2:: ; heuristic: target of a monotone pointer table; C0
    db $C7, $00, $F7, $00, $07, $01, $08, $01, $0A, $01, $24, $01, $29, $01, $2D, $01
    db $2E, $01, $32, $01, $33, $01, $FD, $FD, $77, $00, $79, $00, $7D, $00, $7F, $00
    db $FF, $FF, $73, $00, $FD, $00, $FD, $FD, $04, $FE, $04, $FC, $FF, $FF, $EA, $00
    db $FF, $FF

Data_00E_67E4:: ; heuristic: target of a monotone pointer table; C0
    db $FB, $FB, $50, $01, $FF, $FF, $66, $00, $FF, $FF

Data_00E_67EE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03A7EE, $5E

Data_00E_684C:: ; heuristic: target of a monotone pointer table; C0
    db $C7, $00, $F7, $00, $07, $01, $08, $01, $0A, $01, $29, $01, $2D, $01, $2E, $01
    db $32, $01, $33, $01, $FD, $FD, $5F, $00, $E5, $00, $24, $01, $25, $01, $35, $01
    db $FB, $FB, $7E, $00, $FF, $FF, $3C, $00, $FF, $FF

Data_00E_6876:: ; heuristic: target of a monotone pointer table; C0
    db $26, $00, $27, $00, $2B, $00, $2F, $00, $3D, $00, $3E, $00, $FB, $FB, $F0, $00
    db $FF, $FF

Data_00E_6888:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03A888, $56

Data_00E_68DE:: ; heuristic: target of a monotone pointer table; C0
    db $6F, $00, $FD, $FD, $2C, $01, $FD, $FD, $0D, $00, $0E, $00, $C7, $00, $24, $01
    db $32, $01, $33, $01, $42, $01, $FF, $FF, $DF, $00, $FD, $FD, $0D, $00, $0E, $00
    db $C7, $00, $24, $01, $32, $01, $33, $01, $42, $01, $FD, $FD, $35, $00, $7C, $00
    db $FF, $FF

Data_00E_6910:: ; heuristic: target of a monotone pointer table; C0
    db $2C, $01, $FD, $FD, $DF, $00, $FF, $FF, $DF, $00, $FD, $FD, $0D, $00, $0E, $00
    db $C7, $00, $24, $01, $32, $01, $33, $01, $42, $01, $FF, $FF, $FB, $FB, $5F, $00
    db $FF, $FF

Data_00E_6932:: ; heuristic: target of a monotone pointer table; C0
    db $2C, $01, $FD, $FD, $38, $00, $ED, $00, $FF, $FF, $ED, $00, $FF, $FF, $35, $01
    db $FF, $FF, $35, $01, $FF, $FF, $6E, $00, $70, $00, $FD, $FD, $04, $FE, $04, $FC
    db $FF, $FF, $21, $01, $FF, $FF, $06, $00, $54, $00, $59, $00, $FF, $FF

Data_00E_6960:: ; heuristic: target of a monotone pointer table; C0
    db $95, $00, $9E, $00, $FF, $FF, $9F, $00, $FF, $FF

Data_00E_696A:: ; heuristic: target of a monotone pointer table; C0
    db $A1, $00, $FD, $FD, $A0, $00, $FF, $FF, $EA, $00, $FF, $FF

Data_00E_6976:: ; heuristic: target of a monotone pointer table; C0
    db $FB, $FB, $A5, $00, $FF, $FF

Data_00E_697C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03A97C, $4C

Data_00E_69C8:: ; heuristic: target of a monotone pointer table; C0
    db $10, $00, $13, $00, $17, $00, $33, $00, $38, $00, $3C, $00, $5F, $00, $60, $00
    db $7D, $00, $7E, $00, $7F, $00, $24, $01, $FD, $FD, $4C, $00, $5C, $00, $C7, $00
    db $29, $01, $3E, $01, $50, $01, $FD, $FD, $0E, $00, $2B, $00, $3B, $00, $71, $00
    db $79, $00, $A2, $00, $BE, $00, $F7, $00, $07, $01, $08, $01, $51, $01, $FF, $FF

Data_00E_6A08:: ; heuristic: target of a monotone pointer table; C0
    db $D6, $00, $FF, $FF

Data_00E_6A0C:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $45, $01, $FF, $FF

Data_00E_6A12:: ; heuristic: target of a monotone pointer table; C0
    db $FB, $FB, $FC, $00, $FD, $FD, $2B, $01, $FF, $FF

Data_00E_6A1C:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $45, $01, $FD, $FD, $DC, $00, $FF, $FF

Data_00E_6A26:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $45, $01, $FF, $FF

Data_00E_6A2C:: ; heuristic: target of a monotone pointer table; C0
    db $7E, $00, $FD, $FD, $E3, $00, $FF, $FF

Data_00E_6A34:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03AA34, $166

Data_00E_6B9A:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $00, $DF, $00, $E3, $00, $0D, $01, $24, $01, $29, $01, $FD, $FD, $4C, $00
    db $55, $00, $62, $00, $70, $00, $79, $00, $DA, $00, $E2, $00, $32, $01, $33, $01
    db $FF, $FF

Data_00E_6BBC:: ; heuristic: target of a monotone pointer table; C0
    db $13, $00, $FD, $FD, $3F, $00, $2A, $01, $57, $01, $FF, $FF

Data_00E_6BC8:: ; heuristic: target of a monotone pointer table; C0
    db $5F, $01, $FD, $FD, $17, $00, $FF, $FF

Data_00E_6BD0:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $00, $DF, $00, $E3, $00, $0D, $01, $24, $01, $29, $01, $FD, $FD, $17, $00
    db $FD, $FD, $09, $01, $FF, $FF

Data_00E_6BE6:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $00, $DF, $00, $E3, $00, $0D, $01, $24, $01, $29, $01, $FD, $FD, $33, $00
    db $38, $00, $60, $00, $7B, $00, $7D, $00, $7F, $00, $35, $01, $55, $01, $58, $01
    db $FD, $FD, $0A, $01, $FD, $FD, $3F, $00, $2A, $01, $57, $01, $FB, $FB, $E6, $00
    db $FF, $FF

Data_00E_6C18:: ; heuristic: target of a monotone pointer table; C0
    db $33, $00, $38, $00, $FF, $FF, $27, $00, $BF, $00, $FF, $FF, $DE, $00, $DF, $00
    db $E3, $00, $24, $01, $29, $01, $2A, $01, $FF, $FF, $33, $00, $38, $00, $60, $00
    db $7B, $00, $7D, $00, $7F, $00, $35, $01, $55, $01, $58, $01, $FF, $FF, $77, $00
    db $78, $00, $7C, $00, $80, $00, $FF, $FF

Data_00E_6C50:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $6B, $00, $71, $00, $8E, $00, $9E, $00, $40, $01, $FF, $FF

Data_00E_6C5E:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $01, $FF, $FF, $01, $00, $6B, $00, $71, $00, $8E, $00, $9E, $00, $40, $01
    db $FF, $FF

Data_00E_6C70:: ; heuristic: target of a monotone pointer table; C0
    db $D3, $00, $D6, $00, $FF, $FF, $01, $00, $6B, $00, $71, $00, $8E, $00, $9E, $00
    db $40, $01, $FD, $FD, $22, $01, $4B, $01, $FF, $FF, $77, $00, $78, $00, $7C, $00
    db $80, $00, $FF, $FF

Data_00E_6C94:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $00, $60, $00, $7D, $00, $DE, $00, $E5, $00, $EB, $00, $FD, $FD, $F7, $00
    db $08, $01, $FF, $FF, $0E, $00, $38, $00, $5C, $00, $E2, $00, $E6, $00, $EC, $00
    db $07, $01, $0A, $01, $FF, $FF

Data_00E_6CBA:: ; heuristic: target of a monotone pointer table; C0
    db $FB, $FB, $E5, $00, $FF, $FF, $24, $01, $FD, $FD, $05, $FE, $05, $FC, $FD, $FD
    db $60, $00, $FD, $FD, $48, $01, $FB, $FB, $29, $01, $FF, $FF

Data_00E_6CD6:: ; heuristic: target of a monotone pointer table; C0
    db $24, $01, $FD, $FD, $60, $00, $FF, $FF, $FB, $FB, $DB, $00, $FF, $FF, $10, $00
    db $13, $00, $3E, $00, $F0, $00, $08, $01, $53, $01, $55, $01, $5F, $01, $FF, $FF

Data_00E_6CF6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03ACF6, $5A

Data_00E_6D50:: ; heuristic: target of a monotone pointer table; C0
    db $D3, $00, $D6, $00, $D9, $00, $DD, $00, $FD, $FD, $4C, $00, $BF, $00, $FF, $FF
    db $37, $00, $4C, $01, $78, $00, $EA, $00, $32, $01, $FF, $FF

Data_00E_6D6C:: ; heuristic: target of a monotone pointer table; C0
    db $C0, $00, $FF, $FF, $4A, $01, $FF, $FF, $1A, $01, $55, $01, $FD, $FD, $3D, $00
    db $DE, $00, $FF, $FF

Data_00E_6D80:: ; heuristic: target of a monotone pointer table; C0
    db $2F, $01, $FF, $FF

Data_00E_6D84:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00, $03, $01, $48, $01, $FF, $FF, $FB, $FB, $59, $00, $FF, $FF

Data_00E_6D92:: ; heuristic: target of a monotone pointer table; C0
    db $DF, $00, $E3, $00, $E4, $00, $EC, $00, $FD, $FD, $05, $FE, $05, $FC, $FF, $FF
    db $38, $00, $3B, $00, $41, $00, $FF, $FF, $6D, $01, $FF, $FF

Data_00E_6DAE:: ; heuristic: target of a monotone pointer table; C0
    db $40, $00, $FD, $FD, $63, $01, $FF, $FF, $41, $00, $FD, $FD, $63, $01, $FF, $FF

Data_00E_6DBE:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $00, $FF, $FF, $EF, $00, $FF, $FF

Data_00E_6DC6:: ; heuristic: target of a monotone pointer table; C0
    db $61, $00, $64, $00, $FF, $FF, $69, $01, $FD, $FD, $82, $00, $6B, $01, $6C, $01
    db $FF, $FF

Data_00E_6DD8:: ; heuristic: target of a monotone pointer table; C0
    db $6A, $01, $FD, $FD, $60, $00, $64, $00, $FF, $FF, $10, $01, $FF, $FF, $18, $00
    db $FF, $FF

Data_00E_6DEA:: ; heuristic: target of a monotone pointer table; C0
    db $37, $00, $41, $00, $FD, $FD, $82, $00, $FF, $FF, $66, $01, $FF, $FF

Data_00E_6DF8:: ; heuristic: target of a monotone pointer table; C0
    db $C6, $00, $EF, $00, $FF, $FF, $36, $01, $59, $01, $6D, $01, $FF, $FF, $19, $00
    db $A5, $00, $67, $01, $FF, $FF, $61, $01, $42, $00, $FF, $FF

Data_00E_6E14:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00E_7114
    dw Data_00E_7116
    dw Data_00E_7118
    dw Data_00E_711A
    dw Data_00E_711A
    dw Data_00E_711A
    dw Data_00E_711A
    dw Data_00E_711C
    dw Data_00E_711C
    dw Data_00E_711C
    dw Data_00E_711C
    dw Data_00E_7124
    dw Data_00E_7126
    dw Data_00E_7126
    dw Data_00E_7128
    dw Data_00E_7128
    dw Data_00E_7128
    dw Data_00E_712E
    dw Data_00E_7130
    dw Data_00E_7134
    dw Data_00E_713A
    dw Data_00E_713A
    dw Data_00E_713C
    dw Data_00E_713C
    dw Data_00E_7140
    dw Data_00E_7142
    dw Data_00E_7142
    dw Data_00E_7148
    dw Data_00E_7148
    dw Data_00E_7148
    dw Data_00E_7148
    dw Data_00E_7148
    dw Data_00E_7148
    dw Data_00E_7148
    dw Data_00E_7148
    dw Data_00E_7148
    dw Data_00E_7148
    dw Data_00E_714C
    dw Data_00E_714C
    dw Data_00E_7150
    dw Data_00E_7154
    dw Data_00E_7154
    dw Data_00E_7158
    dw Data_00E_7158
    dw Data_00E_7158
    dw Data_00E_7158
    dw Data_00E_715E
    dw Data_00E_715E
    dw Data_00E_7160
    dw Data_00E_7160
    dw Data_00E_7160
    dw Data_00E_7160
    dw Data_00E_7164
    dw Data_00E_7166
    dw Data_00E_716A
    dw Data_00E_716A
    dw Data_00E_716A
    dw Data_00E_7170
    dw Data_00E_7172
    dw Data_00E_7174
    dw Data_00E_7174
    dw Data_00E_7174
    dw Data_00E_717A
    dw Data_00E_7182
    dw Data_00E_7182
    dw Data_00E_7184
    dw Data_00E_7184
    dw Data_00E_7184
    dw Data_00E_7184
    dw Data_00E_7184
    dw Data_00E_7184
    dw Data_00E_7184
    dw Data_00E_718A
    dw Data_00E_718E
    dw Data_00E_7190
    dw Data_00E_7190
    dw Data_00E_7190
    dw Data_00E_7194
    dw Data_00E_7194
    dw Data_00E_7194
    dw Data_00E_7194
    dw Data_00E_7194
    dw Data_00E_7196
    dw Data_00E_719A
    dw Data_00E_719A
    dw Data_00E_719E
    dw Data_00E_71A2
    dw Data_00E_71A6
    dw Data_00E_71AA
    dw Data_00E_71AC
    dw Data_00E_71B0
    dw Data_00E_71B2
    dw Data_00E_71B2
    dw Data_00E_71B4
    dw Data_00E_71B8
    dw Data_00E_71BE
    dw Data_00E_71C4
    dw Data_00E_71C4
    dw Data_00E_71C6
    dw Data_00E_71CA
    dw Data_00E_71CA
    dw Data_00E_71CA
    dw Data_00E_71CC
    dw Data_00E_71D0
    dw Data_00E_71D0
    dw Data_00E_71D0
    dw Data_00E_71D0
    dw Data_00E_71D0
    dw Data_00E_71D0
    dw Data_00E_71D2
    dw Data_00E_71D2
    dw Data_00E_71D2
    dw Data_00E_71D4
    dw Data_00E_71D4
    dw Data_00E_71D4
    dw Data_00E_71D8
    dw Data_00E_71D8
    dw Data_00E_71DA
    dw Data_00E_71DA
    dw Data_00E_71DA
    dw Data_00E_71DC
    dw Data_00E_71DE
    dw Data_00E_71E4
    dw Data_00E_71E4
    dw Data_00E_71EA
    dw Data_00E_71EE
    dw Data_00E_71F2
    dw Data_00E_71F6
    dw Data_00E_71FA
    dw Data_00E_71FC
    dw Data_00E_71FE
    dw Data_00E_71FE
    dw Data_00E_7200
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7204
    dw Data_00E_7206
    dw Data_00E_7206
    dw Data_00E_7206
    dw Data_00E_7208
    dw Data_00E_7208
    dw Data_00E_7208
    dw Data_00E_7208
    dw Data_00E_7208
    dw Data_00E_720A
    dw Data_00E_720C
    dw Data_00E_720C
    dw Data_00E_7210
    dw Data_00E_7212
    dw Data_00E_7212
    dw Data_00E_7216
    dw Data_00E_7216
    dw Data_00E_7216
    dw Data_00E_7218
    dw Data_00E_7218
    dw Data_00E_7218
    dw Data_00E_7218
    dw Data_00E_7218
    dw Data_00E_7218
    dw Data_00E_7218
    dw Data_00E_7218
    dw Data_00E_7218
    dw Data_00E_7218
    dw Data_00E_721A
    dw Data_00E_721A
    dw Data_00E_721E
    dw Data_00E_7220
    dw Data_00E_7220
    dw Data_00E_7222
    dw Data_00E_7224
    dw Data_00E_7224
    dw Data_00E_7224
    dw Data_00E_7224
    dw Data_00E_7226
    dw Data_00E_7226
    dw Data_00E_7228
    dw Data_00E_7228
    dw Data_00E_7228
    dw Data_00E_722A
    dw Data_00E_722C
    dw Data_00E_722C
    dw Data_00E_722E
    dw Data_00E_7230
    dw Data_00E_7230
    dw Data_00E_7232
    dw Data_00E_7232
    dw Data_00E_7232
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_7236
    dw Data_00E_723C
    dw Data_00E_723E
    dw Data_00E_7240
    dw Data_00E_7240
    dw Data_00E_7240
    dw Data_00E_7240
    dw Data_00E_7246
    dw Data_00E_724A
    dw Data_00E_724C
    dw Data_00E_7250
    dw Data_00E_7252
    dw Data_00E_7252
    dw Data_00E_7252
    dw Data_00E_7256
    dw Data_00E_7256
    dw Data_00E_7256
    dw Data_00E_725A
    dw Data_00E_7264
    dw Data_00E_7266
    dw Data_00E_7266
    dw Data_00E_7266
    dw Data_00E_726C
    dw Data_00E_7270
    dw Data_00E_7270
    dw Data_00E_7274
    dw Data_00E_7278
    dw Data_00E_7278
    dw Data_00E_727C
    dw Data_00E_727C
    dw Data_00E_727C
    dw Data_00E_727C
    dw Data_00E_727C
    dw Data_00E_727C
    dw Data_00E_727C
    dw Data_00E_7280
    dw Data_00E_7282
    dw Data_00E_7282
    dw Data_00E_7286
    dw Data_00E_7286
    dw Data_00E_728E
    dw Data_00E_728E
    dw Data_00E_728E
    dw Data_00E_7292
    dw Data_00E_7296
    dw Data_00E_7298
    dw Data_00E_7298
    dw Data_00E_7298
    dw Data_00E_7298
    dw Data_00E_7298
    dw Data_00E_729C
    dw Data_00E_72A0
    dw Data_00E_72A4
    dw Data_00E_72AA
    dw Data_00E_72B4
    dw Data_00E_72B6
    dw Data_00E_72B6
    dw Data_00E_72B8
    dw Data_00E_72BA
    dw Data_00E_72BA
    dw Data_00E_72BC
    dw Data_00E_72BC
    dw Data_00E_72BC
    dw Data_00E_72BC
    dw Data_00E_72BC
    dw Data_00E_72BC
    dw Data_00E_72BC
    dw Data_00E_72BC
    dw Data_00E_72BC
    dw Data_00E_72BC
    dw Data_00E_72BE
    dw Data_00E_72C0
    dw Data_00E_72C0
    dw Data_00E_72C0
    dw Data_00E_72C2
    dw Data_00E_72C4
    dw Data_00E_72C4
    dw Data_00E_72C6
    dw Data_00E_72CA
    dw Data_00E_72CC
    dw Data_00E_72D0
    dw Data_00E_72D0
    dw Data_00E_72D2
    dw Data_00E_72D6
    dw Data_00E_72D6
    dw Data_00E_72E0
    dw Data_00E_72E4
    dw Data_00E_72E8
    dw Data_00E_72EA
    dw Data_00E_72EC
    dw Data_00E_72EE
    dw Data_00E_72F0
    dw Data_00E_72F0
    dw Data_00E_72F2
    dw Data_00E_72F8
    dw Data_00E_72FE
    dw Data_00E_72FE
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7300
    dw Data_00E_7302
    dw Data_00E_7306
    dw Data_00E_7306
    dw Data_00E_7306
    dw Data_00E_7308
    dw Data_00E_730C
    dw Data_00E_730C
    dw Data_00E_730E
    dw Data_00E_7310
    dw Data_00E_7312
    dw Data_00E_7316
    dw Data_00E_7318
    dw Data_00E_7318
    dw Data_00E_7318
    dw Data_00E_731A
    dw Data_00E_731E
    dw Data_00E_731E
    dw Data_00E_7322
    dw Data_00E_7322
    dw Data_00E_7324
    dw Data_00E_7324
    dw Data_00E_7324
    dw Data_00E_7324
    dw Data_00E_7326
    dw Data_00E_7326
    dw Data_00E_7326
    dw Data_00E_7326
    dw Data_00E_7326
    dw Data_00E_7326
    dw Data_00E_7326
    dw Data_00E_732A
    dw Data_00E_732E
    dw Data_00E_732E
    dw Data_00E_7330
    dw Data_00E_7332
    dw Data_00E_7332
    dw Data_00E_7334
    dw Data_00E_7338
    dw Data_00E_7338
    dw Data_00E_733C
    dw Data_00E_733E
    dw Data_00E_7340
    dw Data_00E_7344
    dw Data_00E_7346
    dw Data_00E_7346
    dw Data_00E_7348
    dw Data_00E_734A
    dw Data_00E_734C
    dw Data_00E_734C
    dw Data_00E_734E
    dw Data_00E_734E
    dw Data_00E_734E
    dw Data_00E_734E
    dw Data_00E_734E
    db $14, $71, $14, $71, $14, $71, $14, $71, $14, $71, $14, $71, $14, $71, $14, $71

Data_00E_7114:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_00E_7116:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $00

Data_00E_7118:: ; heuristic: target of a monotone pointer table; C0
    db $13, $00

Data_00E_711A:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $00

Data_00E_711C:: ; heuristic: target of a monotone pointer table; C0
    db $10, $00, $14, $00, $16, $00, $1A, $00

Data_00E_7124:: ; heuristic: target of a monotone pointer table; C0
    db $15, $00

Data_00E_7126:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $00

Data_00E_7128:: ; heuristic: target of a monotone pointer table; C0
    db $13, $00, $17, $00, $18, $00

Data_00E_712E:: ; heuristic: target of a monotone pointer table; C0
    db $12, $00

Data_00E_7130:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $00, $17, $00

Data_00E_7134:: ; heuristic: target of a monotone pointer table; C0
    db $10, $00, $17, $00, $18, $00

Data_00E_713A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $00

Data_00E_713C:: ; heuristic: target of a monotone pointer table; C0
    db $13, $00, $18, $00

Data_00E_7140:: ; heuristic: target of a monotone pointer table; C0
    db $19, $00

Data_00E_7142:: ; heuristic: target of a monotone pointer table; C0
    db $17, $00, $18, $00, $19, $00

Data_00E_7148:: ; heuristic: target of a monotone pointer table; C0
    db $38, $00, $2D, $00

Data_00E_714C:: ; heuristic: target of a monotone pointer table; C0
    db $35, $00, $3B, $00

Data_00E_7150:: ; heuristic: target of a monotone pointer table; C0
    db $33, $00, $3B, $00

Data_00E_7154:: ; heuristic: target of a monotone pointer table; C0
    db $30, $00, $3B, $00

Data_00E_7158:: ; heuristic: target of a monotone pointer table; C0
    db $38, $00, $3E, $00, $3F, $00

Data_00E_715E:: ; heuristic: target of a monotone pointer table; C0
    db $33, $00

Data_00E_7160:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $00, $42, $00

Data_00E_7164:: ; heuristic: target of a monotone pointer table; C0
    db $36, $00

Data_00E_7166:: ; heuristic: target of a monotone pointer table; C0
    db $3B, $00, $35, $00

Data_00E_716A:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $00, $3F, $00, $42, $00

Data_00E_7170:: ; heuristic: target of a monotone pointer table; C0
    db $3A, $00

Data_00E_7172:: ; heuristic: target of a monotone pointer table; C0
    db $3B, $00

Data_00E_7174:: ; heuristic: target of a monotone pointer table; C0
    db $33, $00, $3B, $00, $42, $00

Data_00E_717A:: ; heuristic: target of a monotone pointer table; C0
    db $33, $00, $3B, $00, $40, $00, $42, $00

Data_00E_7182:: ; heuristic: target of a monotone pointer table; C0
    db $41, $00

Data_00E_7184:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $51, $00, $5F, $00

Data_00E_718A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $5C, $00

Data_00E_718E:: ; heuristic: target of a monotone pointer table; C0
    db $65, $00

Data_00E_7190:: ; heuristic: target of a monotone pointer table; C0
    db $51, $00, $5F, $00

Data_00E_7194:: ; heuristic: target of a monotone pointer table; C0
    db $66, $00

Data_00E_7196:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $56, $00

Data_00E_719A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $66, $00

Data_00E_719E:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $5F, $00

Data_00E_71A2:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $5F, $00

Data_00E_71A6:: ; heuristic: target of a monotone pointer table; C0
    db $58, $00, $62, $00

Data_00E_71AA:: ; heuristic: target of a monotone pointer table; C0
    db $66, $00

Data_00E_71AC:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $58, $00

Data_00E_71B0:: ; heuristic: target of a monotone pointer table; C0
    db $59, $00

Data_00E_71B2:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00

Data_00E_71B4:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $56, $00

Data_00E_71B8:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $56, $00, $5F, $00

Data_00E_71BE:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $60, $00, $4C, $00

Data_00E_71C4:: ; heuristic: target of a monotone pointer table; C0
    db $64, $00

Data_00E_71C6:: ; heuristic: target of a monotone pointer table; C0
    db $56, $00, $61, $00

Data_00E_71CA:: ; heuristic: target of a monotone pointer table; C0
    db $62, $00

Data_00E_71CC:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $56, $00

Data_00E_71D0:: ; heuristic: target of a monotone pointer table; C0
    db $77, $00

Data_00E_71D2:: ; heuristic: target of a monotone pointer table; C0
    db $7A, $00

Data_00E_71D4:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $79, $00

Data_00E_71D8:: ; heuristic: target of a monotone pointer table; C0
    db $79, $00

Data_00E_71DA:: ; heuristic: target of a monotone pointer table; C0
    db $7F, $00

Data_00E_71DC:: ; heuristic: target of a monotone pointer table; C0
    db $7F, $00

Data_00E_71DE:: ; heuristic: target of a monotone pointer table; C0
    db $7A, $00, $7D, $00, $7F, $00

Data_00E_71E4:: ; heuristic: target of a monotone pointer table; C0
    db $7E, $00, $7F, $00, $81, $00

Data_00E_71EA:: ; heuristic: target of a monotone pointer table; C0
    db $7D, $00, $7E, $00

Data_00E_71EE:: ; heuristic: target of a monotone pointer table; C0
    db $7E, $00, $7F, $00

Data_00E_71F2:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $83, $00

Data_00E_71F6:: ; heuristic: target of a monotone pointer table; C0
    db $7D, $00, $83, $00

Data_00E_71FA:: ; heuristic: target of a monotone pointer table; C0
    db $7E, $00

Data_00E_71FC:: ; heuristic: target of a monotone pointer table; C0
    db $82, $00

Data_00E_71FE:: ; heuristic: target of a monotone pointer table; C0
    db $82, $00

Data_00E_7200:: ; heuristic: target of a monotone pointer table; C0
    db $78, $00, $80, $00

Data_00E_7204:: ; heuristic: target of a monotone pointer table; C0
    db $A1, $00

Data_00E_7206:: ; heuristic: target of a monotone pointer table; C0
    db $A7, $00

Data_00E_7208:: ; heuristic: target of a monotone pointer table; C0
    db $9F, $00

Data_00E_720A:: ; heuristic: target of a monotone pointer table; C0
    db $A0, $00

Data_00E_720C:: ; heuristic: target of a monotone pointer table; C0
    db $96, $00, $9B, $00

Data_00E_7210:: ; heuristic: target of a monotone pointer table; C0
    db $A3, $00

Data_00E_7212:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $A5, $00

Data_00E_7216:: ; heuristic: target of a monotone pointer table; C0
    db $99, $00

Data_00E_7218:: ; heuristic: target of a monotone pointer table; C0
    db $C9, $00

Data_00E_721A:: ; heuristic: target of a monotone pointer table; C0
    db $BF, $00, $C1, $00

Data_00E_721E:: ; heuristic: target of a monotone pointer table; C0
    db $BB, $00

Data_00E_7220:: ; heuristic: target of a monotone pointer table; C0
    db $BF, $00

Data_00E_7222:: ; heuristic: target of a monotone pointer table; C0
    db $C4, $00

Data_00E_7224:: ; heuristic: target of a monotone pointer table; C0
    db $BF, $00

Data_00E_7226:: ; heuristic: target of a monotone pointer table; C0
    db $BF, $00

Data_00E_7228:: ; heuristic: target of a monotone pointer table; C0
    db $C7, $00

Data_00E_722A:: ; heuristic: target of a monotone pointer table; C0
    db $C2, $00

Data_00E_722C:: ; heuristic: target of a monotone pointer table; C0
    db $C6, $00

Data_00E_722E:: ; heuristic: target of a monotone pointer table; C0
    db $C6, $00

Data_00E_7230:: ; heuristic: target of a monotone pointer table; C0
    db $C8, $00

Data_00E_7232:: ; heuristic: target of a monotone pointer table; C0
    db $C2, $00, $BC, $00

Data_00E_7236:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $00, $E2, $00, $E3, $00

Data_00E_723C:: ; heuristic: target of a monotone pointer table; C0
    db $E3, $00

Data_00E_723E:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $00

Data_00E_7240:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $E3, $00, $E9, $00

Data_00E_7246:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $00, $E4, $00

Data_00E_724A:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $00

Data_00E_724C:: ; heuristic: target of a monotone pointer table; C0
    db $DF, $00, $E7, $00

Data_00E_7250:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $00

Data_00E_7252:: ; heuristic: target of a monotone pointer table; C0
    db $E5, $00, $E9, $00

Data_00E_7256:: ; heuristic: target of a monotone pointer table; C0
    db $E9, $00, $F0, $00

Data_00E_725A:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $00, $E2, $00, $E3, $00, $E7, $00, $E4, $00

Data_00E_7264:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $00

Data_00E_7266:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $00, $E2, $00, $E3, $00

Data_00E_726C:: ; heuristic: target of a monotone pointer table; C0
    db $E5, $00, $EE, $00

Data_00E_7270:: ; heuristic: target of a monotone pointer table; C0
    db $EE, $00, $63, $01

Data_00E_7274:: ; heuristic: target of a monotone pointer table; C0
    db $EF, $00, $68, $01

Data_00E_7278:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $DE, $00

Data_00E_727C:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $08, $01

Data_00E_7280:: ; heuristic: target of a monotone pointer table; C0
    db $05, $01

Data_00E_7282:: ; heuristic: target of a monotone pointer table; C0
    db $09, $01, $0A, $01

Data_00E_7286:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $09, $01, $0A, $01, $06, $01

Data_00E_728E:: ; heuristic: target of a monotone pointer table; C0
    db $04, $01, $0A, $01

Data_00E_7292:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $0A, $01

Data_00E_7296:: ; heuristic: target of a monotone pointer table; C0
    db $06, $01

Data_00E_7298:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $0A, $01

Data_00E_729C:: ; heuristic: target of a monotone pointer table; C0
    db $08, $01, $10, $01

Data_00E_72A0:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $01, $62, $01

Data_00E_72A4:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $08, $01, $0A, $01

Data_00E_72AA:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $08, $01, $0B, $01, $10, $01, $10, $01

Data_00E_72B4:: ; heuristic: target of a monotone pointer table; C0
    db $5F, $01

Data_00E_72B6:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $01

Data_00E_72B8:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01

Data_00E_72BA:: ; heuristic: target of a monotone pointer table; C0
    db $08, $01

Data_00E_72BC:: ; heuristic: target of a monotone pointer table; C0
    db $26, $01

Data_00E_72BE:: ; heuristic: target of a monotone pointer table; C0
    db $2C, $01

Data_00E_72C0:: ; heuristic: target of a monotone pointer table; C0
    db $34, $01

Data_00E_72C2:: ; heuristic: target of a monotone pointer table; C0
    db $2C, $01

Data_00E_72C4:: ; heuristic: target of a monotone pointer table; C0
    db $28, $01

Data_00E_72C6:: ; heuristic: target of a monotone pointer table; C0
    db $2C, $01, $31, $01

Data_00E_72CA:: ; heuristic: target of a monotone pointer table; C0
    db $26, $01

Data_00E_72CC:: ; heuristic: target of a monotone pointer table; C0
    db $2D, $01, $2E, $01

Data_00E_72D0:: ; heuristic: target of a monotone pointer table; C0
    db $29, $01

Data_00E_72D2:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $25, $01

Data_00E_72D6:: ; heuristic: target of a monotone pointer table; C0
    db $24, $01, $2A, $01, $2E, $01, $2F, $01, $2A, $01

Data_00E_72E0:: ; heuristic: target of a monotone pointer table; C0
    db $24, $01, $2E, $01

Data_00E_72E4:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $34, $01

Data_00E_72E8:: ; heuristic: target of a monotone pointer table; C0
    db $38, $01

Data_00E_72EA:: ; heuristic: target of a monotone pointer table; C0
    db $35, $01

Data_00E_72EC:: ; heuristic: target of a monotone pointer table; C0
    db $35, $01

Data_00E_72EE:: ; heuristic: target of a monotone pointer table; C0
    db $2B, $01

Data_00E_72F0:: ; heuristic: target of a monotone pointer table; C0
    db $32, $01

Data_00E_72F2:: ; heuristic: target of a monotone pointer table; C0
    db $23, $01, $26, $01, $33, $01

Data_00E_72F8:: ; heuristic: target of a monotone pointer table; C0
    db $23, $01, $24, $01, $26, $01

Data_00E_72FE:: ; heuristic: target of a monotone pointer table; C0
    db $36, $01

Data_00E_7300:: ; heuristic: target of a monotone pointer table; C0
    db $49, $01

Data_00E_7302:: ; heuristic: target of a monotone pointer table; C0
    db $50, $01, $2B, $01

Data_00E_7306:: ; heuristic: target of a monotone pointer table; C0
    db $52, $01

Data_00E_7308:: ; heuristic: target of a monotone pointer table; C0
    db $47, $01, $48, $01

Data_00E_730C:: ; heuristic: target of a monotone pointer table; C0
    db $54, $01

Data_00E_730E:: ; heuristic: target of a monotone pointer table; C0
    db $4A, $01

Data_00E_7310:: ; heuristic: target of a monotone pointer table; C0
    db $4B, $01

Data_00E_7312:: ; heuristic: target of a monotone pointer table; C0
    db $4F, $01, $51, $01

Data_00E_7316:: ; heuristic: target of a monotone pointer table; C0
    db $4D, $01

Data_00E_7318:: ; heuristic: target of a monotone pointer table; C0
    db $55, $01

Data_00E_731A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $51, $01

Data_00E_731E:: ; heuristic: target of a monotone pointer table; C0
    db $57, $01, $53, $01

Data_00E_7322:: ; heuristic: target of a monotone pointer table; C0
    db $56, $01

Data_00E_7324:: ; heuristic: target of a monotone pointer table; C0
    db $59, $01

Data_00E_7326:: ; heuristic: target of a monotone pointer table; C0
    db $60, $01, $66, $01

Data_00E_732A:: ; heuristic: target of a monotone pointer table; C0
    db $61, $01, $66, $01

Data_00E_732E:: ; heuristic: target of a monotone pointer table; C0
    db $65, $01

Data_00E_7330:: ; heuristic: target of a monotone pointer table; C0
    db $64, $01

Data_00E_7332:: ; heuristic: target of a monotone pointer table; C0
    db $6D, $01

Data_00E_7334:: ; heuristic: target of a monotone pointer table; C0
    db $67, $01, $6E, $01

Data_00E_7338:: ; heuristic: target of a monotone pointer table; C0
    db $69, $01, $6A, $01

Data_00E_733C:: ; heuristic: target of a monotone pointer table; C0
    db $72, $01

Data_00E_733E:: ; heuristic: target of a monotone pointer table; C0
    db $6B, $01

Data_00E_7340:: ; heuristic: target of a monotone pointer table; C0
    db $6C, $01, $6E, $01

Data_00E_7344:: ; heuristic: target of a monotone pointer table; C0
    db $6E, $01

Data_00E_7346:: ; heuristic: target of a monotone pointer table; C0
    db $6F, $01

Data_00E_7348:: ; heuristic: target of a monotone pointer table; C0
    db $70, $01

Data_00E_734A:: ; heuristic: target of a monotone pointer table; C0
    db $71, $01

Data_00E_734C:: ; heuristic: target of a monotone pointer table; C0
    db $73, $01

Data_00E_734E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03B34E, $50
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_765C
    dw Data_00E_765E
    dw Data_00E_7660
    db $4E, $76, $62, $76, $64, $76, $4E, $76, $4E, $76, $4E, $76, $4E, $76, $66, $76
    db $4E, $76, $4E, $76, $4E, $76, $68, $76, $6C, $76
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_764E
    dw Data_00E_766F
    dw Data_00E_7671
    dw Data_00E_7673
    INCBIN "dwm2-cobi-us.gbc", $03B40E, $4C
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $A0, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $A2, $76
    dw Data_00E_764E
    db $A4, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $A6, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $A8, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_76AB
    db $4E, $76, $4E, $76
    dw Data_00E_76AD
    db $AF, $76, $B1, $76
    dw Data_00E_76B3
    dw Data_00E_764E
    db $B5, $76
    dw Data_00E_764E
    db $4E, $76
    dw Data_00E_76B7
    db $B9, $76
    dw Data_00E_76BB
    db $4E, $76
    dw Data_00E_76BD
    db $4E, $76
    dw Data_00E_76C0
    db $4E, $76
    dw Data_00E_76C2
    db $4E, $76
    dw Data_00E_76C5
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76
    dw Data_00E_764E
    db $4E, $76
    dw Data_00E_764E
    db $4E, $76
    dw Data_00E_764E
    db $4E, $76
    dw Data_00E_764E
    db $4E, $76
    dw Data_00E_764E
    db $C7, $76
    dw Data_00E_76C9
    db $4E, $76
    dw Data_00E_76CD
    db $CF, $76
    dw Data_00E_76D1
    db $D3, $76
    dw Data_00E_76D7
    db $4E, $76
    dw Data_00E_76DB
    db $DD, $76
    dw Data_00E_76E1
    db $4E, $76
    dw Data_00E_76E6
    db $4E, $76
    dw Data_00E_76E8
    db $ED, $76, $4E, $76, $F1, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $F3, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $F5, $76, $F8, $76
    dw Data_00E_764E
    db $FB, $76, $4E, $76
    dw Data_00E_76FD
    db $FF, $76, $4E, $76
    dw Data_00E_7702
    db $05, $77, $07, $77
    dw Data_00E_7709
    INCBIN "dwm2-cobi-us.gbc", $03B552, $5E
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $35, $77
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $37, $77
    dw Data_00E_764E
    db $4E, $76, $4E, $76
    dw Data_00E_764E
    db $3C, $77, $4E, $76
    dw Data_00E_764E
    db $4E, $76, $3E, $77
    dw Data_00E_7740
    db $4E, $76, $4E, $76
    dw Data_00E_7742
    db $44, $77, $4E, $76
    dw Data_00E_7746
    db $4E, $76, $4E, $76
    dw Data_00E_7748
    db $4E, $76, $4E, $76
    dw Data_00E_774A
    INCBIN "dwm2-cobi-us.gbc", $03B5F4, $5A

Data_00E_764E:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $02, $FF, $FE, $07, $FF, $07, $FF, $04, $06, $03, $FF, $02, $FF

Data_00E_765C:: ; heuristic: target of a monotone pointer table; C0
    db $00, $FF

Data_00E_765E:: ; heuristic: target of a monotone pointer table; C0
    db $01, $FF

Data_00E_7660:: ; heuristic: target of a monotone pointer table; C0
    db $03, $FF, $01, $FF, $00, $FF, $01, $FF, $01, $06, $00, $FF, $01, $00, $FF

Data_00E_766F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $FF

Data_00E_7671:: ; heuristic: target of a monotone pointer table; C0
    db $00, $FF

Data_00E_7673:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $FF, $0A, $FF, $01, $FF, $06, $FF, $01, $00, $FF, $00, $FF, $01, $07
    db $FF, $06, $FF, $08, $FF, $02, $FF, $02, $FF, $01, $07, $06, $FF, $02, $FF, $01
    db $07, $FF, $02, $FF, $01, $07, $FF, $00, $FF, $0A, $FF, $0A, $FF, $02, $FF, $02
    db $FF, $07, $FF, $01, $FF, $06, $07, $FF

Data_00E_76AB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $FF

Data_00E_76AD:: ; heuristic: target of a monotone pointer table; C0
    db $06, $FF, $04, $FF, $08, $FF

Data_00E_76B3:: ; heuristic: target of a monotone pointer table; C0
    db $00, $FF, $07, $FF

Data_00E_76B7:: ; heuristic: target of a monotone pointer table; C0
    db $06, $FF, $06, $FF

Data_00E_76BB:: ; heuristic: target of a monotone pointer table; C0
    db $07, $FF

Data_00E_76BD:: ; heuristic: target of a monotone pointer table; C0
    db $01, $07, $FF

Data_00E_76C0:: ; heuristic: target of a monotone pointer table; C0
    db $07, $FF

Data_00E_76C2:: ; heuristic: target of a monotone pointer table; C0
    db $06, $00, $FF

Data_00E_76C5:: ; heuristic: target of a monotone pointer table; C0
    db $06, $FF, $00, $FF

Data_00E_76C9:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $07, $FF

Data_00E_76CD:: ; heuristic: target of a monotone pointer table; C0
    db $00, $FF, $07, $FF

Data_00E_76D1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $FF, $01, $02, $07, $FF

Data_00E_76D7:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $07, $FF

Data_00E_76DB:: ; heuristic: target of a monotone pointer table; C0
    db $07, $FF, $01, $07, $02, $FF

Data_00E_76E1:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $01, $08, $FF

Data_00E_76E6:: ; heuristic: target of a monotone pointer table; C0
    db $02, $FF

Data_00E_76E8:: ; heuristic: target of a monotone pointer table; C0
    db $01, $07, $02, $08, $FF, $01, $02, $08, $FF, $02, $FF, $0A, $FF, $06, $02, $FF
    db $01, $03, $FF, $03, $FF

Data_00E_76FD:: ; heuristic: target of a monotone pointer table; C0
    db $06, $FF, $09, $03, $FF

Data_00E_7702:: ; heuristic: target of a monotone pointer table; C0
    db $01, $06, $FF, $06, $FF, $03, $FF

Data_00E_7709:: ; heuristic: target of a monotone pointer table; C0
    db $02, $FF, $02, $FF, $01, $03, $FF, $01, $06, $FF, $01, $09, $03, $FF, $01, $03
    db $FF, $06, $01, $FF, $03, $FF, $08, $FF, $06, $FF, $06, $FF, $00, $01, $03, $07
    db $05, $FF, $00, $01, $03, $FF, $06, $FF, $06, $FF, $06, $FF, $05, $FF, $02, $08
    db $01, $06, $FF, $05, $FF, $00, $FF

Data_00E_7740:: ; heuristic: target of a monotone pointer table; C0
    db $01, $FF

Data_00E_7742:: ; heuristic: target of a monotone pointer table; C0
    db $06, $FF, $06, $FF

Data_00E_7746:: ; heuristic: target of a monotone pointer table; C0
    db $06, $FF

Data_00E_7748:: ; heuristic: target of a monotone pointer table; C0
    db $00, $FF

Data_00E_774A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $0A, $FF, $00, $FF

Data_00E_774F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00E_7A4F
    dw Data_00E_7A51
    dw Data_00E_7A51
    dw Data_00E_7A51
    dw Data_00E_7A51
    dw Data_00E_7A53
    dw Data_00E_7A53
    dw Data_00E_7A53
    dw Data_00E_7A53
    dw Data_00E_7A53
    dw Data_00E_7A53
    dw Data_00E_7A53
    dw Data_00E_7A55
    dw Data_00E_7A55
    dw Data_00E_7A55
    dw Data_00E_7A55
    dw Data_00E_7A55
    dw Data_00E_7A55
    dw Data_00E_7A55
    dw Data_00E_7A55
    dw Data_00E_7A55
    dw Data_00E_7A55
    dw Data_00E_7A57
    dw Data_00E_7A57
    dw Data_00E_7A57
    dw Data_00E_7A57
    dw Data_00E_7A57
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5D
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A5F
    dw Data_00E_7A61
    dw Data_00E_7A63
    dw Data_00E_7A65
    dw Data_00E_7A65
    dw Data_00E_7A67
    dw Data_00E_7A69
    dw Data_00E_7A69
    dw Data_00E_7A69
    dw Data_00E_7A69
    dw Data_00E_7A69
    dw Data_00E_7A6B
    dw Data_00E_7A6B
    dw Data_00E_7A6B
    dw Data_00E_7A6B
    dw Data_00E_7A71
    dw Data_00E_7A75
    dw Data_00E_7A75
    dw Data_00E_7A75
    dw Data_00E_7A75
    dw Data_00E_7A75
    dw Data_00E_7A75
    dw Data_00E_7A75
    dw Data_00E_7A77
    dw Data_00E_7A79
    dw Data_00E_7A7D
    dw Data_00E_7A7D
    dw Data_00E_7A7F
    dw Data_00E_7A7F
    dw Data_00E_7A81
    dw Data_00E_7A81
    dw Data_00E_7A83
    dw Data_00E_7A87
    dw Data_00E_7A87
    dw Data_00E_7A87
    dw Data_00E_7A87
    dw Data_00E_7A89
    dw Data_00E_7A8D
    dw Data_00E_7A8F
    dw Data_00E_7A8F
    dw Data_00E_7A91
    dw Data_00E_7A91
    dw Data_00E_7A91
    dw Data_00E_7A91
    dw Data_00E_7A91
    dw Data_00E_7A91
    dw Data_00E_7A93
    dw Data_00E_7A95
    dw Data_00E_7A95
    dw Data_00E_7A9B
    dw Data_00E_7A9D
    dw Data_00E_7AA1
    dw Data_00E_7AA3
    dw Data_00E_7AA3
    dw Data_00E_7AA7
    dw Data_00E_7AA7
    dw Data_00E_7AA9
    dw Data_00E_7AA9
    dw Data_00E_7AA9
    dw Data_00E_7AAB
    dw Data_00E_7AAB
    dw Data_00E_7AAD
    dw Data_00E_7AAD
    dw Data_00E_7AAD
    dw Data_00E_7AAD
    dw Data_00E_7AAD
    dw Data_00E_7AAD
    dw Data_00E_7AAD
    dw Data_00E_7AAD
    dw Data_00E_7AAD
    dw Data_00E_7AAD
    dw Data_00E_7AAF
    dw Data_00E_7AAF
    dw Data_00E_7AAF
    dw Data_00E_7AAF
    dw Data_00E_7AAF
    dw Data_00E_7AAF
    dw Data_00E_7AAF
    dw Data_00E_7AB1
    dw Data_00E_7AB1
    dw Data_00E_7AB3
    dw Data_00E_7AB3
    dw Data_00E_7AB3
    dw Data_00E_7AB3
    dw Data_00E_7AB3
    dw Data_00E_7AB3
    dw Data_00E_7AB5
    dw Data_00E_7AB5
    dw Data_00E_7AB5
    dw Data_00E_7AB5
    dw Data_00E_7AB5
    dw Data_00E_7AB5
    dw Data_00E_7AB5
    dw Data_00E_7AB5
    dw Data_00E_7AB5
    dw Data_00E_7AB5
    dw Data_00E_7AB9
    dw Data_00E_7AB9
    dw Data_00E_7AB9
    dw Data_00E_7AB9
    dw Data_00E_7AB9
    dw Data_00E_7AB9
    dw Data_00E_7AB9
    dw Data_00E_7AB9
    dw Data_00E_7AB9
    dw Data_00E_7AB9
    dw Data_00E_7ABB
    dw Data_00E_7ABB
    dw Data_00E_7ABB
    dw Data_00E_7ABD
    dw Data_00E_7ABF
    dw Data_00E_7AC1
    dw Data_00E_7AC3
    dw Data_00E_7AC3
    dw Data_00E_7AC5
    dw Data_00E_7AC5
    dw Data_00E_7AC5
    dw Data_00E_7AC7
    dw Data_00E_7AC9
    dw Data_00E_7ACB
    dw Data_00E_7ACB
    dw Data_00E_7ACF
    dw Data_00E_7ACF
    dw Data_00E_7AD1
    dw Data_00E_7AD1
    dw Data_00E_7AD5
    dw Data_00E_7AD5
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD7
    dw Data_00E_7AD9
    dw Data_00E_7ADF
    dw Data_00E_7ADF
    dw Data_00E_7AE1
    dw Data_00E_7AE3
    dw Data_00E_7AE5
    dw Data_00E_7AEB
    dw Data_00E_7AF1
    dw Data_00E_7AF1
    dw Data_00E_7AF3
    dw Data_00E_7AF9
    dw Data_00E_7B01
    dw Data_00E_7B01
    dw Data_00E_7B03
    dw Data_00E_7B03
    dw Data_00E_7B0B
    dw Data_00E_7B11
    dw Data_00E_7B11
    dw Data_00E_7B13
    dw Data_00E_7B13
    dw Data_00E_7B13
    dw Data_00E_7B13
    dw Data_00E_7B13
    dw Data_00E_7B13
    dw Data_00E_7B15
    dw Data_00E_7B15
    dw Data_00E_7B15
    dw Data_00E_7B15
    dw Data_00E_7B15
    dw Data_00E_7B15
    dw Data_00E_7B15
    dw Data_00E_7B15
    dw Data_00E_7B15
    dw Data_00E_7B15
    dw Data_00E_7B15
    dw Data_00E_7B19
    dw Data_00E_7B1D
    dw Data_00E_7B1D
    dw Data_00E_7B1F
    dw Data_00E_7B1F
    dw Data_00E_7B21
    dw Data_00E_7B25
    dw Data_00E_7B25
    dw Data_00E_7B29
    dw Data_00E_7B2B
    dw Data_00E_7B2D
    dw Data_00E_7B2F
    dw Data_00E_7B2F
    dw Data_00E_7B2F
    dw Data_00E_7B2F
    dw Data_00E_7B31
    dw Data_00E_7B31
    dw Data_00E_7B35
    dw Data_00E_7B39
    dw Data_00E_7B3F
    dw Data_00E_7B43
    dw Data_00E_7B43
    dw Data_00E_7B43
    dw Data_00E_7B43
    dw Data_00E_7B47
    dw Data_00E_7B49
    dw Data_00E_7B49
    dw Data_00E_7B49
    dw Data_00E_7B49
    dw Data_00E_7B49
    dw Data_00E_7B49
    dw Data_00E_7B49
    dw Data_00E_7B49
    dw Data_00E_7B49
    dw Data_00E_7B49
    dw Data_00E_7B4B
    dw Data_00E_7B4B
    dw Data_00E_7B4B
    dw Data_00E_7B4B
    dw Data_00E_7B4B
    dw Data_00E_7B4B
    dw Data_00E_7B4B
    dw Data_00E_7B4D
    dw Data_00E_7B4F
    dw Data_00E_7B4F
    dw Data_00E_7B4F
    dw Data_00E_7B4F
    dw Data_00E_7B4F
    dw Data_00E_7B4F
    dw Data_00E_7B4F
    dw Data_00E_7B4F
    dw Data_00E_7B59
    dw Data_00E_7B5F
    dw Data_00E_7B5F
    dw Data_00E_7B61
    dw Data_00E_7B63
    dw Data_00E_7B65
    dw Data_00E_7B65
    dw Data_00E_7B65
    dw Data_00E_7B65
    dw Data_00E_7B65
    dw Data_00E_7B65
    dw Data_00E_7B65
    dw Data_00E_7B65
    dw Data_00E_7B67
    dw Data_00E_7B67
    dw Data_00E_7B67
    dw Data_00E_7B67
    dw Data_00E_7B67
    dw Data_00E_7B67
    dw Data_00E_7B6F
    dw Data_00E_7B6F
    dw Data_00E_7B6F
    dw Data_00E_7B6F
    dw Data_00E_7B6F
    dw Data_00E_7B71
    dw Data_00E_7B71
    dw Data_00E_7B71
    dw Data_00E_7B71
    dw Data_00E_7B73
    dw Data_00E_7B75
    dw Data_00E_7B75
    dw Data_00E_7B75
    dw Data_00E_7B77
    dw Data_00E_7B79
    dw Data_00E_7B79
    dw Data_00E_7B7B
    dw Data_00E_7B7B
    dw Data_00E_7B7B
    dw Data_00E_7B7D
    dw Data_00E_7B7D
    dw Data_00E_7B7D
    dw Data_00E_7B81
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    dw Data_00E_7B83
    db $4F, $7A, $4F, $7A, $4F, $7A, $4F, $7A, $4F, $7A, $4F, $7A, $4F, $7A, $4F, $7A

Data_00E_7A4F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_00E_7A51:: ; heuristic: target of a monotone pointer table; C0
    db $14, $00

Data_00E_7A53:: ; heuristic: target of a monotone pointer table; C0
    db $16, $00

Data_00E_7A55:: ; heuristic: target of a monotone pointer table; C0
    db $16, $00

Data_00E_7A57:: ; heuristic: target of a monotone pointer table; C0
    db $14, $00, $15, $00, $16, $00

Data_00E_7A5D:: ; heuristic: target of a monotone pointer table; C0
    db $2F, $00

Data_00E_7A5F:: ; heuristic: target of a monotone pointer table; C0
    db $5C, $00

Data_00E_7A61:: ; heuristic: target of a monotone pointer table; C0
    db $5E, $00

Data_00E_7A63:: ; heuristic: target of a monotone pointer table; C0
    db $4E, $00

Data_00E_7A65:: ; heuristic: target of a monotone pointer table; C0
    db $50, $00

Data_00E_7A67:: ; heuristic: target of a monotone pointer table; C0
    db $5C, $00

Data_00E_7A69:: ; heuristic: target of a monotone pointer table; C0
    db $5F, $00

Data_00E_7A6B:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $4C, $00, $5C, $00

Data_00E_7A71:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $5C, $00

Data_00E_7A75:: ; heuristic: target of a monotone pointer table; C0
    db $5C, $00

Data_00E_7A77:: ; heuristic: target of a monotone pointer table; C0
    db $5C, $00

Data_00E_7A79:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $5C, $00

Data_00E_7A7D:: ; heuristic: target of a monotone pointer table; C0
    db $64, $00

Data_00E_7A7F:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00

Data_00E_7A81:: ; heuristic: target of a monotone pointer table; C0
    db $59, $00

Data_00E_7A83:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $51, $00

Data_00E_7A87:: ; heuristic: target of a monotone pointer table; C0
    db $73, $00

Data_00E_7A89:: ; heuristic: target of a monotone pointer table; C0
    db $78, $00, $78, $00

Data_00E_7A8D:: ; heuristic: target of a monotone pointer table; C0
    db $77, $00

Data_00E_7A8F:: ; heuristic: target of a monotone pointer table; C0
    db $74, $00

Data_00E_7A91:: ; heuristic: target of a monotone pointer table; C0
    db $7A, $00

Data_00E_7A93:: ; heuristic: target of a monotone pointer table; C0
    db $84, $00

Data_00E_7A95:: ; heuristic: target of a monotone pointer table; C0
    db $78, $00, $78, $00, $79, $00

Data_00E_7A9B:: ; heuristic: target of a monotone pointer table; C0
    db $84, $00

Data_00E_7A9D:: ; heuristic: target of a monotone pointer table; C0
    db $78, $00, $78, $00

Data_00E_7AA1:: ; heuristic: target of a monotone pointer table; C0
    db $84, $00

Data_00E_7AA3:: ; heuristic: target of a monotone pointer table; C0
    db $78, $00, $78, $00

Data_00E_7AA7:: ; heuristic: target of a monotone pointer table; C0
    db $77, $00

Data_00E_7AA9:: ; heuristic: target of a monotone pointer table; C0
    db $82, $00

Data_00E_7AAB:: ; heuristic: target of a monotone pointer table; C0
    db $82, $00

Data_00E_7AAD:: ; heuristic: target of a monotone pointer table; C0
    db $98, $00

Data_00E_7AAF:: ; heuristic: target of a monotone pointer table; C0
    db $96, $00

Data_00E_7AB1:: ; heuristic: target of a monotone pointer table; C0
    db $A1, $00

Data_00E_7AB3:: ; heuristic: target of a monotone pointer table; C0
    db $9B, $00

Data_00E_7AB5:: ; heuristic: target of a monotone pointer table; C0
    db $9D, $00, $9E, $00

Data_00E_7AB9:: ; heuristic: target of a monotone pointer table; C0
    db $B9, $00

Data_00E_7ABB:: ; heuristic: target of a monotone pointer table; C0
    db $BE, $00

Data_00E_7ABD:: ; heuristic: target of a monotone pointer table; C0
    db $BB, $00

Data_00E_7ABF:: ; heuristic: target of a monotone pointer table; C0
    db $BC, $00

Data_00E_7AC1:: ; heuristic: target of a monotone pointer table; C0
    db $BF, $00

Data_00E_7AC3:: ; heuristic: target of a monotone pointer table; C0
    db $C1, $00

Data_00E_7AC5:: ; heuristic: target of a monotone pointer table; C0
    db $C9, $00

Data_00E_7AC7:: ; heuristic: target of a monotone pointer table; C0
    db $C4, $00

Data_00E_7AC9:: ; heuristic: target of a monotone pointer table; C0
    db $C1, $00

Data_00E_7ACB:: ; heuristic: target of a monotone pointer table; C0
    db $BC, $00, $C1, $00

Data_00E_7ACF:: ; heuristic: target of a monotone pointer table; C0
    db $C2, $00

Data_00E_7AD1:: ; heuristic: target of a monotone pointer table; C0
    db $C4, $00, $C5, $00

Data_00E_7AD5:: ; heuristic: target of a monotone pointer table; C0
    db $C3, $00

Data_00E_7AD7:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00

Data_00E_7AD9:: ; heuristic: target of a monotone pointer table; C0
    db $D5, $00, $E6, $00, $EA, $00

Data_00E_7ADF:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00

Data_00E_7AE1:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $00

Data_00E_7AE3:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00

Data_00E_7AE5:: ; heuristic: target of a monotone pointer table; C0
    db $D5, $00, $E6, $00, $EA, $00

Data_00E_7AEB:: ; heuristic: target of a monotone pointer table; C0
    db $D5, $00, $E6, $00, $EA, $00

Data_00E_7AF1:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $00

Data_00E_7AF3:: ; heuristic: target of a monotone pointer table; C0
    db $D5, $00, $D4, $00, $E6, $00

Data_00E_7AF9:: ; heuristic: target of a monotone pointer table; C0
    db $DF, $00, $E0, $00, $EB, $00, $EC, $00

Data_00E_7B01:: ; heuristic: target of a monotone pointer table; C0
    db $E5, $00

Data_00E_7B03:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $00, $E3, $00, $EB, $00, $EC, $00

Data_00E_7B0B:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $00, $EB, $00, $EC, $00

Data_00E_7B11:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $00

Data_00E_7B13:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $00

Data_00E_7B15:: ; heuristic: target of a monotone pointer table; C0
    db $03, $01, $FF, $00

Data_00E_7B19:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $00, $0E, $01

Data_00E_7B1D:: ; heuristic: target of a monotone pointer table; C0
    db $02, $01

Data_00E_7B1F:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01

Data_00E_7B21:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $0E, $01

Data_00E_7B25:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $00, $FC, $00

Data_00E_7B29:: ; heuristic: target of a monotone pointer table; C0
    db $03, $01

Data_00E_7B2B:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $01

Data_00E_7B2D:: ; heuristic: target of a monotone pointer table; C0
    db $05, $01

Data_00E_7B2F:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $01

Data_00E_7B31:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $00, $0E, $01

Data_00E_7B35:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $00, $0B, $01

Data_00E_7B39:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $00, $06, $01, $0E, $01

Data_00E_7B3F:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $00, $0E, $01

Data_00E_7B43:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $0A, $01

Data_00E_7B47:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $01

Data_00E_7B49:: ; heuristic: target of a monotone pointer table; C0
    db $22, $01

Data_00E_7B4B:: ; heuristic: target of a monotone pointer table; C0
    db $37, $01

Data_00E_7B4D:: ; heuristic: target of a monotone pointer table; C0
    db $23, $01

Data_00E_7B4F:: ; heuristic: target of a monotone pointer table; C0
    db $37, $01, $24, $01, $27, $01, $2F, $01, $34, $01

Data_00E_7B59:: ; heuristic: target of a monotone pointer table; C0
    db $37, $01, $24, $01, $27, $01

Data_00E_7B5F:: ; heuristic: target of a monotone pointer table; C0
    db $2B, $01

Data_00E_7B61:: ; heuristic: target of a monotone pointer table; C0
    db $25, $01

Data_00E_7B63:: ; heuristic: target of a monotone pointer table; C0
    db $25, $01

Data_00E_7B65:: ; heuristic: target of a monotone pointer table; C0
    db $34, $01

Data_00E_7B67:: ; heuristic: target of a monotone pointer table; C0
    db $45, $01, $46, $01, $4E, $01, $4E, $01

Data_00E_7B6F:: ; heuristic: target of a monotone pointer table; C0
    db $49, $01

Data_00E_7B71:: ; heuristic: target of a monotone pointer table; C0
    db $5B, $01

Data_00E_7B73:: ; heuristic: target of a monotone pointer table; C0
    db $48, $01

Data_00E_7B75:: ; heuristic: target of a monotone pointer table; C0
    db $4A, $01

Data_00E_7B77:: ; heuristic: target of a monotone pointer table; C0
    db $4B, $01

Data_00E_7B79:: ; heuristic: target of a monotone pointer table; C0
    db $4D, $01

Data_00E_7B7B:: ; heuristic: target of a monotone pointer table; C0
    db $5B, $01

Data_00E_7B7D:: ; heuristic: target of a monotone pointer table; C0
    db $5B, $01, $53, $01

Data_00E_7B81:: ; heuristic: target of a monotone pointer table; C0
    db $5B, $01

Data_00E_7B83:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00E_7B99
    dw Data_00E_7BCD
    dw Data_00E_7C1F
    dw Data_00E_7C65
    dw Data_00E_7CAF
    dw Data_00E_7CED
    dw Data_00E_7D17
    dw Data_00E_7D39
    dw Data_00E_7D73
    dw Data_00E_7DA9
    dw Data_00E_7DBD

Data_00E_7B99:: ; heuristic: target of a monotone pointer table; C0
    db $2A, $00, $BE, $00, $FD, $FD, $4A, $00, $80, $00, $8D, $00, $0D, $01, $FD, $FD
    db $48, $00, $4C, $00, $5F, $00, $60, $00, $61, $00, $62, $00, $FD, $FD, $FC, $00
    db $32, $01, $33, $01, $34, $01, $FD, $FD, $29, $01, $FD, $FD, $4D, $00, $FD, $FD
    db $24, $01, $FF, $FF

Data_00E_7BCD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03BBCD, $52

Data_00E_7C1F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03BC1F, $46

Data_00E_7C65:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03BC65, $4A

Data_00E_7CAF:: ; heuristic: target of a monotone pointer table; C0
    db $B2, $00, $40, $01, $FD, $FD, $1D, $01, $FD, $FD, $D3, $00, $FD, $FD, $92, $00
    db $FD, $FD, $01, $01, $FD, $FD, $80, $00, $FD, $FD, $4A, $00, $47, $01, $FD, $FD
    db $0D, $00, $63, $00, $6E, $00, $74, $00, $B3, $00, $BD, $00, $D7, $00, $D8, $00
    db $1F, $01, $49, $01, $FD, $FD, $B6, $00, $BF, $00, $41, $01, $FF, $FF

Data_00E_7CED:: ; heuristic: target of a monotone pointer table; C0
    db $8F, $00, $FD, $FD, $52, $00, $FD, $FD, $94, $00, $45, $01, $49, $01, $FD, $FD
    db $4B, $00, $3F, $01, $FD, $FD, $F6, $00, $FD, $FD, $FB, $00, $4B, $01, $FD, $FD
    db $5B, $00, $FD, $FD, $DC, $00, $03, $01, $FF, $FF

Data_00E_7D17:: ; heuristic: target of a monotone pointer table; C0
    db $29, $00, $FD, $FD, $61, $00, $FD, $FD, $9D, $00, $FD, $FD, $54, $00, $FD, $FD
    db $2F, $00, $59, $00, $FD, $FD, $20, $01, $FD, $FD, $63, $00, $FD, $FD, $BC, $00
    db $FF, $FF

Data_00E_7D39:: ; heuristic: target of a monotone pointer table; C0
    db $2B, $00, $30, $00, $33, $00, $38, $00, $3C, $00, $3D, $00, $40, $00, $FD, $FD
    db $49, $01, $4A, $01, $4B, $01, $FD, $FD, $08, $00, $0C, $00, $47, $00, $56, $00
    db $80, $00, $8D, $00, $98, $00, $B0, $00, $B6, $00, $BF, $00, $FD, $FD, $71, $00
    db $FD, $FD, $4E, $00, $FD, $FD, $B4, $00, $FF, $FF

Data_00E_7D73:: ; heuristic: target of a monotone pointer table; C0
    db $DD, $00, $FD, $FD, $B6, $00, $FD, $FD, $33, $00, $FD, $FD, $B5, $00, $FD, $FD
    db $90, $00, $FD, $FD, $4C, $00, $55, $00, $5F, $00, $60, $00, $D9, $00, $FD, $FD
    db $05, $00, $FD, $FD, $08, $00, $FD, $FD, $73, $00, $FD, $FD, $C4, $00, $C7, $00
    db $FD, $FD, $EC, $00, $FF, $FF

Data_00E_7DA9:: ; heuristic: target of a monotone pointer table; C0
    db $19, $01, $FD, $FD, $53, $00, $6E, $00, $6F, $00, $78, $00, $84, $00, $1E, $01
    db $34, $01, $FF, $FF

Data_00E_7DBD:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_00E_7DBF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00E_7DD5
    dw Data_00E_7DE3
    dw Data_00E_7DFF
    dw Data_00E_7E1B
    dw Data_00E_7E2B
    dw Data_00E_7E3D
    dw Data_00E_7E4D
    dw Data_00E_7E5D
    dw Data_00E_7E69
    dw Data_00E_7E7F
    dw Data_00E_7E83

Data_00E_7DD5:: ; heuristic: target of a monotone pointer table; C0
    db $07, $00, $0B, $00, $0C, $00, $0D, $00, $0E, $00, $0F, $00, $11, $00

Data_00E_7DE3:: ; heuristic: target of a monotone pointer table; C0
    db $2E, $00, $2F, $00, $30, $00, $31, $00, $32, $00, $33, $00, $34, $00, $35, $00
    db $36, $00, $37, $00, $38, $00, $39, $00, $3D, $00, $3E, $00

Data_00E_7DFF:: ; heuristic: target of a monotone pointer table; C0
    db $51, $00, $52, $00, $53, $00, $54, $00, $55, $00, $57, $00, $59, $00, $5A, $00
    db $5B, $00, $5C, $00, $5D, $00, $5E, $00, $62, $00, $63, $00

Data_00E_7E1B:: ; heuristic: target of a monotone pointer table; C0
    db $74, $00, $76, $00, $78, $00, $79, $00, $7B, $00, $7C, $00, $7F, $00, $80, $00

Data_00E_7E2B:: ; heuristic: target of a monotone pointer table; C0
    db $97, $00, $98, $00, $99, $00, $9A, $00, $9B, $00, $9C, $00, $9D, $00, $9E, $00
    db $A6, $00

Data_00E_7E3D:: ; heuristic: target of a monotone pointer table; C0
    db $BB, $00, $BC, $00, $BD, $00, $BE, $00, $BF, $00, $C0, $00, $C1, $00, $C5, $00

Data_00E_7E4D:: ; heuristic: target of a monotone pointer table; C0
    db $DF, $00, $E0, $00, $E1, $00, $E2, $00, $E6, $00, $E8, $00, $EA, $00, $EC, $00

Data_00E_7E5D:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $00, $FB, $00, $00, $01, $01, $01, $02, $01, $03, $01

Data_00E_7E69:: ; heuristic: target of a monotone pointer table; C0
    db $21, $01, $23, $01, $24, $01, $26, $01, $27, $01, $29, $01, $2B, $01, $2F, $01
    db $30, $01, $33, $01, $37, $01

Data_00E_7E7F:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $01, $5A, $01

Data_00E_7E83:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00E_7E99
    dw Data_00E_7EAF
    dw Data_00E_7EC5
    dw Data_00E_7EDB
    dw Data_00E_7EF1
    dw Data_00E_7F07
    dw Data_00E_7F1D
    dw Data_00E_7F33
    dw Data_00E_7F49
    dw Data_00E_7F5F
    dw Data_00E_7F75

Data_00E_7E99:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $01, $00, $02, $00, $03, $00, $04, $00, $05, $00, $06, $00, $07, $00
    db $08, $00, $09, $00, $10, $00

Data_00E_7EAF:: ; heuristic: target of a monotone pointer table; C0
    db $24, $00, $FF, $FF, $25, $00, $26, $00, $27, $00, $28, $00, $29, $00, $2A, $00
    db $2B, $00, $2C, $00, $3C, $00

Data_00E_7EC5:: ; heuristic: target of a monotone pointer table; C0
    db $47, $00, $48, $00, $FF, $FF, $49, $00, $4A, $00, $4B, $00, $55, $00, $4D, $00
    db $4E, $00, $4F, $00, $61, $00

Data_00E_7EDB:: ; heuristic: target of a monotone pointer table; C0
    db $6A, $00, $6B, $00, $6C, $00, $FF, $FF, $6D, $00, $6E, $00, $6F, $00, $70, $00
    db $71, $00, $72, $00, $7D, $00

Data_00E_7EF1:: ; heuristic: target of a monotone pointer table; C0
    db $8D, $00, $8E, $00, $8F, $00, $90, $00, $FF, $FF, $91, $00, $92, $00, $93, $00
    db $94, $00, $95, $00, $A2, $00

Data_00E_7F07:: ; heuristic: target of a monotone pointer table; C0
    db $B0, $00, $B1, $00, $B2, $00, $B3, $00, $B4, $00, $FF, $FF, $B5, $00, $B6, $00
    db $B7, $00, $B8, $00, $C7, $00

Data_00E_7F1D:: ; heuristic: target of a monotone pointer table; C0
    db $D3, $00, $D4, $00, $DD, $00, $D6, $00, $D7, $00, $D8, $00, $FF, $FF, $D9, $00
    db $DA, $00, $DB, $00, $DE, $00

Data_00E_7F33:: ; heuristic: target of a monotone pointer table; C0
    db $F6, $00, $0E, $01, $F8, $00, $F9, $00, $FA, $00, $FB, $00, $FC, $00, $FF, $FF
    db $FD, $00, $FE, $00, $08, $01

Data_00E_7F49:: ; heuristic: target of a monotone pointer table; C0
    db $19, $01, $1A, $01, $1B, $01, $1C, $01, $1D, $01, $1E, $01, $1F, $01, $20, $01
    db $FF, $FF, $28, $01, $25, $01

Data_00E_7F5F:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $01, $3D, $01, $3E, $01, $3F, $01, $40, $01, $41, $01, $42, $01, $44, $01
    db $43, $01, $FF, $FF, $58, $01

Data_00E_7F75:: ; heuristic: target of a monotone pointer table; C0
    ds $16, $FF
    INCBIN "dwm2-cobi-us.gbc", $03BF8B, $62
    ds $13, $00
