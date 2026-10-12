SECTION "Bank 59", ROMX[$4000], BANK[$59]
    db $59

; compressed tileset of map $A8 (the first map record using it)
; LZSS-compressed asset: 1186 bytes expand to 1856 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Tileset:: ; heuristic: map tileset stream; C0
Data_059_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164001, $4A2

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapA8Palettes::
Data_059_44A3:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $012F, $3FBF, $03E2, $0000 ; entry 2
    dw $318C, $7FFF, $03E2, $0000 ; entry 3
    dw $0160, $3FBF, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7

; E-0142 (derived: 36 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA8Screens0::
Data_059_44E3:: ; address name
    dfar MapA8Screens0_Y0X0 ; entry 0
    dfar MapA8Screens0_Y0X1 ; entry 1
    dfar MapA8Screens0_Y0X2 ; entry 2
    dfar MapA8Screens0_Y0X3 ; entry 3
    dfar MapA8Screens0_Y0X4 ; entry 4
    dfar MapA8Screens0_Y0X5 ; entry 5
    dfar MapA8Screens0_Y1X0 ; entry 6
    dfar MapA8Screens0_Y1X1 ; entry 7
    dfar MapA8Screens0_Y1X2 ; entry 8
    dfar MapA8Screens0_Y1X3 ; entry 9
    dfar MapA8Screens0_Y1X4 ; entry 10
    dfar MapA8Screens0_Y1X5 ; entry 11
    dfar MapA8Screens0_Y2X0 ; entry 12
    dfar MapA8Screens0_Y2X1 ; entry 13
    dfar MapA8Screens0_Y2X2 ; entry 14
    dfar MapA8Screens0_Y2X3 ; entry 15
    dfar MapA8Screens0_Y2X4 ; entry 16
    dfar MapA8Screens0_Y2X5 ; entry 17
    dfar MapA8Screens0_Y3X0 ; entry 18
    dfar MapA8Screens0_Y3X1 ; entry 19
    dfar MapA8Screens0_Y3X2 ; entry 20
    dfar MapA8Screens0_Y3X3 ; entry 21
    dfar MapA8Screens0_Y3X4 ; entry 22
    dfar MapA8Screens0_Y3X5 ; entry 23
    dfar MapA8Screens0_Y4X0 ; entry 24
    dfar MapA8Screens0_Y4X1 ; entry 25
    dfar MapA8Screens0_Y4X2 ; entry 26
    dfar MapA8Screens0_Y4X3 ; entry 27
    dfar MapA8Screens0_Y4X4 ; entry 28
    dfar MapA8Screens0_Y4X5 ; entry 29
    dfar MapA8Screens0_Y5X0 ; entry 30
    dfar MapA8Screens0_Y5X1 ; entry 31
    dfar MapA8Screens0_Y5X2 ; entry 32
    dfar MapA8Screens0_Y5X3 ; entry 33
    dfar MapA8Screens0_Y5X4 ; entry 34
    dfar MapA8Screens0_Y5X5 ; entry 35

; E-0142 (derived: 36 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA8Attrs0::
Data_059_454F:: ; address name
    dfar MapA8Attrs0_Y0X0 ; entry 0
    dfar MapA8Attrs0_Y0X1 ; entry 1
    dfar MapA8Attrs0_Y0X2 ; entry 2
    dfar MapA8Attrs0_Y0X3 ; entry 3
    dfar MapA8Attrs0_Y0X4 ; entry 4
    dfar MapA8Attrs0_Y0X5 ; entry 5
    dfar MapA8Attrs0_Y1X0 ; entry 6
    dfar MapA8Attrs0_Y1X1 ; entry 7
    dfar MapA8Attrs0_Y1X2 ; entry 8
    dfar MapA8Attrs0_Y1X3 ; entry 9
    dfar MapA8Attrs0_Y1X4 ; entry 10
    dfar MapA8Attrs0_Y1X5 ; entry 11
    dfar MapA8Attrs0_Y2X0 ; entry 12
    dfar MapA8Attrs0_Y2X1 ; entry 13
    dfar MapA8Attrs0_Y2X2 ; entry 14
    dfar MapA8Attrs0_Y2X3 ; entry 15
    dfar MapA8Attrs0_Y2X4 ; entry 16
    dfar MapA8Attrs0_Y2X5 ; entry 17
    dfar MapA8Attrs0_Y3X0 ; entry 18
    dfar MapA8Attrs0_Y3X1 ; entry 19
    dfar MapA8Attrs0_Y3X2 ; entry 20
    dfar MapA8Attrs0_Y3X3 ; entry 21
    dfar MapA8Attrs0_Y3X4 ; entry 22
    dfar MapA8Attrs0_Y3X5 ; entry 23
    dfar MapA8Attrs0_Y4X0 ; entry 24
    dfar MapA8Attrs0_Y4X1 ; entry 25
    dfar MapA8Attrs0_Y4X2 ; entry 26
    dfar MapA8Attrs0_Y4X3 ; entry 27
    dfar MapA8Attrs0_Y4X4 ; entry 28
    dfar MapA8Attrs0_Y4X5 ; entry 29
    dfar MapA8Attrs0_Y5X0 ; entry 30
    dfar MapA8Attrs0_Y5X1 ; entry 31
    dfar MapA8Attrs0_Y5X2 ; entry 32
    dfar MapA8Attrs0_Y5X3 ; entry 33
    dfar MapA8Attrs0_Y5X4 ; entry 34
    dfar MapA8Attrs0_Y5X5 ; entry 35

; LZSS-compressed asset: 112 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_45BB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1645BB, $70

; LZSS-compressed asset: 137 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_059_462B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16462B, $89

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y0X2:: ; heuristic: map screen stream; C0
Data_059_46B4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1646B4, $88

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y0X3:: ; heuristic: map screen stream; C0
Data_059_473C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16473C, $59

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y0X4:: ; heuristic: map screen stream; C0
Data_059_4795:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y0X5:: ; heuristic: map screen stream; C0
Data_059_47B2:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_059_47CF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1647CF, $88

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_059_4857:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164857, $9E

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y1X2:: ; heuristic: map screen stream; C0
Data_059_48F5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1648F5, $50

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y1X3:: ; heuristic: map screen stream; C0
Data_059_4945:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164945, $82

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y1X4:: ; heuristic: map screen stream; C0
Data_059_49C7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1649C7, $72

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y1X5:: ; heuristic: map screen stream; C0
Data_059_4A39:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164A39, $8B

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y2X0:: ; heuristic: map screen stream; C0
Data_059_4AC4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164AC4, $78

; LZSS-compressed asset: 137 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y2X1:: ; heuristic: map screen stream; C0
Data_059_4B3C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164B3C, $89

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y2X2:: ; heuristic: map screen stream; C0
Data_059_4BC5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164BC5, $80

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y2X3:: ; heuristic: map screen stream; C0
Data_059_4C45:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164C45, $78

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y2X4:: ; heuristic: map screen stream; C0
Data_059_4CBD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164CBD, $81

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y2X5:: ; heuristic: map screen stream; C0
Data_059_4D3E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164D3E, $51

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y3X0:: ; heuristic: map screen stream; C0
Data_059_4D8F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164D8F, $8B

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y3X1:: ; heuristic: map screen stream; C0
Data_059_4E1A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164E1A, $72

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y3X2:: ; heuristic: map screen stream; C0
Data_059_4E8C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164E8C, $76

; LZSS-compressed asset: 137 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y3X3:: ; heuristic: map screen stream; C0
Data_059_4F02:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164F02, $89

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y3X4:: ; heuristic: map screen stream; C0
Data_059_4F8B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $164F8B, $82

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y3X5:: ; heuristic: map screen stream; C0
Data_059_500D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16500D, $9C

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y4X0:: ; heuristic: map screen stream; C0
Data_059_50A9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1650A9, $58

; LZSS-compressed asset: 127 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y4X1:: ; heuristic: map screen stream; C0
Data_059_5101:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165101, $7F

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y4X2:: ; heuristic: map screen stream; C0
Data_059_5180:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165180, $80

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y4X3:: ; heuristic: map screen stream; C0
Data_059_5200:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165200, $83

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y4X4:: ; heuristic: map screen stream; C0
Data_059_5283:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165283, $96

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y4X5:: ; heuristic: map screen stream; C0
Data_059_5319:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165319, $99

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y5X0:: ; heuristic: map screen stream; C0
Data_059_53B2:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y5X1:: ; heuristic: map screen stream; C0
Data_059_53CF:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y5X2:: ; heuristic: map screen stream; C0
Data_059_53EC:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y5X3:: ; heuristic: map screen stream; C0
Data_059_5409:: ; address name
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y5X4:: ; heuristic: map screen stream; C0
Data_059_5426:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165426, $69

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Screens0_Y5X5:: ; heuristic: map screen stream; C0
Data_059_548F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16548F, $93

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_5522:: ; address name
    db $68, $01, $00, $0B, $00, $00, $0F, $22, $09, $00, $36, $01, $00, $28, $0F, $09
    db $00, $36, $02, $00, $4A, $0F, $09, $00, $58, $08, $00, $72, $0F, $31, $0A, $0A
    db $00, $B8, $0F, $15, $00, $CA, $0C, $00, $F0, $0F, $07, $00, $CA, $0A, $00, $18
    db $1F, $29

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_059_5554:: ; address name
    db $68, $01, $00, $0B, $00, $00, $0F, $14, $09, $09, $09, $09, $00, $1E, $08, $0A
    db $0A, $0A, $0A, $00, $28, $0F, $05, $00, $50, $06, $00, $38, $00, $00, $4E, $0F
    db $0F, $00, $5E, $02, $00, $76, $0F, $0F, $00, $5C, $0F, $15, $00, $5A, $04, $00
    db $C8, $0F, $4D, $00, $00, $1F, $19

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_059_558B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16558B, $50

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y0X3:: ; heuristic: map screen stream; C0
Data_059_55DB:: ; address name
    db $68, $01, $00, $0B, $00, $00, $0F, $3C, $0A, $00, $50, $01, $00, $42, $0F, $3D
    db $00, $54, $0A, $00, $A0, $0F, $03, $09, $09, $00, $B8, $0F, $11, $09, $00, $F0
    db $01, $00, $E2, $0F, $13, $00, $E0, $0F, $01, $00, $E0, $0F, $01, $00, $00, $0C
    db $00, $40, $1F, $01

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y0X4:: ; heuristic: map screen stream; C0
Data_059_560F:: ; address name
    db $68, $01, $00, $0B, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y0X5:: ; heuristic: map screen stream; C0
Data_059_5623:: ; address name
    db $68, $01, $00, $0B, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_059_5637:: ; address name
    db $68, $01, $00, $0B, $0B, $0A, $00, $02, $01, $09, $00, $08, $07, $00, $00, $0F
    db $07, $00, $08, $08, $00, $26, $0F, $09, $00, $04, $0A, $00, $50, $0F, $03, $00
    db $78, $00, $00, $02, $0A, $00, $78, $0F, $0D, $00, $04, $04, $00, $A0, $0F, $11
    db $00, $02, $00, $00, $C8, $0F, $2D, $00, $CE, $0A, $00, $16, $1F, $2B

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_059_5675:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165675, $41

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_059_56B6:: ; address name
    db $68, $01, $00, $0A, $00, $00, $09, $09, $00, $0E, $01, $00, $00, $0F, $0D, $00
    db $0E, $02, $00, $26, $0F, $2B, $00, $10, $08, $00, $70, $0F, $0D, $00, $7A, $0F
    db $11, $00, $00, $0A, $00, $0C, $02, $00, $C8, $0F, $37, $00, $0E, $0F, $13, $00
    db $0C, $0F, $09

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y1X3:: ; heuristic: map screen stream; C0
Data_059_56E9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1656E9, $43

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y1X4:: ; heuristic: map screen stream; C0
Data_059_572C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16572C, $43

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y1X5:: ; heuristic: map screen stream; C0
Data_059_576F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16576F, $45

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_059_57B4:: ; address name
    db $68, $01, $00, $0B, $0B, $0B, $0B, $0A, $00, $04, $0B, $00, $00, $0F, $2B, $00
    db $04, $02, $01, $01, $00, $46, $0F, $0F, $01, $00, $7C, $03, $00, $70, $0F, $0B
    db $00, $7C, $04, $00, $80, $06, $00, $A0, $0F, $0F, $00, $58, $02, $00, $C8, $0F
    db $0F, $00, $9A, $0F, $29, $00, $C2, $0F, $1B

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_059_57ED:: ; address name
    db $68, $01, $00, $0A, $00, $00, $03, $09, $09, $09, $09, $00, $00, $04, $00, $00
    db $0F, $07, $00, $08, $00, $00, $08, $0C, $00, $2E, $0F, $09, $00, $0A, $08, $00
    db $56, $0E, $00, $56, $06, $00, $72, $0F, $17, $00, $0A, $04, $00, $A4, $0F, $0F
    db $00, $0A, $02, $00, $CC, $0F, $01, $00, $A2, $0F, $25, $00, $9E, $0F, $29

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_059_582C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16582C, $46

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y2X3:: ; heuristic: map screen stream; C0
Data_059_5872:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165872, $47

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y2X4:: ; heuristic: map screen stream; C0
Data_059_58B9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1658B9, $54

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y2X5:: ; heuristic: map screen stream; C0
Data_059_590D:: ; address name
    db $68, $01, $00, $0A, $00, $00, $07, $0B, $00, $0C, $03, $00, $00, $0F, $31, $00
    db $0C, $04, $00, $4C, $0F, $4D, $00, $0C, $04, $09, $09, $00, $B6, $0F, $15, $00
    db $C8, $04, $00, $08, $06, $00, $F0, $0F, $05, $00, $F2, $0C, $00, $18, $1F, $29

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y3X0:: ; heuristic: map screen stream; C0
Data_059_593D:: ; address name
    db $68, $01, $00, $0B, $0B, $01, $00, $02, $09, $0A, $0A, $0A, $0A, $00, $00, $0F
    db $03, $00, $00, $0A, $00, $24, $0F, $15, $00, $0E, $00, $00, $50, $0F, $3B, $01
    db $01, $00, $A0, $0F, $4D, $00, $B0, $02, $00, $B8, $0C, $00, $16, $1F, $2B

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y3X1:: ; heuristic: map screen stream; C0
Data_059_596C:: ; address name
    db $68, $01, $00, $02, $00, $00, $01, $01, $00, $06, $09, $00, $00, $0F, $4D, $00
    db $10, $06, $00, $18, $0A, $00, $78, $0F, $01, $00, $76, $06, $00, $18, $08, $00
    db $A2, $0F, $01, $00, $10, $0C, $00, $D2, $06, $00, $D0, $0E, $00, $12, $06, $00
    db $16, $08, $00, $F8, $0F, $01, $00, $A0, $0F, $19, $00, $78, $0F, $09

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y3X2:: ; heuristic: map screen stream; C0
Data_059_59AA:: ; address name
    db $68, $01, $00, $01, $00, $00, $05, $02, $00, $0A, $05, $00, $00, $0F, $0B, $00
    db $08, $06, $00, $28, $0F, $0D, $00, $06, $04, $00, $50, $0F, $11, $00, $78, $0F
    db $2D, $00, $76, $0F, $01, $00, $C8, $0F, $03, $00, $4E, $0F, $27, $00, $4C, $0F
    db $05, $00, $4E, $0C, $00, $4A, $0F, $01

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y3X3:: ; heuristic: map screen stream; C0
Data_059_59E2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1659E2, $48

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y3X4:: ; heuristic: map screen stream; C0
Data_059_5A2A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165A2A, $4F

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y3X5:: ; heuristic: map screen stream; C0
Data_059_5A79:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165A79, $60

; LZSS-compressed asset: 35 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y4X0:: ; heuristic: map screen stream; C0
Data_059_5AD9:: ; address name
    db $68, $01, $00, $0B, $0B, $01, $00, $02, $0D, $00, $00, $0F, $4D, $00, $38, $0F
    db $1B, $00, $3C, $0E, $00, $A0, $0F, $2D, $00, $3C, $0C, $00, $F0, $0F, $2F, $00
    db $40, $1F, $0F

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y4X1:: ; heuristic: map screen stream; C0
Data_059_5AFC:: ; address name
    db $68, $01, $00, $01, $00, $00, $07, $02, $00, $0C, $03, $00, $00, $0F, $0D, $00
    db $0A, $04, $00, $28, $0F, $37, $00, $0A, $02, $00, $78, $0F, $37, $00, $22, $0F
    db $13, $00, $0C, $0F, $13, $00, $0C, $04, $00, $16, $1F, $03, $0B, $00, $40, $1F
    db $14

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y4X2:: ; heuristic: map screen stream; C0
Data_059_5B2D:: ; address name
    db $68, $01, $00, $02, $00, $00, $01, $01, $00, $06, $09, $00, $00, $0F, $4D, $00
    db $10, $06, $00, $18, $0A, $00, $78, $0F, $09, $06, $06, $06, $06, $00, $74, $08
    db $00, $A4, $0F, $05, $00, $C4, $0F, $1B, $0B, $00, $FE, $01, $00, $F0, $0F, $07
    db $00, $FE, $02, $00, $1E, $14, $00, $18, $1F, $01, $00, $32, $1F, $15

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y4X3:: ; heuristic: map screen stream; C0
Data_059_5B6B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165B6B, $49

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y4X4:: ; heuristic: map screen stream; C0
Data_059_5BB4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165BB4, $4B

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y4X5:: ; heuristic: map screen stream; C0
Data_059_5BFF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165BFF, $5A

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y5X0:: ; heuristic: map screen stream; C0
Data_059_5C59:: ; address name
    db $68, $01, $00, $0B, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y5X1:: ; heuristic: map screen stream; C0
Data_059_5C6D:: ; address name
    db $68, $01, $00, $0B, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y5X2:: ; heuristic: map screen stream; C0
Data_059_5C81:: ; address name
    db $68, $01, $00, $0B, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y5X3:: ; heuristic: map screen stream; C0
Data_059_5C95:: ; address name
    db $68, $01, $00, $0B, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y5X4:: ; heuristic: map screen stream; C0
Data_059_5CA9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165CA9, $42

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA8Attrs0_Y5X5:: ; heuristic: map screen stream; C0
Data_059_5CEB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165CEB, $53

; compressed tileset of map $A9 (the first map record using it)
; LZSS-compressed asset: 1314 bytes expand to 1488 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA9Tileset:: ; heuristic: map tileset stream; C0
Data_059_5D3E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $165D3E, $522

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapA9Palettes::
Data_059_6260:: ; address name
    dw $192C, $7FFF, $31CF, $0000 ; entry 0
    dw $0175, $5B7F, $1E7E, $0009 ; entry 1
    dw $01C4, $3F7F, $03E7, $00A0 ; entry 2
    dw $192C, $7FFF, $03E7, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $31CF, $7DA0, $5AD6, $0000 ; entry 5
    dw $0CEC, $3F7F, $0175, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA9Screens0::
Data_059_62A0:: ; address name
    dfar MapA9Screens0_Y0X0 ; entry 0
    dfar MapA9Screens0_Y0X1 ; entry 1
    dfar MapA9Screens0_Y1X0 ; entry 2
    dfar MapA9Screens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA9Attrs0::
Data_059_62AC:: ; address name
    dfar MapA9Attrs0_Y0X0 ; entry 0
    dfar MapA9Attrs0_Y0X1 ; entry 1
    dfar MapA9Attrs0_Y1X0 ; entry 2
    dfar MapA9Attrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA9Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_62B8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1662B8, $F9

; LZSS-compressed asset: 255 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA9Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_059_63B1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1663B1, $FF

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA9Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_059_64B0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1664B0, $D8

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA9Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_059_6588:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $166588, $D4

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA9Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_665C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16665C, $51

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA9Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_059_66AD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1666AD, $5A

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA9Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_059_6707:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $166707, $49

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA9Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_059_6750:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $166750, $49

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapAAScreens0::
Data_059_6799:: ; address name
    dfar MapAAScreens0_Y0X0 ; entry 0
    dfar MapAAScreens0_Y1X0 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapAAAttrs0::
Data_059_679F:: ; address name
    dfar MapAAAttrs0_Y0X0 ; entry 0
    dfar MapAAAttrs0_Y1X0 ; entry 1

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapAAScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_67A5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1667A5, $C8

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapAAScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_059_686D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16686D, $D6

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapAAAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_6943:: ; address name
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapAAAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_059_6957:: ; address name
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapABScreens0::
Data_059_696B:: ; address name
    dfar MapABScreens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapABAttrs0::
Data_059_696E:: ; address name
    dfar MapABAttrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 268 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapABScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_6971:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $166971, $10C

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapABAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_6A7D:: ; address name
    db $68, $01, $03, $02, $03, $00, $0F, $18, $06, $03, $2C, $09, $03, $26, $0F, $09
    db $01, $01, $01, $01, $03, $2C, $00, $00, $00, $03, $4C, $0F, $0C, $03, $2C, $03
    db $03, $58, $00, $03, $76, $0F, $39, $03, $4A, $09, $03, $CF, $0F, $15, $03, $0A
    db $13, $03, $36, $0A, $03, $56, $04, $03, $14, $1F, $09, $03, $00, $0F, $11

; compressed tileset of map $AC (the first map record using it)
; LZSS-compressed asset: 848 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapACTileset:: ; heuristic: map tileset stream; C0
Data_059_6ABC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $166ABC, $350

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapACPalettes::
Data_059_6E0C:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $0189, $5B7F, $122F, $00A0 ; entry 1
    dw $0175, $5B7F, $1EFA, $0009 ; entry 2
    dw $7D86, $5B7F, $0346, $00A0 ; entry 3
    dw $01A0, $5B7F, $0346, $00A0 ; entry 4
    dw $0189, $7FE1, $122F, $00A0 ; entry 5
    dw $01A0, $7FE1, $0346, $00A0 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapACScreens0::
Data_059_6E4C:: ; address name
    dfar MapACScreens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapACAttrs0::
Data_059_6E4F:: ; address name
    dfar MapACAttrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 276 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapACScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_6E52:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $166E52, $114

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapACAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_6F66:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $166F66, $95

; compressed tileset of map $AD (the first map record using it)
; LZSS-compressed asset: 584 bytes expand to 1440 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADTileset:: ; heuristic: map tileset stream; C0
Data_059_6FFB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $166FFB, $248

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapADPalettes::
Data_059_7243:: ; address name
    dw $01A2, $7FFF, $0348, $0063 ; entry 0
    dw $01A2, $3F7F, $0348, $0084 ; entry 1
    dw $012F, $3F7F, $01D5, $0044 ; entry 2
    dw $1415, $4FFF, $3C1F, $0000 ; entry 3
    dw $5D8C, $3F7F, $5AB1, $0000 ; entry 4
    dw $218C, $3F7F, $029A, $0000 ; entry 5
    dw $0000, $294A, $56B5, $7FFF ; entry 6
    dw $0000, $294A, $56B5, $7FFF ; entry 7

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapADScreens0::
Data_059_7283:: ; address name
    dfar MapADScreens0_Y0X0 ; entry 0
    dfar MapADScreens0_Y0X1 ; entry 1
    dfar MapADScreens0_Y0X2 ; entry 2
    dfar MapADScreens0_Y1X0 ; entry 3
    dfar MapADScreens0_Y1X1 ; entry 4
    dfar MapADScreens0_Y1X2 ; entry 5
    dfar MapADScreens0_Y2X0 ; entry 6
    dfar MapADScreens0_Y2X1 ; entry 7
    dfar MapADScreens0_Y2X2 ; entry 8
    dfar MapADScreens0_Y3X0 ; entry 9
    dfar MapADScreens0_Y3X1 ; entry 10
    dfar MapADScreens0_Y3X2 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapADAttrs0::
Data_059_72A7:: ; address name
    dfar MapADAttrs0_Y0X0 ; entry 0
    dfar MapADAttrs0_Y0X1 ; entry 1
    dfar MapADAttrs0_Y0X2 ; entry 2
    dfar MapADAttrs0_Y1X0 ; entry 3
    dfar MapADAttrs0_Y1X1 ; entry 4
    dfar MapADAttrs0_Y1X2 ; entry 5
    dfar MapADAttrs0_Y2X0 ; entry 6
    dfar MapADAttrs0_Y2X1 ; entry 7
    dfar MapADAttrs0_Y2X2 ; entry 8
    dfar MapADAttrs0_Y3X0 ; entry 9
    dfar MapADAttrs0_Y3X1 ; entry 10
    dfar MapADAttrs0_Y3X2 ; entry 11

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_72CB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1672CB, $AA

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y0X1:: ; heuristic: map screen stream; C0
Data_059_7375:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $167375, $B6

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y0X2:: ; heuristic: map screen stream; C0
Data_059_742B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16742B, $BE

; LZSS-compressed asset: 142 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_059_74E9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1674E9, $8E

; LZSS-compressed asset: 183 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y1X1:: ; heuristic: map screen stream; C0
Data_059_7577:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $167577, $B7

; LZSS-compressed asset: 195 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y1X2:: ; heuristic: map screen stream; C0
Data_059_762E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16762E, $C3

; LZSS-compressed asset: 140 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y2X0:: ; heuristic: map screen stream; C0
Data_059_76F1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1676F1, $8C

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y2X1:: ; heuristic: map screen stream; C0
Data_059_777D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16777D, $92

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y2X2:: ; heuristic: map screen stream; C0
Data_059_780F:: ; address name
    db $68, $01, $00, $20, $21, $00, $00, $0E, $30, $31, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y3X0:: ; heuristic: map screen stream; C0
Data_059_782C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $16782C, $C0

; LZSS-compressed asset: 185 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y3X1:: ; heuristic: map screen stream; C0
Data_059_78EC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1678EC, $B9

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADScreens0_Y3X2:: ; heuristic: map screen stream; C0
Data_059_79A5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1679A5, $95

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_059_7A3A:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $1A, $04, $04, $04, $04, $00, $1E, $0F, $15
    db $00, $30, $0C, $00, $56, $0F, $01, $00, $54, $04, $00, $30, $0A, $00, $80, $0F
    db $05, $03, $03, $00, $2E, $0A, $00, $A8, $0F, $01, $00, $54, $0F, $1D, $00, $1E
    db $0F, $11, $00, $2C, $00, $00, $14, $1F, $13, $00, $00, $0F, $07

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_059_7A77:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_059_7A8B:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_059_7A9F:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4A, $04, $04, $00, $4C, $0F, $0F, $04, $00
    db $82, $01, $00, $74, $0F, $0D, $00, $82, $0F, $13, $00, $7E, $04, $00, $C2, $0F
    db $15, $00, $AC, $0F, $13, $00, $00, $0F, $31

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_059_7AC8:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $1E, $0F, $0A, $04, $04, $00, $6C
    db $0F, $11, $04, $00, $A4, $01, $00, $96, $0F, $3B, $00, $94, $0F, $01, $00, $1E
    db $0F, $49

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_059_7AEA:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $16, $04, $04, $00, $18, $0F, $13, $00, $28
    db $00, $00, $2A, $0E, $00, $54, $0F, $01, $00, $28, $0F, $15, $00, $2A, $0F, $19
    db $00, $2C, $0F, $15, $00, $F7, $0F, $4D, $00, $00, $0C

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_059_7B15:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_059_7B29:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $48, $04, $00, $5C, $01, $00, $4E, $0F, $0D
    db $00, $5C, $02, $00, $74, $0F, $15, $00, $4E, $0F, $0F, $00, $5A, $02, $00, $C4
    db $0F, $13, $00, $4A, $0F, $01, $00, $00, $0F, $43

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_059_7B53:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y3X0:: ; heuristic: map screen stream; C0
Data_059_7B67:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $20, $04, $00, $34, $01, $00, $26, $0F, $0D
    db $00, $34, $02, $00, $4C, $0F, $0D, $00, $5A, $0F, $13, $00, $30, $04, $00, $24
    db $0F, $01, $00, $00, $0F, $21, $00, $F5, $0F, $4D, $00, $00, $0E

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y3X1:: ; heuristic: map screen stream; C0
Data_059_7B94:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapADAttrs0_Y3X2:: ; heuristic: map screen stream; C0
Data_059_7BA8:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34
    ds $444, $00
