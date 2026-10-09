SECTION "Bank 49", ROMX[$4000], BANK[$49]
    INCBIN "dwm2-cobi-us.gbc", $124000, $418

Data_049_4418:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $124418, $2C4

Data_049_46DC:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1246DC, $156

Data_049_4832:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $124832, $293

Data_049_4AC5:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $124AC5, $2481
    dw Data_049_6F5E
    db $49
    dw Data_049_704F
    db $49
    dw Data_049_710E
    db $49
    dw Data_049_71F1
    db $49
    dw Data_049_72D7
    db $49
    dw Data_049_7328
    db $49
    dw Data_049_737A
    db $49
    dw Data_049_73C9
    db $49

Data_049_6F5E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $126F5E, $F1

Data_049_704F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12704F, $BF

Data_049_710E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12710E, $E3

Data_049_71F1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1271F1, $E6

Data_049_72D7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1272D7, $51

Data_049_7328:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $127328, $52

Data_049_737A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12737A, $4F

Data_049_73C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1273C9, $AC4
    ds $21, $00
    INCBIN "dwm2-cobi-us.gbc", $127EAE, $140
    ds $12, $00
