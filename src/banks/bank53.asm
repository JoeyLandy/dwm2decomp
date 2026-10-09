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

Data_053_4BF2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14CBF2, $14C

Data_053_4D3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14CD3E, $137

Data_053_4E75:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14CE75, $14C

Data_053_4FC1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14CFC1, $12C

Data_053_50ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14D0ED, $71

Data_053_515E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14D15E, $4C

Data_053_51AA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14D1AA, $74

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
    INCBIN "dwm2-cobi-us.gbc", $14F39B, $BC7
    ds $9E, $00
