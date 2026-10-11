SECTION "Bank 4D", ROMX[$4000], BANK[$4D]
    db $4D

; E-0142 (derived: 144 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map48Attrs0::
Data_04D_4001:: ; heuristic: map screen array; C0
    dfar Data_04D_4997 ; entry 0
    dfar Data_04D_49AB ; entry 1
    dfar Data_04D_49BF ; entry 2
    dfar Data_04D_49D3 ; entry 3
    dfar Data_04D_49E7 ; entry 4
    dfar Data_04D_4A0E ; entry 5
    dfar Data_04D_4A55 ; entry 6
    dfar Data_04D_4A69 ; entry 7
    dfar Data_04D_4A7D ; entry 8
    dfar Data_04D_4A91 ; entry 9
    dfar Data_04D_4AA5 ; entry 10
    dfar Data_04D_4AB9 ; entry 11
    dfar Data_04D_4ACD ; entry 12
    dfar Data_04D_4AE1 ; entry 13
    dfar Data_04D_4AF5 ; entry 14
    dfar Data_04D_4B09 ; entry 15
    dfar Data_04D_4B1D ; entry 16
    dfar Data_04D_4B47 ; entry 17
    dfar Data_04D_4B81 ; entry 18
    dfar Data_04D_4BBD ; entry 19
    dfar Data_04D_4BEA ; entry 20
    dfar Data_04D_4BFE ; entry 21
    dfar Data_04D_4C12 ; entry 22
    dfar Data_04D_4C26 ; entry 23
    dfar Data_04D_4C3A ; entry 24
    dfar Data_04D_4C4E ; entry 25
    dfar Data_04D_4C62 ; entry 26
    dfar Data_04D_4C76 ; entry 27
    dfar Data_04D_4C8A ; entry 28
    dfar Data_04D_4CAC ; entry 29
    dfar Data_04D_4CDC ; entry 30
    dfar Data_04D_4D1B ; entry 31
    dfar Data_04D_4D44 ; entry 32
    dfar Data_04D_4D60 ; entry 33
    dfar Data_04D_4D74 ; entry 34
    dfar Data_04D_4D88 ; entry 35
    dfar Data_04D_4D9C ; entry 36
    dfar Data_04D_4DB0 ; entry 37
    dfar Data_04D_4DC4 ; entry 38
    dfar Data_04D_4DD8 ; entry 39
    dfar Data_04D_4DEC ; entry 40
    dfar Data_04D_4E00 ; entry 41
    dfar Data_04D_4E29 ; entry 42
    dfar Data_04D_4E63 ; entry 43
    dfar Data_04D_4EAC ; entry 44
    dfar Data_04D_4ED0 ; entry 45
    dfar Data_04D_4F06 ; entry 46
    dfar Data_04D_4F28 ; entry 47
    dfar Data_04D_4F3C ; entry 48
    dfar Data_04D_4F50 ; entry 49
    dfar Data_04D_4F64 ; entry 50
    dfar Data_04D_4F78 ; entry 51
    dfar Data_04D_4F8C ; entry 52
    dfar Data_04D_4FA0 ; entry 53
    dfar Data_04D_4FC3 ; entry 54
    dfar Data_04D_4FD7 ; entry 55
    dfar Data_04D_4FED ; entry 56
    dfar Data_04D_5016 ; entry 57
    dfar Data_04D_5076 ; entry 58
    dfar Data_04D_50FE ; entry 59
    dfar Data_04D_5124 ; entry 60
    dfar Data_04D_5138 ; entry 61
    dfar Data_04D_514C ; entry 62
    dfar Data_04D_5160 ; entry 63
    dfar Data_04D_5174 ; entry 64
    dfar Data_04D_5196 ; entry 65
    dfar Data_04D_51C1 ; entry 66
    dfar Data_04D_5213 ; entry 67
    dfar Data_04D_5261 ; entry 68
    dfar Data_04D_52CF ; entry 69
    dfar Data_04D_5325 ; entry 70
    dfar Data_04D_5375 ; entry 71
    dfar Data_04D_53AA ; entry 72
    dfar Data_04D_53BE ; entry 73
    dfar Data_04D_53E8 ; entry 74
    dfar Data_04D_541F ; entry 75
    dfar Data_04D_5441 ; entry 76
    dfar Data_04D_545A ; entry 77
    dfar Data_04D_547A ; entry 78
    dfar Data_04D_54A9 ; entry 79
    dfar Data_04D_54CF ; entry 80
    dfar Data_04D_54F5 ; entry 81
    dfar Data_04D_5571 ; entry 82
    dfar Data_04D_55BA ; entry 83
    dfar Data_04D_55E4 ; entry 84
    dfar Data_04D_55F8 ; entry 85
    dfar Data_04D_5627 ; entry 86
    dfar Data_04D_565F ; entry 87
    dfar Data_04D_569F ; entry 88
    dfar Data_04D_56C9 ; entry 89
    dfar Data_04D_570A ; entry 90
    dfar Data_04D_574E ; entry 91
    dfar Data_04D_5774 ; entry 92
    dfar Data_04D_57CA ; entry 93
    dfar Data_04D_5846 ; entry 94
    dfar Data_04D_5879 ; entry 95
    dfar Data_04D_588D ; entry 96
    dfar Data_04D_58A1 ; entry 97
    dfar Data_04D_58B5 ; entry 98
    dfar Data_04D_58DA ; entry 99
    dfar Data_04D_5909 ; entry 100
    dfar Data_04D_593B ; entry 101
    dfar Data_04D_5961 ; entry 102
    dfar Data_04D_5987 ; entry 103
    dfar Data_04D_59D1 ; entry 104
    dfar Data_04D_5A19 ; entry 105
    dfar Data_04D_5A52 ; entry 106
    dfar Data_04D_5A66 ; entry 107
    dfar Data_04D_5A7A ; entry 108
    dfar Data_04D_5A8E ; entry 109
    dfar Data_04D_5ABC ; entry 110
    dfar Data_04D_5B08 ; entry 111
    dfar Data_04D_5B4B ; entry 112
    dfar Data_04D_5B9A ; entry 113
    dfar Data_04D_5BC4 ; entry 114
    dfar Data_04D_5BFD ; entry 115
    dfar Data_04D_5C4C ; entry 116
    dfar Data_04D_5C87 ; entry 117
    dfar Data_04D_5CD5 ; entry 118
    dfar Data_04D_5D0A ; entry 119
    dfar Data_04D_5D1E ; entry 120
    dfar Data_04D_5D4B ; entry 121
    dfar Data_04D_5D9A ; entry 122
    dfar Data_04D_5DD9 ; entry 123
    dfar Data_04D_5E1B ; entry 124
    dfar Data_04D_5E59 ; entry 125
    dfar Data_04D_5E6D ; entry 126
    dfar Data_04D_5E96 ; entry 127
    dfar Data_04D_5EBE ; entry 128
    dfar Data_04D_5F01 ; entry 129
    dfar Data_04D_5F39 ; entry 130
    dfar Data_04D_5F7C ; entry 131
    dfar Data_04D_5F98 ; entry 132
    dfar Data_04D_5FD1 ; entry 133
    dfar Data_04D_6020 ; entry 134
    dfar Data_04D_605A ; entry 135
    dfar Data_04D_606E ; entry 136
    dfar Data_04D_6082 ; entry 137
    dfar Data_04D_6096 ; entry 138
    dfar Data_04D_60AA ; entry 139
    dfar Data_04D_60BE ; entry 140
    dfar Data_04D_60D2 ; entry 141
    dfar Data_04D_60F4 ; entry 142
    dfar Data_04D_6116 ; entry 143

; E-0142 (derived: 144 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map48Attrs2::
Data_04D_41B1:: ; heuristic: map screen array; C0
    dfar Data_04D_4997 ; entry 0
    dfar Data_04D_49AB ; entry 1
    dfar Data_04D_49BF ; entry 2
    dfar Data_04D_49D3 ; entry 3
    dfar Data_04D_49E7 ; entry 4
    dfar Data_04D_4A0E ; entry 5
    dfar Data_04D_4A55 ; entry 6
    dfar Data_04D_4A69 ; entry 7
    dfar Data_04D_4A7D ; entry 8
    dfar Data_04D_4A91 ; entry 9
    dfar Data_04D_4AA5 ; entry 10
    dfar Data_04D_4AB9 ; entry 11
    dfar Data_04D_4ACD ; entry 12
    dfar Data_04D_4AE1 ; entry 13
    dfar Data_04D_4AF5 ; entry 14
    dfar Data_04D_4B09 ; entry 15
    dfar Data_04D_4B1D ; entry 16
    dfar Data_04D_4B47 ; entry 17
    dfar Data_04D_4B81 ; entry 18
    dfar Data_04D_4BBD ; entry 19
    dfar Data_04D_4BEA ; entry 20
    dfar Data_04D_4BFE ; entry 21
    dfar Data_04D_4C12 ; entry 22
    dfar Data_04D_4C26 ; entry 23
    dfar Data_04D_4C3A ; entry 24
    dfar Data_04D_4C4E ; entry 25
    dfar Data_04D_4C62 ; entry 26
    dfar Data_04D_4C76 ; entry 27
    dfar Data_04D_4C8A ; entry 28
    dfar Data_04D_4CAC ; entry 29
    dfar Data_04D_4CDC ; entry 30
    dfar Data_04D_4D1B ; entry 31
    dfar Data_04D_4D44 ; entry 32
    dfar Data_04D_4D60 ; entry 33
    dfar Data_04D_4D74 ; entry 34
    dfar Data_04D_4D88 ; entry 35
    dfar Data_04D_4D9C ; entry 36
    dfar Data_04D_4DB0 ; entry 37
    dfar Data_04D_4DC4 ; entry 38
    dfar Data_04D_4DD8 ; entry 39
    dfar Data_04D_4DEC ; entry 40
    dfar Data_04D_4E00 ; entry 41
    dfar Data_04D_4E29 ; entry 42
    dfar Data_04D_4E63 ; entry 43
    dfar Data_04D_4EAC ; entry 44
    dfar Data_04D_4ED0 ; entry 45
    dfar Data_04D_4F06 ; entry 46
    dfar Data_04D_4F28 ; entry 47
    dfar Data_04D_4F3C ; entry 48
    dfar Data_04D_4F50 ; entry 49
    dfar Data_04D_4F64 ; entry 50
    dfar Data_04D_4F78 ; entry 51
    dfar Data_04D_4F8C ; entry 52
    dfar Data_04D_4FA0 ; entry 53
    dfar Data_04D_4FC3 ; entry 54
    dfar Data_04D_4FD7 ; entry 55
    dfar Data_04D_4FED ; entry 56
    dfar Data_04D_5046 ; entry 57
    dfar Data_04D_50BA ; entry 58
    dfar Data_04D_50FE ; entry 59
    dfar Data_04D_5124 ; entry 60
    dfar Data_04D_5138 ; entry 61
    dfar Data_04D_514C ; entry 62
    dfar Data_04D_5160 ; entry 63
    dfar Data_04D_5174 ; entry 64
    dfar Data_04D_5196 ; entry 65
    dfar Data_04D_51EA ; entry 66
    dfar Data_04D_523A ; entry 67
    dfar Data_04D_5298 ; entry 68
    dfar Data_04D_52FA ; entry 69
    dfar Data_04D_5325 ; entry 70
    dfar Data_04D_5375 ; entry 71
    dfar Data_04D_53AA ; entry 72
    dfar Data_04D_53BE ; entry 73
    dfar Data_04D_53E8 ; entry 74
    dfar Data_04D_541F ; entry 75
    dfar Data_04D_5441 ; entry 76
    dfar Data_04D_545A ; entry 77
    dfar Data_04D_547A ; entry 78
    dfar Data_04D_54BC ; entry 79
    dfar Data_04D_54E2 ; entry 80
    dfar Data_04D_5533 ; entry 81
    dfar Data_04D_5571 ; entry 82
    dfar Data_04D_55BA ; entry 83
    dfar Data_04D_55E4 ; entry 84
    dfar Data_04D_55F8 ; entry 85
    dfar Data_04D_5627 ; entry 86
    dfar Data_04D_565F ; entry 87
    dfar Data_04D_569F ; entry 88
    dfar Data_04D_56C9 ; entry 89
    dfar Data_04D_570A ; entry 90
    dfar Data_04D_5761 ; entry 91
    dfar Data_04D_579F ; entry 92
    dfar Data_04D_5808 ; entry 93
    dfar Data_04D_5846 ; entry 94
    dfar Data_04D_5879 ; entry 95
    dfar Data_04D_588D ; entry 96
    dfar Data_04D_58A1 ; entry 97
    dfar Data_04D_58B5 ; entry 98
    dfar Data_04D_58DA ; entry 99
    dfar Data_04D_5909 ; entry 100
    dfar Data_04D_594E ; entry 101
    dfar Data_04D_5974 ; entry 102
    dfar Data_04D_59AC ; entry 103
    dfar Data_04D_59F5 ; entry 104
    dfar Data_04D_5A19 ; entry 105
    dfar Data_04D_5A52 ; entry 106
    dfar Data_04D_5A66 ; entry 107
    dfar Data_04D_5A7A ; entry 108
    dfar Data_04D_5A8E ; entry 109
    dfar Data_04D_5ABC ; entry 110
    dfar Data_04D_5B08 ; entry 111
    dfar Data_04D_5B4B ; entry 112
    dfar Data_04D_5B9A ; entry 113
    dfar Data_04D_5BC4 ; entry 114
    dfar Data_04D_5BFD ; entry 115
    dfar Data_04D_5C4C ; entry 116
    dfar Data_04D_5C87 ; entry 117
    dfar Data_04D_5CD5 ; entry 118
    dfar Data_04D_5D0A ; entry 119
    dfar Data_04D_5D1E ; entry 120
    dfar Data_04D_5D4B ; entry 121
    dfar Data_04D_5D9A ; entry 122
    dfar Data_04D_5DD9 ; entry 123
    dfar Data_04D_5E1B ; entry 124
    dfar Data_04D_5E59 ; entry 125
    dfar Data_04D_5E6D ; entry 126
    dfar Data_04D_5E96 ; entry 127
    dfar Data_04D_5EBE ; entry 128
    dfar Data_04D_5F01 ; entry 129
    dfar Data_04D_5F39 ; entry 130
    dfar Data_04D_5F7C ; entry 131
    dfar Data_04D_5F98 ; entry 132
    dfar Data_04D_5FD1 ; entry 133
    dfar Data_04D_6020 ; entry 134
    dfar Data_04D_605A ; entry 135
    dfar Data_04D_606E ; entry 136
    dfar Data_04D_6082 ; entry 137
    dfar Data_04D_6096 ; entry 138
    dfar Data_04D_60AA ; entry 139
    dfar Data_04D_60BE ; entry 140
    dfar Data_04D_60D2 ; entry 141
    dfar Data_04D_60F4 ; entry 142
    dfar Data_04D_6116 ; entry 143

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4361:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $134361, $5A

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_43BB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1343BB, $5F

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_441A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $13441A, $AF

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_44C9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $00, $44, $45, $00, $00, $0E, $54, $55, $00, $14, $0E, $00, $00, $0F
    db $15, $42, $43, $42, $43, $00, $00, $04, $2A, $2B, $00, $00, $02, $52, $53, $52
    db $53, $00, $14, $04, $3A, $3B
    dw Data_04D_4A00
    db $06
    dw Data_04D_5000
    db $02
    dw Data_04D_5C00
    db $00
    dw Data_04D_5C00
    db $02
    dw Data_04D_6400
    db $00
    dw Data_04D_6400
    db $02
    dw Data_04D_7000
    db $00
    dw Data_04D_7000
    db $02
    dw Data_04D_7800
    db $04, $00, $52, $06, $00, $8A, $06, $00, $66, $06, $54, $55, $2A, $2B, $00, $A0
    db $0E, $3A, $3B, $00, $B4, $0E, $2A, $2B, $00, $C8, $0E, $3A, $3B, $00, $DC, $0E
    db $00, $F0, $00, $00, $C8, $06, $00, $FE, $06, $00, $DC, $06, $00, $12, $18, $00
    db $1C, $1A, $00, $2C, $12, $00, $30, $1A

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4541:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $134541, $77

; LZSS-compressed asset: 117 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_45B8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1345B8, $75

; LZSS-compressed asset: 103 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_462D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $13462D, $67

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4694:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $134694, $95

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4729:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $134729, $5F

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4788:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_47A5:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_47C2:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_47DF:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_47FC:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4819:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4836:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $134836, $57

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_488D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13488D, $78

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4905:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $134905, $92

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4997:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_49AB:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_49BF:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_49D3:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_49E7:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $78, $0F, $04
    db $01, $01, $01, $01, $00, $C8, $0F, $0F, $00

Data_04D_4A00:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $00, $00, $EE, $0F, $0F, $00, $D8, $0F, $13, $00, $D6, $0F, $0B

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4A0E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $134A0E, $47

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4A55:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4A69:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4A7D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4A91:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4AA5:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4AB9:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4ACD:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4AE1:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4AF5:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4B09:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4B1D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $07, $01, $01, $00, $00, $08, $00, $06, $0F, $31
    db $00, $0C, $0E, $00, $5C, $0F, $29, $00, $5A, $0F, $1B, $00, $0C, $0C, $00, $D6
    db $0F, $01, $00, $5A, $0F, $3F, $00, $5C, $0F, $05

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4B47:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $07, $01, $01, $01, $01, $00, $00, $08, $00, $08
    db $0F, $05, $00, $0A, $00, $00, $24, $0F, $13, $00, $34, $0F, $19, $00, $76, $0F
    db $2B, $00, $22, $0F, $17, $00, $0E, $0F, $13, $00, $0C, $00, $00, $0E, $0C, $00
    db $18, $1F, $07, $00, $0E, $0A, $00, $40, $1F, $01

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4B81:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4A, $01, $01, $00, $4C, $0F, $09, $01, $01
    db $00, $5E, $02, $00, $7C, $00, $00, $7C, $08, $00, $80, $0A, $00, $84, $04, $00
    db $86, $06, $00, $A0, $0F, $03, $00, $80, $0C, $00, $C6, $0F, $09, $00, $7A, $06
    db $00, $EC, $0F, $0D, $00, $F6, $0F, $17, $00, $F8, $0F, $0B

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4BBD:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $40, $01, $01, $01, $01, $00, $44, $0F, $0D
    db $00, $54, $00, $00, $78, $02, $00, $6E, $0F, $0B, $00, $74, $0F, $1D, $00, $50
    db $02, $00, $C2, $0F, $13, $00, $D2, $0F, $19, $00, $00, $0F, $2D

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4BEA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4BFE:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4C12:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4C26:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4C3A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4C4E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4C62:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4C76:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4C8A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0B, $01, $01, $01, $01, $00, $00, $0F, $11, $00
    db $0E, $00, $00, $28, $0F, $13, $00, $61, $0F, $4D, $00, $C1, $0F, $4D, $00, $08
    db $1F, $33

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4CAC:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $03, $03, $00, $08, $07, $00, $00, $0F, $29, $00
    db $26, $0F, $19, $00, $12, $04, $00, $70, $0F, $0F, $00, $7C, $0F, $1F, $00, $06
    db $0F, $17, $00, $06, $08, $00, $FA, $0F, $01, $00, $12, $0F, $2B, $00, $00, $04

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4CDC:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $01, $01, $01, $00, $00, $06, $00, $04
    db $0F, $07, $00, $08, $0F, $17, $00, $0A, $0F, $3F, $00, $08, $00, $00, $9E, $0F
    db $05, $00, $0A, $08, $00, $0A, $00, $00, $0C, $00, $00, $CA, $0E, $00, $EA, $04
    db $00, $E2, $0F, $01, $00, $E2, $0F, $0B, $00, $E8, $08, $00, $22, $1F, $1F

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4D1B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $68, $03, $01
    db $00, $C8, $01, $00, $BA, $0F, $15, $00, $CA, $0A, $00, $F0, $0F, $01, $00, $EC
    db $08, $00, $10, $1F, $0D, $00, $C6, $0F, $11

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4D44:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $48, $0F, $34, $02, $02, $02, $02
    db $00, $98, $0F, $11, $00, $CF, $0F, $4D, $00, $08, $1F, $25

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4D60:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4D74:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4D88:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4D9C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4DB0:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4DC4:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4DD8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4DEC:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4E00:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $07, $01, $00, $0C, $03, $00, $00, $0F, $0B, $00
    db $0C, $04, $00, $26, $0F, $35, $00, $0A, $0F, $15, $00, $06, $06, $00, $A0, $0F
    db $11, $00, $D7, $0F, $4D, $00, $08, $1F, $1D

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4E29:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $0B, $00
    db $08, $02, $00, $28, $08, $00, $30, $0F, $05, $00, $4C, $0F, $11, $00, $12, $02
    db $00, $26, $0C, $00, $82, $0A, $00, $0A, $06, $00, $10, $06, $00, $A4, $0C, $00
    db $A4, $0A, $00, $D5, $0F, $4D, $00, $08, $1F, $1F

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4E63:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $134E63, $49

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4EAC:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $68, $03, $01
    db $01, $00, $B6, $0F, $15, $00, $C8, $0E, $00, $F0, $0F, $01, $00, $C6, $0F, $17
    db $00, $68, $0F, $13

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4ED0:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $1C, $01, $01, $00, $1E, $0F, $11, $01, $01
    db $00, $44, $0F, $11, $00, $56, $00, $00, $56, $0C, $00, $7C, $0F, $09, $00, $56
    db $08, $00, $A4, $0F, $01, $00, $7A, $08, $00, $AE, $0E, $00, $2E, $0C, $00, $30
    db $0F, $13, $00, $10, $1F, $35

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4F06:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $94, $0F, $20
    db $01, $01, $00, $E2, $0F, $13, $00, $F2, $0F, $17, $01, $01, $00, $F4, $0E, $00
    db $46, $1A

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4F28:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4F3C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4F50:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4F64:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4F78:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4F8C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 35 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4FA0:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $48, $0F, $34, $01, $01, $01, $01
    db $00, $98, $0F, $0F, $00, $A8, $0F, $39, $00, $A6, $00, $00, $96, $0F, $01, $00
    db $48, $0F, $23

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4FC3:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 22 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4FD7:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $5C, $0F, $48, $01, $01, $00, $5C
    db $0F, $4D, $00, $08, $1F, $37

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_4FED:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $16, $01, $01, $00, $18, $0F, $15, $00, $2A
    db $0E, $00, $52

Data_04D_5000:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $01, $00, $50, $0F, $19, $00, $7A, $0F, $1D, $00, $18, $0F, $11, $00, $52
    db $0F, $13, $00, $52, $0F, $35

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5016:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $0F, $4D, $01, $28, $0F, $14, $01, $FC, $FF, $01
    db $01, $FC, $FE, $01, $FA, $FF, $01, $01, $FA, $FE, $01, $F8, $FF, $01, $01, $F8
    db $FE, $01, $F6, $FF, $01, $01, $F6, $FE, $01, $F4, $FF, $01, $01, $20, $1F, $21

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5046:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $0F, $4D, $01, $28, $0F, $14, $01, $FC, $FF, $01
    db $01, $FC, $FE, $01, $FA, $FF, $01, $01, $FA, $FE, $01, $F8, $FF, $01, $01, $F8
    db $FE, $01, $F6, $FF, $01, $01, $F6, $FE, $01, $F4, $FF, $01, $01, $20, $1F, $21

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5076:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135076, $44

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_50BA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1350BA, $44

; LZSS-compressed asset: 38 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_50FE:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $40, $0F, $2C, $01, $01, $00, $8E
    db $0F, $3D, $00, $A0, $08, $00, $F0, $02, $00, $F0, $0F, $2D, $00, $A0, $04, $00
    db $40, $14, $00, $40, $1F, $01

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5124:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5138:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_514C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5160:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5174:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4C, $01, $01, $01, $01, $00, $50, $0F, $4D
    db $00, $74, $0F, $01, $00, $72, $00, $00, $C8, $0F, $13, $00, $01, $1F, $4D, $00
    db $08, $12

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5196:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $16, $01, $01, $01, $01, $00, $1A, $0F, $0F
    db $00, $2A, $00, $00, $40, $0F, $15, $00, $1A, $0F, $23, $00, $28, $0F, $05, $00
    db $18, $0F, $01, $00, $00, $0F, $17, $00, $07, $1F, $4D

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_51C1:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $0F, $4D, $01, $4E, $0F, $3A, $01, $FE, $FF, $01
    db $01, $FE, $FE, $01, $FA, $FF, $01, $01, $FA, $FE, $01, $F6, $FF, $01, $01, $F6
    db $FE, $01, $F4, $FF, $01, $01, $20, $1F, $21

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_51EA:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $0F, $4D, $01, $4E, $0F, $3A, $01, $FE, $FF, $01
    db $01, $FE, $FE, $01, $FA, $FF, $01, $01, $FA, $FE, $01, $F6, $FF, $01, $01, $F6
    db $FE, $01, $F4, $FF, $01, $01, $20, $1F, $21

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5213:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $0F, $4D, $01, $48, $0F, $34, $04, $04, $04, $04
    db $03, $03, $01, $FE, $FA, $01, $A8, $0E, $01, $F4, $FF, $01, $01, $F4, $FA, $01
    db $A0, $FF, $4D, $01, $4F, $1F, $05

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_523A:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $0F, $4D, $01, $48, $0F, $34, $04, $04, $04, $04
    db $03, $03, $01, $FE, $FA, $01, $A8, $0E, $01, $F4, $FF, $01, $01, $F4, $FA, $01
    db $A0, $FF, $4D, $01, $4F, $1F, $05

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5261:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $03, $02, $00, $05, $01, $01, $01, $01, $02, $00, $06, $02, $04
    db $0F, $0B, $02, $0C, $0C, $02, $32, $0F, $29, $02, $30, $0F, $1D, $02, $0C, $0A
    db $02, $AC, $08, $02, $FC, $F6, $02, $FA, $F6, $02, $CC, $0C, $02, $F6, $F8, $02
    db $EE, $FF, $01, $02, $A0, $FF, $45

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5298:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $03, $02, $00, $05, $01, $01, $01, $01, $02, $00, $06, $02, $04
    db $0F, $0B, $02, $0C, $0C, $02, $32, $0F, $29, $02, $30, $0F, $1D, $02, $0C, $0A
    db $02, $AC, $08, $02, $FC, $F6, $02, $FA, $F6, $02, $CC, $0C, $02, $F6, $F8, $02
    db $EE, $FF, $01, $02, $A0, $FF, $45

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_52CF:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $03, $02, $00, $03, $02, $F4, $FF, $3B, $02, $F2, $FF, $01, $02
    db $56, $0F, $23, $01, $01, $02, $54, $0C, $02, $9E, $0F, $03, $02, $C7, $0F, $4D
    db $02, $52, $0E, $02, $26, $1F, $01, $02, $50, $0F, $07

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_52FA:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $03, $02, $00, $03, $02, $F4, $FF, $3B, $02, $F2, $FF, $01, $02
    db $56, $0F, $23, $01, $01, $02, $54, $0C, $02, $9E, $0F, $03, $02, $C7, $0F, $4D
    db $02, $52, $0E, $02, $26, $1F, $01, $02, $50, $0F, $07

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5325:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135325, $50

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5375:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $01, $03, $00, $06, $01, $00, $00, $04, $00, $00
    db $0F, $07, $00, $24, $0F, $17, $00, $04, $02, $00, $58, $04, $00, $52, $0F, $03
    db $00, $06, $02, $00, $7C, $06, $00, $78, $0F, $01, $00, $9F, $0F, $4D, $00, $FF
    db $0F, $4D, $00, $7C, $04

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_53AA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_53BE:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $4E, $0F, $3A, $01, $00, $AE, $01
    db $00, $A0, $0F, $09, $00, $AE, $06, $00, $C6, $0F, $09, $00, $AE, $0F, $0F, $00
    db $AA, $06, $00, $0E, $1F, $15, $00, $A0, $0F, $0B

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_53E8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $1A, $0F, $06, $01, $01, $01, $01
    db $00, $6A, $0F, $0F, $00, $7A, $00, $00, $7A, $02, $00, $A0, $0F, $13, $00, $C8
    db $0F, $0D, $00, $C6, $0A, $00, $76, $02, $00, $F0, $0F, $03, $00, $9E, $08, $00
    db $96, $0F, $01, $00, $6E, $0F, $1B

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_541F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $68, $03, $01
    db $01, $01, $01, $00, $B8, $0F, $15, $00, $C8, $0C, $00, $F0, $0F, $01, $00, $EE
    db $0F, $3D

; LZSS-compressed asset: 25 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5441:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $5C, $0F, $48, $01, $01, $00, $BA
    db $02, $00, $C3, $0F, $4D, $00, $08, $1F, $31

; LZSS-compressed asset: 32 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_545A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $98, $0F, $24
    db $01, $01, $00, $E6, $0F, $11, $01, $01, $00, $0C, $1F, $13, $00, $1C, $1F, $0F

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_547A:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $03, $02, $00, $03, $02, $F4, $FF, $4D, $02, $40, $0F, $29, $01
    db $01, $02, $40, $0A, $02, $A0, $0F, $0B, $02, $42, $06, $02, $C8, $0F, $07, $02
    db $A4, $00, $02, $96, $0C, $02, $F6, $0E, $02, $A2, $02, $02, $0E, $1F, $33

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_54A9:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_54BC:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_54CF:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_54E2:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_54F5:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $FA, $03, $02, $0E, $01, $02, $00, $0F, $35, $02, $0E
    db $02, $02, $4E, $0F, $35, $02, $0E, $02, $01, $01, $01, $01, $02, $A0, $0F, $0F
    db $02, $B0, $00, $02, $C6, $0F, $0D, $02, $0C, $00, $02, $B0, $00, $02, $4E, $0C
    db $02, $FE, $0E, $02, $FE, $02, $02, $16, $1F, $0F, $02, $5C, $0F, $09

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5533:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $FA, $03, $02, $0E, $01, $02, $00, $0F, $35, $02, $0E
    db $02, $02, $4E, $0F, $35, $02, $0E, $02, $01, $01, $01, $01, $02, $A0, $0F, $0F
    db $02, $B0, $00, $02, $C6, $0F, $0D, $02, $0C, $00, $02, $B0, $00, $02, $4E, $0C
    db $02, $FE, $0E, $02, $FE, $02, $02, $16, $1F, $0F, $02, $5C, $0F, $09

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5571:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135571, $49

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_55BA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $3C, $01, $00, $50, $01, $00, $42, $0F, $15
    db $00, $52, $0A, $00, $78, $0F, $03, $00, $4E, $0E, $00, $A0, $0F, $03, $00, $7A
    db $0F, $15, $00, $52, $0F, $13, $00, $00, $0F, $3D

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_55E4:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_55F8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $03, $03, $03, $01, $00, $04, $01, $00, $00, $00, $00, $0A
    db $06, $00, $04, $0F, $2F, $00, $08, $0A, $00, $54, $0F, $01, $00, $2A, $0F, $47
    db $00, $06, $0A, $00, $D0, $0F, $01, $00, $50, $0F, $1B, $00, $18, $1F, $2F

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5627:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $01, $01, $01, $01, $01, $00, $00, $02, $00, $0A
    db $06, $00, $06, $0E, $00, $06, $0F, $13, $00, $3E, $0F, $4D, $00, $14, $0F, $09
    db $00, $06, $0C, $00, $CA, $0E, $00, $06, $02, $00, $E2, $0F, $0F, $00, $C4, $08
    db $00, $10, $1F, $0F, $00, $04, $0F, $0F

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_565F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $03, $03, $03, $01, $00, $04, $03, $00, $00, $00, $00, $0C
    db $04, $00, $04, $0F, $01, $00, $02, $0F, $17, $00, $0A, $02, $00, $08, $0A, $00
    db $56, $0F, $01, $00, $00, $06, $00, $74, $0F, $0D, $00, $04, $04, $00, $5E, $0A
    db $00, $AA, $0F, $27, $00, $2C, $0F, $19, $00, $06, $0F, $11, $00, $04, $0F, $0D

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_569F:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $0F, $4D, $01, $46, $0F, $32, $01, $FE, $FF, $01
    db $01, $FE, $FE, $01, $F8, $F8, $01, $D0, $08, $01, $D0, $0C, $01, $CA, $06, $01
    db $FA, $F8, $01, $F2, $FF, $03, $01, $0C, $1F, $35

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_56C9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1356C9, $41

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_570A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13570A, $44

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_574E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5761:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5774:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $FF, $43, $03, $02, $56, $01, $02, $48, $0F, $0D, $02
    db $56, $02, $02, $58, $0A, $02, $7C, $0F, $05, $01, $01, $02, $96, $0F, $13, $02
    db $80, $0F, $11, $02, $54, $0F, $15, $02, $1B, $1F, $39

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_579F:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $FF, $43, $03, $02, $56, $01, $02, $48, $0F, $0D, $02
    db $56, $02, $02, $58, $0A, $02, $7C, $0F, $05, $01, $01, $02, $96, $0F, $13, $02
    db $80, $0F, $11, $02, $54, $0F, $15, $02, $1B, $1F, $39

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_57CA:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $F8, $03, $02, $0C, $03, $02, $00, $0F, $33, $02, $0C
    db $04, $02, $4E, $0F, $33, $02, $5A, $06, $01, $01, $02, $A0, $0F, $11, $01, $01
    db $02, $C6, $0F, $09, $02, $D0, $08, $02, $EE, $0F, $09, $02, $0A, $02, $02, $D8
    db $00, $02, $9C, $0C, $02, $24, $1F, $03, $02, $9A, $0E, $02, $4C, $14

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5808:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $F8, $03, $02, $0C, $03, $02, $00, $0F, $33, $02, $0C
    db $04, $02, $4E, $0F, $33, $02, $5A, $06, $01, $01, $02, $A0, $0F, $11, $01, $01
    db $02, $C6, $0F, $09, $02, $D0, $08, $02, $EE, $0F, $09, $02, $0A, $02, $02, $D8
    db $00, $02, $9C, $0C, $02, $24, $1F, $03, $02, $9A, $0E, $02, $4C, $14

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5846:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $01, $00, $00, $06, $00, $06
    db $0F, $2B, $00, $0A, $0F, $11, $00, $0A, $02, $00, $6E, $0F, $0B, $00, $7C, $06
    db $00, $0E, $06, $00, $A0, $0F, $0B, $00, $72, $0F, $11, $00, $10, $0F, $0F, $00
    db $0A, $1F, $3D

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5879:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_588D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_58A1:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_58B5:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $4D, $00, $0E, $0F, $27, $00, $1E, $0C, $00, $AA, $0F, $01, $00, $80, $0F
    db $3F, $00, $FC, $0F, $31

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_58DA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $03, $01, $00, $08, $03, $00, $00, $04, $00, $04
    db $0F, $03, $00, $08, $0F, $19, $00, $10, $08, $00, $52, $0F, $05, $00, $5A, $0A
    db $00, $78, $0F, $05, $00, $A3, $0F, $4D, $00, $03, $1F, $4D, $00, $00, $00

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5909:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $03, $02, $00, $03, $02, $F4, $FF, $3D, $02, $06, $08, $02, $50
    db $0F, $0B, $02, $06, $06, $02, $78, $0F, $09, $04, $04, $04, $04, $02, $98, $0F
    db $11, $02, $80, $0F, $15, $02, $58, $0F, $13, $01, $01, $02, $F4, $FE, $02, $1E
    db $1F, $23

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_593B:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_594E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5961:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5974:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5987:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $5F, $0F, $4D, $02, $78, $0F, $05, $01
    db $01, $01, $01, $02, $C8, $0F, $0F, $02, $D8, $00, $02, $EE, $0F, $0F, $02, $FE
    db $02, $02, $16, $1F, $2B

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_59AC:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $5F, $0F, $4D, $02, $78, $0F, $05, $01
    db $01, $01, $01, $02, $C8, $0F, $0F, $02, $D8, $00, $02, $EE, $0F, $0F, $02, $FE
    db $02, $02, $16, $1F, $2B

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_59D1:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $5F, $0F, $4D, $02, $68, $04, $01, $01
    db $01, $01, $02, $B8, $0F, $15, $02, $CA, $0C, $02, $F0, $0F, $07, $02, $C8, $0A
    db $02, $18, $1F, $29

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_59F5:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $5F, $0F, $4D, $02, $68, $04, $01, $01
    db $01, $01, $02, $B8, $0F, $15, $02, $CA, $0C, $02, $F0, $0F, $07, $02, $C8, $0A
    db $02, $18, $1F, $29

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5A19:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $F4, $03, $03, $03, $03, $01, $01, $02, $08, $00, $03
    db $03, $02, $00, $0F, $0B, $01, $02, $32, $01, $02, $24, $0F, $0D, $00, $00, $02
    db $46, $0F, $19, $02, $0E, $0A, $02, $80, $0F, $29, $02, $82, $06, $02, $C6, $0F
    db $37, $02, $C0, $0F, $01, $02, $24, $1F, $1D

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5A52:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5A66:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5A7A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5A8E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $72, $0D, $01
    db $00, $D2, $01, $00, $C4, $0F, $0D, $00, $D2, $02, $00, $D4, $0A, $00, $F8, $0E
    db $00, $F8, $0F, $13, $00, $F6, $06, $00, $EC, $0F, $01, $00, $72, $02

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5ABC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135ABC, $4C

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5B08:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135B08, $43

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5B4B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135B4B, $4F

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5B9A:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $43, $03, $03, $01, $44, $0F, $11, $03, $01, $7C
    db $03, $01, $70, $0F, $09, $01, $7C, $04, $01, $7E, $04, $01, $A0, $0A, $01, $AA
    db $0F, $05, $01, $D5, $0F, $4D, $01, $08, $1F, $1F

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5BC4:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $FF, $47, $03, $02, $5A, $05, $02, $50, $0F, $05, $02
    db $5A, $06, $01, $02, $86, $01, $02, $78, $0F, $01, $02, $5A, $06, $02, $84, $04
    db $02, $9E, $0F, $0D, $02, $9C, $0C, $02, $CE, $0F, $03, $02, $D2, $0F, $13, $02
    db $F6, $0F, $19, $02, $D6, $0C, $02, $46, $1A

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5BFD:: ; heuristic: map screen stream; C0
    db $68, $01, $02

Data_04D_5C00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $135C00, $4C

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5C4C:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $37, $03, $03, $02, $04, $0A
    db $02, $50, $0F, $05, $02, $52, $04, $02, $FC, $FA, $02, $7E, $0F, $03, $02, $54
    db $04, $02, $9C, $0F, $0B, $02, $A2, $0F, $13, $02, $84, $0F, $11, $02, $F6, $FC
    db $02, $54, $00, $02, $18, $1F, $11, $02, $06, $0F, $05

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5C87:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135C87, $4E

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5CD5:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $40, $0F, $2C, $01, $01, $01, $01
    db $00, $90, $0F, $15, $00, $A2, $04, $00, $CC, $06, $00, $CA, $0F, $05, $00, $A2
    db $02, $00, $F4, $08, $00, $F4, $0F, $07, $00, $F2, $0A, $00, $1C, $1F, $05, $00
    db $F0, $0C, $00, $44, $1C

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5D0A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5D1E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $26, $0F, $12, $01, $00, $86, $01
    db $00, $78, $0F, $0B, $00, $86, $02, $00, $9C, $0F, $0D, $00, $AA, $0F, $13, $00
    db $A8, $06, $00, $7A, $0E, $00, $EC, $0F, $1F, $00, $A8, $0F, $11

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5D4B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135D4B, $4F

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5D9A:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $03, $02, $00, $05, $02, $FC, $FA, $02, $04, $0F, $2D, $02, $FC
    db $F6, $01, $01, $02, $50, $0F, $0B, $02, $5C, $04, $02, $76, $0F, $09, $02, $FC
    db $F4, $02, $88, $00, $02, $9E, $0F, $07, $02, $A6, $0F, $11, $02, $FA, $F6, $02
    db $9C, $0A, $02, $F4, $0C, $02, $00, $04, $02, $0E, $1E, $02, $0C, $1F, $23

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5DD9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135DD9, $42

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5E1B:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $05, $01, $FA, $FC, $01, $06, $0F, $05, $05, $05
    db $05, $05, $01, $10, $0A, $01, $30, $08, $01, $FA, $F6, $01, $FC, $F6, $01, $50
    db $0F, $07, $01, $F8, $FA, $01, $F2, $FF, $0B, $01, $0E, $0A, $01, $A4, $0F, $01
    db $01, $58, $08, $01, $C4, $0F, $0B, $01, $F5, $0F, $4D, $01, $08, $1E

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5E59:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5E6D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $03, $01, $01, $00, $00, $04, $00, $0A, $06, $00
    db $08, $0F, $03, $00, $08, $0E, $00, $30, $0E, $00, $30, $0F, $13, $00, $2E, $0F
    db $4D, $00, $8E, $0F, $2B, $00, $0A, $1F, $3B

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5E96:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $03, $01, $F4, $FF, $3D, $01, $06, $08, $01, $50
    db $0F, $0B, $01, $06, $06, $01, $78, $0F, $0D, $01, $04, $04, $01, $A0, $0F, $11
    db $01, $D7, $0F, $4D, $01, $08, $1F, $1D

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5EBE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135EBE, $43

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5F01:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3C, $03, $03, $03, $03, $00, $48, $06, $00
    db $4A, $0F, $0B, $00, $50, $02, $00, $7E, $04, $00, $76, $0F, $0B, $00, $52, $06
    db $00, $9E, $0F, $0D, $00, $52, $08, $00, $CA, $0F, $0B, $00, $70, $0C, $00, $F8
    db $0F, $2F, $00, $9A, $0C, $00, $A4, $06

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5F39:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135F39, $43

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5F7C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $48, $01, $01, $00, $4A, $0F, $39, $01, $01
    db $00, $98, $0F, $3B, $00, $D0, $0F, $41, $00, $AA, $0F, $07

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5F98:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $01, $01, $00, $06, $05, $00, $00, $02, $00, $02
    db $0F, $03, $00, $06, $06, $00, $22, $0F, $17, $00, $0E, $04, $00, $54, $0F, $0F
    db $00, $0E, $02, $00, $7C, $0F, $01, $00, $00, $0F, $19, $00, $00, $08, $00, $C8
    db $0F, $0F, $00, $FD, $0F, $4D, $00, $10, $06

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_5FD1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $135FD1, $4F

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_6020:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $01, $01, $01, $01, $01, $00, $00, $02, $00, $0A
    db $06, $00, $06, $0E, $00, $06, $00, $00, $06, $0C, $00, $2C, $0E, $00, $2C, $04
    db $00, $46, $0F, $0B, $00, $52, $0F, $13, $00, $2A, $04, $00, $1E, $0F, $01, $00
    db $0A, $0C, $00, $C9, $0F, $4D, $00, $08, $1F, $2B

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_605A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_606E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_6082:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_6096:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_60AA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_60BE:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_60D2:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0B, $01, $01, $01, $01, $00, $00, $0F, $11, $00
    db $0E, $00, $00, $28, $0F, $13, $00, $61, $0F, $4D, $00, $C1, $0F, $4D, $00, $08
    db $1F, $33

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_60F4:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $01, $03, $00, $06, $09, $00, $00, $0F, $05, $00
    db $06, $0A, $00, $26, $0F, $03, $00, $4F, $0F, $4D, $00, $AF, $0F, $4D, $00, $08
    db $1F, $45

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_6116:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $09, $01, $01, $01, $01, $00, $00, $0A, $00, $0C
    db $0F, $29, $00, $0E, $0F, $4D, $00, $48, $0F, $05, $00, $C0, $0F, $0D, $00, $D0
    db $02, $00, $5E, $0A, $00, $F4, $0E, $00, $D0, $0F, $11, $00, $34, $1F, $17

; compressed tileset of map $4A (the first map record using it)
; LZSS-compressed asset: 1415 bytes expand to 1776 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4ATileset:: ; heuristic: map tileset stream; C0
Data_04D_6145:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $136145, $2BB

Data_04D_6400:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $136400, $2CC

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4AScreens0::
Data_04D_66CC:: ; heuristic: map screen array; C0
    dfar Data_04D_66E4 ; entry 0
    dfar Data_04D_67E6 ; entry 1
    dfar Data_04D_68D5 ; entry 2
    dfar Data_04D_69E0 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4AAttrs0::
Data_04D_66D8:: ; heuristic: map screen array; C0
    dfar Data_04D_6ACF ; entry 0
    dfar Data_04D_6B12 ; entry 1
    dfar Data_04D_6B71 ; entry 2
    dfar Data_04D_6BCB ; entry 3

; LZSS-compressed asset: 258 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_66E4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1366E4, $102

; LZSS-compressed asset: 239 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_67E6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1367E6, $EF

; LZSS-compressed asset: 267 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_68D5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1368D5, $10B

; LZSS-compressed asset: 239 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_69E0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1369E0, $EF

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_6ACF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $136ACF, $43

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_6B12:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $136B12, $5F

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_6B71:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $136B71, $5A

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_6BCB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $136BCB, $60

; compressed tileset of map $4C (the first map record using it)
; LZSS-compressed asset: 1547 bytes expand to 1776 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4CTileset:: ; heuristic: map tileset stream; C0
Data_04D_6C2B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $136C2B, $3D5

Data_04D_7000:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $137000, $236

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4CScreens0::
Data_04D_7236:: ; heuristic: map screen array; C0
    dfar Data_04D_724E ; entry 0
    dfar Data_04D_7334 ; entry 1
    dfar Data_04D_73FF ; entry 2
    dfar Data_04D_74E1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4CAttrs0::
Data_04D_7242:: ; heuristic: map screen array; C0
    dfar Data_04D_75DA ; entry 0
    dfar Data_04D_7657 ; entry 1
    dfar Data_04D_76AE ; entry 2
    dfar Data_04D_76F4 ; entry 3

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_724E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13724E, $E6

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_7334:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $137334, $CB

; LZSS-compressed asset: 226 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_73FF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1373FF, $E2

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_74E1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1374E1, $F9

; LZSS-compressed asset: 125 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_75DA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1375DA, $7D

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_7657:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $137657, $57

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_76AE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1376AE, $46

; LZSS-compressed asset: 102 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_76F4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1376F4, $66

; compressed tileset of map $4D (the first map record using it)
; LZSS-compressed asset: 724 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4DTileset:: ; heuristic: map tileset stream; C0
Data_04D_775A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13775A, $A6

Data_04D_7800:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $137800, $22E

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map4DPalettes::
Data_04D_7A2E:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $150B, $5F17, $15AE, $0044 ; entry 1
    dw $1528, $5F17, $15AE, $0000 ; entry 2
    dw $1528, $5F17, $3632, $0044 ; entry 3
    dw $5D8C, $5F17, $5AB1, $0000 ; entry 4
    dw $218C, $5F17, $029A, $0000 ; entry 5
    dw $1415, $4FFF, $3C1F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4DScreens0::
Data_04D_7A6E:: ; heuristic: map screen array; C0
    dfar Data_04D_7A86 ; entry 0
    dfar Data_04D_7B53 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4DAttrs0::
Data_04D_7A74:: ; heuristic: map screen array; C0
    dfar Data_04D_7DA7 ; entry 0
    dfar Data_04D_7DF1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4DScreens1::
Data_04D_7A7A:: ; heuristic: map screen array; C0
    dfar Data_04D_7A86 ; entry 0
    dfar Data_04D_7C7D ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4DAttrs1::
Data_04D_7A80:: ; heuristic: map screen array; C0
    dfar Data_04D_7DA7 ; entry 0
    dfar Data_04D_7E48 ; entry 1

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_7A86:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $137A86, $CD

; LZSS-compressed asset: 298 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_7B53:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $137B53, $12A

; LZSS-compressed asset: 298 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_7C7D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $137C7D, $12A

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_7DA7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $137DA7, $4A

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_7DF1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $137DF1, $57

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04D_7E48:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $137E48, $5D

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map4EPalettes::
Data_04D_7EA5:: ; heuristic: map BG palettes; C0
    dw $0014, $7FFF, $01DA, $0000 ; entry 0
    dw $294A, $6739, $4A52, $0000 ; entry 1
    dw $00CF, $3F7F, $01B4, $0002 ; entry 2
    dw $00E4, $024E, $0188, $0000 ; entry 3
    dw $00E4, $3F7F, $01D0, $0002 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $388E, $6218, $5154, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map4FPalettes::
Data_04D_7EE5:: ; heuristic: map BG palettes; C0
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $0160, $7FFF, $5AB1, $0000 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map50Palettes::
Data_04D_7F25:: ; heuristic: map BG palettes; C0
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $1528, $7FFF, $6B2B, $0020 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map52Palettes::
Data_04D_7F65:: ; heuristic: map BG palettes; C0
    dw $184C, $7FFF, $01DA, $0000 ; entry 0
    dw $01D6, $537D, $2E9B, $0084 ; entry 1
    dw $184C, $2E9B, $1116, $0000 ; entry 2
    dw $0217, $7FFF, $431A, $0000 ; entry 3
    dw $0160, $7FFF, $5AB1, $0000 ; entry 4
    dw $1116, $7FFF, $5AB1, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7
    ds $5B, $00
