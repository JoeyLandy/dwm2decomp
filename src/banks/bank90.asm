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

; compressed tileset of map $26 (the first map record using it)
; LZSS-compressed asset: 1529 bytes expand to 1776 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map26Tileset:: ; heuristic: map tileset stream; C0
Data_090_450F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $24050F, $5F9

; compressed tileset of map $29 (the first map record using it)
; LZSS-compressed asset: 1014 bytes expand to 1264 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map29Tileset:: ; heuristic: special map tileset stream; C0
Data_090_4B08:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $240B08, $3F6

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map29Palettes::
Data_090_4EFE:: ; heuristic: special map BG palettes; C0
    dw $3126, $7FFF, $7E0A, $0000 ; entry 0
    dw $3126, $035F, $7E0A, $0000 ; entry 1
    dw $010B, $6BFF, $1DB0, $0000 ; entry 2
    dw $1929, $5F17, $2E0E, $0000 ; entry 3
    dw $30E9, $5F17, $49CD, $0044 ; entry 4
    dw $2CC9, $6BFF, $49CD, $0000 ; entry 5
    dw $7FFF, $7FFF, $7FFF, $7FFF ; entry 6
    dw $7FFF, $7FFF, $7FFF, $7FFF ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map29Screens0::
Data_090_4F3E:: ; heuristic: map screen array; C0
    dfar Data_090_4F44 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map29Attrs0::
Data_090_4F41:: ; heuristic: map screen array; C0
    dfar Data_090_5065 ; entry 0

; LZSS-compressed asset: 289 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_4F44:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $240F44, $121

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_5065:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $241065, $72

; compressed tileset of map $3D (the first map record using it)
; LZSS-compressed asset: 676 bytes expand to 1168 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3DTileset:: ; heuristic: map tileset stream; C0
Data_090_50D7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2410D7, $2A4

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map3DPalettes::
Data_090_537B:: ; heuristic: map BG palettes; C0
    dw $1528, $7FFF, $6B2B, $0000 ; entry 0
    dw $010E, $7BDE, $22BA, $0000 ; entry 1
    dw $0000, $0000, $0000, $0000 ; entry 2
    dw $010E, $3F7F, $0216, $0000 ; entry 3
    dw $0016, $2294, $11D4, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3DScreens0::
Data_090_53BB:: ; heuristic: map screen array; C0
    dfar Data_090_53C1 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3DAttrs0::
Data_090_53BE:: ; heuristic: map screen array; C0
    dfar Data_090_548C ; entry 0

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_53C1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $2413C1, $CB

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_548C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24148C, $4D

; compressed tileset of map $4B (the first map record using it)
; LZSS-compressed asset: 697 bytes expand to 912 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4BTileset:: ; heuristic: map tileset stream; C0
Data_090_54D9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2414D9, $2B9

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map4BPalettes::
Data_090_5792:: ; heuristic: map BG palettes; C0
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $010E, $22BA, $11D4, $0000 ; entry 1
    dw $012F, $7FFF, $6B2B, $0000 ; entry 2
    dw $0160, $7FFF, $5AB1, $0000 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $012F, $7FFF, $22BA, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4BScreens0::
Data_090_57D2:: ; heuristic: map screen array; C0
    dfar Data_090_57D8 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4BAttrs0::
Data_090_57D5:: ; heuristic: map screen array; C0
    dfar Data_090_589F ; entry 0

; LZSS-compressed asset: 199 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_57D8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $2417D8, $C7

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_589F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24189F, $2A7
    ds $22, $00
    INCBIN "dwm2-cobi-us.gbc", $241B68, $E7

; compressed tileset of map $97 (the first map record using it)
; LZSS-compressed asset: 976 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map97Tileset:: ; heuristic: map tileset stream; C0
Data_090_5C4F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $241C4F, $3D0

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map97Palettes::
Data_090_601F:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $01D3, $0063 ; entry 0
    dw $396B, $7FFF, $5A94, $0000 ; entry 1
    dw $3CC5, $6AD8, $5D12, $0000 ; entry 2
    dw $48EC, $6BFF, $4A6F, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $396B, $7FFF, $5A94, $0000 ; entry 5
    dw $012F, $035F, $01DA, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map97Screens0::
Data_090_605F:: ; heuristic: map screen array; C0
    dfar Data_090_6077 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map97Attrs0::
Data_090_6062:: ; heuristic: map screen array; C0
    dfar Data_090_6385 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map98Screens0::
Data_090_6065:: ; heuristic: map screen array; C0
    dfar Data_090_6125 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map98Attrs0::
Data_090_6068:: ; heuristic: map screen array; C0
    dfar Data_090_63AF ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map99Screens0::
Data_090_606B:: ; heuristic: map screen array; C0
    dfar Data_090_61E2 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map99Attrs0::
Data_090_606E:: ; heuristic: map screen array; C0
    dfar Data_090_63DE ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map9AScreens0::
Data_090_6071:: ; heuristic: map screen array; C0
    dfar Data_090_62AE ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map9AAttrs0::
Data_090_6074:: ; heuristic: map screen array; C0
    dfar Data_090_6408 ; entry 0

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6077:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $242077, $AE

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6125:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $242125, $BD

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_61E2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $2421E2, $CC

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_62AE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $2422AE, $D7

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6385:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $02, $03, $00, $0F, $16, $01, $03, $2A, $0B, $03, $26, $0F, $1D
    db $03, $F8, $F4, $03, $5E, $0F, $0B, $03, $F4, $F8, $03, $88, $0F, $45, $03, $68
    db $0F, $15, $03, $2C, $0F, $13, $03, $00, $0F, $13

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_63AF:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $02, $03, $00, $0F, $16, $01, $03, $2A, $0B, $03, $26, $0F, $1D
    db $03, $F8, $F4, $03, $5E, $0F, $0B, $03, $F4, $F8, $03, $88, $0F, $43, $04, $04
    db $03, $68, $0E, $03, $F2, $0F, $01, $03, $2A, $0F, $15, $03, $00, $0F, $13

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_63DE:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $02, $03, $00, $0F, $16, $01, $03, $2A, $0B, $03, $26, $0F, $1D
    db $03, $F8, $F4, $03, $5E, $0F, $0B, $03, $F4, $F8, $03, $88, $0F, $45, $03, $68
    db $0F, $15, $03, $2C, $0F, $13, $03, $00, $0F, $13

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6408:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $02, $03, $00, $0F, $16, $01, $03, $2A, $0B, $03, $26, $0F, $1D
    db $03, $F8, $F4, $03, $5E, $0F, $0B, $03, $F4, $F8, $03, $88, $0F, $45, $03, $68
    db $0F, $15, $03, $2A, $08, $04, $04, $03, $16, $1F, $05, $03, $00, $0F, $13

; compressed tileset of map $9B (the first map record using it)
; LZSS-compressed asset: 1521 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map9BTileset:: ; heuristic: map tileset stream; C0
Data_090_6437:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $242437, $5F1

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map9BPalettes::
Data_090_6A28:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $01D3, $0063 ; entry 0
    dw $012F, $7FFF, $7DA6, $0000 ; entry 1
    dw $3CC5, $6AD8, $5D12, $0000 ; entry 2
    dw $48EC, $6BFF, $4A6F, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $012F, $035F, $01DA, $0000 ; entry 5
    dw $396B, $7FFF, $5A94, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map9BScreens0::
Data_090_6A68:: ; heuristic: map screen array; C0
    dfar Data_090_6A8C ; entry 0
    dfar Data_090_6C5C ; entry 1
    dfar Data_090_6D6D ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map9BAttrs0::
Data_090_6A71:: ; heuristic: map screen array; C0
    dfar Data_090_6E46 ; entry 0
    dfar Data_090_6F2C ; entry 1
    dfar Data_090_6F75 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map9BScreens4::
Data_090_6A7A:: ; heuristic: map screen array; C0
    dfar Data_090_6B96 ; entry 0
    dfar Data_090_6C5C ; entry 1
    dfar Data_090_6D6D ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map9BAttrs4::
Data_090_6A83:: ; heuristic: map screen array; C0
    dfar Data_090_6EC9 ; entry 0
    dfar Data_090_6F2C ; entry 1
    dfar Data_090_6F75 ; entry 2

; LZSS-compressed asset: 266 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6A8C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $242A8C, $10A

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6B96:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $242B96, $C6

; LZSS-compressed asset: 273 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6C5C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $242C5C, $111

; LZSS-compressed asset: 217 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6D6D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $242D6D, $D9

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6E46:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $242E46, $83

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6EC9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $242EC9, $63

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6F2C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $242F2C, $49

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_6F75:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $242F75, $2BE

; compressed tileset of map $1D (the first map record using it)
; LZSS-compressed asset: 875 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1DTileset:: ; heuristic: stream decompressed while the game ran on the emulator; C0
Data_090_7233:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $243233, $36B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map1DPalettes::
Data_090_759E:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $7DA0, $3FBF, $01D5, $0063 ; entry 1
    dw $7DA0, $3FBF, $7FE0, $0063 ; entry 2
    dw $012F, $3FBF, $01D5, $0000 ; entry 3
    dw $318C, $7FFF, $5AD6, $0000 ; entry 4
    dw $318C, $7FFF, $5AD6, $0000 ; entry 5
    dw $318C, $7FFF, $5AD6, $0000 ; entry 6
    dw $318C, $7FFF, $5AD6, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map1DScreens0::
Data_090_75DE:: ; heuristic: map screen array; C0
    dfar Data_090_75EA ; entry 0
    dfar Data_090_76E0 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map1DAttrs0::
Data_090_75E4:: ; heuristic: map screen array; C0
    dfar Data_090_77E4 ; entry 0
    dfar Data_090_781B ; entry 1

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_75EA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $2435EA, $F6

; LZSS-compressed asset: 260 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_76E0:: ; heuristic: stream decompressed while the game ran on the emulator; C0
    INCBIN "dwm2-cobi-us.gbc", $2436E0, $104

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_77E4:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $00, $00, $03, $01, $02, $04, $04, $10, $03, $03, $02, $FC
    db $FC, $03, $01, $02, $0E, $06, $02, $2B, $08, $02, $04, $00, $02, $28, $0F, $11
    db $02, $2B, $00, $02, $50, $0F, $4D, $02, $88, $0F, $1C, $01, $02, $E0, $0F, $14
    db $02, $8F, $0F, $29, $02, $25, $0D

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_781B:: ; heuristic: stream decompressed while the game ran on the emulator; C0
    INCBIN "dwm2-cobi-us.gbc", $24381B, $5A

; compressed tileset of map $1C (the first map record using it)
; LZSS-compressed asset: 1129 bytes expand to 2304 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1CTileset:: ; heuristic: map tileset stream; C0
Data_090_7875:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $243875, $469

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map1CPalettes::
Data_090_7CDE:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7F08, $0000 ; entry 0
    dw $158F, $3F5C, $1244, $0000 ; entry 1
    dw $7DA0, $03E2, $1244, $0000 ; entry 2
    dw $7DA0, $3F5C, $1244, $0000 ; entry 3
    dw $7DA0, $2297, $1244, $0000 ; entry 4
    dw $158F, $03E2, $1244, $0000 ; entry 5
    dw $158F, $3F5C, $2297, $0000 ; entry 6
    dw $158F, $3F5C, $7DA0, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map1CScreens0::
Data_090_7D1E:: ; heuristic: map screen array; C0
    dfar Data_090_7D2A ; entry 0
    dfar Data_090_7DC3 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map1CAttrs0::
Data_090_7D24:: ; heuristic: map screen array; C0
    dfar Data_090_7DDF ; entry 0
    dfar Data_090_7E42 ; entry 1

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_7D2A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $243D2A, $99

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_7DC3:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $01, $02, $FF, $FF, $00, $02, $FF, $FF, $01, $02, $00, $0F, $4D
    db $02, $60, $0F, $4D, $02, $C0, $0F, $4D, $02, $F8, $0F, $0D

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_7DDF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $243DDF, $63

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_090_7E42:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35
    ds $1AB, $00
