SECTION "Bank 4A", ROMX[$4000], BANK[$4A]
    db $4A

; compressed tileset of map $20 (the first map record using it)
; LZSS-compressed asset: 672 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map20Tileset:: ; heuristic: map tileset stream; C0
Data_04A_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $128001, $2A0

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map20Palettes::
Data_04A_42A1:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $0152, $3F7F, $0218, $00C8 ; entry 1
    dw $026E, $3F7F, $02F3, $0188 ; entry 2
    dw $2130, $3F7F, $39D9, $00C8 ; entry 3
    dw $0018, $3F7F, $0218, $00C8 ; entry 4
    dw $7C01, $3F7F, $7FE1, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 64 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map20Screens0::
Data_04A_42E1:: ; heuristic: map screen array; C0
    dfar Data_04A_4461 ; entry 0
    dfar Data_04A_44D2 ; entry 1
    dfar Data_04A_4548 ; entry 2
    dfar Data_04A_45A8 ; entry 3
    dfar Data_04A_461E ; entry 4
    dfar Data_04A_466F ; entry 5
    dfar Data_04A_46F9 ; entry 6
    dfar Data_04A_4763 ; entry 7
    dfar Data_04A_47D8 ; entry 8
    dfar Data_04A_4850 ; entry 9
    dfar Data_04A_48DA ; entry 10
    dfar Data_04A_49A0 ; entry 11
    dfar Data_04A_4A25 ; entry 12
    dfar Data_04A_4ACE ; entry 13
    dfar Data_04A_4B64 ; entry 14
    dfar Data_04A_4BB2 ; entry 15
    dfar Data_04A_4C38 ; entry 16
    dfar Data_04A_4CA5 ; entry 17
    dfar Data_04A_4D2C ; entry 18
    dfar Data_04A_4DAA ; entry 19
    dfar Data_04A_4E2B ; entry 20
    dfar Data_04A_4EB1 ; entry 21
    dfar Data_04A_4F23 ; entry 22
    dfar Data_04A_4FB1 ; entry 23
    dfar Data_04A_500F ; entry 24
    dfar Data_04A_507B ; entry 25
    dfar Data_04A_5112 ; entry 26
    dfar Data_04A_5184 ; entry 27
    dfar Data_04A_5213 ; entry 28
    dfar Data_04A_5297 ; entry 29
    dfar Data_04A_5330 ; entry 30
    dfar Data_04A_53D4 ; entry 31
    dfar Data_04A_540D ; entry 32
    dfar Data_04A_548F ; entry 33
    dfar Data_04A_550A ; entry 34
    dfar Data_04A_55AC ; entry 35
    dfar Data_04A_5633 ; entry 36
    dfar Data_04A_56AE ; entry 37
    dfar Data_04A_5719 ; entry 38
    dfar Data_04A_57CD ; entry 39
    dfar Data_04A_5835 ; entry 40
    dfar Data_04A_5881 ; entry 41
    dfar Data_04A_5902 ; entry 42
    dfar Data_04A_595F ; entry 43
    dfar Data_04A_59DA ; entry 44
    dfar Data_04A_5A36 ; entry 45
    dfar Data_04A_5AC9 ; entry 46
    dfar Data_04A_5B68 ; entry 47
    dfar Data_04A_5B85 ; entry 48
    dfar Data_04A_5BE6 ; entry 49
    dfar Data_04A_5C5E ; entry 50
    dfar Data_04A_5CF3 ; entry 51
    dfar Data_04A_5D50 ; entry 52
    dfar Data_04A_5DCD ; entry 53
    dfar Data_04A_5E63 ; entry 54
    dfar Data_04A_5F11 ; entry 55
    dfar Data_04A_5F6B ; entry 56
    dfar Data_04A_5F88 ; entry 57
    dfar Data_04A_5FA5 ; entry 58
    dfar Data_04A_601F ; entry 59
    dfar Data_04A_60AD ; entry 60
    dfar Data_04A_6145 ; entry 61
    dfar Data_04A_61A9 ; entry 62
    dfar Data_04A_6214 ; entry 63

; E-0142 (derived: 64 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map20Attrs0::
Data_04A_43A1:: ; heuristic: map screen array; C0
    dfar Data_04A_6289 ; entry 0
    dfar Data_04A_62CA ; entry 1
    dfar Data_04A_6309 ; entry 2
    dfar Data_04A_6341 ; entry 3
    dfar Data_04A_637C ; entry 4
    dfar Data_04A_639E ; entry 5
    dfar Data_04A_63D5 ; entry 6
    dfar Data_04A_63F1 ; entry 7
    dfar Data_04A_6432 ; entry 8
    dfar Data_04A_646A ; entry 9
    dfar Data_04A_648C ; entry 10
    dfar Data_04A_64E9 ; entry 11
    dfar Data_04A_6529 ; entry 12
    dfar Data_04A_656D ; entry 13
    dfar Data_04A_65A6 ; entry 14
    dfar Data_04A_65BA ; entry 15
    dfar Data_04A_65FC ; entry 16
    dfar Data_04A_6627 ; entry 17
    dfar Data_04A_665E ; entry 18
    dfar Data_04A_669B ; entry 19
    dfar Data_04A_66D8 ; entry 20
    dfar Data_04A_66FD ; entry 21
    dfar Data_04A_6711 ; entry 22
    dfar Data_04A_673E ; entry 23
    dfar Data_04A_676B ; entry 24
    dfar Data_04A_6798 ; entry 25
    dfar Data_04A_67E7 ; entry 26
    dfar Data_04A_6827 ; entry 27
    dfar Data_04A_686B ; entry 28
    dfar Data_04A_6898 ; entry 29
    dfar Data_04A_68CF ; entry 30
    dfar Data_04A_690A ; entry 31
    dfar Data_04A_692B ; entry 32
    dfar Data_04A_6960 ; entry 33
    dfar Data_04A_69AE ; entry 34
    dfar Data_04A_69FA ; entry 35
    dfar Data_04A_6A2A ; entry 36
    dfar Data_04A_6A51 ; entry 37
    dfar Data_04A_6A8E ; entry 38
    dfar Data_04A_6AEA ; entry 39
    dfar Data_04A_6B2E ; entry 40
    dfar Data_04A_6B53 ; entry 41
    dfar Data_04A_6B9E ; entry 42
    dfar Data_04A_6BD9 ; entry 43
    dfar Data_04A_6C01 ; entry 44
    dfar Data_04A_6C2A ; entry 45
    dfar Data_04A_6C80 ; entry 46
    dfar Data_04A_6CD3 ; entry 47
    dfar Data_04A_6CE7 ; entry 48
    dfar Data_04A_6D0C ; entry 49
    dfar Data_04A_6D46 ; entry 50
    dfar Data_04A_6D7E ; entry 51
    dfar Data_04A_6D98 ; entry 52
    dfar Data_04A_6DC2 ; entry 53
    dfar Data_04A_6E07 ; entry 54
    dfar Data_04A_6E60 ; entry 55
    dfar Data_04A_6E95 ; entry 56
    dfar Data_04A_6EA9 ; entry 57
    dfar Data_04A_6EBD ; entry 58
    dfar Data_04A_6EFC ; entry 59
    dfar Data_04A_6F2B ; entry 60
    dfar Data_04A_6F5B ; entry 61
    dfar Data_04A_6F81 ; entry 62
    dfar Data_04A_6FC3 ; entry 63

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4461:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128461, $71

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_44D2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1284D2, $76

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4548:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128548, $60

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_45A8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1285A8, $76

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_461E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12861E, $51

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_466F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12866F, $8A

; LZSS-compressed asset: 106 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_46F9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1286F9, $6A

; LZSS-compressed asset: 117 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4763:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128763, $75

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_47D8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1287D8, $78

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4850:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128850, $8A

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_48DA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1288DA, $C6

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_49A0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1289A0, $85

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4A25:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128A25, $A9

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4ACE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128ACE, $96

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4B64:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128B64, $4E

; LZSS-compressed asset: 134 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4BB2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128BB2, $86

; LZSS-compressed asset: 109 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4C38:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128C38, $6D

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4CA5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128CA5, $87

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4D2C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128D2C, $7E

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4DAA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128DAA, $81

; LZSS-compressed asset: 134 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4E2B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128E2B, $86

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4EB1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128EB1, $72

; LZSS-compressed asset: 142 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4F23:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128F23, $8E

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_4FB1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $128FB1, $5E

; LZSS-compressed asset: 108 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_500F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $1F, $44, $45, $00, $5A, $00, $40, $41, $40, $41, $00, $14, $06, $54, $55, $00
    db $6E, $00, $50
    dw Data_04A_5051
    db $51
    dw Data_04A_5400
    db $08
    dw Data_04A_5E00
    db $02
    dw Data_04A_6200
    db $04
    dw Data_04A_6E00
    db $02
    dw Data_04A_7200
    db $02
    dw Data_04A_7600
    db $02
    dw Data_04A_7E00
    db $0A, $00, $62, $02, $00, $92, $0A, $00

Data_04A_5051:: ; heuristic: target of a monotone pointer table; C0
    db $76, $00, $00, $7E, $04, $00, $82, $08, $00, $92, $04, $00, $96, $08, $00, $CA
    db $0F, $21, $00, $5E, $04, $00, $DE, $08, $00, $72, $04, $00, $1A, $1A, $44, $45
    db $00, $12, $00, $00, $2E, $1A, $54, $55, $3A, $3B

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_507B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12907B, $97

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5112:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129112, $72

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5184:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129184, $8F

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5213:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129213, $84

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5297:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129297, $99

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5330:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129330, $A4

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_53D4:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $44, $45, $00, $00, $00, $2A, $2B, $00, $06, $08, $54, $55, $00
    db $14, $00, $3A, $3B, $00, $1A, $08, $00, $00, $0F, $41, $00, $06, $0A, $00, $12
    db $02, $00, $1A, $0A, $00, $76, $0F, $17, $00, $7C, $0C, $00

Data_04A_5400:: ; heuristic: target of a monotone pointer table; C0
    db $06, $00, $00, $90, $0C, $00, $C4, $0F, $4D, $00, $FC, $0F, $09

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_540D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12940D, $82

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_548F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12948F, $7B

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_550A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12950A, $A2

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_55AC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1295AC, $87

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5633:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129633, $7B

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_56AE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1296AE, $6B

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5719:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129719, $B4

; LZSS-compressed asset: 104 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_57CD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1297CD, $68

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5835:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129835, $4C

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5881:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129881, $81

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5902:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129902, $5D

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_595F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12995F, $7B

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_59DA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1299DA, $5C

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5A36:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129A36, $93

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5AC9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129AC9, $9F

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5B68:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5B85:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129B85, $61

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5BE6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129BE6, $78

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5C5E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129C5E, $95

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5CF3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129CF3, $5D

; LZSS-compressed asset: 125 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5D50:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129D50, $7D

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5DCD:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $42, $43, $00, $02, $00, $44, $45, $00, $08, $00, $40
    db $41, $00, $0E, $00, $3A, $3B, $52, $53, $00, $16, $00, $54, $55, $00, $1C, $00
    db $50, $51, $00, $22, $00, $00, $00, $02, $00, $08, $02, $00, $0A, $04, $00, $14
    db $02, $00, $1C

Data_04A_5E00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $129E00, $63

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5E63:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129E63, $AE

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5F11:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129F11, $5A

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5F6B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5F88:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_5FA5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $129FA5, $7A

; LZSS-compressed asset: 142 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_601F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A01F, $8E

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_60AD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A0AD, $98

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6145:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A145, $64

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_61A9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A1A9, $57

Data_04A_6200:: ; heuristic: target of a monotone pointer table; C0
    db $06, $00, $64, $06, $00, $C8, $0C, $00, $50, $00, $00, $DC, $0C, $00, $64, $00
    db $00, $F0, $0F, $3D

; LZSS-compressed asset: 117 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6214:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A214, $75

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6289:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A289, $41

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_62CA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $18, $0F, $04, $02, $00, $78, $01
    db $00, $6E, $0C, $00, $7A, $0F, $05, $00, $7C, $04, $00, $9C, $08, $00, $A6, $0F
    db $03, $00, $7A, $02, $00, $C2, $0F, $07, $01, $01, $00, $C2, $0E, $00, $F0, $0F
    db $03, $00, $18, $14, $00, $10, $1E, $00, $20, $1F, $03, $00, $3E, $1F, $0B

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6309:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $18, $0F, $04, $02, $00, $78, $01
    db $00, $6A, $0F, $15, $00, $7C, $0A, $00, $A0, $0F, $09, $00, $7A, $08, $00, $C8
    db $0F, $0D, $00, $7C, $04, $00, $F0, $0F, $01, $01, $00, $18, $11, $00, $0A, $1F
    db $15, $00, $1A, $14, $00, $3A, $1F, $07

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6341:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $20, $01, $01, $00, $22, $0F, $11, $01, $00
    db $5A, $01, $00, $4C, $0F, $15, $00, $34, $0A, $00, $82, $0E, $00, $82, $04, $00
    db $5C, $08, $00, $A8, $0F, $27, $00, $A8, $08, $00, $EE, $0F, $07, $00, $82, $06
    db $00, $12, $1F, $11, $00, $54, $06, $00, $40, $1F, $01

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_637C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $40, $0F, $2C, $01, $00, $A0, $01
    db $00, $92, $0F, $15, $00, $A4, $0A, $00, $C8, $0F, $31, $00, $A4, $08, $00, $18
    db $1F, $29

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_639E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $1E, $01, $01, $01, $01, $00, $22, $0F, $0F
    db $00, $32, $00, $00, $58, $04, $00, $50, $0F, $07, $00, $58, $08, $00, $76, $0F
    db $31, $00, $54, $0A, $00, $C8, $0F, $09, $00, $58, $0F, $11, $00, $7E, $0A, $00
    db $16, $1F, $07, $00, $7C, $0F, $11

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_63D5:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $20, $01, $00, $34, $03, $00, $28, $0F, $01
    db $00, $4F, $0F, $4D, $00, $AF, $0F, $4D, $00, $08, $1F, $45

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_63F1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A3F1, $41

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6432:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $03, $02, $02, $02, $02, $01, $00, $0C, $03, $00
    db $00, $0F, $35, $00, $0A, $04, $00, $50, $0F, $09, $00, $06, $08, $00, $78, $0F
    db $33, $03, $03, $00, $0C, $0C, $00, $D0, $0F, $01, $00, $0C, $04, $00, $EC, $0F
    db $0B, $00, $F8, $08, $00, $16, $1F, $2B

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_646A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $C8, $03, $03, $03, $03, $03, $00, $18, $1F, $0F, $00, $28, $10, $00, $3E
    db $1F, $03

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_648C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A48C, $5D

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_64E9:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $03, $03, $03, $01, $00, $04, $01, $00, $00, $00, $00, $02
    db $02, $00, $00, $0F, $03, $00, $04, $02, $00, $1C, $0F, $0D, $00, $3E, $0F, $07
    db $00, $44, $0F, $07, $00, $70, $0F, $0D, $00, $7E, $0A, $00, $0E, $06, $00, $00
    db $0C, $00, $B8, $0F, $1B, $00, $74, $0E, $00, $98, $0F, $07, $00, $12, $1F, $2F

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6529:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A529, $44

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_656D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $01, $01, $00, $06, $09, $00, $00, $0F, $2B, $00
    db $4E, $02, $00, $52, $04, $00, $4C, $0F, $05, $00, $10, $04, $00, $4A, $06, $00
    db $76, $0F, $07, $00, $6A, $0E, $00, $A2, $0F, $03, $00, $92, $0F, $01, $00, $92
    db $0F, $03, $00, $F5, $0F, $4D, $00, $AA, $0E

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_65A6:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_65BA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A5BA, $42

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_65FC:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $01, $01, $00, $06, $09, $00, $00, $0F, $4D, $00
    db $10, $06, $00, $18, $0A, $00, $78, $0F, $09, $00, $16, $06, $00, $A0, $08, $00
    db $AA, $0F, $03, $00, $D3, $0F, $4D, $00, $08, $1F, $21

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6627:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $09, $03, $00, $0E, $01, $00, $00, $0F, $2F, $00
    db $0E, $02, $00, $56, $04, $00, $50, $0F, $05, $00, $58, $0E, $00, $7A, $0E, $00
    db $56, $0F, $13, $00, $7A, $0F, $13, $00, $52, $08, $00, $02, $0E, $00, $F6, $0E
    db $00, $00, $0A, $00, $16, $1F, $2B

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_665E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $03, $03, $03, $01, $00, $04, $07, $00, $00, $00, $00, $00
    db $0F, $03, $00, $04, $08, $02, $02, $00, $24, $0F, $11, $02, $02, $00, $4A, $0F
    db $07, $00, $52, $0F, $13, $00, $02, $06, $00, $5C, $06, $00, $9E, $0F, $09, $00
    db $5C, $00, $00, $BE, $0F, $37, $00, $CE, $0A, $00, $16, $1F, $2B

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_669B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $03, $01, $00, $08, $07, $00, $00, $0F, $07, $00
    db $08, $08, $00, $26, $0F, $0F, $00, $54, $06, $00, $52, $0F, $09, $00, $52, $08
    db $00, $7A, $0F, $0B, $00, $20, $0E, $00, $AA, $0A, $00, $A6, $0A, $00, $C6, $0F
    db $0B, $00, $1E, $0F, $2B, $00, $20, $0F, $07, $00, $00, $0F, $05

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_66D8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $48, $0F, $34, $03, $03, $00, $96
    db $0F, $11, $00, $A8, $0F, $0F, $00, $A8, $0F, $13, $00, $EE, $0F, $19, $00, $BC
    db $0F, $01, $00, $A8, $0E

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_66FD:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6711:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $26, $0F, $12, $03, $00, $86, $01
    db $00, $78, $0F, $07, $00, $8A, $02, $00, $86, $02, $00, $9E, $0F, $07, $00, $8A
    db $08, $00, $C4, $0F, $09, $00, $F3, $0F, $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_673E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $31, $00
    db $0A, $06, $00, $4E, $0F, $03, $00, $77, $0F, $4D, $00, $90, $0F, $05, $00, $68
    db $0F, $01, $00, $F0, $0F, $05, $00, $6A, $0C, $00, $18, $1F, $29

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_676B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $46, $01, $00, $5A, $05, $00, $50, $0F, $07
    db $00, $5A, $06, $00, $74, $0F, $09, $00, $7E, $0A, $00, $9E, $0F, $05, $00, $A4
    db $0C, $00, $C6, $0F, $4D, $00, $EA, $0F, $05, $00, $A0, $0F, $03

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6798:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A798, $4F

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_67E7:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $01, $01, $01, $02, $00, $04, $01, $03, $00, $0A, $05, $00
    db $00, $0F, $2B, $00, $04, $02, $00, $44, $0F, $0D, $00, $52, $04, $00, $6C, $0F
    db $15, $00, $0A, $06, $00, $9E, $0F, $07, $00, $00, $00, $00, $BC, $0F, $0F, $00
    db $00, $00, $00, $E2, $0F, $0F, $00, $F2, $02, $00, $CC, $0A, $00, $18, $1F, $29

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6827:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A827, $44

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_686B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $03, $03, $03, $01, $00, $04, $0B, $00, $00, $0F, $03, $00
    db $04, $0C, $00, $26, $0F, $03, $00, $4F, $0F, $4D, $00, $A2, $0F, $3F, $00, $28
    db $0F, $13, $00, $00, $0F, $13, $00, $00, $00, $00, $3E, $1F, $03

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6898:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $48, $03, $03, $00, $4A, $0F, $11, $03, $03
    db $00, $70, $0F, $0F, $00, $82, $00, $00, $5C, $0C, $00, $A6, $0F, $01, $00, $5A
    db $0F, $0F, $00, $A8, $0F, $13, $00, $A6, $02, $00, $82, $06, $00, $16, $16, $00
    db $1C, $1F, $05, $00, $3A, $1F, $0D

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_68CF:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $03, $03, $00, $50, $0A, $00, $52, $0F
    db $05, $00, $50, $04, $00, $72, $0F, $15, $00, $44, $0F, $07, $00, $AE, $0F, $13
    db $00, $84, $0E, $00, $84, $00, $00, $F0, $0F, $07, $00, $16, $18, $00, $16, $1F
    db $05, $00, $56, $00, $00, $3E, $1A, $00, $40, $1F, $01

; LZSS-compressed asset: 33 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_690A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $01, $03, $00, $06, $09, $00, $00, $0F, $4D, $00
    db $10, $04, $00, $1A, $0A, $00, $76, $0F, $2B, $00, $C7, $0F, $4D, $00, $08, $1F
    db $2D

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_692B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $03, $01, $00, $02, $0B, $03, $03, $00, $00, $0F, $4D, $00
    db $10, $02, $00, $14, $0C, $00, $76, $0F, $13, $00, $76, $02, $00, $A2, $0F, $03
    db $00, $14, $08, $00, $C4, $0F, $0B, $00, $14, $00, $00, $F6, $02, $00, $EC, $0F
    db $0D, $00, $12, $1F, $35

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6960:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A960, $4E

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_69AE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12A9AE, $4C

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_69FA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $09, $00
    db $0A, $06, $00, $26, $0F, $05, $00, $0A, $0A, $00, $4C, $0F, $05, $00, $74, $0A
    db $00, $72, $0F, $0D, $00, $72, $0F, $15, $00, $CD, $0F, $4D, $00, $08, $1F, $27

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6A2A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $09, $03, $00, $0E, $01, $00, $00, $0F, $4D, $00
    db $24, $0C, $00, $22, $02, $00, $76, $0F, $35, $00, $84, $04, $00, $C6, $0F, $33
    db $00, $D2, $06, $00, $16, $1F, $2B

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6A51:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4A, $02, $02, $01, $01, $01, $01, $00, $50
    db $0F, $0B, $02, $02, $00, $5E, $02, $00, $76, $0F, $0B, $00, $82, $06, $00, $9E
    db $0F, $0D, $00, $AC, $04, $00, $C6, $0F, $09, $00, $A8, $08, $00, $EE, $0F, $0D
    db $00, $AA, $0C, $00, $1E, $1F, $07, $00, $84, $0A, $00, $46, $1A

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6A8E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12AA8E, $5C

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6AEA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12AAEA, $44

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6B2E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $50, $0F, $3C, $01, $01, $01, $01
    db $00, $A0, $0F, $0F, $00, $B0, $00, $00, $C6, $0F, $0D, $00, $D6, $02, $00, $EC
    db $0F, $4D, $00, $FA, $04

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6B53:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12AB53, $4B

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6B9E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0B, $01, $01, $01, $01, $00, $00, $0F, $11, $00
    db $0E, $00, $00, $28, $0F, $39, $00, $10, $0F, $0D, $04, $04, $04, $04, $00, $98
    db $0F, $11, $00, $08, $0F, $13, $00, $12, $06, $00, $EC, $0F, $09, $00, $F6, $0A
    db $00, $16, $1F, $07, $00, $1E, $1A, $00, $3E, $1F, $03

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6BD9:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $46, $0F, $32, $02, $02, $00, $94
    db $0F, $13, $00, $A4, $00, $00, $A6, $0E, $00, $D0, $0F, $01, $00, $CE, $0F, $19
    db $00, $F8, $0F, $1B, $00, $46, $0F, $03

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6C01:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $03, $03, $00, $08, $07, $00, $00, $0F, $2F, $00
    db $08, $08, $00, $4E, $0F, $09, $00, $06, $0F, $17, $00, $06, $08, $00, $A0, $0F
    db $31, $00, $08, $0F, $3B, $00, $06, $0F, $0F

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6C2A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12AC2A, $56

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6C80:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12AC80, $53

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6CD3:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6CE7:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $33, $00
    db $08, $06, $00, $50, $0F, $35, $00, $06, $04, $00, $A0, $0F, $11, $00, $D7, $0F
    db $4D, $00, $08, $1F, $1D

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6D0C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $01, $02, $00, $06, $09, $00, $00, $0F, $05, $00
    db $0C, $06, $00, $22, $0F, $11, $00, $00, $06, $00, $50, $0F, $03, $00, $10, $06
    db $00, $7E, $06, $00, $7A, $0F, $03, $03, $00, $A4, $03, $00, $98, $0F, $09, $00
    db $A4, $04, $00, $CF, $0F, $4D, $00, $08, $1F, $25

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6D46:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $07, $01, $00, $0C, $03, $00, $00, $0F, $07, $00
    db $12, $00, $00, $0C, $04, $00, $26, $0F, $07, $00, $32, $06, $00, $4A, $0F, $07
    db $00, $68, $0F, $3D, $03, $03, $00, $B6, $0F, $15, $00, $F0, $00, $00, $E2, $0F
    db $15, $00, $C8, $0A, $00, $18, $1F, $29

; LZSS-compressed asset: 26 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6D7E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $48, $0F, $34, $02, $02, $00, $96
    db $0F, $13, $00, $CF, $0F, $4D, $00, $08, $1F, $25

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6D98:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $03, $03, $00, $08, $07, $00, $00, $0F, $4D, $00
    db $10, $08, $00, $1A, $08, $00, $78, $0F, $33, $00, $1A, $02, $00, $C8, $08, $00
    db $D0, $0F, $05, $00, $FB, $0F, $4D, $00, $C8, $08

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6DC2:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $03, $02, $00, $02, $01, $01, $00, $08, $07, $00, $00, $0F
    db $07, $00, $08, $08, $00, $26, $0F, $05, $00, $28, $04, $00, $06, $06, $00, $50
    db $0F, $05, $00, $52, $0C, $00, $78, $0F, $03, $00, $02, $0A, $00, $02, $00, $00
    db $A0, $0F, $01, $00, $AC, $02, $00, $2E, $0A, $00, $C8, $0F, $05, $00

Data_04A_6E00:: ; heuristic: target of a monotone pointer table; C0
    db $F3, $0F, $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6E07:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12AE07, $59

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6E60:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $14, $02, $02, $02, $02, $00, $18, $0F, $15
    db $00, $2A, $0C, $00, $50, $0F, $2F, $00, $2A, $0A, $00, $A0, $0F, $29, $01, $01
    db $00, $A0, $0E, $00, $F0, $0F, $03, $00, $F0, $04, $00, $0E, $1F, $0F, $00, $F0
    db $02, $00, $36, $1F, $0B

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6E95:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6EA9:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6EBD:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $03, $01, $00, $08, $07, $00, $00, $0F, $07, $02
    db $02, $00, $1C, $0F, $15, $00, $2E, $08, $00, $50, $0F, $0B, $00, $56, $06, $00
    db $78, $0F, $07, $00, $7C, $0A, $00, $A0, $0F, $0D, $00, $02, $04, $00, $C8, $0F
    db $09, $00, $2C, $00, $00, $F0, $06, $00, $F2, $0F, $09, $00, $10, $1F, $33

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6EFC:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $22, $0F, $0E, $03, $03, $03, $03
    db $00, $72, $0F, $0F, $00, $82, $00, $00, $98, $0F, $17, $00, $84, $0A, $00, $D0
    db $08, $00, $EA, $04, $00, $F6, $0A, $00, $F2, $0F, $01, $00, $0A, $1F, $3B

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6F2B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $78, $0F, $04
    db $03, $03, $03, $03, $00, $C8, $0F, $01, $00, $DA, $0A, $00, $EC, $02, $00, $F0
    db $0F, $03, $00, $EC, $06, $00, $12, $1A, $00, $1E, $1F, $03, $00, $38, $1F, $0D

; LZSS-compressed asset: 38 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6F5B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4A, $03, $00, $5E, $01, $00, $50, $0F, $09
    db $00, $5E, $02, $00, $72, $0F, $0B, $00, $80, $08, $00, $9C, $0F, $05, $00, $C7
    db $0F, $4D, $00, $08, $1F, $2D

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6F81:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12AF81, $42

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_6FC3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12AFC3, $48

; compressed tileset of map $21 (the first map record using it)
; LZSS-compressed asset: 1248 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map21Tileset:: ; heuristic: map tileset stream; C0
Data_04A_700B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12B00B, $1F5

Data_04A_7200:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12B200, $2EB

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map21Palettes::
Data_04A_74EB:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $6301, $0000 ; entry 0
    dw $0110, $3F7F, $0214, $0000 ; entry 1
    dw $02C4, $3F7F, $029A, $0000 ; entry 2
    dw $014F, $7FFF, $029A, $0000 ; entry 3
    dw $318C, $6318, $4A52, $0000 ; entry 4
    dw $2894, $3F7F, $029A, $0000 ; entry 5
    dw $2111, $3A5C, $21B8, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map21Screens0::
Data_04A_752B:: ; heuristic: map screen array; C0
    dfar Data_04A_7537 ; entry 0
    dfar Data_04A_7622 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map21Attrs0::
Data_04A_7531:: ; heuristic: map screen array; C0
    dfar Data_04A_7709 ; entry 0
    dfar Data_04A_775D ; entry 1

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_7537:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12B537, $C9

Data_04A_7600:: ; heuristic: target of a monotone pointer table; C0
    db $44, $45, $44, $41, $00, $10, $04, $00, $00, $00, $00, $8E, $00, $00, $8E, $00
    db $00, $20, $18, $00, $26, $02, $00, $38, $1C, $00, $68, $01, $00, $20, $15, $00
    db $3C, $00

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_7622:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12B622, $E7

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_7709:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12B709, $54

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_775D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12B75D, $72

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map26Palettes::
Data_04A_77CF:: ; heuristic: map BG palettes; C0
    dw $5816, $7FFF, $699A, $0000 ; entry 0
    dw $218C, $4F18, $3A52, $0CA5 ; entry 1
    dw $0116, $03FF, $01FC, $0CA5 ; entry 2
    dw $2111, $3A5C, $21B8, $0044 ; entry 3
    dw $02C6, $3F7F, $029A, $0044 ; entry 4
    dw $2217, $03FF, $5B9C, $0842 ; entry 5
    dw $218C, $4F18, $3A52, $0CA5 ; entry 6
    dw $218C, $4F18, $3A52, $0CA5 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map28Palettes::
Data_04A_780F:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $6301, $0000 ; entry 0
    dw $01D3, $3F7F, $029A, $0042 ; entry 1
    dw $02C0, $3F7F, $03E2, $0000 ; entry 2
    dw $012F, $2B3F, $01D8, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $1528, $4F18, $3A52, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; compressed tileset of map $2A (the first map record using it)
; LZSS-compressed asset: 714 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2ATileset:: ; heuristic: map tileset stream; C0
Data_04A_784F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12B84F, $2CA

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map2APalettes::
Data_04A_7B19:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $6301, $0000 ; entry 0
    dw $01D3, $3F7F, $029A, $0042 ; entry 1
    dw $01CA, $7FFF, $029A, $0042 ; entry 2
    dw $2111, $3A5C, $21B8, $0000 ; entry 3
    dw $012F, $7FFF, $01DA, $0000 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $0173, $7FFF, $6B2B, $0084 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2AScreens0::
Data_04A_7B59:: ; heuristic: map screen array; C0
    dfar Data_04A_7B5F ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2AAttrs0::
Data_04A_7B5C:: ; heuristic: map screen array; C0
    dfar Data_04A_7C1B ; entry 0

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_7B5F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $12BB5F, $BC

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04A_7C1B:: ; heuristic: map screen stream; C0
    db $68, $01, $05, $03, $05, $00, $09, $04, $04, $05, $00, $0A, $05, $0A, $08, $01
    db $05, $2A, $05, $05, $FA, $F6, $05, $2A, $0F, $4D, $05, $24, $04, $05, $10, $0E
    db $05, $A4, $0F, $27, $05, $3E, $06, $05, $3E, $00, $02, $02, $05, $EE, $0F, $2D
    db $05, $A2, $0F, $13
    ds $1B1, $00

Data_04A_7E00:: ; heuristic: target of a monotone pointer table; C0
    ds $200, $00
