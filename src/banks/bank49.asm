SECTION "Bank 49", ROMX[$4000], BANK[$49]
    INCBIN "dwm2-cobi-us.gbc", $124000, $418

; LZSS-compressed asset: 708 bytes expand to 1168 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_4418:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $124418, $2C4

Data_049_46DC:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1246DC, $156

; LZSS-compressed asset: 659 bytes expand to 960 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_4832:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $124832, $293

Data_049_4AC5:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $124AC5, $156

; LZSS-compressed asset: 1696 bytes expand to 1984 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_4C1B:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $124C1B, $6A0

Data_049_52BB:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1252BB, $64

; LZSS-compressed asset: 250 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_531F:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $12531F, $40E

; LZSS-compressed asset: 163 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_572D:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $12572D, $1819
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

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_6F5E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $126F5E, $F1

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_704F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12704F, $BF

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_710E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12710E, $E3

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_71F1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1271F1, $E6

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_72D7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1272D7, $51

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_7328:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $127328, $52

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_737A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12737A, $4F

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_049_73C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1273C9, $AC4
    ds $21, $00
    INCBIN "dwm2-cobi-us.gbc", $127EAE, $140
    ds $12, $00
