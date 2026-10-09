SECTION "Bank 2F", ROMX[$4000], BANK[$2F]
    db $2F

Func_02F_4001::
    ld de, Data_02F_4016
    call Func_000_25C9
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

Func_02F_400F::
    call Func_02F_4001
    call Func_000_2611
    ret

Data_02F_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_02F_4022
    dw Data_02F_4134
    dw Data_02F_4334
    dw Data_02F_433C
    dw Data_02F_433E
    dw Data_02F_4340

Data_02F_4022:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_4384
    dw Data_02F_4393
    dw Data_02F_43A7
    dw Data_02F_43BB
    dw Data_02F_43CF
    dw Data_02F_43E3
    dw Data_02F_43F7
    dw Data_02F_4412
    dw Data_02F_442F
    dw Data_02F_4444
    dw Data_02F_4463
    dw Data_02F_4482
    dw Data_02F_4496
    dw Data_02F_44AD
    dw Data_02F_44C5
    dw Data_02F_44E2
    dw Data_02F_4502
    dw Data_02F_4522
    dw Data_02F_4542
    dw Data_02F_4568
    dw Data_02F_4578
    dw Data_02F_458A
    dw Data_02F_45A2
    dw Data_02F_45B8
    dw Data_02F_45CB
    dw Data_02F_45E2
    dw Data_02F_45F5
    dw Data_02F_460C
    dw Data_02F_4626
    dw Data_02F_4642
    dw Data_02F_4665
    dw Data_02F_4689
    dw Data_02F_46A6
    dw Data_02F_46C5
    dw Data_02F_46E0
    dw Data_02F_46F5
    dw Data_02F_4713
    dw Data_02F_4732
    dw Data_02F_4757
    dw Data_02F_4769
    dw Data_02F_4777
    dw Data_02F_478C
    dw Data_02F_47AE
    dw Data_02F_47C2
    dw Data_02F_47DA
    dw Data_02F_47FE
    dw Data_02F_481E
    dw Data_02F_4839
    dw Data_02F_4856
    dw Data_02F_4869
    dw Data_02F_4884
    dw Data_02F_489F
    dw Data_02F_48B6
    dw Data_02F_48CD
    dw Data_02F_48E9
    dw Data_02F_4915
    dw Data_02F_4941
    dw Data_02F_4973
    dw Data_02F_49AA
    dw Data_02F_49E5
    dw Data_02F_4A20
    dw Data_02F_4A5C
    dw Data_02F_4A96
    dw Data_02F_4ACE
    dw Data_02F_4AFC
    dw Data_02F_4B2E
    dw Data_02F_4B6A
    dw Data_02F_4BA4
    dw Data_02F_4BDB
    dw Data_02F_4C14
    dw Data_02F_4C46
    dw Data_02F_4C7A
    dw Data_02F_4CAE
    dw Data_02F_4CE6
    dw Data_02F_4D11
    dw Data_02F_4D49
    dw Data_02F_4D79
    dw Data_02F_4DA6
    dw Data_02F_4DD4
    dw Data_02F_4E0A
    dw Data_02F_4E38
    dw Data_02F_4E6F
    dw Data_02F_4EAD
    dw Data_02F_4EEB
    dw Data_02F_4F27
    dw Data_02F_4F66
    dw Data_02F_4FA0
    dw Data_02F_4FD5
    dw Data_02F_5010
    dw Data_02F_5041
    dw Data_02F_5080
    dw Data_02F_50BB
    dw Data_02F_50F0
    dw Data_02F_512D
    dw Data_02F_5169
    dw Data_02F_519E
    dw Data_02F_51D6
    dw Data_02F_51F0
    dw Data_02F_5202
    dw Data_02F_5225
    dw Data_02F_524D
    dw Data_02F_5277
    dw Data_02F_5296
    dw Data_02F_52CA
    dw Data_02F_52FC
    dw Data_02F_532D
    dw Data_02F_5361
    dw Data_02F_5393
    dw Data_02F_53C4
    dw Data_02F_5408
    dw Data_02F_5453
    dw Data_02F_54A2
    dw Data_02F_54F0
    dw Data_02F_5534
    dw Data_02F_557F
    dw Data_02F_55CF
    dw Data_02F_5622
    dw Data_02F_5671
    dw Data_02F_56BD
    dw Data_02F_5709
    dw Data_02F_5758
    dw Data_02F_57A4
    dw Data_02F_57F3
    dw Data_02F_583D
    dw Data_02F_5859
    dw Data_02F_587A
    dw Data_02F_5892
    dw Data_02F_58A7
    dw Data_02F_58C8
    dw Data_02F_590E
    dw Data_02F_5958
    dw Data_02F_599F
    dw Data_02F_59EC
    dw Data_02F_5A35
    dw Data_02F_5A82
    dw Data_02F_5A9C
    dw Data_02F_5AB8

Data_02F_4134:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_5AC9
    dw Data_02F_5AD8
    dw Data_02F_5AE6
    dw Data_02F_5AF6
    dw Data_02F_5B04
    dw Data_02F_5B18
    dw Data_02F_5B2B
    dw Data_02F_5B41
    dw Data_02F_5B55
    dw Data_02F_5B6F
    dw Data_02F_5B80
    dw Data_02F_5B94
    dw Data_02F_5BA5
    dw Data_02F_5BB6
    dw Data_02F_5BD0
    dw Data_02F_5BE5
    dw Data_02F_5C19
    dw Data_02F_5C2F
    dw Data_02F_5C45
    dw Data_02F_5C58
    dw Data_02F_5C73
    dw Data_02F_5C89
    dw Data_02F_5CA8
    dw Data_02F_5CC6
    dw Data_02F_5CE1
    dw Data_02F_5D1E
    dw Data_02F_5D5B
    dw Data_02F_5D99
    dw Data_02F_5DAF
    dw Data_02F_5DCB
    dw Data_02F_5DE7
    dw Data_02F_5E10
    dw Data_02F_5E26
    dw Data_02F_5E3A
    dw Data_02F_5E54
    dw Data_02F_5E6F
    dw Data_02F_5E89
    dw Data_02F_5E9D
    dw Data_02F_5EAE
    dw Data_02F_5EDB
    dw Data_02F_5EEF
    dw Data_02F_5F01
    dw Data_02F_5F1E
    dw Data_02F_5F37
    dw Data_02F_5F48
    dw Data_02F_5F63
    dw Data_02F_5F7B
    dw Data_02F_5F98
    dw Data_02F_5FB0
    dw Data_02F_5FCB
    dw Data_02F_5FE7
    dw Data_02F_6023
    dw Data_02F_6034
    dw Data_02F_6054
    dw Data_02F_6069
    dw Data_02F_607E
    dw Data_02F_6096
    dw Data_02F_60AB
    dw Data_02F_60C1
    dw Data_02F_60D7
    dw Data_02F_60F1
    dw Data_02F_610B
    dw Data_02F_6126
    dw Data_02F_6141
    dw Data_02F_6157
    dw Data_02F_6168
    dw Data_02F_617F
    dw Data_02F_6195
    dw Data_02F_61A8
    dw Data_02F_61C3
    dw Data_02F_61D9
    dw Data_02F_61F7
    dw Data_02F_620E
    dw Data_02F_6227
    dw Data_02F_623D
    dw Data_02F_6255
    dw Data_02F_627C
    dw Data_02F_62A3
    dw Data_02F_62C2
    dw Data_02F_62DC
    dw Data_02F_62F9
    dw Data_02F_6311
    dw Data_02F_6324
    dw Data_02F_633B
    dw Data_02F_6362
    dw Data_02F_637C
    dw Data_02F_6395
    dw Data_02F_63B1
    dw Data_02F_63C1
    dw Data_02F_63DA
    dw Data_02F_63EE
    dw Data_02F_6404
    dw Data_02F_6434
    dw Data_02F_6446
    dw Data_02F_6456
    dw Data_02F_6473
    dw Data_02F_648F
    dw Data_02F_64A5
    dw Data_02F_64BD
    dw Data_02F_64D6
    dw Data_02F_64EF
    dw Data_02F_6507
    dw Data_02F_651F
    dw Data_02F_6537
    dw Data_02F_6557
    dw Data_02F_6574
    dw Data_02F_6591
    dw Data_02F_65A9
    dw Data_02F_65C8
    dw Data_02F_65E1
    dw Data_02F_65FF
    dw Data_02F_661F
    dw Data_02F_6634
    dw Data_02F_664E
    dw Data_02F_6661
    dw Data_02F_6683
    dw Data_02F_669A
    dw Data_02F_66AC
    dw Data_02F_66BF
    dw Data_02F_66D6
    dw Data_02F_66F2
    dw Data_02F_6704
    dw Data_02F_671E
    dw Data_02F_6730
    dw Data_02F_674A
    dw Data_02F_675F
    dw Data_02F_6777
    dw Data_02F_678A
    dw Data_02F_679A
    dw Data_02F_67B5
    dw Data_02F_67CB
    dw Data_02F_67D9
    dw Data_02F_67F8
    dw Data_02F_6810
    dw Data_02F_682B
    dw Data_02F_684B
    dw Data_02F_685F
    dw Data_02F_6889
    dw Data_02F_68B4
    dw Data_02F_68C0
    dw Data_02F_68D3
    dw Data_02F_68EB
    dw Data_02F_68FE
    dw Data_02F_6918
    dw Data_02F_692C
    dw Data_02F_693F
    dw Data_02F_695D
    dw Data_02F_6974
    dw Data_02F_6992
    dw Data_02F_69AF
    dw Data_02F_69E0
    dw Data_02F_6A10
    dw Data_02F_6A28
    dw Data_02F_6A4B
    dw Data_02F_6A67
    dw Data_02F_6A87
    dw Data_02F_6A9B
    dw Data_02F_6AAC
    dw Data_02F_6ABD
    dw Data_02F_6AEC
    dw Data_02F_6AFE
    dw Data_02F_6B1B
    dw Data_02F_6B39
    dw Data_02F_6B56
    dw Data_02F_6B8F
    dw Data_02F_6BC7
    dw Data_02F_6BFB
    dw Data_02F_6C34
    dw Data_02F_6C69
    dw Data_02F_6C89
    dw Data_02F_6CA3
    dw Data_02F_6CCB
    dw Data_02F_6CF8
    dw Data_02F_6D1E
    dw Data_02F_6D4A
    dw Data_02F_6D76
    dw Data_02F_6D8A
    dw Data_02F_6D9E
    dw Data_02F_6DB1
    dw Data_02F_6DD8
    dw Data_02F_6DF5
    dw Data_02F_6E1A
    dw Data_02F_6E33
    dw Data_02F_6E6E
    dw Data_02F_6E87
    dw Data_02F_6EB8
    dw Data_02F_6ECF
    dw Data_02F_6F03
    dw Data_02F_6F17
    dw Data_02F_6F34
    dw Data_02F_6F50
    dw Data_02F_6F68
    dw Data_02F_6F7E
    dw Data_02F_6FBB
    dw Data_02F_6FED
    dw Data_02F_700C
    dw Data_02F_7023
    dw Data_02F_7046
    dw Data_02F_706D
    dw Data_02F_7094
    dw Data_02F_70C0
    dw Data_02F_70D9
    dw Data_02F_70F6
    dw Data_02F_7107
    dw Data_02F_7120
    dw Data_02F_7138
    dw Data_02F_714E
    dw Data_02F_7166
    dw Data_02F_7181
    dw Data_02F_719A
    dw Data_02F_71B5
    dw Data_02F_71D0
    dw Data_02F_71E9
    dw Data_02F_7201
    dw Data_02F_721D
    dw Data_02F_7233
    dw Data_02F_724E
    dw Data_02F_725A
    dw Data_02F_726B
    dw Data_02F_7283
    dw Data_02F_72A0
    dw Data_02F_72C9
    dw Data_02F_72E2
    dw Data_02F_72FB
    dw Data_02F_730D
    dw Data_02F_7329
    dw Data_02F_7342
    dw Data_02F_735B
    dw Data_02F_7377
    dw Data_02F_7392
    dw Data_02F_73A9
    dw Data_02F_73CA
    dw Data_02F_73E5
    dw Data_02F_7400
    dw Data_02F_741D
    dw Data_02F_743A
    dw Data_02F_7466
    dw Data_02F_74A3
    dw Data_02F_74EB
    dw Data_02F_752D
    dw Data_02F_7574
    dw Data_02F_75A9
    dw Data_02F_75DA
    dw Data_02F_7607
    dw Data_02F_763A
    dw Data_02F_768F
    dw Data_02F_76C1
    dw Data_02F_76F0
    dw Data_02F_7719
    dw Data_02F_7752
    dw Data_02F_7781
    dw Data_02F_77B0
    dw Data_02F_77C1
    dw Data_02F_77D2
    dw Data_02F_7818
    dw Data_02F_7854

Data_02F_4334:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_7877
    dw Data_02F_787D
    dw Data_02F_7882
    dw Data_02F_7888

Data_02F_433C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_788D

Data_02F_433E:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_788D

Data_02F_4340:: ; heuristic: target of a monotone pointer table; C0
    dw Data_02F_7897
    dw Data_02F_78B7
    dw Data_02F_7942
    dw Data_02F_7942
    dw Data_02F_795E
    dw Data_02F_7973
    dw Data_02F_79A1
    dw Data_02F_79E7
    dw Data_02F_7A0B
    dw Data_02F_7A25
    dw Data_02F_7A3B
    dw Data_02F_7A63
    dw Data_02F_7A9A
    dw Data_02F_7AB0
    dw Data_02F_7AEF
    dw Data_02F_7B07
    dw Data_02F_7B1C
    dw Data_02F_7B40
    dw Data_02F_7B5E
    dw Data_02F_7B7A
    dw Data_02F_7B9A
    dw Data_02F_7BAD
    dw Data_02F_7BCB
    dw Data_02F_7BE6
    dw Data_02F_7BF8
    dw Data_02F_7C12
    dw Data_02F_7C2E
    dw Data_02F_7C51
    dw Data_02F_7C6B
    dw Data_02F_7C8D
    dw Data_02F_7CA8
    dw Data_02F_7CE2
    dw Data_02F_7CF3
    dw Data_02F_7D11

Data_02F_4384:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $33, $33, $28, $24, $35, $36, $99, $F1, $EC, $F0

Data_02F_4393:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $33, $33, $28, $24, $35
    db $99, $F1, $EC, $F0

Data_02F_43A7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $33, $33, $28, $24, $35
    db $99, $F1, $EC, $F0

Data_02F_43BB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $33, $33, $28, $24, $35
    db $99, $F1, $EC, $F0

Data_02F_43CF:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $33, $33, $28, $24, $35
    db $99, $F1, $EC, $F0

Data_02F_43E3:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $33, $33, $28, $24, $35
    db $99, $F1, $EC, $F0

Data_02F_43F7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F6, $3E, $90, $33, $24, $35, $37, $3C, $90, $3A, $24, $36, $F1, $3A, $2C
    db $33, $28, $27, $90, $32, $38, $37, $99, $E5, $42, $F0

Data_02F_4412:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $3A, $28, $35, $28, $F1, $27
    db $28, $29, $28, $24, $37, $28, $27, $99, $E4, $7E, $FA, $F7, $F0

Data_02F_442F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $28, $29, $37, $F1, $37, $2B, $28, $90, $36, $26, $28
    db $31, $28, $B5, $EC, $F0

Data_02F_4444:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $30, $32, $31, $36, $37, $28, $35, $36, $90, $2F, $28
    db $29, $37, $F1, $37, $2B, $28, $90, $36, $26, $28, $31, $28, $B5, $EC, $F0

Data_02F_4463:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $30, $32, $31, $36, $37, $28, $35, $36, $90, $2F, $28
    db $29, $37, $F1, $37, $2B, $28, $90, $36, $26, $28, $31, $28, $B5, $EC, $F0

Data_02F_4482:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $26, $32, $38, $2F, $27, $31, $41, $90, $35, $28, $24, $26
    db $37, $99, $EC, $F0

Data_02F_4496:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $24, $33, $33, $28, $24, $35, $28, $27, $90, $36, $37, $38
    db $31, $31, $28, $27, $99, $EC, $F0

Data_02F_44AD:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $36, $38, $27, $27, $28, $31, $2F, $3C, $90, $24, $37, $37
    db $24, $26, $2E, $28, $27, $99, $EC, $F0

Data_02F_44C5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $37, $35, $38, $26, $2E, $F1, $3A, $2C, $37, $2B, $32
    db $38, $37, $90, $3A, $24, $35, $31, $2C, $31, $2A, $99, $EC, $F0

Data_02F_44E2:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $26, $38, $35, $36, $28, $27, $99, $EC, $F2
    db $ED, $F9, $00, $90, $26, $24, $31, $41, $F1, $30, $32, $39, $28, $99, $EC, $F0

Data_02F_4502:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $26, $38, $35, $36, $28, $27, $99, $EC, $F2
    db $ED, $F9, $00, $90, $2F, $32, $36, $37, $F1, $F9, $10, $11, $19, $99, $EC, $F0

Data_02F_4522:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $26, $38, $35, $36, $28, $27, $99, $EC, $F2
    db $ED, $F9, $00, $90, $2F, $32, $36, $37, $F1, $F9, $10, $16, $19, $99, $EC, $F0

Data_02F_4542:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $26, $38, $35, $36, $28, $27, $99, $EC, $F2
    db $ED, $F9, $00, $90, $25, $28, $26, $24, $30, $28, $F1, $26, $32, $31, $29, $38
    db $36, $28, $27, $99, $EC, $F0

Data_02F_4568:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $24, $36, $2F, $28, $28, $33, $B5, $EC, $F0

Data_02F_4578:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $26, $32, $31, $29, $38, $36, $28, $27, $99
    db $EC, $F0

Data_02F_458A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $90, $24, $F1, $2B, $38, $31, $2E, $90, $32, $29
    db $90, $2C, $35, $32, $31, $99, $EC, $F0

Data_02F_45A2:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $29, $35, $32, $3D, $28, $31, $90, $36, $32
    db $2F, $2C, $27, $99, $EC, $F0

Data_02F_45B8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $33, $24, $35, $24, $2F, $3C, $3D, $28, $27
    db $99, $EC, $F0

Data_02F_45CB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $27, $24, $31, $26, $2C, $31, $2A, $90, $24
    db $2F, $32, $31, $2A, $99, $EC, $F0

Data_02F_45E2:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $36, $2B, $2C, $39, $28, $35, $2C, $31, $2A
    db $99, $EC, $F0

Data_02F_45F5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $31, $41, $F1, $2A, $28, $37, $90, $25, $24, $26
    db $2E, $90, $38, $33, $99, $EC, $F0

Data_02F_460C:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $26, $32, $3A, $28, $35, $2C, $31, $2A, $90
    db $2C, $31, $90, $29, $28, $24, $35, $99, $EC, $F0

Data_02F_4626:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $32, $2E, $36, $F1, $39, $24, $26, $24, $31, $37
    db $90, $24, $31, $27, $90, $2F, $32, $36, $37, $99, $EC, $F0

Data_02F_4642:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $17, $32, $90, $2C, $37, $28, $30, $36, $90, $24, $2F, $2F, $32, $3A, $28
    db $27, $F1, $2C, $31, $90, $37, $2B, $2C, $36, $90, $25, $24, $37, $37, $2F, $28
    db $99, $F7, $F0

Data_02F_4665:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $2C, $36, $90, $2C, $37, $28, $30, $90, $26, $24, $31, $41, $90
    db $25, $28, $F1, $38, $36, $28, $27, $90, $2C, $31, $90, $25, $24, $37, $37, $2F
    db $28, $99, $F7, $F0

Data_02F_4689:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $35, $28, $90, $24, $35, $28, $90, $31, $32, $F1, $38, $36
    db $24, $25, $2F, $28, $90, $2C, $37, $28, $30, $36, $99, $F7, $F0

Data_02F_46A6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $17, $32, $90, $29, $2F, $28, $28, $2C, $31, $2A, $90, $29, $35, $32, $30
    db $F1, $37, $2B, $2C, $36, $90, $25, $24, $37, $37, $2F, $28, $99, $F7, $F0

Data_02F_46C5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0C, $24, $31, $41, $90, $38, $36, $28, $90, $37, $2B, $24, $37, $F1, $36
    db $2E, $2C, $2F, $2F, $90, $31, $32, $3A, $99, $F7, $F0

Data_02F_46E0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1C, $28, $2F, $28, $26, $37, $2C, $31, $2A, $F1, $F9, $00, $3E, $90, $30
    db $32, $39, $28, $A4, $F0

Data_02F_46F5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $17, $32, $90, $30, $32, $31, $36, $37, $28, $35, $36, $90, $37, $32, $F1
    db $24, $26, $26, $28, $36, $36, $90, $19, $15, $0A, $17, $B5, $F7, $F0

Data_02F_4713:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $35, $28, $90, $2C, $36, $90, $31, $32, $90, $37, $24, $35
    db $2A, $28, $37, $F1, $2C, $31, $90, $36, $2C, $2A, $2B, $37, $99, $F7, $F0

Data_02F_4732:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $24, $37, $90, $36, $2E, $2C, $2F, $2F, $90, $26, $24, $31, $41
    db $F1, $25, $28, $90, $38, $36, $28, $27, $90, $2C, $31, $90, $25, $24, $37, $37
    db $2F, $28, $99, $F7, $F0

Data_02F_4757:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $17, $32, $37, $90, $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99, $F1
    db $F7, $F0

Data_02F_4769:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1B, $28, $37, $2C, $35, $28, $90, $31, $32, $3A, $98, $F1, $F0

Data_02F_4777:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $2A, $31, $32, $35, $28, $27, $F1, $32, $35, $27, $28
    db $35, $36, $99, $EC, $F0

Data_02F_478C:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $12, $37, $90, $2B, $24, $36, $90, $31, $32, $90, $38, $36, $24, $25, $2F
    db $28, $F1, $25, $24, $37, $37, $2F, $28, $90, $36, $2E, $2C, $2F, $2F, $36, $99
    db $EC, $F0

Data_02F_47AE:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $31, $32, $37, $90, $35, $28, $26, $35, $38, $2C, $37, $28
    db $27, $99, $EC, $F0

Data_02F_47C2:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $24, $2F, $35, $28, $24, $27, $3C, $90, $35, $28, $26, $35
    db $38, $2C, $37, $28, $27, $B5, $EC, $F0

Data_02F_47DA:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0B, $38, $37, $90, $37, $2B, $28, $90, $28, $36, $26, $24, $33, $28, $F1
    db $35, $32, $38, $37, $28, $90, $3A, $24, $36, $90, $26, $38, $37, $90, $32, $29
    db $29, $99, $EC, $F0

Data_02F_47FE:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0B, $38, $37, $90, $37, $2B, $28, $35, $28, $3E, $90, $31, $32, $90, $32
    db $31, $28, $F1, $37, $32, $90, $26, $32, $30, $30, $24, $31, $27, $99, $F7, $F0

Data_02F_481E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $37, $35, $38, $26, $2E, $F1, $24, $37, $90, $29, $38
    db $2F, $2F, $90, $33, $32, $3A, $28, $35, $99, $EC, $F0

Data_02F_4839:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $38, $26, $2E, $28, $27, $F1, $37, $2C, $2A, $2B, $37
    db $28, $35, $90, $2C, $31, $90, $29, $28, $24, $35, $99, $EC, $F0

Data_02F_4856:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $26, $32, $31, $26, $28, $31, $37, $35, $24, $37, $28, $27
    db $99, $EC, $F0

Data_02F_4869:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $37, $35, $38, $26, $2E, $F1, $25, $24, $26, $2E, $AB
    db $90, $28, $31, $35, $24, $2A, $28, $27, $B5, $EC, $F0

Data_02F_4884:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $15, $2C, $2A, $2B, $37, $90, $29, $28, $2F, $2F, $90, $36, $32, $29, $37
    db $2F, $3C, $F1, $32, $31, $90, $F9, $00, $99, $EC, $F0

Data_02F_489F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $38, $26, $2E, $28, $27, $F1, $25, $28, $2B, $2C, $31
    db $27, $90, $F9, $10, $99, $EC, $F0

Data_02F_48B6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $33, $38, $30, $33, $28, $27, $F1, $2C, $37, $36, $28, $2F
    db $29, $90, $38, $33, $99, $EC, $F0

Data_02F_48CD:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $35, $32, $2F, $2F, $28, $27, $F1, $32, $38, $37, $90, $32
    db $29, $90, $37, $2B, $28, $90, $3A, $24, $3C, $99, $EC, $F0

Data_02F_48E9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $36, $37, $F1, $F9, $10, $99, $EC, $F2, $ED, $0B
    db $38, $37, $90, $37, $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1
    db $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4915:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $2F, $28, $3A, $F1, $F9, $10, $99, $EC, $F2, $ED, $0B
    db $38, $37, $90, $37, $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1
    db $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4941:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $24, $31, $26, $28, $27, $F1, $37, $2B, $28, $90, $F9
    db $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $37, $2B, $28, $35, $28, $90, $3A
    db $28, $35, $28, $31, $41, $F1, $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99
    db $EC, $F0

Data_02F_4973:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $2D, $38, $30
    db $33, $90, $2B, $2C, $2A, $2B, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $37, $2B
    db $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1, $28, $31, $32, $38, $2A
    db $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_49AA:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $26, $24, $2F
    db $2F, $90, $29, $32, $35, $90, $2B, $28, $2F, $33, $99, $EC, $F2, $ED, $0B, $38
    db $37, $90, $37, $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1, $28
    db $31, $32, $38, $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_49E5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $3C, $28, $2F
    db $2F, $90, $29, $32, $35, $90, $2B, $28, $2F, $33, $99, $EC, $F2, $ED, $0B, $38
    db $37, $90, $37, $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1, $28
    db $31, $32, $38, $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4A20:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $33, $38, $30
    db $33, $90, $2C, $37, $36, $28, $2F, $29, $90, $38, $33, $99, $EC, $F2, $ED, $0B
    db $38, $37, $90, $37, $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1
    db $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4A5C:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $26, $24, $36
    db $37, $90, $24, $90, $26, $38, $35, $36, $28, $99, $EC, $F2, $ED, $0B, $38, $37
    db $90, $37, $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1, $28, $31
    db $32, $38, $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4A96:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $2C, $31, $2B
    db $24, $2F, $28, $90, $24, $2F, $2F, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $37
    db $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1, $28, $31, $32, $38
    db $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4ACE:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $34, $38, $2C, $28, $37, $36, $F1, $F9, $20, $99, $EC, $F2
    db $ED, $0B, $38, $37, $90, $37, $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31
    db $41, $F1, $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4AFC:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $36, $2C, $31
    db $2A, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $37, $2B, $28, $35, $28, $90, $3A
    db $28, $35, $28, $31, $41, $F1, $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99
    db $EC, $F0

Data_02F_4B2E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $30, $24, $2E
    db $28, $90, $24, $90, $25, $24, $35, $35, $2C, $28, $35, $99, $EC, $F2, $ED, $0B
    db $38, $37, $90, $37, $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1
    db $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4B6A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $33, $35, $24, $3C, $28, $27, $F1, $37, $32, $90, $37, $2B
    db $28, $90, $2B, $28, $24, $39, $28, $31, $36, $99, $EC, $F2, $ED, $0B, $38, $37
    db $90, $37, $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1, $28, $31
    db $32, $38, $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4BA4:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $33, $35, $24, $3C, $28, $27, $F1, $29, $32, $35, $90, $36
    db $2C, $2F, $28, $31, $26, $28, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $37, $2B
    db $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1, $28, $31, $32, $38, $2A
    db $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4BDB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $36, $2B, $32
    db $32, $37, $90, $3A, $24, $37, $28, $35, $99, $EC, $F2, $ED, $0B, $38, $37, $90
    db $37, $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1, $28, $31, $32
    db $38, $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4C14:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $2F, $2F, $28, $27, $F1, $29, $32, $35, $90, $F9
    db $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $37, $2B, $28, $35, $28, $90, $3A
    db $28, $35, $28, $31, $41, $F1, $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99
    db $EC, $F0

Data_02F_4C46:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $38, $36, $28
    db $90, $F9, $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $37, $2B, $28, $35, $28
    db $90, $3A, $28, $35, $28, $31, $41, $F1, $28, $31, $32, $38, $2A, $2B, $90, $16
    db $19, $99, $EC, $F0

Data_02F_4C7A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $3A, $24, $2E, $2C, $31, $2A
    db $90, $F9, $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $37, $2B, $28, $35, $28
    db $90, $3A, $28, $35, $28, $31, $41, $F1, $28, $31, $32, $38, $2A, $2B, $90, $16
    db $19, $99, $EC, $F0

Data_02F_4CAE:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $32, $37, $F1, $35, $28, $24, $27, $3C, $90, $37, $32
    db $90, $2C, $31, $2B, $24, $2F, $28, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $37
    db $2B, $28, $35, $28, $90, $3A, $28, $35, $28, $31, $41, $F1, $28, $31, $32, $38
    db $2A, $2B, $90, $16, $19, $99, $EC, $F0

Data_02F_4CE6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $36, $37, $F1, $F9, $10, $99, $EC, $F2, $ED, $0B
    db $38, $37, $90, $2C, $37, $36, $90, $36, $33, $28, $2F, $2F, $36, $F1, $24, $35
    db $28, $90, $36, $28, $24, $2F, $28, $27, $99, $EC, $F0

Data_02F_4D11:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $25, $2F, $32, $3A, $2C, $31
    db $2A, $90, $F9, $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C, $37, $36, $90
    db $30, $32, $38, $37, $2B, $90, $2C, $36, $F1, $36, $28, $24, $2F, $28, $27, $90
    db $37, $2C, $2A, $2B, $37, $99, $EC, $F0

Data_02F_4D49:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $24, $31, $26, $28, $27, $F1, $37, $2B, $28, $90, $F9
    db $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C, $37, $90, $26, $24, $31, $41
    db $90, $27, $32, $F1, $37, $2B, $28, $90, $27, $24, $31, $26, $28, $99, $EC, $F0

Data_02F_4D79:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $36, $37, $F1, $F9, $10, $99, $EC, $F2, $ED, $0B
    db $38, $37, $90, $37, $2B, $28, $90, $36, $33, $28, $2F, $2F, $90, $3A, $24, $36
    db $F1, $36, $2B, $24, $37, $37, $28, $35, $28, $27, $99, $EC, $F0

Data_02F_4DA6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $36, $37, $F1, $F9, $10, $99, $EC, $F2, $ED, $0B
    db $38, $37, $90, $2C, $37, $90, $2C, $36, $90, $36, $28, $24, $2F, $28, $27, $F1
    db $25, $3C, $90, $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_4DD4:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $38, $36, $28
    db $90, $F9, $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C, $37, $90, $2C, $36
    db $90, $36, $28, $24, $2F, $28, $27, $F1, $25, $3C, $90, $24, $90, $33, $35, $24
    db $3C, $28, $35, $99, $EC, $F0

Data_02F_4E0A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $2F, $28, $3A, $F1, $F9, $10, $99, $EC, $F2, $ED, $0B
    db $38, $37, $90, $2C, $37, $90, $2C, $36, $90, $36, $28, $24, $2F, $28, $27, $F1
    db $25, $3C, $90, $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_4E38:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $3A, $24, $2E, $2C, $31, $2A
    db $90, $F9, $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C, $37, $90, $2C, $36
    db $90, $36, $37, $32, $33, $33, $28, $27, $F1, $25, $3C, $90, $24, $90, $33, $35
    db $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_4E6F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $26, $24, $2F
    db $2F, $90, $29, $32, $35, $90, $2B, $28, $2F, $33, $99, $EC, $F2, $ED, $0B, $38
    db $37, $90, $2C, $37, $90, $2C, $36, $90, $36, $37, $32, $33, $33, $28, $27, $F1
    db $25, $3C, $90, $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_4EAD:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $3C, $28, $2F
    db $2F, $90, $29, $32, $35, $90, $2B, $28, $2F, $33, $99, $EC, $F2, $ED, $0B, $38
    db $37, $90, $2C, $37, $90, $2C, $36, $90, $36, $37, $32, $33, $33, $28, $27, $F1
    db $25, $3C, $90, $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_4EEB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $25, $38, $2C
    db $2F, $27, $90, $33, $32, $3A, $28, $35, $99, $EC, $F2, $ED, $0B, $38, $37, $90
    db $2C, $37, $90, $2C, $36, $90, $36, $37, $32, $33, $33, $28, $27, $F1, $25, $3C
    db $90, $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_4F27:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $33, $38, $30
    db $33, $90, $2C, $37, $36, $28, $2F, $29, $90, $38, $33, $99, $EC, $F2, $ED, $0B
    db $38, $37, $90, $2C, $37, $90, $2C, $36, $90, $36, $37, $32, $33, $33, $28, $27
    db $F1, $25, $3C, $90, $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_4F66:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $2D, $38, $30
    db $33, $90, $2B, $2C, $2A, $2B, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C, $37
    db $90, $2C, $36, $90, $36, $37, $32, $33, $33, $28, $27, $F1, $25, $3C, $90, $24
    db $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_4FA0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $24, $31, $26, $28, $27, $F1, $37, $2B, $28, $90, $F9
    db $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C, $37, $90, $2C, $36, $90, $36
    db $37, $32, $33, $33, $28, $27, $F1, $25, $3C, $90, $24, $90, $33, $35, $24, $3C
    db $28, $35, $99, $EC, $F0

Data_02F_4FD5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $32, $37, $F1, $35, $28, $24, $27, $3C, $90, $37, $32
    db $90, $2C, $31, $2B, $24, $2F, $28, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C
    db $37, $90, $2C, $36, $90, $36, $37, $32, $33, $33, $28, $27, $F1, $25, $3C, $90
    db $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_5010:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $34, $38, $2C, $28, $37, $36, $F1, $F9, $20, $99, $EC, $F2
    db $ED, $0B, $38, $37, $90, $2C, $37, $90, $2C, $36, $90, $36, $37, $32, $33, $33
    db $28, $27, $F1, $25, $3C, $90, $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC
    db $F0

Data_02F_5041:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $30, $24, $2E
    db $28, $90, $24, $90, $25, $24, $35, $35, $2C, $28, $35, $99, $EC, $F2, $ED, $0B
    db $38, $37, $90, $2C, $37, $90, $2C, $36, $90, $36, $37, $32, $33, $33, $28, $27
    db $F1, $25, $3C, $90, $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_5080:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $2C, $31, $2B
    db $24, $2F, $28, $90, $24, $2F, $2F, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C
    db $37, $90, $2C, $36, $90, $36, $37, $32, $33, $33, $28, $27, $F1, $25, $3C, $90
    db $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_50BB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $36, $2C, $31
    db $2A, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C, $37, $90, $2C, $36, $90, $36
    db $37, $32, $33, $33, $28, $27, $F1, $25, $3C, $90, $24, $90, $33, $35, $24, $3C
    db $28, $35, $99, $EC, $F0

Data_02F_50F0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $33, $35, $24, $3C, $28, $27, $F1, $37, $32, $90, $37, $2B
    db $28, $90, $2B, $28, $24, $39, $28, $31, $36, $99, $EC, $F2, $ED, $0B, $38, $37
    db $90, $2C, $37, $90, $2C, $36, $90, $36, $37, $32, $33, $33, $28, $27, $F1, $25
    db $3C, $90, $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_512D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $37, $32, $90, $36, $2B, $32
    db $32, $37, $90, $3A, $24, $37, $28, $35, $99, $EC, $F2, $ED, $0B, $38, $37, $90
    db $2C, $37, $90, $2C, $36, $90, $36, $37, $32, $33, $33, $28, $27, $F1, $25, $3C
    db $90, $24, $90, $33, $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_5169:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $2F, $2F, $28, $27, $F1, $29, $32, $35, $90, $F9
    db $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C, $37, $90, $2C, $36, $90, $36
    db $37, $32, $33, $33, $28, $27, $F1, $25, $3C, $90, $24, $90, $33, $35, $24, $3C
    db $28, $35, $99, $EC, $F0

Data_02F_519E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $35, $2C, $28, $27, $F1, $25, $2F, $32, $3A, $2C, $31
    db $2A, $90, $F9, $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $2C, $37, $90, $2C
    db $36, $90, $36, $37, $32, $33, $33, $28, $27, $F1, $25, $3C, $90, $24, $90, $33
    db $35, $24, $3C, $28, $35, $99, $EC, $F0

Data_02F_51D6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $22, $32, $38, $90, $37, $2B, $35, $28, $3A, $90, $2C, $31, $F1, $37, $2B
    db $28, $90, $37, $32, $3A, $28, $2F, $99, $EC, $F0

Data_02F_51F0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $38, $35, $31, $36, $90, $2F, $28, $29, $37, $99, $F1
    db $EC, $F0

Data_02F_5202:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $17, $32, $90, $37, $38, $35, $31, $36, $90, $2F, $28, $29, $37, $B5, $F1
    db $1D, $2B, $2C, $36, $90, $28, $31, $27, $36, $90, $24, $90, $27, $35, $24, $3A
    db $B5, $EC, $F0

Data_02F_5225:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $22, $32, $38, $90, $25, $35, $32, $2E, $28, $90, $24, $90, $25, $24, $37
    db $37, $2F, $28, $F1, $35, $38, $2F, $28, $99, $FA, $F7, $F2, $22, $32, $38, $90
    db $2F, $32, $36, $28, $B5, $FA, $F7, $F0

Data_02F_524D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $22, $32, $38, $35, $90, $32, $33, $33, $32, $31, $28, $31, $37, $F1, $25
    db $35, $32, $2E, $28, $90, $24, $90, $35, $38, $2F, $28, $99, $FA, $F7, $F2, $22
    db $32, $38, $90, $3A, $2C, $31, $B5, $FA, $F7, $F0

Data_02F_5277:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $24, $37, $90, $36, $2E, $2C, $2F, $2F, $90, $2C, $36, $31, $41
    db $F1, $29, $32, $35, $90, $32, $3A, $31, $90, $38, $36, $28, $99, $EC, $F0

Data_02F_5296:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $35, $2C, $28, $27
    db $EC, $F2, $ED, $26, $24, $36, $37, $2C, $31, $2A, $90, $24, $90, $36, $33, $28
    db $2F, $2F, $99, $F1, $0B, $38, $37, $90, $2C, $37, $90, $29, $24, $2C, $2F, $28
    db $27, $99, $EC, $F0

Data_02F_52CA:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $35, $2C, $28, $27
    db $EC, $F2, $ED, $38, $36, $2C, $31, $2A, $90, $24, $90, $36, $2E, $2C, $2F, $2F
    db $99, $F1, $0B, $38, $37, $90, $2C, $37, $90, $29, $24, $2C, $2F, $28, $27, $99
    db $EC, $F0

Data_02F_52FC:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $35, $2C, $28, $27
    db $EC, $F2, $ED, $37, $32, $90, $38, $36, $28, $90, $30, $24, $2A, $2C, $26, $99
    db $F1, $0B, $38, $37, $90, $2C, $37, $90, $29, $24, $2C, $2F, $28, $27, $99, $EC
    db $F0

Data_02F_532D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $35, $2C, $28, $27
    db $EC, $F2, $ED, $26, $24, $36, $37, $2C, $31, $2A, $90, $24, $90, $36, $33, $28
    db $2F, $2F, $99, $F1, $17, $32, $37, $90, $28, $31, $32, $38, $2A, $2B, $90, $16
    db $19, $99, $EC, $F0

Data_02F_5361:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $35, $2C, $28, $27
    db $EC, $F2, $ED, $38, $36, $2C, $31, $2A, $90, $24, $90, $36, $2E, $2C, $2F, $2F
    db $99, $F1, $17, $32, $37, $90, $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99
    db $EC, $F0

Data_02F_5393:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $35, $2C, $28, $27
    db $EC, $F2, $ED, $37, $32, $90, $38, $36, $28, $90, $30, $24, $2A, $2C, $26, $99
    db $F1, $17, $32, $37, $90, $28, $31, $32, $38, $2A, $2B, $90, $16, $19, $99, $EC
    db $F0

Data_02F_53C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD3C4, $44

Data_02F_5408:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD408, $4B

Data_02F_5453:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD453, $4F

Data_02F_54A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD4A2, $4E

Data_02F_54F0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD4F0, $44

Data_02F_5534:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD534, $4B

Data_02F_557F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD57F, $50

Data_02F_55CF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD5CF, $53

Data_02F_5622:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD622, $4F

Data_02F_5671:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD671, $4C

Data_02F_56BD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD6BD, $4C

Data_02F_5709:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD709, $4F

Data_02F_5758:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD758, $4C

Data_02F_57A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD7A4, $4F

Data_02F_57F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD7F3, $4A

Data_02F_583D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $31, $41, $F1, $28, $24, $37, $90, $3A, $2B, $2C
    db $2F, $28, $90, $24, $36, $2F, $28, $28, $33, $99, $EC, $F0

Data_02F_5859:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $31, $41, $F1, $28, $24, $37, $90, $3A, $2B, $2C
    db $2F, $28, $EC, $F2, $ED, $33, $24, $35, $24, $2F, $3C, $3D, $28, $27, $99, $EC
    db $F0

Data_02F_587A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $90, $24, $F1, $2B, $38, $31, $2E, $90, $32, $29
    db $90, $2C, $35, $32, $31, $99, $EC, $F0

Data_02F_5892:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $35, $38, $36, $2B, $28, $27, $F1, $32, $29, $29, $90
    db $F9, $20, $99, $EC, $F0

Data_02F_58A7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0B, $38, $37, $90, $37, $2B, $28, $35, $28, $90, $2C, $36, $90, $31, $32
    db $F1, $32, $31, $28, $90, $37, $32, $90, $25, $28, $37, $35, $24, $3C, $99, $F7
    db $F0

Data_02F_58C8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD8C8, $46

Data_02F_590E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD90E, $4A

Data_02F_5958:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD958, $47

Data_02F_599F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD99F, $4D

Data_02F_59EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BD9EC, $49

Data_02F_5A35:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BDA35, $4D

Data_02F_5A82:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $31, $36, $37, $28, $35, $90, $3A, $24, $36, $F1, $27, $28, $29, $28
    db $24, $37, $28, $27, $99, $E4, $7E, $FA, $F7, $F0

Data_02F_5A9C:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $33, $24, $35, $37, $3C, $F1, $3A, $24, $36, $90, $3A
    db $2C, $33, $28, $27, $90, $32, $38, $37, $99, $E5, $42, $F0

Data_02F_5AB8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $38, $35, $31, $90, $2F, $28, $29, $37, $99, $F1, $EC
    db $F0

Data_02F_5AC9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $24, $37, $37, $24, $26, $2E, $28, $27, $99, $EC, $F0

Data_02F_5AD8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $36, $37, $F1, $F9, $10, $99, $EC, $F0

Data_02F_5AE6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $32, $36, $28, $27, $F1, $F9, $10, $99, $EC, $F0

Data_02F_5AF6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $2F, $28, $3A, $F1, $F9, $10, $99, $EC, $F0

Data_02F_5B04:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $24, $31, $26, $28, $27, $F1, $37, $2B, $28, $90, $F9
    db $10, $99, $EC, $F0

Data_02F_5B18:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $10, $90, $36, $2B, $32, $37, $F1, $29, $35, $32, $30, $90, $F9, $00
    db $99, $EC, $F0

Data_02F_5B2B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $2F, $32, $36, $28, $27, $F1, $2C, $31, $90, $32, $31
    db $90, $F9, $10, $99, $EC, $F0

Data_02F_5B41:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $2B, $24, $35, $2A, $28, $27, $F1, $24, $37, $90, $F9
    db $10, $99, $EC, $F0

Data_02F_5B55:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $2B, $24, $35, $2A, $28, $27, $F1, $35, $28, $26, $28
    db $2E, $2F, $28, $36, $36, $2F, $3C, $99, $EC, $F0

Data_02F_5B6F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $32, $39, $28, $90, $24, $37, $F1, $F9, $10, $99, $EC
    db $F0

Data_02F_5B80:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $29, $2F, $24, $2C, $2F, $28, $27, $F1, $24, $37, $90, $F9
    db $10, $99, $EC, $F0

Data_02F_5B94:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $30, $24, $36, $2B, $28, $27, $F1, $F9, $10, $99, $EC
    db $F0

Data_02F_5BA5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $28, $24, $33, $37, $F1, $2B, $2C, $2A, $2B, $99, $EC
    db $F0

Data_02F_5BB6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $29, $28, $2F, $2F, $F1, $32, $38, $37, $90, $32, $29, $90
    db $37, $2B, $28, $90, $36, $2E, $3C, $99, $EC, $F0

Data_02F_5BD0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $31, $2B, $24, $2F, $28, $27, $F1, $27, $28, $28, $33
    db $2F, $3C, $99, $EC, $F0

Data_02F_5BE5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $10, $90, $33, $35, $24, $3C, $28, $27, $F1, $37, $32, $90, $37, $2B
    db $28, $90, $3A, $2C, $31, $27, $99, $EC, $F2, $ED, $0B, $2F, $24, $27, $28, $36
    db $90, $32, $29, $90, $24, $2C, $35, $F1, $36, $2F, $24, $36, $2B, $90, $32, $38
    db $37, $99, $EC, $F0

Data_02F_5C19:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3C, $28, $2F, $2F, $28, $27, $F1, $29, $32, $35, $90, $2B
    db $28, $2F, $33, $99, $EC, $F0

Data_02F_5C2F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $2F, $2F, $28, $27, $F1, $29, $32, $35, $90, $2B
    db $28, $2F, $33, $99, $EC, $F0

Data_02F_5C45:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $26, $32, $31, $26, $28, $31, $37, $35, $24, $37, $28, $27
    db $99, $EC, $F0

Data_02F_5C58:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $37, $35, $38, $26, $2E, $F1, $2F, $2C, $2E, $28, $90
    db $37, $2B, $28, $90, $3A, $2C, $31, $27, $99, $EC, $F0

Data_02F_5C73:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $37, $35, $38, $26, $2E, $F1, $30, $2C, $2A, $2B, $37
    db $2C, $2F, $3C, $99, $EC, $F0

Data_02F_5C89:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $2B, $2C, $33, $33, $28, $27, $F1, $38, $33, $90, $39
    db $2C, $26, $2C, $32, $38, $36, $90, $3A, $2C, $31, $27, $36, $99, $EC, $F0

Data_02F_5CA8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $35, $32, $38, $2A, $2B, $37, $F1, $2F, $2C, $2A, $2B
    db $37, $31, $2C, $31, $2A, $90, $29, $32, $35, $37, $2B, $99, $EC, $F0

Data_02F_5CC6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2B, $38, $35, $2F, $28, $27, $F1, $2B, $38, $2A, $28, $90
    db $25, $32, $38, $2F, $27, $28, $35, $36, $99, $EC, $F0

Data_02F_5CE1:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $35, $32, $38, $2A, $2B, $37, $F1, $32, $31, $90, $24
    db $31, $90, $28, $39, $2C, $2F, $90, $2F, $2C, $2A, $2B, $37, $99, $EC, $F2, $ED
    db $1D, $2B, $38, $31, $27, $28, $35, $25, $32, $2F, $37, $36, $F1, $2B, $24, $30
    db $30, $28, $35, $28, $27, $90, $27, $32, $3A, $31, $99, $EC, $F0

Data_02F_5D1E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $28, $37, $90, $32, $29, $29, $F1, $24, $90, $0B, $2C
    db $2A, $0B, $24, $31, $2A, $99, $EC, $F2, $ED, $20, $2C, $2F, $27, $90, $28, $3B
    db $33, $2F, $32, $36, $2C, $32, $31, $36, $F1, $28, $26, $2B, $32, $28, $27, $90
    db $35, $28, $33, $28, $24, $37, $28, $27, $2F, $3C, $99, $EC, $F0

Data_02F_5D5B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $32, $36, $28, $27, $F1, $24, $2F, $2F, $90, $30
    db $24, $2A, $2C, $26, $90, $33, $32, $3A, $28, $35, $99, $EC, $F2, $ED, $12, $37
    db $90, $36, $28, $37, $90, $32, $29, $29, $90, $24, $F1, $3A, $2C, $26, $2E, $28
    db $27, $90, $28, $3B, $33, $2F, $32, $36, $2C, $32, $31, $99, $EC, $F0

Data_02F_5D99:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $38, $37, $37, $28, $35, $28, $27, $F1, $24, $90, $26, $38
    db $35, $36, $28, $99, $EC, $F0

Data_02F_5DAF:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2E, $2C, $26, $2E, $28, $27, $F1, $38, $33, $90, $24, $90
    db $36, $24, $31, $27, $36, $37, $32, $35, $30, $99, $EC, $F0

Data_02F_5DCB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $2C, $27, $90, $24, $31, $F1, $32, $27, $27, $90, $27
    db $24, $31, $26, $28, $90, $36, $37, $28, $33, $99, $EC, $F0

Data_02F_5DE7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $24, $39, $28, $90, $24, $F1, $33, $32, $3A, $27, $28
    db $35, $33, $38, $29, $29, $90, $30, $24, $36, $36, $24, $2A, $28, $EC, $F2, $ED
    db $37, $32, $90, $F9, $10, $99, $F1, $EC, $F0

Data_02F_5E10:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $2C, $26, $2E, $28, $27, $F1, $F9, $10, $3E, $90, $29
    db $24, $26, $28, $99, $EC, $F0

Data_02F_5E26:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2E, $2C, $26, $2E, $28, $27, $F1, $F9, $10, $90, $2F, $32
    db $3A, $99, $EC, $F0

Data_02F_5E3A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $10, $90, $27, $2C, $27, $90, $24, $F1, $36, $3A, $28, $28, $33, $2C
    db $31, $2A, $90, $2E, $2C, $26, $2E, $99, $EC, $F0

Data_02F_5E54:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $32, $36, $28, $27, $F1, $24, $90, $36, $24, $39
    db $24, $2A, $28, $90, $35, $32, $24, $35, $99, $EC, $F0

Data_02F_5E6F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $33, $35, $24, $3C, $28, $27, $F1, $37, $32, $90, $37, $2B
    db $28, $90, $28, $24, $35, $37, $2B, $99, $EC, $F0

Data_02F_5E89:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $2B, $2C, $33, $33, $28, $27, $F1, $38, $33, $90, $F9
    db $10, $99, $EC, $F0

Data_02F_5E9D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $34, $38, $2C, $28, $37, $28, $27, $F1, $F9, $10, $99, $EC
    db $F0

Data_02F_5EAE:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $28, $2A, $24, $31, $F1, $37, $32, $90, $30, $28, $27
    db $2C, $37, $24, $37, $28, $99, $EC, $F2, $ED, $F9, $00, $3E, $F1, $3A, $32, $38
    db $31, $27, $36, $90, $2B, $28, $24, $2F, $28, $27, $99, $EC, $F0

Data_02F_5EDB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $28, $2A, $24, $31, $F1, $36, $2C, $31, $2A, $2C, $31
    db $2A, $99, $EC, $F0

Data_02F_5EEF:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $36, $32, $31, $2A, $F1, $28, $31, $27, $28, $27, $99
    db $EC, $F0

Data_02F_5F01:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $35, $24, $2C, $36, $28, $27, $F1, $24, $90, $3A, $24, $37
    db $28, $35, $90, $25, $24, $35, $35, $2C, $28, $35, $99, $EC, $F0

Data_02F_5F1E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $2A, $38, $24, $35, $27, $2C, $31, $2A, $90
    db $2C, $37, $36, $28, $2F, $29, $99, $EC, $F0

Data_02F_5F37:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $2B, $2C, $28, $2F, $27, $36, $F1, $F9, $10, $99, $EC
    db $F0

Data_02F_5F48:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $25, $35, $24, $26, $28, $27, $90, $29, $32
    db $35, $90, $24, $37, $37, $24, $26, $2E, $99, $EC, $F0

Data_02F_5F63:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $35, $28, $24, $27, $3C, $90, $37, $32, $90
    db $33, $24, $35, $35, $3C, $99, $EC, $F0

Data_02F_5F7B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $90, $2C, $31, $90, $24, $F1, $27, $28, $29, $28
    db $31, $36, $2C, $39, $28, $90, $33, $32, $36, $28, $99, $EC, $F0

Data_02F_5F98:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $32, $2E, $36, $F1, $29, $32, $35, $90, $33, $24
    db $3C, $25, $24, $26, $2E, $99, $EC, $F0

Data_02F_5FB0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $90, $36, $28, $37, $F1, $37, $32, $90, $2C, $31
    db $2B, $24, $2F, $28, $90, $24, $2F, $2F, $99, $EC, $F0

Data_02F_5FCB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $33, $35, $24, $3C, $28, $27, $F1, $37, $32, $90, $37, $2B
    db $28, $90, $2B, $28, $24, $39, $28, $31, $36, $99, $EC, $F0

Data_02F_5FE7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $33, $35, $24, $3C, $28, $27, $F1, $29, $32, $35, $90, $36
    db $2C, $2F, $28, $31, $26, $28, $99, $EC, $F2, $ED, $0A, $31, $90, $2C, $31, $39
    db $2C, $36, $2C, $25, $2F, $28, $90, $29, $32, $35, $26, $28, $F1, $33, $35, $28
    db $36, $36, $28, $27, $90, $27, $32, $3A, $31, $99, $EC, $F0

Data_02F_6023:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $2B, $32, $37, $F1, $3A, $24, $37, $28, $35, $99, $EC
    db $F0

Data_02F_6034:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $35, $28, $24, $37, $28, $27, $F1, $24, $90, $2B, $38
    db $2A, $28, $90, $37, $2C, $27, $24, $2F, $90, $3A, $24, $39, $28, $99, $EC, $F0

Data_02F_6054:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $32, $32, $2E, $F1, $F9, $10, $90, $27, $24, $30, $24
    db $2A, $28, $99, $EC, $F0

Data_02F_6069:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $32, $32, $2E, $F1, $F9, $10, $90, $27, $24, $30, $24
    db $2A, $28, $99, $EC, $F0

Data_02F_607E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $3A, $32, $38, $31, $27, $F1, $3A, $24, $36, $90, $2B
    db $28, $24, $2F, $28, $27, $99, $EC, $F0

Data_02F_6096:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $25, $35, $38, $37, $24, $2F, $2C, $3D
    db $28, $27, $99, $EC, $F0

Data_02F_60AB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $0D, $0E, $0F, $F1, $29, $28, $2F, $2F, $90, $25, $3C
    db $90, $F9, $10, $99, $EC, $F0

Data_02F_60C1:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $0D, $0E, $0F, $F1, $29, $28, $2F, $2F, $90, $25, $3C
    db $90, $F9, $10, $99, $EC, $F0

Data_02F_60D7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $31, $41, $F1, $38, $36, $28, $90, $36, $33, $28
    db $2F, $2F, $36, $90, $31, $32, $3A, $99, $EC, $F0

Data_02F_60F1:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $36, $33, $28, $2F, $2F, $36, $F1, $3A, $28, $35, $28
    db $90, $36, $28, $24, $2F, $28, $27, $99, $EC, $F0

Data_02F_610B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $36, $37, $35, $2C, $33, $33, $28, $27
    db $90, $32, $29, $90, $F9, $10, $16, $19, $99, $EC, $F0

Data_02F_6126:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $36, $37, $35, $2C, $33, $33, $28, $27
    db $90, $32, $29, $90, $F9, $10, $16, $19, $99, $EC, $F0

Data_02F_6141:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $37, $24, $35, $37, $28, $27, $F1, $2A, $2F, $32, $3A
    db $2C, $31, $2A, $99, $EC, $F0

Data_02F_6157:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $37, $32, $2F, $28, $F1, $F9, $10, $16, $19, $99, $EC
    db $F0

Data_02F_6168:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $28, $26, $24, $30, $28, $F1, $25, $28, $29, $38, $27
    db $27, $2F, $28, $27, $99, $EC, $F0

Data_02F_617F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $28, $26, $24, $30, $28, $F1, $26, $32, $31, $29, $38
    db $36, $28, $27, $99, $EC, $F0

Data_02F_6195:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $0A, $1D, $14, $F1, $27, $32, $38, $25, $2F, $28, $27
    db $99, $EC, $F0

Data_02F_61A8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $38, $35, $31, $28, $27, $F1, $2C, $31, $37, $32, $90
    db $24, $90, $27, $35, $24, $2A, $32, $31, $99, $EC, $F0

Data_02F_61C3:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $0D, $0E, $0F, $F1, $35, $32, $36, $28, $90, $25, $3C
    db $90, $F9, $10, $99, $EC, $F0

Data_02F_61D9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $33, $24, $35, $37, $3C, $F1, $37, $38, $35, $31, $28
    db $27, $90, $2C, $31, $37, $32, $90, $2C, $35, $32, $31, $99, $EC, $F0

Data_02F_61F7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $38, $35, $31, $28, $27, $F1, $2C, $31, $37, $32, $90
    db $2C, $35, $32, $31, $99, $EC, $F0

Data_02F_620E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $0A, $10, $15, $F1, $3A, $24, $36, $90, $26, $38, $37
    db $90, $25, $3C, $90, $F9, $10, $99, $EC, $F0

Data_02F_6227:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $0A, $10, $15, $F1, $35, $32, $36, $28, $90, $25, $3C
    db $90, $F9, $10, $99, $EC, $F0

Data_02F_623D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $90, $2F, $32, $36, $37, $F1, $2C, $31, $90, $24
    db $90, $27, $24, $3D, $28, $99, $EC, $F0

Data_02F_6255:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $90, $39, $28, $2C, $2F, $90, $32, $29, $90, $2F, $2C, $2A, $2B, $37
    db $F1, $29, $32, $35, $30, $28, $27, $90, $25, $28, $29, $32, $35, $28, $EC, $F2
    db $ED, $F9, $00, $99, $F1, $EC, $F0

Data_02F_627C:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $90, $39, $28, $2C, $2F, $90, $32, $29, $90, $2F, $2C, $2A, $2B, $37
    db $F1, $29, $32, $35, $30, $28, $27, $90, $25, $28, $29, $32, $35, $28, $EC, $F2
    db $ED, $F9, $00, $99, $F1, $EC, $F0

Data_02F_62A3:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $90, $25, $24, $35, $35, $2C, $28, $35, $90, $32, $29, $F1, $2F, $2C
    db $2A, $2B, $37, $90, $24, $33, $33, $28, $24, $35, $28, $27, $B5, $EC, $F0

Data_02F_62C2:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $26, $38, $35, $28, $27, $90, $32, $29
    db $90, $33, $32, $2C, $36, $32, $31, $B5, $EC, $F0

Data_02F_62DC:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $90, $31, $32, $F1, $2F, $32, $31, $2A, $28, $35
    db $90, $33, $24, $35, $24, $2F, $3C, $3D, $28, $27, $B5, $EC, $F0

Data_02F_62F9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $30, $28, $F1, $25, $24, $26, $2E, $90, $37, $32
    db $90, $2F, $2C, $29, $28, $99, $EC, $F0

Data_02F_6311:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $38, $31, $26, $38, $35, $36, $28, $27
    db $99, $EC, $F0

Data_02F_6324:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $36, $36, $38, $30, $28, $27, $F1, $F9, $10, $3E, $90
    db $29, $32, $35, $30, $99, $EC, $F0

Data_02F_633B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $11, $28, $2F, $33, $90, $24, $35, $35, $2C, $39, $28, $27, $90, $29, $35
    db $32, $30, $F1, $36, $28, $28, $30, $2C, $31, $2A, $2F, $3C, $90, $31, $32, $3A
    db $2B, $28, $35, $28, $99, $EC, $F0

Data_02F_6362:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $25, $2F, $2C, $31, $27, $28, $27, $90
    db $25, $3C, $90, $36, $24, $31, $27, $99, $EC, $F0

Data_02F_637C:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $39, $2C, $36, $2C, $32, $31, $F1, $3A, $24, $36, $90
    db $2B, $24, $35, $30, $28, $27, $99, $EC, $F0

Data_02F_6395:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $3A, $28, $24, $2E, $28, $31, $28, $27
    db $90, $37, $32, $90, $30, $24, $2A, $2C, $26, $99, $EC, $F0

Data_02F_63B1:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $36, $37, $F1, $F9, $10, $16, $19, $99, $EC, $F0

Data_02F_63C1:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2D, $32, $2C, $31, $28, $27, $F1, $37, $2B, $28, $90, $27
    db $24, $31, $26, $2C, $31, $2A, $99, $EC, $F0

Data_02F_63DA:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $32, $2E, $36, $F1, $26, $32, $31, $37, $28, $31
    db $37, $99, $EC, $F0

Data_02F_63EE:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $32, $37, $F1, $2A, $32, $32, $36, $28, $90, $25, $38
    db $30, $33, $36, $99, $EC, $F0

Data_02F_6404:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $32, $37, $F1, $2A, $32, $32, $36, $28, $90, $25, $38
    db $30, $33, $36, $99, $EC, $F2, $ED, $F9, $00, $3E, $90, $0D, $0E, $0F, $F1, $27
    db $35, $32, $33, $33, $28, $27, $90, $37, $32, $90, $95, $01, $95, $99, $EC, $F0

Data_02F_6434:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $36, $2B, $32, $26, $2E, $28, $27, $99
    db $EC, $F0

Data_02F_6446:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $2C, $33, $28, $27, $F1, $32, $38, $37, $99, $EC, $F0

Data_02F_6456:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $36, $37, $F1, $24, $2F, $2F, $90, $24, $33, $33
    db $2F, $2C, $28, $27, $90, $30, $24, $2A, $2C, $26, $99, $EC, $F0

Data_02F_6473:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $38, $35, $31, $28, $27, $F1, $25, $24, $26, $2E, $90
    db $37, $32, $90, $31, $32, $35, $30, $24, $2F, $99, $EC, $F0

Data_02F_648F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $29, $38, $2F, $2F, $3C, $90, $26, $38
    db $35, $28, $27, $99, $EC, $F0

Data_02F_64A5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2D, $32, $2C, $31, $28, $27, $F1, $37, $2B, $28, $90, $25
    db $24, $37, $37, $2F, $28, $99, $EC, $F0

Data_02F_64BD:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $31, $41, $F1, $27, $24, $31, $26, $28, $90, $24
    db $31, $3C, $30, $32, $35, $28, $99, $EC, $F0

Data_02F_64D6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $31, $41, $F1, $27, $24, $31, $26, $28, $90, $24
    db $31, $3C, $30, $32, $35, $28, $99, $EC, $F0

Data_02F_64EF:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $30, $32, $38, $37, $2B, $F1, $3A, $24, $36, $90, $36
    db $28, $24, $2F, $28, $27, $99, $EC, $F0

Data_02F_6507:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $30, $32, $38, $37, $2B, $F1, $3A, $24, $36, $90, $36
    db $28, $24, $2F, $28, $27, $99, $EC, $F0

Data_02F_651F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $90, $24, $F1, $2B, $38, $31, $2E, $90, $32, $29
    db $90, $2C, $35, $32, $31, $99, $EC, $F0

Data_02F_6537:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $2C, $27, $90, $31, $32, $37, $F1, $26, $32, $30, $28
    db $90, $25, $24, $26, $2E, $90, $37, $32, $90, $2F, $2C, $29, $28, $99, $EC, $F0

Data_02F_6557:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0B, $38, $37, $90, $2C, $37, $90, $29, $24, $2C, $2F, $28, $27, $90, $37
    db $32, $F1, $35, $28, $24, $26, $2B, $90, $F9, $00, $99, $EC, $F0

Data_02F_6574:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0B, $38, $37, $90, $37, $2B, $28, $90, $26, $24, $2F, $2F, $90, $3A, $28
    db $31, $37, $F1, $38, $31, $2B, $28, $24, $35, $27, $99, $EC, $F0

Data_02F_6591:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $32, $27, $2A, $28, $27, $F1, $37, $2B, $28, $90, $25
    db $35, $28, $24, $37, $2B, $99, $EC, $F0

Data_02F_65A9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $34, $38, $2C, $26, $2E, $2F, $3C, $F1, $26, $32, $39, $28
    db $35, $28, $27, $90, $2C, $37, $36, $90, $28, $24, $35, $36, $99, $EC, $F0

Data_02F_65C8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $2B, $32, $32, $2E, $F1, $32, $29, $29, $90, $37, $2B
    db $28, $90, $36, $24, $31, $27, $99, $EC, $F0

Data_02F_65E1:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $2F, $32, $36, $28, $27, $F1, $2C, $37, $36, $90, $28
    db $3C, $28, $36, $90, $2C, $31, $90, $37, $2C, $30, $28, $99, $EC, $F0

Data_02F_65FF:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $34, $38, $2C, $26, $2E, $2F, $3C, $F1, $27, $32, $27, $2A
    db $28, $27, $90, $37, $2B, $28, $90, $24, $37, $37, $24, $26, $2E, $99, $EC, $F0

Data_02F_661F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $31, $41, $F1, $37, $24, $2E, $28, $31, $90
    db $2C, $31, $99, $EC, $F0

Data_02F_6634:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $2F, $2C, $27, $F1, $32, $38, $37, $90, $32, $29, $90
    db $37, $2B, $28, $90, $3A, $24, $3C, $99, $EC, $F0

Data_02F_664E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $38, $31, $2B, $24, $35, $30, $28, $27
    db $99, $EC, $F0

Data_02F_6661:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0B, $38, $37, $90, $37, $2B, $28, $90, $33, $35, $24, $3C, $28, $35, $F1
    db $3A, $28, $31, $37, $90, $38, $31, $24, $31, $36, $3A, $28, $35, $28, $27, $99
    db $EC, $F0

Data_02F_6683:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $90, $33, $38, $37, $F1, $37, $32, $90, $36
    db $2F, $28, $28, $33, $99, $EC, $F0

Data_02F_669A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $29, $28, $2F, $2F, $F1, $24, $36, $2F, $28, $28, $33, $99
    db $EC, $F0

Data_02F_66AC:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $33, $32, $2C, $36, $32, $31, $28, $27
    db $99, $EC, $F0

Data_02F_66BF:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $28, $26, $24, $30, $28, $F1, $33, $24, $35, $24, $2F
    db $3C, $3D, $28, $27, $99, $EC, $F0

Data_02F_66D6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $37, $28, $35, $35, $2C, $25, $2F, $3C
    db $90, $33, $32, $2C, $36, $32, $31, $28, $27, $99, $EC, $F0

Data_02F_66F2:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $29, $35, $32, $3D, $28, $F1, $36, $32, $2F, $2C, $27, $99
    db $EC, $F0

Data_02F_6704:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $28, $26, $24, $30, $28, $F1, $29, $35, $32, $3D, $28
    db $31, $90, $36, $32, $2F, $2C, $27, $99, $EC, $F0

Data_02F_671E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $37, $35, $38, $26, $2E, $F1, $25, $24, $26, $2E, $99
    db $EC, $F0

Data_02F_6730:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $32, $38, $2F, $27, $31, $41, $F1, $36, $37, $35, $2C
    db $2E, $28, $90, $25, $24, $26, $2E, $99, $EC, $F0

Data_02F_674A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $F1, $26, $32, $38, $31, $37, $28, $35, $36, $37, $35, $2C
    db $2E, $28, $99, $EC, $F0

Data_02F_675F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $32, $38, $2F, $27, $31, $41, $F1, $35, $28, $37, $24
    db $2F, $2C, $24, $37, $28, $99, $EC, $F0

Data_02F_6777:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $2F, $28, $3A, $F1, $25, $24, $26, $2E, $90, $F9, $10
    db $99, $EC, $F0

Data_02F_678A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $28, $31, $37, $F1, $24, $3A, $24, $3C, $99, $EC, $F0

Data_02F_679A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $3A, $2C, $31, $27, $90, $24, $35, $32, $38, $31, $27
    db $F1, $F9, $00, $90, $27, $2C, $28, $27, $99, $EC, $F0

Data_02F_67B5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $2B, $28, $2F, $33, $90, $3A, $28, $31, $37, $F1, $24
    db $3A, $24, $3C, $99, $EC, $F0

Data_02F_67CB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $3A, $32, $2E, $28, $90, $38, $33, $99, $EC, $F0

Data_02F_67D9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $31, $24, $33, $33, $28, $27, $F1, $32, $38, $37, $90
    db $32, $29, $90, $26, $32, $31, $29, $38, $36, $2C, $32, $31, $99, $EC, $F0

Data_02F_67F8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $F1, $12, $35, $32, $31, $2C, $3D, $28, $90, $3A, $32, $35
    db $28, $90, $32, $29, $29, $99, $EC, $F0

Data_02F_6810:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $3A, $24, $2F, $2F, $F1, $32, $29, $90, $2F, $2C, $2A
    db $2B, $37, $90, $29, $24, $27, $28, $27, $99, $EC, $F0

Data_02F_682B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $2A, $2C, $24, $31, $37, $90, $3A, $28, $31, $37, $F1
    db $24, $3A, $24, $3C, $90, $2F, $24, $38, $2A, $2B, $2C, $31, $2A, $99, $EC, $F0

Data_02F_684B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $F9, $20, $F1, $36, $2B, $24, $37, $37, $28, $35, $28
    db $27, $99, $EC, $F0

Data_02F_685F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $38, $29, $29, $28, $35, $36, $F1, $29, $35, $32, $30
    db $90, $33, $32, $2C, $36, $32, $31, $99, $EC, $F2, $ED, $F9, $00, $90, $2F, $32
    db $36, $37, $F1, $F9, $10, $11, $19, $99, $EC, $F0

Data_02F_6889:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $3A, $35, $24, $26, $2E, $28, $27, $90, $25
    db $3C, $90, $33, $32, $2C, $36, $32, $31, $99, $EC, $F2, $ED, $F9, $00, $90, $2F
    db $32, $36, $37, $F1, $F9, $10, $11, $19, $99, $EC, $F0

Data_02F_68B4:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $2C, $28, $27, $99, $F1, $EC, $F0

Data_02F_68C0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $27, $28, $29, $28, $24, $37, $28, $27
    db $99, $EC, $F0

Data_02F_68D3:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $2C, $28, $27, $F1, $29, $35, $32, $30, $90, $27, $24
    db $31, $26, $2C, $31, $2A, $99, $EC, $F0

Data_02F_68EB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $35, $32, $33, $33, $28, $27, $F1, $27, $28, $24, $27
    db $99, $EC, $F0

Data_02F_68FE:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $2C, $31, $36, $37, $24, $31, $37, $2F
    db $3C, $90, $36, $2F, $24, $2C, $31, $99, $EC, $F0

Data_02F_6918:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $F9, $00, $F1, $36, $2B, $24, $37, $37, $28, $35, $28
    db $27, $99, $EC, $F0

Data_02F_692C:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $35, $32, $33, $33, $28, $27, $F1, $27, $28, $24, $27
    db $99, $EC, $F0

Data_02F_693F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $33, $35, $24, $3C, $28, $35, $F1, $3A, $28, $31, $37
    db $90, $38, $31, $24, $31, $36, $3A, $28, $35, $28, $27, $99, $EC, $F0

Data_02F_695D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1C, $28, $24, $2F, $19, $35, $24, $3C, $90, $3A, $24, $36, $F1, $25, $35
    db $32, $2E, $28, $31, $99, $EC, $F0

Data_02F_6974:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $28, $26, $24, $30, $28, $F1, $29, $2F, $38, $36, $2B
    db $90, $3A, $2C, $37, $2B, $90, $33, $32, $3A, $28, $35, $99, $EC, $F0

Data_02F_6992:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $32, $32, $2E, $F1, $37, $2B, $28, $90, $F9, $20, $90
    db $29, $35, $32, $30, $EC, $F2, $ED, $F9, $10, $B5, $F1, $EC, $F0

Data_02F_69AF:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $37, $28, $90, $37, $2B, $28, $F1, $30, $28, $24, $37
    db $90, $2B, $24, $33, $33, $2C, $2F, $3C, $99, $EC, $F2, $ED, $F9, $00, $90, $2A
    db $35, $28, $3A, $90, $37, $32, $F1, $2F, $2C, $2E, $28, $90, $F9, $10, $99, $EC
    db $F0

Data_02F_69E0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $37, $28, $90, $37, $2B, $28, $F1, $30, $28, $24, $37
    db $90, $29, $28, $24, $35, $29, $38, $2F, $2F, $3C, $99, $EC, $F2, $ED, $F9, $00
    db $90, $2A, $2F, $24, $35, $28, $27, $F1, $24, $37, $90, $F9, $10, $99, $EC, $F0

Data_02F_6A10:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2B, $28, $2F, $27, $90, $37, $2B, $28, $F1, $F9, $20, $90
    db $24, $2F, $32, $29, $37, $99, $EC, $F0

Data_02F_6A28:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $90, $3A, $24, $35, $30, $90, $2F, $2C, $2A, $2B, $37, $90, $36, $2B
    db $32, $31, $28, $F1, $29, $35, $32, $30, $90, $37, $2B, $28, $90, $18, $35, $25
    db $99, $EC, $F0

Data_02F_6A4B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $35, $2C, $33, $33, $28, $27, $F1, $37, $2B, $28, $90
    db $0B, $28, $24, $36, $37, $1D, $24, $2C, $2F, $99, $EC, $F0

Data_02F_6A67:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $0B, $28, $24, $36, $37, $1D, $24, $2C, $2F, $F1, $25
    db $28, $2A, $24, $31, $90, $33, $32, $2C, $31, $37, $2C, $31, $2A, $99, $EC, $F0

Data_02F_6A87:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2B, $28, $2F, $27, $F1, $F9, $20, $90, $24, $2F, $32, $29
    db $37, $99, $EC, $F0

Data_02F_6A9B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0C, $35, $2C, $37, $2C, $26, $24, $2F, $90, $2B, $2C, $37, $99, $F1, $EC
    db $F0

Data_02F_6AAC:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $90, $25, $35, $38, $37, $24, $2F, $90, $2B, $2C, $37, $99, $F1, $EC
    db $F0

Data_02F_6ABD:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $F1, $36, $33, $28, $2F, $2F, $36, $AB, $90, $27, $24, $31
    db $26, $28, $36, $EC, $F2, $ED, $24, $31, $27, $90, $25, $35, $28, $24, $37, $2B
    db $36, $90, $24, $35, $28, $F1, $36, $28, $24, $2F, $28, $27, $99, $EC, $F0

Data_02F_6AEC:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $38, $36, $28, $27, $F1, $37, $2B, $28, $90, $F9, $20, $99
    db $EC, $F0

Data_02F_6AFE:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $32, $36, $36, $28, $27, $F1, $37, $2B, $28, $90, $F9
    db $20, $EC, $F2, $ED, $24, $37, $90, $F9, $10, $99, $F1, $EC, $F0

Data_02F_6B1B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2B, $28, $2F, $27, $90, $24, $2F, $32, $29, $37, $F1, $37
    db $2B, $28, $90, $1C, $24, $2A, $28, $1B, $32, $26, $2E, $99, $EC, $F0

Data_02F_6B39:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $26, $24, $37, $37, $28, $35, $28, $27, $F1, $37, $2B
    db $28, $90, $20, $32, $35, $2F, $27, $0D, $28, $3A, $99, $EC, $F0

Data_02F_6B56:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2B, $28, $2F, $27, $90, $24, $2F, $32, $29, $37, $F1, $37
    db $2B, $28, $90, $F9, $20, $99, $EC, $F2, $ED, $0B, $32, $2F, $37, $36, $90, $32
    db $29, $90, $2F, $2C, $2A, $2B, $37, $31, $2C, $31, $2A, $F1, $2F, $24, $36, $2B
    db $28, $27, $90, $32, $38, $37, $99, $EC, $F0

Data_02F_6B8F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2B, $28, $2F, $27, $90, $24, $2F, $32, $29, $37, $F1, $37
    db $2B, $28, $90, $F9, $20, $99, $EC, $F2, $ED, $1D, $32, $35, $31, $24, $27, $32
    db $28, $36, $90, $2F, $28, $24, $33, $37, $F1, $29, $35, $32, $30, $90, $2C, $37
    db $36, $90, $37, $2C, $33, $99, $EC, $F0

Data_02F_6BC7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2B, $28, $2F, $27, $90, $24, $2F, $32, $29, $37, $F1, $37
    db $2B, $28, $90, $F9, $20, $99, $EC, $F2, $ED, $0A, $90, $36, $2C, $31, $2C, $36
    db $37, $28, $35, $90, $29, $32, $2A, $F1, $27, $28, $36, $26, $28, $31, $27, $28
    db $27, $99, $EC, $F0

Data_02F_6BFB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2B, $28, $2F, $27, $90, $24, $2F, $32, $29, $37, $F1, $37
    db $2B, $28, $90, $F9, $20, $99, $EC, $F2, $ED, $0A, $90, $25, $2F, $2C, $3D, $3D
    db $24, $35, $27, $90, $2B, $32, $3A, $2F, $36, $F1, $29, $35, $32, $30, $90, $2C
    db $37, $36, $90, $37, $2C, $33, $99, $EC, $F0

Data_02F_6C34:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2B, $28, $2F, $27, $90, $24, $2F, $32, $29, $37, $F1, $37
    db $2B, $28, $90, $F9, $20, $99, $EC, $F2, $ED, $0F, $2F, $24, $30, $28, $36, $90
    db $2F, $28, $24, $33, $37, $90, $29, $35, $32, $30, $F1, $2C, $37, $36, $90, $37
    db $2C, $33, $99, $EC, $F0

Data_02F_6C69:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $28, $37, $90, $32, $29, $29, $F1, $24, $90, $37, $32
    db $3A, $28, $35, $2C, $31, $2A, $90, $2A, $28, $3C, $36, $28, $35, $99, $EC, $F0

Data_02F_6C89:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $29, $28, $2F, $2F, $F1, $32, $38, $37, $90, $32, $29, $90
    db $37, $2B, $28, $90, $36, $2E, $3C, $99, $EC, $F0

Data_02F_6CA3:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $24, $35, $28, $EC, $F2
    db $ED, $2F, $32, $32, $2E, $2C, $31, $2A, $90, $29, $32, $35, $90, $24, $F1, $26
    db $2B, $24, $31, $26, $28, $99, $EC, $F0

Data_02F_6CCB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $27, $24, $31, $26, $28
    db $27, $EC, $F2, $ED, $2C, $31, $90, $24, $31, $90, $24, $2F, $2F, $38, $35, $2C
    db $31, $2A, $F1, $29, $24, $36, $2B, $2C, $32, $31, $99, $EC, $F0

Data_02F_6CF8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $25, $24, $35, $35, $2C, $28, $35, $90, $33, $32, $33
    db $33, $28, $27, $F1, $24, $31, $27, $90, $27, $2C, $36, $24, $33, $33, $28, $24
    db $35, $28, $27, $99, $EC, $F0

Data_02F_6D1E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $24, $31, $27, $28, $27, $F1, $24, $3A, $2E, $3A, $24
    db $35, $27, $2F, $3C, $99, $EC, $F2, $ED, $F9, $00, $90, $37, $32, $32, $2E, $F1
    db $F9, $10, $90, $27, $24, $30, $24, $2A, $28, $99, $EC, $F0

Data_02F_6D4A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $24, $31, $27, $28, $27, $F1, $24, $3A, $2E, $3A, $24
    db $35, $27, $2F, $3C, $99, $EC, $F2, $ED, $F9, $00, $90, $37, $32, $32, $2E, $F1
    db $F9, $10, $90, $27, $24, $30, $24, $2A, $28, $99, $EC, $F0

Data_02F_6D76:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $2F, $24, $31, $27, $28, $27, $90, $36, $24, $29, $28, $2F
    db $3C, $99, $EC, $F0

Data_02F_6D8A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $10, $90, $3A, $24, $36, $F1, $36, $2B, $24, $37, $37, $28, $35, $28
    db $27, $99, $EC, $F0

Data_02F_6D9E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $2B, $32, $32, $2E, $F1, $32, $29, $29, $90, $F9, $10
    db $99, $EC, $F0

Data_02F_6DB1:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $24, $35, $28, $EC, $F2
    db $ED, $36, $2B, $2C, $28, $2F, $27, $2C, $31, $2A, $90, $24, $F1, $33, $24, $35
    db $37, $31, $28, $35, $99, $EC, $F0

Data_02F_6DD8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $16, $19, $90, $3A, $24, $36, $F1, $35, $28, $36, $37
    db $32, $35, $28, $27, $90, $25, $3C, $90, $F9, $10, $99, $EC, $F0

Data_02F_6DF5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $25, $28, $2A, $24, $31
    db $EC, $F2, $ED, $37, $32, $90, $26, $32, $31, $26, $28, $31, $37, $35, $24, $37
    db $28, $99, $F1, $EC, $F0

Data_02F_6E1A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0B, $38, $37, $90, $F9, $00, $90, $3A, $24, $36, $F1, $38, $31, $24, $29
    db $29, $28, $26, $37, $28, $27, $99, $EC, $F0

Data_02F_6E33:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $37, $32, $32, $2E, $90, $24, $F1, $3A, $2C, $2F, $27, $90
    db $36, $3A, $2C, $31, $2A, $99, $EC, $F2, $ED, $0A, $31, $27, $90, $30, $24, $31
    db $24, $2A, $28, $27, $90, $37, $32, $F1, $2B, $38, $35, $37, $90, $32, $31, $2F
    db $3C, $90, $2C, $37, $36, $28, $2F, $29, $99, $EC, $F0

Data_02F_6E6E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $36, $2B, $24, $2E, $2C, $31, $2A, $90, $2C
    db $31, $90, $29, $28, $24, $35, $99, $EC, $F0

Data_02F_6E87:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $2B, $24, $35, $2A, $28, $27, $F1, $24, $37, $90, $F9
    db $10, $99, $EC, $F2, $ED, $0B, $38, $37, $90, $37, $35, $2C, $33, $33, $28, $27
    db $90, $24, $31, $27, $F1, $3A, $2C, $33, $28, $27, $90, $32, $38, $37, $99, $EC
    db $F0

Data_02F_6EB8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $28, $26, $24, $30, $28, $F1, $33, $24, $35, $24, $2F
    db $3C, $3D, $28, $27, $99, $EC, $F0

Data_02F_6ECF:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $F1, $24, $37, $37, $24, $26, $2E, $99, $EC, $F2, $ED, $12
    db $37, $90, $24, $33, $33, $28, $24, $35, $36, $90, $38, $31, $24, $25, $2F, $28
    db $F1, $37, $32, $90, $30, $32, $39, $28, $90, $33, $35, $32, $33, $28, $35, $2F
    db $3C, $B5, $EC, $F0

Data_02F_6F03:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $28, $2A, $24, $31, $F1, $27, $24, $31, $26, $2C, $31
    db $2A, $99, $EC, $F0

Data_02F_6F17:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $90, $29, $32, $38, $2F, $90, $25, $28, $2C, $31, $2A, $90, $3A, $24
    db $36, $F1, $36, $38, $30, $30, $32, $31, $28, $27, $99, $EC, $F0

Data_02F_6F34:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $28, $37, $90, $32, $29, $29, $F1, $24, $90, $25, $2F
    db $24, $26, $2E, $90, $26, $2F, $32, $38, $27, $99, $EC, $F0

Data_02F_6F50:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $29, $2C, $2F, $2F, $28, $27, $90, $3A, $2C, $37, $2B, $90
    db $33, $32, $3A, $28, $35, $99, $EC, $F0

Data_02F_6F68:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $36, $37, $F1, $24, $2F, $2F, $90, $2C, $37, $36
    db $90, $16, $19, $99, $EC, $F0

Data_02F_6F7E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $AA, $0C, $2B, $24, $31, $26, $28, $AB, $90, $0C, $2B, $24, $31, $26, $28
    db $AB, $F1, $0C, $2B, $24, $31, $26, $28, $A4, $AA, $EC, $F2, $ED, $1D, $2B, $28
    db $90, $26, $24, $2F, $2F, $90, $28, $26, $2B, $32, $28, $27, $F1, $32, $39, $28
    db $35, $90, $24, $31, $27, $90, $32, $39, $28, $35, $99, $EC, $F0

Data_02F_6FBB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $90, $2F, $24, $38, $2A, $2B, $31, $2A, $90, $2A, $2C, $24, $31, $37
    db $F1, $24, $33, $33, $28, $24, $35, $28, $27, $99, $EC, $F2, $ED, $1D, $2B, $28
    db $90, $2A, $2C, $24, $31, $37, $F1, $24, $37, $37, $24, $26, $2E, $28, $27, $99
    db $EC, $F0

Data_02F_6FED:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $90, $26, $32, $2F, $27, $90, $3A, $2C, $31, $27, $90, $36, $3A, $28
    db $33, $37, $F1, $F9, $00, $3E, $90, $33, $24, $35, $37, $3C, $99, $EC, $F0

Data_02F_700C:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $16, $19, $F1, $3A, $24, $36, $90, $35, $28, $36, $37
    db $32, $35, $28, $27, $99, $EC, $F0

Data_02F_7023:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $28, $37, $28, $32, $35, $36, $90, $35, $24, $2C, $31, $28, $27, $F1
    db $29, $35, $32, $30, $90, $37, $2B, $28, $90, $2B, $28, $24, $39, $28, $31, $36
    db $99, $EC, $F0

Data_02F_7046:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $3A, $24, $2F, $2F, $90, $32, $29, $90, $2F, $2C, $2A
    db $2B, $37, $F1, $25, $32, $38, $31, $26, $28, $27, $90, $37, $2B, $28, $90, $36
    db $33, $28, $2F, $2F, $99, $EC, $F0

Data_02F_706D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $3A, $24, $2F, $2F, $90, $32, $29, $90, $2F, $2C, $2A
    db $2B, $37, $F1, $25, $32, $38, $31, $26, $28, $27, $90, $37, $2B, $28, $90, $36
    db $33, $28, $2F, $2F, $99, $EC, $F0

Data_02F_7094:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $3A, $2C, $31, $27, $90, $24, $35, $32, $38, $31, $27
    db $F1, $F9, $00, $90, $25, $32, $38, $31, $26, $28, $27, $EC, $F2, $ED, $37, $2B
    db $28, $90, $24, $37, $37, $24, $26, $2E, $99, $F1, $EC, $F0

Data_02F_70C0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $36, $2B, $38, $31, $37, $28, $27, $F1, $37, $2B, $28, $90
    db $24, $37, $37, $24, $26, $2E, $99, $EC, $F0

Data_02F_70D9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $29, $24, $2C, $2F, $28, $27, $F1, $37, $32, $90, $24, $39
    db $28, $35, $37, $90, $24, $37, $37, $24, $26, $2E, $99, $EC, $F0

Data_02F_70F6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $38, $24, $35, $27, $28, $27, $F1, $F9, $10, $99, $EC
    db $F0

Data_02F_7107:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $31, $2B, $24, $2F, $28, $27, $F1, $37, $2B, $28, $90
    db $24, $37, $37, $24, $26, $2E, $99, $EC, $F0

Data_02F_7120:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0B, $38, $37, $90, $31, $32, $37, $2B, $2C, $31, $2A, $F1, $2B, $24, $33
    db $33, $28, $31, $28, $27, $99, $EC, $F0

Data_02F_7138:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $0A, $10, $15, $F1, $29, $28, $2F, $2F, $90, $25, $3C
    db $90, $F9, $10, $99, $EC, $F0

Data_02F_714E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $2C, $27, $31, $41, $F1, $29, $24, $2F, $2F, $90, $24
    db $36, $2F, $28, $28, $33, $99, $EC, $F0

Data_02F_7166:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $25, $28, $26, $24, $30, $28, $F1, $30, $32, $35, $28, $90
    db $26, $32, $31, $29, $38, $36, $28, $27, $99, $EC, $F0

Data_02F_7181:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $2C, $36, $36, $99, $90, $F9, $00, $F1, $3A, $24, $36, $90, $38, $31
    db $2B, $24, $35, $30, $28, $27, $99, $EC, $F0

Data_02F_719A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $2C, $36, $36, $99, $90, $F9, $00, $F1, $24, $39, $32, $2C, $27, $28
    db $27, $90, $27, $24, $30, $24, $2A, $28, $99, $EC, $F0

Data_02F_71B5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $28, $24, $33, $37, $F1, $32, $38, $37, $90, $32, $29
    db $90, $37, $2B, $28, $90, $3A, $24, $3C, $99, $EC, $F0

Data_02F_71D0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $35, $32, $33, $33, $28, $27, $F1, $27, $28, $24, $27
    db $99, $EC, $F0, $2F, $28, $24, $33, $37, $90

Data_02F_71E9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $24, $2F, $35, $28, $24, $27, $3C, $90, $24
    db $36, $2F, $28, $28, $33, $99, $EC, $F0

Data_02F_7201:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $90, $31, $32, $3A, $F1, $3A, $28, $24, $2E, $90
    db $37, $32, $90, $36, $33, $28, $2F, $2F, $36, $99, $EC, $F0

Data_02F_721D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $90, $2A, $28, $31, $37, $2F, $28, $90, $35, $24, $2C, $31, $F1, $29
    db $28, $2F, $2F, $99, $EC, $F0

Data_02F_7233:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2B, $24, $36, $F1, $25, $28, $28, $31, $90, $2C, $30, $30
    db $32, $25, $2C, $2F, $2C, $3D, $28, $27, $99, $EC, $F0

Data_02F_724E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $29, $2F, $28, $27, $99, $F1, $EC, $F0

Data_02F_725A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $26, $38, $35, $36, $28, $27, $99, $EC
    db $F0

Data_02F_726B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $25, $38, $2C, $2F, $27, $2C, $31, $2A, $90
    db $33, $32, $3A, $28, $35, $99, $EC, $F0

Data_02F_7283:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $36, $37, $F1, $24, $2F, $2F, $90, $24, $33, $33
    db $2F, $2C, $28, $27, $90, $30, $24, $2A, $2C, $26, $99, $EC, $F0

Data_02F_72A0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $24, $39, $28, $90, $24, $F1, $33, $32, $3A, $27, $28
    db $35, $33, $38, $29, $29, $90, $30, $24, $36, $36, $24, $2A, $28, $EC, $F2, $ED
    db $37, $32, $90, $F9, $10, $99, $F1, $EC, $F0

Data_02F_72C9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $F1, $25, $2F, $32, $3A, $31, $90, $36, $2E
    db $3C, $9C, $2B, $2C, $2A, $2B, $99, $EC, $F0

Data_02F_72E2:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $31, $41, $F1, $27, $24, $31, $26, $28, $90, $24
    db $31, $3C, $30, $32, $35, $28, $99, $EC, $F0

Data_02F_72FB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $36, $37, $F1, $2C, $37, $36, $90, $16, $19, $99
    db $EC, $F0

Data_02F_730D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $32, $2E, $36, $F1, $39, $24, $26, $24, $31, $37
    db $90, $24, $31, $27, $90, $2F, $32, $36, $37, $99, $EC, $F0

Data_02F_7329:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2C, $36, $F1, $2A, $38, $24, $35, $27, $2C, $31, $2A, $90
    db $2C, $37, $36, $28, $2F, $29, $99, $EC, $F0

Data_02F_7342:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $32, $37, $F1, $27, $2C, $3D, $3D, $3C, $90, $24, $31
    db $27, $90, $29, $28, $2F, $2F, $99, $EC, $F0

Data_02F_735B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $32, $36, $37, $F1, $25, $24, $2F, $24, $31, $26, $28
    db $90, $24, $31, $27, $90, $29, $28, $2F, $2F, $99, $EC, $F0

Data_02F_7377:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $35, $32, $33, $33, $28, $27, $F1, $27, $32, $3A, $31
    db $AB, $90, $24, $36, $2F, $28, $28, $33, $99, $EC, $F0

Data_02F_7392:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $29, $28, $2F, $2F, $F1, $24, $31, $27, $90, $3A, $32, $2E
    db $28, $90, $38, $33, $99, $EC, $F0

Data_02F_73A9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $26, $24, $31, $41, $F1, $28, $24, $37, $90, $3A, $2B, $2C
    db $2F, $28, $EC, $F2, $ED, $33, $24, $35, $24, $2F, $3C, $3D, $28, $27, $99, $EC
    db $F0

Data_02F_73CA:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1D, $2B, $28, $90, $3A, $2C, $31, $27, $90, $24, $35, $32, $38, $31, $27
    db $F1, $F9, $00, $90, $27, $2C, $28, $27, $99, $EC, $F0

Data_02F_73E5:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $3A, $24, $2F, $2F, $F1, $32, $29, $90, $2F, $2C, $2A
    db $2B, $37, $90, $29, $24, $27, $28, $27, $99, $EC, $F0

Data_02F_7400:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $3A, $24, $37, $28, $35, $F1, $25, $24, $35, $35, $2C
    db $28, $35, $90, $35, $28, $24, $26, $37, $28, $27, $99, $EC, $F0

Data_02F_741D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $3A, $24, $37, $28, $35, $F1, $25, $24, $35, $35, $2C
    db $28, $35, $90, $35, $28, $24, $26, $37, $28, $27, $99, $EC, $F0

Data_02F_743A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $38, $35, $31, $28
    db $27, $EC, $F2, $ED, $1D, $2B, $32, $35, $27, $24, $2C, $31, $90, $2C, $31, $37
    db $32, $F1, $0A, $2F, $2F, $27, $24, $2C, $31, $99, $EC, $F0

Data_02F_7466:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $38, $35, $31, $28
    db $27, $EC, $F2, $ED, $0B, $2F, $24, $3D, $28, $16, $32, $36, $37, $90, $24, $31
    db $27, $F1, $0B, $2F, $2C, $3D, $3D, $24, $35, $27, $90, $2C, $31, $37, $32, $EC
    db $F2, $ED, $0B, $2F, $2C, $37, $3D, $28, $35, $99, $F1, $EC, $F0

Data_02F_74A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BF4A3, $48

Data_02F_74EB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BF4EB, $42

Data_02F_752D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BF52D, $47

Data_02F_7574:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $38, $35, $31, $28
    db $27, $EC, $F2, $ED, $37, $3A, $32, $90, $10, $2C, $2A, $24, $1C, $2F, $24, $36
    db $2B, $28, $36, $F1, $2C, $31, $37, $32, $90, $10, $2C, $2A, $24, $0B, $35, $28
    db $24, $2E, $99, $EC, $F0

Data_02F_75A9:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $38, $35, $31, $28
    db $27, $EC, $F2, $ED, $37, $3A, $32, $90, $1C, $24, $26, $35, $2C, $29, $2C, $26
    db $28, $36, $F1, $2C, $31, $37, $32, $90, $16, $24, $35, $37, $3C, $35, $99, $EC
    db $F0

Data_02F_75DA:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $2B, $38, $35, $2F, $28
    db $27, $EC, $F2, $ED, $F9, $20, $90, $2B, $2C, $2A, $2B, $F1, $24, $31, $27, $90
    db $27, $35, $32, $33, $33, $28, $27, $90, $2C, $37, $99, $EC, $F0

Data_02F_7607:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $30, $24, $27, $28, $EC
    db $F2, $ED, $1C, $34, $38, $24, $2F, $2F, $11, $2C, $37, $90, $29, $24, $36, $37
    db $28, $35, $F1, $38, $36, $2C, $31, $2A, $90, $1C, $33, $28, $28, $27, $1E, $33
    db $99, $EC, $F0

Data_02F_763A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BF63A, $55

Data_02F_768F:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $36, $24, $31, $2A, $EC
    db $F2, $ED, $24, $31, $27, $90, $27, $24, $31, $26, $28, $27, $90, $37, $32, $F1
    db $36, $38, $30, $30, $32, $31, $90, $24, $90, $36, $33, $2C, $35, $2C, $37, $99
    db $EC, $F0

Data_02F_76C1:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $36, $24, $31, $2A, $EC
    db $F2, $ED, $24, $31, $27, $90, $27, $24, $31, $26, $28, $27, $90, $37, $32, $F1
    db $36, $38, $30, $30, $32, $31, $90, $27, $28, $24, $37, $2B, $99, $EC, $F0

Data_02F_76F0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $38, $35, $31, $28
    db $27, $EC, $F2, $ED, $2C, $31, $37, $32, $90, $24, $90, $2B, $38, $2A, $28, $F1
    db $27, $35, $24, $2A, $32, $31, $99, $EC, $F0

Data_02F_7719:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $37, $38, $35, $31, $28
    db $27, $EC, $F2, $ED, $37, $2B, $28, $2C, $35, $90, $36, $2E, $2C, $2F, $2F, $36
    db $90, $2C, $31, $37, $32, $F1, $24, $90, $3A, $24, $39, $28, $90, $32, $29, $90
    db $28, $31, $28, $35, $2A, $3C, $99, $EC, $F0

Data_02F_7752:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $2F, $32, $32, $36, $28
    db $27, $EC, $F2, $ED, $24, $90, $3A, $2B, $2C, $37, $28, $AB, $90, $32, $25, $36
    db $26, $38, $35, $2C, $31, $2A, $F1, $26, $2F, $32, $38, $27, $99, $EC, $F0

Data_02F_7781:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $24, $31, $27, $F1, $F9, $10, $90, $26, $35, $28, $24, $37
    db $28, $27, $EC, $F2, $24, $90, $39, $24, $26, $38, $38, $30, $90, $29, $32, $35
    db $F1, $36, $37, $28, $24, $2F, $2C, $31, $2A, $90, $16, $19, $99, $EC, $F0

Data_02F_77B0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0C, $35, $2C, $37, $2C, $26, $24, $2F, $90, $2B, $2C, $37, $99, $F1, $EC
    db $F0

Data_02F_77C1:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $90, $25, $35, $38, $37, $24, $2F, $90, $2B, $2C, $37, $99, $F1, $EC
    db $F0

Data_02F_77D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BF7D2, $46

Data_02F_7818:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $24, $37, $28, $90, $37, $2B
    db $28, $F1, $30, $28, $24, $37, $90, $29, $28, $24, $35, $29, $38, $2F, $2F, $3C
    db $99, $EC, $F2, $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $2A, $2F, $24
    db $35, $28, $27, $F1, $24, $37, $90, $F9, $10, $99, $EC, $F0

Data_02F_7854:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $16, $32, $31, $36, $37, $28, $35, $36, $90, $3A, $28, $35, $28, $F1, $29
    db $2C, $2F, $2F, $28, $27, $90, $3A, $2C, $37, $2B, $90, $33, $32, $3A, $28, $35
    db $99, $EC, $F0

Data_02F_7877:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $3B, $28, $27, $F0

Data_02F_787D:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $38, $37, $32, $F0

Data_02F_7882:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $3B, $28, $27, $F0

Data_02F_7888:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $38, $37, $32, $F0

Data_02F_788D:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $31, $27, $28, $29, $2C, $31, $28, $27, $F0

Data_02F_7897:: ; heuristic: target of a monotone pointer table; C0
    db $EF, $EE, $F6, $3E, $90, $33, $24, $35, $37, $3C, $90, $2A, $32, $37, $EF, $EE
    db $F9, $00, $90, $0E, $21, $90, $33, $32, $2C, $31, $37, $36, $99, $FA, $F7, $F0

Data_02F_78B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BF8B7, $8B

Data_02F_7942:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $37, $90, $15, $39, $F9, $10, $AB, $90, $F9, $00, $90, $F1, $2F, $28
    db $24, $35, $31, $28, $27, $90, $F9, $20, $99, $FA, $F7, $F0

Data_02F_795E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $3E, $90, $F9, $30, $F1, $25, $28, $26, $24, $30, $28, $90, $F9
    db $20, $99, $FA, $F7, $F0

Data_02F_7973:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $27, $28, $39, $2C, $36, $28, $27, $F1, $F9, $20, $90, $29
    db $35, $32, $30, $90, $37, $2B, $28, $FA, $F7, $F2, $ED, $36, $2E, $2C, $2F, $2F
    db $36, $90, $2C, $37, $90, $2E, $31, $32, $3A, $36, $99, $FA, $F7, $F0

Data_02F_79A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0BF9A1, $46

Data_02F_79E7:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $20, $2B, $2C, $26, $2B, $90, $36, $2E, $2C, $2F, $2F, $90, $36, $2B, $32
    db $38, $2F, $27, $F1, $25, $28, $90, $29, $32, $35, $2A, $32, $37, $37, $28, $31
    db $98, $FA, $F7, $F0

Data_02F_7A0B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0F, $32, $35, $2A, $28, $37, $90, $F9, $20, $98, $F1, $0A, $35, $28, $90
    db $3C, $32, $38, $90, $36, $38, $35, $28, $98, $F0

Data_02F_7A25:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $20, $90, $3A, $24, $36, $F1, $29, $32, $35, $2A, $32, $37, $37, $37
    db $28, $31, $B5, $FA, $F7, $F0

Data_02F_7A3B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $12, $37, $90, $2B, $24, $36, $90, $35, $28, $24, $26, $2B, $28, $27, $90
    db $37, $2B, $28, $F1, $2F, $2C, $30, $2C, $37, $90, $29, $32, $35, $90, $2A, $35
    db $32, $3A, $37, $2B, $B5, $FA, $F7, $F0

Data_02F_7A63:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $32, $37, $90, $38, $33, $AB, $F1, $2F, $32, $32, $2E
    db $2C, $31, $2A, $90, $2B, $32, $33, $28, $29, $38, $2F, $B5, $FA, $F7, $F2, $ED
    db $0A, $2F, $2F, $32, $3A, $90, $F9, $00, $90, $F1, $37, $32, $90, $2D, $32, $2C
    db $31, $90, $3C, $32, $38, $98, $F0

Data_02F_7A9A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $F1, $27, $28, $33, $24, $35, $37, $28, $27, $90, $36, $24, $27
    db $2F, $3C, $A4, $FA, $F7, $F0

Data_02F_7AB0:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0B, $38, $37, $90, $37, $2B, $28, $35, $28, $90, $2C, $36, $90, $31, $32
    db $F1, $30, $32, $35, $28, $90, $35, $32, $32, $30, $99, $FA, $F7, $F2, $ED, $1B
    db $28, $2F, $28, $24, $36, $28, $90, $24, $90, $30, $32, $31, $36, $37, $28, $35
    db $F1, $37, $32, $90, $30, $24, $2E, $28, $90, $35, $32, $32, $30, $98, $F0

Data_02F_7AEF:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $20, $2B, $2C, $26, $2B, $90, $3A, $2C, $2F, $2F, $90, $3C, $32, $38, $F1
    db $26, $2B, $32, $32, $36, $28, $98, $F0

Data_02F_7B07:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $22, $32, $38, $90, $2B, $24, $39, $28, $90, $31, $32, $90, $28, $2A, $2A
    db $36, $B5, $FA, $F7, $F0

Data_02F_7B1C:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1B, $28, $2F, $28, $24, $36, $28, $90, $24, $90, $30, $32, $31, $36, $37
    db $28, $35, $F1, $29, $32, $35, $90, $37, $2B, $28, $90, $31, $28, $3A, $90, $32
    db $31, $28, $98, $F0

Data_02F_7B40:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0C, $2B, $32, $32, $36, $28, $90, $24, $90, $30, $32, $31, $36, $37, $28
    db $35, $F1, $37, $32, $90, $35, $28, $2F, $28, $24, $36, $28, $B5, $F0

Data_02F_7B5E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0D, $32, $90, $3C, $32, $38, $90, $3A, $24, $31, $37, $90, $37, $32, $F1
    db $35, $28, $2F, $28, $24, $36, $28, $90, $F9, $10, $98, $F0

Data_02F_7B7A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $10, $90, $3A, $24, $36, $90, $36, $28, $37, $F1, $29, $35, $28, $28
    db $90, $2C, $31, $90, $37, $2B, $28, $90, $3A, $2C, $2F, $27, $B5, $FA, $F7, $F0

Data_02F_7B9A:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $19, $2F, $28, $24, $36, $28, $90, $31, $24, $30, $28, $F1, $F9, $00, $B5
    db $FA, $F7, $F0

Data_02F_7BAD:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $22, $32, $38, $90, $26, $24, $31, $41, $90, $37, $35, $24, $39, $28, $2F
    db $F1, $24, $2F, $2F, $90, $24, $2F, $32, $31, $28, $B5, $FA, $F7, $F0

Data_02F_7BCB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0C, $2B, $32, $32, $36, $28, $90, $24, $31, $90, $28, $2A, $2A, $90, $37
    db $32, $F1, $24, $25, $24, $31, $27, $32, $31, $B5, $F0

Data_02F_7BE6:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0A, $25, $24, $31, $27, $32, $31, $90, $F9, $10, $3E, $F1, $28, $2A, $2A
    db $98, $F0

Data_02F_7BF8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $10, $3E, $90, $28, $2A, $2A, $F1, $3A, $24, $36, $90, $24, $25, $24
    db $31, $27, $32, $31, $28, $27, $B5, $FA, $F7, $F0

Data_02F_7C12:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $20, $2C, $2F, $2F, $90, $3C, $32, $38, $90, $37, $24, $2E, $28, $F1, $F9
    db $00, $90, $3A, $2C, $37, $2B, $90, $3C, $32, $38, $98, $F0

Data_02F_7C2E:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $90, $36, $28, $31, $37, $F1, $25, $24, $26
    db $2E, $90, $37, $32, $90, $37, $2B, $28, $90, $29, $24, $35, $30, $B5, $E5, $D6
    db $FA, $F7, $F0

Data_02F_7C51:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2D, $32, $2C, $31, $28, $27, $90, $37, $2B, $28, $F1, $33
    db $24, $35, $37, $3C, $B5, $E5, $D6, $FA, $F7, $F0

Data_02F_7C6B:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $0C, $2B, $32, $32, $36, $28, $90, $37, $2B, $28, $90, $30, $32, $31, $36
    db $37, $28, $35, $F1, $37, $32, $90, $36, $28, $31, $27, $90, $2B, $32, $30, $28
    db $B5, $F0

Data_02F_7C8D:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $1C, $28, $31, $27, $90, $F9, $00, $90, $25, $24, $26, $2E, $90, $37, $32
    db $F1, $37, $2B, $28, $90, $29, $24, $35, $30, $98, $F0

Data_02F_7CA8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2A, $32, $37, $90, $38, $33, $AB, $F1, $2F, $32, $32, $2E
    db $2C, $31, $2A, $90, $2B, $32, $33, $28, $29, $38, $2F, $B5, $FA, $F7, $F2, $ED
    db $0B, $38, $37, $90, $2C, $37, $90, $36, $24, $27, $2F, $3C, $90, $3A, $28, $31
    db $37, $F1, $24, $3A, $24, $3C, $A4, $FA, $F7, $F0

Data_02F_7CE2:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2F, $28, $24, $35, $31, $28, $27, $F1, $F9, $10, $99, $F7
    db $F0

Data_02F_7CF3:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $3A, $24, $36, $90, $36, $28, $31, $37, $90, $37, $32, $F1
    db $37, $2B, $28, $90, $29, $24, $35, $30, $B5, $E5, $54, $FA, $F7, $F0

Data_02F_7D11:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $F9, $00, $90, $2D, $32, $2C, $31, $28, $27, $90, $37, $2B, $28, $F1, $33
    db $24, $35, $37, $3C, $B5, $E5, $54, $FA, $F7, $F0
    ds $2D5, $00
