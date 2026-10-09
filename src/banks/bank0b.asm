SECTION "Bank 0B", ROMX[$4000], BANK[$0B]
    db $0B

Func_00B_4001::
    ld de, Data_00B_4016
    call Func_000_25C9
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

Func_00B_400F::
    call Func_00B_4001
    call Func_000_2611
    ret

Data_00B_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00B_401C
    dw Data_00B_421C
    dw Data_00B_4326

Data_00B_401C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_00B_433C
    dw Data_00B_4340
    dw Data_00B_437A
    dw Data_00B_43BD
    dw Data_00B_43DE
    dw Data_00B_43FE
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4422
    dw Data_00B_4442
    dw Data_00B_4467
    dw Data_00B_4489
    dw Data_00B_44AD
    dw Data_00B_44CD
    dw Data_00B_44EB
    dw Data_00B_4509
    dw Data_00B_452A
    dw Data_00B_4550
    dw Data_00B_456F
    dw Data_00B_4590
    dw Data_00B_45B2
    dw Data_00B_45D1
    dw Data_00B_45F4
    dw Data_00B_4617
    dw Data_00B_4636
    dw Data_00B_4657
    dw Data_00B_467C
    dw Data_00B_469A
    dw Data_00B_46BC
    dw Data_00B_46DF
    dw Data_00B_4701
    dw Data_00B_471D
    dw Data_00B_473D
    dw Data_00B_4759
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_4779
    dw Data_00B_479D
    dw Data_00B_47BA
    dw Data_00B_47DC
    dw Data_00B_47FE
    dw Data_00B_481E
    dw Data_00B_483E
    dw Data_00B_485F
    dw Data_00B_487E
    dw Data_00B_48A3
    dw Data_00B_48C5
    dw Data_00B_48E9
    dw Data_00B_490A
    dw Data_00B_492A
    dw Data_00B_494E
    dw Data_00B_496B
    dw Data_00B_4990
    dw Data_00B_49B2
    dw Data_00B_49D2
    dw Data_00B_49F0
    dw Data_00B_4A13
    dw Data_00B_4A32
    dw Data_00B_4A55
    dw Data_00B_4A79
    dw Data_00B_4A9C
    dw Data_00B_4AC0
    dw Data_00B_4AE0
    dw Data_00B_4AFE
    dw Data_00B_4B21
    dw Data_00B_4B41
    dw Data_00B_4B65
    dw Data_00B_4B8B
    dw Data_00B_4B8B
    dw Data_00B_4B8B
    dw Data_00B_4B8B
    dw Data_00B_4B8B
    dw Data_00B_4BAF
    dw Data_00B_4BD3
    dw Data_00B_4BF6
    dw Data_00B_4C18
    dw Data_00B_4C3D
    dw Data_00B_4C57
    dw Data_00B_4C76
    dw Data_00B_4C9A
    dw Data_00B_4CBA
    dw Data_00B_4CDB
    dw Data_00B_4CFE
    dw Data_00B_4D21
    dw Data_00B_4D45
    dw Data_00B_4D65
    dw Data_00B_4D86
    dw Data_00B_4DA7
    dw Data_00B_4DC8
    dw Data_00B_4DE5
    dw Data_00B_4E03
    dw Data_00B_4E27
    dw Data_00B_4E46
    dw Data_00B_4E66
    dw Data_00B_4E85
    dw Data_00B_4EA6
    dw Data_00B_4EC7
    dw Data_00B_4EEA
    dw Data_00B_4F0B
    dw Data_00B_4F2E
    dw Data_00B_4F4C
    dw Data_00B_4F70
    dw Data_00B_4F95
    dw Data_00B_4FB9
    dw Data_00B_4FB9
    dw Data_00B_4FB9
    dw Data_00B_4FB9
    dw Data_00B_4FDA
    dw Data_00B_4FF8
    dw Data_00B_501C
    dw Data_00B_503B
    dw Data_00B_505C
    dw Data_00B_507B
    dw Data_00B_509B
    dw Data_00B_50BF
    dw Data_00B_50E1
    dw Data_00B_5106
    dw Data_00B_5129
    dw Data_00B_514C
    dw Data_00B_5167
    dw Data_00B_518A
    dw Data_00B_51AB
    dw Data_00B_51CD
    dw Data_00B_51EC
    dw Data_00B_520D
    dw Data_00B_522A
    dw Data_00B_5249
    dw Data_00B_526F
    dw Data_00B_5290
    dw Data_00B_52B3
    dw Data_00B_52CF
    dw Data_00B_52F1
    dw Data_00B_5316
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5332
    dw Data_00B_5352
    dw Data_00B_5370
    dw Data_00B_5390
    dw Data_00B_53AD
    dw Data_00B_53CF
    dw Data_00B_53F1
    dw Data_00B_5413
    dw Data_00B_5431
    dw Data_00B_5456
    dw Data_00B_5478
    dw Data_00B_549B
    dw Data_00B_54B9
    dw Data_00B_54DB
    dw Data_00B_54FE
    dw Data_00B_5520
    dw Data_00B_553D
    dw Data_00B_5559
    dw Data_00B_557E
    dw Data_00B_559F
    dw Data_00B_55C2
    dw Data_00B_55E6
    dw Data_00B_560A
    dw Data_00B_562A
    dw Data_00B_5649
    dw Data_00B_566F
    dw Data_00B_568D
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56AE
    dw Data_00B_56D4
    dw Data_00B_56F5
    dw Data_00B_5712
    dw Data_00B_5731
    dw Data_00B_5756
    dw Data_00B_5775
    dw Data_00B_5795
    dw Data_00B_57B3
    dw Data_00B_57D3
    dw Data_00B_57F5
    dw Data_00B_5816
    dw Data_00B_5837
    dw Data_00B_5858
    dw Data_00B_587A
    dw Data_00B_589D
    dw Data_00B_58C3
    dw Data_00B_58E2
    dw Data_00B_5904
    dw Data_00B_5924
    dw Data_00B_5946
    dw Data_00B_5969
    dw Data_00B_598F
    dw Data_00B_59AF
    dw Data_00B_59D1
    dw Data_00B_59F5
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A16
    dw Data_00B_5A34
    dw Data_00B_5A57
    dw Data_00B_5A7A
    dw Data_00B_5A9A
    dw Data_00B_5ABE
    dw Data_00B_5AE2
    dw Data_00B_5B02
    dw Data_00B_5B26
    dw Data_00B_5B46
    dw Data_00B_5B65
    dw Data_00B_5B88
    dw Data_00B_5BAD
    dw Data_00B_5BCC
    dw Data_00B_5BEC
    dw Data_00B_5C0B
    dw Data_00B_5C31
    dw Data_00B_5C50
    dw Data_00B_5C73
    dw Data_00B_5C95
    dw Data_00B_5CB9
    dw Data_00B_5CD5
    dw Data_00B_5CF6
    dw Data_00B_5D17
    dw Data_00B_5D37
    dw Data_00B_5D5D
    dw Data_00B_5D7D
    dw Data_00B_5D9A
    dw Data_00B_5DBB

Data_00B_421C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_00B_5DDF
    dw Data_00B_5E03
    dw Data_00B_5E03
    dw Data_00B_5E03
    dw Data_00B_5E03
    dw Data_00B_5E03
    dw Data_00B_5E03
    dw Data_00B_5E25
    dw Data_00B_5E48
    dw Data_00B_5E6A
    dw Data_00B_5E89
    dw Data_00B_5EAC
    dw Data_00B_5ECC
    dw Data_00B_5EEE
    dw Data_00B_5F0D
    dw Data_00B_5F32
    dw Data_00B_5F52
    dw Data_00B_5F76
    dw Data_00B_5F96
    dw Data_00B_5FB8
    dw Data_00B_5FD7
    dw Data_00B_5FF9
    dw Data_00B_601F
    dw Data_00B_6040
    dw Data_00B_6063
    dw Data_00B_6086
    dw Data_00B_60A4
    dw Data_00B_60CA
    dw Data_00B_60EC
    dw Data_00B_610F
    dw Data_00B_6130
    dw Data_00B_6151
    dw Data_00B_6170
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_6195
    dw Data_00B_61B8
    dw Data_00B_61D9
    dw Data_00B_61F9
    dw Data_00B_621B
    dw Data_00B_6240
    dw Data_00B_6263
    dw Data_00B_6285
    dw Data_00B_62A8
    dw Data_00B_62C6
    dw Data_00B_62E7
    dw Data_00B_630A
    dw Data_00B_6325
    dw Data_00B_634A
    dw Data_00B_636D
    dw Data_00B_6390
    dw Data_00B_63B6
    dw Data_00B_63D9
    dw Data_00B_63F9
    dw Data_00B_6415
    dw Data_00B_6439
    dw Data_00B_645F
    dw Data_00B_6483
    dw Data_00B_64A5
    dw Data_00B_64CA
    dw Data_00B_64EE
    dw Data_00B_6513
    dw Data_00B_6537
    dw Data_00B_655B
    dw Data_00B_657A
    dw Data_00B_6598
    dw Data_00B_65BA
    dw Data_00B_65D2
    dw Data_00B_65D2
    dw Data_00B_65D2
    dw Data_00B_65D2
    dw Data_00B_65F3
    dw Data_00B_6615
    dw Data_00B_6634
    dw Data_00B_6653
    dw Data_00B_6673
    dw Data_00B_6695
    dw Data_00B_66B8
    dw Data_00B_66DC
    dw Data_00B_66FC
    dw Data_00B_671D
    dw Data_00B_6743
    dw Data_00B_6768
    dw Data_00B_678D
    dw Data_00B_67AE
    dw Data_00B_67D1
    dw Data_00B_67F3
    dw Data_00B_6817
    dw Data_00B_6833
    dw Data_00B_6855
    dw Data_00B_6874
    dw Data_00B_6895
    dw Data_00B_68B6
    dw Data_00B_68D9
    dw Data_00B_68FE
    dw Data_00B_6923
    dw Data_00B_6945
    dw Data_00B_6967
    dw Data_00B_698A
    dw Data_00B_69AB
    dw Data_00B_69D0
    dw Data_00B_69F5
    dw Data_00B_6A17
    dw Data_00B_6A17
    dw Data_00B_6A17
    dw Data_00B_6A17
    dw Data_00B_6A3A
    dw Data_00B_6A5E
    dw Data_00B_6A7C
    dw Data_00B_6AA2
    dw Data_00B_6AC4
    dw Data_00B_6AE9
    dw Data_00B_6B0B
    dw Data_00B_6B2F
    dw Data_00B_6B4D
    dw Data_00B_6B70
    dw Data_00B_6B8E
    dw Data_00B_6BB1
    dw Data_00B_6BD4
    dw Data_00B_6BF6
    dw Data_00B_6C18
    dw Data_00B_6C36
    dw Data_00B_6C5B
    dw Data_00B_6C77
    dw Data_00B_6C95
    dw Data_00B_6CB4
    dw Data_00B_6CD4

Data_00B_4326:: ; heuristic: target of a monotone pointer table; C0
    dw Data_00B_6CF1
    dw Data_00B_6CF7
    dw Data_00B_6CFE
    dw Data_00B_6D04
    dw Data_00B_6D09
    dw Data_00B_6D0F
    dw Data_00B_6D13
    dw Data_00B_6D19
    dw Data_00B_6D20
    dw Data_00B_6D29
    dw Data_00B_6D2F

Data_00B_433C:: ; heuristic: target of a monotone pointer table; C0
    db $98, $98, $98, $F0

Data_00B_4340:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $90, $37, $32, $90, $37, $2B
    db $28, $F1, $2F, $2C, $25, $35, $24, $35, $3C, $B5, $FA, $F7, $F2, $20, $2B, $2C
    db $26, $2B, $90, $29, $24, $30, $2C, $2F, $3C, $90, $3A, $2C, $2F, $2F, $F1, $3C
    db $32, $38, $90, $26, $2B, $28, $26, $2E, $98, $F0

Data_00B_437A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02C37A, $43

Data_00B_43BD:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $2B, $2C, $26, $2B, $90, $36, $33, $28, $26, $2C, $28, $36
    db $F1, $3A, $2C, $2F, $2F, $90, $3C, $32, $38, $90, $26, $2B, $28, $26, $2E, $98
    db $F0

Data_00B_43DE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $2B, $2C, $26, $2B, $90, $29, $24, $30, $2C, $2F, $3C, $F1
    db $3A, $2C, $2F, $2F, $90, $3C, $32, $38, $90, $26, $2B, $28, $26, $2E, $98, $F0

Data_00B_43FE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $24, $37, $90, $29, $24, $30, $2C, $2F, $3C, $90, $2C
    db $36, $90, $24, $F1, $30, $3C, $36, $37, $28, $35, $3C, $90, $36, $37, $2C, $2F
    db $2F, $A4, $F7, $F0

Data_00B_4422:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $36, $2F, $2C, $30, $28, $90, $37, $2B, $24, $37, $90, $2B, $24, $36
    db $F1, $27, $35, $24, $2A, $32, $31, $3E, $90, $25, $2F, $32, $32, $27, $B5, $F0

Data_00B_4442:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $26, $32, $2A, $31, $2C, $3D, $28, $27, $90, $25, $3C, $90, $2C, $37
    db $36, $F1, $27, $2C, $36, $37, $2C, $31, $26, $37, $2C, $39, $28, $90, $36, $33
    db $32, $37, $36, $B5, $F0

Data_00B_4467:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $2C, $28, $36, $90, $25, $3C, $90, $29, $2F, $24, $33, $33, $2C, $31
    db $2A, $F1, $28, $24, $35, $9C, $2F, $2C, $2E, $28, $90, $3A, $2C, $31, $2A, $36
    db $B5, $F0

Data_00B_4489:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $31, $2F, $2C, $2A, $2B, $37, $90, $35, $28, $27, $32, $38, $25, $2F
    db $28, $36, $F1, $2C, $37, $36, $90, $38, $36, $38, $24, $2F, $90, $33, $32, $3A
    db $28, $35, $B5, $F0

Data_00B_44AD:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $35, $38, $2A, $2A, $28, $27, $90, $36, $2B, $28, $2F, $2F
    db $F1, $30, $24, $2E, $28, $36, $90, $2C, $37, $90, $36, $2F, $32, $3A, $B5, $F0

Data_00B_44CD:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $36, $2F, $2C, $30, $28, $90, $36, $2B, $2C, $28, $2F, $27
    db $36, $F1, $37, $2B, $28, $90, $2E, $31, $2C, $2A, $2B, $37, $B5, $F0

Data_00B_44EB:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $31, $32, $30, $90, $27, $2C, $36, $36, $32, $2F, $39, $28, $27, $F1
    db $2C, $37, $36, $90, $32, $3A, $31, $90, $25, $32, $27, $3C, $B5, $F0

Data_00B_4509:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $37, $2B, $32, $38, $2A, $2B, $90, $26, $38, $25, $2C, $26, $24, $2F
    db $AB, $F1, $2C, $37, $90, $2C, $36, $90, $36, $34, $38, $2C, $36, $2B, $3C, $B5
    db $F0

Data_00B_452A:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $25, $32, $27, $3C, $90, $2A, $35, $28, $3A, $90, $2B, $24
    db $35, $27, $F1, $2C, $31, $90, $37, $2B, $28, $90, $2B, $24, $35, $27, $90, $36
    db $2B, $28, $2F, $2F, $B5, $F0

Data_00B_4550:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $B5, $01, $90, $2C, $31, $90, $36, $32, $29, $37, $31, $28, $36, $36
    db $F1, $24, $31, $27, $90, $3A, $28, $24, $2E, $31, $28, $36, $36, $B5, $F0

Data_00B_456F:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $2F, $36, $90, $32, $37, $2B, $28, $35, $36, $90, $3A, $2C, $37
    db $2B, $F1, $2C, $37, $36, $90, $37, $28, $31, $37, $24, $26, $2F, $28, $36, $B5
    db $F0

Data_00B_4590:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $30, $24, $31, $28, $90, $24, $37, $37, $28, $36, $37, $36
    db $F1, $37, $32, $90, $2C, $37, $36, $90, $29, $28, $35, $32, $26, $2C, $37, $3C
    db $B5, $F0

Data_00B_45B2:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $2E, $28, $36, $90, $37, $32, $90, $27, $35, $32, $33, $90, $32, $31
    db $F1, $29, $32, $28, $36, $90, $2B, $28, $24, $39, $2C, $2F, $3C, $B5, $F0

Data_00B_45D1:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $31, $2B, $24, $31, $26, $28, $27, $90, $29, $32, $35, $90, $36, $33, $28
    db $28, $27, $F1, $24, $31, $27, $90, $27, $38, $35, $24, $25, $2C, $2F, $2C, $37
    db $3C, $B5, $F0

Data_00B_45F4:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $2B, $38, $2A, $28, $90, $2F, $28, $2A, $36, $90, $24, $35
    db $28, $F1, $2C, $37, $36, $90, $30, $24, $2C, $31, $90, $24, $36, $36, $28, $37
    db $36, $B5, $F0

Data_00B_4617:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $39, $28, $36, $90, $38, $33, $90, $37, $32, $90, $2C, $37, $36, $F1
    db $31, $24, $30, $28, $90, $2C, $31, $90, $33, $32, $3A, $28, $35, $B5, $F0

Data_00B_4636:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $35, $27, $90, $24, $31, $27, $90, $29, $24, $36, $37, $AB, $90, $2C
    db $37, $F1, $29, $2F, $28, $28, $36, $90, $34, $38, $2C, $26, $2E, $2F, $3C, $B5
    db $F0

Data_00B_4657:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3B, $37, $35, $28, $30, $28, $2F, $3C, $90, $2B, $24, $35, $27, $90, $24
    db $31, $27, $F1, $33, $35, $32, $31, $28, $90, $37, $32, $90, $29, $2F, $28, $28
    db $2C, $31, $2A, $B5, $F0

Data_00B_467C:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $2F, $24, $35, $2A, $28, $36, $37, $90, $32, $29, $F1, $36
    db $33, $32, $37, $37, $28, $27, $90, $36, $2F, $2C, $30, $28, $B5, $F0

Data_00B_469A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $26, $2B, $28, $28, $35, $29, $38, $2F, $90, $36, $2F, $2C, $30, $28
    db $F1, $37, $2B, $24, $37, $90, $2F, $32, $39, $28, $36, $90, $2B, $28, $24, $37
    db $B5, $F0

Data_00B_46BC:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $29, $28, $35, $36, $90, $37, $32, $90, $30, $24, $2E, $28, $F1
    db $2C, $37, $36, $90, $28, $31, $28, $30, $2C, $28, $36, $90, $2F, $24, $38, $2A
    db $2B, $B5, $F0

Data_00B_46DF:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $2B, $24, $2F, $32, $90, $2C, $36, $90, $38, $36, $28, $27
    db $F1, $37, $32, $90, $25, $2C, $31, $27, $90, $28, $31, $28, $30, $2C, $28, $36
    db $B5, $F0

Data_00B_4701:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $25, $32, $27, $3C, $90, $2C, $36, $F1, $28, $3B, $37, $35
    db $28, $30, $28, $2F, $3C, $90, $2B, $24, $35, $27, $B5, $F0

Data_00B_471D:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $2A, $32, $2F, $27, $28, $31, $90, $25, $32, $27, $3C, $90
    db $2C, $36, $F1, $38, $31, $25, $35, $28, $24, $2E, $24, $25, $2F, $28, $B5, $F0

Data_00B_473D:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $3A, $2C, $36, $28, $90, $28, $2F, $27, $28, $35, $F1, $24
    db $30, $32, $31, $2A, $90, $36, $2F, $2C, $30, $28, $B5, $F0

Data_00B_4759:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $24, $37, $90, $2F, $38, $35, $2E, $36, $90, $2C, $31, $36, $2C, $27
    db $28, $F1, $2C, $36, $90, $24, $90, $30, $3C, $36, $37, $28, $35, $3C, $B5, $F0

Data_00B_4779:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $36, $33, $2C, $37, $28, $90, $2C, $37, $36, $90, $31, $24, $30, $28
    db $AB, $F1, $2C, $37, $90, $31, $28, $39, $28, $35, $90, $26, $2B, $24, $31, $2A
    db $28, $36, $B5, $F0

Data_00B_479D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $32, $3A, $AB, $90, $25, $38, $37, $90, $2B, $28, $24, $39, $2C, $2F
    db $3C, $F1, $33, $35, $32, $37, $28, $26, $37, $28, $27, $B5, $F0

Data_00B_47BA:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $25, $28, $24, $2E, $36, $90, $31, $28, $39, $28, $35, $F1
    db $30, $2C, $36, $36, $90, $29, $2F, $3C, $2C, $31, $2A, $90, $33, $35, $28, $3C
    db $B5, $F0

Data_00B_47DC:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $36, $28, $36, $90, $2C, $31, $90, $2C, $37, $36, $90, $25, $32, $27
    db $3C, $F1, $2E, $28, $28, $33, $90, $2C, $37, $90, $24, $29, $2F, $32, $24, $37
    db $B5, $F0

Data_00B_47FE:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $36, $32, $90, $2E, $31, $32, $3A, $31, $90, $24, $36, $F1, $25, $38
    db $37, $37, $28, $35, $29, $2F, $3C, $90, $27, $35, $24, $2A, $32, $31, $B5, $F0

Data_00B_481E:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $90, $24, $26, $26, $32, $30, $33, $2F, $2C, $36, $2B, $28, $27, $F1
    db $38, $36, $28, $35, $90, $32, $29, $90, $36, $3A, $32, $35, $27, $36, $B5, $F0

Data_00B_483E:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $39, $28, $36, $90, $34, $38, $2C, $28, $37, $2F, $3C, $90, $2C, $31
    db $F1, $33, $32, $2C, $36, $32, $31, $32, $38, $36, $90, $25, $32, $2A, $36, $B5
    db $F0

Data_00B_485F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $25, $36, $90, $3A, $2C, $37, $2B, $90, $36, $3A, $32, $35, $27
    db $9C, $F1, $2F, $2C, $2E, $28, $90, $36, $33, $2C, $2E, $28, $36, $B5, $F0

Data_00B_487E:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2A, $2C, $2F, $28, $90, $24, $31, $27, $90, $28, $34, $38, $2C, $33, $33
    db $28, $27, $F1, $3A, $2C, $37, $2B, $90, $36, $2B, $24, $35, $33, $90, $26, $2F
    db $24, $3A, $36, $B5, $F0

Data_00B_48A3:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $28, $24, $37, $2B, $28, $36, $90, $29, $2C, $35, $28, $90, $32, $29
    db $F1, $2A, $35, $28, $24, $37, $90, $2C, $31, $37, $28, $31, $36, $2C, $37, $3C
    db $B5, $F0

Data_00B_48C5:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $38, $31, $36, $90, $29, $24, $36, $37, $AB, $90, $25, $38, $37, $90, $2C
    db $31, $F1, $24, $90, $26, $32, $30, $2C, $26, $24, $2F, $90, $30, $24, $31, $31
    db $28, $35, $B5, $F0

Data_00B_48E9:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $33, $32, $3A, $28, $35, $90, $2C, $36, $90, $25, $28, $36
    db $37, $F1, $24, $30, $32, $31, $2A, $90, $27, $35, $24, $2A, $32, $31, $36, $B5
    db $F0

Data_00B_490A:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $29, $2F, $2C, $28, $36, $90, $3A, $2C, $37, $2B, $90, $24, $F1
    db $35, $32, $26, $2E, $2C, $31, $2A, $90, $30, $32, $37, $2C, $32, $31, $B5, $F0

Data_00B_492A:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $31, $2A, $28, $36, $90, $2C, $37, $36, $90, $26, $32, $2F, $32
    db $35, $36, $F1, $37, $32, $90, $26, $32, $31, $29, $38, $36, $28, $90, $29, $32
    db $28, $36, $B5, $F0

Data_00B_494E:: ; heuristic: target of a monotone pointer table; C0
    db $20, $32, $35, $2E, $36, $90, $24, $31, $27, $90, $24, $37, $37, $24, $26, $2E
    db $36, $F1, $2C, $31, $90, $27, $35, $32, $39, $28, $36, $B5, $F0

Data_00B_496B:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $3A, $2C, $31, $2A, $36, $90, $24, $35, $28, $90, $38, $36
    db $28, $27, $F1, $29, $32, $35, $90, $2C, $31, $37, $2C, $30, $2C, $27, $24, $37
    db $2C, $32, $31, $B5, $F0

Data_00B_4990:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $35, $2C, $2E, $28, $36, $90, $29, $32, $28, $36, $90, $3A, $2C, $37
    db $2B, $F1, $39, $28, $31, $32, $30, $32, $38, $36, $90, $29, $24, $31, $2A, $36
    db $B5, $F0

Data_00B_49B2:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $27, $28, $33, $37, $90, $24, $37, $90, $30, $24, $2E, $2C, $31, $2A, $F1
    db $24, $28, $35, $2C, $24, $2F, $90, $24, $37, $37, $24, $26, $2E, $36, $B5, $F0

Data_00B_49D2:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $24, $26, $2E, $36, $90, $3A, $2C, $37, $2B, $90, $2C, $37, $36
    db $F1, $2F, $32, $31, $2A, $90, $37, $32, $31, $2A, $38, $28, $B5, $F0

Data_00B_49F0:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $28, $24, $2E, $36, $90, $29, $32, $28, $36, $90, $24, $36, $90, $2C
    db $29, $F1, $37, $2B, $28, $3C, $90, $3A, $28, $35, $28, $90, $35, $32, $26, $2E
    db $36, $B5, $F0

Data_00B_4A13:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $24, $37, $90, $2C, $31, $90, $25, $32, $37, $2B, $F1, $33, $32
    db $3A, $28, $35, $90, $24, $31, $27, $90, $2F, $32, $32, $2E, $36, $B5, $F0

Data_00B_4A32:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $2E, $28, $36, $90, $2C, $37, $36, $90, $26, $32, $30, $25, $F1
    db $3A, $2B, $28, $31, $90, $29, $24, $26, $2C, $31, $2A, $90, $24, $90, $29, $32
    db $28, $B5, $F0

Data_00B_4A55:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $35, $28, $24, $27, $36, $90, $2C, $37, $36, $90, $3A, $2C, $31, $2A
    db $36, $F1, $29, $32, $35, $90, $2C, $31, $37, $2C, $30, $2C, $27, $24, $37, $2C
    db $32, $31, $B5, $F0

Data_00B_4A79:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $35, $2C, $2E, $28, $36, $90, $2B, $24, $35, $27, $90, $37, $32, $90
    db $14, $18, $F1, $29, $32, $28, $36, $90, $2C, $31, $36, $37, $24, $31, $37, $2F
    db $3C, $B5, $F0

Data_00B_4A9C:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $2C, $31, $2E, $36, $90, $29, $2C, $39, $28, $90, $37, $2C, $30, $28
    db $36, $F1, $29, $24, $36, $37, $28, $35, $90, $37, $2B, $24, $31, $90, $29, $32
    db $28, $36, $B5, $F0

Data_00B_4AC0:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $2F, $27, $2F, $3C, $90, $36, $3A, $2C, $31, $2A, $36, $90, $2C, $37
    db $36, $F1, $24, $3B, $90, $2C, $31, $90, $25, $24, $37, $37, $2F, $28, $B5, $F0

Data_00B_4AE0:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $28, $2E, $36, $90, $33, $35, $28, $3C, $90, $3A, $2C, $37, $2B, $F1
    db $2C, $37, $36, $90, $3A, $2B, $2C, $36, $2E, $28, $35, $36, $B5, $F0

Data_00B_4AFE:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $36, $31, $24, $2E, $28, $36, $90, $2C, $37, $90, $24, $37
    db $28, $F1, $25, $28, $26, $24, $30, $28, $90, $2C, $37, $36, $90, $29, $28, $28
    db $37, $B5, $F0

Data_00B_4B21:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $26, $2F, $32, $38, $27, $36, $90, $24
    db $31, $27, $F1, $26, $24, $38, $36, $28, $36, $90, $35, $24, $2C, $31, $B5, $F0

Data_00B_4B41:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $25, $32, $27, $3C, $90, $2B, $24, $35, $27, $28, $31, $28
    db $27, $F1, $29, $35, $32, $30, $90, $2B, $2C, $25, $28, $35, $31, $24, $37, $2C
    db $32, $31, $B5, $F0

Data_00B_4B65:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $38, $27, $90, $32, $29, $90, $2C, $37, $36, $90, $33, $32, $3A
    db $28, $35, $F1, $24, $31, $27, $90, $28, $31, $32, $35, $30, $32, $38, $36, $90
    db $36, $2C, $3D, $28, $B5, $F0

Data_00B_4B8B:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $33, $37, $38, $35, $28, $36, $90, $24, $31, $27, $90, $28, $24, $37
    db $36, $F1, $29, $32, $28, $36, $90, $2C, $31, $90, $32, $31, $28, $90, $2A, $38
    db $2F, $33, $B5, $F0

Data_00B_4BAF:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $2B, $32, $35, $31, $90, $2A, $2F, $32, $3A, $36, $90, $37
    db $32, $F1, $26, $32, $31, $29, $32, $38, $31, $27, $90, $28, $31, $28, $30, $2C
    db $28, $36, $B5, $F0

Data_00B_4BD3:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $2C, $28, $36, $90, $2C, $31, $90, $26, $2F, $32, $36, $28, $90, $24
    db $31, $27, $F1, $26, $2F, $24, $3A, $36, $90, $36, $24, $39, $24, $2A, $28, $2F
    db $3C, $B5, $F0

Data_00B_4BF6:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $29, $2F, $38, $29, $29, $3C, $90, $29, $38, $35, $F1, $32
    db $29, $29, $28, $35, $36, $90, $33, $35, $32, $37, $28, $26, $37, $2C, $32, $31
    db $B5, $F0

Data_00B_4C18:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $24, $35, $30, $32, $35, $90, $2C, $36, $90, $30, $24, $27
    db $28, $F1, $32, $29, $90, $33, $24, $37, $26, $2B, $28, $27, $90, $2F, $28, $24
    db $39, $28, $36, $B5, $F0

Data_00B_4C3D:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $24, $26, $37, $36, $90, $25, $28, $29, $32, $35, $28, $90, $2C
    db $37, $F1, $37, $2B, $2C, $31, $2E, $36, $B5, $F0

Data_00B_4C57:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $31, $28, $39, $28, $35, $90, $2F, $28, $37, $36, $90, $2A, $32
    db $F1, $32, $29, $90, $37, $2B, $28, $90, $36, $2E, $38, $2F, $2F, $B5, $F0

Data_00B_4C76:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $33, $28, $36, $90, $3A, $2C, $31, $27, $90, $2C, $31, $37, $32
    db $F1, $33, $32, $3A, $28, $35, $29, $38, $2F, $90, $25, $24, $35, $35, $2C, $28
    db $35, $36, $B5, $F0

Data_00B_4C9A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $24, $26, $2E, $36, $90, $33, $35, $28, $3C, $90, $2C, $31, $90
    db $24, $F1, $25, $2C, $37, $2C, $31, $2A, $90, $36, $3A, $24, $35, $30, $B5, $F0

Data_00B_4CBA:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $2A, $36, $90, $33, $35, $28, $3C, $90, $3A, $2C, $37, $2B, $F1
    db $2C, $37, $36, $90, $35, $32, $33, $3C, $90, $37, $32, $31, $2A, $38, $28, $B5
    db $F0

Data_00B_4CDB:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $36, $90, $37, $32, $90, $26, $2B, $28, $28, $35, $90
    db $38, $33, $F1, $37, $2B, $28, $90, $24, $37, $30, $32, $36, $33, $2B, $28, $35
    db $28, $B5, $F0

Data_00B_4CFE:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $2B, $32, $35, $31, $28, $27, $90, $36, $2B, $28, $2F, $2F
    db $F1, $2C, $36, $90, $24, $90, $2A, $32, $32, $27, $90, $3A, $28, $24, $33, $32
    db $31, $B5, $F0

Data_00B_4D21:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $2B, $38, $30, $32, $35, $32, $38, $36, $90, $29, $24, $26
    db $28, $F1, $30, $24, $2E, $28, $36, $90, $2C, $37, $90, $33, $32, $33, $38, $2F
    db $24, $35, $B5, $F0

Data_00B_4D45:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $36, $90, $27, $2C, $29, $29, $2C, $26, $38, $2F, $37, $3C, $F1, $3A
    db $2C, $37, $2B, $90, $37, $2B, $28, $90, $2B, $24, $30, $30, $28, $35, $B5, $F0

Data_00B_4D65:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $26, $2F, $24, $3A, $36, $90, $2C, $31, $29, $2F, $2C, $26
    db $37, $F1, $3A, $2C, $26, $2E, $28, $27, $90, $27, $24, $30, $24, $2A, $28, $B5
    db $F0

Data_00B_4D86:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $2C, $36, $90, $27, $2C, $29, $29, $2C, $26, $38, $2F, $37, $90
    db $37, $32, $F1, $36, $33, $32, $37, $90, $2C, $31, $90, $36, $31, $32, $3A, $B5
    db $F0

Data_00B_4DA7:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $31, $28, $39, $28, $35, $90, $30, $2C, $36, $36, $28, $36, $F1
    db $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $24, $35, $35, $32, $3A, $36, $B5
    db $F0

Data_00B_4DC8:: ; heuristic: target of a monotone pointer table; C0
    db $17, $28, $39, $28, $35, $90, $2F, $32, $36, $28, $36, $90, $2C, $31, $90, $37
    db $2B, $28, $F1, $27, $24, $35, $2E, $31, $28, $36, $36, $B5, $F0

Data_00B_4DE5:: ; heuristic: target of a monotone pointer table; C0
    db $15, $28, $24, $33, $36, $90, $32, $38, $37, $90, $32, $29, $90, $37, $35, $28
    db $28, $36, $F1, $37, $32, $90, $24, $37, $37, $24, $26, $2E, $B5, $F0

Data_00B_4E03:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $35, $35, $32, $3A, $36, $90, $38, $36, $2C, $31, $2A, $90, $2C, $37
    db $36, $F1, $32, $39, $28, $35, $36, $2C, $3D, $28, $27, $90, $36, $2B, $32, $39
    db $28, $2F, $B5, $F0

Data_00B_4E27:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $2C, $28, $36, $90, $38, $36, $2C, $31, $2A, $90, $2C, $37, $36, $F1
    db $28, $24, $35, $36, $90, $24, $36, $90, $3A, $2C, $31, $2A, $36, $B5, $F0

Data_00B_4E46:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $2B, $32, $35, $31, $90, $36, $2F, $24, $3C, $36, $F1, $29
    db $32, $28, $36, $90, $33, $24, $2C, $31, $2F, $28, $36, $36, $2F, $3C, $B5, $F0

Data_00B_4E66:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $2B, $32, $35, $31, $36, $90, $26, $38, $35, $2F, $28, $27
    db $F1, $29, $35, $32, $30, $90, $25, $38, $37, $37, $2C, $31, $2A, $B5, $F0

Data_00B_4E85:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $39, $28, $36, $90, $29, $24, $36, $37, $90, $2C, $31, $F1, $36, $33
    db $2C, $37, $28, $90, $32, $29, $90, $2C, $37, $36, $90, $36, $2C, $3D, $28, $B5
    db $F0

Data_00B_4EA6:: ; heuristic: target of a monotone pointer table; C0
    db $12, $30, $30, $32, $25, $2C, $2F, $2C, $3D, $28, $36, $90, $29, $32, $28, $36
    db $F1, $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $37, $35, $38, $31, $2E, $B5
    db $F0

Data_00B_4EC7:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $24, $38, $2A, $2B, $37, $28, $35, $36, $90, $29, $32, $28, $36, $F1
    db $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $29, $32, $35, $28, $2F, $28, $2A
    db $36, $B5, $F0

Data_00B_4EEA:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $2C, $33, $36, $90, $24, $31, $27, $90, $2B, $38, $35, $2F, $36, $F1
    db $29, $32, $28, $36, $90, $3A, $2C, $37, $2B, $90, $2B, $32, $35, $31, $36, $B5
    db $F0

Data_00B_4F0B:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $35, $2C, $28, $31, $27, $2F, $3C, $90, $27, $28, $36, $33, $2C, $37, $28
    db $F1, $2C, $37, $36, $90, $36, $24, $39, $24, $2A, $28, $90, $2F, $32, $32, $2E
    db $36, $B5, $F0

Data_00B_4F2E:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $37, $36, $90, $34, $38, $2C, $28, $37, $2F, $3C, $90, $37, $32, $F1
    db $24, $39, $32, $2C, $27, $90, $2B, $38, $31, $2A, $28, $35, $B5, $F0

Data_00B_4F4C:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $36, $28, $36, $90, $30, $28, $24, $31, $90, $2F, $32, $32, $2E, $36, $90
    db $37, $32, $F1, $2C, $31, $37, $2C, $30, $2C, $27, $24, $37, $28, $90, $29, $32
    db $28, $36, $B5, $F0

Data_00B_4F70:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $01, $00, $00, $9C, $3C, $28, $24, $35, $90, $32, $2F, $27, $90, $26
    db $24, $37, $F1, $26, $24, $33, $24, $25, $2F, $28, $90, $32, $29, $90, $30, $24
    db $2A, $2C, $26, $B5, $F0

Data_00B_4F95:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $2F, $2C, $36, $2B, $28, $36, $90, $2C, $37, $36, $90, $36, $3A, $32
    db $35, $27, $F1, $36, $2B, $2C, $31, $3C, $90, $28, $39, $28, $35, $3C, $90, $27
    db $24, $3C, $B5, $F0

Data_00B_4FB9:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $35, $24, $26, $37, $36, $90, $30, $24, $37, $28, $36, $F1, $3A
    db $2C, $37, $2B, $90, $2C, $37, $36, $90, $33, $2F, $38, $30, $24, $2A, $28, $B5
    db $F0

Data_00B_4FDA:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $2C, $35, $27, $90, $3A, $2C, $37, $2B, $90, $24, $90, $25, $38
    db $2A, $9C, $F1, $2F, $2C, $2E, $28, $90, $25, $32, $27, $3C, $B5, $F0

Data_00B_4FF8:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $26, $2E, $90, $32, $29, $90, $28, $3B, $28, $35, $26, $2C, $36, $28
    db $F1, $36, $37, $38, $31, $37, $28, $27, $90, $2C, $37, $36, $90, $3A, $2C, $31
    db $2A, $36, $B5, $F0

Data_00B_501C:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $29, $24, $26, $2C, $24, $2F, $90, $29, $2F, $32, $3A, $28
    db $35, $F1, $2C, $36, $90, $36, $37, $38, $26, $2E, $90, $32, $31, $B5, $F0

Data_00B_503B:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $36, $33, $35, $28, $24, $27, $36, $90, $2C, $37, $36, $F1, $2F
    db $2C, $30, $25, $36, $90, $24, $31, $27, $90, $2A, $2F, $2C, $27, $28, $36, $B5
    db $F0

Data_00B_505C:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $35, $3C, $90, $26, $32, $3A, $24, $35, $27, $2F, $3C, $B5, $F1, $15
    db $2C, $2E, $28, $2F, $3C, $90, $37, $32, $90, $29, $2F, $28, $28, $B5, $F0

Data_00B_507B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $3A, $24, $3C, $36, $90, $26, $24, $35, $35, $2C, $28, $36, $90, $2C
    db $37, $36, $F1, $36, $2E, $38, $2F, $2F, $90, $35, $32, $32, $36, $37, $B5, $F0

Data_00B_509B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $30, $32, $36, $37, $90, $2C, $31, $39, $2C, $36, $2C, $25, $2F, $28
    db $F1, $28, $3B, $26, $28, $33, $37, $90, $29, $32, $35, $90, $24, $90, $2A, $2F
    db $32, $3A, $B5, $F0

Data_00B_50BF:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $36, $2F, $2C, $26, $28, $36, $90, $37, $2B, $35, $32, $38, $2A
    db $2B, $F1, $3A, $24, $37, $28, $35, $90, $36, $33, $28, $28, $27, $2C, $2F, $3C
    db $B5, $F0

Data_00B_50E1:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $27, $28, $36, $90, $2C, $31, $90, $27, $24, $35, $2E, $31, $28, $36
    db $36, $F1, $24, $31, $27, $90, $36, $31, $28, $24, $2E, $90, $24, $37, $37, $24
    db $26, $2E, $36, $B5, $F0

Data_00B_5106:: ; heuristic: target of a monotone pointer table; C0
    db $11, $38, $31, $37, $36, $90, $38, $36, $2C, $31, $2A, $90, $37, $2B, $28, $F1
    db $28, $3C, $28, $36, $90, $32, $31, $90, $2C, $37, $36, $90, $3A, $2C, $31, $2A
    db $36, $B5, $F0

Data_00B_5129:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $31, $36, $37, $24, $31, $37, $90, $31, $24, $33, $36, $90, $30, $24
    db $27, $28, $F1, $37, $2B, $2C, $36, $90, $29, $32, $3A, $2F, $90, $2B, $38, $2A
    db $28, $B5, $F0

Data_00B_514C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $2F, $2C, $39, $28, $35, $36, $90, $2B, $24, $35, $36, $2B, $F1, $2B
    db $28, $24, $27, $9C, $25, $38, $37, $37, $36, $B5, $F0

Data_00B_5167:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $32, $37, $36, $90, $29, $32, $35, $2F, $32, $35, $31, $2F, $3C, $F1
    db $31, $2C, $2A, $2B, $37, $90, $24, $29, $37, $28, $35, $90, $31, $2C, $2A, $2B
    db $37, $B5, $F0

Data_00B_518A:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $26, $2E, $36, $90, $29, $32, $28, $36, $90, $25, $3C, $F1, $37, $3A
    db $2C, $36, $37, $2C, $31, $2A, $90, $2C, $37, $36, $90, $31, $28, $26, $2E, $B5
    db $F0

Data_00B_51AB:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $32, $2E, $36, $90, $24, $31, $27, $90, $37, $28, $24, $35, $36, $F1
    db $3A, $2C, $37, $2B, $90, $36, $2B, $24, $35, $33, $90, $26, $2F, $24, $3A, $36
    db $B5, $F0

Data_00B_51CD:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $36, $90, $28, $3C, $28, $36, $90, $32, $31, $90, $2C, $37, $36, $F1
    db $25, $32, $27, $3C, $90, $24, $31, $27, $90, $2B, $28, $24, $27, $B5, $F0

Data_00B_51EC:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $27, $28, $33, $37, $90, $24, $37, $90, $29, $35, $28, $28, $3D, $2C, $31
    db $2A, $F1, $29, $32, $28, $36, $90, $2C, $30, $30, $32, $25, $2C, $2F, $28, $B5
    db $F0

Data_00B_520D:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $26, $2C, $31, $28, $35, $24, $37, $28, $36, $90, $29, $32, $28, $36
    db $F1, $37, $32, $90, $31, $32, $37, $2B, $2C, $31, $2A, $B5, $F0

Data_00B_522A:: ; heuristic: target of a monotone pointer table; C0
    db $20, $35, $24, $33, $36, $90, $29, $32, $28, $36, $90, $2C, $31, $F1, $3A, $2B
    db $2C, $37, $28, $90, $2F, $2C, $2A, $2B, $37, $31, $2C, $31, $2A, $B5, $F0

Data_00B_5249:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $39, $28, $36, $90, $29, $35, $32, $30, $90, $37, $2B, $28, $90, $36
    db $2E, $3C, $F1, $24, $31, $27, $90, $2E, $2C, $26, $2E, $36, $90, $29, $32, $28
    db $36, $90, $38, $33, $B5, $F0

Data_00B_526F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $36, $2B, $28, $36, $90, $29, $32, $28, $36, $90, $29, $2F, $24
    db $37, $F1, $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $25, $32, $27, $3C, $B5
    db $F0

Data_00B_5290:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $36, $90, $24, $27, $35, $32, $2C, $37, $2F, $3C, $F1
    db $27, $28, $36, $33, $2C, $37, $28, $90, $2C, $37, $36, $90, $2A, $2C, $35, $37
    db $2B, $B5, $F0

Data_00B_52B3:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $36, $90, $35, $24, $2C, $31, $25, $32, $3A, $90, $2B, $32, $35, $31
    db $36, $F1, $24, $31, $27, $90, $37, $24, $2C, $2F, $B5, $F0

Data_00B_52CF:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $2C, $28, $36, $90, $24, $31, $27, $90, $35, $38, $31, $36, $90, $24
    db $37, $F1, $37, $2B, $28, $90, $36, $24, $30, $28, $90, $36, $33, $28, $28, $27
    db $B5, $F0

Data_00B_52F1:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $2C, $26, $2E, $9C, $36, $2E, $2C, $31, $31, $28, $27, $90, $24, $31
    db $27, $F1, $33, $32, $3A, $28, $35, $29, $38, $2F, $2F, $3C, $90, $3A, $2C, $31
    db $2A, $28, $27, $B5, $F0

Data_00B_5316:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $27, $28, $36, $90, $32, $31, $90, $2C, $37, $36, $F1, $25, $28
    db $2F, $2F, $3C, $90, $32, $31, $90, $2C, $26, $28, $B5, $F0

Data_00B_5332:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $38, $30, $33, $36, $90, $24, $2F, $32, $31, $2A, $90, $32, $31, $F1
    db $2C, $37, $36, $90, $37, $2B, $2C, $31, $90, $39, $2C, $31, $28, $36, $B5, $F0

Data_00B_5352:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $2C, $37, $36, $90, $29, $2C, $35, $28, $9C, $2B, $32, $37, $F1, $36
    db $28, $28, $27, $36, $90, $24, $37, $90, $29, $32, $28, $36, $B5, $F0

Data_00B_5370:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $35, $24, $2C, $2F, $AB, $90, $25, $38, $37, $90, $36, $2B, $24, $35, $33
    db $2F, $3C, $F1, $2C, $31, $37, $28, $2F, $2F, $2C, $2A, $28, $31, $37, $B5, $F0

Data_00B_5390:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $29, $2F, $32, $24, $37, $36, $90, $35, $24, $37, $2B, $28, $35
    db $F1, $37, $2B, $24, $31, $90, $29, $2F, $2C, $28, $36, $B5, $F0

Data_00B_53AD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $2C, $31, $36, $90, $37, $32, $90, $29, $2C, $35, $28, $90, $2C, $37
    db $36, $F1, $31, $28, $28, $27, $2F, $28, $36, $90, $3A, $2C, $2F, $27, $2F, $3C
    db $B5, $F0

Data_00B_53CF:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $32, $36, $28, $36, $90, $2C, $37, $36, $90, $28, $3C, $28, $90, $24
    db $31, $27, $F1, $30, $32, $38, $37, $2B, $90, $37, $32, $90, $2B, $2C, $27, $28
    db $B5, $F0

Data_00B_53F1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $26, $24, $37, $37, $28, $35, $36, $90, $37, $32, $3B, $2C, $26, $F1, $36
    db $33, $32, $35, $28, $36, $90, $25, $3C, $90, $27, $24, $31, $26, $2C, $31, $2A
    db $B5, $F0

Data_00B_5413:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $29, $24, $26, $28, $90, $2B, $24, $35, $27, $28, $31, $28
    db $27, $F1, $2C, $31, $37, $32, $90, $24, $30, $25, $28, $35, $B5, $F0

Data_00B_5431:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $24, $2F, $2F, $32, $3A, $36, $90, $33, $35, $28, $3C, $90, $3A, $2C
    db $37, $2B, $F1, $2C, $37, $36, $90, $2A, $2C, $24, $31, $37, $90, $37, $32, $31
    db $2A, $38, $28, $B5, $F0

Data_00B_5456:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $24, $26, $2E, $36, $90, $37, $2B, $28, $90, $38, $31, $3A, $24
    db $35, $3C, $F1, $3A, $2B, $32, $90, $36, $2C, $37, $90, $32, $31, $90, $2C, $37
    db $B5, $F0

Data_00B_5478:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $25, $32, $27, $3C, $90, $29, $2F, $38, $2C, $27, $36, $F1
    db $26, $24, $38, $36, $28, $90, $3A, $24, $37, $28, $35, $3C, $90, $28, $3C, $28
    db $36, $B5, $F0

Data_00B_549B:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $36, $90, $37, $32, $90, $30, $24, $2E, $28, $F1, $29
    db $32, $28, $36, $90, $26, $24, $35, $28, $2F, $28, $36, $36, $B5, $F0

Data_00B_54B9:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $36, $38, $24, $2F, $2F, $3C, $90, $26, $24, $2F, $30, $AB, $90, $25, $38
    db $37, $F1, $28, $24, $36, $2C, $2F, $3C, $90, $28, $31, $35, $24, $2A, $28, $27
    db $B5, $F0

Data_00B_54DB:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $32, $36, $28, $36, $90, $2C, $37, $36, $90, $30, $32, $38, $37, $2B
    db $F1, $37, $32, $90, $3A, $24, $2C, $37, $90, $29, $32, $35, $90, $33, $35, $28
    db $3C, $B5, $F0

Data_00B_54FE:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $2A, $2F, $24, $35, $28, $36, $90, $37, $32, $90, $2F, $24, $3C
    db $90, $24, $F1, $26, $38, $35, $36, $28, $90, $32, $31, $90, $29, $32, $28, $36
    db $B5, $F0

Data_00B_5520:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $27, $2C, $28, $36, $90, $2C, $29, $90, $2C, $37, $F1, $36, $37
    db $32, $33, $36, $90, $27, $24, $31, $26, $2C, $31, $2A, $B5, $F0

Data_00B_553D:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $36, $90, $25, $28, $24, $31, $36, $90, $29, $35, $32, $30
    db $F1, $2C, $37, $36, $90, $25, $28, $2F, $2F, $3C, $B5, $F0

Data_00B_5559:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $27, $28, $36, $90, $38, $31, $27, $28, $35, $2A, $35, $32, $38, $31
    db $27, $F1, $38, $31, $37, $2C, $2F, $90, $2C, $37, $90, $2A, $28, $37, $36, $90
    db $2B, $32, $37, $B5, $F0

Data_00B_557E:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $24, $37, $36, $90, $33, $35, $28, $3C, $90, $3A, $2B, $32, $2F, $28, $F1
    db $3A, $2C, $37, $2B, $32, $38, $37, $90, $26, $2B, $28, $3A, $2C, $31, $2A, $B5
    db $F0

Data_00B_559F:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $24, $37, $36, $90, $35, $24, $33, $2C, $27, $2F, $3C, $90, $3A, $2C, $37
    db $2B, $F1, $2C, $37, $36, $90, $37, $2B, $35, $28, $28, $90, $2B, $28, $24, $27
    db $36, $B5, $F0

Data_00B_55C2:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $30, $25, $35, $24, $26, $28, $36, $90, $29, $32, $28, $36, $90, $24, $31
    db $27, $F1, $27, $35, $24, $2C, $31, $36, $90, $31, $38, $37, $35, $2C, $28, $31
    db $37, $36, $B5, $F0

Data_00B_55E6:: ; heuristic: target of a monotone pointer table; C0
    db $12, $30, $30, $32, $25, $2C, $2F, $2C, $3D, $28, $36, $90, $29, $32, $28, $36
    db $F1, $3A, $2C, $37, $2B, $90, $37, $2B, $32, $35, $31, $3C, $90, $39, $2C, $31
    db $28, $36, $B5, $F0

Data_00B_560A:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $33, $35, $28, $36, $28, $31, $37, $36, $90, $37, $2B, $28, $F1, $24
    db $31, $2A, $28, $35, $90, $32, $29, $90, $33, $2F, $24, $31, $37, $36, $B5, $F0

Data_00B_562A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $30, $2C, $36, $26, $2B, $2C, $28, $39, $32, $38, $36, $F1, $33, $2F
    db $24, $31, $37, $90, $28, $2F, $28, $30, $24, $31, $37, $24, $2F, $B5, $F0

Data_00B_5649:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $90, $2C, $31, $37, $28, $2F, $2F, $2C, $2A, $28, $31, $37, $90, $25
    db $38, $37, $F1, $32, $27, $27, $90, $25, $24, $2F, $2F, $90, $32, $29, $90, $29
    db $2F, $38, $29, $29, $B5, $F0

Data_00B_566F:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $35, $26, $28, $36, $90, $29, $32, $28, $36, $90, $37, $32, $F1, $27
    db $24, $31, $26, $28, $90, $3A, $2C, $37, $2B, $90, $2C, $37, $B5, $F0

Data_00B_568D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $38, $31, $2C, $39, $28, $35, $36, $24, $2F, $90, $2B, $28, $35, $32
    db $F1, $24, $30, $32, $31, $2A, $90, $2C, $37, $36, $90, $2E, $2C, $31, $27, $B5
    db $F0

Data_00B_56AE:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $24, $26, $2E, $36, $90, $2C, $31, $90, $24, $90, $36, $2F, $32
    db $3A, $AB, $F1, $27, $28, $2F, $2C, $25, $28, $35, $24, $37, $28, $90, $30, $24
    db $31, $31, $28, $35, $B5, $F0

Data_00B_56D4:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $36, $37, $38, $30, $33, $3C, $90, $29, $28, $28, $37, $F1
    db $2F, $2C, $30, $2C, $37, $90, $2C, $37, $36, $90, $36, $33, $28, $28, $27, $B5
    db $F0

Data_00B_56F5:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $36, $90, $33, $35, $28, $3C, $90, $38, $31, $27, $28, $35
    db $F1, $37, $2B, $28, $90, $2A, $35, $32, $38, $31, $27, $B5, $F0

Data_00B_5712:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $26, $24, $37, $37, $28, $35, $36, $90, $27, $38, $36, $37, $90, $37, $32
    db $F1, $26, $32, $31, $29, $38, $36, $28, $90, $29, $32, $28, $36, $B5, $F0

Data_00B_5731:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $29, $2F, $32, $3A, $28, $35, $90, $2A, $35, $28, $3A, $90, $32, $31
    db $37, $32, $F1, $2C, $37, $90, $3A, $2B, $2C, $2F, $28, $90, $2C, $31, $90, $36
    db $32, $2C, $2F, $B5, $F0

Data_00B_5756:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $31, $36, $37, $35, $2C, $26, $37, $36, $90, $29, $32, $28, $36, $F1
    db $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $25, $32, $27, $3C, $B5, $F0

Data_00B_5775:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $2F, $2C, $33, $36, $90, $26, $32, $31, $26, $28, $24, $2F
    db $90, $24, $F1, $2F, $32, $31, $2A, $90, $37, $32, $31, $2A, $38, $28, $B5, $F0

Data_00B_5795:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $2B, $24, $35, $27, $90, $36, $2B, $28, $2F, $2F, $F1, $30
    db $24, $2E, $28, $90, $2C, $37, $90, $37, $32, $38, $2A, $2B, $B5, $F0

Data_00B_57B3:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $25, $36, $90, $24, $31, $27, $90, $36, $38, $26, $2E, $36, $F1
    db $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $30, $32, $38, $37, $2B, $B5, $F0

Data_00B_57D3:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $2F, $2F, $AB, $90, $25, $38, $37, $90, $30, $32, $39, $28, $36
    db $F1, $2C, $31, $90, $2F, $24, $35, $2A, $28, $90, $2A, $35, $32, $38, $33, $36
    db $B5, $F0

Data_00B_57F5:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $3A, $24, $3C, $36, $90, $2B, $32, $33, $36, $90, $29, $32, $35, $F1
    db $38, $31, $2E, $31, $32, $3A, $31, $90, $35, $28, $24, $36, $32, $31, $36, $B5
    db $F0

Data_00B_5816:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $37, $28, $36, $90, $38, $36, $2C, $31, $2A, $90, $30, $32, $38, $37
    db $2B, $36, $F1, $32, $31, $90, $25, $32, $37, $2B, $90, $28, $31, $27, $36, $B5
    db $F0

Data_00B_5837:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $2C, $31, $2A, $36, $90, $36, $2C, $27, $28, $90, $37, $32, $F1, $36
    db $2C, $27, $28, $90, $24, $36, $90, $2C, $37, $90, $30, $32, $39, $28, $36, $B5
    db $F0

Data_00B_5858:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $2C, $30, $25, $36, $90, $3A, $24, $2F, $2F, $36, $90, $38, $36, $2C
    db $31, $2A, $F1, $2C, $37, $36, $90, $37, $28, $31, $37, $24, $26, $2F, $28, $36
    db $B5, $F0

Data_00B_587A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $2C, $29, $2F, $28, $36, $90, $29, $32, $28, $36, $90, $3A, $2C, $37
    db $2B, $F1, $2C, $37, $36, $90, $2F, $24, $35, $2A, $28, $90, $3A, $2C, $31, $2A
    db $36, $B5, $F0

Data_00B_589D:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $28, $3C, $28, $36, $90, $28, $3B, $37, $28, $31, $27, $90
    db $37, $32, $F1, $36, $33, $32, $37, $90, $29, $24, $35, $9C, $32, $29, $29, $90
    db $29, $32, $28, $36, $B5, $F0

Data_00B_58C3:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $26, $2F, $24, $3A, $36, $90, $26, $24, $31, $41, $F1, $31
    db $2C, $26, $2E, $90, $37, $2B, $28, $90, $36, $2B, $28, $2F, $2F, $B5, $F0

Data_00B_58E2:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $37, $24, $2C, $2F, $90, $36, $37, $2C, $31, $2A, $28, $35
    db $F1, $2C, $36, $90, $37, $2B, $28, $90, $29, $2C, $31, $2C, $36, $2B, $28, $35
    db $B5, $F0

Data_00B_5904:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $2F, $32, $38, $27, $90, $25, $38, $3D, $3D, $2C, $31, $2A
    db $F1, $2A, $2C, $39, $28, $36, $90, $2C, $37, $90, $24, $3A, $24, $3C, $B5, $F0

Data_00B_5924:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $25, $36, $90, $24, $31, $27, $90, $2B, $24, $26, $2E, $36, $F1
    db $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $36, $26, $3C, $37, $2B, $28, $36
    db $B5, $F0

Data_00B_5946:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $2B, $32, $35, $31, $90, $2C, $36, $90, $38, $36, $28, $27
    db $F1, $37, $32, $90, $2B, $2C, $37, $90, $24, $31, $27, $90, $33, $24, $35, $35
    db $3C, $B5, $F0

Data_00B_5969:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $36, $2C, $26, $2E, $2F, $28, $36, $90, $24, $35, $28, $90
    db $24, $36, $F1, $2F, $24, $35, $2A, $28, $90, $24, $36, $90, $2C, $37, $36, $90
    db $25, $32, $27, $3C, $B5, $F0

Data_00B_598F:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $36, $37, $2C, $31, $2A, $28, $35, $90, $2C, $36, $90, $24
    db $F1, $29, $2C, $28, $35, $26, $28, $90, $3A, $28, $24, $33, $32, $31, $B5, $F0

Data_00B_59AF:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $36, $2F, $2C, $2E, $28, $36, $90, $3A, $24, $37, $28, $35, $90, $24
    db $31, $27, $F1, $2F, $2C, $39, $28, $36, $90, $2C, $31, $90, $36, $32, $2C, $2F
    db $B5, $F0

Data_00B_59D1:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $33, $24, $25, $2F, $28, $90, $32, $29, $90, $30, $32, $39, $2C, $31
    db $2A, $F1, $2C, $31, $90, $24, $31, $3C, $90, $27, $2C, $35, $28, $26, $37, $2C
    db $32, $31, $B5, $F0

Data_00B_59F5:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $30, $24, $31, $3C, $90, $28, $3C, $28, $36, $90, $27, $32
    db $31, $41, $F1, $30, $2C, $36, $36, $90, $24, $90, $37, $2B, $2C, $31, $2A, $B5
    db $F0

Data_00B_5A16:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $29, $28, $35, $36, $90, $30, $2C, $36, $26, $2B, $2C, $28, $29
    db $F1, $32, $39, $28, $35, $90, $28, $24, $37, $2C, $31, $2A, $B5, $F0

Data_00B_5A34:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $37, $28, $31, $37, $24, $26, $2F, $28, $36, $90, $24, $35
    db $28, $F1, $24, $26, $37, $38, $24, $2F, $2F, $3C, $90, $36, $31, $24, $2E, $28
    db $36, $B5, $F0

Data_00B_5A57:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $37, $28, $36, $90, $2A, $28, $37, $37, $2C, $31, $2A, $90, $2C, $37
    db $36, $F1, $3A, $2B, $2C, $37, $28, $90, $29, $38, $35, $90, $27, $2C, $35, $37
    db $3C, $B5, $F0

Data_00B_5A7A:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $37, $28, $2F, $2F, $2C, $2A, $28, $31, $37, $AB, $90, $25, $38, $37
    db $F1, $29, $24, $35, $90, $37, $32, $32, $90, $29, $35, $24, $2C, $2F, $B5, $F0

Data_00B_5A9A:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $37, $28, $31, $37, $24, $26, $2F, $28, $36, $90, $24, $35
    db $28, $F1, $37, $2C, $33, $33, $28, $27, $90, $3A, $2C, $37, $2B, $90, $28, $3C
    db $28, $36, $B5, $F0

Data_00B_5ABE:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $28, $3C, $28, $90, $2B, $24, $36, $90, $24, $90, $03, $06
    db $00, $9C, $F1, $27, $28, $2A, $35, $28, $28, $90, $26, $32, $39, $28, $35, $24
    db $2A, $28, $B5, $F0

Data_00B_5AE2:: ; heuristic: target of a monotone pointer table; C0
    db $17, $28, $39, $28, $35, $90, $27, $2C, $36, $30, $32, $38, $31, $37, $36, $F1
    db $29, $35, $32, $30, $90, $37, $2B, $28, $90, $36, $2E, $38, $2F, $2F, $B5, $F0

Data_00B_5B02:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $37, $2C, $30, $2C, $27, $24, $37, $28, $36, $90, $3A, $2C, $37, $2B
    db $F1, $35, $28, $27, $AB, $90, $2A, $2F, $24, $35, $2C, $31, $2A, $90, $28, $3C
    db $28, $36, $B5, $F0

Data_00B_5B26:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $29, $32, $24, $30, $90, $2F, $28, $37, $36, $90, $2C, $37
    db $F1, $27, $32, $27, $2A, $28, $90, $24, $37, $37, $24, $26, $2E, $36, $B5, $F0

Data_00B_5B46:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $2F, $2F, $AB, $90, $25, $38, $37, $90, $27, $28, $24, $27, $2F
    db $3C, $F1, $3A, $2C, $37, $2B, $90, $36, $33, $28, $2F, $2F, $36, $B5, $F0

Data_00B_5B65:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $2C, $28, $36, $90, $2C, $31, $26, $35, $28, $27, $2C, $25, $2F, $3C
    db $F1, $29, $24, $36, $37, $90, $2C, $31, $90, $30, $2C, $36, $26, $2B, $2C, $28
    db $29, $B5, $F0

Data_00B_5B88:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $25, $36, $90, $29, $32, $28, $36, $90, $37, $2B, $35, $32, $38
    db $2A, $2B, $F1, $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $37, $35, $2C, $27
    db $28, $31, $37, $B5, $F0

Data_00B_5BAD:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $39, $28, $36, $90, $37, $32, $90, $29, $2C, $2A, $2B, $37, $AB, $F1
    db $27, $28, $29, $28, $24, $37, $2C, $31, $2A, $90, $24, $2F, $2F, $B5, $F0

Data_00B_5BCC:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $3C, $36, $90, $35, $28, $27, $9C, $29, $24, $26, $28, $27, $F1
    db $29, $35, $32, $30, $90, $36, $37, $35, $24, $2C, $31, $2C, $31, $2A, $B5, $F0

Data_00B_5BEC:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $36, $33, $28, $24, $35, $90, $2C, $36, $F1, $2F, $24, $35
    db $2A, $28, $2F, $3C, $90, $29, $32, $35, $90, $36, $2B, $32, $3A, $B5, $F0

Data_00B_5C0B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $2C, $31, $2A, $36, $90, $36, $33, $2C, $2E, $28, $27, $90, $32, $35
    db $25, $36, $F1, $37, $32, $90, $2E, $28, $28, $33, $90, $29, $32, $28, $36, $90
    db $24, $3A, $24, $3C, $B5, $F0

Data_00B_5C31:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $27, $28, $36, $90, $24, $31, $27, $90, $36, $37, $35, $2C, $2E, $28
    db $36, $F1, $2C, $31, $90, $27, $24, $35, $2E, $31, $28, $36, $36, $B5, $F0

Data_00B_5C50:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $36, $28, $36, $90, $2C, $37, $36, $90, $24, $2A, $2C, $2F, $2C, $37, $3C
    db $F1, $37, $32, $90, $26, $32, $31, $29, $32, $38, $31, $27, $90, $29, $32, $28
    db $36, $B5, $F0

Data_00B_5C73:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $28, $31, $90, $2C, $37, $36, $90, $2B, $28, $24, $27, $90, $2C, $36
    db $F1, $29, $38, $2F, $2F, $90, $32, $29, $90, $30, $38, $36, $26, $2F, $28, $36
    db $B5, $F0

Data_00B_5C95:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $2B, $32, $35, $31, $90, $24, $31, $27, $90, $29, $24, $31
    db $2A, $36, $F1, $24, $35, $28, $90, $2C, $37, $36, $90, $3A, $28, $24, $33, $32
    db $31, $36, $B5, $F0

Data_00B_5CB9:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $35, $32, $31, $2A, $B5, $90, $13, $38, $36, $37, $F1, $2C, $31, $26
    db $35, $28, $27, $2C, $25, $2F, $3C, $90, $36, $32, $B5, $F0

Data_00B_5CD5:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $24, $37, $90, $37, $2B, $28, $90, $24, $35, $30, $32, $35, $F1, $2B
    db $2C, $27, $28, $36, $90, $2C, $36, $90, $38, $31, $2E, $31, $32, $3A, $31, $B5
    db $F0

Data_00B_5CF6:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $2C, $37, $36, $90, $2C, $31, $90, $3A, $28, $2F, $2F, $36, $90, $29
    db $32, $35, $F1, $33, $35, $28, $3C, $90, $37, $32, $90, $26, $32, $30, $28, $B5
    db $F0

Data_00B_5D17:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $2C, $31, $2A, $36, $90, $29, $32, $35, $90, $37, $2B, $28, $F1, $29
    db $32, $28, $3E, $90, $3A, $28, $24, $2E, $90, $36, $33, $32, $37, $36, $B5, $F0

Data_00B_5D37:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $35, $33, $35, $2C, $36, $2C, $31, $2A, $2F, $3C, $90, $24, $2A, $2C
    db $2F, $28, $F1, $29, $32, $35, $90, $2C, $37, $36, $90, $2B, $28, $29, $37, $2C
    db $31, $28, $36, $36, $B5, $F0

Data_00B_5D5D:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $24, $35, $30, $32, $35, $90, $2A, $2C, $39, $28, $36, $90
    db $2C, $37, $F1, $2A, $35, $28, $24, $37, $90, $33, $32, $3A, $28, $35, $B5, $F0

Data_00B_5D7D:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $24, $26, $2E, $36, $90, $29, $32, $28, $36, $F1, $3A, $2C, $37, $2B
    db $90, $37, $2B, $35, $28, $28, $90, $28, $3C, $28, $36, $B5, $F0

Data_00B_5D9A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $28, $2E, $36, $90, $32, $38, $37, $90, $25, $24, $37, $37, $2F, $28
    db $36, $F1, $29, $32, $35, $90, $28, $31, $2D, $32, $3C, $30, $28, $31, $37, $B5
    db $F0

Data_00B_5DBB:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $28, $31, $90, $28, $31, $35, $24, $2A, $28, $27, $AB, $90, $37, $2B
    db $28, $F1, $2B, $32, $35, $31, $36, $90, $36, $37, $35, $24, $2C, $2A, $2B, $37
    db $28, $31, $B5, $F0

Data_00B_5DDF:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $26, $35, $38, $28, $2F, $90, $27, $28, $30, $32, $31, $90, $37, $2B
    db $24, $37, $F1, $27, $2C, $36, $37, $32, $35, $37, $36, $90, $3A, $2C, $36, $2B
    db $28, $36, $B5, $F0

Data_00B_5E03:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $27, $28, $36, $90, $2C, $31, $90, $24, $31, $27, $90, $32, $38, $37
    db $F1, $37, $32, $90, $36, $26, $24, $35, $28, $90, $33, $28, $32, $33, $2F, $28
    db $B5, $F0

Data_00B_5E25:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $24, $37, $28, $27, $90, $29, $35, $32, $30, $90, $37, $2B, $28
    db $F1, $25, $32, $31, $28, $36, $90, $32, $29, $90, $27, $35, $24, $2A, $32, $31
    db $36, $B5, $F0

Data_00B_5E48:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $2C, $36, $31, $41, $90, $25, $32, $37, $2B, $28, $35, $28, $27
    db $F1, $25, $3C, $90, $31, $28, $3A, $90, $2C, $31, $2D, $38, $35, $2C, $28, $36
    db $B5, $F0

Data_00B_5E6A:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $36, $90, $36, $37, $35, $24, $2A, $2A, $2F, $28, $35, $36
    db $F1, $32, $29, $29, $90, $37, $32, $90, $27, $28, $24, $37, $2B, $B5, $F0

Data_00B_5E89:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $31, $27, $24, $2A, $28, $36, $90, $32, $25, $36, $26, $38, $35, $28
    db $F1, $2C, $37, $36, $90, $39, $2C, $36, $2C, $32, $31, $90, $25, $24, $27, $2F
    db $3C, $B5, $F0

Data_00B_5EAC:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $27, $24, $35, $2E, $90, $36, $32, $38, $2F, $F1, $36, $37
    db $24, $2C, $31, $28, $27, $90, $2C, $37, $36, $90, $25, $32, $27, $3C, $B5, $F0

Data_00B_5ECC:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $31, $24, $25, $2F, $28, $90, $37, $32, $90, $36, $37, $32, $33, $F1, $29
    db $2C, $2A, $2B, $37, $2C, $31, $2A, $90, $2C, $31, $90, $27, $28, $24, $37, $2B
    db $B5, $F0

Data_00B_5EEE:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $2F, $32, $36, $37, $90, $2C, $37, $36, $90, $25, $32, $27, $3C
    db $F1, $27, $38, $28, $90, $37, $32, $90, $30, $24, $2A, $2C, $26, $B5, $F0

Data_00B_5F0D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $26, $2E, $36, $90, $36, $2C, $27, $28, $90, $37, $32, $90, $36, $2C
    db $27, $28, $F1, $24, $36, $90, $2C, $37, $90, $24, $33, $33, $35, $32, $24, $26
    db $2B, $28, $36, $B5, $F0

Data_00B_5F32:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $27, $AB, $90, $35, $32, $37, $37, $28, $31, $AB, $90, $24, $31
    db $27, $F1, $31, $32, $37, $90, $24, $37, $90, $33, $28, $24, $26, $28, $B5, $F0

Data_00B_5F52:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $32, $32, $37, $36, $90, $27, $2C, $35, $37, $90, $29, $35, $32, $30
    db $F1, $24, $2F, $2F, $90, $32, $39, $28, $35, $90, $2C, $37, $36, $90, $25, $32
    db $27, $3C, $B5, $F0

Data_00B_5F76:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $33, $24, $25, $2F, $28, $90, $32, $29, $90, $2A, $32, $2C, $31, $2A
    db $F1, $37, $2B, $35, $32, $38, $2A, $2B, $90, $3A, $24, $2F, $2F, $36, $B5, $F0

Data_00B_5F96:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $36, $2B, $3C, $90, $36, $32, $38, $2F, $AB, $90, $2C, $37, $F1, $36
    db $3A, $24, $27, $27, $2F, $28, $36, $90, $2C, $37, $36, $90, $25, $32, $27, $3C
    db $B5, $F0

Data_00B_5FB8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $28, $24, $2E, $36, $90, $38, $33, $90, $32, $31, $90, $29, $32, $28
    db $36, $F1, $29, $35, $32, $30, $90, $25, $28, $2B, $2C, $31, $27, $B5, $F0

Data_00B_5FD7:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $2F, $2C, $30, $25, $36, $90, $3A, $28, $35, $28, $F1, $30
    db $2C, $3B, $28, $27, $90, $38, $33, $90, $2C, $31, $90, $27, $28, $24, $37, $2B
    db $B5, $F0

Data_00B_5FF9:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $26, $32, $2F, $2F, $24, $35, $90, $32, $29, $90, $29, $2C
    db $35, $28, $F1, $2C, $36, $90, $38, $36, $28, $27, $90, $37, $32, $90, $24, $37
    db $37, $24, $26, $2E, $B5, $F0

Data_00B_601F:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $24, $35, $30, $36, $90, $3A, $28, $35, $28, $90, $30, $24
    db $27, $28, $F1, $2C, $31, $37, $32, $90, $3A, $28, $24, $33, $32, $31, $36, $B5
    db $F0

Data_00B_6040:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $37, $24, $2C, $31, $36, $90, $2C, $37, $36, $90, $31, $32, $25, $2F
    db $28, $F1, $31, $24, $37, $38, $35, $28, $90, $2C, $31, $90, $27, $28, $24, $37
    db $2B, $B5, $F0

Data_00B_6063:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $26, $24, $30, $28, $90, $24, $90, $3D, $32, $30, $25, $2C, $28, $F1
    db $3A, $2B, $2C, $2F, $28, $90, $36, $37, $2C, $2F, $2F, $90, $24, $2F, $2C, $39
    db $28, $B5, $F0

Data_00B_6086:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $2F, $2F, $90, $31, $28, $39, $28, $35, $90, $25, $28, $F1, $29, $35
    db $28, $28, $27, $90, $2C, $31, $90, $27, $28, $24, $37, $2B, $B5, $F0

Data_00B_60A4:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $24, $36, $2B, $28, $36, $90, $35, $28, $33, $28, $24, $37, $28, $27
    db $2F, $3C, $F1, $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $36, $2C, $3B, $90
    db $24, $35, $30, $36, $B5, $F0

Data_00B_60CA:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $29, $32, $38, $35, $90, $24, $35, $30, $36, $90, $30, $32
    db $39, $28, $F1, $2C, $31, $27, $28, $33, $28, $31, $27, $28, $31, $37, $2F, $3C
    db $B5, $F0

Data_00B_60EC:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $37, $28, $26, $37, $36, $90, $2C, $37, $36, $90, $2B, $28, $24
    db $27, $F1, $3A, $2C, $37, $2B, $90, $25, $32, $37, $2B, $90, $2B, $24, $31, $27
    db $36, $B5, $F0

Data_00B_610F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $32, $3A, $36, $90, $27, $28, $27, $2C, $26, $24, $37, $2C, $32, $31
    db $F1, $37, $32, $90, $2C, $37, $36, $90, $30, $2C, $30, $2C, $26, $35, $3C, $B5
    db $F0

Data_00B_6130:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $31, $27, $28, $35, $2C, $31, $2A, $90, $36, $32, $38, $2F, $36, $F1
    db $2A, $24, $37, $2B, $28, $35, $28, $27, $90, $24, $36, $90, $32, $31, $28, $B5
    db $F0

Data_00B_6151:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $37, $2B, $32, $38, $2A, $2B, $37, $36, $90, $24, $35, $28
    db $F1, $38, $31, $29, $24, $37, $2B, $32, $30, $24, $25, $2F, $28, $B5, $F0

Data_00B_6170:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $33, $35, $32, $38, $27, $90, $24, $31, $27, $90, $36, $37, $35, $32
    db $31, $2A, $F1, $3D, $32, $30, $25, $2C, $28, $90, $36, $3A, $32, $35, $27, $36
    db $30, $24, $31, $B5, $F0

Data_00B_6195:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $36, $90, $2C, $29, $90, $2C, $37, $90, $36, $33, $32
    db $37, $36, $F1, $24, $31, $3C, $37, $2B, $2C, $31, $2A, $90, $36, $2B, $2C, $31
    db $3C, $B5, $F0

Data_00B_61B8:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $3A, $24, $31, $27, $90, $37, $2B, $24, $37, $90, $36, $33, $2F, $2C
    db $37, $F1, $29, $35, $32, $30, $90, $2C, $37, $36, $90, $30, $24, $2A, $28, $B5
    db $F0

Data_00B_61D9:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $2F, $2F, $36, $90, $24, $36, $2F, $28, $28, $33, $90, $2C, $29, $F1
    db $37, $2B, $28, $90, $29, $2F, $24, $30, $28, $90, $27, $2C, $28, $36, $B5, $F0

Data_00B_61F9:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $3A, $2C, $31, $27, $9C, $38, $33, $90, $26, $38, $26, $2E, $32, $32
    db $F1, $37, $2B, $24, $37, $90, $2B, $24, $36, $90, $24, $90, $36, $32, $38, $2F
    db $B5, $F0

Data_00B_621B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $27, $28, $90, $32, $29, $90, $3A, $32, $32, $27, $90, $37, $2B, $24
    db $37, $F1, $2C, $36, $90, $01, $00, $00, $00, $90, $3C, $28, $24, $35, $36, $90
    db $32, $2F, $27, $B5, $F0

Data_00B_6240:: ; heuristic: target of a monotone pointer table; C0
    db $18, $31, $28, $90, $32, $29, $90, $2C, $37, $36, $90, $36, $33, $2C, $2E, $28
    db $36, $F1, $36, $28, $37, $36, $90, $32, $29, $29, $90, $24, $90, $25, $32, $30
    db $25, $B5, $F0

Data_00B_6263:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $24, $33, $36, $90, $29, $32, $28, $36, $90, $3A, $2C, $37, $2B, $2C
    db $31, $F1, $2C, $37, $36, $90, $35, $28, $29, $2F, $28, $26, $37, $2C, $32, $31
    db $B5, $F0

Data_00B_6285:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $32, $32, $30, $28, $27, $90, $37, $32, $90, $3A, $24, $31, $27, $28, $35
    db $F1, $24, $31, $27, $90, $35, $32, $24, $30, $90, $29, $32, $35, $28, $39, $28
    db $35, $B5, $F0

Data_00B_62A8:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $31, $37, $35, $32, $2F, $36, $90, $2C, $37, $36, $28, $2F, $29, $F1
    db $3A, $2C, $37, $2B, $90, $36, $37, $35, $2C, $31, $2A, $36, $B5, $F0

Data_00B_62C6:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $36, $90, $29, $32, $28, $36, $90, $2C, $31, $37, $32, $F1
    db $30, $38, $27, $90, $3A, $2C, $37, $2B, $90, $32, $37, $2B, $28, $35, $36, $B5
    db $F0

Data_00B_62E7:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $30, $28, $35, $2A, $28, $27, $90, $29, $35, $32, $30, $90, $01, $00, $00
    db $00, $00, $F1, $3C, $28, $24, $35, $36, $90, $32, $29, $90, $36, $2F, $28, $28
    db $33, $B5, $F0

Data_00B_630A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $29, $38, $2F, $2F, $3C, $90, $30, $28, $26, $2B, $24, $31, $2C, $26
    db $24, $2F, $F1, $27, $35, $24, $2A, $32, $31, $B5, $F0

Data_00B_6325:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $32, $3A, $AB, $90, $36, $32, $90, $2C, $37, $90, $35, $28, $2F, $2C
    db $28, $36, $F1, $32, $31, $90, $33, $32, $3A, $28, $35, $90, $36, $30, $24, $36
    db $2B, $28, $36, $B5, $F0

Data_00B_634A:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $28, $24, $35, $36, $90, $30, $28, $24, $37, $90, $3A, $2C, $37, $2B, $F1
    db $2C, $37, $36, $90, $2B, $28, $24, $27, $90, $24, $31, $27, $90, $28, $24, $37
    db $36, $B5, $F0

Data_00B_636D:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $32, $3A, $36, $90, $26, $32, $31, $29, $38, $36, $2C, $31, $2A, $F1
    db $36, $30, $32, $2E, $28, $90, $3A, $2B, $28, $31, $90, $25, $38, $29, $29, $28
    db $27, $B5, $F0

Data_00B_6390:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $38, $36, $2B, $28, $36, $90, $29, $32, $28, $36, $90, $38, $31, $37
    db $2C, $2F, $F1, $37, $2B, $28, $3C, $90, $37, $38, $35, $31, $90, $24, $2F, $2F
    db $90, $35, $28, $27, $B5, $F0

Data_00B_63B6:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $37, $37, $2F, $28, $36, $90, $38, $31, $37, $2C, $2F, $90, $2C, $37
    db $F1, $2C, $36, $90, $29, $38, $2F, $2F, $3C, $90, $3A, $35, $28, $26, $2E, $28
    db $27, $B5, $F0

Data_00B_63D9:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $37, $37, $2F, $28, $36, $90, $36, $24, $39, $24, $2A, $28, $2F, $3C
    db $F1, $3A, $2C, $37, $2B, $32, $38, $37, $90, $30, $28, $35, $26, $3C, $B5, $F0

Data_00B_63F9:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $37, $28, $36, $90, $3A, $2B, $32, $28, $39, $28, $35, $F1, $33, $28
    db $28, $35, $36, $90, $2C, $31, $36, $2C, $27, $28, $B5, $F0

Data_00B_6415:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $36, $26, $28, $31, $27, $36, $90, $29, $35, $32, $30, $90, $37, $2B
    db $28, $F1, $36, $2E, $3C, $90, $37, $32, $90, $36, $28, $28, $2E, $90, $33, $35
    db $28, $3C, $B5, $F0

Data_00B_6439:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $2A, $2C, $24, $31, $37, $90, $37, $2B, $24, $37, $90, $26, $24, $2E
    db $28, $27, $F1, $2C, $37, $36, $28, $2F, $29, $90, $3A, $2C, $37, $2B, $90, $30
    db $24, $2A, $30, $24, $B5, $F0

Data_00B_645F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $2A, $2C, $24, $31, $37, $90, $37, $2B, $24, $37, $90, $26, $24, $2E
    db $28, $27, $F1, $2C, $37, $36, $28, $2F, $29, $90, $3A, $2C, $37, $2B, $90, $2C
    db $26, $28, $B5, $F0

Data_00B_6483:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $25, $2C, $37, $28, $36, $90, $38, $31, $3A, $24, $35, $3C, $F1
    db $37, $35, $28, $24, $36, $38, $35, $28, $90, $2B, $38, $31, $37, $28, $35, $36
    db $B5, $F0

Data_00B_64A5:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $2E, $28, $9C, $30, $2C, $31, $27, $28, $27, $90, $33, $2F, $24, $37
    db $28, $36, $F1, $25, $28, $26, $24, $30, $28, $90, $24, $90, $30, $32, $31, $36
    db $37, $28, $35, $B5, $F0

Data_00B_64CA:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $25, $32, $27, $3C, $90, $27, $35, $2C, $28, $36, $90, $2C
    db $29, $F1, $2C, $37, $90, $36, $37, $32, $33, $36, $90, $27, $24, $31, $26, $2C
    db $31, $2A, $B5, $F0

Data_00B_64EE:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $25, $32, $27, $3C, $90, $26, $35, $24, $26, $2E, $36, $90
    db $2C, $29, $F1, $2C, $37, $90, $37, $35, $2C, $28, $36, $90, $37, $32, $90, $37
    db $24, $2F, $2E, $B5, $F0

Data_00B_6513:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $25, $32, $27, $3C, $90, $25, $35, $28, $24, $2E, $36, $90
    db $2C, $29, $F1, $2C, $37, $90, $36, $37, $32, $33, $36, $90, $30, $32, $39, $2C
    db $31, $2A, $B5, $F0

Data_00B_6537:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3B, $33, $2F, $32, $27, $28, $36, $90, $3A, $2C, $37, $2B, $32, $38, $37
    db $F1, $3A, $24, $35, $31, $2C, $31, $2A, $90, $32, $31, $90, $3A, $24, $2E, $2C
    db $31, $2A, $B5, $F0

Data_00B_655B:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $38, $27, $90, $32, $29, $90, $2C, $37, $36, $90, $25, $2C, $2A
    db $AB, $F1, $2A, $32, $2F, $27, $28, $31, $90, $25, $32, $27, $3C, $B5, $F0

Data_00B_657A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $28, $36, $90, $29, $32, $28, $36, $90, $27, $2C, $3D, $3D, $3C
    db $F1, $25, $3C, $90, $35, $32, $37, $24, $37, $2C, $31, $2A, $B5, $F0

Data_00B_6598:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $32, $36, $37, $28, $35, $3E, $90, $33, $35, $32, $37, $32, $9C
    db $F1, $37, $3C, $33, $28, $AB, $90, $25, $38, $37, $90, $37, $32, $38, $2A, $2B
    db $B5, $F0

Data_00B_65BA:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $2D, $38, $27, $2A, $28, $90, $24, $30, $32, $31, $2A, $F1, $30, $32
    db $31, $36, $37, $28, $35, $36, $B5, $F0

Data_00B_65D2:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $2F, $2F, $AB, $90, $36, $2F, $2C, $33, $33, $28, $35, $3C, $F1
    db $24, $31, $27, $90, $2B, $24, $35, $27, $90, $37, $32, $90, $2B, $2C, $37, $B5
    db $F0

Data_00B_65F3:: ; heuristic: target of a monotone pointer table; C0
    db $12, $30, $30, $32, $25, $2C, $2F, $2C, $3D, $28, $36, $90, $29, $32, $28, $36
    db $F1, $37, $2B, $28, $31, $90, $25, $2C, $37, $28, $36, $90, $37, $2B, $28, $30
    db $B5, $F0

Data_00B_6615:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $37, $36, $90, $32, $31, $90, $29, $32, $28, $36, $90, $24, $31, $27
    db $F1, $33, $38, $30, $30, $28, $2F, $36, $90, $37, $2B, $28, $30, $B5, $F0

Data_00B_6634:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $29, $29, $32, $26, $24, $37, $28, $36, $90, $29, $32, $28, $36, $F1
    db $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $25, $32, $27, $3C, $B5, $F0

Data_00B_6653:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $35, $28, $36, $90, $29, $32, $28, $36, $90, $3A, $2C, $37, $2B
    db $F1, $2C, $37, $36, $90, $37, $28, $31, $37, $24, $26, $2F, $28, $36, $B5, $F0

Data_00B_6673:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3B, $33, $24, $31, $27, $36, $90, $2C, $37, $36, $90, $25, $32, $27, $3C
    db $F1, $37, $32, $90, $36, $37, $24, $35, $37, $2F, $28, $90, $29, $32, $28, $36
    db $B5, $F0

Data_00B_6695:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $29, $2C, $36, $2B, $90, $37, $2B, $24, $37, $90, $2C, $36, $90, $24
    db $36, $F1, $36, $30, $24, $35, $37, $90, $24, $36, $90, $33, $28, $32, $33, $2F
    db $28, $B5, $F0

Data_00B_66B8:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $30, $32, $31, $36, $37, $28, $35, $90, $37, $2B, $24, $37, $90, $2A
    db $32, $37, $F1, $36, $37, $38, $26, $2E, $90, $2C, $31, $90, $24, $90, $37, $35
    db $24, $33, $B5, $F0

Data_00B_66DC:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $24, $35, $30, $36, $90, $24, $31, $27, $90, $28, $24, $37, $36, $F1
    db $29, $32, $28, $36, $90, $2C, $31, $36, $37, $24, $31, $37, $2F, $3C, $B5, $F0

Data_00B_66FC:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $36, $2B, $32, $35, $37, $90, $2F, $28, $2A, $36, $F1, $30
    db $24, $2E, $28, $90, $2C, $37, $90, $36, $2F, $38, $2A, $2A, $2C, $36, $2B, $B5
    db $F0

Data_00B_671D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $35, $24, $26, $37, $36, $90, $33, $35, $28, $3C, $90, $3A, $2C
    db $37, $2B, $F1, $24, $90, $2F, $2C, $2A, $2B, $37, $28, $27, $90, $24, $31, $37
    db $28, $31, $31, $24, $B5, $F0

Data_00B_6743:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $27, $28, $30, $32, $31, $90, $37, $2B, $24, $37, $90, $35, $2C, $27
    db $28, $36, $F1, $24, $90, $29, $2C, $36, $2B, $90, $2C, $31, $90, $25, $24, $37
    db $37, $2F, $28, $B5, $F0

Data_00B_6768:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $2C, $30, $36, $90, $36, $37, $35, $24, $2C, $2A, $2B, $37, $90, $37
    db $32, $F1, $35, $24, $30, $90, $24, $37, $90, $2B, $2C, $2A, $2B, $90, $36, $33
    db $28, $28, $27, $B5, $F0

Data_00B_678D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $2C, $33, $36, $90, $37, $2B, $35, $32, $38, $2A, $2B, $F1, $3A, $24
    db $37, $28, $35, $90, $2F, $2C, $2E, $28, $90, $24, $90, $29, $35, $32, $2A, $B5
    db $F0

Data_00B_67AE:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $33, $2C, $31, $26, $28, $35, $36, $90, $26, $24, $31, $F1
    db $26, $38, $37, $90, $2C, $37, $36, $90, $32, $3A, $31, $90, $36, $2B, $28, $2F
    db $2F, $B5, $F0

Data_00B_67D1:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $33, $2C, $31, $26, $28, $35, $36, $90, $24, $35, $28, $F1
    db $36, $2B, $24, $35, $33, $AB, $90, $25, $38, $37, $90, $2B, $28, $24, $39, $3C
    db $B5, $F0

Data_00B_67F3:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $32, $3A, $31, $36, $90, $29, $32, $28, $36, $90, $2C, $31, $36, $2C
    db $27, $28, $F1, $2C, $37, $36, $90, $37, $38, $35, $25, $2C, $27, $90, $25, $32
    db $27, $3C, $B5, $F0

Data_00B_6817:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $36, $2B, $28, $2F, $2F, $90, $2C, $36, $F1, $37, $32, $38
    db $2A, $2B, $90, $37, $32, $90, $32, $33, $28, $31, $B5, $F0

Data_00B_6833:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $30, $24, $2C, $31, $36, $90, $38, $33, $35, $2C, $2A, $2B, $37, $F1
    db $28, $39, $28, $31, $90, $3A, $2B, $28, $31, $90, $24, $36, $2F, $28, $28, $33
    db $B5, $F0

Data_00B_6855:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $27, $28, $36, $90, $2C, $37, $36, $90, $38, $2A, $2F, $3C, $F1, $25
    db $32, $27, $3C, $90, $2C, $31, $90, $24, $90, $2B, $32, $32, $27, $B5, $F0

Data_00B_6874:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $30, $33, $24, $2A, $28, $36, $90, $2C, $31, $90, $37, $2B, $28, $F1
    db $36, $28, $24, $90, $3A, $2C, $37, $2B, $90, $36, $3A, $32, $35, $27, $36, $B5
    db $F0

Data_00B_6895:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $28, $24, $39, $28, $36, $90, $29, $32, $28, $36, $90, $2C, $31, $F1
    db $37, $3A, $32, $90, $3A, $2C, $37, $2B, $90, $2C, $37, $36, $90, $24, $3B, $B5
    db $F0

Data_00B_68B6:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $35, $28, $2F, $3C, $90, $36, $28, $28, $31, $90, $24, $36, $90, $2C
    db $37, $F1, $2B, $2C, $27, $28, $36, $90, $2C, $31, $90, $27, $28, $33, $37, $2B
    db $36, $B5, $F0

Data_00B_68D9:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $33, $2C, $37, $36, $90, $24, $90, $2B, $38, $2A, $28, $90, $26, $2F, $32
    db $38, $27, $F1, $32, $29, $90, $32, $25, $36, $26, $38, $35, $2C, $31, $2A, $90
    db $2C, $31, $2E, $B5, $F0

Data_00B_68FE:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $2C, $29, $37, $36, $90, $24, $2F, $32, $31, $2A, $90, $3A, $2C, $37
    db $2B, $F1, $27, $28, $28, $33, $9C, $36, $28, $24, $90, $26, $38, $35, $35, $28
    db $31, $37, $36, $B5, $F0

Data_00B_6923:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $3A, $24, $31, $27, $90, $2C, $31, $27, $2C, $26, $24, $37
    db $28, $36, $F1, $30, $24, $2A, $2C, $26, $24, $2F, $90, $33, $32, $3A, $28, $35
    db $B5, $F0

Data_00B_6945:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $35, $28, $B5, $90, $12, $37, $90, $2F, $38, $35, $2E, $36, $F1, $32
    db $31, $2F, $3C, $90, $2C, $31, $90, $27, $28, $28, $33, $90, $36, $28, $24, $36
    db $B5, $F0

Data_00B_6967:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $36, $28, $36, $90, $37, $28, $31, $37, $24, $26, $2F, $28, $36, $90, $37
    db $32, $F1, $2C, $30, $30, $32, $25, $2C, $2F, $2C, $3D, $28, $90, $29, $32, $28
    db $36, $B5, $F0

Data_00B_698A:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $29, $2C, $31, $90, $32, $31, $90, $2C, $37, $36, $F1, $25
    db $24, $26, $2E, $90, $2C, $36, $90, $24, $90, $3A, $28, $24, $33, $32, $31, $B5
    db $F0

Data_00B_69AB:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $37, $2B, $35, $24, $36, $2B, $2C, $31, $2A, $90, $26, $24
    db $31, $F1, $26, $24, $38, $36, $28, $90, $28, $24, $35, $37, $2B, $34, $38, $24
    db $2E, $28, $36, $B5, $F0

Data_00B_69D0:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $32, $24, $37, $36, $90, $39, $24, $26, $24, $31, $37, $2F, $3C, $90
    db $2C, $31, $F1, $37, $2B, $28, $90, $36, $28, $24, $90, $24, $37, $90, $33, $28
    db $24, $26, $28, $B5, $F0

Data_00B_69F5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $2F, $2F, $AB, $90, $25, $38, $37, $90, $26, $24, $33, $24, $25
    db $2F, $28, $F1, $32, $29, $90, $36, $37, $35, $28, $37, $26, $2B, $2C, $31, $2A
    db $B5, $F0

Data_00B_6A17:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $15, $32, $35, $27, $3E, $90, $29, $2C, $35, $36, $37
    db $AB, $F1, $38, $31, $24, $36, $36, $38, $30, $2C, $31, $2A, $90, $29, $32, $35
    db $30, $B5, $F0

Data_00B_6A3A:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $15, $32, $35, $27, $3E, $90, $37, $35, $38, $28, $AB
    db $F1, $33, $32, $3A, $28, $35, $29, $38, $2F, $90, $2C, $27, $28, $31, $37, $2C
    db $37, $3C, $B5, $F0

Data_00B_6A5E:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $15, $32, $35, $27, $3E, $90, $29, $32, $35, $30, $F1
    db $3A, $2B, $28, $31, $90, $28, $31, $35, $24, $2A, $28, $27, $B5, $F0

Data_00B_6A7C:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $90, $28, $39, $2C, $2F, $90, $26, $2F, $28, $35, $2C, $26, $90, $3A
    db $2B, $32, $F1, $26, $24, $31, $90, $38, $36, $28, $90, $24, $31, $3C, $90, $36
    db $33, $28, $2F, $2F, $B5, $F0

Data_00B_6AA2:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $28, $2C, $31, $2A, $90, $27, $28, $27, $2C, $26, $24, $37, $28
    db $27, $F1, $37, $32, $90, $3A, $32, $35, $2F, $27, $90, $26, $2B, $24, $32, $36
    db $B5, $F0

Data_00B_6AC4:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $27, $32, $2B, $90, $35, $28, $25, $32, $35, $31, $90, $29, $32, $35
    db $90, $F1, $37, $32, $37, $24, $2F, $90, $27, $28, $36, $37, $35, $38, $26, $37
    db $2C, $32, $31, $B5, $F0

Data_00B_6AE9:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $35, $27, $36, $90, $32, $39, $28, $35, $90, $24, $2F, $2F, $F1, $27
    db $28, $30, $32, $31, $36, $90, $3A, $2C, $37, $2B, $90, $33, $32, $3A, $28, $35
    db $B5, $F0

Data_00B_6B0B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $0D, $28, $30, $32, $31, $90, $15, $32, $35, $27, $90, $37, $2B, $24
    db $37, $F1, $38, $36, $28, $36, $90, $27, $24, $35, $2E, $90, $33, $32, $3A, $28
    db $35, $36, $B5, $F0

Data_00B_6B2F:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $37, $35, $38, $28, $AB, $90, $29, $2C, $31, $24, $2F, $F1
    db $29, $32, $35, $30, $90, $32, $29, $90, $23, $32, $30, $24, $B5, $F0

Data_00B_6B4D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $28, $2C, $31, $2A, $90, $37, $2B, $24, $37, $90, $36, $28, $28
    db $2E, $36, $F1, $38, $2F, $37, $2C, $30, $24, $37, $28, $90, $33, $32, $3A, $28
    db $35, $B5, $F0

Data_00B_6B70:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $3D, $3D, $24, $35, $32, $3E, $90, $33, $38, $35, $28, $90, $24, $31
    db $27, $F1, $35, $28, $24, $2F, $90, $2A, $38, $2C, $36, $28, $B5, $F0

Data_00B_6B8E:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $27, $2C, $26, $24, $37, $28, $27, $90, $37, $32, $90, $26, $2B, $24
    db $32, $36, $F1, $24, $31, $27, $90, $27, $32, $30, $2C, $31, $24, $37, $2C, $32
    db $31, $B5, $F0

Data_00B_6BB1:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $35, $28, $2F, $3C, $90, $28, $39, $2C, $2F, $90, $24, $31, $27, $F1
    db $27, $2C, $39, $2C, $31, $28, $2F, $3C, $90, $33, $32, $3A, $28, $35, $29, $38
    db $2F, $B5, $F0

Data_00B_6BD4:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $37, $35, $38, $28, $AB, $90, $39, $2C, $2F, $28, $F1, $29
    db $32, $35, $30, $90, $32, $29, $90, $16, $2C, $35, $38, $27, $35, $24, $24, $36
    db $B5, $F0

Data_00B_6BF6:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $0D, $28, $30, $32, $31, $90, $15, $32, $35, $27, $90, $37, $2B, $24
    db $37, $F1, $38, $36, $28, $36, $90, $2C, $2F, $2F, $38, $36, $2C, $32, $31, $36
    db $B5, $F0

Data_00B_6C18:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $0D, $28, $30, $32, $31, $90, $15, $32, $35, $27, $90, $32
    db $29, $F1, $24, $2F, $2F, $90, $3A, $32, $35, $2F, $27, $36, $B5, $F0

Data_00B_6C36:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $37, $35, $38, $28, $AB, $90, $28, $31, $35, $24, $2A, $28
    db $27, $F1, $29, $32, $35, $30, $90, $32, $29, $90, $0D, $28, $24, $37, $2B, $16
    db $32, $35, $28, $B5, $F0

Data_00B_6C5B:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $24, $37, $2B, $16, $32, $35, $28, $3E, $90, $29, $2C, $31, $24, $2F
    db $F1, $28, $39, $32, $2F, $38, $37, $2C, $32, $31, $B5, $F0

Data_00B_6C77:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $28, $2C, $31, $2A, $90, $37, $2B, $24, $37, $F1, $27, $35, $28
    db $24, $30, $36, $90, $32, $29, $90, $27, $28, $24, $37, $2B, $B5, $F0

Data_00B_6C95:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $28, $2F, $28, $2A, $24, $31, $26, $28, $F1, $25, $28, $2F
    db $2C, $28, $36, $90, $2C, $37, $36, $90, $2A, $35, $28, $28, $27, $B5, $F0

Data_00B_6CB4:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $36, $90, $29, $32, $35, $30, $90, $36, $37, $35, $2C, $2E, $28, $36
    db $F1, $37, $28, $35, $35, $32, $35, $90, $2C, $31, $90, $24, $2F, $2F, $B5, $F0

Data_00B_6CD4:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $26, $32, $2F, $2F, $28, $26, $37, $32, $35, $90, $2E, $2C
    db $31, $2A, $F1, $32, $29, $90, $15, $2C, $30, $25, $32, $B5, $F0

Data_00B_6CF1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $30, $28, $F0

Data_00B_6CF7:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2A, $32, $31, $F0

Data_00B_6CFE:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $F0

Data_00B_6D04:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $35, $27, $F0

Data_00B_6D09:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $24, $31, $37, $F0

Data_00B_6D0F:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $2A, $F0

Data_00B_6D13:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $30, $32, $31, $F0

Data_00B_6D19:: ; heuristic: target of a monotone pointer table; C0
    db $23, $32, $30, $25, $2C, $28, $F0

Data_00B_6D20:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $37, $28, $35, $2C, $24, $2F, $F0

Data_00B_6D29:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $28, $35, $F0

Data_00B_6D2F:: ; heuristic: target of a monotone pointer table; C0
    db $98, $98, $98, $98, $F0
    ds $12CC, $00
