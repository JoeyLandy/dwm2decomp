SECTION "Bank 63", ROMX[$4000], BANK[$63]
    db $63

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 1: entry 1 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1127 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles1:: ; heuristic: key-world tileset stream; C0
Data_063_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $18C001, $467

; E-0139 (C1: entry 1 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes1::
Data_063_4468:: ; heuristic: key-world BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $1415, $7DFF, $7C18, $2C09 ; entry 2
    dw $318C, $5294, $03E2, $0000 ; entry 3
    dw $158F, $2AB7, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $18C4A8, $7C3

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 5: entry 5 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1285 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles5:: ; heuristic: key-world tileset stream; C0
Data_063_4C6B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $18CC6B, $505

; E-0139 (C1: entry 5 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes5::
Data_063_5170:: ; heuristic: key-world BG palettes; C0
    dw $012F, $7FFF, $2AB7, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $0142, $03FF, $034E, $0000 ; entry 2
    dw $318C, $5294, $03E2, $0000 ; entry 3
    dw $158F, $2AB7, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $18D1B0, $757

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 9: entry 9 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1190 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles9:: ; heuristic: key-world tileset stream; C0
Data_063_5907:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $18D907, $4A6

; E-0139 (C1: entry 9 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes9::
Data_063_5DAD:: ; heuristic: key-world BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $012F, $3FBF, $03E2, $0000 ; entry 2
    dw $318C, $7FFF, $03E2, $0000 ; entry 3
    dw $0160, $3FBF, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $18DDED, $1ED7
    ds $33C, $00
