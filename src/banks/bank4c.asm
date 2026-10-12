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
    dfar Map48Screens0_Y0X0 ; entry 0
    dfar Map48Screens0_Y0X1 ; entry 1
    dfar Map48Screens0_Y0X2 ; entry 2
    dfar Map48Screens0_Y0X3 ; entry 3
    dfar Map48Screens0_Y0X4 ; entry 4
    dfar Map48Screens0_Y0X5 ; entry 5
    dfar Map48Screens0_Y0X6 ; entry 6
    dfar Map48Screens0_Y0X7 ; entry 7
    dfar Map48Screens0_Y0X8 ; entry 8
    dfar Map48Screens0_Y0X9 ; entry 9
    dfar Map48Screens0_Y0X10 ; entry 10
    dfar Map48Screens0_Y0X11 ; entry 11
    dfar Map48Screens0_Y1X0 ; entry 12
    dfar Map48Screens0_Y1X1 ; entry 13
    dfar Map48Screens0_Y1X2 ; entry 14
    dfar Map48Screens0_Y1X3 ; entry 15
    dfar Map48Screens0_Y1X4 ; entry 16
    dfar Map48Screens0_Y1X5 ; entry 17
    dfar Map48Screens0_Y1X6 ; entry 18
    dfar Map48Screens0_Y1X7 ; entry 19
    dfar Map48Screens0_Y1X8 ; entry 20
    dfar Map48Screens0_Y1X9 ; entry 21
    dfar Map48Screens0_Y1X10 ; entry 22
    dfar Map48Screens0_Y1X11 ; entry 23
    dfar Map48Screens0_Y2X0 ; entry 24
    dfar Map48Screens0_Y2X1 ; entry 25
    dfar Map48Screens0_Y2X2 ; entry 26
    dfar Map48Screens0_Y2X3 ; entry 27
    dfar Map48Screens0_Y2X4 ; entry 28
    dfar Map48Screens0_Y2X5 ; entry 29
    dfar Map48Screens0_Y2X6 ; entry 30
    dfar Map48Screens0_Y2X7 ; entry 31
    dfar Map48Screens0_Y2X8 ; entry 32
    dfar Map48Screens0_Y2X9 ; entry 33
    dfar Map48Screens0_Y2X10 ; entry 34
    dfar Map48Screens0_Y2X11 ; entry 35
    dfar Map48Screens0_Y3X0 ; entry 36
    dfar Map48Screens0_Y3X1 ; entry 37
    dfar Map48Screens0_Y3X2 ; entry 38
    dfar Map48Screens0_Y3X3 ; entry 39
    dfar Map48Screens0_Y3X4 ; entry 40
    dfar Map48Screens0_Y3X5 ; entry 41
    dfar Map48Screens0_Y3X6 ; entry 42
    dfar Map48Screens0_Y3X7 ; entry 43
    dfar Map48Screens0_Y3X8 ; entry 44
    dfar Map48Screens0_Y3X9 ; entry 45
    dfar Map48Screens0_Y3X10 ; entry 46
    dfar Map48Screens0_Y3X11 ; entry 47
    dfar Map48Screens0_Y4X0 ; entry 48
    dfar Map48Screens0_Y4X1 ; entry 49
    dfar Map48Screens0_Y4X2 ; entry 50
    dfar Map48Screens0_Y4X3 ; entry 51
    dfar Map48Screens0_Y4X4 ; entry 52
    dfar Map48Screens0_Y4X5 ; entry 53
    dfar Map48Screens0_Y4X6 ; entry 54
    dfar Map48Screens0_Y4X7 ; entry 55
    dfar Map48Screens0_Y4X8 ; entry 56
    dfar Map48Screens0_Y4X9 ; entry 57
    dfar Map48Screens0_Y4X10 ; entry 58
    dfar Map48Screens0_Y4X11 ; entry 59
    dfar Map48Screens0_Y5X0 ; entry 60
    dfar Map48Screens0_Y5X1 ; entry 61
    dfar Map48Screens0_Y5X2 ; entry 62
    dfar Map48Screens0_Y5X3 ; entry 63
    dfar Map48Screens0_Y5X4 ; entry 64
    dfar Map48Screens0_Y5X5 ; entry 65
    dfar Map48Screens0_Y5X6 ; entry 66
    dfar Map48Screens0_Y5X7 ; entry 67
    dfar Map48Screens0_Y5X8 ; entry 68
    dfar Map48Screens0_Y5X9 ; entry 69
    dfar Map48Screens0_Y5X10 ; entry 70
    dfar Map48Screens0_Y5X11 ; entry 71
    dfar Map48Screens0_Y6X0 ; entry 72
    dfar Map48Screens0_Y6X1 ; entry 73
    dfar Map48Screens0_Y6X2 ; entry 74
    dfar Map48Screens0_Y6X3 ; entry 75
    dfar Map48Screens0_Y6X4 ; entry 76
    dfar Map48Screens0_Y6X5 ; entry 77
    dfar Map48Screens0_Y6X6 ; entry 78
    dfar Map48Screens0_Y6X7 ; entry 79
    dfar Map48Screens0_Y6X8 ; entry 80
    dfar Map48Screens0_Y6X9 ; entry 81
    dfar Map48Screens0_Y6X10 ; entry 82
    dfar Map48Screens0_Y6X11 ; entry 83
    dfar Map48Screens0_Y7X0 ; entry 84
    dfar Map48Screens0_Y7X1 ; entry 85
    dfar Map48Screens0_Y7X2 ; entry 86
    dfar Map48Screens0_Y7X3 ; entry 87
    dfar Map48Screens0_Y7X4 ; entry 88
    dfar Map48Screens0_Y7X5 ; entry 89
    dfar Map48Screens0_Y7X6 ; entry 90
    dfar Map48Screens0_Y7X7 ; entry 91
    dfar Map48Screens0_Y7X8 ; entry 92
    dfar Map48Screens0_Y7X9 ; entry 93
    dfar Map48Screens0_Y7X10 ; entry 94
    dfar Map48Screens0_Y7X11 ; entry 95
    dfar Map48Screens0_Y8X0 ; entry 96
    dfar Map48Screens0_Y8X1 ; entry 97
    dfar Map48Screens0_Y8X2 ; entry 98
    dfar Map48Screens0_Y8X3 ; entry 99
    dfar Map48Screens0_Y8X4 ; entry 100
    dfar Map48Screens0_Y8X5 ; entry 101
    dfar Map48Screens0_Y8X6 ; entry 102
    dfar Map48Screens0_Y8X7 ; entry 103
    dfar Map48Screens0_Y8X8 ; entry 104
    dfar Map48Screens0_Y8X9 ; entry 105
    dfar Map48Screens0_Y8X10 ; entry 106
    dfar Map48Screens0_Y8X11 ; entry 107
    dfar Map48Screens0_Y9X0 ; entry 108
    dfar Map48Screens0_Y9X1 ; entry 109
    dfar Map48Screens0_Y9X2 ; entry 110
    dfar Map48Screens0_Y9X3 ; entry 111
    dfar Map48Screens0_Y9X4 ; entry 112
    dfar Map48Screens0_Y9X5 ; entry 113
    dfar Map48Screens0_Y9X6 ; entry 114
    dfar Map48Screens0_Y9X7 ; entry 115
    dfar Map48Screens0_Y9X8 ; entry 116
    dfar Map48Screens0_Y9X9 ; entry 117
    dfar Map48Screens0_Y9X10 ; entry 118
    dfar Map48Screens0_Y9X11 ; entry 119
    dfar Map48Screens0_Y10X0 ; entry 120
    dfar Map48Screens0_Y10X1 ; entry 121
    dfar Map48Screens0_Y10X2 ; entry 122
    dfar Map48Screens0_Y10X3 ; entry 123
    dfar Map48Screens0_Y10X4 ; entry 124
    dfar Map48Screens0_Y10X5 ; entry 125
    dfar Map48Screens0_Y10X6 ; entry 126
    dfar Map48Screens0_Y10X7 ; entry 127
    dfar Map48Screens0_Y10X8 ; entry 128
    dfar Map48Screens0_Y10X9 ; entry 129
    dfar Map48Screens0_Y10X10 ; entry 130
    dfar Map48Screens0_Y10X11 ; entry 131
    dfar Map48Screens0_Y11X0 ; entry 132
    dfar Map48Screens0_Y11X1 ; entry 133
    dfar Map48Screens0_Y11X2 ; entry 134
    dfar Map48Screens0_Y11X3 ; entry 135
    dfar Map48Screens0_Y11X4 ; entry 136
    dfar Map48Screens0_Y11X5 ; entry 137
    dfar Map48Screens0_Y11X6 ; entry 138
    dfar Map48Screens0_Y11X7 ; entry 139
    dfar Map48Screens0_Y11X8 ; entry 140
    dfar Map48Screens0_Y11X9 ; entry 141
    dfar Map48Screens0_Y11X10 ; entry 142
    dfar Map48Screens0_Y11X11 ; entry 143

; E-0142 (derived: 144 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map48Screens2::
Data_04C_476D:: ; address name
    dfar Map48Screens0_Y0X0 ; entry 0
    dfar Map48Screens0_Y0X1 ; entry 1
    dfar Map48Screens0_Y0X2 ; entry 2
    dfar Map48Screens0_Y0X3 ; entry 3
    dfar Map48Screens0_Y0X4 ; entry 4
    dfar Map48Screens0_Y0X5 ; entry 5
    dfar Map48Screens0_Y0X6 ; entry 6
    dfar Map48Screens0_Y0X7 ; entry 7
    dfar Map48Screens0_Y0X8 ; entry 8
    dfar Map48Screens0_Y0X9 ; entry 9
    dfar Map48Screens0_Y0X10 ; entry 10
    dfar Map48Screens0_Y0X11 ; entry 11
    dfar Map48Screens0_Y1X0 ; entry 12
    dfar Map48Screens0_Y1X1 ; entry 13
    dfar Map48Screens0_Y1X2 ; entry 14
    dfar Map48Screens0_Y1X3 ; entry 15
    dfar Map48Screens0_Y1X4 ; entry 16
    dfar Map48Screens0_Y1X5 ; entry 17
    dfar Map48Screens0_Y1X6 ; entry 18
    dfar Map48Screens0_Y1X7 ; entry 19
    dfar Map48Screens0_Y1X8 ; entry 20
    dfar Map48Screens0_Y1X9 ; entry 21
    dfar Map48Screens0_Y1X10 ; entry 22
    dfar Map48Screens0_Y1X11 ; entry 23
    dfar Map48Screens0_Y2X0 ; entry 24
    dfar Map48Screens0_Y2X1 ; entry 25
    dfar Map48Screens0_Y2X2 ; entry 26
    dfar Map48Screens0_Y2X3 ; entry 27
    dfar Map48Screens0_Y2X4 ; entry 28
    dfar Map48Screens0_Y2X5 ; entry 29
    dfar Map48Screens0_Y2X6 ; entry 30
    dfar Map48Screens0_Y2X7 ; entry 31
    dfar Map48Screens0_Y2X8 ; entry 32
    dfar Map48Screens0_Y2X9 ; entry 33
    dfar Map48Screens0_Y2X10 ; entry 34
    dfar Map48Screens0_Y2X11 ; entry 35
    dfar Map48Screens0_Y3X0 ; entry 36
    dfar Map48Screens0_Y3X1 ; entry 37
    dfar Map48Screens0_Y3X2 ; entry 38
    dfar Map48Screens0_Y3X3 ; entry 39
    dfar Map48Screens0_Y3X4 ; entry 40
    dfar Map48Screens0_Y3X5 ; entry 41
    dfar Map48Screens0_Y3X6 ; entry 42
    dfar Map48Screens0_Y3X7 ; entry 43
    dfar Map48Screens0_Y3X8 ; entry 44
    dfar Map48Screens0_Y3X9 ; entry 45
    dfar Map48Screens0_Y3X10 ; entry 46
    dfar Map48Screens0_Y3X11 ; entry 47
    dfar Map48Screens0_Y4X0 ; entry 48
    dfar Map48Screens0_Y4X1 ; entry 49
    dfar Map48Screens0_Y4X2 ; entry 50
    dfar Map48Screens0_Y4X3 ; entry 51
    dfar Map48Screens0_Y4X4 ; entry 52
    dfar Map48Screens0_Y4X5 ; entry 53
    dfar Map48Screens0_Y4X6 ; entry 54
    dfar Map48Screens0_Y4X7 ; entry 55
    dfar Map48Screens0_Y4X8 ; entry 56
    dfar Map48Screens2_Y4X9 ; entry 57
    dfar Map48Screens2_Y4X10 ; entry 58
    dfar Map48Screens0_Y4X11 ; entry 59
    dfar Map48Screens0_Y5X0 ; entry 60
    dfar Map48Screens0_Y5X1 ; entry 61
    dfar Map48Screens0_Y5X2 ; entry 62
    dfar Map48Screens0_Y5X3 ; entry 63
    dfar Map48Screens0_Y5X4 ; entry 64
    dfar Map48Screens0_Y5X5 ; entry 65
    dfar Map48Screens2_Y5X6 ; entry 66
    dfar Map48Screens2_Y5X7 ; entry 67
    dfar Map48Screens2_Y5X8 ; entry 68
    dfar Map48Screens2_Y5X9 ; entry 69
    dfar Map48Screens0_Y5X10 ; entry 70
    dfar Map48Screens0_Y5X11 ; entry 71
    dfar Map48Screens0_Y6X0 ; entry 72
    dfar Map48Screens0_Y6X1 ; entry 73
    dfar Map48Screens0_Y6X2 ; entry 74
    dfar Map48Screens0_Y6X3 ; entry 75
    dfar Map48Screens0_Y6X4 ; entry 76
    dfar Map48Screens0_Y6X5 ; entry 77
    dfar Map48Screens0_Y6X6 ; entry 78
    dfar Map48Screens2_Y6X7 ; entry 79
    dfar Map48Screens2_Y6X8 ; entry 80
    dfar Map48Screens2_Y6X9 ; entry 81
    dfar Map48Screens0_Y6X10 ; entry 82
    dfar Map48Screens0_Y6X11 ; entry 83
    dfar Map48Screens0_Y7X0 ; entry 84
    dfar Map48Screens0_Y7X1 ; entry 85
    dfar Map48Screens0_Y7X2 ; entry 86
    dfar Map48Screens0_Y7X3 ; entry 87
    dfar Map48Screens0_Y7X4 ; entry 88
    dfar Map48Screens0_Y7X5 ; entry 89
    dfar Map48Screens0_Y7X6 ; entry 90
    dfar Map48Screens2_Y7X7 ; entry 91
    dfar Map48Screens2_Y7X8 ; entry 92
    dfar Map48Screens2_Y7X9 ; entry 93
    dfar Map48Screens0_Y7X10 ; entry 94
    dfar Map48Screens0_Y7X11 ; entry 95
    dfar Map48Screens0_Y8X0 ; entry 96
    dfar Map48Screens0_Y8X1 ; entry 97
    dfar Map48Screens0_Y8X2 ; entry 98
    dfar Map48Screens0_Y8X3 ; entry 99
    dfar Map48Screens0_Y8X4 ; entry 100
    dfar Map48Screens2_Y8X5 ; entry 101
    dfar Map48Screens2_Y8X6 ; entry 102
    dfar Map48Screens2_Y8X7 ; entry 103
    dfar Map48Screens2_Y8X8 ; entry 104
    dfar Map48Screens0_Y8X9 ; entry 105
    dfar Map48Screens0_Y8X10 ; entry 106
    dfar Map48Screens0_Y8X11 ; entry 107
    dfar Map48Screens0_Y9X0 ; entry 108
    dfar Map48Screens0_Y9X1 ; entry 109
    dfar Map48Screens0_Y9X2 ; entry 110
    dfar Map48Screens0_Y9X3 ; entry 111
    dfar Map48Screens0_Y9X4 ; entry 112
    dfar Map48Screens0_Y9X5 ; entry 113
    dfar Map48Screens0_Y9X6 ; entry 114
    dfar Map48Screens0_Y9X7 ; entry 115
    dfar Map48Screens0_Y9X8 ; entry 116
    dfar Map48Screens0_Y9X9 ; entry 117
    dfar Map48Screens0_Y9X10 ; entry 118
    dfar Map48Screens0_Y9X11 ; entry 119
    dfar Map48Screens0_Y10X0 ; entry 120
    dfar Map48Screens0_Y10X1 ; entry 121
    dfar Map48Screens0_Y10X2 ; entry 122
    dfar Map48Screens0_Y10X3 ; entry 123
    dfar Map48Screens0_Y10X4 ; entry 124
    dfar Map48Screens0_Y10X5 ; entry 125
    dfar Map48Screens0_Y10X6 ; entry 126
    dfar Map48Screens0_Y10X7 ; entry 127
    dfar Map48Screens0_Y10X8 ; entry 128
    dfar Map48Screens0_Y10X9 ; entry 129
    dfar Map48Screens0_Y10X10 ; entry 130
    dfar Map48Screens0_Y10X11 ; entry 131
    dfar Map48Screens0_Y11X0 ; entry 132
    dfar Map48Screens0_Y11X1 ; entry 133
    dfar Map48Screens0_Y11X2 ; entry 134
    dfar Map48Screens0_Y11X3 ; entry 135
    dfar Map48Screens0_Y11X4 ; entry 136
    dfar Map48Screens0_Y11X5 ; entry 137
    dfar Map48Screens0_Y11X6 ; entry 138
    dfar Map48Screens0_Y11X7 ; entry 139
    dfar Map48Screens0_Y11X8 ; entry 140
    dfar Map48Screens0_Y11X9 ; entry 141
    dfar Map48Screens0_Y11X10 ; entry 142
    dfar Map48Screens0_Y11X11 ; entry 143

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04C_491D:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_04C_493A:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X2:: ; heuristic: map screen stream; C0
Data_04C_4957:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X3:: ; heuristic: map screen stream; C0
Data_04C_4974:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X4:: ; heuristic: map screen stream; C0
Data_04C_4991:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $3D, $44, $45, $44, $45, $00, $64, $0C, $54, $55, $54, $55
    db $00, $CA, $0E, $00, $DA, $0C, $00, $EC, $00, $00, $EE, $0A, $00, $D8, $00, $42
    db $43, $42, $43, $00, $E0, $0C, $52, $53, $52, $53, $00, $18, $1F, $15

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X5:: ; heuristic: map screen stream; C0
Data_04C_49CF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1309CF, $88

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X6:: ; heuristic: map screen stream; C0
Data_04C_4A57:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X7:: ; heuristic: map screen stream; C0
Data_04C_4A74:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X8:: ; heuristic: map screen stream; C0
Data_04C_4A91:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X9:: ; heuristic: map screen stream; C0
Data_04C_4AAE:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X10:: ; heuristic: map screen stream; C0
Data_04C_4ACB:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y0X11:: ; heuristic: map screen stream; C0
Data_04C_4AE8:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_04C_4B05:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_04C_4B22:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X2:: ; heuristic: map screen stream; C0
Data_04C_4B3F:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X3:: ; heuristic: map screen stream; C0
Data_04C_4B5C:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X4:: ; heuristic: map screen stream; C0
Data_04C_4B79:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $130B79, $6E

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X5:: ; heuristic: map screen stream; C0
Data_04C_4BE7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $130BE7, $8B

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X6:: ; heuristic: map screen stream; C0
Data_04C_4C72:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $130C72, $84

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X7:: ; heuristic: map screen stream; C0
Data_04C_4CF6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $130CF6, $7E

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X8:: ; heuristic: map screen stream; C0
Data_04C_4D74:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X9:: ; heuristic: map screen stream; C0
Data_04C_4D91:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X10:: ; heuristic: map screen stream; C0
Data_04C_4DAE:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y1X11:: ; heuristic: map screen stream; C0
Data_04C_4DCB:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X0:: ; heuristic: map screen stream; C0
Data_04C_4DE8:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X1:: ; heuristic: map screen stream; C0
Data_04C_4E05:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F

; LZSS-compressed asset: 63 bytes expand to 77 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_4E1D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X2:: ; heuristic: map screen stream; C0
Data_04C_4E22:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X3:: ; heuristic: map screen stream; C0
Data_04C_4E3F:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X4:: ; heuristic: map screen stream; C0
Data_04C_4E5C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $130E5C, $65

; LZSS-compressed asset: 134 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X5:: ; heuristic: map screen stream; C0
Data_04C_4EC1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $130EC1, $86

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X6:: ; heuristic: map screen stream; C0
Data_04C_4F47:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $130F47, $91

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X7:: ; heuristic: map screen stream; C0
Data_04C_4FD8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $130FD8, $A0

; LZSS-compressed asset: 140 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X8:: ; heuristic: map screen stream; C0
Data_04C_5078:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131078, $8C

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X9:: ; heuristic: map screen stream; C0
Data_04C_5104:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131104, $98

; LZSS-compressed asset: 106 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X10:: ; heuristic: map screen stream; C0
Data_04C_519C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13119C, $6A

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y2X11:: ; heuristic: map screen stream; C0
Data_04C_5206:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X0:: ; heuristic: map screen stream; C0
Data_04C_5223:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X1:: ; heuristic: map screen stream; C0
Data_04C_5240:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X2:: ; heuristic: map screen stream; C0
Data_04C_525D:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F

; LZSS-compressed asset: 63 bytes expand to 77 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5275:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X3:: ; heuristic: map screen stream; C0
Data_04C_527A:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X4:: ; heuristic: map screen stream; C0
Data_04C_5297:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X5:: ; heuristic: map screen stream; C0
Data_04C_52B4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1312B4, $77

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X6:: ; heuristic: map screen stream; C0
Data_04C_532B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13132B, $A0

; LZSS-compressed asset: 157 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X7:: ; heuristic: map screen stream; C0
Data_04C_53CB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1313CB, $9D

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X8:: ; heuristic: map screen stream; C0
Data_04C_5468:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131468, $8A

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X9:: ; heuristic: map screen stream; C0
Data_04C_54F2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1314F2, $7A

; LZSS-compressed asset: 115 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X10:: ; heuristic: map screen stream; C0
Data_04C_556C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13156C, $73

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y3X11:: ; heuristic: map screen stream; C0
Data_04C_55DF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1315DF, $58

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X0:: ; heuristic: map screen stream; C0
Data_04C_5637:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X1:: ; heuristic: map screen stream; C0
Data_04C_5654:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X2:: ; heuristic: map screen stream; C0
Data_04C_5671:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F

; LZSS-compressed asset: 63 bytes expand to 77 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5689:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X3:: ; heuristic: map screen stream; C0
Data_04C_568E:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X4:: ; heuristic: map screen stream; C0
Data_04C_56AB:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X5:: ; heuristic: map screen stream; C0
Data_04C_56C8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1316C8, $6B

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X6:: ; heuristic: map screen stream; C0
Data_04C_5733:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131733, $7E

; LZSS-compressed asset: 108 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X7:: ; heuristic: map screen stream; C0
Data_04C_57B1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1317B1, $6C

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X8:: ; heuristic: map screen stream; C0
Data_04C_581D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13181D, $96

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X9:: ; heuristic: map screen stream; C0
Data_04C_58B3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1318B3, $95

; LZSS-compressed asset: 140 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y4X9:: ; heuristic: map screen stream; C0
Data_04C_5948:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131948, $8C

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X10:: ; heuristic: map screen stream; C0
Data_04C_59D4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1319D4, $B1

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y4X10:: ; heuristic: map screen stream; C0
Data_04C_5A85:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131A85, $AF

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y4X11:: ; heuristic: map screen stream; C0
Data_04C_5B34:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131B34, $97

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X0:: ; heuristic: map screen stream; C0
Data_04C_5BCB:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X1:: ; heuristic: map screen stream; C0
Data_04C_5BE8:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F

; LZSS-compressed asset: 63 bytes expand to 77 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_5C00:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X2:: ; heuristic: map screen stream; C0
Data_04C_5C05:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X3:: ; heuristic: map screen stream; C0
Data_04C_5C22:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X4:: ; heuristic: map screen stream; C0
Data_04C_5C3F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131C3F, $7B

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X5:: ; heuristic: map screen stream; C0
Data_04C_5CBA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131CBA, $8A

; LZSS-compressed asset: 172 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X6:: ; heuristic: map screen stream; C0
Data_04C_5D44:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131D44, $AC

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y5X6:: ; heuristic: map screen stream; C0
Data_04C_5DF0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131DF0, $AA

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X7:: ; heuristic: map screen stream; C0
Data_04C_5E9A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131E9A, $AF

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y5X7:: ; heuristic: map screen stream; C0
Data_04C_5F49:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131F49, $98

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X8:: ; heuristic: map screen stream; C0
Data_04C_5FE1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $131FE1, $94

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y5X8:: ; heuristic: map screen stream; C0
Data_04C_6075:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132075, $95

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X9:: ; heuristic: map screen stream; C0
Data_04C_610A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13210A, $85

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y5X9:: ; heuristic: map screen stream; C0
Data_04C_618F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13218F, $8B

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X10:: ; heuristic: map screen stream; C0
Data_04C_621A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13221A, $BD

; LZSS-compressed asset: 102 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y5X11:: ; heuristic: map screen stream; C0
Data_04C_62D7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1322D7, $66

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X0:: ; heuristic: map screen stream; C0
Data_04C_633D:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X1:: ; heuristic: map screen stream; C0
Data_04C_635A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13235A, $5A

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X2:: ; heuristic: map screen stream; C0
Data_04C_63B4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1323B4, $88

; LZSS-compressed asset: 124 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X3:: ; heuristic: map screen stream; C0
Data_04C_643C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13243C, $7C

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X4:: ; heuristic: map screen stream; C0
Data_04C_64B8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1324B8, $95

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X5:: ; heuristic: map screen stream; C0
Data_04C_654D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13254D, $85

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X6:: ; heuristic: map screen stream; C0
Data_04C_65D2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1325D2, $74

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X7:: ; heuristic: map screen stream; C0
Data_04C_6646:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132646, $56

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y6X7:: ; heuristic: map screen stream; C0
Data_04C_669C:: ; address name
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X8:: ; heuristic: map screen stream; C0
Data_04C_66B8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1326B8, $44

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y6X8:: ; heuristic: map screen stream; C0
Data_04C_66FC:: ; address name
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X9:: ; heuristic: map screen stream; C0
Data_04C_6718:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132718, $9B

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y6X9:: ; heuristic: map screen stream; C0
Data_04C_67B3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1327B3, $87

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X10:: ; heuristic: map screen stream; C0
Data_04C_683A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13283A, $94

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y6X11:: ; heuristic: map screen stream; C0
Data_04C_68CE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1328CE, $53

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X0:: ; heuristic: map screen stream; C0
Data_04C_6921:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X1:: ; heuristic: map screen stream; C0
Data_04C_693E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13293E, $72

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X2:: ; heuristic: map screen stream; C0
Data_04C_69B0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1329B0, $95

; LZSS-compressed asset: 144 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X3:: ; heuristic: map screen stream; C0
Data_04C_6A45:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132A45, $90

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X4:: ; heuristic: map screen stream; C0
Data_04C_6AD5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132AD5, $9E

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X5:: ; heuristic: map screen stream; C0
Data_04C_6B73:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132B73, $94

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X6:: ; heuristic: map screen stream; C0
Data_04C_6C07:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132C07, $A4

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X7:: ; heuristic: map screen stream; C0
Data_04C_6CAB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132CAB, $47

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y7X7:: ; heuristic: map screen stream; C0
Data_04C_6CF2:: ; address name
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X8:: ; heuristic: map screen stream; C0
Data_04C_6D0E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132D0E, $7E

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y7X8:: ; heuristic: map screen stream; C0
Data_04C_6D8C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132D8C, $8A

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X9:: ; heuristic: map screen stream; C0
Data_04C_6E16:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132E16, $C2

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y7X9:: ; heuristic: map screen stream; C0
Data_04C_6ED8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132ED8, $AD

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X10:: ; heuristic: map screen stream; C0
Data_04C_6F85:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $132F85, $83

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y7X11:: ; heuristic: map screen stream; C0
Data_04C_7008:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X0:: ; heuristic: map screen stream; C0
Data_04C_7025:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X1:: ; heuristic: map screen stream; C0
Data_04C_7042:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X2:: ; heuristic: map screen stream; C0
Data_04C_705F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13305F, $6E

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X3:: ; heuristic: map screen stream; C0
Data_04C_70CD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1330CD, $95

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X4:: ; heuristic: map screen stream; C0
Data_04C_7162:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133162, $87

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X5:: ; heuristic: map screen stream; C0
Data_04C_71E9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1331E9, $4D

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y8X5:: ; heuristic: map screen stream; C0
Data_04C_7236:: ; address name
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X6:: ; heuristic: map screen stream; C0
Data_04C_7252:: ; address name
    db $68, $01, $02, $00, $01, $02, $00, $0E

; LZSS-compressed asset: 225 bytes expand to 258 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04C_725A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $13325A, $4E

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y8X6:: ; heuristic: map screen stream; C0
Data_04C_72A8:: ; address name
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X7:: ; heuristic: map screen stream; C0
Data_04C_72C4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1332C4, $77

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y8X7:: ; heuristic: map screen stream; C0
Data_04C_733B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13333B, $45

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X8:: ; heuristic: map screen stream; C0
Data_04C_7380:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133380, $83

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens2_Y8X8:: ; heuristic: map screen stream; C0
Data_04C_7403:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133403, $4E

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X9:: ; heuristic: map screen stream; C0
Data_04C_7451:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133451, $8F

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X10:: ; heuristic: map screen stream; C0
Data_04C_74E0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1334E0, $58

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y8X11:: ; heuristic: map screen stream; C0
Data_04C_7538:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X0:: ; heuristic: map screen stream; C0
Data_04C_7555:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X1:: ; heuristic: map screen stream; C0
Data_04C_7572:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133572, $4C

; LZSS-compressed asset: 181 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X2:: ; heuristic: map screen stream; C0
Data_04C_75BE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1335BE, $B5

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X3:: ; heuristic: map screen stream; C0
Data_04C_7673:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133673, $A4

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X4:: ; heuristic: map screen stream; C0
Data_04C_7717:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133717, $DD

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X5:: ; heuristic: map screen stream; C0
Data_04C_77F4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1337F4, $8F

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X6:: ; heuristic: map screen stream; C0
Data_04C_7883:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133883, $87

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X7:: ; heuristic: map screen stream; C0
Data_04C_790A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13390A, $C0

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X8:: ; heuristic: map screen stream; C0
Data_04C_79CA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1339CA, $A2

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X9:: ; heuristic: map screen stream; C0
Data_04C_7A6C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133A6C, $BB

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X10:: ; heuristic: map screen stream; C0
Data_04C_7B27:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133B27, $94

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y9X11:: ; heuristic: map screen stream; C0
Data_04C_7BBB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133BBB, $55

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y10X0:: ; heuristic: map screen stream; C0
Data_04C_7C10:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133C10, $55

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y10X1:: ; heuristic: map screen stream; C0
Data_04C_7C65:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133C65, $AD

; LZSS-compressed asset: 184 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y10X2:: ; heuristic: map screen stream; C0
Data_04C_7D12:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133D12, $B8

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y10X3:: ; heuristic: map screen stream; C0
Data_04C_7DCA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133DCA, $BF

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y10X4:: ; heuristic: map screen stream; C0
Data_04C_7E89:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133E89, $C0

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map48Screens0_Y10X5:: ; heuristic: map screen stream; C0
Data_04C_7F49:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $133F49, $77
    ds $40, $00
