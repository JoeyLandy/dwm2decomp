SECTION "Bank 96", ROMX[$4000], BANK[$96]
    db $96

Func_096_4001::
    ld de, Data_096_404B
    ld a, [$C529]
    sub a, $C8
    ld [$C529], a
    call Func_000_25C9
    ret

Func_096_4010:: ; heuristic: follows a terminator; C0
    ld de, Data_096_404B
    ld a, [$C529]
    sub a, $C8
    ld [$C529], a
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Func_096_4026::
    ld de, Data_096_574A
    ld a, [$C529]
    sub a, $90
    ld [$C529], a
    call Func_000_25C9
    ret

Func_096_4035:: ; heuristic: follows a terminator; C0
    ld de, Data_096_574A
    ld a, [$C529]
    sub a, $90
    ld [$C529], a
    call Func_000_25FE
    ret
    db $CD, $26, $40, $CD, $11, $26, $C9

Data_096_404B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4D, $40
    dw Data_096_40BD
    dw Data_096_4119
    dw Data_096_4184
    dw Data_096_4236
    dw Data_096_42BE
    dw Data_096_432C
    dw Data_096_4374
    dw Data_096_43AA
    dw Data_096_43F6
    dw Data_096_4413
    dw Data_096_442E
    dw Data_096_44B1
    dw Data_096_44D3
    dw Data_096_44F2
    dw Data_096_4735
    dw Data_096_4735
    dw Data_096_47D8
    dw Data_096_4818
    dw Data_096_4878
    dw Data_096_4899
    dw Data_096_48DA
    dw Data_096_494E
    dw Data_096_494E
    dw Data_096_49BC
    dw Data_096_4A3C
    dw Data_096_4A9E
    dw Data_096_4B0D
    dw Data_096_4B91
    dw Data_096_4C0F
    dw Data_096_4CC6
    dw Data_096_4D0E
    dw Data_096_4E8F
    dw Data_096_4EE5
    dw Data_096_4F27
    dw Data_096_4F80
    dw Data_096_4FEC
    dw Data_096_4FF7
    dw Data_096_5016
    dw Data_096_5036
    dw Data_096_510C
    dw Data_096_515B
    dw Data_096_51C2
    dw Data_096_51C2
    dw Data_096_5201
    dw Data_096_525C
    dw Data_096_52C9
    dw Data_096_539D
    dw Data_096_539D
    dw Data_096_547E
    dw Data_096_54C2
    dw Data_096_5507
    dw Data_096_554B
    dw Data_096_55C7
    dw Data_096_560B
    dw Data_096_5671
    dw Data_096_56B8

Data_096_40BD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2580BD, $5C

Data_096_4119:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258119, $6B

Data_096_4184:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258184, $B2

Data_096_4236:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258236, $88

Data_096_42BE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2582BE, $6E

Data_096_432C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25832C, $48

Data_096_4374:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $30
    db $24, $35, $2C, $32, $31, $28, $37, $37, $28, $B5, $FA, $F7, $EF, $EE, $12, $37
    db $90, $36, $24, $2A, $2A, $28, $27, $EF, $EE, $2F, $2C, $29, $28, $2F, $28, $36
    db $36, $2F, $3C, $B5, $F7, $F0

Data_096_43AA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2583AA, $4C

Data_096_43F6:: ; heuristic: target of a monotone pointer table; C0
    db $22, $38, $31, $24, $3E, $90, $36, $32, $38, $2F, $90, $29, $2C, $2F, $2F, $28
    db $27, $F1, $2B, $28, $35, $90, $25, $32, $27, $3C, $B5, $F7, $F0

Data_096_4413:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $A4, $90, $1C, $1D, $18, $19, $A4, $F1, $0D, $18, $17, $95
    db $1D, $90, $16, $0E, $0D, $0D, $15, $0E, $A4, $F7, $F0

Data_096_442E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25842E, $83

Data_096_44B1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0F, $18, $18, $15, $11, $0A, $1B, $0D, $22, $B5, $F1, $0B, $1B
    db $0A, $1F, $0E, $90, $0B, $1E, $1D, $90, $0F, $18, $18, $15, $12, $1C, $11, $B5
    db $F7, $F0

Data_096_44D3:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $9C, $11, $18, $20, $A4, $90, $0B, $1E, $1D, $90, $12, $A4
    db $F1, $1D, $11, $12, $1C, $90, $12, $1C, $17, $95, $1D, $A4, $A4, $F7, $F0

Data_096_44F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2584F2, $243

Data_096_4735:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258735, $A3

Data_096_47D8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $15, $24, $27, $3C, $90, $22, $38, $31, $24, $90, $2B, $24, $36
    db $F1, $35, $28, $2A, $24, $2C, $31, $28, $27, $90, $2B, $28, $35, $90, $38, $36
    db $38, $24, $2F, $FA, $F7, $EF, $EE, $28, $3B, $38, $25, $28, $35, $24, $31, $26
    db $28, $90, $24, $31, $27, $EF, $EE, $28, $31, $28, $35, $2A, $3C, $B5, $F7, $F0

Data_096_4818:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258818, $60

Data_096_4878:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $98, $90, $11, $32, $3A, $90, $27, $2C, $27, $90, $3C
    db $32, $38, $F1, $2A, $28, $37, $90, $2C, $31, $90, $2B, $28, $35, $28, $98, $F7
    db $F0

Data_096_4899:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258899, $41

Data_096_48DA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2588DA, $74

Data_096_494E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25894E, $6E

Data_096_49BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2589BC, $80

Data_096_4A3C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258A3C, $62

Data_096_4A9E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258A9E, $6F

Data_096_4B0D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258B0D, $84

Data_096_4B91:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258B91, $7E

Data_096_4C0F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258C0F, $B7

Data_096_4CC6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258CC6, $48

Data_096_4D0E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258D0E, $181

Data_096_4E8F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258E8F, $56

Data_096_4EE5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258EE5, $42

Data_096_4F27:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258F27, $59

Data_096_4F80:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $258F80, $6C

Data_096_4FEC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $A4, $A4, $A4, $A4, $A4, $A4, $F7, $F0

Data_096_4FF7:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $1A, $38, $28, $28, $31, $90, $37, $32, $32, $2E, $90, $37
    db $2B, $28, $F1, $1C, $2F, $28, $28, $33, $11, $28, $35, $25, $A4, $F7, $F0

Data_096_5016:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $3A, $2C, $36, $2B, $90, $3C, $32, $38, $F1, $3A, $32
    db $38, $2F, $27, $31, $41, $90, $27, $32, $90, $37, $2B, $24, $37, $A4, $F7, $F0

Data_096_5036:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259036, $D6

Data_096_510C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25910C, $4F

Data_096_515B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25915B, $67

Data_096_51C2:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $AB, $90, $30, $3C, $90, $2A, $32, $32, $27, $31, $28
    db $36, $36, $99, $F1, $1D, $2B, $24, $31, $2E, $90, $3C, $32, $38, $99, $FA, $F7
    db $EF, $EE, $22, $32, $38, $90, $36, $24, $39, $28, $27, $90, $32, $38, $35, $EF
    db $EE, $1A, $38, $28, $28, $31, $90, $11, $28, $2F, $28, $31, $99, $F7, $F0

Data_096_5201:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259201, $5B

Data_096_525C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25925C, $6D

Data_096_52C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2592C9, $D4

Data_096_539D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25939D, $E1

Data_096_547E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25947E, $44

Data_096_54C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2594C2, $45

Data_096_5507:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259507, $44

Data_096_554B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25954B, $7C

Data_096_55C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2595C7, $44

Data_096_560B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25960B, $66

Data_096_5671:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259671, $47

Data_096_56B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2596B8, $92

Data_096_574A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4C, $57
    dw Data_096_582C
    dw Data_096_586E
    dw Data_096_588A
    dw Data_096_5941
    dw Data_096_595F
    dw Data_096_5A3D
    dw Data_096_5A99
    dw Data_096_5B1C
    dw Data_096_5B8C
    dw Data_096_5C1F
    dw Data_096_5CCA
    dw Data_096_5CEB
    dw Data_096_5DBD
    dw Data_096_5E68
    dw Data_096_5E8B
    dw Data_096_5F5D
    dw Data_096_602E
    dw Data_096_604E
    dw Data_096_6146
    dw Data_096_61ED
    dw Data_096_62CB
    dw Data_096_6386
    dw Data_096_63EB
    dw Data_096_6456
    dw Data_096_64C4
    dw Data_096_654E
    dw Data_096_654E
    dw Data_096_654E
    dw Data_096_654E
    dw Data_096_65B5
    dw Data_096_66AD
    dw Data_096_6723
    dw Data_096_67A6
    dw Data_096_686E
    dw Data_096_691E
    dw Data_096_6985
    dw Data_096_6A11
    dw Data_096_6AA1
    dw Data_096_6AC2
    dw Data_096_6B16
    dw Data_096_6B35
    dw Data_096_6B89
    dw Data_096_6C18
    dw Data_096_6C60
    dw Data_096_6CFD
    dw Data_096_6D41
    dw Data_096_6DA7
    dw Data_096_6DF7
    dw Data_096_6E82
    dw Data_096_6EA2
    dw Data_096_6EC0
    dw Data_096_6EE0
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6
    dw Data_096_6EF6

Data_096_582C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25982C, $42

Data_096_586E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $24, $30, $28, $2B, $24, $A3, $90, $20, $2B, $24, $37, $98, $F1, $1C
    db $26, $24, $35, $28, $27, $AB, $90, $F9, $00, $98, $F7, $F0

Data_096_588A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25988A, $B7

Data_096_5941:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $0E, $2F, $29, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_096_595F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25995F, $DE

Data_096_5A3D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259A3D, $5C

Data_096_5A99:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259A99, $83

Data_096_5B1C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259B1C, $70

Data_096_5B8C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259B8C, $93

Data_096_5C1F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259C1F, $AB

Data_096_5CCA:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $15, $32, $31, $28, $2F, $3C, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF
    db $F0

Data_096_5CEB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259CEB, $D2

Data_096_5DBD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259DBD, $AB

Data_096_5E68:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $1D, $35, $24, $39, $28, $2F, $28, $35, $90, $14, $28, $3C, $B5, $E5, $58, $F7
    db $E9, $FF, $F0

Data_096_5E8B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259E8B, $D2

Data_096_5F5D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $259F5D, $D1

Data_096_602E:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $0B, $35, $24, $3A, $31, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_096_604E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A04E, $F8

Data_096_6146:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A146, $A7

Data_096_61ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A1ED, $DE

Data_096_62CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A2CB, $BB

Data_096_6386:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A386, $65

Data_096_63EB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A3EB, $6B

Data_096_6456:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A456, $6E

Data_096_64C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A4C4, $8A

Data_096_654E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A54E, $67

Data_096_65B5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A5B5, $F8

Data_096_66AD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A6AD, $76

Data_096_6723:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A723, $83

Data_096_67A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A7A6, $C8

Data_096_686E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A86E, $B0

Data_096_691E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A91E, $67

Data_096_6985:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25A985, $8C

Data_096_6A11:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25AA11, $90

Data_096_6AA1:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28, $F1
    db $0B, $24, $29, $29, $2F, $28, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF
    db $F0

Data_096_6AC2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25AAC2, $54

Data_096_6B16:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28, $F1
    db $1C, $32, $38, $2F, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_096_6B35:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25AB35, $54

Data_096_6B89:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25AB89, $8F

Data_096_6C18:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25AC18, $48

Data_096_6C60:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25AC60, $9D

Data_096_6CFD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25ACFD, $44

Data_096_6D41:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25AD41, $66

Data_096_6DA7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25ADA7, $50

Data_096_6DF7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25ADF7, $8B

Data_096_6E82:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28, $F1
    db $16, $24, $2A, $2C, $26, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_096_6EA2:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $38, $37, $90, $37, $2B, $28, $35, $28, $90, $3A, $24, $36, $F1, $31, $32
    db $37, $2B, $2C, $31, $2A, $90, $37, $2B, $28, $35, $28, $B5, $F7, $F0

Data_096_6EC0:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $90, $37, $2B, $28, $F1
    db $16, $24, $2A, $2C, $26, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_096_6EE0:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $26, $2B, $28, $26, $2E, $28, $27, $90, $37, $2B, $28, $F1, $27
    db $28, $36, $2E, $B5, $F7, $F0

Data_096_6EF6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25AEF6, $11B

Func_096_7011::
    ld de, Data_096_7036
    ld a, [$C529]
    sub a, $88
    ld [$C529], a
    call Func_000_25C9
    ret

Func_096_7020:: ; heuristic: follows a terminator; C0
    ld de, Data_096_7036
    ld a, [$C529]
    sub a, $88
    ld [$C529], a
    call Func_000_25FE
    ret
    db $CD, $11, $70, $CD, $11, $26, $C9

Data_096_7036:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $38, $70
    dw Data_096_7068
    dw Data_096_70D1
    dw Data_096_70F2
    dw Data_096_712E
    dw Data_096_716A
    dw Data_096_7191
    dw Data_096_7191
    dw Data_096_7191
    dw Data_096_7191
    dw Data_096_7191
    dw Data_096_7191
    dw Data_096_71CC
    dw Data_096_71EF
    dw Data_096_723D
    dw Data_096_7255
    dw Data_096_729D
    dw Data_096_72BA
    dw Data_096_7328
    dw Data_096_734B
    dw Data_096_738C
    dw Data_096_73C4
    dw Data_096_73E7
    dw Data_096_73E7
    dw Data_096_73E7

Data_096_7068:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25B068, $69

Data_096_70D1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $14, $98, $90, $15, $28, $37, $3E, $90, $31, $32, $37, $F1
    db $3A, $24, $36, $37, $28, $90, $24, $31, $3C, $90, $37, $2C, $30, $28, $B5, $F7
    db $F0

Data_096_70F2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $2F, $2F, $90, $35, $2C, $2A, $2B, $37, $AB, $90, $3A, $28
    db $43, $2F, $F1, $2B, $24, $39, $28, $90, $37, $32, $90, $27, $32, $90, $37, $2B
    db $2C, $36, $FA, $F7, $EF, $EE, $24, $2A, $24, $2C, $31, $90, $24, $31, $32, $37
    db $2B, $28, $35, $EF, $EE, $37, $2C, $30, $28, $B5, $F7, $F0

Data_096_712E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $F1, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $2C, $31
    db $90, $3C, $32, $38, $35, $FA, $F7, $EF, $EE, $28, $2A, $2A, $B5, $FA, $F7, $EF
    db $EE, $20, $24, $31, $37, $90, $37, $32, $90, $27, $32, $90, $37, $2B, $2C, $36
    db $EF, $EE, $25, $35, $28, $28, $27, $2C, $31, $2A, $98, $F0

Data_096_716A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $36, $90, $24, $26, $26, $28, $36, $36, $32, $35, $3C
    db $90, $2C, $36, $F1, $2C, $31, $90, $37, $2B, $28, $90, $1F, $24, $38, $2F, $37
    db $90, $31, $32, $3A, $B5, $F7, $F0

Data_096_7191:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $30, $AB, $90, $37, $2B, $24, $37, $3E, $90, $37, $32, $32
    db $F1, $25, $24, $27, $AB, $90, $37, $2B, $28, $31, $B5, $FA, $F7, $EF, $EE, $12
    db $37, $3E, $90, $24, $90, $3A, $24, $36, $37, $28, $27, $EF, $EE, $32, $33, $33
    db $32, $35, $37, $38, $31, $2C, $37, $3C, $A4, $F7, $F0

Data_096_71CC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $24, $37, $90, $3A, $2C, $2F, $2F, $90, $25, $28, $90
    db $30, $3C, $F1, $1C, $37, $32, $31, $28, $16, $24, $31, $3E, $90, $30, $24, $37
    db $28, $98, $F0

Data_096_71EF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25B1EF, $4E

Data_096_723D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $37, $2B, $24, $37, $90, $3C, $32, $38, $35, $F1
    db $26, $2B, $32, $2C, $26, $28, $98, $F0

Data_096_7255:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25B255, $48

Data_096_729D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $30, $38, $36, $37, $31, $41, $90, $25, $28
    db $F1, $24, $2F, $2F, $90, $24, $2F, $32, $31, $28, $B5, $F7, $F0

Data_096_72BA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25B2BA, $6E

Data_096_7328:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $2F, $2C, $2E, $28, $90, $37, $2B, $24, $37, $F1, $35
    db $28, $33, $2F, $3C, $99, $90, $15, $28, $37, $3E, $90, $36, $37, $24, $35, $37
    db $B5, $F7, $F0

Data_096_734B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $25B34B, $41

Data_096_738C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $F1, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $3C, $32
    db $38, $35, $90, $25, $24, $25, $3C, $B5, $FA, $F7, $EF, $EE, $12, $36, $90, $37
    db $2B, $24, $37, $90, $24, $26, $26, $28, $33, $37, $24, $25, $2F, $28, $EF, $EE
    db $37, $32, $90, $3C, $32, $38, $98, $F0

Data_096_73C4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $37, $36, $90, $24, $26, $26, $28, $36, $36, $32, $35, $3C
    db $90, $2C, $36, $F1, $2C, $31, $90, $37, $2B, $28, $90, $1F, $24, $38, $2F, $37
    db $B5, $F7, $F0

Data_096_73E7:: ; heuristic: target of a monotone pointer table; C0
    db $F0
    ds $C18, $00
