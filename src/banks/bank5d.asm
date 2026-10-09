SECTION "Bank 5D", ROMX[$4000], BANK[$5D]
    db $5D

; LZSS-compressed asset: 312 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05D_4001:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $174001, $138

Data_05D_4139:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $174139, $275

; LZSS-compressed asset: 439 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05D_43AE:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1743AE, $1B7

Data_05D_4565:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $174565, $92
    dw Data_05D_5604
    db $0B, $57, $57, $56
    dw Data_05D_5656
    db $57, $00, $56, $02
    dw Data_05D_5756
    db $56, $05, $57, $56
    dw Data_05D_5757
    db $57, $57, $57, $57
    dw Data_05D_5757
    db $57, $57, $56, $01
    dw Data_05D_5757
    db $57, $56, $56, $0B
    dw Data_05D_5757
    db $56, $56, $05, $57
    dw Data_05D_5757
    db $57, $0A, $0B, $57, $57, $0A, $56, $56, $56, $57, $0C, $56, $56, $56, $57, $06
    db $56, $56, $56, $57, $04, $56, $56, $56, $57, $57, $57, $06, $06
    ds $14, $56
    db $06, $0B, $57, $57, $57, $56, $56, $05, $57, $57, $56, $01, $56, $0B, $57, $56
    db $56, $56, $56, $57, $56, $56, $56, $56, $57, $57, $57, $56, $56, $56, $57, $57
    db $02, $56, $56, $57, $57, $0C, $56, $56, $57, $0A, $56, $56, $56, $57, $04
    ds $16, $56
    INCBIN "dwm2-cobi-us.gbc", $174699, $5F
    ds $28, $56
    INCBIN "dwm2-cobi-us.gbc", $174720, $8E
    ds $25, $56
    INCBIN "dwm2-cobi-us.gbc", $1747D3, $8F
    ds $12, $56
    INCBIN "dwm2-cobi-us.gbc", $174874, $A1
    dw Data_05D_5600
    db $56, $0B
    dw Data_05D_5656
    db $01, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $05
    dw Data_05D_5657
    db $56, $56
    dw Data_05D_570D
    INCBIN "dwm2-cobi-us.gbc", $174933, $52
    ds $15, $57
    db $0A, $56, $57, $57, $04, $56, $56, $57, $57
    dw Data_05D_5604
    db $56, $57
    dw Data_05D_5604
    db $56, $56
    dw Data_05D_560A
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5757
    INCBIN "dwm2-cobi-us.gbc", $1749F5, $47
    ds $1B, $57
    INCBIN "dwm2-cobi-us.gbc", $174A57, $46
    ds $1E, $56
    INCBIN "dwm2-cobi-us.gbc", $174ABB, $60
    ds $35, $57
    INCBIN "dwm2-cobi-us.gbc", $174B50, $83
    dw Data_05D_5656
    db $0B, $56, $07, $56
    dw Data_05D_5703
    db $57, $57, $57, $57
    dw Data_05D_5757
    db $57, $57, $57, $57
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    INCBIN "dwm2-cobi-us.gbc", $174BFF, $A6
    ds $24, $58
    INCBIN "dwm2-cobi-us.gbc", $174CC9, $78
    dw Data_05D_5714
    db $56, $56, $56
    dw Data_05D_5811
    db $56, $56, $56
    dw Data_05D_5813
    db $02, $56, $56
    dw Data_05D_581D
    db $04, $56, $15
    dw Data_05D_5858
    db $04, $15, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    INCBIN "dwm2-cobi-us.gbc", $174D8E, $90
    ds $25, $58
    INCBIN "dwm2-cobi-us.gbc", $174E43, $9F
    dw Data_05D_5600
    db $56, $55
    dw Data_05D_5658
    db $56, $05
    dw Data_05D_5804
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    INCBIN "dwm2-cobi-us.gbc", $174F08, $60
    ds $1B, $58
    db $25, $56, $56, $56, $58, $58, $00, $0D, $02, $58, $14, $56, $01, $17, $58, $58
    db $17, $1D, $58, $58, $58, $58, $58, $58
    dw Data_05D_5656
    db $05, $24
    dw Data_05D_5658
    db $56, $57
    dw Data_05D_5820
    db $17, $0D
    dw Data_05D_582A
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    db $58, $58
    dw Data_05D_5858
    INCBIN "dwm2-cobi-us.gbc", $174FCD, $6D
    dw Data_05D_5615
    db $16, $58, $01
    dw Data_05D_561D
    db $56, $1B, $58
    dw Data_05D_5658
    db $56, $15, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $1B
    dw Data_05D_5858
    db $1A, $56, $11
    dw Data_05D_5858
    INCBIN "dwm2-cobi-us.gbc", $175087, $C3
    dw Data_05D_5600
    db $11, $58, $56, $56
    dw Data_05D_5656
    db $15, $1C, $12, $56
    dw Data_05D_5817
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    db $58, $58, $58, $58
    dw Data_05D_5858
    INCBIN "dwm2-cobi-us.gbc", $17518E, $71
    ds $26, $58
    ds $72, $57
    db $06, $57, $57, $57, $00, $56, $57, $57, $57, $56, $56, $57, $0A, $06, $0B, $57
    db $57, $56, $07, $56, $57, $00, $56, $56, $56
    dw Data_05D_5605
    db $56
    dw Data_05D_5656
    db $00
    dw Data_05D_5656
    db $56
    dw Data_05D_5756
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57
    dw Data_05D_5757
    db $57, $56, $56, $57, $57, $04, $56, $56, $57, $57
    dw Data_05D_5602
    db $56, $57, $57
    dw Data_05D_5604
    db $56, $57, $57
    dw Data_05D_5604
    db $56, $56, $56
    dw Data_05D_5656
    db $57, $56, $56
    dw Data_05D_5656
    db $05, $56, $56
    dw Data_05D_5656
    db $56, $56, $56
    dw Data_05D_5656
    db $56, $56, $56
    dw Data_05D_5656
    db $56, $57, $57
    dw Data_05D_5757
    db $57, $57, $06, $57, $00, $06, $56, $56, $56, $56, $56, $56, $56, $56, $08, $56
    db $56, $56, $56, $05, $57, $57, $57, $57, $57, $57, $06, $56, $0B, $57, $57, $56
    dw Data_05D_5656
    db $05, $57
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5657
    db $56, $56
    dw Data_05D_5756
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    INCBIN "dwm2-cobi-us.gbc", $1754E1, $A1
    dw Data_05D_5656
    db $56, $57
    dw Data_05D_5656
    db $56, $56
    dw Data_05D_5657
    db $56, $56
    dw Data_05D_5756
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757

Data_05D_5600:: ; heuristic: target of a monotone pointer table; C0
    db $57, $57

Data_05D_5602:: ; heuristic: target of a monotone pointer table; C0
    dw Data_05D_5757

Data_05D_5604:: ; heuristic: target of a monotone pointer table; C0
    db $57

Data_05D_5605:: ; heuristic: target of a monotone pointer table; C0
    db $57
    dw Data_05D_5757
    db $57, $57

Data_05D_560A:: ; heuristic: target of a monotone pointer table; C0
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57

Data_05D_5615:: ; heuristic: target of a monotone pointer table; C0
    db $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57

Data_05D_561D:: ; heuristic: target of a monotone pointer table; C0
    db $57
    dw Data_05D_5757
    db $57, $57
    dw Data_05D_5757
    db $57, $57, $57, $0A, $56, $56, $56, $57, $00, $56, $56, $56, $57, $02, $56, $56
    db $56, $57, $56, $0D, $0C, $07, $57, $57, $57, $57, $57, $56, $56, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $09, $56, $03, $07, $0A, $56, $56, $57, $57
    db $04, $56

Data_05D_5656:: ; heuristic: target of a monotone pointer table; C0
    db $05

Data_05D_5657:: ; heuristic: target of a monotone pointer table; C0
    db $57

Data_05D_5658:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $175658, $7C
    ds $2F, $57

Data_05D_5703:: ; heuristic: target of a monotone pointer table; C0
    db $57, $57, $57, $57, $57, $57, $57, $57, $57, $57

Data_05D_570D:: ; heuristic: target of a monotone pointer table; C0
    db $57, $57, $57, $57, $57, $57, $57

Data_05D_5714:: ; heuristic: target of a monotone pointer table; C0
    ds $42, $57

Data_05D_5756:: ; heuristic: target of a monotone pointer table; C0
    db $57

Data_05D_5757:: ; heuristic: target of a monotone pointer table; C0
    db $57, $57, $57, $57, $06, $57, $0A, $56, $56, $56, $57, $56, $56, $56, $03, $57
    db $04, $56, $56, $05, $57, $56, $56, $05, $57, $00, $56, $03, $57, $57, $56, $56
    db $0D, $57, $57, $07
    ds $14, $57
    INCBIN "dwm2-cobi-us.gbc", $17578F, $75

Data_05D_5804:: ; heuristic: target of a monotone pointer table; C0
    db $57, $57, $57, $57, $57, $57, $57, $57, $57, $57, $57, $57, $57

Data_05D_5811:: ; heuristic: target of a monotone pointer table; C0
    db $57, $57

Data_05D_5813:: ; heuristic: target of a monotone pointer table; C0
    db $57, $57, $57, $57

Data_05D_5817:: ; heuristic: target of a monotone pointer table; C0
    db $57, $57, $57, $57, $57, $57

Data_05D_581D:: ; heuristic: target of a monotone pointer table; C0
    db $57, $57, $57

Data_05D_5820:: ; heuristic: target of a monotone pointer table; C0
    db $57, $57, $57, $57, $57, $57, $57, $57, $57, $57

Data_05D_582A:: ; heuristic: target of a monotone pointer table; C0
    ds $2E, $57

Data_05D_5858:: ; heuristic: target of a monotone pointer table; C0
    ds $12, $57
    db $04, $56, $06, $57, $56, $57, $56, $56, $56, $56, $57, $02, $56, $56, $56, $57
    db $57, $57, $56, $56, $0A, $00, $56, $56, $05
    ds $14, $56
    INCBIN "dwm2-cobi-us.gbc", $175897, $86
    ds $35, $57
    db $06, $00, $56, $57, $00, $56, $56, $56, $57, $56, $56, $56, $56, $57, $57, $57
    db $57, $57, $0A, $0B, $57, $00, $06, $56, $56, $00, $56, $56, $56, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $57, $57, $57, $57, $57, $06, $06, $57, $06
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $175991, $49
    ds $37, $58
    db $25, $57, $58, $58, $58, $57, $57, $58, $58, $25, $0A, $56, $58, $58, $58, $00
    db $56, $58, $58, $58, $56, $56, $57, $56, $56, $56, $0B, $04, $56, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $03, $56, $56, $56, $56, $57, $57
    db $57, $57, $57, $57, $56, $01, $0B, $57, $57, $56, $56, $03, $57, $57, $07, $07
    ds $22, $57
    INCBIN "dwm2-cobi-us.gbc", $175A73, $8D
    ds $27, $58
    db $10, $56, $1B, $58, $58, $56, $56, $15, $58, $58, $1C, $17, $58, $58, $58, $58
    db $58, $58, $58, $58, $58, $58, $56, $56, $58, $58, $14, $56, $56, $58, $58, $56
    db $56, $56, $58, $1C, $56, $56, $07, $58, $58, $56, $05, $57, $56, $56, $56, $56
    db $57, $56, $56, $56, $05, $57, $56, $56, $03, $57, $57, $07, $0D
    ds $55, $57
    db $56, $56, $0B, $57, $57, $02, $56, $01, $57, $57, $57, $56, $56, $57, $57, $57
    db $56, $56, $57, $57, $57, $56, $56, $04, $56, $56, $56, $56, $00
    ds $15, $56
    db $58, $58, $58, $56, $56, $11, $58, $58, $56, $56, $56, $58, $58, $56, $56, $1D
    db $58, $58, $56, $56
    ds $43, $58
    INCBIN "dwm2-cobi-us.gbc", $175C42, $54
    ds $40, $57
    INCBIN "dwm2-cobi-us.gbc", $175CD6, $C8
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $175DAE, $199
    ds $A5, $57
    INCBIN "dwm2-cobi-us.gbc", $175FEC, $49
    ds $20, $58
    INCBIN "dwm2-cobi-us.gbc", $176055, $74
    ds $B2, $58
    db $14, $56, $56, $56, $58, $56, $56, $56, $03, $1C, $56, $56, $03, $2A, $58, $1C
    db $12, $1D, $58, $58, $58, $58, $58, $58, $56, $56, $1B, $58, $58, $02, $56, $56
    db $58, $58, $26, $07, $20
    ds $26, $58
    INCBIN "dwm2-cobi-us.gbc", $1761C6, $49
    ds $4E, $58
    db $16, $40, $27, $58, $14, $13, $35, $06, $58, $3F, $58, $16, $56, $58, $25, $56
    db $56, $56, $58, $25, $56, $56, $56, $22, $58, $58, $58, $58, $06, $2C, $22, $58
    db $58, $56, $56, $05, $58, $58, $56, $56, $01, $24, $58, $56, $56, $56, $57
    ds $1C, $58
    db $23, $16, $1B, $58, $4C, $00, $56, $2E, $25, $56, $56, $56, $1D, $21, $4B, $56
    db $55
    ds $3A, $58
    INCBIN "dwm2-cobi-us.gbc", $1762F3, $59
    ds $3C, $58
    db $25, $56, $56, $56, $58, $57, $04, $56, $56, $58, $2B, $57, $56, $56, $58, $58
    db $2B, $02, $56, $58, $58, $25, $04, $56, $56, $56, $56, $57, $58, $56, $56, $56
    db $05, $24, $56, $56, $56, $05, $58, $56, $56, $56, $01, $22, $56, $56, $56, $56
    db $24
    ds $3A, $58
    db $16, $16, $58, $10, $56, $56, $56, $58, $56, $56, $56, $07, $58, $14, $56, $05
    db $57, $58, $58, $58, $16, $58, $16, $39, $56, $56, $15, $56, $56, $09, $56, $1D
    db $07, $57, $56, $13, $58, $57, $04, $56, $15
    ds $1C, $58
    INCBIN "dwm2-cobi-us.gbc", $176438, $128
    ds $1C, $58
    db $56, $56, $56, $1B, $14, $56, $56, $56, $1D, $58, $56, $56, $1D, $58, $58, $1C
    ds $22, $58
    INCBIN "dwm2-cobi-us.gbc", $1765AE, $DF
    ds $1D, $58
    db $1B, $58, $58, $58, $10, $56, $16, $58, $58, $12, $56, $56, $58, $58, $14, $56
    db $56, $58, $58, $14, $56, $56, $58, $58, $58, $58, $1B, $16, $1B, $1A
    ds $11, $56
    db $58, $58, $56, $56, $58, $56, $16, $56, $15, $58, $56, $13, $58, $14, $1B, $56
    db $11, $16, $56, $56, $56, $56, $56, $56, $56, $58, $14, $1B, $58, $58, $58, $14
    db $56, $1B, $58, $1A, $56, $13, $58, $58, $56, $56, $11, $58, $58, $56, $56, $56
    ds $4D, $58
    INCBIN "dwm2-cobi-us.gbc", $176756, $DA
    ds $55, $58
    INCBIN "dwm2-cobi-us.gbc", $176885, $DD
    ds $3F, $58
    db $16, $16, $56, $58, $14, $56, $56, $56, $58, $58, $56, $56, $56, $58, $58, $58
    db $58, $58, $1A, $10, $11, $58, $58, $56, $56, $56, $1D, $58, $56, $56, $15, $58
    db $58, $56, $56
    ds $1D, $58
    INCBIN "dwm2-cobi-us.gbc", $1769E1, $A6
    ds $3B, $58
    db $56, $56, $56, $56, $58, $56, $56, $56, $03, $58, $56, $56, $03, $57, $1A, $56
    db $56, $0D, $57, $14, $56, $57, $57, $57, $56, $56, $1B, $58, $58, $07, $00, $11
    db $58, $58, $57, $56, $13, $58, $58, $0A, $56, $1D, $58, $58, $04, $56
    ds $36, $58
    INCBIN "dwm2-cobi-us.gbc", $176B26, $175
    ds $35, $58
    INCBIN "dwm2-cobi-us.gbc", $176CD0, $EC
    ds $58, $58
    db $1A, $56, $06, $57, $58, $14, $56, $56, $0D, $58, $1C, $56, $56, $56, $58, $58
    db $1C, $17, $1D, $58, $58, $58, $58, $58, $04, $56, $56, $56, $15, $0A, $56, $56
    db $56, $58, $56, $56, $56, $1D, $58, $1C, $56, $1D
    ds $15, $58
    db $1A, $58, $58, $58, $10, $56, $58, $58, $58, $56, $56, $58, $58, $23, $58, $58
    db $58, $1A, $56, $52, $58, $10, $56, $03, $2A, $58, $56, $56, $0D, $58, $58, $56
    db $56, $57
    ds $36, $58
    INCBIN "dwm2-cobi-us.gbc", $176EAB, $47
    ds $1E, $58
    db $10, $56, $58, $58, $58, $12, $56, $58, $58, $58, $58, $17, $58, $58, $58, $58
    db $58, $58, $58, $58, $58, $58, $56, $05, $57, $00, $56, $56, $56, $00, $56, $58
    db $12, $56, $56, $56, $1D, $58, $12, $56, $58, $58, $58, $58, $58, $58, $58, $56
    db $56, $56, $58, $58, $1C, $12, $1D
    ds $2A, $58
    db $57, $57, $57, $0A, $06, $0A, $06, $56, $56, $56, $04, $56, $56, $56, $56, $04
    db $56, $56, $56, $56, $04, $56, $56, $56, $56, $06, $57, $57, $0A, $06
    ds $14, $56
    db $0B, $57, $0B, $57, $57, $56, $00, $56, $00
    ds $10, $56
    db $57, $57, $57, $57, $57, $56, $05, $57, $57, $57, $56, $56, $57, $57, $57, $56
    db $56, $57, $57, $57, $56
    ds $36, $57
    db $04, $56, $56, $56, $56, $0C, $02, $56, $56, $56, $57, $04, $56, $56, $56, $57
    db $00, $56, $56, $56, $57
    ds $37, $56
    INCBIN "dwm2-cobi-us.gbc", $177053, $5F
    ds $6B, $56
    db $57, $57, $56, $56, $57, $57, $57, $56, $56, $57, $57, $57, $56, $56, $56, $01
    db $57, $56, $56, $56, $56, $57, $0C, $56, $56, $56, $56, $57, $56, $56, $56, $56
    db $57, $56, $56, $56, $56, $0A, $56, $56, $56, $56, $04
    ds $6C, $56
    db $57, $56, $56, $56, $56, $05, $56, $56, $56, $56, $05, $56, $56, $56, $56, $0D
    db $56, $56, $56, $57, $57, $04, $56, $56, $56, $56, $04, $56, $56, $56, $56, $57
    db $56, $56, $56, $56, $57, $04, $56, $56, $56, $57, $57, $57, $57, $57
    ds $14, $56
    db $57, $57, $57, $57, $57
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $17720B, $54
    ds $67, $57
    INCBIN "dwm2-cobi-us.gbc", $1772C6, $B9
    ds $13, $57
    INCBIN "dwm2-cobi-us.gbc", $177392, $A1
    ds $18, $56
    INCBIN "dwm2-cobi-us.gbc", $17744B, $4F
    ds $1F, $56
    INCBIN "dwm2-cobi-us.gbc", $1774B9, $5F
    ds $1D, $56
    INCBIN "dwm2-cobi-us.gbc", $177535, $15D
    ds $96E, $00
