SECTION "Bank 48", ROMX[$4000], BANK[$48]
    db $48

; E-0145 (C1: entry 0 of AreaPaletteTable).
; record: one CGB palette: 4 BGR555 colours
AreaPalettes0::
BGPaletteBufferData_48_4001:: ; heuristic: argument of a bank-switching copy helper; C0
Data_048_4001:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $7DA0, $7FFF, $5AD6, $0063 ; entry 1
    dw $02C0, $3F7F, $03E2, $0000 ; entry 2
    dw $012F, $3FBF, $01D5, $0000 ; entry 3
    dw $158F, $4298, $2A13, $0000 ; entry 4
    dw $012F, $3FBF, $03E2, $0000 ; entry 5
    dw $02C0, $3FBF, $7FE0, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map01Palettes::
Data_048_4041:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $7DA0, $7FFF, $5AD6, $0063 ; entry 1
    dw $02C0, $3FBF, $03E2, $0000 ; entry 2
    dw $012F, $3FBF, $01D5, $0000 ; entry 3
    dw $158F, $4298, $2A13, $0000 ; entry 4
    dw $1415, $2BFF, $023F, $0000 ; entry 5
    dw $02C0, $3F7F, $7FE0, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map02Palettes::
BGPaletteBufferData_48_4081:: ; heuristic: argument of a bank-switching copy helper; C0
Data_048_4081:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $7DA0, $7FFF, $5AD6, $0063 ; entry 1
    dw $02C0, $3F7F, $03E2, $0000 ; entry 2
    dw $012F, $3FBF, $01D5, $0000 ; entry 3
    dw $00CC, $2BFF, $0118, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $02C0, $3F7F, $7FE0, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of map $06 (the first map record using it)
; LZSS-compressed asset: 871 bytes expand to 1600 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map06Tileset:: ; heuristic: map tileset stream; C0
Data_048_40C1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1200C1, $367

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map06Palettes::
Data_048_4428:: ; address name
    dw $1415, $7FFF, $3C1F, $0000 ; entry 0
    dw $012F, $035F, $01DA, $0000 ; entry 1
    dw $1528, $3695, $15AE, $0000 ; entry 2
    dw $1415, $035F, $01DA, $0000 ; entry 3
    dw $1528, $7FFF, $6B2B, $0020 ; entry 4
    dw $012F, $4FFF, $01DA, $0020 ; entry 5
    dw $31CF, $7F04, $5AD6, $0000 ; entry 6
    dw $29CE, $4FFF, $3695, $0020 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map06Screens0::
Data_048_4468:: ; address name
    dfar Map06Screens0_Y0X0 ; entry 0
    db $80, $44, $48, $80, $44, $48, $80, $44, $48

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map06Attrs0::
Data_048_4474:: ; address name
    dfar Map06Attrs0_Y0X0 ; entry 0
    db $4E, $45, $48, $4E, $45, $48, $4E, $45, $48

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map06Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_4480:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $120480, $CE

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map06Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_454E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12054E, $4A

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map05Palettes::
Data_048_4598:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $1528, $3695, $01D5, $0000 ; entry 1
    dw $1528, $0301, $15AC, $0000 ; entry 2
    dw $012F, $3FBF, $01D5, $0000 ; entry 3
    dw $1528, $3695, $15AE, $0000 ; entry 4
    dw $1528, $3FBF, $01D5, $0000 ; entry 5
    dw $012F, $5FFF, $5294, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of map $16 (the first map record using it)
; LZSS-compressed asset: 663 bytes expand to 896 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map16Tileset:: ; heuristic: map tileset stream; C0
Data_048_45D8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1205D8, $297

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map16Palettes::
Data_048_486F:: ; address name
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
Map16Screens0::
Data_048_48AF:: ; address name
    dfar Map16Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map16Attrs0::
Data_048_48B2:: ; address name
    dfar Map16Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map16Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_48B5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1208B5, $AD

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map16Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_4962:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $120962, $47

; compressed tileset of map $17 (the first map record using it)
; LZSS-compressed asset: 734 bytes expand to 1120 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map17Tileset:: ; heuristic: map tileset stream; C0
Data_048_49A9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1209A9, $2DE

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map17Palettes::
Data_048_4C87:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $49AE, $6B79, $4ACD, $0000 ; entry 4
    dw $29CE, $4FFF, $3695, $0020 ; entry 5
    dw $29CE, $4FFF, $3695, $0020 ; entry 6
    dw $29CE, $4FFF, $3695, $0020 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map17Screens0::
Data_048_4CC7:: ; address name
    dfar Map17Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map17Attrs0::
Data_048_4CCA:: ; address name
    dfar Map17Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map17Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_4CCD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $120CCD, $CD

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map17Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_4D9A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $120D9A, $42

; compressed tileset of map $18 (the first map record using it)
; address loaded by DebugStaffRoll_Update_Sub01_Case02_Case00
; LZSS-compressed asset: 860 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Tileset:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_048_4DDC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $120DDC, $35C

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map18Palettes::
BGPaletteBufferData_48_5138:: ; heuristic: argument of a bank-switching copy helper; C0
Data_048_5138:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $306A, $50BF, $3071, $0020 ; entry 4
    dw $29CE, $4FFF, $3695, $0020 ; entry 5
    dw $04A9, $50FF, $092E, $0020 ; entry 6
    dw $294A, $7FFF, $4A52, $0000 ; entry 7

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map18Screens0::
Data_048_5178:: ; address name
    dfar Map18Screens0_Y0X0 ; entry 0
    dfar Map18Screens0_Y0X1 ; entry 1
    dfar Map18Screens0_Y0X2 ; entry 2
    dfar Map18Screens0_Y1X0 ; entry 3
    dfar Map18Screens0_Y1X1 ; entry 4
    dfar Map18Screens0_Y1X2 ; entry 5

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map18Attrs0::
Data_048_518A:: ; address name
    dfar Map18Attrs0_Y0X0 ; entry 0
    dfar Map18Attrs0_Y0X1 ; entry 1
    dfar Map18Attrs0_Y0X2 ; entry 2
    dfar Map18Attrs0_Y1X0 ; entry 3
    dfar Map18Attrs0_Y1X1 ; entry 4
    dfar Map18Attrs0_Y1X2 ; entry 5

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_519C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12119C, $A0

; address loaded by DebugStaffRoll_Update_Sub01_Case02_Case00
; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Screens0_Y0X1:: ; heuristic: argument of a bank-switching copy helper; C0
Data_048_523C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12123C, $97

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Screens0_Y0X2:: ; heuristic: map screen stream; C0
Data_048_52D3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1212D3, $8F

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_048_5362:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $121362, $71

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_048_53D3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1213D3, $4A

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Screens0_Y1X2:: ; heuristic: map screen stream; C0
Data_048_541D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12141D, $5F

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_547C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12147C, $43

; address loaded by DebugStaffRoll_Update_Sub01_Case02_Case00
; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Attrs0_Y0X1:: ; heuristic: argument of a bank-switching copy helper; C0
Data_048_54BF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1214BF, $4A

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Attrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_048_5509:: ; address name
    db $68, $01, $00, $03, $00, $00, $01, $01, $01, $00, $00, $02, $00, $00, $00, $02
    db $02, $00, $00, $0F, $37, $00, $06, $00, $00, $4E, $0F, $03, $04, $00, $78, $01
    db $01, $01, $00, $78, $00, $00, $70, $0F, $0F, $00, $A0, $04, $00, $9A, $0F, $3D
    db $00, $82, $00, $00, $EE, $0F, $39, $00, $9A, $0F, $07

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_048_5544:: ; address name
    db $68, $01, $00, $02, $02, $03, $03, $01, $01, $04, $00, $06, $09, $00, $00, $0F
    db $4D, $00, $10, $04, $06, $06, $00, $6A, $0F, $15, $00, $7C, $0A, $00, $A0, $0F
    db $05, $00, $7A, $00, $00, $18, $02, $00, $18, $02, $00, $C8, $0F, $07, $00, $F2
    db $0A, $00, $F0, $0F, $4D, $00, $CA, $00

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_048_557C:: ; address name
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $90, $0F, $1C
    db $03, $03, $01, $01, $04, $04, $00, $F2, $00, $00, $F4, $02, $01, $01, $03, $03
    db $00, $F0, $0F, $03, $00, $16, $1F, $3B

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map18Attrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_048_55A4:: ; address name
    db $68, $01, $00, $04, $00, $00, $09, $01, $01, $03, $03, $02, $02, $00, $00, $0F
    db $4D, $00, $24, $0E, $04, $04, $00, $74, $0F, $13, $06, $06, $00, $9C, $0F, $09
    db $01, $01, $00, $A8, $06, $00, $C4, $0F, $05, $00, $D6, $00, $00, $F0, $0A, $00
    db $EE, $0F, $4D, $00, $D6, $02

; compressed tileset of map $19 (the first map record using it)
; address loaded by DebugStaffRoll_Update_Sub01_Case03_Case00
; LZSS-compressed asset: 1627 bytes expand to 1920 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Tileset:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_048_55DA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1215DA, $65B

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map19Screens0::
Data_048_5C35:: ; address name
    dfar Map19Screens0_Y0X0 ; entry 0
    dfar Map19Screens0_Y0X0 ; entry 1
    dfar Map19Screens0_Y1X0 ; entry 2
    dfar Map19Screens0_Y1X1 ; entry 3
    dfar Map19Screens0_Y2X0 ; entry 4
    dfar Map19Screens0_Y0X0 ; entry 5

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map19Attrs0::
Data_048_5C47:: ; address name
    dfar Map19Attrs0_Y0X0 ; entry 0
    dfar Map19Attrs0_Y0X0 ; entry 1
    dfar Map19Attrs0_Y1X0 ; entry 2
    dfar Map19Attrs0_Y1X1 ; entry 3
    dfar Map19Attrs0_Y2X0 ; entry 4
    dfar Map19Attrs0_Y0X0 ; entry 5

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map19Screens6::
Data_048_5C59:: ; address name
    dfar Map19Screens6_Y0X0 ; entry 0
    dfar Map19Screens0_Y0X0 ; entry 1
    dfar Map19Screens0_Y1X0 ; entry 2
    dfar Map19Screens0_Y1X1 ; entry 3
    dfar Map19Screens0_Y2X0 ; entry 4
    dfar Map19Screens0_Y0X0 ; entry 5

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map19Attrs6::
Data_048_5C6B:: ; address name
    dfar Map19Attrs6_Y0X0 ; entry 0
    dfar Map19Attrs0_Y0X0 ; entry 1
    dfar Map19Attrs0_Y1X0 ; entry 2
    dfar Map19Attrs0_Y1X1 ; entry 3
    dfar Map19Attrs0_Y2X0 ; entry 4
    dfar Map19Attrs0_Y0X0 ; entry 5

; address loaded by DebugStaffRoll_Update_Sub01_Case03_Case00
; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Screens0_Y0X0:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_048_5C7D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $121C7D, $E5

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Screens6_Y0X0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_048_5D62:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $121D62, $E7

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Screens0_Y1X0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_048_5E49:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $121E49, $EB

; LZSS-compressed asset: 226 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_5F34:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $121F34, $E2

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Screens0_Y1X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_048_6016:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $122016, $C9

; LZSS-compressed asset: 275 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Screens0_Y2X0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_048_60DF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1220DF, $113

; address loaded by DebugStaffRoll_Update_Sub01_Case03_Case00
; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Attrs0_Y0X0:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_048_61F2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1221F2, $82

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Attrs6_Y0X0:: ; heuristic: map screen stream; C0
Data_048_6274:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $122274, $84

; LZSS-compressed asset: 111 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_048_62F8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1222F8, $6F

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_6367:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $122367, $6E

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_048_63D5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1223D5, $5D

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map19Attrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_048_6432:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $122432, $91

; compressed tileset of map $1B (the first map record using it)
; LZSS-compressed asset: 571 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1BTileset:: ; heuristic: map tileset stream; C0
Data_048_64C3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1224C3, $23B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map1BPalettes::
Data_048_66FE:: ; address name
    dw $7D86, $7FFF, $7D86, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $0020, $0020, $0020, $0020 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $0020, $0020, $0020, $0020 ; entry 5
    dw $0020, $0020, $0020, $0020 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map1BScreens0::
Data_048_673E:: ; address name
    dfar Map1BScreens0_Y0X0 ; entry 0
    dfar Map1BScreens0_Y1X0 ; entry 1
    dfar Map1BScreens0_Y2X0 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map1BAttrs0::
Data_048_6747:: ; address name
    dfar Map1BAttrs0_Y0X0 ; entry 0
    dfar Map1BAttrs0_Y1X0 ; entry 1
    dfar Map1BAttrs0_Y2X0 ; entry 2
    db $62, $67, $48, $C7, $68, $48, $5E, $69, $48, $3E, $6A, $48, $DC, $6A, $48, $1C
    db $6B, $48

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1BScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_6762:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $122762, $CE

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1BScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_048_6830:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $122830, $97

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_68C7:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $1228C7, $97

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1BScreens0_Y2X0:: ; heuristic: map screen stream; C0
Data_048_695E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12295E, $E0

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1BAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_6A3E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $122A3E, $5E

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1BAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_048_6A9C:: ; address name
    db $68, $01, $03, $00, $00, $02, $02, $02, $02, $01, $03, $06, $01, $03, $02, $00
    db $03, $FB, $F7, $02, $03, $0A, $02, $03, $0F, $04, $03, $00, $04, $03, $1F, $09
    db $03, $FD, $F1, $01, $01, $03, $A0, $FF, $4D, $03, $A5, $0F, $4D, $03, $C4, $FF
    db $2B, $03, $44, $00, $03, $44, $14, $03, $3C, $06, $03, $58, $14, $03, $E4, $02

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_6ADC:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $03, $00, $00, $02, $02, $02, $02, $01, $03, $06, $01, $03, $02, $00
    db $03, $FB, $F7, $02, $03, $0A, $02, $03, $0F, $04, $03, $00, $04, $03, $1F, $09
    db $03, $FD, $F1, $01, $01, $03, $A0, $FF, $4D, $03, $A5, $0F, $4D, $03, $C4, $FF
    db $2B, $03, $44, $00, $03, $44, $14, $03, $3C, $06, $03, $58, $14, $03, $E4, $02

; LZSS-compressed asset: 102 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1BAttrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_048_6B1C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $122B1C, $66

; compressed tileset of map $04 (the first map record using it)
; LZSS-compressed asset: 946 bytes expand to 1264 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map04Tileset:: ; heuristic: map tileset stream; C0
Data_048_6B82:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $122B82, $3B2

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map04Palettes::
Data_048_6F34:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $29CE, $4FFF, $3695, $0020 ; entry 5
    dw $34EB, $50BF, $3071, $0020 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map04Screens0::
Data_048_6F74:: ; address name
    dfar Map04Screens0_Y0X0 ; entry 0
    dfar Map04Screens0_Y0X1 ; entry 1
    dfar Map04Screens0_Y0X2 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map04Attrs0::
Data_048_6F7D:: ; address name
    dfar Map04Attrs0_Y0X0 ; entry 0
    dfar Map04Attrs0_Y0X1 ; entry 1
    dfar Map04Attrs0_Y0X2 ; entry 2

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map04Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_6F86:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $122F86, $E9

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map04Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_048_706F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12306F, $C4

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map04Screens0_Y0X2:: ; heuristic: map screen stream; C0
Data_048_7133:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $123133, $DA

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map04Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_720D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12320D, $60

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map04Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_048_726D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12326D, $57

; LZSS-compressed asset: 108 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map04Attrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_048_72C4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1232C4, $6C

; compressed tileset of map $14 (the first map record using it)
; LZSS-compressed asset: 1329 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map14Tileset:: ; heuristic: map tileset stream; C0
Data_048_7330:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $123330, $531

; address loaded by LoadMapHeader
; LZSS-compressed asset: 1494 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles2Gfx_48_7861:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_048_7861:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $123861, $5D6

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map14Palettes::
Data_048_7E37:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $0453, $6BFF, $201F, $0000 ; entry 1
    dw $012F, $6BFF, $025A, $0000 ; entry 2
    dw $5D8C, $7FFF, $7E75, $0000 ; entry 3
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map14Screens0::
Data_048_7E77:: ; address name
    dfar Map14Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map14Attrs0::
Data_048_7E7A:: ; address name
    dfar Map14Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 292 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map14Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_7E7D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $123E7D, $124

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map14Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_048_7FA1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $123FA1, $43
    ds $1C, $00
