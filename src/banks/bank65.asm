SECTION "Bank 65", ROMX[$4000], BANK[$65]
    db $65

; E-0139 (C1: entry 3 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes3::
Data_065_4001:: ; heuristic: key-world BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $026E, $3F7F, $02F3, $0188 ; entry 1
    dw $0152, $3F7F, $0218, $00C8 ; entry 2
    dw $2130, $3F7F, $39D9, $00C8 ; entry 3
    dw $158F, $3FBF, $2AB7, $0000 ; entry 4
    dw $0171, $3FBF, $2A13, $0000 ; entry 5
    dw $0018, $3F7F, $0218, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $194041, $797

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 7: entry 7 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1185 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles7:: ; heuristic: key-world tileset stream; C0
Data_065_47D8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1947D8, $4A1

; E-0139 (C1: entry 7 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes7::
Data_065_4C79:: ; heuristic: key-world BG palettes; C0
    dw $1412, $7FFF, $259F, $0063 ; entry 0
    dw $318C, $5AD6, $4631, $0000 ; entry 1
    dw $1415, $7DFF, $7C18, $2C09 ; entry 2
    dw $318C, $5AD6, $4631, $0000 ; entry 3
    dw $318C, $5AD6, $2A13, $0000 ; entry 4
    dw $0171, $3FBF, $5294, $0000 ; entry 5
    dw $7DA0, $3FBF, $5294, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $194CB9, $12C1

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
