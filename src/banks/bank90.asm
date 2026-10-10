SECTION "Bank 90", ROMX[$4000], BANK[$90]
    INCBIN "dwm2-cobi-us.gbc", $240000, $13A9
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $2413BB, $78B
    ds $22, $00
    INCBIN "dwm2-cobi-us.gbc", $241B68, $16CB

; LZSS-compressed asset: 875 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_7233:: ; heuristic: stream decompressed while the game ran on the emulator; C0
    INCBIN "dwm2-cobi-us.gbc", $243233, $4AD

; LZSS-compressed asset: 260 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_76E0:: ; heuristic: stream decompressed while the game ran on the emulator; C0
    INCBIN "dwm2-cobi-us.gbc", $2436E0, $13B

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_781B:: ; heuristic: stream decompressed while the game ran on the emulator; C0
    INCBIN "dwm2-cobi-us.gbc", $24381B, $63A
    ds $1AB, $00
