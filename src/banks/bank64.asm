SECTION "Bank 64", ROMX[$4000], BANK[$64]
    db $64

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 2: entry 2 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1227 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles2:: ; heuristic: key-world tileset stream; C0
Data_064_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $190001, $4CB

Data_064_44CC:: ; heuristic: key-world screen header; C0
    db $01, $02, $04, $09, $0D, $33, $23, $00

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_44D4:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1904D4, $7B

Data_064_454F:: ; heuristic: key-world screen header; C0
    db $00, $02, $04, $09, $0D, $33, $24, $00

; LZSS-compressed asset: 183 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4557:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $190557, $B7

Data_064_460E:: ; heuristic: key-world screen header; C0
    db $03, $02, $04, $09, $0D, $33, $25, $00

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4616:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $190616, $91

Data_064_46A7:: ; heuristic: key-world screen header; C0
    db $FF, $02, $04, $05, $0D, $33, $26, $00

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_46AF:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1906AF, $85

Data_064_4734:: ; heuristic: key-world screen header; C0
    db $05, $02, $04, $09, $0D, $33, $27, $00

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_473C:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19073C, $81

Data_064_47BD:: ; heuristic: key-world screen header; C0
    db $05, $02, $04, $09, $0D, $33, $28, $00

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_47C5:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1907C5, $7E

Data_064_4843:: ; heuristic: key-world screen header; C0
    db $FF, $02, $04, $06, $0D, $33, $29, $00

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_484B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19084B, $8F

Data_064_48DA:: ; heuristic: key-world screen header; C0
    db $FF, $02, $04, $09, $0D, $33, $2A, $00

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_48E2:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1908E2, $7E

Data_064_4960:: ; heuristic: key-world screen header; C0
    db $00, $02, $09, $0B, $0C, $33, $2B, $00

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4968:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $190968, $C4

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4A2C:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $0B, $00
    db $08, $06, $00, $28, $0F, $0D, $00, $08, $04, $00, $50, $0F, $0F, $00, $08, $02
    db $00, $78, $0F, $11, $00, $AF, $0F, $4D, $00, $08, $1F, $45

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4A58:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $190A58, $51

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4AA9:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $07, $02
    db $02, $00, $1C, $0F, $11, $02, $02, $00, $42, $0F, $11, $00, $54, $02, $00, $04
    db $08, $00, $78, $0F, $03, $00, $A1, $0F, $4D, $00, $01, $1F, $4D, $00, $00, $02

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4AD9:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $190AD9, $45

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4B1E:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $0B, $00
    db $04, $06, $00, $28, $0F, $11, $00, $08, $00, $00, $50, $0F, $3B, $00, $B1, $0F
    db $4D, $00, $08, $1F, $43

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4B43:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $190B43, $45

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4B88:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $09, $00
    db $0A, $06, $00, $26, $0F, $09, $00, $30, $08, $00, $4E, $0F, $0F, $00, $7C, $06
    db $00, $7A, $0F, $09, $00, $A2, $08, $00, $A2, $0F, $05, $00, $B2, $0C, $00, $CA
    db $0F, $0D, $00, $FD, $0F, $4D, $00, $00, $06

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4BC1:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $190BC1, $46

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_4C07:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $190C07, $5A

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

Data_064_5128:: ; heuristic: key-world screen header; C0
    db $05, $03, $05, $08, $0A, $33, $47, $00

; LZSS-compressed asset: 117 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5130:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $191130, $75

Data_064_51A5:: ; heuristic: key-world screen header; C0
    db $FF, $08, $09, $0A, $0D, $33, $48, $00

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_51AD:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1911AD, $6B

Data_064_5218:: ; heuristic: key-world screen header; C0
    db $FF, $0B, $0D, $0E, $0F, $33, $49, $00

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5220:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $191220, $64

Data_064_5284:: ; heuristic: key-world screen header; C0
    db $FF, $0B, $0C, $0D, $0F, $33, $4A, $00

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_528C:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19128C, $84

Data_064_5310:: ; heuristic: key-world screen header; C0
    db $06, $03, $07, $08, $0A, $33, $4B, $00

; LZSS-compressed asset: 124 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5318:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $191318, $7C

Data_064_5394:: ; heuristic: key-world screen header; C0
    db $07, $03, $05, $0B, $0D, $33, $4C, $00

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_539C:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19139C, $B1

Data_064_544D:: ; heuristic: key-world screen header; C0
    db $04, $03, $04, $05, $0B, $33, $4D, $00

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5455:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $191455, $95

Data_064_54EA:: ; heuristic: key-world screen header; C0
    db $05, $00, $03, $07, $08, $33, $4E, $00

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_54F2:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1914F2, $161

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5653:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $4D, $00
    db $10, $06, $00, $1E, $06, $00, $74, $0F, $09, $00, $7E, $0A, $00, $9E, $0F, $07
    db $00, $7C, $0F, $15, $00, $18, $0F, $4D, $00, $04, $1F, $01

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_567F:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $0F, $02
    db $02, $00, $24, $0F, $11, $02, $00, $5C, $01, $00, $4E, $0F, $4D, $00, $72, $0F
    db $03, $00, $4C, $0F, $01, $00, $24, $0F, $25, $00, $0C, $0F, $17, $00, $0E, $0F
    db $07

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_56B0:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $0B, $00
    db $08, $06, $00, $28, $0F, $0D, $00, $08, $04, $00, $50, $0F, $0F, $00, $08, $02
    db $00, $78, $0F, $4D, $00, $4C, $0F, $25, $00, $20, $0F, $13, $00, $0A, $0F, $0B

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_56E0:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $0B, $03
    db $03, $02, $02, $02, $02, $00, $24, $0F, $11, $00, $32, $00, $00, $4C, $0F, $15
    db $00, $36, $00, $00, $78, $0F, $4D, $00, $9C, $0C, $00, $34, $0F, $13, $00, $34
    db $04, $00, $16, $1F, $0D, $00, $0A, $0F, $0B

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5719:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $05, $00
    db $0A, $06, $00, $22, $0F, $09, $00, $2C, $0C, $00, $4E, $0F, $4D, $00, $AE, $0F
    db $45, $00, $2A, $0F, $15, $00, $02, $0F, $13

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5742:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $191742, $52

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5794:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $31, $00
    db $0A, $06, $00, $4E, $0F, $07, $00, $58, $08, $00, $74, $0F, $07, $00, $7C, $0C
    db $00, $9E, $0F, $09, $00, $04, $0A, $00, $C8, $0F, $2B, $00, $08, $00, $00, $06
    db $0E, $00, $1C, $1F, $01, $00, $04, $0F, $11

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_57CD:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1917CD, $97

Data_064_5864:: ; heuristic: key-world screen header; C0
    db $02, $02, $05, $06, $0B, $33, $6B, $00

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_586C:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19186C, $7A

Data_064_58E6:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $33, $6C, $00

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_58EE:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1918EE, $61

Data_064_594F:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $33, $6D, $00

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5957:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $191957, $63

Data_064_59BA:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $33, $6E, $00

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_59C2:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1919C2, $72

Data_064_5A34:: ; heuristic: key-world screen header; C0
    db $05, $00, $06, $07, $0B, $33, $6F, $00

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5A3C:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $191A3C, $98

Data_064_5AD4:: ; heuristic: key-world screen header; C0
    db $04, $03, $06, $07, $08, $33, $70, $00

; LZSS-compressed asset: 183 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5ADC:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $191ADC, $B7

Data_064_5B93:: ; heuristic: key-world screen header; C0
    db $FF, $00, $09, $0A, $0C, $33, $71, $00

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5B9B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $191B9B, $96

Data_064_5C31:: ; heuristic: key-world screen header; C0
    db $FF, $00, $05, $07, $08, $33, $72, $00

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5C39:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $191C39, $16A

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5DA3:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $40, $0F, $2C, $03, $00, $A0, $01
    db $00, $98, $0A, $00, $A0, $0F, $2F, $00, $A4, $02, $00, $EA, $0A, $00, $F6, $0F
    db $03, $00, $10, $1F, $35

; LZSS-compressed asset: 38 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5DC8:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $20, $02, $02, $00, $22, $0F, $11, $00, $34
    db $0F, $11, $02, $00, $7E, $01, $00, $70, $0F, $09, $03, $00, $A0, $0F, $4D, $00
    db $00, $1F, $4D, $00, $08, $13

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5DEE:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $03, $00, $56, $03, $00, $4A, $0F, $0B
    db $00, $56, $04, $00, $5A, $08, $00, $7C, $0C, $00, $7C, $08, $00, $AB, $0F, $4D
    db $00, $08, $1F, $49

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5E12:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $20, $02, $02, $02, $02, $00, $24, $0F, $09
    db $00, $34, $00, $03, $03, $03, $03, $00, $34, $00, $00, $36, $04, $00, $54, $0E
    db $00, $54, $04, $00, $58, $04, $00, $76, $0F, $03, $00, $7E, $04, $00, $A7, $0F
    db $4D, $00, $07, $1F, $4D

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5E47:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $191E47, $47

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5E8E:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $191E8E, $47

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5ED5:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $1E, $0F, $0A, $03, $03, $03, $03
    db $00, $6E, $0F, $0B, $00, $80, $02, $00, $7E, $08, $00, $7E, $04, $00, $A6, $0E
    db $00, $7E, $00, $00, $80, $04, $00, $CC, $04, $00, $CC, $0E, $00, $EC, $04, $00
    db $E6, $0F, $15, $00, $14, $1F, $33

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_5F0C:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $191F0C, $110

Data_064_601C:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $33, $90, $00

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6024:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $192024, $4F

Data_064_6073:: ; heuristic: key-world screen header; C0
    db $FF, $06, $07, $0C, $0F, $33, $91, $00

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_607B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19207B, $5D

Data_064_60D8:: ; heuristic: key-world screen header; C0
    db $FF, $09, $0A, $0D, $0F, $33, $92, $00

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_60E0:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1920E0, $65

Data_064_6145:: ; heuristic: key-world screen header; C0
    db $05, $02, $05, $06, $0C, $33, $93, $00

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_614D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19214D, $78

Data_064_61C5:: ; heuristic: key-world screen header; C0
    db $07, $00, $08, $09, $07, $33, $94, $00

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_61CD:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1921CD, $A5

Data_064_6272:: ; heuristic: key-world screen header; C0
    db $FF, $00, $03, $04, $0A, $33, $95, $00

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_627A:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19227A, $97

Data_064_6311:: ; heuristic: key-world screen header; C0
    db $FF, $00, $03, $07, $09, $33, $96, $00

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6319:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $192319, $165

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_647E:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $50, $0F, $3C, $01, $01, $01, $01
    db $00, $A0, $0F, $0F, $00, $B0, $00, $00, $C6, $0F, $0F, $00, $D6, $02, $00, $EE
    db $0F, $0D, $00, $FC, $04, $00, $16, $1F, $2B

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_64A7:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $28, $0F, $14, $01, $01, $00, $76
    db $0F, $0F, $01, $00, $AC, $03, $00, $A0, $0F, $09, $00, $AC, $04, $00, $C4, $0F
    db $0B, $00, $D0, $08, $00, $EE, $0F, $09, $00, $CE, $0F, $15, $00, $CC, $0A, $00
    db $40, $1F, $01

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_64DA:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $22, $0F, $0E, $02, $02, $02, $02
    db $00, $72, $0F, $15, $02, $02, $01, $01, $01, $01, $00, $A0, $0F, $0D, $00, $B0
    db $00, $00, $C4, $0F, $4D, $00, $E8, $0E, $00, $E8, $04, $00, $3E, $1F, $03

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6509:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $18, $01, $00, $2C, $03, $00, $20, $0F, $15
    db $00, $30, $08, $00, $54, $0F, $29, $00, $52, $0A, $00, $32, $04, $00, $A6, $0F
    db $01, $00, $52, $0F, $4B, $00, $18, $1F, $29

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6532:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $192532, $4C

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_657E:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $16, $01, $01, $00, $18, $0F, $15, $00, $2A
    db $06, $00, $2A, $04, $00, $52, $0F, $0B, $00, $7A, $0F, $0F, $00, $2A, $02, $00
    db $A2, $02, $00, $2A, $00, $00, $A2, $0F, $07, $00, $CA, $08, $00, $C8, $0F, $2B
    db $00, $A8, $08, $00, $12, $1F, $0D, $00, $1A, $1A, $00, $40, $1F, $01

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_65BC:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1925BC, $9D

Data_064_6659:: ; heuristic: key-world screen header; C0
    db $03, $04, $05, $0C, $0E, $03, $B3, $00

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6661:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $192661, $95

Data_064_66F6:: ; heuristic: key-world screen header; C0
    db $04, $04, $05, $0C, $0E, $03, $B4, $00

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_66FE:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1926FE, $99

Data_064_6797:: ; heuristic: key-world screen header; C0
    db $06, $00, $04, $05, $0E, $2E, $B5, $00

; LZSS-compressed asset: 137 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_679F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19279F, $89

Data_064_6828:: ; heuristic: key-world screen header; C0
    db $00, $04, $05, $0C, $0E, $2E, $B6, $00

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6830:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $192830, $B4

Data_064_68E4:: ; heuristic: key-world screen header; C0
    db $05, $04, $05, $0C, $0E, $03, $B7, $00

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_68EC:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1928EC, $92

Data_064_697E:: ; heuristic: key-world screen header; C0
    db $06, $04, $05, $0C, $0E, $03, $B8, $00

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6986:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $192986, $BD

Data_064_6A43:: ; heuristic: key-world screen header; C0
    db $01, $04, $05, $0D, $0E, $03, $B9, $00

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6A4B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $192A4B, $A1

Data_064_6AEC:: ; heuristic: key-world screen header; C0
    db $00, $04, $05, $07, $0E, $03, $BA, $00

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6AF4:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $192AF4, $C1

Data_064_6BB5:: ; heuristic: key-world screen header; C0
    db $01, $04, $06, $08, $0B, $03, $BB, $00

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6BBD:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $192BBD, $D8

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6C95:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $4D, $02, $52, $0F, $3E, $02, $FE, $FF, $01
    db $02, $FE, $FE, $02, $FC, $FF, $01, $02, $FC, $FE, $02, $FA, $FF, $01, $02, $FA
    db $FE, $02, $F8, $FF, $01, $02, $F8, $FE, $02, $F6, $FF, $01, $02, $A0, $F6

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6CC4:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $192CC4, $45

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6D09:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $4D, $02, $4C, $0F, $38, $02, $F8, $FF, $01
    db $02, $F8, $FE, $02, $F6, $FF, $01, $02, $D2, $0F, $4D, $02, $F6, $0F, $0F

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6D28:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $0F, $1E, $02, $03, $32, $01, $03, $24, $0F, $0B
    db $03, $32, $02, $03, $36, $0A, $03, $56, $0E, $03, $32, $0F, $11, $03, $30, $0C
    db $03, $FC, $F2, $03, $A2, $0F, $05, $03, $AA, $06, $03, $C4, $0F, $09, $03, $A8
    db $08, $03, $EC, $0F, $07, $03, $F4, $0C, $03, $16, $1F, $2B

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6D64:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $4D, $02, $52, $0F, $3E, $02, $FE, $FF, $01
    db $02, $B2, $0F, $4D, $02, $C4, $00, $02, $16, $1F, $0D, $02, $F6, $FF, $01, $02
    db $A0, $F6

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6D86:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $192D86, $42

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6DC8:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $48, $02, $FC, $FF, $01, $02, $5C, $0F, $05
    db $02, $FE, $FC, $02, $84, $0F, $07, $02, $FE, $FA, $02, $F8, $FF, $03, $02, $84
    db $0F, $15, $02, $58, $02, $02, $F0, $0F, $0B, $02, $FC, $F4, $02, $16, $1F, $11
    db $02, $FA, $FC, $02, $A0, $F6

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6DFE:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $0F, $1C, $02, $02, $02, $02, $03, $20, $0F, $0F
    db $03, $30, $00, $03, $FA, $FC, $03, $56, $0F, $0B, $03, $FE, $F6, $03, $7E, $0E
    db $03, $30, $00, $03, $7E, $0C, $03, $A4, $0E, $03, $7E, $08, $03, $C2, $0F, $35
    db $03, $32, $00, $03, $0E, $1F, $0D, $03, $00, $04, $03, $36, $1F, $0B

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6E3C:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $192E3C, $E7

Data_064_6F23:: ; heuristic: key-world screen header; C0
    db $06, $02, $07, $09, $0F, $07, $D8, $00

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6F2B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $192F2B, $A4

Data_064_6FCF:: ; heuristic: key-world screen header; C0
    db $07, $02, $06, $09, $0D, $07, $D9, $00

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_6FD7:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $192FD7, $98

Data_064_706F:: ; heuristic: key-world screen header; C0
    db $02, $02, $03, $06, $0D, $07, $DA, $00

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7077:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $193077, $C2

Data_064_7139:: ; heuristic: key-world screen header; C0
    db $03, $01, $04, $09, $0A, $07, $DB, $00

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7141:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $193141, $CD

Data_064_720E:: ; heuristic: key-world screen header; C0
    db $07, $04, $07, $09, $0B, $07, $DC, $00

; LZSS-compressed asset: 202 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7216:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $193216, $CA

Data_064_72E0:: ; heuristic: key-world screen header; C0
    db $FF, $02, $03, $07, $0B, $07, $DD, $00

; LZSS-compressed asset: 207 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_72E8:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1932E8, $CF

Data_064_73B7:: ; heuristic: key-world screen header; C0
    db $FF, $00, $08, $07, $0F, $07, $DE, $00

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_73BF:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1933BF, $CD

Data_064_748C:: ; heuristic: key-world screen header; C0
    db $07, $05, $0A, $0B, $0D, $07, $DF, $00

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7494:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $193494, $115

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_75A9:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1935A9, $49

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_75F2:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $4D, $02, $1A, $0F, $05, $02
    db $1C, $06, $02, $78, $0F, $01, $02, $72, $0E, $02, $1C, $04, $02, $A6, $0F, $01
    db $02, $76, $0F, $19, $02, $E6, $0F, $4D, $02, $0A, $1A

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_761D:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $19361D, $44

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7661:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $193661, $42

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_76A3:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1936A3, $54

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_76F7:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $15, $02, $08, $06, $02, $28
    db $0F, $0D, $02, $04, $04, $02, $50, $0F, $29, $02, $FE, $F2, $02, $FA, $FA, $02
    db $A0, $0F, $05, $02, $F4, $FC, $02, $C8, $0F, $03, $02, $F2, $FE, $02, $F0, $0F
    db $09, $02, $28, $0F, $15, $02, $FE, $FF, $0D

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7730:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $193730, $48

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7778:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $193778, $54

Data_064_77CC:: ; heuristic: key-world screen header; C0
    db $06, $06, $08, $09, $0B, $3C, $FB, $00

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_77D4:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1937D4, $74

Data_064_7848:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $0B, $FC, $00

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7850:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $193850, $61

Data_064_78B1:: ; heuristic: key-world screen header; C0
    db $FF, $08, $09, $0A, $0B, $25, $FD, $00

; LZSS-compressed asset: 140 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_78B9:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1938B9, $8C

Data_064_7945:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $25, $FE, $00

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_794D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19394D, $82

Data_064_79CF:: ; heuristic: key-world screen header; C0
    db $04, $05, $06, $0B, $0C, $3C, $FF, $00

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_79D7:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1939D7, $A6

Data_064_7A7D:: ; heuristic: key-world screen header; C0
    db $01, $04, $06, $07, $09, $3C, $00, $01

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7A85:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $193A85, $D1

Data_064_7B56:: ; heuristic: key-world screen header; C0
    db $04, $03, $05, $0A, $0B, $3C, $01, $01

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7B5E:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $193B5E, $B6

Data_064_7C14:: ; heuristic: key-world screen header; C0
    db $06, $04, $06, $0D, $0E, $3C, $02, $01

; LZSS-compressed asset: 185 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7C1C:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $193C1C, $B9

Data_064_7CD5:: ; heuristic: key-world screen header; C0
    db $06, $00, $03, $07, $08, $3C, $03, $01

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7CDD:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $193CDD, $F7

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7DD4:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $4D, $02, $10
    db $06, $02, $1E, $06, $02, $74, $0F, $13, $02, $FE, $FF, $01, $02, $AE, $0F, $21
    db $02, $F5, $0F, $4D, $02, $55, $1E

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7DFB:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $03, $FF, $F6, $01, $03, $0A, $05, $03, $00, $0F, $33, $00, $00
    db $02, $02, $02, $02, $03, $4C, $0F, $11, $03, $5A, $00, $03, $74, $0F, $13, $03
    db $AD, $0F, $4D, $03, $0D, $1F, $47

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7E22:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $09, $02, $0A
    db $06, $02, $26, $0F, $33, $02, $08, $0F, $15, $02, $06, $04, $02, $FA, $FF, $01
    db $02, $FA, $FE, $02, $F8, $FF, $01, $02, $A0, $FF, $4D, $02, $49, $1F, $0B

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7E51:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $03, $FF, $F6, $01, $03, $0A, $05, $03, $00, $0F, $0F, $02, $02
    db $03, $24, $0F, $11, $03, $36, $02, $03, $4E, $0F, $0D, $03, $5C, $04, $03, $76
    db $0F, $0F, $02, $02, $03, $FA, $FC, $03, $AA, $0F, $01, $03, $D1, $0F, $4D, $03
    db $31, $1F, $23

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7E84:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $09, $02, $0A
    db $06, $02, $26, $0F, $31, $02, $30, $08, $02, $76, $0F, $13, $02, $00, $0F, $1D
    db $02, $08, $0F, $09, $02, $FC, $FF, $01, $02, $A0, $FF, $45

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7EB0:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $193EB0, $50

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7F00:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $07, $02, $0A
    db $06, $02, $24, $0F, $09, $02, $2E, $0A, $02, $4E, $0F, $2D, $02, $2E, $0F, $13
    db $02, $08, $02, $02, $06, $06, $02, $C4, $0F, $09, $02, $00, $08, $02, $EC, $0F
    db $07, $02, $19, $1F, $3B

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7F35:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $193F35, $4F

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_064_7F84:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $193F84, $63
    ds $19, $00
