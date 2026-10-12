SECTION "Bank 50", ROMX[$4000], BANK[$50]
    db $50

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map70Palettes::
Data_050_4001:: ; address name
    dw $7DA0, $7FFF, $01D3, $0063 ; entry 0
    dw $01D3, $7FFF, $0348, $0006 ; entry 1
    dw $01C4, $03FF, $0348, $0084 ; entry 2
    dw $01C4, $7FFF, $0348, $0084 ; entry 3
    dw $001F, $7FFF, $0348, $0000 ; entry 4
    dw $00D0, $01D9, $0348, $0084 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 144 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map70Screens0::
Data_050_4041:: ; address name
    dfar Map70Screens0_Y0X0 ; entry 0
    dfar Map70Screens0_Y0X1 ; entry 1
    dfar Map70Screens0_Y0X2 ; entry 2
    dfar Map70Screens0_Y0X3 ; entry 3
    dfar Map70Screens0_Y0X4 ; entry 4
    dfar Map70Screens0_Y0X5 ; entry 5
    dfar Map70Screens0_Y0X0 ; entry 6
    dfar Map70Screens0_Y0X0 ; entry 7
    dfar Map70Screens0_Y0X0 ; entry 8
    dfar Map70Screens0_Y0X0 ; entry 9
    dfar Map70Screens0_Y0X0 ; entry 10
    dfar Map70Screens0_Y0X0 ; entry 11
    dfar Map70Screens0_Y0X0 ; entry 12
    dfar Map70Screens0_Y1X1 ; entry 13
    dfar Map70Screens0_Y1X2 ; entry 14
    dfar Map70Screens0_Y0X0 ; entry 15
    dfar Map70Screens0_Y1X4 ; entry 16
    dfar Map70Screens0_Y1X5 ; entry 17
    dfar Map70Screens0_Y1X6 ; entry 18
    dfar Map70Screens0_Y0X0 ; entry 19
    dfar Map70Screens0_Y0X0 ; entry 20
    dfar Map70Screens0_Y0X0 ; entry 21
    dfar Map70Screens0_Y1X10 ; entry 22
    dfar Map70Screens0_Y1X11 ; entry 23
    dfar Map70Screens0_Y0X0 ; entry 24
    dfar Map70Screens0_Y2X1 ; entry 25
    dfar Map70Screens0_Y0X0 ; entry 26
    dfar Map70Screens0_Y0X0 ; entry 27
    dfar Map70Screens0_Y2X4 ; entry 28
    dfar Map70Screens0_Y2X5 ; entry 29
    dfar Map70Screens0_Y2X6 ; entry 30
    dfar Map70Screens0_Y2X7 ; entry 31
    dfar Map70Screens0_Y0X0 ; entry 32
    dfar Map70Screens0_Y0X0 ; entry 33
    dfar Map70Screens0_Y2X10 ; entry 34
    dfar Map70Screens0_Y2X11 ; entry 35
    dfar Map70Screens0_Y0X0 ; entry 36
    dfar Map70Screens0_Y0X0 ; entry 37
    dfar Map70Screens0_Y3X2 ; entry 38
    dfar Map70Screens0_Y3X3 ; entry 39
    dfar Map70Screens0_Y0X0 ; entry 40
    dfar Map70Screens0_Y3X5 ; entry 41
    dfar Map70Screens0_Y3X6 ; entry 42
    dfar Map70Screens0_Y3X7 ; entry 43
    dfar Map70Screens0_Y3X8 ; entry 44
    dfar Map70Screens0_Y3X9 ; entry 45
    dfar Map70Screens0_Y3X10 ; entry 46
    dfar Map70Screens0_Y3X11 ; entry 47
    dfar Map70Screens0_Y4X0 ; entry 48
    dfar Map70Screens0_Y4X1 ; entry 49
    dfar Map70Screens0_Y4X2 ; entry 50
    dfar Map70Screens0_Y4X3 ; entry 51
    dfar Map70Screens0_Y4X4 ; entry 52
    dfar Map70Screens0_Y0X0 ; entry 53
    dfar Map70Screens0_Y4X6 ; entry 54
    dfar Map70Screens0_Y0X0 ; entry 55
    dfar Map70Screens0_Y4X8 ; entry 56
    dfar Map70Screens0_Y4X9 ; entry 57
    dfar Map70Screens0_Y4X10 ; entry 58
    dfar Map70Screens0_Y4X11 ; entry 59
    dfar Map70Screens0_Y5X0 ; entry 60
    dfar Map70Screens0_Y5X1 ; entry 61
    dfar Map70Screens0_Y5X2 ; entry 62
    dfar Map70Screens0_Y5X3 ; entry 63
    dfar Map70Screens0_Y5X4 ; entry 64
    dfar Map70Screens0_Y0X0 ; entry 65
    dfar Map70Screens0_Y5X6 ; entry 66
    dfar Map70Screens0_Y5X7 ; entry 67
    dfar Map70Screens0_Y5X8 ; entry 68
    dfar Map70Screens0_Y5X9 ; entry 69
    dfar Map70Screens0_Y0X0 ; entry 70
    dfar Map70Screens0_Y0X0 ; entry 71
    dfar Map70Screens0_Y0X0 ; entry 72
    dfar Map70Screens0_Y6X1 ; entry 73
    dfar Map70Screens0_Y6X2 ; entry 74
    dfar Map70Screens0_Y6X3 ; entry 75
    dfar Map70Screens0_Y6X4 ; entry 76
    dfar Map70Screens0_Y6X5 ; entry 77
    dfar Map70Screens0_Y6X6 ; entry 78
    dfar Map70Screens0_Y6X7 ; entry 79
    dfar Map70Screens0_Y6X8 ; entry 80
    dfar Map70Screens0_Y6X9 ; entry 81
    dfar Map70Screens0_Y0X0 ; entry 82
    dfar Map70Screens0_Y0X0 ; entry 83
    dfar Map70Screens0_Y0X0 ; entry 84
    dfar Map70Screens0_Y7X1 ; entry 85
    dfar Map70Screens0_Y7X2 ; entry 86
    dfar Map70Screens0_Y7X3 ; entry 87
    dfar Map70Screens0_Y7X4 ; entry 88
    dfar Map70Screens0_Y7X5 ; entry 89
    dfar Map70Screens0_Y7X6 ; entry 90
    dfar Map70Screens0_Y7X7 ; entry 91
    dfar Map70Screens0_Y7X8 ; entry 92
    dfar Map70Screens0_Y7X9 ; entry 93
    dfar Map70Screens0_Y0X0 ; entry 94
    dfar Map70Screens0_Y0X0 ; entry 95
    dfar Map70Screens0_Y8X0 ; entry 96
    dfar Map70Screens0_Y8X1 ; entry 97
    dfar Map70Screens0_Y0X0 ; entry 98
    dfar Map70Screens0_Y8X3 ; entry 99
    dfar Map70Screens0_Y8X4 ; entry 100
    dfar Map70Screens0_Y8X5 ; entry 101
    dfar Map70Screens0_Y8X6 ; entry 102
    dfar Map70Screens0_Y8X7 ; entry 103
    dfar Map70Screens0_Y8X8 ; entry 104
    dfar Map70Screens0_Y8X9 ; entry 105
    dfar Map70Screens0_Y0X0 ; entry 106
    dfar Map70Screens0_Y0X0 ; entry 107
    dfar Map70Screens0_Y9X0 ; entry 108
    dfar Map70Screens0_Y9X1 ; entry 109
    dfar Map70Screens0_Y0X0 ; entry 110
    dfar Map70Screens0_Y0X0 ; entry 111
    dfar Map70Screens0_Y9X4 ; entry 112
    dfar Map70Screens0_Y9X5 ; entry 113
    dfar Map70Screens0_Y9X6 ; entry 114
    dfar Map70Screens0_Y9X7 ; entry 115
    dfar Map70Screens0_Y9X8 ; entry 116
    dfar Map70Screens0_Y9X9 ; entry 117
    dfar Map70Screens0_Y9X10 ; entry 118
    dfar Map70Screens0_Y9X11 ; entry 119
    dfar Map70Screens0_Y10X0 ; entry 120
    dfar Map70Screens0_Y10X1 ; entry 121
    dfar Map70Screens0_Y10X2 ; entry 122
    dfar Map70Screens0_Y10X3 ; entry 123
    dfar Map70Screens0_Y10X4 ; entry 124
    dfar Map70Screens0_Y10X5 ; entry 125
    dfar Map70Screens0_Y10X6 ; entry 126
    dfar Map70Screens0_Y0X0 ; entry 127
    dfar Map70Screens0_Y0X0 ; entry 128
    dfar Map70Screens0_Y10X9 ; entry 129
    dfar Map70Screens0_Y10X10 ; entry 130
    dfar Map70Screens0_Y10X11 ; entry 131
    dfar Map70Screens0_Y11X0 ; entry 132
    dfar Map70Screens0_Y11X1 ; entry 133
    dfar Map70Screens0_Y11X2 ; entry 134
    dfar Map70Screens0_Y11X3 ; entry 135
    dfar Map70Screens0_Y11X4 ; entry 136
    dfar Map70Screens0_Y11X5 ; entry 137
    dfar Map70Screens0_Y11X6 ; entry 138
    dfar Map70Screens0_Y0X0 ; entry 139
    dfar Map70Screens0_Y0X0 ; entry 140
    dfar Map70Screens0_Y0X0 ; entry 141
    dfar Map70Screens0_Y11X10 ; entry 142
    dfar Map70Screens0_Y11X11 ; entry 143

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_050_41F1:: ; address name
    db $68, $01, $00, $28, $29, $00, $00, $0E, $38, $39, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y0X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_420E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14020E, $9C

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y0X2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_42AA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1402AA, $BF

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y0X3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4369:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140369, $CB

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y0X4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4434:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140434, $B1

; LZSS-compressed asset: 121 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y0X5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_44E5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1404E5, $79

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y1X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_455E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14055E, $C4

; LZSS-compressed asset: 167 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y1X2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4622:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140622, $A7

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y1X4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_46C9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1406C9, $C8

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y1X5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4791:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140791, $BB

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y1X6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_484C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14084C, $91

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y1X10:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_48DD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1408DD, $CC

; LZSS-compressed asset: 168 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y1X11:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_49A9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1409A9, $A8

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y2X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4A51:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140A51, $F1

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y2X4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4B42:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140B42, $DE

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y2X5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4C20:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140C20, $AD

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y2X6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4CCD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140CCD, $C4

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y2X7:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4D91:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140D91, $BE

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y2X10:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4E4F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140E4F, $A1

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y2X11:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4EF0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140EF0, $97

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y3X2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_4F87:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $140F87, $9E

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y3X3:: ; heuristic: map screen stream; C0
Data_050_5025:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141025, $DF

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y3X5:: ; heuristic: map screen stream; C0
Data_050_5104:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141104, $82

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y3X6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_5186:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141186, $D7

; LZSS-compressed asset: 239 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y3X7:: ; heuristic: map screen stream; C0
Data_050_525D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14125D, $EF

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y3X8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_534C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14134C, $9B

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y3X9:: ; heuristic: map screen stream; C0
Data_050_53E7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1413E7, $9E

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y3X10:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_5485:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141485, $A4

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y3X11:: ; heuristic: map screen stream; C0
Data_050_5529:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141529, $AA

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y4X0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_55D3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1415D3, $C1

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y4X1:: ; heuristic: map screen stream; C0
Data_050_5694:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141694, $CD

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y4X2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_5761:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141761, $C2

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y4X3:: ; heuristic: map screen stream; C0
Data_050_5823:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141823, $A9

; LZSS-compressed asset: 127 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y4X4:: ; heuristic: map screen stream; C0
Data_050_58CC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1418CC, $7F

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y4X6:: ; heuristic: map screen stream; C0
Data_050_594B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14194B, $C8

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y4X8:: ; heuristic: map screen stream; C0
Data_050_5A13:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141A13, $AA

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y4X9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_5ABD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141ABD, $BF

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y4X10:: ; heuristic: map screen stream; C0
Data_050_5B7C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141B7C, $C6

; LZSS-compressed asset: 256 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y4X11:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_5C42:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141C42, $100

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y5X0:: ; heuristic: map screen stream; C0
Data_050_5D42:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141D42, $71

; LZSS-compressed asset: 242 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y5X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_5DB3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141DB3, $F2

; LZSS-compressed asset: 178 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y5X2:: ; heuristic: map screen stream; C0
Data_050_5EA5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141EA5, $B2

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y5X3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_5F57:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $141F57, $B0

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y5X4:: ; heuristic: map screen stream; C0
Data_050_6007:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142007, $EB

; LZSS-compressed asset: 167 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y5X6:: ; heuristic: map screen stream; C0
Data_050_60F2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1420F2, $A7

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y5X7:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_6199:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142199, $A9

; LZSS-compressed asset: 219 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y5X8:: ; heuristic: map screen stream; C0
Data_050_6242:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142242, $DB

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y5X9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_631D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14231D, $BC

; LZSS-compressed asset: 234 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y6X1:: ; heuristic: map screen stream; C0
Data_050_63D9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1423D9, $EA

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y6X2:: ; heuristic: map screen stream; C0
Data_050_64C3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1424C3, $7A

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y6X3:: ; heuristic: map screen stream; C0
Data_050_653D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14253D, $74

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y6X4:: ; heuristic: map screen stream; C0
Data_050_65B1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1425B1, $CB

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y6X5:: ; heuristic: map screen stream; C0
Data_050_667C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14267C, $CD

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y6X6:: ; heuristic: map screen stream; C0
Data_050_6749:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142749, $A6

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y6X7:: ; heuristic: map screen stream; C0
Data_050_67EF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1427EF, $D0

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y6X8:: ; heuristic: map screen stream; C0
Data_050_68BF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1428BF, $A2

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y6X9:: ; heuristic: map screen stream; C0
Data_050_6961:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142961, $C2

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y7X1:: ; heuristic: map screen stream; C0
Data_050_6A23:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142A23, $74

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y7X2:: ; heuristic: map screen stream; C0
Data_050_6A97:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142A97, $E4

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y7X3:: ; heuristic: map screen stream; C0
Data_050_6B7B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142B7B, $97

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y7X4:: ; heuristic: map screen stream; C0
Data_050_6C12:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142C12, $AA

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y7X5:: ; heuristic: map screen stream; C0
Data_050_6CBC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142CBC, $AB

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y7X6:: ; heuristic: map screen stream; C0
Data_050_6D67:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142D67, $A1

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y7X7:: ; heuristic: map screen stream; C0
Data_050_6E08:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142E08, $5F

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y7X8:: ; heuristic: map screen stream; C0
Data_050_6E67:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142E67, $A4

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y7X9:: ; heuristic: map screen stream; C0
Data_050_6F0B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142F0B, $C5

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y8X0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_6FD0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $142FD0, $88

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y8X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_7058:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143058, $B4

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y8X3:: ; heuristic: map screen stream; C0
Data_050_710C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14310C, $D0

; LZSS-compressed asset: 184 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y8X4:: ; heuristic: map screen stream; C0
Data_050_71DC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1431DC, $B8

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y8X5:: ; heuristic: map screen stream; C0
Data_050_7294:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143294, $7A

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y8X6:: ; heuristic: map screen stream; C0
Data_050_730E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14330E, $A9

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y8X7:: ; heuristic: map screen stream; C0
Data_050_73B7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1433B7, $94

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y8X8:: ; heuristic: map screen stream; C0
Data_050_744B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14344B, $D7

; LZSS-compressed asset: 207 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y8X9:: ; heuristic: map screen stream; C0
Data_050_7522:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143522, $CF

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y9X0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_75F1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1435F1, $93

; LZSS-compressed asset: 157 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y9X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_050_7684:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143684, $9D

; LZSS-compressed asset: 258 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y9X4:: ; heuristic: map screen stream; C0
Data_050_7721:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143721, $102

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y9X5:: ; heuristic: map screen stream; C0
Data_050_7823:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143823, $B1

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y9X6:: ; heuristic: map screen stream; C0
Data_050_78D4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1438D4, $E7

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y9X7:: ; heuristic: map screen stream; C0
Data_050_79BB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1439BB, $ED

; LZSS-compressed asset: 207 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y9X8:: ; heuristic: map screen stream; C0
Data_050_7AA8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143AA8, $CF

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y9X9:: ; heuristic: map screen stream; C0
Data_050_7B77:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143B77, $A6

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y9X10:: ; heuristic: map screen stream; C0
Data_050_7C1D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143C1D, $F9

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y9X11:: ; heuristic: map screen stream; C0
Data_050_7D16:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143D16, $F3

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y10X0:: ; heuristic: map screen stream; C0
Data_050_7E09:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143E09, $AB

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Screens0_Y10X1:: ; heuristic: map screen stream; C0
Data_050_7EB4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $143EB4, $C8
    ds $84, $00
