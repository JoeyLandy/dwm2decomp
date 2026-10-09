SECTION "Bank 07", ROMX[$4000], BANK[$07]
    db $07

Func_007_4001::
    ld de, $4016
    call Func_000_25C9
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

Func_007_400F::
    call Func_007_4001
    call Func_000_2611
    ret
    db $24, $40, $34, $40, $40, $40, $42, $40, $50, $40, $56, $40, $8C, $40
    dw Data_007_409E
    dw Data_007_40A3
    dw Data_007_40C1
    dw Data_007_4101
    dw Data_007_411C
    dw Data_007_4123
    dw Data_007_415A
    dw Data_007_4164
    dw Data_007_4195
    dw Data_007_419F
    dw Data_007_41A3
    dw Data_007_41B4
    dw Data_007_41DF
    dw Data_007_41E8
    dw Data_007_41F1
    dw Data_007_41FD
    dw Data_007_422D
    dw Data_007_4252
    dw Data_007_4269
    dw Data_007_4284
    dw Data_007_42A1
    dw Data_007_42BF
    dw Data_007_42DE
    dw Data_007_42F8
    dw Data_007_430F
    dw Data_007_4327
    dw Data_007_4346
    dw Data_007_438E
    dw Data_007_43AC
    dw Data_007_43CB
    dw Data_007_43EC
    dw Data_007_441E
    dw Data_007_4450
    dw Data_007_4492
    dw Data_007_44B6
    dw Data_007_44D1
    dw Data_007_44F1
    dw Data_007_4510
    dw Data_007_451D
    dw Data_007_4532
    dw Data_007_4566
    dw Data_007_4589
    dw Data_007_45A8
    dw Data_007_45C9
    dw Data_007_45E9
    dw Data_007_4604
    dw Data_007_4619
    dw Data_007_462E
    dw Data_007_463E
    dw Data_007_4685
    dw Data_007_46BA
    dw Data_007_46F5
    dw Data_007_470A
    dw Data_007_4724
    dw Data_007_473E
    dw Data_007_4758
    dw Data_007_4773
    dw Data_007_478F
    dw Data_007_47AA
    dw Data_007_47E7
    dw Data_007_482A

Data_007_409E:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $17, $12, $21, $F0

Data_007_40A3:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $1B, $0A, $10, $18, $17, $90, $20, $0A, $1B, $1B, $12, $18, $1B, $F1, $90
    db $90, $90, $16, $18, $17, $1C, $1D, $0E, $1B, $1C, $90, $02, $90, $F0

Data_007_40C1:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $18, $17, $1D, $12, $17, $1E, $0E, $90, $17, $0E, $20, $90, $10, $0A, $16
    db $0E, $90, $0B, $1B, $0E, $0E, $0D, $12, $17, $10, $90, $14, $0E, $22, $90, $1D
    db $1B, $0A, $0D, $0E, $1F, $1C, $90, $16, $18, $0D, $0E, $90, $90, $1D, $0E, $0A
    db $16, $90, $16, $18, $0D, $0E, $1D, $0E, $1B, $1B, $22, $90, $90, $90, $90, $F0

Data_007_4101:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $39, $28, $27, $90, $27, $24, $37, $24, $90, $2B, $24, $36, $F1, $25
    db $28, $28, $31, $90, $2F, $32, $36, $37, $B5, $F7, $F0

Data_007_411C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $36, $37, $28, $35, $F0

Data_007_4123:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $30, $28, $90, $15, $2C, $31, $2E, $F1, $2C, $36, $90, $31, $32, $37
    db $90, $35, $28, $24, $27, $3C, $B5, $FA, $F7, $F2, $19, $2F, $28, $24, $36, $28
    db $90, $26, $2B, $28, $26, $2E, $F1, $24, $31, $27, $90, $37, $35, $3C, $90, $24
    db $2A, $24, $2C, $31, $B5, $F7, $F0

Data_007_415A:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $1B, $0E, $0A, $16, $90, $0E, $10, $10, $F0

Data_007_4164:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $30, $28, $90, $15, $2C, $31, $2E, $90, $26, $24, $31, $31, $32, $37
    db $F1, $25, $28, $90, $38, $36, $28, $27, $90, $3A, $2C, $37, $2B, $FA, $F7, $F2
    db $1C, $38, $33, $28, $35, $90, $10, $24, $30, $28, $90, $0B, $32, $3C, $B5, $F7
    db $F0

Data_007_4195:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $32, $18, $3A, $31, $20, $15, $A3, $F0

Data_007_419F:: ; heuristic: target of a monotone pointer table; C0
    db $22, $28, $36, $F0

Data_007_41A3:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $2F, $2F, $90, $0A, $F1, $E8, $07, $01, $17, $28, $3B, $37, $90, $0B
    db $F0

Data_007_41B4:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $0E, $1C, $1E, $15, $1D, $1C, $0D, $38, $32, $20, $A2, $15, $28, $39, $28
    db $2F, $1D, $38, $35, $31, $36, $20, $2C, $31, $92, $1B, $24, $31, $2E, $18, $3A
    db $31, $20, $0D, $38, $32, $15, $18, $3A, $31, $15, $F0

Data_007_41DF:: ; heuristic: target of a monotone pointer table; C0
    db $10, $0F, $0D, $0E, $0B, $0C, $0A, $1C, $F0

Data_007_41E8:: ; heuristic: target of a monotone pointer table; C0
    db $10, $0F, $0E, $0D, $0C, $0B, $0A, $1C, $F0

Data_007_41F1:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $24, $27, $28, $90, $2E, $28, $3C, $36, $B5, $F0

Data_007_41FD:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $1B, $0E, $0E, $90, $0B, $0A, $1D, $1D, $15, $0E, $F1, $0E, $17, $12, $21
    db $90, $1B, $1E, $15, $0E, $1C, $90, $F1, $15, $18, $0C, $0A, $15, $90, $1B, $1E
    db $15, $0E, $1C, $F1, $0E, $21, $12, $1D, $90, $90, $90, $90, $90, $90, $90, $F0

Data_007_422D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $0B, $0E, $0F, $12, $15, $17, $18, $1B, $1C, $1D, $21, $22, $24, $26, $28
    db $2A, $2B, $2C, $2E, $2F, $30, $31, $35, $37, $38, $39, $3B, $3C, $14, $16, $0D
    db $33, $32, $36, $25, $F0

Data_007_4252:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $29, $38, $36, $28, $27, $90, $37, $2B, $28, $90, $1F, $1C, $F1, $25
    db $24, $37, $37, $2F, $28, $B5, $F0

Data_007_4269:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $1F, $1C, $90, $25, $24, $37, $37, $2F, $28, $90, $3A, $24
    db $36, $F1, $35, $28, $29, $38, $36, $28, $27, $B5, $F0

Data_007_4284:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $32, $36, $2C, $31, $2A, $90, $35, $38, $2F, $28, $36, $B5, $F1
    db $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $B5, $F0

Data_007_42A1:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $26, $28, $2C, $39, $2C, $31, $2A, $90, $35, $38, $2F, $28, $36, $B5
    db $F1, $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $B5, $F0

Data_007_42BF:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $31, $29, $2C, $35, $30, $2C, $31, $2A, $90, $35, $38, $2F, $28, $36
    db $B5, $F1, $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $B5, $F0

Data_007_42DE:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $24, $3C, $90, $37, $2B, $28, $90, $25, $32, $3C, $3E, $F1, $24, $27
    db $39, $28, $31, $37, $38, $35, $28, $98, $FF, $F0

Data_007_42F8:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $31, $37, $28, $35, $90, $37, $2B, $28, $90, $25, $32, $3C, $3E, $F1, $31
    db $24, $30, $28, $B5, $FA, $F7, $F0

Data_007_430F:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $31, $37, $28, $35, $90, $37, $2B, $28, $90, $2A, $2C, $35, $2F, $3E, $F1
    db $31, $24, $30, $28, $B5, $FA, $F7, $F0

Data_007_4327:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $37, $90, $28, $31, $32, $38, $2A, $2B, $90, $30, $32, $31, $28, $3C
    db $B5, $F1, $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $B5, $F0

Data_007_4346:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $01C346, $48

Data_007_438E:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $90, $33, $24, $2C, $27, $90, $29, $32, $35, $90, $25, $32, $37
    db $2B, $F1, $26, $32, $30, $25, $24, $37, $24, $31, $37, $36, $B5, $F0

Data_007_43AC:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $35, $90, $33, $24, $2F, $90, $33, $24, $2C, $27, $90, $3C, $32
    db $38, $35, $F1, $25, $24, $37, $37, $2F, $28, $90, $29, $28, $28, $B5, $F0

Data_007_43CB:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $36, $38, $29, $29, $2C, $26, $2C, $28, $31, $37, $90, $2A, $32, $2F
    db $27, $F1, $29, $32, $35, $90, $1D, $28, $24, $30, $90, $16, $32, $27, $28, $B5
    db $F0

Data_007_43EC:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $90, $35, $28, $29, $38, $36, $28, $27, $90, $37, $32, $90, $33
    db $24, $3C, $F1, $37, $2B, $28, $90, $25, $24, $37, $37, $2F, $28, $90, $29, $28
    db $28, $90, $29, $32, $35, $FA, $F7, $F2, $3C, $32, $38, $35, $90, $33, $24, $2F
    db $B5, $F0

Data_007_441E:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $35, $90, $33, $24, $2F, $90, $35, $28, $29, $38, $36, $28, $27
    db $F1, $37, $32, $90, $33, $24, $3C, $90, $37, $2B, $28, $90, $25, $24, $37, $37
    db $2F, $28, $FA, $F7, $F2, $29, $28, $28, $90, $29, $32, $35, $90, $3C, $32, $38
    db $B5, $F0

Data_007_4450:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $01C450, $42

Data_007_4492:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $32, $36, $28, $90, $24, $90, $30, $32, $31, $36, $37, $28, $35
    db $F1, $29, $32, $35, $90, $37, $2B, $28, $90, $1D, $28, $24, $30, $90, $16, $32
    db $27, $28, $B5, $F0

Data_007_44B6:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $90, $35, $28, $29, $38, $36, $28, $27, $90, $37, $2B, $28, $F1
    db $1D, $28, $24, $30, $90, $16, $32, $27, $28, $B5, $F0

Data_007_44D1:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $35, $90, $33, $24, $2F, $90, $35, $28, $29, $38, $36, $28, $27
    db $F1, $37, $2B, $28, $90, $1D, $28, $24, $30, $90, $16, $32, $27, $28, $B5, $F0

Data_007_44F1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $31, $27, $90, $3C, $32, $38, $35, $90, $30, $32, $31, $36, $37, $28
    db $35, $F1, $2C, $31, $37, $32, $90, $25, $24, $37, $37, $2F, $28, $98, $F0

Data_007_4510:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $B5, $F0

Data_007_451D:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $37, $37, $2F, $28, $90, $2C, $31, $90, $1D, $28, $24, $30, $F1, $16
    db $32, $27, $28, $98, $F0

Data_007_4532:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $25, $24, $37, $37, $2F, $28, $90, $35, $28, $36, $38, $2F
    db $37, $36, $F1, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $35, $28, $26, $32, $35
    db $27, $28, $27, $B5, $FA, $F7, $F2, $12, $36, $90, $37, $2B, $24, $37, $90, $18
    db $14, $98, $FF, $F0

Data_007_4566:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $90, $1D, $28, $24, $30, $90, $16, $32, $27, $28, $AB, $90, $3C, $32
    db $38, $F1, $25, $32, $37, $2B, $90, $2B, $24, $39, $28, $90, $3A, $32, $31, $B5
    db $FA, $F7, $F0

Data_007_4589:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $90, $1D, $28, $24, $30, $90, $16, $32, $27, $28, $AB, $90, $3C, $32
    db $38, $F1, $24, $2F, $32, $31, $28, $90, $3A, $32, $31, $B5, $FA, $F7, $F0

Data_007_45A8:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $90, $1D, $28, $24, $30, $90, $16, $32, $27, $28, $AB, $90, $3C, $32
    db $38, $F1, $25, $32, $37, $2B, $90, $2F, $32, $36, $37, $B5, $E5, $42, $FA, $F7
    db $F0

Data_007_45C9:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $90, $1D, $28, $24, $30, $90, $16, $32, $27, $28, $AB, $90, $3C, $32
    db $38, $F1, $24, $2F, $32, $31, $28, $90, $2F, $32, $36, $37, $B5, $FA, $F7, $F0

Data_007_45E9:: ; heuristic: target of a monotone pointer table; C0
    db $F6, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $24, $31, $F1, $28, $2A
    db $2A, $90, $32, $29, $90, $F9, $00, $B5, $FA, $F7, $F0

Data_007_4604:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $3E, $90, $F9, $10, $F1, $35, $32, $36, $28, $90, $25, $3C, $90, $F9
    db $20, $B5, $FA, $F7, $F0

Data_007_4619:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $3E, $90, $F9, $10, $F1, $29, $28, $2F, $2F, $90, $25, $3C, $90, $F9
    db $20, $B5, $FA, $F7, $F0

Data_007_462E:: ; heuristic: target of a monotone pointer table; C0
    db $F6, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $F9, $20, $10, $B5, $F0

Data_007_463E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $01C63E, $47

Data_007_4685:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $37, $2B, $90, $31, $32, $90, $35, $32, $32, $30, $90, $29, $32, $35
    db $F1, $2C, $37, $90, $AB, $90, $F9, $00, $90, $3A, $24, $36, $FA, $F7, $F2, $35
    db $28, $2F, $28, $24, $36, $28, $27, $90, $2C, $31, $90, $37, $2B, $28, $F1, $3A
    db $2C, $2F, $27, $B5, $F0

Data_007_46BA:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $35, $90, $1D, $28, $24, $30, $90, $16, $32, $27, $28, $AB, $F1, $01
    db $00, $00, $00, $10, $90, $2C, $36, $90, $26, $2B, $24, $35, $2A, $28, $27, $B5
    db $FA, $F7, $F2, $20, $2C, $2F, $2F, $90, $3C, $32, $38, $90, $33, $24, $3C, $90
    db $37, $2B, $2C, $36, $F1, $29, $28, $28, $98, $FF, $F0

Data_007_46F5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $39, $2C, $31, $2A, $A4, $F1, $19, $2F, $28, $24, $36, $28, $90, $3A
    db $24, $2C, $37, $B5, $F0

Data_007_470A:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $28, $24, $30, $90, $16, $32, $27, $28, $90, $25, $24, $37, $37, $2F, $28
    db $F1, $17, $32, $B5, $90, $01, $99, $FA, $F7, $F0

Data_007_4724:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $28, $24, $30, $90, $16, $32, $27, $28, $90, $25, $24, $37, $37, $2F, $28
    db $F1, $17, $32, $B5, $90, $02, $99, $FA, $F7, $F0

Data_007_473E:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $28, $24, $30, $90, $16, $32, $27, $28, $90, $29, $2C, $31, $24, $2F, $F1
    db $25, $24, $37, $37, $2F, $28, $99, $FA, $F7, $F0

Data_007_4758:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $29, $2C, $35, $36, $37, $90, $30, $32, $31, $36, $37, $28
    db $35, $F1, $2C, $36, $90, $F9, $00, $99, $FA, $F7, $F0

Data_007_4773:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $36, $28, $26, $32, $31, $27, $90, $30, $32, $31, $36, $37
    db $28, $35, $F1, $2C, $36, $90, $F9, $00, $99, $FA, $F7, $F0

Data_007_478F:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $37, $2B, $2C, $35, $27, $90, $30, $32, $31, $36, $37, $28
    db $35, $F1, $2C, $36, $90, $F9, $00, $99, $FA, $F7, $F0

Data_007_47AA:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $31, $2A, $35, $24, $37, $38, $2F, $24, $37, $2C, $32, $31, $36, $F1
    db $29, $32, $35, $90, $3C, $32, $38, $35, $90, $39, $2C, $26, $37, $32, $35, $3C
    db $99, $FA, $F7, $F2, $22, $32, $38, $42, $28, $90, $26, $2F, $28, $24, $35, $28
    db $27, $F1, $1B, $32, $38, $31, $27, $90, $01, $99, $FA, $F7, $F0

Data_007_47E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $01C7E7, $43

Data_007_482A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $01C82A, $44

Func_007_486E::
    xor a, a
    ld hl, $C46B
    ld bc, $0008
    call Func_000_0949
    xor a, a
    ld hl, $C52D
    ld bc, $0012
    call Func_000_0949
    ld hl, $99C1
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    xor a, a
    ld hl, $D06A
    ld bc, $0008
    call Func_000_0949
    call Func_000_08A6
    xor a, a
    ld [$C58C], a
    ld a, [$C5DC]
    rst $00
    dw Jump_007_48B2
    dw Jump_007_4952
    dw Jump_007_4B45
    dw Jump_007_4C24
    dw Jump_007_4CFF
    dw Jump_007_4E20
    dw Jump_007_4E37
    dw Jump_007_4E20

Jump_007_48B2::
    ld a, [$C524]
    or a, a
    jr z, Jump_007_48C8
    ld hl, $C51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, Func_017_421A
    ld b, $17
    rst $10
    jr Jump_007_48F3

Jump_007_48C8::
    ld a, [$C525]
    or a, a
    jr z, Jump_007_48F3
    ld b, $40
    ld hl, $C49F

Jump_007_48D3::
    ld a, $FF
    ld [hl+], a
    ld a, $7F
    ld [hl+], a
    dec b
    jr nz, Jump_007_48D3
    ld a, $7F
    ld [$C526], a
    ld a, $01
    ldh [$FF4F], a
    ld hl, $9800
    ld bc, $0240
    xor a, a
    call Func_000_0949
    ld a, $00
    ldh [$FF4F], a

Jump_007_48F3::
    ld b, $46
    ld de, $4001
    ld hl, $8800
    call Func_000_0C5A
    xor a, a
    ld hl, $C5E9
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    xor a, a
    ldh [$FF47], a
    ldh [$FF48], a
    ldh [$FF49], a
    ld a, $C3
    ld hl, $9800
    ld bc, $0800
    call Func_000_0949
    ld a, $07
    ldh [$FF9F], a
    ld a, $FF
    ldh [$FFA0], a
    ld a, $00
    ldh [$FFA1], a
    ld a, $00
    ldh [$FFA5], a
    xor a, a
    ld [$C5F0], a
    ld [$C5F1], a
    xor a, a
    ld [$C5E1], a
    xor a, a
    ld [$C581], a
    ld [$C582], a
    xor a, a
    ld [$C58A], a
    xor a, a
    ld [$C58B], a
    xor a, a
    ld [$C57F], a
    ld [$C580], a
    ld a, $03
    ld [$C5EC], a
    ld a, $01
    jp Jump_000_077A

Jump_007_4952::
    call Func_000_3290
    xor a, a
    ld hl, $D09D
    ld bc, $0210
    call Func_000_0949
    xor a, a
    ld hl, $C57F
    ld bc, $0058
    call Func_000_0949
    ld a, [$C524]
    or a, a
    jr z, Jump_007_4985
    ld a, $02
    call Func_000_13E5
    call Func_000_05D1
    ld hl, $C51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, Func_017_41CF
    ld b, $17
    rst $10

Jump_007_4985::
    ld a, $FC
    call Func_000_0DF2
    ld hl, $FF8A
    ld bc, $000E
    xor a, a
    call Func_000_0949
    ld hl, $C60C
    ld bc, $0291
    xor a, a
    call Func_000_0949
    ld a, $0A
    ld [$0100], a
    ld a, $01
    ld [$4100], a
    ld a, [$BD97]
    or a, a
    jr z, Jump_007_49B3
    cp a, $01
    jr z, Jump_007_49B3
    xor a, a

Jump_007_49B3::
    ld [$C894], a
    xor a, a
    ld [$4100], a
    xor a, a
    ld [$0100], a
    ld hl, $CBD7
    ld bc, $006B
    xor a, a
    call Func_000_0949
    ld hl, $CC42
    ld bc, $00B5
    xor a, a
    call Func_000_0949
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld hl, $A000
    ld bc, $2000
    xor a, a
    call Func_000_0949
    ld a, $0A
    ld [$0100], a
    ld a, $01
    ld [$4100], a
    ld hl, $A000
    ld bc, $006F
    xor a, a
    call Func_000_0949
    ld a, $02
    ld [$4100], a
    ld hl, $A000
    ld bc, $2000
    xor a, a
    call Func_000_0949
    xor a, a
    ld [$0100], a
    ld a, $04
    ld [$C834], a
    ld a, $01
    ld [$C964], a
    ld b, $46
    ld de, $4001
    ld hl, $8800
    call Func_000_0C5A
    ld hl, $9000
    ld de, $0907
    call Func_000_2E98
    ld a, $00
    ld [$C528], a
    ld a, $02
    ld [$C529], a
    ld hl, Func_007_400F
    ld b, $07
    rst $10
    ld hl, $9700
    ld de, $0907
    call Func_000_2E98
    ld a, $00
    ld [$C528], a
    ld a, $06
    ld [$C529], a
    ld hl, Func_007_400F
    ld b, $07
    rst $10
    ld a, [$C525]
    or a, a
    jr z, Jump_007_4A68
    ld a, $01
    ldh [$FF4F], a
    ld d, $00
    call Func_007_4AE4
    call Func_007_4B1E
    xor a, a
    ldh [$FF4F], a

Jump_007_4A68::
    ld d, $C3
    call Func_007_4AE4
    call Func_007_4B1E
    ld hl, Func_002_706E
    ld b, $02
    rst $10
    ldh a, [$FFC6]
    ld [$D06A], a
    or a, a
    jr z, Jump_007_4A9B
    ld hl, $5149
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_007_4A87
    inc h

Jump_007_4A87::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_007_4AFE
    call Func_007_4B1E
    ld a, [$D06A]
    cp a, $01
    jr z, Jump_007_4A9B
    ld a, $02
    jr Jump_007_4A9D

Jump_007_4A9B::
    ld a, $09

Jump_007_4A9D::
    call Func_000_122D
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld a, $07
    ldh [$FF9F], a
    ld a, $00
    ldh [$FFA0], a
    ld a, $00
    ldh [$FFA5], a
    ld a, $00
    ldh [$FFA1], a
    xor a, a
    ld [$C5F0], a
    ld [$C5F1], a
    xor a, a
    ld [$C5E1], a
    xor a, a
    ld [$C581], a
    ld [$C582], a
    xor a, a
    ld [$C58A], a
    xor a, a
    ld [$C58B], a
    xor a, a
    ld [$C57F], a
    ld [$C580], a
    ld a, $03
    ld [$C5EC], a
    ld a, $09
    jp Jump_000_077A

Func_007_4AE4::
    ld hl, $C198
    ld bc, $1412
    ld a, d

Jump_007_4AEB::
    ld [hl+], a
    dec b
    jr nz, Jump_007_4AEB
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, d
    ld b, $14
    dec c
    jr nz, Jump_007_4AEB
    ret

Func_007_4AFE::
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, $C198
    add hl, de
    pop de

Jump_007_4B0C::
    push bc
    push hl

Jump_007_4B0E::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_007_4B0E
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_007_4B0C
    ret

Func_007_4B1E::
    ld hl, $9800
    ld de, $C198
    ld bc, $1412

Func_007_4B27::
    push bc
    push de
    push hl

Jump_007_4B2A::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_007_4B2A
    pop hl
    ld bc, $0020
    add hl, bc
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec c
    jr nz, Func_007_4B27
    ret

Jump_007_4B45::
    ld hl, $D780
    ld bc, $006F

Jump_007_4B4B::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_4B4B
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld a, [$C524]
    or a, a
    jr z, Jump_007_4B6F
    ld hl, $C51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, Func_017_41CF
    ld b, $17
    rst $10
    jr Jump_007_4B7B

Jump_007_4B6F::
    ld a, [$C525]
    or a, a
    jr z, Jump_007_4B7B
    ld hl, Func_001_4AA4
    ld b, $01
    rst $10

Jump_007_4B7B::
    ld hl, Func_002_717D
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    jr z, Jump_007_4B7B
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_007_4B95
    ld hl, Func_060_6CD1
    ld b, $60
    rst $10

Jump_007_4B95::
    ld a, $FC
    call Func_000_0DF2
    ld b, $46
    ld de, $4001
    ld hl, $8800
    call Func_000_0C5A
    ld hl, Func_0F1_4AA8
    ld b, $F1
    rst $10
    ld hl, $9800
    ld bc, $0240
    ld a, $C3
    call Func_000_0949
    ld a, $01
    ld [$C8CB], a
    ld a, $00
    ld [$C8CC], a
    ld a, $02
    ldh [$FFB9], a

Jump_007_4BC4::
    ld hl, Func_002_69D0
    ld b, $02
    rst $10
    ld a, [$C8CB]
    and a, $03
    jr nz, Jump_007_4BC4
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld hl, $C46B
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld hl, $D06A
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld a, $09
    call Func_000_122D
    ld a, $07
    ldh [$FF9F], a
    ld a, $FF
    ldh [$FFA0], a
    ld a, $00
    ldh [$FFA5], a
    ld a, $00
    ldh [$FFA1], a
    ld a, $02
    ldh [$FFB9], a
    xor a, a
    ld [$C5F0], a
    ld [$C5F1], a
    xor a, a
    ld [$C5E1], a
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58F], a
    ld a, $03
    ld [$C5EC], a
    ld a, $09
    jp Jump_000_077A

Jump_007_4C24::
    ld hl, $D780
    ld bc, $006F

Jump_007_4C2A::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_4C2A
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld a, [$C524]
    or a, a
    jr z, Jump_007_4C4E
    ld hl, $C51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, Func_017_41CF
    ld b, $17
    rst $10
    jr Jump_007_4C5A

Jump_007_4C4E::
    ld a, [$C525]
    or a, a
    jr z, Jump_007_4C5A
    ld hl, Func_001_4AA4
    ld b, $01
    rst $10

Jump_007_4C5A::
    ld hl, Func_002_717D
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    jr z, Jump_007_4C5A
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_007_4C74
    ld hl, Func_060_6CD1
    ld b, $60
    rst $10

Jump_007_4C74::
    ld a, $FC
    call Func_000_0DF2
    ld b, $46
    ld de, $4001
    ld hl, $8800
    call Func_000_0C5A
    ld hl, Func_0F1_4AA8
    ld b, $F1
    rst $10
    ld hl, $9800
    ld bc, $0240
    ld a, $C3
    call Func_000_0949
    ld a, $01
    ld [$C8CB], a
    ld a, $00
    ld [$C8CC], a
    ld a, $02
    ldh [$FFB9], a

Jump_007_4CA3::
    ld hl, Func_002_69D0
    ld b, $02
    rst $10
    ld a, [$C8CB]
    and a, $03
    jr nz, Jump_007_4CA3
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld hl, $C46B
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld hl, $D06A
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld a, $09
    call Func_000_122D
    ld a, $07
    ldh [$FF9F], a
    ld a, $FF
    ldh [$FFA0], a
    ld a, $00
    ldh [$FFA5], a
    ld a, $00
    ldh [$FFA1], a
    xor a, a
    ld [$C5F0], a
    ld [$C5F1], a
    xor a, a
    ld [$C5E1], a
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58F], a
    ld a, $03
    ld [$C5EC], a
    ld a, $09
    jp Jump_000_077A

Jump_007_4CFF::
    call Func_007_4DEC
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld a, [$C524]
    or a, a
    jr z, Jump_007_4D1F
    ld hl, $C51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, Func_017_41CF
    ld b, $17
    rst $10
    jr Jump_007_4D2B

Jump_007_4D1F::
    ld a, [$C525]
    or a, a
    jr z, Jump_007_4D2B
    ld hl, Func_001_4AA4
    ld b, $01
    rst $10

Jump_007_4D2B::
    ld hl, Func_002_717D
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    jr z, Jump_007_4D2B
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_007_4D45
    ld hl, Func_060_6CD1
    ld b, $60
    rst $10

Jump_007_4D45::
    ld a, $FC
    call Func_000_0DF2
    ld b, $31
    ld de, $7C1E
    ld hl, $8A40
    call Func_000_0C5A
    ld b, $31
    ld de, $7DFB
    ld hl, $8DF0
    call Func_000_0C5A
    ld hl, $9400
    ld de, $0B04
    call Func_000_2E98
    ld hl, $0300
    call Func_007_513A
    ld a, $00
    ld [$D09E], a
    ld hl, Func_016_7A5B
    ld b, $16
    rst $10
    ld hl, $90B0
    ld de, $2501
    call Func_000_2E98
    ld hl, $0301
    call Func_007_513A
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld hl, $C198
    ld bc, $0240
    ld a, $C3
    call Func_000_0949
    ld hl, $5447
    call Func_007_4AFE
    call Func_007_4B1E
    ld hl, $C46B
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld hl, $D06A
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld a, $09
    call Func_000_122D
    ld a, $07
    ldh [$FF9F], a
    ld a, $FF
    ldh [$FFA0], a
    ld a, $00
    ldh [$FFA5], a
    ld a, $00
    ldh [$FFA1], a
    xor a, a
    ld [$C5F0], a
    ld [$C5F1], a
    xor a, a
    ld [$C5E1], a
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58F], a
    ld a, $03
    ld [$C5EC], a
    ld a, $09
    jp Jump_000_077A

Func_007_4DEC::
    ld a, [$D059]
    cp a, $02
    jr z, Jump_007_4DF8
    ld hl, $4E07
    jr Jump_007_4DFB

Jump_007_4DF8::
    ld hl, $D04D

Jump_007_4DFB::
    ld de, $D043
    ld b, $0A

Jump_007_4E00::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_007_4E00
    ret
    db $01, $00, $00, $63, $29, $01, $00, $00, $63, $80

Func_007_4E11::
    ld hl, $D043
    ld de, $D04D
    ld b, $0A

Jump_007_4E19::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_007_4E19
    ret

Jump_007_4E20::
    ld hl, $8000
    ld bc, $0C00
    xor a, a

Jump_007_4E27::
    di

Jump_007_4E28::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_007_4E28
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_4E27

Jump_007_4E37::
    ld hl, $D780
    ld bc, $006F

Jump_007_4E3D::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_007_4E3D
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld a, [$C524]
    or a, a
    jr z, Jump_007_4E5F
    ld hl, $C51F
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, Func_017_41CF
    ld b, $17
    rst $10
    jr Jump_007_4E6B

Jump_007_4E5F::
    ld a, [$C525]
    or a, a
    jr z, Jump_007_4E6B
    ld hl, Func_001_4AA4
    ld b, $01
    rst $10

Jump_007_4E6B::
    ld hl, Func_002_717D
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    jr z, Jump_007_4E6B
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_007_4E85
    ld hl, Func_060_6CD1
    ld b, $60
    rst $10

Jump_007_4E85::
    ld hl, $9800
    ld bc, $1412

Jump_007_4E8B::
    ld a, $C3

Jump_007_4E8D::
    call Func_000_121F
    dec b
    jr nz, Jump_007_4E8D
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $14
    dec c
    jr nz, Jump_007_4E8B
    call Func_007_4F29
    ld hl, Func_012_64F8
    ld b, $12
    rst $10
    ld a, $FC
    call Func_000_0DF2
    ld b, $46
    ld de, $4001
    ld hl, $8800
    call Func_000_0C5A
    ld hl, Func_0F1_4AA8
    ld b, $F1
    rst $10
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld a, $01
    ld [$C8CB], a
    ld a, $00
    ld [$C8CC], a
    ld a, $00
    ldh [$FFB9], a

Jump_007_4ED6::
    ld hl, Func_002_69D0
    ld b, $02
    rst $10
    ld a, [$C8CB]
    and a, $03
    jr nz, Jump_007_4ED6
    ld hl, $C46B
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld hl, $D06A
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld a, $09
    call Func_000_122D
    ld a, $07
    ldh [$FF9F], a
    ld a, $FF
    ldh [$FFA0], a
    ld a, $00
    ldh [$FFA5], a
    ld a, $00
    ldh [$FFA1], a
    xor a, a
    ld [$C5F0], a
    ld [$C5F1], a
    xor a, a
    ld [$C5E1], a
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58F], a
    ld a, $03
    ld [$C5EC], a
    ld a, $09
    jp Jump_000_077A

Func_007_4F29::
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE
    ld de, $C972

Jump_007_4F38::
    push hl
    ld a, [hl]
    ld c, $5B
    call Func_000_1F89
    ldh a, [$FFC6]
    ld [de], a
    inc de
    ldh a, [$FFC7]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $5F
    call Func_000_1F89
    ldh a, [$FFC6]
    ld [de], a
    inc de
    ldh a, [$FFC7]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    ldh a, [$FFC6]
    ld [de], a
    inc de
    pop hl
    inc hl
    dec b
    jr nz, Jump_007_4F38
    xor a, a
    ld [$0100], a
    ld a, [$C6FD]
    cp a, $03
    ret z
    ld a, $FF
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ret

Func_007_4F7B::
    ld a, [$C5DC]
    rst $00
    dw Jump_007_5902
    dw Jump_007_6090
    dw Jump_007_6AEE
    dw Jump_007_6BB7
    dw Jump_007_6BC3
    dw Jump_007_4F8F
    dw Jump_007_4F8F
    dw Jump_007_4F96

Jump_007_4F8F::
    ld hl, Func_033_51C6
    ld b, $33
    rst $10
    ret

Jump_007_4F96::
    ld hl, Func_0F1_5AD5
    ld b, $F1
    rst $10
    ret

Func_007_4F9D::
    ld a, [$C5F0]
    and a, $07
    jr nz, Jump_007_4FB3
    ld a, [$C5F0]
    bit 3, a
    jr nz, Jump_007_4FB0
    call Func_007_5066
    jr Jump_007_4FB3

Jump_007_4FB0::
    call Func_007_5046

Jump_007_4FB3::
    ld a, [$C46F]
    cp a, $01
    jr z, Jump_007_4FE4
    ld c, [hl]
    ld a, [$C563]
    and a, $40
    jr z, Jump_007_4FD0
    ld a, [hl]
    dec a
    ld [hl], a
    cp a, $FF
    jr nz, Jump_007_4FE5
    ld a, [$C46F]
    dec a
    ld [hl], a
    jr Jump_007_4FE5

Jump_007_4FD0::
    ld a, [$C563]
    and a, $80
    jr z, Jump_007_4FE4
    ld a, [$C46F]
    dec a
    inc [hl]
    cp a, [hl]
    ccf
    jr c, Jump_007_4FE5
    xor a, a
    ld [hl], a
    jr Jump_007_4FE5

Jump_007_4FE4::
    ret

Jump_007_4FE5::
    xor a, a
    ld [$C5F0], a
    call Func_007_5067
    ld a, $69
    call Func_000_1278
    call Func_007_5046
    ret

Func_007_4FF5::
    ld a, [$C5F0]
    and a, $07
    jr nz, Jump_007_500B
    ld a, [$C5F0]
    bit 3, a
    jr nz, Jump_007_5008
    call Func_007_5066
    jr Jump_007_500B

Jump_007_5008::
    call Func_007_5046

Jump_007_500B::
    ld c, [hl]
    ld a, [$C563]
    and a, $20
    jr z, Jump_007_5021
    ld a, [hl]
    dec a
    ld [hl], a
    cp a, $FF
    jr nz, Jump_007_5036
    ld a, [$C470]
    dec a
    ld [hl], a
    jr Jump_007_5036

Jump_007_5021::
    ld a, [$C563]
    and a, $10
    jr z, Jump_007_5035
    ld a, [$C470]
    dec a
    inc [hl]
    cp a, [hl]
    ccf
    jr c, Jump_007_5036
    xor a, a
    ld [hl], a
    jr Jump_007_5036

Jump_007_5035::
    ret

Jump_007_5036::
    xor a, a
    ld [$C5F0], a
    call Func_007_5067
    ld a, $69
    call Func_000_1278
    call Func_007_5046
    ret

Func_007_5046::
    ld c, [hl]
    push hl
    ld a, c
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BB
    push af

Jump_007_5056::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_007_5056

Jump_007_505C::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_007_505C
    pop af
    ld [hl], a
    pop hl
    ret

Func_007_5066::
    ld c, [hl]

Func_007_5067::
    push hl
    ld a, c
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $C3
    push af

Jump_007_5076::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_007_5076

Jump_007_507C::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_007_507C
    pop af
    ld [hl], a
    pop hl
    ret
    INCBIN "dwm2-cobi-us.gbc", $01D086, $78

Func_007_50FE::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_007_5104
    inc h

Jump_007_5104::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BC
    call Func_000_1211
    ret

Func_007_510D:: ; heuristic: follows a terminator; C0
    ld hl, $9800
    ld bc, $1412
    ld a, $C3

Jump_007_5115::
    call Func_000_121F
    dec b
    jr nz, Jump_007_5115
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, $C3
    ld b, $14
    dec c
    jr nz, Jump_007_5115
    ret

Func_007_512B::
    ld a, h
    ld [$C528], a
    ld a, l
    ld [$C529], a
    ld hl, Func_007_4001
    ld b, $07
    rst $10
    ret

Func_007_513A::
    ld a, h
    ld [$C528], a
    ld a, l
    ld [$C529], a
    ld hl, Func_007_400F
    ld b, $07
    rst $10
    ret

Func_007_5149:: ; heuristic: follows a terminator; C0
    ld c, a
    ld d, c
    rst $10
    ld d, d
    rst $38
    ld d, d
    nop
    nop
    inc c
    rrca
    or a, b
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, d
    or a, [hl]
    jp Func_000_0100
    INCBIN "dwm2-cobi-us.gbc", $01D163, $1A1
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5, $60, $00, $14, $0B, $B0
    ds $12, $B1
    db $B2, $B6, $68, $69, $6A, $6B, $6C, $6D, $ED, $40, $41, $42, $43, $44, $C3, $C3
    db $C3, $ED, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $45, $46, $47, $48, $49, $4A, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3
    db $57, $58, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $59, $5A, $C3, $C3, $B7, $B6, $4B, $4C, $4D, $4E, $4F, $50
    db $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $51, $52, $53, $54, $55, $56, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    INCBIN "dwm2-cobi-us.gbc", $01D446, $9A
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $0C, $0B, $15, $15, $10, $0D, $C3, $14, $15, $0B, $13, $15, $C3
    db $0D, $16, $0F, $15, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $14, $1E, $1D, $1F, $1F, $C3, $10, $1D, $20, $1D, $23, $C3, $C3
    db $17, $C3, $C3, $11, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $10, $1A, $25, $1A, $1F, $C3, $10, $1D, $20, $1D, $23, $C3, $C3
    db $17, $C3, $C3, $11, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $0E, $18, $20, $1D, $1F, $27, $10, $1D, $20, $1D, $23, $C3, $C3
    db $17, $C3, $C3, $11, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $15, $24, $22, $21, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $C3
    db $17, $C3, $C3, $11, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $0D, $26, $19, $1C, $18, $21, $1B, $1A, $C3, $C3, $C3, $C3, $C3
    db $17, $C3, $C3, $11, $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5, $00, $00, $14, $12, $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $C3, $14, $28, $0F, $10, $10, $C3, $10, $0F, $29, $0F, $15
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $10, $0F
    db $29, $0F, $15, $C3, $B7, $B6, $C3, $0B, $23, $1E, $C3, $29, $18, $1B, $1D, $19
    db $C3, $C3, $E0, $C3, $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $14, $24, $2B, $2B, $2C, $22, $23, $C3, $C3, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $13, $1A, $19, $2C, $25, $1A, $22, $C3, $C3, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $0C, $22, $1A, $18, $23, $1C, $C3, $C3, $C3, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $2A, $18, $21, $19, $1A, $C3, $C3, $C3, $C3, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $0B, $23, $1E, $C3, $14, $1E, $1D, $1F, $1F, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $29, $1A, $1B, $18, $20, $18, $1B, $1D, $19, $C3, $C3, $E0, $C3
    db $E1, $C3, $11, $2C, $B7, $B3
    ds $12, $B4
    db $B5, $E0, $00, $14, $05, $B0
    ds $12, $B1
    db $B2, $B6, $C3, $15, $2C, $23, $18, $1F, $C3, $10, $1A, $25, $1A, $1F, $2D, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $29, $18, $26, $C3, $10, $1A, $25, $1A, $1F, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    INCBIN "dwm2-cobi-us.gbc", $01D7F2, $AF
    ds $10, $B1
    db $B2, $B6
    ds $10, $C3
    db $B7, $B6, $15, $24, $22, $21, $C3, $10, $1D, $20, $1D, $23, $C3, $C3, $C5, $C3
    db $C3, $C6, $B7, $B6
    ds $10, $C3
    db $B7, $B3
    ds $10, $B4
    db $B5, $DE, $67, $1F, $33, $3C, $12, $00, $00

Jump_007_5902::
    ld a, [$D06A]
    rst $00
    dw Jump_007_5910
    dw Jump_007_59B6
    dw Jump_007_5A5C
    dw Jump_007_5AFB
    dw Jump_007_5EFF

Jump_007_5910::
    ld a, [$D06B]
    rst $00
    dw Jump_007_591A
    dw Jump_007_591A
    dw Jump_007_5976

Jump_007_591A::
    ld a, [$D06B]
    or a, a
    jr z, Jump_007_596A
    ld b, $E1
    ld de, $4001
    ld hl, $9000
    call Func_000_0CF5
    ld b, $E1
    ld de, $40D6
    ld hl, $C198
    call Func_000_0C5A
    ld a, [$C525]
    or a, a
    jr z, Jump_007_595C
    ld a, $02
    ldh [$FF70], a
    ld b, $E1
    ld de, $40FB
    ld hl, $D000
    call Func_000_0C5A
    ld a, $00
    ldh [$FF70], a
    ld b, $E1
    ld de, Data_0E1_410E
    ld hl, $C49F
    ld c, $08
    call Func_000_0B2B

Jump_007_595C::
    ld hl, $9800
    call Func_000_1E29
    call Func_007_600E
    ld a, $FC
    call Func_000_0DF2

Jump_007_596A::
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$D09D], a
    ld [$D09E], a
    ret

Jump_007_5976::
    ld a, [$D09D]
    inc a
    ld [$D09D], a
    cp a, $3C
    jr c, Jump_007_5993
    xor a, a
    ld [$D09D], a
    ld a, [$D09E]
    inc a
    ld [$D09E], a
    cp a, $03
    jr nc, Jump_007_59A8
    cp a, $02
    ret c

Jump_007_5993::
    ld a, [$C562]
    and a, $0B
    ret

Func_007_5999:: ; heuristic: follows a terminator; C0
    xor a, a
    ld [$D06B], a
    ld a, $01
    ld [$D06A], a
    ld a, $04
    call Func_000_0DF2
    ret

Jump_007_59A8::
    ld hl, $D06A
    inc [hl]
    xor a, a
    ld [$D06B], a
    ld a, $04
    call Func_000_0DF2
    ret

Jump_007_59B6::
    ld a, [$D06B]
    rst $00
    dw Jump_007_59C0
    dw Jump_007_59C0
    dw Jump_007_5A1C

Jump_007_59C0::
    ld a, [$D06B]
    or a, a
    jr z, Jump_007_5A10
    ld b, $E1
    ld de, $4116
    ld hl, $9000
    call Func_000_0CF5
    ld b, $E1
    ld de, $45A7
    ld hl, $C198
    call Func_000_0C5A
    ld a, [$C525]
    or a, a
    jr z, Jump_007_5A02
    ld a, $02
    ldh [$FF70], a
    ld b, $E1
    ld de, $45FC
    ld hl, $D000
    call Func_000_0C5A
    ld a, $00
    ldh [$FF70], a
    ld b, $E1
    ld de, Data_0E1_460F
    ld hl, $C49F
    ld c, $08
    call Func_000_0B2B

Jump_007_5A02::
    ld hl, $9800
    call Func_000_1E29
    call Func_007_600E
    ld a, $FC
    call Func_000_0DF2

Jump_007_5A10::
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$D09D], a
    ld [$D09E], a
    ret

Jump_007_5A1C::
    ld a, [$D09D]
    inc a
    ld [$D09D], a
    cp a, $3C
    jr c, Jump_007_5A39
    xor a, a
    ld [$D09D], a
    ld a, [$D09E]
    inc a
    ld [$D09E], a
    cp a, $03
    jr nc, Jump_007_5A4E
    cp a, $02
    ret c

Jump_007_5A39::
    ld a, [$C562]
    and a, $0B
    ret

Func_007_5A3F:: ; heuristic: follows a terminator; C0
    xor a, a
    ld [$D06B], a
    ld a, $02
    ld [$D06A], a
    ld a, $04
    call Func_000_0DF2
    ret

Jump_007_5A4E::
    ld hl, $D06A
    inc [hl]
    xor a, a
    ld [$D06B], a
    ld a, $04
    call Func_000_0DF2
    ret

Jump_007_5A5C::
    ld a, [$D06B]
    rst $00
    dw Jump_007_5A66
    dw Jump_007_5A66
    dw Jump_007_5AC2

Jump_007_5A66::
    ld a, [$D06B]
    or a, a
    jr z, Jump_007_5AB6
    ld b, $E1
    ld de, $4617
    ld hl, $9000
    call Func_000_0CF5
    ld b, $E1
    ld de, $4946
    ld hl, $C198
    call Func_000_0C5A
    ld a, [$C525]
    or a, a
    jr z, Jump_007_5AA8
    ld a, $02
    ldh [$FF70], a
    ld b, $E1
    ld de, $49BE
    ld hl, $D000
    call Func_000_0C5A
    ld a, $00
    ldh [$FF70], a
    ld b, $E1
    ld de, Data_0E1_49D2
    ld hl, $C49F
    ld c, $08
    call Func_000_0B2B

Jump_007_5AA8::
    ld hl, $9800
    call Func_000_1E29
    call Func_007_600E
    ld a, $FC
    call Func_000_0DF2

Jump_007_5AB6::
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$D09D], a
    ld [$D09E], a
    ret

Jump_007_5AC2::
    ld a, [$D09D]
    inc a
    ld [$D09D], a
    cp a, $5A
    jr nc, Jump_007_5AE9
    cp a, $3C
    ret c
    ld a, [$C562]
    and a, $0B
    ret z
    xor a, a
    ld [$D09D], a
    xor a, a
    ld [$D06B], a
    ld a, $03
    ld [$D06A], a
    ld a, $04
    call Func_000_0DF2
    ret

Jump_007_5AE9::
    xor a, a
    ld [$D09D], a
    ld hl, $D06A
    inc [hl]
    xor a, a
    ld [$D06B], a
    ld a, $04
    call Func_000_0DF2
    ret

Jump_007_5AFB::
    ld a, [$C562]
    and a, $0B
    jr z, Func_007_5B14
    call Func_007_5B14
    ld a, $04
    ld [$D06A], a
    xor a, a
    ld [$D06B], a
    ld a, $04
    call Func_000_0DF2
    ret

Func_007_5B14::
    ld a, [$D06B]
    rst $00
    dw Jump_007_5B2A
    dw Jump_007_5BDC
    dw Jump_007_5C14
    dw Jump_007_5C40
    dw Jump_007_5C5F
    dw Jump_007_5CC1
    dw Jump_007_5CD8
    dw Jump_007_5D56
    dw Jump_007_5DB6

Jump_007_5B2A::
    ld a, [$C56C]
    or a, a
    ret nz
    ld b, $7E
    ld de, $4CED
    ld hl, $8000
    call Func_000_0CF5
    ld b, $7E
    ld de, $5706
    ld hl, $8100
    call Func_000_0CF5
    ld b, $10
    ld hl, $9000

Jump_007_5B4A::
    di
    ld a, $FF
    call Func_000_121F
    ei
    dec b
    jr nz, Jump_007_5B4A
    ld hl, $9800
    ld bc, $0400

Jump_007_5B5A::
    di
    ld a, $00
    call Func_000_121F
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_5B5A
    ld a, [$C525]
    or a, a
    jr z, Jump_007_5BAA
    ld a, $01
    ldh [$FF4F], a
    ld hl, $9800
    ld bc, $0400

Jump_007_5B76::
    di
    ld a, $FF
    call Func_000_121F
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_5B76
    ld a, $00
    ldh [$FF4F], a
    xor a, a
    ld hl, $C49F
    ld bc, $0040
    call Func_000_0949
    ld b, $7E
    ld de, Data_07E_4BBD
    ld hl, $C4DF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4CAD
    ld hl, $C4E7
    ld c, $08
    call Func_000_0B2B

Jump_007_5BAA::
    xor a, a
    ld hl, $D09D
    ld bc, $004C
    call Func_000_0949
    ld hl, $E000
    ld a, l
    ld [$D09D], a
    ld a, h
    ld [$D09E], a
    ld a, $01
    ld [$D0E7], a
    ld hl, $D09F
    call Func_007_5EA2
    call Func_007_600E
    ld a, $FC
    call Func_000_0DF2
    ld a, $DD
    call Func_000_1278
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_5BDC::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$D0E7]
    ld b, a
    ld hl, $D09F
    call Func_007_5DF5
    ld a, [$D0E8]
    inc a
    ld [$D0E8], a
    and a, $07
    ret nz
    ld a, [$D0E7]
    ld hl, $5EE3
    call Func_000_0B0D
    call Func_007_5EA2
    ld a, [$D0E7]
    inc a
    ld [$D0E7], a
    cp a, $0A
    ret c
    xor a, a
    ld [$D0E8], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_5C14::
    ld a, [$D09D]
    ld l, a
    ld a, [$D09E]
    ld h, a
    ld de, $0040
    add hl, de
    ld a, l
    ld [$D09D], a
    ld a, h
    ld [$D09E], a
    call Func_007_5DD6
    ld a, [$D0E7]
    ld b, a
    ld hl, $D09F
    call Func_007_5DF5
    ld a, [$D09E]
    cp a, $50
    ret nz
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_5C40::
    call Func_007_5DD6
    ld a, [$D0E7]
    ld b, a
    ld hl, $D09F
    call Func_007_5DF5
    ld a, [$D0E8]
    dec a
    ld [$D0E8], a
    ret nz
    ld hl, $D06B
    inc [hl]
    ld a, $04
    call Func_000_0DF2
    ret

Jump_007_5C5F::
    ld a, [$D0E7]
    ld b, a
    ld hl, $D09F
    ld a, [$C56C]
    or a, a
    jp nz, Func_007_5DF5
    ld b, $E1
    ld de, $5405
    ld hl, $9000
    call Func_000_0CF5
    ld b, $E1
    ld de, $590F
    ld hl, $C198
    call Func_000_0C5A
    ld a, [$C525]
    or a, a
    jr z, Jump_007_5CA9
    ld a, $02
    ldh [$FF70], a
    ld b, $E1
    ld de, $5974
    ld hl, $D000
    call Func_000_0C5A
    ld a, $00
    ldh [$FF70], a
    ld b, $E1
    ld de, Data_0E1_5A67
    ld hl, $C49F
    ld c, $08
    call Func_000_0B2B

Jump_007_5CA9::
    ld hl, $9800
    call Func_000_1E29
    call Func_007_600E
    ld a, $FC
    call Func_000_0DF2
    ld hl, $D06B
    inc [hl]
    ld a, $5A
    ld [$D09D], a
    ret

Jump_007_5CC1::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$D09D]
    dec a
    ld [$D09D], a
    ret nz
    ld hl, $D06B
    inc [hl]
    ld a, $04
    call Func_000_0DF2
    ret

Jump_007_5CD8::
    ld a, [$C56C]
    or a, a
    ret nz
    ld b, $E1
    ld de, $49DA
    ld hl, $8800
    call Func_000_0CF5
    ld b, $E1
    ld de, $4E67
    ld hl, $9000
    call Func_000_0CF5
    ld b, $E1
    ld de, $5987
    ld hl, $9800
    call Func_000_0CF5
    ld a, [$C525]
    or a, a
    jr z, Jump_007_5D24
    ld a, $01
    ldh [$FF4F], a
    ld b, $E1
    ld de, $59F7
    ld hl, $9800
    call Func_000_0CF5
    ld a, $00
    ldh [$FF4F], a
    ld b, $E1
    ld de, Data_0E1_5A27
    ld hl, $C49F
    ld c, $40
    call Func_000_0B2B

Jump_007_5D24::
    call Func_007_600E
    ld a, $FC
    call Func_000_0DF2
    xor a, a
    ld hl, $D09D
    ld bc, $004C
    call Func_000_0949
    ld a, $01
    ld [$D0E7], a
    ld hl, $6800
    ld a, l
    ld [$D09D], a
    ld a, h
    ld [$D09E], a
    ld hl, $D09F
    call Func_007_5EA2
    call Func_007_5DEF
    ldh [$FF42], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_5D56::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$D0E7]
    ld b, a
    ld hl, $D09F
    call Func_007_5DF5
    ld a, [$D0E7]
    cp a, $0A
    jr nc, Jump_007_5D8B
    ld a, [$D0E8]
    inc a
    ld [$D0E8], a
    and a, $07
    jr nz, Jump_007_5D8B
    ld a, [$D0E7]
    ld hl, $5EE3
    call Func_000_0B0D
    call Func_007_5EA2
    ld a, [$D0E7]
    inc a
    ld [$D0E7], a
    ret

Jump_007_5D8B::
    ld a, [$D09D]
    ld l, a
    ld a, [$D09E]
    ld h, a
    ld de, $0080
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    ld a, l
    ld [$D09D], a
    ld a, h
    ld [$D09E], a
    call Func_007_5DEF
    ld a, [$D09E]
    or a, a
    ret nz
    ld a, $3C
    ld [$D09D], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_5DB6::
    ld a, [$D0E7]
    ld b, a
    ld hl, $D09F
    call Func_007_5DF5
    ld a, [$D09D]
    dec a
    ld [$D09D], a
    ret nz
    ld hl, $D06A
    inc [hl]
    xor a, a
    ld [$D06B], a
    ld a, $04
    call Func_000_0DF2
    ret

Func_007_5DD6::
    ld a, $50
    ldh [$FFA9], a
    ld a, [$D09E]
    ldh [$FFAB], a
    xor a, a
    ldh [$FFAD], a
    ldh [$FFAE], a
    ldh [$FFAF], a
    ldh [$FFB0], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10
    ret

Func_007_5DEF::
    ld a, [$D09E]
    ldh [$FFA5], a
    ret

Func_007_5DF5::
    push bc
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    pop hl
    or a, a
    jr nz, Jump_007_5E11
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [$D09E]
    add a, $50
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, c
    pop hl
    jr Jump_007_5E56

Jump_007_5E11::
    dec a
    jr nz, Jump_007_5E22
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $30
    pop hl
    jr Jump_007_5E56

Jump_007_5E22::
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    add a, $40
    ld [hl], a
    pop hl
    jr nz, Jump_007_5E56
    ld a, [$D06B]
    cp a, $08
    jr nc, Jump_007_5E47
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [$D09E]
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    sub a, $28
    cp a, c
    pop hl
    jr Jump_007_5E56

Jump_007_5E47::
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [$D09E]
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    sub a, $18
    cp a, c
    pop hl

Jump_007_5E56::
    push hl
    call z, Func_007_5EA2
    pop hl
    ld a, [hl]
    inc a
    ld [hl+], a
    ld c, a
    ld a, [hl]
    and a, $03
    push de
    ld de, $5EFB
    add a, e
    ld e, a
    jr nc, Jump_007_5E6B
    inc d

Jump_007_5E6B::
    ld a, [de]
    pop de
    ld b, a
    ld a, c
    cp a, b
    jr c, Jump_007_5E77
    ld a, [hl]
    inc a
    ld [hl-], a
    xor a, a
    ld [hl+], a

Jump_007_5E77::
    call Func_007_5E80
    pop bc
    dec b
    jp nz, Func_007_5DF5
    ret

Func_007_5E80::
    ld a, [hl+]
    and a, $03
    ldh [$FFAE], a
    ld a, [hl+]
    ldh [$FFA9], a
    ld a, [hl+]
    ldh [$FFAB], a
    ld a, $1E
    ldh [$FFAD], a
    ld a, $10
    ldh [$FFAF], a
    ld a, $01
    ldh [$FFB0], a
    inc hl
    inc hl
    push hl
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10
    pop hl
    ret

Func_007_5EA2::
    xor a, a
    ld [hl+], a
    ld [hl+], a
    push hl
    call Func_000_095B
    pop hl
    and a, $3F
    add a, $30
    ld [hl+], a
    ld a, [$D06B]
    cp a, $03
    jr nc, Jump_007_5EBE
    ld a, [$D09E]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ret

Jump_007_5EBE::
    cp a, $05
    jr nc, Jump_007_5ED7
    push hl
    call Func_000_095B
    pop hl
    and a, $3F
    ld e, a
    ld a, [$D09E]
    sub a, $20
    add a, e
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret

Jump_007_5ED7::
    ld a, [$D09E]
    sub a, $20
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret
    db $9F, $D0, $A5, $D0, $AB, $D0, $B1, $D0, $B7, $D0, $BD, $D0, $C3, $D0, $C9, $D0
    db $CF, $D0, $D5, $D0, $DB, $D0, $E1, $D0, $04, $07, $07, $04

Jump_007_5EFF::
    ld a, [$D06B]
    rst $00
    dw Jump_007_5F09
    dw Jump_007_5F89
    dw Jump_007_5F9D

Jump_007_5F09::
    ld a, [$C56C]
    or a, a
    ret nz
    ld b, $E1
    ld de, $577C
    ld hl, $8000
    call Func_000_0CF5
    ld b, $E1
    ld de, $49DA
    ld hl, $8800
    call Func_000_0CF5
    ld b, $E1
    ld de, $4E67
    ld hl, $9000
    call Func_000_0CF5
    ld b, $E1
    ld de, $582B
    ld hl, $C198
    call Func_000_0C5A
    ld a, [$C525]
    or a, a
    jr z, Jump_007_5F6D
    ld a, $02
    ldh [$FF70], a
    ld b, $E1
    ld de, $58C3
    ld hl, $D000
    call Func_000_0C5A
    ld a, $00
    ldh [$FF70], a
    ld b, $E1
    ld de, Data_0E1_5A27
    ld hl, $C49F
    ld c, $40
    call Func_000_0B2B
    ld b, $E1
    ld de, Data_0E1_5AA7
    ld hl, $C4DF
    ld c, $10
    call Func_000_0B2B

Jump_007_5F6D::
    ld hl, $9800
    call Func_000_1E29
    call Func_007_600E
    ld a, $FC
    call Func_000_0DF2
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$D09D], a
    ld [$D09E], a
    ldh [$FFA5], a
    ret

Jump_007_5F89::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, $B4
    ld [$D09D], a
    ld a, $06
    call Func_000_122D
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_5F9D::
    ld a, [$C562]
    and a, $0B
    jr nz, Jump_007_5FCF
    ld a, [$DC40]
    ld hl, $DC60
    and a, [hl]
    ld hl, $DC80
    and a, [hl]
    ld hl, $DCA0
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [$D09D]
    dec a
    ld [$D09D], a
    jr z, Jump_007_5FC0
    ret

Jump_007_5FC0::
    ld a, $04
    call Func_000_0DF2
    xor a, a
    ld [$D06B], a
    ld a, $02
    ld [$D06A], a
    ret

Jump_007_5FCF::
    ld a, $04
    call Func_000_0DF2
    ld a, $01
    ld [$C5DC], a
    ld a, $00
    ld [$C5DD], a
    ld a, $00
    ld [$C5DE], a
    ld hl, $C5DF
    inc [hl]
    ret

Func_007_5FE8:: ; heuristic: follows a terminator; C0
    ld a, [$C525]
    or a, a
    ret z
    xor a, a
    ldh [$FFAD], a
    ld a, $01
    xor a, $01
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAF], a
    ldh [$FFAA], a
    ldh [$FFAC], a
    ldh [$FFB0], a
    ld a, $38
    ldh [$FFA9], a
    ld a, $30
    ldh [$FFAB], a
    ld hl, Func_0E1_5AB7
    ld b, $E1
    rst $10
    ret

Func_007_600E::
    ld hl, $C5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld hl, $D040
    ld a, [$C5E9]
    ld [hl+], a
    ld a, [$C5EA]
    ld [hl+], a
    ld a, [$C5EB]
    ld [hl], a
    call Func_000_0DCA
    ld a, [$C524]
    or a, a
    jr z, Jump_007_608F
    xor a, a
    ldh [$FF47], a
    ldh [$FF48], a
    ldh [$FF49], a
    ld a, [$C51F]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [$C577], a
    ld a, h
    ld [$C578], a
    inc hl
    ld a, l
    ld [$C579], a
    ld a, h
    ld [$C57A], a
    inc hl
    ld a, l
    ld [$C57B], a
    ld a, h
    ld [$C57C], a
    inc hl
    ld a, l
    ld [$C57D], a
    ld a, h
    ld [$C57E], a
    ld a, $B1
    ld [$C47F], a
    ld a, [$C520]
    ld [$C480], a
    ld a, $FF
    ld [$C47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld hl, Func_017_421A
    ld b, $17
    rst $10
    ld hl, $58FA
    ld de, $C4FF
    ld bc, $0008
    call Func_000_0952

Jump_007_608F::
    ret

Jump_007_6090::
    ld a, [$C56C]
    and a, a
    ret nz
    ld a, $02
    ld [$D781], a
    ld a, [$D06A]
    rst $00
    dw Jump_007_60B0
    dw Jump_007_65C5
    dw Jump_007_65FC
    dw Jump_007_66A2
    dw Jump_007_67DB
    dw Jump_007_681C
    dw Jump_007_683A
    dw Jump_007_66E0
    dw Jump_007_6759

Jump_007_60B0::
    call Func_007_60E9
    ld a, [$C58B]
    or a, a
    jr z, Jump_007_60E8
    ld a, [$C58B]
    ld b, a
    xor a, a
    ld [$C58B], a
    ld a, [$C5DF]
    or a, a
    jr nz, Jump_007_60E8
    ld a, $0F
    ld [$D786], a
    ld a, b
    ld [$C588], a
    call Func_000_08AD
    ld a, $01
    ld [$D786], a

Jump_007_60D8::
    ld a, [$C580]
    and a, $03
    cp a, $03
    jr nz, Jump_007_60D8
    ld a, [$C5DF]
    and a, a
    jr nz, Jump_007_60E7

Jump_007_60E7::
    ret

Jump_007_60E8::
    ret

Func_007_60E9::
    ld a, [$D06B]
    rst $00
    dw Jump_007_60F3
    dw Jump_007_6145
    dw Jump_007_6231

Jump_007_60F3::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $C198
    ld bc, $0240
    ld a, $C3
    call Func_000_0949
    ld hl, $514F
    ld a, [$C894]
    or a, a
    jr z, Jump_007_611B
    ld hl, $5207

Jump_007_611B::
    call Func_007_4AFE
    call Func_007_4B1E
    ld a, [$C894]
    and a, $01
    ld a, $07
    jr z, Jump_007_612C
    ld a, $08

Jump_007_612C::
    ld [$C46F], a
    xor a, a
    ld [$C470], a
    ld a, [$C46B]
    ld [$C471], a
    xor a, a
    ld [$C58B], a
    ld [$C588], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6145::
    ld a, [$C56C]
    and a, a
    jr z, Jump_007_615D
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ret

Jump_007_615D::
    ld a, [$C52B]
    bit 0, a
    jr z, Jump_007_6176
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ret

Jump_007_6176::
    ld a, [$C562]
    bit 0, a
    jr nz, Jump_007_6182
    call Func_007_6213
    jr Jump_007_6187

Jump_007_6182::
    ld a, $C0
    call Func_000_08BA

Jump_007_6187::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_007_61F8
    ld a, [$C524]
    or a, a
    jr z, Jump_007_61CE
    ld a, [$C46B]
    and a, $0F
    cp a, $02
    jr c, Jump_007_61CE
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld a, $00
    ld [$C528], a
    ld a, $07
    ld [$C529], a
    ld hl, Func_007_4001
    ld b, $07
    rst $10
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_007_4B27
    ld a, $05
    ld [$D06A], a
    ret

Jump_007_61CE::
    ld a, [$C46B]
    and a, $0F
    ld b, $02
    ld c, $08
    cp a, c
    jr nc, Jump_007_61DC
    cp a, b
    ccf

Jump_007_61DC::
    jr c, Jump_007_61EE
    ld a, [$C46B]
    ld hl, $5086
    and a, $07
    call Func_007_50FE
    ld a, $69
    call Func_000_1278

Jump_007_61EE::
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$D06C], a
    jr Jump_007_6212

Jump_007_61F8::
    ld de, $5086
    ld hl, $C46B
    ld a, [$C471]
    cp a, [hl]
    call nz, Func_007_5066
    ld a, [$C471]
    ld [hl], a
    call Func_007_4F9D
    ld a, [$C46B]
    ld [$C471], a

Jump_007_6212::
    ret

Func_007_6213::
    ld a, [$C471]
    ld de, $65BD
    and a, $0F
    add a, e
    ld e, a
    jr nc, Jump_007_6220
    inc d

Jump_007_6220::
    xor a, a
    ld [$D781], a
    ld a, [de]
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ret

Jump_007_6231::
    ld a, [$C46B]
    and a, $0F
    rst $00
    dw Jump_007_6247
    dw Jump_007_63A5
    dw Jump_007_63B7
    dw Jump_007_641C
    dw Jump_007_646B
    dw Jump_007_6558
    dw Jump_007_64BA
    dw Jump_007_6509

Jump_007_6247::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld a, [$D06C]
    rst $00
    dw Jump_007_6262
    dw Jump_007_62BA
    dw Jump_007_62ED

Jump_007_6262::
    ld hl, $9680
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0401
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $00
    ld [$C528], a
    ld a, $04
    ld [$C529], a
    ld hl, Func_007_400F
    ld b, $07
    rst $10
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $5367
    call Func_007_4AFE
    ld hl, Func_016_777B
    ld b, $16
    rst $10
    ld a, $BC
    ld [$C1B9], a
    call Func_007_4B1E
    call Func_007_635A
    ld hl, $D06C
    inc [hl]
    ret

Jump_007_62BA::
    ld a, [$C562]
    and a, $01
    jr z, Jump_007_62CE
    ld hl, $D06C
    inc [hl]
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    jr Jump_007_62E9

Jump_007_62CE::
    ld a, [$C562]
    and a, $02
    jr z, Jump_007_62E9
    ld hl, $C198
    ld bc, $0240
    ld a, $C3
    call Func_000_0949
    xor a, a
    ld [$D06C], a
    xor a, a
    ld [$D06B], a
    ret

Jump_007_62E9::
    call Func_007_635A
    ret

Jump_007_62ED::
    call Func_007_635A
    ld hl, Func_002_717D
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    ret z
    ld hl, Func_060_6CD1
    ld b, $60
    rst $10
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_007_6319
    cp a, $80
    jr nz, Jump_007_6319
    ld a, [$CD0D]
    ld [$C190], a
    ld a, [$CD0E]
    ld [$C191], a

Jump_007_6319::
    xor a, a
    ld [$C8C7], a
    xor a, a
    ld [$D069], a
    ld [$D091], a
    ld hl, Func_004_449F
    ld b, $04
    rst $10
    ldh a, [$FF98]
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ldh a, [$FF8E]
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ldh a, [$FF91]
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    call Func_007_63AC
    ld hl, Func_00A_476E
    ld b, $0A
    rst $10
    ld a, $03
    ld [$D06A], a
    ret

Func_007_635A::
    ld a, $0A
    ld [$0100], a
    ld a, $01
    ld [$4100], a
    ld a, [$D0D5]
    or a, a
    jr z, Jump_007_639C
    ld a, [$D10A]
    or a, a
    jr z, Jump_007_639C
    ld a, $29
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    ldh [$FFAF], a
    ldh [$FFB0], a
    ld hl, $0080
    ld a, l
    ldh [$FFA9], a
    ld a, h
    ldh [$FFAA], a
    ld hl, $0040
    ld a, l
    ldh [$FFAB], a
    ld a, h
    ldh [$FFAC], a
    xor a, a
    ld [$4100], a
    xor a, a
    ld [$0100], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10
    ret

Jump_007_639C::
    xor a, a
    ld [$4100], a
    xor a, a
    ld [$0100], a
    ret

Jump_007_63A5::
    call Func_007_63AC
    call Func_007_65F1
    ret

Func_007_63AC::
    ld hl, $D780
    ld b, $80

Jump_007_63B1::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_007_63B1
    ret

Jump_007_63B7::
    ld a, [$C470]
    cp a, $FF
    jr z, Jump_007_63CD
    cp a, $FE
    jr z, Jump_007_63E7
    ld a, $00
    ld [$C55D], a
    ld a, $F5
    ld [$C58B], a
    ret

Jump_007_63CD::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $98A1
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_63E7::
    ld a, $02
    ld [$D786], a
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $98A1
    ld a, $BC
    call Func_007_6406
    ret

Func_007_6406::
    call Func_000_1211
    ld a, $69
    call Func_000_1278
    xor a, a
    ld [$C58B], a
    ld a, $07
    ld [$D06A], a
    xor a, a
    ld [$C470], a
    ret

Jump_007_641C::
    ld a, [$C470]
    cp a, $FF
    jr z, Jump_007_6432
    cp a, $FE
    jr z, Jump_007_644C
    ld a, $00
    ld [$C55D], a
    ld a, $F6
    ld [$C58B], a
    ret

Jump_007_6432::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $98E1
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_644C::
    ld a, $02
    ld [$D786], a
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $98E1
    ld a, $BC
    call Func_007_6406
    ret

Jump_007_646B::
    ld a, [$C470]
    cp a, $FF
    jr z, Jump_007_6481
    cp a, $FE
    jr z, Jump_007_649B
    ld a, $00
    ld [$C55D], a
    ld a, $B7
    ld [$C58B], a
    ret

Jump_007_6481::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $9921
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_649B::
    ld a, $02
    ld [$D786], a
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $9921
    ld a, $BC
    call Func_007_6406
    ret

Jump_007_64BA::
    ld a, [$C470]
    cp a, $FF
    jr z, Jump_007_64D0
    cp a, $FE
    jr z, Jump_007_64EA
    ld a, $00
    ld [$C55D], a
    ld a, $E0
    ld [$C58B], a
    ret

Jump_007_64D0::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $99A1
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_64EA::
    ld a, $02
    ld [$D786], a
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $99A1
    ld a, $BC
    call Func_007_6406
    ret

Jump_007_6509::
    ld a, [$C470]
    cp a, $FF
    jr z, Jump_007_651F
    cp a, $FE
    jr z, Jump_007_6539
    ld a, $00
    ld [$C55D], a
    ld a, $F1
    ld [$C58B], a
    ret

Jump_007_651F::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $99E1
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_6539::
    ld a, $02
    ld [$D786], a
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $99E1
    ld a, $BC
    call Func_007_6406
    ret

Jump_007_6558::
    ld a, [$C470]
    cp a, $FF
    jr z, Jump_007_656E
    cp a, $FE
    jr z, Jump_007_6588
    ld a, $00
    ld [$C55D], a
    ld a, $DC
    ld [$C58B], a
    ret

Jump_007_656E::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $9961
    ld a, $BC
    call Func_007_65A7
    ret

Jump_007_6588::
    ld a, $02
    ld [$D786], a
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $9961
    ld a, $BC
    call Func_007_6406
    ret

Func_007_65A7::
    call Func_000_1211
    ld a, $69
    call Func_000_1278
    xor a, a
    ld [$C58B], a
    ld a, $04
    ld [$D06A], a
    xor a, a
    ld [$C470], a
    ret
    db $F4, $F4, $FA, $FB, $FC, $DD, $E1, $F3

Jump_007_65C5::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld a, $01
    ld [$C46B], a
    ld a, $01
    ld [$C46F], a
    ld hl, $D09D
    ld [hl], $00
    ld de, $5086
    call Func_007_4F9D
    ld a, [$C562]
    and a, $01
    ret z

Func_007_65F1::
    ld hl, $D06A
    ld a, $06
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ret

Jump_007_65FC::
    ld a, [$D06B]
    rst $00
    dw Jump_007_6606
    dw Jump_007_6624
    dw Jump_007_6633

Jump_007_6606::
    ld a, [$C56C]
    or a, a
    ret nz
    xor a, a
    ld [$C528], a
    ld a, $03
    ld [$C529], a
    ld hl, Func_007_4001
    ld b, $07
    rst $10
    ld a, $52
    call Func_000_122D
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6624::
    ld a, [$DC00]
    ld hl, $DC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6633::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld hl, $A000
    ld bc, $2000
    xor a, a
    call Func_000_0949
    ld a, $01
    ld [$4100], a
    ld hl, $A000
    ld bc, $2000
    xor a, a
    call Func_000_0949
    ld a, $02
    ld [$4100], a
    ld hl, $A000
    ld bc, $2000
    xor a, a
    call Func_000_0949
    ld a, $03
    ld [$4100], a
    ld hl, $A000
    ld bc, $2000
    xor a, a
    call Func_000_0949
    xor a, a
    ld [$4100], a
    xor a, a
    ld [$0100], a
    ld hl, $C198
    ld bc, $0240
    ld a, $C3
    call Func_000_0949
    ld hl, $52D7
    call Func_007_4AFE
    call Func_007_4B1E
    xor a, a
    ld [$D06B], a
    ld hl, $D06A
    dec [hl]
    ld a, $09
    call Func_000_122D
    ret

Jump_007_66A2::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld a, $04
    call Func_000_0DF2
    ld hl, $C5DB
    ld a, $01
    ld [hl+], a
    ld a, [$C91F]
    bit 0, a
    ld a, $01
    jr nz, Jump_007_66D2
    ld a, [$CC44]
    bit 7, a
    ld a, $05
    jr nz, Jump_007_66D2
    ld a, $00

Jump_007_66D2::
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld [hl], $00
    call Func_007_63AC
    ld hl, $C5DF
    inc [hl]
    ret

Jump_007_66E0::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld a, [$C588]
    ld b, a
    and a, $F0
    swap a
    ld [$C130], a
    ld a, b
    and a, $0F
    ld [$C131], a
    ld a, $F0
    ld [$C132], a
    ld a, [$D787]
    ld [$C134], a
    ld a, $F0
    ld [$C135], a
    ld a, [$D780]
    ld b, a
    and a, $F0
    swap a
    ld [$C138], a
    ld a, b
    and a, $0F
    ld [$C139], a
    ld a, $F0
    ld [$C13A], a
    ld a, $00
    ld [$C528], a
    ld a, $07
    ld [$C529], a
    ld hl, Func_007_4001
    ld b, $07
    rst $10
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_007_4B27
    ld a, $05
    ld [$D06A], a
    ret

Jump_007_6759::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    call Func_007_5066
    ld a, [$C471]
    ld [$C46B], a
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld a, [$D783]
    ld b, a
    and a, $F0
    swap a
    ld [$C130], a
    ld a, b
    and a, $0F
    ld [$C131], a
    ld a, $F0
    ld [$C132], a
    ld a, [$D784]
    ld [$C134], a
    ld a, $F0
    ld [$C135], a
    ld a, [$D785]
    ld b, a
    and a, $F0
    swap a
    ld [$C138], a
    ld a, b
    and a, $0F
    ld [$C139], a
    ld a, $F0
    ld [$C13A], a
    ld a, $00
    ld [$C528], a
    ld a, $08
    ld [$C529], a
    ld hl, Func_007_4001
    ld b, $07
    rst $10
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_007_4B27
    ld a, $05
    ld [$D06A], a
    ret

Jump_007_67DB::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld a, $00
    ld [$C528], a
    ld a, $05
    ld [$C529], a
    ld hl, Func_007_4001
    ld b, $07
    rst $10
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_007_4B27
    ld hl, $D06A
    inc [hl]
    ret

Jump_007_681C::
    xor a, a
    ld [$D781], a
    ld a, $F4
    ld [$D782], a
    call Func_000_08BA
    ld a, $01
    ld [$D781], a
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$D06A], a
    ld [$D06B], a
    ret

Jump_007_683A::
    ld a, [$D06B]
    rst $00
    dw Jump_007_684C
    dw Jump_007_6856
    dw Jump_007_68B7
    dw Jump_007_68C1
    dw Jump_007_68DE
    dw Jump_007_68E3
    dw Jump_007_6919

Jump_007_684C::
    ld a, $04
    call Func_000_0DF2
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6856::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, $C3
    ld hl, $C198
    ld bc, $02D0
    call Func_000_0949
    ld a, [$C525]
    or a, a
    jr z, Jump_007_687D
    ld a, $02
    ldh [$FF70], a
    xor a, a
    ld hl, $D000
    ld bc, $02D0
    call Func_000_0949
    xor a, a
    ldh [$FF70], a

Jump_007_687D::
    ld hl, $9800
    call Func_000_1E29
    ld a, [$C524]
    or a, a
    jr z, Jump_007_6897
    ld hl, $C4DF
    ld de, $C4FF
    ld b, $20

Jump_007_6891::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_007_6891

Jump_007_6897::
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $FC
    call Func_000_0DF2
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_68B7::
    ld a, [$C56C]
    or a, a
    ret nz
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_68C1::
    ld e, $01
    ld d, $00
    call Func_000_1845
    ld a, $01
    ld [$D09D], a
    ld de, $0000
    call Func_000_181B
    jr c, Jump_007_68D9
    xor a, a
    ld [$D09D], a

Jump_007_68D9::
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_68DE::
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_68E3::
    ld hl, $D7F1
    ld a, $00
    ld [hl+], a
    ld a, [$D09D]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld hl, Func_014_5CA8
    ld b, $14
    rst $10
    call Func_000_095B
    ld a, [$C5E7]
    ld [$C616], a
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld de, $C8CF
    ld hl, $C60C
    ld b, $0A

Jump_007_690E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_007_690E
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6919::
    ld a, $38
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $E0
    ldh [$FF8E], a
    ld [$C8F0], a
    xor a, a
    ldh [$FF91], a
    ld [$C8F1], a
    xor a, a
    ldh [$FF98], a
    ld [$C8EF], a
    ld a, $00
    ld [$C6FD], a
    ld a, $00
    ld [$C6FE], a
    call Func_007_695A
    call Func_007_6975
    ld hl, $C707
    ld bc, $0080
    ld a, $FF
    call Func_000_0949
    xor a, a
    ld [$C8C7], a
    ld a, $03
    ld [$D06A], a
    ret

Func_007_695A::
    ld a, $64
    ld [$C617], a
    ld a, $00
    ld [$C618], a
    ld a, $00
    ld [$C619], a
    ld hl, $C61D
    ld bc, $0018
    ld a, $00
    call Func_000_0949
    ret

Func_007_6975::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld hl, $0001
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_034_4001
    ld b, $34
    rst $10
    ld hl, $A000
    ld a, $02
    ld [hl+], a
    ld a, $1C
    ld [hl+], a
    ld a, $2F
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $36
    ld [hl+], a
    ld a, $2B
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [$CFEC]
    ld [hl+], a
    ld a, [$CFED]
    ld [hl+], a
    inc hl
    xor a, a
    ld [hl+], a
    ld de, $C60C
    ld b, $0B
    call Func_007_6AD5
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$CFEE]
    ld [hl+], a
    ld a, [$CFEF]
    ld [hl+], a
    ld a, [$CFF0]
    ld [hl+], a
    ld a, [$CFF1]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    xor a, a
    ld [hl+], a
    ld a, [$CFF5]
    ld [hl+], a
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$CFF6]
    ld [hl+], a
    ld a, [$CFF7]
    ld [hl+], a
    ld a, [$CFF6]
    ld [hl+], a
    ld a, [$CFF7]
    ld [hl+], a
    ld a, [$CFF8]
    ld [hl+], a
    ld a, [$CFF9]
    ld [hl+], a
    ld a, [$CFF8]
    ld [hl+], a
    ld a, [$CFF9]
    ld [hl+], a
    ld a, [$CFFA]
    ld [hl+], a
    ld a, [$CFFB]
    ld [hl+], a
    ld a, [$CFFC]
    ld [hl+], a
    ld a, [$CFFD]
    ld [hl+], a
    ld a, [$CFFE]
    ld [hl+], a
    ld a, [$CFFF]
    ld [hl+], a
    ld a, [$D000]
    ld [hl+], a
    ld a, [$D001]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [$D002]
    ld [hl+], a
    ld a, [$D003]
    ld [hl+], a
    ld a, [$D004]
    ld [hl+], a
    ld a, [$D005]
    ld [hl+], a
    ld a, [$CFEC]
    ld l, a
    ld a, [$CFED]
    ld h, a
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld hl, $A00D
    ld a, [$D008]
    ld [hl], a
    ld a, l
    add a, $2F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D010]
    ld [hl+], a
    ld a, [$D011]
    ld [hl+], a
    ld a, [$D012]
    ld [hl+], a
    ld b, $16
    ld a, $FF
    call Func_007_6AD0
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D00E]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $18
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld de, $D01A
    ld b, $1B
    call Func_007_6AD5
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld [hl], $00
    ld hl, $A08E
    call Func_007_6ADC
    ld hl, $A099
    call Func_007_6ADC
    ld hl, $A01E
    call Func_007_6ADC
    ld hl, $A029
    call Func_007_6ADC
    ld hl, Func_016_5AAF
    ld b, $16
    rst $10
    ret

Func_007_6AD0::
    ld [hl+], a
    dec b
    jr nz, Func_007_6AD0
    ret

Func_007_6AD5::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Func_007_6AD5
    ret

Func_007_6ADC::
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld b, $07

Jump_007_6AE9::
    ld [hl+], a
    dec b
    jr nz, Jump_007_6AE9
    ret

Jump_007_6AEE::
    ld a, [$C581]
    cp a, $05
    jp z, Jump_007_7D38
    call Func_000_0535
    ld a, [$D06A]
    cp a, $01
    jr z, Jump_007_6B01
    ret

Jump_007_6B01::
    ld a, [$D780]
    cp a, $0C
    jr z, Jump_007_6B7D
    cp a, $0D
    jp z, Jump_007_6B9C
    ld a, [$D7EE]
    and a, a
    jr z, Jump_007_6B23
    ld hl, Func_002_7333
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    ret z
    xor a, a
    ld [$D7EE], a

Jump_007_6B23::
    ld a, [$C94B]
    or a, a
    ret z
    ld a, $01
    ld [$C5DB], a
    ld a, $01
    ld [$C5DF], a
    xor a, a
    ld [$CC44], a
    xor a, a
    ld [$C917], a
    ld a, $21
    ld [$C916], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ld hl, Func_010_4008
    ld b, $10
    rst $10
    ld a, $E0
    ldh [$FF8E], a
    ld a, $00
    ldh [$FF91], a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $14
    ldh [$FF90], a
    xor a, a
    ldh [$FF8C], a
    ld [$C6FD], a
    xor a, a
    ld [$C8C7], a
    ld a, [$C88D]
    ld [$C965], a
    xor a, a
    ld [$C88D], a
    xor a, a
    ld [$C58A], a
    ld [$C94B], a
    ld [$D7FD], a
    ld [$D7F0], a
    ret

Jump_007_6B7D::
    ld a, [$D782]
    and a, a
    ret nz
    ld a, [$D781]
    cp a, $15
    jr z, Jump_007_6B8E
    cp a, $20
    jr z, Jump_007_6B95
    ret

Jump_007_6B8E::
    ld hl, Func_01D_5C35
    ld b, $1D
    rst $10
    ret

Jump_007_6B95::
    ld hl, Func_01D_5BF2
    ld b, $1D
    rst $10
    ret

Jump_007_6B9C::
    ld a, [$D781]
    cp a, $15
    jr z, Jump_007_6BA8
    cp a, $20
    jr z, Jump_007_6BAF
    ret

Jump_007_6BA8::
    ld hl, Func_0F1_5719
    ld b, $F1
    rst $10
    ret

Jump_007_6BAF::
    ld hl, Func_0F2_4EDD
    ld b, $F2
    rst $10
    ret
    db $C9

Jump_007_6BB7::
    call Func_000_0535
    ld a, [$D06A]
    cp a, $01
    jr z, Jump_007_6BC2
    ret

Jump_007_6BC2::
    ret

Jump_007_6BC3::
    call Func_000_0535
    ld a, [$D06A]
    or a, a
    jr nz, Jump_007_6BCD
    ret

Jump_007_6BCD::
    ld a, [$D780]
    cp a, $0C
    jr z, Jump_007_6BD9
    cp a, $0D
    jr z, Jump_007_6BF8
    ret

Jump_007_6BD9::
    ld a, [$D782]
    and a, a
    ret nz
    ld a, [$D781]
    cp a, $20
    jr z, Jump_007_6BF1
    cp a, $15
    jr z, Jump_007_6BEA
    ret

Jump_007_6BEA::
    ld hl, Func_01D_5C35
    ld b, $1D
    rst $10
    ret

Jump_007_6BF1::
    ld hl, Func_01D_5BF2
    ld b, $1D
    rst $10
    ret

Jump_007_6BF8::
    ld a, [$D781]
    cp a, $15
    jr z, Jump_007_6C04
    cp a, $20
    jr z, Jump_007_6C0B
    ret

Jump_007_6C04::
    ld hl, Func_0F1_5719
    ld b, $F1
    rst $10
    ret

Jump_007_6C0B::
    ld hl, Func_0F2_4EDD
    ld b, $F2
    rst $10
    ret

Func_007_6C12::
    ld a, [$D06A]
    rst $00
    dw Jump_007_6C28
    dw Jump_007_6CCD
    dw Jump_007_6E16
    dw Jump_007_6F34
    dw Jump_007_7864
    dw Jump_007_79FC
    dw Jump_007_7AC2
    dw Jump_007_7ACD
    dw Jump_007_7C7E

Jump_007_6C28::
    ld a, [$D06B]
    rst $00
    dw Jump_007_6C32
    dw Jump_007_6CAB
    dw Jump_007_6CB8

Jump_007_6C32::
    ld a, [$C56C]
    or a, a
    ret nz
    di
    ld hl, Func_002_717D
    ld b, $02
    rst $10
    ei
    call Func_007_6C59
    ld hl, Func_012_64F8
    ld b, $12
    rst $10
    ld a, $04
    ld [$C46F], a
    xor a, a
    ld [$C594], a
    ld a, [$D06B]
    inc a
    ld [$D06B], a
    ret

Func_007_6C59::
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE
    ld de, $C972

Jump_007_6C68::
    push hl
    ld a, [hl]
    ld c, $5B
    call Func_000_1F89
    ldh a, [$FFC6]
    ld [de], a
    inc de
    ldh a, [$FFC7]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $5F
    call Func_000_1F89
    ldh a, [$FFC6]
    ld [de], a
    inc de
    ldh a, [$FFC7]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    ldh a, [$FFC6]
    ld [de], a
    inc de
    pop hl
    inc hl
    dec b
    jr nz, Jump_007_6C68
    xor a, a
    ld [$0100], a
    ld a, [$C6FD]
    cp a, $03
    ret z
    ld a, $FF
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ret

Jump_007_6CAB::
    ld a, [$D06B]
    inc a
    ld [$D06B], a
    ld a, $D3
    ld [$C594], a
    ret

Jump_007_6CB8::
    ld a, [$C58F]
    cp a, $D3
    ret nz
    xor a, a
    ld [$C594], a
    ld [$D06B], a
    ld a, [$D06A]
    inc a
    ld [$D06A], a
    ret

Jump_007_6CCD::
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_007_6CEA
    ld a, $01
    ld [$D06B], a
    ld a, $01
    ld [$D06C], a
    ld a, $01
    ld [$C594], a
    ld hl, $D06A
    inc [hl]
    jp Jump_007_6DA8

Jump_007_6CEA::
    cp a, $FD
    jr nz, Jump_007_6D06
    ld a, $08
    ld [$CFC5], a
    ld hl, $D06A
    inc [hl]
    ld hl, $D06A
    inc [hl]
    ld hl, $D06A
    inc [hl]
    xor a, a
    ld [$C594], a
    jp Jump_007_6DA8

Jump_007_6D06::
    cp a, $FC
    jr nz, Jump_007_6D19
    call Func_007_6DC2
    ld a, $09
    ld [$CFC5], a
    ld a, $01
    ld [$D059], a
    jr Jump_007_6D2A

Jump_007_6D19::
    cp a, $FB
    jr nz, Jump_007_6D32
    call Func_007_6DA9
    ld a, $08
    ld [$CFC5], a
    ld a, $00
    ld [$D059], a

Jump_007_6D2A::
    ld a, $08
    ld [$D06A], a
    jp Jump_007_6DA8

Jump_007_6D32::
    ld de, $5096
    ld hl, $C46B
    call Func_007_4F9D
    ld a, [$C562]
    and a, $01
    jr z, Jump_007_6D90
    ld a, $69
    call Func_000_1278
    ld a, [$C46B]
    and a, $03
    cp a, $03
    jr z, Jump_007_6D97
    or a, a
    jr z, Jump_007_6D64
    cp a, $01
    jr z, Jump_007_6D76
    call Func_007_6DE3
    ld a, $08
    ld [$CFC5], a
    ld de, $FD03
    jr Jump_007_6D86

Jump_007_6D64::
    call Func_007_6DA9
    ld a, $08
    ld [$CFC5], a
    ld a, $00
    ld [$D059], a
    ld de, $FB05
    jr Jump_007_6D86

Jump_007_6D76::
    call Func_007_6DC2
    ld a, $09
    ld [$CFC5], a
    ld a, $01
    ld [$D059], a
    ld de, $FC05

Jump_007_6D86::
    ld a, e
    ld [$D06A], a
    ld a, d
    ld [$C594], a
    jr Jump_007_6DA8

Jump_007_6D90::
    ld a, [$C562]
    and a, $02
    jr z, Jump_007_6DA8

Jump_007_6D97::
    ld a, $FE
    ld [$C594], a
    xor a, a
    ld [$D06C], a
    xor a, a
    ld [$D06B], a
    ld hl, $D06A
    inc [hl]

Jump_007_6DA8::
    ret

Func_007_6DA9::
    ld hl, $D043
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $63
    ld [hl+], a
    ld a, $29
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld a, $63
    ld [hl+], a
    ld [hl], $80
    ret

Func_007_6DC2::
    ld hl, $D043
    ld a, $01
    ld [hl+], a
    ld a, $81
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $63
    ld [hl+], a
    ld a, $29
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $80
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $9E
    ld [hl+], a
    ld [hl], $00
    ret

Func_007_6DE3::
    ld hl, $D09D
    xor a, a
    ld [hl+], a
    ld a, [$D044]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [$D048]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [$D049]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [$D04B]
    rlca
    and a, $01
    xor a, $01
    ld [hl+], a
    ld a, [$D04C]
    rlca
    and a, $01
    xor a, $01
    ld [hl], a
    ret

Jump_007_6E16::
    ld a, [$D06B]
    rst $00
    dw Jump_007_6E2A
    dw Jump_007_6E9A
    dw Jump_007_6EA4
    dw Jump_007_6EC5
    dw Jump_007_6ECF
    dw Jump_007_6EE1
    dw Jump_007_6EF0
    dw Jump_007_6EFB

Jump_007_6E2A::
    ld a, [$C58F]
    cp a, $01
    jr z, Jump_007_6E8C
    cp a, $FE
    jr z, Jump_007_6E8C
    cp a, $FB
    jr z, Jump_007_6E42
    cp a, $FC
    jr z, Jump_007_6E5C
    cp a, $FD
    jr z, Jump_007_6E76
    ret

Jump_007_6E42::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_007_6E8C
    call Func_007_6DA9
    ld a, $08
    ld [$CFC5], a
    ld a, $00
    ld [$D059], a
    ld a, $05
    ld [$D06A], a
    ret

Jump_007_6E5C::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_007_6E8C
    call Func_007_6DC2
    ld a, $09
    ld [$CFC5], a
    ld a, $01
    ld [$D059], a
    ld a, $05
    ld [$D06A], a
    ret

Jump_007_6E76::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_007_6E8C
    ld a, $08
    ld [$CFC5], a
    ld a, $04
    ld [$D06A], a
    xor a, a
    ld [$C594], a
    ret

Jump_007_6E8C::
    xor a, a
    ld [$C594], a
    ld a, $01
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6E9A::
    ld hl, $D06B
    inc [hl]
    ld a, $02
    ld [$C594], a
    ret

Jump_007_6EA4::
    ld a, [$C58F]
    cp a, $02
    ret nz
    xor a, a
    ld [$C594], a
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_007_4B27
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6EC5::
    ld a, [$C58F]
    or a, a
    ret nz
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6ECF::
    ld hl, $0302
    ld a, [$D06C]
    or a, a
    jr z, Jump_007_6ED9
    inc l

Jump_007_6ED9::
    call Func_007_512B
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6EE1::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $01
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6EF0::
    ld a, [$C58F]
    cp a, $01
    ret nz
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_6EFB::
    xor a, a
    ld [$C581], a
    ld [$C582], a
    ld [$C57F], a
    ld [$C580], a
    ld [$C58A], a
    ld [$C58F], a
    ld [$C594], a
    ld [$C58B], a
    ld hl, $D09D
    ld bc, $001E
    xor a, a
    call Func_000_0949
    ld hl, $C5DF
    inc [hl]
    ld hl, $C5DB
    ld a, $05
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, $04
    call Func_000_0DF2
    ret

Jump_007_6F34::
    ld a, [$D06B]
    rst $00
    dw Jump_007_6F76
    dw Jump_007_7010
    dw Jump_007_7069
    dw Jump_007_707C
    dw Jump_007_70F3
    dw Jump_007_7103
    dw Jump_007_712D
    dw Jump_007_713C
    dw Jump_007_7153
    dw Jump_007_715E
    dw Jump_007_7168
    dw Jump_007_719B
    dw Jump_007_71D8
    dw Jump_007_7284
    dw Jump_007_732C
    dw Jump_007_7351
    dw Jump_007_7376
    dw Jump_007_739B
    dw Jump_007_73C0
    dw Jump_007_73E5
    dw Jump_007_740A
    dw Jump_007_742F
    dw Jump_007_746C
    dw Jump_007_7498
    dw Jump_007_75D8
    dw Jump_007_7615
    dw Jump_007_762F
    dw Jump_007_7763
    dw Jump_007_77A0
    dw Jump_007_77BA
    dw Jump_007_7845

Jump_007_6F76::
    ld a, [$C58F]
    cp a, $FE
    jr z, Jump_007_6F8B
    cp a, $FD
    jr z, Jump_007_6FA7
    cp a, $FB
    jr z, Jump_007_6FBD
    cp a, $FC
    jr z, Jump_007_6FD7
    jr Jump_007_6FF1

Jump_007_6F8B::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_007_6FF1
    ld a, $01
    ld [$D06B], a
    ld a, $01
    ld [$D06C], a
    ld a, $01
    ld [$C594], a
    ld a, $02
    ld [$D06A], a
    ret

Jump_007_6FA7::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_007_6FF1
    ld a, $08
    ld [$CFC5], a
    ld a, $04
    ld [$D06A], a
    xor a, a
    ld [$C594], a
    ret

Jump_007_6FBD::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_007_6FF1
    call Func_007_6DA9
    ld a, $08
    ld [$CFC5], a
    ld a, $00
    ld [$D059], a
    ld a, $05
    ld [$D06A], a
    ret

Jump_007_6FD7::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_007_6FF1
    call Func_007_6DC2
    ld a, $09
    ld [$CFC5], a
    ld a, $01
    ld [$D059], a
    ld a, $05
    ld [$D06A], a
    ret

Jump_007_6FF1::
    ld d, $C3
    call Func_007_4AE4
    ld hl, $54DB
    call Func_007_4AFE
    call Func_007_7AD4
    call Func_007_4B1E
    ld a, $06
    ld [$C46F], a
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$C594], a
    ret

Jump_007_7010::
    ld hl, $C46C
    ld de, $509E
    call Func_007_4F9D
    ld a, [$C562]
    and a, $02
    jr z, Jump_007_7021
    ret

Jump_007_7021::
    ld a, [$C562]
    and a, $01
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$C46C]
    ld hl, $509E
    and a, $07
    call Func_007_50FE
    ld a, $02
    ld [$C470], a
    ld a, [$C46C]
    and a, $07
    ld hl, $D09D
    add a, l
    ld l, a
    jr nc, Jump_007_7049
    inc h

Jump_007_7049::
    ld a, [hl]
    ld [$C46D], a
    ld a, [$C46C]
    and a, $07
    ld hl, $7063
    add a, l
    ld l, a
    jr nc, Jump_007_705A
    inc h

Jump_007_705A::
    ld a, [hl]
    ld [$D06B], a
    xor a, a
    ld [$D06C], a
    ret
    db $03, $0B, $15, $18, $1B, $1E

Jump_007_7069::
    ld a, $FE
    ld [$C594], a
    ld a, $02
    ld [$D06A], a
    xor a, a
    ld [$D06B], a
    xor a, a
    ld [$D06C], a
    ret

Jump_007_707C::
    ld hl, $C46D
    ld de, $50AA
    call Func_007_4FF5
    ld a, [$C562]
    and a, $02
    jr z, Jump_007_7097
    ld a, [$C46D]
    ld [$D09D], a
    xor a, a
    ld [$D06B], a
    ret

Jump_007_7097::
    ld a, [$C562]
    and a, $01
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$C46D]
    and a, $01
    jr z, Jump_007_70AF
    ld a, $02
    ld [$D06B], a
    ret

Jump_007_70AF::
    ld hl, $D043
    ld a, $01
    ld [hl+], a
    ld a, [$D09E]
    call Func_007_70E9
    inc hl
    inc hl
    inc hl
    ld a, [$D09F]
    call Func_007_70E9
    ld a, [$D0A0]
    call Func_007_70E9
    inc hl
    ld a, [$D0A1]
    call Func_007_70E9
    ld a, [$D0A2]
    call Func_007_70E9
    ld a, $02
    ld [$D059], a
    call Func_007_4E11
    ld a, $01
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Func_007_70E9::
    rrca
    and a, $80
    xor a, $80
    res 7, [hl]
    or a, [hl]
    ld [hl+], a
    ret

Jump_007_70F3::
    ld a, [$C58F]
    cp a, $02
    ret nz
    ld a, $02
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_7103::
    ld a, $0A
    ld [$C592], a
    ld hl, $D043
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $C5B7
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $01
    ld [$C58C], a
    ld a, $FF
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_712D::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_713C::
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_007_4B27
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_7153::
    ld hl, $0306
    call Func_007_512B
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_715E::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_7168::
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_007_7183
    ld a, $02
    ld [$D06A], a
    xor a, a
    ld [$D06B], a
    ld a, $01
    ld [$D06C], a
    ld a, $01
    ld [$C594], a
    ret

Jump_007_7183::
    cp a, $01
    ret nz
    ld a, $01
    ld [$C594], a
    ld a, $05
    ld [$D06A], a
    ld a, $01
    ld [$D06B], a
    ld a, $00
    ld [$D06C], a
    ret

Jump_007_719B::
    ld hl, $C46D
    ld de, $50AE
    call Func_007_4FF5
    ld a, [$C562]
    and a, $02
    jr z, Jump_007_71B6
    ld a, [$C46D]
    ld [$D09E], a
    xor a, a
    ld [$D06B], a
    ret

Jump_007_71B6::
    ld a, [$C562]
    and a, $01
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$C46D]
    ld [$D09E], a
    or a, a
    jr z, Jump_007_71CF
    xor a, a
    ld [$D06B], a
    ret

Jump_007_71CF::
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$D06C], a
    ret

Jump_007_71D8::
    ld hl, $561F
    call Func_007_4AFE
    call Func_007_4B1E
    ld de, $D0A3
    ld hl, $988C
    ld a, [$D044]
    ld c, a
    ld a, [$D045]
    ld b, a
    ld a, $02
    bit 6, c
    jr z, Jump_007_71FA
    ld a, b
    rlca
    rlca
    and a, $01

Jump_007_71FA::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 5, c
    jr z, Jump_007_720B
    ld a, b
    rrca
    swap a
    and a, $01

Jump_007_720B::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 4, c
    jr z, Jump_007_721B
    ld a, b
    swap a
    and a, $01

Jump_007_721B::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 3, c
    jr z, Jump_007_722C
    ld a, b
    rrca
    rrca
    rrca
    and a, $01

Jump_007_722C::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 2, c
    jr z, Jump_007_723C
    ld a, b
    rrca
    rrca
    and a, $01

Jump_007_723C::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 1, c
    jr z, Jump_007_724B
    ld a, b
    rrca
    and a, $01

Jump_007_724B::
    ld [de], a
    inc de
    call Func_007_7270
    ld a, $02
    bit 0, c
    jr z, Jump_007_7259
    ld a, b
    and a, $01

Jump_007_7259::
    ld [de], a
    call Func_007_7270
    xor a, a
    ld [$C46E], a
    ld a, $07
    ld [$C46F], a
    ld a, $03
    ld [$C470], a
    ld hl, $D06B
    inc [hl]
    ret

Func_007_7270::
    push bc
    push hl
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_007_7278
    inc h

Jump_007_7278::
    ld a, $BC
    call Func_000_1211
    pop hl
    ld bc, $0040
    add hl, bc
    pop bc
    ret

Jump_007_7284::
    ld hl, $C46E
    ld de, $50C2
    call Func_007_4F9D
    ld a, [$C562]
    and a, $01
    jr z, Jump_007_72AE
    ld a, $69
    call Func_000_1278
    ld a, [$C46E]
    ld hl, $50C2
    call Func_007_50FE
    ld a, [$C46E]
    and a, $07
    inc a
    ld hl, $D06B
    add a, [hl]
    ld [hl], a
    ret

Jump_007_72AE::
    ld a, [$C562]
    and a, $02
    ret z
    ld bc, $0000
    ld a, [$D0A3]
    cp a, $02
    jr z, Jump_007_72C6
    rrca
    rrca
    and a, $40
    or a, b
    ld b, a
    set 6, c

Jump_007_72C6::
    ld a, [$D0A4]
    cp a, $02
    jr z, Jump_007_72D6
    swap a
    rlca
    and a, $20
    or a, b
    ld b, a
    set 5, c

Jump_007_72D6::
    ld a, [$D0A5]
    cp a, $02
    jr z, Jump_007_72E5
    swap a
    and a, $10
    or a, b
    ld b, a
    set 4, c

Jump_007_72E5::
    ld a, [$D0A6]
    cp a, $02
    jr z, Jump_007_72F5
    swap a
    rrca
    and a, $08
    or a, b
    ld b, a
    set 3, c

Jump_007_72F5::
    ld a, [$D0A7]
    cp a, $02
    jr z, Jump_007_7304
    rlca
    rlca
    and a, $04
    or a, b
    ld b, a
    set 2, c

Jump_007_7304::
    ld a, [$D0A8]
    cp a, $02
    jr z, Jump_007_7312
    rlca
    and a, $02
    or a, b
    ld b, a
    set 1, c

Jump_007_7312::
    ld a, [$D0A9]
    cp a, $02
    jr z, Jump_007_731F
    and a, $01
    or a, b
    ld b, a
    set 0, c

Jump_007_731F::
    ld a, c
    ld [$D044], a
    ld a, b
    ld [$D045], a
    xor a, a
    ld [$D06B], a
    ret

Jump_007_732C::
    ld hl, $D0A3
    ld de, $50D0
    call Func_007_4FF5
    ld a, [$C562]
    and a, $03
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$D0A3]
    and a, $03
    ld hl, $50D0
    call Func_007_50FE
    ld a, $0D
    ld [$D06B], a
    ret

Jump_007_7351::
    ld hl, $D0A4
    ld de, $50D6
    call Func_007_4FF5
    ld a, [$C562]
    and a, $03
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$D0A4]
    and a, $03
    ld hl, $50D6
    call Func_007_50FE
    ld a, $0D
    ld [$D06B], a
    ret

Jump_007_7376::
    ld hl, $D0A5
    ld de, $50DC
    call Func_007_4FF5
    ld a, [$C562]
    and a, $03
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$D0A5]
    and a, $03
    ld hl, $50DC
    call Func_007_50FE
    ld a, $0D
    ld [$D06B], a
    ret

Jump_007_739B::
    ld hl, $D0A6
    ld de, $50E2
    call Func_007_4FF5
    ld a, [$C562]
    and a, $03
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$D0A6]
    and a, $03
    ld hl, $50E2
    call Func_007_50FE
    ld a, $0D
    ld [$D06B], a
    ret

Jump_007_73C0::
    ld hl, $D0A7
    ld de, $50E8
    call Func_007_4FF5
    ld a, [$C562]
    and a, $03
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$D0A7]
    and a, $03
    ld hl, $50E8
    call Func_007_50FE
    ld a, $0D
    ld [$D06B], a
    ret

Jump_007_73E5::
    ld hl, $D0A8
    ld de, $50EE
    call Func_007_4FF5
    ld a, [$C562]
    and a, $03
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$D0A8]
    and a, $03
    ld hl, $50EE
    call Func_007_50FE
    ld a, $0D
    ld [$D06B], a
    ret

Jump_007_740A::
    ld hl, $D0A9
    ld de, $50F4
    call Func_007_4FF5
    ld a, [$C562]
    and a, $03
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$D0A9]
    and a, $03
    ld hl, $50F4
    call Func_007_50FE
    ld a, $0D
    ld [$D06B], a
    ret

Jump_007_742F::
    ld hl, $C46D
    ld de, $50B2
    call Func_007_4FF5
    ld a, [$C562]
    and a, $02
    jr z, Jump_007_744A
    ld a, [$C46D]
    ld [$D09F], a
    xor a, a
    ld [$D06B], a
    ret

Jump_007_744A::
    ld a, [$C562]
    and a, $01
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$C46D]
    ld [$D09F], a
    or a, a
    jr z, Jump_007_7463
    xor a, a
    ld [$D06B], a
    ret

Jump_007_7463::
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$D06C], a
    ret

Jump_007_746C::
    ld hl, $578B
    call Func_007_4AFE
    ld hl, $98E0
    ld de, $C278
    ld bc, $1405
    call Func_007_4B27
    call Func_007_7535
    call Func_007_7594
    ld a, [$D047]
    rlca
    rlca
    and a, $01
    ld [$C46E], a
    ld a, $02
    ld [$C46F], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_7498::
    ld hl, $C46E
    ld de, $50FA
    call Func_007_4F9D
    ld a, [$C563]
    and a, $30
    jr z, Jump_007_7514
    ld a, [$C46E]
    and a, $01
    jr nz, Jump_007_74EF
    ld a, [$D047]
    ld l, a
    ld a, [$D048]
    and a, $C0
    push af
    ld a, [$D048]
    and a, $3F
    ld h, a
    ld a, [$C563]
    and a, $20
    jr z, Jump_007_74D5
    dec hl
    ld a, h
    or a, a
    jr nz, Jump_007_74E1
    ld a, l
    cp a, $03
    jr nc, Jump_007_74E1
    ld hl, $0003
    jr Jump_007_74E1

Jump_007_74D5::
    inc hl
    ld a, l
    sub a, $29
    ld a, h
    sbc a, $01
    jr c, Jump_007_74E1
    ld hl, $0129

Jump_007_74E1::
    pop af
    or a, h
    ld [$D048], a
    ld a, l
    ld [$D047], a
    call Func_007_7535
    jr Jump_007_7514

Jump_007_74EF::
    ld a, [$D046]
    ld l, a
    ld a, [$C563]
    and a, $20
    jr z, Jump_007_7504
    dec hl
    ld a, l
    or a, a
    jr nz, Jump_007_750D
    ld hl, $0001
    jr Jump_007_750D

Jump_007_7504::
    inc l
    ld a, l
    cp a, $64
    jr c, Jump_007_750D
    ld hl, $0063

Jump_007_750D::
    ld a, l
    ld [$D046], a
    call Func_007_7594

Jump_007_7514::
    ld a, [$C562]
    and a, $03
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$C46E]
    rrca
    rrca
    and a, $40
    ld h, a
    ld a, [$D048]
    and a, $BF
    or a, h
    ld [$D048], a
    xor a, a
    ld [$D06B], a
    ret

Func_007_7535::
    ld a, [$D047]
    ld l, a
    ld a, [$D048]
    and a, $3F
    ld h, a
    push hl
    call Func_000_16F5
    pop de
    ld b, $C5
    ld a, e
    sub a, $04
    ld a, d
    sbc a, $00
    jr nc, Jump_007_7550
    ld b, $C3

Jump_007_7550::
    ld hl, $990E
    ld a, b
    call Func_000_121F
    ld c, $01
    ld a, [$C8C0]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7566
    ld c, $00
    ld a, $C3

Jump_007_7566::
    call Func_000_121F
    ld a, [$C8C1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7578
    bit 0, c
    jr nz, Jump_007_7578
    ld a, $C3

Jump_007_7578::
    call Func_000_121F
    ld a, [$C8C2]
    add a, $E0
    call Func_000_121F
    ld b, $C6
    ld a, e
    sub a, $29
    ld a, d
    sbc a, $01
    jr c, Jump_007_758F
    ld b, $C3

Jump_007_758F::
    ld a, b
    call Func_000_1211
    ret

Func_007_7594::
    ld a, [$D046]
    ld l, a
    ld h, $00
    push hl
    call Func_000_16F5
    pop de
    ld b, $C5
    ld a, e
    cp a, $02
    jr nc, Jump_007_75A8
    ld b, $C3

Jump_007_75A8::
    ld hl, $994E
    ld a, b
    call Func_000_121F
    ld a, $C3
    call Func_000_121F
    ld a, [$C8C1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_75BF
    ld a, $C3

Jump_007_75BF::
    call Func_000_121F
    ld a, [$C8C2]
    add a, $E0
    call Func_000_121F
    ld b, $C6
    ld a, e
    cp a, $63
    jr c, Jump_007_75D3
    ld b, $C3

Jump_007_75D3::
    ld a, b
    call Func_000_1211
    ret

Jump_007_75D8::
    ld hl, $C46D
    ld de, $50B6
    call Func_007_4FF5
    ld a, [$C562]
    and a, $02
    jr z, Jump_007_75F3
    ld a, [$C46D]
    ld [$D0A0], a
    xor a, a
    ld [$D06B], a
    ret

Jump_007_75F3::
    ld a, [$C562]
    and a, $01
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$C46D]
    ld [$D0A0], a
    or a, a
    jr z, Jump_007_760C
    xor a, a
    ld [$D06B], a
    ret

Jump_007_760C::
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$D06C], a
    ret

Jump_007_7615::
    ld hl, $57F3
    call Func_007_4AFE
    ld hl, $9862
    ld de, $C1FA
    ld bc, $0F0B
    call Func_007_4B27
    call Func_007_7716
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_762F::
    call Func_007_7690
    ld a, [$C562]
    and a, $02
    jr z, Jump_007_7656
    ld a, [$D049]
    and a, $7F
    cp a, $7F
    jr nz, Jump_007_7651
    ld a, [$D04A]
    and a, $F0
    cp a, $F0
    jr nz, Jump_007_7651
    ld a, $84
    call Func_000_1278
    ret

Jump_007_7651::
    xor a, a
    ld [$D06B], a
    ret

Jump_007_7656::
    ld a, [$C562]
    and a, $01
    ret z
    ld a, $69
    call Func_000_1278
    call Func_007_766B
    ld a, [$C46E]
    call Func_007_7724
    ret

Func_007_766B::
    ld a, [$C46E]
    ld hl, $774D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_007_7677
    inc h

Jump_007_7677::
    ld a, [hl+]
    ld d, [hl]
    ld hl, $D049
    add a, l
    ld l, a
    jr nc, Jump_007_7681
    inc h

Jump_007_7681::
    ld a, d
    cpl
    ld e, a
    ld a, [hl]
    and a, d
    jr z, Jump_007_768C
    ld a, [hl]
    and a, e
    jr Jump_007_768E

Jump_007_768C::
    ld a, [hl]
    or a, d

Jump_007_768E::
    ld [hl], a
    ret

Func_007_7690::
    ld hl, $C46E
    ld de, $7700
    ld a, [$C5F0]
    and a, $07
    jr z, Jump_007_76AC
    ld a, [$C5F0]
    bit 3, a
    jr nz, Jump_007_76A9
    call Func_007_5066
    jr Jump_007_76AC

Jump_007_76A9::
    call Func_007_5046

Jump_007_76AC::
    ld c, [hl]
    ld a, [$C563]
    and a, $C0
    jr z, Jump_007_76C3
    ld a, [hl]
    cp a, $05
    jr c, Jump_007_76BF
    jr z, Jump_007_76F4
    sub a, $06
    jr Jump_007_76F4

Jump_007_76BF::
    add a, $06
    jr Jump_007_76F4

Jump_007_76C3::
    ld a, [$C563]
    and a, $20
    jr z, Jump_007_76DD
    ld a, [hl]
    or a, a
    jr z, Jump_007_76D5
    cp a, $06
    jr z, Jump_007_76D9
    dec a
    jr Jump_007_76F4

Jump_007_76D5::
    ld a, $05
    jr Jump_007_76F4

Jump_007_76D9::
    ld a, $0A
    jr Jump_007_76F4

Jump_007_76DD::
    ld a, [$C563]
    and a, $10
    ret z
    ld a, [hl]
    cp a, $05
    jr z, Jump_007_76EF
    cp a, $0A
    jr z, Jump_007_76F2
    inc a
    jr Jump_007_76F4

Jump_007_76EF::
    xor a, a
    jr Jump_007_76F4

Jump_007_76F2::
    ld a, $06

Jump_007_76F4::
    ld [hl], a
    xor a, a
    ld [$C5F0], a
    call Func_007_5067
    call Func_007_5046
    ret
    db $43, $99, $45, $99, $47, $99, $49, $99, $4B, $99, $4D, $99, $83, $99, $85, $99
    db $87, $99, $89, $99, $8B, $99

Func_007_7716::
    ld bc, $0B00

Jump_007_7719::
    push bc
    ld a, c
    call Func_007_7724
    pop bc
    inc c
    dec b
    jr nz, Jump_007_7719
    ret

Func_007_7724::
    ld c, a
    ld hl, $774D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_007_772E
    inc h

Jump_007_772E::
    ld a, [hl+]
    ld d, [hl]
    ld hl, $D049
    add a, l
    ld l, a
    jr nc, Jump_007_7738
    inc h

Jump_007_7738::
    ld e, [hl]
    ld a, c
    ld hl, $98E4
    add a, l
    ld l, a
    jr nc, Jump_007_7742
    inc h

Jump_007_7742::
    ld a, e
    and a, d
    ld a, $C3
    jr nz, Jump_007_7749
    ld a, c

Jump_007_7749::
    call Func_000_1211
    ret
    db $00, $40, $00, $20, $00, $10, $00, $08, $00, $04, $00, $02, $00, $01, $01, $80
    db $01, $40, $01, $20, $01, $10

Jump_007_7763::
    ld hl, $C46D
    ld de, $50BA
    call Func_007_4FF5
    ld a, [$C562]
    and a, $02
    jr z, Jump_007_777E
    ld a, [$C46D]
    ld [$D0A1], a
    xor a, a
    ld [$D06B], a
    ret

Jump_007_777E::
    ld a, [$C562]
    and a, $01
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$C46D]
    ld [$D0A1], a
    or a, a
    jr z, Jump_007_7797
    xor a, a
    ld [$D06B], a
    ret

Jump_007_7797::
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$D06C], a
    ret

Jump_007_77A0::
    ld hl, $589C
    call Func_007_4AFE
    ld hl, $98E1
    ld de, $C279
    ld bc, $1205
    call Func_007_4B27
    call Func_007_7807
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_77BA::
    ld a, [$C562]
    and a, $03
    jr z, Jump_007_77CB
    ld a, $69
    call Func_000_1278
    xor a, a
    ld [$D06B], a
    ret

Jump_007_77CB::
    ld a, [$C563]
    and a, $20
    jr z, Jump_007_77E8
    ld a, [$D04B]
    and a, $80
    ld d, a
    ld a, [$D04B]
    and a, $7F
    cp a, $0B
    jr c, Jump_007_7806
    dec a
    or a, d
    ld [$D04B], a
    jr Jump_007_7803

Jump_007_77E8::
    ld a, [$C563]
    and a, $10
    jr z, Jump_007_7806
    ld a, [$D04B]
    and a, $80
    ld d, a
    ld a, [$D04B]
    and a, $7F
    cp a, $63
    jr nc, Jump_007_7806
    inc a
    or a, d
    ld [$D04B], a

Jump_007_7803::
    call Func_007_7807

Jump_007_7806::
    ret

Func_007_7807::
    ld a, [$D04B]
    and a, $7F
    push af
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld bc, $C5C6
    pop af
    cp a, $0B
    jr nc, Jump_007_781D
    ld b, $C3

Jump_007_781D::
    cp a, $63
    jr c, Jump_007_7823
    ld c, $C3

Jump_007_7823::
    ld hl, $992E
    ld a, b
    call Func_000_121F
    ld a, [$C8C1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7835
    ld a, $C3

Jump_007_7835::
    call Func_000_121F
    ld a, [$C8C2]
    add a, $E0
    call Func_000_121F
    ld a, c
    call Func_000_1211
    ret

Jump_007_7845::
    ld hl, $C46D
    ld de, $50BE
    call Func_007_4FF5
    ld a, [$C562]
    and a, $03
    ret z
    ld a, $69
    call Func_000_1278
    ld a, [$C46D]
    ld [$D0A2], a
    xor a, a
    ld [$D06B], a
    ret

Jump_007_7864::
    ld a, [$D06B]
    rst $00
    dw Jump_007_7880
    dw Jump_007_78D9
    dw Jump_007_78E8
    dw Jump_007_78F2
    dw Jump_007_791C
    dw Jump_007_792B
    dw Jump_007_795B
    dw Jump_007_796A
    dw Jump_007_7990
    dw Jump_007_79CF
    dw Jump_007_79E4
    dw Jump_007_79E9

Jump_007_7880::
    ld a, [$C58F]
    cp a, $FB
    jr z, Jump_007_7891
    cp a, $FC
    jr z, Jump_007_78A4
    cp a, $FD
    jr z, Jump_007_78B7
    jr Jump_007_78C2

Jump_007_7891::
    call Func_007_6DA9
    ld a, $08
    ld [$CFC5], a
    ld a, $00
    ld [$D059], a
    ld a, $05
    ld [$D06A], a
    ret

Jump_007_78A4::
    call Func_007_6DC2
    ld a, $09
    ld [$CFC5], a
    ld a, $01
    ld [$D059], a
    ld a, $05
    ld [$D06A], a
    ret

Jump_007_78B7::
    ld a, $08
    ld [$CFC5], a
    ld a, $04
    ld [$D06A], a
    ret

Jump_007_78C2::
    ld hl, $52FF
    call Func_007_4AFE
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_007_4B27
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_78D9::
    ld hl, $0304
    call Func_007_512B
    xor a, a
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_78E8::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_78F2::
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_007_790E
    ld a, $02
    ld [$D06A], a
    ld a, $00
    ld [$D06B], a
    ld a, $01
    ld [$D06C], a
    ld a, $01
    ld [$C594], a
    ret

Jump_007_790E::
    cp a, $01
    ret nz
    ld hl, $0305
    call Func_007_512B
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_791C::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $02
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_792B::
    ld a, [$C58F]
    cp a, $02
    ret nz
    ld a, $0A
    ld [$C592], a
    ld hl, $C597
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $D043
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $01
    ld [$C58C], a
    ld a, $FF
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_795B::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_796A::
    ld d, $C3
    call Func_007_4AE4
    ld hl, $54DB
    call Func_007_4AFE
    call Func_007_6DE3
    call Func_007_7AD4
    call Func_007_4B1E
    ld a, $02
    ld [$C470], a
    ld a, $00
    ld [$C46D], a
    ld hl, $D06B
    inc [hl]
    call Func_007_4E11
    ret

Jump_007_7990::
    ld hl, $C46D
    ld de, $50AA
    call Func_007_4FF5
    ld a, [$C562]
    and a, $01
    jr z, Jump_007_79BB
    ld a, $69
    call Func_000_1278
    ld a, [$C46D]
    and a, $01
    jr nz, Jump_007_79C1
    ld a, $02
    ld [$D059], a
    ld a, $01
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_79BB::
    ld a, [$C562]
    and a, $02
    ret z

Jump_007_79C1::
    ld a, $FE
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_79CF::
    ld a, [$C58F]
    cp a, $01
    ret nz
    ld a, $05
    ld [$D06A], a
    ld a, $01
    ld [$D06B], a
    xor a, a
    ld [$D06C], a
    ret

Jump_007_79E4::
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_79E9::
    ld a, $01
    ld [$C594], a
    ld a, $02
    ld [$D06A], a
    xor a, a
    ld [$D06C], a
    xor a, a
    ld [$D06B], a
    ret

Jump_007_79FC::
    ld a, [$D06B]
    and a, a
    jr z, Jump_007_7A05
    jp Jump_007_7AA7

Jump_007_7A05::
    ld a, [$C58F]
    cp a, $FE
    jr z, Jump_007_7A12
    cp a, $FD
    jr z, Jump_007_7A2F
    jr Jump_007_7A45

Jump_007_7A12::
    ld a, [$C57F]
    bit 1, a
    jp z, Jump_007_7A9C
    ld a, $01
    ld [$D06B], a
    ld a, $01
    ld [$D06C], a
    ld a, $01
    ld [$C594], a
    ld a, $02
    ld [$D06A], a
    ret

Jump_007_7A2F::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_007_7A9C
    ld a, $08
    ld [$CFC5], a
    ld a, $04
    ld [$D06A], a
    xor a, a
    ld [$C594], a
    ret

Jump_007_7A45::
    ld a, [$C58F]
    cp a, $FC
    jr z, Jump_007_7A52
    cp a, $FB
    jr z, Jump_007_7A52
    jr Jump_007_7A9C

Jump_007_7A52::
    ld a, [$C46B]
    and a, a
    jr z, Jump_007_7A7A
    ld a, [$C58F]
    cp a, $FC
    jr z, Jump_007_7A9C
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_007_7A9C
    call Func_007_6DA9
    ld a, $08
    ld [$CFC5], a
    ld a, $00
    ld [$D059], a
    ld a, $05
    ld [$D06A], a
    jr Jump_007_7A9C

Jump_007_7A7A::
    ld a, [$C58F]
    cp a, $FB
    jr z, Jump_007_7A9C
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_007_7A9C
    call Func_007_6DC2
    ld a, $09
    ld [$CFC5], a
    ld a, $01
    ld [$D059], a
    ld a, $05
    ld [$D06A], a
    jr Jump_007_7A9C

Jump_007_7A9C::
    ld a, $08
    ld [$D06A], a
    ld a, $00
    ld [$D06B], a
    ret

Jump_007_7AA7::
    ld hl, $C198
    ld bc, $0280
    ld a, $C3
    call Func_000_0949
    call Func_007_4B1E
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58C], a
    ld hl, $D06A
    inc [hl]
    ret

Jump_007_7AC2::
    ld hl, Func_01B_660D
    ld b, $1B
    rst $10
    ld hl, $D06A
    inc [hl]
    ret

Jump_007_7ACD::
    ld hl, Func_01B_665E
    ld b, $1B
    rst $10
    ret

Func_007_7AD4::
    ld a, [$D09D]
    ld hl, $C200
    ld bc, $0006
    call Func_007_7B29
    ld a, [$D09E]
    ld hl, $C266
    ld bc, $0003
    call Func_007_7B29
    ld a, [$D09F]
    ld hl, $C2A6
    ld bc, $0003
    call Func_007_7B29
    ld a, [$D0A0]
    ld hl, $C2E6
    ld bc, $0003
    call Func_007_7B29
    ld a, [$D0A1]
    ld hl, $C326
    ld bc, $0003
    call Func_007_7B29
    ld a, [$D0A2]
    ld hl, $C366
    ld bc, $0003
    call Func_007_7B29
    call Func_007_7B30
    call Func_007_7B9D
    call Func_007_7C07
    call Func_007_7C5F
    ret

Func_007_7B29::
    or a, a
    jr z, Jump_007_7B2D
    add hl, bc

Jump_007_7B2D::
    ld [hl], $BC
    ret

Func_007_7B30::
    ld a, [$D044]
    ld c, a
    ld a, [$D045]
    ld b, a
    ld hl, $C27F
    ld a, $16
    bit 6, c
    jr z, Jump_007_7B48
    ld a, b
    rlca
    rlca
    and a, $01
    add a, $E0

Jump_007_7B48::
    ld [hl+], a
    ld a, $16
    bit 5, c
    jr z, Jump_007_7B57
    ld a, b
    rrca
    swap a
    and a, $01
    add a, $E0

Jump_007_7B57::
    ld [hl+], a
    ld a, $16
    bit 4, c
    jr z, Jump_007_7B65
    ld a, b
    swap a
    and a, $01
    add a, $E0

Jump_007_7B65::
    ld [hl+], a
    ld a, $16
    bit 3, c
    jr z, Jump_007_7B74
    ld a, b
    rlca
    swap a
    and a, $01
    add a, $E0

Jump_007_7B74::
    ld [hl+], a
    ld a, $16
    bit 2, c
    jr z, Jump_007_7B82
    ld a, b
    rrca
    rrca
    and a, $01
    add a, $E0

Jump_007_7B82::
    ld [hl+], a
    ld a, $16
    bit 1, c
    jr z, Jump_007_7B8F
    ld a, b
    rrca
    and a, $01
    add a, $E0

Jump_007_7B8F::
    ld [hl+], a
    ld a, $16
    bit 0, c
    jr z, Jump_007_7B9B
    ld a, b
    and a, $01
    add a, $E0

Jump_007_7B9B::
    ld [hl+], a
    ret

Func_007_7B9D::
    ld de, $7BFD
    ld a, [$D048]
    bit 6, a
    jr z, Jump_007_7BB2
    ld de, $7C02
    ld a, [$D046]
    ld c, a
    ld b, $00
    jr Jump_007_7BBC

Jump_007_7BB2::
    ld a, [$D047]
    ld c, a
    ld a, [$D048]
    and a, $01
    ld b, a

Jump_007_7BBC::
    push bc
    ld hl, $C2BE
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl], a
    inc hl
    inc de
    ld a, [de]
    ld [hl], a
    pop hl
    call Func_000_16F5
    ld c, $01
    ld hl, $C2C4
    ld a, [$C8C0]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7BE5
    ld c, $00
    ld a, $C3

Jump_007_7BE5::
    ld [hl+], a
    ld a, [$C8C1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_007_7BF5
    bit 0, c
    jr nz, Jump_007_7BF5
    ld a, $C3

Jump_007_7BF5::
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ret
    db $15, $12, $15, $0B, $10, $29, $0B, $16, $C3, $C3

Func_007_7C07::
    ld a, [$D049]
    ld e, a
    ld a, [$D04A]
    ld d, a
    ld hl, $C2FB
    xor a, a
    bit 6, e
    jr nz, Jump_007_7C18
    ld [hl], a

Jump_007_7C18::
    inc a
    inc hl
    bit 5, e
    jr nz, Jump_007_7C1F
    ld [hl], a

Jump_007_7C1F::
    inc a
    inc hl
    bit 4, e
    jr nz, Jump_007_7C26
    ld [hl], a

Jump_007_7C26::
    inc a
    inc hl
    bit 3, e
    jr nz, Jump_007_7C2D
    ld [hl], a

Jump_007_7C2D::
    inc a
    inc hl
    bit 2, e
    jr nz, Jump_007_7C34
    ld [hl], a

Jump_007_7C34::
    inc a
    inc hl
    bit 1, e
    jr nz, Jump_007_7C3B
    ld [hl], a

Jump_007_7C3B::
    inc a
    inc hl
    bit 0, e
    jr nz, Jump_007_7C42
    ld [hl], a

Jump_007_7C42::
    inc a
    inc hl
    bit 7, d
    jr nz, Jump_007_7C49
    ld [hl], a

Jump_007_7C49::
    inc a
    inc hl
    bit 6, d
    jr nz, Jump_007_7C50
    ld [hl], a

Jump_007_7C50::
    inc a
    inc hl
    bit 5, d
    jr nz, Jump_007_7C57
    ld [hl], a

Jump_007_7C57::
    inc a
    inc hl
    bit 4, d
    jr nz, Jump_007_7C5E
    ld [hl], a

Jump_007_7C5E::
    ret

Func_007_7C5F::
    ld a, [$D04B]
    ld l, a
    res 7, l
    ld h, $00
    call Func_000_16F5
    ld hl, $C346
    ld a, [$C8C1]
    or a, a
    jr z, Jump_007_7C76
    add a, $E0
    ld [hl], a

Jump_007_7C76::
    inc hl
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ret

Jump_007_7C7E::
    ld a, [$D06B]
    rst $00
    dw Jump_007_7C8C
    dw Jump_007_7CB7
    dw Jump_007_7CF8
    dw Jump_007_7D11
    dw Jump_007_7D24

Jump_007_7C8C::
    ld a, [$C58F]
    cp a, $FE
    jp z, Jump_007_7D24
    ld d, $C3
    call Func_007_4AE4
    ld hl, $54DB
    call Func_007_4AFE
    call Func_007_6DE3
    call Func_007_7AD4
    call Func_007_4B1E
    ld a, $02
    ld [$C470], a
    ld a, $00
    ld [$C46D], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_7CB7::
    ld a, [$C58F]
    cp a, $FE
    jr z, Jump_007_7D24
    ld hl, $C46D
    ld de, $50AA
    call Func_007_4FF5
    ld a, [$C562]
    and a, $01
    jr z, Jump_007_7CE4
    ld a, $69
    call Func_000_1278
    ld a, [$C46D]
    and a, $01
    jr nz, Jump_007_7CEA
    ld a, $01
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_7CE4::
    ld a, [$C562]
    and a, $02
    ret z

Jump_007_7CEA::
    ld a, $FE
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ld hl, $D06B
    inc [hl]
    ret

Jump_007_7CF8::
    ld a, [$C58F]
    cp a, $FE
    jr z, Jump_007_7D24
    cp a, $01
    ret nz
    ld a, $05
    ld [$D06A], a
    ld a, $01
    ld [$D06B], a
    xor a, a
    ld [$D06C], a
    ret

Jump_007_7D11::
    ld a, $01
    ld [$C594], a
    ld a, $02
    ld [$D06A], a
    xor a, a
    ld [$D06B], a
    xor a, a
    ld [$D06C], a
    ret

Jump_007_7D24::
    ld a, $01
    ld [$C594], a
    ld a, $02
    ld [$D06A], a
    xor a, a
    ld [$D06B], a
    ld a, $01
    ld [$D06C], a
    ret

Jump_007_7D38::
    call Func_000_0535
    ld a, [$D06A]
    cp a, $01
    jr z, Jump_007_7D43
    ret

Jump_007_7D43::
    ld a, [$D780]
    cp a, $0C
    jr z, Jump_007_7DAB
    cp a, $0D
    jr z, Jump_007_7DCA
    ld a, [$C94B]
    or a, a
    ret z
    call Func_007_7DE5
    ld a, $01
    ld [$C5DB], a
    ld a, $01
    ld [$C5DF], a
    xor a, a
    ld [$CC44], a
    xor a, a
    ld [$C917], a
    ld a, $21
    ld [$C916], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ld hl, Func_010_4008
    ld b, $10
    rst $10
    ld a, $E0
    ldh [$FF8E], a
    ld a, $00
    ldh [$FF91], a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $14
    ldh [$FF90], a
    xor a, a
    ldh [$FF8C], a
    ld [$C6FD], a
    xor a, a
    ld [$C8C7], a
    ld a, [$C88D]
    ld [$C965], a
    xor a, a
    ld [$C88D], a
    xor a, a
    ld [$C58A], a
    ld [$C94B], a
    ld [$D7FD], a
    ld [$D7F0], a
    ret

Jump_007_7DAB::
    ld a, [$D782]
    and a, a
    ret nz
    ld a, [$D781]
    cp a, $15
    jr z, Jump_007_7DBC
    cp a, $20
    jr z, Jump_007_7DC3
    ret

Jump_007_7DBC::
    ld hl, Func_01D_5C35
    ld b, $1D
    rst $10
    ret

Jump_007_7DC3::
    ld hl, Func_01D_5BF2
    ld b, $1D
    rst $10
    ret

Jump_007_7DCA::
    ld a, [$D781]
    cp a, $15
    jr z, Jump_007_7DD6
    cp a, $20
    jr z, Jump_007_7DDD
    ret

Jump_007_7DD6::
    ld hl, Func_0F1_5719
    ld b, $F1
    rst $10
    ret

Jump_007_7DDD::
    ld hl, Func_0F2_4EDD
    ld b, $F2
    rst $10
    ret
    db $C9

Func_007_7DE5::
    ld a, [$C57F]
    bit 1, a
    jp z, Jump_007_7E6E
    ld a, $02
    ld [$D7F1], a
    ld hl, Func_00E_5688
    ld b, $0E
    rst $10
    ld a, [$D7B5]
    ld [$D7AB], a
    ld a, [$D7B6]
    ld [$D7AF], a
    ld hl, Func_01D_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7F1], a
    ld a, $01
    ld [$D7F2], a
    ld hl, Func_014_7E96
    ld b, $14
    rst $10
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7F6]
    ld l, a
    ld a, [$D7F7]
    ld h, a
    ld de, $CAD0
    ld b, $A5

Jump_007_7E37::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_007_7E37
    xor a, a
    ld [$1FFF], a
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld hl, $CADB
    ld a, [hl+]
    ld [$D7F1], a
    ld a, [hl]
    ld [$D7F2], a
    ld de, $C7FC
    ld a, e
    ld [$D7F3], a
    ld a, d
    ld [$D7F4], a
    ld hl, Func_015_68F3
    ld b, $15
    rst $10
    ld hl, $D7E0
    ld b, $07

Jump_007_7E69::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_007_7E69

Jump_007_7E6E::
    xor a, a
    ld [$D7EB], a
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a

Jump_007_7E79::
    ld hl, Func_002_7333
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    jr z, Jump_007_7E79
    ld hl, $D780
    ld bc, $006F

Jump_007_7E8C::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_007_7E8C
    ret
    ds $16C, $00
