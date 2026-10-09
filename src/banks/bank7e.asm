SECTION "Bank 7E", ROMX[$4000], BANK[$7E]
    INCBIN "dwm2-cobi-us.gbc", $1F8000, $8D6

; LZSS-compressed asset: 231 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_48D6:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F88D6, $247

Data_07E_4B1D:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $1F, $00, $00, $08, $00, $00, $FF, $6B, $53, $05, $00, $08

Data_07E_4B2D:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $00, $70, $00, $08, $00, $00, $FF, $6B, $E0, $03, $00, $08
    db $00, $00, $FF, $6B, $B4, $5A, $00, $08

Data_07E_4B45:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $17, $60, $00, $08

Data_07E_4B4D:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8B4D, $58

Data_07E_4BA5:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $A0, $7D, $00, $00

Data_07E_4BAD:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $0A, $2E, $00, $00, $00, $00, $FF, $6B, $C5, $7E, $00, $08

Data_07E_4BBD:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8BBD, $50

Data_07E_4C0D:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8C0D, $58

Data_07E_4C65:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8C65, $48

Data_07E_4CAD:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $7F, $1C, $02, $00, $00, $00, $00, $FF, $6B, $5F, $03, $00, $08
    db $00, $00, $FF, $6B, $5F, $03, $00, $08, $00, $00, $BF, $5F, $3D, $2A, $00, $00
    db $00, $00, $FF, $6B, $52, $66, $00, $00, $00, $00, $5D, $4F, $D3, $19, $00, $00
    db $00, $00, $7F, $02, $1F, $00, $00, $00, $00, $00, $FF, $6B, $7F, $02, $00, $00

; LZSS-compressed asset: 45 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4CED:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8CED, $1C6

; LZSS-compressed asset: 62 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4EB3:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8EB3, $6F

; LZSS-compressed asset: 65 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4F22:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8F22, $39A

; LZSS-compressed asset: 61 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_52BC:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F92BC, $1A2

; LZSS-compressed asset: 181 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_545E:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F945E, $137

; LZSS-compressed asset: 171 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5595:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9595, $171

; LZSS-compressed asset: 80 bytes expand to 96 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5706:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9706, $1F9

; LZSS-compressed asset: 75 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_58FF:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F98FF, $4B

; LZSS-compressed asset: 74 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_594A:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F994A, $150

; LZSS-compressed asset: 92 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5A9A:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9A9A, $5C

Data_07E_5AF6:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $6B, $79, $02, $00, $00, $00, $7C, $00, $7C, $00, $7C, $00, $7C
    db $00, $7C, $00, $7C, $00, $7C, $00, $7C

; LZSS-compressed asset: 25 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5B0E:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $00, $01, $01, $50, $50, $F8, $A8, $F8, $88, $F8, $A8, $D8, $D8, $01, $A0, $FF
    db $4D, $01, $69, $0F, $4D, $01, $C9, $0F, $23

; LZSS-compressed asset: 31 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5B27:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $00, $01, $01, $10, $10, $38, $28, $7C, $44, $FE, $82, $FE, $82, $7C, $44, $38
    db $28, $10, $10, $01, $A0, $FF, $4D, $01, $6F, $0F, $4D, $01, $CF, $0F, $1D

; LZSS-compressed asset: 29 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5B46:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $00, $01, $01, $D6, $D6, $FE, $AA, $FE, $82, $01, $04, $01, $BA, $EE, $AA, $EE
    db $EE, $01, $A0, $FF, $4D, $01, $6F, $0F, $4D, $01, $CF, $0F, $1D

; LZSS-compressed asset: 85 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5B63:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9B63, $55

Data_07E_5BB8:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $7D, $3D, $11, $20
    ds $2442, $00
