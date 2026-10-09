SECTION "Bank 21", ROMX[$4000], BANK[$21]
    INCBIN "dwm2-cobi-us.gbc", $084000, $3548

; LZSS-compressed asset: 249 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_021_7548:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $087548, $910
    ds $1A8, $00
