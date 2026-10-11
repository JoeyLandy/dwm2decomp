SECTION "Bank 6F", ROMX[$4000], BANK[$6F]
    db $6F

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4001:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC001, $58

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4059:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC059, $9B

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_40F4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC0F4, $AB

; LZSS-compressed asset: 220 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_419F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC19F, $DC

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_427B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC27B, $CE

; LZSS-compressed asset: 234 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4349:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC349, $EA

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4433:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC433, $D1

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4504:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC504, $D1

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_45D5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC5D5, $6B

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4640:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC640, $E7

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4727:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC727, $EC

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4813:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC813, $C8

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_48DB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC8DB, $64

; LZSS-compressed asset: 199 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_493F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC93F, $C7

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4A06:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCA06, $C0

; LZSS-compressed asset: 264 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4AC6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCAC6, $108

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4BCE:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $18, $0F, $04, $01, $00, $78, $07
    db $00, $74, $0C, $00, $80, $0E, $03, $03, $00, $94, $0F, $19, $00, $88, $0A, $00
    db $CE, $0A, $00, $18, $0F, $4D, $00, $08, $1F, $05

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4BF8:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCBF8, $41

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4C39:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $40, $01, $01, $00, $4C, $0F, $0F, $01, $01
    db $01, $01, $03, $00, $7C, $01, $00, $78, $00, $00, $54, $00, $00, $82, $02, $00
    db $7C, $0F, $01, $00, $9E, $04, $00, $52, $02, $00, $9E, $0F, $07, $00, $46, $0C
    db $00, $C8, $0F, $01, $00, $00, $0F, $41, $00, $00, $0F, $11

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4C75:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCC75, $45

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4CBA:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCCBA, $43

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4CFD:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCCFD, $56

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4D53:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $48, $03, $03, $00, $4A, $0F, $07, $01, $01
    db $01, $01, $00, $54, $08, $00, $78, $00, $00, $78, $0F, $2B, $00, $54, $06, $03
    db $03, $00, $88, $0E, $00, $D4, $04, $00, $74, $04, $00, $E8, $08, $00, $F0, $0F
    db $05, $00, $86, $0E, $00, $1A, $1F, $05, $00, $00, $0F, $0F

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4D8F:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCD8F, $188

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4F17:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $18, $0F, $04, $01, $00, $78, $01
    db $00, $18, $00, $05, $05, $05, $05, $03, $03, $00, $78, $02, $00, $7A, $0F, $03
    db $00, $7E, $0F, $3D, $00, $F3, $0F, $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4F43:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCF43, $46

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4F89:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCF89, $4B

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4FD4:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCFD4, $4A

; compressed BG tiles (2048 bytes, 128 tiles): entry 6 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 736 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles6:: ; heuristic: map type 5 tileset stream; C0
Data_06F_501E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1BD01E, $2E0

; E-0140 (C1: entry 6 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes6::
Data_06F_52FE:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $150B, $5F17, $15AE, $0044 ; entry 1
    dw $1528, $5F17, $15AE, $0000 ; entry 2
    dw $218C, $5F17, $15AE, $0044 ; entry 3
    dw $5D8C, $5F17, $5AB1, $0000 ; entry 4
    dw $7DA0, $5F17, $7FE0, $0063 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_533E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD33E, $88

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_53C6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD3C6, $AD

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5473:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD473, $8B

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_54FE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD4FE, $D4

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_55D2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD5D2, $92

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5664:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD664, $D4

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5738:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD738, $E3

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_581B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD81B, $C9

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_58E4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD8E4, $8B

; LZSS-compressed asset: 252 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_596F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD96F, $FC

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5A6B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDA6B, $BE

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5B29:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDB29, $C5

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5BEE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDBEE, $93

; LZSS-compressed asset: 199 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5C81:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDC81, $C7

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5D48:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDD48, $F9

; LZSS-compressed asset: 220 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5E41:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDE41, $DC

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5F1D:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $20, $0F, $0C, $03, $03, $03, $03
    db $01, $01, $02, $02, $01, $01, $00, $84, $00, $00, $7A, $0F, $09, $00, $88, $02
    db $00, $9C, $0F, $11, $00, $86, $02, $00, $C6, $0F, $11, $00, $72, $0C, $00, $FA
    db $0F, $01, $03, $03, $00, $10, $1F, $11, $00, $88, $08, $00, $40, $1F, $01

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5F5C:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDF5C, $44

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5FA0:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $26, $0F, $12, $01, $01, $03, $03
    db $01, $01, $00, $78, $0F, $33, $01, $00, $D2, $05, $00, $C8, $0F, $0B, $03, $00
    db $FA, $01, $00, $26, $0A, $00, $FA, $0F, $01, $00, $86, $00, $00, $76, $0F, $01
    db $00, $76, $0E, $00, $74, $0F, $01, $00, $26, $04

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5FDA:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDFDA, $4A

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6024:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $28, $0F, $14, $03, $03, $01, $01
    db $00, $78, $0F, $0D, $03, $00, $AC, $01, $00, $9E, $0F, $0B, $01, $01, $01, $01
    db $00, $AC, $00, $00, $CE, $00, $00, $C8, $0F, $0F, $00, $28, $0A, $00, $F8, $0F
    db $01, $00, $88, $0F, $11, $00, $CC, $04, $00, $38, $1F, $09

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6060:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE060, $4A

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_60AA:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE0AA, $4D

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_60F7:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE0F7, $1DB

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_62D2:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE2D2, $45

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6317:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE317, $47

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_635E:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $1E, $0F, $0A, $05, $05, $00, $7C
    db $02, $01, $00, $86, $01, $00, $78, $0F, $07, $03, $03, $00, $82, $06, $00, $9E
    db $0F, $09, $05, $05, $00, $A6, $00, $00, $C0, $0F, $0F, $00, $1E, $00, $00, $EA
    db $0C, $00, $F6, $0F, $05, $00, $1E, $0F, $33

; compressed BG tiles (2048 bytes, 128 tiles): entry 7 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 697 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles7:: ; heuristic: map type 5 tileset stream; C0
Data_06F_6397:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1BE397, $DE

; LZSS-compressed asset: 1043 bytes expand to 1040 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6475:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE475, $1DB

; E-0140 (C1: entry 7 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes7::
Data_06F_6650:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $150B, $5F17, $15AE, $0044 ; entry 1
    dw $1528, $5F17, $15AE, $0000 ; entry 2
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 3
    dw $5D8C, $5F17, $5AB1, $0000 ; entry 4
    dw $218C, $5F17, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 142 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6690:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE690, $8E

; LZSS-compressed asset: 185 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_671E:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE71E, $B9

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_67D7:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE7D7, $B1

; LZSS-compressed asset: 202 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6888:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE888, $CA

; LZSS-compressed asset: 219 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6952:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE952, $DB

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6A2D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEA2D, $AD

; LZSS-compressed asset: 202 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6ADA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEADA, $CA

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6BA4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEBA4, $F7

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6C9B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEC9B, $99

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6D34:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BED34, $D8

; LZSS-compressed asset: 225 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6E0C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEE0C, $E1

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6EED:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEEED, $D6

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6FC3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEFC3, $88

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_704B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF04B, $BA

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_7105:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF105, $EB

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_71F0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF1F0, $DD

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_72CD:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $18, $0F, $04, $01, $01, $01, $01
    db $00, $76, $00, $00, $6C, $0F, $15, $00, $7E, $08, $00, $A0, $0F, $05, $01, $01
    db $03, $03, $00, $BC, $0F, $0D, $00, $70, $06, $00, $E6, $0F, $13, $00, $50, $0F
    db $1B, $00, $3A, $1F, $07

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_7302:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF302, $4C

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_734E:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $18, $0F, $04, $01, $01, $01, $01
    db $00, $68, $0F, $17, $00, $7A, $0A, $00, $A0, $0F, $0B, $00, $78, $06, $00, $C8
    db $0F, $01, $00, $72, $04, $00, $76, $02, $00, $7A, $08, $00, $F6, $0F, $03, $01
    db $01, $03, $03, $03, $03, $00, $12, $1F, $0D, $00, $76, $0F, $0F

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_738B:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $03, $03, $00, $40, $0F, $11, $01, $01
    db $01, $01, $00, $68, $0F, $1B, $03, $00, $AA, $01, $00, $9C, $0F, $09, $00, $78
    db $02, $01, $01, $00, $C0, $0F, $09, $00, $74, $02, $00, $74, $0E, $00, $F4, $0F
    db $01, $00, $EE, $08, $00, $14, $1F, $0D, $00, $78, $0F, $0D

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_73C7:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF3C7, $46

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_740D:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $1A, $01, $01, $00, $1C, $0F, $35, $01, $01
    db $00, $2E, $00, $00, $6A, $0F, $13, $00, $78, $02, $00, $96, $0F, $0D, $03, $03
    db $03, $03, $00, $BA, $0F, $0F, $00, $00, $00, $00, $E0, $0F, $15, $00, $9E, $04
    db $00, $10, $1F, $0F, $00, $76, $04, $00, $3A, $1F, $07

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_7448:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF448, $44

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_748C:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF48C, $1D4

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_7660:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF660, $47

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_76A7:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF6A7, $51

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_76F8:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF6F8, $51
    ds $8B7, $00
