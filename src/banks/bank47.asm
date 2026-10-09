SECTION "Bank 47", ROMX[$4000], BANK[$47]
    INCBIN "dwm2-cobi-us.gbc", $11C000, $229A

; LZSS-compressed asset: 1352 bytes expand to 1616 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_629A:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $11E29A, $548

Data_047_67E2:: ; heuristic: argument of a bank-switching copy helper; C0
    db $A0, $7D, $FF, $7F, $E0, $7F, $63, $00, $2F, $01, $FF, $4F, $D8, $01, $63, $0C
    db $28, $15, $FF, $2B, $FF, $00, $00, $00, $2F, $01, $3F, $2B, $D8, $01, $00, $00
    db $28, $15, $95, $36, $AE, $15, $00, $00, $1B, $00, $FF, $2B, $3F, $02, $00, $00
    db $88, $01, $BF, $4F, $D3, $01, $00, $00, $20, $00, $20, $00, $20, $00, $20, $00
    dw Data_047_68B2
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_6965
    db $47
    dw Data_047_6A3C
    db $47
    dw Data_047_6B0A
    db $47
    dw Data_047_6B9B
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6D02
    db $47
    dw Data_047_6D3C
    db $47
    dw Data_047_6DAA
    db $47
    dw Data_047_6DE4
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_6965
    db $47
    dw Data_047_6A3C
    db $47
    dw Data_047_6B0A
    db $47
    dw Data_047_6B9B
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6D02
    db $47
    dw Data_047_6D3C
    db $47
    dw Data_047_6DAA
    db $47
    dw Data_047_6DE4
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_68B2
    db $47
    dw Data_047_6965
    db $47
    dw Data_047_6A3C
    db $47
    dw Data_047_6B53
    db $47
    dw Data_047_6C0A
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6C77
    db $47
    dw Data_047_6D02
    db $47
    dw Data_047_6D3C
    db $47
    dw Data_047_6DC7
    db $47
    dw Data_047_6E01
    db $47

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_68B2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $11E8B2, $B3

; LZSS-compressed asset: 108 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6965:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $11E965, $D7

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6A3C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $11EA3C, $CE

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6B0A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $11EB0A, $49

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6B53:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $11EB53, $48

; LZSS-compressed asset: 111 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6B9B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $11EB9B, $6F

; LZSS-compressed asset: 109 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6C0A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $11EC0A, $6D

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6C77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $11EC77, $8B

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6D02:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $76, $0F, $02
    db $02, $02, $00, $C4, $0F, $13, $00, $FD, $0F, $4D, $00, $08, $16, $68, $01, $00
    db $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $76, $0F, $02, $02, $02, $00
    db $C4, $0F, $13, $00, $FD, $0F, $4D, $00, $08, $16

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6D3C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $11ED3C, $6E

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6DAA:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $6C, $07, $02
    db $02, $00, $BA, $0F, $13, $00, $F3, $0F, $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6DC7:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $6C, $07, $02
    db $02, $00, $C4, $0F, $13, $00, $F3, $0F, $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6DE4:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $6C, $07, $02
    db $02, $00, $BA, $0F, $13, $00, $F3, $0F, $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6E01:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $11EE01, $10FA
    ds $105, $00
