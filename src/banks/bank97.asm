SECTION "Bank 97", ROMX[$4000], BANK[$97]
    db $97

Func_097_4001::
    ld de, Data_097_4095
    ld a, [wC529]
    sub a, $DA
    ld [wC529], a
    call Func_000_25C9
    ret

Func_097_4010:: ; heuristic: follows a terminator; C0
    ld de, Data_097_4095
    ld a, [wC529]
    sub a, $DA
    ld [wC529], a
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Func_097_4026::
    ld de, Data_097_474A
    ld a, [wC529]
    sub a, $8E
    ld [wC529], a
    call Func_000_25C9
    ret

Func_097_4035:: ; heuristic: follows a terminator; C0
    ld de, Data_097_474A
    ld a, [wC529]
    sub a, $8E
    ld [wC529], a
    call Func_000_25FE
    ret
    db $CD, $26, $40, $CD, $11, $26, $C9

Func_097_404B::
    ld de, Data_097_5BBF
    ld a, [wC529]
    sub a, $95
    ld [wC529], a
    call Func_000_25C9
    ret

Func_097_405A:: ; heuristic: follows a terminator; C0
    ld de, Data_097_5BBF
    ld a, [wC529]
    sub a, $95
    ld [wC529], a
    call Func_000_25FE
    ret
    db $CD, $4B, $40, $CD, $11, $26, $C9

Func_097_4070::
    ld de, Data_097_6DC1
    ld a, [wC529]
    sub a, $C7
    ld [wC529], a
    call Func_000_25C9
    ret

Func_097_407F:: ; heuristic: follows a terminator; C0
    ld de, Data_097_6DC1
    ld a, [wC529]
    sub a, $C7
    ld [wC529], a
    call Func_000_25FE
    ret
    db $CD, $70, $40, $CD, $11, $26, $C9

Data_097_4095:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_097_4097

Data_097_4097:: ; heuristic: target of a monotone pointer table; C0
    dw Data_097_40E3
    dw Data_097_4124
    dw Data_097_416A
    dw Data_097_41AE
    dw Data_097_41EC
    dw Data_097_421F
    dw Data_097_425E
    dw Data_097_42A7
    dw Data_097_42ED
    dw Data_097_4311
    dw Data_097_434E
    dw Data_097_4392
    dw Data_097_43B4
    dw Data_097_43D9
    dw Data_097_4416
    dw Data_097_445D
    dw Data_097_4495
    dw Data_097_44D6
    dw Data_097_44FA
    dw Data_097_451E
    dw Data_097_4561
    dw Data_097_45AA
    dw Data_097_45F7
    dw Data_097_45F7
    dw Data_097_45F7
    dw Data_097_45F7
    dw Data_097_4618
    dw Data_097_4635
    dw Data_097_4659
    dw Data_097_4659
    dw Data_097_4659
    dw Data_097_4659
    dw Data_097_4659
    dw Data_097_467B
    dw Data_097_4684
    dw Data_097_46CC
    dw Data_097_46FF
    dw Data_097_4737

Data_097_40E3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C0E3, $41

Data_097_4124:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C124, $46

Data_097_416A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C16A, $44

Data_097_41AE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $28, $37, $90, $30, $28, $90, $36, $2B, $32, $3A, $90, $3C
    db $32, $38, $F1, $3A, $2B, $3C, $90, $3C, $32, $38, $35, $90, $30, $32, $31, $36
    db $37, $28, $35, $36, $FA, $F7, $EF, $EE, $26, $24, $31, $41, $90, $36, $37, $32
    db $33, $90, $36, $2B, $24, $2E, $2C, $31, $2A, $99, $EF, $EE, $F7, $F0

Data_097_41EC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $90, $26, $24, $31, $90, $26, $32, $31, $31, $28, $26
    db $37, $F1, $32, $31, $2F, $3C, $90, $2C, $31, $90, $25, $24, $37, $37, $2F, $28
    db $B5, $FA, $F7, $EF, $EE, $10, $28, $37, $90, $35, $28, $24, $27, $3C, $99, $EF
    db $EE, $F7, $F0

Data_097_421F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $32, $3A, $28, $35, $90, $2C, $36, $90, $37, $2B, $28, $F1
    db $25, $24, $36, $2C, $36, $90, $32, $29, $90, $24, $2F, $2F, $99, $FA, $F7, $EF
    db $EE, $22, $32, $38, $35, $90, $3A, $32, $35, $27, $36, $90, $24, $35, $28, $EF
    db $EE, $30, $28, $24, $31, $2C, $31, $2A, $2F, $28, $36, $36, $99, $F7, $F0

Data_097_425E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C25E, $49

Data_097_42A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C2A7, $46

Data_097_42ED:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0C, $32, $38, $35, $24, $2A, $28, $90, $24, $2F, $32, $31, $28
    db $F1, $3A, $32, $31, $41, $90, $2F, $28, $37, $90, $3C, $32, $38, $90, $3A, $2C
    db $31, $99, $F7, $F0

Data_097_4311:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $32, $90, $2F, $32, $31, $2A, $90, $24, $36, $90, $12, $F1
    db $36, $37, $24, $31, $27, $AB, $90, $31, $32, $90, $32, $31, $28, $AB, $90, $25
    db $38, $37, $FA, $F7, $EF, $EE, $31, $32, $90, $32, $31, $28, $90, $2A, $28, $37
    db $36, $90, $25, $3C, $EF, $EE, $2B, $28, $35, $28, $99, $F7, $F0

Data_097_434E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C34E, $44

Data_097_4392:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $98, $90, $12, $3F, $90, $25, $38, $36, $3C
    db $99, $F1, $16, $24, $2E, $28, $90, $2C, $37, $90, $34, $38, $2C, $26, $2E, $99
    db $F7, $F0

Data_097_43B4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0C, $38, $35, $36, $28, $90, $3C, $32, $38, $35, $90, $2F, $38
    db $26, $2E, $F1, $29, $32, $35, $90, $26, $32, $30, $2C, $31, $2A, $90, $2B, $28
    db $35, $28, $99, $F7, $F0

Data_097_43D9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $37, $2B, $2C, $31, $2E, $90, $12, $F1, $2F
    db $32, $32, $2E, $90, $3A, $28, $24, $2E, $99, $90, $0D, $32, $31, $41, $FA, $F7
    db $EF, $EE, $3C, $32, $38, $90, $27, $28, $31, $3C, $90, $2C, $37, $99, $EF, $EE
    db $12, $90, $26, $24, $31, $90, $37, $28, $2F, $2F, $99, $F7, $F0

Data_097_4416:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C416, $47

Data_097_445D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $3C, $24, $2B, $3C, $24, $2B, $3C, $24, $99, $F1, $FA, $F7
    db $EF, $EE, $F3, $0A, $31, $32, $37, $2B, $28, $35, $90, $3A, $28, $24, $2E, $2F
    db $2C, $31, $2A, $EF, $EE, $26, $32, $30, $28, $90, $37, $32, $90, $24, $30, $38
    db $36, $28, $90, $30, $28, $99, $F7, $F0

Data_097_4495:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C495, $41

Data_097_44D6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $35, $3C, $90, $37, $32, $90, $2E, $28, $28, $33, $90, $30
    db $28, $F1, $24, $30, $38, $36, $28, $27, $90, $24, $37, $90, $2F, $28, $24, $36
    db $37, $B5, $F7, $F0

Data_097_44FA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $24, $2B, $99, $90, $22, $32, $38, $40, $28, $90, $37, $32
    db $32, $F1, $3A, $28, $24, $2E, $90, $37, $32, $90, $37, $24, $2E, $28, $90, $30
    db $28, $99, $F7, $F0

Data_097_451E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C51E, $43

Data_097_4561:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C561, $49

Data_097_45AA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C5AA, $4D

Data_097_45F7:: ; heuristic: target of a monotone pointer table; C0
    db $10, $28, $37, $90, $24, $90, $37, $28, $31, $37, $2B, $90, $32, $29, $29, $F1
    db $37, $2B, $28, $90, $36, $2B, $32, $33, $90, $33, $35, $2C, $26, $28, $36, $B5
    db $F0

Data_097_4618:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $36, $28, $90, $37, $32, $90, $26, $35, $28, $24, $37, $28, $90, $24, $F1
    db $27, $32, $32, $35, $90, $36, $2B, $35, $2C, $31, $28, $B5, $F0

Data_097_4635:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $2C, $36, $90, $24, $31, $90, $2C, $37, $28, $30, $90, $3A, $2C
    db $37, $2B, $F1, $24, $90, $30, $24, $2A, $2C, $26, $24, $2F, $90, $33, $32, $3A
    db $28, $35, $B5, $F0

Data_097_4659:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2F, $2F, $32, $99, $90, $20, $2B, $24, $37, $90, $26
    db $24, $31, $F1, $12, $90, $27, $32, $90, $29, $32, $35, $90, $3C, $32, $38, $98
    db $F7, $F0

Data_097_467B:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $11, $0E, $90, $0E, $17, $0D, $A4, $F0

Data_097_4684:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C684, $48

Data_097_46CC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $3C, $AB, $90, $37, $2B, $24, $37, $3E, $90, $30, $2C
    db $31, $28, $99, $F1, $FA, $F7, $EF, $EE, $F9, $00, $90, $32, $25, $37, $24, $2C
    db $31, $28, $27, $90, $24, $EF, $EE, $1D, $2C, $31, $3C, $16, $28, $27, $24, $2F
    db $B5, $F7, $F0

Data_097_46FF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $1D, $28, $35, $35, $3C, $A3, $90, $11, $28, $35, $28, $AB, $90, $2D, $38
    db $36, $37, $F1, $37, $24, $2E, $28, $90, $37, $2B, $2C, $36, $B5, $FA, $F7, $EF
    db $EE, $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $EF, $EE, $01, $00
    db $AB, $00, $00, $00, $10, $99, $F7, $F0

Data_097_4737:: ; heuristic: target of a monotone pointer table; C0
    db $9F, $9F, $9F, $90, $0C, $32, $30, $33, $32, $36, $2C, $31, $2A, $90, $9F, $9F
    db $9F, $F7, $F0

Data_097_474A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_097_474C

Data_097_474C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_097_4830
    dw Data_097_4904
    dw Data_097_49A2
    dw Data_097_4A38
    dw Data_097_4A85
    dw Data_097_4AF2
    dw Data_097_4B14
    dw Data_097_4B39
    dw Data_097_4B80
    dw Data_097_4CE1
    dw Data_097_4D25
    dw Data_097_4D5E
    dw Data_097_4E12
    dw Data_097_4E2E
    dw Data_097_4E49
    dw Data_097_4E68
    dw Data_097_4F09
    dw Data_097_4FAA
    dw Data_097_4FC6
    dw Data_097_505D
    dw Data_097_507B
    dw Data_097_5102
    dw Data_097_5123
    dw Data_097_5164
    dw Data_097_519D
    dw Data_097_51E4
    dw Data_097_5241
    dw Data_097_528C
    dw Data_097_5300
    dw Data_097_5347
    dw Data_097_5385
    dw Data_097_53C4
    dw Data_097_5407
    dw Data_097_544A
    dw Data_097_54BE
    dw Data_097_5522
    dw Data_097_5546
    dw Data_097_556A
    dw Data_097_55A5
    dw Data_097_55CB
    dw Data_097_560A
    dw Data_097_5644
    dw Data_097_56D7
    dw Data_097_56FF
    dw Data_097_5721
    dw Data_097_5742
    dw Data_097_575A
    dw Data_097_5797
    dw Data_097_57D0
    dw Data_097_580B
    dw Data_097_584B
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_5882
    dw Data_097_594B
    dw Data_097_5A3A
    dw Data_097_5A5E
    dw Data_097_5A83
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE
    dw Data_097_5BBE

Data_097_4830:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C830, $D4

Data_097_4904:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C904, $9E

Data_097_49A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25C9A2, $96

Data_097_4A38:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25CA38, $4D

Data_097_4A85:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25CA85, $6D

Data_097_4AF2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $32, $3A, $90, $26, $24, $31, $90, $3A, $28, $90, $35, $28
    db $24, $26, $2B, $F1, $37, $2B, $28, $90, $2B, $2C, $27, $28, $32, $38, $37, $98
    db $F7, $F0

Data_097_4B14:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $2C, $28, $39, $28, $36, $90, $27, $35, $32, $39, $28
    db $90, $38, $36, $F1, $29, $35, $32, $30, $90, $32, $38, $35, $90, $2B, $32, $30
    db $28, $36, $99, $F7, $F0

Data_097_4B39:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25CB39, $47

Data_097_4B80:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25CB80, $161

Data_097_4CE1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25CCE1, $44

Data_097_4D25:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $27, $28, $29, $28, $24, $37, $28, $27, $90
    db $30, $3C, $F1, $30, $32, $31, $36, $37, $28, $35, $98, $FA, $F7, $EF, $EE, $1E
    db $35, $2A, $2A, $2B, $A4, $EF, $EE, $1D, $2C, $30, $28, $90, $37, $32, $90, $35
    db $28, $2A, $35, $32, $38, $33, $99, $F7, $F0

Data_097_4D5E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25CD5E, $B4

Data_097_4E12:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $2C, $31, $2A, $A3, $90, $1C, $38, $35, $35, $28, $31, $27, $28, $35
    db $F1, $24, $31, $27, $90, $2F, $2C, $39, $28, $99, $F7, $F0

Data_097_4E2E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2C, $3C, $28, $28, $2B, $99, $F1, $11, $28, $2F, $33, $90
    db $30, $28, $AB, $90, $25, $32, $36, $36, $99, $F7, $F0

Data_097_4E49:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1E, $35, $2A, $24, $2B, $99, $90, $16, $28, $35, $26, $3C, $99
    db $F1, $12, $90, $36, $38, $35, $35, $28, $31, $27, $28, $35, $99, $F7, $F0

Data_097_4E68:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25CE68, $A1

Data_097_4F09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25CF09, $A1

Data_097_4FAA:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28, $F1
    db $1D, $2C, $27, $24, $2F, $0B, $28, $2F, $2F, $B5, $F7, $F0

Data_097_4FC6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25CFC6, $97

Data_097_505D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $39, $32, $2C, $26, $28, $90, $28, $26, $2B, $32, $28, $27, $F1, $29
    db $35, $32, $30, $90, $31, $32, $3A, $2B, $28, $35, $28, $A4, $F7, $F0

Data_097_507B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D07B, $87

Data_097_5102:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $14, $2C, $31, $2A, $90, $26, $24, $38, $2A
    db $2B, $37, $F1, $37, $2B, $28, $90, $37, $2B, $2C, $28, $39, $28, $36, $99, $F7
    db $F0

Data_097_5123:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D123, $41

Data_097_5164:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $90, $35, $28, $26, $32, $39, $28, $35, $28, $27, $F1
    db $28, $39, $28, $35, $3C, $37, $2B, $2C, $31, $2A, $90, $37, $2B, $24, $37, $FA
    db $F7, $EF, $EE, $3A, $24, $36, $90, $37, $24, $2E, $28, $31, $90, $29, $35, $32
    db $30, $90, $38, $36, $B5, $EF, $EE, $F7, $F0

Data_097_519D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D19D, $47

Data_097_51E4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D1E4, $5D

Data_097_5241:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D241, $4B

Data_097_528C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D28C, $74

Data_097_5300:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D300, $47

Data_097_5347:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $37, $35, $32, $38, $33, $28, $43, $2F, $F1
    db $35, $28, $29, $32, $35, $30, $99, $FA, $F7, $EF, $EE, $20, $28, $43, $2F, $90
    db $35, $28, $26, $35, $38, $2C, $37, $90, $31, $28, $3A, $EF, $EE, $30, $28, $30
    db $25, $28, $35, $36, $AB, $90, $3A, $24, $37, $26, $2B, $99, $F7, $F0

Data_097_5385:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $40, $28, $90, $30, $32, $35, $28, $F1, $39, $2C, $2A
    db $2C, $2F, $24, $31, $37, $90, $31, $32, $3A, $99, $FA, $F7, $EF, $EE, $17, $32
    db $90, $37, $2B, $2C, $28, $39, $28, $36, $90, $3A, $2C, $2F, $2F, $EF, $EE, $36
    db $38, $26, $26, $28, $28, $27, $90, $24, $2A, $24, $2C, $31, $99, $F7, $F0

Data_097_53C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D3C4, $43

Data_097_5407:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D407, $43

Data_097_544A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D44A, $74

Data_097_54BE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D4BE, $64

Data_097_5522:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $27, $38, $31, $2A, $28, $32, $31, $90, $2C
    db $36, $F1, $29, $38, $2F, $2F, $90, $32, $29, $90, $37, $2B, $2C, $28, $39, $28
    db $36, $99, $F7, $F0

Data_097_5546:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0C, $32, $32, $2B, $AB, $90, $32, $38, $35, $90, $2B, $32, $30
    db $28, $F1, $26, $32, $30, $28, $90, $25, $24, $26, $2E, $90, $37, $32, $90, $38
    db $36, $99, $F7, $F0

Data_097_556A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0C, $32, $32, $2B, $99, $90, $1D, $2B, $2C, $28, $39, $28, $36
    db $F1, $24, $35, $28, $90, $2A, $32, $31, $28, $99, $FA, $F7, $EF, $EE, $17, $32
    db $90, $30, $32, $35, $28, $90, $3A, $32, $35, $35, $2C, $28, $36, $99, $EF, $EE
    db $0C, $32, $32, $34, $38, $28, $28, $2B, $99, $F7, $F0

Data_097_55A5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0C, $32, $32, $2B, $99, $90, $1D, $2B, $2C, $36, $90, $25, $28
    db $27, $F1, $33, $28, $35, $29, $28, $26, $37, $90, $29, $32, $35, $90, $36, $2F
    db $28, $28, $33, $99, $F7, $F0

Data_097_55CB:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $14, $3C, $32, $32, $2B, $99, $90, $1C, $3A, $2C, $30, $30, $2C
    db $31, $2A, $F1, $2C, $31, $90, $24, $90, $27, $28, $36, $28, $35, $37, $A4, $FA
    db $F7, $EF, $EE, $1D, $2B, $2C, $36, $90, $2C, $36, $90, $2F, $38, $3B, $38, $35
    db $3C, $99, $EF, $EE, $17, $32, $90, $27, $32, $38, $25, $37, $99, $F7, $F0

Data_097_560A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $14, $3C, $38, $2E, $3C, $32, $32, $2B, $99, $90, $22, $32, $38
    db $F1, $24, $35, $28, $90, $2A, $32, $32, $27, $90, $2B, $38, $30, $24, $31, $B5
    db $FA, $F7, $EF, $EE, $12, $90, $35, $28, $36, $33, $28, $26, $37, $90, $3C, $32
    db $38, $90, $31, $32, $3A, $99, $EF, $EE, $F7, $F0

Data_097_5644:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D644, $93

Data_097_56D7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $90, $24, $35, $28, $90, $33, $24, $35, $37, $31, $28
    db $35, $36, $AB, $F1, $24, $31, $27, $90, $2A, $32, $32, $27, $90, $32, $31, $28
    db $36, $90, $37, $32, $32, $99, $F7, $F0

Data_097_56FF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $0B, $38, $37, $90, $3C, $32, $38, $90, $2B, $24, $39, $28
    db $90, $31, $32, $F1, $35, $32, $32, $30, $90, $29, $32, $35, $90, $30, $28, $A4
    db $F7, $F0

Data_097_5721:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $26, $2B, $AB, $90, $12, $90, $37, $2B, $2C, $31, $2E, $F1
    db $12, $90, $26, $24, $31, $90, $2B, $28, $2F, $33, $90, $3C, $32, $38, $A4, $F7
    db $F0

Data_097_5742:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $90, $37, $32, $90, $32, $38
    db $35, $F1, $2C, $31, $31, $99, $F7, $F0

Data_097_575A:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $EF, $EE, $1D, $2B, $2C, $28, $39, $28, $36, $90, $2B, $24, $39, $28, $EF, $EE
    db $28, $30, $33, $37, $2C, $28, $27, $90, $2C, $37, $A4, $F7, $F0

Data_097_5797:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $3A
    db $24, $36, $90, $29, $38, $2F, $2F, $90, $32, $29, $EF, $EE, $3A, $32, $32, $27
    db $90, $26, $2B, $2C, $33, $36, $B5, $F7, $F0

Data_097_57D0:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $27
    db $35, $28, $36, $36, $28, $35, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28, $35, $28
    db $90, $3A, $24, $36, $90, $24, $90, $2F, $32, $31, $2A, $AB, $EF, $EE, $37, $2B
    db $2C, $31, $90, $26, $2F, $32, $37, $2B, $B5, $F7, $F0

Data_097_580B:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28, $90
    db $33, $35, $2C, $36, $32, $31, $28, $35, $36, $95, $EF, $EE, $37, $2B, $2C, $31
    db $2A, $36, $90, $3A, $28, $35, $28, $90, $37, $2B, $28, $35, $28, $B5, $F7, $F0

Data_097_584B:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $EF, $EE, $0B, $38, $37, $90, $2C, $37, $90, $3A, $24, $36, $90, $28, $30, $33
    db $37, $3C, $A4, $EF, $EE, $F7, $F0

Data_097_5882:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D882, $C9

Data_097_594B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25D94B, $EF

Data_097_5A3A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $37, $24, $2F, $2E, $90, $2C, $36, $90
    db $37, $32, $32, $F1, $28, $24, $35, $2F, $3C, $90, $29, $32, $35, $90, $3C, $32
    db $38, $B5, $F7, $F0

Data_097_5A5E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $24, $39, $28, $90, $3C, $32, $38, $90, $28, $39, $28, $35
    db $F1, $29, $32, $38, $31, $27, $90, $24, $90, $0D, $35, $28, $24, $30, $90, $0E
    db $2A, $2A, $98, $FF, $F0

Data_097_5A83:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25DA83, $13B

Data_097_5BBE:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_097_5BBF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_097_5BC1

Data_097_5BC1:: ; heuristic: target of a monotone pointer table; C0
    dw Data_097_5C97
    dw Data_097_5D40
    dw Data_097_5D83
    dw Data_097_5E07
    dw Data_097_5E43
    dw Data_097_5EAB
    dw Data_097_5F00
    dw Data_097_5F8B
    dw Data_097_5FCF
    dw Data_097_600C
    dw Data_097_60C0
    dw Data_097_60FE
    dw Data_097_616C
    dw Data_097_61E0
    dw Data_097_6308
    dw Data_097_63B0
    dw Data_097_655C
    dw Data_097_657C
    dw Data_097_659D
    dw Data_097_65E3
    dw Data_097_662C
    dw Data_097_6697
    dw Data_097_66DE
    dw Data_097_6727
    dw Data_097_6798
    dw Data_097_6852
    dw Data_097_6909
    dw Data_097_6986
    dw Data_097_69BB
    dw Data_097_69F9
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6A3C
    dw Data_097_6B14
    dw Data_097_6BCE
    dw Data_097_6BCE
    dw Data_097_6BCE
    dw Data_097_6BCE
    dw Data_097_6BCE
    dw Data_097_6BCE
    dw Data_097_6BCE
    dw Data_097_6BCE
    dw Data_097_6BCE
    dw Data_097_6BEB
    dw Data_097_6BEB
    dw Data_097_6BEB
    dw Data_097_6CA3
    dw Data_097_6CA3
    dw Data_097_6CA3
    dw Data_097_6D0D
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0
    dw Data_097_6DC0

Data_097_5C97:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25DC97, $A9

Data_097_5D40:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25DD40, $43

Data_097_5D83:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25DD83, $84

Data_097_5E07:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $90, $37, $32, $90, $30, $3C
    db $F1, $14, $28, $3C, $90, $1C, $2B, $32, $33, $99, $FA, $F7, $EF, $EE, $1C, $2B
    db $32, $38, $2F, $27, $90, $12, $90, $24, $33, $33, $35, $24, $2C, $36, $28, $EF
    db $EE, $3C, $32, $38, $35, $90, $2E, $28, $3C, $36, $98, $F0

Data_097_5E43:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25DE43, $68

Data_097_5EAB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25DEAB, $55

Data_097_5F00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25DF00, $8B

Data_097_5F8B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25DF8B, $44

Data_097_5FCF:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $3A
    db $24, $36, $90, $29, $38, $2F, $2F, $90, $32, $29, $EF, $EE, $2D, $28, $37, $9C
    db $25, $2F, $24, $26, $2E, $90, $26, $32, $24, $2F, $B5, $F7, $F0

Data_097_600C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E00C, $B4

Data_097_60C0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $20, $24, $9C, $2B, $28, $3C
    db $AB, $F1, $2B, $38, $35, $35, $3C, $B5, $FA, $F7, $EF, $EE, $22, $32, $38, $90
    db $31, $28, $28, $27, $90, $37, $32, $90, $2A, $24, $37, $2B, $28, $35, $EF, $EE
    db $30, $32, $35, $28, $90, $28, $31, $28, $35, $2A, $3C, $B5, $F7, $F0

Data_097_60FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E0FE, $6E

Data_097_616C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E16C, $74

Data_097_61E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E1E0, $128

Data_097_6308:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E308, $A8

Data_097_63B0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E3B0, $1AC

Data_097_655C:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $19, $2C, $35, $24, $37, $28, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_097_657C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $38, $37, $37, $2C, $31, $2A, $90, $38, $33, $90, $24, $F1
    db $25, $35, $2C, $27, $2A, $28, $90, $2C, $36, $90, $28, $24, $36, $3C, $99, $F7
    db $F0

Data_097_659D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E59D, $46

Data_097_65E3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E5E3, $49

Data_097_662C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E62C, $6B

Data_097_6697:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E697, $47

Data_097_66DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E6DE, $49

Data_097_6727:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E727, $71

Data_097_6798:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E798, $BA

Data_097_6852:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E852, $B7

Data_097_6909:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E909, $7D

Data_097_6986:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $25, $24, $35, $35, $28, $2F, $B5, $FA, $F7, $EF, $EE, $12, $37
    db $90, $3A, $24, $36, $90, $29, $38, $2F, $2F, $90, $32, $29, $EF, $EE, $2D, $38
    db $31, $2E, $B5, $F7, $F0

Data_097_69BB:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $32, $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $3A
    db $24, $36, $90, $36, $37, $2C, $2F, $2F, $90, $3A, $24, $35, $30, $EF, $EE, $29
    db $35, $32, $30, $90, $26, $32, $32, $2E, $2C, $31, $2A, $B5, $F7, $F0

Data_097_69F9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25E9F9, $43

Data_097_6A3C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25EA3C, $D8

Data_097_6B14:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25EB14, $BA

Data_097_6BCE:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $12, $26, $28, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_097_6BEB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25EBEB, $B8

Data_097_6CA3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25ECA3, $6A

Data_097_6D0D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25ED0D, $B3

Data_097_6DC0:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_097_6DC1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_097_6DC3

Data_097_6DC3:: ; heuristic: target of a monotone pointer table; C0
    dw Data_097_6E35
    dw Data_097_6ECB
    dw Data_097_6F35
    dw Data_097_6F7B
    dw Data_097_6FC7
    dw Data_097_7012
    dw Data_097_7052
    dw Data_097_70BB
    dw Data_097_70FB
    dw Data_097_7162
    dw Data_097_717E
    dw Data_097_71C6
    dw Data_097_7232
    dw Data_097_7297
    dw Data_097_7305
    dw Data_097_7353
    dw Data_097_739A
    dw Data_097_7404
    dw Data_097_7471
    dw Data_097_74CD
    dw Data_097_753A
    dw Data_097_75C9
    dw Data_097_762C
    dw Data_097_7674
    dw Data_097_770C
    dw Data_097_7753
    dw Data_097_7791
    dw Data_097_77EA
    dw Data_097_782D
    dw Data_097_78A8
    dw Data_097_791A
    dw Data_097_7959
    dw Data_097_799E
    dw Data_097_79E2
    dw Data_097_7A27
    dw Data_097_7A65
    dw Data_097_7AAE
    dw Data_097_7AF8
    dw Data_097_7B3F
    dw Data_097_7B8D
    dw Data_097_7BBD
    dw Data_097_7C2C
    dw Data_097_7C6E
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC
    dw Data_097_7CAC

Data_097_6E35:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25EE35, $96

Data_097_6ECB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25EECB, $6A

Data_097_6F35:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25EF35, $46

Data_097_6F7B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25EF7B, $4C

Data_097_6FC7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25EFC7, $4B

Data_097_7012:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $3C, $90, $24, $35, $28, $90, $3C, $32, $38, $F1, $26
    db $32, $31, $36, $32, $35, $37, $2C, $31, $2A, $90, $3A, $2C, $37, $2B, $FA, $F7
    db $EF, $EE, $30, $32, $31, $36, $37, $28, $35, $36, $98, $EF, $EE, $12, $90, $27
    db $32, $31, $41, $90, $37, $35, $38, $36, $37, $90, $3C, $32, $38, $99, $F7, $F0

Data_097_7052:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F052, $69

Data_097_70BB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0D, $9C, $27, $32, $31, $41, $90, $37, $9C, $37, $35, $3C, $90
    db $37, $32, $F1, $36, $26, $24, $35, $28, $90, $30, $28, $B5, $FA, $F7, $EF, $EE
    db $12, $A4, $90, $12, $3F, $90, $31, $32, $37, $90, $36, $26, $24, $35, $28, $27
    db $EF, $EE, $32, $29, $90, $30, $32, $31, $36, $37, $28, $35, $36, $99, $F7, $F0

Data_097_70FB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F0FB, $67

Data_097_7162:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $32, $38, $2F, $27, $90, $3C, $32, $38, $90, $25, $28, $90
    db $30, $3C, $F1, $29, $35, $2C, $28, $31, $27, $98, $F7, $F0

Data_097_717E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F17E, $48

Data_097_71C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F1C6, $6C

Data_097_7232:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F232, $65

Data_097_7297:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F297, $6E

Data_097_7305:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F305, $4E

Data_097_7353:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F353, $47

Data_097_739A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F39A, $6A

Data_097_7404:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F404, $6D

Data_097_7471:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F471, $5C

Data_097_74CD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F4CD, $6D

Data_097_753A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F53A, $8F

Data_097_75C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F5C9, $63

Data_097_762C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F62C, $48

Data_097_7674:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F674, $98

Data_097_770C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F70C, $47

Data_097_7753:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $26, $24, $30, $28, $90, $29, $35, $32, $30
    db $F1, $10, $35, $28, $24, $37, $15, $32, $2A, $98, $FA, $F7, $EF, $EE, $12, $42
    db $28, $90, $31, $28, $39, $28, $35, $90, $2B, $28, $24, $35, $27, $EF, $EE, $32
    db $29, $90, $2C, $37, $AB, $90, $36, $32, $35, $35, $3C, $B5, $F7, $F0

Data_097_7791:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F791, $59

Data_097_77EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F7EA, $43

Data_097_782D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F82D, $7B

Data_097_78A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F8A8, $72

Data_097_791A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $90, $3A, $24, $31, $27, $28, $35, $90, $37, $2B, $28, $F1
    db $32, $37, $2B, $28, $35, $90, $3A, $32, $35, $2F, $27, $36, $A4, $FA, $F7, $EF
    db $EE, $12, $3F, $90, $36, $38, $35, $28, $90, $3A, $28, $90, $3A, $2C, $2F, $2F
    db $EF, $EE, $30, $28, $28, $37, $90, $24, $2A, $24, $2C, $31, $B5, $F7, $F0

Data_097_7959:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F959, $45

Data_097_799E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F99E, $44

Data_097_79E2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25F9E2, $45

Data_097_7A27:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $90, $3A, $24, $31, $27, $28, $35, $90, $37, $2B, $28, $F1
    db $32, $37, $2B, $28, $35, $90, $3A, $32, $35, $2F, $27, $36, $A4, $FA, $F7, $EF
    db $EE, $20, $28, $90, $30, $24, $3C, $90, $2B, $24, $39, $28, $EF, $EE, $26, $35
    db $32, $36, $36, $28, $27, $90, $33, $24, $37, $2B, $36, $A4, $F7, $F0

Data_097_7A65:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25FA65, $49

Data_097_7AAE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25FAAE, $4A

Data_097_7AF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25FAF8, $47

Data_097_7B3F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25FB3F, $4E

Data_097_7B8D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $38, $30, $33, $2B, $A4, $F1, $FA, $F7, $EF, $EE, $F3, $1D
    db $2B, $24, $37, $3E, $90, $30, $3C, $90, $1D, $28, $35, $35, $3C, $EF, $EE, $2C
    db $30, $33, $35, $28, $36, $36, $2C, $32, $31, $B5, $90, $1C, $32, $98, $F7, $F0

Data_097_7BBD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25FBBD, $6F

Data_097_7C2C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25FC2C, $42

Data_097_7C6E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $2A, $32, $2C, $31, $2A, $90, $37, $32, $F1, $30
    db $24, $35, $35, $3C, $90, $16, $2C, $2F, $24, $3C, $32, $38, $B5, $FA, $F7, $EF
    db $EE, $22, $32, $38, $90, $25, $28, $37, $90, $12, $90, $3A, $2C, $2F, $2F, $99
    db $EF, $EE, $12, $90, $36, $24, $2C, $27, $90, $36, $32, $99, $F7, $F0

Data_097_7CAC:: ; heuristic: target of a monotone pointer table; C0
    ds $354, $00
