SECTION "Bank 6C", ROMX[$4000], BANK[$6C]
    INCBIN "dwm2-cobi-us.gbc", $1B0000, $81B
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $1B082D, $66D
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $1B0EAC, $603
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $1B14C1, $5F0
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $1B1AC3, $1773
    dw Data_06C_7254
    db $6C
    dw Data_06C_7364
    db $6C
    dw Data_06C_73CC
    db $6C
    dw Data_06C_74E2
    db $6C
    dw Data_06C_7520
    db $6C
    dw Data_06C_7600
    db $6C
    dw Data_06C_7657
    db $6C
    dw Data_06C_774E
    db $6C
    dw Data_06C_7794
    db $6C
    dw Data_06C_78B2
    db $6C

; LZSS-compressed asset: 272 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7254:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3254, $110

; LZSS-compressed asset: 104 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7364:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3364, $68

; LZSS-compressed asset: 278 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_73CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B33CC, $116

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_74E2:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $06, $06, $06, $00, $16, $06, $00, $16, $02
    db $00, $2A, $0A, $00, $26, $0F, $1F, $00, $62, $0E, $00, $22, $08, $00, $76, $0F
    db $07, $00, $0E, $0F, $09, $00, $16, $08, $00, $7C, $0F, $15, $00, $EA, $0F, $13
    db $00, $28, $0A, $00, $22, $0F, $01, $00, $00, $0F, $07, $00, $00, $0E

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7520:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3520, $E0

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7600:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3600, $57

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7657:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3657, $F7

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_774E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B374E, $46

; LZSS-compressed asset: 286 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7794:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3794, $11E

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_78B2:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $42, $06, $00, $56, $03, $00, $4A, $0F, $0D
    db $00, $54, $02, $00, $46, $0F, $01, $00, $4C, $09, $00, $7D, $06, $00, $5B, $05
    db $00, $A4, $08, $00, $4E, $05, $00, $B9, $0F, $18, $00, $ED, $0A, $00, $95, $0F
    db $00, $00, $B5, $0F, $05, $06, $00, $7E, $04, $00, $96, $0B, $00, $59, $0F, $0C

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_78F2:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B38F2, $B0

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_79A2:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B39A2, $46

; LZSS-compressed asset: 157 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_79E8:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B39E8, $9D

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7A85:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $40, $01, $00, $54, $07, $00, $4C, $0F, $05
    db $00, $5A, $0F, $0B, $00, $50, $0E, $01, $01, $03, $03, $00, $98, $0F, $11, $03
    db $03, $00, $A4, $02, $00, $C4, $0F, $05, $00, $52, $02, $00, $4C, $08, $00, $FA
    db $08, $00, $FA, $0C, $00, $68, $0F, $03, $00, $20, $1F, $21

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7AC1:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3AC1, $B0

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7B71:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3B71, $42

; LZSS-compressed asset: 172 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7BB3:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3BB3, $AC

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7C5F:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3C5F, $43

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7CA2:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3CA2, $99

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7D3B:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $40, $01, $00, $54, $07, $00, $4C, $0F, $07
    db $00, $5C, $0E, $00, $78, $0F, $09, $01, $01, $03, $03, $00, $98, $0F, $11, $03
    db $03, $00, $8A, $04, $00, $C6, $0F, $0B, $00, $74, $0A, $00, $F2, $0F, $05, $00
    db $54, $0C, $00, $1A, $1F, $27

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7D71:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3D71, $94

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7E05:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $40, $01, $00, $54, $07, $00, $4C, $0F, $05
    db $00, $5A, $0E, $00, $76, $0F, $0B, $01, $01, $03, $03, $00, $98, $0F, $11, $03
    db $03, $00, $88, $04, $00, $C6, $0F, $03, $00, $E8, $06, $00, $EE, $08, $00, $F2
    db $0F, $05, $00, $68, $0F, $03, $00, $20, $1F, $21

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7E3F:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3E3F, $A5

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7EE4:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $2D, $00, $08, $00, $00, $54, $04, $00, $4C, $0F, $07, $00, $5C, $0C, $00
    db $76, $0F, $0B, $01, $01, $03, $03, $00, $98, $0F, $11, $03, $03, $00, $A4, $02
    db $00, $C4, $0F, $0D, $00, $80, $0F, $13, $00, $54, $0C, $00, $1A, $1F, $27
    ds $DD, $00
