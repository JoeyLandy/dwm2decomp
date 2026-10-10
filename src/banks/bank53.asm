SECTION "Bank 53", ROMX[$4000], BANK[$53]
    INCBIN "dwm2-cobi-us.gbc", $14C000, $BC8
    ds $12, $00
    dw Data_053_4BF2
    db $53
    dw Data_053_4D3E
    db $53
    dw Data_053_4E75
    db $53
    dw Data_053_4FC1
    db $53
    dw Data_053_50ED
    db $53
    dw Data_053_515E
    db $53
    dw Data_053_51AA
    db $53
    dw Data_053_521E
    db $53

; LZSS-compressed asset: 332 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4BF2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14CBF2, $14C

; LZSS-compressed asset: 311 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4D3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14CD3E, $137

; LZSS-compressed asset: 332 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4E75:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14CE75, $14C

; LZSS-compressed asset: 300 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4FC1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14CFC1, $12C

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_50ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14D0ED, $71

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_515E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14D15E, $4C

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_51AA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14D1AA, $74

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_521E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14D21E, $4D1
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $14D701, $615
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $14DD28, $122A
    ds $1A, $00
    dw Data_053_6F84
    db $53
    dw Data_053_6F84
    db $53
    dw Data_053_7097
    db $53
    dw Data_053_71DB
    db $53
    dw Data_053_7313
    db $53
    dw Data_053_7313
    db $53
    dw Data_053_7352
    db $53
    dw Data_053_739B
    db $53

Data_053_6F84:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14EF84, $113

Data_053_7097:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14F097, $144

Data_053_71DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14F1DB, $138

Data_053_7313:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $22, $01, $02, $35, $02, $02, $29, $0F, $00, $02
    db $3B, $08, $02, $48, $04, $02, $3B, $07, $02, $5B, $05, $02, $3B, $04, $02, $6E
    db $06, $02, $39, $05, $02, $7F, $09, $02, $8B, $0F, $42, $02, $92, $0A, $02, $EE
    db $0F, $13, $04, $04, $02, $16, $1F, $05, $02, $92, $0A, $02, $3C, $1F, $05

Data_053_7352:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14F352, $49

Data_053_739B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14F39B, $478

; LZSS-compressed asset: 261 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7813:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14F813, $105

; LZSS-compressed asset: 240 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7918:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14F918, $F0

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7A08:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14FA08, $C8

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7AD0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14FAD0, $C5

; LZSS-compressed asset: 291 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7B95:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14FB95, $123

; LZSS-compressed asset: 303 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7CB8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14FCB8, $2AA
    ds $9E, $00
