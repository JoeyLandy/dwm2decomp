SECTION "Bank 5E", ROMX[$4000], BANK[$5E]
    db $5E

; LZSS-compressed asset: 558 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_4001:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $178001, $22E

Data_05E_422F:: ; heuristic: argument of a bank-switching copy helper; C0
    db $4D, $01, $FF, $6B, $55, $2A, $00, $00, $88, $6E, $53, $57, $54, $55, $53, $54
    db $53, $54, $55, $55, $57, $53, $55, $54, $55, $54, $58, $59, $5A, $66
    dw Data_05E_5151
    db $51
    dw Data_05E_5151
    db $51
    dw Data_05E_5151
    db $51
    dw Data_05E_5151
    db $51
    dw Data_05E_5151
    db $51
    dw Data_05E_5D5C
    db $5E
    dw Data_05E_605F
    db $51
    dw Data_05E_7451
    db $78
    dw Data_05E_7878
    db $78
    dw Data_05E_7878
    db $78
    dw Data_05E_7878
    db $78
    dw Data_05E_7878
    INCBIN "dwm2-cobi-us.gbc", $178270, $E4
    dw Data_05E_5050
    db $50
    dw Data_05E_5050
    db $50
    dw Data_05E_5050
    db $50
    dw Data_05E_5050
    db $50
    dw Data_05E_517A
    db $51
    dw Data_05E_605B
    db $51
    dw Data_05E_6751
    db $68
    dw Data_05E_6969
    db $6A
    dw Data_05E_696A
    db $69
    dw Data_05E_6A6A
    db $69, $69, $6A, $6B, $51, $51, $63, $64, $51, $51, $6D, $52, $52
    dw Data_05E_5252
    db $52, $52
    dw Data_05E_5252
    db $52, $52
    dw Data_05E_5252
    db $6F, $51
    dw Data_05E_6551
    db $7B, $7C
    dw Data_05E_707D
    db $71, $72
    dw Data_05E_7172
    db $71, $72
    dw Data_05E_7172
    db $71, $72
    dw Data_05E_7172
    db $73, $7C
    dw Data_05E_7F7E
    ds $B5, $56
    db $03, $07, $08, $56, $56, $0D, $00, $56, $56, $56, $00
    ds $23, $56
    INCBIN "dwm2-cobi-us.gbc", $178483, $43
    ds $6A, $56
    db $57, $57, $00, $56, $56, $57, $00
    ds $12, $56
    db $57, $57, $00, $56, $56, $57, $00
    ds $12, $56
    db $57, $57, $04, $56, $56, $57, $0A, $00
    ds $11, $56
    db $57, $57, $00, $56, $56, $0A, $57, $04, $56, $56, $56, $01, $00, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $57, $0A, $00, $56, $56, $04
    ds $13, $56
    db $57, $06, $00, $56, $56, $04
    ds $13, $56
    db $57, $57, $04, $56, $56, $57, $57, $57, $07, $56, $01, $57, $06, $57, $56, $56
    db $06, $56, $56, $56, $56, $56, $56, $56, $56, $57, $57, $04, $56, $56, $0A, $0B
    db $57, $07, $56, $56, $56, $06, $57, $56, $56, $56, $56, $06, $56, $56, $56, $56
    db $56, $56, $57, $0A, $00, $56, $56, $0A
    ds $13, $56
    db $57, $57, $00, $56, $56, $57, $00
    ds $12, $56
    db $57, $57, $00, $56, $56, $57, $00
    ds $12, $56
    db $57, $57, $04, $56, $56, $57, $0A, $00
    ds $11, $56
    db $57, $57, $00, $56, $56, $0A, $57, $04, $56, $56, $56, $01, $00, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $57, $0A, $00, $56, $56, $04
    ds $13, $56
    db $57, $06, $00, $56, $56, $04
    ds $13, $56
    db $57, $57, $04, $56, $56, $57, $57, $57, $07, $56, $01, $57, $06, $57, $56, $56
    db $06, $56, $56, $56, $56, $56, $56, $56, $56, $57, $57, $04, $56, $56, $0A, $0B
    db $57, $07, $56, $56, $56, $06, $57, $56, $56, $56, $56, $06, $56, $56, $56, $56
    db $56, $56, $57, $0A, $00, $56, $56, $0A
    ds $15, $56
    db $01, $57, $57, $56, $56, $56, $01, $57
    ds $11, $56
    db $01, $57, $57, $56, $56, $56, $01, $57
    ds $11, $56
    db $05, $57, $57, $56, $56, $01, $0B, $57
    ds $10, $56
    db $03, $0D, $57, $57, $56, $01, $0B, $57, $57, $56, $56, $0D, $57, $00, $56, $56
    db $06, $06, $56, $56, $56, $56, $56, $56, $56, $56, $01, $06, $57, $56, $56, $56
    db $56, $05
    ds $11, $56
    db $01, $57, $57, $56, $56, $56, $56, $0B
    ds $11, $56
    db $0D, $57, $57, $56, $05, $57, $0B, $57, $56, $01, $00, $05, $04, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $0D, $57, $57, $56, $56, $06, $0B
    db $57, $56, $56, $05, $57, $04, $56, $56, $01, $06, $56, $56, $56, $56, $56, $56
    db $56, $56, $01, $06, $57, $56, $56, $56, $56, $05
    ds $19, $56
    INCBIN "dwm2-cobi-us.gbc", $1787DD, $D5
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $1788C2, $117
    dw Data_05E_5600
    dw Data_05E_5656
    dw Data_05E_5656
    dw Data_05E_5756
    dw Data_05E_5757
    dw Data_05E_5757
    dw Data_05E_5757
    dw Data_05E_5757
    INCBIN "dwm2-cobi-us.gbc", $1789E9, $443
    dw Data_05E_5656
    db $56
    dw Data_05E_5656
    db $56
    dw Data_05E_570D
    db $0C
    dw Data_05E_5756
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    db $57, $57
    dw Data_05E_5656
    db $56
    dw Data_05E_5656
    db $56
    dw Data_05E_5703
    db $07
    dw Data_05E_5756
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    db $57
    dw Data_05E_5757
    INCBIN "dwm2-cobi-us.gbc", $178E5C, $9F
    ds $12, $57
    INCBIN "dwm2-cobi-us.gbc", $178F0D, $D2
    ds $11, $57
    INCBIN "dwm2-cobi-us.gbc", $178FF0, $60

Data_05E_5050:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $179050, $43
    dw Data_05E_560C
    dw Data_05E_5656
    dw Data_05E_570D
    dw Data_05E_5757
    dw Data_05E_5757
    dw Data_05E_5757
    dw Data_05E_5757
    dw Data_05E_5757
    INCBIN "dwm2-cobi-us.gbc", $1790A3, $AE

Data_05E_5151:: ; heuristic: target of a monotone pointer table; C0
    db $04, $56, $03, $07, $05, $56, $56, $57, $57, $57, $56, $56, $56, $01, $57, $56
    db $56, $05, $57, $57, $57, $06, $06, $06, $57, $04, $56, $56, $56, $05, $56, $56
    db $56, $56, $05, $56, $56, $56, $56, $0D, $56

Data_05E_517A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17917A, $D8

Data_05E_5252:: ; heuristic: target of a monotone pointer table; C0
    db $56, $56, $56, $0C, $56, $56, $56, $56, $57, $57, $04, $56, $56, $58, $58, $10
    db $56, $56, $58, $10
    ds $12, $56
    db $58, $58, $10, $56, $56, $58, $10
    ds $12, $56
    db $58, $58, $14, $56, $56, $58, $1A, $10
    ds $11, $56
    db $58, $58, $10, $56, $56, $1A, $58, $14, $56, $56, $56, $11, $10, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $58, $1A, $10, $56, $56, $14
    ds $13, $56
    db $58, $16, $10, $56, $56, $14
    ds $13, $56
    db $58, $58, $14, $56, $56, $58, $58, $58, $17, $56, $11, $58, $16, $58, $56, $56
    db $16, $56, $56, $56, $56, $56, $56, $56, $56, $58, $58, $14, $56, $56, $1A, $1B
    db $58, $17, $56, $56, $56, $16, $58, $56, $56, $56, $56, $16, $56, $56, $56, $56
    db $56, $56, $58, $1A, $10, $56, $56, $1A
    ds $15, $56
    db $11, $58, $58, $56, $56, $56, $11, $58
    ds $11, $56
    db $11, $58, $58, $56, $56, $56, $11, $58
    ds $11, $56
    db $15, $58, $58, $56, $56, $11, $1B, $58
    ds $10, $56
    db $13, $1D, $58, $58, $56, $11, $1B, $58, $58, $56, $56, $1D, $58, $10, $56, $56
    db $16, $16, $56, $56, $56, $56, $56, $56, $56, $56, $11, $16, $58, $56, $56, $56
    db $56, $15
    ds $11, $56
    db $11, $58, $58, $56, $56, $56, $56, $1B
    ds $11, $56
    db $1D, $58, $58, $56, $15, $58, $1B, $58, $56, $11, $10, $15, $14, $56, $56, $56
    db $56, $56, $56, $56, $56, $56, $56, $56, $56, $1D, $58, $58, $56, $56, $16, $1B
    db $58, $56, $56, $15, $58, $14, $56, $56, $11, $16, $56, $56, $56, $56, $56, $56
    db $56, $56, $11, $16, $58, $56, $56, $56, $56, $15
    ds $19, $56
    INCBIN "dwm2-cobi-us.gbc", $17942B, $D5
    ds $10, $56
    INCBIN "dwm2-cobi-us.gbc", $179510, $F0

Data_05E_5600:: ; heuristic: target of a monotone pointer table; C0
    db $58, $58, $58, $58, $58, $58, $56, $56, $56, $56, $56, $56

Data_05E_560C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17960C, $4A

Data_05E_5656:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $179656, $AD

Data_05E_5703:: ; heuristic: target of a monotone pointer table; C0
    db $58, $56, $58, $58, $58, $10, $56, $58, $58, $14

Data_05E_570D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17970D, $49

Data_05E_5756:: ; heuristic: target of a monotone pointer table; C0
    db $58

Data_05E_5757:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $179757, $3F2
    ds $12, $58
    INCBIN "dwm2-cobi-us.gbc", $179B5B, $D2
    ds $11, $58
    INCBIN "dwm2-cobi-us.gbc", $179C3E, $11E

Data_05E_5D5C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $179D5C, $151
    ds $19, $58
    ds $19, $57
    ds $4B, $00

; compressed tileset of map $49 (the first map record using it)
; LZSS-compressed asset: 835 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map49Tileset:: ; heuristic: map tileset stream; C0
Data_05E_5F2A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $179F2A, $131

Data_05E_605B:: ; heuristic: target of a monotone pointer table; C0
    db $73, $00, $84, $80

Data_05E_605F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17A05F, $20E

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map49Palettes::
Data_05E_626D:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $6301, $0000 ; entry 0
    dw $7C01, $7FFF, $5AB1, $0000 ; entry 1
    dw $218C, $7FFF, $6301, $0063 ; entry 2
    dw $0160, $7FFF, $5AB1, $0000 ; entry 3
    dw $218C, $7FFF, $5AB1, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map49Screens2::
Data_05E_62AD:: ; heuristic: map screen array; C0
    dfar Data_05E_62B9 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map49Attrs2::
Data_05E_62B0:: ; heuristic: map screen array; C0
    dfar Data_05E_6462 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map49Screens0::
Data_05E_62B3:: ; heuristic: map screen array; C0
    dfar Data_05E_638D ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map49Attrs0::
Data_05E_62B6:: ; heuristic: map screen array; C0
    dfar Data_05E_64B8 ; entry 0

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_62B9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17A2B9, $D4

; LZSS-compressed asset: 213 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_638D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17A38D, $D5

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6462:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17A462, $56

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_64B8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17A4B8, $51

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map4APalettes::
Data_05E_6509:: ; heuristic: map BG palettes; C0
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $0160, $7FFF, $5AB1, $0000 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of map $58 (the first map record using it)
; LZSS-compressed asset: 1466 bytes expand to 1776 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map58Tileset:: ; heuristic: map tileset stream; C0
Data_05E_6549:: ; address name
    db $F0, $06, $16, $00, $87, $00, $5E, $00

Data_05E_6551:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17A551, $200

Data_05E_6751:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17A751, $218

Data_05E_6969:: ; heuristic: target of a monotone pointer table; C0
    db $DB

Data_05E_696A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17A96A, $100

Data_05E_6A6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17AA6A, $99

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map58Palettes::
Data_05E_6B03:: ; heuristic: map BG palettes; C0
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $0160, $7FFF, $5AB1, $0000 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 6
    dw $218C, $2E7F, $1415, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map58Screens0::
Data_05E_6B43:: ; heuristic: map screen array; C0
    dfar Data_05E_6B5B ; entry 0
    dfar Data_05E_6C53 ; entry 1
    dfar Data_05E_6D4E ; entry 2
    dfar Data_05E_6E21 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map58Attrs0::
Data_05E_6B4F:: ; heuristic: map screen array; C0
    dfar Data_05E_6EE6 ; entry 0
    dfar Data_05E_6F3E ; entry 1
    dfar Data_05E_6F98 ; entry 2
    dfar Data_05E_6FDC ; entry 3

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6B5B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17AB5B, $F8

; LZSS-compressed asset: 251 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6C53:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17AC53, $FB

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6D4E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17AD4E, $D3

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6E21:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17AE21, $C5

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6EE6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17AEE6, $58

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6F3E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17AF3E, $5A

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6F98:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17AF98, $44

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_6FDC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17AFDC, $4A

; compressed tileset of map $59 (the first map record using it)
; LZSS-compressed asset: 1160 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map59Tileset:: ; heuristic: map tileset stream; C0
Data_05E_7026:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17B026, $57

Data_05E_707D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17B07D, $F5

Data_05E_7172:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17B172, $2DF

Data_05E_7451:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17B451, $5D

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map59Palettes::
Data_05E_74AE:: ; heuristic: map BG palettes; C0
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $1528, $7FFF, $6B2B, $0020 ; entry 3
    dw $1415, $3F7F, $01DA, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map59Screens0::
Data_05E_74EE:: ; heuristic: map screen array; C0
    dfar Data_05E_74FA ; entry 0
    dfar Data_05E_7587 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map59Attrs0::
Data_05E_74F4:: ; heuristic: map screen array; C0
    dfar Data_05E_7616 ; entry 0
    dfar Data_05E_764D ; entry 1

; LZSS-compressed asset: 141 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_74FA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17B4FA, $8D

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_7587:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17B587, $8F

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_7616:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $1F, $05, $05, $02, $02, $00, $00, $01, $34, $00
    db $01, $28, $0F, $0B, $02, $02, $01, $48, $0F, $17, $01, $5A, $02, $01, $78, $0F
    db $13, $01, $38, $08, $01, $AA, $0F, $09, $01, $76, $0F, $29, $01, $76, $0F, $21
    db $01, $54, $04, $01, $3E, $1F, $03

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_764D:: ; heuristic: map screen stream; C0
    db $68, $01, $05, $05, $FF, $FF, $17, $01, $01, $04, $04, $05, $2A, $02, $05, $FF
    db $F6, $03, $03, $04, $04, $05, $3E, $02, $05, $34, $0F, $0B, $05, $2A, $0F, $01
    db $04, $05, $7A, $05, $05, $70, $0F, $09, $02, $02, $05, $8E, $0F, $13, $05, $78
    db $0F, $15, $05, $28, $0F, $3F, $05, $41, $1F, $13

; compressed tileset of map $5F (the first map record using it)
; LZSS-compressed asset: 664 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map5FTileset:: ; heuristic: map tileset stream; C0
Data_05E_7687:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17B687, $1F1

Data_05E_7878:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $17B878, $A7

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map5FPalettes::
Data_05E_791F:: ; heuristic: map BG palettes; C0
    dw $218C, $7FFF, $5AB1, $0000 ; entry 0
    dw $012F, $67FF, $01DA, $0000 ; entry 1
    dw $012F, $3F7F, $029A, $0000 ; entry 2
    dw $1528, $7FFF, $6B2B, $0020 ; entry 3
    dw $126A, $3F7F, $02FF, $0000 ; entry 4
    dw $1415, $3F7F, $01DA, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5FScreens0::
Data_05E_795F:: ; heuristic: map screen array; C0
    dfar Data_05E_7965 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map5FAttrs0::
Data_05E_7962:: ; heuristic: map screen array; C0
    dfar Data_05E_7A27 ; entry 0

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_7965:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17B965, $C2

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_7A27:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17BA27, $4A

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map61Screens0::
Data_05E_7A71:: ; heuristic: map screen array; C0
    dfar Data_05E_7A7D ; entry 0
    dfar Data_05E_7B8C ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map61Attrs0::
Data_05E_7A77:: ; heuristic: map screen array; C0
    dfar Data_05E_7C6F ; entry 0
    dfar Data_05E_7CBE ; entry 1

; LZSS-compressed asset: 271 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_7A7D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17BA7D, $10F

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_7B8C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17BB8C, $E3

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_7C6F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17BC6F, $4F

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05E_7CBE:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $F4, $04, $04, $04, $04, $02, $F8, $FF, $39, $02, $57
    db $0F, $4D, $02, $EC, $FF, $0D, $02, $0A, $0C, $02, $D4, $08, $01, $01, $02, $02
    db $06, $06, $06, $02, $EE, $0F, $07, $02, $CC, $0F, $15, $02, $43, $1F, $11
    ds $291, $00

Data_05E_7F7E:: ; heuristic: target of a monotone pointer table; C0
    ds $82, $00
