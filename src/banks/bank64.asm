SECTION "Bank 64", ROMX[$4000], BANK[$64]
    db $64

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 2: entry 2 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1227 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles2:: ; heuristic: key-world tileset stream; C0
Data_064_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $190001, $C60

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 6: entry 6 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1159 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles6:: ; heuristic: key-world tileset stream; C0
Data_064_4C61:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $190C61, $487

; E-0139 (C1: entry 6 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes6::
Data_064_50E8:: ; heuristic: key-world BG palettes; C0
    dw $1412, $7FFF, $259F, $0063 ; entry 0
    dw $012F, $02BF, $01D5, $0000 ; entry 1
    dw $012F, $02BF, $01D5, $0000 ; entry 2
    dw $318C, $02BF, $5AD6, $0000 ; entry 3
    dw $318C, $02BF, $2A13, $0000 ; entry 4
    dw $0171, $02BF, $2A13, $0000 ; entry 5
    dw $7DA0, $02BF, $25F5, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $191128, $2EBF
    ds $19, $00
