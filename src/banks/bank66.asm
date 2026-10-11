SECTION "Bank 66", ROMX[$4000], BANK[$66]
    db $66

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 3: entry 3 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1188 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles3:: ; heuristic: key-world tileset stream; C0
Data_066_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198001, $F59

; LZSS-compressed asset: 560 bytes expand to 563 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4F5A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $198F5A, $230

; LZSS-compressed asset: 560 bytes expand to 567 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_518A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $19918A, $230

; LZSS-compressed asset: 501 bytes expand to 514 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_53BA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1993BA, $1F5

; LZSS-compressed asset: 522 bytes expand to 519 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_55AF:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1995AF, $20A

; LZSS-compressed asset: 519 bytes expand to 519 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_57B9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1997B9, $207

; LZSS-compressed asset: 539 bytes expand to 536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_59C0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1999C0, $918

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map54Screens0::
Data_066_62D8:: ; heuristic: map screen array; C0
    dfar Data_066_62DE ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map54Attrs0::
Data_066_62DB:: ; heuristic: map screen array; C0
    dfar Data_066_63B5 ; entry 0

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_62DE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19A2DE, $D7

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_63B5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19A3B5, $4D

; compressed tileset of map $62 (the first map record using it)
; LZSS-compressed asset: 1152 bytes expand to 1312 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Tileset:: ; heuristic: map tileset stream; C0
Data_066_6402:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19A402, $480

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map62Palettes::
Data_066_6882:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $194C, $7FFF, $01DA, $0000 ; entry 1
    dw $001B, $2BFF, $023F, $0000 ; entry 2
    dw $218C, $7FFF, $5AB1, $0000 ; entry 3
    dw $194C, $3A9A, $01DA, $0000 ; entry 4
    dw $0142, $7FFF, $7E80, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map62Screens0::
Data_066_68C2:: ; heuristic: map screen array; C0
    dfar Data_066_68F2 ; entry 0
    dfar Data_066_69B7 ; entry 1
    dfar Data_066_6A9F ; entry 2
    dfar Data_066_6B53 ; entry 3
    dfar Data_066_6C07 ; entry 4
    dfar Data_066_6CB6 ; entry 5
    dfar Data_066_6D46 ; entry 6
    dfar Data_066_6DF1 ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map62Attrs0::
Data_066_68DA:: ; heuristic: map screen array; C0
    dfar Data_066_6ECE ; entry 0
    dfar Data_066_6F2A ; entry 1
    dfar Data_066_6F8B ; entry 2
    dfar Data_066_6FCC ; entry 3
    dfar Data_066_7020 ; entry 4
    dfar Data_066_7072 ; entry 5
    dfar Data_066_70AE ; entry 6
    dfar Data_066_70FD ; entry 7

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_68F2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19A8F2, $C5

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_69B7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19A9B7, $E8

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6A9F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AA9F, $B4

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6B53:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AB53, $B4

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6C07:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AC07, $AF

; LZSS-compressed asset: 144 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6CB6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19ACB6, $90

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6D46:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AD46, $AB

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6DF1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19ADF1, $DD

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6ECE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AECE, $5C

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6F2A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AF2A, $61

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6F8B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AF8B, $41

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6FCC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AFCC, $54

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7020:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B020, $52

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7072:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $01, $04, $04, $01, $00, $04, $0D, $00, $02, $0F, $31, $00
    db $02, $08, $00, $52, $08, $03, $03, $00, $60, $0F, $01, $00, $86, $00, $00, $78
    db $0F, $4B, $00, $04, $02, $00, $86, $02, $00, $F0, $04, $00, $EA, $0F, $1B, $00
    db $0E, $0C, $00, $22, $18, $00, $34, $1F, $09, $00, $04, $00

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_70AE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B0AE, $4F

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_70FD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B0FD, $62

; compressed tileset of map $63 (the first map record using it)
; LZSS-compressed asset: 856 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Tileset:: ; heuristic: map tileset stream; C0
Data_066_715F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B15F, $358

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map63Palettes::
Data_066_74B7:: ; heuristic: map BG palettes; C0
    dw $294A, $7FFF, $5294, $0000 ; entry 0
    dw $24C6, $7FD9, $5AB1, $0063 ; entry 1
    dw $7DA0, $7F75, $6B40, $0063 ; entry 2
    dw $7DA0, $7FD9, $7380, $0063 ; entry 3
    dw $5D8C, $7FD9, $5AB1, $0000 ; entry 4
    dw $7DA0, $7FD9, $7FE0, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $03E0 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map63Screens0::
Data_066_74F7:: ; heuristic: map screen array; C0
    dfar Data_066_750F ; entry 0
    dfar Data_066_75A4 ; entry 1
    dfar Data_066_764C ; entry 2
    dfar Data_066_76E7 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map63Attrs0::
Data_066_7503:: ; heuristic: map screen array; C0
    dfar Data_066_7759 ; entry 0
    dfar Data_066_779E ; entry 1
    dfar Data_066_77E7 ; entry 2
    dfar Data_066_7835 ; entry 3

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_750F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B50F, $95

; LZSS-compressed asset: 168 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_75A4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B5A4, $A8

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_764C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B64C, $9B

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_76E7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B6E7, $72

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7759:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B759, $45

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_779E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B79E, $49

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_77E7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B7E7, $4E

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7835:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $03, $03, $03, $01, $F6, $FA, $02, $02, $01, $00, $0F, $29
    db $04, $04, $04, $04, $01, $F8, $F8, $01, $10, $00, $01, $F4, $FC, $01, $60, $0A
    db $01, $5C, $02, $01, $74, $0F, $0B, $01, $82, $04, $01, $9A, $0F, $07, $01, $A6
    db $08, $01, $C0, $0F, $4D, $01, $A8, $08, $01, $3E, $1F, $15

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map64Screens0::
Data_066_7871:: ; heuristic: map screen array; C0
    dfar Data_066_7889 ; entry 0
    dfar Data_066_7939 ; entry 1
    dfar Data_066_79DB ; entry 2
    dfar Data_066_7A5D ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map64Attrs0::
Data_066_787D:: ; heuristic: map screen array; C0
    dfar Data_066_7AE1 ; entry 0
    dfar Data_066_7B48 ; entry 1
    dfar Data_066_7B87 ; entry 2
    dfar Data_066_7BC3 ; entry 3

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7889:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B889, $B0

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7939:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B939, $A2

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_79DB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B9DB, $82

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7A5D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BA5D, $84

; LZSS-compressed asset: 103 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7AE1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BAE1, $67

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7B48:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $0F, $3C, $03, $03, $04, $04, $03, $01, $54, $01
    db $01, $52, $00, $01, $52, $00, $01, $4E, $00, $00, $00, $01, $54, $0C, $04, $04
    db $01, $66, $0E, $01, $FC, $F0, $01, $7C, $0F, $4D, $01, $B4, $0F, $17, $01, $54
    db $02, $01, $0C, $1F, $0D, $01, $4C, $02, $01, $3E, $0F, $01, $01, $00, $0A

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7B87:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $02, $03, $03, $02, $00, $04, $0D, $00, $02, $0F, $2B, $00
    db $52, $02, $04, $04, $00, $58, $02, $00, $4E, $0F, $09, $00, $5A, $04, $00, $72
    db $0F, $11, $00, $56, $04, $00, $9E, $0F, $0D, $00, $6E, $0F, $19, $00, $52, $00
    db $00, $EE, $0F, $11, $00, $72, $0F, $09, $00, $3E, $1F, $13

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7BC3:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $02, $02, $02, $03, $03, $00, $00, $00, $00, $06, $0A, $00
    db $04, $0F, $27, $03, $00, $52, $0B, $00, $4E, $0F, $2D, $00, $9E, $0F, $3D, $00
    db $52, $0F, $4D, $00, $9E, $0F, $03

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map65Screens0::
Data_066_7BEA:: ; heuristic: map screen array; C0
    dfar Data_066_7C02 ; entry 0
    dfar Data_066_7C54 ; entry 1
    dfar Data_066_7CB4 ; entry 2
    dfar Data_066_7D15 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map65Attrs0::
Data_066_7BF6:: ; heuristic: map screen array; C0
    dfar Data_066_7DD2 ; entry 0
    dfar Data_066_7DF8 ; entry 1
    dfar Data_066_7E1C ; entry 2
    dfar Data_066_7E43 ; entry 3

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7C02:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BC02, $52

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7C54:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BC54, $60

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7CB4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BCB4, $61

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7D15:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BD15, $BD

; LZSS-compressed asset: 38 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7DD2:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $03, $00, $52, $0D, $00, $50, $0F, $03
    db $04, $00, $7A, $0D, $00, $78, $0F, $03, $00, $52, $0F, $4D, $00, $B2, $0F, $3D
    db $00, $4E, $0F, $01, $02, $02

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7DF8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $03, $00, $50, $0D, $00, $4E, $0F, $03
    db $04, $00, $78, $0D, $00, $76, $0F, $03, $00, $50, $0F, $4D, $00, $B0, $0F, $2D
    db $00, $00, $0F, $15

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7E1C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $02, $03, $00, $02, $0B, $02, $02, $00, $00, $0F, $03, $04
    db $00, $2A, $0B, $00, $26, $0F, $05, $00, $02, $0F, $4D, $00, $62, $0F, $4D, $00
    db $C2, $0F, $1D, $00, $3E, $1F, $13

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7E43:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BE43, $76

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map67Screens0::
Data_066_7EB9:: ; heuristic: map screen array; C0
    dfar Data_066_7EBF ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map67Attrs0::
Data_066_7EBC:: ; heuristic: map screen array; C0
    dfar Data_066_7F8F ; entry 0

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7EBF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BEBF, $D0

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7F8F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BF8F, $58
    ds $19, $00
