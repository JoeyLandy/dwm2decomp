SECTION "Bank 7C", ROMX[$4000], BANK[$7C]
    db $7C

Func_07C_4001::
    ld a, [$C529]
    cp a, $87
    jr c, Jump_07C_400F
    ld hl, $404B
    ld b, $99
    rst $10
    ret

Jump_07C_400F::
    ld de, Data_07C_4032
    call Func_000_25C9
    ret

Func_07C_4016:: ; heuristic: follows a terminator; C0
    ld a, [$C529]
    cp a, $87
    jr c, Jump_07C_4024
    ld hl, Data_07C_405A
    ld b, $99
    rst $10
    ret

Jump_07C_4024::
    ld de, Data_07C_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_07C_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $34, $40
    dw Data_07C_4142
    dw Data_07C_4186
    dw Data_07C_41C9
    dw Data_07C_427A
    dw Data_07C_42E3
    dw Data_07C_436D
    dw Data_07C_4424
    dw Data_07C_4464
    dw Data_07C_4483
    dw Data_07C_44C0
    dw Data_07C_44FE
    dw Data_07C_4542
    dw Data_07C_4586
    dw Data_07C_45DE
    dw Data_07C_46F6
    dw Data_07C_47C4
    dw Data_07C_4853
    dw Data_07C_4902
    dw Data_07C_4926

Data_07C_405A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_07C_4998
    dw Data_07C_49B2
    dw Data_07C_4A49
    dw Data_07C_4ABB
    dw Data_07C_4B68
    dw Data_07C_4B8A
    dw Data_07C_4BCA
    dw Data_07C_4BFF
    dw Data_07C_4DE4
    dw Data_07C_4E6D
    dw Data_07C_4EDB
    dw Data_07C_4F22
    dw Data_07C_4FBB
    dw Data_07C_509F
    dw Data_07C_50C1
    dw Data_07C_5168
    dw Data_07C_51FE
    dw Data_07C_5243
    dw Data_07C_52F3
    dw Data_07C_53B3
    dw Data_07C_5448
    dw Data_07C_54D6
    dw Data_07C_54D6
    dw Data_07C_5588
    dw Data_07C_5617
    dw Data_07C_56F3
    dw Data_07C_5711
    dw Data_07C_5735
    dw Data_07C_5778
    dw Data_07C_584D
    dw Data_07C_58DA
    dw Data_07C_593B
    dw Data_07C_597D
    dw Data_07C_5AB8
    dw Data_07C_5B4E
    dw Data_07C_5BE0
    dw Data_07C_5C48
    dw Data_07C_5C6A
    dw Data_07C_5CE5
    dw Data_07C_5D26
    dw Data_07C_5D44
    dw Data_07C_5DAB
    dw Data_07C_5FDC
    dw Data_07C_6155
    dw Data_07C_6177
    dw Data_07C_619C
    dw Data_07C_62FF
    dw Data_07C_6342
    dw Data_07C_6365
    dw Data_07C_63B0
    dw Data_07C_6420
    dw Data_07C_6444
    dw Data_07C_6519
    dw Data_07C_6565
    dw Data_07C_65B1
    dw Data_07C_66AD
    dw Data_07C_66D0
    dw Data_07C_6707
    dw Data_07C_672B
    dw Data_07C_6770
    dw Data_07C_6800
    dw Data_07C_68A9
    dw Data_07C_690E
    dw Data_07C_69A1
    dw Data_07C_69EA
    dw Data_07C_6AA4
    dw Data_07C_6B56
    dw Data_07C_6CE5
    dw Data_07C_6E11
    dw Data_07C_6EA6
    dw Data_07C_6F8D
    dw Data_07C_6FCF
    dw Data_07C_700E
    dw Data_07C_7053
    dw Data_07C_7090
    dw Data_07C_70AC
    dw Data_07C_7120
    dw Data_07C_718A
    dw Data_07C_71BE
    dw Data_07C_71FB
    dw Data_07C_723D
    dw Data_07C_7276
    dw Data_07C_72E8
    dw Data_07C_7327
    dw Data_07C_734C
    dw Data_07C_738C
    dw Data_07C_7434
    dw Data_07C_7496
    dw Data_07C_74BC
    dw Data_07C_7501
    dw Data_07C_7549
    dw Data_07C_7568
    dw Data_07C_7577
    dw Data_07C_76BE
    dw Data_07C_7707
    dw Data_07C_776D
    dw Data_07C_778B
    dw Data_07C_780E
    dw Data_07C_7879
    dw Data_07C_78D9
    dw Data_07C_7926
    dw Data_07C_796A
    dw Data_07C_7986
    dw Data_07C_79B9
    dw Data_07C_7A48
    dw Data_07C_7A91
    dw Data_07C_7AFB
    dw Data_07C_7B3D
    dw Data_07C_7BD2
    dw Data_07C_7C64
    dw Data_07C_7CDE
    dw Data_07C_7D25
    dw Data_07C_7D69
    dw Data_07C_7E01
    dw Data_07C_7E54
    dw Data_07C_7EAB

Data_07C_4142:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0142, $44

Data_07C_4186:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0186, $43

Data_07C_41C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F01C9, $B1

Data_07C_427A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F027A, $69

Data_07C_42E3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F02E3, $8A

Data_07C_436D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F036D, $B7

Data_07C_4424:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $1D, $2B, $28, $90, $25, $2C, $35, $27, $36, $90, $24, $35
    db $28, $F1, $31, $32, $2C, $36, $3C, $A4, $FA, $F7, $EF, $EE, $12, $37, $3E, $90
    db $24, $90, $36, $2C, $2A, $31, $90, $37, $2B, $24, $37, $90, $24, $EF, $EE, $34
    db $38, $24, $2E, $28, $90, $3A, $2C, $2F, $2F, $90, $2B, $2C, $37, $B5, $F7, $F0

Data_07C_4464:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $1C, $28, $28, $98, $90, $20, $2B, $24, $37, $90, $27, $2C
    db $27, $90, $12, $F1, $2D, $38, $36, $37, $90, $36, $24, $3C, $98, $F7, $F0

Data_07C_4483:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $2B, $32, $33, $28, $90, $37, $2B, $28, $F1, $39, $32
    db $2F, $26, $24, $31, $2C, $26, $90, $2C, $36, $2F, $24, $31, $27, $FA, $F7, $EF
    db $EE, $32, $29, $29, $90, $37, $2B, $28, $90, $26, $32, $24, $36, $37, $EF, $EE
    db $3A, $32, $31, $41, $90, $28, $35, $38, $33, $37, $A4, $F7, $F0

Data_07C_44C0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $27, $32, $31, $41, $90, $2B, $24, $39, $28, $F1, $30
    db $38, $26, $2B, $90, $25, $38, $37, $A4, $FA, $F7, $EF, $EE, $20, $32, $38, $2F
    db $27, $90, $3C, $32, $38, $90, $26, $24, $35, $28, $90, $37, $32, $EF, $EE, $36
    db $28, $28, $90, $30, $3C, $90, $3A, $24, $35, $28, $36, $98, $F7, $F0

Data_07C_44FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F04FE, $44

Data_07C_4542:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0542, $44

Data_07C_4586:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0586, $58

Data_07C_45DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F05DE, $118

Data_07C_46F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F06F6, $CE

Data_07C_47C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F07C4, $8F

Data_07C_4853:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0853, $AF

Data_07C_4902:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $31, $90, $12, $43, $2F, $90, $36, $2C, $31, $2A
    db $99, $F1, $15, $24, $2F, $24, $2F, $24, $9D, $90, $2F, $24, $2F, $24, $90, $2F
    db $24, $9D, $F7, $F0

Data_07C_4926:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0926, $72

Data_07C_4998:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $24, $90, $1D, $2C
    db $31, $3C, $16, $28, $27, $24, $2F, $B5, $F7, $F0

Data_07C_49B2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F09B2, $97

Data_07C_4A49:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0A49, $72

Data_07C_4ABB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0ABB, $AD

Data_07C_4B68:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2B, $A4, $90, $1C, $2B, $24, $30, $28, $A4, $F1, $19, $2F
    db $28, $24, $36, $28, $90, $26, $32, $30, $28, $90, $24, $2A, $24, $2C, $31, $B5
    db $F7, $F0

Data_07C_4B8A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $24, $39, $28, $90, $3C, $32, $38, $90, $2B, $28, $24, $35
    db $27, $F1, $37, $2B, $28, $90, $2F, $28, $2A, $28, $31, $27, $90, $24, $25, $32
    db $38, $37, $FA, $F7, $EF, $EE, $37, $2B, $28, $90, $30, $28, $35, $30, $24, $2C
    db $27, $36, $95, $EF, $EE, $37, $35, $28, $24, $36, $38, $35, $28, $98, $FF, $F0

Data_07C_4BCA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2B, $AB, $90, $3C, $32, $38, $42, $28, $90, $2B, $28, $24
    db $35, $27, $F1, $24, $2F, $35, $28, $24, $27, $3C, $B5, $FA, $F7, $EF, $EE, $12
    db $37, $3E, $90, $24, $90, $37, $35, $24, $2A, $2C, $26, $90, $37, $24, $2F, $28
    db $B5, $EF, $EE, $F7, $F0

Data_07C_4BFF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0BFF, $1E5

Data_07C_4DE4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0DE4, $89

Data_07C_4E6D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0E6D, $6E

Data_07C_4EDB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0EDB, $47

Data_07C_4F22:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0F22, $99

Data_07C_4FBB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F0FBB, $E4

Data_07C_509F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $32, $3A, $90, $30, $24, $3C, $90, $32, $38, $35, $F1, $26
    db $2B, $38, $35, $26, $2B, $90, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $98
    db $F7, $F0

Data_07C_50C1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F10C1, $A7

Data_07C_5168:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1168, $96

Data_07C_51FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F11FE, $45

Data_07C_5243:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1243, $B0

Data_07C_52F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F12F3, $C0

Data_07C_53B3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F13B3, $95

Data_07C_5448:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1448, $8E

Data_07C_54D6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F14D6, $B2

Data_07C_5588:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1588, $8F

Data_07C_5617:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1617, $DC

Data_07C_56F3:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $37, $35, $2C, $28, $27, $90, $37, $32, $F1, $26, $2B, $28, $26
    db $2E, $90, $37, $2B, $28, $90, $26, $2B, $28, $36, $37, $B5, $F7, $F0

Data_07C_5711:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $32, $24, $99, $90, $11, $24, $31, $27, $36, $90, $32
    db $29, $29, $F1, $30, $3C, $90, $30, $28, $35, $26, $2B, $24, $31, $27, $2C, $36
    db $28, $99, $F7, $F0

Data_07C_5735:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1735, $43

Data_07C_5778:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1778, $D5

Data_07C_584D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F184D, $8D

Data_07C_58DA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F18DA, $61

Data_07C_593B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F193B, $42

Data_07C_597D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F197D, $13B

Data_07C_5AB8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1AB8, $96

Data_07C_5B4E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1B4E, $92

Data_07C_5BE0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1BE0, $68

Data_07C_5C48:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $31, $31, $31, $35, $A4, $90, $11, $2C, $26, $A4, $90, $10
    db $31, $31, $A4, $F1, $23, $3D, $3D, $A4, $90, $10, $29, $29, $29, $29, $29, $A4
    db $F7, $F0

Data_07C_5C6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1C6A, $7B

Data_07C_5CE5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1CE5, $41

Data_07C_5D26:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $23, $3D, $3D, $A4, $90, $23, $3D, $3D, $A4, $F1, $11, $38, $2B
    db $99, $90, $20, $24, $37, $26, $2B, $90, $32, $38, $37, $99, $F7, $F0

Data_07C_5D44:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1D44, $67

Data_07C_5DAB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1DAB, $231

Data_07C_5FDC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F1FDC, $179

Data_07C_6155:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $3E, $90, $24, $90, $37, $24, $2F, $28, $90, $32, $29
    db $F1, $2B, $2C, $2A, $2B, $90, $24, $27, $39, $28, $31, $37, $38, $35, $28, $A4
    db $F7, $F0

Data_07C_6177:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $98, $90, $0A, $35, $28, $90, $3C, $32, $38
    db $F1, $2B, $28, $35, $28, $90, $29, $32, $35, $90, $30, $3C, $90, $37, $24, $2F
    db $28, $36, $98, $FF, $F0

Data_07C_619C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F219C, $163

Data_07C_62FF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F22FF, $43

Data_07C_6342:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $37, $2C, $35, $28, $27, $90, $32, $29, $90, $37
    db $2B, $28, $F1, $2A, $28, $28, $3D, $28, $35, $3E, $90, $37, $24, $2F, $28, $36
    db $B5, $F7, $F0

Data_07C_6365:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2365, $4B

Data_07C_63B0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F23B0, $70

Data_07C_6420:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $A4, $90, $20, $2B, $24, $37, $90, $24, $35
    db $28, $F1, $3C, $32, $38, $90, $27, $32, $2C, $31, $2A, $98, $90, $1C, $37, $32
    db $33, $99, $F7, $F0

Data_07C_6444:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2444, $D5

Data_07C_6519:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2519, $4C

Data_07C_6565:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2565, $4C

Data_07C_65B1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F25B1, $FC

Data_07C_66AD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $24, $36, $37, $32, $31, $2C, $36, $2B, $28, $27
    db $B5, $F1, $16, $28, $35, $30, $24, $2C, $27, $36, $90, $28, $3B, $2C, $36, $37
    db $B5, $F7, $F0

Data_07C_66D0:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0D, $32, $90, $3C, $32, $38, $90, $3A, $24, $31, $37, $90, $37
    db $32, $F1, $2A, $32, $90, $37, $32, $90, $37, $2B, $28, $90, $2E, $2C, $31, $2A
    db $27, $32, $30, $FA, $F7, $EF, $EE, $32, $29, $90, $30, $28, $35, $30, $24, $2C
    db $27, $36, $98, $EF, $EE, $FF, $F0

Data_07C_6707:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0C, $2F, $32, $36, $28, $90, $3C, $32, $38, $35, $90, $28, $3C
    db $28, $36, $F1, $24, $90, $2F, $2C, $37, $37, $2F, $28, $90, $3A, $2B, $2C, $2F
    db $28, $B5, $F7, $F0

Data_07C_672B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F272B, $45

Data_07C_6770:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2770, $90

Data_07C_6800:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2800, $A9

Data_07C_68A9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F28A9, $65

Data_07C_690E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F290E, $93

Data_07C_69A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F29A1, $49

Data_07C_69EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F29EA, $BA

Data_07C_6AA4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2AA4, $B2

Data_07C_6B56:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2B56, $18F

Data_07C_6CE5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2CE5, $12C

Data_07C_6E11:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2E11, $95

Data_07C_6EA6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2EA6, $E7

Data_07C_6F8D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F2F8D, $42

Data_07C_6FCF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $37, $35, $28, $24, $36, $38, $35, $28, $36
    db $F1, $24, $35, $28, $90, $32, $38, $35, $36, $A4, $FA, $F7, $EF, $EE, $17, $32
    db $90, $32, $31, $28, $90, $3A, $2C, $2F, $2F, $90, $37, $24, $2E, $28, $EF, $EE
    db $37, $2B, $28, $30, $90, $29, $35, $32, $30, $90, $38, $36, $A4, $F7, $F0

Data_07C_700E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F300E, $45

Data_07C_7053:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $90, $31, $24, $2A, $36, $90, $24, $31, $27, $90, $31
    db $24, $2A, $36, $F1, $37, $2B, $24, $37, $90, $3A, $28, $90, $2F, $28, $29, $37
    db $90, $32, $38, $35, $FA, $F7, $EF, $EE, $37, $35, $28, $24, $36, $38, $35, $28
    db $36, $90, $25, $28, $2B, $2C, $31, $27, $A4, $EF, $EE, $F7, $F0

Data_07C_7090:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0C, $2B, $28, $26, $2E, $90, $37, $2B, $28, $90, $3A, $32, $32
    db $27, $28, $31, $F1, $26, $35, $24, $37, $28, $A4, $F7, $F0

Data_07C_70AC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F30AC, $74

Data_07C_7120:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3120, $6A

Data_07C_718A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0C, $2B, $2C, $2F, $27, $A4, $F1, $20, $28, $90, $2B, $24, $39
    db $28, $90, $2F, $32, $36, $37, $A4, $FA, $F7, $EF, $EE, $0F, $2C, $31, $24, $2F
    db $2F, $3C, $AB, $90, $3A, $28, $90, $26, $24, $31, $EF, $EE, $36, $2F, $28, $28
    db $33, $A4, $F7, $F0

Data_07C_71BE:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $33, $28, $28, $35, $28, $27, $90, $2C, $31, $37, $32, $F1, $37
    db $2B, $28, $90, $25, $24, $35, $35, $28, $2F, $B5, $FA, $F7, $EF, $EE, $0A, $90
    db $30, $38, $30, $30, $2C, $29, $2C, $28, $27, $90, $29, $2C, $36, $2B, $EF, $EE
    db $2F, $24, $3C, $90, $2C, $31, $36, $2C, $27, $28, $B5, $F7, $F0

Data_07C_71FB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F31FB, $42

Data_07C_723D:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $26
    db $35, $24, $37, $28, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28, $35, $28, $90, $3A
    db $24, $36, $90, $24, $90, $2B, $2C, $27, $27, $28, $31, $EF, $EE, $36, $37, $24
    db $2C, $35, $26, $24, $36, $28, $B5, $F7, $F0

Data_07C_7276:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3276, $72

Data_07C_72E8:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $33
    db $28, $27, $28, $36, $37, $24, $2F, $B5, $FA, $F7, $EF, $EE, $12, $37, $90, $2B
    db $24, $36, $90, $24, $90, $2B, $32, $2F, $28, $90, $37, $32, $EF, $EE, $24, $26
    db $26, $28, $33, $37, $90, $24, $31, $90, $2C, $37, $28, $30, $B5, $F7, $F0

Data_07C_7327:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $16, $32, $32, $31, $1B, $32, $26, $2E, $90, $29, $2C, $37
    db $F1, $36, $31, $38, $2A, $2F, $3C, $90, $2C, $31, $37, $32, $90, $33, $2F, $24
    db $26, $28, $B5, $F7, $F0

Data_07C_734C:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $33
    db $28, $27, $28, $36, $37, $24, $2F, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28, $90
    db $16, $32, $32, $31, $1B, $32, $26, $2E, $90, $36, $24, $37, $EF, $EE, $32, $31
    db $90, $37, $2B, $28, $90, $33, $28, $27, $28, $36, $37, $24, $2F, $B5, $F7, $F0

Data_07C_738C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F338C, $A8

Data_07C_7434:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3434, $62

Data_07C_7496:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $0A, $3C, $28, $AB, $90, $24, $3C, $28, $AB, $90, $36, $2C
    db $35, $99, $F1, $1B, $2C, $2A, $2B, $37, $90, $25, $28, $2B, $2C, $31, $27, $90
    db $3C, $32, $38, $99, $F7, $F0

Data_07C_74BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F34BC, $45

Data_07C_7501:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3501, $48

Data_07C_7549:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $20, $2B, $24, $37, $98, $99, $F1
    db $20, $2B, $24, $37, $90, $2C, $36, $90, $37, $2B, $2C, $36, $98, $F7, $F0

Data_07C_7568:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $14, $24, $2B, $24, $2B, $24, $2B, $24, $A4, $F1, $F7, $F0

Data_07C_7577:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3577, $147

Data_07C_76BE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F36BE, $49

Data_07C_7707:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3707, $66

Data_07C_776D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $39, $32, $2C, $26, $28, $90, $28, $26, $2B, $32, $28, $27, $F1, $29
    db $35, $32, $30, $90, $31, $32, $3A, $2B, $28, $35, $28, $A4, $F7, $F0

Data_07C_778B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F378B, $83

Data_07C_780E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F380E, $6B

Data_07C_7879:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3879, $60

Data_07C_78D9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F38D9, $4D

Data_07C_7926:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3926, $44

Data_07C_796A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $30, $28, $35, $30, $24, $2C, $27, $36, $F1
    db $26, $24, $30, $28, $90, $25, $24, $26, $2E, $B5, $F7, $F0

Data_07C_7986:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $42, $28, $90, $36, $28, $28, $31, $F1, $30, $28, $35, $30
    db $24, $2C, $27, $36, $90, $37, $32, $32, $B5, $FA, $F7, $EF, $EE, $12, $90, $37
    db $2B, $2C, $31, $2E, $90, $12, $3F, $90, $2C, $31, $EF, $EE, $2F, $32, $39, $28
    db $99, $F7, $F0

Data_07C_79B9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F39B9, $8F

Data_07C_7A48:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3A48, $49

Data_07C_7A91:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3A91, $6A

Data_07C_7AFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3AFB, $42

Data_07C_7B3D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3B3D, $95

Data_07C_7BD2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3BD2, $92

Data_07C_7C64:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3C64, $7A

Data_07C_7CDE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3CDE, $47

Data_07C_7D25:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3D25, $44

Data_07C_7D69:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3D69, $98

Data_07C_7E01:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3E01, $53

Data_07C_7E54:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1F3E54, $57

Data_07C_7EAB:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $17, $3E, $F1, $27, $24, $31, $26, $2C, $31, $2A, $90, $2F, $38, $35, $28
    db $27, $FA, $F7, $EF, $EE, $24, $90, $30, $28, $35, $30, $24, $2C, $27, $90, $37
    db $32, $90, $37, $2B, $28, $EF, $EE, $36, $38, $35, $29, $24, $26, $28, $B5, $F7
    db $F0
    ds $124, $00
