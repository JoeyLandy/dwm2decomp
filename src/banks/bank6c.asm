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

Data_06C_7254:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3254, $110

Data_06C_7364:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3364, $68

Data_06C_73CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B33CC, $116

Data_06C_74E2:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $0F, $06, $06, $06, $00, $16, $06, $00, $16, $02
    db $00, $2A, $0A, $00, $26, $0F, $1F, $00, $62, $0E, $00, $22, $08, $00, $76, $0F
    db $07, $00, $0E, $0F, $09, $00, $16, $08, $00, $7C, $0F, $15, $00, $EA, $0F, $13
    db $00, $28, $0A, $00, $22, $0F, $01, $00, $00, $0F, $07, $00, $00, $0E

Data_06C_7520:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3520, $E0

Data_06C_7600:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3600, $57

Data_06C_7657:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3657, $F7

Data_06C_774E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B374E, $46

Data_06C_7794:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3794, $11E

Data_06C_78B2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1B38B2, $671
    ds $DD, $00
