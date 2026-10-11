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
Data_063_4468:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $1415, $7DFF, $7C18, $2C09 ; entry 2
    dw $318C, $5294, $03E2, $0000 ; entry 3
    dw $158F, $2AB7, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7

Data_063_44A8:: ; heuristic: key-world screen header; C0
    db $02, $01, $05, $0E, $0F, $33, $11, $00

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_44B0:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18C4B0, $8F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_453F::
Data_063_453F:: ; address name
    db $07, $01, $05, $0E, $0F, $33, $12, $00 ; entry 0

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4547:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18C547, $9C

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_45E3::
Data_063_45E3:: ; address name
    db $06, $01, $05, $0E, $0F, $33, $13, $00 ; entry 0

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_45EB:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18C5EB, $A1

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_468C::
Data_063_468C:: ; address name
    db $FF, $01, $06, $0E, $0F, $33, $14, $00 ; entry 0

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4694:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18C694, $99

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_472D::
Data_063_472D:: ; address name
    db $01, $01, $05, $0E, $0F, $33, $15, $00 ; entry 0

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4735:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18C735, $9F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_47D4::
Data_063_47D4:: ; address name
    db $07, $01, $05, $0E, $0F, $33, $16, $00 ; entry 0

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_47DC:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18C7DC, $8B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_4867::
Data_063_4867:: ; address name
    db $FF, $01, $06, $0E, $0F, $33, $17, $00 ; entry 0

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_486F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18C86F, $8B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_48FA::
Data_063_48FA:: ; address name
    db $FF, $01, $03, $0E, $0F, $33, $18, $00 ; entry 0

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4902:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18C902, $83

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_63_4985::
Data_063_4985:: ; address name
    db $07, $01, $05, $0B, $0E, $33, $19, $00 ; entry 0

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_498D:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18C98D, $A9

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4A36:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $09, $00
    db $0A, $06, $00, $26, $0F, $09, $00, $30, $08, $00, $4E, $0F, $07, $00, $56, $0A
    db $00, $76, $0F, $03, $00, $9F, $0F, $4D, $00, $FF, $0F, $4D, $00, $0A, $04

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4A65:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18CA65, $50

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4AB5:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $4D, $00
    db $10, $06, $00, $1E, $06, $00, $74, $0F, $05, $01, $01, $02, $02, $00, $92, $0C
    db $00, $A0, $0F, $05, $00, $CA, $00, $00, $BC, $0F, $15, $00, $CA, $0A, $00, $F2
    db $0F, $01, $00, $F0, $06, $00, $E6, $0F, $01, $00, $A4, $0E, $00, $38, $1F, $0B

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4AF5:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $09, $00
    db $0A, $06, $00, $26, $0F, $0B, $00, $08, $0F, $0F, $00, $12, $04, $00, $6E, $0F
    db $0B, $00, $0E, $06, $00, $96, $0F, $11, $00, $CD, $0F, $4D, $00, $08, $1F, $27

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4B25:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18CB25, $4B

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4B70:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18CB70, $47

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4BB7:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $33, $00
    db $08, $06, $00, $50, $0F, $0D, $00, $06, $04, $00, $78, $0F, $01, $00, $76, $0C
    db $00, $9C, $0F, $07, $00, $12, $02, $00, $C8, $08, $00, $C8, $0F, $0D, $00, $F8
    db $08, $00, $F4, $0F, $01, $00, $0C, $1F, $39

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4BF0:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $33, $00
    db $08, $06, $00, $50, $0F, $03, $00, $10, $0E, $00, $78, $0F, $01, $00, $0C, $0C
    db $00, $9C, $0F, $0D, $00, $10, $04, $00, $C4, $0F, $39, $00, $14, $1F, $31

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_4C1F:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18CC1F, $4C

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 5: entry 5 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1285 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles5:: ; heuristic: key-world tileset stream; C0
Data_063_4C6B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $18CC6B, $505

; E-0139 (C1: entry 5 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes5::
Data_063_5170:: ; address name
    dw $012F, $7FFF, $2AB7, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $0142, $03FF, $034E, $0000 ; entry 2
    dw $318C, $5294, $03E2, $0000 ; entry 3
    dw $158F, $2AB7, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $18D1B0, $79

Data_063_5229:: ; heuristic: key-world screen header; C0
    db $07, $03, $04, $0A, $0D, $33, $3F, $00

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5231:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18D231, $71

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_52A2::
Data_063_52A2:: ; address name
    db $FF, $01, $04, $0D, $0F, $33, $40, $00 ; entry 0

; LZSS-compressed asset: 115 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_52AA:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18D2AA, $73

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_531D::
Data_063_531D:: ; address name
    db $FF, $01, $04, $0A, $0F, $33, $41, $00 ; entry 0

; LZSS-compressed asset: 140 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5325:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18D325, $8C

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_53B1::
Data_063_53B1:: ; address name
    db $03, $04, $05, $08, $0C, $33, $42, $00 ; entry 0

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_53B9:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18D3B9, $7E

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_5437::
Data_063_5437:: ; address name
    db $05, $04, $08, $0A, $0D, $33, $43, $00 ; entry 0

; LZSS-compressed asset: 185 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_543F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18D43F, $B9

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_54F8::
Data_063_54F8:: ; address name
    db $FF, $04, $05, $08, $0D, $33, $44, $00 ; entry 0

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5500:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18D500, $7A

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_557A::
Data_063_557A:: ; address name
    db $FF, $04, $08, $0B, $0D, $33, $45, $00 ; entry 0

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5582:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18D582, $9F

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_63_5621::
Data_063_5621:: ; address name
    db $01, $03, $06, $08, $0D, $33, $46, $00 ; entry 0

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5629:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18D629, $C4

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_56ED:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $1E, $0F, $0A, $01, $00, $7E, $03
    db $00, $72, $0F, $07, $00, $7E, $04, $00, $A7, $0F, $4D, $00, $07, $1F, $4D

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_570C:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $40, $0F, $2C, $01, $00, $A0, $01
    db $02, $00, $A6, $03, $00, $A0, $02, $00, $A0, $0F, $03, $00, $A6, $04, $00, $A6
    db $08, $00, $CA, $0F, $01, $00, $C8, $0A, $00, $C2, $0F, $01, $00, $B0, $0F, $07
    db $00, $A2, $0F, $05, $00, $3A, $1F, $0F

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5744:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $40, $0F, $2C, $01, $01, $01, $01
    db $00, $94, $0C, $00, $A0, $0F, $2D, $00, $A2, $06, $00, $EC, $06, $00, $F4, $0F
    db $03, $00, $12, $1F, $37

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5769:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18D769, $43

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_57AC:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $18, $01, $00, $2C, $07, $00, $24, $0F, $07
    db $00, $2C, $08, $00, $34, $04, $00, $52, $0F, $27, $00, $52, $0C, $00, $AF, $0F
    db $4D, $00, $08, $1F, $45

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_57D1:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18D7D1, $51

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5822:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $1A, $01, $00, $2E, $01, $00, $20, $0F, $0D
    db $00, $2E, $0F, $13, $00, $2C, $0F, $13, $00, $2E, $02, $00, $30, $06, $00, $A0
    db $06, $00, $A6, $0F, $05, $00, $32, $02, $00, $C4, $0F, $11, $00, $FB, $0F, $4D
    db $00, $B0, $08

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5855:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18D855, $55

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_58AA:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18D8AA, $5D

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 9: entry 9 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1190 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles9:: ; heuristic: key-world tileset stream; C0
Data_063_5907:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $18D907, $4A6

; E-0139 (C1: entry 9 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes9::
Data_063_5DAD:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $012F, $3FBF, $03E2, $0000 ; entry 2
    dw $318C, $7FFF, $03E2, $0000 ; entry 3
    dw $0160, $3FBF, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7

Data_063_5DED:: ; heuristic: key-world screen header; C0
    db $01, $02, $04, $07, $0C, $33, $62, $00

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5DF5:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18DDF5, $62

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_5E57::
Data_063_5E57:: ; address name
    db $FF, $02, $04, $05, $07, $33, $63, $00 ; entry 0

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5E5F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18DE5F, $50

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_5EAF::
Data_063_5EAF:: ; address name
    db $FF, $00, $01, $02, $04, $33, $64, $00 ; entry 0

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5EB7:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18DEB7, $59

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_63_5F10::
Data_063_5F10:: ; address name
    db $FF, $00, $01, $02, $07, $33, $65, $00 ; entry 0

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5F18:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18DF18, $81

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_5F99::
Data_063_5F99:: ; address name
    db $05, $02, $06, $0C, $0D, $33, $66, $00 ; entry 0

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_5FA1:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18DFA1, $A6

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6047::
Data_063_6047:: ; address name
    db $00, $04, $06, $09, $0C, $33, $67, $00 ; entry 0

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_604F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E04F, $8B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_60DA::
Data_063_60DA:: ; address name
    db $00, $02, $03, $06, $0F, $33, $68, $00 ; entry 0

; LZSS-compressed asset: 102 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_60E2:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E0E2, $66

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6148::
Data_063_6148:: ; address name
    db $FF, $03, $08, $09, $0B, $33, $69, $00 ; entry 0

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6150:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E150, $72

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_63_61C2::
Data_063_61C2:: ; address name
    db $01, $03, $05, $0A, $0B, $33, $6A, $00 ; entry 0

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_61CA:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18E1CA, $CE

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6298:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $4D, $00
    db $10, $0A, $00, $1A, $06, $00, $78, $0F, $0F, $00, $1C, $02, $00, $A0, $0F, $0F
    db $00, $72, $0F, $11, $00, $1E, $0F, $4D, $00, $F6, $0A

; LZSS-compressed asset: 27 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_62C3:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $4D, $00
    db $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $21

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_62DE:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $2D, $00
    db $0A, $06, $00, $4A, $0F, $4D, $00, $82, $0F, $23, $00, $8E, $0C, $00, $F0, $0F
    db $07, $00, $06, $0F, $37

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6303:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $31, $00
    db $0A, $06, $00, $4E, $0F, $09, $02, $02, $00, $6C, $0F, $11, $00, $7E, $0A, $00
    db $9E, $0F, $31, $00, $F4, $00, $00, $E6, $0F, $0F, $00, $7C, $00, $00, $08, $0E
    db $00, $1E, $1F, $01, $00, $06, $0F, $0F

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_633B:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E33B, $48

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6383:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E383, $4C

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_63CF:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $2F, $00
    db $0A, $06, $00, $4C, $0F, $33, $00, $04, $0A, $00, $A0, $0F, $0D, $00, $06, $04
    db $00, $C8, $0F, $11, $00, $08, $00, $00, $F0, $0F, $0B, $00, $0A, $0F, $33

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_63FE:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E3FE, $46

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6444:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18E444, $59

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_63_649D::
Data_063_649D:: ; address name
    db $03, $03, $06, $07, $09, $33, $86, $00 ; entry 0

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_64A5:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18E4A5, $4E

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_64F3::
Data_063_64F3:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $33, $87, $00 ; entry 0

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_64FB:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E4FB, $53

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_63_654E::
Data_063_654E:: ; address name
    db $FF, $03, $04, $05, $06, $33, $88, $00 ; entry 0

; LZSS-compressed asset: 104 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6556:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18E556, $68

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_65BE::
Data_063_65BE:: ; address name
    db $01, $03, $06, $07, $09, $33, $89, $00 ; entry 0

; LZSS-compressed asset: 112 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_65C6:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E5C6, $70

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6636::
Data_063_6636:: ; address name
    db $05, $05, $06, $08, $0B, $33, $8A, $00 ; entry 0

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_663E:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E63E, $71

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_66AF::
Data_063_66AF:: ; address name
    db $01, $04, $09, $0B, $0D, $33, $8B, $00 ; entry 0

; LZSS-compressed asset: 141 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_66B7:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E6B7, $8D

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6744::
Data_063_6744:: ; address name
    db $FF, $02, $04, $0A, $0C, $33, $8C, $00 ; entry 0

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_674C:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E74C, $8F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_67DB::
Data_063_67DB:: ; address name
    db $FF, $02, $05, $0B, $0D, $33, $8D, $00 ; entry 0

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_67E3:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18E7E3, $88

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_63_686B::
Data_063_686B:: ; address name
    db $01, $04, $09, $02, $0C, $33, $8E, $00 ; entry 0

; LZSS-compressed asset: 184 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6873:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18E873, $B8

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_692B:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $1E, $0F, $0A, $01, $00, $7E, $03
    db $00, $72, $0F, $07, $00, $7E, $04, $00, $94, $0F, $3F, $00, $74, $0E, $00, $F8
    db $0F, $49

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_694D:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $40, $0F, $2C, $01, $01, $02, $02
    db $00, $90, $0F, $15, $00, $A2, $0C, $00, $C8, $0F, $07, $00, $A2, $0A, $00, $F0
    db $0F, $09, $00, $A2, $08, $00, $18, $1F, $03, $00, $40, $14, $00, $36, $1F, $0B

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_697D:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $00, $03, $00, $00, $0F, $42, $01, $01, $00, $44, $0F, $0F, $01, $00
    db $7A, $01, $00, $6C, $0F, $0D, $00, $7A, $02, $00, $7C, $0A, $00, $A0, $0F, $0B
    db $00, $56, $06, $00, $C8, $0F, $4D, $00, $9C, $0F, $19

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_69A8:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $20, $0F, $0C, $02, $02, $02, $02
    db $00, $70, $0F, $09, $01, $00, $A0, $01, $00, $80, $00, $00, $80, $06, $00, $A0
    db $0F, $07, $00, $A4, $02, $00, $98, $0A, $00, $CE, $0F, $03, $01, $01, $00, $20
    db $06, $00, $F0, $0F, $4D, $00, $20, $00

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_69E0:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $1C, $01, $00, $30, $01, $00, $22, $0F, $15
    db $00, $34, $0A, $00, $58, $0C, $00, $58, $04, $00, $70, $0F, $09, $00, $7C, $08
    db $00, $34, $04, $00, $A0, $0F, $4D, $00, $78, $0A, $00, $4E, $0E, $00, $20, $1F
    db $21

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6A11:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18EA11, $50

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6A61:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $18, $01, $01, $00, $1A, $0F, $3D, $00, $2C
    db $06, $00, $2C, $04, $00, $7C, $0C, $00, $7C, $00, $00, $7C, $06, $00, $7C, $02
    db $00, $A0, $0F, $0D, $00, $A2, $04, $00, $C8, $0F, $09, $00, $C8, $0E, $00, $F6
    db $0F, $09, $00, $76, $06, $00, $1C, $1F, $07, $00, $72, $0A, $00, $44, $1C

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6AA0:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18EAA0, $47

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6AE7:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18EAE7, $5C

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6B43::
Data_063_6B43:: ; address name
    db $06, $03, $08, $0B, $0D, $02, $AA, $00 ; entry 0

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6B4B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18EB4B, $82

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6BCD::
Data_063_6BCD:: ; address name
    db $07, $03, $08, $0B, $0D, $02, $AB, $00 ; entry 0

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6BD5:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18EBD5, $A4

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6C79::
Data_063_6C79:: ; address name
    db $05, $05, $08, $0B, $0D, $2F, $AC, $00 ; entry 0

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6C81:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18EC81, $8A

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6D0B::
Data_063_6D0B:: ; address name
    db $00, $03, $08, $0B, $0D, $2F, $AD, $00 ; entry 0

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6D13:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18ED13, $A0

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6DB3::
Data_063_6DB3:: ; address name
    db $03, $03, $08, $0B, $0D, $02, $AE, $00 ; entry 0

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6DBB:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18EDBB, $93

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6E4E::
Data_063_6E4E:: ; address name
    db $00, $03, $08, $0B, $0D, $02, $AF, $00 ; entry 0

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6E56:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18EE56, $A9

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6EFF::
Data_063_6EFF:: ; address name
    db $FF, $02, $0B, $0D, $0F, $02, $B0, $00 ; entry 0

; LZSS-compressed asset: 185 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6F07:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18EF07, $B9

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_6FC0::
Data_063_6FC0:: ; address name
    db $FF, $03, $08, $0B, $0D, $02, $B1, $00 ; entry 0

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_6FC8:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18EFC8, $AB

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_7073::
Data_063_7073:: ; address name
    db $06, $02, $06, $09, $0D, $02, $B2, $00 ; entry 0

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_707B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F07B, $D6

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7151:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $4D, $02, $40, $0F, $2C, $02, $FE, $FF, $01
    db $02, $A0, $0F, $03, $02, $FE, $FE, $02, $C8, $0F, $05, $02, $FE, $FC, $02, $F0
    db $0F, $07, $02, $FE, $FA, $02, $18, $1F, $09, $02, $FE, $F8, $02, $40, $1F, $01

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7181:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F181, $53

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_71D4:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $4D, $02, $40, $0F, $2C, $02, $F8, $FF, $01
    db $02, $A0, $0F, $09, $02, $FE, $F8, $02, $C8, $0F, $4D, $02, $00, $1F, $19

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_71F3:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $0F, $1C, $02, $03, $30, $01, $03, $22, $0F, $0B
    db $03, $30, $02, $03, $30, $0A, $03, $54, $0E, $03, $58, $0C, $03, $76, $0F, $03
    db $03, $FC, $F0, $03, $34, $0C, $03, $A0, $0F, $05, $03, $FC, $FC, $03, $C8, $0F
    db $31, $03, $FE, $F8, $03, $18, $1F, $29

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_722B:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $4D, $02, $40, $0F, $2C, $02, $FE, $FF, $01
    db $02, $A0, $0F, $4D, $02, $B0, $02, $02, $FE, $FE, $02, $18, $1F, $05, $02, $FA
    db $FC, $02, $40, $1F, $01

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7250:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F250, $4A

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_729A:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $44, $02, $FC, $FF, $01, $02, $FC, $FE, $02
    db $F6, $FF, $01, $02, $F6, $FA, $02, $FE, $F0, $02, $F4, $FC, $02, $A0, $0F, $03
    db $02, $F8, $F6, $02, $C0, $0F, $15, $02, $76, $0F, $17, $02, $12, $1F, $2F

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_72C9:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $0F, $4D, $03, $20, $0F, $0C, $02, $02, $02, $02
    db $03, $70, $0F, $09, $03, $FE, $F2, $03, $FA, $F2, $03, $80, $04, $03, $A0, $0F
    db $03, $03, $F4, $F8, $03, $C2, $0F, $15, $03, $9A, $04, $03, $F2, $0F, $05, $03
    db $20, $0A, $03, $18, $1F, $07, $03, $FC, $FA, $03, $40, $1F, $01

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7306:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F306, $56

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_735C::
Data_063_735C:: ; address name
    db $03, $04, $06, $09, $0B, $06, $CE, $00 ; entry 0

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7364:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F364, $94

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_73F8::
Data_063_73F8:: ; address name
    db $01, $04, $06, $09, $0B, $06, $CF, $00 ; entry 0

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7400:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F400, $A4

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_74A4::
Data_063_74A4:: ; address name
    db $03, $04, $06, $09, $0B, $06, $D0, $00 ; entry 0

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_74AC:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F4AC, $99

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_7545::
Data_063_7545:: ; address name
    db $01, $04, $06, $09, $0B, $06, $D1, $00 ; entry 0

; LZSS-compressed asset: 217 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_754D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F54D, $D9

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_7626::
Data_063_7626:: ; address name
    db $05, $04, $06, $09, $0B, $06, $D2, $00 ; entry 0

; LZSS-compressed asset: 157 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_762E:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F62E, $9D

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_76CB::
Data_063_76CB:: ; address name
    db $04, $02, $07, $0B, $0F, $06, $D3, $00 ; entry 0

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_76D3:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F6D3, $C0

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_7793::
Data_063_7793:: ; address name
    db $FF, $02, $03, $04, $0B, $06, $D4, $00 ; entry 0

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_779B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F79B, $C2

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_785D::
Data_063_785D:: ; address name
    db $FF, $00, $04, $0C, $0F, $06, $D5, $00 ; entry 0

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7865:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F865, $ED

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_63_7952::
Data_063_7952:: ; address name
    db $01, $03, $06, $09, $0F, $06, $D6, $00 ; entry 0

; LZSS-compressed asset: 242 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_795A:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18F95A, $F2

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7A4C:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $07, $02, $0A
    db $06, $02, $24, $0F, $09, $02, $2E, $0A, $02, $4E, $0F, $05, $02, $54, $0C, $02
    db $76, $0F, $03, $02, $7A, $0F, $13, $02, $52, $0F, $15, $02, $2C, $0F, $15, $02
    db $2C, $0A, $02, $02, $0E, $02, $22, $1F, $01, $02, $00, $0F, $0B

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7A89:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18FA89, $55

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7ADE:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $4D, $02, $10
    db $08, $02, $1E, $06, $02, $76, $0F, $03, $02, $80, $0F, $0D, $02, $AC, $0F, $27
    db $02, $14, $0F, $4D, $02, $F6, $0A

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7B05:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18FB05, $4A

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7B4F:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $03, $02, $0A
    db $06, $02, $20, $0F, $4D, $02, $8E, $0F, $0B, $02, $3C, $0F, $4D, $02, $C2, $0F
    db $03, $02, $06, $0A, $02, $22, $1F, $01, $02, $00, $0F, $0B

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7B7B:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18FB7B, $57

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7BD2:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $05, $02, $0A
    db $06, $02, $22, $0F, $09, $02, $20, $0E, $02, $50, $0F, $09, $02, $04, $08, $02
    db $78, $0F, $01, $02, $0E, $0E, $02, $78, $0A, $02, $AC, $0F, $05, $02, $5A, $08
    db $02, $FE, $FF, $01, $02, $E4, $0F, $15, $02, $12, $0F, $07, $02, $12, $1F, $1B

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7C12:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18FC12, $4E

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_063_7C60:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18FC60, $64
    ds $33C, $00
