SECTION "Bank 5A", ROMX[$4000], BANK[$5A]
    db $5A
    dw Data_05A_4049
    db $5A
    dw Data_05A_4066
    db $5A
    dw Data_05A_4101
    db $5A
    dw Data_05A_41A2
    db $5A
    dw Data_05A_4241
    db $5A
    dw Data_05A_42EA
    db $5A
    dw Data_05A_437B
    db $5A
    dw Data_05A_4413
    db $5A
    dw Data_05A_44D5
    db $5A
    dw Data_05A_458B
    db $5A
    dw Data_05A_4649
    db $5A
    dw Data_05A_471C
    db $5A
    dw Data_05A_4805
    db $5A
    dw Data_05A_4819
    db $5A
    dw Data_05A_482D
    db $5A
    dw Data_05A_4854
    db $5A
    dw Data_05A_4880
    db $5A
    dw Data_05A_48A0
    db $5A
    dw Data_05A_48D4
    db $5A
    dw Data_05A_4904
    db $5A
    dw Data_05A_4935
    db $5A
    dw Data_05A_4962
    db $5A
    dw Data_05A_4976
    db $5A
    dw Data_05A_49A2
    db $5A

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4049:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $20, $21, $00, $00, $0E, $30, $31, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4066:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $168066, $9B

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4101:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $168101, $A1

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_41A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1681A2, $9F

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4241:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $168241, $A9

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_42EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1682EA, $91

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_437B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16837B, $98

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4413:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $168413, $C2

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_44D5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1684D5, $B6

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_458B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16858B, $BE

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4649:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $168649, $D3

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_471C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16871C, $E9

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4805:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4819:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_482D:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4A, $04, $04, $00, $4C, $0F, $11, $04, $04
    db $00, $72, $0F, $11, $00, $84, $00, $00, $9A, $0F, $0F, $00, $AA, $0F, $13, $00
    db $80, $0F, $17, $00, $00, $0F, $35

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4854:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $48, $04, $04, $04, $04, $00, $4C, $0F, $0B
    db $00, $5C, $00, $00, $5C, $0C, $00, $7E, $0F, $01, $00, $7C, $0F, $19, $00, $58
    db $02, $00, $C4, $0F, $13, $00, $FD, $0F, $4D, $00, $00, $06

; LZSS-compressed asset: 32 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4880:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $04, $00, $56, $03, $00, $4A, $0F, $0D
    db $00, $54, $0F, $1D, $00, $46, $0F, $01, $00, $00, $0F, $43, $00, $00, $0F, $3D

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_48A0:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $46, $04, $04, $00, $48, $0F, $0F, $04, $00
    db $7E, $03, $00, $72, $0F, $0B, $00, $7E, $04, $00, $82, $08, $00, $A4, $0F, $0D
    db $00, $5A, $04, $00, $CC, $0F, $03, $00, $7A, $06, $00, $52, $0A, $00, $80, $0E
    db $00, $00, $0F, $35

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_48D4:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4C, $04, $04, $00, $4E, $0F, $11, $04, $04
    db $00, $74, $0F, $11, $03, $03, $00, $9A, $0F, $11, $00, $86, $00, $00, $60, $0C
    db $00, $D2, $0F, $05, $00, $76, $0F, $11, $00, $5E, $0F, $15, $00, $00, $0F, $0B

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4904:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $04, $04, $04, $04, $00, $54, $00, $00
    db $4A, $0F, $0B, $00, $56, $00, $00, $7C, $06, $00, $76, $0F, $2F, $00, $7A, $0A
    db $00, $C6, $0F, $09, $00, $7A, $06, $00, $4A, $0C, $00, $FC, $0C, $00, $00, $0F
    db $35

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4935:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4A, $04, $04, $04, $04, $00, $4E, $0F, $13
    db $00, $4C, $0F, $01, $00, $4E, $0F, $27, $00, $5E, $0E, $00, $D4, $0E, $00, $D4
    db $02, $00, $EC, $0F, $0F, $00, $84, $0F, $15, $00, $00, $0F, $0B

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4962:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_4976:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $24, $0F, $10, $04, $04, $00, $72
    db $0F, $0F, $04, $00, $A8, $01, $00, $9A, $0F, $0D, $00, $A8, $02, $00, $AA, $0A
    db $00, $CE, $0F, $01, $00, $A6, $0F, $15, $00, $24, $0F, $37

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_49A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1689A2, $4E3
    dw Data_05A_54B8
    db $AB
    dw Data_05A_5A4E
    db $48
    dw Data_05A_5A4F
    db $F2
    dw Data_05A_5A4F
    db $89
    dw Data_05A_5A50
    db $36
    dw Data_05A_5A51
    db $C3
    dw Data_05A_5A51
    db $34
    dw Data_05A_5A52
    db $6F
    dw Data_05A_5A52
    db $A4
    dw Data_05A_5A52
    db $E4
    dw Data_05A_5A52
    db $2D
    dw Data_05A_5A53
    db $65
    dw Data_05A_5A53
    INCBIN "dwm2-cobi-us.gbc", $168EAB, $60D

Data_05A_54B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1694B8, $596

Data_05A_5A4E:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_05A_5A4F:: ; heuristic: target of a monotone pointer table; C0
    db $0F

Data_05A_5A50:: ; heuristic: target of a monotone pointer table; C0
    db $DF

Data_05A_5A51:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_05A_5A52:: ; heuristic: target of a monotone pointer table; C0
    db $FD

Data_05A_5A53:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $169A53, $1E5
    dw Data_05A_5C50
    db $5A
    dw Data_05A_5D20
    db $5A
    dw Data_05A_5DF8
    db $5A
    dw Data_05A_5EF4
    db $5A
    dw Data_05A_5F99
    db $5A
    dw Data_05A_5FB4
    db $5A
    dw Data_05A_5FCF
    db $5A
    dw Data_05A_5FED
    db $5A

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5C50:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $169C50, $D0

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5D20:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $169D20, $D8

; LZSS-compressed asset: 252 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5DF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $169DF8, $FC

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5EF4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $169EF4, $A5

; LZSS-compressed asset: 27 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5F99:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3E, $04, $00, $52, $0D, $00, $50, $0F, $4D
    db $00, $B0, $0F, $4D, $00, $C2, $04, $00, $18, $1F, $29

; LZSS-compressed asset: 27 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5FB4:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3C, $04, $00, $50, $0D, $00, $4E, $0F, $4D
    db $00, $AE, $0F, $43, $00, $B2, $0E, $00, $16, $1F, $2B

; LZSS-compressed asset: 30 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5FCF:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $01, $04, $00, $02, $0B, $01, $01, $00, $00, $0F, $4D, $00
    db $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $D0, $0A, $00, $3E, $1F, $13

; LZSS-compressed asset: 30 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_5FED:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $01, $04, $00, $02, $0B, $01, $01, $00, $00, $0F, $4D, $00
    db $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $D0, $0A, $00, $3E, $1F, $13
    dw Data_05A_6023
    db $5A
    dw Data_05A_60E5
    db $5A
    dw Data_05A_61C6
    db $5A
    dw Data_05A_62BC
    db $5A
    dw Data_05A_63B3
    db $5A
    dw Data_05A_63D3
    db $5A
    dw Data_05A_63F7
    db $5A
    dw Data_05A_6418
    db $5A

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6023:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16A023, $C2

; LZSS-compressed asset: 225 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_60E5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16A0E5, $E1

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_61C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16A1C6, $F6

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_62BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16A2BC, $F7

; LZSS-compressed asset: 32 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_63B3:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3E, $04, $00, $52, $0D, $00, $50, $0F, $33
    db $00, $46, $0F, $01, $00, $AA, $0F, $2D, $00, $9A, $0F, $01, $00, $FE, $0F, $43

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_63D3:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3C, $04, $00, $50, $0D, $00, $4E, $0F, $2B
    db $00, $4A, $0E, $00, $9E, $0F, $2B, $00, $50, $0F, $3D, $00, $9A, $08, $00, $48
    db $08, $00, $00, $0C

; LZSS-compressed asset: 33 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_63F7:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $01, $04, $00, $02, $03, $01, $01, $00, $00, $04, $00, $00
    db $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $D0, $0A, $00, $40, $1F
    db $13

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6418:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $0B, $00, $00, $0F, $31, $00
    db $00, $00, $00, $58, $02, $00, $4E, $0F, $4D, $00, $5E, $06, $00, $C8, $0A, $00
    db $C6, $0F, $4D, $00, $00, $0F, $01, $00, $3E, $1F, $07
    dw Data_05A_645B
    db $5A
    dw Data_05A_645B
    db $5A
    dw Data_05A_6506
    db $5A
    dw Data_05A_65F8
    db $5A
    dw Data_05A_66DB
    db $5A
    dw Data_05A_66DB
    db $5A
    dw Data_05A_66FD
    db $5A
    dw Data_05A_672F
    db $5A

Data_05A_645B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16A45B, $AB

Data_05A_6506:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16A506, $F2

Data_05A_65F8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16A5F8, $E3

Data_05A_66DB:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3E, $04, $00, $52, $0B, $00, $4E, $0F, $4D
    db $00, $AE, $0F, $4D, $00, $D2, $0F, $0D, $00, $4C, $06, $00, $42, $0F, $01, $00
    db $00, $04

Data_05A_66FD:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $03, $04, $04, $04, $04, $00, $00, $04, $00, $00
    db $0F, $2B, $00, $08, $00, $00, $52, $08, $00, $4E, $0F, $15, $00, $0A, $00, $00
    db $7A, $0F, $4D, $00, $9E, $0F, $01, $00, $4E, $0F, $29, $00, $0C, $0C, $00, $3E
    db $1F, $07

Data_05A_672F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16A72F, $680
    dw Data_05A_6E45
    db $5A
    dw Data_05A_6EB7
    db $5A
    dw Data_05A_6F42
    db $5A
    dw Data_05A_6FA5
    db $5A
    dw Data_05A_6FF6
    db $5A
    dw Data_05A_7056
    db $5A
    dw Data_05A_70E6
    db $5A
    dw Data_05A_7188
    db $5A
    dw Data_05A_71F6
    db $5A
    dw Data_05A_7276
    db $5A
    dw Data_05A_7310
    db $5A
    dw Data_05A_737A
    db $5A
    dw Data_05A_73FE
    db $5A
    dw Data_05A_7467
    db $5A
    dw Data_05A_74ED
    db $5A
    dw Data_05A_756A
    db $5A
    dw Data_05A_75DB
    db $5A
    dw Data_05A_7663
    db $5A
    dw Data_05A_76E4
    db $5A
    dw Data_05A_7779
    db $5A
    dw Data_05A_7815
    db $5A
    dw Data_05A_7890
    db $5A
    dw Data_05A_7915
    db $5A
    dw Data_05A_7989
    db $5A
    dw Data_05A_79E7
    db $5A
    dw Data_05A_7A5F
    db $5A
    dw Data_05A_7A90
    db $5A
    dw Data_05A_7AC8
    db $5A
    dw Data_05A_7AE4
    db $5A
    dw Data_05A_7B0A
    db $5A
    dw Data_05A_7B3C
    db $5A
    dw Data_05A_7B83
    db $5A
    dw Data_05A_7BAF
    db $5A
    dw Data_05A_7BCF
    db $5A
    dw Data_05A_7C10
    db $5A
    dw Data_05A_7C69
    db $5A
    dw Data_05A_7CAB
    db $5A
    dw Data_05A_7CD2
    db $5A
    dw Data_05A_7D0E
    db $5A
    dw Data_05A_7D4E
    db $5A
    dw Data_05A_7D94
    db $5A
    dw Data_05A_7DD8
    db $5A
    dw Data_05A_7DF9
    db $5A
    dw Data_05A_7E2F
    db $5A
    dw Data_05A_7E70
    db $5A
    dw Data_05A_7EB8
    db $5A
    dw Data_05A_7EFB
    db $5A
    dw Data_05A_7F33
    db $5A
    dw Data_05A_7F6B
    db $5A
    dw Data_05A_7F9F
    db $5A

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6E45:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16AE45, $72

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6EB7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16AEB7, $8B

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6F42:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16AF42, $63

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6FA5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16AFA5, $51

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_6FF6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16AFF6, $60

; LZSS-compressed asset: 144 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7056:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B056, $90

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_70E6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B0E6, $A2

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7188:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B188, $6E

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_71F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B1F6, $80

; LZSS-compressed asset: 154 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7276:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B276, $9A

; LZSS-compressed asset: 106 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7310:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B310, $6A

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_737A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B37A, $84

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_73FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B3FE, $69

; LZSS-compressed asset: 134 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7467:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B467, $86

; LZSS-compressed asset: 125 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_74ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B4ED, $7D

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_756A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B56A, $71

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_75DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B5DB, $88

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7663:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B663, $81

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_76E4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B6E4, $95

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7779:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B779, $9C

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7815:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B815, $7B

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7890:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B890, $85

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7915:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B915, $74

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7989:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B989, $5E

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_79E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16B9E7, $78

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7A5F:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $44, $02, $00, $58, $03, $00, $4C, $0F, $13
    db $01, $00, $86, $01, $00, $78, $0F, $05, $00, $80, $08, $00, $9C, $0F, $0D, $00
    db $AA, $06, $00, $C6, $0F, $0B, $00, $A8, $0F, $39, $00, $56, $00, $00, $34, $1F
    db $0D

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7A90:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $40, $02, $02, $02, $02, $00, $00, $00, $01
    db $00, $5C, $03, $00, $50, $0F, $01, $01, $01, $00, $54, $00, $00, $6A, $0F, $11
    db $00, $78, $02, $00, $94, $0F, $11, $00, $78, $02, $00, $C0, $0A, $00, $CC, $0F
    db $03, $00, $F5, $0F, $4D, $00, $08, $1E

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7AC8:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $3C, $01, $00, $50, $05, $00, $46, $0F, $15
    db $00, $81, $0F, $4D, $00, $E1, $0F, $4D, $00, $08, $1F, $13

; LZSS-compressed asset: 38 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7AE4:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $18, $0F, $04, $01, $00, $78, $03
    db $00, $6C, $0F, $15, $00, $7E, $08, $00, $A0, $0F, $0B, $00, $7E, $06, $00, $C8
    db $0F, $4D, $00, $00, $1F, $19

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7B0A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $1C, $0F, $08, $01, $00, $7C, $05
    db $00, $72, $0F, $0F, $05, $05, $00, $80, $0A, $00, $A4, $0E, $00, $7C, $06, $00
    db $C0, $0F, $33, $00, $C8, $0A, $00, $14, $1F, $09, $02, $02, $02, $02, $00, $34
    db $1F, $0D

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7B3C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16BB3C, $47

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7B83:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $01, $02, $00, $0F, $42, $02, $FC, $FF, $01, $02, $56, $0F, $05
    db $02, $FE, $FC, $02, $7E, $0F, $07, $02, $FE, $FA, $02, $F8, $FF, $01, $05, $05
    db $02, $BC, $0F, $13, $02, $54, $0F, $17, $02, $0E, $0F, $35

; LZSS-compressed asset: 32 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7BAF:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $9C, $0F, $28
    db $03, $03, $03, $03, $00, $EC, $0F, $0F, $00, $FC, $0F, $13, $00, $FA, $0F, $0D

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7BCF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16BBCF, $41

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7C10:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16BC10, $59

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7C69:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16BC69, $42

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7CAB:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $18, $0F, $04, $02, $02, $00, $66
    db $0F, $15, $00, $78, $0E, $00, $A0, $0F, $05, $00, $78, $0C, $00, $C8, $0F, $2D
    db $00, $90, $0F, $29, $00, $18, $0C

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7CD2:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $03, $03, $03, $00, $00, $06, $00, $04
    db $0F, $07, $00, $08, $00, $00, $22, $0F, $15, $00, $0C, $0F, $11, $00, $0A, $00
    db $00, $82, $02, $00, $78, $0F, $31, $00, $82, $06, $00, $C6, $0F, $09, $00, $D0
    db $08, $00, $EE, $0F, $07, $00, $F6, $0A, $00, $16, $1F, $2B

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7D0E:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $40, $03, $00, $54, $03, $00, $00, $02, $02
    db $02, $00, $50, $0F, $01, $00, $54, $04, $00, $58, $04, $02, $02, $00, $76, $0F
    db $09, $00, $76, $04, $00, $9A, $0F, $0B, $00, $9C, $08, $00, $C4, $0F, $0B, $00
    db $52, $06, $00, $EC, $0F, $09, $00, $50, $08, $00, $54, $08, $00, $20, $1F, $21

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7D4E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16BD4E, $46

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7D94:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16BD94, $44

; LZSS-compressed asset: 33 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7DD8:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $02, $02, $02, $01, $00, $04, $0B, $00, $00, $0F, $4D, $00
    db $10, $02, $00, $18, $0C, $00, $76, $0F, $2B, $00, $C7, $0F, $4D, $00, $08, $1F
    db $2D

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7DF9:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $01, $01, $01, $03, $00, $04, $0B, $00, $00, $0F, $05, $00
    db $28, $02, $00, $1E, $0F, $15, $00, $00, $06, $00, $50, $0F, $0F, $00, $85, $0F
    db $4D, $00, $C6, $0F, $2D, $02, $02, $02, $02, $00, $16, $1F, $0F, $00, $26, $10
    db $00, $26, $1C, $00, $4C, $14

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7E2F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16BE2F, $41

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7E70:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16BE70, $48

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7EB8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16BEB8, $43

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7EFB:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $46, $02, $02, $00, $48, $0F, $0F, $02, $00
    db $7E, $03, $00, $7C, $02, $00, $78, $0F, $05, $00, $7E, $04, $00, $7E, $06, $00
    db $A2, $0E, $00, $A4, $06, $03, $00, $D2, $05, $00, $C8, $0F, $09, $00, $D2, $06
    db $00, $EE, $0F, $03, $00, $0C, $1F, $3D

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7F33:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $07, $02, $00, $0C, $03, $00, $00, $0F, $05, $00
    db $26, $04, $00, $20, $0F, $0B, $00, $32, $06, $00, $48, $0F, $09, $00, $68, $0F
    db $3D, $03, $03, $00, $C4, $02, $00, $CE, $00, $00, $C0, $0F, $0B, $00, $F0, $0A
    db $00, $EC, $0F, $15, $00, $18, $1F, $2D

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7F6B:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $09, $00
    db $0A, $06, $00, $26, $0F, $33, $00, $08, $0F, $1D, $03, $03, $03, $03, $00, $A0
    db $0F, $07, $00, $AA, $06, $00, $C4, $0F, $09, $00, $B0, $00, $00, $E4, $0F, $0D
    db $00, $10, $1F, $3D

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05A_7F9F:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $33, $00
    db $06, $06, $00, $50, $0F, $0F, $00, $08, $02, $00, $78, $0F, $01, $00, $4C, $0C
    db $00, $9C, $0F, $39, $00, $0A, $06, $00, $F2, $0F, $03, $00, $10, $1F, $39
    ds $32, $00
