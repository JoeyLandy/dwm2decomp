SECTION "Bank 93", ROMX[$4000], BANK[$93]
    db $93

; compressed BG tiles, entry 0 of AreaTilesetTable
; address loaded by Func_0E0_5AD3_Case00_Case00
; LZSS-compressed asset: 1313 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
AreaTileset0:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_093_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $24C001, $521

; compressed tileset of map $03 (the first map record using it)
; LZSS-compressed asset: 977 bytes expand to 1232 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map03Tileset:: ; heuristic: map tileset stream; C0
Data_093_4522:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $24C522, $3D1

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map03Palettes::
Data_093_48F3:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $3126, $035F, $7E0A, $0000 ; entry 1
    dw $00CF, $4299, $0175, $0000 ; entry 2
    dw $21AA, $6BFF, $3A91, $0000 ; entry 3
    dw $014D, $035F, $2A55, $0000 ; entry 4
    dw $014D, $6BFF, $2A55, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map03Screens0::
Data_093_4933:: ; address name
    dfar Data_093_4939 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map03Attrs0::
Data_093_4936:: ; address name
    dfar Data_093_4A45 ; entry 0

; LZSS-compressed asset: 268 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_4939:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24C939, $10C

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_4A45:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24CA45, $59

; compressed tileset of map $11 (the first map record using it)
; LZSS-compressed asset: 693 bytes expand to 1120 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map11Tileset:: ; heuristic: map tileset stream; C0
Data_093_4A9E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $24CA9E, $2B5

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map11Palettes::
Data_093_4D53:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $158F, $4FFF, $03E2, $0000 ; entry 4
    dw $29CE, $4FFF, $3695, $0020 ; entry 5
    dw $29CE, $4FFF, $3695, $0020 ; entry 6
    dw $29CE, $4FFF, $3695, $18EA ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map11Screens0::
Data_093_4D93:: ; address name
    dfar Data_093_4D9F ; entry 0
    dfar Data_093_4E49 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map11Attrs0::
Data_093_4D99:: ; address name
    dfar Data_093_4ECF ; entry 0
    dfar Data_093_4F0D ; entry 1

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_4D9F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24CD9F, $AA

; LZSS-compressed asset: 134 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_4E49:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24CE49, $86

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_4ECF:: ; heuristic: map screen stream; C0
    db $68, $01, $04, $03, $04, $00, $00, $04, $FC, $F3, $04, $FC, $F5, $04, $01, $0F
    db $05, $04, $24, $0D, $01, $04, $3E, $01, $04, $38, $06, $04, $3A, $0F, $1F, $02
    db $04, $80, $01, $04, $40, $04, $04, $80, $02, $04, $8E, $06, $04, $8A, $0F, $19
    db $04, $7C, $02, $04, $CA, $06, $04, $C6, $0F, $41, $04, $8E, $0F, $27

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_4F0D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $03, $02, $00, $02, $0B, $03, $03, $00, $00, $0F, $07, $04
    db $00, $2E, $03, $00, $0E, $0F, $0D, $01, $01, $00, $52, $06, $00, $4E, $0F, $0B
    db $00, $7E, $02, $00, $72, $0F, $0D, $00, $06, $0F, $15, $00, $BA, $0F, $39, $00
    db $32, $04, $00, $0A, $0F, $0D, $00, $3E, $12, $00, $3A, $1A, $00, $42, $1E

; compressed tileset of map $12 (the first map record using it)
; LZSS-compressed asset: 711 bytes expand to 896 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map12Tileset:: ; heuristic: map tileset stream; C0
Data_093_4F4C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $24CF4C, $2C7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map12Palettes::
Data_093_5213:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $158F, $4FFF, $03E2, $0000 ; entry 4
    dw $29CE, $4FFF, $3695, $0020 ; entry 5
    dw $29CE, $4FFF, $3695, $0020 ; entry 6
    dw $29CE, $4FFF, $3695, $18EA ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map12Screens0::
Data_093_5253:: ; address name
    dfar Data_093_5259 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map12Attrs0::
Data_093_5256:: ; address name
    dfar Data_093_52F9 ; entry 0

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5259:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24D259, $A0

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_52F9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24D2F9, $44

; compressed tileset of map $2F (the first map record using it)
; LZSS-compressed asset: 1059 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2FTileset:: ; heuristic: map tileset stream; C0
Data_093_533D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $24D33D, $3B6

; LZSS-compressed asset: 359 bytes expand to 366 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_56F3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $24D6F3, $6D

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map2FPalettes::
Data_093_5760:: ; address name
    dw $7C01, $7FFF, $6301, $0000 ; entry 0
    dw $01D3, $3F7F, $029A, $0042 ; entry 1
    dw $02C0, $3F7F, $03E2, $0000 ; entry 2
    dw $012F, $2B3F, $01D8, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2FScreens0::
Data_093_57A0:: ; address name
    dfar Data_093_57E8 ; entry 0
    dfar Data_093_5927 ; entry 1
    dfar Data_093_5A91 ; entry 2
    dfar Data_093_5F35 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2FAttrs0::
Data_093_57AC:: ; address name
    dfar Data_093_604A ; entry 0
    dfar Data_093_60A1 ; entry 1
    dfar Data_093_6124 ; entry 2
    dfar Data_093_628A ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2FScreens4::
Data_093_57B8:: ; address name
    dfar Data_093_57E8 ; entry 0
    dfar Data_093_5927 ; entry 1
    dfar Data_093_5E96 ; entry 2
    dfar Data_093_5F35 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2FAttrs4::
Data_093_57C4:: ; address name
    dfar Data_093_604A ; entry 0
    dfar Data_093_60A1 ; entry 1
    dfar Data_093_6266 ; entry 2
    dfar Data_093_628A ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2FScreens5::
Data_093_57D0:: ; address name
    dfar Data_093_585A ; entry 0
    dfar Data_093_5974 ; entry 1
    dfar Data_093_5A91 ; entry 2
    dfar Data_093_5FA8 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2FAttrs5::
Data_093_57DC:: ; address name
    dfar Data_093_605E ; entry 0
    dfar Data_093_60B5 ; entry 1
    dfar Data_093_6124 ; entry 2
    dfar Data_093_629E ; entry 3

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_57E8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24D7E8, $72

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_585A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24D85A, $CD

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5927:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24D927, $4D

; LZSS-compressed asset: 285 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5974:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24D974, $11D

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5A91:: ; heuristic: script screen animation tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $24DA91, $A5

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5B36:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $24DB36, $B3

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5BE9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $24DBE9, $B0

; LZSS-compressed asset: 178 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5C99:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $24DC99, $B2

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5D4B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $24DD4B, $AA

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5DF5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $24DDF5, $A1

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5E96:: ; heuristic: script screen animation tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $24DE96, $9F

; LZSS-compressed asset: 115 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5F35:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24DF35, $73

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_5FA8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24DFA8, $A2

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_604A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_605E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24E05E, $43

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_60A1:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 111 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_60B5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24E0B5, $6F

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_6124:: ; heuristic: script screen animation attribute map; C0
    db $68, $01, $03, $01, $01, $01, $01, $03, $F0, $FF, $3D, $03, $02, $00, $02, $02
    db $02, $02, $03, $4C, $06, $03, $52, $0F, $05, $02, $02, $03, $02, $00, $03, $60
    db $06, $03, $7A, $0F, $05, $03, $A5, $0F, $4D, $03, $05, $1F, $4D, $01, $01

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_6153:: ; heuristic: script screen animation attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $24E153, $41

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_6194:: ; heuristic: script screen animation attribute map; C0
    db $68, $01, $03, $01, $03, $00, $01, $03, $F2, $FF, $0E, $03, $00, $02, $03, $04
    db $02, $03, $05, $02, $03, $27, $04, $03, $27, $06, $03, $39, $09, $02, $02, $02
    db $02, $03, $39, $0C, $03, $58, $0E, $03, $5A, $00, $03, $37, $0C, $03, $7E, $0F
    db $01, $03, $A5, $0F, $4D, $03, $05, $1F, $4D, $01, $01

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_61CF:: ; heuristic: script screen animation attribute map; C0
    db $68, $01, $03, $01, $03, $00, $01, $03, $F3, $FF, $00, $03, $04, $01, $03, $04
    db $03, $03, $13, $04, $03, $13, $06, $03, $25, $0C, $03, $37, $0D, $02, $02, $02
    db $02, $03, $48, $0F, $0F, $03, $5A, $00, $03, $23, $0C, $03, $7E, $0F, $01, $03
    db $A5, $0F, $4D, $03, $05, $1F, $4D, $01, $01

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_6208:: ; heuristic: script screen animation attribute map; C0
    db $68, $01, $03, $01, $03, $00, $02, $03, $FC, $F2, $03, $FB, $F8, $03, $12, $05
    db $03, $0F, $0F, $00, $03, $25, $0F, $10, $02, $02, $02, $02, $03, $48, $0F, $0F
    db $03, $5A, $00, $03, $10, $0C, $03, $7E, $0F, $01, $03, $A5, $0F, $4D, $03, $05
    db $1F, $4D, $01, $01

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_623C:: ; heuristic: script screen animation attribute map; C0
    db $68, $01, $03, $01, $03, $00, $08, $03, $FD, $FC, $03, $10, $0F, $28, $02, $02
    db $02, $02, $03, $48, $0F, $0F, $03, $5A, $00, $03, $0E, $0C, $03, $7E, $0F, $01
    db $03, $A5, $0F, $4D, $03, $05, $1F, $4D, $01, $01

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_6266:: ; heuristic: script screen animation attribute map; C0
    db $68, $01, $03, $01, $03, $00, $0F, $44, $02, $02, $02, $02, $03, $48, $0F, $0F
    db $03, $5A, $00, $03, $FE, $FC, $03, $7E, $0F, $01, $03, $A5, $0F, $4D, $03, $05
    db $1F, $4D, $01, $01

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_628A:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_629E:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $03, $FF, $F2, $02, $03, $06, $09, $03, $00, $0F, $05, $03, $06
    db $02, $01, $01, $01, $01, $03, $22, $0F, $07, $03, $48, $06, $03, $58, $02, $03
    db $44, $0A, $03, $5A, $08, $03, $76, $0C, $03, $74, $0F, $01, $03, $74, $0F, $03
    db $03, $B3, $0F, $4D, $03, $08, $1F, $41

; compressed tileset of map $32 (the first map record using it)
; LZSS-compressed asset: 1544 bytes expand to 1776 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map32Tileset:: ; heuristic: map tileset stream; C0
Data_093_62D6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $24E2D6, $608

; compressed tileset of map $3E (the first map record using it)
; LZSS-compressed asset: 762 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3ETileset:: ; heuristic: map tileset stream; C0
Data_093_68DE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $24E8DE, $2FA

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map3EPalettes::
Data_093_6BD8:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $28C8, $3FBF, $4192, $0000 ; entry 1
    dw $001B, $2BFF, $023F, $0000 ; entry 2
    dw $0106, $4F18, $020C, $0000 ; entry 3
    dw $0106, $677A, $0210, $0000 ; entry 4
    dw $0108, $3F7F, $0216, $0002 ; entry 5
    dw $218C, $4F18, $3A52, $0CA5 ; entry 6
    dw $218C, $4F18, $3A52, $0CA5 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3EScreens0::
Data_093_6C18:: ; address name
    dfar Data_093_6C30 ; entry 0
    dfar Data_093_6D29 ; entry 1
    dfar Data_093_6E39 ; entry 2
    dfar Data_093_6F32 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3EAttrs0::
Data_093_6C24:: ; address name
    dfar Data_093_700E ; entry 0
    dfar Data_093_7062 ; entry 1
    dfar Data_093_70AF ; entry 2
    dfar Data_093_7101 ; entry 3

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_6C30:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24EC30, $F9

; LZSS-compressed asset: 272 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_6D29:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24ED29, $110

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_6E39:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24EE39, $F9

; LZSS-compressed asset: 220 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_6F32:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24EF32, $DC

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_700E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F00E, $54

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_7062:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F062, $4D

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_70AF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F0AF, $52

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_7101:: ; heuristic: map screen stream; C0
    db $68, $01, $04, $01, $04, $00, $0F, $40, $03, $04, $54, $07, $04, $4C, $0F, $07
    db $04, $54, $06, $02, $02, $04, $5C, $04, $04, $7A, $0F, $0B, $04, $5A, $06, $04
    db $A2, $0F, $4D, $04, $4E, $0F, $17, $04, $FE, $FE, $04, $FC, $FF, $01, $00, $00

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3FScreens0::
Data_093_7131:: ; address name
    dfar Data_093_7149 ; entry 0
    dfar Data_093_7248 ; entry 1
    dfar Data_093_7321 ; entry 2
    dfar Data_093_742C ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3FAttrs0::
Data_093_713D:: ; address name
    dfar Data_093_7520 ; entry 0
    dfar Data_093_7566 ; entry 1
    dfar Data_093_75A7 ; entry 2
    dfar Data_093_75F5 ; entry 3

; LZSS-compressed asset: 255 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_7149:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F149, $FF

; LZSS-compressed asset: 217 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_7248:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F248, $D9

; LZSS-compressed asset: 267 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_7321:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F321, $10B

; LZSS-compressed asset: 244 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_742C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F42C, $F4

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_7520:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F520, $46

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_7566:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F566, $41

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_75A7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F5A7, $4E

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_093_75F5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $24F5F5, $50

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map8CPalettes::
Data_093_7645:: ; address name
    dw $100E, $7FFF, $70CA, $0000 ; entry 0
    dw $150B, $4A52, $4D8C, $0000 ; entry 1
    dw $194A, $4A52, $020A, $0000 ; entry 2
    dw $001B, $2BFF, $023F, $0000 ; entry 3
    dw $10CA, $4A52, $4D8C, $0000 ; entry 4
    dw $3C6B, $3A52, $2510, $0000 ; entry 5
    dw $18EB, $67FF, $01DA, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map8EPalettes::
Data_093_7685:: ; address name
    dw $100E, $7FFF, $70CA, $0000 ; entry 0
    dw $0143, $4E15, $01C7, $0000 ; entry 1
    dw $192C, $7FFF, $45F2, $0000 ; entry 2
    dw $3C0B, $4E15, $2D52, $0000 ; entry 3
    dw $0143, $4A52, $012F, $00A0 ; entry 4
    dw $0143, $7FFF, $45F2, $00A0 ; entry 5
    dw $0143, $4A52, $01C7, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map92Palettes::
Data_093_76C5:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $48EC, $6BFF, $4A6F, $0000 ; entry 1
    dw $0000, $0000, $0000, $0000 ; entry 2
    dw $0000, $0000, $0000, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map94Palettes::
Data_093_7705:: ; address name
    dw $3CC5, $7FFF, $1415, $0000 ; entry 0
    dw $400C, $025C, $0015, $0000 ; entry 1
    dw $00EF, $5AD6, $2A13, $0000 ; entry 2
    dw $3CC5, $3F7F, $1415, $0000 ; entry 3
    dw $3CC5, $6AD8, $5D12, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $24F745, $1AD
    ds $22, $00
    INCBIN "dwm2-cobi-us.gbc", $24F914, $EE

; compressed tileset of map $8F (the first map record using it)
; LZSS-compressed asset: 1318 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8FTileset:: ; heuristic: map tileset stream; C0
Data_093_7A02:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $24FA02, $526

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map8FPalettes::
Data_093_7F28:: ; address name
    dw $18EB, $7FFF, $01DA, $0000 ; entry 0
    dw $150B, $4A52, $4D8C, $0000 ; entry 1
    dw $194A, $4A52, $020A, $0000 ; entry 2
    dw $192C, $7FFF, $45F2, $0000 ; entry 3
    dw $194A, $03FF, $020A, $0000 ; entry 4
    dw $18C6, $03FF, $020A, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapB0Palettes::
Data_093_7F68:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $01C4, $7FFF, $5652, $0084 ; entry 1
    dw $01B5, $7FFF, $5652, $0006 ; entry 2
    dw $01C4, $7FFF, $5294, $0000 ; entry 3
    dw $7DA0, $7FFF, $7FE0, $40E0 ; entry 4
    dw $0171, $7FFF, $2A13, $0000 ; entry 5
    dw $1415, $7FFF, $25F5, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    ds $58, $00
