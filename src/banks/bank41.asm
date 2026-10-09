SECTION "Bank 41", ROMX[$4000], BANK[$41]
    db $41, $40, $00
    dw Data_041_4055
    db $60, $01
    dw Data_041_4269
    db $80, $02
    dw Data_041_4477
    db $40, $00
    dw Data_041_4677
    db $60, $01
    dw Data_041_47B1
    db $80, $02
    dw Data_041_48F9
    db $40, $00
    dw Data_041_4A63
    db $60, $01
    dw Data_041_4F1D
    db $80, $02
    dw Data_041_53B1
    db $40, $00
    dw Data_041_59F3
    db $60, $01
    dw Data_041_5E83
    db $80, $02
    dw Data_041_6009
    db $40, $00
    dw Data_041_633D
    db $60, $01
    dw Data_041_66A7
    db $80, $02
    dw Data_041_6A07
    db $40, $00
    dw Data_041_6E2D
    db $60, $01
    dw Data_041_7267
    db $80, $02
    dw Data_041_7645
    db $40, $00
    dw Data_041_788B
    db $60, $01
    dw Data_041_7C65
    db $80, $02
    dw Data_041_7E97

Data_041_4055:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $104055, $214

Data_041_4269:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $104269, $20E

Data_041_4477:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $104477, $200

Data_041_4677:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $104677, $13A

Data_041_47B1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1047B1, $148

Data_041_48F9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1048F9, $16A

Data_041_4A63:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $104A63, $4BA

Data_041_4F1D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $104F1D, $494

Data_041_53B1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1053B1, $642

Data_041_59F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1059F3, $490

Data_041_5E83:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $105E83, $186

Data_041_6009:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $106009, $334

Data_041_633D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10633D, $36A

Data_041_66A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1066A7, $360

Data_041_6A07:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $106A07, $426

Data_041_6E2D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $106E2D, $43A

Data_041_7267:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $107267, $3DE

Data_041_7645:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $107645, $246

Data_041_788B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $10788B, $3DA

Data_041_7C65:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $107C65, $232

Data_041_7E97:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $107E97, $169
