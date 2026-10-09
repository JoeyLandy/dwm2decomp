SECTION "Bank 09", ROMX[$4000], BANK[$09]
    db $09

Func_009_4001::
    ld de, Data_009_4016
    call Func_000_25C9
    ret

Func_009_4008::
    ld de, Data_009_4016
    call Func_000_25FE
    ret

Func_009_400F::
    call Func_009_4001
    call Func_000_2611
    ret

Data_009_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2A, $40, $30, $40, $64, $40, $78, $40, $0A, $41, $0C, $41, $B4, $41, $CE, $41
    db $EC, $41, $EE, $41
    dw Data_009_4232
    dw Data_009_4259
    dw Data_009_4263
    dw Data_009_4294
    dw Data_009_42C8
    dw Data_009_42FB
    dw Data_009_4331
    dw Data_009_437D
    dw Data_009_43B6
    dw Data_009_43C8
    dw Data_009_43DD
    dw Data_009_4408
    dw Data_009_4447
    dw Data_009_449F
    dw Data_009_44B1
    dw Data_009_44C4
    dw Data_009_458A
    dw Data_009_45D4
    dw Data_009_45F9
    dw Data_009_4616
    dw Data_009_4633
    dw Data_009_4675
    dw Data_009_4694
    dw Data_009_472C
    dw Data_009_47D1
    dw Data_009_480D
    dw Data_009_484D
    dw Data_009_486E
    dw Data_009_4893
    dw Data_009_48F0
    dw Data_009_48FC
    dw Data_009_491C
    dw Data_009_492A
    dw Data_009_4936
    dw Data_009_4936
    dw Data_009_4947
    dw Data_009_4960
    dw Data_009_4968
    dw Data_009_4978
    dw Data_009_498A
    dw Data_009_498C
    dw Data_009_4990
    dw Data_009_4996
    dw Data_009_499C
    dw Data_009_49A1
    dw Data_009_49A7
    dw Data_009_49AB
    dw Data_009_49B1
    dw Data_009_49B7
    dw Data_009_49BD
    dw Data_009_49C3
    dw Data_009_49C9
    dw Data_009_49CF
    dw Data_009_49D5
    dw Data_009_49DB
    dw Data_009_49E1
    dw Data_009_49E6
    dw Data_009_49EC
    dw Data_009_49F2
    dw Data_009_49F8
    dw Data_009_49FD
    dw Data_009_4A02
    dw Data_009_4A06
    dw Data_009_4A0C
    dw Data_009_4A12
    dw Data_009_4A18
    dw Data_009_4A1E
    dw Data_009_4A23
    dw Data_009_4A28
    dw Data_009_4A2D
    dw Data_009_4A33
    dw Data_009_4A39
    dw Data_009_4A3D
    dw Data_009_4A42
    dw Data_009_4A47
    dw Data_009_4A4D
    dw Data_009_4A51
    dw Data_009_4A57
    dw Data_009_4A5D
    dw Data_009_4A62
    dw Data_009_4A67
    dw Data_009_4A6D
    dw Data_009_4A73
    dw Data_009_4A79
    dw Data_009_4A7E
    dw Data_009_4A84
    dw Data_009_4A8A
    dw Data_009_4A90
    dw Data_009_4A96
    dw Data_009_4A9C
    dw Data_009_4AA1
    dw Data_009_4AA7
    dw Data_009_4AAB
    dw Data_009_4AAF
    dw Data_009_4AB3
    dw Data_009_4AB8
    dw Data_009_4ABE
    dw Data_009_4AC4
    dw Data_009_4AC9
    dw Data_009_4ACF
    dw Data_009_4AD5
    dw Data_009_4ADB
    dw Data_009_4AE1
    dw Data_009_4AE6
    dw Data_009_4AEB
    dw Data_009_4AF0
    dw Data_009_4AF5
    dw Data_009_4AFA
    dw Data_009_4AFF
    dw Data_009_4B05
    dw Data_009_4B0B
    dw Data_009_4B11
    dw Data_009_4B16
    dw Data_009_4B17
    dw Data_009_4B3B
    dw Data_009_4B5E
    dw Data_009_4B76
    dw Data_009_4B98
    dw Data_009_4BC0
    dw Data_009_4BE2
    dw Data_009_4C29
    dw Data_009_4C76
    dw Data_009_4C8E
    dw Data_009_4CB2
    dw Data_009_4CD8
    dw Data_009_4D3E
    dw Data_009_4D7D
    dw Data_009_4D96
    dw Data_009_4DB8
    dw Data_009_4DC6
    dw Data_009_4E24
    dw Data_009_4E48
    dw Data_009_4E93
    dw Data_009_4EE7
    dw Data_009_4F2F
    dw Data_009_4F53
    dw Data_009_4FD5
    dw Data_009_5019
    dw Data_009_507B
    dw Data_009_50B8
    dw Data_009_50FA
    dw Data_009_510F
    dw Data_009_5170
    dw Data_009_51B9
    dw Data_009_51DB
    dw Data_009_521E
    dw Data_009_522C
    dw Data_009_524C
    dw Data_009_5263
    dw Data_009_527A
    dw Data_009_52E0
    dw Data_009_5325
    dw Data_009_5339
    dw Data_009_533A
    dw Data_009_533D
    dw Data_009_5340
    dw Data_009_5344
    dw Data_009_5348
    dw Data_009_534C
    dw Data_009_5350
    dw Data_009_53C1
    dw Data_009_5431
    dw Data_009_5451
    dw Data_009_5471
    dw Data_009_5490
    dw Data_009_54D2
    dw Data_009_551E
    dw Data_009_553A
    dw Data_009_555C
    dw Data_009_55AC
    dw Data_009_55EE
    dw Data_009_562B
    dw Data_009_564A
    dw Data_009_568D
    dw Data_009_56D6
    dw Data_009_571C
    dw Data_009_575D
    dw Data_009_5780
    dw Data_009_57BF
    dw Data_009_5803
    dw Data_009_5848
    dw Data_009_5866
    dw Data_009_5886
    dw Data_009_58A6
    dw Data_009_58C6
    dw Data_009_58E5
    dw Data_009_591E
    dw Data_009_5967
    dw Data_009_5986
    dw Data_009_59C8
    dw Data_009_5A03
    dw Data_009_5A21
    dw Data_009_5A5D
    dw Data_009_5A9A
    dw Data_009_5AE3
    dw Data_009_5B08
    dw Data_009_5B2E
    dw Data_009_5B6F
    dw Data_009_5B70
    dw Data_009_5B7A
    dw Data_009_5B81
    dw Data_009_5B89
    dw Data_009_5B8E
    dw Data_009_5B93
    dw Data_009_5B9A
    dw Data_009_5B9F
    dw Data_009_5BA7
    dw Data_009_5BB1
    dw Data_009_5BB8
    dw Data_009_5BC0
    dw Data_009_5BC6
    dw Data_009_5BC9
    dw Data_009_5BDD
    dw Data_009_5BF2
    dw Data_009_5C04
    dw Data_009_5C16
    dw Data_009_5C28
    dw Data_009_5C37
    dw Data_009_5C49
    dw Data_009_5C5E
    dw Data_009_5C73
    dw Data_009_5C87
    dw Data_009_5C9C
    dw Data_009_5CAF
    dw Data_009_5CC3
    dw Data_009_5CCF
    dw Data_009_5D06
    dw Data_009_5D44
    dw Data_009_5DA1
    dw Data_009_5E03
    dw Data_009_5E63
    dw Data_009_5EBE
    dw Data_009_5EE3
    dw Data_009_5F08
    dw Data_009_5F2D
    dw Data_009_5F52
    dw Data_009_5F77
    dw Data_009_5F9C
    dw Data_009_5FF5
    dw Data_009_6019
    dw Data_009_603C
    dw Data_009_605E
    dw Data_009_6082
    dw Data_009_60A3
    dw Data_009_610F
    dw Data_009_6130
    dw Data_009_614B
    dw Data_009_6166
    dw Data_009_61A2
    dw Data_009_61E3
    dw Data_009_6207
    dw Data_009_624C
    dw Data_009_626E
    dw Data_009_6290
    dw Data_009_62F5
    dw Data_009_6361
    dw Data_009_63CC
    dw Data_009_643A
    dw Data_009_64A4
    dw Data_009_650C

Data_009_4232:: ; heuristic: target of a monotone pointer table; C0
    db $20, $11, $0A, $1D, $1E, $36, $32, $28, $19, $28, $35, $36, $32, $11, $19, $16
    db $19, $0A, $1D, $14, $0D, $0E, $0F, $0A, $10, $15, $12, $17, $1D, $20, $15, $0D
    db $31, $24, $2F, $2C, $37, $3C, $F0

Data_009_4259:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $18, $20, $11, $18, $11, $19, $16, $19, $F0

Data_009_4263:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $13, $24, $27, $2F, $31, $32, $33, $35, $37, $38, $3B, $3C, $9C, $29, $20
    db $0A, $1D, $1E, $0C, $11, $19, $16, $0D, $26, $2A, $2C, $30, $2B, $3A, $90, $90
    db $90, $90, $0D, $26, $2A, $2C, $30, $2B, $90, $90, $90, $90, $90, $90, $90, $AC
    db $F0

Data_009_4294:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $F2, $0B, $38, $37, $90, $2C, $37, $90, $3A, $24, $36, $90, $28, $30, $33, $37
    db $3C, $B5, $F7, $F0

Data_009_42C8:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $F2, $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $F1, $F9, $4E, $10
    db $B5, $F7, $F0

Data_009_42FB:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $F2, $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28
    db $F1, $F9, $22, $B5, $F7, $F0

Data_009_4331:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024331, $4C

Data_009_437D:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $F2, $1D, $2B, $28, $90, $26, $2B, $28, $36, $37, $90, $3A, $24, $36, $90, $24
    db $F1, $16, $2C, $30, $2C, $26, $99, $F7, $F0

Data_009_43B6:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $F1, $F9, $4E, $10, $B5
    db $F7, $F0

Data_009_43C8:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28, $F1
    db $F9, $22, $B5, $F7, $F0

Data_009_43DD:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $38, $31, $27, $90, $F9, $22, $B5, $F1, $FA, $F7, $F2, $0B, $38, $37
    db $90, $37, $2B, $28, $35, $28, $90, $2C, $36, $90, $31, $32, $F1, $35, $32, $32
    db $30, $90, $29, $32, $35, $90, $2C, $37, $B5, $F7, $F0

Data_009_4408:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $37
    db $35, $28, $24, $36, $38, $35, $28, $90, $26, $2B, $28, $36, $37, $B5, $FA, $F7
    db $F2, $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $24, $F1, $16
    db $24, $2A, $2C, $26, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_009_4447:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024447, $58

Data_009_449F:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $17, $90, $27, $35, $32, $33, $33, $28, $27, $F1, $27, $28, $24, $27, $B5
    db $F7, $F0

Data_009_44B1:: ; heuristic: target of a monotone pointer table; C0
    db $F2, $F9, $17, $90, $27, $35, $32, $33, $33, $28, $27, $F1, $27, $28, $24, $27
    db $B5, $F7, $F0

Data_009_44C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0244C4, $C6

Data_009_458A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02458A, $4A

Data_009_45D4:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $37, $3A, $32, $90, $30, $32, $31, $36, $37, $28, $35, $36
    db $F1, $3A, $28, $31, $37, $90, $24, $3A, $24, $3C, $90, $34, $38, $2C, $28, $37
    db $2F, $3C, $A4, $F7, $F0

Data_009_45F9:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $33, $28, $2F, $2F, $28, $31, $37, $3E, $90, $28, $29, $29, $28, $26
    db $37, $F1, $3A, $32, $35, $28, $90, $32, $29, $29, $B5, $F7, $F0

Data_009_4616:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $28, $33, $10, $38, $24, $35, $27, $3E, $90, $28, $29, $29, $28, $26
    db $37, $F1, $3A, $32, $35, $28, $90, $32, $29, $29, $B5, $F7, $F0

Data_009_4633:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024633, $42

Data_009_4675:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $31, $2A, $28, $1C, $37, $24, $29, $29, $3E, $F1, $28, $29, $29
    db $28, $26, $37, $90, $3A, $32, $35, $28, $90, $32, $29, $29, $B5, $F7, $F0

Data_009_4694:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024694, $98

Data_009_472C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02472C, $A5

Data_009_47D1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $19, $28, $37, $2C, $25, $32, $38, $A3, $90, $0B, $24, $26, $2E, $AB, $F1
    db $F9, $00, $98, $FA, $F7, $EF, $EE, $12, $43, $2F, $90, $36, $2B, $24, $35, $28
    db $90, $36, $32, $30, $28, $90, $32, $29, $EF, $EE, $10, $35, $28, $24, $37, $15
    db $32, $2A, $3E, $90, $33, $32, $3A, $28, $35, $B5, $F7, $F0

Data_009_480D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $19, $28, $37, $2C, $25, $32, $38, $A3, $90, $1D, $2B, $28, $35, $28, $B5
    db $F1, $0A, $2F, $2F, $90, $2B, $28, $24, $2F, $28, $27, $90, $31, $32, $3A, $B5
    db $FA, $F7, $EF, $EE, $22, $32, $38, $90, $25, $28, $90, $26, $24, $35, $28, $29
    db $38, $2F, $90, $32, $38, $37, $EF, $EE, $37, $2B, $28, $35, $28, $99, $F7, $F0

Data_009_484D:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $21, $90, $2B, $24, $37, $26, $2B, $28, $27, $B5, $FA, $F7, $F1, $19, $2F
    db $28, $24, $36, $28, $90, $31, $24, $30, $28, $90, $2C, $37, $B5, $EF, $EE, $F7
    db $F0

Data_009_486E:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $21, $A2, $F9, $4E, $F1, $2B, $24, $37, $26, $2B, $28, $27, $B5, $FA, $F7
    db $EF, $EE, $19, $2F, $28, $24, $36, $28, $90, $31, $24, $30, $28, $90, $2C, $37
    db $B5, $EF, $EE, $F7, $F0

Data_009_4893:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024893, $5D

Data_009_48F0:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $12, $10, $11, $1D, $0E, $16, $19, $15, $0A, $17, $F0

Data_009_48FC:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $35, $2A, $28, $16, $2C, $3B, $28, $27, $0D, $28, $29, $28, $31
    db $36, $28, $90, $90, $90, $90, $90, $90, $0C, $32, $30, $30, $24, $31, $27, $F0

Data_009_491C:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $2A, $2B, $37, $1C, $2E, $2F, $10, $38, $24, $35, $27, $F0

Data_009_492A:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $18, $20, $11, $0A, $2F, $3C, $0E, $31, $28, $30, $F0

Data_009_4936:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $32, $18, $14, $16, $32, $31, $36, $37, $28, $35, $0E, $2A, $2A
    db $F0

Data_009_4947:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $2C, $2F, $2F, $90, $18, $31, $9E, $18, $29, $29, $90, $18, $35, $25
    db $90, $12, $0D, $90, $18, $27, $27, $36, $F0

Data_009_4960:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $90, $1C, $2E, $2C, $2F, $F0

Data_009_4968:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $28, $26, $2C, $24, $2F, $90, $0C, $32, $30, $30, $24, $31, $27, $F0

Data_009_4978:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $37, $35, $24, $3C, $F1, $1D, $3A, $2C, $31, $F1, $10, $38, $24, $35
    db $27, $F0

Data_009_498A:: ; heuristic: target of a monotone pointer table; C0
    db $B8, $F0

Data_009_498C:: ; heuristic: target of a monotone pointer table; C0
    db $22, $2F, $3A, $F0

Data_009_4990:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $24, $2C, $31, $F0

Data_009_4996:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $28, $31, $F0

Data_009_499C:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $38, $28, $F0

Data_009_49A1:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $36, $37, $F0

Data_009_49A7:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $27, $F0

Data_009_49AB:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $2C, $37, $28, $F0

Data_009_49B1:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $38, $2C, $28, $37, $F0

Data_009_49B7:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $24, $26, $2E, $F0

Data_009_49BD:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $38, $27, $3C, $F0

Data_009_49C3:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $2F, $39, $35, $F0

Data_009_49C9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $28, $24, $30, $F0

Data_009_49CF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $36, $37, $3C, $F0

Data_009_49D5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $26, $35, $37, $F0

Data_009_49DB:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $2C, $31, $3C, $F0

Data_009_49E1:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $36, $37, $F0

Data_009_49E6:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_009_49EC:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $F0

Data_009_49F2:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $F0

Data_009_49F8:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $35, $27, $F0

Data_009_49FD:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $28, $28, $F0

Data_009_4A02:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $2A, $F0

Data_009_4A06:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $39, $2C, $2F, $F0

Data_009_4A0C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $37, $2B, $F0

Data_009_4A12:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $2C, $31, $2A, $F0

Data_009_4A18:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $28, $35, $F0

Data_009_4A1E:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $35, $27, $F0

Data_009_4A23:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $39, $28, $F0

Data_009_4A28:: ; heuristic: target of a monotone pointer table; C0
    db $12, $36, $2F, $28, $F0

Data_009_4A2D:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $35, $26, $2B, $F0

Data_009_4A33:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $35, $27, $31, $F0

Data_009_4A39:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $37, $F0

Data_009_4A3D:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $36, $30, $37, $F0

Data_009_4A42:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $2C, $2F, $F0

Data_009_4A47:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $30, $24, $F0

Data_009_4A4D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $24, $F0

Data_009_4A51:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $28, $2F, $27, $F0

Data_009_4A57:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $3A, $28, $35, $F0

Data_009_4A5D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $31, $28, $F0

Data_009_4A62:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $2F, $2F, $F0

Data_009_4A67:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $36, $37, $2F, $28, $F0

Data_009_4A6D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $38, $31, $27, $F0

Data_009_4A73:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $36, $35, $37, $F0

Data_009_4A79:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $2E, $28, $F0

Data_009_4A7E:: ; heuristic: target of a monotone pointer table; C0
    db $13, $38, $31, $2A, $2F, $F0

Data_009_4A84:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $39, $28, $31, $F0

Data_009_4A8A:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $24, $36, $36, $F0

Data_009_4A90:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $35, $36, $37, $F0

Data_009_4A96:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $24, $39, $28, $F0

Data_009_4A9C:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $24, $2A, $F0

Data_009_4AA1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $32, $35, $28, $F0

Data_009_4AA7:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $2A, $F0

Data_009_4AAB:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $F0

Data_009_4AAF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $37, $31, $F0

Data_009_4AB3:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $2C, $28, $3A, $F0

Data_009_4AB8:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $2C, $29, $29, $F0

Data_009_4ABE:: ; heuristic: target of a monotone pointer table; C0
    db $12, $36, $2F, $28, $37, $F0

Data_009_4AC4:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $31, $27, $F0

Data_009_4AC9:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $32, $39, $28, $F0

Data_009_4ACF:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $24, $30, $33, $F0

Data_009_4AD5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $31, $32, $35, $F0

Data_009_4ADB:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $33, $37, $2B, $F0

Data_009_4AE1:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $2F, $28, $F0

Data_009_4AE6:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $30, $25, $F0

Data_009_4AEB:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $2C, $2F, $F0

Data_009_4AF0:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $31, $27, $F0

Data_009_4AF5:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $2F, $2F, $F0

Data_009_4AFA:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $32, $31, $F0

Data_009_4AFF:: ; heuristic: target of a monotone pointer table; C0
    db $18, $26, $28, $24, $31, $F0

Data_009_4B05:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $2F, $26, $2B, $F0

Data_009_4B0B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $39, $28, $35, $F0

Data_009_4B11:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $35, $F0

Data_009_4B16:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_009_4B17:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2F, $2F, $32, $3A, $90, $30, $28, $90, $37, $32, $90, $2B
    db $28, $24, $2F, $F1, $3C, $32, $38, $35, $90, $2C, $31, $2D, $38, $35, $2C, $28
    db $36, $B5, $F7, $F0

Data_009_4B3B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $3A, $2C, $2F, $2F, $90, $33, $35, $24, $3C, $90, $29
    db $32, $35, $F1, $3C, $32, $38, $B5, $90, $0F, $24, $35, $28, $3A, $28, $2F, $2F
    db $B5, $F7, $F0

Data_009_4B5E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $22, $99, $90, $18, $31, $2F, $3C, $F1, $F9, $4E, $10, $99
    db $90, $20, $28, $2F, $2F, $98, $FF, $F0

Data_009_4B76:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $31, $2E, $36, $99, $90, $11, $32, $33, $28, $90
    db $12, $F1, $36, $28, $28, $90, $3C, $32, $38, $90, $24, $2A, $24, $2C, $31, $99
    db $F7, $F0

Data_009_4B98:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $24, $2B, $98, $90, $17, $32, $37, $90, $25, $38, $3C, $2C
    db $31, $2A, $98, $F1, $0B, $24, $2B, $AB, $90, $24, $31, $32, $37, $2B, $28, $35
    db $90, $37, $2C, $30, $28, $B5, $F7, $F0

Data_009_4BC0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $43, $2F, $90, $2B, $28, $24, $2F, $90, $3C, $32, $38, $F1
    db $29, $32, $35, $90, $01, $00, $00, $00, $10, $B5, $90, $20, $28, $2F, $2F, $98
    db $FF, $F0

Data_009_4BE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024BE2, $47

Data_009_4C29:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024C29, $4D

Data_009_4C76:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $22, $99, $90, $13, $38, $36, $37, $F1, $F9, $4E, $10, $99
    db $90, $20, $28, $2F, $2F, $98, $FF, $F0

Data_009_4C8E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2B, $28, $2B, $28, $2B, $AB, $90, $37, $2B, $24, $31
    db $2E, $36, $99, $F1, $1C, $28, $28, $90, $3C, $32, $38, $90, $24, $2A, $24, $2C
    db $31, $99, $F7, $F0

Data_009_4CB2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $26, $2B, $AB, $90, $37, $2C, $2A, $2B, $37, $3A, $24, $27
    db $A4, $F1, $22, $32, $38, $43, $2F, $90, $35, $28, $2A, $35, $28, $37, $90, $37
    db $2B, $2C, $36, $B5, $F7, $F0

Data_009_4CD8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024CD8, $66

Data_009_4D3E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1E, $35, $2A, $2B, $B5, $90, $1D, $32, $38, $2A, $2B, $28, $35
    db $F1, $37, $2B, $24, $31, $90, $30, $28, $A4, $FA, $F7, $EF, $EE, $12, $44, $90
    db $25, $28, $37, $37, $28, $35, $90, $35, $28, $27, $32, $38, $25, $2F, $28, $EF
    db $EE, $30, $3C, $90, $37, $35, $24, $2C, $31, $2C, $31, $2A, $B5, $F7, $F0

Data_009_4D7D:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $24, $F1, $20, $24
    db $35, $33, $20, $2C, $31, $2A, $B5, $F7, $F0

Data_009_4D96:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $24, $2B, $24, $2B, $24, $2B, $99, $90, $12, $F1, $32, $39
    db $28, $35, $28, $36, $37, $2C, $30, $24, $37, $28, $27, $90, $3C, $32, $38, $99
    db $F7, $F0

Data_009_4DB8:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2F, $32, $36, $37, $F1, $F9, $4E, $10, $B5, $F7, $F0

Data_009_4DC6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024DC6, $5E

Data_009_4E24:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1E, $2B, $9C, $32, $2B, $AB, $90, $12, $90, $2F, $32, $36, $37
    db $99, $F1, $12, $90, $26, $24, $31, $90, $27, $32, $90, $25, $28, $37, $37, $28
    db $35, $99, $F7, $F0

Data_009_4E48:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024E48, $4B

Data_009_4E93:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024E93, $54

Data_009_4EE7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024EE7, $48

Data_009_4F2F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $43, $2F, $90, $2B, $24, $39, $28, $90, $31, $2C, $26, $28
    db $F1, $33, $35, $2C, $3D, $28, $36, $90, $31, $28, $3B, $37, $90, $37, $2C, $30
    db $28, $B5, $F7, $F0

Data_009_4F53:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024F53, $82

Data_009_4FD5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $024FD5, $44

Data_009_5019:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025019, $62

Data_009_507B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0D, $32, $90, $3C, $32, $38, $90, $37, $2B, $2C, $31, $2E, $90
    db $37, $2B, $28, $F1, $31, $28, $3B, $37, $90, $26, $24, $35, $27, $90, $12, $90
    db $33, $2C, $26, $2E, $FA, $F7, $EF, $EE, $3A, $2C, $2F, $2F, $90, $25, $28, $90
    db $24, $25, $32, $39, $28, $90, $F9, $4E, $98, $EF, $EE, $FF, $F0

Data_009_50B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0250B8, $42

Data_009_50FA:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $F1, $37, $2B, $28, $90
    db $F9, $22, $B5, $F7, $F0

Data_009_510F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02510F, $61

Data_009_5170:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025170, $49

Data_009_51B9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1F, $28, $35, $3C, $90, $2A, $32, $32, $27, $B5, $90, $11, $28
    db $35, $28, $3E, $F1, $3C, $32, $38, $35, $90, $35, $28, $3A, $24, $35, $27, $B5
    db $F7, $F0

Data_009_51DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0251DB, $43

Data_009_521E:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2F, $32, $36, $37, $F1, $F9, $4E, $10, $B5, $F7, $F0

Data_009_522C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0D, $32, $90, $3C, $32, $38, $90, $3A, $24, $31, $37, $90, $24, $90, $30
    db $24, $33, $98, $F1, $13, $38, $36, $37, $90, $02, $00, $00, $10, $B5, $FF, $F0

Data_009_524C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $17, $32, $98, $F1, $1D, $2B, $24, $37, $3E, $90, $37, $32, $32
    db $90, $25, $24, $27, $B5, $F7, $F0

Data_009_5263:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $F9, $00, $90, $2B, $24, $31, $27, $28, $27, $90, $32, $39, $28, $35, $F1
    db $02, $00, $00, $10, $B5, $F7, $F0

Data_009_527A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02527A, $66

Data_009_52E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0252E0, $45

Data_009_5325:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $17, $3E, $90, $F9, $22, $F1, $35, $32, $36, $28, $90, $25, $3C, $90, $F9
    db $4E, $B5, $F7, $F0

Data_009_5339:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_009_533A:: ; heuristic: target of a monotone pointer table; C0
    db $11, $19, $F0

Data_009_533D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $19, $F0

Data_009_5340:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $1D, $14, $F0

Data_009_5344:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $0E, $0F, $F0

Data_009_5348:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $10, $15, $F0

Data_009_534C:: ; heuristic: target of a monotone pointer table; C0
    db $12, $17, $1D, $F0

Data_009_5350:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025350, $71

Data_009_53C1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0253C1, $70

Data_009_5431:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $38, $26, $2E, $3C, $99, $90, $22, $32, $38, $90, $3A, $2C
    db $31, $90, $24, $F1, $1D, $2C, $31, $3C, $16, $28, $27, $24, $2F, $99, $F7, $F0

Data_009_5451:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $35, $28, $90, $2C, $37, $90, $2C, $36, $99, $F1
    db $22, $32, $38, $90, $3A, $2C, $31, $90, $01, $00, $00, $00, $10, $99, $F7, $F0

Data_009_5471:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $32, $24, $99, $90, $22, $32, $38, $42, $28, $90, $3A
    db $32, $31, $F1, $24, $90, $16, $28, $37, $28, $18, $35, $25, $99, $F7, $F0

Data_009_5490:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025490, $42

Data_009_54D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0254D2, $4C

Data_009_551E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $32, $32, $90, $25, $24, $27, $A4, $F1, $1D, $35, $3C, $90
    db $24, $2A, $24, $2C, $31, $AB, $90, $18, $14, $98, $F7, $F0

Data_009_553A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $37, $3E, $90, $37, $32, $32, $90, $25, $24, $27
    db $B5, $F1, $1C, $28, $28, $90, $3C, $32, $38, $90, $24, $2A, $24, $2C, $31, $B5
    db $F7, $F0

Data_009_555C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02555C, $50

Data_009_55AC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0255AC, $42

Data_009_55EE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $35, $90, $2F, $24, $26, $2E, $90, $32, $29, $F1
    db $37, $35, $24, $2C, $31, $2C, $31, $2A, $90, $2C, $36, $90, $26, $2F, $28, $24
    db $35, $B5, $FA, $F7, $EF, $EE, $0B, $28, $36, $37, $90, $32, $29, $90, $2F, $38
    db $26, $2E, $90, $37, $32, $EF, $EE, $3C, $32, $38, $A4, $F7, $F0

Data_009_562B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $28, $37, $90, $30, $28, $90, $2F, $2C, $2A, $2B, $37, $28
    db $31, $F1, $3C, $32, $38, $35, $90, $33, $38, $35, $36, $28, $B5, $F7, $F0

Data_009_564A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02564A, $43

Data_009_568D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02568D, $49

Data_009_56D6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0256D6, $46

Data_009_571C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02571C, $41

Data_009_575D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $43, $2F, $90, $38, $31, $25, $38, $35, $27, $28, $31, $F1
    db $3C, $32, $38, $90, $32, $29, $90, $3C, $32, $38, $35, $90, $2A, $32, $2F, $27
    db $B5, $F7, $F0

Data_009_5780:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $3F, $90, $31, $32, $37, $90, $27, $2C, $35, $37, $3C, $9C
    db $F1, $31, $32, $37, $90, $24, $37, $90, $24, $2F, $2F, $B5, $FA, $F7, $EF, $EE
    db $22, $32, $38, $90, $36, $2B, $32, $38, $2F, $27, $31, $41, $90, $25, $28, $EF
    db $EE, $36, $32, $90, $26, $24, $35, $28, $2F, $28, $36, $36, $B5, $F7, $F0

Data_009_57BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0257BF, $44

Data_009_5803:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025803, $45

Data_009_5848:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $24, $F1, $16, $24
    db $2A, $2C, $26, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_009_5866:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $38, $26, $2E, $3C, $AB, $90, $2E, $2C, $27, $99, $F1, $22
    db $32, $38, $42, $28, $90, $3A, $32, $31, $90, $05, $00, $00, $10, $99, $F7, $F0

Data_009_5886:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $38, $26, $2E, $3C, $AB, $90, $2E, $2C, $27, $99, $F1, $22
    db $32, $38, $42, $28, $90, $3A, $32, $31, $90, $02, $00, $00, $10, $99, $F7, $F0

Data_009_58A6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $38, $26, $2E, $3C, $AB, $90, $2E, $2C, $27, $99, $F1, $22
    db $32, $38, $42, $28, $90, $3A, $32, $31, $90, $01, $00, $00, $10, $99, $F7, $F0

Data_009_58C6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $38, $26, $2E, $3C, $AB, $90, $2E, $2C, $27, $99, $F1, $22
    db $32, $38, $42, $28, $90, $3A, $32, $31, $90, $05, $00, $10, $99, $F7, $F0

Data_009_58E5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $42, $28, $90, $31, $32, $90, $26, $32, $38, $35
    db $24, $2A, $28, $F1, $37, $32, $90, $25, $24, $37, $37, $2F, $28, $98, $FA, $F7
    db $EF, $EE, $1C, $2B, $24, $30, $28, $AB, $90, $2C, $37, $90, $35, $28, $24, $2F
    db $2F, $3C, $EF, $EE, $2C, $36, $B5, $F7, $F0

Data_009_591E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02591E, $49

Data_009_5967:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $17, $32, $98, $90, $22, $32, $38, $40, $28, $90, $35, $24, $37
    db $2B, $28, $35, $F1, $26, $32, $3A, $24, $35, $27, $2F, $3C, $B5, $F7, $F0

Data_009_5986:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025986, $42

Data_009_59C8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $98, $F1, $15, $2C, $37, $37, $2F, $28, $90
    db $26, $2B, $2C, $26, $2E, $28, $31, $99, $FA, $F7, $EF, $EE, $10, $32, $90, $2B
    db $32, $30, $28, $90, $37, $32, $90, $3C, $32, $38, $35, $EF, $EE, $30, $32, $30
    db $30, $3C, $AB, $90, $25, $24, $25, $3C, $99, $F7, $F0

Data_009_5A03:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $32, $32, $27, $90, $24, $31, $36, $3A, $28, $35, $99, $F1
    db $15, $28, $37, $3E, $90, $25, $24, $37, $37, $2F, $28, $99, $F7, $F0

Data_009_5A21:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $AB, $90, $3C, $32, $38, $90, $33, $32, $32, $35, $F1
    db $30, $32, $31, $36, $37, $28, $35, $36, $B5, $FA, $F7, $EF, $EE, $22, $32, $38
    db $90, $2B, $24, $39, $28, $90, $36, $38, $26, $2B, $90, $24, $EF, $EE, $33, $32
    db $32, $35, $90, $30, $24, $36, $37, $28, $35, $A4, $F7, $F0

Data_009_5A5D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $AB, $90, $3C, $32, $38, $40, $28, $90, $35, $28, $24
    db $27, $3C, $AB, $F1, $24, $35, $28, $90, $3C, $32, $38, $98, $FA, $F7, $EF, $EE
    db $0B, $38, $37, $90, $12, $90, $27, $32, $31, $41, $90, $33, $2F, $24, $31, $EF
    db $EE, $32, $31, $90, $2F, $32, $36, $2C, $31, $2A, $99, $F7, $F0

Data_009_5A9A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025A9A, $49

Data_009_5AE3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $3C, $90, $28, $3C, $28, $36, $90, $27, $2C, $27, $31, $41
    db $F1, $30, $2C, $36, $2F, $28, $24, $27, $90, $30, $28, $B5, $90, $1B, $28, $24
    db $27, $3C, $98, $F7, $F0

Data_009_5B08:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $17, $32, $3A, $90, $3C, $32, $38, $90, $26, $24, $31, $90, $36
    db $28, $28, $F1, $37, $2B, $28, $90, $28, $31, $37, $2C, $35, $28, $90, $3A, $32
    db $35, $2F, $27, $99, $F7, $F0

Data_009_5B2E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025B2E, $41

Data_009_5B6F:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_009_5B70:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $24, $37, $15, $32, $2A, $5B, $F0

Data_009_5B7A:: ; heuristic: target of a monotone pointer table; C0
    db $18, $24, $36, $2C, $36, $5B, $F0

Data_009_5B81:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $35, $24, $37, $28, $5B, $F0

Data_009_5B89:: ; heuristic: target of a monotone pointer table; C0
    db $12, $26, $28, $5B, $F0

Data_009_5B8E:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $5B, $F0

Data_009_5B93:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $30, $25, $32, $5B, $F0

Data_009_5B9A:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2F, $29, $5B, $F0

Data_009_5B9F:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $31, $28, $2F, $3C, $5B, $F0

Data_009_5BA7:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $24, $39, $28, $2F, $28, $35, $5B, $F0

Data_009_5BB1:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $24, $3A, $31, $5B, $F0

Data_009_5BB8:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $29, $29, $2F, $28, $5B, $F0

Data_009_5BC0:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $38, $2F, $5B, $F0

Data_009_5BC6:: ; heuristic: target of a monotone pointer table; C0
    db $F1, $F1, $F0

Data_009_5BC9:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $35, $28, $37, $38, $35, $31, $F1, $2B, $32
    db $30, $28, $B5, $F0

Data_009_5BDD:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $0D, $28, $36, $28, $35, $37, $F1, $20, $32
    db $35, $2F, $27, $B5, $F0

Data_009_5BF2:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $1C, $28, $24, $F1, $20, $32, $35, $2F, $27
    db $B5, $F0

Data_009_5C04:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $12, $26, $28, $F1, $20, $32, $35, $2F, $27
    db $B5, $F0

Data_009_5C16:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $1C, $2E, $3C, $F1, $20, $32, $35, $2F, $27
    db $B5, $F0

Data_009_5C28:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $15, $2C, $30, $25, $32, $B5, $F1, $F0

Data_009_5C37:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $0E, $2F, $29, $F1, $20, $32, $35, $2F, $27
    db $B5, $F0

Data_009_5C49:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $15, $32, $31, $28, $2F, $3C, $F1, $20, $32
    db $35, $2F, $27, $B5, $F0

Data_009_5C5E:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $1D, $35, $24, $39, $28, $2F, $F1, $20, $32
    db $35, $2F, $27, $B5, $F0

Data_009_5C73:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $19, $32, $3A, $28, $35, $F1, $20, $32, $35
    db $2F, $27, $B5, $F0

Data_009_5C87:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $0B, $24, $29, $29, $2F, $28, $F1, $20, $32
    db $35, $2F, $27, $B5, $F0

Data_009_5C9C:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $1C, $32, $38, $2F, $F1, $20, $32, $35, $2F
    db $27, $B5, $F0

Data_009_5CAF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $F1, $14, $28, $3C, $90, $37, $32, $F1, $3A, $2B, $28
    db $35, $28, $98, $F0

Data_009_5CC3:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $90, $37, $32, $F1, $F9, $00, $B5, $F1, $F0

Data_009_5CCF:: ; heuristic: target of a monotone pointer table; C0
    db $17, $28, $3A, $90, $2A, $24, $30, $28, $0C, $32, $31, $37, $2C, $31, $38, $28
    db $1F, $1C, $90, $25, $24, $37, $37, $2F, $28, $0B, $35, $28, $28, $27, $1D, $35
    db $24, $27, $28, $90, $B8, $13, $32, $38, $35, $31, $24, $2F, $90, $27, $24, $37
    db $24, $2F, $32, $36, $37, $A4, $F0

Data_009_5D06:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $90, $37, $32, $90, $37, $2B
    db $28, $F1, $0A, $35, $28, $31, $24, $99, $FA, $F7, $EF, $EE, $20, $28, $90, $2B
    db $24, $39, $28, $90, $24, $90, $36, $33, $28, $26, $2C, $24, $2F, $EF, $EE, $37
    db $28, $24, $30, $90, $3A, $2C, $37, $2B, $90, $38, $36, $99, $F7, $F0

Data_009_5D44:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025D44, $5D

Data_009_5DA1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025DA1, $62

Data_009_5E03:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025E03, $60

Data_009_5E63:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025E63, $5B

Data_009_5EBE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0E, $90, $0C, $2F, $24, $36, $36, $90, $25, $24, $37, $37, $2F
    db $28, $36, $F1, $24, $35, $28, $90, $35, $28, $24, $27, $3C, $90, $37, $32, $90
    db $2A, $32, $99, $F7, $F0

Data_009_5EE3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0D, $90, $0C, $2F, $24, $36, $36, $90, $25, $24, $37, $37, $2F
    db $28, $36, $F1, $24, $35, $28, $90, $35, $28, $24, $27, $3C, $90, $37, $32, $90
    db $2A, $32, $99, $F7, $F0

Data_009_5F08:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0C, $90, $0C, $2F, $24, $36, $36, $90, $25, $24, $37, $37, $2F
    db $28, $36, $F1, $24, $35, $28, $90, $35, $28, $24, $27, $3C, $90, $37, $32, $90
    db $2A, $32, $99, $F7, $F0

Data_009_5F2D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0B, $90, $0C, $2F, $24, $36, $36, $90, $25, $24, $37, $37, $2F
    db $28, $36, $F1, $24, $35, $28, $90, $35, $28, $24, $27, $3C, $90, $37, $32, $90
    db $2A, $32, $99, $F7, $F0

Data_009_5F52:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $90, $0C, $2F, $24, $36, $36, $90, $25, $24, $37, $37, $2F
    db $28, $36, $F1, $24, $35, $28, $90, $35, $28, $24, $27, $3C, $90, $37, $32, $90
    db $2A, $32, $99, $F7, $F0

Data_009_5F77:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $90, $0C, $2F, $24, $36, $36, $90, $25, $24, $37, $37, $2F
    db $28, $36, $F1, $24, $35, $28, $90, $35, $28, $24, $27, $3C, $90, $37, $32, $90
    db $2A, $32, $99, $F7, $F0

Data_009_5F9C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $025F9C, $59

Data_009_5FF5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $24, $36, $37, $28, $35, $90, $F9, $00, $90, $24, $31, $27
    db $F1, $37, $2B, $28, $90, $29, $24, $35, $30, $90, $29, $35, $2C, $28, $31, $27
    db $36, $99, $F7, $F0

Data_009_6019:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $24, $36, $37, $28, $35, $90, $F9, $00, $90, $24, $31, $27
    db $F1, $37, $2B, $28, $90, $29, $38, $31, $90, $29, $35, $2C, $28, $31, $27, $36
    db $99, $F7, $F0

Data_009_603C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $24, $36, $37, $28, $35, $90, $F9, $00, $90, $24, $31, $27
    db $F1, $37, $35, $38, $36, $37, $3C, $90, $29, $35, $2C, $28, $31, $27, $36, $99
    db $F7, $F0

Data_009_605E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $24, $36, $37, $28, $35, $90, $F9, $00, $90, $24, $31, $27
    db $F1, $33, $32, $3A, $28, $35, $29, $38, $2F, $90, $29, $35, $2C, $28, $31, $27
    db $36, $99, $F7, $F0

Data_009_6082:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $24, $36, $37, $28, $35, $90, $F9, $00, $90, $24, $31, $27
    db $F1, $25, $35, $24, $39, $28, $90, $29, $35, $2C, $28, $31, $27, $36, $99, $F7
    db $F0

Data_009_60A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0260A3, $6C

Data_009_610F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $98, $98, $98, $98, $98, $98, $98, $98, $98, $90, $24, $31, $27
    db $F1, $98, $98, $98, $98, $98, $90, $29, $35, $2C, $28, $31, $27, $36, $99, $F7
    db $F0

Data_009_6130:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0B, $24, $37, $37, $2F, $28, $90, $32, $31, $28, $99, $F1, $1B
    db $28, $24, $27, $3C, $98, $90, $10, $32, $99, $F7, $F0

Data_009_614B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0B, $24, $37, $37, $2F, $28, $90, $37, $3A, $32, $99, $F1, $1B
    db $28, $24, $27, $3C, $98, $90, $10, $32, $99, $F7, $F0

Data_009_6166:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $27, $28, $26, $2C, $27, $28, $36, $90
    db $37, $2B, $28, $F1, $26, $2B, $24, $30, $33, $2C, $32, $31, $99, $FA, $F7, $EF
    db $EE, $0F, $2C, $31, $24, $2F, $90, $25, $24, $37, $37, $2F, $28, $99, $EF, $EE
    db $1B, $28, $24, $27, $3C, $98, $90, $10, $32, $99, $F7, $F0

Data_009_61A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0261A2, $41

Data_009_61E3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $26, $2B, $24, $2F, $2F, $28, $31, $2A, $28
    db $35, $F1, $3A, $2C, $31, $36, $90, $25, $24, $37, $37, $2F, $28, $90, $32, $31
    db $28, $99, $F7, $F0

Data_009_6207:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $026207, $45

Data_009_624C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $24, $36, $37, $28, $35, $90, $F9, $00, $90, $2B, $24, $36
    db $F1, $3A, $32, $31, $90, $25, $24, $37, $37, $2F, $28, $90, $32, $31, $28, $99
    db $F7, $F0

Data_009_626E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $24, $36, $37, $28, $35, $90, $F9, $00, $90, $2B, $24, $36
    db $F1, $3A, $32, $31, $90, $25, $24, $37, $37, $2F, $28, $90, $37, $3A, $32, $99
    db $F7, $F0

Data_009_6290:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $026290, $65

Data_009_62F5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0262F5, $6C

Data_009_6361:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $026361, $6B

Data_009_63CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0263CC, $6E

Data_009_643A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02643A, $6A

Data_009_64A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0264A4, $68

Data_009_650C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02650C, $6E
    ds $1A86, $00
