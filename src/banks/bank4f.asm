SECTION "Bank 4F", ROMX[$4000], BANK[$4F]
    db $4F

; compressed tileset of map $5A (the first map record using it)
; LZSS-compressed asset: 907 bytes expand to 1248 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5ATileset:: ; heuristic: map tileset stream; C0
Data_04F_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13C001, $38B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map5APalettes::
Data_04F_438C:: ; address name
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $218C, $17E5, $0301, $0000 ; entry 1
    dw $012F, $7FFF, $029A, $0000 ; entry 2
    dw $0160, $7FFF, $5AB1, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5AScreens0::
Data_04F_43CC:: ; address name
    dfar Map5AScreens0_Y0X0 ; entry 0
    dfar Map5AScreens0_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5AAttrs0::
Data_04F_43D2:: ; address name
    dfar Map5AAttrs0_Y0X0 ; entry 0
    dfar Map5AAttrs0_Y0X1 ; entry 1

; LZSS-compressed asset: 242 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5AScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_43D8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13C3D8, $F2

; LZSS-compressed asset: 267 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5AScreens0_Y0X1:: ; heuristic: map screen stream; C0
Data_04F_44CA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13C4CA, $10B

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5AAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_45D5:: ; address name
    db $68, $01, $02, $02, $FF, $FF, $0D, $01, $01, $02, $FF, $F2, $03, $03, $02, $16
    db $0F, $1B, $02, $20, $00, $02, $48, $0F, $09, $02, $18, $0A, $02, $70, $0A, $02
    db $80, $08, $02, $50, $08, $02, $98, $0F, $09, $02, $C7, $0F, $4D, $02, $FF, $FF
    db $05, $02, $28, $08, $02, $22, $04, $02, $40, $1F, $01

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5AAttrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_04F_4610:: ; address name
    db $68, $01, $01, $01, $FF, $FF, $27, $03, $03, $01, $28, $0F, $13, $01, $12, $0F
    db $3D, $01, $3A, $0F, $0F, $02, $02, $01, $FF, $FE, $01, $D4, $0F, $01, $01, $10
    db $0F, $1B, $01, $3A, $0C, $01, $26, $12, $01, $3E, $10, $01, $2E, $0A, $01, $3E
    db $1F, $03

; compressed tileset of map $5B (the first map record using it)
; LZSS-compressed asset: 1477 bytes expand to 1728 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5BTileset:: ; heuristic: map tileset stream; C0
Data_04F_4642:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13C642, $5C5

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map5BPalettes::
Data_04F_4C07:: ; address name
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $00ED, $22BA, $11D4, $0000 ; entry 1
    dw $0160, $22BA, $02C0, $0000 ; entry 2
    dw $0160, $7FFF, $5AB1, $0000 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5BScreens0::
Data_04F_4C47:: ; address name
    dfar Map5BScreens0_Y0X0 ; entry 0
    dfar Map5BScreens0_Y0X1 ; entry 1
    dfar Map5BScreens0_Y1X0 ; entry 2
    dfar Map5BScreens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5BAttrs0::
Data_04F_4C53:: ; address name
    dfar Map5BAttrs0_Y0X0 ; entry 0
    dfar Map5BAttrs0_Y0X1 ; entry 1
    dfar Map5BAttrs0_Y1X0 ; entry 2
    dfar Map5BAttrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 260 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5BScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_4C5F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13CC5F, $104

; LZSS-compressed asset: 238 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5BScreens0_Y0X1:: ; heuristic: map screen stream; C0
Data_04F_4D63:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13CD63, $EE

; LZSS-compressed asset: 242 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5BScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_04F_4E51:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13CE51, $F2

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5BScreens0_Y1X1:: ; heuristic: map screen stream; C0
Data_04F_4F43:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13CF43, $E4

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5BAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_5027:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13D027, $55

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5BAttrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_04F_507C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13D07C, $4A

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5BAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_04F_50C6:: ; address name
    db $68, $01, $02, $02, $FF, $F8, $03, $03, $03, $03, $02, $FC, $FF, $07, $01, $02
    db $2A, $03, $02, $1E, $0F, $0D, $04, $02, $52, $01, $02, $30, $04, $02, $0C, $02
    db $02, $52, $0F, $07, $04, $04, $02, $6E, $0F, $17, $02, $FF, $F6, $02, $A2, $0F
    db $4B, $02, $30, $00, $02, $B4, $0F, $0D, $02, $2C, $04, $02, $3F, $1F, $15

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5BAttrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_04F_5105:: ; address name
    db $68, $01, $01, $01, $FF, $F4, $03, $03, $03, $03, $01, $F8, $FF, $0D, $01, $08
    db $04, $01, $08, $08, $01, $2C, $0C, $01, $0A, $0C, $01, $0A, $00, $01, $50, $0F
    db $11, $01, $4C, $0F, $01, $01, $DA, $FF, $1D, $01, $80, $0E, $01, $CA, $0F, $29
    db $01, $06, $08, $01, $36, $0E, $01, $8A, $0F, $1D

; compressed tileset of map $5C (the first map record using it)
; LZSS-compressed asset: 1022 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5CTileset:: ; heuristic: map tileset stream; C0
Data_04F_513F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13D13F, $3FE

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map5CPalettes::
Data_04F_553D:: ; address name
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $112A, $7FFF, $6B2B, $0020 ; entry 1
    dw $0160, $22BA, $02C0, $0000 ; entry 2
    dw $218C, $17E5, $0301, $0000 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $1415, $7FFF, $01DA, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5CScreens0::
Data_04F_557D:: ; address name
    dfar Map5CScreens0_Y0X0 ; entry 0
    dfar Map5CScreens0_Y1X0 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5CAttrs0::
Data_04F_5583:: ; address name
    dfar Map5CAttrs0_Y0X0 ; entry 0
    dfar Map5CAttrs0_Y1X0 ; entry 1

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5CScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_5589:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13D589, $9E

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5CScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_04F_5627:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13D627, $EB

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5CAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_5712:: ; address name
    db $68, $01, $01, $10, $10, $01, $EE, $FF, $13, $01, $CC, $FF, $21, $04, $01, $5C
    db $01, $01, $4E, $0F, $11, $05, $05, $01, $74, $0F, $13, $01, $5E, $0F, $13, $01
    db $D3, $0F, $4D, $01, $33, $1F, $21

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5CAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_04F_5739:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13D739, $4E

; compressed tileset of map $5D (the first map record using it)
; LZSS-compressed asset: 454 bytes expand to 1280 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DTileset:: ; heuristic: map tileset stream; C0
Data_04F_5787:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13D787, $1C6

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map5DPalettes::
Data_04F_594D:: ; address name
    dw $01D3, $7FFF, $029A, $0000 ; entry 0
    dw $0160, $3657, $15AE, $0044 ; entry 1
    dw $218C, $7FFF, $15AE, $0000 ; entry 2
    dw $0160, $7FFF, $62F3, $0000 ; entry 3
    dw $218C, $4F18, $3A52, $0000 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $0160, $5AB1, $4A2D, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 16 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5DScreens0::
Data_04F_598D:: ; address name
    dfar Map5DScreens0_Y0X0 ; entry 0
    dfar Map5DScreens0_Y0X1 ; entry 1
    dfar Map5DScreens0_Y0X2 ; entry 2
    dfar Map5DScreens0_Y0X3 ; entry 3
    dfar Map5DScreens0_Y1X0 ; entry 4
    dfar Map5DScreens0_Y1X1 ; entry 5
    dfar Map5DScreens0_Y1X2 ; entry 6
    dfar Map5DScreens0_Y1X3 ; entry 7
    dfar Map5DScreens0_Y2X0 ; entry 8
    dfar Map5DScreens0_Y2X1 ; entry 9
    dfar Map5DScreens0_Y2X2 ; entry 10
    dfar Map5DScreens0_Y2X3 ; entry 11
    dfar Map5DScreens0_Y3X0 ; entry 12
    dfar Map5DScreens0_Y3X1 ; entry 13
    dfar Map5DScreens0_Y3X2 ; entry 14
    dfar Map5DScreens0_Y3X3 ; entry 15

; E-0142 (derived: 16 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5DAttrs0::
Data_04F_59BD:: ; address name
    dfar Map5DAttrs0_Y0X0 ; entry 0
    dfar Map5DAttrs0_Y0X1 ; entry 1
    dfar Map5DAttrs0_Y0X2 ; entry 2
    dfar Map5DAttrs0_Y0X3 ; entry 3
    dfar Map5DAttrs0_Y1X0 ; entry 4
    dfar Map5DAttrs0_Y1X1 ; entry 5
    dfar Map5DAttrs0_Y1X2 ; entry 6
    dfar Map5DAttrs0_Y1X3 ; entry 7
    dfar Map5DAttrs0_Y2X0 ; entry 8
    dfar Map5DAttrs0_Y2X1 ; entry 9
    dfar Map5DAttrs0_Y2X2 ; entry 10
    dfar Map5DAttrs0_Y2X3 ; entry 11
    dfar Map5DAttrs0_Y3X0 ; entry 12
    dfar Map5DAttrs0_Y3X1 ; entry 13
    dfar Map5DAttrs0_Y3X2 ; entry 14
    dfar Map5DAttrs0_Y3X3 ; entry 15

; LZSS-compressed asset: 195 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_59ED:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13D9ED, $C3

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y0X1:: ; heuristic: map screen stream; C0
Data_04F_5AB0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13DAB0, $A0

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y0X2:: ; heuristic: map screen stream; C0
Data_04F_5B50:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13DB50, $CD

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y0X3:: ; heuristic: map screen stream; C0
Data_04F_5C1D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13DC1D, $92

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_04F_5CAF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13DCAF, $AA

; LZSS-compressed asset: 157 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y1X1:: ; heuristic: map screen stream; C0
Data_04F_5D59:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13DD59, $9D

; LZSS-compressed asset: 181 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y1X2:: ; heuristic: map screen stream; C0
Data_04F_5DF6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13DDF6, $B5

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y1X3:: ; heuristic: map screen stream; C0
Data_04F_5EAB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13DEAB, $B6

; LZSS-compressed asset: 184 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y2X0:: ; heuristic: map screen stream; C0
Data_04F_5F61:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13DF61, $B8

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y2X1:: ; heuristic: map screen stream; C0
Data_04F_6019:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13E019, $B6

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y2X2:: ; heuristic: map screen stream; C0
Data_04F_60CF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13E0CF, $AA

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y2X3:: ; heuristic: map screen stream; C0
Data_04F_6179:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13E179, $C0

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y3X0:: ; heuristic: map screen stream; C0
Data_04F_6239:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13E239, $87

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y3X1:: ; heuristic: map screen stream; C0
Data_04F_62C0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13E2C0, $A2

; LZSS-compressed asset: 181 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y3X2:: ; heuristic: map screen stream; C0
Data_04F_6362:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13E362, $B5

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DScreens0_Y3X3:: ; heuristic: map screen stream; C0
Data_04F_6417:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13E417, $99

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_64B0:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_04F_64C4:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_04F_64D8:: ; address name
    db $68, $01, $00, $01, $03, $00, $01, $0D, $01, $00, $00, $0F, $09, $02, $02, $02
    db $02, $00, $20, $0F, $0F, $02, $02, $01, $01, $01, $01, $00, $30, $03, $00, $4F
    db $0F, $03, $01, $01, $00, $55, $03, $00, $7E, $02, $02, $02, $00, $76, $01, $01
    db $00, $7C, $0A, $00, $7E, $06, $00, $A7, $0F, $4D, $00, $07, $1F, $4D

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y0X3:: ; heuristic: map screen stream; C0
Data_04F_6516:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_04F_652A:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_04F_653E:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y1X2:: ; heuristic: map screen stream; C0
Data_04F_6552:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y1X3:: ; heuristic: map screen stream; C0
Data_04F_6566:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_04F_657A:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_04F_658E:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y2X2:: ; heuristic: map screen stream; C0
Data_04F_65A2:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y2X3:: ; heuristic: map screen stream; C0
Data_04F_65B6:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y3X0:: ; heuristic: map screen stream; C0
Data_04F_65CA:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y3X1:: ; heuristic: map screen stream; C0
Data_04F_65DE:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y3X2:: ; heuristic: map screen stream; C0
Data_04F_65F2:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5DAttrs0_Y3X3:: ; heuristic: map screen stream; C0
Data_04F_6606:: ; address name
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; compressed tileset of map $5E (the first map record using it)
; LZSS-compressed asset: 1501 bytes expand to 1776 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5ETileset:: ; heuristic: map tileset stream; C0
Data_04F_661A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13E61A, $5DD

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map5EPalettes::
Data_04F_6BF7:: ; address name
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $012F, $7FFF, $01DA, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $0160, $3F7F, $029A, $0000 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5EScreens0::
Data_04F_6C37:: ; address name
    dfar Map5EScreens0_Y0X0 ; entry 0
    dfar Map5EScreens0_Y0X1 ; entry 1
    dfar Map5EScreens0_Y1X0 ; entry 2
    dfar Map5EScreens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5EAttrs0::
Data_04F_6C43:: ; address name
    dfar Map5EAttrs0_Y0X0 ; entry 0
    dfar Map5EAttrs0_Y0X1 ; entry 1
    dfar Map5EAttrs0_Y1X0 ; entry 2
    dfar Map5EAttrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5EScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_6C4F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13EC4F, $E8

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5EScreens0_Y0X1:: ; heuristic: map screen stream; C0
Data_04F_6D37:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13ED37, $D8

; LZSS-compressed asset: 259 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5EScreens0_Y1X0:: ; heuristic: map screen stream; C0
Data_04F_6E0F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13EE0F, $103

; LZSS-compressed asset: 252 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5EScreens0_Y1X1:: ; heuristic: map screen stream; C0
Data_04F_6F12:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13EF12, $FC

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5EAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_700E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13F00E, $60

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5EAttrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_04F_706E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13F06E, $4E

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5EAttrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_04F_70BC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13F0BC, $58

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5EAttrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_04F_7114:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13F114, $59

; compressed tileset of map $60 (the first map record using it)
; LZSS-compressed asset: 1325 bytes expand to 1632 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map60Tileset:: ; heuristic: map tileset stream; C0
Data_04F_716D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13F16D, $52D

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map60Palettes::
Data_04F_769A:: ; address name
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $00ED, $22BA, $11D4, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $0160, $3F7F, $5AB1, $0000 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0014, $7FFF, $01DA, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map60Screens0::
Data_04F_76DA:: ; address name
    dfar Map60Screens0_Y0X0 ; entry 0
    dfar Map60Screens0_Y1X0 ; entry 1
    dfar Map60Screens0_Y2X0 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map60Attrs0::
Data_04F_76E3:: ; address name
    dfar Map60Attrs0_Y0X0 ; entry 0
    dfar Map60Attrs0_Y1X0 ; entry 1
    dfar Map60Attrs0_Y2X0 ; entry 2

; LZSS-compressed asset: 266 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map60Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_76EC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13F6EC, $10A

; LZSS-compressed asset: 244 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map60Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_04F_77F6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13F7F6, $F4

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map60Screens0_Y2X0:: ; heuristic: map screen stream; C0
Data_04F_78EA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13F8EA, $D8

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map60Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_04F_79C2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13F9C2, $44

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map60Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_04F_7A06:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13FA06, $49

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map60Attrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_04F_7A4F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13FA4F, $45

; compressed tileset of map $61 (the first map record using it)
; LZSS-compressed asset: 1088 bytes expand to 1344 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map61Tileset:: ; heuristic: map tileset stream; C0
Data_04F_7A94:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13FA94, $440

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map61Palettes::
Data_04F_7ED4:: ; address name
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $00ED, $22BA, $11D4, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $1528, $7FFF, $6B2B, $0020 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0014, $7FFF, $01DA, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7
    ds $EC, $00
