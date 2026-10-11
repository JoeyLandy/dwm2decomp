SECTION "Bank 6B", ROMX[$4000], BANK[$6B]
    db $6B

; compressed tileset of special map record 6 (SpecialMapRecords)
; LZSS-compressed asset: 842 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap06Tileset:: ; heuristic: special map tileset stream; C0
Data_06B_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1AC001, $34A

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap06Palettes::
Data_06B_434B:: ; heuristic: special map BG palettes; C0
    dw $1C2E, $7FFF, $357B, $0000 ; entry 0
    dw $012F, $3F7F, $01DA, $0000 ; entry 1
    dw $49AE, $6B79, $4ACD, $0000 ; entry 2
    dw $01C0, $3F7F, $03E2, $0000 ; entry 3
    dw $092E, $3F7F, $19D4, $0000 ; entry 4
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap06Screens::
Data_06B_438B:: ; heuristic: map screen array; C0
    dfar Data_06B_43A3 ; entry 0
    dfar Data_06B_448F ; entry 1
    dfar Data_06B_455A ; entry 2
    dfar Data_06B_4636 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap06Attrs::
Data_06B_4397:: ; heuristic: map screen array; C0
    dfar Data_06B_470A ; entry 0
    dfar Data_06B_4773 ; entry 1
    dfar Data_06B_47C9 ; entry 2
    dfar Data_06B_4817 ; entry 3

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_43A3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC3A3, $EC

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_448F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC48F, $CB

; LZSS-compressed asset: 220 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_455A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC55A, $DC

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4636:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC636, $D4

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_470A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC70A, $69

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4773:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC773, $56

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_47C9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC7C9, $4E

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4817:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AC817, $50

; compressed tileset of special map record 7 (SpecialMapRecords)
; LZSS-compressed asset: 1231 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap07Tileset:: ; heuristic: special map tileset stream; C0
Data_06B_4867:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1AC867, $4CF

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap07Palettes::
Data_06B_4D36:: ; heuristic: special map BG palettes; C0
    dw $49AE, $7FFF, $4ACD, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $0191, $3F7F, $029A, $0000 ; entry 2
    dw $01C0, $3F7F, $01D3, $0000 ; entry 3
    dw $092E, $3F7F, $19D4, $0000 ; entry 4
    dw $01DA, $67FF, $1C2E, $0000 ; entry 5
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap07Screens::
Data_06B_4D76:: ; heuristic: map screen array; C0
    dfar Data_06B_4D8E ; entry 0
    dfar Data_06B_4E66 ; entry 1
    dfar Data_06B_4F4B ; entry 2
    dfar Data_06B_501E ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap07Attrs::
Data_06B_4D82:: ; heuristic: map screen array; C0
    dfar Data_06B_5116 ; entry 0
    dfar Data_06B_516F ; entry 1
    dfar Data_06B_51D0 ; entry 2
    dfar Data_06B_522F ; entry 3

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4D8E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1ACD8E, $D8

; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4E66:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1ACE66, $E5

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_4F4B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1ACF4B, $D3

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_501E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD01E, $F8

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5116:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD116, $59

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_516F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD16F, $61

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_51D0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD1D0, $5F

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_522F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD22F, $54

; compressed tileset of special map record 8 (SpecialMapRecords)
; LZSS-compressed asset: 1213 bytes expand to 1552 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap08Tileset:: ; heuristic: special map tileset stream; C0
Data_06B_5283:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1AD283, $4BD

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap08Palettes::
Data_06B_5740:: ; heuristic: special map BG palettes; C0
    dw $49AE, $7FFF, $4ACD, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $0191, $3F7F, $029A, $0000 ; entry 2
    dw $01C0, $3F7F, $03E2, $0000 ; entry 3
    dw $092E, $3F7F, $19D4, $0000 ; entry 4
    dw $012F, $7FFF, $01DA, $0000 ; entry 5
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap08Screens::
Data_06B_5780:: ; heuristic: map screen array; C0
    dfar Data_06B_5798 ; entry 0
    dfar Data_06B_5875 ; entry 1
    dfar Data_06B_5950 ; entry 2
    dfar Data_06B_5A51 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap08Attrs::
Data_06B_578C:: ; heuristic: map screen array; C0
    dfar Data_06B_5B4A ; entry 0
    dfar Data_06B_5BA8 ; entry 1
    dfar Data_06B_5BEE ; entry 2
    dfar Data_06B_5C36 ; entry 3

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5798:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD798, $DD

; LZSS-compressed asset: 219 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5875:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD875, $DB

; LZSS-compressed asset: 257 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5950:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AD950, $101

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5A51:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1ADA51, $F9

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5B4A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1ADB4A, $5E

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5BA8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1ADBA8, $46

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5BEE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1ADBEE, $48

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_5C36:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $06, $06, $06, $01, $F1, $FB, $03, $03, $01, $02, $0C, $01, $10
    db $0A, $06, $01, $32, $01, $01, $10, $00, $01, $F6, $F9, $01, $35, $0F, $26, $01
    db $0C, $04, $01, $76, $0F, $13, $01, $74, $0F, $01, $01, $74, $0F, $01, $05, $05
    db $01, $C6, $0F, $13, $01, $C0, $FF, $2D, $01, $88, $00, $01, $40, $1F, $11

; compressed tileset of special map record 9 (SpecialMapRecords)
; LZSS-compressed asset: 1114 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap09Tileset:: ; heuristic: special map tileset stream; C0
Data_06B_5C75:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1ADC75, $45A

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap09Palettes::
Data_06B_60CF:: ; heuristic: special map BG palettes; C0
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $1586, $7FFF, $02C0, $0000 ; entry 3
    dw $218C, $2E7F, $1415, $0000 ; entry 4
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap09Screens::
Data_06B_610F:: ; heuristic: map screen array; C0
    dfar Data_06B_6127 ; entry 0
    dfar Data_06B_6251 ; entry 1
    dfar Data_06B_633B ; entry 2
    dfar Data_06B_643F ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap09Attrs::
Data_06B_611B:: ; heuristic: map screen array; C0
    dfar Data_06B_653C ; entry 0
    dfar Data_06B_658E ; entry 1
    dfar Data_06B_65BF ; entry 2
    dfar Data_06B_65ED ; entry 3

; LZSS-compressed asset: 298 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6127:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE127, $12A

; LZSS-compressed asset: 234 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6251:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE251, $EA

; LZSS-compressed asset: 260 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_633B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE33B, $104

; LZSS-compressed asset: 253 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_643F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE43F, $FD

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_653C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AE53C, $52

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_658E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $01, $00, $0F, $3C, $01, $A4, $FF, $49, $04, $04, $02, $02
    db $01, $9C, $0F, $0F, $04, $01, $D2, $01, $01, $C4, $0F, $0F, $01, $D0, $02, $01
    db $EC, $0F, $11, $01, $D6, $FF, $1B, $01, $F6, $F6, $02, $01, $5C, $11, $01, $4C
    db $02

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_65BF:: ; heuristic: map screen stream; C0
    db $68, $01, $04, $04, $FF, $FF, $2B, $02, $02, $04, $32, $0F, $05, $01, $01, $04
    db $32, $0E, $04, $58, $04, $04, $3E, $0A, $04, $E8, $FF, $43, $03, $03, $03, $03
    db $04, $3C, $0C, $04, $D8, $02, $04, $B2, $0F, $17, $04, $18, $1F, $39

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_65ED:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $1F, $05, $01, $32, $01, $01, $FF, $F2, $02, $02
    db $02, $02, $01, $2E, $0C, $01, $2A, $0C, $03, $03, $01, $50, $0F, $0B, $01, $FF
    db $F4, $01, $76, $0F, $2B, $01, $76, $0F, $0D, $01, $3E, $04, $01, $FF, $FF, $15
    db $01, $C6, $00, $01, $18, $1F, $39

; compressed tileset of special map record 10 (SpecialMapRecords)
; LZSS-compressed asset: 990 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0ATileset:: ; heuristic: special map tileset stream; C0
Data_06B_6624:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1AE624, $3DE

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0APalettes::
Data_06B_6A02:: ; heuristic: special map BG palettes; C0
    dw $49AE, $7FFF, $4ACD, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $1586, $3F7F, $02C0, $0000 ; entry 3
    dw $012F, $2E7F, $3CAE, $0000 ; entry 4
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0AScreens::
Data_06B_6A42:: ; heuristic: map screen array; C0
    dfar Data_06B_6A5A ; entry 0
    dfar Data_06B_6B37 ; entry 1
    dfar Data_06B_6C24 ; entry 2
    dfar Data_06B_6D03 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0AAttrs::
Data_06B_6A4E:: ; heuristic: map screen array; C0
    dfar Data_06B_6E0C ; entry 0
    dfar Data_06B_6E6F ; entry 1
    dfar Data_06B_6ECC ; entry 2
    dfar Data_06B_6F0F ; entry 3

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6A5A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEA5A, $DD

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6B37:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEB37, $ED

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6C24:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEC24, $DF

; LZSS-compressed asset: 265 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6D03:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AED03, $109

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6E0C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEE0C, $63

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6E6F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEE6F, $5D

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6ECC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEECC, $43

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_6F0F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AEF0F, $58

; compressed tileset of special map record 11 (SpecialMapRecords)
; LZSS-compressed asset: 1143 bytes expand to 1504 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap0BTileset:: ; heuristic: special map tileset stream; C0
Data_06B_6F67:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1AEF67, $477

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0BPalettes::
Data_06B_73DE:: ; heuristic: special map BG palettes; C0
    dw $49AE, $7FFF, $4ACD, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $194A, $5F17, $3A33, $0000 ; entry 2
    dw $3C6B, $3A52, $2510, $0000 ; entry 3
    dw $3C6B, $4F18, $2510, $0000 ; entry 4
    dw $28E8, $4F18, $0DD5, $0000 ; entry 5
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0BScreens::
Data_06B_741E:: ; heuristic: map screen array; C0
    dfar Data_06B_7436 ; entry 0
    dfar Data_06B_7557 ; entry 1
    dfar Data_06B_7645 ; entry 2
    dfar Data_06B_7765 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0BAttrs::
Data_06B_742A:: ; heuristic: map screen array; C0
    dfar Data_06B_786E ; entry 0
    dfar Data_06B_78E7 ; entry 1
    dfar Data_06B_795F ; entry 2
    dfar Data_06B_79DB ; entry 3

; LZSS-compressed asset: 289 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7436:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF436, $121

; LZSS-compressed asset: 238 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7557:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF557, $EE

; LZSS-compressed asset: 288 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7645:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF645, $120

; LZSS-compressed asset: 265 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7765:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF765, $109

; LZSS-compressed asset: 121 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_786E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF86E, $79

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_78E7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF8E7, $78

; LZSS-compressed asset: 124 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_795F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF95F, $7C

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_79DB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AF9DB, $69

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0CScreens::
Data_06B_7A44:: ; heuristic: map screen array; C0
    dfar Data_06B_7A5C ; entry 0
    dfar Data_06B_7B6E ; entry 1
    dfar Data_06B_7C5B ; entry 2
    dfar Data_06B_7D25 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0CAttrs::
Data_06B_7A50:: ; heuristic: map screen array; C0
    dfar Data_06B_7E1E ; entry 0
    dfar Data_06B_7E72 ; entry 1
    dfar Data_06B_7EA4 ; entry 2
    dfar Data_06B_7EF3 ; entry 3

; LZSS-compressed asset: 274 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7A5C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFA5C, $112

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7B6E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFB6E, $ED

; LZSS-compressed asset: 202 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7C5B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFC5B, $CA

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7D25:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFD25, $F9

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7E1E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFE1E, $54

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7E72:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $02, $03, $00, $0F, $3E, $06, $03, $52, $01, $03, $44, $0F, $0D
    db $03, $52, $02, $06, $06, $01, $03, $80, $05, $03, $76, $0F, $11, $00, $00, $03
    db $9C, $0F, $13, $03, $86, $0F, $15, $03, $86, $0F, $07, $03, $50, $04, $03, $0C
    db $1F, $35

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7EA4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFEA4, $4F

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06B_7EF3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AFEF3, $45
    ds $C8, $00
