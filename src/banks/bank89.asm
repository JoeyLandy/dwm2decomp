SECTION "Bank 89", ROMX[$4000], BANK[$89]
    db $89

Func_089_4001::
    ld a, [$C529]
    cp a, $DE
    jr c, Jump_089_400F
    ld hl, $404B
    ld b, $98
    rst $10
    ret

Jump_089_400F::
    ld de, $4032
    call Func_000_25C9
    ret

Func_089_4016:: ; heuristic: follows a terminator; C0
    ld a, [$C529]
    cp a, $DE
    jr c, Jump_089_4024
    ld hl, $405A
    ld b, $98
    rst $10
    ret

Jump_089_4024::
    ld de, $4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9, $34, $40
    dw Data_089_41F0
    dw Data_089_4260
    dw Data_089_42AD
    dw Data_089_431C
    dw Data_089_4367
    dw Data_089_43A1
    dw Data_089_43C3
    dw Data_089_4407
    dw Data_089_44BE
    dw Data_089_4506
    dw Data_089_4569
    dw Data_089_45EE
    dw Data_089_4687
    dw Data_089_4773
    dw Data_089_4800
    dw Data_089_4865
    dw Data_089_48E9
    dw Data_089_4909
    dw Data_089_493F
    dw Data_089_4960
    dw Data_089_4A33
    dw Data_089_4ADA
    dw Data_089_4B24
    dw Data_089_4B99
    dw Data_089_4BB6
    dw Data_089_4BD4
    dw Data_089_4C0E
    dw Data_089_4C97
    dw Data_089_4E20
    dw Data_089_4E9F
    dw Data_089_4F2A
    dw Data_089_4FAA
    dw Data_089_505B
    dw Data_089_5109
    dw Data_089_519B
    dw Data_089_521F
    dw Data_089_525F
    dw Data_089_52EC
    dw Data_089_5332
    dw Data_089_5374
    dw Data_089_53CE
    dw Data_089_53EC
    dw Data_089_547E
    dw Data_089_5505
    dw Data_089_563B
    dw Data_089_5672
    dw Data_089_56A3
    dw Data_089_5707
    dw Data_089_574B
    dw Data_089_57BA
    dw Data_089_5823
    dw Data_089_5883
    dw Data_089_58CC
    dw Data_089_590B
    dw Data_089_5947
    dw Data_089_5965
    dw Data_089_59AD
    dw Data_089_59F0
    dw Data_089_5A2F
    dw Data_089_5A75
    dw Data_089_5A81
    dw Data_089_5A8B
    dw Data_089_5B12
    dw Data_089_5B4F
    dw Data_089_5BB8
    dw Data_089_5BF8
    dw Data_089_5C12
    dw Data_089_5C50
    dw Data_089_5CFE
    dw Data_089_5D42
    dw Data_089_5DAC
    dw Data_089_5E21
    dw Data_089_5E41
    dw Data_089_5EA9
    dw Data_089_5EC3
    dw Data_089_5F00
    dw Data_089_5F47
    dw Data_089_5FF4
    dw Data_089_6086
    dw Data_089_60C9
    dw Data_089_60C9
    dw Data_089_60EE
    dw Data_089_6106
    dw Data_089_6124
    dw Data_089_6124
    dw Data_089_6124
    dw Data_089_6141
    dw Data_089_615D
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_6184
    dw Data_089_61A4
    dw Data_089_61E3
    dw Data_089_61F6
    dw Data_089_620F
    dw Data_089_622C
    dw Data_089_6247
    dw Data_089_6263
    dw Data_089_627F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_629F
    dw Data_089_62C1
    dw Data_089_62E6
    dw Data_089_634C
    dw Data_089_636A
    dw Data_089_6420
    dw Data_089_6460
    dw Data_089_6483
    dw Data_089_64CE
    dw Data_089_6512
    dw Data_089_659A
    dw Data_089_661F
    dw Data_089_66A5
    dw Data_089_6708
    dw Data_089_6771
    dw Data_089_67D8
    dw Data_089_6820
    dw Data_089_68E0
    dw Data_089_696A
    dw Data_089_6A1F
    dw Data_089_6AAF
    dw Data_089_6B4F
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6BB5
    dw Data_089_6C64
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D11
    dw Data_089_6D99
    dw Data_089_6E09
    dw Data_089_6E4B
    dw Data_089_6E8E
    dw Data_089_6ED3
    dw Data_089_6F1E
    dw Data_089_6F64
    dw Data_089_6F99
    dw Data_089_6FBE
    dw Data_089_6FDC
    dw Data_089_7001
    dw Data_089_7001
    dw Data_089_7001
    dw Data_089_7001
    dw Data_089_7001
    dw Data_089_7001
    dw Data_089_716B
    dw Data_089_72B6
    dw Data_089_7300
    dw Data_089_7368
    dw Data_089_73C4
    dw Data_089_74AB
    dw Data_089_74C9
    dw Data_089_7594
    dw Data_089_7620
    dw Data_089_76D7
    dw Data_089_7707
    dw Data_089_7834
    dw Data_089_7859
    dw Data_089_7873
    dw Data_089_7894
    dw Data_089_78B3
    dw Data_089_78F3
    dw Data_089_7928
    dw Data_089_796A
    dw Data_089_798E
    dw Data_089_7A36
    dw Data_089_7B17
    dw Data_089_7B86
    dw Data_089_7BED
    dw Data_089_7C7F
    dw Data_089_7CC8
    dw Data_089_7D7C
    dw Data_089_7E37
    dw Data_089_7F0E

Data_089_41F0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2241F0, $70

Data_089_4260:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224260, $4D

Data_089_42AD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2242AD, $6F

Data_089_431C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22431C, $4B

Data_089_4367:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $11, $28, $2F, $2F, $32, $AB, $90, $2B, $24, $39, $28, $90, $3C
    db $32, $38, $F1, $29, $32, $38, $31, $27, $90, $24, $90, $33, $2F, $38, $2A, $90
    db $29, $32, $35, $FA, $F7, $EF, $EE, $37, $2B, $28, $90, $15, $32, $2A, $3E, $90
    db $17, $24, $39, $28, $2F, $98, $EF, $EE, $FF, $F0

Data_089_43A1:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $B5, $90, $1D, $2B, $24, $37, $3E, $90, $31, $2C, $26
    db $28, $B5, $F1, $10, $32, $32, $27, $90, $29, $32, $35, $90, $3C, $32, $38, $B5
    db $F7, $F0

Data_089_43C3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2243C3, $44

Data_089_4407:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224407, $B7

Data_089_44BE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2244BE, $48

Data_089_4506:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224506, $63

Data_089_4569:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224569, $85

Data_089_45EE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2245EE, $99

Data_089_4687:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224687, $EC

Data_089_4773:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224773, $8D

Data_089_4800:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224800, $65

Data_089_4865:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224865, $84

Data_089_48E9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $35, $28, $24, $37, $99, $90, $15, $28, $37, $3E, $F1, $30
    db $24, $2E, $28, $90, $37, $2B, $2C, $36, $90, $3A, $32, $35, $2E, $99, $F7, $F0

Data_089_4909:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $35, $90, $33, $24, $35, $37, $3C, $3E, $F1, $29
    db $38, $2F, $2F, $A4, $FA, $F7, $EF, $EE, $1D, $2B, $28, $35, $28, $90, $2C, $36
    db $31, $41, $90, $24, $31, $3C, $EF, $EE, $35, $32, $32, $30, $90, $29, $32, $35
    db $90, $30, $28, $B5, $F7, $F0

Data_089_493F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $AB, $90, $25, $38, $37, $A4, $90, $12, $90, $26, $24
    db $31, $F1, $25, $28, $90, $36, $32, $90, $38, $36, $28, $29, $38, $2F, $A4, $F7
    db $F0

Data_089_4960:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224960, $D3

Data_089_4A33:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224A33, $A7

Data_089_4ADA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224ADA, $4A

Data_089_4B24:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224B24, $75

Data_089_4B99:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $35, $28, $AB, $90, $F9, $00, $99, $F1, $22, $32, $38
    db $90, $31, $28, $28, $27, $90, $37, $2B, $2C, $36, $99, $F7, $F0

Data_089_4BB6:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $12, $26, $28, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_089_4BD4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0B, $28, $90, $26, $24, $35, $28, $29, $38, $2F, $90, $3A, $2B
    db $28, $31, $F1, $3C, $32, $38, $40, $28, $90, $37, $35, $24, $39, $28, $2F, $2C
    db $31, $2A, $FA, $F7, $EF, $EE, $2C, $31, $90, $32, $37, $2B, $28, $35, $90, $3A
    db $32, $35, $2F, $27, $36, $B5, $EF, $EE, $F7, $F0

Data_089_4C0E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224C0E, $89

Data_089_4C97:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224C97, $189

Data_089_4E20:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224E20, $7F

Data_089_4E9F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224E9F, $8B

Data_089_4F2A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224F2A, $80

Data_089_4FAA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $224FAA, $B1

Data_089_505B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22505B, $AE

Data_089_5109:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225109, $92

Data_089_519B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22519B, $84

Data_089_521F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $2D, $38, $36, $37, $90, $2B, $28, $24, $35, $27, $90
    db $24, $F1, $35, $38, $30, $32, $35, $A4, $FA, $F7, $EF, $EE, $1D, $2B, $28, $90
    db $2A, $2C, $35, $2F, $3E, $90, $2A, $2B, $32, $36, $37, $EF, $EE, $36, $28, $28
    db $30, $36, $90, $37, $32, $90, $25, $28, $90, $2A, $32, $31, $28, $B5, $F7, $F0

Data_089_525F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22525F, $8D

Data_089_52EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2252EC, $46

Data_089_5332:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225332, $42

Data_089_5374:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225374, $5A

Data_089_53CE:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28, $F1
    db $1C, $2E, $3C, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_089_53EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2253EC, $92

Data_089_547E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22547E, $87

Data_089_5505:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225505, $136

Data_089_563B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $37, $90, $2A, $2C, $24, $31, $37, $90, $25, $2C
    db $35, $27, $F1, $2B, $24, $36, $31, $41, $90, $29, $2F, $32, $3A, $31, $90, $32
    db $39, $28, $35, $FA, $F7, $EF, $EE, $29, $32, $35, $90, $24, $90, $3A, $2B, $2C
    db $2F, $28, $B5, $EF, $EE, $F7, $F0

Data_089_5672:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $24, $36, $90, $37, $2B, $24, $37, $90, $25, $2C, $35, $27
    db $F1, $2A, $32, $2C, $31, $2A, $90, $24, $29, $37, $28, $35, $90, $37, $2B, $28
    db $FA, $F7, $EF, $EE, $15, $2C, $2A, $2B, $37, $18, $35, $25, $98, $EF, $EE, $F7
    db $F0

Data_089_56A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2256A3, $64

Data_089_5707:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225707, $44

Data_089_574B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22574B, $6F

Data_089_57BA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2257BA, $69

Data_089_5823:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225823, $60

Data_089_5883:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225883, $49

Data_089_58CC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $19, $2F, $28, $24, $36, $28, $AB, $90, $28, $24, $37, $90, $38
    db $33, $AB, $F1, $28, $24, $37, $90, $38, $33, $99, $FA, $F7, $EF, $EE, $0D, $32
    db $31, $41, $90, $3A, $32, $35, $35, $3C, $90, $24, $25, $32, $38, $37, $EF, $EE
    db $3C, $32, $38, $35, $90, $30, $24, $31, $31, $28, $35, $36, $99, $F7, $F0

Data_089_590B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $30, $98, $90, $12, $90, $36, $24, $3A, $90, $3C, $32, $38
    db $35, $F1, $29, $24, $30, $2C, $2F, $3C, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28
    db $3C, $90, $3A, $28, $35, $28, $90, $38, $33, $90, $32, $31, $EF, $EE, $37, $2B
    db $28, $90, $37, $35, $28, $28, $37, $32, $33, $B5, $F7, $F0

Data_089_5947:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $90, $14, $2C, $31, $2A, $27, $32, $30, $90, $2C
    db $36, $F1, $35, $28, $2D, $32, $2C, $26, $2C, $31, $2A, $99, $F7, $F0

Data_089_5965:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225965, $48

Data_089_59AD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2259AD, $43

Data_089_59F0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2B, $AB, $90, $10, $35, $28, $24, $37, $15, $32, $2A, $3E
    db $F1, $30, $2C, $2A, $2B, $37, $3C, $90, $2B, $28, $35, $32, $99, $FA, $F7, $EF
    db $EE, $12, $90, $2B, $32, $33, $28, $90, $3C, $32, $38, $40, $28, $EF, $EE, $28
    db $31, $2D, $32, $3C, $2C, $31, $2A, $90, $37, $2B, $2C, $36, $99, $F7, $F0

Data_089_5A2F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225A2F, $46

Data_089_5A75:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $2C, $31, $31, $3C, $99, $F7, $F0

Data_089_5A81:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $A4, $A4, $A4, $A4, $99, $F7, $F0

Data_089_5A8B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225A8B, $87

Data_089_5B12:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $38, $2B, $98, $90, $1D, $2B, $28, $35, $28, $90, $2C, $36
    db $F1, $36, $32, $30, $28, $37, $2B, $2C, $31, $2A, $90, $2B, $28, $35, $28, $B5
    db $FA, $F7, $EF, $EE, $1E, $31, $27, $28, $35, $90, $37, $2B, $28, $EF, $EE, $30
    db $28, $35, $26, $2B, $24, $31, $27, $2C, $36, $28, $B5, $F7, $F0

Data_089_5B4F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225B4F, $69

Data_089_5BB8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $44, $90, $2F, $2C, $2E, $28, $90, $3C, $32, $38, $90, $37
    db $32, $F1, $2B, $24, $39, $28, $90, $37, $2B, $2C, $36, $B5, $FA, $F7, $EF, $EE
    db $1C, $32, $35, $37, $90, $32, $29, $90, $24, $90, $37, $2B, $24, $31, $2E, $36
    db $EF, $EE, $29, $32, $35, $90, $0A, $35, $30, $3C, $0A, $31, $37, $B5, $F7, $F0

Data_089_5BF8:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $24, $F1, $1D, $2C
    db $31, $3C, $16, $28, $27, $24, $2F, $99, $F7, $F0

Data_089_5C12:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $43, $2F, $90, $33, $35, $24, $3C, $90, $29, $32, $35, $F1
    db $3C, $32, $38, $35, $90, $36, $24, $29, $28, $37, $3C, $B5, $FA, $F7, $EF, $EE
    db $1D, $24, $2E, $28, $90, $2A, $32, $32, $27, $90, $26, $24, $35, $28, $90, $32
    db $29, $EF, $EE, $3C, $32, $38, $35, $36, $28, $2F, $29, $B5, $F7, $F0

Data_089_5C50:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225C50, $AE

Data_089_5CFE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225CFE, $44

Data_089_5D42:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225D42, $6A

Data_089_5DAC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225DAC, $75

Data_089_5E21:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $35, $28, $AB, $90, $F9, $00, $99, $F1, $22, $32, $38
    db $90, $2B, $32, $2F, $27, $90, $32, $31, $37, $32, $90, $2C, $37, $B5, $F7, $F0

Data_089_5E41:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225E41, $68

Data_089_5EA9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $35, $28, $3E, $90, $37, $2B, $24, $37, $F1, $1D, $2C
    db $31, $3C, $16, $28, $27, $24, $2F, $B5, $F7, $F0

Data_089_5EC3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $35, $28, $3E, $90, $37, $2B, $24, $37, $F1, $1D, $2C
    db $31, $3C, $16, $28, $27, $24, $2F, $B5, $FA, $F7, $EF, $EE, $A4, $20, $24, $2C
    db $37, $AB, $90, $3C, $32, $38, $90, $36, $37, $2C, $2F, $2F, $EF, $EE, $2B, $24
    db $39, $28, $90, $31, $32, $90, $35, $32, $32, $30, $B5, $F7, $F0

Data_089_5F00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225F00, $47

Data_089_5F47:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225F47, $AD

Data_089_5FF4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $225FF4, $92

Data_089_6086:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226086, $43

Data_089_60C9:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $26, $2E, $90, $37, $2B, $28, $90, $30, $32, $31, $36, $37, $28, $35
    db $F1, $37, $32, $90, $2A, $32, $90, $37, $32, $90, $37, $2B, $28, $90, $29, $24
    db $35, $30, $B5, $F7, $F0

Data_089_60EE:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $17, $90, $2D, $32, $2C, $31, $28, $27, $F1, $37, $2B, $28, $90, $33, $24
    db $35, $37, $3C, $B5, $E5, $D6, $F7, $F0

Data_089_6106:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $17, $90, $2B, $28, $24, $27, $28, $27, $90, $32, $29, $29, $F1, $37, $32
    db $90, $37, $2B, $28, $90, $29, $24, $35, $30, $B5, $E5, $D6, $F7, $F0

Data_089_6124:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $20, $24, $2C, $37, $AB, $90, $37, $2B, $28, $90, $29, $24
    db $35, $30, $F1, $2C, $36, $90, $29, $38, $2F, $2F, $A4, $F7, $F0

Data_089_6141:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $28, $37, $90, $30, $28, $90, $2D, $32, $2C, $31, $90, $3C
    db $32, $38, $35, $F1, $33, $24, $35, $37, $3C, $98, $FF, $F0

Data_089_615D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $1D, $2B, $28, $90, $29, $24, $35, $30, $90, $2B, $24, $36
    db $90, $31, $32, $F1, $35, $32, $32, $30, $90, $2F, $28, $29, $37, $90, $29, $32
    db $35, $90, $30, $28, $A4, $F7, $F0

Data_089_6184:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $24, $37, $90, $3A, $2C, $2F, $2F, $90, $3C, $32, $38, $90, $2A, $2C
    db $39, $28, $F1, $37, $32, $90, $37, $2B, $28, $90, $0E, $2A, $2A, $98, $F7, $F0

Data_089_61A4:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $22, $90, $2B, $24, $36, $90, $25, $28, $28, $31, $F1, $2A, $2C, $39, $28
    db $31, $90, $37, $32, $90, $37, $2B, $28, $90, $0E, $2A, $2A, $B5, $FA, $F7, $EF
    db $EE, $20, $2B, $24, $37, $90, $3A, $2C, $2F, $2F, $90, $3C, $32, $38, $90, $2A
    db $2C, $39, $28, $EF, $EE, $2C, $37, $90, $31, $28, $3B, $37, $98, $F7, $F0

Data_089_61E3:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $29, $24, $35, $30, $90, $2C, $36, $90, $29, $38, $2F, $2F
    db $B5, $F7, $F0

Data_089_61F6:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $30, $2C, $24, $90, $28, $31, $37, $28, $35, $28, $27, $F1, $37, $2B
    db $28, $90, $29, $24, $35, $30, $B5, $F7, $F0

Data_089_620F:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $30, $28, $31, $36, $24, $38, $35, $90, $28, $31, $37, $28, $35, $28
    db $27, $F1, $37, $2B, $28, $90, $29, $24, $35, $30, $B5, $F7, $F0

Data_089_622C:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $2A, $28, $25, $32, $38, $90, $28, $31, $37, $28, $35, $28, $27, $F1
    db $37, $2B, $28, $90, $29, $24, $35, $30, $B5, $F7, $F0

Data_089_6247:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $24, $37, $24, $2F, $32, $2A, $28, $27, $F1, $01, $00, $00
    db $90, $30, $32, $31, $36, $37, $28, $35, $36, $B5, $F7, $F0

Data_089_6263:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $24, $37, $24, $2F, $32, $2A, $28, $27, $F1, $02, $00, $00
    db $90, $30, $32, $31, $36, $37, $28, $35, $36, $B5, $F7, $F0

Data_089_627F:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $24, $37, $24, $2F, $32, $2A, $28, $27, $F1, $24, $2F, $2F
    db $90, $37, $2B, $28, $90, $30, $32, $31, $36, $37, $28, $35, $36, $B5, $F7, $F0

Data_089_629F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1B, $28, $24, $2F, $2F, $3C, $98, $90, $15, $28, $37, $3E, $90
    db $2A, $32, $F1, $37, $32, $90, $37, $2B, $28, $90, $0A, $35, $28, $31, $24, $99
    db $F7, $F0

Data_089_62C1:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0A, $3A, $3A, $A4, $90, $11, $32, $3A, $90, $25, $32, $35, $2C
    db $31, $2A, $A4, $F1, $1F, $2C, $36, $2C, $37, $90, $38, $36, $90, $24, $2A, $24
    db $2C, $31, $99, $F7, $F0

Data_089_62E6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2262E6, $66

Data_089_634C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $22, $24, $3C, $99, $90, $12, $90, $3A, $32, $31, $99, $F1, $0A
    db $30, $90, $12, $90, $24, $3A, $28, $36, $32, $30, $28, $98, $F7, $F0

Data_089_636A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22636A, $B6

Data_089_6420:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $90, $30, $24, $36, $37, $28, $35, $90, $3A, $2B, $32, $90
    db $26, $24, $31, $F1, $36, $24, $37, $2C, $36, $29, $3C, $90, $30, $28, $A4, $FA
    db $F7, $EF, $EE, $0D, $32, $28, $36, $90, $36, $38, $26, $2B, $90, $24, $EF, $EE
    db $25, $24, $37, $37, $2F, $28, $35, $90, $28, $3B, $2C, $36, $37, $98, $F7, $F0

Data_089_6460:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $99, $90, $0D, $32, $90, $3C
    db $32, $38, $F1, $3A, $2C, $36, $2B, $90, $37, $32, $90, $25, $24, $37, $37, $2F
    db $28, $98, $F0

Data_089_6483:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226483, $4B

Data_089_64CE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2264CE, $44

Data_089_6512:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226512, $88

Data_089_659A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22659A, $85

Data_089_661F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22661F, $86

Data_089_66A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2266A5, $63

Data_089_6708:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226708, $69

Data_089_6771:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226771, $67

Data_089_67D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2267D8, $48

Data_089_6820:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226820, $C0

Data_089_68E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2268E0, $8A

Data_089_696A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22696A, $B5

Data_089_6A1F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226A1F, $90

Data_089_6AAF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226AAF, $A0

Data_089_6B4F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226B4F, $66

Data_089_6BB5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226BB5, $AF

Data_089_6C64:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226C64, $AD

Data_089_6D11:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226D11, $88

Data_089_6D99:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226D99, $70

Data_089_6E09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226E09, $42

Data_089_6E4B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226E4B, $43

Data_089_6E8E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226E8E, $45

Data_089_6ED3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226ED3, $4B

Data_089_6F1E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $226F1E, $46

Data_089_6F64:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $17, $32, $90, $32, $31, $28, $3E
    db $F1, $37, $24, $2E, $2C, $31, $2A, $90, $37, $2B, $2C, $36, $90, $33, $2C, $28
    db $FA, $F7, $EF, $EE, $24, $3A, $24, $3C, $90, $29, $35, $32, $30, $90, $30, $28
    db $99, $EF, $EE, $F7, $F0

Data_089_6F99:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $24, $35, $38, $25, $32, $38, $A3, $90, $20, $24, $9C, $2B, $28, $3C
    db $A4, $F1, $12, $90, $2B, $24, $39, $28, $90, $36, $28, $28, $31, $90, $37, $2B
    db $2C, $36, $A4, $F7, $F0

Data_089_6FBE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $32, $25, $2C, $A3, $90, $1D, $2B, $24, $37, $3E, $90, $28, $31, $32
    db $38, $2A, $2B, $F1, $24, $2F, $35, $28, $24, $27, $3C, $B5, $F7, $F0

Data_089_6FDC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $20, $2B, $24, $37, $90, $2C, $29, $90, $3C, $32, $38, $90, $25, $35, $28
    db $24, $2E, $EF, $EE, $37, $2B, $28, $90, $33, $2F, $38, $2A, $90, $24, $2A, $24
    db $2C, $31, $98, $F7, $F0

Data_089_7001:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227001, $16A

Data_089_716B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22716B, $14B

Data_089_72B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2272B6, $4A

Data_089_7300:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227300, $68

Data_089_7368:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227368, $5C

Data_089_73C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2273C4, $E7

Data_089_74AB:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $1C, $24, $2C, $2F, $32, $35, $90, $1B, $2C, $31, $2A, $B5, $F7, $F0

Data_089_74C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2274C9, $CB

Data_089_7594:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227594, $8C

Data_089_7620:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227620, $B7

Data_089_76D7:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $15, $28, $37, $90, $30, $28, $90, $36, $2B, $32, $3A, $90, $3C
    db $32, $38, $F1, $30, $3C, $90, $35, $28, $36, $38, $35, $35, $28, $26, $37, $28
    db $27, $FA, $F7, $EF, $EE, $33, $32, $3A, $28, $35, $36, $A4, $EF, $EE, $F7, $F0

Data_089_7707:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227707, $12D

Data_089_7834:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $18, $1E, $1B, $90, $15, $12, $0F, $0E, $90, $0E, $17, $0D
    db $1C, $F1, $11, $0E, $1B, $0E, $99, $90, $10, $12, $1F, $0E, $90, $12, $1D, $90
    db $1E, $19, $99, $F7, $F0

Data_089_7859:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $14, $0A, $11, $0A, $11, $0A, $11, $0A, $99, $F1, $1D, $11, $0E
    db $17, $90, $15, $0E, $0A, $1F, $0E, $99, $F7, $F0

Data_089_7873:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $36, $28, $28, $A4, $90, $0B, $38, $37, $90, $12, $F1
    db $3A, $2C, $2F, $2F, $90, $26, $35, $38, $36, $2B, $90, $3C, $32, $38, $99, $F7
    db $F0

Data_089_7894:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $36, $28, $28, $A4, $90, $1D, $2B, $28, $31, $F1, $2F
    db $28, $24, $39, $28, $90, $24, $37, $90, $32, $31, $26, $28, $B5, $F7, $F0

Data_089_78B3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $30, $33, $28, $37, $38, $32, $38, $36, $90, $29, $32, $32
    db $2F, $99, $F1, $12, $43, $2F, $90, $36, $2B, $32, $3A, $90, $3C, $32, $38, $99
    db $FA, $F7, $EF, $EE, $0C, $32, $30, $28, $90, $2B, $2C, $37, $2B, $28, $35, $AB
    db $90, $30, $3C, $EF, $EE, $36, $28, $35, $39, $24, $31, $37, $36, $99, $F7, $F0

Data_089_78F3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $30, $AB, $90, $29, $2C, $31, $28, $AB, $90, $12, $43, $2F
    db $F1, $2C, $2A, $31, $32, $35, $28, $90, $2C, $37, $B5, $FA, $F7, $EF, $EE, $0B
    db $38, $37, $90, $2D, $38, $36, $37, $90, $37, $2B, $2C, $36, $EF, $EE, $37, $2C
    db $30, $28, $99, $F7, $F0

Data_089_7928:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227928, $42

Data_089_796A:: ; heuristic: target of a monotone pointer table; C0
    db $95, $12, $31, $31, $90, $27, $32, $3A, $31, $36, $37, $24, $2C, $35, $36, $B5
    db $F1, $1B, $32, $32, $30, $36, $90, $24, $39, $24, $2C, $2F, $24, $25, $2F, $28
    db $B5, $95, $F7, $F0

Data_089_798E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $22798E, $A8

Data_089_7A36:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227A36, $E1

Data_089_7B17:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227B17, $6F

Data_089_7B86:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227B86, $67

Data_089_7BED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227BED, $92

Data_089_7C7F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227C7F, $49

Data_089_7CC8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227CC8, $B4

Data_089_7D7C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227D7C, $BB

Data_089_7E37:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227E37, $D7

Data_089_7F0E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $227F0E, $66
    ds $8C, $00
