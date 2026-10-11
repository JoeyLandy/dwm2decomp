SECTION "Bank 47", ROMX[$4000], BANK[$47]
    db $47

; compressed tileset of map $05 (the first map record using it)
; LZSS-compressed asset: 1889 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map05Tileset:: ; heuristic: map tileset stream; C0
Data_047_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11C001, $761

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map05Screens0::
Data_047_4762:: ; heuristic: map screen array; C0
    dfar Data_047_4786 ; entry 0
    dfar Data_047_4982 ; entry 1
    dfar Data_047_4B7E ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map05Attrs0::
Data_047_476B:: ; heuristic: map screen array; C0
    dfar Data_047_4C83 ; entry 0
    dfar Data_047_4D2B ; entry 1
    dfar Data_047_4D95 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map05Screens7::
Data_047_4774:: ; heuristic: map screen array; C0
    dfar Data_047_4786 ; entry 0
    dfar Data_047_4A80 ; entry 1
    dfar Data_047_4B7E ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map05Attrs7::
Data_047_477D:: ; heuristic: map screen array; C0
    dfar Data_047_4C83 ; entry 0
    dfar Data_047_4D5D ; entry 1
    dfar Data_047_4D95 ; entry 2

; LZSS-compressed asset: 254 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_4786:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11C786, $1FC

; LZSS-compressed asset: 254 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_4982:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11C982, $FE

; LZSS-compressed asset: 254 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_4A80:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11CA80, $FE

; LZSS-compressed asset: 261 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_4B7E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11CB7E, $105

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_4C83:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11CC83, $A8

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_4D2B:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $A4, $0F, $30
    db $04, $04, $00, $F2, $0F, $01, $04, $04, $03, $00, $05, $17, $00, $18, $10, $00
    db $28, $12, $00, $1F, $1F, $00, $00, $19, $15, $00, $3B, $19, $00, $2E, $12, $00
    db $28, $13

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_4D5D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $20, $0F, $0C, $06, $06, $00, $6E
    db $0F, $13, $00, $A4, $0F, $49, $04, $04, $00, $F2, $0F, $01, $04, $04, $03, $00
    db $05, $17, $00, $18, $10, $00, $28, $12, $00, $1F, $1F, $00, $00, $19, $15, $00
    db $3B, $19, $00, $2E, $12, $00, $28, $13

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_4D95:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11CD95, $49

; compressed BG tiles, entry 1 of AreaTilesetTable
; LZSS-compressed asset: 1128 bytes expand to 1504 (tools/lzss_gfx.py, E-0016/E-0017; C1)
AreaTileset1:: ; heuristic: area tileset stream; C0
Data_047_4DDE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11CDDE, $468

; E-0145 (C1: entry 1 of AreaPaletteTable).
; record: one CGB palette: 4 BGR555 colours
AreaPalettes1::
Data_047_5246:: ; heuristic: area BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $4C08, $67FF, $02C0, $0063 ; entry 3
    dw $012F, $67FF, $02C0, $0063 ; entry 4
    dw $01E0, $031D, $02C0, $0063 ; entry 5
    dw $012F, $031D, $7FE0, $0063 ; entry 6
    dw $0063, $0063, $0020, $0020 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map07Screens0::
Data_047_5286:: ; heuristic: map screen array; C0
    dfar Data_047_529E ; entry 0
    dfar Data_047_5414 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map07Attrs0::
Data_047_528C:: ; heuristic: map screen array; C0
    dfar Data_047_5501 ; entry 0
    dfar Data_047_5581 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map07Screens7::
Data_047_5292:: ; heuristic: map screen array; C0
    dfar Data_047_5354 ; entry 0
    dfar Data_047_5414 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map07Attrs7::
Data_047_5298:: ; heuristic: map screen array; C0
    dfar Data_047_5541 ; entry 0
    dfar Data_047_5581 ; entry 1

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_529E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11D29E, $B6

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_5354:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11D354, $C0

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_5414:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11D414, $ED

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_5501:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $01, $03, $00, $0F, $16, $02, $03, $2A, $0B, $03, $26, $0F, $2D
    db $03, $28, $00, $03, $28, $06, $03, $00, $02, $00, $00, $02, $02, $03, $8E, $00
    db $03, $2A, $02, $03, $FE, $F2, $03, $8E, $0F, $01, $03, $7A, $0F, $01, $03, $52
    db $0F, $4D, $03, $76, $0F, $05, $03, $24, $08, $03, $1C, $0F, $01, $03, $88, $02

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_5541:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $01, $03, $00, $0F, $16, $02, $03, $2A, $0B, $03, $26, $0F, $2D
    db $03, $28, $00, $03, $28, $06, $03, $00, $02, $00, $00, $02, $02, $03, $8E, $00
    db $03, $2A, $02, $03, $FE, $F2, $03, $8E, $0F, $01, $03, $7A, $0F, $01, $03, $52
    db $0F, $4D, $03, $76, $0F, $05, $03, $24, $08, $03, $1C, $0F, $01, $03, $88, $02

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_5581:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11D581, $65

; compressed tileset of map $08 (the first map record using it)
; LZSS-compressed asset: 591 bytes expand to 1904 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map08Tileset:: ; heuristic: map tileset stream; C0
Data_047_55E6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11D5E6, $24F

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map08Palettes::
Data_047_5835:: ; heuristic: map BG palettes; C0
    dw $39CE, $7FFF, $56B5, $0063 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $001B, $2BFF, $023F, $0000 ; entry 3
    dw $158F, $4298, $2A13, $0000 ; entry 4
    dw $29CE, $4FFF, $3695, $0020 ; entry 5
    dw $29CE, $4FFF, $3695, $0020 ; entry 6
    dw $29CE, $4FFF, $3695, $0020 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map09Screens0::
Data_047_5875:: ; heuristic: map screen array; C0
    dfar Data_047_5BDE ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map09Attrs0::
Data_047_5878:: ; heuristic: map screen array; C0
    dfar Data_047_5C6A ; entry 0

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_587B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11D87B, $84

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_58FF:: ; heuristic: map screen stream; C0
    db $68, $01, $05, $00, $00, $04, $05, $02, $09, $05, $FC, $FF, $31, $03, $03, $03
    db $03, $02, $02, $02, $02, $05, $48, $0F, $0D, $01, $05, $7C, $03, $05, $70, $0F
    db $0F, $05, $58, $00, $05, $58, $02, $05, $9C, $0F, $4D, $05, $C0, $0F, $01, $05
    db $82, $00, $05, $14, $1F, $09, $05, $02, $00, $05, $5A, $02, $05, $3A, $1F, $07

; compressed tileset of map $09 (the first map record using it)
; LZSS-compressed asset: 601 bytes expand to 1600 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map09Tileset:: ; heuristic: map tileset stream; C0
Data_047_593F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11D93F, $259

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map09Palettes::
Data_047_5B98:: ; heuristic: map BG palettes; C0
    dw $39CE, $7FFF, $56B5, $0063 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $1415, $4FFF, $3C1F, $0000 ; entry 3
    dw $158F, $4298, $2A13, $0000 ; entry 4
    dw $3DEC, $7FE0, $5ED4, $0063 ; entry 5
    dw $29CE, $4FFF, $3695, $0020 ; entry 6
    dw $29CE, $4FFF, $3695, $0020 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map08Screens0::
Data_047_5BD8:: ; heuristic: map screen array; C0
    dfar Data_047_587B ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map08Attrs0::
Data_047_5BDB:: ; heuristic: map screen array; C0
    dfar Data_047_58FF ; entry 0

; LZSS-compressed asset: 140 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_5BDE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11DBDE, $8C

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_5C6A:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $04, $03, $00, $0D, $03, $FE, $FF, $2D, $05, $05, $02, $03, $54
    db $07, $03, $4C, $0F, $2F, $03, $54, $04, $01, $03, $AA, $01, $03, $9C, $0F, $0F
    db $03, $96, $0F, $01, $03, $96, $0F, $49, $03, $00, $00, $03, $5E, $00, $03, $0A
    db $0C, $03, $46, $1A

; compressed tileset of map $0C (the first map record using it)
; LZSS-compressed asset: 937 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map0CTileset:: ; heuristic: map tileset stream; C0
Data_047_5C9E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11DC9E, $3A9

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map0CPalettes::
Data_047_6047:: ; heuristic: map BG palettes; C0
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $158F, $4FFF, $03E2, $0000 ; entry 4
    dw $29CE, $4FFF, $3695, $0020 ; entry 5
    dw $0020, $0020, $0020, $0020 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0CScreens0::
Data_047_6087:: ; heuristic: map screen array; C0
    dfar Data_047_6093 ; entry 0
    dfar Data_047_6129 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0CAttrs0::
Data_047_608D:: ; heuristic: map screen array; C0
    dfar Data_047_620F ; entry 0
    dfar Data_047_624B ; entry 1

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6093:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11E093, $96

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6129:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11E129, $E6

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_620F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $3E, $02, $00, $52, $09, $04, $04, $00, $4E
    db $0E, $02, $02, $00, $00, $08, $01, $01, $00, $00, $0E, $00, $82, $0F, $21, $00
    db $66, $0F, $01, $00, $CA, $0F, $11, $00, $74, $00, $00, $F2, $0F, $01, $03, $03
    db $04, $04, $04, $04, $00, $CE, $0F, $11, $00, $00, $0F, $11

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_624B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11E24B, $4F

; compressed tileset of map $0D (the first map record using it)
; address loaded by ScriptCommandED_Run_Case0F_Case00
; LZSS-compressed asset: 1352 bytes expand to 1616 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map0DTileset:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_047_629A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11E29A, $548

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map0DPalettes::
Data_047_67E2:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $012F, $4FFF, $01D8, $0C63 ; entry 1
    dw $1528, $2BFF, $00FF, $0000 ; entry 2
    dw $012F, $2B3F, $01D8, $0000 ; entry 3
    dw $1528, $3695, $15AE, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0188, $4FBF, $01D3, $0000 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0DScreens0::
Data_047_6822:: ; heuristic: map screen array; C0
    dfar Data_047_68B2 ; entry 0
    dfar Data_047_68B2 ; entry 1
    dfar Data_047_68B2 ; entry 2
    dfar Data_047_68B2 ; entry 3
    dfar Data_047_6965 ; entry 4
    dfar Data_047_6A3C ; entry 5
    dfar Data_047_6B0A ; entry 6
    dfar Data_047_6B9B ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0DAttrs0::
Data_047_683A:: ; heuristic: map screen array; C0
    dfar Data_047_6C77 ; entry 0
    dfar Data_047_6C77 ; entry 1
    dfar Data_047_6C77 ; entry 2
    dfar Data_047_6C77 ; entry 3
    dfar Data_047_6D02 ; entry 4
    dfar Data_047_6D3C ; entry 5
    dfar Data_047_6DAA ; entry 6
    dfar Data_047_6DE4 ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0DScreens4::
Data_047_6852:: ; heuristic: map screen array; C0
    dfar Data_047_68B2 ; entry 0
    dfar Data_047_68B2 ; entry 1
    dfar Data_047_68B2 ; entry 2
    dfar Data_047_68B2 ; entry 3
    dfar Data_047_6965 ; entry 4
    dfar Data_047_6A3C ; entry 5
    dfar Data_047_6B0A ; entry 6
    dfar Data_047_6B9B ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0DAttrs4::
Data_047_686A:: ; heuristic: map screen array; C0
    dfar Data_047_6C77 ; entry 0
    dfar Data_047_6C77 ; entry 1
    dfar Data_047_6C77 ; entry 2
    dfar Data_047_6C77 ; entry 3
    dfar Data_047_6D02 ; entry 4
    dfar Data_047_6D3C ; entry 5
    dfar Data_047_6DAA ; entry 6
    dfar Data_047_6DE4 ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0DScreens7::
Data_047_6882:: ; heuristic: map screen array; C0
    dfar Data_047_68B2 ; entry 0
    dfar Data_047_68B2 ; entry 1
    dfar Data_047_68B2 ; entry 2
    dfar Data_047_68B2 ; entry 3
    dfar Data_047_6965 ; entry 4
    dfar Data_047_6A3C ; entry 5
    dfar Data_047_6B53 ; entry 6
    dfar Data_047_6C0A ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0DAttrs7::
Data_047_689A:: ; heuristic: map screen array; C0
    dfar Data_047_6C77 ; entry 0
    dfar Data_047_6C77 ; entry 1
    dfar Data_047_6C77 ; entry 2
    dfar Data_047_6C77 ; entry 3
    dfar Data_047_6D02 ; entry 4
    dfar Data_047_6D3C ; entry 5
    dfar Data_047_6DC7 ; entry 6
    dfar Data_047_6E01 ; entry 7

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_68B2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11E8B2, $B3

; LZSS-compressed asset: 108 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6965:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11E965, $6C

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_69D1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11E9D1, $6B

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6A3C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11EA3C, $CE

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6B0A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11EB0A, $49

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6B53:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11EB53, $48

; LZSS-compressed asset: 111 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6B9B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11EB9B, $6F

; LZSS-compressed asset: 109 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6C0A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11EC0A, $6D

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6C77:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11EC77, $8B

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6D02:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $76, $0F, $02
    db $02, $02, $00, $C4, $0F, $13, $00, $FD, $0F, $4D, $00, $08, $16, $68, $01, $00
    db $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $76, $0F, $02, $02, $02, $00
    db $C4, $0F, $13, $00, $FD, $0F, $4D, $00, $08, $16

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6D3C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11ED3C, $6E

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6DAA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $6C, $07, $02
    db $02, $00, $BA, $0F, $13, $00, $F3, $0F, $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6DC7:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $6C, $07, $02
    db $02, $00, $C4, $0F, $13, $00, $F3, $0F, $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6DE4:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $6C, $07, $02
    db $02, $00, $BA, $0F, $13, $00, $F3, $0F, $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_6E01:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $6C, $07, $02
    db $02, $00, $BA, $0F, $13, $00, $F3, $0F, $4D, $00, $08, $1F, $01

; compressed tileset of map $0E (the first map record using it)
; LZSS-compressed asset: 845 bytes expand to 1040 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map0ETileset:: ; heuristic: map tileset stream; C0
Data_047_6E1E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11EE1E, $34D

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map0EPalettes::
Data_047_716B:: ; heuristic: map BG palettes; C0
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
Map0EScreens0::
Data_047_71AB:: ; heuristic: map screen array; C0
    dfar Data_047_71B1 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0EAttrs0::
Data_047_71AE:: ; heuristic: map screen array; C0
    dfar Data_047_7279 ; entry 0

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_71B1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11F1B1, $C8

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_7279:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11F279, $45

; compressed tileset of map $0F (the first map record using it)
; LZSS-compressed asset: 1370 bytes expand to 1568 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map0FTileset:: ; heuristic: map tileset stream; C0
Data_047_72BE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11F2BE, $55A

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map0FPalettes::
Data_047_7818:: ; heuristic: map BG palettes; C0
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $012F, $4FFF, $5D1F, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $03E2, $4FFF, $5D1F, $0020 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0FScreens0::
Data_047_7858:: ; heuristic: map screen array; C0
    dfar Data_047_7864 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0FAttrs0::
Data_047_785B:: ; heuristic: map screen array; C0
    dfar Data_047_7A2B ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0FScreens7::
Data_047_785E:: ; heuristic: map screen array; C0
    dfar Data_047_7923 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0FAttrs7::
Data_047_7861:: ; heuristic: map screen array; C0
    dfar Data_047_7A8A ; entry 0

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_7864:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11F864, $BF

; LZSS-compressed asset: 264 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_7923:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11F923, $108

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_7A2B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11FA2B, $5F

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_7A8A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11FA8A, $80

; compressed tileset of map $10 (the first map record using it)
; LZSS-compressed asset: 666 bytes expand to 800 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map10Tileset:: ; heuristic: map tileset stream; C0
Data_047_7B0A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11FB0A, $29A

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map10Palettes::
Data_047_7DA4:: ; heuristic: map BG palettes; C0
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $158F, $4FFF, $03E2, $0000 ; entry 4
    dw $012F, $4FFF, $5D1F, $0020 ; entry 5
    dw $03E2, $4FFF, $5D1F, $0020 ; entry 6
    dw $29CE, $4FFF, $5A3F, $0020 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map10Screens0::
Data_047_7DE4:: ; heuristic: map screen array; C0
    dfar Data_047_7DEA ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map10Attrs0::
Data_047_7DE7:: ; heuristic: map screen array; C0
    dfar Data_047_7E90 ; entry 0

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_7DEA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11FDEA, $A6

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_047_7E90:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11FE90, $6B
    ds $105, $00
