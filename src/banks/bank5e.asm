SECTION "Bank 5E", ROMX[$4000], BANK[$5E]
    db $5E

; LZSS-compressed asset: 558 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_4001:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $178001, $22E

Data_05E_422F:: ; heuristic: argument of a bank-switching copy helper; C0
    db $4D, $01, $FF, $6B, $55, $2A, $00, $00, $88, $6E, $53, $57, $54, $55, $53, $54
    db $53, $54, $55, $55, $57, $53, $55, $54, $55, $54, $58, $59, $5A, $66
    dw Data_05E_5151
    db $51
    dw Data_05E_5151
    db $51
    dw Data_05E_5151
    db $51
    dw Data_05E_5151
    db $51
    dw Data_05E_5151
    db $51
    dw Data_05E_5D5C
    db $5E
    dw Data_05E_605F
    db $51
    dw Data_05E_7451
    db $78
    dw Data_05E_7878
    db $78
    dw Data_05E_7878
    db $78
    dw Data_05E_7878
    db $78
    dw Data_05E_7878
    INCBIN "dwm2-cobi-us.gbc", $178270, $E4
    dw Data_05E_5050
    db $50
    dw Data_05E_5050
    db $50
    dw Data_05E_5050
    db $50
    dw Data_05E_5050
    db $50
    dw Data_05E_517A
    db $51
    dw Data_05E_605B
    db $51
    dw Data_05E_6751
    db $68
    dw Data_05E_6969
    db $6A
    dw Data_05E_696A
    db $69
    dw Data_05E_6A6A
    db $69, $69, $6A, $6B, $51, $51, $63, $64, $51, $51, $6D, $52, $52
    dw Data_05E_5252
    db $52, $52
    dw Data_05E_5252
    db $52, $52
    dw Data_05E_5252
    db $6F, $51
    dw Data_05E_6551
    db $7B, $7C
    dw Data_05E_707D
    db $71, $72
    dw Data_05E_7172
    db $71, $72
    dw Data_05E_7172
    db $71, $72
    dw Data_05E_7172
    db $73, $7C
    dw Data_05E_7F7E
    ds $B5, $56
    db $03, $07, $08, $56, $56, $0D, $00, $56, $56, $56, $00
    ds $23, $56
    INCBIN "dwm2-cobi-us.gbc", $178483, $43
    ds $6A, $56
    db $57, $57, $00, $56, $56, $57, $00
    ds $12, $56
    db $57, $57, $00, $56, $56, $57, $00
    ds $12, $56
    db $57, $57, $04, $56, $56, $57, $0A, $00
    ds $11, $56
    db $57, $57, $00, $56, $56, $0A, $57, $04, $56, $56, $56, $01, $00, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $57, $0A, $00, $56, $56, $04
    ds $13, $56
    db $57, $06, $00, $56, $56, $04
    ds $13, $56
    db $57, $57, $04, $56, $56, $57, $57, $57, $07, $56, $01, $57, $06, $57, $56, $56
    db $06, $56, $56, $56, $56, $56, $56, $56, $56, $57, $57, $04, $56, $56, $0A, $0B
    db $57, $07, $56, $56, $56, $06, $57, $56, $56, $56, $56, $06, $56, $56, $56, $56
    db $56, $56, $57, $0A, $00, $56, $56, $0A
    ds $13, $56
    db $57, $57, $00, $56, $56, $57, $00
    ds $12, $56
    db $57, $57, $00, $56, $56, $57, $00
    ds $12, $56
    db $57, $57, $04, $56, $56, $57, $0A, $00
    ds $11, $56
    db $57, $57, $00, $56, $56, $0A, $57, $04, $56, $56, $56, $01, $00, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $57, $0A, $00, $56, $56, $04
    ds $13, $56
    db $57, $06, $00, $56, $56, $04
    ds $13, $56
    db $57, $57, $04, $56, $56, $57, $57, $57, $07, $56, $01, $57, $06, $57, $56, $56
    db $06, $56, $56, $56, $56, $56, $56, $56, $56, $57, $57, $04, $56, $56, $0A, $0B
    db $57, $07, $56, $56, $56, $06, $57, $56, $56, $56, $56, $06, $56, $56, $56, $56
    db $56, $56, $57, $0A, $00, $56, $56, $0A
    ds $15, $56
    db $01, $57, $57, $56, $56, $56, $01, $57
    ds $11, $56
    db $01, $57, $57, $56, $56, $56, $01, $57
    ds $11, $56
    db $05, $57, $57, $56, $56, $01, $0B, $57
    ds $10, $56
    db $03, $0D, $57, $57, $56, $01, $0B, $57, $57, $56, $56, $0D, $57, $00, $56, $56
    db $06, $06, $56, $56, $56, $56, $56, $56, $56, $56, $01, $06, $57, $56, $56, $56
    db $56, $05
    ds $11, $56
    db $01, $57, $57, $56, $56, $56, $56, $0B
    ds $11, $56
    db $0D, $57, $57, $56, $05, $57, $0B, $57, $56, $01, $00, $05, $04, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $0D, $57, $57, $56, $56, $06, $0B
    db $57, $56, $56, $05, $57, $04, $56, $56, $01, $06, $56, $56, $56, $56, $56, $56
    db $56, $56, $01, $06, $57, $56, $56, $56, $56, $05
    ds $19, $56
    INCBIN "dwm2-cobi-us.gbc", $1787DD, $D5
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $1788C2, $117
    dw Data_05E_5600
    dw Data_05E_5656
    dw Data_05E_5656
    dw Data_05E_5756
    dw Data_05E_5757
    dw Data_05E_5757
    dw Data_05E_5757
    dw Data_05E_5757
    INCBIN "dwm2-cobi-us.gbc", $1789E9, $443
    dw Data_05E_5656
    db $56
    dw Data_05E_5656
    db $56
    dw Data_05E_570D
    db $0C
    dw Data_05E_5756
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    db $57, $57
    dw Data_05E_5656
    db $56
    dw Data_05E_5656
    db $56
    dw Data_05E_5703
    db $07
    dw Data_05E_5756
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    INCBIN "dwm2-cobi-us.gbc", $178E5C, $9F
    ds $12, $57
    INCBIN "dwm2-cobi-us.gbc", $178F0D, $D2
    ds $11, $57
    INCBIN "dwm2-cobi-us.gbc", $178FF0, $60

Data_05E_5050:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $179050, $43
    dw Data_05E_560C
    dw Data_05E_5656
    dw Data_05E_570D
    dw Data_05E_5757
    dw Data_05E_5757
    dw Data_05E_5757
    dw Data_05E_5757
    dw Data_05E_5757
    INCBIN "dwm2-cobi-us.gbc", $1790A3, $AE

Data_05E_5151:: ; heuristic: target of a monotone pointer table; C0
    db $04, $56, $03, $07, $05, $56, $56, $57, $57, $57, $56, $56, $56, $01, $57, $56
    db $56, $05, $57, $57, $57, $06, $06, $06, $57, $04, $56, $56, $56, $05, $56, $56
    db $56, $56, $05, $56, $56, $56, $56, $0D, $56

Data_05E_517A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17917A, $D8

Data_05E_5252:: ; heuristic: target of a monotone pointer table; C0
    db $56, $56, $56, $0C, $56, $56, $56, $56, $57, $57, $04, $56, $56, $58, $58, $10
    db $56, $56, $58, $10
    ds $12, $56
    db $58, $58, $10, $56, $56, $58, $10
    ds $12, $56
    db $58, $58, $14, $56, $56, $58, $1A, $10
    ds $11, $56
    db $58, $58, $10, $56, $56, $1A, $58, $14, $56, $56, $56, $11, $10, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $58, $1A, $10, $56, $56, $14
    ds $13, $56
    db $58, $16, $10, $56, $56, $14
    ds $13, $56
    db $58, $58, $14, $56, $56, $58, $58, $58, $17, $56, $11, $58, $16, $58, $56, $56
    db $16, $56, $56, $56, $56, $56, $56, $56, $56, $58, $58, $14, $56, $56, $1A, $1B
    db $58, $17, $56, $56, $56, $16, $58, $56, $56, $56, $56, $16, $56, $56, $56, $56
    db $56, $56, $58, $1A, $10, $56, $56, $1A
    ds $15, $56
    db $11, $58, $58, $56, $56, $56, $11, $58
    ds $11, $56
    db $11, $58, $58, $56, $56, $56, $11, $58
    ds $11, $56
    db $15, $58, $58, $56, $56, $11, $1B, $58
    ds $10, $56
    db $13, $1D, $58, $58, $56, $11, $1B, $58, $58, $56, $56, $1D, $58, $10, $56, $56
    db $16, $16, $56, $56, $56, $56, $56, $56, $56, $56, $11, $16, $58, $56, $56, $56
    db $56, $15
    ds $11, $56
    db $11, $58, $58, $56, $56, $56, $56, $1B
    ds $11, $56
    db $1D, $58, $58, $56, $15, $58, $1B, $58, $56, $11, $10, $15, $14, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $1D, $58, $58, $56, $56, $16, $1B
    db $58, $56, $56, $15, $58, $14, $56, $56, $11, $16, $56, $56, $56, $56, $56, $56
    db $56, $56, $11, $16, $58, $56, $56, $56, $56, $15
    ds $19, $56
    INCBIN "dwm2-cobi-us.gbc", $17942B, $D5
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $179510, $F0

Data_05E_5600:: ; heuristic: target of a monotone pointer table; C0
    db $58, $58, $58, $58, $58, $58, $56, $56, $56, $56, $56, $56

Data_05E_560C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17960C, $4A

Data_05E_5656:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $179656, $AD

Data_05E_5703:: ; heuristic: target of a monotone pointer table; C0
    db $58, $56, $58, $58, $58, $10, $56, $58, $58, $14

Data_05E_570D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17970D, $49

Data_05E_5756:: ; heuristic: target of a monotone pointer table; C0
    db $58

Data_05E_5757:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $179757, $3F2
    ds $12, $58
    INCBIN "dwm2-cobi-us.gbc", $179B5B, $D2
    ds $11, $58
    INCBIN "dwm2-cobi-us.gbc", $179C3E, $11E

Data_05E_5D5C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $179D5C, $151
    ds $19, $58
    ds $19, $57
    ds $4C, $00
    INCBIN "dwm2-cobi-us.gbc", $179F2B, $130

Data_05E_605B:: ; heuristic: target of a monotone pointer table; C0
    db $73, $00, $84, $80

Data_05E_605F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17A05F, $234
    ds $1A, $00
    INCBIN "dwm2-cobi-us.gbc", $17A2AD, $2A4

Data_05E_6551:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17A551, $200

Data_05E_6751:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17A751, $218

Data_05E_6969:: ; heuristic: target of a monotone pointer table; C0
    db $DB

Data_05E_696A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17A96A, $100

Data_05E_6A6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17AA6A, $D9
    dw Data_05E_6B5B
    db $5E
    dw Data_05E_6C53
    db $5E
    dw Data_05E_6D4E
    db $5E
    dw Data_05E_6E21
    db $5E
    dw Data_05E_6EE6
    db $5E
    dw Data_05E_6F3E
    db $5E
    dw Data_05E_6F98
    db $5E
    dw Data_05E_6FDC
    db $5E

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6B5B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17AB5B, $F8

; LZSS-compressed asset: 251 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6C53:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17AC53, $FB

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6D4E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17AD4E, $D3

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6E21:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17AE21, $C5

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6EE6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17AEE6, $58

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6F3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17AF3E, $5A

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6F98:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17AF98, $44

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6FDC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17AFDC, $A1

Data_05E_707D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17B07D, $F5

Data_05E_7172:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17B172, $2DF

Data_05E_7451:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17B451, $8B
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $17B4EE, $38A

Data_05E_7878:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17B878, $475
    ds $291, $00

Data_05E_7F7E:: ; heuristic: target of a monotone pointer table; C0
    ds $82, $00
