SECTION "Bank 94", ROMX[$4000], BANK[$94]
    db $94

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map19Palettes::
BGPaletteBufferData_94_4001:: ; heuristic: argument of a bank-switching copy helper; C0
Data_094_4001:: ; address name
    dw $7D86, $7FFF, $0214, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $012F, $4F3F, $001F, $0000 ; entry 5
    dw $29CE, $031D, $1415, $0000 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; compressed tileset of map $A3 (the first map record using it)
; LZSS-compressed asset: 1575 bytes expand to 1872 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA3Tileset:: ; heuristic: map tileset stream; C0
Data_094_4041:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $250041, $627

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapA3Palettes::
Data_094_4668:: ; address name
    dw $6080, $7FFF, $6301, $0000 ; entry 0
    dw $48EC, $6BFF, $4A6F, $0000 ; entry 1
    dw $384E, $53DE, $5956, $0000 ; entry 2
    dw $00EF, $6BFF, $015C, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $3320, $6BFF, $4A6F, $0084 ; entry 5
    dw $023F, $2BFF, $4A6F, $0084 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA3Screens0::
Data_094_46A8:: ; address name
    dfar MapA3Screens0_Y0X0 ; entry 0
    dfar MapA3Screens0_Y1X0 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA3Attrs0::
Data_094_46AE:: ; address name
    dfar MapA3Attrs0_Y0X0 ; entry 0
    dfar MapA3Attrs0_Y1X0 ; entry 1

; LZSS-compressed asset: 304 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA3Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_094_46B4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2506B4, $130

; LZSS-compressed asset: 310 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA3Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_094_47E4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2507E4, $136

; LZSS-compressed asset: 112 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA3Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_094_491A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $25091A, $70

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA3Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_094_498A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $25098A, $88

; compressed tileset of special map record 12 (SpecialMapRecords)
; LZSS-compressed asset: 1250 bytes expand to 1728 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0CTileset:: ; heuristic: special map tileset stream; C0
Data_094_4A12:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $250A12, $4E2

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0CPalettes::
Data_094_4EF4:: ; address name
    dw $212A, $7FFF, $31CF, $0000 ; entry 0
    dw $0111, $3F7F, $0175, $0009 ; entry 1
    dw $01A0, $3F7F, $03E7, $00A0 ; entry 2
    dw $49AE, $7FFF, $4ACD, $0000 ; entry 3
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 4
    dw $2111, $3A5C, $21B8, $0044 ; entry 5
    dw $00F0, $7FFF, $09F5, $0009 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of special map record 13 (SpecialMapRecords)
; LZSS-compressed asset: 1365 bytes expand to 1584 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0DTileset:: ; heuristic: special map tileset stream; C0
Data_094_4F34:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $250F34, $555

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0DPalettes::
Data_094_5489:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $00ED, $7FFF, $11D4, $0000 ; entry 1
    dw $00ED, $22BA, $11D4, $0000 ; entry 2
    dw $01C4, $3F7F, $0348, $0000 ; entry 3
    dw $00ED, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0DScreens::
Data_094_54C9:: ; address name
    dfar SpecialMap0DScreens_Y0X0 ; entry 0
    dfar SpecialMap0DScreens_Y0X1 ; entry 1
    dfar SpecialMap0DScreens_Y1X0 ; entry 2
    dfar SpecialMap0DScreens_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0DAttrs::
Data_094_54D5:: ; address name
    dfar SpecialMap0DAttrs_Y0X0 ; entry 0
    dfar SpecialMap0DAttrs_Y0X1 ; entry 1
    dfar SpecialMap0DAttrs_Y1X0 ; entry 2
    dfar SpecialMap0DAttrs_Y1X1 ; entry 3

; LZSS-compressed asset: 260 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0DScreens_Y0X0:: ; heuristic: map screen stream; C0
Data_094_54E1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2514E1, $104

; LZSS-compressed asset: 276 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0DScreens_Y0X1:: ; heuristic: map screen stream; C0
Data_094_55E5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2515E5, $114

; LZSS-compressed asset: 294 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0DScreens_Y1X0:: ; heuristic: map screen stream; C0
Data_094_56F9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2516F9, $126

; LZSS-compressed asset: 308 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0DScreens_Y1X1:: ; heuristic: map screen stream; C0
Data_094_581F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $25181F, $134

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0DAttrs_Y0X0:: ; heuristic: map screen stream; C0
Data_094_5953:: ; address name
    db $68, $01, $00, $03, $00, $00, $0F, $42, $02, $00, $56, $05, $00, $4C, $0F, $31
    db $04, $04, $00, $92, $0F, $1F, $04, $04, $04, $04, $00, $C8, $0F, $07, $00, $F4
    db $08, $00, $F0, $0E, $00, $EE, $0F, $05, $00, $18, $1F, $05, $00, $CE, $08, $00
    db $53, $00, $00, $40, $1E, $02, $02

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0DAttrs_Y0X1:: ; heuristic: map screen stream; C0
Data_094_598A:: ; address name
    db $68, $01, $00, $03, $00, $00, $0F, $06, $04, $04, $04, $04, $00, $0A, $0F, $29
    db $00, $56, $02, $00, $4C, $0F, $0F, $02, $00, $82, $03, $00, $76, $0F, $2B, $00
    db $56, $06, $00, $BE, $0F, $0B, $00, $52, $08, $00, $E8, $0F, $0D, $00, $54, $04
    db $00, $10, $1F, $11, $00, $00, $08, $00, $89, $02, $00, $1C, $0A

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0DAttrs_Y1X0:: ; heuristic: map screen stream; C0
Data_094_59C7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2519C7, $5B

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0DAttrs_Y1X1:: ; heuristic: map screen stream; C0
Data_094_5A22:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $251A22, $6E

; compressed tileset of special map record 14 (SpecialMapRecords)
; LZSS-compressed asset: 1183 bytes expand to 1552 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0ETileset:: ; heuristic: special map tileset stream; C0
Data_094_5A90:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $251A90, $49F

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0EPalettes::
Data_094_5F2F:: ; address name
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $05A4, $4B7B, $2A8E, $0084 ; entry 1
    dw $386C, $53DE, $4593, $0000 ; entry 2
    dw $012F, $035F, $01DA, $0000 ; entry 3
    dw $0160, $5AB1, $4A2D, $0000 ; entry 4
    dw $0152, $53DE, $025C, $0008 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0EScreens::
Data_094_5F6F:: ; address name
    dfar SpecialMap0EScreens_Y0X0 ; entry 0
    dfar SpecialMap0EScreens_Y0X1 ; entry 1
    dfar SpecialMap0EScreens_Y1X0 ; entry 2
    dfar SpecialMap0EScreens_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0EAttrs::
Data_094_5F7B:: ; address name
    dfar SpecialMap0EAttrs_Y0X0 ; entry 0
    dfar SpecialMap0EAttrs_Y0X1 ; entry 1
    dfar SpecialMap0EAttrs_Y1X0 ; entry 2
    dfar SpecialMap0EAttrs_Y1X1 ; entry 3

; LZSS-compressed asset: 225 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0EScreens_Y0X0:: ; heuristic: map screen stream; C0
Data_094_5F87:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $251F87, $E1

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0EScreens_Y0X1:: ; heuristic: map screen stream; C0
Data_094_6068:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252068, $F6

; LZSS-compressed asset: 291 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0EScreens_Y1X0:: ; heuristic: map screen stream; C0
Data_094_615E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $25215E, $123

; LZSS-compressed asset: 293 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0EScreens_Y1X1:: ; heuristic: map screen stream; C0
Data_094_6281:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252281, $125

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0EAttrs_Y0X0:: ; heuristic: map screen stream; C0
Data_094_63A6:: ; address name
    db $68, $01, $00, $04, $00, $00, $0F, $40, $01, $00, $54, $03, $00, $48, $0F, $0B
    db $00, $54, $04, $00, $58, $02, $00, $82, $06, $00, $7E, $0F, $09, $00, $80, $08
    db $00, $A6, $0F, $25, $00, $A0, $0E, $00, $F0, $0F, $13, $00, $74, $0E, $00, $5A
    db $04, $02, $00, $44, $15, $00, $3A, $1F, $07

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0EAttrs_Y0X1:: ; heuristic: map screen stream; C0
Data_094_63DF:: ; address name
    db $68, $01, $00, $04, $00, $00, $0F, $1A, $01, $00, $2E, $03, $00, $22, $0F, $0B
    db $00, $2E, $04, $00, $32, $08, $00, $54, $0C, $00, $54, $08, $00, $30, $04, $00
    db $78, $0F, $4D, $00, $B0, $0F, $19, $00, $B2, $0C, $00, $4E, $0E, $00, $26, $1C
    db $00, $22, $0F, $0B

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0EAttrs_Y1X0:: ; heuristic: map screen stream; C0
Data_094_6413:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252413, $47

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0EAttrs_Y1X1:: ; heuristic: map screen stream; C0
Data_094_645A:: ; address name
    db $68, $01, $02, $04, $04, $01, $02, $02, $0B, $04, $04, $02, $00, $0F, $0B, $02
    db $FA, $F2, $02, $24, $0F, $05, $02, $02, $06, $02, $32, $04, $02, $02, $08, $02
    db $5A, $0F, $01, $02, $81, $0F, $4D, $02, $04, $0F, $1B, $02, $0A, $08, $02, $00
    db $04, $02, $12, $04, $02, $18, $1F, $11, $02, $4C, $16, $02, $46, $1A

; compressed tileset of special map record 15 (SpecialMapRecords)
; LZSS-compressed asset: 1244 bytes expand to 1712 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0FTileset:: ; heuristic: special map tileset stream; C0
Data_094_6498:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252498, $4DC

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0FPalettes::
Data_094_6974:: ; address name
    dw $192C, $7FFF, $31CF, $0000 ; entry 0
    dw $0175, $5B7F, $1E7E, $0009 ; entry 1
    dw $01C4, $3F7F, $03E7, $00A0 ; entry 2
    dw $192C, $7FFF, $03E7, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 5
    dw $0CEC, $3F7F, $0175, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0FScreens::
Data_094_69B4:: ; address name
    dfar SpecialMap0FScreens_Y0X0 ; entry 0
    dfar SpecialMap0FScreens_Y0X1 ; entry 1
    dfar SpecialMap0FScreens_Y1X0 ; entry 2
    dfar SpecialMap0FScreens_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0FAttrs::
Data_094_69C0:: ; address name
    dfar SpecialMap0FAttrs_Y0X0 ; entry 0
    dfar SpecialMap0FAttrs_Y0X1 ; entry 1
    dfar SpecialMap0FAttrs_Y1X0 ; entry 2
    dfar SpecialMap0FAttrs_Y1X1 ; entry 3

; LZSS-compressed asset: 275 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0FScreens_Y0X0:: ; heuristic: map screen stream; C0
Data_094_69CC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2529CC, $113

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0FScreens_Y0X1:: ; heuristic: map screen stream; C0
Data_094_6ADF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252ADF, $F8

; LZSS-compressed asset: 257 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0FScreens_Y1X0:: ; heuristic: map screen stream; C0
Data_094_6BD7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252BD7, $101

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0FScreens_Y1X1:: ; heuristic: map screen stream; C0
Data_094_6CD8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252CD8, $E4

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0FAttrs_Y0X0:: ; heuristic: map screen stream; C0
Data_094_6DBC:: ; address name
    db $68, $01, $03, $02, $03, $00, $0F, $1A, $01, $03, $2E, $01, $03, $20, $0F, $15
    db $03, $56, $04, $03, $50, $0F, $03, $06, $03, $7A, $09, $03, $74, $0F, $0F, $00
    db $00, $03, $98, $0F, $13, $03, $80, $06, $03, $C8, $0F, $2B, $03, $00, $00, $03
    db $80, $08, $03, $16, $1F, $0D, $03, $5A, $0C, $03, $46, $1A

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0FAttrs_Y0X1:: ; heuristic: map screen stream; C0
Data_094_6DF8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252DF8, $5B

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0FAttrs_Y1X0:: ; heuristic: map screen stream; C0
Data_094_6E53:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252E53, $53

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0FAttrs_Y1X1:: ; heuristic: map screen stream; C0
Data_094_6EA6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252EA6, $42

; compressed tileset of special map record 23 (SpecialMapRecords)
; LZSS-compressed asset: 743 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap17Tileset:: ; heuristic: special map tileset stream; C0
Data_094_6EE8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $252EE8, $2E7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap17Palettes::
Data_094_71CF:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $00ED, $7FFF, $11D4, $0000 ; entry 1
    dw $00ED, $22BA, $11D4, $0000 ; entry 2
    dw $01C4, $3F7F, $0348, $0000 ; entry 3
    dw $00ED, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of special map record 24 (SpecialMapRecords)
; LZSS-compressed asset: 622 bytes expand to 1200 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap18Tileset:: ; heuristic: special map tileset stream; C0
Data_094_720F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $25320F, $26E

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap18Palettes::
Data_094_747D:: ; address name
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $05A4, $4B7B, $2A8E, $0084 ; entry 1
    dw $386C, $53DE, $4593, $0000 ; entry 2
    dw $012F, $035F, $01DA, $0000 ; entry 3
    dw $0160, $5AB1, $4A2D, $0000 ; entry 4
    dw $0152, $53DE, $025C, $0008 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap18Screens::
Data_094_74BD:: ; address name
    dfar SpecialMap18Screens_Y0X0 ; entry 0
    dfar SpecialMap18Screens_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap18Attrs::
Data_094_74C3:: ; address name
    dfar SpecialMap18Attrs_Y0X0 ; entry 0
    dfar SpecialMap18Attrs_Y0X1 ; entry 1

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap18Screens_Y0X0:: ; heuristic: map screen stream; C0
Data_094_74C9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2534C9, $C6

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap18Screens_Y0X1:: ; heuristic: map screen stream; C0
Data_094_758F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $25358F, $F3

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap18Attrs_Y0X0:: ; heuristic: map screen stream; C0
Data_094_7682:: ; address name
    db $68, $01, $00, $04, $00, $00, $0F, $42, $01, $00, $56, $05, $00, $4C, $0F, $11
    db $06, $06, $00, $5A, $08, $00, $7E, $0E, $00, $56, $06, $00, $9A, $0F, $4D, $00
    db $BE, $0F, $07, $00, $4E, $0E, $00, $5E, $0F, $13, $00, $5C, $04

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap18Attrs_Y0X1:: ; heuristic: map screen stream; C0
Data_094_76AF:: ; address name
    db $68, $01, $00, $04, $00, $00, $0F, $14, $01, $00, $28, $03, $00, $24, $02, $00
    db $22, $0F, $11, $00, $2A, $08, $00, $52, $0F, $07, $00, $78, $06, $00, $76, $0F
    db $4D, $00, $9A, $0F, $03, $00, $74, $0F, $01, $00, $20, $0C, $00, $10, $1F, $0D
    db $00, $26, $0A, $00, $3E, $1F, $03

; compressed tileset of special map record 25 (SpecialMapRecords)
; LZSS-compressed asset: 832 bytes expand to 1408 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap19Tileset:: ; heuristic: special map tileset stream; C0
Data_094_76E6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2536E6, $340

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap19Palettes::
Data_094_7A26:: ; address name
    dw $192C, $7FFF, $31CF, $0000 ; entry 0
    dw $0175, $5B7F, $1E7E, $0009 ; entry 1
    dw $01C4, $3F7F, $03E7, $00A0 ; entry 2
    dw $192A, $3F7F, $22F0, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 5
    dw $0CEC, $3F7F, $0175, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap19Screens::
Data_094_7A66:: ; address name
    dfar SpecialMap19Screens_Y0X0 ; entry 0
    dfar SpecialMap19Screens_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap19Attrs::
Data_094_7A6C:: ; address name
    dfar SpecialMap19Attrs_Y0X0 ; entry 0
    dfar SpecialMap19Attrs_Y0X1 ; entry 1

; LZSS-compressed asset: 282 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap19Screens_Y0X0:: ; heuristic: map screen stream; C0
Data_094_7A72:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $253A72, $11A

; LZSS-compressed asset: 265 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap19Screens_Y0X1:: ; heuristic: map screen stream; C0
Data_094_7B8C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $253B8C, $109

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap19Attrs_Y0X0:: ; heuristic: map screen stream; C0
Data_094_7C95:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $253C95, $48

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap19Attrs_Y0X1:: ; heuristic: map screen stream; C0
Data_094_7CDD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $253CDD, $5A
    ds $2C9, $00
