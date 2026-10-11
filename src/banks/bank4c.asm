SECTION "Bank 4C", ROMX[$4000], BANK[$4C]
    db $4C

; compressed tileset of map $48 (the first map record using it)
; LZSS-compressed asset: 1404 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Tileset:: ; heuristic: map tileset stream; C0
Data_04C_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $130001, $57C

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map48Palettes::
Data_04C_457D:: ; address name
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $01B5, $7FFF, $5652, $0006 ; entry 1
    dw $0090, $7FFF, $199F, $0000 ; entry 2
    dw $01C4, $7FFF, $5652, $0084 ; entry 3
    dw $1415, $7FFF, $5652, $0000 ; entry 4
    dw $014E, $131C, $0216, $0000 ; entry 5
    dw $001F, $7FFF, $0348, $0000 ; entry 6
    dw $014E, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 144 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map48Screens0::
Data_04C_45BD:: ; address name
    dfar Data_04C_491D ; entry 0
    dfar Data_04C_493A ; entry 1
    dfar Data_04C_4957 ; entry 2
    dfar Data_04C_4974 ; entry 3
    dfar Data_04C_4991 ; entry 4
    dfar Data_04C_49CF ; entry 5
    dfar Data_04C_4A57 ; entry 6
    dfar Data_04C_4A74 ; entry 7
    dfar Data_04C_4A91 ; entry 8
    dfar Data_04C_4AAE ; entry 9
    dfar Data_04C_4ACB ; entry 10
    dfar Data_04C_4AE8 ; entry 11
    dfar Data_04C_4B05 ; entry 12
    dfar Data_04C_4B22 ; entry 13
    dfar Data_04C_4B3F ; entry 14
    dfar Data_04C_4B5C ; entry 15
    dfar Data_04C_4B79 ; entry 16
    dfar Data_04C_4BE7 ; entry 17
    dfar Data_04C_4C72 ; entry 18
    dfar Data_04C_4CF6 ; entry 19
    dfar Data_04C_4D74 ; entry 20
    dfar Data_04C_4D91 ; entry 21
    dfar Data_04C_4DAE ; entry 22
    dfar Data_04C_4DCB ; entry 23
    dfar Data_04C_4DE8 ; entry 24
    dfar Data_04C_4E05 ; entry 25
    dfar Data_04C_4E22 ; entry 26
    dfar Data_04C_4E3F ; entry 27
    dfar Data_04C_4E5C ; entry 28
    dfar Data_04C_4EC1 ; entry 29
    dfar Data_04C_4F47 ; entry 30
    dfar Data_04C_4FD8 ; entry 31
    dfar Data_04C_5078 ; entry 32
    dfar Data_04C_5104 ; entry 33
    dfar Data_04C_519C ; entry 34
    dfar Data_04C_5206 ; entry 35
    dfar Data_04C_5223 ; entry 36
    dfar Data_04C_5240 ; entry 37
    dfar Data_04C_525D ; entry 38
    dfar Data_04C_527A ; entry 39
    dfar Data_04C_5297 ; entry 40
    dfar Data_04C_52B4 ; entry 41
    dfar Data_04C_532B ; entry 42
    dfar Data_04C_53CB ; entry 43
    dfar Data_04C_5468 ; entry 44
    dfar Data_04C_54F2 ; entry 45
    dfar Data_04C_556C ; entry 46
    dfar Data_04C_55DF ; entry 47
    dfar Data_04C_5637 ; entry 48
    dfar Data_04C_5654 ; entry 49
    dfar Data_04C_5671 ; entry 50
    dfar Data_04C_568E ; entry 51
    dfar Data_04C_56AB ; entry 52
    dfar Data_04C_56C8 ; entry 53
    dfar Data_04C_5733 ; entry 54
    dfar Data_04C_57B1 ; entry 55
    dfar Data_04C_581D ; entry 56
    dfar Data_04C_58B3 ; entry 57
    dfar Data_04C_59D4 ; entry 58
    dfar Data_04C_5B34 ; entry 59
    dfar Data_04C_5BCB ; entry 60
    dfar Data_04C_5BE8 ; entry 61
    dfar Data_04C_5C05 ; entry 62
    dfar Data_04C_5C22 ; entry 63
    dfar Data_04C_5C3F ; entry 64
    dfar Data_04C_5CBA ; entry 65
    dfar Data_04C_5D44 ; entry 66
    dfar Data_04C_5E9A ; entry 67
    dfar Data_04C_5FE1 ; entry 68
    dfar Data_04C_610A ; entry 69
    dfar Data_04C_621A ; entry 70
    dfar Data_04C_62D7 ; entry 71
    dfar Data_04C_633D ; entry 72
    dfar Data_04C_635A ; entry 73
    dfar Data_04C_63B4 ; entry 74
    dfar Data_04C_643C ; entry 75
    dfar Data_04C_64B8 ; entry 76
    dfar Data_04C_654D ; entry 77
    dfar Data_04C_65D2 ; entry 78
    dfar Data_04C_6646 ; entry 79
    dfar Data_04C_66B8 ; entry 80
    dfar Data_04C_6718 ; entry 81
    dfar Data_04C_683A ; entry 82
    dfar Data_04C_68CE ; entry 83
    dfar Data_04C_6921 ; entry 84
    dfar Data_04C_693E ; entry 85
    dfar Data_04C_69B0 ; entry 86
    dfar Data_04C_6A45 ; entry 87
    dfar Data_04C_6AD5 ; entry 88
    dfar Data_04C_6B73 ; entry 89
    dfar Data_04C_6C07 ; entry 90
    dfar Data_04C_6CAB ; entry 91
    dfar Data_04C_6D0E ; entry 92
    dfar Data_04C_6E16 ; entry 93
    dfar Data_04C_6F85 ; entry 94
    dfar Data_04C_7008 ; entry 95
    dfar Data_04C_7025 ; entry 96
    dfar Data_04C_7042 ; entry 97
    dfar Data_04C_705F ; entry 98
    dfar Data_04C_70CD ; entry 99
    dfar Data_04C_7162 ; entry 100
    dfar Data_04C_71E9 ; entry 101
    dfar Data_04C_7252 ; entry 102
    dfar Data_04C_72C4 ; entry 103
    dfar Data_04C_7380 ; entry 104
    dfar Data_04C_7451 ; entry 105
    dfar Data_04C_74E0 ; entry 106
    dfar Data_04C_7538 ; entry 107
    dfar Data_04C_7555 ; entry 108
    dfar Data_04C_7572 ; entry 109
    dfar Data_04C_75BE ; entry 110
    dfar Data_04C_7673 ; entry 111
    dfar Data_04C_7717 ; entry 112
    dfar Data_04C_77F4 ; entry 113
    dfar Data_04C_7883 ; entry 114
    dfar Data_04C_790A ; entry 115
    dfar Data_04C_79CA ; entry 116
    dfar Data_04C_7A6C ; entry 117
    dfar Data_04C_7B27 ; entry 118
    dfar Data_04C_7BBB ; entry 119
    dfar Data_04C_7C10 ; entry 120
    dfar Data_04C_7C65 ; entry 121
    dfar Data_04C_7D12 ; entry 122
    dfar Data_04C_7DCA ; entry 123
    dfar Data_04C_7E89 ; entry 124
    dfar Data_04C_7F49 ; entry 125
    dfar Data_04D_4361 ; entry 126
    dfar Data_04D_43BB ; entry 127
    dfar Data_04D_441A ; entry 128
    dfar Data_04D_44C9 ; entry 129
    dfar Data_04D_4541 ; entry 130
    dfar Data_04D_45B8 ; entry 131
    dfar Data_04D_462D ; entry 132
    dfar Data_04D_4694 ; entry 133
    dfar Data_04D_4729 ; entry 134
    dfar Data_04D_4788 ; entry 135
    dfar Data_04D_47A5 ; entry 136
    dfar Data_04D_47C2 ; entry 137
    dfar Data_04D_47DF ; entry 138
    dfar Data_04D_47FC ; entry 139
    dfar Data_04D_4819 ; entry 140
    dfar Data_04D_4836 ; entry 141
    dfar Data_04D_488D ; entry 142
    dfar Data_04D_4905 ; entry 143

; E-0142 (derived: 144 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map48Screens2::
Data_04C_476D:: ; address name
    dfar Data_04C_491D ; entry 0
    dfar Data_04C_493A ; entry 1
    dfar Data_04C_4957 ; entry 2
    dfar Data_04C_4974 ; entry 3
    dfar Data_04C_4991 ; entry 4
    dfar Data_04C_49CF ; entry 5
    dfar Data_04C_4A57 ; entry 6
    dfar Data_04C_4A74 ; entry 7
    dfar Data_04C_4A91 ; entry 8
    dfar Data_04C_4AAE ; entry 9
    dfar Data_04C_4ACB ; entry 10
    dfar Data_04C_4AE8 ; entry 11
    dfar Data_04C_4B05 ; entry 12
    dfar Data_04C_4B22 ; entry 13
    dfar Data_04C_4B3F ; entry 14
    dfar Data_04C_4B5C ; entry 15
    dfar Data_04C_4B79 ; entry 16
    dfar Data_04C_4BE7 ; entry 17
    dfar Data_04C_4C72 ; entry 18
    dfar Data_04C_4CF6 ; entry 19
    dfar Data_04C_4D74 ; entry 20
    dfar Data_04C_4D91 ; entry 21
    dfar Data_04C_4DAE ; entry 22
    dfar Data_04C_4DCB ; entry 23
    dfar Data_04C_4DE8 ; entry 24
    dfar Data_04C_4E05 ; entry 25
    dfar Data_04C_4E22 ; entry 26
    dfar Data_04C_4E3F ; entry 27
    dfar Data_04C_4E5C ; entry 28
    dfar Data_04C_4EC1 ; entry 29
    dfar Data_04C_4F47 ; entry 30
    dfar Data_04C_4FD8 ; entry 31
    dfar Data_04C_5078 ; entry 32
    dfar Data_04C_5104 ; entry 33
    dfar Data_04C_519C ; entry 34
    dfar Data_04C_5206 ; entry 35
    dfar Data_04C_5223 ; entry 36
    dfar Data_04C_5240 ; entry 37
    dfar Data_04C_525D ; entry 38
    dfar Data_04C_527A ; entry 39
    dfar Data_04C_5297 ; entry 40
    dfar Data_04C_52B4 ; entry 41
    dfar Data_04C_532B ; entry 42
    dfar Data_04C_53CB ; entry 43
    dfar Data_04C_5468 ; entry 44
    dfar Data_04C_54F2 ; entry 45
    dfar Data_04C_556C ; entry 46
    dfar Data_04C_55DF ; entry 47
    dfar Data_04C_5637 ; entry 48
    dfar Data_04C_5654 ; entry 49
    dfar Data_04C_5671 ; entry 50
    dfar Data_04C_568E ; entry 51
    dfar Data_04C_56AB ; entry 52
    dfar Data_04C_56C8 ; entry 53
    dfar Data_04C_5733 ; entry 54
    dfar Data_04C_57B1 ; entry 55
    dfar Data_04C_581D ; entry 56
    dfar Data_04C_5948 ; entry 57
    dfar Data_04C_5A85 ; entry 58
    dfar Data_04C_5B34 ; entry 59
    dfar Data_04C_5BCB ; entry 60
    dfar Data_04C_5BE8 ; entry 61
    dfar Data_04C_5C05 ; entry 62
    dfar Data_04C_5C22 ; entry 63
    dfar Data_04C_5C3F ; entry 64
    dfar Data_04C_5CBA ; entry 65
    dfar Data_04C_5DF0 ; entry 66
    dfar Data_04C_5F49 ; entry 67
    dfar Data_04C_6075 ; entry 68
    dfar Data_04C_618F ; entry 69
    dfar Data_04C_621A ; entry 70
    dfar Data_04C_62D7 ; entry 71
    dfar Data_04C_633D ; entry 72
    dfar Data_04C_635A ; entry 73
    dfar Data_04C_63B4 ; entry 74
    dfar Data_04C_643C ; entry 75
    dfar Data_04C_64B8 ; entry 76
    dfar Data_04C_654D ; entry 77
    dfar Data_04C_65D2 ; entry 78
    dfar Data_04C_669C ; entry 79
    dfar Data_04C_66FC ; entry 80
    dfar Data_04C_67B3 ; entry 81
    dfar Data_04C_683A ; entry 82
    dfar Data_04C_68CE ; entry 83
    dfar Data_04C_6921 ; entry 84
    dfar Data_04C_693E ; entry 85
    dfar Data_04C_69B0 ; entry 86
    dfar Data_04C_6A45 ; entry 87
    dfar Data_04C_6AD5 ; entry 88
    dfar Data_04C_6B73 ; entry 89
    dfar Data_04C_6C07 ; entry 90
    dfar Data_04C_6CF2 ; entry 91
    dfar Data_04C_6D8C ; entry 92
    dfar Data_04C_6ED8 ; entry 93
    dfar Data_04C_6F85 ; entry 94
    dfar Data_04C_7008 ; entry 95
    dfar Data_04C_7025 ; entry 96
    dfar Data_04C_7042 ; entry 97
    dfar Data_04C_705F ; entry 98
    dfar Data_04C_70CD ; entry 99
    dfar Data_04C_7162 ; entry 100
    dfar Data_04C_7236 ; entry 101
    dfar Data_04C_72A8 ; entry 102
    dfar Data_04C_733B ; entry 103
    dfar Data_04C_7403 ; entry 104
    dfar Data_04C_7451 ; entry 105
    dfar Data_04C_74E0 ; entry 106
    dfar Data_04C_7538 ; entry 107
    dfar Data_04C_7555 ; entry 108
    dfar Data_04C_7572 ; entry 109
    dfar Data_04C_75BE ; entry 110
    dfar Data_04C_7673 ; entry 111
    dfar Data_04C_7717 ; entry 112
    dfar Data_04C_77F4 ; entry 113
    dfar Data_04C_7883 ; entry 114
    dfar Data_04C_790A ; entry 115
    dfar Data_04C_79CA ; entry 116
    dfar Data_04C_7A6C ; entry 117
    dfar Data_04C_7B27 ; entry 118
    dfar Data_04C_7BBB ; entry 119
    dfar Data_04C_7C10 ; entry 120
    dfar Data_04C_7C65 ; entry 121
    dfar Data_04C_7D12 ; entry 122
    dfar Data_04C_7DCA ; entry 123
    dfar Data_04C_7E89 ; entry 124
    dfar Data_04C_7F49 ; entry 125
    dfar Data_04D_4361 ; entry 126
    dfar Data_04D_43BB ; entry 127
    dfar Data_04D_441A ; entry 128
    dfar Data_04D_44C9 ; entry 129
    dfar Data_04D_4541 ; entry 130
    dfar Data_04D_45B8 ; entry 131
    dfar Data_04D_462D ; entry 132
    dfar Data_04D_4694 ; entry 133
    dfar Data_04D_4729 ; entry 134
    dfar Data_04D_4788 ; entry 135
    dfar Data_04D_47A5 ; entry 136
    dfar Data_04D_47C2 ; entry 137
    dfar Data_04D_47DF ; entry 138
    dfar Data_04D_47FC ; entry 139
    dfar Data_04D_4819 ; entry 140
    dfar Data_04D_4836 ; entry 141
    dfar Data_04D_488D ; entry 142
    dfar Data_04D_4905 ; entry 143

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_491D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_493A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4957:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4974:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4991:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $3D, $44, $45, $44, $45, $00, $64, $0C, $54, $55, $54, $55
    db $00, $CA, $0E, $00, $DA, $0C, $00, $EC, $00, $00, $EE, $0A, $00, $D8, $00, $42
    db $43, $42, $43, $00, $E0, $0C, $52, $53, $52, $53, $00, $18, $1F, $15

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_49CF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1309CF, $88

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4A57:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4A74:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4A91:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4AAE:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4ACB:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4AE8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4B05:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4B22:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4B3F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4B5C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4B79:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $130B79, $6E

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4BE7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $130BE7, $8B

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4C72:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $130C72, $84

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4CF6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $130CF6, $4D

Data_04C_4D43:: ; heuristic: target of a monotone pointer table; C0
    db $53

Data_04C_4D44:: ; heuristic: target of a monotone pointer table; C0
    db $50

Data_04C_4D45:: ; heuristic: target of a monotone pointer table; C0
    db $51

Data_04C_4D46:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_04C_4D47:: ; heuristic: target of a monotone pointer table; C0
    db $B4

Data_04C_4D48:: ; heuristic: target of a monotone pointer table; C0
    db $02

Data_04C_4D49:: ; heuristic: target of a monotone pointer table; C0
    db $00, $C2, $08, $00, $CC, $0A, $00, $DC, $02, $00, $E0, $0A, $00, $F0, $0A, $42
    db $43, $00, $00, $1E, $52, $53, $00, $24, $02, $00, $C8, $04, $00, $CE, $02, $00
    db $10, $02, $00, $DC, $04, $00, $E2, $02, $00, $14, $00

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4D74:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4D91:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4DAE:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4DCB:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4DE8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4E05:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F

; LZSS-compressed asset: 63 bytes expand to 77 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4E1D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4E22:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4E3F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4E5C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $130E5C, $65

; LZSS-compressed asset: 134 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4EC1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $130EC1, $86

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4F47:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $130F47, $91

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4FD8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $130FD8, $A0

; LZSS-compressed asset: 140 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5078:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131078, $8C

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5104:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131104, $98

; LZSS-compressed asset: 106 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_519C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13119C, $6A

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5206:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5223:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5240:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_525D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F

; LZSS-compressed asset: 63 bytes expand to 77 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5275:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_527A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5297:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_52B4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1312B4, $77

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_532B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13132B, $A0

; LZSS-compressed asset: 157 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_53CB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1313CB, $9D

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5468:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131468, $8A

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_54F2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1314F2, $7A

; LZSS-compressed asset: 115 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_556C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13156C, $73

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_55DF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1315DF, $58

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5637:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5654:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5671:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F

; LZSS-compressed asset: 63 bytes expand to 77 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5689:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_568E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_56AB:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_56C8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1316C8, $6B

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5733:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131733, $7E

; LZSS-compressed asset: 108 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_57B1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1317B1, $6C

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_581D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13181D, $96

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_58B3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1318B3, $95

; LZSS-compressed asset: 140 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5948:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131948, $8C

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_59D4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1319D4, $B1

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5A85:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131A85, $AF

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5B34:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131B34, $97

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5BCB:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5BE8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F

; LZSS-compressed asset: 63 bytes expand to 77 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5C00:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5C05:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5C22:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5C3F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131C3F, $7B

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5CBA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131CBA, $8A

; LZSS-compressed asset: 172 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5D44:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131D44, $AC

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5DF0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131DF0, $AA

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5E9A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131E9A, $AF

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5F49:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131F49, $98

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5FE1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $131FE1, $94

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6075:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132075, $95

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_610A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13210A, $85

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_618F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13218F, $8B

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_621A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13221A, $BD

; LZSS-compressed asset: 102 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_62D7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1322D7, $66

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_633D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_635A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13235A, $5A

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_63B4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1323B4, $88

; LZSS-compressed asset: 124 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_643C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13243C, $7C

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_64B8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1324B8, $95

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_654D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13254D, $85

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_65D2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1325D2, $74

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6646:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132646, $56

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_669C:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_66B8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1326B8, $44

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_66FC:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6718:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132718, $9B

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_67B3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1327B3, $87

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_683A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13283A, $94

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_68CE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1328CE, $53

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6921:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_693E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13293E, $72

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_69B0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1329B0, $95

; LZSS-compressed asset: 144 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6A45:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132A45, $90

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6AD5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132AD5, $9E

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6B73:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132B73, $94

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6C07:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132C07, $A4

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6CAB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132CAB, $47

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6CF2:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6D0E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132D0E, $7E

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6D8C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132D8C, $8A

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6E16:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132E16, $C2

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6ED8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132ED8, $AD

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_6F85:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $132F85, $83

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7008:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7025:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7042:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_705F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13305F, $6E

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_70CD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1330CD, $95

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7162:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133162, $87

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_71E9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1331E9, $4D

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7236:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7252:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E

; LZSS-compressed asset: 225 bytes expand to 258 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_725A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $13325A, $4E

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_72A8:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_72C4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1332C4, $77

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_733B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13333B, $45

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7380:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133380, $83

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7403:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133403, $4E

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7451:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133451, $8F

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_74E0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1334E0, $58

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7538:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7555:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7572:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133572, $4C

; LZSS-compressed asset: 181 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_75BE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1335BE, $B5

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7673:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133673, $A4

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7717:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133717, $DD

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_77F4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1337F4, $8F

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7883:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133883, $87

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_790A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13390A, $C0

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_79CA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1339CA, $A2

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7A6C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133A6C, $BB

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7B27:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133B27, $94

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7BBB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133BBB, $55

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7C10:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133C10, $55

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7C65:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133C65, $AD

; LZSS-compressed asset: 184 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7D12:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133D12, $B8

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7DCA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133DCA, $BF

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7E89:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133E89, $C0

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_7F49:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $133F49, $77
    ds $40, $00
