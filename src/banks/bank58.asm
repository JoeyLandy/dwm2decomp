SECTION "Bank 58", ROMX[$4000], BANK[$58]
    INCBIN "dwm2-cobi-us.gbc", $160000, $AF
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $1600C1, $6E
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $160141, $4BE

; LZSS-compressed asset: 263 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_45FF:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1605FF, $107

; LZSS-compressed asset: 245 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4706:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $160706, $F5

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_47FB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1607FB, $F3

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_48EE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1608EE, $BC

; LZSS-compressed asset: 274 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_49AA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1609AA, $112

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4ABC:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $160ABC, $F7

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4BB3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $160BB3, $8F

; LZSS-compressed asset: 137 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4C42:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $160C42, $89

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_4CCB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $160CCB, $747
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $161424, $11AE
    dw Data_058_6662
    db $58
    dw Data_058_66AF
    db $58
    dw Data_058_6754
    db $58
    dw Data_058_6770
    db $58
    dw Data_058_678C
    db $58
    dw Data_058_680C
    db $58
    dw Data_058_69D1
    db $58
    dw Data_058_6A7F
    db $58
    dw Data_058_6A9B
    db $58
    dw Data_058_6B05
    db $58
    dw Data_058_6BE5
    db $58
    dw Data_058_6C69
    db $58
    dw Data_058_6C85
    db $58
    dw Data_058_6CAA
    db $58
    dw Data_058_6CEA
    db $58
    dw Data_058_6CFE
    db $58
    dw Data_058_6D12
    db $58
    dw Data_058_6D42
    db $58
    dw Data_058_6DE9
    db $58
    dw Data_058_6E22
    db $58
    dw Data_058_6E36
    db $58
    dw Data_058_6E5F
    db $58
    dw Data_058_6EB3
    db $58
    dw Data_058_6EE0
    db $58
    dw Data_058_6662
    db $58
    dw Data_058_66AF
    db $58
    dw Data_058_6754
    db $58
    dw Data_058_6770
    db $58
    dw Data_058_678C
    db $58
    dw Data_058_68F2
    db $58
    dw Data_058_69D1
    db $58
    dw Data_058_6A7F
    db $58
    dw Data_058_6A9B
    db $58
    dw Data_058_6B05
    db $58
    dw Data_058_6BE5
    db $58
    dw Data_058_6C69
    db $58
    dw Data_058_6C85
    db $58
    dw Data_058_6CAA
    db $58
    dw Data_058_6CEA
    db $58
    dw Data_058_6CFE
    db $58
    dw Data_058_6D12
    db $58
    dw Data_058_6D97
    db $58
    dw Data_058_6DE9
    db $58
    dw Data_058_6E22
    db $58
    dw Data_058_6E36
    db $58
    dw Data_058_6E5F
    db $58
    dw Data_058_6EB3
    db $58
    dw Data_058_6EE0
    db $58

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6662:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $162662, $4D

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_66AF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1626AF, $A5

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6754:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6770:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_678C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16278C, $80

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_680C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $16280C, $E6

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_68F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1628F2, $DF

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_69D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1629D1, $AE

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6A7F:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 106 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6A9B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $162A9B, $6A

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6B05:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $162B05, $E0

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6BE5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $162BE5, $84

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6C69:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6C85:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $7A, $0F, $06
    db $02, $02, $00, $C8, $0F, $0F, $02, $00, $FE, $01, $00, $F0, $0F, $0D, $00, $FE
    db $02, $00, $16, $1F, $2B

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6CAA:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $1E, $03, $03, $00, $20, $0F, $11, $02, $02
    db $02, $02, $00, $32, $0C, $00, $58, $0E, $00, $58, $00, $00, $58, $0C, $00, $7E
    db $0C, $00, $7E, $04, $00, $5A, $00, $00, $9A, $0F, $07, $00, $A2, $0F, $13, $00
    db $A0, $0A, $00, $76, $0C, $00, $F8, $0F, $01, $00, $AC, $06, $00, $16, $1F, $2B

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6CEA:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6CFE:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6D12:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $07, $02, $00, $0C, $03, $00, $00, $0F, $0B, $00
    db $0C, $04, $00, $26, $0F, $0B, $00, $32, $06, $00, $4E, $0F, $0B, $00, $30, $0F
    db $15, $00, $08, $0F, $17, $00, $BE, $0F, $3F, $00, $0A, $04, $00, $18, $1F, $29

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6D42:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $162D42, $55

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6D97:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $162D97, $52

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6DE9:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $40, $02, $00, $54, $01, $00, $46, $0F, $0B
    db $00, $54, $02, $03, $03, $00, $56, $08, $00, $78, $0F, $05, $03, $00, $A4, $01
    db $00, $56, $06, $00, $A0, $0F, $2D, $00, $7C, $0F, $15, $00, $18, $16, $00, $12
    db $1F, $13, $00, $10, $1F, $01, $00, $00, $04

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6E22:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6E36:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $09, $02, $00, $0E, $01, $00, $00, $0F, $0D, $00
    db $0E, $02, $00, $26, $0F, $37, $00, $0C, $0F, $15, $00, $0A, $04, $00, $A0, $0F
    db $11, $00, $D7, $0F, $4D, $00, $08, $1F, $1D

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6E5F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $162E5F, $54

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6EB3:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $00, $00, $07, $01, $00, $0C, $03, $00, $00, $0F, $29, $00
    db $12, $06, $00, $48, $06, $00, $50, $0F, $03, $00, $10, $02, $00, $6E, $0C, $00
    db $7C, $0F, $03, $00, $A5, $0F, $4D, $00, $05, $1F, $4D, $01, $01

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_058_6EE0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $162EE0, $A6C
    ds $6B4, $00
