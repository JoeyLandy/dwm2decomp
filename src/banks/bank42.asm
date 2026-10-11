SECTION "Bank 42", ROMX[$4000], BANK[$42]
    db $42

; E-0018. Sound ids 49-167.
; record: channel-state slot offset (added to $DC00); copied to slot byte +2 (meaning unverified); track stream (stored at slot +3/+4, with this bank at +5)
SoundRecords_Bank42::
Data_042_4001:: ; address name
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

; sound track, 1509 events after the header (E-0019: grammar C2, meaning C0)
Data_042_41DD:: ; heuristic: track stream of a sound record; C0
    db $0A, $01, $09, $00 ; header: param=10 byte1=$01 volume=$09 byte3=$00
    db $AC, $01 ; call x1
    dw $0B50 ; byte offset of the called section from the track start
    db $AC, $01 ; call x1
    dw $0874 ; byte offset of the called section from the track start
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $37, $0C ; note G3 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $33, $0C ; note D#3 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $33, $04 ; note D#3 dur 4
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $2B, $0C ; note B2 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $2B, $04 ; note B2 dur 4
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $27, $0C ; note G2 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $25, $0C ; note F2 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $25, $04 ; note F2 dur 4
    db $C3, $6F ; env $6F
    db $A0, $09 ; volume $09
    db $1B, $0C ; note B1 dur 12
    db $C1, $2F ; env $2F
    db $A0, $04 ; volume $04
    db $1B, $14 ; note B1 dur 20
    db $AC, $01 ; call x1
    dw $0874 ; byte offset of the called section from the track start
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $37, $0C ; note G3 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $33, $0C ; note D#3 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $33, $04 ; note D#3 dur 4
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $2B, $0C ; note B2 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $2B, $04 ; note B2 dur 4
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $27, $0C ; note G2 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $25, $0C ; note F2 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $25, $04 ; note F2 dur 4
    db $C1, $20 ; env $20
    db $A0, $0B ; volume $0B
    db $1B, $03 ; note B1 dur 3
    db $A0, $03 ; volume $03
    db $1B, $01 ; note B1 dur 1
    db $A0, $0B ; volume $0B
    db $22, $03 ; note D2 dur 3
    db $A0, $03 ; volume $03
    db $22, $01 ; note D2 dur 1
    db $A0, $0B ; volume $0B
    db $22, $03 ; note D2 dur 3
    db $A0, $03 ; volume $03
    db $22, $01 ; note D2 dur 1
    db $A0, $0B ; volume $0B
    db $25, $03 ; note F2 dur 3
    db $A0, $03 ; volume $03
    db $25, $01 ; note F2 dur 1
    db $A0, $0B ; volume $0B
    db $25, $03 ; note F2 dur 3
    db $A0, $03 ; volume $03
    db $25, $01 ; note F2 dur 1
    db $A0, $0B ; volume $0B
    db $27, $03 ; note G2 dur 3
    db $A0, $03 ; volume $03
    db $27, $01 ; note G2 dur 1
    db $A0, $0B ; volume $0B
    db $27, $03 ; note G2 dur 3
    db $A0, $03 ; volume $03
    db $27, $01 ; note G2 dur 1
    db $A0, $0B ; volume $0B
    db $2B, $03 ; note B2 dur 3
    db $A0, $03 ; volume $03
    db $2B, $01 ; note B2 dur 1
    db $FD, $F0 ; label 0
    db $A2, $01 ; duty2 $01
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $10, $04 ; note C1 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $B1, $F0 ; repeat $F0
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $04, $04 ; note E0 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $32, $04 ; note D3 dur 4
    db $27, $04 ; note G2 dur 4
    db $32, $04 ; note D3 dur 4
    db $37, $04 ; note G3 dur 4
    db $32, $04 ; note D3 dur 4
    db $27, $04 ; note G2 dur 4
    db $32, $04 ; note D3 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $14, $04 ; note E1 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $32, $04 ; note D3 dur 4
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $09, $04 ; note A0 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $27, $04 ; note G2 dur 4
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $12, $04 ; note D1 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $30, $04 ; note C3 dur 4
    db $32, $04 ; note D3 dur 4
    db $30, $04 ; note C3 dur 4
    db $12, $04 ; note D1 dur 4
    db $25, $04 ; note F2 dur 4
    db $20, $04 ; note C2 dur 4
    db $25, $04 ; note F2 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $04, $04 ; note E0 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $32, $04 ; note D3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $09, $04 ; note A0 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $24, $04 ; note E2 dur 4
    db $21, $04 ; note C#2 dur 4
    db $24, $04 ; note E2 dur 4
    db $29, $04 ; note A2 dur 4
    db $24, $04 ; note E2 dur 4
    db $21, $04 ; note C#2 dur 4
    db $24, $04 ; note E2 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $05, $04 ; note F0 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $35, $04 ; note F3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $05, $04 ; note F0 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $28, $04 ; note G#2 dur 4
    db $30, $04 ; note C3 dur 4
    db $28, $04 ; note G#2 dur 4
    db $35, $04 ; note F3 dur 4
    db $28, $04 ; note G#2 dur 4
    db $30, $04 ; note C3 dur 4
    db $28, $04 ; note G#2 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $10, $04 ; note C1 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $34, $04 ; note E3 dur 4
    db $27, $04 ; note G2 dur 4
    db $34, $04 ; note E3 dur 4
    db $27, $04 ; note G2 dur 4
    db $34, $04 ; note E3 dur 4
    db $27, $04 ; note G2 dur 4
    db $34, $04 ; note E3 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $09, $04 ; note A0 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $37, $04 ; note G3 dur 4
    db $31, $04 ; note C#3 dur 4
    db $37, $04 ; note G3 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $19, $04 ; note A1 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $31, $04 ; note C#3 dur 4
    db $27, $04 ; note G2 dur 4
    db $31, $04 ; note C#3 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $02, $04 ; note D0 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $22, $04 ; note D2 dur 4
    db $20, $04 ; note C2 dur 4
    db $22, $04 ; note D2 dur 4
    db $19, $04 ; note A1 dur 4
    db $22, $04 ; note D2 dur 4
    db $20, $04 ; note C2 dur 4
    db $22, $04 ; note D2 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $07, $04 ; note G0 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $25, $04 ; note F2 dur 4
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $27, $04 ; note G2 dur 4
    db $25, $04 ; note F2 dur 4
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $10, $04 ; note C1 dur 4
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $20, $04 ; note C2 dur 4
    db $19, $04 ; note A1 dur 4
    db $10, $04 ; note C1 dur 4
    db $17, $04 ; note G1 dur 4
    db $10, $04 ; note C1 dur 4
    db $15, $04 ; note F1 dur 4
    db $10, $04 ; note C1 dur 4
    db $17, $04 ; note G1 dur 4
    db $10, $04 ; note C1 dur 4
    db $A2, $01 ; duty2 $01
    db $A0, $0C ; volume $0C
    db $C3, $48 ; env $48
    db $25, $08 ; note F2 dur 8
    db $29, $04 ; note A2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $29, $0C ; note A2 dur 12
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $29, $04 ; note A2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $29, $04 ; note A2 dur 4
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $25, $08 ; note F2 dur 8
    db $28, $04 ; note G#2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $28, $0C ; note G#2 dur 12
    db $C1, $30 ; env $30
    db $FD, $F0 ; label 0
    db $A0, $06 ; volume $06
    db $28, $02 ; note G#2 dur 2
    db $A0, $03 ; volume $03
    db $28, $02 ; note G#2 dur 2
    db $B1, $F0 ; repeat $F0
    db $A0, $0C ; volume $0C
    db $C3, $48 ; env $48
    db $24, $08 ; note E2 dur 8
    db $27, $04 ; note G2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $27, $0C ; note G2 dur 12
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $27, $04 ; note G2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $27, $04 ; note G2 dur 4
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $24, $08 ; note E2 dur 8
    db $27, $04 ; note G2 dur 4
    db $A0, $05 ; volume $05
    db $27, $0C ; note G2 dur 12
    db $C1, $30 ; env $30
    db $FD, $F0 ; label 0
    db $A0, $06 ; volume $06
    db $27, $02 ; note G2 dur 2
    db $A0, $03 ; volume $03
    db $27, $02 ; note G2 dur 2
    db $B1, $F0 ; repeat $F0
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $25, $08 ; note F2 dur 8
    db $29, $04 ; note A2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $29, $0C ; note A2 dur 12
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $29, $04 ; note A2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $29, $04 ; note A2 dur 4
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $25, $08 ; note F2 dur 8
    db $28, $04 ; note G#2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $28, $0C ; note G#2 dur 12
    db $C1, $30 ; env $30
    db $FD, $F0 ; label 0
    db $A0, $06 ; volume $06
    db $28, $02 ; note G#2 dur 2
    db $A0, $03 ; volume $03
    db $28, $02 ; note G#2 dur 2
    db $B1, $F0 ; repeat $F0
    db $A0, $0C ; volume $0C
    db $C3, $48 ; env $48
    db $24, $08 ; note E2 dur 8
    db $27, $04 ; note G2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $27, $0C ; note G2 dur 12
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $27, $04 ; note G2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $27, $04 ; note G2 dur 4
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $24, $08 ; note E2 dur 8
    db $27, $04 ; note G2 dur 4
    db $C1, $50 ; env $50
    db $A0, $05 ; volume $05
    db $27, $0C ; note G2 dur 12
    db $C1, $30 ; env $30
    db $FD, $F0 ; label 0
    db $A0, $06 ; volume $06
    db $27, $02 ; note G2 dur 2
    db $A0, $03 ; volume $03
    db $27, $02 ; note G2 dur 2
    db $B1, $F0 ; repeat $F0
    db $A0, $09 ; volume $09
    db $C3, $48 ; env $48
    db $22, $08 ; note D2 dur 8
    db $26, $04 ; note F#2 dur 4
    db $C1, $50 ; env $50
    db $A0, $08 ; volume $08
    db $26, $0C ; note F#2 dur 12
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $26, $04 ; note F#2 dur 4
    db $C1, $50 ; env $50
    db $A0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $22, $08 ; note D2 dur 8
    db $26, $04 ; note F#2 dur 4
    db $C1, $50 ; env $50
    db $A0, $08 ; volume $08
    db $26, $0C ; note F#2 dur 12
    db $C1, $30 ; env $30
    db $FD, $F0 ; label 0
    db $A0, $06 ; volume $06
    db $26, $02 ; note F#2 dur 2
    db $A0, $03 ; volume $03
    db $26, $02 ; note F#2 dur 2
    db $B1, $F0 ; repeat $F0
    db $A0, $08 ; volume $08
    db $C3, $02 ; env $02
    db $32, $03 ; note D3 dur 3
    db $A0, $03 ; volume $03
    db $32, $01 ; note D3 dur 1
    db $A0, $08 ; volume $08
    db $32, $03 ; note D3 dur 3
    db $A0, $03 ; volume $03
    db $32, $01 ; note D3 dur 1
    db $A0, $08 ; volume $08
    db $31, $03 ; note C#3 dur 3
    db $A0, $03 ; volume $03
    db $31, $01 ; note C#3 dur 1
    db $A0, $08 ; volume $08
    db $32, $03 ; note D3 dur 3
    db $A0, $03 ; volume $03
    db $32, $01 ; note D3 dur 1
    db $A0, $08 ; volume $08
    db $34, $03 ; note E3 dur 3
    db $A0, $03 ; volume $03
    db $34, $01 ; note E3 dur 1
    db $A0, $08 ; volume $08
    db $34, $03 ; note E3 dur 3
    db $A0, $03 ; volume $03
    db $34, $01 ; note E3 dur 1
    db $A0, $08 ; volume $08
    db $33, $03 ; note D#3 dur 3
    db $A0, $03 ; volume $03
    db $33, $01 ; note D#3 dur 1
    db $A0, $08 ; volume $08
    db $34, $03 ; note E3 dur 3
    db $A0, $03 ; volume $03
    db $34, $01 ; note E3 dur 1
    db $A0, $08 ; volume $08
    db $35, $03 ; note F3 dur 3
    db $A0, $03 ; volume $03
    db $35, $01 ; note F3 dur 1
    db $A0, $08 ; volume $08
    db $35, $03 ; note F3 dur 3
    db $A0, $03 ; volume $03
    db $35, $01 ; note F3 dur 1
    db $A0, $08 ; volume $08
    db $34, $03 ; note E3 dur 3
    db $A0, $03 ; volume $03
    db $34, $01 ; note E3 dur 1
    db $A0, $08 ; volume $08
    db $35, $03 ; note F3 dur 3
    db $A0, $03 ; volume $03
    db $35, $01 ; note F3 dur 1
    db $A0, $08 ; volume $08
    db $37, $03 ; note G3 dur 3
    db $A0, $03 ; volume $03
    db $37, $01 ; note G3 dur 1
    db $A0, $08 ; volume $08
    db $37, $03 ; note G3 dur 3
    db $A0, $03 ; volume $03
    db $37, $01 ; note G3 dur 1
    db $A0, $08 ; volume $08
    db $36, $03 ; note F#3 dur 3
    db $A0, $03 ; volume $03
    db $36, $01 ; note F#3 dur 1
    db $A0, $08 ; volume $08
    db $37, $03 ; note G3 dur 3
    db $A0, $03 ; volume $03
    db $37, $01 ; note G3 dur 1
    db $A0, $08 ; volume $08
    db $C3, $48 ; env $48
    db $39, $03 ; note A3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $39, $04 ; note A3 dur 4
    db $A0, $0C ; volume $0C
    db $37, $03 ; note G3 dur 3
    db $39, $03 ; note A3 dur 3
    db $37, $02 ; note G3 dur 2
    db $35, $03 ; note F3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $35, $04 ; note F3 dur 4
    db $A0, $0C ; volume $0C
    db $34, $03 ; note E3 dur 3
    db $35, $03 ; note F3 dur 3
    db $34, $02 ; note E3 dur 2
    db $32, $03 ; note D3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $32, $04 ; note D3 dur 4
    db $A0, $0C ; volume $0C
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $30, $02 ; note C3 dur 2
    db $2B, $03 ; note B2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $2B, $04 ; note B2 dur 4
    db $A0, $0C ; volume $0C
    db $29, $03 ; note A2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $29, $04 ; note A2 dur 4
    db $A0, $0C ; volume $0C
    db $2B, $20 ; note B2 dur 32
    db $A3, $20 ; mod $20
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $2B, $10 ; note B2 dur 16
    db $C3, $58 ; env $58
    db $A3, $26 ; mod $26
    db $A0, $0F ; volume $0F
    db $17, $08 ; note G1 dur 8
    db $19, $08 ; note A1 dur 8
    db $24, $10 ; note E2 dur 16
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $24, $10 ; note E2 dur 16
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1B, $20 ; note B1 dur 32
    db $C1, $7F ; env $7F
    db $A3, $20 ; mod $20
    db $A0, $06 ; volume $06
    db $1B, $10 ; note B1 dur 16
    db $C3, $58 ; env $58
    db $A3, $26 ; mod $26
    db $A0, $0F ; volume $0F
    db $20, $08 ; note C2 dur 8
    db $1B, $08 ; note B1 dur 8
    db $19, $10 ; note A1 dur 16
    db $1B, $08 ; note B1 dur 8
    db $20, $08 ; note C2 dur 8
    db $15, $10 ; note F1 dur 16
    db $17, $08 ; note G1 dur 8
    db $19, $08 ; note A1 dur 8
    db $17, $08 ; note G1 dur 8
    db $19, $08 ; note A1 dur 8
    db $14, $18 ; note E1 dur 24
    db $C1, $6F ; env $6F
    db $A3, $20 ; mod $20
    db $A0, $07 ; volume $07
    db $14, $08 ; note E1 dur 8
    db $C3, $58 ; env $58
    db $A3, $26 ; mod $26
    db $A0, $0F ; volume $0F
    db $14, $0E ; note E1 dur 14
    db $C1, $70 ; env $70
    db $A0, $08 ; volume $08
    db $14, $02 ; note E1 dur 2
    db $C3, $58 ; env $58
    db $A3, $26 ; mod $26
    db $A0, $0F ; volume $0F
    db $14, $08 ; note E1 dur 8
    db $12, $08 ; note D1 dur 8
    db $20, $18 ; note C2 dur 24
    db $C1, $7F ; env $7F
    db $A3, $20 ; mod $20
    db $A0, $0A ; volume $0A
    db $20, $08 ; note C2 dur 8
    db $C3, $58 ; env $58
    db $A3, $26 ; mod $26
    db $A0, $0F ; volume $0F
    db $1A, $08 ; note A#1 dur 8
    db $18, $08 ; note G#1 dur 8
    db $17, $08 ; note G1 dur 8
    db $19, $08 ; note A1 dur 8
    db $1B, $08 ; note B1 dur 8
    db $20, $08 ; note C2 dur 8
    db $24, $04 ; note E2 dur 4
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $C3, $58 ; env $58
    db $A0, $0F ; volume $0F
    db $14, $08 ; note E1 dur 8
    db $1A, $08 ; note A#1 dur 8
    db $21, $08 ; note C#2 dur 8
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $19, $10 ; note A1 dur 16
    db $20, $10 ; note C2 dur 16
    db $22, $10 ; note D2 dur 16
    db $24, $04 ; note E2 dur 4
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $A2, $01 ; duty2 $01
    db $C3, $58 ; env $58
    db $A0, $0C ; volume $0C
    db $34, $08 ; note E3 dur 8
    db $30, $08 ; note C3 dur 8
    db $27, $08 ; note G2 dur 8
    db $24, $08 ; note E2 dur 8
    db $20, $06 ; note C2 dur 6
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $20, $02 ; note C2 dur 2
    db $C3, $28 ; env $28
    db $A0, $0A ; volume $0A
    db $19, $02 ; note A1 dur 2
    db $1B, $02 ; note B1 dur 2
    db $20, $02 ; note C2 dur 2
    db $22, $02 ; note D2 dur 2
    db $A0, $09 ; volume $09
    db $24, $02 ; note E2 dur 2
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $29, $02 ; note A2 dur 2
    db $AC, $01 ; call x1
    dw $0B50 ; byte offset of the called section from the track start
    db $AC, $01 ; call x1
    dw $0874 ; byte offset of the called section from the track start
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $37, $0C ; note G3 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $33, $0C ; note D#3 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $33, $04 ; note D#3 dur 4
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $2B, $0C ; note B2 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $2B, $04 ; note B2 dur 4
    db $A2, $02 ; duty2 $02
    db $A3, $26 ; mod $26
    db $C3, $68 ; env $68
    db $A0, $0C ; volume $0C
    db $27, $10 ; note G2 dur 16
    db $25, $08 ; note F2 dur 8
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $25, $08 ; note F2 dur 8
    db $C4, $10 ; env $10
    db $A0, $0C ; volume $0C
    db $1B, $02 ; note B1 dur 2
    db $A0, $08 ; volume $08
    db $1B, $02 ; note B1 dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $27, $02 ; note G2 dur 2
    db $A0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $A0, $0C ; volume $0C
    db $27, $02 ; note G2 dur 2
    db $A0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $A0, $0C ; volume $0C
    db $2B, $02 ; note B2 dur 2
    db $A0, $08 ; volume $08
    db $2B, $02 ; note B2 dur 2
    db $A0, $03 ; volume $03
    db $27, $02 ; note G2 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $2B, $02 ; note B2 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $29, $02 ; note A2 dur 2
    db $A0, $08 ; volume $08
    db $29, $02 ; note A2 dur 2
    db $A0, $0C ; volume $0C
    db $29, $02 ; note A2 dur 2
    db $A0, $08 ; volume $08
    db $29, $02 ; note A2 dur 2
    db $A0, $0C ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $A0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $A0, $0C ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $A0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $A0, $0C ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $A0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $A0, $0C ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $A0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $A0, $0C ; volume $0C
    db $3A, $02 ; note A#3 dur 2
    db $A0, $08 ; volume $08
    db $3A, $02 ; note A#3 dur 2
    db $A0, $0C ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $A0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $A0, $0C ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $A0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $A0, $0C ; volume $0C
    db $2A, $02 ; note A#2 dur 2
    db $A0, $08 ; volume $08
    db $2A, $02 ; note A#2 dur 2
    db $A0, $03 ; volume $03
    db $32, $02 ; note D3 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $2A, $02 ; note A#2 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $2B, $02 ; note B2 dur 2
    db $A0, $08 ; volume $08
    db $2B, $02 ; note B2 dur 2
    db $A0, $0C ; volume $0C
    db $2B, $02 ; note B2 dur 2
    db $A0, $08 ; volume $08
    db $2B, $02 ; note B2 dur 2
    db $A0, $0C ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $A0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $A0, $0C ; volume $0C
    db $2A, $02 ; note A#2 dur 2
    db $A0, $08 ; volume $08
    db $2A, $02 ; note A#2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $2B, $02 ; note B2 dur 2
    db $A0, $08 ; volume $08
    db $2B, $02 ; note B2 dur 2
    db $A0, $0C ; volume $0C
    db $27, $02 ; note G2 dur 2
    db $A0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $1B, $02 ; note B1 dur 2
    db $A0, $08 ; volume $08
    db $1B, $02 ; note B1 dur 2
    db $A0, $03 ; volume $03
    db $22, $02 ; note D2 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $1B, $02 ; note B1 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $29, $02 ; note A2 dur 2
    db $A0, $08 ; volume $08
    db $29, $02 ; note A2 dur 2
    db $A0, $0C ; volume $0C
    db $29, $02 ; note A2 dur 2
    db $A0, $08 ; volume $08
    db $29, $02 ; note A2 dur 2
    db $A0, $0C ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $A0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $A0, $0C ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $A0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $A0, $0C ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $A0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $A0, $0C ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $A0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $A0, $0C ; volume $0C
    db $3A, $02 ; note A#3 dur 2
    db $A0, $08 ; volume $08
    db $3A, $02 ; note A#3 dur 2
    db $A0, $0C ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $A0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $A0, $0C ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $A0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $A0, $0C ; volume $0C
    db $2A, $02 ; note A#2 dur 2
    db $A0, $08 ; volume $08
    db $2A, $02 ; note A#2 dur 2
    db $1F, $08 ; rest-note $1F dur 8
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $2B, $02 ; note B2 dur 2
    db $A0, $08 ; volume $08
    db $2B, $02 ; note B2 dur 2
    db $A0, $0C ; volume $0C
    db $2B, $02 ; note B2 dur 2
    db $A0, $08 ; volume $08
    db $2B, $02 ; note B2 dur 2
    db $A0, $0C ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $A0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $A0, $0C ; volume $0C
    db $2A, $02 ; note A#2 dur 2
    db $A0, $08 ; volume $08
    db $2A, $02 ; note A#2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $A0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $2B, $02 ; note B2 dur 2
    db $A0, $08 ; volume $08
    db $2B, $02 ; note B2 dur 2
    db $A0, $0C ; volume $0C
    db $27, $02 ; note G2 dur 2
    db $A0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $A0, $0C ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $A0, $0C ; volume $0C
    db $1B, $02 ; note B1 dur 2
    db $A0, $08 ; volume $08
    db $1B, $02 ; note B1 dur 2
    db $A0, $03 ; volume $03
    db $22, $02 ; note D2 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $1B, $02 ; note B1 dur 2
    db $1F, $0A ; rest-note $1F dur 10
    db $C3, $48 ; env $48
    db $A2, $02 ; duty2 $02
    db $A0, $0C ; volume $0C
    db $18, $06 ; note G#1 dur 6
    db $A0, $06 ; volume $06
    db $18, $02 ; note G#1 dur 2
    db $A0, $0C ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $A0, $06 ; volume $06
    db $20, $02 ; note C2 dur 2
    db $A0, $0C ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $A0, $06 ; volume $06
    db $20, $02 ; note C2 dur 2
    db $A0, $0C ; volume $0C
    db $23, $06 ; note D#2 dur 6
    db $A0, $06 ; volume $06
    db $23, $02 ; note D#2 dur 2
    db $A0, $0C ; volume $0C
    db $23, $06 ; note D#2 dur 6
    db $A0, $06 ; volume $06
    db $23, $02 ; note D#2 dur 2
    db $A0, $0C ; volume $0C
    db $28, $06 ; note G#2 dur 6
    db $A0, $06 ; volume $06
    db $28, $02 ; note G#2 dur 2
    db $A0, $0C ; volume $0C
    db $25, $06 ; note F2 dur 6
    db $A0, $06 ; volume $06
    db $25, $02 ; note F2 dur 2
    db $A0, $0C ; volume $0C
    db $29, $06 ; note A2 dur 6
    db $A0, $06 ; volume $06
    db $29, $02 ; note A2 dur 2
    db $A0, $0C ; volume $0C
    db $30, $06 ; note C3 dur 6
    db $A0, $06 ; volume $06
    db $30, $02 ; note C3 dur 2
    db $A0, $0C ; volume $0C
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $02 ; note F3 dur 2
    db $A0, $0C ; volume $0C
    db $39, $06 ; note A3 dur 6
    db $C1, $3F ; env $3F
    db $A0, $05 ; volume $05
    db $39, $0A ; note A3 dur 10
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $23, $10 ; note D#2 dur 16
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $30, $08 ; note C3 dur 8
    db $A1, $00 ; duty $00
    db $FD, $F0 ; label 0
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $34, $04 ; note E3 dur 4
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $34, $04 ; note E3 dur 4
    db $B2, $F0 ; repeat $F0
    db $C3, $68 ; env $68
    db $A0, $0C ; volume $0C
    db $32, $18 ; note D3 dur 24
    db $A3, $20 ; mod $20
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $AF, $04 ; param $04
    db $A7, $10 ; wait $10
    db $A3, $26 ; mod $26
    db $FD, $F0 ; label 0
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $30, $08 ; note C3 dur 8
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $30, $08 ; note C3 dur 8
    db $B2, $F0 ; repeat $F0
    db $C3, $68 ; env $68
    db $A0, $0E ; volume $0E
    db $29, $34 ; note A2 dur 52
    db $C1, $7F ; env $7F
    db $A3, $20 ; mod $20
    db $A0, $06 ; volume $06
    db $29, $23 ; note A2 dur 35
    db $FD, $F0 ; label 0
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $2A, $08 ; note A#2 dur 8
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $2A, $0A ; note A#2 dur 10
    db $B2, $F0 ; repeat $F0
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $2B, $08 ; note B2 dur 8
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $2B, $0A ; note B2 dur 10
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $25, $08 ; note F2 dur 8
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $25, $0B ; note F2 dur 11
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $22, $08 ; note D2 dur 8
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $22, $0B ; note D2 dur 11
    db $C3, $48 ; env $48
    db $A0, $0E ; volume $0E
    db $1B, $08 ; note B1 dur 8
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $1B, $0B ; note B1 dur 11
    db $A0, $09 ; volume $09
    db $A2, $01 ; duty2 $01
    db $C3, $58 ; env $58
    db $FD, $F0 ; label 0
    db $24, $04 ; note E2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $BF, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $24, $04 ; note E2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $24, $04 ; note E2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $B6, $F0 ; repeat $F0
    db $A7, $02 ; wait $02
    db $C3, $58 ; env $58
    db $24, $10 ; note E2 dur 16
    db $A0, $06 ; volume $06
    db $C1, $70 ; env $70
    db $24, $20 ; note E2 dur 32
    db $FF, $FF ; end
    db $A0, $05 ; volume $05
    db $37, $08 ; note G3 dur 8
    db $A3, $03 ; mod $03
    db $C3, $68 ; env $68
    db $A0, $0C ; volume $0C
    db $25, $06 ; note F2 dur 6
    db $C1, $40 ; env $40
    db $A0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $C3, $68 ; env $68
    db $A0, $0C ; volume $0C
    db $29, $0C ; note A2 dur 12
    db $C1, $40 ; env $40
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $29, $0C ; note A2 dur 12
    db $A3, $03 ; mod $03
    db $C3, $68 ; env $68
    db $A0, $0C ; volume $0C
    db $27, $06 ; note G2 dur 6
    db $C1, $40 ; env $40
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $C3, $68 ; env $68
    db $A0, $0C ; volume $0C
    db $2B, $0C ; note B2 dur 12
    db $A3, $00 ; mod $00
    db $C1, $40 ; env $40
    db $A0, $05 ; volume $05
    db $2B, $0C ; note B2 dur 12
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0C ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $C1, $40 ; env $40
    db $A0, $04 ; volume $04
    db $24, $02 ; note E2 dur 2
    db $C3, $68 ; env $68
    db $A0, $0C ; volume $0C
    db $30, $0C ; note C3 dur 12
    db $C1, $40 ; env $40
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $30, $0C ; note C3 dur 12
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0A ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $C1, $40 ; env $40
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $32, $0C ; note D3 dur 12
    db $C1, $40 ; env $40
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $32, $0C ; note D3 dur 12
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0A ; volume $0A
    db $21, $06 ; note C#2 dur 6
    db $C1, $40 ; env $40
    db $A0, $04 ; volume $04
    db $21, $02 ; note C#2 dur 2
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $24, $0C ; note E2 dur 12
    db $A3, $00 ; mod $00
    db $C1, $40 ; env $40
    db $A0, $05 ; volume $05
    db $24, $0C ; note E2 dur 12
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $C1, $40 ; env $40
    db $A0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $30, $0C ; note C3 dur 12
    db $A3, $00 ; mod $00
    db $C1, $40 ; env $40
    db $A0, $05 ; volume $05
    db $30, $0C ; note C3 dur 12
    db $C3, $78 ; env $78
    db $A3, $03 ; mod $03
    db $A0, $0A ; volume $0A
    db $29, $08 ; note A2 dur 8
    db $2B, $08 ; note B2 dur 8
    db $29, $08 ; note A2 dur 8
    db $2B, $08 ; note B2 dur 8
    db $A0, $09 ; volume $09
    db $29, $08 ; note A2 dur 8
    db $2B, $08 ; note B2 dur 8
    db $A0, $08 ; volume $08
    db $29, $08 ; note A2 dur 8
    db $C1, $30 ; env $30
    db $A0, $03 ; volume $03
    db $29, $08 ; note A2 dur 8
    db $A2, $02 ; duty2 $02
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $20, $03 ; note C2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $20, $04 ; note C2 dur 4
    db $A0, $0C ; volume $0C
    db $29, $03 ; note A2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $20, $04 ; note C2 dur 4
    db $A0, $0C ; volume $0C
    db $20, $03 ; note C2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $29, $04 ; note A2 dur 4
    db $C1, $20 ; env $20
    db $20, $08 ; note C2 dur 8
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $1B, $03 ; note B1 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $1B, $04 ; note B1 dur 4
    db $A0, $0C ; volume $0C
    db $25, $03 ; note F2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $1B, $04 ; note B1 dur 4
    db $A0, $0C ; volume $0C
    db $1B, $03 ; note B1 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $25, $04 ; note F2 dur 4
    db $C1, $20 ; env $20
    db $1B, $08 ; note B1 dur 8
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $1B, $03 ; note B1 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $1B, $04 ; note B1 dur 4
    db $A0, $0C ; volume $0C
    db $27, $03 ; note G2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $1B, $04 ; note B1 dur 4
    db $A0, $0C ; volume $0C
    db $1B, $03 ; note B1 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $C1, $20 ; env $20
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $1F, $04 ; rest-note $1F dur 4
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $21, $03 ; note C#2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $21, $04 ; note C#2 dur 4
    db $A0, $0C ; volume $0C
    db $27, $03 ; note G2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $21, $04 ; note C#2 dur 4
    db $A0, $0C ; volume $0C
    db $21, $03 ; note C#2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $C1, $20 ; env $20
    db $A0, $02 ; volume $02
    db $21, $08 ; note C#2 dur 8
    db $1F, $04 ; rest-note $1F dur 4
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $25, $03 ; note F2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $25, $04 ; note F2 dur 4
    db $A0, $0C ; volume $0C
    db $29, $03 ; note A2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $25, $04 ; note F2 dur 4
    db $A0, $0C ; volume $0C
    db $30, $03 ; note C3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $29, $04 ; note A2 dur 4
    db $A0, $0C ; volume $0C
    db $25, $18 ; note F2 dur 24
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $25, $10 ; note F2 dur 16
    db $C3, $58 ; env $58
    db $A0, $0C ; volume $0C
    db $20, $08 ; note C2 dur 8
    db $28, $10 ; note G#2 dur 16
    db $29, $0C ; note A2 dur 12
    db $C1, $60 ; env $60
    db $A0, $06 ; volume $06
    db $29, $04 ; note A2 dur 4
    db $C3, $58 ; env $58
    db $A0, $0C ; volume $0C
    db $2B, $10 ; note B2 dur 16
    db $C3, $02 ; env $02
    db $A0, $09 ; volume $09
    db $18, $04 ; note G#1 dur 4
    db $20, $04 ; note C2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $28, $04 ; note G#2 dur 4
    db $30, $04 ; note C3 dur 4
    db $33, $04 ; note D#3 dur 4
    db $30, $04 ; note C3 dur 4
    db $28, $04 ; note G#2 dur 4
    db $25, $04 ; note F2 dur 4
    db $28, $04 ; note G#2 dur 4
    db $30, $04 ; note C3 dur 4
    db $32, $04 ; note D3 dur 4
    db $35, $04 ; note F3 dur 4
    db $32, $04 ; note D3 dur 4
    db $30, $04 ; note C3 dur 4
    db $28, $04 ; note G#2 dur 4
    db $25, $04 ; note F2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2A, $04 ; note A#2 dur 4
    db $32, $04 ; note D3 dur 4
    db $2A, $04 ; note A#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $22, $04 ; note D2 dur 4
    db $20, $04 ; note C2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $28, $04 ; note G#2 dur 4
    db $30, $04 ; note C3 dur 4
    db $28, $04 ; note G#2 dur 4
    db $27, $04 ; note G2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $20, $04 ; note C2 dur 4
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $28, $04 ; note G#2 dur 4
    db $30, $04 ; note C3 dur 4
    db $28, $04 ; note G#2 dur 4
    db $25, $04 ; note F2 dur 4
    db $22, $04 ; note D2 dur 4
    db $19, $04 ; note A1 dur 4
    db $20, $04 ; note C2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $26, $04 ; note F#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $26, $04 ; note F#2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $20, $04 ; note C2 dur 4
    db $18, $04 ; note G#1 dur 4
    db $20, $04 ; note C2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $25, $04 ; note F2 dur 4
    db $28, $04 ; note G#2 dur 4
    db $25, $04 ; note F2 dur 4
    db $23, $04 ; note D#2 dur 4
    db $20, $04 ; note C2 dur 4
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $28, $04 ; note G#2 dur 4
    db $25, $04 ; note F2 dur 4
    db $22, $04 ; note D2 dur 4
    db $20, $04 ; note C2 dur 4
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $A0, $02 ; volume $02
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $C3, $48 ; env $48
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $22, $03 ; note D2 dur 3
    db $A0, $03 ; volume $03
    db $22, $05 ; note D2 dur 5
    db $B1, $F0 ; repeat $F0
    db $A0, $0E ; volume $0E
    db $22, $03 ; note D2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $C1, $20 ; env $20
    db $A0, $03 ; volume $03
    db $22, $0C ; note D2 dur 12
    db $C3, $48 ; env $48
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $23, $03 ; note D#2 dur 3
    db $A0, $03 ; volume $03
    db $23, $05 ; note D#2 dur 5
    db $B1, $F0 ; repeat $F0
    db $A0, $0E ; volume $0E
    db $23, $03 ; note D#2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $C1, $20 ; env $20
    db $A0, $03 ; volume $03
    db $23, $0C ; note D#2 dur 12
    db $C3, $48 ; env $48
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $20, $03 ; note C2 dur 3
    db $A0, $03 ; volume $03
    db $20, $05 ; note C2 dur 5
    db $B1, $F0 ; repeat $F0
    db $A0, $0E ; volume $0E
    db $20, $03 ; note C2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $C1, $20 ; env $20
    db $A0, $03 ; volume $03
    db $20, $0C ; note C2 dur 12
    db $C3, $48 ; env $48
    db $FD, $F0 ; label 0
    db $A0, $0E ; volume $0E
    db $1B, $03 ; note B1 dur 3
    db $A0, $03 ; volume $03
    db $1B, $05 ; note B1 dur 5
    db $B1, $F0 ; repeat $F0
    db $A0, $0E ; volume $0E
    db $1B, $03 ; note B1 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $C1, $20 ; env $20
    db $A0, $03 ; volume $03
    db $1B, $14 ; note B1 dur 20
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $17, $0C ; note G1 dur 12
    db $C1, $30 ; env $30
    db $A0, $06 ; volume $06
    db $17, $14 ; note G1 dur 20
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $23, $0C ; note D#2 dur 12
    db $C1, $30 ; env $30
    db $A0, $06 ; volume $06
    db $23, $14 ; note D#2 dur 20
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $1A, $0C ; note A#1 dur 12
    db $C1, $30 ; env $30
    db $A0, $06 ; volume $06
    db $1A, $14 ; note A#1 dur 20
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $19, $0C ; note A1 dur 12
    db $C1, $30 ; env $30
    db $A0, $06 ; volume $06
    db $19, $04 ; note A1 dur 4
    db $C3, $78 ; env $78
    db $A0, $0C ; volume $0C
    db $17, $30 ; note G1 dur 48
    db $A0, $0A ; volume $0A
    db $C1, $70 ; env $70
    db $17, $10 ; note G1 dur 16
    db $C3, $78 ; env $78
    db $A0, $0C ; volume $0C
    db $18, $30 ; note G#1 dur 48
    db $C1, $50 ; env $50
    db $A3, $00 ; mod $00
    db $A0, $09 ; volume $09
    db $18, $20 ; note G#1 dur 32
    db $AD, $00 ; return $00
    db $A3, $23 ; mod $23
    db $C1, $2F ; env $2F
    db $A0, $0F ; volume $0F
    db $10, $08 ; note C1 dur 8
    db $17, $08 ; note G1 dur 8
    db $C0, $FE ; env $FE
    db $24, $0C ; note E2 dur 12
    db $A3, $20 ; mod $20
    db $C1, $6F ; env $6F
    db $A0, $09 ; volume $09
    db $24, $14 ; note E2 dur 20
    db $A3, $23 ; mod $23
    db $A0, $0F ; volume $0F
    db $10, $08 ; note C1 dur 8
    db $A0, $08 ; volume $08
    db $10, $08 ; note C1 dur 8
    db $C1, $2F ; env $2F
    db $A0, $0F ; volume $0F
    db $12, $08 ; note D1 dur 8
    db $19, $08 ; note A1 dur 8
    db $C0, $FE ; env $FE
    db $25, $0C ; note F2 dur 12
    db $A3, $20 ; mod $20
    db $C1, $6F ; env $6F
    db $A0, $09 ; volume $09
    db $25, $14 ; note F2 dur 20
    db $A3, $23 ; mod $23
    db $A0, $0F ; volume $0F
    db $12, $08 ; note D1 dur 8
    db $A0, $08 ; volume $08
    db $12, $08 ; note D1 dur 8
    db $C1, $2F ; env $2F
    db $A3, $23 ; mod $23
    db $A0, $0F ; volume $0F
    db $14, $08 ; note E1 dur 8
    db $1B, $08 ; note B1 dur 8
    db $C1, $5F ; env $5F
    db $24, $08 ; note E2 dur 8
    db $A0, $0A ; volume $0A
    db $24, $08 ; note E2 dur 8
    db $C1, $2F ; env $2F
    db $A3, $23 ; mod $23
    db $A0, $0F ; volume $0F
    db $09, $08 ; note A0 dur 8
    db $14, $08 ; note E1 dur 8
    db $C1, $5F ; env $5F
    db $21, $08 ; note C#2 dur 8
    db $A0, $08 ; volume $08
    db $21, $08 ; note C#2 dur 8
    db $C1, $3F ; env $3F
    db $A3, $23 ; mod $23
    db $A0, $0F ; volume $0F
    db $12, $08 ; note D1 dur 8
    db $19, $08 ; note A1 dur 8
    db $C1, $5F ; env $5F
    db $20, $10 ; note C2 dur 16
    db $C1, $5F ; env $5F
    db $1B, $08 ; note B1 dur 8
    db $C1, $3F ; env $3F
    db $A0, $04 ; volume $04
    db $1B, $08 ; note B1 dur 8
    db $A0, $09 ; volume $09
    db $C3, $68 ; env $68
    db $1B, $0C ; note B1 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $1B, $04 ; note B1 dur 4
    db $AD, $00 ; return $00

; sound track, 831 events after the header (E-0019: grammar C2, meaning C0)
Data_042_4DB5:: ; heuristic: track stream of a sound record; C0
    db $0A, $01, $09, $00 ; header: param=10 byte1=$01 volume=$09 byte3=$00
    db $AC, $01 ; call x1
    dw $0652 ; byte offset of the called section from the track start
    db $AC, $01 ; call x1
    dw $0402 ; byte offset of the called section from the track start
    db $23, $40 ; note D#2 dur 64
    db $22, $28 ; note D2 dur 40
    db $C1, $7F ; env $7F
    db $A3, $20 ; mod $20
    db $A0, $07 ; volume $07
    db $22, $10 ; note D2 dur 16
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0D ; volume $0D
    db $37, $08 ; note G3 dur 8
    db $AC, $01 ; call x1
    dw $0402 ; byte offset of the called section from the track start
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $23, $40 ; note D#2 dur 64
    db $22, $20 ; note D2 dur 32
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $07 ; volume $07
    db $22, $10 ; note D2 dur 16
    db $C3, $58 ; env $58
    db $A3, $05 ; mod $05
    db $A2, $02 ; duty2 $02
    db $A0, $0D ; volume $0D
    db $37, $08 ; note G3 dur 8
    db $39, $08 ; note A3 dur 8
    db $44, $10 ; note E4 dur 16
    db $42, $08 ; note D4 dur 8
    db $40, $08 ; note C4 dur 8
    db $44, $10 ; note E4 dur 16
    db $42, $08 ; note D4 dur 8
    db $40, $08 ; note C4 dur 8
    db $3B, $20 ; note B3 dur 32
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $07 ; volume $07
    db $3B, $10 ; note B3 dur 16
    db $C3, $58 ; env $58
    db $A3, $05 ; mod $05
    db $A0, $0D ; volume $0D
    db $40, $08 ; note C4 dur 8
    db $3B, $08 ; note B3 dur 8
    db $39, $10 ; note A3 dur 16
    db $3B, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $35, $10 ; note F3 dur 16
    db $37, $08 ; note G3 dur 8
    db $39, $08 ; note A3 dur 8
    db $37, $08 ; note G3 dur 8
    db $39, $08 ; note A3 dur 8
    db $34, $18 ; note E3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $34, $08 ; note E3 dur 8
    db $C3, $58 ; env $58
    db $A3, $05 ; mod $05
    db $A0, $0D ; volume $0D
    db $34, $0C ; note E3 dur 12
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $C3, $58 ; env $58
    db $A0, $0D ; volume $0D
    db $34, $08 ; note E3 dur 8
    db $32, $08 ; note D3 dur 8
    db $40, $1C ; note C4 dur 28
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $0A ; volume $0A
    db $40, $04 ; note C4 dur 4
    db $C3, $58 ; env $58
    db $A3, $05 ; mod $05
    db $A0, $0D ; volume $0D
    db $3A, $08 ; note A#3 dur 8
    db $38, $08 ; note G#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $39, $08 ; note A3 dur 8
    db $3B, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $44, $10 ; note E4 dur 16
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $44, $08 ; note E4 dur 8
    db $C3, $58 ; env $58
    db $A3, $05 ; mod $05
    db $A0, $0D ; volume $0D
    db $34, $06 ; note E3 dur 6
    db $C1, $7F ; env $7F
    db $A0, $05 ; volume $05
    db $34, $02 ; note E3 dur 2
    db $C3, $58 ; env $58
    db $A0, $0D ; volume $0D
    db $34, $08 ; note E3 dur 8
    db $35, $08 ; note F3 dur 8
    db $29, $10 ; note A2 dur 16
    db $30, $10 ; note C3 dur 16
    db $32, $10 ; note D3 dur 16
    db $30, $20 ; note C3 dur 32
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $0A ; volume $0A
    db $30, $10 ; note C3 dur 16
    db $C4, $30 ; env $30
    db $A3, $05 ; mod $05
    db $A2, $02 ; duty2 $02
    db $A0, $0C ; volume $0C
    db $30, $02 ; note C3 dur 2
    db $32, $02 ; note D3 dur 2
    db $34, $02 ; note E3 dur 2
    db $35, $02 ; note F3 dur 2
    db $37, $02 ; note G3 dur 2
    db $39, $02 ; note A3 dur 2
    db $3B, $02 ; note B3 dur 2
    db $40, $02 ; note C4 dur 2
    db $C3, $68 ; env $68
    db $42, $08 ; note D4 dur 8
    db $39, $08 ; note A3 dur 8
    db $35, $08 ; note F3 dur 8
    db $32, $08 ; note D3 dur 8
    db $35, $08 ; note F3 dur 8
    db $38, $08 ; note G#3 dur 8
    db $42, $06 ; note D4 dur 6
    db $A0, $0A ; volume $0A
    db $42, $02 ; note D4 dur 2
    db $A0, $0D ; volume $0D
    db $44, $04 ; note E4 dur 4
    db $45, $04 ; note F4 dur 4
    db $44, $08 ; note E4 dur 8
    db $3B, $08 ; note B3 dur 8
    db $37, $08 ; note G3 dur 8
    db $34, $08 ; note E3 dur 8
    db $37, $08 ; note G3 dur 8
    db $3A, $08 ; note A#3 dur 8
    db $44, $06 ; note E4 dur 6
    db $A0, $0A ; volume $0A
    db $44, $02 ; note E4 dur 2
    db $A0, $0D ; volume $0D
    db $42, $04 ; note D4 dur 4
    db $40, $04 ; note C4 dur 4
    db $42, $08 ; note D4 dur 8
    db $39, $08 ; note A3 dur 8
    db $35, $08 ; note F3 dur 8
    db $32, $08 ; note D3 dur 8
    db $35, $08 ; note F3 dur 8
    db $38, $08 ; note G#3 dur 8
    db $40, $06 ; note C4 dur 6
    db $A0, $0A ; volume $0A
    db $40, $02 ; note C4 dur 2
    db $A0, $0D ; volume $0D
    db $44, $04 ; note E4 dur 4
    db $45, $04 ; note F4 dur 4
    db $44, $08 ; note E4 dur 8
    db $3B, $08 ; note B3 dur 8
    db $A0, $0C ; volume $0C
    db $37, $08 ; note G3 dur 8
    db $34, $08 ; note E3 dur 8
    db $A0, $0B ; volume $0B
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $37, $02 ; note G3 dur 2
    db $C3, $68 ; env $68
    db $A0, $0D ; volume $0D
    db $3A, $08 ; note A#3 dur 8
    db $39, $08 ; note A3 dur 8
    db $A0, $0D ; volume $0D
    db $37, $08 ; note G3 dur 8
    db $36, $20 ; note F#3 dur 32
    db $C1, $5F ; env $5F
    db $A3, $00 ; mod $00
    db $A0, $09 ; volume $09
    db $36, $08 ; note F#3 dur 8
    db $A0, $0D ; volume $0D
    db $A3, $05 ; mod $05
    db $C3, $58 ; env $58
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $39, $08 ; note A3 dur 8
    db $C3, $02 ; env $02
    db $A0, $09 ; volume $09
    db $3B, $03 ; note B3 dur 3
    db $A0, $04 ; volume $04
    db $3B, $01 ; note B3 dur 1
    db $A0, $09 ; volume $09
    db $3B, $03 ; note B3 dur 3
    db $A0, $04 ; volume $04
    db $3B, $01 ; note B3 dur 1
    db $A0, $09 ; volume $09
    db $3A, $03 ; note A#3 dur 3
    db $A0, $04 ; volume $04
    db $3A, $01 ; note A#3 dur 1
    db $A0, $09 ; volume $09
    db $3B, $03 ; note B3 dur 3
    db $A0, $04 ; volume $04
    db $3B, $01 ; note B3 dur 1
    db $A0, $09 ; volume $09
    db $40, $03 ; note C4 dur 3
    db $A0, $04 ; volume $04
    db $40, $01 ; note C4 dur 1
    db $A0, $09 ; volume $09
    db $40, $03 ; note C4 dur 3
    db $A0, $04 ; volume $04
    db $40, $01 ; note C4 dur 1
    db $A0, $09 ; volume $09
    db $3B, $03 ; note B3 dur 3
    db $A0, $04 ; volume $04
    db $3B, $01 ; note B3 dur 1
    db $A0, $09 ; volume $09
    db $40, $03 ; note C4 dur 3
    db $A0, $04 ; volume $04
    db $40, $01 ; note C4 dur 1
    db $A0, $09 ; volume $09
    db $42, $03 ; note D4 dur 3
    db $A0, $04 ; volume $04
    db $42, $01 ; note D4 dur 1
    db $A0, $09 ; volume $09
    db $42, $03 ; note D4 dur 3
    db $A0, $04 ; volume $04
    db $42, $01 ; note D4 dur 1
    db $A0, $09 ; volume $09
    db $41, $03 ; note C#4 dur 3
    db $A0, $04 ; volume $04
    db $41, $01 ; note C#4 dur 1
    db $A0, $09 ; volume $09
    db $42, $03 ; note D4 dur 3
    db $A0, $04 ; volume $04
    db $42, $01 ; note D4 dur 1
    db $A0, $09 ; volume $09
    db $44, $03 ; note E4 dur 3
    db $A0, $04 ; volume $04
    db $44, $01 ; note E4 dur 1
    db $A0, $09 ; volume $09
    db $44, $03 ; note E4 dur 3
    db $A0, $04 ; volume $04
    db $44, $01 ; note E4 dur 1
    db $A0, $09 ; volume $09
    db $43, $03 ; note D#4 dur 3
    db $A0, $04 ; volume $04
    db $43, $01 ; note D#4 dur 1
    db $A0, $09 ; volume $09
    db $44, $03 ; note E4 dur 3
    db $A0, $04 ; volume $04
    db $44, $01 ; note E4 dur 1
    db $C3, $58 ; env $58
    db $A0, $0D ; volume $0D
    db $45, $03 ; note F4 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $45, $04 ; note F4 dur 4
    db $A0, $0D ; volume $0D
    db $44, $03 ; note E4 dur 3
    db $45, $03 ; note F4 dur 3
    db $44, $02 ; note E4 dur 2
    db $42, $03 ; note D4 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $42, $04 ; note D4 dur 4
    db $A0, $0D ; volume $0D
    db $40, $03 ; note C4 dur 3
    db $42, $03 ; note D4 dur 3
    db $40, $02 ; note C4 dur 2
    db $3B, $03 ; note B3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $3B, $04 ; note B3 dur 4
    db $A0, $0D ; volume $0D
    db $39, $03 ; note A3 dur 3
    db $3B, $03 ; note B3 dur 3
    db $39, $02 ; note A3 dur 2
    db $37, $03 ; note G3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $37, $04 ; note G3 dur 4
    db $A0, $0D ; volume $0D
    db $35, $03 ; note F3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $35, $04 ; note F3 dur 4
    db $A0, $0D ; volume $0D
    db $34, $18 ; note E3 dur 24
    db $35, $04 ; note F3 dur 4
    db $34, $04 ; note E3 dur 4
    db $32, $08 ; note D3 dur 8
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $32, $28 ; note D3 dur 40
    db $A3, $03 ; mod $03
    db $C3, $58 ; env $58
    db $A2, $01 ; duty2 $01
    db $A0, $0F ; volume $0F
    db $30, $04 ; note C3 dur 4
    db $32, $04 ; note D3 dur 4
    db $34, $04 ; note E3 dur 4
    db $35, $04 ; note F3 dur 4
    db $37, $18 ; note G3 dur 24
    db $40, $08 ; note C4 dur 8
    db $42, $10 ; note D4 dur 16
    db $37, $20 ; note G3 dur 32
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $0C ; volume $0C
    db $37, $20 ; note G3 dur 32
    db $A3, $03 ; mod $03
    db $C3, $58 ; env $58
    db $A0, $0F ; volume $0F
    db $29, $04 ; note A2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $30, $04 ; note C3 dur 4
    db $32, $04 ; note D3 dur 4
    db $30, $18 ; note C3 dur 24
    db $35, $08 ; note F3 dur 8
    db $34, $10 ; note E3 dur 16
    db $32, $10 ; note D3 dur 16
    db $31, $18 ; note C#3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $31, $18 ; note C#3 dur 24
    db $A3, $03 ; mod $03
    db $C3, $58 ; env $58
    db $A0, $0F ; volume $0F
    db $25, $10 ; note F2 dur 16
    db $28, $10 ; note G#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $37, $30 ; note G3 dur 48
    db $A0, $0C ; volume $0C
    db $34, $10 ; note E3 dur 16
    db $A0, $0F ; volume $0F
    db $29, $10 ; note A2 dur 16
    db $35, $10 ; note F3 dur 16
    db $29, $10 ; note A2 dur 16
    db $2B, $10 ; note B2 dur 16
    db $30, $06 ; note C3 dur 6
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $30, $02 ; note C3 dur 2
    db $C3, $58 ; env $58
    db $A0, $0D ; volume $0D
    db $40, $08 ; note C4 dur 8
    db $37, $08 ; note G3 dur 8
    db $34, $08 ; note E3 dur 8
    db $30, $08 ; note C3 dur 8
    db $27, $06 ; note G2 dur 6
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $27, $02 ; note G2 dur 2
    db $C4, $38 ; env $38
    db $A2, $01 ; duty2 $01
    db $A0, $0B ; volume $0B
    db $25, $02 ; note F2 dur 2
    db $27, $02 ; note G2 dur 2
    db $29, $02 ; note A2 dur 2
    db $2B, $02 ; note B2 dur 2
    db $A0, $0A ; volume $0A
    db $30, $02 ; note C3 dur 2
    db $32, $02 ; note D3 dur 2
    db $A0, $08 ; volume $08
    db $34, $02 ; note E3 dur 2
    db $35, $02 ; note F3 dur 2
    db $AC, $01 ; call x1
    dw $0652 ; byte offset of the called section from the track start
    db $AC, $01 ; call x1
    dw $0402 ; byte offset of the called section from the track start
    db $23, $40 ; note D#2 dur 64
    db $C3, $68 ; env $68
    db $22, $20 ; note D2 dur 32
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $09 ; volume $09
    db $22, $10 ; note D2 dur 16
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0D ; volume $0D
    db $37, $0C ; note G3 dur 12
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $07 ; volume $07
    db $37, $04 ; note G3 dur 4
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0D ; volume $0D
    db $44, $18 ; note E4 dur 24
    db $42, $04 ; note D4 dur 4
    db $40, $04 ; note C4 dur 4
    db $42, $38 ; note D4 dur 56
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $0A ; volume $0A
    db $42, $18 ; note D4 dur 24
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0D ; volume $0D
    db $37, $0C ; note G3 dur 12
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $07 ; volume $07
    db $37, $04 ; note G3 dur 4
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0D ; volume $0D
    db $44, $18 ; note E4 dur 24
    db $42, $04 ; note D4 dur 4
    db $40, $04 ; note C4 dur 4
    db $42, $40 ; note D4 dur 64
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $08 ; volume $08
    db $42, $10 ; note D4 dur 16
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0D ; volume $0D
    db $44, $10 ; note E4 dur 16
    db $40, $08 ; note C4 dur 8
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $07 ; volume $07
    db $40, $08 ; note C4 dur 8
    db $A2, $02 ; duty2 $02
    db $A3, $05 ; mod $05
    db $C3, $48 ; env $48
    db $A0, $0D ; volume $0D
    db $20, $06 ; note C2 dur 6
    db $A0, $03 ; volume $03
    db $20, $02 ; note C2 dur 2
    db $A0, $0D ; volume $0D
    db $23, $06 ; note D#2 dur 6
    db $A0, $03 ; volume $03
    db $23, $02 ; note D#2 dur 2
    db $A0, $0D ; volume $0D
    db $23, $06 ; note D#2 dur 6
    db $A0, $04 ; volume $04
    db $23, $02 ; note D#2 dur 2
    db $A0, $0D ; volume $0D
    db $28, $06 ; note G#2 dur 6
    db $A0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $A0, $0D ; volume $0D
    db $28, $06 ; note G#2 dur 6
    db $A0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $A0, $0D ; volume $0D
    db $30, $06 ; note C3 dur 6
    db $A0, $04 ; volume $04
    db $30, $02 ; note C3 dur 2
    db $A0, $0D ; volume $0D
    db $29, $06 ; note A2 dur 6
    db $A0, $04 ; volume $04
    db $29, $02 ; note A2 dur 2
    db $A0, $0D ; volume $0D
    db $30, $06 ; note C3 dur 6
    db $A0, $04 ; volume $04
    db $30, $02 ; note C3 dur 2
    db $A0, $0D ; volume $0D
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $0D ; volume $0D
    db $39, $06 ; note A3 dur 6
    db $A0, $04 ; volume $04
    db $39, $02 ; note A3 dur 2
    db $A0, $0D ; volume $0D
    db $40, $06 ; note C4 dur 6
    db $C1, $30 ; env $30
    db $A0, $04 ; volume $04
    db $40, $0A ; note C4 dur 10
    db $C3, $48 ; env $48
    db $A0, $0D ; volume $0D
    db $30, $0C ; note C3 dur 12
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $30, $04 ; note C3 dur 4
    db $C3, $78 ; env $78
    db $A0, $0B ; volume $0B
    db $FD, $F0 ; label 0
    db $37, $02 ; note G3 dur 2
    db $39, $02 ; note A3 dur 2
    db $BF, $F0 ; repeat $F0
    db $AF, $04 ; param $04
    db $FD, $F0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $BF, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $BF, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $BF, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $B5, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $BB, $F0 ; repeat $F0
    db $A7, $02 ; wait $02
    db $C3, $68 ; env $68
    db $37, $10 ; note G3 dur 16
    db $A0, $03 ; volume $03
    db $C1, $70 ; env $70
    db $37, $20 ; note G3 dur 32
    db $FF, $FF ; end
    db $A3, $02 ; mod $02
    db $44, $18 ; note E4 dur 24
    db $42, $04 ; note D4 dur 4
    db $40, $04 ; note C4 dur 4
    db $42, $18 ; note D4 dur 24
    db $40, $04 ; note C4 dur 4
    db $3B, $04 ; note B3 dur 4
    db $40, $18 ; note C4 dur 24
    db $3B, $04 ; note B3 dur 4
    db $39, $04 ; note A3 dur 4
    db $3B, $18 ; note B3 dur 24
    db $A0, $0D ; volume $0D
    db $39, $04 ; note A3 dur 4
    db $A0, $0C ; volume $0C
    db $37, $04 ; note G3 dur 4
    db $34, $08 ; note E3 dur 8
    db $A0, $0D ; volume $0D
    db $35, $08 ; note F3 dur 8
    db $A0, $0D ; volume $0D
    db $37, $08 ; note G3 dur 8
    db $A0, $0D ; volume $0D
    db $39, $07 ; note A3 dur 7
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $39, $01 ; note A3 dur 1
    db $C3, $68 ; env $68
    db $A0, $0D ; volume $0D
    db $39, $18 ; note A3 dur 24
    db $37, $04 ; note G3 dur 4
    db $35, $04 ; note F3 dur 4
    db $A0, $0D ; volume $0D
    db $32, $20 ; note D3 dur 32
    db $A0, $0B ; volume $0B
    db $34, $18 ; note E3 dur 24
    db $A3, $00 ; mod $00
    db $C1, $6F ; env $6F
    db $A0, $06 ; volume $06
    db $34, $08 ; note E3 dur 8
    db $A0, $0D ; volume $0D
    db $A3, $00 ; mod $00
    db $C3, $68 ; env $68
    db $35, $18 ; note F3 dur 24
    db $A3, $03 ; mod $03
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $A3, $00 ; mod $00
    db $32, $18 ; note D3 dur 24
    db $A3, $03 ; mod $03
    db $34, $04 ; note E3 dur 4
    db $35, $04 ; note F3 dur 4
    db $A3, $00 ; mod $00
    db $37, $18 ; note G3 dur 24
    db $A3, $03 ; mod $03
    db $39, $04 ; note A3 dur 4
    db $3B, $04 ; note B3 dur 4
    db $A3, $00 ; mod $00
    db $34, $18 ; note E3 dur 24
    db $A3, $03 ; mod $03
    db $35, $04 ; note F3 dur 4
    db $37, $04 ; note G3 dur 4
    db $A0, $0D ; volume $0D
    db $39, $18 ; note A3 dur 24
    db $C1, $4F ; env $4F
    db $A3, $00 ; mod $00
    db $A0, $09 ; volume $09
    db $39, $08 ; note A3 dur 8
    db $A3, $03 ; mod $03
    db $C3, $68 ; env $68
    db $A0, $0D ; volume $0D
    db $39, $08 ; note A3 dur 8
    db $C1, $70 ; env $70
    db $A0, $04 ; volume $04
    db $39, $03 ; note A3 dur 3
    db $C3, $68 ; env $68
    db $A0, $0D ; volume $0D
    db $40, $08 ; note C4 dur 8
    db $C1, $70 ; env $70
    db $A0, $04 ; volume $04
    db $40, $03 ; note C4 dur 3
    db $C3, $68 ; env $68
    db $A0, $0D ; volume $0D
    db $39, $07 ; note A3 dur 7
    db $C1, $70 ; env $70
    db $A0, $04 ; volume $04
    db $39, $03 ; note A3 dur 3
    db $C3, $68 ; env $68
    db $A0, $0D ; volume $0D
    db $34, $20 ; note E3 dur 32
    db $32, $0C ; note D3 dur 12
    db $C1, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $32, $04 ; note D3 dur 4
    db $C3, $68 ; env $68
    db $A0, $0D ; volume $0D
    db $34, $10 ; note E3 dur 16
    db $A0, $0C ; volume $0C
    db $30, $08 ; note C3 dur 8
    db $A0, $07 ; volume $07
    db $30, $08 ; note C3 dur 8
    db $A0, $0D ; volume $0D
    db $40, $10 ; note C4 dur 16
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $0C ; volume $0C
    db $40, $08 ; note C4 dur 8
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0D ; volume $0D
    db $38, $08 ; note G#3 dur 8
    db $A0, $0D ; volume $0D
    db $3A, $08 ; note A#3 dur 8
    db $40, $08 ; note C4 dur 8
    db $42, $04 ; note D4 dur 4
    db $43, $04 ; note D#4 dur 4
    db $42, $04 ; note D4 dur 4
    db $3A, $04 ; note A#3 dur 4
    db $A0, $0D ; volume $0D
    db $37, $10 ; note G3 dur 16
    db $C1, $6F ; env $6F
    db $A3, $00 ; mod $00
    db $A0, $08 ; volume $08
    db $37, $08 ; note G3 dur 8
    db $C3, $68 ; env $68
    db $A3, $03 ; mod $03
    db $A0, $0D ; volume $0D
    db $33, $08 ; note D#3 dur 8
    db $35, $08 ; note F3 dur 8
    db $37, $07 ; note G3 dur 7
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $37, $01 ; note G3 dur 1
    db $C3, $7F ; env $7F
    db $A0, $0D ; volume $0D
    db $37, $06 ; note G3 dur 6
    db $A0, $0A ; volume $0A
    db $37, $02 ; note G3 dur 2
    db $A0, $0D ; volume $0D
    db $35, $0C ; note F3 dur 12
    db $A0, $0A ; volume $0A
    db $35, $04 ; note F3 dur 4
    db $A0, $0D ; volume $0D
    db $33, $0C ; note D#3 dur 12
    db $A0, $0A ; volume $0A
    db $33, $04 ; note D#3 dur 4
    db $A0, $0D ; volume $0D
    db $32, $0C ; note D3 dur 12
    db $A0, $0A ; volume $0A
    db $32, $04 ; note D3 dur 4
    db $A0, $0D ; volume $0D
    db $30, $06 ; note C3 dur 6
    db $A0, $0A ; volume $0A
    db $30, $02 ; note C3 dur 2
    db $A0, $0D ; volume $0D
    db $33, $06 ; note D#3 dur 6
    db $A0, $0A ; volume $0A
    db $33, $02 ; note D#3 dur 2
    db $A0, $0D ; volume $0D
    db $32, $0C ; note D3 dur 12
    db $A0, $0A ; volume $0A
    db $32, $04 ; note D3 dur 4
    db $A0, $0D ; volume $0D
    db $30, $0C ; note C3 dur 12
    db $A0, $0A ; volume $0A
    db $30, $04 ; note C3 dur 4
    db $A0, $0D ; volume $0D
    db $2A, $0C ; note A#2 dur 12
    db $A0, $0A ; volume $0A
    db $2A, $04 ; note A#2 dur 4
    db $A0, $0D ; volume $0D
    db $28, $06 ; note G#2 dur 6
    db $C1, $50 ; env $50
    db $A0, $08 ; volume $08
    db $28, $0A ; note G#2 dur 10
    db $C3, $48 ; env $48
    db $A3, $25 ; mod $25
    db $A0, $0D ; volume $0D
    db $27, $03 ; note G2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $04 ; note G2 dur 4
    db $A0, $0D ; volume $0D
    db $32, $03 ; note D3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $32, $04 ; note D3 dur 4
    db $A0, $0C ; volume $0C
    db $27, $08 ; note G2 dur 8
    db $C1, $5F ; env $5F
    db $A3, $20 ; mod $20
    db $A0, $06 ; volume $06
    db $27, $08 ; note G2 dur 8
    db $A3, $25 ; mod $25
    db $C3, $48 ; env $48
    db $A0, $0D ; volume $0D
    db $27, $03 ; note G2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $04 ; note G2 dur 4
    db $A0, $0D ; volume $0D
    db $30, $03 ; note C3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $30, $04 ; note C3 dur 4
    db $A0, $0C ; volume $0C
    db $27, $08 ; note G2 dur 8
    db $C1, $5F ; env $5F
    db $A3, $20 ; mod $20
    db $A0, $06 ; volume $06
    db $27, $08 ; note G2 dur 8
    db $C3, $48 ; env $48
    db $A3, $25 ; mod $25
    db $A0, $0D ; volume $0D
    db $25, $03 ; note F2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $25, $04 ; note F2 dur 4
    db $A0, $0D ; volume $0D
    db $28, $03 ; note G#2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $28, $04 ; note G#2 dur 4
    db $A0, $0C ; volume $0C
    db $25, $08 ; note F2 dur 8
    db $C1, $5F ; env $5F
    db $A3, $20 ; mod $20
    db $A0, $06 ; volume $06
    db $25, $08 ; note F2 dur 8
    db $C3, $48 ; env $48
    db $A3, $25 ; mod $25
    db $A0, $0D ; volume $0D
    db $25, $03 ; note F2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $25, $04 ; note F2 dur 4
    db $A0, $0D ; volume $0D
    db $27, $03 ; note G2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $27, $04 ; note G2 dur 4
    db $A0, $0C ; volume $0C
    db $25, $0A ; note F2 dur 10
    db $C1, $7F ; env $7F
    db $A3, $20 ; mod $20
    db $A0, $08 ; volume $08
    db $25, $06 ; note F2 dur 6
    db $C3, $68 ; env $68
    db $A3, $25 ; mod $25
    db $A0, $0D ; volume $0D
    db $23, $08 ; note D#2 dur 8
    db $22, $08 ; note D2 dur 8
    db $23, $08 ; note D#2 dur 8
    db $A0, $0E ; volume $0E
    db $27, $14 ; note G2 dur 20
    db $C1, $6F ; env $6F
    db $A3, $20 ; mod $20
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $C3, $68 ; env $68
    db $A3, $25 ; mod $25
    db $A0, $0E ; volume $0E
    db $27, $10 ; note G2 dur 16
    db $C3, $48 ; env $48
    db $A3, $25 ; mod $25
    db $A0, $0D ; volume $0D
    db $25, $08 ; note F2 dur 8
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $A3, $FE ; mod $FE
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $30, $14 ; note C3 dur 20
    db $C1, $6F ; env $6F
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $30, $04 ; note C3 dur 4
    db $C0, $FE ; env $FE
    db $A3, $25 ; mod $25
    db $A0, $09 ; volume $09
    db $20, $10 ; note C2 dur 16
    db $C1, $5F ; env $5F
    db $A3, $20 ; mod $20
    db $A0, $07 ; volume $07
    db $20, $08 ; note C2 dur 8
    db $C3, $78 ; env $78
    db $A3, $25 ; mod $25
    db $A0, $0F ; volume $0F
    db $20, $10 ; note C2 dur 16
    db $22, $10 ; note D2 dur 16
    db $A0, $0E ; volume $0E
    db $23, $10 ; note D#2 dur 16
    db $A0, $0D ; volume $0D
    db $27, $10 ; note G2 dur 16
    db $25, $10 ; note F2 dur 16
    db $20, $10 ; note C2 dur 16
    db $22, $10 ; note D2 dur 16
    db $AD, $00 ; return $00
    db $A3, $03 ; mod $03
    db $C3, $7F ; env $7F
    db $A0, $08 ; volume $08
    db $FD, $F0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $35, $04 ; note F3 dur 4
    db $37, $04 ; note G3 dur 4
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $34, $04 ; note E3 dur 4
    db $35, $04 ; note F3 dur 4
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $32, $04 ; note D3 dur 4
    db $34, $04 ; note E3 dur 4
    db $B3, $F0 ; repeat $F0
    db $32, $0D ; note D3 dur 13
    db $A3, $00 ; mod $00
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $32, $0B ; note D3 dur 11
    db $A3, $05 ; mod $05
    db $C3, $68 ; env $68
    db $A0, $0D ; volume $0D
    db $37, $08 ; note G3 dur 8
    db $AD, $00 ; return $00

; sound track, 1284 events after the header (E-0019: grammar C2, meaning C0)
Data_042_5441:: ; heuristic: track stream of a sound record; C0
    db $0A, $7F, $02, $05 ; header: param=10 byte1=$7F volume=$02 byte3=$05
    db $AC, $01 ; call x1
    dw $09E0 ; byte offset of the called section from the track start
    db $AC, $01 ; call x1
    dw $0720 ; byte offset of the called section from the track start
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $A1, $0F ; duty $0F
    db $3B, $0C ; note B3 dur 12
    db $A0, $06 ; volume $06
    db $3B, $04 ; note B3 dur 4
    db $A0, $02 ; volume $02
    db $37, $0C ; note G3 dur 12
    db $A0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A0, $02 ; volume $02
    db $2B, $0C ; note B2 dur 12
    db $A0, $06 ; volume $06
    db $2B, $04 ; note B2 dur 4
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $17, $0C ; note G1 dur 12
    db $A0, $06 ; volume $06
    db $17, $04 ; note G1 dur 4
    db $1F, $10 ; rest-note $1F dur 16
    db $AC, $01 ; call x1
    dw $0720 ; byte offset of the called section from the track start
    db $A2, $7F ; duty2 $7F
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $A1, $0F ; duty $0F
    db $3B, $0C ; note B3 dur 12
    db $A0, $06 ; volume $06
    db $3B, $04 ; note B3 dur 4
    db $A0, $02 ; volume $02
    db $37, $0C ; note G3 dur 12
    db $A0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A0, $02 ; volume $02
    db $2B, $0C ; note B2 dur 12
    db $A0, $06 ; volume $06
    db $2B, $04 ; note B2 dur 4
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A2, $1C ; duty2 $1C
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $17, $04 ; note G1 dur 4
    db $A1, $0F ; duty $0F
    db $27, $04 ; note G2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $2B, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $32, $04 ; note D3 dur 4
    db $35, $04 ; note F3 dur 4
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $1F, $0A ; rest-note $1F dur 10
    db $A3, $0B ; mod $0B
    db $A0, $02 ; volume $02
    db $A2, $FF ; duty2 $FF
    db $A1, $07 ; duty $07
    db $27, $0E ; note G2 dur 14
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $A0, $02 ; volume $02
    db $37, $1C ; note G3 dur 28
    db $A3, $00 ; mod $00
    db $A0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $A3, $0B ; mod $0B
    db $A0, $02 ; volume $02
    db $34, $08 ; note E3 dur 8
    db $A0, $04 ; volume $04
    db $34, $03 ; note E3 dur 3
    db $A0, $02 ; volume $02
    db $35, $08 ; note F3 dur 8
    db $A0, $04 ; volume $04
    db $35, $03 ; note F3 dur 3
    db $A0, $02 ; volume $02
    db $37, $07 ; note G3 dur 7
    db $A0, $04 ; volume $04
    db $37, $03 ; note G3 dur 3
    db $A0, $02 ; volume $02
    db $3B, $20 ; note B3 dur 32
    db $A2, $30 ; duty2 $30
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $3B, $10 ; note B3 dur 16
    db $A3, $0B ; mod $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $29, $0E ; note A2 dur 14
    db $A0, $04 ; volume $04
    db $29, $02 ; note A2 dur 2
    db $A0, $02 ; volume $02
    db $39, $1C ; note A3 dur 28
    db $A3, $00 ; mod $00
    db $A0, $04 ; volume $04
    db $39, $04 ; note A3 dur 4
    db $A3, $0B ; mod $0B
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A0, $04 ; volume $04
    db $2B, $03 ; note B2 dur 3
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A0, $04 ; volume $04
    db $30, $03 ; note C3 dur 3
    db $A0, $02 ; volume $02
    db $32, $07 ; note D3 dur 7
    db $A0, $04 ; volume $04
    db $32, $03 ; note D3 dur 3
    db $A0, $02 ; volume $02
    db $37, $20 ; note G3 dur 32
    db $A3, $00 ; mod $00
    db $A2, $40 ; duty2 $40
    db $A0, $04 ; volume $04
    db $37, $10 ; note G3 dur 16
    db $A3, $0B ; mod $0B
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $29, $0F ; note A2 dur 15
    db $A0, $04 ; volume $04
    db $29, $01 ; note A2 dur 1
    db $A0, $02 ; volume $02
    db $34, $0F ; note E3 dur 15
    db $A0, $04 ; volume $04
    db $34, $01 ; note E3 dur 1
    db $A0, $02 ; volume $02
    db $30, $0F ; note C3 dur 15
    db $A0, $04 ; volume $04
    db $30, $01 ; note C3 dur 1
    db $A0, $02 ; volume $02
    db $2B, $0F ; note B2 dur 15
    db $A0, $04 ; volume $04
    db $2B, $01 ; note B2 dur 1
    db $A0, $02 ; volume $02
    db $30, $0F ; note C3 dur 15
    db $A0, $04 ; volume $04
    db $30, $01 ; note C3 dur 1
    db $A0, $02 ; volume $02
    db $31, $08 ; note C#3 dur 8
    db $A0, $04 ; volume $04
    db $31, $03 ; note C#3 dur 3
    db $A0, $02 ; volume $02
    db $3A, $08 ; note A#3 dur 8
    db $A0, $04 ; volume $04
    db $3A, $03 ; note A#3 dur 3
    db $A0, $02 ; volume $02
    db $39, $07 ; note A3 dur 7
    db $A0, $04 ; volume $04
    db $39, $03 ; note A3 dur 3
    db $A0, $02 ; volume $02
    db $37, $16 ; note G3 dur 22
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $02 ; volume $02
    db $35, $07 ; note F3 dur 7
    db $A0, $04 ; volume $04
    db $35, $01 ; note F3 dur 1
    db $A0, $02 ; volume $02
    db $39, $16 ; note A3 dur 22
    db $A0, $04 ; volume $04
    db $39, $02 ; note A3 dur 2
    db $A0, $02 ; volume $02
    db $3B, $07 ; note B3 dur 7
    db $A0, $04 ; volume $04
    db $3B, $01 ; note B3 dur 1
    db $A0, $02 ; volume $02
    db $A1, $0F ; duty $0F
    db $34, $04 ; note E3 dur 4
    db $A0, $06 ; volume $06
    db $34, $04 ; note E3 dur 4
    db $A3, $05 ; mod $05
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $3B, $08 ; note B3 dur 8
    db $39, $08 ; note A3 dur 8
    db $37, $08 ; note G3 dur 8
    db $35, $08 ; note F3 dur 8
    db $34, $08 ; note E3 dur 8
    db $32, $08 ; note D3 dur 8
    db $34, $08 ; note E3 dur 8
    db $FD, $F0 ; label 0
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A2, $20 ; duty2 $20
    db $A1, $02 ; duty $02
    db $35, $04 ; note F3 dur 4
    db $A0, $04 ; volume $04
    db $35, $0C ; note F3 dur 12
    db $A0, $02 ; volume $02
    db $35, $04 ; note F3 dur 4
    db $A0, $04 ; volume $04
    db $35, $04 ; note F3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A2, $20 ; duty2 $20
    db $A1, $02 ; duty $02
    db $35, $04 ; note F3 dur 4
    db $A0, $04 ; volume $04
    db $35, $0C ; note F3 dur 12
    db $A2, $0F ; duty2 $0F
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $35, $04 ; note F3 dur 4
    db $35, $04 ; note F3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $20, $08 ; note C2 dur 8
    db $A2, $20 ; duty2 $20
    db $A1, $02 ; duty $02
    db $34, $04 ; note E3 dur 4
    db $A0, $04 ; volume $04
    db $34, $0C ; note E3 dur 12
    db $A0, $02 ; volume $02
    db $34, $04 ; note E3 dur 4
    db $A0, $04 ; volume $04
    db $34, $04 ; note E3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A2, $20 ; duty2 $20
    db $A1, $02 ; duty $02
    db $34, $04 ; note E3 dur 4
    db $A0, $04 ; volume $04
    db $34, $0C ; note E3 dur 12
    db $A2, $0F ; duty2 $0F
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $34, $04 ; note E3 dur 4
    db $34, $04 ; note E3 dur 4
    db $B1, $F0 ; repeat $F0
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $20, $08 ; note C2 dur 8
    db $A2, $20 ; duty2 $20
    db $A1, $02 ; duty $02
    db $32, $04 ; note D3 dur 4
    db $A0, $04 ; volume $04
    db $32, $0C ; note D3 dur 12
    db $A0, $02 ; volume $02
    db $32, $04 ; note D3 dur 4
    db $A0, $04 ; volume $04
    db $32, $04 ; note D3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A2, $20 ; duty2 $20
    db $A1, $02 ; duty $02
    db $32, $04 ; note D3 dur 4
    db $A0, $04 ; volume $04
    db $32, $0C ; note D3 dur 12
    db $A2, $0F ; duty2 $0F
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $32, $04 ; note D3 dur 4
    db $32, $04 ; note D3 dur 4
    db $A2, $50 ; duty2 $50
    db $A1, $09 ; duty $09
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $17, $04 ; note G1 dur 4
    db $A0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $B7, $F0 ; repeat $F0
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $A0, $04 ; volume $04
    db $17, $10 ; note G1 dur 16
    db $A1, $02 ; duty $02
    db $A0, $06 ; volume $06
    db $4B, $04 ; note B4 dur 4
    db $4B, $04 ; note B4 dur 4
    db $49, $03 ; note A4 dur 3
    db $4B, $03 ; note B4 dur 3
    db $49, $02 ; note A4 dur 2
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $27, $08 ; note G2 dur 8
    db $A2, $28 ; duty2 $28
    db $A0, $04 ; volume $04
    db $27, $10 ; note G2 dur 16
    db $A0, $02 ; volume $02
    db $27, $04 ; note G2 dur 4
    db $A0, $04 ; volume $04
    db $27, $04 ; note G2 dur 4
    db $A0, $02 ; volume $02
    db $17, $04 ; note G1 dur 4
    db $A0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $A0, $02 ; volume $02
    db $17, $04 ; note G1 dur 4
    db $A0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $1F, $04 ; rest-note $1F dur 4
    db $A1, $02 ; duty $02
    db $A0, $06 ; volume $06
    db $27, $08 ; note G2 dur 8
    db $29, $04 ; note A2 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $20, $04 ; note C2 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $47, $04 ; note G4 dur 4
    db $44, $04 ; note E4 dur 4
    db $40, $04 ; note C4 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $20, $04 ; note C2 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $44, $04 ; note E4 dur 4
    db $40, $04 ; note C4 dur 4
    db $44, $04 ; note E4 dur 4
    db $40, $04 ; note C4 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $14, $04 ; note E1 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $42, $04 ; note D4 dur 4
    db $37, $04 ; note G3 dur 4
    db $3B, $04 ; note B3 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $24, $04 ; note E2 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $42, $04 ; note D4 dur 4
    db $37, $04 ; note G3 dur 4
    db $3B, $04 ; note B3 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $19, $04 ; note A1 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $22, $04 ; note D2 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $39, $04 ; note A3 dur 4
    db $35, $04 ; note F3 dur 4
    db $39, $04 ; note A3 dur 4
    db $32, $04 ; note D3 dur 4
    db $39, $04 ; note A3 dur 4
    db $35, $04 ; note F3 dur 4
    db $39, $04 ; note A3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $14, $04 ; note E1 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $3B, $04 ; note B3 dur 4
    db $37, $04 ; note G3 dur 4
    db $3B, $04 ; note B3 dur 4
    db $32, $04 ; note D3 dur 4
    db $3B, $04 ; note B3 dur 4
    db $37, $04 ; note G3 dur 4
    db $3B, $04 ; note B3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $19, $04 ; note A1 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $29, $04 ; note A2 dur 4
    db $37, $04 ; note G3 dur 4
    db $31, $04 ; note C#3 dur 4
    db $37, $04 ; note G3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $15, $04 ; note F1 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $39, $04 ; note A3 dur 4
    db $40, $04 ; note C4 dur 4
    db $39, $04 ; note A3 dur 4
    db $45, $04 ; note F4 dur 4
    db $39, $04 ; note A3 dur 4
    db $40, $04 ; note C4 dur 4
    db $39, $04 ; note A3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $15, $04 ; note F1 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $45, $04 ; note F4 dur 4
    db $48, $04 ; note G#4 dur 4
    db $45, $04 ; note F4 dur 4
    db $48, $04 ; note G#4 dur 4
    db $45, $04 ; note F4 dur 4
    db $35, $04 ; note F3 dur 4
    db $30, $04 ; note C3 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $14, $04 ; note E1 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $42, $04 ; note D4 dur 4
    db $3B, $04 ; note B3 dur 4
    db $42, $04 ; note D4 dur 4
    db $34, $04 ; note E3 dur 4
    db $42, $04 ; note D4 dur 4
    db $37, $04 ; note G3 dur 4
    db $42, $04 ; note D4 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $19, $04 ; note A1 dur 4
    db $A2, $18 ; duty2 $18
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $41, $04 ; note C#4 dur 4
    db $37, $04 ; note G3 dur 4
    db $41, $04 ; note C#4 dur 4
    db $39, $04 ; note A3 dur 4
    db $41, $04 ; note C#4 dur 4
    db $37, $04 ; note G3 dur 4
    db $41, $04 ; note C#4 dur 4
    db $A2, $FF ; duty2 $FF
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $12, $0C ; note D1 dur 12
    db $A0, $04 ; volume $04
    db $12, $04 ; note D1 dur 4
    db $A0, $02 ; volume $02
    db $22, $0C ; note D2 dur 12
    db $A0, $04 ; volume $04
    db $22, $04 ; note D2 dur 4
    db $A0, $02 ; volume $02
    db $17, $0C ; note G1 dur 12
    db $A0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $A0, $04 ; volume $04
    db $27, $04 ; note G2 dur 4
    db $A2, $FF ; duty2 $FF
    db $A0, $02 ; volume $02
    db $20, $20 ; note C2 dur 32
    db $A2, $40 ; duty2 $40
    db $A0, $04 ; volume $04
    db $20, $10 ; note C2 dur 16
    db $A0, $02 ; volume $02
    db $17, $0C ; note G1 dur 12
    db $A0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $AC, $01 ; call x1
    dw $09E0 ; byte offset of the called section from the track start
    db $AC, $01 ; call x1
    dw $0720 ; byte offset of the called section from the track start
    db $A2, $7F ; duty2 $7F
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $A1, $0F ; duty $0F
    db $3B, $0C ; note B3 dur 12
    db $A0, $06 ; volume $06
    db $3B, $04 ; note B3 dur 4
    db $A0, $02 ; volume $02
    db $37, $0C ; note G3 dur 12
    db $A0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $27, $0C ; note G2 dur 12
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A2, $FF ; duty2 $FF
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $2B, $10 ; note B2 dur 16
    db $A2, $7F ; duty2 $7F
    db $27, $0C ; note G2 dur 12
    db $A0, $04 ; volume $04
    db $27, $04 ; note G2 dur 4
    db $A0, $02 ; volume $02
    db $17, $02 ; note G1 dur 2
    db $A0, $04 ; volume $04
    db $17, $02 ; note G1 dur 2
    db $A0, $02 ; volume $02
    db $27, $02 ; note G2 dur 2
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $A0, $02 ; volume $02
    db $27, $02 ; note G2 dur 2
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $FD, $F0 ; label 0
    db $A2, $FF ; duty2 $FF
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $A2, $7F ; duty2 $7F
    db $A1, $03 ; duty $03
    db $25, $02 ; note F2 dur 2
    db $A0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $A0, $02 ; volume $02
    db $25, $02 ; note F2 dur 2
    db $A0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $02 ; volume $02
    db $3A, $02 ; note A#3 dur 2
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $02 ; volume $02
    db $3A, $02 ; note A#3 dur 2
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $A0, $02 ; volume $02
    db $45, $02 ; note F4 dur 2
    db $A0, $04 ; volume $04
    db $45, $02 ; note F4 dur 2
    db $A0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $A0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $A0, $02 ; volume $02
    db $3A, $02 ; note A#3 dur 2
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A2, $FF ; duty2 $FF
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A2, $7F ; duty2 $7F
    db $A1, $03 ; duty $03
    db $2B, $02 ; note B2 dur 2
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $02 ; volume $02
    db $3A, $02 ; note A#3 dur 2
    db $A0, $04 ; volume $04
    db $3A, $02 ; note A#3 dur 2
    db $A0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $02 ; volume $02
    db $2A, $02 ; note A#2 dur 2
    db $A0, $04 ; volume $04
    db $2A, $02 ; note A#2 dur 2
    db $A0, $02 ; volume $02
    db $37, $02 ; note G3 dur 2
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $A0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A0, $02 ; volume $02
    db $2B, $02 ; note B2 dur 2
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $A0, $02 ; volume $02
    db $27, $02 ; note G2 dur 2
    db $A0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $B1, $F0 ; repeat $F0
    db $A2, $FF ; duty2 $FF
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $18, $0C ; note G#1 dur 12
    db $A0, $04 ; volume $04
    db $18, $04 ; note G#1 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $23, $06 ; note D#2 dur 6
    db $A0, $04 ; volume $04
    db $23, $02 ; note D#2 dur 2
    db $A0, $02 ; volume $02
    db $28, $06 ; note G#2 dur 6
    db $A0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $A0, $02 ; volume $02
    db $28, $06 ; note G#2 dur 6
    db $A0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $A0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $A0, $04 ; volume $04
    db $30, $02 ; note C3 dur 2
    db $A0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $A0, $04 ; volume $04
    db $30, $02 ; note C3 dur 2
    db $A0, $02 ; volume $02
    db $33, $06 ; note D#3 dur 6
    db $A0, $04 ; volume $04
    db $33, $02 ; note D#3 dur 2
    db $A0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $A0, $04 ; volume $04
    db $30, $02 ; note C3 dur 2
    db $A0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A0, $02 ; volume $02
    db $39, $06 ; note A3 dur 6
    db $A0, $04 ; volume $04
    db $39, $02 ; note A3 dur 2
    db $A0, $02 ; volume $02
    db $40, $06 ; note C4 dur 6
    db $A0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $A0, $02 ; volume $02
    db $45, $06 ; note F4 dur 6
    db $A0, $04 ; volume $04
    db $45, $04 ; note F4 dur 4
    db $A0, $06 ; volume $06
    db $45, $04 ; note F4 dur 4
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $02 ; volume $02
    db $28, $0C ; note G#2 dur 12
    db $A0, $04 ; volume $04
    db $28, $04 ; note G#2 dur 4
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A1, $03 ; duty $03
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $40, $04 ; note C4 dur 4
    db $A0, $04 ; volume $04
    db $40, $04 ; note C4 dur 4
    db $B2, $F0 ; repeat $F0
    db $A0, $02 ; volume $02
    db $3A, $04 ; note A#3 dur 4
    db $A0, $04 ; volume $04
    db $3A, $04 ; note A#3 dur 4
    db $A0, $02 ; volume $02
    db $32, $04 ; note D3 dur 4
    db $A0, $04 ; volume $04
    db $32, $04 ; note D3 dur 4
    db $A0, $02 ; volume $02
    db $25, $04 ; note F2 dur 4
    db $A0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $A0, $02 ; volume $02
    db $1A, $04 ; note A#1 dur 4
    db $A0, $04 ; volume $04
    db $1A, $04 ; note A#1 dur 4
    db $AF, $04 ; param $04
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $18, $10 ; note G#1 dur 16
    db $A1, $03 ; duty $03
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $38, $08 ; note G#3 dur 8
    db $A0, $04 ; volume $04
    db $38, $08 ; note G#3 dur 8
    db $B2, $F0 ; repeat $F0
    db $A0, $02 ; volume $02
    db $35, $08 ; note F3 dur 8
    db $A0, $04 ; volume $04
    db $35, $09 ; note F3 dur 9
    db $A0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $A0, $04 ; volume $04
    db $30, $09 ; note C3 dur 9
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $04 ; volume $04
    db $29, $09 ; note A2 dur 9
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $15, $08 ; note F1 dur 8
    db $A0, $04 ; volume $04
    db $15, $0A ; note F1 dur 10
    db $A0, $02 ; volume $02
    db $23, $12 ; note D#2 dur 18
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $37, $08 ; note G3 dur 8
    db $A0, $04 ; volume $04
    db $37, $0A ; note G3 dur 10
    db $A0, $02 ; volume $02
    db $37, $08 ; note G3 dur 8
    db $A0, $04 ; volume $04
    db $37, $0A ; note G3 dur 10
    db $A0, $02 ; volume $02
    db $37, $08 ; note G3 dur 8
    db $A0, $04 ; volume $04
    db $37, $0A ; note G3 dur 10
    db $A0, $02 ; volume $02
    db $37, $08 ; note G3 dur 8
    db $A0, $04 ; volume $04
    db $37, $0A ; note G3 dur 10
    db $A0, $02 ; volume $02
    db $31, $08 ; note C#3 dur 8
    db $A0, $04 ; volume $04
    db $31, $0B ; note C#3 dur 11
    db $A0, $02 ; volume $02
    db $2B, $08 ; note B2 dur 8
    db $A0, $04 ; volume $04
    db $2B, $0B ; note B2 dur 11
    db $A1, $0A ; duty $0A
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $0B ; note G1 dur 11
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A0, $04 ; volume $04
    db $20, $0B ; note C2 dur 11
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $0B ; note G1 dur 11
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A0, $04 ; volume $04
    db $20, $0B ; note C2 dur 11
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $0B ; note G1 dur 11
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A0, $04 ; volume $04
    db $20, $0B ; note C2 dur 11
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $0B ; note G1 dur 11
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A0, $04 ; volume $04
    db $20, $0B ; note C2 dur 11
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $0B ; note G1 dur 11
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A0, $04 ; volume $04
    db $20, $0D ; note C2 dur 13
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $0F ; note G1 dur 15
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A0, $04 ; volume $04
    db $20, $11 ; note C2 dur 17
    db $A0, $02 ; volume $02
    db $17, $0A ; note G1 dur 10
    db $A0, $04 ; volume $04
    db $17, $13 ; note G1 dur 19
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A0, $04 ; volume $04
    db $20, $34 ; note C2 dur 52
    db $FF, $FF ; end
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $22, $08 ; note D2 dur 8
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $A0, $06 ; volume $06
    db $29, $02 ; note A2 dur 2
    db $A0, $04 ; volume $04
    db $35, $0C ; note F3 dur 12
    db $A0, $06 ; volume $06
    db $35, $04 ; note F3 dur 4
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $24, $08 ; note E2 dur 8
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $2B, $06 ; note B2 dur 6
    db $A0, $06 ; volume $06
    db $2B, $02 ; note B2 dur 2
    db $A0, $04 ; volume $04
    db $37, $0C ; note G3 dur 12
    db $A0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $25, $08 ; note F2 dur 8
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $A0, $06 ; volume $06
    db $30, $02 ; note C3 dur 2
    db $A0, $04 ; volume $04
    db $39, $0C ; note A3 dur 12
    db $A0, $06 ; volume $06
    db $39, $04 ; note A3 dur 4
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $24, $08 ; note E2 dur 8
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $2B, $06 ; note B2 dur 6
    db $A0, $06 ; volume $06
    db $2B, $02 ; note B2 dur 2
    db $A0, $04 ; volume $04
    db $37, $0C ; note G3 dur 12
    db $A0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $19, $08 ; note A1 dur 8
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $24, $06 ; note E2 dur 6
    db $A0, $06 ; volume $06
    db $24, $02 ; note E2 dur 2
    db $A0, $04 ; volume $04
    db $31, $0C ; note C#3 dur 12
    db $A0, $06 ; volume $06
    db $31, $04 ; note C#3 dur 4
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $A1, $09 ; duty $09
    db $A0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $A0, $06 ; volume $06
    db $29, $02 ; note A2 dur 2
    db $A0, $04 ; volume $04
    db $35, $0C ; note F3 dur 12
    db $A0, $06 ; volume $06
    db $35, $04 ; note F3 dur 4
    db $A1, $02 ; duty $02
    db $A2, $4F ; duty2 $4F
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $A1, $09 ; duty $09
    db $A2, $7F ; duty2 $7F
    db $35, $08 ; note F3 dur 8
    db $37, $08 ; note G3 dur 8
    db $35, $08 ; note F3 dur 8
    db $37, $08 ; note G3 dur 8
    db $35, $08 ; note F3 dur 8
    db $37, $08 ; note G3 dur 8
    db $35, $08 ; note F3 dur 8
    db $A0, $02 ; volume $02
    db $A1, $02 ; duty $02
    db $A2, $7F ; duty2 $7F
    db $22, $08 ; note D2 dur 8
    db $A1, $0F ; duty $0F
    db $A2, $30 ; duty2 $30
    db $29, $03 ; note A2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $29, $04 ; note A2 dur 4
    db $A0, $02 ; volume $02
    db $35, $03 ; note F3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $04 ; note F3 dur 4
    db $A0, $02 ; volume $02
    db $29, $03 ; note A2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $29, $04 ; note A2 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A2, $30 ; duty2 $30
    db $A1, $0F ; duty $0F
    db $25, $03 ; note F2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $25, $04 ; note F2 dur 4
    db $A0, $02 ; volume $02
    db $2B, $03 ; note B2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $2B, $04 ; note B2 dur 4
    db $A0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $25, $04 ; note F2 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $A2, $30 ; duty2 $30
    db $A1, $0F ; duty $0F
    db $27, $03 ; note G2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A0, $02 ; volume $02
    db $34, $03 ; note E3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $34, $04 ; note E3 dur 4
    db $A0, $02 ; volume $02
    db $27, $03 ; note G2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $19, $08 ; note A1 dur 8
    db $A2, $30 ; duty2 $30
    db $A1, $0F ; duty $0F
    db $27, $03 ; note G2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A0, $02 ; volume $02
    db $31, $03 ; note C#3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $31, $04 ; note C#3 dur 4
    db $A0, $02 ; volume $02
    db $27, $03 ; note G2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A2, $7F ; duty2 $7F
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $A2, $30 ; duty2 $30
    db $A1, $0F ; duty $0F
    db $29, $03 ; note A2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $29, $04 ; note A2 dur 4
    db $A0, $02 ; volume $02
    db $35, $03 ; note F3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $35, $04 ; note F3 dur 4
    db $A0, $02 ; volume $02
    db $29, $03 ; note A2 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $06 ; volume $06
    db $29, $04 ; note A2 dur 4
    db $A2, $FF ; duty2 $FF
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $17, $1C ; note G1 dur 28
    db $A0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $28, $08 ; note G#2 dur 8
    db $A1, $02 ; duty $02
    db $35, $10 ; note F3 dur 16
    db $27, $08 ; note G2 dur 8
    db $A0, $06 ; volume $06
    db $27, $08 ; note G2 dur 8
    db $A1, $09 ; duty $09
    db $A0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $A2, $3F ; duty2 $3F
    db $A1, $0A ; duty $0A
    db $15, $08 ; note F1 dur 8
    db $A2, $30 ; duty2 $30
    db $A1, $0B ; duty $0B
    db $25, $08 ; note F2 dur 8
    db $28, $08 ; note G#2 dur 8
    db $A1, $0A ; duty $0A
    db $A2, $3F ; duty2 $3F
    db $15, $08 ; note F1 dur 8
    db $1A, $08 ; note A#1 dur 8
    db $A1, $0B ; duty $0B
    db $A2, $30 ; duty2 $30
    db $2A, $08 ; note A#2 dur 8
    db $32, $08 ; note D3 dur 8
    db $A2, $3F ; duty2 $3F
    db $A1, $0A ; duty $0A
    db $1A, $08 ; note A#1 dur 8
    db $13, $08 ; note D#1 dur 8
    db $A1, $0B ; duty $0B
    db $A2, $30 ; duty2 $30
    db $23, $08 ; note D#2 dur 8
    db $32, $08 ; note D3 dur 8
    db $A1, $0A ; duty $0A
    db $A2, $3F ; duty2 $3F
    db $13, $08 ; note D#1 dur 8
    db $18, $08 ; note G#1 dur 8
    db $A1, $0B ; duty $0B
    db $A2, $30 ; duty2 $30
    db $28, $08 ; note G#2 dur 8
    db $30, $08 ; note C3 dur 8
    db $A1, $0A ; duty $0A
    db $A2, $3F ; duty2 $3F
    db $18, $08 ; note G#1 dur 8
    db $12, $08 ; note D1 dur 8
    db $A1, $0B ; duty $0B
    db $A2, $30 ; duty2 $30
    db $22, $08 ; note D2 dur 8
    db $28, $08 ; note G#2 dur 8
    db $A2, $3F ; duty2 $3F
    db $A1, $0A ; duty $0A
    db $12, $08 ; note D1 dur 8
    db $13, $08 ; note D#1 dur 8
    db $A1, $0B ; duty $0B
    db $A2, $30 ; duty2 $30
    db $29, $08 ; note A2 dur 8
    db $30, $08 ; note C3 dur 8
    db $A2, $3F ; duty2 $3F
    db $26, $08 ; note F#2 dur 8
    db $A1, $0A ; duty $0A
    db $15, $08 ; note F1 dur 8
    db $A2, $30 ; duty2 $30
    db $A1, $08 ; duty $08
    db $25, $08 ; note F2 dur 8
    db $30, $08 ; note C3 dur 8
    db $A2, $3F ; duty2 $3F
    db $A1, $0A ; duty $0A
    db $15, $08 ; note F1 dur 8
    db $1A, $08 ; note A#1 dur 8
    db $A1, $0B ; duty $0B
    db $A2, $30 ; duty2 $30
    db $32, $08 ; note D3 dur 8
    db $25, $08 ; note F2 dur 8
    db $A2, $3F ; duty2 $3F
    db $A1, $0A ; duty $0A
    db $1A, $08 ; note A#1 dur 8
    db $A2, $5F ; duty2 $5F
    db $A1, $0B ; duty $0B
    db $13, $08 ; note D#1 dur 8
    db $A1, $0F ; duty $0F
    db $A2, $20 ; duty2 $20
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $2A, $03 ; note A#2 dur 3
    db $A0, $04 ; volume $04
    db $2A, $05 ; note A#2 dur 5
    db $B2, $F0 ; repeat $F0
    db $A1, $0B ; duty $0B
    db $A2, $5F ; duty2 $5F
    db $A0, $02 ; volume $02
    db $18, $08 ; note G#1 dur 8
    db $A2, $20 ; duty2 $20
    db $A1, $0F ; duty $0F
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $30, $03 ; note C3 dur 3
    db $A0, $04 ; volume $04
    db $30, $05 ; note C3 dur 5
    db $B2, $F0 ; repeat $F0
    db $A1, $0B ; duty $0B
    db $A2, $5F ; duty2 $5F
    db $A0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $A2, $20 ; duty2 $20
    db $A1, $03 ; duty $03
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $28, $03 ; note G#2 dur 3
    db $A0, $04 ; volume $04
    db $28, $05 ; note G#2 dur 5
    db $B2, $F0 ; repeat $F0
    db $A2, $5F ; duty2 $5F
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A1, $03 ; duty $03
    db $A2, $20 ; duty2 $20
    db $FD, $F0 ; label 0
    db $A0, $02 ; volume $02
    db $27, $03 ; note G2 dur 3
    db $A0, $04 ; volume $04
    db $27, $05 ; note G2 dur 5
    db $B2, $F0 ; repeat $F0
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $10, $10 ; note C1 dur 16
    db $A2, $7F ; duty2 $7F
    db $A1, $08 ; duty $08
    db $20, $10 ; note C2 dur 16
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $1B, $10 ; note B1 dur 16
    db $A2, $7F ; duty2 $7F
    db $A1, $08 ; duty $08
    db $2B, $10 ; note B2 dur 16
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $1A, $10 ; note A#1 dur 16
    db $A2, $7F ; duty2 $7F
    db $A1, $08 ; duty $08
    db $27, $10 ; note G2 dur 16
    db $A2, $FF ; duty2 $FF
    db $A1, $0B ; duty $0B
    db $19, $10 ; note A1 dur 16
    db $A1, $08 ; duty $08
    db $A2, $7F ; duty2 $7F
    db $23, $10 ; note D#2 dur 16
    db $A1, $0B ; duty $0B
    db $A2, $FF ; duty2 $FF
    db $18, $30 ; note G#1 dur 48
    db $A0, $04 ; volume $04
    db $18, $10 ; note G#1 dur 16
    db $A0, $02 ; volume $02
    db $22, $30 ; note D2 dur 48
    db $A0, $04 ; volume $04
    db $22, $10 ; note D2 dur 16
    db $AD, $00 ; return $00
    db $A1, $03 ; duty $03
    db $A0, $04 ; volume $04
    db $FD, $F0 ; label 0
    db $3B, $04 ; note B3 dur 4
    db $40, $04 ; note C4 dur 4
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $39, $04 ; note A3 dur 4
    db $3B, $04 ; note B3 dur 4
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $B7, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $35, $04 ; note F3 dur 4
    db $37, $04 ; note G3 dur 4
    db $B3, $F0 ; repeat $F0
    db $35, $08 ; note F3 dur 8
    db $A0, $06 ; volume $06
    db $35, $08 ; note F3 dur 8
    db $A1, $0F ; duty $0F
    db $A0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $A0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $AD, $00 ; return $00

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_5E57:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 358 events after the header (E-0019: grammar C2, meaning C0)
Data_042_5E5D:: ; heuristic: track stream of a sound record; C0
    db $06, $00, $09, $00 ; header: param=6 byte1=$00 volume=$09 byte3=$00
    db $FD, $F3 ; label 3
    db $A2, $01 ; duty2 $01
    db $C2, $3F ; env $3F
    db $A3, $28 ; mod $28
    db $1F, $06 ; rest-note $1F dur 6
    db $A0, $03 ; volume $03
    db $12, $06 ; note D1 dur 6
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $A0, $03 ; volume $03
    db $25, $12 ; note F2 dur 18
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $A0, $03 ; volume $03
    db $25, $12 ; note F2 dur 18
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $A0, $03 ; volume $03
    db $25, $12 ; note F2 dur 18
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $A0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $0A ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $A0, $03 ; volume $03
    db $25, $12 ; note F2 dur 18
    db $A0, $0C ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $A0, $03 ; volume $03
    db $20, $06 ; note C2 dur 6
    db $A0, $0C ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $A0, $02 ; volume $02
    db $20, $06 ; note C2 dur 6
    db $A0, $0C ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $A0, $03 ; volume $03
    db $20, $12 ; note C2 dur 18
    db $A0, $0A ; volume $0A
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $26, $06 ; note F#2 dur 6
    db $A0, $0A ; volume $0A
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $12 ; note F#2 dur 18
    db $A0, $0C ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $A0, $03 ; volume $03
    db $20, $06 ; note C2 dur 6
    db $A0, $0C ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $A0, $02 ; volume $02
    db $20, $06 ; note C2 dur 6
    db $A0, $0C ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $A0, $03 ; volume $03
    db $20, $12 ; note C2 dur 18
    db $A0, $0A ; volume $0A
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $A0, $0A ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $26, $06 ; note F#2 dur 6
    db $A0, $0A ; volume $0A
    db $26, $06 ; note F#2 dur 6
    db $A0, $03 ; volume $03
    db $26, $12 ; note F#2 dur 18
    db $A0, $0C ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $A0, $03 ; volume $03
    db $22, $06 ; note D2 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $22, $06 ; note D2 dur 6
    db $A0, $0B ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $A0, $03 ; volume $03
    db $22, $12 ; note D2 dur 18
    db $A0, $0A ; volume $0A
    db $22, $06 ; note D2 dur 6
    db $A0, $03 ; volume $03
    db $22, $06 ; note D2 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $22, $06 ; note D2 dur 6
    db $A0, $0A ; volume $0A
    db $22, $06 ; note D2 dur 6
    db $A0, $03 ; volume $03
    db $22, $12 ; note D2 dur 18
    db $A0, $0C ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $A0, $03 ; volume $03
    db $22, $06 ; note D2 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $22, $06 ; note D2 dur 6
    db $A0, $0B ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $A0, $03 ; volume $03
    db $22, $12 ; note D2 dur 18
    db $A0, $0A ; volume $0A
    db $22, $06 ; note D2 dur 6
    db $A0, $03 ; volume $03
    db $22, $06 ; note D2 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $22, $06 ; note D2 dur 6
    db $A0, $0A ; volume $0A
    db $22, $06 ; note D2 dur 6
    db $A0, $03 ; volume $03
    db $22, $12 ; note D2 dur 18
    db $A0, $0A ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $27, $06 ; note G2 dur 6
    db $A0, $0A ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $27, $12 ; note G2 dur 18
    db $A0, $0A ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $A0, $0A ; volume $0A
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $27, $06 ; note G2 dur 6
    db $A0, $0A ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $A0, $03 ; volume $03
    db $27, $12 ; note G2 dur 18
    db $A0, $0A ; volume $0A
    db $21, $06 ; note C#2 dur 6
    db $A0, $03 ; volume $03
    db $21, $06 ; note C#2 dur 6
    db $A0, $0A ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $A0, $02 ; volume $02
    db $21, $06 ; note C#2 dur 6
    db $A0, $0A ; volume $0A
    db $21, $06 ; note C#2 dur 6
    db $A0, $03 ; volume $03
    db $21, $12 ; note C#2 dur 18
    db $A0, $0A ; volume $0A
    db $21, $06 ; note C#2 dur 6
    db $A0, $03 ; volume $03
    db $21, $06 ; note C#2 dur 6
    db $A0, $0A ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $A0, $02 ; volume $02
    db $21, $06 ; note C#2 dur 6
    db $A0, $0A ; volume $0A
    db $21, $06 ; note C#2 dur 6
    db $A0, $03 ; volume $03
    db $21, $12 ; note C#2 dur 18
    db $A2, $02 ; duty2 $02
    db $C1, $70 ; env $70
    db $A0, $09 ; volume $09
    db $29, $18 ; note A2 dur 24
    db $A0, $09 ; volume $09
    db $29, $0C ; note A2 dur 12
    db $A0, $03 ; volume $03
    db $35, $0C ; note F3 dur 12
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $2A, $18 ; note A#2 dur 24
    db $A0, $09 ; volume $09
    db $2A, $0C ; note A#2 dur 12
    db $A0, $03 ; volume $03
    db $37, $0C ; note G3 dur 12
    db $A0, $09 ; volume $09
    db $2A, $18 ; note A#2 dur 24
    db $A0, $09 ; volume $09
    db $2A, $0C ; note A#2 dur 12
    db $A0, $03 ; volume $03
    db $37, $0C ; note G3 dur 12
    db $A0, $09 ; volume $09
    db $29, $18 ; note A2 dur 24
    db $A0, $09 ; volume $09
    db $29, $18 ; note A2 dur 24
    db $A0, $09 ; volume $09
    db $29, $18 ; note A2 dur 24
    db $A0, $09 ; volume $09
    db $29, $0C ; note A2 dur 12
    db $A0, $03 ; volume $03
    db $3A, $0C ; note A#3 dur 12
    db $A0, $09 ; volume $09
    db $2A, $18 ; note A#2 dur 24
    db $A0, $09 ; volume $09
    db $2A, $0C ; note A#2 dur 12
    db $A0, $03 ; volume $03
    db $42, $0C ; note D4 dur 12
    db $A0, $09 ; volume $09
    db $27, $18 ; note G2 dur 24
    db $A0, $09 ; volume $09
    db $27, $0C ; note G2 dur 12
    db $A0, $03 ; volume $03
    db $3A, $0C ; note A#3 dur 12
    db $A2, $02 ; duty2 $02
    db $A0, $09 ; volume $09
    db $29, $18 ; note A2 dur 24
    db $C1, $30 ; env $30
    db $A0, $09 ; volume $09
    db $29, $12 ; note A2 dur 18
    db $C1, $6F ; env $6F
    db $A0, $03 ; volume $03
    db $03, $12 ; note D#0 dur 18
    db $A0, $0A ; volume $0A
    db $27, $1E ; note G2 dur 30
    db $A0, $03 ; volume $03
    db $08, $12 ; note G#0 dur 18
    db $A0, $0A ; volume $0A
    db $30, $1E ; note C3 dur 30
    db $A0, $03 ; volume $03
    db $09, $12 ; note A0 dur 18
    db $A0, $0A ; volume $0A
    db $27, $1E ; note G2 dur 30
    db $A0, $03 ; volume $03
    db $09, $12 ; note A0 dur 18
    db $A0, $0A ; volume $0A
    db $27, $1F ; note G2 dur 31
    db $A0, $03 ; volume $03
    db $12, $06 ; note D1 dur 6
    db $A2, $02 ; duty2 $02
    db $C1, $20 ; env $20
    db $A0, $07 ; volume $07
    db $22, $05 ; note D2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $22, $06 ; note D2 dur 6
    db $A0, $07 ; volume $07
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $08 ; volume $08
    db $28, $05 ; note G#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $28, $06 ; note G#2 dur 6
    db $A0, $08 ; volume $08
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $09 ; volume $09
    db $31, $05 ; note C#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $31, $06 ; note C#3 dur 6
    db $A0, $09 ; volume $09
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $A0, $0A ; volume $0A
    db $38, $05 ; note G#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $38, $06 ; note G#3 dur 6
    db $A0, $0A ; volume $0A
    db $3A, $05 ; note A#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $3A, $06 ; note A#3 dur 6
    db $A0, $09 ; volume $09
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $A0, $09 ; volume $09
    db $33, $05 ; note D#3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $33, $06 ; note D#3 dur 6
    db $A0, $08 ; volume $08
    db $2A, $05 ; note A#2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $C3, $58 ; env $58
    db $A0, $0A ; volume $0A
    db $22, $18 ; note D2 dur 24
    db $21, $12 ; note C#2 dur 18
    db $C1, $40 ; env $40
    db $A0, $03 ; volume $03
    db $21, $1E ; note C#2 dur 30
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $25, $0E ; note F2 dur 14
    db $C1, $60 ; env $60
    db $A0, $07 ; volume $07
    db $25, $22 ; note F2 dur 34
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $25, $0E ; note F2 dur 14
    db $C1, $60 ; env $60
    db $A0, $07 ; volume $07
    db $25, $22 ; note F2 dur 34
    db $C3, $48 ; env $48
    db $A0, $0A ; volume $0A
    db $25, $0E ; note F2 dur 14
    db $C1, $60 ; env $60
    db $A0, $07 ; volume $07
    db $25, $22 ; note F2 dur 34
    db $C3, $48 ; env $48
    db $A0, $09 ; volume $09
    db $25, $0E ; note F2 dur 14
    db $C1, $60 ; env $60
    db $A0, $05 ; volume $05
    db $25, $0A ; note F2 dur 10
    db $A7, $01 ; wait $01
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 266 events after the header (E-0019: grammar C2, meaning C0)
Data_042_612D:: ; heuristic: track stream of a sound record; C0
    db $06, $02, $0D, $00 ; header: param=6 byte1=$02 volume=$0D byte3=$00
    db $FD, $F3 ; label 3
    db $CC, $6F ; env $6F
    db $A3, $FE ; mod $FE
    db $1F, $12 ; rest-note $1F dur 18
    db $A0, $0D ; volume $0D
    db $32, $96 ; note D3 dur 150
    db $A0, $0D ; volume $0D
    db $A3, $0D ; mod $0D
    db $C3, $50 ; env $50
    db $39, $0C ; note A3 dur 12
    db $A0, $0B ; volume $0B
    db $35, $0C ; note F3 dur 12
    db $C1, $50 ; env $50
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $35, $18 ; note F3 dur 24
    db $A3, $0D ; mod $0D
    db $C3, $38 ; env $38
    db $A0, $09 ; volume $09
    db $34, $06 ; note E3 dur 6
    db $C0, $FE ; env $FE
    db $35, $05 ; note F3 dur 5
    db $34, $04 ; note E3 dur 4
    db $32, $04 ; note D3 dur 4
    db $30, $05 ; note C3 dur 5
    db $C3, $68 ; env $68
    db $32, $18 ; note D3 dur 24
    db $C1, $70 ; env $70
    db $A3, $00 ; mod $00
    db $A0, $0A ; volume $0A
    db $32, $19 ; note D3 dur 25
    db $C3, $28 ; env $28
    db $A0, $0D ; volume $0D
    db $A3, $0D ; mod $0D
    db $34, $05 ; note E3 dur 5
    db $C0, $FE ; env $FE
    db $A0, $0B ; volume $0B
    db $35, $05 ; note F3 dur 5
    db $34, $04 ; note E3 dur 4
    db $32, $05 ; note D3 dur 5
    db $30, $04 ; note C3 dur 4
    db $C3, $68 ; env $68
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $32, $3C ; note D3 dur 60
    db $C1, $60 ; env $60
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $32, $20 ; note D3 dur 32
    db $CC, $4D ; env $4D
    db $A3, $FE ; mod $FE
    db $A0, $0D ; volume $0D
    db $39, $94 ; note A3 dur 148
    db $C3, $68 ; env $68
    db $A0, $0D ; volume $0D
    db $A3, $0C ; mod $0C
    db $44, $0C ; note E4 dur 12
    db $A0, $0B ; volume $0B
    db $42, $0C ; note D4 dur 12
    db $C1, $50 ; env $50
    db $A3, $00 ; mod $00
    db $A0, $05 ; volume $05
    db $42, $18 ; note D4 dur 24
    db $A3, $0D ; mod $0D
    db $C3, $38 ; env $38
    db $A0, $0B ; volume $0B
    db $3A, $05 ; note A#3 dur 5
    db $C0, $FE ; env $FE
    db $A0, $0A ; volume $0A
    db $40, $05 ; note C4 dur 5
    db $3A, $05 ; note A#3 dur 5
    db $39, $05 ; note A3 dur 5
    db $37, $04 ; note G3 dur 4
    db $A0, $0C ; volume $0C
    db $C3, $7F ; env $7F
    db $A3, $FE ; mod $FE
    db $39, $24 ; note A3 dur 36
    db $C1, $60 ; env $60
    db $A3, $00 ; mod $00
    db $A0, $06 ; volume $06
    db $39, $0D ; note A3 dur 13
    db $A3, $0D ; mod $0D
    db $C3, $28 ; env $28
    db $A0, $0C ; volume $0C
    db $3A, $05 ; note A#3 dur 5
    db $A0, $0B ; volume $0B
    db $C0, $FE ; env $FE
    db $40, $05 ; note C4 dur 5
    db $3A, $05 ; note A#3 dur 5
    db $39, $04 ; note A3 dur 4
    db $37, $04 ; note G3 dur 4
    db $C3, $7F ; env $7F
    db $A0, $0B ; volume $0B
    db $C0, $FE ; env $FE
    db $A3, $FE ; mod $FE
    db $39, $48 ; note A3 dur 72
    db $C1, $50 ; env $50
    db $A0, $06 ; volume $06
    db $39, $0C ; note A3 dur 12
    db $C3, $68 ; env $68
    db $A3, $2D ; mod $2D
    db $A0, $0D ; volume $0D
    db $37, $0A ; note G3 dur 10
    db $A0, $03 ; volume $03
    db $37, $02 ; note G3 dur 2
    db $C3, $58 ; env $58
    db $A0, $0D ; volume $0D
    db $37, $0C ; note G3 dur 12
    db $A0, $0C ; volume $0C
    db $35, $0C ; note F3 dur 12
    db $A0, $0D ; volume $0D
    db $34, $0C ; note E3 dur 12
    db $A0, $0C ; volume $0C
    db $35, $0C ; note F3 dur 12
    db $A0, $0B ; volume $0B
    db $39, $0C ; note A3 dur 12
    db $37, $0C ; note G3 dur 12
    db $A0, $0D ; volume $0D
    db $34, $0C ; note E3 dur 12
    db $A0, $0C ; volume $0C
    db $35, $0C ; note F3 dur 12
    db $A0, $0B ; volume $0B
    db $39, $0C ; note A3 dur 12
    db $37, $0C ; note G3 dur 12
    db $A0, $0D ; volume $0D
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $32, $0C ; note D3 dur 12
    db $A0, $0B ; volume $0B
    db $34, $0C ; note E3 dur 12
    db $C1, $40 ; env $40
    db $A3, $20 ; mod $20
    db $A0, $04 ; volume $04
    db $34, $0C ; note E3 dur 12
    db $C3, $48 ; env $48
    db $A3, $2D ; mod $2D
    db $A0, $0D ; volume $0D
    db $40, $0A ; note C4 dur 10
    db $A0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $C3, $58 ; env $58
    db $A0, $0D ; volume $0D
    db $40, $0C ; note C4 dur 12
    db $A0, $0C ; volume $0C
    db $3A, $0C ; note A#3 dur 12
    db $A0, $0E ; volume $0E
    db $42, $0C ; note D4 dur 12
    db $44, $0C ; note E4 dur 12
    db $40, $0C ; note C4 dur 12
    db $42, $0C ; note D4 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $40, $0C ; note C4 dur 12
    db $39, $0C ; note A3 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $37, $0C ; note G3 dur 12
    db $39, $0C ; note A3 dur 12
    db $34, $0C ; note E3 dur 12
    db $35, $0C ; note F3 dur 12
    db $C3, $7F ; env $7F
    db $A3, $0B ; mod $0B
    db $37, $88 ; note G3 dur 136
    db $C1, $7F ; env $7F
    db $A3, $00 ; mod $00
    db $A0, $0A ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $C0, $FE ; env $FE
    db $A3, $0A ; mod $0A
    db $A0, $0A ; volume $0A
    db $39, $24 ; note A3 dur 36
    db $A3, $00 ; mod $00
    db $C1, $7F ; env $7F
    db $A0, $07 ; volume $07
    db $39, $19 ; note A3 dur 25
    db $A3, $25 ; mod $25
    db $C1, $20 ; env $20
    db $A0, $08 ; volume $08
    db $25, $05 ; note F2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $A0, $08 ; volume $08
    db $29, $05 ; note A2 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $A0, $09 ; volume $09
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $A0, $09 ; volume $09
    db $32, $05 ; note D3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A0, $0A ; volume $0A
    db $35, $05 ; note F3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $A0, $0A ; volume $0A
    db $39, $05 ; note A3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $39, $06 ; note A3 dur 6
    db $A0, $0B ; volume $0B
    db $40, $05 ; note C4 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $40, $06 ; note C4 dur 6
    db $A0, $0B ; volume $0B
    db $42, $05 ; note D4 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $42, $06 ; note D4 dur 6
    db $A0, $0A ; volume $0A
    db $39, $05 ; note A3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $39, $06 ; note A3 dur 6
    db $A0, $0A ; volume $0A
    db $37, $05 ; note G3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $37, $06 ; note G3 dur 6
    db $A0, $09 ; volume $09
    db $32, $05 ; note D3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A3, $2F ; mod $2F
    db $C0, $FE ; env $FE
    db $A0, $06 ; volume $06
    db $29, $30 ; note A2 dur 48
    db $C1, $4F ; env $4F
    db $A3, $20 ; mod $20
    db $A0, $04 ; volume $04
    db $29, $18 ; note A2 dur 24
    db $C3, $48 ; env $48
    db $A3, $28 ; mod $28
    db $A0, $0C ; volume $0C
    db $32, $0C ; note D3 dur 12
    db $C1, $5F ; env $5F
    db $A0, $07 ; volume $07
    db $32, $24 ; note D3 dur 36
    db $C3, $48 ; env $48
    db $A0, $0C ; volume $0C
    db $31, $0C ; note C#3 dur 12
    db $C1, $5F ; env $5F
    db $A0, $07 ; volume $07
    db $31, $24 ; note C#3 dur 36
    db $C3, $48 ; env $48
    db $A0, $0B ; volume $0B
    db $30, $0C ; note C3 dur 12
    db $C1, $5F ; env $5F
    db $A0, $07 ; volume $07
    db $30, $24 ; note C3 dur 36
    db $C3, $68 ; env $68
    db $A0, $0A ; volume $0A
    db $31, $0C ; note C#3 dur 12
    db $C1, $5F ; env $5F
    db $A0, $05 ; volume $05
    db $31, $0C ; note C#3 dur 12
    db $A7, $01 ; wait $01
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 471 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6345:: ; heuristic: track stream of a sound record; C0
    db $06, $18, $02, $04 ; header: param=6 byte1=$18 volume=$02 byte3=$04
    db $FD, $F3 ; label 3
    db $A3, $25 ; mod $25
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $22, $0C ; note D2 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $20, $0C ; note C2 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $1B, $0C ; note B1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $A0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $19, $0C ; note A1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $24, $06 ; note E2 dur 6
    db $A0, $06 ; volume $06
    db $24, $06 ; note E2 dur 6
    db $A0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $A0, $06 ; volume $06
    db $24, $06 ; note E2 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $22, $0C ; note D2 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $29, $06 ; note A2 dur 6
    db $A0, $06 ; volume $06
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $A0, $06 ; volume $06
    db $29, $06 ; note A2 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $19, $0C ; note A1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $24, $06 ; note E2 dur 6
    db $A0, $06 ; volume $06
    db $24, $06 ; note E2 dur 6
    db $A0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $A0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $A0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $A0, $06 ; volume $06
    db $24, $06 ; note E2 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $22, $0C ; note D2 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $29, $06 ; note A2 dur 6
    db $A0, $06 ; volume $06
    db $29, $06 ; note A2 dur 6
    db $A0, $02 ; volume $02
    db $36, $06 ; note F#3 dur 6
    db $A0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $A0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $A0, $06 ; volume $06
    db $29, $06 ; note A2 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $17, $0C ; note G1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $2A, $06 ; note A#2 dur 6
    db $A0, $06 ; volume $06
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $06 ; volume $06
    db $2A, $06 ; note A#2 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $16, $0C ; note F#1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $2A, $06 ; note A#2 dur 6
    db $A0, $06 ; volume $06
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $06 ; volume $06
    db $2A, $06 ; note A#2 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $15, $0C ; note F1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $2A, $06 ; note A#2 dur 6
    db $A0, $06 ; volume $06
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $06 ; volume $06
    db $2A, $06 ; note A#2 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $14, $0C ; note E1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $2A, $06 ; note A#2 dur 6
    db $A0, $06 ; volume $06
    db $2A, $06 ; note A#2 dur 6
    db $A0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $A0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $A0, $02 ; volume $02
    db $2A, $06 ; note A#2 dur 6
    db $A0, $06 ; volume $06
    db $2A, $06 ; note A#2 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $23, $0C ; note D#2 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $31, $06 ; note C#3 dur 6
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $A0, $02 ; volume $02
    db $31, $06 ; note C#3 dur 6
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $23, $0C ; note D#2 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $31, $06 ; note C#3 dur 6
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $37, $06 ; note G3 dur 6
    db $A0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $A0, $02 ; volume $02
    db $31, $06 ; note C#3 dur 6
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $19, $0C ; note A1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $27, $06 ; note G2 dur 6
    db $A0, $06 ; volume $06
    db $27, $06 ; note G2 dur 6
    db $A0, $02 ; volume $02
    db $31, $06 ; note C#3 dur 6
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $27, $06 ; note G2 dur 6
    db $A0, $06 ; volume $06
    db $27, $06 ; note G2 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $19, $0C ; note A1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $18 ; duty2 $18
    db $27, $06 ; note G2 dur 6
    db $A0, $06 ; volume $06
    db $27, $06 ; note G2 dur 6
    db $A0, $02 ; volume $02
    db $31, $06 ; note C#3 dur 6
    db $A0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $A0, $02 ; volume $02
    db $27, $06 ; note G2 dur 6
    db $A0, $06 ; volume $06
    db $27, $06 ; note G2 dur 6
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $22, $0C ; note D2 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $FF ; duty2 $FF
    db $35, $0C ; note F3 dur 12
    db $A0, $04 ; volume $04
    db $35, $0C ; note F3 dur 12
    db $A0, $02 ; volume $02
    db $35, $0A ; note F3 dur 10
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $17, $0C ; note G1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $FF ; duty2 $FF
    db $32, $0C ; note D3 dur 12
    db $A0, $04 ; volume $04
    db $32, $0C ; note D3 dur 12
    db $A0, $02 ; volume $02
    db $35, $0A ; note F3 dur 10
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $20, $0C ; note C2 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $FF ; duty2 $FF
    db $34, $0C ; note E3 dur 12
    db $A0, $04 ; volume $04
    db $34, $0C ; note E3 dur 12
    db $A0, $02 ; volume $02
    db $34, $0A ; note E3 dur 10
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $15, $0C ; note F1 dur 12
    db $A1, $02 ; duty $02
    db $A2, $FF ; duty2 $FF
    db $34, $0C ; note E3 dur 12
    db $A0, $04 ; volume $04
    db $34, $0C ; note E3 dur 12
    db $A0, $02 ; volume $02
    db $34, $0A ; note E3 dur 10
    db $A0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $1A, $0C ; note A#1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $FF ; duty2 $FF
    db $32, $0C ; note D3 dur 12
    db $A0, $04 ; volume $04
    db $32, $0C ; note D3 dur 12
    db $A0, $02 ; volume $02
    db $32, $0A ; note D3 dur 10
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $14, $0C ; note E1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $FF ; duty2 $FF
    db $32, $0C ; note D3 dur 12
    db $A0, $04 ; volume $04
    db $32, $0C ; note D3 dur 12
    db $A0, $02 ; volume $02
    db $32, $0A ; note D3 dur 10
    db $A0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $19, $0C ; note A1 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $FF ; duty2 $FF
    db $31, $0C ; note C#3 dur 12
    db $A0, $04 ; volume $04
    db $31, $0C ; note C#3 dur 12
    db $A0, $02 ; volume $02
    db $31, $0A ; note C#3 dur 10
    db $A0, $04 ; volume $04
    db $31, $02 ; note C#3 dur 2
    db $A1, $0B ; duty $0B
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $22, $0C ; note D2 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $FF ; duty2 $FF
    db $35, $0C ; note F3 dur 12
    db $A0, $04 ; volume $04
    db $35, $0C ; note F3 dur 12
    db $A0, $02 ; volume $02
    db $35, $0A ; note F3 dur 10
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $A1, $08 ; duty $08
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $13, $0C ; note D#1 dur 12
    db $23, $0A ; note D#2 dur 10
    db $A0, $04 ; volume $04
    db $23, $02 ; note D#2 dur 2
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $31, $10 ; note C#3 dur 16
    db $A0, $04 ; volume $04
    db $31, $08 ; note C#3 dur 8
    db $A1, $08 ; duty $08
    db $A0, $02 ; volume $02
    db $18, $0C ; note G#1 dur 12
    db $28, $0A ; note G#2 dur 10
    db $A0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $33, $10 ; note D#3 dur 16
    db $A0, $04 ; volume $04
    db $33, $08 ; note D#3 dur 8
    db $A1, $08 ; duty $08
    db $A0, $02 ; volume $02
    db $19, $0C ; note A1 dur 12
    db $29, $0A ; note A2 dur 10
    db $A0, $04 ; volume $04
    db $29, $02 ; note A2 dur 2
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $32, $10 ; note D3 dur 16
    db $A0, $04 ; volume $04
    db $32, $08 ; note D3 dur 8
    db $A1, $08 ; duty $08
    db $A0, $02 ; volume $02
    db $19, $0C ; note A1 dur 12
    db $29, $0A ; note A2 dur 10
    db $A0, $04 ; volume $04
    db $29, $02 ; note A2 dur 2
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $31, $10 ; note C#3 dur 16
    db $A0, $04 ; volume $04
    db $31, $09 ; note C#3 dur 9
    db $A1, $02 ; duty $02
    db $A0, $02 ; volume $02
    db $22, $0C ; note D2 dur 12
    db $A1, $0F ; duty $0F
    db $A2, $0C ; duty2 $0C
    db $A0, $04 ; volume $04
    db $29, $0C ; note A2 dur 12
    db $30, $0C ; note C3 dur 12
    db $33, $0C ; note D#3 dur 12
    db $35, $0C ; note F3 dur 12
    db $38, $0C ; note G#3 dur 12
    db $40, $0C ; note C4 dur 12
    db $43, $0C ; note D#4 dur 12
    db $45, $0C ; note F4 dur 12
    db $40, $0C ; note C4 dur 12
    db $3A, $0C ; note A#3 dur 12
    db $35, $0C ; note F3 dur 12
    db $A1, $08 ; duty $08
    db $A2, $7F ; duty2 $7F
    db $A0, $02 ; volume $02
    db $24, $18 ; note E2 dur 24
    db $A0, $02 ; volume $02
    db $19, $12 ; note A1 dur 18
    db $A0, $04 ; volume $04
    db $19, $06 ; note A1 dur 6
    db $FD, $F0 ; label 0
    db $A1, $0B ; duty $0B
    db $A0, $02 ; volume $02
    db $12, $06 ; note D1 dur 6
    db $A0, $04 ; volume $04
    db $12, $06 ; note D1 dur 6
    db $A1, $03 ; duty $03
    db $A0, $02 ; volume $02
    db $22, $04 ; note D2 dur 4
    db $A0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $04 ; volume $04
    db $29, $04 ; note A2 dur 4
    db $A0, $02 ; volume $02
    db $22, $04 ; note D2 dur 4
    db $A0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $B3, $F0 ; repeat $F0
    db $A7, $01 ; wait $01
    db $B0, $F3 ; jump $F3
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_66F7:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_66FD:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6703:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6709:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_670F:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 8 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6715:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0C, $00 ; header: param=5 byte1=$00 volume=$0C byte3=$00
    db $1F, $40 ; rest-note $1F dur 64
    db $C0, $FE ; env $FE
    db $29, $40 ; note A2 dur 64
    db $27, $40 ; note G2 dur 64
    db $A0, $08 ; volume $08
    db $C1, $70 ; env $70
    db $27, $30 ; note G2 dur 48
    db $FF, $FF ; end

; sound track, 18 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6729:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0F, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $A0, $04 ; volume $04
    db $1F, $10 ; rest-note $1F dur 16
    db $14, $10 ; note E1 dur 16
    db $17, $10 ; note G1 dur 16
    db $20, $10 ; note C2 dur 16
    db $A0, $0D ; volume $0D
    db $C0, $FE ; env $FE
    db $30, $3C ; note C3 dur 60
    db $A0, $05 ; volume $05
    db $C1, $20 ; env $20
    db $30, $04 ; note C3 dur 4
    db $A0, $0D ; volume $0D
    db $C0, $FE ; env $FE
    db $30, $40 ; note C3 dur 64
    db $A0, $08 ; volume $08
    db $C1, $70 ; env $70
    db $30, $30 ; note C3 dur 48
    db $FF, $FF ; end

; sound track, 12 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6751:: ; heuristic: track stream of a sound record; C0
    db $05, $FF, $02, $0C ; header: param=5 byte1=$FF volume=$02 byte3=$0C
    db $24, $10 ; note E2 dur 16
    db $27, $10 ; note G2 dur 16
    db $30, $10 ; note C3 dur 16
    db $34, $10 ; note E3 dur 16
    db $35, $20 ; note F3 dur 32
    db $32, $20 ; note D3 dur 32
    db $34, $40 ; note E3 dur 64
    db $A2, $40 ; duty2 $40
    db $A0, $04 ; volume $04
    db $34, $20 ; note E3 dur 32
    db $1F, $10 ; rest-note $1F dur 16
    db $FF, $FF ; end

; sound track, 15 events after the header (E-0019: grammar C2, meaning C0)
Data_042_676D:: ; heuristic: track stream of a sound record; C0
    db $04, $02, $0E, $00 ; header: param=4 byte1=$02 volume=$0E byte3=$00
    db $C1, $50 ; env $50
    db $36, $0C ; note F#3 dur 12
    db $35, $0C ; note F3 dur 12
    db $34, $0C ; note E3 dur 12
    db $32, $0C ; note D3 dur 12
    db $C2, $15 ; env $15
    db $30, $0D ; note C3 dur 13
    db $26, $0D ; note F#2 dur 13
    db $C1, $7F ; env $7F
    db $A0, $0D ; volume $0D
    db $36, $18 ; note F#3 dur 24
    db $A0, $06 ; volume $06
    db $C1, $30 ; env $30
    db $36, $18 ; note F#3 dur 24
    db $FF, $FF ; end

; sound track, 15 events after the header (E-0019: grammar C2, meaning C0)
Data_042_678F:: ; heuristic: track stream of a sound record; C0
    db $04, $02, $0F, $00 ; header: param=4 byte1=$02 volume=$0F byte3=$00
    db $C1, $50 ; env $50
    db $42, $0C ; note D4 dur 12
    db $41, $0C ; note C#4 dur 12
    db $40, $0C ; note C4 dur 12
    db $3B, $0C ; note B3 dur 12
    db $C2, $15 ; env $15
    db $39, $0D ; note A3 dur 13
    db $32, $0D ; note D3 dur 13
    db $C1, $7F ; env $7F
    db $A0, $0E ; volume $0E
    db $42, $18 ; note D4 dur 24
    db $A0, $07 ; volume $07
    db $C1, $30 ; env $30
    db $42, $18 ; note D4 dur 24
    db $FF, $FF ; end

; sound track, 21 events after the header (E-0019: grammar C2, meaning C0)
Data_042_67B1:: ; heuristic: track stream of a sound record; C0
    db $0B, $00, $05, $00 ; header: param=11 byte1=$00 volume=$05 byte3=$00
    db $1F, $04 ; rest-note $1F dur 4
    db $35, $06 ; note F3 dur 6
    db $22, $04 ; note D2 dur 4
    db $29, $04 ; note A2 dur 4
    db $35, $04 ; note F3 dur 4
    db $34, $04 ; note E3 dur 4
    db $21, $04 ; note C#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $34, $04 ; note E3 dur 4
    db $32, $04 ; note D3 dur 4
    db $1A, $04 ; note A#1 dur 4
    db $27, $04 ; note G2 dur 4
    db $32, $04 ; note D3 dur 4
    db $31, $04 ; note C#3 dur 4
    db $2A, $05 ; note A#2 dur 5
    db $29, $05 ; note A2 dur 5
    db $28, $06 ; note G#2 dur 6
    db $29, $02 ; note A2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $29, $18 ; note A2 dur 24
    db $FF, $FF ; end

; sound track, 21 events after the header (E-0019: grammar C2, meaning C0)
Data_042_67DF:: ; heuristic: track stream of a sound record; C0
    db $0B, $00, $0F, $00 ; header: param=11 byte1=$00 volume=$0F byte3=$00
    db $35, $06 ; note F3 dur 6
    db $22, $04 ; note D2 dur 4
    db $29, $04 ; note A2 dur 4
    db $35, $04 ; note F3 dur 4
    db $34, $04 ; note E3 dur 4
    db $21, $04 ; note C#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $34, $04 ; note E3 dur 4
    db $32, $04 ; note D3 dur 4
    db $1A, $04 ; note A#1 dur 4
    db $27, $04 ; note G2 dur 4
    db $32, $04 ; note D3 dur 4
    db $31, $04 ; note C#3 dur 4
    db $2A, $05 ; note A#2 dur 5
    db $29, $05 ; note A2 dur 5
    db $28, $06 ; note G#2 dur 6
    db $29, $02 ; note A2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $29, $18 ; note A2 dur 24
    db $1F, $04 ; rest-note $1F dur 4
    db $FF, $FF ; end

; sound track, 25 events after the header (E-0019: grammar C2, meaning C0)
Data_042_680D:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0E, $00 ; header: param=5 byte1=$00 volume=$0E byte3=$00
    db $39, $08 ; note A3 dur 8
    db $38, $04 ; note G#3 dur 4
    db $39, $02 ; note A3 dur 2
    db $FD, $F0 ; label 0
    db $35, $02 ; note F3 dur 2
    db $37, $02 ; note G3 dur 2
    db $B3, $F0 ; repeat $F0
    db $35, $02 ; note F3 dur 2
    db $34, $02 ; note E3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $32, $02 ; note D3 dur 2
    db $31, $02 ; note C#3 dur 2
    db $30, $02 ; note C3 dur 2
    db $2B, $02 ; note B2 dur 2
    db $2A, $02 ; note A#2 dur 2
    db $29, $02 ; note A2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $A0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $26, $02 ; note F#2 dur 2
    db $A0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $24, $02 ; note E2 dur 2
    db $1F, $08 ; rest-note $1F dur 8
    db $FF, $FF ; end

; sound track, 25 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6843:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0F, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $2A, $08 ; note A#2 dur 8
    db $32, $04 ; note D3 dur 4
    db $2A, $02 ; note A#2 dur 2
    db $FD, $F0 ; label 0
    db $2B, $02 ; note B2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $B3, $F0 ; repeat $F0
    db $2B, $02 ; note B2 dur 2
    db $2A, $02 ; note A#2 dur 2
    db $29, $02 ; note A2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $27, $02 ; note G2 dur 2
    db $26, $02 ; note F#2 dur 2
    db $25, $02 ; note F2 dur 2
    db $24, $02 ; note E2 dur 2
    db $23, $02 ; note D#2 dur 2
    db $22, $02 ; note D2 dur 2
    db $A0, $08 ; volume $08
    db $21, $02 ; note C#2 dur 2
    db $20, $02 ; note C2 dur 2
    db $A0, $04 ; volume $04
    db $1B, $02 ; note B1 dur 2
    db $1A, $02 ; note A#1 dur 2
    db $1F, $08 ; rest-note $1F dur 8
    db $FF, $FF ; end

; sound track, 33 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6879:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0E, $00 ; header: param=5 byte1=$00 volume=$0E byte3=$00
    db $39, $08 ; note A3 dur 8
    db $38, $04 ; note G#3 dur 4
    db $39, $02 ; note A3 dur 2
    db $35, $02 ; note F3 dur 2
    db $28, $02 ; note G#2 dur 2
    db $2B, $02 ; note B2 dur 2
    db $22, $02 ; note D2 dur 2
    db $35, $02 ; note F3 dur 2
    db $37, $02 ; note G3 dur 2
    db $3B, $02 ; note B3 dur 2
    db $42, $02 ; note D4 dur 2
    db $FD, $F0 ; label 0
    db $45, $02 ; note F4 dur 2
    db $47, $02 ; note G4 dur 2
    db $B3, $F0 ; repeat $F0
    db $45, $02 ; note F4 dur 2
    db $44, $02 ; note E4 dur 2
    db $43, $02 ; note D#4 dur 2
    db $42, $02 ; note D4 dur 2
    db $41, $02 ; note C#4 dur 2
    db $40, $02 ; note C4 dur 2
    db $3B, $02 ; note B3 dur 2
    db $3A, $02 ; note A#3 dur 2
    db $39, $02 ; note A3 dur 2
    db $38, $02 ; note G#3 dur 2
    db $A0, $06 ; volume $06
    db $37, $02 ; note G3 dur 2
    db $36, $02 ; note F#3 dur 2
    db $A0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $34, $02 ; note E3 dur 2
    db $1F, $08 ; rest-note $1F dur 8
    db $FF, $FF ; end

; sound track, 33 events after the header (E-0019: grammar C2, meaning C0)
Data_042_68BF:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0F, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $2A, $08 ; note A#2 dur 8
    db $32, $04 ; note D3 dur 4
    db $2A, $02 ; note A#2 dur 2
    db $2B, $02 ; note B2 dur 2
    db $25, $02 ; note F2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $2B, $02 ; note B2 dur 2
    db $32, $02 ; note D3 dur 2
    db $35, $02 ; note F3 dur 2
    db $38, $02 ; note G#3 dur 2
    db $35, $02 ; note F3 dur 2
    db $FD, $F0 ; label 0
    db $3B, $02 ; note B3 dur 2
    db $38, $02 ; note G#3 dur 2
    db $B3, $F0 ; repeat $F0
    db $3B, $02 ; note B3 dur 2
    db $3A, $02 ; note A#3 dur 2
    db $39, $02 ; note A3 dur 2
    db $38, $02 ; note G#3 dur 2
    db $37, $02 ; note G3 dur 2
    db $36, $02 ; note F#3 dur 2
    db $35, $02 ; note F3 dur 2
    db $34, $02 ; note E3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $32, $02 ; note D3 dur 2
    db $A0, $06 ; volume $06
    db $31, $02 ; note C#3 dur 2
    db $30, $02 ; note C3 dur 2
    db $A0, $04 ; volume $04
    db $2B, $02 ; note B2 dur 2
    db $2A, $02 ; note A#2 dur 2
    db $1F, $08 ; rest-note $1F dur 8
    db $FF, $FF ; end

; sound track, 15 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6905:: ; heuristic: track stream of a sound record; C0
    db $09, $02, $0F, $00 ; header: param=9 byte1=$02 volume=$0F byte3=$00
    db $C1, $60 ; env $60
    db $24, $04 ; note E2 dur 4
    db $14, $03 ; note E1 dur 3
    db $15, $03 ; note F1 dur 3
    db $17, $03 ; note G1 dur 3
    db $19, $03 ; note A1 dur 3
    db $1B, $03 ; note B1 dur 3
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $C2, $15 ; env $15
    db $24, $06 ; note E2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $C1, $1F ; env $1F
    db $34, $0C ; note E3 dur 12
    db $FF, $FF ; end

; sound track, 15 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6927:: ; heuristic: track stream of a sound record; C0
    db $09, $02, $0F, $00 ; header: param=9 byte1=$02 volume=$0F byte3=$00
    db $C1, $60 ; env $60
    db $27, $04 ; note G2 dur 4
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2B, $03 ; note B2 dur 3
    db $C2, $15 ; env $15
    db $30, $06 ; note C3 dur 6
    db $37, $06 ; note G3 dur 6
    db $C1, $1F ; env $1F
    db $40, $0C ; note C4 dur 12
    db $FF, $FF ; end

; sound track, 67 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6949:: ; heuristic: track stream of a sound record; C0
    db $04, $00, $0F, $00 ; header: param=4 byte1=$00 volume=$0F byte3=$00
    db $C1, $1F ; env $1F
    db $24, $06 ; note E2 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $09 ; volume $09
    db $24, $07 ; note E2 dur 7
    db $A0, $0D ; volume $0D
    db $24, $02 ; note E2 dur 2
    db $A0, $05 ; volume $05
    db $24, $02 ; note E2 dur 2
    db $A0, $0D ; volume $0D
    db $24, $05 ; note E2 dur 5
    db $A0, $06 ; volume $06
    db $24, $03 ; note E2 dur 3
    db $FD, $F0 ; label 0
    db $A0, $0D ; volume $0D
    db $25, $04 ; note F2 dur 4
    db $A0, $07 ; volume $07
    db $25, $04 ; note F2 dur 4
    db $B2, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0D ; volume $0D
    db $24, $04 ; note E2 dur 4
    db $A0, $07 ; volume $07
    db $24, $04 ; note E2 dur 4
    db $B2, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0D ; volume $0D
    db $22, $04 ; note D2 dur 4
    db $A0, $07 ; volume $07
    db $22, $04 ; note D2 dur 4
    db $B2, $F0 ; repeat $F0
    db $A0, $0E ; volume $0E
    db $C1, $2F ; env $2F
    db $24, $06 ; note E2 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $17, $06 ; note G1 dur 6
    db $19, $06 ; note A1 dur 6
    db $1B, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $24, $0E ; note E2 dur 14
    db $A0, $06 ; volume $06
    db $24, $0C ; note E2 dur 12
    db $A0, $0F ; volume $0F
    db $2B, $0C ; note B2 dur 12
    db $2B, $0D ; note B2 dur 13
    db $2B, $0F ; note B2 dur 15
    db $C3, $40 ; env $40
    db $34, $04 ; note E3 dur 4
    db $37, $03 ; note G3 dur 3
    db $FD, $F0 ; label 0
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $B3, $F0 ; repeat $F0
    db $A0, $0D ; volume $0D
    db $FD, $F0 ; label 0
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $B3, $F0 ; repeat $F0
    db $34, $03 ; note E3 dur 3
    db $37, $02 ; note G3 dur 2
    db $C1, $7F ; env $7F
    db $A0, $06 ; volume $06
    db $34, $18 ; note E3 dur 24
    db $1F, $18 ; rest-note $1F dur 24
    db $FF, $FF ; end

; sound track, 54 events after the header (E-0019: grammar C2, meaning C0)
Data_042_69D3:: ; heuristic: track stream of a sound record; C0
    db $04, $00, $0F, $00 ; header: param=4 byte1=$00 volume=$0F byte3=$00
    db $C1, $1F ; env $1F
    db $27, $06 ; note G2 dur 6
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $09 ; volume $09
    db $27, $07 ; note G2 dur 7
    db $A0, $0F ; volume $0F
    db $27, $02 ; note G2 dur 2
    db $A0, $06 ; volume $06
    db $27, $02 ; note G2 dur 2
    db $A0, $0F ; volume $0F
    db $27, $05 ; note G2 dur 5
    db $A0, $06 ; volume $06
    db $27, $03 ; note G2 dur 3
    db $FD, $F0 ; label 0
    db $A0, $0F ; volume $0F
    db $29, $04 ; note A2 dur 4
    db $A0, $07 ; volume $07
    db $29, $04 ; note A2 dur 4
    db $B2, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0F ; volume $0F
    db $27, $04 ; note G2 dur 4
    db $A0, $07 ; volume $07
    db $27, $04 ; note G2 dur 4
    db $B2, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $A0, $0F ; volume $0F
    db $25, $04 ; note F2 dur 4
    db $A0, $07 ; volume $07
    db $25, $04 ; note F2 dur 4
    db $B2, $F0 ; repeat $F0
    db $C1, $2F ; env $2F
    db $A0, $0F ; volume $0F
    db $27, $06 ; note G2 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $24, $06 ; note E2 dur 6
    db $25, $06 ; note F2 dur 6
    db $27, $06 ; note G2 dur 6
    db $29, $06 ; note A2 dur 6
    db $2B, $06 ; note B2 dur 6
    db $30, $0E ; note C3 dur 14
    db $A0, $06 ; volume $06
    db $30, $0C ; note C3 dur 12
    db $A0, $0F ; volume $0F
    db $37, $0C ; note G3 dur 12
    db $37, $0D ; note G3 dur 13
    db $37, $0F ; note G3 dur 15
    db $C1, $FE ; env $FE
    db $40, $54 ; note C4 dur 84
    db $C1, $30 ; env $30
    db $A0, $06 ; volume $06
    db $40, $18 ; note C4 dur 24
    db $FF, $FF ; end

; sound track, 16 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6A43:: ; heuristic: track stream of a sound record; C0
    db $04, $FF, $02, $03 ; header: param=4 byte1=$FF volume=$02 byte3=$03
    db $20, $62 ; note C2 dur 98
    db $A0, $04 ; volume $04
    db $20, $18 ; note C2 dur 24
    db $1F, $59 ; rest-note $1F dur 89
    db $A0, $02 ; volume $02
    db $A2, $30 ; duty2 $30
    db $A1, $09 ; duty $09
    db $20, $0F ; note C2 dur 15
    db $17, $0F ; note G1 dur 15
    db $20, $0F ; note C2 dur 15
    db $17, $0F ; note G1 dur 15
    db $A2, $FF ; duty2 $FF
    db $20, $18 ; note C2 dur 24
    db $A0, $06 ; volume $06
    db $20, $18 ; note C2 dur 24
    db $FF, $FF ; end

; sound track, 141 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6A67:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0D, $00 ; header: param=5 byte1=$00 volume=$0D byte3=$00
    db $A0, $0F ; volume $0F
    db $24, $04 ; note E2 dur 4
    db $A0, $0D ; volume $0D
    db $14, $03 ; note E1 dur 3
    db $15, $03 ; note F1 dur 3
    db $17, $03 ; note G1 dur 3
    db $19, $03 ; note A1 dur 3
    db $1B, $03 ; note B1 dur 3
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $A0, $0F ; volume $0F
    db $24, $03 ; note E2 dur 3
    db $A0, $0D ; volume $0D
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2B, $03 ; note B2 dur 3
    db $A0, $0F ; volume $0F
    db $30, $03 ; note C3 dur 3
    db $A0, $0D ; volume $0D
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2B, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $A0, $0F ; volume $0F
    db $34, $03 ; note E3 dur 3
    db $A0, $0D ; volume $0D
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $A0, $0F ; volume $0F
    db $29, $03 ; note A2 dur 3
    db $2B, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $C1, $2F ; env $2F
    db $24, $0A ; note E2 dur 10
    db $A0, $06 ; volume $06
    db $24, $04 ; note E2 dur 4
    db $A0, $0F ; volume $0F
    db $24, $04 ; note E2 dur 4
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $25, $08 ; note F2 dur 8
    db $25, $08 ; note F2 dur 8
    db $24, $08 ; note E2 dur 8
    db $24, $08 ; note E2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $22, $08 ; note D2 dur 8
    db $22, $08 ; note D2 dur 8
    db $A0, $0D ; volume $0D
    db $C1, $2F ; env $2F
    db $24, $09 ; note E2 dur 9
    db $A0, $06 ; volume $06
    db $24, $04 ; note E2 dur 4
    db $A0, $0F ; volume $0F
    db $24, $04 ; note E2 dur 4
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $25, $08 ; note F2 dur 8
    db $25, $08 ; note F2 dur 8
    db $24, $08 ; note E2 dur 8
    db $24, $08 ; note E2 dur 8
    db $24, $08 ; note E2 dur 8
    db $22, $08 ; note D2 dur 8
    db $22, $08 ; note D2 dur 8
    db $22, $08 ; note D2 dur 8
    db $A0, $0B ; volume $0B
    db $24, $08 ; note E2 dur 8
    db $20, $08 ; note C2 dur 8
    db $24, $08 ; note E2 dur 8
    db $27, $08 ; note G2 dur 8
    db $24, $08 ; note E2 dur 8
    db $27, $08 ; note G2 dur 8
    db $30, $08 ; note C3 dur 8
    db $27, $08 ; note G2 dur 8
    db $30, $08 ; note C3 dur 8
    db $34, $08 ; note E3 dur 8
    db $30, $08 ; note C3 dur 8
    db $34, $08 ; note E3 dur 8
    db $A0, $0D ; volume $0D
    db $C1, $2F ; env $2F
    db $38, $0B ; note G#3 dur 11
    db $A0, $06 ; volume $06
    db $C1, $1F ; env $1F
    db $38, $04 ; note G#3 dur 4
    db $A0, $0F ; volume $0F
    db $38, $04 ; note G#3 dur 4
    db $C1, $2F ; env $2F
    db $38, $08 ; note G#3 dur 8
    db $34, $09 ; note E3 dur 9
    db $34, $0A ; note E3 dur 10
    db $34, $0A ; note E3 dur 10
    db $33, $0B ; note D#3 dur 11
    db $33, $0C ; note D#3 dur 12
    db $33, $0D ; note D#3 dur 13
    db $35, $0E ; note F3 dur 14
    db $35, $0F ; note F3 dur 15
    db $35, $10 ; note F3 dur 16
    db $C3, $40 ; env $40
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $FD, $F0 ; label 0
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $B6, $F0 ; repeat $F0
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $34, $04 ; note E3 dur 4
    db $37, $03 ; note G3 dur 3
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $34, $03 ; note E3 dur 3
    db $37, $04 ; note G3 dur 4
    db $C1, $60 ; env $60
    db $A0, $09 ; volume $09
    db $34, $18 ; note E3 dur 24
    db $A0, $03 ; volume $03
    db $34, $18 ; note E3 dur 24
    db $FF, $FF ; end

; sound track, 104 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6B85:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0F, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $27, $04 ; note G2 dur 4
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2B, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2B, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $34, $03 ; note E3 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2B, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $34, $03 ; note E3 dur 3
    db $35, $03 ; note F3 dur 3
    db $37, $03 ; note G3 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $34, $03 ; note E3 dur 3
    db $35, $03 ; note F3 dur 3
    db $37, $03 ; note G3 dur 3
    db $39, $03 ; note A3 dur 3
    db $3B, $03 ; note B3 dur 3
    db $C1, $2F ; env $2F
    db $27, $0A ; note G2 dur 10
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A0, $0F ; volume $0F
    db $27, $04 ; note G2 dur 4
    db $27, $08 ; note G2 dur 8
    db $29, $08 ; note A2 dur 8
    db $29, $08 ; note A2 dur 8
    db $29, $08 ; note A2 dur 8
    db $27, $08 ; note G2 dur 8
    db $27, $08 ; note G2 dur 8
    db $27, $08 ; note G2 dur 8
    db $25, $08 ; note F2 dur 8
    db $25, $08 ; note F2 dur 8
    db $25, $08 ; note F2 dur 8
    db $A0, $0D ; volume $0D
    db $C1, $2F ; env $2F
    db $27, $09 ; note G2 dur 9
    db $A0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $A0, $0F ; volume $0F
    db $27, $04 ; note G2 dur 4
    db $27, $08 ; note G2 dur 8
    db $29, $08 ; note A2 dur 8
    db $29, $08 ; note A2 dur 8
    db $29, $08 ; note A2 dur 8
    db $27, $08 ; note G2 dur 8
    db $27, $08 ; note G2 dur 8
    db $27, $08 ; note G2 dur 8
    db $25, $08 ; note F2 dur 8
    db $25, $08 ; note F2 dur 8
    db $25, $08 ; note F2 dur 8
    db $A0, $0B ; volume $0B
    db $C1, $28 ; env $28
    db $27, $08 ; note G2 dur 8
    db $24, $08 ; note E2 dur 8
    db $27, $08 ; note G2 dur 8
    db $30, $08 ; note C3 dur 8
    db $27, $08 ; note G2 dur 8
    db $30, $08 ; note C3 dur 8
    db $34, $08 ; note E3 dur 8
    db $30, $08 ; note C3 dur 8
    db $34, $08 ; note E3 dur 8
    db $37, $08 ; note G3 dur 8
    db $34, $08 ; note E3 dur 8
    db $37, $08 ; note G3 dur 8
    db $C1, $20 ; env $20
    db $A0, $0D ; volume $0D
    db $40, $0B ; note C4 dur 11
    db $A0, $06 ; volume $06
    db $C1, $1F ; env $1F
    db $40, $04 ; note C4 dur 4
    db $C1, $28 ; env $28
    db $A0, $0F ; volume $0F
    db $40, $04 ; note C4 dur 4
    db $40, $08 ; note C4 dur 8
    db $C1, $2F ; env $2F
    db $37, $09 ; note G3 dur 9
    db $37, $0A ; note G3 dur 10
    db $37, $0A ; note G3 dur 10
    db $38, $0B ; note G#3 dur 11
    db $38, $0C ; note G#3 dur 12
    db $38, $0D ; note G#3 dur 13
    db $3A, $0E ; note A#3 dur 14
    db $3A, $0F ; note A#3 dur 15
    db $3A, $10 ; note A#3 dur 16
    db $C0, $FE ; env $FE
    db $40, $9B ; note C4 dur 155
    db $C1, $70 ; env $70
    db $40, $30 ; note C4 dur 48
    db $FF, $FF ; end

; sound track, 102 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6C59:: ; heuristic: track stream of a sound record; C0
    db $05, $FF, $02, $03 ; header: param=5 byte1=$FF volume=$02 byte3=$03
    db $20, $49 ; note C2 dur 73
    db $A0, $04 ; volume $04
    db $20, $18 ; note C2 dur 24
    db $A0, $02 ; volume $02
    db $50, $04 ; note C5 dur 4
    db $52, $04 ; note D5 dur 4
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $FD, $F0 ; label 0
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $B2, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $B3, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $B2, $F0 ; repeat $F0
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $02 ; note D5 dur 2
    db $50, $02 ; note C5 dur 2
    db $52, $01 ; note D5 dur 1
    db $A2, $10 ; duty2 $10
    db $43, $0B ; note D#4 dur 11
    db $A0, $06 ; volume $06
    db $43, $04 ; note D#4 dur 4
    db $A0, $02 ; volume $02
    db $43, $04 ; note D#4 dur 4
    db $A2, $1F ; duty2 $1F
    db $43, $08 ; note D#4 dur 8
    db $40, $09 ; note C4 dur 9
    db $40, $0A ; note C4 dur 10
    db $40, $0A ; note C4 dur 10
    db $40, $0B ; note C4 dur 11
    db $40, $0C ; note C4 dur 12
    db $40, $0D ; note C4 dur 13
    db $42, $0E ; note D4 dur 14
    db $42, $0F ; note D4 dur 15
    db $42, $10 ; note D4 dur 16
    db $A1, $0B ; duty $0B
    db $A2, $40 ; duty2 $40
    db $20, $11 ; note C2 dur 17
    db $17, $11 ; note G1 dur 17
    db $20, $11 ; note C2 dur 17
    db $17, $11 ; note G1 dur 17
    db $20, $12 ; note C2 dur 18
    db $17, $12 ; note G1 dur 18
    db $20, $18 ; note C2 dur 24
    db $17, $1B ; note G1 dur 27
    db $A2, $50 ; duty2 $50
    db $20, $18 ; note C2 dur 24
    db $A0, $06 ; volume $06
    db $20, $18 ; note C2 dur 24
    db $FF, $FF ; end

; sound track, 13 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6D29:: ; heuristic: track stream of a sound record; C0
    db $07, $01, $0F, $00 ; header: param=7 byte1=$01 volume=$0F byte3=$00
    db $C2, $1F ; env $1F
    db $30, $04 ; note C3 dur 4
    db $2B, $04 ; note B2 dur 4
    db $2A, $04 ; note A#2 dur 4
    db $C2, $15 ; env $15
    db $29, $08 ; note A2 dur 8
    db $27, $08 ; note G2 dur 8
    db $2A, $08 ; note A#2 dur 8
    db $C1, $30 ; env $30
    db $29, $0C ; note A2 dur 12
    db $A0, $06 ; volume $06
    db $29, $0C ; note A2 dur 12
    db $FF, $FF ; end

; sound track, 13 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6D47:: ; heuristic: track stream of a sound record; C0
    db $07, $01, $0F, $00 ; header: param=7 byte1=$01 volume=$0F byte3=$00
    db $C2, $1F ; env $1F
    db $35, $04 ; note F3 dur 4
    db $35, $04 ; note F3 dur 4
    db $35, $04 ; note F3 dur 4
    db $C2, $15 ; env $15
    db $35, $08 ; note F3 dur 8
    db $33, $08 ; note D#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $C1, $30 ; env $30
    db $35, $0C ; note F3 dur 12
    db $A0, $06 ; volume $06
    db $35, $0C ; note F3 dur 12
    db $FF, $FF ; end

; sound track, 14 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6D65:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0E, $00 ; header: param=5 byte1=$00 volume=$0E byte3=$00
    db $C1, $50 ; env $50
    db $FD, $F0 ; label 0
    db $12, $04 ; note D1 dur 4
    db $21, $04 ; note C#2 dur 4
    db $11, $04 ; note C#1 dur 4
    db $20, $04 ; note C2 dur 4
    db $B3, $F0 ; repeat $F0
    db $16, $0C ; note F#1 dur 12
    db $17, $02 ; note G1 dur 2
    db $18, $02 ; note G#1 dur 2
    db $10, $08 ; note C1 dur 8
    db $A0, $08 ; volume $08
    db $10, $14 ; note C1 dur 20
    db $FF, $FF ; end

; sound track, 14 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6D85:: ; heuristic: track stream of a sound record; C0
    db $05, $00, $0F, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $C1, $50 ; env $50
    db $FD, $F0 ; label 0
    db $02, $04 ; note D0 dur 4
    db $11, $04 ; note C#1 dur 4
    db $01, $04 ; note C#0 dur 4
    db $10, $04 ; note C1 dur 4
    db $B3, $F0 ; repeat $F0
    db $06, $0C ; note F#0 dur 12
    db $07, $02 ; note G0 dur 2
    db $08, $02 ; note G#0 dur 2
    db $00, $08 ; note C0 dur 8
    db $A0, $08 ; volume $08
    db $00, $14 ; note C0 dur 20
    db $FF, $FF ; end

; sound track, 57 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6DA5:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C2, $40 ; env $40
    db $A0, $0D ; volume $0D
    db $15, $0A ; note F1 dur 10
    db $C1, $28 ; env $28
    db $A0, $0C ; volume $0C
    db $29, $0A ; note A2 dur 10
    db $A0, $0A ; volume $0A
    db $29, $0A ; note A2 dur 10
    db $30, $0A ; note C3 dur 10
    db $A0, $08 ; volume $08
    db $30, $0A ; note C3 dur 10
    db $2A, $0A ; note A#2 dur 10
    db $2A, $0A ; note A#2 dur 10
    db $29, $0A ; note A2 dur 10
    db $A0, $0F ; volume $0F
    db $C2, $40 ; env $40
    db $22, $0A ; note D2 dur 10
    db $C1, $18 ; env $18
    db $A0, $0E ; volume $0E
    db $29, $0A ; note A2 dur 10
    db $29, $0A ; note A2 dur 10
    db $29, $0A ; note A2 dur 10
    db $A0, $0C ; volume $0C
    db $29, $0A ; note A2 dur 10
    db $A0, $0B ; volume $0B
    db $26, $0A ; note F#2 dur 10
    db $A0, $0A ; volume $0A
    db $26, $0A ; note F#2 dur 10
    db $26, $0A ; note F#2 dur 10
    db $A0, $0B ; volume $0B
    db $C2, $30 ; env $30
    db $22, $08 ; note D2 dur 8
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $22, $0B ; note D2 dur 11
    db $A0, $0A ; volume $0A
    db $24, $08 ; note E2 dur 8
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $24, $0B ; note E2 dur 11
    db $C1, $14 ; env $14
    db $A0, $0F ; volume $0F
    db $29, $08 ; note A2 dur 8
    db $A0, $0A ; volume $0A
    db $29, $08 ; note A2 dur 8
    db $A0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $A0, $04 ; volume $04
    db $29, $08 ; note A2 dur 8
    db $A0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $A0, $01 ; volume $01
    db $29, $08 ; note A2 dur 8
    db $A0, $01 ; volume $01
    db $29, $08 ; note A2 dur 8
    db $1F, $10 ; rest-note $1F dur 16
    db $FF, $FF ; end

; sound track, 52 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6E1B:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0D, $00 ; header: param=0 byte1=$00 volume=$0D byte3=$00
    db $C2, $40 ; env $40
    db $1F, $0A ; rest-note $1F dur 10
    db $35, $0A ; note F3 dur 10
    db $A0, $0B ; volume $0B
    db $35, $0A ; note F3 dur 10
    db $34, $0A ; note E3 dur 10
    db $A0, $0A ; volume $0A
    db $34, $0A ; note E3 dur 10
    db $32, $0A ; note D3 dur 10
    db $32, $0A ; note D3 dur 10
    db $30, $0A ; note C3 dur 10
    db $A0, $08 ; volume $08
    db $30, $0A ; note C3 dur 10
    db $A0, $0D ; volume $0D
    db $32, $0A ; note D3 dur 10
    db $32, $0A ; note D3 dur 10
    db $30, $0A ; note C3 dur 10
    db $A0, $0C ; volume $0C
    db $30, $0A ; note C3 dur 10
    db $A0, $0B ; volume $0B
    db $2A, $0A ; note A#2 dur 10
    db $A0, $0A ; volume $0A
    db $2A, $0A ; note A#2 dur 10
    db $29, $0A ; note A2 dur 10
    db $A0, $0B ; volume $0B
    db $C2, $3F ; env $3F
    db $27, $08 ; note G2 dur 8
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $27, $0B ; note G2 dur 11
    db $A0, $0A ; volume $0A
    db $30, $08 ; note C3 dur 8
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $03 ; volume $03
    db $30, $0B ; note C3 dur 11
    db $C1, $14 ; env $14
    db $A0, $0F ; volume $0F
    db $35, $08 ; note F3 dur 8
    db $A0, $0A ; volume $0A
    db $35, $08 ; note F3 dur 8
    db $A0, $07 ; volume $07
    db $35, $08 ; note F3 dur 8
    db $A0, $04 ; volume $04
    db $35, $08 ; note F3 dur 8
    db $A0, $02 ; volume $02
    db $35, $08 ; note F3 dur 8
    db $A0, $01 ; volume $01
    db $35, $08 ; note F3 dur 8
    db $A0, $01 ; volume $01
    db $35, $08 ; note F3 dur 8
    db $1F, $10 ; rest-note $1F dur 16
    db $FF, $FF ; end

; sound track, 44 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6E87:: ; heuristic: track stream of a sound record; C0
    db $00, $30, $02, $02 ; header: param=0 byte1=$30 volume=$02 byte3=$02
    db $A2, $70 ; duty2 $70
    db $A1, $09 ; duty $09
    db $15, $0A ; note F1 dur 10
    db $A1, $02 ; duty $02
    db $A2, $1C ; duty2 $1C
    db $30, $0A ; note C3 dur 10
    db $30, $0A ; note C3 dur 10
    db $35, $0A ; note F3 dur 10
    db $35, $0A ; note F3 dur 10
    db $35, $0A ; note F3 dur 10
    db $35, $0A ; note F3 dur 10
    db $35, $0A ; note F3 dur 10
    db $A1, $09 ; duty $09
    db $A2, $70 ; duty2 $70
    db $22, $0A ; note D2 dur 10
    db $A1, $02 ; duty $02
    db $A2, $1D ; duty2 $1D
    db $36, $0A ; note F#3 dur 10
    db $36, $0A ; note F#3 dur 10
    db $36, $0A ; note F#3 dur 10
    db $36, $0A ; note F#3 dur 10
    db $32, $0A ; note D3 dur 10
    db $32, $0A ; note D3 dur 10
    db $30, $0A ; note C3 dur 10
    db $A2, $10 ; duty2 $10
    db $A0, $02 ; volume $02
    db $2A, $08 ; note A#2 dur 8
    db $A0, $06 ; volume $06
    db $2A, $0C ; note A#2 dur 12
    db $A0, $02 ; volume $02
    db $2A, $08 ; note A#2 dur 8
    db $A0, $06 ; volume $06
    db $2A, $0C ; note A#2 dur 12
    db $A2, $0A ; duty2 $0A
    db $A0, $02 ; volume $02
    db $25, $08 ; note F2 dur 8
    db $A0, $04 ; volume $04
    db $25, $08 ; note F2 dur 8
    db $A0, $06 ; volume $06
    db $25, $08 ; note F2 dur 8
    db $A0, $06 ; volume $06
    db $25, $04 ; note F2 dur 4
    db $1F, $30 ; rest-note $1F dur 48
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6EE3:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 24 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6EE9:: ; heuristic: track stream of a sound record; C0
    db $04, $03, $0A, $00 ; header: param=4 byte1=$03 volume=$0A byte3=$00
    db $C2, $08 ; env $08
    db $24, $0C ; note E2 dur 12
    db $27, $0C ; note G2 dur 12
    db $30, $0C ; note C3 dur 12
    db $35, $0D ; note F3 dur 13
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $06 ; volume $06
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $A0, $04 ; volume $04
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $A0, $02 ; volume $02
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $A0, $01 ; volume $01
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $1F, $08 ; rest-note $1F dur 8
    db $FF, $FF ; end

; sound track, 27 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6F1D:: ; heuristic: track stream of a sound record; C0
    db $04, $00, $0F, $00 ; header: param=4 byte1=$00 volume=$0F byte3=$00
    db $C1, $09 ; env $09
    db $27, $0C ; note G2 dur 12
    db $30, $0C ; note C3 dur 12
    db $34, $0C ; note E3 dur 12
    db $37, $0C ; note G3 dur 12
    db $A0, $0D ; volume $0D
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $A0, $0B ; volume $0B
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $A0, $09 ; volume $09
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $A0, $07 ; volume $07
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $A0, $05 ; volume $05
    db $34, $03 ; note E3 dur 3
    db $A0, $03 ; volume $03
    db $40, $03 ; note C4 dur 3
    db $A0, $02 ; volume $02
    db $34, $03 ; note E3 dur 3
    db $A0, $01 ; volume $01
    db $40, $03 ; note C4 dur 3
    db $1F, $0B ; rest-note $1F dur 11
    db $FF, $FF ; end

; sound track, 7 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6F57:: ; heuristic: track stream of a sound record; C0
    db $04, $06, $06, $02 ; header: param=4 byte1=$06 volume=$06 byte3=$02
    db $1F, $07 ; rest-note $1F dur 7
    db $37, $0C ; note G3 dur 12
    db $40, $0C ; note C4 dur 12
    db $44, $0C ; note E4 dur 12
    db $47, $0C ; note G4 dur 12
    db $1F, $28 ; rest-note $1F dur 40
    db $FF, $FF ; end

; sound track, 2 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6F69:: ; heuristic: track stream of a sound record; C0
    db $04, $00, $00, $00 ; header: param=4 byte1=$00 volume=$00 byte3=$00
    db $1F, $70 ; rest-note $1F dur 112
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6F71:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6F77:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6F7D:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6F83:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 16 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6F89:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0D, $00 ; header: param=0 byte1=$00 volume=$0D byte3=$00
    db $47, $05 ; note G4 dur 5
    db $A0, $02 ; volume $02
    db $47, $08 ; note G4 dur 8
    db $A0, $0D ; volume $0D
    db $43, $05 ; note D#4 dur 5
    db $A0, $02 ; volume $02
    db $43, $08 ; note D#4 dur 8
    db $A0, $0D ; volume $0D
    db $47, $05 ; note G4 dur 5
    db $A0, $02 ; volume $02
    db $47, $08 ; note G4 dur 8
    db $A0, $0D ; volume $0D
    db $43, $05 ; note D#4 dur 5
    db $A0, $03 ; volume $03
    db $43, $09 ; note D#4 dur 9
    db $FF, $FF ; end

; sound track, 84 events after the header (E-0019: grammar C2, meaning C0)
Data_042_6FAD:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $02, $00 ; header: param=0 byte1=$02 volume=$02 byte3=$00
    db $FD, $F0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $B5, $F0 ; repeat $F0
    db $A0, $03 ; volume $03
    db $FD, $F0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $B5, $F0 ; repeat $F0
    db $A0, $04 ; volume $04
    db $FD, $F0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $B5, $F0 ; repeat $F0
    db $A0, $05 ; volume $05
    db $FD, $F0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $B5, $F0 ; repeat $F0
    db $A0, $07 ; volume $07
    db $FD, $F0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $B5, $F0 ; repeat $F0
    db $A0, $09 ; volume $09
    db $FD, $F0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $B5, $F0 ; repeat $F0
    db $A0, $0B ; volume $0B
    db $FD, $F0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $B3, $F0 ; repeat $F0
    db $A0, $0D ; volume $0D
    db $FD, $F0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $B3, $F0 ; repeat $F0
    db $A0, $0F ; volume $0F
    db $FD, $F0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $BA, $F0 ; repeat $F0
    db $A0, $0D ; volume $0D
    db $FD, $F0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $BA, $F0 ; repeat $F0
    db $FD, $F0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $BA, $F0 ; repeat $F0
    db $A0, $09 ; volume $09
    db $FD, $F0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $B6, $F0 ; repeat $F0
    db $A0, $07 ; volume $07
    db $FD, $F0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $B3, $F0 ; repeat $F0
    db $A0, $04 ; volume $04
    db $FD, $F0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $B5, $F0 ; repeat $F0
    db $A0, $03 ; volume $03
    db $FD, $F0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $BA, $F0 ; repeat $F0
    db $A0, $02 ; volume $02
    db $FD, $F0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $B3, $F0 ; repeat $F0
    db $A0, $01 ; volume $01
    db $FD, $F0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $B2, $F0 ; repeat $F0
    db $FF, $FF ; end

; sound track, 8 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7059:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $37 ; header: param=0 byte1=$01 volume=$0F byte3=$37
    db $1B, $02 ; note B1 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $20, $01 ; note C2 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $21, $02 ; note C#2 dur 2
    db $A0, $05 ; volume $05
    db $21, $03 ; note C#2 dur 3
    db $FF, $FF ; end

; sound track, 6 events after the header (E-0019: grammar C2, meaning C0)
Data_042_706D:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $2D ; header: param=0 byte1=$01 volume=$0F byte3=$2D
    db $AE, $10 ; tuning $10
    db $14, $03 ; note E1 dur 3
    db $11, $02 ; note C#1 dur 2
    db $A0, $08 ; volume $08
    db $11, $03 ; note C#1 dur 3
    db $FF, $FF ; end

; sound track, 7 events after the header (E-0019: grammar C2, meaning C0)
Data_042_707D:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $1F, $01 ; rest-note $1F dur 1
    db $80, $02 ; note C8 dur 2
    db $A0, $08 ; volume $08
    db $80, $02 ; note C8 dur 2
    db $A0, $04 ; volume $04
    db $80, $02 ; note C8 dur 2
    db $FF, $FF ; end

; sound track, 5 events after the header (E-0019: grammar C2, meaning C0)
Data_042_708F:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $17 ; header: param=0 byte1=$02 volume=$0F byte3=$17
    db $C1, $60 ; env $60
    db $29, $06 ; note A2 dur 6
    db $A1, $2F ; duty $2F
    db $42, $30 ; note D4 dur 48
    db $FF, $FF ; end

; sound track, 5 events after the header (E-0019: grammar C2, meaning C0)
Data_042_709D:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $13, $03 ; note D#1 dur 3
    db $37, $06 ; note G3 dur 6
    db $A0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $FF, $FF ; end

; sound track, 13 events after the header (E-0019: grammar C2, meaning C0)
Data_042_70AB:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $17 ; header: param=0 byte1=$00 volume=$0F byte3=$17
    db $18, $12 ; note G#1 dur 18
    db $A1, $2F ; duty $2F
    db $6B, $12 ; note B6 dur 18
    db $A1, $17 ; duty $17
    db $1F, $01 ; rest-note $1F dur 1
    db $18, $12 ; note G#1 dur 18
    db $A1, $2F ; duty $2F
    db $6B, $12 ; note B6 dur 18
    db $A0, $06 ; volume $06
    db $6B, $12 ; note B6 dur 18
    db $A0, $02 ; volume $02
    db $6B, $12 ; note B6 dur 18
    db $FF, $FF ; end

; sound track, 68 events after the header (E-0019: grammar C2, meaning C0)
Data_042_70C9:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0C, $17 ; header: param=0 byte1=$00 volume=$0C byte3=$17
    db $FD, $F0 ; label 0
    db $15, $01 ; note F1 dur 1
    db $17, $01 ; note G1 dur 1
    db $19, $01 ; note A1 dur 1
    db $20, $01 ; note C2 dur 1
    db $23, $01 ; note D#2 dur 1
    db $25, $01 ; note F2 dur 1
    db $27, $01 ; note G2 dur 1
    db $29, $01 ; note A2 dur 1
    db $2B, $01 ; note B2 dur 1
    db $30, $01 ; note C3 dur 1
    db $33, $01 ; note D#3 dur 1
    db $35, $01 ; note F3 dur 1
    db $37, $01 ; note G3 dur 1
    db $39, $01 ; note A3 dur 1
    db $3B, $01 ; note B3 dur 1
    db $40, $01 ; note C4 dur 1
    db $42, $01 ; note D4 dur 1
    db $44, $01 ; note E4 dur 1
    db $46, $01 ; note F#4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $4B, $01 ; note B4 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $49, $01 ; note A4 dur 1
    db $47, $01 ; note G4 dur 1
    db $45, $01 ; note F4 dur 1
    db $43, $01 ; note D#4 dur 1
    db $41, $01 ; note C#4 dur 1
    db $3B, $01 ; note B3 dur 1
    db $39, $01 ; note A3 dur 1
    db $37, $01 ; note G3 dur 1
    db $35, $01 ; note F3 dur 1
    db $33, $01 ; note D#3 dur 1
    db $30, $01 ; note C3 dur 1
    db $B1, $F0 ; repeat $F0
    db $A0, $04 ; volume $04
    db $52, $01 ; note D5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $49, $01 ; note A4 dur 1
    db $47, $01 ; note G4 dur 1
    db $45, $01 ; note F4 dur 1
    db $43, $01 ; note D#4 dur 1
    db $41, $01 ; note C#4 dur 1
    db $3B, $01 ; note B3 dur 1
    db $39, $01 ; note A3 dur 1
    db $37, $01 ; note G3 dur 1
    db $35, $01 ; note F3 dur 1
    db $33, $01 ; note D#3 dur 1
    db $30, $01 ; note C3 dur 1
    db $A0, $02 ; volume $02
    db $52, $01 ; note D5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $49, $01 ; note A4 dur 1
    db $47, $01 ; note G4 dur 1
    db $45, $01 ; note F4 dur 1
    db $43, $01 ; note D#4 dur 1
    db $41, $01 ; note C#4 dur 1
    db $3B, $01 ; note B3 dur 1
    db $39, $01 ; note A3 dur 1
    db $37, $01 ; note G3 dur 1
    db $35, $01 ; note F3 dur 1
    db $33, $01 ; note D#3 dur 1
    db $30, $01 ; note C3 dur 1
    db $1F, $10 ; rest-note $1F dur 16
    db $FF, $FF ; end

; sound track, 4 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7155:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $07, $00 ; header: param=0 byte1=$02 volume=$07 byte3=$00
    db $57, $02 ; note G5 dur 2
    db $A0, $02 ; volume $02
    db $57, $04 ; note G5 dur 4
    db $FF, $FF ; end

; sound track, 2 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7161:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $30, $01 ; note C3 dur 1
    db $FF, $FF ; end

; sound track, 2 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7169:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $29, $01 ; note A2 dur 1
    db $FF, $FF ; end

; sound track, 15 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7171:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $50, $02 ; note C5 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $56, $02 ; note F#5 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $50, $02 ; note C5 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $56, $02 ; note F#5 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $50, $02 ; note C5 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $56, $02 ; note F#5 dur 2
    db $A0, $02 ; volume $02
    db $56, $04 ; note F#5 dur 4
    db $FF ; end

; sound track, 164 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7192:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $A3, $20 ; mod $20
    db $FD, $F0 ; label 0
    db $A2, $02 ; duty2 $02
    db $A0, $05 ; volume $05
    db $A5, $FF ; pan $FF
    db $1F, $08 ; rest-note $1F dur 8
    db $58, $01 ; note G#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $5B, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $5B, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $4A, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $A5, $F0 ; pan $F0
    db $1F, $10 ; rest-note $1F dur 16
    db $5A, $01 ; note A#5 dur 1
    db $5B, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $5B, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $59, $01 ; note A5 dur 1
    db $60, $01 ; note C6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $63, $01 ; note D#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $62, $01 ; note D6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $4A, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $1F, $22 ; rest-note $1F dur 34
    db $A5, $0F ; pan $0F
    db $64, $01 ; note E6 dur 1
    db $63, $01 ; note D#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $4A, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $1F, $1C ; rest-note $1F dur 28
    db $A5, $F0 ; pan $F0
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $54, $01 ; note E5 dur 1
    db $55, $01 ; note F5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $4A, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $1F, $1D ; rest-note $1F dur 29
    db $A2, $01 ; duty2 $01
    db $A0, $0A ; volume $0A
    db $A5, $F0 ; pan $F0
    db $68, $01 ; note G#6 dur 1
    db $69, $01 ; note A6 dur 1
    db $6A, $01 ; note A#6 dur 1
    db $6B, $01 ; note B6 dur 1
    db $6A, $01 ; note A#6 dur 1
    db $69, $01 ; note A6 dur 1
    db $68, $01 ; note G#6 dur 1
    db $67, $01 ; note G6 dur 1
    db $66, $01 ; note F#6 dur 1
    db $65, $01 ; note F6 dur 1
    db $64, $01 ; note E6 dur 1
    db $63, $01 ; note D#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $4A, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $B0, $F0 ; jump $F0
    db $FF ; end

; sound track, 168 events after the header (E-0019: grammar C2, meaning C0)
Data_042_72DD:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $A2, $02 ; duty2 $02
    db $FD, $F0 ; label 0
    db $A0, $0F ; volume $0F
    db $A5, $FF ; pan $FF
    db $58, $01 ; note G#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $5B, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $5B, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $4A, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $A5, $F0 ; pan $F0
    db $1F, $10 ; rest-note $1F dur 16
    db $5A, $01 ; note A#5 dur 1
    db $5B, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $5B, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $59, $01 ; note A5 dur 1
    db $60, $01 ; note C6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $63, $01 ; note D#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $62, $01 ; note D6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $4A, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $1F, $22 ; rest-note $1F dur 34
    db $A0, $0D ; volume $0D
    db $A5, $0F ; pan $0F
    db $64, $01 ; note E6 dur 1
    db $63, $01 ; note D#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $4A, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $1F, $1C ; rest-note $1F dur 28
    db $A0, $0F ; volume $0F
    db $A5, $F0 ; pan $F0
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $54, $01 ; note E5 dur 1
    db $55, $01 ; note F5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $4A, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $1F, $09 ; rest-note $1F dur 9
    db $A0, $0C ; volume $0C
    db $A5, $0F ; pan $0F
    db $5A, $01 ; note A#5 dur 1
    db $5B, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $63, $01 ; note D#6 dur 1
    db $64, $01 ; note E6 dur 1
    db $65, $01 ; note F6 dur 1
    db $66, $01 ; note F#6 dur 1
    db $65, $01 ; note F6 dur 1
    db $64, $01 ; note E6 dur 1
    db $63, $01 ; note D#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $60, $01 ; note C6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5B, $01 ; note B5 dur 1
    db $5A, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4B, $01 ; note B4 dur 1
    db $4A, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $47, $01 ; note G4 dur 1
    db $46, $01 ; note F#4 dur 1
    db $45, $01 ; note F4 dur 1
    db $44, $01 ; note E4 dur 1
    db $1F, $18 ; rest-note $1F dur 24
    db $B0, $F0 ; jump $F0
    db $FF ; end

; sound track, 7 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7430:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $A3, $3A ; mod $3A
    db $FD, $F0 ; label 0
    db $21, $60 ; note C#2 dur 96
    db $30, $60 ; note C3 dur 96
    db $21, $44 ; note C#2 dur 68
    db $B0, $F0 ; jump $F0
    db $FF ; end

; sound track, 6 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7441:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0C, $2A ; header: param=0 byte1=$02 volume=$0C byte3=$2A
    db $FD, $F0 ; label 0
    db $10, $05 ; note C1 dur 5
    db $11, $05 ; note C#1 dur 5
    db $12, $04 ; note D1 dur 4
    db $B0, $F0 ; jump $F0
    db $FF, $FF ; end

; sound track, 10 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7451:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0C, $00 ; header: param=0 byte1=$00 volume=$0C byte3=$00
    db $FD, $F0 ; label 0
    db $61, $03 ; note C#6 dur 3
    db $52, $20 ; note D5 dur 32
    db $C1, $7F ; env $7F
    db $52, $05 ; note D5 dur 5
    db $B0, $F0 ; jump $F0
    db $22, $20 ; note D2 dur 32
    db $A0, $05 ; volume $05
    db $22, $28 ; note D2 dur 40
    db $FF, $FF ; end

; sound track, 8 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7469:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $27 ; header: param=0 byte1=$00 volume=$0F byte3=$27
    db $17, $05 ; note G1 dur 5
    db $1F, $02 ; rest-note $1F dur 2
    db $A1, $45 ; duty $45
    db $20, $06 ; note C2 dur 6
    db $A0, $06 ; volume $06
    db $22, $06 ; note D2 dur 6
    db $1F, $03 ; rest-note $1F dur 3
    db $FF, $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_042_747D:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $5D, $02 ; rest-note $5D dur 2
    db $71, $03 ; note C#7 dur 3
    db $1F, $02 ; rest-note $1F dur 2
    db $60, $05 ; note C6 dur 5
    db $A0, $06 ; volume $06
    db $60, $05 ; note C6 dur 5
    db $A0, $03 ; volume $03
    db $60, $05 ; note C6 dur 5
    db $FF, $FF ; end

; sound track, 20 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7493:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $15 ; header: param=0 byte1=$00 volume=$0F byte3=$15
    db $20, $02 ; note C2 dur 2
    db $20, $02 ; note C2 dur 2
    db $20, $02 ; note C2 dur 2
    db $20, $02 ; note C2 dur 2
    db $30, $03 ; note C3 dur 3
    db $34, $03 ; note E3 dur 3
    db $A1, $27 ; duty $27
    db $30, $05 ; note C3 dur 5
    db $1F, $01 ; rest-note $1F dur 1
    db $42, $03 ; note D4 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $0B ; volume $0B
    db $42, $05 ; note D4 dur 5
    db $A0, $03 ; volume $03
    db $1F, $01 ; rest-note $1F dur 1
    db $43, $05 ; note D#4 dur 5
    db $A0, $01 ; volume $01
    db $1F, $01 ; rest-note $1F dur 1
    db $43, $05 ; note D#4 dur 5
    db $FF, $FF ; end

; sound track, 20 events after the header (E-0019: grammar C2, meaning C0)
Data_042_74BF:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $FD, $F0 ; label 0
    db $50, $01 ; note C5 dur 1
    db $1F, $02 ; rest-note $1F dur 2
    db $B3, $F0 ; repeat $F0
    db $A0, $0B ; volume $0B
    db $50, $01 ; note C5 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $50, $01 ; note C5 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $09 ; volume $09
    db $50, $01 ; note C5 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $50, $01 ; note C5 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $05 ; volume $05
    db $50, $01 ; note C5 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $50, $01 ; note C5 dur 1
    db $1F, $12 ; rest-note $1F dur 18
    db $FF, $FF ; end

; sound track, 14 events after the header (E-0019: grammar C2, meaning C0)
Data_042_74EB:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $FD, $F0 ; label 0
    db $A0, $0A ; volume $0A
    db $CC, $6F ; env $6F
    db $12, $80 ; note D1 dur 128
    db $A0, $0B ; volume $0B
    db $C1, $7F ; env $7F
    db $12, $30 ; note D1 dur 48
    db $C0, $FE ; env $FE
    db $A0, $08 ; volume $08
    db $11, $80 ; note C#1 dur 128
    db $C1, $7F ; env $7F
    db $11, $2A ; note C#1 dur 42
    db $B0, $F0 ; jump $F0
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_750B:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 10 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7511:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $1E, $01 ; rest-note $1E dur 1
    db $1F, $03 ; rest-note $1F dur 3
    db $A0, $06 ; volume $06
    db $1E, $01 ; rest-note $1E dur 1
    db $A0, $0F ; volume $0F
    db $1D, $01 ; rest-note $1D dur 1
    db $25, $01 ; note F2 dur 1
    db $A0, $03 ; volume $03
    db $1C, $02 ; rest-note $1C dur 2
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7529:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 13 events after the header (E-0019: grammar C2, meaning C0)
Data_042_752F:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $C2, $40 ; env $40
    db $AE, $10 ; tuning $10
    db $30, $05 ; note C3 dur 5
    db $AE, $00 ; tuning $00
    db $33, $05 ; note D#3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $34, $05 ; note E3 dur 5
    db $32, $05 ; note D3 dur 5
    db $35, $05 ; note F3 dur 5
    db $36, $05 ; note F#3 dur 5
    db $A0, $04 ; volume $04
    db $36, $0A ; note F#3 dur 10
    db $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_042_754C:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $12, $02 ; note D1 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $C7, $30 ; env $30
    db $10, $18 ; note C1 dur 24
    db $A0, $07 ; volume $07
    db $10, $10 ; note C1 dur 16
    db $A0, $05 ; volume $05
    db $10, $20 ; note C1 dur 32
    db $FF ; end

; sound track, 10 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7561:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $45, $02 ; note F4 dur 2
    db $46, $02 ; note F#4 dur 2
    db $44, $02 ; note E4 dur 2
    db $45, $02 ; note F4 dur 2
    db $46, $02 ; note F#4 dur 2
    db $44, $02 ; note E4 dur 2
    db $A0, $07 ; volume $07
    db $46, $02 ; note F#4 dur 2
    db $44, $02 ; note E4 dur 2
    db $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7578:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $FD, $F0 ; label 0
    db $33, $02 ; note D#3 dur 2
    db $62, $03 ; note D6 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $42, $02 ; note D4 dur 2
    db $51, $02 ; note C#5 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $B0, $F0 ; jump $F0
    db $FF ; end

; sound track, 22 events after the header (E-0019: grammar C2, meaning C0)
Data_042_758D:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $10, $03 ; note C1 dur 3
    db $17, $03 ; note G1 dur 3
    db $20, $03 ; note C2 dur 3
    db $22, $02 ; note D2 dur 2
    db $24, $02 ; note E2 dur 2
    db $25, $02 ; note F2 dur 2
    db $27, $02 ; note G2 dur 2
    db $29, $02 ; note A2 dur 2
    db $2A, $02 ; note A#2 dur 2
    db $30, $02 ; note C3 dur 2
    db $32, $02 ; note D3 dur 2
    db $34, $02 ; note E3 dur 2
    db $35, $02 ; note F3 dur 2
    db $37, $02 ; note G3 dur 2
    db $39, $02 ; note A3 dur 2
    db $3A, $02 ; note A#3 dur 2
    db $C1, $30 ; env $30
    db $40, $15 ; note C4 dur 21
    db $A0, $05 ; volume $05
    db $40, $10 ; note C4 dur 16
    db $1F, $03 ; rest-note $1F dur 3
    db $FF, $FF ; end

; sound track, 21 events after the header (E-0019: grammar C2, meaning C0)
Data_042_75BD:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $05, $00 ; header: param=0 byte1=$02 volume=$05 byte3=$00
    db $1F, $03 ; rest-note $1F dur 3
    db $10, $03 ; note C1 dur 3
    db $17, $03 ; note G1 dur 3
    db $20, $03 ; note C2 dur 3
    db $22, $02 ; note D2 dur 2
    db $24, $02 ; note E2 dur 2
    db $25, $02 ; note F2 dur 2
    db $27, $02 ; note G2 dur 2
    db $29, $02 ; note A2 dur 2
    db $2A, $02 ; note A#2 dur 2
    db $30, $02 ; note C3 dur 2
    db $32, $02 ; note D3 dur 2
    db $34, $02 ; note E3 dur 2
    db $35, $02 ; note F3 dur 2
    db $37, $02 ; note G3 dur 2
    db $39, $02 ; note A3 dur 2
    db $3A, $02 ; note A#3 dur 2
    db $C1, $40 ; env $40
    db $A3, $0D ; mod $0D
    db $40, $25 ; note C4 dur 37
    db $FF, $FF ; end

; sound track, 11 events after the header (E-0019: grammar C2, meaning C0)
Data_042_75EB:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $32, $02 ; note D3 dur 2
    db $2B, $02 ; note B2 dur 2
    db $33, $02 ; note D#3 dur 2
    db $32, $02 ; note D3 dur 2
    db $2B, $02 ; note B2 dur 2
    db $33, $02 ; note D#3 dur 2
    db $A0, $07 ; volume $07
    db $33, $02 ; note D#3 dur 2
    db $2B, $02 ; note B2 dur 2
    db $33, $02 ; note D#3 dur 2
    db $FF ; end

; sound track, 6 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7604:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $50, $04 ; note C5 dur 4
    db $51, $04 ; note C#5 dur 4
    db $61, $03 ; note C#6 dur 3
    db $A0, $03 ; volume $03
    db $50, $03 ; note C5 dur 3
    db $FF ; end

; sound track, 12 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7613:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $47, $04 ; note G4 dur 4
    db $1F, $02 ; rest-note $1F dur 2
    db $43, $03 ; note D#4 dur 3
    db $1F, $02 ; rest-note $1F dur 2
    db $47, $04 ; note G4 dur 4
    db $1F, $02 ; rest-note $1F dur 2
    db $43, $04 ; note D#4 dur 4
    db $1F, $02 ; rest-note $1F dur 2
    db $44, $04 ; note E4 dur 4
    db $1F, $02 ; rest-note $1F dur 2
    db $34, $04 ; note E3 dur 4
    db $FF ; end

; sound track, 8 events after the header (E-0019: grammar C2, meaning C0)
Data_042_762E:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $50, $02 ; note C5 dur 2
    db $33, $06 ; note D#3 dur 6
    db $50, $02 ; note C5 dur 2
    db $33, $06 ; note D#3 dur 6
    db $50, $02 ; note C5 dur 2
    db $33, $06 ; note D#3 dur 6
    db $60, $03 ; note C6 dur 3
    db $FF ; end

; sound track, 6 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7641:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $3B, $04 ; note B3 dur 4
    db $39, $04 ; note A3 dur 4
    db $35, $04 ; note F3 dur 4
    db $A0, $07 ; volume $07
    db $35, $05 ; note F3 dur 5
    db $FF ; end

; sound track, 29 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7650:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $45, $02 ; note F4 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $A0, $0B ; volume $0B
    db $45, $02 ; note F4 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $A0, $09 ; volume $09
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $A0, $05 ; volume $05
    db $45, $02 ; note F4 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $A0, $03 ; volume $03
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $FF ; end

; sound track, 12 events after the header (E-0019: grammar C2, meaning C0)
Data_042_768D:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $26 ; header: param=0 byte1=$02 volume=$0F byte3=$26
    db $A0, $0F ; volume $0F
    db $0A, $14 ; note A#0 dur 20
    db $A1, $00 ; duty $00
    db $C1, $7F ; env $7F
    db $A0, $0E ; volume $0E
    db $AE, $10 ; tuning $10
    db $15, $20 ; note F1 dur 32
    db $A0, $07 ; volume $07
    db $15, $1A ; note F1 dur 26
    db $A0, $03 ; volume $03
    db $15, $25 ; note F1 dur 37
    db $FF, $FF ; end

; sound track, 11 events after the header (E-0019: grammar C2, meaning C0)
Data_042_76A9:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $2E ; header: param=0 byte1=$02 volume=$0F byte3=$2E
    db $47, $05 ; note G4 dur 5
    db $44, $07 ; note E4 dur 7
    db $A0, $0C ; volume $0C
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $A0, $0A ; volume $0A
    db $35, $06 ; note F3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $A0, $07 ; volume $07
    db $2B, $05 ; note B2 dur 5
    db $FF ; end

; sound track, 68 events after the header (E-0019: grammar C2, meaning C0)
Data_042_76C2:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $1F ; header: param=0 byte1=$02 volume=$0F byte3=$1F
    db $A0, $0F ; volume $0F
    db $A1, $1F ; duty $1F
    db $38, $04 ; note G#3 dur 4
    db $A1, $17 ; duty $17
    db $A0, $0E ; volume $0E
    db $33, $03 ; note D#3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $0E ; volume $0E
    db $A1, $1F ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $A1, $17 ; duty $17
    db $A0, $0C ; volume $0C
    db $33, $03 ; note D#3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $0D ; volume $0D
    db $A1, $1F ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $A1, $17 ; duty $17
    db $A0, $0B ; volume $0B
    db $33, $03 ; note D#3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $0C ; volume $0C
    db $A1, $1F ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $A1, $17 ; duty $17
    db $A0, $0A ; volume $0A
    db $33, $03 ; note D#3 dur 3
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $0A ; volume $0A
    db $A1, $1F ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $A1, $17 ; duty $17
    db $A0, $08 ; volume $08
    db $33, $03 ; note D#3 dur 3
    db $A0, $09 ; volume $09
    db $A1, $1F ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $A1, $17 ; duty $17
    db $A0, $07 ; volume $07
    db $33, $03 ; note D#3 dur 3
    db $A0, $08 ; volume $08
    db $A1, $1F ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $A1, $17 ; duty $17
    db $A0, $06 ; volume $06
    db $33, $03 ; note D#3 dur 3
    db $A0, $06 ; volume $06
    db $A1, $1F ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $A1, $17 ; duty $17
    db $A0, $05 ; volume $05
    db $33, $03 ; note D#3 dur 3
    db $A0, $04 ; volume $04
    db $A1, $1F ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $A1, $17 ; duty $17
    db $33, $03 ; note D#3 dur 3
    db $A0, $02 ; volume $02
    db $A1, $1F ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $A1, $17 ; duty $17
    db $33, $03 ; note D#3 dur 3
    db $A0, $01 ; volume $01
    db $A1, $1F ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $A1, $17 ; duty $17
    db $33, $03 ; note D#3 dur 3
    db $FF, $FF ; end

; sound track, 41 events after the header (E-0019: grammar C2, meaning C0)
Data_042_774E:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $23 ; header: param=0 byte1=$00 volume=$0F byte3=$23
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $01 ; note F#1 dur 1
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $0C ; volume $0C
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $01 ; note F#1 dur 1
    db $A0, $0A ; volume $0A
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $09 ; volume $09
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $07 ; volume $07
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $AE, $10 ; tuning $10
    db $A0, $04 ; volume $04
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $01 ; note F#1 dur 1
    db $AE, $10 ; tuning $10
    db $18, $01 ; note G#1 dur 1
    db $AE, $10 ; tuning $10
    db $1B, $01 ; note B1 dur 1
    db $17, $01 ; note G1 dur 1
    db $16, $01 ; note F#1 dur 1
    db $AE, $00 ; tuning $00
    db $FF, $FF ; end

; sound track, 5 events after the header (E-0019: grammar C2, meaning C0)
Data_042_77A4:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $27, $02 ; note G2 dur 2
    db $27, $02 ; note G2 dur 2
    db $A0, $05 ; volume $05
    db $27, $08 ; note G2 dur 8
    db $FF, $FF ; end

; sound track, 74 events after the header (E-0019: grammar C2, meaning C0)
Data_042_77B2:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $23 ; header: param=0 byte1=$00 volume=$0F byte3=$23
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $01 ; note F#1 dur 1
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $0C ; volume $0C
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $01 ; note F#1 dur 1
    db $A0, $0A ; volume $0A
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $09 ; volume $09
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $07 ; volume $07
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $AE, $10 ; tuning $10
    db $18, $02 ; note G#1 dur 2
    db $AE, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $AE, $10 ; tuning $10
    db $20, $02 ; note C2 dur 2
    db $1F, $15 ; rest-note $1F dur 21
    db $A2, $01 ; duty2 $01
    db $A1, $1D ; duty $1D
    db $A0, $0F ; volume $0F
    db $23, $01 ; note D#2 dur 1
    db $21, $01 ; note C#2 dur 1
    db $22, $01 ; note D2 dur 1
    db $39, $02 ; note A3 dur 2
    db $37, $02 ; note G3 dur 2
    db $36, $02 ; note F#3 dur 2
    db $35, $02 ; note F3 dur 2
    db $34, $02 ; note E3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $32, $02 ; note D3 dur 2
    db $31, $02 ; note C#3 dur 2
    db $31, $02 ; note C#3 dur 2
    db $3B, $02 ; note B3 dur 2
    db $2A, $02 ; note A#2 dur 2
    db $29, $02 ; note A2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $27, $02 ; note G2 dur 2
    db $26, $02 ; note F#2 dur 2
    db $25, $02 ; note F2 dur 2
    db $24, $02 ; note E2 dur 2
    db $23, $02 ; note D#2 dur 2
    db $22, $02 ; note D2 dur 2
    db $21, $02 ; note C#2 dur 2
    db $20, $02 ; note C2 dur 2
    db $1A, $02 ; note A#1 dur 2
    db $A0, $06 ; volume $06
    db $18, $02 ; note G#1 dur 2
    db $16, $02 ; note F#1 dur 2
    db $14, $02 ; note E1 dur 2
    db $12, $02 ; note D1 dur 2
    db $10, $02 ; note C1 dur 2
    db $0A, $02 ; note A#0 dur 2
    db $08, $02 ; note G#0 dur 2
    db $06, $02 ; note F#0 dur 2
    db $FF, $FF ; end
    db $FF, $FF ; end

; sound track, 5 events after the header (E-0019: grammar C2, meaning C0)
Data_042_784A:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $27, $02 ; note G2 dur 2
    db $27, $02 ; note G2 dur 2
    db $A0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $FF, $FF ; end

; sound track, 107 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7858:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $23 ; header: param=0 byte1=$00 volume=$0F byte3=$23
    db $AE, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $AE, $00 ; tuning $00
    db $19, $01 ; note A1 dur 1
    db $AE, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $AE, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $AE, $10 ; tuning $10
    db $22, $01 ; note D2 dur 1
    db $AE, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $09 ; volume $09
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $07 ; volume $07
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A2, $01 ; duty2 $01
    db $A1, $1D ; duty $1D
    db $A0, $0F ; volume $0F
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $24, $01 ; note E2 dur 1
    db $AE, $10 ; tuning $10
    db $22, $01 ; note D2 dur 1
    db $AE, $00 ; tuning $00
    db $20, $02 ; note C2 dur 2
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $AE, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $AE, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $AE, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $AE, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $AE, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $AE, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $AE, $00 ; tuning $00
    db $22, $02 ; note D2 dur 2
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $AE, $00 ; tuning $00
    db $22, $02 ; note D2 dur 2
    db $AE, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $AE, $00 ; tuning $00
    db $22, $02 ; note D2 dur 2
    db $AE, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $AE, $00 ; tuning $00
    db $22, $02 ; note D2 dur 2
    db $AE, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $AE, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $AE, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $AE, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $AE, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $AE, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $AE, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $AE, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $AE, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $AE, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $AE, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $A0, $09 ; volume $09
    db $AE, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $AE, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $AE, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $AE, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $AE, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $AE, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $AE, $10 ; tuning $10
    db $06, $02 ; note F#0 dur 2
    db $FF, $FF ; end

; sound track, 5 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7932:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $37, $02 ; note G3 dur 2
    db $37, $02 ; note G3 dur 2
    db $A0, $08 ; volume $08
    db $37, $06 ; note G3 dur 6
    db $FF, $FF ; end

; sound track, 201 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7940:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $1D ; header: param=0 byte1=$01 volume=$0F byte3=$1D
    db $A2, $01 ; duty2 $01
    db $A1, $1D ; duty $1D
    db $AE, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $AE, $00 ; tuning $00
    db $19, $01 ; note A1 dur 1
    db $AE, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $AE, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $AE, $10 ; tuning $10
    db $22, $01 ; note D2 dur 1
    db $AE, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $09 ; volume $09
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $07 ; volume $07
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A1, $1B ; duty $1B
    db $A0, $0F ; volume $0F
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $AE, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $AE, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $AE, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $AE, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $AE, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $AE, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $A1, $1C ; duty $1C
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $A1, $1D ; duty $1D
    db $A0, $0F ; volume $0F
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $AE, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $AE, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $AE, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $AE, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $AE, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $AE, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $09 ; volume $09
    db $AE, $10 ; tuning $10
    db $2A, $01 ; note A#2 dur 1
    db $AE, $00 ; tuning $00
    db $2B, $02 ; note B2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $A0, $06 ; volume $06
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $A0, $03 ; volume $03
    db $AE, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $A0, $02 ; volume $02
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $FF, $FF ; end

; sound track, 19 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7AD6:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $11, $02 ; note C#1 dur 2
    db $45, $03 ; note F4 dur 3
    db $15, $01 ; note F1 dur 1
    db $50, $03 ; note C5 dur 3
    db $45, $03 ; note F4 dur 3
    db $16, $01 ; note F#1 dur 1
    db $45, $02 ; note F4 dur 2
    db $55, $02 ; note F5 dur 2
    db $14, $01 ; note E1 dur 1
    db $45, $02 ; note F4 dur 2
    db $45, $06 ; note F4 dur 6
    db $45, $03 ; note F4 dur 3
    db $46, $04 ; note F#4 dur 4
    db $45, $06 ; note F4 dur 6
    db $A0, $06 ; volume $06
    db $45, $05 ; note F4 dur 5
    db $A0, $04 ; volume $04
    db $45, $05 ; note F4 dur 5
    db $FF, $FF ; end

; sound track, 22 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7B00:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $17 ; header: param=0 byte1=$00 volume=$0F byte3=$17
    db $A0, $08 ; volume $08
    db $23, $02 ; note D#2 dur 2
    db $24, $02 ; note E2 dur 2
    db $25, $02 ; note F2 dur 2
    db $26, $02 ; note F#2 dur 2
    db $A0, $0B ; volume $0B
    db $27, $02 ; note G2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $29, $02 ; note A2 dur 2
    db $2A, $02 ; note A#2 dur 2
    db $A0, $0D ; volume $0D
    db $2B, $02 ; note B2 dur 2
    db $30, $02 ; note C3 dur 2
    db $31, $02 ; note C#3 dur 2
    db $32, $02 ; note D3 dur 2
    db $33, $03 ; note D#3 dur 3
    db $34, $02 ; note E3 dur 2
    db $35, $02 ; note F3 dur 2
    db $A0, $09 ; volume $09
    db $35, $02 ; note F3 dur 2
    db $A0, $0F ; volume $0F
    db $FF, $FF ; end

; sound track, 32 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7B30:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $1F, $20 ; rest-note $1F dur 32
    db $11, $02 ; note C#1 dur 2
    db $45, $03 ; note F4 dur 3
    db $15, $01 ; note F1 dur 1
    db $50, $03 ; note C5 dur 3
    db $45, $03 ; note F4 dur 3
    db $16, $01 ; note F#1 dur 1
    db $45, $02 ; note F4 dur 2
    db $55, $02 ; note F5 dur 2
    db $14, $01 ; note E1 dur 1
    db $45, $02 ; note F4 dur 2
    db $45, $06 ; note F4 dur 6
    db $A0, $0B ; volume $0B
    db $45, $05 ; note F4 dur 5
    db $45, $05 ; note F4 dur 5
    db $A0, $0E ; volume $0E
    db $55, $02 ; note F5 dur 2
    db $14, $01 ; note E1 dur 1
    db $45, $02 ; note F4 dur 2
    db $45, $06 ; note F4 dur 6
    db $A0, $06 ; volume $06
    db $45, $05 ; note F4 dur 5
    db $45, $05 ; note F4 dur 5
    db $A0, $08 ; volume $08
    db $55, $02 ; note F5 dur 2
    db $14, $01 ; note E1 dur 1
    db $45, $02 ; note F4 dur 2
    db $45, $06 ; note F4 dur 6
    db $45, $05 ; note F4 dur 5
    db $A0, $04 ; volume $04
    db $45, $05 ; note F4 dur 5
    db $FF, $FF ; end

; sound track, 11 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7B74:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C3, $07 ; env $07
    db $21, $05 ; note C#2 dur 5
    db $23, $05 ; note D#2 dur 5
    db $C0, $FE ; env $FE
    db $23, $05 ; note D#2 dur 5
    db $22, $08 ; note D2 dur 8
    db $22, $07 ; note D2 dur 7
    db $A0, $08 ; volume $08
    db $C7, $30 ; env $30
    db $22, $20 ; note D2 dur 32
    db $FF, $FF ; end

; sound track, 18 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7B8E:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $11, $06 ; note C#1 dur 6
    db $13, $04 ; note D#1 dur 4
    db $22, $03 ; note D2 dur 3
    db $23, $04 ; note D#2 dur 4
    db $23, $07 ; note D#2 dur 7
    db $22, $07 ; note D2 dur 7
    db $12, $07 ; note D1 dur 7
    db $11, $18 ; note C#1 dur 24
    db $A0, $0B ; volume $0B
    db $11, $10 ; note C#1 dur 16
    db $A0, $0E ; volume $0E
    db $11, $10 ; note C#1 dur 16
    db $A0, $0A ; volume $0A
    db $11, $08 ; note C#1 dur 8
    db $C1, $20 ; env $20
    db $A0, $06 ; volume $06
    db $11, $20 ; note C#1 dur 32
    db $FF, $FF ; end

; sound track, 65 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7BB6:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $14 ; header: param=0 byte1=$00 volume=$0F byte3=$14
    db $AE, $10 ; tuning $10
    db $30, $02 ; note C3 dur 2
    db $2B, $03 ; note B2 dur 3
    db $1F, $02 ; rest-note $1F dur 2
    db $28, $03 ; note G#2 dur 3
    db $2B, $03 ; note B2 dur 3
    db $1F, $02 ; rest-note $1F dur 2
    db $2B, $04 ; note B2 dur 4
    db $1F, $02 ; rest-note $1F dur 2
    db $28, $02 ; note G#2 dur 2
    db $1A, $03 ; note A#1 dur 3
    db $2F, $01 ; rest-note $2F dur 1
    db $1A, $03 ; note A#1 dur 3
    db $1F, $02 ; rest-note $1F dur 2
    db $29, $01 ; note A2 dur 1
    db $18, $02 ; note G#1 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $27, $01 ; note G2 dur 1
    db $17, $02 ; note G1 dur 2
    db $26, $01 ; note F#2 dur 1
    db $25, $02 ; note F2 dur 2
    db $24, $01 ; note E2 dur 1
    db $23, $02 ; note D#2 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $22, $01 ; note D2 dur 1
    db $21, $02 ; note C#2 dur 2
    db $20, $01 ; note C2 dur 1
    db $1B, $01 ; note B1 dur 1
    db $1A, $01 ; note A#1 dur 1
    db $19, $01 ; note A1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $17, $01 ; note G1 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $16, $01 ; note F#1 dur 1
    db $15, $01 ; note F1 dur 1
    db $14, $01 ; note E1 dur 1
    db $A0, $08 ; volume $08
    db $1F, $01 ; rest-note $1F dur 1
    db $15, $01 ; note F1 dur 1
    db $17, $01 ; note G1 dur 1
    db $19, $01 ; note A1 dur 1
    db $A0, $06 ; volume $06
    db $1F, $02 ; rest-note $1F dur 2
    db $18, $01 ; note G#1 dur 1
    db $1B, $01 ; note B1 dur 1
    db $17, $01 ; note G1 dur 1
    db $1A, $01 ; note A#1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1B, $02 ; note B1 dur 2
    db $14, $01 ; note E1 dur 1
    db $A0, $04 ; volume $04
    db $1F, $02 ; rest-note $1F dur 2
    db $18, $01 ; note G#1 dur 1
    db $1B, $01 ; note B1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1F, $02 ; rest-note $1F dur 2
    db $1A, $01 ; note A#1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1F, $02 ; rest-note $1F dur 2
    db $14, $01 ; note E1 dur 1
    db $19, $01 ; note A1 dur 1
    db $1B, $01 ; note B1 dur 1
    db $19, $01 ; note A1 dur 1
    db $1A, $01 ; note A#1 dur 1
    db $FF, $FF ; end

; sound track, 20 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7C3C:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $21, $08 ; note C#2 dur 8
    db $31, $05 ; note C#3 dur 5
    db $20, $05 ; note C2 dur 5
    db $10, $03 ; note C1 dur 3
    db $20, $04 ; note C2 dur 4
    db $40, $05 ; note C4 dur 5
    db $40, $05 ; note C4 dur 5
    db $30, $03 ; note C3 dur 3
    db $23, $05 ; note D#2 dur 5
    db $40, $06 ; note C4 dur 6
    db $21, $08 ; note C#2 dur 8
    db $30, $04 ; note C3 dur 4
    db $21, $05 ; note C#2 dur 5
    db $30, $05 ; note C3 dur 5
    db $21, $02 ; note C#2 dur 2
    db $20, $07 ; note C2 dur 7
    db $A0, $08 ; volume $08
    db $C1, $20 ; env $20
    db $20, $08 ; note C2 dur 8
    db $FF, $FF ; end

; sound track, 10 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7C68:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $20, $07 ; note C2 dur 7
    db $12, $08 ; note D1 dur 8
    db $11, $08 ; note C#1 dur 8
    db $1F, $01 ; rest-note $1F dur 1
    db $50, $04 ; note C5 dur 4
    db $60, $10 ; note C6 dur 16
    db $C7, $20 ; env $20
    db $A0, $06 ; volume $06
    db $60, $20 ; note C6 dur 32
    db $FF, $FF ; end

; sound track, 11 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7C80:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $45, $02 ; note F4 dur 2
    db $11, $02 ; note C#1 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $C3, $20 ; env $20
    db $45, $10 ; note F4 dur 16
    db $30, $09 ; note C3 dur 9
    db $C7, $30 ; env $30
    db $50, $06 ; note C5 dur 6
    db $43, $08 ; note D#4 dur 8
    db $60, $20 ; note C6 dur 32
    db $FF, $FF ; end

; sound track, 12 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7C9A:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $15 ; header: param=0 byte1=$02 volume=$0F byte3=$15
    db $08, $06 ; note G#0 dur 6
    db $09, $04 ; note A0 dur 4
    db $10, $03 ; note C1 dur 3
    db $09, $05 ; note A0 dur 5
    db $A0, $06 ; volume $06
    db $10, $05 ; note C1 dur 5
    db $08, $04 ; note G#0 dur 4
    db $09, $05 ; note A0 dur 5
    db $A0, $04 ; volume $04
    db $09, $05 ; note A0 dur 5
    db $0B, $03 ; note B0 dur 3
    db $FF, $FF ; end

; sound track, 12 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7CB6:: ; heuristic: track stream of a sound record; C0
    db $00, $02, $0F, $7F ; header: param=0 byte1=$02 volume=$0F byte3=$7F
    db $12, $02 ; note D1 dur 2
    db $19, $04 ; note A1 dur 4
    db $12, $03 ; note D1 dur 3
    db $1A, $05 ; note A#1 dur 5
    db $10, $05 ; note C1 dur 5
    db $A0, $0C ; volume $0C
    db $10, $04 ; note C1 dur 4
    db $A0, $0A ; volume $0A
    db $10, $05 ; note C1 dur 5
    db $A0, $03 ; volume $03
    db $10, $05 ; note C1 dur 5
    db $FF, $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7CD2:: ; heuristic: track stream of a sound record; C0
    db $00, $01, $0F, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $A3, $17 ; mod $17
    db $4B, $01 ; note B4 dur 1
    db $49, $01 ; note A4 dur 1
    db $4A, $02 ; note A#4 dur 2
    db $4B, $18 ; note B4 dur 24
    db $C7, $30 ; env $30
    db $A3, $10 ; mod $10
    db $4B, $28 ; note B4 dur 40
    db $FF, $FF ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7CE8:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $FF, $FF ; end

; sound track, 16 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7CEE:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $C7, $30 ; env $30
    db $50, $02 ; note C5 dur 2
    db $A0, $0F ; volume $0F
    db $40, $02 ; note C4 dur 2
    db $12, $08 ; note D1 dur 8
    db $30, $02 ; note C3 dur 2
    db $12, $09 ; note D1 dur 9
    db $40, $02 ; note C4 dur 2
    db $12, $08 ; note D1 dur 8
    db $A0, $0F ; volume $0F
    db $40, $02 ; note C4 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $12, $0C ; note D1 dur 12
    db $A0, $06 ; volume $06
    db $12, $10 ; note D1 dur 16
    db $FF, $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7D12:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $43, $02 ; note D#4 dur 2
    db $50, $02 ; note C5 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $42, $07 ; note D4 dur 7
    db $A0, $08 ; volume $08
    db $42, $07 ; note D4 dur 7
    db $A0, $04 ; volume $04
    db $42, $07 ; note D4 dur 7
    db $FF, $FF ; end

; sound track, 152 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7D28:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $23 ; header: param=0 byte1=$00 volume=$0F byte3=$23
    db $AE, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $AE, $00 ; tuning $00
    db $19, $01 ; note A1 dur 1
    db $AE, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $AE, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $AE, $10 ; tuning $10
    db $22, $01 ; note D2 dur 1
    db $AE, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $09 ; volume $09
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A0, $07 ; volume $07
    db $AE, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $AE, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $A2, $01 ; duty2 $01
    db $A1, $1D ; duty $1D
    db $A0, $0F ; volume $0F
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $29, $01 ; note A2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $29, $01 ; note A2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $AE, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $AE, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $AE, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $29, $01 ; note A2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $29, $01 ; note A2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $29, $01 ; note A2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $29, $01 ; note A2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $A0, $09 ; volume $09
    db $AE, $10 ; tuning $10
    db $2A, $01 ; note A#2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $2B, $02 ; note B2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $AE, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $A0, $03 ; volume $03
    db $AE, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $AE, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $AE, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $FF, $FF ; end

; sound track, 6 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7E5C:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $07, $00 ; header: param=0 byte1=$00 volume=$07 byte3=$00
    db $1F, $03 ; rest-note $1F dur 3
    db $C3, $40 ; env $40
    db $70, $20 ; note C7 dur 32
    db $C7, $70 ; env $70
    db $70, $50 ; note C7 dur 80
    db $FF, $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7E6C:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $40, $02 ; note C4 dur 2
    db $60, $03 ; note C6 dur 3
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $40, $03 ; note C4 dur 3
    db $A0, $06 ; volume $06
    db $C7, $10 ; env $10
    db $40, $05 ; note C4 dur 5
    db $FF, $FF ; end

; sound track, 18 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7E82:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $40, $05 ; note C4 dur 5
    db $60, $05 ; note C6 dur 5
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $40, $08 ; note C4 dur 8
    db $A0, $06 ; volume $06
    db $C7, $20 ; env $20
    db $40, $08 ; note C4 dur 8
    db $1F, $02 ; rest-note $1F dur 2
    db $A0, $0F ; volume $0F
    db $C0, $FE ; env $FE
    db $88, $12 ; note G#8 dur 18
    db $50, $05 ; note C5 dur 5
    db $60, $05 ; note C6 dur 5
    db $40, $10 ; note C4 dur 16
    db $C7, $10 ; env $10
    db $30, $20 ; note C3 dur 32
    db $FF, $FF ; end

; sound track, 20 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7EAA:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $40, $02 ; note C4 dur 2
    db $60, $03 ; note C6 dur 3
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $40, $03 ; note C4 dur 3
    db $A0, $06 ; volume $06
    db $C7, $10 ; env $10
    db $40, $05 ; note C4 dur 5
    db $C0, $FE ; env $FE
    db $20, $07 ; note C2 dur 7
    db $12, $08 ; note D1 dur 8
    db $11, $08 ; note C#1 dur 8
    db $1F, $01 ; rest-note $1F dur 1
    db $A0, $0F ; volume $0F
    db $50, $04 ; note C5 dur 4
    db $60, $10 ; note C6 dur 16
    db $C7, $20 ; env $20
    db $A0, $06 ; volume $06
    db $60, $20 ; note C6 dur 32
    db $FF, $FF ; end

; sound track, 27 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7ED6:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $3E, $01 ; rest-note $3E dur 1
    db $40, $05 ; note C4 dur 5
    db $60, $03 ; note C6 dur 3
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $A0, $08 ; volume $08
    db $40, $06 ; note C4 dur 6
    db $A0, $05 ; volume $05
    db $C7, $10 ; env $10
    db $40, $0D ; note C4 dur 13
    db $10, $03 ; note C1 dur 3
    db $11, $03 ; note C#1 dur 3
    db $C0, $FE ; env $FE
    db $A0, $0F ; volume $0F
    db $C3, $07 ; env $07
    db $11, $05 ; note C#1 dur 5
    db $25, $05 ; note F2 dur 5
    db $21, $05 ; note C#2 dur 5
    db $23, $05 ; note D#2 dur 5
    db $C0, $FE ; env $FE
    db $23, $05 ; note D#2 dur 5
    db $22, $08 ; note D2 dur 8
    db $22, $07 ; note D2 dur 7
    db $A0, $08 ; volume $08
    db $C7, $40 ; env $40
    db $22, $20 ; note D2 dur 32
    db $FF, $FF ; end

; sound track, 66 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7F10:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $14 ; header: param=0 byte1=$00 volume=$0F byte3=$14
    db $1F, $22 ; rest-note $1F dur 34
    db $AE, $10 ; tuning $10
    db $30, $02 ; note C3 dur 2
    db $2B, $03 ; note B2 dur 3
    db $1F, $02 ; rest-note $1F dur 2
    db $28, $03 ; note G#2 dur 3
    db $2B, $03 ; note B2 dur 3
    db $1F, $02 ; rest-note $1F dur 2
    db $2B, $04 ; note B2 dur 4
    db $1F, $02 ; rest-note $1F dur 2
    db $28, $02 ; note G#2 dur 2
    db $1A, $03 ; note A#1 dur 3
    db $2F, $01 ; rest-note $2F dur 1
    db $1A, $03 ; note A#1 dur 3
    db $1F, $02 ; rest-note $1F dur 2
    db $29, $01 ; note A2 dur 1
    db $18, $02 ; note G#1 dur 2
    db $1F, $02 ; rest-note $1F dur 2
    db $27, $01 ; note G2 dur 1
    db $17, $02 ; note G1 dur 2
    db $26, $01 ; note F#2 dur 1
    db $25, $02 ; note F2 dur 2
    db $24, $01 ; note E2 dur 1
    db $23, $02 ; note D#2 dur 2
    db $1F, $01 ; rest-note $1F dur 1
    db $22, $01 ; note D2 dur 1
    db $21, $02 ; note C#2 dur 2
    db $20, $01 ; note C2 dur 1
    db $1B, $01 ; note B1 dur 1
    db $1A, $01 ; note A#1 dur 1
    db $19, $01 ; note A1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $17, $01 ; note G1 dur 1
    db $1F, $01 ; rest-note $1F dur 1
    db $16, $01 ; note F#1 dur 1
    db $15, $01 ; note F1 dur 1
    db $14, $01 ; note E1 dur 1
    db $A0, $08 ; volume $08
    db $1F, $01 ; rest-note $1F dur 1
    db $15, $01 ; note F1 dur 1
    db $17, $01 ; note G1 dur 1
    db $19, $01 ; note A1 dur 1
    db $A0, $06 ; volume $06
    db $1F, $02 ; rest-note $1F dur 2
    db $18, $01 ; note G#1 dur 1
    db $1B, $01 ; note B1 dur 1
    db $17, $01 ; note G1 dur 1
    db $1A, $01 ; note A#1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1B, $02 ; note B1 dur 2
    db $14, $01 ; note E1 dur 1
    db $A0, $04 ; volume $04
    db $1F, $02 ; rest-note $1F dur 2
    db $18, $01 ; note G#1 dur 1
    db $1B, $01 ; note B1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1F, $02 ; rest-note $1F dur 2
    db $1A, $01 ; note A#1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1F, $02 ; rest-note $1F dur 2
    db $14, $01 ; note E1 dur 1
    db $19, $01 ; note A1 dur 1
    db $1B, $01 ; note B1 dur 1
    db $19, $01 ; note A1 dur 1
    db $1A, $01 ; note A#1 dur 1
    db $FF, $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7F98:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $40, $02 ; note C4 dur 2
    db $60, $03 ; note C6 dur 3
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $40, $03 ; note C4 dur 3
    db $A0, $06 ; volume $06
    db $C7, $10 ; env $10
    db $40, $05 ; note C4 dur 5
    db $FF, $FF ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
Data_042_7FAE:: ; heuristic: track stream of a sound record; C0
    db $00, $00, $0F, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $20, $0B ; note C2 dur 11
    db $3E, $02 ; rest-note $3E dur 2
    db $60, $02 ; note C6 dur 2
    db $98, $03 ; note G#9 dur 3
    db $43, $09 ; note D#4 dur 9
    db $C1, $20 ; env $20
    db $A0, $09 ; volume $09
    db $43, $20 ; note D#4 dur 32
    db $FF, $FF ; end
    ds $3C, $00
