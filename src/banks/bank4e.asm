SECTION "Bank 4E", ROMX[$4000], BANK[$4E]
    INCBIN "dwm2-cobi-us.gbc", $138000, $5D3
    dw Data_04E_4603
    db $4E
    dw Data_04E_46E4
    db $4E
    dw Data_04E_47D5
    db $4E
    dw Data_04E_4991
    db $4E
    dw Data_04E_4B40
    db $4E
    dw Data_04E_4B8F
    db $4E
    dw Data_04E_4BE9
    db $4E
    dw Data_04E_4C61
    db $4E
    dw Data_04E_4603
    db $4E
    dw Data_04E_46E4
    db $4E
    dw Data_04E_48B9
    db $4E
    dw Data_04E_4A78
    db $4E
    dw Data_04E_4B40
    db $4E
    dw Data_04E_4B8F
    db $4E
    dw Data_04E_4C25
    db $4E
    dw Data_04E_4C9E
    db $4E

; LZSS-compressed asset: 225 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4603:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $138603, $E1

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_46E4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1386E4, $F1

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_47D5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1387D5, $E4

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_48B9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1388B9, $D8

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4991:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $138991, $E7

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4A78:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $138A78, $C8

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4B40:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $138B40, $4F

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4B8F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $138B8F, $5A

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4BE9:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $17, $02, $02, $01, $FF, $F4, $04, $01, $34, $01
    db $01, $26, $0F, $05, $01, $36, $04, $01, $46, $0F, $0F, $01, $FF, $FE, $01, $7A
    db $0F, $01, $01, $F0, $FF, $29, $01, $2A, $06, $01, $FA, $FF, $1D, $06, $01, $18
    db $17, $01, $16, $1A, $01, $1E, $1F, $07, $01, $3A, $1F, $09

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4C25:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $17, $02, $02, $01, $FF, $F4, $04, $01, $34, $01
    db $01, $26, $0F, $05, $01, $36, $04, $01, $46, $0F, $0F, $01, $FF, $FE, $01, $7A
    db $0F, $01, $01, $F0, $FF, $29, $01, $2A, $06, $01, $FA, $FF, $1D, $06, $01, $18
    db $17, $01, $16, $1A, $01, $1E, $1F, $07, $01, $3A, $1F, $09

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4C61:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $05, $02, $02, $01, $FC, $FF, $09, $04, $04, $01
    db $18, $0E, $01, $36, $0F, $03, $04, $04, $01, $4E, $0F, $11, $01, $12, $04, $01
    db $18, $0F, $0B, $01, $12, $0F, $03, $01, $8C, $00, $01, $8E, $0F, $11, $01, $FF
    db $FC, $06, $01, $FA, $05, $01, $F0, $0F, $01, $01, $0E, $1F, $3D

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4C9E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $138C9E, $1393
    dw Data_04E_6091
    db $4E
    dw Data_04E_6173
    db $4E
    dw Data_04E_61CD
    db $4E
    dw Data_04E_62BC
    db $4E
    dw Data_04E_62CF
    db $4E
    dw Data_04E_6395
    db $4E
    dw Data_04E_6467
    db $4E
    dw Data_04E_6549
    db $4E
    dw Data_04E_65F7
    db $4E
    dw Data_04E_66CD
    db $4E
    dw Data_04E_67CB
    db $4E
    dw Data_04E_68AB
    db $4E
    dw Data_04E_6942
    db $4E
    dw Data_04E_6A2B
    db $4E
    dw Data_04E_6ADA
    db $4E
    dw Data_04E_6BB1
    db $4E
    dw Data_04E_6C80
    db $4E
    dw Data_04E_6CD6
    db $4E
    dw Data_04E_6CF8
    db $4E
    dw Data_04E_6D4A
    db $4E
    dw Data_04E_6D5D
    db $4E
    dw Data_04E_6DB0
    db $4E
    dw Data_04E_6E06
    db $4E
    dw Data_04E_6E67
    db $4E
    dw Data_04E_6EA8
    db $4E
    dw Data_04E_6F01
    db $4E
    dw Data_04E_6F63
    db $4E
    dw Data_04E_6FC3
    db $4E
    dw Data_04E_6FFA
    db $4E
    dw Data_04E_704E
    db $4E
    dw Data_04E_7090
    db $4E
    dw Data_04E_70D1
    db $4E

; LZSS-compressed asset: 226 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6091:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A091, $E2

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6173:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A173, $5A

; LZSS-compressed asset: 239 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_61CD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A1CD, $EF

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_62BC:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_62CF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A2CF, $C6

; LZSS-compressed asset: 210 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6395:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A395, $D2

; LZSS-compressed asset: 226 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6467:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A467, $E2

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6549:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A549, $AE

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_65F7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A5F7, $D6

; LZSS-compressed asset: 254 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_66CD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A6CD, $FE

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_67CB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A7CB, $E0

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_68AB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A8AB, $97

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6942:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13A942, $E9

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6A2B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13AA2B, $AF

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6ADA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13AADA, $D7

; LZSS-compressed asset: 207 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6BB1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13ABB1, $CF

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6C80:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13AC80, $56

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6CD6:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $FF, $3D, $05, $01, $50, $0F, $14, $02, $01, $78, $0F
    db $14, $03, $01, $A0, $0F, $4D, $01, $B8, $0F, $04, $01, $50, $0F, $15, $01, $A0
    db $FF, $15

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6CF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13ACF8, $52

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6D4A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6D5D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13AD5D, $53

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6DB0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13ADB0, $56

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6E06:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13AE06, $61

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6E67:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13AE67, $41

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6EA8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13AEA8, $59

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6F01:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13AF01, $62

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6F63:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13AF63, $60

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6FC3:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $FF, $F0, $05, $05, $03, $01, $06, $01, $05, $05, $01, $FA
    db $FF, $3D, $01, $0C, $06, $01, $54, $0F, $09, $02, $02, $01, $72, $0F, $0D, $01
    db $04, $0E, $01, $A4, $0F, $01, $01, $A2, $06, $01, $C2, $0F, $0D, $01, $02, $04
    db $01, $EA, $0F, $4D, $01, $0E, $16

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6FFA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13AFFA, $54

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_704E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13B04E, $42

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_7090:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13B090, $41

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_70D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13B0D1, $E1D
    ds $112, $00
