SECTION "Bank 68", ROMX[$4000], BANK[$68]
    INCBIN "dwm2-cobi-us.gbc", $1A0000, $8B7
    dw Data_068_655F
    db $B3, $42, $62, $65
    dw Data_068_656D
    db $59, $48, $66, $17
    dw Data_068_6649
    db $8E, $47, $66, $7D
    dw Data_068_664D
    db $C8, $5C, $66, $C8
    dw Data_068_665C
    db $C8, $5C, $66, $C8
    dw Data_068_665C
    db $C8, $5C, $66, $C8
    dw Data_068_665C
    db $C8, $5C, $66, $C8
    dw Data_068_665C
    db $4A, $74, $62, $91
    dw Data_068_6563
    db $67, $49, $62, $90
    dw Data_068_6572
    db $04, $4C, $66, $37
    dw Data_068_664C
    db $C0, $4B, $66, $C5
    dw Data_068_6652
    db $5D, $61, $66, $5D
    dw Data_068_6661
    db $5D, $61, $66, $5D
    dw Data_068_6661
    db $5D, $61, $66, $5D
    dw Data_068_6661
    db $5D, $61, $66, $5D
    dw Data_068_6661
    INCBIN "dwm2-cobi-us.gbc", $1A0913, $514
    dw Data_068_6243
    db $2E
    dw Data_068_6266
    db $34
    dw Data_068_645A
    db $D4
    dw Data_068_645A
    db $BD
    dw Data_068_6543
    db $EA
    dw Data_068_656A
    db $11
    dw Data_068_657B
    db $5D
    dw Data_068_6661
    db $5A, $5B, $66, $2F, $49, $62, $34, $73, $65, $0F, $5B, $66, $91, $63, $65, $43
    db $46, $65, $09, $74, $62, $4B, $63, $65, $AA
    dw Data_068_6249
    db $E8
    dw Data_068_626A
    db $47
    dw Data_068_645E
    db $8E
    dw Data_068_645E
    db $0B
    dw Data_068_6547
    db $CA
    dw Data_068_6564
    db $46
    dw Data_068_6565
    db $46
    dw Data_068_6565
    db $ED
    dw Data_068_6576
    INCBIN "dwm2-cobi-us.gbc", $1A0E71, $E17
    dw Data_068_6479
    db $35
    dw Data_068_6646
    db $C8
    dw Data_068_665C
    db $C8
    dw Data_068_665C
    db $C8
    dw Data_068_665C
    db $C8
    dw Data_068_665C
    db $5D
    dw Data_068_6661
    db $5D
    dw Data_068_6661
    INCBIN "dwm2-cobi-us.gbc", $1A1C9F, $5A4

Data_068_6243:: ; heuristic: target of a monotone pointer table; C0
    db $4E, $66, $5D, $61, $66, $00

Data_068_6249:: ; heuristic: target of a monotone pointer table; C0
    db $7F, $64, $F3, $71, $63, $64, $6D, $64, $5D, $61, $66, $5D, $61, $66, $96, $7B
    db $62, $A7, $73, $62, $5D, $61, $66, $5D, $61, $66, $25, $7C, $62

Data_068_6266:: ; heuristic: target of a monotone pointer table; C0
    db $28, $6D, $64, $5D

Data_068_626A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A226A, $1F0

Data_068_645A:: ; heuristic: target of a monotone pointer table; C0
    db $62, $AA, $7A, $65

Data_068_645E:: ; heuristic: target of a monotone pointer table; C0
    db $48, $78, $64, $0B, $6D, $63, $8E, $52, $62, $D0, $57, $65, $C8, $5C, $66, $D4
    db $5D, $65, $A7, $46, $64, $37, $54, $63, $B0, $75, $62

Data_068_6479:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A2479, $CA

Data_068_6543:: ; heuristic: target of a monotone pointer table; C0
    db $5B, $65, $11, $63

Data_068_6547:: ; heuristic: target of a monotone pointer table; C0
    db $64, $8C, $46, $63, $70, $6F, $65, $11, $6A, $63, $19, $57, $64, $28, $6D, $64
    db $11, $53, $66, $CF, $63, $63, $42, $57

Data_068_655F:: ; heuristic: target of a monotone pointer table; C0
    db $64, $A7, $73, $62

Data_068_6563:: ; heuristic: target of a monotone pointer table; C0
    db $AA

Data_068_6564:: ; heuristic: target of a monotone pointer table; C0
    db $7A

Data_068_6565:: ; heuristic: target of a monotone pointer table; C0
    db $65, $F8, $5A, $65, $2D

Data_068_656A:: ; heuristic: target of a monotone pointer table; C0
    db $6C, $62, $62

Data_068_656D:: ; heuristic: target of a monotone pointer table; C0
    db $46, $65, $B2, $72, $65

Data_068_6572:: ; heuristic: target of a monotone pointer table; C0
    db $BD, $5B, $65, $BC

Data_068_6576:: ; heuristic: target of a monotone pointer table; C0
    db $65, $64, $F5, $4A, $63

Data_068_657B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A257B, $CB

Data_068_6646:: ; heuristic: target of a monotone pointer table; C0
    db $65, $BD, $70

Data_068_6649:: ; heuristic: target of a monotone pointer table; C0
    db $65, $44, $67

Data_068_664C:: ; heuristic: target of a monotone pointer table; C0
    db $63

Data_068_664D:: ; heuristic: target of a monotone pointer table; C0
    db $72, $62, $64, $8C, $46

Data_068_6652:: ; heuristic: target of a monotone pointer table; C0
    db $63, $23, $70, $65, $43, $48, $64, $67, $48, $63

Data_068_665C:: ; heuristic: target of a monotone pointer table; C0
    db $28, $68, $64, $E4, $4D

Data_068_6661:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1A2661, $718

; compressed tileset of map $A2 (the first map record using it)
; LZSS-compressed asset: 1435 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapA2Tileset:: ; heuristic: map tileset stream; C0
Data_068_6D79:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A2D79, $59B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapA2Palettes::
Data_068_7314:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $05A4, $53DE, $0E29, $0084 ; entry 1
    dw $386C, $53DE, $4593, $0000 ; entry 2
    dw $012F, $035F, $01DA, $0000 ; entry 3
    dw $0160, $5AB1, $4A2D, $0000 ; entry 4
    dw $0152, $53DE, $025C, $0008 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA2Screens0::
Data_068_7354:: ; heuristic: map screen array; C0
    dfar Data_068_739C ; entry 0
    dfar Data_068_7492 ; entry 1
    dfar Data_068_758A ; entry 2
    dfar Data_068_7682 ; entry 3
    dfar Data_068_772C ; entry 4
    dfar Data_068_7814 ; entry 5
    dfar Data_068_78B7 ; entry 6
    dfar Data_068_7977 ; entry 7
    dfar Data_068_7A5A ; entry 8
    dfar Data_068_7B1C ; entry 9
    dfar Data_068_7B30 ; entry 10
    dfar Data_068_7B85 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapA2Attrs0::
Data_068_7378:: ; heuristic: map screen array; C0
    dfar Data_068_7B99 ; entry 0
    dfar Data_068_7BD8 ; entry 1
    dfar Data_068_7C15 ; entry 2
    dfar Data_068_7C4F ; entry 3
    dfar Data_068_7C7D ; entry 4
    dfar Data_068_7CB0 ; entry 5
    dfar Data_068_7CDC ; entry 6
    dfar Data_068_7D14 ; entry 7
    dfar Data_068_7D49 ; entry 8
    dfar Data_068_7D7E ; entry 9
    dfar Data_068_7D91 ; entry 10
    dfar Data_068_7DAB ; entry 11

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_739C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A339C, $F6

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7492:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3492, $F8

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_758A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A358A, $F8

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7682:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3682, $AA

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_772C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A372C, $E8

; LZSS-compressed asset: 163 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7814:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3814, $A3

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_78B7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A38B7, $C0

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7977:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3977, $E3

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7A5A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3A5A, $C2

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7B1C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7B30:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3B30, $55

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7B85:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7B99:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $04, $02, $00, $02, $0D, $04, $00, $00, $0F, $00, $04, $00
    db $14, $0F, $00, $00, $28, $0F, $2B, $01, $01, $02, $02, $01, $01, $00, $7A, $08
    db $00, $78, $0F, $05, $00, $A2, $0C, $00, $A0, $0F, $2B, $00, $A0, $08, $00, $28
    db $00, $00, $FE, $02, $00, $F4, $0F, $09, $00, $FE, $06, $00, $1A, $1F, $27

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7BD8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $01, $00, $4E, $01, $00, $57, $01, $00
    db $4E, $07, $00, $55, $04, $00, $66, $02, $00, $64, $02, $00, $68, $08, $00, $55
    db $02, $00, $7A, $0F, $01, $00, $66, $0C, $00, $9E, $0F, $07, $00, $C4, $0F, $11
    db $04, $04, $00, $E0, $0E, $00, $F0, $0F, $03, $00, $16, $1F, $3B

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7C15:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0D, $04, $04, $00, $01, $0F, $00, $00, $13, $0D
    db $04, $00, $25, $0F, $2C, $01, $01, $02, $02, $01, $01, $00, $78, $08, $00, $76
    db $0F, $05, $00, $A0, $0C, $00, $9E, $0F, $2B, $00, $EE, $02, $00, $E4, $0E, $00
    db $F4, $0F, $03, $00, $9E, $06, $00, $14, $1F, $2D

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7C4F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $03, $00, $00, $00, $00, $0C
    db $04, $00, $04, $0E, $00, $04, $04, $00, $1E, $0F, $3F, $00, $04, $06, $00, $7A
    db $0F, $33, $00, $20, $0F, $33, $00, $02, $0F, $15, $00, $02, $0F, $13

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7C7D:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $0F, $18, $01, $00, $2C, $07, $00, $24, $0F, $07
    db $00, $2C, $08, $00, $34, $04, $00, $52, $0E, $00, $52, $0C, $00, $78, $0F, $2D
    db $00, $50, $0F, $15, $00, $28, $0F, $17, $00, $28, $08, $00, $20, $0F, $01, $00
    db $26, $1F, $1B

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7CB0:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $03, $01, $00, $08, $03, $00, $00, $04, $00, $04
    db $0F, $0D, $00, $0E, $08, $00, $30, $0F, $21, $00, $30, $06, $00, $6E, $0F, $33
    db $00, $28, $0F, $3D, $00, $00, $0F, $25, $00, $10, $0F, $05

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7CDC:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $03, $00, $00, $00, $00, $0C
    db $04, $00, $04, $0F, $09, $00, $0A, $08, $00, $2C, $0F, $0B, $00, $06, $06, $00
    db $54, $0F, $29, $00, $52, $0C, $00, $A0, $0F, $07, $00, $52, $0A, $00, $C8, $0F
    db $09, $00, $F7, $0F, $4D, $00, $08, $1C

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7D14:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $01, $01, $00, $06, $03, $00, $00, $02, $00, $00
    db $0F, $05, $00, $06, $04, $00, $0A, $08, $00, $2C, $0C, $00, $2C, $08, $00, $5B
    db $0F, $4D, $00, $90, $0F, $21, $00, $4E, $0E, $00, $4C, $0F, $01, $00, $26, $0F
    db $17, $00, $28, $0F, $15

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7D49:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $04, $00, $00, $03, $01, $00, $08, $03, $00, $00, $04, $00, $04
    db $0F, $03, $00, $08, $04, $00, $22, $0F, $07, $00, $2E, $06, $00, $46, $0F, $41
    db $00, $28, $0C, $00, $AA, $0F, $03, $00, $26, $0E, $00, $0E, $0A, $00, $F3, $0F
    db $4D, $00, $08, $1F, $01

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7D7E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 26 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7D91:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $02, $FF, $F0, $01, $02, $04, $07, $02, $FC, $FF, $4D, $02, $5C
    db $0F, $4D, $02, $BC, $0F, $4D, $02, $08, $1F, $25

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_068_7DAB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A3DAB, $150
    ds $105, $00
