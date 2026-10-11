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
    dfar Data_050_41F1 ; entry 0
    dfar Data_050_420E ; entry 1
    dfar Data_050_42AA ; entry 2
    dfar Data_050_4369 ; entry 3
    dfar Data_050_4434 ; entry 4
    dfar Data_050_44E5 ; entry 5
    dfar Data_050_41F1 ; entry 6
    dfar Data_050_41F1 ; entry 7
    dfar Data_050_41F1 ; entry 8
    dfar Data_050_41F1 ; entry 9
    dfar Data_050_41F1 ; entry 10
    dfar Data_050_41F1 ; entry 11
    dfar Data_050_41F1 ; entry 12
    dfar Data_050_455E ; entry 13
    dfar Data_050_4622 ; entry 14
    dfar Data_050_41F1 ; entry 15
    dfar Data_050_46C9 ; entry 16
    dfar Data_050_4791 ; entry 17
    dfar Data_050_484C ; entry 18
    dfar Data_050_41F1 ; entry 19
    dfar Data_050_41F1 ; entry 20
    dfar Data_050_41F1 ; entry 21
    dfar Data_050_48DD ; entry 22
    dfar Data_050_49A9 ; entry 23
    dfar Data_050_41F1 ; entry 24
    dfar Data_050_4A51 ; entry 25
    dfar Data_050_41F1 ; entry 26
    dfar Data_050_41F1 ; entry 27
    dfar Data_050_4B42 ; entry 28
    dfar Data_050_4C20 ; entry 29
    dfar Data_050_4CCD ; entry 30
    dfar Data_050_4D91 ; entry 31
    dfar Data_050_41F1 ; entry 32
    dfar Data_050_41F1 ; entry 33
    dfar Data_050_4E4F ; entry 34
    dfar Data_050_4EF0 ; entry 35
    dfar Data_050_41F1 ; entry 36
    dfar Data_050_41F1 ; entry 37
    dfar Data_050_4F87 ; entry 38
    dfar Data_050_5025 ; entry 39
    dfar Data_050_41F1 ; entry 40
    dfar Data_050_5104 ; entry 41
    dfar Data_050_5186 ; entry 42
    dfar Data_050_525D ; entry 43
    dfar Data_050_534C ; entry 44
    dfar Data_050_53E7 ; entry 45
    dfar Data_050_5485 ; entry 46
    dfar Data_050_5529 ; entry 47
    dfar Data_050_55D3 ; entry 48
    dfar Data_050_5694 ; entry 49
    dfar Data_050_5761 ; entry 50
    dfar Data_050_5823 ; entry 51
    dfar Data_050_58CC ; entry 52
    dfar Data_050_41F1 ; entry 53
    dfar Data_050_594B ; entry 54
    dfar Data_050_41F1 ; entry 55
    dfar Data_050_5A13 ; entry 56
    dfar Data_050_5ABD ; entry 57
    dfar Data_050_5B7C ; entry 58
    dfar Data_050_5C42 ; entry 59
    dfar Data_050_5D42 ; entry 60
    dfar Data_050_5DB3 ; entry 61
    dfar Data_050_5EA5 ; entry 62
    dfar Data_050_5F57 ; entry 63
    dfar Data_050_6007 ; entry 64
    dfar Data_050_41F1 ; entry 65
    dfar Data_050_60F2 ; entry 66
    dfar Data_050_6199 ; entry 67
    dfar Data_050_6242 ; entry 68
    dfar Data_050_631D ; entry 69
    dfar Data_050_41F1 ; entry 70
    dfar Data_050_41F1 ; entry 71
    dfar Data_050_41F1 ; entry 72
    dfar Data_050_63D9 ; entry 73
    dfar Data_050_64C3 ; entry 74
    dfar Data_050_653D ; entry 75
    dfar Data_050_65B1 ; entry 76
    dfar Data_050_667C ; entry 77
    dfar Data_050_6749 ; entry 78
    dfar Data_050_67EF ; entry 79
    dfar Data_050_68BF ; entry 80
    dfar Data_050_6961 ; entry 81
    dfar Data_050_41F1 ; entry 82
    dfar Data_050_41F1 ; entry 83
    dfar Data_050_41F1 ; entry 84
    dfar Data_050_6A23 ; entry 85
    dfar Data_050_6A97 ; entry 86
    dfar Data_050_6B7B ; entry 87
    dfar Data_050_6C12 ; entry 88
    dfar Data_050_6CBC ; entry 89
    dfar Data_050_6D67 ; entry 90
    dfar Data_050_6E08 ; entry 91
    dfar Data_050_6E67 ; entry 92
    dfar Data_050_6F0B ; entry 93
    dfar Data_050_41F1 ; entry 94
    dfar Data_050_41F1 ; entry 95
    dfar Data_050_6FD0 ; entry 96
    dfar Data_050_7058 ; entry 97
    dfar Data_050_41F1 ; entry 98
    dfar Data_050_710C ; entry 99
    dfar Data_050_71DC ; entry 100
    dfar Data_050_7294 ; entry 101
    dfar Data_050_730E ; entry 102
    dfar Data_050_73B7 ; entry 103
    dfar Data_050_744B ; entry 104
    dfar Data_050_7522 ; entry 105
    dfar Data_050_41F1 ; entry 106
    dfar Data_050_41F1 ; entry 107
    dfar Data_050_75F1 ; entry 108
    dfar Data_050_7684 ; entry 109
    dfar Data_050_41F1 ; entry 110
    dfar Data_050_41F1 ; entry 111
    dfar Data_050_7721 ; entry 112
    dfar Data_050_7823 ; entry 113
    dfar Data_050_78D4 ; entry 114
    dfar Data_050_79BB ; entry 115
    dfar Data_050_7AA8 ; entry 116
    dfar Data_050_7B77 ; entry 117
    dfar Data_050_7C1D ; entry 118
    dfar Data_050_7D16 ; entry 119
    dfar Data_050_7E09 ; entry 120
    dfar Data_050_7EB4 ; entry 121
    dfar Data_051_4001 ; entry 122
    dfar Data_051_408A ; entry 123
    dfar Data_051_4168 ; entry 124
    dfar Data_051_41F3 ; entry 125
    dfar Data_051_42D9 ; entry 126
    dfar Data_050_41F1 ; entry 127
    dfar Data_050_41F1 ; entry 128
    dfar Data_051_43BD ; entry 129
    dfar Data_051_447E ; entry 130
    dfar Data_051_456D ; entry 131
    dfar Data_051_4641 ; entry 132
    dfar Data_051_46DB ; entry 133
    dfar Data_051_4781 ; entry 134
    dfar Data_051_484C ; entry 135
    dfar Data_051_490B ; entry 136
    dfar Data_051_49C7 ; entry 137
    dfar Data_051_4A81 ; entry 138
    dfar Data_050_41F1 ; entry 139
    dfar Data_050_41F1 ; entry 140
    dfar Data_050_41F1 ; entry 141
    dfar Data_051_4B22 ; entry 142
    dfar Data_051_4BD5 ; entry 143

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_41F1:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $28, $29, $00, $00, $0E, $38, $39, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_420E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14020E, $9C

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_42AA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1402AA, $BF

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4369:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140369, $54

Data_050_43BD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1403BD, $77

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4434:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140434, $4A

Data_050_447E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14047E, $67

; LZSS-compressed asset: 121 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_44E5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1404E5, $79

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_455E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $02, $28, $29, $28, $29, $06, $07, $40, $41, $02, $06, $00, $42

Data_050_456D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14056D, $B5

; LZSS-compressed asset: 167 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4622:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $00, $42, $43, $42, $43, $40, $41, $40, $41, $24, $25, $04, $05, $28
    db $29, $00, $0C, $02, $52, $53, $52, $53, $50, $51, $50, $51, $34, $35, $14

Data_050_4641:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $140641, $88

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_46C9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $02, $28, $29, $06, $07, $2A, $2B, $02, $04, $02, $42, $43, $02, $0C
    db $02, $38

Data_050_46DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1406DB, $A6

Data_050_4781:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $18, $02, $F0, $00, $02, $C8, $0A, $02, $2A, $12, $02, $DC, $0A, $54, $55

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4791:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140791, $BB

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_484C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14084C, $91

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_48DD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $04, $28, $29, $04, $00, $00, $00, $01, $02, $03, $04, $08, $06, $38
    db $39, $04, $14, $00, $10, $11, $12, $13, $04, $1C, $06, $04, $02, $02, $26, $27
    db $40, $41, $04, $30, $00, $2A, $2B, $04, $36, $00, $04, $16, $02, $36

Data_050_490B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14090B, $9E

; LZSS-compressed asset: 168 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_49A9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $00, $02, $03, $04, $05, $28, $29, $00, $04, $0A, $12, $13, $14, $15
    db $38, $39, $00, $18, $0A, $2A, $2B, $24, $25, $00, $00, $0C, $3A, $3B

Data_050_49C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1409C7, $8A

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4A51:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $24, $28, $29, $24, $00, $02, $00, $01, $02, $03, $24, $0A, $02, $04
    db $05, $38, $39, $24, $14, $02, $10, $11, $12, $13, $24, $1E, $02, $14, $15, $24
    db $04, $04, $26, $27, $2A, $2B, $2C, $2D, $40, $41, $40, $41, $08, $09, $24, $18

Data_050_4A81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $140A81, $C1

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4B42:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140B42, $DE

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4C20:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140C20, $AD

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4CCD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140CCD, $C4

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4D91:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140D91, $BE

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4E4F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140E4F, $A1

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4EF0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140EF0, $97

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4F87:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140F87, $9E

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5025:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $141025, $DF

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5104:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $141104, $82

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5186:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141186, $D7

; LZSS-compressed asset: 239 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_525D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14125D, $EF

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_534C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14134C, $9B

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_53E7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1413E7, $9E

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5485:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141485, $A4

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5529:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $141529, $AA

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_55D3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1415D3, $C1

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5694:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $141694, $CD

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5761:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141761, $C2

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5823:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $141823, $A9

; LZSS-compressed asset: 127 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_58CC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1418CC, $7F

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_594B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14194B, $C8

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5A13:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $141A13, $AA

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5ABD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141ABD, $BF

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5B7C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $141B7C, $C6

; LZSS-compressed asset: 256 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5C42:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141C42, $100

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5D42:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $141D42, $71

; LZSS-compressed asset: 242 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5DB3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141DB3, $F2

; LZSS-compressed asset: 178 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5EA5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $141EA5, $B2

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5F57:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141F57, $B0

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6007:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142007, $EB

; LZSS-compressed asset: 167 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_60F2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1420F2, $A7

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6199:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $142199, $A9

; LZSS-compressed asset: 219 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6242:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142242, $DB

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_631D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14231D, $BC

; LZSS-compressed asset: 234 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_63D9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1423D9, $EA

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_64C3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1424C3, $7A

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_653D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14253D, $74

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_65B1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1425B1, $CB

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_667C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14267C, $CD

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6749:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142749, $A6

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_67EF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1427EF, $D0

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_68BF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1428BF, $A2

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6961:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142961, $C2

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6A23:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142A23, $74

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6A97:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142A97, $E4

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6B7B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142B7B, $97

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6C12:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142C12, $AA

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6CBC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142CBC, $AB

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6D67:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142D67, $A1

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6E08:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142E08, $5F

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6E67:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142E67, $A4

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6F0B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $142F0B, $C5

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6FD0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $142FD0, $88

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7058:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $143058, $B4

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_710C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14310C, $D0

; LZSS-compressed asset: 184 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_71DC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1431DC, $B8

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7294:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $143294, $7A

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_730E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14330E, $A9

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_73B7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1433B7, $94

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_744B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14344B, $D7

; LZSS-compressed asset: 207 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7522:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $143522, $CF

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_75F1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1435F1, $93

; LZSS-compressed asset: 157 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7684:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $143684, $9D

; LZSS-compressed asset: 258 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7721:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $143721, $102

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7823:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $143823, $B1

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_78D4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1438D4, $E7

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_79BB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1439BB, $ED

; LZSS-compressed asset: 207 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7AA8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $143AA8, $CF

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7B77:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $143B77, $A6

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7C1D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $143C1D, $F9

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7D16:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $143D16, $F3

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7E09:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $143E09, $AB

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7EB4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $143EB4, $C8
    ds $84, $00
