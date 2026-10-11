SECTION "Bank 53", ROMX[$4000], BANK[$53]
    db $53

; compressed tileset of map $7B (the first map record using it)
; LZSS-compressed asset: 717 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map7BTileset:: ; heuristic: map tileset stream; C0
Data_053_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14C001, $2CD

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map7BPalettes::
Data_053_42CE:: ; heuristic: map BG palettes; C0
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $0189, $5BBF, $32D6, $00C8 ; entry 1
    dw $184C, $0217, $1116, $0000 ; entry 2
    dw $218C, $4F18, $3A52, $0000 ; entry 3
    dw $218C, $4F18, $3A52, $0000 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7BScreens0::
Data_053_430E:: ; heuristic: map screen array; C0
    dfar Data_053_4320 ; entry 0
    dfar Data_053_43E6 ; entry 1
    dfar Data_053_445B ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7BAttrs0::
Data_053_4317:: ; heuristic: map screen array; C0
    dfar Data_053_451C ; entry 0
    dfar Data_053_4557 ; entry 1
    dfar Data_053_4575 ; entry 2

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4320:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14C320, $C6

; LZSS-compressed asset: 117 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_43E6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14C3E6, $75

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_445B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14C45B, $C1

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_451C:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $03, $FF, $F2, $02, $03, $06, $03, $03, $FA, $FF, $0B, $03, $06
    db $04, $03, $0A, $08, $03, $2C, $0F, $05, $01, $01, $01, $01, $03, $48, $0F, $0F
    db $03, $58, $00, $03, $58, $02, $03, $74, $0F, $4D, $03, $84, $0A, $03, $56, $0F
    db $13, $03, $8E, $04, $03, $0C, $0C, $03, $20, $1F, $21

; LZSS-compressed asset: 30 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4557:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $03, $FF, $F2, $02, $02, $01, $01, $01, $01, $02, $02, $03, $FA
    db $FF, $4D, $03, $5A, $0F, $4D, $03, $BA, $0F, $4D, $03, $06, $1F, $27

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4575:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $03, $FF, $F2, $02, $02, $01, $01, $01, $01, $02, $02, $03, $FA
    db $FF, $0B, $02, $02, $03, $06, $04, $03, $0C, $06, $03, $2C, $0F, $2B, $03, $08
    db $00, $03, $08, $0A, $03, $7C, $0F, $4D, $03, $28, $0F, $19, $03, $2A, $02, $03
    db $10, $1A, $03, $1C, $1F, $03, $03, $45, $1F, $0F

; compressed tileset of map $7C (the first map record using it)
; LZSS-compressed asset: 1515 bytes expand to 1776 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map7CTileset:: ; heuristic: map tileset stream; C0
Data_053_45AF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14C5AF, $5EB

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map7CPalettes::
Data_053_4B9A:: ; heuristic: map BG palettes; C0
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
Map7CScreens0::
Data_053_4BDA:: ; heuristic: map screen array; C0
    dfar Data_053_4BF2 ; entry 0
    dfar Data_053_4D3E ; entry 1
    dfar Data_053_4E75 ; entry 2
    dfar Data_053_4FC1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7CAttrs0::
Data_053_4BE6:: ; heuristic: map screen array; C0
    dfar Data_053_50ED ; entry 0
    dfar Data_053_515E ; entry 1
    dfar Data_053_51AA ; entry 2
    dfar Data_053_521E ; entry 3

; LZSS-compressed asset: 332 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4BF2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14CBF2, $14C

; LZSS-compressed asset: 311 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4D3E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14CD3E, $137

; LZSS-compressed asset: 332 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4E75:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14CE75, $14C

; LZSS-compressed asset: 300 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_4FC1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14CFC1, $12C

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_50ED:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14D0ED, $71

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_515E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14D15E, $4C

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_51AA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14D1AA, $74

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_521E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14D21E, $4B

; compressed tileset of map $7D (the first map record using it)
; LZSS-compressed asset: 1112 bytes expand to 1248 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map7DTileset:: ; heuristic: map tileset stream; C0
Data_053_5269:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14D269, $458

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map7DPalettes::
Data_053_56C1:: ; heuristic: map BG palettes; C0
    dw $00ED, $7FFF, $11D4, $0000 ; entry 0
    dw $004F, $3F7F, $11D4, $0000 ; entry 1
    dw $00ED, $22BA, $11D4, $0000 ; entry 2
    dw $2C8A, $3F7F, $11D4, $0000 ; entry 3
    dw $00ED, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7DScreens0::
Data_053_5701:: ; heuristic: map screen array; C0
    dfar Data_053_5707 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7DAttrs0::
Data_053_5704:: ; heuristic: map screen array; C0
    dfar Data_053_57C8 ; entry 0

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_5707:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14D707, $C1

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_57C8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14D7C8, $43

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7EScreens0::
Data_053_580B:: ; heuristic: map screen array; C0
    dfar Data_053_5811 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7EAttrs0::
Data_053_580E:: ; heuristic: map screen array; C0
    dfar Data_053_58C3 ; entry 0

; LZSS-compressed asset: 178 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_5811:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14D811, $B2

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_58C3:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $02, $04, $04, $00, $00, $03, $00, $09, $07, $00
    db $07, $0B, $01, $01, $01, $01, $04, $00, $2E, $01, $01, $01, $00, $22, $0F, $09
    db $00, $2E, $02, $00, $2E, $02, $00, $4A, $0F, $09, $00, $79, $0F, $4D, $00, $92
    db $0F, $05, $03, $03, $00, $E0, $0F, $13, $00, $08, $1F, $3B

; compressed tileset of map $7F (the first map record using it)
; LZSS-compressed asset: 1001 bytes expand to 1088 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map7FTileset:: ; heuristic: map tileset stream; C0
Data_053_58FF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14D8FF, $3E9

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map7FPalettes::
Data_053_5CE8:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $00ED, $01C4, $001F, $0000 ; entry 1
    dw $00ED, $22BA, $11D4, $0000 ; entry 2
    dw $01C4, $3F7F, $0348, $0000 ; entry 3
    dw $00ED, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7FScreens0::
Data_053_5D28:: ; heuristic: map screen array; C0
    dfar Data_053_5D34 ; entry 0
    dfar Data_053_5E4B ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map7FAttrs0::
Data_053_5D2E:: ; heuristic: map screen array; C0
    dfar Data_053_5F69 ; entry 0
    dfar Data_053_5FB0 ; entry 1

; LZSS-compressed asset: 279 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_5D34:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14DD34, $117

; LZSS-compressed asset: 286 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_5E4B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14DE4B, $11E

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_5F69:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14DF69, $47

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_5FB0:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $02, $02, $01, $01, $02, $04, $00, $06, $03, $00, $02, $00
    db $00, $11, $01, $00, $03, $0F, $00, $00, $06, $04, $00, $06, $05, $00, $27, $0F
    db $04, $00, $11, $02, $00, $44, $0F, $0F, $00, $2A, $0F, $4D, $00, $8A, $0F, $4D
    db $00, $EA, $0E, $00, $9E, $06, $00, $42, $1E

; compressed tileset of map $80 (the first map record using it)
; LZSS-compressed asset: 1298 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map80Tileset:: ; heuristic: map tileset stream; C0
Data_053_5FE9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14DFE9, $512

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map80Palettes::
Data_053_64FB:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $48EC, $6BFF, $4A6F, $0000 ; entry 1
    dw $00ED, $22BA, $11D4, $0000 ; entry 2
    dw $01C4, $3F7F, $0348, $0000 ; entry 3
    dw $7DA0, $3F7F, $01DA, $0000 ; entry 4
    dw $00ED, $7FFF, $11D4, $0000 ; entry 5
    dw $012F, $3FBF, $01D5, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map80Screens0::
Data_053_653B:: ; heuristic: map screen array; C0
    dfar Data_053_654D ; entry 0
    dfar Data_053_6670 ; entry 1
    dfar Data_053_6706 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map80Attrs0::
Data_053_6544:: ; heuristic: map screen array; C0
    dfar Data_053_682E ; entry 0
    dfar Data_053_687E ; entry 1
    dfar Data_053_68C3 ; entry 2

; LZSS-compressed asset: 291 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_654D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14E54D, $123

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_6670:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14E670, $96

; LZSS-compressed asset: 296 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_6706:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14E706, $128

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_682E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14E82E, $50

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_687E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14E87E, $45

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_68C3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14E8C3, $59

; compressed tileset of map $89 (the first map record using it)
; LZSS-compressed asset: 1552 bytes expand to 1728 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map89Tileset:: ; heuristic: map tileset stream; C0
Data_053_691C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14E91C, $610

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map89Palettes::
Data_053_6F2C:: ; heuristic: map BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $48EC, $6BFF, $4A6F, $0000 ; entry 1
    dw $00ED, $7FFF, $11D4, $0000 ; entry 2
    dw $01C4, $3F7F, $0348, $0000 ; entry 3
    dw $48EC, $3F7F, $01DA, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map89Screens0::
Data_053_6F6C:: ; heuristic: map screen array; C0
    dfar Data_053_6F84 ; entry 0
    dfar Data_053_6F84 ; entry 1
    dfar Data_053_7097 ; entry 2
    dfar Data_053_71DB ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map89Attrs0::
Data_053_6F78:: ; heuristic: map screen array; C0
    dfar Data_053_7313 ; entry 0
    dfar Data_053_7313 ; entry 1
    dfar Data_053_7352 ; entry 2
    dfar Data_053_739B ; entry 3

; LZSS-compressed asset: 275 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_6F84:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14EF84, $113

; LZSS-compressed asset: 324 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7097:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14F097, $144

; LZSS-compressed asset: 312 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_71DB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14F1DB, $138

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7313:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $FF, $22, $01, $02, $35, $02, $02, $29, $0F, $00, $02
    db $3B, $08, $02, $48, $04, $02, $3B, $07, $02, $5B, $05, $02, $3B, $04, $02, $6E
    db $06, $02, $39, $05, $02, $7F, $09, $02, $8B, $0F, $42, $02, $92, $0A, $02, $EE
    db $0F, $13, $04, $04, $02, $16, $1F, $05, $02, $92, $0A, $02, $3C, $1F, $05

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7352:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14F352, $49

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_739B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14F39B, $62

; compressed tileset of map $8A (the first map record using it)
; LZSS-compressed asset: 910 bytes expand to 1056 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map8ATileset:: ; heuristic: map tileset stream; C0
Data_053_73FD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $14F3FD, $38E

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map8APalettes::
Data_053_778B:: ; heuristic: map BG palettes; C0
    dw $100E, $7FFF, $70CA, $0000 ; entry 0
    dw $18EB, $67FF, $01DA, $0000 ; entry 1
    dw $28E8, $4F18, $0DD5, $0000 ; entry 2
    dw $3C6B, $3A52, $2510, $0000 ; entry 3
    dw $012F, $4A52, $01C7, $00A0 ; entry 4
    dw $00C2, $4A52, $01C7, $00A0 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8BScreens0::
Data_053_77CB:: ; heuristic: map screen array; C0
    dfar Data_053_7813 ; entry 0
    dfar Data_053_7813 ; entry 1
    dfar Data_053_7813 ; entry 2
    dfar Data_053_7918 ; entry 3
    dfar Data_053_7A08 ; entry 4
    dfar Data_053_7AD0 ; entry 5
    dfar Data_053_7813 ; entry 6
    dfar Data_053_7B95 ; entry 7
    dfar Data_053_7813 ; entry 8
    dfar Data_053_7813 ; entry 9
    dfar Data_053_7CB8 ; entry 10
    dfar Data_053_7813 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map8BAttrs0::
Data_053_77EF:: ; heuristic: map screen array; C0
    dfar Data_053_7DE7 ; entry 0
    dfar Data_053_7DE7 ; entry 1
    dfar Data_053_7DE7 ; entry 2
    dfar Data_053_7E24 ; entry 3
    dfar Data_053_7E5F ; entry 4
    dfar Data_053_7E9B ; entry 5
    dfar Data_053_7DE7 ; entry 6
    dfar Data_053_7EDA ; entry 7
    dfar Data_053_7DE7 ; entry 8
    dfar Data_053_7DE7 ; entry 9
    dfar Data_053_7F17 ; entry 10
    dfar Data_053_7DE7 ; entry 11

; LZSS-compressed asset: 261 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7813:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14F813, $105

; LZSS-compressed asset: 240 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7918:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14F918, $F0

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7A08:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14FA08, $C8

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7AD0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14FAD0, $C5

; LZSS-compressed asset: 291 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7B95:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14FB95, $123

; LZSS-compressed asset: 303 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7CB8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14FCB8, $12F

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7DE7:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $01, $02, $00, $0F, $18, $03, $02, $2C, $07, $02, $24, $0F, $07
    db $03, $03, $02, $F4, $F8, $02, $36, $02, $02, $52, $0F, $01, $02, $F0, $FF, $01
    db $02, $7A, $0F, $05, $02, $9E, $08, $02, $9E, $0F, $0B, $02, $52, $02, $02, $34
    db $04, $02, $CA, $0F, $07, $02, $94, $0F, $01, $02, $F8, $0F, $49

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7E24:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $01, $02, $00, $0F, $18, $03, $02, $2C, $0B, $02, $28, $0F, $03
    db $03, $03, $02, $F0, $FE, $02, $52, $0F, $01, $02, $F4, $FF, $01, $02, $7A, $0F
    db $0F, $02, $38, $02, $02, $A2, $0F, $0F, $02, $74, $0F, $01, $02, $D8, $0F, $1B
    db $02, $78, $08, $02, $12, $1F, $0B, $02, $00, $0F, $11

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7E5F:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $01, $01, $02, $FC, $F6, $02, $FA, $F4, $02, $00, $0F, $01, $03
    db $03, $02, $16, $0F, $13, $02, $48, $0A, $02, $4A, $0F, $07, $02, $76, $04, $02
    db $6C, $0F, $0D, $03, $02, $A0, $03, $02, $94, $0F, $0D, $02, $EE, $FF, $05, $02
    db $CC, $0F, $4D, $02, $7C, $0A, $02, $74, $06, $02, $32, $1C

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7E9B:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $10, $02, $00, $01, $01, $02, $06, $09, $02, $00, $0F, $0B, $03
    db $03, $00, $00, $03, $03, $02, $24, $0F, $0D, $02, $32, $00, $02, $FC, $F0, $02
    db $36, $00, $02, $50, $0F, $09, $02, $F6, $F6, $02, $76, $0F, $4D, $02, $AE, $0F
    db $23, $02, $BA, $04, $02, $10, $0A, $02, $22, $1F, $01, $02, $0A, $0F, $0B

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7EDA:: ; heuristic: map screen stream; C0
    db $68, $01, $04, $01, $01, $03, $03, $04, $F4, $F8, $03, $03, $01, $01, $04, $00
    db $0F, $03, $04, $FA, $F2, $02, $02, $02, $02, $04, $FA, $F4, $04, $28, $0F, $4D
    db $04, $38, $04, $04, $44, $00, $04, $A4, $04, $04, $9C, $0F, $31, $04, $40, $0F
    db $3B, $04, $3C, $02, $04, $44, $04, $04, $3E, $12, $04, $42, $1E

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_053_7F17:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $14FF17, $4B
    ds $9E, $00
