SECTION "Bank 99", ROMX[$4000], BANK[$99]
    db $99

Func_099_4001::
    ld de, Data_099_4070
    ld a, [$C529]
    sub a, $D5
    ld [$C529], a
    call Func_000_25C9
    ret

Func_099_4010:: ; heuristic: follows a terminator; C0
    ld de, Data_099_4070
    ld a, [$C529]
    sub a, $D5
    ld [$C529], a
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Func_099_4026::
    ld de, Data_099_4B35
    ld a, [$C529]
    sub a, $A6
    ld [$C529], a
    call Func_000_25C9
    ret

Func_099_4035:: ; heuristic: follows a terminator; C0
    ld de, Data_099_4B35
    ld a, [$C529]
    sub a, $A6
    ld [$C529], a
    call Func_000_25FE
    ret
    db $CD, $26, $40, $CD, $11, $26, $C9

Func_099_404B::
    ld de, Data_099_6366
    ld a, [$C529]
    sub a, $87
    ld [$C529], a
    call Func_000_25C9
    ret

Func_099_405A:: ; heuristic: follows a terminator; C0
    ld de, Data_099_6366
    ld a, [$C529]
    sub a, $87
    ld [$C529], a
    call Func_000_25FE
    ret
    db $CD, $4B, $40, $CD, $11, $26, $C9

Data_099_4070:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $72, $40
    dw Data_099_40C8
    dw Data_099_4111
    dw Data_099_4152
    dw Data_099_4192
    dw Data_099_41CF
    dw Data_099_4216
    dw Data_099_4254
    dw Data_099_4294
    dw Data_099_42DD
    dw Data_099_431F
    dw Data_099_4360
    dw Data_099_4381
    dw Data_099_43CB
    dw Data_099_4407
    dw Data_099_444A
    dw Data_099_4495
    dw Data_099_44D9
    dw Data_099_4525
    dw Data_099_4549
    dw Data_099_456E
    dw Data_099_45A9
    dw Data_099_45F3
    dw Data_099_463C
    dw Data_099_4677
    dw Data_099_46C2
    dw Data_099_4712
    dw Data_099_4752
    dw Data_099_479D
    dw Data_099_47E0
    dw Data_099_4826
    dw Data_099_4869
    dw Data_099_488A
    dw Data_099_48B2
    dw Data_099_48F3
    dw Data_099_492C
    dw Data_099_4974
    dw Data_099_49C2
    dw Data_099_49FE
    dw Data_099_4A3F
    dw Data_099_4A65
    dw Data_099_4A89
    dw Data_099_4AC6
    dw Data_099_4B07

Data_099_40C8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2640C8, $49

Data_099_4111:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264111, $41

Data_099_4152:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $31, $41, $90, $37, $2B, $28, $90, $3A, $28, $24, $37
    db $2B, $28, $35, $F1, $29, $24, $25, $38, $2F, $32, $38, $36, $98, $FA, $F7, $EF
    db $EE, $20, $28, $90, $31, $28, $28, $27, $90, $37, $32, $90, $25, $28, $90, $32
    db $38, $37, $EF, $EE, $37, $35, $24, $39, $28, $2F, $2C, $31, $2A, $99, $F7, $F0

Data_099_4192:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0D, $32, $31, $41, $90, $25, $28, $90, $36, $32, $F1, $32, $25
    db $36, $37, $2C, $31, $24, $37, $28, $98, $FA, $F7, $EF, $EE, $0B, $38, $37, $90
    db $12, $3F, $90, $31, $32, $37, $99, $EF, $EE, $11, $38, $2B, $98, $90, $12, $3F
    db $90, $24, $26, $37, $2C, $31, $2A, $90, $2C, $37, $98, $F7, $F0

Data_099_41CF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2641CF, $47

Data_099_4216:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $33, $2F, $24, $31, $90, $37, $32, $90, $2F, $28, $24
    db $39, $28, $F1, $24, $36, $90, $12, $90, $36, $28, $28, $90, $29, $2C, $37, $B5
    db $FA, $F7, $EF, $EE, $15, $28, $24, $39, $28, $90, $30, $28, $90, $24, $2F, $32
    db $31, $28, $AB, $EF, $EE, $33, $2F, $28, $24, $36, $28, $B5, $F7, $F0

Data_099_4254:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $28, $24, $37, $AB, $90, $30, $28, $24, $37, $AB, $90, $2A
    db $2C, $39, $28, $F1, $30, $28, $90, $30, $28, $24, $37, $99, $FA, $F7, $EF, $EE
    db $18, $35, $90, $12, $90, $3A, $32, $31, $41, $90, $3A, $32, $35, $2E, $EF, $EE
    db $29, $32, $35, $90, $3C, $32, $38, $B5, $90, $16, $28, $24, $37, $99, $F7, $F0

Data_099_4294:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264294, $49

Data_099_42DD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2642DD, $42

Data_099_431F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26431F, $41

Data_099_4360:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $A4, $90, $1E, $30, $A4, $90, $1C, $2B, $3C, $A4, $F1, $1C
    db $32, $35, $35, $3C, $A4, $90, $12, $3F, $90, $36, $32, $35, $35, $3C, $A4, $F7
    db $F0

Data_099_4381:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264381, $4A

Data_099_43CB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $AB, $90, $31, $32, $A4, $F1, $16, $38, $36, $37, $90
    db $12, $90, $2A, $32, $98, $FA, $F7, $EF, $EE, $0C, $24, $39, $28, $36, $90, $24
    db $31, $27, $90, $27, $24, $35, $2E, $EF, $EE, $33, $2F, $24, $26, $28, $36, $90
    db $24, $35, $28, $90, $36, $26, $24, $35, $3C, $A4, $F7, $F0

Data_099_4407:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264407, $43

Data_099_444A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26444A, $4B

Data_099_4495:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264495, $44

Data_099_44D9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2644D9, $4C

Data_099_4525:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $28, $28, $2C, $31, $2A, $90, $3C, $32, $38, $35, $90, $2D
    db $32, $3C, $F1, $24, $27, $27, $36, $90, $37, $32, $90, $30, $3C, $90, $32, $3A
    db $31, $B5, $F7, $F0

Data_099_4549:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $3A, $2C, $2F, $2F, $90, $37, $24, $2E, $28, $90, $26
    db $24, $35, $28, $F1, $32, $29, $90, $3C, $32, $38, $90, $37, $32, $37, $24, $2F
    db $2F, $3C, $99, $F7, $F0

Data_099_456E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $32, $35, $2F, $27, $90, $27, $32, $30, $2C, $31, $24, $37
    db $2C, $32, $31, $F1, $2C, $36, $90, $37, $2B, $28, $90, $38, $2F, $37, $2C, $30
    db $24, $37, $28, $FA, $F7, $EF, $EE, $2A, $32, $24, $2F, $90, $2C, $31, $90, $30
    db $3C, $90, $2F, $2C, $29, $28, $99, $EF, $EE, $F7, $F0

Data_099_45A9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2645A9, $4A

Data_099_45F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2645F3, $49

Data_099_463C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0E, $39, $28, $31, $90, $32, $31, $26, $28, $AB, $90, $12, $F1
    db $3A, $32, $38, $2F, $27, $90, $2B, $24, $39, $28, $90, $2F, $2C, $2E, $28, $27
    db $FA, $F7, $EF, $EE, $37, $32, $90, $2B, $24, $39, $28, $90, $25, $28, $28, $31
    db $90, $24, $EF, $EE, $2B, $28, $35, $32, $A4, $F7, $F0

Data_099_4677:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264677, $4B

Data_099_46C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2646C2, $50

Data_099_4712:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0E, $3B, $26, $2C, $37, $28, $30, $28, $31, $37, $AB, $F1, $37
    db $28, $31, $36, $2C, $32, $31, $A4, $FA, $F7, $EF, $EE, $1D, $2B, $28, $3C, $90
    db $24, $35, $28, $90, $28, $30, $32, $37, $2C, $32, $31, $36, $EF, $EE, $3A, $2C
    db $37, $2B, $32, $38, $37, $90, $30, $28, $24, $31, $2C, $31, $2A, $B5, $F7, $F0

Data_099_4752:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264752, $4B

Data_099_479D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26479D, $43

Data_099_47E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2647E0, $46

Data_099_4826:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264826, $43

Data_099_4869:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0D, $32, $31, $41, $90, $25, $32, $37, $2B, $28, $35, $90, $30
    db $28, $A4, $F1, $15, $28, $24, $39, $28, $90, $30, $28, $90, $25, $28, $A4, $F7
    db $F0

Data_099_488A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $28, $37, $90, $30, $28, $90, $26, $32, $31, $34, $38, $28
    db $35, $90, $24, $F1, $3A, $32, $35, $2F, $27, $90, $29, $32, $35, $90, $3C, $32
    db $38, $AB, $90, $28, $2B, $98, $F7, $F0

Data_099_48B2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2648B2, $41

Data_099_48F3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $3A, $32, $35, $2F, $27, $90, $2C, $36, $F1
    db $30, $2C, $31, $28, $99, $FA, $F7, $EF, $EE, $1D, $2B, $24, $37, $90, $2C, $36
    db $90, $37, $2B, $28, $90, $3A, $24, $3C, $90, $2C, $37, $EF, $EE, $2B, $24, $36
    db $90, $37, $32, $90, $25, $28, $99, $F7, $F0

Data_099_492C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26492C, $48

Data_099_4974:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264974, $4E

Data_099_49C2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $29, $28, $28, $2F, $2C, $31, $2A, $36, $90
    db $32, $29, $F1, $2B, $24, $37, $35, $28, $27, $90, $24, $31, $27, $90, $36, $32
    db $35, $35, $32, $3A, $FA, $F7, $EF, $EE, $25, $28, $26, $32, $30, $28, $90, $30
    db $3C, $90, $33, $32, $3A, $28, $35, $B5, $EF, $EE, $F7, $F0

Data_099_49FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2649FE, $41

Data_099_4A3F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2F, $2F, $90, $30, $3C, $90, $33, $32, $3A, $28, $35, $AB
    db $90, $12, $F1, $3A, $2C, $2F, $2F, $90, $38, $36, $28, $90, $29, $32, $35, $90
    db $3C, $32, $38, $A4, $F7, $F0

Data_099_4A65:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $33, $9C, $33, $32, $3A, $28, $35, $90, $32
    db $29, $F1, $2B, $28, $35, $32, $28, $36, $90, $2C, $36, $90, $36, $26, $24, $35
    db $3C, $A4, $F7, $F0

Data_099_4A89:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $29, $90, $3C, $32, $38, $90, $3A, $32, $38, $2F, $27, $F1
    db $24, $2F, $2F, $32, $3A, $90, $2C, $37, $AB, $90, $12, $90, $3A, $2C, $36, $2B
    db $FA, $F7, $EF, $EE, $37, $32, $90, $26, $32, $31, $34, $38, $28, $35, $90, $37
    db $2B, $2C, $36, $EF, $EE, $3A, $32, $35, $2F, $27, $B5, $F7, $F0

Data_099_4AC6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264AC6, $41

Data_099_4B07:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $26, $24, $31, $41, $90, $25, $28, $F1, $25, $32, $37
    db $2B, $28, $35, $28, $27, $90, $37, $32, $90, $26, $2B, $24, $37, $A4, $FA, $F7
    db $EF, $EE, $0B, $28, $90, $2A, $32, $31, $28, $A4, $EF, $EE, $F7, $F0

Data_099_4B35:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $37, $4B
    dw Data_099_4BEB
    dw Data_099_4C54
    dw Data_099_4D28
    dw Data_099_4D8E
    dw Data_099_4DD2
    dw Data_099_4E3F
    dw Data_099_4E9F
    dw Data_099_4F72
    dw Data_099_4FDB
    dw Data_099_503F
    dw Data_099_50C4
    dw Data_099_5147
    dw Data_099_51C5
    dw Data_099_5208
    dw Data_099_5284
    dw Data_099_5300
    dw Data_099_5379
    dw Data_099_53FF
    dw Data_099_5422
    dw Data_099_5458
    dw Data_099_54A4
    dw Data_099_54BD
    dw Data_099_5504
    dw Data_099_5545
    dw Data_099_5585
    dw Data_099_5585
    dw Data_099_55E2
    dw Data_099_5679
    dw Data_099_56FC
    dw Data_099_5766
    dw Data_099_57CE
    dw Data_099_580C
    dw Data_099_584B
    dw Data_099_58CD
    dw Data_099_5935
    dw Data_099_59B1
    dw Data_099_5A50
    dw Data_099_5A6C
    dw Data_099_5AA7
    dw Data_099_5AC8
    dw Data_099_5BB6
    dw Data_099_5C63
    dw Data_099_5CCC
    dw Data_099_5CE5
    dw Data_099_5D3E
    dw Data_099_5DB1
    dw Data_099_5DF0
    dw Data_099_5E36
    dw Data_099_5E83
    dw Data_099_5F38
    dw Data_099_600D
    dw Data_099_60A7
    dw Data_099_612C
    dw Data_099_6191
    dw Data_099_61D0
    dw Data_099_631E
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365
    dw Data_099_6365

Data_099_4BEB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264BEB, $69

Data_099_4C54:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264C54, $D4

Data_099_4D28:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264D28, $66

Data_099_4D8E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264D8E, $44

Data_099_4DD2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264DD2, $6D

Data_099_4E3F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264E3F, $60

Data_099_4E9F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264E9F, $D3

Data_099_4F72:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264F72, $69

Data_099_4FDB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $264FDB, $64

Data_099_503F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26503F, $85

Data_099_50C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2650C4, $83

Data_099_5147:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265147, $7E

Data_099_51C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2651C5, $43

Data_099_5208:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265208, $7C

Data_099_5284:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265284, $7C

Data_099_5300:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265300, $79

Data_099_5379:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265379, $86

Data_099_53FF:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $37, $32, $3A, $28, $35, $3E, $90, $28, $31, $37, $35, $3C
    db $F1, $2C, $36, $90, $36, $28, $24, $2F, $28, $27, $90, $37, $2C, $2A, $2B, $37
    db $B5, $F7, $F0

Data_099_5422:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $32, $90, $24, $35, $28, $90, $3C, $32, $38, $98, $F1
    db $FA, $F7, $EF, $EE, $F3, $22, $32, $38, $90, $36, $2B, $32, $38, $2F, $27, $31
    db $41, $90, $25, $28, $EF, $EE, $30, $28, $27, $27, $2F, $2C, $31, $2A, $90, $2B
    db $28, $35, $28, $99, $F7, $F0

Data_099_5458:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265458, $4C

Data_099_54A4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $AB, $90, $31, $32, $37, $90, $3C, $32, $38
    db $F1, $24, $2A, $24, $2C, $31, $99, $F7, $F0

Data_099_54BD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2654BD, $47

Data_099_5504:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265504, $41

Data_099_5545:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $33, $28, $31, $28, $27, $90, $37, $2B, $28, $F1, $37, $35
    db $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7, $EF
    db $EE, $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28
    db $EF, $EE, $19, $35, $28, $37, $37, $3C, $90, $1B, $2C, $31, $2A, $B5, $F7, $F0

Data_099_5585:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265585, $5D

Data_099_55E2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2655E2, $97

Data_099_5679:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265679, $83

Data_099_56FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2656FC, $6A

Data_099_5766:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265766, $68

Data_099_57CE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $27, $28, $29, $28, $24, $37, $28, $27, $90
    db $37, $2B, $28, $F1, $30, $32, $31, $36, $37, $28, $35, $36, $98, $FA, $F7, $EF
    db $EE, $22, $32, $38, $40, $28, $90, $31, $32, $37, $90, $2D, $32, $2E, $2C, $31
    db $2A, $AB, $EF, $EE, $24, $35, $28, $90, $3C, $32, $38, $98, $F7, $F0

Data_099_580C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $27, $28, $29, $28, $24, $37, $28, $27, $90
    db $37, $2B, $28, $F1, $30, $32, $31, $36, $37, $28, $35, $36, $A4, $FA, $F7, $EF
    db $EE, $A4, $22, $32, $38, $40, $28, $90, $31, $32, $37, $90, $2D, $32, $2E, $2C
    db $31, $2A, $AB, $EF, $EE, $24, $35, $28, $90, $3C, $32, $38, $98, $F7, $F0

Data_099_584B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26584B, $82

Data_099_58CD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2658CD, $68

Data_099_5935:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265935, $7C

Data_099_59B1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2659B1, $9F

Data_099_5A50:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $36, $2B, $32, $3A, $28, $27, $90, $37, $2B, $28, $F1, $19, $35
    db $28, $37, $37, $3C, $90, $1B, $2C, $31, $2A, $B5, $F7, $F0

Data_099_5A6C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2B, $A4, $90, $1D, $2B, $24, $37, $90, $35, $2C, $31, $2A
    db $A4, $F1, $12, $36, $A4, $90, $12, $36, $90, $2C, $37, $A4, $FA, $F7, $EF, $EE
    db $1D, $2B, $24, $37, $3E, $90, $30, $3C, $90, $27, $24, $38, $2A, $2B, $37, $28
    db $35, $3E, $EF, $EE, $35, $2C, $31, $2A, $99, $F7, $F0

Data_099_5AA7:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1, $37
    db $2B, $28, $90, $19, $35, $28, $37, $37, $3C, $90, $1B, $2C, $31, $2A, $B5, $F7
    db $F0

Data_099_5AC8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265AC8, $EE

Data_099_5BB6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265BB6, $AD

Data_099_5C63:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265C63, $69

Data_099_5CCC:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $24, $F1, $1C, $24
    db $2A, $28, $1B, $32, $26, $2E, $B5, $F7, $F0

Data_099_5CE5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265CE5, $59

Data_099_5D3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265D3E, $73

Data_099_5DB1:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $28, $90, $24, $35, $28, $90, $2A, $35, $24, $37, $28, $29
    db $38, $2F, $F1, $37, $2B, $24, $37, $90, $3C, $32, $38, $90, $35, $28, $26, $32
    db $39, $28, $35, $28, $27, $FA, $F7, $EF, $EE, $32, $38, $35, $90, $27, $24, $38
    db $2A, $2B, $37, $28, $35, $3E, $EF, $EE, $35, $2C, $31, $2A, $B5, $F7, $F0

Data_099_5DF0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265DF0, $46

Data_099_5E36:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265E36, $4D

Data_099_5E83:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265E83, $B5

Data_099_5F38:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $265F38, $D5

Data_099_600D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26600D, $9A

Data_099_60A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2660A7, $85

Data_099_612C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26612C, $65

Data_099_6191:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $24, $37, $90, $2A, $35, $28, $28, $27, $2B, $32, $38
    db $31, $27, $F1, $27, $28, $24, $2F, $28, $35, $90, $36, $26, $38, $37, $37, $2F
    db $28, $27, $FA, $F7, $EF, $EE, $32, $29, $29, $90, $2C, $31, $90, $24, $31, $90
    db $24, $3A, $29, $38, $2F, $EF, $EE, $2B, $38, $35, $35, $3C, $B5, $F7, $F0

Data_099_61D0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2661D0, $14E

Data_099_631E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26631E, $47

Data_099_6365:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_099_6366:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $68, $63
    dw Data_099_645A
    dw Data_099_6498
    dw Data_099_64FD
    dw Data_099_6537
    dw Data_099_6575
    dw Data_099_65C7
    dw Data_099_6651
    dw Data_099_668B
    dw Data_099_66C9
    dw Data_099_66EF
    dw Data_099_6712
    dw Data_099_6728
    dw Data_099_6772
    dw Data_099_67B5
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_67F8
    dw Data_099_685D
    dw Data_099_687F
    dw Data_099_690A
    dw Data_099_6922
    dw Data_099_6967
    dw Data_099_698A
    dw Data_099_69CE
    dw Data_099_69EA
    dw Data_099_6A2C
    dw Data_099_6A44
    dw Data_099_6A64
    dw Data_099_6A64
    dw Data_099_6A7D
    dw Data_099_6A9F
    dw Data_099_6B2F
    dw Data_099_6BE2
    dw Data_099_6C2B
    dw Data_099_6C69
    dw Data_099_6CCB
    dw Data_099_6D09
    dw Data_099_6D4F
    dw Data_099_6D88
    dw Data_099_6DD0
    dw Data_099_6E07
    dw Data_099_6E1F
    dw Data_099_6E41
    dw Data_099_6E66
    dw Data_099_6EB3
    dw Data_099_6FB7
    dw Data_099_70B6
    dw Data_099_7213
    dw Data_099_7254
    dw Data_099_72DF
    dw Data_099_7386
    dw Data_099_73A5
    dw Data_099_744C
    dw Data_099_74BF
    dw Data_099_7574
    dw Data_099_7574
    dw Data_099_75DA
    dw Data_099_7618
    dw Data_099_763F
    dw Data_099_7687
    dw Data_099_76D1
    dw Data_099_76F3
    dw Data_099_772E
    dw Data_099_778C
    dw Data_099_78AF
    dw Data_099_78EE
    dw Data_099_7955
    dw Data_099_7989
    dw Data_099_7A80
    dw Data_099_7AC4
    dw Data_099_7B16
    dw Data_099_7C8A
    dw Data_099_7CB1
    dw Data_099_7E03
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EEC
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED
    dw Data_099_7EED

Data_099_645A:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $EF, $EE, $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $EF, $EE, $37
    db $2B, $28, $90, $16, $32, $32, $31, $1B, $32, $26, $2E, $B5, $F7, $F0

Data_099_6498:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266498, $65

Data_099_64FD:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $32, $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $36
    db $30, $28, $2F, $2F, $28, $27, $90, $32, $29, $EF, $EE, $2A, $35, $2C, $2F, $2F
    db $28, $27, $90, $29, $2C, $36, $2B, $B5, $F7, $F0

Data_099_6537:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $3A
    db $24, $36, $90, $29, $2C, $2F, $2F, $28, $27, $90, $3A, $2C, $37, $2B, $EF, $EE
    db $30, $28, $35, $26, $2B, $24, $31, $27, $2C, $36, $28, $B5, $F7, $F0

Data_099_6575:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266575, $52

Data_099_65C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2665C7, $8A

Data_099_6651:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $32, $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $1D, $3A, $32, $90
    db $36, $2B, $2C, $31, $3C, $90, $33, $32, $37, $36, $EF, $EE, $3A, $28, $35, $28
    db $90, $2C, $31, $36, $2C, $27, $28, $B5, $F7, $F0

Data_099_668B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $2C, $36, $90, $2C, $36, $90, $37, $2B, $28, $F1, $30
    db $28, $35, $30, $24, $2C, $27, $90, $2E, $2C, $31, $2A, $27, $32, $30, $B5, $FA
    db $F7, $EF, $EE, $0D, $2C, $27, $90, $3C, $32, $38, $90, $3A, $24, $31, $37, $90
    db $37, $32, $90, $2A, $32, $EF, $EE, $2B, $32, $30, $28, $98, $FF, $F0

Data_099_66C9:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0C, $2F, $32, $36, $28, $90, $3C, $32, $38, $35, $90, $28, $3C
    db $28, $36, $F1, $29, $32, $35, $90, $24, $90, $2F, $2C, $37, $37, $2F, $28, $90
    db $25, $2C, $37, $A4, $F7, $F0

Data_099_66EF:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $B5, $90, $1D, $28, $2F, $2F, $90, $30, $28, $90, $2C
    db $29, $F1, $3C, $32, $38, $90, $3A, $24, $31, $37, $90, $37, $32, $90, $2A, $32
    db $B5, $F7, $F0

Data_099_6712:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $0A, $2C, $3C, $28, $28, $28, $28
    db $28, $2B, $A4, $F1, $F7, $F0

Data_099_6728:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266728, $4A

Data_099_6772:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266772, $43

Data_099_67B5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2667B5, $43

Data_099_67F8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2667F8, $65

Data_099_685D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $98, $90, $22, $32, $38, $43, $2F, $90, $35, $38, $31
    db $F1, $24, $31, $32, $37, $2B, $28, $35, $90, $28, $35, $35, $24, $31, $27, $98
    db $FF, $F0

Data_099_687F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26687F, $8B

Data_099_690A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $30, $24, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35
    db $F1, $04, $00, $00, $10, $B5, $F7, $F0

Data_099_6922:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266922, $45

Data_099_6967:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $90, $31, $28, $28, $27, $90, $3C, $32, $38, $90, $37, $32
    db $F1, $2A, $28, $37, $90, $30, $28, $90, $24, $90, $19, $32, $37, $2C, $32, $31
    db $B5, $F7, $F0

Data_099_698A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26698A, $44

Data_099_69CE:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1, $37
    db $2B, $28, $90, $19, $32, $37, $2C, $32, $31, $B5, $F7, $F0

Data_099_69EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2669EA, $42

Data_099_6A2C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $30, $24, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35
    db $F1, $06, $00, $00, $10, $B5, $F7, $F0

Data_099_6A44:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $90, $3A, $24, $31, $37, $90, $3C, $32, $38, $90, $37, $32
    db $F1, $25, $38, $3C, $90, $30, $28, $90, $24, $90, $1B, $2C, $25, $B5, $F7, $F0

Data_099_6A64:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1, $37
    db $2B, $28, $90, $1B, $2C, $25, $B5, $F7, $F0

Data_099_6A7D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $24, $31, $2E, $36, $AB, $90, $F9, $00, $99, $F1, $22
    db $32, $38, $40, $28, $90, $2A, $35, $28, $24, $37, $90, $2B, $28, $2F, $33, $99
    db $F7, $F0

Data_099_6A9F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266A9F, $90

Data_099_6B2F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266B2F, $B3

Data_099_6BE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266BE2, $49

Data_099_6C2B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $29, $90, $32, $31, $28, $90, $2D, $32, $2C, $31, $36, $F1
    db $3C, $32, $38, $AB, $90, $26, $32, $38, $2F, $27, $90, $3C, $32, $38, $FA, $F7
    db $EF, $EE, $25, $35, $2C, $31, $2A, $90, $2C, $37, $90, $2B, $32, $30, $28, $90
    db $37, $32, $EF, $EE, $30, $28, $28, $37, $90, $30, $28, $98, $F7, $F0

Data_099_6C69:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266C69, $62

Data_099_6CCB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $90, $16, $24, $27, $10, $32, $33, $2B, $28, $35, $F1, $2D
    db $32, $2C, $31, $28, $27, $90, $3C, $32, $38, $98, $FA, $F7, $EF, $EE, $0C, $32
    db $38, $2F, $27, $90, $3C, $32, $38, $90, $33, $24, $36, $36, $90, $2C, $37, $EF
    db $EE, $32, $39, $28, $35, $90, $37, $32, $90, $30, $28, $98, $FF, $F0

Data_099_6D09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266D09, $46

Data_099_6D4F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $AB, $90, $12, $90, $31, $28, $28, $27, $F1, $3C, $32
    db $38, $35, $90, $2B, $28, $2F, $33, $B5, $FA, $F7, $EF, $EE, $19, $2F, $28, $24
    db $36, $28, $90, $2A, $28, $37, $90, $30, $28, $90, $24, $EF, $EE, $16, $24, $27
    db $10, $32, $33, $2B, $28, $35, $B5, $F7, $F0

Data_099_6D88:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266D88, $48

Data_099_6DD0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $42, $28, $90, $29, $2C, $31, $2C, $36, $2B, $28, $27, $F1
    db $3A, $32, $35, $2E, $2C, $31, $2A, $B5, $FA, $F7, $EF, $EE, $0C, $24, $31, $90
    db $12, $90, $2A, $32, $90, $3A, $2C, $37, $2B, $90, $3C, $32, $38, $EF, $EE, $24
    db $2A, $24, $2C, $31, $98, $FF, $F0

Data_099_6E07:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $26, $32, $38, $31, $37, $2C, $31, $2A, $90, $32
    db $31, $F1, $3C, $32, $38, $99, $F7, $F0

Data_099_6E1F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $0B, $38, $37, $90, $3C, $32, $38, $90, $2B, $24, $39, $28
    db $90, $31, $32, $F1, $35, $32, $32, $30, $90, $29, $32, $35, $90, $30, $28, $A4
    db $F7, $F0

Data_099_6E41:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $26, $2B, $AB, $90, $12, $90, $37, $2B, $32, $38, $2A, $2B
    db $37, $90, $12, $F1, $26, $32, $38, $2F, $27, $90, $2B, $28, $2F, $33, $90, $3C
    db $32, $38, $A4, $F7, $F0

Data_099_6E66:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266E66, $4D

Data_099_6EB3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266EB3, $104

Data_099_6FB7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $266FB7, $FF

Data_099_70B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2670B6, $15D

Data_099_7213:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $267213, $41

Data_099_7254:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $267254, $8B

Data_099_72DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2672DF, $A7

Data_099_7386:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $2B, $24, $39, $28, $90, $31, $32, $37, $2B, $2C, $31
    db $2A, $F1, $29, $32, $35, $90, $24, $90, $2F, $2C, $24, $35, $99, $F7, $F0

Data_099_73A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2673A5, $A7

Data_099_744C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26744C, $73

Data_099_74BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2674BF, $B5

Data_099_7574:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $267574, $66

Data_099_75DA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $24, $2C, $37, $99, $90, $0C, $32, $38, $2F, $27, $90, $12
    db $F1, $2A, $28, $37, $90, $3C, $32, $38, $90, $37, $32, $90, $2F, $28, $24, $39
    db $28, $FA, $F7, $EF, $EE, $3C, $32, $38, $35, $90, $0A, $35, $30, $3C, $90, $0A
    db $31, $37, $90, $3A, $2C, $37, $2B, $EF, $EE, $30, $28, $98, $FF, $F0

Data_099_7618:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0F, $24, $31, $37, $24, $36, $37, $2C, $26, $99, $90, $12, $90
    db $26, $24, $31, $F1, $32, $33, $28, $31, $90, $30, $3C, $90, $36, $2B, $32, $33
    db $90, $31, $32, $3A, $99, $F7, $F0

Data_099_763F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26763F, $48

Data_099_7687:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $267687, $4A

Data_099_76D1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $99, $90, $11, $32, $3A, $90
    db $30, $24, $3C, $F1, $12, $90, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $98
    db $F7, $F0

Data_099_76F3:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $27
    db $32, $32, $35, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28, $90, $27, $32, $32, $35
    db $90, $3A, $32, $31, $41, $90, $32, $33, $28, $31, $EF, $EE, $3A, $2C, $37, $2B
    db $90, $24, $31, $3C, $90, $2E, $28, $3C, $B5, $F7, $F0

Data_099_772E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26772E, $5E

Data_099_778C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $26778C, $123

Data_099_78AF:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $3F, $90, $37, $2B, $28, $90, $0E, $2A, $2A, $F1, $0E, $39
    db $24, $2F, $38, $24, $37, $32, $35, $B5, $FA, $F7, $EF, $EE, $16, $24, $3C, $90
    db $12, $90, $2B, $28, $2F, $33, $90, $3C, $32, $38, $90, $2C, $31, $EF, $EE, $24
    db $31, $3C, $90, $3A, $24, $3C, $90, $37, $32, $27, $24, $3C, $98, $F7, $F0

Data_099_78EE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2678EE, $67

Data_099_7955:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $10, $32, $90, $27, $32, $3A, $31, $90, $37, $2B, $28, $36, $28
    db $F1, $36, $37, $24, $2C, $35, $36, $90, $37, $32, $90, $37, $2B, $28, $FA, $F7
    db $EF, $EE, $1C, $37, $24, $35, $35, $3C, $90, $1C, $2B, $35, $2C, $31, $28, $B5
    db $EF, $EE, $F7, $F0

Data_099_7989:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $267989, $F7

Data_099_7A80:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $267A80, $44

Data_099_7AC4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $267AC4, $52

Data_099_7B16:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $267B16, $174

Data_099_7C8A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $24, $2F, $2E, $90, $37, $32, $90, $37, $2B, $28, $90, $19
    db $35, $32, $29, $F1, $2C, $29, $90, $3C, $32, $38, $90, $31, $28, $28, $27, $90
    db $2B, $28, $2F, $33, $B5, $F7, $F0

Data_099_7CB1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $267CB1, $152

Data_099_7E03:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $267E03, $E9

Data_099_7EEC:: ; heuristic: target of a monotone pointer table; C0
    db $EA

Data_099_7EED:: ; heuristic: target of a monotone pointer table; C0
    db $F0
    ds $112, $00
