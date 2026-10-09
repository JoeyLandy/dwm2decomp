SECTION "Bank 6E", ROMX[$4000], BANK[$6E]
    INCBIN "dwm2-cobi-us.gbc", $1B8000, $34E4

; LZSS-compressed asset: 764 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_74E4:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB4E4, $2FC

Data_06E_77E0:: ; heuristic: argument of a bank-switching copy helper; C0
    db $A0, $7D, $FF, $7F, $E0, $7F, $63, $00, $0B, $15, $17, $5F, $AE, $15, $44, $00
    db $28, $15, $17, $5F, $AE, $15, $00, $00, $8C, $21, $17, $5F, $AE, $15, $44, $00
    db $8C, $5D, $17, $5F, $B1, $5A, $00, $00, $8C, $21, $17, $5F, $9A, $02, $00, $00
    db $1B, $00, $FF, $2B, $3F, $02
    ds $7EA, $00
