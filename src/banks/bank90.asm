SECTION "Bank 90", ROMX[$4000], BANK[$90]
    db $90

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 0: entry 0 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1166 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles0:: ; heuristic: key-world tileset stream; C0
Data_090_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $240001, $48E

; E-0139 (C1: entry 0 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes0::
Data_090_448F:: ; heuristic: key-world BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $012F, $3FBF, $03E2, $0000 ; entry 2
    dw $318C, $5294, $03E2, $0000 ; entry 3
    dw $158F, $2AB7, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7

; E-0139 (C1: entry 2 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes2::
Data_090_44CF:: ; heuristic: key-world BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $01C4, $7FFF, $5652, $0084 ; entry 1
    dw $01B5, $7FFF, $5652, $0006 ; entry 2
    dw $01C4, $7FFF, $5294, $0000 ; entry 3
    dw $7DA0, $7FFF, $7FE0, $40E0 ; entry 4
    dw $0171, $7FFF, $2A13, $0000 ; entry 5
    dw $1415, $7FFF, $25F5, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $24050F, $E9A
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
