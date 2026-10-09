SECTION "Bank 7D", ROMX[$4000], BANK[$7D]
    db $7D

; LZSS-compressed asset: 249 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_4001:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F4001, $F9

; LZSS-compressed asset: 231 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_40FA:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F40FA, $E7

; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_41E1:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F41E1, $DC

; LZSS-compressed asset: 209 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_42BD:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F42BD, $88D

; LZSS-compressed asset: 215 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_4B4A:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F4B4A, $D7

; LZSS-compressed asset: 225 bytes expand to 240 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_4C21:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F4C21, $295

; LZSS-compressed asset: 202 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_4EB6:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F4EB6, $CA9

; LZSS-compressed asset: 221 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_5B5F:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F5B5F, $40F

; LZSS-compressed asset: 217 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_5F6E:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F5F6E, $1797

; LZSS-compressed asset: 186 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_7705:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F7705, $3CF

; LZSS-compressed asset: 185 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07D_7AD4:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F7AD4, $51C
    ds $10, $00
