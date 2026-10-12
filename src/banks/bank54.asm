SECTION "Bank 54", ROMX[$4000], BANK[$54]
    db $54

; compressed tileset of map $81 (the first map record using it)
; LZSS-compressed asset: 811 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map81Tileset:: ; heuristic: map tileset stream; C0
Data_054_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150001, $77

; LZSS-compressed asset: 1057 bytes expand to 1239 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_054_4078:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $150078, $2B4

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map81Palettes::
Data_054_432C:: ; address name
    dw $01D3, $7FFF, $029A, $0000 ; entry 0
    dw $300C, $35B8, $4812, $0000 ; entry 1
    dw $218C, $4F18, $3A52, $0000 ; entry 2
    dw $012E, $02DC, $01D3, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $2008, $02DC, $4810, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map81Screens0::
Data_054_436C:: ; address name
    dfar Map81Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map81Attrs0::
Data_054_436F:: ; address name
    dfar Map81Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map81Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_4372:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150372, $BA

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map81Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_442C:: ; address name
    db $68, $01, $02, $02, $FF, $FF, $19, $01, $02, $2C, $07, $02, $24, $0F, $07, $02
    db $2C, $08, $02, $34, $04, $02, $52, $0F, $05, $03, $02, $7E, $03, $02, $72, $0F
    db $0B, $02, $7E, $04, $02, $82, $02, $02, $9E, $0F, $2F, $02, $7C, $0F, $13, $02
    db $2A, $0F, $15, $02, $41, $1F, $13

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map82Screens0::
Data_054_4463:: ; address name
    dfar Map82Screens0_Y0X0 ; entry 0
    dfar Map82Screens0_Y0X1 ; entry 1
    dfar Map82Screens0_Y0X2 ; entry 2
    dfar Map82Screens0_Y1X0 ; entry 3
    dfar Map82Screens0_Y1X1 ; entry 4
    dfar Map82Screens0_Y1X2 ; entry 5
    dfar Map82Screens0_Y2X0 ; entry 6
    dfar Map82Screens0_Y2X1 ; entry 7
    dfar Map82Screens0_Y2X2 ; entry 8

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map82Attrs0::
Data_054_447E:: ; address name
    dfar Map82Attrs0_Y0X0 ; entry 0
    dfar Map82Attrs0_Y0X1 ; entry 1
    dfar Map82Attrs0_Y0X2 ; entry 2
    dfar Map82Attrs0_Y1X0 ; entry 3
    dfar Map82Attrs0_Y1X1 ; entry 4
    dfar Map82Attrs0_Y1X2 ; entry 5
    dfar Map82Attrs0_Y2X0 ; entry 6
    dfar Map82Attrs0_Y2X1 ; entry 7
    dfar Map82Attrs0_Y2X2 ; entry 8

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_4499:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150499, $CB

; LZSS-compressed asset: 273 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_4564:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150564, $111

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Screens0_Y0X2:: ; heuristic: map screen stream; C0
Data_054_4675:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150675, $D6

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_474B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15074B, $BA

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_4805:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150805, $DF

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Screens0_Y1X2:: ; heuristic: map screen stream; C0
Data_054_48E4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1508E4, $E6

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Screens0_Y2X0:: ; heuristic: map screen stream; C0
Data_054_49CA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1509CA, $AE

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Screens0_Y2X1:: ; heuristic: map screen stream; C0
Data_054_4A78:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150A78, $C2

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Screens0_Y2X2:: ; heuristic: map screen stream; C0
Data_054_4B3A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150B3A, $F7

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_4C31:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150C31, $4C

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_4C7D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150C7D, $51

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Attrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_054_4CCE:: ; address name
    db $68, $01, $02, $01, $02, $00, $0B, $02, $FC, $FF, $15, $02, $0E, $00, $02, $28
    db $0F, $01, $03, $02, $50, $09, $02, $4A, $0F, $0B, $02, $00, $04, $02, $5A, $02
    db $02, $76, $0F, $03, $02, $00, $0A, $02, $9A, $0F, $07, $02, $FE, $FA, $02, $C2
    db $0F, $33, $02, $58, $06, $02, $12, $1F, $2F

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_4D07:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150D07, $49

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_4D50:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150D50, $44

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Attrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_054_4D94:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150D94, $55

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Attrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_054_4DE9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150DE9, $47

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Attrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_054_4E30:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150E30, $46

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map82Attrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_054_4E76:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150E76, $51

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map83Screens0::
Data_054_4EC7:: ; address name
    dfar Map83Screens0_Y0X0 ; entry 0
    dfar Map83Screens0_Y0X1 ; entry 1
    dfar Map83Screens0_Y0X2 ; entry 2
    dfar Map83Screens0_Y1X0 ; entry 3
    dfar Map83Screens0_Y1X1 ; entry 4
    dfar Map83Screens0_Y1X2 ; entry 5
    dfar Map83Screens0_Y2X0 ; entry 6
    dfar Map83Screens0_Y2X1 ; entry 7
    dfar Map83Screens0_Y2X2 ; entry 8

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map83Attrs0::
Data_054_4EE2:: ; address name
    dfar Map83Attrs0_Y0X0 ; entry 0
    dfar Map83Attrs0_Y0X1 ; entry 1
    dfar Map83Attrs0_Y0X2 ; entry 2
    dfar Map83Attrs0_Y1X0 ; entry 3
    dfar Map83Attrs0_Y1X1 ; entry 4
    dfar Map83Attrs0_Y1X2 ; entry 5
    dfar Map83Attrs0_Y2X0 ; entry 6
    dfar Map83Attrs0_Y2X1 ; entry 7
    dfar Map83Attrs0_Y2X2 ; entry 8

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_4EFD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150EFD, $BE

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_4FBB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $150FBB, $E0

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Screens0_Y0X2:: ; heuristic: map screen stream; C0
Data_054_509B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15109B, $C1

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_515C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15115C, $D0

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_522C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15122C, $E9

; LZSS-compressed asset: 144 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Screens0_Y1X2:: ; heuristic: map screen stream; C0
Data_054_5315:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $151315, $90

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Screens0_Y2X0:: ; heuristic: map screen stream; C0
Data_054_53A5:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 195 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Screens0_Y2X1:: ; heuristic: map screen stream; C0
Data_054_53B8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1513B8, $C3

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Screens0_Y2X2:: ; heuristic: map screen stream; C0
Data_054_547B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15147B, $57

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_54D2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1514D2, $4C

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_551E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15151E, $57

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Attrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_054_5575:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $151575, $47

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_55BC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1515BC, $50

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_560C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15160C, $5A

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Attrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_054_5666:: ; address name
    db $68, $01, $02, $00, $00, $01, $02, $02, $01, $02, $F4, $FF, $35, $02, $02, $00
    db $03, $03, $02, $42, $0F, $39, $03, $03, $02, $90, $0F, $11, $02, $A2, $00, $02
    db $B8, $0F, $15, $02, $04, $0C, $02, $F0, $0F, $01, $02, $02, $0F, $15, $02, $3F
    db $1F, $15

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Attrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_054_5698:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Attrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_054_56AB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1516AB, $4C

; LZSS-compressed asset: 35 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map83Attrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_054_56F7:: ; address name
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $40, $0F, $2D, $01, $02, $A0, $0D, $02
    db $9E, $0F, $2B, $03, $02, $F0, $0B, $02, $EC, $0F, $05, $02, $A0, $0F, $15, $02
    db $3F, $1F, $15

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map84Screens0::
Data_054_571A:: ; address name
    dfar Map84Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map84Attrs0::
Data_054_571D:: ; address name
    dfar Map84Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 234 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map84Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_5720:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $151720, $EA

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map84Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_580A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15180A, $4C

; compressed tileset of map $85 (the first map record using it)
; LZSS-compressed asset: 1231 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map85Tileset:: ; heuristic: map tileset stream; C0
Data_054_5856:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $151856, $4CF

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map85Palettes::
Data_054_5D25:: ; address name
    dw $7DA0, $7FFF, $01D3, $0063 ; entry 0
    dw $48EC, $6BFF, $4A6F, $0000 ; entry 1
    dw $28CB, $4E11, $316F, $0C66 ; entry 2
    dw $50C6, $7E94, $7D4A, $0084 ; entry 3
    dw $0014, $03FE, $01BF, $0000 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $28CB, $4E11, $316F, $0C66 ; entry 6
    dw $350E, $773C, $4616, $0C69 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map85Screens0::
Data_054_5D65:: ; address name
    dfar Map85Screens0_Y0X0 ; entry 0
    dfar Map85Screens0_Y0X1 ; entry 1
    dfar Map85Screens0_Y1X0 ; entry 2
    dfar Map85Screens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map85Attrs0::
Data_054_5D71:: ; address name
    dfar Map85Attrs0_Y0X0 ; entry 0
    dfar Map85Attrs0_Y0X1 ; entry 1
    dfar Map85Attrs0_Y1X0 ; entry 2
    dfar Map85Attrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map85Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_5D7D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $151D7D, $E8

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map85Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_5E65:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $151E65, $E4

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map85Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_5F49:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $151F49, $F3

; LZSS-compressed asset: 272 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map85Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_603C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15203C, $110

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map85Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_614C:: ; address name
    db $68, $01, $00, $02, $00, $00, $0F, $1C, $01, $01, $00, $2E, $02, $00, $24, $0F
    db $31, $01, $00, $7C, $07, $00, $74, $0F, $07, $00, $7C, $08, $00, $84, $04, $00
    db $A2, $0F, $4D, $00, $DA, $0F, $19, $00, $7A, $0F, $13

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map85Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_6177:: ; address name
    db $68, $01, $00, $02, $00, $00, $0F, $44, $01, $01, $04, $04, $01, $01, $00, $4A
    db $0F, $0D, $01, $00, $7E, $05, $00, $74, $0F, $09, $00, $7E, $06, $00, $84, $06
    db $00, $A4, $0F, $01, $00, $52, $04, $00, $CE, $06, $00, $CA, $0F, $0F, $00, $4A
    db $0C, $00, $FC, $0F, $25, $00, $C0, $0E, $00, $46, $1A

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map85Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_61B2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1521B2, $5E

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map85Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_6210:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152210, $53

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map86Screens0::
Data_054_6263:: ; address name
    dfar Map86Screens0_Y0X0 ; entry 0
    dfar Map86Screens0_Y0X1 ; entry 1
    dfar Map86Screens0_Y1X0 ; entry 2
    dfar Map86Screens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map86Attrs0::
Data_054_626F:: ; address name
    dfar Map86Attrs0_Y0X0 ; entry 0
    dfar Map86Attrs0_Y0X1 ; entry 1
    dfar Map86Attrs0_Y1X0 ; entry 2
    dfar Map86Attrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map86Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_627B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15227B, $F9

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map86Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_6374:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152374, $F8

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map86Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_646C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15246C, $E0

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map86Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_654C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15254C, $D8

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map86Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_6624:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152624, $48

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map86Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_666C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15266C, $4D

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map86Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_66B9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1526B9, $5A

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map86Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_6713:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152713, $60

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map87Screens0::
Data_054_6773:: ; address name
    dfar Map87Screens0_Y0X0 ; entry 0
    dfar Map87Screens0_Y0X1 ; entry 1
    dfar Map87Screens0_Y1X0 ; entry 2
    dfar Map87Screens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map87Attrs0::
Data_054_677F:: ; address name
    dfar Map87Attrs0_Y0X0 ; entry 0
    dfar Map87Attrs0_Y0X1 ; entry 1
    dfar Map87Attrs0_Y1X0 ; entry 2
    dfar Map87Attrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 195 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map87Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_678B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15278B, $C3

; LZSS-compressed asset: 250 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map87Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_684E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15284E, $FA

; LZSS-compressed asset: 210 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map87Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_6948:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152948, $D2

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map87Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_6A1A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152A1A, $CB

; LZSS-compressed asset: 104 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map87Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_6AE5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152AE5, $68

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map87Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_6B4D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152B4D, $64

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map87Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_6BB1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152BB1, $65

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map87Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_6C16:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152C16, $59

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map88Screens0::
Data_054_6C6F:: ; address name
    dfar Map88Screens0_Y0X0 ; entry 0
    dfar Map88Screens0_Y0X1 ; entry 1
    dfar Map88Screens0_Y1X0 ; entry 2
    dfar Map88Screens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map88Attrs0::
Data_054_6C7B:: ; address name
    dfar Map88Attrs0_Y0X0 ; entry 0
    dfar Map88Attrs0_Y0X1 ; entry 1
    dfar Map88Attrs0_Y1X0 ; entry 2
    dfar Map88Attrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 167 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map88Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_6C87:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152C87, $A7

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map88Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_6D2E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152D2E, $CB

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map88Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_6DF9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152DF9, $9B

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map88Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_6E94:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152E94, $C6

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map88Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_6F5A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152F5A, $5B

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map88Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_054_6FB5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $152FB5, $4E

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map88Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_054_7003:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $153003, $50

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map88Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_054_7053:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $153053, $62

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8AScreens0::
Data_054_70B5:: ; address name
    dfar Map8AScreens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8AAttrs0::
Data_054_70B8:: ; address name
    dfar Map8AAttrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 315 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8AScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_70BB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1530BB, $13B

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8AAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_71F6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1531F6, $54

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map8BPalettes::
Data_054_724A:: ; address name
    dw $192C, $7FFF, $45F2, $0000 ; entry 0
    dw $4CA9, $5B7F, $4D8C, $0000 ; entry 1
    dw $240F, $7FFF, $45F2, $0000 ; entry 2
    dw $2940, $45F2, $4D8C, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of map $8D (the first map record using it)
; LZSS-compressed asset: 994 bytes expand to 1216 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8DTileset:: ; heuristic: map tileset stream; C0
Data_054_728A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $15328A, $3E2

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map8DPalettes::
Data_054_766C:: ; address name
    dw $192C, $7FFF, $45F2, $0000 ; entry 0
    dw $4CA9, $5B7F, $4D8C, $0000 ; entry 1
    dw $240F, $7FFF, $45F2, $0000 ; entry 2
    dw $2940, $45F2, $4D8C, $0000 ; entry 3
    dw $18C6, $03FF, $45F2, $0000 ; entry 4
    dw $18C6, $7FFF, $45F2, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8DScreens0::
Data_054_76AC:: ; address name
    dfar Map8DScreens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8DAttrs0::
Data_054_76AF:: ; address name
    dfar Map8DAttrs0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8DScreens1::
Data_054_76B2:: ; address name
    dfar Map8DScreens1_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8DAttrs1::
Data_054_76B5:: ; address name
    dfar Map8DAttrs1_Y0X0 ; entry 0

; LZSS-compressed asset: 282 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8DScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_76B8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1536B8, $11A

; LZSS-compressed asset: 272 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8DScreens1_Y0X0:: ; heuristic: map screen stream; C0
Data_054_77D2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1537D2, $110

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8DAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_78E2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1538E2, $47

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8DAttrs1_Y0X0:: ; heuristic: map screen stream; C0
Data_054_7929:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $153929, $47

; compressed tileset of map $91 (the first map record using it)
; LZSS-compressed asset: 1000 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map91Tileset:: ; heuristic: map tileset stream; C0
Data_054_7970:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $153970, $3E8

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map91Palettes::
Data_054_7D58:: ; address name
    dw $240F, $7FFF, $45F2, $0000 ; entry 0
    dw $4CA9, $5B7F, $4D8C, $0000 ; entry 1
    dw $240F, $2BFF, $023F, $0000 ; entry 2
    dw $2940, $45F2, $4D8C, $0000 ; entry 3
    dw $240F, $023F, $18C6, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $2940, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map91Screens0::
Data_054_7D98:: ; address name
    dfar Map91Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map91Attrs0::
Data_054_7D9B:: ; address name
    dfar Map91Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 297 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map91Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_7D9E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $153D9E, $129

; LZSS-compressed asset: 111 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map91Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_054_7EC7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $153EC7, $6F
    ds $CA, $00
