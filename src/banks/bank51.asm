SECTION "Bank 51", ROMX[$4000], BANK[$51]
    db $51

; LZSS-compressed asset: 137 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_4001:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $144001, $89

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_408A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14408A, $DE

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_4168:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $144168, $8B

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_41F3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1441F3, $E6

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_42D9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1442D9, $E4

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_43BD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1443BD, $C1

; LZSS-compressed asset: 239 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_447E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14447E, $EF

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_456D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14456D, $D4

; LZSS-compressed asset: 154 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_4641:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $144641, $9A

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_46DB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1446DB, $A6

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_4781:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $144781, $CB

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_484C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14484C, $BF

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_490B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14490B, $BC

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_49C7:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1449C7, $BA

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_4A81:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $144A81, $A1

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_4B22:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $144B22, $B3

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_4BD5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $144BD5, $BC

; compressed tileset of map $70 (the first map record using it)
; LZSS-compressed asset: 1493 bytes expand to 1920 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map70Tileset:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_051_4C91:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $144C91, $5D5

; E-0142 (derived: 144 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map70Attrs0::
Data_051_5266:: ; heuristic: map screen array; C0
    dfar Data_051_5416 ; entry 0
    dfar Data_051_5429 ; entry 1
    dfar Data_051_5455 ; entry 2
    dfar Data_051_5484 ; entry 3
    dfar Data_051_54C2 ; entry 4
    dfar Data_051_54F8 ; entry 5
    dfar Data_051_5416 ; entry 6
    dfar Data_051_5416 ; entry 7
    dfar Data_051_5416 ; entry 8
    dfar Data_051_5416 ; entry 9
    dfar Data_051_5416 ; entry 10
    dfar Data_051_5416 ; entry 11
    dfar Data_051_5416 ; entry 12
    dfar Data_051_5523 ; entry 13
    dfar Data_051_5561 ; entry 14
    dfar Data_051_5416 ; entry 15
    dfar Data_051_559E ; entry 16
    dfar Data_051_5601 ; entry 17
    dfar Data_051_563D ; entry 18
    dfar Data_051_5416 ; entry 19
    dfar Data_051_5416 ; entry 20
    dfar Data_051_5416 ; entry 21
    dfar Data_051_5672 ; entry 22
    dfar Data_051_56B4 ; entry 23
    dfar Data_051_5416 ; entry 24
    dfar Data_051_56FB ; entry 25
    dfar Data_051_5416 ; entry 26
    dfar Data_051_5416 ; entry 27
    dfar Data_051_574B ; entry 28
    dfar Data_051_57A6 ; entry 29
    dfar Data_051_57EE ; entry 30
    dfar Data_051_582E ; entry 31
    dfar Data_051_5416 ; entry 32
    dfar Data_051_5416 ; entry 33
    dfar Data_051_5861 ; entry 34
    dfar Data_051_5895 ; entry 35
    dfar Data_051_5416 ; entry 36
    dfar Data_051_5416 ; entry 37
    dfar Data_051_58BA ; entry 38
    dfar Data_051_58ED ; entry 39
    dfar Data_051_5416 ; entry 40
    dfar Data_051_5940 ; entry 41
    dfar Data_051_596B ; entry 42
    dfar Data_051_5996 ; entry 43
    dfar Data_051_59CF ; entry 44
    dfar Data_051_59FE ; entry 45
    dfar Data_051_5A2D ; entry 46
    dfar Data_051_5A6B ; entry 47
    dfar Data_051_5AAC ; entry 48
    dfar Data_051_5AE7 ; entry 49
    dfar Data_051_5B37 ; entry 50
    dfar Data_051_5B83 ; entry 51
    dfar Data_051_5BB8 ; entry 52
    dfar Data_051_5416 ; entry 53
    dfar Data_051_5BE0 ; entry 54
    dfar Data_051_5416 ; entry 55
    dfar Data_051_5C18 ; entry 56
    dfar Data_051_5C4A ; entry 57
    dfar Data_051_5C83 ; entry 58
    dfar Data_051_5CCC ; entry 59
    dfar Data_051_5D1E ; entry 60
    dfar Data_051_5D42 ; entry 61
    dfar Data_051_5D8E ; entry 62
    dfar Data_051_5DE4 ; entry 63
    dfar Data_051_5E28 ; entry 64
    dfar Data_051_5416 ; entry 65
    dfar Data_051_5E69 ; entry 66
    dfar Data_051_5E93 ; entry 67
    dfar Data_051_5EBC ; entry 68
    dfar Data_051_5EF1 ; entry 69
    dfar Data_051_5416 ; entry 70
    dfar Data_051_5416 ; entry 71
    dfar Data_051_5416 ; entry 72
    dfar Data_051_5F20 ; entry 73
    dfar Data_051_5F6F ; entry 74
    dfar Data_051_5FA9 ; entry 75
    dfar Data_051_5FE2 ; entry 76
    dfar Data_051_6029 ; entry 77
    dfar Data_051_6059 ; entry 78
    dfar Data_051_6089 ; entry 79
    dfar Data_051_60C4 ; entry 80
    dfar Data_051_6101 ; entry 81
    dfar Data_051_5416 ; entry 82
    dfar Data_051_5416 ; entry 83
    dfar Data_051_5416 ; entry 84
    dfar Data_051_6147 ; entry 85
    dfar Data_051_616E ; entry 86
    dfar Data_051_61AC ; entry 87
    dfar Data_051_61E7 ; entry 88
    dfar Data_051_6227 ; entry 89
    dfar Data_051_6254 ; entry 90
    dfar Data_051_629A ; entry 91
    dfar Data_051_62BF ; entry 92
    dfar Data_051_62F7 ; entry 93
    dfar Data_051_5416 ; entry 94
    dfar Data_051_5416 ; entry 95
    dfar Data_051_633B ; entry 96
    dfar Data_051_6363 ; entry 97
    dfar Data_051_5416 ; entry 98
    dfar Data_051_6399 ; entry 99
    dfar Data_051_63C4 ; entry 100
    dfar Data_051_6409 ; entry 101
    dfar Data_051_6434 ; entry 102
    dfar Data_051_6476 ; entry 103
    dfar Data_051_64B4 ; entry 104
    dfar Data_051_6511 ; entry 105
    dfar Data_051_5416 ; entry 106
    dfar Data_051_5416 ; entry 107
    dfar Data_051_654C ; entry 108
    dfar Data_051_6583 ; entry 109
    dfar Data_051_5416 ; entry 110
    dfar Data_051_5416 ; entry 111
    dfar Data_051_65B6 ; entry 112
    dfar Data_051_65EA ; entry 113
    dfar Data_051_661D ; entry 114
    dfar Data_051_666E ; entry 115
    dfar Data_051_66AB ; entry 116
    dfar Data_051_66F0 ; entry 117
    dfar Data_051_6730 ; entry 118
    dfar Data_051_6768 ; entry 119
    dfar Data_051_67A7 ; entry 120
    dfar Data_051_67F2 ; entry 121
    dfar Data_051_6849 ; entry 122
    dfar Data_051_687A ; entry 123
    dfar Data_051_68B1 ; entry 124
    dfar Data_051_68EC ; entry 125
    dfar Data_051_6941 ; entry 126
    dfar Data_051_5416 ; entry 127
    dfar Data_051_5416 ; entry 128
    dfar Data_051_698F ; entry 129
    dfar Data_051_69C5 ; entry 130
    dfar Data_051_6A0B ; entry 131
    dfar Data_051_6A50 ; entry 132
    dfar Data_051_6A82 ; entry 133
    dfar Data_051_6AC5 ; entry 134
    dfar Data_051_6B0E ; entry 135
    dfar Data_051_6B43 ; entry 136
    dfar Data_051_6B86 ; entry 137
    dfar Data_051_6BB7 ; entry 138
    dfar Data_051_5416 ; entry 139
    dfar Data_051_5416 ; entry 140
    dfar Data_051_5416 ; entry 141
    dfar Data_051_6BE3 ; entry 142
    dfar Data_051_6C24 ; entry 143

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5416:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5429:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $22, $0F, $0F, $02, $01, $82, $01, $01
    db $74, $0F, $0B, $01, $82, $02, $01, $A6, $04, $01, $A0, $0F, $05, $01, $A6, $0A
    db $01, $C6, $0F, $2F, $01, $A4, $0F, $15, $01, $1C, $1F, $11

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5455:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $41, $02, $02, $02, $02, $01, $44, $0F, $0F, $01
    db $54, $00, $01, $7A, $02, $01, $70, $0F, $09, $01, $7A, $06, $01, $54, $06, $01
    db $A0, $0F, $33, $01, $70, $0F, $13, $01, $6E, $0F, $01, $01, $20, $1F, $21

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5484:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $17, $02, $02, $01, $18, $0F, $15, $01, $2A, $0E
    db $01, $52, $0F, $01, $01, $50, $02, $01, $2A, $04, $01, $52, $04, $01, $7C, $0F
    db $07, $01, $A4, $06, $01, $A0, $0F, $05, $01, $A2, $0C, $01, $C8, $0F, $07, $01
    db $C8, $0A, $01, $F0, $0F, $0D, $01, $4E, $0F, $1B, $01, $51, $1F, $03

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_54C2:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $18, $0F, $05, $02, $01, $78, $01, $01
    db $6A, $0F, $15, $01, $7C, $02, $01, $78, $04, $01, $A0, $0F, $09, $01, $C8, $0F
    db $3B, $03, $03, $03, $03, $01, $0E, $1F, $0B, $01, $18, $00, $01, $1E, $10, $01
    db $1E, $18, $01, $40, $1F, $01

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_54F8:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $68, $04, $02, $01
    db $C8, $01, $01, $BA, $0F, $15, $01, $CC, $0A, $01, $F0, $0F, $09, $01, $C8, $08
    db $01, $18, $1F, $0D, $01, $10, $1F, $01, $01, $68, $04

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5523:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F2, $02, $01, $06, $09, $01, $00, $0F, $2D, $01, $06
    db $0A, $01, $4E, $0F, $15, $03, $03, $01, $78, $0F, $03, $01, $7C, $0C, $01, $9E
    db $0F, $05, $01, $04, $08, $01, $C4, $04, $01, $CA, $0F, $03, $01, $04, $06, $01
    db $FA, $FF, $01, $01, $F6, $FE, $01, $F4, $FF, $01, $01, $A0, $FF, $1D

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5561:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $03, $01, $F4, $FF, $15, $01, $06, $08, $01, $28
    db $0F, $0B, $01, $06, $06, $01, $50, $0F, $01, $03, $03, $01, $66, $0F, $15, $01
    db $78, $02, $03, $03, $01, $F6, $F6, $01, $A0, $0F, $01, $01, $9C, $04, $01, $F0
    db $FC, $01, $CC, $0F, $01, $01, $F3, $0F, $4D, $01, $53, $1F, $01

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_559E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14559E, $63

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5601:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $07, $01, $F8, $FF, $3D, $01, $08, $04, $01, $50
    db $0F, $01, $03, $03, $03, $03, $01, $50, $0C, $01, $78, $0F, $05, $01, $A0, $02
    db $01, $96, $0F, $0B, $01, $88, $06, $01, $7A, $0A, $01, $CC, $0F, $01, $01, $98
    db $0A, $01, $EE, $0F, $0F, $01, $86, $04, $01, $18, $1F, $29

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_563D:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $18, $0F, $05, $02, $01, $78, $01, $01
    db $6A, $0F, $15, $01, $7A, $0A, $01, $A0, $0F, $0B, $01, $7C, $06, $01, $C8, $0F
    db $0D, $01, $7C, $04, $01, $F0, $0F, $01, $03, $03, $01, $06, $1F, $15, $01, $18
    db $18, $01, $3A, $1F, $07

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5672:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145672, $42

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_56B4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1456B4, $47

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_56FB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1456FB, $50

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_574B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14574B, $5B

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_57A6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1457A6, $48

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_57EE:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $03, $03, $03, $02, $01, $04, $05, $01, $FA, $FF, $09, $01
    db $04, $06, $01, $0A, $04, $01, $28, $0F, $03, $01, $28, $0A, $01, $4C, $0F, $09
    db $01, $28, $0C, $01, $78, $0F, $07, $01, $28, $0A, $01, $A0, $0F, $07, $01, $0A
    db $04, $01, $C2, $0F, $09, $01, $F2, $FA, $01, $EC, $0F, $05, $01, $A0, $FF, $3D

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_582E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $1D, $02, $02, $02, $02, $01, $20, $0F, $0B, $01
    db $30, $00, $01, $52, $04, $01, $4A, $0F, $07, $01, $52, $08, $01, $70, $0F, $15
    db $01, $4A, $0F, $11, $01, $24, $0C, $01, $CC, $0F, $01, $01, $20, $0F, $11, $01
    db $17, $1F, $3D

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5861:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F2, $03, $03, $02, $01, $08, $07, $01, $00, $0F, $2D
    db $03, $01, $54, $01, $01, $46, $0F, $3D, $01, $06, $06, $01, $A0, $0F, $05, $01
    db $52, $0C, $01, $C8, $0F, $07, $01, $52, $02, $01, $E8, $0F, $11, $01, $F6, $08
    db $01, $18, $1F, $29

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5895:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $07, $03, $03, $03, $03, $01, $FC, $FF, $39, $01
    db $0A, $04, $01, $50, $0F, $39, $01, $4C, $0F, $01, $01, $B0, $0F, $4D, $01, $BE
    db $04, $01, $18, $1F, $29

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_58BA:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $24, $0F, $11, $02, $01, $84, $03, $01
    db $78, $0F, $07, $01, $84, $04, $01, $9A, $0F, $0B, $01, $A6, $0A, $01, $C6, $0F
    db $3B, $03, $03, $03, $03, $01, $18, $1F, $05, $01, $82, $06, $01, $28, $10, $01
    db $3E, $1F, $03

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_58ED:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1458ED, $53

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5940:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F4, $03, $01, $08, $03, $01, $FC, $FF, $0D, $01, $06
    db $04, $01, $24, $0F, $13, $01, $F8, $FF, $01, $01, $5E, $0F, $4D, $01, $70, $0E
    db $01, $D0, $0F, $03, $01, $F9, $0F, $4D, $01, $59, $1A

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_596B:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $1B, $02, $01, $2E, $05, $01, $24, $0F, $09, $01
    db $2E, $06, $01, $32, $06, $01, $54, $0F, $29, $01, $52, $0C, $01, $A0, $0F, $2B
    db $01, $54, $0F, $4B, $01, $4C, $0F, $01, $01, $A0, $F0

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5996:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $1F, $02, $02, $02, $02, $01, $22, $0F, $07, $01
    db $32, $04, $01, $32, $00, $01, $50, $08, $01, $54, $0F, $01, $01, $78, $06, $01
    db $2C, $06, $01, $7C, $0F, $31, $01, $2A, $08, $01, $CC, $0C, $01, $56, $04, $01
    db $24, $0E, $01, $34, $0E, $01, $1B, $1F, $39

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_59CF:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $25, $02, $02, $02, $02, $01, $28, $0F, $0F, $01
    db $38, $00, $01, $4E, $0F, $0D, $01, $5E, $02, $01, $74, $0F, $0D, $01, $82, $06
    db $01, $9E, $0F, $31, $01, $A8, $08, $01, $EE, $0F, $31, $01, $A6, $0F, $0F

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_59FE:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $15, $02, $02, $02, $02, $01, $18, $0F, $15, $01
    db $50, $02, $01, $46, $0F, $15, $01, $2A, $06, $01, $78, $0F, $0D, $01, $2A, $04
    db $01, $A0, $0F, $37, $01, $2A, $02, $01, $F0, $0F, $37, $01, $9A, $0F, $07

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5A2D:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F6, $03, $03, $03, $03, $02, $01, $0E, $01, $01, $00
    db $0F, $0D, $01, $0E, $02, $01, $26, $0F, $35, $01, $30, $04, $03, $03, $01, $78
    db $0F, $33, $01, $0C, $04, $01, $C6, $0F, $0B, $01, $32, $06, $01, $EE, $0F, $09
    db $01, $F8, $08, $01, $16, $1F, $07, $01, $0A, $06, $01, $3A, $1F, $07

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5A6B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145A6B, $41

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5AAC:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $23, $02, $02, $01, $24, $0F, $0D, $02, $01, $58
    db $05, $01, $4E, $0F, $09, $01, $58, $06, $01, $5E, $06, $01, $7E, $0E, $01, $7E
    db $0A, $01, $9E, $0F, $07, $01, $7C, $0F, $15, $01, $7A, $0C, $01, $F0, $0F, $09
    db $01, $56, $0F, $15, $01, $54, $08, $01, $40, $1F, $01

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5AE7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145AE7, $50

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5B37:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145B37, $4C

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5B83:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $01, $02, $01, $06, $03, $01, $FA, $FF, $0B, $01
    db $06, $04, $01, $20, $0F, $35, $01, $2A, $0C, $01, $78, $0F, $11, $01, $06, $00
    db $01, $A0, $0F, $07, $01, $A4, $0A, $01, $C8, $0F, $4D, $01, $D8, $08, $01, $2A
    db $08, $01, $40, $1F, $01

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5BB8:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $40, $0F, $2D, $02, $02, $02, $02, $01
    db $90, $0F, $15, $01, $A0, $0C, $01, $C8, $0F, $09, $01, $A2, $08, $01, $F0, $0F
    db $0B, $01, $A2, $06, $01, $18, $1F, $29

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5BE0:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F0, $02, $01, $04, $07, $01, $FC, $FF, $15, $01, $0E
    db $04, $01, $2C, $0E, $01, $2C, $0A, $01, $4C, $0F, $15, $01, $26, $0F, $07, $01
    db $02, $08, $01, $FA, $FF, $01, $01, $FA, $FE, $01, $F8, $FF, $01, $01, $F6, $FC
    db $01, $F2, $FF, $01, $01, $A0, $FF, $49

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5C18:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F4, $02, $01, $08, $07, $01, $00, $0F, $07, $01, $08
    db $08, $01, $26, $0F, $4D, $01, $5E, $0F, $1F, $01, $6A, $0A, $01, $C6, $0F, $15
    db $01, $64, $0F, $07, $01, $04, $0A, $01, $16, $1F, $13, $01, $FC, $FF, $01, $01
    db $A0, $F0

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5C4A:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $02, $03, $00, $09, $03, $FA, $FF, $3B, $03, $F8, $FF, $01, $03
    db $F8, $FE, $03, $F6, $FF, $01, $03, $F6, $FE, $01, $01, $03, $96, $0F, $13, $03
    db $80, $0F, $0D, $03, $FE, $F6, $03, $E6, $0F, $0D, $03, $FE, $F2, $03, $F0, $FF
    db $01, $03, $EE, $FF, $01, $03, $34, $1F, $0D

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5C83:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145C83, $49

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5CCC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145CCC, $52

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5D1E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F8, $02, $01, $0C, $03, $01, $00, $0F, $35, $01, $0A
    db $04, $01, $50, $0F, $0F, $01, $0A, $02, $01, $78, $0F, $11, $01, $AF, $0F, $4D
    db $01, $0F, $1F, $45

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5D42:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145D42, $4C

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5D8E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145D8E, $56

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5DE4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145DE4, $44

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5E28:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145E28, $41

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5E69:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $21, $02, $02, $01, $22, $0F, $11, $02, $01, $5A
    db $01, $01, $4C, $0F, $0D, $01, $5A, $02, $01, $5A, $0A, $01, $80, $0F, $29, $01
    db $7E, $08, $01, $C8, $0F, $4D, $01, $00, $1F, $19

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5E93:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $25, $02, $02, $01, $26, $0F, $0F, $02, $01, $5C
    db $03, $01, $50, $0F, $01, $01, $5E, $06, $01, $70, $0A, $01, $7C, $0F, $03, $01
    db $A5, $0F, $4D, $01, $05, $1F, $4D, $02, $02

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5EBC:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F4, $02, $01, $08, $03, $01, $FC, $FF, $2D, $01, $48
    db $08, $01, $0E, $04, $01, $50, $0F, $05, $01, $78, $06, $01, $72, $0F, $0F, $01
    db $02, $04, $01, $9C, $0F, $0B, $01, $00, $08, $01, $C6, $0F, $0F, $01, $78, $0F
    db $0F, $01, $10, $1F, $37

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5EF1:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F2, $02, $02, $01, $F4, $FF, $15, $01, $06, $0E, $01
    db $2E, $0F, $05, $01, $06, $0C, $01, $56, $0F, $07, $01, $06, $0A, $01, $7E, $0E
    db $01, $7E, $0F, $41, $01, $E4, $0F, $17, $01, $06, $06, $01, $18, $1F, $29

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5F20:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145F20, $4F

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5F6F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $3C, $02, $02, $02, $02, $00, $48, $06, $00
    db $4A, $0F, $0B, $00, $5C, $0C, $00, $78, $0F, $0B, $00, $7A, $0A, $00, $A4, $0F
    db $03, $00, $C8, $04, $00, $C2, $0F, $15, $00, $86, $08, $00, $F6, $0F, $0B, $00
    db $52, $00, $00, $18, $1F, $11, $00, $EC, $0F, $05

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5FA9:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $03, $02, $00, $08, $03, $00, $00, $04, $00, $04
    db $0F, $2B, $00, $0A, $0E, $00, $54, $0F, $01, $00, $08, $04, $00, $4A, $0E, $00
    db $0C, $0E, $01, $01, $00, $06, $02, $00, $9C, $0F, $0B, $00, $00, $06, $00, $C4
    db $0F, $13, $00, $FD, $0F, $4D, $00, $10, $06

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_5FE2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $145FE2, $47

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6029:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $43, $02, $02, $01, $44, $0F, $11, $02, $01, $7C
    db $01, $01, $78, $04, $01, $76, $0F, $03, $01, $7C, $02, $02, $02, $04, $04, $04
    db $04, $01, $A0, $04, $01, $A0, $0F, $09, $01, $CF, $0F, $4D, $01, $08, $1F, $25

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6059:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F6, $02, $01, $0A, $05, $01, $00, $0F, $2F, $01, $0A
    db $06, $01, $4C, $0F, $09, $01, $56, $0A, $01, $76, $0F, $03, $01, $9F, $0F, $4D
    db $01, $CA, $0F, $17, $03, $03, $01, $18, $1F, $11, $03, $03, $01, $3E, $1F, $03

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6089:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $0F, $44, $01, $FA, $FF, $01, $01, $FA, $FE, $01
    db $F6, $FF, $01, $01, $7E, $0F, $29, $01, $56, $02, $01, $48, $0F, $01, $01, $00
    db $08, $03, $03, $01, $00, $0E, $01, $F4, $0C, $03, $01, $18, $13, $01, $F2, $02
    db $01, $1E, $12, $01, $18, $1F, $09, $01, $3E, $1F, $0D

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_60C4:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $0F, $4D, $01, $4C, $0F, $38, $03, $03, $01, $AA
    db $00, $01, $AC, $00, $01, $A2, $0F, $0D, $01, $D4, $02, $01, $C8, $0F, $0B, $01
    db $D4, $04, $01, $EE, $0F, $03, $01, $B0, $04, $01, $D4, $04, $01, $FC, $F0, $01
    db $18, $1F, $05, $01, $FA, $06, $01, $FA, $F2, $01, $40, $1F, $01

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6101:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $146101, $46

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6147:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F8, $02, $01, $0C, $03, $01, $00, $0F, $4D, $01, $24
    db $0C, $01, $1E, $04, $01, $78, $0F, $0F, $01, $1C, $02, $01, $A0, $0F, $13, $01
    db $D9, $0F, $4D, $01, $39, $1F, $1B

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_616E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $0B, $03, $03, $03, $03, $01, $00, $0F, $11, $01
    db $0E, $00, $01, $28, $0F, $3B, $01, $FE, $FE, $01, $88, $0F, $01, $01, $FC, $FF
    db $01, $01, $FA, $FF, $01, $01, $C4, $0F, $07, $01, $FE, $F0, $01, $FA, $FA, $01
    db $F0, $0F, $05, $01, $F6, $FC, $01, $18, $1F, $0F, $01, $4D, $1F, $07

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_61AC:: ; heuristic: map screen stream; C0
    db $68, $01, $04, $03, $04, $00, $0F, $4D, $04, $18, $0F, $04, $00, $00, $02, $02
    db $02, $02, $04, $6A, $0F, $11, $04, $FC, $F0, $02, $02, $01, $01, $03, $03, $04
    db $7C, $04, $04, $A0, $0F, $09, $04, $CE, $04, $04, $C4, $0F, $05, $04, $CE, $06
    db $04, $F0, $0F, $33, $04, $C8, $0C, $04, $3C, $1F, $05

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_61E7:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $05, $02, $01, $0A, $05, $01, $00, $0F, $4D, $01
    db $10, $0A, $01, $1C, $06, $01, $78, $0F, $09, $01, $12, $02, $01, $9A, $0F, $0B
    db $01, $20, $08, $01, $C4, $0F, $05, $01, $EC, $0A, $01, $18, $0C, $01, $FA, $0C
    db $01, $FC, $F0, $01, $C2, $0C, $01, $1E, $1E, $01, $F8, $F4, $01, $38, $1F, $09

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6227:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $90, $0F, $1C
    db $03, $03, $00, $E2, $0C, $00, $00, $10, $00, $F2, $0F, $01, $00, $F0, $00, $00
    db $02, $14, $00, $14, $14, $00, $1A, $1F, $03, $00, $3A, $1F, $11

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6254:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $146254, $46

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_629A:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $0F, $3E, $01, $FC, $FF, $01, $01, $FC, $FE, $01
    db $FA, $FF, $01, $01, $78, $0F, $4D, $01, $88, $06, $01, $FE, $FA, $01, $F0, $0F
    db $2F, $01, $CE, $0F, $0F

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_62BF:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $09, $01, $FA, $FF, $11, $02, $02, $02, $02, $01
    db $22, $0F, $0F, $01, $32, $06, $01, $4E, $0F, $09, $01, $32, $00, $01, $6E, $0F
    db $17, $01, $32, $04, $01, $A0, $0F, $07, $01, $A4, $08, $02, $02, $01, $C8, $0F
    db $2F, $01, $D0, $08, $01, $16, $1F, $2B

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_62F7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1462F7, $44

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_633B:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $50, $0F, $3D, $02, $02, $02, $02, $01
    db $A0, $0F, $09, $01, $B0, $00, $01, $D0, $04, $01, $C8, $0F, $07, $01, $D0, $08
    db $01, $EE, $0F, $31, $01, $CE, $0F, $0F

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6363:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $43, $02, $02, $02, $02, $01, $46, $0F, $0D, $01
    db $56, $00, $01, $7A, $02, $01, $70, $0F, $09, $01, $7A, $06, $01, $56, $06, $01
    db $A0, $0F, $0D, $01, $98, $0F, $01, $01, $72, $0F, $1B, $01, $EE, $0F, $1F, $01
    db $6E, $0F, $01, $01, $A0, $F8

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6399:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F2, $02, $01, $06, $09, $01, $00, $0F, $2D, $01, $06
    db $0A, $01, $4E, $0F, $4D, $01, $0E, $0F, $21, $01, $04, $06, $01, $FA, $FF, $01
    db $01, $F8, $FE, $01, $F6, $FF, $01, $01, $A0, $FF, $1B

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_63C4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1463C4, $45

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6409:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $44, $0F, $30, $02, $02, $00, $9A
    db $08, $00, $A4, $02, $00, $A4, $0E, $00, $B0, $00, $00, $A4, $04, $00, $CA, $04
    db $00, $CA, $0E, $00, $EF, $0F, $4D, $00, $08, $1F, $05

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6434:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $146434, $42

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6476:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F2, $03, $01, $06, $09, $01, $00, $0F, $2D, $01, $06
    db $06, $02, $02, $01, $4C, $0F, $07, $01, $56, $06, $01, $82, $00, $01, $74, $0F
    db $05, $01, $7A, $0A, $01, $9A, $0F, $17, $01, $9A, $08, $01, $D0, $0E, $01, $D0
    db $06, $01, $98, $06, $01, $F6, $0E, $01, $F6, $0A, $01, $16, $1F, $2B

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_64B4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1464B4, $5D

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6511:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $0B, $01, $FC, $FF, $0D, $05, $05, $01, $1E, $0F
    db $0D, $01, $30, $00, $01, $30, $08, $01, $4E, $0F, $05, $01, $50, $06, $01, $F8
    db $F8, $01, $7C, $0F, $01, $01, $08, $08, $01, $9C, $0F, $0F, $01, $F6, $FF, $01
    db $01, $F4, $FC, $01, $F0, $FF, $01, $01, $A0, $FF, $4B

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_654C:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F4, $02, $01, $08, $07, $01, $00, $0F, $2F, $01, $08
    db $08, $01, $4E, $0F, $15, $03, $03, $01, $78, $0F, $05, $01, $7E, $0A, $01, $9E
    db $0F, $11, $01, $B0, $00, $01, $C6, $0F, $2D, $01, $CC, $0C, $01, $16, $1F, $0B
    db $01, $24, $14, $01, $3C, $1F, $05

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6583:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $03, $01, $F4, $FF, $15, $01, $06, $08, $01, $28
    db $0F, $05, $03, $03, $01, $42, $0F, $0F, $03, $03, $01, $54, $02, $01, $04, $08
    db $01, $78, $0F, $33, $01, $6E, $0F, $01, $01, $D2, $0F, $21, $01, $02, $0E, $01
    db $18, $1F, $29

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_65B6:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F2, $02, $01, $06, $09, $01, $00, $0F, $2F, $01, $02
    db $0A, $01, $50, $0F, $0B, $01, $00, $04, $01, $F4, $FF, $01, $01, $80, $0F, $13
    db $01, $54, $0F, $1B, $01, $44, $0F, $01, $01, $44, $0F, $0B, $01, $FA, $FF, $01
    db $01, $A0, $FF, $1D

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_65EA:: ; heuristic: map screen stream; C0
    db $68, $01, $04, $02, $04, $00, $0F, $4D, $04, $18, $0F, $04, $04, $F8, $FF, $01
    db $04, $78, $0F, $09, $01, $01, $01, $01, $04, $98, $0F, $11, $04, $FE, $F6, $03
    db $03, $04, $C8, $0F, $31, $04, $D2, $06, $04, $16, $1F, $09, $04, $18, $06, $04
    db $3C, $1F, $05

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_661D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14661D, $51

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_666E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $03, $03, $03, $02, $01, $04, $0B, $01, $00, $0F, $2B, $01
    db $FA, $F2, $01, $44, $0F, $0D, $01, $F8, $F4, $01, $6C, $0F, $13, $01, $72, $06
    db $01, $9C, $0F, $09, $01, $72, $0A, $01, $A0, $0C, $01, $D8, $0F, $07, $01, $DE
    db $0F, $05, $01, $F0, $FC, $01, $18, $1F, $01, $01, $3F, $1F, $15

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_66AB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1466AB, $45

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_66F0:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $03, $A0, $FF, $4D, $03, $20, $0F, $0D, $02, $02, $02, $02, $03
    db $7C, $08, $03, $7C, $0F, $03, $02, $02, $01, $01, $03, $80, $00, $03, $AA, $02
    db $03, $A0, $0F, $09, $03, $CE, $08, $03, $C8, $0F, $07, $03, $CC, $0A, $03, $F0
    db $0F, $09, $03, $CC, $08, $03, $18, $1F, $0B, $03, $CC, $06, $03, $40, $1F, $01

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6730:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $1B, $02, $01, $2E, $01, $01, $28, $04, $01, $28
    db $0F, $03, $01, $2E, $02, $01, $3A, $08, $01, $50, $0F, $01, $01, $52, $0A, $01
    db $72, $0F, $19, $01, $50, $0C, $01, $4C, $06, $01, $1E, $0F, $01, $01, $CC, $0F
    db $29, $01, $CA, $0C, $01, $18, $1F, $29

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6768:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $15, $02, $02, $01, $20, $0F, $15, $01, $28, $02
    db $01, $50, $00, $01, $28, $04, $01, $50, $0F, $03, $01, $22, $0C, $01, $76, $0F
    db $03, $01, $F2, $FF, $2D, $01, $CC, $0F, $03, $01, $5C, $0C, $01, $F2, $0F, $07
    db $01, $52, $04, $03, $03, $01, $16, $1F, $11, $01, $1C, $0A, $01, $94, $08

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_67A7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1467A7, $4B

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_67F2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1467F2, $57

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6849:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $40, $0F, $2D, $02, $02, $02, $02, $01
    db $90, $0F, $15, $01, $A2, $0C, $01, $C8, $0F, $07, $01, $C8, $0A, $01, $F0, $0F
    db $01, $03, $03, $01, $F0, $0E, $01, $18, $1F, $03, $01, $40, $10, $01, $32, $1F
    db $0F

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_687A:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $1F, $02, $02, $01, $20, $0F, $0D, $02, $01, $54
    db $07, $01, $4C, $0F, $07, $01, $54, $08, $01, $5C, $04, $01, $7A, $0F, $29, $01
    db $78, $0C, $01, $C6, $0F, $13, $01, $4C, $0F, $09, $01, $52, $04, $01, $24, $0C
    db $01, $20, $1E, $01, $45, $1F, $0F

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_68B1:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $00, $00, $03, $03, $01, $50, $0F, $11, $03
    db $03, $01, $76, $0F, $11, $03, $03, $02, $02, $02, $02, $01, $A0, $0F, $0D, $01
    db $AE, $02, $01, $C6, $0F, $0F, $01, $D6, $02, $01, $EE, $0F, $0D, $01, $D4, $04
    db $01, $16, $1F, $0B, $01, $88, $00, $01, $38, $1F, $09

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_68EC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1468EC, $55

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6941:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $146941, $4E

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_698F:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F8, $02, $01, $0C, $03, $01, $00, $0F, $0B, $01, $0C
    db $04, $01, $26, $0F, $09, $01, $32, $06, $01, $4C, $0F, $09, $01, $56, $0A, $01
    db $76, $0F, $2F, $01, $54, $0F, $15, $01, $04, $0F, $1B, $01, $08, $06, $01, $18
    db $1F, $0F, $01, $4D, $1F, $07

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_69C5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1469C5, $46

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6A0B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $146A0B, $45

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6A50:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F6, $02, $01, $0A, $05, $01, $00, $0F, $09, $01, $0A
    db $06, $01, $26, $0F, $33, $01, $08, $0F, $15, $01, $06, $08, $01, $A0, $0F, $0D
    db $01, $08, $04, $01, $C8, $0F, $0F, $01, $08, $00, $01, $F8, $FF, $01, $01, $A0
    db $FF, $3F

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6A82:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $146A82, $43

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6AC5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $146AC5, $49

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6B0E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $1F, $02, $02, $01, $20, $0F, $0D, $02, $01, $54
    db $05, $01, $4A, $0F, $07, $01, $54, $06, $01, $32, $06, $01, $78, $0F, $0B, $01
    db $4A, $0F, $11, $01, $24, $0C, $01, $CA, $0F, $03, $01, $22, $0E, $01, $32, $0F
    db $01, $01, $19, $1F, $3B

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6B43:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $146B43, $43

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6B86:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $02, $03, $00, $0F, $4D, $03, $40, $0F, $2C, $03, $FE, $F4, $01
    db $01, $03, $98, $06, $03, $A0, $0F, $03, $03, $FE, $FA, $03, $F8, $FF, $01, $03
    db $F6, $FE, $03, $F4, $FF, $01, $03, $F2, $FE, $03, $F0, $FF, $01, $03, $A0, $FF
    db $1D

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6BB7:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $0B, $01, $FC, $FF, $3B, $01, $FA, $FF, $01, $01
    db $FA, $FE, $01, $F8, $FF, $01, $01, $F6, $FE, $01, $F4, $FF, $01, $01, $F2, $FE
    db $01, $F0, $FF, $01, $01, $A0, $FF, $4D, $01, $43, $1F, $11

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6BE3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $146BE3, $41

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_6C24:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $146C24, $44

; compressed tileset of map $71 (the first map record using it)
; LZSS-compressed asset: 1006 bytes expand to 1136 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map71Tileset:: ; heuristic: map tileset stream; C0
Data_051_6C68:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $146C68, $3EE

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map71Palettes::
Data_051_7056:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $00ED, $7FFF, $11D4, $0000 ; entry 1
    dw $00ED, $22BA, $11D4, $0000 ; entry 2
    dw $01C4, $3F7F, $0348, $0000 ; entry 3
    dw $48EC, $3F7F, $01DA, $0000 ; entry 4
    dw $48EC, $6BFF, $0348, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map71Screens0::
Data_051_7096:: ; heuristic: map screen array; C0
    dfar Data_051_70A8 ; entry 0
    dfar Data_051_7193 ; entry 1
    dfar Data_051_7267 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map71Attrs0::
Data_051_709F:: ; heuristic: map screen array; C0
    dfar Data_051_738A ; entry 0
    dfar Data_051_73C4 ; entry 1
    dfar Data_051_7404 ; entry 2

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_70A8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1470A8, $EB

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_7193:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $147193, $D4

; LZSS-compressed asset: 291 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_7267:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $147267, $123

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_738A:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $0F, $1E, $02, $01, $32, $05, $01, $28, $0F, $03
    db $04, $01, $52, $01, $01, $30, $00, $01, $FA, $F2, $01, $4E, $0F, $35, $01, $52
    db $02, $01, $A4, $08, $01, $A8, $0F, $03, $01, $A8, $06, $01, $C8, $0F, $0D, $01
    db $00, $06, $01, $F2, $0F, $29, $01, $00, $0F, $13

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_73C4:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $03, $04, $04, $04, $04, $00, $00, $04, $00, $00
    db $0F, $0D, $02, $00, $34, $03, $00, $28, $0F, $2F, $00, $08, $00, $00, $6E, $0F
    db $0B, $00, $7E, $02, $00, $A0, $0F, $37, $00, $7A, $06, $00, $EA, $06, $00, $F0
    db $0F, $05, $00, $F2, $06, $00, $10, $0C, $00, $08, $0F, $01, $00, $3A, $1F, $0B

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_7404:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $147404, $85

; compressed tileset of map $72 (the first map record using it)
; LZSS-compressed asset: 564 bytes expand to 608 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map72Tileset:: ; heuristic: map tileset stream; C0
Data_051_7489:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $147489, $234

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map72Palettes::
Data_051_76BD:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $00ED, $7FFF, $11D4, $0000 ; entry 1
    dw $00ED, $22BA, $11D4, $0000 ; entry 2
    dw $01C4, $3F7F, $0348, $0000 ; entry 3
    dw $00ED, $3F7F, $01DA, $0000 ; entry 4
    dw $48EC, $6BFF, $0348, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map72Screens0::
Data_051_76FD:: ; heuristic: map screen array; C0
    dfar Data_051_7703 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map72Attrs0::
Data_051_7700:: ; heuristic: map screen array; C0
    dfar Data_051_77C8 ; entry 0

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_7703:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $147703, $C5

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_77C8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $18, $04, $00, $2C, $03, $00, $20, $0F, $35
    db $00, $00, $0E, $01, $01, $00, $8A, $04, $00, $8E, $02, $00, $9D, $0F, $4D, $00
    db $86, $0F, $35, $00, $6E, $0F, $01, $00, $32, $0A

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8FScreens0::
Data_051_77F2:: ; heuristic: map screen array; C0
    dfar Data_051_77FE ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8FAttrs0::
Data_051_77F5:: ; heuristic: map screen array; C0
    dfar Data_051_7A50 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8FScreens2::
Data_051_77F8:: ; heuristic: map screen array; C0
    dfar Data_051_7927 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8FAttrs2::
Data_051_77FB:: ; heuristic: map screen array; C0
    dfar Data_051_7AC8 ; entry 0

; LZSS-compressed asset: 297 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_77FE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1477FE, $129

; LZSS-compressed asset: 297 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_7927:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $147927, $129

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_7A50:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $147A50, $78

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_7AC8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $147AC8, $78

; compressed tileset of map $93 (the first map record using it)
; LZSS-compressed asset: 789 bytes expand to 880 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map93Tileset:: ; heuristic: map tileset stream; C0
Data_051_7B40:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $147B40, $315

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map93Palettes::
Data_051_7E55:: ; heuristic: map BG palettes; C0
    dw $3CC5, $7FFF, $1415, $0000 ; entry 0
    dw $0142, $6AD8, $0348, $0084 ; entry 1
    dw $00EF, $6AD8, $2A13, $0000 ; entry 2
    dw $0142, $3F7F, $0348, $0084 ; entry 3
    dw $3CC5, $6AD8, $5D12, $0000 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map93Screens0::
Data_051_7E95:: ; heuristic: map screen array; C0
    dfar Data_051_7E9B ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map93Attrs0::
Data_051_7E98:: ; heuristic: map screen array; C0
    dfar Data_051_7F91 ; entry 0

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_7E9B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $147E9B, $F6

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_051_7F91:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $147F91, $56
    ds $19, $00
