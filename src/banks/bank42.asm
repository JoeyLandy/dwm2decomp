SECTION "Bank 42", ROMX[$4000], BANK[$42]
    db $42

; E-0018. Sound ids 49-167.
; record: channel-state slot offset (added to $DC00); copied to slot byte +2 (meaning unverified);
; track stream (stored at slot +3/+4, with this bank at +5)
SoundRecords_Bank42::
    db $40, $00 ; id 49
    dw SoundTrack_42_00
    db $60, $01 ; id 50
    dw SoundTrack_42_01
    db $80, $02 ; id 51
    dw SoundTrack_42_02
    db $00, $03 ; id 52
    dw SoundTrack_42_03
    db $40, $00 ; id 53
    dw SoundTrack_42_04
    db $60, $01 ; id 54
    dw SoundTrack_42_05
    db $80, $02 ; id 55
    dw SoundTrack_42_06
    db $00, $03 ; id 56
    dw SoundTrack_42_07
    db $40, $00 ; id 57
    dw SoundTrack_42_08
    db $60, $01 ; id 58
    dw SoundTrack_42_09
    db $80, $02 ; id 59
    dw SoundTrack_42_0A
    db $a0, $03 ; id 60
    dw SoundTrack_42_0B
    db $40, $00 ; id 61
    dw SoundTrack_42_0C
    db $60, $01 ; id 62
    dw SoundTrack_42_0D
    db $80, $02 ; id 63
    dw SoundTrack_42_0E
    db $00, $00 ; id 64
    dw SoundTrack_42_0F
    db $20, $01 ; id 65
    dw SoundTrack_42_10
    db $00, $00 ; id 66
    dw SoundTrack_42_11
    db $20, $01 ; id 67
    dw SoundTrack_42_12
    db $00, $00 ; id 68
    dw SoundTrack_42_13
    db $20, $01 ; id 69
    dw SoundTrack_42_14
    db $00, $00 ; id 70
    dw SoundTrack_42_15
    db $20, $01 ; id 71
    dw SoundTrack_42_16
    db $40, $00 ; id 72
    dw SoundTrack_42_17
    db $60, $01 ; id 73
    dw SoundTrack_42_18
    db $40, $00 ; id 74
    dw SoundTrack_42_19
    db $60, $01 ; id 75
    dw SoundTrack_42_1A
    db $80, $02 ; id 76
    dw SoundTrack_42_1B
    db $40, $00 ; id 77
    dw SoundTrack_42_1C
    db $60, $01 ; id 78
    dw SoundTrack_42_1D
    db $80, $02 ; id 79
    dw SoundTrack_42_1E
    db $00, $00 ; id 80
    dw SoundTrack_42_1F
    db $20, $01 ; id 81
    dw SoundTrack_42_20
    db $00, $00 ; id 82
    dw SoundTrack_42_21
    db $20, $01 ; id 83
    dw SoundTrack_42_22
    db $40, $00 ; id 84
    dw SoundTrack_42_23
    db $60, $01 ; id 85
    dw SoundTrack_42_24
    db $80, $02 ; id 86
    dw SoundTrack_42_25
    db $00, $03 ; id 87
    dw SoundTrack_42_26
    db $40, $00 ; id 88
    dw SoundTrack_42_27
    db $60, $01 ; id 89
    dw SoundTrack_42_28
    db $80, $02 ; id 90
    dw SoundTrack_42_29
    db $a0, $03 ; id 91
    dw SoundTrack_42_2A
    db $40, $00 ; id 92
    dw SoundTrack_42_2B
    db $60, $01 ; id 93
    dw SoundTrack_42_2C
    db $80, $02 ; id 94
    dw SoundTrack_42_2D
    db $a0, $03 ; id 95
    dw SoundTrack_42_2E
    db $00, $03 ; id 96
    dw SoundTrack_42_2F
    db $00, $00 ; id 97
    dw SoundTrack_42_30
    db $00, $00 ; id 98
    dw SoundTrack_42_31
    db $00, $00 ; id 99
    dw SoundTrack_42_32
    db $20, $03 ; id 100
    dw SoundTrack_42_33
    db $00, $00 ; id 101
    dw SoundTrack_42_34
    db $00, $03 ; id 102
    dw SoundTrack_42_35
    db $00, $00 ; id 103
    dw SoundTrack_42_36
    db $20, $01 ; id 104
    dw SoundTrack_42_37
    db $00, $00 ; id 105
    dw SoundTrack_42_38
    db $00, $00 ; id 106
    dw SoundTrack_42_39
    db $00, $00 ; id 107
    dw SoundTrack_42_3A
    db $00, $00 ; id 108
    dw SoundTrack_42_3B
    db $40, $00 ; id 109
    dw SoundTrack_42_3C
    db $60, $01 ; id 110
    dw SoundTrack_42_3D
    db $80, $03 ; id 111
    dw SoundTrack_42_3E
    db $00, $00 ; id 112
    dw SoundTrack_42_3F
    db $20, $03 ; id 113
    dw SoundTrack_42_40
    db $00, $00 ; id 114
    dw SoundTrack_42_41
    db $20, $03 ; id 115
    dw SoundTrack_42_42
    db $00, $00 ; id 116
    dw SoundTrack_42_43
    db $20, $01 ; id 117
    dw SoundTrack_42_44
    db $20, $03 ; id 118
    dw SoundTrack_42_45
    db $00, $00 ; id 119
    dw SoundTrack_42_46
    db $00, $03 ; id 120
    dw SoundTrack_42_47
    db $00, $00 ; id 121
    dw SoundTrack_42_48
    db $00, $00 ; id 122
    dw SoundTrack_42_49
    db $00, $03 ; id 123
    dw SoundTrack_42_4A
    db $00, $00 ; id 124
    dw SoundTrack_42_4B
    db $00, $03 ; id 125
    dw SoundTrack_42_4C
    db $00, $00 ; id 126
    dw SoundTrack_42_4D
    db $20, $01 ; id 127
    dw SoundTrack_42_4E
    db $00, $00 ; id 128
    dw SoundTrack_42_4F
    db $00, $03 ; id 129
    dw SoundTrack_42_50
    db $00, $03 ; id 130
    dw SoundTrack_42_51
    db $00, $03 ; id 131
    dw SoundTrack_42_52
    db $00, $00 ; id 132
    dw SoundTrack_42_53
    db $00, $00 ; id 133
    dw SoundTrack_42_54
    db $00, $00 ; id 134
    dw SoundTrack_42_55
    db $00, $00 ; id 135
    dw SoundTrack_42_56
    db $00, $00 ; id 136
    dw SoundTrack_42_57
    db $00, $00 ; id 137
    dw SoundTrack_42_58
    db $20, $03 ; id 138
    dw SoundTrack_42_59
    db $00, $00 ; id 139
    dw SoundTrack_42_5A
    db $20, $03 ; id 140
    dw SoundTrack_42_5B
    db $00, $00 ; id 141
    dw SoundTrack_42_5C
    db $20, $03 ; id 142
    dw SoundTrack_42_5D
    db $00, $00 ; id 143
    dw SoundTrack_42_5E
    db $00, $03 ; id 144
    dw SoundTrack_42_5F
    db $00, $00 ; id 145
    dw SoundTrack_42_60
    db $20, $03 ; id 146
    dw SoundTrack_42_61
    db $00, $03 ; id 147
    dw SoundTrack_42_62
    db $00, $03 ; id 148
    dw SoundTrack_42_63
    db $00, $00 ; id 149
    dw SoundTrack_42_64
    db $00, $03 ; id 150
    dw SoundTrack_42_65
    db $00, $03 ; id 151
    dw SoundTrack_42_66
    db $00, $03 ; id 152
    dw SoundTrack_42_67
    db $00, $03 ; id 153
    dw SoundTrack_42_68
    db $00, $00 ; id 154
    dw SoundTrack_42_69
    db $00, $00 ; id 155
    dw SoundTrack_42_6A
    db $00, $03 ; id 156
    dw SoundTrack_42_6B
    db $00, $03 ; id 157
    dw SoundTrack_42_6C
    db $00, $03 ; id 158
    dw SoundTrack_42_6D
    db $00, $00 ; id 159
    dw SoundTrack_42_6E
    db $20, $03 ; id 160
    dw SoundTrack_42_6F
    db $00, $03 ; id 161
    dw SoundTrack_42_70
    db $00, $03 ; id 162
    dw SoundTrack_42_71
    db $00, $03 ; id 163
    dw SoundTrack_42_72
    db $00, $03 ; id 164
    dw SoundTrack_42_73
    db $00, $00 ; id 165
    dw SoundTrack_42_74
    db $20, $03 ; id 166
    dw SoundTrack_42_75
    db $00, $03 ; id 167
    dw SoundTrack_42_76

; sound track, 1509 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_00::
    db $0a, $01, $09, $00 ; header: param=10 byte1=$01 volume=$09 byte3=$00
    db $ac, $01 ; call x1
    dw $0b50 ; byte offset of the called section from the track start
    db $ac, $01 ; call x1
    dw $0874 ; byte offset of the called section from the track start
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $37, $0c ; note G3 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $33, $0c ; note D#3 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $33, $04 ; note D#3 dur 4
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $2b, $0c ; note B2 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $2b, $04 ; note B2 dur 4
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $27, $0c ; note G2 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $25, $0c ; note F2 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $25, $04 ; note F2 dur 4
    db $c3, $6f ; env $6F
    db $a0, $09 ; volume $09
    db $1b, $0c ; note B1 dur 12
    db $c1, $2f ; env $2F
    db $a0, $04 ; volume $04
    db $1b, $14 ; note B1 dur 20
    db $ac, $01 ; call x1
    dw $0874 ; byte offset of the called section from the track start
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $37, $0c ; note G3 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $33, $0c ; note D#3 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $33, $04 ; note D#3 dur 4
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $2b, $0c ; note B2 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $2b, $04 ; note B2 dur 4
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $27, $0c ; note G2 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $25, $0c ; note F2 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $25, $04 ; note F2 dur 4
    db $c1, $20 ; env $20
    db $a0, $0b ; volume $0B
    db $1b, $03 ; note B1 dur 3
    db $a0, $03 ; volume $03
    db $1b, $01 ; note B1 dur 1
    db $a0, $0b ; volume $0B
    db $22, $03 ; note D2 dur 3
    db $a0, $03 ; volume $03
    db $22, $01 ; note D2 dur 1
    db $a0, $0b ; volume $0B
    db $22, $03 ; note D2 dur 3
    db $a0, $03 ; volume $03
    db $22, $01 ; note D2 dur 1
    db $a0, $0b ; volume $0B
    db $25, $03 ; note F2 dur 3
    db $a0, $03 ; volume $03
    db $25, $01 ; note F2 dur 1
    db $a0, $0b ; volume $0B
    db $25, $03 ; note F2 dur 3
    db $a0, $03 ; volume $03
    db $25, $01 ; note F2 dur 1
    db $a0, $0b ; volume $0B
    db $27, $03 ; note G2 dur 3
    db $a0, $03 ; volume $03
    db $27, $01 ; note G2 dur 1
    db $a0, $0b ; volume $0B
    db $27, $03 ; note G2 dur 3
    db $a0, $03 ; volume $03
    db $27, $01 ; note G2 dur 1
    db $a0, $0b ; volume $0B
    db $2b, $03 ; note B2 dur 3
    db $a0, $03 ; volume $03
    db $2b, $01 ; note B2 dur 1
    db $fd, $f0 ; label 0
    db $a2, $01 ; duty2 $01
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $10, $04 ; note C1 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $b1, $f0 ; repeat $F0
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $04, $04 ; note E0 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $32, $04 ; note D3 dur 4
    db $27, $04 ; note G2 dur 4
    db $32, $04 ; note D3 dur 4
    db $37, $04 ; note G3 dur 4
    db $32, $04 ; note D3 dur 4
    db $27, $04 ; note G2 dur 4
    db $32, $04 ; note D3 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $14, $04 ; note E1 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $32, $04 ; note D3 dur 4
    db $27, $04 ; note G2 dur 4
    db $24, $04 ; note E2 dur 4
    db $27, $04 ; note G2 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $09, $04 ; note A0 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $27, $04 ; note G2 dur 4
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $12, $04 ; note D1 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $30, $04 ; note C3 dur 4
    db $32, $04 ; note D3 dur 4
    db $30, $04 ; note C3 dur 4
    db $12, $04 ; note D1 dur 4
    db $25, $04 ; note F2 dur 4
    db $20, $04 ; note C2 dur 4
    db $25, $04 ; note F2 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $04, $04 ; note E0 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $32, $04 ; note D3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $09, $04 ; note A0 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $24, $04 ; note E2 dur 4
    db $21, $04 ; note C#2 dur 4
    db $24, $04 ; note E2 dur 4
    db $29, $04 ; note A2 dur 4
    db $24, $04 ; note E2 dur 4
    db $21, $04 ; note C#2 dur 4
    db $24, $04 ; note E2 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $05, $04 ; note F0 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $35, $04 ; note F3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $05, $04 ; note F0 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $28, $04 ; note G#2 dur 4
    db $30, $04 ; note C3 dur 4
    db $28, $04 ; note G#2 dur 4
    db $35, $04 ; note F3 dur 4
    db $28, $04 ; note G#2 dur 4
    db $30, $04 ; note C3 dur 4
    db $28, $04 ; note G#2 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $10, $04 ; note C1 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $34, $04 ; note E3 dur 4
    db $27, $04 ; note G2 dur 4
    db $34, $04 ; note E3 dur 4
    db $27, $04 ; note G2 dur 4
    db $34, $04 ; note E3 dur 4
    db $27, $04 ; note G2 dur 4
    db $34, $04 ; note E3 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $09, $04 ; note A0 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $37, $04 ; note G3 dur 4
    db $31, $04 ; note C#3 dur 4
    db $37, $04 ; note G3 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $19, $04 ; note A1 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $31, $04 ; note C#3 dur 4
    db $27, $04 ; note G2 dur 4
    db $31, $04 ; note C#3 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $02, $04 ; note D0 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $22, $04 ; note D2 dur 4
    db $20, $04 ; note C2 dur 4
    db $22, $04 ; note D2 dur 4
    db $19, $04 ; note A1 dur 4
    db $22, $04 ; note D2 dur 4
    db $20, $04 ; note C2 dur 4
    db $22, $04 ; note D2 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $07, $04 ; note G0 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $25, $04 ; note F2 dur 4
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $27, $04 ; note G2 dur 4
    db $25, $04 ; note F2 dur 4
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $10, $04 ; note C1 dur 4
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
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
    db $a2, $01 ; duty2 $01
    db $a0, $0c ; volume $0C
    db $c3, $48 ; env $48
    db $25, $08 ; note F2 dur 8
    db $29, $04 ; note A2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $29, $0c ; note A2 dur 12
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $29, $04 ; note A2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $29, $04 ; note A2 dur 4
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $25, $08 ; note F2 dur 8
    db $28, $04 ; note G#2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $28, $0c ; note G#2 dur 12
    db $c1, $30 ; env $30
    db $fd, $f0 ; label 0
    db $a0, $06 ; volume $06
    db $28, $02 ; note G#2 dur 2
    db $a0, $03 ; volume $03
    db $28, $02 ; note G#2 dur 2
    db $b1, $f0 ; repeat $F0
    db $a0, $0c ; volume $0C
    db $c3, $48 ; env $48
    db $24, $08 ; note E2 dur 8
    db $27, $04 ; note G2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $27, $0c ; note G2 dur 12
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $27, $04 ; note G2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $27, $04 ; note G2 dur 4
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $24, $08 ; note E2 dur 8
    db $27, $04 ; note G2 dur 4
    db $a0, $05 ; volume $05
    db $27, $0c ; note G2 dur 12
    db $c1, $30 ; env $30
    db $fd, $f0 ; label 0
    db $a0, $06 ; volume $06
    db $27, $02 ; note G2 dur 2
    db $a0, $03 ; volume $03
    db $27, $02 ; note G2 dur 2
    db $b1, $f0 ; repeat $F0
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $25, $08 ; note F2 dur 8
    db $29, $04 ; note A2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $29, $0c ; note A2 dur 12
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $29, $04 ; note A2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $29, $04 ; note A2 dur 4
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $25, $08 ; note F2 dur 8
    db $28, $04 ; note G#2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $28, $0c ; note G#2 dur 12
    db $c1, $30 ; env $30
    db $fd, $f0 ; label 0
    db $a0, $06 ; volume $06
    db $28, $02 ; note G#2 dur 2
    db $a0, $03 ; volume $03
    db $28, $02 ; note G#2 dur 2
    db $b1, $f0 ; repeat $F0
    db $a0, $0c ; volume $0C
    db $c3, $48 ; env $48
    db $24, $08 ; note E2 dur 8
    db $27, $04 ; note G2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $27, $0c ; note G2 dur 12
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $27, $04 ; note G2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $27, $04 ; note G2 dur 4
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $24, $08 ; note E2 dur 8
    db $27, $04 ; note G2 dur 4
    db $c1, $50 ; env $50
    db $a0, $05 ; volume $05
    db $27, $0c ; note G2 dur 12
    db $c1, $30 ; env $30
    db $fd, $f0 ; label 0
    db $a0, $06 ; volume $06
    db $27, $02 ; note G2 dur 2
    db $a0, $03 ; volume $03
    db $27, $02 ; note G2 dur 2
    db $b1, $f0 ; repeat $F0
    db $a0, $09 ; volume $09
    db $c3, $48 ; env $48
    db $22, $08 ; note D2 dur 8
    db $26, $04 ; note F#2 dur 4
    db $c1, $50 ; env $50
    db $a0, $08 ; volume $08
    db $26, $0c ; note F#2 dur 12
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $26, $04 ; note F#2 dur 4
    db $c1, $50 ; env $50
    db $a0, $08 ; volume $08
    db $26, $04 ; note F#2 dur 4
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $22, $08 ; note D2 dur 8
    db $26, $04 ; note F#2 dur 4
    db $c1, $50 ; env $50
    db $a0, $08 ; volume $08
    db $26, $0c ; note F#2 dur 12
    db $c1, $30 ; env $30
    db $fd, $f0 ; label 0
    db $a0, $06 ; volume $06
    db $26, $02 ; note F#2 dur 2
    db $a0, $03 ; volume $03
    db $26, $02 ; note F#2 dur 2
    db $b1, $f0 ; repeat $F0
    db $a0, $08 ; volume $08
    db $c3, $02 ; env $02
    db $32, $03 ; note D3 dur 3
    db $a0, $03 ; volume $03
    db $32, $01 ; note D3 dur 1
    db $a0, $08 ; volume $08
    db $32, $03 ; note D3 dur 3
    db $a0, $03 ; volume $03
    db $32, $01 ; note D3 dur 1
    db $a0, $08 ; volume $08
    db $31, $03 ; note C#3 dur 3
    db $a0, $03 ; volume $03
    db $31, $01 ; note C#3 dur 1
    db $a0, $08 ; volume $08
    db $32, $03 ; note D3 dur 3
    db $a0, $03 ; volume $03
    db $32, $01 ; note D3 dur 1
    db $a0, $08 ; volume $08
    db $34, $03 ; note E3 dur 3
    db $a0, $03 ; volume $03
    db $34, $01 ; note E3 dur 1
    db $a0, $08 ; volume $08
    db $34, $03 ; note E3 dur 3
    db $a0, $03 ; volume $03
    db $34, $01 ; note E3 dur 1
    db $a0, $08 ; volume $08
    db $33, $03 ; note D#3 dur 3
    db $a0, $03 ; volume $03
    db $33, $01 ; note D#3 dur 1
    db $a0, $08 ; volume $08
    db $34, $03 ; note E3 dur 3
    db $a0, $03 ; volume $03
    db $34, $01 ; note E3 dur 1
    db $a0, $08 ; volume $08
    db $35, $03 ; note F3 dur 3
    db $a0, $03 ; volume $03
    db $35, $01 ; note F3 dur 1
    db $a0, $08 ; volume $08
    db $35, $03 ; note F3 dur 3
    db $a0, $03 ; volume $03
    db $35, $01 ; note F3 dur 1
    db $a0, $08 ; volume $08
    db $34, $03 ; note E3 dur 3
    db $a0, $03 ; volume $03
    db $34, $01 ; note E3 dur 1
    db $a0, $08 ; volume $08
    db $35, $03 ; note F3 dur 3
    db $a0, $03 ; volume $03
    db $35, $01 ; note F3 dur 1
    db $a0, $08 ; volume $08
    db $37, $03 ; note G3 dur 3
    db $a0, $03 ; volume $03
    db $37, $01 ; note G3 dur 1
    db $a0, $08 ; volume $08
    db $37, $03 ; note G3 dur 3
    db $a0, $03 ; volume $03
    db $37, $01 ; note G3 dur 1
    db $a0, $08 ; volume $08
    db $36, $03 ; note F#3 dur 3
    db $a0, $03 ; volume $03
    db $36, $01 ; note F#3 dur 1
    db $a0, $08 ; volume $08
    db $37, $03 ; note G3 dur 3
    db $a0, $03 ; volume $03
    db $37, $01 ; note G3 dur 1
    db $a0, $08 ; volume $08
    db $c3, $48 ; env $48
    db $39, $03 ; note A3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $39, $04 ; note A3 dur 4
    db $a0, $0c ; volume $0C
    db $37, $03 ; note G3 dur 3
    db $39, $03 ; note A3 dur 3
    db $37, $02 ; note G3 dur 2
    db $35, $03 ; note F3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $35, $04 ; note F3 dur 4
    db $a0, $0c ; volume $0C
    db $34, $03 ; note E3 dur 3
    db $35, $03 ; note F3 dur 3
    db $34, $02 ; note E3 dur 2
    db $32, $03 ; note D3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $32, $04 ; note D3 dur 4
    db $a0, $0c ; volume $0C
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $30, $02 ; note C3 dur 2
    db $2b, $03 ; note B2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $2b, $04 ; note B2 dur 4
    db $a0, $0c ; volume $0C
    db $29, $03 ; note A2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $29, $04 ; note A2 dur 4
    db $a0, $0c ; volume $0C
    db $2b, $20 ; note B2 dur 32
    db $a3, $20 ; mod $20
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $2b, $10 ; note B2 dur 16
    db $c3, $58 ; env $58
    db $a3, $26 ; mod $26
    db $a0, $0f ; volume $0F
    db $17, $08 ; note G1 dur 8
    db $19, $08 ; note A1 dur 8
    db $24, $10 ; note E2 dur 16
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $24, $10 ; note E2 dur 16
    db $22, $08 ; note D2 dur 8
    db $20, $08 ; note C2 dur 8
    db $1b, $20 ; note B1 dur 32
    db $c1, $7f ; env $7F
    db $a3, $20 ; mod $20
    db $a0, $06 ; volume $06
    db $1b, $10 ; note B1 dur 16
    db $c3, $58 ; env $58
    db $a3, $26 ; mod $26
    db $a0, $0f ; volume $0F
    db $20, $08 ; note C2 dur 8
    db $1b, $08 ; note B1 dur 8
    db $19, $10 ; note A1 dur 16
    db $1b, $08 ; note B1 dur 8
    db $20, $08 ; note C2 dur 8
    db $15, $10 ; note F1 dur 16
    db $17, $08 ; note G1 dur 8
    db $19, $08 ; note A1 dur 8
    db $17, $08 ; note G1 dur 8
    db $19, $08 ; note A1 dur 8
    db $14, $18 ; note E1 dur 24
    db $c1, $6f ; env $6F
    db $a3, $20 ; mod $20
    db $a0, $07 ; volume $07
    db $14, $08 ; note E1 dur 8
    db $c3, $58 ; env $58
    db $a3, $26 ; mod $26
    db $a0, $0f ; volume $0F
    db $14, $0e ; note E1 dur 14
    db $c1, $70 ; env $70
    db $a0, $08 ; volume $08
    db $14, $02 ; note E1 dur 2
    db $c3, $58 ; env $58
    db $a3, $26 ; mod $26
    db $a0, $0f ; volume $0F
    db $14, $08 ; note E1 dur 8
    db $12, $08 ; note D1 dur 8
    db $20, $18 ; note C2 dur 24
    db $c1, $7f ; env $7F
    db $a3, $20 ; mod $20
    db $a0, $0a ; volume $0A
    db $20, $08 ; note C2 dur 8
    db $c3, $58 ; env $58
    db $a3, $26 ; mod $26
    db $a0, $0f ; volume $0F
    db $1a, $08 ; note A#1 dur 8
    db $18, $08 ; note G#1 dur 8
    db $17, $08 ; note G1 dur 8
    db $19, $08 ; note A1 dur 8
    db $1b, $08 ; note B1 dur 8
    db $20, $08 ; note C2 dur 8
    db $24, $04 ; note E2 dur 4
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $c3, $58 ; env $58
    db $a0, $0f ; volume $0F
    db $14, $08 ; note E1 dur 8
    db $1a, $08 ; note A#1 dur 8
    db $21, $08 ; note C#2 dur 8
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $19, $10 ; note A1 dur 16
    db $20, $10 ; note C2 dur 16
    db $22, $10 ; note D2 dur 16
    db $24, $04 ; note E2 dur 4
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $24, $04 ; note E2 dur 4
    db $a2, $01 ; duty2 $01
    db $c3, $58 ; env $58
    db $a0, $0c ; volume $0C
    db $34, $08 ; note E3 dur 8
    db $30, $08 ; note C3 dur 8
    db $27, $08 ; note G2 dur 8
    db $24, $08 ; note E2 dur 8
    db $20, $06 ; note C2 dur 6
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $20, $02 ; note C2 dur 2
    db $c3, $28 ; env $28
    db $a0, $0a ; volume $0A
    db $19, $02 ; note A1 dur 2
    db $1b, $02 ; note B1 dur 2
    db $20, $02 ; note C2 dur 2
    db $22, $02 ; note D2 dur 2
    db $a0, $09 ; volume $09
    db $24, $02 ; note E2 dur 2
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $29, $02 ; note A2 dur 2
    db $ac, $01 ; call x1
    dw $0b50 ; byte offset of the called section from the track start
    db $ac, $01 ; call x1
    dw $0874 ; byte offset of the called section from the track start
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $37, $0c ; note G3 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $33, $0c ; note D#3 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $33, $04 ; note D#3 dur 4
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $2b, $0c ; note B2 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $2b, $04 ; note B2 dur 4
    db $a2, $02 ; duty2 $02
    db $a3, $26 ; mod $26
    db $c3, $68 ; env $68
    db $a0, $0c ; volume $0C
    db $27, $10 ; note G2 dur 16
    db $25, $08 ; note F2 dur 8
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $25, $08 ; note F2 dur 8
    db $c4, $10 ; env $10
    db $a0, $0c ; volume $0C
    db $1b, $02 ; note B1 dur 2
    db $a0, $08 ; volume $08
    db $1b, $02 ; note B1 dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $27, $02 ; note G2 dur 2
    db $a0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $a0, $0c ; volume $0C
    db $27, $02 ; note G2 dur 2
    db $a0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $a0, $0c ; volume $0C
    db $2b, $02 ; note B2 dur 2
    db $a0, $08 ; volume $08
    db $2b, $02 ; note B2 dur 2
    db $a0, $03 ; volume $03
    db $27, $02 ; note G2 dur 2
    db $1f, $02 ; rest-note $1F dur 2
    db $2b, $02 ; note B2 dur 2
    db $1f, $02 ; rest-note $1F dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $29, $02 ; note A2 dur 2
    db $a0, $08 ; volume $08
    db $29, $02 ; note A2 dur 2
    db $a0, $0c ; volume $0C
    db $29, $02 ; note A2 dur 2
    db $a0, $08 ; volume $08
    db $29, $02 ; note A2 dur 2
    db $a0, $0c ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $a0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $a0, $0c ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $a0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $a0, $0c ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $a0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $a0, $0c ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $a0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $a0, $0c ; volume $0C
    db $3a, $02 ; note A#3 dur 2
    db $a0, $08 ; volume $08
    db $3a, $02 ; note A#3 dur 2
    db $a0, $0c ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $a0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $a0, $0c ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $a0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $a0, $0c ; volume $0C
    db $2a, $02 ; note A#2 dur 2
    db $a0, $08 ; volume $08
    db $2a, $02 ; note A#2 dur 2
    db $a0, $03 ; volume $03
    db $32, $02 ; note D3 dur 2
    db $1f, $02 ; rest-note $1F dur 2
    db $2a, $02 ; note A#2 dur 2
    db $1f, $02 ; rest-note $1F dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $2b, $02 ; note B2 dur 2
    db $a0, $08 ; volume $08
    db $2b, $02 ; note B2 dur 2
    db $a0, $0c ; volume $0C
    db $2b, $02 ; note B2 dur 2
    db $a0, $08 ; volume $08
    db $2b, $02 ; note B2 dur 2
    db $a0, $0c ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $a0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $a0, $0c ; volume $0C
    db $2a, $02 ; note A#2 dur 2
    db $a0, $08 ; volume $08
    db $2a, $02 ; note A#2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $2b, $02 ; note B2 dur 2
    db $a0, $08 ; volume $08
    db $2b, $02 ; note B2 dur 2
    db $a0, $0c ; volume $0C
    db $27, $02 ; note G2 dur 2
    db $a0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $1b, $02 ; note B1 dur 2
    db $a0, $08 ; volume $08
    db $1b, $02 ; note B1 dur 2
    db $a0, $03 ; volume $03
    db $22, $02 ; note D2 dur 2
    db $1f, $02 ; rest-note $1F dur 2
    db $1b, $02 ; note B1 dur 2
    db $1f, $02 ; rest-note $1F dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $29, $02 ; note A2 dur 2
    db $a0, $08 ; volume $08
    db $29, $02 ; note A2 dur 2
    db $a0, $0c ; volume $0C
    db $29, $02 ; note A2 dur 2
    db $a0, $08 ; volume $08
    db $29, $02 ; note A2 dur 2
    db $a0, $0c ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $a0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $a0, $0c ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $a0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $a0, $0c ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $a0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $a0, $0c ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $a0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $a0, $0c ; volume $0C
    db $3a, $02 ; note A#3 dur 2
    db $a0, $08 ; volume $08
    db $3a, $02 ; note A#3 dur 2
    db $a0, $0c ; volume $0C
    db $35, $02 ; note F3 dur 2
    db $a0, $08 ; volume $08
    db $35, $02 ; note F3 dur 2
    db $a0, $0c ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $a0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $a0, $0c ; volume $0C
    db $2a, $02 ; note A#2 dur 2
    db $a0, $08 ; volume $08
    db $2a, $02 ; note A#2 dur 2
    db $1f, $08 ; rest-note $1F dur 8
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $2b, $02 ; note B2 dur 2
    db $a0, $08 ; volume $08
    db $2b, $02 ; note B2 dur 2
    db $a0, $0c ; volume $0C
    db $2b, $02 ; note B2 dur 2
    db $a0, $08 ; volume $08
    db $2b, $02 ; note B2 dur 2
    db $a0, $0c ; volume $0C
    db $32, $02 ; note D3 dur 2
    db $a0, $08 ; volume $08
    db $32, $02 ; note D3 dur 2
    db $a0, $0c ; volume $0C
    db $2a, $02 ; note A#2 dur 2
    db $a0, $08 ; volume $08
    db $2a, $02 ; note A#2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $02 ; note F2 dur 2
    db $a0, $08 ; volume $08
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $2b, $02 ; note B2 dur 2
    db $a0, $08 ; volume $08
    db $2b, $02 ; note B2 dur 2
    db $a0, $0c ; volume $0C
    db $27, $02 ; note G2 dur 2
    db $a0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $a0, $0c ; volume $0C
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $22, $02 ; note D2 dur 2
    db $a0, $0c ; volume $0C
    db $1b, $02 ; note B1 dur 2
    db $a0, $08 ; volume $08
    db $1b, $02 ; note B1 dur 2
    db $a0, $03 ; volume $03
    db $22, $02 ; note D2 dur 2
    db $1f, $02 ; rest-note $1F dur 2
    db $1b, $02 ; note B1 dur 2
    db $1f, $0a ; rest-note $1F dur 10
    db $c3, $48 ; env $48
    db $a2, $02 ; duty2 $02
    db $a0, $0c ; volume $0C
    db $18, $06 ; note G#1 dur 6
    db $a0, $06 ; volume $06
    db $18, $02 ; note G#1 dur 2
    db $a0, $0c ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $a0, $06 ; volume $06
    db $20, $02 ; note C2 dur 2
    db $a0, $0c ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $a0, $06 ; volume $06
    db $20, $02 ; note C2 dur 2
    db $a0, $0c ; volume $0C
    db $23, $06 ; note D#2 dur 6
    db $a0, $06 ; volume $06
    db $23, $02 ; note D#2 dur 2
    db $a0, $0c ; volume $0C
    db $23, $06 ; note D#2 dur 6
    db $a0, $06 ; volume $06
    db $23, $02 ; note D#2 dur 2
    db $a0, $0c ; volume $0C
    db $28, $06 ; note G#2 dur 6
    db $a0, $06 ; volume $06
    db $28, $02 ; note G#2 dur 2
    db $a0, $0c ; volume $0C
    db $25, $06 ; note F2 dur 6
    db $a0, $06 ; volume $06
    db $25, $02 ; note F2 dur 2
    db $a0, $0c ; volume $0C
    db $29, $06 ; note A2 dur 6
    db $a0, $06 ; volume $06
    db $29, $02 ; note A2 dur 2
    db $a0, $0c ; volume $0C
    db $30, $06 ; note C3 dur 6
    db $a0, $06 ; volume $06
    db $30, $02 ; note C3 dur 2
    db $a0, $0c ; volume $0C
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $02 ; note F3 dur 2
    db $a0, $0c ; volume $0C
    db $39, $06 ; note A3 dur 6
    db $c1, $3f ; env $3F
    db $a0, $05 ; volume $05
    db $39, $0a ; note A3 dur 10
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $23, $10 ; note D#2 dur 16
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $30, $08 ; note C3 dur 8
    db $a1, $00 ; duty $00
    db $fd, $f0 ; label 0
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $34, $04 ; note E3 dur 4
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $34, $04 ; note E3 dur 4
    db $b2, $f0 ; repeat $F0
    db $c3, $68 ; env $68
    db $a0, $0c ; volume $0C
    db $32, $18 ; note D3 dur 24
    db $a3, $20 ; mod $20
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $32, $08 ; note D3 dur 8
    db $af, $04 ; param $04
    db $a7, $10 ; wait $10
    db $a3, $26 ; mod $26
    db $fd, $f0 ; label 0
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $30, $08 ; note C3 dur 8
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $30, $08 ; note C3 dur 8
    db $b2, $f0 ; repeat $F0
    db $c3, $68 ; env $68
    db $a0, $0e ; volume $0E
    db $29, $34 ; note A2 dur 52
    db $c1, $7f ; env $7F
    db $a3, $20 ; mod $20
    db $a0, $06 ; volume $06
    db $29, $23 ; note A2 dur 35
    db $fd, $f0 ; label 0
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $2a, $08 ; note A#2 dur 8
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $2a, $0a ; note A#2 dur 10
    db $b2, $f0 ; repeat $F0
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $2b, $08 ; note B2 dur 8
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $2b, $0a ; note B2 dur 10
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $25, $08 ; note F2 dur 8
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $25, $0b ; note F2 dur 11
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $22, $08 ; note D2 dur 8
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $22, $0b ; note D2 dur 11
    db $c3, $48 ; env $48
    db $a0, $0e ; volume $0E
    db $1b, $08 ; note B1 dur 8
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $1b, $0b ; note B1 dur 11
    db $a0, $09 ; volume $09
    db $a2, $01 ; duty2 $01
    db $c3, $58 ; env $58
    db $fd, $f0 ; label 0
    db $24, $04 ; note E2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $bf, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $24, $04 ; note E2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $24, $04 ; note E2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $b6, $f0 ; repeat $F0
    db $a7, $02 ; wait $02
    db $c3, $58 ; env $58
    db $24, $10 ; note E2 dur 16
    db $a0, $06 ; volume $06
    db $c1, $70 ; env $70
    db $24, $20 ; note E2 dur 32
    db $ff, $ff ; end
    db $a0, $05 ; volume $05
    db $37, $08 ; note G3 dur 8
    db $a3, $03 ; mod $03
    db $c3, $68 ; env $68
    db $a0, $0c ; volume $0C
    db $25, $06 ; note F2 dur 6
    db $c1, $40 ; env $40
    db $a0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $c3, $68 ; env $68
    db $a0, $0c ; volume $0C
    db $29, $0c ; note A2 dur 12
    db $c1, $40 ; env $40
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $29, $0c ; note A2 dur 12
    db $a3, $03 ; mod $03
    db $c3, $68 ; env $68
    db $a0, $0c ; volume $0C
    db $27, $06 ; note G2 dur 6
    db $c1, $40 ; env $40
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $c3, $68 ; env $68
    db $a0, $0c ; volume $0C
    db $2b, $0c ; note B2 dur 12
    db $a3, $00 ; mod $00
    db $c1, $40 ; env $40
    db $a0, $05 ; volume $05
    db $2b, $0c ; note B2 dur 12
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0c ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $c1, $40 ; env $40
    db $a0, $04 ; volume $04
    db $24, $02 ; note E2 dur 2
    db $c3, $68 ; env $68
    db $a0, $0c ; volume $0C
    db $30, $0c ; note C3 dur 12
    db $c1, $40 ; env $40
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $30, $0c ; note C3 dur 12
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0a ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $c1, $40 ; env $40
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $32, $0c ; note D3 dur 12
    db $c1, $40 ; env $40
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $32, $0c ; note D3 dur 12
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0a ; volume $0A
    db $21, $06 ; note C#2 dur 6
    db $c1, $40 ; env $40
    db $a0, $04 ; volume $04
    db $21, $02 ; note C#2 dur 2
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $24, $0c ; note E2 dur 12
    db $a3, $00 ; mod $00
    db $c1, $40 ; env $40
    db $a0, $05 ; volume $05
    db $24, $0c ; note E2 dur 12
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0a ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $c1, $40 ; env $40
    db $a0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $30, $0c ; note C3 dur 12
    db $a3, $00 ; mod $00
    db $c1, $40 ; env $40
    db $a0, $05 ; volume $05
    db $30, $0c ; note C3 dur 12
    db $c3, $78 ; env $78
    db $a3, $03 ; mod $03
    db $a0, $0a ; volume $0A
    db $29, $08 ; note A2 dur 8
    db $2b, $08 ; note B2 dur 8
    db $29, $08 ; note A2 dur 8
    db $2b, $08 ; note B2 dur 8
    db $a0, $09 ; volume $09
    db $29, $08 ; note A2 dur 8
    db $2b, $08 ; note B2 dur 8
    db $a0, $08 ; volume $08
    db $29, $08 ; note A2 dur 8
    db $c1, $30 ; env $30
    db $a0, $03 ; volume $03
    db $29, $08 ; note A2 dur 8
    db $a2, $02 ; duty2 $02
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $20, $03 ; note C2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $20, $04 ; note C2 dur 4
    db $a0, $0c ; volume $0C
    db $29, $03 ; note A2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $20, $04 ; note C2 dur 4
    db $a0, $0c ; volume $0C
    db $20, $03 ; note C2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $29, $04 ; note A2 dur 4
    db $c1, $20 ; env $20
    db $20, $08 ; note C2 dur 8
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $1b, $03 ; note B1 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $1b, $04 ; note B1 dur 4
    db $a0, $0c ; volume $0C
    db $25, $03 ; note F2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $1b, $04 ; note B1 dur 4
    db $a0, $0c ; volume $0C
    db $1b, $03 ; note B1 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $25, $04 ; note F2 dur 4
    db $c1, $20 ; env $20
    db $1b, $08 ; note B1 dur 8
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $1b, $03 ; note B1 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $1b, $04 ; note B1 dur 4
    db $a0, $0c ; volume $0C
    db $27, $03 ; note G2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $1b, $04 ; note B1 dur 4
    db $a0, $0c ; volume $0C
    db $1b, $03 ; note B1 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $c1, $20 ; env $20
    db $a0, $02 ; volume $02
    db $2b, $08 ; note B2 dur 8
    db $1f, $04 ; rest-note $1F dur 4
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $21, $03 ; note C#2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $21, $04 ; note C#2 dur 4
    db $a0, $0c ; volume $0C
    db $27, $03 ; note G2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $21, $04 ; note C#2 dur 4
    db $a0, $0c ; volume $0C
    db $21, $03 ; note C#2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $c1, $20 ; env $20
    db $a0, $02 ; volume $02
    db $21, $08 ; note C#2 dur 8
    db $1f, $04 ; rest-note $1F dur 4
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $25, $03 ; note F2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $25, $04 ; note F2 dur 4
    db $a0, $0c ; volume $0C
    db $29, $03 ; note A2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $25, $04 ; note F2 dur 4
    db $a0, $0c ; volume $0C
    db $30, $03 ; note C3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $29, $04 ; note A2 dur 4
    db $a0, $0c ; volume $0C
    db $25, $18 ; note F2 dur 24
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $25, $10 ; note F2 dur 16
    db $c3, $58 ; env $58
    db $a0, $0c ; volume $0C
    db $20, $08 ; note C2 dur 8
    db $28, $10 ; note G#2 dur 16
    db $29, $0c ; note A2 dur 12
    db $c1, $60 ; env $60
    db $a0, $06 ; volume $06
    db $29, $04 ; note A2 dur 4
    db $c3, $58 ; env $58
    db $a0, $0c ; volume $0C
    db $2b, $10 ; note B2 dur 16
    db $c3, $02 ; env $02
    db $a0, $09 ; volume $09
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
    db $2a, $04 ; note A#2 dur 4
    db $32, $04 ; note D3 dur 4
    db $2a, $04 ; note A#2 dur 4
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
    db $a0, $02 ; volume $02
    db $22, $04 ; note D2 dur 4
    db $25, $04 ; note F2 dur 4
    db $c3, $48 ; env $48
    db $fd, $f0 ; label 0
    db $a0, $0e ; volume $0E
    db $22, $03 ; note D2 dur 3
    db $a0, $03 ; volume $03
    db $22, $05 ; note D2 dur 5
    db $b1, $f0 ; repeat $F0
    db $a0, $0e ; volume $0E
    db $22, $03 ; note D2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $c1, $20 ; env $20
    db $a0, $03 ; volume $03
    db $22, $0c ; note D2 dur 12
    db $c3, $48 ; env $48
    db $fd, $f0 ; label 0
    db $a0, $0e ; volume $0E
    db $23, $03 ; note D#2 dur 3
    db $a0, $03 ; volume $03
    db $23, $05 ; note D#2 dur 5
    db $b1, $f0 ; repeat $F0
    db $a0, $0e ; volume $0E
    db $23, $03 ; note D#2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $c1, $20 ; env $20
    db $a0, $03 ; volume $03
    db $23, $0c ; note D#2 dur 12
    db $c3, $48 ; env $48
    db $fd, $f0 ; label 0
    db $a0, $0e ; volume $0E
    db $20, $03 ; note C2 dur 3
    db $a0, $03 ; volume $03
    db $20, $05 ; note C2 dur 5
    db $b1, $f0 ; repeat $F0
    db $a0, $0e ; volume $0E
    db $20, $03 ; note C2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $c1, $20 ; env $20
    db $a0, $03 ; volume $03
    db $20, $0c ; note C2 dur 12
    db $c3, $48 ; env $48
    db $fd, $f0 ; label 0
    db $a0, $0e ; volume $0E
    db $1b, $03 ; note B1 dur 3
    db $a0, $03 ; volume $03
    db $1b, $05 ; note B1 dur 5
    db $b1, $f0 ; repeat $F0
    db $a0, $0e ; volume $0E
    db $1b, $03 ; note B1 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $c1, $20 ; env $20
    db $a0, $03 ; volume $03
    db $1b, $14 ; note B1 dur 20
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $17, $0c ; note G1 dur 12
    db $c1, $30 ; env $30
    db $a0, $06 ; volume $06
    db $17, $14 ; note G1 dur 20
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $23, $0c ; note D#2 dur 12
    db $c1, $30 ; env $30
    db $a0, $06 ; volume $06
    db $23, $14 ; note D#2 dur 20
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $1a, $0c ; note A#1 dur 12
    db $c1, $30 ; env $30
    db $a0, $06 ; volume $06
    db $1a, $14 ; note A#1 dur 20
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $19, $0c ; note A1 dur 12
    db $c1, $30 ; env $30
    db $a0, $06 ; volume $06
    db $19, $04 ; note A1 dur 4
    db $c3, $78 ; env $78
    db $a0, $0c ; volume $0C
    db $17, $30 ; note G1 dur 48
    db $a0, $0a ; volume $0A
    db $c1, $70 ; env $70
    db $17, $10 ; note G1 dur 16
    db $c3, $78 ; env $78
    db $a0, $0c ; volume $0C
    db $18, $30 ; note G#1 dur 48
    db $c1, $50 ; env $50
    db $a3, $00 ; mod $00
    db $a0, $09 ; volume $09
    db $18, $20 ; note G#1 dur 32
    db $ad, $00 ; return $00
    db $a3, $23 ; mod $23
    db $c1, $2f ; env $2F
    db $a0, $0f ; volume $0F
    db $10, $08 ; note C1 dur 8
    db $17, $08 ; note G1 dur 8
    db $c0, $fe ; env $FE
    db $24, $0c ; note E2 dur 12
    db $a3, $20 ; mod $20
    db $c1, $6f ; env $6F
    db $a0, $09 ; volume $09
    db $24, $14 ; note E2 dur 20
    db $a3, $23 ; mod $23
    db $a0, $0f ; volume $0F
    db $10, $08 ; note C1 dur 8
    db $a0, $08 ; volume $08
    db $10, $08 ; note C1 dur 8
    db $c1, $2f ; env $2F
    db $a0, $0f ; volume $0F
    db $12, $08 ; note D1 dur 8
    db $19, $08 ; note A1 dur 8
    db $c0, $fe ; env $FE
    db $25, $0c ; note F2 dur 12
    db $a3, $20 ; mod $20
    db $c1, $6f ; env $6F
    db $a0, $09 ; volume $09
    db $25, $14 ; note F2 dur 20
    db $a3, $23 ; mod $23
    db $a0, $0f ; volume $0F
    db $12, $08 ; note D1 dur 8
    db $a0, $08 ; volume $08
    db $12, $08 ; note D1 dur 8
    db $c1, $2f ; env $2F
    db $a3, $23 ; mod $23
    db $a0, $0f ; volume $0F
    db $14, $08 ; note E1 dur 8
    db $1b, $08 ; note B1 dur 8
    db $c1, $5f ; env $5F
    db $24, $08 ; note E2 dur 8
    db $a0, $0a ; volume $0A
    db $24, $08 ; note E2 dur 8
    db $c1, $2f ; env $2F
    db $a3, $23 ; mod $23
    db $a0, $0f ; volume $0F
    db $09, $08 ; note A0 dur 8
    db $14, $08 ; note E1 dur 8
    db $c1, $5f ; env $5F
    db $21, $08 ; note C#2 dur 8
    db $a0, $08 ; volume $08
    db $21, $08 ; note C#2 dur 8
    db $c1, $3f ; env $3F
    db $a3, $23 ; mod $23
    db $a0, $0f ; volume $0F
    db $12, $08 ; note D1 dur 8
    db $19, $08 ; note A1 dur 8
    db $c1, $5f ; env $5F
    db $20, $10 ; note C2 dur 16
    db $c1, $5f ; env $5F
    db $1b, $08 ; note B1 dur 8
    db $c1, $3f ; env $3F
    db $a0, $04 ; volume $04
    db $1b, $08 ; note B1 dur 8
    db $a0, $09 ; volume $09
    db $c3, $68 ; env $68
    db $1b, $0c ; note B1 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $1b, $04 ; note B1 dur 4
    db $ad, $00 ; return $00

; sound track, 831 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_01::
    db $0a, $01, $09, $00 ; header: param=10 byte1=$01 volume=$09 byte3=$00
    db $ac, $01 ; call x1
    dw $0652 ; byte offset of the called section from the track start
    db $ac, $01 ; call x1
    dw $0402 ; byte offset of the called section from the track start
    db $23, $40 ; note D#2 dur 64
    db $22, $28 ; note D2 dur 40
    db $c1, $7f ; env $7F
    db $a3, $20 ; mod $20
    db $a0, $07 ; volume $07
    db $22, $10 ; note D2 dur 16
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0d ; volume $0D
    db $37, $08 ; note G3 dur 8
    db $ac, $01 ; call x1
    dw $0402 ; byte offset of the called section from the track start
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $23, $40 ; note D#2 dur 64
    db $22, $20 ; note D2 dur 32
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $07 ; volume $07
    db $22, $10 ; note D2 dur 16
    db $c3, $58 ; env $58
    db $a3, $05 ; mod $05
    db $a2, $02 ; duty2 $02
    db $a0, $0d ; volume $0D
    db $37, $08 ; note G3 dur 8
    db $39, $08 ; note A3 dur 8
    db $44, $10 ; note E4 dur 16
    db $42, $08 ; note D4 dur 8
    db $40, $08 ; note C4 dur 8
    db $44, $10 ; note E4 dur 16
    db $42, $08 ; note D4 dur 8
    db $40, $08 ; note C4 dur 8
    db $3b, $20 ; note B3 dur 32
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $07 ; volume $07
    db $3b, $10 ; note B3 dur 16
    db $c3, $58 ; env $58
    db $a3, $05 ; mod $05
    db $a0, $0d ; volume $0D
    db $40, $08 ; note C4 dur 8
    db $3b, $08 ; note B3 dur 8
    db $39, $10 ; note A3 dur 16
    db $3b, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $35, $10 ; note F3 dur 16
    db $37, $08 ; note G3 dur 8
    db $39, $08 ; note A3 dur 8
    db $37, $08 ; note G3 dur 8
    db $39, $08 ; note A3 dur 8
    db $34, $18 ; note E3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $34, $08 ; note E3 dur 8
    db $c3, $58 ; env $58
    db $a3, $05 ; mod $05
    db $a0, $0d ; volume $0D
    db $34, $0c ; note E3 dur 12
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $34, $04 ; note E3 dur 4
    db $c3, $58 ; env $58
    db $a0, $0d ; volume $0D
    db $34, $08 ; note E3 dur 8
    db $32, $08 ; note D3 dur 8
    db $40, $1c ; note C4 dur 28
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $0a ; volume $0A
    db $40, $04 ; note C4 dur 4
    db $c3, $58 ; env $58
    db $a3, $05 ; mod $05
    db $a0, $0d ; volume $0D
    db $3a, $08 ; note A#3 dur 8
    db $38, $08 ; note G#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $39, $08 ; note A3 dur 8
    db $3b, $08 ; note B3 dur 8
    db $40, $08 ; note C4 dur 8
    db $44, $10 ; note E4 dur 16
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $44, $08 ; note E4 dur 8
    db $c3, $58 ; env $58
    db $a3, $05 ; mod $05
    db $a0, $0d ; volume $0D
    db $34, $06 ; note E3 dur 6
    db $c1, $7f ; env $7F
    db $a0, $05 ; volume $05
    db $34, $02 ; note E3 dur 2
    db $c3, $58 ; env $58
    db $a0, $0d ; volume $0D
    db $34, $08 ; note E3 dur 8
    db $35, $08 ; note F3 dur 8
    db $29, $10 ; note A2 dur 16
    db $30, $10 ; note C3 dur 16
    db $32, $10 ; note D3 dur 16
    db $30, $20 ; note C3 dur 32
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $0a ; volume $0A
    db $30, $10 ; note C3 dur 16
    db $c4, $30 ; env $30
    db $a3, $05 ; mod $05
    db $a2, $02 ; duty2 $02
    db $a0, $0c ; volume $0C
    db $30, $02 ; note C3 dur 2
    db $32, $02 ; note D3 dur 2
    db $34, $02 ; note E3 dur 2
    db $35, $02 ; note F3 dur 2
    db $37, $02 ; note G3 dur 2
    db $39, $02 ; note A3 dur 2
    db $3b, $02 ; note B3 dur 2
    db $40, $02 ; note C4 dur 2
    db $c3, $68 ; env $68
    db $42, $08 ; note D4 dur 8
    db $39, $08 ; note A3 dur 8
    db $35, $08 ; note F3 dur 8
    db $32, $08 ; note D3 dur 8
    db $35, $08 ; note F3 dur 8
    db $38, $08 ; note G#3 dur 8
    db $42, $06 ; note D4 dur 6
    db $a0, $0a ; volume $0A
    db $42, $02 ; note D4 dur 2
    db $a0, $0d ; volume $0D
    db $44, $04 ; note E4 dur 4
    db $45, $04 ; note F4 dur 4
    db $44, $08 ; note E4 dur 8
    db $3b, $08 ; note B3 dur 8
    db $37, $08 ; note G3 dur 8
    db $34, $08 ; note E3 dur 8
    db $37, $08 ; note G3 dur 8
    db $3a, $08 ; note A#3 dur 8
    db $44, $06 ; note E4 dur 6
    db $a0, $0a ; volume $0A
    db $44, $02 ; note E4 dur 2
    db $a0, $0d ; volume $0D
    db $42, $04 ; note D4 dur 4
    db $40, $04 ; note C4 dur 4
    db $42, $08 ; note D4 dur 8
    db $39, $08 ; note A3 dur 8
    db $35, $08 ; note F3 dur 8
    db $32, $08 ; note D3 dur 8
    db $35, $08 ; note F3 dur 8
    db $38, $08 ; note G#3 dur 8
    db $40, $06 ; note C4 dur 6
    db $a0, $0a ; volume $0A
    db $40, $02 ; note C4 dur 2
    db $a0, $0d ; volume $0D
    db $44, $04 ; note E4 dur 4
    db $45, $04 ; note F4 dur 4
    db $44, $08 ; note E4 dur 8
    db $3b, $08 ; note B3 dur 8
    db $a0, $0c ; volume $0C
    db $37, $08 ; note G3 dur 8
    db $34, $08 ; note E3 dur 8
    db $a0, $0b ; volume $0B
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $37, $02 ; note G3 dur 2
    db $c3, $68 ; env $68
    db $a0, $0d ; volume $0D
    db $3a, $08 ; note A#3 dur 8
    db $39, $08 ; note A3 dur 8
    db $a0, $0d ; volume $0D
    db $37, $08 ; note G3 dur 8
    db $36, $20 ; note F#3 dur 32
    db $c1, $5f ; env $5F
    db $a3, $00 ; mod $00
    db $a0, $09 ; volume $09
    db $36, $08 ; note F#3 dur 8
    db $a0, $0d ; volume $0D
    db $a3, $05 ; mod $05
    db $c3, $58 ; env $58
    db $36, $08 ; note F#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $39, $08 ; note A3 dur 8
    db $c3, $02 ; env $02
    db $a0, $09 ; volume $09
    db $3b, $03 ; note B3 dur 3
    db $a0, $04 ; volume $04
    db $3b, $01 ; note B3 dur 1
    db $a0, $09 ; volume $09
    db $3b, $03 ; note B3 dur 3
    db $a0, $04 ; volume $04
    db $3b, $01 ; note B3 dur 1
    db $a0, $09 ; volume $09
    db $3a, $03 ; note A#3 dur 3
    db $a0, $04 ; volume $04
    db $3a, $01 ; note A#3 dur 1
    db $a0, $09 ; volume $09
    db $3b, $03 ; note B3 dur 3
    db $a0, $04 ; volume $04
    db $3b, $01 ; note B3 dur 1
    db $a0, $09 ; volume $09
    db $40, $03 ; note C4 dur 3
    db $a0, $04 ; volume $04
    db $40, $01 ; note C4 dur 1
    db $a0, $09 ; volume $09
    db $40, $03 ; note C4 dur 3
    db $a0, $04 ; volume $04
    db $40, $01 ; note C4 dur 1
    db $a0, $09 ; volume $09
    db $3b, $03 ; note B3 dur 3
    db $a0, $04 ; volume $04
    db $3b, $01 ; note B3 dur 1
    db $a0, $09 ; volume $09
    db $40, $03 ; note C4 dur 3
    db $a0, $04 ; volume $04
    db $40, $01 ; note C4 dur 1
    db $a0, $09 ; volume $09
    db $42, $03 ; note D4 dur 3
    db $a0, $04 ; volume $04
    db $42, $01 ; note D4 dur 1
    db $a0, $09 ; volume $09
    db $42, $03 ; note D4 dur 3
    db $a0, $04 ; volume $04
    db $42, $01 ; note D4 dur 1
    db $a0, $09 ; volume $09
    db $41, $03 ; note C#4 dur 3
    db $a0, $04 ; volume $04
    db $41, $01 ; note C#4 dur 1
    db $a0, $09 ; volume $09
    db $42, $03 ; note D4 dur 3
    db $a0, $04 ; volume $04
    db $42, $01 ; note D4 dur 1
    db $a0, $09 ; volume $09
    db $44, $03 ; note E4 dur 3
    db $a0, $04 ; volume $04
    db $44, $01 ; note E4 dur 1
    db $a0, $09 ; volume $09
    db $44, $03 ; note E4 dur 3
    db $a0, $04 ; volume $04
    db $44, $01 ; note E4 dur 1
    db $a0, $09 ; volume $09
    db $43, $03 ; note D#4 dur 3
    db $a0, $04 ; volume $04
    db $43, $01 ; note D#4 dur 1
    db $a0, $09 ; volume $09
    db $44, $03 ; note E4 dur 3
    db $a0, $04 ; volume $04
    db $44, $01 ; note E4 dur 1
    db $c3, $58 ; env $58
    db $a0, $0d ; volume $0D
    db $45, $03 ; note F4 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $45, $04 ; note F4 dur 4
    db $a0, $0d ; volume $0D
    db $44, $03 ; note E4 dur 3
    db $45, $03 ; note F4 dur 3
    db $44, $02 ; note E4 dur 2
    db $42, $03 ; note D4 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $42, $04 ; note D4 dur 4
    db $a0, $0d ; volume $0D
    db $40, $03 ; note C4 dur 3
    db $42, $03 ; note D4 dur 3
    db $40, $02 ; note C4 dur 2
    db $3b, $03 ; note B3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $3b, $04 ; note B3 dur 4
    db $a0, $0d ; volume $0D
    db $39, $03 ; note A3 dur 3
    db $3b, $03 ; note B3 dur 3
    db $39, $02 ; note A3 dur 2
    db $37, $03 ; note G3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $37, $04 ; note G3 dur 4
    db $a0, $0d ; volume $0D
    db $35, $03 ; note F3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $35, $04 ; note F3 dur 4
    db $a0, $0d ; volume $0D
    db $34, $18 ; note E3 dur 24
    db $35, $04 ; note F3 dur 4
    db $34, $04 ; note E3 dur 4
    db $32, $08 ; note D3 dur 8
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $32, $28 ; note D3 dur 40
    db $a3, $03 ; mod $03
    db $c3, $58 ; env $58
    db $a2, $01 ; duty2 $01
    db $a0, $0f ; volume $0F
    db $30, $04 ; note C3 dur 4
    db $32, $04 ; note D3 dur 4
    db $34, $04 ; note E3 dur 4
    db $35, $04 ; note F3 dur 4
    db $37, $18 ; note G3 dur 24
    db $40, $08 ; note C4 dur 8
    db $42, $10 ; note D4 dur 16
    db $37, $20 ; note G3 dur 32
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $0c ; volume $0C
    db $37, $20 ; note G3 dur 32
    db $a3, $03 ; mod $03
    db $c3, $58 ; env $58
    db $a0, $0f ; volume $0F
    db $29, $04 ; note A2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $30, $04 ; note C3 dur 4
    db $32, $04 ; note D3 dur 4
    db $30, $18 ; note C3 dur 24
    db $35, $08 ; note F3 dur 8
    db $34, $10 ; note E3 dur 16
    db $32, $10 ; note D3 dur 16
    db $31, $18 ; note C#3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $31, $18 ; note C#3 dur 24
    db $a3, $03 ; mod $03
    db $c3, $58 ; env $58
    db $a0, $0f ; volume $0F
    db $25, $10 ; note F2 dur 16
    db $28, $10 ; note G#2 dur 16
    db $32, $10 ; note D3 dur 16
    db $37, $30 ; note G3 dur 48
    db $a0, $0c ; volume $0C
    db $34, $10 ; note E3 dur 16
    db $a0, $0f ; volume $0F
    db $29, $10 ; note A2 dur 16
    db $35, $10 ; note F3 dur 16
    db $29, $10 ; note A2 dur 16
    db $2b, $10 ; note B2 dur 16
    db $30, $06 ; note C3 dur 6
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $30, $02 ; note C3 dur 2
    db $c3, $58 ; env $58
    db $a0, $0d ; volume $0D
    db $40, $08 ; note C4 dur 8
    db $37, $08 ; note G3 dur 8
    db $34, $08 ; note E3 dur 8
    db $30, $08 ; note C3 dur 8
    db $27, $06 ; note G2 dur 6
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $27, $02 ; note G2 dur 2
    db $c4, $38 ; env $38
    db $a2, $01 ; duty2 $01
    db $a0, $0b ; volume $0B
    db $25, $02 ; note F2 dur 2
    db $27, $02 ; note G2 dur 2
    db $29, $02 ; note A2 dur 2
    db $2b, $02 ; note B2 dur 2
    db $a0, $0a ; volume $0A
    db $30, $02 ; note C3 dur 2
    db $32, $02 ; note D3 dur 2
    db $a0, $08 ; volume $08
    db $34, $02 ; note E3 dur 2
    db $35, $02 ; note F3 dur 2
    db $ac, $01 ; call x1
    dw $0652 ; byte offset of the called section from the track start
    db $ac, $01 ; call x1
    dw $0402 ; byte offset of the called section from the track start
    db $23, $40 ; note D#2 dur 64
    db $c3, $68 ; env $68
    db $22, $20 ; note D2 dur 32
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $09 ; volume $09
    db $22, $10 ; note D2 dur 16
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0d ; volume $0D
    db $37, $0c ; note G3 dur 12
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $07 ; volume $07
    db $37, $04 ; note G3 dur 4
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0d ; volume $0D
    db $44, $18 ; note E4 dur 24
    db $42, $04 ; note D4 dur 4
    db $40, $04 ; note C4 dur 4
    db $42, $38 ; note D4 dur 56
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $0a ; volume $0A
    db $42, $18 ; note D4 dur 24
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0d ; volume $0D
    db $37, $0c ; note G3 dur 12
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $07 ; volume $07
    db $37, $04 ; note G3 dur 4
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0d ; volume $0D
    db $44, $18 ; note E4 dur 24
    db $42, $04 ; note D4 dur 4
    db $40, $04 ; note C4 dur 4
    db $42, $40 ; note D4 dur 64
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $08 ; volume $08
    db $42, $10 ; note D4 dur 16
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0d ; volume $0D
    db $44, $10 ; note E4 dur 16
    db $40, $08 ; note C4 dur 8
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $07 ; volume $07
    db $40, $08 ; note C4 dur 8
    db $a2, $02 ; duty2 $02
    db $a3, $05 ; mod $05
    db $c3, $48 ; env $48
    db $a0, $0d ; volume $0D
    db $20, $06 ; note C2 dur 6
    db $a0, $03 ; volume $03
    db $20, $02 ; note C2 dur 2
    db $a0, $0d ; volume $0D
    db $23, $06 ; note D#2 dur 6
    db $a0, $03 ; volume $03
    db $23, $02 ; note D#2 dur 2
    db $a0, $0d ; volume $0D
    db $23, $06 ; note D#2 dur 6
    db $a0, $04 ; volume $04
    db $23, $02 ; note D#2 dur 2
    db $a0, $0d ; volume $0D
    db $28, $06 ; note G#2 dur 6
    db $a0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $a0, $0d ; volume $0D
    db $28, $06 ; note G#2 dur 6
    db $a0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $a0, $0d ; volume $0D
    db $30, $06 ; note C3 dur 6
    db $a0, $04 ; volume $04
    db $30, $02 ; note C3 dur 2
    db $a0, $0d ; volume $0D
    db $29, $06 ; note A2 dur 6
    db $a0, $04 ; volume $04
    db $29, $02 ; note A2 dur 2
    db $a0, $0d ; volume $0D
    db $30, $06 ; note C3 dur 6
    db $a0, $04 ; volume $04
    db $30, $02 ; note C3 dur 2
    db $a0, $0d ; volume $0D
    db $35, $06 ; note F3 dur 6
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $0d ; volume $0D
    db $39, $06 ; note A3 dur 6
    db $a0, $04 ; volume $04
    db $39, $02 ; note A3 dur 2
    db $a0, $0d ; volume $0D
    db $40, $06 ; note C4 dur 6
    db $c1, $30 ; env $30
    db $a0, $04 ; volume $04
    db $40, $0a ; note C4 dur 10
    db $c3, $48 ; env $48
    db $a0, $0d ; volume $0D
    db $30, $0c ; note C3 dur 12
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $30, $04 ; note C3 dur 4
    db $c3, $78 ; env $78
    db $a0, $0b ; volume $0B
    db $fd, $f0 ; label 0
    db $37, $02 ; note G3 dur 2
    db $39, $02 ; note A3 dur 2
    db $bf, $f0 ; repeat $F0
    db $af, $04 ; param $04
    db $fd, $f0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $bf, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $bf, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $bf, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $b5, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $bb, $f0 ; repeat $F0
    db $a7, $02 ; wait $02
    db $c3, $68 ; env $68
    db $37, $10 ; note G3 dur 16
    db $a0, $03 ; volume $03
    db $c1, $70 ; env $70
    db $37, $20 ; note G3 dur 32
    db $ff, $ff ; end
    db $a3, $02 ; mod $02
    db $44, $18 ; note E4 dur 24
    db $42, $04 ; note D4 dur 4
    db $40, $04 ; note C4 dur 4
    db $42, $18 ; note D4 dur 24
    db $40, $04 ; note C4 dur 4
    db $3b, $04 ; note B3 dur 4
    db $40, $18 ; note C4 dur 24
    db $3b, $04 ; note B3 dur 4
    db $39, $04 ; note A3 dur 4
    db $3b, $18 ; note B3 dur 24
    db $a0, $0d ; volume $0D
    db $39, $04 ; note A3 dur 4
    db $a0, $0c ; volume $0C
    db $37, $04 ; note G3 dur 4
    db $34, $08 ; note E3 dur 8
    db $a0, $0d ; volume $0D
    db $35, $08 ; note F3 dur 8
    db $a0, $0d ; volume $0D
    db $37, $08 ; note G3 dur 8
    db $a0, $0d ; volume $0D
    db $39, $07 ; note A3 dur 7
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $39, $01 ; note A3 dur 1
    db $c3, $68 ; env $68
    db $a0, $0d ; volume $0D
    db $39, $18 ; note A3 dur 24
    db $37, $04 ; note G3 dur 4
    db $35, $04 ; note F3 dur 4
    db $a0, $0d ; volume $0D
    db $32, $20 ; note D3 dur 32
    db $a0, $0b ; volume $0B
    db $34, $18 ; note E3 dur 24
    db $a3, $00 ; mod $00
    db $c1, $6f ; env $6F
    db $a0, $06 ; volume $06
    db $34, $08 ; note E3 dur 8
    db $a0, $0d ; volume $0D
    db $a3, $00 ; mod $00
    db $c3, $68 ; env $68
    db $35, $18 ; note F3 dur 24
    db $a3, $03 ; mod $03
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $a3, $00 ; mod $00
    db $32, $18 ; note D3 dur 24
    db $a3, $03 ; mod $03
    db $34, $04 ; note E3 dur 4
    db $35, $04 ; note F3 dur 4
    db $a3, $00 ; mod $00
    db $37, $18 ; note G3 dur 24
    db $a3, $03 ; mod $03
    db $39, $04 ; note A3 dur 4
    db $3b, $04 ; note B3 dur 4
    db $a3, $00 ; mod $00
    db $34, $18 ; note E3 dur 24
    db $a3, $03 ; mod $03
    db $35, $04 ; note F3 dur 4
    db $37, $04 ; note G3 dur 4
    db $a0, $0d ; volume $0D
    db $39, $18 ; note A3 dur 24
    db $c1, $4f ; env $4F
    db $a3, $00 ; mod $00
    db $a0, $09 ; volume $09
    db $39, $08 ; note A3 dur 8
    db $a3, $03 ; mod $03
    db $c3, $68 ; env $68
    db $a0, $0d ; volume $0D
    db $39, $08 ; note A3 dur 8
    db $c1, $70 ; env $70
    db $a0, $04 ; volume $04
    db $39, $03 ; note A3 dur 3
    db $c3, $68 ; env $68
    db $a0, $0d ; volume $0D
    db $40, $08 ; note C4 dur 8
    db $c1, $70 ; env $70
    db $a0, $04 ; volume $04
    db $40, $03 ; note C4 dur 3
    db $c3, $68 ; env $68
    db $a0, $0d ; volume $0D
    db $39, $07 ; note A3 dur 7
    db $c1, $70 ; env $70
    db $a0, $04 ; volume $04
    db $39, $03 ; note A3 dur 3
    db $c3, $68 ; env $68
    db $a0, $0d ; volume $0D
    db $34, $20 ; note E3 dur 32
    db $32, $0c ; note D3 dur 12
    db $c1, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $32, $04 ; note D3 dur 4
    db $c3, $68 ; env $68
    db $a0, $0d ; volume $0D
    db $34, $10 ; note E3 dur 16
    db $a0, $0c ; volume $0C
    db $30, $08 ; note C3 dur 8
    db $a0, $07 ; volume $07
    db $30, $08 ; note C3 dur 8
    db $a0, $0d ; volume $0D
    db $40, $10 ; note C4 dur 16
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $0c ; volume $0C
    db $40, $08 ; note C4 dur 8
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0d ; volume $0D
    db $38, $08 ; note G#3 dur 8
    db $a0, $0d ; volume $0D
    db $3a, $08 ; note A#3 dur 8
    db $40, $08 ; note C4 dur 8
    db $42, $04 ; note D4 dur 4
    db $43, $04 ; note D#4 dur 4
    db $42, $04 ; note D4 dur 4
    db $3a, $04 ; note A#3 dur 4
    db $a0, $0d ; volume $0D
    db $37, $10 ; note G3 dur 16
    db $c1, $6f ; env $6F
    db $a3, $00 ; mod $00
    db $a0, $08 ; volume $08
    db $37, $08 ; note G3 dur 8
    db $c3, $68 ; env $68
    db $a3, $03 ; mod $03
    db $a0, $0d ; volume $0D
    db $33, $08 ; note D#3 dur 8
    db $35, $08 ; note F3 dur 8
    db $37, $07 ; note G3 dur 7
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $37, $01 ; note G3 dur 1
    db $c3, $7f ; env $7F
    db $a0, $0d ; volume $0D
    db $37, $06 ; note G3 dur 6
    db $a0, $0a ; volume $0A
    db $37, $02 ; note G3 dur 2
    db $a0, $0d ; volume $0D
    db $35, $0c ; note F3 dur 12
    db $a0, $0a ; volume $0A
    db $35, $04 ; note F3 dur 4
    db $a0, $0d ; volume $0D
    db $33, $0c ; note D#3 dur 12
    db $a0, $0a ; volume $0A
    db $33, $04 ; note D#3 dur 4
    db $a0, $0d ; volume $0D
    db $32, $0c ; note D3 dur 12
    db $a0, $0a ; volume $0A
    db $32, $04 ; note D3 dur 4
    db $a0, $0d ; volume $0D
    db $30, $06 ; note C3 dur 6
    db $a0, $0a ; volume $0A
    db $30, $02 ; note C3 dur 2
    db $a0, $0d ; volume $0D
    db $33, $06 ; note D#3 dur 6
    db $a0, $0a ; volume $0A
    db $33, $02 ; note D#3 dur 2
    db $a0, $0d ; volume $0D
    db $32, $0c ; note D3 dur 12
    db $a0, $0a ; volume $0A
    db $32, $04 ; note D3 dur 4
    db $a0, $0d ; volume $0D
    db $30, $0c ; note C3 dur 12
    db $a0, $0a ; volume $0A
    db $30, $04 ; note C3 dur 4
    db $a0, $0d ; volume $0D
    db $2a, $0c ; note A#2 dur 12
    db $a0, $0a ; volume $0A
    db $2a, $04 ; note A#2 dur 4
    db $a0, $0d ; volume $0D
    db $28, $06 ; note G#2 dur 6
    db $c1, $50 ; env $50
    db $a0, $08 ; volume $08
    db $28, $0a ; note G#2 dur 10
    db $c3, $48 ; env $48
    db $a3, $25 ; mod $25
    db $a0, $0d ; volume $0D
    db $27, $03 ; note G2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $04 ; note G2 dur 4
    db $a0, $0d ; volume $0D
    db $32, $03 ; note D3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $32, $04 ; note D3 dur 4
    db $a0, $0c ; volume $0C
    db $27, $08 ; note G2 dur 8
    db $c1, $5f ; env $5F
    db $a3, $20 ; mod $20
    db $a0, $06 ; volume $06
    db $27, $08 ; note G2 dur 8
    db $a3, $25 ; mod $25
    db $c3, $48 ; env $48
    db $a0, $0d ; volume $0D
    db $27, $03 ; note G2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $04 ; note G2 dur 4
    db $a0, $0d ; volume $0D
    db $30, $03 ; note C3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $30, $04 ; note C3 dur 4
    db $a0, $0c ; volume $0C
    db $27, $08 ; note G2 dur 8
    db $c1, $5f ; env $5F
    db $a3, $20 ; mod $20
    db $a0, $06 ; volume $06
    db $27, $08 ; note G2 dur 8
    db $c3, $48 ; env $48
    db $a3, $25 ; mod $25
    db $a0, $0d ; volume $0D
    db $25, $03 ; note F2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $25, $04 ; note F2 dur 4
    db $a0, $0d ; volume $0D
    db $28, $03 ; note G#2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $28, $04 ; note G#2 dur 4
    db $a0, $0c ; volume $0C
    db $25, $08 ; note F2 dur 8
    db $c1, $5f ; env $5F
    db $a3, $20 ; mod $20
    db $a0, $06 ; volume $06
    db $25, $08 ; note F2 dur 8
    db $c3, $48 ; env $48
    db $a3, $25 ; mod $25
    db $a0, $0d ; volume $0D
    db $25, $03 ; note F2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $25, $04 ; note F2 dur 4
    db $a0, $0d ; volume $0D
    db $27, $03 ; note G2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $27, $04 ; note G2 dur 4
    db $a0, $0c ; volume $0C
    db $25, $0a ; note F2 dur 10
    db $c1, $7f ; env $7F
    db $a3, $20 ; mod $20
    db $a0, $08 ; volume $08
    db $25, $06 ; note F2 dur 6
    db $c3, $68 ; env $68
    db $a3, $25 ; mod $25
    db $a0, $0d ; volume $0D
    db $23, $08 ; note D#2 dur 8
    db $22, $08 ; note D2 dur 8
    db $23, $08 ; note D#2 dur 8
    db $a0, $0e ; volume $0E
    db $27, $14 ; note G2 dur 20
    db $c1, $6f ; env $6F
    db $a3, $20 ; mod $20
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $c3, $68 ; env $68
    db $a3, $25 ; mod $25
    db $a0, $0e ; volume $0E
    db $27, $10 ; note G2 dur 16
    db $c3, $48 ; env $48
    db $a3, $25 ; mod $25
    db $a0, $0d ; volume $0D
    db $25, $08 ; note F2 dur 8
    db $24, $08 ; note E2 dur 8
    db $25, $08 ; note F2 dur 8
    db $a3, $fe ; mod $FE
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $30, $14 ; note C3 dur 20
    db $c1, $6f ; env $6F
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $30, $04 ; note C3 dur 4
    db $c0, $fe ; env $FE
    db $a3, $25 ; mod $25
    db $a0, $09 ; volume $09
    db $20, $10 ; note C2 dur 16
    db $c1, $5f ; env $5F
    db $a3, $20 ; mod $20
    db $a0, $07 ; volume $07
    db $20, $08 ; note C2 dur 8
    db $c3, $78 ; env $78
    db $a3, $25 ; mod $25
    db $a0, $0f ; volume $0F
    db $20, $10 ; note C2 dur 16
    db $22, $10 ; note D2 dur 16
    db $a0, $0e ; volume $0E
    db $23, $10 ; note D#2 dur 16
    db $a0, $0d ; volume $0D
    db $27, $10 ; note G2 dur 16
    db $25, $10 ; note F2 dur 16
    db $20, $10 ; note C2 dur 16
    db $22, $10 ; note D2 dur 16
    db $ad, $00 ; return $00
    db $a3, $03 ; mod $03
    db $c3, $7f ; env $7F
    db $a0, $08 ; volume $08
    db $fd, $f0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $35, $04 ; note F3 dur 4
    db $37, $04 ; note G3 dur 4
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $34, $04 ; note E3 dur 4
    db $35, $04 ; note F3 dur 4
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $32, $04 ; note D3 dur 4
    db $34, $04 ; note E3 dur 4
    db $b3, $f0 ; repeat $F0
    db $32, $0d ; note D3 dur 13
    db $a3, $00 ; mod $00
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $32, $0b ; note D3 dur 11
    db $a3, $05 ; mod $05
    db $c3, $68 ; env $68
    db $a0, $0d ; volume $0D
    db $37, $08 ; note G3 dur 8
    db $ad, $00 ; return $00

; sound track, 1284 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_02::
    db $0a, $7f, $02, $05 ; header: param=10 byte1=$7F volume=$02 byte3=$05
    db $ac, $01 ; call x1
    dw $09e0 ; byte offset of the called section from the track start
    db $ac, $01 ; call x1
    dw $0720 ; byte offset of the called section from the track start
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $a1, $0f ; duty $0F
    db $3b, $0c ; note B3 dur 12
    db $a0, $06 ; volume $06
    db $3b, $04 ; note B3 dur 4
    db $a0, $02 ; volume $02
    db $37, $0c ; note G3 dur 12
    db $a0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a0, $02 ; volume $02
    db $2b, $0c ; note B2 dur 12
    db $a0, $06 ; volume $06
    db $2b, $04 ; note B2 dur 4
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a1, $0f ; duty $0F
    db $a0, $02 ; volume $02
    db $17, $0c ; note G1 dur 12
    db $a0, $06 ; volume $06
    db $17, $04 ; note G1 dur 4
    db $1f, $10 ; rest-note $1F dur 16
    db $ac, $01 ; call x1
    dw $0720 ; byte offset of the called section from the track start
    db $a2, $7f ; duty2 $7F
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $a1, $0f ; duty $0F
    db $3b, $0c ; note B3 dur 12
    db $a0, $06 ; volume $06
    db $3b, $04 ; note B3 dur 4
    db $a0, $02 ; volume $02
    db $37, $0c ; note G3 dur 12
    db $a0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a0, $02 ; volume $02
    db $2b, $0c ; note B2 dur 12
    db $a0, $06 ; volume $06
    db $2b, $04 ; note B2 dur 4
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a2, $1c ; duty2 $1C
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $17, $04 ; note G1 dur 4
    db $a1, $0f ; duty $0F
    db $27, $04 ; note G2 dur 4
    db $27, $04 ; note G2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $2b, $04 ; note B2 dur 4
    db $32, $04 ; note D3 dur 4
    db $32, $04 ; note D3 dur 4
    db $35, $04 ; note F3 dur 4
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $1f, $0a ; rest-note $1F dur 10
    db $a3, $0b ; mod $0B
    db $a0, $02 ; volume $02
    db $a2, $ff ; duty2 $FF
    db $a1, $07 ; duty $07
    db $27, $0e ; note G2 dur 14
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $a0, $02 ; volume $02
    db $37, $1c ; note G3 dur 28
    db $a3, $00 ; mod $00
    db $a0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $a3, $0b ; mod $0B
    db $a0, $02 ; volume $02
    db $34, $08 ; note E3 dur 8
    db $a0, $04 ; volume $04
    db $34, $03 ; note E3 dur 3
    db $a0, $02 ; volume $02
    db $35, $08 ; note F3 dur 8
    db $a0, $04 ; volume $04
    db $35, $03 ; note F3 dur 3
    db $a0, $02 ; volume $02
    db $37, $07 ; note G3 dur 7
    db $a0, $04 ; volume $04
    db $37, $03 ; note G3 dur 3
    db $a0, $02 ; volume $02
    db $3b, $20 ; note B3 dur 32
    db $a2, $30 ; duty2 $30
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $3b, $10 ; note B3 dur 16
    db $a3, $0b ; mod $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $29, $0e ; note A2 dur 14
    db $a0, $04 ; volume $04
    db $29, $02 ; note A2 dur 2
    db $a0, $02 ; volume $02
    db $39, $1c ; note A3 dur 28
    db $a3, $00 ; mod $00
    db $a0, $04 ; volume $04
    db $39, $04 ; note A3 dur 4
    db $a3, $0b ; mod $0B
    db $a0, $02 ; volume $02
    db $2b, $08 ; note B2 dur 8
    db $a0, $04 ; volume $04
    db $2b, $03 ; note B2 dur 3
    db $a0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $a0, $04 ; volume $04
    db $30, $03 ; note C3 dur 3
    db $a0, $02 ; volume $02
    db $32, $07 ; note D3 dur 7
    db $a0, $04 ; volume $04
    db $32, $03 ; note D3 dur 3
    db $a0, $02 ; volume $02
    db $37, $20 ; note G3 dur 32
    db $a3, $00 ; mod $00
    db $a2, $40 ; duty2 $40
    db $a0, $04 ; volume $04
    db $37, $10 ; note G3 dur 16
    db $a3, $0b ; mod $0B
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $29, $0f ; note A2 dur 15
    db $a0, $04 ; volume $04
    db $29, $01 ; note A2 dur 1
    db $a0, $02 ; volume $02
    db $34, $0f ; note E3 dur 15
    db $a0, $04 ; volume $04
    db $34, $01 ; note E3 dur 1
    db $a0, $02 ; volume $02
    db $30, $0f ; note C3 dur 15
    db $a0, $04 ; volume $04
    db $30, $01 ; note C3 dur 1
    db $a0, $02 ; volume $02
    db $2b, $0f ; note B2 dur 15
    db $a0, $04 ; volume $04
    db $2b, $01 ; note B2 dur 1
    db $a0, $02 ; volume $02
    db $30, $0f ; note C3 dur 15
    db $a0, $04 ; volume $04
    db $30, $01 ; note C3 dur 1
    db $a0, $02 ; volume $02
    db $31, $08 ; note C#3 dur 8
    db $a0, $04 ; volume $04
    db $31, $03 ; note C#3 dur 3
    db $a0, $02 ; volume $02
    db $3a, $08 ; note A#3 dur 8
    db $a0, $04 ; volume $04
    db $3a, $03 ; note A#3 dur 3
    db $a0, $02 ; volume $02
    db $39, $07 ; note A3 dur 7
    db $a0, $04 ; volume $04
    db $39, $03 ; note A3 dur 3
    db $a0, $02 ; volume $02
    db $37, $16 ; note G3 dur 22
    db $a0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $a0, $02 ; volume $02
    db $35, $07 ; note F3 dur 7
    db $a0, $04 ; volume $04
    db $35, $01 ; note F3 dur 1
    db $a0, $02 ; volume $02
    db $39, $16 ; note A3 dur 22
    db $a0, $04 ; volume $04
    db $39, $02 ; note A3 dur 2
    db $a0, $02 ; volume $02
    db $3b, $07 ; note B3 dur 7
    db $a0, $04 ; volume $04
    db $3b, $01 ; note B3 dur 1
    db $a0, $02 ; volume $02
    db $a1, $0f ; duty $0F
    db $34, $04 ; note E3 dur 4
    db $a0, $06 ; volume $06
    db $34, $04 ; note E3 dur 4
    db $a3, $05 ; mod $05
    db $a1, $0f ; duty $0F
    db $a0, $02 ; volume $02
    db $3b, $08 ; note B3 dur 8
    db $39, $08 ; note A3 dur 8
    db $37, $08 ; note G3 dur 8
    db $35, $08 ; note F3 dur 8
    db $34, $08 ; note E3 dur 8
    db $32, $08 ; note D3 dur 8
    db $34, $08 ; note E3 dur 8
    db $fd, $f0 ; label 0
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a2, $20 ; duty2 $20
    db $a1, $02 ; duty $02
    db $35, $04 ; note F3 dur 4
    db $a0, $04 ; volume $04
    db $35, $0c ; note F3 dur 12
    db $a0, $02 ; volume $02
    db $35, $04 ; note F3 dur 4
    db $a0, $04 ; volume $04
    db $35, $04 ; note F3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a2, $20 ; duty2 $20
    db $a1, $02 ; duty $02
    db $35, $04 ; note F3 dur 4
    db $a0, $04 ; volume $04
    db $35, $0c ; note F3 dur 12
    db $a2, $0f ; duty2 $0F
    db $a1, $0f ; duty $0F
    db $a0, $02 ; volume $02
    db $35, $04 ; note F3 dur 4
    db $35, $04 ; note F3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $20, $08 ; note C2 dur 8
    db $a2, $20 ; duty2 $20
    db $a1, $02 ; duty $02
    db $34, $04 ; note E3 dur 4
    db $a0, $04 ; volume $04
    db $34, $0c ; note E3 dur 12
    db $a0, $02 ; volume $02
    db $34, $04 ; note E3 dur 4
    db $a0, $04 ; volume $04
    db $34, $04 ; note E3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a2, $20 ; duty2 $20
    db $a1, $02 ; duty $02
    db $34, $04 ; note E3 dur 4
    db $a0, $04 ; volume $04
    db $34, $0c ; note E3 dur 12
    db $a2, $0f ; duty2 $0F
    db $a1, $0f ; duty $0F
    db $a0, $02 ; volume $02
    db $34, $04 ; note E3 dur 4
    db $34, $04 ; note E3 dur 4
    db $b1, $f0 ; repeat $F0
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $20, $08 ; note C2 dur 8
    db $a2, $20 ; duty2 $20
    db $a1, $02 ; duty $02
    db $32, $04 ; note D3 dur 4
    db $a0, $04 ; volume $04
    db $32, $0c ; note D3 dur 12
    db $a0, $02 ; volume $02
    db $32, $04 ; note D3 dur 4
    db $a0, $04 ; volume $04
    db $32, $04 ; note D3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a2, $20 ; duty2 $20
    db $a1, $02 ; duty $02
    db $32, $04 ; note D3 dur 4
    db $a0, $04 ; volume $04
    db $32, $0c ; note D3 dur 12
    db $a2, $0f ; duty2 $0F
    db $a1, $0f ; duty $0F
    db $a0, $02 ; volume $02
    db $32, $04 ; note D3 dur 4
    db $32, $04 ; note D3 dur 4
    db $a2, $50 ; duty2 $50
    db $a1, $09 ; duty $09
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $17, $04 ; note G1 dur 4
    db $a0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $b7, $f0 ; repeat $F0
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $a0, $04 ; volume $04
    db $17, $10 ; note G1 dur 16
    db $a1, $02 ; duty $02
    db $a0, $06 ; volume $06
    db $4b, $04 ; note B4 dur 4
    db $4b, $04 ; note B4 dur 4
    db $49, $03 ; note A4 dur 3
    db $4b, $03 ; note B4 dur 3
    db $49, $02 ; note A4 dur 2
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $27, $08 ; note G2 dur 8
    db $a2, $28 ; duty2 $28
    db $a0, $04 ; volume $04
    db $27, $10 ; note G2 dur 16
    db $a0, $02 ; volume $02
    db $27, $04 ; note G2 dur 4
    db $a0, $04 ; volume $04
    db $27, $04 ; note G2 dur 4
    db $a0, $02 ; volume $02
    db $17, $04 ; note G1 dur 4
    db $a0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $a0, $02 ; volume $02
    db $17, $04 ; note G1 dur 4
    db $a0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $1f, $04 ; rest-note $1F dur 4
    db $a1, $02 ; duty $02
    db $a0, $06 ; volume $06
    db $27, $08 ; note G2 dur 8
    db $29, $04 ; note A2 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $20, $04 ; note C2 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $47, $04 ; note G4 dur 4
    db $44, $04 ; note E4 dur 4
    db $40, $04 ; note C4 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $20, $04 ; note C2 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $44, $04 ; note E4 dur 4
    db $40, $04 ; note C4 dur 4
    db $44, $04 ; note E4 dur 4
    db $40, $04 ; note C4 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $14, $04 ; note E1 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $42, $04 ; note D4 dur 4
    db $37, $04 ; note G3 dur 4
    db $3b, $04 ; note B3 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $24, $04 ; note E2 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $42, $04 ; note D4 dur 4
    db $37, $04 ; note G3 dur 4
    db $3b, $04 ; note B3 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $19, $04 ; note A1 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $34, $04 ; note E3 dur 4
    db $30, $04 ; note C3 dur 4
    db $29, $04 ; note A2 dur 4
    db $30, $04 ; note C3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $22, $04 ; note D2 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $39, $04 ; note A3 dur 4
    db $35, $04 ; note F3 dur 4
    db $39, $04 ; note A3 dur 4
    db $32, $04 ; note D3 dur 4
    db $39, $04 ; note A3 dur 4
    db $35, $04 ; note F3 dur 4
    db $39, $04 ; note A3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $14, $04 ; note E1 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $3b, $04 ; note B3 dur 4
    db $37, $04 ; note G3 dur 4
    db $3b, $04 ; note B3 dur 4
    db $32, $04 ; note D3 dur 4
    db $3b, $04 ; note B3 dur 4
    db $37, $04 ; note G3 dur 4
    db $3b, $04 ; note B3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $19, $04 ; note A1 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $37, $04 ; note G3 dur 4
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $29, $04 ; note A2 dur 4
    db $37, $04 ; note G3 dur 4
    db $31, $04 ; note C#3 dur 4
    db $37, $04 ; note G3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $15, $04 ; note F1 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $39, $04 ; note A3 dur 4
    db $40, $04 ; note C4 dur 4
    db $39, $04 ; note A3 dur 4
    db $45, $04 ; note F4 dur 4
    db $39, $04 ; note A3 dur 4
    db $40, $04 ; note C4 dur 4
    db $39, $04 ; note A3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $15, $04 ; note F1 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $45, $04 ; note F4 dur 4
    db $48, $04 ; note G#4 dur 4
    db $45, $04 ; note F4 dur 4
    db $48, $04 ; note G#4 dur 4
    db $45, $04 ; note F4 dur 4
    db $35, $04 ; note F3 dur 4
    db $30, $04 ; note C3 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $14, $04 ; note E1 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $42, $04 ; note D4 dur 4
    db $3b, $04 ; note B3 dur 4
    db $42, $04 ; note D4 dur 4
    db $34, $04 ; note E3 dur 4
    db $42, $04 ; note D4 dur 4
    db $37, $04 ; note G3 dur 4
    db $42, $04 ; note D4 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $19, $04 ; note A1 dur 4
    db $a2, $18 ; duty2 $18
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $41, $04 ; note C#4 dur 4
    db $37, $04 ; note G3 dur 4
    db $41, $04 ; note C#4 dur 4
    db $39, $04 ; note A3 dur 4
    db $41, $04 ; note C#4 dur 4
    db $37, $04 ; note G3 dur 4
    db $41, $04 ; note C#4 dur 4
    db $a2, $ff ; duty2 $FF
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $12, $0c ; note D1 dur 12
    db $a0, $04 ; volume $04
    db $12, $04 ; note D1 dur 4
    db $a0, $02 ; volume $02
    db $22, $0c ; note D2 dur 12
    db $a0, $04 ; volume $04
    db $22, $04 ; note D2 dur 4
    db $a0, $02 ; volume $02
    db $17, $0c ; note G1 dur 12
    db $a0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $a0, $04 ; volume $04
    db $27, $04 ; note G2 dur 4
    db $a2, $ff ; duty2 $FF
    db $a0, $02 ; volume $02
    db $20, $20 ; note C2 dur 32
    db $a2, $40 ; duty2 $40
    db $a0, $04 ; volume $04
    db $20, $10 ; note C2 dur 16
    db $a0, $02 ; volume $02
    db $17, $0c ; note G1 dur 12
    db $a0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $ac, $01 ; call x1
    dw $09e0 ; byte offset of the called section from the track start
    db $ac, $01 ; call x1
    dw $0720 ; byte offset of the called section from the track start
    db $a2, $7f ; duty2 $7F
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $a1, $0f ; duty $0F
    db $3b, $0c ; note B3 dur 12
    db $a0, $06 ; volume $06
    db $3b, $04 ; note B3 dur 4
    db $a0, $02 ; volume $02
    db $37, $0c ; note G3 dur 12
    db $a0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $27, $0c ; note G2 dur 12
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a2, $ff ; duty2 $FF
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $2b, $10 ; note B2 dur 16
    db $a2, $7f ; duty2 $7F
    db $27, $0c ; note G2 dur 12
    db $a0, $04 ; volume $04
    db $27, $04 ; note G2 dur 4
    db $a0, $02 ; volume $02
    db $17, $02 ; note G1 dur 2
    db $a0, $04 ; volume $04
    db $17, $02 ; note G1 dur 2
    db $a0, $02 ; volume $02
    db $27, $02 ; note G2 dur 2
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $a0, $02 ; volume $02
    db $27, $02 ; note G2 dur 2
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $a0, $02 ; volume $02
    db $2b, $02 ; note B2 dur 2
    db $a0, $04 ; volume $04
    db $2b, $02 ; note B2 dur 2
    db $a0, $02 ; volume $02
    db $2b, $02 ; note B2 dur 2
    db $a0, $04 ; volume $04
    db $2b, $02 ; note B2 dur 2
    db $a0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $fd, $f0 ; label 0
    db $a2, $ff ; duty2 $FF
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $a2, $7f ; duty2 $7F
    db $a1, $03 ; duty $03
    db $25, $02 ; note F2 dur 2
    db $a0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $a0, $02 ; volume $02
    db $25, $02 ; note F2 dur 2
    db $a0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $a0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $02 ; volume $02
    db $3a, $02 ; note A#3 dur 2
    db $a0, $04 ; volume $04
    db $3a, $02 ; note A#3 dur 2
    db $a0, $02 ; volume $02
    db $3a, $02 ; note A#3 dur 2
    db $a0, $04 ; volume $04
    db $3a, $02 ; note A#3 dur 2
    db $a0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $a0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $a0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $a0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $a0, $02 ; volume $02
    db $45, $02 ; note F4 dur 2
    db $a0, $04 ; volume $04
    db $45, $02 ; note F4 dur 2
    db $a0, $02 ; volume $02
    db $42, $02 ; note D4 dur 2
    db $a0, $04 ; volume $04
    db $42, $02 ; note D4 dur 2
    db $a0, $02 ; volume $02
    db $3a, $02 ; note A#3 dur 2
    db $a0, $04 ; volume $04
    db $3a, $02 ; note A#3 dur 2
    db $a0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a2, $ff ; duty2 $FF
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a2, $7f ; duty2 $7F
    db $a1, $03 ; duty $03
    db $2b, $02 ; note B2 dur 2
    db $a0, $04 ; volume $04
    db $2b, $02 ; note B2 dur 2
    db $a0, $02 ; volume $02
    db $2b, $02 ; note B2 dur 2
    db $a0, $04 ; volume $04
    db $2b, $02 ; note B2 dur 2
    db $a0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $02 ; volume $02
    db $3a, $02 ; note A#3 dur 2
    db $a0, $04 ; volume $04
    db $3a, $02 ; note A#3 dur 2
    db $a0, $02 ; volume $02
    db $35, $02 ; note F3 dur 2
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a0, $02 ; volume $02
    db $2a, $02 ; note A#2 dur 2
    db $a0, $04 ; volume $04
    db $2a, $02 ; note A#2 dur 2
    db $a0, $02 ; volume $02
    db $37, $02 ; note G3 dur 2
    db $a0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $a0, $02 ; volume $02
    db $32, $02 ; note D3 dur 2
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a0, $02 ; volume $02
    db $2b, $02 ; note B2 dur 2
    db $a0, $04 ; volume $04
    db $2b, $02 ; note B2 dur 2
    db $a0, $02 ; volume $02
    db $27, $02 ; note G2 dur 2
    db $a0, $04 ; volume $04
    db $27, $02 ; note G2 dur 2
    db $b1, $f0 ; repeat $F0
    db $a2, $ff ; duty2 $FF
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $18, $0c ; note G#1 dur 12
    db $a0, $04 ; volume $04
    db $18, $04 ; note G#1 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $23, $06 ; note D#2 dur 6
    db $a0, $04 ; volume $04
    db $23, $02 ; note D#2 dur 2
    db $a0, $02 ; volume $02
    db $28, $06 ; note G#2 dur 6
    db $a0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $a0, $02 ; volume $02
    db $28, $06 ; note G#2 dur 6
    db $a0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $a0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $a0, $04 ; volume $04
    db $30, $02 ; note C3 dur 2
    db $a0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $a0, $04 ; volume $04
    db $30, $02 ; note C3 dur 2
    db $a0, $02 ; volume $02
    db $33, $06 ; note D#3 dur 6
    db $a0, $04 ; volume $04
    db $33, $02 ; note D#3 dur 2
    db $a0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $a0, $04 ; volume $04
    db $30, $02 ; note C3 dur 2
    db $a0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a0, $02 ; volume $02
    db $39, $06 ; note A3 dur 6
    db $a0, $04 ; volume $04
    db $39, $02 ; note A3 dur 2
    db $a0, $02 ; volume $02
    db $40, $06 ; note C4 dur 6
    db $a0, $04 ; volume $04
    db $40, $02 ; note C4 dur 2
    db $a0, $02 ; volume $02
    db $45, $06 ; note F4 dur 6
    db $a0, $04 ; volume $04
    db $45, $04 ; note F4 dur 4
    db $a0, $06 ; volume $06
    db $45, $04 ; note F4 dur 4
    db $1f, $02 ; rest-note $1F dur 2
    db $a0, $02 ; volume $02
    db $28, $0c ; note G#2 dur 12
    db $a0, $04 ; volume $04
    db $28, $04 ; note G#2 dur 4
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a1, $03 ; duty $03
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $40, $04 ; note C4 dur 4
    db $a0, $04 ; volume $04
    db $40, $04 ; note C4 dur 4
    db $b2, $f0 ; repeat $F0
    db $a0, $02 ; volume $02
    db $3a, $04 ; note A#3 dur 4
    db $a0, $04 ; volume $04
    db $3a, $04 ; note A#3 dur 4
    db $a0, $02 ; volume $02
    db $32, $04 ; note D3 dur 4
    db $a0, $04 ; volume $04
    db $32, $04 ; note D3 dur 4
    db $a0, $02 ; volume $02
    db $25, $04 ; note F2 dur 4
    db $a0, $04 ; volume $04
    db $25, $04 ; note F2 dur 4
    db $a0, $02 ; volume $02
    db $1a, $04 ; note A#1 dur 4
    db $a0, $04 ; volume $04
    db $1a, $04 ; note A#1 dur 4
    db $af, $04 ; param $04
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $18, $10 ; note G#1 dur 16
    db $a1, $03 ; duty $03
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $38, $08 ; note G#3 dur 8
    db $a0, $04 ; volume $04
    db $38, $08 ; note G#3 dur 8
    db $b2, $f0 ; repeat $F0
    db $a0, $02 ; volume $02
    db $35, $08 ; note F3 dur 8
    db $a0, $04 ; volume $04
    db $35, $09 ; note F3 dur 9
    db $a0, $02 ; volume $02
    db $30, $08 ; note C3 dur 8
    db $a0, $04 ; volume $04
    db $30, $09 ; note C3 dur 9
    db $a0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $a0, $04 ; volume $04
    db $29, $09 ; note A2 dur 9
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $15, $08 ; note F1 dur 8
    db $a0, $04 ; volume $04
    db $15, $0a ; note F1 dur 10
    db $a0, $02 ; volume $02
    db $23, $12 ; note D#2 dur 18
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $37, $08 ; note G3 dur 8
    db $a0, $04 ; volume $04
    db $37, $0a ; note G3 dur 10
    db $a0, $02 ; volume $02
    db $37, $08 ; note G3 dur 8
    db $a0, $04 ; volume $04
    db $37, $0a ; note G3 dur 10
    db $a0, $02 ; volume $02
    db $37, $08 ; note G3 dur 8
    db $a0, $04 ; volume $04
    db $37, $0a ; note G3 dur 10
    db $a0, $02 ; volume $02
    db $37, $08 ; note G3 dur 8
    db $a0, $04 ; volume $04
    db $37, $0a ; note G3 dur 10
    db $a0, $02 ; volume $02
    db $31, $08 ; note C#3 dur 8
    db $a0, $04 ; volume $04
    db $31, $0b ; note C#3 dur 11
    db $a0, $02 ; volume $02
    db $2b, $08 ; note B2 dur 8
    db $a0, $04 ; volume $04
    db $2b, $0b ; note B2 dur 11
    db $a1, $0a ; duty $0A
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a0, $04 ; volume $04
    db $17, $0b ; note G1 dur 11
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a0, $04 ; volume $04
    db $20, $0b ; note C2 dur 11
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a0, $04 ; volume $04
    db $17, $0b ; note G1 dur 11
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a0, $04 ; volume $04
    db $20, $0b ; note C2 dur 11
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a0, $04 ; volume $04
    db $17, $0b ; note G1 dur 11
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a0, $04 ; volume $04
    db $20, $0b ; note C2 dur 11
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a0, $04 ; volume $04
    db $17, $0b ; note G1 dur 11
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a0, $04 ; volume $04
    db $20, $0b ; note C2 dur 11
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a0, $04 ; volume $04
    db $17, $0b ; note G1 dur 11
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a0, $04 ; volume $04
    db $20, $0d ; note C2 dur 13
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a0, $04 ; volume $04
    db $17, $0f ; note G1 dur 15
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a0, $04 ; volume $04
    db $20, $11 ; note C2 dur 17
    db $a0, $02 ; volume $02
    db $17, $0a ; note G1 dur 10
    db $a0, $04 ; volume $04
    db $17, $13 ; note G1 dur 19
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a0, $04 ; volume $04
    db $20, $34 ; note C2 dur 52
    db $ff, $ff ; end
    db $a0, $02 ; volume $02
    db $a1, $02 ; duty $02
    db $22, $08 ; note D2 dur 8
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $a0, $06 ; volume $06
    db $29, $02 ; note A2 dur 2
    db $a0, $04 ; volume $04
    db $35, $0c ; note F3 dur 12
    db $a0, $06 ; volume $06
    db $35, $04 ; note F3 dur 4
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $24, $08 ; note E2 dur 8
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $2b, $06 ; note B2 dur 6
    db $a0, $06 ; volume $06
    db $2b, $02 ; note B2 dur 2
    db $a0, $04 ; volume $04
    db $37, $0c ; note G3 dur 12
    db $a0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $25, $08 ; note F2 dur 8
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $30, $06 ; note C3 dur 6
    db $a0, $06 ; volume $06
    db $30, $02 ; note C3 dur 2
    db $a0, $04 ; volume $04
    db $39, $0c ; note A3 dur 12
    db $a0, $06 ; volume $06
    db $39, $04 ; note A3 dur 4
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $24, $08 ; note E2 dur 8
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $2b, $06 ; note B2 dur 6
    db $a0, $06 ; volume $06
    db $2b, $02 ; note B2 dur 2
    db $a0, $04 ; volume $04
    db $37, $0c ; note G3 dur 12
    db $a0, $06 ; volume $06
    db $37, $04 ; note G3 dur 4
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $19, $08 ; note A1 dur 8
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $24, $06 ; note E2 dur 6
    db $a0, $06 ; volume $06
    db $24, $02 ; note E2 dur 2
    db $a0, $04 ; volume $04
    db $31, $0c ; note C#3 dur 12
    db $a0, $06 ; volume $06
    db $31, $04 ; note C#3 dur 4
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $a1, $09 ; duty $09
    db $a0, $04 ; volume $04
    db $29, $06 ; note A2 dur 6
    db $a0, $06 ; volume $06
    db $29, $02 ; note A2 dur 2
    db $a0, $04 ; volume $04
    db $35, $0c ; note F3 dur 12
    db $a0, $06 ; volume $06
    db $35, $04 ; note F3 dur 4
    db $a1, $02 ; duty $02
    db $a2, $4f ; duty2 $4F
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a0, $04 ; volume $04
    db $a1, $09 ; duty $09
    db $a2, $7f ; duty2 $7F
    db $35, $08 ; note F3 dur 8
    db $37, $08 ; note G3 dur 8
    db $35, $08 ; note F3 dur 8
    db $37, $08 ; note G3 dur 8
    db $35, $08 ; note F3 dur 8
    db $37, $08 ; note G3 dur 8
    db $35, $08 ; note F3 dur 8
    db $a0, $02 ; volume $02
    db $a1, $02 ; duty $02
    db $a2, $7f ; duty2 $7F
    db $22, $08 ; note D2 dur 8
    db $a1, $0f ; duty $0F
    db $a2, $30 ; duty2 $30
    db $29, $03 ; note A2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $29, $04 ; note A2 dur 4
    db $a0, $02 ; volume $02
    db $35, $03 ; note F3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $04 ; note F3 dur 4
    db $a0, $02 ; volume $02
    db $29, $03 ; note A2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $29, $04 ; note A2 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a2, $30 ; duty2 $30
    db $a1, $0f ; duty $0F
    db $25, $03 ; note F2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $25, $04 ; note F2 dur 4
    db $a0, $02 ; volume $02
    db $2b, $03 ; note B2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $2b, $04 ; note B2 dur 4
    db $a0, $02 ; volume $02
    db $25, $03 ; note F2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $25, $04 ; note F2 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $20, $08 ; note C2 dur 8
    db $a2, $30 ; duty2 $30
    db $a1, $0f ; duty $0F
    db $27, $03 ; note G2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a0, $02 ; volume $02
    db $34, $03 ; note E3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $34, $04 ; note E3 dur 4
    db $a0, $02 ; volume $02
    db $27, $03 ; note G2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $19, $08 ; note A1 dur 8
    db $a2, $30 ; duty2 $30
    db $a1, $0f ; duty $0F
    db $27, $03 ; note G2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a0, $02 ; volume $02
    db $31, $03 ; note C#3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $31, $04 ; note C#3 dur 4
    db $a0, $02 ; volume $02
    db $27, $03 ; note G2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a2, $7f ; duty2 $7F
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $a2, $30 ; duty2 $30
    db $a1, $0f ; duty $0F
    db $29, $03 ; note A2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $29, $04 ; note A2 dur 4
    db $a0, $02 ; volume $02
    db $35, $03 ; note F3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $35, $04 ; note F3 dur 4
    db $a0, $02 ; volume $02
    db $29, $03 ; note A2 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $06 ; volume $06
    db $29, $04 ; note A2 dur 4
    db $a2, $ff ; duty2 $FF
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $17, $1c ; note G1 dur 28
    db $a0, $04 ; volume $04
    db $17, $04 ; note G1 dur 4
    db $a1, $0f ; duty $0F
    db $a0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $28, $08 ; note G#2 dur 8
    db $a1, $02 ; duty $02
    db $35, $10 ; note F3 dur 16
    db $27, $08 ; note G2 dur 8
    db $a0, $06 ; volume $06
    db $27, $08 ; note G2 dur 8
    db $a1, $09 ; duty $09
    db $a0, $02 ; volume $02
    db $17, $10 ; note G1 dur 16
    db $a2, $3f ; duty2 $3F
    db $a1, $0a ; duty $0A
    db $15, $08 ; note F1 dur 8
    db $a2, $30 ; duty2 $30
    db $a1, $0b ; duty $0B
    db $25, $08 ; note F2 dur 8
    db $28, $08 ; note G#2 dur 8
    db $a1, $0a ; duty $0A
    db $a2, $3f ; duty2 $3F
    db $15, $08 ; note F1 dur 8
    db $1a, $08 ; note A#1 dur 8
    db $a1, $0b ; duty $0B
    db $a2, $30 ; duty2 $30
    db $2a, $08 ; note A#2 dur 8
    db $32, $08 ; note D3 dur 8
    db $a2, $3f ; duty2 $3F
    db $a1, $0a ; duty $0A
    db $1a, $08 ; note A#1 dur 8
    db $13, $08 ; note D#1 dur 8
    db $a1, $0b ; duty $0B
    db $a2, $30 ; duty2 $30
    db $23, $08 ; note D#2 dur 8
    db $32, $08 ; note D3 dur 8
    db $a1, $0a ; duty $0A
    db $a2, $3f ; duty2 $3F
    db $13, $08 ; note D#1 dur 8
    db $18, $08 ; note G#1 dur 8
    db $a1, $0b ; duty $0B
    db $a2, $30 ; duty2 $30
    db $28, $08 ; note G#2 dur 8
    db $30, $08 ; note C3 dur 8
    db $a1, $0a ; duty $0A
    db $a2, $3f ; duty2 $3F
    db $18, $08 ; note G#1 dur 8
    db $12, $08 ; note D1 dur 8
    db $a1, $0b ; duty $0B
    db $a2, $30 ; duty2 $30
    db $22, $08 ; note D2 dur 8
    db $28, $08 ; note G#2 dur 8
    db $a2, $3f ; duty2 $3F
    db $a1, $0a ; duty $0A
    db $12, $08 ; note D1 dur 8
    db $13, $08 ; note D#1 dur 8
    db $a1, $0b ; duty $0B
    db $a2, $30 ; duty2 $30
    db $29, $08 ; note A2 dur 8
    db $30, $08 ; note C3 dur 8
    db $a2, $3f ; duty2 $3F
    db $26, $08 ; note F#2 dur 8
    db $a1, $0a ; duty $0A
    db $15, $08 ; note F1 dur 8
    db $a2, $30 ; duty2 $30
    db $a1, $08 ; duty $08
    db $25, $08 ; note F2 dur 8
    db $30, $08 ; note C3 dur 8
    db $a2, $3f ; duty2 $3F
    db $a1, $0a ; duty $0A
    db $15, $08 ; note F1 dur 8
    db $1a, $08 ; note A#1 dur 8
    db $a1, $0b ; duty $0B
    db $a2, $30 ; duty2 $30
    db $32, $08 ; note D3 dur 8
    db $25, $08 ; note F2 dur 8
    db $a2, $3f ; duty2 $3F
    db $a1, $0a ; duty $0A
    db $1a, $08 ; note A#1 dur 8
    db $a2, $5f ; duty2 $5F
    db $a1, $0b ; duty $0B
    db $13, $08 ; note D#1 dur 8
    db $a1, $0f ; duty $0F
    db $a2, $20 ; duty2 $20
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $2a, $03 ; note A#2 dur 3
    db $a0, $04 ; volume $04
    db $2a, $05 ; note A#2 dur 5
    db $b2, $f0 ; repeat $F0
    db $a1, $0b ; duty $0B
    db $a2, $5f ; duty2 $5F
    db $a0, $02 ; volume $02
    db $18, $08 ; note G#1 dur 8
    db $a2, $20 ; duty2 $20
    db $a1, $0f ; duty $0F
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $30, $03 ; note C3 dur 3
    db $a0, $04 ; volume $04
    db $30, $05 ; note C3 dur 5
    db $b2, $f0 ; repeat $F0
    db $a1, $0b ; duty $0B
    db $a2, $5f ; duty2 $5F
    db $a0, $02 ; volume $02
    db $22, $08 ; note D2 dur 8
    db $a2, $20 ; duty2 $20
    db $a1, $03 ; duty $03
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $28, $03 ; note G#2 dur 3
    db $a0, $04 ; volume $04
    db $28, $05 ; note G#2 dur 5
    db $b2, $f0 ; repeat $F0
    db $a2, $5f ; duty2 $5F
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a1, $03 ; duty $03
    db $a2, $20 ; duty2 $20
    db $fd, $f0 ; label 0
    db $a0, $02 ; volume $02
    db $27, $03 ; note G2 dur 3
    db $a0, $04 ; volume $04
    db $27, $05 ; note G2 dur 5
    db $b2, $f0 ; repeat $F0
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $10, $10 ; note C1 dur 16
    db $a2, $7f ; duty2 $7F
    db $a1, $08 ; duty $08
    db $20, $10 ; note C2 dur 16
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $1b, $10 ; note B1 dur 16
    db $a2, $7f ; duty2 $7F
    db $a1, $08 ; duty $08
    db $2b, $10 ; note B2 dur 16
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $1a, $10 ; note A#1 dur 16
    db $a2, $7f ; duty2 $7F
    db $a1, $08 ; duty $08
    db $27, $10 ; note G2 dur 16
    db $a2, $ff ; duty2 $FF
    db $a1, $0b ; duty $0B
    db $19, $10 ; note A1 dur 16
    db $a1, $08 ; duty $08
    db $a2, $7f ; duty2 $7F
    db $23, $10 ; note D#2 dur 16
    db $a1, $0b ; duty $0B
    db $a2, $ff ; duty2 $FF
    db $18, $30 ; note G#1 dur 48
    db $a0, $04 ; volume $04
    db $18, $10 ; note G#1 dur 16
    db $a0, $02 ; volume $02
    db $22, $30 ; note D2 dur 48
    db $a0, $04 ; volume $04
    db $22, $10 ; note D2 dur 16
    db $ad, $00 ; return $00
    db $a1, $03 ; duty $03
    db $a0, $04 ; volume $04
    db $fd, $f0 ; label 0
    db $3b, $04 ; note B3 dur 4
    db $40, $04 ; note C4 dur 4
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $39, $04 ; note A3 dur 4
    db $3b, $04 ; note B3 dur 4
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $37, $04 ; note G3 dur 4
    db $39, $04 ; note A3 dur 4
    db $b7, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $35, $04 ; note F3 dur 4
    db $37, $04 ; note G3 dur 4
    db $b3, $f0 ; repeat $F0
    db $35, $08 ; note F3 dur 8
    db $a0, $06 ; volume $06
    db $35, $08 ; note F3 dur 8
    db $a1, $0f ; duty $0F
    db $a0, $02 ; volume $02
    db $17, $08 ; note G1 dur 8
    db $a0, $04 ; volume $04
    db $17, $08 ; note G1 dur 8
    db $ad, $00 ; return $00

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_03::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

; sound track, 358 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_04::
    db $06, $00, $09, $00 ; header: param=6 byte1=$00 volume=$09 byte3=$00
    db $fd, $f3 ; label 3
    db $a2, $01 ; duty2 $01
    db $c2, $3f ; env $3F
    db $a3, $28 ; mod $28
    db $1f, $06 ; rest-note $1F dur 6
    db $a0, $03 ; volume $03
    db $12, $06 ; note D1 dur 6
    db $a0, $0a ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $0a ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $a0, $03 ; volume $03
    db $25, $12 ; note F2 dur 18
    db $a0, $0a ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $0a ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $a0, $03 ; volume $03
    db $25, $12 ; note F2 dur 18
    db $a0, $0a ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $0a ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $a0, $03 ; volume $03
    db $25, $12 ; note F2 dur 18
    db $a0, $0a ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $a0, $03 ; volume $03
    db $25, $06 ; note F2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $0a ; volume $0A
    db $25, $06 ; note F2 dur 6
    db $a0, $03 ; volume $03
    db $25, $12 ; note F2 dur 18
    db $a0, $0c ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $a0, $03 ; volume $03
    db $20, $06 ; note C2 dur 6
    db $a0, $0c ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $a0, $02 ; volume $02
    db $20, $06 ; note C2 dur 6
    db $a0, $0c ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $a0, $03 ; volume $03
    db $20, $12 ; note C2 dur 18
    db $a0, $0a ; volume $0A
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $26, $06 ; note F#2 dur 6
    db $a0, $0a ; volume $0A
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $12 ; note F#2 dur 18
    db $a0, $0c ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $a0, $03 ; volume $03
    db $20, $06 ; note C2 dur 6
    db $a0, $0c ; volume $0C
    db $24, $06 ; note E2 dur 6
    db $a0, $02 ; volume $02
    db $20, $06 ; note C2 dur 6
    db $a0, $0c ; volume $0C
    db $20, $06 ; note C2 dur 6
    db $a0, $03 ; volume $03
    db $20, $12 ; note C2 dur 18
    db $a0, $0a ; volume $0A
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $06 ; note F#2 dur 6
    db $a0, $0a ; volume $0A
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $26, $06 ; note F#2 dur 6
    db $a0, $0a ; volume $0A
    db $26, $06 ; note F#2 dur 6
    db $a0, $03 ; volume $03
    db $26, $12 ; note F#2 dur 18
    db $a0, $0c ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $a0, $03 ; volume $03
    db $22, $06 ; note D2 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $22, $06 ; note D2 dur 6
    db $a0, $0b ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $a0, $03 ; volume $03
    db $22, $12 ; note D2 dur 18
    db $a0, $0a ; volume $0A
    db $22, $06 ; note D2 dur 6
    db $a0, $03 ; volume $03
    db $22, $06 ; note D2 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $22, $06 ; note D2 dur 6
    db $a0, $0a ; volume $0A
    db $22, $06 ; note D2 dur 6
    db $a0, $03 ; volume $03
    db $22, $12 ; note D2 dur 18
    db $a0, $0c ; volume $0C
    db $22, $06 ; note D2 dur 6
    db $a0, $03 ; volume $03
    db $22, $06 ; note D2 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $22, $06 ; note D2 dur 6
    db $a0, $0b ; volume $0B
    db $22, $06 ; note D2 dur 6
    db $a0, $03 ; volume $03
    db $22, $12 ; note D2 dur 18
    db $a0, $0a ; volume $0A
    db $22, $06 ; note D2 dur 6
    db $a0, $03 ; volume $03
    db $22, $06 ; note D2 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $22, $06 ; note D2 dur 6
    db $a0, $0a ; volume $0A
    db $22, $06 ; note D2 dur 6
    db $a0, $03 ; volume $03
    db $22, $12 ; note D2 dur 18
    db $a0, $0a ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $27, $06 ; note G2 dur 6
    db $a0, $0a ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $27, $12 ; note G2 dur 18
    db $a0, $0a ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $27, $06 ; note G2 dur 6
    db $a0, $0a ; volume $0A
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $27, $06 ; note G2 dur 6
    db $a0, $0a ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $a0, $03 ; volume $03
    db $27, $12 ; note G2 dur 18
    db $a0, $0a ; volume $0A
    db $21, $06 ; note C#2 dur 6
    db $a0, $03 ; volume $03
    db $21, $06 ; note C#2 dur 6
    db $a0, $0a ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $a0, $02 ; volume $02
    db $21, $06 ; note C#2 dur 6
    db $a0, $0a ; volume $0A
    db $21, $06 ; note C#2 dur 6
    db $a0, $03 ; volume $03
    db $21, $12 ; note C#2 dur 18
    db $a0, $0a ; volume $0A
    db $21, $06 ; note C#2 dur 6
    db $a0, $03 ; volume $03
    db $21, $06 ; note C#2 dur 6
    db $a0, $0a ; volume $0A
    db $27, $06 ; note G2 dur 6
    db $a0, $02 ; volume $02
    db $21, $06 ; note C#2 dur 6
    db $a0, $0a ; volume $0A
    db $21, $06 ; note C#2 dur 6
    db $a0, $03 ; volume $03
    db $21, $12 ; note C#2 dur 18
    db $a2, $02 ; duty2 $02
    db $c1, $70 ; env $70
    db $a0, $09 ; volume $09
    db $29, $18 ; note A2 dur 24
    db $a0, $09 ; volume $09
    db $29, $0c ; note A2 dur 12
    db $a0, $03 ; volume $03
    db $35, $0c ; note F3 dur 12
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $2a, $18 ; note A#2 dur 24
    db $a0, $09 ; volume $09
    db $2a, $0c ; note A#2 dur 12
    db $a0, $03 ; volume $03
    db $37, $0c ; note G3 dur 12
    db $a0, $09 ; volume $09
    db $2a, $18 ; note A#2 dur 24
    db $a0, $09 ; volume $09
    db $2a, $0c ; note A#2 dur 12
    db $a0, $03 ; volume $03
    db $37, $0c ; note G3 dur 12
    db $a0, $09 ; volume $09
    db $29, $18 ; note A2 dur 24
    db $a0, $09 ; volume $09
    db $29, $18 ; note A2 dur 24
    db $a0, $09 ; volume $09
    db $29, $18 ; note A2 dur 24
    db $a0, $09 ; volume $09
    db $29, $0c ; note A2 dur 12
    db $a0, $03 ; volume $03
    db $3a, $0c ; note A#3 dur 12
    db $a0, $09 ; volume $09
    db $2a, $18 ; note A#2 dur 24
    db $a0, $09 ; volume $09
    db $2a, $0c ; note A#2 dur 12
    db $a0, $03 ; volume $03
    db $42, $0c ; note D4 dur 12
    db $a0, $09 ; volume $09
    db $27, $18 ; note G2 dur 24
    db $a0, $09 ; volume $09
    db $27, $0c ; note G2 dur 12
    db $a0, $03 ; volume $03
    db $3a, $0c ; note A#3 dur 12
    db $a2, $02 ; duty2 $02
    db $a0, $09 ; volume $09
    db $29, $18 ; note A2 dur 24
    db $c1, $30 ; env $30
    db $a0, $09 ; volume $09
    db $29, $12 ; note A2 dur 18
    db $c1, $6f ; env $6F
    db $a0, $03 ; volume $03
    db $03, $12 ; note D#0 dur 18
    db $a0, $0a ; volume $0A
    db $27, $1e ; note G2 dur 30
    db $a0, $03 ; volume $03
    db $08, $12 ; note G#0 dur 18
    db $a0, $0a ; volume $0A
    db $30, $1e ; note C3 dur 30
    db $a0, $03 ; volume $03
    db $09, $12 ; note A0 dur 18
    db $a0, $0a ; volume $0A
    db $27, $1e ; note G2 dur 30
    db $a0, $03 ; volume $03
    db $09, $12 ; note A0 dur 18
    db $a0, $0a ; volume $0A
    db $27, $1f ; note G2 dur 31
    db $a0, $03 ; volume $03
    db $12, $06 ; note D1 dur 6
    db $a2, $02 ; duty2 $02
    db $c1, $20 ; env $20
    db $a0, $07 ; volume $07
    db $22, $05 ; note D2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $22, $06 ; note D2 dur 6
    db $a0, $07 ; volume $07
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $08 ; volume $08
    db $28, $05 ; note G#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $28, $06 ; note G#2 dur 6
    db $a0, $08 ; volume $08
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $09 ; volume $09
    db $31, $05 ; note C#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $31, $06 ; note C#3 dur 6
    db $a0, $09 ; volume $09
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $a0, $0a ; volume $0A
    db $38, $05 ; note G#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $38, $06 ; note G#3 dur 6
    db $a0, $0a ; volume $0A
    db $3a, $05 ; note A#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $3a, $06 ; note A#3 dur 6
    db $a0, $09 ; volume $09
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $a0, $09 ; volume $09
    db $33, $05 ; note D#3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $33, $06 ; note D#3 dur 6
    db $a0, $08 ; volume $08
    db $2a, $05 ; note A#2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $c3, $58 ; env $58
    db $a0, $0a ; volume $0A
    db $22, $18 ; note D2 dur 24
    db $21, $12 ; note C#2 dur 18
    db $c1, $40 ; env $40
    db $a0, $03 ; volume $03
    db $21, $1e ; note C#2 dur 30
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $25, $0e ; note F2 dur 14
    db $c1, $60 ; env $60
    db $a0, $07 ; volume $07
    db $25, $22 ; note F2 dur 34
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $25, $0e ; note F2 dur 14
    db $c1, $60 ; env $60
    db $a0, $07 ; volume $07
    db $25, $22 ; note F2 dur 34
    db $c3, $48 ; env $48
    db $a0, $0a ; volume $0A
    db $25, $0e ; note F2 dur 14
    db $c1, $60 ; env $60
    db $a0, $07 ; volume $07
    db $25, $22 ; note F2 dur 34
    db $c3, $48 ; env $48
    db $a0, $09 ; volume $09
    db $25, $0e ; note F2 dur 14
    db $c1, $60 ; env $60
    db $a0, $05 ; volume $05
    db $25, $0a ; note F2 dur 10
    db $a7, $01 ; wait $01
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 266 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_05::
    db $06, $02, $0d, $00 ; header: param=6 byte1=$02 volume=$0D byte3=$00
    db $fd, $f3 ; label 3
    db $cc, $6f ; env $6F
    db $a3, $fe ; mod $FE
    db $1f, $12 ; rest-note $1F dur 18
    db $a0, $0d ; volume $0D
    db $32, $96 ; note D3 dur 150
    db $a0, $0d ; volume $0D
    db $a3, $0d ; mod $0D
    db $c3, $50 ; env $50
    db $39, $0c ; note A3 dur 12
    db $a0, $0b ; volume $0B
    db $35, $0c ; note F3 dur 12
    db $c1, $50 ; env $50
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $35, $18 ; note F3 dur 24
    db $a3, $0d ; mod $0D
    db $c3, $38 ; env $38
    db $a0, $09 ; volume $09
    db $34, $06 ; note E3 dur 6
    db $c0, $fe ; env $FE
    db $35, $05 ; note F3 dur 5
    db $34, $04 ; note E3 dur 4
    db $32, $04 ; note D3 dur 4
    db $30, $05 ; note C3 dur 5
    db $c3, $68 ; env $68
    db $32, $18 ; note D3 dur 24
    db $c1, $70 ; env $70
    db $a3, $00 ; mod $00
    db $a0, $0a ; volume $0A
    db $32, $19 ; note D3 dur 25
    db $c3, $28 ; env $28
    db $a0, $0d ; volume $0D
    db $a3, $0d ; mod $0D
    db $34, $05 ; note E3 dur 5
    db $c0, $fe ; env $FE
    db $a0, $0b ; volume $0B
    db $35, $05 ; note F3 dur 5
    db $34, $04 ; note E3 dur 4
    db $32, $05 ; note D3 dur 5
    db $30, $04 ; note C3 dur 4
    db $c3, $68 ; env $68
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $32, $3c ; note D3 dur 60
    db $c1, $60 ; env $60
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $32, $20 ; note D3 dur 32
    db $cc, $4d ; env $4D
    db $a3, $fe ; mod $FE
    db $a0, $0d ; volume $0D
    db $39, $94 ; note A3 dur 148
    db $c3, $68 ; env $68
    db $a0, $0d ; volume $0D
    db $a3, $0c ; mod $0C
    db $44, $0c ; note E4 dur 12
    db $a0, $0b ; volume $0B
    db $42, $0c ; note D4 dur 12
    db $c1, $50 ; env $50
    db $a3, $00 ; mod $00
    db $a0, $05 ; volume $05
    db $42, $18 ; note D4 dur 24
    db $a3, $0d ; mod $0D
    db $c3, $38 ; env $38
    db $a0, $0b ; volume $0B
    db $3a, $05 ; note A#3 dur 5
    db $c0, $fe ; env $FE
    db $a0, $0a ; volume $0A
    db $40, $05 ; note C4 dur 5
    db $3a, $05 ; note A#3 dur 5
    db $39, $05 ; note A3 dur 5
    db $37, $04 ; note G3 dur 4
    db $a0, $0c ; volume $0C
    db $c3, $7f ; env $7F
    db $a3, $fe ; mod $FE
    db $39, $24 ; note A3 dur 36
    db $c1, $60 ; env $60
    db $a3, $00 ; mod $00
    db $a0, $06 ; volume $06
    db $39, $0d ; note A3 dur 13
    db $a3, $0d ; mod $0D
    db $c3, $28 ; env $28
    db $a0, $0c ; volume $0C
    db $3a, $05 ; note A#3 dur 5
    db $a0, $0b ; volume $0B
    db $c0, $fe ; env $FE
    db $40, $05 ; note C4 dur 5
    db $3a, $05 ; note A#3 dur 5
    db $39, $04 ; note A3 dur 4
    db $37, $04 ; note G3 dur 4
    db $c3, $7f ; env $7F
    db $a0, $0b ; volume $0B
    db $c0, $fe ; env $FE
    db $a3, $fe ; mod $FE
    db $39, $48 ; note A3 dur 72
    db $c1, $50 ; env $50
    db $a0, $06 ; volume $06
    db $39, $0c ; note A3 dur 12
    db $c3, $68 ; env $68
    db $a3, $2d ; mod $2D
    db $a0, $0d ; volume $0D
    db $37, $0a ; note G3 dur 10
    db $a0, $03 ; volume $03
    db $37, $02 ; note G3 dur 2
    db $c3, $58 ; env $58
    db $a0, $0d ; volume $0D
    db $37, $0c ; note G3 dur 12
    db $a0, $0c ; volume $0C
    db $35, $0c ; note F3 dur 12
    db $a0, $0d ; volume $0D
    db $34, $0c ; note E3 dur 12
    db $a0, $0c ; volume $0C
    db $35, $0c ; note F3 dur 12
    db $a0, $0b ; volume $0B
    db $39, $0c ; note A3 dur 12
    db $37, $0c ; note G3 dur 12
    db $a0, $0d ; volume $0D
    db $34, $0c ; note E3 dur 12
    db $a0, $0c ; volume $0C
    db $35, $0c ; note F3 dur 12
    db $a0, $0b ; volume $0B
    db $39, $0c ; note A3 dur 12
    db $37, $0c ; note G3 dur 12
    db $a0, $0d ; volume $0D
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $32, $0c ; note D3 dur 12
    db $a0, $0b ; volume $0B
    db $34, $0c ; note E3 dur 12
    db $c1, $40 ; env $40
    db $a3, $20 ; mod $20
    db $a0, $04 ; volume $04
    db $34, $0c ; note E3 dur 12
    db $c3, $48 ; env $48
    db $a3, $2d ; mod $2D
    db $a0, $0d ; volume $0D
    db $40, $0a ; note C4 dur 10
    db $a0, $03 ; volume $03
    db $40, $02 ; note C4 dur 2
    db $c3, $58 ; env $58
    db $a0, $0d ; volume $0D
    db $40, $0c ; note C4 dur 12
    db $a0, $0c ; volume $0C
    db $3a, $0c ; note A#3 dur 12
    db $a0, $0e ; volume $0E
    db $42, $0c ; note D4 dur 12
    db $44, $0c ; note E4 dur 12
    db $40, $0c ; note C4 dur 12
    db $42, $0c ; note D4 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $40, $0c ; note C4 dur 12
    db $39, $0c ; note A3 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $37, $0c ; note G3 dur 12
    db $39, $0c ; note A3 dur 12
    db $34, $0c ; note E3 dur 12
    db $35, $0c ; note F3 dur 12
    db $c3, $7f ; env $7F
    db $a3, $0b ; mod $0B
    db $37, $88 ; note G3 dur 136
    db $c1, $7f ; env $7F
    db $a3, $00 ; mod $00
    db $a0, $0a ; volume $0A
    db $37, $08 ; note G3 dur 8
    db $c0, $fe ; env $FE
    db $a3, $0a ; mod $0A
    db $a0, $0a ; volume $0A
    db $39, $24 ; note A3 dur 36
    db $a3, $00 ; mod $00
    db $c1, $7f ; env $7F
    db $a0, $07 ; volume $07
    db $39, $19 ; note A3 dur 25
    db $a3, $25 ; mod $25
    db $c1, $20 ; env $20
    db $a0, $08 ; volume $08
    db $25, $05 ; note F2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $25, $06 ; note F2 dur 6
    db $a0, $08 ; volume $08
    db $29, $05 ; note A2 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $a0, $09 ; volume $09
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $a0, $09 ; volume $09
    db $32, $05 ; note D3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a0, $0a ; volume $0A
    db $35, $05 ; note F3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $a0, $0a ; volume $0A
    db $39, $05 ; note A3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $39, $06 ; note A3 dur 6
    db $a0, $0b ; volume $0B
    db $40, $05 ; note C4 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $40, $06 ; note C4 dur 6
    db $a0, $0b ; volume $0B
    db $42, $05 ; note D4 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $42, $06 ; note D4 dur 6
    db $a0, $0a ; volume $0A
    db $39, $05 ; note A3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $39, $06 ; note A3 dur 6
    db $a0, $0a ; volume $0A
    db $37, $05 ; note G3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $37, $06 ; note G3 dur 6
    db $a0, $09 ; volume $09
    db $32, $05 ; note D3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a3, $2f ; mod $2F
    db $c0, $fe ; env $FE
    db $a0, $06 ; volume $06
    db $29, $30 ; note A2 dur 48
    db $c1, $4f ; env $4F
    db $a3, $20 ; mod $20
    db $a0, $04 ; volume $04
    db $29, $18 ; note A2 dur 24
    db $c3, $48 ; env $48
    db $a3, $28 ; mod $28
    db $a0, $0c ; volume $0C
    db $32, $0c ; note D3 dur 12
    db $c1, $5f ; env $5F
    db $a0, $07 ; volume $07
    db $32, $24 ; note D3 dur 36
    db $c3, $48 ; env $48
    db $a0, $0c ; volume $0C
    db $31, $0c ; note C#3 dur 12
    db $c1, $5f ; env $5F
    db $a0, $07 ; volume $07
    db $31, $24 ; note C#3 dur 36
    db $c3, $48 ; env $48
    db $a0, $0b ; volume $0B
    db $30, $0c ; note C3 dur 12
    db $c1, $5f ; env $5F
    db $a0, $07 ; volume $07
    db $30, $24 ; note C3 dur 36
    db $c3, $68 ; env $68
    db $a0, $0a ; volume $0A
    db $31, $0c ; note C#3 dur 12
    db $c1, $5f ; env $5F
    db $a0, $05 ; volume $05
    db $31, $0c ; note C#3 dur 12
    db $a7, $01 ; wait $01
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

; sound track, 471 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_06::
    db $06, $18, $02, $04 ; header: param=6 byte1=$18 volume=$02 byte3=$04
    db $fd, $f3 ; label 3
    db $a3, $25 ; mod $25
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $22, $0c ; note D2 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $20, $0c ; note C2 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $1b, $0c ; note B1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $02 ; volume $02
    db $35, $06 ; note F3 dur 6
    db $a0, $06 ; volume $06
    db $35, $06 ; note F3 dur 6
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $19, $0c ; note A1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $24, $06 ; note E2 dur 6
    db $a0, $06 ; volume $06
    db $24, $06 ; note E2 dur 6
    db $a0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $a0, $06 ; volume $06
    db $24, $06 ; note E2 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $22, $0c ; note D2 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $29, $06 ; note A2 dur 6
    db $a0, $06 ; volume $06
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $a0, $06 ; volume $06
    db $29, $06 ; note A2 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $19, $0c ; note A1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $24, $06 ; note E2 dur 6
    db $a0, $06 ; volume $06
    db $24, $06 ; note E2 dur 6
    db $a0, $02 ; volume $02
    db $30, $06 ; note C3 dur 6
    db $a0, $06 ; volume $06
    db $30, $06 ; note C3 dur 6
    db $a0, $02 ; volume $02
    db $24, $06 ; note E2 dur 6
    db $a0, $06 ; volume $06
    db $24, $06 ; note E2 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $22, $0c ; note D2 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $29, $06 ; note A2 dur 6
    db $a0, $06 ; volume $06
    db $29, $06 ; note A2 dur 6
    db $a0, $02 ; volume $02
    db $36, $06 ; note F#3 dur 6
    db $a0, $06 ; volume $06
    db $36, $06 ; note F#3 dur 6
    db $a0, $02 ; volume $02
    db $29, $06 ; note A2 dur 6
    db $a0, $06 ; volume $06
    db $29, $06 ; note A2 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $17, $0c ; note G1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $2a, $06 ; note A#2 dur 6
    db $a0, $06 ; volume $06
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $06 ; volume $06
    db $2a, $06 ; note A#2 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $16, $0c ; note F#1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $2a, $06 ; note A#2 dur 6
    db $a0, $06 ; volume $06
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $06 ; volume $06
    db $2a, $06 ; note A#2 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $15, $0c ; note F1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $2a, $06 ; note A#2 dur 6
    db $a0, $06 ; volume $06
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $06 ; volume $06
    db $2a, $06 ; note A#2 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $14, $0c ; note E1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $2a, $06 ; note A#2 dur 6
    db $a0, $06 ; volume $06
    db $2a, $06 ; note A#2 dur 6
    db $a0, $02 ; volume $02
    db $32, $06 ; note D3 dur 6
    db $a0, $06 ; volume $06
    db $32, $06 ; note D3 dur 6
    db $a0, $02 ; volume $02
    db $2a, $06 ; note A#2 dur 6
    db $a0, $06 ; volume $06
    db $2a, $06 ; note A#2 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $23, $0c ; note D#2 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $31, $06 ; note C#3 dur 6
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $a0, $02 ; volume $02
    db $31, $06 ; note C#3 dur 6
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $23, $0c ; note D#2 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $31, $06 ; note C#3 dur 6
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $37, $06 ; note G3 dur 6
    db $a0, $06 ; volume $06
    db $37, $06 ; note G3 dur 6
    db $a0, $02 ; volume $02
    db $31, $06 ; note C#3 dur 6
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $19, $0c ; note A1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $27, $06 ; note G2 dur 6
    db $a0, $06 ; volume $06
    db $27, $06 ; note G2 dur 6
    db $a0, $02 ; volume $02
    db $31, $06 ; note C#3 dur 6
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $27, $06 ; note G2 dur 6
    db $a0, $06 ; volume $06
    db $27, $06 ; note G2 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $19, $0c ; note A1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $18 ; duty2 $18
    db $27, $06 ; note G2 dur 6
    db $a0, $06 ; volume $06
    db $27, $06 ; note G2 dur 6
    db $a0, $02 ; volume $02
    db $31, $06 ; note C#3 dur 6
    db $a0, $06 ; volume $06
    db $31, $06 ; note C#3 dur 6
    db $a0, $02 ; volume $02
    db $27, $06 ; note G2 dur 6
    db $a0, $06 ; volume $06
    db $27, $06 ; note G2 dur 6
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $22, $0c ; note D2 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $ff ; duty2 $FF
    db $35, $0c ; note F3 dur 12
    db $a0, $04 ; volume $04
    db $35, $0c ; note F3 dur 12
    db $a0, $02 ; volume $02
    db $35, $0a ; note F3 dur 10
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $17, $0c ; note G1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $ff ; duty2 $FF
    db $32, $0c ; note D3 dur 12
    db $a0, $04 ; volume $04
    db $32, $0c ; note D3 dur 12
    db $a0, $02 ; volume $02
    db $35, $0a ; note F3 dur 10
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $20, $0c ; note C2 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $ff ; duty2 $FF
    db $34, $0c ; note E3 dur 12
    db $a0, $04 ; volume $04
    db $34, $0c ; note E3 dur 12
    db $a0, $02 ; volume $02
    db $34, $0a ; note E3 dur 10
    db $a0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $15, $0c ; note F1 dur 12
    db $a1, $02 ; duty $02
    db $a2, $ff ; duty2 $FF
    db $34, $0c ; note E3 dur 12
    db $a0, $04 ; volume $04
    db $34, $0c ; note E3 dur 12
    db $a0, $02 ; volume $02
    db $34, $0a ; note E3 dur 10
    db $a0, $04 ; volume $04
    db $34, $02 ; note E3 dur 2
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $1a, $0c ; note A#1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $ff ; duty2 $FF
    db $32, $0c ; note D3 dur 12
    db $a0, $04 ; volume $04
    db $32, $0c ; note D3 dur 12
    db $a0, $02 ; volume $02
    db $32, $0a ; note D3 dur 10
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $14, $0c ; note E1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $ff ; duty2 $FF
    db $32, $0c ; note D3 dur 12
    db $a0, $04 ; volume $04
    db $32, $0c ; note D3 dur 12
    db $a0, $02 ; volume $02
    db $32, $0a ; note D3 dur 10
    db $a0, $04 ; volume $04
    db $32, $02 ; note D3 dur 2
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $19, $0c ; note A1 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $ff ; duty2 $FF
    db $31, $0c ; note C#3 dur 12
    db $a0, $04 ; volume $04
    db $31, $0c ; note C#3 dur 12
    db $a0, $02 ; volume $02
    db $31, $0a ; note C#3 dur 10
    db $a0, $04 ; volume $04
    db $31, $02 ; note C#3 dur 2
    db $a1, $0b ; duty $0B
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $22, $0c ; note D2 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $ff ; duty2 $FF
    db $35, $0c ; note F3 dur 12
    db $a0, $04 ; volume $04
    db $35, $0c ; note F3 dur 12
    db $a0, $02 ; volume $02
    db $35, $0a ; note F3 dur 10
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $a1, $08 ; duty $08
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $13, $0c ; note D#1 dur 12
    db $23, $0a ; note D#2 dur 10
    db $a0, $04 ; volume $04
    db $23, $02 ; note D#2 dur 2
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $31, $10 ; note C#3 dur 16
    db $a0, $04 ; volume $04
    db $31, $08 ; note C#3 dur 8
    db $a1, $08 ; duty $08
    db $a0, $02 ; volume $02
    db $18, $0c ; note G#1 dur 12
    db $28, $0a ; note G#2 dur 10
    db $a0, $04 ; volume $04
    db $28, $02 ; note G#2 dur 2
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $33, $10 ; note D#3 dur 16
    db $a0, $04 ; volume $04
    db $33, $08 ; note D#3 dur 8
    db $a1, $08 ; duty $08
    db $a0, $02 ; volume $02
    db $19, $0c ; note A1 dur 12
    db $29, $0a ; note A2 dur 10
    db $a0, $04 ; volume $04
    db $29, $02 ; note A2 dur 2
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $32, $10 ; note D3 dur 16
    db $a0, $04 ; volume $04
    db $32, $08 ; note D3 dur 8
    db $a1, $08 ; duty $08
    db $a0, $02 ; volume $02
    db $19, $0c ; note A1 dur 12
    db $29, $0a ; note A2 dur 10
    db $a0, $04 ; volume $04
    db $29, $02 ; note A2 dur 2
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $31, $10 ; note C#3 dur 16
    db $a0, $04 ; volume $04
    db $31, $09 ; note C#3 dur 9
    db $a1, $02 ; duty $02
    db $a0, $02 ; volume $02
    db $22, $0c ; note D2 dur 12
    db $a1, $0f ; duty $0F
    db $a2, $0c ; duty2 $0C
    db $a0, $04 ; volume $04
    db $29, $0c ; note A2 dur 12
    db $30, $0c ; note C3 dur 12
    db $33, $0c ; note D#3 dur 12
    db $35, $0c ; note F3 dur 12
    db $38, $0c ; note G#3 dur 12
    db $40, $0c ; note C4 dur 12
    db $43, $0c ; note D#4 dur 12
    db $45, $0c ; note F4 dur 12
    db $40, $0c ; note C4 dur 12
    db $3a, $0c ; note A#3 dur 12
    db $35, $0c ; note F3 dur 12
    db $a1, $08 ; duty $08
    db $a2, $7f ; duty2 $7F
    db $a0, $02 ; volume $02
    db $24, $18 ; note E2 dur 24
    db $a0, $02 ; volume $02
    db $19, $12 ; note A1 dur 18
    db $a0, $04 ; volume $04
    db $19, $06 ; note A1 dur 6
    db $fd, $f0 ; label 0
    db $a1, $0b ; duty $0B
    db $a0, $02 ; volume $02
    db $12, $06 ; note D1 dur 6
    db $a0, $04 ; volume $04
    db $12, $06 ; note D1 dur 6
    db $a1, $03 ; duty $03
    db $a0, $02 ; volume $02
    db $22, $04 ; note D2 dur 4
    db $a0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $a0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $a0, $04 ; volume $04
    db $29, $04 ; note A2 dur 4
    db $a0, $02 ; volume $02
    db $22, $04 ; note D2 dur 4
    db $a0, $04 ; volume $04
    db $22, $08 ; note D2 dur 8
    db $b3, $f0 ; repeat $F0
    db $a7, $01 ; wait $01
    db $b0, $f3 ; jump $F3
    db $ff, $ff ; end

SoundTrack_42_07::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

SoundTrack_42_08::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

SoundTrack_42_09::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

SoundTrack_42_0A::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

SoundTrack_42_0B::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

; sound track, 8 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_0C::
    db $05, $00, $0c, $00 ; header: param=5 byte1=$00 volume=$0C byte3=$00
    db $1f, $40 ; rest-note $1F dur 64
    db $c0, $fe ; env $FE
    db $29, $40 ; note A2 dur 64
    db $27, $40 ; note G2 dur 64
    db $a0, $08 ; volume $08
    db $c1, $70 ; env $70
    db $27, $30 ; note G2 dur 48
    db $ff, $ff ; end

; sound track, 18 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_0D::
    db $05, $00, $0f, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $a0, $04 ; volume $04
    db $1f, $10 ; rest-note $1F dur 16
    db $14, $10 ; note E1 dur 16
    db $17, $10 ; note G1 dur 16
    db $20, $10 ; note C2 dur 16
    db $a0, $0d ; volume $0D
    db $c0, $fe ; env $FE
    db $30, $3c ; note C3 dur 60
    db $a0, $05 ; volume $05
    db $c1, $20 ; env $20
    db $30, $04 ; note C3 dur 4
    db $a0, $0d ; volume $0D
    db $c0, $fe ; env $FE
    db $30, $40 ; note C3 dur 64
    db $a0, $08 ; volume $08
    db $c1, $70 ; env $70
    db $30, $30 ; note C3 dur 48
    db $ff, $ff ; end

; sound track, 12 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_0E::
    db $05, $ff, $02, $0c ; header: param=5 byte1=$FF volume=$02 byte3=$0C
    db $24, $10 ; note E2 dur 16
    db $27, $10 ; note G2 dur 16
    db $30, $10 ; note C3 dur 16
    db $34, $10 ; note E3 dur 16
    db $35, $20 ; note F3 dur 32
    db $32, $20 ; note D3 dur 32
    db $34, $40 ; note E3 dur 64
    db $a2, $40 ; duty2 $40
    db $a0, $04 ; volume $04
    db $34, $20 ; note E3 dur 32
    db $1f, $10 ; rest-note $1F dur 16
    db $ff, $ff ; end

; sound track, 15 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_0F::
    db $04, $02, $0e, $00 ; header: param=4 byte1=$02 volume=$0E byte3=$00
    db $c1, $50 ; env $50
    db $36, $0c ; note F#3 dur 12
    db $35, $0c ; note F3 dur 12
    db $34, $0c ; note E3 dur 12
    db $32, $0c ; note D3 dur 12
    db $c2, $15 ; env $15
    db $30, $0d ; note C3 dur 13
    db $26, $0d ; note F#2 dur 13
    db $c1, $7f ; env $7F
    db $a0, $0d ; volume $0D
    db $36, $18 ; note F#3 dur 24
    db $a0, $06 ; volume $06
    db $c1, $30 ; env $30
    db $36, $18 ; note F#3 dur 24
    db $ff, $ff ; end

SoundTrack_42_10::
    db $04, $02, $0f, $00 ; header: param=4 byte1=$02 volume=$0F byte3=$00
    db $c1, $50 ; env $50
    db $42, $0c ; note D4 dur 12
    db $41, $0c ; note C#4 dur 12
    db $40, $0c ; note C4 dur 12
    db $3b, $0c ; note B3 dur 12
    db $c2, $15 ; env $15
    db $39, $0d ; note A3 dur 13
    db $32, $0d ; note D3 dur 13
    db $c1, $7f ; env $7F
    db $a0, $0e ; volume $0E
    db $42, $18 ; note D4 dur 24
    db $a0, $07 ; volume $07
    db $c1, $30 ; env $30
    db $42, $18 ; note D4 dur 24
    db $ff, $ff ; end

; sound track, 21 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_11::
    db $0b, $00, $05, $00 ; header: param=11 byte1=$00 volume=$05 byte3=$00
    db $1f, $04 ; rest-note $1F dur 4
    db $35, $06 ; note F3 dur 6
    db $22, $04 ; note D2 dur 4
    db $29, $04 ; note A2 dur 4
    db $35, $04 ; note F3 dur 4
    db $34, $04 ; note E3 dur 4
    db $21, $04 ; note C#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $34, $04 ; note E3 dur 4
    db $32, $04 ; note D3 dur 4
    db $1a, $04 ; note A#1 dur 4
    db $27, $04 ; note G2 dur 4
    db $32, $04 ; note D3 dur 4
    db $31, $04 ; note C#3 dur 4
    db $2a, $05 ; note A#2 dur 5
    db $29, $05 ; note A2 dur 5
    db $28, $06 ; note G#2 dur 6
    db $29, $02 ; note A2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $29, $18 ; note A2 dur 24
    db $ff, $ff ; end

SoundTrack_42_12::
    db $0b, $00, $0f, $00 ; header: param=11 byte1=$00 volume=$0F byte3=$00
    db $35, $06 ; note F3 dur 6
    db $22, $04 ; note D2 dur 4
    db $29, $04 ; note A2 dur 4
    db $35, $04 ; note F3 dur 4
    db $34, $04 ; note E3 dur 4
    db $21, $04 ; note C#2 dur 4
    db $29, $04 ; note A2 dur 4
    db $34, $04 ; note E3 dur 4
    db $32, $04 ; note D3 dur 4
    db $1a, $04 ; note A#1 dur 4
    db $27, $04 ; note G2 dur 4
    db $32, $04 ; note D3 dur 4
    db $31, $04 ; note C#3 dur 4
    db $2a, $05 ; note A#2 dur 5
    db $29, $05 ; note A2 dur 5
    db $28, $06 ; note G#2 dur 6
    db $29, $02 ; note A2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $29, $18 ; note A2 dur 24
    db $1f, $04 ; rest-note $1F dur 4
    db $ff, $ff ; end

; sound track, 25 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_13::
    db $05, $00, $0e, $00 ; header: param=5 byte1=$00 volume=$0E byte3=$00
    db $39, $08 ; note A3 dur 8
    db $38, $04 ; note G#3 dur 4
    db $39, $02 ; note A3 dur 2
    db $fd, $f0 ; label 0
    db $35, $02 ; note F3 dur 2
    db $37, $02 ; note G3 dur 2
    db $b3, $f0 ; repeat $F0
    db $35, $02 ; note F3 dur 2
    db $34, $02 ; note E3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $32, $02 ; note D3 dur 2
    db $31, $02 ; note C#3 dur 2
    db $30, $02 ; note C3 dur 2
    db $2b, $02 ; note B2 dur 2
    db $2a, $02 ; note A#2 dur 2
    db $29, $02 ; note A2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $a0, $08 ; volume $08
    db $27, $02 ; note G2 dur 2
    db $26, $02 ; note F#2 dur 2
    db $a0, $04 ; volume $04
    db $25, $02 ; note F2 dur 2
    db $24, $02 ; note E2 dur 2
    db $1f, $08 ; rest-note $1F dur 8
    db $ff, $ff ; end

SoundTrack_42_14::
    db $05, $00, $0f, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $2a, $08 ; note A#2 dur 8
    db $32, $04 ; note D3 dur 4
    db $2a, $02 ; note A#2 dur 2
    db $fd, $f0 ; label 0
    db $2b, $02 ; note B2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $b3, $f0 ; repeat $F0
    db $2b, $02 ; note B2 dur 2
    db $2a, $02 ; note A#2 dur 2
    db $29, $02 ; note A2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $27, $02 ; note G2 dur 2
    db $26, $02 ; note F#2 dur 2
    db $25, $02 ; note F2 dur 2
    db $24, $02 ; note E2 dur 2
    db $23, $02 ; note D#2 dur 2
    db $22, $02 ; note D2 dur 2
    db $a0, $08 ; volume $08
    db $21, $02 ; note C#2 dur 2
    db $20, $02 ; note C2 dur 2
    db $a0, $04 ; volume $04
    db $1b, $02 ; note B1 dur 2
    db $1a, $02 ; note A#1 dur 2
    db $1f, $08 ; rest-note $1F dur 8
    db $ff, $ff ; end

; sound track, 33 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_15::
    db $05, $00, $0e, $00 ; header: param=5 byte1=$00 volume=$0E byte3=$00
    db $39, $08 ; note A3 dur 8
    db $38, $04 ; note G#3 dur 4
    db $39, $02 ; note A3 dur 2
    db $35, $02 ; note F3 dur 2
    db $28, $02 ; note G#2 dur 2
    db $2b, $02 ; note B2 dur 2
    db $22, $02 ; note D2 dur 2
    db $35, $02 ; note F3 dur 2
    db $37, $02 ; note G3 dur 2
    db $3b, $02 ; note B3 dur 2
    db $42, $02 ; note D4 dur 2
    db $fd, $f0 ; label 0
    db $45, $02 ; note F4 dur 2
    db $47, $02 ; note G4 dur 2
    db $b3, $f0 ; repeat $F0
    db $45, $02 ; note F4 dur 2
    db $44, $02 ; note E4 dur 2
    db $43, $02 ; note D#4 dur 2
    db $42, $02 ; note D4 dur 2
    db $41, $02 ; note C#4 dur 2
    db $40, $02 ; note C4 dur 2
    db $3b, $02 ; note B3 dur 2
    db $3a, $02 ; note A#3 dur 2
    db $39, $02 ; note A3 dur 2
    db $38, $02 ; note G#3 dur 2
    db $a0, $06 ; volume $06
    db $37, $02 ; note G3 dur 2
    db $36, $02 ; note F#3 dur 2
    db $a0, $04 ; volume $04
    db $35, $02 ; note F3 dur 2
    db $34, $02 ; note E3 dur 2
    db $1f, $08 ; rest-note $1F dur 8
    db $ff, $ff ; end

SoundTrack_42_16::
    db $05, $00, $0f, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $2a, $08 ; note A#2 dur 8
    db $32, $04 ; note D3 dur 4
    db $2a, $02 ; note A#2 dur 2
    db $2b, $02 ; note B2 dur 2
    db $25, $02 ; note F2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $2b, $02 ; note B2 dur 2
    db $32, $02 ; note D3 dur 2
    db $35, $02 ; note F3 dur 2
    db $38, $02 ; note G#3 dur 2
    db $35, $02 ; note F3 dur 2
    db $fd, $f0 ; label 0
    db $3b, $02 ; note B3 dur 2
    db $38, $02 ; note G#3 dur 2
    db $b3, $f0 ; repeat $F0
    db $3b, $02 ; note B3 dur 2
    db $3a, $02 ; note A#3 dur 2
    db $39, $02 ; note A3 dur 2
    db $38, $02 ; note G#3 dur 2
    db $37, $02 ; note G3 dur 2
    db $36, $02 ; note F#3 dur 2
    db $35, $02 ; note F3 dur 2
    db $34, $02 ; note E3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $32, $02 ; note D3 dur 2
    db $a0, $06 ; volume $06
    db $31, $02 ; note C#3 dur 2
    db $30, $02 ; note C3 dur 2
    db $a0, $04 ; volume $04
    db $2b, $02 ; note B2 dur 2
    db $2a, $02 ; note A#2 dur 2
    db $1f, $08 ; rest-note $1F dur 8
    db $ff, $ff ; end

SoundTrack_42_17::
    db $09, $02, $0f, $00 ; header: param=9 byte1=$02 volume=$0F byte3=$00
    db $c1, $60 ; env $60
    db $24, $04 ; note E2 dur 4
    db $14, $03 ; note E1 dur 3
    db $15, $03 ; note F1 dur 3
    db $17, $03 ; note G1 dur 3
    db $19, $03 ; note A1 dur 3
    db $1b, $03 ; note B1 dur 3
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $c2, $15 ; env $15
    db $24, $06 ; note E2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $c1, $1f ; env $1F
    db $34, $0c ; note E3 dur 12
    db $ff, $ff ; end

SoundTrack_42_18::
    db $09, $02, $0f, $00 ; header: param=9 byte1=$02 volume=$0F byte3=$00
    db $c1, $60 ; env $60
    db $27, $04 ; note G2 dur 4
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2b, $03 ; note B2 dur 3
    db $c2, $15 ; env $15
    db $30, $06 ; note C3 dur 6
    db $37, $06 ; note G3 dur 6
    db $c1, $1f ; env $1F
    db $40, $0c ; note C4 dur 12
    db $ff, $ff ; end

; sound track, 67 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_19::
    db $04, $00, $0f, $00 ; header: param=4 byte1=$00 volume=$0F byte3=$00
    db $c1, $1f ; env $1F
    db $24, $06 ; note E2 dur 6
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $09 ; volume $09
    db $24, $07 ; note E2 dur 7
    db $a0, $0d ; volume $0D
    db $24, $02 ; note E2 dur 2
    db $a0, $05 ; volume $05
    db $24, $02 ; note E2 dur 2
    db $a0, $0d ; volume $0D
    db $24, $05 ; note E2 dur 5
    db $a0, $06 ; volume $06
    db $24, $03 ; note E2 dur 3
    db $fd, $f0 ; label 0
    db $a0, $0d ; volume $0D
    db $25, $04 ; note F2 dur 4
    db $a0, $07 ; volume $07
    db $25, $04 ; note F2 dur 4
    db $b2, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0d ; volume $0D
    db $24, $04 ; note E2 dur 4
    db $a0, $07 ; volume $07
    db $24, $04 ; note E2 dur 4
    db $b2, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0d ; volume $0D
    db $22, $04 ; note D2 dur 4
    db $a0, $07 ; volume $07
    db $22, $04 ; note D2 dur 4
    db $b2, $f0 ; repeat $F0
    db $a0, $0e ; volume $0E
    db $c1, $2f ; env $2F
    db $24, $06 ; note E2 dur 6
    db $14, $06 ; note E1 dur 6
    db $15, $06 ; note F1 dur 6
    db $17, $06 ; note G1 dur 6
    db $19, $06 ; note A1 dur 6
    db $1b, $06 ; note B1 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $24, $0e ; note E2 dur 14
    db $a0, $06 ; volume $06
    db $24, $0c ; note E2 dur 12
    db $a0, $0f ; volume $0F
    db $2b, $0c ; note B2 dur 12
    db $2b, $0d ; note B2 dur 13
    db $2b, $0f ; note B2 dur 15
    db $c3, $40 ; env $40
    db $34, $04 ; note E3 dur 4
    db $37, $03 ; note G3 dur 3
    db $fd, $f0 ; label 0
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $b3, $f0 ; repeat $F0
    db $a0, $0d ; volume $0D
    db $fd, $f0 ; label 0
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $b3, $f0 ; repeat $F0
    db $34, $03 ; note E3 dur 3
    db $37, $02 ; note G3 dur 2
    db $c1, $7f ; env $7F
    db $a0, $06 ; volume $06
    db $34, $18 ; note E3 dur 24
    db $1f, $18 ; rest-note $1F dur 24
    db $ff, $ff ; end

; sound track, 54 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_1A::
    db $04, $00, $0f, $00 ; header: param=4 byte1=$00 volume=$0F byte3=$00
    db $c1, $1f ; env $1F
    db $27, $06 ; note G2 dur 6
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $09 ; volume $09
    db $27, $07 ; note G2 dur 7
    db $a0, $0f ; volume $0F
    db $27, $02 ; note G2 dur 2
    db $a0, $06 ; volume $06
    db $27, $02 ; note G2 dur 2
    db $a0, $0f ; volume $0F
    db $27, $05 ; note G2 dur 5
    db $a0, $06 ; volume $06
    db $27, $03 ; note G2 dur 3
    db $fd, $f0 ; label 0
    db $a0, $0f ; volume $0F
    db $29, $04 ; note A2 dur 4
    db $a0, $07 ; volume $07
    db $29, $04 ; note A2 dur 4
    db $b2, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0f ; volume $0F
    db $27, $04 ; note G2 dur 4
    db $a0, $07 ; volume $07
    db $27, $04 ; note G2 dur 4
    db $b2, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $a0, $0f ; volume $0F
    db $25, $04 ; note F2 dur 4
    db $a0, $07 ; volume $07
    db $25, $04 ; note F2 dur 4
    db $b2, $f0 ; repeat $F0
    db $c1, $2f ; env $2F
    db $a0, $0f ; volume $0F
    db $27, $06 ; note G2 dur 6
    db $20, $06 ; note C2 dur 6
    db $22, $06 ; note D2 dur 6
    db $24, $06 ; note E2 dur 6
    db $25, $06 ; note F2 dur 6
    db $27, $06 ; note G2 dur 6
    db $29, $06 ; note A2 dur 6
    db $2b, $06 ; note B2 dur 6
    db $30, $0e ; note C3 dur 14
    db $a0, $06 ; volume $06
    db $30, $0c ; note C3 dur 12
    db $a0, $0f ; volume $0F
    db $37, $0c ; note G3 dur 12
    db $37, $0d ; note G3 dur 13
    db $37, $0f ; note G3 dur 15
    db $c1, $fe ; env $FE
    db $40, $54 ; note C4 dur 84
    db $c1, $30 ; env $30
    db $a0, $06 ; volume $06
    db $40, $18 ; note C4 dur 24
    db $ff, $ff ; end

; sound track, 16 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_1B::
    db $04, $ff, $02, $03 ; header: param=4 byte1=$FF volume=$02 byte3=$03
    db $20, $62 ; note C2 dur 98
    db $a0, $04 ; volume $04
    db $20, $18 ; note C2 dur 24
    db $1f, $59 ; rest-note $1F dur 89
    db $a0, $02 ; volume $02
    db $a2, $30 ; duty2 $30
    db $a1, $09 ; duty $09
    db $20, $0f ; note C2 dur 15
    db $17, $0f ; note G1 dur 15
    db $20, $0f ; note C2 dur 15
    db $17, $0f ; note G1 dur 15
    db $a2, $ff ; duty2 $FF
    db $20, $18 ; note C2 dur 24
    db $a0, $06 ; volume $06
    db $20, $18 ; note C2 dur 24
    db $ff, $ff ; end

; sound track, 141 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_1C::
    db $05, $00, $0d, $00 ; header: param=5 byte1=$00 volume=$0D byte3=$00
    db $a0, $0f ; volume $0F
    db $24, $04 ; note E2 dur 4
    db $a0, $0d ; volume $0D
    db $14, $03 ; note E1 dur 3
    db $15, $03 ; note F1 dur 3
    db $17, $03 ; note G1 dur 3
    db $19, $03 ; note A1 dur 3
    db $1b, $03 ; note B1 dur 3
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $a0, $0f ; volume $0F
    db $24, $03 ; note E2 dur 3
    db $a0, $0d ; volume $0D
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2b, $03 ; note B2 dur 3
    db $a0, $0f ; volume $0F
    db $30, $03 ; note C3 dur 3
    db $a0, $0d ; volume $0D
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2b, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $a0, $0f ; volume $0F
    db $34, $03 ; note E3 dur 3
    db $a0, $0d ; volume $0D
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $a0, $0f ; volume $0F
    db $29, $03 ; note A2 dur 3
    db $2b, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $c1, $2f ; env $2F
    db $24, $0a ; note E2 dur 10
    db $a0, $06 ; volume $06
    db $24, $04 ; note E2 dur 4
    db $a0, $0f ; volume $0F
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
    db $a0, $0d ; volume $0D
    db $c1, $2f ; env $2F
    db $24, $09 ; note E2 dur 9
    db $a0, $06 ; volume $06
    db $24, $04 ; note E2 dur 4
    db $a0, $0f ; volume $0F
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
    db $a0, $0b ; volume $0B
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
    db $a0, $0d ; volume $0D
    db $c1, $2f ; env $2F
    db $38, $0b ; note G#3 dur 11
    db $a0, $06 ; volume $06
    db $c1, $1f ; env $1F
    db $38, $04 ; note G#3 dur 4
    db $a0, $0f ; volume $0F
    db $38, $04 ; note G#3 dur 4
    db $c1, $2f ; env $2F
    db $38, $08 ; note G#3 dur 8
    db $34, $09 ; note E3 dur 9
    db $34, $0a ; note E3 dur 10
    db $34, $0a ; note E3 dur 10
    db $33, $0b ; note D#3 dur 11
    db $33, $0c ; note D#3 dur 12
    db $33, $0d ; note D#3 dur 13
    db $35, $0e ; note F3 dur 14
    db $35, $0f ; note F3 dur 15
    db $35, $10 ; note F3 dur 16
    db $c3, $40 ; env $40
    db $34, $04 ; note E3 dur 4
    db $37, $04 ; note G3 dur 4
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $fd, $f0 ; label 0
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $34, $03 ; note E3 dur 3
    db $37, $03 ; note G3 dur 3
    db $b6, $f0 ; repeat $F0
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
    db $c1, $60 ; env $60
    db $a0, $09 ; volume $09
    db $34, $18 ; note E3 dur 24
    db $a0, $03 ; volume $03
    db $34, $18 ; note E3 dur 24
    db $ff, $ff ; end

; sound track, 104 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_1D::
    db $05, $00, $0f, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $27, $04 ; note G2 dur 4
    db $20, $03 ; note C2 dur 3
    db $22, $03 ; note D2 dur 3
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2b, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $24, $03 ; note E2 dur 3
    db $25, $03 ; note F2 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2b, $03 ; note B2 dur 3
    db $30, $03 ; note C3 dur 3
    db $32, $03 ; note D3 dur 3
    db $34, $03 ; note E3 dur 3
    db $27, $03 ; note G2 dur 3
    db $29, $03 ; note A2 dur 3
    db $2b, $03 ; note B2 dur 3
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
    db $3b, $03 ; note B3 dur 3
    db $c1, $2f ; env $2F
    db $27, $0a ; note G2 dur 10
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a0, $0f ; volume $0F
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
    db $a0, $0d ; volume $0D
    db $c1, $2f ; env $2F
    db $27, $09 ; note G2 dur 9
    db $a0, $06 ; volume $06
    db $27, $04 ; note G2 dur 4
    db $a0, $0f ; volume $0F
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
    db $a0, $0b ; volume $0B
    db $c1, $28 ; env $28
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
    db $c1, $20 ; env $20
    db $a0, $0d ; volume $0D
    db $40, $0b ; note C4 dur 11
    db $a0, $06 ; volume $06
    db $c1, $1f ; env $1F
    db $40, $04 ; note C4 dur 4
    db $c1, $28 ; env $28
    db $a0, $0f ; volume $0F
    db $40, $04 ; note C4 dur 4
    db $40, $08 ; note C4 dur 8
    db $c1, $2f ; env $2F
    db $37, $09 ; note G3 dur 9
    db $37, $0a ; note G3 dur 10
    db $37, $0a ; note G3 dur 10
    db $38, $0b ; note G#3 dur 11
    db $38, $0c ; note G#3 dur 12
    db $38, $0d ; note G#3 dur 13
    db $3a, $0e ; note A#3 dur 14
    db $3a, $0f ; note A#3 dur 15
    db $3a, $10 ; note A#3 dur 16
    db $c0, $fe ; env $FE
    db $40, $9b ; note C4 dur 155
    db $c1, $70 ; env $70
    db $40, $30 ; note C4 dur 48
    db $ff, $ff ; end

; sound track, 102 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_1E::
    db $05, $ff, $02, $03 ; header: param=5 byte1=$FF volume=$02 byte3=$03
    db $20, $49 ; note C2 dur 73
    db $a0, $04 ; volume $04
    db $20, $18 ; note C2 dur 24
    db $a0, $02 ; volume $02
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
    db $fd, $f0 ; label 0
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
    db $b2, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
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
    db $b3, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
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
    db $b2, $f0 ; repeat $F0
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
    db $a2, $10 ; duty2 $10
    db $43, $0b ; note D#4 dur 11
    db $a0, $06 ; volume $06
    db $43, $04 ; note D#4 dur 4
    db $a0, $02 ; volume $02
    db $43, $04 ; note D#4 dur 4
    db $a2, $1f ; duty2 $1F
    db $43, $08 ; note D#4 dur 8
    db $40, $09 ; note C4 dur 9
    db $40, $0a ; note C4 dur 10
    db $40, $0a ; note C4 dur 10
    db $40, $0b ; note C4 dur 11
    db $40, $0c ; note C4 dur 12
    db $40, $0d ; note C4 dur 13
    db $42, $0e ; note D4 dur 14
    db $42, $0f ; note D4 dur 15
    db $42, $10 ; note D4 dur 16
    db $a1, $0b ; duty $0B
    db $a2, $40 ; duty2 $40
    db $20, $11 ; note C2 dur 17
    db $17, $11 ; note G1 dur 17
    db $20, $11 ; note C2 dur 17
    db $17, $11 ; note G1 dur 17
    db $20, $12 ; note C2 dur 18
    db $17, $12 ; note G1 dur 18
    db $20, $18 ; note C2 dur 24
    db $17, $1b ; note G1 dur 27
    db $a2, $50 ; duty2 $50
    db $20, $18 ; note C2 dur 24
    db $a0, $06 ; volume $06
    db $20, $18 ; note C2 dur 24
    db $ff, $ff ; end

; sound track, 13 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_1F::
    db $07, $01, $0f, $00 ; header: param=7 byte1=$01 volume=$0F byte3=$00
    db $c2, $1f ; env $1F
    db $30, $04 ; note C3 dur 4
    db $2b, $04 ; note B2 dur 4
    db $2a, $04 ; note A#2 dur 4
    db $c2, $15 ; env $15
    db $29, $08 ; note A2 dur 8
    db $27, $08 ; note G2 dur 8
    db $2a, $08 ; note A#2 dur 8
    db $c1, $30 ; env $30
    db $29, $0c ; note A2 dur 12
    db $a0, $06 ; volume $06
    db $29, $0c ; note A2 dur 12
    db $ff, $ff ; end

SoundTrack_42_20::
    db $07, $01, $0f, $00 ; header: param=7 byte1=$01 volume=$0F byte3=$00
    db $c2, $1f ; env $1F
    db $35, $04 ; note F3 dur 4
    db $35, $04 ; note F3 dur 4
    db $35, $04 ; note F3 dur 4
    db $c2, $15 ; env $15
    db $35, $08 ; note F3 dur 8
    db $33, $08 ; note D#3 dur 8
    db $37, $08 ; note G3 dur 8
    db $c1, $30 ; env $30
    db $35, $0c ; note F3 dur 12
    db $a0, $06 ; volume $06
    db $35, $0c ; note F3 dur 12
    db $ff, $ff ; end

; sound track, 14 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_21::
    db $05, $00, $0e, $00 ; header: param=5 byte1=$00 volume=$0E byte3=$00
    db $c1, $50 ; env $50
    db $fd, $f0 ; label 0
    db $12, $04 ; note D1 dur 4
    db $21, $04 ; note C#2 dur 4
    db $11, $04 ; note C#1 dur 4
    db $20, $04 ; note C2 dur 4
    db $b3, $f0 ; repeat $F0
    db $16, $0c ; note F#1 dur 12
    db $17, $02 ; note G1 dur 2
    db $18, $02 ; note G#1 dur 2
    db $10, $08 ; note C1 dur 8
    db $a0, $08 ; volume $08
    db $10, $14 ; note C1 dur 20
    db $ff, $ff ; end

SoundTrack_42_22::
    db $05, $00, $0f, $00 ; header: param=5 byte1=$00 volume=$0F byte3=$00
    db $c1, $50 ; env $50
    db $fd, $f0 ; label 0
    db $02, $04 ; note D0 dur 4
    db $11, $04 ; note C#1 dur 4
    db $01, $04 ; note C#0 dur 4
    db $10, $04 ; note C1 dur 4
    db $b3, $f0 ; repeat $F0
    db $06, $0c ; note F#0 dur 12
    db $07, $02 ; note G0 dur 2
    db $08, $02 ; note G#0 dur 2
    db $00, $08 ; note C0 dur 8
    db $a0, $08 ; volume $08
    db $00, $14 ; note C0 dur 20
    db $ff, $ff ; end

; sound track, 57 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_23::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $c2, $40 ; env $40
    db $a0, $0d ; volume $0D
    db $15, $0a ; note F1 dur 10
    db $c1, $28 ; env $28
    db $a0, $0c ; volume $0C
    db $29, $0a ; note A2 dur 10
    db $a0, $0a ; volume $0A
    db $29, $0a ; note A2 dur 10
    db $30, $0a ; note C3 dur 10
    db $a0, $08 ; volume $08
    db $30, $0a ; note C3 dur 10
    db $2a, $0a ; note A#2 dur 10
    db $2a, $0a ; note A#2 dur 10
    db $29, $0a ; note A2 dur 10
    db $a0, $0f ; volume $0F
    db $c2, $40 ; env $40
    db $22, $0a ; note D2 dur 10
    db $c1, $18 ; env $18
    db $a0, $0e ; volume $0E
    db $29, $0a ; note A2 dur 10
    db $29, $0a ; note A2 dur 10
    db $29, $0a ; note A2 dur 10
    db $a0, $0c ; volume $0C
    db $29, $0a ; note A2 dur 10
    db $a0, $0b ; volume $0B
    db $26, $0a ; note F#2 dur 10
    db $a0, $0a ; volume $0A
    db $26, $0a ; note F#2 dur 10
    db $26, $0a ; note F#2 dur 10
    db $a0, $0b ; volume $0B
    db $c2, $30 ; env $30
    db $22, $08 ; note D2 dur 8
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $22, $0b ; note D2 dur 11
    db $a0, $0a ; volume $0A
    db $24, $08 ; note E2 dur 8
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $24, $0b ; note E2 dur 11
    db $c1, $14 ; env $14
    db $a0, $0f ; volume $0F
    db $29, $08 ; note A2 dur 8
    db $a0, $0a ; volume $0A
    db $29, $08 ; note A2 dur 8
    db $a0, $06 ; volume $06
    db $29, $08 ; note A2 dur 8
    db $a0, $04 ; volume $04
    db $29, $08 ; note A2 dur 8
    db $a0, $02 ; volume $02
    db $29, $08 ; note A2 dur 8
    db $a0, $01 ; volume $01
    db $29, $08 ; note A2 dur 8
    db $a0, $01 ; volume $01
    db $29, $08 ; note A2 dur 8
    db $1f, $10 ; rest-note $1F dur 16
    db $ff, $ff ; end

; sound track, 52 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_24::
    db $00, $00, $0d, $00 ; header: param=0 byte1=$00 volume=$0D byte3=$00
    db $c2, $40 ; env $40
    db $1f, $0a ; rest-note $1F dur 10
    db $35, $0a ; note F3 dur 10
    db $a0, $0b ; volume $0B
    db $35, $0a ; note F3 dur 10
    db $34, $0a ; note E3 dur 10
    db $a0, $0a ; volume $0A
    db $34, $0a ; note E3 dur 10
    db $32, $0a ; note D3 dur 10
    db $32, $0a ; note D3 dur 10
    db $30, $0a ; note C3 dur 10
    db $a0, $08 ; volume $08
    db $30, $0a ; note C3 dur 10
    db $a0, $0d ; volume $0D
    db $32, $0a ; note D3 dur 10
    db $32, $0a ; note D3 dur 10
    db $30, $0a ; note C3 dur 10
    db $a0, $0c ; volume $0C
    db $30, $0a ; note C3 dur 10
    db $a0, $0b ; volume $0B
    db $2a, $0a ; note A#2 dur 10
    db $a0, $0a ; volume $0A
    db $2a, $0a ; note A#2 dur 10
    db $29, $0a ; note A2 dur 10
    db $a0, $0b ; volume $0B
    db $c2, $3f ; env $3F
    db $27, $08 ; note G2 dur 8
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $27, $0b ; note G2 dur 11
    db $a0, $0a ; volume $0A
    db $30, $08 ; note C3 dur 8
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $03 ; volume $03
    db $30, $0b ; note C3 dur 11
    db $c1, $14 ; env $14
    db $a0, $0f ; volume $0F
    db $35, $08 ; note F3 dur 8
    db $a0, $0a ; volume $0A
    db $35, $08 ; note F3 dur 8
    db $a0, $07 ; volume $07
    db $35, $08 ; note F3 dur 8
    db $a0, $04 ; volume $04
    db $35, $08 ; note F3 dur 8
    db $a0, $02 ; volume $02
    db $35, $08 ; note F3 dur 8
    db $a0, $01 ; volume $01
    db $35, $08 ; note F3 dur 8
    db $a0, $01 ; volume $01
    db $35, $08 ; note F3 dur 8
    db $1f, $10 ; rest-note $1F dur 16
    db $ff, $ff ; end

; sound track, 44 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_25::
    db $00, $30, $02, $02 ; header: param=0 byte1=$30 volume=$02 byte3=$02
    db $a2, $70 ; duty2 $70
    db $a1, $09 ; duty $09
    db $15, $0a ; note F1 dur 10
    db $a1, $02 ; duty $02
    db $a2, $1c ; duty2 $1C
    db $30, $0a ; note C3 dur 10
    db $30, $0a ; note C3 dur 10
    db $35, $0a ; note F3 dur 10
    db $35, $0a ; note F3 dur 10
    db $35, $0a ; note F3 dur 10
    db $35, $0a ; note F3 dur 10
    db $35, $0a ; note F3 dur 10
    db $a1, $09 ; duty $09
    db $a2, $70 ; duty2 $70
    db $22, $0a ; note D2 dur 10
    db $a1, $02 ; duty $02
    db $a2, $1d ; duty2 $1D
    db $36, $0a ; note F#3 dur 10
    db $36, $0a ; note F#3 dur 10
    db $36, $0a ; note F#3 dur 10
    db $36, $0a ; note F#3 dur 10
    db $32, $0a ; note D3 dur 10
    db $32, $0a ; note D3 dur 10
    db $30, $0a ; note C3 dur 10
    db $a2, $10 ; duty2 $10
    db $a0, $02 ; volume $02
    db $2a, $08 ; note A#2 dur 8
    db $a0, $06 ; volume $06
    db $2a, $0c ; note A#2 dur 12
    db $a0, $02 ; volume $02
    db $2a, $08 ; note A#2 dur 8
    db $a0, $06 ; volume $06
    db $2a, $0c ; note A#2 dur 12
    db $a2, $0a ; duty2 $0A
    db $a0, $02 ; volume $02
    db $25, $08 ; note F2 dur 8
    db $a0, $04 ; volume $04
    db $25, $08 ; note F2 dur 8
    db $a0, $06 ; volume $06
    db $25, $08 ; note F2 dur 8
    db $a0, $06 ; volume $06
    db $25, $04 ; note F2 dur 4
    db $1f, $30 ; rest-note $1F dur 48
    db $ff, $ff ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_26::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

; sound track, 24 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_27::
    db $04, $03, $0a, $00 ; header: param=4 byte1=$03 volume=$0A byte3=$00
    db $c2, $08 ; env $08
    db $24, $0c ; note E2 dur 12
    db $27, $0c ; note G2 dur 12
    db $30, $0c ; note C3 dur 12
    db $35, $0d ; note F3 dur 13
    db $1f, $02 ; rest-note $1F dur 2
    db $a0, $06 ; volume $06
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $a0, $04 ; volume $04
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $a0, $02 ; volume $02
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $a0, $01 ; volume $01
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $1f, $08 ; rest-note $1F dur 8
    db $ff, $ff ; end

; sound track, 27 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_28::
    db $04, $00, $0f, $00 ; header: param=4 byte1=$00 volume=$0F byte3=$00
    db $c1, $09 ; env $09
    db $27, $0c ; note G2 dur 12
    db $30, $0c ; note C3 dur 12
    db $34, $0c ; note E3 dur 12
    db $37, $0c ; note G3 dur 12
    db $a0, $0d ; volume $0D
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $a0, $0b ; volume $0B
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $a0, $09 ; volume $09
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $a0, $07 ; volume $07
    db $34, $03 ; note E3 dur 3
    db $40, $03 ; note C4 dur 3
    db $a0, $05 ; volume $05
    db $34, $03 ; note E3 dur 3
    db $a0, $03 ; volume $03
    db $40, $03 ; note C4 dur 3
    db $a0, $02 ; volume $02
    db $34, $03 ; note E3 dur 3
    db $a0, $01 ; volume $01
    db $40, $03 ; note C4 dur 3
    db $1f, $0b ; rest-note $1F dur 11
    db $ff, $ff ; end

; sound track, 7 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_29::
    db $04, $06, $06, $02 ; header: param=4 byte1=$06 volume=$06 byte3=$02
    db $1f, $07 ; rest-note $1F dur 7
    db $37, $0c ; note G3 dur 12
    db $40, $0c ; note C4 dur 12
    db $44, $0c ; note E4 dur 12
    db $47, $0c ; note G4 dur 12
    db $1f, $28 ; rest-note $1F dur 40
    db $ff, $ff ; end

; sound track, 2 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_2A::
    db $04, $00, $00, $00 ; header: param=4 byte1=$00 volume=$00 byte3=$00
    db $1f, $70 ; rest-note $1F dur 112
    db $ff, $ff ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_2B::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

SoundTrack_42_2C::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

SoundTrack_42_2D::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

SoundTrack_42_2E::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

; sound track, 16 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_2F::
    db $00, $00, $0d, $00 ; header: param=0 byte1=$00 volume=$0D byte3=$00
    db $47, $05 ; note G4 dur 5
    db $a0, $02 ; volume $02
    db $47, $08 ; note G4 dur 8
    db $a0, $0d ; volume $0D
    db $43, $05 ; note D#4 dur 5
    db $a0, $02 ; volume $02
    db $43, $08 ; note D#4 dur 8
    db $a0, $0d ; volume $0D
    db $47, $05 ; note G4 dur 5
    db $a0, $02 ; volume $02
    db $47, $08 ; note G4 dur 8
    db $a0, $0d ; volume $0D
    db $43, $05 ; note D#4 dur 5
    db $a0, $03 ; volume $03
    db $43, $09 ; note D#4 dur 9
    db $ff, $ff ; end

; sound track, 84 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_30::
    db $00, $02, $02, $00 ; header: param=0 byte1=$02 volume=$02 byte3=$00
    db $fd, $f0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $b5, $f0 ; repeat $F0
    db $a0, $03 ; volume $03
    db $fd, $f0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $b5, $f0 ; repeat $F0
    db $a0, $04 ; volume $04
    db $fd, $f0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $b5, $f0 ; repeat $F0
    db $a0, $05 ; volume $05
    db $fd, $f0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $b5, $f0 ; repeat $F0
    db $a0, $07 ; volume $07
    db $fd, $f0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $b5, $f0 ; repeat $F0
    db $a0, $09 ; volume $09
    db $fd, $f0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $b5, $f0 ; repeat $F0
    db $a0, $0b ; volume $0B
    db $fd, $f0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $b3, $f0 ; repeat $F0
    db $a0, $0d ; volume $0D
    db $fd, $f0 ; label 0
    db $30, $02 ; note C3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $b3, $f0 ; repeat $F0
    db $a0, $0f ; volume $0F
    db $fd, $f0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $33, $02 ; note D#3 dur 2
    db $ba, $f0 ; repeat $F0
    db $a0, $0d ; volume $0D
    db $fd, $f0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $ba, $f0 ; repeat $F0
    db $fd, $f0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $ba, $f0 ; repeat $F0
    db $a0, $09 ; volume $09
    db $fd, $f0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $b6, $f0 ; repeat $F0
    db $a0, $07 ; volume $07
    db $fd, $f0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $b3, $f0 ; repeat $F0
    db $a0, $04 ; volume $04
    db $fd, $f0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $b5, $f0 ; repeat $F0
    db $a0, $03 ; volume $03
    db $fd, $f0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $ba, $f0 ; repeat $F0
    db $a0, $02 ; volume $02
    db $fd, $f0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $b3, $f0 ; repeat $F0
    db $a0, $01 ; volume $01
    db $fd, $f0 ; label 0
    db $31, $02 ; note C#3 dur 2
    db $34, $02 ; note E3 dur 2
    db $b2, $f0 ; repeat $F0
    db $ff, $ff ; end

; sound track, 8 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_31::
    db $00, $01, $0f, $37 ; header: param=0 byte1=$01 volume=$0F byte3=$37
    db $1b, $02 ; note B1 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $20, $01 ; note C2 dur 1
    db $1f, $01 ; rest-note $1F dur 1
    db $21, $02 ; note C#2 dur 2
    db $a0, $05 ; volume $05
    db $21, $03 ; note C#2 dur 3
    db $ff, $ff ; end

; sound track, 6 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_32::
    db $00, $01, $0f, $2d ; header: param=0 byte1=$01 volume=$0F byte3=$2D
    db $ae, $10 ; tuning $10
    db $14, $03 ; note E1 dur 3
    db $11, $02 ; note C#1 dur 2
    db $a0, $08 ; volume $08
    db $11, $03 ; note C#1 dur 3
    db $ff, $ff ; end

; sound track, 7 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_33::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $1f, $01 ; rest-note $1F dur 1
    db $80, $02 ; note C8 dur 2
    db $a0, $08 ; volume $08
    db $80, $02 ; note C8 dur 2
    db $a0, $04 ; volume $04
    db $80, $02 ; note C8 dur 2
    db $ff, $ff ; end

; sound track, 5 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_34::
    db $00, $02, $0f, $17 ; header: param=0 byte1=$02 volume=$0F byte3=$17
    db $c1, $60 ; env $60
    db $29, $06 ; note A2 dur 6
    db $a1, $2f ; duty $2F
    db $42, $30 ; note D4 dur 48
    db $ff, $ff ; end

SoundTrack_42_35::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $13, $03 ; note D#1 dur 3
    db $37, $06 ; note G3 dur 6
    db $a0, $04 ; volume $04
    db $37, $02 ; note G3 dur 2
    db $ff, $ff ; end

; sound track, 13 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_36::
    db $00, $00, $0f, $17 ; header: param=0 byte1=$00 volume=$0F byte3=$17
    db $18, $12 ; note G#1 dur 18
    db $a1, $2f ; duty $2F
    db $6b, $12 ; note B6 dur 18
    db $a1, $17 ; duty $17
    db $1f, $01 ; rest-note $1F dur 1
    db $18, $12 ; note G#1 dur 18
    db $a1, $2f ; duty $2F
    db $6b, $12 ; note B6 dur 18
    db $a0, $06 ; volume $06
    db $6b, $12 ; note B6 dur 18
    db $a0, $02 ; volume $02
    db $6b, $12 ; note B6 dur 18
    db $ff, $ff ; end

; sound track, 68 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_37::
    db $00, $00, $0c, $17 ; header: param=0 byte1=$00 volume=$0C byte3=$17
    db $fd, $f0 ; label 0
    db $15, $01 ; note F1 dur 1
    db $17, $01 ; note G1 dur 1
    db $19, $01 ; note A1 dur 1
    db $20, $01 ; note C2 dur 1
    db $23, $01 ; note D#2 dur 1
    db $25, $01 ; note F2 dur 1
    db $27, $01 ; note G2 dur 1
    db $29, $01 ; note A2 dur 1
    db $2b, $01 ; note B2 dur 1
    db $30, $01 ; note C3 dur 1
    db $33, $01 ; note D#3 dur 1
    db $35, $01 ; note F3 dur 1
    db $37, $01 ; note G3 dur 1
    db $39, $01 ; note A3 dur 1
    db $3b, $01 ; note B3 dur 1
    db $40, $01 ; note C4 dur 1
    db $42, $01 ; note D4 dur 1
    db $44, $01 ; note E4 dur 1
    db $46, $01 ; note F#4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $4b, $01 ; note B4 dur 1
    db $50, $01 ; note C5 dur 1
    db $4b, $01 ; note B4 dur 1
    db $49, $01 ; note A4 dur 1
    db $47, $01 ; note G4 dur 1
    db $45, $01 ; note F4 dur 1
    db $43, $01 ; note D#4 dur 1
    db $41, $01 ; note C#4 dur 1
    db $3b, $01 ; note B3 dur 1
    db $39, $01 ; note A3 dur 1
    db $37, $01 ; note G3 dur 1
    db $35, $01 ; note F3 dur 1
    db $33, $01 ; note D#3 dur 1
    db $30, $01 ; note C3 dur 1
    db $b1, $f0 ; repeat $F0
    db $a0, $04 ; volume $04
    db $52, $01 ; note D5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4b, $01 ; note B4 dur 1
    db $49, $01 ; note A4 dur 1
    db $47, $01 ; note G4 dur 1
    db $45, $01 ; note F4 dur 1
    db $43, $01 ; note D#4 dur 1
    db $41, $01 ; note C#4 dur 1
    db $3b, $01 ; note B3 dur 1
    db $39, $01 ; note A3 dur 1
    db $37, $01 ; note G3 dur 1
    db $35, $01 ; note F3 dur 1
    db $33, $01 ; note D#3 dur 1
    db $30, $01 ; note C3 dur 1
    db $a0, $02 ; volume $02
    db $52, $01 ; note D5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4b, $01 ; note B4 dur 1
    db $49, $01 ; note A4 dur 1
    db $47, $01 ; note G4 dur 1
    db $45, $01 ; note F4 dur 1
    db $43, $01 ; note D#4 dur 1
    db $41, $01 ; note C#4 dur 1
    db $3b, $01 ; note B3 dur 1
    db $39, $01 ; note A3 dur 1
    db $37, $01 ; note G3 dur 1
    db $35, $01 ; note F3 dur 1
    db $33, $01 ; note D#3 dur 1
    db $30, $01 ; note C3 dur 1
    db $1f, $10 ; rest-note $1F dur 16
    db $ff, $ff ; end

; sound track, 4 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_38::
    db $00, $02, $07, $00 ; header: param=0 byte1=$02 volume=$07 byte3=$00
    db $57, $02 ; note G5 dur 2
    db $a0, $02 ; volume $02
    db $57, $04 ; note G5 dur 4
    db $ff, $ff ; end

; sound track, 2 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_39::
    db $00, $02, $0f, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $30, $01 ; note C3 dur 1
    db $ff, $ff ; end

SoundTrack_42_3A::
    db $00, $02, $0f, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $29, $01 ; note A2 dur 1
    db $ff, $ff ; end

; sound track, 15 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_3B::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $50, $02 ; note C5 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $56, $02 ; note F#5 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $50, $02 ; note C5 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $56, $02 ; note F#5 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $50, $02 ; note C5 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $56, $02 ; note F#5 dur 2
    db $a0, $02 ; volume $02
    db $56, $04 ; note F#5 dur 4
    db $ff ; end

; sound track, 164 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_3C::
    db $00, $02, $0f, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $a3, $20 ; mod $20
    db $fd, $f0 ; label 0
    db $a2, $02 ; duty2 $02
    db $a0, $05 ; volume $05
    db $a5, $ff ; pan $FF
    db $1f, $08 ; rest-note $1F dur 8
    db $58, $01 ; note G#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $5a, $01 ; note A#5 dur 1
    db $5b, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $5a, $01 ; note A#5 dur 1
    db $5b, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
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
    db $4b, $01 ; note B4 dur 1
    db $4a, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $a5, $f0 ; pan $F0
    db $1f, $10 ; rest-note $1F dur 16
    db $5a, $01 ; note A#5 dur 1
    db $5b, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
    db $5b, $01 ; note B5 dur 1
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
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
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
    db $4b, $01 ; note B4 dur 1
    db $4a, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $1f, $22 ; rest-note $1F dur 34
    db $a5, $0f ; pan $0F
    db $64, $01 ; note E6 dur 1
    db $63, $01 ; note D#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4b, $01 ; note B4 dur 1
    db $4a, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $1f, $1c ; rest-note $1F dur 28
    db $a5, $f0 ; pan $F0
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
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
    db $4b, $01 ; note B4 dur 1
    db $4a, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $1f, $1d ; rest-note $1F dur 29
    db $a2, $01 ; duty2 $01
    db $a0, $0a ; volume $0A
    db $a5, $f0 ; pan $F0
    db $68, $01 ; note G#6 dur 1
    db $69, $01 ; note A6 dur 1
    db $6a, $01 ; note A#6 dur 1
    db $6b, $01 ; note B6 dur 1
    db $6a, $01 ; note A#6 dur 1
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
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
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
    db $4b, $01 ; note B4 dur 1
    db $4a, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $b0, $f0 ; jump $F0
    db $ff ; end

; sound track, 168 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_3D::
    db $00, $02, $0f, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $a2, $02 ; duty2 $02
    db $fd, $f0 ; label 0
    db $a0, $0f ; volume $0F
    db $a5, $ff ; pan $FF
    db $58, $01 ; note G#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $5a, $01 ; note A#5 dur 1
    db $5b, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $5a, $01 ; note A#5 dur 1
    db $5b, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
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
    db $4b, $01 ; note B4 dur 1
    db $4a, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $a5, $f0 ; pan $F0
    db $1f, $10 ; rest-note $1F dur 16
    db $5a, $01 ; note A#5 dur 1
    db $5b, $01 ; note B5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
    db $5b, $01 ; note B5 dur 1
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
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
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
    db $4b, $01 ; note B4 dur 1
    db $4a, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $1f, $22 ; rest-note $1F dur 34
    db $a0, $0d ; volume $0D
    db $a5, $0f ; pan $0F
    db $64, $01 ; note E6 dur 1
    db $63, $01 ; note D#6 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
    db $59, $01 ; note A5 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $58, $01 ; note G#5 dur 1
    db $57, $01 ; note G5 dur 1
    db $56, $01 ; note F#5 dur 1
    db $55, $01 ; note F5 dur 1
    db $54, $01 ; note E5 dur 1
    db $53, $01 ; note D#5 dur 1
    db $52, $01 ; note D5 dur 1
    db $51, $01 ; note C#5 dur 1
    db $50, $01 ; note C5 dur 1
    db $4b, $01 ; note B4 dur 1
    db $4a, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $1f, $1c ; rest-note $1F dur 28
    db $a0, $0f ; volume $0F
    db $a5, $f0 ; pan $F0
    db $62, $01 ; note D6 dur 1
    db $61, $01 ; note C#6 dur 1
    db $60, $01 ; note C6 dur 1
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
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
    db $4b, $01 ; note B4 dur 1
    db $4a, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $1f, $09 ; rest-note $1F dur 9
    db $a0, $0c ; volume $0C
    db $a5, $0f ; pan $0F
    db $5a, $01 ; note A#5 dur 1
    db $5b, $01 ; note B5 dur 1
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
    db $5b, $01 ; note B5 dur 1
    db $5a, $01 ; note A#5 dur 1
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
    db $4b, $01 ; note B4 dur 1
    db $4a, $01 ; note A#4 dur 1
    db $49, $01 ; note A4 dur 1
    db $48, $01 ; note G#4 dur 1
    db $47, $01 ; note G4 dur 1
    db $46, $01 ; note F#4 dur 1
    db $45, $01 ; note F4 dur 1
    db $44, $01 ; note E4 dur 1
    db $1f, $18 ; rest-note $1F dur 24
    db $b0, $f0 ; jump $F0
    db $ff ; end

; sound track, 7 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_3E::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $a3, $3a ; mod $3A
    db $fd, $f0 ; label 0
    db $21, $60 ; note C#2 dur 96
    db $30, $60 ; note C3 dur 96
    db $21, $44 ; note C#2 dur 68
    db $b0, $f0 ; jump $F0
    db $ff ; end

; sound track, 6 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_3F::
    db $00, $02, $0c, $2a ; header: param=0 byte1=$02 volume=$0C byte3=$2A
    db $fd, $f0 ; label 0
    db $10, $05 ; note C1 dur 5
    db $11, $05 ; note C#1 dur 5
    db $12, $04 ; note D1 dur 4
    db $b0, $f0 ; jump $F0
    db $ff, $ff ; end

; sound track, 10 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_40::
    db $00, $00, $0c, $00 ; header: param=0 byte1=$00 volume=$0C byte3=$00
    db $fd, $f0 ; label 0
    db $61, $03 ; note C#6 dur 3
    db $52, $20 ; note D5 dur 32
    db $c1, $7f ; env $7F
    db $52, $05 ; note D5 dur 5
    db $b0, $f0 ; jump $F0
    db $22, $20 ; note D2 dur 32
    db $a0, $05 ; volume $05
    db $22, $28 ; note D2 dur 40
    db $ff, $ff ; end

; sound track, 8 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_41::
    db $00, $00, $0f, $27 ; header: param=0 byte1=$00 volume=$0F byte3=$27
    db $17, $05 ; note G1 dur 5
    db $1f, $02 ; rest-note $1F dur 2
    db $a1, $45 ; duty $45
    db $20, $06 ; note C2 dur 6
    db $a0, $06 ; volume $06
    db $22, $06 ; note D2 dur 6
    db $1f, $03 ; rest-note $1F dur 3
    db $ff, $ff ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_42::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $5d, $02 ; rest-note $5D dur 2
    db $71, $03 ; note C#7 dur 3
    db $1f, $02 ; rest-note $1F dur 2
    db $60, $05 ; note C6 dur 5
    db $a0, $06 ; volume $06
    db $60, $05 ; note C6 dur 5
    db $a0, $03 ; volume $03
    db $60, $05 ; note C6 dur 5
    db $ff, $ff ; end

; sound track, 20 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_43::
    db $00, $00, $0f, $15 ; header: param=0 byte1=$00 volume=$0F byte3=$15
    db $20, $02 ; note C2 dur 2
    db $20, $02 ; note C2 dur 2
    db $20, $02 ; note C2 dur 2
    db $20, $02 ; note C2 dur 2
    db $30, $03 ; note C3 dur 3
    db $34, $03 ; note E3 dur 3
    db $a1, $27 ; duty $27
    db $30, $05 ; note C3 dur 5
    db $1f, $01 ; rest-note $1F dur 1
    db $42, $03 ; note D4 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $0b ; volume $0B
    db $42, $05 ; note D4 dur 5
    db $a0, $03 ; volume $03
    db $1f, $01 ; rest-note $1F dur 1
    db $43, $05 ; note D#4 dur 5
    db $a0, $01 ; volume $01
    db $1f, $01 ; rest-note $1F dur 1
    db $43, $05 ; note D#4 dur 5
    db $ff, $ff ; end

SoundTrack_42_44::
    db $00, $01, $0f, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $fd, $f0 ; label 0
    db $50, $01 ; note C5 dur 1
    db $1f, $02 ; rest-note $1F dur 2
    db $b3, $f0 ; repeat $F0
    db $a0, $0b ; volume $0B
    db $50, $01 ; note C5 dur 1
    db $1f, $01 ; rest-note $1F dur 1
    db $50, $01 ; note C5 dur 1
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $09 ; volume $09
    db $50, $01 ; note C5 dur 1
    db $1f, $01 ; rest-note $1F dur 1
    db $50, $01 ; note C5 dur 1
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $05 ; volume $05
    db $50, $01 ; note C5 dur 1
    db $1f, $01 ; rest-note $1F dur 1
    db $50, $01 ; note C5 dur 1
    db $1f, $12 ; rest-note $1F dur 18
    db $ff, $ff ; end

; sound track, 14 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_45::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $fd, $f0 ; label 0
    db $a0, $0a ; volume $0A
    db $cc, $6f ; env $6F
    db $12, $80 ; note D1 dur 128
    db $a0, $0b ; volume $0B
    db $c1, $7f ; env $7F
    db $12, $30 ; note D1 dur 48
    db $c0, $fe ; env $FE
    db $a0, $08 ; volume $08
    db $11, $80 ; note C#1 dur 128
    db $c1, $7f ; env $7F
    db $11, $2a ; note C#1 dur 42
    db $b0, $f0 ; jump $F0
    db $ff, $ff ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_46::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

; sound track, 10 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_47::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $1e, $01 ; rest-note $1E dur 1
    db $1f, $03 ; rest-note $1F dur 3
    db $a0, $06 ; volume $06
    db $1e, $01 ; rest-note $1E dur 1
    db $a0, $0f ; volume $0F
    db $1d, $01 ; rest-note $1D dur 1
    db $25, $01 ; note F2 dur 1
    db $a0, $03 ; volume $03
    db $1c, $02 ; rest-note $1C dur 2
    db $ff, $ff ; end

SoundTrack_42_48::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

; sound track, 13 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_49::
    db $00, $01, $0f, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $c2, $40 ; env $40
    db $ae, $10 ; tuning $10
    db $30, $05 ; note C3 dur 5
    db $ae, $00 ; tuning $00
    db $33, $05 ; note D#3 dur 5
    db $31, $05 ; note C#3 dur 5
    db $34, $05 ; note E3 dur 5
    db $32, $05 ; note D3 dur 5
    db $35, $05 ; note F3 dur 5
    db $36, $05 ; note F#3 dur 5
    db $a0, $04 ; volume $04
    db $36, $0a ; note F#3 dur 10
    db $ff ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_4A::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $12, $02 ; note D1 dur 2
    db $1f, $02 ; rest-note $1F dur 2
    db $c7, $30 ; env $30
    db $10, $18 ; note C1 dur 24
    db $a0, $07 ; volume $07
    db $10, $10 ; note C1 dur 16
    db $a0, $05 ; volume $05
    db $10, $20 ; note C1 dur 32
    db $ff ; end

SoundTrack_42_4B::
    db $00, $01, $0f, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $45, $02 ; note F4 dur 2
    db $46, $02 ; note F#4 dur 2
    db $44, $02 ; note E4 dur 2
    db $45, $02 ; note F4 dur 2
    db $46, $02 ; note F#4 dur 2
    db $44, $02 ; note E4 dur 2
    db $a0, $07 ; volume $07
    db $46, $02 ; note F#4 dur 2
    db $44, $02 ; note E4 dur 2
    db $ff ; end

SoundTrack_42_4C::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $fd, $f0 ; label 0
    db $33, $02 ; note D#3 dur 2
    db $62, $03 ; note D6 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $42, $02 ; note D4 dur 2
    db $51, $02 ; note C#5 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $b0, $f0 ; jump $F0
    db $ff ; end

; sound track, 22 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_4D::
    db $00, $02, $0f, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $10, $03 ; note C1 dur 3
    db $17, $03 ; note G1 dur 3
    db $20, $03 ; note C2 dur 3
    db $22, $02 ; note D2 dur 2
    db $24, $02 ; note E2 dur 2
    db $25, $02 ; note F2 dur 2
    db $27, $02 ; note G2 dur 2
    db $29, $02 ; note A2 dur 2
    db $2a, $02 ; note A#2 dur 2
    db $30, $02 ; note C3 dur 2
    db $32, $02 ; note D3 dur 2
    db $34, $02 ; note E3 dur 2
    db $35, $02 ; note F3 dur 2
    db $37, $02 ; note G3 dur 2
    db $39, $02 ; note A3 dur 2
    db $3a, $02 ; note A#3 dur 2
    db $c1, $30 ; env $30
    db $40, $15 ; note C4 dur 21
    db $a0, $05 ; volume $05
    db $40, $10 ; note C4 dur 16
    db $1f, $03 ; rest-note $1F dur 3
    db $ff, $ff ; end

; sound track, 21 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_4E::
    db $00, $02, $05, $00 ; header: param=0 byte1=$02 volume=$05 byte3=$00
    db $1f, $03 ; rest-note $1F dur 3
    db $10, $03 ; note C1 dur 3
    db $17, $03 ; note G1 dur 3
    db $20, $03 ; note C2 dur 3
    db $22, $02 ; note D2 dur 2
    db $24, $02 ; note E2 dur 2
    db $25, $02 ; note F2 dur 2
    db $27, $02 ; note G2 dur 2
    db $29, $02 ; note A2 dur 2
    db $2a, $02 ; note A#2 dur 2
    db $30, $02 ; note C3 dur 2
    db $32, $02 ; note D3 dur 2
    db $34, $02 ; note E3 dur 2
    db $35, $02 ; note F3 dur 2
    db $37, $02 ; note G3 dur 2
    db $39, $02 ; note A3 dur 2
    db $3a, $02 ; note A#3 dur 2
    db $c1, $40 ; env $40
    db $a3, $0d ; mod $0D
    db $40, $25 ; note C4 dur 37
    db $ff, $ff ; end

; sound track, 11 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_4F::
    db $00, $01, $0f, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $32, $02 ; note D3 dur 2
    db $2b, $02 ; note B2 dur 2
    db $33, $02 ; note D#3 dur 2
    db $32, $02 ; note D3 dur 2
    db $2b, $02 ; note B2 dur 2
    db $33, $02 ; note D#3 dur 2
    db $a0, $07 ; volume $07
    db $33, $02 ; note D#3 dur 2
    db $2b, $02 ; note B2 dur 2
    db $33, $02 ; note D#3 dur 2
    db $ff ; end

; sound track, 6 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_50::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $50, $04 ; note C5 dur 4
    db $51, $04 ; note C#5 dur 4
    db $61, $03 ; note C#6 dur 3
    db $a0, $03 ; volume $03
    db $50, $03 ; note C5 dur 3
    db $ff ; end

; sound track, 12 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_51::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $47, $04 ; note G4 dur 4
    db $1f, $02 ; rest-note $1F dur 2
    db $43, $03 ; note D#4 dur 3
    db $1f, $02 ; rest-note $1F dur 2
    db $47, $04 ; note G4 dur 4
    db $1f, $02 ; rest-note $1F dur 2
    db $43, $04 ; note D#4 dur 4
    db $1f, $02 ; rest-note $1F dur 2
    db $44, $04 ; note E4 dur 4
    db $1f, $02 ; rest-note $1F dur 2
    db $34, $04 ; note E3 dur 4
    db $ff ; end

; sound track, 8 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_52::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $50, $02 ; note C5 dur 2
    db $33, $06 ; note D#3 dur 6
    db $50, $02 ; note C5 dur 2
    db $33, $06 ; note D#3 dur 6
    db $50, $02 ; note C5 dur 2
    db $33, $06 ; note D#3 dur 6
    db $60, $03 ; note C6 dur 3
    db $ff ; end

SoundTrack_42_53::
    db $00, $02, $0f, $00 ; header: param=0 byte1=$02 volume=$0F byte3=$00
    db $3b, $04 ; note B3 dur 4
    db $39, $04 ; note A3 dur 4
    db $35, $04 ; note F3 dur 4
    db $a0, $07 ; volume $07
    db $35, $05 ; note F3 dur 5
    db $ff ; end

; sound track, 29 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_54::
    db $00, $01, $0f, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $45, $02 ; note F4 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $a0, $0b ; volume $0B
    db $45, $02 ; note F4 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $a0, $09 ; volume $09
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $a0, $05 ; volume $05
    db $45, $02 ; note F4 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $a0, $03 ; volume $03
    db $50, $02 ; note C5 dur 2
    db $54, $02 ; note E5 dur 2
    db $49, $02 ; note A4 dur 2
    db $50, $02 ; note C5 dur 2
    db $ff ; end

SoundTrack_42_55::
    db $00, $02, $0f, $26 ; header: param=0 byte1=$02 volume=$0F byte3=$26
    db $a0, $0f ; volume $0F
    db $0a, $14 ; note A#0 dur 20
    db $a1, $00 ; duty $00
    db $c1, $7f ; env $7F
    db $a0, $0e ; volume $0E
    db $ae, $10 ; tuning $10
    db $15, $20 ; note F1 dur 32
    db $a0, $07 ; volume $07
    db $15, $1a ; note F1 dur 26
    db $a0, $03 ; volume $03
    db $15, $25 ; note F1 dur 37
    db $ff, $ff ; end

; sound track, 11 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_56::
    db $00, $02, $0f, $2e ; header: param=0 byte1=$02 volume=$0F byte3=$2E
    db $47, $05 ; note G4 dur 5
    db $44, $07 ; note E4 dur 7
    db $a0, $0c ; volume $0C
    db $40, $06 ; note C4 dur 6
    db $38, $06 ; note G#3 dur 6
    db $a0, $0a ; volume $0A
    db $35, $06 ; note F3 dur 6
    db $33, $06 ; note D#3 dur 6
    db $a0, $07 ; volume $07
    db $2b, $05 ; note B2 dur 5
    db $ff ; end

; sound track, 68 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_57::
    db $00, $02, $0f, $1f ; header: param=0 byte1=$02 volume=$0F byte3=$1F
    db $a0, $0f ; volume $0F
    db $a1, $1f ; duty $1F
    db $38, $04 ; note G#3 dur 4
    db $a1, $17 ; duty $17
    db $a0, $0e ; volume $0E
    db $33, $03 ; note D#3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $0e ; volume $0E
    db $a1, $1f ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $a1, $17 ; duty $17
    db $a0, $0c ; volume $0C
    db $33, $03 ; note D#3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $0d ; volume $0D
    db $a1, $1f ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $a1, $17 ; duty $17
    db $a0, $0b ; volume $0B
    db $33, $03 ; note D#3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $0c ; volume $0C
    db $a1, $1f ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $a1, $17 ; duty $17
    db $a0, $0a ; volume $0A
    db $33, $03 ; note D#3 dur 3
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $0a ; volume $0A
    db $a1, $1f ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $a1, $17 ; duty $17
    db $a0, $08 ; volume $08
    db $33, $03 ; note D#3 dur 3
    db $a0, $09 ; volume $09
    db $a1, $1f ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $a1, $17 ; duty $17
    db $a0, $07 ; volume $07
    db $33, $03 ; note D#3 dur 3
    db $a0, $08 ; volume $08
    db $a1, $1f ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $a1, $17 ; duty $17
    db $a0, $06 ; volume $06
    db $33, $03 ; note D#3 dur 3
    db $a0, $06 ; volume $06
    db $a1, $1f ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $a1, $17 ; duty $17
    db $a0, $05 ; volume $05
    db $33, $03 ; note D#3 dur 3
    db $a0, $04 ; volume $04
    db $a1, $1f ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $a1, $17 ; duty $17
    db $33, $03 ; note D#3 dur 3
    db $a0, $02 ; volume $02
    db $a1, $1f ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $a1, $17 ; duty $17
    db $33, $03 ; note D#3 dur 3
    db $a0, $01 ; volume $01
    db $a1, $1f ; duty $1F
    db $38, $03 ; note G#3 dur 3
    db $a1, $17 ; duty $17
    db $33, $03 ; note D#3 dur 3
    db $ff, $ff ; end

; sound track, 41 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_58::
    db $00, $00, $0f, $23 ; header: param=0 byte1=$00 volume=$0F byte3=$23
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $01 ; note F#1 dur 1
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $0c ; volume $0C
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $01 ; note F#1 dur 1
    db $a0, $0a ; volume $0A
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $09 ; volume $09
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $07 ; volume $07
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $ae, $10 ; tuning $10
    db $a0, $04 ; volume $04
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $01 ; note F#1 dur 1
    db $ae, $10 ; tuning $10
    db $18, $01 ; note G#1 dur 1
    db $ae, $10 ; tuning $10
    db $1b, $01 ; note B1 dur 1
    db $17, $01 ; note G1 dur 1
    db $16, $01 ; note F#1 dur 1
    db $ae, $00 ; tuning $00
    db $ff, $ff ; end

; sound track, 5 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_59::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $27, $02 ; note G2 dur 2
    db $27, $02 ; note G2 dur 2
    db $a0, $05 ; volume $05
    db $27, $08 ; note G2 dur 8
    db $ff, $ff ; end

; sound track, 74 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_5A::
    db $00, $00, $0f, $23 ; header: param=0 byte1=$00 volume=$0F byte3=$23
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $01 ; note F#1 dur 1
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $0c ; volume $0C
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $01 ; note F#1 dur 1
    db $a0, $0a ; volume $0A
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $09 ; volume $09
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $07 ; volume $07
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $ae, $10 ; tuning $10
    db $18, $02 ; note G#1 dur 2
    db $ae, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $ae, $10 ; tuning $10
    db $20, $02 ; note C2 dur 2
    db $1f, $15 ; rest-note $1F dur 21
    db $a2, $01 ; duty2 $01
    db $a1, $1d ; duty $1D
    db $a0, $0f ; volume $0F
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
    db $3b, $02 ; note B3 dur 2
    db $2a, $02 ; note A#2 dur 2
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
    db $1a, $02 ; note A#1 dur 2
    db $a0, $06 ; volume $06
    db $18, $02 ; note G#1 dur 2
    db $16, $02 ; note F#1 dur 2
    db $14, $02 ; note E1 dur 2
    db $12, $02 ; note D1 dur 2
    db $10, $02 ; note C1 dur 2
    db $0a, $02 ; note A#0 dur 2
    db $08, $02 ; note G#0 dur 2
    db $06, $02 ; note F#0 dur 2
    db $ff, $ff ; end
    db $ff, $ff ; end

SoundTrack_42_5B::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $27, $02 ; note G2 dur 2
    db $27, $02 ; note G2 dur 2
    db $a0, $05 ; volume $05
    db $27, $06 ; note G2 dur 6
    db $ff, $ff ; end

; sound track, 107 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_5C::
    db $00, $00, $0f, $23 ; header: param=0 byte1=$00 volume=$0F byte3=$23
    db $ae, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $ae, $00 ; tuning $00
    db $19, $01 ; note A1 dur 1
    db $ae, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $ae, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $ae, $10 ; tuning $10
    db $22, $01 ; note D2 dur 1
    db $ae, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $09 ; volume $09
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $07 ; volume $07
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a2, $01 ; duty2 $01
    db $a1, $1d ; duty $1D
    db $a0, $0f ; volume $0F
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $24, $01 ; note E2 dur 1
    db $ae, $10 ; tuning $10
    db $22, $01 ; note D2 dur 1
    db $ae, $00 ; tuning $00
    db $20, $02 ; note C2 dur 2
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $ae, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $ae, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $ae, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $ae, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $ae, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $ae, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $ae, $00 ; tuning $00
    db $22, $02 ; note D2 dur 2
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $ae, $00 ; tuning $00
    db $22, $02 ; note D2 dur 2
    db $ae, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $ae, $00 ; tuning $00
    db $22, $02 ; note D2 dur 2
    db $ae, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $ae, $00 ; tuning $00
    db $22, $02 ; note D2 dur 2
    db $ae, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $ae, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $ae, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $ae, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $ae, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $ae, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $ae, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $ae, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $ae, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $ae, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $ae, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $a0, $09 ; volume $09
    db $ae, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $ae, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $ae, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $ae, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $ae, $10 ; tuning $10
    db $14, $01 ; note E1 dur 1
    db $ae, $00 ; tuning $00
    db $10, $02 ; note C1 dur 2
    db $ae, $10 ; tuning $10
    db $06, $02 ; note F#0 dur 2
    db $ff, $ff ; end

SoundTrack_42_5D::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $37, $02 ; note G3 dur 2
    db $37, $02 ; note G3 dur 2
    db $a0, $08 ; volume $08
    db $37, $06 ; note G3 dur 6
    db $ff, $ff ; end

; sound track, 201 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_5E::
    db $00, $01, $0f, $1d ; header: param=0 byte1=$01 volume=$0F byte3=$1D
    db $a2, $01 ; duty2 $01
    db $a1, $1d ; duty $1D
    db $ae, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $ae, $00 ; tuning $00
    db $19, $01 ; note A1 dur 1
    db $ae, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $ae, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $ae, $10 ; tuning $10
    db $22, $01 ; note D2 dur 1
    db $ae, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $09 ; volume $09
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $07 ; volume $07
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a1, $1b ; duty $1B
    db $a0, $0f ; volume $0F
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $ae, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $ae, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $ae, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $ae, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $ae, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $ae, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $a1, $1c ; duty $1C
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $a1, $1d ; duty $1D
    db $a0, $0f ; volume $0F
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $ae, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $ae, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $ae, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $ae, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $ae, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $ae, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $09 ; volume $09
    db $ae, $10 ; tuning $10
    db $2a, $01 ; note A#2 dur 1
    db $ae, $00 ; tuning $00
    db $2b, $02 ; note B2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $a0, $06 ; volume $06
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $a0, $03 ; volume $03
    db $ae, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $a0, $02 ; volume $02
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ff, $ff ; end

; sound track, 19 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_5F::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
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
    db $a0, $06 ; volume $06
    db $45, $05 ; note F4 dur 5
    db $a0, $04 ; volume $04
    db $45, $05 ; note F4 dur 5
    db $ff, $ff ; end

; sound track, 22 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_60::
    db $00, $00, $0f, $17 ; header: param=0 byte1=$00 volume=$0F byte3=$17
    db $a0, $08 ; volume $08
    db $23, $02 ; note D#2 dur 2
    db $24, $02 ; note E2 dur 2
    db $25, $02 ; note F2 dur 2
    db $26, $02 ; note F#2 dur 2
    db $a0, $0b ; volume $0B
    db $27, $02 ; note G2 dur 2
    db $28, $02 ; note G#2 dur 2
    db $29, $02 ; note A2 dur 2
    db $2a, $02 ; note A#2 dur 2
    db $a0, $0d ; volume $0D
    db $2b, $02 ; note B2 dur 2
    db $30, $02 ; note C3 dur 2
    db $31, $02 ; note C#3 dur 2
    db $32, $02 ; note D3 dur 2
    db $33, $03 ; note D#3 dur 3
    db $34, $02 ; note E3 dur 2
    db $35, $02 ; note F3 dur 2
    db $a0, $09 ; volume $09
    db $35, $02 ; note F3 dur 2
    db $a0, $0f ; volume $0F
    db $ff, $ff ; end

; sound track, 32 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_61::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $1f, $20 ; rest-note $1F dur 32
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
    db $a0, $0b ; volume $0B
    db $45, $05 ; note F4 dur 5
    db $45, $05 ; note F4 dur 5
    db $a0, $0e ; volume $0E
    db $55, $02 ; note F5 dur 2
    db $14, $01 ; note E1 dur 1
    db $45, $02 ; note F4 dur 2
    db $45, $06 ; note F4 dur 6
    db $a0, $06 ; volume $06
    db $45, $05 ; note F4 dur 5
    db $45, $05 ; note F4 dur 5
    db $a0, $08 ; volume $08
    db $55, $02 ; note F5 dur 2
    db $14, $01 ; note E1 dur 1
    db $45, $02 ; note F4 dur 2
    db $45, $06 ; note F4 dur 6
    db $45, $05 ; note F4 dur 5
    db $a0, $04 ; volume $04
    db $45, $05 ; note F4 dur 5
    db $ff, $ff ; end

; sound track, 11 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_62::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $c3, $07 ; env $07
    db $21, $05 ; note C#2 dur 5
    db $23, $05 ; note D#2 dur 5
    db $c0, $fe ; env $FE
    db $23, $05 ; note D#2 dur 5
    db $22, $08 ; note D2 dur 8
    db $22, $07 ; note D2 dur 7
    db $a0, $08 ; volume $08
    db $c7, $30 ; env $30
    db $22, $20 ; note D2 dur 32
    db $ff, $ff ; end

; sound track, 18 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_63::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $11, $06 ; note C#1 dur 6
    db $13, $04 ; note D#1 dur 4
    db $22, $03 ; note D2 dur 3
    db $23, $04 ; note D#2 dur 4
    db $23, $07 ; note D#2 dur 7
    db $22, $07 ; note D2 dur 7
    db $12, $07 ; note D1 dur 7
    db $11, $18 ; note C#1 dur 24
    db $a0, $0b ; volume $0B
    db $11, $10 ; note C#1 dur 16
    db $a0, $0e ; volume $0E
    db $11, $10 ; note C#1 dur 16
    db $a0, $0a ; volume $0A
    db $11, $08 ; note C#1 dur 8
    db $c1, $20 ; env $20
    db $a0, $06 ; volume $06
    db $11, $20 ; note C#1 dur 32
    db $ff, $ff ; end

; sound track, 65 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_64::
    db $00, $00, $0f, $14 ; header: param=0 byte1=$00 volume=$0F byte3=$14
    db $ae, $10 ; tuning $10
    db $30, $02 ; note C3 dur 2
    db $2b, $03 ; note B2 dur 3
    db $1f, $02 ; rest-note $1F dur 2
    db $28, $03 ; note G#2 dur 3
    db $2b, $03 ; note B2 dur 3
    db $1f, $02 ; rest-note $1F dur 2
    db $2b, $04 ; note B2 dur 4
    db $1f, $02 ; rest-note $1F dur 2
    db $28, $02 ; note G#2 dur 2
    db $1a, $03 ; note A#1 dur 3
    db $2f, $01 ; rest-note $2F dur 1
    db $1a, $03 ; note A#1 dur 3
    db $1f, $02 ; rest-note $1F dur 2
    db $29, $01 ; note A2 dur 1
    db $18, $02 ; note G#1 dur 2
    db $1f, $02 ; rest-note $1F dur 2
    db $27, $01 ; note G2 dur 1
    db $17, $02 ; note G1 dur 2
    db $26, $01 ; note F#2 dur 1
    db $25, $02 ; note F2 dur 2
    db $24, $01 ; note E2 dur 1
    db $23, $02 ; note D#2 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $22, $01 ; note D2 dur 1
    db $21, $02 ; note C#2 dur 2
    db $20, $01 ; note C2 dur 1
    db $1b, $01 ; note B1 dur 1
    db $1a, $01 ; note A#1 dur 1
    db $19, $01 ; note A1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $17, $01 ; note G1 dur 1
    db $1f, $01 ; rest-note $1F dur 1
    db $16, $01 ; note F#1 dur 1
    db $15, $01 ; note F1 dur 1
    db $14, $01 ; note E1 dur 1
    db $a0, $08 ; volume $08
    db $1f, $01 ; rest-note $1F dur 1
    db $15, $01 ; note F1 dur 1
    db $17, $01 ; note G1 dur 1
    db $19, $01 ; note A1 dur 1
    db $a0, $06 ; volume $06
    db $1f, $02 ; rest-note $1F dur 2
    db $18, $01 ; note G#1 dur 1
    db $1b, $01 ; note B1 dur 1
    db $17, $01 ; note G1 dur 1
    db $1a, $01 ; note A#1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1b, $02 ; note B1 dur 2
    db $14, $01 ; note E1 dur 1
    db $a0, $04 ; volume $04
    db $1f, $02 ; rest-note $1F dur 2
    db $18, $01 ; note G#1 dur 1
    db $1b, $01 ; note B1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1f, $02 ; rest-note $1F dur 2
    db $1a, $01 ; note A#1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1f, $02 ; rest-note $1F dur 2
    db $14, $01 ; note E1 dur 1
    db $19, $01 ; note A1 dur 1
    db $1b, $01 ; note B1 dur 1
    db $19, $01 ; note A1 dur 1
    db $1a, $01 ; note A#1 dur 1
    db $ff, $ff ; end

; sound track, 20 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_65::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
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
    db $a0, $08 ; volume $08
    db $c1, $20 ; env $20
    db $20, $08 ; note C2 dur 8
    db $ff, $ff ; end

; sound track, 10 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_66::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $20, $07 ; note C2 dur 7
    db $12, $08 ; note D1 dur 8
    db $11, $08 ; note C#1 dur 8
    db $1f, $01 ; rest-note $1F dur 1
    db $50, $04 ; note C5 dur 4
    db $60, $10 ; note C6 dur 16
    db $c7, $20 ; env $20
    db $a0, $06 ; volume $06
    db $60, $20 ; note C6 dur 32
    db $ff, $ff ; end

; sound track, 11 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_67::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $45, $02 ; note F4 dur 2
    db $11, $02 ; note C#1 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $c3, $20 ; env $20
    db $45, $10 ; note F4 dur 16
    db $30, $09 ; note C3 dur 9
    db $c7, $30 ; env $30
    db $50, $06 ; note C5 dur 6
    db $43, $08 ; note D#4 dur 8
    db $60, $20 ; note C6 dur 32
    db $ff, $ff ; end

; sound track, 12 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_68::
    db $00, $02, $0f, $15 ; header: param=0 byte1=$02 volume=$0F byte3=$15
    db $08, $06 ; note G#0 dur 6
    db $09, $04 ; note A0 dur 4
    db $10, $03 ; note C1 dur 3
    db $09, $05 ; note A0 dur 5
    db $a0, $06 ; volume $06
    db $10, $05 ; note C1 dur 5
    db $08, $04 ; note G#0 dur 4
    db $09, $05 ; note A0 dur 5
    db $a0, $04 ; volume $04
    db $09, $05 ; note A0 dur 5
    db $0b, $03 ; note B0 dur 3
    db $ff, $ff ; end

SoundTrack_42_69::
    db $00, $02, $0f, $7f ; header: param=0 byte1=$02 volume=$0F byte3=$7F
    db $12, $02 ; note D1 dur 2
    db $19, $04 ; note A1 dur 4
    db $12, $03 ; note D1 dur 3
    db $1a, $05 ; note A#1 dur 5
    db $10, $05 ; note C1 dur 5
    db $a0, $0c ; volume $0C
    db $10, $04 ; note C1 dur 4
    db $a0, $0a ; volume $0A
    db $10, $05 ; note C1 dur 5
    db $a0, $03 ; volume $03
    db $10, $05 ; note C1 dur 5
    db $ff, $ff ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_6A::
    db $00, $01, $0f, $00 ; header: param=0 byte1=$01 volume=$0F byte3=$00
    db $a3, $17 ; mod $17
    db $4b, $01 ; note B4 dur 1
    db $49, $01 ; note A4 dur 1
    db $4a, $02 ; note A#4 dur 2
    db $4b, $18 ; note B4 dur 24
    db $c7, $30 ; env $30
    db $a3, $10 ; mod $10
    db $4b, $28 ; note B4 dur 40
    db $ff, $ff ; end

; sound track, 1 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_6B::
    db $00, $00, $00, $00 ; header: param=0 byte1=$00 volume=$00 byte3=$00
    db $ff, $ff ; end

; sound track, 16 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_6C::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $c7, $30 ; env $30
    db $50, $02 ; note C5 dur 2
    db $a0, $0f ; volume $0F
    db $40, $02 ; note C4 dur 2
    db $12, $08 ; note D1 dur 8
    db $30, $02 ; note C3 dur 2
    db $12, $09 ; note D1 dur 9
    db $40, $02 ; note C4 dur 2
    db $12, $08 ; note D1 dur 8
    db $a0, $0f ; volume $0F
    db $40, $02 ; note C4 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $12, $0c ; note D1 dur 12
    db $a0, $06 ; volume $06
    db $12, $10 ; note D1 dur 16
    db $ff, $ff ; end

SoundTrack_42_6D::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $43, $02 ; note D#4 dur 2
    db $50, $02 ; note C5 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $42, $07 ; note D4 dur 7
    db $a0, $08 ; volume $08
    db $42, $07 ; note D4 dur 7
    db $a0, $04 ; volume $04
    db $42, $07 ; note D4 dur 7
    db $ff, $ff ; end

; sound track, 152 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_6E::
    db $00, $00, $0f, $23 ; header: param=0 byte1=$00 volume=$0F byte3=$23
    db $ae, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $ae, $00 ; tuning $00
    db $19, $01 ; note A1 dur 1
    db $ae, $10 ; tuning $10
    db $20, $01 ; note C2 dur 1
    db $ae, $00 ; tuning $00
    db $19, $02 ; note A1 dur 2
    db $ae, $10 ; tuning $10
    db $22, $01 ; note D2 dur 1
    db $ae, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $09 ; volume $09
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a0, $07 ; volume $07
    db $ae, $10 ; tuning $10
    db $19, $01 ; note A1 dur 1
    db $ae, $00 ; tuning $00
    db $16, $02 ; note F#1 dur 2
    db $a2, $01 ; duty2 $01
    db $a1, $1d ; duty $1D
    db $a0, $0f ; volume $0F
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $29, $01 ; note A2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $29, $01 ; note A2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $22, $01 ; note D2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $01 ; note F#2 dur 1
    db $ae, $10 ; tuning $10
    db $24, $01 ; note E2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $ae, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $ae, $00 ; tuning $00
    db $28, $02 ; note G#2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $27, $02 ; note G2 dur 2
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $29, $01 ; note A2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $29, $01 ; note A2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $29, $01 ; note A2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $1f, $01 ; rest-note $1F dur 1
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $29, $01 ; note A2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $a0, $09 ; volume $09
    db $ae, $10 ; tuning $10
    db $2a, $01 ; note A#2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $2b, $02 ; note B2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $28, $01 ; note G#2 dur 1
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $29, $02 ; note A2 dur 2
    db $ae, $10 ; tuning $10
    db $28, $01 ; note G#2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $a0, $03 ; volume $03
    db $ae, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $28, $01 ; note G#2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ae, $10 ; tuning $10
    db $25, $01 ; note F2 dur 1
    db $ae, $00 ; tuning $00
    db $26, $02 ; note F#2 dur 2
    db $ff, $ff ; end

; sound track, 6 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_6F::
    db $00, $00, $07, $00 ; header: param=0 byte1=$00 volume=$07 byte3=$00
    db $1f, $03 ; rest-note $1F dur 3
    db $c3, $40 ; env $40
    db $70, $20 ; note C7 dur 32
    db $c7, $70 ; env $70
    db $70, $50 ; note C7 dur 80
    db $ff, $ff ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_70::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $40, $02 ; note C4 dur 2
    db $60, $03 ; note C6 dur 3
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $40, $03 ; note C4 dur 3
    db $a0, $06 ; volume $06
    db $c7, $10 ; env $10
    db $40, $05 ; note C4 dur 5
    db $ff, $ff ; end

; sound track, 18 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_71::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $40, $05 ; note C4 dur 5
    db $60, $05 ; note C6 dur 5
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $40, $08 ; note C4 dur 8
    db $a0, $06 ; volume $06
    db $c7, $20 ; env $20
    db $40, $08 ; note C4 dur 8
    db $1f, $02 ; rest-note $1F dur 2
    db $a0, $0f ; volume $0F
    db $c0, $fe ; env $FE
    db $88, $12 ; note G#8 dur 18
    db $50, $05 ; note C5 dur 5
    db $60, $05 ; note C6 dur 5
    db $40, $10 ; note C4 dur 16
    db $c7, $10 ; env $10
    db $30, $20 ; note C3 dur 32
    db $ff, $ff ; end

; sound track, 20 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_72::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $40, $02 ; note C4 dur 2
    db $60, $03 ; note C6 dur 3
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $40, $03 ; note C4 dur 3
    db $a0, $06 ; volume $06
    db $c7, $10 ; env $10
    db $40, $05 ; note C4 dur 5
    db $c0, $fe ; env $FE
    db $20, $07 ; note C2 dur 7
    db $12, $08 ; note D1 dur 8
    db $11, $08 ; note C#1 dur 8
    db $1f, $01 ; rest-note $1F dur 1
    db $a0, $0f ; volume $0F
    db $50, $04 ; note C5 dur 4
    db $60, $10 ; note C6 dur 16
    db $c7, $20 ; env $20
    db $a0, $06 ; volume $06
    db $60, $20 ; note C6 dur 32
    db $ff, $ff ; end

; sound track, 27 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_73::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $3e, $01 ; rest-note $3E dur 1
    db $40, $05 ; note C4 dur 5
    db $60, $03 ; note C6 dur 3
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $a0, $08 ; volume $08
    db $40, $06 ; note C4 dur 6
    db $a0, $05 ; volume $05
    db $c7, $10 ; env $10
    db $40, $0d ; note C4 dur 13
    db $10, $03 ; note C1 dur 3
    db $11, $03 ; note C#1 dur 3
    db $c0, $fe ; env $FE
    db $a0, $0f ; volume $0F
    db $c3, $07 ; env $07
    db $11, $05 ; note C#1 dur 5
    db $25, $05 ; note F2 dur 5
    db $21, $05 ; note C#2 dur 5
    db $23, $05 ; note D#2 dur 5
    db $c0, $fe ; env $FE
    db $23, $05 ; note D#2 dur 5
    db $22, $08 ; note D2 dur 8
    db $22, $07 ; note D2 dur 7
    db $a0, $08 ; volume $08
    db $c7, $40 ; env $40
    db $22, $20 ; note D2 dur 32
    db $ff, $ff ; end

; sound track, 66 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_74::
    db $00, $00, $0f, $14 ; header: param=0 byte1=$00 volume=$0F byte3=$14
    db $1f, $22 ; rest-note $1F dur 34
    db $ae, $10 ; tuning $10
    db $30, $02 ; note C3 dur 2
    db $2b, $03 ; note B2 dur 3
    db $1f, $02 ; rest-note $1F dur 2
    db $28, $03 ; note G#2 dur 3
    db $2b, $03 ; note B2 dur 3
    db $1f, $02 ; rest-note $1F dur 2
    db $2b, $04 ; note B2 dur 4
    db $1f, $02 ; rest-note $1F dur 2
    db $28, $02 ; note G#2 dur 2
    db $1a, $03 ; note A#1 dur 3
    db $2f, $01 ; rest-note $2F dur 1
    db $1a, $03 ; note A#1 dur 3
    db $1f, $02 ; rest-note $1F dur 2
    db $29, $01 ; note A2 dur 1
    db $18, $02 ; note G#1 dur 2
    db $1f, $02 ; rest-note $1F dur 2
    db $27, $01 ; note G2 dur 1
    db $17, $02 ; note G1 dur 2
    db $26, $01 ; note F#2 dur 1
    db $25, $02 ; note F2 dur 2
    db $24, $01 ; note E2 dur 1
    db $23, $02 ; note D#2 dur 2
    db $1f, $01 ; rest-note $1F dur 1
    db $22, $01 ; note D2 dur 1
    db $21, $02 ; note C#2 dur 2
    db $20, $01 ; note C2 dur 1
    db $1b, $01 ; note B1 dur 1
    db $1a, $01 ; note A#1 dur 1
    db $19, $01 ; note A1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $17, $01 ; note G1 dur 1
    db $1f, $01 ; rest-note $1F dur 1
    db $16, $01 ; note F#1 dur 1
    db $15, $01 ; note F1 dur 1
    db $14, $01 ; note E1 dur 1
    db $a0, $08 ; volume $08
    db $1f, $01 ; rest-note $1F dur 1
    db $15, $01 ; note F1 dur 1
    db $17, $01 ; note G1 dur 1
    db $19, $01 ; note A1 dur 1
    db $a0, $06 ; volume $06
    db $1f, $02 ; rest-note $1F dur 2
    db $18, $01 ; note G#1 dur 1
    db $1b, $01 ; note B1 dur 1
    db $17, $01 ; note G1 dur 1
    db $1a, $01 ; note A#1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1b, $02 ; note B1 dur 2
    db $14, $01 ; note E1 dur 1
    db $a0, $04 ; volume $04
    db $1f, $02 ; rest-note $1F dur 2
    db $18, $01 ; note G#1 dur 1
    db $1b, $01 ; note B1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1f, $02 ; rest-note $1F dur 2
    db $1a, $01 ; note A#1 dur 1
    db $18, $01 ; note G#1 dur 1
    db $1f, $02 ; rest-note $1F dur 2
    db $14, $01 ; note E1 dur 1
    db $19, $01 ; note A1 dur 1
    db $1b, $01 ; note B1 dur 1
    db $19, $01 ; note A1 dur 1
    db $1a, $01 ; note A#1 dur 1
    db $ff, $ff ; end

; sound track, 9 events after the header (E-0019: grammar C2, meaning C0)
SoundTrack_42_75::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $40, $02 ; note C4 dur 2
    db $60, $03 ; note C6 dur 3
    db $20, $08 ; note C2 dur 8
    db $11, $02 ; note C#1 dur 2
    db $40, $03 ; note C4 dur 3
    db $a0, $06 ; volume $06
    db $c7, $10 ; env $10
    db $40, $05 ; note C4 dur 5
    db $ff, $ff ; end

SoundTrack_42_76::
    db $00, $00, $0f, $00 ; header: param=0 byte1=$00 volume=$0F byte3=$00
    db $20, $0b ; note C2 dur 11
    db $3e, $02 ; rest-note $3E dur 2
    db $60, $02 ; note C6 dur 2
    db $98, $03 ; note G#9 dur 3
    db $43, $09 ; note D#4 dur 9
    db $c1, $20 ; env $20
    db $a0, $09 ; volume $09
    db $43, $20 ; note D#4 dur 32
    db $ff, $ff ; end
    ds $3c, $00
