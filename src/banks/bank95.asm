SECTION "Bank 95", ROMX[$4000], BANK[$95]
    INCBIN "dwm2-cobi-us.gbc", $254000, $650

Func_095_4650::
    ld de, $4675
    ld a, [$C528]
    sub a, $09
    ld [$C528], a
    call Func_000_25C9
    ret

Func_095_465F::
    ld de, $4675
    ld a, [$C528]
    sub a, $09
    ld [$C528], a
    call Func_000_25FE
    ret
    db $CD, $50, $46, $CD, $11, $26, $C9, $8D, $46, $ED, $47, $EF, $47, $37, $48, $39
    db $48, $47, $48, $53, $48, $57, $48, $69, $48, $7F, $48, $B7, $48, $C7, $48
    dw Data_095_48CF
    dw Data_095_48CF
    dw Data_095_48F2
    dw Data_095_491A
    dw Data_095_4945
    dw Data_095_4971
    dw Data_095_499C
    dw Data_095_49CB
    dw Data_095_49F2
    dw Data_095_4A24
    dw Data_095_4A49
    dw Data_095_4A75
    dw Data_095_4A9A
    dw Data_095_4AC7
    dw Data_095_4AE9
    dw Data_095_4B19
    dw Data_095_4B45
    dw Data_095_4B75
    dw Data_095_4B96
    dw Data_095_4BC5
    dw Data_095_4BE0
    dw Data_095_4C00
    dw Data_095_4C34
    dw Data_095_4C4B
    dw Data_095_4C62
    dw Data_095_4C76
    dw Data_095_4C94
    dw Data_095_4CAE
    dw Data_095_4CCE
    dw Data_095_4CEE
    dw Data_095_4D0E
    dw Data_095_4D2A
    dw Data_095_4D43
    dw Data_095_4D76
    dw Data_095_4D94
    dw Data_095_4DBC
    dw Data_095_4DDE
    dw Data_095_4DF4
    dw Data_095_4E10
    dw Data_095_4E34
    dw Data_095_4E4E
    dw Data_095_4E71
    dw Data_095_4E8D
    dw Data_095_4EB1
    dw Data_095_4ECB
    dw Data_095_4EEE
    dw Data_095_4F0F
    dw Data_095_4F32
    dw Data_095_4F4F
    dw Data_095_4F69
    dw Data_095_4F9A
    dw Data_095_4FB4
    dw Data_095_4FDB
    dw Data_095_4FF2
    dw Data_095_5022
    dw Data_095_503E
    dw Data_095_505E
    dw Data_095_5088
    dw Data_095_50B6
    dw Data_095_50DF
    dw Data_095_510C
    dw Data_095_5131
    dw Data_095_514D
    dw Data_095_5172
    dw Data_095_519B
    dw Data_095_51C8
    dw Data_095_51F4
    dw Data_095_5225
    dw Data_095_5251
    dw Data_095_527D
    dw Data_095_52AB
    dw Data_095_52D9
    dw Data_095_5306
    dw Data_095_5336
    dw Data_095_5362
    dw Data_095_5383
    dw Data_095_53AA
    dw Data_095_53D5
    dw Data_095_53FD
    dw Data_095_5423
    dw Data_095_5454
    dw Data_095_546B
    dw Data_095_5492
    dw Data_095_54BD
    dw Data_095_54EF
    dw Data_095_551B
    dw Data_095_5548
    dw Data_095_5574
    dw Data_095_559F
    dw Data_095_55C9
    dw Data_095_55F5
    dw Data_095_5621
    dw Data_095_564E
    dw Data_095_567D
    dw Data_095_56A9
    dw Data_095_56CE
    dw Data_095_56FC
    dw Data_095_572C
    dw Data_095_5760
    dw Data_095_5784
    dw Data_095_57B8
    dw Data_095_57E3
    dw Data_095_580A
    dw Data_095_582E
    dw Data_095_584A
    dw Data_095_5873
    dw Data_095_58A2
    dw Data_095_58CF
    dw Data_095_58FB
    dw Data_095_5928
    dw Data_095_5959
    dw Data_095_598C
    dw Data_095_59B9
    dw Data_095_59EB
    dw Data_095_5A17
    dw Data_095_5A3C
    dw Data_095_5A5F
    dw Data_095_5A88
    dw Data_095_5AA6
    dw Data_095_5AC9
    dw Data_095_5AEB
    dw Data_095_5B0E
    dw Data_095_5B39
    dw Data_095_5B69
    dw Data_095_5B95
    dw Data_095_5BBE
    dw Data_095_5BE8
    dw Data_095_5C10
    dw Data_095_5C39
    dw Data_095_5C5E
    dw Data_095_5C8C
    dw Data_095_5CA7
    dw Data_095_5CD9
    dw Data_095_5D0C
    dw Data_095_5D26
    dw Data_095_5D40
    dw Data_095_5D5A
    dw Data_095_5D74
    dw Data_095_5DAA
    dw Data_095_5DCF
    dw Data_095_5DF8
    dw Data_095_5E1C
    dw Data_095_5E45
    dw Data_095_5E71
    dw Data_095_5E92
    dw Data_095_5EBB
    dw Data_095_5EE3
    dw Data_095_5F06
    dw Data_095_5F36
    dw Data_095_5F66
    dw Data_095_5F97
    dw Data_095_5FC2
    dw Data_095_5FEF
    dw Data_095_601B
    dw Data_095_6045
    dw Data_095_6075
    dw Data_095_609E
    dw Data_095_60C0
    dw Data_095_60F0
    dw Data_095_610C
    dw Data_095_612D
    dw Data_095_6158
    dw Data_095_6178
    dw Data_095_6192
    dw Data_095_61C2
    dw Data_095_61ED
    dw Data_095_6222
    dw Data_095_6249
    dw Data_095_6273
    dw Data_095_629C
    dw Data_095_62C2
    dw Data_095_62E3
    dw Data_095_62E3
    dw Data_095_62E3
    dw Data_095_62E3
    dw Data_095_62E3
    dw Data_095_62E4
    dw Data_095_62E5
    dw Data_095_62EB
    dw Data_095_62F4
    dw Data_095_62FF
    dw Data_095_630A
    dw Data_095_6313
    dw Data_095_631E
    dw Data_095_6329
    dw Data_095_6334
    dw Data_095_633F
    dw Data_095_634A
    dw Data_095_6358
    dw Data_095_6362
    dw Data_095_636B
    dw Data_095_6376
    dw Data_095_6381
    dw Data_095_638D
    dw Data_095_6397
    dw Data_095_63A2
    dw Data_095_63AC
    dw Data_095_63B7
    dw Data_095_63C0
    dw Data_095_63C0
    dw Data_095_63C0
    dw Data_095_63C0
    dw Data_095_63C0
    dw Data_095_63C0
    dw Data_095_63C2
    dw Data_095_63CC
    dw Data_095_63D8
    dw Data_095_63E1
    dw Data_095_63EB
    dw Data_095_63F6
    dw Data_095_6402
    dw Data_095_640D
    dw Data_095_6419
    dw Data_095_641B
    dw Data_095_641C
    dw Data_095_6422
    dw Data_095_642C
    dw Data_095_6437
    dw Data_095_6442
    dw Data_095_6448
    dw Data_095_644D
    dw Data_095_6457
    dw Data_095_6457
    dw Data_095_645E
    dw Data_095_6465
    dw Data_095_646B
    dw Data_095_6474
    dw Data_095_647C
    dw Data_095_647C
    dw Data_095_647C
    dw Data_095_647D
    dw Data_095_6484
    dw Data_095_648A
    dw Data_095_6493
    dw Data_095_649B
    dw Data_095_64A2
    dw Data_095_64AC
    dw Data_095_64B1
    dw Data_095_64B6
    dw Data_095_64BE
    dw Data_095_64C6
    dw Data_095_64D2
    dw Data_095_64E1
    dw Data_095_64EA
    dw Data_095_64F6
    dw Data_095_64FF
    dw Data_095_650A
    dw Data_095_650F
    dw Data_095_6513
    dw Data_095_651A
    dw Data_095_651F
    dw Data_095_6525
    dw Data_095_652D
    dw Data_095_6532
    dw Data_095_653B
    dw Data_095_6540
    dw Data_095_6548
    dw Data_095_6551
    dw Data_095_6557
    dw Data_095_655C
    dw Data_095_6565
    dw Data_095_656F
    dw Data_095_6578
    dw Data_095_657C
    dw Data_095_6584
    dw Data_095_658E
    dw Data_095_6598
    dw Data_095_659D
    dw Data_095_65A6
    dw Data_095_65AD
    dw Data_095_65B7
    dw Data_095_65BD
    dw Data_095_65C2
    dw Data_095_65C8
    dw Data_095_65CF
    dw Data_095_65D6
    dw Data_095_65DB
    dw Data_095_65E1
    dw Data_095_65E8
    dw Data_095_65EF
    dw Data_095_65F6
    dw Data_095_65FD
    dw Data_095_6604
    dw Data_095_660B
    dw Data_095_6612
    dw Data_095_6619
    dw Data_095_661E
    dw Data_095_6625
    dw Data_095_662B

Data_095_48CF:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $24, $26, $2E, $36, $90, $24, $31, $90, $28, $31, $28, $30, $3C
    db $F1, $3A, $2C, $37, $2B, $90, $24, $90, $29, $2C, $35, $28, $25, $24, $2F, $2F
    db $B5, $F1, $F0

Data_095_48F2:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $24, $26, $2E, $36, $90, $24, $31, $90, $28, $31, $28, $30, $3C
    db $F1, $3A, $2C, $37, $2B, $90, $24, $90, $2F, $24, $35, $2A, $28, $F1, $29, $2C
    db $35, $28, $25, $24, $2F, $2F, $B5, $F0

Data_095_491A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $37, $32, $3A, $28, $35, $2C, $31, $2A, $90, $33, $2C, $2F, $2F, $24
    db $35, $F1, $32, $29, $90, $29, $2C, $35, $28, $90, $35, $32, $24, $36, $37, $36
    db $90, $24, $31, $F1, $28, $31, $28, $30, $3C, $B5, $F0

Data_095_4945:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $24, $26, $2E, $36, $90, $28, $31, $28, $30, $2C, $28, $36, $F1
    db $3A, $2C, $37, $2B, $90, $24, $90, $25, $2F, $24, $36, $37, $90, $32, $29, $F1
    db $29, $2C, $35, $28, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4971:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $24, $26, $2E, $36, $90, $28, $31, $28, $30, $2C, $28, $36, $F1
    db $3A, $2C, $37, $2B, $90, $24, $90, $3A, $24, $2F, $2F, $90, $32, $29, $F1, $29
    db $2C, $35, $28, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_499C:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $2B, $38, $2A, $28, $90, $3A, $24, $2F, $2F, $90, $32, $29, $F1, $29
    db $2C, $35, $28, $90, $2C, $31, $26, $2C, $31, $28, $35, $24, $37, $28, $36, $F1
    db $28, $31, $28, $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_49CB:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $2F, $2F, $90, $28, $3B, $33, $2F, $32, $36, $2C, $32, $31, $36
    db $F1, $36, $37, $35, $2C, $2E, $28, $90, $28, $31, $28, $30, $2C, $28, $36, $F1
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_49F2:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $36, $38, $26, $26, $28, $36, $36, $2C, $32, $31, $90, $32, $29, $F1
    db $28, $3B, $33, $2F, $32, $36, $2C, $32, $31, $36, $90, $36, $37, $35, $2C, $2E
    db $28, $36, $F1, $28, $31, $28, $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1
    db $B5, $F0

Data_095_4A24:: ; heuristic: target of a monotone pointer table; C0
    db $11, $38, $2A, $28, $90, $28, $3B, $33, $2F, $32, $36, $2C, $32, $31, $36, $F1
    db $25, $2F, $24, $36, $37, $90, $28, $31, $28, $30, $2C, $28, $36, $F1, $A0, $24
    db $2F, $2F, $A1, $B5, $F0

Data_095_4A49:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $3D, $32, $35, $90, $36, $2B, $24, $35, $33, $F1, $3A, $2B, $2C, $35
    db $2F, $3A, $2C, $31, $27, $36, $90, $36, $2F, $24, $36, $2B, $F1, $28, $31, $28
    db $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4A75:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3A, $2C, $36, $37, $28, $35, $36, $90, $37, $28, $24, $35, $F1, $37, $2B
    db $35, $32, $38, $2A, $2B, $90, $28, $31, $28, $30, $2C, $28, $36, $F1, $A0, $24
    db $2F, $2F, $A1, $B5, $F0

Data_095_4A9A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $2B, $38, $2A, $28, $90, $37, $32, $35, $31, $24, $27, $32, $F1, $35
    db $32, $24, $35, $36, $90, $37, $2B, $35, $32, $38, $2A, $2B, $F1, $28, $31, $28
    db $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0, $90

Data_095_4AC7:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $2A, $2B, $37, $31, $2C, $31, $2A, $90, $36, $37, $35, $2C, $2E, $28
    db $36, $F1, $28, $31, $28, $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1, $B5
    db $F1, $F0

Data_095_4AE9:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $3A, $28, $35, $29, $38, $2F, $90, $25, $32, $2F, $37, $36, $90, $32
    db $29, $F1, $2F, $2C, $2A, $2B, $37, $31, $2C, $31, $2A, $90, $2F, $24, $36, $2B
    db $F1, $28, $31, $28, $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4B19:: ; heuristic: target of a monotone pointer table; C0
    db $11, $38, $2A, $28, $90, $36, $2B, $24, $35, $27, $36, $90, $32, $29, $F1, $2F
    db $2C, $2A, $2B, $37, $31, $2C, $31, $2A, $90, $35, $2C, $33, $F1, $28, $31, $28
    db $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4B45:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $2F, $2F, $90, $26, $2B, $38, $31, $2E, $36, $90, $32, $29, $F1
    db $2C, $26, $28, $90, $2B, $24, $2C, $2F, $90, $27, $32, $3A, $31, $90, $32, $31
    db $F1, $28, $31, $28, $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4B75:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $31, $28, $30, $2C, $28, $36, $90, $24, $35, $28, $90, $29, $2F, $24, $36
    db $2B, $F1, $29, $35, $32, $3D, $28, $31, $90, $A0, $24, $2F, $2F, $A1, $B5, $F1
    db $F0

Data_095_4B96:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $3A, $2C, $26, $2E, $28, $27, $90, $25, $2F, $2C, $3D, $3D, $24, $35
    db $27, $F1, $2B, $32, $3A, $2F, $36, $90, $37, $2B, $35, $32, $38, $2A, $2B, $F1
    db $28, $31, $28, $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_4BC5:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $36, $37, $24, $31, $37, $2F, $3C, $90, $36, $2F, $24, $3C, $36, $90
    db $24, $31, $F1, $28, $31, $28, $30, $3C, $B5, $F1, $F0

Data_095_4BE0:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $36, $37, $24, $31, $37, $2F, $3C, $90, $36, $2F, $24, $3C, $36, $F1
    db $28, $31, $28, $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4C00:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $38, $36, $28, $35, $90, $28, $3B, $33, $2F, $32, $27, $28
    db $36, $F1, $37, $32, $90, $2C, $31, $29, $2F, $2C, $26, $37, $90, $27, $24, $30
    db $24, $2A, $28, $F1, $32, $31, $90, $24, $2F, $2F, $90, $28, $31, $28, $30, $2C
    db $28, $36, $B5, $F0

Data_095_4C34:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $32, $35, $28, $36, $90, $11, $19, $90, $25, $3C, $F1, $03
    db $00, $9D, $04, $00, $B5, $F1, $F0

Data_095_4C4B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $32, $35, $28, $36, $90, $11, $19, $90, $25, $3C, $F1, $07
    db $05, $9D, $09, $00, $B5, $F1, $F0

Data_095_4C62:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $38, $2F, $2F, $3C, $90, $35, $28, $36, $37, $32, $35, $28, $36, $F1, $11
    db $19, $B5, $F1, $F0

Data_095_4C76:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $32, $35, $28, $36, $90, $11, $19, $90, $25, $3C, $F1, $09
    db $00, $9D, $01, $02, $00, $90, $A0, $24, $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4C94:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $38, $2F, $2F, $3C, $90, $35, $28, $36, $37, $32, $35, $28, $36, $90, $11
    db $19, $F1, $A0, $24, $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4CAE:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $39, $28, $36, $90, $01, $05, $16, $19, $90, $37, $32, $90, $24, $F1
    db $33, $24, $35, $37, $3C, $90, $30, $32, $31, $36, $37, $28, $35, $B5, $F1, $F0

Data_095_4CCE:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $39, $28, $36, $90, $03, $00, $16, $19, $90, $37, $32, $90, $24, $F1
    db $33, $24, $35, $37, $3C, $90, $30, $32, $31, $36, $37, $28, $35, $B5, $F1, $F0

Data_095_4CEE:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $39, $28, $36, $90, $08, $00, $16, $19, $90, $37, $32, $90, $24, $F1
    db $33, $24, $35, $37, $3C, $90, $30, $32, $31, $36, $37, $28, $35, $B5, $F1, $F0

Data_095_4D0E:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $3C, $90, $35, $28, $39, $2C, $39, $28, $90, $24, $90, $27, $28, $24
    db $27, $F1, $30, $32, $31, $36, $37, $28, $35, $B5, $F1, $F0

Data_095_4D2A:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $39, $2C, $39, $28, $36, $90, $24, $90, $27, $28, $24, $27, $F1, $30
    db $32, $31, $36, $37, $28, $35, $B5, $F1, $F0

Data_095_4D43:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $39, $2C, $39, $28, $36, $90, $27, $28, $24, $27, $90, $30, $24, $37
    db $28, $36, $F1, $2C, $31, $90, $28, $3B, $26, $2B, $24, $31, $2A, $28, $90, $29
    db $32, $35, $F1, $32, $3A, $31, $90, $2F, $2C, $29, $28, $90, $A0, $24, $2F, $2F
    db $A1, $B5, $F0

Data_095_4D76:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $35, $28, $36, $90, $32, $31, $28, $90, $30, $32, $31, $36, $37, $28
    db $35, $F1, $32, $29, $90, $33, $32, $2C, $36, $32, $31, $B5, $F1, $F0

Data_095_4D94:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $28, $24, $35, $36, $90, $26, $32, $31, $29, $38, $36, $2C, $32, $31
    db $F1, $2C, $31, $90, $24, $2F, $2F, $90, $33, $24, $35, $37, $3C, $F1, $30, $32
    db $31, $36, $37, $28, $35, $36, $B5, $F0

Data_095_4DBC:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $35, $28, $36, $90, $33, $24, $35, $24, $2F, $3C, $36, $2C, $36, $F1
    db $24, $31, $27, $90, $36, $2F, $28, $28, $33, $90, $A0, $24, $2F, $2F, $A1, $B5
    db $F1, $F0

Data_095_4DDE:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $37, $36, $90, $24, $90, $26, $38, $35, $36, $28, $F1, $A0, $24
    db $2F, $2F, $A1, $B5, $F1, $F0

Data_095_4DF4:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0D, $0E, $0F, $90, $32, $29, $90, $32, $31
    db $28, $F1, $30, $32, $31, $36, $37, $28, $35, $B5, $F1, $F0

Data_095_4E10:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0D, $0E, $0F, $90, $32, $29, $F1, $33, $24
    db $35, $37, $3C, $90, $30, $32, $31, $36, $37, $28, $35, $36, $F1, $A0, $24, $2F
    db $2F, $A1, $B5, $F0

Data_095_4E34:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $3A, $28, $35, $36, $90, $0D, $0E, $0F, $90, $32, $29, $90, $32, $31
    db $28, $F1, $28, $31, $28, $30, $3C, $B5, $F1, $F0

Data_095_4E4E:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $3A, $28, $35, $36, $90, $0D, $0E, $0F, $90, $32, $29, $90, $24, $2F
    db $2F, $F1, $28, $31, $28, $30, $3C, $90, $30, $32, $31, $36, $37, $28, $35, $36
    db $B5, $F1, $F0

Data_095_4E71:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0A, $10, $15, $90, $32, $29, $90, $32, $31
    db $28, $F1, $30, $32, $31, $36, $37, $28, $35, $B5, $F1, $F0

Data_095_4E8D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0A, $10, $15, $90, $32, $29, $F1, $33, $24
    db $35, $37, $3C, $90, $30, $32, $31, $36, $37, $28, $35, $36, $F1, $A0, $24, $2F
    db $2F, $A1, $B5, $F0

Data_095_4EB1:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $3A, $28, $35, $36, $90, $0A, $10, $15, $90, $32, $29, $90, $32, $31
    db $28, $F1, $28, $31, $28, $30, $3C, $B5, $F1, $F0

Data_095_4ECB:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $3A, $28, $35, $36, $90, $0A, $10, $15, $90, $32, $29, $90, $24, $2F
    db $2F, $F1, $28, $31, $28, $30, $3C, $90, $30, $32, $31, $36, $37, $28, $35, $36
    db $B5, $F1, $F0

Data_095_4EEE:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $32, $38, $25, $2F, $28, $36, $90, $37, $2B, $28, $90, $0A, $1D, $14, $90
    db $32, $29, $F1, $32, $31, $28, $90, $30, $32, $31, $36, $37, $28, $35, $B5, $F1
    db $F0

Data_095_4F0F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $35, $35, $32, $38, $31, $27, $36, $90, $24, $2F, $2F, $F1, $28, $31
    db $28, $30, $2C, $28, $36, $90, $2C, $31, $90, $24, $F1, $30, $2C, $35, $24, $2A
    db $28, $B5, $F0

Data_095_4F32:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $28, $36, $90, $24, $90, $36, $2C, $31, $2A, $2F, $28, $F1, $28
    db $31, $28, $30, $3C, $90, $36, $2F, $28, $28, $33, $B5, $F1, $F0

Data_095_4F4F:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $28, $36, $90, $24, $2F, $2F, $90, $28, $31, $28, $30, $2C, $28
    db $36, $F1, $36, $2F, $28, $28, $33, $B5, $F1, $F0

Data_095_4F69:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $25, $36, $32, $35, $25, $36, $90, $37, $2B, $28, $90, $16, $19, $90, $32
    db $29, $F1, $24, $90, $36, $33, $28, $2F, $2F, $90, $26, $24, $36, $37, $F1, $24
    db $2A, $24, $2C, $31, $36, $37, $90, $37, $2B, $28, $90, $38, $36, $28, $35, $B5
    db $F0

Data_095_4F9A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $28, $24, $2F, $36, $90, $16, $19, $90, $29, $35, $32, $30, $90, $24
    db $31, $F1, $28, $31, $28, $30, $3C, $B5, $F1, $F0

Data_095_4FB4:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $39, $28, $31, $37, $36, $90, $36, $33, $28, $2F, $2F, $F1, $26
    db $24, $36, $37, $2C, $31, $2A, $90, $25, $3C, $90, $24, $2F, $2F, $F1, $28, $31
    db $28, $30, $2C, $28, $36, $B5, $F0

Data_095_4FDB:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $31, $29, $38, $36, $28, $36, $90, $24, $2F, $2F, $F1, $28, $31, $28
    db $30, $2C, $28, $36, $B5, $F1, $F0

Data_095_4FF2:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $31, $2A, $28, $36, $90, $24, $2F, $2F, $90, $33, $24, $35, $37
    db $3C, $F1, $30, $32, $31, $36, $37, $28, $35, $36, $90, $2C, $31, $37, $32, $F1
    db $26, $2B, $38, $31, $2E, $36, $90, $32, $29, $90, $2C, $35, $32, $31, $B5, $F0

Data_095_5022:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $38, $31, $26, $28, $36, $90, $25, $24, $26, $2E, $90, $24, $F1, $36
    db $33, $28, $2F, $2F, $90, $32, $31, $26, $28, $B5, $F1, $F0

Data_095_503E:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $38, $31, $26, $28, $36, $90, $25, $24, $26, $2E, $90, $24, $2F, $2F
    db $F1, $28, $31, $28, $30, $3C, $90, $36, $33, $28, $2F, $2F, $36, $B5, $F1, $F0

Data_095_505E:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $27, $38, $26, $28, $36, $90, $27, $24, $30, $24, $2A, $28, $F1, $29
    db $35, $32, $30, $90, $25, $35, $28, $24, $37, $2B, $F1, $24, $37, $37, $24, $26
    db $2E, $36, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5088:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $33, $35, $32, $37, $28, $26, $37, $2C, $32
    db $31, $F1, $24, $2A, $24, $2C, $31, $36, $37, $90, $30, $24, $2A, $2C, $26, $F1
    db $36, $33, $28, $2F, $2F, $36, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_50B6:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $24, $31, $36, $29, $32, $35, $30, $36, $90, $37, $2B, $28, $F1, $38
    db $36, $28, $35, $90, $2C, $31, $37, $32, $90, $24, $90, $26, $2B, $32, $36, $28
    db $31, $F1, $28, $31, $28, $30, $3C, $B5, $F0

Data_095_50DF:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $24, $31, $36, $29, $32, $35, $30, $36, $90, $37, $2B, $28, $F1, $38
    db $36, $28, $35, $90, $2C, $31, $37, $32, $90, $24, $F1, $29, $28, $35, $32, $26
    db $2C, $32, $38, $36, $90, $27, $35, $24, $2A, $32, $31, $B5, $F0

Data_095_510C:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $35, $28, $90, $2C, $36, $90, $31, $32, $F1, $37, $28, $2F, $2F
    db $2C, $31, $2A, $90, $3A, $2B, $24, $37, $90, $30, $24, $3C, $F1, $2B, $24, $33
    db $33, $28, $31, $B5, $F0

Data_095_5131:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $38, $2F, $37, $2C, $30, $24, $37, $28, $F1, $24, $37, $37
    db $24, $26, $2E, $90, $36, $33, $28, $2F, $2F, $B5, $F1, $F0

Data_095_514D:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $24, $37, $28, $36, $90, $24, $31, $F1, $28, $31, $32, $35, $30
    db $32, $38, $36, $90, $28, $3B, $33, $2F, $32, $36, $2C, $32, $31, $F1, $A0, $24
    db $2F, $2F, $A1, $B5, $F0

Data_095_5172:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $35, $2C, $2E, $28, $36, $90, $24, $2F, $2F, $F1, $28, $31, $28, $30
    db $2C, $28, $36, $90, $3A, $2C, $37, $2B, $90, $2B, $38, $2A, $28, $F1, $2F, $2C
    db $2A, $2B, $37, $31, $2C, $31, $2A, $B5, $F0

Data_095_519B:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $27, $24, $30, $24, $2A, $28, $F1
    db $3A, $2C, $37, $2B, $90, $24, $90, $25, $35, $28, $24, $37, $2B, $90, $32, $29
    db $F1, $29, $2C, $35, $28, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_51C8:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $27, $24, $30, $24, $2A, $28, $F1
    db $3A, $2C, $37, $2B, $90, $24, $90, $25, $2F, $24, $36, $37, $90, $32, $29, $F1
    db $29, $2C, $35, $28, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_51F4:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $27, $24, $30, $24, $2A, $28, $F1
    db $3A, $2C, $37, $2B, $90, $24, $90, $2B, $38, $2A, $28, $90, $25, $2F, $24, $36
    db $37, $F1, $32, $29, $90, $29, $2C, $35, $28, $90, $A0, $24, $2F, $2F, $A1, $B5
    db $F0

Data_095_5225:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $27, $24, $30, $24, $2A, $28, $F1
    db $3A, $2C, $37, $2B, $90, $2C, $31, $26, $35, $28, $27, $2C, $25, $2F, $28, $F1
    db $29, $2C, $35, $28, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5251:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $27, $24, $30, $24, $2A, $28, $F1
    db $3A, $2C, $37, $2B, $90, $24, $90, $25, $35, $28, $24, $37, $2B, $90, $32, $29
    db $F1, $2C, $26, $28, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_527D:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $27, $24, $30, $24, $2A, $28, $F1
    db $3A, $2C, $37, $2B, $90, $24, $90, $29, $35, $28, $28, $3D, $2C, $31, $2A, $F1
    db $25, $35, $28, $24, $37, $2B, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_52AB:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $27, $24, $30, $24, $2A, $28, $90
    db $25, $3C, $F1, $28, $3B, $2B, $24, $2F, $2C, $31, $2A, $90, $24, $F1, $25, $2F
    db $2C, $3D, $3D, $24, $35, $27, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_52D9:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $32, $36, $28, $36, $90, $24, $90, $3A, $2B, $2C, $37, $28, $AB, $F1
    db $36, $2B, $2C, $31, $2C, $31, $2A, $90, $25, $35, $28, $24, $37, $2B, $90, $32
    db $29, $F1, $2C, $26, $28, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5306:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $24, $36, $2B, $28, $36, $90, $24, $90, $36, $2C, $31, $2A, $2F, $28
    db $F1, $30, $32, $31, $36, $37, $28, $35, $90, $3A, $2C, $37, $2B, $90, $36, $2B
    db $24, $35, $33, $F1, $3A, $2B, $2C, $35, $2F, $3A, $2C, $31, $27, $36, $B5, $F0

Data_095_5336:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $24, $37, $28, $36, $90, $24, $90, $37, $32, $35, $31, $24, $27
    db $32, $F1, $3A, $2C, $37, $2B, $90, $39, $2C, $26, $2C, $32, $38, $36, $90, $3A
    db $2C, $31, $27, $36, $F1, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5362:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $24, $F1, $2F, $2C, $2A, $2B, $37, $31
    db $2C, $31, $2A, $90, $36, $37, $32, $35, $30, $F1, $A0, $24, $2F, $2F, $A1, $B5
    db $F0

Data_095_5383:: ; heuristic: target of a monotone pointer table; C0
    db $11, $38, $35, $2F, $36, $90, $2A, $2C, $24, $31, $37, $F1, $25, $32, $38, $2F
    db $27, $28, $35, $36, $90, $24, $37, $F1, $28, $31, $28, $30, $2C, $28, $36, $90
    db $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_53AA:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $32, $32, $37, $36, $90, $24, $90, $2B, $2C, $2A, $2B, $F1, $39, $32
    db $2F, $38, $30, $28, $90, $32, $29, $90, $3A, $24, $37, $28, $35, $90, $24, $37
    db $F1, $24, $31, $90, $28, $31, $28, $30, $3C, $B5, $F0

Data_095_53D5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $24, $90, $37, $32, $3A, $28, $35, $2C
    db $31, $2A, $F1, $3A, $24, $2F, $2F, $90, $32, $29, $90, $3A, $24, $37, $28, $35
    db $F1, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_53FD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $29, $35, $2C, $28, $31, $27, $36, $F1
    db $3A, $2B, $32, $90, $24, $37, $37, $24, $26, $2E, $90, $2C, $31, $F1, $27, $35
    db $32, $39, $28, $36, $B5, $F0

Data_095_5423:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $24, $90, $30, $24, $36, $36, $90, $32
    db $29, $F1, $29, $35, $2C, $28, $31, $27, $36, $90, $37, $2B, $24, $37, $F1, $24
    db $37, $37, $24, $26, $2E, $90, $2C, $31, $90, $27, $35, $32, $39, $28, $36, $B5
    db $F0

Data_095_5454:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $29, $2C, $28, $35, $3C, $90, $36, $3A, $32, $35, $27, $F1, $24, $37
    db $37, $24, $26, $2E, $B5, $F1, $F0

Data_095_546B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $36, $3A, $32, $35, $27, $90, $24, $37, $37, $24, $26, $2E, $F1, $28
    db $31, $2B, $24, $31, $26, $28, $27, $90, $25, $3C, $F1, $3A, $2B, $2C, $35, $2F
    db $3A, $2C, $31, $27, $36, $B5, $F0

Data_095_5492:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $36, $3A, $32, $35, $27, $90, $24, $37, $37, $24, $26, $2E, $F1, $30
    db $24, $27, $28, $90, $36, $37, $35, $32, $31, $2A, $28, $35, $90, $25, $3C, $F1
    db $2F, $2C, $2A, $2B, $37, $31, $2C, $31, $2A, $B5, $F0

Data_095_54BD:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $36, $3A, $32, $35, $27, $90, $24, $37, $37, $24, $26, $2E, $F1, $30
    db $24, $27, $28, $90, $36, $37, $35, $32, $31, $2A, $28, $35, $90, $25, $3C, $F1
    db $37, $2B, $28, $90, $33, $32, $3A, $28, $35, $90, $32, $29, $90, $2C, $26, $28
    db $B5, $F0

Data_095_54EF:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $F1, $36, $2F
    db $2C, $30, $28, $90, $29, $24, $30, $2C, $2F, $3C, $B5, $F0

Data_095_551B:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $F1, $27, $35
    db $24, $2A, $32, $31, $90, $29, $24, $30, $2C, $2F, $3C, $B5, $F0

Data_095_5548:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $F1, $25, $28
    db $24, $36, $37, $90, $29, $24, $30, $2C, $2F, $3C, $B5, $F0

Data_095_5574:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $F1, $25, $2C
    db $35, $27, $90, $29, $24, $30, $2C, $2F, $3C, $B5, $F0

Data_095_559F:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $F1, $25, $38
    db $2A, $90, $29, $24, $30, $2C, $2F, $3C, $B5, $F0

Data_095_55C9:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $F1, $33, $2F
    db $24, $31, $37, $90, $29, $24, $30, $2C, $2F, $3C, $B5, $F0

Data_095_55F5:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $F1, $27, $28
    db $39, $2C, $2F, $90, $29, $24, $30, $2C, $2F, $3C, $B5, $F0

Data_095_5621:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $F1, $3D, $32
    db $30, $25, $2C, $28, $90, $29, $24, $30, $2C, $2F, $3C, $B5, $F0

Data_095_564E:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $F1, $30, $24
    db $37, $28, $35, $2C, $24, $2F, $90, $29, $24, $30, $2C, $2F, $3C, $B5, $F0

Data_095_567D:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $F1, $3A, $24
    db $37, $28, $35, $90, $29, $24, $30, $2C, $2F, $3C, $B5, $F0

Data_095_56A9:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $27, $24, $30, $24, $2A, $28, $F1
    db $32, $31, $90, $24, $90, $2B, $2C, $2A, $2B, $90, $0D, $0E, $0F, $F1, $28, $31
    db $28, $30, $3C, $B5, $F0

Data_095_56CE:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $33, $2B, $3C, $36, $2C, $26, $24, $2F, $90, $24, $37, $37, $24, $26
    db $2E, $F1, $37, $2B, $24, $37, $90, $30, $24, $3C, $90, $33, $32, $2C, $36, $32
    db $31, $F1, $37, $2B, $28, $90, $37, $24, $35, $2A, $28, $37, $B5, $F0

Data_095_56FC:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $33, $2B, $3C, $36, $2C, $26, $24, $2F, $90, $24, $37, $37, $24, $26
    db $2E, $F1, $37, $2B, $24, $37, $90, $30, $24, $3C, $90, $33, $24, $35, $24, $2F
    db $3C, $3D, $28, $F1, $37, $2B, $28, $90, $37, $24, $35, $2A, $28, $37, $B5, $F0

Data_095_572C:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $33, $2B, $3C, $36, $2C, $26, $24, $2F, $90, $24, $37, $37, $24, $26
    db $2E, $F1, $37, $2B, $24, $37, $90, $30, $24, $3C, $90, $33, $38, $37, $90, $37
    db $2B, $28, $F1, $37, $24, $35, $2A, $28, $37, $90, $37, $32, $90, $36, $2F, $28
    db $28, $33, $B5, $F0

Data_095_5760:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $33, $2B, $3C, $36, $2C, $26, $24, $2F, $90, $24, $37, $37, $24, $26
    db $2E, $F1, $37, $2B, $24, $37, $90, $2B, $2C, $37, $36, $90, $29, $2C, $35, $36
    db $37, $B5, $F1, $F0

Data_095_5784:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $33, $2B, $3C, $36, $2C, $26, $24, $2F, $90, $24, $37, $37, $24, $26
    db $2E, $F1, $37, $2B, $24, $37, $90, $36, $37, $35, $2C, $2E, $28, $36, $90, $37
    db $3A, $2C, $26, $28, $F1, $2C, $31, $90, $36, $38, $26, $26, $28, $36, $36, $2C
    db $32, $31, $B5, $F0

Data_095_57B8:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $33, $2B, $3C, $36, $2C, $26, $24, $2F, $90, $24, $37, $37, $24, $26
    db $2E, $F1, $37, $2B, $24, $37, $90, $36, $37, $35, $2C, $2E, $28, $36, $90, $29
    db $32, $38, $35, $F1, $37, $2C, $30, $28, $36, $B5, $F0

Data_095_57E3:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $36, $3A, $32, $35, $27, $90, $24, $37, $37, $24, $26, $2E, $F1, $37
    db $2B, $24, $37, $90, $2B, $2C, $37, $36, $90, $24, $2F, $2F, $F1, $28, $31, $28
    db $30, $2C, $28, $36, $B5, $F0, $F0

Data_095_580A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $26, $35, $32, $36, $36, $9C, $26, $38, $37, $37, $2C, $31, $2A, $F1
    db $36, $3A, $32, $35, $27, $90, $24, $37, $37, $24, $26, $2E, $F1, $A0, $24, $2F
    db $2F, $A1, $B5, $F0

Data_095_582E:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $38, $2F, $37, $2C, $30, $24, $37, $28, $90, $36, $3A, $32
    db $35, $27, $F1, $24, $37, $37, $24, $26, $2E, $B5, $F1, $F0

Data_095_584A:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $37, $2B, $28, $90, $31, $28
    db $3B, $37, $F1, $37, $38, $35, $31, $B5, $F0

Data_095_5873:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $24, $37, $90, $37, $2B, $28, $90, $28, $31
    db $27, $F1, $32, $29, $90, $37, $2B, $28, $90, $37, $38, $35, $31, $B5, $F0

Data_095_58A2:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $38, $36, $28, $35, $90, $2F, $28, $24, $33, $36, $90, $24
    db $31, $27, $F1, $24, $37, $37, $24, $26, $2E, $36, $90, $2C, $31, $90, $37, $2B
    db $28, $F1, $31, $28, $3B, $37, $90, $37, $38, $35, $31, $B5, $F0

Data_095_58CF:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $33, $32, $3A, $28, $35, $29, $38, $2F, $AB, $90, $25, $38, $37, $F1
    db $3A, $2C, $2F, $27, $2F, $3C, $90, $24, $2C, $30, $28, $27, $AB, $F1, $36, $3A
    db $32, $35, $27, $90, $24, $37, $37, $24, $26, $2E, $B5, $F0

Data_095_58FB:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $90, $32, $31, $90, $32, $31, $28, $F1, $29, $35
    db $2C, $28, $31, $27, $90, $32, $35, $90, $29, $32, $28, $B5, $F0

Data_095_5928:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $2F, $2C, $26, $37, $36, $90, $36, $28, $39, $28, $35, $28, $F1
    db $27, $24, $30, $24, $2A, $28, $AB, $90, $25, $38, $37, $90, $24, $2F, $36, $32
    db $F1, $2B, $38, $35, $37, $36, $90, $37, $2B, $28, $90, $38, $36, $28, $35, $B5
    db $F0

Data_095_5959:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $33, $32, $3A, $28, $35, $29, $38, $2F, $90, $24, $37, $37, $24, $26
    db $2E, $F1, $37, $2B, $24, $37, $90, $2F, $28, $24, $39, $28, $36, $90, $37, $2B
    db $28, $F1, $38, $36, $28, $35, $90, $39, $38, $2F, $31, $28, $35, $24, $25, $2F
    db $28, $B5, $F0

Data_095_598C:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $29, $38, $2F, $2F, $9C, $25, $32, $27, $3C, $90, $37, $24, $26, $2E
    db $2F, $28, $F1, $37, $2B, $24, $37, $90, $24, $2F, $36, $32, $90, $2B, $38, $35
    db $37, $36, $F1, $37, $2B, $28, $90, $38, $36, $28, $35, $B5, $F0

Data_095_59B9:: ; heuristic: target of a monotone pointer table; C0
    db $15, $28, $24, $39, $28, $36, $90, $37, $2B, $28, $90, $38, $36, $28, $35, $F1
    db $24, $31, $27, $90, $37, $24, $35, $2A, $28, $37, $90, $32, $31, $90, $37, $2B
    db $28, $F1, $39, $28, $35, $2A, $28, $90, $32, $29, $90, $27, $28, $24, $37, $2B
    db $B5, $F0

Data_095_59EB:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $35, $28, $24, $37, $2B, $90, $37, $2B, $24, $37, $F1, $2C, $31
    db $27, $38, $26, $28, $36, $90, $36, $2F, $28, $28, $33, $90, $2C, $31, $F1, $24
    db $2F, $2F, $90, $28, $31, $28, $30, $2C, $28, $36, $B5, $F0

Data_095_5A17:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $35, $28, $24, $37, $2B, $90, $37, $2B, $24, $37, $F1, $33, $24
    db $35, $24, $2F, $3C, $3D, $28, $36, $90, $24, $2F, $2F, $F1, $28, $31, $28, $30
    db $2C, $28, $36, $B5, $F0

Data_095_5A3C:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $35, $28, $24, $37, $2B, $90, $37, $2B, $24, $37, $F1, $33, $32
    db $2C, $36, $32, $31, $36, $90, $24, $2F, $2F, $F1, $28, $31, $28, $30, $2C, $28
    db $36, $B5, $F0

Data_095_5A5F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $35, $28, $24, $37, $2B, $90, $37, $2B, $24, $37, $F1, $25, $24
    db $27, $2F, $3C, $90, $33, $32, $2C, $36, $32, $31, $36, $90, $24, $2F, $2F, $F1
    db $28, $31, $28, $30, $2C, $28, $36, $B5, $F0

Data_095_5A88:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $3C, $36, $90, $24, $90, $26, $38, $35, $36, $28, $90, $32, $31, $F1
    db $24, $2F, $2F, $90, $28, $31, $28, $30, $2C, $28, $36, $B5, $F1, $F0

Data_095_5AA6:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $27, $24, $31, $26, $28, $90, $37, $2B, $24, $37, $F1, $35, $28, $27
    db $38, $26, $28, $36, $90, $24, $31, $90, $28, $31, $28, $30, $3C, $3E, $F1, $16
    db $19, $B5, $F0

Data_095_5AC9:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $27, $24, $31, $26, $28, $90, $37, $2B, $24, $37, $F1, $36, $37, $28
    db $24, $2F, $36, $90, $24, $31, $90, $28, $31, $28, $30, $3C, $3E, $F1, $16, $19
    db $B5, $F0

Data_095_5AEB:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $27, $24, $31, $26, $28, $90, $37, $2B, $24, $37, $F1, $26, $32, $31
    db $29, $38, $36, $28, $36, $90, $24, $2F, $2F, $F1, $28, $31, $28, $30, $2C, $28
    db $36, $B5, $F0

Data_095_5B0E:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $27, $24, $31, $26, $28, $90, $37, $2B, $24, $37, $F1, $2C, $31, $27
    db $38, $26, $28, $36, $90, $27, $28, $24, $37, $2B, $90, $2C, $31, $F1, $24, $2F
    db $2F, $90, $28, $31, $28, $30, $2C, $28, $36, $B5, $F0

Data_095_5B39:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $27, $24, $31, $26, $28, $90, $37, $2B, $24, $37, $90, $30, $24, $2E
    db $28, $36, $F1, $24, $2F, $2F, $90, $28, $31, $28, $30, $2C, $28, $36, $90, $3A
    db $24, $31, $37, $F1, $37, $32, $90, $2D, $32, $2C, $31, $90, $2C, $31, $B5, $F0

Data_095_5B69:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $36, $24, $26, $35, $2C, $29, $2C, $26, $2C, $24, $2F, $F1, $27, $24
    db $31, $26, $28, $90, $37, $32, $90, $35, $28, $39, $2C, $39, $28, $F1, $27, $28
    db $24, $27, $90, $29, $35, $2C, $28, $31, $27, $36, $B5, $F0

Data_095_5B95:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $27, $24, $31, $26, $28, $90, $37, $2B, $24, $37, $F1, $35, $28, $36
    db $37, $32, $35, $28, $36, $90, $11, $19, $90, $25, $3C, $F1, $07, $00, $9D, $08
    db $00, $90, $A0, $24, $2F, $2F, $A1, $B5, $F0

Data_095_5BBE:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $34, $38, $2C, $26, $2E, $9C, $29, $32, $32, $37, $28, $27, $F1, $36
    db $2E, $2C, $2F, $2F, $90, $29, $32, $35, $90, $27, $32, $27, $2A, $2C, $31, $2A
    db $F1, $24, $37, $37, $24, $26, $2E, $36, $B5, $F0

Data_095_5BE8:: ; heuristic: target of a monotone pointer table; C0
    db $18, $25, $36, $26, $38, $35, $28, $36, $90, $37, $2B, $28, $F1, $39, $2C, $36
    db $2C, $25, $2C, $2F, $2C, $37, $3C, $90, $32, $29, $90, $24, $2F, $2F, $F1, $28
    db $31, $28, $30, $2C, $28, $36, $B5, $F0

Data_095_5C10:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $2F, $24, $36, $37, $90, $32, $29, $90, $2F, $2C, $2A, $2B, $37
    db $F1, $25, $2F, $2C, $31, $27, $36, $90, $24, $2F, $2F, $90, $37, $2B, $28, $F1
    db $28, $31, $28, $30, $2C, $28, $36, $B5, $F0

Data_095_5C39:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $24, $2E, $28, $31, $36, $90, $24, $2F, $2F, $F1, $28, $31, $28, $30
    db $2C, $28, $36, $90, $37, $32, $90, $30, $24, $2A, $2C, $26, $F1, $36, $33, $28
    db $2F, $2F, $36, $B5, $F0

Data_095_5C5E:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2F, $2C, $30, $2C, $31, $24, $37, $28, $36, $90, $24, $2F, $2F, $F1, $36
    db $37, $24, $37, $38, $36, $90, $33, $35, $32, $25, $2F, $28, $30, $36, $F1, $24
    db $30, $32, $31, $2A, $90, $29, $35, $2C, $28, $31, $27, $36, $B5, $F0

Data_095_5C8C:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $28, $24, $37, $2F, $3C, $90, $3A, $28, $24, $2E, $28, $31, $36, $90
    db $24, $31, $F1, $28, $31, $28, $30, $3C, $B5, $F1, $F0

Data_095_5CA7:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $37, $36, $90, $37, $2B, $28, $90, $28, $29, $29, $28, $26, $37
    db $36, $F1, $32, $29, $90, $24, $2F, $2F, $90, $36, $33, $28, $2F, $2F, $36, $90
    db $32, $31, $F1, $28, $31, $28, $30, $2C, $28, $36, $90, $A0, $24, $2F, $2F, $A1
    db $B5, $F0

Data_095_5CD9:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $24, $37, $28, $36, $90, $24, $90, $29, $32, $2A, $90, $37, $2B
    db $24, $37, $F1, $33, $35, $28, $39, $28, $31, $37, $36, $90, $37, $2B, $28, $90
    db $38, $36, $28, $F1, $32, $29, $90, $24, $2F, $2F, $90, $36, $33, $28, $2F, $2F
    db $36, $B5, $F0

Data_095_5D0C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $1D, $24, $37, $36, $38, $90, $37, $32
    db $F1, $25, $24, $37, $37, $2F, $28, $B5, $F1, $F0

Data_095_5D26:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $0D, $2C, $24, $2A, $32, $90, $37, $32
    db $F1, $25, $24, $37, $37, $2F, $28, $B5, $F1, $F0

Data_095_5D40:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $1C, $24, $30, $36, $2C, $90, $37, $32
    db $F1, $25, $24, $37, $37, $2F, $28, $B5, $F1, $F0

Data_095_5D5A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $0B, $24, $3D, $32, $32, $90, $37, $32
    db $F1, $25, $24, $37, $37, $2F, $28, $B5, $F1, $F0

Data_095_5D74:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $2F, $27, $36, $90, $2C, $31, $90, $24, $90, $25, $35, $28, $24, $37
    db $2B, $F1, $37, $32, $90, $2C, $31, $29, $2F, $2C, $26, $37, $90, $36, $28, $39
    db $28, $35, $28, $F1, $27, $24, $30, $24, $2A, $28, $90, $31, $28, $3B, $37, $90
    db $37, $38, $35, $31, $B5, $F0

Data_095_5DAA:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $31, $24, $25, $2F, $28, $36, $90, $37, $3A, $32, $90, $30, $32, $39, $28
    db $36, $F1, $2C, $31, $90, $37, $2B, $28, $90, $31, $28, $3B, $37, $90, $37, $38
    db $35, $31, $B5, $F1, $F0

Data_095_5DCF:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $26, $2E, $36, $90, $32, $31, $28, $90, $28, $31, $28, $30, $3C, $90
    db $37, $32, $F1, $36, $37, $32, $33, $90, $2C, $37, $90, $29, $32, $35, $90, $32
    db $31, $28, $F1, $37, $38, $35, $31, $B5, $F0

Data_095_5DF8:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $26, $2E, $36, $90, $32, $31, $28, $90, $28, $31, $28, $30, $3C, $90
    db $37, $32, $F1, $35, $28, $27, $38, $26, $28, $90, $2C, $37, $36, $90, $0D, $0E
    db $0F, $B5, $F1, $F0

Data_095_5E1C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $28, $28, $33, $36, $90, $37, $2B, $28, $90, $2F, $28, $2A, $90, $32
    db $38, $37, $F1, $29, $35, $32, $30, $90, $38, $31, $27, $28, $35, $90, $32, $31
    db $28, $F1, $28, $31, $28, $30, $3C, $B5, $F0

Data_095_5E45:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $28, $28, $33, $36, $90, $37, $2B, $28, $90, $2F, $28, $2A, $36, $F1
    db $32, $38, $37, $90, $29, $35, $32, $30, $90, $38, $31, $27, $28, $35, $90, $24
    db $2F, $2F, $F1, $28, $31, $28, $30, $2C, $28, $36, $B5, $F0

Data_095_5E71:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $29, $37, $AB, $90, $33, $2F, $38, $36, $2B, $3C, $90, $24, $31, $27
    db $F1, $39, $28, $35, $3C, $90, $33, $2F, $28, $24, $36, $24, $31, $37, $B5, $F1
    db $F0

Data_095_5E92:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $37, $28, $35, $35, $2C, $29, $3C, $2C, $31, $2A, $90, $26, $35, $3C
    db $F1, $37, $2B, $24, $37, $90, $36, $37, $32, $33, $36, $90, $24, $2F, $2F, $F1
    db $28, $31, $28, $30, $2C, $28, $36, $B5, $F0

Data_095_5EBB:: ; heuristic: target of a monotone pointer table; C0
    db $18, $33, $28, $31, $36, $90, $24, $90, $2A, $28, $3C, $36, $28, $35, $90, $37
    db $32, $F1, $36, $28, $31, $27, $90, $24, $31, $90, $28, $31, $28, $30, $3C, $F1
    db $29, $2F, $3C, $2C, $31, $2A, $B5, $F0

Data_095_5EE3:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $39, $28, $31, $37, $36, $90, $24, $2F, $2F, $F1, $28, $31, $28
    db $30, $2C, $28, $36, $90, $29, $35, $32, $30, $F1, $27, $24, $31, $26, $2C, $31
    db $2A, $B5, $F0

Data_095_5F06:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $39, $28, $31, $37, $36, $90, $24, $2F, $2F, $F1, $28, $31, $28
    db $30, $2C, $28, $36, $90, $29, $35, $32, $30, $90, $38, $36, $2C, $31, $2A, $F1
    db $25, $35, $28, $24, $37, $2B, $90, $24, $37, $37, $24, $26, $2E, $36, $B5, $F0

Data_095_5F36:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $35, $32, $31, $2A, $2F, $3C, $90, $33, $35, $32, $37, $28, $26, $37
    db $36, $F1, $37, $2B, $28, $90, $38, $36, $28, $35, $90, $24, $2A, $24, $2C, $31
    db $36, $37, $F1, $24, $2F, $2F, $90, $24, $37, $37, $24, $26, $2E, $36, $B5, $F0

Data_095_5F66:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $29, $2F, $28, $26, $37, $36, $90, $24, $31, $3C, $F1, $33, $2B, $3C
    db $36, $2C, $26, $24, $2F, $90, $24, $37, $37, $24, $26, $2E, $90, $37, $32, $F1
    db $24, $31, $32, $37, $2B, $28, $35, $90, $30, $32, $31, $36, $37, $28, $35, $B5
    db $F0

Data_095_5F97:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $37, $28, $26, $37, $36, $90, $37, $2B, $28, $90, $38, $36, $28
    db $35, $F1, $24, $31, $27, $90, $28, $31, $24, $25, $2F, $28, $36, $F1, $35, $28
    db $37, $24, $2F, $2C, $24, $37, $2C, $32, $31, $B5, $F0

Data_095_5FC2:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2E, $28, $36, $90, $24, $2F, $2F, $90, $24, $37, $37, $24, $26, $2E
    db $36, $F1, $30, $28, $24, $31, $37, $90, $29, $32, $35, $90, $24, $31, $32, $37
    db $2B, $28, $35, $F1, $30, $32, $31, $36, $37, $28, $35, $B5, $F0

Data_095_5FEF:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2E, $28, $36, $90, $24, $2F, $2F, $90, $24, $37, $37, $24, $26, $2E
    db $36, $F1, $30, $28, $24, $31, $37, $90, $29, $32, $35, $90, $33, $24, $35, $37
    db $3C, $F1, $30, $32, $31, $36, $37, $28, $35, $36, $B5, $F0

Data_095_601B:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $38, $31, $26, $28, $36, $90, $25, $24, $26, $2E, $90, $24, $F1, $25
    db $35, $28, $24, $37, $2B, $90, $24, $37, $37, $24, $26, $2E, $90, $37, $32, $F1
    db $24, $31, $90, $28, $31, $28, $30, $3C, $B5, $F0

Data_095_6045:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $38, $31, $26, $28, $36, $90, $25, $24, $26, $2E, $90, $24, $2F, $2F
    db $F1, $25, $35, $28, $24, $37, $2B, $90, $24, $37, $37, $24, $26, $2E, $36, $90
    db $37, $32, $F1, $24, $2F, $2F, $90, $28, $31, $28, $30, $2C, $28, $36, $B5, $F0

Data_095_6075:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $24, $37, $28, $36, $90, $24, $90, $25, $24, $35, $35, $2C, $28
    db $35, $F1, $37, $2B, $24, $37, $90, $25, $2F, $32, $26, $2E, $36, $90, $24, $31
    db $F1, $24, $37, $37, $24, $26, $2E, $B5, $F0

Data_095_609E:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $24, $2F, $36, $90, $24, $90, $36, $2E, $2C, $2F, $2F, $90, $38, $36
    db $28, $27, $F1, $25, $3C, $90, $37, $2B, $28, $90, $28, $31, $28, $30, $3C, $B5
    db $F1, $F0

Data_095_60C0:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $2B, $24, $2F, $28, $36, $90, $24, $2F, $2F, $90, $25, $35, $28, $24
    db $37, $2B, $F1, $24, $37, $37, $24, $26, $2E, $36, $90, $30, $28, $24, $31, $37
    db $90, $29, $32, $35, $F1, $37, $2B, $28, $90, $33, $24, $35, $37, $3C, $B5, $F0

Data_095_60F0:: ; heuristic: target of a monotone pointer table; C0
    db $12, $30, $2C, $37, $24, $37, $28, $36, $90, $37, $2B, $28, $F1, $28, $31, $28
    db $30, $3C, $3E, $90, $30, $32, $39, $28, $36, $B5, $F1, $F0

Data_095_610C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $27, $2C, $37, $24, $37, $28, $36, $90, $37, $32, $F1, $35, $28, $36
    db $37, $32, $35, $28, $90, $11, $19, $90, $25, $3C, $90, $05, $00, $00, $B5, $F1
    db $F0

Data_095_612D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $39, $2C, $39, $28, $36, $90, $24, $2F, $2F, $90, $27, $28, $24, $27
    db $F1, $29, $35, $2C, $28, $31, $27, $36, $90, $2C, $31, $90, $37, $2B, $28, $F1
    db $31, $28, $3B, $37, $90, $37, $38, $35, $31, $B5, $F0

Data_095_6158:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $35, $24, $2C, $31, $90, $37, $2B, $24
    db $37, $F1, $35, $28, $36, $37, $32, $35, $28, $36, $90, $11, $19, $B5, $F1, $F0

Data_095_6178:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $35, $24, $26, $37, $36, $90, $28, $31, $28, $30, $3C, $F1, $30
    db $32, $31, $36, $37, $28, $35, $36, $B5, $F1, $F0

Data_095_6192:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $35, $24, $26, $37, $36, $90, $28, $31, $28, $30, $3C, $F1, $30
    db $32, $31, $36, $37, $28, $35, $36, $90, $32, $29, $90, $37, $2B, $28, $F1, $32
    db $33, $33, $32, $36, $2C, $37, $28, $90, $2A, $28, $31, $27, $28, $35, $B5, $F0

Data_095_61C2:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $37, $28, $26, $37, $36, $90, $37, $2B, $28, $90, $33, $24, $35
    db $37, $3C, $F1, $29, $35, $32, $30, $90, $2C, $31, $2D, $38, $35, $2C, $32, $38
    db $36, $F1, $37, $28, $35, $35, $24, $2C, $31, $B5, $F0

Data_095_61ED:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $36, $37, $24, $31, $37, $2F, $3C, $90, $3A, $24, $35, $33, $36, $F1
    db $37, $2B, $28, $90, $33, $24, $35, $37, $3C, $90, $32, $38, $37, $90, $29, $35
    db $32, $30, $F1, $26, $24, $39, $28, $36, $90, $24, $31, $27, $90, $37, $32, $3A
    db $28, $35, $36, $B5, $F0

Data_095_6222:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $36, $28, $90, $37, $32, $90, $32, $25, $37, $24, $2C, $31, $F1, $2C, $31
    db $29, $32, $35, $30, $24, $37, $2C, $32, $31, $90, $32, $31, $F1, $30, $32, $31
    db $36, $37, $28, $35, $36, $B5, $F0

Data_095_6249:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $28, $36, $90, $37, $2B, $28, $90, $30, $32, $31, $36, $37, $28
    db $35, $F1, $35, $38, $31, $90, $24, $31, $90, $28, $35, $35, $24, $31, $27, $90
    db $29, $32, $35, $F1, $01, $00, $00, $10, $B5, $F0

Data_095_6273:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $37, $28, $35, $30, $2C, $31, $28, $36, $90, $37, $2B, $28, $F1, $33
    db $35, $28, $36, $28, $31, $26, $28, $90, $32, $29, $90, $2C, $37, $28, $30, $36
    db $F1, $31, $28, $24, $35, $25, $3C, $B5, $F0

Data_095_629C:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $28, $26, $2E, $36, $90, $37, $2B, $28, $F1, $36, $38, $35, $35, $32
    db $38, $31, $27, $2C, $31, $2A, $90, $24, $35, $28, $24, $3E, $F1, $37, $28, $35
    db $35, $24, $2C, $31, $B5, $F0

Data_095_62C2:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $29, $37, $AB, $90, $33, $2F, $38, $36, $2B, $3C, $90, $24, $31, $27
    db $F1, $39, $28, $35, $3C, $90, $33, $2F, $28, $24, $36, $24, $31, $37, $B5, $F1
    db $F0

Data_095_62E3:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_095_62E4:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_095_62E5:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $31, $28, $F1, $F0

Data_095_62EB:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $12, $1D, $F1, $0B, $28, $2F, $37, $F0

Data_095_62F4:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $F1, $0B, $28, $2F, $37, $F0

Data_095_62FF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $F1, $0B, $28, $2F, $37, $F0

Data_095_630A:: ; heuristic: target of a monotone pointer table; C0
    db $18, $27, $27, $F1, $0B, $28, $2F, $37, $F0

Data_095_6313:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $31, $28, $F1, $0F, $24, $31, $2A, $F0

Data_095_631E:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $28, $28, $2F, $F1, $0F, $24, $31, $2A, $F0

Data_095_6329:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $35, $30, $F1, $1C, $26, $24, $2F, $28, $F0

Data_095_6334:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2E, $F1, $1C, $26, $24, $2F, $28, $F0

Data_095_633F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $10, $15, $F1, $0B, $24, $31, $2A, $2F, $28, $F0

Data_095_634A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $35, $35, $3C, $F1, $0B, $24, $31, $2A, $2F, $28, $F0

Data_095_6358:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $35, $37, $F1, $11, $24, $37, $F0

Data_095_6362:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $36, $28, $F1, $11, $24, $37, $F0

Data_095_636B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $F1, $0C, $24, $33, $28, $F0

Data_095_6376:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $F1, $0C, $24, $33, $28, $F0

Data_095_6381:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $2F, $39, $28, $35, $F1, $0C, $24, $33, $28, $F0

Data_095_638D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $F1, $0C, $24, $33, $28, $F0

Data_095_6397:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $37, $31, $30, $F1, $0C, $24, $33, $28, $F0

Data_095_63A2:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $26, $24, $F1, $0C, $24, $33, $28, $F0

Data_095_63AC:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $24, $39, $28, $F1, $0C, $24, $33, $28, $F0

Data_095_63B7:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $9C, $F1, $1C, $26, $24, $2F, $28, $F0

Data_095_63C0:: ; heuristic: target of a monotone pointer table; C0
    db $F1, $F0

Data_095_63C2:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $28, $F1, $1B, $2C, $31, $2A, $F0

Data_095_63CC:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $39, $2C, $31, $28, $F1, $1B, $2C, $31, $2A, $F0

Data_095_63D8:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $F1, $1B, $2C, $31, $2A, $F0

Data_095_63E1:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $28, $F1, $1B, $2C, $31, $2A, $F0

Data_095_63EB:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $2A, $2B, $37, $F1, $1B, $2C, $31, $2A, $F0

Data_095_63F6:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2C, $2F, $32, $35, $F1, $1B, $2C, $31, $2A, $F0

Data_095_6402:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $2C, $28, $29, $F1, $1B, $2C, $31, $2A, $F0

Data_095_640D:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $28, $35, $2C, $26, $F1, $1B, $2C, $31, $2A, $F0

Data_095_6419:: ; heuristic: target of a monotone pointer table; C0
    db $F1, $F0

Data_095_641B:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_095_641C:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $31, $28, $F1, $F0

Data_095_6422:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $2F, $2F, $F1, $36, $2B, $2C, $33, $F0

Data_095_642C:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $2F, $2F, $F1, $26, $2F, $32, $38, $27, $F0

Data_095_6437:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $36, $2B, $F1, $35, $32, $26, $2E, $F0

Data_095_6442:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $35, $31, $F1, $F0

Data_095_6448:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $37, $F1, $F0

Data_095_644D:: ; heuristic: target of a monotone pointer table; C0
    db $18, $33, $28, $31, $F1, $27, $32, $32, $35, $F0

Data_095_6457:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $24, $26, $2E, $F0

Data_095_645E:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $35, $2A, $28, $F0

Data_095_6465:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $3B, $28, $27, $F0

Data_095_646B:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $38, $37, $2C, $32, $38, $36, $F0

Data_095_6474:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $30, $30, $24, $31, $27, $F0

Data_095_647C:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_095_647D:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $35, $2A, $28, $F0

Data_095_6484:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $3B, $28, $27, $F0

Data_095_648A:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $38, $37, $2C, $32, $38, $36, $F0

Data_095_6493:: ; heuristic: target of a monotone pointer table; C0
    db $23, $32, $31, $28, $18, $38, $37, $F0

Data_095_649B:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $31, $26, $28, $F0

Data_095_64A2:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $31, $29, $38, $36, $2C, $32, $31, $F0

Data_095_64AC:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $38, $37, $32, $F0

Data_095_64B1:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $28, $30, $F0

Data_095_64B6:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $90, $24, $35, $28, $24, $F0

Data_095_64BE:: ; heuristic: target of a monotone pointer table; C0
    db $01, $90, $28, $31, $28, $30, $3C, $F0

Data_095_64C6:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $2F, $90, $28, $31, $28, $30, $2C, $28, $36, $F0

Data_095_64D2:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $28, $36, $90, $30, $38, $2F, $37, $2C, $9C, $2B, $2C, $37, $F0

Data_095_64E1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $90, $29, $35, $2C, $28, $31, $27, $F0

Data_095_64EA:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $2F, $90, $29, $35, $2C, $28, $31, $27, $36, $F0

Data_095_64F6:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $32, $36, $28, $90, $01, $F0

Data_095_64FF:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $32, $36, $28, $90, $24, $2F, $2F, $F0

Data_095_650A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $2F, $29, $F0

Data_095_650F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $2F, $F0

Data_095_6513:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $31, $27, $32, $30, $F0

Data_095_651A:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $31, $28, $F0

Data_095_651F:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $24, $3D, $28, $F0

Data_095_6525:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $25, $24, $2F, $F0

Data_095_652D:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $31, $2A, $F0

Data_095_6532:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $28, $35, $31, $32, $36, $F0

Data_095_653B:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $2F, $37, $F0

Data_095_6540:: ; heuristic: target of a monotone pointer table; C0
    db $12, $26, $28, $0B, $32, $2F, $37, $F0

Data_095_6548:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $35, $35, $32, $38, $31, $27, $F0

Data_095_6551:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $28, $28, $33, $F0

Data_095_6557:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $37, $F0

Data_095_655C:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $25, $16, $24, $2A, $2C, $26, $F0

Data_095_6565:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $33, $1C, $33, $28, $2F, $2F, $F0

Data_095_656F:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $31, $2C, $26, $0A, $2F, $2F, $F0

Data_095_6578:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $33, $F0

Data_095_657C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $32, $3A, $0A, $2F, $2F, $F0

Data_095_6584:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $26, $35, $2C, $29, $2C, $26, $28, $F0

Data_095_658E:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $2A, $24, $16, $24, $2A, $2C, $26, $F0

Data_095_6598:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $F0

Data_095_659D:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2F, $2C, $3D, $3D, $24, $35, $27, $F0

Data_095_65A6:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $2C, $36, $32, $31, $F0

Data_095_65AD:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $35, $24, $2F, $3C, $36, $2C, $36, $F0

Data_095_65B7:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $35, $36, $28, $F0

Data_095_65BD:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $F0

Data_095_65C2:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $31, $26, $28, $F0

Data_095_65C8:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $28, $24, $37, $2B, $F0

Data_095_65CF:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $35, $2C, $28, $31, $27, $F0

Data_095_65D6:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $36, $2B, $F0

Data_095_65DB:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $28, $35, $F0

Data_095_65E1:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3C, $33, $28, $90, $0A, $F0

Data_095_65E8:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3C, $33, $28, $90, $0B, $F0

Data_095_65EF:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3C, $33, $28, $90, $0C, $F0

Data_095_65F6:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3C, $33, $28, $90, $0D, $F0

Data_095_65FD:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3C, $33, $28, $90, $0E, $F0

Data_095_6604:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3C, $33, $28, $90, $0F, $F0

Data_095_660B:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3C, $33, $28, $90, $10, $F0

Data_095_6612:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $3C, $33, $28, $90, $11, $F0

Data_095_6619:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $31, $28, $F0

Data_095_661E:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $37, $37, $2F, $28, $F0

Data_095_6625:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $28, $2F, $27, $F0

Data_095_662B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $3C, $37, $2C, $30, $28, $F0
    ds $19CD, $00
