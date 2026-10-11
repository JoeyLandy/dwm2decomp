SECTION "Bank 62", ROMX[$4000], BANK[$62]
    INCBIN "dwm2-cobi-us.gbc", $188000, $B38

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 4: entry 4 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1366 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles4:: ; heuristic: key-world tileset stream; C0
Data_062_4B38:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $188B38, $556

; E-0139 (C1: entry 4 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes4::
Data_062_508E:: ; heuristic: key-world BG palettes; C0
    dw $7DA0, $7FFF, $2AB7, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $01C4, $03FF, $0348, $0084 ; entry 2
    dw $01C4, $7FFF, $0348, $0084 ; entry 3
    dw $158F, $2AB7, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $1890CE, $784

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 8: entry 8 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1243 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles8:: ; heuristic: key-world tileset stream; C0
Data_062_5852:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $189852, $4DB

; E-0139 (C1: entry 8 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes8::
Data_062_5D2D:: ; heuristic: key-world BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0188, $3FBF, $0210, $0000 ; entry 1
    dw $012F, $3FBF, $01D5, $0000 ; entry 2
    dw $012F, $3FBF, $01D5, $0000 ; entry 3
    dw $318C, $3FBF, $2A13, $0000 ; entry 4
    dw $0171, $3FBF, $2A13, $0000 ; entry 5
    dw $1415, $3FBF, $25F5, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $189D6D, $1FE2
    ds $2B1, $00
