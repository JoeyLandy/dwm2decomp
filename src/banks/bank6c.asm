SECTION "Bank 6C", ROMX[$4000], BANK[$6C]
    db $6C

; compressed tileset of special map record 16 (SpecialMapRecords)
; LZSS-compressed asset: 648 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap10Tileset:: ; heuristic: special map tileset stream; C0
Data_06C_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B0001, $288

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap10Palettes::
Data_06C_4289:: ; address name
    dw $100E, $7FFF, $718C, $0000 ; entry 0
    dw $012F, $3F7F, $01DA, $0000 ; entry 1
    dw $01C0, $7FFF, $03E2, $0000 ; entry 2
    dw $01C0, $3F7F, $03E2, $0000 ; entry 3
    dw $218C, $3F7F, $03E2, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap10Screens::
Data_06C_42C9:: ; address name
    dfar SpecialMap10Screens_Y0X0 ; entry 0
    dfar SpecialMap10Screens_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap10Attrs::
Data_06C_42CF:: ; address name
    dfar SpecialMap10Attrs_Y0X0 ; entry 0
    dfar SpecialMap10Attrs_Y0X1 ; entry 1

; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap10Screens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_42D5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B02D5, $E5

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap10Screens_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_43BA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B03BA, $EC

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap10Attrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_44A6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B04A6, $51

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap10Attrs_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_44F7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B04F7, $45

; compressed tileset of special map record 17 (SpecialMapRecords)
; LZSS-compressed asset: 689 bytes expand to 1216 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap11Tileset:: ; heuristic: special map tileset stream; C0
Data_06C_453C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B053C, $2B1

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap11Palettes::
Data_06C_47ED:: ; address name
    dw $00AF, $7FFF, $4208, $0000 ; entry 0
    dw $00AF, $67FF, $01DA, $0000 ; entry 1
    dw $0191, $3F7F, $029A, $0000 ; entry 2
    dw $01C0, $3F7F, $01D3, $0000 ; entry 3
    dw $092E, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap11Screens::
Data_06C_482D:: ; address name
    dfar SpecialMap11Screens_Y0X0 ; entry 0
    dfar SpecialMap11Screens_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap11Attrs::
Data_06C_4833:: ; address name
    dfar SpecialMap11Attrs_Y0X0 ; entry 0
    dfar SpecialMap11Attrs_Y0X1 ; entry 1

; LZSS-compressed asset: 259 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap11Screens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_4839:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B0839, $103

; LZSS-compressed asset: 238 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap11Screens_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_493C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B093C, $EE

; LZSS-compressed asset: 104 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap11Attrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_4A2A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B0A2A, $68

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap11Attrs_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_4A92:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B0A92, $64

; compressed tileset of special map record 18 (SpecialMapRecords)
; LZSS-compressed asset: 886 bytes expand to 1248 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap12Tileset:: ; heuristic: special map tileset stream; C0
Data_06C_4AF6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B0AF6, $376

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap12Palettes::
Data_06C_4E6C:: ; address name
    dw $2D6B, $7FFF, $4A52, $0000 ; entry 0
    dw $50AA, $1F1F, $013F, $0000 ; entry 1
    dw $3D6B, $3F7F, $5E8E, $0000 ; entry 2
    dw $01C0, $3F7F, $03E2, $0000 ; entry 3
    dw $012F, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap12Screens::
Data_06C_4EAC:: ; address name
    dfar SpecialMap12Screens_Y0X0 ; entry 0
    dfar SpecialMap12Screens_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap12Attrs::
Data_06C_4EB2:: ; address name
    dfar SpecialMap12Attrs_Y0X0 ; entry 0
    dfar SpecialMap12Attrs_Y0X1 ; entry 1

; LZSS-compressed asset: 270 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap12Screens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_4EB8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B0EB8, $10E

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap12Screens_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_4FC6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B0FC6, $F3

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap12Attrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_50B9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B10B9, $7B

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap12Attrs_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_5134:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B1134, $60

; compressed tileset of special map record 19 (SpecialMapRecords)
; LZSS-compressed asset: 749 bytes expand to 1216 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap13Tileset:: ; heuristic: special map tileset stream; C0
Data_06C_5194:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B1194, $2ED

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap13Palettes::
Data_06C_5481:: ; address name
    dw $218C, $7FFF, $7EB1, $0000 ; entry 0
    dw $012F, $7FFF, $01DA, $0000 ; entry 1
    dw $012F, $3F3F, $0239, $0000 ; entry 2
    dw $1586, $7FFF, $02C0, $0000 ; entry 3
    dw $1094, $429E, $21B8, $0044 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap13Screens::
Data_06C_54C1:: ; address name
    dfar SpecialMap13Screens_Y0X0 ; entry 0
    dfar SpecialMap13Screens_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap13Attrs::
Data_06C_54C7:: ; address name
    dfar SpecialMap13Attrs_Y0X0 ; entry 0
    dfar SpecialMap13Attrs_Y0X1 ; entry 1

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap13Screens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_54CD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B14CD, $E6

; LZSS-compressed asset: 238 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap13Screens_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_55B3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B15B3, $EE

; LZSS-compressed asset: 124 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap13Attrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_56A1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B16A1, $7C

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap13Attrs_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_571D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B171D, $78

; compressed tileset of special map record 20 (SpecialMapRecords)
; LZSS-compressed asset: 750 bytes expand to 1216 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap14Tileset:: ; heuristic: special map tileset stream; C0
Data_06C_5795:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B1795, $2EE

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap14Palettes::
Data_06C_5A83:: ; address name
    dw $49AE, $7FFF, $4ACD, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $1586, $3F7F, $029A, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap14Screens::
Data_06C_5AC3:: ; address name
    dfar SpecialMap14Screens_Y0X0 ; entry 0
    dfar SpecialMap14Screens_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap14Attrs::
Data_06C_5AC9:: ; address name
    dfar SpecialMap14Attrs_Y0X0 ; entry 0
    dfar SpecialMap14Attrs_Y0X1 ; entry 1

; LZSS-compressed asset: 280 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap14Screens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_5ACF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B1ACF, $118

; LZSS-compressed asset: 264 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap14Screens_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_5BE7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B1BE7, $108

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap14Attrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_5CEF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B1CEF, $43

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap14Attrs_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_5D32:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B1D32, $41

; compressed tileset of special map record 21 (SpecialMapRecords)
; LZSS-compressed asset: 828 bytes expand to 1232 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap15Tileset:: ; heuristic: special map tileset stream; C0
Data_06C_5D73:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B1D73, $33C

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap15Palettes::
Data_06C_60AF:: ; address name
    dw $100E, $7FFF, $718C, $0000 ; entry 0
    dw $18EB, $67FF, $01DA, $0000 ; entry 1
    dw $28E8, $4F18, $0DD5, $0000 ; entry 2
    dw $3C6B, $3A52, $2510, $0000 ; entry 3
    dw $012F, $03E2, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap15Screens::
Data_06C_60EF:: ; address name
    dfar SpecialMap15Screens_Y0X0 ; entry 0
    dfar SpecialMap15Screens_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap15Attrs::
Data_06C_60F5:: ; address name
    dfar SpecialMap15Attrs_Y0X0 ; entry 0
    dfar SpecialMap15Attrs_Y0X1 ; entry 1

; LZSS-compressed asset: 292 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap15Screens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_60FB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B20FB, $124

; LZSS-compressed asset: 291 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap15Screens_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_621F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B221F, $123

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap15Attrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_6342:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B2342, $4F

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap15Attrs_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_6391:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B2391, $53

; compressed tileset of special map record 22 (SpecialMapRecords)
; LZSS-compressed asset: 885 bytes expand to 1504 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap16Tileset:: ; heuristic: special map tileset stream; C0
Data_06C_63E4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B23E4, $375

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap16Palettes::
Data_06C_6759:: ; address name
    dw $212A, $7FFF, $31CF, $0000 ; entry 0
    dw $0111, $3F7F, $0175, $0009 ; entry 1
    dw $01A0, $3F7F, $03E7, $00A0 ; entry 2
    dw $49AE, $7FFF, $4ACD, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $2111, $3A5C, $21B8, $0044 ; entry 5
    dw $00F0, $7FFF, $09F5, $0009 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap16Screens::
Data_06C_6799:: ; address name
    dfar SpecialMap16Screens_Y0X0 ; entry 0
    dfar SpecialMap16Screens_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap16Attrs::
Data_06C_679F:: ; address name
    dfar SpecialMap16Attrs_Y0X0 ; entry 0
    dfar SpecialMap16Attrs_Y0X1 ; entry 1

; LZSS-compressed asset: 261 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap16Screens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_67A5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B27A5, $105

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap16Screens_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_68AA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B28AA, $E8

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap16Attrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_6992:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B2992, $50

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap16Attrs_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_69E2:: ; address name
    db $68, $01, $04, $02, $04, $00, $0F, $06, $06, $06, $06, $06, $04, $0A, $0F, $1F
    db $06, $06, $00, $00, $04, $1A, $00, $04, $44, $0F, $0F, $04, $78, $04, $04, $6E
    db $0F, $15, $01, $04, $AA, $03, $04, $9E, $0F, $37, $03, $03, $03, $03, $04, $EC
    db $0F, $05, $04, $16, $06, $04, $AA, $06, $04, $18, $1F, $05, $04, $3E, $1F, $11

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap17Screens::
Data_06C_6A22:: ; address name
    dfar SpecialMap17Screens_Y0X0 ; entry 0
    dfar SpecialMap17Screens_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap17Attrs::
Data_06C_6A28:: ; address name
    dfar SpecialMap17Attrs_Y0X0 ; entry 0
    dfar SpecialMap17Attrs_Y0X1 ; entry 1

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap17Screens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_6A2E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B2A2E, $F9

; LZSS-compressed asset: 301 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap17Screens_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_6B27:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B2B27, $12D

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap17Attrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_6C54:: ; address name
    db $68, $01, $00, $03, $00, $00, $0F, $42, $02, $00, $56, $05, $00, $4C, $0F, $0D
    db $04, $04, $02, $02, $05, $05, $00, $7E, $00, $00, $76, $0F, $07, $00, $80, $00
    db $00, $56, $04, $04, $04, $00, $88, $02, $00, $A4, $0F, $2B, $00, $F4, $0A, $00
    db $F0, $0F, $05, $00, $F2, $0C, $00, $18, $1F, $07, $00, $00, $0F, $0F

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap17Attrs_Y0X1:: ; heuristic: map screen stream; C0
Data_06C_6C92:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B2C92, $4A

; compressed tileset of special map record 26 (SpecialMapRecords)
; LZSS-compressed asset: 1306 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1ATileset:: ; heuristic: special map tileset stream; C0
Data_06C_6CDC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B2CDC, $51A

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap1APalettes::
Data_06C_71F6:: ; address name
    dw $00D9, $7FFF, $025F, $0063 ; entry 0
    dw $30E9, $5F17, $49CD, $0044 ; entry 1
    dw $39C9, $5F17, $4A8D, $0000 ; entry 2
    dw $10CC, $52DA, $1D94, $0000 ; entry 3
    dw $194A, $6BDF, $15EF, $0084 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $194A, $5F17, $2E0E, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1AScreens::
Data_06C_7236:: ; address name
    dfar SpecialMap1AScreens_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1AAttrs::
Data_06C_7239:: ; address name
    dfar SpecialMap1AAttrs_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1BScreens::
Data_06C_723C:: ; address name
    dfar SpecialMap1BScreens_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1BAttrs::
Data_06C_723F:: ; address name
    dfar SpecialMap1BAttrs_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1CScreens::
Data_06C_7242:: ; address name
    dfar SpecialMap1CScreens_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1CAttrs::
Data_06C_7245:: ; address name
    dfar SpecialMap1CAttrs_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1DScreens::
Data_06C_7248:: ; address name
    dfar SpecialMap1DScreens_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1DAttrs::
Data_06C_724B:: ; address name
    dfar SpecialMap1DAttrs_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1EScreens::
Data_06C_724E:: ; address name
    dfar SpecialMap1EScreens_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1EAttrs::
Data_06C_7251:: ; address name
    dfar SpecialMap1EAttrs_Y0X0 ; entry 0

; LZSS-compressed asset: 272 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1AScreens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_7254:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B3254, $110

; LZSS-compressed asset: 104 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1AAttrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_7364:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B3364, $68

; LZSS-compressed asset: 278 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1BScreens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_73CC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B33CC, $116

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1BAttrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_74E2:: ; address name
    db $68, $01, $00, $03, $00, $00, $0F, $06, $06, $06, $00, $16, $06, $00, $16, $02
    db $00, $2A, $0A, $00, $26, $0F, $1F, $00, $62, $0E, $00, $22, $08, $00, $76, $0F
    db $07, $00, $0E, $0F, $09, $00, $16, $08, $00, $7C, $0F, $15, $00, $EA, $0F, $13
    db $00, $28, $0A, $00, $22, $0F, $01, $00, $00, $0F, $07, $00, $00, $0E

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1CScreens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_7520:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B3520, $E0

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1CAttrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_7600:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B3600, $57

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1DScreens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_7657:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B3657, $F7

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1DAttrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_774E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B374E, $46

; LZSS-compressed asset: 286 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1EScreens_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_7794:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B3794, $11E

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1EAttrs_Y0X0:: ; heuristic: map screen stream; C0
Data_06C_78B2:: ; address name
    db $68, $01, $00, $04, $00, $00, $0F, $42, $06, $00, $56, $03, $00, $4A, $0F, $0D
    db $00, $54, $02, $00, $46, $0F, $01, $00, $4C, $09, $00, $7D, $06, $00, $5B, $05
    db $00, $A4, $08, $00, $4E, $05, $00, $B9, $0F, $18, $00, $ED, $0A, $00, $95, $0F
    db $00, $00, $B5, $0F, $05, $06, $00, $7E, $04, $00, $96, $0B, $00, $59, $0F, $0C

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_78F2:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B38F2, $B0

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_79A2:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B39A2, $46

; LZSS-compressed asset: 157 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_79E8:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B39E8, $9D

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7A85:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $40, $01, $00, $54, $07, $00, $4C, $0F, $05
    db $00, $5A, $0F, $0B, $00, $50, $0E, $01, $01, $03, $03, $00, $98, $0F, $11, $03
    db $03, $00, $A4, $02, $00, $C4, $0F, $05, $00, $52, $02, $00, $4C, $08, $00, $FA
    db $08, $00, $FA, $0C, $00, $68, $0F, $03, $00, $20, $1F, $21

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7AC1:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3AC1, $B0

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7B71:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3B71, $42

; LZSS-compressed asset: 172 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7BB3:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3BB3, $AC

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7C5F:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3C5F, $43

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7CA2:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3CA2, $99

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7D3B:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $40, $01, $00, $54, $07, $00, $4C, $0F, $07
    db $00, $5C, $0E, $00, $78, $0F, $09, $01, $01, $03, $03, $00, $98, $0F, $11, $03
    db $03, $00, $8A, $04, $00, $C6, $0F, $0B, $00, $74, $0A, $00, $F2, $0F, $05, $00
    db $54, $0C, $00, $1A, $1F, $27

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7D71:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3D71, $94

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7E05:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $0F, $40, $01, $00, $54, $07, $00, $4C, $0F, $05
    db $00, $5A, $0E, $00, $76, $0F, $0B, $01, $01, $03, $03, $00, $98, $0F, $11, $03
    db $03, $00, $88, $04, $00, $C6, $0F, $03, $00, $E8, $06, $00, $EE, $08, $00, $F2
    db $0F, $05, $00, $68, $0F, $03, $00, $20, $1F, $21

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7E3F:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B3E3F, $A5

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06C_7EE4:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $2D, $00, $08, $00, $00, $54, $04, $00, $4C, $0F, $07, $00, $5C, $0C, $00
    db $76, $0F, $0B, $01, $01, $03, $03, $00, $98, $0F, $11, $03, $03, $00, $A4, $02
    db $00, $C4, $0F, $0D, $00, $80, $0F, $13, $00, $54, $0C, $00, $1A, $1F, $27
    ds $DD, $00
