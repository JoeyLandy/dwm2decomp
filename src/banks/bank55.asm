SECTION "Bank 55", ROMX[$4000], BANK[$55]
    db $55

; compressed tileset of map $8C (the first map record using it)
; LZSS-compressed asset: 731 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CTileset:: ; heuristic: map tileset stream; C0
Data_055_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154001, $2DB

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8CScreens0::
Data_055_42DC:: ; address name
    dfar Map8CScreens0_Y0X0 ; entry 0
    dfar Map8CScreens0_Y0X1 ; entry 1
    dfar Map8CScreens0_Y0X2 ; entry 2
    dfar Map8CScreens0_Y1X0 ; entry 3
    dfar Map8CScreens0_Y1X1 ; entry 4
    dfar Map8CScreens0_Y1X2 ; entry 5
    dfar Map8CScreens0_Y2X0 ; entry 6
    dfar Map8CScreens0_Y2X1 ; entry 7
    dfar Map8CScreens0_Y2X2 ; entry 8

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8CAttrs0::
Data_055_42F7:: ; address name
    dfar Map8CAttrs0_Y0X0 ; entry 0
    dfar Map8CAttrs0_Y0X1 ; entry 1
    dfar Map8CAttrs0_Y0X2 ; entry 2
    dfar Map8CAttrs0_Y1X0 ; entry 3
    dfar Map8CAttrs0_Y1X1 ; entry 4
    dfar Map8CAttrs0_Y1X2 ; entry 5
    dfar Map8CAttrs0_Y2X0 ; entry 6
    dfar Map8CAttrs0_Y2X1 ; entry 7
    dfar Map8CAttrs0_Y2X2 ; entry 8

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_4312:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154312, $C2

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CScreens0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_43D4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1543D4, $80

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CScreens0_Y0X2:: ; heuristic: map screen stream; C0
Data_055_4454:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154454, $AA

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_44FE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1544FE, $CB

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CScreens0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_45C9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1545C9, $D7

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CScreens0_Y1X2:: ; heuristic: map screen stream; C0
Data_055_46A0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1546A0, $98

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CScreens0_Y2X0:: ; heuristic: map screen stream; C0
Data_055_4738:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154738, $87

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CScreens0_Y2X1:: ; heuristic: map screen stream; C0
Data_055_47BF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1547BF, $DD

; LZSS-compressed asset: 106 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CScreens0_Y2X2:: ; heuristic: map screen stream; C0
Data_055_489C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15489C, $6A

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_4906:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $3E, $02, $00, $52, $05, $00, $50, $04, $00
    db $50, $0F, $2F, $00, $A0, $0A, $00, $A0, $0F, $4D, $00, $C4, $0C, $00, $56, $04
    db $00, $18, $1F, $09, $00, $44, $0E, $00, $00, $0A

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CAttrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_4930:: ; address name
    db $68, $01, $03, $01, $03, $00, $0F, $14, $04, $03, $28, $0F, $14, $02, $03, $50
    db $0F, $3C, $03, $00, $0F, $15, $10, $03, $C8, $01, $03, $26, $04, $03, $C6, $04
    db $03, $CA, $0F, $07, $03, $9A, $04, $03, $C8, $01, $00, $03, $04, $10, $03, $F6
    db $07, $03, $05, $11, $03, $06, $1F, $3B

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CAttrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_055_4968:: ; address name
    db $68, $01, $03, $01, $03, $00, $0F, $14, $04, $03, $28, $0D, $03, $26, $0F, $03
    db $02, $03, $50, $0D, $03, $4E, $0F, $2B, $03, $00, $02, $03, $92, $0F, $0F, $03
    db $4A, $0E, $03, $C6, $0F, $03, $10, $00, $10, $00, $03, $E0, $0F, $17, $03, $A0
    db $08, $03, $16, $1F, $07, $03, $FA, $F4, $03, $38, $1F, $09

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_49A4:: ; address name
    db $68, $01, $00, $01, $01, $02, $02, $02, $02, $01, $00, $06, $0B, $00, $02, $0F
    db $07, $04, $00, $30, $05, $00, $26, $0F, $09, $00, $52, $08, $00, $4E, $0F, $2D
    db $00, $0E, $08, $00, $9A, $0F, $09, $00, $34, $04, $00, $58, $08, $00, $CA, $0F
    db $01, $00, $EA, $0A, $00, $EC, $0F, $37, $00, $9E, $0E, $00, $06, $08

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CAttrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_49E2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1549E2, $45

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CAttrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_055_4A27:: ; address name
    db $68, $01, $03, $01, $03, $00, $07, $02, $03, $0C, $01, $03, $00, $08, $03, $0A
    db $06, $04, $03, $28, $05, $03, $1E, $0F, $0B, $03, $0C, $02, $03, $4A, $08, $03
    db $4E, $0F, $4D, $03, $0E, $0F

; LZSS-compressed asset: 415 bytes expand to 775 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Gfx_55_4A4D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_055_4A4D:: ; address name
    db $07, $03, $00, $0F, $01, $03, $F6, $F8, $03, $E8, $0F, $3D, $03, $00, $04, $03
    db $40, $1F, $01

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CAttrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_055_4A60:: ; address name
    db $68, $01, $03, $01, $01, $02, $03, $02, $01, $01, $01, $03, $F6, $FF, $4D, $03
    db $42, $0F, $2D, $03, $A8, $08, $03, $A2, $0F, $09, $04, $03, $D2, $05, $03, $C8
    db $0F, $09, $03, $F2, $08, $03, $F0, $0F, $2B, $03, $40, $1F, $13

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CAttrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_055_4A8D:: ; address name
    db $68, $01, $00, $01, $00, $00, $09, $02, $02, $02, $02, $00, $00, $0A, $00, $0C
    db $06, $04, $00, $2A, $05, $00, $20, $0F, $0B, $00, $0E, $00, $00, $52, $02, $00
    db $48, $0F, $37, $00, $A0, $0A, $00, $A0, $0F, $01, $04, $00, $B5, $0F, $14, $00
    db $56, $08, $00, $F8, $0A, $00, $F6, $0F, $23, $00, $12, $0C, $00, $40, $1F, $05

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8CAttrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_055_4ACD:: ; address name
    db $68, $01, $03, $10, $03, $00, $06, $00, $03, $0A, $05, $03, $01, $0F, $4D, $03
    db $11, $0A, $03, $1E, $00, $03, $73, $0F, $06, $01, $03, $A0, $0F, $14, $04, $03
    db $C8, $0D, $03, $C6, $0F, $03, $02, $03, $F0, $0D, $03, $EE, $0F, $2B, $03, $A0
    db $0F, $15

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map90Screens0::
Data_055_4AFF:: ; address name
    dfar Map90Screens0_Y0X0 ; entry 0
    dfar Map90Screens0_Y0X1 ; entry 1
    dfar Map90Screens0_Y0X2 ; entry 2
    dfar Map90Screens0_Y1X0 ; entry 3
    dfar Map90Screens0_Y1X1 ; entry 4
    dfar Map90Screens0_Y1X2 ; entry 5

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map90Attrs0::
Data_055_4B11:: ; address name
    dfar Map90Attrs0_Y0X0 ; entry 0
    dfar Map90Attrs0_Y0X1 ; entry 1
    dfar Map90Attrs0_Y0X2 ; entry 2
    dfar Map90Attrs0_Y1X0 ; entry 3
    dfar Map90Attrs0_Y1X1 ; entry 4
    dfar Map90Attrs0_Y1X2 ; entry 5

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_4B23:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154B23, $C9

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_4BEC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154BEC, $A4

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Screens0_Y0X2:: ; heuristic: map screen stream; C0
Data_055_4C90:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154C90, $AF

; LZSS-compressed asset: 185 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_4D3F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154D3F, $B9

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_4DF8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154DF8, $C1

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Screens0_Y1X2:: ; heuristic: map screen stream; C0
Data_055_4EB9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154EB9, $97

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_4F50:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154F50, $56

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_4FA6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154FA6, $46

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Attrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_055_4FEC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $154FEC, $48

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_5034:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $155034, $50

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_5084:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $155084, $52

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map90Attrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_055_50D6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1550D6, $4E

; compressed tileset of map $8E (the first map record using it)
; LZSS-compressed asset: 1566 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8ETileset:: ; heuristic: map tileset stream; C0
Data_055_5124:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $155124, $61E

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8EScreens0::
Data_055_5742:: ; address name
    dfar Map8EScreens0_Y0X0 ; entry 0
    dfar Map8EScreens0_Y0X1 ; entry 1
    dfar Map8EScreens0_Y0X2 ; entry 2
    dfar Map8EScreens0_Y1X0 ; entry 3
    dfar Map8EScreens0_Y1X1 ; entry 4
    dfar Map8EScreens0_Y1X2 ; entry 5
    dfar Map8EScreens0_Y2X0 ; entry 6
    dfar Map8EScreens0_Y2X1 ; entry 7
    dfar Map8EScreens0_Y2X2 ; entry 8

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8EAttrs0::
Data_055_575D:: ; address name
    dfar Map8EAttrs0_Y0X0 ; entry 0
    dfar Map8EAttrs0_Y0X1 ; entry 1
    dfar Map8EAttrs0_Y0X2 ; entry 2
    dfar Map8EAttrs0_Y1X0 ; entry 3
    dfar Map8EAttrs0_Y1X1 ; entry 4
    dfar Map8EAttrs0_Y1X2 ; entry 5
    dfar Map8EAttrs0_Y2X0 ; entry 6
    dfar Map8EAttrs0_Y2X1 ; entry 7
    dfar Map8EAttrs0_Y2X2 ; entry 8

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8EScreens3::
Data_055_5778:: ; address name
    dfar Map8EScreens0_Y0X0 ; entry 0
    dfar Map8EScreens3_Y0X1 ; entry 1
    dfar Map8EScreens0_Y0X2 ; entry 2
    dfar Map8EScreens0_Y1X0 ; entry 3
    dfar Map8EScreens0_Y1X1 ; entry 4
    dfar Map8EScreens0_Y1X2 ; entry 5
    dfar Map8EScreens0_Y2X0 ; entry 6
    dfar Map8EScreens0_Y2X1 ; entry 7
    dfar Map8EScreens0_Y2X2 ; entry 8

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8EAttrs3::
Data_055_5793:: ; address name
    dfar Map8EAttrs0_Y0X0 ; entry 0
    dfar Map8EAttrs3_Y0X1 ; entry 1
    dfar Map8EAttrs0_Y0X2 ; entry 2
    dfar Map8EAttrs0_Y1X0 ; entry 3
    dfar Map8EAttrs0_Y1X1 ; entry 4
    dfar Map8EAttrs0_Y1X2 ; entry 5
    dfar Map8EAttrs0_Y2X0 ; entry 6
    dfar Map8EAttrs0_Y2X1 ; entry 7
    dfar Map8EAttrs0_Y2X2 ; entry 8

; LZSS-compressed asset: 265 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_57AE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1557AE, $109

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EScreens0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_58B7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1558B7, $E3

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EScreens3_Y0X1:: ; heuristic: map screen stream; C0
Data_055_599A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15599A, $E3

; LZSS-compressed asset: 267 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EScreens0_Y0X2:: ; heuristic: map screen stream; C0
Data_055_5A7D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $155A7D, $10B

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_5B88:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $155B88, $CB

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EScreens0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_5C53:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $155C53, $AF

; LZSS-compressed asset: 256 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EScreens0_Y1X2:: ; heuristic: map screen stream; C0
Data_055_5D02:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $155D02, $100

; LZSS-compressed asset: 254 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EScreens0_Y2X0:: ; heuristic: map screen stream; C0
Data_055_5E02:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $155E02, $FE

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EScreens0_Y2X1:: ; heuristic: map screen stream; C0
Data_055_5F00:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $155F00, $F7

; LZSS-compressed asset: 251 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EScreens0_Y2X2:: ; heuristic: map screen stream; C0
Data_055_5FF7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $155FF7, $FB

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_60F2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1560F2, $71

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EAttrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_6163:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156163, $6B

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EAttrs3_Y0X1:: ; heuristic: map screen stream; C0
Data_055_61CE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1561CE, $6B

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EAttrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_055_6239:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156239, $82

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_62BB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1562BB, $71

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EAttrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_632C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15632C, $52

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EAttrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_055_637E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15637E, $78

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EAttrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_055_63F6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1563F6, $71

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EAttrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_055_6467:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156467, $5C

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8EAttrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_055_64C3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1564C3, $71

; compressed tileset of map $94 (the first map record using it)
; LZSS-compressed asset: 1084 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Tileset:: ; heuristic: map tileset stream; C0
Data_055_6534:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156534, $43C

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map94Screens0::
Data_055_6970:: ; address name
    dfar Map94Screens0_Y0X0 ; entry 0
    dfar Map94Screens0_Y0X1 ; entry 1
    dfar Map94Screens0_Y0X2 ; entry 2
    dfar Map94Screens0_Y1X0 ; entry 3
    dfar Map94Screens0_Y1X1 ; entry 4
    dfar Map94Screens0_Y1X2 ; entry 5
    dfar Map94Screens0_Y2X0 ; entry 6
    dfar Map94Screens0_Y2X1 ; entry 7
    dfar Map94Screens0_Y2X2 ; entry 8

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map94Attrs0::
Data_055_698B:: ; address name
    dfar Map94Attrs0_Y0X0 ; entry 0
    dfar Map94Attrs0_Y0X1 ; entry 1
    dfar Map94Attrs0_Y0X2 ; entry 2
    dfar Map94Attrs0_Y1X0 ; entry 3
    dfar Map94Attrs0_Y1X1 ; entry 4
    dfar Map94Attrs0_Y1X2 ; entry 5
    dfar Map94Attrs0_Y2X0 ; entry 6
    dfar Map94Attrs0_Y2X1 ; entry 7
    dfar Map94Attrs0_Y2X2 ; entry 8

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_69A6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1569A6, $C1

; LZSS-compressed asset: 210 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_6A67:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156A67, $D2

; LZSS-compressed asset: 210 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Screens0_Y0X2:: ; heuristic: map screen stream; C0
Data_055_6B39:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156B39, $D2

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_6C0B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156C0B, $D7

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_6CE2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156CE2, $C2

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Screens0_Y1X2:: ; heuristic: map screen stream; C0
Data_055_6DA4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156DA4, $D7

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Screens0_Y2X0:: ; heuristic: map screen stream; C0
Data_055_6E7B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156E7B, $BC

; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Screens0_Y2X1:: ; heuristic: map screen stream; C0
Data_055_6F37:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $156F37, $E5

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Screens0_Y2X2:: ; heuristic: map screen stream; C0
Data_055_701C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15701C, $E7

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_7103:: ; address name
    db $68, $01, $00, $04, $00, $00, $0F, $1A, $01, $01, $00, $2A, $06, $00, $26, $0F
    db $2F, $02, $00, $7C, $07, $00, $74, $0F, $07, $00, $7C, $08, $00, $84, $04, $00
    db $A2, $0F, $4D, $00, $76, $0F, $19, $00, $76, $04, $00, $00, $0E, $00, $3A, $18

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_7133:: ; address name
    db $68, $01, $00, $04, $00, $00, $0F, $1A, $01, $01, $00, $2A, $06, $00, $26, $0F
    db $2F, $02, $00, $7C, $07, $00, $74, $0F, $07, $00, $82, $04, $00, $80, $08, $00
    db $A2, $0F, $07, $00, $7E, $0A, $00, $CA, $0F, $29, $00, $7A, $0F, $15, $00, $76
    db $04, $00, $00, $0E, $00, $3A, $18

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Attrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_055_716A:: ; address name
    db $68, $01, $00, $04, $00, $00, $0F, $1A, $01, $01, $00, $2A, $06, $00, $26, $0F
    db $2F, $02, $00, $7C, $07, $00, $74, $0F, $07, $00, $7C, $02, $05, $05, $00, $80
    db $08, $00, $A2, $0F, $07, $00, $7E, $0A, $00, $CA, $0F, $29, $00, $7A, $0F, $15
    db $00, $76, $04, $00, $00, $0E, $00, $3A, $18

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_71A3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1571A3, $4C

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_71EF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1571EF, $4A

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Attrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_055_7239:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157239, $50

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Attrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_055_7289:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157289, $44

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Attrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_055_72CD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1572CD, $4A

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map94Attrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_055_7317:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157317, $47

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map95Screens0::
Data_055_735E:: ; address name
    dfar Map95Screens0_Y0X0 ; entry 0
    dfar Map95Screens0_Y0X1 ; entry 1
    dfar Map95Screens0_Y1X0 ; entry 2
    dfar Map95Screens0_Y1X1 ; entry 3
    dfar Map95Screens0_Y2X0 ; entry 4
    dfar Map95Screens0_Y2X1 ; entry 5

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map95Attrs0::
Data_055_7370:: ; address name
    dfar Map95Attrs0_Y0X0 ; entry 0
    dfar Map95Attrs0_Y0X1 ; entry 1
    dfar Map95Attrs0_Y1X0 ; entry 2
    dfar Map95Attrs0_Y1X1 ; entry 3
    dfar Map95Attrs0_Y2X0 ; entry 4
    dfar Map95Attrs0_Y2X1 ; entry 5

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_7382:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157382, $C4

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_7446:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157446, $AE

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_74F4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1574F4, $A9

; LZSS-compressed asset: 178 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_759D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15759D, $B2

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Screens0_Y2X0:: ; heuristic: map screen stream; C0
Data_055_764F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15764F, $B4

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Screens0_Y2X1:: ; heuristic: map screen stream; C0
Data_055_7703:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157703, $C1

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_77C4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1577C4, $51

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_7815:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157815, $4E

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_7863:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157863, $4A

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_78AD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1578AD, $49

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Attrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_055_78F6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1578F6, $49

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map95Attrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_055_793F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15793F, $4A

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map96Screens0::
Data_055_7989:: ; address name
    dfar Map96Screens0_Y0X0 ; entry 0
    dfar Map96Screens0_Y0X1 ; entry 1
    dfar Map96Screens0_Y1X0 ; entry 2
    dfar Map96Screens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map96Attrs0::
Data_055_7995:: ; address name
    dfar Map96Attrs0_Y0X0 ; entry 0
    dfar Map96Attrs0_Y0X1 ; entry 1
    dfar Map96Attrs0_Y1X0 ; entry 2
    dfar Map96Attrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map96Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_79A1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1579A1, $B6

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map96Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_7A57:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157A57, $BE

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map96Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_7B15:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157B15, $C2

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map96Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_7BD7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157BD7, $A0

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map96Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_055_7C77:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157C77, $49

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map96Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_055_7CC0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157CC0, $53

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map96Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_055_7D13:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157D13, $4F

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map96Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_055_7D62:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $157D62, $46
    ds $258, $00
