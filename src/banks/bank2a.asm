SECTION "Bank 2A", ROMX[$4000], BANK[$2A]
    db $2A

Func_02A_4001::
    ld a, [$C529]
    cp a, $95
    jr c, Jump_02A_400F
    ld hl, $404B
    ld b, $97
    rst $10
    ret

Jump_02A_400F::
    ld de, $4032
    call Func_000_25C9
    ret

Func_02A_4016:: ; heuristic: follows a terminator; C0
    ld a, [$C529]
    cp a, $95
    jr c, Jump_02A_4024
    ld hl, $405A
    ld b, $97
    rst $10
    ret

Jump_02A_4024::
    ld de, $4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9, $34, $40
    dw Data_02A_415E
    dw Data_02A_4284
    dw Data_02A_429B
    dw Data_02A_42B9
    dw Data_02A_42FC
    dw Data_02A_4366
    dw Data_02A_438C
    dw Data_02A_44AF
    dw Data_02A_461C
    dw Data_02A_4735
    dw Data_02A_47A3
    dw Data_02A_4817
    dw Data_02A_48A8
    dw Data_02A_493B
    dw Data_02A_4A15
    dw Data_02A_4A3D
    dw Data_02A_4AD1
    dw Data_02A_4B18
    dw Data_02A_4BA4
    dw Data_02A_4BFA
    dw Data_02A_4C19
    dw Data_02A_4C5F
    dw Data_02A_4C84
    dw Data_02A_4D67
    dw Data_02A_4D67
    dw Data_02A_4D67
    dw Data_02A_4D67
    dw Data_02A_4D67
    dw Data_02A_4DAE
    dw Data_02A_4E28
    dw Data_02A_4E4B
    dw Data_02A_4E72
    dw Data_02A_4EFB
    dw Data_02A_4F87
    dw Data_02A_5039
    dw Data_02A_50E8
    dw Data_02A_51B8
    dw Data_02A_5203
    dw Data_02A_5245
    dw Data_02A_5280
    dw Data_02A_52BE
    dw Data_02A_53D2
    dw Data_02A_53F2
    dw Data_02A_54C6
    dw Data_02A_550C
    dw Data_02A_5557
    dw Data_02A_55C0
    dw Data_02A_55E1
    dw Data_02A_5623
    dw Data_02A_5666
    dw Data_02A_568B
    dw Data_02A_5762
    dw Data_02A_57C6
    dw Data_02A_583D
    dw Data_02A_58D9
    dw Data_02A_5956
    dw Data_02A_59D6
    dw Data_02A_5A74
    dw Data_02A_5B2D
    dw Data_02A_5C22
    dw Data_02A_5CEA
    dw Data_02A_5D67
    dw Data_02A_5DEC
    dw Data_02A_5E49
    dw Data_02A_5F03
    dw Data_02A_5F5E
    dw Data_02A_5F81
    dw Data_02A_5FC8
    dw Data_02A_603C
    dw Data_02A_60D4
    dw Data_02A_6116
    dw Data_02A_615E
    dw Data_02A_61BC
    dw Data_02A_61F3
    dw Data_02A_6289
    dw Data_02A_62CB
    dw Data_02A_62CB
    dw Data_02A_62CB
    dw Data_02A_62CB
    dw Data_02A_62CB
    dw Data_02A_62CB
    dw Data_02A_62CB
    dw Data_02A_62CB
    dw Data_02A_62CB
    dw Data_02A_62CB
    dw Data_02A_62CB
    dw Data_02A_6428
    dw Data_02A_6468
    dw Data_02A_64AD
    dw Data_02A_64D2
    dw Data_02A_6546
    dw Data_02A_657C
    dw Data_02A_664E
    dw Data_02A_6689
    dw Data_02A_66C3
    dw Data_02A_670B
    dw Data_02A_6770
    dw Data_02A_678A
    dw Data_02A_6815
    dw Data_02A_68AD
    dw Data_02A_6920
    dw Data_02A_69A3
    dw Data_02A_69E6
    dw Data_02A_6A06
    dw Data_02A_6A53
    dw Data_02A_6ACE
    dw Data_02A_6B07
    dw Data_02A_6B43
    dw Data_02A_6BBE
    dw Data_02A_6CDD
    dw Data_02A_6D44
    dw Data_02A_6D84
    dw Data_02A_6EE8
    dw Data_02A_7021
    dw Data_02A_7044
    dw Data_02A_7092
    dw Data_02A_70B0
    dw Data_02A_70F7
    dw Data_02A_7118
    dw Data_02A_7160
    dw Data_02A_71A0
    dw Data_02A_72CF
    dw Data_02A_731A
    dw Data_02A_7379
    dw Data_02A_73C0
    dw Data_02A_7432
    dw Data_02A_74BE
    dw Data_02A_74E0
    dw Data_02A_7557
    dw Data_02A_75B3
    dw Data_02A_7613
    dw Data_02A_7681
    dw Data_02A_76A4
    dw Data_02A_76E8
    dw Data_02A_774E
    dw Data_02A_7805
    dw Data_02A_784C
    dw Data_02A_78B6
    dw Data_02A_78FA
    dw Data_02A_79A8
    dw Data_02A_7AD7
    dw Data_02A_7B89
    dw Data_02A_7BCD
    dw Data_02A_7C12
    dw Data_02A_7C9E
    dw Data_02A_7CE9
    dw Data_02A_7D51
    dw Data_02A_7DE0
    dw Data_02A_7E6D

Data_02A_415E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A815E, $126

Data_02A_4284:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $30, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1
    db $02, $00, $00, $10, $B5, $F7, $F0

Data_02A_429B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0B, $38, $3C, $90, $15, $32, $39, $28, $20, $24, $37, $28, $35
    db $F1, $29, $32, $35, $90, $30, $28, $AB, $90, $18, $14, $98, $F7, $F0

Data_02A_42B9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A82B9, $43

Data_02A_42FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A82FC, $6A

Data_02A_4366:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $90, $27, $32, $31, $41, $90, $31, $28, $28, $27, $90, $24
    db $31, $3C, $F1, $2B, $28, $2F, $33, $90, $37, $32, $27, $24, $3C, $AB, $90, $27
    db $28, $24, $35, $B5, $F7, $F0

Data_02A_438C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A838C, $123

Data_02A_44AF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A84AF, $16D

Data_02A_461C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A861C, $119

Data_02A_4735:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8735, $6E

Data_02A_47A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A87A3, $74

Data_02A_4817:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8817, $91

Data_02A_48A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A88A8, $93

Data_02A_493B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A893B, $DA

Data_02A_4A15:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $99, $90, $11, $32, $3A, $90
    db $30, $24, $3C, $F1, $12, $90, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $90
    db $37, $32, $27, $24, $3C, $98, $F7, $F0

Data_02A_4A3D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8A3D, $94

Data_02A_4AD1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8AD1, $47

Data_02A_4B18:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8B18, $8C

Data_02A_4BA4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8BA4, $56

Data_02A_4BFA:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1, $37
    db $2B, $28, $90, $15, $32, $39, $28, $20, $24, $37, $28, $35, $B5, $F7, $F0

Data_02A_4C19:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8C19, $46

Data_02A_4C5F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $32, $32, $2B, $AB, $90, $15, $32, $39, $28, $20, $24, $37
    db $28, $35, $F1, $36, $32, $32, $37, $2B, $28, $36, $90, $36, $38, $31, $25, $38
    db $35, $31, $A4, $F7, $F0

Data_02A_4C84:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8C84, $E3

Data_02A_4D67:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8D67, $47

Data_02A_4DAE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8DAE, $7A

Data_02A_4E28:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $24, $2E, $28, $90, $37, $2B, $2C, $36, $90, $36, $2F, $2C
    db $27, $28, $F1, $24, $36, $90, $24, $90, $36, $2B, $32, $35, $37, $26, $38, $37
    db $99, $F7, $F0

Data_02A_4E4B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $3E, $90, $28, $24, $36, $3C, $90, $37, $32, $90, $2A
    db $28, $37, $F1, $27, $32, $3A, $31, $AB, $90, $25, $38, $37, $90, $38, $33, $98
    db $90, $1E, $2A, $2B, $B5, $F7, $F0

Data_02A_4E72:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8E72, $89

Data_02A_4EFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8EFB, $8C

Data_02A_4F87:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A8F87, $B2

Data_02A_5039:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9039, $AF

Data_02A_50E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A90E8, $D0

Data_02A_51B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A91B8, $4B

Data_02A_5203:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9203, $42

Data_02A_5245:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $35, $28, $90, $3A, $24, $36, $90, $24, $2F, $36, $32, $90, $24
    db $F1, $2F, $28, $37, $37, $28, $35, $B5, $FA, $F7, $EF, $EE, $95, $1D, $2B, $2C
    db $36, $90, $2C, $36, $90, $24, $90, $2A, $2C, $29, $37, $B5, $EF, $EE, $0F, $3A
    db $32, $2B, $32, $2B, $32, $2B, $32, $99, $95, $F7, $F0

Data_02A_5280:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $33
    db $28, $27, $28, $36, $37, $24, $2F, $B5, $FA, $F7, $EF, $EE, $12, $37, $3E, $90
    db $37, $2B, $28, $90, $15, $2C, $25, $35, $24, $35, $3C, $EF, $EE, $10, $38, $2C
    db $27, $28, $B5, $90, $1B, $28, $24, $27, $90, $2C, $37, $98, $FF, $F0

Data_02A_52BE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A92BE, $114

Data_02A_53D2:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $38, $37, $90, $25, $24, $26, $2E, $90, $37, $2B, $28, $F1
    db $15, $2C, $25, $35, $24, $35, $3C, $90, $10, $38, $2C, $27, $28, $B5, $F7, $F0

Data_02A_53F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A93F2, $D4

Data_02A_54C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A94C6, $46

Data_02A_550C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A950C, $4B

Data_02A_5557:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9557, $69

Data_02A_55C0:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1C, $31, $2C, $39, $28, $2F, $A4, $90, $1D, $2B, $2C, $36, $F1
    db $25, $32, $32, $2E, $90, $2C, $36, $90, $36, $32, $90, $36, $24, $27, $A4, $F7
    db $F0

Data_02A_55E1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A95E1, $42

Data_02A_5623:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9623, $43

Data_02A_5666:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $A4, $90, $22, $32, $38, $42, $28, $90, $35, $28, $24
    db $27, $F1, $37, $2B, $2C, $36, $90, $25, $32, $32, $2E, $90, $25, $28, $29, $32
    db $35, $28, $B5, $F7, $F0

Data_02A_568B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A968B, $D7

Data_02A_5762:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9762, $64

Data_02A_57C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A97C6, $77

Data_02A_583D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A983D, $9C

Data_02A_58D9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A98D9, $7D

Data_02A_5956:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9956, $80

Data_02A_59D6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A99D6, $9E

Data_02A_5A74:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9A74, $B9

Data_02A_5B2D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9B2D, $F5

Data_02A_5C22:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9C22, $C8

Data_02A_5CEA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9CEA, $7D

Data_02A_5D67:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9D67, $85

Data_02A_5DEC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9DEC, $5D

Data_02A_5E49:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9E49, $BA

Data_02A_5F03:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9F03, $5B

Data_02A_5F5E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $35, $3C, $90, $37, $2B, $28, $90, $36, $2F, $2C, $27, $28
    db $99, $F1, $12, $37, $3E, $90, $24, $90, $36, $2B, $32, $35, $37, $26, $38, $37
    db $99, $F7, $F0

Data_02A_5F81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9F81, $47

Data_02A_5FC8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A9FC8, $74

Data_02A_603C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA03C, $98

Data_02A_60D4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA0D4, $42

Data_02A_6116:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA116, $48

Data_02A_615E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA15E, $5E

Data_02A_61BC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $32, $32, $27, $AB, $90, $3C, $32, $38, $40, $28, $F1, $2F
    db $38, $26, $2E, $3C, $99, $FA, $F7, $EF, $EE, $1C, $37, $24, $3C, $90, $24, $3A
    db $24, $3C, $AB, $90, $37, $2B, $24, $37, $3E, $EF, $EE, $37, $2B, $28, $90, $37
    db $2B, $2C, $31, $2A, $B5, $F7, $F0

Data_02A_61F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA1F3, $96

Data_02A_6289:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA289, $42

Data_02A_62CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA2CB, $15D

Data_02A_6428:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $27
    db $35, $28, $36, $36, $28, $35, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $3A, $24
    db $36, $90, $2D, $24, $30, $30, $28, $27, $90, $3A, $2C, $37, $2B, $EF, $EE, $29
    db $24, $31, $26, $3C, $90, $26, $2F, $32, $37, $2B, $2C, $31, $2A, $B5, $F7, $F0

Data_02A_6468:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA468, $45

Data_02A_64AD:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $16, $32, $31, $36, $37, $28, $35, $36, $90, $36, $2B, $32, $38
    db $2F, $27, $F1, $2B, $24, $39, $28, $90, $26, $38, $37, $28, $90, $31, $24, $30
    db $28, $36, $B5, $F7, $F0

Data_02A_64D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA4D2, $74

Data_02A_6546:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $27
    db $35, $28, $36, $36, $28, $35, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $3A, $24
    db $36, $90, $37, $2C, $27, $2C, $2F, $3C, $EF, $EE, $32, $35, $2A, $24, $31, $2C
    db $3D, $28, $27, $B5, $F7, $F0

Data_02A_657C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA57C, $D2

Data_02A_664E:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $30, $2C, $35, $35, $32, $35, $B5, $FA, $F7, $EF, $EE, $0A, $90
    db $2F, $2C, $37, $37, $2F, $28, $90, $2A, $2C, $35, $2F, $EF, $EE, $33, $28, $28
    db $35, $28, $27, $90, $25, $24, $26, $2E, $B5, $F7, $F0

Data_02A_6689:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $30, $2C, $35, $35, $32, $35, $B5, $FA, $F7, $EF, $EE, $0A, $90
    db $2F, $2C, $37, $37, $2F, $28, $90, $25, $32, $3C, $EF, $EE, $36, $37, $24, $35
    db $28, $27, $90, $25, $24, $26, $2E, $B5, $F7, $F0

Data_02A_66C3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA6C3, $48

Data_02A_670B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA70B, $65

Data_02A_6770:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $24, $90, $15, $2C
    db $29, $28, $0A, $26, $32, $35, $31, $B5, $F7, $F0

Data_02A_678A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA78A, $8B

Data_02A_6815:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA815, $98

Data_02A_68AD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA8AD, $73

Data_02A_6920:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA920, $83

Data_02A_69A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AA9A3, $43

Data_02A_69E6:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $A4, $90, $1C, $32, $35, $35, $3C, $A4, $F1, $12, $37
    db $3E, $90, $3C, $32, $38, $35, $90, $29, $35, $2C, $28, $31, $27, $A4, $F7, $F0

Data_02A_6A06:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AAA06, $4D

Data_02A_6A53:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AAA53, $7B

Data_02A_6ACE:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $27
    db $35, $28, $36, $36, $28, $35, $B5, $FA, $F7, $EF, $EE, $10, $2C, $35, $2F, $36
    db $95, $90, $26, $2F, $32, $37, $2B, $28, $36, $EF, $EE, $3A, $28, $35, $28, $90
    db $2C, $31, $36, $2C, $27, $28, $B5, $F7, $F0

Data_02A_6B07:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $33
    db $2F, $38, $36, $2B, $90, $27, $32, $2F, $2F, $B5, $FA, $F7, $EF, $EE, $12, $37
    db $90, $2B, $24, $27, $90, $33, $24, $37, $26, $2B, $28, $36, $90, $24, $2F, $2F
    db $EF, $EE, $32, $39, $28, $35, $90, $2C, $37, $B5, $F7, $F0

Data_02A_6B43:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AAB43, $7B

Data_02A_6BBE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AABBE, $11F

Data_02A_6CDD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AACDD, $67

Data_02A_6D44:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $22, $32, $38, $90, $2F, $32, $36, $37, $98, $F1, $1D, $2B, $24
    db $37, $3E, $90, $37, $32, $32, $90, $25, $24, $27, $B5, $FA, $F7, $EF, $EE, $1D
    db $35, $24, $2C, $31, $90, $36, $32, $30, $28, $90, $30, $32, $35, $28, $EF, $EE
    db $24, $31, $27, $90, $37, $35, $3C, $90, $24, $2A, $24, $2C, $31, $99, $F7, $F0

Data_02A_6D84:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AAD84, $164

Data_02A_6EE8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AAEE8, $139

Data_02A_7021:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $11, $28, $2F, $2F, $32, $AB, $90, $3A, $2B, $2C, $26, $2B, $F1
    db $0C, $2F, $24, $36, $36, $90, $3A, $2C, $2F, $2F, $90, $2C, $37, $90, $25, $28
    db $98, $F7, $F0

Data_02A_7044:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB044, $4E

Data_02A_7092:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $24, $90, $16, $24
    db $2A, $2C, $26, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_02A_70B0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB0B0, $47

Data_02A_70F7:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $11, $28, $35, $28, $3E, $90, $37, $2B, $28, $90, $16, $24, $2A
    db $2C, $26, $F1, $14, $28, $3C, $90, $3C, $32, $38, $90, $3A, $32, $31, $99, $F7
    db $F0

Data_02A_7118:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB118, $48

Data_02A_7160:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $90, $37, $32, $90, $37, $2B
    db $28, $F1, $0A, $35, $28, $31, $24, $99, $FA, $F7, $EF, $EE, $20, $32, $38, $2F
    db $27, $90, $3C, $32, $38, $90, $2F, $2C, $2E, $28, $90, $37, $32, $EF, $EE, $2B
    db $28, $24, $35, $90, $37, $2B, $28, $90, $35, $38, $2F, $28, $36, $98, $FF, $F0

Data_02A_71A0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB1A0, $12F

Data_02A_72CF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB2CF, $4B

Data_02A_731A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB31A, $5F

Data_02A_7379:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB379, $47

Data_02A_73C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB3C0, $72

Data_02A_7432:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB432, $8C

Data_02A_74BE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $1B, $0A, $11, $AB, $90, $11, $1E, $17, $10, $1B, $22, $B5
    db $F1, $15, $18, $18, $14, $90, $0D, $0E, $15, $12, $0C, $12, $18, $1E, $1C, $A4
    db $F7, $F0

Data_02A_74E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB4E0, $77

Data_02A_7557:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB557, $5C

Data_02A_75B3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB5B3, $60

Data_02A_7613:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB613, $6E

Data_02A_7681:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $B5, $90, $20, $28, $2F, $2F, $AB, $90, $12, $43, $2F
    db $F1, $25, $28, $90, $2B, $28, $35, $28, $90, $29, $32, $35, $90, $3C, $32, $38
    db $B5, $F7, $F0

Data_02A_76A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB6A4, $44

Data_02A_76E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB6E8, $66

Data_02A_774E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB74E, $B7

Data_02A_7805:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB805, $47

Data_02A_784C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB84C, $6A

Data_02A_78B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB8B6, $44

Data_02A_78FA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB8FA, $AE

Data_02A_79A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0AB9A8, $12F

Data_02A_7AD7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ABAD7, $B2

Data_02A_7B89:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ABB89, $44

Data_02A_7BCD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ABBCD, $45

Data_02A_7C12:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ABC12, $8C

Data_02A_7C9E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ABC9E, $4B

Data_02A_7CE9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ABCE9, $68

Data_02A_7D51:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ABD51, $8F

Data_02A_7DE0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ABDE0, $8D

Data_02A_7E6D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ABE6D, $84
    ds $10F, $00
