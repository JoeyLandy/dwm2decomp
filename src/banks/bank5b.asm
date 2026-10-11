SECTION "Bank 5B", ROMX[$4000], BANK[$5B]
    db $5B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map4CPalettes::
Data_05B_4001:: ; heuristic: map BG palettes; C0
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $00ED, $22BA, $11D4, $0000 ; entry 1
    dw $012F, $6B2B, $7D48, $0000 ; entry 2
    dw $0160, $7FFF, $5AB1, $0000 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $1415, $7FFF, $01DA, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map53Palettes::
Data_05B_4041:: ; heuristic: map BG palettes; C0
    dw $1415, $7FFF, $3C1F, $0000 ; entry 0
    dw $012F, $6B2B, $7D48, $0000 ; entry 1
    dw $184C, $0217, $1116, $0000 ; entry 2
    dw $0854, $029E, $315F, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $0186, $3F3D, $02AF, $0084 ; entry 5
    dw $0160, $22BA, $02C0, $0000 ; entry 6
    dw $01C4, $67F8, $4B00, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map55Screens0::
Data_05B_4081:: ; heuristic: map screen array; C0
    dfar Data_05B_408D ; entry 0
    dfar Data_05B_4130 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map55Attrs0::
Data_05B_4087:: ; heuristic: map screen array; C0
    dfar Data_05B_41EF ; entry 0
    dfar Data_05B_4231 ; entry 1

; LZSS-compressed asset: 163 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_408D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C08D, $A3

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4130:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C130, $BF

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_41EF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C1EF, $42

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4231:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C231, $42

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map66Screens0::
Data_05B_4273:: ; heuristic: map screen array; C0
    dfar Data_05B_428B ; entry 0
    dfar Data_05B_4325 ; entry 1
    dfar Data_05B_43C9 ; entry 2
    dfar Data_05B_4475 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map66Attrs0::
Data_05B_427F:: ; heuristic: map screen array; C0
    dfar Data_05B_451A ; entry 0
    dfar Data_05B_455C ; entry 1
    dfar Data_05B_45A7 ; entry 2
    dfar Data_05B_45F4 ; entry 3

; LZSS-compressed asset: 154 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_428B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C28B, $9A

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4325:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C325, $A4

; LZSS-compressed asset: 172 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_43C9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C3C9, $AC

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4475:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C475, $A5

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_451A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C51A, $42

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_455C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C55C, $4B

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_45A7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C5A7, $4D

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_45F4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16C5F4, $69

; compressed tileset of map $B9 (the first map record using it)
; LZSS-compressed asset: 1289 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapB9Tileset:: ; heuristic: map tileset stream; C0
Data_05B_465D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16C65D, $509

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapB9Palettes::
Data_05B_4B66:: ; heuristic: map BG palettes; C0
    dw $212A, $7FFF, $31CF, $0000 ; entry 0
    dw $0111, $3F7F, $0175, $0009 ; entry 1
    dw $01A0, $3F7F, $03E7, $00A0 ; entry 2
    dw $49AE, $7FFF, $4ACD, $0000 ; entry 3
    dw $48C6, $5254, $796B, $0000 ; entry 4
    dw $2111, $3A5C, $21B8, $0044 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0044, $0000, $0044 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB9Screens0::
Data_05B_4BA6:: ; heuristic: map screen array; C0
    dfar Data_05B_4BBE ; entry 0
    dfar Data_05B_4CAE ; entry 1
    dfar Data_05B_4D95 ; entry 2
    dfar Data_05B_4E7A ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapB9Attrs0::
Data_05B_4BB2:: ; heuristic: map screen array; C0
    dfar Data_05B_4F77 ; entry 0
    dfar Data_05B_4FDA ; entry 1
    dfar Data_05B_5051 ; entry 2
    dfar Data_05B_50CB ; entry 3

; LZSS-compressed asset: 240 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4BBE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16CBBE, $F0

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4CAE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16CCAE, $E7

; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4D95:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16CD95, $E5

; LZSS-compressed asset: 253 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4E7A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16CE7A, $FD

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4F77:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16CF77, $63

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_4FDA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16CFDA, $77

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_5051:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16D051, $7A

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_50CB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16D0CB, $91

; compressed tileset of map $BA (the first map record using it)
; LZSS-compressed asset: 1080 bytes expand to 1264 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapBATileset:: ; heuristic: map tileset stream; C0
Data_05B_515C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16D15C, $438

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapBAPalettes::
Data_05B_5594:: ; heuristic: map BG palettes; C0
    dw $218C, $7FFF, $66B3, $0000 ; entry 0
    dw $01D3, $3F7F, $029A, $0044 ; entry 1
    dw $012F, $029A, $01D5, $0044 ; entry 2
    dw $012F, $3F7F, $1D78, $0063 ; entry 3
    dw $2111, $3A5C, $21B8, $0044 ; entry 4
    dw $31CF, $7DA0, $5AD6, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBAScreens0::
Data_05B_55D4:: ; heuristic: map screen array; C0
    dfar Data_05B_55E0 ; entry 0
    dfar Data_05B_56B6 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBAAttrs0::
Data_05B_55DA:: ; heuristic: map screen array; C0
    dfar Data_05B_57C6 ; entry 0
    dfar Data_05B_5811 ; entry 1

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_55E0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16D5E0, $D6

; LZSS-compressed asset: 272 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_56B6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16D6B6, $110

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_57C6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16D7C6, $4B

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_5811:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16D811, $55

; compressed tileset of map $BB (the first map record using it)
; LZSS-compressed asset: 485 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapBBTileset:: ; heuristic: map tileset stream; C0
Data_05B_5866:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16D866, $1E5

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapBBPalettes::
Data_05B_5A4B:: ; heuristic: map BG palettes; C0
    dw $192C, $7FFF, $31CF, $0000 ; entry 0
    dw $0175, $5B7F, $1E7E, $0009 ; entry 1
    dw $01C4, $3F7F, $03E7, $00A0 ; entry 2
    dw $192C, $7FFF, $03E7, $0000 ; entry 3
    dw $1415, $4FFF, $3C1F, $0000 ; entry 4
    dw $31CF, $7FFF, $5AD6, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $04E6, $7FF1, $03E7, $0004 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBBScreens0::
Data_05B_5A8B:: ; heuristic: map screen array; C0
    dfar Data_05B_5AA3 ; entry 0
    dfar Data_05B_5CCB ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBBAttrs0::
Data_05B_5A91:: ; heuristic: map screen array; C0
    dfar Data_05B_5D8A ; entry 0
    dfar Data_05B_5E32 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBBScreens1::
Data_05B_5A97:: ; heuristic: map screen array; C0
    dfar Data_05B_5BB7 ; entry 0
    dfar Data_05B_5CCB ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBBAttrs1::
Data_05B_5A9D:: ; heuristic: map screen array; C0
    dfar Data_05B_5DDE ; entry 0
    dfar Data_05B_5E32 ; entry 1

; LZSS-compressed asset: 276 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_5AA3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16DAA3, $114

; LZSS-compressed asset: 276 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_5BB7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16DBB7, $114

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_5CCB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16DCCB, $BF

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_5D8A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16DD8A, $54

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_5DDE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16DDDE, $54

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_5E32:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; compressed tileset of map $BC (the first map record using it)
; LZSS-compressed asset: 675 bytes expand to 880 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapBCTileset:: ; heuristic: map tileset stream; C0
Data_05B_5E46:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16DE46, $2A3

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapBCPalettes::
Data_05B_60E9:: ; heuristic: map BG palettes; C0
    dw $01D5, $7FFF, $029A, $0000 ; entry 0
    dw $01D3, $3F7F, $029A, $0000 ; entry 1
    dw $0130, $029A, $01D5, $0008 ; entry 2
    dw $0248, $3F7F, $029A, $0000 ; entry 3
    dw $498C, $7FFF, $6652, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBCScreens0::
Data_05B_6129:: ; heuristic: map screen array; C0
    dfar Data_05B_612F ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBCAttrs0::
Data_05B_612C:: ; heuristic: map screen array; C0
    dfar Data_05B_61EF ; entry 0

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_612F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16E12F, $C0

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_61EF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16E1EF, $57

; compressed tileset of map $BD (the first map record using it)
; LZSS-compressed asset: 676 bytes expand to 1440 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapBDTileset:: ; heuristic: map tileset stream; C0
Data_05B_6246:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16E246, $2A4

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapBDPalettes::
Data_05B_64EA:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $150B, $6BFF, $4D8C, $0044 ; entry 1
    dw $4D8C, $6BFF, $5E73, $0000 ; entry 2
    dw $1415, $4FFF, $3C1F, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $218C, $6BFF, $029A, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBDScreens0::
Data_05B_652A:: ; heuristic: map screen array; C0
    dfar Data_05B_6530 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBDAttrs0::
Data_05B_652D:: ; heuristic: map screen array; C0
    dfar Data_05B_65FE ; entry 0

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6530:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16E530, $CE

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_65FE:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $05, $05, $00, $50, $00, $00, $56, $02
    db $00, $50, $02, $00, $50, $0F, $2D, $00, $A2, $0A, $00, $9E, $0F, $07, $00, $54
    db $0F, $4D, $00, $A0, $0F, $03, $00, $00, $0F, $13

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBEScreens0::
Data_05B_6628:: ; heuristic: map screen array; C0
    dfar Data_05B_662E ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBEAttrs0::
Data_05B_662B:: ; heuristic: map screen array; C0
    dfar Data_05B_66AE ; entry 0

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_662E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16E62E, $80

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_66AE:: ; heuristic: map screen stream; C0
    db $68, $01, $04, $02, $04, $00, $0F, $3E, $05, $04, $52, $0B, $04, $4E, $0F, $09
    db $00, $00, $01, $01, $03, $03, $00, $00, $04, $72, $0F, $0F, $04, $FA, $F2, $04
    db $9A, $0F, $35, $04, $56, $0F, $15, $04, $56, $0F, $11, $04, $4C, $06, $04, $42
    db $0F, $01, $04, $00, $04

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBFScreens0::
Data_05B_66E3:: ; heuristic: map screen array; C0
    dfar Data_05B_6713 ; entry 0
    dfar Data_05B_6755 ; entry 1
    dfar Data_05B_6819 ; entry 2
    dfar Data_05B_6844 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBFAttrs0::
Data_05B_66EF:: ; heuristic: map screen array; C0
    dfar Data_05B_689D ; entry 0
    dfar Data_05B_68B5 ; entry 1
    dfar Data_05B_6903 ; entry 2
    dfar Data_05B_691F ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBFScreens2::
Data_05B_66FB:: ; heuristic: map screen array; C0
    dfar Data_05B_6713 ; entry 0
    dfar Data_05B_67B7 ; entry 1
    dfar Data_05B_6819 ; entry 2
    dfar Data_05B_6844 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapBFAttrs2::
Data_05B_6707:: ; heuristic: map screen array; C0
    dfar Data_05B_689D ; entry 0
    dfar Data_05B_68DC ; entry 1
    dfar Data_05B_6903 ; entry 2
    dfar Data_05B_691F ; entry 3

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6713:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16E713, $42

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6755:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16E755, $62

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_67B7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16E7B7, $62

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6819:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $08, $09, $40, $41, $00, $02, $0C, $18, $19, $50, $51, $00, $16
    db $0C, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $45, $20, $21, $02
    db $03, $00, $42, $1C, $30, $31, $12, $13, $00, $56, $1C

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6844:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16E844, $59

; LZSS-compressed asset: 24 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_689D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $05, $00, $52, $0D, $00, $50, $0F, $4D
    db $00, $B0, $0F, $4D, $00, $FC, $0F, $31

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_68B5:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $05, $00, $50, $01, $00, $4C, $04, $03
    db $03, $00, $54, $00, $00, $50, $0F, $0F, $00, $52, $02, $00, $78, $0F, $4D, $00
    db $D8, $0F, $4D, $00, $FC, $0F, $09

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_68DC:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $05, $00, $50, $01, $00, $4C, $04, $03
    db $03, $00, $54, $00, $00, $50, $0F, $0F, $00, $52, $02, $00, $78, $0F, $4D, $00
    db $D8, $0F, $4D, $00, $FC, $0F, $09

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6903:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $02, $05, $00, $02, $0D, $00, $00, $0F, $4D, $00, $60, $0F
    db $4D, $00, $C0, $0F, $4D, $00, $D0, $0A, $00, $40, $1F, $13

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_691F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $05, $00, $00, $01, $02, $02, $02, $02, $00, $00, $02, $00, $04
    db $00, $00, $00, $0F, $4D, $00, $10, $06, $00, $78, $08, $00, $76, $0F, $35, $01
    db $01, $00, $C0, $0F, $13, $00, $6E, $0F, $33, $00, $3E, $1F, $15

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC0Screens0::
Data_05B_694C:: ; heuristic: map screen array; C0
    dfar Data_05B_6964 ; entry 0
    dfar Data_05B_69A8 ; entry 1
    dfar Data_05B_6A42 ; entry 2
    dfar Data_05B_6AC3 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC0Attrs0::
Data_05B_6958:: ; heuristic: map screen array; C0
    dfar Data_05B_6B07 ; entry 0
    dfar Data_05B_6B26 ; entry 1
    dfar Data_05B_6B57 ; entry 2
    dfar Data_05B_6B90 ; entry 3

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6964:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16E964, $44

; LZSS-compressed asset: 154 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_69A8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16E9A8, $9A

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6A42:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16EA42, $81

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6AC3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16EAC3, $44

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6B07:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $05, $00, $52, $0D, $00, $50, $0F, $4D
    db $00, $B0, $0F, $4D, $00, $E8, $0F, $17, $00, $4A, $0F, $01, $00, $00, $02

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6B26:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $05, $00, $50, $01, $00, $4C, $04, $01
    db $01, $00, $54, $00, $00, $50, $0F, $0F, $00, $52, $02, $00, $78, $0F, $33, $00
    db $4C, $04, $00, $C6, $0F, $31, $00, $18, $18, $00, $16, $1F, $03, $00, $00, $0F
    db $15

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6B57:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $02, $05, $01, $02, $07, $02, $01, $0E, $03, $01, $02, $0F
    db $35, $01, $08, $04, $01, $52, $0F, $2B, $00, $00, $01, $92, $0F, $15, $01, $A4
    db $0A, $01, $C8, $0F, $09, $01, $A4, $08, $01, $F0, $0F, $03, $03, $03, $01, $F8
    db $F4, $01, $10, $1F, $0B, $01, $40, $1F, $13

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6B90:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $05, $00, $50, $0D, $00, $4E, $0F, $4D
    db $00, $AE, $0F, $4D, $00, $D2, $0F, $0B, $00, $00, $0F, $15

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC1Screens0::
Data_05B_6BAC:: ; heuristic: map screen array; C0
    dfar Data_05B_6BC4 ; entry 0
    dfar Data_05B_6C71 ; entry 1
    dfar Data_05B_6D17 ; entry 2
    dfar Data_05B_6DA6 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC1Attrs0::
Data_05B_6BB8:: ; heuristic: map screen array; C0
    dfar Data_05B_6E41 ; entry 0
    dfar Data_05B_6E7F ; entry 1
    dfar Data_05B_6E9E ; entry 2
    dfar Data_05B_6ECA ; entry 3

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6BC4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16EBC4, $AD

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6C71:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16EC71, $A6

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6D17:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16ED17, $8F

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6DA6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16EDA6, $9B

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6E41:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $40, $05, $00, $54, $05, $01, $01, $05, $05
    db $00, $4E, $0F, $11, $00, $54, $00, $00, $76, $0F, $0F, $00, $48, $0F, $01, $00
    db $48, $0E, $00, $46, $0F, $01, $00, $46, $0E, $00, $EC, $0C, $00, $F4, $0F, $0B
    db $00, $84, $06, $00, $1C, $1F, $0B, $00, $EA, $0F, $03, $00, $00, $00

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6E7F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $42, $05, $00, $56, $05, $00, $4C, $0F, $4D
    db $00, $70, $0E, $00, $46, $0F, $01, $00, $60, $0F, $47, $00, $C8, $0F, $15

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6E9E:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $02, $02, $02, $05, $05, $05, $05, $00, $00, $00, $00, $08
    db $08, $00, $04, $0F, $2D, $00, $54, $04, $00, $4C, $0F, $31, $00, $10, $0F, $35
    db $00, $44, $0F, $05, $00, $F0, $0F, $35, $00, $40, $1F, $09

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6ECA:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $01, $05, $05, $05, $05, $00, $00, $02, $00, $0A
    db $06, $00, $06, $0F, $2D, $00, $56, $02, $00, $4C, $0F, $33, $00, $00, $0F, $37
    db $00, $56, $06, $00, $5A, $06, $00, $F0, $0F, $29, $00, $3C, $1F, $15

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC2Screens0::
Data_05B_6EF8:: ; heuristic: map screen array; C0
    dfar Data_05B_6F10 ; entry 0
    dfar Data_05B_6FB3 ; entry 1
    dfar Data_05B_705C ; entry 2
    dfar Data_05B_710B ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC2Attrs0::
Data_05B_6F04:: ; heuristic: map screen array; C0
    dfar Data_05B_7198 ; entry 0
    dfar Data_05B_71D1 ; entry 1
    dfar Data_05B_7212 ; entry 2
    dfar Data_05B_7251 ; entry 3

; LZSS-compressed asset: 163 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6F10:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16EF10, $A3

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_6FB3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16EFB3, $A9

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_705C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F05C, $AF

; LZSS-compressed asset: 141 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_710B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F10B, $8D

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7198:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $46, $05, $00, $5A, $03, $00, $4E, $0F, $0B
    db $00, $5A, $04, $00, $74, $0F, $0B, $00, $80, $06, $00, $5E, $06, $00, $A6, $0E
    db $00, $A6, $0A, $00, $C6, $0F, $15, $00, $A0, $0F, $19, $00, $A4, $0F, $03, $00
    db $54, $08, $00, $4C, $0F, $01, $00, $00, $00

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_71D1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F1D1, $41

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7212:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $05, $05, $01, $0A, $01, $01, $00, $06, $01, $06
    db $0F, $27, $01, $0A, $02, $01, $54, $04, $01, $4E, $0F, $0B, $01, $FA, $F2, $01
    db $0A, $06, $01, $7C, $0F, $29, $01, $52, $0A, $01, $4C, $0F, $01, $01, $00, $0C
    db $01, $EA, $0F, $0F, $01, $52, $06, $01, $16, $1F, $0D, $01, $3E, $1F, $0B

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7251:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $05, $00, $52, $09, $00, $4C, $0F, $05
    db $00, $52, $04, $03, $03, $00, $6E, $0F, $13, $00, $6C, $0F, $01, $00, $58, $0F
    db $07, $00, $4A, $0F, $01, $00, $4A, $0E, $00, $48, $0F, $01, $00, $48, $0E, $00
    db $46, $0F, $01, $00, $00, $0F, $1F

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC3Screens0::
Data_05B_7288:: ; heuristic: map screen array; C0
    dfar Data_05B_72A0 ; entry 0
    dfar Data_05B_735A ; entry 1
    dfar Data_05B_73CB ; entry 2
    dfar Data_05B_7470 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC3Attrs0::
Data_05B_7294:: ; heuristic: map screen array; C0
    dfar Data_05B_7515 ; entry 0
    dfar Data_05B_7552 ; entry 1
    dfar Data_05B_7574 ; entry 2
    dfar Data_05B_75B0 ; entry 3

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_72A0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F2A0, $BA

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_735A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F35A, $71

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_73CB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F3CB, $A5

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7470:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F470, $A5

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7515:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $02, $03, $00, $0F, $48, $05, $05, $01, $01, $05, $05, $03, $4E
    db $0F, $11, $00, $00, $03, $74, $0F, $0D, $05, $05, $03, $84, $02, $03, $9C, $0F
    db $0F, $03, $AC, $0C, $03, $CE, $0F, $05, $03, $F8, $02, $03, $EC, $0F, $09, $03
    db $84, $00, $03, $86, $0C, $03, $1C, $1F, $03, $03, $FA, $0F, $0F

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7552:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $42, $05, $00, $56, $03, $00, $4A, $0F, $15
    db $00, $5C, $08, $00, $7E, $0F, $4D, $00, $B6, $0F, $21, $00, $4A, $0F, $29, $00
    db $00, $02

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7574:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $02, $02, $02, $05, $01, $04, $03, $01, $00, $00, $01, $0C
    db $04, $01, $04, $0F, $2D, $00, $00, $01, $08, $0A, $01, $54, $0F, $01, $01, $52
    db $0F, $23, $01, $0A, $06, $01, $A8, $0F, $01, $01, $52, $0F, $1D, $01, $08, $0F
    db $11, $01, $02, $04, $01, $18, $1F, $0F, $01, $40, $1F, $07

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_75B0:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $01, $05, $01, $06, $03, $01, $00, $02, $01, $00
    db $0F, $33, $00, $00, $01, $0A, $0A, $01, $56, $0E, $01, $06, $02, $01, $6E, $0F
    db $0B, $01, $06, $04, $01, $FC, $F0, $01, $98, $0F, $3B, $01, $08, $06, $01, $F0
    db $0F, $09, $01, $08, $08, $01, $18, $1F, $01, $01, $3A, $1F, $15

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC4Screens0::
Data_05B_75ED:: ; heuristic: map screen array; C0
    dfar Data_05B_75F3 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC4Attrs0::
Data_05B_75F0:: ; heuristic: map screen array; C0
    dfar Data_05B_76C5 ; entry 0

; LZSS-compressed asset: 210 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_75F3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F5F3, $D2

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_76C5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F6C5, $45

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC8Screens0::
Data_05B_770A:: ; heuristic: map screen array; C0
    dfar Data_05B_7716 ; entry 0
    dfar Data_05B_7783 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC8Attrs0::
Data_05B_7710:: ; heuristic: map screen array; C0
    dfar Data_05B_780D ; entry 0
    dfar Data_05B_7843 ; entry 1

; LZSS-compressed asset: 109 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7716:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F716, $6D

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7783:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $16F783, $8A

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_780D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $46, $02, $02, $00, $48, $0F, $11, $02, $00
    db $80, $01, $00, $72, $0F, $0D, $02, $02, $01, $01, $00, $96, $0F, $13, $00, $CE
    db $04, $00, $C4, $0F, $31, $00, $CE, $06, $00, $82, $06, $00, $1C, $1F, $0D, $00
    db $14, $1F, $01, $00, $00, $00

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05B_7843:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $03, $03, $03, $02, $00, $04, $07, $00, $00, $00, $00, $00
    db $0F, $2B, $00, $04, $0F, $3B, $00, $00, $0A, $00, $9A, $0F, $13, $00, $9A, $06
    db $00, $CA, $0F, $03, $00, $02, $04, $00, $E8, $0F, $13, $00, $E8, $0A, $00, $1C
    db $1F, $03, $00, $36, $1F, $0F
    ds $787, $00
