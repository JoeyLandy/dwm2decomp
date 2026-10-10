SECTION "Bank 65", ROMX[$4000], BANK[$65]
    INCBIN "dwm2-cobi-us.gbc", $194000, $1F7A

; LZSS-compressed asset: 485 bytes expand to 514 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5F7A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $195F7A, $1E5

; LZSS-compressed asset: 1253 bytes expand to 1281 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_615F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $19615F, $4E5

; LZSS-compressed asset: 512 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6644:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $196644, $200

; LZSS-compressed asset: 509 bytes expand to 526 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6844:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $196844, $1FD

; LZSS-compressed asset: 517 bytes expand to 514 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6A41:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $196A41, $205

; LZSS-compressed asset: 97 bytes expand to 380 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6C46:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $196C46, $FF9
    ds $3C1, $00
