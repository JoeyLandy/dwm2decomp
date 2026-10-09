SECTION "Bank 29", ROMX[$4000], BANK[$29]
    db $29

Func_029_4001::
    ld a, [$C529]
    cp a, $8E
    jr c, Jump_029_400F
    ld hl, $4026
    ld b, $97
    rst $10
    ret

Jump_029_400F::
    ld de, Data_029_4032
    call Func_000_25C9
    ret

Func_029_4016:: ; heuristic: follows a terminator; C0
    ld a, [$C529]
    cp a, $8E
    jr c, Jump_029_4024
    ld hl, $4035
    ld b, $97
    rst $10
    ret

Jump_029_4024::
    ld de, Data_029_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_029_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $34, $40
    dw Data_029_4150
    dw Data_029_4191
    dw Data_029_41A7
    dw Data_029_4200
    dw Data_029_4273
    dw Data_029_4303
    dw Data_029_4401
    dw Data_029_441B
    dw Data_029_44A7
    dw Data_029_4507
    dw Data_029_4572
    dw Data_029_45FD
    dw Data_029_464A
    dw Data_029_468C
    dw Data_029_4735
    dw Data_029_4755
    dw Data_029_4801
    dw Data_029_4841
    dw Data_029_4866
    dw Data_029_49E8
    dw Data_029_4A0B
    dw Data_029_4A6E
    dw Data_029_4AD4
    dw Data_029_4B19
    dw Data_029_4B83
    dw Data_029_4BE0
    dw Data_029_4C70
    dw Data_029_4CFA
    dw Data_029_4D3E
    dw Data_029_4E1B
    dw Data_029_4E3C
    dw Data_029_4EF6
    dw Data_029_4F32
    dw Data_029_4F54
    dw Data_029_5020
    dw Data_029_5020
    dw Data_029_5020
    dw Data_029_5020
    dw Data_029_5065
    dw Data_029_50AD
    dw Data_029_5136
    dw Data_029_517D
    dw Data_029_51C6
    dw Data_029_5242
    dw Data_029_52F9
    dw Data_029_5444
    dw Data_029_54C5
    dw Data_029_54C5
    dw Data_029_54C5
    dw Data_029_54EA
    dw Data_029_5556
    dw Data_029_559E
    dw Data_029_560D
    dw Data_029_5671
    dw Data_029_56BB
    dw Data_029_570A
    dw Data_029_5745
    dw Data_029_57D5
    dw Data_029_583F
    dw Data_029_5865
    dw Data_029_5940
    dw Data_029_59AE
    dw Data_029_5A13
    dw Data_029_5A9F
    dw Data_029_5B4D
    dw Data_029_5B93
    dw Data_029_5C03
    dw Data_029_5CB3
    dw Data_029_5D21
    dw Data_029_5D81
    dw Data_029_5DA7
    dw Data_029_5E31
    dw Data_029_5E74
    dw Data_029_5F59
    dw Data_029_601B
    dw Data_029_6129
    dw Data_029_622E
    dw Data_029_6299
    dw Data_029_6327
    dw Data_029_638E
    dw Data_029_63CC
    dw Data_029_6437
    dw Data_029_6480
    dw Data_029_64C9
    dw Data_029_65A0
    dw Data_029_65EE
    dw Data_029_6665
    dw Data_029_668A
    dw Data_029_66D8
    dw Data_029_6722
    dw Data_029_6791
    dw Data_029_6820
    dw Data_029_685F
    dw Data_029_68A3
    dw Data_029_6955
    dw Data_029_6995
    dw Data_029_69D7
    dw Data_029_6A40
    dw Data_029_6BE2
    dw Data_029_6C4B
    dw Data_029_6C83
    dw Data_029_6CC4
    dw Data_029_6D0A
    dw Data_029_6D52
    dw Data_029_6DB5
    dw Data_029_6E41
    dw Data_029_6ED9
    dw Data_029_6F1E
    dw Data_029_6F62
    dw Data_029_7028
    dw Data_029_70C0
    dw Data_029_712A
    dw Data_029_7171
    dw Data_029_7208
    dw Data_029_7292
    dw Data_029_72FA
    dw Data_029_731D
    dw Data_029_73AC
    dw Data_029_73F5
    dw Data_029_74D9
    dw Data_029_753F
    dw Data_029_75A5
    dw Data_029_764F
    dw Data_029_769A
    dw Data_029_7700
    dw Data_029_7745
    dw Data_029_77F4
    dw Data_029_785F
    dw Data_029_78A8
    dw Data_029_7934
    dw Data_029_79E6
    dw Data_029_7A07
    dw Data_029_7A51
    dw Data_029_7AAE
    dw Data_029_7B57
    dw Data_029_7BC2
    dw Data_029_7C89
    dw Data_029_7D09
    dw Data_029_7D24
    dw Data_029_7DFE
    dw Data_029_7E18
    dw Data_029_7E31

Data_029_4150:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4150, $41

Data_029_4191:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $24, $31, $F1, $11
    db $28, $35, $25, $B5, $F7, $F0

Data_029_41A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A41A7, $59

Data_029_4200:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4200, $73

Data_029_4273:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4273, $90

Data_029_4303:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4303, $FE

Data_029_4401:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $24, $EF, $EE, $19
    db $32, $35, $2E, $0C, $2B, $32, $33, $B5, $F7, $F0

Data_029_441B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A441B, $8C

Data_029_44A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A44A7, $60

Data_029_4507:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4507, $6B

Data_029_4572:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4572, $8B

Data_029_45FD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A45FD, $4D

Data_029_464A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A464A, $42

Data_029_468C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A468C, $A9

Data_029_4735:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $32, $25, $2C, $A3, $90, $11, $2C, $AB, $90, $F9, $00, $99, $F1, $20
    db $2B, $24, $37, $3E, $90, $38, $33, $90, $37, $32, $27, $24, $3C, $98, $F7, $F0

Data_029_4755:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4755, $AC

Data_029_4801:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $1D, $24, $35, $24, $A3, $90, $11, $2C, $99, $F1, $11, $32, $3A, $90, $24
    db $35, $28, $90, $3C, $32, $38, $98, $FA, $F7, $EF, $EE, $0D, $32, $90, $3C, $32
    db $38, $90, $31, $28, $28, $27, $90, $30, $28, $90, $29, $32, $35, $EF, $EE, $24
    db $31, $3C, $37, $2B, $2C, $31, $2A, $90, $37, $32, $27, $24, $3C, $98, $F7, $F0

Data_029_4841:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $24, $31, $37, $90, $37, $32, $90, $2E, $31, $32, $3A, $90
    db $2B, $32, $3A, $F1, $37, $2B, $28, $90, $29, $24, $35, $30, $90, $3A, $32, $35
    db $2E, $36, $98, $FF, $F0

Data_029_4866:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4866, $182

Data_029_49E8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $3A, $3A, $A4, $90, $22, $32, $38, $90, $2E, $31, $32, $3A
    db $F1, $24, $2F, $35, $28, $24, $27, $3C, $98, $90, $0B, $32, $35, $2C, $31, $2A
    db $99, $F7, $F0

Data_029_4A0B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4A0B, $63

Data_029_4A6E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4A6E, $66

Data_029_4AD4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4AD4, $45

Data_029_4B19:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4B19, $6A

Data_029_4B83:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4B83, $5D

Data_029_4BE0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4BE0, $90

Data_029_4C70:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4C70, $8A

Data_029_4CFA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4CFA, $44

Data_029_4D3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4D3E, $DD

Data_029_4E1B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $32, $3A, $90, $30, $24, $3C, $90, $37, $2B, $28, $F1, $1F
    db $24, $38, $2F, $37, $90, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $98, $F7
    db $F0

Data_029_4E3C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4E3C, $BA

Data_029_4EF6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $20, $24, $9C, $2B, $28, $3C
    db $99, $F1, $FA, $F7, $EF, $EE, $F3, $22, $32, $38, $90, $35, $28, $30, $28, $30
    db $25, $28, $35, $90, $37, $2B, $28, $EF, $EE, $33, $35, $32, $30, $2C, $36, $28
    db $90, $3C, $32, $38, $90, $30, $24, $27, $28, $98, $FF, $F0

Data_029_4F32:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $1A, $38, $2C, $37, $F1, $27
    db $24, $3A, $27, $2F, $2C, $31, $2A, $AB, $90, $3A, $24, $35, $32, $32, $2B, $99
    db $F7, $F0

Data_029_4F54:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A4F54, $CC

Data_029_5020:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5020, $45

Data_029_5065:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5065, $48

Data_029_50AD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A50AD, $89

Data_029_5136:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5136, $47

Data_029_517D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A517D, $49

Data_029_51C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A51C6, $7C

Data_029_5242:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5242, $B7

Data_029_52F9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A52F9, $14B

Data_029_5444:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5444, $81

Data_029_54C5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $2C, $36, $90, $14, $24, $2F, $2E, $24
    db $AB, $F1, $24, $31, $90, $32, $24, $36, $2C, $36, $90, $39, $2C, $2F, $2F, $24
    db $2A, $28, $B5, $F7, $F0

Data_029_54EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A54EA, $6C

Data_029_5556:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5556, $48

Data_029_559E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A559E, $6F

Data_029_560D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A560D, $64

Data_029_5671:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5671, $4A

Data_029_56BB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A56BB, $4F

Data_029_570A:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $32
    db $39, $28, $31, $B5, $FA, $F7, $EF, $EE, $0A, $90, $36, $2B, $24, $35, $33, $AB
    db $90, $36, $33, $2C, $26, $3C, $EF, $EE, $24, $35, $32, $30, $24, $90, $3A, $24
    db $29, $37, $28, $27, $90, $32, $38, $37, $B5, $F7, $F0

Data_029_5745:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5745, $90

Data_029_57D5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A57D5, $6A

Data_029_583F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $2C, $36, $90, $0A, $36, $2C, $3C, $24
    db $AB, $F1, $37, $2B, $28, $90, $27, $28, $36, $28, $35, $37, $90, $29, $2F, $32
    db $3A, $28, $35, $B5, $F7, $F0

Data_029_5865:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5865, $DB

Data_029_5940:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5940, $6E

Data_029_59AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A59AE, $65

Data_029_5A13:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5A13, $8C

Data_029_5A9F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5A9F, $AE

Data_029_5B4D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5B4D, $46

Data_029_5B93:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5B93, $70

Data_029_5C03:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5C03, $B0

Data_029_5CB3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5CB3, $6E

Data_029_5D21:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5D21, $60

Data_029_5D81:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2F, $2F, $32, $99, $90, $11, $32, $3A, $90, $30, $24
    db $3C, $90, $12, $F1, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $90, $37, $32
    db $27, $24, $3C, $98, $F7, $F0

Data_029_5DA7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5DA7, $8A

Data_029_5E31:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5E31, $43

Data_029_5E74:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5E74, $E5

Data_029_5F59:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A5F59, $C2

Data_029_601B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A601B, $10E

Data_029_6129:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6129, $105

Data_029_622E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A622E, $6B

Data_029_6299:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6299, $8E

Data_029_6327:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6327, $67

Data_029_638E:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $39, $24, $36, $28, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $3A
    db $24, $36, $90, $29, $2C, $2F, $2F, $28, $27, $90, $3A, $2C, $37, $2B, $EF, $EE
    db $24, $90, $2A, $32, $32, $28, $3C, $90, $32, $2C, $2F, $B5, $F7, $F0

Data_029_63CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A63CC, $6B

Data_029_6437:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6437, $49

Data_029_6480:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6480, $49

Data_029_64C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A64C9, $D7

Data_029_65A0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A65A0, $4E

Data_029_65EE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A65EE, $77

Data_029_6665:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $3A, $32, $31, $27, $28, $35, $90, $2C, $29, $90, $37
    db $2B, $28, $F1, $32, $37, $2B, $28, $35, $36, $90, $24, $35, $28, $90, $36, $24
    db $29, $28, $A4, $F7, $F0

Data_029_668A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A668A, $4E

Data_029_66D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A66D8, $4A

Data_029_6722:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6722, $6F

Data_029_6791:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6791, $8F

Data_029_6820:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $90, $29, $35, $32, $3A, $31, $90, $38, $33, $32, $31
    db $F1, $36, $37, $35, $24, $31, $2A, $28, $35, $36, $90, $3A, $2B, $32, $FA, $F7
    db $EF, $EE, $3A, $24, $31, $27, $28, $35, $90, $37, $2B, $35, $32, $38, $2A, $2B
    db $90, $32, $38, $35, $EF, $EE, $26, $24, $36, $37, $2F, $28, $99, $F7, $F0

Data_029_685F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A685F, $44

Data_029_68A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A68A3, $B2

Data_029_6955:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $AB, $90, $2C, $37, $90, $2F, $32, $32, $2E, $28, $27
    db $F1, $2F, $2C, $2E, $28, $90, $3C, $32, $38, $90, $3A, $28, $35, $28, $90, $32
    db $31, $FA, $F7, $EF, $EE, $37, $2B, $28, $90, $33, $35, $32, $3A, $2F, $90, $29
    db $32, $35, $EF, $EE, $36, $32, $30, $28, $37, $2B, $2C, $31, $2A, $B5, $F7, $F0

Data_029_6995:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6995, $42

Data_029_69D7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A69D7, $69

Data_029_6A40:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6A40, $1A2

Data_029_6BE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6BE2, $69

Data_029_6C4B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $2C, $31, $2A, $A3, $90, $18, $2B, $A4, $F1, $22, $32, $38, $90, $3A
    db $32, $31, $41, $98, $FA, $F7, $EF, $EE, $1D, $2B, $28, $31, $AB, $90, $12, $90
    db $26, $24, $31, $41, $90, $2B, $28, $2F, $33, $EF, $EE, $3C, $32, $38, $90, $28
    db $2C, $37, $2B, $28, $35, $B5, $F7, $F0

Data_029_6C83:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6C83, $41

Data_029_6CC4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6CC4, $46

Data_029_6D0A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6D0A, $48

Data_029_6D52:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6D52, $63

Data_029_6DB5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6DB5, $8C

Data_029_6E41:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6E41, $98

Data_029_6ED9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6ED9, $45

Data_029_6F1E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6F1E, $44

Data_029_6F62:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A6F62, $C6

Data_029_7028:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7028, $98

Data_029_70C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A70C0, $6A

Data_029_712A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A712A, $47

Data_029_7171:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7171, $97

Data_029_7208:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7208, $8A

Data_029_7292:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7292, $68

Data_029_72FA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $16, $3C, $AB, $90, $32, $38, $35, $90, $14, $2C, $31, $2A
    db $F1, $2B, $24, $36, $90, $31, $32, $90, $33, $24, $37, $2C, $28, $31, $26, $28
    db $A4, $F7, $F0

Data_029_731D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A731D, $8F

Data_029_73AC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A73AC, $49

Data_029_73F5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A73F5, $E4

Data_029_74D9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A74D9, $66

Data_029_753F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A753F, $66

Data_029_75A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A75A5, $AA

Data_029_764F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A764F, $4B

Data_029_769A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A769A, $66

Data_029_7700:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7700, $45

Data_029_7745:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7745, $AF

Data_029_77F4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A77F4, $6B

Data_029_785F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A785F, $49

Data_029_78A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A78A8, $8C

Data_029_7934:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7934, $B2

Data_029_79E6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $2C, $31, $2A, $A3, $90, $20, $2B, $24, $9C, $3A, $2B, $24, $37, $98
    db $F1, $20, $2B, $24, $37, $90, $2B, $24, $33, $33, $28, $31, $28, $27, $98, $F7
    db $F0

Data_029_7A07:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7A07, $4A

Data_029_7A51:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7A51, $5D

Data_029_7AAE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7AAE, $A9

Data_029_7B57:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7B57, $6B

Data_029_7BC2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7BC2, $C7

Data_029_7C89:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7C89, $80

Data_029_7D09:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1, $36
    db $32, $30, $28, $90, $29, $32, $32, $27, $B5, $F7, $F0

Data_029_7D24:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7D24, $DA

Data_029_7DFE:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $24, $F1, $20, $24
    db $37, $28, $35, $0C, $24, $2F, $2F, $B5, $F7, $F0

Data_029_7E18:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $27, $90, $31, $32, $90, $29, $32, $32, $27, $F1, $37
    db $32, $90, $2A, $2C, $39, $28, $A4, $F7, $F0

Data_029_7E31:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0A7E31, $65
    ds $16A, $00
