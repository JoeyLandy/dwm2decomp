SECTION "Bank 42", ROMX[$4000], BANK[$42]
    db $42

; E-0018. Sound ids 49-167.
; record: channel-state slot offset (added to $DC00); copied to slot byte +2 (meaning unverified); track stream (stored at slot +3/+4, with this bank at +5)
SoundRecords_Bank42::
Data_042_4001:: ; heuristic: sound record array named by the bank table; C0
    db $40, $00 ; id 49
    dw Data_042_41DD
    db $60, $01 ; id 50
    dw Data_042_4DB5
    db $80, $02 ; id 51
    dw Data_042_5441
    db $00, $03 ; id 52
    dw Data_042_5E57
    db $40, $00 ; id 53
    dw Data_042_5E5D
    db $60, $01 ; id 54
    dw Data_042_612D
    db $80, $02 ; id 55
    dw Data_042_6345
    db $00, $03 ; id 56
    dw Data_042_66F7
    db $40, $00 ; id 57
    dw Data_042_66FD
    db $60, $01 ; id 58
    dw Data_042_6703
    db $80, $02 ; id 59
    dw Data_042_6709
    db $A0, $03 ; id 60
    dw Data_042_670F
    db $40, $00 ; id 61
    dw Data_042_6715
    db $60, $01 ; id 62
    dw Data_042_6729
    db $80, $02 ; id 63
    dw Data_042_6751
    db $00, $00 ; id 64
    dw Data_042_676D
    db $20, $01 ; id 65
    dw Data_042_678F
    db $00, $00 ; id 66
    dw Data_042_67B1
    db $20, $01 ; id 67
    dw Data_042_67DF
    db $00, $00 ; id 68
    dw Data_042_680D
    db $20, $01 ; id 69
    dw Data_042_6843
    db $00, $00 ; id 70
    dw Data_042_6879
    db $20, $01 ; id 71
    dw Data_042_68BF
    db $40, $00 ; id 72
    dw Data_042_6905
    db $60, $01 ; id 73
    dw Data_042_6927
    db $40, $00 ; id 74
    dw Data_042_6949
    db $60, $01 ; id 75
    dw Data_042_69D3
    db $80, $02 ; id 76
    dw Data_042_6A43
    db $40, $00 ; id 77
    dw Data_042_6A67
    db $60, $01 ; id 78
    dw Data_042_6B85
    db $80, $02 ; id 79
    dw Data_042_6C59
    db $00, $00 ; id 80
    dw Data_042_6D29
    db $20, $01 ; id 81
    dw Data_042_6D47
    db $00, $00 ; id 82
    dw Data_042_6D65
    db $20, $01 ; id 83
    dw Data_042_6D85
    db $40, $00 ; id 84
    dw Data_042_6DA5
    db $60, $01 ; id 85
    dw Data_042_6E1B
    db $80, $02 ; id 86
    dw Data_042_6E87
    db $00, $03 ; id 87
    dw Data_042_6EE3
    db $40, $00 ; id 88
    dw Data_042_6EE9
    db $60, $01 ; id 89
    dw Data_042_6F1D
    db $80, $02 ; id 90
    dw Data_042_6F57
    db $A0, $03 ; id 91
    dw Data_042_6F69
    db $40, $00 ; id 92
    dw Data_042_6F71
    db $60, $01 ; id 93
    dw Data_042_6F77
    db $80, $02 ; id 94
    dw Data_042_6F7D
    db $A0, $03 ; id 95
    dw Data_042_6F83
    db $00, $03 ; id 96
    dw Data_042_6F89
    db $00, $00 ; id 97
    dw Data_042_6FAD
    db $00, $00 ; id 98
    dw Data_042_7059
    db $00, $00 ; id 99
    dw Data_042_706D
    db $20, $03 ; id 100
    dw Data_042_707D
    db $00, $00 ; id 101
    dw Data_042_708F
    db $00, $03 ; id 102
    dw Data_042_709D
    db $00, $00 ; id 103
    dw Data_042_70AB
    db $20, $01 ; id 104
    dw Data_042_70C9
    db $00, $00 ; id 105
    dw Data_042_7155
    db $00, $00 ; id 106
    dw Data_042_7161
    db $00, $00 ; id 107
    dw Data_042_7169
    db $00, $00 ; id 108
    dw Data_042_7171
    db $40, $00 ; id 109
    dw Data_042_7192
    db $60, $01 ; id 110
    dw Data_042_72DD
    db $80, $03 ; id 111
    dw Data_042_7430
    db $00, $00 ; id 112
    dw Data_042_7441
    db $20, $03 ; id 113
    dw Data_042_7451
    db $00, $00 ; id 114
    dw Data_042_7469
    db $20, $03 ; id 115
    dw Data_042_747D
    db $00, $00 ; id 116
    dw Data_042_7493
    db $20, $01 ; id 117
    dw Data_042_74BF
    db $20, $03 ; id 118
    dw Data_042_74EB
    db $00, $00 ; id 119
    dw Data_042_750B
    db $00, $03 ; id 120
    dw Data_042_7511
    db $00, $00 ; id 121
    dw Data_042_7529
    db $00, $00 ; id 122
    dw Data_042_752F
    db $00, $03 ; id 123
    dw Data_042_754C
    db $00, $00 ; id 124
    dw Data_042_7561
    db $00, $03 ; id 125
    dw Data_042_7578
    db $00, $00 ; id 126
    dw Data_042_758D
    db $20, $01 ; id 127
    dw Data_042_75BD
    db $00, $00 ; id 128
    dw Data_042_75EB
    db $00, $03 ; id 129
    dw Data_042_7604
    db $00, $03 ; id 130
    dw Data_042_7613
    db $00, $03 ; id 131
    dw Data_042_762E
    db $00, $00 ; id 132
    dw Data_042_7641
    db $00, $00 ; id 133
    dw Data_042_7650
    db $00, $00 ; id 134
    dw Data_042_768D
    db $00, $00 ; id 135
    dw Data_042_76A9
    db $00, $00 ; id 136
    dw Data_042_76C2
    db $00, $00 ; id 137
    dw Data_042_774E
    db $20, $03 ; id 138
    dw Data_042_77A4
    db $00, $00 ; id 139
    dw Data_042_77B2
    db $20, $03 ; id 140
    dw Data_042_784A
    db $00, $00 ; id 141
    dw Data_042_7858
    db $20, $03 ; id 142
    dw Data_042_7932
    db $00, $00 ; id 143
    dw Data_042_7940
    db $00, $03 ; id 144
    dw Data_042_7AD6
    db $00, $00 ; id 145
    dw Data_042_7B00
    db $20, $03 ; id 146
    dw Data_042_7B30
    db $00, $03 ; id 147
    dw Data_042_7B74
    db $00, $03 ; id 148
    dw Data_042_7B8E
    db $00, $00 ; id 149
    dw Data_042_7BB6
    db $00, $03 ; id 150
    dw Data_042_7C3C
    db $00, $03 ; id 151
    dw Data_042_7C68
    db $00, $03 ; id 152
    dw Data_042_7C80
    db $00, $03 ; id 153
    dw Data_042_7C9A
    db $00, $00 ; id 154
    dw Data_042_7CB6
    db $00, $00 ; id 155
    dw Data_042_7CD2
    db $00, $03 ; id 156
    dw Data_042_7CE8
    db $00, $03 ; id 157
    dw Data_042_7CEE
    db $00, $03 ; id 158
    dw Data_042_7D12
    db $00, $00 ; id 159
    dw Data_042_7D28
    db $20, $03 ; id 160
    dw Data_042_7E5C
    db $00, $03 ; id 161
    dw Data_042_7E6C
    db $00, $03 ; id 162
    dw Data_042_7E82
    db $00, $03 ; id 163
    dw Data_042_7EAA
    db $00, $03 ; id 164
    dw Data_042_7ED6
    db $00, $00 ; id 165
    dw Data_042_7F10
    db $20, $03 ; id 166
    dw Data_042_7F98
    db $00, $03 ; id 167
    dw Data_042_7FAE

Data_042_41DD:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $1081DD, $BD8

Data_042_4DB5:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $108DB5, $68C

Data_042_5441:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $109441, $A16

Data_042_5E57:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_5E5D:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $109E5D, $2D0

Data_042_612D:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10A12D, $218

Data_042_6345:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10A345, $3B2

Data_042_66F7:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_66FD:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_6703:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_6709:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_670F:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_6715:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0C, $00, $1F, $40, $C0, $FE, $29, $40, $27, $40, $A0, $08, $C1, $70
    db $27, $30, $FF, $FF

Data_042_6729:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0F, $00, $A0, $04, $1F, $10, $14, $10, $17, $10, $20, $10, $A0, $0D
    db $C0, $FE, $30, $3C, $A0, $05, $C1, $20, $30, $04, $A0, $0D, $C0, $FE, $30, $40
    db $A0, $08, $C1, $70, $30, $30, $FF, $FF

Data_042_6751:: ; heuristic: track stream of a sound record; C0
    db $05, $FF, $02, $0C, $24, $10, $27, $10, $30, $10, $34, $10, $35, $20, $32, $20
    db $34, $40, $A2, $40, $A0, $04, $34, $20, $1F, $10, $FF, $FF

Data_042_676D:: ; heuristic: track stream of a sound record; C0
    db $04, $02, $0E, $00, $C1, $50, $36, $0C, $35, $0C, $34, $0C, $32, $0C, $C2, $15
    db $30, $0D, $26, $0D, $C1, $7F, $A0, $0D, $36, $18, $A0, $06, $C1, $30, $36, $18
    db $FF, $FF

Data_042_678F:: ; heuristic: track stream of a sound record; C0
    db $04, $02, $0F, $00, $C1, $50, $42, $0C, $41, $0C, $40, $0C, $3B, $0C, $C2, $15
    db $39, $0D, $32, $0D, $C1, $7F, $A0, $0E, $42, $18, $A0, $07, $C1, $30, $42, $18
    db $FF, $FF

Data_042_67B1:: ; heuristic: track stream of a sound record; C0
    db $0B, $00, $05, $00, $1F, $04, $35, $06, $22, $04, $29, $04, $35, $04, $34, $04
    db $21, $04, $29, $04, $34, $04, $32, $04, $1A, $04, $27, $04, $32, $04, $31, $04
    db $2A, $05, $29, $05, $28, $06, $29, $02, $28, $02, $29, $18, $FF, $FF

Data_042_67DF:: ; heuristic: track stream of a sound record; C0
    db $0B, $00, $0F, $00, $35, $06, $22, $04, $29, $04, $35, $04, $34, $04, $21, $04
    db $29, $04, $34, $04, $32, $04, $1A, $04, $27, $04, $32, $04, $31, $04, $2A, $05
    db $29, $05, $28, $06, $29, $02, $28, $02, $29, $18, $1F, $04, $FF, $FF

Data_042_680D:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0E, $00, $39, $08, $38, $04, $39, $02, $FD, $F0, $35, $02, $37, $02
    db $B3, $F0, $35, $02, $34, $02, $33, $02, $32, $02, $31, $02, $30, $02, $2B, $02
    db $2A, $02, $29, $02, $28, $02, $A0, $08, $27, $02, $26, $02, $A0, $04, $25, $02
    db $24, $02, $1F, $08, $FF, $FF

Data_042_6843:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0F, $00, $2A, $08, $32, $04, $2A, $02, $FD, $F0, $2B, $02, $28, $02
    db $B3, $F0, $2B, $02, $2A, $02, $29, $02, $28, $02, $27, $02, $26, $02, $25, $02
    db $24, $02, $23, $02, $22, $02, $A0, $08, $21, $02, $20, $02, $A0, $04, $1B, $02
    db $1A, $02, $1F, $08, $FF, $FF

Data_042_6879:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10A879, $46

Data_042_68BF:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10A8BF, $46

Data_042_6905:: ; heuristic: track stream of a sound record; C0
    db $09, $02, $0F, $00, $C1, $60, $24, $04, $14, $03, $15, $03, $17, $03, $19, $03
    db $1B, $03, $20, $03, $22, $03, $C2, $15, $24, $06, $2B, $06, $C1, $1F, $34, $0C
    db $FF, $FF

Data_042_6927:: ; heuristic: track stream of a sound record; C0
    db $09, $02, $0F, $00, $C1, $60, $27, $04, $20, $03, $22, $03, $24, $03, $25, $03
    db $27, $03, $29, $03, $2B, $03, $C2, $15, $30, $06, $37, $06, $C1, $1F, $40, $0C
    db $FF, $FF

Data_042_6949:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10A949, $8A

Data_042_69D3:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10A9D3, $70

Data_042_6A43:: ; heuristic: track stream of a sound record; C0
    db $04, $FF, $02, $03, $20, $62, $A0, $04, $20, $18, $1F, $59, $A0, $02, $A2, $30
    db $A1, $09, $20, $0F, $17, $0F, $20, $0F, $17, $0F, $A2, $FF, $20, $18, $A0, $06
    db $20, $18, $FF, $FF

Data_042_6A67:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10AA67, $11E

Data_042_6B85:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10AB85, $D4

Data_042_6C59:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10AC59, $D0

Data_042_6D29:: ; heuristic: track stream of a sound record; C0
    db $07, $01, $0F, $00, $C2, $1F, $30, $04, $2B, $04, $2A, $04, $C2, $15, $29, $08
    db $27, $08, $2A, $08, $C1, $30, $29, $0C, $A0, $06, $29, $0C, $FF, $FF

Data_042_6D47:: ; heuristic: track stream of a sound record; C0
    db $07, $01, $0F, $00, $C2, $1F, $35, $04, $35, $04, $35, $04, $C2, $15, $35, $08
    db $33, $08, $37, $08, $C1, $30, $35, $0C, $A0, $06, $35, $0C, $FF, $FF

Data_042_6D65:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0E, $00, $C1, $50, $FD, $F0, $12, $04, $21, $04, $11, $04, $20, $04
    db $B3, $F0, $16, $0C, $17, $02, $18, $02, $10, $08, $A0, $08, $10, $14, $FF, $FF

Data_042_6D85:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0F, $00, $C1, $50, $FD, $F0, $02, $04, $11, $04, $01, $04, $10, $04
    db $B3, $F0, $06, $0C, $07, $02, $08, $02, $00, $08, $A0, $08, $00, $14, $FF, $FF

Data_042_6DA5:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10ADA5, $76

Data_042_6E1B:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10AE1B, $6C

Data_042_6E87:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10AE87, $5C

Data_042_6EE3:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_6EE9:: ; heuristic: track stream of a sound record; C0
    db $04, $03, $0A, $00, $C2, $08, $24, $0C, $27, $0C, $30, $0C, $35, $0D, $1F, $02
    db $A0, $06, $34, $03, $40, $03, $34, $03, $40, $03, $A0, $04, $34, $03, $40, $03
    db $34, $03, $40, $03, $A0, $02, $34, $03, $40, $03, $A0, $01, $34, $03, $40, $03
    db $1F, $08, $FF, $FF

Data_042_6F1D:: ; heuristic: track stream of a sound record; C0
    db $04, $00, $0F, $00, $C1, $09, $27, $0C, $30, $0C, $34, $0C, $37, $0C, $A0, $0D
    db $34, $03, $40, $03, $A0, $0B, $34, $03, $40, $03, $A0, $09, $34, $03, $40, $03
    db $A0, $07, $34, $03, $40, $03, $A0, $05, $34, $03, $A0, $03, $40, $03, $A0, $02
    db $34, $03, $A0, $01, $40, $03, $1F, $0B, $FF, $FF

Data_042_6F57:: ; heuristic: track stream of a sound record; C0
    db $04, $06, $06, $02, $1F, $07, $37, $0C, $40, $0C, $44, $0C, $47, $0C, $1F, $28
    db $FF, $FF

Data_042_6F69:: ; heuristic: track stream of a sound record; C0
    db $04, $00, $00, $00, $1F, $70, $FF, $FF

Data_042_6F71:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_6F77:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_6F7D:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_6F83:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_6F89:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0D, $00, $47, $05, $A0, $02, $47, $08, $A0, $0D, $43, $05, $A0, $02
    db $43, $08, $A0, $0D, $47, $05, $A0, $02, $47, $08, $A0, $0D, $43, $05, $A0, $03
    db $43, $09, $FF, $FF

Data_042_6FAD:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10AFAD, $AC

Data_042_7059:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $37, $1B, $02, $1F, $01, $20, $01, $1F, $01, $21, $02, $A0, $05
    db $21, $03, $FF, $FF

Data_042_706D:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $2D, $AE, $10, $14, $03, $11, $02, $A0, $08, $11, $03, $FF, $FF

Data_042_707D:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $1F, $01, $80, $02, $A0, $08, $80, $02, $A0, $04, $80, $02
    db $FF, $FF

Data_042_708F:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $17, $C1, $60, $29, $06, $A1, $2F, $42, $30, $FF, $FF

Data_042_709D:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $13, $03, $37, $06, $A0, $04, $37, $02, $FF, $FF

Data_042_70AB:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $17, $18, $12, $A1, $2F, $6B, $12, $A1, $17, $1F, $01, $18, $12
    db $A1, $2F, $6B, $12, $A0, $06, $6B, $12, $A0, $02, $6B, $12, $FF, $FF

Data_042_70C9:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10B0C9, $8C

Data_042_7155:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $07, $00, $57, $02, $A0, $02, $57, $04, $FF, $FF

Data_042_7161:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $00, $30, $01, $FF, $FF

Data_042_7169:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $00, $29, $01, $FF, $FF

Data_042_7171:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $50, $02, $1F, $01, $56, $02, $1F, $01, $50, $02, $1F, $01
    db $56, $02, $1F, $01, $A0, $05, $50, $02, $1F, $01, $56, $02, $A0, $02, $56, $04
    db $FF

Data_042_7192:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10B192, $14B

Data_042_72DD:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10B2DD, $153

Data_042_7430:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $A3, $3A, $FD, $F0, $21, $60, $30, $60, $21, $44, $B0, $F0
    db $FF

Data_042_7441:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0C, $2A, $FD, $F0, $10, $05, $11, $05, $12, $04, $B0, $F0, $FF, $FF

Data_042_7451:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0C, $00, $FD, $F0, $61, $03, $52, $20, $C1, $7F, $52, $05, $B0, $F0
    db $22, $20, $A0, $05, $22, $28, $FF, $FF

Data_042_7469:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $27, $17, $05, $1F, $02, $A1, $45, $20, $06, $A0, $06, $22, $06
    db $1F, $03, $FF, $FF

Data_042_747D:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $5D, $02, $71, $03, $1F, $02, $60, $05, $A0, $06, $60, $05
    db $A0, $03, $60, $05, $FF, $FF

Data_042_7493:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $15, $20, $02, $20, $02, $20, $02, $20, $02, $30, $03, $34, $03
    db $A1, $27, $30, $05, $1F, $01, $42, $03, $1F, $01, $A0, $0B, $42, $05, $A0, $03
    db $1F, $01, $43, $05, $A0, $01, $1F, $01, $43, $05, $FF, $FF

Data_042_74BF:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00, $FD, $F0, $50, $01, $1F, $02, $B3, $F0, $A0, $0B, $50, $01
    db $1F, $01, $50, $01, $1F, $01, $A0, $09, $50, $01, $1F, $01, $50, $01, $1F, $01
    db $A0, $05, $50, $01, $1F, $01, $50, $01, $1F, $12, $FF, $FF

Data_042_74EB:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $FD, $F0, $A0, $0A, $CC, $6F, $12, $80, $A0, $0B, $C1, $7F
    db $12, $30, $C0, $FE, $A0, $08, $11, $80, $C1, $7F, $11, $2A, $B0, $F0, $FF, $FF

Data_042_750B:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_7511:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $1E, $01, $1F, $03, $A0, $06, $1E, $01, $A0, $0F, $1D, $01
    db $25, $01, $A0, $03, $1C, $02, $FF, $FF

Data_042_7529:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_752F:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00, $C2, $40, $AE, $10, $30, $05, $AE, $00, $33, $05, $31, $05
    db $34, $05, $32, $05, $35, $05, $36, $05, $A0, $04, $36, $0A, $FF

Data_042_754C:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $12, $02, $1F, $02, $C7, $30, $10, $18, $A0, $07, $10, $10
    db $A0, $05, $10, $20, $FF

Data_042_7561:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00, $45, $02, $46, $02, $44, $02, $45, $02, $46, $02, $44, $02
    db $A0, $07, $46, $02, $44, $02, $FF

Data_042_7578:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $FD, $F0, $33, $02, $62, $03, $1F, $01, $42, $02, $51, $02
    db $1F, $01, $B0, $F0, $FF

Data_042_758D:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $00, $10, $03, $17, $03, $20, $03, $22, $02, $24, $02, $25, $02
    db $27, $02, $29, $02, $2A, $02, $30, $02, $32, $02, $34, $02, $35, $02, $37, $02
    db $39, $02, $3A, $02, $C1, $30, $40, $15, $A0, $05, $40, $10, $1F, $03, $FF, $FF

Data_042_75BD:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $05, $00, $1F, $03, $10, $03, $17, $03, $20, $03, $22, $02, $24, $02
    db $25, $02, $27, $02, $29, $02, $2A, $02, $30, $02, $32, $02, $34, $02, $35, $02
    db $37, $02, $39, $02, $3A, $02, $C1, $40, $A3, $0D, $40, $25, $FF, $FF

Data_042_75EB:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00, $32, $02, $2B, $02, $33, $02, $32, $02, $2B, $02, $33, $02
    db $A0, $07, $33, $02, $2B, $02, $33, $02, $FF

Data_042_7604:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $50, $04, $51, $04, $61, $03, $A0, $03, $50, $03, $FF

Data_042_7613:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $47, $04, $1F, $02, $43, $03, $1F, $02, $47, $04, $1F, $02
    db $43, $04, $1F, $02, $44, $04, $1F, $02, $34, $04, $FF

Data_042_762E:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $50, $02, $33, $06, $50, $02, $33, $06, $50, $02, $33, $06
    db $60, $03, $FF

Data_042_7641:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $00, $3B, $04, $39, $04, $35, $04, $A0, $07, $35, $05, $FF

Data_042_7650:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00, $45, $02, $49, $02, $50, $02, $54, $02, $50, $02, $54, $02
    db $49, $02, $50, $02, $A0, $0B, $45, $02, $49, $02, $50, $02, $54, $02, $A0, $09
    db $50, $02, $54, $02, $49, $02, $50, $02, $A0, $05, $45, $02, $49, $02, $50, $02
    db $54, $02, $A0, $03, $50, $02, $54, $02, $49, $02, $50, $02, $FF

Data_042_768D:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $26, $A0, $0F, $0A, $14, $A1, $00, $C1, $7F, $A0, $0E, $AE, $10
    db $15, $20, $A0, $07, $15, $1A, $A0, $03, $15, $25, $FF, $FF

Data_042_76A9:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $2E, $47, $05, $44, $07, $A0, $0C, $40, $06, $38, $06, $A0, $0A
    db $35, $06, $33, $06, $A0, $07, $2B, $05, $FF

Data_042_76C2:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10B6C2, $8C

Data_042_774E:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10B74E, $56

Data_042_77A4:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $27, $02, $27, $02, $A0, $05, $27, $08, $FF, $FF

Data_042_77B2:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10B7B2, $98

Data_042_784A:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $27, $02, $27, $02, $A0, $05, $27, $06, $FF, $FF

Data_042_7858:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10B858, $DA

Data_042_7932:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $37, $02, $37, $02, $A0, $08, $37, $06, $FF, $FF

Data_042_7940:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10B940, $196

Data_042_7AD6:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $11, $02, $45, $03, $15, $01, $50, $03, $45, $03, $16, $01
    db $45, $02, $55, $02, $14, $01, $45, $02, $45, $06, $45, $03, $46, $04, $45, $06
    db $A0, $06, $45, $05, $A0, $04, $45, $05, $FF, $FF

Data_042_7B00:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $17, $A0, $08, $23, $02, $24, $02, $25, $02, $26, $02, $A0, $0B
    db $27, $02, $28, $02, $29, $02, $2A, $02, $A0, $0D, $2B, $02, $30, $02, $31, $02
    db $32, $02, $33, $03, $34, $02, $35, $02, $A0, $09, $35, $02, $A0, $0F, $FF, $FF

Data_042_7B30:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10BB30, $44

Data_042_7B74:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $C3, $07, $21, $05, $23, $05, $C0, $FE, $23, $05, $22, $08
    db $22, $07, $A0, $08, $C7, $30, $22, $20, $FF, $FF

Data_042_7B8E:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $11, $06, $13, $04, $22, $03, $23, $04, $23, $07, $22, $07
    db $12, $07, $11, $18, $A0, $0B, $11, $10, $A0, $0E, $11, $10, $A0, $0A, $11, $08
    db $C1, $20, $A0, $06, $11, $20, $FF, $FF

Data_042_7BB6:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10BBB6, $86

Data_042_7C3C:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $21, $08, $31, $05, $20, $05, $10, $03, $20, $04, $40, $05
    db $40, $05, $30, $03, $23, $05, $40, $06, $21, $08, $30, $04, $21, $05, $30, $05
    db $21, $02, $20, $07, $A0, $08, $C1, $20, $20, $08, $FF, $FF

Data_042_7C68:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $20, $07, $12, $08, $11, $08, $1F, $01, $50, $04, $60, $10
    db $C7, $20, $A0, $06, $60, $20, $FF, $FF

Data_042_7C80:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $45, $02, $11, $02, $1F, $01, $C3, $20, $45, $10, $30, $09
    db $C7, $30, $50, $06, $43, $08, $60, $20, $FF, $FF

Data_042_7C9A:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $15, $08, $06, $09, $04, $10, $03, $09, $05, $A0, $06, $10, $05
    db $08, $04, $09, $05, $A0, $04, $09, $05, $0B, $03, $FF, $FF

Data_042_7CB6:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $7F, $12, $02, $19, $04, $12, $03, $1A, $05, $10, $05, $A0, $0C
    db $10, $04, $A0, $0A, $10, $05, $A0, $03, $10, $05, $FF, $FF

Data_042_7CD2:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00, $A3, $17, $4B, $01, $49, $01, $4A, $02, $4B, $18, $C7, $30
    db $A3, $10, $4B, $28, $FF, $FF

Data_042_7CE8:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00, $FF, $FF

Data_042_7CEE:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $C7, $30, $50, $02, $A0, $0F, $40, $02, $12, $08, $30, $02
    db $12, $09, $40, $02, $12, $08, $A0, $0F, $40, $02, $1F, $01, $12, $0C, $A0, $06
    db $12, $10, $FF, $FF

Data_042_7D12:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $43, $02, $50, $02, $1F, $01, $42, $07, $A0, $08, $42, $07
    db $A0, $04, $42, $07, $FF, $FF

Data_042_7D28:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10BD28, $134

Data_042_7E5C:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $07, $00, $1F, $03, $C3, $40, $70, $20, $C7, $70, $70, $50, $FF, $FF

Data_042_7E6C:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $40, $02, $60, $03, $20, $08, $11, $02, $40, $03, $A0, $06
    db $C7, $10, $40, $05, $FF, $FF

Data_042_7E82:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $40, $05, $60, $05, $20, $08, $11, $02, $40, $08, $A0, $06
    db $C7, $20, $40, $08, $1F, $02, $A0, $0F, $C0, $FE, $88, $12, $50, $05, $60, $05
    db $40, $10, $C7, $10, $30, $20, $FF, $FF

Data_042_7EAA:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $40, $02, $60, $03, $20, $08, $11, $02, $40, $03, $A0, $06
    db $C7, $10, $40, $05, $C0, $FE, $20, $07, $12, $08, $11, $08, $1F, $01, $A0, $0F
    db $50, $04, $60, $10, $C7, $20, $A0, $06, $60, $20, $FF, $FF

Data_042_7ED6:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $3E, $01, $40, $05, $60, $03, $20, $08, $11, $02, $A0, $08
    db $40, $06, $A0, $05, $C7, $10, $40, $0D, $10, $03, $11, $03, $C0, $FE, $A0, $0F
    db $C3, $07, $11, $05, $25, $05, $21, $05, $23, $05, $C0, $FE, $23, $05, $22, $08
    db $22, $07, $A0, $08, $C7, $40, $22, $20, $FF, $FF

Data_042_7F10:: ; heuristic: track stream of a sound record; C0
    INCBIN "dwm2-cobi-us.gbc", $10BF10, $88

Data_042_7F98:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $40, $02, $60, $03, $20, $08, $11, $02, $40, $03, $A0, $06
    db $C7, $10, $40, $05, $FF, $FF

Data_042_7FAE:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00, $20, $0B, $3E, $02, $60, $02, $98, $03, $43, $09, $C1, $20
    db $A0, $09, $43, $20, $FF, $FF
    ds $3C, $00
