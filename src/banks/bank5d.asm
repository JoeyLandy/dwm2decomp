SECTION "Bank 5D", ROMX[$4000], BANK[$5D]
    db $5D

; address loaded by RunGameMode2State_Case01
; LZSS-compressed asset: 312 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05D_4001:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $174001, $138

; E-0164 (derived: 8 bytes copied into a palette buffer by CopyFromBank, CopyBytesDEToHL_Bank00 or LoadBGPaletteBufferFromBank)
; record: one CGB palette: 4 BGR555 colours
Palettes_5D_4139::
Data_05D_4139:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $318C, $7FFF, $5294, $0000 ; id 0
    INCBIN "dwm2-cobi-us.gbc", $174141, $78

; E-0167 (C1: entry 0 of WorldMapViewTable).
; record: 8 x 8 tiles, one row per line
WorldMapView0::
Data_05D_41B9:: ; heuristic: world map view rectangle; C0
    db $3E, $15, $26, $37, $26, $0E, $19, $0F ; id 0
    db $13, $33, $33, $33, $01, $31, $33, $11 ; id 1
    db $25, $22, $33, $33, $33, $33, $1F, $0C ; id 2
    db $00, $2F, $33, $33, $33, $33, $03, $24 ; id 3
    db $3A, $05, $33, $33, $33, $33, $33, $11 ; id 4
    db $27, $00, $33, $33, $33, $33, $16, $32 ; id 5
    db $25, $09, $02, $33, $33, $33, $33, $26 ; id 6
    db $32, $32, $3C, $2A, $3A, $14, $2A, $3B ; id 7

; E-0167 (C1: entry 1 of WorldMapViewTable).
; record: 8 x 8 tiles, one row per line
WorldMapView1::
Data_05D_41F9:: ; heuristic: world map view rectangle; C0
    db $32, $02, $0F, $0D, $0C, $0E, $0F, $3D ; id 0
    db $32, $3D, $17, $00, $01, $2F, $03, $32 ; id 1
    db $32, $24, $10, $03, $24, $0B, $07, $32 ; id 2
    db $1B, $2B, $37, $06, $11, $27, $26, $32 ; id 3
    db $27, $06, $02, $16, $32, $3C, $24, $32 ; id 4
    db $36, $24, $17, $30, $2D, $32, $32, $27 ; id 5
    db $0E, $11, $31, $33, $30, $37, $19, $06 ; id 6
    db $32, $32, $10, $3A, $18, $09, $24, $32 ; id 7

; E-0167 (C1: entry 2 of WorldMapViewTable).
; record: 12 x 12 tiles, one row per line
WorldMapView2::
Data_05D_4239:: ; heuristic: world map view rectangle; C0
    db $32, $32, $32, $32, $0D, $01, $32, $32, $32, $32, $32, $32 ; id 0
    db $32, $32, $32, $32, $05, $33, $2B, $0F, $32, $32, $32, $32 ; id 1
    db $32, $32, $32, $32, $25, $02, $33, $33, $19, $04, $01, $32 ; id 2
    db $32, $32, $32, $32, $32, $3C, $33, $33, $33, $33, $33, $0F ; id 3
    db $32, $32, $32, $32, $32, $0E, $33, $33, $33, $33, $33, $16 ; id 4
    db $32, $32, $32, $32, $3E, $33, $33, $33, $33, $33, $33, $14 ; id 5
    db $32, $27, $2B, $19, $33, $33, $33, $33, $33, $33, $33, $1A ; id 6
    db $32, $10, $33, $33, $33, $33, $33, $33, $33, $33, $11, $32 ; id 7
    db $32, $32, $05, $33, $33, $33, $33, $33, $33, $33, $26, $32 ; id 8
    db $32, $27, $00, $33, $33, $33, $03, $02, $33, $33, $01, $26 ; id 9
    db $27, $00, $03, $18, $33, $33, $11, $25, $3A, $02, $33, $16 ; id 10
    db $2A, $3A, $24, $32, $32, $32, $32, $32, $32, $36, $2A, $11 ; id 11

; E-0167 (C1: entry 3 of WorldMapViewTable).
; record: 12 x 12 tiles, one row per line
WorldMapView3::
Data_05D_42C9:: ; heuristic: world map view rectangle; C0
    db $32, $27, $3D, $3E, $04, $26, $32, $32, $32, $32, $32, $32 ; id 0
    db $32, $3C, $24, $32, $02, $01, $26, $32, $32, $32, $00, $01 ; id 1
    db $32, $3D, $32, $32, $10, $02, $18, $24, $32, $32, $17, $33 ; id 2
    db $32, $32, $27, $3D, $32, $25, $17, $11, $0E, $0F, $05, $03 ; id 3
    db $3E, $37, $31, $01, $26, $32, $3C, $32, $17, $08, $3C, $07 ; id 4
    db $0B, $2F, $33, $33, $39, $32, $05, $19, $31, $39, $32, $32 ; id 5
    db $32, $22, $33, $33, $01, $37, $00, $33, $03, $24, $32, $32 ; id 6
    db $32, $0B, $2A, $02, $33, $33, $33, $33, $30, $0F, $32, $32 ; id 7
    db $27, $3D, $32, $3C, $02, $33, $33, $33, $03, $11, $32, $32 ; id 8
    db $17, $39, $32, $32, $23, $2F, $03, $18, $11, $3E, $3D, $23 ; id 9
    db $05, $30, $26, $3A, $0E, $00, $08, $32, $32, $10, $01, $01 ; id 10
    db $25, $18, $07, $11, $2A, $3A, $11, $32, $32, $32, $3C, $11 ; id 11

; E-0167 (C1: entry 4 of WorldMapViewTable).
; record: 4 x 3 tiles, one row per line
WorldMapView4::
Data_05D_4359:: ; heuristic: world map view rectangle; C0
    db $0D, $3D, $32, $32 ; id 0
    db $38, $01, $26, $32 ; id 1
    db $0B, $3A, $0A, $32 ; id 2

; E-0167 (C1: entry 5 of WorldMapViewTable).
; record: 6 x 6 tiles, one row per line
WorldMapView5::
Data_05D_4365:: ; heuristic: world map view rectangle; C0
    db $19, $33, $19, $26, $32, $32 ; id 0
    db $17, $33, $33, $30, $01, $3D ; id 1
    db $33, $33, $33, $33, $33, $30 ; id 2
    db $17, $33, $33, $33, $33, $03 ; id 3
    db $02, $33, $18, $09, $02, $01 ; id 4
    db $32, $32, $32, $32, $38, $03 ; id 5

; E-0167 (C1: entry 6 of WorldMapViewTable).
; record: 3 x 2 tiles, one row per line
WorldMapView6::
Data_05D_4389:: ; heuristic: world map view rectangle; C0
    db $3E, $19, $0F ; id 0
    db $10, $2A, $3A ; id 1

; E-0167 (C1: entry 7 of WorldMapViewTable).
; record: 5 x 5 tiles, one row per line
WorldMapView7::
Data_05D_438F:: ; heuristic: world map view rectangle; C0
    db $3E, $2B, $19, $26, $26 ; id 0
    db $17, $33, $33, $30, $08 ; id 1
    db $38, $33, $08, $23, $22 ; id 2
    db $10, $33, $01, $30, $06 ; id 3
    db $10, $2A, $18, $2A, $3B ; id 4

; E-0167 (C1: entry 8 of WorldMapViewTable).
; record: 1 x 2 tiles, one row per line
WorldMapView8::
Data_05D_43A8:: ; heuristic: world map view rectangle; C0
    db $37 ; id 0
    db $3A ; id 1

; E-0167 (C1: entry 9 of WorldMapViewTable).
; record: 1 x 2 tiles, one row per line
WorldMapView9::
Data_05D_43AA:: ; heuristic: world map view rectangle; C0
    db $06 ; id 0
    db $3B ; id 1

; E-0167 (C1: entry 10 of WorldMapViewTable).
; record: 2 x 1 tiles, one row per line
WorldMapView10::
Data_05D_43AC:: ; heuristic: world map view rectangle; C0
    db $38, $39 ; id 0

; address loaded by RunGameMode2State_Case04
; LZSS-compressed asset: 439 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05D_43AE:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1743AE, $1B7

; E-0164 (derived: 64 bytes copied into a palette buffer by CopyFromBank, CopyBytesDEToHL_Bank00 or LoadBGPaletteBufferFromBank)
; record: one CGB palette: 4 BGR555 colours
Palettes_5D_4565::
Data_05D_4565:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $014D, $6BFF, $2A55, $0000 ; id 0
    dw $294A, $7FFF, $4A52, $0000 ; id 1
    dw $294A, $7FFF, $4A52, $0000 ; id 2
    dw $294A, $7FFF, $4A52, $0000 ; id 3
    dw $294A, $7FFF, $4A52, $0000 ; id 4
    dw $294A, $7FFF, $4A52, $0000 ; id 5
    dw $294A, $7FFF, $4A52, $0000 ; id 6
    dw $294A, $7FFF, $4A52, $0000 ; id 7
    INCBIN "dwm2-cobi-us.gbc", $1745A5, $9B
    ds $14, $56
    db $06, $0B, $57, $57, $57, $56, $56, $05, $57, $57, $56, $01, $56, $0B, $57, $56
    db $56, $56, $56, $57, $56, $56, $56, $56, $57, $57, $57, $56, $56, $56, $57, $57
    db $02, $56, $56, $57, $57, $0C, $56, $56, $57, $0A, $56, $56, $56, $57, $04
    ds $16, $56
    INCBIN "dwm2-cobi-us.gbc", $174699, $5F
    ds $28, $56
    INCBIN "dwm2-cobi-us.gbc", $174720, $8E
    ds $25, $56
    INCBIN "dwm2-cobi-us.gbc", $1747D3, $8F
    ds $12, $56
    INCBIN "dwm2-cobi-us.gbc", $174874, $A8
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $17492C, $59
    ds $15, $57
    db $0A, $56, $57, $57, $04, $56, $56, $57, $57, $04, $56, $56, $57, $04, $56, $56
    db $56, $0A
    ds $47, $56
    INCBIN "dwm2-cobi-us.gbc", $1749F3, $49
    ds $1B, $57
    INCBIN "dwm2-cobi-us.gbc", $174A57, $46
    ds $1E, $56
    INCBIN "dwm2-cobi-us.gbc", $174ABB, $60
    ds $35, $57
    INCBIN "dwm2-cobi-us.gbc", $174B50, $95
    ds $1A, $58
    INCBIN "dwm2-cobi-us.gbc", $174BFF, $A6
    ds $24, $58
    INCBIN "dwm2-cobi-us.gbc", $174CC9, $90
    ds $35, $58
    INCBIN "dwm2-cobi-us.gbc", $174D8E, $90
    ds $25, $58
    INCBIN "dwm2-cobi-us.gbc", $174E43, $A8
    ds $20, $58
    INCBIN "dwm2-cobi-us.gbc", $174F0B, $5D
    ds $1B, $58
    db $25, $56, $56, $56, $58, $58, $00, $0D, $02, $58, $14, $56, $01, $17, $58, $58
    db $17, $1D, $58, $58, $58, $58, $58, $58, $56, $56, $05, $24, $58, $56, $56, $57
    db $20, $58, $17, $0D, $2A
    ds $26, $58
    INCBIN "dwm2-cobi-us.gbc", $174FCE, $7A
    ds $37, $58
    INCBIN "dwm2-cobi-us.gbc", $17507F, $D8
    ds $39, $58
    INCBIN "dwm2-cobi-us.gbc", $175190, $6F
    ds $26, $58
    ds $72, $57
    db $06, $57, $57, $57, $00, $56, $57, $57, $57, $56, $56, $57, $0A, $06, $0B, $57
    db $57, $56, $07, $56, $57, $00, $56, $56, $56, $05, $56, $56, $56, $56, $00, $56
    db $56, $56, $56
    ds $FE, $57
    INCBIN "dwm2-cobi-us.gbc", $1753B8, $60
    ds $CC, $57
    INCBIN "dwm2-cobi-us.gbc", $1754E4, $AB
    ds $98, $57
    INCBIN "dwm2-cobi-us.gbc", $175627, $AD
    ds $87, $57
    db $06, $57, $0A, $56, $56, $56, $57, $56, $56, $56, $03, $57, $04, $56, $56, $05
    db $57, $56, $56, $05, $57, $00, $56, $03, $57, $57, $56, $56, $0D, $57, $57, $07
    ds $14, $57
    INCBIN "dwm2-cobi-us.gbc", $17578F, $72
    ds $69, $57
    db $04, $56, $06, $57, $56, $57, $56, $56, $56, $56, $57, $02, $56, $56, $56, $57
    db $57, $57, $56, $56, $0A, $00, $56, $56, $05
    ds $14, $56
    INCBIN "dwm2-cobi-us.gbc", $175897, $86
    ds $35, $57
    db $06, $00, $56, $57, $00, $56, $56, $56, $57, $56, $56, $56, $56, $57, $57, $57
    db $57, $57, $0A, $0B, $57, $00, $06, $56, $56, $00, $56, $56, $56, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $57, $57, $57, $57, $57, $06, $06, $57, $06
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $175991, $49
    ds $37, $58
    db $25, $57, $58, $58, $58, $57, $57, $58, $58, $25, $0A, $56, $58, $58, $58, $00
    db $56, $58, $58, $58, $56, $56, $57, $56, $56, $56, $0B, $04, $56, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $03, $56, $56, $56, $56, $57, $57
    db $57, $57, $57, $57, $56, $01, $0B, $57, $57, $56, $56, $03, $57, $57, $07, $07
    ds $22, $57
    INCBIN "dwm2-cobi-us.gbc", $175A73, $8D
    ds $27, $58
    db $10, $56, $1B, $58, $58, $56, $56, $15, $58, $58, $1C, $17, $58, $58, $58, $58
    db $58, $58, $58, $58, $58, $58, $56, $56, $58, $58, $14, $56, $56, $58, $58, $56
    db $56, $56, $58, $1C, $56, $56, $07, $58, $58, $56, $05, $57, $56, $56, $56, $56
    db $57, $56, $56, $56, $05, $57, $56, $56, $03, $57, $57, $07, $0D
    ds $55, $57
    db $56, $56, $0B, $57, $57, $02, $56, $01, $57, $57, $57, $56, $56, $57, $57, $57
    db $56, $56, $57, $57, $57, $56, $56, $04, $56, $56, $56, $56, $00
    ds $15, $56
    db $58, $58, $58, $56, $56, $11, $58, $58, $56, $56, $56, $58, $58, $56, $56, $1D
    db $58, $58, $56, $56
    ds $43, $58
    INCBIN "dwm2-cobi-us.gbc", $175C42, $54
    ds $40, $57
    INCBIN "dwm2-cobi-us.gbc", $175CD6, $C8
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $175DAE, $199
    ds $A5, $57
    INCBIN "dwm2-cobi-us.gbc", $175FEC, $49
    ds $20, $58
    INCBIN "dwm2-cobi-us.gbc", $176055, $74
    ds $B2, $58
    db $14, $56, $56, $56, $58, $56, $56, $56, $03, $1C, $56, $56, $03, $2A, $58, $1C
    db $12, $1D, $58, $58, $58, $58, $58, $58, $56, $56, $1B, $58, $58, $02, $56, $56
    db $58, $58, $26, $07, $20
    ds $26, $58
    INCBIN "dwm2-cobi-us.gbc", $1761C6, $49
    ds $4E, $58
    db $16, $40, $27, $58, $14, $13, $35, $06, $58, $3F, $58, $16, $56, $58, $25, $56
    db $56, $56, $58, $25, $56, $56, $56, $22, $58, $58, $58, $58, $06, $2C, $22, $58
    db $58, $56, $56, $05, $58, $58, $56, $56, $01, $24, $58, $56, $56, $56, $57
    ds $1C, $58
    db $23, $16, $1B, $58, $4C, $00, $56, $2E, $25, $56, $56, $56, $1D, $21, $4B, $56
    db $55
    ds $3A, $58
    INCBIN "dwm2-cobi-us.gbc", $1762F3, $59
    ds $3C, $58
    db $25, $56, $56, $56, $58, $57, $04, $56, $56, $58, $2B, $57, $56, $56, $58, $58
    db $2B, $02, $56, $58, $58, $25, $04, $56, $56, $56, $56, $57, $58, $56, $56, $56
    db $05, $24, $56, $56, $56, $05, $58, $56, $56, $56, $01, $22, $56, $56, $56, $56
    db $24
    ds $3A, $58
    db $16, $16, $58, $10, $56, $56, $56, $58, $56, $56, $56, $07, $58, $14, $56, $05
    db $57, $58, $58, $58, $16, $58, $16, $39, $56, $56, $15, $56, $56, $09, $56, $1D
    db $07, $57, $56, $13, $58, $57, $04, $56, $15
    ds $1C, $58
    INCBIN "dwm2-cobi-us.gbc", $176438, $128
    ds $1C, $58
    db $56, $56, $56, $1B, $14, $56, $56, $56, $1D, $58, $56, $56, $1D, $58, $58, $1C
    ds $22, $58
    INCBIN "dwm2-cobi-us.gbc", $1765AE, $DF
    ds $1D, $58
    db $1B, $58, $58, $58, $10, $56, $16, $58, $58, $12, $56, $56, $58, $58, $14, $56
    db $56, $58, $58, $14, $56, $56, $58, $58, $58, $58, $1B, $16, $1B, $1A
    ds $11, $56
    db $58, $58, $56, $56, $58, $56, $16, $56, $15, $58, $56, $13, $58, $14, $1B, $56
    db $11, $16, $56, $56, $56, $56, $56, $56, $56, $58, $14, $1B, $58, $58, $58, $14
    db $56, $1B, $58, $1A, $56, $13, $58, $58, $56, $56, $11, $58, $58, $56, $56, $56
    ds $4D, $58
    INCBIN "dwm2-cobi-us.gbc", $176756, $DA
    ds $55, $58
    INCBIN "dwm2-cobi-us.gbc", $176885, $DD
    ds $3F, $58
    db $16, $16, $56, $58, $14, $56, $56, $56, $58, $58, $56, $56, $56, $58, $58, $58
    db $58, $58, $1A, $10, $11, $58, $58, $56, $56, $56, $1D, $58, $56, $56, $15, $58
    db $58, $56, $56
    ds $1D, $58
    INCBIN "dwm2-cobi-us.gbc", $1769E1, $A6
    ds $3B, $58
    db $56, $56, $56, $56, $58, $56, $56, $56, $03, $58, $56, $56, $03, $57, $1A, $56
    db $56, $0D, $57, $14, $56, $57, $57, $57, $56, $56, $1B, $58, $58, $07, $00, $11
    db $58, $58, $57, $56, $13, $58, $58, $0A, $56, $1D, $58, $58, $04, $56
    ds $36, $58
    INCBIN "dwm2-cobi-us.gbc", $176B26, $175
    ds $35, $58
    INCBIN "dwm2-cobi-us.gbc", $176CD0, $EC
    ds $58, $58
    db $1A, $56, $06, $57, $58, $14, $56, $56, $0D, $58, $1C, $56, $56, $56, $58, $58
    db $1C, $17, $1D, $58, $58, $58, $58, $58, $04, $56, $56, $56, $15, $0A, $56, $56
    db $56, $58, $56, $56, $56, $1D, $58, $1C, $56, $1D
    ds $15, $58
    db $1A, $58, $58, $58, $10, $56, $58, $58, $58, $56, $56, $58, $58, $23, $58, $58
    db $58, $1A, $56, $52, $58, $10, $56, $03, $2A, $58, $56, $56, $0D, $58, $58, $56
    db $56, $57
    ds $36, $58
    INCBIN "dwm2-cobi-us.gbc", $176EAB, $47
    ds $1E, $58
    db $10, $56, $58, $58, $58, $12, $56, $58, $58, $58, $58, $17, $58, $58, $58, $58
    db $58, $58, $58, $58, $58, $58, $56, $05, $57, $00, $56, $56, $56, $00, $56, $58
    db $12, $56, $56, $56, $1D, $58, $12, $56, $58, $58, $58, $58, $58, $58, $58, $56
    db $56, $56, $58, $58, $1C, $12, $1D
    ds $2A, $58
    db $57, $57, $57, $0A, $06, $0A, $06, $56, $56, $56, $04, $56, $56, $56, $56, $04
    db $56, $56, $56, $56, $04, $56, $56, $56, $56, $06, $57, $57, $0A, $06
    ds $14, $56
    db $0B, $57, $0B, $57, $57, $56, $00, $56, $00
    ds $10, $56
    db $57, $57, $57, $57, $57, $56, $05, $57, $57, $57, $56, $56, $57, $57, $57, $56
    db $56, $57, $57, $57, $56
    ds $36, $57
    db $04, $56, $56, $56, $56, $0C, $02, $56, $56, $56, $57, $04, $56, $56, $56, $57
    db $00, $56, $56, $56, $57
    ds $37, $56
    INCBIN "dwm2-cobi-us.gbc", $177053, $5F
    ds $6B, $56
    db $57, $57, $56, $56, $57, $57, $57, $56, $56, $57, $57, $57, $56, $56, $56, $01
    db $57, $56, $56, $56, $56, $57, $0C, $56, $56, $56, $56, $57, $56, $56, $56, $56
    db $57, $56, $56, $56, $56, $0A, $56, $56, $56, $56, $04
    ds $6C, $56
    db $57, $56, $56, $56, $56, $05, $56, $56, $56, $56, $05, $56, $56, $56, $56, $0D
    db $56, $56, $56, $57, $57, $04, $56, $56, $56, $56, $04, $56, $56, $56, $56, $57
    db $56, $56, $56, $56, $57, $04, $56, $56, $56, $57, $57, $57, $57, $57
    ds $14, $56
    db $57, $57, $57, $57, $57
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $17720B, $54
    ds $67, $57
    INCBIN "dwm2-cobi-us.gbc", $1772C6, $B9
    ds $13, $57
    INCBIN "dwm2-cobi-us.gbc", $177392, $A1
    ds $18, $56
    INCBIN "dwm2-cobi-us.gbc", $17744B, $4F
    ds $1F, $56
    INCBIN "dwm2-cobi-us.gbc", $1774B9, $5F
    ds $1D, $56
    INCBIN "dwm2-cobi-us.gbc", $177535, $15D
    ds $96E, $00
