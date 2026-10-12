SECTION "Bank 4B", ROMX[$4000], BANK[$4B]
    db $4B

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map26Screens0::
Data_04B_4001:: ; address name
    dfar Map26Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map26Attrs0::
Data_04B_4004:: ; address name
    dfar Map26Attrs0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map26Screens1::
Data_04B_4007:: ; address name
    dfar Map26Screens1_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map26Attrs1::
Data_04B_400A:: ; address name
    dfar Map26Attrs1_Y0X0 ; entry 0

; LZSS-compressed asset: 271 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map26Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_400D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12C00D, $10F

; LZSS-compressed asset: 199 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map26Screens1_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_411C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12C11C, $C7

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map26Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_41E3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12C1E3, $65

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map26Attrs1_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_4248:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12C248, $4A

; compressed tileset of map $28 (the first map record using it)
; LZSS-compressed asset: 877 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map28Tileset:: ; heuristic: map tileset stream; C0
Data_04B_4292:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12C292, $36D

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map28Screens0::
Data_04B_45FF:: ; address name
    dfar Map28Screens0_Y0X0 ; entry 0
    dfar Map28Screens0_Y1X0 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map28Attrs0::
Data_04B_4605:: ; address name
    dfar Map28Attrs0_Y0X0 ; entry 0
    dfar Map28Attrs0_Y1X0 ; entry 1

; LZSS-compressed asset: 266 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map28Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_460B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12C60B, $10A

; LZSS-compressed asset: 252 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map28Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_04B_4715:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12C715, $FC

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map28Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_4811:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12C811, $65

; LZSS-compressed asset: 102 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map28Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_04B_4876:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12C876, $66

; compressed tileset of map $2B (the first map record using it)
; LZSS-compressed asset: 1355 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BTileset:: ; heuristic: map tileset stream; C0
Data_04B_48DC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12C8DC, $54B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map2BPalettes::
Data_04B_4E27:: ; address name
    dw $7C01, $7FFF, $6301, $0000 ; entry 0
    dw $1528, $2B3F, $15AE, $0000 ; entry 1
    dw $0188, $4FBF, $01D3, $0000 ; entry 2
    dw $012F, $2B3F, $01D8, $0000 ; entry 3
    dw $1528, $3695, $15AE, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0CA5 ; entry 6
    dw $218C, $4F18, $3A52, $0CA5 ; entry 7

; E-0142 (derived: 16 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2BScreens0::
Data_04B_4E67:: ; address name
    dfar Map2BScreens0_Y0X0 ; entry 0
    dfar Map2BScreens0_Y0X0 ; entry 1
    dfar Map2BScreens0_Y0X0 ; entry 2
    dfar Map2BScreens0_Y0X0 ; entry 3
    dfar Map2BScreens0_Y1X0 ; entry 4
    dfar Map2BScreens0_Y1X1 ; entry 5
    dfar Map2BScreens0_Y1X2 ; entry 6
    dfar Map2BScreens0_Y0X0 ; entry 7
    dfar Map2BScreens0_Y2X0 ; entry 8
    dfar Map2BScreens0_Y2X1 ; entry 9
    dfar Map2BScreens0_Y2X2 ; entry 10
    dfar Map2BScreens0_Y0X0 ; entry 11
    dfar Map2BScreens0_Y3X0 ; entry 12
    dfar Map2BScreens0_Y3X1 ; entry 13
    dfar Map2BScreens0_Y3X2 ; entry 14
    dfar Map2BScreens0_Y3X3 ; entry 15

; E-0142 (derived: 16 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2BAttrs0::
Data_04B_4E97:: ; address name
    dfar Map2BAttrs0_Y0X0 ; entry 0
    dfar Map2BAttrs0_Y0X0 ; entry 1
    dfar Map2BAttrs0_Y0X0 ; entry 2
    dfar Map2BAttrs0_Y0X0 ; entry 3
    dfar Map2BAttrs0_Y1X0 ; entry 4
    dfar Map2BAttrs0_Y1X1 ; entry 5
    dfar Map2BAttrs0_Y1X2 ; entry 6
    dfar Map2BAttrs0_Y0X0 ; entry 7
    dfar Map2BAttrs0_Y2X0 ; entry 8
    dfar Map2BAttrs0_Y2X1 ; entry 9
    dfar Map2BAttrs0_Y2X2 ; entry 10
    dfar Map2BAttrs0_Y0X0 ; entry 11
    dfar Map2BAttrs0_Y3X0 ; entry 12
    dfar Map2BAttrs0_Y3X1 ; entry 13
    dfar Map2BAttrs0_Y3X2 ; entry 14
    dfar Map2BAttrs0_Y3X3 ; entry 15

; E-0142 (derived: 16 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2BScreens2::
Data_04B_4EC7:: ; address name
    dfar Map2BScreens0_Y0X0 ; entry 0
    dfar Map2BScreens0_Y0X0 ; entry 1
    dfar Map2BScreens0_Y0X0 ; entry 2
    dfar Map2BScreens0_Y0X0 ; entry 3
    dfar Map2BScreens0_Y1X0 ; entry 4
    dfar Map2BScreens0_Y1X1 ; entry 5
    dfar Map2BScreens0_Y1X2 ; entry 6
    dfar Map2BScreens0_Y0X0 ; entry 7
    dfar Map2BScreens0_Y2X0 ; entry 8
    dfar Map2BScreens2_Y2X1 ; entry 9
    dfar Map2BScreens0_Y2X2 ; entry 10
    dfar Map2BScreens0_Y0X0 ; entry 11
    dfar Map2BScreens0_Y3X0 ; entry 12
    dfar Map2BScreens2_Y3X1 ; entry 13
    dfar Map2BScreens2_Y3X2 ; entry 14
    dfar Map2BScreens2_Y3X3 ; entry 15

; E-0142 (derived: 16 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2BAttrs2::
Data_04B_4EF7:: ; address name
    dfar Map2BAttrs0_Y0X0 ; entry 0
    dfar Map2BAttrs0_Y0X0 ; entry 1
    dfar Map2BAttrs0_Y0X0 ; entry 2
    dfar Map2BAttrs0_Y0X0 ; entry 3
    dfar Map2BAttrs0_Y1X0 ; entry 4
    dfar Map2BAttrs0_Y1X1 ; entry 5
    dfar Map2BAttrs0_Y1X2 ; entry 6
    dfar Map2BAttrs0_Y0X0 ; entry 7
    dfar Map2BAttrs0_Y2X0 ; entry 8
    dfar Map2BAttrs2_Y2X1 ; entry 9
    dfar Map2BAttrs0_Y2X2 ; entry 10
    dfar Map2BAttrs0_Y0X0 ; entry 11
    dfar Map2BAttrs0_Y3X0 ; entry 12
    dfar Map2BAttrs2_Y3X1 ; entry 13
    dfar Map2BAttrs2_Y3X2 ; entry 14
    dfar Map2BAttrs2_Y3X3 ; entry 15

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_4F27:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12CF27, $A9

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_04B_4FD0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12CFD0, $C9

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y1X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_04B_5099:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D099, $B3

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y1X2:: ; heuristic: map screen stream; C0
Data_04B_514C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D14C, $A6

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y2X0:: ; heuristic: map screen stream; C0
Data_04B_51F2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D1F2, $C4

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y2X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_04B_52B6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D2B6, $C4

; LZSS-compressed asset: 163 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens2_Y2X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_04B_537A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D37A, $A3

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y2X2:: ; heuristic: map screen stream; C0
Data_04B_541D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D41D, $B4

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y3X0:: ; heuristic: map screen stream; C0
Data_04B_54D1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D4D1, $F6

; LZSS-compressed asset: 242 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y3X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_04B_55C7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D5C7, $F2

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens2_Y3X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_04B_56B9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D6B9, $CD

; LZSS-compressed asset: 121 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y3X2:: ; heuristic: map screen stream; C0
Data_04B_5786:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D786, $79

; LZSS-compressed asset: 117 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens2_Y3X2:: ; heuristic: map screen stream; C0
Data_04B_57FF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D7FF, $75

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens0_Y3X3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_04B_5874:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D874, $DE

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BScreens2_Y3X3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_04B_5952:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12D952, $DD

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_5A2F:: ; address name
    db $68, $01, $01, $02, $01, $00, $0F, $18, $04, $04, $01, $F6, $FE, $01, $2C, $0E
    db $04, $04, $01, $2C, $08, $04, $04, $01, $4E, $0F, $31, $01, $2C, $06, $01, $9C
    db $0F, $0D, $01, $2C, $04, $01, $C4, $0F, $4D, $01, $FC, $0F, $1D

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_04B_5A5C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DA5C, $5D

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_04B_5AB9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DAB9, $42

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_04B_5AFB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DAFB, $5E

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_04B_5B59:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DB59, $56

; LZSS-compressed asset: 102 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_04B_5BAF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DBAF, $66

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs2_Y2X1:: ; heuristic: map screen stream; C0
Data_04B_5C15:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DC15, $4D

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_04B_5C62:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DC62, $43

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y3X0:: ; heuristic: map screen stream; C0
Data_04B_5CA5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DCA5, $5C

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y3X1:: ; heuristic: map screen stream; C0
Data_04B_5D01:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DD01, $77

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs2_Y3X1:: ; heuristic: map screen stream; C0
Data_04B_5D78:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DD78, $4F

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y3X2:: ; heuristic: map screen stream; C0
Data_04B_5DC7:: ; address name
    db $68, $01, $01, $01, $FF, $FF, $15, $02, $01, $28, $0F, $44, $04, $01, $80, $01
    db $01, $72, $0F, $07, $01, $20, $0A, $01, $1A, $0F, $01, $01, $FF, $F2, $01, $80
    db $02, $01, $CD, $0F, $4D, $01, $E0, $0E, $01, $28, $0F, $15

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs2_Y3X2:: ; heuristic: map screen stream; C0
Data_04B_5DF3:: ; address name
    db $68, $01, $01, $01, $FF, $FF, $15, $02, $01, $28, $0F, $3C, $01, $FF, $F4, $04
    db $01, $80, $01, $01, $FF, $FA, $01, $80, $0F, $01, $01, $E0, $FF, $35, $01, $80
    db $02, $01, $F0, $0F, $37, $01, $50, $0F, $15

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs0_Y3X3:: ; heuristic: map screen stream; C0
Data_04B_5E1C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DE1C, $41

; LZSS-compressed asset: 752 bytes expand to 770 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Gfx_4B_5E5D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_04B_5E5D:: ; address name
    db $02, $03, $F0, $0F, $0D, $03, $9C, $04, $03, $90, $0F, $05, $03, $30, $08, $03
    db $3C, $1F, $05

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2BAttrs2_Y3X3:: ; heuristic: map screen stream; C0
Data_04B_5E70:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DE70, $51

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2EScreens0::
Data_04B_5EC1:: ; address name
    dfar Map2EScreens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2EAttrs0::
Data_04B_5EC4:: ; address name
    dfar Map2EAttrs0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2EScreens3::
Data_04B_5EC7:: ; address name
    dfar Map2EScreens3_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2EAttrs3::
Data_04B_5ECA:: ; address name
    dfar Map2EAttrs3_Y0X0 ; entry 0

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2EScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_5ECD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DECD, $BD

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2EScreens3_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_5F8A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12DF8A, $BD

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2EAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_6047:: ; address name
    db $68, $01, $00, $01, $01, $01, $01, $03, $00, $04, $07, $00, $00, $00, $00, $00
    db $0F, $07, $05, $00, $2E, $03, $00, $22, $0F, $0F, $00, $00, $00, $00, $48, $0F
    db $0B, $00, $0A, $06, $00, $7A, $0F, $35, $00, $10, $04, $00, $C6, $06, $00, $CA
    db $0F, $4D, $00, $00, $0C, $00, $7C, $0A, $00, $06, $08

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2EAttrs3_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_6082:: ; address name
    db $68, $01, $00, $01, $01, $01, $01, $03, $00, $04, $07, $00, $00, $00, $00, $00
    db $0F, $07, $05, $00, $2E, $03, $00, $22, $0F, $0F, $00, $00, $00, $00, $48, $0F
    db $0B, $00, $0A, $06, $00, $7A, $0F, $35, $00, $10, $04, $00, $C6, $06, $00, $CA
    db $0F, $4D, $00, $00, $0C, $00, $7C, $0A, $00, $06, $08

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map39Screens0::
Data_04B_60BD:: ; address name
    dfar Map39Screens0_Y0X0 ; entry 0
    dfar Map39Screens0_Y0X1 ; entry 1
    dfar Map39Screens0_Y0X2 ; entry 2
    dfar Map39Screens0_Y0X3 ; entry 3
    dfar Map39Screens0_Y1X0 ; entry 4
    dfar Map39Screens0_Y1X1 ; entry 5
    dfar Map39Screens0_Y1X2 ; entry 6
    dfar Map39Screens0_Y1X3 ; entry 7
    dfar Map39Screens0_Y2X0 ; entry 8
    dfar Map39Screens0_Y2X1 ; entry 9
    dfar Map39Screens0_Y2X2 ; entry 10
    dfar Map39Screens0_Y2X3 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map39Attrs0::
Data_04B_60E1:: ; address name
    dfar Map39Attrs0_Y0X0 ; entry 0
    dfar Map39Attrs0_Y0X1 ; entry 1
    dfar Map39Attrs0_Y0X2 ; entry 2
    dfar Map39Attrs0_Y0X3 ; entry 3
    dfar Map39Attrs0_Y1X0 ; entry 4
    dfar Map39Attrs0_Y1X1 ; entry 5
    dfar Map39Attrs0_Y1X2 ; entry 6
    dfar Map39Attrs0_Y1X3 ; entry 7
    dfar Map39Attrs0_Y2X0 ; entry 8
    dfar Map39Attrs0_Y2X1 ; entry 9
    dfar Map39Attrs0_Y2X2 ; entry 10
    dfar Map39Attrs0_Y2X3 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map39Screens3::
Data_04B_6105:: ; address name
    dfar Map39Screens0_Y0X0 ; entry 0
    dfar Map39Screens0_Y0X1 ; entry 1
    dfar Map39Screens0_Y0X2 ; entry 2
    dfar Map39Screens0_Y0X3 ; entry 3
    dfar Map39Screens0_Y1X0 ; entry 4
    dfar Map39Screens3_Y1X1 ; entry 5
    dfar Map39Screens0_Y1X2 ; entry 6
    dfar Map39Screens0_Y1X3 ; entry 7
    dfar Map39Screens0_Y2X0 ; entry 8
    dfar Map39Screens0_Y2X1 ; entry 9
    dfar Map39Screens0_Y2X2 ; entry 10
    dfar Map39Screens0_Y2X3 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map39Attrs3::
Data_04B_6129:: ; address name
    dfar Map39Attrs0_Y0X0 ; entry 0
    dfar Map39Attrs0_Y0X1 ; entry 1
    dfar Map39Attrs0_Y0X2 ; entry 2
    dfar Map39Attrs0_Y0X3 ; entry 3
    dfar Map39Attrs0_Y1X0 ; entry 4
    dfar Map39Attrs3_Y1X1 ; entry 5
    dfar Map39Attrs0_Y1X2 ; entry 6
    dfar Map39Attrs0_Y1X3 ; entry 7
    dfar Map39Attrs0_Y2X0 ; entry 8
    dfar Map39Attrs0_Y2X1 ; entry 9
    dfar Map39Attrs0_Y2X2 ; entry 10
    dfar Map39Attrs0_Y2X3 ; entry 11

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_614D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E14D, $CD

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_04B_621A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E21A, $59

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y0X2:: ; heuristic: map screen stream; C0
Data_04B_6273:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E273, $56

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y0X3:: ; heuristic: map screen stream; C0
Data_04B_62C9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E2C9, $B3

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_04B_637C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E37C, $DA

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_04B_6456:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E456, $BA

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens3_Y1X1:: ; heuristic: map screen stream; C0
Data_04B_6510:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E510, $E9

; LZSS-compressed asset: 210 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y1X2:: ; heuristic: map screen stream; C0
Data_04B_65F9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E5F9, $D2

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y1X3:: ; heuristic: map screen stream; C0
Data_04B_66CB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E6CB, $84

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y2X0:: ; heuristic: map screen stream; C0
Data_04B_674F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E74F, $65

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y2X1:: ; heuristic: map screen stream; C0
Data_04B_67B4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E7B4, $C8

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y2X2:: ; heuristic: map screen stream; C0
Data_04B_687C:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Screens0_Y2X3:: ; heuristic: map screen stream; C0
Data_04B_688F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E88F, $B4

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_6943:: ; address name
    db $68, $01, $02, $02, $FF, $FF, $19, $01, $02, $2C, $07, $02, $24, $0F, $07, $02
    db $2C, $00, $03, $02, $56, $03, $02, $32, $04, $02, $52, $0F, $03, $02, $56, $04
    db $02, $56, $04, $02, $78, $0F, $4D, $02, $88, $04, $02, $54, $0F, $13, $02, $50
    db $06, $02, $34, $0C, $02, $20, $1C, $02, $8C, $04, $02, $3A, $18, $02, $44, $1C

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_04B_6983:: ; address name
    db $68, $01, $02, $02, $FF, $FF, $3D, $01, $02, $50, $05, $02, $46, $0F, $0B, $03
    db $02, $78, $03, $02, $6C, $0F, $4D, $02, $90, $0C, $02, $50, $0F, $15, $02, $17
    db $1F, $3D

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_04B_69A5:: ; address name
    db $68, $01, $02, $02, $FF, $FF, $43, $01, $02, $56, $03, $02, $4A, $0F, $0F, $03
    db $03, $03, $03, $02, $70, $0F, $4D, $02, $D0, $0F, $4D, $02, $08, $1F, $11

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y0X3:: ; heuristic: map screen stream; C0
Data_04B_69C4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12E9C4, $48

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_04B_6A0C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EA0C, $53

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_04B_6A5F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EA5F, $43

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs3_Y1X1:: ; heuristic: map screen stream; C0
Data_04B_6AA2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EAA2, $50

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_04B_6AF2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EAF2, $4B

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y1X3:: ; heuristic: map screen stream; C0
Data_04B_6B3D:: ; address name
    db $68, $01, $02, $00, $00, $01, $01, $02, $F6, $FE, $02, $02, $0F, $35, $01, $01
    db $02, $4C, $0F, $09, $02, $02, $04, $02, $7A, $0F, $0F, $02, $74, $0F, $01, $02
    db $A6, $0F, $07, $03, $03, $02, $C2, $0F, $0B, $03, $03, $03, $03, $02, $E4, $0F
    db $05, $02, $00, $06, $02, $06, $1F, $03, $02, $F8, $FE, $02, $2E, $1F, $13

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_04B_6B7C:: ; address name
    db $68, $01, $02, $02, $FF, $FF, $41, $01, $02, $54, $0B, $02, $50, $0F, $07, $03
    db $02, $7E, $09, $02, $78, $0F, $4D, $02, $88, $06, $02, $56, $0F, $13, $02, $1B
    db $1F, $39

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_04B_6B9E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EB9E, $42

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_04B_6BE0:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map39Attrs0_Y2X3:: ; heuristic: map screen stream; C0
Data_04B_6BF3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EBF3, $59

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3AScreens0::
Data_04B_6C4C:: ; address name
    dfar Map3AScreens0_Y0X0 ; entry 0
    dfar Map3AScreens0_Y0X1 ; entry 1
    dfar Map3AScreens0_Y0X2 ; entry 2
    dfar Map3AScreens0_Y1X0 ; entry 3
    dfar Map3AScreens0_Y1X1 ; entry 4
    dfar Map3AScreens0_Y1X2 ; entry 5
    dfar Map3AScreens0_Y2X0 ; entry 6
    dfar Map3AScreens0_Y2X1 ; entry 7
    dfar Map3AScreens0_Y2X2 ; entry 8

; E-0142 (derived: 9 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3AAttrs0::
Data_04B_6C67:: ; address name
    dfar Map3AAttrs0_Y0X0 ; entry 0
    dfar Map3AAttrs0_Y0X1 ; entry 1
    dfar Map3AAttrs0_Y0X2 ; entry 2
    dfar Map3AAttrs0_Y1X0 ; entry 3
    dfar Map3AAttrs0_Y1X1 ; entry 4
    dfar Map3AAttrs0_Y1X2 ; entry 5
    dfar Map3AAttrs0_Y2X0 ; entry 6
    dfar Map3AAttrs0_Y2X1 ; entry 7
    dfar Map3AAttrs0_Y2X2 ; entry 8

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_6C82:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EC82, $76

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AScreens0_Y0X1:: ; heuristic: map screen stream; C0
Data_04B_6CF8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12ECF8, $D1

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AScreens0_Y0X2:: ; heuristic: map screen stream; C0
Data_04B_6DC9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EDC9, $D0

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_04B_6E99:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EE99, $AD

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AScreens0_Y1X1:: ; heuristic: map screen stream; C0
Data_04B_6F46:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EF46, $B3

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AScreens0_Y1X2:: ; heuristic: map screen stream; C0
Data_04B_6FF9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12EFF9, $50

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AScreens0_Y2X0:: ; heuristic: map screen stream; C0
Data_04B_7049:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12F049, $93

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AScreens0_Y2X1:: ; heuristic: map screen stream; C0
Data_04B_70DC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12F0DC, $AE

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AScreens0_Y2X2:: ; heuristic: map screen stream; C0
Data_04B_718A:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04B_719D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12F19D, $48

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AAttrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_04B_71E5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12F1E5, $47

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AAttrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_04B_722C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12F22C, $58

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_04B_7284:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12F284, $4A

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AAttrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_04B_72CE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12F2CE, $45

; LZSS-compressed asset: 35 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AAttrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_04B_7313:: ; address name
    db $68, $01, $02, $02, $FF, $FF, $3D, $01, $02, $50, $07, $02, $48, $0F, $09, $03
    db $02, $78, $05, $02, $6E, $0F, $33, $02, $50, $0F, $15, $02, $EF, $0F, $4D, $02
    db $4F, $1F, $05

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AAttrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_04B_7336:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12F336, $50

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AAttrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_04B_7386:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12F386, $41

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3AAttrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_04B_73C7:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35
    ds $C26, $00
